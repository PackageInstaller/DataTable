return {
	Play102601001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 102601001
		arg_1_1.duration_ = 10

		local var_1_0 = {
			ja = 10,
			ko = 7.5,
			zh = 6.3,
			en = 6.566
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
				arg_1_0:Play102601002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.ST04a == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST04a")
				var_4_0.name = "ST04a"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.ST04a = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.ST04a

				arg_1_1.bgs_.ST04a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "ST04a" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_4 = arg_1_1.bgs_.ST04a:GetComponent("SpriteRenderer")

				if var_4_4 then
					arg_1_1.var_.alphaOldValueST04a = var_4_4.color.a
					arg_1_1.var_.alphaMatValueST04a = var_4_4
				end

				arg_1_1.var_.alphaOldValueST04a = 0
			end

			local var_4_5 = 1.5

			if 0 <= arg_1_1.time_ and arg_1_1.time_ < 0 + var_4_5 then
				if arg_1_1.var_.alphaMatValueST04a then
					arg_1_1.var_.alphaMatValueST04a.color.a = Mathf.Lerp(arg_1_1.var_.alphaOldValueST04a, 1, (arg_1_1.time_ - 0) / var_4_5)
					arg_1_1.var_.alphaMatValueST04a.color = arg_1_1.var_.alphaMatValueST04a.color
				end
			end

			if arg_1_1.time_ >= 0 + var_4_5 and arg_1_1.time_ < 0 + var_4_5 + arg_4_0 and arg_1_1.var_.alphaMatValueST04a then
				arg_1_1.var_.alphaMatValueST04a.color.a = 1
				arg_1_1.var_.alphaMatValueST04a.color = arg_1_1.var_.alphaMatValueST04a.color
			end

			local var_4_6 = "1019ui_story"

			if arg_1_1.actors_["1019ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1019ui_story"))) then
				local var_4_7 = Object.Instantiate(Asset.Load("Char/" .. "1019ui_story"), arg_1_1.stage_.transform)

				var_4_7.name = var_4_6
				var_4_7.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.actors_[var_4_6] = var_4_7

				local var_4_8 = var_4_7:GetComponentInChildren(typeof(CharacterEffect))

				var_4_8.enabled = true

				local var_4_9 = GameObjectTools.GetOrAddComponent(var_4_7, typeof(DynamicBoneHelper))

				if var_4_9 then
					var_4_9:EnableDynamicBone(false)
				end

				arg_1_1:ShowWeapon(var_4_8.transform, false)

				arg_1_1.var_[var_4_6 .. "Animator"] = var_4_8.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_1_1.var_[var_4_6 .. "Animator"].applyRootMotion = true
				arg_1_1.var_[var_4_6 .. "LipSync"] = var_4_8.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_4_10 = arg_1_1.actors_["1019ui_story"].transform

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				arg_1_1.var_.moveOldPos1019ui_story = var_4_10.localPosition
			end

			local var_4_11 = 0.001

			if 1.8 <= arg_1_1.time_ and arg_1_1.time_ < 1.8 + var_4_11 then
				var_4_10.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1019ui_story, Vector3.New(-0.2, -1.08, -5.9), (arg_1_1.time_ - 1.8) / var_4_11)
				var_4_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_10.position).x, (manager.ui.mainCamera.transform.position - var_4_10.position).y, (manager.ui.mainCamera.transform.position - var_4_10.position).z)
				var_4_10.localEulerAngles.z = 0
				var_4_10.localEulerAngles.x = 0
				var_4_10.localEulerAngles = var_4_10.localEulerAngles
			end

			if arg_1_1.time_ >= 1.8 + var_4_11 and arg_1_1.time_ < 1.8 + var_4_11 + arg_4_0 then
				var_4_10.localPosition = Vector3.New(-0.2, -1.08, -5.9)
				var_4_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_10.position).x, (manager.ui.mainCamera.transform.position - var_4_10.position).y, (manager.ui.mainCamera.transform.position - var_4_10.position).z)
				var_4_10.localEulerAngles.z = 0
				var_4_10.localEulerAngles.x = 0
				var_4_10.localEulerAngles = var_4_10.localEulerAngles
			end

			local var_4_12 = arg_1_1.actors_["1019ui_story"]

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 and not isNil(var_4_12) and arg_1_1.var_.characterEffect1019ui_story == nil then
				arg_1_1.var_.characterEffect1019ui_story = var_4_12:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_13 = 0.2

			if 1.8 <= arg_1_1.time_ and arg_1_1.time_ < 1.8 + var_4_13 and not isNil(var_4_12) then
				if arg_1_1.var_.characterEffect1019ui_story and not isNil(var_4_12) then
					arg_1_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= 1.8 + var_4_13 and arg_1_1.time_ < 1.8 + var_4_13 + arg_4_0 and not isNil(var_4_12) and arg_1_1.var_.characterEffect1019ui_story then
				arg_1_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				arg_1_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action1_1")
			end

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				arg_1_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_4_15 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_15 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			if arg_1_1.time_ >= var_4_15 + 2 and arg_1_1.time_ < var_4_15 + 2 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_18 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_18 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_18

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_18
						arg_1_1.bgmTxt2_.text = var_4_18
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
				arg_1_1:AudioAction("play", "music", "bgm_side_daily03", "bgm_side_daily03", "bgm_side_daily03.awb")

				local var_4_21 = manager.audio:GetAudioName("bgm_side_daily03", "bgm_side_daily03")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_21 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_21

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_21
						arg_1_1.bgmTxt2_.text = var_4_21
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

			local var_4_22 = 2
			local var_4_23 = 0.625

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_22 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_24 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_24:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_24:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_24:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_25 = arg_1_1:GetWordFromCfg(102601001)
				local var_4_26 = arg_1_1:FormatText(var_4_25.content)

				arg_1_1.text_.text = var_4_26

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_28 = 25 <= 0 and var_4_23 or var_4_23 * (utf8.len(var_4_26) / 25)

				if (25 <= 0 and var_4_23 or var_4_23 * (utf8.len(var_4_26) / 25)) > 0 and var_4_23 < var_4_28 then
					arg_1_1.talkMaxDuration = var_4_28
					var_4_22 = var_4_22 + 0.3

					if var_4_28 + var_4_22 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_28 + var_4_22
					end
				end

				arg_1_1.text_.text = var_4_26
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_102601", "102601001", "story_v_side_old_102601.awb") ~= 0 then
					local var_4_29 = manager.audio:GetVoiceLength("story_v_side_old_102601", "102601001", "story_v_side_old_102601.awb") / 1000

					if var_4_29 + var_4_22 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_29 + var_4_22
					end

					if var_4_25.prefab_name ~= "" and arg_1_1.actors_[var_4_25.prefab_name] ~= nil then
						local var_4_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_25.prefab_name].transform, "story_v_side_old_102601", "102601001", "story_v_side_old_102601.awb")

						arg_1_1:RecordAudio("102601001", var_4_30)
						arg_1_1:RecordAudio("102601001", var_4_30)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_side_old_102601", "102601001", "story_v_side_old_102601.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_side_old_102601", "102601001", "story_v_side_old_102601.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_31 = var_4_22 + 0.3
			local var_4_32 = math.max(var_4_23, arg_1_1.talkMaxDuration)

			if var_4_22 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_31 + var_4_32 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_31) / var_4_32

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_31 + var_4_32 and arg_1_1.time_ < var_4_31 + var_4_32 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
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
	Play102601002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 102601002
		arg_9_1.duration_ = 8.4

		local var_9_0 = {
			ja = 8.4,
			ko = 5.7,
			zh = 7,
			en = 6.4
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
				arg_9_0:Play102601003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action2_1")
			end

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_12_0 = 0
			local var_12_1 = 0.725

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_0 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				arg_9_1.leftNameTxt_.text = arg_9_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_2 = arg_9_1:GetWordFromCfg(102601002)
				local var_12_3 = arg_9_1:FormatText(var_12_2.content)

				arg_9_1.text_.text = var_12_3

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_5 = 29 <= 0 and var_12_1 or var_12_1 * (utf8.len(var_12_3) / 29)

				if (29 <= 0 and var_12_1 or var_12_1 * (utf8.len(var_12_3) / 29)) > 0 and var_12_1 < var_12_5 then
					arg_9_1.talkMaxDuration = var_12_5

					if var_12_5 + var_12_0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_5 + var_12_0
					end
				end

				arg_9_1.text_.text = var_12_3
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_102601", "102601002", "story_v_side_old_102601.awb") ~= 0 then
					local var_12_6 = manager.audio:GetVoiceLength("story_v_side_old_102601", "102601002", "story_v_side_old_102601.awb") / 1000

					if var_12_6 + var_12_0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_6 + var_12_0
					end

					if var_12_2.prefab_name ~= "" and arg_9_1.actors_[var_12_2.prefab_name] ~= nil then
						local var_12_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_2.prefab_name].transform, "story_v_side_old_102601", "102601002", "story_v_side_old_102601.awb")

						arg_9_1:RecordAudio("102601002", var_12_7)
						arg_9_1:RecordAudio("102601002", var_12_7)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_side_old_102601", "102601002", "story_v_side_old_102601.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_side_old_102601", "102601002", "story_v_side_old_102601.awb")
				end

				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_8 = math.max(var_12_1, arg_9_1.talkMaxDuration)

			if var_12_0 <= arg_9_1.time_ and arg_9_1.time_ < var_12_0 + var_12_8 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_0) / var_12_8

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_0 + var_12_8 and arg_9_1.time_ < var_12_0 + var_12_8 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {}

		arg_9_1:InitPlayNodeList()
	end,
	Play102601003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 102601003
		arg_13_1.duration_ = 7.2

		local var_13_0 = {
			ja = 7.2,
			ko = 4.766,
			zh = 4.5,
			en = 5.7
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
				arg_13_0:Play102601004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_16_0 = 0
			local var_16_1 = 0.6

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_0 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_2 = arg_13_1:GetWordFromCfg(102601003)
				local var_16_3 = arg_13_1:FormatText(var_16_2.content)

				arg_13_1.text_.text = var_16_3

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_5 = 24 <= 0 and var_16_1 or var_16_1 * (utf8.len(var_16_3) / 24)

				if (24 <= 0 and var_16_1 or var_16_1 * (utf8.len(var_16_3) / 24)) > 0 and var_16_1 < var_16_5 then
					arg_13_1.talkMaxDuration = var_16_5

					if var_16_5 + var_16_0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_5 + var_16_0
					end
				end

				arg_13_1.text_.text = var_16_3
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_102601", "102601003", "story_v_side_old_102601.awb") ~= 0 then
					local var_16_6 = manager.audio:GetVoiceLength("story_v_side_old_102601", "102601003", "story_v_side_old_102601.awb") / 1000

					if var_16_6 + var_16_0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_6 + var_16_0
					end

					if var_16_2.prefab_name ~= "" and arg_13_1.actors_[var_16_2.prefab_name] ~= nil then
						local var_16_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_2.prefab_name].transform, "story_v_side_old_102601", "102601003", "story_v_side_old_102601.awb")

						arg_13_1:RecordAudio("102601003", var_16_7)
						arg_13_1:RecordAudio("102601003", var_16_7)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_side_old_102601", "102601003", "story_v_side_old_102601.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_side_old_102601", "102601003", "story_v_side_old_102601.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_8 = math.max(var_16_1, arg_13_1.talkMaxDuration)

			if var_16_0 <= arg_13_1.time_ and arg_13_1.time_ < var_16_0 + var_16_8 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_0) / var_16_8

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_0 + var_16_8 and arg_13_1.time_ < var_16_0 + var_16_8 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play102601004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 102601004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play102601005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.var_.moveOldPos1019ui_story = arg_17_1.actors_["1019ui_story"].transform.localPosition
			end

			local var_20_0 = 0.001

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_0 then
				arg_17_1.actors_["1019ui_story"].transform.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1019ui_story, Vector3.New(0, 100, 0), (arg_17_1.time_ - 0) / var_20_0)
				arg_17_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_17_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["1019ui_story"].transform.position).z)
				arg_17_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_17_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_17_1.actors_["1019ui_story"].transform.localEulerAngles = arg_17_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			if arg_17_1.time_ >= 0 + var_20_0 and arg_17_1.time_ < 0 + var_20_0 + arg_20_0 then
				arg_17_1.actors_["1019ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_17_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_17_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["1019ui_story"].transform.position).z)
				arg_17_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_17_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_17_1.actors_["1019ui_story"].transform.localEulerAngles = arg_17_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			local var_20_1 = 0
			local var_20_2 = 1.15

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_1 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, false)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_3 = arg_17_1:FormatText(arg_17_1:GetWordFromCfg(102601004).content)

				arg_17_1.text_.text = var_20_3

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_5 = 46 <= 0 and var_20_2 or var_20_2 * (utf8.len(var_20_3) / 46)

				if (46 <= 0 and var_20_2 or var_20_2 * (utf8.len(var_20_3) / 46)) > 0 and var_20_2 < var_20_5 then
					arg_17_1.talkMaxDuration = var_20_5

					if var_20_5 + var_20_1 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_5 + var_20_1
					end
				end

				arg_17_1.text_.text = var_20_3
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)
				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_6 = math.max(var_20_2, arg_17_1.talkMaxDuration)

			if var_20_1 <= arg_17_1.time_ and arg_17_1.time_ < var_20_1 + var_20_6 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_1) / var_20_6

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_1 + var_20_6 and arg_17_1.time_ < var_20_1 + var_20_6 + arg_20_0 then
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
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_17_1:InitPlayNodeList()
	end,
	Play102601005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 102601005
		arg_21_1.duration_ = 5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play102601006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = 0.525

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, false)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_1 = arg_21_1:FormatText(arg_21_1:GetWordFromCfg(102601005).content)

				arg_21_1.text_.text = var_24_1

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_3 = 21 <= 0 and var_24_0 or var_24_0 * (utf8.len(var_24_1) / 21)

				if (21 <= 0 and var_24_0 or var_24_0 * (utf8.len(var_24_1) / 21)) > 0 and var_24_0 < var_24_3 then
					arg_21_1.talkMaxDuration = var_24_3

					if var_24_3 + 0 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_3 + 0
					end
				end

				arg_21_1.text_.text = var_24_1
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)
				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_4 = math.max(var_24_0, arg_21_1.talkMaxDuration)

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_4 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - 0) / var_24_4

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= 0 + var_24_4 and arg_21_1.time_ < 0 + var_24_4 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play102601006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 102601006
		arg_25_1.duration_ = 5

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play102601007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = 0.475

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, false)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_1 = arg_25_1:FormatText(arg_25_1:GetWordFromCfg(102601006).content)

				arg_25_1.text_.text = var_28_1

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_3 = 19 <= 0 and var_28_0 or var_28_0 * (utf8.len(var_28_1) / 19)

				if (19 <= 0 and var_28_0 or var_28_0 * (utf8.len(var_28_1) / 19)) > 0 and var_28_0 < var_28_3 then
					arg_25_1.talkMaxDuration = var_28_3

					if var_28_3 + 0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_3 + 0
					end
				end

				arg_25_1.text_.text = var_28_1
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)
				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_4 = math.max(var_28_0, arg_25_1.talkMaxDuration)

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_4 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - 0) / var_28_4

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= 0 + var_28_4 and arg_25_1.time_ < 0 + var_28_4 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play102601007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 102601007
		arg_29_1.duration_ = 7.65

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play102601008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if arg_29_1.bgs_.ST04b == nil then
				local var_32_0 = Object.Instantiate(arg_29_1.paintGo_)

				var_32_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST04b")
				var_32_0.name = "ST04b"
				var_32_0.transform.parent = arg_29_1.stage_.transform
				var_32_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_29_1.bgs_.ST04b = var_32_0
			end

			if 1.5 < arg_29_1.time_ and arg_29_1.time_ <= 1.5 + arg_32_0 then
				local var_32_1 = arg_29_1.bgs_.ST04b

				arg_29_1.bgs_.ST04b.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_32_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_32_2 = var_32_1:GetComponent("SpriteRenderer")

				if var_32_2 and var_32_2.sprite then
					local var_32_3 = 2 * (var_32_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_32_1.transform.localScale = Vector3.New(var_32_3 / var_32_2.sprite.bounds.size.y < var_32_3 * manager.ui.mainCameraCom_.aspect / var_32_2.sprite.bounds.size.x and var_32_3 * manager.ui.mainCameraCom_.aspect / var_32_2.sprite.bounds.size.x or var_32_3 / var_32_2.sprite.bounds.size.y, var_32_3 / var_32_2.sprite.bounds.size.y < var_32_3 * manager.ui.mainCameraCom_.aspect / var_32_2.sprite.bounds.size.x and var_32_3 * manager.ui.mainCameraCom_.aspect / var_32_2.sprite.bounds.size.x or var_32_3 / var_32_2.sprite.bounds.size.y, 0)
				end

				for iter_32_0, iter_32_1 in pairs(arg_29_1.bgs_) do
					if iter_32_0 ~= "ST04b" then
						iter_32_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				local var_32_4 = arg_29_1.bgs_.ST04a:GetComponent("SpriteRenderer")

				if var_32_4 then
					arg_29_1.var_.alphaOldValueST04a = var_32_4.color.a
					arg_29_1.var_.alphaMatValueST04a = var_32_4
				end

				arg_29_1.var_.alphaOldValueST04a = 1
			end

			local var_32_5 = 1.5

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_5 then
				if arg_29_1.var_.alphaMatValueST04a then
					arg_29_1.var_.alphaMatValueST04a.color.a = Mathf.Lerp(arg_29_1.var_.alphaOldValueST04a, 0, (arg_29_1.time_ - 0) / var_32_5)
					arg_29_1.var_.alphaMatValueST04a.color = arg_29_1.var_.alphaMatValueST04a.color
				end
			end

			if arg_29_1.time_ >= 0 + var_32_5 and arg_29_1.time_ < 0 + var_32_5 + arg_32_0 and arg_29_1.var_.alphaMatValueST04a then
				arg_29_1.var_.alphaMatValueST04a.color.a = 0
				arg_29_1.var_.alphaMatValueST04a.color = arg_29_1.var_.alphaMatValueST04a.color
			end

			if 1.5 < arg_29_1.time_ and arg_29_1.time_ <= 1.5 + arg_32_0 then
				local var_32_6 = arg_29_1.bgs_.ST04b:GetComponent("SpriteRenderer")

				if var_32_6 then
					arg_29_1.var_.alphaOldValueST04b = var_32_6.color.a
					arg_29_1.var_.alphaMatValueST04b = var_32_6
				end

				arg_29_1.var_.alphaOldValueST04b = 0
			end

			local var_32_7 = 1.5

			if 1.5 <= arg_29_1.time_ and arg_29_1.time_ < 1.5 + var_32_7 then
				if arg_29_1.var_.alphaMatValueST04b then
					arg_29_1.var_.alphaMatValueST04b.color.a = Mathf.Lerp(arg_29_1.var_.alphaOldValueST04b, 1, (arg_29_1.time_ - 1.5) / var_32_7)
					arg_29_1.var_.alphaMatValueST04b.color = arg_29_1.var_.alphaMatValueST04b.color
				end
			end

			if arg_29_1.time_ >= 1.5 + var_32_7 and arg_29_1.time_ < 1.5 + var_32_7 + arg_32_0 and arg_29_1.var_.alphaMatValueST04b then
				arg_29_1.var_.alphaMatValueST04b.color.a = 1
				arg_29_1.var_.alphaMatValueST04b.color = arg_29_1.var_.alphaMatValueST04b.color
			end

			local var_32_8 = 0

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_8 + arg_32_0 then
				arg_29_1.allBtn_.enabled = false
			end

			if arg_29_1.time_ >= var_32_8 + 2.65 and arg_29_1.time_ < var_32_8 + 2.65 + arg_32_0 then
				arg_29_1.allBtn_.enabled = true
			end

			if arg_29_1.frameCnt_ <= 1 then
				arg_29_1.dialog_:SetActive(false)
			end

			local var_32_9 = 2.65
			local var_32_10 = 0.35

			if 2.65 < arg_29_1.time_ and arg_29_1.time_ <= var_32_9 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0

				arg_29_1.dialog_:SetActive(true)

				arg_29_1.dialogCg_.alpha = 0

				local var_32_11 = LeanTween.value(arg_29_1.dialog_, 0, 1, 0.3)

				var_32_11:setOnUpdate(LuaHelper.FloatAction(function(arg_33_0)
					arg_29_1.dialogCg_.alpha = arg_33_0
				end))
				var_32_11:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_29_1.dialog_)
					var_32_11:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_29_1.duration_ = arg_29_1.duration_ + 0.3

				SetActive(arg_29_1.leftNameGo_, false)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_12 = arg_29_1:FormatText(arg_29_1:GetWordFromCfg(102601007).content)

				arg_29_1.text_.text = var_32_12

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_14 = 14 <= 0 and var_32_10 or var_32_10 * (utf8.len(var_32_12) / 14)

				if (14 <= 0 and var_32_10 or var_32_10 * (utf8.len(var_32_12) / 14)) > 0 and var_32_10 < var_32_14 then
					arg_29_1.talkMaxDuration = var_32_14
					var_32_9 = var_32_9 + 0.3

					if var_32_14 + var_32_9 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_14 + var_32_9
					end
				end

				arg_29_1.text_.text = var_32_12
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)
				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_15 = var_32_9 + 0.3
			local var_32_16 = math.max(var_32_10, arg_29_1.talkMaxDuration)

			if var_32_9 + 0.3 <= arg_29_1.time_ and arg_29_1.time_ < var_32_15 + var_32_16 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_15) / var_32_16

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_15 + var_32_16 and arg_29_1.time_ < var_32_15 + var_32_16 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play102601008 = function(arg_35_0, arg_35_1)
		arg_35_1.time_ = 0
		arg_35_1.frameCnt_ = 0
		arg_35_1.state_ = "playing"
		arg_35_1.curTalkId_ = 102601008
		arg_35_1.duration_ = 2.2

		local var_35_0 = {
			ja = 1.999999999999,
			ko = 2.1,
			zh = 1.999999999999,
			en = 2.2
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
				arg_35_0:Play102601009(arg_35_1)
			end
		end

		function arg_35_1.onSingleLineUpdate_(arg_38_0)
			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 then
				arg_35_1.var_.moveOldPos1019ui_story = arg_35_1.actors_["1019ui_story"].transform.localPosition
			end

			local var_38_0 = 0.001

			if 0 <= arg_35_1.time_ and arg_35_1.time_ < 0 + var_38_0 then
				arg_35_1.actors_["1019ui_story"].transform.localPosition = Vector3.Lerp(arg_35_1.var_.moveOldPos1019ui_story, Vector3.New(-0.2, -1.08, -5.9), (arg_35_1.time_ - 0) / var_38_0)
				arg_35_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_35_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_35_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_35_1.actors_["1019ui_story"].transform.position).z)
				arg_35_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_35_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_35_1.actors_["1019ui_story"].transform.localEulerAngles = arg_35_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			if arg_35_1.time_ >= 0 + var_38_0 and arg_35_1.time_ < 0 + var_38_0 + arg_38_0 then
				arg_35_1.actors_["1019ui_story"].transform.localPosition = Vector3.New(-0.2, -1.08, -5.9)
				arg_35_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_35_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_35_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_35_1.actors_["1019ui_story"].transform.position).z)
				arg_35_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_35_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_35_1.actors_["1019ui_story"].transform.localEulerAngles = arg_35_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			local var_38_1 = arg_35_1.actors_["1019ui_story"]

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 and not isNil(var_38_1) and arg_35_1.var_.characterEffect1019ui_story == nil then
				arg_35_1.var_.characterEffect1019ui_story = var_38_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_38_2 = 0.2

			if 0 <= arg_35_1.time_ and arg_35_1.time_ < 0 + var_38_2 and not isNil(var_38_1) then
				if arg_35_1.var_.characterEffect1019ui_story and not isNil(var_38_1) then
					arg_35_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_35_1.time_ >= 0 + var_38_2 and arg_35_1.time_ < 0 + var_38_2 + arg_38_0 and not isNil(var_38_1) and arg_35_1.var_.characterEffect1019ui_story then
				arg_35_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 then
				arg_35_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action1_1")
			end

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 then
				arg_35_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_38_4 = 0
			local var_38_5 = 0.175

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= var_38_4 + arg_38_0 then
				arg_35_1.talkMaxDuration = 0
				arg_35_1.dialogCg_.alpha = 1

				arg_35_1.dialog_:SetActive(true)
				SetActive(arg_35_1.leftNameGo_, true)

				arg_35_1.leftNameTxt_.text = arg_35_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_35_1.leftNameTxt_.transform)

				arg_35_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_35_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_35_1:RecordName(arg_35_1.leftNameTxt_.text)
				SetActive(arg_35_1.iconTrs_.gameObject, false)
				arg_35_1.callingController_:SetSelectedState("normal")

				local var_38_6 = arg_35_1:GetWordFromCfg(102601008)
				local var_38_7 = arg_35_1:FormatText(var_38_6.content)

				arg_35_1.text_.text = var_38_7

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_9 = 7 <= 0 and var_38_5 or var_38_5 * (utf8.len(var_38_7) / 7)

				if (7 <= 0 and var_38_5 or var_38_5 * (utf8.len(var_38_7) / 7)) > 0 and var_38_5 < var_38_9 then
					arg_35_1.talkMaxDuration = var_38_9

					if var_38_9 + var_38_4 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_9 + var_38_4
					end
				end

				arg_35_1.text_.text = var_38_7
				arg_35_1.typewritter.percent = 0

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_102601", "102601008", "story_v_side_old_102601.awb") ~= 0 then
					local var_38_10 = manager.audio:GetVoiceLength("story_v_side_old_102601", "102601008", "story_v_side_old_102601.awb") / 1000

					if var_38_10 + var_38_4 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_10 + var_38_4
					end

					if var_38_6.prefab_name ~= "" and arg_35_1.actors_[var_38_6.prefab_name] ~= nil then
						local var_38_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_35_1.actors_[var_38_6.prefab_name].transform, "story_v_side_old_102601", "102601008", "story_v_side_old_102601.awb")

						arg_35_1:RecordAudio("102601008", var_38_11)
						arg_35_1:RecordAudio("102601008", var_38_11)
					else
						arg_35_1:AudioAction("play", "voice", "story_v_side_old_102601", "102601008", "story_v_side_old_102601.awb")
					end

					arg_35_1:RecordHistoryTalkVoice("story_v_side_old_102601", "102601008", "story_v_side_old_102601.awb")
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
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_35_1:InitPlayNodeList()
	end,
	Play102601009 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 102601009
		arg_39_1.duration_ = 5

		SetActive(arg_39_1.tipsGo_, false)

		function arg_39_1.onSingleLineFinish_()
			arg_39_1.onSingleLineUpdate_ = nil
			arg_39_1.onSingleLineFinish_ = nil
			arg_39_1.state_ = "waiting"
		end

		function arg_39_1.playNext_(arg_41_0)
			if arg_41_0 == 1 then
				arg_39_0:Play102601010(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 and not isNil(arg_39_1.actors_["1019ui_story"]) and arg_39_1.var_.characterEffect1019ui_story == nil then
				arg_39_1.var_.characterEffect1019ui_story = arg_39_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_42_0 = 0.2

			if 0 <= arg_39_1.time_ and arg_39_1.time_ < 0 + var_42_0 and not isNil(arg_39_1.actors_["1019ui_story"]) then
				if arg_39_1.var_.characterEffect1019ui_story and not isNil(arg_39_1.actors_["1019ui_story"]) then
					arg_39_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_39_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_39_1.time_ - 0) / var_42_0)
				end
			end

			if arg_39_1.time_ >= 0 + var_42_0 and arg_39_1.time_ < 0 + var_42_0 + arg_42_0 and not isNil(arg_39_1.actors_["1019ui_story"]) and arg_39_1.var_.characterEffect1019ui_story then
				arg_39_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_39_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_42_1 = 0
			local var_42_2 = 0.6

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

				local var_42_3 = arg_39_1:FormatText(arg_39_1:GetWordFromCfg(102601009).content)

				arg_39_1.text_.text = var_42_3

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_5 = 24 <= 0 and var_42_2 or var_42_2 * (utf8.len(var_42_3) / 24)

				if (24 <= 0 and var_42_2 or var_42_2 * (utf8.len(var_42_3) / 24)) > 0 and var_42_2 < var_42_5 then
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
	Play102601010 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 102601010
		arg_43_1.duration_ = 5

		SetActive(arg_43_1.tipsGo_, false)

		function arg_43_1.onSingleLineFinish_()
			arg_43_1.onSingleLineUpdate_ = nil
			arg_43_1.onSingleLineFinish_ = nil
			arg_43_1.state_ = "waiting"
		end

		function arg_43_1.playNext_(arg_45_0)
			if arg_45_0 == 1 then
				arg_43_0:Play102601011(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			local var_46_0 = 0.175

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

				local var_46_1 = arg_43_1:FormatText(arg_43_1:GetWordFromCfg(102601010).content)

				arg_43_1.text_.text = var_46_1

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_3 = 7 <= 0 and var_46_0 or var_46_0 * (utf8.len(var_46_1) / 7)

				if (7 <= 0 and var_46_0 or var_46_0 * (utf8.len(var_46_1) / 7)) > 0 and var_46_0 < var_46_3 then
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
	Play102601011 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 102601011
		arg_47_1.duration_ = 5.47

		local var_47_0 = {
			ja = 5.333,
			ko = 4.966,
			zh = 4.8,
			en = 5.466
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
				arg_47_0:Play102601012(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 then
				arg_47_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 then
				arg_47_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action2_1")
			end

			local var_50_0 = arg_47_1.actors_["1019ui_story"]

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 and not isNil(var_50_0) and arg_47_1.var_.characterEffect1019ui_story == nil then
				arg_47_1.var_.characterEffect1019ui_story = var_50_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_50_1 = 0.2

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_1 and not isNil(var_50_0) then
				if arg_47_1.var_.characterEffect1019ui_story and not isNil(var_50_0) then
					arg_47_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_47_1.time_ >= 0 + var_50_1 and arg_47_1.time_ < 0 + var_50_1 + arg_50_0 and not isNil(var_50_0) and arg_47_1.var_.characterEffect1019ui_story then
				arg_47_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_50_3 = 0
			local var_50_4 = 0.475

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= var_50_3 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0
				arg_47_1.dialogCg_.alpha = 1

				arg_47_1.dialog_:SetActive(true)
				SetActive(arg_47_1.leftNameGo_, true)

				arg_47_1.leftNameTxt_.text = arg_47_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_47_1.leftNameTxt_.transform)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1.leftNameTxt_.text)
				SetActive(arg_47_1.iconTrs_.gameObject, false)
				arg_47_1.callingController_:SetSelectedState("normal")

				local var_50_5 = arg_47_1:GetWordFromCfg(102601011)
				local var_50_6 = arg_47_1:FormatText(var_50_5.content)

				arg_47_1.text_.text = var_50_6

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_8 = 19 <= 0 and var_50_4 or var_50_4 * (utf8.len(var_50_6) / 19)

				if (19 <= 0 and var_50_4 or var_50_4 * (utf8.len(var_50_6) / 19)) > 0 and var_50_4 < var_50_8 then
					arg_47_1.talkMaxDuration = var_50_8

					if var_50_8 + var_50_3 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_8 + var_50_3
					end
				end

				arg_47_1.text_.text = var_50_6
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_102601", "102601011", "story_v_side_old_102601.awb") ~= 0 then
					local var_50_9 = manager.audio:GetVoiceLength("story_v_side_old_102601", "102601011", "story_v_side_old_102601.awb") / 1000

					if var_50_9 + var_50_3 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_9 + var_50_3
					end

					if var_50_5.prefab_name ~= "" and arg_47_1.actors_[var_50_5.prefab_name] ~= nil then
						local var_50_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_47_1.actors_[var_50_5.prefab_name].transform, "story_v_side_old_102601", "102601011", "story_v_side_old_102601.awb")

						arg_47_1:RecordAudio("102601011", var_50_10)
						arg_47_1:RecordAudio("102601011", var_50_10)
					else
						arg_47_1:AudioAction("play", "voice", "story_v_side_old_102601", "102601011", "story_v_side_old_102601.awb")
					end

					arg_47_1:RecordHistoryTalkVoice("story_v_side_old_102601", "102601011", "story_v_side_old_102601.awb")
				end

				arg_47_1:RecordContent(arg_47_1.text_.text)
			end

			local var_50_11 = math.max(var_50_4, arg_47_1.talkMaxDuration)

			if var_50_3 <= arg_47_1.time_ and arg_47_1.time_ < var_50_3 + var_50_11 then
				arg_47_1.typewritter.percent = (arg_47_1.time_ - var_50_3) / var_50_11

				arg_47_1.typewritter:SetDirty()
			end

			if arg_47_1.time_ >= var_50_3 + var_50_11 and arg_47_1.time_ < var_50_3 + var_50_11 + arg_50_0 then
				arg_47_1.typewritter.percent = 1

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(true)
			end
		end

		arg_47_1.nodeConfigList_ = {}

		arg_47_1:InitPlayNodeList()
	end,
	Play102601012 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 102601012
		arg_51_1.duration_ = 11.07

		local var_51_0 = {
			ja = 11.066,
			ko = 7.033,
			zh = 5.366,
			en = 5.9
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
				arg_51_0:Play102601013(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 then
				arg_51_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 then
				arg_51_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019actionlink/1019action425")
			end

			local var_54_0 = 0
			local var_54_1 = 0.65

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= var_54_0 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, true)

				arg_51_1.leftNameTxt_.text = arg_51_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_51_1.leftNameTxt_.transform)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1.leftNameTxt_.text)
				SetActive(arg_51_1.iconTrs_.gameObject, false)
				arg_51_1.callingController_:SetSelectedState("normal")

				local var_54_2 = arg_51_1:GetWordFromCfg(102601012)
				local var_54_3 = arg_51_1:FormatText(var_54_2.content)

				arg_51_1.text_.text = var_54_3

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_5 = 26 <= 0 and var_54_1 or var_54_1 * (utf8.len(var_54_3) / 26)

				if (26 <= 0 and var_54_1 or var_54_1 * (utf8.len(var_54_3) / 26)) > 0 and var_54_1 < var_54_5 then
					arg_51_1.talkMaxDuration = var_54_5

					if var_54_5 + var_54_0 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_5 + var_54_0
					end
				end

				arg_51_1.text_.text = var_54_3
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_102601", "102601012", "story_v_side_old_102601.awb") ~= 0 then
					local var_54_6 = manager.audio:GetVoiceLength("story_v_side_old_102601", "102601012", "story_v_side_old_102601.awb") / 1000

					if var_54_6 + var_54_0 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_6 + var_54_0
					end

					if var_54_2.prefab_name ~= "" and arg_51_1.actors_[var_54_2.prefab_name] ~= nil then
						local var_54_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_51_1.actors_[var_54_2.prefab_name].transform, "story_v_side_old_102601", "102601012", "story_v_side_old_102601.awb")

						arg_51_1:RecordAudio("102601012", var_54_7)
						arg_51_1:RecordAudio("102601012", var_54_7)
					else
						arg_51_1:AudioAction("play", "voice", "story_v_side_old_102601", "102601012", "story_v_side_old_102601.awb")
					end

					arg_51_1:RecordHistoryTalkVoice("story_v_side_old_102601", "102601012", "story_v_side_old_102601.awb")
				end

				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_8 = math.max(var_54_1, arg_51_1.talkMaxDuration)

			if var_54_0 <= arg_51_1.time_ and arg_51_1.time_ < var_54_0 + var_54_8 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - var_54_0) / var_54_8

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= var_54_0 + var_54_8 and arg_51_1.time_ < var_54_0 + var_54_8 + arg_54_0 then
				arg_51_1.typewritter.percent = 1

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(true)
			end
		end

		arg_51_1.nodeConfigList_ = {}

		arg_51_1:InitPlayNodeList()
	end,
	Play102601013 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 102601013
		arg_55_1.duration_ = 5

		SetActive(arg_55_1.tipsGo_, false)

		function arg_55_1.onSingleLineFinish_()
			arg_55_1.onSingleLineUpdate_ = nil
			arg_55_1.onSingleLineFinish_ = nil
			arg_55_1.state_ = "waiting"
		end

		function arg_55_1.playNext_(arg_57_0)
			if arg_57_0 == 1 then
				arg_55_0:Play102601014(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 then
				arg_55_1.var_.moveOldPos1019ui_story = arg_55_1.actors_["1019ui_story"].transform.localPosition
			end

			local var_58_0 = 0.001

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_0 then
				arg_55_1.actors_["1019ui_story"].transform.localPosition = Vector3.Lerp(arg_55_1.var_.moveOldPos1019ui_story, Vector3.New(0, 100, 0), (arg_55_1.time_ - 0) / var_58_0)
				arg_55_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_55_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_55_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_55_1.actors_["1019ui_story"].transform.position).z)
				arg_55_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_55_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_55_1.actors_["1019ui_story"].transform.localEulerAngles = arg_55_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			if arg_55_1.time_ >= 0 + var_58_0 and arg_55_1.time_ < 0 + var_58_0 + arg_58_0 then
				arg_55_1.actors_["1019ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_55_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_55_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_55_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_55_1.actors_["1019ui_story"].transform.position).z)
				arg_55_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_55_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_55_1.actors_["1019ui_story"].transform.localEulerAngles = arg_55_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			local var_58_1 = 0
			local var_58_2 = 0.475

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= var_58_1 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, true)

				arg_55_1.leftNameTxt_.text = arg_55_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_55_1.leftNameTxt_.transform)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1.leftNameTxt_.text)
				SetActive(arg_55_1.iconTrs_.gameObject, true)
				arg_55_1.iconController_:SetSelectedState("hero")

				arg_55_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_55_1.callingController_:SetSelectedState("normal")

				arg_55_1.keyicon_.color = Color.New(1, 1, 1)
				arg_55_1.icon_.color = Color.New(1, 1, 1)

				local var_58_3 = arg_55_1:FormatText(arg_55_1:GetWordFromCfg(102601013).content)

				arg_55_1.text_.text = var_58_3

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_5 = 19 <= 0 and var_58_2 or var_58_2 * (utf8.len(var_58_3) / 19)

				if (19 <= 0 and var_58_2 or var_58_2 * (utf8.len(var_58_3) / 19)) > 0 and var_58_2 < var_58_5 then
					arg_55_1.talkMaxDuration = var_58_5

					if var_58_5 + var_58_1 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_5 + var_58_1
					end
				end

				arg_55_1.text_.text = var_58_3
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)
				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_6 = math.max(var_58_2, arg_55_1.talkMaxDuration)

			if var_58_1 <= arg_55_1.time_ and arg_55_1.time_ < var_58_1 + var_58_6 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - var_58_1) / var_58_6

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= var_58_1 + var_58_6 and arg_55_1.time_ < var_58_1 + var_58_6 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end

		arg_55_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_55_1:InitPlayNodeList()
	end,
	Play102601014 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 102601014
		arg_59_1.duration_ = 5

		SetActive(arg_59_1.tipsGo_, false)

		function arg_59_1.onSingleLineFinish_()
			arg_59_1.onSingleLineUpdate_ = nil
			arg_59_1.onSingleLineFinish_ = nil
			arg_59_1.state_ = "waiting"
		end

		function arg_59_1.playNext_(arg_61_0)
			if arg_61_0 == 1 then
				arg_59_0:Play102601015(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			local var_62_0 = 0.925

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

				local var_62_1 = arg_59_1:FormatText(arg_59_1:GetWordFromCfg(102601014).content)

				arg_59_1.text_.text = var_62_1

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_3 = 37 <= 0 and var_62_0 or var_62_0 * (utf8.len(var_62_1) / 37)

				if (37 <= 0 and var_62_0 or var_62_0 * (utf8.len(var_62_1) / 37)) > 0 and var_62_0 < var_62_3 then
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
	Play102601015 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 102601015
		arg_63_1.duration_ = 5

		SetActive(arg_63_1.tipsGo_, false)

		function arg_63_1.onSingleLineFinish_()
			arg_63_1.onSingleLineUpdate_ = nil
			arg_63_1.onSingleLineFinish_ = nil
			arg_63_1.state_ = "waiting"
		end

		function arg_63_1.playNext_(arg_65_0)
			if arg_65_0 == 1 then
				arg_63_0:Play102601016(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			local var_66_0 = 0.05

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, true)

				arg_63_1.leftNameTxt_.text = arg_63_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_63_1.leftNameTxt_.transform)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1.leftNameTxt_.text)
				SetActive(arg_63_1.iconTrs_.gameObject, true)
				arg_63_1.iconController_:SetSelectedState("hero")

				arg_63_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_63_1.callingController_:SetSelectedState("normal")

				arg_63_1.keyicon_.color = Color.New(1, 1, 1)
				arg_63_1.icon_.color = Color.New(1, 1, 1)

				local var_66_1 = arg_63_1:FormatText(arg_63_1:GetWordFromCfg(102601015).content)

				arg_63_1.text_.text = var_66_1

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_3 = 2 <= 0 and var_66_0 or var_66_0 * (utf8.len(var_66_1) / 2)

				if (2 <= 0 and var_66_0 or var_66_0 * (utf8.len(var_66_1) / 2)) > 0 and var_66_0 < var_66_3 then
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
	Play102601016 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 102601016
		arg_67_1.duration_ = 5

		SetActive(arg_67_1.tipsGo_, false)

		function arg_67_1.onSingleLineFinish_()
			arg_67_1.onSingleLineUpdate_ = nil
			arg_67_1.onSingleLineFinish_ = nil
			arg_67_1.state_ = "waiting"
		end

		function arg_67_1.playNext_(arg_69_0)
			if arg_69_0 == 1 then
				arg_67_0:Play102601017(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			local var_70_0 = 0.45

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, false)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_67_1.iconTrs_.gameObject, false)
				arg_67_1.callingController_:SetSelectedState("normal")

				local var_70_1 = arg_67_1:FormatText(arg_67_1:GetWordFromCfg(102601016).content)

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
	Play102601017 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 102601017
		arg_71_1.duration_ = 5

		SetActive(arg_71_1.tipsGo_, false)

		function arg_71_1.onSingleLineFinish_()
			arg_71_1.onSingleLineUpdate_ = nil
			arg_71_1.onSingleLineFinish_ = nil
			arg_71_1.state_ = "waiting"
		end

		function arg_71_1.playNext_(arg_73_0)
			if arg_73_0 == 1 then
				arg_71_0:Play102601018(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			local var_74_0 = 1.05

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, false)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_71_1.iconTrs_.gameObject, false)
				arg_71_1.callingController_:SetSelectedState("normal")

				local var_74_1 = arg_71_1:FormatText(arg_71_1:GetWordFromCfg(102601017).content)

				arg_71_1.text_.text = var_74_1

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_3 = 41 <= 0 and var_74_0 or var_74_0 * (utf8.len(var_74_1) / 41)

				if (41 <= 0 and var_74_0 or var_74_0 * (utf8.len(var_74_1) / 41)) > 0 and var_74_0 < var_74_3 then
					arg_71_1.talkMaxDuration = var_74_3

					if var_74_3 + 0 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_3 + 0
					end
				end

				arg_71_1.text_.text = var_74_1
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)
				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_4 = math.max(var_74_0, arg_71_1.talkMaxDuration)

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_4 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - 0) / var_74_4

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= 0 + var_74_4 and arg_71_1.time_ < 0 + var_74_4 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {}

		arg_71_1:InitPlayNodeList()
	end,
	Play102601018 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 102601018
		arg_75_1.duration_ = 5

		SetActive(arg_75_1.tipsGo_, false)

		function arg_75_1.onSingleLineFinish_()
			arg_75_1.onSingleLineUpdate_ = nil
			arg_75_1.onSingleLineFinish_ = nil
			arg_75_1.state_ = "waiting"
		end

		function arg_75_1.playNext_(arg_77_0)
			if arg_77_0 == 1 then
				arg_75_0:Play102601019(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			local var_78_0 = 0.6

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, false)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_75_1.iconTrs_.gameObject, false)
				arg_75_1.callingController_:SetSelectedState("normal")

				local var_78_1 = arg_75_1:FormatText(arg_75_1:GetWordFromCfg(102601018).content)

				arg_75_1.text_.text = var_78_1

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_3 = 24 <= 0 and var_78_0 or var_78_0 * (utf8.len(var_78_1) / 24)

				if (24 <= 0 and var_78_0 or var_78_0 * (utf8.len(var_78_1) / 24)) > 0 and var_78_0 < var_78_3 then
					arg_75_1.talkMaxDuration = var_78_3

					if var_78_3 + 0 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_3 + 0
					end
				end

				arg_75_1.text_.text = var_78_1
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)
				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_4 = math.max(var_78_0, arg_75_1.talkMaxDuration)

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_4 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - 0) / var_78_4

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= 0 + var_78_4 and arg_75_1.time_ < 0 + var_78_4 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {}

		arg_75_1:InitPlayNodeList()
	end,
	Play102601019 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 102601019
		arg_79_1.duration_ = 6.43

		local var_79_0 = {
			ja = 6.433,
			ko = 4.366,
			zh = 3.266,
			en = 2.7
		}
		local var_79_1 = manager.audio:GetLocalizationFlag()

		if var_79_0[var_79_1] ~= nil then
			arg_79_1.duration_ = var_79_0[var_79_1]
		end

		SetActive(arg_79_1.tipsGo_, false)

		function arg_79_1.onSingleLineFinish_()
			arg_79_1.onSingleLineUpdate_ = nil
			arg_79_1.onSingleLineFinish_ = nil
			arg_79_1.state_ = "waiting"
		end

		function arg_79_1.playNext_(arg_81_0)
			if arg_81_0 == 1 then
				arg_79_0:Play102601020(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1.var_.moveOldPos1019ui_story = arg_79_1.actors_["1019ui_story"].transform.localPosition
			end

			local var_82_0 = 0.001

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_0 then
				arg_79_1.actors_["1019ui_story"].transform.localPosition = Vector3.Lerp(arg_79_1.var_.moveOldPos1019ui_story, Vector3.New(-0.2, -1.08, -5.9), (arg_79_1.time_ - 0) / var_82_0)
				arg_79_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_79_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_79_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_79_1.actors_["1019ui_story"].transform.position).z)
				arg_79_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_79_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_79_1.actors_["1019ui_story"].transform.localEulerAngles = arg_79_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			if arg_79_1.time_ >= 0 + var_82_0 and arg_79_1.time_ < 0 + var_82_0 + arg_82_0 then
				arg_79_1.actors_["1019ui_story"].transform.localPosition = Vector3.New(-0.2, -1.08, -5.9)
				arg_79_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_79_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_79_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_79_1.actors_["1019ui_story"].transform.position).z)
				arg_79_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_79_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_79_1.actors_["1019ui_story"].transform.localEulerAngles = arg_79_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			local var_82_1 = arg_79_1.actors_["1019ui_story"]

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 and not isNil(var_82_1) and arg_79_1.var_.characterEffect1019ui_story == nil then
				arg_79_1.var_.characterEffect1019ui_story = var_82_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_82_2 = 0.2

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_2 and not isNil(var_82_1) then
				if arg_79_1.var_.characterEffect1019ui_story and not isNil(var_82_1) then
					arg_79_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_79_1.time_ >= 0 + var_82_2 and arg_79_1.time_ < 0 + var_82_2 + arg_82_0 and not isNil(var_82_1) and arg_79_1.var_.characterEffect1019ui_story then
				arg_79_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action5_1")
			end

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_82_4 = 0
			local var_82_5 = 0.325

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= var_82_4 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, true)

				arg_79_1.leftNameTxt_.text = arg_79_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_79_1.leftNameTxt_.transform)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1.leftNameTxt_.text)
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_6 = arg_79_1:GetWordFromCfg(102601019)
				local var_82_7 = arg_79_1:FormatText(var_82_6.content)

				arg_79_1.text_.text = var_82_7

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_9 = 13 <= 0 and var_82_5 or var_82_5 * (utf8.len(var_82_7) / 13)

				if (13 <= 0 and var_82_5 or var_82_5 * (utf8.len(var_82_7) / 13)) > 0 and var_82_5 < var_82_9 then
					arg_79_1.talkMaxDuration = var_82_9

					if var_82_9 + var_82_4 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_9 + var_82_4
					end
				end

				arg_79_1.text_.text = var_82_7
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_102601", "102601019", "story_v_side_old_102601.awb") ~= 0 then
					local var_82_10 = manager.audio:GetVoiceLength("story_v_side_old_102601", "102601019", "story_v_side_old_102601.awb") / 1000

					if var_82_10 + var_82_4 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_10 + var_82_4
					end

					if var_82_6.prefab_name ~= "" and arg_79_1.actors_[var_82_6.prefab_name] ~= nil then
						local var_82_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_79_1.actors_[var_82_6.prefab_name].transform, "story_v_side_old_102601", "102601019", "story_v_side_old_102601.awb")

						arg_79_1:RecordAudio("102601019", var_82_11)
						arg_79_1:RecordAudio("102601019", var_82_11)
					else
						arg_79_1:AudioAction("play", "voice", "story_v_side_old_102601", "102601019", "story_v_side_old_102601.awb")
					end

					arg_79_1:RecordHistoryTalkVoice("story_v_side_old_102601", "102601019", "story_v_side_old_102601.awb")
				end

				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_12 = math.max(var_82_5, arg_79_1.talkMaxDuration)

			if var_82_4 <= arg_79_1.time_ and arg_79_1.time_ < var_82_4 + var_82_12 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_4) / var_82_12

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_4 + var_82_12 and arg_79_1.time_ < var_82_4 + var_82_12 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_79_1:InitPlayNodeList()
	end,
	Play102601020 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 102601020
		arg_83_1.duration_ = 5

		SetActive(arg_83_1.tipsGo_, false)

		function arg_83_1.onSingleLineFinish_()
			arg_83_1.onSingleLineUpdate_ = nil
			arg_83_1.onSingleLineFinish_ = nil
			arg_83_1.state_ = "waiting"
		end

		function arg_83_1.playNext_(arg_85_0)
			if arg_85_0 == 1 then
				arg_83_0:Play102601021(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 and not isNil(arg_83_1.actors_["1019ui_story"]) and arg_83_1.var_.characterEffect1019ui_story == nil then
				arg_83_1.var_.characterEffect1019ui_story = arg_83_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_86_0 = 0.2

			if 0 <= arg_83_1.time_ and arg_83_1.time_ < 0 + var_86_0 and not isNil(arg_83_1.actors_["1019ui_story"]) then
				if arg_83_1.var_.characterEffect1019ui_story and not isNil(arg_83_1.actors_["1019ui_story"]) then
					arg_83_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_83_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_83_1.time_ - 0) / var_86_0)
				end
			end

			if arg_83_1.time_ >= 0 + var_86_0 and arg_83_1.time_ < 0 + var_86_0 + arg_86_0 and not isNil(arg_83_1.actors_["1019ui_story"]) and arg_83_1.var_.characterEffect1019ui_story then
				arg_83_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_83_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_86_1 = 0
			local var_86_2 = 0.525

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= var_86_1 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, false)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_83_1.iconTrs_.gameObject, false)
				arg_83_1.callingController_:SetSelectedState("normal")

				local var_86_3 = arg_83_1:FormatText(arg_83_1:GetWordFromCfg(102601020).content)

				arg_83_1.text_.text = var_86_3

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_5 = 21 <= 0 and var_86_2 or var_86_2 * (utf8.len(var_86_3) / 21)

				if (21 <= 0 and var_86_2 or var_86_2 * (utf8.len(var_86_3) / 21)) > 0 and var_86_2 < var_86_5 then
					arg_83_1.talkMaxDuration = var_86_5

					if var_86_5 + var_86_1 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_5 + var_86_1
					end
				end

				arg_83_1.text_.text = var_86_3
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)
				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_6 = math.max(var_86_2, arg_83_1.talkMaxDuration)

			if var_86_1 <= arg_83_1.time_ and arg_83_1.time_ < var_86_1 + var_86_6 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - var_86_1) / var_86_6

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= var_86_1 + var_86_6 and arg_83_1.time_ < var_86_1 + var_86_6 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {}

		arg_83_1:InitPlayNodeList()
	end,
	Play102601021 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 102601021
		arg_87_1.duration_ = 5

		SetActive(arg_87_1.tipsGo_, false)

		function arg_87_1.onSingleLineFinish_()
			arg_87_1.onSingleLineUpdate_ = nil
			arg_87_1.onSingleLineFinish_ = nil
			arg_87_1.state_ = "waiting"
		end

		function arg_87_1.playNext_(arg_89_0)
			if arg_89_0 == 1 then
				arg_87_0:Play102601022(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			local var_90_0 = 0.725

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, true)

				arg_87_1.leftNameTxt_.text = arg_87_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_87_1.leftNameTxt_.transform)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1.leftNameTxt_.text)
				SetActive(arg_87_1.iconTrs_.gameObject, true)
				arg_87_1.iconController_:SetSelectedState("hero")

				arg_87_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_87_1.callingController_:SetSelectedState("normal")

				arg_87_1.keyicon_.color = Color.New(1, 1, 1)
				arg_87_1.icon_.color = Color.New(1, 1, 1)

				local var_90_1 = arg_87_1:FormatText(arg_87_1:GetWordFromCfg(102601021).content)

				arg_87_1.text_.text = var_90_1

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_3 = 29 <= 0 and var_90_0 or var_90_0 * (utf8.len(var_90_1) / 29)

				if (29 <= 0 and var_90_0 or var_90_0 * (utf8.len(var_90_1) / 29)) > 0 and var_90_0 < var_90_3 then
					arg_87_1.talkMaxDuration = var_90_3

					if var_90_3 + 0 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_3 + 0
					end
				end

				arg_87_1.text_.text = var_90_1
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)
				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_4 = math.max(var_90_0, arg_87_1.talkMaxDuration)

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_4 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - 0) / var_90_4

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= 0 + var_90_4 and arg_87_1.time_ < 0 + var_90_4 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {}

		arg_87_1:InitPlayNodeList()
	end,
	Play102601022 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 102601022
		arg_91_1.duration_ = 5

		SetActive(arg_91_1.tipsGo_, false)

		function arg_91_1.onSingleLineFinish_()
			arg_91_1.onSingleLineUpdate_ = nil
			arg_91_1.onSingleLineFinish_ = nil
			arg_91_1.state_ = "waiting"
		end

		function arg_91_1.playNext_(arg_93_0)
			if arg_93_0 == 1 then
				arg_91_0:Play102601023(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				arg_91_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_94_0 = 0
			local var_94_1 = 0.35

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= var_94_0 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, false)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_91_1.iconTrs_.gameObject, false)
				arg_91_1.callingController_:SetSelectedState("normal")

				local var_94_2 = arg_91_1:FormatText(arg_91_1:GetWordFromCfg(102601022).content)

				arg_91_1.text_.text = var_94_2

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_4 = 14 <= 0 and var_94_1 or var_94_1 * (utf8.len(var_94_2) / 14)

				if (14 <= 0 and var_94_1 or var_94_1 * (utf8.len(var_94_2) / 14)) > 0 and var_94_1 < var_94_4 then
					arg_91_1.talkMaxDuration = var_94_4

					if var_94_4 + var_94_0 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_4 + var_94_0
					end
				end

				arg_91_1.text_.text = var_94_2
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)
				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_5 = math.max(var_94_1, arg_91_1.talkMaxDuration)

			if var_94_0 <= arg_91_1.time_ and arg_91_1.time_ < var_94_0 + var_94_5 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - var_94_0) / var_94_5

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= var_94_0 + var_94_5 and arg_91_1.time_ < var_94_0 + var_94_5 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {}

		arg_91_1:InitPlayNodeList()
	end,
	Play102601023 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 102601023
		arg_95_1.duration_ = 5

		SetActive(arg_95_1.tipsGo_, false)

		function arg_95_1.onSingleLineFinish_()
			arg_95_1.onSingleLineUpdate_ = nil
			arg_95_1.onSingleLineFinish_ = nil
			arg_95_1.state_ = "waiting"
		end

		function arg_95_1.playNext_(arg_97_0)
			if arg_97_0 == 1 then
				arg_95_0:Play102601024(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			local var_98_0 = 0.275

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, true)

				arg_95_1.leftNameTxt_.text = arg_95_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_95_1.leftNameTxt_.transform)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1.leftNameTxt_.text)
				SetActive(arg_95_1.iconTrs_.gameObject, true)
				arg_95_1.iconController_:SetSelectedState("hero")

				arg_95_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_95_1.callingController_:SetSelectedState("normal")

				arg_95_1.keyicon_.color = Color.New(1, 1, 1)
				arg_95_1.icon_.color = Color.New(1, 1, 1)

				local var_98_1 = arg_95_1:FormatText(arg_95_1:GetWordFromCfg(102601023).content)

				arg_95_1.text_.text = var_98_1

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_3 = 11 <= 0 and var_98_0 or var_98_0 * (utf8.len(var_98_1) / 11)

				if (11 <= 0 and var_98_0 or var_98_0 * (utf8.len(var_98_1) / 11)) > 0 and var_98_0 < var_98_3 then
					arg_95_1.talkMaxDuration = var_98_3

					if var_98_3 + 0 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_3 + 0
					end
				end

				arg_95_1.text_.text = var_98_1
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)
				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_4 = math.max(var_98_0, arg_95_1.talkMaxDuration)

			if 0 <= arg_95_1.time_ and arg_95_1.time_ < 0 + var_98_4 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - 0) / var_98_4

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= 0 + var_98_4 and arg_95_1.time_ < 0 + var_98_4 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {}

		arg_95_1:InitPlayNodeList()
	end,
	Play102601024 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 102601024
		arg_99_1.duration_ = 7

		local var_99_0 = {
			ja = 7,
			ko = 5.6,
			zh = 4.866,
			en = 6.266
		}
		local var_99_1 = manager.audio:GetLocalizationFlag()

		if var_99_0[var_99_1] ~= nil then
			arg_99_1.duration_ = var_99_0[var_99_1]
		end

		SetActive(arg_99_1.tipsGo_, false)

		function arg_99_1.onSingleLineFinish_()
			arg_99_1.onSingleLineUpdate_ = nil
			arg_99_1.onSingleLineFinish_ = nil
			arg_99_1.state_ = "waiting"
		end

		function arg_99_1.playNext_(arg_101_0)
			if arg_101_0 == 1 then
				arg_99_0:Play102601025(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 and not isNil(arg_99_1.actors_["1019ui_story"]) and arg_99_1.var_.characterEffect1019ui_story == nil then
				arg_99_1.var_.characterEffect1019ui_story = arg_99_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_102_0 = 0.2

			if 0 <= arg_99_1.time_ and arg_99_1.time_ < 0 + var_102_0 and not isNil(arg_99_1.actors_["1019ui_story"]) then
				if arg_99_1.var_.characterEffect1019ui_story and not isNil(arg_99_1.actors_["1019ui_story"]) then
					arg_99_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_99_1.time_ >= 0 + var_102_0 and arg_99_1.time_ < 0 + var_102_0 + arg_102_0 and not isNil(arg_99_1.actors_["1019ui_story"]) and arg_99_1.var_.characterEffect1019ui_story then
				arg_99_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 then
				arg_99_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_102_2 = 0
			local var_102_3 = 0.6

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= var_102_2 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, true)

				arg_99_1.leftNameTxt_.text = arg_99_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_99_1.leftNameTxt_.transform)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1.leftNameTxt_.text)
				SetActive(arg_99_1.iconTrs_.gameObject, false)
				arg_99_1.callingController_:SetSelectedState("normal")

				local var_102_4 = arg_99_1:GetWordFromCfg(102601024)
				local var_102_5 = arg_99_1:FormatText(var_102_4.content)

				arg_99_1.text_.text = var_102_5

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_7 = 24 <= 0 and var_102_3 or var_102_3 * (utf8.len(var_102_5) / 24)

				if (24 <= 0 and var_102_3 or var_102_3 * (utf8.len(var_102_5) / 24)) > 0 and var_102_3 < var_102_7 then
					arg_99_1.talkMaxDuration = var_102_7

					if var_102_7 + var_102_2 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_7 + var_102_2
					end
				end

				arg_99_1.text_.text = var_102_5
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_102601", "102601024", "story_v_side_old_102601.awb") ~= 0 then
					local var_102_8 = manager.audio:GetVoiceLength("story_v_side_old_102601", "102601024", "story_v_side_old_102601.awb") / 1000

					if var_102_8 + var_102_2 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_8 + var_102_2
					end

					if var_102_4.prefab_name ~= "" and arg_99_1.actors_[var_102_4.prefab_name] ~= nil then
						local var_102_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_99_1.actors_[var_102_4.prefab_name].transform, "story_v_side_old_102601", "102601024", "story_v_side_old_102601.awb")

						arg_99_1:RecordAudio("102601024", var_102_9)
						arg_99_1:RecordAudio("102601024", var_102_9)
					else
						arg_99_1:AudioAction("play", "voice", "story_v_side_old_102601", "102601024", "story_v_side_old_102601.awb")
					end

					arg_99_1:RecordHistoryTalkVoice("story_v_side_old_102601", "102601024", "story_v_side_old_102601.awb")
				end

				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_10 = math.max(var_102_3, arg_99_1.talkMaxDuration)

			if var_102_2 <= arg_99_1.time_ and arg_99_1.time_ < var_102_2 + var_102_10 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - var_102_2) / var_102_10

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= var_102_2 + var_102_10 and arg_99_1.time_ < var_102_2 + var_102_10 + arg_102_0 then
				arg_99_1.typewritter.percent = 1

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(true)
			end
		end

		arg_99_1.nodeConfigList_ = {}

		arg_99_1:InitPlayNodeList()
	end,
	Play102601025 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 102601025
		arg_103_1.duration_ = 2.5

		local var_103_0 = {
			ja = 1.999999999999,
			ko = 2.5,
			zh = 1.999999999999,
			en = 1.999999999999
		}
		local var_103_1 = manager.audio:GetLocalizationFlag()

		if var_103_0[var_103_1] ~= nil then
			arg_103_1.duration_ = var_103_0[var_103_1]
		end

		SetActive(arg_103_1.tipsGo_, false)

		function arg_103_1.onSingleLineFinish_()
			arg_103_1.onSingleLineUpdate_ = nil
			arg_103_1.onSingleLineFinish_ = nil
			arg_103_1.state_ = "waiting"
		end

		function arg_103_1.playNext_(arg_105_0)
			if arg_105_0 == 1 then
				arg_103_0:Play102601026(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 then
				arg_103_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_106_0 = 0
			local var_106_1 = 0.175

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= var_106_0 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, true)

				arg_103_1.leftNameTxt_.text = arg_103_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_103_1.leftNameTxt_.transform)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1.leftNameTxt_.text)
				SetActive(arg_103_1.iconTrs_.gameObject, false)
				arg_103_1.callingController_:SetSelectedState("normal")

				local var_106_2 = arg_103_1:GetWordFromCfg(102601025)
				local var_106_3 = arg_103_1:FormatText(var_106_2.content)

				arg_103_1.text_.text = var_106_3

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_5 = 7 <= 0 and var_106_1 or var_106_1 * (utf8.len(var_106_3) / 7)

				if (7 <= 0 and var_106_1 or var_106_1 * (utf8.len(var_106_3) / 7)) > 0 and var_106_1 < var_106_5 then
					arg_103_1.talkMaxDuration = var_106_5

					if var_106_5 + var_106_0 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_5 + var_106_0
					end
				end

				arg_103_1.text_.text = var_106_3
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_102601", "102601025", "story_v_side_old_102601.awb") ~= 0 then
					local var_106_6 = manager.audio:GetVoiceLength("story_v_side_old_102601", "102601025", "story_v_side_old_102601.awb") / 1000

					if var_106_6 + var_106_0 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_6 + var_106_0
					end

					if var_106_2.prefab_name ~= "" and arg_103_1.actors_[var_106_2.prefab_name] ~= nil then
						local var_106_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_103_1.actors_[var_106_2.prefab_name].transform, "story_v_side_old_102601", "102601025", "story_v_side_old_102601.awb")

						arg_103_1:RecordAudio("102601025", var_106_7)
						arg_103_1:RecordAudio("102601025", var_106_7)
					else
						arg_103_1:AudioAction("play", "voice", "story_v_side_old_102601", "102601025", "story_v_side_old_102601.awb")
					end

					arg_103_1:RecordHistoryTalkVoice("story_v_side_old_102601", "102601025", "story_v_side_old_102601.awb")
				end

				arg_103_1:RecordContent(arg_103_1.text_.text)
			end

			local var_106_8 = math.max(var_106_1, arg_103_1.talkMaxDuration)

			if var_106_0 <= arg_103_1.time_ and arg_103_1.time_ < var_106_0 + var_106_8 then
				arg_103_1.typewritter.percent = (arg_103_1.time_ - var_106_0) / var_106_8

				arg_103_1.typewritter:SetDirty()
			end

			if arg_103_1.time_ >= var_106_0 + var_106_8 and arg_103_1.time_ < var_106_0 + var_106_8 + arg_106_0 then
				arg_103_1.typewritter.percent = 1

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(true)
			end
		end

		arg_103_1.nodeConfigList_ = {}

		arg_103_1:InitPlayNodeList()
	end,
	Play102601026 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 102601026
		arg_107_1.duration_ = 5

		SetActive(arg_107_1.tipsGo_, false)

		function arg_107_1.onSingleLineFinish_()
			arg_107_1.onSingleLineUpdate_ = nil
			arg_107_1.onSingleLineFinish_ = nil
			arg_107_1.state_ = "waiting"
		end

		function arg_107_1.playNext_(arg_109_0)
			if arg_109_0 == 1 then
				arg_107_0:Play102601027(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 then
				arg_107_1.var_.moveOldPos1019ui_story = arg_107_1.actors_["1019ui_story"].transform.localPosition
			end

			local var_110_0 = 0.001

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_0 then
				arg_107_1.actors_["1019ui_story"].transform.localPosition = Vector3.Lerp(arg_107_1.var_.moveOldPos1019ui_story, Vector3.New(0, 100, 0), (arg_107_1.time_ - 0) / var_110_0)
				arg_107_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_107_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_107_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_107_1.actors_["1019ui_story"].transform.position).z)
				arg_107_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_107_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_107_1.actors_["1019ui_story"].transform.localEulerAngles = arg_107_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			if arg_107_1.time_ >= 0 + var_110_0 and arg_107_1.time_ < 0 + var_110_0 + arg_110_0 then
				arg_107_1.actors_["1019ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_107_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_107_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_107_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_107_1.actors_["1019ui_story"].transform.position).z)
				arg_107_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_107_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_107_1.actors_["1019ui_story"].transform.localEulerAngles = arg_107_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			local var_110_1 = 0
			local var_110_2 = 0.325

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= var_110_1 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, false)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_107_1.iconTrs_.gameObject, false)
				arg_107_1.callingController_:SetSelectedState("normal")

				local var_110_3 = arg_107_1:FormatText(arg_107_1:GetWordFromCfg(102601026).content)

				arg_107_1.text_.text = var_110_3

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_5 = 13 <= 0 and var_110_2 or var_110_2 * (utf8.len(var_110_3) / 13)

				if (13 <= 0 and var_110_2 or var_110_2 * (utf8.len(var_110_3) / 13)) > 0 and var_110_2 < var_110_5 then
					arg_107_1.talkMaxDuration = var_110_5

					if var_110_5 + var_110_1 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_5 + var_110_1
					end
				end

				arg_107_1.text_.text = var_110_3
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)
				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_6 = math.max(var_110_2, arg_107_1.talkMaxDuration)

			if var_110_1 <= arg_107_1.time_ and arg_107_1.time_ < var_110_1 + var_110_6 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - var_110_1) / var_110_6

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= var_110_1 + var_110_6 and arg_107_1.time_ < var_110_1 + var_110_6 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_107_1:InitPlayNodeList()
	end,
	Play102601027 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 102601027
		arg_111_1.duration_ = 5

		SetActive(arg_111_1.tipsGo_, false)

		function arg_111_1.onSingleLineFinish_()
			arg_111_1.onSingleLineUpdate_ = nil
			arg_111_1.onSingleLineFinish_ = nil
			arg_111_1.state_ = "waiting"
		end

		function arg_111_1.playNext_(arg_113_0)
			if arg_113_0 == 1 then
				arg_111_0:Play102601028(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			local var_114_0 = 0.45

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

				local var_114_1 = arg_111_1:FormatText(arg_111_1:GetWordFromCfg(102601027).content)

				arg_111_1.text_.text = var_114_1

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_3 = 18 <= 0 and var_114_0 or var_114_0 * (utf8.len(var_114_1) / 18)

				if (18 <= 0 and var_114_0 or var_114_0 * (utf8.len(var_114_1) / 18)) > 0 and var_114_0 < var_114_3 then
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
	Play102601028 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 102601028
		arg_115_1.duration_ = 7.68

		SetActive(arg_115_1.tipsGo_, false)

		function arg_115_1.onSingleLineFinish_()
			arg_115_1.onSingleLineUpdate_ = nil
			arg_115_1.onSingleLineFinish_ = nil
			arg_115_1.state_ = "waiting"
		end

		function arg_115_1.playNext_(arg_117_0)
			if arg_117_0 == 1 then
				arg_115_0:Play102601029(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			if arg_115_1.bgs_.ST13 == nil then
				local var_118_0 = Object.Instantiate(arg_115_1.paintGo_)

				var_118_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST13")
				var_118_0.name = "ST13"
				var_118_0.transform.parent = arg_115_1.stage_.transform
				var_118_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_115_1.bgs_.ST13 = var_118_0
			end

			if 1.5 < arg_115_1.time_ and arg_115_1.time_ <= 1.5 + arg_118_0 then
				local var_118_1 = arg_115_1.bgs_.ST13

				arg_115_1.bgs_.ST13.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_118_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_118_2 = var_118_1:GetComponent("SpriteRenderer")

				if var_118_2 and var_118_2.sprite then
					local var_118_3 = 2 * (var_118_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_118_1.transform.localScale = Vector3.New(var_118_3 / var_118_2.sprite.bounds.size.y < var_118_3 * manager.ui.mainCameraCom_.aspect / var_118_2.sprite.bounds.size.x and var_118_3 * manager.ui.mainCameraCom_.aspect / var_118_2.sprite.bounds.size.x or var_118_3 / var_118_2.sprite.bounds.size.y, var_118_3 / var_118_2.sprite.bounds.size.y < var_118_3 * manager.ui.mainCameraCom_.aspect / var_118_2.sprite.bounds.size.x and var_118_3 * manager.ui.mainCameraCom_.aspect / var_118_2.sprite.bounds.size.x or var_118_3 / var_118_2.sprite.bounds.size.y, 0)
				end

				for iter_118_0, iter_118_1 in pairs(arg_115_1.bgs_) do
					if iter_118_0 ~= "ST13" then
						iter_118_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				local var_118_4 = arg_115_1.bgs_.ST04b:GetComponent("SpriteRenderer")

				if var_118_4 then
					arg_115_1.var_.alphaOldValueST04b = var_118_4.color.a
					arg_115_1.var_.alphaMatValueST04b = var_118_4
				end

				arg_115_1.var_.alphaOldValueST04b = 1
			end

			local var_118_5 = 1.5

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_5 then
				if arg_115_1.var_.alphaMatValueST04b then
					arg_115_1.var_.alphaMatValueST04b.color.a = Mathf.Lerp(arg_115_1.var_.alphaOldValueST04b, 0, (arg_115_1.time_ - 0) / var_118_5)
					arg_115_1.var_.alphaMatValueST04b.color = arg_115_1.var_.alphaMatValueST04b.color
				end
			end

			if arg_115_1.time_ >= 0 + var_118_5 and arg_115_1.time_ < 0 + var_118_5 + arg_118_0 and arg_115_1.var_.alphaMatValueST04b then
				arg_115_1.var_.alphaMatValueST04b.color.a = 0
				arg_115_1.var_.alphaMatValueST04b.color = arg_115_1.var_.alphaMatValueST04b.color
			end

			if 1.5 < arg_115_1.time_ and arg_115_1.time_ <= 1.5 + arg_118_0 then
				local var_118_6 = arg_115_1.bgs_.ST13:GetComponent("SpriteRenderer")

				if var_118_6 then
					arg_115_1.var_.alphaOldValueST13 = var_118_6.color.a
					arg_115_1.var_.alphaMatValueST13 = var_118_6
				end

				arg_115_1.var_.alphaOldValueST13 = 0
			end

			local var_118_7 = 1.5

			if 1.5 <= arg_115_1.time_ and arg_115_1.time_ < 1.5 + var_118_7 then
				if arg_115_1.var_.alphaMatValueST13 then
					arg_115_1.var_.alphaMatValueST13.color.a = Mathf.Lerp(arg_115_1.var_.alphaOldValueST13, 1, (arg_115_1.time_ - 1.5) / var_118_7)
					arg_115_1.var_.alphaMatValueST13.color = arg_115_1.var_.alphaMatValueST13.color
				end
			end

			if arg_115_1.time_ >= 1.5 + var_118_7 and arg_115_1.time_ < 1.5 + var_118_7 + arg_118_0 and arg_115_1.var_.alphaMatValueST13 then
				arg_115_1.var_.alphaMatValueST13.color.a = 1
				arg_115_1.var_.alphaMatValueST13.color = arg_115_1.var_.alphaMatValueST13.color
			end

			local var_118_8 = 0

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= var_118_8 + arg_118_0 then
				arg_115_1.allBtn_.enabled = false
			end

			if arg_115_1.time_ >= var_118_8 + 2.675 and arg_115_1.time_ < var_118_8 + 2.675 + arg_118_0 then
				arg_115_1.allBtn_.enabled = true
			end

			if arg_115_1.frameCnt_ <= 1 then
				arg_115_1.dialog_:SetActive(false)
			end

			local var_118_9 = 2.675
			local var_118_10 = 0.325

			if 2.675 < arg_115_1.time_ and arg_115_1.time_ <= var_118_9 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0

				arg_115_1.dialog_:SetActive(true)

				arg_115_1.dialogCg_.alpha = 0

				local var_118_11 = LeanTween.value(arg_115_1.dialog_, 0, 1, 0.3)

				var_118_11:setOnUpdate(LuaHelper.FloatAction(function(arg_119_0)
					arg_115_1.dialogCg_.alpha = arg_119_0
				end))
				var_118_11:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_115_1.dialog_)
					var_118_11:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_115_1.duration_ = arg_115_1.duration_ + 0.3

				SetActive(arg_115_1.leftNameGo_, false)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_12 = arg_115_1:FormatText(arg_115_1:GetWordFromCfg(102601028).content)

				arg_115_1.text_.text = var_118_12

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_14 = 13 <= 0 and var_118_10 or var_118_10 * (utf8.len(var_118_12) / 13)

				if (13 <= 0 and var_118_10 or var_118_10 * (utf8.len(var_118_12) / 13)) > 0 and var_118_10 < var_118_14 then
					arg_115_1.talkMaxDuration = var_118_14
					var_118_9 = var_118_9 + 0.3

					if var_118_14 + var_118_9 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_14 + var_118_9
					end
				end

				arg_115_1.text_.text = var_118_12
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)
				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_15 = var_118_9 + 0.3
			local var_118_16 = math.max(var_118_10, arg_115_1.talkMaxDuration)

			if var_118_9 + 0.3 <= arg_115_1.time_ and arg_115_1.time_ < var_118_15 + var_118_16 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - var_118_15) / var_118_16

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= var_118_15 + var_118_16 and arg_115_1.time_ < var_118_15 + var_118_16 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {}

		arg_115_1:InitPlayNodeList()
	end,
	Play102601029 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 102601029
		arg_121_1.duration_ = 5

		SetActive(arg_121_1.tipsGo_, false)

		function arg_121_1.onSingleLineFinish_()
			arg_121_1.onSingleLineUpdate_ = nil
			arg_121_1.onSingleLineFinish_ = nil
			arg_121_1.state_ = "waiting"
		end

		function arg_121_1.playNext_(arg_123_0)
			if arg_123_0 == 1 then
				arg_121_0:Play102601030(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			local var_124_0 = 0.95

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, false)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_1 = arg_121_1:FormatText(arg_121_1:GetWordFromCfg(102601029).content)

				arg_121_1.text_.text = var_124_1

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_3 = 38 <= 0 and var_124_0 or var_124_0 * (utf8.len(var_124_1) / 38)

				if (38 <= 0 and var_124_0 or var_124_0 * (utf8.len(var_124_1) / 38)) > 0 and var_124_0 < var_124_3 then
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
	Play102601030 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 102601030
		arg_125_1.duration_ = 5

		SetActive(arg_125_1.tipsGo_, false)

		function arg_125_1.onSingleLineFinish_()
			arg_125_1.onSingleLineUpdate_ = nil
			arg_125_1.onSingleLineFinish_ = nil
			arg_125_1.state_ = "waiting"
		end

		function arg_125_1.playNext_(arg_127_0)
			if arg_127_0 == 1 then
				arg_125_0:Play102601031(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			local var_128_0 = 0.675

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, false)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_1 = arg_125_1:FormatText(arg_125_1:GetWordFromCfg(102601030).content)

				arg_125_1.text_.text = var_128_1

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_3 = 27 <= 0 and var_128_0 or var_128_0 * (utf8.len(var_128_1) / 27)

				if (27 <= 0 and var_128_0 or var_128_0 * (utf8.len(var_128_1) / 27)) > 0 and var_128_0 < var_128_3 then
					arg_125_1.talkMaxDuration = var_128_3

					if var_128_3 + 0 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_3 + 0
					end
				end

				arg_125_1.text_.text = var_128_1
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)
				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_4 = math.max(var_128_0, arg_125_1.talkMaxDuration)

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_4 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - 0) / var_128_4

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= 0 + var_128_4 and arg_125_1.time_ < 0 + var_128_4 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {}

		arg_125_1:InitPlayNodeList()
	end,
	Play102601031 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 102601031
		arg_129_1.duration_ = 5

		SetActive(arg_129_1.tipsGo_, false)

		function arg_129_1.onSingleLineFinish_()
			arg_129_1.onSingleLineUpdate_ = nil
			arg_129_1.onSingleLineFinish_ = nil
			arg_129_1.state_ = "waiting"
		end

		function arg_129_1.playNext_(arg_131_0)
			if arg_131_0 == 1 then
				arg_129_0:Play102601032(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			local var_132_0 = 0.875

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, false)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_1 = arg_129_1:FormatText(arg_129_1:GetWordFromCfg(102601031).content)

				arg_129_1.text_.text = var_132_1

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_3 = 35 <= 0 and var_132_0 or var_132_0 * (utf8.len(var_132_1) / 35)

				if (35 <= 0 and var_132_0 or var_132_0 * (utf8.len(var_132_1) / 35)) > 0 and var_132_0 < var_132_3 then
					arg_129_1.talkMaxDuration = var_132_3

					if var_132_3 + 0 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_3 + 0
					end
				end

				arg_129_1.text_.text = var_132_1
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)
				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_4 = math.max(var_132_0, arg_129_1.talkMaxDuration)

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_4 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - 0) / var_132_4

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= 0 + var_132_4 and arg_129_1.time_ < 0 + var_132_4 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {}

		arg_129_1:InitPlayNodeList()
	end,
	Play102601032 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 102601032
		arg_133_1.duration_ = 5

		SetActive(arg_133_1.tipsGo_, false)

		function arg_133_1.onSingleLineFinish_()
			arg_133_1.onSingleLineUpdate_ = nil
			arg_133_1.onSingleLineFinish_ = nil
			arg_133_1.state_ = "waiting"
		end

		function arg_133_1.playNext_(arg_135_0)
			if arg_135_0 == 1 then
				arg_133_0:Play102601033(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			local var_136_0 = 0.575

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, false)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_1 = arg_133_1:FormatText(arg_133_1:GetWordFromCfg(102601032).content)

				arg_133_1.text_.text = var_136_1

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_3 = 23 <= 0 and var_136_0 or var_136_0 * (utf8.len(var_136_1) / 23)

				if (23 <= 0 and var_136_0 or var_136_0 * (utf8.len(var_136_1) / 23)) > 0 and var_136_0 < var_136_3 then
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
	Play102601033 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 102601033
		arg_137_1.duration_ = 5

		SetActive(arg_137_1.tipsGo_, false)

		function arg_137_1.onSingleLineFinish_()
			arg_137_1.onSingleLineUpdate_ = nil
			arg_137_1.onSingleLineFinish_ = nil
			arg_137_1.state_ = "waiting"
		end

		function arg_137_1.playNext_(arg_139_0)
			if arg_139_0 == 1 then
				arg_137_0:Play102601034(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			local var_140_0 = 0.4

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, false)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_1 = arg_137_1:FormatText(arg_137_1:GetWordFromCfg(102601033).content)

				arg_137_1.text_.text = var_140_1

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_3 = 16 <= 0 and var_140_0 or var_140_0 * (utf8.len(var_140_1) / 16)

				if (16 <= 0 and var_140_0 or var_140_0 * (utf8.len(var_140_1) / 16)) > 0 and var_140_0 < var_140_3 then
					arg_137_1.talkMaxDuration = var_140_3

					if var_140_3 + 0 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_3 + 0
					end
				end

				arg_137_1.text_.text = var_140_1
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)
				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_4 = math.max(var_140_0, arg_137_1.talkMaxDuration)

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_4 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - 0) / var_140_4

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= 0 + var_140_4 and arg_137_1.time_ < 0 + var_140_4 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {}

		arg_137_1:InitPlayNodeList()
	end,
	Play102601034 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 102601034
		arg_141_1.duration_ = 5

		SetActive(arg_141_1.tipsGo_, false)

		function arg_141_1.onSingleLineFinish_()
			arg_141_1.onSingleLineUpdate_ = nil
			arg_141_1.onSingleLineFinish_ = nil
			arg_141_1.state_ = "waiting"
		end

		function arg_141_1.playNext_(arg_143_0)
			if arg_143_0 == 1 then
				arg_141_0:Play102601035(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			local var_144_0 = 0.175

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				arg_141_1.leftNameTxt_.text = arg_141_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, true)
				arg_141_1.iconController_:SetSelectedState("hero")

				arg_141_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_141_1.callingController_:SetSelectedState("normal")

				arg_141_1.keyicon_.color = Color.New(1, 1, 1)
				arg_141_1.icon_.color = Color.New(1, 1, 1)

				local var_144_1 = arg_141_1:FormatText(arg_141_1:GetWordFromCfg(102601034).content)

				arg_141_1.text_.text = var_144_1

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_3 = 7 <= 0 and var_144_0 or var_144_0 * (utf8.len(var_144_1) / 7)

				if (7 <= 0 and var_144_0 or var_144_0 * (utf8.len(var_144_1) / 7)) > 0 and var_144_0 < var_144_3 then
					arg_141_1.talkMaxDuration = var_144_3

					if var_144_3 + 0 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_3 + 0
					end
				end

				arg_141_1.text_.text = var_144_1
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)
				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_4 = math.max(var_144_0, arg_141_1.talkMaxDuration)

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_4 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - 0) / var_144_4

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= 0 + var_144_4 and arg_141_1.time_ < 0 + var_144_4 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {}

		arg_141_1:InitPlayNodeList()
	end,
	Play102601035 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 102601035
		arg_145_1.duration_ = 5

		SetActive(arg_145_1.tipsGo_, false)

		function arg_145_1.onSingleLineFinish_()
			arg_145_1.onSingleLineUpdate_ = nil
			arg_145_1.onSingleLineFinish_ = nil
			arg_145_1.state_ = "waiting"
		end

		function arg_145_1.playNext_(arg_147_0)
			if arg_147_0 == 1 then
				arg_145_0:Play102601036(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			local var_148_0 = 0.25

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				arg_145_1.leftNameTxt_.text = arg_145_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, true)
				arg_145_1.iconController_:SetSelectedState("hero")

				arg_145_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_145_1.callingController_:SetSelectedState("normal")

				arg_145_1.keyicon_.color = Color.New(1, 1, 1)
				arg_145_1.icon_.color = Color.New(1, 1, 1)

				local var_148_1 = arg_145_1:FormatText(arg_145_1:GetWordFromCfg(102601035).content)

				arg_145_1.text_.text = var_148_1

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_3 = 10 <= 0 and var_148_0 or var_148_0 * (utf8.len(var_148_1) / 10)

				if (10 <= 0 and var_148_0 or var_148_0 * (utf8.len(var_148_1) / 10)) > 0 and var_148_0 < var_148_3 then
					arg_145_1.talkMaxDuration = var_148_3

					if var_148_3 + 0 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_3 + 0
					end
				end

				arg_145_1.text_.text = var_148_1
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)
				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_4 = math.max(var_148_0, arg_145_1.talkMaxDuration)

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_4 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - 0) / var_148_4

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= 0 + var_148_4 and arg_145_1.time_ < 0 + var_148_4 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {}

		arg_145_1:InitPlayNodeList()
	end,
	Play102601036 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 102601036
		arg_149_1.duration_ = 5

		SetActive(arg_149_1.tipsGo_, false)

		function arg_149_1.onSingleLineFinish_()
			arg_149_1.onSingleLineUpdate_ = nil
			arg_149_1.onSingleLineFinish_ = nil
			arg_149_1.state_ = "waiting"
		end

		function arg_149_1.playNext_(arg_151_0)
			if arg_151_0 == 1 then
				arg_149_0:Play102601037(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			local var_152_0 = 0.25

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

				local var_152_1 = arg_149_1:FormatText(arg_149_1:GetWordFromCfg(102601036).content)

				arg_149_1.text_.text = var_152_1

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_3 = 10 <= 0 and var_152_0 or var_152_0 * (utf8.len(var_152_1) / 10)

				if (10 <= 0 and var_152_0 or var_152_0 * (utf8.len(var_152_1) / 10)) > 0 and var_152_0 < var_152_3 then
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
	Play102601037 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 102601037
		arg_153_1.duration_ = 5

		SetActive(arg_153_1.tipsGo_, false)

		function arg_153_1.onSingleLineFinish_()
			arg_153_1.onSingleLineUpdate_ = nil
			arg_153_1.onSingleLineFinish_ = nil
			arg_153_1.state_ = "waiting"
		end

		function arg_153_1.playNext_(arg_155_0)
			if arg_155_0 == 1 then
				arg_153_0:Play102601038(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			local var_156_0 = 0.8

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

				local var_156_1 = arg_153_1:FormatText(arg_153_1:GetWordFromCfg(102601037).content)

				arg_153_1.text_.text = var_156_1

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_3 = 32 <= 0 and var_156_0 or var_156_0 * (utf8.len(var_156_1) / 32)

				if (32 <= 0 and var_156_0 or var_156_0 * (utf8.len(var_156_1) / 32)) > 0 and var_156_0 < var_156_3 then
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
	Play102601038 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 102601038
		arg_157_1.duration_ = 5

		SetActive(arg_157_1.tipsGo_, false)

		function arg_157_1.onSingleLineFinish_()
			arg_157_1.onSingleLineUpdate_ = nil
			arg_157_1.onSingleLineFinish_ = nil
			arg_157_1.state_ = "waiting"
		end

		function arg_157_1.playNext_(arg_159_0)
			if arg_159_0 == 1 then
				arg_157_0:Play102601039(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			local var_160_0 = 0.425

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, false)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_1 = arg_157_1:FormatText(arg_157_1:GetWordFromCfg(102601038).content)

				arg_157_1.text_.text = var_160_1

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_3 = 17 <= 0 and var_160_0 or var_160_0 * (utf8.len(var_160_1) / 17)

				if (17 <= 0 and var_160_0 or var_160_0 * (utf8.len(var_160_1) / 17)) > 0 and var_160_0 < var_160_3 then
					arg_157_1.talkMaxDuration = var_160_3

					if var_160_3 + 0 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_3 + 0
					end
				end

				arg_157_1.text_.text = var_160_1
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)
				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_4 = math.max(var_160_0, arg_157_1.talkMaxDuration)

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_4 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - 0) / var_160_4

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= 0 + var_160_4 and arg_157_1.time_ < 0 + var_160_4 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {}

		arg_157_1:InitPlayNodeList()
	end,
	Play102601039 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 102601039
		arg_161_1.duration_ = 5

		SetActive(arg_161_1.tipsGo_, false)

		function arg_161_1.onSingleLineFinish_()
			arg_161_1.onSingleLineUpdate_ = nil
			arg_161_1.onSingleLineFinish_ = nil
			arg_161_1.state_ = "waiting"
		end

		function arg_161_1.playNext_(arg_163_0)
			if arg_163_0 == 1 then
				arg_161_0:Play102601040(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			if 0.35 < arg_161_1.time_ and arg_161_1.time_ <= 0.35 + arg_164_0 then
				arg_161_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_164_0 = 0.6

			if 0.35 <= arg_161_1.time_ and arg_161_1.time_ < 0.35 + var_164_0 then
				local var_164_1, var_164_2 = math.modf((arg_161_1.time_ - 0.35) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_164_2 * 0.13, var_164_2 * 0.13, var_164_2 * 0.13) + arg_161_1.var_.shakeOldPos
			end

			if arg_161_1.time_ >= 0.35 + var_164_0 and arg_161_1.time_ < 0.35 + var_164_0 + arg_164_0 then
				manager.ui.mainCamera.transform.localPosition = arg_161_1.var_.shakeOldPos
			end

			local var_164_3 = 0
			local var_164_4 = 0.95

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= var_164_3 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, false)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_5 = arg_161_1:FormatText(arg_161_1:GetWordFromCfg(102601039).content)

				arg_161_1.text_.text = var_164_5

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_7 = 38 <= 0 and var_164_4 or var_164_4 * (utf8.len(var_164_5) / 38)

				if (38 <= 0 and var_164_4 or var_164_4 * (utf8.len(var_164_5) / 38)) > 0 and var_164_4 < var_164_7 then
					arg_161_1.talkMaxDuration = var_164_7

					if var_164_7 + var_164_3 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_7 + var_164_3
					end
				end

				arg_161_1.text_.text = var_164_5
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)
				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_8 = math.max(var_164_4, arg_161_1.talkMaxDuration)

			if var_164_3 <= arg_161_1.time_ and arg_161_1.time_ < var_164_3 + var_164_8 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - var_164_3) / var_164_8

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= var_164_3 + var_164_8 and arg_161_1.time_ < var_164_3 + var_164_8 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {}

		arg_161_1:InitPlayNodeList()
	end,
	Play102601040 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 102601040
		arg_165_1.duration_ = 5

		SetActive(arg_165_1.tipsGo_, false)

		function arg_165_1.onSingleLineFinish_()
			arg_165_1.onSingleLineUpdate_ = nil
			arg_165_1.onSingleLineFinish_ = nil
			arg_165_1.state_ = "waiting"
		end

		function arg_165_1.playNext_(arg_167_0)
			if arg_167_0 == 1 then
				arg_165_0:Play102601041(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			local var_168_0 = 1.2

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

				local var_168_1 = arg_165_1:FormatText(arg_165_1:GetWordFromCfg(102601040).content)

				arg_165_1.text_.text = var_168_1

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_3 = 48 <= 0 and var_168_0 or var_168_0 * (utf8.len(var_168_1) / 48)

				if (48 <= 0 and var_168_0 or var_168_0 * (utf8.len(var_168_1) / 48)) > 0 and var_168_0 < var_168_3 then
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
	Play102601041 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 102601041
		arg_169_1.duration_ = 5

		SetActive(arg_169_1.tipsGo_, false)

		function arg_169_1.onSingleLineFinish_()
			arg_169_1.onSingleLineUpdate_ = nil
			arg_169_1.onSingleLineFinish_ = nil
			arg_169_1.state_ = "waiting"
		end

		function arg_169_1.playNext_(arg_171_0)
			if arg_171_0 == 1 then
				arg_169_0:Play102601042(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_172_0 = 1

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_0 then
				local var_172_1, var_172_2 = math.modf((arg_169_1.time_ - 0) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_172_2 * 0.13, var_172_2 * 0.13, var_172_2 * 0.13) + arg_169_1.var_.shakeOldPos
			end

			if arg_169_1.time_ >= 0 + var_172_0 and arg_169_1.time_ < 0 + var_172_0 + arg_172_0 then
				manager.ui.mainCamera.transform.localPosition = arg_169_1.var_.shakeOldPos
			end

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1:AudioAction("play", "effect", "se_story_side_1026", "se_story_1026_smash", "")
			end

			local var_172_4 = 0
			local var_172_5 = 0.1

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= var_172_4 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, false)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_6 = arg_169_1:FormatText(arg_169_1:GetWordFromCfg(102601041).content)

				arg_169_1.text_.text = var_172_6

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_8 = 4 <= 0 and var_172_5 or var_172_5 * (utf8.len(var_172_6) / 4)

				if (4 <= 0 and var_172_5 or var_172_5 * (utf8.len(var_172_6) / 4)) > 0 and var_172_5 < var_172_8 then
					arg_169_1.talkMaxDuration = var_172_8

					if var_172_8 + var_172_4 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_8 + var_172_4
					end
				end

				arg_169_1.text_.text = var_172_6
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)
				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_9 = math.max(var_172_5, arg_169_1.talkMaxDuration)

			if var_172_4 <= arg_169_1.time_ and arg_169_1.time_ < var_172_4 + var_172_9 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_4) / var_172_9

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_4 + var_172_9 and arg_169_1.time_ < var_172_4 + var_172_9 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {}

		arg_169_1:InitPlayNodeList()
	end,
	Play102601042 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 102601042
		arg_173_1.duration_ = 5

		SetActive(arg_173_1.tipsGo_, false)

		function arg_173_1.onSingleLineFinish_()
			arg_173_1.onSingleLineUpdate_ = nil
			arg_173_1.onSingleLineFinish_ = nil
			arg_173_1.state_ = "waiting"
		end

		function arg_173_1.playNext_(arg_175_0)
			if arg_175_0 == 1 then
				arg_173_0:Play102601043(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				local var_176_0 = arg_173_1.bgs_.ST13:GetComponent("SpriteRenderer")

				if var_176_0 then
					arg_173_1.var_.alphaOldValueST13 = var_176_0.color.a
					arg_173_1.var_.alphaMatValueST13 = var_176_0
				end

				arg_173_1.var_.alphaOldValueST13 = 1
			end

			local var_176_1 = 1

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_1 then
				if arg_173_1.var_.alphaMatValueST13 then
					arg_173_1.var_.alphaMatValueST13.color.a = Mathf.Lerp(arg_173_1.var_.alphaOldValueST13, 0, (arg_173_1.time_ - 0) / var_176_1)
					arg_173_1.var_.alphaMatValueST13.color = arg_173_1.var_.alphaMatValueST13.color
				end
			end

			if arg_173_1.time_ >= 0 + var_176_1 and arg_173_1.time_ < 0 + var_176_1 + arg_176_0 and arg_173_1.var_.alphaMatValueST13 then
				arg_173_1.var_.alphaMatValueST13.color.a = 0
				arg_173_1.var_.alphaMatValueST13.color = arg_173_1.var_.alphaMatValueST13.color
			end

			local var_176_2 = 0

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= var_176_2 + arg_176_0 then
				arg_173_1.allBtn_.enabled = false
			end

			if arg_173_1.time_ >= var_176_2 + 1 and arg_173_1.time_ < var_176_2 + 1 + arg_176_0 then
				arg_173_1.allBtn_.enabled = true
			end

			local var_176_3 = 0
			local var_176_4 = 0.7

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= var_176_3 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, false)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_173_1.iconTrs_.gameObject, false)
				arg_173_1.callingController_:SetSelectedState("normal")

				local var_176_5 = arg_173_1:FormatText(arg_173_1:GetWordFromCfg(102601042).content)

				arg_173_1.text_.text = var_176_5

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_7 = 28 <= 0 and var_176_4 or var_176_4 * (utf8.len(var_176_5) / 28)

				if (28 <= 0 and var_176_4 or var_176_4 * (utf8.len(var_176_5) / 28)) > 0 and var_176_4 < var_176_7 then
					arg_173_1.talkMaxDuration = var_176_7

					if var_176_7 + var_176_3 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_7 + var_176_3
					end
				end

				arg_173_1.text_.text = var_176_5
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)
				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_8 = math.max(var_176_4, arg_173_1.talkMaxDuration)

			if var_176_3 <= arg_173_1.time_ and arg_173_1.time_ < var_176_3 + var_176_8 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - var_176_3) / var_176_8

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= var_176_3 + var_176_8 and arg_173_1.time_ < var_176_3 + var_176_8 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {}

		arg_173_1:InitPlayNodeList()
	end,
	Play102601043 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 102601043
		arg_177_1.duration_ = 2.4

		local var_177_0 = {
			ja = 2.4,
			ko = 1.333,
			zh = 1.3,
			en = 1.633
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
				arg_177_0:Play102601044(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			local var_180_0 = 0.15

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

				local var_180_1 = arg_177_1:GetWordFromCfg(102601043)
				local var_180_2 = arg_177_1:FormatText(var_180_1.content)

				arg_177_1.text_.text = var_180_2

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_4 = 6 <= 0 and var_180_0 or var_180_0 * (utf8.len(var_180_2) / 6)

				if (6 <= 0 and var_180_0 or var_180_0 * (utf8.len(var_180_2) / 6)) > 0 and var_180_0 < var_180_4 then
					arg_177_1.talkMaxDuration = var_180_4

					if var_180_4 + 0 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_4 + 0
					end
				end

				arg_177_1.text_.text = var_180_2
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_102601", "102601043", "story_v_side_old_102601.awb") ~= 0 then
					local var_180_5 = manager.audio:GetVoiceLength("story_v_side_old_102601", "102601043", "story_v_side_old_102601.awb") / 1000

					if var_180_5 + 0 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_5 + 0
					end

					if var_180_1.prefab_name ~= "" and arg_177_1.actors_[var_180_1.prefab_name] ~= nil then
						local var_180_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_177_1.actors_[var_180_1.prefab_name].transform, "story_v_side_old_102601", "102601043", "story_v_side_old_102601.awb")

						arg_177_1:RecordAudio("102601043", var_180_6)
						arg_177_1:RecordAudio("102601043", var_180_6)
					else
						arg_177_1:AudioAction("play", "voice", "story_v_side_old_102601", "102601043", "story_v_side_old_102601.awb")
					end

					arg_177_1:RecordHistoryTalkVoice("story_v_side_old_102601", "102601043", "story_v_side_old_102601.awb")
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
	Play102601044 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 102601044
		arg_181_1.duration_ = 5

		SetActive(arg_181_1.tipsGo_, false)

		function arg_181_1.onSingleLineFinish_()
			arg_181_1.onSingleLineUpdate_ = nil
			arg_181_1.onSingleLineFinish_ = nil
			arg_181_1.state_ = "waiting"
		end

		function arg_181_1.playNext_(arg_183_0)
			if arg_183_0 == 1 then
				arg_181_0:Play102601045(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			local var_184_0 = 0.375

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, false)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_1 = arg_181_1:FormatText(arg_181_1:GetWordFromCfg(102601044).content)

				arg_181_1.text_.text = var_184_1

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_3 = 15 <= 0 and var_184_0 or var_184_0 * (utf8.len(var_184_1) / 15)

				if (15 <= 0 and var_184_0 or var_184_0 * (utf8.len(var_184_1) / 15)) > 0 and var_184_0 < var_184_3 then
					arg_181_1.talkMaxDuration = var_184_3

					if var_184_3 + 0 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_3 + 0
					end
				end

				arg_181_1.text_.text = var_184_1
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)
				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_4 = math.max(var_184_0, arg_181_1.talkMaxDuration)

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_4 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - 0) / var_184_4

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= 0 + var_184_4 and arg_181_1.time_ < 0 + var_184_4 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {}

		arg_181_1:InitPlayNodeList()
	end,
	Play102601045 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 102601045
		arg_185_1.duration_ = 7

		SetActive(arg_185_1.tipsGo_, false)

		function arg_185_1.onSingleLineFinish_()
			arg_185_1.onSingleLineUpdate_ = nil
			arg_185_1.onSingleLineFinish_ = nil
			arg_185_1.state_ = "waiting"
		end

		function arg_185_1.playNext_(arg_187_0)
			if arg_187_0 == 1 then
				arg_185_0:Play102601046(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 then
				local var_188_0 = arg_185_1.bgs_.ST13:GetComponent("SpriteRenderer")

				if var_188_0 then
					arg_185_1.var_.alphaOldValueST13 = var_188_0.color.a
					arg_185_1.var_.alphaMatValueST13 = var_188_0
				end

				arg_185_1.var_.alphaOldValueST13 = 0
			end

			local var_188_1 = 1.5

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_1 then
				if arg_185_1.var_.alphaMatValueST13 then
					arg_185_1.var_.alphaMatValueST13.color.a = Mathf.Lerp(arg_185_1.var_.alphaOldValueST13, 1, (arg_185_1.time_ - 0) / var_188_1)
					arg_185_1.var_.alphaMatValueST13.color = arg_185_1.var_.alphaMatValueST13.color
				end
			end

			if arg_185_1.time_ >= 0 + var_188_1 and arg_185_1.time_ < 0 + var_188_1 + arg_188_0 and arg_185_1.var_.alphaMatValueST13 then
				arg_185_1.var_.alphaMatValueST13.color.a = 1
				arg_185_1.var_.alphaMatValueST13.color = arg_185_1.var_.alphaMatValueST13.color
			end

			local var_188_2 = 0

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= var_188_2 + arg_188_0 then
				arg_185_1.allBtn_.enabled = false
			end

			if arg_185_1.time_ >= var_188_2 + 2 and arg_185_1.time_ < var_188_2 + 2 + arg_188_0 then
				arg_185_1.allBtn_.enabled = true
			end

			if arg_185_1.frameCnt_ <= 1 then
				arg_185_1.dialog_:SetActive(false)
			end

			local var_188_3 = 2
			local var_188_4 = 0.55

			if 2 < arg_185_1.time_ and arg_185_1.time_ <= var_188_3 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0

				arg_185_1.dialog_:SetActive(true)

				arg_185_1.dialogCg_.alpha = 0

				local var_188_5 = LeanTween.value(arg_185_1.dialog_, 0, 1, 0.3)

				var_188_5:setOnUpdate(LuaHelper.FloatAction(function(arg_189_0)
					arg_185_1.dialogCg_.alpha = arg_189_0
				end))
				var_188_5:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_185_1.dialog_)
					var_188_5:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_185_1.duration_ = arg_185_1.duration_ + 0.3

				SetActive(arg_185_1.leftNameGo_, false)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_6 = arg_185_1:FormatText(arg_185_1:GetWordFromCfg(102601045).content)

				arg_185_1.text_.text = var_188_6

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_8 = 22 <= 0 and var_188_4 or var_188_4 * (utf8.len(var_188_6) / 22)

				if (22 <= 0 and var_188_4 or var_188_4 * (utf8.len(var_188_6) / 22)) > 0 and var_188_4 < var_188_8 then
					arg_185_1.talkMaxDuration = var_188_8
					var_188_3 = var_188_3 + 0.3

					if var_188_8 + var_188_3 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_8 + var_188_3
					end
				end

				arg_185_1.text_.text = var_188_6
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)
				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_9 = var_188_3 + 0.3
			local var_188_10 = math.max(var_188_4, arg_185_1.talkMaxDuration)

			if var_188_3 + 0.3 <= arg_185_1.time_ and arg_185_1.time_ < var_188_9 + var_188_10 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_9) / var_188_10

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_9 + var_188_10 and arg_185_1.time_ < var_188_9 + var_188_10 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {}

		arg_185_1:InitPlayNodeList()
	end,
	Play102601046 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 102601046
		arg_191_1.duration_ = 7.5

		SetActive(arg_191_1.tipsGo_, false)

		function arg_191_1.onSingleLineFinish_()
			arg_191_1.onSingleLineUpdate_ = nil
			arg_191_1.onSingleLineFinish_ = nil
			arg_191_1.state_ = "waiting"
		end

		function arg_191_1.playNext_(arg_193_0)
			if arg_193_0 == 1 then
				arg_191_0:Play102601047(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 then
				local var_194_0 = arg_191_1.bgs_.ST13:GetComponent("SpriteRenderer")

				if var_194_0 then
					arg_191_1.var_.alphaOldValueST13 = var_194_0.color.a
					arg_191_1.var_.alphaMatValueST13 = var_194_0
				end

				arg_191_1.var_.alphaOldValueST13 = 1
			end

			local var_194_1 = 1

			if 0 <= arg_191_1.time_ and arg_191_1.time_ < 0 + var_194_1 then
				if arg_191_1.var_.alphaMatValueST13 then
					arg_191_1.var_.alphaMatValueST13.color.a = Mathf.Lerp(arg_191_1.var_.alphaOldValueST13, 0, (arg_191_1.time_ - 0) / var_194_1)
					arg_191_1.var_.alphaMatValueST13.color = arg_191_1.var_.alphaMatValueST13.color
				end
			end

			if arg_191_1.time_ >= 0 + var_194_1 and arg_191_1.time_ < 0 + var_194_1 + arg_194_0 and arg_191_1.var_.alphaMatValueST13 then
				arg_191_1.var_.alphaMatValueST13.color.a = 0
				arg_191_1.var_.alphaMatValueST13.color = arg_191_1.var_.alphaMatValueST13.color
			end

			if 1.2 < arg_191_1.time_ and arg_191_1.time_ <= 1.2 + arg_194_0 then
				local var_194_2 = arg_191_1.bgs_.ST13:GetComponent("SpriteRenderer")

				if var_194_2 then
					arg_191_1.var_.alphaOldValueST13 = var_194_2.color.a
					arg_191_1.var_.alphaMatValueST13 = var_194_2
				end

				arg_191_1.var_.alphaOldValueST13 = 0
			end

			local var_194_3 = 1

			if 1.2 <= arg_191_1.time_ and arg_191_1.time_ < 1.2 + var_194_3 then
				if arg_191_1.var_.alphaMatValueST13 then
					arg_191_1.var_.alphaMatValueST13.color.a = Mathf.Lerp(arg_191_1.var_.alphaOldValueST13, 1, (arg_191_1.time_ - 1.2) / var_194_3)
					arg_191_1.var_.alphaMatValueST13.color = arg_191_1.var_.alphaMatValueST13.color
				end
			end

			if arg_191_1.time_ >= 1.2 + var_194_3 and arg_191_1.time_ < 1.2 + var_194_3 + arg_194_0 and arg_191_1.var_.alphaMatValueST13 then
				arg_191_1.var_.alphaMatValueST13.color.a = 1
				arg_191_1.var_.alphaMatValueST13.color = arg_191_1.var_.alphaMatValueST13.color
			end

			local var_194_4 = 0

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= var_194_4 + arg_194_0 then
				arg_191_1.allBtn_.enabled = false
			end

			if arg_191_1.time_ >= var_194_4 + 2.5 and arg_191_1.time_ < var_194_4 + 2.5 + arg_194_0 then
				arg_191_1.allBtn_.enabled = true
			end

			if arg_191_1.frameCnt_ <= 1 then
				arg_191_1.dialog_:SetActive(false)
			end

			local var_194_5 = 2.5
			local var_194_6 = 0.75

			if 2.5 < arg_191_1.time_ and arg_191_1.time_ <= var_194_5 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0

				arg_191_1.dialog_:SetActive(true)

				arg_191_1.dialogCg_.alpha = 0

				local var_194_7 = LeanTween.value(arg_191_1.dialog_, 0, 1, 0.3)

				var_194_7:setOnUpdate(LuaHelper.FloatAction(function(arg_195_0)
					arg_191_1.dialogCg_.alpha = arg_195_0
				end))
				var_194_7:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_191_1.dialog_)
					var_194_7:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_191_1.duration_ = arg_191_1.duration_ + 0.3

				SetActive(arg_191_1.leftNameGo_, false)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_191_1.iconTrs_.gameObject, false)
				arg_191_1.callingController_:SetSelectedState("normal")

				local var_194_8 = arg_191_1:FormatText(arg_191_1:GetWordFromCfg(102601046).content)

				arg_191_1.text_.text = var_194_8

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_10 = 30 <= 0 and var_194_6 or var_194_6 * (utf8.len(var_194_8) / 30)

				if (30 <= 0 and var_194_6 or var_194_6 * (utf8.len(var_194_8) / 30)) > 0 and var_194_6 < var_194_10 then
					arg_191_1.talkMaxDuration = var_194_10
					var_194_5 = var_194_5 + 0.3

					if var_194_10 + var_194_5 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_10 + var_194_5
					end
				end

				arg_191_1.text_.text = var_194_8
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)
				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_11 = var_194_5 + 0.3
			local var_194_12 = math.max(var_194_6, arg_191_1.talkMaxDuration)

			if var_194_5 + 0.3 <= arg_191_1.time_ and arg_191_1.time_ < var_194_11 + var_194_12 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - var_194_11) / var_194_12

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= var_194_11 + var_194_12 and arg_191_1.time_ < var_194_11 + var_194_12 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {}

		arg_191_1:InitPlayNodeList()
	end,
	Play102601047 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 102601047
		arg_197_1.duration_ = 2.93

		local var_197_0 = {
			ja = 2.933,
			ko = 2.5,
			zh = 2.2,
			en = 2.533
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
				arg_197_0:Play102601048(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			local var_200_0 = 0.175

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, true)

				arg_197_1.leftNameTxt_.text = arg_197_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, true)
				arg_197_1.iconController_:SetSelectedState("hero")

				arg_197_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1026")

				arg_197_1.callingController_:SetSelectedState("normal")

				arg_197_1.keyicon_.color = Color.New(1, 1, 1)
				arg_197_1.icon_.color = Color.New(1, 1, 1)

				local var_200_1 = arg_197_1:GetWordFromCfg(102601047)
				local var_200_2 = arg_197_1:FormatText(var_200_1.content)

				arg_197_1.text_.text = var_200_2

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_4 = 7 <= 0 and var_200_0 or var_200_0 * (utf8.len(var_200_2) / 7)

				if (7 <= 0 and var_200_0 or var_200_0 * (utf8.len(var_200_2) / 7)) > 0 and var_200_0 < var_200_4 then
					arg_197_1.talkMaxDuration = var_200_4

					if var_200_4 + 0 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_4 + 0
					end
				end

				arg_197_1.text_.text = var_200_2
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_102601", "102601047", "story_v_side_old_102601.awb") ~= 0 then
					local var_200_5 = manager.audio:GetVoiceLength("story_v_side_old_102601", "102601047", "story_v_side_old_102601.awb") / 1000

					if var_200_5 + 0 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_5 + 0
					end

					if var_200_1.prefab_name ~= "" and arg_197_1.actors_[var_200_1.prefab_name] ~= nil then
						local var_200_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_197_1.actors_[var_200_1.prefab_name].transform, "story_v_side_old_102601", "102601047", "story_v_side_old_102601.awb")

						arg_197_1:RecordAudio("102601047", var_200_6)
						arg_197_1:RecordAudio("102601047", var_200_6)
					else
						arg_197_1:AudioAction("play", "voice", "story_v_side_old_102601", "102601047", "story_v_side_old_102601.awb")
					end

					arg_197_1:RecordHistoryTalkVoice("story_v_side_old_102601", "102601047", "story_v_side_old_102601.awb")
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
	Play102601048 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 102601048
		arg_201_1.duration_ = 4.97

		local var_201_0 = {
			ja = 4.966,
			ko = 3.266,
			zh = 2.333,
			en = 3.533
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
				arg_201_0:Play102601049(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			local var_204_0 = 0.325

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, true)

				arg_201_1.leftNameTxt_.text = arg_201_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_201_1.leftNameTxt_.transform)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1.leftNameTxt_.text)
				SetActive(arg_201_1.iconTrs_.gameObject, true)
				arg_201_1.iconController_:SetSelectedState("hero")

				arg_201_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1026")

				arg_201_1.callingController_:SetSelectedState("normal")

				arg_201_1.keyicon_.color = Color.New(1, 1, 1)
				arg_201_1.icon_.color = Color.New(1, 1, 1)

				local var_204_1 = arg_201_1:GetWordFromCfg(102601048)
				local var_204_2 = arg_201_1:FormatText(var_204_1.content)

				arg_201_1.text_.text = var_204_2

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_4 = 13 <= 0 and var_204_0 or var_204_0 * (utf8.len(var_204_2) / 13)

				if (13 <= 0 and var_204_0 or var_204_0 * (utf8.len(var_204_2) / 13)) > 0 and var_204_0 < var_204_4 then
					arg_201_1.talkMaxDuration = var_204_4

					if var_204_4 + 0 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_4 + 0
					end
				end

				arg_201_1.text_.text = var_204_2
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_102601", "102601048", "story_v_side_old_102601.awb") ~= 0 then
					local var_204_5 = manager.audio:GetVoiceLength("story_v_side_old_102601", "102601048", "story_v_side_old_102601.awb") / 1000

					if var_204_5 + 0 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_5 + 0
					end

					if var_204_1.prefab_name ~= "" and arg_201_1.actors_[var_204_1.prefab_name] ~= nil then
						local var_204_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_201_1.actors_[var_204_1.prefab_name].transform, "story_v_side_old_102601", "102601048", "story_v_side_old_102601.awb")

						arg_201_1:RecordAudio("102601048", var_204_6)
						arg_201_1:RecordAudio("102601048", var_204_6)
					else
						arg_201_1:AudioAction("play", "voice", "story_v_side_old_102601", "102601048", "story_v_side_old_102601.awb")
					end

					arg_201_1:RecordHistoryTalkVoice("story_v_side_old_102601", "102601048", "story_v_side_old_102601.awb")
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
	Play102601049 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 102601049
		arg_205_1.duration_ = 5

		SetActive(arg_205_1.tipsGo_, false)

		function arg_205_1.onSingleLineFinish_()
			arg_205_1.onSingleLineUpdate_ = nil
			arg_205_1.onSingleLineFinish_ = nil
			arg_205_1.state_ = "waiting"
		end

		function arg_205_1.playNext_(arg_207_0)
			if arg_207_0 == 1 then
				arg_205_0:Play102601050(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			local var_208_0 = 0.25

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

				local var_208_1 = arg_205_1:FormatText(arg_205_1:GetWordFromCfg(102601049).content)

				arg_205_1.text_.text = var_208_1

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_3 = 10 <= 0 and var_208_0 or var_208_0 * (utf8.len(var_208_1) / 10)

				if (10 <= 0 and var_208_0 or var_208_0 * (utf8.len(var_208_1) / 10)) > 0 and var_208_0 < var_208_3 then
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
	Play102601050 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 102601050
		arg_209_1.duration_ = 8.03

		local var_209_0 = {
			ja = 8.033,
			ko = 3.533,
			zh = 3.8,
			en = 7.1
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
				arg_209_0:Play102601051(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			local var_212_0 = 0.5

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, true)

				arg_209_1.leftNameTxt_.text = arg_209_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_209_1.leftNameTxt_.transform)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1.leftNameTxt_.text)
				SetActive(arg_209_1.iconTrs_.gameObject, true)
				arg_209_1.iconController_:SetSelectedState("hero")

				arg_209_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1026")

				arg_209_1.callingController_:SetSelectedState("normal")

				arg_209_1.keyicon_.color = Color.New(1, 1, 1)
				arg_209_1.icon_.color = Color.New(1, 1, 1)

				local var_212_1 = arg_209_1:GetWordFromCfg(102601050)
				local var_212_2 = arg_209_1:FormatText(var_212_1.content)

				arg_209_1.text_.text = var_212_2

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_4 = 20 <= 0 and var_212_0 or var_212_0 * (utf8.len(var_212_2) / 20)

				if (20 <= 0 and var_212_0 or var_212_0 * (utf8.len(var_212_2) / 20)) > 0 and var_212_0 < var_212_4 then
					arg_209_1.talkMaxDuration = var_212_4

					if var_212_4 + 0 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_4 + 0
					end
				end

				arg_209_1.text_.text = var_212_2
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_102601", "102601050", "story_v_side_old_102601.awb") ~= 0 then
					local var_212_5 = manager.audio:GetVoiceLength("story_v_side_old_102601", "102601050", "story_v_side_old_102601.awb") / 1000

					if var_212_5 + 0 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_5 + 0
					end

					if var_212_1.prefab_name ~= "" and arg_209_1.actors_[var_212_1.prefab_name] ~= nil then
						local var_212_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_209_1.actors_[var_212_1.prefab_name].transform, "story_v_side_old_102601", "102601050", "story_v_side_old_102601.awb")

						arg_209_1:RecordAudio("102601050", var_212_6)
						arg_209_1:RecordAudio("102601050", var_212_6)
					else
						arg_209_1:AudioAction("play", "voice", "story_v_side_old_102601", "102601050", "story_v_side_old_102601.awb")
					end

					arg_209_1:RecordHistoryTalkVoice("story_v_side_old_102601", "102601050", "story_v_side_old_102601.awb")
				end

				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_7 = math.max(var_212_0, arg_209_1.talkMaxDuration)

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_7 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - 0) / var_212_7

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= 0 + var_212_7 and arg_209_1.time_ < 0 + var_212_7 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {}

		arg_209_1:InitPlayNodeList()
	end,
	Play102601051 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 102601051
		arg_213_1.duration_ = 5

		SetActive(arg_213_1.tipsGo_, false)

		function arg_213_1.onSingleLineFinish_()
			arg_213_1.onSingleLineUpdate_ = nil
			arg_213_1.onSingleLineFinish_ = nil
			arg_213_1.state_ = "waiting"
		end

		function arg_213_1.playNext_(arg_215_0)
			if arg_215_0 == 1 then
				arg_213_0:Play102601052(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			local var_216_0 = 0.35

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

				local var_216_1 = arg_213_1:FormatText(arg_213_1:GetWordFromCfg(102601051).content)

				arg_213_1.text_.text = var_216_1

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_3 = 14 <= 0 and var_216_0 or var_216_0 * (utf8.len(var_216_1) / 14)

				if (14 <= 0 and var_216_0 or var_216_0 * (utf8.len(var_216_1) / 14)) > 0 and var_216_0 < var_216_3 then
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
	Play102601052 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 102601052
		arg_217_1.duration_ = 5.8

		SetActive(arg_217_1.tipsGo_, false)

		function arg_217_1.onSingleLineFinish_()
			arg_217_1.onSingleLineUpdate_ = nil
			arg_217_1.onSingleLineFinish_ = nil
			arg_217_1.state_ = "waiting"
		end

		function arg_217_1.playNext_(arg_219_0)
			if arg_219_0 == 1 then
				arg_217_0:Play102601053(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 then
				arg_217_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_220_0 = 0.6

			if 0 <= arg_217_1.time_ and arg_217_1.time_ < 0 + var_220_0 then
				local var_220_1, var_220_2 = math.modf((arg_217_1.time_ - 0) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_220_2 * 0.13, var_220_2 * 0.13, var_220_2 * 0.13) + arg_217_1.var_.shakeOldPos
			end

			if arg_217_1.time_ >= 0 + var_220_0 and arg_217_1.time_ < 0 + var_220_0 + arg_220_0 then
				manager.ui.mainCamera.transform.localPosition = arg_217_1.var_.shakeOldPos
			end

			if arg_217_1.frameCnt_ <= 1 then
				arg_217_1.dialog_:SetActive(false)
			end

			local var_220_3 = 0.8
			local var_220_4 = 0.825

			if 0.8 < arg_217_1.time_ and arg_217_1.time_ <= var_220_3 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0

				arg_217_1.dialog_:SetActive(true)

				arg_217_1.dialogCg_.alpha = 0

				local var_220_5 = LeanTween.value(arg_217_1.dialog_, 0, 1, 0.3)

				var_220_5:setOnUpdate(LuaHelper.FloatAction(function(arg_221_0)
					arg_217_1.dialogCg_.alpha = arg_221_0
				end))
				var_220_5:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_217_1.dialog_)
					var_220_5:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_217_1.duration_ = arg_217_1.duration_ + 0.3

				SetActive(arg_217_1.leftNameGo_, false)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_217_1.iconTrs_.gameObject, false)
				arg_217_1.callingController_:SetSelectedState("normal")

				local var_220_6 = arg_217_1:FormatText(arg_217_1:GetWordFromCfg(102601052).content)

				arg_217_1.text_.text = var_220_6

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_8 = 33 <= 0 and var_220_4 or var_220_4 * (utf8.len(var_220_6) / 33)

				if (33 <= 0 and var_220_4 or var_220_4 * (utf8.len(var_220_6) / 33)) > 0 and var_220_4 < var_220_8 then
					arg_217_1.talkMaxDuration = var_220_8
					var_220_3 = var_220_3 + 0.3

					if var_220_8 + var_220_3 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_8 + var_220_3
					end
				end

				arg_217_1.text_.text = var_220_6
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)
				arg_217_1:RecordContent(arg_217_1.text_.text)
			end

			local var_220_9 = var_220_3 + 0.3
			local var_220_10 = math.max(var_220_4, arg_217_1.talkMaxDuration)

			if var_220_3 + 0.3 <= arg_217_1.time_ and arg_217_1.time_ < var_220_9 + var_220_10 then
				arg_217_1.typewritter.percent = (arg_217_1.time_ - var_220_9) / var_220_10

				arg_217_1.typewritter:SetDirty()
			end

			if arg_217_1.time_ >= var_220_9 + var_220_10 and arg_217_1.time_ < var_220_9 + var_220_10 + arg_220_0 then
				arg_217_1.typewritter.percent = 1

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(true)
			end
		end

		arg_217_1.nodeConfigList_ = {}

		arg_217_1:InitPlayNodeList()
	end,
	Play102601053 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 102601053
		arg_223_1.duration_ = 5

		SetActive(arg_223_1.tipsGo_, false)

		function arg_223_1.onSingleLineFinish_()
			arg_223_1.onSingleLineUpdate_ = nil
			arg_223_1.onSingleLineFinish_ = nil
			arg_223_1.state_ = "waiting"
		end

		function arg_223_1.playNext_(arg_225_0)
			if arg_225_0 == 1 then
				arg_223_0:Play102601054(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			local var_226_0 = 0.7

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0
				arg_223_1.dialogCg_.alpha = 1

				arg_223_1.dialog_:SetActive(true)
				SetActive(arg_223_1.leftNameGo_, false)

				arg_223_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_223_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_223_1:RecordName(arg_223_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_223_1.iconTrs_.gameObject, false)
				arg_223_1.callingController_:SetSelectedState("normal")

				local var_226_1 = arg_223_1:FormatText(arg_223_1:GetWordFromCfg(102601053).content)

				arg_223_1.text_.text = var_226_1

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_3 = 28 <= 0 and var_226_0 or var_226_0 * (utf8.len(var_226_1) / 28)

				if (28 <= 0 and var_226_0 or var_226_0 * (utf8.len(var_226_1) / 28)) > 0 and var_226_0 < var_226_3 then
					arg_223_1.talkMaxDuration = var_226_3

					if var_226_3 + 0 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_3 + 0
					end
				end

				arg_223_1.text_.text = var_226_1
				arg_223_1.typewritter.percent = 0

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(false)
				arg_223_1:RecordContent(arg_223_1.text_.text)
			end

			local var_226_4 = math.max(var_226_0, arg_223_1.talkMaxDuration)

			if 0 <= arg_223_1.time_ and arg_223_1.time_ < 0 + var_226_4 then
				arg_223_1.typewritter.percent = (arg_223_1.time_ - 0) / var_226_4

				arg_223_1.typewritter:SetDirty()
			end

			if arg_223_1.time_ >= 0 + var_226_4 and arg_223_1.time_ < 0 + var_226_4 + arg_226_0 then
				arg_223_1.typewritter.percent = 1

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(true)
			end
		end

		arg_223_1.nodeConfigList_ = {}

		arg_223_1:InitPlayNodeList()
	end,
	Play102601054 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 102601054
		arg_227_1.duration_ = 14.4

		local var_227_0 = {
			ja = 14.4,
			ko = 6.3,
			zh = 6.066,
			en = 6.6
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
				arg_227_0:Play102601055(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			if arg_227_1.actors_["1026ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1026ui_story"))) then
				local var_230_0 = Object.Instantiate(Asset.Load("Char/" .. "1026ui_story"), arg_227_1.stage_.transform)

				var_230_0.name = "1026ui_story"
				var_230_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_227_1.actors_["1026ui_story"] = var_230_0

				local var_230_1 = var_230_0:GetComponentInChildren(typeof(CharacterEffect))

				var_230_1.enabled = true

				local var_230_2 = GameObjectTools.GetOrAddComponent(var_230_0, typeof(DynamicBoneHelper))

				if var_230_2 then
					var_230_2:EnableDynamicBone(false)
				end

				arg_227_1:ShowWeapon(var_230_1.transform, false)

				arg_227_1.var_["1026ui_story" .. "Animator"] = var_230_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_227_1.var_["1026ui_story" .. "Animator"].applyRootMotion = true
				arg_227_1.var_["1026ui_story" .. "LipSync"] = var_230_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_230_3 = arg_227_1.actors_["1026ui_story"].transform

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 then
				arg_227_1.var_.moveOldPos1026ui_story = var_230_3.localPosition
			end

			local var_230_4 = 0.001

			if 0 <= arg_227_1.time_ and arg_227_1.time_ < 0 + var_230_4 then
				var_230_3.localPosition = Vector3.Lerp(arg_227_1.var_.moveOldPos1026ui_story, Vector3.New(0, -1.05, -6.2), (arg_227_1.time_ - 0) / var_230_4)
				var_230_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_230_3.position).x, (manager.ui.mainCamera.transform.position - var_230_3.position).y, (manager.ui.mainCamera.transform.position - var_230_3.position).z)
				var_230_3.localEulerAngles.z = 0
				var_230_3.localEulerAngles.x = 0
				var_230_3.localEulerAngles = var_230_3.localEulerAngles
			end

			if arg_227_1.time_ >= 0 + var_230_4 and arg_227_1.time_ < 0 + var_230_4 + arg_230_0 then
				var_230_3.localPosition = Vector3.New(0, -1.05, -6.2)
				var_230_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_230_3.position).x, (manager.ui.mainCamera.transform.position - var_230_3.position).y, (manager.ui.mainCamera.transform.position - var_230_3.position).z)
				var_230_3.localEulerAngles.z = 0
				var_230_3.localEulerAngles.x = 0
				var_230_3.localEulerAngles = var_230_3.localEulerAngles
			end

			local var_230_5 = arg_227_1.actors_["1026ui_story"]

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 and not isNil(var_230_5) and arg_227_1.var_.characterEffect1026ui_story == nil then
				arg_227_1.var_.characterEffect1026ui_story = var_230_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_230_6 = 0.2

			if 0 <= arg_227_1.time_ and arg_227_1.time_ < 0 + var_230_6 and not isNil(var_230_5) then
				if arg_227_1.var_.characterEffect1026ui_story and not isNil(var_230_5) then
					arg_227_1.var_.characterEffect1026ui_story.fillFlat = false
				end
			end

			if arg_227_1.time_ >= 0 + var_230_6 and arg_227_1.time_ < 0 + var_230_6 + arg_230_0 and not isNil(var_230_5) and arg_227_1.var_.characterEffect1026ui_story then
				arg_227_1.var_.characterEffect1026ui_story.fillFlat = false
			end

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 then
				arg_227_1:PlayTimeline("1026ui_story", "StoryTimeline/CharAction/story1026/story1026action/1026action3_1")
			end

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 then
				arg_227_1:PlayTimeline("1026ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1204cva")
			end

			local var_230_8 = 0
			local var_230_9 = 0.7

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= var_230_8 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0
				arg_227_1.dialogCg_.alpha = 1

				arg_227_1.dialog_:SetActive(true)
				SetActive(arg_227_1.leftNameGo_, true)

				arg_227_1.leftNameTxt_.text = arg_227_1:FormatText(StoryNameCfg[83].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_227_1.leftNameTxt_.transform)

				arg_227_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_227_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_227_1:RecordName(arg_227_1.leftNameTxt_.text)
				SetActive(arg_227_1.iconTrs_.gameObject, false)
				arg_227_1.callingController_:SetSelectedState("normal")

				local var_230_10 = arg_227_1:GetWordFromCfg(102601054)
				local var_230_11 = arg_227_1:FormatText(var_230_10.content)

				arg_227_1.text_.text = var_230_11

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_13 = 28 <= 0 and var_230_9 or var_230_9 * (utf8.len(var_230_11) / 28)

				if (28 <= 0 and var_230_9 or var_230_9 * (utf8.len(var_230_11) / 28)) > 0 and var_230_9 < var_230_13 then
					arg_227_1.talkMaxDuration = var_230_13

					if var_230_13 + var_230_8 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_13 + var_230_8
					end
				end

				arg_227_1.text_.text = var_230_11
				arg_227_1.typewritter.percent = 0

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_102601", "102601054", "story_v_side_old_102601.awb") ~= 0 then
					local var_230_14 = manager.audio:GetVoiceLength("story_v_side_old_102601", "102601054", "story_v_side_old_102601.awb") / 1000

					if var_230_14 + var_230_8 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_14 + var_230_8
					end

					if var_230_10.prefab_name ~= "" and arg_227_1.actors_[var_230_10.prefab_name] ~= nil then
						local var_230_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_227_1.actors_[var_230_10.prefab_name].transform, "story_v_side_old_102601", "102601054", "story_v_side_old_102601.awb")

						arg_227_1:RecordAudio("102601054", var_230_15)
						arg_227_1:RecordAudio("102601054", var_230_15)
					else
						arg_227_1:AudioAction("play", "voice", "story_v_side_old_102601", "102601054", "story_v_side_old_102601.awb")
					end

					arg_227_1:RecordHistoryTalkVoice("story_v_side_old_102601", "102601054", "story_v_side_old_102601.awb")
				end

				arg_227_1:RecordContent(arg_227_1.text_.text)
			end

			local var_230_16 = math.max(var_230_9, arg_227_1.talkMaxDuration)

			if var_230_8 <= arg_227_1.time_ and arg_227_1.time_ < var_230_8 + var_230_16 then
				arg_227_1.typewritter.percent = (arg_227_1.time_ - var_230_8) / var_230_16

				arg_227_1.typewritter:SetDirty()
			end

			if arg_227_1.time_ >= var_230_8 + var_230_16 and arg_227_1.time_ < var_230_8 + var_230_16 + arg_230_0 then
				arg_227_1.typewritter.percent = 1

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(true)
			end
		end

		arg_227_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1026ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_227_1:InitPlayNodeList()
	end,
	Play102601055 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 102601055
		arg_231_1.duration_ = 5

		SetActive(arg_231_1.tipsGo_, false)

		function arg_231_1.onSingleLineFinish_()
			arg_231_1.onSingleLineUpdate_ = nil
			arg_231_1.onSingleLineFinish_ = nil
			arg_231_1.state_ = "waiting"
		end

		function arg_231_1.playNext_(arg_233_0)
			if arg_233_0 == 1 then
				arg_231_0:Play102601056(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 then
				arg_231_1.var_.moveOldPos1026ui_story = arg_231_1.actors_["1026ui_story"].transform.localPosition
			end

			local var_234_0 = 0.001

			if 0 <= arg_231_1.time_ and arg_231_1.time_ < 0 + var_234_0 then
				arg_231_1.actors_["1026ui_story"].transform.localPosition = Vector3.Lerp(arg_231_1.var_.moveOldPos1026ui_story, Vector3.New(0, 100, 0), (arg_231_1.time_ - 0) / var_234_0)
				arg_231_1.actors_["1026ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_231_1.actors_["1026ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_231_1.actors_["1026ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_231_1.actors_["1026ui_story"].transform.position).z)
				arg_231_1.actors_["1026ui_story"].transform.localEulerAngles.z = 0
				arg_231_1.actors_["1026ui_story"].transform.localEulerAngles.x = 0
				arg_231_1.actors_["1026ui_story"].transform.localEulerAngles = arg_231_1.actors_["1026ui_story"].transform.localEulerAngles
			end

			if arg_231_1.time_ >= 0 + var_234_0 and arg_231_1.time_ < 0 + var_234_0 + arg_234_0 then
				arg_231_1.actors_["1026ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_231_1.actors_["1026ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_231_1.actors_["1026ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_231_1.actors_["1026ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_231_1.actors_["1026ui_story"].transform.position).z)
				arg_231_1.actors_["1026ui_story"].transform.localEulerAngles.z = 0
				arg_231_1.actors_["1026ui_story"].transform.localEulerAngles.x = 0
				arg_231_1.actors_["1026ui_story"].transform.localEulerAngles = arg_231_1.actors_["1026ui_story"].transform.localEulerAngles
			end

			local var_234_1 = 0
			local var_234_2 = 0.325

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= var_234_1 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0
				arg_231_1.dialogCg_.alpha = 1

				arg_231_1.dialog_:SetActive(true)
				SetActive(arg_231_1.leftNameGo_, false)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_231_1.iconTrs_.gameObject, false)
				arg_231_1.callingController_:SetSelectedState("normal")

				local var_234_3 = arg_231_1:FormatText(arg_231_1:GetWordFromCfg(102601055).content)

				arg_231_1.text_.text = var_234_3

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_5 = 13 <= 0 and var_234_2 or var_234_2 * (utf8.len(var_234_3) / 13)

				if (13 <= 0 and var_234_2 or var_234_2 * (utf8.len(var_234_3) / 13)) > 0 and var_234_2 < var_234_5 then
					arg_231_1.talkMaxDuration = var_234_5

					if var_234_5 + var_234_1 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_5 + var_234_1
					end
				end

				arg_231_1.text_.text = var_234_3
				arg_231_1.typewritter.percent = 0

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(false)
				arg_231_1:RecordContent(arg_231_1.text_.text)
			end

			local var_234_6 = math.max(var_234_2, arg_231_1.talkMaxDuration)

			if var_234_1 <= arg_231_1.time_ and arg_231_1.time_ < var_234_1 + var_234_6 then
				arg_231_1.typewritter.percent = (arg_231_1.time_ - var_234_1) / var_234_6

				arg_231_1.typewritter:SetDirty()
			end

			if arg_231_1.time_ >= var_234_1 + var_234_6 and arg_231_1.time_ < var_234_1 + var_234_6 + arg_234_0 then
				arg_231_1.typewritter.percent = 1

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(true)
			end
		end

		arg_231_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1026ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_231_1:InitPlayNodeList()
	end,
	Play102601056 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 102601056
		arg_235_1.duration_ = 7.13

		local var_235_0 = {
			ja = 7.133,
			ko = 3.433,
			zh = 3.5,
			en = 3.933
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
				arg_235_0:Play102601057(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 then
				arg_235_1.var_.moveOldPos1026ui_story = arg_235_1.actors_["1026ui_story"].transform.localPosition
			end

			local var_238_0 = 0.001

			if 0 <= arg_235_1.time_ and arg_235_1.time_ < 0 + var_238_0 then
				arg_235_1.actors_["1026ui_story"].transform.localPosition = Vector3.Lerp(arg_235_1.var_.moveOldPos1026ui_story, Vector3.New(0, -1.05, -6.2), (arg_235_1.time_ - 0) / var_238_0)
				arg_235_1.actors_["1026ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_235_1.actors_["1026ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_235_1.actors_["1026ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_235_1.actors_["1026ui_story"].transform.position).z)
				arg_235_1.actors_["1026ui_story"].transform.localEulerAngles.z = 0
				arg_235_1.actors_["1026ui_story"].transform.localEulerAngles.x = 0
				arg_235_1.actors_["1026ui_story"].transform.localEulerAngles = arg_235_1.actors_["1026ui_story"].transform.localEulerAngles
			end

			if arg_235_1.time_ >= 0 + var_238_0 and arg_235_1.time_ < 0 + var_238_0 + arg_238_0 then
				arg_235_1.actors_["1026ui_story"].transform.localPosition = Vector3.New(0, -1.05, -6.2)
				arg_235_1.actors_["1026ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_235_1.actors_["1026ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_235_1.actors_["1026ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_235_1.actors_["1026ui_story"].transform.position).z)
				arg_235_1.actors_["1026ui_story"].transform.localEulerAngles.z = 0
				arg_235_1.actors_["1026ui_story"].transform.localEulerAngles.x = 0
				arg_235_1.actors_["1026ui_story"].transform.localEulerAngles = arg_235_1.actors_["1026ui_story"].transform.localEulerAngles
			end

			local var_238_1 = arg_235_1.actors_["1026ui_story"]

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 and not isNil(var_238_1) and arg_235_1.var_.characterEffect1026ui_story == nil then
				arg_235_1.var_.characterEffect1026ui_story = var_238_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_238_2 = 0.2

			if 0 <= arg_235_1.time_ and arg_235_1.time_ < 0 + var_238_2 and not isNil(var_238_1) then
				if arg_235_1.var_.characterEffect1026ui_story and not isNil(var_238_1) then
					arg_235_1.var_.characterEffect1026ui_story.fillFlat = false
				end
			end

			if arg_235_1.time_ >= 0 + var_238_2 and arg_235_1.time_ < 0 + var_238_2 + arg_238_0 and not isNil(var_238_1) and arg_235_1.var_.characterEffect1026ui_story then
				arg_235_1.var_.characterEffect1026ui_story.fillFlat = false
			end

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 then
				arg_235_1:PlayTimeline("1026ui_story", "StoryTimeline/CharAction/story1026/story1026action/1026action7_1")
			end

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 then
				arg_235_1:PlayTimeline("1026ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1204cva")
			end

			local var_238_4 = 0
			local var_238_5 = 0.45

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= var_238_4 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0
				arg_235_1.dialogCg_.alpha = 1

				arg_235_1.dialog_:SetActive(true)
				SetActive(arg_235_1.leftNameGo_, true)

				arg_235_1.leftNameTxt_.text = arg_235_1:FormatText(StoryNameCfg[83].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_235_1.leftNameTxt_.transform)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1.leftNameTxt_.text)
				SetActive(arg_235_1.iconTrs_.gameObject, false)
				arg_235_1.callingController_:SetSelectedState("normal")

				local var_238_6 = arg_235_1:GetWordFromCfg(102601056)
				local var_238_7 = arg_235_1:FormatText(var_238_6.content)

				arg_235_1.text_.text = var_238_7

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_9 = 18 <= 0 and var_238_5 or var_238_5 * (utf8.len(var_238_7) / 18)

				if (18 <= 0 and var_238_5 or var_238_5 * (utf8.len(var_238_7) / 18)) > 0 and var_238_5 < var_238_9 then
					arg_235_1.talkMaxDuration = var_238_9

					if var_238_9 + var_238_4 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_9 + var_238_4
					end
				end

				arg_235_1.text_.text = var_238_7
				arg_235_1.typewritter.percent = 0

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_102601", "102601056", "story_v_side_old_102601.awb") ~= 0 then
					local var_238_10 = manager.audio:GetVoiceLength("story_v_side_old_102601", "102601056", "story_v_side_old_102601.awb") / 1000

					if var_238_10 + var_238_4 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_10 + var_238_4
					end

					if var_238_6.prefab_name ~= "" and arg_235_1.actors_[var_238_6.prefab_name] ~= nil then
						local var_238_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_235_1.actors_[var_238_6.prefab_name].transform, "story_v_side_old_102601", "102601056", "story_v_side_old_102601.awb")

						arg_235_1:RecordAudio("102601056", var_238_11)
						arg_235_1:RecordAudio("102601056", var_238_11)
					else
						arg_235_1:AudioAction("play", "voice", "story_v_side_old_102601", "102601056", "story_v_side_old_102601.awb")
					end

					arg_235_1:RecordHistoryTalkVoice("story_v_side_old_102601", "102601056", "story_v_side_old_102601.awb")
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

		arg_235_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1026ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_235_1:InitPlayNodeList()
	end,
	Play102601057 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 102601057
		arg_239_1.duration_ = 5

		SetActive(arg_239_1.tipsGo_, false)

		function arg_239_1.onSingleLineFinish_()
			arg_239_1.onSingleLineUpdate_ = nil
			arg_239_1.onSingleLineFinish_ = nil
			arg_239_1.state_ = "waiting"
		end

		function arg_239_1.playNext_(arg_241_0)
			if arg_241_0 == 1 then
				arg_239_0:Play102601058(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 and not isNil(arg_239_1.actors_["1026ui_story"]) and arg_239_1.var_.characterEffect1026ui_story == nil then
				arg_239_1.var_.characterEffect1026ui_story = arg_239_1.actors_["1026ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_242_0 = 0.2

			if 0 <= arg_239_1.time_ and arg_239_1.time_ < 0 + var_242_0 and not isNil(arg_239_1.actors_["1026ui_story"]) then
				if arg_239_1.var_.characterEffect1026ui_story and not isNil(arg_239_1.actors_["1026ui_story"]) then
					arg_239_1.var_.characterEffect1026ui_story.fillFlat = true
					arg_239_1.var_.characterEffect1026ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_239_1.time_ - 0) / var_242_0)
				end
			end

			if arg_239_1.time_ >= 0 + var_242_0 and arg_239_1.time_ < 0 + var_242_0 + arg_242_0 and not isNil(arg_239_1.actors_["1026ui_story"]) and arg_239_1.var_.characterEffect1026ui_story then
				arg_239_1.var_.characterEffect1026ui_story.fillFlat = true
				arg_239_1.var_.characterEffect1026ui_story.fillRatio = 0.5
			end

			local var_242_1 = 0
			local var_242_2 = 0.25

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= var_242_1 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0
				arg_239_1.dialogCg_.alpha = 1

				arg_239_1.dialog_:SetActive(true)
				SetActive(arg_239_1.leftNameGo_, true)

				arg_239_1.leftNameTxt_.text = arg_239_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_239_1.leftNameTxt_.transform)

				arg_239_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_239_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_239_1:RecordName(arg_239_1.leftNameTxt_.text)
				SetActive(arg_239_1.iconTrs_.gameObject, true)
				arg_239_1.iconController_:SetSelectedState("hero")

				arg_239_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_239_1.callingController_:SetSelectedState("normal")

				arg_239_1.keyicon_.color = Color.New(1, 1, 1)
				arg_239_1.icon_.color = Color.New(1, 1, 1)

				local var_242_3 = arg_239_1:FormatText(arg_239_1:GetWordFromCfg(102601057).content)

				arg_239_1.text_.text = var_242_3

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_5 = 10 <= 0 and var_242_2 or var_242_2 * (utf8.len(var_242_3) / 10)

				if (10 <= 0 and var_242_2 or var_242_2 * (utf8.len(var_242_3) / 10)) > 0 and var_242_2 < var_242_5 then
					arg_239_1.talkMaxDuration = var_242_5

					if var_242_5 + var_242_1 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_5 + var_242_1
					end
				end

				arg_239_1.text_.text = var_242_3
				arg_239_1.typewritter.percent = 0

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(false)
				arg_239_1:RecordContent(arg_239_1.text_.text)
			end

			local var_242_6 = math.max(var_242_2, arg_239_1.talkMaxDuration)

			if var_242_1 <= arg_239_1.time_ and arg_239_1.time_ < var_242_1 + var_242_6 then
				arg_239_1.typewritter.percent = (arg_239_1.time_ - var_242_1) / var_242_6

				arg_239_1.typewritter:SetDirty()
			end

			if arg_239_1.time_ >= var_242_1 + var_242_6 and arg_239_1.time_ < var_242_1 + var_242_6 + arg_242_0 then
				arg_239_1.typewritter.percent = 1

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(true)
			end
		end

		arg_239_1.nodeConfigList_ = {}

		arg_239_1:InitPlayNodeList()
	end,
	Play102601058 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 102601058
		arg_243_1.duration_ = 5

		SetActive(arg_243_1.tipsGo_, false)

		function arg_243_1.onSingleLineFinish_()
			arg_243_1.onSingleLineUpdate_ = nil
			arg_243_1.onSingleLineFinish_ = nil
			arg_243_1.state_ = "waiting"
		end

		function arg_243_1.playNext_(arg_245_0)
			if arg_245_0 == 1 then
				arg_243_0:Play102601059(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 then
				arg_243_1.var_.moveOldPos1026ui_story = arg_243_1.actors_["1026ui_story"].transform.localPosition
			end

			local var_246_0 = 0.001

			if 0 <= arg_243_1.time_ and arg_243_1.time_ < 0 + var_246_0 then
				arg_243_1.actors_["1026ui_story"].transform.localPosition = Vector3.Lerp(arg_243_1.var_.moveOldPos1026ui_story, Vector3.New(0, 100, 0), (arg_243_1.time_ - 0) / var_246_0)
				arg_243_1.actors_["1026ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_243_1.actors_["1026ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_243_1.actors_["1026ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_243_1.actors_["1026ui_story"].transform.position).z)
				arg_243_1.actors_["1026ui_story"].transform.localEulerAngles.z = 0
				arg_243_1.actors_["1026ui_story"].transform.localEulerAngles.x = 0
				arg_243_1.actors_["1026ui_story"].transform.localEulerAngles = arg_243_1.actors_["1026ui_story"].transform.localEulerAngles
			end

			if arg_243_1.time_ >= 0 + var_246_0 and arg_243_1.time_ < 0 + var_246_0 + arg_246_0 then
				arg_243_1.actors_["1026ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_243_1.actors_["1026ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_243_1.actors_["1026ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_243_1.actors_["1026ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_243_1.actors_["1026ui_story"].transform.position).z)
				arg_243_1.actors_["1026ui_story"].transform.localEulerAngles.z = 0
				arg_243_1.actors_["1026ui_story"].transform.localEulerAngles.x = 0
				arg_243_1.actors_["1026ui_story"].transform.localEulerAngles = arg_243_1.actors_["1026ui_story"].transform.localEulerAngles
			end

			local var_246_1 = 0
			local var_246_2 = 0.975

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= var_246_1 + arg_246_0 then
				arg_243_1.talkMaxDuration = 0
				arg_243_1.dialogCg_.alpha = 1

				arg_243_1.dialog_:SetActive(true)
				SetActive(arg_243_1.leftNameGo_, false)

				arg_243_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_243_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_243_1:RecordName(arg_243_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_243_1.iconTrs_.gameObject, false)
				arg_243_1.callingController_:SetSelectedState("normal")

				local var_246_3 = arg_243_1:FormatText(arg_243_1:GetWordFromCfg(102601058).content)

				arg_243_1.text_.text = var_246_3

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_5 = 39 <= 0 and var_246_2 or var_246_2 * (utf8.len(var_246_3) / 39)

				if (39 <= 0 and var_246_2 or var_246_2 * (utf8.len(var_246_3) / 39)) > 0 and var_246_2 < var_246_5 then
					arg_243_1.talkMaxDuration = var_246_5

					if var_246_5 + var_246_1 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_5 + var_246_1
					end
				end

				arg_243_1.text_.text = var_246_3
				arg_243_1.typewritter.percent = 0

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(false)
				arg_243_1:RecordContent(arg_243_1.text_.text)
			end

			local var_246_6 = math.max(var_246_2, arg_243_1.talkMaxDuration)

			if var_246_1 <= arg_243_1.time_ and arg_243_1.time_ < var_246_1 + var_246_6 then
				arg_243_1.typewritter.percent = (arg_243_1.time_ - var_246_1) / var_246_6

				arg_243_1.typewritter:SetDirty()
			end

			if arg_243_1.time_ >= var_246_1 + var_246_6 and arg_243_1.time_ < var_246_1 + var_246_6 + arg_246_0 then
				arg_243_1.typewritter.percent = 1

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(true)
			end
		end

		arg_243_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1026ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_243_1:InitPlayNodeList()
	end,
	Play102601059 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 102601059
		arg_247_1.duration_ = 11.43

		local var_247_0 = {
			ja = 11.433,
			ko = 10.2,
			zh = 10.5,
			en = 9.4
		}
		local var_247_1 = manager.audio:GetLocalizationFlag()

		if var_247_0[var_247_1] ~= nil then
			arg_247_1.duration_ = var_247_0[var_247_1]
		end

		SetActive(arg_247_1.tipsGo_, false)

		function arg_247_1.onSingleLineFinish_()
			arg_247_1.onSingleLineUpdate_ = nil
			arg_247_1.onSingleLineFinish_ = nil
			arg_247_1.state_ = "waiting"
		end

		function arg_247_1.playNext_(arg_249_0)
			if arg_249_0 == 1 then
				arg_247_0:Play102601060(arg_247_1)
			end
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			local var_250_0 = 1

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0
				arg_247_1.dialogCg_.alpha = 1

				arg_247_1.dialog_:SetActive(true)
				SetActive(arg_247_1.leftNameGo_, true)

				arg_247_1.leftNameTxt_.text = arg_247_1:FormatText(StoryNameCfg[83].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_247_1.leftNameTxt_.transform)

				arg_247_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_247_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_247_1:RecordName(arg_247_1.leftNameTxt_.text)
				SetActive(arg_247_1.iconTrs_.gameObject, true)
				arg_247_1.iconController_:SetSelectedState("hero")

				arg_247_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1026")

				arg_247_1.callingController_:SetSelectedState("normal")

				arg_247_1.keyicon_.color = Color.New(1, 1, 1)
				arg_247_1.icon_.color = Color.New(1, 1, 1)

				local var_250_1 = arg_247_1:GetWordFromCfg(102601059)
				local var_250_2 = arg_247_1:FormatText(var_250_1.content)

				arg_247_1.text_.text = var_250_2

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_4 = 40 <= 0 and var_250_0 or var_250_0 * (utf8.len(var_250_2) / 40)

				if (40 <= 0 and var_250_0 or var_250_0 * (utf8.len(var_250_2) / 40)) > 0 and var_250_0 < var_250_4 then
					arg_247_1.talkMaxDuration = var_250_4

					if var_250_4 + 0 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_4 + 0
					end
				end

				arg_247_1.text_.text = var_250_2
				arg_247_1.typewritter.percent = 0

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_102601", "102601059", "story_v_side_old_102601.awb") ~= 0 then
					local var_250_5 = manager.audio:GetVoiceLength("story_v_side_old_102601", "102601059", "story_v_side_old_102601.awb") / 1000

					if var_250_5 + 0 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_5 + 0
					end

					if var_250_1.prefab_name ~= "" and arg_247_1.actors_[var_250_1.prefab_name] ~= nil then
						local var_250_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_247_1.actors_[var_250_1.prefab_name].transform, "story_v_side_old_102601", "102601059", "story_v_side_old_102601.awb")

						arg_247_1:RecordAudio("102601059", var_250_6)
						arg_247_1:RecordAudio("102601059", var_250_6)
					else
						arg_247_1:AudioAction("play", "voice", "story_v_side_old_102601", "102601059", "story_v_side_old_102601.awb")
					end

					arg_247_1:RecordHistoryTalkVoice("story_v_side_old_102601", "102601059", "story_v_side_old_102601.awb")
				end

				arg_247_1:RecordContent(arg_247_1.text_.text)
			end

			local var_250_7 = math.max(var_250_0, arg_247_1.talkMaxDuration)

			if 0 <= arg_247_1.time_ and arg_247_1.time_ < 0 + var_250_7 then
				arg_247_1.typewritter.percent = (arg_247_1.time_ - 0) / var_250_7

				arg_247_1.typewritter:SetDirty()
			end

			if arg_247_1.time_ >= 0 + var_250_7 and arg_247_1.time_ < 0 + var_250_7 + arg_250_0 then
				arg_247_1.typewritter.percent = 1

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(true)
			end
		end

		arg_247_1.nodeConfigList_ = {}

		arg_247_1:InitPlayNodeList()
	end,
	Play102601060 = function(arg_251_0, arg_251_1)
		arg_251_1.time_ = 0
		arg_251_1.frameCnt_ = 0
		arg_251_1.state_ = "playing"
		arg_251_1.curTalkId_ = 102601060
		arg_251_1.duration_ = 5

		SetActive(arg_251_1.tipsGo_, false)

		function arg_251_1.onSingleLineFinish_()
			arg_251_1.onSingleLineUpdate_ = nil
			arg_251_1.onSingleLineFinish_ = nil
			arg_251_1.state_ = "waiting"
		end

		function arg_251_1.playNext_(arg_253_0)
			if arg_253_0 == 1 then
				arg_251_0:Play102601061(arg_251_1)
			end
		end

		function arg_251_1.onSingleLineUpdate_(arg_254_0)
			local var_254_0 = 0.1

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

				local var_254_1 = arg_251_1:FormatText(arg_251_1:GetWordFromCfg(102601060).content)

				arg_251_1.text_.text = var_254_1

				LuaForUtil.ClearLinePrefixSymbol(arg_251_1.text_)

				local var_254_3 = 4 <= 0 and var_254_0 or var_254_0 * (utf8.len(var_254_1) / 4)

				if (4 <= 0 and var_254_0 or var_254_0 * (utf8.len(var_254_1) / 4)) > 0 and var_254_0 < var_254_3 then
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
	Play102601061 = function(arg_255_0, arg_255_1)
		arg_255_1.time_ = 0
		arg_255_1.frameCnt_ = 0
		arg_255_1.state_ = "playing"
		arg_255_1.curTalkId_ = 102601061
		arg_255_1.duration_ = 4

		local var_255_0 = {
			ja = 4,
			ko = 3.566,
			zh = 2.266,
			en = 2.9
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
				arg_255_0:Play102601062(arg_255_1)
			end
		end

		function arg_255_1.onSingleLineUpdate_(arg_258_0)
			local var_258_0 = 0.275

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 then
				arg_255_1.talkMaxDuration = 0
				arg_255_1.dialogCg_.alpha = 1

				arg_255_1.dialog_:SetActive(true)
				SetActive(arg_255_1.leftNameGo_, true)

				arg_255_1.leftNameTxt_.text = arg_255_1:FormatText(StoryNameCfg[83].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_255_1.leftNameTxt_.transform)

				arg_255_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_255_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_255_1:RecordName(arg_255_1.leftNameTxt_.text)
				SetActive(arg_255_1.iconTrs_.gameObject, true)
				arg_255_1.iconController_:SetSelectedState("hero")

				arg_255_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1026")

				arg_255_1.callingController_:SetSelectedState("normal")

				arg_255_1.keyicon_.color = Color.New(1, 1, 1)
				arg_255_1.icon_.color = Color.New(1, 1, 1)

				local var_258_1 = arg_255_1:GetWordFromCfg(102601061)
				local var_258_2 = arg_255_1:FormatText(var_258_1.content)

				arg_255_1.text_.text = var_258_2

				LuaForUtil.ClearLinePrefixSymbol(arg_255_1.text_)

				local var_258_4 = 11 <= 0 and var_258_0 or var_258_0 * (utf8.len(var_258_2) / 11)

				if (11 <= 0 and var_258_0 or var_258_0 * (utf8.len(var_258_2) / 11)) > 0 and var_258_0 < var_258_4 then
					arg_255_1.talkMaxDuration = var_258_4

					if var_258_4 + 0 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_4 + 0
					end
				end

				arg_255_1.text_.text = var_258_2
				arg_255_1.typewritter.percent = 0

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_102601", "102601061", "story_v_side_old_102601.awb") ~= 0 then
					local var_258_5 = manager.audio:GetVoiceLength("story_v_side_old_102601", "102601061", "story_v_side_old_102601.awb") / 1000

					if var_258_5 + 0 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_5 + 0
					end

					if var_258_1.prefab_name ~= "" and arg_255_1.actors_[var_258_1.prefab_name] ~= nil then
						local var_258_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_255_1.actors_[var_258_1.prefab_name].transform, "story_v_side_old_102601", "102601061", "story_v_side_old_102601.awb")

						arg_255_1:RecordAudio("102601061", var_258_6)
						arg_255_1:RecordAudio("102601061", var_258_6)
					else
						arg_255_1:AudioAction("play", "voice", "story_v_side_old_102601", "102601061", "story_v_side_old_102601.awb")
					end

					arg_255_1:RecordHistoryTalkVoice("story_v_side_old_102601", "102601061", "story_v_side_old_102601.awb")
				end

				arg_255_1:RecordContent(arg_255_1.text_.text)
			end

			local var_258_7 = math.max(var_258_0, arg_255_1.talkMaxDuration)

			if 0 <= arg_255_1.time_ and arg_255_1.time_ < 0 + var_258_7 then
				arg_255_1.typewritter.percent = (arg_255_1.time_ - 0) / var_258_7

				arg_255_1.typewritter:SetDirty()
			end

			if arg_255_1.time_ >= 0 + var_258_7 and arg_255_1.time_ < 0 + var_258_7 + arg_258_0 then
				arg_255_1.typewritter.percent = 1

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(true)
			end
		end

		arg_255_1.nodeConfigList_ = {}

		arg_255_1:InitPlayNodeList()
	end,
	Play102601062 = function(arg_259_0, arg_259_1)
		arg_259_1.time_ = 0
		arg_259_1.frameCnt_ = 0
		arg_259_1.state_ = "playing"
		arg_259_1.curTalkId_ = 102601062
		arg_259_1.duration_ = 5

		SetActive(arg_259_1.tipsGo_, false)

		function arg_259_1.onSingleLineFinish_()
			arg_259_1.onSingleLineUpdate_ = nil
			arg_259_1.onSingleLineFinish_ = nil
			arg_259_1.state_ = "waiting"
		end

		function arg_259_1.playNext_(arg_261_0)
			if arg_261_0 == 1 then
				arg_259_0:Play102601063(arg_259_1)
			end
		end

		function arg_259_1.onSingleLineUpdate_(arg_262_0)
			local var_262_0 = 0.35

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 then
				arg_259_1.talkMaxDuration = 0
				arg_259_1.dialogCg_.alpha = 1

				arg_259_1.dialog_:SetActive(true)
				SetActive(arg_259_1.leftNameGo_, false)

				arg_259_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_259_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_259_1:RecordName(arg_259_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_259_1.iconTrs_.gameObject, false)
				arg_259_1.callingController_:SetSelectedState("normal")

				local var_262_1 = arg_259_1:FormatText(arg_259_1:GetWordFromCfg(102601062).content)

				arg_259_1.text_.text = var_262_1

				LuaForUtil.ClearLinePrefixSymbol(arg_259_1.text_)

				local var_262_3 = 14 <= 0 and var_262_0 or var_262_0 * (utf8.len(var_262_1) / 14)

				if (14 <= 0 and var_262_0 or var_262_0 * (utf8.len(var_262_1) / 14)) > 0 and var_262_0 < var_262_3 then
					arg_259_1.talkMaxDuration = var_262_3

					if var_262_3 + 0 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_3 + 0
					end
				end

				arg_259_1.text_.text = var_262_1
				arg_259_1.typewritter.percent = 0

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(false)
				arg_259_1:RecordContent(arg_259_1.text_.text)
			end

			local var_262_4 = math.max(var_262_0, arg_259_1.talkMaxDuration)

			if 0 <= arg_259_1.time_ and arg_259_1.time_ < 0 + var_262_4 then
				arg_259_1.typewritter.percent = (arg_259_1.time_ - 0) / var_262_4

				arg_259_1.typewritter:SetDirty()
			end

			if arg_259_1.time_ >= 0 + var_262_4 and arg_259_1.time_ < 0 + var_262_4 + arg_262_0 then
				arg_259_1.typewritter.percent = 1

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(true)
			end
		end

		arg_259_1.nodeConfigList_ = {}

		arg_259_1:InitPlayNodeList()
	end,
	Play102601063 = function(arg_263_0, arg_263_1)
		arg_263_1.time_ = 0
		arg_263_1.frameCnt_ = 0
		arg_263_1.state_ = "playing"
		arg_263_1.curTalkId_ = 102601063
		arg_263_1.duration_ = 5

		SetActive(arg_263_1.tipsGo_, false)

		function arg_263_1.onSingleLineFinish_()
			arg_263_1.onSingleLineUpdate_ = nil
			arg_263_1.onSingleLineFinish_ = nil
			arg_263_1.state_ = "waiting"
		end

		function arg_263_1.playNext_(arg_265_0)
			if arg_265_0 == 1 then
				arg_263_0:Play102601064(arg_263_1)
			end
		end

		function arg_263_1.onSingleLineUpdate_(arg_266_0)
			local var_266_0 = 0.925

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 then
				arg_263_1.talkMaxDuration = 0
				arg_263_1.dialogCg_.alpha = 1

				arg_263_1.dialog_:SetActive(true)
				SetActive(arg_263_1.leftNameGo_, false)

				arg_263_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_263_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_263_1:RecordName(arg_263_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_263_1.iconTrs_.gameObject, false)
				arg_263_1.callingController_:SetSelectedState("normal")

				local var_266_1 = arg_263_1:FormatText(arg_263_1:GetWordFromCfg(102601063).content)

				arg_263_1.text_.text = var_266_1

				LuaForUtil.ClearLinePrefixSymbol(arg_263_1.text_)

				local var_266_3 = 37 <= 0 and var_266_0 or var_266_0 * (utf8.len(var_266_1) / 37)

				if (37 <= 0 and var_266_0 or var_266_0 * (utf8.len(var_266_1) / 37)) > 0 and var_266_0 < var_266_3 then
					arg_263_1.talkMaxDuration = var_266_3

					if var_266_3 + 0 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_3 + 0
					end
				end

				arg_263_1.text_.text = var_266_1
				arg_263_1.typewritter.percent = 0

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(false)
				arg_263_1:RecordContent(arg_263_1.text_.text)
			end

			local var_266_4 = math.max(var_266_0, arg_263_1.talkMaxDuration)

			if 0 <= arg_263_1.time_ and arg_263_1.time_ < 0 + var_266_4 then
				arg_263_1.typewritter.percent = (arg_263_1.time_ - 0) / var_266_4

				arg_263_1.typewritter:SetDirty()
			end

			if arg_263_1.time_ >= 0 + var_266_4 and arg_263_1.time_ < 0 + var_266_4 + arg_266_0 then
				arg_263_1.typewritter.percent = 1

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(true)
			end
		end

		arg_263_1.nodeConfigList_ = {}

		arg_263_1:InitPlayNodeList()
	end,
	Play102601064 = function(arg_267_0, arg_267_1)
		arg_267_1.time_ = 0
		arg_267_1.frameCnt_ = 0
		arg_267_1.state_ = "playing"
		arg_267_1.curTalkId_ = 102601064
		arg_267_1.duration_ = 5

		SetActive(arg_267_1.tipsGo_, false)

		function arg_267_1.onSingleLineFinish_()
			arg_267_1.onSingleLineUpdate_ = nil
			arg_267_1.onSingleLineFinish_ = nil
			arg_267_1.state_ = "waiting"
		end

		function arg_267_1.playNext_(arg_269_0)
			if arg_269_0 == 1 then
				arg_267_0:Play102601065(arg_267_1)
			end
		end

		function arg_267_1.onSingleLineUpdate_(arg_270_0)
			local var_270_0 = 0.475

			if 0 < arg_267_1.time_ and arg_267_1.time_ <= 0 + arg_270_0 then
				arg_267_1.talkMaxDuration = 0
				arg_267_1.dialogCg_.alpha = 1

				arg_267_1.dialog_:SetActive(true)
				SetActive(arg_267_1.leftNameGo_, true)

				arg_267_1.leftNameTxt_.text = arg_267_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_267_1.leftNameTxt_.transform)

				arg_267_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_267_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_267_1:RecordName(arg_267_1.leftNameTxt_.text)
				SetActive(arg_267_1.iconTrs_.gameObject, true)
				arg_267_1.iconController_:SetSelectedState("hero")

				arg_267_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_267_1.callingController_:SetSelectedState("normal")

				arg_267_1.keyicon_.color = Color.New(1, 1, 1)
				arg_267_1.icon_.color = Color.New(1, 1, 1)

				local var_270_1 = arg_267_1:FormatText(arg_267_1:GetWordFromCfg(102601064).content)

				arg_267_1.text_.text = var_270_1

				LuaForUtil.ClearLinePrefixSymbol(arg_267_1.text_)

				local var_270_3 = 19 <= 0 and var_270_0 or var_270_0 * (utf8.len(var_270_1) / 19)

				if (19 <= 0 and var_270_0 or var_270_0 * (utf8.len(var_270_1) / 19)) > 0 and var_270_0 < var_270_3 then
					arg_267_1.talkMaxDuration = var_270_3

					if var_270_3 + 0 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_3 + 0
					end
				end

				arg_267_1.text_.text = var_270_1
				arg_267_1.typewritter.percent = 0

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(false)
				arg_267_1:RecordContent(arg_267_1.text_.text)
			end

			local var_270_4 = math.max(var_270_0, arg_267_1.talkMaxDuration)

			if 0 <= arg_267_1.time_ and arg_267_1.time_ < 0 + var_270_4 then
				arg_267_1.typewritter.percent = (arg_267_1.time_ - 0) / var_270_4

				arg_267_1.typewritter:SetDirty()
			end

			if arg_267_1.time_ >= 0 + var_270_4 and arg_267_1.time_ < 0 + var_270_4 + arg_270_0 then
				arg_267_1.typewritter.percent = 1

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(true)
			end
		end

		arg_267_1.nodeConfigList_ = {}

		arg_267_1:InitPlayNodeList()
	end,
	Play102601065 = function(arg_271_0, arg_271_1)
		arg_271_1.time_ = 0
		arg_271_1.frameCnt_ = 0
		arg_271_1.state_ = "playing"
		arg_271_1.curTalkId_ = 102601065
		arg_271_1.duration_ = 5

		SetActive(arg_271_1.tipsGo_, false)

		function arg_271_1.onSingleLineFinish_()
			arg_271_1.onSingleLineUpdate_ = nil
			arg_271_1.onSingleLineFinish_ = nil
			arg_271_1.state_ = "waiting"
		end

		function arg_271_1.playNext_(arg_273_0)
			if arg_273_0 == 1 then
				arg_271_0:Play102601066(arg_271_1)
			end
		end

		function arg_271_1.onSingleLineUpdate_(arg_274_0)
			local var_274_0 = 0.35

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 then
				arg_271_1.talkMaxDuration = 0
				arg_271_1.dialogCg_.alpha = 1

				arg_271_1.dialog_:SetActive(true)
				SetActive(arg_271_1.leftNameGo_, false)

				arg_271_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_271_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_271_1:RecordName(arg_271_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_271_1.iconTrs_.gameObject, false)
				arg_271_1.callingController_:SetSelectedState("normal")

				local var_274_1 = arg_271_1:FormatText(arg_271_1:GetWordFromCfg(102601065).content)

				arg_271_1.text_.text = var_274_1

				LuaForUtil.ClearLinePrefixSymbol(arg_271_1.text_)

				local var_274_3 = 14 <= 0 and var_274_0 or var_274_0 * (utf8.len(var_274_1) / 14)

				if (14 <= 0 and var_274_0 or var_274_0 * (utf8.len(var_274_1) / 14)) > 0 and var_274_0 < var_274_3 then
					arg_271_1.talkMaxDuration = var_274_3

					if var_274_3 + 0 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_3 + 0
					end
				end

				arg_271_1.text_.text = var_274_1
				arg_271_1.typewritter.percent = 0

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(false)
				arg_271_1:RecordContent(arg_271_1.text_.text)
			end

			local var_274_4 = math.max(var_274_0, arg_271_1.talkMaxDuration)

			if 0 <= arg_271_1.time_ and arg_271_1.time_ < 0 + var_274_4 then
				arg_271_1.typewritter.percent = (arg_271_1.time_ - 0) / var_274_4

				arg_271_1.typewritter:SetDirty()
			end

			if arg_271_1.time_ >= 0 + var_274_4 and arg_271_1.time_ < 0 + var_274_4 + arg_274_0 then
				arg_271_1.typewritter.percent = 1

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(true)
			end
		end

		arg_271_1.nodeConfigList_ = {}

		arg_271_1:InitPlayNodeList()
	end,
	Play102601066 = function(arg_275_0, arg_275_1)
		arg_275_1.time_ = 0
		arg_275_1.frameCnt_ = 0
		arg_275_1.state_ = "playing"
		arg_275_1.curTalkId_ = 102601066
		arg_275_1.duration_ = 5

		SetActive(arg_275_1.tipsGo_, false)

		function arg_275_1.onSingleLineFinish_()
			arg_275_1.onSingleLineUpdate_ = nil
			arg_275_1.onSingleLineFinish_ = nil
			arg_275_1.state_ = "waiting"
		end

		function arg_275_1.playNext_(arg_277_0)
			if arg_277_0 == 1 then
				arg_275_0:Play102601067(arg_275_1)
			end
		end

		function arg_275_1.onSingleLineUpdate_(arg_278_0)
			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 then
				arg_275_1:AudioAction("play", "effect", "se_story_side_1026", "se_story_1026_broken", "")
			end

			local var_278_1 = 0
			local var_278_2 = 0.1

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= var_278_1 + arg_278_0 then
				arg_275_1.talkMaxDuration = 0
				arg_275_1.dialogCg_.alpha = 1

				arg_275_1.dialog_:SetActive(true)
				SetActive(arg_275_1.leftNameGo_, false)

				arg_275_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_275_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_275_1:RecordName(arg_275_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_275_1.iconTrs_.gameObject, false)
				arg_275_1.callingController_:SetSelectedState("normal")

				local var_278_3 = arg_275_1:FormatText(arg_275_1:GetWordFromCfg(102601066).content)

				arg_275_1.text_.text = var_278_3

				LuaForUtil.ClearLinePrefixSymbol(arg_275_1.text_)

				local var_278_5 = 4 <= 0 and var_278_2 or var_278_2 * (utf8.len(var_278_3) / 4)

				if (4 <= 0 and var_278_2 or var_278_2 * (utf8.len(var_278_3) / 4)) > 0 and var_278_2 < var_278_5 then
					arg_275_1.talkMaxDuration = var_278_5

					if var_278_5 + var_278_1 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_5 + var_278_1
					end
				end

				arg_275_1.text_.text = var_278_3
				arg_275_1.typewritter.percent = 0

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(false)
				arg_275_1:RecordContent(arg_275_1.text_.text)
			end

			local var_278_6 = math.max(var_278_2, arg_275_1.talkMaxDuration)

			if var_278_1 <= arg_275_1.time_ and arg_275_1.time_ < var_278_1 + var_278_6 then
				arg_275_1.typewritter.percent = (arg_275_1.time_ - var_278_1) / var_278_6

				arg_275_1.typewritter:SetDirty()
			end

			if arg_275_1.time_ >= var_278_1 + var_278_6 and arg_275_1.time_ < var_278_1 + var_278_6 + arg_278_0 then
				arg_275_1.typewritter.percent = 1

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(true)
			end
		end

		arg_275_1.nodeConfigList_ = {}

		arg_275_1:InitPlayNodeList()
	end,
	Play102601067 = function(arg_279_0, arg_279_1)
		arg_279_1.time_ = 0
		arg_279_1.frameCnt_ = 0
		arg_279_1.state_ = "playing"
		arg_279_1.curTalkId_ = 102601067
		arg_279_1.duration_ = 5

		SetActive(arg_279_1.tipsGo_, false)

		function arg_279_1.onSingleLineFinish_()
			arg_279_1.onSingleLineUpdate_ = nil
			arg_279_1.onSingleLineFinish_ = nil
			arg_279_1.state_ = "waiting"
		end

		function arg_279_1.playNext_(arg_281_0)
			if arg_281_0 == 1 then
				arg_279_0:Play102601068(arg_279_1)
			end
		end

		function arg_279_1.onSingleLineUpdate_(arg_282_0)
			local var_282_0 = 0.875

			if 0 < arg_279_1.time_ and arg_279_1.time_ <= 0 + arg_282_0 then
				arg_279_1.talkMaxDuration = 0
				arg_279_1.dialogCg_.alpha = 1

				arg_279_1.dialog_:SetActive(true)
				SetActive(arg_279_1.leftNameGo_, false)

				arg_279_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_279_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_279_1:RecordName(arg_279_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_279_1.iconTrs_.gameObject, false)
				arg_279_1.callingController_:SetSelectedState("normal")

				local var_282_1 = arg_279_1:FormatText(arg_279_1:GetWordFromCfg(102601067).content)

				arg_279_1.text_.text = var_282_1

				LuaForUtil.ClearLinePrefixSymbol(arg_279_1.text_)

				local var_282_3 = 35 <= 0 and var_282_0 or var_282_0 * (utf8.len(var_282_1) / 35)

				if (35 <= 0 and var_282_0 or var_282_0 * (utf8.len(var_282_1) / 35)) > 0 and var_282_0 < var_282_3 then
					arg_279_1.talkMaxDuration = var_282_3

					if var_282_3 + 0 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_3 + 0
					end
				end

				arg_279_1.text_.text = var_282_1
				arg_279_1.typewritter.percent = 0

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(false)
				arg_279_1:RecordContent(arg_279_1.text_.text)
			end

			local var_282_4 = math.max(var_282_0, arg_279_1.talkMaxDuration)

			if 0 <= arg_279_1.time_ and arg_279_1.time_ < 0 + var_282_4 then
				arg_279_1.typewritter.percent = (arg_279_1.time_ - 0) / var_282_4

				arg_279_1.typewritter:SetDirty()
			end

			if arg_279_1.time_ >= 0 + var_282_4 and arg_279_1.time_ < 0 + var_282_4 + arg_282_0 then
				arg_279_1.typewritter.percent = 1

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(true)
			end
		end

		arg_279_1.nodeConfigList_ = {}

		arg_279_1:InitPlayNodeList()
	end,
	Play102601068 = function(arg_283_0, arg_283_1)
		arg_283_1.time_ = 0
		arg_283_1.frameCnt_ = 0
		arg_283_1.state_ = "playing"
		arg_283_1.curTalkId_ = 102601068
		arg_283_1.duration_ = 5

		SetActive(arg_283_1.tipsGo_, false)

		function arg_283_1.onSingleLineFinish_()
			arg_283_1.onSingleLineUpdate_ = nil
			arg_283_1.onSingleLineFinish_ = nil
			arg_283_1.state_ = "waiting"
		end

		function arg_283_1.playNext_(arg_285_0)
			if arg_285_0 == 1 then
				arg_283_0:Play102601069(arg_283_1)
			end
		end

		function arg_283_1.onSingleLineUpdate_(arg_286_0)
			local var_286_0 = 1.175

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 then
				arg_283_1.talkMaxDuration = 0
				arg_283_1.dialogCg_.alpha = 1

				arg_283_1.dialog_:SetActive(true)
				SetActive(arg_283_1.leftNameGo_, false)

				arg_283_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_283_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_283_1:RecordName(arg_283_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_283_1.iconTrs_.gameObject, false)
				arg_283_1.callingController_:SetSelectedState("normal")

				local var_286_1 = arg_283_1:FormatText(arg_283_1:GetWordFromCfg(102601068).content)

				arg_283_1.text_.text = var_286_1

				LuaForUtil.ClearLinePrefixSymbol(arg_283_1.text_)

				local var_286_3 = 47 <= 0 and var_286_0 or var_286_0 * (utf8.len(var_286_1) / 47)

				if (47 <= 0 and var_286_0 or var_286_0 * (utf8.len(var_286_1) / 47)) > 0 and var_286_0 < var_286_3 then
					arg_283_1.talkMaxDuration = var_286_3

					if var_286_3 + 0 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_3 + 0
					end
				end

				arg_283_1.text_.text = var_286_1
				arg_283_1.typewritter.percent = 0

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(false)
				arg_283_1:RecordContent(arg_283_1.text_.text)
			end

			local var_286_4 = math.max(var_286_0, arg_283_1.talkMaxDuration)

			if 0 <= arg_283_1.time_ and arg_283_1.time_ < 0 + var_286_4 then
				arg_283_1.typewritter.percent = (arg_283_1.time_ - 0) / var_286_4

				arg_283_1.typewritter:SetDirty()
			end

			if arg_283_1.time_ >= 0 + var_286_4 and arg_283_1.time_ < 0 + var_286_4 + arg_286_0 then
				arg_283_1.typewritter.percent = 1

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(true)
			end
		end

		arg_283_1.nodeConfigList_ = {}

		arg_283_1:InitPlayNodeList()
	end,
	Play102601069 = function(arg_287_0, arg_287_1)
		arg_287_1.time_ = 0
		arg_287_1.frameCnt_ = 0
		arg_287_1.state_ = "playing"
		arg_287_1.curTalkId_ = 102601069
		arg_287_1.duration_ = 5

		SetActive(arg_287_1.tipsGo_, false)

		function arg_287_1.onSingleLineFinish_()
			arg_287_1.onSingleLineUpdate_ = nil
			arg_287_1.onSingleLineFinish_ = nil
			arg_287_1.state_ = "waiting"
		end

		function arg_287_1.playNext_(arg_289_0)
			if arg_289_0 == 1 then
				arg_287_0:Play102601070(arg_287_1)
			end
		end

		function arg_287_1.onSingleLineUpdate_(arg_290_0)
			local var_290_0 = 0.525

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 then
				arg_287_1.talkMaxDuration = 0
				arg_287_1.dialogCg_.alpha = 1

				arg_287_1.dialog_:SetActive(true)
				SetActive(arg_287_1.leftNameGo_, false)

				arg_287_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_287_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_287_1:RecordName(arg_287_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_287_1.iconTrs_.gameObject, false)
				arg_287_1.callingController_:SetSelectedState("normal")

				local var_290_1 = arg_287_1:FormatText(arg_287_1:GetWordFromCfg(102601069).content)

				arg_287_1.text_.text = var_290_1

				LuaForUtil.ClearLinePrefixSymbol(arg_287_1.text_)

				local var_290_3 = 21 <= 0 and var_290_0 or var_290_0 * (utf8.len(var_290_1) / 21)

				if (21 <= 0 and var_290_0 or var_290_0 * (utf8.len(var_290_1) / 21)) > 0 and var_290_0 < var_290_3 then
					arg_287_1.talkMaxDuration = var_290_3

					if var_290_3 + 0 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_3 + 0
					end
				end

				arg_287_1.text_.text = var_290_1
				arg_287_1.typewritter.percent = 0

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(false)
				arg_287_1:RecordContent(arg_287_1.text_.text)
			end

			local var_290_4 = math.max(var_290_0, arg_287_1.talkMaxDuration)

			if 0 <= arg_287_1.time_ and arg_287_1.time_ < 0 + var_290_4 then
				arg_287_1.typewritter.percent = (arg_287_1.time_ - 0) / var_290_4

				arg_287_1.typewritter:SetDirty()
			end

			if arg_287_1.time_ >= 0 + var_290_4 and arg_287_1.time_ < 0 + var_290_4 + arg_290_0 then
				arg_287_1.typewritter.percent = 1

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(true)
			end
		end

		arg_287_1.nodeConfigList_ = {}

		arg_287_1:InitPlayNodeList()
	end,
	Play102601070 = function(arg_291_0, arg_291_1)
		arg_291_1.time_ = 0
		arg_291_1.frameCnt_ = 0
		arg_291_1.state_ = "playing"
		arg_291_1.curTalkId_ = 102601070
		arg_291_1.duration_ = 5

		SetActive(arg_291_1.tipsGo_, false)

		function arg_291_1.onSingleLineFinish_()
			arg_291_1.onSingleLineUpdate_ = nil
			arg_291_1.onSingleLineFinish_ = nil
			arg_291_1.state_ = "waiting"
		end

		function arg_291_1.playNext_(arg_293_0)
			if arg_293_0 == 1 then
				arg_291_0:Play102601071(arg_291_1)
			end
		end

		function arg_291_1.onSingleLineUpdate_(arg_294_0)
			local var_294_0 = 0.125

			if 0 < arg_291_1.time_ and arg_291_1.time_ <= 0 + arg_294_0 then
				arg_291_1.talkMaxDuration = 0
				arg_291_1.dialogCg_.alpha = 1

				arg_291_1.dialog_:SetActive(true)
				SetActive(arg_291_1.leftNameGo_, true)

				arg_291_1.leftNameTxt_.text = arg_291_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_291_1.leftNameTxt_.transform)

				arg_291_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_291_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_291_1:RecordName(arg_291_1.leftNameTxt_.text)
				SetActive(arg_291_1.iconTrs_.gameObject, true)
				arg_291_1.iconController_:SetSelectedState("hero")

				arg_291_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_291_1.callingController_:SetSelectedState("normal")

				arg_291_1.keyicon_.color = Color.New(1, 1, 1)
				arg_291_1.icon_.color = Color.New(1, 1, 1)

				local var_294_1 = arg_291_1:FormatText(arg_291_1:GetWordFromCfg(102601070).content)

				arg_291_1.text_.text = var_294_1

				LuaForUtil.ClearLinePrefixSymbol(arg_291_1.text_)

				local var_294_3 = 5 <= 0 and var_294_0 or var_294_0 * (utf8.len(var_294_1) / 5)

				if (5 <= 0 and var_294_0 or var_294_0 * (utf8.len(var_294_1) / 5)) > 0 and var_294_0 < var_294_3 then
					arg_291_1.talkMaxDuration = var_294_3

					if var_294_3 + 0 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_3 + 0
					end
				end

				arg_291_1.text_.text = var_294_1
				arg_291_1.typewritter.percent = 0

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(false)
				arg_291_1:RecordContent(arg_291_1.text_.text)
			end

			local var_294_4 = math.max(var_294_0, arg_291_1.talkMaxDuration)

			if 0 <= arg_291_1.time_ and arg_291_1.time_ < 0 + var_294_4 then
				arg_291_1.typewritter.percent = (arg_291_1.time_ - 0) / var_294_4

				arg_291_1.typewritter:SetDirty()
			end

			if arg_291_1.time_ >= 0 + var_294_4 and arg_291_1.time_ < 0 + var_294_4 + arg_294_0 then
				arg_291_1.typewritter.percent = 1

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(true)
			end
		end

		arg_291_1.nodeConfigList_ = {}

		arg_291_1:InitPlayNodeList()
	end,
	Play102601071 = function(arg_295_0, arg_295_1)
		arg_295_1.time_ = 0
		arg_295_1.frameCnt_ = 0
		arg_295_1.state_ = "playing"
		arg_295_1.curTalkId_ = 102601071
		arg_295_1.duration_ = 5

		SetActive(arg_295_1.tipsGo_, false)

		function arg_295_1.onSingleLineFinish_()
			arg_295_1.onSingleLineUpdate_ = nil
			arg_295_1.onSingleLineFinish_ = nil
			arg_295_1.state_ = "waiting"
		end

		function arg_295_1.playNext_(arg_297_0)
			if arg_297_0 == 1 then
				arg_295_0:Play102601072(arg_295_1)
			end
		end

		function arg_295_1.onSingleLineUpdate_(arg_298_0)
			local var_298_0 = 0.525

			if 0 < arg_295_1.time_ and arg_295_1.time_ <= 0 + arg_298_0 then
				arg_295_1.talkMaxDuration = 0
				arg_295_1.dialogCg_.alpha = 1

				arg_295_1.dialog_:SetActive(true)
				SetActive(arg_295_1.leftNameGo_, false)

				arg_295_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_295_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_295_1:RecordName(arg_295_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_295_1.iconTrs_.gameObject, false)
				arg_295_1.callingController_:SetSelectedState("normal")

				local var_298_1 = arg_295_1:FormatText(arg_295_1:GetWordFromCfg(102601071).content)

				arg_295_1.text_.text = var_298_1

				LuaForUtil.ClearLinePrefixSymbol(arg_295_1.text_)

				local var_298_3 = 21 <= 0 and var_298_0 or var_298_0 * (utf8.len(var_298_1) / 21)

				if (21 <= 0 and var_298_0 or var_298_0 * (utf8.len(var_298_1) / 21)) > 0 and var_298_0 < var_298_3 then
					arg_295_1.talkMaxDuration = var_298_3

					if var_298_3 + 0 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_3 + 0
					end
				end

				arg_295_1.text_.text = var_298_1
				arg_295_1.typewritter.percent = 0

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(false)
				arg_295_1:RecordContent(arg_295_1.text_.text)
			end

			local var_298_4 = math.max(var_298_0, arg_295_1.talkMaxDuration)

			if 0 <= arg_295_1.time_ and arg_295_1.time_ < 0 + var_298_4 then
				arg_295_1.typewritter.percent = (arg_295_1.time_ - 0) / var_298_4

				arg_295_1.typewritter:SetDirty()
			end

			if arg_295_1.time_ >= 0 + var_298_4 and arg_295_1.time_ < 0 + var_298_4 + arg_298_0 then
				arg_295_1.typewritter.percent = 1

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(true)
			end
		end

		arg_295_1.nodeConfigList_ = {}

		arg_295_1:InitPlayNodeList()
	end,
	Play102601072 = function(arg_299_0, arg_299_1)
		arg_299_1.time_ = 0
		arg_299_1.frameCnt_ = 0
		arg_299_1.state_ = "playing"
		arg_299_1.curTalkId_ = 102601072
		arg_299_1.duration_ = 5

		SetActive(arg_299_1.tipsGo_, false)

		function arg_299_1.onSingleLineFinish_()
			arg_299_1.onSingleLineUpdate_ = nil
			arg_299_1.onSingleLineFinish_ = nil
			arg_299_1.state_ = "waiting"
		end

		function arg_299_1.playNext_(arg_301_0)
			if arg_301_0 == 1 then
				arg_299_0:Play102601073(arg_299_1)
			end
		end

		function arg_299_1.onSingleLineUpdate_(arg_302_0)
			local var_302_0 = 0.2

			if 0 < arg_299_1.time_ and arg_299_1.time_ <= 0 + arg_302_0 then
				arg_299_1.talkMaxDuration = 0
				arg_299_1.dialogCg_.alpha = 1

				arg_299_1.dialog_:SetActive(true)
				SetActive(arg_299_1.leftNameGo_, true)

				arg_299_1.leftNameTxt_.text = arg_299_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_299_1.leftNameTxt_.transform)

				arg_299_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_299_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_299_1:RecordName(arg_299_1.leftNameTxt_.text)
				SetActive(arg_299_1.iconTrs_.gameObject, true)
				arg_299_1.iconController_:SetSelectedState("hero")

				arg_299_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_299_1.callingController_:SetSelectedState("normal")

				arg_299_1.keyicon_.color = Color.New(1, 1, 1)
				arg_299_1.icon_.color = Color.New(1, 1, 1)

				local var_302_1 = arg_299_1:FormatText(arg_299_1:GetWordFromCfg(102601072).content)

				arg_299_1.text_.text = var_302_1

				LuaForUtil.ClearLinePrefixSymbol(arg_299_1.text_)

				local var_302_3 = 8 <= 0 and var_302_0 or var_302_0 * (utf8.len(var_302_1) / 8)

				if (8 <= 0 and var_302_0 or var_302_0 * (utf8.len(var_302_1) / 8)) > 0 and var_302_0 < var_302_3 then
					arg_299_1.talkMaxDuration = var_302_3

					if var_302_3 + 0 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_3 + 0
					end
				end

				arg_299_1.text_.text = var_302_1
				arg_299_1.typewritter.percent = 0

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(false)
				arg_299_1:RecordContent(arg_299_1.text_.text)
			end

			local var_302_4 = math.max(var_302_0, arg_299_1.talkMaxDuration)

			if 0 <= arg_299_1.time_ and arg_299_1.time_ < 0 + var_302_4 then
				arg_299_1.typewritter.percent = (arg_299_1.time_ - 0) / var_302_4

				arg_299_1.typewritter:SetDirty()
			end

			if arg_299_1.time_ >= 0 + var_302_4 and arg_299_1.time_ < 0 + var_302_4 + arg_302_0 then
				arg_299_1.typewritter.percent = 1

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(true)
			end
		end

		arg_299_1.nodeConfigList_ = {}

		arg_299_1:InitPlayNodeList()
	end,
	Play102601073 = function(arg_303_0, arg_303_1)
		arg_303_1.time_ = 0
		arg_303_1.frameCnt_ = 0
		arg_303_1.state_ = "playing"
		arg_303_1.curTalkId_ = 102601073
		arg_303_1.duration_ = 5

		SetActive(arg_303_1.tipsGo_, false)

		function arg_303_1.onSingleLineFinish_()
			arg_303_1.onSingleLineUpdate_ = nil
			arg_303_1.onSingleLineFinish_ = nil
			arg_303_1.state_ = "waiting"
		end

		function arg_303_1.playNext_(arg_305_0)
			if arg_305_0 == 1 then
				arg_303_0:Play102601074(arg_303_1)
			end
		end

		function arg_303_1.onSingleLineUpdate_(arg_306_0)
			local var_306_0 = 0.85

			if 0 < arg_303_1.time_ and arg_303_1.time_ <= 0 + arg_306_0 then
				arg_303_1.talkMaxDuration = 0
				arg_303_1.dialogCg_.alpha = 1

				arg_303_1.dialog_:SetActive(true)
				SetActive(arg_303_1.leftNameGo_, false)

				arg_303_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_303_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_303_1:RecordName(arg_303_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_303_1.iconTrs_.gameObject, false)
				arg_303_1.callingController_:SetSelectedState("normal")

				local var_306_1 = arg_303_1:FormatText(arg_303_1:GetWordFromCfg(102601073).content)

				arg_303_1.text_.text = var_306_1

				LuaForUtil.ClearLinePrefixSymbol(arg_303_1.text_)

				local var_306_3 = 34 <= 0 and var_306_0 or var_306_0 * (utf8.len(var_306_1) / 34)

				if (34 <= 0 and var_306_0 or var_306_0 * (utf8.len(var_306_1) / 34)) > 0 and var_306_0 < var_306_3 then
					arg_303_1.talkMaxDuration = var_306_3

					if var_306_3 + 0 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_3 + 0
					end
				end

				arg_303_1.text_.text = var_306_1
				arg_303_1.typewritter.percent = 0

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(false)
				arg_303_1:RecordContent(arg_303_1.text_.text)
			end

			local var_306_4 = math.max(var_306_0, arg_303_1.talkMaxDuration)

			if 0 <= arg_303_1.time_ and arg_303_1.time_ < 0 + var_306_4 then
				arg_303_1.typewritter.percent = (arg_303_1.time_ - 0) / var_306_4

				arg_303_1.typewritter:SetDirty()
			end

			if arg_303_1.time_ >= 0 + var_306_4 and arg_303_1.time_ < 0 + var_306_4 + arg_306_0 then
				arg_303_1.typewritter.percent = 1

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(true)
			end
		end

		arg_303_1.nodeConfigList_ = {}

		arg_303_1:InitPlayNodeList()
	end,
	Play102601074 = function(arg_307_0, arg_307_1)
		arg_307_1.time_ = 0
		arg_307_1.frameCnt_ = 0
		arg_307_1.state_ = "playing"
		arg_307_1.curTalkId_ = 102601074
		arg_307_1.duration_ = 3.97

		local var_307_0 = {
			ja = 3.966,
			ko = 2.2,
			zh = 2.233,
			en = 2.266
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
				arg_307_0:Play102601075(arg_307_1)
			end
		end

		function arg_307_1.onSingleLineUpdate_(arg_310_0)
			if 0 < arg_307_1.time_ and arg_307_1.time_ <= 0 + arg_310_0 and not isNil(arg_307_1.actors_["1026ui_story"]) and arg_307_1.var_.characterEffect1026ui_story == nil then
				arg_307_1.var_.characterEffect1026ui_story = arg_307_1.actors_["1026ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_310_0 = 0.2

			if 0 <= arg_307_1.time_ and arg_307_1.time_ < 0 + var_310_0 and not isNil(arg_307_1.actors_["1026ui_story"]) then
				if arg_307_1.var_.characterEffect1026ui_story and not isNil(arg_307_1.actors_["1026ui_story"]) then
					arg_307_1.var_.characterEffect1026ui_story.fillFlat = false
				end
			end

			if arg_307_1.time_ >= 0 + var_310_0 and arg_307_1.time_ < 0 + var_310_0 + arg_310_0 and not isNil(arg_307_1.actors_["1026ui_story"]) and arg_307_1.var_.characterEffect1026ui_story then
				arg_307_1.var_.characterEffect1026ui_story.fillFlat = false
			end

			if 0 < arg_307_1.time_ and arg_307_1.time_ <= 0 + arg_310_0 then
				arg_307_1:PlayTimeline("1026ui_story", "StoryTimeline/CharAction/story1026/story1026action/1026action1_1")
			end

			if 0 < arg_307_1.time_ and arg_307_1.time_ <= 0 + arg_310_0 then
				arg_307_1:PlayTimeline("1026ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1204cva")
			end

			local var_310_2 = arg_307_1.actors_["1026ui_story"].transform

			if 0 < arg_307_1.time_ and arg_307_1.time_ <= 0 + arg_310_0 then
				arg_307_1.var_.moveOldPos1026ui_story = var_310_2.localPosition
			end

			local var_310_3 = 0.001

			if 0 <= arg_307_1.time_ and arg_307_1.time_ < 0 + var_310_3 then
				var_310_2.localPosition = Vector3.Lerp(arg_307_1.var_.moveOldPos1026ui_story, Vector3.New(0, -1.05, -6.2), (arg_307_1.time_ - 0) / var_310_3)
				var_310_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_310_2.position).x, (manager.ui.mainCamera.transform.position - var_310_2.position).y, (manager.ui.mainCamera.transform.position - var_310_2.position).z)
				var_310_2.localEulerAngles.z = 0
				var_310_2.localEulerAngles.x = 0
				var_310_2.localEulerAngles = var_310_2.localEulerAngles
			end

			if arg_307_1.time_ >= 0 + var_310_3 and arg_307_1.time_ < 0 + var_310_3 + arg_310_0 then
				var_310_2.localPosition = Vector3.New(0, -1.05, -6.2)
				var_310_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_310_2.position).x, (manager.ui.mainCamera.transform.position - var_310_2.position).y, (manager.ui.mainCamera.transform.position - var_310_2.position).z)
				var_310_2.localEulerAngles.z = 0
				var_310_2.localEulerAngles.x = 0
				var_310_2.localEulerAngles = var_310_2.localEulerAngles
			end

			local var_310_4 = 0
			local var_310_5 = 0.325

			if 0 < arg_307_1.time_ and arg_307_1.time_ <= var_310_4 + arg_310_0 then
				arg_307_1.talkMaxDuration = 0
				arg_307_1.dialogCg_.alpha = 1

				arg_307_1.dialog_:SetActive(true)
				SetActive(arg_307_1.leftNameGo_, true)

				arg_307_1.leftNameTxt_.text = arg_307_1:FormatText(StoryNameCfg[83].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_307_1.leftNameTxt_.transform)

				arg_307_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_307_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_307_1:RecordName(arg_307_1.leftNameTxt_.text)
				SetActive(arg_307_1.iconTrs_.gameObject, false)
				arg_307_1.callingController_:SetSelectedState("normal")

				local var_310_6 = arg_307_1:GetWordFromCfg(102601074)
				local var_310_7 = arg_307_1:FormatText(var_310_6.content)

				arg_307_1.text_.text = var_310_7

				LuaForUtil.ClearLinePrefixSymbol(arg_307_1.text_)

				local var_310_9 = 13 <= 0 and var_310_5 or var_310_5 * (utf8.len(var_310_7) / 13)

				if (13 <= 0 and var_310_5 or var_310_5 * (utf8.len(var_310_7) / 13)) > 0 and var_310_5 < var_310_9 then
					arg_307_1.talkMaxDuration = var_310_9

					if var_310_9 + var_310_4 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_9 + var_310_4
					end
				end

				arg_307_1.text_.text = var_310_7
				arg_307_1.typewritter.percent = 0

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_102601", "102601074", "story_v_side_old_102601.awb") ~= 0 then
					local var_310_10 = manager.audio:GetVoiceLength("story_v_side_old_102601", "102601074", "story_v_side_old_102601.awb") / 1000

					if var_310_10 + var_310_4 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_10 + var_310_4
					end

					if var_310_6.prefab_name ~= "" and arg_307_1.actors_[var_310_6.prefab_name] ~= nil then
						local var_310_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_307_1.actors_[var_310_6.prefab_name].transform, "story_v_side_old_102601", "102601074", "story_v_side_old_102601.awb")

						arg_307_1:RecordAudio("102601074", var_310_11)
						arg_307_1:RecordAudio("102601074", var_310_11)
					else
						arg_307_1:AudioAction("play", "voice", "story_v_side_old_102601", "102601074", "story_v_side_old_102601.awb")
					end

					arg_307_1:RecordHistoryTalkVoice("story_v_side_old_102601", "102601074", "story_v_side_old_102601.awb")
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
				actorName = "1026ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_307_1:InitPlayNodeList()
	end,
	Play102601075 = function(arg_311_0, arg_311_1)
		arg_311_1.time_ = 0
		arg_311_1.frameCnt_ = 0
		arg_311_1.state_ = "playing"
		arg_311_1.curTalkId_ = 102601075
		arg_311_1.duration_ = 5

		local var_311_0 = {
			ja = 5,
			ko = 3.766,
			zh = 3.466,
			en = 3.833
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
				arg_311_0:Play102601076(arg_311_1)
			end
		end

		function arg_311_1.onSingleLineUpdate_(arg_314_0)
			if 0 < arg_311_1.time_ and arg_311_1.time_ <= 0 + arg_314_0 then
				arg_311_1:PlayTimeline("1026ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			if 0 < arg_311_1.time_ and arg_311_1.time_ <= 0 + arg_314_0 then
				arg_311_1:PlayTimeline("1026ui_story", "StoryTimeline/CharAction/story1026/story1026action/1026action7_1")
			end

			local var_314_0 = 0
			local var_314_1 = 0.5

			if 0 < arg_311_1.time_ and arg_311_1.time_ <= var_314_0 + arg_314_0 then
				arg_311_1.talkMaxDuration = 0
				arg_311_1.dialogCg_.alpha = 1

				arg_311_1.dialog_:SetActive(true)
				SetActive(arg_311_1.leftNameGo_, true)

				arg_311_1.leftNameTxt_.text = arg_311_1:FormatText(StoryNameCfg[83].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_311_1.leftNameTxt_.transform)

				arg_311_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_311_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_311_1:RecordName(arg_311_1.leftNameTxt_.text)
				SetActive(arg_311_1.iconTrs_.gameObject, false)
				arg_311_1.callingController_:SetSelectedState("normal")

				local var_314_2 = arg_311_1:GetWordFromCfg(102601075)
				local var_314_3 = arg_311_1:FormatText(var_314_2.content)

				arg_311_1.text_.text = var_314_3

				LuaForUtil.ClearLinePrefixSymbol(arg_311_1.text_)

				local var_314_5 = 20 <= 0 and var_314_1 or var_314_1 * (utf8.len(var_314_3) / 20)

				if (20 <= 0 and var_314_1 or var_314_1 * (utf8.len(var_314_3) / 20)) > 0 and var_314_1 < var_314_5 then
					arg_311_1.talkMaxDuration = var_314_5

					if var_314_5 + var_314_0 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_5 + var_314_0
					end
				end

				arg_311_1.text_.text = var_314_3
				arg_311_1.typewritter.percent = 0

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_102601", "102601075", "story_v_side_old_102601.awb") ~= 0 then
					local var_314_6 = manager.audio:GetVoiceLength("story_v_side_old_102601", "102601075", "story_v_side_old_102601.awb") / 1000

					if var_314_6 + var_314_0 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_6 + var_314_0
					end

					if var_314_2.prefab_name ~= "" and arg_311_1.actors_[var_314_2.prefab_name] ~= nil then
						local var_314_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_311_1.actors_[var_314_2.prefab_name].transform, "story_v_side_old_102601", "102601075", "story_v_side_old_102601.awb")

						arg_311_1:RecordAudio("102601075", var_314_7)
						arg_311_1:RecordAudio("102601075", var_314_7)
					else
						arg_311_1:AudioAction("play", "voice", "story_v_side_old_102601", "102601075", "story_v_side_old_102601.awb")
					end

					arg_311_1:RecordHistoryTalkVoice("story_v_side_old_102601", "102601075", "story_v_side_old_102601.awb")
				end

				arg_311_1:RecordContent(arg_311_1.text_.text)
			end

			local var_314_8 = math.max(var_314_1, arg_311_1.talkMaxDuration)

			if var_314_0 <= arg_311_1.time_ and arg_311_1.time_ < var_314_0 + var_314_8 then
				arg_311_1.typewritter.percent = (arg_311_1.time_ - var_314_0) / var_314_8

				arg_311_1.typewritter:SetDirty()
			end

			if arg_311_1.time_ >= var_314_0 + var_314_8 and arg_311_1.time_ < var_314_0 + var_314_8 + arg_314_0 then
				arg_311_1.typewritter.percent = 1

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(true)
			end
		end

		arg_311_1.nodeConfigList_ = {}

		arg_311_1:InitPlayNodeList()
	end,
	Play102601076 = function(arg_315_0, arg_315_1)
		arg_315_1.time_ = 0
		arg_315_1.frameCnt_ = 0
		arg_315_1.state_ = "playing"
		arg_315_1.curTalkId_ = 102601076
		arg_315_1.duration_ = 5

		SetActive(arg_315_1.tipsGo_, false)

		function arg_315_1.onSingleLineFinish_()
			arg_315_1.onSingleLineUpdate_ = nil
			arg_315_1.onSingleLineFinish_ = nil
			arg_315_1.state_ = "waiting"
		end

		function arg_315_1.playNext_(arg_317_0)
			if arg_317_0 == 1 then
				arg_315_0:Play102601077(arg_315_1)
			end
		end

		function arg_315_1.onSingleLineUpdate_(arg_318_0)
			if 0 < arg_315_1.time_ and arg_315_1.time_ <= 0 + arg_318_0 and not isNil(arg_315_1.actors_["1026ui_story"]) and arg_315_1.var_.characterEffect1026ui_story == nil then
				arg_315_1.var_.characterEffect1026ui_story = arg_315_1.actors_["1026ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_318_0 = 0.2

			if 0 <= arg_315_1.time_ and arg_315_1.time_ < 0 + var_318_0 and not isNil(arg_315_1.actors_["1026ui_story"]) then
				if arg_315_1.var_.characterEffect1026ui_story and not isNil(arg_315_1.actors_["1026ui_story"]) then
					arg_315_1.var_.characterEffect1026ui_story.fillFlat = true
					arg_315_1.var_.characterEffect1026ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_315_1.time_ - 0) / var_318_0)
				end
			end

			if arg_315_1.time_ >= 0 + var_318_0 and arg_315_1.time_ < 0 + var_318_0 + arg_318_0 and not isNil(arg_315_1.actors_["1026ui_story"]) and arg_315_1.var_.characterEffect1026ui_story then
				arg_315_1.var_.characterEffect1026ui_story.fillFlat = true
				arg_315_1.var_.characterEffect1026ui_story.fillRatio = 0.5
			end

			local var_318_1 = 0
			local var_318_2 = 0.2

			if 0 < arg_315_1.time_ and arg_315_1.time_ <= var_318_1 + arg_318_0 then
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

				local var_318_3 = arg_315_1:FormatText(arg_315_1:GetWordFromCfg(102601076).content)

				arg_315_1.text_.text = var_318_3

				LuaForUtil.ClearLinePrefixSymbol(arg_315_1.text_)

				local var_318_5 = 8 <= 0 and var_318_2 or var_318_2 * (utf8.len(var_318_3) / 8)

				if (8 <= 0 and var_318_2 or var_318_2 * (utf8.len(var_318_3) / 8)) > 0 and var_318_2 < var_318_5 then
					arg_315_1.talkMaxDuration = var_318_5

					if var_318_5 + var_318_1 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_5 + var_318_1
					end
				end

				arg_315_1.text_.text = var_318_3
				arg_315_1.typewritter.percent = 0

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(false)
				arg_315_1:RecordContent(arg_315_1.text_.text)
			end

			local var_318_6 = math.max(var_318_2, arg_315_1.talkMaxDuration)

			if var_318_1 <= arg_315_1.time_ and arg_315_1.time_ < var_318_1 + var_318_6 then
				arg_315_1.typewritter.percent = (arg_315_1.time_ - var_318_1) / var_318_6

				arg_315_1.typewritter:SetDirty()
			end

			if arg_315_1.time_ >= var_318_1 + var_318_6 and arg_315_1.time_ < var_318_1 + var_318_6 + arg_318_0 then
				arg_315_1.typewritter.percent = 1

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(true)
			end
		end

		arg_315_1.nodeConfigList_ = {}

		arg_315_1:InitPlayNodeList()
	end,
	Play102601077 = function(arg_319_0, arg_319_1)
		arg_319_1.time_ = 0
		arg_319_1.frameCnt_ = 0
		arg_319_1.state_ = "playing"
		arg_319_1.curTalkId_ = 102601077
		arg_319_1.duration_ = 7.63

		SetActive(arg_319_1.tipsGo_, false)

		function arg_319_1.onSingleLineFinish_()
			arg_319_1.onSingleLineUpdate_ = nil
			arg_319_1.onSingleLineFinish_ = nil
			arg_319_1.state_ = "waiting"
		end

		function arg_319_1.playNext_(arg_321_0)
			if arg_321_0 == 1 then
				arg_319_0:Play102601078(arg_319_1)
			end
		end

		function arg_319_1.onSingleLineUpdate_(arg_322_0)
			if 0 < arg_319_1.time_ and arg_319_1.time_ <= 0 + arg_322_0 then
				local var_322_0 = arg_319_1.bgs_.ST13:GetComponent("SpriteRenderer")

				if var_322_0 then
					arg_319_1.var_.alphaOldValueST13 = var_322_0.color.a
					arg_319_1.var_.alphaMatValueST13 = var_322_0
				end

				arg_319_1.var_.alphaOldValueST13 = 1
			end

			local var_322_1 = 1.5

			if 0 <= arg_319_1.time_ and arg_319_1.time_ < 0 + var_322_1 then
				if arg_319_1.var_.alphaMatValueST13 then
					arg_319_1.var_.alphaMatValueST13.color.a = Mathf.Lerp(arg_319_1.var_.alphaOldValueST13, 0, (arg_319_1.time_ - 0) / var_322_1)
					arg_319_1.var_.alphaMatValueST13.color = arg_319_1.var_.alphaMatValueST13.color
				end
			end

			if arg_319_1.time_ >= 0 + var_322_1 and arg_319_1.time_ < 0 + var_322_1 + arg_322_0 and arg_319_1.var_.alphaMatValueST13 then
				arg_319_1.var_.alphaMatValueST13.color.a = 0
				arg_319_1.var_.alphaMatValueST13.color = arg_319_1.var_.alphaMatValueST13.color
			end

			if 1.83333333333333 < arg_319_1.time_ and arg_319_1.time_ <= 1.83333333333333 + arg_322_0 then
				local var_322_2 = arg_319_1.bgs_.ST13:GetComponent("SpriteRenderer")

				if var_322_2 then
					arg_319_1.var_.alphaOldValueST13 = var_322_2.color.a
					arg_319_1.var_.alphaMatValueST13 = var_322_2
				end

				arg_319_1.var_.alphaOldValueST13 = 0
			end

			local var_322_3 = 1.5

			if 1.83333333333333 <= arg_319_1.time_ and arg_319_1.time_ < 1.83333333333333 + var_322_3 then
				if arg_319_1.var_.alphaMatValueST13 then
					arg_319_1.var_.alphaMatValueST13.color.a = Mathf.Lerp(arg_319_1.var_.alphaOldValueST13, 1, (arg_319_1.time_ - 1.83333333333333) / var_322_3)
					arg_319_1.var_.alphaMatValueST13.color = arg_319_1.var_.alphaMatValueST13.color
				end
			end

			if arg_319_1.time_ >= 1.83333333333333 + var_322_3 and arg_319_1.time_ < 1.83333333333333 + var_322_3 + arg_322_0 and arg_319_1.var_.alphaMatValueST13 then
				arg_319_1.var_.alphaMatValueST13.color.a = 1
				arg_319_1.var_.alphaMatValueST13.color = arg_319_1.var_.alphaMatValueST13.color
			end

			local var_322_4 = arg_319_1.actors_["1026ui_story"].transform

			if 0 < arg_319_1.time_ and arg_319_1.time_ <= 0 + arg_322_0 then
				arg_319_1.var_.moveOldPos1026ui_story = var_322_4.localPosition
			end

			local var_322_5 = 0.001

			if 0 <= arg_319_1.time_ and arg_319_1.time_ < 0 + var_322_5 then
				var_322_4.localPosition = Vector3.Lerp(arg_319_1.var_.moveOldPos1026ui_story, Vector3.New(0, 100, 0), (arg_319_1.time_ - 0) / var_322_5)
				var_322_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_322_4.position).x, (manager.ui.mainCamera.transform.position - var_322_4.position).y, (manager.ui.mainCamera.transform.position - var_322_4.position).z)
				var_322_4.localEulerAngles.z = 0
				var_322_4.localEulerAngles.x = 0
				var_322_4.localEulerAngles = var_322_4.localEulerAngles
			end

			if arg_319_1.time_ >= 0 + var_322_5 and arg_319_1.time_ < 0 + var_322_5 + arg_322_0 then
				var_322_4.localPosition = Vector3.New(0, 100, 0)
				var_322_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_322_4.position).x, (manager.ui.mainCamera.transform.position - var_322_4.position).y, (manager.ui.mainCamera.transform.position - var_322_4.position).z)
				var_322_4.localEulerAngles.z = 0
				var_322_4.localEulerAngles.x = 0
				var_322_4.localEulerAngles = var_322_4.localEulerAngles
			end

			local var_322_6 = 0

			if 0 < arg_319_1.time_ and arg_319_1.time_ <= var_322_6 + arg_322_0 then
				arg_319_1.allBtn_.enabled = false
			end

			if arg_319_1.time_ >= var_322_6 + 2.63333333333333 and arg_319_1.time_ < var_322_6 + 2.63333333333333 + arg_322_0 then
				arg_319_1.allBtn_.enabled = true
			end

			if arg_319_1.frameCnt_ <= 1 then
				arg_319_1.dialog_:SetActive(false)
			end

			local var_322_7 = 2.63333333333333
			local var_322_8 = 0.7

			if 2.63333333333333 < arg_319_1.time_ and arg_319_1.time_ <= var_322_7 + arg_322_0 then
				arg_319_1.talkMaxDuration = 0

				arg_319_1.dialog_:SetActive(true)

				arg_319_1.dialogCg_.alpha = 0

				local var_322_9 = LeanTween.value(arg_319_1.dialog_, 0, 1, 0.3)

				var_322_9:setOnUpdate(LuaHelper.FloatAction(function(arg_323_0)
					arg_319_1.dialogCg_.alpha = arg_323_0
				end))
				var_322_9:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_319_1.dialog_)
					var_322_9:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_319_1.duration_ = arg_319_1.duration_ + 0.3

				SetActive(arg_319_1.leftNameGo_, false)

				arg_319_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_319_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_319_1:RecordName(arg_319_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_319_1.iconTrs_.gameObject, false)
				arg_319_1.callingController_:SetSelectedState("normal")

				local var_322_10 = arg_319_1:FormatText(arg_319_1:GetWordFromCfg(102601077).content)

				arg_319_1.text_.text = var_322_10

				LuaForUtil.ClearLinePrefixSymbol(arg_319_1.text_)

				local var_322_12 = 28 <= 0 and var_322_8 or var_322_8 * (utf8.len(var_322_10) / 28)

				if (28 <= 0 and var_322_8 or var_322_8 * (utf8.len(var_322_10) / 28)) > 0 and var_322_8 < var_322_12 then
					arg_319_1.talkMaxDuration = var_322_12
					var_322_7 = var_322_7 + 0.3

					if var_322_12 + var_322_7 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_12 + var_322_7
					end
				end

				arg_319_1.text_.text = var_322_10
				arg_319_1.typewritter.percent = 0

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(false)
				arg_319_1:RecordContent(arg_319_1.text_.text)
			end

			local var_322_13 = var_322_7 + 0.3
			local var_322_14 = math.max(var_322_8, arg_319_1.talkMaxDuration)

			if var_322_7 + 0.3 <= arg_319_1.time_ and arg_319_1.time_ < var_322_13 + var_322_14 then
				arg_319_1.typewritter.percent = (arg_319_1.time_ - var_322_13) / var_322_14

				arg_319_1.typewritter:SetDirty()
			end

			if arg_319_1.time_ >= var_322_13 + var_322_14 and arg_319_1.time_ < var_322_13 + var_322_14 + arg_322_0 then
				arg_319_1.typewritter.percent = 1

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(true)
			end
		end

		arg_319_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1026ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_319_1:InitPlayNodeList()
	end,
	Play102601078 = function(arg_325_0, arg_325_1)
		arg_325_1.time_ = 0
		arg_325_1.frameCnt_ = 0
		arg_325_1.state_ = "playing"
		arg_325_1.curTalkId_ = 102601078
		arg_325_1.duration_ = 5

		SetActive(arg_325_1.tipsGo_, false)

		function arg_325_1.onSingleLineFinish_()
			arg_325_1.onSingleLineUpdate_ = nil
			arg_325_1.onSingleLineFinish_ = nil
			arg_325_1.state_ = "waiting"
		end

		function arg_325_1.playNext_(arg_327_0)
			if arg_327_0 == 1 then
				arg_325_0:Play102601079(arg_325_1)
			end
		end

		function arg_325_1.onSingleLineUpdate_(arg_328_0)
			local var_328_0 = 0.75

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= 0 + arg_328_0 then
				arg_325_1.talkMaxDuration = 0
				arg_325_1.dialogCg_.alpha = 1

				arg_325_1.dialog_:SetActive(true)
				SetActive(arg_325_1.leftNameGo_, false)

				arg_325_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_325_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_325_1:RecordName(arg_325_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_325_1.iconTrs_.gameObject, false)
				arg_325_1.callingController_:SetSelectedState("normal")

				local var_328_1 = arg_325_1:FormatText(arg_325_1:GetWordFromCfg(102601078).content)

				arg_325_1.text_.text = var_328_1

				LuaForUtil.ClearLinePrefixSymbol(arg_325_1.text_)

				local var_328_3 = 30 <= 0 and var_328_0 or var_328_0 * (utf8.len(var_328_1) / 30)

				if (30 <= 0 and var_328_0 or var_328_0 * (utf8.len(var_328_1) / 30)) > 0 and var_328_0 < var_328_3 then
					arg_325_1.talkMaxDuration = var_328_3

					if var_328_3 + 0 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_3 + 0
					end
				end

				arg_325_1.text_.text = var_328_1
				arg_325_1.typewritter.percent = 0

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(false)
				arg_325_1:RecordContent(arg_325_1.text_.text)
			end

			local var_328_4 = math.max(var_328_0, arg_325_1.talkMaxDuration)

			if 0 <= arg_325_1.time_ and arg_325_1.time_ < 0 + var_328_4 then
				arg_325_1.typewritter.percent = (arg_325_1.time_ - 0) / var_328_4

				arg_325_1.typewritter:SetDirty()
			end

			if arg_325_1.time_ >= 0 + var_328_4 and arg_325_1.time_ < 0 + var_328_4 + arg_328_0 then
				arg_325_1.typewritter.percent = 1

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(true)
			end
		end

		arg_325_1.nodeConfigList_ = {}

		arg_325_1:InitPlayNodeList()
	end,
	Play102601079 = function(arg_329_0, arg_329_1)
		arg_329_1.time_ = 0
		arg_329_1.frameCnt_ = 0
		arg_329_1.state_ = "playing"
		arg_329_1.curTalkId_ = 102601079
		arg_329_1.duration_ = 5

		SetActive(arg_329_1.tipsGo_, false)

		function arg_329_1.onSingleLineFinish_()
			arg_329_1.onSingleLineUpdate_ = nil
			arg_329_1.onSingleLineFinish_ = nil
			arg_329_1.state_ = "waiting"
		end

		function arg_329_1.playNext_(arg_331_0)
			if arg_331_0 == 1 then
				arg_329_0:Play102601080(arg_329_1)
			end
		end

		function arg_329_1.onSingleLineUpdate_(arg_332_0)
			local var_332_0 = 0.35

			if 0 < arg_329_1.time_ and arg_329_1.time_ <= 0 + arg_332_0 then
				arg_329_1.talkMaxDuration = 0
				arg_329_1.dialogCg_.alpha = 1

				arg_329_1.dialog_:SetActive(true)
				SetActive(arg_329_1.leftNameGo_, false)

				arg_329_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_329_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_329_1:RecordName(arg_329_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_329_1.iconTrs_.gameObject, false)
				arg_329_1.callingController_:SetSelectedState("normal")

				local var_332_1 = arg_329_1:FormatText(arg_329_1:GetWordFromCfg(102601079).content)

				arg_329_1.text_.text = var_332_1

				LuaForUtil.ClearLinePrefixSymbol(arg_329_1.text_)

				local var_332_3 = 14 <= 0 and var_332_0 or var_332_0 * (utf8.len(var_332_1) / 14)

				if (14 <= 0 and var_332_0 or var_332_0 * (utf8.len(var_332_1) / 14)) > 0 and var_332_0 < var_332_3 then
					arg_329_1.talkMaxDuration = var_332_3

					if var_332_3 + 0 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_3 + 0
					end
				end

				arg_329_1.text_.text = var_332_1
				arg_329_1.typewritter.percent = 0

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(false)
				arg_329_1:RecordContent(arg_329_1.text_.text)
			end

			local var_332_4 = math.max(var_332_0, arg_329_1.talkMaxDuration)

			if 0 <= arg_329_1.time_ and arg_329_1.time_ < 0 + var_332_4 then
				arg_329_1.typewritter.percent = (arg_329_1.time_ - 0) / var_332_4

				arg_329_1.typewritter:SetDirty()
			end

			if arg_329_1.time_ >= 0 + var_332_4 and arg_329_1.time_ < 0 + var_332_4 + arg_332_0 then
				arg_329_1.typewritter.percent = 1

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(true)
			end
		end

		arg_329_1.nodeConfigList_ = {}

		arg_329_1:InitPlayNodeList()
	end,
	Play102601080 = function(arg_333_0, arg_333_1)
		arg_333_1.time_ = 0
		arg_333_1.frameCnt_ = 0
		arg_333_1.state_ = "playing"
		arg_333_1.curTalkId_ = 102601080
		arg_333_1.duration_ = 3.93

		local var_333_0 = {
			ja = 3.933,
			ko = 3,
			zh = 2.766,
			en = 2.866
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
				arg_333_0:Play102601081(arg_333_1)
			end
		end

		function arg_333_1.onSingleLineUpdate_(arg_336_0)
			if 0 < arg_333_1.time_ and arg_333_1.time_ <= 0 + arg_336_0 then
				arg_333_1:PlayTimeline("1026ui_story", "StoryTimeline/CharAction/story1026/story1026action/1026action7_1")
			end

			if 0 < arg_333_1.time_ and arg_333_1.time_ <= 0 + arg_336_0 then
				arg_333_1:PlayTimeline("1026ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_336_0 = arg_333_1.actors_["1026ui_story"].transform

			if 0 < arg_333_1.time_ and arg_333_1.time_ <= 0 + arg_336_0 then
				arg_333_1.var_.moveOldPos1026ui_story = var_336_0.localPosition
			end

			local var_336_1 = 0.001

			if 0 <= arg_333_1.time_ and arg_333_1.time_ < 0 + var_336_1 then
				var_336_0.localPosition = Vector3.Lerp(arg_333_1.var_.moveOldPos1026ui_story, Vector3.New(0, -1.05, -6.2), (arg_333_1.time_ - 0) / var_336_1)
				var_336_0.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_336_0.position).x, (manager.ui.mainCamera.transform.position - var_336_0.position).y, (manager.ui.mainCamera.transform.position - var_336_0.position).z)
				var_336_0.localEulerAngles.z = 0
				var_336_0.localEulerAngles.x = 0
				var_336_0.localEulerAngles = var_336_0.localEulerAngles
			end

			if arg_333_1.time_ >= 0 + var_336_1 and arg_333_1.time_ < 0 + var_336_1 + arg_336_0 then
				var_336_0.localPosition = Vector3.New(0, -1.05, -6.2)
				var_336_0.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_336_0.position).x, (manager.ui.mainCamera.transform.position - var_336_0.position).y, (manager.ui.mainCamera.transform.position - var_336_0.position).z)
				var_336_0.localEulerAngles.z = 0
				var_336_0.localEulerAngles.x = 0
				var_336_0.localEulerAngles = var_336_0.localEulerAngles
			end

			local var_336_2 = arg_333_1.actors_["1026ui_story"]

			if 0 < arg_333_1.time_ and arg_333_1.time_ <= 0 + arg_336_0 and not isNil(var_336_2) and arg_333_1.var_.characterEffect1026ui_story == nil then
				arg_333_1.var_.characterEffect1026ui_story = var_336_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_336_3 = 0.2

			if 0 <= arg_333_1.time_ and arg_333_1.time_ < 0 + var_336_3 and not isNil(var_336_2) then
				if arg_333_1.var_.characterEffect1026ui_story and not isNil(var_336_2) then
					arg_333_1.var_.characterEffect1026ui_story.fillFlat = false
				end
			end

			if arg_333_1.time_ >= 0 + var_336_3 and arg_333_1.time_ < 0 + var_336_3 + arg_336_0 and not isNil(var_336_2) and arg_333_1.var_.characterEffect1026ui_story then
				arg_333_1.var_.characterEffect1026ui_story.fillFlat = false
			end

			local var_336_5 = 0
			local var_336_6 = 0.425

			if 0 < arg_333_1.time_ and arg_333_1.time_ <= var_336_5 + arg_336_0 then
				arg_333_1.talkMaxDuration = 0
				arg_333_1.dialogCg_.alpha = 1

				arg_333_1.dialog_:SetActive(true)
				SetActive(arg_333_1.leftNameGo_, true)

				arg_333_1.leftNameTxt_.text = arg_333_1:FormatText(StoryNameCfg[83].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_333_1.leftNameTxt_.transform)

				arg_333_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_333_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_333_1:RecordName(arg_333_1.leftNameTxt_.text)
				SetActive(arg_333_1.iconTrs_.gameObject, false)
				arg_333_1.callingController_:SetSelectedState("normal")

				local var_336_7 = arg_333_1:GetWordFromCfg(102601080)
				local var_336_8 = arg_333_1:FormatText(var_336_7.content)

				arg_333_1.text_.text = var_336_8

				LuaForUtil.ClearLinePrefixSymbol(arg_333_1.text_)

				local var_336_10 = 17 <= 0 and var_336_6 or var_336_6 * (utf8.len(var_336_8) / 17)

				if (17 <= 0 and var_336_6 or var_336_6 * (utf8.len(var_336_8) / 17)) > 0 and var_336_6 < var_336_10 then
					arg_333_1.talkMaxDuration = var_336_10

					if var_336_10 + var_336_5 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_10 + var_336_5
					end
				end

				arg_333_1.text_.text = var_336_8
				arg_333_1.typewritter.percent = 0

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_102601", "102601080", "story_v_side_old_102601.awb") ~= 0 then
					local var_336_11 = manager.audio:GetVoiceLength("story_v_side_old_102601", "102601080", "story_v_side_old_102601.awb") / 1000

					if var_336_11 + var_336_5 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_11 + var_336_5
					end

					if var_336_7.prefab_name ~= "" and arg_333_1.actors_[var_336_7.prefab_name] ~= nil then
						local var_336_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_333_1.actors_[var_336_7.prefab_name].transform, "story_v_side_old_102601", "102601080", "story_v_side_old_102601.awb")

						arg_333_1:RecordAudio("102601080", var_336_12)
						arg_333_1:RecordAudio("102601080", var_336_12)
					else
						arg_333_1:AudioAction("play", "voice", "story_v_side_old_102601", "102601080", "story_v_side_old_102601.awb")
					end

					arg_333_1:RecordHistoryTalkVoice("story_v_side_old_102601", "102601080", "story_v_side_old_102601.awb")
				end

				arg_333_1:RecordContent(arg_333_1.text_.text)
			end

			local var_336_13 = math.max(var_336_6, arg_333_1.talkMaxDuration)

			if var_336_5 <= arg_333_1.time_ and arg_333_1.time_ < var_336_5 + var_336_13 then
				arg_333_1.typewritter.percent = (arg_333_1.time_ - var_336_5) / var_336_13

				arg_333_1.typewritter:SetDirty()
			end

			if arg_333_1.time_ >= var_336_5 + var_336_13 and arg_333_1.time_ < var_336_5 + var_336_13 + arg_336_0 then
				arg_333_1.typewritter.percent = 1

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(true)
			end
		end

		arg_333_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1026ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_333_1:InitPlayNodeList()
	end,
	Play102601081 = function(arg_337_0, arg_337_1)
		arg_337_1.time_ = 0
		arg_337_1.frameCnt_ = 0
		arg_337_1.state_ = "playing"
		arg_337_1.curTalkId_ = 102601081
		arg_337_1.duration_ = 5

		SetActive(arg_337_1.tipsGo_, false)

		function arg_337_1.onSingleLineFinish_()
			arg_337_1.onSingleLineUpdate_ = nil
			arg_337_1.onSingleLineFinish_ = nil
			arg_337_1.state_ = "waiting"
		end

		function arg_337_1.playNext_(arg_339_0)
			if arg_339_0 == 1 then
				arg_337_0:Play102601082(arg_337_1)
			end
		end

		function arg_337_1.onSingleLineUpdate_(arg_340_0)
			if 0 < arg_337_1.time_ and arg_337_1.time_ <= 0 + arg_340_0 and not isNil(arg_337_1.actors_["1026ui_story"]) and arg_337_1.var_.characterEffect1026ui_story == nil then
				arg_337_1.var_.characterEffect1026ui_story = arg_337_1.actors_["1026ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_340_0 = 0.2

			if 0 <= arg_337_1.time_ and arg_337_1.time_ < 0 + var_340_0 and not isNil(arg_337_1.actors_["1026ui_story"]) then
				if arg_337_1.var_.characterEffect1026ui_story and not isNil(arg_337_1.actors_["1026ui_story"]) then
					arg_337_1.var_.characterEffect1026ui_story.fillFlat = true
					arg_337_1.var_.characterEffect1026ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_337_1.time_ - 0) / var_340_0)
				end
			end

			if arg_337_1.time_ >= 0 + var_340_0 and arg_337_1.time_ < 0 + var_340_0 + arg_340_0 and not isNil(arg_337_1.actors_["1026ui_story"]) and arg_337_1.var_.characterEffect1026ui_story then
				arg_337_1.var_.characterEffect1026ui_story.fillFlat = true
				arg_337_1.var_.characterEffect1026ui_story.fillRatio = 0.5
			end

			local var_340_1 = 0
			local var_340_2 = 0.05

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

				local var_340_3 = arg_337_1:FormatText(arg_337_1:GetWordFromCfg(102601081).content)

				arg_337_1.text_.text = var_340_3

				LuaForUtil.ClearLinePrefixSymbol(arg_337_1.text_)

				local var_340_5 = 2 <= 0 and var_340_2 or var_340_2 * (utf8.len(var_340_3) / 2)

				if (2 <= 0 and var_340_2 or var_340_2 * (utf8.len(var_340_3) / 2)) > 0 and var_340_2 < var_340_5 then
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
	Play102601082 = function(arg_341_0, arg_341_1)
		arg_341_1.time_ = 0
		arg_341_1.frameCnt_ = 0
		arg_341_1.state_ = "playing"
		arg_341_1.curTalkId_ = 102601082
		arg_341_1.duration_ = 5.87

		local var_341_0 = {
			ja = 5.866,
			ko = 4.466,
			zh = 3.5,
			en = 4.133
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
				arg_341_0:Play102601083(arg_341_1)
			end
		end

		function arg_341_1.onSingleLineUpdate_(arg_344_0)
			if 0 < arg_341_1.time_ and arg_341_1.time_ <= 0 + arg_344_0 then
				arg_341_1:PlayTimeline("1026ui_story", "StoryTimeline/CharAction/story1026/story1026action/1026action7_2")
			end

			if 0 < arg_341_1.time_ and arg_341_1.time_ <= 0 + arg_344_0 then
				arg_341_1:PlayTimeline("1026ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_344_0 = arg_341_1.actors_["1026ui_story"]

			if 0 < arg_341_1.time_ and arg_341_1.time_ <= 0 + arg_344_0 and not isNil(var_344_0) and arg_341_1.var_.characterEffect1026ui_story == nil then
				arg_341_1.var_.characterEffect1026ui_story = var_344_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_344_1 = 0.2

			if 0 <= arg_341_1.time_ and arg_341_1.time_ < 0 + var_344_1 and not isNil(var_344_0) then
				if arg_341_1.var_.characterEffect1026ui_story and not isNil(var_344_0) then
					arg_341_1.var_.characterEffect1026ui_story.fillFlat = false
				end
			end

			if arg_341_1.time_ >= 0 + var_344_1 and arg_341_1.time_ < 0 + var_344_1 + arg_344_0 and not isNil(var_344_0) and arg_341_1.var_.characterEffect1026ui_story then
				arg_341_1.var_.characterEffect1026ui_story.fillFlat = false
			end

			local var_344_3 = 0
			local var_344_4 = 0.525

			if 0 < arg_341_1.time_ and arg_341_1.time_ <= var_344_3 + arg_344_0 then
				arg_341_1.talkMaxDuration = 0
				arg_341_1.dialogCg_.alpha = 1

				arg_341_1.dialog_:SetActive(true)
				SetActive(arg_341_1.leftNameGo_, true)

				arg_341_1.leftNameTxt_.text = arg_341_1:FormatText(StoryNameCfg[83].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_341_1.leftNameTxt_.transform)

				arg_341_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_341_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_341_1:RecordName(arg_341_1.leftNameTxt_.text)
				SetActive(arg_341_1.iconTrs_.gameObject, false)
				arg_341_1.callingController_:SetSelectedState("normal")

				local var_344_5 = arg_341_1:GetWordFromCfg(102601082)
				local var_344_6 = arg_341_1:FormatText(var_344_5.content)

				arg_341_1.text_.text = var_344_6

				LuaForUtil.ClearLinePrefixSymbol(arg_341_1.text_)

				local var_344_8 = 21 <= 0 and var_344_4 or var_344_4 * (utf8.len(var_344_6) / 21)

				if (21 <= 0 and var_344_4 or var_344_4 * (utf8.len(var_344_6) / 21)) > 0 and var_344_4 < var_344_8 then
					arg_341_1.talkMaxDuration = var_344_8

					if var_344_8 + var_344_3 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_8 + var_344_3
					end
				end

				arg_341_1.text_.text = var_344_6
				arg_341_1.typewritter.percent = 0

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_102601", "102601082", "story_v_side_old_102601.awb") ~= 0 then
					local var_344_9 = manager.audio:GetVoiceLength("story_v_side_old_102601", "102601082", "story_v_side_old_102601.awb") / 1000

					if var_344_9 + var_344_3 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_9 + var_344_3
					end

					if var_344_5.prefab_name ~= "" and arg_341_1.actors_[var_344_5.prefab_name] ~= nil then
						local var_344_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_341_1.actors_[var_344_5.prefab_name].transform, "story_v_side_old_102601", "102601082", "story_v_side_old_102601.awb")

						arg_341_1:RecordAudio("102601082", var_344_10)
						arg_341_1:RecordAudio("102601082", var_344_10)
					else
						arg_341_1:AudioAction("play", "voice", "story_v_side_old_102601", "102601082", "story_v_side_old_102601.awb")
					end

					arg_341_1:RecordHistoryTalkVoice("story_v_side_old_102601", "102601082", "story_v_side_old_102601.awb")
				end

				arg_341_1:RecordContent(arg_341_1.text_.text)
			end

			local var_344_11 = math.max(var_344_4, arg_341_1.talkMaxDuration)

			if var_344_3 <= arg_341_1.time_ and arg_341_1.time_ < var_344_3 + var_344_11 then
				arg_341_1.typewritter.percent = (arg_341_1.time_ - var_344_3) / var_344_11

				arg_341_1.typewritter:SetDirty()
			end

			if arg_341_1.time_ >= var_344_3 + var_344_11 and arg_341_1.time_ < var_344_3 + var_344_11 + arg_344_0 then
				arg_341_1.typewritter.percent = 1

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(true)
			end
		end

		arg_341_1.nodeConfigList_ = {}

		arg_341_1:InitPlayNodeList()
	end,
	Play102601083 = function(arg_345_0, arg_345_1)
		arg_345_1.time_ = 0
		arg_345_1.frameCnt_ = 0
		arg_345_1.state_ = "playing"
		arg_345_1.curTalkId_ = 102601083
		arg_345_1.duration_ = 5

		SetActive(arg_345_1.tipsGo_, false)

		function arg_345_1.onSingleLineFinish_()
			arg_345_1.onSingleLineUpdate_ = nil
			arg_345_1.onSingleLineFinish_ = nil
			arg_345_1.state_ = "waiting"
		end

		function arg_345_1.playNext_(arg_347_0)
			if arg_347_0 == 1 then
				arg_345_0:Play102601084(arg_345_1)
			end
		end

		function arg_345_1.onSingleLineUpdate_(arg_348_0)
			if 0 < arg_345_1.time_ and arg_345_1.time_ <= 0 + arg_348_0 and not isNil(arg_345_1.actors_["1026ui_story"]) and arg_345_1.var_.characterEffect1026ui_story == nil then
				arg_345_1.var_.characterEffect1026ui_story = arg_345_1.actors_["1026ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_348_0 = 0.2

			if 0 <= arg_345_1.time_ and arg_345_1.time_ < 0 + var_348_0 and not isNil(arg_345_1.actors_["1026ui_story"]) then
				if arg_345_1.var_.characterEffect1026ui_story and not isNil(arg_345_1.actors_["1026ui_story"]) then
					arg_345_1.var_.characterEffect1026ui_story.fillFlat = true
					arg_345_1.var_.characterEffect1026ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_345_1.time_ - 0) / var_348_0)
				end
			end

			if arg_345_1.time_ >= 0 + var_348_0 and arg_345_1.time_ < 0 + var_348_0 + arg_348_0 and not isNil(arg_345_1.actors_["1026ui_story"]) and arg_345_1.var_.characterEffect1026ui_story then
				arg_345_1.var_.characterEffect1026ui_story.fillFlat = true
				arg_345_1.var_.characterEffect1026ui_story.fillRatio = 0.5
			end

			local var_348_1 = 0
			local var_348_2 = 0.075

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

				local var_348_3 = arg_345_1:FormatText(arg_345_1:GetWordFromCfg(102601083).content)

				arg_345_1.text_.text = var_348_3

				LuaForUtil.ClearLinePrefixSymbol(arg_345_1.text_)

				local var_348_5 = 3 <= 0 and var_348_2 or var_348_2 * (utf8.len(var_348_3) / 3)

				if (3 <= 0 and var_348_2 or var_348_2 * (utf8.len(var_348_3) / 3)) > 0 and var_348_2 < var_348_5 then
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
	Play102601084 = function(arg_349_0, arg_349_1)
		arg_349_1.time_ = 0
		arg_349_1.frameCnt_ = 0
		arg_349_1.state_ = "playing"
		arg_349_1.curTalkId_ = 102601084
		arg_349_1.duration_ = 8.17

		local var_349_0 = {
			ja = 8.166,
			ko = 4.9,
			zh = 4.8,
			en = 5.1
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
				arg_349_0:Play102601085(arg_349_1)
			end
		end

		function arg_349_1.onSingleLineUpdate_(arg_352_0)
			if 0 < arg_349_1.time_ and arg_349_1.time_ <= 0 + arg_352_0 then
				arg_349_1:PlayTimeline("1026ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_352_0 = arg_349_1.actors_["1026ui_story"]

			if 0 < arg_349_1.time_ and arg_349_1.time_ <= 0 + arg_352_0 and not isNil(var_352_0) and arg_349_1.var_.characterEffect1026ui_story == nil then
				arg_349_1.var_.characterEffect1026ui_story = var_352_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_352_1 = 0.2

			if 0 <= arg_349_1.time_ and arg_349_1.time_ < 0 + var_352_1 and not isNil(var_352_0) then
				if arg_349_1.var_.characterEffect1026ui_story and not isNil(var_352_0) then
					arg_349_1.var_.characterEffect1026ui_story.fillFlat = false
				end
			end

			if arg_349_1.time_ >= 0 + var_352_1 and arg_349_1.time_ < 0 + var_352_1 + arg_352_0 and not isNil(var_352_0) and arg_349_1.var_.characterEffect1026ui_story then
				arg_349_1.var_.characterEffect1026ui_story.fillFlat = false
			end

			local var_352_3 = 0
			local var_352_4 = 0.6

			if 0 < arg_349_1.time_ and arg_349_1.time_ <= var_352_3 + arg_352_0 then
				arg_349_1.talkMaxDuration = 0
				arg_349_1.dialogCg_.alpha = 1

				arg_349_1.dialog_:SetActive(true)
				SetActive(arg_349_1.leftNameGo_, true)

				arg_349_1.leftNameTxt_.text = arg_349_1:FormatText(StoryNameCfg[83].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_349_1.leftNameTxt_.transform)

				arg_349_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_349_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_349_1:RecordName(arg_349_1.leftNameTxt_.text)
				SetActive(arg_349_1.iconTrs_.gameObject, false)
				arg_349_1.callingController_:SetSelectedState("normal")

				local var_352_5 = arg_349_1:GetWordFromCfg(102601084)
				local var_352_6 = arg_349_1:FormatText(var_352_5.content)

				arg_349_1.text_.text = var_352_6

				LuaForUtil.ClearLinePrefixSymbol(arg_349_1.text_)

				local var_352_8 = 24 <= 0 and var_352_4 or var_352_4 * (utf8.len(var_352_6) / 24)

				if (24 <= 0 and var_352_4 or var_352_4 * (utf8.len(var_352_6) / 24)) > 0 and var_352_4 < var_352_8 then
					arg_349_1.talkMaxDuration = var_352_8

					if var_352_8 + var_352_3 > arg_349_1.duration_ then
						arg_349_1.duration_ = var_352_8 + var_352_3
					end
				end

				arg_349_1.text_.text = var_352_6
				arg_349_1.typewritter.percent = 0

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_102601", "102601084", "story_v_side_old_102601.awb") ~= 0 then
					local var_352_9 = manager.audio:GetVoiceLength("story_v_side_old_102601", "102601084", "story_v_side_old_102601.awb") / 1000

					if var_352_9 + var_352_3 > arg_349_1.duration_ then
						arg_349_1.duration_ = var_352_9 + var_352_3
					end

					if var_352_5.prefab_name ~= "" and arg_349_1.actors_[var_352_5.prefab_name] ~= nil then
						local var_352_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_349_1.actors_[var_352_5.prefab_name].transform, "story_v_side_old_102601", "102601084", "story_v_side_old_102601.awb")

						arg_349_1:RecordAudio("102601084", var_352_10)
						arg_349_1:RecordAudio("102601084", var_352_10)
					else
						arg_349_1:AudioAction("play", "voice", "story_v_side_old_102601", "102601084", "story_v_side_old_102601.awb")
					end

					arg_349_1:RecordHistoryTalkVoice("story_v_side_old_102601", "102601084", "story_v_side_old_102601.awb")
				end

				arg_349_1:RecordContent(arg_349_1.text_.text)
			end

			local var_352_11 = math.max(var_352_4, arg_349_1.talkMaxDuration)

			if var_352_3 <= arg_349_1.time_ and arg_349_1.time_ < var_352_3 + var_352_11 then
				arg_349_1.typewritter.percent = (arg_349_1.time_ - var_352_3) / var_352_11

				arg_349_1.typewritter:SetDirty()
			end

			if arg_349_1.time_ >= var_352_3 + var_352_11 and arg_349_1.time_ < var_352_3 + var_352_11 + arg_352_0 then
				arg_349_1.typewritter.percent = 1

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(true)
			end
		end

		arg_349_1.nodeConfigList_ = {}

		arg_349_1:InitPlayNodeList()
	end,
	Play102601085 = function(arg_353_0, arg_353_1)
		arg_353_1.time_ = 0
		arg_353_1.frameCnt_ = 0
		arg_353_1.state_ = "playing"
		arg_353_1.curTalkId_ = 102601085
		arg_353_1.duration_ = 5

		SetActive(arg_353_1.tipsGo_, false)

		function arg_353_1.onSingleLineFinish_()
			arg_353_1.onSingleLineUpdate_ = nil
			arg_353_1.onSingleLineFinish_ = nil
			arg_353_1.state_ = "waiting"
		end

		function arg_353_1.playNext_(arg_355_0)
			if arg_355_0 == 1 then
				arg_353_0:Play102601086(arg_353_1)
			end
		end

		function arg_353_1.onSingleLineUpdate_(arg_356_0)
			if 0 < arg_353_1.time_ and arg_353_1.time_ <= 0 + arg_356_0 and not isNil(arg_353_1.actors_["1026ui_story"]) and arg_353_1.var_.characterEffect1026ui_story == nil then
				arg_353_1.var_.characterEffect1026ui_story = arg_353_1.actors_["1026ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_356_0 = 0.2

			if 0 <= arg_353_1.time_ and arg_353_1.time_ < 0 + var_356_0 and not isNil(arg_353_1.actors_["1026ui_story"]) then
				if arg_353_1.var_.characterEffect1026ui_story and not isNil(arg_353_1.actors_["1026ui_story"]) then
					arg_353_1.var_.characterEffect1026ui_story.fillFlat = true
					arg_353_1.var_.characterEffect1026ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_353_1.time_ - 0) / var_356_0)
				end
			end

			if arg_353_1.time_ >= 0 + var_356_0 and arg_353_1.time_ < 0 + var_356_0 + arg_356_0 and not isNil(arg_353_1.actors_["1026ui_story"]) and arg_353_1.var_.characterEffect1026ui_story then
				arg_353_1.var_.characterEffect1026ui_story.fillFlat = true
				arg_353_1.var_.characterEffect1026ui_story.fillRatio = 0.5
			end

			local var_356_1 = 0
			local var_356_2 = 0.1

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

				local var_356_3 = arg_353_1:FormatText(arg_353_1:GetWordFromCfg(102601085).content)

				arg_353_1.text_.text = var_356_3

				LuaForUtil.ClearLinePrefixSymbol(arg_353_1.text_)

				local var_356_5 = 4 <= 0 and var_356_2 or var_356_2 * (utf8.len(var_356_3) / 4)

				if (4 <= 0 and var_356_2 or var_356_2 * (utf8.len(var_356_3) / 4)) > 0 and var_356_2 < var_356_5 then
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
	Play102601086 = function(arg_357_0, arg_357_1)
		arg_357_1.time_ = 0
		arg_357_1.frameCnt_ = 0
		arg_357_1.state_ = "playing"
		arg_357_1.curTalkId_ = 102601086
		arg_357_1.duration_ = 5

		SetActive(arg_357_1.tipsGo_, false)

		function arg_357_1.onSingleLineFinish_()
			arg_357_1.onSingleLineUpdate_ = nil
			arg_357_1.onSingleLineFinish_ = nil
			arg_357_1.state_ = "waiting"
		end

		function arg_357_1.playNext_(arg_359_0)
			if arg_359_0 == 1 then
				arg_357_0:Play102601087(arg_357_1)
			end
		end

		function arg_357_1.onSingleLineUpdate_(arg_360_0)
			if 0 < arg_357_1.time_ and arg_357_1.time_ <= 0 + arg_360_0 then
				arg_357_1.var_.moveOldPos1026ui_story = arg_357_1.actors_["1026ui_story"].transform.localPosition
			end

			local var_360_0 = 0.001

			if 0 <= arg_357_1.time_ and arg_357_1.time_ < 0 + var_360_0 then
				arg_357_1.actors_["1026ui_story"].transform.localPosition = Vector3.Lerp(arg_357_1.var_.moveOldPos1026ui_story, Vector3.New(0, 100, 0), (arg_357_1.time_ - 0) / var_360_0)
				arg_357_1.actors_["1026ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_357_1.actors_["1026ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_357_1.actors_["1026ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_357_1.actors_["1026ui_story"].transform.position).z)
				arg_357_1.actors_["1026ui_story"].transform.localEulerAngles.z = 0
				arg_357_1.actors_["1026ui_story"].transform.localEulerAngles.x = 0
				arg_357_1.actors_["1026ui_story"].transform.localEulerAngles = arg_357_1.actors_["1026ui_story"].transform.localEulerAngles
			end

			if arg_357_1.time_ >= 0 + var_360_0 and arg_357_1.time_ < 0 + var_360_0 + arg_360_0 then
				arg_357_1.actors_["1026ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_357_1.actors_["1026ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_357_1.actors_["1026ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_357_1.actors_["1026ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_357_1.actors_["1026ui_story"].transform.position).z)
				arg_357_1.actors_["1026ui_story"].transform.localEulerAngles.z = 0
				arg_357_1.actors_["1026ui_story"].transform.localEulerAngles.x = 0
				arg_357_1.actors_["1026ui_story"].transform.localEulerAngles = arg_357_1.actors_["1026ui_story"].transform.localEulerAngles
			end

			local var_360_1 = 0
			local var_360_2 = 1.05

			if 0 < arg_357_1.time_ and arg_357_1.time_ <= var_360_1 + arg_360_0 then
				arg_357_1.talkMaxDuration = 0
				arg_357_1.dialogCg_.alpha = 1

				arg_357_1.dialog_:SetActive(true)
				SetActive(arg_357_1.leftNameGo_, false)

				arg_357_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_357_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_357_1:RecordName(arg_357_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_357_1.iconTrs_.gameObject, false)
				arg_357_1.callingController_:SetSelectedState("normal")

				local var_360_3 = arg_357_1:FormatText(arg_357_1:GetWordFromCfg(102601086).content)

				arg_357_1.text_.text = var_360_3

				LuaForUtil.ClearLinePrefixSymbol(arg_357_1.text_)

				local var_360_5 = 41 <= 0 and var_360_2 or var_360_2 * (utf8.len(var_360_3) / 41)

				if (41 <= 0 and var_360_2 or var_360_2 * (utf8.len(var_360_3) / 41)) > 0 and var_360_2 < var_360_5 then
					arg_357_1.talkMaxDuration = var_360_5

					if var_360_5 + var_360_1 > arg_357_1.duration_ then
						arg_357_1.duration_ = var_360_5 + var_360_1
					end
				end

				arg_357_1.text_.text = var_360_3
				arg_357_1.typewritter.percent = 0

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(false)
				arg_357_1:RecordContent(arg_357_1.text_.text)
			end

			local var_360_6 = math.max(var_360_2, arg_357_1.talkMaxDuration)

			if var_360_1 <= arg_357_1.time_ and arg_357_1.time_ < var_360_1 + var_360_6 then
				arg_357_1.typewritter.percent = (arg_357_1.time_ - var_360_1) / var_360_6

				arg_357_1.typewritter:SetDirty()
			end

			if arg_357_1.time_ >= var_360_1 + var_360_6 and arg_357_1.time_ < var_360_1 + var_360_6 + arg_360_0 then
				arg_357_1.typewritter.percent = 1

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(true)
			end
		end

		arg_357_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1026ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_357_1:InitPlayNodeList()
	end,
	Play102601087 = function(arg_361_0, arg_361_1)
		arg_361_1.time_ = 0
		arg_361_1.frameCnt_ = 0
		arg_361_1.state_ = "playing"
		arg_361_1.curTalkId_ = 102601087
		arg_361_1.duration_ = 5

		SetActive(arg_361_1.tipsGo_, false)

		function arg_361_1.onSingleLineFinish_()
			arg_361_1.onSingleLineUpdate_ = nil
			arg_361_1.onSingleLineFinish_ = nil
			arg_361_1.state_ = "waiting"
		end

		function arg_361_1.playNext_(arg_363_0)
			if arg_363_0 == 1 then
				arg_361_0:Play102601088(arg_361_1)
			end
		end

		function arg_361_1.onSingleLineUpdate_(arg_364_0)
			local var_364_0 = 0.3

			if 0 < arg_361_1.time_ and arg_361_1.time_ <= 0 + arg_364_0 then
				arg_361_1.talkMaxDuration = 0
				arg_361_1.dialogCg_.alpha = 1

				arg_361_1.dialog_:SetActive(true)
				SetActive(arg_361_1.leftNameGo_, false)

				arg_361_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_361_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_361_1:RecordName(arg_361_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_361_1.iconTrs_.gameObject, false)
				arg_361_1.callingController_:SetSelectedState("normal")

				local var_364_1 = arg_361_1:FormatText(arg_361_1:GetWordFromCfg(102601087).content)

				arg_361_1.text_.text = var_364_1

				LuaForUtil.ClearLinePrefixSymbol(arg_361_1.text_)

				local var_364_3 = 12 <= 0 and var_364_0 or var_364_0 * (utf8.len(var_364_1) / 12)

				if (12 <= 0 and var_364_0 or var_364_0 * (utf8.len(var_364_1) / 12)) > 0 and var_364_0 < var_364_3 then
					arg_361_1.talkMaxDuration = var_364_3

					if var_364_3 + 0 > arg_361_1.duration_ then
						arg_361_1.duration_ = var_364_3 + 0
					end
				end

				arg_361_1.text_.text = var_364_1
				arg_361_1.typewritter.percent = 0

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(false)
				arg_361_1:RecordContent(arg_361_1.text_.text)
			end

			local var_364_4 = math.max(var_364_0, arg_361_1.talkMaxDuration)

			if 0 <= arg_361_1.time_ and arg_361_1.time_ < 0 + var_364_4 then
				arg_361_1.typewritter.percent = (arg_361_1.time_ - 0) / var_364_4

				arg_361_1.typewritter:SetDirty()
			end

			if arg_361_1.time_ >= 0 + var_364_4 and arg_361_1.time_ < 0 + var_364_4 + arg_364_0 then
				arg_361_1.typewritter.percent = 1

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(true)
			end
		end

		arg_361_1.nodeConfigList_ = {}

		arg_361_1:InitPlayNodeList()
	end,
	Play102601088 = function(arg_365_0, arg_365_1)
		arg_365_1.time_ = 0
		arg_365_1.frameCnt_ = 0
		arg_365_1.state_ = "playing"
		arg_365_1.curTalkId_ = 102601088
		arg_365_1.duration_ = 5

		SetActive(arg_365_1.tipsGo_, false)

		function arg_365_1.onSingleLineFinish_()
			arg_365_1.onSingleLineUpdate_ = nil
			arg_365_1.onSingleLineFinish_ = nil
			arg_365_1.state_ = "waiting"
		end

		function arg_365_1.playNext_(arg_367_0)
			if arg_367_0 == 1 then
				arg_365_0:Play102601089(arg_365_1)
			end
		end

		function arg_365_1.onSingleLineUpdate_(arg_368_0)
			local var_368_0 = 0.225

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

				local var_368_1 = arg_365_1:FormatText(arg_365_1:GetWordFromCfg(102601088).content)

				arg_365_1.text_.text = var_368_1

				LuaForUtil.ClearLinePrefixSymbol(arg_365_1.text_)

				local var_368_3 = 9 <= 0 and var_368_0 or var_368_0 * (utf8.len(var_368_1) / 9)

				if (9 <= 0 and var_368_0 or var_368_0 * (utf8.len(var_368_1) / 9)) > 0 and var_368_0 < var_368_3 then
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
	Play102601089 = function(arg_369_0, arg_369_1)
		arg_369_1.time_ = 0
		arg_369_1.frameCnt_ = 0
		arg_369_1.state_ = "playing"
		arg_369_1.curTalkId_ = 102601089
		arg_369_1.duration_ = 5

		SetActive(arg_369_1.tipsGo_, false)

		function arg_369_1.onSingleLineFinish_()
			arg_369_1.onSingleLineUpdate_ = nil
			arg_369_1.onSingleLineFinish_ = nil
			arg_369_1.state_ = "waiting"
		end

		function arg_369_1.playNext_(arg_371_0)
			if arg_371_0 == 1 then
				arg_369_0:Play102601090(arg_369_1)
			end
		end

		function arg_369_1.onSingleLineUpdate_(arg_372_0)
			local var_372_0 = 0.9

			if 0 < arg_369_1.time_ and arg_369_1.time_ <= 0 + arg_372_0 then
				arg_369_1.talkMaxDuration = 0
				arg_369_1.dialogCg_.alpha = 1

				arg_369_1.dialog_:SetActive(true)
				SetActive(arg_369_1.leftNameGo_, false)

				arg_369_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_369_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_369_1:RecordName(arg_369_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_369_1.iconTrs_.gameObject, false)
				arg_369_1.callingController_:SetSelectedState("normal")

				local var_372_1 = arg_369_1:FormatText(arg_369_1:GetWordFromCfg(102601089).content)

				arg_369_1.text_.text = var_372_1

				LuaForUtil.ClearLinePrefixSymbol(arg_369_1.text_)

				local var_372_3 = 36 <= 0 and var_372_0 or var_372_0 * (utf8.len(var_372_1) / 36)

				if (36 <= 0 and var_372_0 or var_372_0 * (utf8.len(var_372_1) / 36)) > 0 and var_372_0 < var_372_3 then
					arg_369_1.talkMaxDuration = var_372_3

					if var_372_3 + 0 > arg_369_1.duration_ then
						arg_369_1.duration_ = var_372_3 + 0
					end
				end

				arg_369_1.text_.text = var_372_1
				arg_369_1.typewritter.percent = 0

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(false)
				arg_369_1:RecordContent(arg_369_1.text_.text)
			end

			local var_372_4 = math.max(var_372_0, arg_369_1.talkMaxDuration)

			if 0 <= arg_369_1.time_ and arg_369_1.time_ < 0 + var_372_4 then
				arg_369_1.typewritter.percent = (arg_369_1.time_ - 0) / var_372_4

				arg_369_1.typewritter:SetDirty()
			end

			if arg_369_1.time_ >= 0 + var_372_4 and arg_369_1.time_ < 0 + var_372_4 + arg_372_0 then
				arg_369_1.typewritter.percent = 1

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(true)
			end
		end

		arg_369_1.nodeConfigList_ = {}

		arg_369_1:InitPlayNodeList()
	end,
	Play102601090 = function(arg_373_0, arg_373_1)
		arg_373_1.time_ = 0
		arg_373_1.frameCnt_ = 0
		arg_373_1.state_ = "playing"
		arg_373_1.curTalkId_ = 102601090
		arg_373_1.duration_ = 5

		SetActive(arg_373_1.tipsGo_, false)

		function arg_373_1.onSingleLineFinish_()
			arg_373_1.onSingleLineUpdate_ = nil
			arg_373_1.onSingleLineFinish_ = nil
			arg_373_1.state_ = "waiting"
		end

		function arg_373_1.playNext_(arg_375_0)
			if arg_375_0 == 1 then
				arg_373_0:Play102601091(arg_373_1)
			end
		end

		function arg_373_1.onSingleLineUpdate_(arg_376_0)
			local var_376_0 = 1.25

			if 0 < arg_373_1.time_ and arg_373_1.time_ <= 0 + arg_376_0 then
				arg_373_1.talkMaxDuration = 0
				arg_373_1.dialogCg_.alpha = 1

				arg_373_1.dialog_:SetActive(true)
				SetActive(arg_373_1.leftNameGo_, false)

				arg_373_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_373_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_373_1:RecordName(arg_373_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_373_1.iconTrs_.gameObject, false)
				arg_373_1.callingController_:SetSelectedState("normal")

				local var_376_1 = arg_373_1:FormatText(arg_373_1:GetWordFromCfg(102601090).content)

				arg_373_1.text_.text = var_376_1

				LuaForUtil.ClearLinePrefixSymbol(arg_373_1.text_)

				local var_376_3 = 50 <= 0 and var_376_0 or var_376_0 * (utf8.len(var_376_1) / 50)

				if (50 <= 0 and var_376_0 or var_376_0 * (utf8.len(var_376_1) / 50)) > 0 and var_376_0 < var_376_3 then
					arg_373_1.talkMaxDuration = var_376_3

					if var_376_3 + 0 > arg_373_1.duration_ then
						arg_373_1.duration_ = var_376_3 + 0
					end
				end

				arg_373_1.text_.text = var_376_1
				arg_373_1.typewritter.percent = 0

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(false)
				arg_373_1:RecordContent(arg_373_1.text_.text)
			end

			local var_376_4 = math.max(var_376_0, arg_373_1.talkMaxDuration)

			if 0 <= arg_373_1.time_ and arg_373_1.time_ < 0 + var_376_4 then
				arg_373_1.typewritter.percent = (arg_373_1.time_ - 0) / var_376_4

				arg_373_1.typewritter:SetDirty()
			end

			if arg_373_1.time_ >= 0 + var_376_4 and arg_373_1.time_ < 0 + var_376_4 + arg_376_0 then
				arg_373_1.typewritter.percent = 1

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(true)
			end
		end

		arg_373_1.nodeConfigList_ = {}

		arg_373_1:InitPlayNodeList()
	end,
	Play102601091 = function(arg_377_0, arg_377_1)
		arg_377_1.time_ = 0
		arg_377_1.frameCnt_ = 0
		arg_377_1.state_ = "playing"
		arg_377_1.curTalkId_ = 102601091
		arg_377_1.duration_ = 5

		SetActive(arg_377_1.tipsGo_, false)

		function arg_377_1.onSingleLineFinish_()
			arg_377_1.onSingleLineUpdate_ = nil
			arg_377_1.onSingleLineFinish_ = nil
			arg_377_1.state_ = "waiting"
		end

		function arg_377_1.playNext_(arg_379_0)
			if arg_379_0 == 1 then
				arg_377_0:Play102601092(arg_377_1)
			end
		end

		function arg_377_1.onSingleLineUpdate_(arg_380_0)
			local var_380_0 = 0.475

			if 0 < arg_377_1.time_ and arg_377_1.time_ <= 0 + arg_380_0 then
				arg_377_1.talkMaxDuration = 0
				arg_377_1.dialogCg_.alpha = 1

				arg_377_1.dialog_:SetActive(true)
				SetActive(arg_377_1.leftNameGo_, true)

				arg_377_1.leftNameTxt_.text = arg_377_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_377_1.leftNameTxt_.transform)

				arg_377_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_377_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_377_1:RecordName(arg_377_1.leftNameTxt_.text)
				SetActive(arg_377_1.iconTrs_.gameObject, true)
				arg_377_1.iconController_:SetSelectedState("hero")

				arg_377_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_377_1.callingController_:SetSelectedState("normal")

				arg_377_1.keyicon_.color = Color.New(1, 1, 1)
				arg_377_1.icon_.color = Color.New(1, 1, 1)

				local var_380_1 = arg_377_1:FormatText(arg_377_1:GetWordFromCfg(102601091).content)

				arg_377_1.text_.text = var_380_1

				LuaForUtil.ClearLinePrefixSymbol(arg_377_1.text_)

				local var_380_3 = 19 <= 0 and var_380_0 or var_380_0 * (utf8.len(var_380_1) / 19)

				if (19 <= 0 and var_380_0 or var_380_0 * (utf8.len(var_380_1) / 19)) > 0 and var_380_0 < var_380_3 then
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
	Play102601092 = function(arg_381_0, arg_381_1)
		arg_381_1.time_ = 0
		arg_381_1.frameCnt_ = 0
		arg_381_1.state_ = "playing"
		arg_381_1.curTalkId_ = 102601092
		arg_381_1.duration_ = 5.97

		local var_381_0 = {
			ja = 1.766,
			ko = 1.066,
			zh = 1.5,
			en = 5.966
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
				arg_381_0:Play102601093(arg_381_1)
			end
		end

		function arg_381_1.onSingleLineUpdate_(arg_384_0)
			local var_384_0 = 0.05

			if 0 < arg_381_1.time_ and arg_381_1.time_ <= 0 + arg_384_0 then
				arg_381_1.talkMaxDuration = 0
				arg_381_1.dialogCg_.alpha = 1

				arg_381_1.dialog_:SetActive(true)
				SetActive(arg_381_1.leftNameGo_, true)

				arg_381_1.leftNameTxt_.text = arg_381_1:FormatText(StoryNameCfg[83].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_381_1.leftNameTxt_.transform)

				arg_381_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_381_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_381_1:RecordName(arg_381_1.leftNameTxt_.text)
				SetActive(arg_381_1.iconTrs_.gameObject, true)
				arg_381_1.iconController_:SetSelectedState("hero")

				arg_381_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1026")

				arg_381_1.callingController_:SetSelectedState("normal")

				arg_381_1.keyicon_.color = Color.New(1, 1, 1)
				arg_381_1.icon_.color = Color.New(1, 1, 1)

				local var_384_1 = arg_381_1:GetWordFromCfg(102601092)
				local var_384_2 = arg_381_1:FormatText(var_384_1.content)

				arg_381_1.text_.text = var_384_2

				LuaForUtil.ClearLinePrefixSymbol(arg_381_1.text_)

				local var_384_4 = 2 <= 0 and var_384_0 or var_384_0 * (utf8.len(var_384_2) / 2)

				if (2 <= 0 and var_384_0 or var_384_0 * (utf8.len(var_384_2) / 2)) > 0 and var_384_0 < var_384_4 then
					arg_381_1.talkMaxDuration = var_384_4

					if var_384_4 + 0 > arg_381_1.duration_ then
						arg_381_1.duration_ = var_384_4 + 0
					end
				end

				arg_381_1.text_.text = var_384_2
				arg_381_1.typewritter.percent = 0

				arg_381_1.typewritter:SetDirty()
				arg_381_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_102601", "102601092", "story_v_side_old_102601.awb") ~= 0 then
					local var_384_5 = manager.audio:GetVoiceLength("story_v_side_old_102601", "102601092", "story_v_side_old_102601.awb") / 1000

					if var_384_5 + 0 > arg_381_1.duration_ then
						arg_381_1.duration_ = var_384_5 + 0
					end

					if var_384_1.prefab_name ~= "" and arg_381_1.actors_[var_384_1.prefab_name] ~= nil then
						local var_384_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_381_1.actors_[var_384_1.prefab_name].transform, "story_v_side_old_102601", "102601092", "story_v_side_old_102601.awb")

						arg_381_1:RecordAudio("102601092", var_384_6)
						arg_381_1:RecordAudio("102601092", var_384_6)
					else
						arg_381_1:AudioAction("play", "voice", "story_v_side_old_102601", "102601092", "story_v_side_old_102601.awb")
					end

					arg_381_1:RecordHistoryTalkVoice("story_v_side_old_102601", "102601092", "story_v_side_old_102601.awb")
				end

				arg_381_1:RecordContent(arg_381_1.text_.text)
			end

			local var_384_7 = math.max(var_384_0, arg_381_1.talkMaxDuration)

			if 0 <= arg_381_1.time_ and arg_381_1.time_ < 0 + var_384_7 then
				arg_381_1.typewritter.percent = (arg_381_1.time_ - 0) / var_384_7

				arg_381_1.typewritter:SetDirty()
			end

			if arg_381_1.time_ >= 0 + var_384_7 and arg_381_1.time_ < 0 + var_384_7 + arg_384_0 then
				arg_381_1.typewritter.percent = 1

				arg_381_1.typewritter:SetDirty()
				arg_381_1:ShowNextGo(true)
			end
		end

		arg_381_1.nodeConfigList_ = {}

		arg_381_1:InitPlayNodeList()
	end,
	Play102601093 = function(arg_385_0, arg_385_1)
		arg_385_1.time_ = 0
		arg_385_1.frameCnt_ = 0
		arg_385_1.state_ = "playing"
		arg_385_1.curTalkId_ = 102601093
		arg_385_1.duration_ = 5

		SetActive(arg_385_1.tipsGo_, false)

		function arg_385_1.onSingleLineFinish_()
			arg_385_1.onSingleLineUpdate_ = nil
			arg_385_1.onSingleLineFinish_ = nil
			arg_385_1.state_ = "waiting"
		end

		function arg_385_1.playNext_(arg_387_0)
			if arg_387_0 == 1 then
				arg_385_0:Play102601094(arg_385_1)
			end
		end

		function arg_385_1.onSingleLineUpdate_(arg_388_0)
			local var_388_0 = 1.25

			if 0 < arg_385_1.time_ and arg_385_1.time_ <= 0 + arg_388_0 then
				arg_385_1.talkMaxDuration = 0
				arg_385_1.dialogCg_.alpha = 1

				arg_385_1.dialog_:SetActive(true)
				SetActive(arg_385_1.leftNameGo_, false)

				arg_385_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_385_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_385_1:RecordName(arg_385_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_385_1.iconTrs_.gameObject, false)
				arg_385_1.callingController_:SetSelectedState("normal")

				local var_388_1 = arg_385_1:FormatText(arg_385_1:GetWordFromCfg(102601093).content)

				arg_385_1.text_.text = var_388_1

				LuaForUtil.ClearLinePrefixSymbol(arg_385_1.text_)

				local var_388_3 = 50 <= 0 and var_388_0 or var_388_0 * (utf8.len(var_388_1) / 50)

				if (50 <= 0 and var_388_0 or var_388_0 * (utf8.len(var_388_1) / 50)) > 0 and var_388_0 < var_388_3 then
					arg_385_1.talkMaxDuration = var_388_3

					if var_388_3 + 0 > arg_385_1.duration_ then
						arg_385_1.duration_ = var_388_3 + 0
					end
				end

				arg_385_1.text_.text = var_388_1
				arg_385_1.typewritter.percent = 0

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(false)
				arg_385_1:RecordContent(arg_385_1.text_.text)
			end

			local var_388_4 = math.max(var_388_0, arg_385_1.talkMaxDuration)

			if 0 <= arg_385_1.time_ and arg_385_1.time_ < 0 + var_388_4 then
				arg_385_1.typewritter.percent = (arg_385_1.time_ - 0) / var_388_4

				arg_385_1.typewritter:SetDirty()
			end

			if arg_385_1.time_ >= 0 + var_388_4 and arg_385_1.time_ < 0 + var_388_4 + arg_388_0 then
				arg_385_1.typewritter.percent = 1

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(true)
			end
		end

		arg_385_1.nodeConfigList_ = {}

		arg_385_1:InitPlayNodeList()
	end,
	Play102601094 = function(arg_389_0, arg_389_1)
		arg_389_1.time_ = 0
		arg_389_1.frameCnt_ = 0
		arg_389_1.state_ = "playing"
		arg_389_1.curTalkId_ = 102601094
		arg_389_1.duration_ = 3.23

		local var_389_0 = {
			ja = 3.233,
			ko = 3.166,
			zh = 2,
			en = 3.1
		}
		local var_389_1 = manager.audio:GetLocalizationFlag()

		if var_389_0[var_389_1] ~= nil then
			arg_389_1.duration_ = var_389_0[var_389_1]
		end

		SetActive(arg_389_1.tipsGo_, false)

		function arg_389_1.onSingleLineFinish_()
			arg_389_1.onSingleLineUpdate_ = nil
			arg_389_1.onSingleLineFinish_ = nil
			arg_389_1.state_ = "waiting"
		end

		function arg_389_1.playNext_(arg_391_0)
			if arg_391_0 == 1 then
				arg_389_0:Play102601095(arg_389_1)
			end
		end

		function arg_389_1.onSingleLineUpdate_(arg_392_0)
			local var_392_0 = 0.3

			if 0 < arg_389_1.time_ and arg_389_1.time_ <= 0 + arg_392_0 then
				arg_389_1.talkMaxDuration = 0
				arg_389_1.dialogCg_.alpha = 1

				arg_389_1.dialog_:SetActive(true)
				SetActive(arg_389_1.leftNameGo_, true)

				arg_389_1.leftNameTxt_.text = arg_389_1:FormatText(StoryNameCfg[83].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_389_1.leftNameTxt_.transform)

				arg_389_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_389_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_389_1:RecordName(arg_389_1.leftNameTxt_.text)
				SetActive(arg_389_1.iconTrs_.gameObject, true)
				arg_389_1.iconController_:SetSelectedState("hero")

				arg_389_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1026")

				arg_389_1.callingController_:SetSelectedState("normal")

				arg_389_1.keyicon_.color = Color.New(1, 1, 1)
				arg_389_1.icon_.color = Color.New(1, 1, 1)

				local var_392_1 = arg_389_1:GetWordFromCfg(102601094)
				local var_392_2 = arg_389_1:FormatText(var_392_1.content)

				arg_389_1.text_.text = var_392_2

				LuaForUtil.ClearLinePrefixSymbol(arg_389_1.text_)

				local var_392_4 = 12 <= 0 and var_392_0 or var_392_0 * (utf8.len(var_392_2) / 12)

				if (12 <= 0 and var_392_0 or var_392_0 * (utf8.len(var_392_2) / 12)) > 0 and var_392_0 < var_392_4 then
					arg_389_1.talkMaxDuration = var_392_4

					if var_392_4 + 0 > arg_389_1.duration_ then
						arg_389_1.duration_ = var_392_4 + 0
					end
				end

				arg_389_1.text_.text = var_392_2
				arg_389_1.typewritter.percent = 0

				arg_389_1.typewritter:SetDirty()
				arg_389_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_102601", "102601094", "story_v_side_old_102601.awb") ~= 0 then
					local var_392_5 = manager.audio:GetVoiceLength("story_v_side_old_102601", "102601094", "story_v_side_old_102601.awb") / 1000

					if var_392_5 + 0 > arg_389_1.duration_ then
						arg_389_1.duration_ = var_392_5 + 0
					end

					if var_392_1.prefab_name ~= "" and arg_389_1.actors_[var_392_1.prefab_name] ~= nil then
						local var_392_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_389_1.actors_[var_392_1.prefab_name].transform, "story_v_side_old_102601", "102601094", "story_v_side_old_102601.awb")

						arg_389_1:RecordAudio("102601094", var_392_6)
						arg_389_1:RecordAudio("102601094", var_392_6)
					else
						arg_389_1:AudioAction("play", "voice", "story_v_side_old_102601", "102601094", "story_v_side_old_102601.awb")
					end

					arg_389_1:RecordHistoryTalkVoice("story_v_side_old_102601", "102601094", "story_v_side_old_102601.awb")
				end

				arg_389_1:RecordContent(arg_389_1.text_.text)
			end

			local var_392_7 = math.max(var_392_0, arg_389_1.talkMaxDuration)

			if 0 <= arg_389_1.time_ and arg_389_1.time_ < 0 + var_392_7 then
				arg_389_1.typewritter.percent = (arg_389_1.time_ - 0) / var_392_7

				arg_389_1.typewritter:SetDirty()
			end

			if arg_389_1.time_ >= 0 + var_392_7 and arg_389_1.time_ < 0 + var_392_7 + arg_392_0 then
				arg_389_1.typewritter.percent = 1

				arg_389_1.typewritter:SetDirty()
				arg_389_1:ShowNextGo(true)
			end
		end

		arg_389_1.nodeConfigList_ = {}

		arg_389_1:InitPlayNodeList()
	end,
	Play102601095 = function(arg_393_0, arg_393_1)
		arg_393_1.time_ = 0
		arg_393_1.frameCnt_ = 0
		arg_393_1.state_ = "playing"
		arg_393_1.curTalkId_ = 102601095
		arg_393_1.duration_ = 5

		SetActive(arg_393_1.tipsGo_, false)

		function arg_393_1.onSingleLineFinish_()
			arg_393_1.onSingleLineUpdate_ = nil
			arg_393_1.onSingleLineFinish_ = nil
			arg_393_1.state_ = "waiting"
		end

		function arg_393_1.playNext_(arg_395_0)
			if arg_395_0 == 1 then
				arg_393_0:Play102601096(arg_393_1)
			end
		end

		function arg_393_1.onSingleLineUpdate_(arg_396_0)
			local var_396_0 = 1.375

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

				local var_396_1 = arg_393_1:FormatText(arg_393_1:GetWordFromCfg(102601095).content)

				arg_393_1.text_.text = var_396_1

				LuaForUtil.ClearLinePrefixSymbol(arg_393_1.text_)

				local var_396_3 = 55 <= 0 and var_396_0 or var_396_0 * (utf8.len(var_396_1) / 55)

				if (55 <= 0 and var_396_0 or var_396_0 * (utf8.len(var_396_1) / 55)) > 0 and var_396_0 < var_396_3 then
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
	Play102601096 = function(arg_397_0, arg_397_1)
		arg_397_1.time_ = 0
		arg_397_1.frameCnt_ = 0
		arg_397_1.state_ = "playing"
		arg_397_1.curTalkId_ = 102601096
		arg_397_1.duration_ = 5

		SetActive(arg_397_1.tipsGo_, false)

		function arg_397_1.onSingleLineFinish_()
			arg_397_1.onSingleLineUpdate_ = nil
			arg_397_1.onSingleLineFinish_ = nil
			arg_397_1.state_ = "waiting"
		end

		function arg_397_1.playNext_(arg_399_0)
			if arg_399_0 == 1 then
				arg_397_0:Play102601097(arg_397_1)
			end
		end

		function arg_397_1.onSingleLineUpdate_(arg_400_0)
			local var_400_0 = 1.3

			if 0 < arg_397_1.time_ and arg_397_1.time_ <= 0 + arg_400_0 then
				arg_397_1.talkMaxDuration = 0
				arg_397_1.dialogCg_.alpha = 1

				arg_397_1.dialog_:SetActive(true)
				SetActive(arg_397_1.leftNameGo_, false)

				arg_397_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_397_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_397_1:RecordName(arg_397_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_397_1.iconTrs_.gameObject, false)
				arg_397_1.callingController_:SetSelectedState("normal")

				local var_400_1 = arg_397_1:FormatText(arg_397_1:GetWordFromCfg(102601096).content)

				arg_397_1.text_.text = var_400_1

				LuaForUtil.ClearLinePrefixSymbol(arg_397_1.text_)

				local var_400_3 = 52 <= 0 and var_400_0 or var_400_0 * (utf8.len(var_400_1) / 52)

				if (52 <= 0 and var_400_0 or var_400_0 * (utf8.len(var_400_1) / 52)) > 0 and var_400_0 < var_400_3 then
					arg_397_1.talkMaxDuration = var_400_3

					if var_400_3 + 0 > arg_397_1.duration_ then
						arg_397_1.duration_ = var_400_3 + 0
					end
				end

				arg_397_1.text_.text = var_400_1
				arg_397_1.typewritter.percent = 0

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(false)
				arg_397_1:RecordContent(arg_397_1.text_.text)
			end

			local var_400_4 = math.max(var_400_0, arg_397_1.talkMaxDuration)

			if 0 <= arg_397_1.time_ and arg_397_1.time_ < 0 + var_400_4 then
				arg_397_1.typewritter.percent = (arg_397_1.time_ - 0) / var_400_4

				arg_397_1.typewritter:SetDirty()
			end

			if arg_397_1.time_ >= 0 + var_400_4 and arg_397_1.time_ < 0 + var_400_4 + arg_400_0 then
				arg_397_1.typewritter.percent = 1

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(true)
			end
		end

		arg_397_1.nodeConfigList_ = {}

		arg_397_1:InitPlayNodeList()
	end,
	Play102601097 = function(arg_401_0, arg_401_1)
		arg_401_1.time_ = 0
		arg_401_1.frameCnt_ = 0
		arg_401_1.state_ = "playing"
		arg_401_1.curTalkId_ = 102601097
		arg_401_1.duration_ = 5

		SetActive(arg_401_1.tipsGo_, false)

		function arg_401_1.onSingleLineFinish_()
			arg_401_1.onSingleLineUpdate_ = nil
			arg_401_1.onSingleLineFinish_ = nil
			arg_401_1.state_ = "waiting"
		end

		function arg_401_1.playNext_(arg_403_0)
			if arg_403_0 == 1 then
				arg_401_0:Play102601098(arg_401_1)
			end
		end

		function arg_401_1.onSingleLineUpdate_(arg_404_0)
			local var_404_0 = 0.35

			if 0 < arg_401_1.time_ and arg_401_1.time_ <= 0 + arg_404_0 then
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

				local var_404_1 = arg_401_1:FormatText(arg_401_1:GetWordFromCfg(102601097).content)

				arg_401_1.text_.text = var_404_1

				LuaForUtil.ClearLinePrefixSymbol(arg_401_1.text_)

				local var_404_3 = 14 <= 0 and var_404_0 or var_404_0 * (utf8.len(var_404_1) / 14)

				if (14 <= 0 and var_404_0 or var_404_0 * (utf8.len(var_404_1) / 14)) > 0 and var_404_0 < var_404_3 then
					arg_401_1.talkMaxDuration = var_404_3

					if var_404_3 + 0 > arg_401_1.duration_ then
						arg_401_1.duration_ = var_404_3 + 0
					end
				end

				arg_401_1.text_.text = var_404_1
				arg_401_1.typewritter.percent = 0

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(false)
				arg_401_1:RecordContent(arg_401_1.text_.text)
			end

			local var_404_4 = math.max(var_404_0, arg_401_1.talkMaxDuration)

			if 0 <= arg_401_1.time_ and arg_401_1.time_ < 0 + var_404_4 then
				arg_401_1.typewritter.percent = (arg_401_1.time_ - 0) / var_404_4

				arg_401_1.typewritter:SetDirty()
			end

			if arg_401_1.time_ >= 0 + var_404_4 and arg_401_1.time_ < 0 + var_404_4 + arg_404_0 then
				arg_401_1.typewritter.percent = 1

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(true)
			end
		end

		arg_401_1.nodeConfigList_ = {}

		arg_401_1:InitPlayNodeList()
	end,
	Play102601098 = function(arg_405_0, arg_405_1)
		arg_405_1.time_ = 0
		arg_405_1.frameCnt_ = 0
		arg_405_1.state_ = "playing"
		arg_405_1.curTalkId_ = 102601098
		arg_405_1.duration_ = 5

		SetActive(arg_405_1.tipsGo_, false)

		function arg_405_1.onSingleLineFinish_()
			arg_405_1.onSingleLineUpdate_ = nil
			arg_405_1.onSingleLineFinish_ = nil
			arg_405_1.state_ = "waiting"
		end

		function arg_405_1.playNext_(arg_407_0)
			if arg_407_0 == 1 then
				arg_405_0:Play102601099(arg_405_1)
			end
		end

		function arg_405_1.onSingleLineUpdate_(arg_408_0)
			local var_408_0 = 0.425

			if 0 < arg_405_1.time_ and arg_405_1.time_ <= 0 + arg_408_0 then
				arg_405_1.talkMaxDuration = 0
				arg_405_1.dialogCg_.alpha = 1

				arg_405_1.dialog_:SetActive(true)
				SetActive(arg_405_1.leftNameGo_, false)

				arg_405_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_405_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_405_1:RecordName(arg_405_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_405_1.iconTrs_.gameObject, false)
				arg_405_1.callingController_:SetSelectedState("normal")

				local var_408_1 = arg_405_1:FormatText(arg_405_1:GetWordFromCfg(102601098).content)

				arg_405_1.text_.text = var_408_1

				LuaForUtil.ClearLinePrefixSymbol(arg_405_1.text_)

				local var_408_3 = 17 <= 0 and var_408_0 or var_408_0 * (utf8.len(var_408_1) / 17)

				if (17 <= 0 and var_408_0 or var_408_0 * (utf8.len(var_408_1) / 17)) > 0 and var_408_0 < var_408_3 then
					arg_405_1.talkMaxDuration = var_408_3

					if var_408_3 + 0 > arg_405_1.duration_ then
						arg_405_1.duration_ = var_408_3 + 0
					end
				end

				arg_405_1.text_.text = var_408_1
				arg_405_1.typewritter.percent = 0

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(false)
				arg_405_1:RecordContent(arg_405_1.text_.text)
			end

			local var_408_4 = math.max(var_408_0, arg_405_1.talkMaxDuration)

			if 0 <= arg_405_1.time_ and arg_405_1.time_ < 0 + var_408_4 then
				arg_405_1.typewritter.percent = (arg_405_1.time_ - 0) / var_408_4

				arg_405_1.typewritter:SetDirty()
			end

			if arg_405_1.time_ >= 0 + var_408_4 and arg_405_1.time_ < 0 + var_408_4 + arg_408_0 then
				arg_405_1.typewritter.percent = 1

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(true)
			end
		end

		arg_405_1.nodeConfigList_ = {}

		arg_405_1:InitPlayNodeList()
	end,
	Play102601099 = function(arg_409_0, arg_409_1)
		arg_409_1.time_ = 0
		arg_409_1.frameCnt_ = 0
		arg_409_1.state_ = "playing"
		arg_409_1.curTalkId_ = 102601099
		arg_409_1.duration_ = 7.08

		SetActive(arg_409_1.tipsGo_, false)

		function arg_409_1.onSingleLineFinish_()
			arg_409_1.onSingleLineUpdate_ = nil
			arg_409_1.onSingleLineFinish_ = nil
			arg_409_1.state_ = "waiting"
		end

		function arg_409_1.playNext_(arg_411_0)
			if arg_411_0 == 1 then
				arg_409_0:Play102601100(arg_409_1)
			end
		end

		function arg_409_1.onSingleLineUpdate_(arg_412_0)
			if 0 < arg_409_1.time_ and arg_409_1.time_ <= 0 + arg_412_0 then
				local var_412_0 = arg_409_1.bgs_.ST13:GetComponent("SpriteRenderer")

				if var_412_0 then
					arg_409_1.var_.alphaOldValueST13 = var_412_0.color.a
					arg_409_1.var_.alphaMatValueST13 = var_412_0
				end

				arg_409_1.var_.alphaOldValueST13 = 1
			end

			local var_412_1 = 1.5

			if 0 <= arg_409_1.time_ and arg_409_1.time_ < 0 + var_412_1 then
				if arg_409_1.var_.alphaMatValueST13 then
					arg_409_1.var_.alphaMatValueST13.color.a = Mathf.Lerp(arg_409_1.var_.alphaOldValueST13, 0, (arg_409_1.time_ - 0) / var_412_1)
					arg_409_1.var_.alphaMatValueST13.color = arg_409_1.var_.alphaMatValueST13.color
				end
			end

			if arg_409_1.time_ >= 0 + var_412_1 and arg_409_1.time_ < 0 + var_412_1 + arg_412_0 and arg_409_1.var_.alphaMatValueST13 then
				arg_409_1.var_.alphaMatValueST13.color.a = 0
				arg_409_1.var_.alphaMatValueST13.color = arg_409_1.var_.alphaMatValueST13.color
			end

			local var_412_2 = "ST13a"

			if arg_409_1.bgs_.ST13a == nil then
				local var_412_3 = Object.Instantiate(arg_409_1.paintGo_)

				var_412_3:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_412_2)
				var_412_3.name = var_412_2
				var_412_3.transform.parent = arg_409_1.stage_.transform
				var_412_3.transform.localPosition = Vector3.New(0, 100, 0)
				arg_409_1.bgs_[var_412_2] = var_412_3
			end

			if 1.5 < arg_409_1.time_ and arg_409_1.time_ <= 1.5 + arg_412_0 then
				local var_412_4 = arg_409_1.bgs_.ST13a:GetComponent("SpriteRenderer")

				if var_412_4 then
					arg_409_1.var_.alphaOldValueST13a = var_412_4.color.a
					arg_409_1.var_.alphaMatValueST13a = var_412_4
				end

				arg_409_1.var_.alphaOldValueST13a = 0
			end

			local var_412_5 = 1.5

			if 1.5 <= arg_409_1.time_ and arg_409_1.time_ < 1.5 + var_412_5 then
				if arg_409_1.var_.alphaMatValueST13a then
					arg_409_1.var_.alphaMatValueST13a.color.a = Mathf.Lerp(arg_409_1.var_.alphaOldValueST13a, 1, (arg_409_1.time_ - 1.5) / var_412_5)
					arg_409_1.var_.alphaMatValueST13a.color = arg_409_1.var_.alphaMatValueST13a.color
				end
			end

			if arg_409_1.time_ >= 1.5 + var_412_5 and arg_409_1.time_ < 1.5 + var_412_5 + arg_412_0 and arg_409_1.var_.alphaMatValueST13a then
				arg_409_1.var_.alphaMatValueST13a.color.a = 1
				arg_409_1.var_.alphaMatValueST13a.color = arg_409_1.var_.alphaMatValueST13a.color
			end

			if 1.5 < arg_409_1.time_ and arg_409_1.time_ <= 1.5 + arg_412_0 then
				local var_412_6 = arg_409_1.bgs_.ST13a

				arg_409_1.bgs_.ST13a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_412_6.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_412_7 = var_412_6:GetComponent("SpriteRenderer")

				if var_412_7 and var_412_7.sprite then
					local var_412_8 = 2 * (var_412_6.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_412_6.transform.localScale = Vector3.New(var_412_8 / var_412_7.sprite.bounds.size.y < var_412_8 * manager.ui.mainCameraCom_.aspect / var_412_7.sprite.bounds.size.x and var_412_8 * manager.ui.mainCameraCom_.aspect / var_412_7.sprite.bounds.size.x or var_412_8 / var_412_7.sprite.bounds.size.y, var_412_8 / var_412_7.sprite.bounds.size.y < var_412_8 * manager.ui.mainCameraCom_.aspect / var_412_7.sprite.bounds.size.x and var_412_8 * manager.ui.mainCameraCom_.aspect / var_412_7.sprite.bounds.size.x or var_412_8 / var_412_7.sprite.bounds.size.y, 0)
				end

				for iter_412_0, iter_412_1 in pairs(arg_409_1.bgs_) do
					if iter_412_0 ~= "ST13a" then
						iter_412_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_412_9 = 0

			if 0 < arg_409_1.time_ and arg_409_1.time_ <= var_412_9 + arg_412_0 then
				arg_409_1.allBtn_.enabled = false
			end

			if arg_409_1.time_ >= var_412_9 + 2.075 and arg_409_1.time_ < var_412_9 + 2.075 + arg_412_0 then
				arg_409_1.allBtn_.enabled = true
			end

			if arg_409_1.frameCnt_ <= 1 then
				arg_409_1.dialog_:SetActive(false)
			end

			local var_412_10 = 2.075
			local var_412_11 = 0.925

			if 2.075 < arg_409_1.time_ and arg_409_1.time_ <= var_412_10 + arg_412_0 then
				arg_409_1.talkMaxDuration = 0

				arg_409_1.dialog_:SetActive(true)

				arg_409_1.dialogCg_.alpha = 0

				local var_412_12 = LeanTween.value(arg_409_1.dialog_, 0, 1, 0.3)

				var_412_12:setOnUpdate(LuaHelper.FloatAction(function(arg_413_0)
					arg_409_1.dialogCg_.alpha = arg_413_0
				end))
				var_412_12:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_409_1.dialog_)
					var_412_12:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_409_1.duration_ = arg_409_1.duration_ + 0.3

				SetActive(arg_409_1.leftNameGo_, false)

				arg_409_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_409_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_409_1:RecordName(arg_409_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_409_1.iconTrs_.gameObject, false)
				arg_409_1.callingController_:SetSelectedState("normal")

				local var_412_13 = arg_409_1:FormatText(arg_409_1:GetWordFromCfg(102601099).content)

				arg_409_1.text_.text = var_412_13

				LuaForUtil.ClearLinePrefixSymbol(arg_409_1.text_)

				local var_412_15 = 37 <= 0 and var_412_11 or var_412_11 * (utf8.len(var_412_13) / 37)

				if (37 <= 0 and var_412_11 or var_412_11 * (utf8.len(var_412_13) / 37)) > 0 and var_412_11 < var_412_15 then
					arg_409_1.talkMaxDuration = var_412_15
					var_412_10 = var_412_10 + 0.3

					if var_412_15 + var_412_10 > arg_409_1.duration_ then
						arg_409_1.duration_ = var_412_15 + var_412_10
					end
				end

				arg_409_1.text_.text = var_412_13
				arg_409_1.typewritter.percent = 0

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(false)
				arg_409_1:RecordContent(arg_409_1.text_.text)
			end

			local var_412_16 = var_412_10 + 0.3
			local var_412_17 = math.max(var_412_11, arg_409_1.talkMaxDuration)

			if var_412_10 + 0.3 <= arg_409_1.time_ and arg_409_1.time_ < var_412_16 + var_412_17 then
				arg_409_1.typewritter.percent = (arg_409_1.time_ - var_412_16) / var_412_17

				arg_409_1.typewritter:SetDirty()
			end

			if arg_409_1.time_ >= var_412_16 + var_412_17 and arg_409_1.time_ < var_412_16 + var_412_17 + arg_412_0 then
				arg_409_1.typewritter.percent = 1

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(true)
			end
		end

		arg_409_1.nodeConfigList_ = {}

		arg_409_1:InitPlayNodeList()
	end,
	Play102601100 = function(arg_415_0, arg_415_1)
		arg_415_1.time_ = 0
		arg_415_1.frameCnt_ = 0
		arg_415_1.state_ = "playing"
		arg_415_1.curTalkId_ = 102601100
		arg_415_1.duration_ = 2.27

		local var_415_0 = {
			ja = 2.266,
			ko = 1.3,
			zh = 1.033,
			en = 1.3
		}
		local var_415_1 = manager.audio:GetLocalizationFlag()

		if var_415_0[var_415_1] ~= nil then
			arg_415_1.duration_ = var_415_0[var_415_1]
		end

		SetActive(arg_415_1.tipsGo_, false)

		function arg_415_1.onSingleLineFinish_()
			arg_415_1.onSingleLineUpdate_ = nil
			arg_415_1.onSingleLineFinish_ = nil
			arg_415_1.state_ = "waiting"
		end

		function arg_415_1.playNext_(arg_417_0)
			if arg_417_0 == 1 then
				arg_415_0:Play102601101(arg_415_1)
			end
		end

		function arg_415_1.onSingleLineUpdate_(arg_418_0)
			local var_418_0 = 0.1

			if 0 < arg_415_1.time_ and arg_415_1.time_ <= 0 + arg_418_0 then
				arg_415_1.talkMaxDuration = 0
				arg_415_1.dialogCg_.alpha = 1

				arg_415_1.dialog_:SetActive(true)
				SetActive(arg_415_1.leftNameGo_, true)

				arg_415_1.leftNameTxt_.text = arg_415_1:FormatText(StoryNameCfg[83].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_415_1.leftNameTxt_.transform)

				arg_415_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_415_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_415_1:RecordName(arg_415_1.leftNameTxt_.text)
				SetActive(arg_415_1.iconTrs_.gameObject, true)
				arg_415_1.iconController_:SetSelectedState("hero")

				arg_415_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1026")

				arg_415_1.callingController_:SetSelectedState("normal")

				arg_415_1.keyicon_.color = Color.New(1, 1, 1)
				arg_415_1.icon_.color = Color.New(1, 1, 1)

				local var_418_1 = arg_415_1:GetWordFromCfg(102601100)
				local var_418_2 = arg_415_1:FormatText(var_418_1.content)

				arg_415_1.text_.text = var_418_2

				LuaForUtil.ClearLinePrefixSymbol(arg_415_1.text_)

				local var_418_4 = 4 <= 0 and var_418_0 or var_418_0 * (utf8.len(var_418_2) / 4)

				if (4 <= 0 and var_418_0 or var_418_0 * (utf8.len(var_418_2) / 4)) > 0 and var_418_0 < var_418_4 then
					arg_415_1.talkMaxDuration = var_418_4

					if var_418_4 + 0 > arg_415_1.duration_ then
						arg_415_1.duration_ = var_418_4 + 0
					end
				end

				arg_415_1.text_.text = var_418_2
				arg_415_1.typewritter.percent = 0

				arg_415_1.typewritter:SetDirty()
				arg_415_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_102601", "102601100", "story_v_side_old_102601.awb") ~= 0 then
					local var_418_5 = manager.audio:GetVoiceLength("story_v_side_old_102601", "102601100", "story_v_side_old_102601.awb") / 1000

					if var_418_5 + 0 > arg_415_1.duration_ then
						arg_415_1.duration_ = var_418_5 + 0
					end

					if var_418_1.prefab_name ~= "" and arg_415_1.actors_[var_418_1.prefab_name] ~= nil then
						local var_418_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_415_1.actors_[var_418_1.prefab_name].transform, "story_v_side_old_102601", "102601100", "story_v_side_old_102601.awb")

						arg_415_1:RecordAudio("102601100", var_418_6)
						arg_415_1:RecordAudio("102601100", var_418_6)
					else
						arg_415_1:AudioAction("play", "voice", "story_v_side_old_102601", "102601100", "story_v_side_old_102601.awb")
					end

					arg_415_1:RecordHistoryTalkVoice("story_v_side_old_102601", "102601100", "story_v_side_old_102601.awb")
				end

				arg_415_1:RecordContent(arg_415_1.text_.text)
			end

			local var_418_7 = math.max(var_418_0, arg_415_1.talkMaxDuration)

			if 0 <= arg_415_1.time_ and arg_415_1.time_ < 0 + var_418_7 then
				arg_415_1.typewritter.percent = (arg_415_1.time_ - 0) / var_418_7

				arg_415_1.typewritter:SetDirty()
			end

			if arg_415_1.time_ >= 0 + var_418_7 and arg_415_1.time_ < 0 + var_418_7 + arg_418_0 then
				arg_415_1.typewritter.percent = 1

				arg_415_1.typewritter:SetDirty()
				arg_415_1:ShowNextGo(true)
			end
		end

		arg_415_1.nodeConfigList_ = {}

		arg_415_1:InitPlayNodeList()
	end,
	Play102601101 = function(arg_419_0, arg_419_1)
		arg_419_1.time_ = 0
		arg_419_1.frameCnt_ = 0
		arg_419_1.state_ = "playing"
		arg_419_1.curTalkId_ = 102601101
		arg_419_1.duration_ = 5

		SetActive(arg_419_1.tipsGo_, false)

		function arg_419_1.onSingleLineFinish_()
			arg_419_1.onSingleLineUpdate_ = nil
			arg_419_1.onSingleLineFinish_ = nil
			arg_419_1.state_ = "waiting"
		end

		function arg_419_1.playNext_(arg_421_0)
			if arg_421_0 == 1 then
				arg_419_0:Play102601102(arg_419_1)
			end
		end

		function arg_419_1.onSingleLineUpdate_(arg_422_0)
			local var_422_0 = 0.125

			if 0 < arg_419_1.time_ and arg_419_1.time_ <= 0 + arg_422_0 then
				arg_419_1.talkMaxDuration = 0
				arg_419_1.dialogCg_.alpha = 1

				arg_419_1.dialog_:SetActive(true)
				SetActive(arg_419_1.leftNameGo_, true)

				arg_419_1.leftNameTxt_.text = arg_419_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_419_1.leftNameTxt_.transform)

				arg_419_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_419_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_419_1:RecordName(arg_419_1.leftNameTxt_.text)
				SetActive(arg_419_1.iconTrs_.gameObject, true)
				arg_419_1.iconController_:SetSelectedState("hero")

				arg_419_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_419_1.callingController_:SetSelectedState("normal")

				arg_419_1.keyicon_.color = Color.New(1, 1, 1)
				arg_419_1.icon_.color = Color.New(1, 1, 1)

				local var_422_1 = arg_419_1:FormatText(arg_419_1:GetWordFromCfg(102601101).content)

				arg_419_1.text_.text = var_422_1

				LuaForUtil.ClearLinePrefixSymbol(arg_419_1.text_)

				local var_422_3 = 5 <= 0 and var_422_0 or var_422_0 * (utf8.len(var_422_1) / 5)

				if (5 <= 0 and var_422_0 or var_422_0 * (utf8.len(var_422_1) / 5)) > 0 and var_422_0 < var_422_3 then
					arg_419_1.talkMaxDuration = var_422_3

					if var_422_3 + 0 > arg_419_1.duration_ then
						arg_419_1.duration_ = var_422_3 + 0
					end
				end

				arg_419_1.text_.text = var_422_1
				arg_419_1.typewritter.percent = 0

				arg_419_1.typewritter:SetDirty()
				arg_419_1:ShowNextGo(false)
				arg_419_1:RecordContent(arg_419_1.text_.text)
			end

			local var_422_4 = math.max(var_422_0, arg_419_1.talkMaxDuration)

			if 0 <= arg_419_1.time_ and arg_419_1.time_ < 0 + var_422_4 then
				arg_419_1.typewritter.percent = (arg_419_1.time_ - 0) / var_422_4

				arg_419_1.typewritter:SetDirty()
			end

			if arg_419_1.time_ >= 0 + var_422_4 and arg_419_1.time_ < 0 + var_422_4 + arg_422_0 then
				arg_419_1.typewritter.percent = 1

				arg_419_1.typewritter:SetDirty()
				arg_419_1:ShowNextGo(true)
			end
		end

		arg_419_1.nodeConfigList_ = {}

		arg_419_1:InitPlayNodeList()
	end,
	Play102601102 = function(arg_423_0, arg_423_1)
		arg_423_1.time_ = 0
		arg_423_1.frameCnt_ = 0
		arg_423_1.state_ = "playing"
		arg_423_1.curTalkId_ = 102601102
		arg_423_1.duration_ = 6.8

		local var_423_0 = {
			ja = 6.8,
			ko = 3.8,
			zh = 2.9,
			en = 2.766
		}
		local var_423_1 = manager.audio:GetLocalizationFlag()

		if var_423_0[var_423_1] ~= nil then
			arg_423_1.duration_ = var_423_0[var_423_1]
		end

		SetActive(arg_423_1.tipsGo_, false)

		function arg_423_1.onSingleLineFinish_()
			arg_423_1.onSingleLineUpdate_ = nil
			arg_423_1.onSingleLineFinish_ = nil
			arg_423_1.state_ = "waiting"
		end

		function arg_423_1.playNext_(arg_425_0)
			if arg_425_0 == 1 then
				arg_423_0:Play102601103(arg_423_1)
			end
		end

		function arg_423_1.onSingleLineUpdate_(arg_426_0)
			if 0 < arg_423_1.time_ and arg_423_1.time_ <= 0 + arg_426_0 then
				arg_423_1:PlayTimeline("1026ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1204cva")
			end

			local var_426_0 = arg_423_1.actors_["1026ui_story"].transform

			if 0 < arg_423_1.time_ and arg_423_1.time_ <= 0 + arg_426_0 then
				arg_423_1.var_.moveOldPos1026ui_story = var_426_0.localPosition
			end

			local var_426_1 = 0.001

			if 0 <= arg_423_1.time_ and arg_423_1.time_ < 0 + var_426_1 then
				var_426_0.localPosition = Vector3.Lerp(arg_423_1.var_.moveOldPos1026ui_story, Vector3.New(0, -1.05, -6.2), (arg_423_1.time_ - 0) / var_426_1)
				var_426_0.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_426_0.position).x, (manager.ui.mainCamera.transform.position - var_426_0.position).y, (manager.ui.mainCamera.transform.position - var_426_0.position).z)
				var_426_0.localEulerAngles.z = 0
				var_426_0.localEulerAngles.x = 0
				var_426_0.localEulerAngles = var_426_0.localEulerAngles
			end

			if arg_423_1.time_ >= 0 + var_426_1 and arg_423_1.time_ < 0 + var_426_1 + arg_426_0 then
				var_426_0.localPosition = Vector3.New(0, -1.05, -6.2)
				var_426_0.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_426_0.position).x, (manager.ui.mainCamera.transform.position - var_426_0.position).y, (manager.ui.mainCamera.transform.position - var_426_0.position).z)
				var_426_0.localEulerAngles.z = 0
				var_426_0.localEulerAngles.x = 0
				var_426_0.localEulerAngles = var_426_0.localEulerAngles
			end

			local var_426_2 = arg_423_1.actors_["1026ui_story"]

			if 0 < arg_423_1.time_ and arg_423_1.time_ <= 0 + arg_426_0 and not isNil(var_426_2) and arg_423_1.var_.characterEffect1026ui_story == nil then
				arg_423_1.var_.characterEffect1026ui_story = var_426_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_426_3 = 0.2

			if 0 <= arg_423_1.time_ and arg_423_1.time_ < 0 + var_426_3 and not isNil(var_426_2) then
				if arg_423_1.var_.characterEffect1026ui_story and not isNil(var_426_2) then
					arg_423_1.var_.characterEffect1026ui_story.fillFlat = false
				end
			end

			if arg_423_1.time_ >= 0 + var_426_3 and arg_423_1.time_ < 0 + var_426_3 + arg_426_0 and not isNil(var_426_2) and arg_423_1.var_.characterEffect1026ui_story then
				arg_423_1.var_.characterEffect1026ui_story.fillFlat = false
			end

			if 0 < arg_423_1.time_ and arg_423_1.time_ <= 0 + arg_426_0 then
				arg_423_1:PlayTimeline("1026ui_story", "StoryTimeline/CharAction/story1026/story1026action/1026action1_1")
			end

			local var_426_5 = 0
			local var_426_6 = 0.35

			if 0 < arg_423_1.time_ and arg_423_1.time_ <= var_426_5 + arg_426_0 then
				arg_423_1.talkMaxDuration = 0
				arg_423_1.dialogCg_.alpha = 1

				arg_423_1.dialog_:SetActive(true)
				SetActive(arg_423_1.leftNameGo_, true)

				arg_423_1.leftNameTxt_.text = arg_423_1:FormatText(StoryNameCfg[83].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_423_1.leftNameTxt_.transform)

				arg_423_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_423_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_423_1:RecordName(arg_423_1.leftNameTxt_.text)
				SetActive(arg_423_1.iconTrs_.gameObject, false)
				arg_423_1.callingController_:SetSelectedState("normal")

				local var_426_7 = arg_423_1:GetWordFromCfg(102601102)
				local var_426_8 = arg_423_1:FormatText(var_426_7.content)

				arg_423_1.text_.text = var_426_8

				LuaForUtil.ClearLinePrefixSymbol(arg_423_1.text_)

				local var_426_10 = 14 <= 0 and var_426_6 or var_426_6 * (utf8.len(var_426_8) / 14)

				if (14 <= 0 and var_426_6 or var_426_6 * (utf8.len(var_426_8) / 14)) > 0 and var_426_6 < var_426_10 then
					arg_423_1.talkMaxDuration = var_426_10

					if var_426_10 + var_426_5 > arg_423_1.duration_ then
						arg_423_1.duration_ = var_426_10 + var_426_5
					end
				end

				arg_423_1.text_.text = var_426_8
				arg_423_1.typewritter.percent = 0

				arg_423_1.typewritter:SetDirty()
				arg_423_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_102601", "102601102", "story_v_side_old_102601.awb") ~= 0 then
					local var_426_11 = manager.audio:GetVoiceLength("story_v_side_old_102601", "102601102", "story_v_side_old_102601.awb") / 1000

					if var_426_11 + var_426_5 > arg_423_1.duration_ then
						arg_423_1.duration_ = var_426_11 + var_426_5
					end

					if var_426_7.prefab_name ~= "" and arg_423_1.actors_[var_426_7.prefab_name] ~= nil then
						local var_426_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_423_1.actors_[var_426_7.prefab_name].transform, "story_v_side_old_102601", "102601102", "story_v_side_old_102601.awb")

						arg_423_1:RecordAudio("102601102", var_426_12)
						arg_423_1:RecordAudio("102601102", var_426_12)
					else
						arg_423_1:AudioAction("play", "voice", "story_v_side_old_102601", "102601102", "story_v_side_old_102601.awb")
					end

					arg_423_1:RecordHistoryTalkVoice("story_v_side_old_102601", "102601102", "story_v_side_old_102601.awb")
				end

				arg_423_1:RecordContent(arg_423_1.text_.text)
			end

			local var_426_13 = math.max(var_426_6, arg_423_1.talkMaxDuration)

			if var_426_5 <= arg_423_1.time_ and arg_423_1.time_ < var_426_5 + var_426_13 then
				arg_423_1.typewritter.percent = (arg_423_1.time_ - var_426_5) / var_426_13

				arg_423_1.typewritter:SetDirty()
			end

			if arg_423_1.time_ >= var_426_5 + var_426_13 and arg_423_1.time_ < var_426_5 + var_426_13 + arg_426_0 then
				arg_423_1.typewritter.percent = 1

				arg_423_1.typewritter:SetDirty()
				arg_423_1:ShowNextGo(true)
			end
		end

		arg_423_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1026ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_423_1:InitPlayNodeList()
	end,
	Play102601103 = function(arg_427_0, arg_427_1)
		arg_427_1.time_ = 0
		arg_427_1.frameCnt_ = 0
		arg_427_1.state_ = "playing"
		arg_427_1.curTalkId_ = 102601103
		arg_427_1.duration_ = 5

		SetActive(arg_427_1.tipsGo_, false)

		function arg_427_1.onSingleLineFinish_()
			arg_427_1.onSingleLineUpdate_ = nil
			arg_427_1.onSingleLineFinish_ = nil
			arg_427_1.state_ = "waiting"
		end

		function arg_427_1.playNext_(arg_429_0)
			if arg_429_0 == 1 then
				arg_427_0:Play102601104(arg_427_1)
			end
		end

		function arg_427_1.onSingleLineUpdate_(arg_430_0)
			if 0 < arg_427_1.time_ and arg_427_1.time_ <= 0 + arg_430_0 then
				arg_427_1.var_.moveOldPos1026ui_story = arg_427_1.actors_["1026ui_story"].transform.localPosition
			end

			local var_430_0 = 0.001

			if 0 <= arg_427_1.time_ and arg_427_1.time_ < 0 + var_430_0 then
				arg_427_1.actors_["1026ui_story"].transform.localPosition = Vector3.Lerp(arg_427_1.var_.moveOldPos1026ui_story, Vector3.New(0, 100, 0), (arg_427_1.time_ - 0) / var_430_0)
				arg_427_1.actors_["1026ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_427_1.actors_["1026ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_427_1.actors_["1026ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_427_1.actors_["1026ui_story"].transform.position).z)
				arg_427_1.actors_["1026ui_story"].transform.localEulerAngles.z = 0
				arg_427_1.actors_["1026ui_story"].transform.localEulerAngles.x = 0
				arg_427_1.actors_["1026ui_story"].transform.localEulerAngles = arg_427_1.actors_["1026ui_story"].transform.localEulerAngles
			end

			if arg_427_1.time_ >= 0 + var_430_0 and arg_427_1.time_ < 0 + var_430_0 + arg_430_0 then
				arg_427_1.actors_["1026ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_427_1.actors_["1026ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_427_1.actors_["1026ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_427_1.actors_["1026ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_427_1.actors_["1026ui_story"].transform.position).z)
				arg_427_1.actors_["1026ui_story"].transform.localEulerAngles.z = 0
				arg_427_1.actors_["1026ui_story"].transform.localEulerAngles.x = 0
				arg_427_1.actors_["1026ui_story"].transform.localEulerAngles = arg_427_1.actors_["1026ui_story"].transform.localEulerAngles
			end

			local var_430_1 = 0
			local var_430_2 = 0.375

			if 0 < arg_427_1.time_ and arg_427_1.time_ <= var_430_1 + arg_430_0 then
				arg_427_1.talkMaxDuration = 0
				arg_427_1.dialogCg_.alpha = 1

				arg_427_1.dialog_:SetActive(true)
				SetActive(arg_427_1.leftNameGo_, false)

				arg_427_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_427_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_427_1:RecordName(arg_427_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_427_1.iconTrs_.gameObject, false)
				arg_427_1.callingController_:SetSelectedState("normal")

				local var_430_3 = arg_427_1:FormatText(arg_427_1:GetWordFromCfg(102601103).content)

				arg_427_1.text_.text = var_430_3

				LuaForUtil.ClearLinePrefixSymbol(arg_427_1.text_)

				local var_430_5 = 15 <= 0 and var_430_2 or var_430_2 * (utf8.len(var_430_3) / 15)

				if (15 <= 0 and var_430_2 or var_430_2 * (utf8.len(var_430_3) / 15)) > 0 and var_430_2 < var_430_5 then
					arg_427_1.talkMaxDuration = var_430_5

					if var_430_5 + var_430_1 > arg_427_1.duration_ then
						arg_427_1.duration_ = var_430_5 + var_430_1
					end
				end

				arg_427_1.text_.text = var_430_3
				arg_427_1.typewritter.percent = 0

				arg_427_1.typewritter:SetDirty()
				arg_427_1:ShowNextGo(false)
				arg_427_1:RecordContent(arg_427_1.text_.text)
			end

			local var_430_6 = math.max(var_430_2, arg_427_1.talkMaxDuration)

			if var_430_1 <= arg_427_1.time_ and arg_427_1.time_ < var_430_1 + var_430_6 then
				arg_427_1.typewritter.percent = (arg_427_1.time_ - var_430_1) / var_430_6

				arg_427_1.typewritter:SetDirty()
			end

			if arg_427_1.time_ >= var_430_1 + var_430_6 and arg_427_1.time_ < var_430_1 + var_430_6 + arg_430_0 then
				arg_427_1.typewritter.percent = 1

				arg_427_1.typewritter:SetDirty()
				arg_427_1:ShowNextGo(true)
			end
		end

		arg_427_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1026ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_427_1:InitPlayNodeList()
	end,
	Play102601104 = function(arg_431_0, arg_431_1)
		arg_431_1.time_ = 0
		arg_431_1.frameCnt_ = 0
		arg_431_1.state_ = "playing"
		arg_431_1.curTalkId_ = 102601104
		arg_431_1.duration_ = 5

		SetActive(arg_431_1.tipsGo_, false)

		function arg_431_1.onSingleLineFinish_()
			arg_431_1.onSingleLineUpdate_ = nil
			arg_431_1.onSingleLineFinish_ = nil
			arg_431_1.state_ = "waiting"
		end

		function arg_431_1.playNext_(arg_433_0)
			if arg_433_0 == 1 then
				arg_431_0:Play102601105(arg_431_1)
			end
		end

		function arg_431_1.onSingleLineUpdate_(arg_434_0)
			local var_434_0 = 0.225

			if 0 < arg_431_1.time_ and arg_431_1.time_ <= 0 + arg_434_0 then
				arg_431_1.talkMaxDuration = 0
				arg_431_1.dialogCg_.alpha = 1

				arg_431_1.dialog_:SetActive(true)
				SetActive(arg_431_1.leftNameGo_, false)

				arg_431_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_431_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_431_1:RecordName(arg_431_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_431_1.iconTrs_.gameObject, false)
				arg_431_1.callingController_:SetSelectedState("normal")

				local var_434_1 = arg_431_1:FormatText(arg_431_1:GetWordFromCfg(102601104).content)

				arg_431_1.text_.text = var_434_1

				LuaForUtil.ClearLinePrefixSymbol(arg_431_1.text_)

				local var_434_3 = 8 <= 0 and var_434_0 or var_434_0 * (utf8.len(var_434_1) / 8)

				if (8 <= 0 and var_434_0 or var_434_0 * (utf8.len(var_434_1) / 8)) > 0 and var_434_0 < var_434_3 then
					arg_431_1.talkMaxDuration = var_434_3

					if var_434_3 + 0 > arg_431_1.duration_ then
						arg_431_1.duration_ = var_434_3 + 0
					end
				end

				arg_431_1.text_.text = var_434_1
				arg_431_1.typewritter.percent = 0

				arg_431_1.typewritter:SetDirty()
				arg_431_1:ShowNextGo(false)
				arg_431_1:RecordContent(arg_431_1.text_.text)
			end

			local var_434_4 = math.max(var_434_0, arg_431_1.talkMaxDuration)

			if 0 <= arg_431_1.time_ and arg_431_1.time_ < 0 + var_434_4 then
				arg_431_1.typewritter.percent = (arg_431_1.time_ - 0) / var_434_4

				arg_431_1.typewritter:SetDirty()
			end

			if arg_431_1.time_ >= 0 + var_434_4 and arg_431_1.time_ < 0 + var_434_4 + arg_434_0 then
				arg_431_1.typewritter.percent = 1

				arg_431_1.typewritter:SetDirty()
				arg_431_1:ShowNextGo(true)
			end
		end

		arg_431_1.nodeConfigList_ = {}

		arg_431_1:InitPlayNodeList()
	end,
	Play102601105 = function(arg_435_0, arg_435_1)
		arg_435_1.time_ = 0
		arg_435_1.frameCnt_ = 0
		arg_435_1.state_ = "playing"
		arg_435_1.curTalkId_ = 102601105
		arg_435_1.duration_ = 5

		SetActive(arg_435_1.tipsGo_, false)

		function arg_435_1.onSingleLineFinish_()
			arg_435_1.onSingleLineUpdate_ = nil
			arg_435_1.onSingleLineFinish_ = nil
			arg_435_1.state_ = "waiting"
		end

		function arg_435_1.playNext_(arg_437_0)
			if arg_437_0 == 1 then
				arg_435_0:Play102601106(arg_435_1)
			end
		end

		function arg_435_1.onSingleLineUpdate_(arg_438_0)
			local var_438_0 = 0.7

			if 0 < arg_435_1.time_ and arg_435_1.time_ <= 0 + arg_438_0 then
				arg_435_1.talkMaxDuration = 0
				arg_435_1.dialogCg_.alpha = 1

				arg_435_1.dialog_:SetActive(true)
				SetActive(arg_435_1.leftNameGo_, false)

				arg_435_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_435_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_435_1:RecordName(arg_435_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_435_1.iconTrs_.gameObject, false)
				arg_435_1.callingController_:SetSelectedState("normal")

				local var_438_1 = arg_435_1:FormatText(arg_435_1:GetWordFromCfg(102601105).content)

				arg_435_1.text_.text = var_438_1

				LuaForUtil.ClearLinePrefixSymbol(arg_435_1.text_)

				local var_438_3 = 28 <= 0 and var_438_0 or var_438_0 * (utf8.len(var_438_1) / 28)

				if (28 <= 0 and var_438_0 or var_438_0 * (utf8.len(var_438_1) / 28)) > 0 and var_438_0 < var_438_3 then
					arg_435_1.talkMaxDuration = var_438_3

					if var_438_3 + 0 > arg_435_1.duration_ then
						arg_435_1.duration_ = var_438_3 + 0
					end
				end

				arg_435_1.text_.text = var_438_1
				arg_435_1.typewritter.percent = 0

				arg_435_1.typewritter:SetDirty()
				arg_435_1:ShowNextGo(false)
				arg_435_1:RecordContent(arg_435_1.text_.text)
			end

			local var_438_4 = math.max(var_438_0, arg_435_1.talkMaxDuration)

			if 0 <= arg_435_1.time_ and arg_435_1.time_ < 0 + var_438_4 then
				arg_435_1.typewritter.percent = (arg_435_1.time_ - 0) / var_438_4

				arg_435_1.typewritter:SetDirty()
			end

			if arg_435_1.time_ >= 0 + var_438_4 and arg_435_1.time_ < 0 + var_438_4 + arg_438_0 then
				arg_435_1.typewritter.percent = 1

				arg_435_1.typewritter:SetDirty()
				arg_435_1:ShowNextGo(true)
			end
		end

		arg_435_1.nodeConfigList_ = {}

		arg_435_1:InitPlayNodeList()
	end,
	Play102601106 = function(arg_439_0, arg_439_1)
		arg_439_1.time_ = 0
		arg_439_1.frameCnt_ = 0
		arg_439_1.state_ = "playing"
		arg_439_1.curTalkId_ = 102601106
		arg_439_1.duration_ = 5

		SetActive(arg_439_1.tipsGo_, false)

		function arg_439_1.onSingleLineFinish_()
			arg_439_1.onSingleLineUpdate_ = nil
			arg_439_1.onSingleLineFinish_ = nil
			arg_439_1.state_ = "waiting"
		end

		function arg_439_1.playNext_(arg_441_0)
			if arg_441_0 == 1 then
				arg_439_0:Play102601107(arg_439_1)
			end
		end

		function arg_439_1.onSingleLineUpdate_(arg_442_0)
			if 0 < arg_439_1.time_ and arg_439_1.time_ <= 0 + arg_442_0 then
				arg_439_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_442_0 = 0.6

			if 0 <= arg_439_1.time_ and arg_439_1.time_ < 0 + var_442_0 then
				local var_442_1, var_442_2 = math.modf((arg_439_1.time_ - 0) / 0)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_442_2 * 0, var_442_2 * 0, var_442_2 * 0) + arg_439_1.var_.shakeOldPos
			end

			if arg_439_1.time_ >= 0 + var_442_0 and arg_439_1.time_ < 0 + var_442_0 + arg_442_0 then
				manager.ui.mainCamera.transform.localPosition = arg_439_1.var_.shakeOldPos
			end

			local var_442_3 = 0
			local var_442_4 = 0.4

			if 0 < arg_439_1.time_ and arg_439_1.time_ <= var_442_3 + arg_442_0 then
				arg_439_1.talkMaxDuration = 0
				arg_439_1.dialogCg_.alpha = 1

				arg_439_1.dialog_:SetActive(true)
				SetActive(arg_439_1.leftNameGo_, true)

				arg_439_1.leftNameTxt_.text = arg_439_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_439_1.leftNameTxt_.transform)

				arg_439_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_439_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_439_1:RecordName(arg_439_1.leftNameTxt_.text)
				SetActive(arg_439_1.iconTrs_.gameObject, true)
				arg_439_1.iconController_:SetSelectedState("hero")

				arg_439_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_439_1.callingController_:SetSelectedState("normal")

				arg_439_1.keyicon_.color = Color.New(1, 1, 1)
				arg_439_1.icon_.color = Color.New(1, 1, 1)

				local var_442_5 = arg_439_1:FormatText(arg_439_1:GetWordFromCfg(102601106).content)

				arg_439_1.text_.text = var_442_5

				LuaForUtil.ClearLinePrefixSymbol(arg_439_1.text_)

				local var_442_7 = 16 <= 0 and var_442_4 or var_442_4 * (utf8.len(var_442_5) / 16)

				if (16 <= 0 and var_442_4 or var_442_4 * (utf8.len(var_442_5) / 16)) > 0 and var_442_4 < var_442_7 then
					arg_439_1.talkMaxDuration = var_442_7

					if var_442_7 + var_442_3 > arg_439_1.duration_ then
						arg_439_1.duration_ = var_442_7 + var_442_3
					end
				end

				arg_439_1.text_.text = var_442_5
				arg_439_1.typewritter.percent = 0

				arg_439_1.typewritter:SetDirty()
				arg_439_1:ShowNextGo(false)
				arg_439_1:RecordContent(arg_439_1.text_.text)
			end

			local var_442_8 = math.max(var_442_4, arg_439_1.talkMaxDuration)

			if var_442_3 <= arg_439_1.time_ and arg_439_1.time_ < var_442_3 + var_442_8 then
				arg_439_1.typewritter.percent = (arg_439_1.time_ - var_442_3) / var_442_8

				arg_439_1.typewritter:SetDirty()
			end

			if arg_439_1.time_ >= var_442_3 + var_442_8 and arg_439_1.time_ < var_442_3 + var_442_8 + arg_442_0 then
				arg_439_1.typewritter.percent = 1

				arg_439_1.typewritter:SetDirty()
				arg_439_1:ShowNextGo(true)
			end
		end

		arg_439_1.nodeConfigList_ = {}

		arg_439_1:InitPlayNodeList()
	end,
	Play102601107 = function(arg_443_0, arg_443_1)
		arg_443_1.time_ = 0
		arg_443_1.frameCnt_ = 0
		arg_443_1.state_ = "playing"
		arg_443_1.curTalkId_ = 102601107
		arg_443_1.duration_ = 5

		SetActive(arg_443_1.tipsGo_, false)

		function arg_443_1.onSingleLineFinish_()
			arg_443_1.onSingleLineUpdate_ = nil
			arg_443_1.onSingleLineFinish_ = nil
			arg_443_1.state_ = "waiting"
		end

		function arg_443_1.playNext_(arg_445_0)
			if arg_445_0 == 1 then
				arg_443_0:Play102601108(arg_443_1)
			end
		end

		function arg_443_1.onSingleLineUpdate_(arg_446_0)
			local var_446_0 = 0.325

			if 0 < arg_443_1.time_ and arg_443_1.time_ <= 0 + arg_446_0 then
				arg_443_1.talkMaxDuration = 0
				arg_443_1.dialogCg_.alpha = 1

				arg_443_1.dialog_:SetActive(true)
				SetActive(arg_443_1.leftNameGo_, false)

				arg_443_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_443_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_443_1:RecordName(arg_443_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_443_1.iconTrs_.gameObject, false)
				arg_443_1.callingController_:SetSelectedState("normal")

				local var_446_1 = arg_443_1:FormatText(arg_443_1:GetWordFromCfg(102601107).content)

				arg_443_1.text_.text = var_446_1

				LuaForUtil.ClearLinePrefixSymbol(arg_443_1.text_)

				local var_446_3 = 13 <= 0 and var_446_0 or var_446_0 * (utf8.len(var_446_1) / 13)

				if (13 <= 0 and var_446_0 or var_446_0 * (utf8.len(var_446_1) / 13)) > 0 and var_446_0 < var_446_3 then
					arg_443_1.talkMaxDuration = var_446_3

					if var_446_3 + 0 > arg_443_1.duration_ then
						arg_443_1.duration_ = var_446_3 + 0
					end
				end

				arg_443_1.text_.text = var_446_1
				arg_443_1.typewritter.percent = 0

				arg_443_1.typewritter:SetDirty()
				arg_443_1:ShowNextGo(false)
				arg_443_1:RecordContent(arg_443_1.text_.text)
			end

			local var_446_4 = math.max(var_446_0, arg_443_1.talkMaxDuration)

			if 0 <= arg_443_1.time_ and arg_443_1.time_ < 0 + var_446_4 then
				arg_443_1.typewritter.percent = (arg_443_1.time_ - 0) / var_446_4

				arg_443_1.typewritter:SetDirty()
			end

			if arg_443_1.time_ >= 0 + var_446_4 and arg_443_1.time_ < 0 + var_446_4 + arg_446_0 then
				arg_443_1.typewritter.percent = 1

				arg_443_1.typewritter:SetDirty()
				arg_443_1:ShowNextGo(true)
			end
		end

		arg_443_1.nodeConfigList_ = {}

		arg_443_1:InitPlayNodeList()
	end,
	Play102601108 = function(arg_447_0, arg_447_1)
		arg_447_1.time_ = 0
		arg_447_1.frameCnt_ = 0
		arg_447_1.state_ = "playing"
		arg_447_1.curTalkId_ = 102601108
		arg_447_1.duration_ = 3.73

		local var_447_0 = {
			ja = 3.733,
			ko = 2.233,
			zh = 1.999999999999,
			en = 2.2
		}
		local var_447_1 = manager.audio:GetLocalizationFlag()

		if var_447_0[var_447_1] ~= nil then
			arg_447_1.duration_ = var_447_0[var_447_1]
		end

		SetActive(arg_447_1.tipsGo_, false)

		function arg_447_1.onSingleLineFinish_()
			arg_447_1.onSingleLineUpdate_ = nil
			arg_447_1.onSingleLineFinish_ = nil
			arg_447_1.state_ = "waiting"
		end

		function arg_447_1.playNext_(arg_449_0)
			if arg_449_0 == 1 then
				arg_447_0:Play102601109(arg_447_1)
			end
		end

		function arg_447_1.onSingleLineUpdate_(arg_450_0)
			if 0 < arg_447_1.time_ and arg_447_1.time_ <= 0 + arg_450_0 then
				arg_447_1:PlayTimeline("1026ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_450_0 = arg_447_1.actors_["1026ui_story"].transform

			if 0 < arg_447_1.time_ and arg_447_1.time_ <= 0 + arg_450_0 then
				arg_447_1.var_.moveOldPos1026ui_story = var_450_0.localPosition
			end

			local var_450_1 = 0.001

			if 0 <= arg_447_1.time_ and arg_447_1.time_ < 0 + var_450_1 then
				var_450_0.localPosition = Vector3.Lerp(arg_447_1.var_.moveOldPos1026ui_story, Vector3.New(0, -1.05, -6.2), (arg_447_1.time_ - 0) / var_450_1)
				var_450_0.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_450_0.position).x, (manager.ui.mainCamera.transform.position - var_450_0.position).y, (manager.ui.mainCamera.transform.position - var_450_0.position).z)
				var_450_0.localEulerAngles.z = 0
				var_450_0.localEulerAngles.x = 0
				var_450_0.localEulerAngles = var_450_0.localEulerAngles
			end

			if arg_447_1.time_ >= 0 + var_450_1 and arg_447_1.time_ < 0 + var_450_1 + arg_450_0 then
				var_450_0.localPosition = Vector3.New(0, -1.05, -6.2)
				var_450_0.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_450_0.position).x, (manager.ui.mainCamera.transform.position - var_450_0.position).y, (manager.ui.mainCamera.transform.position - var_450_0.position).z)
				var_450_0.localEulerAngles.z = 0
				var_450_0.localEulerAngles.x = 0
				var_450_0.localEulerAngles = var_450_0.localEulerAngles
			end

			local var_450_2 = arg_447_1.actors_["1026ui_story"]

			if 0 < arg_447_1.time_ and arg_447_1.time_ <= 0 + arg_450_0 and not isNil(var_450_2) and arg_447_1.var_.characterEffect1026ui_story == nil then
				arg_447_1.var_.characterEffect1026ui_story = var_450_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_450_3 = 0.2

			if 0 <= arg_447_1.time_ and arg_447_1.time_ < 0 + var_450_3 and not isNil(var_450_2) then
				if arg_447_1.var_.characterEffect1026ui_story and not isNil(var_450_2) then
					arg_447_1.var_.characterEffect1026ui_story.fillFlat = false
				end
			end

			if arg_447_1.time_ >= 0 + var_450_3 and arg_447_1.time_ < 0 + var_450_3 + arg_450_0 and not isNil(var_450_2) and arg_447_1.var_.characterEffect1026ui_story then
				arg_447_1.var_.characterEffect1026ui_story.fillFlat = false
			end

			if 0 < arg_447_1.time_ and arg_447_1.time_ <= 0 + arg_450_0 then
				arg_447_1:PlayTimeline("1026ui_story", "StoryTimeline/CharAction/story1026/story1026action/1026action3_1")
			end

			local var_450_5 = 0
			local var_450_6 = 0.175

			if 0 < arg_447_1.time_ and arg_447_1.time_ <= var_450_5 + arg_450_0 then
				arg_447_1.talkMaxDuration = 0
				arg_447_1.dialogCg_.alpha = 1

				arg_447_1.dialog_:SetActive(true)
				SetActive(arg_447_1.leftNameGo_, true)

				arg_447_1.leftNameTxt_.text = arg_447_1:FormatText(StoryNameCfg[83].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_447_1.leftNameTxt_.transform)

				arg_447_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_447_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_447_1:RecordName(arg_447_1.leftNameTxt_.text)
				SetActive(arg_447_1.iconTrs_.gameObject, false)
				arg_447_1.callingController_:SetSelectedState("normal")

				local var_450_7 = arg_447_1:GetWordFromCfg(102601108)
				local var_450_8 = arg_447_1:FormatText(var_450_7.content)

				arg_447_1.text_.text = var_450_8

				LuaForUtil.ClearLinePrefixSymbol(arg_447_1.text_)

				local var_450_10 = 7 <= 0 and var_450_6 or var_450_6 * (utf8.len(var_450_8) / 7)

				if (7 <= 0 and var_450_6 or var_450_6 * (utf8.len(var_450_8) / 7)) > 0 and var_450_6 < var_450_10 then
					arg_447_1.talkMaxDuration = var_450_10

					if var_450_10 + var_450_5 > arg_447_1.duration_ then
						arg_447_1.duration_ = var_450_10 + var_450_5
					end
				end

				arg_447_1.text_.text = var_450_8
				arg_447_1.typewritter.percent = 0

				arg_447_1.typewritter:SetDirty()
				arg_447_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_102601", "102601108", "story_v_side_old_102601.awb") ~= 0 then
					local var_450_11 = manager.audio:GetVoiceLength("story_v_side_old_102601", "102601108", "story_v_side_old_102601.awb") / 1000

					if var_450_11 + var_450_5 > arg_447_1.duration_ then
						arg_447_1.duration_ = var_450_11 + var_450_5
					end

					if var_450_7.prefab_name ~= "" and arg_447_1.actors_[var_450_7.prefab_name] ~= nil then
						local var_450_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_447_1.actors_[var_450_7.prefab_name].transform, "story_v_side_old_102601", "102601108", "story_v_side_old_102601.awb")

						arg_447_1:RecordAudio("102601108", var_450_12)
						arg_447_1:RecordAudio("102601108", var_450_12)
					else
						arg_447_1:AudioAction("play", "voice", "story_v_side_old_102601", "102601108", "story_v_side_old_102601.awb")
					end

					arg_447_1:RecordHistoryTalkVoice("story_v_side_old_102601", "102601108", "story_v_side_old_102601.awb")
				end

				arg_447_1:RecordContent(arg_447_1.text_.text)
			end

			local var_450_13 = math.max(var_450_6, arg_447_1.talkMaxDuration)

			if var_450_5 <= arg_447_1.time_ and arg_447_1.time_ < var_450_5 + var_450_13 then
				arg_447_1.typewritter.percent = (arg_447_1.time_ - var_450_5) / var_450_13

				arg_447_1.typewritter:SetDirty()
			end

			if arg_447_1.time_ >= var_450_5 + var_450_13 and arg_447_1.time_ < var_450_5 + var_450_13 + arg_450_0 then
				arg_447_1.typewritter.percent = 1

				arg_447_1.typewritter:SetDirty()
				arg_447_1:ShowNextGo(true)
			end
		end

		arg_447_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1026ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_447_1:InitPlayNodeList()
	end,
	Play102601109 = function(arg_451_0, arg_451_1)
		arg_451_1.time_ = 0
		arg_451_1.frameCnt_ = 0
		arg_451_1.state_ = "playing"
		arg_451_1.curTalkId_ = 102601109
		arg_451_1.duration_ = 5

		SetActive(arg_451_1.tipsGo_, false)

		function arg_451_1.onSingleLineFinish_()
			arg_451_1.onSingleLineUpdate_ = nil
			arg_451_1.onSingleLineFinish_ = nil
			arg_451_1.state_ = "waiting"
		end

		function arg_451_1.playNext_(arg_453_0)
			if arg_453_0 == 1 then
				arg_451_0:Play102601110(arg_451_1)
			end
		end

		function arg_451_1.onSingleLineUpdate_(arg_454_0)
			if 0 < arg_451_1.time_ and arg_451_1.time_ <= 0 + arg_454_0 and not isNil(arg_451_1.actors_["1026ui_story"]) and arg_451_1.var_.characterEffect1026ui_story == nil then
				arg_451_1.var_.characterEffect1026ui_story = arg_451_1.actors_["1026ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_454_0 = 0.2

			if 0 <= arg_451_1.time_ and arg_451_1.time_ < 0 + var_454_0 and not isNil(arg_451_1.actors_["1026ui_story"]) then
				if arg_451_1.var_.characterEffect1026ui_story and not isNil(arg_451_1.actors_["1026ui_story"]) then
					arg_451_1.var_.characterEffect1026ui_story.fillFlat = true
					arg_451_1.var_.characterEffect1026ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_451_1.time_ - 0) / var_454_0)
				end
			end

			if arg_451_1.time_ >= 0 + var_454_0 and arg_451_1.time_ < 0 + var_454_0 + arg_454_0 and not isNil(arg_451_1.actors_["1026ui_story"]) and arg_451_1.var_.characterEffect1026ui_story then
				arg_451_1.var_.characterEffect1026ui_story.fillFlat = true
				arg_451_1.var_.characterEffect1026ui_story.fillRatio = 0.5
			end

			local var_454_1 = 0
			local var_454_2 = 0.15

			if 0 < arg_451_1.time_ and arg_451_1.time_ <= var_454_1 + arg_454_0 then
				arg_451_1.talkMaxDuration = 0
				arg_451_1.dialogCg_.alpha = 1

				arg_451_1.dialog_:SetActive(true)
				SetActive(arg_451_1.leftNameGo_, true)

				arg_451_1.leftNameTxt_.text = arg_451_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_451_1.leftNameTxt_.transform)

				arg_451_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_451_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_451_1:RecordName(arg_451_1.leftNameTxt_.text)
				SetActive(arg_451_1.iconTrs_.gameObject, true)
				arg_451_1.iconController_:SetSelectedState("hero")

				arg_451_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_451_1.callingController_:SetSelectedState("normal")

				arg_451_1.keyicon_.color = Color.New(1, 1, 1)
				arg_451_1.icon_.color = Color.New(1, 1, 1)

				local var_454_3 = arg_451_1:FormatText(arg_451_1:GetWordFromCfg(102601109).content)

				arg_451_1.text_.text = var_454_3

				LuaForUtil.ClearLinePrefixSymbol(arg_451_1.text_)

				local var_454_5 = 6 <= 0 and var_454_2 or var_454_2 * (utf8.len(var_454_3) / 6)

				if (6 <= 0 and var_454_2 or var_454_2 * (utf8.len(var_454_3) / 6)) > 0 and var_454_2 < var_454_5 then
					arg_451_1.talkMaxDuration = var_454_5

					if var_454_5 + var_454_1 > arg_451_1.duration_ then
						arg_451_1.duration_ = var_454_5 + var_454_1
					end
				end

				arg_451_1.text_.text = var_454_3
				arg_451_1.typewritter.percent = 0

				arg_451_1.typewritter:SetDirty()
				arg_451_1:ShowNextGo(false)
				arg_451_1:RecordContent(arg_451_1.text_.text)
			end

			local var_454_6 = math.max(var_454_2, arg_451_1.talkMaxDuration)

			if var_454_1 <= arg_451_1.time_ and arg_451_1.time_ < var_454_1 + var_454_6 then
				arg_451_1.typewritter.percent = (arg_451_1.time_ - var_454_1) / var_454_6

				arg_451_1.typewritter:SetDirty()
			end

			if arg_451_1.time_ >= var_454_1 + var_454_6 and arg_451_1.time_ < var_454_1 + var_454_6 + arg_454_0 then
				arg_451_1.typewritter.percent = 1

				arg_451_1.typewritter:SetDirty()
				arg_451_1:ShowNextGo(true)
			end
		end

		arg_451_1.nodeConfigList_ = {}

		arg_451_1:InitPlayNodeList()
	end,
	Play102601110 = function(arg_455_0, arg_455_1)
		arg_455_1.time_ = 0
		arg_455_1.frameCnt_ = 0
		arg_455_1.state_ = "playing"
		arg_455_1.curTalkId_ = 102601110
		arg_455_1.duration_ = 5

		SetActive(arg_455_1.tipsGo_, false)

		function arg_455_1.onSingleLineFinish_()
			arg_455_1.onSingleLineUpdate_ = nil
			arg_455_1.onSingleLineFinish_ = nil
			arg_455_1.state_ = "waiting"
		end

		function arg_455_1.playNext_(arg_457_0)
			if arg_457_0 == 1 then
				arg_455_0:Play102601111(arg_455_1)
			end
		end

		function arg_455_1.onSingleLineUpdate_(arg_458_0)
			if 0 < arg_455_1.time_ and arg_455_1.time_ <= 0 + arg_458_0 then
				arg_455_1.var_.moveOldPos1026ui_story = arg_455_1.actors_["1026ui_story"].transform.localPosition
			end

			local var_458_0 = 0.001

			if 0 <= arg_455_1.time_ and arg_455_1.time_ < 0 + var_458_0 then
				arg_455_1.actors_["1026ui_story"].transform.localPosition = Vector3.Lerp(arg_455_1.var_.moveOldPos1026ui_story, Vector3.New(0, 100, 0), (arg_455_1.time_ - 0) / var_458_0)
				arg_455_1.actors_["1026ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_455_1.actors_["1026ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_455_1.actors_["1026ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_455_1.actors_["1026ui_story"].transform.position).z)
				arg_455_1.actors_["1026ui_story"].transform.localEulerAngles.z = 0
				arg_455_1.actors_["1026ui_story"].transform.localEulerAngles.x = 0
				arg_455_1.actors_["1026ui_story"].transform.localEulerAngles = arg_455_1.actors_["1026ui_story"].transform.localEulerAngles
			end

			if arg_455_1.time_ >= 0 + var_458_0 and arg_455_1.time_ < 0 + var_458_0 + arg_458_0 then
				arg_455_1.actors_["1026ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_455_1.actors_["1026ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_455_1.actors_["1026ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_455_1.actors_["1026ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_455_1.actors_["1026ui_story"].transform.position).z)
				arg_455_1.actors_["1026ui_story"].transform.localEulerAngles.z = 0
				arg_455_1.actors_["1026ui_story"].transform.localEulerAngles.x = 0
				arg_455_1.actors_["1026ui_story"].transform.localEulerAngles = arg_455_1.actors_["1026ui_story"].transform.localEulerAngles
			end

			local var_458_1 = 0
			local var_458_2 = 0.95

			if 0 < arg_455_1.time_ and arg_455_1.time_ <= var_458_1 + arg_458_0 then
				arg_455_1.talkMaxDuration = 0
				arg_455_1.dialogCg_.alpha = 1

				arg_455_1.dialog_:SetActive(true)
				SetActive(arg_455_1.leftNameGo_, false)

				arg_455_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_455_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_455_1:RecordName(arg_455_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_455_1.iconTrs_.gameObject, false)
				arg_455_1.callingController_:SetSelectedState("normal")

				local var_458_3 = arg_455_1:FormatText(arg_455_1:GetWordFromCfg(102601110).content)

				arg_455_1.text_.text = var_458_3

				LuaForUtil.ClearLinePrefixSymbol(arg_455_1.text_)

				local var_458_5 = 38 <= 0 and var_458_2 or var_458_2 * (utf8.len(var_458_3) / 38)

				if (38 <= 0 and var_458_2 or var_458_2 * (utf8.len(var_458_3) / 38)) > 0 and var_458_2 < var_458_5 then
					arg_455_1.talkMaxDuration = var_458_5

					if var_458_5 + var_458_1 > arg_455_1.duration_ then
						arg_455_1.duration_ = var_458_5 + var_458_1
					end
				end

				arg_455_1.text_.text = var_458_3
				arg_455_1.typewritter.percent = 0

				arg_455_1.typewritter:SetDirty()
				arg_455_1:ShowNextGo(false)
				arg_455_1:RecordContent(arg_455_1.text_.text)
			end

			local var_458_6 = math.max(var_458_2, arg_455_1.talkMaxDuration)

			if var_458_1 <= arg_455_1.time_ and arg_455_1.time_ < var_458_1 + var_458_6 then
				arg_455_1.typewritter.percent = (arg_455_1.time_ - var_458_1) / var_458_6

				arg_455_1.typewritter:SetDirty()
			end

			if arg_455_1.time_ >= var_458_1 + var_458_6 and arg_455_1.time_ < var_458_1 + var_458_6 + arg_458_0 then
				arg_455_1.typewritter.percent = 1

				arg_455_1.typewritter:SetDirty()
				arg_455_1:ShowNextGo(true)
			end
		end

		arg_455_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1026ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_455_1:InitPlayNodeList()
	end,
	Play102601111 = function(arg_459_0, arg_459_1)
		arg_459_1.time_ = 0
		arg_459_1.frameCnt_ = 0
		arg_459_1.state_ = "playing"
		arg_459_1.curTalkId_ = 102601111
		arg_459_1.duration_ = 5

		SetActive(arg_459_1.tipsGo_, false)

		function arg_459_1.onSingleLineFinish_()
			arg_459_1.onSingleLineUpdate_ = nil
			arg_459_1.onSingleLineFinish_ = nil
			arg_459_1.state_ = "waiting"
		end

		function arg_459_1.playNext_(arg_461_0)
			if arg_461_0 == 1 then
				arg_459_0:Play102601112(arg_459_1)
			end
		end

		function arg_459_1.onSingleLineUpdate_(arg_462_0)
			local var_462_0 = 0.925

			if 0 < arg_459_1.time_ and arg_459_1.time_ <= 0 + arg_462_0 then
				arg_459_1.talkMaxDuration = 0
				arg_459_1.dialogCg_.alpha = 1

				arg_459_1.dialog_:SetActive(true)
				SetActive(arg_459_1.leftNameGo_, false)

				arg_459_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_459_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_459_1:RecordName(arg_459_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_459_1.iconTrs_.gameObject, false)
				arg_459_1.callingController_:SetSelectedState("normal")

				local var_462_1 = arg_459_1:FormatText(arg_459_1:GetWordFromCfg(102601111).content)

				arg_459_1.text_.text = var_462_1

				LuaForUtil.ClearLinePrefixSymbol(arg_459_1.text_)

				local var_462_3 = 37 <= 0 and var_462_0 or var_462_0 * (utf8.len(var_462_1) / 37)

				if (37 <= 0 and var_462_0 or var_462_0 * (utf8.len(var_462_1) / 37)) > 0 and var_462_0 < var_462_3 then
					arg_459_1.talkMaxDuration = var_462_3

					if var_462_3 + 0 > arg_459_1.duration_ then
						arg_459_1.duration_ = var_462_3 + 0
					end
				end

				arg_459_1.text_.text = var_462_1
				arg_459_1.typewritter.percent = 0

				arg_459_1.typewritter:SetDirty()
				arg_459_1:ShowNextGo(false)
				arg_459_1:RecordContent(arg_459_1.text_.text)
			end

			local var_462_4 = math.max(var_462_0, arg_459_1.talkMaxDuration)

			if 0 <= arg_459_1.time_ and arg_459_1.time_ < 0 + var_462_4 then
				arg_459_1.typewritter.percent = (arg_459_1.time_ - 0) / var_462_4

				arg_459_1.typewritter:SetDirty()
			end

			if arg_459_1.time_ >= 0 + var_462_4 and arg_459_1.time_ < 0 + var_462_4 + arg_462_0 then
				arg_459_1.typewritter.percent = 1

				arg_459_1.typewritter:SetDirty()
				arg_459_1:ShowNextGo(true)
			end
		end

		arg_459_1.nodeConfigList_ = {}

		arg_459_1:InitPlayNodeList()
	end,
	Play102601112 = function(arg_463_0, arg_463_1)
		arg_463_1.time_ = 0
		arg_463_1.frameCnt_ = 0
		arg_463_1.state_ = "playing"
		arg_463_1.curTalkId_ = 102601112
		arg_463_1.duration_ = 5

		SetActive(arg_463_1.tipsGo_, false)

		function arg_463_1.onSingleLineFinish_()
			arg_463_1.onSingleLineUpdate_ = nil
			arg_463_1.onSingleLineFinish_ = nil
			arg_463_1.state_ = "waiting"
		end

		function arg_463_1.playNext_(arg_465_0)
			if arg_465_0 == 1 then
				arg_463_0:Play102601113(arg_463_1)
			end
		end

		function arg_463_1.onSingleLineUpdate_(arg_466_0)
			local var_466_0 = 0.225

			if 0 < arg_463_1.time_ and arg_463_1.time_ <= 0 + arg_466_0 then
				arg_463_1.talkMaxDuration = 0
				arg_463_1.dialogCg_.alpha = 1

				arg_463_1.dialog_:SetActive(true)
				SetActive(arg_463_1.leftNameGo_, false)

				arg_463_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_463_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_463_1:RecordName(arg_463_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_463_1.iconTrs_.gameObject, false)
				arg_463_1.callingController_:SetSelectedState("normal")

				local var_466_1 = arg_463_1:FormatText(arg_463_1:GetWordFromCfg(102601112).content)

				arg_463_1.text_.text = var_466_1

				LuaForUtil.ClearLinePrefixSymbol(arg_463_1.text_)

				local var_466_3 = 9 <= 0 and var_466_0 or var_466_0 * (utf8.len(var_466_1) / 9)

				if (9 <= 0 and var_466_0 or var_466_0 * (utf8.len(var_466_1) / 9)) > 0 and var_466_0 < var_466_3 then
					arg_463_1.talkMaxDuration = var_466_3

					if var_466_3 + 0 > arg_463_1.duration_ then
						arg_463_1.duration_ = var_466_3 + 0
					end
				end

				arg_463_1.text_.text = var_466_1
				arg_463_1.typewritter.percent = 0

				arg_463_1.typewritter:SetDirty()
				arg_463_1:ShowNextGo(false)
				arg_463_1:RecordContent(arg_463_1.text_.text)
			end

			local var_466_4 = math.max(var_466_0, arg_463_1.talkMaxDuration)

			if 0 <= arg_463_1.time_ and arg_463_1.time_ < 0 + var_466_4 then
				arg_463_1.typewritter.percent = (arg_463_1.time_ - 0) / var_466_4

				arg_463_1.typewritter:SetDirty()
			end

			if arg_463_1.time_ >= 0 + var_466_4 and arg_463_1.time_ < 0 + var_466_4 + arg_466_0 then
				arg_463_1.typewritter.percent = 1

				arg_463_1.typewritter:SetDirty()
				arg_463_1:ShowNextGo(true)
			end
		end

		arg_463_1.nodeConfigList_ = {}

		arg_463_1:InitPlayNodeList()
	end,
	Play102601113 = function(arg_467_0, arg_467_1)
		arg_467_1.time_ = 0
		arg_467_1.frameCnt_ = 0
		arg_467_1.state_ = "playing"
		arg_467_1.curTalkId_ = 102601113
		arg_467_1.duration_ = 7.4

		SetActive(arg_467_1.tipsGo_, false)

		function arg_467_1.onSingleLineFinish_()
			arg_467_1.onSingleLineUpdate_ = nil
			arg_467_1.onSingleLineFinish_ = nil
			arg_467_1.state_ = "waiting"
		end

		function arg_467_1.playNext_(arg_469_0)
			if arg_469_0 == 1 then
				arg_467_0:Play102601114(arg_467_1)
			end
		end

		function arg_467_1.onSingleLineUpdate_(arg_470_0)
			if 0 < arg_467_1.time_ and arg_467_1.time_ <= 0 + arg_470_0 then
				local var_470_0 = arg_467_1.bgs_.ST13a:GetComponent("SpriteRenderer")

				if var_470_0 then
					arg_467_1.var_.alphaOldValueST13a = var_470_0.color.a
					arg_467_1.var_.alphaMatValueST13a = var_470_0
				end

				arg_467_1.var_.alphaOldValueST13a = 1
			end

			local var_470_1 = 1.5

			if 0 <= arg_467_1.time_ and arg_467_1.time_ < 0 + var_470_1 then
				if arg_467_1.var_.alphaMatValueST13a then
					arg_467_1.var_.alphaMatValueST13a.color.a = Mathf.Lerp(arg_467_1.var_.alphaOldValueST13a, 0, (arg_467_1.time_ - 0) / var_470_1)
					arg_467_1.var_.alphaMatValueST13a.color = arg_467_1.var_.alphaMatValueST13a.color
				end
			end

			if arg_467_1.time_ >= 0 + var_470_1 and arg_467_1.time_ < 0 + var_470_1 + arg_470_0 and arg_467_1.var_.alphaMatValueST13a then
				arg_467_1.var_.alphaMatValueST13a.color.a = 0
				arg_467_1.var_.alphaMatValueST13a.color = arg_467_1.var_.alphaMatValueST13a.color
			end

			local var_470_2 = "ST03"

			if arg_467_1.bgs_.ST03 == nil then
				local var_470_3 = Object.Instantiate(arg_467_1.paintGo_)

				var_470_3:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_470_2)
				var_470_3.name = var_470_2
				var_470_3.transform.parent = arg_467_1.stage_.transform
				var_470_3.transform.localPosition = Vector3.New(0, 100, 0)
				arg_467_1.bgs_[var_470_2] = var_470_3
			end

			if 1.5 < arg_467_1.time_ and arg_467_1.time_ <= 1.5 + arg_470_0 then
				local var_470_4 = arg_467_1.bgs_.ST03:GetComponent("SpriteRenderer")

				if var_470_4 then
					arg_467_1.var_.alphaOldValueST03 = var_470_4.color.a
					arg_467_1.var_.alphaMatValueST03 = var_470_4
				end

				arg_467_1.var_.alphaOldValueST03 = 0
			end

			local var_470_5 = 1.5

			if 1.5 <= arg_467_1.time_ and arg_467_1.time_ < 1.5 + var_470_5 then
				if arg_467_1.var_.alphaMatValueST03 then
					arg_467_1.var_.alphaMatValueST03.color.a = Mathf.Lerp(arg_467_1.var_.alphaOldValueST03, 1, (arg_467_1.time_ - 1.5) / var_470_5)
					arg_467_1.var_.alphaMatValueST03.color = arg_467_1.var_.alphaMatValueST03.color
				end
			end

			if arg_467_1.time_ >= 1.5 + var_470_5 and arg_467_1.time_ < 1.5 + var_470_5 + arg_470_0 and arg_467_1.var_.alphaMatValueST03 then
				arg_467_1.var_.alphaMatValueST03.color.a = 1
				arg_467_1.var_.alphaMatValueST03.color = arg_467_1.var_.alphaMatValueST03.color
			end

			if 1.5 < arg_467_1.time_ and arg_467_1.time_ <= 1.5 + arg_470_0 then
				local var_470_6 = arg_467_1.bgs_.ST03

				arg_467_1.bgs_.ST03.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_470_6.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_470_7 = var_470_6:GetComponent("SpriteRenderer")

				if var_470_7 and var_470_7.sprite then
					local var_470_8 = 2 * (var_470_6.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_470_6.transform.localScale = Vector3.New(var_470_8 / var_470_7.sprite.bounds.size.y < var_470_8 * manager.ui.mainCameraCom_.aspect / var_470_7.sprite.bounds.size.x and var_470_8 * manager.ui.mainCameraCom_.aspect / var_470_7.sprite.bounds.size.x or var_470_8 / var_470_7.sprite.bounds.size.y, var_470_8 / var_470_7.sprite.bounds.size.y < var_470_8 * manager.ui.mainCameraCom_.aspect / var_470_7.sprite.bounds.size.x and var_470_8 * manager.ui.mainCameraCom_.aspect / var_470_7.sprite.bounds.size.x or var_470_8 / var_470_7.sprite.bounds.size.y, 0)
				end

				for iter_470_0, iter_470_1 in pairs(arg_467_1.bgs_) do
					if iter_470_0 ~= "ST03" then
						iter_470_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_470_9 = 0

			if 0 < arg_467_1.time_ and arg_467_1.time_ <= var_470_9 + arg_470_0 then
				arg_467_1.allBtn_.enabled = false
			end

			if arg_467_1.time_ >= var_470_9 + 2.4 and arg_467_1.time_ < var_470_9 + 2.4 + arg_470_0 then
				arg_467_1.allBtn_.enabled = true
			end

			if arg_467_1.frameCnt_ <= 1 then
				arg_467_1.dialog_:SetActive(false)
			end

			local var_470_10 = 2.4
			local var_470_11 = 0.6

			if 2.4 < arg_467_1.time_ and arg_467_1.time_ <= var_470_10 + arg_470_0 then
				arg_467_1.talkMaxDuration = 0

				arg_467_1.dialog_:SetActive(true)

				arg_467_1.dialogCg_.alpha = 0

				local var_470_12 = LeanTween.value(arg_467_1.dialog_, 0, 1, 0.3)

				var_470_12:setOnUpdate(LuaHelper.FloatAction(function(arg_471_0)
					arg_467_1.dialogCg_.alpha = arg_471_0
				end))
				var_470_12:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_467_1.dialog_)
					var_470_12:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_467_1.duration_ = arg_467_1.duration_ + 0.3

				SetActive(arg_467_1.leftNameGo_, false)

				arg_467_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_467_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_467_1:RecordName(arg_467_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_467_1.iconTrs_.gameObject, false)
				arg_467_1.callingController_:SetSelectedState("normal")

				local var_470_13 = arg_467_1:FormatText(arg_467_1:GetWordFromCfg(102601113).content)

				arg_467_1.text_.text = var_470_13

				LuaForUtil.ClearLinePrefixSymbol(arg_467_1.text_)

				local var_470_15 = 24 <= 0 and var_470_11 or var_470_11 * (utf8.len(var_470_13) / 24)

				if (24 <= 0 and var_470_11 or var_470_11 * (utf8.len(var_470_13) / 24)) > 0 and var_470_11 < var_470_15 then
					arg_467_1.talkMaxDuration = var_470_15
					var_470_10 = var_470_10 + 0.3

					if var_470_15 + var_470_10 > arg_467_1.duration_ then
						arg_467_1.duration_ = var_470_15 + var_470_10
					end
				end

				arg_467_1.text_.text = var_470_13
				arg_467_1.typewritter.percent = 0

				arg_467_1.typewritter:SetDirty()
				arg_467_1:ShowNextGo(false)
				arg_467_1:RecordContent(arg_467_1.text_.text)
			end

			local var_470_16 = var_470_10 + 0.3
			local var_470_17 = math.max(var_470_11, arg_467_1.talkMaxDuration)

			if var_470_10 + 0.3 <= arg_467_1.time_ and arg_467_1.time_ < var_470_16 + var_470_17 then
				arg_467_1.typewritter.percent = (arg_467_1.time_ - var_470_16) / var_470_17

				arg_467_1.typewritter:SetDirty()
			end

			if arg_467_1.time_ >= var_470_16 + var_470_17 and arg_467_1.time_ < var_470_16 + var_470_17 + arg_470_0 then
				arg_467_1.typewritter.percent = 1

				arg_467_1.typewritter:SetDirty()
				arg_467_1:ShowNextGo(true)
			end
		end

		arg_467_1.nodeConfigList_ = {}

		arg_467_1:InitPlayNodeList()
	end,
	Play102601114 = function(arg_473_0, arg_473_1)
		arg_473_1.time_ = 0
		arg_473_1.frameCnt_ = 0
		arg_473_1.state_ = "playing"
		arg_473_1.curTalkId_ = 102601114
		arg_473_1.duration_ = 5

		SetActive(arg_473_1.tipsGo_, false)

		function arg_473_1.onSingleLineFinish_()
			arg_473_1.onSingleLineUpdate_ = nil
			arg_473_1.onSingleLineFinish_ = nil
			arg_473_1.state_ = "waiting"
		end

		function arg_473_1.playNext_(arg_475_0)
			if arg_475_0 == 1 then
				arg_473_0:Play102601115(arg_473_1)
			end
		end

		function arg_473_1.onSingleLineUpdate_(arg_476_0)
			local var_476_0 = 0.125

			if 0 < arg_473_1.time_ and arg_473_1.time_ <= 0 + arg_476_0 then
				arg_473_1.talkMaxDuration = 0
				arg_473_1.dialogCg_.alpha = 1

				arg_473_1.dialog_:SetActive(true)
				SetActive(arg_473_1.leftNameGo_, true)

				arg_473_1.leftNameTxt_.text = arg_473_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_473_1.leftNameTxt_.transform)

				arg_473_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_473_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_473_1:RecordName(arg_473_1.leftNameTxt_.text)
				SetActive(arg_473_1.iconTrs_.gameObject, true)
				arg_473_1.iconController_:SetSelectedState("hero")

				arg_473_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_473_1.callingController_:SetSelectedState("normal")

				arg_473_1.keyicon_.color = Color.New(1, 1, 1)
				arg_473_1.icon_.color = Color.New(1, 1, 1)

				local var_476_1 = arg_473_1:FormatText(arg_473_1:GetWordFromCfg(102601114).content)

				arg_473_1.text_.text = var_476_1

				LuaForUtil.ClearLinePrefixSymbol(arg_473_1.text_)

				local var_476_3 = 5 <= 0 and var_476_0 or var_476_0 * (utf8.len(var_476_1) / 5)

				if (5 <= 0 and var_476_0 or var_476_0 * (utf8.len(var_476_1) / 5)) > 0 and var_476_0 < var_476_3 then
					arg_473_1.talkMaxDuration = var_476_3

					if var_476_3 + 0 > arg_473_1.duration_ then
						arg_473_1.duration_ = var_476_3 + 0
					end
				end

				arg_473_1.text_.text = var_476_1
				arg_473_1.typewritter.percent = 0

				arg_473_1.typewritter:SetDirty()
				arg_473_1:ShowNextGo(false)
				arg_473_1:RecordContent(arg_473_1.text_.text)
			end

			local var_476_4 = math.max(var_476_0, arg_473_1.talkMaxDuration)

			if 0 <= arg_473_1.time_ and arg_473_1.time_ < 0 + var_476_4 then
				arg_473_1.typewritter.percent = (arg_473_1.time_ - 0) / var_476_4

				arg_473_1.typewritter:SetDirty()
			end

			if arg_473_1.time_ >= 0 + var_476_4 and arg_473_1.time_ < 0 + var_476_4 + arg_476_0 then
				arg_473_1.typewritter.percent = 1

				arg_473_1.typewritter:SetDirty()
				arg_473_1:ShowNextGo(true)
			end
		end

		arg_473_1.nodeConfigList_ = {}

		arg_473_1:InitPlayNodeList()
	end,
	Play102601115 = function(arg_477_0, arg_477_1)
		arg_477_1.time_ = 0
		arg_477_1.frameCnt_ = 0
		arg_477_1.state_ = "playing"
		arg_477_1.curTalkId_ = 102601115
		arg_477_1.duration_ = 5

		SetActive(arg_477_1.tipsGo_, false)

		function arg_477_1.onSingleLineFinish_()
			arg_477_1.onSingleLineUpdate_ = nil
			arg_477_1.onSingleLineFinish_ = nil
			arg_477_1.state_ = "waiting"
		end

		function arg_477_1.playNext_(arg_479_0)
			if arg_479_0 == 1 then
				arg_477_0:Play102601116(arg_477_1)
			end
		end

		function arg_477_1.onSingleLineUpdate_(arg_480_0)
			if 0 < arg_477_1.time_ and arg_477_1.time_ <= 0 + arg_480_0 then
				arg_477_1.var_.moveOldPosST03 = arg_477_1.bgs_.ST03.transform.localPosition
			end

			local var_480_0 = 2

			if 0 <= arg_477_1.time_ and arg_477_1.time_ < 0 + var_480_0 then
				arg_477_1.bgs_.ST03.transform.localPosition = Vector3.Lerp(arg_477_1.var_.moveOldPosST03, Vector3.New(0, 0.9, 9.5), (arg_477_1.time_ - 0) / var_480_0)
			end

			if arg_477_1.time_ >= 0 + var_480_0 and arg_477_1.time_ < 0 + var_480_0 + arg_480_0 then
				arg_477_1.bgs_.ST03.transform.localPosition = Vector3.New(0, 0.9, 9.5)
			end

			local var_480_1 = 0

			if 0 < arg_477_1.time_ and arg_477_1.time_ <= var_480_1 + arg_480_0 then
				arg_477_1.allBtn_.enabled = false
			end

			if arg_477_1.time_ >= var_480_1 + 2 and arg_477_1.time_ < var_480_1 + 2 + arg_480_0 then
				arg_477_1.allBtn_.enabled = true
			end

			if 0.352302199229598 < arg_477_1.time_ and arg_477_1.time_ <= 0.352302199229598 + arg_480_0 then
				arg_477_1:AudioAction("play", "effect", "se_story_side_1026", "se_story_1026_uav_whoosh", "")
			end

			if 0.352302199229598 < arg_477_1.time_ and arg_477_1.time_ <= 0.352302199229598 + arg_480_0 then
				arg_477_1:AudioAction("play", "music", "bgm_side_daily06", "bgm_side_daily06", "bgm_side_daily06.awb")

				local var_480_5 = manager.audio:GetAudioName("bgm_side_daily06", "bgm_side_daily06")

				if "" ~= "" then
					if arg_477_1.bgmTxt_.text ~= var_480_5 and arg_477_1.bgmTxt_.text ~= "" then
						if arg_477_1.bgmTxt2_.text ~= "" then
							arg_477_1.bgmTxt_.text = arg_477_1.bgmTxt2_.text
						end

						arg_477_1.bgmTxt2_.text = var_480_5

						arg_477_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_477_1.bgmTxt_.text = var_480_5
						arg_477_1.bgmTxt2_.text = var_480_5
					end

					if arg_477_1.bgmTimer then
						arg_477_1.bgmTimer:Stop()

						arg_477_1.bgmTimer = nil
					end

					if arg_477_1.settingData.show_music_name == 1 then
						arg_477_1.musicController:SetSelectedState("show")
						arg_477_1.musicAnimator_:Play("open", 0, 0)

						if arg_477_1.settingData.music_time ~= 0 then
							arg_477_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_477_1.settingData.music_time), function()
								if arg_477_1 == nil or isNil(arg_477_1.bgmTxt_) then
									return
								end

								arg_477_1.musicController:SetSelectedState("hide")
								arg_477_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_480_6 = 0
			local var_480_7 = 0.425

			if 0 < arg_477_1.time_ and arg_477_1.time_ <= var_480_6 + arg_480_0 then
				arg_477_1.talkMaxDuration = 0
				arg_477_1.dialogCg_.alpha = 1

				arg_477_1.dialog_:SetActive(true)
				SetActive(arg_477_1.leftNameGo_, false)

				arg_477_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_477_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_477_1:RecordName(arg_477_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_477_1.iconTrs_.gameObject, false)
				arg_477_1.callingController_:SetSelectedState("normal")

				local var_480_8 = arg_477_1:FormatText(arg_477_1:GetWordFromCfg(102601115).content)

				arg_477_1.text_.text = var_480_8

				LuaForUtil.ClearLinePrefixSymbol(arg_477_1.text_)

				local var_480_10 = 17 <= 0 and var_480_7 or var_480_7 * (utf8.len(var_480_8) / 17)

				if (17 <= 0 and var_480_7 or var_480_7 * (utf8.len(var_480_8) / 17)) > 0 and var_480_7 < var_480_10 then
					arg_477_1.talkMaxDuration = var_480_10

					if var_480_10 + var_480_6 > arg_477_1.duration_ then
						arg_477_1.duration_ = var_480_10 + var_480_6
					end
				end

				arg_477_1.text_.text = var_480_8
				arg_477_1.typewritter.percent = 0

				arg_477_1.typewritter:SetDirty()
				arg_477_1:ShowNextGo(false)
				arg_477_1:RecordContent(arg_477_1.text_.text)
			end

			local var_480_11 = math.max(var_480_7, arg_477_1.talkMaxDuration)

			if var_480_6 <= arg_477_1.time_ and arg_477_1.time_ < var_480_6 + var_480_11 then
				arg_477_1.typewritter.percent = (arg_477_1.time_ - var_480_6) / var_480_11

				arg_477_1.typewritter:SetDirty()
			end

			if arg_477_1.time_ >= var_480_6 + var_480_11 and arg_477_1.time_ < var_480_6 + var_480_11 + arg_480_0 then
				arg_477_1.typewritter.percent = 1

				arg_477_1.typewritter:SetDirty()
				arg_477_1:ShowNextGo(true)
			end
		end

		arg_477_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "ST03",
				changeDisplayLayer = false,
				needEase = false,
				duration = 2,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_477_1:InitPlayNodeList()
	end,
	Play102601116 = function(arg_482_0, arg_482_1)
		arg_482_1.time_ = 0
		arg_482_1.frameCnt_ = 0
		arg_482_1.state_ = "playing"
		arg_482_1.curTalkId_ = 102601116
		arg_482_1.duration_ = 5

		SetActive(arg_482_1.tipsGo_, false)

		function arg_482_1.onSingleLineFinish_()
			arg_482_1.onSingleLineUpdate_ = nil
			arg_482_1.onSingleLineFinish_ = nil
			arg_482_1.state_ = "waiting"
		end

		function arg_482_1.playNext_(arg_484_0)
			if arg_484_0 == 1 then
				arg_482_0:Play102601117(arg_482_1)
			end
		end

		function arg_482_1.onSingleLineUpdate_(arg_485_0)
			local var_485_0 = 0.925

			if 0 < arg_482_1.time_ and arg_482_1.time_ <= 0 + arg_485_0 then
				arg_482_1.talkMaxDuration = 0
				arg_482_1.dialogCg_.alpha = 1

				arg_482_1.dialog_:SetActive(true)
				SetActive(arg_482_1.leftNameGo_, false)

				arg_482_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_482_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_482_1:RecordName(arg_482_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_482_1.iconTrs_.gameObject, false)
				arg_482_1.callingController_:SetSelectedState("normal")

				local var_485_1 = arg_482_1:FormatText(arg_482_1:GetWordFromCfg(102601116).content)

				arg_482_1.text_.text = var_485_1

				LuaForUtil.ClearLinePrefixSymbol(arg_482_1.text_)

				local var_485_3 = 37 <= 0 and var_485_0 or var_485_0 * (utf8.len(var_485_1) / 37)

				if (37 <= 0 and var_485_0 or var_485_0 * (utf8.len(var_485_1) / 37)) > 0 and var_485_0 < var_485_3 then
					arg_482_1.talkMaxDuration = var_485_3

					if var_485_3 + 0 > arg_482_1.duration_ then
						arg_482_1.duration_ = var_485_3 + 0
					end
				end

				arg_482_1.text_.text = var_485_1
				arg_482_1.typewritter.percent = 0

				arg_482_1.typewritter:SetDirty()
				arg_482_1:ShowNextGo(false)
				arg_482_1:RecordContent(arg_482_1.text_.text)
			end

			local var_485_4 = math.max(var_485_0, arg_482_1.talkMaxDuration)

			if 0 <= arg_482_1.time_ and arg_482_1.time_ < 0 + var_485_4 then
				arg_482_1.typewritter.percent = (arg_482_1.time_ - 0) / var_485_4

				arg_482_1.typewritter:SetDirty()
			end

			if arg_482_1.time_ >= 0 + var_485_4 and arg_482_1.time_ < 0 + var_485_4 + arg_485_0 then
				arg_482_1.typewritter.percent = 1

				arg_482_1.typewritter:SetDirty()
				arg_482_1:ShowNextGo(true)
			end
		end

		arg_482_1.nodeConfigList_ = {}

		arg_482_1:InitPlayNodeList()
	end,
	Play102601117 = function(arg_486_0, arg_486_1)
		arg_486_1.time_ = 0
		arg_486_1.frameCnt_ = 0
		arg_486_1.state_ = "playing"
		arg_486_1.curTalkId_ = 102601117
		arg_486_1.duration_ = 5

		SetActive(arg_486_1.tipsGo_, false)

		function arg_486_1.onSingleLineFinish_()
			arg_486_1.onSingleLineUpdate_ = nil
			arg_486_1.onSingleLineFinish_ = nil
			arg_486_1.state_ = "waiting"
		end

		function arg_486_1.playNext_(arg_488_0)
			if arg_488_0 == 1 then
				arg_486_0:Play102601118(arg_486_1)
			end
		end

		function arg_486_1.onSingleLineUpdate_(arg_489_0)
			if 0 < arg_486_1.time_ and arg_486_1.time_ <= 0 + arg_489_0 then
				arg_486_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_489_0 = 0.6

			if 0 <= arg_486_1.time_ and arg_486_1.time_ < 0 + var_489_0 then
				local var_489_1, var_489_2 = math.modf((arg_486_1.time_ - 0) / 0)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_489_2 * 0, var_489_2 * 0, var_489_2 * 0) + arg_486_1.var_.shakeOldPos
			end

			if arg_486_1.time_ >= 0 + var_489_0 and arg_486_1.time_ < 0 + var_489_0 + arg_489_0 then
				manager.ui.mainCamera.transform.localPosition = arg_486_1.var_.shakeOldPos
			end

			local var_489_3 = 0
			local var_489_4 = 0.1

			if 0 < arg_486_1.time_ and arg_486_1.time_ <= var_489_3 + arg_489_0 then
				arg_486_1.talkMaxDuration = 0
				arg_486_1.dialogCg_.alpha = 1

				arg_486_1.dialog_:SetActive(true)
				SetActive(arg_486_1.leftNameGo_, true)

				arg_486_1.leftNameTxt_.text = arg_486_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_486_1.leftNameTxt_.transform)

				arg_486_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_486_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_486_1:RecordName(arg_486_1.leftNameTxt_.text)
				SetActive(arg_486_1.iconTrs_.gameObject, true)
				arg_486_1.iconController_:SetSelectedState("hero")

				arg_486_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_486_1.callingController_:SetSelectedState("normal")

				arg_486_1.keyicon_.color = Color.New(1, 1, 1)
				arg_486_1.icon_.color = Color.New(1, 1, 1)

				local var_489_5 = arg_486_1:FormatText(arg_486_1:GetWordFromCfg(102601117).content)

				arg_486_1.text_.text = var_489_5

				LuaForUtil.ClearLinePrefixSymbol(arg_486_1.text_)

				local var_489_7 = 4 <= 0 and var_489_4 or var_489_4 * (utf8.len(var_489_5) / 4)

				if (4 <= 0 and var_489_4 or var_489_4 * (utf8.len(var_489_5) / 4)) > 0 and var_489_4 < var_489_7 then
					arg_486_1.talkMaxDuration = var_489_7

					if var_489_7 + var_489_3 > arg_486_1.duration_ then
						arg_486_1.duration_ = var_489_7 + var_489_3
					end
				end

				arg_486_1.text_.text = var_489_5
				arg_486_1.typewritter.percent = 0

				arg_486_1.typewritter:SetDirty()
				arg_486_1:ShowNextGo(false)
				arg_486_1:RecordContent(arg_486_1.text_.text)
			end

			local var_489_8 = math.max(var_489_4, arg_486_1.talkMaxDuration)

			if var_489_3 <= arg_486_1.time_ and arg_486_1.time_ < var_489_3 + var_489_8 then
				arg_486_1.typewritter.percent = (arg_486_1.time_ - var_489_3) / var_489_8

				arg_486_1.typewritter:SetDirty()
			end

			if arg_486_1.time_ >= var_489_3 + var_489_8 and arg_486_1.time_ < var_489_3 + var_489_8 + arg_489_0 then
				arg_486_1.typewritter.percent = 1

				arg_486_1.typewritter:SetDirty()
				arg_486_1:ShowNextGo(true)
			end
		end

		arg_486_1.nodeConfigList_ = {}

		arg_486_1:InitPlayNodeList()
	end,
	Play102601118 = function(arg_490_0, arg_490_1)
		arg_490_1.time_ = 0
		arg_490_1.frameCnt_ = 0
		arg_490_1.state_ = "playing"
		arg_490_1.curTalkId_ = 102601118
		arg_490_1.duration_ = 5

		SetActive(arg_490_1.tipsGo_, false)

		function arg_490_1.onSingleLineFinish_()
			arg_490_1.onSingleLineUpdate_ = nil
			arg_490_1.onSingleLineFinish_ = nil
			arg_490_1.state_ = "waiting"
		end

		function arg_490_1.playNext_(arg_492_0)
			if arg_492_0 == 1 then
				arg_490_0:Play102601119(arg_490_1)
			end
		end

		function arg_490_1.onSingleLineUpdate_(arg_493_0)
			local var_493_0 = 0.825

			if 0 < arg_490_1.time_ and arg_490_1.time_ <= 0 + arg_493_0 then
				arg_490_1.talkMaxDuration = 0
				arg_490_1.dialogCg_.alpha = 1

				arg_490_1.dialog_:SetActive(true)
				SetActive(arg_490_1.leftNameGo_, false)

				arg_490_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_490_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_490_1:RecordName(arg_490_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_490_1.iconTrs_.gameObject, false)
				arg_490_1.callingController_:SetSelectedState("normal")

				local var_493_1 = arg_490_1:FormatText(arg_490_1:GetWordFromCfg(102601118).content)

				arg_490_1.text_.text = var_493_1

				LuaForUtil.ClearLinePrefixSymbol(arg_490_1.text_)

				local var_493_3 = 32 <= 0 and var_493_0 or var_493_0 * (utf8.len(var_493_1) / 32)

				if (32 <= 0 and var_493_0 or var_493_0 * (utf8.len(var_493_1) / 32)) > 0 and var_493_0 < var_493_3 then
					arg_490_1.talkMaxDuration = var_493_3

					if var_493_3 + 0 > arg_490_1.duration_ then
						arg_490_1.duration_ = var_493_3 + 0
					end
				end

				arg_490_1.text_.text = var_493_1
				arg_490_1.typewritter.percent = 0

				arg_490_1.typewritter:SetDirty()
				arg_490_1:ShowNextGo(false)
				arg_490_1:RecordContent(arg_490_1.text_.text)
			end

			local var_493_4 = math.max(var_493_0, arg_490_1.talkMaxDuration)

			if 0 <= arg_490_1.time_ and arg_490_1.time_ < 0 + var_493_4 then
				arg_490_1.typewritter.percent = (arg_490_1.time_ - 0) / var_493_4

				arg_490_1.typewritter:SetDirty()
			end

			if arg_490_1.time_ >= 0 + var_493_4 and arg_490_1.time_ < 0 + var_493_4 + arg_493_0 then
				arg_490_1.typewritter.percent = 1

				arg_490_1.typewritter:SetDirty()
				arg_490_1:ShowNextGo(true)
			end
		end

		arg_490_1.nodeConfigList_ = {}

		arg_490_1:InitPlayNodeList()
	end,
	Play102601119 = function(arg_494_0, arg_494_1)
		arg_494_1.time_ = 0
		arg_494_1.frameCnt_ = 0
		arg_494_1.state_ = "playing"
		arg_494_1.curTalkId_ = 102601119
		arg_494_1.duration_ = 5

		SetActive(arg_494_1.tipsGo_, false)

		function arg_494_1.onSingleLineFinish_()
			arg_494_1.onSingleLineUpdate_ = nil
			arg_494_1.onSingleLineFinish_ = nil
			arg_494_1.state_ = "waiting"
		end

		function arg_494_1.playNext_(arg_496_0)
			if arg_496_0 == 1 then
				arg_494_0:Play102601120(arg_494_1)
			end
		end

		function arg_494_1.onSingleLineUpdate_(arg_497_0)
			local var_497_0 = 0.025

			if 0 < arg_494_1.time_ and arg_494_1.time_ <= 0 + arg_497_0 then
				arg_494_1.talkMaxDuration = 0
				arg_494_1.dialogCg_.alpha = 1

				arg_494_1.dialog_:SetActive(true)
				SetActive(arg_494_1.leftNameGo_, true)

				arg_494_1.leftNameTxt_.text = arg_494_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_494_1.leftNameTxt_.transform)

				arg_494_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_494_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_494_1:RecordName(arg_494_1.leftNameTxt_.text)
				SetActive(arg_494_1.iconTrs_.gameObject, true)
				arg_494_1.iconController_:SetSelectedState("hero")

				arg_494_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_494_1.callingController_:SetSelectedState("normal")

				arg_494_1.keyicon_.color = Color.New(1, 1, 1)
				arg_494_1.icon_.color = Color.New(1, 1, 1)

				local var_497_1 = arg_494_1:FormatText(arg_494_1:GetWordFromCfg(102601119).content)

				arg_494_1.text_.text = var_497_1

				LuaForUtil.ClearLinePrefixSymbol(arg_494_1.text_)

				local var_497_3 = 1 <= 0 and var_497_0 or var_497_0 * (utf8.len(var_497_1) / 1)

				if (1 <= 0 and var_497_0 or var_497_0 * (utf8.len(var_497_1) / 1)) > 0 and var_497_0 < var_497_3 then
					arg_494_1.talkMaxDuration = var_497_3

					if var_497_3 + 0 > arg_494_1.duration_ then
						arg_494_1.duration_ = var_497_3 + 0
					end
				end

				arg_494_1.text_.text = var_497_1
				arg_494_1.typewritter.percent = 0

				arg_494_1.typewritter:SetDirty()
				arg_494_1:ShowNextGo(false)
				arg_494_1:RecordContent(arg_494_1.text_.text)
			end

			local var_497_4 = math.max(var_497_0, arg_494_1.talkMaxDuration)

			if 0 <= arg_494_1.time_ and arg_494_1.time_ < 0 + var_497_4 then
				arg_494_1.typewritter.percent = (arg_494_1.time_ - 0) / var_497_4

				arg_494_1.typewritter:SetDirty()
			end

			if arg_494_1.time_ >= 0 + var_497_4 and arg_494_1.time_ < 0 + var_497_4 + arg_497_0 then
				arg_494_1.typewritter.percent = 1

				arg_494_1.typewritter:SetDirty()
				arg_494_1:ShowNextGo(true)
			end
		end

		arg_494_1.nodeConfigList_ = {}

		arg_494_1:InitPlayNodeList()
	end,
	Play102601120 = function(arg_498_0, arg_498_1)
		arg_498_1.time_ = 0
		arg_498_1.frameCnt_ = 0
		arg_498_1.state_ = "playing"
		arg_498_1.curTalkId_ = 102601120
		arg_498_1.duration_ = 7

		local var_498_0 = {
			ko = 5.633,
			en = 7
		}
		local var_498_1 = manager.audio:GetLocalizationFlag()

		if var_498_0[var_498_1] ~= nil then
			arg_498_1.duration_ = var_498_0[var_498_1]
		end

		SetActive(arg_498_1.tipsGo_, false)

		function arg_498_1.onSingleLineFinish_()
			arg_498_1.onSingleLineUpdate_ = nil
			arg_498_1.onSingleLineFinish_ = nil
			arg_498_1.state_ = "waiting"
		end

		function arg_498_1.playNext_(arg_500_0)
			if arg_500_0 == 1 then
				arg_498_0:Play102601121(arg_498_1)
			end
		end

		function arg_498_1.onSingleLineUpdate_(arg_501_0)
			if 0 < arg_498_1.time_ and arg_498_1.time_ <= 0 + arg_501_0 then
				arg_498_1:AudioAction("play", "effect", "se_story_side_1026", "se_story_1026_song1", "")
			end

			local var_501_1 = 0
			local var_501_2 = 0.9

			if 0 < arg_498_1.time_ and arg_498_1.time_ <= var_501_1 + arg_501_0 then
				arg_498_1.talkMaxDuration = 0
				arg_498_1.dialogCg_.alpha = 1

				arg_498_1.dialog_:SetActive(true)
				SetActive(arg_498_1.leftNameGo_, true)

				arg_498_1.leftNameTxt_.text = arg_498_1:FormatText(StoryNameCfg[192].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_498_1.leftNameTxt_.transform)

				arg_498_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_498_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_498_1:RecordName(arg_498_1.leftNameTxt_.text)
				SetActive(arg_498_1.iconTrs_.gameObject, false)
				arg_498_1.callingController_:SetSelectedState("normal")

				local var_501_3 = arg_498_1:GetWordFromCfg(102601120)
				local var_501_4 = arg_498_1:FormatText(var_501_3.content)

				arg_498_1.text_.text = var_501_4

				LuaForUtil.ClearLinePrefixSymbol(arg_498_1.text_)

				local var_501_6 = 17 <= 0 and var_501_2 or var_501_2 * (utf8.len(var_501_4) / 17)

				if (17 <= 0 and var_501_2 or var_501_2 * (utf8.len(var_501_4) / 17)) > 0 and var_501_2 < var_501_6 then
					arg_498_1.talkMaxDuration = var_501_6

					if var_501_6 + var_501_1 > arg_498_1.duration_ then
						arg_498_1.duration_ = var_501_6 + var_501_1
					end
				end

				arg_498_1.text_.text = var_501_4
				arg_498_1.typewritter.percent = 0

				arg_498_1.typewritter:SetDirty()
				arg_498_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_102601", "102601120", "story_v_side_old_102601.awb") ~= 0 then
					local var_501_7 = manager.audio:GetVoiceLength("story_v_side_old_102601", "102601120", "story_v_side_old_102601.awb") / 1000

					if var_501_7 + var_501_1 > arg_498_1.duration_ then
						arg_498_1.duration_ = var_501_7 + var_501_1
					end

					if var_501_3.prefab_name ~= "" and arg_498_1.actors_[var_501_3.prefab_name] ~= nil then
						local var_501_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_498_1.actors_[var_501_3.prefab_name].transform, "story_v_side_old_102601", "102601120", "story_v_side_old_102601.awb")

						arg_498_1:RecordAudio("102601120", var_501_8)
						arg_498_1:RecordAudio("102601120", var_501_8)
					else
						arg_498_1:AudioAction("play", "voice", "story_v_side_old_102601", "102601120", "story_v_side_old_102601.awb")
					end

					arg_498_1:RecordHistoryTalkVoice("story_v_side_old_102601", "102601120", "story_v_side_old_102601.awb")
				end

				arg_498_1:RecordContent(arg_498_1.text_.text)
			end

			local var_501_9 = math.max(var_501_2, arg_498_1.talkMaxDuration)

			if var_501_1 <= arg_498_1.time_ and arg_498_1.time_ < var_501_1 + var_501_9 then
				arg_498_1.typewritter.percent = (arg_498_1.time_ - var_501_1) / var_501_9

				arg_498_1.typewritter:SetDirty()
			end

			if arg_498_1.time_ >= var_501_1 + var_501_9 and arg_498_1.time_ < var_501_1 + var_501_9 + arg_501_0 then
				arg_498_1.typewritter.percent = 1

				arg_498_1.typewritter:SetDirty()
				arg_498_1:ShowNextGo(true)
			end
		end

		arg_498_1.nodeConfigList_ = {}

		arg_498_1:InitPlayNodeList()
	end,
	Play102601121 = function(arg_502_0, arg_502_1)
		arg_502_1.time_ = 0
		arg_502_1.frameCnt_ = 0
		arg_502_1.state_ = "playing"
		arg_502_1.curTalkId_ = 102601121
		arg_502_1.duration_ = 5

		SetActive(arg_502_1.tipsGo_, false)

		function arg_502_1.onSingleLineFinish_()
			arg_502_1.onSingleLineUpdate_ = nil
			arg_502_1.onSingleLineFinish_ = nil
			arg_502_1.state_ = "waiting"
		end

		function arg_502_1.playNext_(arg_504_0)
			if arg_504_0 == 1 then
				arg_502_0:Play102601122(arg_502_1)
			end
		end

		function arg_502_1.onSingleLineUpdate_(arg_505_0)
			local var_505_0 = 0.05

			if 0 < arg_502_1.time_ and arg_502_1.time_ <= 0 + arg_505_0 then
				arg_502_1.talkMaxDuration = 0
				arg_502_1.dialogCg_.alpha = 1

				arg_502_1.dialog_:SetActive(true)
				SetActive(arg_502_1.leftNameGo_, true)

				arg_502_1.leftNameTxt_.text = arg_502_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_502_1.leftNameTxt_.transform)

				arg_502_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_502_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_502_1:RecordName(arg_502_1.leftNameTxt_.text)
				SetActive(arg_502_1.iconTrs_.gameObject, true)
				arg_502_1.iconController_:SetSelectedState("hero")

				arg_502_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_502_1.callingController_:SetSelectedState("normal")

				arg_502_1.keyicon_.color = Color.New(1, 1, 1)
				arg_502_1.icon_.color = Color.New(1, 1, 1)

				local var_505_1 = arg_502_1:FormatText(arg_502_1:GetWordFromCfg(102601121).content)

				arg_502_1.text_.text = var_505_1

				LuaForUtil.ClearLinePrefixSymbol(arg_502_1.text_)

				local var_505_3 = 2 <= 0 and var_505_0 or var_505_0 * (utf8.len(var_505_1) / 2)

				if (2 <= 0 and var_505_0 or var_505_0 * (utf8.len(var_505_1) / 2)) > 0 and var_505_0 < var_505_3 then
					arg_502_1.talkMaxDuration = var_505_3

					if var_505_3 + 0 > arg_502_1.duration_ then
						arg_502_1.duration_ = var_505_3 + 0
					end
				end

				arg_502_1.text_.text = var_505_1
				arg_502_1.typewritter.percent = 0

				arg_502_1.typewritter:SetDirty()
				arg_502_1:ShowNextGo(false)
				arg_502_1:RecordContent(arg_502_1.text_.text)
			end

			local var_505_4 = math.max(var_505_0, arg_502_1.talkMaxDuration)

			if 0 <= arg_502_1.time_ and arg_502_1.time_ < 0 + var_505_4 then
				arg_502_1.typewritter.percent = (arg_502_1.time_ - 0) / var_505_4

				arg_502_1.typewritter:SetDirty()
			end

			if arg_502_1.time_ >= 0 + var_505_4 and arg_502_1.time_ < 0 + var_505_4 + arg_505_0 then
				arg_502_1.typewritter.percent = 1

				arg_502_1.typewritter:SetDirty()
				arg_502_1:ShowNextGo(true)
			end
		end

		arg_502_1.nodeConfigList_ = {}

		arg_502_1:InitPlayNodeList()
	end,
	Play102601122 = function(arg_506_0, arg_506_1)
		arg_506_1.time_ = 0
		arg_506_1.frameCnt_ = 0
		arg_506_1.state_ = "playing"
		arg_506_1.curTalkId_ = 102601122
		arg_506_1.duration_ = 5

		SetActive(arg_506_1.tipsGo_, false)

		function arg_506_1.onSingleLineFinish_()
			arg_506_1.onSingleLineUpdate_ = nil
			arg_506_1.onSingleLineFinish_ = nil
			arg_506_1.state_ = "waiting"
		end

		function arg_506_1.playNext_(arg_508_0)
			if arg_508_0 == 1 then
				arg_506_0:Play102601123(arg_506_1)
			end
		end

		function arg_506_1.onSingleLineUpdate_(arg_509_0)
			local var_509_0 = 0.675

			if 0 < arg_506_1.time_ and arg_506_1.time_ <= 0 + arg_509_0 then
				arg_506_1.talkMaxDuration = 0
				arg_506_1.dialogCg_.alpha = 1

				arg_506_1.dialog_:SetActive(true)
				SetActive(arg_506_1.leftNameGo_, false)

				arg_506_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_506_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_506_1:RecordName(arg_506_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_506_1.iconTrs_.gameObject, false)
				arg_506_1.callingController_:SetSelectedState("normal")

				local var_509_1 = arg_506_1:FormatText(arg_506_1:GetWordFromCfg(102601122).content)

				arg_506_1.text_.text = var_509_1

				LuaForUtil.ClearLinePrefixSymbol(arg_506_1.text_)

				local var_509_3 = 27 <= 0 and var_509_0 or var_509_0 * (utf8.len(var_509_1) / 27)

				if (27 <= 0 and var_509_0 or var_509_0 * (utf8.len(var_509_1) / 27)) > 0 and var_509_0 < var_509_3 then
					arg_506_1.talkMaxDuration = var_509_3

					if var_509_3 + 0 > arg_506_1.duration_ then
						arg_506_1.duration_ = var_509_3 + 0
					end
				end

				arg_506_1.text_.text = var_509_1
				arg_506_1.typewritter.percent = 0

				arg_506_1.typewritter:SetDirty()
				arg_506_1:ShowNextGo(false)
				arg_506_1:RecordContent(arg_506_1.text_.text)
			end

			local var_509_4 = math.max(var_509_0, arg_506_1.talkMaxDuration)

			if 0 <= arg_506_1.time_ and arg_506_1.time_ < 0 + var_509_4 then
				arg_506_1.typewritter.percent = (arg_506_1.time_ - 0) / var_509_4

				arg_506_1.typewritter:SetDirty()
			end

			if arg_506_1.time_ >= 0 + var_509_4 and arg_506_1.time_ < 0 + var_509_4 + arg_509_0 then
				arg_506_1.typewritter.percent = 1

				arg_506_1.typewritter:SetDirty()
				arg_506_1:ShowNextGo(true)
			end
		end

		arg_506_1.nodeConfigList_ = {}

		arg_506_1:InitPlayNodeList()
	end,
	Play102601123 = function(arg_510_0, arg_510_1)
		arg_510_1.time_ = 0
		arg_510_1.frameCnt_ = 0
		arg_510_1.state_ = "playing"
		arg_510_1.curTalkId_ = 102601123
		arg_510_1.duration_ = 5

		SetActive(arg_510_1.tipsGo_, false)

		function arg_510_1.onSingleLineFinish_()
			arg_510_1.onSingleLineUpdate_ = nil
			arg_510_1.onSingleLineFinish_ = nil
			arg_510_1.state_ = "waiting"
		end

		function arg_510_1.playNext_(arg_512_0)
			if arg_512_0 == 1 then
				arg_510_0:Play102601124(arg_510_1)
			end
		end

		function arg_510_1.onSingleLineUpdate_(arg_513_0)
			if 0 < arg_510_1.time_ and arg_510_1.time_ <= 0 + arg_513_0 then
				arg_510_1:AudioAction("play", "effect", "se_story_side_1026", "se_story_1026_bubble", "")
			end

			local var_513_1 = 0
			local var_513_2 = 0.25

			if 0 < arg_510_1.time_ and arg_510_1.time_ <= var_513_1 + arg_513_0 then
				arg_510_1.talkMaxDuration = 0
				arg_510_1.dialogCg_.alpha = 1

				arg_510_1.dialog_:SetActive(true)
				SetActive(arg_510_1.leftNameGo_, false)

				arg_510_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_510_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_510_1:RecordName(arg_510_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_510_1.iconTrs_.gameObject, false)
				arg_510_1.callingController_:SetSelectedState("normal")

				local var_513_3 = arg_510_1:FormatText(arg_510_1:GetWordFromCfg(102601123).content)

				arg_510_1.text_.text = var_513_3

				LuaForUtil.ClearLinePrefixSymbol(arg_510_1.text_)

				local var_513_5 = 10 <= 0 and var_513_2 or var_513_2 * (utf8.len(var_513_3) / 10)

				if (10 <= 0 and var_513_2 or var_513_2 * (utf8.len(var_513_3) / 10)) > 0 and var_513_2 < var_513_5 then
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
	Play102601124 = function(arg_514_0, arg_514_1)
		arg_514_1.time_ = 0
		arg_514_1.frameCnt_ = 0
		arg_514_1.state_ = "playing"
		arg_514_1.curTalkId_ = 102601124
		arg_514_1.duration_ = 3.63

		local var_514_0 = {
			ko = 2.8,
			en = 3.633
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
				arg_514_0:Play102601125(arg_514_1)
			end
		end

		function arg_514_1.onSingleLineUpdate_(arg_517_0)
			if 0 < arg_514_1.time_ and arg_514_1.time_ <= 0 + arg_517_0 then
				arg_514_1:AudioAction("play", "effect", "se_story_side_1026", "se_story_1026_song2", "")
			end

			local var_517_1 = 0
			local var_517_2 = 0.3

			if 0 < arg_514_1.time_ and arg_514_1.time_ <= var_517_1 + arg_517_0 then
				arg_514_1.talkMaxDuration = 0
				arg_514_1.dialogCg_.alpha = 1

				arg_514_1.dialog_:SetActive(true)
				SetActive(arg_514_1.leftNameGo_, true)

				arg_514_1.leftNameTxt_.text = arg_514_1:FormatText(StoryNameCfg[192].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_514_1.leftNameTxt_.transform)

				arg_514_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_514_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_514_1:RecordName(arg_514_1.leftNameTxt_.text)
				SetActive(arg_514_1.iconTrs_.gameObject, false)
				arg_514_1.callingController_:SetSelectedState("normal")

				local var_517_3 = arg_514_1:GetWordFromCfg(102601124)
				local var_517_4 = arg_514_1:FormatText(var_517_3.content)

				arg_514_1.text_.text = var_517_4

				LuaForUtil.ClearLinePrefixSymbol(arg_514_1.text_)

				local var_517_6 = 8 <= 0 and var_517_2 or var_517_2 * (utf8.len(var_517_4) / 8)

				if (8 <= 0 and var_517_2 or var_517_2 * (utf8.len(var_517_4) / 8)) > 0 and var_517_2 < var_517_6 then
					arg_514_1.talkMaxDuration = var_517_6

					if var_517_6 + var_517_1 > arg_514_1.duration_ then
						arg_514_1.duration_ = var_517_6 + var_517_1
					end
				end

				arg_514_1.text_.text = var_517_4
				arg_514_1.typewritter.percent = 0

				arg_514_1.typewritter:SetDirty()
				arg_514_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_102601", "102601124", "story_v_side_old_102601.awb") ~= 0 then
					local var_517_7 = manager.audio:GetVoiceLength("story_v_side_old_102601", "102601124", "story_v_side_old_102601.awb") / 1000

					if var_517_7 + var_517_1 > arg_514_1.duration_ then
						arg_514_1.duration_ = var_517_7 + var_517_1
					end

					if var_517_3.prefab_name ~= "" and arg_514_1.actors_[var_517_3.prefab_name] ~= nil then
						local var_517_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_514_1.actors_[var_517_3.prefab_name].transform, "story_v_side_old_102601", "102601124", "story_v_side_old_102601.awb")

						arg_514_1:RecordAudio("102601124", var_517_8)
						arg_514_1:RecordAudio("102601124", var_517_8)
					else
						arg_514_1:AudioAction("play", "voice", "story_v_side_old_102601", "102601124", "story_v_side_old_102601.awb")
					end

					arg_514_1:RecordHistoryTalkVoice("story_v_side_old_102601", "102601124", "story_v_side_old_102601.awb")
				end

				arg_514_1:RecordContent(arg_514_1.text_.text)
			end

			local var_517_9 = math.max(var_517_2, arg_514_1.talkMaxDuration)

			if var_517_1 <= arg_514_1.time_ and arg_514_1.time_ < var_517_1 + var_517_9 then
				arg_514_1.typewritter.percent = (arg_514_1.time_ - var_517_1) / var_517_9

				arg_514_1.typewritter:SetDirty()
			end

			if arg_514_1.time_ >= var_517_1 + var_517_9 and arg_514_1.time_ < var_517_1 + var_517_9 + arg_517_0 then
				arg_514_1.typewritter.percent = 1

				arg_514_1.typewritter:SetDirty()
				arg_514_1:ShowNextGo(true)
			end
		end

		arg_514_1.nodeConfigList_ = {}

		arg_514_1:InitPlayNodeList()
	end,
	Play102601125 = function(arg_518_0, arg_518_1)
		arg_518_1.time_ = 0
		arg_518_1.frameCnt_ = 0
		arg_518_1.state_ = "playing"
		arg_518_1.curTalkId_ = 102601125
		arg_518_1.duration_ = 7.2

		local var_518_0 = {
			ja = 7.2,
			ko = 4.266,
			zh = 4.5,
			en = 4.3
		}
		local var_518_1 = manager.audio:GetLocalizationFlag()

		if var_518_0[var_518_1] ~= nil then
			arg_518_1.duration_ = var_518_0[var_518_1]
		end

		SetActive(arg_518_1.tipsGo_, false)

		function arg_518_1.onSingleLineFinish_()
			arg_518_1.onSingleLineUpdate_ = nil
			arg_518_1.onSingleLineFinish_ = nil
			arg_518_1.state_ = "waiting"
		end

		function arg_518_1.playNext_(arg_520_0)
			if arg_520_0 == 1 then
				arg_518_0:Play102601126(arg_518_1)
			end
		end

		function arg_518_1.onSingleLineUpdate_(arg_521_0)
			if 0 < arg_518_1.time_ and arg_518_1.time_ <= 0 + arg_521_0 then
				arg_518_1.var_.moveOldPos1026ui_story = arg_518_1.actors_["1026ui_story"].transform.localPosition
			end

			local var_521_0 = 0.001

			if 0 <= arg_518_1.time_ and arg_518_1.time_ < 0 + var_521_0 then
				arg_518_1.actors_["1026ui_story"].transform.localPosition = Vector3.Lerp(arg_518_1.var_.moveOldPos1026ui_story, Vector3.New(0, -1.05, -6.2), (arg_518_1.time_ - 0) / var_521_0)
				arg_518_1.actors_["1026ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_518_1.actors_["1026ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_518_1.actors_["1026ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_518_1.actors_["1026ui_story"].transform.position).z)
				arg_518_1.actors_["1026ui_story"].transform.localEulerAngles.z = 0
				arg_518_1.actors_["1026ui_story"].transform.localEulerAngles.x = 0
				arg_518_1.actors_["1026ui_story"].transform.localEulerAngles = arg_518_1.actors_["1026ui_story"].transform.localEulerAngles
			end

			if arg_518_1.time_ >= 0 + var_521_0 and arg_518_1.time_ < 0 + var_521_0 + arg_521_0 then
				arg_518_1.actors_["1026ui_story"].transform.localPosition = Vector3.New(0, -1.05, -6.2)
				arg_518_1.actors_["1026ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_518_1.actors_["1026ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_518_1.actors_["1026ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_518_1.actors_["1026ui_story"].transform.position).z)
				arg_518_1.actors_["1026ui_story"].transform.localEulerAngles.z = 0
				arg_518_1.actors_["1026ui_story"].transform.localEulerAngles.x = 0
				arg_518_1.actors_["1026ui_story"].transform.localEulerAngles = arg_518_1.actors_["1026ui_story"].transform.localEulerAngles
			end

			local var_521_1 = arg_518_1.actors_["1026ui_story"]

			if 0 < arg_518_1.time_ and arg_518_1.time_ <= 0 + arg_521_0 and not isNil(var_521_1) and arg_518_1.var_.characterEffect1026ui_story == nil then
				arg_518_1.var_.characterEffect1026ui_story = var_521_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_521_2 = 0.2

			if 0 <= arg_518_1.time_ and arg_518_1.time_ < 0 + var_521_2 and not isNil(var_521_1) then
				if arg_518_1.var_.characterEffect1026ui_story and not isNil(var_521_1) then
					arg_518_1.var_.characterEffect1026ui_story.fillFlat = false
				end
			end

			if arg_518_1.time_ >= 0 + var_521_2 and arg_518_1.time_ < 0 + var_521_2 + arg_521_0 and not isNil(var_521_1) and arg_518_1.var_.characterEffect1026ui_story then
				arg_518_1.var_.characterEffect1026ui_story.fillFlat = false
			end

			if 0 < arg_518_1.time_ and arg_518_1.time_ <= 0 + arg_521_0 then
				arg_518_1:PlayTimeline("1026ui_story", "StoryTimeline/CharAction/story1026/story1026action/1026action5_1")
			end

			if 0 < arg_518_1.time_ and arg_518_1.time_ <= 0 + arg_521_0 then
				arg_518_1:PlayTimeline("1026ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_521_4 = 0
			local var_521_5 = 0.55

			if 0 < arg_518_1.time_ and arg_518_1.time_ <= var_521_4 + arg_521_0 then
				arg_518_1.talkMaxDuration = 0
				arg_518_1.dialogCg_.alpha = 1

				arg_518_1.dialog_:SetActive(true)
				SetActive(arg_518_1.leftNameGo_, true)

				arg_518_1.leftNameTxt_.text = arg_518_1:FormatText(StoryNameCfg[83].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_518_1.leftNameTxt_.transform)

				arg_518_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_518_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_518_1:RecordName(arg_518_1.leftNameTxt_.text)
				SetActive(arg_518_1.iconTrs_.gameObject, false)
				arg_518_1.callingController_:SetSelectedState("normal")

				local var_521_6 = arg_518_1:GetWordFromCfg(102601125)
				local var_521_7 = arg_518_1:FormatText(var_521_6.content)

				arg_518_1.text_.text = var_521_7

				LuaForUtil.ClearLinePrefixSymbol(arg_518_1.text_)

				local var_521_9 = 22 <= 0 and var_521_5 or var_521_5 * (utf8.len(var_521_7) / 22)

				if (22 <= 0 and var_521_5 or var_521_5 * (utf8.len(var_521_7) / 22)) > 0 and var_521_5 < var_521_9 then
					arg_518_1.talkMaxDuration = var_521_9

					if var_521_9 + var_521_4 > arg_518_1.duration_ then
						arg_518_1.duration_ = var_521_9 + var_521_4
					end
				end

				arg_518_1.text_.text = var_521_7
				arg_518_1.typewritter.percent = 0

				arg_518_1.typewritter:SetDirty()
				arg_518_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_102601", "102601125", "story_v_side_old_102601.awb") ~= 0 then
					local var_521_10 = manager.audio:GetVoiceLength("story_v_side_old_102601", "102601125", "story_v_side_old_102601.awb") / 1000

					if var_521_10 + var_521_4 > arg_518_1.duration_ then
						arg_518_1.duration_ = var_521_10 + var_521_4
					end

					if var_521_6.prefab_name ~= "" and arg_518_1.actors_[var_521_6.prefab_name] ~= nil then
						local var_521_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_518_1.actors_[var_521_6.prefab_name].transform, "story_v_side_old_102601", "102601125", "story_v_side_old_102601.awb")

						arg_518_1:RecordAudio("102601125", var_521_11)
						arg_518_1:RecordAudio("102601125", var_521_11)
					else
						arg_518_1:AudioAction("play", "voice", "story_v_side_old_102601", "102601125", "story_v_side_old_102601.awb")
					end

					arg_518_1:RecordHistoryTalkVoice("story_v_side_old_102601", "102601125", "story_v_side_old_102601.awb")
				end

				arg_518_1:RecordContent(arg_518_1.text_.text)
			end

			local var_521_12 = math.max(var_521_5, arg_518_1.talkMaxDuration)

			if var_521_4 <= arg_518_1.time_ and arg_518_1.time_ < var_521_4 + var_521_12 then
				arg_518_1.typewritter.percent = (arg_518_1.time_ - var_521_4) / var_521_12

				arg_518_1.typewritter:SetDirty()
			end

			if arg_518_1.time_ >= var_521_4 + var_521_12 and arg_518_1.time_ < var_521_4 + var_521_12 + arg_521_0 then
				arg_518_1.typewritter.percent = 1

				arg_518_1.typewritter:SetDirty()
				arg_518_1:ShowNextGo(true)
			end
		end

		arg_518_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1026ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_518_1:InitPlayNodeList()
	end,
	Play102601126 = function(arg_522_0, arg_522_1)
		arg_522_1.time_ = 0
		arg_522_1.frameCnt_ = 0
		arg_522_1.state_ = "playing"
		arg_522_1.curTalkId_ = 102601126
		arg_522_1.duration_ = 5

		SetActive(arg_522_1.tipsGo_, false)

		function arg_522_1.onSingleLineFinish_()
			arg_522_1.onSingleLineUpdate_ = nil
			arg_522_1.onSingleLineFinish_ = nil
			arg_522_1.state_ = "waiting"
		end

		function arg_522_1.playNext_(arg_524_0)
			if arg_524_0 == 1 then
				arg_522_0:Play102601127(arg_522_1)
			end
		end

		function arg_522_1.onSingleLineUpdate_(arg_525_0)
			if 0 < arg_522_1.time_ and arg_522_1.time_ <= 0 + arg_525_0 and not isNil(arg_522_1.actors_["1026ui_story"]) and arg_522_1.var_.characterEffect1026ui_story == nil then
				arg_522_1.var_.characterEffect1026ui_story = arg_522_1.actors_["1026ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_525_0 = 0.2

			if 0 <= arg_522_1.time_ and arg_522_1.time_ < 0 + var_525_0 and not isNil(arg_522_1.actors_["1026ui_story"]) then
				if arg_522_1.var_.characterEffect1026ui_story and not isNil(arg_522_1.actors_["1026ui_story"]) then
					arg_522_1.var_.characterEffect1026ui_story.fillFlat = true
					arg_522_1.var_.characterEffect1026ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_522_1.time_ - 0) / var_525_0)
				end
			end

			if arg_522_1.time_ >= 0 + var_525_0 and arg_522_1.time_ < 0 + var_525_0 + arg_525_0 and not isNil(arg_522_1.actors_["1026ui_story"]) and arg_522_1.var_.characterEffect1026ui_story then
				arg_522_1.var_.characterEffect1026ui_story.fillFlat = true
				arg_522_1.var_.characterEffect1026ui_story.fillRatio = 0.5
			end

			local var_525_1 = 0
			local var_525_2 = 0.55

			if 0 < arg_522_1.time_ and arg_522_1.time_ <= var_525_1 + arg_525_0 then
				arg_522_1.talkMaxDuration = 0
				arg_522_1.dialogCg_.alpha = 1

				arg_522_1.dialog_:SetActive(true)
				SetActive(arg_522_1.leftNameGo_, false)

				arg_522_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_522_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_522_1:RecordName(arg_522_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_522_1.iconTrs_.gameObject, false)
				arg_522_1.callingController_:SetSelectedState("normal")

				local var_525_3 = arg_522_1:FormatText(arg_522_1:GetWordFromCfg(102601126).content)

				arg_522_1.text_.text = var_525_3

				LuaForUtil.ClearLinePrefixSymbol(arg_522_1.text_)

				local var_525_5 = 22 <= 0 and var_525_2 or var_525_2 * (utf8.len(var_525_3) / 22)

				if (22 <= 0 and var_525_2 or var_525_2 * (utf8.len(var_525_3) / 22)) > 0 and var_525_2 < var_525_5 then
					arg_522_1.talkMaxDuration = var_525_5

					if var_525_5 + var_525_1 > arg_522_1.duration_ then
						arg_522_1.duration_ = var_525_5 + var_525_1
					end
				end

				arg_522_1.text_.text = var_525_3
				arg_522_1.typewritter.percent = 0

				arg_522_1.typewritter:SetDirty()
				arg_522_1:ShowNextGo(false)
				arg_522_1:RecordContent(arg_522_1.text_.text)
			end

			local var_525_6 = math.max(var_525_2, arg_522_1.talkMaxDuration)

			if var_525_1 <= arg_522_1.time_ and arg_522_1.time_ < var_525_1 + var_525_6 then
				arg_522_1.typewritter.percent = (arg_522_1.time_ - var_525_1) / var_525_6

				arg_522_1.typewritter:SetDirty()
			end

			if arg_522_1.time_ >= var_525_1 + var_525_6 and arg_522_1.time_ < var_525_1 + var_525_6 + arg_525_0 then
				arg_522_1.typewritter.percent = 1

				arg_522_1.typewritter:SetDirty()
				arg_522_1:ShowNextGo(true)
			end
		end

		arg_522_1.nodeConfigList_ = {}

		arg_522_1:InitPlayNodeList()
	end,
	Play102601127 = function(arg_526_0, arg_526_1)
		arg_526_1.time_ = 0
		arg_526_1.frameCnt_ = 0
		arg_526_1.state_ = "playing"
		arg_526_1.curTalkId_ = 102601127
		arg_526_1.duration_ = 5

		SetActive(arg_526_1.tipsGo_, false)

		function arg_526_1.onSingleLineFinish_()
			arg_526_1.onSingleLineUpdate_ = nil
			arg_526_1.onSingleLineFinish_ = nil
			arg_526_1.state_ = "waiting"
		end

		function arg_526_1.playNext_(arg_528_0)
			if arg_528_0 == 1 then
				arg_526_0:Play102601128(arg_526_1)
			end
		end

		function arg_526_1.onSingleLineUpdate_(arg_529_0)
			local var_529_0 = 0.1

			if 0 < arg_526_1.time_ and arg_526_1.time_ <= 0 + arg_529_0 then
				arg_526_1.talkMaxDuration = 0
				arg_526_1.dialogCg_.alpha = 1

				arg_526_1.dialog_:SetActive(true)
				SetActive(arg_526_1.leftNameGo_, true)

				arg_526_1.leftNameTxt_.text = arg_526_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_526_1.leftNameTxt_.transform)

				arg_526_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_526_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_526_1:RecordName(arg_526_1.leftNameTxt_.text)
				SetActive(arg_526_1.iconTrs_.gameObject, true)
				arg_526_1.iconController_:SetSelectedState("hero")

				arg_526_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_526_1.callingController_:SetSelectedState("normal")

				arg_526_1.keyicon_.color = Color.New(1, 1, 1)
				arg_526_1.icon_.color = Color.New(1, 1, 1)

				local var_529_1 = arg_526_1:FormatText(arg_526_1:GetWordFromCfg(102601127).content)

				arg_526_1.text_.text = var_529_1

				LuaForUtil.ClearLinePrefixSymbol(arg_526_1.text_)

				local var_529_3 = 4 <= 0 and var_529_0 or var_529_0 * (utf8.len(var_529_1) / 4)

				if (4 <= 0 and var_529_0 or var_529_0 * (utf8.len(var_529_1) / 4)) > 0 and var_529_0 < var_529_3 then
					arg_526_1.talkMaxDuration = var_529_3

					if var_529_3 + 0 > arg_526_1.duration_ then
						arg_526_1.duration_ = var_529_3 + 0
					end
				end

				arg_526_1.text_.text = var_529_1
				arg_526_1.typewritter.percent = 0

				arg_526_1.typewritter:SetDirty()
				arg_526_1:ShowNextGo(false)
				arg_526_1:RecordContent(arg_526_1.text_.text)
			end

			local var_529_4 = math.max(var_529_0, arg_526_1.talkMaxDuration)

			if 0 <= arg_526_1.time_ and arg_526_1.time_ < 0 + var_529_4 then
				arg_526_1.typewritter.percent = (arg_526_1.time_ - 0) / var_529_4

				arg_526_1.typewritter:SetDirty()
			end

			if arg_526_1.time_ >= 0 + var_529_4 and arg_526_1.time_ < 0 + var_529_4 + arg_529_0 then
				arg_526_1.typewritter.percent = 1

				arg_526_1.typewritter:SetDirty()
				arg_526_1:ShowNextGo(true)
			end
		end

		arg_526_1.nodeConfigList_ = {}

		arg_526_1:InitPlayNodeList()
	end,
	Play102601128 = function(arg_530_0, arg_530_1)
		arg_530_1.time_ = 0
		arg_530_1.frameCnt_ = 0
		arg_530_1.state_ = "playing"
		arg_530_1.curTalkId_ = 102601128
		arg_530_1.duration_ = 5

		SetActive(arg_530_1.tipsGo_, false)

		function arg_530_1.onSingleLineFinish_()
			arg_530_1.onSingleLineUpdate_ = nil
			arg_530_1.onSingleLineFinish_ = nil
			arg_530_1.state_ = "waiting"
		end

		function arg_530_1.playNext_(arg_532_0)
			if arg_532_0 == 1 then
				arg_530_0:Play102601129(arg_530_1)
			end
		end

		function arg_530_1.onSingleLineUpdate_(arg_533_0)
			local var_533_0 = 0.775

			if 0 < arg_530_1.time_ and arg_530_1.time_ <= 0 + arg_533_0 then
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

				local var_533_1 = arg_530_1:FormatText(arg_530_1:GetWordFromCfg(102601128).content)

				arg_530_1.text_.text = var_533_1

				LuaForUtil.ClearLinePrefixSymbol(arg_530_1.text_)

				local var_533_3 = 31 <= 0 and var_533_0 or var_533_0 * (utf8.len(var_533_1) / 31)

				if (31 <= 0 and var_533_0 or var_533_0 * (utf8.len(var_533_1) / 31)) > 0 and var_533_0 < var_533_3 then
					arg_530_1.talkMaxDuration = var_533_3

					if var_533_3 + 0 > arg_530_1.duration_ then
						arg_530_1.duration_ = var_533_3 + 0
					end
				end

				arg_530_1.text_.text = var_533_1
				arg_530_1.typewritter.percent = 0

				arg_530_1.typewritter:SetDirty()
				arg_530_1:ShowNextGo(false)
				arg_530_1:RecordContent(arg_530_1.text_.text)
			end

			local var_533_4 = math.max(var_533_0, arg_530_1.talkMaxDuration)

			if 0 <= arg_530_1.time_ and arg_530_1.time_ < 0 + var_533_4 then
				arg_530_1.typewritter.percent = (arg_530_1.time_ - 0) / var_533_4

				arg_530_1.typewritter:SetDirty()
			end

			if arg_530_1.time_ >= 0 + var_533_4 and arg_530_1.time_ < 0 + var_533_4 + arg_533_0 then
				arg_530_1.typewritter.percent = 1

				arg_530_1.typewritter:SetDirty()
				arg_530_1:ShowNextGo(true)
			end
		end

		arg_530_1.nodeConfigList_ = {}

		arg_530_1:InitPlayNodeList()
	end,
	Play102601129 = function(arg_534_0, arg_534_1)
		arg_534_1.time_ = 0
		arg_534_1.frameCnt_ = 0
		arg_534_1.state_ = "playing"
		arg_534_1.curTalkId_ = 102601129
		arg_534_1.duration_ = 3.53

		local var_534_0 = {
			ja = 3.533,
			ko = 3.033,
			zh = 2.133,
			en = 2.2
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
				arg_534_0:Play102601130(arg_534_1)
			end
		end

		function arg_534_1.onSingleLineUpdate_(arg_537_0)
			if 0 < arg_534_1.time_ and arg_534_1.time_ <= 0 + arg_537_0 then
				arg_534_1:PlayTimeline("1026ui_story", "StoryTimeline/CharAction/story1026/story1026actionlink/1026action453")
			end

			if 0 < arg_534_1.time_ and arg_534_1.time_ <= 0 + arg_537_0 then
				arg_534_1:PlayTimeline("1026ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_537_0 = arg_534_1.actors_["1026ui_story"]

			if 0 < arg_534_1.time_ and arg_534_1.time_ <= 0 + arg_537_0 and not isNil(var_537_0) and arg_534_1.var_.characterEffect1026ui_story == nil then
				arg_534_1.var_.characterEffect1026ui_story = var_537_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_537_1 = 0.2

			if 0 <= arg_534_1.time_ and arg_534_1.time_ < 0 + var_537_1 and not isNil(var_537_0) then
				if arg_534_1.var_.characterEffect1026ui_story and not isNil(var_537_0) then
					arg_534_1.var_.characterEffect1026ui_story.fillFlat = false
				end
			end

			if arg_534_1.time_ >= 0 + var_537_1 and arg_534_1.time_ < 0 + var_537_1 + arg_537_0 and not isNil(var_537_0) and arg_534_1.var_.characterEffect1026ui_story then
				arg_534_1.var_.characterEffect1026ui_story.fillFlat = false
			end

			local var_537_3 = 0
			local var_537_4 = 0.3

			if 0 < arg_534_1.time_ and arg_534_1.time_ <= var_537_3 + arg_537_0 then
				arg_534_1.talkMaxDuration = 0
				arg_534_1.dialogCg_.alpha = 1

				arg_534_1.dialog_:SetActive(true)
				SetActive(arg_534_1.leftNameGo_, true)

				arg_534_1.leftNameTxt_.text = arg_534_1:FormatText(StoryNameCfg[83].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_534_1.leftNameTxt_.transform)

				arg_534_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_534_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_534_1:RecordName(arg_534_1.leftNameTxt_.text)
				SetActive(arg_534_1.iconTrs_.gameObject, false)
				arg_534_1.callingController_:SetSelectedState("normal")

				local var_537_5 = arg_534_1:GetWordFromCfg(102601129)
				local var_537_6 = arg_534_1:FormatText(var_537_5.content)

				arg_534_1.text_.text = var_537_6

				LuaForUtil.ClearLinePrefixSymbol(arg_534_1.text_)

				local var_537_8 = 12 <= 0 and var_537_4 or var_537_4 * (utf8.len(var_537_6) / 12)

				if (12 <= 0 and var_537_4 or var_537_4 * (utf8.len(var_537_6) / 12)) > 0 and var_537_4 < var_537_8 then
					arg_534_1.talkMaxDuration = var_537_8

					if var_537_8 + var_537_3 > arg_534_1.duration_ then
						arg_534_1.duration_ = var_537_8 + var_537_3
					end
				end

				arg_534_1.text_.text = var_537_6
				arg_534_1.typewritter.percent = 0

				arg_534_1.typewritter:SetDirty()
				arg_534_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_102601", "102601129", "story_v_side_old_102601.awb") ~= 0 then
					local var_537_9 = manager.audio:GetVoiceLength("story_v_side_old_102601", "102601129", "story_v_side_old_102601.awb") / 1000

					if var_537_9 + var_537_3 > arg_534_1.duration_ then
						arg_534_1.duration_ = var_537_9 + var_537_3
					end

					if var_537_5.prefab_name ~= "" and arg_534_1.actors_[var_537_5.prefab_name] ~= nil then
						local var_537_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_534_1.actors_[var_537_5.prefab_name].transform, "story_v_side_old_102601", "102601129", "story_v_side_old_102601.awb")

						arg_534_1:RecordAudio("102601129", var_537_10)
						arg_534_1:RecordAudio("102601129", var_537_10)
					else
						arg_534_1:AudioAction("play", "voice", "story_v_side_old_102601", "102601129", "story_v_side_old_102601.awb")
					end

					arg_534_1:RecordHistoryTalkVoice("story_v_side_old_102601", "102601129", "story_v_side_old_102601.awb")
				end

				arg_534_1:RecordContent(arg_534_1.text_.text)
			end

			local var_537_11 = math.max(var_537_4, arg_534_1.talkMaxDuration)

			if var_537_3 <= arg_534_1.time_ and arg_534_1.time_ < var_537_3 + var_537_11 then
				arg_534_1.typewritter.percent = (arg_534_1.time_ - var_537_3) / var_537_11

				arg_534_1.typewritter:SetDirty()
			end

			if arg_534_1.time_ >= var_537_3 + var_537_11 and arg_534_1.time_ < var_537_3 + var_537_11 + arg_537_0 then
				arg_534_1.typewritter.percent = 1

				arg_534_1.typewritter:SetDirty()
				arg_534_1:ShowNextGo(true)
			end
		end

		arg_534_1.nodeConfigList_ = {}

		arg_534_1:InitPlayNodeList()
	end,
	Play102601130 = function(arg_538_0, arg_538_1)
		arg_538_1.time_ = 0
		arg_538_1.frameCnt_ = 0
		arg_538_1.state_ = "playing"
		arg_538_1.curTalkId_ = 102601130
		arg_538_1.duration_ = 5

		SetActive(arg_538_1.tipsGo_, false)

		function arg_538_1.onSingleLineFinish_()
			arg_538_1.onSingleLineUpdate_ = nil
			arg_538_1.onSingleLineFinish_ = nil
			arg_538_1.state_ = "waiting"
		end

		function arg_538_1.playNext_(arg_540_0)
			if arg_540_0 == 1 then
				arg_538_0:Play102601131(arg_538_1)
			end
		end

		function arg_538_1.onSingleLineUpdate_(arg_541_0)
			if 0 < arg_538_1.time_ and arg_538_1.time_ <= 0 + arg_541_0 then
				arg_538_1.var_.moveOldPos1026ui_story = arg_538_1.actors_["1026ui_story"].transform.localPosition
			end

			local var_541_0 = 0.001

			if 0 <= arg_538_1.time_ and arg_538_1.time_ < 0 + var_541_0 then
				arg_538_1.actors_["1026ui_story"].transform.localPosition = Vector3.Lerp(arg_538_1.var_.moveOldPos1026ui_story, Vector3.New(0, 100, 0), (arg_538_1.time_ - 0) / var_541_0)
				arg_538_1.actors_["1026ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_538_1.actors_["1026ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_538_1.actors_["1026ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_538_1.actors_["1026ui_story"].transform.position).z)
				arg_538_1.actors_["1026ui_story"].transform.localEulerAngles.z = 0
				arg_538_1.actors_["1026ui_story"].transform.localEulerAngles.x = 0
				arg_538_1.actors_["1026ui_story"].transform.localEulerAngles = arg_538_1.actors_["1026ui_story"].transform.localEulerAngles
			end

			if arg_538_1.time_ >= 0 + var_541_0 and arg_538_1.time_ < 0 + var_541_0 + arg_541_0 then
				arg_538_1.actors_["1026ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_538_1.actors_["1026ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_538_1.actors_["1026ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_538_1.actors_["1026ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_538_1.actors_["1026ui_story"].transform.position).z)
				arg_538_1.actors_["1026ui_story"].transform.localEulerAngles.z = 0
				arg_538_1.actors_["1026ui_story"].transform.localEulerAngles.x = 0
				arg_538_1.actors_["1026ui_story"].transform.localEulerAngles = arg_538_1.actors_["1026ui_story"].transform.localEulerAngles
			end

			local var_541_1 = 0
			local var_541_2 = 0.775

			if 0 < arg_538_1.time_ and arg_538_1.time_ <= var_541_1 + arg_541_0 then
				arg_538_1.talkMaxDuration = 0
				arg_538_1.dialogCg_.alpha = 1

				arg_538_1.dialog_:SetActive(true)
				SetActive(arg_538_1.leftNameGo_, false)

				arg_538_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_538_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_538_1:RecordName(arg_538_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_538_1.iconTrs_.gameObject, false)
				arg_538_1.callingController_:SetSelectedState("normal")

				local var_541_3 = arg_538_1:FormatText(arg_538_1:GetWordFromCfg(102601130).content)

				arg_538_1.text_.text = var_541_3

				LuaForUtil.ClearLinePrefixSymbol(arg_538_1.text_)

				local var_541_5 = 31 <= 0 and var_541_2 or var_541_2 * (utf8.len(var_541_3) / 31)

				if (31 <= 0 and var_541_2 or var_541_2 * (utf8.len(var_541_3) / 31)) > 0 and var_541_2 < var_541_5 then
					arg_538_1.talkMaxDuration = var_541_5

					if var_541_5 + var_541_1 > arg_538_1.duration_ then
						arg_538_1.duration_ = var_541_5 + var_541_1
					end
				end

				arg_538_1.text_.text = var_541_3
				arg_538_1.typewritter.percent = 0

				arg_538_1.typewritter:SetDirty()
				arg_538_1:ShowNextGo(false)
				arg_538_1:RecordContent(arg_538_1.text_.text)
			end

			local var_541_6 = math.max(var_541_2, arg_538_1.talkMaxDuration)

			if var_541_1 <= arg_538_1.time_ and arg_538_1.time_ < var_541_1 + var_541_6 then
				arg_538_1.typewritter.percent = (arg_538_1.time_ - var_541_1) / var_541_6

				arg_538_1.typewritter:SetDirty()
			end

			if arg_538_1.time_ >= var_541_1 + var_541_6 and arg_538_1.time_ < var_541_1 + var_541_6 + arg_541_0 then
				arg_538_1.typewritter.percent = 1

				arg_538_1.typewritter:SetDirty()
				arg_538_1:ShowNextGo(true)
			end
		end

		arg_538_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1026ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_538_1:InitPlayNodeList()
	end,
	Play102601131 = function(arg_542_0, arg_542_1)
		arg_542_1.time_ = 0
		arg_542_1.frameCnt_ = 0
		arg_542_1.state_ = "playing"
		arg_542_1.curTalkId_ = 102601131
		arg_542_1.duration_ = 7.93

		local var_542_0 = {
			ja = 7.933,
			ko = 4.1,
			zh = 4.2,
			en = 3.4
		}
		local var_542_1 = manager.audio:GetLocalizationFlag()

		if var_542_0[var_542_1] ~= nil then
			arg_542_1.duration_ = var_542_0[var_542_1]
		end

		SetActive(arg_542_1.tipsGo_, false)

		function arg_542_1.onSingleLineFinish_()
			arg_542_1.onSingleLineUpdate_ = nil
			arg_542_1.onSingleLineFinish_ = nil
			arg_542_1.state_ = "waiting"
		end

		function arg_542_1.playNext_(arg_544_0)
			if arg_544_0 == 1 then
				arg_542_0:Play102601132(arg_542_1)
			end
		end

		function arg_542_1.onSingleLineUpdate_(arg_545_0)
			if 0 < arg_542_1.time_ and arg_542_1.time_ <= 0 + arg_545_0 then
				arg_542_1.var_.moveOldPos1026ui_story = arg_542_1.actors_["1026ui_story"].transform.localPosition
			end

			local var_545_0 = 0.001

			if 0 <= arg_542_1.time_ and arg_542_1.time_ < 0 + var_545_0 then
				arg_542_1.actors_["1026ui_story"].transform.localPosition = Vector3.Lerp(arg_542_1.var_.moveOldPos1026ui_story, Vector3.New(0, -1.05, -6.2), (arg_542_1.time_ - 0) / var_545_0)
				arg_542_1.actors_["1026ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_542_1.actors_["1026ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_542_1.actors_["1026ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_542_1.actors_["1026ui_story"].transform.position).z)
				arg_542_1.actors_["1026ui_story"].transform.localEulerAngles.z = 0
				arg_542_1.actors_["1026ui_story"].transform.localEulerAngles.x = 0
				arg_542_1.actors_["1026ui_story"].transform.localEulerAngles = arg_542_1.actors_["1026ui_story"].transform.localEulerAngles
			end

			if arg_542_1.time_ >= 0 + var_545_0 and arg_542_1.time_ < 0 + var_545_0 + arg_545_0 then
				arg_542_1.actors_["1026ui_story"].transform.localPosition = Vector3.New(0, -1.05, -6.2)
				arg_542_1.actors_["1026ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_542_1.actors_["1026ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_542_1.actors_["1026ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_542_1.actors_["1026ui_story"].transform.position).z)
				arg_542_1.actors_["1026ui_story"].transform.localEulerAngles.z = 0
				arg_542_1.actors_["1026ui_story"].transform.localEulerAngles.x = 0
				arg_542_1.actors_["1026ui_story"].transform.localEulerAngles = arg_542_1.actors_["1026ui_story"].transform.localEulerAngles
			end

			local var_545_1 = arg_542_1.actors_["1026ui_story"]

			if 0 < arg_542_1.time_ and arg_542_1.time_ <= 0 + arg_545_0 and not isNil(var_545_1) and arg_542_1.var_.characterEffect1026ui_story == nil then
				arg_542_1.var_.characterEffect1026ui_story = var_545_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_545_2 = 0.2

			if 0 <= arg_542_1.time_ and arg_542_1.time_ < 0 + var_545_2 and not isNil(var_545_1) then
				if arg_542_1.var_.characterEffect1026ui_story and not isNil(var_545_1) then
					arg_542_1.var_.characterEffect1026ui_story.fillFlat = false
				end
			end

			if arg_542_1.time_ >= 0 + var_545_2 and arg_542_1.time_ < 0 + var_545_2 + arg_545_0 and not isNil(var_545_1) and arg_542_1.var_.characterEffect1026ui_story then
				arg_542_1.var_.characterEffect1026ui_story.fillFlat = false
			end

			if 0 < arg_542_1.time_ and arg_542_1.time_ <= 0 + arg_545_0 then
				arg_542_1:PlayTimeline("1026ui_story", "StoryTimeline/CharAction/story1026/story1026action/1026action1_1")
			end

			if 0 < arg_542_1.time_ and arg_542_1.time_ <= 0 + arg_545_0 then
				arg_542_1:PlayTimeline("1026ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_545_4 = 0
			local var_545_5 = 0.625

			if 0 < arg_542_1.time_ and arg_542_1.time_ <= var_545_4 + arg_545_0 then
				arg_542_1.talkMaxDuration = 0
				arg_542_1.dialogCg_.alpha = 1

				arg_542_1.dialog_:SetActive(true)
				SetActive(arg_542_1.leftNameGo_, true)

				arg_542_1.leftNameTxt_.text = arg_542_1:FormatText(StoryNameCfg[83].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_542_1.leftNameTxt_.transform)

				arg_542_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_542_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_542_1:RecordName(arg_542_1.leftNameTxt_.text)
				SetActive(arg_542_1.iconTrs_.gameObject, false)
				arg_542_1.callingController_:SetSelectedState("normal")

				local var_545_6 = arg_542_1:GetWordFromCfg(102601131)
				local var_545_7 = arg_542_1:FormatText(var_545_6.content)

				arg_542_1.text_.text = var_545_7

				LuaForUtil.ClearLinePrefixSymbol(arg_542_1.text_)

				local var_545_9 = 25 <= 0 and var_545_5 or var_545_5 * (utf8.len(var_545_7) / 25)

				if (25 <= 0 and var_545_5 or var_545_5 * (utf8.len(var_545_7) / 25)) > 0 and var_545_5 < var_545_9 then
					arg_542_1.talkMaxDuration = var_545_9

					if var_545_9 + var_545_4 > arg_542_1.duration_ then
						arg_542_1.duration_ = var_545_9 + var_545_4
					end
				end

				arg_542_1.text_.text = var_545_7
				arg_542_1.typewritter.percent = 0

				arg_542_1.typewritter:SetDirty()
				arg_542_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_102601", "102601131", "story_v_side_old_102601.awb") ~= 0 then
					local var_545_10 = manager.audio:GetVoiceLength("story_v_side_old_102601", "102601131", "story_v_side_old_102601.awb") / 1000

					if var_545_10 + var_545_4 > arg_542_1.duration_ then
						arg_542_1.duration_ = var_545_10 + var_545_4
					end

					if var_545_6.prefab_name ~= "" and arg_542_1.actors_[var_545_6.prefab_name] ~= nil then
						local var_545_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_542_1.actors_[var_545_6.prefab_name].transform, "story_v_side_old_102601", "102601131", "story_v_side_old_102601.awb")

						arg_542_1:RecordAudio("102601131", var_545_11)
						arg_542_1:RecordAudio("102601131", var_545_11)
					else
						arg_542_1:AudioAction("play", "voice", "story_v_side_old_102601", "102601131", "story_v_side_old_102601.awb")
					end

					arg_542_1:RecordHistoryTalkVoice("story_v_side_old_102601", "102601131", "story_v_side_old_102601.awb")
				end

				arg_542_1:RecordContent(arg_542_1.text_.text)
			end

			local var_545_12 = math.max(var_545_5, arg_542_1.talkMaxDuration)

			if var_545_4 <= arg_542_1.time_ and arg_542_1.time_ < var_545_4 + var_545_12 then
				arg_542_1.typewritter.percent = (arg_542_1.time_ - var_545_4) / var_545_12

				arg_542_1.typewritter:SetDirty()
			end

			if arg_542_1.time_ >= var_545_4 + var_545_12 and arg_542_1.time_ < var_545_4 + var_545_12 + arg_545_0 then
				arg_542_1.typewritter.percent = 1

				arg_542_1.typewritter:SetDirty()
				arg_542_1:ShowNextGo(true)
			end
		end

		arg_542_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1026ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_542_1:InitPlayNodeList()
	end,
	Play102601132 = function(arg_546_0, arg_546_1)
		arg_546_1.time_ = 0
		arg_546_1.frameCnt_ = 0
		arg_546_1.state_ = "playing"
		arg_546_1.curTalkId_ = 102601132
		arg_546_1.duration_ = 5

		SetActive(arg_546_1.tipsGo_, false)

		function arg_546_1.onSingleLineFinish_()
			arg_546_1.onSingleLineUpdate_ = nil
			arg_546_1.onSingleLineFinish_ = nil
			arg_546_1.state_ = "waiting"
		end

		function arg_546_1.playNext_(arg_548_0)
			if arg_548_0 == 1 then
				arg_546_0:Play102601133(arg_546_1)
			end
		end

		function arg_546_1.onSingleLineUpdate_(arg_549_0)
			if 0 < arg_546_1.time_ and arg_546_1.time_ <= 0 + arg_549_0 then
				arg_546_1.var_.moveOldPos1026ui_story = arg_546_1.actors_["1026ui_story"].transform.localPosition
			end

			local var_549_0 = 0.001

			if 0 <= arg_546_1.time_ and arg_546_1.time_ < 0 + var_549_0 then
				arg_546_1.actors_["1026ui_story"].transform.localPosition = Vector3.Lerp(arg_546_1.var_.moveOldPos1026ui_story, Vector3.New(0, 100, 0), (arg_546_1.time_ - 0) / var_549_0)
				arg_546_1.actors_["1026ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_546_1.actors_["1026ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_546_1.actors_["1026ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_546_1.actors_["1026ui_story"].transform.position).z)
				arg_546_1.actors_["1026ui_story"].transform.localEulerAngles.z = 0
				arg_546_1.actors_["1026ui_story"].transform.localEulerAngles.x = 0
				arg_546_1.actors_["1026ui_story"].transform.localEulerAngles = arg_546_1.actors_["1026ui_story"].transform.localEulerAngles
			end

			if arg_546_1.time_ >= 0 + var_549_0 and arg_546_1.time_ < 0 + var_549_0 + arg_549_0 then
				arg_546_1.actors_["1026ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_546_1.actors_["1026ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_546_1.actors_["1026ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_546_1.actors_["1026ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_546_1.actors_["1026ui_story"].transform.position).z)
				arg_546_1.actors_["1026ui_story"].transform.localEulerAngles.z = 0
				arg_546_1.actors_["1026ui_story"].transform.localEulerAngles.x = 0
				arg_546_1.actors_["1026ui_story"].transform.localEulerAngles = arg_546_1.actors_["1026ui_story"].transform.localEulerAngles
			end

			local var_549_1 = 0
			local var_549_2 = 0.55

			if 0 < arg_546_1.time_ and arg_546_1.time_ <= var_549_1 + arg_549_0 then
				arg_546_1.talkMaxDuration = 0
				arg_546_1.dialogCg_.alpha = 1

				arg_546_1.dialog_:SetActive(true)
				SetActive(arg_546_1.leftNameGo_, false)

				arg_546_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_546_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_546_1:RecordName(arg_546_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_546_1.iconTrs_.gameObject, false)
				arg_546_1.callingController_:SetSelectedState("normal")

				local var_549_3 = arg_546_1:FormatText(arg_546_1:GetWordFromCfg(102601132).content)

				arg_546_1.text_.text = var_549_3

				LuaForUtil.ClearLinePrefixSymbol(arg_546_1.text_)

				local var_549_5 = 22 <= 0 and var_549_2 or var_549_2 * (utf8.len(var_549_3) / 22)

				if (22 <= 0 and var_549_2 or var_549_2 * (utf8.len(var_549_3) / 22)) > 0 and var_549_2 < var_549_5 then
					arg_546_1.talkMaxDuration = var_549_5

					if var_549_5 + var_549_1 > arg_546_1.duration_ then
						arg_546_1.duration_ = var_549_5 + var_549_1
					end
				end

				arg_546_1.text_.text = var_549_3
				arg_546_1.typewritter.percent = 0

				arg_546_1.typewritter:SetDirty()
				arg_546_1:ShowNextGo(false)
				arg_546_1:RecordContent(arg_546_1.text_.text)
			end

			local var_549_6 = math.max(var_549_2, arg_546_1.talkMaxDuration)

			if var_549_1 <= arg_546_1.time_ and arg_546_1.time_ < var_549_1 + var_549_6 then
				arg_546_1.typewritter.percent = (arg_546_1.time_ - var_549_1) / var_549_6

				arg_546_1.typewritter:SetDirty()
			end

			if arg_546_1.time_ >= var_549_1 + var_549_6 and arg_546_1.time_ < var_549_1 + var_549_6 + arg_549_0 then
				arg_546_1.typewritter.percent = 1

				arg_546_1.typewritter:SetDirty()
				arg_546_1:ShowNextGo(true)
			end
		end

		arg_546_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1026ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_546_1:InitPlayNodeList()
	end,
	Play102601133 = function(arg_550_0, arg_550_1)
		arg_550_1.time_ = 0
		arg_550_1.frameCnt_ = 0
		arg_550_1.state_ = "playing"
		arg_550_1.curTalkId_ = 102601133
		arg_550_1.duration_ = 5

		SetActive(arg_550_1.tipsGo_, false)

		function arg_550_1.onSingleLineFinish_()
			arg_550_1.onSingleLineUpdate_ = nil
			arg_550_1.onSingleLineFinish_ = nil
			arg_550_1.state_ = "waiting"
		end

		function arg_550_1.playNext_(arg_552_0)
			if arg_552_0 == 1 then
				arg_550_0:Play102601134(arg_550_1)
			end
		end

		function arg_550_1.onSingleLineUpdate_(arg_553_0)
			local var_553_0 = 0.975

			if 0 < arg_550_1.time_ and arg_550_1.time_ <= 0 + arg_553_0 then
				arg_550_1.talkMaxDuration = 0
				arg_550_1.dialogCg_.alpha = 1

				arg_550_1.dialog_:SetActive(true)
				SetActive(arg_550_1.leftNameGo_, false)

				arg_550_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_550_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_550_1:RecordName(arg_550_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_550_1.iconTrs_.gameObject, false)
				arg_550_1.callingController_:SetSelectedState("normal")

				local var_553_1 = arg_550_1:FormatText(arg_550_1:GetWordFromCfg(102601133).content)

				arg_550_1.text_.text = var_553_1

				LuaForUtil.ClearLinePrefixSymbol(arg_550_1.text_)

				local var_553_3 = 39 <= 0 and var_553_0 or var_553_0 * (utf8.len(var_553_1) / 39)

				if (39 <= 0 and var_553_0 or var_553_0 * (utf8.len(var_553_1) / 39)) > 0 and var_553_0 < var_553_3 then
					arg_550_1.talkMaxDuration = var_553_3

					if var_553_3 + 0 > arg_550_1.duration_ then
						arg_550_1.duration_ = var_553_3 + 0
					end
				end

				arg_550_1.text_.text = var_553_1
				arg_550_1.typewritter.percent = 0

				arg_550_1.typewritter:SetDirty()
				arg_550_1:ShowNextGo(false)
				arg_550_1:RecordContent(arg_550_1.text_.text)
			end

			local var_553_4 = math.max(var_553_0, arg_550_1.talkMaxDuration)

			if 0 <= arg_550_1.time_ and arg_550_1.time_ < 0 + var_553_4 then
				arg_550_1.typewritter.percent = (arg_550_1.time_ - 0) / var_553_4

				arg_550_1.typewritter:SetDirty()
			end

			if arg_550_1.time_ >= 0 + var_553_4 and arg_550_1.time_ < 0 + var_553_4 + arg_553_0 then
				arg_550_1.typewritter.percent = 1

				arg_550_1.typewritter:SetDirty()
				arg_550_1:ShowNextGo(true)
			end
		end

		arg_550_1.nodeConfigList_ = {}

		arg_550_1:InitPlayNodeList()
	end,
	Play102601134 = function(arg_554_0, arg_554_1)
		arg_554_1.time_ = 0
		arg_554_1.frameCnt_ = 0
		arg_554_1.state_ = "playing"
		arg_554_1.curTalkId_ = 102601134
		arg_554_1.duration_ = 7.62

		SetActive(arg_554_1.tipsGo_, false)

		function arg_554_1.onSingleLineFinish_()
			arg_554_1.onSingleLineUpdate_ = nil
			arg_554_1.onSingleLineFinish_ = nil
			arg_554_1.state_ = "waiting"
		end

		function arg_554_1.playNext_(arg_556_0)
			if arg_556_0 == 1 then
				arg_554_0:Play102601135(arg_554_1)
			end
		end

		function arg_554_1.onSingleLineUpdate_(arg_557_0)
			if arg_554_1.bgs_.ST03a == nil then
				local var_557_0 = Object.Instantiate(arg_554_1.paintGo_)

				var_557_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST03a")
				var_557_0.name = "ST03a"
				var_557_0.transform.parent = arg_554_1.stage_.transform
				var_557_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_554_1.bgs_.ST03a = var_557_0
			end

			if 1.5 < arg_554_1.time_ and arg_554_1.time_ <= 1.5 + arg_557_0 then
				local var_557_1 = arg_554_1.bgs_.ST03a

				arg_554_1.bgs_.ST03a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_557_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_557_2 = var_557_1:GetComponent("SpriteRenderer")

				if var_557_2 and var_557_2.sprite then
					local var_557_3 = 2 * (var_557_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_557_1.transform.localScale = Vector3.New(var_557_3 / var_557_2.sprite.bounds.size.y < var_557_3 * manager.ui.mainCameraCom_.aspect / var_557_2.sprite.bounds.size.x and var_557_3 * manager.ui.mainCameraCom_.aspect / var_557_2.sprite.bounds.size.x or var_557_3 / var_557_2.sprite.bounds.size.y, var_557_3 / var_557_2.sprite.bounds.size.y < var_557_3 * manager.ui.mainCameraCom_.aspect / var_557_2.sprite.bounds.size.x and var_557_3 * manager.ui.mainCameraCom_.aspect / var_557_2.sprite.bounds.size.x or var_557_3 / var_557_2.sprite.bounds.size.y, 0)
				end

				for iter_557_0, iter_557_1 in pairs(arg_554_1.bgs_) do
					if iter_557_0 ~= "ST03a" then
						iter_557_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 0 < arg_554_1.time_ and arg_554_1.time_ <= 0 + arg_557_0 then
				local var_557_4 = arg_554_1.bgs_.ST03:GetComponent("SpriteRenderer")

				if var_557_4 then
					arg_554_1.var_.alphaOldValueST03 = var_557_4.color.a
					arg_554_1.var_.alphaMatValueST03 = var_557_4
				end

				arg_554_1.var_.alphaOldValueST03 = 1
			end

			local var_557_5 = 1.5

			if 0 <= arg_554_1.time_ and arg_554_1.time_ < 0 + var_557_5 then
				if arg_554_1.var_.alphaMatValueST03 then
					arg_554_1.var_.alphaMatValueST03.color.a = Mathf.Lerp(arg_554_1.var_.alphaOldValueST03, 0, (arg_554_1.time_ - 0) / var_557_5)
					arg_554_1.var_.alphaMatValueST03.color = arg_554_1.var_.alphaMatValueST03.color
				end
			end

			if arg_554_1.time_ >= 0 + var_557_5 and arg_554_1.time_ < 0 + var_557_5 + arg_557_0 and arg_554_1.var_.alphaMatValueST03 then
				arg_554_1.var_.alphaMatValueST03.color.a = 0
				arg_554_1.var_.alphaMatValueST03.color = arg_554_1.var_.alphaMatValueST03.color
			end

			if 1.5 < arg_554_1.time_ and arg_554_1.time_ <= 1.5 + arg_557_0 then
				local var_557_6 = arg_554_1.bgs_.ST03a:GetComponent("SpriteRenderer")

				if var_557_6 then
					arg_554_1.var_.alphaOldValueST03a = var_557_6.color.a
					arg_554_1.var_.alphaMatValueST03a = var_557_6
				end

				arg_554_1.var_.alphaOldValueST03a = 0
			end

			local var_557_7 = 1.5

			if 1.5 <= arg_554_1.time_ and arg_554_1.time_ < 1.5 + var_557_7 then
				if arg_554_1.var_.alphaMatValueST03a then
					arg_554_1.var_.alphaMatValueST03a.color.a = Mathf.Lerp(arg_554_1.var_.alphaOldValueST03a, 1, (arg_554_1.time_ - 1.5) / var_557_7)
					arg_554_1.var_.alphaMatValueST03a.color = arg_554_1.var_.alphaMatValueST03a.color
				end
			end

			if arg_554_1.time_ >= 1.5 + var_557_7 and arg_554_1.time_ < 1.5 + var_557_7 + arg_557_0 and arg_554_1.var_.alphaMatValueST03a then
				arg_554_1.var_.alphaMatValueST03a.color.a = 1
				arg_554_1.var_.alphaMatValueST03a.color = arg_554_1.var_.alphaMatValueST03a.color
			end

			local var_557_8 = 0

			if 0 < arg_554_1.time_ and arg_554_1.time_ <= var_557_8 + arg_557_0 then
				arg_554_1.allBtn_.enabled = false
			end

			if arg_554_1.time_ >= var_557_8 + 2.625 and arg_554_1.time_ < var_557_8 + 2.625 + arg_557_0 then
				arg_554_1.allBtn_.enabled = true
			end

			if arg_554_1.frameCnt_ <= 1 then
				arg_554_1.dialog_:SetActive(false)
			end

			local var_557_9 = 2.625
			local var_557_10 = 0.375

			if 2.625 < arg_554_1.time_ and arg_554_1.time_ <= var_557_9 + arg_557_0 then
				arg_554_1.talkMaxDuration = 0

				arg_554_1.dialog_:SetActive(true)

				arg_554_1.dialogCg_.alpha = 0

				local var_557_11 = LeanTween.value(arg_554_1.dialog_, 0, 1, 0.3)

				var_557_11:setOnUpdate(LuaHelper.FloatAction(function(arg_558_0)
					arg_554_1.dialogCg_.alpha = arg_558_0
				end))
				var_557_11:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_554_1.dialog_)
					var_557_11:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_554_1.duration_ = arg_554_1.duration_ + 0.3

				SetActive(arg_554_1.leftNameGo_, false)

				arg_554_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_554_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_554_1:RecordName(arg_554_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_554_1.iconTrs_.gameObject, false)
				arg_554_1.callingController_:SetSelectedState("normal")

				local var_557_12 = arg_554_1:FormatText(arg_554_1:GetWordFromCfg(102601134).content)

				arg_554_1.text_.text = var_557_12

				LuaForUtil.ClearLinePrefixSymbol(arg_554_1.text_)

				local var_557_14 = 15 <= 0 and var_557_10 or var_557_10 * (utf8.len(var_557_12) / 15)

				if (15 <= 0 and var_557_10 or var_557_10 * (utf8.len(var_557_12) / 15)) > 0 and var_557_10 < var_557_14 then
					arg_554_1.talkMaxDuration = var_557_14
					var_557_9 = var_557_9 + 0.3

					if var_557_14 + var_557_9 > arg_554_1.duration_ then
						arg_554_1.duration_ = var_557_14 + var_557_9
					end
				end

				arg_554_1.text_.text = var_557_12
				arg_554_1.typewritter.percent = 0

				arg_554_1.typewritter:SetDirty()
				arg_554_1:ShowNextGo(false)
				arg_554_1:RecordContent(arg_554_1.text_.text)
			end

			local var_557_15 = var_557_9 + 0.3
			local var_557_16 = math.max(var_557_10, arg_554_1.talkMaxDuration)

			if var_557_9 + 0.3 <= arg_554_1.time_ and arg_554_1.time_ < var_557_15 + var_557_16 then
				arg_554_1.typewritter.percent = (arg_554_1.time_ - var_557_15) / var_557_16

				arg_554_1.typewritter:SetDirty()
			end

			if arg_554_1.time_ >= var_557_15 + var_557_16 and arg_554_1.time_ < var_557_15 + var_557_16 + arg_557_0 then
				arg_554_1.typewritter.percent = 1

				arg_554_1.typewritter:SetDirty()
				arg_554_1:ShowNextGo(true)
			end
		end

		arg_554_1.nodeConfigList_ = {}

		arg_554_1:InitPlayNodeList()
	end,
	Play102601135 = function(arg_560_0, arg_560_1)
		arg_560_1.time_ = 0
		arg_560_1.frameCnt_ = 0
		arg_560_1.state_ = "playing"
		arg_560_1.curTalkId_ = 102601135
		arg_560_1.duration_ = 5

		SetActive(arg_560_1.tipsGo_, false)

		function arg_560_1.onSingleLineFinish_()
			arg_560_1.onSingleLineUpdate_ = nil
			arg_560_1.onSingleLineFinish_ = nil
			arg_560_1.state_ = "waiting"
		end

		function arg_560_1.playNext_(arg_562_0)
			if arg_562_0 == 1 then
				arg_560_0:Play102601136(arg_560_1)
			end
		end

		function arg_560_1.onSingleLineUpdate_(arg_563_0)
			local var_563_0 = 1.4

			if 0 < arg_560_1.time_ and arg_560_1.time_ <= 0 + arg_563_0 then
				arg_560_1.talkMaxDuration = 0
				arg_560_1.dialogCg_.alpha = 1

				arg_560_1.dialog_:SetActive(true)
				SetActive(arg_560_1.leftNameGo_, false)

				arg_560_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_560_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_560_1:RecordName(arg_560_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_560_1.iconTrs_.gameObject, false)
				arg_560_1.callingController_:SetSelectedState("normal")

				local var_563_1 = arg_560_1:FormatText(arg_560_1:GetWordFromCfg(102601135).content)

				arg_560_1.text_.text = var_563_1

				LuaForUtil.ClearLinePrefixSymbol(arg_560_1.text_)

				local var_563_3 = 56 <= 0 and var_563_0 or var_563_0 * (utf8.len(var_563_1) / 56)

				if (56 <= 0 and var_563_0 or var_563_0 * (utf8.len(var_563_1) / 56)) > 0 and var_563_0 < var_563_3 then
					arg_560_1.talkMaxDuration = var_563_3

					if var_563_3 + 0 > arg_560_1.duration_ then
						arg_560_1.duration_ = var_563_3 + 0
					end
				end

				arg_560_1.text_.text = var_563_1
				arg_560_1.typewritter.percent = 0

				arg_560_1.typewritter:SetDirty()
				arg_560_1:ShowNextGo(false)
				arg_560_1:RecordContent(arg_560_1.text_.text)
			end

			local var_563_4 = math.max(var_563_0, arg_560_1.talkMaxDuration)

			if 0 <= arg_560_1.time_ and arg_560_1.time_ < 0 + var_563_4 then
				arg_560_1.typewritter.percent = (arg_560_1.time_ - 0) / var_563_4

				arg_560_1.typewritter:SetDirty()
			end

			if arg_560_1.time_ >= 0 + var_563_4 and arg_560_1.time_ < 0 + var_563_4 + arg_563_0 then
				arg_560_1.typewritter.percent = 1

				arg_560_1.typewritter:SetDirty()
				arg_560_1:ShowNextGo(true)
			end
		end

		arg_560_1.nodeConfigList_ = {}

		arg_560_1:InitPlayNodeList()
	end,
	Play102601136 = function(arg_564_0, arg_564_1)
		arg_564_1.time_ = 0
		arg_564_1.frameCnt_ = 0
		arg_564_1.state_ = "playing"
		arg_564_1.curTalkId_ = 102601136
		arg_564_1.duration_ = 3.47

		local var_564_0 = {
			ja = 3.466,
			ko = 2.666,
			zh = 3,
			en = 2.833
		}
		local var_564_1 = manager.audio:GetLocalizationFlag()

		if var_564_0[var_564_1] ~= nil then
			arg_564_1.duration_ = var_564_0[var_564_1]
		end

		SetActive(arg_564_1.tipsGo_, false)

		function arg_564_1.onSingleLineFinish_()
			arg_564_1.onSingleLineUpdate_ = nil
			arg_564_1.onSingleLineFinish_ = nil
			arg_564_1.state_ = "waiting"
		end

		function arg_564_1.playNext_(arg_566_0)
			if arg_566_0 == 1 then
				arg_564_0:Play102601137(arg_564_1)
			end
		end

		function arg_564_1.onSingleLineUpdate_(arg_567_0)
			if 0 < arg_564_1.time_ and arg_564_1.time_ <= 0 + arg_567_0 then
				arg_564_1.var_.moveOldPos1019ui_story = arg_564_1.actors_["1019ui_story"].transform.localPosition
			end

			local var_567_0 = 0.001

			if 0 <= arg_564_1.time_ and arg_564_1.time_ < 0 + var_567_0 then
				arg_564_1.actors_["1019ui_story"].transform.localPosition = Vector3.Lerp(arg_564_1.var_.moveOldPos1019ui_story, Vector3.New(-0.2, -1.08, -5.9), (arg_564_1.time_ - 0) / var_567_0)
				arg_564_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_564_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_564_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_564_1.actors_["1019ui_story"].transform.position).z)
				arg_564_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_564_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_564_1.actors_["1019ui_story"].transform.localEulerAngles = arg_564_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			if arg_564_1.time_ >= 0 + var_567_0 and arg_564_1.time_ < 0 + var_567_0 + arg_567_0 then
				arg_564_1.actors_["1019ui_story"].transform.localPosition = Vector3.New(-0.2, -1.08, -5.9)
				arg_564_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_564_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_564_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_564_1.actors_["1019ui_story"].transform.position).z)
				arg_564_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_564_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_564_1.actors_["1019ui_story"].transform.localEulerAngles = arg_564_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			local var_567_1 = arg_564_1.actors_["1019ui_story"]

			if 0 < arg_564_1.time_ and arg_564_1.time_ <= 0 + arg_567_0 and not isNil(var_567_1) and arg_564_1.var_.characterEffect1019ui_story == nil then
				arg_564_1.var_.characterEffect1019ui_story = var_567_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_567_2 = 0.2

			if 0 <= arg_564_1.time_ and arg_564_1.time_ < 0 + var_567_2 and not isNil(var_567_1) then
				if arg_564_1.var_.characterEffect1019ui_story and not isNil(var_567_1) then
					arg_564_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_564_1.time_ >= 0 + var_567_2 and arg_564_1.time_ < 0 + var_567_2 + arg_567_0 and not isNil(var_567_1) and arg_564_1.var_.characterEffect1019ui_story then
				arg_564_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			if 0 < arg_564_1.time_ and arg_564_1.time_ <= 0 + arg_567_0 then
				arg_564_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action5_1")
			end

			if 0 < arg_564_1.time_ and arg_564_1.time_ <= 0 + arg_567_0 then
				arg_564_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_567_4 = 0
			local var_567_5 = 0.325

			if 0 < arg_564_1.time_ and arg_564_1.time_ <= var_567_4 + arg_567_0 then
				arg_564_1.talkMaxDuration = 0
				arg_564_1.dialogCg_.alpha = 1

				arg_564_1.dialog_:SetActive(true)
				SetActive(arg_564_1.leftNameGo_, true)

				arg_564_1.leftNameTxt_.text = arg_564_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_564_1.leftNameTxt_.transform)

				arg_564_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_564_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_564_1:RecordName(arg_564_1.leftNameTxt_.text)
				SetActive(arg_564_1.iconTrs_.gameObject, false)
				arg_564_1.callingController_:SetSelectedState("normal")

				local var_567_6 = arg_564_1:GetWordFromCfg(102601136)
				local var_567_7 = arg_564_1:FormatText(var_567_6.content)

				arg_564_1.text_.text = var_567_7

				LuaForUtil.ClearLinePrefixSymbol(arg_564_1.text_)

				local var_567_9 = 13 <= 0 and var_567_5 or var_567_5 * (utf8.len(var_567_7) / 13)

				if (13 <= 0 and var_567_5 or var_567_5 * (utf8.len(var_567_7) / 13)) > 0 and var_567_5 < var_567_9 then
					arg_564_1.talkMaxDuration = var_567_9

					if var_567_9 + var_567_4 > arg_564_1.duration_ then
						arg_564_1.duration_ = var_567_9 + var_567_4
					end
				end

				arg_564_1.text_.text = var_567_7
				arg_564_1.typewritter.percent = 0

				arg_564_1.typewritter:SetDirty()
				arg_564_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_102601", "102601136", "story_v_side_old_102601.awb") ~= 0 then
					local var_567_10 = manager.audio:GetVoiceLength("story_v_side_old_102601", "102601136", "story_v_side_old_102601.awb") / 1000

					if var_567_10 + var_567_4 > arg_564_1.duration_ then
						arg_564_1.duration_ = var_567_10 + var_567_4
					end

					if var_567_6.prefab_name ~= "" and arg_564_1.actors_[var_567_6.prefab_name] ~= nil then
						local var_567_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_564_1.actors_[var_567_6.prefab_name].transform, "story_v_side_old_102601", "102601136", "story_v_side_old_102601.awb")

						arg_564_1:RecordAudio("102601136", var_567_11)
						arg_564_1:RecordAudio("102601136", var_567_11)
					else
						arg_564_1:AudioAction("play", "voice", "story_v_side_old_102601", "102601136", "story_v_side_old_102601.awb")
					end

					arg_564_1:RecordHistoryTalkVoice("story_v_side_old_102601", "102601136", "story_v_side_old_102601.awb")
				end

				arg_564_1:RecordContent(arg_564_1.text_.text)
			end

			local var_567_12 = math.max(var_567_5, arg_564_1.talkMaxDuration)

			if var_567_4 <= arg_564_1.time_ and arg_564_1.time_ < var_567_4 + var_567_12 then
				arg_564_1.typewritter.percent = (arg_564_1.time_ - var_567_4) / var_567_12

				arg_564_1.typewritter:SetDirty()
			end

			if arg_564_1.time_ >= var_567_4 + var_567_12 and arg_564_1.time_ < var_567_4 + var_567_12 + arg_567_0 then
				arg_564_1.typewritter.percent = 1

				arg_564_1.typewritter:SetDirty()
				arg_564_1:ShowNextGo(true)
			end
		end

		arg_564_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_564_1:InitPlayNodeList()
	end,
	Play102601137 = function(arg_568_0, arg_568_1)
		arg_568_1.time_ = 0
		arg_568_1.frameCnt_ = 0
		arg_568_1.state_ = "playing"
		arg_568_1.curTalkId_ = 102601137
		arg_568_1.duration_ = 5

		SetActive(arg_568_1.tipsGo_, false)

		function arg_568_1.onSingleLineFinish_()
			arg_568_1.onSingleLineUpdate_ = nil
			arg_568_1.onSingleLineFinish_ = nil
			arg_568_1.state_ = "waiting"
		end

		function arg_568_1.playNext_(arg_570_0)
			if arg_570_0 == 1 then
				arg_568_0:Play102601138(arg_568_1)
			end
		end

		function arg_568_1.onSingleLineUpdate_(arg_571_0)
			if 0 < arg_568_1.time_ and arg_568_1.time_ <= 0 + arg_571_0 and not isNil(arg_568_1.actors_["1019ui_story"]) and arg_568_1.var_.characterEffect1019ui_story == nil then
				arg_568_1.var_.characterEffect1019ui_story = arg_568_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_571_0 = 0.2

			if 0 <= arg_568_1.time_ and arg_568_1.time_ < 0 + var_571_0 and not isNil(arg_568_1.actors_["1019ui_story"]) then
				if arg_568_1.var_.characterEffect1019ui_story and not isNil(arg_568_1.actors_["1019ui_story"]) then
					arg_568_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_568_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_568_1.time_ - 0) / var_571_0)
				end
			end

			if arg_568_1.time_ >= 0 + var_571_0 and arg_568_1.time_ < 0 + var_571_0 + arg_571_0 and not isNil(arg_568_1.actors_["1019ui_story"]) and arg_568_1.var_.characterEffect1019ui_story then
				arg_568_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_568_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_571_1 = 0
			local var_571_2 = 1.05

			if 0 < arg_568_1.time_ and arg_568_1.time_ <= var_571_1 + arg_571_0 then
				arg_568_1.talkMaxDuration = 0
				arg_568_1.dialogCg_.alpha = 1

				arg_568_1.dialog_:SetActive(true)
				SetActive(arg_568_1.leftNameGo_, true)

				arg_568_1.leftNameTxt_.text = arg_568_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_568_1.leftNameTxt_.transform)

				arg_568_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_568_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_568_1:RecordName(arg_568_1.leftNameTxt_.text)
				SetActive(arg_568_1.iconTrs_.gameObject, true)
				arg_568_1.iconController_:SetSelectedState("hero")

				arg_568_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_568_1.callingController_:SetSelectedState("normal")

				arg_568_1.keyicon_.color = Color.New(1, 1, 1)
				arg_568_1.icon_.color = Color.New(1, 1, 1)

				local var_571_3 = arg_568_1:FormatText(arg_568_1:GetWordFromCfg(102601137).content)

				arg_568_1.text_.text = var_571_3

				LuaForUtil.ClearLinePrefixSymbol(arg_568_1.text_)

				local var_571_5 = 42 <= 0 and var_571_2 or var_571_2 * (utf8.len(var_571_3) / 42)

				if (42 <= 0 and var_571_2 or var_571_2 * (utf8.len(var_571_3) / 42)) > 0 and var_571_2 < var_571_5 then
					arg_568_1.talkMaxDuration = var_571_5

					if var_571_5 + var_571_1 > arg_568_1.duration_ then
						arg_568_1.duration_ = var_571_5 + var_571_1
					end
				end

				arg_568_1.text_.text = var_571_3
				arg_568_1.typewritter.percent = 0

				arg_568_1.typewritter:SetDirty()
				arg_568_1:ShowNextGo(false)
				arg_568_1:RecordContent(arg_568_1.text_.text)
			end

			local var_571_6 = math.max(var_571_2, arg_568_1.talkMaxDuration)

			if var_571_1 <= arg_568_1.time_ and arg_568_1.time_ < var_571_1 + var_571_6 then
				arg_568_1.typewritter.percent = (arg_568_1.time_ - var_571_1) / var_571_6

				arg_568_1.typewritter:SetDirty()
			end

			if arg_568_1.time_ >= var_571_1 + var_571_6 and arg_568_1.time_ < var_571_1 + var_571_6 + arg_571_0 then
				arg_568_1.typewritter.percent = 1

				arg_568_1.typewritter:SetDirty()
				arg_568_1:ShowNextGo(true)
			end
		end

		arg_568_1.nodeConfigList_ = {}

		arg_568_1:InitPlayNodeList()
	end,
	Play102601138 = function(arg_572_0, arg_572_1)
		arg_572_1.time_ = 0
		arg_572_1.frameCnt_ = 0
		arg_572_1.state_ = "playing"
		arg_572_1.curTalkId_ = 102601138
		arg_572_1.duration_ = 5

		SetActive(arg_572_1.tipsGo_, false)

		function arg_572_1.onSingleLineFinish_()
			arg_572_1.onSingleLineUpdate_ = nil
			arg_572_1.onSingleLineFinish_ = nil
			arg_572_1.state_ = "waiting"
		end

		function arg_572_1.playNext_(arg_574_0)
			if arg_574_0 == 1 then
				arg_572_0:Play102601139(arg_572_1)
			end
		end

		function arg_572_1.onSingleLineUpdate_(arg_575_0)
			local var_575_0 = 0.2

			if 0 < arg_572_1.time_ and arg_572_1.time_ <= 0 + arg_575_0 then
				arg_572_1.talkMaxDuration = 0
				arg_572_1.dialogCg_.alpha = 1

				arg_572_1.dialog_:SetActive(true)
				SetActive(arg_572_1.leftNameGo_, true)

				arg_572_1.leftNameTxt_.text = arg_572_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_572_1.leftNameTxt_.transform)

				arg_572_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_572_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_572_1:RecordName(arg_572_1.leftNameTxt_.text)
				SetActive(arg_572_1.iconTrs_.gameObject, true)
				arg_572_1.iconController_:SetSelectedState("hero")

				arg_572_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_572_1.callingController_:SetSelectedState("normal")

				arg_572_1.keyicon_.color = Color.New(1, 1, 1)
				arg_572_1.icon_.color = Color.New(1, 1, 1)

				local var_575_1 = arg_572_1:FormatText(arg_572_1:GetWordFromCfg(102601138).content)

				arg_572_1.text_.text = var_575_1

				LuaForUtil.ClearLinePrefixSymbol(arg_572_1.text_)

				local var_575_3 = 8 <= 0 and var_575_0 or var_575_0 * (utf8.len(var_575_1) / 8)

				if (8 <= 0 and var_575_0 or var_575_0 * (utf8.len(var_575_1) / 8)) > 0 and var_575_0 < var_575_3 then
					arg_572_1.talkMaxDuration = var_575_3

					if var_575_3 + 0 > arg_572_1.duration_ then
						arg_572_1.duration_ = var_575_3 + 0
					end
				end

				arg_572_1.text_.text = var_575_1
				arg_572_1.typewritter.percent = 0

				arg_572_1.typewritter:SetDirty()
				arg_572_1:ShowNextGo(false)
				arg_572_1:RecordContent(arg_572_1.text_.text)
			end

			local var_575_4 = math.max(var_575_0, arg_572_1.talkMaxDuration)

			if 0 <= arg_572_1.time_ and arg_572_1.time_ < 0 + var_575_4 then
				arg_572_1.typewritter.percent = (arg_572_1.time_ - 0) / var_575_4

				arg_572_1.typewritter:SetDirty()
			end

			if arg_572_1.time_ >= 0 + var_575_4 and arg_572_1.time_ < 0 + var_575_4 + arg_575_0 then
				arg_572_1.typewritter.percent = 1

				arg_572_1.typewritter:SetDirty()
				arg_572_1:ShowNextGo(true)
			end
		end

		arg_572_1.nodeConfigList_ = {}

		arg_572_1:InitPlayNodeList()
	end,
	Play102601139 = function(arg_576_0, arg_576_1)
		arg_576_1.time_ = 0
		arg_576_1.frameCnt_ = 0
		arg_576_1.state_ = "playing"
		arg_576_1.curTalkId_ = 102601139
		arg_576_1.duration_ = 5

		SetActive(arg_576_1.tipsGo_, false)

		function arg_576_1.onSingleLineFinish_()
			arg_576_1.onSingleLineUpdate_ = nil
			arg_576_1.onSingleLineFinish_ = nil
			arg_576_1.state_ = "waiting"
		end

		function arg_576_1.playNext_(arg_578_0)
			if arg_578_0 == 1 then
				arg_576_0:Play102601140(arg_576_1)
			end
		end

		function arg_576_1.onSingleLineUpdate_(arg_579_0)
			local var_579_0 = 0.35

			if 0 < arg_576_1.time_ and arg_576_1.time_ <= 0 + arg_579_0 then
				arg_576_1.talkMaxDuration = 0
				arg_576_1.dialogCg_.alpha = 1

				arg_576_1.dialog_:SetActive(true)
				SetActive(arg_576_1.leftNameGo_, false)

				arg_576_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_576_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_576_1:RecordName(arg_576_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_576_1.iconTrs_.gameObject, false)
				arg_576_1.callingController_:SetSelectedState("normal")

				local var_579_1 = arg_576_1:FormatText(arg_576_1:GetWordFromCfg(102601139).content)

				arg_576_1.text_.text = var_579_1

				LuaForUtil.ClearLinePrefixSymbol(arg_576_1.text_)

				local var_579_3 = 14 <= 0 and var_579_0 or var_579_0 * (utf8.len(var_579_1) / 14)

				if (14 <= 0 and var_579_0 or var_579_0 * (utf8.len(var_579_1) / 14)) > 0 and var_579_0 < var_579_3 then
					arg_576_1.talkMaxDuration = var_579_3

					if var_579_3 + 0 > arg_576_1.duration_ then
						arg_576_1.duration_ = var_579_3 + 0
					end
				end

				arg_576_1.text_.text = var_579_1
				arg_576_1.typewritter.percent = 0

				arg_576_1.typewritter:SetDirty()
				arg_576_1:ShowNextGo(false)
				arg_576_1:RecordContent(arg_576_1.text_.text)
			end

			local var_579_4 = math.max(var_579_0, arg_576_1.talkMaxDuration)

			if 0 <= arg_576_1.time_ and arg_576_1.time_ < 0 + var_579_4 then
				arg_576_1.typewritter.percent = (arg_576_1.time_ - 0) / var_579_4

				arg_576_1.typewritter:SetDirty()
			end

			if arg_576_1.time_ >= 0 + var_579_4 and arg_576_1.time_ < 0 + var_579_4 + arg_579_0 then
				arg_576_1.typewritter.percent = 1

				arg_576_1.typewritter:SetDirty()
				arg_576_1:ShowNextGo(true)
			end
		end

		arg_576_1.nodeConfigList_ = {}

		arg_576_1:InitPlayNodeList()
	end,
	Play102601140 = function(arg_580_0, arg_580_1)
		arg_580_1.time_ = 0
		arg_580_1.frameCnt_ = 0
		arg_580_1.state_ = "playing"
		arg_580_1.curTalkId_ = 102601140
		arg_580_1.duration_ = 5

		SetActive(arg_580_1.tipsGo_, false)

		function arg_580_1.onSingleLineFinish_()
			arg_580_1.onSingleLineUpdate_ = nil
			arg_580_1.onSingleLineFinish_ = nil
			arg_580_1.state_ = "waiting"
		end

		function arg_580_1.playNext_(arg_582_0)
			if arg_582_0 == 1 then
				arg_580_0:Play102601141(arg_580_1)
			end
		end

		function arg_580_1.onSingleLineUpdate_(arg_583_0)
			local var_583_0 = 0.275

			if 0 < arg_580_1.time_ and arg_580_1.time_ <= 0 + arg_583_0 then
				arg_580_1.talkMaxDuration = 0
				arg_580_1.dialogCg_.alpha = 1

				arg_580_1.dialog_:SetActive(true)
				SetActive(arg_580_1.leftNameGo_, true)

				arg_580_1.leftNameTxt_.text = arg_580_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_580_1.leftNameTxt_.transform)

				arg_580_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_580_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_580_1:RecordName(arg_580_1.leftNameTxt_.text)
				SetActive(arg_580_1.iconTrs_.gameObject, true)
				arg_580_1.iconController_:SetSelectedState("hero")

				arg_580_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_580_1.callingController_:SetSelectedState("normal")

				arg_580_1.keyicon_.color = Color.New(1, 1, 1)
				arg_580_1.icon_.color = Color.New(1, 1, 1)

				local var_583_1 = arg_580_1:FormatText(arg_580_1:GetWordFromCfg(102601140).content)

				arg_580_1.text_.text = var_583_1

				LuaForUtil.ClearLinePrefixSymbol(arg_580_1.text_)

				local var_583_3 = 11 <= 0 and var_583_0 or var_583_0 * (utf8.len(var_583_1) / 11)

				if (11 <= 0 and var_583_0 or var_583_0 * (utf8.len(var_583_1) / 11)) > 0 and var_583_0 < var_583_3 then
					arg_580_1.talkMaxDuration = var_583_3

					if var_583_3 + 0 > arg_580_1.duration_ then
						arg_580_1.duration_ = var_583_3 + 0
					end
				end

				arg_580_1.text_.text = var_583_1
				arg_580_1.typewritter.percent = 0

				arg_580_1.typewritter:SetDirty()
				arg_580_1:ShowNextGo(false)
				arg_580_1:RecordContent(arg_580_1.text_.text)
			end

			local var_583_4 = math.max(var_583_0, arg_580_1.talkMaxDuration)

			if 0 <= arg_580_1.time_ and arg_580_1.time_ < 0 + var_583_4 then
				arg_580_1.typewritter.percent = (arg_580_1.time_ - 0) / var_583_4

				arg_580_1.typewritter:SetDirty()
			end

			if arg_580_1.time_ >= 0 + var_583_4 and arg_580_1.time_ < 0 + var_583_4 + arg_583_0 then
				arg_580_1.typewritter.percent = 1

				arg_580_1.typewritter:SetDirty()
				arg_580_1:ShowNextGo(true)
			end
		end

		arg_580_1.nodeConfigList_ = {}

		arg_580_1:InitPlayNodeList()
	end,
	Play102601141 = function(arg_584_0, arg_584_1)
		arg_584_1.time_ = 0
		arg_584_1.frameCnt_ = 0
		arg_584_1.state_ = "playing"
		arg_584_1.curTalkId_ = 102601141
		arg_584_1.duration_ = 6.7

		local var_584_0 = {
			ja = 6.7,
			ko = 4.433,
			zh = 4.7,
			en = 3.633
		}
		local var_584_1 = manager.audio:GetLocalizationFlag()

		if var_584_0[var_584_1] ~= nil then
			arg_584_1.duration_ = var_584_0[var_584_1]
		end

		SetActive(arg_584_1.tipsGo_, false)

		function arg_584_1.onSingleLineFinish_()
			arg_584_1.onSingleLineUpdate_ = nil
			arg_584_1.onSingleLineFinish_ = nil
			arg_584_1.state_ = "waiting"
		end

		function arg_584_1.playNext_(arg_586_0)
			if arg_586_0 == 1 then
				arg_584_0:Play102601142(arg_584_1)
			end
		end

		function arg_584_1.onSingleLineUpdate_(arg_587_0)
			if 0 < arg_584_1.time_ and arg_584_1.time_ <= 0 + arg_587_0 and not isNil(arg_584_1.actors_["1019ui_story"]) and arg_584_1.var_.characterEffect1019ui_story == nil then
				arg_584_1.var_.characterEffect1019ui_story = arg_584_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_587_0 = 0.2

			if 0 <= arg_584_1.time_ and arg_584_1.time_ < 0 + var_587_0 and not isNil(arg_584_1.actors_["1019ui_story"]) then
				if arg_584_1.var_.characterEffect1019ui_story and not isNil(arg_584_1.actors_["1019ui_story"]) then
					arg_584_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_584_1.time_ >= 0 + var_587_0 and arg_584_1.time_ < 0 + var_587_0 + arg_587_0 and not isNil(arg_584_1.actors_["1019ui_story"]) and arg_584_1.var_.characterEffect1019ui_story then
				arg_584_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			if 0 < arg_584_1.time_ and arg_584_1.time_ <= 0 + arg_587_0 then
				arg_584_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_587_2 = 0
			local var_587_3 = 0.525

			if 0 < arg_584_1.time_ and arg_584_1.time_ <= var_587_2 + arg_587_0 then
				arg_584_1.talkMaxDuration = 0
				arg_584_1.dialogCg_.alpha = 1

				arg_584_1.dialog_:SetActive(true)
				SetActive(arg_584_1.leftNameGo_, true)

				arg_584_1.leftNameTxt_.text = arg_584_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_584_1.leftNameTxt_.transform)

				arg_584_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_584_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_584_1:RecordName(arg_584_1.leftNameTxt_.text)
				SetActive(arg_584_1.iconTrs_.gameObject, false)
				arg_584_1.callingController_:SetSelectedState("normal")

				local var_587_4 = arg_584_1:GetWordFromCfg(102601141)
				local var_587_5 = arg_584_1:FormatText(var_587_4.content)

				arg_584_1.text_.text = var_587_5

				LuaForUtil.ClearLinePrefixSymbol(arg_584_1.text_)

				local var_587_7 = 21 <= 0 and var_587_3 or var_587_3 * (utf8.len(var_587_5) / 21)

				if (21 <= 0 and var_587_3 or var_587_3 * (utf8.len(var_587_5) / 21)) > 0 and var_587_3 < var_587_7 then
					arg_584_1.talkMaxDuration = var_587_7

					if var_587_7 + var_587_2 > arg_584_1.duration_ then
						arg_584_1.duration_ = var_587_7 + var_587_2
					end
				end

				arg_584_1.text_.text = var_587_5
				arg_584_1.typewritter.percent = 0

				arg_584_1.typewritter:SetDirty()
				arg_584_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_102601", "102601141", "story_v_side_old_102601.awb") ~= 0 then
					local var_587_8 = manager.audio:GetVoiceLength("story_v_side_old_102601", "102601141", "story_v_side_old_102601.awb") / 1000

					if var_587_8 + var_587_2 > arg_584_1.duration_ then
						arg_584_1.duration_ = var_587_8 + var_587_2
					end

					if var_587_4.prefab_name ~= "" and arg_584_1.actors_[var_587_4.prefab_name] ~= nil then
						local var_587_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_584_1.actors_[var_587_4.prefab_name].transform, "story_v_side_old_102601", "102601141", "story_v_side_old_102601.awb")

						arg_584_1:RecordAudio("102601141", var_587_9)
						arg_584_1:RecordAudio("102601141", var_587_9)
					else
						arg_584_1:AudioAction("play", "voice", "story_v_side_old_102601", "102601141", "story_v_side_old_102601.awb")
					end

					arg_584_1:RecordHistoryTalkVoice("story_v_side_old_102601", "102601141", "story_v_side_old_102601.awb")
				end

				arg_584_1:RecordContent(arg_584_1.text_.text)
			end

			local var_587_10 = math.max(var_587_3, arg_584_1.talkMaxDuration)

			if var_587_2 <= arg_584_1.time_ and arg_584_1.time_ < var_587_2 + var_587_10 then
				arg_584_1.typewritter.percent = (arg_584_1.time_ - var_587_2) / var_587_10

				arg_584_1.typewritter:SetDirty()
			end

			if arg_584_1.time_ >= var_587_2 + var_587_10 and arg_584_1.time_ < var_587_2 + var_587_10 + arg_587_0 then
				arg_584_1.typewritter.percent = 1

				arg_584_1.typewritter:SetDirty()
				arg_584_1:ShowNextGo(true)
			end
		end

		arg_584_1.nodeConfigList_ = {}

		arg_584_1:InitPlayNodeList()
	end,
	Play102601142 = function(arg_588_0, arg_588_1)
		arg_588_1.time_ = 0
		arg_588_1.frameCnt_ = 0
		arg_588_1.state_ = "playing"
		arg_588_1.curTalkId_ = 102601142
		arg_588_1.duration_ = 5

		SetActive(arg_588_1.tipsGo_, false)

		function arg_588_1.onSingleLineFinish_()
			arg_588_1.onSingleLineUpdate_ = nil
			arg_588_1.onSingleLineFinish_ = nil
			arg_588_1.state_ = "waiting"
		end

		function arg_588_1.playNext_(arg_590_0)
			if arg_590_0 == 1 then
				arg_588_0:Play102601143(arg_588_1)
			end
		end

		function arg_588_1.onSingleLineUpdate_(arg_591_0)
			if 0 < arg_588_1.time_ and arg_588_1.time_ <= 0 + arg_591_0 and not isNil(arg_588_1.actors_["1019ui_story"]) and arg_588_1.var_.characterEffect1019ui_story == nil then
				arg_588_1.var_.characterEffect1019ui_story = arg_588_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_591_0 = 0.2

			if 0 <= arg_588_1.time_ and arg_588_1.time_ < 0 + var_591_0 and not isNil(arg_588_1.actors_["1019ui_story"]) then
				if arg_588_1.var_.characterEffect1019ui_story and not isNil(arg_588_1.actors_["1019ui_story"]) then
					arg_588_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_588_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_588_1.time_ - 0) / var_591_0)
				end
			end

			if arg_588_1.time_ >= 0 + var_591_0 and arg_588_1.time_ < 0 + var_591_0 + arg_591_0 and not isNil(arg_588_1.actors_["1019ui_story"]) and arg_588_1.var_.characterEffect1019ui_story then
				arg_588_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_588_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_591_1 = 0
			local var_591_2 = 0.025

			if 0 < arg_588_1.time_ and arg_588_1.time_ <= var_591_1 + arg_591_0 then
				arg_588_1.talkMaxDuration = 0
				arg_588_1.dialogCg_.alpha = 1

				arg_588_1.dialog_:SetActive(true)
				SetActive(arg_588_1.leftNameGo_, true)

				arg_588_1.leftNameTxt_.text = arg_588_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_588_1.leftNameTxt_.transform)

				arg_588_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_588_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_588_1:RecordName(arg_588_1.leftNameTxt_.text)
				SetActive(arg_588_1.iconTrs_.gameObject, true)
				arg_588_1.iconController_:SetSelectedState("hero")

				arg_588_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_588_1.callingController_:SetSelectedState("normal")

				arg_588_1.keyicon_.color = Color.New(1, 1, 1)
				arg_588_1.icon_.color = Color.New(1, 1, 1)

				local var_591_3 = arg_588_1:FormatText(arg_588_1:GetWordFromCfg(102601142).content)

				arg_588_1.text_.text = var_591_3

				LuaForUtil.ClearLinePrefixSymbol(arg_588_1.text_)

				local var_591_5 = 1 <= 0 and var_591_2 or var_591_2 * (utf8.len(var_591_3) / 1)

				if (1 <= 0 and var_591_2 or var_591_2 * (utf8.len(var_591_3) / 1)) > 0 and var_591_2 < var_591_5 then
					arg_588_1.talkMaxDuration = var_591_5

					if var_591_5 + var_591_1 > arg_588_1.duration_ then
						arg_588_1.duration_ = var_591_5 + var_591_1
					end
				end

				arg_588_1.text_.text = var_591_3
				arg_588_1.typewritter.percent = 0

				arg_588_1.typewritter:SetDirty()
				arg_588_1:ShowNextGo(false)
				arg_588_1:RecordContent(arg_588_1.text_.text)
			end

			local var_591_6 = math.max(var_591_2, arg_588_1.talkMaxDuration)

			if var_591_1 <= arg_588_1.time_ and arg_588_1.time_ < var_591_1 + var_591_6 then
				arg_588_1.typewritter.percent = (arg_588_1.time_ - var_591_1) / var_591_6

				arg_588_1.typewritter:SetDirty()
			end

			if arg_588_1.time_ >= var_591_1 + var_591_6 and arg_588_1.time_ < var_591_1 + var_591_6 + arg_591_0 then
				arg_588_1.typewritter.percent = 1

				arg_588_1.typewritter:SetDirty()
				arg_588_1:ShowNextGo(true)
			end
		end

		arg_588_1.nodeConfigList_ = {}

		arg_588_1:InitPlayNodeList()
	end,
	Play102601143 = function(arg_592_0, arg_592_1)
		arg_592_1.time_ = 0
		arg_592_1.frameCnt_ = 0
		arg_592_1.state_ = "playing"
		arg_592_1.curTalkId_ = 102601143
		arg_592_1.duration_ = 5

		SetActive(arg_592_1.tipsGo_, false)

		function arg_592_1.onSingleLineFinish_()
			arg_592_1.onSingleLineUpdate_ = nil
			arg_592_1.onSingleLineFinish_ = nil
			arg_592_1.state_ = "waiting"
		end

		function arg_592_1.playNext_(arg_594_0)
			if arg_594_0 == 1 then
				arg_592_0:Play102601144(arg_592_1)
			end
		end

		function arg_592_1.onSingleLineUpdate_(arg_595_0)
			local var_595_0 = 0.05

			if 0 < arg_592_1.time_ and arg_592_1.time_ <= 0 + arg_595_0 then
				arg_592_1.talkMaxDuration = 0
				arg_592_1.dialogCg_.alpha = 1

				arg_592_1.dialog_:SetActive(true)
				SetActive(arg_592_1.leftNameGo_, true)

				arg_592_1.leftNameTxt_.text = arg_592_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_592_1.leftNameTxt_.transform)

				arg_592_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_592_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_592_1:RecordName(arg_592_1.leftNameTxt_.text)
				SetActive(arg_592_1.iconTrs_.gameObject, true)
				arg_592_1.iconController_:SetSelectedState("hero")

				arg_592_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_592_1.callingController_:SetSelectedState("normal")

				arg_592_1.keyicon_.color = Color.New(1, 1, 1)
				arg_592_1.icon_.color = Color.New(1, 1, 1)

				local var_595_1 = arg_592_1:FormatText(arg_592_1:GetWordFromCfg(102601143).content)

				arg_592_1.text_.text = var_595_1

				LuaForUtil.ClearLinePrefixSymbol(arg_592_1.text_)

				local var_595_3 = 2 <= 0 and var_595_0 or var_595_0 * (utf8.len(var_595_1) / 2)

				if (2 <= 0 and var_595_0 or var_595_0 * (utf8.len(var_595_1) / 2)) > 0 and var_595_0 < var_595_3 then
					arg_592_1.talkMaxDuration = var_595_3

					if var_595_3 + 0 > arg_592_1.duration_ then
						arg_592_1.duration_ = var_595_3 + 0
					end
				end

				arg_592_1.text_.text = var_595_1
				arg_592_1.typewritter.percent = 0

				arg_592_1.typewritter:SetDirty()
				arg_592_1:ShowNextGo(false)
				arg_592_1:RecordContent(arg_592_1.text_.text)
			end

			local var_595_4 = math.max(var_595_0, arg_592_1.talkMaxDuration)

			if 0 <= arg_592_1.time_ and arg_592_1.time_ < 0 + var_595_4 then
				arg_592_1.typewritter.percent = (arg_592_1.time_ - 0) / var_595_4

				arg_592_1.typewritter:SetDirty()
			end

			if arg_592_1.time_ >= 0 + var_595_4 and arg_592_1.time_ < 0 + var_595_4 + arg_595_0 then
				arg_592_1.typewritter.percent = 1

				arg_592_1.typewritter:SetDirty()
				arg_592_1:ShowNextGo(true)
			end
		end

		arg_592_1.nodeConfigList_ = {}

		arg_592_1:InitPlayNodeList()
	end,
	Play102601144 = function(arg_596_0, arg_596_1)
		arg_596_1.time_ = 0
		arg_596_1.frameCnt_ = 0
		arg_596_1.state_ = "playing"
		arg_596_1.curTalkId_ = 102601144
		arg_596_1.duration_ = 5

		SetActive(arg_596_1.tipsGo_, false)

		function arg_596_1.onSingleLineFinish_()
			arg_596_1.onSingleLineUpdate_ = nil
			arg_596_1.onSingleLineFinish_ = nil
			arg_596_1.state_ = "waiting"
		end

		function arg_596_1.playNext_(arg_598_0)
			if arg_598_0 == 1 then
				arg_596_0:Play102601145(arg_596_1)
			end
		end

		function arg_596_1.onSingleLineUpdate_(arg_599_0)
			local var_599_0 = 0.575

			if 0 < arg_596_1.time_ and arg_596_1.time_ <= 0 + arg_599_0 then
				arg_596_1.talkMaxDuration = 0
				arg_596_1.dialogCg_.alpha = 1

				arg_596_1.dialog_:SetActive(true)
				SetActive(arg_596_1.leftNameGo_, false)

				arg_596_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_596_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_596_1:RecordName(arg_596_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_596_1.iconTrs_.gameObject, false)
				arg_596_1.callingController_:SetSelectedState("normal")

				local var_599_1 = arg_596_1:FormatText(arg_596_1:GetWordFromCfg(102601144).content)

				arg_596_1.text_.text = var_599_1

				LuaForUtil.ClearLinePrefixSymbol(arg_596_1.text_)

				local var_599_3 = 23 <= 0 and var_599_0 or var_599_0 * (utf8.len(var_599_1) / 23)

				if (23 <= 0 and var_599_0 or var_599_0 * (utf8.len(var_599_1) / 23)) > 0 and var_599_0 < var_599_3 then
					arg_596_1.talkMaxDuration = var_599_3

					if var_599_3 + 0 > arg_596_1.duration_ then
						arg_596_1.duration_ = var_599_3 + 0
					end
				end

				arg_596_1.text_.text = var_599_1
				arg_596_1.typewritter.percent = 0

				arg_596_1.typewritter:SetDirty()
				arg_596_1:ShowNextGo(false)
				arg_596_1:RecordContent(arg_596_1.text_.text)
			end

			local var_599_4 = math.max(var_599_0, arg_596_1.talkMaxDuration)

			if 0 <= arg_596_1.time_ and arg_596_1.time_ < 0 + var_599_4 then
				arg_596_1.typewritter.percent = (arg_596_1.time_ - 0) / var_599_4

				arg_596_1.typewritter:SetDirty()
			end

			if arg_596_1.time_ >= 0 + var_599_4 and arg_596_1.time_ < 0 + var_599_4 + arg_599_0 then
				arg_596_1.typewritter.percent = 1

				arg_596_1.typewritter:SetDirty()
				arg_596_1:ShowNextGo(true)
			end
		end

		arg_596_1.nodeConfigList_ = {}

		arg_596_1:InitPlayNodeList()
	end,
	Play102601145 = function(arg_600_0, arg_600_1)
		arg_600_1.time_ = 0
		arg_600_1.frameCnt_ = 0
		arg_600_1.state_ = "playing"
		arg_600_1.curTalkId_ = 102601145
		arg_600_1.duration_ = 5

		SetActive(arg_600_1.tipsGo_, false)

		function arg_600_1.onSingleLineFinish_()
			arg_600_1.onSingleLineUpdate_ = nil
			arg_600_1.onSingleLineFinish_ = nil
			arg_600_1.state_ = "waiting"
		end

		function arg_600_1.playNext_(arg_602_0)
			if arg_602_0 == 1 then
				arg_600_0:Play102601146(arg_600_1)
			end
		end

		function arg_600_1.onSingleLineUpdate_(arg_603_0)
			local var_603_0 = 0.55

			if 0 < arg_600_1.time_ and arg_600_1.time_ <= 0 + arg_603_0 then
				arg_600_1.talkMaxDuration = 0
				arg_600_1.dialogCg_.alpha = 1

				arg_600_1.dialog_:SetActive(true)
				SetActive(arg_600_1.leftNameGo_, false)

				arg_600_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_600_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_600_1:RecordName(arg_600_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_600_1.iconTrs_.gameObject, false)
				arg_600_1.callingController_:SetSelectedState("normal")

				local var_603_1 = arg_600_1:FormatText(arg_600_1:GetWordFromCfg(102601145).content)

				arg_600_1.text_.text = var_603_1

				LuaForUtil.ClearLinePrefixSymbol(arg_600_1.text_)

				local var_603_3 = 22 <= 0 and var_603_0 or var_603_0 * (utf8.len(var_603_1) / 22)

				if (22 <= 0 and var_603_0 or var_603_0 * (utf8.len(var_603_1) / 22)) > 0 and var_603_0 < var_603_3 then
					arg_600_1.talkMaxDuration = var_603_3

					if var_603_3 + 0 > arg_600_1.duration_ then
						arg_600_1.duration_ = var_603_3 + 0
					end
				end

				arg_600_1.text_.text = var_603_1
				arg_600_1.typewritter.percent = 0

				arg_600_1.typewritter:SetDirty()
				arg_600_1:ShowNextGo(false)
				arg_600_1:RecordContent(arg_600_1.text_.text)
			end

			local var_603_4 = math.max(var_603_0, arg_600_1.talkMaxDuration)

			if 0 <= arg_600_1.time_ and arg_600_1.time_ < 0 + var_603_4 then
				arg_600_1.typewritter.percent = (arg_600_1.time_ - 0) / var_603_4

				arg_600_1.typewritter:SetDirty()
			end

			if arg_600_1.time_ >= 0 + var_603_4 and arg_600_1.time_ < 0 + var_603_4 + arg_603_0 then
				arg_600_1.typewritter.percent = 1

				arg_600_1.typewritter:SetDirty()
				arg_600_1:ShowNextGo(true)
			end
		end

		arg_600_1.nodeConfigList_ = {}

		arg_600_1:InitPlayNodeList()
	end,
	Play102601146 = function(arg_604_0, arg_604_1)
		arg_604_1.time_ = 0
		arg_604_1.frameCnt_ = 0
		arg_604_1.state_ = "playing"
		arg_604_1.curTalkId_ = 102601146
		arg_604_1.duration_ = 2

		SetActive(arg_604_1.tipsGo_, false)

		function arg_604_1.onSingleLineFinish_()
			arg_604_1.onSingleLineUpdate_ = nil
			arg_604_1.onSingleLineFinish_ = nil
			arg_604_1.state_ = "waiting"
		end

		function arg_604_1.playNext_(arg_606_0)
			if arg_606_0 == 1 then
				arg_604_0:Play102601147(arg_604_1)
			end
		end

		function arg_604_1.onSingleLineUpdate_(arg_607_0)
			if 0 < arg_604_1.time_ and arg_604_1.time_ <= 0 + arg_607_0 and not isNil(arg_604_1.actors_["1019ui_story"]) and arg_604_1.var_.characterEffect1019ui_story == nil then
				arg_604_1.var_.characterEffect1019ui_story = arg_604_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_607_0 = 0.2

			if 0 <= arg_604_1.time_ and arg_604_1.time_ < 0 + var_607_0 and not isNil(arg_604_1.actors_["1019ui_story"]) then
				if arg_604_1.var_.characterEffect1019ui_story and not isNil(arg_604_1.actors_["1019ui_story"]) then
					arg_604_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_604_1.time_ >= 0 + var_607_0 and arg_604_1.time_ < 0 + var_607_0 + arg_607_0 and not isNil(arg_604_1.actors_["1019ui_story"]) and arg_604_1.var_.characterEffect1019ui_story then
				arg_604_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			if 0 < arg_604_1.time_ and arg_604_1.time_ <= 0 + arg_607_0 then
				arg_604_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action5_2")
			end

			if 0 < arg_604_1.time_ and arg_604_1.time_ <= 0 + arg_607_0 then
				arg_604_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_607_2 = 0
			local var_607_3 = 0.1

			if 0 < arg_604_1.time_ and arg_604_1.time_ <= var_607_2 + arg_607_0 then
				arg_604_1.talkMaxDuration = 0
				arg_604_1.dialogCg_.alpha = 1

				arg_604_1.dialog_:SetActive(true)
				SetActive(arg_604_1.leftNameGo_, true)

				arg_604_1.leftNameTxt_.text = arg_604_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_604_1.leftNameTxt_.transform)

				arg_604_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_604_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_604_1:RecordName(arg_604_1.leftNameTxt_.text)
				SetActive(arg_604_1.iconTrs_.gameObject, false)
				arg_604_1.callingController_:SetSelectedState("normal")

				local var_607_4 = arg_604_1:GetWordFromCfg(102601146)
				local var_607_5 = arg_604_1:FormatText(var_607_4.content)

				arg_604_1.text_.text = var_607_5

				LuaForUtil.ClearLinePrefixSymbol(arg_604_1.text_)

				local var_607_7 = 4 <= 0 and var_607_3 or var_607_3 * (utf8.len(var_607_5) / 4)

				if (4 <= 0 and var_607_3 or var_607_3 * (utf8.len(var_607_5) / 4)) > 0 and var_607_3 < var_607_7 then
					arg_604_1.talkMaxDuration = var_607_7

					if var_607_7 + var_607_2 > arg_604_1.duration_ then
						arg_604_1.duration_ = var_607_7 + var_607_2
					end
				end

				arg_604_1.text_.text = var_607_5
				arg_604_1.typewritter.percent = 0

				arg_604_1.typewritter:SetDirty()
				arg_604_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_102601", "102601146", "story_v_side_old_102601.awb") ~= 0 then
					local var_607_8 = manager.audio:GetVoiceLength("story_v_side_old_102601", "102601146", "story_v_side_old_102601.awb") / 1000

					if var_607_8 + var_607_2 > arg_604_1.duration_ then
						arg_604_1.duration_ = var_607_8 + var_607_2
					end

					if var_607_4.prefab_name ~= "" and arg_604_1.actors_[var_607_4.prefab_name] ~= nil then
						local var_607_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_604_1.actors_[var_607_4.prefab_name].transform, "story_v_side_old_102601", "102601146", "story_v_side_old_102601.awb")

						arg_604_1:RecordAudio("102601146", var_607_9)
						arg_604_1:RecordAudio("102601146", var_607_9)
					else
						arg_604_1:AudioAction("play", "voice", "story_v_side_old_102601", "102601146", "story_v_side_old_102601.awb")
					end

					arg_604_1:RecordHistoryTalkVoice("story_v_side_old_102601", "102601146", "story_v_side_old_102601.awb")
				end

				arg_604_1:RecordContent(arg_604_1.text_.text)
			end

			local var_607_10 = math.max(var_607_3, arg_604_1.talkMaxDuration)

			if var_607_2 <= arg_604_1.time_ and arg_604_1.time_ < var_607_2 + var_607_10 then
				arg_604_1.typewritter.percent = (arg_604_1.time_ - var_607_2) / var_607_10

				arg_604_1.typewritter:SetDirty()
			end

			if arg_604_1.time_ >= var_607_2 + var_607_10 and arg_604_1.time_ < var_607_2 + var_607_10 + arg_607_0 then
				arg_604_1.typewritter.percent = 1

				arg_604_1.typewritter:SetDirty()
				arg_604_1:ShowNextGo(true)
			end
		end

		arg_604_1.nodeConfigList_ = {}

		arg_604_1:InitPlayNodeList()
	end,
	Play102601147 = function(arg_608_0, arg_608_1)
		arg_608_1.time_ = 0
		arg_608_1.frameCnt_ = 0
		arg_608_1.state_ = "playing"
		arg_608_1.curTalkId_ = 102601147
		arg_608_1.duration_ = 4.9

		local var_608_0 = {
			ja = 4.9,
			ko = 3.833,
			zh = 3.766,
			en = 3.833
		}
		local var_608_1 = manager.audio:GetLocalizationFlag()

		if var_608_0[var_608_1] ~= nil then
			arg_608_1.duration_ = var_608_0[var_608_1]
		end

		SetActive(arg_608_1.tipsGo_, false)

		function arg_608_1.onSingleLineFinish_()
			arg_608_1.onSingleLineUpdate_ = nil
			arg_608_1.onSingleLineFinish_ = nil
			arg_608_1.state_ = "waiting"
		end

		function arg_608_1.playNext_(arg_610_0)
			if arg_610_0 == 1 then
				arg_608_0:Play102601148(arg_608_1)
			end
		end

		function arg_608_1.onSingleLineUpdate_(arg_611_0)
			if 0 < arg_608_1.time_ and arg_608_1.time_ <= 0 + arg_611_0 then
				arg_608_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_611_0 = 0
			local var_611_1 = 0.475

			if 0 < arg_608_1.time_ and arg_608_1.time_ <= var_611_0 + arg_611_0 then
				arg_608_1.talkMaxDuration = 0
				arg_608_1.dialogCg_.alpha = 1

				arg_608_1.dialog_:SetActive(true)
				SetActive(arg_608_1.leftNameGo_, true)

				arg_608_1.leftNameTxt_.text = arg_608_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_608_1.leftNameTxt_.transform)

				arg_608_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_608_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_608_1:RecordName(arg_608_1.leftNameTxt_.text)
				SetActive(arg_608_1.iconTrs_.gameObject, false)
				arg_608_1.callingController_:SetSelectedState("normal")

				local var_611_2 = arg_608_1:GetWordFromCfg(102601147)
				local var_611_3 = arg_608_1:FormatText(var_611_2.content)

				arg_608_1.text_.text = var_611_3

				LuaForUtil.ClearLinePrefixSymbol(arg_608_1.text_)

				local var_611_5 = 19 <= 0 and var_611_1 or var_611_1 * (utf8.len(var_611_3) / 19)

				if (19 <= 0 and var_611_1 or var_611_1 * (utf8.len(var_611_3) / 19)) > 0 and var_611_1 < var_611_5 then
					arg_608_1.talkMaxDuration = var_611_5

					if var_611_5 + var_611_0 > arg_608_1.duration_ then
						arg_608_1.duration_ = var_611_5 + var_611_0
					end
				end

				arg_608_1.text_.text = var_611_3
				arg_608_1.typewritter.percent = 0

				arg_608_1.typewritter:SetDirty()
				arg_608_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_102601", "102601147", "story_v_side_old_102601.awb") ~= 0 then
					local var_611_6 = manager.audio:GetVoiceLength("story_v_side_old_102601", "102601147", "story_v_side_old_102601.awb") / 1000

					if var_611_6 + var_611_0 > arg_608_1.duration_ then
						arg_608_1.duration_ = var_611_6 + var_611_0
					end

					if var_611_2.prefab_name ~= "" and arg_608_1.actors_[var_611_2.prefab_name] ~= nil then
						local var_611_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_608_1.actors_[var_611_2.prefab_name].transform, "story_v_side_old_102601", "102601147", "story_v_side_old_102601.awb")

						arg_608_1:RecordAudio("102601147", var_611_7)
						arg_608_1:RecordAudio("102601147", var_611_7)
					else
						arg_608_1:AudioAction("play", "voice", "story_v_side_old_102601", "102601147", "story_v_side_old_102601.awb")
					end

					arg_608_1:RecordHistoryTalkVoice("story_v_side_old_102601", "102601147", "story_v_side_old_102601.awb")
				end

				arg_608_1:RecordContent(arg_608_1.text_.text)
			end

			local var_611_8 = math.max(var_611_1, arg_608_1.talkMaxDuration)

			if var_611_0 <= arg_608_1.time_ and arg_608_1.time_ < var_611_0 + var_611_8 then
				arg_608_1.typewritter.percent = (arg_608_1.time_ - var_611_0) / var_611_8

				arg_608_1.typewritter:SetDirty()
			end

			if arg_608_1.time_ >= var_611_0 + var_611_8 and arg_608_1.time_ < var_611_0 + var_611_8 + arg_611_0 then
				arg_608_1.typewritter.percent = 1

				arg_608_1.typewritter:SetDirty()
				arg_608_1:ShowNextGo(true)
			end
		end

		arg_608_1.nodeConfigList_ = {}

		arg_608_1:InitPlayNodeList()
	end,
	Play102601148 = function(arg_612_0, arg_612_1)
		arg_612_1.time_ = 0
		arg_612_1.frameCnt_ = 0
		arg_612_1.state_ = "playing"
		arg_612_1.curTalkId_ = 102601148
		arg_612_1.duration_ = 5

		SetActive(arg_612_1.tipsGo_, false)

		function arg_612_1.onSingleLineFinish_()
			arg_612_1.onSingleLineUpdate_ = nil
			arg_612_1.onSingleLineFinish_ = nil
			arg_612_1.state_ = "waiting"
			arg_612_1.auto_ = false
		end

		function arg_612_1.playNext_(arg_614_0)
			arg_612_1.onStoryFinished_()
		end

		function arg_612_1.onSingleLineUpdate_(arg_615_0)
			if 0 < arg_612_1.time_ and arg_612_1.time_ <= 0 + arg_615_0 and not isNil(arg_612_1.actors_["1019ui_story"]) and arg_612_1.var_.characterEffect1019ui_story == nil then
				arg_612_1.var_.characterEffect1019ui_story = arg_612_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_615_0 = 0.2

			if 0 <= arg_612_1.time_ and arg_612_1.time_ < 0 + var_615_0 and not isNil(arg_612_1.actors_["1019ui_story"]) then
				if arg_612_1.var_.characterEffect1019ui_story and not isNil(arg_612_1.actors_["1019ui_story"]) then
					arg_612_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_612_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_612_1.time_ - 0) / var_615_0)
				end
			end

			if arg_612_1.time_ >= 0 + var_615_0 and arg_612_1.time_ < 0 + var_615_0 + arg_615_0 and not isNil(arg_612_1.actors_["1019ui_story"]) and arg_612_1.var_.characterEffect1019ui_story then
				arg_612_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_612_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_615_1 = 0
			local var_615_2 = 0.225

			if 0 < arg_612_1.time_ and arg_612_1.time_ <= var_615_1 + arg_615_0 then
				arg_612_1.talkMaxDuration = 0
				arg_612_1.dialogCg_.alpha = 1

				arg_612_1.dialog_:SetActive(true)
				SetActive(arg_612_1.leftNameGo_, true)

				arg_612_1.leftNameTxt_.text = arg_612_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_612_1.leftNameTxt_.transform)

				arg_612_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_612_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_612_1:RecordName(arg_612_1.leftNameTxt_.text)
				SetActive(arg_612_1.iconTrs_.gameObject, true)
				arg_612_1.iconController_:SetSelectedState("hero")

				arg_612_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_612_1.callingController_:SetSelectedState("normal")

				arg_612_1.keyicon_.color = Color.New(1, 1, 1)
				arg_612_1.icon_.color = Color.New(1, 1, 1)

				local var_615_3 = arg_612_1:FormatText(arg_612_1:GetWordFromCfg(102601148).content)

				arg_612_1.text_.text = var_615_3

				LuaForUtil.ClearLinePrefixSymbol(arg_612_1.text_)

				local var_615_5 = 9 <= 0 and var_615_2 or var_615_2 * (utf8.len(var_615_3) / 9)

				if (9 <= 0 and var_615_2 or var_615_2 * (utf8.len(var_615_3) / 9)) > 0 and var_615_2 < var_615_5 then
					arg_612_1.talkMaxDuration = var_615_5

					if var_615_5 + var_615_1 > arg_612_1.duration_ then
						arg_612_1.duration_ = var_615_5 + var_615_1
					end
				end

				arg_612_1.text_.text = var_615_3
				arg_612_1.typewritter.percent = 0

				arg_612_1.typewritter:SetDirty()
				arg_612_1:ShowNextGo(false)
				arg_612_1:RecordContent(arg_612_1.text_.text)
			end

			local var_615_6 = math.max(var_615_2, arg_612_1.talkMaxDuration)

			if var_615_1 <= arg_612_1.time_ and arg_612_1.time_ < var_615_1 + var_615_6 then
				arg_612_1.typewritter.percent = (arg_612_1.time_ - var_615_1) / var_615_6

				arg_612_1.typewritter:SetDirty()
			end

			if arg_612_1.time_ >= var_615_1 + var_615_6 and arg_612_1.time_ < var_615_1 + var_615_6 + arg_615_0 then
				arg_612_1.typewritter.percent = 1

				arg_612_1.typewritter:SetDirty()
				arg_612_1:ShowNextGo(true)
			end
		end

		arg_612_1.nodeConfigList_ = {}

		arg_612_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST04a",
		"TextureConfig/Background/ST04b",
		"TextureConfig/Background/ST13",
		"TextureConfig/Background/ST13a",
		"TextureConfig/Background/ST03",
		"TextureConfig/Background/ST03a"
	},
	voices = {
		"story_v_side_old_102601.awb"
	}
}
