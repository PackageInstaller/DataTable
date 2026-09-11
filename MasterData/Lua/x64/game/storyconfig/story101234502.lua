return {
	Play123452001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 123452001
		arg_1_1.duration_ = 5.17

		local var_1_0 = {
			zh = 4.099999999999,
			ja = 5.166
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
				arg_1_0:Play123452002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.K07g == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "K07g")
				var_4_0.name = "K07g"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.K07g = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.K07g

				arg_1_1.bgs_.K07g.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "K07g" then
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

			local var_4_8 = "1055ui_story"

			if arg_1_1.actors_["1055ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1055ui_story"))) then
				local var_4_9 = Object.Instantiate(Asset.Load("Char/" .. "1055ui_story"), arg_1_1.stage_.transform)

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

			local var_4_12 = arg_1_1.actors_["1055ui_story"].transform

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				arg_1_1.var_.moveOldPos1055ui_story = var_4_12.localPosition
			end

			local var_4_13 = 0.001

			if 1.8 <= arg_1_1.time_ and arg_1_1.time_ < 1.8 + var_4_13 then
				var_4_12.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1055ui_story, Vector3.New(0, -0.965, -6.2), (arg_1_1.time_ - 1.8) / var_4_13)
				var_4_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_12.position).x, (manager.ui.mainCamera.transform.position - var_4_12.position).y, (manager.ui.mainCamera.transform.position - var_4_12.position).z)
				var_4_12.localEulerAngles.z = 0
				var_4_12.localEulerAngles.x = 0
				var_4_12.localEulerAngles = var_4_12.localEulerAngles
			end

			if arg_1_1.time_ >= 1.8 + var_4_13 and arg_1_1.time_ < 1.8 + var_4_13 + arg_4_0 then
				var_4_12.localPosition = Vector3.New(0, -0.965, -6.2)
				var_4_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_12.position).x, (manager.ui.mainCamera.transform.position - var_4_12.position).y, (manager.ui.mainCamera.transform.position - var_4_12.position).z)
				var_4_12.localEulerAngles.z = 0
				var_4_12.localEulerAngles.x = 0
				var_4_12.localEulerAngles = var_4_12.localEulerAngles
			end

			local var_4_14 = arg_1_1.actors_["1055ui_story"]

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 and not isNil(var_4_14) and arg_1_1.var_.characterEffect1055ui_story == nil then
				arg_1_1.var_.characterEffect1055ui_story = var_4_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_15 = 0.200000002980232

			if 1.8 <= arg_1_1.time_ and arg_1_1.time_ < 1.8 + var_4_15 and not isNil(var_4_14) then
				if arg_1_1.var_.characterEffect1055ui_story and not isNil(var_4_14) then
					arg_1_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= 1.8 + var_4_15 and arg_1_1.time_ < 1.8 + var_4_15 + arg_4_0 and not isNil(var_4_14) and arg_1_1.var_.characterEffect1055ui_story then
				arg_1_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				arg_1_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action1_1")
			end

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				arg_1_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
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

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_2_4_battle_xiajingqu", "bgm_activity_2_4_battle_xiajingqu", "bgm_activity_2_4_battle_xiajingqu.awb")

				local var_4_22 = manager.audio:GetAudioName("bgm_activity_2_4_battle_xiajingqu", "bgm_activity_2_4_battle_xiajingqu")

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

			local var_4_23 = 2
			local var_4_24 = 0.225

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_23 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0
				arg_1_1.dialogCg_.alpha = 1

				arg_1_1.dialog_:SetActive(true)
				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[481].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_25 = arg_1_1:GetWordFromCfg(123452001)
				local var_4_26 = arg_1_1:FormatText(var_4_25.content)

				arg_1_1.text_.text = var_4_26

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_28 = 9 <= 0 and var_4_24 or var_4_24 * (utf8.len(var_4_26) / 9)

				if (9 <= 0 and var_4_24 or var_4_24 * (utf8.len(var_4_26) / 9)) > 0 and var_4_24 < var_4_28 then
					arg_1_1.talkMaxDuration = var_4_28

					if var_4_28 + var_4_23 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_28 + var_4_23
					end
				end

				arg_1_1.text_.text = var_4_26
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123452", "123452001", "story_v_out_123452.awb") ~= 0 then
					local var_4_29 = manager.audio:GetVoiceLength("story_v_out_123452", "123452001", "story_v_out_123452.awb") / 1000

					if var_4_29 + var_4_23 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_29 + var_4_23
					end

					if var_4_25.prefab_name ~= "" and arg_1_1.actors_[var_4_25.prefab_name] ~= nil then
						local var_4_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_25.prefab_name].transform, "story_v_out_123452", "123452001", "story_v_out_123452.awb")

						arg_1_1:RecordAudio("123452001", var_4_30)
						arg_1_1:RecordAudio("123452001", var_4_30)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_123452", "123452001", "story_v_out_123452.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_123452", "123452001", "story_v_out_123452.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_31 = math.max(var_4_24, arg_1_1.talkMaxDuration)

			if var_4_23 <= arg_1_1.time_ and arg_1_1.time_ < var_4_23 + var_4_31 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_23) / var_4_31

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_23 + var_4_31 and arg_1_1.time_ < var_4_23 + var_4_31 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1055ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play123452002 = function(arg_7_0, arg_7_1)
		arg_7_1.time_ = 0
		arg_7_1.frameCnt_ = 0
		arg_7_1.state_ = "playing"
		arg_7_1.curTalkId_ = 123452002
		arg_7_1.duration_ = 3.43

		local var_7_0 = {
			zh = 3.433,
			ja = 2.9
		}
		local var_7_1 = manager.audio:GetLocalizationFlag()

		if var_7_0[var_7_1] ~= nil then
			arg_7_1.duration_ = var_7_0[var_7_1]
		end

		SetActive(arg_7_1.tipsGo_, false)

		function arg_7_1.onSingleLineFinish_()
			arg_7_1.onSingleLineUpdate_ = nil
			arg_7_1.onSingleLineFinish_ = nil
			arg_7_1.state_ = "waiting"
		end

		function arg_7_1.playNext_(arg_9_0)
			if arg_9_0 == 1 then
				arg_7_0:Play123452003(arg_7_1)
			end
		end

		function arg_7_1.onSingleLineUpdate_(arg_10_0)
			if 0 < arg_7_1.time_ and arg_7_1.time_ <= 0 + arg_10_0 and not isNil(arg_7_1.actors_["1055ui_story"]) and arg_7_1.var_.characterEffect1055ui_story == nil then
				arg_7_1.var_.characterEffect1055ui_story = arg_7_1.actors_["1055ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_10_0 = 0.200000002980232

			if 0 <= arg_7_1.time_ and arg_7_1.time_ < 0 + var_10_0 and not isNil(arg_7_1.actors_["1055ui_story"]) then
				if arg_7_1.var_.characterEffect1055ui_story and not isNil(arg_7_1.actors_["1055ui_story"]) then
					arg_7_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_7_1.var_.characterEffect1055ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_7_1.time_ - 0) / var_10_0)
				end
			end

			if arg_7_1.time_ >= 0 + var_10_0 and arg_7_1.time_ < 0 + var_10_0 + arg_10_0 and not isNil(arg_7_1.actors_["1055ui_story"]) and arg_7_1.var_.characterEffect1055ui_story then
				arg_7_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_7_1.var_.characterEffect1055ui_story.fillRatio = 0.5
			end

			local var_10_1 = 0
			local var_10_2 = 0.25

			if 0 < arg_7_1.time_ and arg_7_1.time_ <= var_10_1 + arg_10_0 then
				arg_7_1.talkMaxDuration = 0
				arg_7_1.dialogCg_.alpha = 1

				arg_7_1.dialog_:SetActive(true)
				SetActive(arg_7_1.leftNameGo_, true)

				arg_7_1.leftNameTxt_.text = arg_7_1:FormatText(StoryNameCfg[494].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_7_1.leftNameTxt_.transform)

				arg_7_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_7_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_7_1:RecordName(arg_7_1.leftNameTxt_.text)
				SetActive(arg_7_1.iconTrs_.gameObject, true)
				arg_7_1.iconController_:SetSelectedState("hero")

				arg_7_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2089")

				arg_7_1.callingController_:SetSelectedState("normal")

				arg_7_1.keyicon_.color = Color.New(1, 1, 1)
				arg_7_1.icon_.color = Color.New(1, 1, 1)

				local var_10_3 = arg_7_1:GetWordFromCfg(123452002)
				local var_10_4 = arg_7_1:FormatText(var_10_3.content)

				arg_7_1.text_.text = var_10_4

				LuaForUtil.ClearLinePrefixSymbol(arg_7_1.text_)

				local var_10_6 = 10 <= 0 and var_10_2 or var_10_2 * (utf8.len(var_10_4) / 10)

				if (10 <= 0 and var_10_2 or var_10_2 * (utf8.len(var_10_4) / 10)) > 0 and var_10_2 < var_10_6 then
					arg_7_1.talkMaxDuration = var_10_6

					if var_10_6 + var_10_1 > arg_7_1.duration_ then
						arg_7_1.duration_ = var_10_6 + var_10_1
					end
				end

				arg_7_1.text_.text = var_10_4
				arg_7_1.typewritter.percent = 0

				arg_7_1.typewritter:SetDirty()
				arg_7_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123452", "123452002", "story_v_out_123452.awb") ~= 0 then
					local var_10_7 = manager.audio:GetVoiceLength("story_v_out_123452", "123452002", "story_v_out_123452.awb") / 1000

					if var_10_7 + var_10_1 > arg_7_1.duration_ then
						arg_7_1.duration_ = var_10_7 + var_10_1
					end

					if var_10_3.prefab_name ~= "" and arg_7_1.actors_[var_10_3.prefab_name] ~= nil then
						local var_10_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_7_1.actors_[var_10_3.prefab_name].transform, "story_v_out_123452", "123452002", "story_v_out_123452.awb")

						arg_7_1:RecordAudio("123452002", var_10_8)
						arg_7_1:RecordAudio("123452002", var_10_8)
					else
						arg_7_1:AudioAction("play", "voice", "story_v_out_123452", "123452002", "story_v_out_123452.awb")
					end

					arg_7_1:RecordHistoryTalkVoice("story_v_out_123452", "123452002", "story_v_out_123452.awb")
				end

				arg_7_1:RecordContent(arg_7_1.text_.text)
			end

			local var_10_9 = math.max(var_10_2, arg_7_1.talkMaxDuration)

			if var_10_1 <= arg_7_1.time_ and arg_7_1.time_ < var_10_1 + var_10_9 then
				arg_7_1.typewritter.percent = (arg_7_1.time_ - var_10_1) / var_10_9

				arg_7_1.typewritter:SetDirty()
			end

			if arg_7_1.time_ >= var_10_1 + var_10_9 and arg_7_1.time_ < var_10_1 + var_10_9 + arg_10_0 then
				arg_7_1.typewritter.percent = 1

				arg_7_1.typewritter:SetDirty()
				arg_7_1:ShowNextGo(true)
			end
		end

		arg_7_1.nodeConfigList_ = {}

		arg_7_1:InitPlayNodeList()
	end,
	Play123452003 = function(arg_11_0, arg_11_1)
		arg_11_1.time_ = 0
		arg_11_1.frameCnt_ = 0
		arg_11_1.state_ = "playing"
		arg_11_1.curTalkId_ = 123452003
		arg_11_1.duration_ = 5

		SetActive(arg_11_1.tipsGo_, false)

		function arg_11_1.onSingleLineFinish_()
			arg_11_1.onSingleLineUpdate_ = nil
			arg_11_1.onSingleLineFinish_ = nil
			arg_11_1.state_ = "waiting"
		end

		function arg_11_1.playNext_(arg_13_0)
			if arg_13_0 == 1 then
				arg_11_0:Play123452004(arg_11_1)
			end
		end

		function arg_11_1.onSingleLineUpdate_(arg_14_0)
			if 0 < arg_11_1.time_ and arg_11_1.time_ <= 0 + arg_14_0 then
				arg_11_1.var_.moveOldPos1055ui_story = arg_11_1.actors_["1055ui_story"].transform.localPosition
			end

			local var_14_0 = 0.001

			if 0 <= arg_11_1.time_ and arg_11_1.time_ < 0 + var_14_0 then
				arg_11_1.actors_["1055ui_story"].transform.localPosition = Vector3.Lerp(arg_11_1.var_.moveOldPos1055ui_story, Vector3.New(0, 100, 0), (arg_11_1.time_ - 0) / var_14_0)
				arg_11_1.actors_["1055ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_11_1.actors_["1055ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_11_1.actors_["1055ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_11_1.actors_["1055ui_story"].transform.position).z)
				arg_11_1.actors_["1055ui_story"].transform.localEulerAngles.z = 0
				arg_11_1.actors_["1055ui_story"].transform.localEulerAngles.x = 0
				arg_11_1.actors_["1055ui_story"].transform.localEulerAngles = arg_11_1.actors_["1055ui_story"].transform.localEulerAngles
			end

			if arg_11_1.time_ >= 0 + var_14_0 and arg_11_1.time_ < 0 + var_14_0 + arg_14_0 then
				arg_11_1.actors_["1055ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_11_1.actors_["1055ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_11_1.actors_["1055ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_11_1.actors_["1055ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_11_1.actors_["1055ui_story"].transform.position).z)
				arg_11_1.actors_["1055ui_story"].transform.localEulerAngles.z = 0
				arg_11_1.actors_["1055ui_story"].transform.localEulerAngles.x = 0
				arg_11_1.actors_["1055ui_story"].transform.localEulerAngles = arg_11_1.actors_["1055ui_story"].transform.localEulerAngles
			end

			local var_14_1 = arg_11_1.actors_["1055ui_story"]

			if 0 < arg_11_1.time_ and arg_11_1.time_ <= 0 + arg_14_0 and not isNil(var_14_1) and arg_11_1.var_.characterEffect1055ui_story == nil then
				arg_11_1.var_.characterEffect1055ui_story = var_14_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_14_2 = 0.200000002980232

			if 0 <= arg_11_1.time_ and arg_11_1.time_ < 0 + var_14_2 and not isNil(var_14_1) then
				if arg_11_1.var_.characterEffect1055ui_story and not isNil(var_14_1) then
					arg_11_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_11_1.var_.characterEffect1055ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_11_1.time_ - 0) / var_14_2)
				end
			end

			if arg_11_1.time_ >= 0 + var_14_2 and arg_11_1.time_ < 0 + var_14_2 + arg_14_0 and not isNil(var_14_1) and arg_11_1.var_.characterEffect1055ui_story then
				arg_11_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_11_1.var_.characterEffect1055ui_story.fillRatio = 0.5
			end

			if 0 < arg_11_1.time_ and arg_11_1.time_ <= 0 + arg_14_0 then
				arg_11_1:AudioAction("play", "effect", "se_story_123_01", "se_story_123_01_vine", "")
			end

			local var_14_4 = 0
			local var_14_5 = 0.825

			if 0 < arg_11_1.time_ and arg_11_1.time_ <= var_14_4 + arg_14_0 then
				arg_11_1.talkMaxDuration = 0
				arg_11_1.dialogCg_.alpha = 1

				arg_11_1.dialog_:SetActive(true)
				SetActive(arg_11_1.leftNameGo_, false)

				arg_11_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_11_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_11_1:RecordName(arg_11_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_11_1.iconTrs_.gameObject, false)
				arg_11_1.callingController_:SetSelectedState("normal")

				local var_14_6 = arg_11_1:FormatText(arg_11_1:GetWordFromCfg(123452003).content)

				arg_11_1.text_.text = var_14_6

				LuaForUtil.ClearLinePrefixSymbol(arg_11_1.text_)

				local var_14_8 = 33 <= 0 and var_14_5 or var_14_5 * (utf8.len(var_14_6) / 33)

				if (33 <= 0 and var_14_5 or var_14_5 * (utf8.len(var_14_6) / 33)) > 0 and var_14_5 < var_14_8 then
					arg_11_1.talkMaxDuration = var_14_8

					if var_14_8 + var_14_4 > arg_11_1.duration_ then
						arg_11_1.duration_ = var_14_8 + var_14_4
					end
				end

				arg_11_1.text_.text = var_14_6
				arg_11_1.typewritter.percent = 0

				arg_11_1.typewritter:SetDirty()
				arg_11_1:ShowNextGo(false)
				arg_11_1:RecordContent(arg_11_1.text_.text)
			end

			local var_14_9 = math.max(var_14_5, arg_11_1.talkMaxDuration)

			if var_14_4 <= arg_11_1.time_ and arg_11_1.time_ < var_14_4 + var_14_9 then
				arg_11_1.typewritter.percent = (arg_11_1.time_ - var_14_4) / var_14_9

				arg_11_1.typewritter:SetDirty()
			end

			if arg_11_1.time_ >= var_14_4 + var_14_9 and arg_11_1.time_ < var_14_4 + var_14_9 + arg_14_0 then
				arg_11_1.typewritter.percent = 1

				arg_11_1.typewritter:SetDirty()
				arg_11_1:ShowNextGo(true)
			end
		end

		arg_11_1.nodeConfigList_ = {
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

		arg_11_1:InitPlayNodeList()
	end,
	Play123452004 = function(arg_15_0, arg_15_1)
		arg_15_1.time_ = 0
		arg_15_1.frameCnt_ = 0
		arg_15_1.state_ = "playing"
		arg_15_1.curTalkId_ = 123452004
		arg_15_1.duration_ = 2.77

		local var_15_0 = {
			zh = 2.766,
			ja = 1.999999999999
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
				arg_15_0:Play123452005(arg_15_1)
			end
		end

		function arg_15_1.onSingleLineUpdate_(arg_18_0)
			if arg_15_1.actors_["1093ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1093ui_story"))) then
				local var_18_0 = Object.Instantiate(Asset.Load("Char/" .. "1093ui_story"), arg_15_1.stage_.transform)

				var_18_0.name = "1093ui_story"
				var_18_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_15_1.actors_["1093ui_story"] = var_18_0

				local var_18_1 = var_18_0:GetComponentInChildren(typeof(CharacterEffect))

				var_18_1.enabled = true

				local var_18_2 = GameObjectTools.GetOrAddComponent(var_18_0, typeof(DynamicBoneHelper))

				if var_18_2 then
					var_18_2:EnableDynamicBone(false)
				end

				arg_15_1:ShowWeapon(var_18_1.transform, false)

				arg_15_1.var_["1093ui_story" .. "Animator"] = var_18_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_15_1.var_["1093ui_story" .. "Animator"].applyRootMotion = true
				arg_15_1.var_["1093ui_story" .. "LipSync"] = var_18_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_18_3 = arg_15_1.actors_["1093ui_story"].transform

			if 0 < arg_15_1.time_ and arg_15_1.time_ <= 0 + arg_18_0 then
				arg_15_1.var_.moveOldPos1093ui_story = var_18_3.localPosition
			end

			local var_18_4 = 0.001

			if 0 <= arg_15_1.time_ and arg_15_1.time_ < 0 + var_18_4 then
				var_18_3.localPosition = Vector3.Lerp(arg_15_1.var_.moveOldPos1093ui_story, Vector3.New(-0.7, -1.11, -5.88), (arg_15_1.time_ - 0) / var_18_4)
				var_18_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_18_3.position).x, (manager.ui.mainCamera.transform.position - var_18_3.position).y, (manager.ui.mainCamera.transform.position - var_18_3.position).z)
				var_18_3.localEulerAngles.z = 0
				var_18_3.localEulerAngles.x = 0
				var_18_3.localEulerAngles = var_18_3.localEulerAngles
			end

			if arg_15_1.time_ >= 0 + var_18_4 and arg_15_1.time_ < 0 + var_18_4 + arg_18_0 then
				var_18_3.localPosition = Vector3.New(-0.7, -1.11, -5.88)
				var_18_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_18_3.position).x, (manager.ui.mainCamera.transform.position - var_18_3.position).y, (manager.ui.mainCamera.transform.position - var_18_3.position).z)
				var_18_3.localEulerAngles.z = 0
				var_18_3.localEulerAngles.x = 0
				var_18_3.localEulerAngles = var_18_3.localEulerAngles
			end

			local var_18_5 = arg_15_1.actors_["1093ui_story"]

			if 0 < arg_15_1.time_ and arg_15_1.time_ <= 0 + arg_18_0 and not isNil(var_18_5) and arg_15_1.var_.characterEffect1093ui_story == nil then
				arg_15_1.var_.characterEffect1093ui_story = var_18_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_18_6 = 0.200000002980232

			if 0 <= arg_15_1.time_ and arg_15_1.time_ < 0 + var_18_6 and not isNil(var_18_5) then
				if arg_15_1.var_.characterEffect1093ui_story and not isNil(var_18_5) then
					arg_15_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_15_1.time_ >= 0 + var_18_6 and arg_15_1.time_ < 0 + var_18_6 + arg_18_0 and not isNil(var_18_5) and arg_15_1.var_.characterEffect1093ui_story then
				arg_15_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_15_1.time_ and arg_15_1.time_ <= 0 + arg_18_0 then
				arg_15_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action4_1")
			end

			if 0 < arg_15_1.time_ and arg_15_1.time_ <= 0 + arg_18_0 then
				arg_15_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_18_8 = arg_15_1.actors_["1055ui_story"].transform

			if 0 < arg_15_1.time_ and arg_15_1.time_ <= 0 + arg_18_0 then
				arg_15_1.var_.moveOldPos1055ui_story = var_18_8.localPosition
			end

			local var_18_9 = 0.001

			if 0 <= arg_15_1.time_ and arg_15_1.time_ < 0 + var_18_9 then
				var_18_8.localPosition = Vector3.Lerp(arg_15_1.var_.moveOldPos1055ui_story, Vector3.New(0.7, -0.965, -6.2), (arg_15_1.time_ - 0) / var_18_9)
				var_18_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_18_8.position).x, (manager.ui.mainCamera.transform.position - var_18_8.position).y, (manager.ui.mainCamera.transform.position - var_18_8.position).z)
				var_18_8.localEulerAngles.z = 0
				var_18_8.localEulerAngles.x = 0
				var_18_8.localEulerAngles = var_18_8.localEulerAngles
			end

			if arg_15_1.time_ >= 0 + var_18_9 and arg_15_1.time_ < 0 + var_18_9 + arg_18_0 then
				var_18_8.localPosition = Vector3.New(0.7, -0.965, -6.2)
				var_18_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_18_8.position).x, (manager.ui.mainCamera.transform.position - var_18_8.position).y, (manager.ui.mainCamera.transform.position - var_18_8.position).z)
				var_18_8.localEulerAngles.z = 0
				var_18_8.localEulerAngles.x = 0
				var_18_8.localEulerAngles = var_18_8.localEulerAngles
			end

			local var_18_10 = arg_15_1.actors_["1055ui_story"]

			if 0 < arg_15_1.time_ and arg_15_1.time_ <= 0 + arg_18_0 and not isNil(var_18_10) and arg_15_1.var_.characterEffect1055ui_story == nil then
				arg_15_1.var_.characterEffect1055ui_story = var_18_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_18_11 = 0.200000002980232

			if 0 <= arg_15_1.time_ and arg_15_1.time_ < 0 + var_18_11 and not isNil(var_18_10) then
				if arg_15_1.var_.characterEffect1055ui_story and not isNil(var_18_10) then
					arg_15_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_15_1.var_.characterEffect1055ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_15_1.time_ - 0) / var_18_11)
				end
			end

			if arg_15_1.time_ >= 0 + var_18_11 and arg_15_1.time_ < 0 + var_18_11 + arg_18_0 and not isNil(var_18_10) and arg_15_1.var_.characterEffect1055ui_story then
				arg_15_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_15_1.var_.characterEffect1055ui_story.fillRatio = 0.5
			end

			local var_18_12 = 0
			local var_18_13 = 0.225

			if 0 < arg_15_1.time_ and arg_15_1.time_ <= var_18_12 + arg_18_0 then
				arg_15_1.talkMaxDuration = 0
				arg_15_1.dialogCg_.alpha = 1

				arg_15_1.dialog_:SetActive(true)
				SetActive(arg_15_1.leftNameGo_, true)

				arg_15_1.leftNameTxt_.text = arg_15_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_15_1.leftNameTxt_.transform)

				arg_15_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_15_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_15_1:RecordName(arg_15_1.leftNameTxt_.text)
				SetActive(arg_15_1.iconTrs_.gameObject, false)
				arg_15_1.callingController_:SetSelectedState("normal")

				local var_18_14 = arg_15_1:GetWordFromCfg(123452004)
				local var_18_15 = arg_15_1:FormatText(var_18_14.content)

				arg_15_1.text_.text = var_18_15

				LuaForUtil.ClearLinePrefixSymbol(arg_15_1.text_)

				local var_18_17 = 9 <= 0 and var_18_13 or var_18_13 * (utf8.len(var_18_15) / 9)

				if (9 <= 0 and var_18_13 or var_18_13 * (utf8.len(var_18_15) / 9)) > 0 and var_18_13 < var_18_17 then
					arg_15_1.talkMaxDuration = var_18_17

					if var_18_17 + var_18_12 > arg_15_1.duration_ then
						arg_15_1.duration_ = var_18_17 + var_18_12
					end
				end

				arg_15_1.text_.text = var_18_15
				arg_15_1.typewritter.percent = 0

				arg_15_1.typewritter:SetDirty()
				arg_15_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123452", "123452004", "story_v_out_123452.awb") ~= 0 then
					local var_18_18 = manager.audio:GetVoiceLength("story_v_out_123452", "123452004", "story_v_out_123452.awb") / 1000

					if var_18_18 + var_18_12 > arg_15_1.duration_ then
						arg_15_1.duration_ = var_18_18 + var_18_12
					end

					if var_18_14.prefab_name ~= "" and arg_15_1.actors_[var_18_14.prefab_name] ~= nil then
						local var_18_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_15_1.actors_[var_18_14.prefab_name].transform, "story_v_out_123452", "123452004", "story_v_out_123452.awb")

						arg_15_1:RecordAudio("123452004", var_18_19)
						arg_15_1:RecordAudio("123452004", var_18_19)
					else
						arg_15_1:AudioAction("play", "voice", "story_v_out_123452", "123452004", "story_v_out_123452.awb")
					end

					arg_15_1:RecordHistoryTalkVoice("story_v_out_123452", "123452004", "story_v_out_123452.awb")
				end

				arg_15_1:RecordContent(arg_15_1.text_.text)
			end

			local var_18_20 = math.max(var_18_13, arg_15_1.talkMaxDuration)

			if var_18_12 <= arg_15_1.time_ and arg_15_1.time_ < var_18_12 + var_18_20 then
				arg_15_1.typewritter.percent = (arg_15_1.time_ - var_18_12) / var_18_20

				arg_15_1.typewritter:SetDirty()
			end

			if arg_15_1.time_ >= var_18_12 + var_18_20 and arg_15_1.time_ < var_18_12 + var_18_20 + arg_18_0 then
				arg_15_1.typewritter.percent = 1

				arg_15_1.typewritter:SetDirty()
				arg_15_1:ShowNextGo(true)
			end
		end

		arg_15_1.nodeConfigList_ = {
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

		arg_15_1:InitPlayNodeList()
	end,
	Play123452005 = function(arg_19_0, arg_19_1)
		arg_19_1.time_ = 0
		arg_19_1.frameCnt_ = 0
		arg_19_1.state_ = "playing"
		arg_19_1.curTalkId_ = 123452005
		arg_19_1.duration_ = 8.97

		local var_19_0 = {
			zh = 6.566,
			ja = 8.966
		}
		local var_19_1 = manager.audio:GetLocalizationFlag()

		if var_19_0[var_19_1] ~= nil then
			arg_19_1.duration_ = var_19_0[var_19_1]
		end

		SetActive(arg_19_1.tipsGo_, false)

		function arg_19_1.onSingleLineFinish_()
			arg_19_1.onSingleLineUpdate_ = nil
			arg_19_1.onSingleLineFinish_ = nil
			arg_19_1.state_ = "waiting"
		end

		function arg_19_1.playNext_(arg_21_0)
			if arg_21_0 == 1 then
				arg_19_0:Play123452006(arg_19_1)
			end
		end

		function arg_19_1.onSingleLineUpdate_(arg_22_0)
			if 0 < arg_19_1.time_ and arg_19_1.time_ <= 0 + arg_22_0 and not isNil(arg_19_1.actors_["1055ui_story"]) and arg_19_1.var_.characterEffect1055ui_story == nil then
				arg_19_1.var_.characterEffect1055ui_story = arg_19_1.actors_["1055ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_22_0 = 0.200000002980232

			if 0 <= arg_19_1.time_ and arg_19_1.time_ < 0 + var_22_0 and not isNil(arg_19_1.actors_["1055ui_story"]) then
				if arg_19_1.var_.characterEffect1055ui_story and not isNil(arg_19_1.actors_["1055ui_story"]) then
					arg_19_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_19_1.time_ >= 0 + var_22_0 and arg_19_1.time_ < 0 + var_22_0 + arg_22_0 and not isNil(arg_19_1.actors_["1055ui_story"]) and arg_19_1.var_.characterEffect1055ui_story then
				arg_19_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= 0 + arg_22_0 then
				arg_19_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_22_2 = arg_19_1.actors_["1093ui_story"]

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= 0 + arg_22_0 and not isNil(var_22_2) and arg_19_1.var_.characterEffect1093ui_story == nil then
				arg_19_1.var_.characterEffect1093ui_story = var_22_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_22_3 = 0.200000002980232

			if 0 <= arg_19_1.time_ and arg_19_1.time_ < 0 + var_22_3 and not isNil(var_22_2) then
				if arg_19_1.var_.characterEffect1093ui_story and not isNil(var_22_2) then
					arg_19_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_19_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_19_1.time_ - 0) / var_22_3)
				end
			end

			if arg_19_1.time_ >= 0 + var_22_3 and arg_19_1.time_ < 0 + var_22_3 + arg_22_0 and not isNil(var_22_2) and arg_19_1.var_.characterEffect1093ui_story then
				arg_19_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_19_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_22_4 = 0
			local var_22_5 = 0.825

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= var_22_4 + arg_22_0 then
				arg_19_1.talkMaxDuration = 0
				arg_19_1.dialogCg_.alpha = 1

				arg_19_1.dialog_:SetActive(true)
				SetActive(arg_19_1.leftNameGo_, true)

				arg_19_1.leftNameTxt_.text = arg_19_1:FormatText(StoryNameCfg[481].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_19_1.leftNameTxt_.transform)

				arg_19_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_19_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_19_1:RecordName(arg_19_1.leftNameTxt_.text)
				SetActive(arg_19_1.iconTrs_.gameObject, false)
				arg_19_1.callingController_:SetSelectedState("normal")

				local var_22_6 = arg_19_1:GetWordFromCfg(123452005)
				local var_22_7 = arg_19_1:FormatText(var_22_6.content)

				arg_19_1.text_.text = var_22_7

				LuaForUtil.ClearLinePrefixSymbol(arg_19_1.text_)

				local var_22_9 = 33 <= 0 and var_22_5 or var_22_5 * (utf8.len(var_22_7) / 33)

				if (33 <= 0 and var_22_5 or var_22_5 * (utf8.len(var_22_7) / 33)) > 0 and var_22_5 < var_22_9 then
					arg_19_1.talkMaxDuration = var_22_9

					if var_22_9 + var_22_4 > arg_19_1.duration_ then
						arg_19_1.duration_ = var_22_9 + var_22_4
					end
				end

				arg_19_1.text_.text = var_22_7
				arg_19_1.typewritter.percent = 0

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123452", "123452005", "story_v_out_123452.awb") ~= 0 then
					local var_22_10 = manager.audio:GetVoiceLength("story_v_out_123452", "123452005", "story_v_out_123452.awb") / 1000

					if var_22_10 + var_22_4 > arg_19_1.duration_ then
						arg_19_1.duration_ = var_22_10 + var_22_4
					end

					if var_22_6.prefab_name ~= "" and arg_19_1.actors_[var_22_6.prefab_name] ~= nil then
						local var_22_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_19_1.actors_[var_22_6.prefab_name].transform, "story_v_out_123452", "123452005", "story_v_out_123452.awb")

						arg_19_1:RecordAudio("123452005", var_22_11)
						arg_19_1:RecordAudio("123452005", var_22_11)
					else
						arg_19_1:AudioAction("play", "voice", "story_v_out_123452", "123452005", "story_v_out_123452.awb")
					end

					arg_19_1:RecordHistoryTalkVoice("story_v_out_123452", "123452005", "story_v_out_123452.awb")
				end

				arg_19_1:RecordContent(arg_19_1.text_.text)
			end

			local var_22_12 = math.max(var_22_5, arg_19_1.talkMaxDuration)

			if var_22_4 <= arg_19_1.time_ and arg_19_1.time_ < var_22_4 + var_22_12 then
				arg_19_1.typewritter.percent = (arg_19_1.time_ - var_22_4) / var_22_12

				arg_19_1.typewritter:SetDirty()
			end

			if arg_19_1.time_ >= var_22_4 + var_22_12 and arg_19_1.time_ < var_22_4 + var_22_12 + arg_22_0 then
				arg_19_1.typewritter.percent = 1

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(true)
			end
		end

		arg_19_1.nodeConfigList_ = {}

		arg_19_1:InitPlayNodeList()
	end,
	Play123452006 = function(arg_23_0, arg_23_1)
		arg_23_1.time_ = 0
		arg_23_1.frameCnt_ = 0
		arg_23_1.state_ = "playing"
		arg_23_1.curTalkId_ = 123452006
		arg_23_1.duration_ = 6.4

		local var_23_0 = {
			zh = 6.4,
			ja = 5.1
		}
		local var_23_1 = manager.audio:GetLocalizationFlag()

		if var_23_0[var_23_1] ~= nil then
			arg_23_1.duration_ = var_23_0[var_23_1]
		end

		SetActive(arg_23_1.tipsGo_, false)

		function arg_23_1.onSingleLineFinish_()
			arg_23_1.onSingleLineUpdate_ = nil
			arg_23_1.onSingleLineFinish_ = nil
			arg_23_1.state_ = "waiting"
		end

		function arg_23_1.playNext_(arg_25_0)
			if arg_25_0 == 1 then
				arg_23_0:Play123452007(arg_23_1)
			end
		end

		function arg_23_1.onSingleLineUpdate_(arg_26_0)
			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 and not isNil(arg_23_1.actors_["1093ui_story"]) and arg_23_1.var_.characterEffect1093ui_story == nil then
				arg_23_1.var_.characterEffect1093ui_story = arg_23_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_26_0 = 0.200000002980232

			if 0 <= arg_23_1.time_ and arg_23_1.time_ < 0 + var_26_0 and not isNil(arg_23_1.actors_["1093ui_story"]) then
				if arg_23_1.var_.characterEffect1093ui_story and not isNil(arg_23_1.actors_["1093ui_story"]) then
					arg_23_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_23_1.time_ >= 0 + var_26_0 and arg_23_1.time_ < 0 + var_26_0 + arg_26_0 and not isNil(arg_23_1.actors_["1093ui_story"]) and arg_23_1.var_.characterEffect1093ui_story then
				arg_23_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 then
				arg_23_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action4_2")
			end

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 then
				arg_23_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_26_2 = arg_23_1.actors_["1055ui_story"]

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 and not isNil(var_26_2) and arg_23_1.var_.characterEffect1055ui_story == nil then
				arg_23_1.var_.characterEffect1055ui_story = var_26_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_26_3 = 0.200000002980232

			if 0 <= arg_23_1.time_ and arg_23_1.time_ < 0 + var_26_3 and not isNil(var_26_2) then
				if arg_23_1.var_.characterEffect1055ui_story and not isNil(var_26_2) then
					arg_23_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_23_1.var_.characterEffect1055ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_23_1.time_ - 0) / var_26_3)
				end
			end

			if arg_23_1.time_ >= 0 + var_26_3 and arg_23_1.time_ < 0 + var_26_3 + arg_26_0 and not isNil(var_26_2) and arg_23_1.var_.characterEffect1055ui_story then
				arg_23_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_23_1.var_.characterEffect1055ui_story.fillRatio = 0.5
			end

			local var_26_4 = 0
			local var_26_5 = 0.575

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= var_26_4 + arg_26_0 then
				arg_23_1.talkMaxDuration = 0
				arg_23_1.dialogCg_.alpha = 1

				arg_23_1.dialog_:SetActive(true)
				SetActive(arg_23_1.leftNameGo_, true)

				arg_23_1.leftNameTxt_.text = arg_23_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_23_1.leftNameTxt_.transform)

				arg_23_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_23_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_23_1:RecordName(arg_23_1.leftNameTxt_.text)
				SetActive(arg_23_1.iconTrs_.gameObject, false)
				arg_23_1.callingController_:SetSelectedState("normal")

				local var_26_6 = arg_23_1:GetWordFromCfg(123452006)
				local var_26_7 = arg_23_1:FormatText(var_26_6.content)

				arg_23_1.text_.text = var_26_7

				LuaForUtil.ClearLinePrefixSymbol(arg_23_1.text_)

				local var_26_9 = 23 <= 0 and var_26_5 or var_26_5 * (utf8.len(var_26_7) / 23)

				if (23 <= 0 and var_26_5 or var_26_5 * (utf8.len(var_26_7) / 23)) > 0 and var_26_5 < var_26_9 then
					arg_23_1.talkMaxDuration = var_26_9

					if var_26_9 + var_26_4 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_9 + var_26_4
					end
				end

				arg_23_1.text_.text = var_26_7
				arg_23_1.typewritter.percent = 0

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123452", "123452006", "story_v_out_123452.awb") ~= 0 then
					local var_26_10 = manager.audio:GetVoiceLength("story_v_out_123452", "123452006", "story_v_out_123452.awb") / 1000

					if var_26_10 + var_26_4 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_10 + var_26_4
					end

					if var_26_6.prefab_name ~= "" and arg_23_1.actors_[var_26_6.prefab_name] ~= nil then
						local var_26_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_23_1.actors_[var_26_6.prefab_name].transform, "story_v_out_123452", "123452006", "story_v_out_123452.awb")

						arg_23_1:RecordAudio("123452006", var_26_11)
						arg_23_1:RecordAudio("123452006", var_26_11)
					else
						arg_23_1:AudioAction("play", "voice", "story_v_out_123452", "123452006", "story_v_out_123452.awb")
					end

					arg_23_1:RecordHistoryTalkVoice("story_v_out_123452", "123452006", "story_v_out_123452.awb")
				end

				arg_23_1:RecordContent(arg_23_1.text_.text)
			end

			local var_26_12 = math.max(var_26_5, arg_23_1.talkMaxDuration)

			if var_26_4 <= arg_23_1.time_ and arg_23_1.time_ < var_26_4 + var_26_12 then
				arg_23_1.typewritter.percent = (arg_23_1.time_ - var_26_4) / var_26_12

				arg_23_1.typewritter:SetDirty()
			end

			if arg_23_1.time_ >= var_26_4 + var_26_12 and arg_23_1.time_ < var_26_4 + var_26_12 + arg_26_0 then
				arg_23_1.typewritter.percent = 1

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(true)
			end
		end

		arg_23_1.nodeConfigList_ = {}

		arg_23_1:InitPlayNodeList()
	end,
	Play123452007 = function(arg_27_0, arg_27_1)
		arg_27_1.time_ = 0
		arg_27_1.frameCnt_ = 0
		arg_27_1.state_ = "playing"
		arg_27_1.curTalkId_ = 123452007
		arg_27_1.duration_ = 7

		local var_27_0 = {
			zh = 5.733,
			ja = 7
		}
		local var_27_1 = manager.audio:GetLocalizationFlag()

		if var_27_0[var_27_1] ~= nil then
			arg_27_1.duration_ = var_27_0[var_27_1]
		end

		SetActive(arg_27_1.tipsGo_, false)

		function arg_27_1.onSingleLineFinish_()
			arg_27_1.onSingleLineUpdate_ = nil
			arg_27_1.onSingleLineFinish_ = nil
			arg_27_1.state_ = "waiting"
		end

		function arg_27_1.playNext_(arg_29_0)
			if arg_29_0 == 1 then
				arg_27_0:Play123452008(arg_27_1)
			end
		end

		function arg_27_1.onSingleLineUpdate_(arg_30_0)
			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 then
				arg_27_1.var_.moveOldPos1055ui_story = arg_27_1.actors_["1055ui_story"].transform.localPosition
			end

			local var_30_0 = 0.001

			if 0 <= arg_27_1.time_ and arg_27_1.time_ < 0 + var_30_0 then
				arg_27_1.actors_["1055ui_story"].transform.localPosition = Vector3.Lerp(arg_27_1.var_.moveOldPos1055ui_story, Vector3.New(0.7, -0.965, -6.2), (arg_27_1.time_ - 0) / var_30_0)
				arg_27_1.actors_["1055ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_27_1.actors_["1055ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_27_1.actors_["1055ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_27_1.actors_["1055ui_story"].transform.position).z)
				arg_27_1.actors_["1055ui_story"].transform.localEulerAngles.z = 0
				arg_27_1.actors_["1055ui_story"].transform.localEulerAngles.x = 0
				arg_27_1.actors_["1055ui_story"].transform.localEulerAngles = arg_27_1.actors_["1055ui_story"].transform.localEulerAngles
			end

			if arg_27_1.time_ >= 0 + var_30_0 and arg_27_1.time_ < 0 + var_30_0 + arg_30_0 then
				arg_27_1.actors_["1055ui_story"].transform.localPosition = Vector3.New(0.7, -0.965, -6.2)
				arg_27_1.actors_["1055ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_27_1.actors_["1055ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_27_1.actors_["1055ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_27_1.actors_["1055ui_story"].transform.position).z)
				arg_27_1.actors_["1055ui_story"].transform.localEulerAngles.z = 0
				arg_27_1.actors_["1055ui_story"].transform.localEulerAngles.x = 0
				arg_27_1.actors_["1055ui_story"].transform.localEulerAngles = arg_27_1.actors_["1055ui_story"].transform.localEulerAngles
			end

			local var_30_1 = arg_27_1.actors_["1055ui_story"]

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 and not isNil(var_30_1) and arg_27_1.var_.characterEffect1055ui_story == nil then
				arg_27_1.var_.characterEffect1055ui_story = var_30_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_30_2 = 0.200000002980232

			if 0 <= arg_27_1.time_ and arg_27_1.time_ < 0 + var_30_2 and not isNil(var_30_1) then
				if arg_27_1.var_.characterEffect1055ui_story and not isNil(var_30_1) then
					arg_27_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_27_1.time_ >= 0 + var_30_2 and arg_27_1.time_ < 0 + var_30_2 + arg_30_0 and not isNil(var_30_1) and arg_27_1.var_.characterEffect1055ui_story then
				arg_27_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 then
				arg_27_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action1_1")
			end

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 then
				arg_27_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_30_4 = arg_27_1.actors_["1093ui_story"]

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 and not isNil(var_30_4) and arg_27_1.var_.characterEffect1093ui_story == nil then
				arg_27_1.var_.characterEffect1093ui_story = var_30_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_30_5 = 0.200000002980232

			if 0 <= arg_27_1.time_ and arg_27_1.time_ < 0 + var_30_5 and not isNil(var_30_4) then
				if arg_27_1.var_.characterEffect1093ui_story and not isNil(var_30_4) then
					arg_27_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_27_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_27_1.time_ - 0) / var_30_5)
				end
			end

			if arg_27_1.time_ >= 0 + var_30_5 and arg_27_1.time_ < 0 + var_30_5 + arg_30_0 and not isNil(var_30_4) and arg_27_1.var_.characterEffect1093ui_story then
				arg_27_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_27_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_30_6 = 0
			local var_30_7 = 0.8

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= var_30_6 + arg_30_0 then
				arg_27_1.talkMaxDuration = 0
				arg_27_1.dialogCg_.alpha = 1

				arg_27_1.dialog_:SetActive(true)
				SetActive(arg_27_1.leftNameGo_, true)

				arg_27_1.leftNameTxt_.text = arg_27_1:FormatText(StoryNameCfg[481].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_27_1.leftNameTxt_.transform)

				arg_27_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_27_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_27_1:RecordName(arg_27_1.leftNameTxt_.text)
				SetActive(arg_27_1.iconTrs_.gameObject, false)
				arg_27_1.callingController_:SetSelectedState("normal")

				local var_30_8 = arg_27_1:GetWordFromCfg(123452007)
				local var_30_9 = arg_27_1:FormatText(var_30_8.content)

				arg_27_1.text_.text = var_30_9

				LuaForUtil.ClearLinePrefixSymbol(arg_27_1.text_)

				local var_30_11 = 32 <= 0 and var_30_7 or var_30_7 * (utf8.len(var_30_9) / 32)

				if (32 <= 0 and var_30_7 or var_30_7 * (utf8.len(var_30_9) / 32)) > 0 and var_30_7 < var_30_11 then
					arg_27_1.talkMaxDuration = var_30_11

					if var_30_11 + var_30_6 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_11 + var_30_6
					end
				end

				arg_27_1.text_.text = var_30_9
				arg_27_1.typewritter.percent = 0

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123452", "123452007", "story_v_out_123452.awb") ~= 0 then
					local var_30_12 = manager.audio:GetVoiceLength("story_v_out_123452", "123452007", "story_v_out_123452.awb") / 1000

					if var_30_12 + var_30_6 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_12 + var_30_6
					end

					if var_30_8.prefab_name ~= "" and arg_27_1.actors_[var_30_8.prefab_name] ~= nil then
						local var_30_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_27_1.actors_[var_30_8.prefab_name].transform, "story_v_out_123452", "123452007", "story_v_out_123452.awb")

						arg_27_1:RecordAudio("123452007", var_30_13)
						arg_27_1:RecordAudio("123452007", var_30_13)
					else
						arg_27_1:AudioAction("play", "voice", "story_v_out_123452", "123452007", "story_v_out_123452.awb")
					end

					arg_27_1:RecordHistoryTalkVoice("story_v_out_123452", "123452007", "story_v_out_123452.awb")
				end

				arg_27_1:RecordContent(arg_27_1.text_.text)
			end

			local var_30_14 = math.max(var_30_7, arg_27_1.talkMaxDuration)

			if var_30_6 <= arg_27_1.time_ and arg_27_1.time_ < var_30_6 + var_30_14 then
				arg_27_1.typewritter.percent = (arg_27_1.time_ - var_30_6) / var_30_14

				arg_27_1.typewritter:SetDirty()
			end

			if arg_27_1.time_ >= var_30_6 + var_30_14 and arg_27_1.time_ < var_30_6 + var_30_14 + arg_30_0 then
				arg_27_1.typewritter.percent = 1

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(true)
			end
		end

		arg_27_1.nodeConfigList_ = {
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

		arg_27_1:InitPlayNodeList()
	end,
	Play123452008 = function(arg_31_0, arg_31_1)
		arg_31_1.time_ = 0
		arg_31_1.frameCnt_ = 0
		arg_31_1.state_ = "playing"
		arg_31_1.curTalkId_ = 123452008
		arg_31_1.duration_ = 2

		SetActive(arg_31_1.tipsGo_, false)

		function arg_31_1.onSingleLineFinish_()
			arg_31_1.onSingleLineUpdate_ = nil
			arg_31_1.onSingleLineFinish_ = nil
			arg_31_1.state_ = "waiting"
		end

		function arg_31_1.playNext_(arg_33_0)
			if arg_33_0 == 1 then
				arg_31_0:Play123452009(arg_31_1)
			end
		end

		function arg_31_1.onSingleLineUpdate_(arg_34_0)
			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 and not isNil(arg_31_1.actors_["1093ui_story"]) and arg_31_1.var_.characterEffect1093ui_story == nil then
				arg_31_1.var_.characterEffect1093ui_story = arg_31_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_34_0 = 0.200000002980232

			if 0 <= arg_31_1.time_ and arg_31_1.time_ < 0 + var_34_0 and not isNil(arg_31_1.actors_["1093ui_story"]) then
				if arg_31_1.var_.characterEffect1093ui_story and not isNil(arg_31_1.actors_["1093ui_story"]) then
					arg_31_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_31_1.time_ >= 0 + var_34_0 and arg_31_1.time_ < 0 + var_34_0 + arg_34_0 and not isNil(arg_31_1.actors_["1093ui_story"]) and arg_31_1.var_.characterEffect1093ui_story then
				arg_31_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 then
				arg_31_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action1_1")
			end

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 then
				arg_31_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_34_2 = arg_31_1.actors_["1055ui_story"]

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 and not isNil(var_34_2) and arg_31_1.var_.characterEffect1055ui_story == nil then
				arg_31_1.var_.characterEffect1055ui_story = var_34_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_34_3 = 0.200000002980232

			if 0 <= arg_31_1.time_ and arg_31_1.time_ < 0 + var_34_3 and not isNil(var_34_2) then
				if arg_31_1.var_.characterEffect1055ui_story and not isNil(var_34_2) then
					arg_31_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_31_1.var_.characterEffect1055ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_31_1.time_ - 0) / var_34_3)
				end
			end

			if arg_31_1.time_ >= 0 + var_34_3 and arg_31_1.time_ < 0 + var_34_3 + arg_34_0 and not isNil(var_34_2) and arg_31_1.var_.characterEffect1055ui_story then
				arg_31_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_31_1.var_.characterEffect1055ui_story.fillRatio = 0.5
			end

			local var_34_4 = 0
			local var_34_5 = 0.05

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= var_34_4 + arg_34_0 then
				arg_31_1.talkMaxDuration = 0
				arg_31_1.dialogCg_.alpha = 1

				arg_31_1.dialog_:SetActive(true)
				SetActive(arg_31_1.leftNameGo_, true)

				arg_31_1.leftNameTxt_.text = arg_31_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_31_1.leftNameTxt_.transform)

				arg_31_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_31_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_31_1:RecordName(arg_31_1.leftNameTxt_.text)
				SetActive(arg_31_1.iconTrs_.gameObject, false)
				arg_31_1.callingController_:SetSelectedState("normal")

				local var_34_6 = arg_31_1:GetWordFromCfg(123452008)
				local var_34_7 = arg_31_1:FormatText(var_34_6.content)

				arg_31_1.text_.text = var_34_7

				LuaForUtil.ClearLinePrefixSymbol(arg_31_1.text_)

				local var_34_9 = 2 <= 0 and var_34_5 or var_34_5 * (utf8.len(var_34_7) / 2)

				if (2 <= 0 and var_34_5 or var_34_5 * (utf8.len(var_34_7) / 2)) > 0 and var_34_5 < var_34_9 then
					arg_31_1.talkMaxDuration = var_34_9

					if var_34_9 + var_34_4 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_9 + var_34_4
					end
				end

				arg_31_1.text_.text = var_34_7
				arg_31_1.typewritter.percent = 0

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123452", "123452008", "story_v_out_123452.awb") ~= 0 then
					local var_34_10 = manager.audio:GetVoiceLength("story_v_out_123452", "123452008", "story_v_out_123452.awb") / 1000

					if var_34_10 + var_34_4 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_10 + var_34_4
					end

					if var_34_6.prefab_name ~= "" and arg_31_1.actors_[var_34_6.prefab_name] ~= nil then
						local var_34_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_31_1.actors_[var_34_6.prefab_name].transform, "story_v_out_123452", "123452008", "story_v_out_123452.awb")

						arg_31_1:RecordAudio("123452008", var_34_11)
						arg_31_1:RecordAudio("123452008", var_34_11)
					else
						arg_31_1:AudioAction("play", "voice", "story_v_out_123452", "123452008", "story_v_out_123452.awb")
					end

					arg_31_1:RecordHistoryTalkVoice("story_v_out_123452", "123452008", "story_v_out_123452.awb")
				end

				arg_31_1:RecordContent(arg_31_1.text_.text)
			end

			local var_34_12 = math.max(var_34_5, arg_31_1.talkMaxDuration)

			if var_34_4 <= arg_31_1.time_ and arg_31_1.time_ < var_34_4 + var_34_12 then
				arg_31_1.typewritter.percent = (arg_31_1.time_ - var_34_4) / var_34_12

				arg_31_1.typewritter:SetDirty()
			end

			if arg_31_1.time_ >= var_34_4 + var_34_12 and arg_31_1.time_ < var_34_4 + var_34_12 + arg_34_0 then
				arg_31_1.typewritter.percent = 1

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(true)
			end
		end

		arg_31_1.nodeConfigList_ = {}

		arg_31_1:InitPlayNodeList()
	end,
	Play123452009 = function(arg_35_0, arg_35_1)
		arg_35_1.time_ = 0
		arg_35_1.frameCnt_ = 0
		arg_35_1.state_ = "playing"
		arg_35_1.curTalkId_ = 123452009
		arg_35_1.duration_ = 16.1

		local var_35_0 = {
			zh = 14.9,
			ja = 16.1
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
				arg_35_0:Play123452010(arg_35_1)
			end
		end

		function arg_35_1.onSingleLineUpdate_(arg_38_0)
			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 and not isNil(arg_35_1.actors_["1055ui_story"]) and arg_35_1.var_.characterEffect1055ui_story == nil then
				arg_35_1.var_.characterEffect1055ui_story = arg_35_1.actors_["1055ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_38_0 = 0.200000002980232

			if 0 <= arg_35_1.time_ and arg_35_1.time_ < 0 + var_38_0 and not isNil(arg_35_1.actors_["1055ui_story"]) then
				if arg_35_1.var_.characterEffect1055ui_story and not isNil(arg_35_1.actors_["1055ui_story"]) then
					arg_35_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_35_1.time_ >= 0 + var_38_0 and arg_35_1.time_ < 0 + var_38_0 + arg_38_0 and not isNil(arg_35_1.actors_["1055ui_story"]) and arg_35_1.var_.characterEffect1055ui_story then
				arg_35_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 then
				arg_35_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action1_1")
			end

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 then
				arg_35_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_38_2 = arg_35_1.actors_["1093ui_story"]

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 and not isNil(var_38_2) and arg_35_1.var_.characterEffect1093ui_story == nil then
				arg_35_1.var_.characterEffect1093ui_story = var_38_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_38_3 = 0.200000002980232

			if 0 <= arg_35_1.time_ and arg_35_1.time_ < 0 + var_38_3 and not isNil(var_38_2) then
				if arg_35_1.var_.characterEffect1093ui_story and not isNil(var_38_2) then
					arg_35_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_35_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_35_1.time_ - 0) / var_38_3)
				end
			end

			if arg_35_1.time_ >= 0 + var_38_3 and arg_35_1.time_ < 0 + var_38_3 + arg_38_0 and not isNil(var_38_2) and arg_35_1.var_.characterEffect1093ui_story then
				arg_35_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_35_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_38_4 = 0
			local var_38_5 = 1.875

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= var_38_4 + arg_38_0 then
				arg_35_1.talkMaxDuration = 0
				arg_35_1.dialogCg_.alpha = 1

				arg_35_1.dialog_:SetActive(true)
				SetActive(arg_35_1.leftNameGo_, true)

				arg_35_1.leftNameTxt_.text = arg_35_1:FormatText(StoryNameCfg[481].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_35_1.leftNameTxt_.transform)

				arg_35_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_35_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_35_1:RecordName(arg_35_1.leftNameTxt_.text)
				SetActive(arg_35_1.iconTrs_.gameObject, false)
				arg_35_1.callingController_:SetSelectedState("normal")

				local var_38_6 = arg_35_1:GetWordFromCfg(123452009)
				local var_38_7 = arg_35_1:FormatText(var_38_6.content)

				arg_35_1.text_.text = var_38_7

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_9 = 75 <= 0 and var_38_5 or var_38_5 * (utf8.len(var_38_7) / 75)

				if (75 <= 0 and var_38_5 or var_38_5 * (utf8.len(var_38_7) / 75)) > 0 and var_38_5 < var_38_9 then
					arg_35_1.talkMaxDuration = var_38_9

					if var_38_9 + var_38_4 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_9 + var_38_4
					end
				end

				arg_35_1.text_.text = var_38_7
				arg_35_1.typewritter.percent = 0

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123452", "123452009", "story_v_out_123452.awb") ~= 0 then
					local var_38_10 = manager.audio:GetVoiceLength("story_v_out_123452", "123452009", "story_v_out_123452.awb") / 1000

					if var_38_10 + var_38_4 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_10 + var_38_4
					end

					if var_38_6.prefab_name ~= "" and arg_35_1.actors_[var_38_6.prefab_name] ~= nil then
						local var_38_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_35_1.actors_[var_38_6.prefab_name].transform, "story_v_out_123452", "123452009", "story_v_out_123452.awb")

						arg_35_1:RecordAudio("123452009", var_38_11)
						arg_35_1:RecordAudio("123452009", var_38_11)
					else
						arg_35_1:AudioAction("play", "voice", "story_v_out_123452", "123452009", "story_v_out_123452.awb")
					end

					arg_35_1:RecordHistoryTalkVoice("story_v_out_123452", "123452009", "story_v_out_123452.awb")
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

		arg_35_1.nodeConfigList_ = {}

		arg_35_1:InitPlayNodeList()
	end,
	Play123452010 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 123452010
		arg_39_1.duration_ = 9.1

		local var_39_0 = {
			zh = 7.366,
			ja = 9.1
		}
		local var_39_1 = manager.audio:GetLocalizationFlag()

		if var_39_0[var_39_1] ~= nil then
			arg_39_1.duration_ = var_39_0[var_39_1]
		end

		SetActive(arg_39_1.tipsGo_, false)

		function arg_39_1.onSingleLineFinish_()
			arg_39_1.onSingleLineUpdate_ = nil
			arg_39_1.onSingleLineFinish_ = nil
			arg_39_1.state_ = "waiting"
		end

		function arg_39_1.playNext_(arg_41_0)
			if arg_41_0 == 1 then
				arg_39_0:Play123452011(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			local var_42_0 = 0.975

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0
				arg_39_1.dialogCg_.alpha = 1

				arg_39_1.dialog_:SetActive(true)
				SetActive(arg_39_1.leftNameGo_, true)

				arg_39_1.leftNameTxt_.text = arg_39_1:FormatText(StoryNameCfg[481].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_39_1.leftNameTxt_.transform)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1.leftNameTxt_.text)
				SetActive(arg_39_1.iconTrs_.gameObject, false)
				arg_39_1.callingController_:SetSelectedState("normal")

				local var_42_1 = arg_39_1:GetWordFromCfg(123452010)
				local var_42_2 = arg_39_1:FormatText(var_42_1.content)

				arg_39_1.text_.text = var_42_2

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_4 = 39 <= 0 and var_42_0 or var_42_0 * (utf8.len(var_42_2) / 39)

				if (39 <= 0 and var_42_0 or var_42_0 * (utf8.len(var_42_2) / 39)) > 0 and var_42_0 < var_42_4 then
					arg_39_1.talkMaxDuration = var_42_4

					if var_42_4 + 0 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_4 + 0
					end
				end

				arg_39_1.text_.text = var_42_2
				arg_39_1.typewritter.percent = 0

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123452", "123452010", "story_v_out_123452.awb") ~= 0 then
					local var_42_5 = manager.audio:GetVoiceLength("story_v_out_123452", "123452010", "story_v_out_123452.awb") / 1000

					if var_42_5 + 0 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_5 + 0
					end

					if var_42_1.prefab_name ~= "" and arg_39_1.actors_[var_42_1.prefab_name] ~= nil then
						local var_42_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_39_1.actors_[var_42_1.prefab_name].transform, "story_v_out_123452", "123452010", "story_v_out_123452.awb")

						arg_39_1:RecordAudio("123452010", var_42_6)
						arg_39_1:RecordAudio("123452010", var_42_6)
					else
						arg_39_1:AudioAction("play", "voice", "story_v_out_123452", "123452010", "story_v_out_123452.awb")
					end

					arg_39_1:RecordHistoryTalkVoice("story_v_out_123452", "123452010", "story_v_out_123452.awb")
				end

				arg_39_1:RecordContent(arg_39_1.text_.text)
			end

			local var_42_7 = math.max(var_42_0, arg_39_1.talkMaxDuration)

			if 0 <= arg_39_1.time_ and arg_39_1.time_ < 0 + var_42_7 then
				arg_39_1.typewritter.percent = (arg_39_1.time_ - 0) / var_42_7

				arg_39_1.typewritter:SetDirty()
			end

			if arg_39_1.time_ >= 0 + var_42_7 and arg_39_1.time_ < 0 + var_42_7 + arg_42_0 then
				arg_39_1.typewritter.percent = 1

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(true)
			end
		end

		arg_39_1.nodeConfigList_ = {}

		arg_39_1:InitPlayNodeList()
	end,
	Play123452011 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 123452011
		arg_43_1.duration_ = 5

		SetActive(arg_43_1.tipsGo_, false)

		function arg_43_1.onSingleLineFinish_()
			arg_43_1.onSingleLineUpdate_ = nil
			arg_43_1.onSingleLineFinish_ = nil
			arg_43_1.state_ = "waiting"
		end

		function arg_43_1.playNext_(arg_45_0)
			if arg_45_0 == 1 then
				arg_43_0:Play123452012(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 and not isNil(arg_43_1.actors_["1055ui_story"]) and arg_43_1.var_.characterEffect1055ui_story == nil then
				arg_43_1.var_.characterEffect1055ui_story = arg_43_1.actors_["1055ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_46_0 = 0.2

			if 0 <= arg_43_1.time_ and arg_43_1.time_ < 0 + var_46_0 and not isNil(arg_43_1.actors_["1055ui_story"]) then
				if arg_43_1.var_.characterEffect1055ui_story and not isNil(arg_43_1.actors_["1055ui_story"]) then
					arg_43_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_43_1.var_.characterEffect1055ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_43_1.time_ - 0) / var_46_0)
				end
			end

			if arg_43_1.time_ >= 0 + var_46_0 and arg_43_1.time_ < 0 + var_46_0 + arg_46_0 and not isNil(arg_43_1.actors_["1055ui_story"]) and arg_43_1.var_.characterEffect1055ui_story then
				arg_43_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_43_1.var_.characterEffect1055ui_story.fillRatio = 0.5
			end

			local var_46_1 = 0
			local var_46_2 = 0.675

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= var_46_1 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0
				arg_43_1.dialogCg_.alpha = 1

				arg_43_1.dialog_:SetActive(true)
				SetActive(arg_43_1.leftNameGo_, false)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_43_1.iconTrs_.gameObject, false)
				arg_43_1.callingController_:SetSelectedState("normal")

				local var_46_3 = arg_43_1:FormatText(arg_43_1:GetWordFromCfg(123452011).content)

				arg_43_1.text_.text = var_46_3

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_5 = 27 <= 0 and var_46_2 or var_46_2 * (utf8.len(var_46_3) / 27)

				if (27 <= 0 and var_46_2 or var_46_2 * (utf8.len(var_46_3) / 27)) > 0 and var_46_2 < var_46_5 then
					arg_43_1.talkMaxDuration = var_46_5

					if var_46_5 + var_46_1 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_5 + var_46_1
					end
				end

				arg_43_1.text_.text = var_46_3
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)
				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_6 = math.max(var_46_2, arg_43_1.talkMaxDuration)

			if var_46_1 <= arg_43_1.time_ and arg_43_1.time_ < var_46_1 + var_46_6 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - var_46_1) / var_46_6

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= var_46_1 + var_46_6 and arg_43_1.time_ < var_46_1 + var_46_6 + arg_46_0 then
				arg_43_1.typewritter.percent = 1

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(true)
			end
		end

		arg_43_1.nodeConfigList_ = {}

		arg_43_1:InitPlayNodeList()
	end,
	Play123452012 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 123452012
		arg_47_1.duration_ = 7.57

		local var_47_0 = {
			zh = 5.766,
			ja = 7.566
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
				arg_47_0:Play123452013(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 and not isNil(arg_47_1.actors_["1093ui_story"]) and arg_47_1.var_.characterEffect1093ui_story == nil then
				arg_47_1.var_.characterEffect1093ui_story = arg_47_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_50_0 = 0.200000002980232

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_0 and not isNil(arg_47_1.actors_["1093ui_story"]) then
				if arg_47_1.var_.characterEffect1093ui_story and not isNil(arg_47_1.actors_["1093ui_story"]) then
					arg_47_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_47_1.time_ >= 0 + var_50_0 and arg_47_1.time_ < 0 + var_50_0 + arg_50_0 and not isNil(arg_47_1.actors_["1093ui_story"]) and arg_47_1.var_.characterEffect1093ui_story then
				arg_47_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			local var_50_2 = 0
			local var_50_3 = 0.65

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= var_50_2 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0
				arg_47_1.dialogCg_.alpha = 1

				arg_47_1.dialog_:SetActive(true)
				SetActive(arg_47_1.leftNameGo_, true)

				arg_47_1.leftNameTxt_.text = arg_47_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_47_1.leftNameTxt_.transform)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1.leftNameTxt_.text)
				SetActive(arg_47_1.iconTrs_.gameObject, false)
				arg_47_1.callingController_:SetSelectedState("normal")

				local var_50_4 = arg_47_1:GetWordFromCfg(123452012)
				local var_50_5 = arg_47_1:FormatText(var_50_4.content)

				arg_47_1.text_.text = var_50_5

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_7 = 26 <= 0 and var_50_3 or var_50_3 * (utf8.len(var_50_5) / 26)

				if (26 <= 0 and var_50_3 or var_50_3 * (utf8.len(var_50_5) / 26)) > 0 and var_50_3 < var_50_7 then
					arg_47_1.talkMaxDuration = var_50_7

					if var_50_7 + var_50_2 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_7 + var_50_2
					end
				end

				arg_47_1.text_.text = var_50_5
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123452", "123452012", "story_v_out_123452.awb") ~= 0 then
					local var_50_8 = manager.audio:GetVoiceLength("story_v_out_123452", "123452012", "story_v_out_123452.awb") / 1000

					if var_50_8 + var_50_2 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_8 + var_50_2
					end

					if var_50_4.prefab_name ~= "" and arg_47_1.actors_[var_50_4.prefab_name] ~= nil then
						local var_50_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_47_1.actors_[var_50_4.prefab_name].transform, "story_v_out_123452", "123452012", "story_v_out_123452.awb")

						arg_47_1:RecordAudio("123452012", var_50_9)
						arg_47_1:RecordAudio("123452012", var_50_9)
					else
						arg_47_1:AudioAction("play", "voice", "story_v_out_123452", "123452012", "story_v_out_123452.awb")
					end

					arg_47_1:RecordHistoryTalkVoice("story_v_out_123452", "123452012", "story_v_out_123452.awb")
				end

				arg_47_1:RecordContent(arg_47_1.text_.text)
			end

			local var_50_10 = math.max(var_50_3, arg_47_1.talkMaxDuration)

			if var_50_2 <= arg_47_1.time_ and arg_47_1.time_ < var_50_2 + var_50_10 then
				arg_47_1.typewritter.percent = (arg_47_1.time_ - var_50_2) / var_50_10

				arg_47_1.typewritter:SetDirty()
			end

			if arg_47_1.time_ >= var_50_2 + var_50_10 and arg_47_1.time_ < var_50_2 + var_50_10 + arg_50_0 then
				arg_47_1.typewritter.percent = 1

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(true)
			end
		end

		arg_47_1.nodeConfigList_ = {}

		arg_47_1:InitPlayNodeList()
	end,
	Play123452013 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 123452013
		arg_51_1.duration_ = 5

		SetActive(arg_51_1.tipsGo_, false)

		function arg_51_1.onSingleLineFinish_()
			arg_51_1.onSingleLineUpdate_ = nil
			arg_51_1.onSingleLineFinish_ = nil
			arg_51_1.state_ = "waiting"
		end

		function arg_51_1.playNext_(arg_53_0)
			if arg_53_0 == 1 then
				arg_51_0:Play123452014(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 then
				arg_51_1.var_.moveOldPos1093ui_story = arg_51_1.actors_["1093ui_story"].transform.localPosition
			end

			local var_54_0 = 0.001

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_0 then
				arg_51_1.actors_["1093ui_story"].transform.localPosition = Vector3.Lerp(arg_51_1.var_.moveOldPos1093ui_story, Vector3.New(0, 100, 0), (arg_51_1.time_ - 0) / var_54_0)
				arg_51_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_51_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_51_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_51_1.actors_["1093ui_story"].transform.position).z)
				arg_51_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_51_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_51_1.actors_["1093ui_story"].transform.localEulerAngles = arg_51_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if arg_51_1.time_ >= 0 + var_54_0 and arg_51_1.time_ < 0 + var_54_0 + arg_54_0 then
				arg_51_1.actors_["1093ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_51_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_51_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_51_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_51_1.actors_["1093ui_story"].transform.position).z)
				arg_51_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_51_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_51_1.actors_["1093ui_story"].transform.localEulerAngles = arg_51_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			local var_54_1 = arg_51_1.actors_["1055ui_story"].transform

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 then
				arg_51_1.var_.moveOldPos1055ui_story = var_54_1.localPosition
			end

			local var_54_2 = 0.001

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_2 then
				var_54_1.localPosition = Vector3.Lerp(arg_51_1.var_.moveOldPos1055ui_story, Vector3.New(0, 100, 0), (arg_51_1.time_ - 0) / var_54_2)
				var_54_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_54_1.position).x, (manager.ui.mainCamera.transform.position - var_54_1.position).y, (manager.ui.mainCamera.transform.position - var_54_1.position).z)
				var_54_1.localEulerAngles.z = 0
				var_54_1.localEulerAngles.x = 0
				var_54_1.localEulerAngles = var_54_1.localEulerAngles
			end

			if arg_51_1.time_ >= 0 + var_54_2 and arg_51_1.time_ < 0 + var_54_2 + arg_54_0 then
				var_54_1.localPosition = Vector3.New(0, 100, 0)
				var_54_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_54_1.position).x, (manager.ui.mainCamera.transform.position - var_54_1.position).y, (manager.ui.mainCamera.transform.position - var_54_1.position).z)
				var_54_1.localEulerAngles.z = 0
				var_54_1.localEulerAngles.x = 0
				var_54_1.localEulerAngles = var_54_1.localEulerAngles
			end

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 then
				arg_51_1:AudioAction("play", "effect", "se_story_122_01", "se_story_122_01_signal", "")
			end

			local var_54_4 = 0
			local var_54_5 = 1.7

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= var_54_4 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, false)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_51_1.iconTrs_.gameObject, false)
				arg_51_1.callingController_:SetSelectedState("normal")

				local var_54_6 = arg_51_1:FormatText(arg_51_1:GetWordFromCfg(123452013).content)

				arg_51_1.text_.text = var_54_6

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_8 = 68 <= 0 and var_54_5 or var_54_5 * (utf8.len(var_54_6) / 68)

				if (68 <= 0 and var_54_5 or var_54_5 * (utf8.len(var_54_6) / 68)) > 0 and var_54_5 < var_54_8 then
					arg_51_1.talkMaxDuration = var_54_8

					if var_54_8 + var_54_4 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_8 + var_54_4
					end
				end

				arg_51_1.text_.text = var_54_6
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)
				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_9 = math.max(var_54_5, arg_51_1.talkMaxDuration)

			if var_54_4 <= arg_51_1.time_ and arg_51_1.time_ < var_54_4 + var_54_9 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - var_54_4) / var_54_9

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= var_54_4 + var_54_9 and arg_51_1.time_ < var_54_4 + var_54_9 + arg_54_0 then
				arg_51_1.typewritter.percent = 1

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(true)
			end
		end

		arg_51_1.nodeConfigList_ = {
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

		arg_51_1:InitPlayNodeList()
	end,
	Play123452014 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 123452014
		arg_55_1.duration_ = 3.33

		local var_55_0 = {
			zh = 3.333,
			ja = 3.033
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
				arg_55_0:Play123452015(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 then
				arg_55_1.var_.moveOldPos1093ui_story = arg_55_1.actors_["1093ui_story"].transform.localPosition
			end

			local var_58_0 = 0.001

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_0 then
				arg_55_1.actors_["1093ui_story"].transform.localPosition = Vector3.Lerp(arg_55_1.var_.moveOldPos1093ui_story, Vector3.New(-0.7, -1.11, -5.88), (arg_55_1.time_ - 0) / var_58_0)
				arg_55_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_55_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_55_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_55_1.actors_["1093ui_story"].transform.position).z)
				arg_55_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_55_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_55_1.actors_["1093ui_story"].transform.localEulerAngles = arg_55_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if arg_55_1.time_ >= 0 + var_58_0 and arg_55_1.time_ < 0 + var_58_0 + arg_58_0 then
				arg_55_1.actors_["1093ui_story"].transform.localPosition = Vector3.New(-0.7, -1.11, -5.88)
				arg_55_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_55_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_55_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_55_1.actors_["1093ui_story"].transform.position).z)
				arg_55_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_55_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_55_1.actors_["1093ui_story"].transform.localEulerAngles = arg_55_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			local var_58_1 = arg_55_1.actors_["1093ui_story"]

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 and not isNil(var_58_1) and arg_55_1.var_.characterEffect1093ui_story == nil then
				arg_55_1.var_.characterEffect1093ui_story = var_58_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_58_2 = 0.200000002980232

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_2 and not isNil(var_58_1) then
				if arg_55_1.var_.characterEffect1093ui_story and not isNil(var_58_1) then
					arg_55_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_55_1.time_ >= 0 + var_58_2 and arg_55_1.time_ < 0 + var_58_2 + arg_58_0 and not isNil(var_58_1) and arg_55_1.var_.characterEffect1093ui_story then
				arg_55_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 then
				arg_55_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action2_1")
			end

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 then
				arg_55_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_58_4 = 0
			local var_58_5 = 0.325

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= var_58_4 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, true)

				arg_55_1.leftNameTxt_.text = arg_55_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_55_1.leftNameTxt_.transform)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1.leftNameTxt_.text)
				SetActive(arg_55_1.iconTrs_.gameObject, false)
				arg_55_1.callingController_:SetSelectedState("normal")

				local var_58_6 = arg_55_1:GetWordFromCfg(123452014)
				local var_58_7 = arg_55_1:FormatText(var_58_6.content)

				arg_55_1.text_.text = var_58_7

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_9 = 13 <= 0 and var_58_5 or var_58_5 * (utf8.len(var_58_7) / 13)

				if (13 <= 0 and var_58_5 or var_58_5 * (utf8.len(var_58_7) / 13)) > 0 and var_58_5 < var_58_9 then
					arg_55_1.talkMaxDuration = var_58_9

					if var_58_9 + var_58_4 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_9 + var_58_4
					end
				end

				arg_55_1.text_.text = var_58_7
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123452", "123452014", "story_v_out_123452.awb") ~= 0 then
					local var_58_10 = manager.audio:GetVoiceLength("story_v_out_123452", "123452014", "story_v_out_123452.awb") / 1000

					if var_58_10 + var_58_4 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_10 + var_58_4
					end

					if var_58_6.prefab_name ~= "" and arg_55_1.actors_[var_58_6.prefab_name] ~= nil then
						local var_58_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_55_1.actors_[var_58_6.prefab_name].transform, "story_v_out_123452", "123452014", "story_v_out_123452.awb")

						arg_55_1:RecordAudio("123452014", var_58_11)
						arg_55_1:RecordAudio("123452014", var_58_11)
					else
						arg_55_1:AudioAction("play", "voice", "story_v_out_123452", "123452014", "story_v_out_123452.awb")
					end

					arg_55_1:RecordHistoryTalkVoice("story_v_out_123452", "123452014", "story_v_out_123452.awb")
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
				actorName = "1093ui_story",
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
	Play123452015 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 123452015
		arg_59_1.duration_ = 2.07

		local var_59_0 = {
			zh = 1.4,
			ja = 2.066
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
				arg_59_0:Play123452016(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 then
				arg_59_1.var_.moveOldPos1055ui_story = arg_59_1.actors_["1055ui_story"].transform.localPosition
			end

			local var_62_0 = 0.001

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_0 then
				arg_59_1.actors_["1055ui_story"].transform.localPosition = Vector3.Lerp(arg_59_1.var_.moveOldPos1055ui_story, Vector3.New(0.7, -0.965, -6.2), (arg_59_1.time_ - 0) / var_62_0)
				arg_59_1.actors_["1055ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_59_1.actors_["1055ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_59_1.actors_["1055ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_59_1.actors_["1055ui_story"].transform.position).z)
				arg_59_1.actors_["1055ui_story"].transform.localEulerAngles.z = 0
				arg_59_1.actors_["1055ui_story"].transform.localEulerAngles.x = 0
				arg_59_1.actors_["1055ui_story"].transform.localEulerAngles = arg_59_1.actors_["1055ui_story"].transform.localEulerAngles
			end

			if arg_59_1.time_ >= 0 + var_62_0 and arg_59_1.time_ < 0 + var_62_0 + arg_62_0 then
				arg_59_1.actors_["1055ui_story"].transform.localPosition = Vector3.New(0.7, -0.965, -6.2)
				arg_59_1.actors_["1055ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_59_1.actors_["1055ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_59_1.actors_["1055ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_59_1.actors_["1055ui_story"].transform.position).z)
				arg_59_1.actors_["1055ui_story"].transform.localEulerAngles.z = 0
				arg_59_1.actors_["1055ui_story"].transform.localEulerAngles.x = 0
				arg_59_1.actors_["1055ui_story"].transform.localEulerAngles = arg_59_1.actors_["1055ui_story"].transform.localEulerAngles
			end

			local var_62_1 = arg_59_1.actors_["1055ui_story"]

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 and not isNil(var_62_1) and arg_59_1.var_.characterEffect1055ui_story == nil then
				arg_59_1.var_.characterEffect1055ui_story = var_62_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_62_2 = 0.200000002980232

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_2 and not isNil(var_62_1) then
				if arg_59_1.var_.characterEffect1055ui_story and not isNil(var_62_1) then
					arg_59_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_59_1.time_ >= 0 + var_62_2 and arg_59_1.time_ < 0 + var_62_2 + arg_62_0 and not isNil(var_62_1) and arg_59_1.var_.characterEffect1055ui_story then
				arg_59_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 then
				arg_59_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action1_1")
			end

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 then
				arg_59_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_62_4 = arg_59_1.actors_["1093ui_story"]

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 and not isNil(var_62_4) and arg_59_1.var_.characterEffect1093ui_story == nil then
				arg_59_1.var_.characterEffect1093ui_story = var_62_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_62_5 = 0.200000002980232

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_5 and not isNil(var_62_4) then
				if arg_59_1.var_.characterEffect1093ui_story and not isNil(var_62_4) then
					arg_59_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_59_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_59_1.time_ - 0) / var_62_5)
				end
			end

			if arg_59_1.time_ >= 0 + var_62_5 and arg_59_1.time_ < 0 + var_62_5 + arg_62_0 and not isNil(var_62_4) and arg_59_1.var_.characterEffect1093ui_story then
				arg_59_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_59_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_62_6 = 0
			local var_62_7 = 0.175

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= var_62_6 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, true)

				arg_59_1.leftNameTxt_.text = arg_59_1:FormatText(StoryNameCfg[481].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_59_1.leftNameTxt_.transform)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1.leftNameTxt_.text)
				SetActive(arg_59_1.iconTrs_.gameObject, false)
				arg_59_1.callingController_:SetSelectedState("normal")

				local var_62_8 = arg_59_1:GetWordFromCfg(123452015)
				local var_62_9 = arg_59_1:FormatText(var_62_8.content)

				arg_59_1.text_.text = var_62_9

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_11 = 7 <= 0 and var_62_7 or var_62_7 * (utf8.len(var_62_9) / 7)

				if (7 <= 0 and var_62_7 or var_62_7 * (utf8.len(var_62_9) / 7)) > 0 and var_62_7 < var_62_11 then
					arg_59_1.talkMaxDuration = var_62_11

					if var_62_11 + var_62_6 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_11 + var_62_6
					end
				end

				arg_59_1.text_.text = var_62_9
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123452", "123452015", "story_v_out_123452.awb") ~= 0 then
					local var_62_12 = manager.audio:GetVoiceLength("story_v_out_123452", "123452015", "story_v_out_123452.awb") / 1000

					if var_62_12 + var_62_6 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_12 + var_62_6
					end

					if var_62_8.prefab_name ~= "" and arg_59_1.actors_[var_62_8.prefab_name] ~= nil then
						local var_62_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_59_1.actors_[var_62_8.prefab_name].transform, "story_v_out_123452", "123452015", "story_v_out_123452.awb")

						arg_59_1:RecordAudio("123452015", var_62_13)
						arg_59_1:RecordAudio("123452015", var_62_13)
					else
						arg_59_1:AudioAction("play", "voice", "story_v_out_123452", "123452015", "story_v_out_123452.awb")
					end

					arg_59_1:RecordHistoryTalkVoice("story_v_out_123452", "123452015", "story_v_out_123452.awb")
				end

				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_14 = math.max(var_62_7, arg_59_1.talkMaxDuration)

			if var_62_6 <= arg_59_1.time_ and arg_59_1.time_ < var_62_6 + var_62_14 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - var_62_6) / var_62_14

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= var_62_6 + var_62_14 and arg_59_1.time_ < var_62_6 + var_62_14 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end

		arg_59_1.nodeConfigList_ = {
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

		arg_59_1:InitPlayNodeList()
	end,
	Play123452016 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 123452016
		arg_63_1.duration_ = 5

		SetActive(arg_63_1.tipsGo_, false)

		function arg_63_1.onSingleLineFinish_()
			arg_63_1.onSingleLineUpdate_ = nil
			arg_63_1.onSingleLineFinish_ = nil
			arg_63_1.state_ = "waiting"
		end

		function arg_63_1.playNext_(arg_65_0)
			if arg_65_0 == 1 then
				arg_63_0:Play123452017(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 and not isNil(arg_63_1.actors_["1055ui_story"]) and arg_63_1.var_.characterEffect1055ui_story == nil then
				arg_63_1.var_.characterEffect1055ui_story = arg_63_1.actors_["1055ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_66_0 = 0.200000002980232

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_0 and not isNil(arg_63_1.actors_["1055ui_story"]) then
				if arg_63_1.var_.characterEffect1055ui_story and not isNil(arg_63_1.actors_["1055ui_story"]) then
					arg_63_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_63_1.var_.characterEffect1055ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_63_1.time_ - 0) / var_66_0)
				end
			end

			if arg_63_1.time_ >= 0 + var_66_0 and arg_63_1.time_ < 0 + var_66_0 + arg_66_0 and not isNil(arg_63_1.actors_["1055ui_story"]) and arg_63_1.var_.characterEffect1055ui_story then
				arg_63_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_63_1.var_.characterEffect1055ui_story.fillRatio = 0.5
			end

			local var_66_1 = 0
			local var_66_2 = 0.8

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= var_66_1 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, false)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_63_1.iconTrs_.gameObject, false)
				arg_63_1.callingController_:SetSelectedState("normal")

				local var_66_3 = arg_63_1:FormatText(arg_63_1:GetWordFromCfg(123452016).content)

				arg_63_1.text_.text = var_66_3

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_5 = 32 <= 0 and var_66_2 or var_66_2 * (utf8.len(var_66_3) / 32)

				if (32 <= 0 and var_66_2 or var_66_2 * (utf8.len(var_66_3) / 32)) > 0 and var_66_2 < var_66_5 then
					arg_63_1.talkMaxDuration = var_66_5

					if var_66_5 + var_66_1 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_5 + var_66_1
					end
				end

				arg_63_1.text_.text = var_66_3
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)
				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_6 = math.max(var_66_2, arg_63_1.talkMaxDuration)

			if var_66_1 <= arg_63_1.time_ and arg_63_1.time_ < var_66_1 + var_66_6 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - var_66_1) / var_66_6

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= var_66_1 + var_66_6 and arg_63_1.time_ < var_66_1 + var_66_6 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end

		arg_63_1.nodeConfigList_ = {}

		arg_63_1:InitPlayNodeList()
	end,
	Play123452017 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 123452017
		arg_67_1.duration_ = 4.23

		local var_67_0 = {
			zh = 4.033,
			ja = 4.233
		}
		local var_67_1 = manager.audio:GetLocalizationFlag()

		if var_67_0[var_67_1] ~= nil then
			arg_67_1.duration_ = var_67_0[var_67_1]
		end

		SetActive(arg_67_1.tipsGo_, false)

		function arg_67_1.onSingleLineFinish_()
			arg_67_1.onSingleLineUpdate_ = nil
			arg_67_1.onSingleLineFinish_ = nil
			arg_67_1.state_ = "waiting"
			arg_67_1.auto_ = false
		end

		function arg_67_1.playNext_(arg_69_0)
			arg_67_1.onStoryFinished_()
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 and not isNil(arg_67_1.actors_["1093ui_story"]) and arg_67_1.var_.characterEffect1093ui_story == nil then
				arg_67_1.var_.characterEffect1093ui_story = arg_67_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_70_0 = 0.200000002980232

			if 0 <= arg_67_1.time_ and arg_67_1.time_ < 0 + var_70_0 and not isNil(arg_67_1.actors_["1093ui_story"]) then
				if arg_67_1.var_.characterEffect1093ui_story and not isNil(arg_67_1.actors_["1093ui_story"]) then
					arg_67_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_67_1.time_ >= 0 + var_70_0 and arg_67_1.time_ < 0 + var_70_0 + arg_70_0 and not isNil(arg_67_1.actors_["1093ui_story"]) and arg_67_1.var_.characterEffect1093ui_story then
				arg_67_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 then
				arg_67_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action2_2")
			end

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 then
				arg_67_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_70_2 = 0
			local var_70_3 = 0.375

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= var_70_2 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, true)

				arg_67_1.leftNameTxt_.text = arg_67_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_67_1.leftNameTxt_.transform)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1.leftNameTxt_.text)
				SetActive(arg_67_1.iconTrs_.gameObject, false)
				arg_67_1.callingController_:SetSelectedState("normal")

				local var_70_4 = arg_67_1:GetWordFromCfg(123452017)
				local var_70_5 = arg_67_1:FormatText(var_70_4.content)

				arg_67_1.text_.text = var_70_5

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_7 = 15 <= 0 and var_70_3 or var_70_3 * (utf8.len(var_70_5) / 15)

				if (15 <= 0 and var_70_3 or var_70_3 * (utf8.len(var_70_5) / 15)) > 0 and var_70_3 < var_70_7 then
					arg_67_1.talkMaxDuration = var_70_7

					if var_70_7 + var_70_2 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_7 + var_70_2
					end
				end

				arg_67_1.text_.text = var_70_5
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123452", "123452017", "story_v_out_123452.awb") ~= 0 then
					local var_70_8 = manager.audio:GetVoiceLength("story_v_out_123452", "123452017", "story_v_out_123452.awb") / 1000

					if var_70_8 + var_70_2 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_8 + var_70_2
					end

					if var_70_4.prefab_name ~= "" and arg_67_1.actors_[var_70_4.prefab_name] ~= nil then
						local var_70_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_67_1.actors_[var_70_4.prefab_name].transform, "story_v_out_123452", "123452017", "story_v_out_123452.awb")

						arg_67_1:RecordAudio("123452017", var_70_9)
						arg_67_1:RecordAudio("123452017", var_70_9)
					else
						arg_67_1:AudioAction("play", "voice", "story_v_out_123452", "123452017", "story_v_out_123452.awb")
					end

					arg_67_1:RecordHistoryTalkVoice("story_v_out_123452", "123452017", "story_v_out_123452.awb")
				end

				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_10 = math.max(var_70_3, arg_67_1.talkMaxDuration)

			if var_70_2 <= arg_67_1.time_ and arg_67_1.time_ < var_70_2 + var_70_10 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - var_70_2) / var_70_10

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= var_70_2 + var_70_10 and arg_67_1.time_ < var_70_2 + var_70_10 + arg_70_0 then
				arg_67_1.typewritter.percent = 1

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(true)
			end
		end

		arg_67_1.nodeConfigList_ = {}

		arg_67_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/K07g"
	},
	voices = {
		"story_v_out_123452.awb"
	}
}
