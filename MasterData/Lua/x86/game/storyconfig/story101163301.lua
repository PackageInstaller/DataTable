return {
	Play116331001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 116331001
		arg_1_1.duration_ = 5.77

		local var_1_0 = {
			zh = 4.6,
			ja = 5.766
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
				arg_1_0:Play116331002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.I07a == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "I07a")
				var_4_0.name = "I07a"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.I07a = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.I07a

				arg_1_1.bgs_.I07a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "I07a" then
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

			if 0.4 < arg_1_1.time_ and arg_1_1.time_ <= 0.4 + arg_4_0 then
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

			if 0.575 < arg_1_1.time_ and arg_1_1.time_ <= 0.575 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_1_6_story_story", "corg", "bgm_activity_1_6_story_story.awb")

				if MusicRecordCfg[96].musicName ~= "" then
					if arg_1_1.bgmTxt_.text ~= MusicRecordCfg[96].musicName and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = MusicRecordCfg[96].musicName

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = MusicRecordCfg[96].musicName
						arg_1_1.bgmTxt2_.text = MusicRecordCfg[96].musicName
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
			local var_4_15 = 0.3

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

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[337].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10046")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_17 = arg_1_1:GetWordFromCfg(116331001)
				local var_4_18 = arg_1_1:FormatText(var_4_17.content)

				arg_1_1.text_.text = var_4_18

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_20 = 12 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_18) / 12)

				if (12 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_18) / 12)) > 0 and var_4_15 < var_4_20 then
					arg_1_1.talkMaxDuration = var_4_20
					var_4_14 = var_4_14 + 0.3

					if var_4_20 + var_4_14 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_20 + var_4_14
					end
				end

				arg_1_1.text_.text = var_4_18
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116331", "116331001", "story_v_out_116331.awb") ~= 0 then
					local var_4_21 = manager.audio:GetVoiceLength("story_v_out_116331", "116331001", "story_v_out_116331.awb") / 1000

					if var_4_21 + var_4_14 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_21 + var_4_14
					end

					if var_4_17.prefab_name ~= "" and arg_1_1.actors_[var_4_17.prefab_name] ~= nil then
						local var_4_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_17.prefab_name].transform, "story_v_out_116331", "116331001", "story_v_out_116331.awb")

						arg_1_1:RecordAudio("116331001", var_4_22)
						arg_1_1:RecordAudio("116331001", var_4_22)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_116331", "116331001", "story_v_out_116331.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_116331", "116331001", "story_v_out_116331.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_23 = var_4_14 + 0.3
			local var_4_24 = math.max(var_4_15, arg_1_1.talkMaxDuration)

			if var_4_14 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_23 + var_4_24 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_23) / var_4_24

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_23 + var_4_24 and arg_1_1.time_ < var_4_23 + var_4_24 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play116331002 = function(arg_10_0, arg_10_1)
		arg_10_1.time_ = 0
		arg_10_1.frameCnt_ = 0
		arg_10_1.state_ = "playing"
		arg_10_1.curTalkId_ = 116331002
		arg_10_1.duration_ = 13.77

		local var_10_0 = {
			zh = 11.8,
			ja = 13.766
		}
		local var_10_1 = manager.audio:GetLocalizationFlag()

		if var_10_0[var_10_1] ~= nil then
			arg_10_1.duration_ = var_10_0[var_10_1]
		end

		SetActive(arg_10_1.tipsGo_, false)

		function arg_10_1.onSingleLineFinish_()
			arg_10_1.onSingleLineUpdate_ = nil
			arg_10_1.onSingleLineFinish_ = nil
			arg_10_1.state_ = "waiting"
		end

		function arg_10_1.playNext_(arg_12_0)
			if arg_12_0 == 1 then
				arg_10_0:Play116331003(arg_10_1)
			end
		end

		function arg_10_1.onSingleLineUpdate_(arg_13_0)
			if arg_10_1.actors_["10032ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10032ui_story"))) then
				local var_13_0 = Object.Instantiate(Asset.Load("Char/" .. "10032ui_story"), arg_10_1.stage_.transform)

				var_13_0.name = "10032ui_story"
				var_13_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_10_1.actors_["10032ui_story"] = var_13_0

				local var_13_1 = var_13_0:GetComponentInChildren(typeof(CharacterEffect))

				var_13_1.enabled = true

				local var_13_2 = GameObjectTools.GetOrAddComponent(var_13_0, typeof(DynamicBoneHelper))

				if var_13_2 then
					var_13_2:EnableDynamicBone(false)
				end

				arg_10_1:ShowWeapon(var_13_1.transform, false)

				arg_10_1.var_["10032ui_story" .. "Animator"] = var_13_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_10_1.var_["10032ui_story" .. "Animator"].applyRootMotion = true
				arg_10_1.var_["10032ui_story" .. "LipSync"] = var_13_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_13_3 = arg_10_1.actors_["10032ui_story"].transform

			if 0 < arg_10_1.time_ and arg_10_1.time_ <= 0 + arg_13_0 then
				arg_10_1.var_.moveOldPos10032ui_story = var_13_3.localPosition
			end

			local var_13_4 = 0.001

			if 0 <= arg_10_1.time_ and arg_10_1.time_ < 0 + var_13_4 then
				var_13_3.localPosition = Vector3.Lerp(arg_10_1.var_.moveOldPos10032ui_story, Vector3.New(0, -1.1, -5.9), (arg_10_1.time_ - 0) / var_13_4)
				var_13_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_13_3.position).x, (manager.ui.mainCamera.transform.position - var_13_3.position).y, (manager.ui.mainCamera.transform.position - var_13_3.position).z)
				var_13_3.localEulerAngles.z = 0
				var_13_3.localEulerAngles.x = 0
				var_13_3.localEulerAngles = var_13_3.localEulerAngles
			end

			if arg_10_1.time_ >= 0 + var_13_4 and arg_10_1.time_ < 0 + var_13_4 + arg_13_0 then
				var_13_3.localPosition = Vector3.New(0, -1.1, -5.9)
				var_13_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_13_3.position).x, (manager.ui.mainCamera.transform.position - var_13_3.position).y, (manager.ui.mainCamera.transform.position - var_13_3.position).z)
				var_13_3.localEulerAngles.z = 0
				var_13_3.localEulerAngles.x = 0
				var_13_3.localEulerAngles = var_13_3.localEulerAngles
			end

			if 0 < arg_10_1.time_ and arg_10_1.time_ <= 0 + arg_13_0 then
				arg_10_1:PlayTimeline("10032ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action1_1")
			end

			if 0 < arg_10_1.time_ and arg_10_1.time_ <= 0 + arg_13_0 then
				arg_10_1:PlayTimeline("10032ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_13_5 = arg_10_1.actors_["10032ui_story"]

			if 0 < arg_10_1.time_ and arg_10_1.time_ <= 0 + arg_13_0 and not isNil(var_13_5) and arg_10_1.var_.characterEffect10032ui_story == nil then
				arg_10_1.var_.characterEffect10032ui_story = var_13_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_13_6 = 0.2

			if 0 <= arg_10_1.time_ and arg_10_1.time_ < 0 + var_13_6 and not isNil(var_13_5) then
				if arg_10_1.var_.characterEffect10032ui_story and not isNil(var_13_5) then
					arg_10_1.var_.characterEffect10032ui_story.fillFlat = false
				end
			end

			if arg_10_1.time_ >= 0 + var_13_6 and arg_10_1.time_ < 0 + var_13_6 + arg_13_0 and not isNil(var_13_5) and arg_10_1.var_.characterEffect10032ui_story then
				arg_10_1.var_.characterEffect10032ui_story.fillFlat = false
			end

			local var_13_8 = 0
			local var_13_9 = 0.975

			if 0 < arg_10_1.time_ and arg_10_1.time_ <= var_13_8 + arg_13_0 then
				arg_10_1.talkMaxDuration = 0
				arg_10_1.dialogCg_.alpha = 1

				arg_10_1.dialog_:SetActive(true)
				SetActive(arg_10_1.leftNameGo_, true)

				arg_10_1.leftNameTxt_.text = arg_10_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_10_1.leftNameTxt_.transform)

				arg_10_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_10_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_10_1:RecordName(arg_10_1.leftNameTxt_.text)
				SetActive(arg_10_1.iconTrs_.gameObject, false)
				arg_10_1.callingController_:SetSelectedState("normal")

				local var_13_10 = arg_10_1:GetWordFromCfg(116331002)
				local var_13_11 = arg_10_1:FormatText(var_13_10.content)

				arg_10_1.text_.text = var_13_11

				LuaForUtil.ClearLinePrefixSymbol(arg_10_1.text_)

				local var_13_13 = 39 <= 0 and var_13_9 or var_13_9 * (utf8.len(var_13_11) / 39)

				if (39 <= 0 and var_13_9 or var_13_9 * (utf8.len(var_13_11) / 39)) > 0 and var_13_9 < var_13_13 then
					arg_10_1.talkMaxDuration = var_13_13

					if var_13_13 + var_13_8 > arg_10_1.duration_ then
						arg_10_1.duration_ = var_13_13 + var_13_8
					end
				end

				arg_10_1.text_.text = var_13_11
				arg_10_1.typewritter.percent = 0

				arg_10_1.typewritter:SetDirty()
				arg_10_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116331", "116331002", "story_v_out_116331.awb") ~= 0 then
					local var_13_14 = manager.audio:GetVoiceLength("story_v_out_116331", "116331002", "story_v_out_116331.awb") / 1000

					if var_13_14 + var_13_8 > arg_10_1.duration_ then
						arg_10_1.duration_ = var_13_14 + var_13_8
					end

					if var_13_10.prefab_name ~= "" and arg_10_1.actors_[var_13_10.prefab_name] ~= nil then
						local var_13_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_10_1.actors_[var_13_10.prefab_name].transform, "story_v_out_116331", "116331002", "story_v_out_116331.awb")

						arg_10_1:RecordAudio("116331002", var_13_15)
						arg_10_1:RecordAudio("116331002", var_13_15)
					else
						arg_10_1:AudioAction("play", "voice", "story_v_out_116331", "116331002", "story_v_out_116331.awb")
					end

					arg_10_1:RecordHistoryTalkVoice("story_v_out_116331", "116331002", "story_v_out_116331.awb")
				end

				arg_10_1:RecordContent(arg_10_1.text_.text)
			end

			local var_13_16 = math.max(var_13_9, arg_10_1.talkMaxDuration)

			if var_13_8 <= arg_10_1.time_ and arg_10_1.time_ < var_13_8 + var_13_16 then
				arg_10_1.typewritter.percent = (arg_10_1.time_ - var_13_8) / var_13_16

				arg_10_1.typewritter:SetDirty()
			end

			if arg_10_1.time_ >= var_13_8 + var_13_16 and arg_10_1.time_ < var_13_8 + var_13_16 + arg_13_0 then
				arg_10_1.typewritter.percent = 1

				arg_10_1.typewritter:SetDirty()
				arg_10_1:ShowNextGo(true)
			end
		end

		arg_10_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10032ui_story",
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
	Play116331003 = function(arg_14_0, arg_14_1)
		arg_14_1.time_ = 0
		arg_14_1.frameCnt_ = 0
		arg_14_1.state_ = "playing"
		arg_14_1.curTalkId_ = 116331003
		arg_14_1.duration_ = 1.9

		local var_14_0 = {
			zh = 1.9,
			ja = 1.433
		}
		local var_14_1 = manager.audio:GetLocalizationFlag()

		if var_14_0[var_14_1] ~= nil then
			arg_14_1.duration_ = var_14_0[var_14_1]
		end

		SetActive(arg_14_1.tipsGo_, false)

		function arg_14_1.onSingleLineFinish_()
			arg_14_1.onSingleLineUpdate_ = nil
			arg_14_1.onSingleLineFinish_ = nil
			arg_14_1.state_ = "waiting"
		end

		function arg_14_1.playNext_(arg_16_0)
			if arg_16_0 == 1 then
				arg_14_0:Play116331004(arg_14_1)
			end
		end

		function arg_14_1.onSingleLineUpdate_(arg_17_0)
			if 0 < arg_14_1.time_ and arg_14_1.time_ <= 0 + arg_17_0 and not isNil(arg_14_1.actors_["10032ui_story"]) and arg_14_1.var_.characterEffect10032ui_story == nil then
				arg_14_1.var_.characterEffect10032ui_story = arg_14_1.actors_["10032ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_17_0 = 0.2

			if 0 <= arg_14_1.time_ and arg_14_1.time_ < 0 + var_17_0 and not isNil(arg_14_1.actors_["10032ui_story"]) then
				if arg_14_1.var_.characterEffect10032ui_story and not isNil(arg_14_1.actors_["10032ui_story"]) then
					arg_14_1.var_.characterEffect10032ui_story.fillFlat = true
					arg_14_1.var_.characterEffect10032ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_14_1.time_ - 0) / var_17_0)
				end
			end

			if arg_14_1.time_ >= 0 + var_17_0 and arg_14_1.time_ < 0 + var_17_0 + arg_17_0 and not isNil(arg_14_1.actors_["10032ui_story"]) and arg_14_1.var_.characterEffect10032ui_story then
				arg_14_1.var_.characterEffect10032ui_story.fillFlat = true
				arg_14_1.var_.characterEffect10032ui_story.fillRatio = 0.5
			end

			local var_17_1 = 0
			local var_17_2 = 0.25

			if 0 < arg_14_1.time_ and arg_14_1.time_ <= var_17_1 + arg_17_0 then
				arg_14_1.talkMaxDuration = 0
				arg_14_1.dialogCg_.alpha = 1

				arg_14_1.dialog_:SetActive(true)
				SetActive(arg_14_1.leftNameGo_, true)

				arg_14_1.leftNameTxt_.text = arg_14_1:FormatText(StoryNameCfg[337].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_14_1.leftNameTxt_.transform)

				arg_14_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_14_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_14_1:RecordName(arg_14_1.leftNameTxt_.text)
				SetActive(arg_14_1.iconTrs_.gameObject, true)
				arg_14_1.iconController_:SetSelectedState("hero")

				arg_14_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10046")

				arg_14_1.callingController_:SetSelectedState("normal")

				arg_14_1.keyicon_.color = Color.New(1, 1, 1)
				arg_14_1.icon_.color = Color.New(1, 1, 1)

				local var_17_3 = arg_14_1:GetWordFromCfg(116331003)
				local var_17_4 = arg_14_1:FormatText(var_17_3.content)

				arg_14_1.text_.text = var_17_4

				LuaForUtil.ClearLinePrefixSymbol(arg_14_1.text_)

				local var_17_6 = 10 <= 0 and var_17_2 or var_17_2 * (utf8.len(var_17_4) / 10)

				if (10 <= 0 and var_17_2 or var_17_2 * (utf8.len(var_17_4) / 10)) > 0 and var_17_2 < var_17_6 then
					arg_14_1.talkMaxDuration = var_17_6

					if var_17_6 + var_17_1 > arg_14_1.duration_ then
						arg_14_1.duration_ = var_17_6 + var_17_1
					end
				end

				arg_14_1.text_.text = var_17_4
				arg_14_1.typewritter.percent = 0

				arg_14_1.typewritter:SetDirty()
				arg_14_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116331", "116331003", "story_v_out_116331.awb") ~= 0 then
					local var_17_7 = manager.audio:GetVoiceLength("story_v_out_116331", "116331003", "story_v_out_116331.awb") / 1000

					if var_17_7 + var_17_1 > arg_14_1.duration_ then
						arg_14_1.duration_ = var_17_7 + var_17_1
					end

					if var_17_3.prefab_name ~= "" and arg_14_1.actors_[var_17_3.prefab_name] ~= nil then
						local var_17_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_14_1.actors_[var_17_3.prefab_name].transform, "story_v_out_116331", "116331003", "story_v_out_116331.awb")

						arg_14_1:RecordAudio("116331003", var_17_8)
						arg_14_1:RecordAudio("116331003", var_17_8)
					else
						arg_14_1:AudioAction("play", "voice", "story_v_out_116331", "116331003", "story_v_out_116331.awb")
					end

					arg_14_1:RecordHistoryTalkVoice("story_v_out_116331", "116331003", "story_v_out_116331.awb")
				end

				arg_14_1:RecordContent(arg_14_1.text_.text)
			end

			local var_17_9 = math.max(var_17_2, arg_14_1.talkMaxDuration)

			if var_17_1 <= arg_14_1.time_ and arg_14_1.time_ < var_17_1 + var_17_9 then
				arg_14_1.typewritter.percent = (arg_14_1.time_ - var_17_1) / var_17_9

				arg_14_1.typewritter:SetDirty()
			end

			if arg_14_1.time_ >= var_17_1 + var_17_9 and arg_14_1.time_ < var_17_1 + var_17_9 + arg_17_0 then
				arg_14_1.typewritter.percent = 1

				arg_14_1.typewritter:SetDirty()
				arg_14_1:ShowNextGo(true)
			end
		end

		arg_14_1.nodeConfigList_ = {}

		arg_14_1:InitPlayNodeList()
	end,
	Play116331004 = function(arg_18_0, arg_18_1)
		arg_18_1.time_ = 0
		arg_18_1.frameCnt_ = 0
		arg_18_1.state_ = "playing"
		arg_18_1.curTalkId_ = 116331004
		arg_18_1.duration_ = 2.97

		local var_18_0 = {
			zh = 2.966,
			ja = 2.666
		}
		local var_18_1 = manager.audio:GetLocalizationFlag()

		if var_18_0[var_18_1] ~= nil then
			arg_18_1.duration_ = var_18_0[var_18_1]
		end

		SetActive(arg_18_1.tipsGo_, false)

		function arg_18_1.onSingleLineFinish_()
			arg_18_1.onSingleLineUpdate_ = nil
			arg_18_1.onSingleLineFinish_ = nil
			arg_18_1.state_ = "waiting"
		end

		function arg_18_1.playNext_(arg_20_0)
			if arg_20_0 == 1 then
				arg_18_0:Play116331005(arg_18_1)
			end
		end

		function arg_18_1.onSingleLineUpdate_(arg_21_0)
			if 0 < arg_18_1.time_ and arg_18_1.time_ <= 0 + arg_21_0 then
				arg_18_1.var_.moveOldPos10032ui_story = arg_18_1.actors_["10032ui_story"].transform.localPosition
			end

			local var_21_0 = 0.001

			if 0 <= arg_18_1.time_ and arg_18_1.time_ < 0 + var_21_0 then
				arg_18_1.actors_["10032ui_story"].transform.localPosition = Vector3.Lerp(arg_18_1.var_.moveOldPos10032ui_story, Vector3.New(0, -1.1, -5.9), (arg_18_1.time_ - 0) / var_21_0)
				arg_18_1.actors_["10032ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_18_1.actors_["10032ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_18_1.actors_["10032ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_18_1.actors_["10032ui_story"].transform.position).z)
				arg_18_1.actors_["10032ui_story"].transform.localEulerAngles.z = 0
				arg_18_1.actors_["10032ui_story"].transform.localEulerAngles.x = 0
				arg_18_1.actors_["10032ui_story"].transform.localEulerAngles = arg_18_1.actors_["10032ui_story"].transform.localEulerAngles
			end

			if arg_18_1.time_ >= 0 + var_21_0 and arg_18_1.time_ < 0 + var_21_0 + arg_21_0 then
				arg_18_1.actors_["10032ui_story"].transform.localPosition = Vector3.New(0, -1.1, -5.9)
				arg_18_1.actors_["10032ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_18_1.actors_["10032ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_18_1.actors_["10032ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_18_1.actors_["10032ui_story"].transform.position).z)
				arg_18_1.actors_["10032ui_story"].transform.localEulerAngles.z = 0
				arg_18_1.actors_["10032ui_story"].transform.localEulerAngles.x = 0
				arg_18_1.actors_["10032ui_story"].transform.localEulerAngles = arg_18_1.actors_["10032ui_story"].transform.localEulerAngles
			end

			if 0 < arg_18_1.time_ and arg_18_1.time_ <= 0 + arg_21_0 then
				arg_18_1:PlayTimeline("10032ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action4_1")
			end

			if 0 < arg_18_1.time_ and arg_18_1.time_ <= 0 + arg_21_0 then
				arg_18_1:PlayTimeline("10032ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0204cva")
			end

			local var_21_1 = arg_18_1.actors_["10032ui_story"]

			if 0 < arg_18_1.time_ and arg_18_1.time_ <= 0 + arg_21_0 and not isNil(var_21_1) and arg_18_1.var_.characterEffect10032ui_story == nil then
				arg_18_1.var_.characterEffect10032ui_story = var_21_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_21_2 = 0.2

			if 0 <= arg_18_1.time_ and arg_18_1.time_ < 0 + var_21_2 and not isNil(var_21_1) then
				if arg_18_1.var_.characterEffect10032ui_story and not isNil(var_21_1) then
					arg_18_1.var_.characterEffect10032ui_story.fillFlat = false
				end
			end

			if arg_18_1.time_ >= 0 + var_21_2 and arg_18_1.time_ < 0 + var_21_2 + arg_21_0 and not isNil(var_21_1) and arg_18_1.var_.characterEffect10032ui_story then
				arg_18_1.var_.characterEffect10032ui_story.fillFlat = false
			end

			local var_21_4 = 0
			local var_21_5 = 0.2

			if 0 < arg_18_1.time_ and arg_18_1.time_ <= var_21_4 + arg_21_0 then
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

				local var_21_6 = arg_18_1:GetWordFromCfg(116331004)
				local var_21_7 = arg_18_1:FormatText(var_21_6.content)

				arg_18_1.text_.text = var_21_7

				LuaForUtil.ClearLinePrefixSymbol(arg_18_1.text_)

				local var_21_9 = 8 <= 0 and var_21_5 or var_21_5 * (utf8.len(var_21_7) / 8)

				if (8 <= 0 and var_21_5 or var_21_5 * (utf8.len(var_21_7) / 8)) > 0 and var_21_5 < var_21_9 then
					arg_18_1.talkMaxDuration = var_21_9

					if var_21_9 + var_21_4 > arg_18_1.duration_ then
						arg_18_1.duration_ = var_21_9 + var_21_4
					end
				end

				arg_18_1.text_.text = var_21_7
				arg_18_1.typewritter.percent = 0

				arg_18_1.typewritter:SetDirty()
				arg_18_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116331", "116331004", "story_v_out_116331.awb") ~= 0 then
					local var_21_10 = manager.audio:GetVoiceLength("story_v_out_116331", "116331004", "story_v_out_116331.awb") / 1000

					if var_21_10 + var_21_4 > arg_18_1.duration_ then
						arg_18_1.duration_ = var_21_10 + var_21_4
					end

					if var_21_6.prefab_name ~= "" and arg_18_1.actors_[var_21_6.prefab_name] ~= nil then
						local var_21_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_18_1.actors_[var_21_6.prefab_name].transform, "story_v_out_116331", "116331004", "story_v_out_116331.awb")

						arg_18_1:RecordAudio("116331004", var_21_11)
						arg_18_1:RecordAudio("116331004", var_21_11)
					else
						arg_18_1:AudioAction("play", "voice", "story_v_out_116331", "116331004", "story_v_out_116331.awb")
					end

					arg_18_1:RecordHistoryTalkVoice("story_v_out_116331", "116331004", "story_v_out_116331.awb")
				end

				arg_18_1:RecordContent(arg_18_1.text_.text)
			end

			local var_21_12 = math.max(var_21_5, arg_18_1.talkMaxDuration)

			if var_21_4 <= arg_18_1.time_ and arg_18_1.time_ < var_21_4 + var_21_12 then
				arg_18_1.typewritter.percent = (arg_18_1.time_ - var_21_4) / var_21_12

				arg_18_1.typewritter:SetDirty()
			end

			if arg_18_1.time_ >= var_21_4 + var_21_12 and arg_18_1.time_ < var_21_4 + var_21_12 + arg_21_0 then
				arg_18_1.typewritter.percent = 1

				arg_18_1.typewritter:SetDirty()
				arg_18_1:ShowNextGo(true)
			end
		end

		arg_18_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10032ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_18_1:InitPlayNodeList()
	end,
	Play116331005 = function(arg_22_0, arg_22_1)
		arg_22_1.time_ = 0
		arg_22_1.frameCnt_ = 0
		arg_22_1.state_ = "playing"
		arg_22_1.curTalkId_ = 116331005
		arg_22_1.duration_ = 8.7

		local var_22_0 = {
			zh = 5.333,
			ja = 8.7
		}
		local var_22_1 = manager.audio:GetLocalizationFlag()

		if var_22_0[var_22_1] ~= nil then
			arg_22_1.duration_ = var_22_0[var_22_1]
		end

		SetActive(arg_22_1.tipsGo_, false)

		function arg_22_1.onSingleLineFinish_()
			arg_22_1.onSingleLineUpdate_ = nil
			arg_22_1.onSingleLineFinish_ = nil
			arg_22_1.state_ = "waiting"
		end

		function arg_22_1.playNext_(arg_24_0)
			if arg_24_0 == 1 then
				arg_22_0:Play116331006(arg_22_1)
			end
		end

		function arg_22_1.onSingleLineUpdate_(arg_25_0)
			if 0 < arg_22_1.time_ and arg_22_1.time_ <= 0 + arg_25_0 and not isNil(arg_22_1.actors_["10032ui_story"]) and arg_22_1.var_.characterEffect10032ui_story == nil then
				arg_22_1.var_.characterEffect10032ui_story = arg_22_1.actors_["10032ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_25_0 = 0.2

			if 0 <= arg_22_1.time_ and arg_22_1.time_ < 0 + var_25_0 and not isNil(arg_22_1.actors_["10032ui_story"]) then
				if arg_22_1.var_.characterEffect10032ui_story and not isNil(arg_22_1.actors_["10032ui_story"]) then
					arg_22_1.var_.characterEffect10032ui_story.fillFlat = true
					arg_22_1.var_.characterEffect10032ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_22_1.time_ - 0) / var_25_0)
				end
			end

			if arg_22_1.time_ >= 0 + var_25_0 and arg_22_1.time_ < 0 + var_25_0 + arg_25_0 and not isNil(arg_22_1.actors_["10032ui_story"]) and arg_22_1.var_.characterEffect10032ui_story then
				arg_22_1.var_.characterEffect10032ui_story.fillFlat = true
				arg_22_1.var_.characterEffect10032ui_story.fillRatio = 0.5
			end

			local var_25_1 = 0
			local var_25_2 = 0.725

			if 0 < arg_22_1.time_ and arg_22_1.time_ <= var_25_1 + arg_25_0 then
				arg_22_1.talkMaxDuration = 0
				arg_22_1.dialogCg_.alpha = 1

				arg_22_1.dialog_:SetActive(true)
				SetActive(arg_22_1.leftNameGo_, true)

				arg_22_1.leftNameTxt_.text = arg_22_1:FormatText(StoryNameCfg[337].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_22_1.leftNameTxt_.transform)

				arg_22_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_22_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_22_1:RecordName(arg_22_1.leftNameTxt_.text)
				SetActive(arg_22_1.iconTrs_.gameObject, true)
				arg_22_1.iconController_:SetSelectedState("hero")

				arg_22_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10046")

				arg_22_1.callingController_:SetSelectedState("normal")

				arg_22_1.keyicon_.color = Color.New(1, 1, 1)
				arg_22_1.icon_.color = Color.New(1, 1, 1)

				local var_25_3 = arg_22_1:GetWordFromCfg(116331005)
				local var_25_4 = arg_22_1:FormatText(var_25_3.content)

				arg_22_1.text_.text = var_25_4

				LuaForUtil.ClearLinePrefixSymbol(arg_22_1.text_)

				local var_25_6 = 29 <= 0 and var_25_2 or var_25_2 * (utf8.len(var_25_4) / 29)

				if (29 <= 0 and var_25_2 or var_25_2 * (utf8.len(var_25_4) / 29)) > 0 and var_25_2 < var_25_6 then
					arg_22_1.talkMaxDuration = var_25_6

					if var_25_6 + var_25_1 > arg_22_1.duration_ then
						arg_22_1.duration_ = var_25_6 + var_25_1
					end
				end

				arg_22_1.text_.text = var_25_4
				arg_22_1.typewritter.percent = 0

				arg_22_1.typewritter:SetDirty()
				arg_22_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116331", "116331005", "story_v_out_116331.awb") ~= 0 then
					local var_25_7 = manager.audio:GetVoiceLength("story_v_out_116331", "116331005", "story_v_out_116331.awb") / 1000

					if var_25_7 + var_25_1 > arg_22_1.duration_ then
						arg_22_1.duration_ = var_25_7 + var_25_1
					end

					if var_25_3.prefab_name ~= "" and arg_22_1.actors_[var_25_3.prefab_name] ~= nil then
						local var_25_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_22_1.actors_[var_25_3.prefab_name].transform, "story_v_out_116331", "116331005", "story_v_out_116331.awb")

						arg_22_1:RecordAudio("116331005", var_25_8)
						arg_22_1:RecordAudio("116331005", var_25_8)
					else
						arg_22_1:AudioAction("play", "voice", "story_v_out_116331", "116331005", "story_v_out_116331.awb")
					end

					arg_22_1:RecordHistoryTalkVoice("story_v_out_116331", "116331005", "story_v_out_116331.awb")
				end

				arg_22_1:RecordContent(arg_22_1.text_.text)
			end

			local var_25_9 = math.max(var_25_2, arg_22_1.talkMaxDuration)

			if var_25_1 <= arg_22_1.time_ and arg_22_1.time_ < var_25_1 + var_25_9 then
				arg_22_1.typewritter.percent = (arg_22_1.time_ - var_25_1) / var_25_9

				arg_22_1.typewritter:SetDirty()
			end

			if arg_22_1.time_ >= var_25_1 + var_25_9 and arg_22_1.time_ < var_25_1 + var_25_9 + arg_25_0 then
				arg_22_1.typewritter.percent = 1

				arg_22_1.typewritter:SetDirty()
				arg_22_1:ShowNextGo(true)
			end
		end

		arg_22_1.nodeConfigList_ = {}

		arg_22_1:InitPlayNodeList()
	end,
	Play116331006 = function(arg_26_0, arg_26_1)
		arg_26_1.time_ = 0
		arg_26_1.frameCnt_ = 0
		arg_26_1.state_ = "playing"
		arg_26_1.curTalkId_ = 116331006
		arg_26_1.duration_ = 11.6

		local var_26_0 = {
			zh = 11.6,
			ja = 7.066
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
				arg_26_0:Play116331007(arg_26_1)
			end
		end

		function arg_26_1.onSingleLineUpdate_(arg_29_0)
			local var_29_0 = 1.2

			if 0 < arg_26_1.time_ and arg_26_1.time_ <= 0 + arg_29_0 then
				arg_26_1.talkMaxDuration = 0
				arg_26_1.dialogCg_.alpha = 1

				arg_26_1.dialog_:SetActive(true)
				SetActive(arg_26_1.leftNameGo_, true)

				arg_26_1.leftNameTxt_.text = arg_26_1:FormatText(StoryNameCfg[337].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_26_1.leftNameTxt_.transform)

				arg_26_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_26_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_26_1:RecordName(arg_26_1.leftNameTxt_.text)
				SetActive(arg_26_1.iconTrs_.gameObject, true)
				arg_26_1.iconController_:SetSelectedState("hero")

				arg_26_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10046")

				arg_26_1.callingController_:SetSelectedState("normal")

				arg_26_1.keyicon_.color = Color.New(1, 1, 1)
				arg_26_1.icon_.color = Color.New(1, 1, 1)

				local var_29_1 = arg_26_1:GetWordFromCfg(116331006)
				local var_29_2 = arg_26_1:FormatText(var_29_1.content)

				arg_26_1.text_.text = var_29_2

				LuaForUtil.ClearLinePrefixSymbol(arg_26_1.text_)

				local var_29_4 = 48 <= 0 and var_29_0 or var_29_0 * (utf8.len(var_29_2) / 48)

				if (48 <= 0 and var_29_0 or var_29_0 * (utf8.len(var_29_2) / 48)) > 0 and var_29_0 < var_29_4 then
					arg_26_1.talkMaxDuration = var_29_4

					if var_29_4 + 0 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_4 + 0
					end
				end

				arg_26_1.text_.text = var_29_2
				arg_26_1.typewritter.percent = 0

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116331", "116331006", "story_v_out_116331.awb") ~= 0 then
					local var_29_5 = manager.audio:GetVoiceLength("story_v_out_116331", "116331006", "story_v_out_116331.awb") / 1000

					if var_29_5 + 0 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_5 + 0
					end

					if var_29_1.prefab_name ~= "" and arg_26_1.actors_[var_29_1.prefab_name] ~= nil then
						local var_29_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_26_1.actors_[var_29_1.prefab_name].transform, "story_v_out_116331", "116331006", "story_v_out_116331.awb")

						arg_26_1:RecordAudio("116331006", var_29_6)
						arg_26_1:RecordAudio("116331006", var_29_6)
					else
						arg_26_1:AudioAction("play", "voice", "story_v_out_116331", "116331006", "story_v_out_116331.awb")
					end

					arg_26_1:RecordHistoryTalkVoice("story_v_out_116331", "116331006", "story_v_out_116331.awb")
				end

				arg_26_1:RecordContent(arg_26_1.text_.text)
			end

			local var_29_7 = math.max(var_29_0, arg_26_1.talkMaxDuration)

			if 0 <= arg_26_1.time_ and arg_26_1.time_ < 0 + var_29_7 then
				arg_26_1.typewritter.percent = (arg_26_1.time_ - 0) / var_29_7

				arg_26_1.typewritter:SetDirty()
			end

			if arg_26_1.time_ >= 0 + var_29_7 and arg_26_1.time_ < 0 + var_29_7 + arg_29_0 then
				arg_26_1.typewritter.percent = 1

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(true)
			end
		end

		arg_26_1.nodeConfigList_ = {}

		arg_26_1:InitPlayNodeList()
	end,
	Play116331007 = function(arg_30_0, arg_30_1)
		arg_30_1.time_ = 0
		arg_30_1.frameCnt_ = 0
		arg_30_1.state_ = "playing"
		arg_30_1.curTalkId_ = 116331007
		arg_30_1.duration_ = 7.63

		local var_30_0 = {
			zh = 7.633,
			ja = 6.7
		}
		local var_30_1 = manager.audio:GetLocalizationFlag()

		if var_30_0[var_30_1] ~= nil then
			arg_30_1.duration_ = var_30_0[var_30_1]
		end

		SetActive(arg_30_1.tipsGo_, false)

		function arg_30_1.onSingleLineFinish_()
			arg_30_1.onSingleLineUpdate_ = nil
			arg_30_1.onSingleLineFinish_ = nil
			arg_30_1.state_ = "waiting"
		end

		function arg_30_1.playNext_(arg_32_0)
			if arg_32_0 == 1 then
				arg_30_0:Play116331008(arg_30_1)
			end
		end

		function arg_30_1.onSingleLineUpdate_(arg_33_0)
			if 0 < arg_30_1.time_ and arg_30_1.time_ <= 0 + arg_33_0 then
				arg_30_1.var_.moveOldPos10032ui_story = arg_30_1.actors_["10032ui_story"].transform.localPosition
			end

			local var_33_0 = 0.001

			if 0 <= arg_30_1.time_ and arg_30_1.time_ < 0 + var_33_0 then
				arg_30_1.actors_["10032ui_story"].transform.localPosition = Vector3.Lerp(arg_30_1.var_.moveOldPos10032ui_story, Vector3.New(0, -1.1, -5.9), (arg_30_1.time_ - 0) / var_33_0)
				arg_30_1.actors_["10032ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_30_1.actors_["10032ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_30_1.actors_["10032ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_30_1.actors_["10032ui_story"].transform.position).z)
				arg_30_1.actors_["10032ui_story"].transform.localEulerAngles.z = 0
				arg_30_1.actors_["10032ui_story"].transform.localEulerAngles.x = 0
				arg_30_1.actors_["10032ui_story"].transform.localEulerAngles = arg_30_1.actors_["10032ui_story"].transform.localEulerAngles
			end

			if arg_30_1.time_ >= 0 + var_33_0 and arg_30_1.time_ < 0 + var_33_0 + arg_33_0 then
				arg_30_1.actors_["10032ui_story"].transform.localPosition = Vector3.New(0, -1.1, -5.9)
				arg_30_1.actors_["10032ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_30_1.actors_["10032ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_30_1.actors_["10032ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_30_1.actors_["10032ui_story"].transform.position).z)
				arg_30_1.actors_["10032ui_story"].transform.localEulerAngles.z = 0
				arg_30_1.actors_["10032ui_story"].transform.localEulerAngles.x = 0
				arg_30_1.actors_["10032ui_story"].transform.localEulerAngles = arg_30_1.actors_["10032ui_story"].transform.localEulerAngles
			end

			if 0 < arg_30_1.time_ and arg_30_1.time_ <= 0 + arg_33_0 then
				arg_30_1:PlayTimeline("10032ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action4_2")
			end

			if 0 < arg_30_1.time_ and arg_30_1.time_ <= 0 + arg_33_0 then
				arg_30_1:PlayTimeline("10032ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_33_1 = arg_30_1.actors_["10032ui_story"]

			if 0 < arg_30_1.time_ and arg_30_1.time_ <= 0 + arg_33_0 and not isNil(var_33_1) and arg_30_1.var_.characterEffect10032ui_story == nil then
				arg_30_1.var_.characterEffect10032ui_story = var_33_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_33_2 = 0.2

			if 0 <= arg_30_1.time_ and arg_30_1.time_ < 0 + var_33_2 and not isNil(var_33_1) then
				if arg_30_1.var_.characterEffect10032ui_story and not isNil(var_33_1) then
					arg_30_1.var_.characterEffect10032ui_story.fillFlat = false
				end
			end

			if arg_30_1.time_ >= 0 + var_33_2 and arg_30_1.time_ < 0 + var_33_2 + arg_33_0 and not isNil(var_33_1) and arg_30_1.var_.characterEffect10032ui_story then
				arg_30_1.var_.characterEffect10032ui_story.fillFlat = false
			end

			local var_33_4 = 0
			local var_33_5 = 0.65

			if 0 < arg_30_1.time_ and arg_30_1.time_ <= var_33_4 + arg_33_0 then
				arg_30_1.talkMaxDuration = 0
				arg_30_1.dialogCg_.alpha = 1

				arg_30_1.dialog_:SetActive(true)
				SetActive(arg_30_1.leftNameGo_, true)

				arg_30_1.leftNameTxt_.text = arg_30_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_30_1.leftNameTxt_.transform)

				arg_30_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_30_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_30_1:RecordName(arg_30_1.leftNameTxt_.text)
				SetActive(arg_30_1.iconTrs_.gameObject, false)
				arg_30_1.callingController_:SetSelectedState("normal")

				local var_33_6 = arg_30_1:GetWordFromCfg(116331007)
				local var_33_7 = arg_30_1:FormatText(var_33_6.content)

				arg_30_1.text_.text = var_33_7

				LuaForUtil.ClearLinePrefixSymbol(arg_30_1.text_)

				local var_33_9 = 26 <= 0 and var_33_5 or var_33_5 * (utf8.len(var_33_7) / 26)

				if (26 <= 0 and var_33_5 or var_33_5 * (utf8.len(var_33_7) / 26)) > 0 and var_33_5 < var_33_9 then
					arg_30_1.talkMaxDuration = var_33_9

					if var_33_9 + var_33_4 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_9 + var_33_4
					end
				end

				arg_30_1.text_.text = var_33_7
				arg_30_1.typewritter.percent = 0

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116331", "116331007", "story_v_out_116331.awb") ~= 0 then
					local var_33_10 = manager.audio:GetVoiceLength("story_v_out_116331", "116331007", "story_v_out_116331.awb") / 1000

					if var_33_10 + var_33_4 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_10 + var_33_4
					end

					if var_33_6.prefab_name ~= "" and arg_30_1.actors_[var_33_6.prefab_name] ~= nil then
						local var_33_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_30_1.actors_[var_33_6.prefab_name].transform, "story_v_out_116331", "116331007", "story_v_out_116331.awb")

						arg_30_1:RecordAudio("116331007", var_33_11)
						arg_30_1:RecordAudio("116331007", var_33_11)
					else
						arg_30_1:AudioAction("play", "voice", "story_v_out_116331", "116331007", "story_v_out_116331.awb")
					end

					arg_30_1:RecordHistoryTalkVoice("story_v_out_116331", "116331007", "story_v_out_116331.awb")
				end

				arg_30_1:RecordContent(arg_30_1.text_.text)
			end

			local var_33_12 = math.max(var_33_5, arg_30_1.talkMaxDuration)

			if var_33_4 <= arg_30_1.time_ and arg_30_1.time_ < var_33_4 + var_33_12 then
				arg_30_1.typewritter.percent = (arg_30_1.time_ - var_33_4) / var_33_12

				arg_30_1.typewritter:SetDirty()
			end

			if arg_30_1.time_ >= var_33_4 + var_33_12 and arg_30_1.time_ < var_33_4 + var_33_12 + arg_33_0 then
				arg_30_1.typewritter.percent = 1

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(true)
			end
		end

		arg_30_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10032ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_30_1:InitPlayNodeList()
	end,
	Play116331008 = function(arg_34_0, arg_34_1)
		arg_34_1.time_ = 0
		arg_34_1.frameCnt_ = 0
		arg_34_1.state_ = "playing"
		arg_34_1.curTalkId_ = 116331008
		arg_34_1.duration_ = 8.5

		local var_34_0 = {
			zh = 8.5,
			ja = 8.1
		}
		local var_34_1 = manager.audio:GetLocalizationFlag()

		if var_34_0[var_34_1] ~= nil then
			arg_34_1.duration_ = var_34_0[var_34_1]
		end

		SetActive(arg_34_1.tipsGo_, false)

		function arg_34_1.onSingleLineFinish_()
			arg_34_1.onSingleLineUpdate_ = nil
			arg_34_1.onSingleLineFinish_ = nil
			arg_34_1.state_ = "waiting"
		end

		function arg_34_1.playNext_(arg_36_0)
			if arg_36_0 == 1 then
				arg_34_0:Play116331009(arg_34_1)
			end
		end

		function arg_34_1.onSingleLineUpdate_(arg_37_0)
			if 0 < arg_34_1.time_ and arg_34_1.time_ <= 0 + arg_37_0 and not isNil(arg_34_1.actors_["10032ui_story"]) and arg_34_1.var_.characterEffect10032ui_story == nil then
				arg_34_1.var_.characterEffect10032ui_story = arg_34_1.actors_["10032ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_37_0 = 0.2

			if 0 <= arg_34_1.time_ and arg_34_1.time_ < 0 + var_37_0 and not isNil(arg_34_1.actors_["10032ui_story"]) then
				if arg_34_1.var_.characterEffect10032ui_story and not isNil(arg_34_1.actors_["10032ui_story"]) then
					arg_34_1.var_.characterEffect10032ui_story.fillFlat = true
					arg_34_1.var_.characterEffect10032ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_34_1.time_ - 0) / var_37_0)
				end
			end

			if arg_34_1.time_ >= 0 + var_37_0 and arg_34_1.time_ < 0 + var_37_0 + arg_37_0 and not isNil(arg_34_1.actors_["10032ui_story"]) and arg_34_1.var_.characterEffect10032ui_story then
				arg_34_1.var_.characterEffect10032ui_story.fillFlat = true
				arg_34_1.var_.characterEffect10032ui_story.fillRatio = 0.5
			end

			local var_37_1 = 0
			local var_37_2 = 1.025

			if 0 < arg_34_1.time_ and arg_34_1.time_ <= var_37_1 + arg_37_0 then
				arg_34_1.talkMaxDuration = 0
				arg_34_1.dialogCg_.alpha = 1

				arg_34_1.dialog_:SetActive(true)
				SetActive(arg_34_1.leftNameGo_, true)

				arg_34_1.leftNameTxt_.text = arg_34_1:FormatText(StoryNameCfg[337].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_34_1.leftNameTxt_.transform)

				arg_34_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_34_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_34_1:RecordName(arg_34_1.leftNameTxt_.text)
				SetActive(arg_34_1.iconTrs_.gameObject, true)
				arg_34_1.iconController_:SetSelectedState("hero")

				arg_34_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10046")

				arg_34_1.callingController_:SetSelectedState("normal")

				arg_34_1.keyicon_.color = Color.New(1, 1, 1)
				arg_34_1.icon_.color = Color.New(1, 1, 1)

				local var_37_3 = arg_34_1:GetWordFromCfg(116331008)
				local var_37_4 = arg_34_1:FormatText(var_37_3.content)

				arg_34_1.text_.text = var_37_4

				LuaForUtil.ClearLinePrefixSymbol(arg_34_1.text_)

				local var_37_6 = 41 <= 0 and var_37_2 or var_37_2 * (utf8.len(var_37_4) / 41)

				if (41 <= 0 and var_37_2 or var_37_2 * (utf8.len(var_37_4) / 41)) > 0 and var_37_2 < var_37_6 then
					arg_34_1.talkMaxDuration = var_37_6

					if var_37_6 + var_37_1 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_6 + var_37_1
					end
				end

				arg_34_1.text_.text = var_37_4
				arg_34_1.typewritter.percent = 0

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116331", "116331008", "story_v_out_116331.awb") ~= 0 then
					local var_37_7 = manager.audio:GetVoiceLength("story_v_out_116331", "116331008", "story_v_out_116331.awb") / 1000

					if var_37_7 + var_37_1 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_7 + var_37_1
					end

					if var_37_3.prefab_name ~= "" and arg_34_1.actors_[var_37_3.prefab_name] ~= nil then
						local var_37_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_34_1.actors_[var_37_3.prefab_name].transform, "story_v_out_116331", "116331008", "story_v_out_116331.awb")

						arg_34_1:RecordAudio("116331008", var_37_8)
						arg_34_1:RecordAudio("116331008", var_37_8)
					else
						arg_34_1:AudioAction("play", "voice", "story_v_out_116331", "116331008", "story_v_out_116331.awb")
					end

					arg_34_1:RecordHistoryTalkVoice("story_v_out_116331", "116331008", "story_v_out_116331.awb")
				end

				arg_34_1:RecordContent(arg_34_1.text_.text)
			end

			local var_37_9 = math.max(var_37_2, arg_34_1.talkMaxDuration)

			if var_37_1 <= arg_34_1.time_ and arg_34_1.time_ < var_37_1 + var_37_9 then
				arg_34_1.typewritter.percent = (arg_34_1.time_ - var_37_1) / var_37_9

				arg_34_1.typewritter:SetDirty()
			end

			if arg_34_1.time_ >= var_37_1 + var_37_9 and arg_34_1.time_ < var_37_1 + var_37_9 + arg_37_0 then
				arg_34_1.typewritter.percent = 1

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(true)
			end
		end

		arg_34_1.nodeConfigList_ = {}

		arg_34_1:InitPlayNodeList()
	end,
	Play116331009 = function(arg_38_0, arg_38_1)
		arg_38_1.time_ = 0
		arg_38_1.frameCnt_ = 0
		arg_38_1.state_ = "playing"
		arg_38_1.curTalkId_ = 116331009
		arg_38_1.duration_ = 3.33

		local var_38_0 = {
			zh = 3.333,
			ja = 2.866
		}
		local var_38_1 = manager.audio:GetLocalizationFlag()

		if var_38_0[var_38_1] ~= nil then
			arg_38_1.duration_ = var_38_0[var_38_1]
		end

		SetActive(arg_38_1.tipsGo_, false)

		function arg_38_1.onSingleLineFinish_()
			arg_38_1.onSingleLineUpdate_ = nil
			arg_38_1.onSingleLineFinish_ = nil
			arg_38_1.state_ = "waiting"
		end

		function arg_38_1.playNext_(arg_40_0)
			if arg_40_0 == 1 then
				arg_38_0:Play116331010(arg_38_1)
			end
		end

		function arg_38_1.onSingleLineUpdate_(arg_41_0)
			if 0 < arg_38_1.time_ and arg_38_1.time_ <= 0 + arg_41_0 then
				arg_38_1.var_.moveOldPos10032ui_story = arg_38_1.actors_["10032ui_story"].transform.localPosition
			end

			local var_41_0 = 0.001

			if 0 <= arg_38_1.time_ and arg_38_1.time_ < 0 + var_41_0 then
				arg_38_1.actors_["10032ui_story"].transform.localPosition = Vector3.Lerp(arg_38_1.var_.moveOldPos10032ui_story, Vector3.New(0, -1.1, -5.9), (arg_38_1.time_ - 0) / var_41_0)
				arg_38_1.actors_["10032ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_38_1.actors_["10032ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_38_1.actors_["10032ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_38_1.actors_["10032ui_story"].transform.position).z)
				arg_38_1.actors_["10032ui_story"].transform.localEulerAngles.z = 0
				arg_38_1.actors_["10032ui_story"].transform.localEulerAngles.x = 0
				arg_38_1.actors_["10032ui_story"].transform.localEulerAngles = arg_38_1.actors_["10032ui_story"].transform.localEulerAngles
			end

			if arg_38_1.time_ >= 0 + var_41_0 and arg_38_1.time_ < 0 + var_41_0 + arg_41_0 then
				arg_38_1.actors_["10032ui_story"].transform.localPosition = Vector3.New(0, -1.1, -5.9)
				arg_38_1.actors_["10032ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_38_1.actors_["10032ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_38_1.actors_["10032ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_38_1.actors_["10032ui_story"].transform.position).z)
				arg_38_1.actors_["10032ui_story"].transform.localEulerAngles.z = 0
				arg_38_1.actors_["10032ui_story"].transform.localEulerAngles.x = 0
				arg_38_1.actors_["10032ui_story"].transform.localEulerAngles = arg_38_1.actors_["10032ui_story"].transform.localEulerAngles
			end

			if 0 < arg_38_1.time_ and arg_38_1.time_ <= 0 + arg_41_0 then
				arg_38_1:PlayTimeline("10032ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action8_1")
			end

			if 0 < arg_38_1.time_ and arg_38_1.time_ <= 0 + arg_41_0 then
				arg_38_1:PlayTimeline("10032ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_41_1 = arg_38_1.actors_["10032ui_story"]

			if 0 < arg_38_1.time_ and arg_38_1.time_ <= 0 + arg_41_0 and not isNil(var_41_1) and arg_38_1.var_.characterEffect10032ui_story == nil then
				arg_38_1.var_.characterEffect10032ui_story = var_41_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_41_2 = 0.2

			if 0 <= arg_38_1.time_ and arg_38_1.time_ < 0 + var_41_2 and not isNil(var_41_1) then
				if arg_38_1.var_.characterEffect10032ui_story and not isNil(var_41_1) then
					arg_38_1.var_.characterEffect10032ui_story.fillFlat = false
				end
			end

			if arg_38_1.time_ >= 0 + var_41_2 and arg_38_1.time_ < 0 + var_41_2 + arg_41_0 and not isNil(var_41_1) and arg_38_1.var_.characterEffect10032ui_story then
				arg_38_1.var_.characterEffect10032ui_story.fillFlat = false
			end

			local var_41_4 = 0
			local var_41_5 = 0.175

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

				local var_41_6 = arg_38_1:GetWordFromCfg(116331009)
				local var_41_7 = arg_38_1:FormatText(var_41_6.content)

				arg_38_1.text_.text = var_41_7

				LuaForUtil.ClearLinePrefixSymbol(arg_38_1.text_)

				local var_41_9 = 7 <= 0 and var_41_5 or var_41_5 * (utf8.len(var_41_7) / 7)

				if (7 <= 0 and var_41_5 or var_41_5 * (utf8.len(var_41_7) / 7)) > 0 and var_41_5 < var_41_9 then
					arg_38_1.talkMaxDuration = var_41_9

					if var_41_9 + var_41_4 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_9 + var_41_4
					end
				end

				arg_38_1.text_.text = var_41_7
				arg_38_1.typewritter.percent = 0

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116331", "116331009", "story_v_out_116331.awb") ~= 0 then
					local var_41_10 = manager.audio:GetVoiceLength("story_v_out_116331", "116331009", "story_v_out_116331.awb") / 1000

					if var_41_10 + var_41_4 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_10 + var_41_4
					end

					if var_41_6.prefab_name ~= "" and arg_38_1.actors_[var_41_6.prefab_name] ~= nil then
						local var_41_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_38_1.actors_[var_41_6.prefab_name].transform, "story_v_out_116331", "116331009", "story_v_out_116331.awb")

						arg_38_1:RecordAudio("116331009", var_41_11)
						arg_38_1:RecordAudio("116331009", var_41_11)
					else
						arg_38_1:AudioAction("play", "voice", "story_v_out_116331", "116331009", "story_v_out_116331.awb")
					end

					arg_38_1:RecordHistoryTalkVoice("story_v_out_116331", "116331009", "story_v_out_116331.awb")
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
				actorName = "10032ui_story",
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
	Play116331010 = function(arg_42_0, arg_42_1)
		arg_42_1.time_ = 0
		arg_42_1.frameCnt_ = 0
		arg_42_1.state_ = "playing"
		arg_42_1.curTalkId_ = 116331010
		arg_42_1.duration_ = 14.53

		local var_42_0 = {
			zh = 6.3,
			ja = 14.533
		}
		local var_42_1 = manager.audio:GetLocalizationFlag()

		if var_42_0[var_42_1] ~= nil then
			arg_42_1.duration_ = var_42_0[var_42_1]
		end

		SetActive(arg_42_1.tipsGo_, false)

		function arg_42_1.onSingleLineFinish_()
			arg_42_1.onSingleLineUpdate_ = nil
			arg_42_1.onSingleLineFinish_ = nil
			arg_42_1.state_ = "waiting"
		end

		function arg_42_1.playNext_(arg_44_0)
			if arg_44_0 == 1 then
				arg_42_0:Play116331011(arg_42_1)
			end
		end

		function arg_42_1.onSingleLineUpdate_(arg_45_0)
			if 0 < arg_42_1.time_ and arg_42_1.time_ <= 0 + arg_45_0 and not isNil(arg_42_1.actors_["10032ui_story"]) and arg_42_1.var_.characterEffect10032ui_story == nil then
				arg_42_1.var_.characterEffect10032ui_story = arg_42_1.actors_["10032ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_45_0 = 0.2

			if 0 <= arg_42_1.time_ and arg_42_1.time_ < 0 + var_45_0 and not isNil(arg_42_1.actors_["10032ui_story"]) then
				if arg_42_1.var_.characterEffect10032ui_story and not isNil(arg_42_1.actors_["10032ui_story"]) then
					arg_42_1.var_.characterEffect10032ui_story.fillFlat = true
					arg_42_1.var_.characterEffect10032ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_42_1.time_ - 0) / var_45_0)
				end
			end

			if arg_42_1.time_ >= 0 + var_45_0 and arg_42_1.time_ < 0 + var_45_0 + arg_45_0 and not isNil(arg_42_1.actors_["10032ui_story"]) and arg_42_1.var_.characterEffect10032ui_story then
				arg_42_1.var_.characterEffect10032ui_story.fillFlat = true
				arg_42_1.var_.characterEffect10032ui_story.fillRatio = 0.5
			end

			local var_45_1 = 0
			local var_45_2 = 0.725

			if 0 < arg_42_1.time_ and arg_42_1.time_ <= var_45_1 + arg_45_0 then
				arg_42_1.talkMaxDuration = 0
				arg_42_1.dialogCg_.alpha = 1

				arg_42_1.dialog_:SetActive(true)
				SetActive(arg_42_1.leftNameGo_, true)

				arg_42_1.leftNameTxt_.text = arg_42_1:FormatText(StoryNameCfg[337].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_42_1.leftNameTxt_.transform)

				arg_42_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_42_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_42_1:RecordName(arg_42_1.leftNameTxt_.text)
				SetActive(arg_42_1.iconTrs_.gameObject, true)
				arg_42_1.iconController_:SetSelectedState("hero")

				arg_42_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10046")

				arg_42_1.callingController_:SetSelectedState("normal")

				arg_42_1.keyicon_.color = Color.New(1, 1, 1)
				arg_42_1.icon_.color = Color.New(1, 1, 1)

				local var_45_3 = arg_42_1:GetWordFromCfg(116331010)
				local var_45_4 = arg_42_1:FormatText(var_45_3.content)

				arg_42_1.text_.text = var_45_4

				LuaForUtil.ClearLinePrefixSymbol(arg_42_1.text_)

				local var_45_6 = 29 <= 0 and var_45_2 or var_45_2 * (utf8.len(var_45_4) / 29)

				if (29 <= 0 and var_45_2 or var_45_2 * (utf8.len(var_45_4) / 29)) > 0 and var_45_2 < var_45_6 then
					arg_42_1.talkMaxDuration = var_45_6

					if var_45_6 + var_45_1 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_6 + var_45_1
					end
				end

				arg_42_1.text_.text = var_45_4
				arg_42_1.typewritter.percent = 0

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116331", "116331010", "story_v_out_116331.awb") ~= 0 then
					local var_45_7 = manager.audio:GetVoiceLength("story_v_out_116331", "116331010", "story_v_out_116331.awb") / 1000

					if var_45_7 + var_45_1 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_7 + var_45_1
					end

					if var_45_3.prefab_name ~= "" and arg_42_1.actors_[var_45_3.prefab_name] ~= nil then
						local var_45_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_42_1.actors_[var_45_3.prefab_name].transform, "story_v_out_116331", "116331010", "story_v_out_116331.awb")

						arg_42_1:RecordAudio("116331010", var_45_8)
						arg_42_1:RecordAudio("116331010", var_45_8)
					else
						arg_42_1:AudioAction("play", "voice", "story_v_out_116331", "116331010", "story_v_out_116331.awb")
					end

					arg_42_1:RecordHistoryTalkVoice("story_v_out_116331", "116331010", "story_v_out_116331.awb")
				end

				arg_42_1:RecordContent(arg_42_1.text_.text)
			end

			local var_45_9 = math.max(var_45_2, arg_42_1.talkMaxDuration)

			if var_45_1 <= arg_42_1.time_ and arg_42_1.time_ < var_45_1 + var_45_9 then
				arg_42_1.typewritter.percent = (arg_42_1.time_ - var_45_1) / var_45_9

				arg_42_1.typewritter:SetDirty()
			end

			if arg_42_1.time_ >= var_45_1 + var_45_9 and arg_42_1.time_ < var_45_1 + var_45_9 + arg_45_0 then
				arg_42_1.typewritter.percent = 1

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(true)
			end
		end

		arg_42_1.nodeConfigList_ = {}

		arg_42_1:InitPlayNodeList()
	end,
	Play116331011 = function(arg_46_0, arg_46_1)
		arg_46_1.time_ = 0
		arg_46_1.frameCnt_ = 0
		arg_46_1.state_ = "playing"
		arg_46_1.curTalkId_ = 116331011
		arg_46_1.duration_ = 8.37

		local var_46_0 = {
			zh = 6.566,
			ja = 8.366
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
				arg_46_0:Play116331012(arg_46_1)
			end
		end

		function arg_46_1.onSingleLineUpdate_(arg_49_0)
			local var_49_0 = 0.775

			if 0 < arg_46_1.time_ and arg_46_1.time_ <= 0 + arg_49_0 then
				arg_46_1.talkMaxDuration = 0
				arg_46_1.dialogCg_.alpha = 1

				arg_46_1.dialog_:SetActive(true)
				SetActive(arg_46_1.leftNameGo_, true)

				arg_46_1.leftNameTxt_.text = arg_46_1:FormatText(StoryNameCfg[337].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_46_1.leftNameTxt_.transform)

				arg_46_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_46_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_46_1:RecordName(arg_46_1.leftNameTxt_.text)
				SetActive(arg_46_1.iconTrs_.gameObject, true)
				arg_46_1.iconController_:SetSelectedState("hero")

				arg_46_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10046")

				arg_46_1.callingController_:SetSelectedState("normal")

				arg_46_1.keyicon_.color = Color.New(1, 1, 1)
				arg_46_1.icon_.color = Color.New(1, 1, 1)

				local var_49_1 = arg_46_1:GetWordFromCfg(116331011)
				local var_49_2 = arg_46_1:FormatText(var_49_1.content)

				arg_46_1.text_.text = var_49_2

				LuaForUtil.ClearLinePrefixSymbol(arg_46_1.text_)

				local var_49_4 = 31 <= 0 and var_49_0 or var_49_0 * (utf8.len(var_49_2) / 31)

				if (31 <= 0 and var_49_0 or var_49_0 * (utf8.len(var_49_2) / 31)) > 0 and var_49_0 < var_49_4 then
					arg_46_1.talkMaxDuration = var_49_4

					if var_49_4 + 0 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_4 + 0
					end
				end

				arg_46_1.text_.text = var_49_2
				arg_46_1.typewritter.percent = 0

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116331", "116331011", "story_v_out_116331.awb") ~= 0 then
					local var_49_5 = manager.audio:GetVoiceLength("story_v_out_116331", "116331011", "story_v_out_116331.awb") / 1000

					if var_49_5 + 0 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_5 + 0
					end

					if var_49_1.prefab_name ~= "" and arg_46_1.actors_[var_49_1.prefab_name] ~= nil then
						local var_49_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_46_1.actors_[var_49_1.prefab_name].transform, "story_v_out_116331", "116331011", "story_v_out_116331.awb")

						arg_46_1:RecordAudio("116331011", var_49_6)
						arg_46_1:RecordAudio("116331011", var_49_6)
					else
						arg_46_1:AudioAction("play", "voice", "story_v_out_116331", "116331011", "story_v_out_116331.awb")
					end

					arg_46_1:RecordHistoryTalkVoice("story_v_out_116331", "116331011", "story_v_out_116331.awb")
				end

				arg_46_1:RecordContent(arg_46_1.text_.text)
			end

			local var_49_7 = math.max(var_49_0, arg_46_1.talkMaxDuration)

			if 0 <= arg_46_1.time_ and arg_46_1.time_ < 0 + var_49_7 then
				arg_46_1.typewritter.percent = (arg_46_1.time_ - 0) / var_49_7

				arg_46_1.typewritter:SetDirty()
			end

			if arg_46_1.time_ >= 0 + var_49_7 and arg_46_1.time_ < 0 + var_49_7 + arg_49_0 then
				arg_46_1.typewritter.percent = 1

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(true)
			end
		end

		arg_46_1.nodeConfigList_ = {}

		arg_46_1:InitPlayNodeList()
	end,
	Play116331012 = function(arg_50_0, arg_50_1)
		arg_50_1.time_ = 0
		arg_50_1.frameCnt_ = 0
		arg_50_1.state_ = "playing"
		arg_50_1.curTalkId_ = 116331012
		arg_50_1.duration_ = 9.7

		local var_50_0 = {
			zh = 9.7,
			ja = 8.266
		}
		local var_50_1 = manager.audio:GetLocalizationFlag()

		if var_50_0[var_50_1] ~= nil then
			arg_50_1.duration_ = var_50_0[var_50_1]
		end

		SetActive(arg_50_1.tipsGo_, false)

		function arg_50_1.onSingleLineFinish_()
			arg_50_1.onSingleLineUpdate_ = nil
			arg_50_1.onSingleLineFinish_ = nil
			arg_50_1.state_ = "waiting"
		end

		function arg_50_1.playNext_(arg_52_0)
			if arg_52_0 == 1 then
				arg_50_0:Play116331013(arg_50_1)
			end
		end

		function arg_50_1.onSingleLineUpdate_(arg_53_0)
			if arg_50_1.bgs_.I07 == nil then
				local var_53_0 = Object.Instantiate(arg_50_1.paintGo_)

				var_53_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "I07")
				var_53_0.name = "I07"
				var_53_0.transform.parent = arg_50_1.stage_.transform
				var_53_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_50_1.bgs_.I07 = var_53_0
			end

			if 2 < arg_50_1.time_ and arg_50_1.time_ <= 2 + arg_53_0 then
				local var_53_1 = arg_50_1.bgs_.I07

				arg_50_1.bgs_.I07.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_53_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_53_2 = var_53_1:GetComponent("SpriteRenderer")

				if var_53_2 and var_53_2.sprite then
					local var_53_3 = 2 * (var_53_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_53_1.transform.localScale = Vector3.New(var_53_3 / var_53_2.sprite.bounds.size.y < var_53_3 * manager.ui.mainCameraCom_.aspect / var_53_2.sprite.bounds.size.x and var_53_3 * manager.ui.mainCameraCom_.aspect / var_53_2.sprite.bounds.size.x or var_53_3 / var_53_2.sprite.bounds.size.y, var_53_3 / var_53_2.sprite.bounds.size.y < var_53_3 * manager.ui.mainCameraCom_.aspect / var_53_2.sprite.bounds.size.x and var_53_3 * manager.ui.mainCameraCom_.aspect / var_53_2.sprite.bounds.size.x or var_53_3 / var_53_2.sprite.bounds.size.y, 0)
				end

				for iter_53_0, iter_53_1 in pairs(arg_50_1.bgs_) do
					if iter_53_0 ~= "I07" then
						iter_53_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_53_4 = 0

			if 0 < arg_50_1.time_ and arg_50_1.time_ <= var_53_4 + arg_53_0 then
				arg_50_1.mask_.enabled = true
				arg_50_1.mask_.raycastTarget = true

				arg_50_1:SetGaussion(false)
			end

			local var_53_5 = 2

			if var_53_4 <= arg_50_1.time_ and arg_50_1.time_ < var_53_4 + var_53_5 then
				local var_53_6 = Color.New(0, 0, 0)

				var_53_6.a = Mathf.Lerp(0, 1, (arg_50_1.time_ - var_53_4) / var_53_5)
				arg_50_1.mask_.color = var_53_6
			end

			if arg_50_1.time_ >= var_53_4 + var_53_5 and arg_50_1.time_ < var_53_4 + var_53_5 + arg_53_0 then
				local var_53_7 = Color.New(0, 0, 0)

				var_53_7.a = 1
				arg_50_1.mask_.color = var_53_7
			end

			local var_53_8 = 2

			if 2 < arg_50_1.time_ and arg_50_1.time_ <= var_53_8 + arg_53_0 then
				arg_50_1.mask_.enabled = true
				arg_50_1.mask_.raycastTarget = true

				arg_50_1:SetGaussion(false)
			end

			local var_53_9 = 2

			if var_53_8 <= arg_50_1.time_ and arg_50_1.time_ < var_53_8 + var_53_9 then
				local var_53_10 = Color.New(0, 0, 0)

				var_53_10.a = Mathf.Lerp(1, 0, (arg_50_1.time_ - var_53_8) / var_53_9)
				arg_50_1.mask_.color = var_53_10
			end

			if arg_50_1.time_ >= var_53_8 + var_53_9 and arg_50_1.time_ < var_53_8 + var_53_9 + arg_53_0 then
				local var_53_11 = Color.New(0, 0, 0)

				arg_50_1.mask_.enabled = false
				var_53_11.a = 0
				arg_50_1.mask_.color = var_53_11
			end

			local var_53_12 = arg_50_1.actors_["10032ui_story"].transform

			if 2 < arg_50_1.time_ and arg_50_1.time_ <= 2 + arg_53_0 then
				arg_50_1.var_.moveOldPos10032ui_story = var_53_12.localPosition
			end

			local var_53_13 = 0.001

			if 2 <= arg_50_1.time_ and arg_50_1.time_ < 2 + var_53_13 then
				var_53_12.localPosition = Vector3.Lerp(arg_50_1.var_.moveOldPos10032ui_story, Vector3.New(0, 100, 0), (arg_50_1.time_ - 2) / var_53_13)
				var_53_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_53_12.position).x, (manager.ui.mainCamera.transform.position - var_53_12.position).y, (manager.ui.mainCamera.transform.position - var_53_12.position).z)
				var_53_12.localEulerAngles.z = 0
				var_53_12.localEulerAngles.x = 0
				var_53_12.localEulerAngles = var_53_12.localEulerAngles
			end

			if arg_50_1.time_ >= 2 + var_53_13 and arg_50_1.time_ < 2 + var_53_13 + arg_53_0 then
				var_53_12.localPosition = Vector3.New(0, 100, 0)
				var_53_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_53_12.position).x, (manager.ui.mainCamera.transform.position - var_53_12.position).y, (manager.ui.mainCamera.transform.position - var_53_12.position).z)
				var_53_12.localEulerAngles.z = 0
				var_53_12.localEulerAngles.x = 0
				var_53_12.localEulerAngles = var_53_12.localEulerAngles
			end

			if 2 < arg_50_1.time_ and arg_50_1.time_ <= 2 + arg_53_0 then
				arg_50_1:AudioAction("play", "music", "bgm_story_scheme", "bgm_story_scheme", "bgm_story_scheme.awb")

				local var_53_16 = manager.audio:GetAudioName("bgm_story_scheme", "bgm_story_scheme")

				if "" ~= "" then
					if arg_50_1.bgmTxt_.text ~= var_53_16 and arg_50_1.bgmTxt_.text ~= "" then
						if arg_50_1.bgmTxt2_.text ~= "" then
							arg_50_1.bgmTxt_.text = arg_50_1.bgmTxt2_.text
						end

						arg_50_1.bgmTxt2_.text = var_53_16

						arg_50_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_50_1.bgmTxt_.text = var_53_16
						arg_50_1.bgmTxt2_.text = var_53_16
					end

					if arg_50_1.bgmTimer then
						arg_50_1.bgmTimer:Stop()

						arg_50_1.bgmTimer = nil
					end

					if arg_50_1.settingData.show_music_name == 1 then
						arg_50_1.musicController:SetSelectedState("show")
						arg_50_1.musicAnimator_:Play("open", 0, 0)

						if arg_50_1.settingData.music_time ~= 0 then
							arg_50_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_50_1.settingData.music_time), function()
								if arg_50_1 == nil or isNil(arg_50_1.bgmTxt_) then
									return
								end

								arg_50_1.musicController:SetSelectedState("hide")
								arg_50_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_50_1.frameCnt_ <= 1 then
				arg_50_1.dialog_:SetActive(false)
			end

			local var_53_17 = 4
			local var_53_18 = 0.25

			if 4 < arg_50_1.time_ and arg_50_1.time_ <= var_53_17 + arg_53_0 then
				arg_50_1.talkMaxDuration = 0

				arg_50_1.dialog_:SetActive(true)

				arg_50_1.dialogCg_.alpha = 0

				local var_53_19 = LeanTween.value(arg_50_1.dialog_, 0, 1, 0.3)

				var_53_19:setOnUpdate(LuaHelper.FloatAction(function(arg_55_0)
					arg_50_1.dialogCg_.alpha = arg_55_0
				end))
				var_53_19:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_50_1.dialog_)
					var_53_19:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_50_1.duration_ = arg_50_1.duration_ + 0.3

				SetActive(arg_50_1.leftNameGo_, true)

				arg_50_1.leftNameTxt_.text = arg_50_1:FormatText(StoryNameCfg[332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_50_1.leftNameTxt_.transform)

				arg_50_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_50_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_50_1:RecordName(arg_50_1.leftNameTxt_.text)
				SetActive(arg_50_1.iconTrs_.gameObject, true)
				arg_50_1.iconController_:SetSelectedState("hero")

				arg_50_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10024")

				arg_50_1.callingController_:SetSelectedState("normal")

				arg_50_1.keyicon_.color = Color.New(1, 1, 1)
				arg_50_1.icon_.color = Color.New(1, 1, 1)

				local var_53_20 = arg_50_1:GetWordFromCfg(116331012)
				local var_53_21 = arg_50_1:FormatText(var_53_20.content)

				arg_50_1.text_.text = var_53_21

				LuaForUtil.ClearLinePrefixSymbol(arg_50_1.text_)

				local var_53_23 = 10 <= 0 and var_53_18 or var_53_18 * (utf8.len(var_53_21) / 10)

				if (10 <= 0 and var_53_18 or var_53_18 * (utf8.len(var_53_21) / 10)) > 0 and var_53_18 < var_53_23 then
					arg_50_1.talkMaxDuration = var_53_23
					var_53_17 = var_53_17 + 0.3

					if var_53_23 + var_53_17 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_23 + var_53_17
					end
				end

				arg_50_1.text_.text = var_53_21
				arg_50_1.typewritter.percent = 0

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116331", "116331012", "story_v_out_116331.awb") ~= 0 then
					local var_53_24 = manager.audio:GetVoiceLength("story_v_out_116331", "116331012", "story_v_out_116331.awb") / 1000

					if var_53_24 + var_53_17 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_24 + var_53_17
					end

					if var_53_20.prefab_name ~= "" and arg_50_1.actors_[var_53_20.prefab_name] ~= nil then
						local var_53_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_50_1.actors_[var_53_20.prefab_name].transform, "story_v_out_116331", "116331012", "story_v_out_116331.awb")

						arg_50_1:RecordAudio("116331012", var_53_25)
						arg_50_1:RecordAudio("116331012", var_53_25)
					else
						arg_50_1:AudioAction("play", "voice", "story_v_out_116331", "116331012", "story_v_out_116331.awb")
					end

					arg_50_1:RecordHistoryTalkVoice("story_v_out_116331", "116331012", "story_v_out_116331.awb")
				end

				arg_50_1:RecordContent(arg_50_1.text_.text)
			end

			local var_53_26 = var_53_17 + 0.3
			local var_53_27 = math.max(var_53_18, arg_50_1.talkMaxDuration)

			if var_53_17 + 0.3 <= arg_50_1.time_ and arg_50_1.time_ < var_53_26 + var_53_27 then
				arg_50_1.typewritter.percent = (arg_50_1.time_ - var_53_26) / var_53_27

				arg_50_1.typewritter:SetDirty()
			end

			if arg_50_1.time_ >= var_53_26 + var_53_27 and arg_50_1.time_ < var_53_26 + var_53_27 + arg_53_0 then
				arg_50_1.typewritter.percent = 1

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(true)
			end
		end

		arg_50_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10032ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_50_1:InitPlayNodeList()
	end,
	Play116331013 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 116331013
		arg_57_1.duration_ = 5.13

		local var_57_0 = {
			zh = 4.6,
			ja = 5.133
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
				arg_57_0:Play116331014(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = 0.575

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				arg_57_1.leftNameTxt_.text = arg_57_1:FormatText(StoryNameCfg[338].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, true)
				arg_57_1.iconController_:SetSelectedState("hero")

				arg_57_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadowm")

				arg_57_1.callingController_:SetSelectedState("normal")

				arg_57_1.keyicon_.color = Color.New(1, 1, 1)
				arg_57_1.icon_.color = Color.New(1, 1, 1)

				local var_60_1 = arg_57_1:GetWordFromCfg(116331013)
				local var_60_2 = arg_57_1:FormatText(var_60_1.content)

				arg_57_1.text_.text = var_60_2

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_4 = 23 <= 0 and var_60_0 or var_60_0 * (utf8.len(var_60_2) / 23)

				if (23 <= 0 and var_60_0 or var_60_0 * (utf8.len(var_60_2) / 23)) > 0 and var_60_0 < var_60_4 then
					arg_57_1.talkMaxDuration = var_60_4

					if var_60_4 + 0 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_4 + 0
					end
				end

				arg_57_1.text_.text = var_60_2
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116331", "116331013", "story_v_out_116331.awb") ~= 0 then
					local var_60_5 = manager.audio:GetVoiceLength("story_v_out_116331", "116331013", "story_v_out_116331.awb") / 1000

					if var_60_5 + 0 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_5 + 0
					end

					if var_60_1.prefab_name ~= "" and arg_57_1.actors_[var_60_1.prefab_name] ~= nil then
						local var_60_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_1.prefab_name].transform, "story_v_out_116331", "116331013", "story_v_out_116331.awb")

						arg_57_1:RecordAudio("116331013", var_60_6)
						arg_57_1:RecordAudio("116331013", var_60_6)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_116331", "116331013", "story_v_out_116331.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_116331", "116331013", "story_v_out_116331.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_7 = math.max(var_60_0, arg_57_1.talkMaxDuration)

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_7 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - 0) / var_60_7

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= 0 + var_60_7 and arg_57_1.time_ < 0 + var_60_7 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play116331014 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 116331014
		arg_61_1.duration_ = 6.77

		local var_61_0 = {
			zh = 6.766,
			ja = 6.4
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
				arg_61_0:Play116331015(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = 0.75

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				arg_61_1.leftNameTxt_.text = arg_61_1:FormatText(StoryNameCfg[338].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, true)
				arg_61_1.iconController_:SetSelectedState("hero")

				arg_61_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadowm")

				arg_61_1.callingController_:SetSelectedState("normal")

				arg_61_1.keyicon_.color = Color.New(1, 1, 1)
				arg_61_1.icon_.color = Color.New(1, 1, 1)

				local var_64_1 = arg_61_1:GetWordFromCfg(116331014)
				local var_64_2 = arg_61_1:FormatText(var_64_1.content)

				arg_61_1.text_.text = var_64_2

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_4 = 30 <= 0 and var_64_0 or var_64_0 * (utf8.len(var_64_2) / 30)

				if (30 <= 0 and var_64_0 or var_64_0 * (utf8.len(var_64_2) / 30)) > 0 and var_64_0 < var_64_4 then
					arg_61_1.talkMaxDuration = var_64_4

					if var_64_4 + 0 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_4 + 0
					end
				end

				arg_61_1.text_.text = var_64_2
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116331", "116331014", "story_v_out_116331.awb") ~= 0 then
					local var_64_5 = manager.audio:GetVoiceLength("story_v_out_116331", "116331014", "story_v_out_116331.awb") / 1000

					if var_64_5 + 0 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_5 + 0
					end

					if var_64_1.prefab_name ~= "" and arg_61_1.actors_[var_64_1.prefab_name] ~= nil then
						local var_64_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_1.prefab_name].transform, "story_v_out_116331", "116331014", "story_v_out_116331.awb")

						arg_61_1:RecordAudio("116331014", var_64_6)
						arg_61_1:RecordAudio("116331014", var_64_6)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_116331", "116331014", "story_v_out_116331.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_116331", "116331014", "story_v_out_116331.awb")
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
	Play116331015 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 116331015
		arg_65_1.duration_ = 3.4

		local var_65_0 = {
			zh = 2.566,
			ja = 3.4
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
				arg_65_0:Play116331016(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = 0.325

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				arg_65_1.leftNameTxt_.text = arg_65_1:FormatText(StoryNameCfg[332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, true)
				arg_65_1.iconController_:SetSelectedState("hero")

				arg_65_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10024")

				arg_65_1.callingController_:SetSelectedState("normal")

				arg_65_1.keyicon_.color = Color.New(1, 1, 1)
				arg_65_1.icon_.color = Color.New(1, 1, 1)

				local var_68_1 = arg_65_1:GetWordFromCfg(116331015)
				local var_68_2 = arg_65_1:FormatText(var_68_1.content)

				arg_65_1.text_.text = var_68_2

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_4 = 13 <= 0 and var_68_0 or var_68_0 * (utf8.len(var_68_2) / 13)

				if (13 <= 0 and var_68_0 or var_68_0 * (utf8.len(var_68_2) / 13)) > 0 and var_68_0 < var_68_4 then
					arg_65_1.talkMaxDuration = var_68_4

					if var_68_4 + 0 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_4 + 0
					end
				end

				arg_65_1.text_.text = var_68_2
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116331", "116331015", "story_v_out_116331.awb") ~= 0 then
					local var_68_5 = manager.audio:GetVoiceLength("story_v_out_116331", "116331015", "story_v_out_116331.awb") / 1000

					if var_68_5 + 0 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_5 + 0
					end

					if var_68_1.prefab_name ~= "" and arg_65_1.actors_[var_68_1.prefab_name] ~= nil then
						local var_68_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_1.prefab_name].transform, "story_v_out_116331", "116331015", "story_v_out_116331.awb")

						arg_65_1:RecordAudio("116331015", var_68_6)
						arg_65_1:RecordAudio("116331015", var_68_6)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_116331", "116331015", "story_v_out_116331.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_116331", "116331015", "story_v_out_116331.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_7 = math.max(var_68_0, arg_65_1.talkMaxDuration)

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_7 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - 0) / var_68_7

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= 0 + var_68_7 and arg_65_1.time_ < 0 + var_68_7 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play116331016 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 116331016
		arg_69_1.duration_ = 8.8

		local var_69_0 = {
			zh = 8.733,
			ja = 8.8
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
				arg_69_0:Play116331017(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = 1.2

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				arg_69_1.leftNameTxt_.text = arg_69_1:FormatText(StoryNameCfg[339].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, true)
				arg_69_1.iconController_:SetSelectedState("hero")

				arg_69_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadoww")

				arg_69_1.callingController_:SetSelectedState("normal")

				arg_69_1.keyicon_.color = Color.New(1, 1, 1)
				arg_69_1.icon_.color = Color.New(1, 1, 1)

				local var_72_1 = arg_69_1:GetWordFromCfg(116331016)
				local var_72_2 = arg_69_1:FormatText(var_72_1.content)

				arg_69_1.text_.text = var_72_2

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_4 = 48 <= 0 and var_72_0 or var_72_0 * (utf8.len(var_72_2) / 48)

				if (48 <= 0 and var_72_0 or var_72_0 * (utf8.len(var_72_2) / 48)) > 0 and var_72_0 < var_72_4 then
					arg_69_1.talkMaxDuration = var_72_4

					if var_72_4 + 0 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_4 + 0
					end
				end

				arg_69_1.text_.text = var_72_2
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116331", "116331016", "story_v_out_116331.awb") ~= 0 then
					local var_72_5 = manager.audio:GetVoiceLength("story_v_out_116331", "116331016", "story_v_out_116331.awb") / 1000

					if var_72_5 + 0 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_5 + 0
					end

					if var_72_1.prefab_name ~= "" and arg_69_1.actors_[var_72_1.prefab_name] ~= nil then
						local var_72_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_1.prefab_name].transform, "story_v_out_116331", "116331016", "story_v_out_116331.awb")

						arg_69_1:RecordAudio("116331016", var_72_6)
						arg_69_1:RecordAudio("116331016", var_72_6)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_116331", "116331016", "story_v_out_116331.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_116331", "116331016", "story_v_out_116331.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_7 = math.max(var_72_0, arg_69_1.talkMaxDuration)

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_7 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - 0) / var_72_7

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= 0 + var_72_7 and arg_69_1.time_ < 0 + var_72_7 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play116331017 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 116331017
		arg_73_1.duration_ = 7.03

		local var_73_0 = {
			zh = 7.033,
			ja = 6.9
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
				arg_73_0:Play116331018(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = 0.8

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				arg_73_1.leftNameTxt_.text = arg_73_1:FormatText(StoryNameCfg[339].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, true)
				arg_73_1.iconController_:SetSelectedState("hero")

				arg_73_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadoww")

				arg_73_1.callingController_:SetSelectedState("normal")

				arg_73_1.keyicon_.color = Color.New(1, 1, 1)
				arg_73_1.icon_.color = Color.New(1, 1, 1)

				local var_76_1 = arg_73_1:GetWordFromCfg(116331017)
				local var_76_2 = arg_73_1:FormatText(var_76_1.content)

				arg_73_1.text_.text = var_76_2

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_4 = 32 <= 0 and var_76_0 or var_76_0 * (utf8.len(var_76_2) / 32)

				if (32 <= 0 and var_76_0 or var_76_0 * (utf8.len(var_76_2) / 32)) > 0 and var_76_0 < var_76_4 then
					arg_73_1.talkMaxDuration = var_76_4

					if var_76_4 + 0 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_4 + 0
					end
				end

				arg_73_1.text_.text = var_76_2
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116331", "116331017", "story_v_out_116331.awb") ~= 0 then
					local var_76_5 = manager.audio:GetVoiceLength("story_v_out_116331", "116331017", "story_v_out_116331.awb") / 1000

					if var_76_5 + 0 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_5 + 0
					end

					if var_76_1.prefab_name ~= "" and arg_73_1.actors_[var_76_1.prefab_name] ~= nil then
						local var_76_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_1.prefab_name].transform, "story_v_out_116331", "116331017", "story_v_out_116331.awb")

						arg_73_1:RecordAudio("116331017", var_76_6)
						arg_73_1:RecordAudio("116331017", var_76_6)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_116331", "116331017", "story_v_out_116331.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_116331", "116331017", "story_v_out_116331.awb")
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
	Play116331018 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 116331018
		arg_77_1.duration_ = 5.03

		local var_77_0 = {
			zh = 3.9,
			ja = 5.033
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
				arg_77_0:Play116331019(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = 0.25

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				arg_77_1.leftNameTxt_.text = arg_77_1:FormatText(StoryNameCfg[338].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, true)
				arg_77_1.iconController_:SetSelectedState("hero")

				arg_77_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadowm")

				arg_77_1.callingController_:SetSelectedState("normal")

				arg_77_1.keyicon_.color = Color.New(1, 1, 1)
				arg_77_1.icon_.color = Color.New(1, 1, 1)

				local var_80_1 = arg_77_1:GetWordFromCfg(116331018)
				local var_80_2 = arg_77_1:FormatText(var_80_1.content)

				arg_77_1.text_.text = var_80_2

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_4 = 10 <= 0 and var_80_0 or var_80_0 * (utf8.len(var_80_2) / 10)

				if (10 <= 0 and var_80_0 or var_80_0 * (utf8.len(var_80_2) / 10)) > 0 and var_80_0 < var_80_4 then
					arg_77_1.talkMaxDuration = var_80_4

					if var_80_4 + 0 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_4 + 0
					end
				end

				arg_77_1.text_.text = var_80_2
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116331", "116331018", "story_v_out_116331.awb") ~= 0 then
					local var_80_5 = manager.audio:GetVoiceLength("story_v_out_116331", "116331018", "story_v_out_116331.awb") / 1000

					if var_80_5 + 0 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_5 + 0
					end

					if var_80_1.prefab_name ~= "" and arg_77_1.actors_[var_80_1.prefab_name] ~= nil then
						local var_80_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_1.prefab_name].transform, "story_v_out_116331", "116331018", "story_v_out_116331.awb")

						arg_77_1:RecordAudio("116331018", var_80_6)
						arg_77_1:RecordAudio("116331018", var_80_6)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_116331", "116331018", "story_v_out_116331.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_116331", "116331018", "story_v_out_116331.awb")
				end

				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_7 = math.max(var_80_0, arg_77_1.talkMaxDuration)

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_7 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - 0) / var_80_7

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= 0 + var_80_7 and arg_77_1.time_ < 0 + var_80_7 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {}

		arg_77_1:InitPlayNodeList()
	end,
	Play116331019 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 116331019
		arg_81_1.duration_ = 6.8

		local var_81_0 = {
			zh = 6.8,
			ja = 6.233
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
				arg_81_0:Play116331020(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = 0.8

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				arg_81_1.leftNameTxt_.text = arg_81_1:FormatText(StoryNameCfg[338].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, true)
				arg_81_1.iconController_:SetSelectedState("hero")

				arg_81_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadowm")

				arg_81_1.callingController_:SetSelectedState("normal")

				arg_81_1.keyicon_.color = Color.New(1, 1, 1)
				arg_81_1.icon_.color = Color.New(1, 1, 1)

				local var_84_1 = arg_81_1:GetWordFromCfg(116331019)
				local var_84_2 = arg_81_1:FormatText(var_84_1.content)

				arg_81_1.text_.text = var_84_2

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_4 = 32 <= 0 and var_84_0 or var_84_0 * (utf8.len(var_84_2) / 32)

				if (32 <= 0 and var_84_0 or var_84_0 * (utf8.len(var_84_2) / 32)) > 0 and var_84_0 < var_84_4 then
					arg_81_1.talkMaxDuration = var_84_4

					if var_84_4 + 0 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_4 + 0
					end
				end

				arg_81_1.text_.text = var_84_2
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116331", "116331019", "story_v_out_116331.awb") ~= 0 then
					local var_84_5 = manager.audio:GetVoiceLength("story_v_out_116331", "116331019", "story_v_out_116331.awb") / 1000

					if var_84_5 + 0 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_5 + 0
					end

					if var_84_1.prefab_name ~= "" and arg_81_1.actors_[var_84_1.prefab_name] ~= nil then
						local var_84_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_1.prefab_name].transform, "story_v_out_116331", "116331019", "story_v_out_116331.awb")

						arg_81_1:RecordAudio("116331019", var_84_6)
						arg_81_1:RecordAudio("116331019", var_84_6)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_116331", "116331019", "story_v_out_116331.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_116331", "116331019", "story_v_out_116331.awb")
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
	Play116331020 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 116331020
		arg_85_1.duration_ = 5

		SetActive(arg_85_1.tipsGo_, false)

		function arg_85_1.onSingleLineFinish_()
			arg_85_1.onSingleLineUpdate_ = nil
			arg_85_1.onSingleLineFinish_ = nil
			arg_85_1.state_ = "waiting"
		end

		function arg_85_1.playNext_(arg_87_0)
			if arg_87_0 == 1 then
				arg_85_0:Play116331021(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1:AudioAction("play", "effect", "se_story_16", "se_story_16_thunder", "")
			end

			local var_88_1 = 0
			local var_88_2 = 0.175

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_1 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, false)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_3 = arg_85_1:FormatText(arg_85_1:GetWordFromCfg(116331020).content)

				arg_85_1.text_.text = var_88_3

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_5 = 7 <= 0 and var_88_2 or var_88_2 * (utf8.len(var_88_3) / 7)

				if (7 <= 0 and var_88_2 or var_88_2 * (utf8.len(var_88_3) / 7)) > 0 and var_88_2 < var_88_5 then
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
	Play116331021 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 116331021
		arg_89_1.duration_ = 9.5

		local var_89_0 = {
			zh = 9.5,
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
				arg_89_0:Play116331022(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			if 2 < arg_89_1.time_ and arg_89_1.time_ <= 2 + arg_92_0 then
				local var_92_0 = arg_89_1.bgs_.I07

				arg_89_1.bgs_.I07.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_92_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_92_1 = var_92_0:GetComponent("SpriteRenderer")

				if var_92_1 and var_92_1.sprite then
					local var_92_2 = 2 * (var_92_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_92_0.transform.localScale = Vector3.New(var_92_2 / var_92_1.sprite.bounds.size.y < var_92_2 * manager.ui.mainCameraCom_.aspect / var_92_1.sprite.bounds.size.x and var_92_2 * manager.ui.mainCameraCom_.aspect / var_92_1.sprite.bounds.size.x or var_92_2 / var_92_1.sprite.bounds.size.y, var_92_2 / var_92_1.sprite.bounds.size.y < var_92_2 * manager.ui.mainCameraCom_.aspect / var_92_1.sprite.bounds.size.x and var_92_2 * manager.ui.mainCameraCom_.aspect / var_92_1.sprite.bounds.size.x or var_92_2 / var_92_1.sprite.bounds.size.y, 0)
				end

				for iter_92_0, iter_92_1 in pairs(arg_89_1.bgs_) do
					if iter_92_0 ~= "I07" then
						iter_92_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_92_3 = 0

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_3 + arg_92_0 then
				arg_89_1.mask_.enabled = true
				arg_89_1.mask_.raycastTarget = true

				arg_89_1:SetGaussion(false)
			end

			local var_92_4 = 2

			if var_92_3 <= arg_89_1.time_ and arg_89_1.time_ < var_92_3 + var_92_4 then
				local var_92_5 = Color.New(0, 0, 0)

				var_92_5.a = Mathf.Lerp(0, 1, (arg_89_1.time_ - var_92_3) / var_92_4)
				arg_89_1.mask_.color = var_92_5
			end

			if arg_89_1.time_ >= var_92_3 + var_92_4 and arg_89_1.time_ < var_92_3 + var_92_4 + arg_92_0 then
				local var_92_6 = Color.New(0, 0, 0)

				var_92_6.a = 1
				arg_89_1.mask_.color = var_92_6
			end

			local var_92_7 = 2

			if 2 < arg_89_1.time_ and arg_89_1.time_ <= var_92_7 + arg_92_0 then
				arg_89_1.mask_.enabled = true
				arg_89_1.mask_.raycastTarget = true

				arg_89_1:SetGaussion(false)
			end

			local var_92_8 = 2

			if var_92_7 <= arg_89_1.time_ and arg_89_1.time_ < var_92_7 + var_92_8 then
				local var_92_9 = Color.New(0, 0, 0)

				var_92_9.a = Mathf.Lerp(1, 0, (arg_89_1.time_ - var_92_7) / var_92_8)
				arg_89_1.mask_.color = var_92_9
			end

			if arg_89_1.time_ >= var_92_7 + var_92_8 and arg_89_1.time_ < var_92_7 + var_92_8 + arg_92_0 then
				local var_92_10 = Color.New(0, 0, 0)

				arg_89_1.mask_.enabled = false
				var_92_10.a = 0
				arg_89_1.mask_.color = var_92_10
			end

			local var_92_11 = 2

			arg_89_1.isInRecall_ = false

			if var_92_11 < arg_89_1.time_ and arg_89_1.time_ <= var_92_11 + arg_92_0 then
				arg_89_1.screenFilterGo_:SetActive(true)

				arg_89_1.screenFilterEffect_.profile = Asset.Load("Effect/Scene/fx_vintageStyle_Profile")

				for iter_92_2, iter_92_3 in pairs(arg_89_1.actors_) do
					for iter_92_4, iter_92_5 in ipairs((iter_92_3:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_92_5.color = iter_92_5.color.r > 0.51 and Color.New(1, 1, 1) or Color.New(0.5, 0.5, 0.5)
					end
				end
			end

			local var_92_12 = 0.0166666666666667

			if var_92_11 <= arg_89_1.time_ and arg_89_1.time_ < var_92_11 + var_92_12 then
				arg_89_1.screenFilterEffect_.weight = Mathf.Lerp(0, 1, (arg_89_1.time_ - var_92_11) / var_92_12)
			end

			if arg_89_1.time_ >= var_92_11 + var_92_12 and arg_89_1.time_ < var_92_11 + var_92_12 + arg_92_0 then
				arg_89_1.screenFilterEffect_.weight = 1
			end

			local var_92_13 = "10014ui_story"

			if arg_89_1.actors_["10014ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10014ui_story"))) then
				local var_92_14 = Object.Instantiate(Asset.Load("Char/" .. "10014ui_story"), arg_89_1.stage_.transform)

				var_92_14.name = var_92_13
				var_92_14.transform.localPosition = Vector3.New(0, 100, 0)
				arg_89_1.actors_[var_92_13] = var_92_14

				local var_92_15 = var_92_14:GetComponentInChildren(typeof(CharacterEffect))

				var_92_15.enabled = true

				local var_92_16 = GameObjectTools.GetOrAddComponent(var_92_14, typeof(DynamicBoneHelper))

				if var_92_16 then
					var_92_16:EnableDynamicBone(false)
				end

				arg_89_1:ShowWeapon(var_92_15.transform, false)

				arg_89_1.var_[var_92_13 .. "Animator"] = var_92_15.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_89_1.var_[var_92_13 .. "Animator"].applyRootMotion = true
				arg_89_1.var_[var_92_13 .. "LipSync"] = var_92_15.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_92_17 = arg_89_1.actors_["10014ui_story"].transform

			if 4 < arg_89_1.time_ and arg_89_1.time_ <= 4 + arg_92_0 then
				arg_89_1.var_.moveOldPos10014ui_story = var_92_17.localPosition
			end

			local var_92_18 = 0.001

			if 4 <= arg_89_1.time_ and arg_89_1.time_ < 4 + var_92_18 then
				var_92_17.localPosition = Vector3.Lerp(arg_89_1.var_.moveOldPos10014ui_story, Vector3.New(0, -1.06, -6.2), (arg_89_1.time_ - 4) / var_92_18)
				var_92_17.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_92_17.position).x, (manager.ui.mainCamera.transform.position - var_92_17.position).y, (manager.ui.mainCamera.transform.position - var_92_17.position).z)
				var_92_17.localEulerAngles.z = 0
				var_92_17.localEulerAngles.x = 0
				var_92_17.localEulerAngles = var_92_17.localEulerAngles
			end

			if arg_89_1.time_ >= 4 + var_92_18 and arg_89_1.time_ < 4 + var_92_18 + arg_92_0 then
				var_92_17.localPosition = Vector3.New(0, -1.06, -6.2)
				var_92_17.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_92_17.position).x, (manager.ui.mainCamera.transform.position - var_92_17.position).y, (manager.ui.mainCamera.transform.position - var_92_17.position).z)
				var_92_17.localEulerAngles.z = 0
				var_92_17.localEulerAngles.x = 0
				var_92_17.localEulerAngles = var_92_17.localEulerAngles
			end

			local var_92_19 = arg_89_1.actors_["10014ui_story"]

			if 4 < arg_89_1.time_ and arg_89_1.time_ <= 4 + arg_92_0 and not isNil(var_92_19) and arg_89_1.var_.characterEffect10014ui_story == nil then
				arg_89_1.var_.characterEffect10014ui_story = var_92_19:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_20 = 0.2

			if 4 <= arg_89_1.time_ and arg_89_1.time_ < 4 + var_92_20 and not isNil(var_92_19) then
				if arg_89_1.var_.characterEffect10014ui_story and not isNil(var_92_19) then
					arg_89_1.var_.characterEffect10014ui_story.fillFlat = false
				end
			end

			if arg_89_1.time_ >= 4 + var_92_20 and arg_89_1.time_ < 4 + var_92_20 + arg_92_0 and not isNil(var_92_19) and arg_89_1.var_.characterEffect10014ui_story then
				arg_89_1.var_.characterEffect10014ui_story.fillFlat = false
			end

			if 4 < arg_89_1.time_ and arg_89_1.time_ <= 4 + arg_92_0 then
				arg_89_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/story10014/story10014action/10014action2_1")
			end

			if 4 < arg_89_1.time_ and arg_89_1.time_ <= 4 + arg_92_0 then
				arg_89_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			if arg_89_1.frameCnt_ <= 1 then
				arg_89_1.dialog_:SetActive(false)
			end

			local var_92_22 = 4
			local var_92_23 = 0.575

			if 4 < arg_89_1.time_ and arg_89_1.time_ <= var_92_22 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0

				arg_89_1.dialog_:SetActive(true)

				arg_89_1.dialogCg_.alpha = 0

				local var_92_24 = LeanTween.value(arg_89_1.dialog_, 0, 1, 0.3)

				var_92_24:setOnUpdate(LuaHelper.FloatAction(function(arg_93_0)
					arg_89_1.dialogCg_.alpha = arg_93_0
				end))
				var_92_24:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_89_1.dialog_)
					var_92_24:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_89_1.duration_ = arg_89_1.duration_ + 0.3

				SetActive(arg_89_1.leftNameGo_, true)

				arg_89_1.leftNameTxt_.text = arg_89_1:FormatText(StoryNameCfg[264].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_25 = arg_89_1:GetWordFromCfg(116331021)
				local var_92_26 = arg_89_1:FormatText(var_92_25.content)

				arg_89_1.text_.text = var_92_26

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_28 = 23 <= 0 and var_92_23 or var_92_23 * (utf8.len(var_92_26) / 23)

				if (23 <= 0 and var_92_23 or var_92_23 * (utf8.len(var_92_26) / 23)) > 0 and var_92_23 < var_92_28 then
					arg_89_1.talkMaxDuration = var_92_28
					var_92_22 = var_92_22 + 0.3

					if var_92_28 + var_92_22 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_28 + var_92_22
					end
				end

				arg_89_1.text_.text = var_92_26
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116331", "116331021", "story_v_out_116331.awb") ~= 0 then
					local var_92_29 = manager.audio:GetVoiceLength("story_v_out_116331", "116331021", "story_v_out_116331.awb") / 1000

					if var_92_29 + var_92_22 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_29 + var_92_22
					end

					if var_92_25.prefab_name ~= "" and arg_89_1.actors_[var_92_25.prefab_name] ~= nil then
						local var_92_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_25.prefab_name].transform, "story_v_out_116331", "116331021", "story_v_out_116331.awb")

						arg_89_1:RecordAudio("116331021", var_92_30)
						arg_89_1:RecordAudio("116331021", var_92_30)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_116331", "116331021", "story_v_out_116331.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_116331", "116331021", "story_v_out_116331.awb")
				end

				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_31 = var_92_22 + 0.3
			local var_92_32 = math.max(var_92_23, arg_89_1.talkMaxDuration)

			if var_92_22 + 0.3 <= arg_89_1.time_ and arg_89_1.time_ < var_92_31 + var_92_32 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_31) / var_92_32

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_31 + var_92_32 and arg_89_1.time_ < var_92_31 + var_92_32 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10014ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 4,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_89_1:InitPlayNodeList()
	end,
	Play116331022 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 116331022
		arg_95_1.duration_ = 11.33

		local var_95_0 = {
			zh = 7.733,
			ja = 11.333
		}
		local var_95_1 = manager.audio:GetLocalizationFlag()

		if var_95_0[var_95_1] ~= nil then
			arg_95_1.duration_ = var_95_0[var_95_1]
		end

		SetActive(arg_95_1.tipsGo_, false)

		function arg_95_1.onSingleLineFinish_()
			arg_95_1.onSingleLineUpdate_ = nil
			arg_95_1.onSingleLineFinish_ = nil
			arg_95_1.state_ = "waiting"
		end

		function arg_95_1.playNext_(arg_97_0)
			if arg_97_0 == 1 then
				arg_95_0:Play116331023(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 then
				arg_95_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_98_0 = 0
			local var_98_1 = 0.95

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= var_98_0 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, true)

				arg_95_1.leftNameTxt_.text = arg_95_1:FormatText(StoryNameCfg[264].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_95_1.leftNameTxt_.transform)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1.leftNameTxt_.text)
				SetActive(arg_95_1.iconTrs_.gameObject, false)
				arg_95_1.callingController_:SetSelectedState("normal")

				local var_98_2 = arg_95_1:GetWordFromCfg(116331022)
				local var_98_3 = arg_95_1:FormatText(var_98_2.content)

				arg_95_1.text_.text = var_98_3

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_5 = 38 <= 0 and var_98_1 or var_98_1 * (utf8.len(var_98_3) / 38)

				if (38 <= 0 and var_98_1 or var_98_1 * (utf8.len(var_98_3) / 38)) > 0 and var_98_1 < var_98_5 then
					arg_95_1.talkMaxDuration = var_98_5

					if var_98_5 + var_98_0 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_5 + var_98_0
					end
				end

				arg_95_1.text_.text = var_98_3
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116331", "116331022", "story_v_out_116331.awb") ~= 0 then
					local var_98_6 = manager.audio:GetVoiceLength("story_v_out_116331", "116331022", "story_v_out_116331.awb") / 1000

					if var_98_6 + var_98_0 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_6 + var_98_0
					end

					if var_98_2.prefab_name ~= "" and arg_95_1.actors_[var_98_2.prefab_name] ~= nil then
						local var_98_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_95_1.actors_[var_98_2.prefab_name].transform, "story_v_out_116331", "116331022", "story_v_out_116331.awb")

						arg_95_1:RecordAudio("116331022", var_98_7)
						arg_95_1:RecordAudio("116331022", var_98_7)
					else
						arg_95_1:AudioAction("play", "voice", "story_v_out_116331", "116331022", "story_v_out_116331.awb")
					end

					arg_95_1:RecordHistoryTalkVoice("story_v_out_116331", "116331022", "story_v_out_116331.awb")
				end

				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_8 = math.max(var_98_1, arg_95_1.talkMaxDuration)

			if var_98_0 <= arg_95_1.time_ and arg_95_1.time_ < var_98_0 + var_98_8 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - var_98_0) / var_98_8

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= var_98_0 + var_98_8 and arg_95_1.time_ < var_98_0 + var_98_8 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {}

		arg_95_1:InitPlayNodeList()
	end,
	Play116331023 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 116331023
		arg_99_1.duration_ = 10.77

		local var_99_0 = {
			zh = 10.4,
			ja = 10.766
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
				arg_99_0:Play116331024(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			if 2 < arg_99_1.time_ and arg_99_1.time_ <= 2 + arg_102_0 then
				local var_102_0 = arg_99_1.bgs_.I07a

				arg_99_1.bgs_.I07a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_102_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_102_1 = var_102_0:GetComponent("SpriteRenderer")

				if var_102_1 and var_102_1.sprite then
					local var_102_2 = 2 * (var_102_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_102_0.transform.localScale = Vector3.New(var_102_2 / var_102_1.sprite.bounds.size.y < var_102_2 * manager.ui.mainCameraCom_.aspect / var_102_1.sprite.bounds.size.x and var_102_2 * manager.ui.mainCameraCom_.aspect / var_102_1.sprite.bounds.size.x or var_102_2 / var_102_1.sprite.bounds.size.y, var_102_2 / var_102_1.sprite.bounds.size.y < var_102_2 * manager.ui.mainCameraCom_.aspect / var_102_1.sprite.bounds.size.x and var_102_2 * manager.ui.mainCameraCom_.aspect / var_102_1.sprite.bounds.size.x or var_102_2 / var_102_1.sprite.bounds.size.y, 0)
				end

				for iter_102_0, iter_102_1 in pairs(arg_99_1.bgs_) do
					if iter_102_0 ~= "I07a" then
						iter_102_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_102_3 = 0

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= var_102_3 + arg_102_0 then
				arg_99_1.mask_.enabled = true
				arg_99_1.mask_.raycastTarget = true

				arg_99_1:SetGaussion(false)
			end

			local var_102_4 = 2

			if var_102_3 <= arg_99_1.time_ and arg_99_1.time_ < var_102_3 + var_102_4 then
				local var_102_5 = Color.New(0, 0, 0)

				var_102_5.a = Mathf.Lerp(0, 1, (arg_99_1.time_ - var_102_3) / var_102_4)
				arg_99_1.mask_.color = var_102_5
			end

			if arg_99_1.time_ >= var_102_3 + var_102_4 and arg_99_1.time_ < var_102_3 + var_102_4 + arg_102_0 then
				local var_102_6 = Color.New(0, 0, 0)

				var_102_6.a = 1
				arg_99_1.mask_.color = var_102_6
			end

			local var_102_7 = 2

			if 2 < arg_99_1.time_ and arg_99_1.time_ <= var_102_7 + arg_102_0 then
				arg_99_1.mask_.enabled = true
				arg_99_1.mask_.raycastTarget = true

				arg_99_1:SetGaussion(false)
			end

			local var_102_8 = 2

			if var_102_7 <= arg_99_1.time_ and arg_99_1.time_ < var_102_7 + var_102_8 then
				local var_102_9 = Color.New(0, 0, 0)

				var_102_9.a = Mathf.Lerp(1, 0, (arg_99_1.time_ - var_102_7) / var_102_8)
				arg_99_1.mask_.color = var_102_9
			end

			if arg_99_1.time_ >= var_102_7 + var_102_8 and arg_99_1.time_ < var_102_7 + var_102_8 + arg_102_0 then
				local var_102_10 = Color.New(0, 0, 0)

				arg_99_1.mask_.enabled = false
				var_102_10.a = 0
				arg_99_1.mask_.color = var_102_10
			end

			local var_102_11 = arg_99_1.actors_["10014ui_story"].transform

			if 2 < arg_99_1.time_ and arg_99_1.time_ <= 2 + arg_102_0 then
				arg_99_1.var_.moveOldPos10014ui_story = var_102_11.localPosition
			end

			local var_102_12 = 0.001

			if 2 <= arg_99_1.time_ and arg_99_1.time_ < 2 + var_102_12 then
				var_102_11.localPosition = Vector3.Lerp(arg_99_1.var_.moveOldPos10014ui_story, Vector3.New(0, 100, 0), (arg_99_1.time_ - 2) / var_102_12)
				var_102_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_102_11.position).x, (manager.ui.mainCamera.transform.position - var_102_11.position).y, (manager.ui.mainCamera.transform.position - var_102_11.position).z)
				var_102_11.localEulerAngles.z = 0
				var_102_11.localEulerAngles.x = 0
				var_102_11.localEulerAngles = var_102_11.localEulerAngles
			end

			if arg_99_1.time_ >= 2 + var_102_12 and arg_99_1.time_ < 2 + var_102_12 + arg_102_0 then
				var_102_11.localPosition = Vector3.New(0, 100, 0)
				var_102_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_102_11.position).x, (manager.ui.mainCamera.transform.position - var_102_11.position).y, (manager.ui.mainCamera.transform.position - var_102_11.position).z)
				var_102_11.localEulerAngles.z = 0
				var_102_11.localEulerAngles.x = 0
				var_102_11.localEulerAngles = var_102_11.localEulerAngles
			end

			if arg_99_1.frameCnt_ <= 1 then
				arg_99_1.dialog_:SetActive(false)
			end

			local var_102_13 = 4
			local var_102_14 = 0.85

			if 4 < arg_99_1.time_ and arg_99_1.time_ <= var_102_13 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0

				arg_99_1.dialog_:SetActive(true)

				arg_99_1.dialogCg_.alpha = 0

				local var_102_15 = LeanTween.value(arg_99_1.dialog_, 0, 1, 0.3)

				var_102_15:setOnUpdate(LuaHelper.FloatAction(function(arg_103_0)
					arg_99_1.dialogCg_.alpha = arg_103_0
				end))
				var_102_15:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_99_1.dialog_)
					var_102_15:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_99_1.duration_ = arg_99_1.duration_ + 0.3

				SetActive(arg_99_1.leftNameGo_, true)

				arg_99_1.leftNameTxt_.text = arg_99_1:FormatText(StoryNameCfg[337].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_99_1.leftNameTxt_.transform)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1.leftNameTxt_.text)
				SetActive(arg_99_1.iconTrs_.gameObject, true)
				arg_99_1.iconController_:SetSelectedState("hero")

				arg_99_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10046")

				arg_99_1.callingController_:SetSelectedState("normal")

				arg_99_1.keyicon_.color = Color.New(1, 1, 1)
				arg_99_1.icon_.color = Color.New(1, 1, 1)

				local var_102_16 = arg_99_1:GetWordFromCfg(116331023)
				local var_102_17 = arg_99_1:FormatText(var_102_16.content)

				arg_99_1.text_.text = var_102_17

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_19 = 34 <= 0 and var_102_14 or var_102_14 * (utf8.len(var_102_17) / 34)

				if (34 <= 0 and var_102_14 or var_102_14 * (utf8.len(var_102_17) / 34)) > 0 and var_102_14 < var_102_19 then
					arg_99_1.talkMaxDuration = var_102_19
					var_102_13 = var_102_13 + 0.3

					if var_102_19 + var_102_13 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_19 + var_102_13
					end
				end

				arg_99_1.text_.text = var_102_17
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116331", "116331023", "story_v_out_116331.awb") ~= 0 then
					local var_102_20 = manager.audio:GetVoiceLength("story_v_out_116331", "116331023", "story_v_out_116331.awb") / 1000

					if var_102_20 + var_102_13 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_20 + var_102_13
					end

					if var_102_16.prefab_name ~= "" and arg_99_1.actors_[var_102_16.prefab_name] ~= nil then
						local var_102_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_99_1.actors_[var_102_16.prefab_name].transform, "story_v_out_116331", "116331023", "story_v_out_116331.awb")

						arg_99_1:RecordAudio("116331023", var_102_21)
						arg_99_1:RecordAudio("116331023", var_102_21)
					else
						arg_99_1:AudioAction("play", "voice", "story_v_out_116331", "116331023", "story_v_out_116331.awb")
					end

					arg_99_1:RecordHistoryTalkVoice("story_v_out_116331", "116331023", "story_v_out_116331.awb")
				end

				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_22 = var_102_13 + 0.3
			local var_102_23 = math.max(var_102_14, arg_99_1.talkMaxDuration)

			if var_102_13 + 0.3 <= arg_99_1.time_ and arg_99_1.time_ < var_102_22 + var_102_23 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - var_102_22) / var_102_23

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= var_102_22 + var_102_23 and arg_99_1.time_ < var_102_22 + var_102_23 + arg_102_0 then
				arg_99_1.typewritter.percent = 1

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(true)
			end
		end

		arg_99_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10014ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_99_1:InitPlayNodeList()
	end,
	Play116331024 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 116331024
		arg_105_1.duration_ = 5.97

		local var_105_0 = {
			zh = 3.666,
			ja = 5.966
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
				arg_105_0:Play116331025(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = 0.475

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				arg_105_1.leftNameTxt_.text = arg_105_1:FormatText(StoryNameCfg[337].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, true)
				arg_105_1.iconController_:SetSelectedState("hero")

				arg_105_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10046")

				arg_105_1.callingController_:SetSelectedState("normal")

				arg_105_1.keyicon_.color = Color.New(1, 1, 1)
				arg_105_1.icon_.color = Color.New(1, 1, 1)

				local var_108_1 = arg_105_1:GetWordFromCfg(116331024)
				local var_108_2 = arg_105_1:FormatText(var_108_1.content)

				arg_105_1.text_.text = var_108_2

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_4 = 19 <= 0 and var_108_0 or var_108_0 * (utf8.len(var_108_2) / 19)

				if (19 <= 0 and var_108_0 or var_108_0 * (utf8.len(var_108_2) / 19)) > 0 and var_108_0 < var_108_4 then
					arg_105_1.talkMaxDuration = var_108_4

					if var_108_4 + 0 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_4 + 0
					end
				end

				arg_105_1.text_.text = var_108_2
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116331", "116331024", "story_v_out_116331.awb") ~= 0 then
					local var_108_5 = manager.audio:GetVoiceLength("story_v_out_116331", "116331024", "story_v_out_116331.awb") / 1000

					if var_108_5 + 0 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_5 + 0
					end

					if var_108_1.prefab_name ~= "" and arg_105_1.actors_[var_108_1.prefab_name] ~= nil then
						local var_108_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_1.prefab_name].transform, "story_v_out_116331", "116331024", "story_v_out_116331.awb")

						arg_105_1:RecordAudio("116331024", var_108_6)
						arg_105_1:RecordAudio("116331024", var_108_6)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_116331", "116331024", "story_v_out_116331.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_116331", "116331024", "story_v_out_116331.awb")
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
	Play116331025 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 116331025
		arg_109_1.duration_ = 9

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
		end

		function arg_109_1.playNext_(arg_111_0)
			if arg_111_0 == 1 then
				arg_109_0:Play116331026(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			if 2 < arg_109_1.time_ and arg_109_1.time_ <= 2 + arg_112_0 then
				local var_112_0 = arg_109_1.bgs_.I07a

				arg_109_1.bgs_.I07a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_112_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_112_1 = var_112_0:GetComponent("SpriteRenderer")

				if var_112_1 and var_112_1.sprite then
					local var_112_2 = 2 * (var_112_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_112_0.transform.localScale = Vector3.New(var_112_2 / var_112_1.sprite.bounds.size.y < var_112_2 * manager.ui.mainCameraCom_.aspect / var_112_1.sprite.bounds.size.x and var_112_2 * manager.ui.mainCameraCom_.aspect / var_112_1.sprite.bounds.size.x or var_112_2 / var_112_1.sprite.bounds.size.y, var_112_2 / var_112_1.sprite.bounds.size.y < var_112_2 * manager.ui.mainCameraCom_.aspect / var_112_1.sprite.bounds.size.x and var_112_2 * manager.ui.mainCameraCom_.aspect / var_112_1.sprite.bounds.size.x or var_112_2 / var_112_1.sprite.bounds.size.y, 0)
				end

				for iter_112_0, iter_112_1 in pairs(arg_109_1.bgs_) do
					if iter_112_0 ~= "I07a" then
						iter_112_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_112_3 = 0

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= var_112_3 + arg_112_0 then
				arg_109_1.mask_.enabled = true
				arg_109_1.mask_.raycastTarget = true

				arg_109_1:SetGaussion(false)
			end

			local var_112_4 = 2

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

			local var_112_7 = 2

			if 2 < arg_109_1.time_ and arg_109_1.time_ <= var_112_7 + arg_112_0 then
				arg_109_1.mask_.enabled = true
				arg_109_1.mask_.raycastTarget = true

				arg_109_1:SetGaussion(false)
			end

			local var_112_8 = 2

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

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_112_13 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_109_1.bgmTxt_.text ~= var_112_13 and arg_109_1.bgmTxt_.text ~= "" then
						if arg_109_1.bgmTxt2_.text ~= "" then
							arg_109_1.bgmTxt_.text = arg_109_1.bgmTxt2_.text
						end

						arg_109_1.bgmTxt2_.text = var_112_13

						arg_109_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_109_1.bgmTxt_.text = var_112_13
						arg_109_1.bgmTxt2_.text = var_112_13
					end

					if arg_109_1.bgmTimer then
						arg_109_1.bgmTimer:Stop()

						arg_109_1.bgmTimer = nil
					end

					if arg_109_1.settingData.show_music_name == 1 then
						arg_109_1.musicController:SetSelectedState("show")
						arg_109_1.musicAnimator_:Play("open", 0, 0)

						if arg_109_1.settingData.music_time ~= 0 then
							arg_109_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_109_1.settingData.music_time), function()
								if arg_109_1 == nil or isNil(arg_109_1.bgmTxt_) then
									return
								end

								arg_109_1.musicController:SetSelectedState("hide")
								arg_109_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_112_14 = 2

			arg_109_1.isInRecall_ = false

			if var_112_14 < arg_109_1.time_ and arg_109_1.time_ <= var_112_14 + arg_112_0 then
				arg_109_1.screenFilterGo_:SetActive(false)

				for iter_112_2, iter_112_3 in pairs(arg_109_1.actors_) do
					for iter_112_4, iter_112_5 in ipairs((iter_112_3:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_112_5.color = iter_112_5.color.r > 0.51 and Color.New(1, 1, 1) or Color.New(0.5, 0.5, 0.5)
					end
				end
			end

			local var_112_15 = 0.0166666666666667

			if var_112_14 <= arg_109_1.time_ and arg_109_1.time_ < var_112_14 + var_112_15 then
				arg_109_1.screenFilterEffect_.weight = Mathf.Lerp(1, 0, (arg_109_1.time_ - var_112_14) / var_112_15)
			end

			if arg_109_1.time_ >= var_112_14 + var_112_15 and arg_109_1.time_ < var_112_14 + var_112_15 + arg_112_0 then
				arg_109_1.screenFilterEffect_.weight = 0
			end

			if arg_109_1.frameCnt_ <= 1 then
				arg_109_1.dialog_:SetActive(false)
			end

			local var_112_16 = 4
			local var_112_17 = 0.925

			if 4 < arg_109_1.time_ and arg_109_1.time_ <= var_112_16 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0

				arg_109_1.dialog_:SetActive(true)

				arg_109_1.dialogCg_.alpha = 0

				local var_112_18 = LeanTween.value(arg_109_1.dialog_, 0, 1, 0.3)

				var_112_18:setOnUpdate(LuaHelper.FloatAction(function(arg_114_0)
					arg_109_1.dialogCg_.alpha = arg_114_0
				end))
				var_112_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_109_1.dialog_)
					var_112_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_109_1.duration_ = arg_109_1.duration_ + 0.3

				SetActive(arg_109_1.leftNameGo_, false)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_19 = arg_109_1:FormatText(arg_109_1:GetWordFromCfg(116331025).content)

				arg_109_1.text_.text = var_112_19

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_21 = 37 <= 0 and var_112_17 or var_112_17 * (utf8.len(var_112_19) / 37)

				if (37 <= 0 and var_112_17 or var_112_17 * (utf8.len(var_112_19) / 37)) > 0 and var_112_17 < var_112_21 then
					arg_109_1.talkMaxDuration = var_112_21
					var_112_16 = var_112_16 + 0.3

					if var_112_21 + var_112_16 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_21 + var_112_16
					end
				end

				arg_109_1.text_.text = var_112_19
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)
				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_22 = var_112_16 + 0.3
			local var_112_23 = math.max(var_112_17, arg_109_1.talkMaxDuration)

			if var_112_16 + 0.3 <= arg_109_1.time_ and arg_109_1.time_ < var_112_22 + var_112_23 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_22) / var_112_23

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_22 + var_112_23 and arg_109_1.time_ < var_112_22 + var_112_23 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {}

		arg_109_1:InitPlayNodeList()
	end,
	Play116331026 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 116331026
		arg_116_1.duration_ = 5

		SetActive(arg_116_1.tipsGo_, false)

		function arg_116_1.onSingleLineFinish_()
			arg_116_1.onSingleLineUpdate_ = nil
			arg_116_1.onSingleLineFinish_ = nil
			arg_116_1.state_ = "waiting"
		end

		function arg_116_1.playNext_(arg_118_0)
			if arg_118_0 == 1 then
				arg_116_0:Play116331027(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			local var_119_0 = 0.875

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0
				arg_116_1.dialogCg_.alpha = 1

				arg_116_1.dialog_:SetActive(true)
				SetActive(arg_116_1.leftNameGo_, false)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_116_1.iconTrs_.gameObject, false)
				arg_116_1.callingController_:SetSelectedState("normal")

				local var_119_1 = arg_116_1:FormatText(arg_116_1:GetWordFromCfg(116331026).content)

				arg_116_1.text_.text = var_119_1

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_3 = 35 <= 0 and var_119_0 or var_119_0 * (utf8.len(var_119_1) / 35)

				if (35 <= 0 and var_119_0 or var_119_0 * (utf8.len(var_119_1) / 35)) > 0 and var_119_0 < var_119_3 then
					arg_116_1.talkMaxDuration = var_119_3

					if var_119_3 + 0 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_3 + 0
					end
				end

				arg_116_1.text_.text = var_119_1
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)
				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_4 = math.max(var_119_0, arg_116_1.talkMaxDuration)

			if 0 <= arg_116_1.time_ and arg_116_1.time_ < 0 + var_119_4 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - 0) / var_119_4

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= 0 + var_119_4 and arg_116_1.time_ < 0 + var_119_4 + arg_119_0 then
				arg_116_1.typewritter.percent = 1

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(true)
			end
		end

		arg_116_1.nodeConfigList_ = {}

		arg_116_1:InitPlayNodeList()
	end,
	Play116331027 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 116331027
		arg_120_1.duration_ = 5

		SetActive(arg_120_1.tipsGo_, false)

		function arg_120_1.onSingleLineFinish_()
			arg_120_1.onSingleLineUpdate_ = nil
			arg_120_1.onSingleLineFinish_ = nil
			arg_120_1.state_ = "waiting"
		end

		function arg_120_1.playNext_(arg_122_0)
			if arg_122_0 == 1 then
				arg_120_0:Play116331028(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			local var_123_0 = 0.85

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0
				arg_120_1.dialogCg_.alpha = 1

				arg_120_1.dialog_:SetActive(true)
				SetActive(arg_120_1.leftNameGo_, false)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_120_1.iconTrs_.gameObject, false)
				arg_120_1.callingController_:SetSelectedState("normal")

				local var_123_1 = arg_120_1:FormatText(arg_120_1:GetWordFromCfg(116331027).content)

				arg_120_1.text_.text = var_123_1

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_3 = 34 <= 0 and var_123_0 or var_123_0 * (utf8.len(var_123_1) / 34)

				if (34 <= 0 and var_123_0 or var_123_0 * (utf8.len(var_123_1) / 34)) > 0 and var_123_0 < var_123_3 then
					arg_120_1.talkMaxDuration = var_123_3

					if var_123_3 + 0 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_3 + 0
					end
				end

				arg_120_1.text_.text = var_123_1
				arg_120_1.typewritter.percent = 0

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(false)
				arg_120_1:RecordContent(arg_120_1.text_.text)
			end

			local var_123_4 = math.max(var_123_0, arg_120_1.talkMaxDuration)

			if 0 <= arg_120_1.time_ and arg_120_1.time_ < 0 + var_123_4 then
				arg_120_1.typewritter.percent = (arg_120_1.time_ - 0) / var_123_4

				arg_120_1.typewritter:SetDirty()
			end

			if arg_120_1.time_ >= 0 + var_123_4 and arg_120_1.time_ < 0 + var_123_4 + arg_123_0 then
				arg_120_1.typewritter.percent = 1

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(true)
			end
		end

		arg_120_1.nodeConfigList_ = {}

		arg_120_1:InitPlayNodeList()
	end,
	Play116331028 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 116331028
		arg_124_1.duration_ = 6.8

		local var_124_0 = {
			zh = 4.7,
			ja = 6.8
		}
		local var_124_1 = manager.audio:GetLocalizationFlag()

		if var_124_0[var_124_1] ~= nil then
			arg_124_1.duration_ = var_124_0[var_124_1]
		end

		SetActive(arg_124_1.tipsGo_, false)

		function arg_124_1.onSingleLineFinish_()
			arg_124_1.onSingleLineUpdate_ = nil
			arg_124_1.onSingleLineFinish_ = nil
			arg_124_1.state_ = "waiting"
		end

		function arg_124_1.playNext_(arg_126_0)
			if arg_126_0 == 1 then
				arg_124_0:Play116331029(arg_124_1)
			end
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 then
				arg_124_1.var_.moveOldPos10032ui_story = arg_124_1.actors_["10032ui_story"].transform.localPosition
			end

			local var_127_0 = 0.001

			if 0 <= arg_124_1.time_ and arg_124_1.time_ < 0 + var_127_0 then
				arg_124_1.actors_["10032ui_story"].transform.localPosition = Vector3.Lerp(arg_124_1.var_.moveOldPos10032ui_story, Vector3.New(0, -1.1, -5.9), (arg_124_1.time_ - 0) / var_127_0)
				arg_124_1.actors_["10032ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_124_1.actors_["10032ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_124_1.actors_["10032ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_124_1.actors_["10032ui_story"].transform.position).z)
				arg_124_1.actors_["10032ui_story"].transform.localEulerAngles.z = 0
				arg_124_1.actors_["10032ui_story"].transform.localEulerAngles.x = 0
				arg_124_1.actors_["10032ui_story"].transform.localEulerAngles = arg_124_1.actors_["10032ui_story"].transform.localEulerAngles
			end

			if arg_124_1.time_ >= 0 + var_127_0 and arg_124_1.time_ < 0 + var_127_0 + arg_127_0 then
				arg_124_1.actors_["10032ui_story"].transform.localPosition = Vector3.New(0, -1.1, -5.9)
				arg_124_1.actors_["10032ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_124_1.actors_["10032ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_124_1.actors_["10032ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_124_1.actors_["10032ui_story"].transform.position).z)
				arg_124_1.actors_["10032ui_story"].transform.localEulerAngles.z = 0
				arg_124_1.actors_["10032ui_story"].transform.localEulerAngles.x = 0
				arg_124_1.actors_["10032ui_story"].transform.localEulerAngles = arg_124_1.actors_["10032ui_story"].transform.localEulerAngles
			end

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 then
				arg_124_1:PlayTimeline("10032ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action4_1")
			end

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 then
				arg_124_1:PlayTimeline("10032ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_127_1 = arg_124_1.actors_["10032ui_story"]

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 and not isNil(var_127_1) and arg_124_1.var_.characterEffect10032ui_story == nil then
				arg_124_1.var_.characterEffect10032ui_story = var_127_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_127_2 = 0.2

			if 0 <= arg_124_1.time_ and arg_124_1.time_ < 0 + var_127_2 and not isNil(var_127_1) then
				if arg_124_1.var_.characterEffect10032ui_story and not isNil(var_127_1) then
					arg_124_1.var_.characterEffect10032ui_story.fillFlat = false
				end
			end

			if arg_124_1.time_ >= 0 + var_127_2 and arg_124_1.time_ < 0 + var_127_2 + arg_127_0 and not isNil(var_127_1) and arg_124_1.var_.characterEffect10032ui_story then
				arg_124_1.var_.characterEffect10032ui_story.fillFlat = false
			end

			local var_127_4 = 0
			local var_127_5 = 0.475

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= var_127_4 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, true)

				arg_124_1.leftNameTxt_.text = arg_124_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_124_1.leftNameTxt_.transform)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1.leftNameTxt_.text)
				SetActive(arg_124_1.iconTrs_.gameObject, false)
				arg_124_1.callingController_:SetSelectedState("normal")

				local var_127_6 = arg_124_1:GetWordFromCfg(116331028)
				local var_127_7 = arg_124_1:FormatText(var_127_6.content)

				arg_124_1.text_.text = var_127_7

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_9 = 19 <= 0 and var_127_5 or var_127_5 * (utf8.len(var_127_7) / 19)

				if (19 <= 0 and var_127_5 or var_127_5 * (utf8.len(var_127_7) / 19)) > 0 and var_127_5 < var_127_9 then
					arg_124_1.talkMaxDuration = var_127_9

					if var_127_9 + var_127_4 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_9 + var_127_4
					end
				end

				arg_124_1.text_.text = var_127_7
				arg_124_1.typewritter.percent = 0

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116331", "116331028", "story_v_out_116331.awb") ~= 0 then
					local var_127_10 = manager.audio:GetVoiceLength("story_v_out_116331", "116331028", "story_v_out_116331.awb") / 1000

					if var_127_10 + var_127_4 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_10 + var_127_4
					end

					if var_127_6.prefab_name ~= "" and arg_124_1.actors_[var_127_6.prefab_name] ~= nil then
						local var_127_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_124_1.actors_[var_127_6.prefab_name].transform, "story_v_out_116331", "116331028", "story_v_out_116331.awb")

						arg_124_1:RecordAudio("116331028", var_127_11)
						arg_124_1:RecordAudio("116331028", var_127_11)
					else
						arg_124_1:AudioAction("play", "voice", "story_v_out_116331", "116331028", "story_v_out_116331.awb")
					end

					arg_124_1:RecordHistoryTalkVoice("story_v_out_116331", "116331028", "story_v_out_116331.awb")
				end

				arg_124_1:RecordContent(arg_124_1.text_.text)
			end

			local var_127_12 = math.max(var_127_5, arg_124_1.talkMaxDuration)

			if var_127_4 <= arg_124_1.time_ and arg_124_1.time_ < var_127_4 + var_127_12 then
				arg_124_1.typewritter.percent = (arg_124_1.time_ - var_127_4) / var_127_12

				arg_124_1.typewritter:SetDirty()
			end

			if arg_124_1.time_ >= var_127_4 + var_127_12 and arg_124_1.time_ < var_127_4 + var_127_12 + arg_127_0 then
				arg_124_1.typewritter.percent = 1

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(true)
			end
		end

		arg_124_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10032ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_124_1:InitPlayNodeList()
	end,
	Play116331029 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 116331029
		arg_128_1.duration_ = 16.25

		SetActive(arg_128_1.tipsGo_, false)

		function arg_128_1.onSingleLineFinish_()
			arg_128_1.onSingleLineUpdate_ = nil
			arg_128_1.onSingleLineFinish_ = nil
			arg_128_1.state_ = "waiting"
		end

		function arg_128_1.playNext_(arg_130_0)
			if arg_130_0 == 1 then
				arg_128_0:Play116331030(arg_128_1)
			end
		end

		function arg_128_1.onSingleLineUpdate_(arg_131_0)
			if arg_128_1.bgs_.STwhite == nil then
				local var_131_0 = Object.Instantiate(arg_128_1.paintGo_)

				var_131_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "STwhite")
				var_131_0.name = "STwhite"
				var_131_0.transform.parent = arg_128_1.stage_.transform
				var_131_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_128_1.bgs_.STwhite = var_131_0
			end

			if 2 < arg_128_1.time_ and arg_128_1.time_ <= 2 + arg_131_0 then
				local var_131_1 = arg_128_1.bgs_.STwhite

				arg_128_1.bgs_.STwhite.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_131_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_131_2 = var_131_1:GetComponent("SpriteRenderer")

				if var_131_2 and var_131_2.sprite then
					local var_131_3 = 2 * (var_131_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_131_1.transform.localScale = Vector3.New(var_131_3 / var_131_2.sprite.bounds.size.y < var_131_3 * manager.ui.mainCameraCom_.aspect / var_131_2.sprite.bounds.size.x and var_131_3 * manager.ui.mainCameraCom_.aspect / var_131_2.sprite.bounds.size.x or var_131_3 / var_131_2.sprite.bounds.size.y, var_131_3 / var_131_2.sprite.bounds.size.y < var_131_3 * manager.ui.mainCameraCom_.aspect / var_131_2.sprite.bounds.size.x and var_131_3 * manager.ui.mainCameraCom_.aspect / var_131_2.sprite.bounds.size.x or var_131_3 / var_131_2.sprite.bounds.size.y, 0)
				end

				for iter_131_0, iter_131_1 in pairs(arg_128_1.bgs_) do
					if iter_131_0 ~= "STwhite" then
						iter_131_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 2 < arg_128_1.time_ and arg_128_1.time_ <= 2 + arg_131_0 then
				arg_128_1.fswbg_:SetActive(true)
				arg_128_1.dialog_:SetActive(false)

				arg_128_1.fswtw_.percent = 0
				arg_128_1.fswt_.text = arg_128_1:FormatText(arg_128_1:GetWordFromCfg(116331029).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.fswt_)

				arg_128_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_128_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_128_1.fswtw_:SetDirty()

				arg_128_1.typewritterCharCountI18N = 0

				SetActive(arg_128_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_128_1:ShowNextGo(false)
			end

			local var_131_4 = 4

			if 4 < arg_128_1.time_ and arg_128_1.time_ <= var_131_4 + arg_131_0 then
				arg_128_1.var_.oldValueTypewriter = arg_128_1.fswtw_.percent

				SetActive(arg_128_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_128_1:ShowNextGo(false)
			end

			local var_131_5 = 59
			local var_131_6 = 2.95
			local var_131_7, var_131_8 = arg_128_1:GetPercentByPara(arg_128_1:FormatText(arg_128_1:GetWordFromCfg(116331029).content), 1)

			if var_131_4 < arg_128_1.time_ and arg_128_1.time_ <= var_131_4 + arg_131_0 then
				arg_128_1.talkMaxDuration = 0

				local var_131_9 = var_131_5 <= 0 and var_131_6 or var_131_6 * ((var_131_8 - arg_128_1.typewritterCharCountI18N) / var_131_5)

				if (var_131_5 <= 0 and var_131_6 or var_131_6 * ((var_131_8 - arg_128_1.typewritterCharCountI18N) / var_131_5)) > 0 and var_131_6 < var_131_9 then
					arg_128_1.talkMaxDuration = var_131_9

					if var_131_9 + var_131_4 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_9 + var_131_4
					end
				end
			end

			local var_131_10 = math.max(2.95, arg_128_1.talkMaxDuration)

			if var_131_4 <= arg_128_1.time_ and arg_128_1.time_ < var_131_4 + var_131_10 then
				arg_128_1.fswtw_.percent = Mathf.Lerp(arg_128_1.var_.oldValueTypewriter, var_131_7, (arg_128_1.time_ - var_131_4) / var_131_10)
				arg_128_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_128_1.fswtw_:SetDirty()
			end

			if arg_128_1.time_ >= var_131_4 + var_131_10 and arg_128_1.time_ < var_131_4 + var_131_10 + arg_131_0 then
				arg_128_1.fswtw_.percent = var_131_7

				arg_128_1.fswtw_:SetDirty()
				arg_128_1:ShowNextGo(true)

				arg_128_1.typewritterCharCountI18N = var_131_8
			end

			local var_131_11 = 4
			local var_131_12 = manager.audio:GetVoiceLength("story_v_out_116331", "116331029", "story_v_out_116331.awb") / 1000

			if var_131_12 > 0 and 12.251 < var_131_12 and var_131_12 + var_131_11 > arg_128_1.duration_ then
				arg_128_1.duration_ = var_131_12 + var_131_11
			end

			if var_131_11 < arg_128_1.time_ and arg_128_1.time_ <= var_131_11 + arg_131_0 then
				arg_128_1:AudioAction("play", "voice", "story_v_out_116331", "116331029", "story_v_out_116331.awb")
			end

			local var_131_14 = arg_128_1.actors_["10032ui_story"].transform

			if 2 < arg_128_1.time_ and arg_128_1.time_ <= 2 + arg_131_0 then
				arg_128_1.var_.moveOldPos10032ui_story = var_131_14.localPosition
			end

			local var_131_15 = 0.001

			if 2 <= arg_128_1.time_ and arg_128_1.time_ < 2 + var_131_15 then
				var_131_14.localPosition = Vector3.Lerp(arg_128_1.var_.moveOldPos10032ui_story, Vector3.New(0, 100, 0), (arg_128_1.time_ - 2) / var_131_15)
				var_131_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_131_14.position).x, (manager.ui.mainCamera.transform.position - var_131_14.position).y, (manager.ui.mainCamera.transform.position - var_131_14.position).z)
				var_131_14.localEulerAngles.z = 0
				var_131_14.localEulerAngles.x = 0
				var_131_14.localEulerAngles = var_131_14.localEulerAngles
			end

			if arg_128_1.time_ >= 2 + var_131_15 and arg_128_1.time_ < 2 + var_131_15 + arg_131_0 then
				var_131_14.localPosition = Vector3.New(0, 100, 0)
				var_131_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_131_14.position).x, (manager.ui.mainCamera.transform.position - var_131_14.position).y, (manager.ui.mainCamera.transform.position - var_131_14.position).z)
				var_131_14.localEulerAngles.z = 0
				var_131_14.localEulerAngles.x = 0
				var_131_14.localEulerAngles = var_131_14.localEulerAngles
			end

			if 4 < arg_128_1.time_ and arg_128_1.time_ <= 4 + arg_131_0 then
				arg_128_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_131_18 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_128_1.bgmTxt_.text ~= var_131_18 and arg_128_1.bgmTxt_.text ~= "" then
						if arg_128_1.bgmTxt2_.text ~= "" then
							arg_128_1.bgmTxt_.text = arg_128_1.bgmTxt2_.text
						end

						arg_128_1.bgmTxt2_.text = var_131_18

						arg_128_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_128_1.bgmTxt_.text = var_131_18
						arg_128_1.bgmTxt2_.text = var_131_18
					end

					if arg_128_1.bgmTimer then
						arg_128_1.bgmTimer:Stop()

						arg_128_1.bgmTimer = nil
					end

					if arg_128_1.settingData.show_music_name == 1 then
						arg_128_1.musicController:SetSelectedState("show")
						arg_128_1.musicAnimator_:Play("open", 0, 0)

						if arg_128_1.settingData.music_time ~= 0 then
							arg_128_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_128_1.settingData.music_time), function()
								if arg_128_1 == nil or isNil(arg_128_1.bgmTxt_) then
									return
								end

								arg_128_1.musicController:SetSelectedState("hide")
								arg_128_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 4.4 < arg_128_1.time_ and arg_128_1.time_ <= 4.4 + arg_131_0 then
				arg_128_1:AudioAction("play", "music", "bgm_activity_1_6_story_story", "bgm_activity_1_6_story_story", "bgm_activity_1_6_story_story.awb")

				if "" ~= "" then
					if arg_128_1.bgmTxt_.text ~= "" and arg_128_1.bgmTxt_.text ~= "" then
						if arg_128_1.bgmTxt2_.text ~= "" then
							arg_128_1.bgmTxt_.text = arg_128_1.bgmTxt2_.text
						end

						arg_128_1.bgmTxt2_.text = ""

						arg_128_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_128_1.bgmTxt_.text = ""
						arg_128_1.bgmTxt2_.text = ""
					end

					if arg_128_1.bgmTimer then
						arg_128_1.bgmTimer:Stop()

						arg_128_1.bgmTimer = nil
					end

					if arg_128_1.settingData.show_music_name == 1 then
						arg_128_1.musicController:SetSelectedState("show")
						arg_128_1.musicAnimator_:Play("open", 0, 0)

						if arg_128_1.settingData.music_time ~= 0 then
							arg_128_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_128_1.settingData.music_time), function()
								if arg_128_1 == nil or isNil(arg_128_1.bgmTxt_) then
									return
								end

								arg_128_1.musicController:SetSelectedState("hide")
								arg_128_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 4.575 < arg_128_1.time_ and arg_128_1.time_ <= 4.575 + arg_131_0 then
				arg_128_1:AudioAction("play", "music", "bgm_activity_1_6_story_story", "story", "bgm_activity_1_6_story_story.awb")

				if MusicRecordCfg[97].musicName ~= "" then
					if arg_128_1.bgmTxt_.text ~= MusicRecordCfg[97].musicName and arg_128_1.bgmTxt_.text ~= "" then
						if arg_128_1.bgmTxt2_.text ~= "" then
							arg_128_1.bgmTxt_.text = arg_128_1.bgmTxt2_.text
						end

						arg_128_1.bgmTxt2_.text = MusicRecordCfg[97].musicName

						arg_128_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_128_1.bgmTxt_.text = MusicRecordCfg[97].musicName
						arg_128_1.bgmTxt2_.text = MusicRecordCfg[97].musicName
					end

					if arg_128_1.bgmTimer then
						arg_128_1.bgmTimer:Stop()

						arg_128_1.bgmTimer = nil
					end

					if arg_128_1.settingData.show_music_name == 1 then
						arg_128_1.musicController:SetSelectedState("show")
						arg_128_1.musicAnimator_:Play("open", 0, 0)

						if arg_128_1.settingData.music_time ~= 0 then
							arg_128_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_128_1.settingData.music_time), function()
								if arg_128_1 == nil or isNil(arg_128_1.bgmTxt_) then
									return
								end

								arg_128_1.musicController:SetSelectedState("hide")
								arg_128_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_131_22 = 0

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= var_131_22 + arg_131_0 then
				arg_128_1.mask_.enabled = true
				arg_128_1.mask_.raycastTarget = true

				arg_128_1:SetGaussion(false)
			end

			local var_131_23 = 2

			if var_131_22 <= arg_128_1.time_ and arg_128_1.time_ < var_131_22 + var_131_23 then
				local var_131_24 = Color.New(0, 0, 0)

				var_131_24.a = Mathf.Lerp(0, 1, (arg_128_1.time_ - var_131_22) / var_131_23)
				arg_128_1.mask_.color = var_131_24
			end

			if arg_128_1.time_ >= var_131_22 + var_131_23 and arg_128_1.time_ < var_131_22 + var_131_23 + arg_131_0 then
				local var_131_25 = Color.New(0, 0, 0)

				var_131_25.a = 1
				arg_128_1.mask_.color = var_131_25
			end

			local var_131_26 = 2

			if 2 < arg_128_1.time_ and arg_128_1.time_ <= var_131_26 + arg_131_0 then
				arg_128_1.mask_.enabled = true
				arg_128_1.mask_.raycastTarget = true

				arg_128_1:SetGaussion(false)
			end

			local var_131_27 = 2

			if var_131_26 <= arg_128_1.time_ and arg_128_1.time_ < var_131_26 + var_131_27 then
				local var_131_28 = Color.New(0, 0, 0)

				var_131_28.a = Mathf.Lerp(1, 0, (arg_128_1.time_ - var_131_26) / var_131_27)
				arg_128_1.mask_.color = var_131_28
			end

			if arg_128_1.time_ >= var_131_26 + var_131_27 and arg_128_1.time_ < var_131_26 + var_131_27 + arg_131_0 then
				local var_131_29 = Color.New(0, 0, 0)

				arg_128_1.mask_.enabled = false
				var_131_29.a = 0
				arg_128_1.mask_.color = var_131_29
			end

			local var_131_30 = 4

			if 4 < arg_128_1.time_ and arg_128_1.time_ <= var_131_30 + arg_131_0 then
				arg_128_1.allBtn_.enabled = false
			end

			if arg_128_1.time_ >= var_131_30 + 2.95 and arg_128_1.time_ < var_131_30 + 2.95 + arg_131_0 then
				arg_128_1.allBtn_.enabled = true
			end
		end

		arg_128_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10032ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_128_1:InitPlayNodeList()
	end,
	Play116331030 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 116331030
		arg_135_1.duration_ = 11.48

		SetActive(arg_135_1.tipsGo_, false)

		function arg_135_1.onSingleLineFinish_()
			arg_135_1.onSingleLineUpdate_ = nil
			arg_135_1.onSingleLineFinish_ = nil
			arg_135_1.state_ = "waiting"
		end

		function arg_135_1.playNext_(arg_137_0)
			if arg_137_0 == 1 then
				arg_135_0:Play116331031(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				arg_135_1.var_.oldValueTypewriter = arg_135_1.fswtw_.percent

				SetActive(arg_135_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_135_1:ShowNextGo(false)
			end

			local var_138_0 = 0
			local var_138_1 = -1
			local var_138_2, var_138_3 = arg_135_1:GetPercentByPara(arg_135_1:FormatText(arg_135_1:GetWordFromCfg(116331029).content), 1)

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0

				local var_138_4 = var_138_0 <= 0 and var_138_1 or var_138_1 * ((var_138_3 - arg_135_1.typewritterCharCountI18N) / var_138_0)

				if (var_138_0 <= 0 and var_138_1 or var_138_1 * ((var_138_3 - arg_135_1.typewritterCharCountI18N) / var_138_0)) > 0 and var_138_1 < var_138_4 then
					arg_135_1.talkMaxDuration = var_138_4

					if var_138_4 + 0 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_4 + 0
					end
				end
			end

			local var_138_5 = math.max(-1, arg_135_1.talkMaxDuration)

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_5 then
				arg_135_1.fswtw_.percent = Mathf.Lerp(arg_135_1.var_.oldValueTypewriter, var_138_2, (arg_135_1.time_ - 0) / var_138_5)
				arg_135_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_135_1.fswtw_:SetDirty()
			end

			if arg_135_1.time_ >= 0 + var_138_5 and arg_135_1.time_ < 0 + var_138_5 + arg_138_0 then
				arg_135_1.fswtw_.percent = var_138_2

				arg_135_1.fswtw_:SetDirty()
				arg_135_1:ShowNextGo(true)

				arg_135_1.typewritterCharCountI18N = var_138_3
			end

			local var_138_6 = 0

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= var_138_6 + arg_138_0 then
				arg_135_1.var_.oldValueTypewriter = arg_135_1.fswtw_.percent

				SetActive(arg_135_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_135_1:ShowNextGo(false)
			end

			local var_138_7 = 47
			local var_138_8 = 2.35
			local var_138_9, var_138_10 = arg_135_1:GetPercentByPara(arg_135_1:FormatText(arg_135_1:GetWordFromCfg(116331029).content), 2)

			if var_138_6 < arg_135_1.time_ and arg_135_1.time_ <= var_138_6 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0

				local var_138_11 = var_138_7 <= 0 and var_138_8 or var_138_8 * ((var_138_10 - arg_135_1.typewritterCharCountI18N) / var_138_7)

				if (var_138_7 <= 0 and var_138_8 or var_138_8 * ((var_138_10 - arg_135_1.typewritterCharCountI18N) / var_138_7)) > 0 and var_138_8 < var_138_11 then
					arg_135_1.talkMaxDuration = var_138_11

					if var_138_11 + var_138_6 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_11 + var_138_6
					end
				end
			end

			local var_138_12 = math.max(2.35, arg_135_1.talkMaxDuration)

			if var_138_6 <= arg_135_1.time_ and arg_135_1.time_ < var_138_6 + var_138_12 then
				arg_135_1.fswtw_.percent = Mathf.Lerp(arg_135_1.var_.oldValueTypewriter, var_138_9, (arg_135_1.time_ - var_138_6) / var_138_12)
				arg_135_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_135_1.fswtw_:SetDirty()
			end

			if arg_135_1.time_ >= var_138_6 + var_138_12 and arg_135_1.time_ < var_138_6 + var_138_12 + arg_138_0 then
				arg_135_1.fswtw_.percent = var_138_9

				arg_135_1.fswtw_:SetDirty()
				arg_135_1:ShowNextGo(true)

				arg_135_1.typewritterCharCountI18N = var_138_10
			end

			local var_138_13 = 0
			local var_138_14 = manager.audio:GetVoiceLength("story_v_out_116331", "116331030", "story_v_out_116331.awb") / 1000

			if var_138_14 > 0 and 11.482 < var_138_14 and var_138_14 + var_138_13 > arg_135_1.duration_ then
				arg_135_1.duration_ = var_138_14 + var_138_13
			end

			if var_138_13 < arg_135_1.time_ and arg_135_1.time_ <= var_138_13 + arg_138_0 then
				arg_135_1:AudioAction("play", "voice", "story_v_out_116331", "116331030", "story_v_out_116331.awb")
			end

			local var_138_16 = 0

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= var_138_16 + arg_138_0 then
				arg_135_1.allBtn_.enabled = false
			end

			if arg_135_1.time_ >= var_138_16 + 2.35 and arg_135_1.time_ < var_138_16 + 2.35 + arg_138_0 then
				arg_135_1.allBtn_.enabled = true
			end
		end

		arg_135_1.nodeConfigList_ = {}

		arg_135_1:InitPlayNodeList()
	end,
	Play116331031 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 116331031
		arg_139_1.duration_ = 12.41

		SetActive(arg_139_1.tipsGo_, false)

		function arg_139_1.onSingleLineFinish_()
			arg_139_1.onSingleLineUpdate_ = nil
			arg_139_1.onSingleLineFinish_ = nil
			arg_139_1.state_ = "waiting"
		end

		function arg_139_1.playNext_(arg_141_0)
			if arg_141_0 == 1 then
				arg_139_0:Play116331032(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1.var_.oldValueTypewriter = arg_139_1.fswtw_.percent

				SetActive(arg_139_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_139_1:ShowNextGo(false)
			end

			local var_142_0 = 0
			local var_142_1 = -2.53333333333333
			local var_142_2, var_142_3 = arg_139_1:GetPercentByPara(arg_139_1:FormatText(arg_139_1:GetWordFromCfg(116331029).content), 1)

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0

				local var_142_4 = var_142_0 <= 0 and var_142_1 or var_142_1 * ((var_142_3 - arg_139_1.typewritterCharCountI18N) / var_142_0)

				if (var_142_0 <= 0 and var_142_1 or var_142_1 * ((var_142_3 - arg_139_1.typewritterCharCountI18N) / var_142_0)) > 0 and var_142_1 < var_142_4 then
					arg_139_1.talkMaxDuration = var_142_4

					if var_142_4 + 0 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_4 + 0
					end
				end
			end

			local var_142_5 = math.max(-2.53333333333333, arg_139_1.talkMaxDuration)

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_5 then
				arg_139_1.fswtw_.percent = Mathf.Lerp(arg_139_1.var_.oldValueTypewriter, var_142_2, (arg_139_1.time_ - 0) / var_142_5)
				arg_139_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_139_1.fswtw_:SetDirty()
			end

			if arg_139_1.time_ >= 0 + var_142_5 and arg_139_1.time_ < 0 + var_142_5 + arg_142_0 then
				arg_139_1.fswtw_.percent = var_142_2

				arg_139_1.fswtw_:SetDirty()
				arg_139_1:ShowNextGo(true)

				arg_139_1.typewritterCharCountI18N = var_142_3
			end

			local var_142_6 = 0

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= var_142_6 + arg_142_0 then
				arg_139_1.var_.oldValueTypewriter = arg_139_1.fswtw_.percent

				SetActive(arg_139_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_139_1:ShowNextGo(false)
			end

			local var_142_7 = 53
			local var_142_8 = 2.65
			local var_142_9, var_142_10 = arg_139_1:GetPercentByPara(arg_139_1:FormatText(arg_139_1:GetWordFromCfg(116331029).content), 3)

			if var_142_6 < arg_139_1.time_ and arg_139_1.time_ <= var_142_6 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0

				local var_142_11 = var_142_7 <= 0 and var_142_8 or var_142_8 * ((var_142_10 - arg_139_1.typewritterCharCountI18N) / var_142_7)

				if (var_142_7 <= 0 and var_142_8 or var_142_8 * ((var_142_10 - arg_139_1.typewritterCharCountI18N) / var_142_7)) > 0 and var_142_8 < var_142_11 then
					arg_139_1.talkMaxDuration = var_142_11

					if var_142_11 + var_142_6 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_11 + var_142_6
					end
				end
			end

			local var_142_12 = math.max(2.65, arg_139_1.talkMaxDuration)

			if var_142_6 <= arg_139_1.time_ and arg_139_1.time_ < var_142_6 + var_142_12 then
				arg_139_1.fswtw_.percent = Mathf.Lerp(arg_139_1.var_.oldValueTypewriter, var_142_9, (arg_139_1.time_ - var_142_6) / var_142_12)
				arg_139_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_139_1.fswtw_:SetDirty()
			end

			if arg_139_1.time_ >= var_142_6 + var_142_12 and arg_139_1.time_ < var_142_6 + var_142_12 + arg_142_0 then
				arg_139_1.fswtw_.percent = var_142_9

				arg_139_1.fswtw_:SetDirty()
				arg_139_1:ShowNextGo(true)

				arg_139_1.typewritterCharCountI18N = var_142_10
			end

			local var_142_13 = 0
			local var_142_14 = manager.audio:GetVoiceLength("story_v_out_116331", "116331031", "story_v_out_116331.awb") / 1000

			if var_142_14 > 0 and 12.414 < var_142_14 and var_142_14 + var_142_13 > arg_139_1.duration_ then
				arg_139_1.duration_ = var_142_14 + var_142_13
			end

			if var_142_13 < arg_139_1.time_ and arg_139_1.time_ <= var_142_13 + arg_142_0 then
				arg_139_1:AudioAction("play", "voice", "story_v_out_116331", "116331031", "story_v_out_116331.awb")
			end

			local var_142_16 = 0

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= var_142_16 + arg_142_0 then
				arg_139_1.allBtn_.enabled = false
			end

			if arg_139_1.time_ >= var_142_16 + 2.65 and arg_139_1.time_ < var_142_16 + 2.65 + arg_142_0 then
				arg_139_1.allBtn_.enabled = true
			end
		end

		arg_139_1.nodeConfigList_ = {}

		arg_139_1:InitPlayNodeList()
	end,
	Play116331032 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 116331032
		arg_143_1.duration_ = 4.23

		SetActive(arg_143_1.tipsGo_, false)

		function arg_143_1.onSingleLineFinish_()
			arg_143_1.onSingleLineUpdate_ = nil
			arg_143_1.onSingleLineFinish_ = nil
			arg_143_1.state_ = "waiting"
		end

		function arg_143_1.playNext_(arg_145_0)
			if arg_145_0 == 1 then
				arg_143_0:Play116331033(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1.var_.oldValueTypewriter = arg_143_1.fswtw_.percent

				SetActive(arg_143_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_143_1:ShowNextGo(false)
			end

			local var_146_0 = 0
			local var_146_1 = -5.26666666666667
			local var_146_2, var_146_3 = arg_143_1:GetPercentByPara(arg_143_1:FormatText(arg_143_1:GetWordFromCfg(116331029).content), 2)

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0

				local var_146_4 = var_146_0 <= 0 and var_146_1 or var_146_1 * ((var_146_3 - arg_143_1.typewritterCharCountI18N) / var_146_0)

				if (var_146_0 <= 0 and var_146_1 or var_146_1 * ((var_146_3 - arg_143_1.typewritterCharCountI18N) / var_146_0)) > 0 and var_146_1 < var_146_4 then
					arg_143_1.talkMaxDuration = var_146_4

					if var_146_4 + 0 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_4 + 0
					end
				end
			end

			local var_146_5 = math.max(-5.26666666666667, arg_143_1.talkMaxDuration)

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_5 then
				arg_143_1.fswtw_.percent = Mathf.Lerp(arg_143_1.var_.oldValueTypewriter, var_146_2, (arg_143_1.time_ - 0) / var_146_5)
				arg_143_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_143_1.fswtw_:SetDirty()
			end

			if arg_143_1.time_ >= 0 + var_146_5 and arg_143_1.time_ < 0 + var_146_5 + arg_146_0 then
				arg_143_1.fswtw_.percent = var_146_2

				arg_143_1.fswtw_:SetDirty()
				arg_143_1:ShowNextGo(true)

				arg_143_1.typewritterCharCountI18N = var_146_3
			end

			local var_146_6 = 0

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= var_146_6 + arg_146_0 then
				arg_143_1.var_.oldValueTypewriter = arg_143_1.fswtw_.percent

				SetActive(arg_143_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_143_1:ShowNextGo(false)
			end

			local var_146_7 = 25
			local var_146_8 = 1.25
			local var_146_9, var_146_10 = arg_143_1:GetPercentByPara(arg_143_1:FormatText(arg_143_1:GetWordFromCfg(116331029).content), 4)

			if var_146_6 < arg_143_1.time_ and arg_143_1.time_ <= var_146_6 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0

				local var_146_11 = var_146_7 <= 0 and var_146_8 or var_146_8 * ((var_146_10 - arg_143_1.typewritterCharCountI18N) / var_146_7)

				if (var_146_7 <= 0 and var_146_8 or var_146_8 * ((var_146_10 - arg_143_1.typewritterCharCountI18N) / var_146_7)) > 0 and var_146_8 < var_146_11 then
					arg_143_1.talkMaxDuration = var_146_11

					if var_146_11 + var_146_6 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_11 + var_146_6
					end
				end
			end

			local var_146_12 = math.max(1.25, arg_143_1.talkMaxDuration)

			if var_146_6 <= arg_143_1.time_ and arg_143_1.time_ < var_146_6 + var_146_12 then
				arg_143_1.fswtw_.percent = Mathf.Lerp(arg_143_1.var_.oldValueTypewriter, var_146_9, (arg_143_1.time_ - var_146_6) / var_146_12)
				arg_143_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_143_1.fswtw_:SetDirty()
			end

			if arg_143_1.time_ >= var_146_6 + var_146_12 and arg_143_1.time_ < var_146_6 + var_146_12 + arg_146_0 then
				arg_143_1.fswtw_.percent = var_146_9

				arg_143_1.fswtw_:SetDirty()
				arg_143_1:ShowNextGo(true)

				arg_143_1.typewritterCharCountI18N = var_146_10
			end

			local var_146_13 = 0
			local var_146_14 = manager.audio:GetVoiceLength("story_v_out_116331", "116331032", "story_v_out_116331.awb") / 1000

			if var_146_14 > 0 and 4.23 < var_146_14 and var_146_14 + var_146_13 > arg_143_1.duration_ then
				arg_143_1.duration_ = var_146_14 + var_146_13
			end

			if var_146_13 < arg_143_1.time_ and arg_143_1.time_ <= var_146_13 + arg_146_0 then
				arg_143_1:AudioAction("play", "voice", "story_v_out_116331", "116331032", "story_v_out_116331.awb")
			end

			local var_146_16 = 0

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= var_146_16 + arg_146_0 then
				arg_143_1.allBtn_.enabled = false
			end

			if arg_143_1.time_ >= var_146_16 + 1.25 and arg_143_1.time_ < var_146_16 + 1.25 + arg_146_0 then
				arg_143_1.allBtn_.enabled = true
			end
		end

		arg_143_1.nodeConfigList_ = {}

		arg_143_1:InitPlayNodeList()
	end,
	Play116331033 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 116331033
		arg_147_1.duration_ = 11.89

		SetActive(arg_147_1.tipsGo_, false)

		function arg_147_1.onSingleLineFinish_()
			arg_147_1.onSingleLineUpdate_ = nil
			arg_147_1.onSingleLineFinish_ = nil
			arg_147_1.state_ = "waiting"
		end

		function arg_147_1.playNext_(arg_149_0)
			if arg_149_0 == 1 then
				arg_147_0:Play116331034(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 then
				arg_147_1.var_.oldValueTypewriter = arg_147_1.fswtw_.percent

				SetActive(arg_147_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_147_1:ShowNextGo(false)
			end

			local var_150_0 = 0
			local var_150_1 = -5.33333333333333
			local var_150_2, var_150_3 = arg_147_1:GetPercentByPara(arg_147_1:FormatText(arg_147_1:GetWordFromCfg(116331029).content), 2)

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0

				local var_150_4 = var_150_0 <= 0 and var_150_1 or var_150_1 * ((var_150_3 - arg_147_1.typewritterCharCountI18N) / var_150_0)

				if (var_150_0 <= 0 and var_150_1 or var_150_1 * ((var_150_3 - arg_147_1.typewritterCharCountI18N) / var_150_0)) > 0 and var_150_1 < var_150_4 then
					arg_147_1.talkMaxDuration = var_150_4

					if var_150_4 + 0 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_4 + 0
					end
				end
			end

			local var_150_5 = math.max(-5.33333333333333, arg_147_1.talkMaxDuration)

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_5 then
				arg_147_1.fswtw_.percent = Mathf.Lerp(arg_147_1.var_.oldValueTypewriter, var_150_2, (arg_147_1.time_ - 0) / var_150_5)
				arg_147_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_147_1.fswtw_:SetDirty()
			end

			if arg_147_1.time_ >= 0 + var_150_5 and arg_147_1.time_ < 0 + var_150_5 + arg_150_0 then
				arg_147_1.fswtw_.percent = var_150_2

				arg_147_1.fswtw_:SetDirty()
				arg_147_1:ShowNextGo(true)

				arg_147_1.typewritterCharCountI18N = var_150_3
			end

			local var_150_6 = 0

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= var_150_6 + arg_150_0 then
				arg_147_1.var_.oldValueTypewriter = arg_147_1.fswtw_.percent

				SetActive(arg_147_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_147_1:ShowNextGo(false)
			end

			local var_150_7 = 52
			local var_150_8 = 2.6
			local var_150_9, var_150_10 = arg_147_1:GetPercentByPara(arg_147_1:FormatText(arg_147_1:GetWordFromCfg(116331029).content), 5)

			if var_150_6 < arg_147_1.time_ and arg_147_1.time_ <= var_150_6 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0

				local var_150_11 = var_150_7 <= 0 and var_150_8 or var_150_8 * ((var_150_10 - arg_147_1.typewritterCharCountI18N) / var_150_7)

				if (var_150_7 <= 0 and var_150_8 or var_150_8 * ((var_150_10 - arg_147_1.typewritterCharCountI18N) / var_150_7)) > 0 and var_150_8 < var_150_11 then
					arg_147_1.talkMaxDuration = var_150_11

					if var_150_11 + var_150_6 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_11 + var_150_6
					end
				end
			end

			local var_150_12 = math.max(2.6, arg_147_1.talkMaxDuration)

			if var_150_6 <= arg_147_1.time_ and arg_147_1.time_ < var_150_6 + var_150_12 then
				arg_147_1.fswtw_.percent = Mathf.Lerp(arg_147_1.var_.oldValueTypewriter, var_150_9, (arg_147_1.time_ - var_150_6) / var_150_12)
				arg_147_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_147_1.fswtw_:SetDirty()
			end

			if arg_147_1.time_ >= var_150_6 + var_150_12 and arg_147_1.time_ < var_150_6 + var_150_12 + arg_150_0 then
				arg_147_1.fswtw_.percent = var_150_9

				arg_147_1.fswtw_:SetDirty()
				arg_147_1:ShowNextGo(true)

				arg_147_1.typewritterCharCountI18N = var_150_10
			end

			local var_150_13 = 0
			local var_150_14 = manager.audio:GetVoiceLength("story_v_out_116331", "116331033", "story_v_out_116331.awb") / 1000

			if var_150_14 > 0 and 11.89 < var_150_14 and var_150_14 + var_150_13 > arg_147_1.duration_ then
				arg_147_1.duration_ = var_150_14 + var_150_13
			end

			if var_150_13 < arg_147_1.time_ and arg_147_1.time_ <= var_150_13 + arg_150_0 then
				arg_147_1:AudioAction("play", "voice", "story_v_out_116331", "116331033", "story_v_out_116331.awb")
			end

			local var_150_16 = 0

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= var_150_16 + arg_150_0 then
				arg_147_1.allBtn_.enabled = false
			end

			if arg_147_1.time_ >= var_150_16 + 2.6 and arg_147_1.time_ < var_150_16 + 2.6 + arg_150_0 then
				arg_147_1.allBtn_.enabled = true
			end
		end

		arg_147_1.nodeConfigList_ = {}

		arg_147_1:InitPlayNodeList()
	end,
	Play116331034 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 116331034
		arg_151_1.duration_ = 3.06

		SetActive(arg_151_1.tipsGo_, false)

		function arg_151_1.onSingleLineFinish_()
			arg_151_1.onSingleLineUpdate_ = nil
			arg_151_1.onSingleLineFinish_ = nil
			arg_151_1.state_ = "waiting"
		end

		function arg_151_1.playNext_(arg_153_0)
			if arg_153_0 == 1 then
				arg_151_0:Play116331035(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 then
				arg_151_1.var_.oldValueTypewriter = arg_151_1.fswtw_.percent

				SetActive(arg_151_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_151_1:ShowNextGo(false)
			end

			local var_154_0 = 0
			local var_154_1 = -8.13333333333333
			local var_154_2, var_154_3 = arg_151_1:GetPercentByPara(arg_151_1:FormatText(arg_151_1:GetWordFromCfg(116331029).content), 2)

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0

				local var_154_4 = var_154_0 <= 0 and var_154_1 or var_154_1 * ((var_154_3 - arg_151_1.typewritterCharCountI18N) / var_154_0)

				if (var_154_0 <= 0 and var_154_1 or var_154_1 * ((var_154_3 - arg_151_1.typewritterCharCountI18N) / var_154_0)) > 0 and var_154_1 < var_154_4 then
					arg_151_1.talkMaxDuration = var_154_4

					if var_154_4 + 0 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_4 + 0
					end
				end
			end

			local var_154_5 = math.max(-8.13333333333333, arg_151_1.talkMaxDuration)

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_5 then
				arg_151_1.fswtw_.percent = Mathf.Lerp(arg_151_1.var_.oldValueTypewriter, var_154_2, (arg_151_1.time_ - 0) / var_154_5)
				arg_151_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_151_1.fswtw_:SetDirty()
			end

			if arg_151_1.time_ >= 0 + var_154_5 and arg_151_1.time_ < 0 + var_154_5 + arg_154_0 then
				arg_151_1.fswtw_.percent = var_154_2

				arg_151_1.fswtw_:SetDirty()
				arg_151_1:ShowNextGo(true)

				arg_151_1.typewritterCharCountI18N = var_154_3
			end

			local var_154_6 = 0

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= var_154_6 + arg_154_0 then
				arg_151_1.var_.oldValueTypewriter = arg_151_1.fswtw_.percent

				SetActive(arg_151_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_151_1:ShowNextGo(false)
			end

			local var_154_7 = 21
			local var_154_8 = 1.05
			local var_154_9, var_154_10 = arg_151_1:GetPercentByPara(arg_151_1:FormatText(arg_151_1:GetWordFromCfg(116331029).content), 6)

			if var_154_6 < arg_151_1.time_ and arg_151_1.time_ <= var_154_6 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0

				local var_154_11 = var_154_7 <= 0 and var_154_8 or var_154_8 * ((var_154_10 - arg_151_1.typewritterCharCountI18N) / var_154_7)

				if (var_154_7 <= 0 and var_154_8 or var_154_8 * ((var_154_10 - arg_151_1.typewritterCharCountI18N) / var_154_7)) > 0 and var_154_8 < var_154_11 then
					arg_151_1.talkMaxDuration = var_154_11

					if var_154_11 + var_154_6 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_11 + var_154_6
					end
				end
			end

			local var_154_12 = math.max(1.05, arg_151_1.talkMaxDuration)

			if var_154_6 <= arg_151_1.time_ and arg_151_1.time_ < var_154_6 + var_154_12 then
				arg_151_1.fswtw_.percent = Mathf.Lerp(arg_151_1.var_.oldValueTypewriter, var_154_9, (arg_151_1.time_ - var_154_6) / var_154_12)
				arg_151_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_151_1.fswtw_:SetDirty()
			end

			if arg_151_1.time_ >= var_154_6 + var_154_12 and arg_151_1.time_ < var_154_6 + var_154_12 + arg_154_0 then
				arg_151_1.fswtw_.percent = var_154_9

				arg_151_1.fswtw_:SetDirty()
				arg_151_1:ShowNextGo(true)

				arg_151_1.typewritterCharCountI18N = var_154_10
			end

			local var_154_13 = 0
			local var_154_14 = manager.audio:GetVoiceLength("story_v_out_116331", "116331034", "story_v_out_116331.awb") / 1000

			if var_154_14 > 0 and 3.059 < var_154_14 and var_154_14 + var_154_13 > arg_151_1.duration_ then
				arg_151_1.duration_ = var_154_14 + var_154_13
			end

			if var_154_13 < arg_151_1.time_ and arg_151_1.time_ <= var_154_13 + arg_154_0 then
				arg_151_1:AudioAction("play", "voice", "story_v_out_116331", "116331034", "story_v_out_116331.awb")
			end

			local var_154_16 = 0

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= var_154_16 + arg_154_0 then
				arg_151_1.allBtn_.enabled = false
			end

			if arg_151_1.time_ >= var_154_16 + 1.05 and arg_151_1.time_ < var_154_16 + 1.05 + arg_154_0 then
				arg_151_1.allBtn_.enabled = true
			end
		end

		arg_151_1.nodeConfigList_ = {}

		arg_151_1:InitPlayNodeList()
	end,
	Play116331035 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 116331035
		arg_155_1.duration_ = 4.57

		SetActive(arg_155_1.tipsGo_, false)

		function arg_155_1.onSingleLineFinish_()
			arg_155_1.onSingleLineUpdate_ = nil
			arg_155_1.onSingleLineFinish_ = nil
			arg_155_1.state_ = "waiting"
		end

		function arg_155_1.playNext_(arg_157_0)
			if arg_157_0 == 1 then
				arg_155_0:Play116331036(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 then
				arg_155_1.fswbg_:SetActive(true)
				arg_155_1.dialog_:SetActive(false)

				arg_155_1.fswtw_.percent = 0
				arg_155_1.fswt_.text = arg_155_1:FormatText(arg_155_1:GetWordFromCfg(116331035).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.fswt_)

				arg_155_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_155_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_155_1.fswtw_:SetDirty()

				arg_155_1.typewritterCharCountI18N = 0

				SetActive(arg_155_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_155_1:ShowNextGo(false)
			end

			local var_158_0 = 0.0166666666666667

			if 0.0166666666666667 < arg_155_1.time_ and arg_155_1.time_ <= var_158_0 + arg_158_0 then
				arg_155_1.var_.oldValueTypewriter = arg_155_1.fswtw_.percent

				SetActive(arg_155_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_155_1:ShowNextGo(false)
			end

			local var_158_1 = 22
			local var_158_2 = 1.46666666666667
			local var_158_3, var_158_4 = arg_155_1:GetPercentByPara(arg_155_1:FormatText(arg_155_1:GetWordFromCfg(116331035).content), 1)

			if var_158_0 < arg_155_1.time_ and arg_155_1.time_ <= var_158_0 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0

				local var_158_5 = var_158_1 <= 0 and var_158_2 or var_158_2 * ((var_158_4 - arg_155_1.typewritterCharCountI18N) / var_158_1)

				if (var_158_1 <= 0 and var_158_2 or var_158_2 * ((var_158_4 - arg_155_1.typewritterCharCountI18N) / var_158_1)) > 0 and var_158_2 < var_158_5 then
					arg_155_1.talkMaxDuration = var_158_5

					if var_158_5 + var_158_0 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_5 + var_158_0
					end
				end
			end

			local var_158_6 = math.max(1.46666666666667, arg_155_1.talkMaxDuration)

			if var_158_0 <= arg_155_1.time_ and arg_155_1.time_ < var_158_0 + var_158_6 then
				arg_155_1.fswtw_.percent = Mathf.Lerp(arg_155_1.var_.oldValueTypewriter, var_158_3, (arg_155_1.time_ - var_158_0) / var_158_6)
				arg_155_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_155_1.fswtw_:SetDirty()
			end

			if arg_155_1.time_ >= var_158_0 + var_158_6 and arg_155_1.time_ < var_158_0 + var_158_6 + arg_158_0 then
				arg_155_1.fswtw_.percent = var_158_3

				arg_155_1.fswtw_:SetDirty()
				arg_155_1:ShowNextGo(true)

				arg_155_1.typewritterCharCountI18N = var_158_4
			end

			local var_158_7 = 0
			local var_158_8 = manager.audio:GetVoiceLength("story_v_out_116331", "116331035", "story_v_out_116331.awb") / 1000

			if var_158_8 > 0 and 4.567 < var_158_8 and var_158_8 + var_158_7 > arg_155_1.duration_ then
				arg_155_1.duration_ = var_158_8 + var_158_7
			end

			if var_158_7 < arg_155_1.time_ and arg_155_1.time_ <= var_158_7 + arg_158_0 then
				arg_155_1:AudioAction("play", "voice", "story_v_out_116331", "116331035", "story_v_out_116331.awb")
			end

			local var_158_10 = 0

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= var_158_10 + arg_158_0 then
				arg_155_1.allBtn_.enabled = false
			end

			if arg_155_1.time_ >= var_158_10 + 1.48333333333333 and arg_155_1.time_ < var_158_10 + 1.48333333333333 + arg_158_0 then
				arg_155_1.allBtn_.enabled = true
			end
		end

		arg_155_1.nodeConfigList_ = {}

		arg_155_1:InitPlayNodeList()
	end,
	Play116331036 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 116331036
		arg_159_1.duration_ = 1.18

		SetActive(arg_159_1.tipsGo_, false)

		function arg_159_1.onSingleLineFinish_()
			arg_159_1.onSingleLineUpdate_ = nil
			arg_159_1.onSingleLineFinish_ = nil
			arg_159_1.state_ = "waiting"
		end

		function arg_159_1.playNext_(arg_161_0)
			if arg_161_0 == 1 then
				arg_159_0:Play116331037(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1.var_.oldValueTypewriter = arg_159_1.fswtw_.percent

				SetActive(arg_159_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_159_1:ShowNextGo(false)
			end

			local var_162_0 = 11
			local var_162_1 = 0.733333333333333
			local var_162_2, var_162_3 = arg_159_1:GetPercentByPara(arg_159_1:FormatText(arg_159_1:GetWordFromCfg(116331035).content), 2)

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0

				local var_162_4 = var_162_0 <= 0 and var_162_1 or var_162_1 * ((var_162_3 - arg_159_1.typewritterCharCountI18N) / var_162_0)

				if (var_162_0 <= 0 and var_162_1 or var_162_1 * ((var_162_3 - arg_159_1.typewritterCharCountI18N) / var_162_0)) > 0 and var_162_1 < var_162_4 then
					arg_159_1.talkMaxDuration = var_162_4

					if var_162_4 + 0 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_4 + 0
					end
				end
			end

			local var_162_5 = math.max(0.733333333333333, arg_159_1.talkMaxDuration)

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_5 then
				arg_159_1.fswtw_.percent = Mathf.Lerp(arg_159_1.var_.oldValueTypewriter, var_162_2, (arg_159_1.time_ - 0) / var_162_5)
				arg_159_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_159_1.fswtw_:SetDirty()
			end

			if arg_159_1.time_ >= 0 + var_162_5 and arg_159_1.time_ < 0 + var_162_5 + arg_162_0 then
				arg_159_1.fswtw_.percent = var_162_2

				arg_159_1.fswtw_:SetDirty()
				arg_159_1:ShowNextGo(true)

				arg_159_1.typewritterCharCountI18N = var_162_3
			end

			local var_162_6 = 0
			local var_162_7 = manager.audio:GetVoiceLength("story_v_out_116331", "116331036", "story_v_out_116331.awb") / 1000

			if var_162_7 > 0 and 1.176 < var_162_7 and var_162_7 + var_162_6 > arg_159_1.duration_ then
				arg_159_1.duration_ = var_162_7 + var_162_6
			end

			if var_162_6 < arg_159_1.time_ and arg_159_1.time_ <= var_162_6 + arg_162_0 then
				arg_159_1:AudioAction("play", "voice", "story_v_out_116331", "116331036", "story_v_out_116331.awb")
			end

			local var_162_9 = 0

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= var_162_9 + arg_162_0 then
				arg_159_1.allBtn_.enabled = false
			end

			if arg_159_1.time_ >= var_162_9 + 0.733333333333333 and arg_159_1.time_ < var_162_9 + 0.733333333333333 + arg_162_0 then
				arg_159_1.allBtn_.enabled = true
			end
		end

		arg_159_1.nodeConfigList_ = {}

		arg_159_1:InitPlayNodeList()
	end,
	Play116331037 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 116331037
		arg_163_1.duration_ = 3.89

		SetActive(arg_163_1.tipsGo_, false)

		function arg_163_1.onSingleLineFinish_()
			arg_163_1.onSingleLineUpdate_ = nil
			arg_163_1.onSingleLineFinish_ = nil
			arg_163_1.state_ = "waiting"
		end

		function arg_163_1.playNext_(arg_165_0)
			if arg_165_0 == 1 then
				arg_163_0:Play116331038(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 then
				arg_163_1.var_.oldValueTypewriter = arg_163_1.fswtw_.percent

				SetActive(arg_163_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_163_1:ShowNextGo(false)
			end

			local var_166_0 = 30
			local var_166_1 = 2
			local var_166_2, var_166_3 = arg_163_1:GetPercentByPara(arg_163_1:FormatText(arg_163_1:GetWordFromCfg(116331035).content), 3)

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0

				local var_166_4 = var_166_0 <= 0 and var_166_1 or var_166_1 * ((var_166_3 - arg_163_1.typewritterCharCountI18N) / var_166_0)

				if (var_166_0 <= 0 and var_166_1 or var_166_1 * ((var_166_3 - arg_163_1.typewritterCharCountI18N) / var_166_0)) > 0 and var_166_1 < var_166_4 then
					arg_163_1.talkMaxDuration = var_166_4

					if var_166_4 + 0 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_4 + 0
					end
				end
			end

			local var_166_5 = math.max(2, arg_163_1.talkMaxDuration)

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_5 then
				arg_163_1.fswtw_.percent = Mathf.Lerp(arg_163_1.var_.oldValueTypewriter, var_166_2, (arg_163_1.time_ - 0) / var_166_5)
				arg_163_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_163_1.fswtw_:SetDirty()
			end

			if arg_163_1.time_ >= 0 + var_166_5 and arg_163_1.time_ < 0 + var_166_5 + arg_166_0 then
				arg_163_1.fswtw_.percent = var_166_2

				arg_163_1.fswtw_:SetDirty()
				arg_163_1:ShowNextGo(true)

				arg_163_1.typewritterCharCountI18N = var_166_3
			end

			local var_166_6 = 0
			local var_166_7 = manager.audio:GetVoiceLength("story_v_out_116331", "116331037", "story_v_out_116331.awb") / 1000

			if var_166_7 > 0 and 3.893 < var_166_7 and var_166_7 + var_166_6 > arg_163_1.duration_ then
				arg_163_1.duration_ = var_166_7 + var_166_6
			end

			if var_166_6 < arg_163_1.time_ and arg_163_1.time_ <= var_166_6 + arg_166_0 then
				arg_163_1:AudioAction("play", "voice", "story_v_out_116331", "116331037", "story_v_out_116331.awb")
			end

			local var_166_9 = 0

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= var_166_9 + arg_166_0 then
				arg_163_1.allBtn_.enabled = false
			end

			if arg_163_1.time_ >= var_166_9 + 2 and arg_163_1.time_ < var_166_9 + 2 + arg_166_0 then
				arg_163_1.allBtn_.enabled = true
			end
		end

		arg_163_1.nodeConfigList_ = {}

		arg_163_1:InitPlayNodeList()
	end,
	Play116331038 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 116331038
		arg_167_1.duration_ = 6.07

		SetActive(arg_167_1.tipsGo_, false)

		function arg_167_1.onSingleLineFinish_()
			arg_167_1.onSingleLineUpdate_ = nil
			arg_167_1.onSingleLineFinish_ = nil
			arg_167_1.state_ = "waiting"
		end

		function arg_167_1.playNext_(arg_169_0)
			if arg_169_0 == 1 then
				arg_167_0:Play116331039(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 then
				arg_167_1.var_.oldValueTypewriter = arg_167_1.fswtw_.percent

				SetActive(arg_167_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_167_1:ShowNextGo(false)
			end

			local var_170_0 = 29
			local var_170_1 = 1.93333333333333
			local var_170_2, var_170_3 = arg_167_1:GetPercentByPara(arg_167_1:FormatText(arg_167_1:GetWordFromCfg(116331035).content), 4)

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0

				local var_170_4 = var_170_0 <= 0 and var_170_1 or var_170_1 * ((var_170_3 - arg_167_1.typewritterCharCountI18N) / var_170_0)

				if (var_170_0 <= 0 and var_170_1 or var_170_1 * ((var_170_3 - arg_167_1.typewritterCharCountI18N) / var_170_0)) > 0 and var_170_1 < var_170_4 then
					arg_167_1.talkMaxDuration = var_170_4

					if var_170_4 + 0 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_4 + 0
					end
				end
			end

			local var_170_5 = math.max(1.93333333333333, arg_167_1.talkMaxDuration)

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_5 then
				arg_167_1.fswtw_.percent = Mathf.Lerp(arg_167_1.var_.oldValueTypewriter, var_170_2, (arg_167_1.time_ - 0) / var_170_5)
				arg_167_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_167_1.fswtw_:SetDirty()
			end

			if arg_167_1.time_ >= 0 + var_170_5 and arg_167_1.time_ < 0 + var_170_5 + arg_170_0 then
				arg_167_1.fswtw_.percent = var_170_2

				arg_167_1.fswtw_:SetDirty()
				arg_167_1:ShowNextGo(true)

				arg_167_1.typewritterCharCountI18N = var_170_3
			end

			local var_170_6 = 0
			local var_170_7 = manager.audio:GetVoiceLength("story_v_out_116331", "116331038", "story_v_out_116331.awb") / 1000

			if var_170_7 > 0 and 6.072 < var_170_7 and var_170_7 + var_170_6 > arg_167_1.duration_ then
				arg_167_1.duration_ = var_170_7 + var_170_6
			end

			if var_170_6 < arg_167_1.time_ and arg_167_1.time_ <= var_170_6 + arg_170_0 then
				arg_167_1:AudioAction("play", "voice", "story_v_out_116331", "116331038", "story_v_out_116331.awb")
			end

			local var_170_9 = 0

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= var_170_9 + arg_170_0 then
				arg_167_1.allBtn_.enabled = false
			end

			if arg_167_1.time_ >= var_170_9 + 1.93333333333333 and arg_167_1.time_ < var_170_9 + 1.93333333333333 + arg_170_0 then
				arg_167_1.allBtn_.enabled = true
			end
		end

		arg_167_1.nodeConfigList_ = {}

		arg_167_1:InitPlayNodeList()
	end,
	Play116331039 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 116331039
		arg_171_1.duration_ = 6.24

		SetActive(arg_171_1.tipsGo_, false)

		function arg_171_1.onSingleLineFinish_()
			arg_171_1.onSingleLineUpdate_ = nil
			arg_171_1.onSingleLineFinish_ = nil
			arg_171_1.state_ = "waiting"
		end

		function arg_171_1.playNext_(arg_173_0)
			if arg_173_0 == 1 then
				arg_171_0:Play116331040(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 then
				arg_171_1.var_.oldValueTypewriter = arg_171_1.fswtw_.percent

				SetActive(arg_171_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_171_1:ShowNextGo(false)
			end

			local var_174_0 = 29
			local var_174_1 = 1.93333333333333
			local var_174_2, var_174_3 = arg_171_1:GetPercentByPara(arg_171_1:FormatText(arg_171_1:GetWordFromCfg(116331035).content), 5)

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0

				local var_174_4 = var_174_0 <= 0 and var_174_1 or var_174_1 * ((var_174_3 - arg_171_1.typewritterCharCountI18N) / var_174_0)

				if (var_174_0 <= 0 and var_174_1 or var_174_1 * ((var_174_3 - arg_171_1.typewritterCharCountI18N) / var_174_0)) > 0 and var_174_1 < var_174_4 then
					arg_171_1.talkMaxDuration = var_174_4

					if var_174_4 + 0 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_4 + 0
					end
				end
			end

			local var_174_5 = math.max(1.93333333333333, arg_171_1.talkMaxDuration)

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_5 then
				arg_171_1.fswtw_.percent = Mathf.Lerp(arg_171_1.var_.oldValueTypewriter, var_174_2, (arg_171_1.time_ - 0) / var_174_5)
				arg_171_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_171_1.fswtw_:SetDirty()
			end

			if arg_171_1.time_ >= 0 + var_174_5 and arg_171_1.time_ < 0 + var_174_5 + arg_174_0 then
				arg_171_1.fswtw_.percent = var_174_2

				arg_171_1.fswtw_:SetDirty()
				arg_171_1:ShowNextGo(true)

				arg_171_1.typewritterCharCountI18N = var_174_3
			end

			local var_174_6 = 0
			local var_174_7 = manager.audio:GetVoiceLength("story_v_out_116331", "116331039", "story_v_out_116331.awb") / 1000

			if var_174_7 > 0 and 6.24 < var_174_7 and var_174_7 + var_174_6 > arg_171_1.duration_ then
				arg_171_1.duration_ = var_174_7 + var_174_6
			end

			if var_174_6 < arg_171_1.time_ and arg_171_1.time_ <= var_174_6 + arg_174_0 then
				arg_171_1:AudioAction("play", "voice", "story_v_out_116331", "116331039", "story_v_out_116331.awb")
			end

			local var_174_9 = 0

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= var_174_9 + arg_174_0 then
				arg_171_1.allBtn_.enabled = false
			end

			if arg_171_1.time_ >= var_174_9 + 1.93333333333333 and arg_171_1.time_ < var_174_9 + 1.93333333333333 + arg_174_0 then
				arg_171_1.allBtn_.enabled = true
			end
		end

		arg_171_1.nodeConfigList_ = {}

		arg_171_1:InitPlayNodeList()
	end,
	Play116331040 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 116331040
		arg_175_1.duration_ = 14.15

		SetActive(arg_175_1.tipsGo_, false)

		function arg_175_1.onSingleLineFinish_()
			arg_175_1.onSingleLineUpdate_ = nil
			arg_175_1.onSingleLineFinish_ = nil
			arg_175_1.state_ = "waiting"
		end

		function arg_175_1.playNext_(arg_177_0)
			if arg_177_0 == 1 then
				arg_175_0:Play116331041(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 then
				arg_175_1.var_.oldValueTypewriter = arg_175_1.fswtw_.percent

				SetActive(arg_175_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_175_1:ShowNextGo(false)
			end

			local var_178_0 = 60
			local var_178_1 = 4
			local var_178_2, var_178_3 = arg_175_1:GetPercentByPara(arg_175_1:FormatText(arg_175_1:GetWordFromCfg(116331035).content), 6)

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0

				local var_178_4 = var_178_0 <= 0 and var_178_1 or var_178_1 * ((var_178_3 - arg_175_1.typewritterCharCountI18N) / var_178_0)

				if (var_178_0 <= 0 and var_178_1 or var_178_1 * ((var_178_3 - arg_175_1.typewritterCharCountI18N) / var_178_0)) > 0 and var_178_1 < var_178_4 then
					arg_175_1.talkMaxDuration = var_178_4

					if var_178_4 + 0 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_4 + 0
					end
				end
			end

			local var_178_5 = math.max(4, arg_175_1.talkMaxDuration)

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_5 then
				arg_175_1.fswtw_.percent = Mathf.Lerp(arg_175_1.var_.oldValueTypewriter, var_178_2, (arg_175_1.time_ - 0) / var_178_5)
				arg_175_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_175_1.fswtw_:SetDirty()
			end

			if arg_175_1.time_ >= 0 + var_178_5 and arg_175_1.time_ < 0 + var_178_5 + arg_178_0 then
				arg_175_1.fswtw_.percent = var_178_2

				arg_175_1.fswtw_:SetDirty()
				arg_175_1:ShowNextGo(true)

				arg_175_1.typewritterCharCountI18N = var_178_3
			end

			local var_178_6 = 0
			local var_178_7 = manager.audio:GetVoiceLength("story_v_out_116331", "116331040", "story_v_out_116331.awb") / 1000

			if var_178_7 > 0 and 14.153 < var_178_7 and var_178_7 + var_178_6 > arg_175_1.duration_ then
				arg_175_1.duration_ = var_178_7 + var_178_6
			end

			if var_178_6 < arg_175_1.time_ and arg_175_1.time_ <= var_178_6 + arg_178_0 then
				arg_175_1:AudioAction("play", "voice", "story_v_out_116331", "116331040", "story_v_out_116331.awb")
			end

			local var_178_9 = 0

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= var_178_9 + arg_178_0 then
				arg_175_1.allBtn_.enabled = false
			end

			if arg_175_1.time_ >= var_178_9 + 4 and arg_175_1.time_ < var_178_9 + 4 + arg_178_0 then
				arg_175_1.allBtn_.enabled = true
			end
		end

		arg_175_1.nodeConfigList_ = {}

		arg_175_1:InitPlayNodeList()
	end,
	Play116331041 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 116331041
		arg_179_1.duration_ = 6.59

		SetActive(arg_179_1.tipsGo_, false)

		function arg_179_1.onSingleLineFinish_()
			arg_179_1.onSingleLineUpdate_ = nil
			arg_179_1.onSingleLineFinish_ = nil
			arg_179_1.state_ = "waiting"
		end

		function arg_179_1.playNext_(arg_181_0)
			if arg_181_0 == 1 then
				arg_179_0:Play116331042(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 then
				arg_179_1.var_.oldValueTypewriter = arg_179_1.fswtw_.percent

				SetActive(arg_179_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_179_1:ShowNextGo(false)
			end

			local var_182_0 = 31
			local var_182_1 = 2.06666666666667
			local var_182_2, var_182_3 = arg_179_1:GetPercentByPara(arg_179_1:FormatText(arg_179_1:GetWordFromCfg(116331035).content), 7)

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0

				local var_182_4 = var_182_0 <= 0 and var_182_1 or var_182_1 * ((var_182_3 - arg_179_1.typewritterCharCountI18N) / var_182_0)

				if (var_182_0 <= 0 and var_182_1 or var_182_1 * ((var_182_3 - arg_179_1.typewritterCharCountI18N) / var_182_0)) > 0 and var_182_1 < var_182_4 then
					arg_179_1.talkMaxDuration = var_182_4

					if var_182_4 + 0 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_4 + 0
					end
				end
			end

			local var_182_5 = math.max(2.06666666666667, arg_179_1.talkMaxDuration)

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_5 then
				arg_179_1.fswtw_.percent = Mathf.Lerp(arg_179_1.var_.oldValueTypewriter, var_182_2, (arg_179_1.time_ - 0) / var_182_5)
				arg_179_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_179_1.fswtw_:SetDirty()
			end

			if arg_179_1.time_ >= 0 + var_182_5 and arg_179_1.time_ < 0 + var_182_5 + arg_182_0 then
				arg_179_1.fswtw_.percent = var_182_2

				arg_179_1.fswtw_:SetDirty()
				arg_179_1:ShowNextGo(true)

				arg_179_1.typewritterCharCountI18N = var_182_3
			end

			local var_182_6 = 0
			local var_182_7 = manager.audio:GetVoiceLength("story_v_out_116331", "116331041", "story_v_out_116331.awb") / 1000

			if var_182_7 > 0 and 6.594 < var_182_7 and var_182_7 + var_182_6 > arg_179_1.duration_ then
				arg_179_1.duration_ = var_182_7 + var_182_6
			end

			if var_182_6 < arg_179_1.time_ and arg_179_1.time_ <= var_182_6 + arg_182_0 then
				arg_179_1:AudioAction("play", "voice", "story_v_out_116331", "116331041", "story_v_out_116331.awb")
			end

			local var_182_9 = 0

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= var_182_9 + arg_182_0 then
				arg_179_1.allBtn_.enabled = false
			end

			if arg_179_1.time_ >= var_182_9 + 2.06666666666667 and arg_179_1.time_ < var_182_9 + 2.06666666666667 + arg_182_0 then
				arg_179_1.allBtn_.enabled = true
			end
		end

		arg_179_1.nodeConfigList_ = {}

		arg_179_1:InitPlayNodeList()
	end,
	Play116331042 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 116331042
		arg_183_1.duration_ = 2.97

		SetActive(arg_183_1.tipsGo_, false)

		function arg_183_1.onSingleLineFinish_()
			arg_183_1.onSingleLineUpdate_ = nil
			arg_183_1.onSingleLineFinish_ = nil
			arg_183_1.state_ = "waiting"
		end

		function arg_183_1.playNext_(arg_185_0)
			if arg_185_0 == 1 then
				arg_183_0:Play116331043(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				arg_183_1.fswbg_:SetActive(true)
				arg_183_1.dialog_:SetActive(false)

				arg_183_1.fswtw_.percent = 0
				arg_183_1.fswt_.text = arg_183_1:FormatText(arg_183_1:GetWordFromCfg(116331042).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.fswt_)

				arg_183_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_183_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_183_1.fswtw_:SetDirty()

				arg_183_1.typewritterCharCountI18N = 0

				SetActive(arg_183_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_183_1:ShowNextGo(false)
			end

			local var_186_0 = 0.0166666666666667

			if 0.0166666666666667 < arg_183_1.time_ and arg_183_1.time_ <= var_186_0 + arg_186_0 then
				arg_183_1.var_.oldValueTypewriter = arg_183_1.fswtw_.percent

				SetActive(arg_183_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_183_1:ShowNextGo(false)
			end

			local var_186_1 = 14
			local var_186_2 = 0.933333333333333
			local var_186_3, var_186_4 = arg_183_1:GetPercentByPara(arg_183_1:FormatText(arg_183_1:GetWordFromCfg(116331042).content), 1)

			if var_186_0 < arg_183_1.time_ and arg_183_1.time_ <= var_186_0 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0

				local var_186_5 = var_186_1 <= 0 and var_186_2 or var_186_2 * ((var_186_4 - arg_183_1.typewritterCharCountI18N) / var_186_1)

				if (var_186_1 <= 0 and var_186_2 or var_186_2 * ((var_186_4 - arg_183_1.typewritterCharCountI18N) / var_186_1)) > 0 and var_186_2 < var_186_5 then
					arg_183_1.talkMaxDuration = var_186_5

					if var_186_5 + var_186_0 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_5 + var_186_0
					end
				end
			end

			local var_186_6 = math.max(0.933333333333333, arg_183_1.talkMaxDuration)

			if var_186_0 <= arg_183_1.time_ and arg_183_1.time_ < var_186_0 + var_186_6 then
				arg_183_1.fswtw_.percent = Mathf.Lerp(arg_183_1.var_.oldValueTypewriter, var_186_3, (arg_183_1.time_ - var_186_0) / var_186_6)
				arg_183_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_183_1.fswtw_:SetDirty()
			end

			if arg_183_1.time_ >= var_186_0 + var_186_6 and arg_183_1.time_ < var_186_0 + var_186_6 + arg_186_0 then
				arg_183_1.fswtw_.percent = var_186_3

				arg_183_1.fswtw_:SetDirty()
				arg_183_1:ShowNextGo(true)

				arg_183_1.typewritterCharCountI18N = var_186_4
			end

			local var_186_7 = 0
			local var_186_8 = manager.audio:GetVoiceLength("story_v_out_116331", "116331042", "story_v_out_116331.awb") / 1000

			if var_186_8 > 0 and 2.969 < var_186_8 and var_186_8 + var_186_7 > arg_183_1.duration_ then
				arg_183_1.duration_ = var_186_8 + var_186_7
			end

			if var_186_7 < arg_183_1.time_ and arg_183_1.time_ <= var_186_7 + arg_186_0 then
				arg_183_1:AudioAction("play", "voice", "story_v_out_116331", "116331042", "story_v_out_116331.awb")
			end

			local var_186_10 = 0

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= var_186_10 + arg_186_0 then
				arg_183_1.allBtn_.enabled = false
			end

			if arg_183_1.time_ >= var_186_10 + 0.95 and arg_183_1.time_ < var_186_10 + 0.95 + arg_186_0 then
				arg_183_1.allBtn_.enabled = true
			end
		end

		arg_183_1.nodeConfigList_ = {}

		arg_183_1:InitPlayNodeList()
	end,
	Play116331043 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 116331043
		arg_187_1.duration_ = 2.53

		SetActive(arg_187_1.tipsGo_, false)

		function arg_187_1.onSingleLineFinish_()
			arg_187_1.onSingleLineUpdate_ = nil
			arg_187_1.onSingleLineFinish_ = nil
			arg_187_1.state_ = "waiting"
		end

		function arg_187_1.playNext_(arg_189_0)
			if arg_189_0 == 1 then
				arg_187_0:Play116331044(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 then
				arg_187_1.var_.oldValueTypewriter = arg_187_1.fswtw_.percent

				SetActive(arg_187_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_187_1:ShowNextGo(false)
			end

			local var_190_0 = 19
			local var_190_1 = 1.26666666666667
			local var_190_2, var_190_3 = arg_187_1:GetPercentByPara(arg_187_1:FormatText(arg_187_1:GetWordFromCfg(116331042).content), 2)

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0

				local var_190_4 = var_190_0 <= 0 and var_190_1 or var_190_1 * ((var_190_3 - arg_187_1.typewritterCharCountI18N) / var_190_0)

				if (var_190_0 <= 0 and var_190_1 or var_190_1 * ((var_190_3 - arg_187_1.typewritterCharCountI18N) / var_190_0)) > 0 and var_190_1 < var_190_4 then
					arg_187_1.talkMaxDuration = var_190_4

					if var_190_4 + 0 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_4 + 0
					end
				end
			end

			local var_190_5 = math.max(1.26666666666667, arg_187_1.talkMaxDuration)

			if 0 <= arg_187_1.time_ and arg_187_1.time_ < 0 + var_190_5 then
				arg_187_1.fswtw_.percent = Mathf.Lerp(arg_187_1.var_.oldValueTypewriter, var_190_2, (arg_187_1.time_ - 0) / var_190_5)
				arg_187_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_187_1.fswtw_:SetDirty()
			end

			if arg_187_1.time_ >= 0 + var_190_5 and arg_187_1.time_ < 0 + var_190_5 + arg_190_0 then
				arg_187_1.fswtw_.percent = var_190_2

				arg_187_1.fswtw_:SetDirty()
				arg_187_1:ShowNextGo(true)

				arg_187_1.typewritterCharCountI18N = var_190_3
			end

			local var_190_6 = 0
			local var_190_7 = manager.audio:GetVoiceLength("story_v_out_116331", "116331043", "story_v_out_116331.awb") / 1000

			if var_190_7 > 0 and 2.534 < var_190_7 and var_190_7 + var_190_6 > arg_187_1.duration_ then
				arg_187_1.duration_ = var_190_7 + var_190_6
			end

			if var_190_6 < arg_187_1.time_ and arg_187_1.time_ <= var_190_6 + arg_190_0 then
				arg_187_1:AudioAction("play", "voice", "story_v_out_116331", "116331043", "story_v_out_116331.awb")
			end

			local var_190_9 = 0

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= var_190_9 + arg_190_0 then
				arg_187_1.allBtn_.enabled = false
			end

			if arg_187_1.time_ >= var_190_9 + 1.26666666666667 and arg_187_1.time_ < var_190_9 + 1.26666666666667 + arg_190_0 then
				arg_187_1.allBtn_.enabled = true
			end
		end

		arg_187_1.nodeConfigList_ = {}

		arg_187_1:InitPlayNodeList()
	end,
	Play116331044 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 116331044
		arg_191_1.duration_ = 2

		SetActive(arg_191_1.tipsGo_, false)

		function arg_191_1.onSingleLineFinish_()
			arg_191_1.onSingleLineUpdate_ = nil
			arg_191_1.onSingleLineFinish_ = nil
			arg_191_1.state_ = "waiting"
		end

		function arg_191_1.playNext_(arg_193_0)
			if arg_193_0 == 1 then
				arg_191_0:Play116331045(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 then
				arg_191_1.var_.oldValueTypewriter = arg_191_1.fswtw_.percent

				SetActive(arg_191_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_191_1:ShowNextGo(false)
			end

			local var_194_0 = 17
			local var_194_1 = 1.13333333333333
			local var_194_2, var_194_3 = arg_191_1:GetPercentByPara(arg_191_1:FormatText(arg_191_1:GetWordFromCfg(116331042).content), 3)

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0

				local var_194_4 = var_194_0 <= 0 and var_194_1 or var_194_1 * ((var_194_3 - arg_191_1.typewritterCharCountI18N) / var_194_0)

				if (var_194_0 <= 0 and var_194_1 or var_194_1 * ((var_194_3 - arg_191_1.typewritterCharCountI18N) / var_194_0)) > 0 and var_194_1 < var_194_4 then
					arg_191_1.talkMaxDuration = var_194_4

					if var_194_4 + 0 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_4 + 0
					end
				end
			end

			local var_194_5 = math.max(1.13333333333333, arg_191_1.talkMaxDuration)

			if 0 <= arg_191_1.time_ and arg_191_1.time_ < 0 + var_194_5 then
				arg_191_1.fswtw_.percent = Mathf.Lerp(arg_191_1.var_.oldValueTypewriter, var_194_2, (arg_191_1.time_ - 0) / var_194_5)
				arg_191_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_191_1.fswtw_:SetDirty()
			end

			if arg_191_1.time_ >= 0 + var_194_5 and arg_191_1.time_ < 0 + var_194_5 + arg_194_0 then
				arg_191_1.fswtw_.percent = var_194_2

				arg_191_1.fswtw_:SetDirty()
				arg_191_1:ShowNextGo(true)

				arg_191_1.typewritterCharCountI18N = var_194_3
			end

			local var_194_6 = 0
			local var_194_7 = manager.audio:GetVoiceLength("story_v_out_116331", "116331044", "story_v_out_116331.awb") / 1000

			if var_194_7 > 0 and 2.003 < var_194_7 and var_194_7 + var_194_6 > arg_191_1.duration_ then
				arg_191_1.duration_ = var_194_7 + var_194_6
			end

			if var_194_6 < arg_191_1.time_ and arg_191_1.time_ <= var_194_6 + arg_194_0 then
				arg_191_1:AudioAction("play", "voice", "story_v_out_116331", "116331044", "story_v_out_116331.awb")
			end

			local var_194_9 = 0

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= var_194_9 + arg_194_0 then
				arg_191_1.allBtn_.enabled = false
			end

			if arg_191_1.time_ >= var_194_9 + 1.13333333333333 and arg_191_1.time_ < var_194_9 + 1.13333333333333 + arg_194_0 then
				arg_191_1.allBtn_.enabled = true
			end
		end

		arg_191_1.nodeConfigList_ = {}

		arg_191_1:InitPlayNodeList()
	end,
	Play116331045 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 116331045
		arg_195_1.duration_ = 6.9

		SetActive(arg_195_1.tipsGo_, false)

		function arg_195_1.onSingleLineFinish_()
			arg_195_1.onSingleLineUpdate_ = nil
			arg_195_1.onSingleLineFinish_ = nil
			arg_195_1.state_ = "waiting"
		end

		function arg_195_1.playNext_(arg_197_0)
			if arg_197_0 == 1 then
				arg_195_0:Play116331046(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 then
				arg_195_1.var_.oldValueTypewriter = arg_195_1.fswtw_.percent

				SetActive(arg_195_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_195_1:ShowNextGo(false)
			end

			local var_198_0 = 33
			local var_198_1 = 2.2
			local var_198_2, var_198_3 = arg_195_1:GetPercentByPara(arg_195_1:FormatText(arg_195_1:GetWordFromCfg(116331042).content), 4)

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0

				local var_198_4 = var_198_0 <= 0 and var_198_1 or var_198_1 * ((var_198_3 - arg_195_1.typewritterCharCountI18N) / var_198_0)

				if (var_198_0 <= 0 and var_198_1 or var_198_1 * ((var_198_3 - arg_195_1.typewritterCharCountI18N) / var_198_0)) > 0 and var_198_1 < var_198_4 then
					arg_195_1.talkMaxDuration = var_198_4

					if var_198_4 + 0 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_4 + 0
					end
				end
			end

			local var_198_5 = math.max(2.2, arg_195_1.talkMaxDuration)

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_5 then
				arg_195_1.fswtw_.percent = Mathf.Lerp(arg_195_1.var_.oldValueTypewriter, var_198_2, (arg_195_1.time_ - 0) / var_198_5)
				arg_195_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_195_1.fswtw_:SetDirty()
			end

			if arg_195_1.time_ >= 0 + var_198_5 and arg_195_1.time_ < 0 + var_198_5 + arg_198_0 then
				arg_195_1.fswtw_.percent = var_198_2

				arg_195_1.fswtw_:SetDirty()
				arg_195_1:ShowNextGo(true)

				arg_195_1.typewritterCharCountI18N = var_198_3
			end

			local var_198_6 = 0
			local var_198_7 = manager.audio:GetVoiceLength("story_v_out_116331", "116331045", "story_v_out_116331.awb") / 1000

			if var_198_7 > 0 and 6.898 < var_198_7 and var_198_7 + var_198_6 > arg_195_1.duration_ then
				arg_195_1.duration_ = var_198_7 + var_198_6
			end

			if var_198_6 < arg_195_1.time_ and arg_195_1.time_ <= var_198_6 + arg_198_0 then
				arg_195_1:AudioAction("play", "voice", "story_v_out_116331", "116331045", "story_v_out_116331.awb")
			end

			local var_198_9 = 0

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= var_198_9 + arg_198_0 then
				arg_195_1.allBtn_.enabled = false
			end

			if arg_195_1.time_ >= var_198_9 + 2.2 and arg_195_1.time_ < var_198_9 + 2.2 + arg_198_0 then
				arg_195_1.allBtn_.enabled = true
			end
		end

		arg_195_1.nodeConfigList_ = {}

		arg_195_1:InitPlayNodeList()
	end,
	Play116331046 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 116331046
		arg_199_1.duration_ = 4.76

		SetActive(arg_199_1.tipsGo_, false)

		function arg_199_1.onSingleLineFinish_()
			arg_199_1.onSingleLineUpdate_ = nil
			arg_199_1.onSingleLineFinish_ = nil
			arg_199_1.state_ = "waiting"
		end

		function arg_199_1.playNext_(arg_201_0)
			if arg_201_0 == 1 then
				arg_199_0:Play116331047(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 then
				arg_199_1.var_.oldValueTypewriter = arg_199_1.fswtw_.percent

				SetActive(arg_199_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_199_1:ShowNextGo(false)
			end

			local var_202_0 = 30
			local var_202_1 = 2
			local var_202_2, var_202_3 = arg_199_1:GetPercentByPara(arg_199_1:FormatText(arg_199_1:GetWordFromCfg(116331042).content), 5)

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0

				local var_202_4 = var_202_0 <= 0 and var_202_1 or var_202_1 * ((var_202_3 - arg_199_1.typewritterCharCountI18N) / var_202_0)

				if (var_202_0 <= 0 and var_202_1 or var_202_1 * ((var_202_3 - arg_199_1.typewritterCharCountI18N) / var_202_0)) > 0 and var_202_1 < var_202_4 then
					arg_199_1.talkMaxDuration = var_202_4

					if var_202_4 + 0 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_4 + 0
					end
				end
			end

			local var_202_5 = math.max(2, arg_199_1.talkMaxDuration)

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_5 then
				arg_199_1.fswtw_.percent = Mathf.Lerp(arg_199_1.var_.oldValueTypewriter, var_202_2, (arg_199_1.time_ - 0) / var_202_5)
				arg_199_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_199_1.fswtw_:SetDirty()
			end

			if arg_199_1.time_ >= 0 + var_202_5 and arg_199_1.time_ < 0 + var_202_5 + arg_202_0 then
				arg_199_1.fswtw_.percent = var_202_2

				arg_199_1.fswtw_:SetDirty()
				arg_199_1:ShowNextGo(true)

				arg_199_1.typewritterCharCountI18N = var_202_3
			end

			local var_202_6 = 0
			local var_202_7 = manager.audio:GetVoiceLength("story_v_out_116331", "116331046", "story_v_out_116331.awb") / 1000

			if var_202_7 > 0 and 4.763 < var_202_7 and var_202_7 + var_202_6 > arg_199_1.duration_ then
				arg_199_1.duration_ = var_202_7 + var_202_6
			end

			if var_202_6 < arg_199_1.time_ and arg_199_1.time_ <= var_202_6 + arg_202_0 then
				arg_199_1:AudioAction("play", "voice", "story_v_out_116331", "116331046", "story_v_out_116331.awb")
			end

			local var_202_9 = 0

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= var_202_9 + arg_202_0 then
				arg_199_1.allBtn_.enabled = false
			end

			if arg_199_1.time_ >= var_202_9 + 2 and arg_199_1.time_ < var_202_9 + 2 + arg_202_0 then
				arg_199_1.allBtn_.enabled = true
			end
		end

		arg_199_1.nodeConfigList_ = {}

		arg_199_1:InitPlayNodeList()
	end,
	Play116331047 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 116331047
		arg_203_1.duration_ = 3.6

		SetActive(arg_203_1.tipsGo_, false)

		function arg_203_1.onSingleLineFinish_()
			arg_203_1.onSingleLineUpdate_ = nil
			arg_203_1.onSingleLineFinish_ = nil
			arg_203_1.state_ = "waiting"
		end

		function arg_203_1.playNext_(arg_205_0)
			if arg_205_0 == 1 then
				arg_203_0:Play116331048(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				arg_203_1.var_.oldValueTypewriter = arg_203_1.fswtw_.percent

				SetActive(arg_203_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_203_1:ShowNextGo(false)
			end

			local var_206_0 = 12
			local var_206_1 = 0.8
			local var_206_2, var_206_3 = arg_203_1:GetPercentByPara(arg_203_1:FormatText(arg_203_1:GetWordFromCfg(116331042).content), 6)

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0

				local var_206_4 = var_206_0 <= 0 and var_206_1 or var_206_1 * ((var_206_3 - arg_203_1.typewritterCharCountI18N) / var_206_0)

				if (var_206_0 <= 0 and var_206_1 or var_206_1 * ((var_206_3 - arg_203_1.typewritterCharCountI18N) / var_206_0)) > 0 and var_206_1 < var_206_4 then
					arg_203_1.talkMaxDuration = var_206_4

					if var_206_4 + 0 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_4 + 0
					end
				end
			end

			local var_206_5 = math.max(0.8, arg_203_1.talkMaxDuration)

			if 0 <= arg_203_1.time_ and arg_203_1.time_ < 0 + var_206_5 then
				arg_203_1.fswtw_.percent = Mathf.Lerp(arg_203_1.var_.oldValueTypewriter, var_206_2, (arg_203_1.time_ - 0) / var_206_5)
				arg_203_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_203_1.fswtw_:SetDirty()
			end

			if arg_203_1.time_ >= 0 + var_206_5 and arg_203_1.time_ < 0 + var_206_5 + arg_206_0 then
				arg_203_1.fswtw_.percent = var_206_2

				arg_203_1.fswtw_:SetDirty()
				arg_203_1:ShowNextGo(true)

				arg_203_1.typewritterCharCountI18N = var_206_3
			end

			local var_206_6 = 0
			local var_206_7 = manager.audio:GetVoiceLength("story_v_out_116331", "116331047", "story_v_out_116331.awb") / 1000

			if var_206_7 > 0 and 3.599 < var_206_7 and var_206_7 + var_206_6 > arg_203_1.duration_ then
				arg_203_1.duration_ = var_206_7 + var_206_6
			end

			if var_206_6 < arg_203_1.time_ and arg_203_1.time_ <= var_206_6 + arg_206_0 then
				arg_203_1:AudioAction("play", "voice", "story_v_out_116331", "116331047", "story_v_out_116331.awb")
			end

			local var_206_9 = 0

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= var_206_9 + arg_206_0 then
				arg_203_1.allBtn_.enabled = false
			end

			if arg_203_1.time_ >= var_206_9 + 0.8 and arg_203_1.time_ < var_206_9 + 0.8 + arg_206_0 then
				arg_203_1.allBtn_.enabled = true
			end
		end

		arg_203_1.nodeConfigList_ = {}

		arg_203_1:InitPlayNodeList()
	end,
	Play116331048 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 116331048
		arg_207_1.duration_ = 9.92

		local var_207_0 = {
			zh = 9.383,
			ja = 9.916
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
				arg_207_0:Play116331049(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			if arg_207_1.bgs_.STblack == nil then
				local var_210_0 = Object.Instantiate(arg_207_1.paintGo_)

				var_210_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "STblack")
				var_210_0.name = "STblack"
				var_210_0.transform.parent = arg_207_1.stage_.transform
				var_210_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_207_1.bgs_.STblack = var_210_0
			end

			if 2 < arg_207_1.time_ and arg_207_1.time_ <= 2 + arg_210_0 then
				local var_210_1 = arg_207_1.bgs_.STblack

				arg_207_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_210_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_210_2 = var_210_1:GetComponent("SpriteRenderer")

				if var_210_2 and var_210_2.sprite then
					local var_210_3 = 2 * (var_210_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_210_1.transform.localScale = Vector3.New(var_210_3 / var_210_2.sprite.bounds.size.y < var_210_3 * manager.ui.mainCameraCom_.aspect / var_210_2.sprite.bounds.size.x and var_210_3 * manager.ui.mainCameraCom_.aspect / var_210_2.sprite.bounds.size.x or var_210_3 / var_210_2.sprite.bounds.size.y, var_210_3 / var_210_2.sprite.bounds.size.y < var_210_3 * manager.ui.mainCameraCom_.aspect / var_210_2.sprite.bounds.size.x and var_210_3 * manager.ui.mainCameraCom_.aspect / var_210_2.sprite.bounds.size.x or var_210_3 / var_210_2.sprite.bounds.size.y, 0)
				end

				for iter_210_0, iter_210_1 in pairs(arg_207_1.bgs_) do
					if iter_210_0 ~= "STblack" then
						iter_210_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 2 < arg_207_1.time_ and arg_207_1.time_ <= 2 + arg_210_0 then
				arg_207_1.fswbg_:SetActive(false)
				arg_207_1.dialog_:SetActive(false)
				SetActive(arg_207_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_207_1:ShowNextGo(false)
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

			local var_210_12 = 3.55
			local var_210_13 = 0.45

			if 3.55 < arg_207_1.time_ and arg_207_1.time_ <= var_210_12 + arg_210_0 then
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

				SetActive(arg_207_1.leftNameGo_, true)

				arg_207_1.leftNameTxt_.text = arg_207_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_207_1.leftNameTxt_.transform)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1.leftNameTxt_.text)
				SetActive(arg_207_1.iconTrs_.gameObject, true)
				arg_207_1.iconController_:SetSelectedState("hero")

				arg_207_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10032")

				arg_207_1.callingController_:SetSelectedState("normal")

				arg_207_1.keyicon_.color = Color.New(1, 1, 1)
				arg_207_1.icon_.color = Color.New(1, 1, 1)

				local var_210_15 = arg_207_1:GetWordFromCfg(116331048)
				local var_210_16 = arg_207_1:FormatText(var_210_15.content)

				arg_207_1.text_.text = var_210_16

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_18 = 18 <= 0 and var_210_13 or var_210_13 * (utf8.len(var_210_16) / 18)

				if (18 <= 0 and var_210_13 or var_210_13 * (utf8.len(var_210_16) / 18)) > 0 and var_210_13 < var_210_18 then
					arg_207_1.talkMaxDuration = var_210_18
					var_210_12 = var_210_12 + 0.3

					if var_210_18 + var_210_12 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_18 + var_210_12
					end
				end

				arg_207_1.text_.text = var_210_16
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116331", "116331048", "story_v_out_116331.awb") ~= 0 then
					local var_210_19 = manager.audio:GetVoiceLength("story_v_out_116331", "116331048", "story_v_out_116331.awb") / 1000

					if var_210_19 + var_210_12 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_19 + var_210_12
					end

					if var_210_15.prefab_name ~= "" and arg_207_1.actors_[var_210_15.prefab_name] ~= nil then
						local var_210_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_207_1.actors_[var_210_15.prefab_name].transform, "story_v_out_116331", "116331048", "story_v_out_116331.awb")

						arg_207_1:RecordAudio("116331048", var_210_20)
						arg_207_1:RecordAudio("116331048", var_210_20)
					else
						arg_207_1:AudioAction("play", "voice", "story_v_out_116331", "116331048", "story_v_out_116331.awb")
					end

					arg_207_1:RecordHistoryTalkVoice("story_v_out_116331", "116331048", "story_v_out_116331.awb")
				end

				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_21 = var_210_12 + 0.3
			local var_210_22 = math.max(var_210_13, arg_207_1.talkMaxDuration)

			if var_210_12 + 0.3 <= arg_207_1.time_ and arg_207_1.time_ < var_210_21 + var_210_22 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - var_210_21) / var_210_22

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= var_210_21 + var_210_22 and arg_207_1.time_ < var_210_21 + var_210_22 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {}

		arg_207_1:InitPlayNodeList()
	end,
	Play116331049 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 116331049
		arg_213_1.duration_ = 10.2

		local var_213_0 = {
			zh = 10.2,
			ja = 7.866
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
				arg_213_0:Play116331050(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			local var_216_0 = 0.575

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, true)

				arg_213_1.leftNameTxt_.text = arg_213_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_213_1.leftNameTxt_.transform)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1.leftNameTxt_.text)
				SetActive(arg_213_1.iconTrs_.gameObject, true)
				arg_213_1.iconController_:SetSelectedState("hero")

				arg_213_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10032")

				arg_213_1.callingController_:SetSelectedState("normal")

				arg_213_1.keyicon_.color = Color.New(1, 1, 1)
				arg_213_1.icon_.color = Color.New(1, 1, 1)

				local var_216_1 = arg_213_1:GetWordFromCfg(116331049)
				local var_216_2 = arg_213_1:FormatText(var_216_1.content)

				arg_213_1.text_.text = var_216_2

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_4 = 23 <= 0 and var_216_0 or var_216_0 * (utf8.len(var_216_2) / 23)

				if (23 <= 0 and var_216_0 or var_216_0 * (utf8.len(var_216_2) / 23)) > 0 and var_216_0 < var_216_4 then
					arg_213_1.talkMaxDuration = var_216_4

					if var_216_4 + 0 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_4 + 0
					end
				end

				arg_213_1.text_.text = var_216_2
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116331", "116331049", "story_v_out_116331.awb") ~= 0 then
					local var_216_5 = manager.audio:GetVoiceLength("story_v_out_116331", "116331049", "story_v_out_116331.awb") / 1000

					if var_216_5 + 0 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_5 + 0
					end

					if var_216_1.prefab_name ~= "" and arg_213_1.actors_[var_216_1.prefab_name] ~= nil then
						local var_216_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_213_1.actors_[var_216_1.prefab_name].transform, "story_v_out_116331", "116331049", "story_v_out_116331.awb")

						arg_213_1:RecordAudio("116331049", var_216_6)
						arg_213_1:RecordAudio("116331049", var_216_6)
					else
						arg_213_1:AudioAction("play", "voice", "story_v_out_116331", "116331049", "story_v_out_116331.awb")
					end

					arg_213_1:RecordHistoryTalkVoice("story_v_out_116331", "116331049", "story_v_out_116331.awb")
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
	Play116331050 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 116331050
		arg_217_1.duration_ = 10

		SetActive(arg_217_1.tipsGo_, false)

		function arg_217_1.onSingleLineFinish_()
			arg_217_1.onSingleLineUpdate_ = nil
			arg_217_1.onSingleLineFinish_ = nil
			arg_217_1.state_ = "waiting"
		end

		function arg_217_1.playNext_(arg_219_0)
			if arg_219_0 == 1 then
				arg_217_0:Play116331051(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			if arg_217_1.bgs_.ST03a == nil then
				local var_220_0 = Object.Instantiate(arg_217_1.paintGo_)

				var_220_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST03a")
				var_220_0.name = "ST03a"
				var_220_0.transform.parent = arg_217_1.stage_.transform
				var_220_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_217_1.bgs_.ST03a = var_220_0
			end

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 then
				local var_220_1 = arg_217_1.bgs_.ST03a

				arg_217_1.bgs_.ST03a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_220_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_220_2 = var_220_1:GetComponent("SpriteRenderer")

				if var_220_2 and var_220_2.sprite then
					local var_220_3 = 2 * (var_220_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_220_1.transform.localScale = Vector3.New(var_220_3 / var_220_2.sprite.bounds.size.y < var_220_3 * manager.ui.mainCameraCom_.aspect / var_220_2.sprite.bounds.size.x and var_220_3 * manager.ui.mainCameraCom_.aspect / var_220_2.sprite.bounds.size.x or var_220_3 / var_220_2.sprite.bounds.size.y, var_220_3 / var_220_2.sprite.bounds.size.y < var_220_3 * manager.ui.mainCameraCom_.aspect / var_220_2.sprite.bounds.size.x and var_220_3 * manager.ui.mainCameraCom_.aspect / var_220_2.sprite.bounds.size.x or var_220_3 / var_220_2.sprite.bounds.size.y, 0)
				end

				for iter_220_0, iter_220_1 in pairs(arg_217_1.bgs_) do
					if iter_220_0 ~= "ST03a" then
						iter_220_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_220_4 = 0

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= var_220_4 + arg_220_0 then
				arg_217_1.mask_.enabled = true
				arg_217_1.mask_.raycastTarget = true

				arg_217_1:SetGaussion(false)
			end

			local var_220_5 = 5

			if var_220_4 <= arg_217_1.time_ and arg_217_1.time_ < var_220_4 + var_220_5 then
				local var_220_6 = Color.New(0, 0, 0)

				var_220_6.a = Mathf.Lerp(1, 0, (arg_217_1.time_ - var_220_4) / var_220_5)
				arg_217_1.mask_.color = var_220_6
			end

			if arg_217_1.time_ >= var_220_4 + var_220_5 and arg_217_1.time_ < var_220_4 + var_220_5 + arg_220_0 then
				local var_220_7 = Color.New(0, 0, 0)

				arg_217_1.mask_.enabled = false
				var_220_7.a = 0
				arg_217_1.mask_.color = var_220_7
			end

			local var_220_8 = arg_217_1.bgs_.ST03a.transform

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 then
				arg_217_1.var_.moveOldPosST03a = var_220_8.localPosition
			end

			local var_220_9 = 0.001

			if 0 <= arg_217_1.time_ and arg_217_1.time_ < 0 + var_220_9 then
				var_220_8.localPosition = Vector3.Lerp(arg_217_1.var_.moveOldPosST03a, Vector3.New(0, 1, 9), (arg_217_1.time_ - 0) / var_220_9)
			end

			if arg_217_1.time_ >= 0 + var_220_9 and arg_217_1.time_ < 0 + var_220_9 + arg_220_0 then
				var_220_8.localPosition = Vector3.New(0, 1, 9)
			end

			local var_220_10 = arg_217_1.bgs_.ST03a.transform

			if 0.016666666666667 < arg_217_1.time_ and arg_217_1.time_ <= 0.016666666666667 + arg_220_0 then
				arg_217_1.var_.moveOldPosST03a = var_220_10.localPosition
			end

			local var_220_11 = 6

			if 0.016666666666667 <= arg_217_1.time_ and arg_217_1.time_ < 0.016666666666667 + var_220_11 then
				var_220_10.localPosition = Vector3.Lerp(arg_217_1.var_.moveOldPosST03a, Vector3.New(0, 1, 10), (arg_217_1.time_ - 0.016666666666667) / var_220_11)
			end

			if arg_217_1.time_ >= 0.016666666666667 + var_220_11 and arg_217_1.time_ < 0.016666666666667 + var_220_11 + arg_220_0 then
				var_220_10.localPosition = Vector3.New(0, 1, 10)
			end

			local var_220_12 = 5

			if 5 < arg_217_1.time_ and arg_217_1.time_ <= var_220_12 + arg_220_0 then
				arg_217_1.allBtn_.enabled = false
			end

			if arg_217_1.time_ >= var_220_12 + 1.01666666666667 and arg_217_1.time_ < var_220_12 + 1.01666666666667 + arg_220_0 then
				arg_217_1.allBtn_.enabled = true
			end

			if arg_217_1.frameCnt_ <= 1 then
				arg_217_1.dialog_:SetActive(false)
			end

			local var_220_13 = 5
			local var_220_14 = 0.95

			if 5 < arg_217_1.time_ and arg_217_1.time_ <= var_220_13 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0

				arg_217_1.dialog_:SetActive(true)

				arg_217_1.dialogCg_.alpha = 0

				local var_220_15 = LeanTween.value(arg_217_1.dialog_, 0, 1, 0.3)

				var_220_15:setOnUpdate(LuaHelper.FloatAction(function(arg_221_0)
					arg_217_1.dialogCg_.alpha = arg_221_0
				end))
				var_220_15:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_217_1.dialog_)
					var_220_15:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_217_1.duration_ = arg_217_1.duration_ + 0.3

				SetActive(arg_217_1.leftNameGo_, false)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_217_1.iconTrs_.gameObject, false)
				arg_217_1.callingController_:SetSelectedState("normal")

				local var_220_16 = arg_217_1:FormatText(arg_217_1:GetWordFromCfg(116331050).content)

				arg_217_1.text_.text = var_220_16

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_18 = 38 <= 0 and var_220_14 or var_220_14 * (utf8.len(var_220_16) / 38)

				if (38 <= 0 and var_220_14 or var_220_14 * (utf8.len(var_220_16) / 38)) > 0 and var_220_14 < var_220_18 then
					arg_217_1.talkMaxDuration = var_220_18
					var_220_13 = var_220_13 + 0.3

					if var_220_18 + var_220_13 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_18 + var_220_13
					end
				end

				arg_217_1.text_.text = var_220_16
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)
				arg_217_1:RecordContent(arg_217_1.text_.text)
			end

			local var_220_19 = var_220_13 + 0.3
			local var_220_20 = math.max(var_220_14, arg_217_1.talkMaxDuration)

			if var_220_13 + 0.3 <= arg_217_1.time_ and arg_217_1.time_ < var_220_19 + var_220_20 then
				arg_217_1.typewritter.percent = (arg_217_1.time_ - var_220_19) / var_220_20

				arg_217_1.typewritter:SetDirty()
			end

			if arg_217_1.time_ >= var_220_19 + var_220_20 and arg_217_1.time_ < var_220_19 + var_220_20 + arg_220_0 then
				arg_217_1.typewritter.percent = 1

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(true)
			end
		end

		arg_217_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "ST03a",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "ST03a",
				changeDisplayLayer = false,
				needEase = false,
				duration = 6,
				className = "StoryMoveNode",
				startTime = 0.016666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_217_1:InitPlayNodeList()
	end,
	Play116331051 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 116331051
		arg_223_1.duration_ = 6.97

		local var_223_0 = {
			zh = 4.266,
			ja = 6.966
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
			arg_223_1.auto_ = false
		end

		function arg_223_1.playNext_(arg_225_0)
			arg_223_1.onStoryFinished_()
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 then
				arg_223_1.var_.moveOldPos10032ui_story = arg_223_1.actors_["10032ui_story"].transform.localPosition
			end

			local var_226_0 = 0.001

			if 0 <= arg_223_1.time_ and arg_223_1.time_ < 0 + var_226_0 then
				arg_223_1.actors_["10032ui_story"].transform.localPosition = Vector3.Lerp(arg_223_1.var_.moveOldPos10032ui_story, Vector3.New(0, -1.1, -5.9), (arg_223_1.time_ - 0) / var_226_0)
				arg_223_1.actors_["10032ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_223_1.actors_["10032ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_223_1.actors_["10032ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_223_1.actors_["10032ui_story"].transform.position).z)
				arg_223_1.actors_["10032ui_story"].transform.localEulerAngles.z = 0
				arg_223_1.actors_["10032ui_story"].transform.localEulerAngles.x = 0
				arg_223_1.actors_["10032ui_story"].transform.localEulerAngles = arg_223_1.actors_["10032ui_story"].transform.localEulerAngles
			end

			if arg_223_1.time_ >= 0 + var_226_0 and arg_223_1.time_ < 0 + var_226_0 + arg_226_0 then
				arg_223_1.actors_["10032ui_story"].transform.localPosition = Vector3.New(0, -1.1, -5.9)
				arg_223_1.actors_["10032ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_223_1.actors_["10032ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_223_1.actors_["10032ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_223_1.actors_["10032ui_story"].transform.position).z)
				arg_223_1.actors_["10032ui_story"].transform.localEulerAngles.z = 0
				arg_223_1.actors_["10032ui_story"].transform.localEulerAngles.x = 0
				arg_223_1.actors_["10032ui_story"].transform.localEulerAngles = arg_223_1.actors_["10032ui_story"].transform.localEulerAngles
			end

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 then
				arg_223_1:PlayTimeline("10032ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action8_1")
			end

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 then
				arg_223_1:PlayTimeline("10032ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_226_1 = arg_223_1.actors_["10032ui_story"]

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 and not isNil(var_226_1) and arg_223_1.var_.characterEffect10032ui_story == nil then
				arg_223_1.var_.characterEffect10032ui_story = var_226_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_226_2 = 0.2

			if 0 <= arg_223_1.time_ and arg_223_1.time_ < 0 + var_226_2 and not isNil(var_226_1) then
				if arg_223_1.var_.characterEffect10032ui_story and not isNil(var_226_1) then
					arg_223_1.var_.characterEffect10032ui_story.fillFlat = false
				end
			end

			if arg_223_1.time_ >= 0 + var_226_2 and arg_223_1.time_ < 0 + var_226_2 + arg_226_0 and not isNil(var_226_1) and arg_223_1.var_.characterEffect10032ui_story then
				arg_223_1.var_.characterEffect10032ui_story.fillFlat = false
			end

			local var_226_4 = 0
			local var_226_5 = 0.325

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= var_226_4 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0
				arg_223_1.dialogCg_.alpha = 1

				arg_223_1.dialog_:SetActive(true)
				SetActive(arg_223_1.leftNameGo_, true)

				arg_223_1.leftNameTxt_.text = arg_223_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_223_1.leftNameTxt_.transform)

				arg_223_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_223_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_223_1:RecordName(arg_223_1.leftNameTxt_.text)
				SetActive(arg_223_1.iconTrs_.gameObject, false)
				arg_223_1.callingController_:SetSelectedState("normal")

				local var_226_6 = arg_223_1:GetWordFromCfg(116331051)
				local var_226_7 = arg_223_1:FormatText(var_226_6.content)

				arg_223_1.text_.text = var_226_7

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_9 = 13 <= 0 and var_226_5 or var_226_5 * (utf8.len(var_226_7) / 13)

				if (13 <= 0 and var_226_5 or var_226_5 * (utf8.len(var_226_7) / 13)) > 0 and var_226_5 < var_226_9 then
					arg_223_1.talkMaxDuration = var_226_9

					if var_226_9 + var_226_4 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_9 + var_226_4
					end
				end

				arg_223_1.text_.text = var_226_7
				arg_223_1.typewritter.percent = 0

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116331", "116331051", "story_v_out_116331.awb") ~= 0 then
					local var_226_10 = manager.audio:GetVoiceLength("story_v_out_116331", "116331051", "story_v_out_116331.awb") / 1000

					if var_226_10 + var_226_4 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_10 + var_226_4
					end

					if var_226_6.prefab_name ~= "" and arg_223_1.actors_[var_226_6.prefab_name] ~= nil then
						local var_226_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_223_1.actors_[var_226_6.prefab_name].transform, "story_v_out_116331", "116331051", "story_v_out_116331.awb")

						arg_223_1:RecordAudio("116331051", var_226_11)
						arg_223_1:RecordAudio("116331051", var_226_11)
					else
						arg_223_1:AudioAction("play", "voice", "story_v_out_116331", "116331051", "story_v_out_116331.awb")
					end

					arg_223_1:RecordHistoryTalkVoice("story_v_out_116331", "116331051", "story_v_out_116331.awb")
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
				actorName = "10032ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_223_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/I07a",
		"TextureConfig/Background/I07",
		"TextureConfig/Background/STwhite",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/ST03a"
	},
	voices = {
		"story_v_out_116331.awb"
	}
}
