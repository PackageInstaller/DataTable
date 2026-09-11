return {
	Play116292001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 116292001
		arg_1_1.duration_ = 4.83

		local var_1_0 = {
			zh = 4.833,
			ja = 4.466
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
				arg_1_0:Play116292002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.B13c == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "B13c")
				var_4_0.name = "B13c"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.B13c = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.B13c

				arg_1_1.bgs_.B13c.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "B13c" then
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

			if 0.266666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 0.266666666666667 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_story_v0_battleground", "bgm_story_v0_battleground", "bgm_story_v0_battleground.awb")

				local var_4_13 = manager.audio:GetAudioName("bgm_story_v0_battleground", "bgm_story_v0_battleground")

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

			local var_4_14 = 2
			local var_4_15 = 0.35

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_14 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0
				arg_1_1.dialogCg_.alpha = 1

				arg_1_1.dialog_:SetActive(true)
				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1148")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_16 = arg_1_1:GetWordFromCfg(116292001)
				local var_4_17 = arg_1_1:FormatText(var_4_16.content)

				arg_1_1.text_.text = var_4_17

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_19 = 14 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_17) / 14)

				if (14 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_17) / 14)) > 0 and var_4_15 < var_4_19 then
					arg_1_1.talkMaxDuration = var_4_19

					if var_4_19 + var_4_14 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_19 + var_4_14
					end
				end

				arg_1_1.text_.text = var_4_17
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116292", "116292001", "story_v_out_116292.awb") ~= 0 then
					local var_4_20 = manager.audio:GetVoiceLength("story_v_out_116292", "116292001", "story_v_out_116292.awb") / 1000

					if var_4_20 + var_4_14 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_20 + var_4_14
					end

					if var_4_16.prefab_name ~= "" and arg_1_1.actors_[var_4_16.prefab_name] ~= nil then
						local var_4_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_16.prefab_name].transform, "story_v_out_116292", "116292001", "story_v_out_116292.awb")

						arg_1_1:RecordAudio("116292001", var_4_21)
						arg_1_1:RecordAudio("116292001", var_4_21)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_116292", "116292001", "story_v_out_116292.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_116292", "116292001", "story_v_out_116292.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_22 = math.max(var_4_15, arg_1_1.talkMaxDuration)

			if var_4_14 <= arg_1_1.time_ and arg_1_1.time_ < var_4_14 + var_4_22 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_14) / var_4_22

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_14 + var_4_22 and arg_1_1.time_ < var_4_14 + var_4_22 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play116292002 = function(arg_7_0, arg_7_1)
		arg_7_1.time_ = 0
		arg_7_1.frameCnt_ = 0
		arg_7_1.state_ = "playing"
		arg_7_1.curTalkId_ = 116292002
		arg_7_1.duration_ = 2

		SetActive(arg_7_1.tipsGo_, false)

		function arg_7_1.onSingleLineFinish_()
			arg_7_1.onSingleLineUpdate_ = nil
			arg_7_1.onSingleLineFinish_ = nil
			arg_7_1.state_ = "waiting"
		end

		function arg_7_1.playNext_(arg_9_0)
			if arg_9_0 == 1 then
				arg_7_0:Play116292003(arg_7_1)
			end
		end

		function arg_7_1.onSingleLineUpdate_(arg_10_0)
			if arg_7_1.actors_["1059ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1059ui_story"))) then
				local var_10_0 = Object.Instantiate(Asset.Load("Char/" .. "1059ui_story"), arg_7_1.stage_.transform)

				var_10_0.name = "1059ui_story"
				var_10_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_7_1.actors_["1059ui_story"] = var_10_0

				local var_10_1 = var_10_0:GetComponentInChildren(typeof(CharacterEffect))

				var_10_1.enabled = true

				local var_10_2 = GameObjectTools.GetOrAddComponent(var_10_0, typeof(DynamicBoneHelper))

				if var_10_2 then
					var_10_2:EnableDynamicBone(false)
				end

				arg_7_1:ShowWeapon(var_10_1.transform, false)

				arg_7_1.var_["1059ui_story" .. "Animator"] = var_10_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_7_1.var_["1059ui_story" .. "Animator"].applyRootMotion = true
				arg_7_1.var_["1059ui_story" .. "LipSync"] = var_10_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_10_3 = arg_7_1.actors_["1059ui_story"]

			if 0 < arg_7_1.time_ and arg_7_1.time_ <= 0 + arg_10_0 and not isNil(var_10_3) and arg_7_1.var_.characterEffect1059ui_story == nil then
				arg_7_1.var_.characterEffect1059ui_story = var_10_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_10_4 = 0.2

			if 0 <= arg_7_1.time_ and arg_7_1.time_ < 0 + var_10_4 and not isNil(var_10_3) then
				if arg_7_1.var_.characterEffect1059ui_story and not isNil(var_10_3) then
					arg_7_1.var_.characterEffect1059ui_story.fillFlat = false
				end
			end

			if arg_7_1.time_ >= 0 + var_10_4 and arg_7_1.time_ < 0 + var_10_4 + arg_10_0 and not isNil(var_10_3) and arg_7_1.var_.characterEffect1059ui_story then
				arg_7_1.var_.characterEffect1059ui_story.fillFlat = false
			end

			local var_10_6 = "1148ui_story"

			if arg_7_1.actors_["1148ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1148ui_story"))) then
				local var_10_7 = Object.Instantiate(Asset.Load("Char/" .. "1148ui_story"), arg_7_1.stage_.transform)

				var_10_7.name = var_10_6
				var_10_7.transform.localPosition = Vector3.New(0, 100, 0)
				arg_7_1.actors_[var_10_6] = var_10_7

				local var_10_8 = var_10_7:GetComponentInChildren(typeof(CharacterEffect))

				var_10_8.enabled = true

				local var_10_9 = GameObjectTools.GetOrAddComponent(var_10_7, typeof(DynamicBoneHelper))

				if var_10_9 then
					var_10_9:EnableDynamicBone(false)
				end

				arg_7_1:ShowWeapon(var_10_8.transform, false)

				arg_7_1.var_[var_10_6 .. "Animator"] = var_10_8.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_7_1.var_[var_10_6 .. "Animator"].applyRootMotion = true
				arg_7_1.var_[var_10_6 .. "LipSync"] = var_10_8.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_10_10 = arg_7_1.actors_["1148ui_story"]

			if 0 < arg_7_1.time_ and arg_7_1.time_ <= 0 + arg_10_0 and not isNil(var_10_10) and arg_7_1.var_.characterEffect1148ui_story == nil then
				arg_7_1.var_.characterEffect1148ui_story = var_10_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_10_11 = 0.2

			if 0 <= arg_7_1.time_ and arg_7_1.time_ < 0 + var_10_11 and not isNil(var_10_10) then
				if arg_7_1.var_.characterEffect1148ui_story and not isNil(var_10_10) then
					arg_7_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_7_1.var_.characterEffect1148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_7_1.time_ - 0) / var_10_11)
				end
			end

			if arg_7_1.time_ >= 0 + var_10_11 and arg_7_1.time_ < 0 + var_10_11 + arg_10_0 and not isNil(var_10_10) and arg_7_1.var_.characterEffect1148ui_story then
				arg_7_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_7_1.var_.characterEffect1148ui_story.fillRatio = 0.5
			end

			local var_10_12 = arg_7_1.actors_["1059ui_story"].transform

			if 0 < arg_7_1.time_ and arg_7_1.time_ <= 0 + arg_10_0 then
				arg_7_1.var_.moveOldPos1059ui_story = var_10_12.localPosition
			end

			local var_10_13 = 0.001

			if 0 <= arg_7_1.time_ and arg_7_1.time_ < 0 + var_10_13 then
				var_10_12.localPosition = Vector3.Lerp(arg_7_1.var_.moveOldPos1059ui_story, Vector3.New(0, -1.05, -6), (arg_7_1.time_ - 0) / var_10_13)
				var_10_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_10_12.position).x, (manager.ui.mainCamera.transform.position - var_10_12.position).y, (manager.ui.mainCamera.transform.position - var_10_12.position).z)
				var_10_12.localEulerAngles.z = 0
				var_10_12.localEulerAngles.x = 0
				var_10_12.localEulerAngles = var_10_12.localEulerAngles
			end

			if arg_7_1.time_ >= 0 + var_10_13 and arg_7_1.time_ < 0 + var_10_13 + arg_10_0 then
				var_10_12.localPosition = Vector3.New(0, -1.05, -6)
				var_10_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_10_12.position).x, (manager.ui.mainCamera.transform.position - var_10_12.position).y, (manager.ui.mainCamera.transform.position - var_10_12.position).z)
				var_10_12.localEulerAngles.z = 0
				var_10_12.localEulerAngles.x = 0
				var_10_12.localEulerAngles = var_10_12.localEulerAngles
			end

			if 0 < arg_7_1.time_ and arg_7_1.time_ <= 0 + arg_10_0 then
				arg_7_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/story1059/story1059action/1059action1_1")
			end

			if 0 < arg_7_1.time_ and arg_7_1.time_ <= 0 + arg_10_0 then
				arg_7_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_10_14 = 0
			local var_10_15 = 0.125

			if 0 < arg_7_1.time_ and arg_7_1.time_ <= var_10_14 + arg_10_0 then
				arg_7_1.talkMaxDuration = 0
				arg_7_1.dialogCg_.alpha = 1

				arg_7_1.dialog_:SetActive(true)
				SetActive(arg_7_1.leftNameGo_, true)

				arg_7_1.leftNameTxt_.text = arg_7_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_7_1.leftNameTxt_.transform)

				arg_7_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_7_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_7_1:RecordName(arg_7_1.leftNameTxt_.text)
				SetActive(arg_7_1.iconTrs_.gameObject, false)
				arg_7_1.callingController_:SetSelectedState("normal")

				local var_10_16 = arg_7_1:GetWordFromCfg(116292002)
				local var_10_17 = arg_7_1:FormatText(var_10_16.content)

				arg_7_1.text_.text = var_10_17

				LuaForUtil.ClearLinePrefixSymbol(arg_7_1.text_)

				local var_10_19 = 5 <= 0 and var_10_15 or var_10_15 * (utf8.len(var_10_17) / 5)

				if (5 <= 0 and var_10_15 or var_10_15 * (utf8.len(var_10_17) / 5)) > 0 and var_10_15 < var_10_19 then
					arg_7_1.talkMaxDuration = var_10_19

					if var_10_19 + var_10_14 > arg_7_1.duration_ then
						arg_7_1.duration_ = var_10_19 + var_10_14
					end
				end

				arg_7_1.text_.text = var_10_17
				arg_7_1.typewritter.percent = 0

				arg_7_1.typewritter:SetDirty()
				arg_7_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116292", "116292002", "story_v_out_116292.awb") ~= 0 then
					local var_10_20 = manager.audio:GetVoiceLength("story_v_out_116292", "116292002", "story_v_out_116292.awb") / 1000

					if var_10_20 + var_10_14 > arg_7_1.duration_ then
						arg_7_1.duration_ = var_10_20 + var_10_14
					end

					if var_10_16.prefab_name ~= "" and arg_7_1.actors_[var_10_16.prefab_name] ~= nil then
						local var_10_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_7_1.actors_[var_10_16.prefab_name].transform, "story_v_out_116292", "116292002", "story_v_out_116292.awb")

						arg_7_1:RecordAudio("116292002", var_10_21)
						arg_7_1:RecordAudio("116292002", var_10_21)
					else
						arg_7_1:AudioAction("play", "voice", "story_v_out_116292", "116292002", "story_v_out_116292.awb")
					end

					arg_7_1:RecordHistoryTalkVoice("story_v_out_116292", "116292002", "story_v_out_116292.awb")
				end

				arg_7_1:RecordContent(arg_7_1.text_.text)
			end

			local var_10_22 = math.max(var_10_15, arg_7_1.talkMaxDuration)

			if var_10_14 <= arg_7_1.time_ and arg_7_1.time_ < var_10_14 + var_10_22 then
				arg_7_1.typewritter.percent = (arg_7_1.time_ - var_10_14) / var_10_22

				arg_7_1.typewritter:SetDirty()
			end

			if arg_7_1.time_ >= var_10_14 + var_10_22 and arg_7_1.time_ < var_10_14 + var_10_22 + arg_10_0 then
				arg_7_1.typewritter.percent = 1

				arg_7_1.typewritter:SetDirty()
				arg_7_1:ShowNextGo(true)
			end
		end

		arg_7_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1059ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_7_1:InitPlayNodeList()
	end,
	Play116292003 = function(arg_11_0, arg_11_1)
		arg_11_1.time_ = 0
		arg_11_1.frameCnt_ = 0
		arg_11_1.state_ = "playing"
		arg_11_1.curTalkId_ = 116292003
		arg_11_1.duration_ = 5

		SetActive(arg_11_1.tipsGo_, false)

		function arg_11_1.onSingleLineFinish_()
			arg_11_1.onSingleLineUpdate_ = nil
			arg_11_1.onSingleLineFinish_ = nil
			arg_11_1.state_ = "waiting"
		end

		function arg_11_1.playNext_(arg_13_0)
			if arg_13_0 == 1 then
				arg_11_0:Play116292004(arg_11_1)
			end
		end

		function arg_11_1.onSingleLineUpdate_(arg_14_0)
			if 0 < arg_11_1.time_ and arg_11_1.time_ <= 0 + arg_14_0 then
				arg_11_1.var_.moveOldPos1148ui_story = arg_11_1.actors_["1148ui_story"].transform.localPosition
			end

			local var_14_0 = 0.001

			if 0 <= arg_11_1.time_ and arg_11_1.time_ < 0 + var_14_0 then
				arg_11_1.actors_["1148ui_story"].transform.localPosition = Vector3.Lerp(arg_11_1.var_.moveOldPos1148ui_story, Vector3.New(0, 100, 0), (arg_11_1.time_ - 0) / var_14_0)
				arg_11_1.actors_["1148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_11_1.actors_["1148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_11_1.actors_["1148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_11_1.actors_["1148ui_story"].transform.position).z)
				arg_11_1.actors_["1148ui_story"].transform.localEulerAngles.z = 0
				arg_11_1.actors_["1148ui_story"].transform.localEulerAngles.x = 0
				arg_11_1.actors_["1148ui_story"].transform.localEulerAngles = arg_11_1.actors_["1148ui_story"].transform.localEulerAngles
			end

			if arg_11_1.time_ >= 0 + var_14_0 and arg_11_1.time_ < 0 + var_14_0 + arg_14_0 then
				arg_11_1.actors_["1148ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_11_1.actors_["1148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_11_1.actors_["1148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_11_1.actors_["1148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_11_1.actors_["1148ui_story"].transform.position).z)
				arg_11_1.actors_["1148ui_story"].transform.localEulerAngles.z = 0
				arg_11_1.actors_["1148ui_story"].transform.localEulerAngles.x = 0
				arg_11_1.actors_["1148ui_story"].transform.localEulerAngles = arg_11_1.actors_["1148ui_story"].transform.localEulerAngles
			end

			local var_14_1 = arg_11_1.actors_["1059ui_story"].transform

			if 0 < arg_11_1.time_ and arg_11_1.time_ <= 0 + arg_14_0 then
				arg_11_1.var_.moveOldPos1059ui_story = var_14_1.localPosition
			end

			local var_14_2 = 0.001

			if 0 <= arg_11_1.time_ and arg_11_1.time_ < 0 + var_14_2 then
				var_14_1.localPosition = Vector3.Lerp(arg_11_1.var_.moveOldPos1059ui_story, Vector3.New(0, 100, 0), (arg_11_1.time_ - 0) / var_14_2)
				var_14_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_14_1.position).x, (manager.ui.mainCamera.transform.position - var_14_1.position).y, (manager.ui.mainCamera.transform.position - var_14_1.position).z)
				var_14_1.localEulerAngles.z = 0
				var_14_1.localEulerAngles.x = 0
				var_14_1.localEulerAngles = var_14_1.localEulerAngles
			end

			if arg_11_1.time_ >= 0 + var_14_2 and arg_11_1.time_ < 0 + var_14_2 + arg_14_0 then
				var_14_1.localPosition = Vector3.New(0, 100, 0)
				var_14_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_14_1.position).x, (manager.ui.mainCamera.transform.position - var_14_1.position).y, (manager.ui.mainCamera.transform.position - var_14_1.position).z)
				var_14_1.localEulerAngles.z = 0
				var_14_1.localEulerAngles.x = 0
				var_14_1.localEulerAngles = var_14_1.localEulerAngles
			end

			local var_14_3 = 0
			local var_14_4 = 1.375

			if 0 < arg_11_1.time_ and arg_11_1.time_ <= var_14_3 + arg_14_0 then
				arg_11_1.talkMaxDuration = 0
				arg_11_1.dialogCg_.alpha = 1

				arg_11_1.dialog_:SetActive(true)
				SetActive(arg_11_1.leftNameGo_, false)

				arg_11_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_11_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_11_1:RecordName(arg_11_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_11_1.iconTrs_.gameObject, false)
				arg_11_1.callingController_:SetSelectedState("normal")

				local var_14_5 = arg_11_1:FormatText(arg_11_1:GetWordFromCfg(116292003).content)

				arg_11_1.text_.text = var_14_5

				LuaForUtil.ClearLinePrefixSymbol(arg_11_1.text_)

				local var_14_7 = 55 <= 0 and var_14_4 or var_14_4 * (utf8.len(var_14_5) / 55)

				if (55 <= 0 and var_14_4 or var_14_4 * (utf8.len(var_14_5) / 55)) > 0 and var_14_4 < var_14_7 then
					arg_11_1.talkMaxDuration = var_14_7

					if var_14_7 + var_14_3 > arg_11_1.duration_ then
						arg_11_1.duration_ = var_14_7 + var_14_3
					end
				end

				arg_11_1.text_.text = var_14_5
				arg_11_1.typewritter.percent = 0

				arg_11_1.typewritter:SetDirty()
				arg_11_1:ShowNextGo(false)
				arg_11_1:RecordContent(arg_11_1.text_.text)
			end

			local var_14_8 = math.max(var_14_4, arg_11_1.talkMaxDuration)

			if var_14_3 <= arg_11_1.time_ and arg_11_1.time_ < var_14_3 + var_14_8 then
				arg_11_1.typewritter.percent = (arg_11_1.time_ - var_14_3) / var_14_8

				arg_11_1.typewritter:SetDirty()
			end

			if arg_11_1.time_ >= var_14_3 + var_14_8 and arg_11_1.time_ < var_14_3 + var_14_8 + arg_14_0 then
				arg_11_1.typewritter.percent = 1

				arg_11_1.typewritter:SetDirty()
				arg_11_1:ShowNextGo(true)
			end
		end

		arg_11_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1059ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_11_1:InitPlayNodeList()
	end,
	Play116292004 = function(arg_15_0, arg_15_1)
		arg_15_1.time_ = 0
		arg_15_1.frameCnt_ = 0
		arg_15_1.state_ = "playing"
		arg_15_1.curTalkId_ = 116292004
		arg_15_1.duration_ = 4.73

		local var_15_0 = {
			zh = 4.733,
			ja = 4.266
		}
		local var_15_1 = manager.audio:GetLocalizationFlag()

		if var_15_0[var_15_1] ~= nil then
			arg_15_1.duration_ = var_15_0[var_15_1]
		end

		SetActive(arg_15_1.tipsGo_, false)

		function arg_15_1.onSingleLineFinish_()
			arg_15_1.onSingleLineUpdate_ = nil
			arg_15_1.onSingleLineFinish_ = nil
			arg_15_1.state_ = "waiting"
		end

		function arg_15_1.playNext_(arg_17_0)
			if arg_17_0 == 1 then
				arg_15_0:Play116292005(arg_15_1)
			end
		end

		function arg_15_1.onSingleLineUpdate_(arg_18_0)
			local var_18_0 = 0.55

			if 0 < arg_15_1.time_ and arg_15_1.time_ <= 0 + arg_18_0 then
				arg_15_1.talkMaxDuration = 0
				arg_15_1.dialogCg_.alpha = 1

				arg_15_1.dialog_:SetActive(true)
				SetActive(arg_15_1.leftNameGo_, true)

				arg_15_1.leftNameTxt_.text = arg_15_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_15_1.leftNameTxt_.transform)

				arg_15_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_15_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_15_1:RecordName(arg_15_1.leftNameTxt_.text)
				SetActive(arg_15_1.iconTrs_.gameObject, true)
				arg_15_1.iconController_:SetSelectedState("hero")

				arg_15_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1059")

				arg_15_1.callingController_:SetSelectedState("normal")

				arg_15_1.keyicon_.color = Color.New(1, 1, 1)
				arg_15_1.icon_.color = Color.New(1, 1, 1)

				local var_18_1 = arg_15_1:GetWordFromCfg(116292004)
				local var_18_2 = arg_15_1:FormatText(var_18_1.content)

				arg_15_1.text_.text = var_18_2

				LuaForUtil.ClearLinePrefixSymbol(arg_15_1.text_)

				local var_18_4 = 22 <= 0 and var_18_0 or var_18_0 * (utf8.len(var_18_2) / 22)

				if (22 <= 0 and var_18_0 or var_18_0 * (utf8.len(var_18_2) / 22)) > 0 and var_18_0 < var_18_4 then
					arg_15_1.talkMaxDuration = var_18_4

					if var_18_4 + 0 > arg_15_1.duration_ then
						arg_15_1.duration_ = var_18_4 + 0
					end
				end

				arg_15_1.text_.text = var_18_2
				arg_15_1.typewritter.percent = 0

				arg_15_1.typewritter:SetDirty()
				arg_15_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116292", "116292004", "story_v_out_116292.awb") ~= 0 then
					local var_18_5 = manager.audio:GetVoiceLength("story_v_out_116292", "116292004", "story_v_out_116292.awb") / 1000

					if var_18_5 + 0 > arg_15_1.duration_ then
						arg_15_1.duration_ = var_18_5 + 0
					end

					if var_18_1.prefab_name ~= "" and arg_15_1.actors_[var_18_1.prefab_name] ~= nil then
						local var_18_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_15_1.actors_[var_18_1.prefab_name].transform, "story_v_out_116292", "116292004", "story_v_out_116292.awb")

						arg_15_1:RecordAudio("116292004", var_18_6)
						arg_15_1:RecordAudio("116292004", var_18_6)
					else
						arg_15_1:AudioAction("play", "voice", "story_v_out_116292", "116292004", "story_v_out_116292.awb")
					end

					arg_15_1:RecordHistoryTalkVoice("story_v_out_116292", "116292004", "story_v_out_116292.awb")
				end

				arg_15_1:RecordContent(arg_15_1.text_.text)
			end

			local var_18_7 = math.max(var_18_0, arg_15_1.talkMaxDuration)

			if 0 <= arg_15_1.time_ and arg_15_1.time_ < 0 + var_18_7 then
				arg_15_1.typewritter.percent = (arg_15_1.time_ - 0) / var_18_7

				arg_15_1.typewritter:SetDirty()
			end

			if arg_15_1.time_ >= 0 + var_18_7 and arg_15_1.time_ < 0 + var_18_7 + arg_18_0 then
				arg_15_1.typewritter.percent = 1

				arg_15_1.typewritter:SetDirty()
				arg_15_1:ShowNextGo(true)
			end
		end

		arg_15_1.nodeConfigList_ = {}

		arg_15_1:InitPlayNodeList()
	end,
	Play116292005 = function(arg_19_0, arg_19_1)
		arg_19_1.time_ = 0
		arg_19_1.frameCnt_ = 0
		arg_19_1.state_ = "playing"
		arg_19_1.curTalkId_ = 116292005
		arg_19_1.duration_ = 7

		SetActive(arg_19_1.tipsGo_, false)

		function arg_19_1.onSingleLineFinish_()
			arg_19_1.onSingleLineUpdate_ = nil
			arg_19_1.onSingleLineFinish_ = nil
			arg_19_1.state_ = "waiting"
		end

		function arg_19_1.playNext_(arg_21_0)
			if arg_21_0 == 1 then
				arg_19_0:Play116292006(arg_19_1)
			end
		end

		function arg_19_1.onSingleLineUpdate_(arg_22_0)
			if 0 < arg_19_1.time_ and arg_19_1.time_ <= 0 + arg_22_0 then
				arg_19_1.var_.moveOldPos1059ui_story = arg_19_1.actors_["1059ui_story"].transform.localPosition
			end

			local var_22_0 = 0.001

			if 0 <= arg_19_1.time_ and arg_19_1.time_ < 0 + var_22_0 then
				arg_19_1.actors_["1059ui_story"].transform.localPosition = Vector3.Lerp(arg_19_1.var_.moveOldPos1059ui_story, Vector3.New(0, 100, 0), (arg_19_1.time_ - 0) / var_22_0)
				arg_19_1.actors_["1059ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_19_1.actors_["1059ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_19_1.actors_["1059ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_19_1.actors_["1059ui_story"].transform.position).z)
				arg_19_1.actors_["1059ui_story"].transform.localEulerAngles.z = 0
				arg_19_1.actors_["1059ui_story"].transform.localEulerAngles.x = 0
				arg_19_1.actors_["1059ui_story"].transform.localEulerAngles = arg_19_1.actors_["1059ui_story"].transform.localEulerAngles
			end

			if arg_19_1.time_ >= 0 + var_22_0 and arg_19_1.time_ < 0 + var_22_0 + arg_22_0 then
				arg_19_1.actors_["1059ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_19_1.actors_["1059ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_19_1.actors_["1059ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_19_1.actors_["1059ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_19_1.actors_["1059ui_story"].transform.position).z)
				arg_19_1.actors_["1059ui_story"].transform.localEulerAngles.z = 0
				arg_19_1.actors_["1059ui_story"].transform.localEulerAngles.x = 0
				arg_19_1.actors_["1059ui_story"].transform.localEulerAngles = arg_19_1.actors_["1059ui_story"].transform.localEulerAngles
			end

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= 0 + arg_22_0 then
				arg_19_1:AudioAction("play", "effect", "se_story_16", "se_story_16_archery", "")
			end

			local var_22_2 = 0

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= var_22_2 + arg_22_0 then
				arg_19_1.mask_.enabled = true
				arg_19_1.mask_.raycastTarget = true

				arg_19_1:SetGaussion(false)
			end

			local var_22_3 = 2

			if var_22_2 <= arg_19_1.time_ and arg_19_1.time_ < var_22_2 + var_22_3 then
				local var_22_4 = Color.New(1, 1, 1)

				var_22_4.a = Mathf.Lerp(1, 0, (arg_19_1.time_ - var_22_2) / var_22_3)
				arg_19_1.mask_.color = var_22_4
			end

			if arg_19_1.time_ >= var_22_2 + var_22_3 and arg_19_1.time_ < var_22_2 + var_22_3 + arg_22_0 then
				local var_22_5 = Color.New(1, 1, 1)

				arg_19_1.mask_.enabled = false
				var_22_5.a = 0
				arg_19_1.mask_.color = var_22_5
			end

			local var_22_6 = manager.ui.mainCamera.transform

			if 1 < arg_19_1.time_ and arg_19_1.time_ <= 1 + arg_22_0 then
				arg_19_1.var_.shakeOldPos = var_22_6.localPosition
			end

			local var_22_7 = 1

			if 1 <= arg_19_1.time_ and arg_19_1.time_ < 1 + var_22_7 then
				local var_22_8, var_22_9 = math.modf((arg_19_1.time_ - 1) / 0.066)

				var_22_6.localPosition = Vector3.New(var_22_9 * 0.13, var_22_9 * 0.13, var_22_9 * 0.13) + arg_19_1.var_.shakeOldPos
			end

			if arg_19_1.time_ >= 1 + var_22_7 and arg_19_1.time_ < 1 + var_22_7 + arg_22_0 then
				var_22_6.localPosition = arg_19_1.var_.shakeOldPos
			end

			if arg_19_1.frameCnt_ <= 1 then
				arg_19_1.dialog_:SetActive(false)
			end

			local var_22_10 = 1.999999999999
			local var_22_11 = 1.65

			if 1.999999999999 < arg_19_1.time_ and arg_19_1.time_ <= var_22_10 + arg_22_0 then
				arg_19_1.talkMaxDuration = 0

				arg_19_1.dialog_:SetActive(true)

				arg_19_1.dialogCg_.alpha = 0

				local var_22_12 = LeanTween.value(arg_19_1.dialog_, 0, 1, 0.3)

				var_22_12:setOnUpdate(LuaHelper.FloatAction(function(arg_23_0)
					arg_19_1.dialogCg_.alpha = arg_23_0
				end))
				var_22_12:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_19_1.dialog_)
					var_22_12:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_19_1.duration_ = arg_19_1.duration_ + 0.3

				SetActive(arg_19_1.leftNameGo_, false)

				arg_19_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_19_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_19_1:RecordName(arg_19_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_19_1.iconTrs_.gameObject, false)
				arg_19_1.callingController_:SetSelectedState("normal")

				local var_22_13 = arg_19_1:FormatText(arg_19_1:GetWordFromCfg(116292005).content)

				arg_19_1.text_.text = var_22_13

				LuaForUtil.ClearLinePrefixSymbol(arg_19_1.text_)

				local var_22_15 = 66 <= 0 and var_22_11 or var_22_11 * (utf8.len(var_22_13) / 66)

				if (66 <= 0 and var_22_11 or var_22_11 * (utf8.len(var_22_13) / 66)) > 0 and var_22_11 < var_22_15 then
					arg_19_1.talkMaxDuration = var_22_15
					var_22_10 = var_22_10 + 0.3

					if var_22_15 + var_22_10 > arg_19_1.duration_ then
						arg_19_1.duration_ = var_22_15 + var_22_10
					end
				end

				arg_19_1.text_.text = var_22_13
				arg_19_1.typewritter.percent = 0

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(false)
				arg_19_1:RecordContent(arg_19_1.text_.text)
			end

			local var_22_16 = var_22_10 + 0.3
			local var_22_17 = math.max(var_22_11, arg_19_1.talkMaxDuration)

			if var_22_10 + 0.3 <= arg_19_1.time_ and arg_19_1.time_ < var_22_16 + var_22_17 then
				arg_19_1.typewritter.percent = (arg_19_1.time_ - var_22_16) / var_22_17

				arg_19_1.typewritter:SetDirty()
			end

			if arg_19_1.time_ >= var_22_16 + var_22_17 and arg_19_1.time_ < var_22_16 + var_22_17 + arg_22_0 then
				arg_19_1.typewritter.percent = 1

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(true)
			end
		end

		arg_19_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1059ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_19_1:InitPlayNodeList()
	end,
	Play116292006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 116292006
		arg_25_1.duration_ = 5

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play116292007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = 0.1

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

				local var_28_1 = arg_25_1:FormatText(arg_25_1:GetWordFromCfg(116292006).content)

				arg_25_1.text_.text = var_28_1

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_3 = 4 <= 0 and var_28_0 or var_28_0 * (utf8.len(var_28_1) / 4)

				if (4 <= 0 and var_28_0 or var_28_0 * (utf8.len(var_28_1) / 4)) > 0 and var_28_0 < var_28_3 then
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
	Play116292007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 116292007
		arg_29_1.duration_ = 5

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play116292008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = 1

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, false)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_1 = arg_29_1:FormatText(arg_29_1:GetWordFromCfg(116292007).content)

				arg_29_1.text_.text = var_32_1

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_3 = 40 <= 0 and var_32_0 or var_32_0 * (utf8.len(var_32_1) / 40)

				if (40 <= 0 and var_32_0 or var_32_0 * (utf8.len(var_32_1) / 40)) > 0 and var_32_0 < var_32_3 then
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
	Play116292008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 116292008
		arg_33_1.duration_ = 5

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play116292009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = 0.05

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
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

				local var_36_1 = arg_33_1:FormatText(arg_33_1:GetWordFromCfg(116292008).content)

				arg_33_1.text_.text = var_36_1

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_3 = 2 <= 0 and var_36_0 or var_36_0 * (utf8.len(var_36_1) / 2)

				if (2 <= 0 and var_36_0 or var_36_0 * (utf8.len(var_36_1) / 2)) > 0 and var_36_0 < var_36_3 then
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
	Play116292009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 116292009
		arg_37_1.duration_ = 5.17

		local var_37_0 = {
			zh = 3.266,
			ja = 5.166
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
				arg_37_0:Play116292010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			if arg_37_1.actors_["1184ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1184ui_story"))) then
				local var_40_0 = Object.Instantiate(Asset.Load("Char/" .. "1184ui_story"), arg_37_1.stage_.transform)

				var_40_0.name = "1184ui_story"
				var_40_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_37_1.actors_["1184ui_story"] = var_40_0

				local var_40_1 = var_40_0:GetComponentInChildren(typeof(CharacterEffect))

				var_40_1.enabled = true

				local var_40_2 = GameObjectTools.GetOrAddComponent(var_40_0, typeof(DynamicBoneHelper))

				if var_40_2 then
					var_40_2:EnableDynamicBone(false)
				end

				arg_37_1:ShowWeapon(var_40_1.transform, false)

				arg_37_1.var_["1184ui_story" .. "Animator"] = var_40_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_37_1.var_["1184ui_story" .. "Animator"].applyRootMotion = true
				arg_37_1.var_["1184ui_story" .. "LipSync"] = var_40_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_40_3 = arg_37_1.actors_["1184ui_story"].transform

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1.var_.moveOldPos1184ui_story = var_40_3.localPosition
			end

			local var_40_4 = 0.001

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_4 then
				var_40_3.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos1184ui_story, Vector3.New(-0.7, -0.97, -6), (arg_37_1.time_ - 0) / var_40_4)
				var_40_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_40_3.position).x, (manager.ui.mainCamera.transform.position - var_40_3.position).y, (manager.ui.mainCamera.transform.position - var_40_3.position).z)
				var_40_3.localEulerAngles.z = 0
				var_40_3.localEulerAngles.x = 0
				var_40_3.localEulerAngles = var_40_3.localEulerAngles
			end

			if arg_37_1.time_ >= 0 + var_40_4 and arg_37_1.time_ < 0 + var_40_4 + arg_40_0 then
				var_40_3.localPosition = Vector3.New(-0.7, -0.97, -6)
				var_40_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_40_3.position).x, (manager.ui.mainCamera.transform.position - var_40_3.position).y, (manager.ui.mainCamera.transform.position - var_40_3.position).z)
				var_40_3.localEulerAngles.z = 0
				var_40_3.localEulerAngles.x = 0
				var_40_3.localEulerAngles = var_40_3.localEulerAngles
			end

			local var_40_5 = arg_37_1.actors_["1059ui_story"].transform

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1.var_.moveOldPos1059ui_story = var_40_5.localPosition
			end

			local var_40_6 = 0.001

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_6 then
				var_40_5.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos1059ui_story, Vector3.New(0.7, -1.05, -6), (arg_37_1.time_ - 0) / var_40_6)
				var_40_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_40_5.position).x, (manager.ui.mainCamera.transform.position - var_40_5.position).y, (manager.ui.mainCamera.transform.position - var_40_5.position).z)
				var_40_5.localEulerAngles.z = 0
				var_40_5.localEulerAngles.x = 0
				var_40_5.localEulerAngles = var_40_5.localEulerAngles
			end

			if arg_37_1.time_ >= 0 + var_40_6 and arg_37_1.time_ < 0 + var_40_6 + arg_40_0 then
				var_40_5.localPosition = Vector3.New(0.7, -1.05, -6)
				var_40_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_40_5.position).x, (manager.ui.mainCamera.transform.position - var_40_5.position).y, (manager.ui.mainCamera.transform.position - var_40_5.position).z)
				var_40_5.localEulerAngles.z = 0
				var_40_5.localEulerAngles.x = 0
				var_40_5.localEulerAngles = var_40_5.localEulerAngles
			end

			local var_40_7 = arg_37_1.actors_["1059ui_story"]

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(var_40_7) and arg_37_1.var_.characterEffect1059ui_story == nil then
				arg_37_1.var_.characterEffect1059ui_story = var_40_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_8 = 0.034

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_8 and not isNil(var_40_7) then
				if arg_37_1.var_.characterEffect1059ui_story and not isNil(var_40_7) then
					arg_37_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_37_1.var_.characterEffect1059ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_37_1.time_ - 0) / var_40_8)
				end
			end

			if arg_37_1.time_ >= 0 + var_40_8 and arg_37_1.time_ < 0 + var_40_8 + arg_40_0 and not isNil(var_40_7) and arg_37_1.var_.characterEffect1059ui_story then
				arg_37_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_37_1.var_.characterEffect1059ui_story.fillRatio = 0.5
			end

			local var_40_9 = arg_37_1.actors_["1184ui_story"]

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(var_40_9) and arg_37_1.var_.characterEffect1184ui_story == nil then
				arg_37_1.var_.characterEffect1184ui_story = var_40_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_10 = 0.2

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_10 and not isNil(var_40_9) then
				if arg_37_1.var_.characterEffect1184ui_story and not isNil(var_40_9) then
					arg_37_1.var_.characterEffect1184ui_story.fillFlat = false
				end
			end

			if arg_37_1.time_ >= 0 + var_40_10 and arg_37_1.time_ < 0 + var_40_10 + arg_40_0 and not isNil(var_40_9) and arg_37_1.var_.characterEffect1184ui_story then
				arg_37_1.var_.characterEffect1184ui_story.fillFlat = false
			end

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action4_1")
			end

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/story1059/story1059action/1059action1_1")
			end

			local var_40_12 = 0
			local var_40_13 = 0.375

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_12 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				arg_37_1.leftNameTxt_.text = arg_37_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_14 = arg_37_1:GetWordFromCfg(116292009)
				local var_40_15 = arg_37_1:FormatText(var_40_14.content)

				arg_37_1.text_.text = var_40_15

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_17 = 15 <= 0 and var_40_13 or var_40_13 * (utf8.len(var_40_15) / 15)

				if (15 <= 0 and var_40_13 or var_40_13 * (utf8.len(var_40_15) / 15)) > 0 and var_40_13 < var_40_17 then
					arg_37_1.talkMaxDuration = var_40_17

					if var_40_17 + var_40_12 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_17 + var_40_12
					end
				end

				arg_37_1.text_.text = var_40_15
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116292", "116292009", "story_v_out_116292.awb") ~= 0 then
					local var_40_18 = manager.audio:GetVoiceLength("story_v_out_116292", "116292009", "story_v_out_116292.awb") / 1000

					if var_40_18 + var_40_12 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_18 + var_40_12
					end

					if var_40_14.prefab_name ~= "" and arg_37_1.actors_[var_40_14.prefab_name] ~= nil then
						local var_40_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_14.prefab_name].transform, "story_v_out_116292", "116292009", "story_v_out_116292.awb")

						arg_37_1:RecordAudio("116292009", var_40_19)
						arg_37_1:RecordAudio("116292009", var_40_19)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_116292", "116292009", "story_v_out_116292.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_116292", "116292009", "story_v_out_116292.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_20 = math.max(var_40_13, arg_37_1.talkMaxDuration)

			if var_40_12 <= arg_37_1.time_ and arg_37_1.time_ < var_40_12 + var_40_20 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_12) / var_40_20

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_12 + var_40_20 and arg_37_1.time_ < var_40_12 + var_40_20 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1184ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1059ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_37_1:InitPlayNodeList()
	end,
	Play116292010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 116292010
		arg_41_1.duration_ = 3.07

		local var_41_0 = {
			zh = 2.433333333332,
			ja = 3.066
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
				arg_41_0:Play116292011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(arg_41_1.actors_["1059ui_story"]) and arg_41_1.var_.characterEffect1059ui_story == nil then
				arg_41_1.var_.characterEffect1059ui_story = arg_41_1.actors_["1059ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_0 = 0.2

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_0 and not isNil(arg_41_1.actors_["1059ui_story"]) then
				if arg_41_1.var_.characterEffect1059ui_story and not isNil(arg_41_1.actors_["1059ui_story"]) then
					arg_41_1.var_.characterEffect1059ui_story.fillFlat = false
				end
			end

			if arg_41_1.time_ >= 0 + var_44_0 and arg_41_1.time_ < 0 + var_44_0 + arg_44_0 and not isNil(arg_41_1.actors_["1059ui_story"]) and arg_41_1.var_.characterEffect1059ui_story then
				arg_41_1.var_.characterEffect1059ui_story.fillFlat = false
			end

			local var_44_2 = arg_41_1.actors_["1184ui_story"]

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(var_44_2) and arg_41_1.var_.characterEffect1184ui_story == nil then
				arg_41_1.var_.characterEffect1184ui_story = var_44_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_3 = 0.2

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_3 and not isNil(var_44_2) then
				if arg_41_1.var_.characterEffect1184ui_story and not isNil(var_44_2) then
					arg_41_1.var_.characterEffect1184ui_story.fillFlat = true
					arg_41_1.var_.characterEffect1184ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_41_1.time_ - 0) / var_44_3)
				end
			end

			if arg_41_1.time_ >= 0 + var_44_3 and arg_41_1.time_ < 0 + var_44_3 + arg_44_0 and not isNil(var_44_2) and arg_41_1.var_.characterEffect1184ui_story then
				arg_41_1.var_.characterEffect1184ui_story.fillFlat = true
				arg_41_1.var_.characterEffect1184ui_story.fillRatio = 0.5
			end

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/story1059/story1059action/1059action3_1")
			end

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0202cva")
			end

			local var_44_4 = 0
			local var_44_5 = 0.2

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_4 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				arg_41_1.leftNameTxt_.text = arg_41_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_6 = arg_41_1:GetWordFromCfg(116292010)
				local var_44_7 = arg_41_1:FormatText(var_44_6.content)

				arg_41_1.text_.text = var_44_7

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_9 = 8 <= 0 and var_44_5 or var_44_5 * (utf8.len(var_44_7) / 8)

				if (8 <= 0 and var_44_5 or var_44_5 * (utf8.len(var_44_7) / 8)) > 0 and var_44_5 < var_44_9 then
					arg_41_1.talkMaxDuration = var_44_9

					if var_44_9 + var_44_4 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_9 + var_44_4
					end
				end

				arg_41_1.text_.text = var_44_7
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116292", "116292010", "story_v_out_116292.awb") ~= 0 then
					local var_44_10 = manager.audio:GetVoiceLength("story_v_out_116292", "116292010", "story_v_out_116292.awb") / 1000

					if var_44_10 + var_44_4 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_10 + var_44_4
					end

					if var_44_6.prefab_name ~= "" and arg_41_1.actors_[var_44_6.prefab_name] ~= nil then
						local var_44_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_6.prefab_name].transform, "story_v_out_116292", "116292010", "story_v_out_116292.awb")

						arg_41_1:RecordAudio("116292010", var_44_11)
						arg_41_1:RecordAudio("116292010", var_44_11)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_116292", "116292010", "story_v_out_116292.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_116292", "116292010", "story_v_out_116292.awb")
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
	Play116292011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 116292011
		arg_45_1.duration_ = 5

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play116292012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1.var_.moveOldPos1184ui_story = arg_45_1.actors_["1184ui_story"].transform.localPosition
			end

			local var_48_0 = 0.001

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_0 then
				arg_45_1.actors_["1184ui_story"].transform.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos1184ui_story, Vector3.New(0, 100, 0), (arg_45_1.time_ - 0) / var_48_0)
				arg_45_1.actors_["1184ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_45_1.actors_["1184ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_45_1.actors_["1184ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_45_1.actors_["1184ui_story"].transform.position).z)
				arg_45_1.actors_["1184ui_story"].transform.localEulerAngles.z = 0
				arg_45_1.actors_["1184ui_story"].transform.localEulerAngles.x = 0
				arg_45_1.actors_["1184ui_story"].transform.localEulerAngles = arg_45_1.actors_["1184ui_story"].transform.localEulerAngles
			end

			if arg_45_1.time_ >= 0 + var_48_0 and arg_45_1.time_ < 0 + var_48_0 + arg_48_0 then
				arg_45_1.actors_["1184ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_45_1.actors_["1184ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_45_1.actors_["1184ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_45_1.actors_["1184ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_45_1.actors_["1184ui_story"].transform.position).z)
				arg_45_1.actors_["1184ui_story"].transform.localEulerAngles.z = 0
				arg_45_1.actors_["1184ui_story"].transform.localEulerAngles.x = 0
				arg_45_1.actors_["1184ui_story"].transform.localEulerAngles = arg_45_1.actors_["1184ui_story"].transform.localEulerAngles
			end

			local var_48_1 = arg_45_1.actors_["1059ui_story"].transform

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1.var_.moveOldPos1059ui_story = var_48_1.localPosition
			end

			local var_48_2 = 0.001

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_2 then
				var_48_1.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos1059ui_story, Vector3.New(0, 100, 0), (arg_45_1.time_ - 0) / var_48_2)
				var_48_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_48_1.position).x, (manager.ui.mainCamera.transform.position - var_48_1.position).y, (manager.ui.mainCamera.transform.position - var_48_1.position).z)
				var_48_1.localEulerAngles.z = 0
				var_48_1.localEulerAngles.x = 0
				var_48_1.localEulerAngles = var_48_1.localEulerAngles
			end

			if arg_45_1.time_ >= 0 + var_48_2 and arg_45_1.time_ < 0 + var_48_2 + arg_48_0 then
				var_48_1.localPosition = Vector3.New(0, 100, 0)
				var_48_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_48_1.position).x, (manager.ui.mainCamera.transform.position - var_48_1.position).y, (manager.ui.mainCamera.transform.position - var_48_1.position).z)
				var_48_1.localEulerAngles.z = 0
				var_48_1.localEulerAngles.x = 0
				var_48_1.localEulerAngles = var_48_1.localEulerAngles
			end

			local var_48_3 = 0
			local var_48_4 = 0.65

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_3 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, false)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_5 = arg_45_1:FormatText(arg_45_1:GetWordFromCfg(116292011).content)

				arg_45_1.text_.text = var_48_5

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_7 = 26 <= 0 and var_48_4 or var_48_4 * (utf8.len(var_48_5) / 26)

				if (26 <= 0 and var_48_4 or var_48_4 * (utf8.len(var_48_5) / 26)) > 0 and var_48_4 < var_48_7 then
					arg_45_1.talkMaxDuration = var_48_7

					if var_48_7 + var_48_3 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_7 + var_48_3
					end
				end

				arg_45_1.text_.text = var_48_5
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)
				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_8 = math.max(var_48_4, arg_45_1.talkMaxDuration)

			if var_48_3 <= arg_45_1.time_ and arg_45_1.time_ < var_48_3 + var_48_8 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_3) / var_48_8

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_3 + var_48_8 and arg_45_1.time_ < var_48_3 + var_48_8 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1184ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1059ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_45_1:InitPlayNodeList()
	end,
	Play116292012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 116292012
		arg_49_1.duration_ = 5

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play116292013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = 1.225

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, false)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_1 = arg_49_1:FormatText(arg_49_1:GetWordFromCfg(116292012).content)

				arg_49_1.text_.text = var_52_1

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_3 = 49 <= 0 and var_52_0 or var_52_0 * (utf8.len(var_52_1) / 49)

				if (49 <= 0 and var_52_0 or var_52_0 * (utf8.len(var_52_1) / 49)) > 0 and var_52_0 < var_52_3 then
					arg_49_1.talkMaxDuration = var_52_3

					if var_52_3 + 0 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_3 + 0
					end
				end

				arg_49_1.text_.text = var_52_1
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)
				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_4 = math.max(var_52_0, arg_49_1.talkMaxDuration)

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_4 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - 0) / var_52_4

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= 0 + var_52_4 and arg_49_1.time_ < 0 + var_52_4 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play116292013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 116292013
		arg_53_1.duration_ = 3.43

		local var_53_0 = {
			zh = 3.433,
			ja = 0.999999999999
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
				arg_53_0:Play116292014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1.var_.moveOldPos1184ui_story = arg_53_1.actors_["1184ui_story"].transform.localPosition
			end

			local var_56_0 = 0.001

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_0 then
				arg_53_1.actors_["1184ui_story"].transform.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos1184ui_story, Vector3.New(0, 100, 0), (arg_53_1.time_ - 0) / var_56_0)
				arg_53_1.actors_["1184ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_53_1.actors_["1184ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["1184ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["1184ui_story"].transform.position).z)
				arg_53_1.actors_["1184ui_story"].transform.localEulerAngles.z = 0
				arg_53_1.actors_["1184ui_story"].transform.localEulerAngles.x = 0
				arg_53_1.actors_["1184ui_story"].transform.localEulerAngles = arg_53_1.actors_["1184ui_story"].transform.localEulerAngles
			end

			if arg_53_1.time_ >= 0 + var_56_0 and arg_53_1.time_ < 0 + var_56_0 + arg_56_0 then
				arg_53_1.actors_["1184ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_53_1.actors_["1184ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_53_1.actors_["1184ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["1184ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["1184ui_story"].transform.position).z)
				arg_53_1.actors_["1184ui_story"].transform.localEulerAngles.z = 0
				arg_53_1.actors_["1184ui_story"].transform.localEulerAngles.x = 0
				arg_53_1.actors_["1184ui_story"].transform.localEulerAngles = arg_53_1.actors_["1184ui_story"].transform.localEulerAngles
			end

			local var_56_1 = arg_53_1.actors_["1059ui_story"].transform

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1.var_.moveOldPos1059ui_story = var_56_1.localPosition
			end

			local var_56_2 = 0.001

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_2 then
				var_56_1.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos1059ui_story, Vector3.New(0, 100, 0), (arg_53_1.time_ - 0) / var_56_2)
				var_56_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_56_1.position).x, (manager.ui.mainCamera.transform.position - var_56_1.position).y, (manager.ui.mainCamera.transform.position - var_56_1.position).z)
				var_56_1.localEulerAngles.z = 0
				var_56_1.localEulerAngles.x = 0
				var_56_1.localEulerAngles = var_56_1.localEulerAngles
			end

			if arg_53_1.time_ >= 0 + var_56_2 and arg_53_1.time_ < 0 + var_56_2 + arg_56_0 then
				var_56_1.localPosition = Vector3.New(0, 100, 0)
				var_56_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_56_1.position).x, (manager.ui.mainCamera.transform.position - var_56_1.position).y, (manager.ui.mainCamera.transform.position - var_56_1.position).z)
				var_56_1.localEulerAngles.z = 0
				var_56_1.localEulerAngles.x = 0
				var_56_1.localEulerAngles = var_56_1.localEulerAngles
			end

			local var_56_3 = manager.ui.mainCamera.transform

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1.var_.shakeOldPos = var_56_3.localPosition
			end

			local var_56_4 = 0.6

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_4 then
				local var_56_5, var_56_6 = math.modf((arg_53_1.time_ - 0) / 0.066)

				var_56_3.localPosition = Vector3.New(var_56_6 * 0.13, var_56_6 * 0.13, var_56_6 * 0.13) + arg_53_1.var_.shakeOldPos
			end

			if arg_53_1.time_ >= 0 + var_56_4 and arg_53_1.time_ < 0 + var_56_4 + arg_56_0 then
				var_56_3.localPosition = arg_53_1.var_.shakeOldPos
			end

			local var_56_7 = 0

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_7 + arg_56_0 then
				arg_53_1.allBtn_.enabled = false
			end

			if arg_53_1.time_ >= var_56_7 + 0.6 and arg_53_1.time_ < var_56_7 + 0.6 + arg_56_0 then
				arg_53_1.allBtn_.enabled = true
			end

			local var_56_8 = 0
			local var_56_9 = 0.375

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_8 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				arg_53_1.leftNameTxt_.text = arg_53_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, true)
				arg_53_1.iconController_:SetSelectedState("hero")

				arg_53_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1148")

				arg_53_1.callingController_:SetSelectedState("normal")

				arg_53_1.keyicon_.color = Color.New(1, 1, 1)
				arg_53_1.icon_.color = Color.New(1, 1, 1)

				local var_56_10 = arg_53_1:GetWordFromCfg(116292013)
				local var_56_11 = arg_53_1:FormatText(var_56_10.content)

				arg_53_1.text_.text = var_56_11

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_13 = 15 <= 0 and var_56_9 or var_56_9 * (utf8.len(var_56_11) / 15)

				if (15 <= 0 and var_56_9 or var_56_9 * (utf8.len(var_56_11) / 15)) > 0 and var_56_9 < var_56_13 then
					arg_53_1.talkMaxDuration = var_56_13

					if var_56_13 + var_56_8 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_13 + var_56_8
					end
				end

				arg_53_1.text_.text = var_56_11
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116292", "116292013", "story_v_out_116292.awb") ~= 0 then
					local var_56_14 = manager.audio:GetVoiceLength("story_v_out_116292", "116292013", "story_v_out_116292.awb") / 1000

					if var_56_14 + var_56_8 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_14 + var_56_8
					end

					if var_56_10.prefab_name ~= "" and arg_53_1.actors_[var_56_10.prefab_name] ~= nil then
						local var_56_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_10.prefab_name].transform, "story_v_out_116292", "116292013", "story_v_out_116292.awb")

						arg_53_1:RecordAudio("116292013", var_56_15)
						arg_53_1:RecordAudio("116292013", var_56_15)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_116292", "116292013", "story_v_out_116292.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_116292", "116292013", "story_v_out_116292.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_16 = math.max(var_56_9, arg_53_1.talkMaxDuration)

			if var_56_8 <= arg_53_1.time_ and arg_53_1.time_ < var_56_8 + var_56_16 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_8) / var_56_16

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_8 + var_56_16 and arg_53_1.time_ < var_56_8 + var_56_16 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1184ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1059ui_story",
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
	Play116292014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 116292014
		arg_57_1.duration_ = 2

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play116292015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 and not isNil(arg_57_1.actors_["1184ui_story"]) and arg_57_1.var_.characterEffect1184ui_story == nil then
				arg_57_1.var_.characterEffect1184ui_story = arg_57_1.actors_["1184ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_0 = 0.2

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_0 and not isNil(arg_57_1.actors_["1184ui_story"]) then
				if arg_57_1.var_.characterEffect1184ui_story and not isNil(arg_57_1.actors_["1184ui_story"]) then
					arg_57_1.var_.characterEffect1184ui_story.fillFlat = false
				end
			end

			if arg_57_1.time_ >= 0 + var_60_0 and arg_57_1.time_ < 0 + var_60_0 + arg_60_0 and not isNil(arg_57_1.actors_["1184ui_story"]) and arg_57_1.var_.characterEffect1184ui_story then
				arg_57_1.var_.characterEffect1184ui_story.fillFlat = false
			end

			local var_60_2 = arg_57_1.actors_["1148ui_story"]

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 and not isNil(var_60_2) and arg_57_1.var_.characterEffect1148ui_story == nil then
				arg_57_1.var_.characterEffect1148ui_story = var_60_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_3 = 0.2

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_3 and not isNil(var_60_2) then
				if arg_57_1.var_.characterEffect1148ui_story and not isNil(var_60_2) then
					arg_57_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_57_1.var_.characterEffect1148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_57_1.time_ - 0) / var_60_3)
				end
			end

			if arg_57_1.time_ >= 0 + var_60_3 and arg_57_1.time_ < 0 + var_60_3 + arg_60_0 and not isNil(var_60_2) and arg_57_1.var_.characterEffect1148ui_story then
				arg_57_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_57_1.var_.characterEffect1148ui_story.fillRatio = 0.5
			end

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action11_1")
			end

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_60_4 = arg_57_1.actors_["1184ui_story"].transform

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1.var_.moveOldPos1184ui_story = var_60_4.localPosition

				arg_57_1:ShowWeapon(arg_57_1.var_["1184ui_story" .. "Animator"].transform, true)
			end

			local var_60_5 = 0.001

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_5 then
				var_60_4.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos1184ui_story, Vector3.New(0, -0.97, -6), (arg_57_1.time_ - 0) / var_60_5)
				var_60_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_60_4.position).x, (manager.ui.mainCamera.transform.position - var_60_4.position).y, (manager.ui.mainCamera.transform.position - var_60_4.position).z)
				var_60_4.localEulerAngles.z = 0
				var_60_4.localEulerAngles.x = 0
				var_60_4.localEulerAngles = var_60_4.localEulerAngles
			end

			if arg_57_1.time_ >= 0 + var_60_5 and arg_57_1.time_ < 0 + var_60_5 + arg_60_0 then
				var_60_4.localPosition = Vector3.New(0, -0.97, -6)
				var_60_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_60_4.position).x, (manager.ui.mainCamera.transform.position - var_60_4.position).y, (manager.ui.mainCamera.transform.position - var_60_4.position).z)
				var_60_4.localEulerAngles.z = 0
				var_60_4.localEulerAngles.x = 0
				var_60_4.localEulerAngles = var_60_4.localEulerAngles
			end

			local var_60_6 = 0
			local var_60_7 = 0.175

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_6 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				arg_57_1.leftNameTxt_.text = arg_57_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_8 = arg_57_1:GetWordFromCfg(116292014)
				local var_60_9 = arg_57_1:FormatText(var_60_8.content)

				arg_57_1.text_.text = var_60_9

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_11 = 7 <= 0 and var_60_7 or var_60_7 * (utf8.len(var_60_9) / 7)

				if (7 <= 0 and var_60_7 or var_60_7 * (utf8.len(var_60_9) / 7)) > 0 and var_60_7 < var_60_11 then
					arg_57_1.talkMaxDuration = var_60_11

					if var_60_11 + var_60_6 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_11 + var_60_6
					end
				end

				arg_57_1.text_.text = var_60_9
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116292", "116292014", "story_v_out_116292.awb") ~= 0 then
					local var_60_12 = manager.audio:GetVoiceLength("story_v_out_116292", "116292014", "story_v_out_116292.awb") / 1000

					if var_60_12 + var_60_6 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_12 + var_60_6
					end

					if var_60_8.prefab_name ~= "" and arg_57_1.actors_[var_60_8.prefab_name] ~= nil then
						local var_60_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_8.prefab_name].transform, "story_v_out_116292", "116292014", "story_v_out_116292.awb")

						arg_57_1:RecordAudio("116292014", var_60_13)
						arg_57_1:RecordAudio("116292014", var_60_13)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_116292", "116292014", "story_v_out_116292.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_116292", "116292014", "story_v_out_116292.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_14 = math.max(var_60_7, arg_57_1.talkMaxDuration)

			if var_60_6 <= arg_57_1.time_ and arg_57_1.time_ < var_60_6 + var_60_14 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_6) / var_60_14

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_6 + var_60_14 and arg_57_1.time_ < var_60_6 + var_60_14 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1184ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_57_1:InitPlayNodeList()
	end,
	Play116292015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 116292015
		arg_61_1.duration_ = 5

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play116292016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1.var_.moveOldPos1148ui_story = arg_61_1.actors_["1148ui_story"].transform.localPosition
			end

			local var_64_0 = 0.001

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_0 then
				arg_61_1.actors_["1148ui_story"].transform.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos1148ui_story, Vector3.New(0, 100, 0), (arg_61_1.time_ - 0) / var_64_0)
				arg_61_1.actors_["1148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_61_1.actors_["1148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["1148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["1148ui_story"].transform.position).z)
				arg_61_1.actors_["1148ui_story"].transform.localEulerAngles.z = 0
				arg_61_1.actors_["1148ui_story"].transform.localEulerAngles.x = 0
				arg_61_1.actors_["1148ui_story"].transform.localEulerAngles = arg_61_1.actors_["1148ui_story"].transform.localEulerAngles
			end

			if arg_61_1.time_ >= 0 + var_64_0 and arg_61_1.time_ < 0 + var_64_0 + arg_64_0 then
				arg_61_1.actors_["1148ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_61_1.actors_["1148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_61_1.actors_["1148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["1148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["1148ui_story"].transform.position).z)
				arg_61_1.actors_["1148ui_story"].transform.localEulerAngles.z = 0
				arg_61_1.actors_["1148ui_story"].transform.localEulerAngles.x = 0
				arg_61_1.actors_["1148ui_story"].transform.localEulerAngles = arg_61_1.actors_["1148ui_story"].transform.localEulerAngles
			end

			local var_64_1 = arg_61_1.actors_["1184ui_story"].transform

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1.var_.moveOldPos1184ui_story = var_64_1.localPosition
			end

			local var_64_2 = 0.001

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_2 then
				var_64_1.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos1184ui_story, Vector3.New(0, 100, 0), (arg_61_1.time_ - 0) / var_64_2)
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
			local var_64_4 = 0.85

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

				local var_64_5 = arg_61_1:FormatText(arg_61_1:GetWordFromCfg(116292015).content)

				arg_61_1.text_.text = var_64_5

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_7 = 34 <= 0 and var_64_4 or var_64_4 * (utf8.len(var_64_5) / 34)

				if (34 <= 0 and var_64_4 or var_64_4 * (utf8.len(var_64_5) / 34)) > 0 and var_64_4 < var_64_7 then
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
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1184ui_story",
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
	Play116292016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 116292016
		arg_65_1.duration_ = 5

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play116292017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_68_0 = 1

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_0 then
				local var_68_1, var_68_2 = math.modf((arg_65_1.time_ - 0) / 0.099)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_68_2 * 0.13, var_68_2 * 0.13, var_68_2 * 0.13) + arg_65_1.var_.shakeOldPos
			end

			if arg_65_1.time_ >= 0 + var_68_0 and arg_65_1.time_ < 0 + var_68_0 + arg_68_0 then
				manager.ui.mainCamera.transform.localPosition = arg_65_1.var_.shakeOldPos
			end

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1:AudioAction("play", "effect", "se_story_16", "se_story_16_blast", "")
			end

			local var_68_4 = 0
			local var_68_5 = 0.95

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_4 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, false)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_6 = arg_65_1:FormatText(arg_65_1:GetWordFromCfg(116292016).content)

				arg_65_1.text_.text = var_68_6

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_8 = 38 <= 0 and var_68_5 or var_68_5 * (utf8.len(var_68_6) / 38)

				if (38 <= 0 and var_68_5 or var_68_5 * (utf8.len(var_68_6) / 38)) > 0 and var_68_5 < var_68_8 then
					arg_65_1.talkMaxDuration = var_68_8

					if var_68_8 + var_68_4 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_8 + var_68_4
					end
				end

				arg_65_1.text_.text = var_68_6
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)
				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_9 = math.max(var_68_5, arg_65_1.talkMaxDuration)

			if var_68_4 <= arg_65_1.time_ and arg_65_1.time_ < var_68_4 + var_68_9 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_4) / var_68_9

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_4 + var_68_9 and arg_65_1.time_ < var_68_4 + var_68_9 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play116292017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 116292017
		arg_69_1.duration_ = 11.68

		local var_69_0 = {
			zh = 6.083,
			ja = 11.683
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
				arg_69_0:Play116292018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			if arg_69_1.bgs_.STblack == nil then
				local var_72_0 = Object.Instantiate(arg_69_1.paintGo_)

				var_72_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "STblack")
				var_72_0.name = "STblack"
				var_72_0.transform.parent = arg_69_1.stage_.transform
				var_72_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_69_1.bgs_.STblack = var_72_0
			end

			if 2 < arg_69_1.time_ and arg_69_1.time_ <= 2 + arg_72_0 then
				local var_72_1 = arg_69_1.bgs_.STblack

				arg_69_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_72_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_72_2 = var_72_1:GetComponent("SpriteRenderer")

				if var_72_2 and var_72_2.sprite then
					local var_72_3 = 2 * (var_72_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_72_1.transform.localScale = Vector3.New(var_72_3 / var_72_2.sprite.bounds.size.y < var_72_3 * manager.ui.mainCameraCom_.aspect / var_72_2.sprite.bounds.size.x and var_72_3 * manager.ui.mainCameraCom_.aspect / var_72_2.sprite.bounds.size.x or var_72_3 / var_72_2.sprite.bounds.size.y, var_72_3 / var_72_2.sprite.bounds.size.y < var_72_3 * manager.ui.mainCameraCom_.aspect / var_72_2.sprite.bounds.size.x and var_72_3 * manager.ui.mainCameraCom_.aspect / var_72_2.sprite.bounds.size.x or var_72_3 / var_72_2.sprite.bounds.size.y, 0)
				end

				for iter_72_0, iter_72_1 in pairs(arg_69_1.bgs_) do
					if iter_72_0 ~= "STblack" then
						iter_72_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_72_4 = 0

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_4 + arg_72_0 then
				arg_69_1.mask_.enabled = true
				arg_69_1.mask_.raycastTarget = true

				arg_69_1:SetGaussion(false)
			end

			local var_72_5 = 2

			if var_72_4 <= arg_69_1.time_ and arg_69_1.time_ < var_72_4 + var_72_5 then
				local var_72_6 = Color.New(0, 0, 0)

				var_72_6.a = Mathf.Lerp(0, 1, (arg_69_1.time_ - var_72_4) / var_72_5)
				arg_69_1.mask_.color = var_72_6
			end

			if arg_69_1.time_ >= var_72_4 + var_72_5 and arg_69_1.time_ < var_72_4 + var_72_5 + arg_72_0 then
				local var_72_7 = Color.New(0, 0, 0)

				var_72_7.a = 1
				arg_69_1.mask_.color = var_72_7
			end

			local var_72_8 = 2

			if 2 < arg_69_1.time_ and arg_69_1.time_ <= var_72_8 + arg_72_0 then
				arg_69_1.mask_.enabled = true
				arg_69_1.mask_.raycastTarget = true

				arg_69_1:SetGaussion(false)
			end

			local var_72_9 = 2

			if var_72_8 <= arg_69_1.time_ and arg_69_1.time_ < var_72_8 + var_72_9 then
				local var_72_10 = Color.New(0, 0, 0)

				var_72_10.a = Mathf.Lerp(1, 0, (arg_69_1.time_ - var_72_8) / var_72_9)
				arg_69_1.mask_.color = var_72_10
			end

			if arg_69_1.time_ >= var_72_8 + var_72_9 and arg_69_1.time_ < var_72_8 + var_72_9 + arg_72_0 then
				local var_72_11 = Color.New(0, 0, 0)

				arg_69_1.mask_.enabled = false
				var_72_11.a = 0
				arg_69_1.mask_.color = var_72_11
			end

			if arg_69_1.frameCnt_ <= 1 then
				arg_69_1.dialog_:SetActive(false)
			end

			local var_72_12 = 3.85
			local var_72_13 = 0.15

			if 3.85 < arg_69_1.time_ and arg_69_1.time_ <= var_72_12 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0

				arg_69_1.dialog_:SetActive(true)

				arg_69_1.dialogCg_.alpha = 0

				local var_72_14 = LeanTween.value(arg_69_1.dialog_, 0, 1, 0.3)

				var_72_14:setOnUpdate(LuaHelper.FloatAction(function(arg_73_0)
					arg_69_1.dialogCg_.alpha = arg_73_0
				end))
				var_72_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_69_1.dialog_)
					var_72_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_69_1.duration_ = arg_69_1.duration_ + 0.3

				SetActive(arg_69_1.leftNameGo_, true)

				arg_69_1.leftNameTxt_.text = arg_69_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, true)
				arg_69_1.iconController_:SetSelectedState("hero")

				arg_69_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1148")

				arg_69_1.callingController_:SetSelectedState("normal")

				arg_69_1.keyicon_.color = Color.New(1, 1, 1)
				arg_69_1.icon_.color = Color.New(1, 1, 1)

				local var_72_15 = arg_69_1:GetWordFromCfg(116292017)
				local var_72_16 = arg_69_1:FormatText(var_72_15.content)

				arg_69_1.text_.text = var_72_16

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_18 = 6 <= 0 and var_72_13 or var_72_13 * (utf8.len(var_72_16) / 6)

				if (6 <= 0 and var_72_13 or var_72_13 * (utf8.len(var_72_16) / 6)) > 0 and var_72_13 < var_72_18 then
					arg_69_1.talkMaxDuration = var_72_18
					var_72_12 = var_72_12 + 0.3

					if var_72_18 + var_72_12 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_18 + var_72_12
					end
				end

				arg_69_1.text_.text = var_72_16
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116292", "116292017", "story_v_out_116292.awb") ~= 0 then
					local var_72_19 = manager.audio:GetVoiceLength("story_v_out_116292", "116292017", "story_v_out_116292.awb") / 1000

					if var_72_19 + var_72_12 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_19 + var_72_12
					end

					if var_72_15.prefab_name ~= "" and arg_69_1.actors_[var_72_15.prefab_name] ~= nil then
						local var_72_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_15.prefab_name].transform, "story_v_out_116292", "116292017", "story_v_out_116292.awb")

						arg_69_1:RecordAudio("116292017", var_72_20)
						arg_69_1:RecordAudio("116292017", var_72_20)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_116292", "116292017", "story_v_out_116292.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_116292", "116292017", "story_v_out_116292.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_21 = var_72_12 + 0.3
			local var_72_22 = math.max(var_72_13, arg_69_1.talkMaxDuration)

			if var_72_12 + 0.3 <= arg_69_1.time_ and arg_69_1.time_ < var_72_21 + var_72_22 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_21) / var_72_22

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_21 + var_72_22 and arg_69_1.time_ < var_72_21 + var_72_22 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play116292018 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 116292018
		arg_75_1.duration_ = 12.17

		local var_75_0 = {
			zh = 10.733,
			ja = 12.166
		}
		local var_75_1 = manager.audio:GetLocalizationFlag()

		if var_75_0[var_75_1] ~= nil then
			arg_75_1.duration_ = var_75_0[var_75_1]
		end

		SetActive(arg_75_1.tipsGo_, false)

		function arg_75_1.onSingleLineFinish_()
			arg_75_1.onSingleLineUpdate_ = nil
			arg_75_1.onSingleLineFinish_ = nil
			arg_75_1.state_ = "waiting"
		end

		function arg_75_1.playNext_(arg_77_0)
			if arg_77_0 == 1 then
				arg_75_0:Play116292019(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			if arg_75_1.bgs_.SK0204 == nil then
				local var_78_0 = Object.Instantiate(arg_75_1.paintGo_)

				var_78_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "SK0204")
				var_78_0.name = "SK0204"
				var_78_0.transform.parent = arg_75_1.stage_.transform
				var_78_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_75_1.bgs_.SK0204 = var_78_0
			end

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 then
				local var_78_1 = arg_75_1.bgs_.SK0204

				arg_75_1.bgs_.SK0204.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_78_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_78_2 = var_78_1:GetComponent("SpriteRenderer")

				if var_78_2 and var_78_2.sprite then
					local var_78_3 = 2 * (var_78_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_78_1.transform.localScale = Vector3.New(var_78_3 / var_78_2.sprite.bounds.size.y < var_78_3 * manager.ui.mainCameraCom_.aspect / var_78_2.sprite.bounds.size.x and var_78_3 * manager.ui.mainCameraCom_.aspect / var_78_2.sprite.bounds.size.x or var_78_3 / var_78_2.sprite.bounds.size.y, var_78_3 / var_78_2.sprite.bounds.size.y < var_78_3 * manager.ui.mainCameraCom_.aspect / var_78_2.sprite.bounds.size.x and var_78_3 * manager.ui.mainCameraCom_.aspect / var_78_2.sprite.bounds.size.x or var_78_3 / var_78_2.sprite.bounds.size.y, 0)
				end

				for iter_78_0, iter_78_1 in pairs(arg_75_1.bgs_) do
					if iter_78_0 ~= "SK0204" then
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

			local var_78_5 = 5

			if var_78_4 <= arg_75_1.time_ and arg_75_1.time_ < var_78_4 + var_78_5 then
				local var_78_6 = Color.New(0, 0, 0)

				var_78_6.a = Mathf.Lerp(1, 0, (arg_75_1.time_ - var_78_4) / var_78_5)
				arg_75_1.mask_.color = var_78_6
			end

			if arg_75_1.time_ >= var_78_4 + var_78_5 and arg_75_1.time_ < var_78_4 + var_78_5 + arg_78_0 then
				local var_78_7 = Color.New(0, 0, 0)

				arg_75_1.mask_.enabled = false
				var_78_7.a = 0
				arg_75_1.mask_.color = var_78_7
			end

			local var_78_8 = arg_75_1.bgs_.SK0204.transform

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 then
				arg_75_1.var_.moveOldPosSK0204 = var_78_8.localPosition
			end

			local var_78_9 = 0.1

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_9 then
				var_78_8.localPosition = Vector3.Lerp(arg_75_1.var_.moveOldPosSK0204, Vector3.New(-4.08, 3.87, 0.99), (arg_75_1.time_ - 0) / var_78_9)
			end

			if arg_75_1.time_ >= 0 + var_78_9 and arg_75_1.time_ < 0 + var_78_9 + arg_78_0 then
				var_78_8.localPosition = Vector3.New(-4.08, 3.87, 0.99)
			end

			local var_78_10 = arg_75_1.bgs_.SK0204.transform

			if 0.1 < arg_75_1.time_ and arg_75_1.time_ <= 0.1 + arg_78_0 then
				arg_75_1.var_.moveOldPosSK0204 = var_78_10.localPosition
			end

			local var_78_11 = 4.9

			if 0.1 <= arg_75_1.time_ and arg_75_1.time_ < 0.1 + var_78_11 then
				var_78_10.localPosition = Vector3.Lerp(arg_75_1.var_.moveOldPosSK0204, Vector3.New(0, 1, 10), (arg_75_1.time_ - 0.1) / var_78_11)
			end

			if arg_75_1.time_ >= 0.1 + var_78_11 and arg_75_1.time_ < 0.1 + var_78_11 + arg_78_0 then
				var_78_10.localPosition = Vector3.New(0, 1, 10)
			end

			local var_78_12 = 0

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= var_78_12 + arg_78_0 then
				arg_75_1.allBtn_.enabled = false
			end

			if arg_75_1.time_ >= var_78_12 + 5 and arg_75_1.time_ < var_78_12 + 5 + arg_78_0 then
				arg_75_1.allBtn_.enabled = true
			end

			if arg_75_1.frameCnt_ <= 1 then
				arg_75_1.dialog_:SetActive(false)
			end

			local var_78_13 = 5
			local var_78_14 = 0.45

			if 5 < arg_75_1.time_ and arg_75_1.time_ <= var_78_13 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0

				arg_75_1.dialog_:SetActive(true)

				arg_75_1.dialogCg_.alpha = 0

				local var_78_15 = LeanTween.value(arg_75_1.dialog_, 0, 1, 0.3)

				var_78_15:setOnUpdate(LuaHelper.FloatAction(function(arg_79_0)
					arg_75_1.dialogCg_.alpha = arg_79_0
				end))
				var_78_15:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_75_1.dialog_)
					var_78_15:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_75_1.duration_ = arg_75_1.duration_ + 0.3

				SetActive(arg_75_1.leftNameGo_, true)

				arg_75_1.leftNameTxt_.text = arg_75_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_75_1.leftNameTxt_.transform)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1.leftNameTxt_.text)
				SetActive(arg_75_1.iconTrs_.gameObject, false)
				arg_75_1.callingController_:SetSelectedState("normal")

				local var_78_16 = arg_75_1:GetWordFromCfg(116292018)
				local var_78_17 = arg_75_1:FormatText(var_78_16.content)

				arg_75_1.text_.text = var_78_17

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_19 = 18 <= 0 and var_78_14 or var_78_14 * (utf8.len(var_78_17) / 18)

				if (18 <= 0 and var_78_14 or var_78_14 * (utf8.len(var_78_17) / 18)) > 0 and var_78_14 < var_78_19 then
					arg_75_1.talkMaxDuration = var_78_19
					var_78_13 = var_78_13 + 0.3

					if var_78_19 + var_78_13 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_19 + var_78_13
					end
				end

				arg_75_1.text_.text = var_78_17
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116292", "116292018", "story_v_out_116292.awb") ~= 0 then
					local var_78_20 = manager.audio:GetVoiceLength("story_v_out_116292", "116292018", "story_v_out_116292.awb") / 1000

					if var_78_20 + var_78_13 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_20 + var_78_13
					end

					if var_78_16.prefab_name ~= "" and arg_75_1.actors_[var_78_16.prefab_name] ~= nil then
						local var_78_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_75_1.actors_[var_78_16.prefab_name].transform, "story_v_out_116292", "116292018", "story_v_out_116292.awb")

						arg_75_1:RecordAudio("116292018", var_78_21)
						arg_75_1:RecordAudio("116292018", var_78_21)
					else
						arg_75_1:AudioAction("play", "voice", "story_v_out_116292", "116292018", "story_v_out_116292.awb")
					end

					arg_75_1:RecordHistoryTalkVoice("story_v_out_116292", "116292018", "story_v_out_116292.awb")
				end

				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_22 = var_78_13 + 0.3
			local var_78_23 = math.max(var_78_14, arg_75_1.talkMaxDuration)

			if var_78_13 + 0.3 <= arg_75_1.time_ and arg_75_1.time_ < var_78_22 + var_78_23 then
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
				actorName = "SK0204",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.1,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "SK0204",
				changeDisplayLayer = false,
				needEase = false,
				duration = 4.9,
				className = "StoryMoveNode",
				startTime = 0.1,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_75_1:InitPlayNodeList()
	end,
	Play116292019 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 116292019
		arg_81_1.duration_ = 2.4

		local var_81_0 = {
			zh = 1.9,
			ja = 2.4
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
				arg_81_0:Play116292020(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = 0.175

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				arg_81_1.leftNameTxt_.text = arg_81_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_1 = arg_81_1:GetWordFromCfg(116292019)
				local var_84_2 = arg_81_1:FormatText(var_84_1.content)

				arg_81_1.text_.text = var_84_2

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_4 = 7 <= 0 and var_84_0 or var_84_0 * (utf8.len(var_84_2) / 7)

				if (7 <= 0 and var_84_0 or var_84_0 * (utf8.len(var_84_2) / 7)) > 0 and var_84_0 < var_84_4 then
					arg_81_1.talkMaxDuration = var_84_4

					if var_84_4 + 0 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_4 + 0
					end
				end

				arg_81_1.text_.text = var_84_2
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116292", "116292019", "story_v_out_116292.awb") ~= 0 then
					local var_84_5 = manager.audio:GetVoiceLength("story_v_out_116292", "116292019", "story_v_out_116292.awb") / 1000

					if var_84_5 + 0 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_5 + 0
					end

					if var_84_1.prefab_name ~= "" and arg_81_1.actors_[var_84_1.prefab_name] ~= nil then
						local var_84_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_1.prefab_name].transform, "story_v_out_116292", "116292019", "story_v_out_116292.awb")

						arg_81_1:RecordAudio("116292019", var_84_6)
						arg_81_1:RecordAudio("116292019", var_84_6)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_116292", "116292019", "story_v_out_116292.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_116292", "116292019", "story_v_out_116292.awb")
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
	Play116292020 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 116292020
		arg_85_1.duration_ = 5.8

		local var_85_0 = {
			zh = 5.8,
			ja = 4.9
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
				arg_85_0:Play116292021(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = 0.85

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				arg_85_1.leftNameTxt_.text = arg_85_1:FormatText(StoryNameCfg[332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, true)
				arg_85_1.iconController_:SetSelectedState("hero")

				arg_85_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10024")

				arg_85_1.callingController_:SetSelectedState("normal")

				arg_85_1.keyicon_.color = Color.New(1, 1, 1)
				arg_85_1.icon_.color = Color.New(1, 1, 1)

				local var_88_1 = arg_85_1:GetWordFromCfg(116292020)
				local var_88_2 = arg_85_1:FormatText(var_88_1.content)

				arg_85_1.text_.text = var_88_2

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_4 = 34 <= 0 and var_88_0 or var_88_0 * (utf8.len(var_88_2) / 34)

				if (34 <= 0 and var_88_0 or var_88_0 * (utf8.len(var_88_2) / 34)) > 0 and var_88_0 < var_88_4 then
					arg_85_1.talkMaxDuration = var_88_4

					if var_88_4 + 0 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_4 + 0
					end
				end

				arg_85_1.text_.text = var_88_2
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116292", "116292020", "story_v_out_116292.awb") ~= 0 then
					local var_88_5 = manager.audio:GetVoiceLength("story_v_out_116292", "116292020", "story_v_out_116292.awb") / 1000

					if var_88_5 + 0 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_5 + 0
					end

					if var_88_1.prefab_name ~= "" and arg_85_1.actors_[var_88_1.prefab_name] ~= nil then
						local var_88_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_1.prefab_name].transform, "story_v_out_116292", "116292020", "story_v_out_116292.awb")

						arg_85_1:RecordAudio("116292020", var_88_6)
						arg_85_1:RecordAudio("116292020", var_88_6)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_116292", "116292020", "story_v_out_116292.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_116292", "116292020", "story_v_out_116292.awb")
				end

				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_7 = math.max(var_88_0, arg_85_1.talkMaxDuration)

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_7 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - 0) / var_88_7

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= 0 + var_88_7 and arg_85_1.time_ < 0 + var_88_7 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {}

		arg_85_1:InitPlayNodeList()
	end,
	Play116292021 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 116292021
		arg_89_1.duration_ = 10.63

		local var_89_0 = {
			zh = 8.166,
			ja = 10.633
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
				arg_89_0:Play116292022(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = 1.075

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				arg_89_1.leftNameTxt_.text = arg_89_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_1 = arg_89_1:GetWordFromCfg(116292021)
				local var_92_2 = arg_89_1:FormatText(var_92_1.content)

				arg_89_1.text_.text = var_92_2

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_4 = 43 <= 0 and var_92_0 or var_92_0 * (utf8.len(var_92_2) / 43)

				if (43 <= 0 and var_92_0 or var_92_0 * (utf8.len(var_92_2) / 43)) > 0 and var_92_0 < var_92_4 then
					arg_89_1.talkMaxDuration = var_92_4

					if var_92_4 + 0 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_4 + 0
					end
				end

				arg_89_1.text_.text = var_92_2
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116292", "116292021", "story_v_out_116292.awb") ~= 0 then
					local var_92_5 = manager.audio:GetVoiceLength("story_v_out_116292", "116292021", "story_v_out_116292.awb") / 1000

					if var_92_5 + 0 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_5 + 0
					end

					if var_92_1.prefab_name ~= "" and arg_89_1.actors_[var_92_1.prefab_name] ~= nil then
						local var_92_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_1.prefab_name].transform, "story_v_out_116292", "116292021", "story_v_out_116292.awb")

						arg_89_1:RecordAudio("116292021", var_92_6)
						arg_89_1:RecordAudio("116292021", var_92_6)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_116292", "116292021", "story_v_out_116292.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_116292", "116292021", "story_v_out_116292.awb")
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
	Play116292022 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 116292022
		arg_93_1.duration_ = 7.3

		local var_93_0 = {
			zh = 7.3,
			ja = 3.6
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
				arg_93_0:Play116292023(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = 0.525

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				arg_93_1.leftNameTxt_.text = arg_93_1:FormatText(StoryNameCfg[332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, true)
				arg_93_1.iconController_:SetSelectedState("hero")

				arg_93_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10024")

				arg_93_1.callingController_:SetSelectedState("normal")

				arg_93_1.keyicon_.color = Color.New(1, 1, 1)
				arg_93_1.icon_.color = Color.New(1, 1, 1)

				local var_96_1 = arg_93_1:GetWordFromCfg(116292022)
				local var_96_2 = arg_93_1:FormatText(var_96_1.content)

				arg_93_1.text_.text = var_96_2

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_4 = 21 <= 0 and var_96_0 or var_96_0 * (utf8.len(var_96_2) / 21)

				if (21 <= 0 and var_96_0 or var_96_0 * (utf8.len(var_96_2) / 21)) > 0 and var_96_0 < var_96_4 then
					arg_93_1.talkMaxDuration = var_96_4

					if var_96_4 + 0 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_4 + 0
					end
				end

				arg_93_1.text_.text = var_96_2
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116292", "116292022", "story_v_out_116292.awb") ~= 0 then
					local var_96_5 = manager.audio:GetVoiceLength("story_v_out_116292", "116292022", "story_v_out_116292.awb") / 1000

					if var_96_5 + 0 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_5 + 0
					end

					if var_96_1.prefab_name ~= "" and arg_93_1.actors_[var_96_1.prefab_name] ~= nil then
						local var_96_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_1.prefab_name].transform, "story_v_out_116292", "116292022", "story_v_out_116292.awb")

						arg_93_1:RecordAudio("116292022", var_96_6)
						arg_93_1:RecordAudio("116292022", var_96_6)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_116292", "116292022", "story_v_out_116292.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_116292", "116292022", "story_v_out_116292.awb")
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
	Play116292023 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 116292023
		arg_97_1.duration_ = 12.67

		local var_97_0 = {
			zh = 12.666,
			ja = 6.766
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
				arg_97_0:Play116292024(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = 1.15

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				arg_97_1.leftNameTxt_.text = arg_97_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_1 = arg_97_1:GetWordFromCfg(116292023)
				local var_100_2 = arg_97_1:FormatText(var_100_1.content)

				arg_97_1.text_.text = var_100_2

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_4 = 46 <= 0 and var_100_0 or var_100_0 * (utf8.len(var_100_2) / 46)

				if (46 <= 0 and var_100_0 or var_100_0 * (utf8.len(var_100_2) / 46)) > 0 and var_100_0 < var_100_4 then
					arg_97_1.talkMaxDuration = var_100_4

					if var_100_4 + 0 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_4 + 0
					end
				end

				arg_97_1.text_.text = var_100_2
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116292", "116292023", "story_v_out_116292.awb") ~= 0 then
					local var_100_5 = manager.audio:GetVoiceLength("story_v_out_116292", "116292023", "story_v_out_116292.awb") / 1000

					if var_100_5 + 0 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_5 + 0
					end

					if var_100_1.prefab_name ~= "" and arg_97_1.actors_[var_100_1.prefab_name] ~= nil then
						local var_100_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_1.prefab_name].transform, "story_v_out_116292", "116292023", "story_v_out_116292.awb")

						arg_97_1:RecordAudio("116292023", var_100_6)
						arg_97_1:RecordAudio("116292023", var_100_6)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_116292", "116292023", "story_v_out_116292.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_116292", "116292023", "story_v_out_116292.awb")
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
	Play116292024 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 116292024
		arg_101_1.duration_ = 5.63

		local var_101_0 = {
			zh = 5.6,
			ja = 5.633
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
				arg_101_0:Play116292025(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = 0.7

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				arg_101_1.leftNameTxt_.text = arg_101_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, true)
				arg_101_1.iconController_:SetSelectedState("hero")

				arg_101_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1059")

				arg_101_1.callingController_:SetSelectedState("normal")

				arg_101_1.keyicon_.color = Color.New(1, 1, 1)
				arg_101_1.icon_.color = Color.New(1, 1, 1)

				local var_104_1 = arg_101_1:GetWordFromCfg(116292024)
				local var_104_2 = arg_101_1:FormatText(var_104_1.content)

				arg_101_1.text_.text = var_104_2

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_4 = 28 <= 0 and var_104_0 or var_104_0 * (utf8.len(var_104_2) / 28)

				if (28 <= 0 and var_104_0 or var_104_0 * (utf8.len(var_104_2) / 28)) > 0 and var_104_0 < var_104_4 then
					arg_101_1.talkMaxDuration = var_104_4

					if var_104_4 + 0 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_4 + 0
					end
				end

				arg_101_1.text_.text = var_104_2
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116292", "116292024", "story_v_out_116292.awb") ~= 0 then
					local var_104_5 = manager.audio:GetVoiceLength("story_v_out_116292", "116292024", "story_v_out_116292.awb") / 1000

					if var_104_5 + 0 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_5 + 0
					end

					if var_104_1.prefab_name ~= "" and arg_101_1.actors_[var_104_1.prefab_name] ~= nil then
						local var_104_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_1.prefab_name].transform, "story_v_out_116292", "116292024", "story_v_out_116292.awb")

						arg_101_1:RecordAudio("116292024", var_104_6)
						arg_101_1:RecordAudio("116292024", var_104_6)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_116292", "116292024", "story_v_out_116292.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_116292", "116292024", "story_v_out_116292.awb")
				end

				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_7 = math.max(var_104_0, arg_101_1.talkMaxDuration)

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_7 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - 0) / var_104_7

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= 0 + var_104_7 and arg_101_1.time_ < 0 + var_104_7 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {}

		arg_101_1:InitPlayNodeList()
	end,
	Play116292025 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 116292025
		arg_105_1.duration_ = 3.7

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play116292026(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = 0.175

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				arg_105_1.leftNameTxt_.text = arg_105_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_1 = arg_105_1:GetWordFromCfg(116292025)
				local var_108_2 = arg_105_1:FormatText(var_108_1.content)

				arg_105_1.text_.text = var_108_2

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_4 = 7 <= 0 and var_108_0 or var_108_0 * (utf8.len(var_108_2) / 7)

				if (7 <= 0 and var_108_0 or var_108_0 * (utf8.len(var_108_2) / 7)) > 0 and var_108_0 < var_108_4 then
					arg_105_1.talkMaxDuration = var_108_4

					if var_108_4 + 0 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_4 + 0
					end
				end

				arg_105_1.text_.text = var_108_2
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116292", "116292025", "story_v_out_116292.awb") ~= 0 then
					local var_108_5 = manager.audio:GetVoiceLength("story_v_out_116292", "116292025", "story_v_out_116292.awb") / 1000

					if var_108_5 + 0 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_5 + 0
					end

					if var_108_1.prefab_name ~= "" and arg_105_1.actors_[var_108_1.prefab_name] ~= nil then
						local var_108_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_1.prefab_name].transform, "story_v_out_116292", "116292025", "story_v_out_116292.awb")

						arg_105_1:RecordAudio("116292025", var_108_6)
						arg_105_1:RecordAudio("116292025", var_108_6)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_116292", "116292025", "story_v_out_116292.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_116292", "116292025", "story_v_out_116292.awb")
				end

				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_7 = math.max(var_108_0, arg_105_1.talkMaxDuration)

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_7 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - 0) / var_108_7

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= 0 + var_108_7 and arg_105_1.time_ < 0 + var_108_7 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {}

		arg_105_1:InitPlayNodeList()
	end,
	Play116292026 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 116292026
		arg_109_1.duration_ = 9.76

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
		end

		function arg_109_1.playNext_(arg_111_0)
			if arg_111_0 == 1 then
				arg_109_0:Play116292027(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			if 1 < arg_109_1.time_ and arg_109_1.time_ <= 1 + arg_112_0 then
				local var_112_0 = arg_109_1.bgs_.STblack

				arg_109_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_112_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_112_1 = var_112_0:GetComponent("SpriteRenderer")

				if var_112_1 and var_112_1.sprite then
					local var_112_2 = 2 * (var_112_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_112_0.transform.localScale = Vector3.New(var_112_2 / var_112_1.sprite.bounds.size.y < var_112_2 * manager.ui.mainCameraCom_.aspect / var_112_1.sprite.bounds.size.x and var_112_2 * manager.ui.mainCameraCom_.aspect / var_112_1.sprite.bounds.size.x or var_112_2 / var_112_1.sprite.bounds.size.y, var_112_2 / var_112_1.sprite.bounds.size.y < var_112_2 * manager.ui.mainCameraCom_.aspect / var_112_1.sprite.bounds.size.x and var_112_2 * manager.ui.mainCameraCom_.aspect / var_112_1.sprite.bounds.size.x or var_112_2 / var_112_1.sprite.bounds.size.y, 0)
				end

				for iter_112_0, iter_112_1 in pairs(arg_109_1.bgs_) do
					if iter_112_0 ~= "STblack" then
						iter_112_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_112_3 = 0

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= var_112_3 + arg_112_0 then
				arg_109_1.mask_.enabled = true
				arg_109_1.mask_.raycastTarget = false

				arg_109_1:SetGaussion(false)
			end

			local var_112_4 = 1

			if var_112_3 <= arg_109_1.time_ and arg_109_1.time_ < var_112_3 + var_112_4 then
				local var_112_5 = Color.New(0, 0, 0)

				var_112_5.a = Mathf.Lerp(0, 1, (arg_109_1.time_ - var_112_3) / var_112_4)
				arg_109_1.mask_.color = var_112_5
			end

			if arg_109_1.time_ >= var_112_3 + var_112_4 and arg_109_1.time_ < var_112_3 + var_112_4 + arg_112_0 then
				local var_112_6 = Color.New(0, 0, 0)

				var_112_6.a = 1
				arg_109_1.mask_.color = var_112_6
			end

			local var_112_7 = 1

			if 1 < arg_109_1.time_ and arg_109_1.time_ <= var_112_7 + arg_112_0 then
				arg_109_1.mask_.enabled = true
				arg_109_1.mask_.raycastTarget = false

				arg_109_1:SetGaussion(false)
			end

			local var_112_8 = 1.5

			if var_112_7 <= arg_109_1.time_ and arg_109_1.time_ < var_112_7 + var_112_8 then
				local var_112_9 = Color.New(0, 0, 0)

				var_112_9.a = Mathf.Lerp(1, 0, (arg_109_1.time_ - var_112_7) / var_112_8)
				arg_109_1.mask_.color = var_112_9
			end

			if arg_109_1.time_ >= var_112_7 + var_112_8 and arg_109_1.time_ < var_112_7 + var_112_8 + arg_112_0 then
				local var_112_10 = Color.New(0, 0, 0)

				arg_109_1.mask_.enabled = false
				var_112_10.a = 0
				arg_109_1.mask_.color = var_112_10
			end

			local var_112_11 = 2.5
			local var_112_12 = manager.audio:GetVoiceLength("story_v_out_116292", "116292026", "story_v_out_116292.awb") / 1000

			if var_112_12 > 0 and 7.264 < var_112_12 and var_112_12 + var_112_11 > arg_109_1.duration_ then
				arg_109_1.duration_ = var_112_12 + var_112_11
			end

			if var_112_11 < arg_109_1.time_ and arg_109_1.time_ <= var_112_11 + arg_112_0 then
				arg_109_1:AudioAction("play", "voice", "story_v_out_116292", "116292026", "story_v_out_116292.awb")
			end

			if 1 < arg_109_1.time_ and arg_109_1.time_ <= 1 + arg_112_0 then
				arg_109_1.fswbg_:SetActive(true)
				arg_109_1.dialog_:SetActive(false)

				arg_109_1.fswtw_.percent = 0
				arg_109_1.fswt_.text = arg_109_1:FormatText(arg_109_1:GetWordFromCfg(116292026).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.fswt_)

				arg_109_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_109_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_109_1.fswtw_:SetDirty()

				arg_109_1.typewritterCharCountI18N = 0

				SetActive(arg_109_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_109_1:ShowNextGo(false)
			end

			local var_112_14 = 2.5

			if 2.5 < arg_109_1.time_ and arg_109_1.time_ <= var_112_14 + arg_112_0 then
				arg_109_1.var_.oldValueTypewriter = arg_109_1.fswtw_.percent

				SetActive(arg_109_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_109_1:ShowNextGo(false)
			end

			local var_112_15 = 42
			local var_112_16 = 2.8
			local var_112_17, var_112_18 = arg_109_1:GetPercentByPara(arg_109_1:FormatText(arg_109_1:GetWordFromCfg(116292026).content), 1)

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

			local var_112_20 = math.max(2.8, arg_109_1.talkMaxDuration)

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

			local var_112_21 = 0

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= var_112_21 + arg_112_0 then
				arg_109_1.allBtn_.enabled = false
			end

			if arg_109_1.time_ >= var_112_21 + 5.3 and arg_109_1.time_ < var_112_21 + 5.3 + arg_112_0 then
				arg_109_1.allBtn_.enabled = true
			end
		end

		arg_109_1.nodeConfigList_ = {}

		arg_109_1:InitPlayNodeList()
	end,
	Play116292027 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 116292027
		arg_113_1.duration_ = 1

		SetActive(arg_113_1.tipsGo_, false)

		function arg_113_1.onSingleLineFinish_()
			arg_113_1.onSingleLineUpdate_ = nil
			arg_113_1.onSingleLineFinish_ = nil
			arg_113_1.state_ = "waiting"
		end

		function arg_113_1.playNext_(arg_115_0)
			if arg_115_0 == 1 then
				arg_113_0:Play116292028(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1.var_.oldValueTypewriter = arg_113_1.fswtw_.percent

				SetActive(arg_113_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_113_1:ShowNextGo(false)
			end

			local var_116_0 = 0
			local var_116_1 = -0.533333333333333
			local var_116_2, var_116_3 = arg_113_1:GetPercentByPara(arg_113_1:FormatText(arg_113_1:GetWordFromCfg(116292026).content), 1)

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0

				local var_116_4 = var_116_0 <= 0 and var_116_1 or var_116_1 * ((var_116_3 - arg_113_1.typewritterCharCountI18N) / var_116_0)

				if (var_116_0 <= 0 and var_116_1 or var_116_1 * ((var_116_3 - arg_113_1.typewritterCharCountI18N) / var_116_0)) > 0 and var_116_1 < var_116_4 then
					arg_113_1.talkMaxDuration = var_116_4

					if var_116_4 + 0 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_4 + 0
					end
				end
			end

			local var_116_5 = math.max(-0.533333333333333, arg_113_1.talkMaxDuration)

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_5 then
				arg_113_1.fswtw_.percent = Mathf.Lerp(arg_113_1.var_.oldValueTypewriter, var_116_2, (arg_113_1.time_ - 0) / var_116_5)
				arg_113_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_113_1.fswtw_:SetDirty()
			end

			if arg_113_1.time_ >= 0 + var_116_5 and arg_113_1.time_ < 0 + var_116_5 + arg_116_0 then
				arg_113_1.fswtw_.percent = var_116_2

				arg_113_1.fswtw_:SetDirty()
				arg_113_1:ShowNextGo(true)

				arg_113_1.typewritterCharCountI18N = var_116_3
			end

			local var_116_6 = 0

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= var_116_6 + arg_116_0 then
				arg_113_1.var_.oldValueTypewriter = arg_113_1.fswtw_.percent

				SetActive(arg_113_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_113_1:ShowNextGo(false)
			end

			local var_116_7 = 57
			local var_116_8 = 1
			local var_116_9, var_116_10 = arg_113_1:GetPercentByPara(arg_113_1:FormatText(arg_113_1:GetWordFromCfg(116292026).content), 2)

			if var_116_6 < arg_113_1.time_ and arg_113_1.time_ <= var_116_6 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0

				local var_116_11 = var_116_7 <= 0 and var_116_8 or var_116_8 * ((var_116_10 - arg_113_1.typewritterCharCountI18N) / var_116_7)

				if (var_116_7 <= 0 and var_116_8 or var_116_8 * ((var_116_10 - arg_113_1.typewritterCharCountI18N) / var_116_7)) > 0 and var_116_8 < var_116_11 then
					arg_113_1.talkMaxDuration = var_116_11

					if var_116_11 + var_116_6 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_11 + var_116_6
					end
				end
			end

			local var_116_12 = math.max(1, arg_113_1.talkMaxDuration)

			if var_116_6 <= arg_113_1.time_ and arg_113_1.time_ < var_116_6 + var_116_12 then
				arg_113_1.fswtw_.percent = Mathf.Lerp(arg_113_1.var_.oldValueTypewriter, var_116_9, (arg_113_1.time_ - var_116_6) / var_116_12)
				arg_113_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_113_1.fswtw_:SetDirty()
			end

			if arg_113_1.time_ >= var_116_6 + var_116_12 and arg_113_1.time_ < var_116_6 + var_116_12 + arg_116_0 then
				arg_113_1.fswtw_.percent = var_116_9

				arg_113_1.fswtw_:SetDirty()
				arg_113_1:ShowNextGo(true)

				arg_113_1.typewritterCharCountI18N = var_116_10
			end

			local var_116_13 = 0
			local var_116_14 = manager.audio:GetVoiceLength("story_v_out_116292", "116292027", "story_v_out_116292.awb") / 1000

			if var_116_14 > 0 and 0.711 < var_116_14 and var_116_14 + var_116_13 > arg_113_1.duration_ then
				arg_113_1.duration_ = var_116_14 + var_116_13
			end

			if var_116_13 < arg_113_1.time_ and arg_113_1.time_ <= var_116_13 + arg_116_0 then
				arg_113_1:AudioAction("play", "voice", "story_v_out_116292", "116292027", "story_v_out_116292.awb")
			end

			local var_116_16 = 0

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= var_116_16 + arg_116_0 then
				arg_113_1.allBtn_.enabled = false
			end

			if arg_113_1.time_ >= var_116_16 + 1 and arg_113_1.time_ < var_116_16 + 1 + arg_116_0 then
				arg_113_1.allBtn_.enabled = true
			end
		end

		arg_113_1.nodeConfigList_ = {}

		arg_113_1:InitPlayNodeList()
	end,
	Play116292028 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 116292028
		arg_117_1.duration_ = 7.42

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"
		end

		function arg_117_1.playNext_(arg_119_0)
			if arg_119_0 == 1 then
				arg_117_0:Play116292029(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1.var_.oldValueTypewriter = arg_117_1.fswtw_.percent

				SetActive(arg_117_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_117_1:ShowNextGo(false)
			end

			local var_120_0 = 46
			local var_120_1 = 3.06666666666667
			local var_120_2, var_120_3 = arg_117_1:GetPercentByPara(arg_117_1:FormatText(arg_117_1:GetWordFromCfg(116292026).content), 3)

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0

				local var_120_4 = var_120_0 <= 0 and var_120_1 or var_120_1 * ((var_120_3 - arg_117_1.typewritterCharCountI18N) / var_120_0)

				if (var_120_0 <= 0 and var_120_1 or var_120_1 * ((var_120_3 - arg_117_1.typewritterCharCountI18N) / var_120_0)) > 0 and var_120_1 < var_120_4 then
					arg_117_1.talkMaxDuration = var_120_4

					if var_120_4 + 0 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_4 + 0
					end
				end
			end

			local var_120_5 = math.max(3.06666666666667, arg_117_1.talkMaxDuration)

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_5 then
				arg_117_1.fswtw_.percent = Mathf.Lerp(arg_117_1.var_.oldValueTypewriter, var_120_2, (arg_117_1.time_ - 0) / var_120_5)
				arg_117_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_117_1.fswtw_:SetDirty()
			end

			if arg_117_1.time_ >= 0 + var_120_5 and arg_117_1.time_ < 0 + var_120_5 + arg_120_0 then
				arg_117_1.fswtw_.percent = var_120_2

				arg_117_1.fswtw_:SetDirty()
				arg_117_1:ShowNextGo(true)

				arg_117_1.typewritterCharCountI18N = var_120_3
			end

			local var_120_6 = 0
			local var_120_7 = manager.audio:GetVoiceLength("story_v_out_116292", "116292028", "story_v_out_116292.awb") / 1000

			if var_120_7 > 0 and 7.417 < var_120_7 and var_120_7 + var_120_6 > arg_117_1.duration_ then
				arg_117_1.duration_ = var_120_7 + var_120_6
			end

			if var_120_6 < arg_117_1.time_ and arg_117_1.time_ <= var_120_6 + arg_120_0 then
				arg_117_1:AudioAction("play", "voice", "story_v_out_116292", "116292028", "story_v_out_116292.awb")
			end

			local var_120_9 = 0

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= var_120_9 + arg_120_0 then
				arg_117_1.allBtn_.enabled = false
			end

			if arg_117_1.time_ >= var_120_9 + 3.06666666666667 and arg_117_1.time_ < var_120_9 + 3.06666666666667 + arg_120_0 then
				arg_117_1.allBtn_.enabled = true
			end
		end

		arg_117_1.nodeConfigList_ = {}

		arg_117_1:InitPlayNodeList()
	end,
	Play116292029 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 116292029
		arg_121_1.duration_ = 7.8

		SetActive(arg_121_1.tipsGo_, false)

		function arg_121_1.onSingleLineFinish_()
			arg_121_1.onSingleLineUpdate_ = nil
			arg_121_1.onSingleLineFinish_ = nil
			arg_121_1.state_ = "waiting"
		end

		function arg_121_1.playNext_(arg_123_0)
			if arg_123_0 == 1 then
				arg_121_0:Play116292030(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1.var_.oldValueTypewriter = arg_121_1.fswtw_.percent

				SetActive(arg_121_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_121_1:ShowNextGo(false)
			end

			local var_124_0 = 0
			local var_124_1 = -0.866666666666667
			local var_124_2, var_124_3 = arg_121_1:GetPercentByPara(arg_121_1:FormatText(arg_121_1:GetWordFromCfg(116292026).content), 3)

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0

				local var_124_4 = var_124_0 <= 0 and var_124_1 or var_124_1 * ((var_124_3 - arg_121_1.typewritterCharCountI18N) / var_124_0)

				if (var_124_0 <= 0 and var_124_1 or var_124_1 * ((var_124_3 - arg_121_1.typewritterCharCountI18N) / var_124_0)) > 0 and var_124_1 < var_124_4 then
					arg_121_1.talkMaxDuration = var_124_4

					if var_124_4 + 0 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_4 + 0
					end
				end
			end

			local var_124_5 = math.max(-0.866666666666667, arg_121_1.talkMaxDuration)

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_5 then
				arg_121_1.fswtw_.percent = Mathf.Lerp(arg_121_1.var_.oldValueTypewriter, var_124_2, (arg_121_1.time_ - 0) / var_124_5)
				arg_121_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_121_1.fswtw_:SetDirty()
			end

			if arg_121_1.time_ >= 0 + var_124_5 and arg_121_1.time_ < 0 + var_124_5 + arg_124_0 then
				arg_121_1.fswtw_.percent = var_124_2

				arg_121_1.fswtw_:SetDirty()
				arg_121_1:ShowNextGo(true)

				arg_121_1.typewritterCharCountI18N = var_124_3
			end

			local var_124_6 = 0

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= var_124_6 + arg_124_0 then
				arg_121_1.var_.oldValueTypewriter = arg_121_1.fswtw_.percent

				SetActive(arg_121_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_121_1:ShowNextGo(false)
			end

			local var_124_7 = 45
			local var_124_8 = 3
			local var_124_9, var_124_10 = arg_121_1:GetPercentByPara(arg_121_1:FormatText(arg_121_1:GetWordFromCfg(116292026).content), 4)

			if var_124_6 < arg_121_1.time_ and arg_121_1.time_ <= var_124_6 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0

				local var_124_11 = var_124_7 <= 0 and var_124_8 or var_124_8 * ((var_124_10 - arg_121_1.typewritterCharCountI18N) / var_124_7)

				if (var_124_7 <= 0 and var_124_8 or var_124_8 * ((var_124_10 - arg_121_1.typewritterCharCountI18N) / var_124_7)) > 0 and var_124_8 < var_124_11 then
					arg_121_1.talkMaxDuration = var_124_11

					if var_124_11 + var_124_6 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_11 + var_124_6
					end
				end
			end

			local var_124_12 = math.max(3, arg_121_1.talkMaxDuration)

			if var_124_6 <= arg_121_1.time_ and arg_121_1.time_ < var_124_6 + var_124_12 then
				arg_121_1.fswtw_.percent = Mathf.Lerp(arg_121_1.var_.oldValueTypewriter, var_124_9, (arg_121_1.time_ - var_124_6) / var_124_12)
				arg_121_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_121_1.fswtw_:SetDirty()
			end

			if arg_121_1.time_ >= var_124_6 + var_124_12 and arg_121_1.time_ < var_124_6 + var_124_12 + arg_124_0 then
				arg_121_1.fswtw_.percent = var_124_9

				arg_121_1.fswtw_:SetDirty()
				arg_121_1:ShowNextGo(true)

				arg_121_1.typewritterCharCountI18N = var_124_10
			end

			local var_124_13 = 0
			local var_124_14 = manager.audio:GetVoiceLength("story_v_out_116292", "116292029", "story_v_out_116292.awb") / 1000

			if var_124_14 > 0 and 7.802 < var_124_14 and var_124_14 + var_124_13 > arg_121_1.duration_ then
				arg_121_1.duration_ = var_124_14 + var_124_13
			end

			if var_124_13 < arg_121_1.time_ and arg_121_1.time_ <= var_124_13 + arg_124_0 then
				arg_121_1:AudioAction("play", "voice", "story_v_out_116292", "116292029", "story_v_out_116292.awb")
			end

			local var_124_16 = 0

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= var_124_16 + arg_124_0 then
				arg_121_1.allBtn_.enabled = false
			end

			if arg_121_1.time_ >= var_124_16 + 3.06666666666667 and arg_121_1.time_ < var_124_16 + 3.06666666666667 + arg_124_0 then
				arg_121_1.allBtn_.enabled = true
			end
		end

		arg_121_1.nodeConfigList_ = {}

		arg_121_1:InitPlayNodeList()
	end,
	Play116292030 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 116292030
		arg_125_1.duration_ = 3.73

		SetActive(arg_125_1.tipsGo_, false)

		function arg_125_1.onSingleLineFinish_()
			arg_125_1.onSingleLineUpdate_ = nil
			arg_125_1.onSingleLineFinish_ = nil
			arg_125_1.state_ = "waiting"
		end

		function arg_125_1.playNext_(arg_127_0)
			if arg_127_0 == 1 then
				arg_125_0:Play116292031(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1.var_.oldValueTypewriter = arg_125_1.fswtw_.percent

				SetActive(arg_125_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_125_1:ShowNextGo(false)
			end

			local var_128_0 = 0
			local var_128_1 = -2.6
			local var_128_2, var_128_3 = arg_125_1:GetPercentByPara(arg_125_1:FormatText(arg_125_1:GetWordFromCfg(116292026).content), 3)

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0

				local var_128_4 = var_128_0 <= 0 and var_128_1 or var_128_1 * ((var_128_3 - arg_125_1.typewritterCharCountI18N) / var_128_0)

				if (var_128_0 <= 0 and var_128_1 or var_128_1 * ((var_128_3 - arg_125_1.typewritterCharCountI18N) / var_128_0)) > 0 and var_128_1 < var_128_4 then
					arg_125_1.talkMaxDuration = var_128_4

					if var_128_4 + 0 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_4 + 0
					end
				end
			end

			local var_128_5 = math.max(-2.6, arg_125_1.talkMaxDuration)

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_5 then
				arg_125_1.fswtw_.percent = Mathf.Lerp(arg_125_1.var_.oldValueTypewriter, var_128_2, (arg_125_1.time_ - 0) / var_128_5)
				arg_125_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_125_1.fswtw_:SetDirty()
			end

			if arg_125_1.time_ >= 0 + var_128_5 and arg_125_1.time_ < 0 + var_128_5 + arg_128_0 then
				arg_125_1.fswtw_.percent = var_128_2

				arg_125_1.fswtw_:SetDirty()
				arg_125_1:ShowNextGo(true)

				arg_125_1.typewritterCharCountI18N = var_128_3
			end

			local var_128_6 = 0

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= var_128_6 + arg_128_0 then
				arg_125_1.var_.oldValueTypewriter = arg_125_1.fswtw_.percent

				SetActive(arg_125_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_125_1:ShowNextGo(false)
			end

			local var_128_7 = 29
			local var_128_8 = 1.93333333333333
			local var_128_9, var_128_10 = arg_125_1:GetPercentByPara(arg_125_1:FormatText(arg_125_1:GetWordFromCfg(116292026).content), 5)

			if var_128_6 < arg_125_1.time_ and arg_125_1.time_ <= var_128_6 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0

				local var_128_11 = var_128_7 <= 0 and var_128_8 or var_128_8 * ((var_128_10 - arg_125_1.typewritterCharCountI18N) / var_128_7)

				if (var_128_7 <= 0 and var_128_8 or var_128_8 * ((var_128_10 - arg_125_1.typewritterCharCountI18N) / var_128_7)) > 0 and var_128_8 < var_128_11 then
					arg_125_1.talkMaxDuration = var_128_11

					if var_128_11 + var_128_6 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_11 + var_128_6
					end
				end
			end

			local var_128_12 = math.max(1.93333333333333, arg_125_1.talkMaxDuration)

			if var_128_6 <= arg_125_1.time_ and arg_125_1.time_ < var_128_6 + var_128_12 then
				arg_125_1.fswtw_.percent = Mathf.Lerp(arg_125_1.var_.oldValueTypewriter, var_128_9, (arg_125_1.time_ - var_128_6) / var_128_12)
				arg_125_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_125_1.fswtw_:SetDirty()
			end

			if arg_125_1.time_ >= var_128_6 + var_128_12 and arg_125_1.time_ < var_128_6 + var_128_12 + arg_128_0 then
				arg_125_1.fswtw_.percent = var_128_9

				arg_125_1.fswtw_:SetDirty()
				arg_125_1:ShowNextGo(true)

				arg_125_1.typewritterCharCountI18N = var_128_10
			end

			local var_128_13 = 0
			local var_128_14 = manager.audio:GetVoiceLength("story_v_out_116292", "116292030", "story_v_out_116292.awb") / 1000

			if var_128_14 > 0 and 3.729 < var_128_14 and var_128_14 + var_128_13 > arg_125_1.duration_ then
				arg_125_1.duration_ = var_128_14 + var_128_13
			end

			if var_128_13 < arg_125_1.time_ and arg_125_1.time_ <= var_128_13 + arg_128_0 then
				arg_125_1:AudioAction("play", "voice", "story_v_out_116292", "116292030", "story_v_out_116292.awb")
			end

			local var_128_16 = 0

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= var_128_16 + arg_128_0 then
				arg_125_1.allBtn_.enabled = false
			end

			if arg_125_1.time_ >= var_128_16 + 1.93333333333333 and arg_125_1.time_ < var_128_16 + 1.93333333333333 + arg_128_0 then
				arg_125_1.allBtn_.enabled = true
			end
		end

		arg_125_1.nodeConfigList_ = {}

		arg_125_1:InitPlayNodeList()
	end,
	Play116292031 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 116292031
		arg_129_1.duration_ = 2.59

		SetActive(arg_129_1.tipsGo_, false)

		function arg_129_1.onSingleLineFinish_()
			arg_129_1.onSingleLineUpdate_ = nil
			arg_129_1.onSingleLineFinish_ = nil
			arg_129_1.state_ = "waiting"
		end

		function arg_129_1.playNext_(arg_131_0)
			if arg_131_0 == 1 then
				arg_129_0:Play116292032(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1.var_.oldValueTypewriter = arg_129_1.fswtw_.percent

				SetActive(arg_129_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_129_1:ShowNextGo(false)
			end

			local var_132_0 = 0
			local var_132_1 = -3.93333333333333
			local var_132_2, var_132_3 = arg_129_1:GetPercentByPara(arg_129_1:FormatText(arg_129_1:GetWordFromCfg(116292026).content), 3)

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0

				local var_132_4 = var_132_0 <= 0 and var_132_1 or var_132_1 * ((var_132_3 - arg_129_1.typewritterCharCountI18N) / var_132_0)

				if (var_132_0 <= 0 and var_132_1 or var_132_1 * ((var_132_3 - arg_129_1.typewritterCharCountI18N) / var_132_0)) > 0 and var_132_1 < var_132_4 then
					arg_129_1.talkMaxDuration = var_132_4

					if var_132_4 + 0 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_4 + 0
					end
				end
			end

			local var_132_5 = math.max(-3.93333333333333, arg_129_1.talkMaxDuration)

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_5 then
				arg_129_1.fswtw_.percent = Mathf.Lerp(arg_129_1.var_.oldValueTypewriter, var_132_2, (arg_129_1.time_ - 0) / var_132_5)
				arg_129_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_129_1.fswtw_:SetDirty()
			end

			if arg_129_1.time_ >= 0 + var_132_5 and arg_129_1.time_ < 0 + var_132_5 + arg_132_0 then
				arg_129_1.fswtw_.percent = var_132_2

				arg_129_1.fswtw_:SetDirty()
				arg_129_1:ShowNextGo(true)

				arg_129_1.typewritterCharCountI18N = var_132_3
			end

			local var_132_6 = 0

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= var_132_6 + arg_132_0 then
				arg_129_1.var_.oldValueTypewriter = arg_129_1.fswtw_.percent

				SetActive(arg_129_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_129_1:ShowNextGo(false)
			end

			local var_132_7 = 15
			local var_132_8 = 1
			local var_132_9, var_132_10 = arg_129_1:GetPercentByPara(arg_129_1:FormatText(arg_129_1:GetWordFromCfg(116292026).content), 6)

			if var_132_6 < arg_129_1.time_ and arg_129_1.time_ <= var_132_6 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0

				local var_132_11 = var_132_7 <= 0 and var_132_8 or var_132_8 * ((var_132_10 - arg_129_1.typewritterCharCountI18N) / var_132_7)

				if (var_132_7 <= 0 and var_132_8 or var_132_8 * ((var_132_10 - arg_129_1.typewritterCharCountI18N) / var_132_7)) > 0 and var_132_8 < var_132_11 then
					arg_129_1.talkMaxDuration = var_132_11

					if var_132_11 + var_132_6 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_11 + var_132_6
					end
				end
			end

			local var_132_12 = math.max(1, arg_129_1.talkMaxDuration)

			if var_132_6 <= arg_129_1.time_ and arg_129_1.time_ < var_132_6 + var_132_12 then
				arg_129_1.fswtw_.percent = Mathf.Lerp(arg_129_1.var_.oldValueTypewriter, var_132_9, (arg_129_1.time_ - var_132_6) / var_132_12)
				arg_129_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_129_1.fswtw_:SetDirty()
			end

			if arg_129_1.time_ >= var_132_6 + var_132_12 and arg_129_1.time_ < var_132_6 + var_132_12 + arg_132_0 then
				arg_129_1.fswtw_.percent = var_132_9

				arg_129_1.fswtw_:SetDirty()
				arg_129_1:ShowNextGo(true)

				arg_129_1.typewritterCharCountI18N = var_132_10
			end

			local var_132_13 = 0
			local var_132_14 = manager.audio:GetVoiceLength("story_v_out_116292", "116292031", "story_v_out_116292.awb") / 1000

			if var_132_14 > 0 and 2.586 < var_132_14 and var_132_14 + var_132_13 > arg_129_1.duration_ then
				arg_129_1.duration_ = var_132_14 + var_132_13
			end

			if var_132_13 < arg_129_1.time_ and arg_129_1.time_ <= var_132_13 + arg_132_0 then
				arg_129_1:AudioAction("play", "voice", "story_v_out_116292", "116292031", "story_v_out_116292.awb")
			end

			local var_132_16 = 0

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= var_132_16 + arg_132_0 then
				arg_129_1.allBtn_.enabled = false
			end

			if arg_129_1.time_ >= var_132_16 + 1 and arg_129_1.time_ < var_132_16 + 1 + arg_132_0 then
				arg_129_1.allBtn_.enabled = true
			end
		end

		arg_129_1.nodeConfigList_ = {}

		arg_129_1:InitPlayNodeList()
	end,
	Play116292032 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 116292032
		arg_133_1.duration_ = 4.96

		SetActive(arg_133_1.tipsGo_, false)

		function arg_133_1.onSingleLineFinish_()
			arg_133_1.onSingleLineUpdate_ = nil
			arg_133_1.onSingleLineFinish_ = nil
			arg_133_1.state_ = "waiting"
		end

		function arg_133_1.playNext_(arg_135_0)
			if arg_135_0 == 1 then
				arg_133_0:Play116292033(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1.var_.oldValueTypewriter = arg_133_1.fswtw_.percent

				SetActive(arg_133_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_133_1:ShowNextGo(false)
			end

			local var_136_0 = 0
			local var_136_1 = -3.46666666666667
			local var_136_2, var_136_3 = arg_133_1:GetPercentByPara(arg_133_1:FormatText(arg_133_1:GetWordFromCfg(116292026).content), 4)

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0

				local var_136_4 = var_136_0 <= 0 and var_136_1 or var_136_1 * ((var_136_3 - arg_133_1.typewritterCharCountI18N) / var_136_0)

				if (var_136_0 <= 0 and var_136_1 or var_136_1 * ((var_136_3 - arg_133_1.typewritterCharCountI18N) / var_136_0)) > 0 and var_136_1 < var_136_4 then
					arg_133_1.talkMaxDuration = var_136_4

					if var_136_4 + 0 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_4 + 0
					end
				end
			end

			local var_136_5 = math.max(-3.46666666666667, arg_133_1.talkMaxDuration)

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_5 then
				arg_133_1.fswtw_.percent = Mathf.Lerp(arg_133_1.var_.oldValueTypewriter, var_136_2, (arg_133_1.time_ - 0) / var_136_5)
				arg_133_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_133_1.fswtw_:SetDirty()
			end

			if arg_133_1.time_ >= 0 + var_136_5 and arg_133_1.time_ < 0 + var_136_5 + arg_136_0 then
				arg_133_1.fswtw_.percent = var_136_2

				arg_133_1.fswtw_:SetDirty()
				arg_133_1:ShowNextGo(true)

				arg_133_1.typewritterCharCountI18N = var_136_3
			end

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1.fswbg_:SetActive(true)
				arg_133_1.dialog_:SetActive(false)

				arg_133_1.fswtw_.percent = 0
				arg_133_1.fswt_.text = arg_133_1:FormatText(arg_133_1:GetWordFromCfg(116292032).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.fswt_)

				arg_133_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_133_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_133_1.fswtw_:SetDirty()

				arg_133_1.typewritterCharCountI18N = 0

				SetActive(arg_133_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_133_1:ShowNextGo(false)
			end

			local var_136_6 = 0.0166666666666667

			if 0.0166666666666667 < arg_133_1.time_ and arg_133_1.time_ <= var_136_6 + arg_136_0 then
				arg_133_1.var_.oldValueTypewriter = arg_133_1.fswtw_.percent

				SetActive(arg_133_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_133_1:ShowNextGo(false)
			end

			local var_136_7 = 34
			local var_136_8 = 2.26666666666667
			local var_136_9, var_136_10 = arg_133_1:GetPercentByPara(arg_133_1:FormatText(arg_133_1:GetWordFromCfg(116292032).content), 1)

			if var_136_6 < arg_133_1.time_ and arg_133_1.time_ <= var_136_6 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0

				local var_136_11 = var_136_7 <= 0 and var_136_8 or var_136_8 * ((var_136_10 - arg_133_1.typewritterCharCountI18N) / var_136_7)

				if (var_136_7 <= 0 and var_136_8 or var_136_8 * ((var_136_10 - arg_133_1.typewritterCharCountI18N) / var_136_7)) > 0 and var_136_8 < var_136_11 then
					arg_133_1.talkMaxDuration = var_136_11

					if var_136_11 + var_136_6 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_11 + var_136_6
					end
				end
			end

			local var_136_12 = math.max(2.26666666666667, arg_133_1.talkMaxDuration)

			if var_136_6 <= arg_133_1.time_ and arg_133_1.time_ < var_136_6 + var_136_12 then
				arg_133_1.fswtw_.percent = Mathf.Lerp(arg_133_1.var_.oldValueTypewriter, var_136_9, (arg_133_1.time_ - var_136_6) / var_136_12)
				arg_133_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_133_1.fswtw_:SetDirty()
			end

			if arg_133_1.time_ >= var_136_6 + var_136_12 and arg_133_1.time_ < var_136_6 + var_136_12 + arg_136_0 then
				arg_133_1.fswtw_.percent = var_136_9

				arg_133_1.fswtw_:SetDirty()
				arg_133_1:ShowNextGo(true)

				arg_133_1.typewritterCharCountI18N = var_136_10
			end

			local var_136_13 = 0
			local var_136_14 = manager.audio:GetVoiceLength("story_v_out_116292", "116292032", "story_v_out_116292.awb") / 1000

			if var_136_14 > 0 and 4.957 < var_136_14 and var_136_14 + var_136_13 > arg_133_1.duration_ then
				arg_133_1.duration_ = var_136_14 + var_136_13
			end

			if var_136_13 < arg_133_1.time_ and arg_133_1.time_ <= var_136_13 + arg_136_0 then
				arg_133_1:AudioAction("play", "voice", "story_v_out_116292", "116292032", "story_v_out_116292.awb")
			end

			local var_136_16 = 0

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= var_136_16 + arg_136_0 then
				arg_133_1.allBtn_.enabled = false
			end

			if arg_133_1.time_ >= var_136_16 + 2.28333333333333 and arg_133_1.time_ < var_136_16 + 2.28333333333333 + arg_136_0 then
				arg_133_1.allBtn_.enabled = true
			end
		end

		arg_133_1.nodeConfigList_ = {}

		arg_133_1:InitPlayNodeList()
	end,
	Play116292033 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 116292033
		arg_137_1.duration_ = 3.35

		SetActive(arg_137_1.tipsGo_, false)

		function arg_137_1.onSingleLineFinish_()
			arg_137_1.onSingleLineUpdate_ = nil
			arg_137_1.onSingleLineFinish_ = nil
			arg_137_1.state_ = "waiting"
		end

		function arg_137_1.playNext_(arg_139_0)
			if arg_139_0 == 1 then
				arg_137_0:Play116292034(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1.var_.oldValueTypewriter = arg_137_1.fswtw_.percent

				SetActive(arg_137_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_137_1:ShowNextGo(false)
			end

			local var_140_0 = 25
			local var_140_1 = 1.66666666666667
			local var_140_2, var_140_3 = arg_137_1:GetPercentByPara(arg_137_1:FormatText(arg_137_1:GetWordFromCfg(116292032).content), 2)

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0

				local var_140_4 = var_140_0 <= 0 and var_140_1 or var_140_1 * ((var_140_3 - arg_137_1.typewritterCharCountI18N) / var_140_0)

				if (var_140_0 <= 0 and var_140_1 or var_140_1 * ((var_140_3 - arg_137_1.typewritterCharCountI18N) / var_140_0)) > 0 and var_140_1 < var_140_4 then
					arg_137_1.talkMaxDuration = var_140_4

					if var_140_4 + 0 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_4 + 0
					end
				end
			end

			local var_140_5 = math.max(1.66666666666667, arg_137_1.talkMaxDuration)

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_5 then
				arg_137_1.fswtw_.percent = Mathf.Lerp(arg_137_1.var_.oldValueTypewriter, var_140_2, (arg_137_1.time_ - 0) / var_140_5)
				arg_137_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_137_1.fswtw_:SetDirty()
			end

			if arg_137_1.time_ >= 0 + var_140_5 and arg_137_1.time_ < 0 + var_140_5 + arg_140_0 then
				arg_137_1.fswtw_.percent = var_140_2

				arg_137_1.fswtw_:SetDirty()
				arg_137_1:ShowNextGo(true)

				arg_137_1.typewritterCharCountI18N = var_140_3
			end

			local var_140_6 = 0
			local var_140_7 = manager.audio:GetVoiceLength("story_v_out_116292", "116292033", "story_v_out_116292.awb") / 1000

			if var_140_7 > 0 and 3.346 < var_140_7 and var_140_7 + var_140_6 > arg_137_1.duration_ then
				arg_137_1.duration_ = var_140_7 + var_140_6
			end

			if var_140_6 < arg_137_1.time_ and arg_137_1.time_ <= var_140_6 + arg_140_0 then
				arg_137_1:AudioAction("play", "voice", "story_v_out_116292", "116292033", "story_v_out_116292.awb")
			end

			local var_140_9 = 0

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= var_140_9 + arg_140_0 then
				arg_137_1.allBtn_.enabled = false
			end

			if arg_137_1.time_ >= var_140_9 + 1.66666666666667 and arg_137_1.time_ < var_140_9 + 1.66666666666667 + arg_140_0 then
				arg_137_1.allBtn_.enabled = true
			end
		end

		arg_137_1.nodeConfigList_ = {}

		arg_137_1:InitPlayNodeList()
	end,
	Play116292034 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 116292034
		arg_141_1.duration_ = 6.67

		SetActive(arg_141_1.tipsGo_, false)

		function arg_141_1.onSingleLineFinish_()
			arg_141_1.onSingleLineUpdate_ = nil
			arg_141_1.onSingleLineFinish_ = nil
			arg_141_1.state_ = "waiting"
		end

		function arg_141_1.playNext_(arg_143_0)
			if arg_143_0 == 1 then
				arg_141_0:Play116292035(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1.var_.oldValueTypewriter = arg_141_1.fswtw_.percent

				SetActive(arg_141_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_141_1:ShowNextGo(false)
			end

			local var_144_0 = 40
			local var_144_1 = 2.66666666666667
			local var_144_2, var_144_3 = arg_141_1:GetPercentByPara(arg_141_1:FormatText(arg_141_1:GetWordFromCfg(116292032).content), 3)

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

			local var_144_5 = math.max(2.66666666666667, arg_141_1.talkMaxDuration)

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

			local var_144_6 = 0
			local var_144_7 = manager.audio:GetVoiceLength("story_v_out_116292", "116292034", "story_v_out_116292.awb") / 1000

			if var_144_7 > 0 and 6.671 < var_144_7 and var_144_7 + var_144_6 > arg_141_1.duration_ then
				arg_141_1.duration_ = var_144_7 + var_144_6
			end

			if var_144_6 < arg_141_1.time_ and arg_141_1.time_ <= var_144_6 + arg_144_0 then
				arg_141_1:AudioAction("play", "voice", "story_v_out_116292", "116292034", "story_v_out_116292.awb")
			end

			local var_144_9 = 0

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= var_144_9 + arg_144_0 then
				arg_141_1.allBtn_.enabled = false
			end

			if arg_141_1.time_ >= var_144_9 + 2.66666666666667 and arg_141_1.time_ < var_144_9 + 2.66666666666667 + arg_144_0 then
				arg_141_1.allBtn_.enabled = true
			end
		end

		arg_141_1.nodeConfigList_ = {}

		arg_141_1:InitPlayNodeList()
	end,
	Play116292035 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 116292035
		arg_145_1.duration_ = 6.09

		SetActive(arg_145_1.tipsGo_, false)

		function arg_145_1.onSingleLineFinish_()
			arg_145_1.onSingleLineUpdate_ = nil
			arg_145_1.onSingleLineFinish_ = nil
			arg_145_1.state_ = "waiting"
		end

		function arg_145_1.playNext_(arg_147_0)
			if arg_147_0 == 1 then
				arg_145_0:Play116292036(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1.var_.oldValueTypewriter = arg_145_1.fswtw_.percent

				SetActive(arg_145_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_145_1:ShowNextGo(false)
			end

			local var_148_0 = 28
			local var_148_1 = 1.86666666666667
			local var_148_2, var_148_3 = arg_145_1:GetPercentByPara(arg_145_1:FormatText(arg_145_1:GetWordFromCfg(116292032).content), 4)

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

			local var_148_5 = math.max(1.86666666666667, arg_145_1.talkMaxDuration)

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

			local var_148_6 = 0
			local var_148_7 = manager.audio:GetVoiceLength("story_v_out_116292", "116292035", "story_v_out_116292.awb") / 1000

			if var_148_7 > 0 and 6.092 < var_148_7 and var_148_7 + var_148_6 > arg_145_1.duration_ then
				arg_145_1.duration_ = var_148_7 + var_148_6
			end

			if var_148_6 < arg_145_1.time_ and arg_145_1.time_ <= var_148_6 + arg_148_0 then
				arg_145_1:AudioAction("play", "voice", "story_v_out_116292", "116292035", "story_v_out_116292.awb")
			end

			local var_148_9 = 0

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= var_148_9 + arg_148_0 then
				arg_145_1.allBtn_.enabled = false
			end

			if arg_145_1.time_ >= var_148_9 + 1.86666666666667 and arg_145_1.time_ < var_148_9 + 1.86666666666667 + arg_148_0 then
				arg_145_1.allBtn_.enabled = true
			end
		end

		arg_145_1.nodeConfigList_ = {}

		arg_145_1:InitPlayNodeList()
	end,
	Play116292036 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 116292036
		arg_149_1.duration_ = 5.68

		SetActive(arg_149_1.tipsGo_, false)

		function arg_149_1.onSingleLineFinish_()
			arg_149_1.onSingleLineUpdate_ = nil
			arg_149_1.onSingleLineFinish_ = nil
			arg_149_1.state_ = "waiting"
		end

		function arg_149_1.playNext_(arg_151_0)
			if arg_151_0 == 1 then
				arg_149_0:Play116292037(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1.var_.oldValueTypewriter = arg_149_1.fswtw_.percent

				SetActive(arg_149_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_149_1:ShowNextGo(false)
			end

			local var_152_0 = 37
			local var_152_1 = 2.46666666666667
			local var_152_2, var_152_3 = arg_149_1:GetPercentByPara(arg_149_1:FormatText(arg_149_1:GetWordFromCfg(116292032).content), 5)

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0

				local var_152_4 = var_152_0 <= 0 and var_152_1 or var_152_1 * ((var_152_3 - arg_149_1.typewritterCharCountI18N) / var_152_0)

				if (var_152_0 <= 0 and var_152_1 or var_152_1 * ((var_152_3 - arg_149_1.typewritterCharCountI18N) / var_152_0)) > 0 and var_152_1 < var_152_4 then
					arg_149_1.talkMaxDuration = var_152_4

					if var_152_4 + 0 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_4 + 0
					end
				end
			end

			local var_152_5 = math.max(2.46666666666667, arg_149_1.talkMaxDuration)

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_5 then
				arg_149_1.fswtw_.percent = Mathf.Lerp(arg_149_1.var_.oldValueTypewriter, var_152_2, (arg_149_1.time_ - 0) / var_152_5)
				arg_149_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_149_1.fswtw_:SetDirty()
			end

			if arg_149_1.time_ >= 0 + var_152_5 and arg_149_1.time_ < 0 + var_152_5 + arg_152_0 then
				arg_149_1.fswtw_.percent = var_152_2

				arg_149_1.fswtw_:SetDirty()
				arg_149_1:ShowNextGo(true)

				arg_149_1.typewritterCharCountI18N = var_152_3
			end

			local var_152_6 = 0
			local var_152_7 = manager.audio:GetVoiceLength("story_v_out_116292", "116292036", "story_v_out_116292.awb") / 1000

			if var_152_7 > 0 and 5.681 < var_152_7 and var_152_7 + var_152_6 > arg_149_1.duration_ then
				arg_149_1.duration_ = var_152_7 + var_152_6
			end

			if var_152_6 < arg_149_1.time_ and arg_149_1.time_ <= var_152_6 + arg_152_0 then
				arg_149_1:AudioAction("play", "voice", "story_v_out_116292", "116292036", "story_v_out_116292.awb")
			end

			local var_152_9 = 0

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= var_152_9 + arg_152_0 then
				arg_149_1.allBtn_.enabled = false
			end

			if arg_149_1.time_ >= var_152_9 + 2.46666666666667 and arg_149_1.time_ < var_152_9 + 2.46666666666667 + arg_152_0 then
				arg_149_1.allBtn_.enabled = true
			end
		end

		arg_149_1.nodeConfigList_ = {}

		arg_149_1:InitPlayNodeList()
	end,
	Play116292037 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 116292037
		arg_153_1.duration_ = 4.06

		SetActive(arg_153_1.tipsGo_, false)

		function arg_153_1.onSingleLineFinish_()
			arg_153_1.onSingleLineUpdate_ = nil
			arg_153_1.onSingleLineFinish_ = nil
			arg_153_1.state_ = "waiting"
		end

		function arg_153_1.playNext_(arg_155_0)
			if arg_155_0 == 1 then
				arg_153_0:Play116292038(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1.var_.oldValueTypewriter = arg_153_1.fswtw_.percent

				SetActive(arg_153_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_153_1:ShowNextGo(false)
			end

			local var_156_0 = 25
			local var_156_1 = 1.66666666666667
			local var_156_2, var_156_3 = arg_153_1:GetPercentByPara(arg_153_1:FormatText(arg_153_1:GetWordFromCfg(116292032).content), 6)

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0

				local var_156_4 = var_156_0 <= 0 and var_156_1 or var_156_1 * ((var_156_3 - arg_153_1.typewritterCharCountI18N) / var_156_0)

				if (var_156_0 <= 0 and var_156_1 or var_156_1 * ((var_156_3 - arg_153_1.typewritterCharCountI18N) / var_156_0)) > 0 and var_156_1 < var_156_4 then
					arg_153_1.talkMaxDuration = var_156_4

					if var_156_4 + 0 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_4 + 0
					end
				end
			end

			local var_156_5 = math.max(1.66666666666667, arg_153_1.talkMaxDuration)

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_5 then
				arg_153_1.fswtw_.percent = Mathf.Lerp(arg_153_1.var_.oldValueTypewriter, var_156_2, (arg_153_1.time_ - 0) / var_156_5)
				arg_153_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_153_1.fswtw_:SetDirty()
			end

			if arg_153_1.time_ >= 0 + var_156_5 and arg_153_1.time_ < 0 + var_156_5 + arg_156_0 then
				arg_153_1.fswtw_.percent = var_156_2

				arg_153_1.fswtw_:SetDirty()
				arg_153_1:ShowNextGo(true)

				arg_153_1.typewritterCharCountI18N = var_156_3
			end

			local var_156_6 = 0
			local var_156_7 = manager.audio:GetVoiceLength("story_v_out_116292", "116292037", "story_v_out_116292.awb") / 1000

			if var_156_7 > 0 and 4.06 < var_156_7 and var_156_7 + var_156_6 > arg_153_1.duration_ then
				arg_153_1.duration_ = var_156_7 + var_156_6
			end

			if var_156_6 < arg_153_1.time_ and arg_153_1.time_ <= var_156_6 + arg_156_0 then
				arg_153_1:AudioAction("play", "voice", "story_v_out_116292", "116292037", "story_v_out_116292.awb")
			end

			local var_156_9 = 0

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= var_156_9 + arg_156_0 then
				arg_153_1.allBtn_.enabled = false
			end

			if arg_153_1.time_ >= var_156_9 + 1.66666666666667 and arg_153_1.time_ < var_156_9 + 1.66666666666667 + arg_156_0 then
				arg_153_1.allBtn_.enabled = true
			end
		end

		arg_153_1.nodeConfigList_ = {}

		arg_153_1:InitPlayNodeList()
	end,
	Play116292038 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 116292038
		arg_157_1.duration_ = 3.55

		SetActive(arg_157_1.tipsGo_, false)

		function arg_157_1.onSingleLineFinish_()
			arg_157_1.onSingleLineUpdate_ = nil
			arg_157_1.onSingleLineFinish_ = nil
			arg_157_1.state_ = "waiting"
		end

		function arg_157_1.playNext_(arg_159_0)
			if arg_159_0 == 1 then
				arg_157_0:Play116292039(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1.fswbg_:SetActive(true)
				arg_157_1.dialog_:SetActive(false)

				arg_157_1.fswtw_.percent = 0
				arg_157_1.fswt_.text = arg_157_1:FormatText(arg_157_1:GetWordFromCfg(116292038).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.fswt_)

				arg_157_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_157_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_157_1.fswtw_:SetDirty()

				arg_157_1.typewritterCharCountI18N = 0

				SetActive(arg_157_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_157_1:ShowNextGo(false)
			end

			local var_160_0 = 0.0166666666666667

			if 0.0166666666666667 < arg_157_1.time_ and arg_157_1.time_ <= var_160_0 + arg_160_0 then
				arg_157_1.var_.oldValueTypewriter = arg_157_1.fswtw_.percent

				SetActive(arg_157_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_157_1:ShowNextGo(false)
			end

			local var_160_1 = 21
			local var_160_2 = 1.4
			local var_160_3, var_160_4 = arg_157_1:GetPercentByPara(arg_157_1:FormatText(arg_157_1:GetWordFromCfg(116292038).content), 1)

			if var_160_0 < arg_157_1.time_ and arg_157_1.time_ <= var_160_0 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0

				local var_160_5 = var_160_1 <= 0 and var_160_2 or var_160_2 * ((var_160_4 - arg_157_1.typewritterCharCountI18N) / var_160_1)

				if (var_160_1 <= 0 and var_160_2 or var_160_2 * ((var_160_4 - arg_157_1.typewritterCharCountI18N) / var_160_1)) > 0 and var_160_2 < var_160_5 then
					arg_157_1.talkMaxDuration = var_160_5

					if var_160_5 + var_160_0 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_5 + var_160_0
					end
				end
			end

			local var_160_6 = math.max(1.4, arg_157_1.talkMaxDuration)

			if var_160_0 <= arg_157_1.time_ and arg_157_1.time_ < var_160_0 + var_160_6 then
				arg_157_1.fswtw_.percent = Mathf.Lerp(arg_157_1.var_.oldValueTypewriter, var_160_3, (arg_157_1.time_ - var_160_0) / var_160_6)
				arg_157_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_157_1.fswtw_:SetDirty()
			end

			if arg_157_1.time_ >= var_160_0 + var_160_6 and arg_157_1.time_ < var_160_0 + var_160_6 + arg_160_0 then
				arg_157_1.fswtw_.percent = var_160_3

				arg_157_1.fswtw_:SetDirty()
				arg_157_1:ShowNextGo(true)

				arg_157_1.typewritterCharCountI18N = var_160_4
			end

			local var_160_7 = 0
			local var_160_8 = manager.audio:GetVoiceLength("story_v_out_116292", "116292038", "story_v_out_116292.awb") / 1000

			if var_160_8 > 0 and 3.554 < var_160_8 and var_160_8 + var_160_7 > arg_157_1.duration_ then
				arg_157_1.duration_ = var_160_8 + var_160_7
			end

			if var_160_7 < arg_157_1.time_ and arg_157_1.time_ <= var_160_7 + arg_160_0 then
				arg_157_1:AudioAction("play", "voice", "story_v_out_116292", "116292038", "story_v_out_116292.awb")
			end

			local var_160_10 = 0

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= var_160_10 + arg_160_0 then
				arg_157_1.allBtn_.enabled = false
			end

			if arg_157_1.time_ >= var_160_10 + 3.554 and arg_157_1.time_ < var_160_10 + 3.554 + arg_160_0 then
				arg_157_1.allBtn_.enabled = true
			end
		end

		arg_157_1.nodeConfigList_ = {}

		arg_157_1:InitPlayNodeList()
	end,
	Play116292039 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 116292039
		arg_161_1.duration_ = 2.77

		SetActive(arg_161_1.tipsGo_, false)

		function arg_161_1.onSingleLineFinish_()
			arg_161_1.onSingleLineUpdate_ = nil
			arg_161_1.onSingleLineFinish_ = nil
			arg_161_1.state_ = "waiting"
		end

		function arg_161_1.playNext_(arg_163_0)
			if arg_163_0 == 1 then
				arg_161_0:Play116292040(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1.var_.oldValueTypewriter = arg_161_1.fswtw_.percent

				SetActive(arg_161_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_161_1:ShowNextGo(false)
			end

			local var_164_0 = 19
			local var_164_1 = 1.26666666666667
			local var_164_2, var_164_3 = arg_161_1:GetPercentByPara(arg_161_1:FormatText(arg_161_1:GetWordFromCfg(116292038).content), 2)

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0

				local var_164_4 = var_164_0 <= 0 and var_164_1 or var_164_1 * ((var_164_3 - arg_161_1.typewritterCharCountI18N) / var_164_0)

				if (var_164_0 <= 0 and var_164_1 or var_164_1 * ((var_164_3 - arg_161_1.typewritterCharCountI18N) / var_164_0)) > 0 and var_164_1 < var_164_4 then
					arg_161_1.talkMaxDuration = var_164_4

					if var_164_4 + 0 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_4 + 0
					end
				end
			end

			local var_164_5 = math.max(1.26666666666667, arg_161_1.talkMaxDuration)

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_5 then
				arg_161_1.fswtw_.percent = Mathf.Lerp(arg_161_1.var_.oldValueTypewriter, var_164_2, (arg_161_1.time_ - 0) / var_164_5)
				arg_161_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_161_1.fswtw_:SetDirty()
			end

			if arg_161_1.time_ >= 0 + var_164_5 and arg_161_1.time_ < 0 + var_164_5 + arg_164_0 then
				arg_161_1.fswtw_.percent = var_164_2

				arg_161_1.fswtw_:SetDirty()
				arg_161_1:ShowNextGo(true)

				arg_161_1.typewritterCharCountI18N = var_164_3
			end

			local var_164_6 = 0
			local var_164_7 = manager.audio:GetVoiceLength("story_v_out_116292", "116292039", "story_v_out_116292.awb") / 1000

			if var_164_7 > 0 and 2.767 < var_164_7 and var_164_7 + var_164_6 > arg_161_1.duration_ then
				arg_161_1.duration_ = var_164_7 + var_164_6
			end

			if var_164_6 < arg_161_1.time_ and arg_161_1.time_ <= var_164_6 + arg_164_0 then
				arg_161_1:AudioAction("play", "voice", "story_v_out_116292", "116292039", "story_v_out_116292.awb")
			end

			local var_164_9 = 0

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= var_164_9 + arg_164_0 then
				arg_161_1.allBtn_.enabled = false
			end

			if arg_161_1.time_ >= var_164_9 + 1.26666666666667 and arg_161_1.time_ < var_164_9 + 1.26666666666667 + arg_164_0 then
				arg_161_1.allBtn_.enabled = true
			end
		end

		arg_161_1.nodeConfigList_ = {}

		arg_161_1:InitPlayNodeList()
	end,
	Play116292040 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 116292040
		arg_165_1.duration_ = 2.1

		SetActive(arg_165_1.tipsGo_, false)

		function arg_165_1.onSingleLineFinish_()
			arg_165_1.onSingleLineUpdate_ = nil
			arg_165_1.onSingleLineFinish_ = nil
			arg_165_1.state_ = "waiting"
		end

		function arg_165_1.playNext_(arg_167_0)
			if arg_167_0 == 1 then
				arg_165_0:Play116292041(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1.var_.oldValueTypewriter = arg_165_1.fswtw_.percent

				SetActive(arg_165_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_165_1:ShowNextGo(false)
			end

			local var_168_0 = 18
			local var_168_1 = 1.2
			local var_168_2, var_168_3 = arg_165_1:GetPercentByPara(arg_165_1:FormatText(arg_165_1:GetWordFromCfg(116292038).content), 3)

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

			local var_168_5 = math.max(1.2, arg_165_1.talkMaxDuration)

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

			local var_168_6 = 0
			local var_168_7 = manager.audio:GetVoiceLength("story_v_out_116292", "116292040", "story_v_out_116292.awb") / 1000

			if var_168_7 > 0 and 2.102 < var_168_7 and var_168_7 + var_168_6 > arg_165_1.duration_ then
				arg_165_1.duration_ = var_168_7 + var_168_6
			end

			if var_168_6 < arg_165_1.time_ and arg_165_1.time_ <= var_168_6 + arg_168_0 then
				arg_165_1:AudioAction("play", "voice", "story_v_out_116292", "116292040", "story_v_out_116292.awb")
			end

			local var_168_9 = 0

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= var_168_9 + arg_168_0 then
				arg_165_1.allBtn_.enabled = false
			end

			if arg_165_1.time_ >= var_168_9 + 1.2 and arg_165_1.time_ < var_168_9 + 1.2 + arg_168_0 then
				arg_165_1.allBtn_.enabled = true
			end
		end

		arg_165_1.nodeConfigList_ = {}

		arg_165_1:InitPlayNodeList()
	end,
	Play116292041 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 116292041
		arg_169_1.duration_ = 2.94

		SetActive(arg_169_1.tipsGo_, false)

		function arg_169_1.onSingleLineFinish_()
			arg_169_1.onSingleLineUpdate_ = nil
			arg_169_1.onSingleLineFinish_ = nil
			arg_169_1.state_ = "waiting"
		end

		function arg_169_1.playNext_(arg_171_0)
			if arg_171_0 == 1 then
				arg_169_0:Play116292042(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1.var_.oldValueTypewriter = arg_169_1.fswtw_.percent

				SetActive(arg_169_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_169_1:ShowNextGo(false)
			end

			local var_172_0 = 21
			local var_172_1 = 1.4
			local var_172_2, var_172_3 = arg_169_1:GetPercentByPara(arg_169_1:FormatText(arg_169_1:GetWordFromCfg(116292038).content), 4)

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

			local var_172_5 = math.max(1.4, arg_169_1.talkMaxDuration)

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

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1:AudioAction("play", "effect", "se_story_6", "se_story_6_blast", "")
			end

			local var_172_7 = 0
			local var_172_8 = manager.audio:GetVoiceLength("story_v_out_116292", "116292041", "story_v_out_116292.awb") / 1000

			if var_172_8 > 0 and 2.936 < var_172_8 and var_172_8 + var_172_7 > arg_169_1.duration_ then
				arg_169_1.duration_ = var_172_8 + var_172_7
			end

			if var_172_7 < arg_169_1.time_ and arg_169_1.time_ <= var_172_7 + arg_172_0 then
				arg_169_1:AudioAction("play", "voice", "story_v_out_116292", "116292041", "story_v_out_116292.awb")
			end

			local var_172_10 = 0

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= var_172_10 + arg_172_0 then
				arg_169_1.allBtn_.enabled = false
			end

			if arg_169_1.time_ >= var_172_10 + 1.4 and arg_169_1.time_ < var_172_10 + 1.4 + arg_172_0 then
				arg_169_1.allBtn_.enabled = true
			end
		end

		arg_169_1.nodeConfigList_ = {}

		arg_169_1:InitPlayNodeList()
	end,
	Play116292042 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 116292042
		arg_173_1.duration_ = 1.84

		SetActive(arg_173_1.tipsGo_, false)

		function arg_173_1.onSingleLineFinish_()
			arg_173_1.onSingleLineUpdate_ = nil
			arg_173_1.onSingleLineFinish_ = nil
			arg_173_1.state_ = "waiting"
		end

		function arg_173_1.playNext_(arg_175_0)
			if arg_175_0 == 1 then
				arg_173_0:Play116292043(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1.var_.oldValueTypewriter = arg_173_1.fswtw_.percent

				SetActive(arg_173_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_173_1:ShowNextGo(false)
			end

			local var_176_0 = 18
			local var_176_1 = 1.2
			local var_176_2, var_176_3 = arg_173_1:GetPercentByPara(arg_173_1:FormatText(arg_173_1:GetWordFromCfg(116292038).content), 5)

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0

				local var_176_4 = var_176_0 <= 0 and var_176_1 or var_176_1 * ((var_176_3 - arg_173_1.typewritterCharCountI18N) / var_176_0)

				if (var_176_0 <= 0 and var_176_1 or var_176_1 * ((var_176_3 - arg_173_1.typewritterCharCountI18N) / var_176_0)) > 0 and var_176_1 < var_176_4 then
					arg_173_1.talkMaxDuration = var_176_4

					if var_176_4 + 0 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_4 + 0
					end
				end
			end

			local var_176_5 = math.max(1.2, arg_173_1.talkMaxDuration)

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_5 then
				arg_173_1.fswtw_.percent = Mathf.Lerp(arg_173_1.var_.oldValueTypewriter, var_176_2, (arg_173_1.time_ - 0) / var_176_5)
				arg_173_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_173_1.fswtw_:SetDirty()
			end

			if arg_173_1.time_ >= 0 + var_176_5 and arg_173_1.time_ < 0 + var_176_5 + arg_176_0 then
				arg_173_1.fswtw_.percent = var_176_2

				arg_173_1.fswtw_:SetDirty()
				arg_173_1:ShowNextGo(true)

				arg_173_1.typewritterCharCountI18N = var_176_3
			end

			local var_176_6 = 0
			local var_176_7 = manager.audio:GetVoiceLength("story_v_out_116292", "116292042", "story_v_out_116292.awb") / 1000

			if var_176_7 > 0 and 1.844 < var_176_7 and var_176_7 + var_176_6 > arg_173_1.duration_ then
				arg_173_1.duration_ = var_176_7 + var_176_6
			end

			if var_176_6 < arg_173_1.time_ and arg_173_1.time_ <= var_176_6 + arg_176_0 then
				arg_173_1:AudioAction("play", "voice", "story_v_out_116292", "116292042", "story_v_out_116292.awb")
			end

			local var_176_9 = 0

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= var_176_9 + arg_176_0 then
				arg_173_1.allBtn_.enabled = false
			end

			if arg_173_1.time_ >= var_176_9 + 1.2 and arg_173_1.time_ < var_176_9 + 1.2 + arg_176_0 then
				arg_173_1.allBtn_.enabled = true
			end
		end

		arg_173_1.nodeConfigList_ = {}

		arg_173_1:InitPlayNodeList()
	end,
	Play116292043 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 116292043
		arg_177_1.duration_ = 8.13

		SetActive(arg_177_1.tipsGo_, false)

		function arg_177_1.onSingleLineFinish_()
			arg_177_1.onSingleLineUpdate_ = nil
			arg_177_1.onSingleLineFinish_ = nil
			arg_177_1.state_ = "waiting"
		end

		function arg_177_1.playNext_(arg_179_0)
			if arg_179_0 == 1 then
				arg_177_0:Play116292044(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				local var_180_0 = arg_177_1.bgs_.STblack

				arg_177_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_180_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_180_1 = var_180_0:GetComponent("SpriteRenderer")

				if var_180_1 and var_180_1.sprite then
					local var_180_2 = 2 * (var_180_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_180_0.transform.localScale = Vector3.New(var_180_2 / var_180_1.sprite.bounds.size.y < var_180_2 * manager.ui.mainCameraCom_.aspect / var_180_1.sprite.bounds.size.x and var_180_2 * manager.ui.mainCameraCom_.aspect / var_180_1.sprite.bounds.size.x or var_180_2 / var_180_1.sprite.bounds.size.y, var_180_2 / var_180_1.sprite.bounds.size.y < var_180_2 * manager.ui.mainCameraCom_.aspect / var_180_1.sprite.bounds.size.x and var_180_2 * manager.ui.mainCameraCom_.aspect / var_180_1.sprite.bounds.size.x or var_180_2 / var_180_1.sprite.bounds.size.y, 0)
				end

				for iter_180_0, iter_180_1 in pairs(arg_177_1.bgs_) do
					if iter_180_0 ~= "STblack" then
						iter_180_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 1.983333 < arg_177_1.time_ and arg_177_1.time_ <= 1.983333 + arg_180_0 then
				arg_177_1.fswbg_:SetActive(false)
				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_177_1:ShowNextGo(false)
			end

			local var_180_3 = 2
			local var_180_4 = manager.audio:GetVoiceLength("story_v_out_116292", "116292043", "story_v_out_116292.awb") / 1000

			if var_180_4 > 0 and 3.464 < var_180_4 and var_180_4 + var_180_3 > arg_177_1.duration_ then
				arg_177_1.duration_ = var_180_4 + var_180_3
			end

			if var_180_3 < arg_177_1.time_ and arg_177_1.time_ <= var_180_3 + arg_180_0 then
				arg_177_1:AudioAction("play", "voice", "story_v_out_116292", "116292043", "story_v_out_116292.awb")
			end

			local var_180_6 = 0

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= var_180_6 + arg_180_0 then
				arg_177_1.mask_.enabled = true
				arg_177_1.mask_.raycastTarget = true

				arg_177_1:SetGaussion(false)
			end

			local var_180_7 = 2

			if var_180_6 <= arg_177_1.time_ and arg_177_1.time_ < var_180_6 + var_180_7 then
				local var_180_8 = Color.New(0, 0, 0)

				var_180_8.a = Mathf.Lerp(0, 1, (arg_177_1.time_ - var_180_6) / var_180_7)
				arg_177_1.mask_.color = var_180_8
			end

			if arg_177_1.time_ >= var_180_6 + var_180_7 and arg_177_1.time_ < var_180_6 + var_180_7 + arg_180_0 then
				local var_180_9 = Color.New(0, 0, 0)

				var_180_9.a = 1
				arg_177_1.mask_.color = var_180_9
			end

			local var_180_10 = 2

			if 2 < arg_177_1.time_ and arg_177_1.time_ <= var_180_10 + arg_180_0 then
				arg_177_1.mask_.enabled = true
				arg_177_1.mask_.raycastTarget = true

				arg_177_1:SetGaussion(false)
			end

			local var_180_11 = 2

			if var_180_10 <= arg_177_1.time_ and arg_177_1.time_ < var_180_10 + var_180_11 then
				local var_180_12 = Color.New(0, 0, 0)

				var_180_12.a = Mathf.Lerp(1, 0, (arg_177_1.time_ - var_180_10) / var_180_11)
				arg_177_1.mask_.color = var_180_12
			end

			if arg_177_1.time_ >= var_180_10 + var_180_11 and arg_177_1.time_ < var_180_10 + var_180_11 + arg_180_0 then
				local var_180_13 = Color.New(0, 0, 0)

				arg_177_1.mask_.enabled = false
				var_180_13.a = 0
				arg_177_1.mask_.color = var_180_13
			end

			if arg_177_1.frameCnt_ <= 1 then
				arg_177_1.dialog_:SetActive(false)
			end

			local var_180_14 = 1.983333
			local var_180_15 = 0.15

			if 1.983333 < arg_177_1.time_ and arg_177_1.time_ <= var_180_14 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0

				arg_177_1.dialog_:SetActive(true)

				arg_177_1.dialogCg_.alpha = 0

				local var_180_16 = LeanTween.value(arg_177_1.dialog_, 0, 1, 0.3)

				var_180_16:setOnUpdate(LuaHelper.FloatAction(function(arg_181_0)
					arg_177_1.dialogCg_.alpha = arg_181_0
				end))
				var_180_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_177_1.dialog_)
					var_180_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_177_1.duration_ = arg_177_1.duration_ + 0.3

				SetActive(arg_177_1.leftNameGo_, true)

				arg_177_1.leftNameTxt_.text = arg_177_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, true)
				arg_177_1.iconController_:SetSelectedState("hero")

				arg_177_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1148")

				arg_177_1.callingController_:SetSelectedState("normal")

				arg_177_1.keyicon_.color = Color.New(1, 1, 1)
				arg_177_1.icon_.color = Color.New(1, 1, 1)

				local var_180_17 = arg_177_1:GetWordFromCfg(116292043)
				local var_180_18 = arg_177_1:FormatText(var_180_17.content)

				arg_177_1.text_.text = var_180_18

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_20 = 6 <= 0 and var_180_15 or var_180_15 * (utf8.len(var_180_18) / 6)

				if (6 <= 0 and var_180_15 or var_180_15 * (utf8.len(var_180_18) / 6)) > 0 and var_180_15 < var_180_20 then
					arg_177_1.talkMaxDuration = var_180_20
					var_180_14 = var_180_14 + 0.3

					if var_180_20 + var_180_14 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_20 + var_180_14
					end
				end

				arg_177_1.text_.text = var_180_18
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116292", "116292043", "story_v_out_116292.awb") ~= 0 then
					local var_180_21 = manager.audio:GetVoiceLength("story_v_out_116292", "116292043", "story_v_out_116292.awb") / 1000

					if var_180_21 + var_180_14 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_21 + var_180_14
					end

					if var_180_17.prefab_name ~= "" and arg_177_1.actors_[var_180_17.prefab_name] ~= nil then
						local var_180_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_177_1.actors_[var_180_17.prefab_name].transform, "story_v_out_116292", "116292043", "story_v_out_116292.awb")

						arg_177_1:RecordAudio("116292043", var_180_22)
						arg_177_1:RecordAudio("116292043", var_180_22)
					else
						arg_177_1:AudioAction("play", "voice", "story_v_out_116292", "116292043", "story_v_out_116292.awb")
					end

					arg_177_1:RecordHistoryTalkVoice("story_v_out_116292", "116292043", "story_v_out_116292.awb")
				end

				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_23 = var_180_14 + 0.3
			local var_180_24 = math.max(var_180_15, arg_177_1.talkMaxDuration)

			if var_180_14 + 0.3 <= arg_177_1.time_ and arg_177_1.time_ < var_180_23 + var_180_24 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - var_180_23) / var_180_24

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= var_180_23 + var_180_24 and arg_177_1.time_ < var_180_23 + var_180_24 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {}

		arg_177_1:InitPlayNodeList()
	end,
	Play116292044 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 116292044
		arg_183_1.duration_ = 6.83

		local var_183_0 = {
			zh = 5.733,
			ja = 6.833
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
				arg_183_0:Play116292045(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			if arg_183_1.bgs_.SK0204a == nil then
				local var_186_0 = Object.Instantiate(arg_183_1.paintGo_)

				var_186_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "SK0204a")
				var_186_0.name = "SK0204a"
				var_186_0.transform.parent = arg_183_1.stage_.transform
				var_186_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_183_1.bgs_.SK0204a = var_186_0
			end

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				local var_186_1 = arg_183_1.bgs_.SK0204a

				arg_183_1.bgs_.SK0204a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_186_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_186_2 = var_186_1:GetComponent("SpriteRenderer")

				if var_186_2 and var_186_2.sprite then
					local var_186_3 = 2 * (var_186_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_186_1.transform.localScale = Vector3.New(var_186_3 / var_186_2.sprite.bounds.size.y < var_186_3 * manager.ui.mainCameraCom_.aspect / var_186_2.sprite.bounds.size.x and var_186_3 * manager.ui.mainCameraCom_.aspect / var_186_2.sprite.bounds.size.x or var_186_3 / var_186_2.sprite.bounds.size.y, var_186_3 / var_186_2.sprite.bounds.size.y < var_186_3 * manager.ui.mainCameraCom_.aspect / var_186_2.sprite.bounds.size.x and var_186_3 * manager.ui.mainCameraCom_.aspect / var_186_2.sprite.bounds.size.x or var_186_3 / var_186_2.sprite.bounds.size.y, 0)
				end

				for iter_186_0, iter_186_1 in pairs(arg_183_1.bgs_) do
					if iter_186_0 ~= "SK0204a" then
						iter_186_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_186_4 = 0

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= var_186_4 + arg_186_0 then
				arg_183_1.mask_.enabled = true
				arg_183_1.mask_.raycastTarget = true

				arg_183_1:SetGaussion(false)
			end

			local var_186_5 = 3

			if var_186_4 <= arg_183_1.time_ and arg_183_1.time_ < var_186_4 + var_186_5 then
				local var_186_6 = Color.New(0, 0, 0)

				var_186_6.a = Mathf.Lerp(1, 0, (arg_183_1.time_ - var_186_4) / var_186_5)
				arg_183_1.mask_.color = var_186_6
			end

			if arg_183_1.time_ >= var_186_4 + var_186_5 and arg_183_1.time_ < var_186_4 + var_186_5 + arg_186_0 then
				local var_186_7 = Color.New(0, 0, 0)

				arg_183_1.mask_.enabled = false
				var_186_7.a = 0
				arg_183_1.mask_.color = var_186_7
			end

			local var_186_8 = 0

			arg_183_1.isInRecall_ = false

			if var_186_8 < arg_183_1.time_ and arg_183_1.time_ <= var_186_8 + arg_186_0 then
				arg_183_1.screenFilterGo_:SetActive(true)

				arg_183_1.screenFilterEffect_.profile = Asset.Load("Effect/Scene/fx_vintageStyle_Profile")

				for iter_186_2, iter_186_3 in pairs(arg_183_1.actors_) do
					for iter_186_4, iter_186_5 in ipairs((iter_186_3:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_186_5.color = iter_186_5.color.r > 0.51 and Color.New(1, 1, 1) or Color.New(0.5, 0.5, 0.5)
					end
				end
			end

			local var_186_9 = 0.0166666666666667

			if var_186_8 <= arg_183_1.time_ and arg_183_1.time_ < var_186_8 + var_186_9 then
				arg_183_1.screenFilterEffect_.weight = Mathf.Lerp(0, 1, (arg_183_1.time_ - var_186_8) / var_186_9)
			end

			if arg_183_1.time_ >= var_186_8 + var_186_9 and arg_183_1.time_ < var_186_8 + var_186_9 + arg_186_0 then
				arg_183_1.screenFilterEffect_.weight = 1
			end

			if arg_183_1.frameCnt_ <= 1 then
				arg_183_1.dialog_:SetActive(false)
			end

			local var_186_10 = 3
			local var_186_11 = 0.2

			if 3 < arg_183_1.time_ and arg_183_1.time_ <= var_186_10 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0

				arg_183_1.dialog_:SetActive(true)

				arg_183_1.dialogCg_.alpha = 0

				local var_186_12 = LeanTween.value(arg_183_1.dialog_, 0, 1, 0.3)

				var_186_12:setOnUpdate(LuaHelper.FloatAction(function(arg_187_0)
					arg_183_1.dialogCg_.alpha = arg_187_0
				end))
				var_186_12:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_183_1.dialog_)
					var_186_12:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_183_1.duration_ = arg_183_1.duration_ + 0.3

				SetActive(arg_183_1.leftNameGo_, true)

				arg_183_1.leftNameTxt_.text = arg_183_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_183_1.leftNameTxt_.transform)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1.leftNameTxt_.text)
				SetActive(arg_183_1.iconTrs_.gameObject, false)
				arg_183_1.callingController_:SetSelectedState("normal")

				local var_186_13 = arg_183_1:GetWordFromCfg(116292044)
				local var_186_14 = arg_183_1:FormatText(var_186_13.content)

				arg_183_1.text_.text = var_186_14

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_16 = 8 <= 0 and var_186_11 or var_186_11 * (utf8.len(var_186_14) / 8)

				if (8 <= 0 and var_186_11 or var_186_11 * (utf8.len(var_186_14) / 8)) > 0 and var_186_11 < var_186_16 then
					arg_183_1.talkMaxDuration = var_186_16
					var_186_10 = var_186_10 + 0.3

					if var_186_16 + var_186_10 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_16 + var_186_10
					end
				end

				arg_183_1.text_.text = var_186_14
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116292", "116292044", "story_v_out_116292.awb") ~= 0 then
					local var_186_17 = manager.audio:GetVoiceLength("story_v_out_116292", "116292044", "story_v_out_116292.awb") / 1000

					if var_186_17 + var_186_10 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_17 + var_186_10
					end

					if var_186_13.prefab_name ~= "" and arg_183_1.actors_[var_186_13.prefab_name] ~= nil then
						local var_186_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_183_1.actors_[var_186_13.prefab_name].transform, "story_v_out_116292", "116292044", "story_v_out_116292.awb")

						arg_183_1:RecordAudio("116292044", var_186_18)
						arg_183_1:RecordAudio("116292044", var_186_18)
					else
						arg_183_1:AudioAction("play", "voice", "story_v_out_116292", "116292044", "story_v_out_116292.awb")
					end

					arg_183_1:RecordHistoryTalkVoice("story_v_out_116292", "116292044", "story_v_out_116292.awb")
				end

				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_19 = var_186_10 + 0.3
			local var_186_20 = math.max(var_186_11, arg_183_1.talkMaxDuration)

			if var_186_10 + 0.3 <= arg_183_1.time_ and arg_183_1.time_ < var_186_19 + var_186_20 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - var_186_19) / var_186_20

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= var_186_19 + var_186_20 and arg_183_1.time_ < var_186_19 + var_186_20 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {}

		arg_183_1:InitPlayNodeList()
	end,
	Play116292045 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 116292045
		arg_189_1.duration_ = 7.7

		local var_189_0 = {
			zh = 7.7,
			ja = 6.966
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
				arg_189_0:Play116292046(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			local var_192_0 = 0.75

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				arg_189_1.leftNameTxt_.text = arg_189_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_1 = arg_189_1:GetWordFromCfg(116292045)
				local var_192_2 = arg_189_1:FormatText(var_192_1.content)

				arg_189_1.text_.text = var_192_2

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_4 = 30 <= 0 and var_192_0 or var_192_0 * (utf8.len(var_192_2) / 30)

				if (30 <= 0 and var_192_0 or var_192_0 * (utf8.len(var_192_2) / 30)) > 0 and var_192_0 < var_192_4 then
					arg_189_1.talkMaxDuration = var_192_4

					if var_192_4 + 0 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_4 + 0
					end
				end

				arg_189_1.text_.text = var_192_2
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116292", "116292045", "story_v_out_116292.awb") ~= 0 then
					local var_192_5 = manager.audio:GetVoiceLength("story_v_out_116292", "116292045", "story_v_out_116292.awb") / 1000

					if var_192_5 + 0 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_5 + 0
					end

					if var_192_1.prefab_name ~= "" and arg_189_1.actors_[var_192_1.prefab_name] ~= nil then
						local var_192_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_189_1.actors_[var_192_1.prefab_name].transform, "story_v_out_116292", "116292045", "story_v_out_116292.awb")

						arg_189_1:RecordAudio("116292045", var_192_6)
						arg_189_1:RecordAudio("116292045", var_192_6)
					else
						arg_189_1:AudioAction("play", "voice", "story_v_out_116292", "116292045", "story_v_out_116292.awb")
					end

					arg_189_1:RecordHistoryTalkVoice("story_v_out_116292", "116292045", "story_v_out_116292.awb")
				end

				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_7 = math.max(var_192_0, arg_189_1.talkMaxDuration)

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_7 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - 0) / var_192_7

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= 0 + var_192_7 and arg_189_1.time_ < 0 + var_192_7 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {}

		arg_189_1:InitPlayNodeList()
	end,
	Play116292046 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 116292046
		arg_193_1.duration_ = 6

		local var_193_0 = {
			zh = 6,
			ja = 2.966
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
				arg_193_0:Play116292047(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			local var_196_0 = 0.45

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, true)

				arg_193_1.leftNameTxt_.text = arg_193_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_193_1.leftNameTxt_.transform)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1.leftNameTxt_.text)
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_1 = arg_193_1:GetWordFromCfg(116292046)
				local var_196_2 = arg_193_1:FormatText(var_196_1.content)

				arg_193_1.text_.text = var_196_2

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_4 = 18 <= 0 and var_196_0 or var_196_0 * (utf8.len(var_196_2) / 18)

				if (18 <= 0 and var_196_0 or var_196_0 * (utf8.len(var_196_2) / 18)) > 0 and var_196_0 < var_196_4 then
					arg_193_1.talkMaxDuration = var_196_4

					if var_196_4 + 0 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_4 + 0
					end
				end

				arg_193_1.text_.text = var_196_2
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116292", "116292046", "story_v_out_116292.awb") ~= 0 then
					local var_196_5 = manager.audio:GetVoiceLength("story_v_out_116292", "116292046", "story_v_out_116292.awb") / 1000

					if var_196_5 + 0 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_5 + 0
					end

					if var_196_1.prefab_name ~= "" and arg_193_1.actors_[var_196_1.prefab_name] ~= nil then
						local var_196_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_193_1.actors_[var_196_1.prefab_name].transform, "story_v_out_116292", "116292046", "story_v_out_116292.awb")

						arg_193_1:RecordAudio("116292046", var_196_6)
						arg_193_1:RecordAudio("116292046", var_196_6)
					else
						arg_193_1:AudioAction("play", "voice", "story_v_out_116292", "116292046", "story_v_out_116292.awb")
					end

					arg_193_1:RecordHistoryTalkVoice("story_v_out_116292", "116292046", "story_v_out_116292.awb")
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
	Play116292047 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 116292047
		arg_197_1.duration_ = 12.63

		local var_197_0 = {
			zh = 8.8,
			ja = 12.633
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
				arg_197_0:Play116292048(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			local var_200_0 = 0.925

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, true)

				arg_197_1.leftNameTxt_.text = arg_197_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, false)
				arg_197_1.callingController_:SetSelectedState("normal")

				local var_200_1 = arg_197_1:GetWordFromCfg(116292047)
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

				if manager.audio:GetVoiceLength("story_v_out_116292", "116292047", "story_v_out_116292.awb") ~= 0 then
					local var_200_5 = manager.audio:GetVoiceLength("story_v_out_116292", "116292047", "story_v_out_116292.awb") / 1000

					if var_200_5 + 0 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_5 + 0
					end

					if var_200_1.prefab_name ~= "" and arg_197_1.actors_[var_200_1.prefab_name] ~= nil then
						local var_200_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_197_1.actors_[var_200_1.prefab_name].transform, "story_v_out_116292", "116292047", "story_v_out_116292.awb")

						arg_197_1:RecordAudio("116292047", var_200_6)
						arg_197_1:RecordAudio("116292047", var_200_6)
					else
						arg_197_1:AudioAction("play", "voice", "story_v_out_116292", "116292047", "story_v_out_116292.awb")
					end

					arg_197_1:RecordHistoryTalkVoice("story_v_out_116292", "116292047", "story_v_out_116292.awb")
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
	Play116292048 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 116292048
		arg_201_1.duration_ = 3.4

		local var_201_0 = {
			zh = 2.7,
			ja = 3.4
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
				arg_201_0:Play116292049(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			local var_204_0 = 0.225

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, true)

				arg_201_1.leftNameTxt_.text = arg_201_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_201_1.leftNameTxt_.transform)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1.leftNameTxt_.text)
				SetActive(arg_201_1.iconTrs_.gameObject, false)
				arg_201_1.callingController_:SetSelectedState("normal")

				local var_204_1 = arg_201_1:GetWordFromCfg(116292048)
				local var_204_2 = arg_201_1:FormatText(var_204_1.content)

				arg_201_1.text_.text = var_204_2

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_4 = 9 <= 0 and var_204_0 or var_204_0 * (utf8.len(var_204_2) / 9)

				if (9 <= 0 and var_204_0 or var_204_0 * (utf8.len(var_204_2) / 9)) > 0 and var_204_0 < var_204_4 then
					arg_201_1.talkMaxDuration = var_204_4

					if var_204_4 + 0 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_4 + 0
					end
				end

				arg_201_1.text_.text = var_204_2
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116292", "116292048", "story_v_out_116292.awb") ~= 0 then
					local var_204_5 = manager.audio:GetVoiceLength("story_v_out_116292", "116292048", "story_v_out_116292.awb") / 1000

					if var_204_5 + 0 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_5 + 0
					end

					if var_204_1.prefab_name ~= "" and arg_201_1.actors_[var_204_1.prefab_name] ~= nil then
						local var_204_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_201_1.actors_[var_204_1.prefab_name].transform, "story_v_out_116292", "116292048", "story_v_out_116292.awb")

						arg_201_1:RecordAudio("116292048", var_204_6)
						arg_201_1:RecordAudio("116292048", var_204_6)
					else
						arg_201_1:AudioAction("play", "voice", "story_v_out_116292", "116292048", "story_v_out_116292.awb")
					end

					arg_201_1:RecordHistoryTalkVoice("story_v_out_116292", "116292048", "story_v_out_116292.awb")
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
	Play116292049 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 116292049
		arg_205_1.duration_ = 10.63

		local var_205_0 = {
			zh = 10.633,
			ja = 4.4
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
				arg_205_0:Play116292050(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			local var_208_0 = 1

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, true)

				arg_205_1.leftNameTxt_.text = arg_205_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_205_1.leftNameTxt_.transform)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1.leftNameTxt_.text)
				SetActive(arg_205_1.iconTrs_.gameObject, false)
				arg_205_1.callingController_:SetSelectedState("normal")

				local var_208_1 = arg_205_1:GetWordFromCfg(116292049)
				local var_208_2 = arg_205_1:FormatText(var_208_1.content)

				arg_205_1.text_.text = var_208_2

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_4 = 40 <= 0 and var_208_0 or var_208_0 * (utf8.len(var_208_2) / 40)

				if (40 <= 0 and var_208_0 or var_208_0 * (utf8.len(var_208_2) / 40)) > 0 and var_208_0 < var_208_4 then
					arg_205_1.talkMaxDuration = var_208_4

					if var_208_4 + 0 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_4 + 0
					end
				end

				arg_205_1.text_.text = var_208_2
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116292", "116292049", "story_v_out_116292.awb") ~= 0 then
					local var_208_5 = manager.audio:GetVoiceLength("story_v_out_116292", "116292049", "story_v_out_116292.awb") / 1000

					if var_208_5 + 0 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_5 + 0
					end

					if var_208_1.prefab_name ~= "" and arg_205_1.actors_[var_208_1.prefab_name] ~= nil then
						local var_208_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_205_1.actors_[var_208_1.prefab_name].transform, "story_v_out_116292", "116292049", "story_v_out_116292.awb")

						arg_205_1:RecordAudio("116292049", var_208_6)
						arg_205_1:RecordAudio("116292049", var_208_6)
					else
						arg_205_1:AudioAction("play", "voice", "story_v_out_116292", "116292049", "story_v_out_116292.awb")
					end

					arg_205_1:RecordHistoryTalkVoice("story_v_out_116292", "116292049", "story_v_out_116292.awb")
				end

				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_7 = math.max(var_208_0, arg_205_1.talkMaxDuration)

			if 0 <= arg_205_1.time_ and arg_205_1.time_ < 0 + var_208_7 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - 0) / var_208_7

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= 0 + var_208_7 and arg_205_1.time_ < 0 + var_208_7 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {}

		arg_205_1:InitPlayNodeList()
	end,
	Play116292050 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 116292050
		arg_209_1.duration_ = 4.7

		local var_209_0 = {
			zh = 2.8,
			ja = 4.7
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
				arg_209_0:Play116292051(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			local var_212_0 = 0.325

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, true)

				arg_209_1.leftNameTxt_.text = arg_209_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_209_1.leftNameTxt_.transform)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1.leftNameTxt_.text)
				SetActive(arg_209_1.iconTrs_.gameObject, true)
				arg_209_1.iconController_:SetSelectedState("hero")

				arg_209_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1059")

				arg_209_1.callingController_:SetSelectedState("normal")

				arg_209_1.keyicon_.color = Color.New(1, 1, 1)
				arg_209_1.icon_.color = Color.New(1, 1, 1)

				local var_212_1 = arg_209_1:GetWordFromCfg(116292050)
				local var_212_2 = arg_209_1:FormatText(var_212_1.content)

				arg_209_1.text_.text = var_212_2

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_4 = 13 <= 0 and var_212_0 or var_212_0 * (utf8.len(var_212_2) / 13)

				if (13 <= 0 and var_212_0 or var_212_0 * (utf8.len(var_212_2) / 13)) > 0 and var_212_0 < var_212_4 then
					arg_209_1.talkMaxDuration = var_212_4

					if var_212_4 + 0 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_4 + 0
					end
				end

				arg_209_1.text_.text = var_212_2
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116292", "116292050", "story_v_out_116292.awb") ~= 0 then
					local var_212_5 = manager.audio:GetVoiceLength("story_v_out_116292", "116292050", "story_v_out_116292.awb") / 1000

					if var_212_5 + 0 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_5 + 0
					end

					if var_212_1.prefab_name ~= "" and arg_209_1.actors_[var_212_1.prefab_name] ~= nil then
						local var_212_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_209_1.actors_[var_212_1.prefab_name].transform, "story_v_out_116292", "116292050", "story_v_out_116292.awb")

						arg_209_1:RecordAudio("116292050", var_212_6)
						arg_209_1:RecordAudio("116292050", var_212_6)
					else
						arg_209_1:AudioAction("play", "voice", "story_v_out_116292", "116292050", "story_v_out_116292.awb")
					end

					arg_209_1:RecordHistoryTalkVoice("story_v_out_116292", "116292050", "story_v_out_116292.awb")
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
	Play116292051 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 116292051
		arg_213_1.duration_ = 5.23

		local var_213_0 = {
			zh = 5.233,
			ja = 2.133
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
				arg_213_0:Play116292052(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			local var_216_0 = 0.4

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, true)

				arg_213_1.leftNameTxt_.text = arg_213_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_213_1.leftNameTxt_.transform)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1.leftNameTxt_.text)
				SetActive(arg_213_1.iconTrs_.gameObject, false)
				arg_213_1.callingController_:SetSelectedState("normal")

				local var_216_1 = arg_213_1:GetWordFromCfg(116292051)
				local var_216_2 = arg_213_1:FormatText(var_216_1.content)

				arg_213_1.text_.text = var_216_2

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_4 = 16 <= 0 and var_216_0 or var_216_0 * (utf8.len(var_216_2) / 16)

				if (16 <= 0 and var_216_0 or var_216_0 * (utf8.len(var_216_2) / 16)) > 0 and var_216_0 < var_216_4 then
					arg_213_1.talkMaxDuration = var_216_4

					if var_216_4 + 0 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_4 + 0
					end
				end

				arg_213_1.text_.text = var_216_2
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116292", "116292051", "story_v_out_116292.awb") ~= 0 then
					local var_216_5 = manager.audio:GetVoiceLength("story_v_out_116292", "116292051", "story_v_out_116292.awb") / 1000

					if var_216_5 + 0 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_5 + 0
					end

					if var_216_1.prefab_name ~= "" and arg_213_1.actors_[var_216_1.prefab_name] ~= nil then
						local var_216_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_213_1.actors_[var_216_1.prefab_name].transform, "story_v_out_116292", "116292051", "story_v_out_116292.awb")

						arg_213_1:RecordAudio("116292051", var_216_6)
						arg_213_1:RecordAudio("116292051", var_216_6)
					else
						arg_213_1:AudioAction("play", "voice", "story_v_out_116292", "116292051", "story_v_out_116292.awb")
					end

					arg_213_1:RecordHistoryTalkVoice("story_v_out_116292", "116292051", "story_v_out_116292.awb")
				end

				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_7 = math.max(var_216_0, arg_213_1.talkMaxDuration)

			if 0 <= arg_213_1.time_ and arg_213_1.time_ < 0 + var_216_7 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - 0) / var_216_7

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= 0 + var_216_7 and arg_213_1.time_ < 0 + var_216_7 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {}

		arg_213_1:InitPlayNodeList()
	end,
	Play116292052 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 116292052
		arg_217_1.duration_ = 3.6

		local var_217_0 = {
			zh = 3.6,
			ja = 2.466
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
				arg_217_0:Play116292053(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			local var_220_0 = 0.175

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0
				arg_217_1.dialogCg_.alpha = 1

				arg_217_1.dialog_:SetActive(true)
				SetActive(arg_217_1.leftNameGo_, true)

				arg_217_1.leftNameTxt_.text = arg_217_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_217_1.leftNameTxt_.transform)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1.leftNameTxt_.text)
				SetActive(arg_217_1.iconTrs_.gameObject, false)
				arg_217_1.callingController_:SetSelectedState("normal")

				local var_220_1 = arg_217_1:GetWordFromCfg(116292052)
				local var_220_2 = arg_217_1:FormatText(var_220_1.content)

				arg_217_1.text_.text = var_220_2

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_4 = 7 <= 0 and var_220_0 or var_220_0 * (utf8.len(var_220_2) / 7)

				if (7 <= 0 and var_220_0 or var_220_0 * (utf8.len(var_220_2) / 7)) > 0 and var_220_0 < var_220_4 then
					arg_217_1.talkMaxDuration = var_220_4

					if var_220_4 + 0 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_4 + 0
					end
				end

				arg_217_1.text_.text = var_220_2
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116292", "116292052", "story_v_out_116292.awb") ~= 0 then
					local var_220_5 = manager.audio:GetVoiceLength("story_v_out_116292", "116292052", "story_v_out_116292.awb") / 1000

					if var_220_5 + 0 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_5 + 0
					end

					if var_220_1.prefab_name ~= "" and arg_217_1.actors_[var_220_1.prefab_name] ~= nil then
						local var_220_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_217_1.actors_[var_220_1.prefab_name].transform, "story_v_out_116292", "116292052", "story_v_out_116292.awb")

						arg_217_1:RecordAudio("116292052", var_220_6)
						arg_217_1:RecordAudio("116292052", var_220_6)
					else
						arg_217_1:AudioAction("play", "voice", "story_v_out_116292", "116292052", "story_v_out_116292.awb")
					end

					arg_217_1:RecordHistoryTalkVoice("story_v_out_116292", "116292052", "story_v_out_116292.awb")
				end

				arg_217_1:RecordContent(arg_217_1.text_.text)
			end

			local var_220_7 = math.max(var_220_0, arg_217_1.talkMaxDuration)

			if 0 <= arg_217_1.time_ and arg_217_1.time_ < 0 + var_220_7 then
				arg_217_1.typewritter.percent = (arg_217_1.time_ - 0) / var_220_7

				arg_217_1.typewritter:SetDirty()
			end

			if arg_217_1.time_ >= 0 + var_220_7 and arg_217_1.time_ < 0 + var_220_7 + arg_220_0 then
				arg_217_1.typewritter.percent = 1

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(true)
			end
		end

		arg_217_1.nodeConfigList_ = {}

		arg_217_1:InitPlayNodeList()
	end,
	Play116292053 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 116292053
		arg_221_1.duration_ = 13.47

		local var_221_0 = {
			zh = 13.466,
			ja = 10.6
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
				arg_221_0:Play116292054(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			if 2 < arg_221_1.time_ and arg_221_1.time_ <= 2 + arg_224_0 then
				local var_224_0 = arg_221_1.bgs_.B13c

				arg_221_1.bgs_.B13c.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_224_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_224_1 = var_224_0:GetComponent("SpriteRenderer")

				if var_224_1 and var_224_1.sprite then
					local var_224_2 = 2 * (var_224_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_224_0.transform.localScale = Vector3.New(var_224_2 / var_224_1.sprite.bounds.size.y < var_224_2 * manager.ui.mainCameraCom_.aspect / var_224_1.sprite.bounds.size.x and var_224_2 * manager.ui.mainCameraCom_.aspect / var_224_1.sprite.bounds.size.x or var_224_2 / var_224_1.sprite.bounds.size.y, var_224_2 / var_224_1.sprite.bounds.size.y < var_224_2 * manager.ui.mainCameraCom_.aspect / var_224_1.sprite.bounds.size.x and var_224_2 * manager.ui.mainCameraCom_.aspect / var_224_1.sprite.bounds.size.x or var_224_2 / var_224_1.sprite.bounds.size.y, 0)
				end

				for iter_224_0, iter_224_1 in pairs(arg_221_1.bgs_) do
					if iter_224_0 ~= "B13c" then
						iter_224_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_224_3 = 0

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= var_224_3 + arg_224_0 then
				arg_221_1.mask_.enabled = true
				arg_221_1.mask_.raycastTarget = true

				arg_221_1:SetGaussion(false)
			end

			local var_224_4 = 2

			if var_224_3 <= arg_221_1.time_ and arg_221_1.time_ < var_224_3 + var_224_4 then
				local var_224_5 = Color.New(0, 0, 0)

				var_224_5.a = Mathf.Lerp(0, 1, (arg_221_1.time_ - var_224_3) / var_224_4)
				arg_221_1.mask_.color = var_224_5
			end

			if arg_221_1.time_ >= var_224_3 + var_224_4 and arg_221_1.time_ < var_224_3 + var_224_4 + arg_224_0 then
				local var_224_6 = Color.New(0, 0, 0)

				var_224_6.a = 1
				arg_221_1.mask_.color = var_224_6
			end

			local var_224_7 = 2

			if 2 < arg_221_1.time_ and arg_221_1.time_ <= var_224_7 + arg_224_0 then
				arg_221_1.mask_.enabled = true
				arg_221_1.mask_.raycastTarget = true

				arg_221_1:SetGaussion(false)
			end

			local var_224_8 = 2

			if var_224_7 <= arg_221_1.time_ and arg_221_1.time_ < var_224_7 + var_224_8 then
				local var_224_9 = Color.New(0, 0, 0)

				var_224_9.a = Mathf.Lerp(1, 0, (arg_221_1.time_ - var_224_7) / var_224_8)
				arg_221_1.mask_.color = var_224_9
			end

			if arg_221_1.time_ >= var_224_7 + var_224_8 and arg_221_1.time_ < var_224_7 + var_224_8 + arg_224_0 then
				local var_224_10 = Color.New(0, 0, 0)

				arg_221_1.mask_.enabled = false
				var_224_10.a = 0
				arg_221_1.mask_.color = var_224_10
			end

			local var_224_11 = 1.98333333333333

			arg_221_1.isInRecall_ = false

			if var_224_11 < arg_221_1.time_ and arg_221_1.time_ <= var_224_11 + arg_224_0 then
				arg_221_1.screenFilterGo_:SetActive(false)

				for iter_224_2, iter_224_3 in pairs(arg_221_1.actors_) do
					for iter_224_4, iter_224_5 in ipairs((iter_224_3:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_224_5.color = iter_224_5.color.r > 0.51 and Color.New(1, 1, 1) or Color.New(0.5, 0.5, 0.5)
					end
				end
			end

			local var_224_12 = 0.0166666666666667

			if var_224_11 <= arg_221_1.time_ and arg_221_1.time_ < var_224_11 + var_224_12 then
				arg_221_1.screenFilterEffect_.weight = Mathf.Lerp(1, 0, (arg_221_1.time_ - var_224_11) / var_224_12)
			end

			if arg_221_1.time_ >= var_224_11 + var_224_12 and arg_221_1.time_ < var_224_11 + var_224_12 + arg_224_0 then
				arg_221_1.screenFilterEffect_.weight = 0
			end

			if arg_221_1.frameCnt_ <= 1 then
				arg_221_1.dialog_:SetActive(false)
			end

			local var_224_13 = 4
			local var_224_14 = 1.175

			if 4 < arg_221_1.time_ and arg_221_1.time_ <= var_224_13 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0

				arg_221_1.dialog_:SetActive(true)

				arg_221_1.dialogCg_.alpha = 0

				local var_224_15 = LeanTween.value(arg_221_1.dialog_, 0, 1, 0.3)

				var_224_15:setOnUpdate(LuaHelper.FloatAction(function(arg_225_0)
					arg_221_1.dialogCg_.alpha = arg_225_0
				end))
				var_224_15:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_221_1.dialog_)
					var_224_15:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_221_1.duration_ = arg_221_1.duration_ + 0.3

				SetActive(arg_221_1.leftNameGo_, true)

				arg_221_1.leftNameTxt_.text = arg_221_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_221_1.leftNameTxt_.transform)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1.leftNameTxt_.text)
				SetActive(arg_221_1.iconTrs_.gameObject, true)
				arg_221_1.iconController_:SetSelectedState("hero")

				arg_221_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1059")

				arg_221_1.callingController_:SetSelectedState("normal")

				arg_221_1.keyicon_.color = Color.New(1, 1, 1)
				arg_221_1.icon_.color = Color.New(1, 1, 1)

				local var_224_16 = arg_221_1:GetWordFromCfg(116292053)
				local var_224_17 = arg_221_1:FormatText(var_224_16.content)

				arg_221_1.text_.text = var_224_17

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_19 = 47 <= 0 and var_224_14 or var_224_14 * (utf8.len(var_224_17) / 47)

				if (47 <= 0 and var_224_14 or var_224_14 * (utf8.len(var_224_17) / 47)) > 0 and var_224_14 < var_224_19 then
					arg_221_1.talkMaxDuration = var_224_19
					var_224_13 = var_224_13 + 0.3

					if var_224_19 + var_224_13 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_19 + var_224_13
					end
				end

				arg_221_1.text_.text = var_224_17
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116292", "116292053", "story_v_out_116292.awb") ~= 0 then
					local var_224_20 = manager.audio:GetVoiceLength("story_v_out_116292", "116292053", "story_v_out_116292.awb") / 1000

					if var_224_20 + var_224_13 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_20 + var_224_13
					end

					if var_224_16.prefab_name ~= "" and arg_221_1.actors_[var_224_16.prefab_name] ~= nil then
						local var_224_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_221_1.actors_[var_224_16.prefab_name].transform, "story_v_out_116292", "116292053", "story_v_out_116292.awb")

						arg_221_1:RecordAudio("116292053", var_224_21)
						arg_221_1:RecordAudio("116292053", var_224_21)
					else
						arg_221_1:AudioAction("play", "voice", "story_v_out_116292", "116292053", "story_v_out_116292.awb")
					end

					arg_221_1:RecordHistoryTalkVoice("story_v_out_116292", "116292053", "story_v_out_116292.awb")
				end

				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_22 = var_224_13 + 0.3
			local var_224_23 = math.max(var_224_14, arg_221_1.talkMaxDuration)

			if var_224_13 + 0.3 <= arg_221_1.time_ and arg_221_1.time_ < var_224_22 + var_224_23 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - var_224_22) / var_224_23

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= var_224_22 + var_224_23 and arg_221_1.time_ < var_224_22 + var_224_23 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end

		arg_221_1.nodeConfigList_ = {}

		arg_221_1:InitPlayNodeList()
	end,
	Play116292054 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 116292054
		arg_227_1.duration_ = 5

		SetActive(arg_227_1.tipsGo_, false)

		function arg_227_1.onSingleLineFinish_()
			arg_227_1.onSingleLineUpdate_ = nil
			arg_227_1.onSingleLineFinish_ = nil
			arg_227_1.state_ = "waiting"
		end

		function arg_227_1.playNext_(arg_229_0)
			if arg_229_0 == 1 then
				arg_227_0:Play116292055(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			local var_230_0 = 1

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0
				arg_227_1.dialogCg_.alpha = 1

				arg_227_1.dialog_:SetActive(true)
				SetActive(arg_227_1.leftNameGo_, false)

				arg_227_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_227_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_227_1:RecordName(arg_227_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_227_1.iconTrs_.gameObject, false)
				arg_227_1.callingController_:SetSelectedState("normal")

				local var_230_1 = arg_227_1:FormatText(arg_227_1:GetWordFromCfg(116292054).content)

				arg_227_1.text_.text = var_230_1

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_3 = 40 <= 0 and var_230_0 or var_230_0 * (utf8.len(var_230_1) / 40)

				if (40 <= 0 and var_230_0 or var_230_0 * (utf8.len(var_230_1) / 40)) > 0 and var_230_0 < var_230_3 then
					arg_227_1.talkMaxDuration = var_230_3

					if var_230_3 + 0 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_3 + 0
					end
				end

				arg_227_1.text_.text = var_230_1
				arg_227_1.typewritter.percent = 0

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(false)
				arg_227_1:RecordContent(arg_227_1.text_.text)
			end

			local var_230_4 = math.max(var_230_0, arg_227_1.talkMaxDuration)

			if 0 <= arg_227_1.time_ and arg_227_1.time_ < 0 + var_230_4 then
				arg_227_1.typewritter.percent = (arg_227_1.time_ - 0) / var_230_4

				arg_227_1.typewritter:SetDirty()
			end

			if arg_227_1.time_ >= 0 + var_230_4 and arg_227_1.time_ < 0 + var_230_4 + arg_230_0 then
				arg_227_1.typewritter.percent = 1

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(true)
			end
		end

		arg_227_1.nodeConfigList_ = {}

		arg_227_1:InitPlayNodeList()
	end,
	Play116292055 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 116292055
		arg_231_1.duration_ = 7.2

		local var_231_0 = {
			zh = 7.2,
			ja = 6.766
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
				arg_231_0:Play116292056(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 and not isNil(arg_231_1.actors_["1059ui_story"]) and arg_231_1.var_.characterEffect1059ui_story == nil then
				arg_231_1.var_.characterEffect1059ui_story = arg_231_1.actors_["1059ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_234_0 = 0.2

			if 0 <= arg_231_1.time_ and arg_231_1.time_ < 0 + var_234_0 and not isNil(arg_231_1.actors_["1059ui_story"]) then
				if arg_231_1.var_.characterEffect1059ui_story and not isNil(arg_231_1.actors_["1059ui_story"]) then
					arg_231_1.var_.characterEffect1059ui_story.fillFlat = false
				end
			end

			if arg_231_1.time_ >= 0 + var_234_0 and arg_231_1.time_ < 0 + var_234_0 + arg_234_0 and not isNil(arg_231_1.actors_["1059ui_story"]) and arg_231_1.var_.characterEffect1059ui_story then
				arg_231_1.var_.characterEffect1059ui_story.fillFlat = false
			end

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 then
				arg_231_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0204cva")
			end

			local var_234_2 = arg_231_1.actors_["1059ui_story"].transform

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 then
				arg_231_1.var_.moveOldPos1059ui_story = var_234_2.localPosition
			end

			local var_234_3 = 0.001

			if 0 <= arg_231_1.time_ and arg_231_1.time_ < 0 + var_234_3 then
				var_234_2.localPosition = Vector3.Lerp(arg_231_1.var_.moveOldPos1059ui_story, Vector3.New(0, -1.05, -6), (arg_231_1.time_ - 0) / var_234_3)
				var_234_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_234_2.position).x, (manager.ui.mainCamera.transform.position - var_234_2.position).y, (manager.ui.mainCamera.transform.position - var_234_2.position).z)
				var_234_2.localEulerAngles.z = 0
				var_234_2.localEulerAngles.x = 0
				var_234_2.localEulerAngles = var_234_2.localEulerAngles
			end

			if arg_231_1.time_ >= 0 + var_234_3 and arg_231_1.time_ < 0 + var_234_3 + arg_234_0 then
				var_234_2.localPosition = Vector3.New(0, -1.05, -6)
				var_234_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_234_2.position).x, (manager.ui.mainCamera.transform.position - var_234_2.position).y, (manager.ui.mainCamera.transform.position - var_234_2.position).z)
				var_234_2.localEulerAngles.z = 0
				var_234_2.localEulerAngles.x = 0
				var_234_2.localEulerAngles = var_234_2.localEulerAngles
			end

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 then
				arg_231_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/story1059/story1059action/1059action3_1")
			end

			local var_234_4 = 0
			local var_234_5 = 0.825

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= var_234_4 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0
				arg_231_1.dialogCg_.alpha = 1

				arg_231_1.dialog_:SetActive(true)
				SetActive(arg_231_1.leftNameGo_, true)

				arg_231_1.leftNameTxt_.text = arg_231_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_231_1.leftNameTxt_.transform)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1.leftNameTxt_.text)
				SetActive(arg_231_1.iconTrs_.gameObject, false)
				arg_231_1.callingController_:SetSelectedState("normal")

				local var_234_6 = arg_231_1:GetWordFromCfg(116292055)
				local var_234_7 = arg_231_1:FormatText(var_234_6.content)

				arg_231_1.text_.text = var_234_7

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_9 = 33 <= 0 and var_234_5 or var_234_5 * (utf8.len(var_234_7) / 33)

				if (33 <= 0 and var_234_5 or var_234_5 * (utf8.len(var_234_7) / 33)) > 0 and var_234_5 < var_234_9 then
					arg_231_1.talkMaxDuration = var_234_9

					if var_234_9 + var_234_4 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_9 + var_234_4
					end
				end

				arg_231_1.text_.text = var_234_7
				arg_231_1.typewritter.percent = 0

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116292", "116292055", "story_v_out_116292.awb") ~= 0 then
					local var_234_10 = manager.audio:GetVoiceLength("story_v_out_116292", "116292055", "story_v_out_116292.awb") / 1000

					if var_234_10 + var_234_4 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_10 + var_234_4
					end

					if var_234_6.prefab_name ~= "" and arg_231_1.actors_[var_234_6.prefab_name] ~= nil then
						local var_234_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_231_1.actors_[var_234_6.prefab_name].transform, "story_v_out_116292", "116292055", "story_v_out_116292.awb")

						arg_231_1:RecordAudio("116292055", var_234_11)
						arg_231_1:RecordAudio("116292055", var_234_11)
					else
						arg_231_1:AudioAction("play", "voice", "story_v_out_116292", "116292055", "story_v_out_116292.awb")
					end

					arg_231_1:RecordHistoryTalkVoice("story_v_out_116292", "116292055", "story_v_out_116292.awb")
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
				actorName = "1059ui_story",
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
	Play116292056 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 116292056
		arg_235_1.duration_ = 6.6

		local var_235_0 = {
			zh = 6.6,
			ja = 3.566
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
				arg_235_0:Play116292057(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 then
				arg_235_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_238_0 = 0
			local var_238_1 = 0.825

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= var_238_0 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0
				arg_235_1.dialogCg_.alpha = 1

				arg_235_1.dialog_:SetActive(true)
				SetActive(arg_235_1.leftNameGo_, true)

				arg_235_1.leftNameTxt_.text = arg_235_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_235_1.leftNameTxt_.transform)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1.leftNameTxt_.text)
				SetActive(arg_235_1.iconTrs_.gameObject, false)
				arg_235_1.callingController_:SetSelectedState("normal")

				local var_238_2 = arg_235_1:GetWordFromCfg(116292056)
				local var_238_3 = arg_235_1:FormatText(var_238_2.content)

				arg_235_1.text_.text = var_238_3

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_5 = 33 <= 0 and var_238_1 or var_238_1 * (utf8.len(var_238_3) / 33)

				if (33 <= 0 and var_238_1 or var_238_1 * (utf8.len(var_238_3) / 33)) > 0 and var_238_1 < var_238_5 then
					arg_235_1.talkMaxDuration = var_238_5

					if var_238_5 + var_238_0 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_5 + var_238_0
					end
				end

				arg_235_1.text_.text = var_238_3
				arg_235_1.typewritter.percent = 0

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116292", "116292056", "story_v_out_116292.awb") ~= 0 then
					local var_238_6 = manager.audio:GetVoiceLength("story_v_out_116292", "116292056", "story_v_out_116292.awb") / 1000

					if var_238_6 + var_238_0 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_6 + var_238_0
					end

					if var_238_2.prefab_name ~= "" and arg_235_1.actors_[var_238_2.prefab_name] ~= nil then
						local var_238_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_235_1.actors_[var_238_2.prefab_name].transform, "story_v_out_116292", "116292056", "story_v_out_116292.awb")

						arg_235_1:RecordAudio("116292056", var_238_7)
						arg_235_1:RecordAudio("116292056", var_238_7)
					else
						arg_235_1:AudioAction("play", "voice", "story_v_out_116292", "116292056", "story_v_out_116292.awb")
					end

					arg_235_1:RecordHistoryTalkVoice("story_v_out_116292", "116292056", "story_v_out_116292.awb")
				end

				arg_235_1:RecordContent(arg_235_1.text_.text)
			end

			local var_238_8 = math.max(var_238_1, arg_235_1.talkMaxDuration)

			if var_238_0 <= arg_235_1.time_ and arg_235_1.time_ < var_238_0 + var_238_8 then
				arg_235_1.typewritter.percent = (arg_235_1.time_ - var_238_0) / var_238_8

				arg_235_1.typewritter:SetDirty()
			end

			if arg_235_1.time_ >= var_238_0 + var_238_8 and arg_235_1.time_ < var_238_0 + var_238_8 + arg_238_0 then
				arg_235_1.typewritter.percent = 1

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(true)
			end
		end

		arg_235_1.nodeConfigList_ = {}

		arg_235_1:InitPlayNodeList()
	end,
	Play116292057 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 116292057
		arg_239_1.duration_ = 7.7

		local var_239_0 = {
			zh = 7.666,
			ja = 7.7
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
				arg_239_0:Play116292058(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 then
				arg_239_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 then
				arg_239_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/story1059/story1059action/1059action3_2")
			end

			local var_242_0 = 0
			local var_242_1 = 0.975

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= var_242_0 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0
				arg_239_1.dialogCg_.alpha = 1

				arg_239_1.dialog_:SetActive(true)
				SetActive(arg_239_1.leftNameGo_, true)

				arg_239_1.leftNameTxt_.text = arg_239_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_239_1.leftNameTxt_.transform)

				arg_239_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_239_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_239_1:RecordName(arg_239_1.leftNameTxt_.text)
				SetActive(arg_239_1.iconTrs_.gameObject, false)
				arg_239_1.callingController_:SetSelectedState("normal")

				local var_242_2 = arg_239_1:GetWordFromCfg(116292057)
				local var_242_3 = arg_239_1:FormatText(var_242_2.content)

				arg_239_1.text_.text = var_242_3

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_5 = 39 <= 0 and var_242_1 or var_242_1 * (utf8.len(var_242_3) / 39)

				if (39 <= 0 and var_242_1 or var_242_1 * (utf8.len(var_242_3) / 39)) > 0 and var_242_1 < var_242_5 then
					arg_239_1.talkMaxDuration = var_242_5

					if var_242_5 + var_242_0 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_5 + var_242_0
					end
				end

				arg_239_1.text_.text = var_242_3
				arg_239_1.typewritter.percent = 0

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116292", "116292057", "story_v_out_116292.awb") ~= 0 then
					local var_242_6 = manager.audio:GetVoiceLength("story_v_out_116292", "116292057", "story_v_out_116292.awb") / 1000

					if var_242_6 + var_242_0 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_6 + var_242_0
					end

					if var_242_2.prefab_name ~= "" and arg_239_1.actors_[var_242_2.prefab_name] ~= nil then
						local var_242_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_239_1.actors_[var_242_2.prefab_name].transform, "story_v_out_116292", "116292057", "story_v_out_116292.awb")

						arg_239_1:RecordAudio("116292057", var_242_7)
						arg_239_1:RecordAudio("116292057", var_242_7)
					else
						arg_239_1:AudioAction("play", "voice", "story_v_out_116292", "116292057", "story_v_out_116292.awb")
					end

					arg_239_1:RecordHistoryTalkVoice("story_v_out_116292", "116292057", "story_v_out_116292.awb")
				end

				arg_239_1:RecordContent(arg_239_1.text_.text)
			end

			local var_242_8 = math.max(var_242_1, arg_239_1.talkMaxDuration)

			if var_242_0 <= arg_239_1.time_ and arg_239_1.time_ < var_242_0 + var_242_8 then
				arg_239_1.typewritter.percent = (arg_239_1.time_ - var_242_0) / var_242_8

				arg_239_1.typewritter:SetDirty()
			end

			if arg_239_1.time_ >= var_242_0 + var_242_8 and arg_239_1.time_ < var_242_0 + var_242_8 + arg_242_0 then
				arg_239_1.typewritter.percent = 1

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(true)
			end
		end

		arg_239_1.nodeConfigList_ = {}

		arg_239_1:InitPlayNodeList()
	end,
	Play116292058 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 116292058
		arg_243_1.duration_ = 1.7

		local var_243_0 = {
			zh = 1.7,
			ja = 1.1
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
				arg_243_0:Play116292059(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 and not isNil(arg_243_1.actors_["1059ui_story"]) and arg_243_1.var_.characterEffect1059ui_story == nil then
				arg_243_1.var_.characterEffect1059ui_story = arg_243_1.actors_["1059ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_246_0 = 0.2

			if 0 <= arg_243_1.time_ and arg_243_1.time_ < 0 + var_246_0 and not isNil(arg_243_1.actors_["1059ui_story"]) then
				if arg_243_1.var_.characterEffect1059ui_story and not isNil(arg_243_1.actors_["1059ui_story"]) then
					arg_243_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_243_1.var_.characterEffect1059ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_243_1.time_ - 0) / var_246_0)
				end
			end

			if arg_243_1.time_ >= 0 + var_246_0 and arg_243_1.time_ < 0 + var_246_0 + arg_246_0 and not isNil(arg_243_1.actors_["1059ui_story"]) and arg_243_1.var_.characterEffect1059ui_story then
				arg_243_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_243_1.var_.characterEffect1059ui_story.fillRatio = 0.5
			end

			local var_246_1 = 0
			local var_246_2 = 0.15

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= var_246_1 + arg_246_0 then
				arg_243_1.talkMaxDuration = 0
				arg_243_1.dialogCg_.alpha = 1

				arg_243_1.dialog_:SetActive(true)
				SetActive(arg_243_1.leftNameGo_, true)

				arg_243_1.leftNameTxt_.text = arg_243_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_243_1.leftNameTxt_.transform)

				arg_243_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_243_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_243_1:RecordName(arg_243_1.leftNameTxt_.text)
				SetActive(arg_243_1.iconTrs_.gameObject, true)
				arg_243_1.iconController_:SetSelectedState("hero")

				arg_243_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1028")

				arg_243_1.callingController_:SetSelectedState("normal")

				arg_243_1.keyicon_.color = Color.New(1, 1, 1)
				arg_243_1.icon_.color = Color.New(1, 1, 1)

				local var_246_3 = arg_243_1:GetWordFromCfg(116292058)
				local var_246_4 = arg_243_1:FormatText(var_246_3.content)

				arg_243_1.text_.text = var_246_4

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_6 = 6 <= 0 and var_246_2 or var_246_2 * (utf8.len(var_246_4) / 6)

				if (6 <= 0 and var_246_2 or var_246_2 * (utf8.len(var_246_4) / 6)) > 0 and var_246_2 < var_246_6 then
					arg_243_1.talkMaxDuration = var_246_6

					if var_246_6 + var_246_1 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_6 + var_246_1
					end
				end

				arg_243_1.text_.text = var_246_4
				arg_243_1.typewritter.percent = 0

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116292", "116292058", "story_v_out_116292.awb") ~= 0 then
					local var_246_7 = manager.audio:GetVoiceLength("story_v_out_116292", "116292058", "story_v_out_116292.awb") / 1000

					if var_246_7 + var_246_1 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_7 + var_246_1
					end

					if var_246_3.prefab_name ~= "" and arg_243_1.actors_[var_246_3.prefab_name] ~= nil then
						local var_246_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_243_1.actors_[var_246_3.prefab_name].transform, "story_v_out_116292", "116292058", "story_v_out_116292.awb")

						arg_243_1:RecordAudio("116292058", var_246_8)
						arg_243_1:RecordAudio("116292058", var_246_8)
					else
						arg_243_1:AudioAction("play", "voice", "story_v_out_116292", "116292058", "story_v_out_116292.awb")
					end

					arg_243_1:RecordHistoryTalkVoice("story_v_out_116292", "116292058", "story_v_out_116292.awb")
				end

				arg_243_1:RecordContent(arg_243_1.text_.text)
			end

			local var_246_9 = math.max(var_246_2, arg_243_1.talkMaxDuration)

			if var_246_1 <= arg_243_1.time_ and arg_243_1.time_ < var_246_1 + var_246_9 then
				arg_243_1.typewritter.percent = (arg_243_1.time_ - var_246_1) / var_246_9

				arg_243_1.typewritter:SetDirty()
			end

			if arg_243_1.time_ >= var_246_1 + var_246_9 and arg_243_1.time_ < var_246_1 + var_246_9 + arg_246_0 then
				arg_243_1.typewritter.percent = 1

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(true)
			end
		end

		arg_243_1.nodeConfigList_ = {}

		arg_243_1:InitPlayNodeList()
	end,
	Play116292059 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 116292059
		arg_247_1.duration_ = 13.43

		local var_247_0 = {
			zh = 12.1,
			ja = 13.433
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
				arg_247_0:Play116292060(arg_247_1)
			end
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 and not isNil(arg_247_1.actors_["1059ui_story"]) and arg_247_1.var_.characterEffect1059ui_story == nil then
				arg_247_1.var_.characterEffect1059ui_story = arg_247_1.actors_["1059ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_250_0 = 0.2

			if 0 <= arg_247_1.time_ and arg_247_1.time_ < 0 + var_250_0 and not isNil(arg_247_1.actors_["1059ui_story"]) then
				if arg_247_1.var_.characterEffect1059ui_story and not isNil(arg_247_1.actors_["1059ui_story"]) then
					arg_247_1.var_.characterEffect1059ui_story.fillFlat = false
				end
			end

			if arg_247_1.time_ >= 0 + var_250_0 and arg_247_1.time_ < 0 + var_250_0 + arg_250_0 and not isNil(arg_247_1.actors_["1059ui_story"]) and arg_247_1.var_.characterEffect1059ui_story then
				arg_247_1.var_.characterEffect1059ui_story.fillFlat = false
			end

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 then
				arg_247_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_250_2 = 0
			local var_250_3 = 1.3

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= var_250_2 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0
				arg_247_1.dialogCg_.alpha = 1

				arg_247_1.dialog_:SetActive(true)
				SetActive(arg_247_1.leftNameGo_, true)

				arg_247_1.leftNameTxt_.text = arg_247_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_247_1.leftNameTxt_.transform)

				arg_247_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_247_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_247_1:RecordName(arg_247_1.leftNameTxt_.text)
				SetActive(arg_247_1.iconTrs_.gameObject, false)
				arg_247_1.callingController_:SetSelectedState("normal")

				local var_250_4 = arg_247_1:GetWordFromCfg(116292059)
				local var_250_5 = arg_247_1:FormatText(var_250_4.content)

				arg_247_1.text_.text = var_250_5

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_7 = 52 <= 0 and var_250_3 or var_250_3 * (utf8.len(var_250_5) / 52)

				if (52 <= 0 and var_250_3 or var_250_3 * (utf8.len(var_250_5) / 52)) > 0 and var_250_3 < var_250_7 then
					arg_247_1.talkMaxDuration = var_250_7

					if var_250_7 + var_250_2 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_7 + var_250_2
					end
				end

				arg_247_1.text_.text = var_250_5
				arg_247_1.typewritter.percent = 0

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116292", "116292059", "story_v_out_116292.awb") ~= 0 then
					local var_250_8 = manager.audio:GetVoiceLength("story_v_out_116292", "116292059", "story_v_out_116292.awb") / 1000

					if var_250_8 + var_250_2 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_8 + var_250_2
					end

					if var_250_4.prefab_name ~= "" and arg_247_1.actors_[var_250_4.prefab_name] ~= nil then
						local var_250_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_247_1.actors_[var_250_4.prefab_name].transform, "story_v_out_116292", "116292059", "story_v_out_116292.awb")

						arg_247_1:RecordAudio("116292059", var_250_9)
						arg_247_1:RecordAudio("116292059", var_250_9)
					else
						arg_247_1:AudioAction("play", "voice", "story_v_out_116292", "116292059", "story_v_out_116292.awb")
					end

					arg_247_1:RecordHistoryTalkVoice("story_v_out_116292", "116292059", "story_v_out_116292.awb")
				end

				arg_247_1:RecordContent(arg_247_1.text_.text)
			end

			local var_250_10 = math.max(var_250_3, arg_247_1.talkMaxDuration)

			if var_250_2 <= arg_247_1.time_ and arg_247_1.time_ < var_250_2 + var_250_10 then
				arg_247_1.typewritter.percent = (arg_247_1.time_ - var_250_2) / var_250_10

				arg_247_1.typewritter:SetDirty()
			end

			if arg_247_1.time_ >= var_250_2 + var_250_10 and arg_247_1.time_ < var_250_2 + var_250_10 + arg_250_0 then
				arg_247_1.typewritter.percent = 1

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(true)
			end
		end

		arg_247_1.nodeConfigList_ = {}

		arg_247_1:InitPlayNodeList()
	end,
	Play116292060 = function(arg_251_0, arg_251_1)
		arg_251_1.time_ = 0
		arg_251_1.frameCnt_ = 0
		arg_251_1.state_ = "playing"
		arg_251_1.curTalkId_ = 116292060
		arg_251_1.duration_ = 5

		SetActive(arg_251_1.tipsGo_, false)

		function arg_251_1.onSingleLineFinish_()
			arg_251_1.onSingleLineUpdate_ = nil
			arg_251_1.onSingleLineFinish_ = nil
			arg_251_1.state_ = "waiting"
		end

		function arg_251_1.playNext_(arg_253_0)
			if arg_253_0 == 1 then
				arg_251_0:Play116292061(arg_251_1)
			end
		end

		function arg_251_1.onSingleLineUpdate_(arg_254_0)
			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 then
				arg_251_1.var_.moveOldPos1059ui_story = arg_251_1.actors_["1059ui_story"].transform.localPosition
			end

			local var_254_0 = 0.001

			if 0 <= arg_251_1.time_ and arg_251_1.time_ < 0 + var_254_0 then
				arg_251_1.actors_["1059ui_story"].transform.localPosition = Vector3.Lerp(arg_251_1.var_.moveOldPos1059ui_story, Vector3.New(0, 100, 0), (arg_251_1.time_ - 0) / var_254_0)
				arg_251_1.actors_["1059ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_251_1.actors_["1059ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_251_1.actors_["1059ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_251_1.actors_["1059ui_story"].transform.position).z)
				arg_251_1.actors_["1059ui_story"].transform.localEulerAngles.z = 0
				arg_251_1.actors_["1059ui_story"].transform.localEulerAngles.x = 0
				arg_251_1.actors_["1059ui_story"].transform.localEulerAngles = arg_251_1.actors_["1059ui_story"].transform.localEulerAngles
			end

			if arg_251_1.time_ >= 0 + var_254_0 and arg_251_1.time_ < 0 + var_254_0 + arg_254_0 then
				arg_251_1.actors_["1059ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_251_1.actors_["1059ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_251_1.actors_["1059ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_251_1.actors_["1059ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_251_1.actors_["1059ui_story"].transform.position).z)
				arg_251_1.actors_["1059ui_story"].transform.localEulerAngles.z = 0
				arg_251_1.actors_["1059ui_story"].transform.localEulerAngles.x = 0
				arg_251_1.actors_["1059ui_story"].transform.localEulerAngles = arg_251_1.actors_["1059ui_story"].transform.localEulerAngles
			end

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 then
				arg_251_1:AudioAction("play", "effect", "se_story_16", "se_story_16_arch", "")
			end

			local var_254_2 = 0
			local var_254_3 = 0.5

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= var_254_2 + arg_254_0 then
				arg_251_1.talkMaxDuration = 0
				arg_251_1.dialogCg_.alpha = 1

				arg_251_1.dialog_:SetActive(true)
				SetActive(arg_251_1.leftNameGo_, false)

				arg_251_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_251_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_251_1:RecordName(arg_251_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_251_1.iconTrs_.gameObject, false)
				arg_251_1.callingController_:SetSelectedState("normal")

				local var_254_4 = arg_251_1:FormatText(arg_251_1:GetWordFromCfg(116292060).content)

				arg_251_1.text_.text = var_254_4

				LuaForUtil.ClearLinePrefixSymbol(arg_251_1.text_)

				local var_254_6 = 20 <= 0 and var_254_3 or var_254_3 * (utf8.len(var_254_4) / 20)

				if (20 <= 0 and var_254_3 or var_254_3 * (utf8.len(var_254_4) / 20)) > 0 and var_254_3 < var_254_6 then
					arg_251_1.talkMaxDuration = var_254_6

					if var_254_6 + var_254_2 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_6 + var_254_2
					end
				end

				arg_251_1.text_.text = var_254_4
				arg_251_1.typewritter.percent = 0

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(false)
				arg_251_1:RecordContent(arg_251_1.text_.text)
			end

			local var_254_7 = math.max(var_254_3, arg_251_1.talkMaxDuration)

			if var_254_2 <= arg_251_1.time_ and arg_251_1.time_ < var_254_2 + var_254_7 then
				arg_251_1.typewritter.percent = (arg_251_1.time_ - var_254_2) / var_254_7

				arg_251_1.typewritter:SetDirty()
			end

			if arg_251_1.time_ >= var_254_2 + var_254_7 and arg_251_1.time_ < var_254_2 + var_254_7 + arg_254_0 then
				arg_251_1.typewritter.percent = 1

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(true)
			end
		end

		arg_251_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1059ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_251_1:InitPlayNodeList()
	end,
	Play116292061 = function(arg_255_0, arg_255_1)
		arg_255_1.time_ = 0
		arg_255_1.frameCnt_ = 0
		arg_255_1.state_ = "playing"
		arg_255_1.curTalkId_ = 116292061
		arg_255_1.duration_ = 6.3

		local var_255_0 = {
			zh = 4.266,
			ja = 6.3
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
				arg_255_0:Play116292062(arg_255_1)
			end
		end

		function arg_255_1.onSingleLineUpdate_(arg_258_0)
			local var_258_0 = 0.4

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 then
				arg_255_1.talkMaxDuration = 0
				arg_255_1.dialogCg_.alpha = 1

				arg_255_1.dialog_:SetActive(true)
				SetActive(arg_255_1.leftNameGo_, true)

				arg_255_1.leftNameTxt_.text = arg_255_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_255_1.leftNameTxt_.transform)

				arg_255_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_255_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_255_1:RecordName(arg_255_1.leftNameTxt_.text)
				SetActive(arg_255_1.iconTrs_.gameObject, true)
				arg_255_1.iconController_:SetSelectedState("hero")

				arg_255_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1059")

				arg_255_1.callingController_:SetSelectedState("normal")

				arg_255_1.keyicon_.color = Color.New(1, 1, 1)
				arg_255_1.icon_.color = Color.New(1, 1, 1)

				local var_258_1 = arg_255_1:GetWordFromCfg(116292061)
				local var_258_2 = arg_255_1:FormatText(var_258_1.content)

				arg_255_1.text_.text = var_258_2

				LuaForUtil.ClearLinePrefixSymbol(arg_255_1.text_)

				local var_258_4 = 16 <= 0 and var_258_0 or var_258_0 * (utf8.len(var_258_2) / 16)

				if (16 <= 0 and var_258_0 or var_258_0 * (utf8.len(var_258_2) / 16)) > 0 and var_258_0 < var_258_4 then
					arg_255_1.talkMaxDuration = var_258_4

					if var_258_4 + 0 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_4 + 0
					end
				end

				arg_255_1.text_.text = var_258_2
				arg_255_1.typewritter.percent = 0

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116292", "116292061", "story_v_out_116292.awb") ~= 0 then
					local var_258_5 = manager.audio:GetVoiceLength("story_v_out_116292", "116292061", "story_v_out_116292.awb") / 1000

					if var_258_5 + 0 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_5 + 0
					end

					if var_258_1.prefab_name ~= "" and arg_255_1.actors_[var_258_1.prefab_name] ~= nil then
						local var_258_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_255_1.actors_[var_258_1.prefab_name].transform, "story_v_out_116292", "116292061", "story_v_out_116292.awb")

						arg_255_1:RecordAudio("116292061", var_258_6)
						arg_255_1:RecordAudio("116292061", var_258_6)
					else
						arg_255_1:AudioAction("play", "voice", "story_v_out_116292", "116292061", "story_v_out_116292.awb")
					end

					arg_255_1:RecordHistoryTalkVoice("story_v_out_116292", "116292061", "story_v_out_116292.awb")
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
	Play116292062 = function(arg_259_0, arg_259_1)
		arg_259_1.time_ = 0
		arg_259_1.frameCnt_ = 0
		arg_259_1.state_ = "playing"
		arg_259_1.curTalkId_ = 116292062
		arg_259_1.duration_ = 5

		SetActive(arg_259_1.tipsGo_, false)

		function arg_259_1.onSingleLineFinish_()
			arg_259_1.onSingleLineUpdate_ = nil
			arg_259_1.onSingleLineFinish_ = nil
			arg_259_1.state_ = "waiting"
		end

		function arg_259_1.playNext_(arg_261_0)
			if arg_261_0 == 1 then
				arg_259_0:Play116292063(arg_259_1)
			end
		end

		function arg_259_1.onSingleLineUpdate_(arg_262_0)
			local var_262_0 = 1.125

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

				local var_262_1 = arg_259_1:FormatText(arg_259_1:GetWordFromCfg(116292062).content)

				arg_259_1.text_.text = var_262_1

				LuaForUtil.ClearLinePrefixSymbol(arg_259_1.text_)

				local var_262_3 = 45 <= 0 and var_262_0 or var_262_0 * (utf8.len(var_262_1) / 45)

				if (45 <= 0 and var_262_0 or var_262_0 * (utf8.len(var_262_1) / 45)) > 0 and var_262_0 < var_262_3 then
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
	Play116292063 = function(arg_263_0, arg_263_1)
		arg_263_1.time_ = 0
		arg_263_1.frameCnt_ = 0
		arg_263_1.state_ = "playing"
		arg_263_1.curTalkId_ = 116292063
		arg_263_1.duration_ = 5

		SetActive(arg_263_1.tipsGo_, false)

		function arg_263_1.onSingleLineFinish_()
			arg_263_1.onSingleLineUpdate_ = nil
			arg_263_1.onSingleLineFinish_ = nil
			arg_263_1.state_ = "waiting"
		end

		function arg_263_1.playNext_(arg_265_0)
			if arg_265_0 == 1 then
				arg_263_0:Play116292064(arg_263_1)
			end
		end

		function arg_263_1.onSingleLineUpdate_(arg_266_0)
			local var_266_0 = 0.7

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

				local var_266_1 = arg_263_1:FormatText(arg_263_1:GetWordFromCfg(116292063).content)

				arg_263_1.text_.text = var_266_1

				LuaForUtil.ClearLinePrefixSymbol(arg_263_1.text_)

				local var_266_3 = 28 <= 0 and var_266_0 or var_266_0 * (utf8.len(var_266_1) / 28)

				if (28 <= 0 and var_266_0 or var_266_0 * (utf8.len(var_266_1) / 28)) > 0 and var_266_0 < var_266_3 then
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
	Play116292064 = function(arg_267_0, arg_267_1)
		arg_267_1.time_ = 0
		arg_267_1.frameCnt_ = 0
		arg_267_1.state_ = "playing"
		arg_267_1.curTalkId_ = 116292064
		arg_267_1.duration_ = 6.63

		local var_267_0 = {
			zh = 4.466,
			ja = 6.633
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
				arg_267_0:Play116292065(arg_267_1)
			end
		end

		function arg_267_1.onSingleLineUpdate_(arg_270_0)
			local var_270_0 = 0.3

			if 0 < arg_267_1.time_ and arg_267_1.time_ <= 0 + arg_270_0 then
				arg_267_1.talkMaxDuration = 0
				arg_267_1.dialogCg_.alpha = 1

				arg_267_1.dialog_:SetActive(true)
				SetActive(arg_267_1.leftNameGo_, true)

				arg_267_1.leftNameTxt_.text = arg_267_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_267_1.leftNameTxt_.transform)

				arg_267_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_267_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_267_1:RecordName(arg_267_1.leftNameTxt_.text)
				SetActive(arg_267_1.iconTrs_.gameObject, true)
				arg_267_1.iconController_:SetSelectedState("hero")

				arg_267_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1028")

				arg_267_1.callingController_:SetSelectedState("normal")

				arg_267_1.keyicon_.color = Color.New(1, 1, 1)
				arg_267_1.icon_.color = Color.New(1, 1, 1)

				local var_270_1 = arg_267_1:GetWordFromCfg(116292064)
				local var_270_2 = arg_267_1:FormatText(var_270_1.content)

				arg_267_1.text_.text = var_270_2

				LuaForUtil.ClearLinePrefixSymbol(arg_267_1.text_)

				local var_270_4 = 12 <= 0 and var_270_0 or var_270_0 * (utf8.len(var_270_2) / 12)

				if (12 <= 0 and var_270_0 or var_270_0 * (utf8.len(var_270_2) / 12)) > 0 and var_270_0 < var_270_4 then
					arg_267_1.talkMaxDuration = var_270_4

					if var_270_4 + 0 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_4 + 0
					end
				end

				arg_267_1.text_.text = var_270_2
				arg_267_1.typewritter.percent = 0

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116292", "116292064", "story_v_out_116292.awb") ~= 0 then
					local var_270_5 = manager.audio:GetVoiceLength("story_v_out_116292", "116292064", "story_v_out_116292.awb") / 1000

					if var_270_5 + 0 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_5 + 0
					end

					if var_270_1.prefab_name ~= "" and arg_267_1.actors_[var_270_1.prefab_name] ~= nil then
						local var_270_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_267_1.actors_[var_270_1.prefab_name].transform, "story_v_out_116292", "116292064", "story_v_out_116292.awb")

						arg_267_1:RecordAudio("116292064", var_270_6)
						arg_267_1:RecordAudio("116292064", var_270_6)
					else
						arg_267_1:AudioAction("play", "voice", "story_v_out_116292", "116292064", "story_v_out_116292.awb")
					end

					arg_267_1:RecordHistoryTalkVoice("story_v_out_116292", "116292064", "story_v_out_116292.awb")
				end

				arg_267_1:RecordContent(arg_267_1.text_.text)
			end

			local var_270_7 = math.max(var_270_0, arg_267_1.talkMaxDuration)

			if 0 <= arg_267_1.time_ and arg_267_1.time_ < 0 + var_270_7 then
				arg_267_1.typewritter.percent = (arg_267_1.time_ - 0) / var_270_7

				arg_267_1.typewritter:SetDirty()
			end

			if arg_267_1.time_ >= 0 + var_270_7 and arg_267_1.time_ < 0 + var_270_7 + arg_270_0 then
				arg_267_1.typewritter.percent = 1

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(true)
			end
		end

		arg_267_1.nodeConfigList_ = {}

		arg_267_1:InitPlayNodeList()
	end,
	Play116292065 = function(arg_271_0, arg_271_1)
		arg_271_1.time_ = 0
		arg_271_1.frameCnt_ = 0
		arg_271_1.state_ = "playing"
		arg_271_1.curTalkId_ = 116292065
		arg_271_1.duration_ = 5.57

		local var_271_0 = {
			zh = 5.566,
			ja = 4.033
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
				arg_271_0:Play116292066(arg_271_1)
			end
		end

		function arg_271_1.onSingleLineUpdate_(arg_274_0)
			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 and not isNil(arg_271_1.actors_["1059ui_story"]) and arg_271_1.var_.characterEffect1059ui_story == nil then
				arg_271_1.var_.characterEffect1059ui_story = arg_271_1.actors_["1059ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_274_0 = 0.2

			if 0 <= arg_271_1.time_ and arg_271_1.time_ < 0 + var_274_0 and not isNil(arg_271_1.actors_["1059ui_story"]) then
				if arg_271_1.var_.characterEffect1059ui_story and not isNil(arg_271_1.actors_["1059ui_story"]) then
					arg_271_1.var_.characterEffect1059ui_story.fillFlat = false
				end
			end

			if arg_271_1.time_ >= 0 + var_274_0 and arg_271_1.time_ < 0 + var_274_0 + arg_274_0 and not isNil(arg_271_1.actors_["1059ui_story"]) and arg_271_1.var_.characterEffect1059ui_story then
				arg_271_1.var_.characterEffect1059ui_story.fillFlat = false
			end

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 then
				arg_271_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/story1059/story1059action/1059action6_1")
			end

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 then
				arg_271_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_274_2 = arg_271_1.actors_["1059ui_story"].transform

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 then
				arg_271_1.var_.moveOldPos1059ui_story = var_274_2.localPosition
			end

			local var_274_3 = 0.001

			if 0 <= arg_271_1.time_ and arg_271_1.time_ < 0 + var_274_3 then
				var_274_2.localPosition = Vector3.Lerp(arg_271_1.var_.moveOldPos1059ui_story, Vector3.New(0, -1.05, -6), (arg_271_1.time_ - 0) / var_274_3)
				var_274_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_274_2.position).x, (manager.ui.mainCamera.transform.position - var_274_2.position).y, (manager.ui.mainCamera.transform.position - var_274_2.position).z)
				var_274_2.localEulerAngles.z = 0
				var_274_2.localEulerAngles.x = 0
				var_274_2.localEulerAngles = var_274_2.localEulerAngles
			end

			if arg_271_1.time_ >= 0 + var_274_3 and arg_271_1.time_ < 0 + var_274_3 + arg_274_0 then
				var_274_2.localPosition = Vector3.New(0, -1.05, -6)
				var_274_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_274_2.position).x, (manager.ui.mainCamera.transform.position - var_274_2.position).y, (manager.ui.mainCamera.transform.position - var_274_2.position).z)
				var_274_2.localEulerAngles.z = 0
				var_274_2.localEulerAngles.x = 0
				var_274_2.localEulerAngles = var_274_2.localEulerAngles
			end

			local var_274_4 = 0
			local var_274_5 = 0.55

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= var_274_4 + arg_274_0 then
				arg_271_1.talkMaxDuration = 0
				arg_271_1.dialogCg_.alpha = 1

				arg_271_1.dialog_:SetActive(true)
				SetActive(arg_271_1.leftNameGo_, true)

				arg_271_1.leftNameTxt_.text = arg_271_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_271_1.leftNameTxt_.transform)

				arg_271_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_271_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_271_1:RecordName(arg_271_1.leftNameTxt_.text)
				SetActive(arg_271_1.iconTrs_.gameObject, false)
				arg_271_1.callingController_:SetSelectedState("normal")

				local var_274_6 = arg_271_1:GetWordFromCfg(116292065)
				local var_274_7 = arg_271_1:FormatText(var_274_6.content)

				arg_271_1.text_.text = var_274_7

				LuaForUtil.ClearLinePrefixSymbol(arg_271_1.text_)

				local var_274_9 = 22 <= 0 and var_274_5 or var_274_5 * (utf8.len(var_274_7) / 22)

				if (22 <= 0 and var_274_5 or var_274_5 * (utf8.len(var_274_7) / 22)) > 0 and var_274_5 < var_274_9 then
					arg_271_1.talkMaxDuration = var_274_9

					if var_274_9 + var_274_4 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_9 + var_274_4
					end
				end

				arg_271_1.text_.text = var_274_7
				arg_271_1.typewritter.percent = 0

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116292", "116292065", "story_v_out_116292.awb") ~= 0 then
					local var_274_10 = manager.audio:GetVoiceLength("story_v_out_116292", "116292065", "story_v_out_116292.awb") / 1000

					if var_274_10 + var_274_4 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_10 + var_274_4
					end

					if var_274_6.prefab_name ~= "" and arg_271_1.actors_[var_274_6.prefab_name] ~= nil then
						local var_274_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_271_1.actors_[var_274_6.prefab_name].transform, "story_v_out_116292", "116292065", "story_v_out_116292.awb")

						arg_271_1:RecordAudio("116292065", var_274_11)
						arg_271_1:RecordAudio("116292065", var_274_11)
					else
						arg_271_1:AudioAction("play", "voice", "story_v_out_116292", "116292065", "story_v_out_116292.awb")
					end

					arg_271_1:RecordHistoryTalkVoice("story_v_out_116292", "116292065", "story_v_out_116292.awb")
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

		arg_271_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1059ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_271_1:InitPlayNodeList()
	end,
	Play116292066 = function(arg_275_0, arg_275_1)
		arg_275_1.time_ = 0
		arg_275_1.frameCnt_ = 0
		arg_275_1.state_ = "playing"
		arg_275_1.curTalkId_ = 116292066
		arg_275_1.duration_ = 5

		SetActive(arg_275_1.tipsGo_, false)

		function arg_275_1.onSingleLineFinish_()
			arg_275_1.onSingleLineUpdate_ = nil
			arg_275_1.onSingleLineFinish_ = nil
			arg_275_1.state_ = "waiting"
		end

		function arg_275_1.playNext_(arg_277_0)
			if arg_277_0 == 1 then
				arg_275_0:Play116292067(arg_275_1)
			end
		end

		function arg_275_1.onSingleLineUpdate_(arg_278_0)
			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 and not isNil(arg_275_1.actors_["1059ui_story"]) and arg_275_1.var_.characterEffect1059ui_story == nil then
				arg_275_1.var_.characterEffect1059ui_story = arg_275_1.actors_["1059ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_278_0 = 0.2

			if 0 <= arg_275_1.time_ and arg_275_1.time_ < 0 + var_278_0 and not isNil(arg_275_1.actors_["1059ui_story"]) then
				if arg_275_1.var_.characterEffect1059ui_story and not isNil(arg_275_1.actors_["1059ui_story"]) then
					arg_275_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_275_1.var_.characterEffect1059ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_275_1.time_ - 0) / var_278_0)
				end
			end

			if arg_275_1.time_ >= 0 + var_278_0 and arg_275_1.time_ < 0 + var_278_0 + arg_278_0 and not isNil(arg_275_1.actors_["1059ui_story"]) and arg_275_1.var_.characterEffect1059ui_story then
				arg_275_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_275_1.var_.characterEffect1059ui_story.fillRatio = 0.5
			end

			local var_278_1 = 0
			local var_278_2 = 0.2

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= var_278_1 + arg_278_0 then
				arg_275_1.talkMaxDuration = 0
				arg_275_1.dialogCg_.alpha = 1

				arg_275_1.dialog_:SetActive(true)
				SetActive(arg_275_1.leftNameGo_, true)

				arg_275_1.leftNameTxt_.text = arg_275_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_275_1.leftNameTxt_.transform)

				arg_275_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_275_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_275_1:RecordName(arg_275_1.leftNameTxt_.text)
				SetActive(arg_275_1.iconTrs_.gameObject, true)
				arg_275_1.iconController_:SetSelectedState("hero")

				arg_275_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_275_1.callingController_:SetSelectedState("normal")

				arg_275_1.keyicon_.color = Color.New(1, 1, 1)
				arg_275_1.icon_.color = Color.New(1, 1, 1)

				local var_278_3 = arg_275_1:FormatText(arg_275_1:GetWordFromCfg(116292066).content)

				arg_275_1.text_.text = var_278_3

				LuaForUtil.ClearLinePrefixSymbol(arg_275_1.text_)

				local var_278_5 = 8 <= 0 and var_278_2 or var_278_2 * (utf8.len(var_278_3) / 8)

				if (8 <= 0 and var_278_2 or var_278_2 * (utf8.len(var_278_3) / 8)) > 0 and var_278_2 < var_278_5 then
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
	Play116292067 = function(arg_279_0, arg_279_1)
		arg_279_1.time_ = 0
		arg_279_1.frameCnt_ = 0
		arg_279_1.state_ = "playing"
		arg_279_1.curTalkId_ = 116292067
		arg_279_1.duration_ = 2.8

		local var_279_0 = {
			zh = 2.8,
			ja = 2.433333333332
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
				arg_279_0:Play116292068(arg_279_1)
			end
		end

		function arg_279_1.onSingleLineUpdate_(arg_282_0)
			if 0 < arg_279_1.time_ and arg_279_1.time_ <= 0 + arg_282_0 then
				arg_279_1.var_.moveOldPos1059ui_story = arg_279_1.actors_["1059ui_story"].transform.localPosition
			end

			local var_282_0 = 0.001

			if 0 <= arg_279_1.time_ and arg_279_1.time_ < 0 + var_282_0 then
				arg_279_1.actors_["1059ui_story"].transform.localPosition = Vector3.Lerp(arg_279_1.var_.moveOldPos1059ui_story, Vector3.New(0, 100, 0), (arg_279_1.time_ - 0) / var_282_0)
				arg_279_1.actors_["1059ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_279_1.actors_["1059ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_279_1.actors_["1059ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_279_1.actors_["1059ui_story"].transform.position).z)
				arg_279_1.actors_["1059ui_story"].transform.localEulerAngles.z = 0
				arg_279_1.actors_["1059ui_story"].transform.localEulerAngles.x = 0
				arg_279_1.actors_["1059ui_story"].transform.localEulerAngles = arg_279_1.actors_["1059ui_story"].transform.localEulerAngles
			end

			if arg_279_1.time_ >= 0 + var_282_0 and arg_279_1.time_ < 0 + var_282_0 + arg_282_0 then
				arg_279_1.actors_["1059ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_279_1.actors_["1059ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_279_1.actors_["1059ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_279_1.actors_["1059ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_279_1.actors_["1059ui_story"].transform.position).z)
				arg_279_1.actors_["1059ui_story"].transform.localEulerAngles.z = 0
				arg_279_1.actors_["1059ui_story"].transform.localEulerAngles.x = 0
				arg_279_1.actors_["1059ui_story"].transform.localEulerAngles = arg_279_1.actors_["1059ui_story"].transform.localEulerAngles
			end

			local var_282_1 = "10025ui_story"

			if arg_279_1.actors_["10025ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10025ui_story"))) then
				local var_282_2 = Object.Instantiate(Asset.Load("Char/" .. "10025ui_story"), arg_279_1.stage_.transform)

				var_282_2.name = var_282_1
				var_282_2.transform.localPosition = Vector3.New(0, 100, 0)
				arg_279_1.actors_[var_282_1] = var_282_2

				local var_282_3 = var_282_2:GetComponentInChildren(typeof(CharacterEffect))

				var_282_3.enabled = true

				local var_282_4 = GameObjectTools.GetOrAddComponent(var_282_2, typeof(DynamicBoneHelper))

				if var_282_4 then
					var_282_4:EnableDynamicBone(false)
				end

				arg_279_1:ShowWeapon(var_282_3.transform, false)

				arg_279_1.var_[var_282_1 .. "Animator"] = var_282_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_279_1.var_[var_282_1 .. "Animator"].applyRootMotion = true
				arg_279_1.var_[var_282_1 .. "LipSync"] = var_282_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_282_5 = arg_279_1.actors_["10025ui_story"].transform

			if 0 < arg_279_1.time_ and arg_279_1.time_ <= 0 + arg_282_0 then
				arg_279_1.var_.moveOldPos10025ui_story = var_282_5.localPosition
			end

			local var_282_6 = 0.001

			if 0 <= arg_279_1.time_ and arg_279_1.time_ < 0 + var_282_6 then
				var_282_5.localPosition = Vector3.Lerp(arg_279_1.var_.moveOldPos10025ui_story, Vector3.New(0, -1.1, -5.9), (arg_279_1.time_ - 0) / var_282_6)
				var_282_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_282_5.position).x, (manager.ui.mainCamera.transform.position - var_282_5.position).y, (manager.ui.mainCamera.transform.position - var_282_5.position).z)
				var_282_5.localEulerAngles.z = 0
				var_282_5.localEulerAngles.x = 0
				var_282_5.localEulerAngles = var_282_5.localEulerAngles
			end

			if arg_279_1.time_ >= 0 + var_282_6 and arg_279_1.time_ < 0 + var_282_6 + arg_282_0 then
				var_282_5.localPosition = Vector3.New(0, -1.1, -5.9)
				var_282_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_282_5.position).x, (manager.ui.mainCamera.transform.position - var_282_5.position).y, (manager.ui.mainCamera.transform.position - var_282_5.position).z)
				var_282_5.localEulerAngles.z = 0
				var_282_5.localEulerAngles.x = 0
				var_282_5.localEulerAngles = var_282_5.localEulerAngles
			end

			local var_282_7 = arg_279_1.actors_["10025ui_story"]

			if 0 < arg_279_1.time_ and arg_279_1.time_ <= 0 + arg_282_0 and not isNil(var_282_7) and arg_279_1.var_.characterEffect10025ui_story == nil then
				arg_279_1.var_.characterEffect10025ui_story = var_282_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_282_8 = 0.2

			if 0 <= arg_279_1.time_ and arg_279_1.time_ < 0 + var_282_8 and not isNil(var_282_7) then
				if arg_279_1.var_.characterEffect10025ui_story and not isNil(var_282_7) then
					arg_279_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_279_1.time_ >= 0 + var_282_8 and arg_279_1.time_ < 0 + var_282_8 + arg_282_0 and not isNil(var_282_7) and arg_279_1.var_.characterEffect10025ui_story then
				arg_279_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			if 0 < arg_279_1.time_ and arg_279_1.time_ <= 0 + arg_282_0 then
				arg_279_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action8_1")
			end

			if 0 < arg_279_1.time_ and arg_279_1.time_ <= 0 + arg_282_0 then
				arg_279_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_282_10 = 0
			local var_282_11 = 0.175

			if 0 < arg_279_1.time_ and arg_279_1.time_ <= var_282_10 + arg_282_0 then
				arg_279_1.talkMaxDuration = 0
				arg_279_1.dialogCg_.alpha = 1

				arg_279_1.dialog_:SetActive(true)
				SetActive(arg_279_1.leftNameGo_, true)

				arg_279_1.leftNameTxt_.text = arg_279_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_279_1.leftNameTxt_.transform)

				arg_279_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_279_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_279_1:RecordName(arg_279_1.leftNameTxt_.text)
				SetActive(arg_279_1.iconTrs_.gameObject, false)
				arg_279_1.callingController_:SetSelectedState("normal")

				local var_282_12 = arg_279_1:GetWordFromCfg(116292067)
				local var_282_13 = arg_279_1:FormatText(var_282_12.content)

				arg_279_1.text_.text = var_282_13

				LuaForUtil.ClearLinePrefixSymbol(arg_279_1.text_)

				local var_282_15 = 7 <= 0 and var_282_11 or var_282_11 * (utf8.len(var_282_13) / 7)

				if (7 <= 0 and var_282_11 or var_282_11 * (utf8.len(var_282_13) / 7)) > 0 and var_282_11 < var_282_15 then
					arg_279_1.talkMaxDuration = var_282_15

					if var_282_15 + var_282_10 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_15 + var_282_10
					end
				end

				arg_279_1.text_.text = var_282_13
				arg_279_1.typewritter.percent = 0

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116292", "116292067", "story_v_out_116292.awb") ~= 0 then
					local var_282_16 = manager.audio:GetVoiceLength("story_v_out_116292", "116292067", "story_v_out_116292.awb") / 1000

					if var_282_16 + var_282_10 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_16 + var_282_10
					end

					if var_282_12.prefab_name ~= "" and arg_279_1.actors_[var_282_12.prefab_name] ~= nil then
						local var_282_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_279_1.actors_[var_282_12.prefab_name].transform, "story_v_out_116292", "116292067", "story_v_out_116292.awb")

						arg_279_1:RecordAudio("116292067", var_282_17)
						arg_279_1:RecordAudio("116292067", var_282_17)
					else
						arg_279_1:AudioAction("play", "voice", "story_v_out_116292", "116292067", "story_v_out_116292.awb")
					end

					arg_279_1:RecordHistoryTalkVoice("story_v_out_116292", "116292067", "story_v_out_116292.awb")
				end

				arg_279_1:RecordContent(arg_279_1.text_.text)
			end

			local var_282_18 = math.max(var_282_11, arg_279_1.talkMaxDuration)

			if var_282_10 <= arg_279_1.time_ and arg_279_1.time_ < var_282_10 + var_282_18 then
				arg_279_1.typewritter.percent = (arg_279_1.time_ - var_282_10) / var_282_18

				arg_279_1.typewritter:SetDirty()
			end

			if arg_279_1.time_ >= var_282_10 + var_282_18 and arg_279_1.time_ < var_282_10 + var_282_18 + arg_282_0 then
				arg_279_1.typewritter.percent = 1

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(true)
			end
		end

		arg_279_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1059ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
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

		arg_279_1:InitPlayNodeList()
	end,
	Play116292068 = function(arg_283_0, arg_283_1)
		arg_283_1.time_ = 0
		arg_283_1.frameCnt_ = 0
		arg_283_1.state_ = "playing"
		arg_283_1.curTalkId_ = 116292068
		arg_283_1.duration_ = 5

		SetActive(arg_283_1.tipsGo_, false)

		function arg_283_1.onSingleLineFinish_()
			arg_283_1.onSingleLineUpdate_ = nil
			arg_283_1.onSingleLineFinish_ = nil
			arg_283_1.state_ = "waiting"
		end

		function arg_283_1.playNext_(arg_285_0)
			if arg_285_0 == 1 then
				arg_283_0:Play116292069(arg_283_1)
			end
		end

		function arg_283_1.onSingleLineUpdate_(arg_286_0)
			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 then
				arg_283_1.var_.moveOldPos10025ui_story = arg_283_1.actors_["10025ui_story"].transform.localPosition
			end

			local var_286_0 = 0.001

			if 0 <= arg_283_1.time_ and arg_283_1.time_ < 0 + var_286_0 then
				arg_283_1.actors_["10025ui_story"].transform.localPosition = Vector3.Lerp(arg_283_1.var_.moveOldPos10025ui_story, Vector3.New(0, 100, 0), (arg_283_1.time_ - 0) / var_286_0)
				arg_283_1.actors_["10025ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_283_1.actors_["10025ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_283_1.actors_["10025ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_283_1.actors_["10025ui_story"].transform.position).z)
				arg_283_1.actors_["10025ui_story"].transform.localEulerAngles.z = 0
				arg_283_1.actors_["10025ui_story"].transform.localEulerAngles.x = 0
				arg_283_1.actors_["10025ui_story"].transform.localEulerAngles = arg_283_1.actors_["10025ui_story"].transform.localEulerAngles
			end

			if arg_283_1.time_ >= 0 + var_286_0 and arg_283_1.time_ < 0 + var_286_0 + arg_286_0 then
				arg_283_1.actors_["10025ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_283_1.actors_["10025ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_283_1.actors_["10025ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_283_1.actors_["10025ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_283_1.actors_["10025ui_story"].transform.position).z)
				arg_283_1.actors_["10025ui_story"].transform.localEulerAngles.z = 0
				arg_283_1.actors_["10025ui_story"].transform.localEulerAngles.x = 0
				arg_283_1.actors_["10025ui_story"].transform.localEulerAngles = arg_283_1.actors_["10025ui_story"].transform.localEulerAngles
			end

			local var_286_1 = 0
			local var_286_2 = 1.025

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= var_286_1 + arg_286_0 then
				arg_283_1.talkMaxDuration = 0
				arg_283_1.dialogCg_.alpha = 1

				arg_283_1.dialog_:SetActive(true)
				SetActive(arg_283_1.leftNameGo_, false)

				arg_283_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_283_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_283_1:RecordName(arg_283_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_283_1.iconTrs_.gameObject, false)
				arg_283_1.callingController_:SetSelectedState("normal")

				local var_286_3 = arg_283_1:FormatText(arg_283_1:GetWordFromCfg(116292068).content)

				arg_283_1.text_.text = var_286_3

				LuaForUtil.ClearLinePrefixSymbol(arg_283_1.text_)

				local var_286_5 = 41 <= 0 and var_286_2 or var_286_2 * (utf8.len(var_286_3) / 41)

				if (41 <= 0 and var_286_2 or var_286_2 * (utf8.len(var_286_3) / 41)) > 0 and var_286_2 < var_286_5 then
					arg_283_1.talkMaxDuration = var_286_5

					if var_286_5 + var_286_1 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_5 + var_286_1
					end
				end

				arg_283_1.text_.text = var_286_3
				arg_283_1.typewritter.percent = 0

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(false)
				arg_283_1:RecordContent(arg_283_1.text_.text)
			end

			local var_286_6 = math.max(var_286_2, arg_283_1.talkMaxDuration)

			if var_286_1 <= arg_283_1.time_ and arg_283_1.time_ < var_286_1 + var_286_6 then
				arg_283_1.typewritter.percent = (arg_283_1.time_ - var_286_1) / var_286_6

				arg_283_1.typewritter:SetDirty()
			end

			if arg_283_1.time_ >= var_286_1 + var_286_6 and arg_283_1.time_ < var_286_1 + var_286_6 + arg_286_0 then
				arg_283_1.typewritter.percent = 1

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(true)
			end
		end

		arg_283_1.nodeConfigList_ = {
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

		arg_283_1:InitPlayNodeList()
	end,
	Play116292069 = function(arg_287_0, arg_287_1)
		arg_287_1.time_ = 0
		arg_287_1.frameCnt_ = 0
		arg_287_1.state_ = "playing"
		arg_287_1.curTalkId_ = 116292069
		arg_287_1.duration_ = 8.3

		local var_287_0 = {
			zh = 6.2,
			ja = 8.3
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
				arg_287_0:Play116292070(arg_287_1)
			end
		end

		function arg_287_1.onSingleLineUpdate_(arg_290_0)
			local var_290_0 = 0.35

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 then
				arg_287_1.talkMaxDuration = 0
				arg_287_1.dialogCg_.alpha = 1

				arg_287_1.dialog_:SetActive(true)
				SetActive(arg_287_1.leftNameGo_, true)

				arg_287_1.leftNameTxt_.text = arg_287_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_287_1.leftNameTxt_.transform)

				arg_287_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_287_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_287_1:RecordName(arg_287_1.leftNameTxt_.text)
				SetActive(arg_287_1.iconTrs_.gameObject, true)
				arg_287_1.iconController_:SetSelectedState("hero")

				arg_287_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1028")

				arg_287_1.callingController_:SetSelectedState("normal")

				arg_287_1.keyicon_.color = Color.New(1, 1, 1)
				arg_287_1.icon_.color = Color.New(1, 1, 1)

				local var_290_1 = arg_287_1:GetWordFromCfg(116292069)
				local var_290_2 = arg_287_1:FormatText(var_290_1.content)

				arg_287_1.text_.text = var_290_2

				LuaForUtil.ClearLinePrefixSymbol(arg_287_1.text_)

				local var_290_4 = 14 <= 0 and var_290_0 or var_290_0 * (utf8.len(var_290_2) / 14)

				if (14 <= 0 and var_290_0 or var_290_0 * (utf8.len(var_290_2) / 14)) > 0 and var_290_0 < var_290_4 then
					arg_287_1.talkMaxDuration = var_290_4

					if var_290_4 + 0 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_4 + 0
					end
				end

				arg_287_1.text_.text = var_290_2
				arg_287_1.typewritter.percent = 0

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116292", "116292069", "story_v_out_116292.awb") ~= 0 then
					local var_290_5 = manager.audio:GetVoiceLength("story_v_out_116292", "116292069", "story_v_out_116292.awb") / 1000

					if var_290_5 + 0 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_5 + 0
					end

					if var_290_1.prefab_name ~= "" and arg_287_1.actors_[var_290_1.prefab_name] ~= nil then
						local var_290_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_287_1.actors_[var_290_1.prefab_name].transform, "story_v_out_116292", "116292069", "story_v_out_116292.awb")

						arg_287_1:RecordAudio("116292069", var_290_6)
						arg_287_1:RecordAudio("116292069", var_290_6)
					else
						arg_287_1:AudioAction("play", "voice", "story_v_out_116292", "116292069", "story_v_out_116292.awb")
					end

					arg_287_1:RecordHistoryTalkVoice("story_v_out_116292", "116292069", "story_v_out_116292.awb")
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
	Play116292070 = function(arg_291_0, arg_291_1)
		arg_291_1.time_ = 0
		arg_291_1.frameCnt_ = 0
		arg_291_1.state_ = "playing"
		arg_291_1.curTalkId_ = 116292070
		arg_291_1.duration_ = 4.57

		local var_291_0 = {
			zh = 4.5,
			ja = 4.566
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
				arg_291_0:Play116292071(arg_291_1)
			end
		end

		function arg_291_1.onSingleLineUpdate_(arg_294_0)
			if 0 < arg_291_1.time_ and arg_291_1.time_ <= 0 + arg_294_0 then
				arg_291_1.var_.moveOldPos1184ui_story = arg_291_1.actors_["1184ui_story"].transform.localPosition

				arg_291_1:ShowWeapon(arg_291_1.var_["1184ui_story" .. "Animator"].transform, false)
			end

			local var_294_0 = 0.001

			if 0 <= arg_291_1.time_ and arg_291_1.time_ < 0 + var_294_0 then
				arg_291_1.actors_["1184ui_story"].transform.localPosition = Vector3.Lerp(arg_291_1.var_.moveOldPos1184ui_story, Vector3.New(0, -0.97, -6), (arg_291_1.time_ - 0) / var_294_0)
				arg_291_1.actors_["1184ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_291_1.actors_["1184ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_291_1.actors_["1184ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_291_1.actors_["1184ui_story"].transform.position).z)
				arg_291_1.actors_["1184ui_story"].transform.localEulerAngles.z = 0
				arg_291_1.actors_["1184ui_story"].transform.localEulerAngles.x = 0
				arg_291_1.actors_["1184ui_story"].transform.localEulerAngles = arg_291_1.actors_["1184ui_story"].transform.localEulerAngles
			end

			if arg_291_1.time_ >= 0 + var_294_0 and arg_291_1.time_ < 0 + var_294_0 + arg_294_0 then
				arg_291_1.actors_["1184ui_story"].transform.localPosition = Vector3.New(0, -0.97, -6)
				arg_291_1.actors_["1184ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_291_1.actors_["1184ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_291_1.actors_["1184ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_291_1.actors_["1184ui_story"].transform.position).z)
				arg_291_1.actors_["1184ui_story"].transform.localEulerAngles.z = 0
				arg_291_1.actors_["1184ui_story"].transform.localEulerAngles.x = 0
				arg_291_1.actors_["1184ui_story"].transform.localEulerAngles = arg_291_1.actors_["1184ui_story"].transform.localEulerAngles
			end

			local var_294_1 = "1028ui_story"

			if arg_291_1.actors_["1028ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1028ui_story"))) then
				local var_294_2 = Object.Instantiate(Asset.Load("Char/" .. "1028ui_story"), arg_291_1.stage_.transform)

				var_294_2.name = var_294_1
				var_294_2.transform.localPosition = Vector3.New(0, 100, 0)
				arg_291_1.actors_[var_294_1] = var_294_2

				local var_294_3 = var_294_2:GetComponentInChildren(typeof(CharacterEffect))

				var_294_3.enabled = true

				local var_294_4 = GameObjectTools.GetOrAddComponent(var_294_2, typeof(DynamicBoneHelper))

				if var_294_4 then
					var_294_4:EnableDynamicBone(false)
				end

				arg_291_1:ShowWeapon(var_294_3.transform, false)

				arg_291_1.var_[var_294_1 .. "Animator"] = var_294_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_291_1.var_[var_294_1 .. "Animator"].applyRootMotion = true
				arg_291_1.var_[var_294_1 .. "LipSync"] = var_294_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_294_5 = arg_291_1.actors_["1028ui_story"]

			if 0 < arg_291_1.time_ and arg_291_1.time_ <= 0 + arg_294_0 and not isNil(var_294_5) and arg_291_1.var_.characterEffect1028ui_story == nil then
				arg_291_1.var_.characterEffect1028ui_story = var_294_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_294_6 = 0.2

			if 0 <= arg_291_1.time_ and arg_291_1.time_ < 0 + var_294_6 and not isNil(var_294_5) then
				if arg_291_1.var_.characterEffect1028ui_story and not isNil(var_294_5) then
					arg_291_1.var_.characterEffect1028ui_story.fillFlat = true
					arg_291_1.var_.characterEffect1028ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_291_1.time_ - 0) / var_294_6)
				end
			end

			if arg_291_1.time_ >= 0 + var_294_6 and arg_291_1.time_ < 0 + var_294_6 + arg_294_0 and not isNil(var_294_5) and arg_291_1.var_.characterEffect1028ui_story then
				arg_291_1.var_.characterEffect1028ui_story.fillFlat = true
				arg_291_1.var_.characterEffect1028ui_story.fillRatio = 0.5
			end

			local var_294_7 = arg_291_1.actors_["1184ui_story"]

			if 0 < arg_291_1.time_ and arg_291_1.time_ <= 0 + arg_294_0 and not isNil(var_294_7) and arg_291_1.var_.characterEffect1184ui_story == nil then
				arg_291_1.var_.characterEffect1184ui_story = var_294_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_294_8 = 0.2

			if 0 <= arg_291_1.time_ and arg_291_1.time_ < 0 + var_294_8 and not isNil(var_294_7) then
				if arg_291_1.var_.characterEffect1184ui_story and not isNil(var_294_7) then
					arg_291_1.var_.characterEffect1184ui_story.fillFlat = false
				end
			end

			if arg_291_1.time_ >= 0 + var_294_8 and arg_291_1.time_ < 0 + var_294_8 + arg_294_0 and not isNil(var_294_7) and arg_291_1.var_.characterEffect1184ui_story then
				arg_291_1.var_.characterEffect1184ui_story.fillFlat = false
			end

			if 0 < arg_291_1.time_ and arg_291_1.time_ <= 0 + arg_294_0 then
				arg_291_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_1")
			end

			if 0 < arg_291_1.time_ and arg_291_1.time_ <= 0 + arg_294_0 then
				arg_291_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_294_10 = 0
			local var_294_11 = 0.3

			if 0 < arg_291_1.time_ and arg_291_1.time_ <= var_294_10 + arg_294_0 then
				arg_291_1.talkMaxDuration = 0
				arg_291_1.dialogCg_.alpha = 1

				arg_291_1.dialog_:SetActive(true)
				SetActive(arg_291_1.leftNameGo_, true)

				arg_291_1.leftNameTxt_.text = arg_291_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_291_1.leftNameTxt_.transform)

				arg_291_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_291_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_291_1:RecordName(arg_291_1.leftNameTxt_.text)
				SetActive(arg_291_1.iconTrs_.gameObject, false)
				arg_291_1.callingController_:SetSelectedState("normal")

				local var_294_12 = arg_291_1:GetWordFromCfg(116292070)
				local var_294_13 = arg_291_1:FormatText(var_294_12.content)

				arg_291_1.text_.text = var_294_13

				LuaForUtil.ClearLinePrefixSymbol(arg_291_1.text_)

				local var_294_15 = 12 <= 0 and var_294_11 or var_294_11 * (utf8.len(var_294_13) / 12)

				if (12 <= 0 and var_294_11 or var_294_11 * (utf8.len(var_294_13) / 12)) > 0 and var_294_11 < var_294_15 then
					arg_291_1.talkMaxDuration = var_294_15

					if var_294_15 + var_294_10 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_15 + var_294_10
					end
				end

				arg_291_1.text_.text = var_294_13
				arg_291_1.typewritter.percent = 0

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116292", "116292070", "story_v_out_116292.awb") ~= 0 then
					local var_294_16 = manager.audio:GetVoiceLength("story_v_out_116292", "116292070", "story_v_out_116292.awb") / 1000

					if var_294_16 + var_294_10 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_16 + var_294_10
					end

					if var_294_12.prefab_name ~= "" and arg_291_1.actors_[var_294_12.prefab_name] ~= nil then
						local var_294_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_291_1.actors_[var_294_12.prefab_name].transform, "story_v_out_116292", "116292070", "story_v_out_116292.awb")

						arg_291_1:RecordAudio("116292070", var_294_17)
						arg_291_1:RecordAudio("116292070", var_294_17)
					else
						arg_291_1:AudioAction("play", "voice", "story_v_out_116292", "116292070", "story_v_out_116292.awb")
					end

					arg_291_1:RecordHistoryTalkVoice("story_v_out_116292", "116292070", "story_v_out_116292.awb")
				end

				arg_291_1:RecordContent(arg_291_1.text_.text)
			end

			local var_294_18 = math.max(var_294_11, arg_291_1.talkMaxDuration)

			if var_294_10 <= arg_291_1.time_ and arg_291_1.time_ < var_294_10 + var_294_18 then
				arg_291_1.typewritter.percent = (arg_291_1.time_ - var_294_10) / var_294_18

				arg_291_1.typewritter:SetDirty()
			end

			if arg_291_1.time_ >= var_294_10 + var_294_18 and arg_291_1.time_ < var_294_10 + var_294_18 + arg_294_0 then
				arg_291_1.typewritter.percent = 1

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(true)
			end
		end

		arg_291_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1184ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_291_1:InitPlayNodeList()
	end,
	Play116292071 = function(arg_295_0, arg_295_1)
		arg_295_1.time_ = 0
		arg_295_1.frameCnt_ = 0
		arg_295_1.state_ = "playing"
		arg_295_1.curTalkId_ = 116292071
		arg_295_1.duration_ = 13.57

		local var_295_0 = {
			zh = 8.133,
			ja = 13.566
		}
		local var_295_1 = manager.audio:GetLocalizationFlag()

		if var_295_0[var_295_1] ~= nil then
			arg_295_1.duration_ = var_295_0[var_295_1]
		end

		SetActive(arg_295_1.tipsGo_, false)

		function arg_295_1.onSingleLineFinish_()
			arg_295_1.onSingleLineUpdate_ = nil
			arg_295_1.onSingleLineFinish_ = nil
			arg_295_1.state_ = "waiting"
		end

		function arg_295_1.playNext_(arg_297_0)
			if arg_297_0 == 1 then
				arg_295_0:Play116292072(arg_295_1)
			end
		end

		function arg_295_1.onSingleLineUpdate_(arg_298_0)
			if 0 < arg_295_1.time_ and arg_295_1.time_ <= 0 + arg_298_0 and not isNil(arg_295_1.actors_["1028ui_story"]) and arg_295_1.var_.characterEffect1028ui_story == nil then
				arg_295_1.var_.characterEffect1028ui_story = arg_295_1.actors_["1028ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_298_0 = 0.2

			if 0 <= arg_295_1.time_ and arg_295_1.time_ < 0 + var_298_0 and not isNil(arg_295_1.actors_["1028ui_story"]) then
				if arg_295_1.var_.characterEffect1028ui_story and not isNil(arg_295_1.actors_["1028ui_story"]) then
					arg_295_1.var_.characterEffect1028ui_story.fillFlat = false
				end
			end

			if arg_295_1.time_ >= 0 + var_298_0 and arg_295_1.time_ < 0 + var_298_0 + arg_298_0 and not isNil(arg_295_1.actors_["1028ui_story"]) and arg_295_1.var_.characterEffect1028ui_story then
				arg_295_1.var_.characterEffect1028ui_story.fillFlat = false
			end

			local var_298_2 = arg_295_1.actors_["1184ui_story"]

			if 0 < arg_295_1.time_ and arg_295_1.time_ <= 0 + arg_298_0 and not isNil(var_298_2) and arg_295_1.var_.characterEffect1184ui_story == nil then
				arg_295_1.var_.characterEffect1184ui_story = var_298_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_298_3 = 0.2

			if 0 <= arg_295_1.time_ and arg_295_1.time_ < 0 + var_298_3 and not isNil(var_298_2) then
				if arg_295_1.var_.characterEffect1184ui_story and not isNil(var_298_2) then
					arg_295_1.var_.characterEffect1184ui_story.fillFlat = true
					arg_295_1.var_.characterEffect1184ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_295_1.time_ - 0) / var_298_3)
				end
			end

			if arg_295_1.time_ >= 0 + var_298_3 and arg_295_1.time_ < 0 + var_298_3 + arg_298_0 and not isNil(var_298_2) and arg_295_1.var_.characterEffect1184ui_story then
				arg_295_1.var_.characterEffect1184ui_story.fillFlat = true
				arg_295_1.var_.characterEffect1184ui_story.fillRatio = 0.5
			end

			if 0 < arg_295_1.time_ and arg_295_1.time_ <= 0 + arg_298_0 then
				arg_295_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_298_4 = 0
			local var_298_5 = 0.925

			if 0 < arg_295_1.time_ and arg_295_1.time_ <= var_298_4 + arg_298_0 then
				arg_295_1.talkMaxDuration = 0
				arg_295_1.dialogCg_.alpha = 1

				arg_295_1.dialog_:SetActive(true)
				SetActive(arg_295_1.leftNameGo_, true)

				arg_295_1.leftNameTxt_.text = arg_295_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_295_1.leftNameTxt_.transform)

				arg_295_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_295_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_295_1:RecordName(arg_295_1.leftNameTxt_.text)
				SetActive(arg_295_1.iconTrs_.gameObject, true)
				arg_295_1.iconController_:SetSelectedState("hero")

				arg_295_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1028")

				arg_295_1.callingController_:SetSelectedState("normal")

				arg_295_1.keyicon_.color = Color.New(1, 1, 1)
				arg_295_1.icon_.color = Color.New(1, 1, 1)

				local var_298_6 = arg_295_1:GetWordFromCfg(116292071)
				local var_298_7 = arg_295_1:FormatText(var_298_6.content)

				arg_295_1.text_.text = var_298_7

				LuaForUtil.ClearLinePrefixSymbol(arg_295_1.text_)

				local var_298_9 = 37 <= 0 and var_298_5 or var_298_5 * (utf8.len(var_298_7) / 37)

				if (37 <= 0 and var_298_5 or var_298_5 * (utf8.len(var_298_7) / 37)) > 0 and var_298_5 < var_298_9 then
					arg_295_1.talkMaxDuration = var_298_9

					if var_298_9 + var_298_4 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_9 + var_298_4
					end
				end

				arg_295_1.text_.text = var_298_7
				arg_295_1.typewritter.percent = 0

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116292", "116292071", "story_v_out_116292.awb") ~= 0 then
					local var_298_10 = manager.audio:GetVoiceLength("story_v_out_116292", "116292071", "story_v_out_116292.awb") / 1000

					if var_298_10 + var_298_4 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_10 + var_298_4
					end

					if var_298_6.prefab_name ~= "" and arg_295_1.actors_[var_298_6.prefab_name] ~= nil then
						local var_298_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_295_1.actors_[var_298_6.prefab_name].transform, "story_v_out_116292", "116292071", "story_v_out_116292.awb")

						arg_295_1:RecordAudio("116292071", var_298_11)
						arg_295_1:RecordAudio("116292071", var_298_11)
					else
						arg_295_1:AudioAction("play", "voice", "story_v_out_116292", "116292071", "story_v_out_116292.awb")
					end

					arg_295_1:RecordHistoryTalkVoice("story_v_out_116292", "116292071", "story_v_out_116292.awb")
				end

				arg_295_1:RecordContent(arg_295_1.text_.text)
			end

			local var_298_12 = math.max(var_298_5, arg_295_1.talkMaxDuration)

			if var_298_4 <= arg_295_1.time_ and arg_295_1.time_ < var_298_4 + var_298_12 then
				arg_295_1.typewritter.percent = (arg_295_1.time_ - var_298_4) / var_298_12

				arg_295_1.typewritter:SetDirty()
			end

			if arg_295_1.time_ >= var_298_4 + var_298_12 and arg_295_1.time_ < var_298_4 + var_298_12 + arg_298_0 then
				arg_295_1.typewritter.percent = 1

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(true)
			end
		end

		arg_295_1.nodeConfigList_ = {}

		arg_295_1:InitPlayNodeList()
	end,
	Play116292072 = function(arg_299_0, arg_299_1)
		arg_299_1.time_ = 0
		arg_299_1.frameCnt_ = 0
		arg_299_1.state_ = "playing"
		arg_299_1.curTalkId_ = 116292072
		arg_299_1.duration_ = 7.07

		local var_299_0 = {
			zh = 4.1,
			ja = 7.066
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
				arg_299_0:Play116292073(arg_299_1)
			end
		end

		function arg_299_1.onSingleLineUpdate_(arg_302_0)
			if 0 < arg_299_1.time_ and arg_299_1.time_ <= 0 + arg_302_0 then
				arg_299_1.var_.moveOldPos1059ui_story = arg_299_1.actors_["1059ui_story"].transform.localPosition
			end

			local var_302_0 = 0.001

			if 0 <= arg_299_1.time_ and arg_299_1.time_ < 0 + var_302_0 then
				arg_299_1.actors_["1059ui_story"].transform.localPosition = Vector3.Lerp(arg_299_1.var_.moveOldPos1059ui_story, Vector3.New(-0.7, -1.05, -6), (arg_299_1.time_ - 0) / var_302_0)
				arg_299_1.actors_["1059ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_299_1.actors_["1059ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_299_1.actors_["1059ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_299_1.actors_["1059ui_story"].transform.position).z)
				arg_299_1.actors_["1059ui_story"].transform.localEulerAngles.z = 0
				arg_299_1.actors_["1059ui_story"].transform.localEulerAngles.x = 0
				arg_299_1.actors_["1059ui_story"].transform.localEulerAngles = arg_299_1.actors_["1059ui_story"].transform.localEulerAngles
			end

			if arg_299_1.time_ >= 0 + var_302_0 and arg_299_1.time_ < 0 + var_302_0 + arg_302_0 then
				arg_299_1.actors_["1059ui_story"].transform.localPosition = Vector3.New(-0.7, -1.05, -6)
				arg_299_1.actors_["1059ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_299_1.actors_["1059ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_299_1.actors_["1059ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_299_1.actors_["1059ui_story"].transform.position).z)
				arg_299_1.actors_["1059ui_story"].transform.localEulerAngles.z = 0
				arg_299_1.actors_["1059ui_story"].transform.localEulerAngles.x = 0
				arg_299_1.actors_["1059ui_story"].transform.localEulerAngles = arg_299_1.actors_["1059ui_story"].transform.localEulerAngles
			end

			local var_302_1 = arg_299_1.actors_["1028ui_story"].transform

			if 0 < arg_299_1.time_ and arg_299_1.time_ <= 0 + arg_302_0 then
				arg_299_1.var_.moveOldPos1028ui_story = var_302_1.localPosition
			end

			local var_302_2 = 0.001

			if 0 <= arg_299_1.time_ and arg_299_1.time_ < 0 + var_302_2 then
				var_302_1.localPosition = Vector3.Lerp(arg_299_1.var_.moveOldPos1028ui_story, Vector3.New(0, 100, 0), (arg_299_1.time_ - 0) / var_302_2)
				var_302_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_302_1.position).x, (manager.ui.mainCamera.transform.position - var_302_1.position).y, (manager.ui.mainCamera.transform.position - var_302_1.position).z)
				var_302_1.localEulerAngles.z = 0
				var_302_1.localEulerAngles.x = 0
				var_302_1.localEulerAngles = var_302_1.localEulerAngles
			end

			if arg_299_1.time_ >= 0 + var_302_2 and arg_299_1.time_ < 0 + var_302_2 + arg_302_0 then
				var_302_1.localPosition = Vector3.New(0, 100, 0)
				var_302_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_302_1.position).x, (manager.ui.mainCamera.transform.position - var_302_1.position).y, (manager.ui.mainCamera.transform.position - var_302_1.position).z)
				var_302_1.localEulerAngles.z = 0
				var_302_1.localEulerAngles.x = 0
				var_302_1.localEulerAngles = var_302_1.localEulerAngles
			end

			local var_302_3 = arg_299_1.actors_["1184ui_story"].transform

			if 0 < arg_299_1.time_ and arg_299_1.time_ <= 0 + arg_302_0 then
				arg_299_1.var_.moveOldPos1184ui_story = var_302_3.localPosition
			end

			local var_302_4 = 0.001

			if 0 <= arg_299_1.time_ and arg_299_1.time_ < 0 + var_302_4 then
				var_302_3.localPosition = Vector3.Lerp(arg_299_1.var_.moveOldPos1184ui_story, Vector3.New(0, 100, 0), (arg_299_1.time_ - 0) / var_302_4)
				var_302_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_302_3.position).x, (manager.ui.mainCamera.transform.position - var_302_3.position).y, (manager.ui.mainCamera.transform.position - var_302_3.position).z)
				var_302_3.localEulerAngles.z = 0
				var_302_3.localEulerAngles.x = 0
				var_302_3.localEulerAngles = var_302_3.localEulerAngles
			end

			if arg_299_1.time_ >= 0 + var_302_4 and arg_299_1.time_ < 0 + var_302_4 + arg_302_0 then
				var_302_3.localPosition = Vector3.New(0, 100, 0)
				var_302_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_302_3.position).x, (manager.ui.mainCamera.transform.position - var_302_3.position).y, (manager.ui.mainCamera.transform.position - var_302_3.position).z)
				var_302_3.localEulerAngles.z = 0
				var_302_3.localEulerAngles.x = 0
				var_302_3.localEulerAngles = var_302_3.localEulerAngles
			end

			local var_302_5 = arg_299_1.actors_["1059ui_story"]

			if 0 < arg_299_1.time_ and arg_299_1.time_ <= 0 + arg_302_0 and not isNil(var_302_5) and arg_299_1.var_.characterEffect1059ui_story == nil then
				arg_299_1.var_.characterEffect1059ui_story = var_302_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_302_6 = 0.2

			if 0 <= arg_299_1.time_ and arg_299_1.time_ < 0 + var_302_6 and not isNil(var_302_5) then
				if arg_299_1.var_.characterEffect1059ui_story and not isNil(var_302_5) then
					arg_299_1.var_.characterEffect1059ui_story.fillFlat = false
				end
			end

			if arg_299_1.time_ >= 0 + var_302_6 and arg_299_1.time_ < 0 + var_302_6 + arg_302_0 and not isNil(var_302_5) and arg_299_1.var_.characterEffect1059ui_story then
				arg_299_1.var_.characterEffect1059ui_story.fillFlat = false
			end

			if 0 < arg_299_1.time_ and arg_299_1.time_ <= 0 + arg_302_0 then
				arg_299_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/story1059/story1059action/1059action2_1")
			end

			if 0 < arg_299_1.time_ and arg_299_1.time_ <= 0 + arg_302_0 then
				arg_299_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_302_8 = 0
			local var_302_9 = 0.475

			if 0 < arg_299_1.time_ and arg_299_1.time_ <= var_302_8 + arg_302_0 then
				arg_299_1.talkMaxDuration = 0
				arg_299_1.dialogCg_.alpha = 1

				arg_299_1.dialog_:SetActive(true)
				SetActive(arg_299_1.leftNameGo_, true)

				arg_299_1.leftNameTxt_.text = arg_299_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_299_1.leftNameTxt_.transform)

				arg_299_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_299_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_299_1:RecordName(arg_299_1.leftNameTxt_.text)
				SetActive(arg_299_1.iconTrs_.gameObject, false)
				arg_299_1.callingController_:SetSelectedState("normal")

				local var_302_10 = arg_299_1:GetWordFromCfg(116292072)
				local var_302_11 = arg_299_1:FormatText(var_302_10.content)

				arg_299_1.text_.text = var_302_11

				LuaForUtil.ClearLinePrefixSymbol(arg_299_1.text_)

				local var_302_13 = 19 <= 0 and var_302_9 or var_302_9 * (utf8.len(var_302_11) / 19)

				if (19 <= 0 and var_302_9 or var_302_9 * (utf8.len(var_302_11) / 19)) > 0 and var_302_9 < var_302_13 then
					arg_299_1.talkMaxDuration = var_302_13

					if var_302_13 + var_302_8 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_13 + var_302_8
					end
				end

				arg_299_1.text_.text = var_302_11
				arg_299_1.typewritter.percent = 0

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116292", "116292072", "story_v_out_116292.awb") ~= 0 then
					local var_302_14 = manager.audio:GetVoiceLength("story_v_out_116292", "116292072", "story_v_out_116292.awb") / 1000

					if var_302_14 + var_302_8 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_14 + var_302_8
					end

					if var_302_10.prefab_name ~= "" and arg_299_1.actors_[var_302_10.prefab_name] ~= nil then
						local var_302_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_299_1.actors_[var_302_10.prefab_name].transform, "story_v_out_116292", "116292072", "story_v_out_116292.awb")

						arg_299_1:RecordAudio("116292072", var_302_15)
						arg_299_1:RecordAudio("116292072", var_302_15)
					else
						arg_299_1:AudioAction("play", "voice", "story_v_out_116292", "116292072", "story_v_out_116292.awb")
					end

					arg_299_1:RecordHistoryTalkVoice("story_v_out_116292", "116292072", "story_v_out_116292.awb")
				end

				arg_299_1:RecordContent(arg_299_1.text_.text)
			end

			local var_302_16 = math.max(var_302_9, arg_299_1.talkMaxDuration)

			if var_302_8 <= arg_299_1.time_ and arg_299_1.time_ < var_302_8 + var_302_16 then
				arg_299_1.typewritter.percent = (arg_299_1.time_ - var_302_8) / var_302_16

				arg_299_1.typewritter:SetDirty()
			end

			if arg_299_1.time_ >= var_302_8 + var_302_16 and arg_299_1.time_ < var_302_8 + var_302_16 + arg_302_0 then
				arg_299_1.typewritter.percent = 1

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(true)
			end
		end

		arg_299_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1059ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1028ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1184ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_299_1:InitPlayNodeList()
	end,
	Play116292073 = function(arg_303_0, arg_303_1)
		arg_303_1.time_ = 0
		arg_303_1.frameCnt_ = 0
		arg_303_1.state_ = "playing"
		arg_303_1.curTalkId_ = 116292073
		arg_303_1.duration_ = 3.93

		local var_303_0 = {
			zh = 3.733,
			ja = 3.933
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
			arg_303_1.auto_ = false
		end

		function arg_303_1.playNext_(arg_305_0)
			arg_303_1.onStoryFinished_()
		end

		function arg_303_1.onSingleLineUpdate_(arg_306_0)
			if 0 < arg_303_1.time_ and arg_303_1.time_ <= 0 + arg_306_0 and not isNil(arg_303_1.actors_["1059ui_story"]) and arg_303_1.var_.characterEffect1059ui_story == nil then
				arg_303_1.var_.characterEffect1059ui_story = arg_303_1.actors_["1059ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_306_0 = 0.2

			if 0 <= arg_303_1.time_ and arg_303_1.time_ < 0 + var_306_0 and not isNil(arg_303_1.actors_["1059ui_story"]) then
				if arg_303_1.var_.characterEffect1059ui_story and not isNil(arg_303_1.actors_["1059ui_story"]) then
					arg_303_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_303_1.var_.characterEffect1059ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_303_1.time_ - 0) / var_306_0)
				end
			end

			if arg_303_1.time_ >= 0 + var_306_0 and arg_303_1.time_ < 0 + var_306_0 + arg_306_0 and not isNil(arg_303_1.actors_["1059ui_story"]) and arg_303_1.var_.characterEffect1059ui_story then
				arg_303_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_303_1.var_.characterEffect1059ui_story.fillRatio = 0.5
			end

			local var_306_1 = arg_303_1.actors_["1148ui_story"]

			if 0 < arg_303_1.time_ and arg_303_1.time_ <= 0 + arg_306_0 and not isNil(var_306_1) and arg_303_1.var_.characterEffect1148ui_story == nil then
				arg_303_1.var_.characterEffect1148ui_story = var_306_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_306_2 = 0.2

			if 0 <= arg_303_1.time_ and arg_303_1.time_ < 0 + var_306_2 and not isNil(var_306_1) then
				if arg_303_1.var_.characterEffect1148ui_story and not isNil(var_306_1) then
					arg_303_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_303_1.time_ >= 0 + var_306_2 and arg_303_1.time_ < 0 + var_306_2 + arg_306_0 and not isNil(var_306_1) and arg_303_1.var_.characterEffect1148ui_story then
				arg_303_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			if 0 < arg_303_1.time_ and arg_303_1.time_ <= 0 + arg_306_0 then
				arg_303_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1048/story1048action/1048action3_1")
			end

			if 0 < arg_303_1.time_ and arg_303_1.time_ <= 0 + arg_306_0 then
				arg_303_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_306_4 = arg_303_1.actors_["1148ui_story"].transform

			if 0 < arg_303_1.time_ and arg_303_1.time_ <= 0 + arg_306_0 then
				arg_303_1.var_.moveOldPos1148ui_story = var_306_4.localPosition
			end

			local var_306_5 = 0.001

			if 0 <= arg_303_1.time_ and arg_303_1.time_ < 0 + var_306_5 then
				var_306_4.localPosition = Vector3.Lerp(arg_303_1.var_.moveOldPos1148ui_story, Vector3.New(0.7, -0.8, -6.2), (arg_303_1.time_ - 0) / var_306_5)
				var_306_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_306_4.position).x, (manager.ui.mainCamera.transform.position - var_306_4.position).y, (manager.ui.mainCamera.transform.position - var_306_4.position).z)
				var_306_4.localEulerAngles.z = 0
				var_306_4.localEulerAngles.x = 0
				var_306_4.localEulerAngles = var_306_4.localEulerAngles
			end

			if arg_303_1.time_ >= 0 + var_306_5 and arg_303_1.time_ < 0 + var_306_5 + arg_306_0 then
				var_306_4.localPosition = Vector3.New(0.7, -0.8, -6.2)
				var_306_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_306_4.position).x, (manager.ui.mainCamera.transform.position - var_306_4.position).y, (manager.ui.mainCamera.transform.position - var_306_4.position).z)
				var_306_4.localEulerAngles.z = 0
				var_306_4.localEulerAngles.x = 0
				var_306_4.localEulerAngles = var_306_4.localEulerAngles
			end

			local var_306_6 = 0
			local var_306_7 = 0.575

			if 0 < arg_303_1.time_ and arg_303_1.time_ <= var_306_6 + arg_306_0 then
				arg_303_1.talkMaxDuration = 0
				arg_303_1.dialogCg_.alpha = 1

				arg_303_1.dialog_:SetActive(true)
				SetActive(arg_303_1.leftNameGo_, true)

				arg_303_1.leftNameTxt_.text = arg_303_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_303_1.leftNameTxt_.transform)

				arg_303_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_303_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_303_1:RecordName(arg_303_1.leftNameTxt_.text)
				SetActive(arg_303_1.iconTrs_.gameObject, false)
				arg_303_1.callingController_:SetSelectedState("normal")

				local var_306_8 = arg_303_1:GetWordFromCfg(116292073)
				local var_306_9 = arg_303_1:FormatText(var_306_8.content)

				arg_303_1.text_.text = var_306_9

				LuaForUtil.ClearLinePrefixSymbol(arg_303_1.text_)

				local var_306_11 = 23 <= 0 and var_306_7 or var_306_7 * (utf8.len(var_306_9) / 23)

				if (23 <= 0 and var_306_7 or var_306_7 * (utf8.len(var_306_9) / 23)) > 0 and var_306_7 < var_306_11 then
					arg_303_1.talkMaxDuration = var_306_11

					if var_306_11 + var_306_6 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_11 + var_306_6
					end
				end

				arg_303_1.text_.text = var_306_9
				arg_303_1.typewritter.percent = 0

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116292", "116292073", "story_v_out_116292.awb") ~= 0 then
					local var_306_12 = manager.audio:GetVoiceLength("story_v_out_116292", "116292073", "story_v_out_116292.awb") / 1000

					if var_306_12 + var_306_6 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_12 + var_306_6
					end

					if var_306_8.prefab_name ~= "" and arg_303_1.actors_[var_306_8.prefab_name] ~= nil then
						local var_306_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_303_1.actors_[var_306_8.prefab_name].transform, "story_v_out_116292", "116292073", "story_v_out_116292.awb")

						arg_303_1:RecordAudio("116292073", var_306_13)
						arg_303_1:RecordAudio("116292073", var_306_13)
					else
						arg_303_1:AudioAction("play", "voice", "story_v_out_116292", "116292073", "story_v_out_116292.awb")
					end

					arg_303_1:RecordHistoryTalkVoice("story_v_out_116292", "116292073", "story_v_out_116292.awb")
				end

				arg_303_1:RecordContent(arg_303_1.text_.text)
			end

			local var_306_14 = math.max(var_306_7, arg_303_1.talkMaxDuration)

			if var_306_6 <= arg_303_1.time_ and arg_303_1.time_ < var_306_6 + var_306_14 then
				arg_303_1.typewritter.percent = (arg_303_1.time_ - var_306_6) / var_306_14

				arg_303_1.typewritter:SetDirty()
			end

			if arg_303_1.time_ >= var_306_6 + var_306_14 and arg_303_1.time_ < var_306_6 + var_306_14 + arg_306_0 then
				arg_303_1.typewritter.percent = 1

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(true)
			end
		end

		arg_303_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_303_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/B13c",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/SK0204",
		"TextureConfig/Background/SK0204a"
	},
	voices = {
		"story_v_out_116292.awb"
	}
}
