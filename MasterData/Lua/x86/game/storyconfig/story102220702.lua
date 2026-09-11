return {
	Play222072001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 222072001
		arg_1_1.duration_ = 11.63

		local var_1_0 = {
			ja = 9.865999999999,
			ko = 11.632999999999,
			zh = 11.632999999999
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
				arg_1_0:Play222072002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.ST52 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST52")
				var_4_0.name = "ST52"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.ST52 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.ST52

				arg_1_1.bgs_.ST52.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "ST52" then
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

			if 0.9 < arg_1_1.time_ and arg_1_1.time_ <= 0.9 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_2_2_story_ruomuhuajing", "bgm_activity_2_2_story_ruomuhuajing", "bgm_activity_2_2_story_ruomuhuajing.awb")

				local var_4_13 = manager.audio:GetAudioName("bgm_activity_2_2_story_ruomuhuajing", "bgm_activity_2_2_story_ruomuhuajing")

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

			local var_4_14 = 1.999999999999
			local var_4_15 = 0.8

			if 1.999999999999 < arg_1_1.time_ and arg_1_1.time_ <= var_4_14 + arg_4_0 then
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

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1074_1")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_17 = arg_1_1:GetWordFromCfg(222072001)
				local var_4_18 = arg_1_1:FormatText(var_4_17.content)

				arg_1_1.text_.text = var_4_18

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_20 = 32 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_18) / 32)

				if (32 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_18) / 32)) > 0 and var_4_15 < var_4_20 then
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

				if manager.audio:GetVoiceLength("story_v_out_222072", "222072001", "story_v_out_222072.awb") ~= 0 then
					local var_4_21 = manager.audio:GetVoiceLength("story_v_out_222072", "222072001", "story_v_out_222072.awb") / 1000

					if var_4_21 + var_4_14 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_21 + var_4_14
					end

					if var_4_17.prefab_name ~= "" and arg_1_1.actors_[var_4_17.prefab_name] ~= nil then
						local var_4_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_17.prefab_name].transform, "story_v_out_222072", "222072001", "story_v_out_222072.awb")

						arg_1_1:RecordAudio("222072001", var_4_22)
						arg_1_1:RecordAudio("222072001", var_4_22)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_222072", "222072001", "story_v_out_222072.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_222072", "222072001", "story_v_out_222072.awb")
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
	Play222072002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 222072002
		arg_9_1.duration_ = 6.47

		local var_9_0 = {
			ja = 6.466,
			ko = 3.4,
			zh = 3.433
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
				arg_9_0:Play222072003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			if arg_9_1.actors_["1074ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1074ui_story"))) then
				local var_12_0 = Object.Instantiate(Asset.Load("Char/" .. "1074ui_story"), arg_9_1.stage_.transform)

				var_12_0.name = "1074ui_story"
				var_12_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_9_1.actors_["1074ui_story"] = var_12_0

				local var_12_1 = var_12_0:GetComponentInChildren(typeof(CharacterEffect))

				var_12_1.enabled = true

				local var_12_2 = GameObjectTools.GetOrAddComponent(var_12_0, typeof(DynamicBoneHelper))

				if var_12_2 then
					var_12_2:EnableDynamicBone(false)
				end

				arg_9_1:ShowWeapon(var_12_1.transform, false)

				arg_9_1.var_["1074ui_story" .. "Animator"] = var_12_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_9_1.var_["1074ui_story" .. "Animator"].applyRootMotion = true
				arg_9_1.var_["1074ui_story" .. "LipSync"] = var_12_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_12_3 = arg_9_1.actors_["1074ui_story"].transform

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.var_.moveOldPos1074ui_story = var_12_3.localPosition
			end

			local var_12_4 = 0.001

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_4 then
				var_12_3.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos1074ui_story, Vector3.New(0, -1.055, -6.12), (arg_9_1.time_ - 0) / var_12_4)
				var_12_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_12_3.position).x, (manager.ui.mainCamera.transform.position - var_12_3.position).y, (manager.ui.mainCamera.transform.position - var_12_3.position).z)
				var_12_3.localEulerAngles.z = 0
				var_12_3.localEulerAngles.x = 0
				var_12_3.localEulerAngles = var_12_3.localEulerAngles
			end

			if arg_9_1.time_ >= 0 + var_12_4 and arg_9_1.time_ < 0 + var_12_4 + arg_12_0 then
				var_12_3.localPosition = Vector3.New(0, -1.055, -6.12)
				var_12_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_12_3.position).x, (manager.ui.mainCamera.transform.position - var_12_3.position).y, (manager.ui.mainCamera.transform.position - var_12_3.position).z)
				var_12_3.localEulerAngles.z = 0
				var_12_3.localEulerAngles.x = 0
				var_12_3.localEulerAngles = var_12_3.localEulerAngles
			end

			local var_12_5 = arg_9_1.actors_["1074ui_story"]

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 and not isNil(var_12_5) and arg_9_1.var_.characterEffect1074ui_story == nil then
				arg_9_1.var_.characterEffect1074ui_story = var_12_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_6 = 0.200000002980232

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_6 and not isNil(var_12_5) then
				if arg_9_1.var_.characterEffect1074ui_story and not isNil(var_12_5) then
					arg_9_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_9_1.time_ >= 0 + var_12_6 and arg_9_1.time_ < 0 + var_12_6 + arg_12_0 and not isNil(var_12_5) and arg_9_1.var_.characterEffect1074ui_story then
				arg_9_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action1_1")
			end

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_12_8 = 0
			local var_12_9 = 0.3

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_8 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				arg_9_1.leftNameTxt_.text = arg_9_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_10 = arg_9_1:GetWordFromCfg(222072002)
				local var_12_11 = arg_9_1:FormatText(var_12_10.content)

				arg_9_1.text_.text = var_12_11

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_13 = 12 <= 0 and var_12_9 or var_12_9 * (utf8.len(var_12_11) / 12)

				if (12 <= 0 and var_12_9 or var_12_9 * (utf8.len(var_12_11) / 12)) > 0 and var_12_9 < var_12_13 then
					arg_9_1.talkMaxDuration = var_12_13

					if var_12_13 + var_12_8 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_13 + var_12_8
					end
				end

				arg_9_1.text_.text = var_12_11
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222072", "222072002", "story_v_out_222072.awb") ~= 0 then
					local var_12_14 = manager.audio:GetVoiceLength("story_v_out_222072", "222072002", "story_v_out_222072.awb") / 1000

					if var_12_14 + var_12_8 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_14 + var_12_8
					end

					if var_12_10.prefab_name ~= "" and arg_9_1.actors_[var_12_10.prefab_name] ~= nil then
						local var_12_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_10.prefab_name].transform, "story_v_out_222072", "222072002", "story_v_out_222072.awb")

						arg_9_1:RecordAudio("222072002", var_12_15)
						arg_9_1:RecordAudio("222072002", var_12_15)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_222072", "222072002", "story_v_out_222072.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_222072", "222072002", "story_v_out_222072.awb")
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
				actorName = "1074ui_story",
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
	Play222072003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 222072003
		arg_13_1.duration_ = 11

		local var_13_0 = {
			ja = 11,
			ko = 6.233,
			zh = 6.233
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
				arg_13_0:Play222072004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(arg_13_1.actors_["1074ui_story"]) and arg_13_1.var_.characterEffect1074ui_story == nil then
				arg_13_1.var_.characterEffect1074ui_story = arg_13_1.actors_["1074ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_0 = 0.200000002980232

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_0 and not isNil(arg_13_1.actors_["1074ui_story"]) then
				if arg_13_1.var_.characterEffect1074ui_story and not isNil(arg_13_1.actors_["1074ui_story"]) then
					arg_13_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_13_1.var_.characterEffect1074ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_13_1.time_ - 0) / var_16_0)
				end
			end

			if arg_13_1.time_ >= 0 + var_16_0 and arg_13_1.time_ < 0 + var_16_0 + arg_16_0 and not isNil(arg_13_1.actors_["1074ui_story"]) and arg_13_1.var_.characterEffect1074ui_story then
				arg_13_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_13_1.var_.characterEffect1074ui_story.fillRatio = 0.5
			end

			local var_16_1 = 0
			local var_16_2 = 0.625

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_1 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, true)
				arg_13_1.iconController_:SetSelectedState("hero")

				arg_13_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1074_1")

				arg_13_1.callingController_:SetSelectedState("normal")

				arg_13_1.keyicon_.color = Color.New(1, 1, 1)
				arg_13_1.icon_.color = Color.New(1, 1, 1)

				local var_16_3 = arg_13_1:GetWordFromCfg(222072003)
				local var_16_4 = arg_13_1:FormatText(var_16_3.content)

				arg_13_1.text_.text = var_16_4

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_6 = 25 <= 0 and var_16_2 or var_16_2 * (utf8.len(var_16_4) / 25)

				if (25 <= 0 and var_16_2 or var_16_2 * (utf8.len(var_16_4) / 25)) > 0 and var_16_2 < var_16_6 then
					arg_13_1.talkMaxDuration = var_16_6

					if var_16_6 + var_16_1 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_6 + var_16_1
					end
				end

				arg_13_1.text_.text = var_16_4
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222072", "222072003", "story_v_out_222072.awb") ~= 0 then
					local var_16_7 = manager.audio:GetVoiceLength("story_v_out_222072", "222072003", "story_v_out_222072.awb") / 1000

					if var_16_7 + var_16_1 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_7 + var_16_1
					end

					if var_16_3.prefab_name ~= "" and arg_13_1.actors_[var_16_3.prefab_name] ~= nil then
						local var_16_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_3.prefab_name].transform, "story_v_out_222072", "222072003", "story_v_out_222072.awb")

						arg_13_1:RecordAudio("222072003", var_16_8)
						arg_13_1:RecordAudio("222072003", var_16_8)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_222072", "222072003", "story_v_out_222072.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_222072", "222072003", "story_v_out_222072.awb")
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
	Play222072004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 222072004
		arg_17_1.duration_ = 12.77

		local var_17_0 = {
			ja = 12.766,
			ko = 7.8,
			zh = 7.833
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
				arg_17_0:Play222072005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(arg_17_1.actors_["1074ui_story"]) and arg_17_1.var_.characterEffect1074ui_story == nil then
				arg_17_1.var_.characterEffect1074ui_story = arg_17_1.actors_["1074ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_0 = 0.200000002980232

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_0 and not isNil(arg_17_1.actors_["1074ui_story"]) then
				if arg_17_1.var_.characterEffect1074ui_story and not isNil(arg_17_1.actors_["1074ui_story"]) then
					arg_17_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_17_1.time_ >= 0 + var_20_0 and arg_17_1.time_ < 0 + var_20_0 + arg_20_0 and not isNil(arg_17_1.actors_["1074ui_story"]) and arg_17_1.var_.characterEffect1074ui_story then
				arg_17_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action5_1")
			end

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_20_2 = 0
			local var_20_3 = 0.875

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_2 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_4 = arg_17_1:GetWordFromCfg(222072004)
				local var_20_5 = arg_17_1:FormatText(var_20_4.content)

				arg_17_1.text_.text = var_20_5

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_7 = 35 <= 0 and var_20_3 or var_20_3 * (utf8.len(var_20_5) / 35)

				if (35 <= 0 and var_20_3 or var_20_3 * (utf8.len(var_20_5) / 35)) > 0 and var_20_3 < var_20_7 then
					arg_17_1.talkMaxDuration = var_20_7

					if var_20_7 + var_20_2 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_7 + var_20_2
					end
				end

				arg_17_1.text_.text = var_20_5
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222072", "222072004", "story_v_out_222072.awb") ~= 0 then
					local var_20_8 = manager.audio:GetVoiceLength("story_v_out_222072", "222072004", "story_v_out_222072.awb") / 1000

					if var_20_8 + var_20_2 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_8 + var_20_2
					end

					if var_20_4.prefab_name ~= "" and arg_17_1.actors_[var_20_4.prefab_name] ~= nil then
						local var_20_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_4.prefab_name].transform, "story_v_out_222072", "222072004", "story_v_out_222072.awb")

						arg_17_1:RecordAudio("222072004", var_20_9)
						arg_17_1:RecordAudio("222072004", var_20_9)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_222072", "222072004", "story_v_out_222072.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_222072", "222072004", "story_v_out_222072.awb")
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
	Play222072005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 222072005
		arg_21_1.duration_ = 10.97

		local var_21_0 = {
			ja = 10.966,
			ko = 9.133,
			zh = 9.133
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
				arg_21_0:Play222072006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = 0.925

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_1 = arg_21_1:GetWordFromCfg(222072005)
				local var_24_2 = arg_21_1:FormatText(var_24_1.content)

				arg_21_1.text_.text = var_24_2

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_4 = 37 <= 0 and var_24_0 or var_24_0 * (utf8.len(var_24_2) / 37)

				if (37 <= 0 and var_24_0 or var_24_0 * (utf8.len(var_24_2) / 37)) > 0 and var_24_0 < var_24_4 then
					arg_21_1.talkMaxDuration = var_24_4

					if var_24_4 + 0 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_4 + 0
					end
				end

				arg_21_1.text_.text = var_24_2
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222072", "222072005", "story_v_out_222072.awb") ~= 0 then
					local var_24_5 = manager.audio:GetVoiceLength("story_v_out_222072", "222072005", "story_v_out_222072.awb") / 1000

					if var_24_5 + 0 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_5 + 0
					end

					if var_24_1.prefab_name ~= "" and arg_21_1.actors_[var_24_1.prefab_name] ~= nil then
						local var_24_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_1.prefab_name].transform, "story_v_out_222072", "222072005", "story_v_out_222072.awb")

						arg_21_1:RecordAudio("222072005", var_24_6)
						arg_21_1:RecordAudio("222072005", var_24_6)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_222072", "222072005", "story_v_out_222072.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_222072", "222072005", "story_v_out_222072.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_7 = math.max(var_24_0, arg_21_1.talkMaxDuration)

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_7 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - 0) / var_24_7

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= 0 + var_24_7 and arg_21_1.time_ < 0 + var_24_7 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play222072006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 222072006
		arg_25_1.duration_ = 23.4

		local var_25_0 = {
			ja = 23.4,
			ko = 16.566,
			zh = 16.6
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
				arg_25_0:Play222072007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0202cva")
			end

			local var_28_0 = 0
			local var_28_1 = 1.35

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_0 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_2 = arg_25_1:GetWordFromCfg(222072006)
				local var_28_3 = arg_25_1:FormatText(var_28_2.content)

				arg_25_1.text_.text = var_28_3

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_5 = 54 <= 0 and var_28_1 or var_28_1 * (utf8.len(var_28_3) / 54)

				if (54 <= 0 and var_28_1 or var_28_1 * (utf8.len(var_28_3) / 54)) > 0 and var_28_1 < var_28_5 then
					arg_25_1.talkMaxDuration = var_28_5

					if var_28_5 + var_28_0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_5 + var_28_0
					end
				end

				arg_25_1.text_.text = var_28_3
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222072", "222072006", "story_v_out_222072.awb") ~= 0 then
					local var_28_6 = manager.audio:GetVoiceLength("story_v_out_222072", "222072006", "story_v_out_222072.awb") / 1000

					if var_28_6 + var_28_0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_6 + var_28_0
					end

					if var_28_2.prefab_name ~= "" and arg_25_1.actors_[var_28_2.prefab_name] ~= nil then
						local var_28_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_2.prefab_name].transform, "story_v_out_222072", "222072006", "story_v_out_222072.awb")

						arg_25_1:RecordAudio("222072006", var_28_7)
						arg_25_1:RecordAudio("222072006", var_28_7)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_222072", "222072006", "story_v_out_222072.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_222072", "222072006", "story_v_out_222072.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_8 = math.max(var_28_1, arg_25_1.talkMaxDuration)

			if var_28_0 <= arg_25_1.time_ and arg_25_1.time_ < var_28_0 + var_28_8 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_0) / var_28_8

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_0 + var_28_8 and arg_25_1.time_ < var_28_0 + var_28_8 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play222072007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 222072007
		arg_29_1.duration_ = 4.83

		local var_29_0 = {
			ja = 4.833,
			ko = 4.5,
			zh = 4.4
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
				arg_29_0:Play222072008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_32_0 = 0
			local var_32_1 = 0.5

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_0 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_2 = arg_29_1:GetWordFromCfg(222072007)
				local var_32_3 = arg_29_1:FormatText(var_32_2.content)

				arg_29_1.text_.text = var_32_3

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_5 = 20 <= 0 and var_32_1 or var_32_1 * (utf8.len(var_32_3) / 20)

				if (20 <= 0 and var_32_1 or var_32_1 * (utf8.len(var_32_3) / 20)) > 0 and var_32_1 < var_32_5 then
					arg_29_1.talkMaxDuration = var_32_5

					if var_32_5 + var_32_0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_5 + var_32_0
					end
				end

				arg_29_1.text_.text = var_32_3
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222072", "222072007", "story_v_out_222072.awb") ~= 0 then
					local var_32_6 = manager.audio:GetVoiceLength("story_v_out_222072", "222072007", "story_v_out_222072.awb") / 1000

					if var_32_6 + var_32_0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_6 + var_32_0
					end

					if var_32_2.prefab_name ~= "" and arg_29_1.actors_[var_32_2.prefab_name] ~= nil then
						local var_32_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_2.prefab_name].transform, "story_v_out_222072", "222072007", "story_v_out_222072.awb")

						arg_29_1:RecordAudio("222072007", var_32_7)
						arg_29_1:RecordAudio("222072007", var_32_7)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_222072", "222072007", "story_v_out_222072.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_222072", "222072007", "story_v_out_222072.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_8 = math.max(var_32_1, arg_29_1.talkMaxDuration)

			if var_32_0 <= arg_29_1.time_ and arg_29_1.time_ < var_32_0 + var_32_8 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_0) / var_32_8

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_0 + var_32_8 and arg_29_1.time_ < var_32_0 + var_32_8 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play222072008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 222072008
		arg_33_1.duration_ = 5

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play222072009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1.var_.moveOldPos1074ui_story = arg_33_1.actors_["1074ui_story"].transform.localPosition
			end

			local var_36_0 = 0.001

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_0 then
				arg_33_1.actors_["1074ui_story"].transform.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos1074ui_story, Vector3.New(0, 100, 0), (arg_33_1.time_ - 0) / var_36_0)
				arg_33_1.actors_["1074ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_33_1.actors_["1074ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["1074ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["1074ui_story"].transform.position).z)
				arg_33_1.actors_["1074ui_story"].transform.localEulerAngles.z = 0
				arg_33_1.actors_["1074ui_story"].transform.localEulerAngles.x = 0
				arg_33_1.actors_["1074ui_story"].transform.localEulerAngles = arg_33_1.actors_["1074ui_story"].transform.localEulerAngles
			end

			if arg_33_1.time_ >= 0 + var_36_0 and arg_33_1.time_ < 0 + var_36_0 + arg_36_0 then
				arg_33_1.actors_["1074ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_33_1.actors_["1074ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_33_1.actors_["1074ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["1074ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["1074ui_story"].transform.position).z)
				arg_33_1.actors_["1074ui_story"].transform.localEulerAngles.z = 0
				arg_33_1.actors_["1074ui_story"].transform.localEulerAngles.x = 0
				arg_33_1.actors_["1074ui_story"].transform.localEulerAngles = arg_33_1.actors_["1074ui_story"].transform.localEulerAngles
			end

			local var_36_1 = arg_33_1.actors_["1074ui_story"]

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(var_36_1) and arg_33_1.var_.characterEffect1074ui_story == nil then
				arg_33_1.var_.characterEffect1074ui_story = var_36_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_2 = 0.200000002980232

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_2 and not isNil(var_36_1) then
				if arg_33_1.var_.characterEffect1074ui_story and not isNil(var_36_1) then
					arg_33_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_33_1.var_.characterEffect1074ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_33_1.time_ - 0) / var_36_2)
				end
			end

			if arg_33_1.time_ >= 0 + var_36_2 and arg_33_1.time_ < 0 + var_36_2 + arg_36_0 and not isNil(var_36_1) and arg_33_1.var_.characterEffect1074ui_story then
				arg_33_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_33_1.var_.characterEffect1074ui_story.fillRatio = 0.5
			end

			local var_36_3 = 0
			local var_36_4 = 1.4

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_3 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, false)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_5 = arg_33_1:FormatText(arg_33_1:GetWordFromCfg(222072008).content)

				arg_33_1.text_.text = var_36_5

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_7 = 56 <= 0 and var_36_4 or var_36_4 * (utf8.len(var_36_5) / 56)

				if (56 <= 0 and var_36_4 or var_36_4 * (utf8.len(var_36_5) / 56)) > 0 and var_36_4 < var_36_7 then
					arg_33_1.talkMaxDuration = var_36_7

					if var_36_7 + var_36_3 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_7 + var_36_3
					end
				end

				arg_33_1.text_.text = var_36_5
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)
				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_8 = math.max(var_36_4, arg_33_1.talkMaxDuration)

			if var_36_3 <= arg_33_1.time_ and arg_33_1.time_ < var_36_3 + var_36_8 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_3) / var_36_8

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_3 + var_36_8 and arg_33_1.time_ < var_36_3 + var_36_8 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074ui_story",
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
	Play222072009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 222072009
		arg_37_1.duration_ = 9

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play222072010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_9000

			if arg_37_1.bgs_.J03g == nil then
				local var_40_0 = Object.Instantiate(arg_37_1.paintGo_)

				var_40_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "J03g")
				var_40_0.name = "J03g"
				var_40_0.transform.parent = arg_37_1.stage_.transform
				var_40_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_37_1.bgs_.J03g = var_40_0
			end

			if 1.999999999999 < arg_37_1.time_ and arg_37_1.time_ <= 1.999999999999 + arg_40_0 then
				local var_40_1 = arg_37_1.bgs_.J03g

				arg_37_1.bgs_.J03g.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_40_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_40_2 = var_40_1:GetComponent("SpriteRenderer")

				if var_40_2 and var_40_2.sprite then
					local var_40_3 = 2 * (var_40_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_40_1.transform.localScale = Vector3.New(var_40_3 / var_40_2.sprite.bounds.size.y < var_40_3 * manager.ui.mainCameraCom_.aspect / var_40_2.sprite.bounds.size.x and var_40_3 * manager.ui.mainCameraCom_.aspect / var_40_2.sprite.bounds.size.x or var_40_3 / var_40_2.sprite.bounds.size.y, var_40_3 / var_40_2.sprite.bounds.size.y < var_40_3 * manager.ui.mainCameraCom_.aspect / var_40_2.sprite.bounds.size.x and var_40_3 * manager.ui.mainCameraCom_.aspect / var_40_2.sprite.bounds.size.x or var_40_3 / var_40_2.sprite.bounds.size.y, 0)
				end

				for iter_40_0, iter_40_1 in pairs(arg_37_1.bgs_) do
					if iter_40_0 ~= "J03g" then
						iter_40_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_40_4 = 0

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_4 + arg_40_0 then
				arg_37_1.mask_.enabled = true
				arg_37_1.mask_.raycastTarget = true

				arg_37_1:SetGaussion(false)
			end

			local var_40_5 = 2

			if var_40_4 <= arg_37_1.time_ and arg_37_1.time_ < var_40_4 + var_40_5 then
				local var_40_6 = Color.New(0, 0, 0)

				var_40_6.a = Mathf.Lerp(0, 1, (arg_37_1.time_ - var_40_4) / var_40_5)
				arg_37_1.mask_.color = var_40_6
			end

			if arg_37_1.time_ >= var_40_4 + var_40_5 and arg_37_1.time_ < var_40_4 + var_40_5 + arg_40_0 then
				local var_40_7 = Color.New(0, 0, 0)

				var_40_7.a = 1
				arg_37_1.mask_.color = var_40_7
			end

			local var_40_8 = 2

			if 2 < arg_37_1.time_ and arg_37_1.time_ <= var_40_8 + arg_40_0 then
				arg_37_1.mask_.enabled = true
				arg_37_1.mask_.raycastTarget = true

				arg_37_1:SetGaussion(false)
			end

			local var_40_9 = 2

			if var_40_8 <= arg_37_1.time_ and arg_37_1.time_ < var_40_8 + var_40_9 then
				local var_40_10 = Color.New(0, 0, 0)

				var_40_10.a = Mathf.Lerp(1, 0, (arg_37_1.time_ - var_40_8) / var_40_9)
				arg_37_1.mask_.color = var_40_10
			end

			if arg_37_1.time_ >= var_40_8 + var_40_9 and arg_37_1.time_ < var_40_8 + var_40_9 + arg_40_0 then
				local var_40_11 = Color.New(0, 0, 0)

				arg_37_1.mask_.enabled = false
				var_40_11.a = 0
				arg_37_1.mask_.color = var_40_11
			end

			if 2 < arg_37_1.time_ and arg_37_1.time_ <= 2 + arg_40_0 then
				arg_37_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_40_14 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_37_1.bgmTxt_.text ~= var_40_14 and arg_37_1.bgmTxt_.text ~= "" then
						if arg_37_1.bgmTxt2_.text ~= "" then
							arg_37_1.bgmTxt_.text = arg_37_1.bgmTxt2_.text
						end

						arg_37_1.bgmTxt2_.text = var_40_14

						arg_37_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_37_1.bgmTxt_.text = var_40_14
						arg_37_1.bgmTxt2_.text = var_40_14
					end

					if arg_37_1.bgmTimer then
						arg_37_1.bgmTimer:Stop()

						arg_37_1.bgmTimer = nil
					end

					if arg_37_1.settingData.show_music_name == 1 then
						arg_37_1.musicController:SetSelectedState("show")
						arg_37_1.musicAnimator_:Play("open", 0, 0)

						if arg_37_1.settingData.music_time ~= 0 then
							arg_37_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_37_1.settingData.music_time), function()
								if arg_37_1 == nil or isNil(arg_37_1.bgmTxt_) then
									return
								end

								arg_37_1.musicController:SetSelectedState("hide")
								arg_37_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 2.3 < arg_37_1.time_ and arg_37_1.time_ <= 2.3 + arg_40_0 then
				arg_37_1:AudioAction("play", "music", "bgm_activity_2_0_story_jingdu", "bgm_activity_2_0_story_jingdu", "bgm_activity_2_0_story_jingdu.awb")

				local var_40_17 = manager.audio:GetAudioName("bgm_activity_2_0_story_jingdu", "bgm_activity_2_0_story_jingdu")

				if "" ~= "" then
					if arg_37_1.bgmTxt_.text ~= var_40_17 and arg_37_1.bgmTxt_.text ~= "" then
						if arg_37_1.bgmTxt2_.text ~= "" then
							arg_37_1.bgmTxt_.text = arg_37_1.bgmTxt2_.text
						end

						arg_37_1.bgmTxt2_.text = var_40_17

						arg_37_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_37_1.bgmTxt_.text = var_40_17
						arg_37_1.bgmTxt2_.text = var_40_17
					end

					if arg_37_1.bgmTimer then
						arg_37_1.bgmTimer:Stop()

						arg_37_1.bgmTimer = nil
					end

					if arg_37_1.settingData.show_music_name == 1 then
						arg_37_1.musicController:SetSelectedState("show")
						arg_37_1.musicAnimator_:Play("open", 0, 0)

						if arg_37_1.settingData.music_time ~= 0 then
							arg_37_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_37_1.settingData.music_time), function()
								if arg_37_1 == nil or isNil(arg_37_1.bgmTxt_) then
									return
								end

								arg_37_1.musicController:SetSelectedState("hide")
								arg_37_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				local var_40_18 = arg_37_1.var_.effecthuanjing1

				if not arg_37_1.var_.effecthuanjing1 then
					var_40_18 = Object.Instantiate(Asset.Load("Effect/Scene/fx_ripple"), manager.ui.mainCamera.transform)
					var_40_18.name = "huanjing1"
					arg_37_1.var_.effecthuanjing1 = var_40_18
				else
					var_40_18.transform:SetParent(var_40_9000)
				end

				var_40_18.transform.localPosition = Vector3.New(0, 0, 0)
				var_40_18.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 2 < arg_37_1.time_ and arg_37_1.time_ <= 2 + arg_40_0 then
				if arg_37_1.var_.effecthuanjing1 then
					Object.Destroy(arg_37_1.var_.effecthuanjing1)

					arg_37_1.var_.effecthuanjing1 = nil
				end
			end

			local var_40_21 = "1071ui_story"

			if arg_37_1.actors_["1071ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1071ui_story"))) then
				local var_40_22 = Object.Instantiate(Asset.Load("Char/" .. "1071ui_story"), arg_37_1.stage_.transform)

				var_40_22.name = var_40_21
				var_40_22.transform.localPosition = Vector3.New(0, 100, 0)
				arg_37_1.actors_[var_40_21] = var_40_22

				local var_40_23 = var_40_22:GetComponentInChildren(typeof(CharacterEffect))

				var_40_23.enabled = true

				local var_40_24 = GameObjectTools.GetOrAddComponent(var_40_22, typeof(DynamicBoneHelper))

				if var_40_24 then
					var_40_24:EnableDynamicBone(false)
				end

				arg_37_1:ShowWeapon(var_40_23.transform, false)

				arg_37_1.var_[var_40_21 .. "Animator"] = var_40_23.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_37_1.var_[var_40_21 .. "Animator"].applyRootMotion = true
				arg_37_1.var_[var_40_21 .. "LipSync"] = var_40_23.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva")
			end

			if arg_37_1.frameCnt_ <= 1 then
				arg_37_1.dialog_:SetActive(false)
			end

			local var_40_25 = 4
			local var_40_26 = 1.2

			if 4 < arg_37_1.time_ and arg_37_1.time_ <= var_40_25 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0

				arg_37_1.dialog_:SetActive(true)

				arg_37_1.dialogCg_.alpha = 0

				local var_40_27 = LeanTween.value(arg_37_1.dialog_, 0, 1, 0.3)

				var_40_27:setOnUpdate(LuaHelper.FloatAction(function(arg_43_0)
					arg_37_1.dialogCg_.alpha = arg_43_0
				end))
				var_40_27:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_37_1.dialog_)
					var_40_27:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_37_1.duration_ = arg_37_1.duration_ + 0.3

				SetActive(arg_37_1.leftNameGo_, false)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_28 = arg_37_1:FormatText(arg_37_1:GetWordFromCfg(222072009).content)

				arg_37_1.text_.text = var_40_28

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_30 = 48 <= 0 and var_40_26 or var_40_26 * (utf8.len(var_40_28) / 48)

				if (48 <= 0 and var_40_26 or var_40_26 * (utf8.len(var_40_28) / 48)) > 0 and var_40_26 < var_40_30 then
					arg_37_1.talkMaxDuration = var_40_30
					var_40_25 = var_40_25 + 0.3

					if var_40_30 + var_40_25 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_30 + var_40_25
					end
				end

				arg_37_1.text_.text = var_40_28
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)
				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_31 = var_40_25 + 0.3
			local var_40_32 = math.max(var_40_26, arg_37_1.talkMaxDuration)

			if var_40_25 + 0.3 <= arg_37_1.time_ and arg_37_1.time_ < var_40_31 + var_40_32 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_31) / var_40_32

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_31 + var_40_32 and arg_37_1.time_ < var_40_31 + var_40_32 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play222072010 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 222072010
		arg_45_1.duration_ = 4.77

		local var_45_0 = {
			ja = 4.766,
			ko = 2.8,
			zh = 2.8
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
				arg_45_0:Play222072011(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1.var_.moveOldPos1071ui_story = arg_45_1.actors_["1071ui_story"].transform.localPosition
			end

			local var_48_0 = 0.001

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_0 then
				arg_45_1.actors_["1071ui_story"].transform.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos1071ui_story, Vector3.New(-0.7, -1.05, -6.2), (arg_45_1.time_ - 0) / var_48_0)
				arg_45_1.actors_["1071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_45_1.actors_["1071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_45_1.actors_["1071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_45_1.actors_["1071ui_story"].transform.position).z)
				arg_45_1.actors_["1071ui_story"].transform.localEulerAngles.z = 0
				arg_45_1.actors_["1071ui_story"].transform.localEulerAngles.x = 0
				arg_45_1.actors_["1071ui_story"].transform.localEulerAngles = arg_45_1.actors_["1071ui_story"].transform.localEulerAngles
			end

			if arg_45_1.time_ >= 0 + var_48_0 and arg_45_1.time_ < 0 + var_48_0 + arg_48_0 then
				arg_45_1.actors_["1071ui_story"].transform.localPosition = Vector3.New(-0.7, -1.05, -6.2)
				arg_45_1.actors_["1071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_45_1.actors_["1071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_45_1.actors_["1071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_45_1.actors_["1071ui_story"].transform.position).z)
				arg_45_1.actors_["1071ui_story"].transform.localEulerAngles.z = 0
				arg_45_1.actors_["1071ui_story"].transform.localEulerAngles.x = 0
				arg_45_1.actors_["1071ui_story"].transform.localEulerAngles = arg_45_1.actors_["1071ui_story"].transform.localEulerAngles
			end

			local var_48_1 = arg_45_1.actors_["1071ui_story"]

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 and not isNil(var_48_1) and arg_45_1.var_.characterEffect1071ui_story == nil then
				arg_45_1.var_.characterEffect1071ui_story = var_48_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_2 = 0.200000002980232

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_2 and not isNil(var_48_1) then
				if arg_45_1.var_.characterEffect1071ui_story and not isNil(var_48_1) then
					arg_45_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_45_1.time_ >= 0 + var_48_2 and arg_45_1.time_ < 0 + var_48_2 + arg_48_0 and not isNil(var_48_1) and arg_45_1.var_.characterEffect1071ui_story then
				arg_45_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action1_1")
			end

			local var_48_4 = "1070ui_story"

			if arg_45_1.actors_["1070ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1070ui_story"))) then
				local var_48_5 = Object.Instantiate(Asset.Load("Char/" .. "1070ui_story"), arg_45_1.stage_.transform)

				var_48_5.name = var_48_4
				var_48_5.transform.localPosition = Vector3.New(0, 100, 0)
				arg_45_1.actors_[var_48_4] = var_48_5

				local var_48_6 = var_48_5:GetComponentInChildren(typeof(CharacterEffect))

				var_48_6.enabled = true

				local var_48_7 = GameObjectTools.GetOrAddComponent(var_48_5, typeof(DynamicBoneHelper))

				if var_48_7 then
					var_48_7:EnableDynamicBone(false)
				end

				arg_45_1:ShowWeapon(var_48_6.transform, false)

				arg_45_1.var_[var_48_4 .. "Animator"] = var_48_6.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_45_1.var_[var_48_4 .. "Animator"].applyRootMotion = true
				arg_45_1.var_[var_48_4 .. "LipSync"] = var_48_6.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_48_8 = arg_45_1.actors_["1070ui_story"].transform

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1.var_.moveOldPos1070ui_story = var_48_8.localPosition
			end

			local var_48_9 = 0.001

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_9 then
				var_48_8.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos1070ui_story, Vector3.New(0.7, -0.95, -6.05), (arg_45_1.time_ - 0) / var_48_9)
				var_48_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_48_8.position).x, (manager.ui.mainCamera.transform.position - var_48_8.position).y, (manager.ui.mainCamera.transform.position - var_48_8.position).z)
				var_48_8.localEulerAngles.z = 0
				var_48_8.localEulerAngles.x = 0
				var_48_8.localEulerAngles = var_48_8.localEulerAngles
			end

			if arg_45_1.time_ >= 0 + var_48_9 and arg_45_1.time_ < 0 + var_48_9 + arg_48_0 then
				var_48_8.localPosition = Vector3.New(0.7, -0.95, -6.05)
				var_48_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_48_8.position).x, (manager.ui.mainCamera.transform.position - var_48_8.position).y, (manager.ui.mainCamera.transform.position - var_48_8.position).z)
				var_48_8.localEulerAngles.z = 0
				var_48_8.localEulerAngles.x = 0
				var_48_8.localEulerAngles = var_48_8.localEulerAngles
			end

			local var_48_10 = arg_45_1.actors_["1070ui_story"]

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 and not isNil(var_48_10) and arg_45_1.var_.characterEffect1070ui_story == nil then
				arg_45_1.var_.characterEffect1070ui_story = var_48_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_11 = 0.200000002980232

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_11 and not isNil(var_48_10) then
				if arg_45_1.var_.characterEffect1070ui_story and not isNil(var_48_10) then
					arg_45_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_45_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_45_1.time_ - 0) / var_48_11)
				end
			end

			if arg_45_1.time_ >= 0 + var_48_11 and arg_45_1.time_ < 0 + var_48_11 + arg_48_0 and not isNil(var_48_10) and arg_45_1.var_.characterEffect1070ui_story then
				arg_45_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_45_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_48_12 = 0
			local var_48_13 = 0.25

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_12 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				arg_45_1.leftNameTxt_.text = arg_45_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_14 = arg_45_1:GetWordFromCfg(222072010)
				local var_48_15 = arg_45_1:FormatText(var_48_14.content)

				arg_45_1.text_.text = var_48_15

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_17 = 10 <= 0 and var_48_13 or var_48_13 * (utf8.len(var_48_15) / 10)

				if (10 <= 0 and var_48_13 or var_48_13 * (utf8.len(var_48_15) / 10)) > 0 and var_48_13 < var_48_17 then
					arg_45_1.talkMaxDuration = var_48_17

					if var_48_17 + var_48_12 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_17 + var_48_12
					end
				end

				arg_45_1.text_.text = var_48_15
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222072", "222072010", "story_v_out_222072.awb") ~= 0 then
					local var_48_18 = manager.audio:GetVoiceLength("story_v_out_222072", "222072010", "story_v_out_222072.awb") / 1000

					if var_48_18 + var_48_12 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_18 + var_48_12
					end

					if var_48_14.prefab_name ~= "" and arg_45_1.actors_[var_48_14.prefab_name] ~= nil then
						local var_48_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_14.prefab_name].transform, "story_v_out_222072", "222072010", "story_v_out_222072.awb")

						arg_45_1:RecordAudio("222072010", var_48_19)
						arg_45_1:RecordAudio("222072010", var_48_19)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_222072", "222072010", "story_v_out_222072.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_222072", "222072010", "story_v_out_222072.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_20 = math.max(var_48_13, arg_45_1.talkMaxDuration)

			if var_48_12 <= arg_45_1.time_ and arg_45_1.time_ < var_48_12 + var_48_20 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_12) / var_48_20

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_12 + var_48_20 and arg_45_1.time_ < var_48_12 + var_48_20 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1070ui_story",
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
	Play222072011 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 222072011
		arg_49_1.duration_ = 5.5

		local var_49_0 = {
			ja = 5.5,
			ko = 3.566,
			zh = 3.566
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
				arg_49_0:Play222072012(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 and not isNil(arg_49_1.actors_["1070ui_story"]) and arg_49_1.var_.characterEffect1070ui_story == nil then
				arg_49_1.var_.characterEffect1070ui_story = arg_49_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_0 = 0.200000002980232

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_0 and not isNil(arg_49_1.actors_["1070ui_story"]) then
				if arg_49_1.var_.characterEffect1070ui_story and not isNil(arg_49_1.actors_["1070ui_story"]) then
					arg_49_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_49_1.time_ >= 0 + var_52_0 and arg_49_1.time_ < 0 + var_52_0 + arg_52_0 and not isNil(arg_49_1.actors_["1070ui_story"]) and arg_49_1.var_.characterEffect1070ui_story then
				arg_49_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action1_1")
			end

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_52_2 = arg_49_1.actors_["1071ui_story"]

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 and not isNil(var_52_2) and arg_49_1.var_.characterEffect1071ui_story == nil then
				arg_49_1.var_.characterEffect1071ui_story = var_52_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_3 = 0.200000002980232

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_3 and not isNil(var_52_2) then
				if arg_49_1.var_.characterEffect1071ui_story and not isNil(var_52_2) then
					arg_49_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_49_1.var_.characterEffect1071ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_49_1.time_ - 0) / var_52_3)
				end
			end

			if arg_49_1.time_ >= 0 + var_52_3 and arg_49_1.time_ < 0 + var_52_3 + arg_52_0 and not isNil(var_52_2) and arg_49_1.var_.characterEffect1071ui_story then
				arg_49_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_49_1.var_.characterEffect1071ui_story.fillRatio = 0.5
			end

			local var_52_4 = 0
			local var_52_5 = 0.5

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_4 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				arg_49_1.leftNameTxt_.text = arg_49_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_6 = arg_49_1:GetWordFromCfg(222072011)
				local var_52_7 = arg_49_1:FormatText(var_52_6.content)

				arg_49_1.text_.text = var_52_7

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_9 = 19 <= 0 and var_52_5 or var_52_5 * (utf8.len(var_52_7) / 19)

				if (19 <= 0 and var_52_5 or var_52_5 * (utf8.len(var_52_7) / 19)) > 0 and var_52_5 < var_52_9 then
					arg_49_1.talkMaxDuration = var_52_9

					if var_52_9 + var_52_4 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_9 + var_52_4
					end
				end

				arg_49_1.text_.text = var_52_7
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222072", "222072011", "story_v_out_222072.awb") ~= 0 then
					local var_52_10 = manager.audio:GetVoiceLength("story_v_out_222072", "222072011", "story_v_out_222072.awb") / 1000

					if var_52_10 + var_52_4 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_10 + var_52_4
					end

					if var_52_6.prefab_name ~= "" and arg_49_1.actors_[var_52_6.prefab_name] ~= nil then
						local var_52_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_6.prefab_name].transform, "story_v_out_222072", "222072011", "story_v_out_222072.awb")

						arg_49_1:RecordAudio("222072011", var_52_11)
						arg_49_1:RecordAudio("222072011", var_52_11)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_222072", "222072011", "story_v_out_222072.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_222072", "222072011", "story_v_out_222072.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_12 = math.max(var_52_5, arg_49_1.talkMaxDuration)

			if var_52_4 <= arg_49_1.time_ and arg_49_1.time_ < var_52_4 + var_52_12 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_4) / var_52_12

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_4 + var_52_12 and arg_49_1.time_ < var_52_4 + var_52_12 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play222072012 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 222072012
		arg_53_1.duration_ = 8.27

		local var_53_0 = {
			ja = 8.266,
			ko = 4.3,
			zh = 4.3
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
				arg_53_0:Play222072013(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1.var_.moveOldPos1071ui_story = arg_53_1.actors_["1071ui_story"].transform.localPosition
			end

			local var_56_0 = 0.001

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_0 then
				arg_53_1.actors_["1071ui_story"].transform.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos1071ui_story, Vector3.New(0, 100, 0), (arg_53_1.time_ - 0) / var_56_0)
				arg_53_1.actors_["1071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_53_1.actors_["1071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["1071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["1071ui_story"].transform.position).z)
				arg_53_1.actors_["1071ui_story"].transform.localEulerAngles.z = 0
				arg_53_1.actors_["1071ui_story"].transform.localEulerAngles.x = 0
				arg_53_1.actors_["1071ui_story"].transform.localEulerAngles = arg_53_1.actors_["1071ui_story"].transform.localEulerAngles
			end

			if arg_53_1.time_ >= 0 + var_56_0 and arg_53_1.time_ < 0 + var_56_0 + arg_56_0 then
				arg_53_1.actors_["1071ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_53_1.actors_["1071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_53_1.actors_["1071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["1071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["1071ui_story"].transform.position).z)
				arg_53_1.actors_["1071ui_story"].transform.localEulerAngles.z = 0
				arg_53_1.actors_["1071ui_story"].transform.localEulerAngles.x = 0
				arg_53_1.actors_["1071ui_story"].transform.localEulerAngles = arg_53_1.actors_["1071ui_story"].transform.localEulerAngles
			end

			local var_56_1 = arg_53_1.actors_["1071ui_story"]

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 and not isNil(var_56_1) and arg_53_1.var_.characterEffect1071ui_story == nil then
				arg_53_1.var_.characterEffect1071ui_story = var_56_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_2 = 0.200000002980232

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_2 and not isNil(var_56_1) then
				if arg_53_1.var_.characterEffect1071ui_story and not isNil(var_56_1) then
					arg_53_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_53_1.var_.characterEffect1071ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_53_1.time_ - 0) / var_56_2)
				end
			end

			if arg_53_1.time_ >= 0 + var_56_2 and arg_53_1.time_ < 0 + var_56_2 + arg_56_0 and not isNil(var_56_1) and arg_53_1.var_.characterEffect1071ui_story then
				arg_53_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_53_1.var_.characterEffect1071ui_story.fillRatio = 0.5
			end

			local var_56_3 = arg_53_1.actors_["1074ui_story"].transform

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1.var_.moveOldPos1074ui_story = var_56_3.localPosition
			end

			local var_56_4 = 0.001

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_4 then
				var_56_3.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos1074ui_story, Vector3.New(-0.7, -1.055, -6.12), (arg_53_1.time_ - 0) / var_56_4)
				var_56_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_56_3.position).x, (manager.ui.mainCamera.transform.position - var_56_3.position).y, (manager.ui.mainCamera.transform.position - var_56_3.position).z)
				var_56_3.localEulerAngles.z = 0
				var_56_3.localEulerAngles.x = 0
				var_56_3.localEulerAngles = var_56_3.localEulerAngles
			end

			if arg_53_1.time_ >= 0 + var_56_4 and arg_53_1.time_ < 0 + var_56_4 + arg_56_0 then
				var_56_3.localPosition = Vector3.New(-0.7, -1.055, -6.12)
				var_56_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_56_3.position).x, (manager.ui.mainCamera.transform.position - var_56_3.position).y, (manager.ui.mainCamera.transform.position - var_56_3.position).z)
				var_56_3.localEulerAngles.z = 0
				var_56_3.localEulerAngles.x = 0
				var_56_3.localEulerAngles = var_56_3.localEulerAngles
			end

			local var_56_5 = arg_53_1.actors_["1074ui_story"]

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 and not isNil(var_56_5) and arg_53_1.var_.characterEffect1074ui_story == nil then
				arg_53_1.var_.characterEffect1074ui_story = var_56_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_6 = 0.200000002980232

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_6 and not isNil(var_56_5) then
				if arg_53_1.var_.characterEffect1074ui_story and not isNil(var_56_5) then
					arg_53_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_53_1.time_ >= 0 + var_56_6 and arg_53_1.time_ < 0 + var_56_6 + arg_56_0 and not isNil(var_56_5) and arg_53_1.var_.characterEffect1074ui_story then
				arg_53_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action1_1")
			end

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_56_8 = arg_53_1.actors_["1070ui_story"]

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 and not isNil(var_56_8) and arg_53_1.var_.characterEffect1070ui_story == nil then
				arg_53_1.var_.characterEffect1070ui_story = var_56_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_9 = 0.200000002980232

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_9 and not isNil(var_56_8) then
				if arg_53_1.var_.characterEffect1070ui_story and not isNil(var_56_8) then
					arg_53_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_53_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_53_1.time_ - 0) / var_56_9)
				end
			end

			if arg_53_1.time_ >= 0 + var_56_9 and arg_53_1.time_ < 0 + var_56_9 + arg_56_0 and not isNil(var_56_8) and arg_53_1.var_.characterEffect1070ui_story then
				arg_53_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_53_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_56_10 = 0
			local var_56_11 = 0.35

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_10 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				arg_53_1.leftNameTxt_.text = arg_53_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_12 = arg_53_1:GetWordFromCfg(222072012)
				local var_56_13 = arg_53_1:FormatText(var_56_12.content)

				arg_53_1.text_.text = var_56_13

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_15 = 14 <= 0 and var_56_11 or var_56_11 * (utf8.len(var_56_13) / 14)

				if (14 <= 0 and var_56_11 or var_56_11 * (utf8.len(var_56_13) / 14)) > 0 and var_56_11 < var_56_15 then
					arg_53_1.talkMaxDuration = var_56_15

					if var_56_15 + var_56_10 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_15 + var_56_10
					end
				end

				arg_53_1.text_.text = var_56_13
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222072", "222072012", "story_v_out_222072.awb") ~= 0 then
					local var_56_16 = manager.audio:GetVoiceLength("story_v_out_222072", "222072012", "story_v_out_222072.awb") / 1000

					if var_56_16 + var_56_10 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_16 + var_56_10
					end

					if var_56_12.prefab_name ~= "" and arg_53_1.actors_[var_56_12.prefab_name] ~= nil then
						local var_56_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_12.prefab_name].transform, "story_v_out_222072", "222072012", "story_v_out_222072.awb")

						arg_53_1:RecordAudio("222072012", var_56_17)
						arg_53_1:RecordAudio("222072012", var_56_17)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_222072", "222072012", "story_v_out_222072.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_222072", "222072012", "story_v_out_222072.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_18 = math.max(var_56_11, arg_53_1.talkMaxDuration)

			if var_56_10 <= arg_53_1.time_ and arg_53_1.time_ < var_56_10 + var_56_18 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_10) / var_56_18

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_10 + var_56_18 and arg_53_1.time_ < var_56_10 + var_56_18 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1074ui_story",
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
	Play222072013 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 222072013
		arg_57_1.duration_ = 5

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play222072014(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1.var_.moveOldPos1074ui_story = arg_57_1.actors_["1074ui_story"].transform.localPosition
			end

			local var_60_0 = 0.001

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_0 then
				arg_57_1.actors_["1074ui_story"].transform.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos1074ui_story, Vector3.New(0, 100, 0), (arg_57_1.time_ - 0) / var_60_0)
				arg_57_1.actors_["1074ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_57_1.actors_["1074ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["1074ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["1074ui_story"].transform.position).z)
				arg_57_1.actors_["1074ui_story"].transform.localEulerAngles.z = 0
				arg_57_1.actors_["1074ui_story"].transform.localEulerAngles.x = 0
				arg_57_1.actors_["1074ui_story"].transform.localEulerAngles = arg_57_1.actors_["1074ui_story"].transform.localEulerAngles
			end

			if arg_57_1.time_ >= 0 + var_60_0 and arg_57_1.time_ < 0 + var_60_0 + arg_60_0 then
				arg_57_1.actors_["1074ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_57_1.actors_["1074ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_57_1.actors_["1074ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["1074ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["1074ui_story"].transform.position).z)
				arg_57_1.actors_["1074ui_story"].transform.localEulerAngles.z = 0
				arg_57_1.actors_["1074ui_story"].transform.localEulerAngles.x = 0
				arg_57_1.actors_["1074ui_story"].transform.localEulerAngles = arg_57_1.actors_["1074ui_story"].transform.localEulerAngles
			end

			local var_60_1 = arg_57_1.actors_["1074ui_story"]

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 and not isNil(var_60_1) and arg_57_1.var_.characterEffect1074ui_story == nil then
				arg_57_1.var_.characterEffect1074ui_story = var_60_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_2 = 0.200000002980232

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_2 and not isNil(var_60_1) then
				if arg_57_1.var_.characterEffect1074ui_story and not isNil(var_60_1) then
					arg_57_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_57_1.var_.characterEffect1074ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_57_1.time_ - 0) / var_60_2)
				end
			end

			if arg_57_1.time_ >= 0 + var_60_2 and arg_57_1.time_ < 0 + var_60_2 + arg_60_0 and not isNil(var_60_1) and arg_57_1.var_.characterEffect1074ui_story then
				arg_57_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_57_1.var_.characterEffect1074ui_story.fillRatio = 0.5
			end

			local var_60_3 = arg_57_1.actors_["1070ui_story"].transform

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1.var_.moveOldPos1070ui_story = var_60_3.localPosition
			end

			local var_60_4 = 0.001

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_4 then
				var_60_3.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos1070ui_story, Vector3.New(0, 100, 0), (arg_57_1.time_ - 0) / var_60_4)
				var_60_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_60_3.position).x, (manager.ui.mainCamera.transform.position - var_60_3.position).y, (manager.ui.mainCamera.transform.position - var_60_3.position).z)
				var_60_3.localEulerAngles.z = 0
				var_60_3.localEulerAngles.x = 0
				var_60_3.localEulerAngles = var_60_3.localEulerAngles
			end

			if arg_57_1.time_ >= 0 + var_60_4 and arg_57_1.time_ < 0 + var_60_4 + arg_60_0 then
				var_60_3.localPosition = Vector3.New(0, 100, 0)
				var_60_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_60_3.position).x, (manager.ui.mainCamera.transform.position - var_60_3.position).y, (manager.ui.mainCamera.transform.position - var_60_3.position).z)
				var_60_3.localEulerAngles.z = 0
				var_60_3.localEulerAngles.x = 0
				var_60_3.localEulerAngles = var_60_3.localEulerAngles
			end

			local var_60_5 = arg_57_1.actors_["1070ui_story"]

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 and not isNil(var_60_5) and arg_57_1.var_.characterEffect1070ui_story == nil then
				arg_57_1.var_.characterEffect1070ui_story = var_60_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_6 = 0.200000002980232

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_6 and not isNil(var_60_5) then
				if arg_57_1.var_.characterEffect1070ui_story and not isNil(var_60_5) then
					arg_57_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_57_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_57_1.time_ - 0) / var_60_6)
				end
			end

			if arg_57_1.time_ >= 0 + var_60_6 and arg_57_1.time_ < 0 + var_60_6 + arg_60_0 and not isNil(var_60_5) and arg_57_1.var_.characterEffect1070ui_story then
				arg_57_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_57_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_60_7 = 0
			local var_60_8 = 1.025

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_7 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, false)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_9 = arg_57_1:FormatText(arg_57_1:GetWordFromCfg(222072013).content)

				arg_57_1.text_.text = var_60_9

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_11 = 41 <= 0 and var_60_8 or var_60_8 * (utf8.len(var_60_9) / 41)

				if (41 <= 0 and var_60_8 or var_60_8 * (utf8.len(var_60_9) / 41)) > 0 and var_60_8 < var_60_11 then
					arg_57_1.talkMaxDuration = var_60_11

					if var_60_11 + var_60_7 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_11 + var_60_7
					end
				end

				arg_57_1.text_.text = var_60_9
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)
				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_12 = math.max(var_60_8, arg_57_1.talkMaxDuration)

			if var_60_7 <= arg_57_1.time_ and arg_57_1.time_ < var_60_7 + var_60_12 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_7) / var_60_12

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_7 + var_60_12 and arg_57_1.time_ < var_60_7 + var_60_12 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_57_1:InitPlayNodeList()
	end,
	Play222072014 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 222072014
		arg_61_1.duration_ = 5

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play222072015(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = 1.175

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

				local var_64_1 = arg_61_1:FormatText(arg_61_1:GetWordFromCfg(222072014).content)

				arg_61_1.text_.text = var_64_1

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_3 = 47 <= 0 and var_64_0 or var_64_0 * (utf8.len(var_64_1) / 47)

				if (47 <= 0 and var_64_0 or var_64_0 * (utf8.len(var_64_1) / 47)) > 0 and var_64_0 < var_64_3 then
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
	Play222072015 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 222072015
		arg_65_1.duration_ = 9.6

		local var_65_0 = {
			ja = 9.6,
			ko = 3.833,
			zh = 3.833
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
				arg_65_0:Play222072016(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1.var_.moveOldPos1074ui_story = arg_65_1.actors_["1074ui_story"].transform.localPosition
			end

			local var_68_0 = 0.001

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_0 then
				arg_65_1.actors_["1074ui_story"].transform.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos1074ui_story, Vector3.New(-0.7, -1.055, -6.12), (arg_65_1.time_ - 0) / var_68_0)
				arg_65_1.actors_["1074ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_65_1.actors_["1074ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["1074ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["1074ui_story"].transform.position).z)
				arg_65_1.actors_["1074ui_story"].transform.localEulerAngles.z = 0
				arg_65_1.actors_["1074ui_story"].transform.localEulerAngles.x = 0
				arg_65_1.actors_["1074ui_story"].transform.localEulerAngles = arg_65_1.actors_["1074ui_story"].transform.localEulerAngles
			end

			if arg_65_1.time_ >= 0 + var_68_0 and arg_65_1.time_ < 0 + var_68_0 + arg_68_0 then
				arg_65_1.actors_["1074ui_story"].transform.localPosition = Vector3.New(-0.7, -1.055, -6.12)
				arg_65_1.actors_["1074ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_65_1.actors_["1074ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["1074ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["1074ui_story"].transform.position).z)
				arg_65_1.actors_["1074ui_story"].transform.localEulerAngles.z = 0
				arg_65_1.actors_["1074ui_story"].transform.localEulerAngles.x = 0
				arg_65_1.actors_["1074ui_story"].transform.localEulerAngles = arg_65_1.actors_["1074ui_story"].transform.localEulerAngles
			end

			local var_68_1 = arg_65_1.actors_["1074ui_story"]

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(var_68_1) and arg_65_1.var_.characterEffect1074ui_story == nil then
				arg_65_1.var_.characterEffect1074ui_story = var_68_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_2 = 0.200000002980232

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_2 and not isNil(var_68_1) then
				if arg_65_1.var_.characterEffect1074ui_story and not isNil(var_68_1) then
					arg_65_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_65_1.time_ >= 0 + var_68_2 and arg_65_1.time_ < 0 + var_68_2 + arg_68_0 and not isNil(var_68_1) and arg_65_1.var_.characterEffect1074ui_story then
				arg_65_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action1_1")
			end

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_68_4 = 0
			local var_68_5 = 0.475

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_4 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				arg_65_1.leftNameTxt_.text = arg_65_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_6 = arg_65_1:GetWordFromCfg(222072015)
				local var_68_7 = arg_65_1:FormatText(var_68_6.content)

				arg_65_1.text_.text = var_68_7

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_9 = 19 <= 0 and var_68_5 or var_68_5 * (utf8.len(var_68_7) / 19)

				if (19 <= 0 and var_68_5 or var_68_5 * (utf8.len(var_68_7) / 19)) > 0 and var_68_5 < var_68_9 then
					arg_65_1.talkMaxDuration = var_68_9

					if var_68_9 + var_68_4 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_9 + var_68_4
					end
				end

				arg_65_1.text_.text = var_68_7
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222072", "222072015", "story_v_out_222072.awb") ~= 0 then
					local var_68_10 = manager.audio:GetVoiceLength("story_v_out_222072", "222072015", "story_v_out_222072.awb") / 1000

					if var_68_10 + var_68_4 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_10 + var_68_4
					end

					if var_68_6.prefab_name ~= "" and arg_65_1.actors_[var_68_6.prefab_name] ~= nil then
						local var_68_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_6.prefab_name].transform, "story_v_out_222072", "222072015", "story_v_out_222072.awb")

						arg_65_1:RecordAudio("222072015", var_68_11)
						arg_65_1:RecordAudio("222072015", var_68_11)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_222072", "222072015", "story_v_out_222072.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_222072", "222072015", "story_v_out_222072.awb")
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
				actorName = "1074ui_story",
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
	Play222072016 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 222072016
		arg_69_1.duration_ = 13.17

		local var_69_0 = {
			ja = 13.166,
			ko = 6.366,
			zh = 6.4
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
				arg_69_0:Play222072017(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1.var_.moveOldPos1070ui_story = arg_69_1.actors_["1070ui_story"].transform.localPosition
			end

			local var_72_0 = 0.001

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_0 then
				arg_69_1.actors_["1070ui_story"].transform.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos1070ui_story, Vector3.New(0.7, -0.95, -6.05), (arg_69_1.time_ - 0) / var_72_0)
				arg_69_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_69_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_69_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_69_1.actors_["1070ui_story"].transform.position).z)
				arg_69_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_69_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_69_1.actors_["1070ui_story"].transform.localEulerAngles = arg_69_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			if arg_69_1.time_ >= 0 + var_72_0 and arg_69_1.time_ < 0 + var_72_0 + arg_72_0 then
				arg_69_1.actors_["1070ui_story"].transform.localPosition = Vector3.New(0.7, -0.95, -6.05)
				arg_69_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_69_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_69_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_69_1.actors_["1070ui_story"].transform.position).z)
				arg_69_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_69_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_69_1.actors_["1070ui_story"].transform.localEulerAngles = arg_69_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			local var_72_1 = arg_69_1.actors_["1070ui_story"]

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 and not isNil(var_72_1) and arg_69_1.var_.characterEffect1070ui_story == nil then
				arg_69_1.var_.characterEffect1070ui_story = var_72_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_2 = 0.200000002980232

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_2 and not isNil(var_72_1) then
				if arg_69_1.var_.characterEffect1070ui_story and not isNil(var_72_1) then
					arg_69_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_69_1.time_ >= 0 + var_72_2 and arg_69_1.time_ < 0 + var_72_2 + arg_72_0 and not isNil(var_72_1) and arg_69_1.var_.characterEffect1070ui_story then
				arg_69_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action1_1")
			end

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_72_4 = arg_69_1.actors_["1074ui_story"]

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 and not isNil(var_72_4) and arg_69_1.var_.characterEffect1074ui_story == nil then
				arg_69_1.var_.characterEffect1074ui_story = var_72_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_5 = 0.200000002980232

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_5 and not isNil(var_72_4) then
				if arg_69_1.var_.characterEffect1074ui_story and not isNil(var_72_4) then
					arg_69_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_69_1.var_.characterEffect1074ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_69_1.time_ - 0) / var_72_5)
				end
			end

			if arg_69_1.time_ >= 0 + var_72_5 and arg_69_1.time_ < 0 + var_72_5 + arg_72_0 and not isNil(var_72_4) and arg_69_1.var_.characterEffect1074ui_story then
				arg_69_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_69_1.var_.characterEffect1074ui_story.fillRatio = 0.5
			end

			local var_72_6 = 0
			local var_72_7 = 0.7

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_6 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				arg_69_1.leftNameTxt_.text = arg_69_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_8 = arg_69_1:GetWordFromCfg(222072016)
				local var_72_9 = arg_69_1:FormatText(var_72_8.content)

				arg_69_1.text_.text = var_72_9

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_11 = 28 <= 0 and var_72_7 or var_72_7 * (utf8.len(var_72_9) / 28)

				if (28 <= 0 and var_72_7 or var_72_7 * (utf8.len(var_72_9) / 28)) > 0 and var_72_7 < var_72_11 then
					arg_69_1.talkMaxDuration = var_72_11

					if var_72_11 + var_72_6 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_11 + var_72_6
					end
				end

				arg_69_1.text_.text = var_72_9
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222072", "222072016", "story_v_out_222072.awb") ~= 0 then
					local var_72_12 = manager.audio:GetVoiceLength("story_v_out_222072", "222072016", "story_v_out_222072.awb") / 1000

					if var_72_12 + var_72_6 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_12 + var_72_6
					end

					if var_72_8.prefab_name ~= "" and arg_69_1.actors_[var_72_8.prefab_name] ~= nil then
						local var_72_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_8.prefab_name].transform, "story_v_out_222072", "222072016", "story_v_out_222072.awb")

						arg_69_1:RecordAudio("222072016", var_72_13)
						arg_69_1:RecordAudio("222072016", var_72_13)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_222072", "222072016", "story_v_out_222072.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_222072", "222072016", "story_v_out_222072.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_14 = math.max(var_72_7, arg_69_1.talkMaxDuration)

			if var_72_6 <= arg_69_1.time_ and arg_69_1.time_ < var_72_6 + var_72_14 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_6) / var_72_14

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_6 + var_72_14 and arg_69_1.time_ < var_72_6 + var_72_14 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_69_1:InitPlayNodeList()
	end,
	Play222072017 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 222072017
		arg_73_1.duration_ = 16.3

		local var_73_0 = {
			ja = 16.3,
			ko = 8.6,
			zh = 8.566
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
				arg_73_0:Play222072018(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action4_1")
			end

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_76_0 = 0
			local var_76_1 = 0.975

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_0 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				arg_73_1.leftNameTxt_.text = arg_73_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_2 = arg_73_1:GetWordFromCfg(222072017)
				local var_76_3 = arg_73_1:FormatText(var_76_2.content)

				arg_73_1.text_.text = var_76_3

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_5 = 39 <= 0 and var_76_1 or var_76_1 * (utf8.len(var_76_3) / 39)

				if (39 <= 0 and var_76_1 or var_76_1 * (utf8.len(var_76_3) / 39)) > 0 and var_76_1 < var_76_5 then
					arg_73_1.talkMaxDuration = var_76_5

					if var_76_5 + var_76_0 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_5 + var_76_0
					end
				end

				arg_73_1.text_.text = var_76_3
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222072", "222072017", "story_v_out_222072.awb") ~= 0 then
					local var_76_6 = manager.audio:GetVoiceLength("story_v_out_222072", "222072017", "story_v_out_222072.awb") / 1000

					if var_76_6 + var_76_0 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_6 + var_76_0
					end

					if var_76_2.prefab_name ~= "" and arg_73_1.actors_[var_76_2.prefab_name] ~= nil then
						local var_76_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_2.prefab_name].transform, "story_v_out_222072", "222072017", "story_v_out_222072.awb")

						arg_73_1:RecordAudio("222072017", var_76_7)
						arg_73_1:RecordAudio("222072017", var_76_7)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_222072", "222072017", "story_v_out_222072.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_222072", "222072017", "story_v_out_222072.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_8 = math.max(var_76_1, arg_73_1.talkMaxDuration)

			if var_76_0 <= arg_73_1.time_ and arg_73_1.time_ < var_76_0 + var_76_8 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_0) / var_76_8

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_0 + var_76_8 and arg_73_1.time_ < var_76_0 + var_76_8 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play222072018 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 222072018
		arg_77_1.duration_ = 5.27

		local var_77_0 = {
			ja = 5.266,
			ko = 4.1,
			zh = 4.2
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
				arg_77_0:Play222072019(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1.var_.moveOldPos1074ui_story = arg_77_1.actors_["1074ui_story"].transform.localPosition
			end

			local var_80_0 = 0.001

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_0 then
				arg_77_1.actors_["1074ui_story"].transform.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos1074ui_story, Vector3.New(0, 100, 0), (arg_77_1.time_ - 0) / var_80_0)
				arg_77_1.actors_["1074ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_77_1.actors_["1074ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_77_1.actors_["1074ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_77_1.actors_["1074ui_story"].transform.position).z)
				arg_77_1.actors_["1074ui_story"].transform.localEulerAngles.z = 0
				arg_77_1.actors_["1074ui_story"].transform.localEulerAngles.x = 0
				arg_77_1.actors_["1074ui_story"].transform.localEulerAngles = arg_77_1.actors_["1074ui_story"].transform.localEulerAngles
			end

			if arg_77_1.time_ >= 0 + var_80_0 and arg_77_1.time_ < 0 + var_80_0 + arg_80_0 then
				arg_77_1.actors_["1074ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_77_1.actors_["1074ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_77_1.actors_["1074ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_77_1.actors_["1074ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_77_1.actors_["1074ui_story"].transform.position).z)
				arg_77_1.actors_["1074ui_story"].transform.localEulerAngles.z = 0
				arg_77_1.actors_["1074ui_story"].transform.localEulerAngles.x = 0
				arg_77_1.actors_["1074ui_story"].transform.localEulerAngles = arg_77_1.actors_["1074ui_story"].transform.localEulerAngles
			end

			local var_80_1 = arg_77_1.actors_["1074ui_story"]

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 and not isNil(var_80_1) and arg_77_1.var_.characterEffect1074ui_story == nil then
				arg_77_1.var_.characterEffect1074ui_story = var_80_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_2 = 0.200000002980232

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_2 and not isNil(var_80_1) then
				if arg_77_1.var_.characterEffect1074ui_story and not isNil(var_80_1) then
					arg_77_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_77_1.var_.characterEffect1074ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_77_1.time_ - 0) / var_80_2)
				end
			end

			if arg_77_1.time_ >= 0 + var_80_2 and arg_77_1.time_ < 0 + var_80_2 + arg_80_0 and not isNil(var_80_1) and arg_77_1.var_.characterEffect1074ui_story then
				arg_77_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_77_1.var_.characterEffect1074ui_story.fillRatio = 0.5
			end

			local var_80_3 = arg_77_1.actors_["1071ui_story"].transform

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1.var_.moveOldPos1071ui_story = var_80_3.localPosition
			end

			local var_80_4 = 0.001

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_4 then
				var_80_3.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos1071ui_story, Vector3.New(-0.7, -1.05, -6.2), (arg_77_1.time_ - 0) / var_80_4)
				var_80_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_80_3.position).x, (manager.ui.mainCamera.transform.position - var_80_3.position).y, (manager.ui.mainCamera.transform.position - var_80_3.position).z)
				var_80_3.localEulerAngles.z = 0
				var_80_3.localEulerAngles.x = 0
				var_80_3.localEulerAngles = var_80_3.localEulerAngles
			end

			if arg_77_1.time_ >= 0 + var_80_4 and arg_77_1.time_ < 0 + var_80_4 + arg_80_0 then
				var_80_3.localPosition = Vector3.New(-0.7, -1.05, -6.2)
				var_80_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_80_3.position).x, (manager.ui.mainCamera.transform.position - var_80_3.position).y, (manager.ui.mainCamera.transform.position - var_80_3.position).z)
				var_80_3.localEulerAngles.z = 0
				var_80_3.localEulerAngles.x = 0
				var_80_3.localEulerAngles = var_80_3.localEulerAngles
			end

			local var_80_5 = arg_77_1.actors_["1071ui_story"]

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 and not isNil(var_80_5) and arg_77_1.var_.characterEffect1071ui_story == nil then
				arg_77_1.var_.characterEffect1071ui_story = var_80_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_6 = 0.200000002980232

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_6 and not isNil(var_80_5) then
				if arg_77_1.var_.characterEffect1071ui_story and not isNil(var_80_5) then
					arg_77_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_77_1.time_ >= 0 + var_80_6 and arg_77_1.time_ < 0 + var_80_6 + arg_80_0 and not isNil(var_80_5) and arg_77_1.var_.characterEffect1071ui_story then
				arg_77_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action2_1")
			end

			local var_80_8 = arg_77_1.actors_["1070ui_story"]

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 and not isNil(var_80_8) and arg_77_1.var_.characterEffect1070ui_story == nil then
				arg_77_1.var_.characterEffect1070ui_story = var_80_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_9 = 0.200000002980232

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_9 and not isNil(var_80_8) then
				if arg_77_1.var_.characterEffect1070ui_story and not isNil(var_80_8) then
					arg_77_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_77_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_77_1.time_ - 0) / var_80_9)
				end
			end

			if arg_77_1.time_ >= 0 + var_80_9 and arg_77_1.time_ < 0 + var_80_9 + arg_80_0 and not isNil(var_80_8) and arg_77_1.var_.characterEffect1070ui_story then
				arg_77_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_77_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_80_10 = 0
			local var_80_11 = 0.5

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_10 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				arg_77_1.leftNameTxt_.text = arg_77_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_12 = arg_77_1:GetWordFromCfg(222072018)
				local var_80_13 = arg_77_1:FormatText(var_80_12.content)

				arg_77_1.text_.text = var_80_13

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_15 = 20 <= 0 and var_80_11 or var_80_11 * (utf8.len(var_80_13) / 20)

				if (20 <= 0 and var_80_11 or var_80_11 * (utf8.len(var_80_13) / 20)) > 0 and var_80_11 < var_80_15 then
					arg_77_1.talkMaxDuration = var_80_15

					if var_80_15 + var_80_10 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_15 + var_80_10
					end
				end

				arg_77_1.text_.text = var_80_13
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222072", "222072018", "story_v_out_222072.awb") ~= 0 then
					local var_80_16 = manager.audio:GetVoiceLength("story_v_out_222072", "222072018", "story_v_out_222072.awb") / 1000

					if var_80_16 + var_80_10 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_16 + var_80_10
					end

					if var_80_12.prefab_name ~= "" and arg_77_1.actors_[var_80_12.prefab_name] ~= nil then
						local var_80_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_12.prefab_name].transform, "story_v_out_222072", "222072018", "story_v_out_222072.awb")

						arg_77_1:RecordAudio("222072018", var_80_17)
						arg_77_1:RecordAudio("222072018", var_80_17)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_222072", "222072018", "story_v_out_222072.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_222072", "222072018", "story_v_out_222072.awb")
				end

				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_18 = math.max(var_80_11, arg_77_1.talkMaxDuration)

			if var_80_10 <= arg_77_1.time_ and arg_77_1.time_ < var_80_10 + var_80_18 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_10) / var_80_18

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_10 + var_80_18 and arg_77_1.time_ < var_80_10 + var_80_18 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1071ui_story",
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
	Play222072019 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 222072019
		arg_81_1.duration_ = 5.73

		local var_81_0 = {
			ja = 5.733,
			ko = 3.3,
			zh = 3.3
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
				arg_81_0:Play222072020(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 and not isNil(arg_81_1.actors_["1070ui_story"]) and arg_81_1.var_.characterEffect1070ui_story == nil then
				arg_81_1.var_.characterEffect1070ui_story = arg_81_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_0 = 0.200000002980232

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_0 and not isNil(arg_81_1.actors_["1070ui_story"]) then
				if arg_81_1.var_.characterEffect1070ui_story and not isNil(arg_81_1.actors_["1070ui_story"]) then
					arg_81_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_81_1.time_ >= 0 + var_84_0 and arg_81_1.time_ < 0 + var_84_0 + arg_84_0 and not isNil(arg_81_1.actors_["1070ui_story"]) and arg_81_1.var_.characterEffect1070ui_story then
				arg_81_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action7_1")
			end

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_84_2 = arg_81_1.actors_["1071ui_story"]

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 and not isNil(var_84_2) and arg_81_1.var_.characterEffect1071ui_story == nil then
				arg_81_1.var_.characterEffect1071ui_story = var_84_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_3 = 0.200000002980232

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_3 and not isNil(var_84_2) then
				if arg_81_1.var_.characterEffect1071ui_story and not isNil(var_84_2) then
					arg_81_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_81_1.var_.characterEffect1071ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_81_1.time_ - 0) / var_84_3)
				end
			end

			if arg_81_1.time_ >= 0 + var_84_3 and arg_81_1.time_ < 0 + var_84_3 + arg_84_0 and not isNil(var_84_2) and arg_81_1.var_.characterEffect1071ui_story then
				arg_81_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_81_1.var_.characterEffect1071ui_story.fillRatio = 0.5
			end

			local var_84_4 = 0
			local var_84_5 = 0.4

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_4 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				arg_81_1.leftNameTxt_.text = arg_81_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_6 = arg_81_1:GetWordFromCfg(222072019)
				local var_84_7 = arg_81_1:FormatText(var_84_6.content)

				arg_81_1.text_.text = var_84_7

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_9 = 16 <= 0 and var_84_5 or var_84_5 * (utf8.len(var_84_7) / 16)

				if (16 <= 0 and var_84_5 or var_84_5 * (utf8.len(var_84_7) / 16)) > 0 and var_84_5 < var_84_9 then
					arg_81_1.talkMaxDuration = var_84_9

					if var_84_9 + var_84_4 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_9 + var_84_4
					end
				end

				arg_81_1.text_.text = var_84_7
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222072", "222072019", "story_v_out_222072.awb") ~= 0 then
					local var_84_10 = manager.audio:GetVoiceLength("story_v_out_222072", "222072019", "story_v_out_222072.awb") / 1000

					if var_84_10 + var_84_4 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_10 + var_84_4
					end

					if var_84_6.prefab_name ~= "" and arg_81_1.actors_[var_84_6.prefab_name] ~= nil then
						local var_84_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_6.prefab_name].transform, "story_v_out_222072", "222072019", "story_v_out_222072.awb")

						arg_81_1:RecordAudio("222072019", var_84_11)
						arg_81_1:RecordAudio("222072019", var_84_11)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_222072", "222072019", "story_v_out_222072.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_222072", "222072019", "story_v_out_222072.awb")
				end

				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_12 = math.max(var_84_5, arg_81_1.talkMaxDuration)

			if var_84_4 <= arg_81_1.time_ and arg_81_1.time_ < var_84_4 + var_84_12 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_4) / var_84_12

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_4 + var_84_12 and arg_81_1.time_ < var_84_4 + var_84_12 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {}

		arg_81_1:InitPlayNodeList()
	end,
	Play222072020 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 222072020
		arg_85_1.duration_ = 1.67

		local var_85_0 = {
			ja = 1.666,
			ko = 1.4,
			zh = 1.4
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
				arg_85_0:Play222072021(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 and not isNil(arg_85_1.actors_["1071ui_story"]) and arg_85_1.var_.characterEffect1071ui_story == nil then
				arg_85_1.var_.characterEffect1071ui_story = arg_85_1.actors_["1071ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_0 = 0.200000002980232

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_0 and not isNil(arg_85_1.actors_["1071ui_story"]) then
				if arg_85_1.var_.characterEffect1071ui_story and not isNil(arg_85_1.actors_["1071ui_story"]) then
					arg_85_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_85_1.time_ >= 0 + var_88_0 and arg_85_1.time_ < 0 + var_88_0 + arg_88_0 and not isNil(arg_85_1.actors_["1071ui_story"]) and arg_85_1.var_.characterEffect1071ui_story then
				arg_85_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_88_2 = arg_85_1.actors_["1070ui_story"]

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 and not isNil(var_88_2) and arg_85_1.var_.characterEffect1070ui_story == nil then
				arg_85_1.var_.characterEffect1070ui_story = var_88_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_3 = 0.200000002980232

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_3 and not isNil(var_88_2) then
				if arg_85_1.var_.characterEffect1070ui_story and not isNil(var_88_2) then
					arg_85_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_85_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_85_1.time_ - 0) / var_88_3)
				end
			end

			if arg_85_1.time_ >= 0 + var_88_3 and arg_85_1.time_ < 0 + var_88_3 + arg_88_0 and not isNil(var_88_2) and arg_85_1.var_.characterEffect1070ui_story then
				arg_85_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_85_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_88_4 = 0
			local var_88_5 = 0.125

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_4 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				arg_85_1.leftNameTxt_.text = arg_85_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_6 = arg_85_1:GetWordFromCfg(222072020)
				local var_88_7 = arg_85_1:FormatText(var_88_6.content)

				arg_85_1.text_.text = var_88_7

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_9 = 5 <= 0 and var_88_5 or var_88_5 * (utf8.len(var_88_7) / 5)

				if (5 <= 0 and var_88_5 or var_88_5 * (utf8.len(var_88_7) / 5)) > 0 and var_88_5 < var_88_9 then
					arg_85_1.talkMaxDuration = var_88_9

					if var_88_9 + var_88_4 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_9 + var_88_4
					end
				end

				arg_85_1.text_.text = var_88_7
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222072", "222072020", "story_v_out_222072.awb") ~= 0 then
					local var_88_10 = manager.audio:GetVoiceLength("story_v_out_222072", "222072020", "story_v_out_222072.awb") / 1000

					if var_88_10 + var_88_4 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_10 + var_88_4
					end

					if var_88_6.prefab_name ~= "" and arg_85_1.actors_[var_88_6.prefab_name] ~= nil then
						local var_88_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_6.prefab_name].transform, "story_v_out_222072", "222072020", "story_v_out_222072.awb")

						arg_85_1:RecordAudio("222072020", var_88_11)
						arg_85_1:RecordAudio("222072020", var_88_11)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_222072", "222072020", "story_v_out_222072.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_222072", "222072020", "story_v_out_222072.awb")
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

		arg_85_1.nodeConfigList_ = {}

		arg_85_1:InitPlayNodeList()
	end,
	Play222072021 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 222072021
		arg_89_1.duration_ = 5.8

		local var_89_0 = {
			ja = 5.8,
			ko = 4.433,
			zh = 4.4
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
				arg_89_0:Play222072022(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1.var_.moveOldPos1071ui_story = arg_89_1.actors_["1071ui_story"].transform.localPosition
			end

			local var_92_0 = 0.001

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_0 then
				arg_89_1.actors_["1071ui_story"].transform.localPosition = Vector3.Lerp(arg_89_1.var_.moveOldPos1071ui_story, Vector3.New(0, 100, 0), (arg_89_1.time_ - 0) / var_92_0)
				arg_89_1.actors_["1071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_89_1.actors_["1071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["1071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["1071ui_story"].transform.position).z)
				arg_89_1.actors_["1071ui_story"].transform.localEulerAngles.z = 0
				arg_89_1.actors_["1071ui_story"].transform.localEulerAngles.x = 0
				arg_89_1.actors_["1071ui_story"].transform.localEulerAngles = arg_89_1.actors_["1071ui_story"].transform.localEulerAngles
			end

			if arg_89_1.time_ >= 0 + var_92_0 and arg_89_1.time_ < 0 + var_92_0 + arg_92_0 then
				arg_89_1.actors_["1071ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_89_1.actors_["1071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_89_1.actors_["1071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["1071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["1071ui_story"].transform.position).z)
				arg_89_1.actors_["1071ui_story"].transform.localEulerAngles.z = 0
				arg_89_1.actors_["1071ui_story"].transform.localEulerAngles.x = 0
				arg_89_1.actors_["1071ui_story"].transform.localEulerAngles = arg_89_1.actors_["1071ui_story"].transform.localEulerAngles
			end

			local var_92_1 = arg_89_1.actors_["1071ui_story"]

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 and not isNil(var_92_1) and arg_89_1.var_.characterEffect1071ui_story == nil then
				arg_89_1.var_.characterEffect1071ui_story = var_92_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_2 = 0.200000002980232

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_2 and not isNil(var_92_1) then
				if arg_89_1.var_.characterEffect1071ui_story and not isNil(var_92_1) then
					arg_89_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_89_1.var_.characterEffect1071ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_89_1.time_ - 0) / var_92_2)
				end
			end

			if arg_89_1.time_ >= 0 + var_92_2 and arg_89_1.time_ < 0 + var_92_2 + arg_92_0 and not isNil(var_92_1) and arg_89_1.var_.characterEffect1071ui_story then
				arg_89_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_89_1.var_.characterEffect1071ui_story.fillRatio = 0.5
			end

			local var_92_3 = arg_89_1.actors_["1074ui_story"].transform

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1.var_.moveOldPos1074ui_story = var_92_3.localPosition
			end

			local var_92_4 = 0.001

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_4 then
				var_92_3.localPosition = Vector3.Lerp(arg_89_1.var_.moveOldPos1074ui_story, Vector3.New(-0.7, -1.055, -6.12), (arg_89_1.time_ - 0) / var_92_4)
				var_92_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_92_3.position).x, (manager.ui.mainCamera.transform.position - var_92_3.position).y, (manager.ui.mainCamera.transform.position - var_92_3.position).z)
				var_92_3.localEulerAngles.z = 0
				var_92_3.localEulerAngles.x = 0
				var_92_3.localEulerAngles = var_92_3.localEulerAngles
			end

			if arg_89_1.time_ >= 0 + var_92_4 and arg_89_1.time_ < 0 + var_92_4 + arg_92_0 then
				var_92_3.localPosition = Vector3.New(-0.7, -1.055, -6.12)
				var_92_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_92_3.position).x, (manager.ui.mainCamera.transform.position - var_92_3.position).y, (manager.ui.mainCamera.transform.position - var_92_3.position).z)
				var_92_3.localEulerAngles.z = 0
				var_92_3.localEulerAngles.x = 0
				var_92_3.localEulerAngles = var_92_3.localEulerAngles
			end

			local var_92_5 = arg_89_1.actors_["1074ui_story"]

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 and not isNil(var_92_5) and arg_89_1.var_.characterEffect1074ui_story == nil then
				arg_89_1.var_.characterEffect1074ui_story = var_92_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_6 = 0.200000002980232

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_6 and not isNil(var_92_5) then
				if arg_89_1.var_.characterEffect1074ui_story and not isNil(var_92_5) then
					arg_89_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_89_1.time_ >= 0 + var_92_6 and arg_89_1.time_ < 0 + var_92_6 + arg_92_0 and not isNil(var_92_5) and arg_89_1.var_.characterEffect1074ui_story then
				arg_89_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action1_1")
			end

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_92_8 = 0
			local var_92_9 = 0.55

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_8 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				arg_89_1.leftNameTxt_.text = arg_89_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_10 = arg_89_1:GetWordFromCfg(222072021)
				local var_92_11 = arg_89_1:FormatText(var_92_10.content)

				arg_89_1.text_.text = var_92_11

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_13 = 22 <= 0 and var_92_9 or var_92_9 * (utf8.len(var_92_11) / 22)

				if (22 <= 0 and var_92_9 or var_92_9 * (utf8.len(var_92_11) / 22)) > 0 and var_92_9 < var_92_13 then
					arg_89_1.talkMaxDuration = var_92_13

					if var_92_13 + var_92_8 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_13 + var_92_8
					end
				end

				arg_89_1.text_.text = var_92_11
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222072", "222072021", "story_v_out_222072.awb") ~= 0 then
					local var_92_14 = manager.audio:GetVoiceLength("story_v_out_222072", "222072021", "story_v_out_222072.awb") / 1000

					if var_92_14 + var_92_8 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_14 + var_92_8
					end

					if var_92_10.prefab_name ~= "" and arg_89_1.actors_[var_92_10.prefab_name] ~= nil then
						local var_92_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_10.prefab_name].transform, "story_v_out_222072", "222072021", "story_v_out_222072.awb")

						arg_89_1:RecordAudio("222072021", var_92_15)
						arg_89_1:RecordAudio("222072021", var_92_15)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_222072", "222072021", "story_v_out_222072.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_222072", "222072021", "story_v_out_222072.awb")
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
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1074ui_story",
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
	Play222072022 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 222072022
		arg_93_1.duration_ = 9.43

		local var_93_0 = {
			ja = 9.433,
			ko = 4.5,
			zh = 4.466
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
				arg_93_0:Play222072023(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action5_1")
			end

			local var_96_0 = 0
			local var_96_1 = 0.6

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_0 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				arg_93_1.leftNameTxt_.text = arg_93_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_2 = arg_93_1:GetWordFromCfg(222072022)
				local var_96_3 = arg_93_1:FormatText(var_96_2.content)

				arg_93_1.text_.text = var_96_3

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_5 = 24 <= 0 and var_96_1 or var_96_1 * (utf8.len(var_96_3) / 24)

				if (24 <= 0 and var_96_1 or var_96_1 * (utf8.len(var_96_3) / 24)) > 0 and var_96_1 < var_96_5 then
					arg_93_1.talkMaxDuration = var_96_5

					if var_96_5 + var_96_0 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_5 + var_96_0
					end
				end

				arg_93_1.text_.text = var_96_3
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222072", "222072022", "story_v_out_222072.awb") ~= 0 then
					local var_96_6 = manager.audio:GetVoiceLength("story_v_out_222072", "222072022", "story_v_out_222072.awb") / 1000

					if var_96_6 + var_96_0 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_6 + var_96_0
					end

					if var_96_2.prefab_name ~= "" and arg_93_1.actors_[var_96_2.prefab_name] ~= nil then
						local var_96_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_2.prefab_name].transform, "story_v_out_222072", "222072022", "story_v_out_222072.awb")

						arg_93_1:RecordAudio("222072022", var_96_7)
						arg_93_1:RecordAudio("222072022", var_96_7)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_222072", "222072022", "story_v_out_222072.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_222072", "222072022", "story_v_out_222072.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_8 = math.max(var_96_1, arg_93_1.talkMaxDuration)

			if var_96_0 <= arg_93_1.time_ and arg_93_1.time_ < var_96_0 + var_96_8 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_0) / var_96_8

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_0 + var_96_8 and arg_93_1.time_ < var_96_0 + var_96_8 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play222072023 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 222072023
		arg_97_1.duration_ = 5

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play222072024(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 and not isNil(arg_97_1.actors_["1074ui_story"]) and arg_97_1.var_.characterEffect1074ui_story == nil then
				arg_97_1.var_.characterEffect1074ui_story = arg_97_1.actors_["1074ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_0 = 0.200000002980232

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_0 and not isNil(arg_97_1.actors_["1074ui_story"]) then
				if arg_97_1.var_.characterEffect1074ui_story and not isNil(arg_97_1.actors_["1074ui_story"]) then
					arg_97_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_97_1.var_.characterEffect1074ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_97_1.time_ - 0) / var_100_0)
				end
			end

			if arg_97_1.time_ >= 0 + var_100_0 and arg_97_1.time_ < 0 + var_100_0 + arg_100_0 and not isNil(arg_97_1.actors_["1074ui_story"]) and arg_97_1.var_.characterEffect1074ui_story then
				arg_97_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_97_1.var_.characterEffect1074ui_story.fillRatio = 0.5
			end

			local var_100_1 = 0
			local var_100_2 = 1.175

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_1 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, false)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_3 = arg_97_1:FormatText(arg_97_1:GetWordFromCfg(222072023).content)

				arg_97_1.text_.text = var_100_3

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_5 = 47 <= 0 and var_100_2 or var_100_2 * (utf8.len(var_100_3) / 47)

				if (47 <= 0 and var_100_2 or var_100_2 * (utf8.len(var_100_3) / 47)) > 0 and var_100_2 < var_100_5 then
					arg_97_1.talkMaxDuration = var_100_5

					if var_100_5 + var_100_1 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_5 + var_100_1
					end
				end

				arg_97_1.text_.text = var_100_3
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)
				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_6 = math.max(var_100_2, arg_97_1.talkMaxDuration)

			if var_100_1 <= arg_97_1.time_ and arg_97_1.time_ < var_100_1 + var_100_6 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_1) / var_100_6

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_1 + var_100_6 and arg_97_1.time_ < var_100_1 + var_100_6 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {}

		arg_97_1:InitPlayNodeList()
	end,
	Play222072024 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 222072024
		arg_101_1.duration_ = 5.53

		local var_101_0 = {
			ja = 5.533,
			ko = 4.366,
			zh = 4.366
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
				arg_101_0:Play222072025(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 and not isNil(arg_101_1.actors_["1070ui_story"]) and arg_101_1.var_.characterEffect1070ui_story == nil then
				arg_101_1.var_.characterEffect1070ui_story = arg_101_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_0 = 0.200000002980232

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_0 and not isNil(arg_101_1.actors_["1070ui_story"]) then
				if arg_101_1.var_.characterEffect1070ui_story and not isNil(arg_101_1.actors_["1070ui_story"]) then
					arg_101_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_101_1.time_ >= 0 + var_104_0 and arg_101_1.time_ < 0 + var_104_0 + arg_104_0 and not isNil(arg_101_1.actors_["1070ui_story"]) and arg_101_1.var_.characterEffect1070ui_story then
				arg_101_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action7_2")
			end

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_104_2 = 0
			local var_104_3 = 0.6

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= var_104_2 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				arg_101_1.leftNameTxt_.text = arg_101_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_4 = arg_101_1:GetWordFromCfg(222072024)
				local var_104_5 = arg_101_1:FormatText(var_104_4.content)

				arg_101_1.text_.text = var_104_5

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_7 = 24 <= 0 and var_104_3 or var_104_3 * (utf8.len(var_104_5) / 24)

				if (24 <= 0 and var_104_3 or var_104_3 * (utf8.len(var_104_5) / 24)) > 0 and var_104_3 < var_104_7 then
					arg_101_1.talkMaxDuration = var_104_7

					if var_104_7 + var_104_2 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_7 + var_104_2
					end
				end

				arg_101_1.text_.text = var_104_5
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222072", "222072024", "story_v_out_222072.awb") ~= 0 then
					local var_104_8 = manager.audio:GetVoiceLength("story_v_out_222072", "222072024", "story_v_out_222072.awb") / 1000

					if var_104_8 + var_104_2 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_8 + var_104_2
					end

					if var_104_4.prefab_name ~= "" and arg_101_1.actors_[var_104_4.prefab_name] ~= nil then
						local var_104_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_4.prefab_name].transform, "story_v_out_222072", "222072024", "story_v_out_222072.awb")

						arg_101_1:RecordAudio("222072024", var_104_9)
						arg_101_1:RecordAudio("222072024", var_104_9)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_222072", "222072024", "story_v_out_222072.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_222072", "222072024", "story_v_out_222072.awb")
				end

				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_10 = math.max(var_104_3, arg_101_1.talkMaxDuration)

			if var_104_2 <= arg_101_1.time_ and arg_101_1.time_ < var_104_2 + var_104_10 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_2) / var_104_10

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_2 + var_104_10 and arg_101_1.time_ < var_104_2 + var_104_10 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {}

		arg_101_1:InitPlayNodeList()
	end,
	Play222072025 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 222072025
		arg_105_1.duration_ = 17.67

		local var_105_0 = {
			ja = 17.666,
			ko = 10.8,
			zh = 10.8
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
				arg_105_0:Play222072026(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1.var_.moveOldPos1070ui_story = arg_105_1.actors_["1070ui_story"].transform.localPosition
			end

			local var_108_0 = 0.001

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_0 then
				arg_105_1.actors_["1070ui_story"].transform.localPosition = Vector3.Lerp(arg_105_1.var_.moveOldPos1070ui_story, Vector3.New(0, 100, 0), (arg_105_1.time_ - 0) / var_108_0)
				arg_105_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_105_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_105_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_105_1.actors_["1070ui_story"].transform.position).z)
				arg_105_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_105_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_105_1.actors_["1070ui_story"].transform.localEulerAngles = arg_105_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			if arg_105_1.time_ >= 0 + var_108_0 and arg_105_1.time_ < 0 + var_108_0 + arg_108_0 then
				arg_105_1.actors_["1070ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_105_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_105_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_105_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_105_1.actors_["1070ui_story"].transform.position).z)
				arg_105_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_105_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_105_1.actors_["1070ui_story"].transform.localEulerAngles = arg_105_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			local var_108_1 = arg_105_1.actors_["1070ui_story"]

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 and not isNil(var_108_1) and arg_105_1.var_.characterEffect1070ui_story == nil then
				arg_105_1.var_.characterEffect1070ui_story = var_108_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_2 = 0.200000002980232

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_2 and not isNil(var_108_1) then
				if arg_105_1.var_.characterEffect1070ui_story and not isNil(var_108_1) then
					arg_105_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_105_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_105_1.time_ - 0) / var_108_2)
				end
			end

			if arg_105_1.time_ >= 0 + var_108_2 and arg_105_1.time_ < 0 + var_108_2 + arg_108_0 and not isNil(var_108_1) and arg_105_1.var_.characterEffect1070ui_story then
				arg_105_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_105_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_108_3 = arg_105_1.actors_["1071ui_story"].transform

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1.var_.moveOldPos1071ui_story = var_108_3.localPosition
			end

			local var_108_4 = 0.001

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_4 then
				var_108_3.localPosition = Vector3.Lerp(arg_105_1.var_.moveOldPos1071ui_story, Vector3.New(0.7, -1.05, -6.2), (arg_105_1.time_ - 0) / var_108_4)
				var_108_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_108_3.position).x, (manager.ui.mainCamera.transform.position - var_108_3.position).y, (manager.ui.mainCamera.transform.position - var_108_3.position).z)
				var_108_3.localEulerAngles.z = 0
				var_108_3.localEulerAngles.x = 0
				var_108_3.localEulerAngles = var_108_3.localEulerAngles
			end

			if arg_105_1.time_ >= 0 + var_108_4 and arg_105_1.time_ < 0 + var_108_4 + arg_108_0 then
				var_108_3.localPosition = Vector3.New(0.7, -1.05, -6.2)
				var_108_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_108_3.position).x, (manager.ui.mainCamera.transform.position - var_108_3.position).y, (manager.ui.mainCamera.transform.position - var_108_3.position).z)
				var_108_3.localEulerAngles.z = 0
				var_108_3.localEulerAngles.x = 0
				var_108_3.localEulerAngles = var_108_3.localEulerAngles
			end

			local var_108_5 = arg_105_1.actors_["1071ui_story"]

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 and not isNil(var_108_5) and arg_105_1.var_.characterEffect1071ui_story == nil then
				arg_105_1.var_.characterEffect1071ui_story = var_108_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_6 = 0.200000002980232

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_6 and not isNil(var_108_5) then
				if arg_105_1.var_.characterEffect1071ui_story and not isNil(var_108_5) then
					arg_105_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_105_1.time_ >= 0 + var_108_6 and arg_105_1.time_ < 0 + var_108_6 + arg_108_0 and not isNil(var_108_5) and arg_105_1.var_.characterEffect1071ui_story then
				arg_105_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action1_1")
			end

			local var_108_8 = 0
			local var_108_9 = 1.15

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= var_108_8 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				arg_105_1.leftNameTxt_.text = arg_105_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_10 = arg_105_1:GetWordFromCfg(222072025)
				local var_108_11 = arg_105_1:FormatText(var_108_10.content)

				arg_105_1.text_.text = var_108_11

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_13 = 46 <= 0 and var_108_9 or var_108_9 * (utf8.len(var_108_11) / 46)

				if (46 <= 0 and var_108_9 or var_108_9 * (utf8.len(var_108_11) / 46)) > 0 and var_108_9 < var_108_13 then
					arg_105_1.talkMaxDuration = var_108_13

					if var_108_13 + var_108_8 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_13 + var_108_8
					end
				end

				arg_105_1.text_.text = var_108_11
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222072", "222072025", "story_v_out_222072.awb") ~= 0 then
					local var_108_14 = manager.audio:GetVoiceLength("story_v_out_222072", "222072025", "story_v_out_222072.awb") / 1000

					if var_108_14 + var_108_8 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_14 + var_108_8
					end

					if var_108_10.prefab_name ~= "" and arg_105_1.actors_[var_108_10.prefab_name] ~= nil then
						local var_108_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_10.prefab_name].transform, "story_v_out_222072", "222072025", "story_v_out_222072.awb")

						arg_105_1:RecordAudio("222072025", var_108_15)
						arg_105_1:RecordAudio("222072025", var_108_15)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_222072", "222072025", "story_v_out_222072.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_222072", "222072025", "story_v_out_222072.awb")
				end

				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_16 = math.max(var_108_9, arg_105_1.talkMaxDuration)

			if var_108_8 <= arg_105_1.time_ and arg_105_1.time_ < var_108_8 + var_108_16 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_8) / var_108_16

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_8 + var_108_16 and arg_105_1.time_ < var_108_8 + var_108_16 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1071ui_story",
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
	Play222072026 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 222072026
		arg_109_1.duration_ = 10.83

		local var_109_0 = {
			ja = 10.833,
			ko = 9.333,
			zh = 9.333
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
				arg_109_0:Play222072027(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 and not isNil(arg_109_1.actors_["1074ui_story"]) and arg_109_1.var_.characterEffect1074ui_story == nil then
				arg_109_1.var_.characterEffect1074ui_story = arg_109_1.actors_["1074ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_0 = 0.200000002980232

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_0 and not isNil(arg_109_1.actors_["1074ui_story"]) then
				if arg_109_1.var_.characterEffect1074ui_story and not isNil(arg_109_1.actors_["1074ui_story"]) then
					arg_109_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_109_1.time_ >= 0 + var_112_0 and arg_109_1.time_ < 0 + var_112_0 + arg_112_0 and not isNil(arg_109_1.actors_["1074ui_story"]) and arg_109_1.var_.characterEffect1074ui_story then
				arg_109_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action5_2")
			end

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_112_2 = arg_109_1.actors_["1071ui_story"]

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 and not isNil(var_112_2) and arg_109_1.var_.characterEffect1071ui_story == nil then
				arg_109_1.var_.characterEffect1071ui_story = var_112_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_3 = 0.200000002980232

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_3 and not isNil(var_112_2) then
				if arg_109_1.var_.characterEffect1071ui_story and not isNil(var_112_2) then
					arg_109_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_109_1.var_.characterEffect1071ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_109_1.time_ - 0) / var_112_3)
				end
			end

			if arg_109_1.time_ >= 0 + var_112_3 and arg_109_1.time_ < 0 + var_112_3 + arg_112_0 and not isNil(var_112_2) and arg_109_1.var_.characterEffect1071ui_story then
				arg_109_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_109_1.var_.characterEffect1071ui_story.fillRatio = 0.5
			end

			local var_112_4 = 0
			local var_112_5 = 1.075

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= var_112_4 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				arg_109_1.leftNameTxt_.text = arg_109_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_6 = arg_109_1:GetWordFromCfg(222072026)
				local var_112_7 = arg_109_1:FormatText(var_112_6.content)

				arg_109_1.text_.text = var_112_7

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_9 = 43 <= 0 and var_112_5 or var_112_5 * (utf8.len(var_112_7) / 43)

				if (43 <= 0 and var_112_5 or var_112_5 * (utf8.len(var_112_7) / 43)) > 0 and var_112_5 < var_112_9 then
					arg_109_1.talkMaxDuration = var_112_9

					if var_112_9 + var_112_4 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_9 + var_112_4
					end
				end

				arg_109_1.text_.text = var_112_7
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222072", "222072026", "story_v_out_222072.awb") ~= 0 then
					local var_112_10 = manager.audio:GetVoiceLength("story_v_out_222072", "222072026", "story_v_out_222072.awb") / 1000

					if var_112_10 + var_112_4 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_10 + var_112_4
					end

					if var_112_6.prefab_name ~= "" and arg_109_1.actors_[var_112_6.prefab_name] ~= nil then
						local var_112_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_6.prefab_name].transform, "story_v_out_222072", "222072026", "story_v_out_222072.awb")

						arg_109_1:RecordAudio("222072026", var_112_11)
						arg_109_1:RecordAudio("222072026", var_112_11)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_222072", "222072026", "story_v_out_222072.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_222072", "222072026", "story_v_out_222072.awb")
				end

				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_12 = math.max(var_112_5, arg_109_1.talkMaxDuration)

			if var_112_4 <= arg_109_1.time_ and arg_109_1.time_ < var_112_4 + var_112_12 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_4) / var_112_12

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_4 + var_112_12 and arg_109_1.time_ < var_112_4 + var_112_12 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {}

		arg_109_1:InitPlayNodeList()
	end,
	Play222072027 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 222072027
		arg_113_1.duration_ = 8.5

		local var_113_0 = {
			ja = 8.5,
			ko = 6.833,
			zh = 6.9
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
				arg_113_0:Play222072028(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			local var_116_0 = 0.725

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				arg_113_1.leftNameTxt_.text = arg_113_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_1 = arg_113_1:GetWordFromCfg(222072027)
				local var_116_2 = arg_113_1:FormatText(var_116_1.content)

				arg_113_1.text_.text = var_116_2

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_4 = 29 <= 0 and var_116_0 or var_116_0 * (utf8.len(var_116_2) / 29)

				if (29 <= 0 and var_116_0 or var_116_0 * (utf8.len(var_116_2) / 29)) > 0 and var_116_0 < var_116_4 then
					arg_113_1.talkMaxDuration = var_116_4

					if var_116_4 + 0 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_4 + 0
					end
				end

				arg_113_1.text_.text = var_116_2
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222072", "222072027", "story_v_out_222072.awb") ~= 0 then
					local var_116_5 = manager.audio:GetVoiceLength("story_v_out_222072", "222072027", "story_v_out_222072.awb") / 1000

					if var_116_5 + 0 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_5 + 0
					end

					if var_116_1.prefab_name ~= "" and arg_113_1.actors_[var_116_1.prefab_name] ~= nil then
						local var_116_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_1.prefab_name].transform, "story_v_out_222072", "222072027", "story_v_out_222072.awb")

						arg_113_1:RecordAudio("222072027", var_116_6)
						arg_113_1:RecordAudio("222072027", var_116_6)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_out_222072", "222072027", "story_v_out_222072.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_out_222072", "222072027", "story_v_out_222072.awb")
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
	Play222072028 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 222072028
		arg_117_1.duration_ = 11.97

		local var_117_0 = {
			ja = 11.966,
			ko = 7.433,
			zh = 7.433
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
				arg_117_0:Play222072029(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1.var_.moveOldPos1071ui_story = arg_117_1.actors_["1071ui_story"].transform.localPosition
			end

			local var_120_0 = 0.001

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_0 then
				arg_117_1.actors_["1071ui_story"].transform.localPosition = Vector3.Lerp(arg_117_1.var_.moveOldPos1071ui_story, Vector3.New(0, 100, 0), (arg_117_1.time_ - 0) / var_120_0)
				arg_117_1.actors_["1071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_117_1.actors_["1071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_117_1.actors_["1071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_117_1.actors_["1071ui_story"].transform.position).z)
				arg_117_1.actors_["1071ui_story"].transform.localEulerAngles.z = 0
				arg_117_1.actors_["1071ui_story"].transform.localEulerAngles.x = 0
				arg_117_1.actors_["1071ui_story"].transform.localEulerAngles = arg_117_1.actors_["1071ui_story"].transform.localEulerAngles
			end

			if arg_117_1.time_ >= 0 + var_120_0 and arg_117_1.time_ < 0 + var_120_0 + arg_120_0 then
				arg_117_1.actors_["1071ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_117_1.actors_["1071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_117_1.actors_["1071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_117_1.actors_["1071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_117_1.actors_["1071ui_story"].transform.position).z)
				arg_117_1.actors_["1071ui_story"].transform.localEulerAngles.z = 0
				arg_117_1.actors_["1071ui_story"].transform.localEulerAngles.x = 0
				arg_117_1.actors_["1071ui_story"].transform.localEulerAngles = arg_117_1.actors_["1071ui_story"].transform.localEulerAngles
			end

			local var_120_1 = arg_117_1.actors_["1071ui_story"]

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 and not isNil(var_120_1) and arg_117_1.var_.characterEffect1071ui_story == nil then
				arg_117_1.var_.characterEffect1071ui_story = var_120_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_120_2 = 0.200000002980232

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_2 and not isNil(var_120_1) then
				if arg_117_1.var_.characterEffect1071ui_story and not isNil(var_120_1) then
					arg_117_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_117_1.var_.characterEffect1071ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_117_1.time_ - 0) / var_120_2)
				end
			end

			if arg_117_1.time_ >= 0 + var_120_2 and arg_117_1.time_ < 0 + var_120_2 + arg_120_0 and not isNil(var_120_1) and arg_117_1.var_.characterEffect1071ui_story then
				arg_117_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_117_1.var_.characterEffect1071ui_story.fillRatio = 0.5
			end

			local var_120_3 = arg_117_1.actors_["1070ui_story"].transform

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1.var_.moveOldPos1070ui_story = var_120_3.localPosition
			end

			local var_120_4 = 0.001

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_4 then
				var_120_3.localPosition = Vector3.Lerp(arg_117_1.var_.moveOldPos1070ui_story, Vector3.New(0.7, -0.95, -6.05), (arg_117_1.time_ - 0) / var_120_4)
				var_120_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_120_3.position).x, (manager.ui.mainCamera.transform.position - var_120_3.position).y, (manager.ui.mainCamera.transform.position - var_120_3.position).z)
				var_120_3.localEulerAngles.z = 0
				var_120_3.localEulerAngles.x = 0
				var_120_3.localEulerAngles = var_120_3.localEulerAngles
			end

			if arg_117_1.time_ >= 0 + var_120_4 and arg_117_1.time_ < 0 + var_120_4 + arg_120_0 then
				var_120_3.localPosition = Vector3.New(0.7, -0.95, -6.05)
				var_120_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_120_3.position).x, (manager.ui.mainCamera.transform.position - var_120_3.position).y, (manager.ui.mainCamera.transform.position - var_120_3.position).z)
				var_120_3.localEulerAngles.z = 0
				var_120_3.localEulerAngles.x = 0
				var_120_3.localEulerAngles = var_120_3.localEulerAngles
			end

			local var_120_5 = arg_117_1.actors_["1070ui_story"]

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 and not isNil(var_120_5) and arg_117_1.var_.characterEffect1070ui_story == nil then
				arg_117_1.var_.characterEffect1070ui_story = var_120_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_120_6 = 0.200000002980232

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_6 and not isNil(var_120_5) then
				if arg_117_1.var_.characterEffect1070ui_story and not isNil(var_120_5) then
					arg_117_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_117_1.time_ >= 0 + var_120_6 and arg_117_1.time_ < 0 + var_120_6 + arg_120_0 and not isNil(var_120_5) and arg_117_1.var_.characterEffect1070ui_story then
				arg_117_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action3_1")
			end

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_120_8 = arg_117_1.actors_["1074ui_story"]

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 and not isNil(var_120_8) and arg_117_1.var_.characterEffect1074ui_story == nil then
				arg_117_1.var_.characterEffect1074ui_story = var_120_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_120_9 = 0.200000002980232

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_9 and not isNil(var_120_8) then
				if arg_117_1.var_.characterEffect1074ui_story and not isNil(var_120_8) then
					arg_117_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_117_1.var_.characterEffect1074ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_117_1.time_ - 0) / var_120_9)
				end
			end

			if arg_117_1.time_ >= 0 + var_120_9 and arg_117_1.time_ < 0 + var_120_9 + arg_120_0 and not isNil(var_120_8) and arg_117_1.var_.characterEffect1074ui_story then
				arg_117_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_117_1.var_.characterEffect1074ui_story.fillRatio = 0.5
			end

			local var_120_10 = 0
			local var_120_11 = 0.85

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= var_120_10 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				arg_117_1.leftNameTxt_.text = arg_117_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_12 = arg_117_1:GetWordFromCfg(222072028)
				local var_120_13 = arg_117_1:FormatText(var_120_12.content)

				arg_117_1.text_.text = var_120_13

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_15 = 34 <= 0 and var_120_11 or var_120_11 * (utf8.len(var_120_13) / 34)

				if (34 <= 0 and var_120_11 or var_120_11 * (utf8.len(var_120_13) / 34)) > 0 and var_120_11 < var_120_15 then
					arg_117_1.talkMaxDuration = var_120_15

					if var_120_15 + var_120_10 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_15 + var_120_10
					end
				end

				arg_117_1.text_.text = var_120_13
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222072", "222072028", "story_v_out_222072.awb") ~= 0 then
					local var_120_16 = manager.audio:GetVoiceLength("story_v_out_222072", "222072028", "story_v_out_222072.awb") / 1000

					if var_120_16 + var_120_10 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_16 + var_120_10
					end

					if var_120_12.prefab_name ~= "" and arg_117_1.actors_[var_120_12.prefab_name] ~= nil then
						local var_120_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_12.prefab_name].transform, "story_v_out_222072", "222072028", "story_v_out_222072.awb")

						arg_117_1:RecordAudio("222072028", var_120_17)
						arg_117_1:RecordAudio("222072028", var_120_17)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_out_222072", "222072028", "story_v_out_222072.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_out_222072", "222072028", "story_v_out_222072.awb")
				end

				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_18 = math.max(var_120_11, arg_117_1.talkMaxDuration)

			if var_120_10 <= arg_117_1.time_ and arg_117_1.time_ < var_120_10 + var_120_18 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_10) / var_120_18

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_10 + var_120_18 and arg_117_1.time_ < var_120_10 + var_120_18 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_117_1:InitPlayNodeList()
	end,
	Play222072029 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 222072029
		arg_121_1.duration_ = 9

		SetActive(arg_121_1.tipsGo_, false)

		function arg_121_1.onSingleLineFinish_()
			arg_121_1.onSingleLineUpdate_ = nil
			arg_121_1.onSingleLineFinish_ = nil
			arg_121_1.state_ = "waiting"
		end

		function arg_121_1.playNext_(arg_123_0)
			if arg_123_0 == 1 then
				arg_121_0:Play222072030(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			if arg_121_1.bgs_.ST39 == nil then
				local var_124_0 = Object.Instantiate(arg_121_1.paintGo_)

				var_124_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST39")
				var_124_0.name = "ST39"
				var_124_0.transform.parent = arg_121_1.stage_.transform
				var_124_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_121_1.bgs_.ST39 = var_124_0
			end

			if 2 < arg_121_1.time_ and arg_121_1.time_ <= 2 + arg_124_0 then
				local var_124_1 = arg_121_1.bgs_.ST39

				arg_121_1.bgs_.ST39.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_124_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_124_2 = var_124_1:GetComponent("SpriteRenderer")

				if var_124_2 and var_124_2.sprite then
					local var_124_3 = 2 * (var_124_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_124_1.transform.localScale = Vector3.New(var_124_3 / var_124_2.sprite.bounds.size.y < var_124_3 * manager.ui.mainCameraCom_.aspect / var_124_2.sprite.bounds.size.x and var_124_3 * manager.ui.mainCameraCom_.aspect / var_124_2.sprite.bounds.size.x or var_124_3 / var_124_2.sprite.bounds.size.y, var_124_3 / var_124_2.sprite.bounds.size.y < var_124_3 * manager.ui.mainCameraCom_.aspect / var_124_2.sprite.bounds.size.x and var_124_3 * manager.ui.mainCameraCom_.aspect / var_124_2.sprite.bounds.size.x or var_124_3 / var_124_2.sprite.bounds.size.y, 0)
				end

				for iter_124_0, iter_124_1 in pairs(arg_121_1.bgs_) do
					if iter_124_0 ~= "ST39" then
						iter_124_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_124_4 = arg_121_1.actors_["1070ui_story"].transform

			if 1.96599999815226 < arg_121_1.time_ and arg_121_1.time_ <= 1.96599999815226 + arg_124_0 then
				arg_121_1.var_.moveOldPos1070ui_story = var_124_4.localPosition
			end

			local var_124_5 = 0.001

			if 1.96599999815226 <= arg_121_1.time_ and arg_121_1.time_ < 1.96599999815226 + var_124_5 then
				var_124_4.localPosition = Vector3.Lerp(arg_121_1.var_.moveOldPos1070ui_story, Vector3.New(0, 100, 0), (arg_121_1.time_ - 1.96599999815226) / var_124_5)
				var_124_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_124_4.position).x, (manager.ui.mainCamera.transform.position - var_124_4.position).y, (manager.ui.mainCamera.transform.position - var_124_4.position).z)
				var_124_4.localEulerAngles.z = 0
				var_124_4.localEulerAngles.x = 0
				var_124_4.localEulerAngles = var_124_4.localEulerAngles
			end

			if arg_121_1.time_ >= 1.96599999815226 + var_124_5 and arg_121_1.time_ < 1.96599999815226 + var_124_5 + arg_124_0 then
				var_124_4.localPosition = Vector3.New(0, 100, 0)
				var_124_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_124_4.position).x, (manager.ui.mainCamera.transform.position - var_124_4.position).y, (manager.ui.mainCamera.transform.position - var_124_4.position).z)
				var_124_4.localEulerAngles.z = 0
				var_124_4.localEulerAngles.x = 0
				var_124_4.localEulerAngles = var_124_4.localEulerAngles
			end

			local var_124_6 = arg_121_1.actors_["1070ui_story"]

			if 1.96599999815226 < arg_121_1.time_ and arg_121_1.time_ <= 1.96599999815226 + arg_124_0 and not isNil(var_124_6) and arg_121_1.var_.characterEffect1070ui_story == nil then
				arg_121_1.var_.characterEffect1070ui_story = var_124_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_7 = 0.0166666666666667

			if 1.96599999815226 <= arg_121_1.time_ and arg_121_1.time_ < 1.96599999815226 + var_124_7 and not isNil(var_124_6) then
				if arg_121_1.var_.characterEffect1070ui_story and not isNil(var_124_6) then
					arg_121_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_121_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_121_1.time_ - 1.96599999815226) / var_124_7)
				end
			end

			if arg_121_1.time_ >= 1.96599999815226 + var_124_7 and arg_121_1.time_ < 1.96599999815226 + var_124_7 + arg_124_0 and not isNil(var_124_6) and arg_121_1.var_.characterEffect1070ui_story then
				arg_121_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_121_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_124_8 = arg_121_1.actors_["1074ui_story"].transform

			if 1.96599999815226 < arg_121_1.time_ and arg_121_1.time_ <= 1.96599999815226 + arg_124_0 then
				arg_121_1.var_.moveOldPos1074ui_story = var_124_8.localPosition
			end

			local var_124_9 = 0.001

			if 1.96599999815226 <= arg_121_1.time_ and arg_121_1.time_ < 1.96599999815226 + var_124_9 then
				var_124_8.localPosition = Vector3.Lerp(arg_121_1.var_.moveOldPos1074ui_story, Vector3.New(0, 100, 0), (arg_121_1.time_ - 1.96599999815226) / var_124_9)
				var_124_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_124_8.position).x, (manager.ui.mainCamera.transform.position - var_124_8.position).y, (manager.ui.mainCamera.transform.position - var_124_8.position).z)
				var_124_8.localEulerAngles.z = 0
				var_124_8.localEulerAngles.x = 0
				var_124_8.localEulerAngles = var_124_8.localEulerAngles
			end

			if arg_121_1.time_ >= 1.96599999815226 + var_124_9 and arg_121_1.time_ < 1.96599999815226 + var_124_9 + arg_124_0 then
				var_124_8.localPosition = Vector3.New(0, 100, 0)
				var_124_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_124_8.position).x, (manager.ui.mainCamera.transform.position - var_124_8.position).y, (manager.ui.mainCamera.transform.position - var_124_8.position).z)
				var_124_8.localEulerAngles.z = 0
				var_124_8.localEulerAngles.x = 0
				var_124_8.localEulerAngles = var_124_8.localEulerAngles
			end

			local var_124_10 = arg_121_1.actors_["1074ui_story"]

			if 1.96599999815226 < arg_121_1.time_ and arg_121_1.time_ <= 1.96599999815226 + arg_124_0 and not isNil(var_124_10) and arg_121_1.var_.characterEffect1074ui_story == nil then
				arg_121_1.var_.characterEffect1074ui_story = var_124_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_11 = 0.034000001847744

			if 1.96599999815226 <= arg_121_1.time_ and arg_121_1.time_ < 1.96599999815226 + var_124_11 and not isNil(var_124_10) then
				if arg_121_1.var_.characterEffect1074ui_story and not isNil(var_124_10) then
					arg_121_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_121_1.var_.characterEffect1074ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_121_1.time_ - 1.96599999815226) / var_124_11)
				end
			end

			if arg_121_1.time_ >= 1.96599999815226 + var_124_11 and arg_121_1.time_ < 1.96599999815226 + var_124_11 + arg_124_0 and not isNil(var_124_10) and arg_121_1.var_.characterEffect1074ui_story then
				arg_121_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_121_1.var_.characterEffect1074ui_story.fillRatio = 0.5
			end

			local var_124_12 = 0

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= var_124_12 + arg_124_0 then
				arg_121_1.mask_.enabled = true
				arg_121_1.mask_.raycastTarget = true

				arg_121_1:SetGaussion(false)
			end

			local var_124_13 = 2

			if var_124_12 <= arg_121_1.time_ and arg_121_1.time_ < var_124_12 + var_124_13 then
				local var_124_14 = Color.New(0, 0, 0)

				var_124_14.a = Mathf.Lerp(0, 1, (arg_121_1.time_ - var_124_12) / var_124_13)
				arg_121_1.mask_.color = var_124_14
			end

			if arg_121_1.time_ >= var_124_12 + var_124_13 and arg_121_1.time_ < var_124_12 + var_124_13 + arg_124_0 then
				local var_124_15 = Color.New(0, 0, 0)

				var_124_15.a = 1
				arg_121_1.mask_.color = var_124_15
			end

			local var_124_16 = 2

			if 2 < arg_121_1.time_ and arg_121_1.time_ <= var_124_16 + arg_124_0 then
				arg_121_1.mask_.enabled = true
				arg_121_1.mask_.raycastTarget = true

				arg_121_1:SetGaussion(false)
			end

			local var_124_17 = 2

			if var_124_16 <= arg_121_1.time_ and arg_121_1.time_ < var_124_16 + var_124_17 then
				local var_124_18 = Color.New(0, 0, 0)

				var_124_18.a = Mathf.Lerp(1, 0, (arg_121_1.time_ - var_124_16) / var_124_17)
				arg_121_1.mask_.color = var_124_18
			end

			if arg_121_1.time_ >= var_124_16 + var_124_17 and arg_121_1.time_ < var_124_16 + var_124_17 + arg_124_0 then
				local var_124_19 = Color.New(0, 0, 0)

				arg_121_1.mask_.enabled = false
				var_124_19.a = 0
				arg_121_1.mask_.color = var_124_19
			end

			if arg_121_1.frameCnt_ <= 1 then
				arg_121_1.dialog_:SetActive(false)
			end

			local var_124_20 = 4
			local var_124_21 = 0.3

			if 4 < arg_121_1.time_ and arg_121_1.time_ <= var_124_20 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0

				arg_121_1.dialog_:SetActive(true)

				arg_121_1.dialogCg_.alpha = 0

				local var_124_22 = LeanTween.value(arg_121_1.dialog_, 0, 1, 0.3)

				var_124_22:setOnUpdate(LuaHelper.FloatAction(function(arg_125_0)
					arg_121_1.dialogCg_.alpha = arg_125_0
				end))
				var_124_22:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_121_1.dialog_)
					var_124_22:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_121_1.duration_ = arg_121_1.duration_ + 0.3

				SetActive(arg_121_1.leftNameGo_, false)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_23 = arg_121_1:FormatText(arg_121_1:GetWordFromCfg(222072029).content)

				arg_121_1.text_.text = var_124_23

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_25 = 12 <= 0 and var_124_21 or var_124_21 * (utf8.len(var_124_23) / 12)

				if (12 <= 0 and var_124_21 or var_124_21 * (utf8.len(var_124_23) / 12)) > 0 and var_124_21 < var_124_25 then
					arg_121_1.talkMaxDuration = var_124_25
					var_124_20 = var_124_20 + 0.3

					if var_124_25 + var_124_20 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_25 + var_124_20
					end
				end

				arg_121_1.text_.text = var_124_23
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)
				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_26 = var_124_20 + 0.3
			local var_124_27 = math.max(var_124_21, arg_121_1.talkMaxDuration)

			if var_124_20 + 0.3 <= arg_121_1.time_ and arg_121_1.time_ < var_124_26 + var_124_27 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_26) / var_124_27

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_26 + var_124_27 and arg_121_1.time_ < var_124_26 + var_124_27 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_121_1:InitPlayNodeList()
	end,
	Play222072030 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 222072030
		arg_127_1.duration_ = 11.43

		local var_127_0 = {
			ja = 11.433,
			ko = 7.3,
			zh = 7.4
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
				arg_127_0:Play222072031(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			local var_130_0 = 0.725

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, true)

				arg_127_1.leftNameTxt_.text = arg_127_1:FormatText(StoryNameCfg[461].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, true)
				arg_127_1.iconController_:SetSelectedState("hero")

				arg_127_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_grandpaa")

				arg_127_1.callingController_:SetSelectedState("normal")

				arg_127_1.keyicon_.color = Color.New(1, 1, 1)
				arg_127_1.icon_.color = Color.New(1, 1, 1)

				local var_130_1 = arg_127_1:GetWordFromCfg(222072030)
				local var_130_2 = arg_127_1:FormatText(var_130_1.content)

				arg_127_1.text_.text = var_130_2

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_4 = 29 <= 0 and var_130_0 or var_130_0 * (utf8.len(var_130_2) / 29)

				if (29 <= 0 and var_130_0 or var_130_0 * (utf8.len(var_130_2) / 29)) > 0 and var_130_0 < var_130_4 then
					arg_127_1.talkMaxDuration = var_130_4

					if var_130_4 + 0 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_4 + 0
					end
				end

				arg_127_1.text_.text = var_130_2
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222072", "222072030", "story_v_out_222072.awb") ~= 0 then
					local var_130_5 = manager.audio:GetVoiceLength("story_v_out_222072", "222072030", "story_v_out_222072.awb") / 1000

					if var_130_5 + 0 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_5 + 0
					end

					if var_130_1.prefab_name ~= "" and arg_127_1.actors_[var_130_1.prefab_name] ~= nil then
						local var_130_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_127_1.actors_[var_130_1.prefab_name].transform, "story_v_out_222072", "222072030", "story_v_out_222072.awb")

						arg_127_1:RecordAudio("222072030", var_130_6)
						arg_127_1:RecordAudio("222072030", var_130_6)
					else
						arg_127_1:AudioAction("play", "voice", "story_v_out_222072", "222072030", "story_v_out_222072.awb")
					end

					arg_127_1:RecordHistoryTalkVoice("story_v_out_222072", "222072030", "story_v_out_222072.awb")
				end

				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_7 = math.max(var_130_0, arg_127_1.talkMaxDuration)

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_7 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - 0) / var_130_7

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= 0 + var_130_7 and arg_127_1.time_ < 0 + var_130_7 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {}

		arg_127_1:InitPlayNodeList()
	end,
	Play222072031 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 222072031
		arg_131_1.duration_ = 5

		SetActive(arg_131_1.tipsGo_, false)

		function arg_131_1.onSingleLineFinish_()
			arg_131_1.onSingleLineUpdate_ = nil
			arg_131_1.onSingleLineFinish_ = nil
			arg_131_1.state_ = "waiting"
		end

		function arg_131_1.playNext_(arg_133_0)
			if arg_133_0 == 1 then
				arg_131_0:Play222072032(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			local var_134_0 = 1

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, false)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_1 = arg_131_1:FormatText(arg_131_1:GetWordFromCfg(222072031).content)

				arg_131_1.text_.text = var_134_1

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_3 = 40 <= 0 and var_134_0 or var_134_0 * (utf8.len(var_134_1) / 40)

				if (40 <= 0 and var_134_0 or var_134_0 * (utf8.len(var_134_1) / 40)) > 0 and var_134_0 < var_134_3 then
					arg_131_1.talkMaxDuration = var_134_3

					if var_134_3 + 0 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_3 + 0
					end
				end

				arg_131_1.text_.text = var_134_1
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)
				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_4 = math.max(var_134_0, arg_131_1.talkMaxDuration)

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_4 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - 0) / var_134_4

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= 0 + var_134_4 and arg_131_1.time_ < 0 + var_134_4 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {}

		arg_131_1:InitPlayNodeList()
	end,
	Play222072032 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 222072032
		arg_135_1.duration_ = 6.3

		local var_135_0 = {
			ja = 6.3,
			ko = 3.4,
			zh = 3.433
		}
		local var_135_1 = manager.audio:GetLocalizationFlag()

		if var_135_0[var_135_1] ~= nil then
			arg_135_1.duration_ = var_135_0[var_135_1]
		end

		SetActive(arg_135_1.tipsGo_, false)

		function arg_135_1.onSingleLineFinish_()
			arg_135_1.onSingleLineUpdate_ = nil
			arg_135_1.onSingleLineFinish_ = nil
			arg_135_1.state_ = "waiting"
		end

		function arg_135_1.playNext_(arg_137_0)
			if arg_137_0 == 1 then
				arg_135_0:Play222072033(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				arg_135_1.var_.moveOldPos1071ui_story = arg_135_1.actors_["1071ui_story"].transform.localPosition
			end

			local var_138_0 = 0.001

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_0 then
				arg_135_1.actors_["1071ui_story"].transform.localPosition = Vector3.Lerp(arg_135_1.var_.moveOldPos1071ui_story, Vector3.New(0, -1.05, -6.2), (arg_135_1.time_ - 0) / var_138_0)
				arg_135_1.actors_["1071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_135_1.actors_["1071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_135_1.actors_["1071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_135_1.actors_["1071ui_story"].transform.position).z)
				arg_135_1.actors_["1071ui_story"].transform.localEulerAngles.z = 0
				arg_135_1.actors_["1071ui_story"].transform.localEulerAngles.x = 0
				arg_135_1.actors_["1071ui_story"].transform.localEulerAngles = arg_135_1.actors_["1071ui_story"].transform.localEulerAngles
			end

			if arg_135_1.time_ >= 0 + var_138_0 and arg_135_1.time_ < 0 + var_138_0 + arg_138_0 then
				arg_135_1.actors_["1071ui_story"].transform.localPosition = Vector3.New(0, -1.05, -6.2)
				arg_135_1.actors_["1071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_135_1.actors_["1071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_135_1.actors_["1071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_135_1.actors_["1071ui_story"].transform.position).z)
				arg_135_1.actors_["1071ui_story"].transform.localEulerAngles.z = 0
				arg_135_1.actors_["1071ui_story"].transform.localEulerAngles.x = 0
				arg_135_1.actors_["1071ui_story"].transform.localEulerAngles = arg_135_1.actors_["1071ui_story"].transform.localEulerAngles
			end

			local var_138_1 = arg_135_1.actors_["1071ui_story"]

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 and not isNil(var_138_1) and arg_135_1.var_.characterEffect1071ui_story == nil then
				arg_135_1.var_.characterEffect1071ui_story = var_138_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_138_2 = 0.200000002980232

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_2 and not isNil(var_138_1) then
				if arg_135_1.var_.characterEffect1071ui_story and not isNil(var_138_1) then
					arg_135_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_135_1.time_ >= 0 + var_138_2 and arg_135_1.time_ < 0 + var_138_2 + arg_138_0 and not isNil(var_138_1) and arg_135_1.var_.characterEffect1071ui_story then
				arg_135_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				arg_135_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action1_1")
			end

			local var_138_4 = 0
			local var_138_5 = 0.2

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= var_138_4 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				arg_135_1.leftNameTxt_.text = arg_135_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_6 = arg_135_1:GetWordFromCfg(222072032)
				local var_138_7 = arg_135_1:FormatText(var_138_6.content)

				arg_135_1.text_.text = var_138_7

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_9 = 8 <= 0 and var_138_5 or var_138_5 * (utf8.len(var_138_7) / 8)

				if (8 <= 0 and var_138_5 or var_138_5 * (utf8.len(var_138_7) / 8)) > 0 and var_138_5 < var_138_9 then
					arg_135_1.talkMaxDuration = var_138_9

					if var_138_9 + var_138_4 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_9 + var_138_4
					end
				end

				arg_135_1.text_.text = var_138_7
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222072", "222072032", "story_v_out_222072.awb") ~= 0 then
					local var_138_10 = manager.audio:GetVoiceLength("story_v_out_222072", "222072032", "story_v_out_222072.awb") / 1000

					if var_138_10 + var_138_4 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_10 + var_138_4
					end

					if var_138_6.prefab_name ~= "" and arg_135_1.actors_[var_138_6.prefab_name] ~= nil then
						local var_138_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_135_1.actors_[var_138_6.prefab_name].transform, "story_v_out_222072", "222072032", "story_v_out_222072.awb")

						arg_135_1:RecordAudio("222072032", var_138_11)
						arg_135_1:RecordAudio("222072032", var_138_11)
					else
						arg_135_1:AudioAction("play", "voice", "story_v_out_222072", "222072032", "story_v_out_222072.awb")
					end

					arg_135_1:RecordHistoryTalkVoice("story_v_out_222072", "222072032", "story_v_out_222072.awb")
				end

				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_12 = math.max(var_138_5, arg_135_1.talkMaxDuration)

			if var_138_4 <= arg_135_1.time_ and arg_135_1.time_ < var_138_4 + var_138_12 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_4) / var_138_12

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_4 + var_138_12 and arg_135_1.time_ < var_138_4 + var_138_12 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_135_1:InitPlayNodeList()
	end,
	Play222072033 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 222072033
		arg_139_1.duration_ = 11.03

		local var_139_0 = {
			ja = 11.033,
			ko = 9.433,
			zh = 9.433
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
				arg_139_0:Play222072034(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 and not isNil(arg_139_1.actors_["1071ui_story"]) and arg_139_1.var_.characterEffect1071ui_story == nil then
				arg_139_1.var_.characterEffect1071ui_story = arg_139_1.actors_["1071ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_142_0 = 0.2

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_0 and not isNil(arg_139_1.actors_["1071ui_story"]) then
				if arg_139_1.var_.characterEffect1071ui_story and not isNil(arg_139_1.actors_["1071ui_story"]) then
					arg_139_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_139_1.var_.characterEffect1071ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_139_1.time_ - 0) / var_142_0)
				end
			end

			if arg_139_1.time_ >= 0 + var_142_0 and arg_139_1.time_ < 0 + var_142_0 + arg_142_0 and not isNil(arg_139_1.actors_["1071ui_story"]) and arg_139_1.var_.characterEffect1071ui_story then
				arg_139_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_139_1.var_.characterEffect1071ui_story.fillRatio = 0.5
			end

			local var_142_1 = 0
			local var_142_2 = 0.9

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= var_142_1 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				arg_139_1.leftNameTxt_.text = arg_139_1:FormatText(StoryNameCfg[461].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, true)
				arg_139_1.iconController_:SetSelectedState("hero")

				arg_139_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_grandpaa")

				arg_139_1.callingController_:SetSelectedState("normal")

				arg_139_1.keyicon_.color = Color.New(1, 1, 1)
				arg_139_1.icon_.color = Color.New(1, 1, 1)

				local var_142_3 = arg_139_1:GetWordFromCfg(222072033)
				local var_142_4 = arg_139_1:FormatText(var_142_3.content)

				arg_139_1.text_.text = var_142_4

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_6 = 36 <= 0 and var_142_2 or var_142_2 * (utf8.len(var_142_4) / 36)

				if (36 <= 0 and var_142_2 or var_142_2 * (utf8.len(var_142_4) / 36)) > 0 and var_142_2 < var_142_6 then
					arg_139_1.talkMaxDuration = var_142_6

					if var_142_6 + var_142_1 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_6 + var_142_1
					end
				end

				arg_139_1.text_.text = var_142_4
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222072", "222072033", "story_v_out_222072.awb") ~= 0 then
					local var_142_7 = manager.audio:GetVoiceLength("story_v_out_222072", "222072033", "story_v_out_222072.awb") / 1000

					if var_142_7 + var_142_1 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_7 + var_142_1
					end

					if var_142_3.prefab_name ~= "" and arg_139_1.actors_[var_142_3.prefab_name] ~= nil then
						local var_142_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_139_1.actors_[var_142_3.prefab_name].transform, "story_v_out_222072", "222072033", "story_v_out_222072.awb")

						arg_139_1:RecordAudio("222072033", var_142_8)
						arg_139_1:RecordAudio("222072033", var_142_8)
					else
						arg_139_1:AudioAction("play", "voice", "story_v_out_222072", "222072033", "story_v_out_222072.awb")
					end

					arg_139_1:RecordHistoryTalkVoice("story_v_out_222072", "222072033", "story_v_out_222072.awb")
				end

				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_9 = math.max(var_142_2, arg_139_1.talkMaxDuration)

			if var_142_1 <= arg_139_1.time_ and arg_139_1.time_ < var_142_1 + var_142_9 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_1) / var_142_9

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_1 + var_142_9 and arg_139_1.time_ < var_142_1 + var_142_9 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {}

		arg_139_1:InitPlayNodeList()
	end,
	Play222072034 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 222072034
		arg_143_1.duration_ = 5

		SetActive(arg_143_1.tipsGo_, false)

		function arg_143_1.onSingleLineFinish_()
			arg_143_1.onSingleLineUpdate_ = nil
			arg_143_1.onSingleLineFinish_ = nil
			arg_143_1.state_ = "waiting"
		end

		function arg_143_1.playNext_(arg_145_0)
			if arg_145_0 == 1 then
				arg_143_0:Play222072035(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1.var_.moveOldPos1071ui_story = arg_143_1.actors_["1071ui_story"].transform.localPosition
			end

			local var_146_0 = 0.001

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_0 then
				arg_143_1.actors_["1071ui_story"].transform.localPosition = Vector3.Lerp(arg_143_1.var_.moveOldPos1071ui_story, Vector3.New(0, 100, 0), (arg_143_1.time_ - 0) / var_146_0)
				arg_143_1.actors_["1071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_143_1.actors_["1071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_143_1.actors_["1071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_143_1.actors_["1071ui_story"].transform.position).z)
				arg_143_1.actors_["1071ui_story"].transform.localEulerAngles.z = 0
				arg_143_1.actors_["1071ui_story"].transform.localEulerAngles.x = 0
				arg_143_1.actors_["1071ui_story"].transform.localEulerAngles = arg_143_1.actors_["1071ui_story"].transform.localEulerAngles
			end

			if arg_143_1.time_ >= 0 + var_146_0 and arg_143_1.time_ < 0 + var_146_0 + arg_146_0 then
				arg_143_1.actors_["1071ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_143_1.actors_["1071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_143_1.actors_["1071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_143_1.actors_["1071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_143_1.actors_["1071ui_story"].transform.position).z)
				arg_143_1.actors_["1071ui_story"].transform.localEulerAngles.z = 0
				arg_143_1.actors_["1071ui_story"].transform.localEulerAngles.x = 0
				arg_143_1.actors_["1071ui_story"].transform.localEulerAngles = arg_143_1.actors_["1071ui_story"].transform.localEulerAngles
			end

			local var_146_1 = arg_143_1.actors_["1071ui_story"]

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 and not isNil(var_146_1) and arg_143_1.var_.characterEffect1071ui_story == nil then
				arg_143_1.var_.characterEffect1071ui_story = var_146_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_146_2 = 0.200000002980232

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_2 and not isNil(var_146_1) then
				if arg_143_1.var_.characterEffect1071ui_story and not isNil(var_146_1) then
					arg_143_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_143_1.var_.characterEffect1071ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_143_1.time_ - 0) / var_146_2)
				end
			end

			if arg_143_1.time_ >= 0 + var_146_2 and arg_143_1.time_ < 0 + var_146_2 + arg_146_0 and not isNil(var_146_1) and arg_143_1.var_.characterEffect1071ui_story then
				arg_143_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_143_1.var_.characterEffect1071ui_story.fillRatio = 0.5
			end

			local var_146_3 = 0
			local var_146_4 = 0.675

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= var_146_3 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, false)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_143_1.iconTrs_.gameObject, false)
				arg_143_1.callingController_:SetSelectedState("normal")

				local var_146_5 = arg_143_1:FormatText(arg_143_1:GetWordFromCfg(222072034).content)

				arg_143_1.text_.text = var_146_5

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_7 = 27 <= 0 and var_146_4 or var_146_4 * (utf8.len(var_146_5) / 27)

				if (27 <= 0 and var_146_4 or var_146_4 * (utf8.len(var_146_5) / 27)) > 0 and var_146_4 < var_146_7 then
					arg_143_1.talkMaxDuration = var_146_7

					if var_146_7 + var_146_3 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_7 + var_146_3
					end
				end

				arg_143_1.text_.text = var_146_5
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)
				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_8 = math.max(var_146_4, arg_143_1.talkMaxDuration)

			if var_146_3 <= arg_143_1.time_ and arg_143_1.time_ < var_146_3 + var_146_8 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_3) / var_146_8

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_3 + var_146_8 and arg_143_1.time_ < var_146_3 + var_146_8 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_143_1:InitPlayNodeList()
	end,
	Play222072035 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 222072035
		arg_147_1.duration_ = 5

		SetActive(arg_147_1.tipsGo_, false)

		function arg_147_1.onSingleLineFinish_()
			arg_147_1.onSingleLineUpdate_ = nil
			arg_147_1.onSingleLineFinish_ = nil
			arg_147_1.state_ = "waiting"
		end

		function arg_147_1.playNext_(arg_149_0)
			if arg_149_0 == 1 then
				arg_147_0:Play222072036(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			local var_150_0 = 1.675

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, false)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_1 = arg_147_1:FormatText(arg_147_1:GetWordFromCfg(222072035).content)

				arg_147_1.text_.text = var_150_1

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_3 = 67 <= 0 and var_150_0 or var_150_0 * (utf8.len(var_150_1) / 67)

				if (67 <= 0 and var_150_0 or var_150_0 * (utf8.len(var_150_1) / 67)) > 0 and var_150_0 < var_150_3 then
					arg_147_1.talkMaxDuration = var_150_3

					if var_150_3 + 0 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_3 + 0
					end
				end

				arg_147_1.text_.text = var_150_1
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)
				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_4 = math.max(var_150_0, arg_147_1.talkMaxDuration)

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_4 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - 0) / var_150_4

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= 0 + var_150_4 and arg_147_1.time_ < 0 + var_150_4 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {}

		arg_147_1:InitPlayNodeList()
	end,
	Play222072036 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 222072036
		arg_151_1.duration_ = 7.87

		local var_151_0 = {
			ja = 7.866,
			ko = 4.6,
			zh = 4.6
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
				arg_151_0:Play222072037(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 then
				arg_151_1.var_.moveOldPos1074ui_story = arg_151_1.actors_["1074ui_story"].transform.localPosition
			end

			local var_154_0 = 0.001

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_0 then
				arg_151_1.actors_["1074ui_story"].transform.localPosition = Vector3.Lerp(arg_151_1.var_.moveOldPos1074ui_story, Vector3.New(0, -1.055, -6.12), (arg_151_1.time_ - 0) / var_154_0)
				arg_151_1.actors_["1074ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_151_1.actors_["1074ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_151_1.actors_["1074ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_151_1.actors_["1074ui_story"].transform.position).z)
				arg_151_1.actors_["1074ui_story"].transform.localEulerAngles.z = 0
				arg_151_1.actors_["1074ui_story"].transform.localEulerAngles.x = 0
				arg_151_1.actors_["1074ui_story"].transform.localEulerAngles = arg_151_1.actors_["1074ui_story"].transform.localEulerAngles
			end

			if arg_151_1.time_ >= 0 + var_154_0 and arg_151_1.time_ < 0 + var_154_0 + arg_154_0 then
				arg_151_1.actors_["1074ui_story"].transform.localPosition = Vector3.New(0, -1.055, -6.12)
				arg_151_1.actors_["1074ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_151_1.actors_["1074ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_151_1.actors_["1074ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_151_1.actors_["1074ui_story"].transform.position).z)
				arg_151_1.actors_["1074ui_story"].transform.localEulerAngles.z = 0
				arg_151_1.actors_["1074ui_story"].transform.localEulerAngles.x = 0
				arg_151_1.actors_["1074ui_story"].transform.localEulerAngles = arg_151_1.actors_["1074ui_story"].transform.localEulerAngles
			end

			local var_154_1 = arg_151_1.actors_["1074ui_story"]

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 and not isNil(var_154_1) and arg_151_1.var_.characterEffect1074ui_story == nil then
				arg_151_1.var_.characterEffect1074ui_story = var_154_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_154_2 = 0.200000002980232

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_2 and not isNil(var_154_1) then
				if arg_151_1.var_.characterEffect1074ui_story and not isNil(var_154_1) then
					arg_151_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_151_1.time_ >= 0 + var_154_2 and arg_151_1.time_ < 0 + var_154_2 + arg_154_0 and not isNil(var_154_1) and arg_151_1.var_.characterEffect1074ui_story then
				arg_151_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 then
				arg_151_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action1_1")
			end

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 then
				arg_151_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_154_4 = 0
			local var_154_5 = 0.525

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= var_154_4 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				arg_151_1.leftNameTxt_.text = arg_151_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, false)
				arg_151_1.callingController_:SetSelectedState("normal")

				local var_154_6 = arg_151_1:GetWordFromCfg(222072036)
				local var_154_7 = arg_151_1:FormatText(var_154_6.content)

				arg_151_1.text_.text = var_154_7

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_9 = 21 <= 0 and var_154_5 or var_154_5 * (utf8.len(var_154_7) / 21)

				if (21 <= 0 and var_154_5 or var_154_5 * (utf8.len(var_154_7) / 21)) > 0 and var_154_5 < var_154_9 then
					arg_151_1.talkMaxDuration = var_154_9

					if var_154_9 + var_154_4 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_9 + var_154_4
					end
				end

				arg_151_1.text_.text = var_154_7
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222072", "222072036", "story_v_out_222072.awb") ~= 0 then
					local var_154_10 = manager.audio:GetVoiceLength("story_v_out_222072", "222072036", "story_v_out_222072.awb") / 1000

					if var_154_10 + var_154_4 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_10 + var_154_4
					end

					if var_154_6.prefab_name ~= "" and arg_151_1.actors_[var_154_6.prefab_name] ~= nil then
						local var_154_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_151_1.actors_[var_154_6.prefab_name].transform, "story_v_out_222072", "222072036", "story_v_out_222072.awb")

						arg_151_1:RecordAudio("222072036", var_154_11)
						arg_151_1:RecordAudio("222072036", var_154_11)
					else
						arg_151_1:AudioAction("play", "voice", "story_v_out_222072", "222072036", "story_v_out_222072.awb")
					end

					arg_151_1:RecordHistoryTalkVoice("story_v_out_222072", "222072036", "story_v_out_222072.awb")
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
				actorName = "1074ui_story",
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
	Play222072037 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 222072037
		arg_155_1.duration_ = 15.97

		local var_155_0 = {
			ja = 15.966,
			ko = 12.1,
			zh = 12.1
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
				arg_155_0:Play222072038(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 and not isNil(arg_155_1.actors_["1074ui_story"]) and arg_155_1.var_.characterEffect1074ui_story == nil then
				arg_155_1.var_.characterEffect1074ui_story = arg_155_1.actors_["1074ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_158_0 = 0.200000002980232

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_0 and not isNil(arg_155_1.actors_["1074ui_story"]) then
				if arg_155_1.var_.characterEffect1074ui_story and not isNil(arg_155_1.actors_["1074ui_story"]) then
					arg_155_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_155_1.var_.characterEffect1074ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_155_1.time_ - 0) / var_158_0)
				end
			end

			if arg_155_1.time_ >= 0 + var_158_0 and arg_155_1.time_ < 0 + var_158_0 + arg_158_0 and not isNil(arg_155_1.actors_["1074ui_story"]) and arg_155_1.var_.characterEffect1074ui_story then
				arg_155_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_155_1.var_.characterEffect1074ui_story.fillRatio = 0.5
			end

			local var_158_1 = 0
			local var_158_2 = 1.05

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= var_158_1 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, true)

				arg_155_1.leftNameTxt_.text = arg_155_1:FormatText(StoryNameCfg[461].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, true)
				arg_155_1.iconController_:SetSelectedState("hero")

				arg_155_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_grandpaa")

				arg_155_1.callingController_:SetSelectedState("normal")

				arg_155_1.keyicon_.color = Color.New(1, 1, 1)
				arg_155_1.icon_.color = Color.New(1, 1, 1)

				local var_158_3 = arg_155_1:GetWordFromCfg(222072037)
				local var_158_4 = arg_155_1:FormatText(var_158_3.content)

				arg_155_1.text_.text = var_158_4

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_6 = 42 <= 0 and var_158_2 or var_158_2 * (utf8.len(var_158_4) / 42)

				if (42 <= 0 and var_158_2 or var_158_2 * (utf8.len(var_158_4) / 42)) > 0 and var_158_2 < var_158_6 then
					arg_155_1.talkMaxDuration = var_158_6

					if var_158_6 + var_158_1 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_6 + var_158_1
					end
				end

				arg_155_1.text_.text = var_158_4
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222072", "222072037", "story_v_out_222072.awb") ~= 0 then
					local var_158_7 = manager.audio:GetVoiceLength("story_v_out_222072", "222072037", "story_v_out_222072.awb") / 1000

					if var_158_7 + var_158_1 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_7 + var_158_1
					end

					if var_158_3.prefab_name ~= "" and arg_155_1.actors_[var_158_3.prefab_name] ~= nil then
						local var_158_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_155_1.actors_[var_158_3.prefab_name].transform, "story_v_out_222072", "222072037", "story_v_out_222072.awb")

						arg_155_1:RecordAudio("222072037", var_158_8)
						arg_155_1:RecordAudio("222072037", var_158_8)
					else
						arg_155_1:AudioAction("play", "voice", "story_v_out_222072", "222072037", "story_v_out_222072.awb")
					end

					arg_155_1:RecordHistoryTalkVoice("story_v_out_222072", "222072037", "story_v_out_222072.awb")
				end

				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_9 = math.max(var_158_2, arg_155_1.talkMaxDuration)

			if var_158_1 <= arg_155_1.time_ and arg_155_1.time_ < var_158_1 + var_158_9 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - var_158_1) / var_158_9

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= var_158_1 + var_158_9 and arg_155_1.time_ < var_158_1 + var_158_9 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {}

		arg_155_1:InitPlayNodeList()
	end,
	Play222072038 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 222072038
		arg_159_1.duration_ = 13.67

		local var_159_0 = {
			ja = 12.9,
			ko = 13.5,
			zh = 13.666
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
				arg_159_0:Play222072039(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			local var_162_0 = 1.225

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, true)

				arg_159_1.leftNameTxt_.text = arg_159_1:FormatText(StoryNameCfg[461].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_159_1.leftNameTxt_.transform)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1.leftNameTxt_.text)
				SetActive(arg_159_1.iconTrs_.gameObject, true)
				arg_159_1.iconController_:SetSelectedState("hero")

				arg_159_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_grandpaa")

				arg_159_1.callingController_:SetSelectedState("normal")

				arg_159_1.keyicon_.color = Color.New(1, 1, 1)
				arg_159_1.icon_.color = Color.New(1, 1, 1)

				local var_162_1 = arg_159_1:GetWordFromCfg(222072038)
				local var_162_2 = arg_159_1:FormatText(var_162_1.content)

				arg_159_1.text_.text = var_162_2

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_4 = 49 <= 0 and var_162_0 or var_162_0 * (utf8.len(var_162_2) / 49)

				if (49 <= 0 and var_162_0 or var_162_0 * (utf8.len(var_162_2) / 49)) > 0 and var_162_0 < var_162_4 then
					arg_159_1.talkMaxDuration = var_162_4

					if var_162_4 + 0 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_4 + 0
					end
				end

				arg_159_1.text_.text = var_162_2
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222072", "222072038", "story_v_out_222072.awb") ~= 0 then
					local var_162_5 = manager.audio:GetVoiceLength("story_v_out_222072", "222072038", "story_v_out_222072.awb") / 1000

					if var_162_5 + 0 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_5 + 0
					end

					if var_162_1.prefab_name ~= "" and arg_159_1.actors_[var_162_1.prefab_name] ~= nil then
						local var_162_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_159_1.actors_[var_162_1.prefab_name].transform, "story_v_out_222072", "222072038", "story_v_out_222072.awb")

						arg_159_1:RecordAudio("222072038", var_162_6)
						arg_159_1:RecordAudio("222072038", var_162_6)
					else
						arg_159_1:AudioAction("play", "voice", "story_v_out_222072", "222072038", "story_v_out_222072.awb")
					end

					arg_159_1:RecordHistoryTalkVoice("story_v_out_222072", "222072038", "story_v_out_222072.awb")
				end

				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_7 = math.max(var_162_0, arg_159_1.talkMaxDuration)

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_7 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - 0) / var_162_7

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= 0 + var_162_7 and arg_159_1.time_ < 0 + var_162_7 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {}

		arg_159_1:InitPlayNodeList()
	end,
	Play222072039 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 222072039
		arg_163_1.duration_ = 9.5

		local var_163_0 = {
			ja = 9.5,
			ko = 6.166,
			zh = 6.166
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
				arg_163_0:Play222072040(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			local var_166_0 = 0.575

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, true)

				arg_163_1.leftNameTxt_.text = arg_163_1:FormatText(StoryNameCfg[461].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_163_1.leftNameTxt_.transform)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1.leftNameTxt_.text)
				SetActive(arg_163_1.iconTrs_.gameObject, true)
				arg_163_1.iconController_:SetSelectedState("hero")

				arg_163_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_grandpaa")

				arg_163_1.callingController_:SetSelectedState("normal")

				arg_163_1.keyicon_.color = Color.New(1, 1, 1)
				arg_163_1.icon_.color = Color.New(1, 1, 1)

				local var_166_1 = arg_163_1:GetWordFromCfg(222072039)
				local var_166_2 = arg_163_1:FormatText(var_166_1.content)

				arg_163_1.text_.text = var_166_2

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_4 = 23 <= 0 and var_166_0 or var_166_0 * (utf8.len(var_166_2) / 23)

				if (23 <= 0 and var_166_0 or var_166_0 * (utf8.len(var_166_2) / 23)) > 0 and var_166_0 < var_166_4 then
					arg_163_1.talkMaxDuration = var_166_4

					if var_166_4 + 0 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_4 + 0
					end
				end

				arg_163_1.text_.text = var_166_2
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222072", "222072039", "story_v_out_222072.awb") ~= 0 then
					local var_166_5 = manager.audio:GetVoiceLength("story_v_out_222072", "222072039", "story_v_out_222072.awb") / 1000

					if var_166_5 + 0 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_5 + 0
					end

					if var_166_1.prefab_name ~= "" and arg_163_1.actors_[var_166_1.prefab_name] ~= nil then
						local var_166_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_163_1.actors_[var_166_1.prefab_name].transform, "story_v_out_222072", "222072039", "story_v_out_222072.awb")

						arg_163_1:RecordAudio("222072039", var_166_6)
						arg_163_1:RecordAudio("222072039", var_166_6)
					else
						arg_163_1:AudioAction("play", "voice", "story_v_out_222072", "222072039", "story_v_out_222072.awb")
					end

					arg_163_1:RecordHistoryTalkVoice("story_v_out_222072", "222072039", "story_v_out_222072.awb")
				end

				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_7 = math.max(var_166_0, arg_163_1.talkMaxDuration)

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_7 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - 0) / var_166_7

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= 0 + var_166_7 and arg_163_1.time_ < 0 + var_166_7 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {}

		arg_163_1:InitPlayNodeList()
	end,
	Play222072040 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 222072040
		arg_167_1.duration_ = 4.57

		local var_167_0 = {
			ja = 4.566,
			ko = 3.4,
			zh = 3.4
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
				arg_167_0:Play222072041(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 then
				arg_167_1.var_.moveOldPos1074ui_story = arg_167_1.actors_["1074ui_story"].transform.localPosition
			end

			local var_170_0 = 0.001

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_0 then
				arg_167_1.actors_["1074ui_story"].transform.localPosition = Vector3.Lerp(arg_167_1.var_.moveOldPos1074ui_story, Vector3.New(-0.7, -1.055, -6.12), (arg_167_1.time_ - 0) / var_170_0)
				arg_167_1.actors_["1074ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_167_1.actors_["1074ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_167_1.actors_["1074ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_167_1.actors_["1074ui_story"].transform.position).z)
				arg_167_1.actors_["1074ui_story"].transform.localEulerAngles.z = 0
				arg_167_1.actors_["1074ui_story"].transform.localEulerAngles.x = 0
				arg_167_1.actors_["1074ui_story"].transform.localEulerAngles = arg_167_1.actors_["1074ui_story"].transform.localEulerAngles
			end

			if arg_167_1.time_ >= 0 + var_170_0 and arg_167_1.time_ < 0 + var_170_0 + arg_170_0 then
				arg_167_1.actors_["1074ui_story"].transform.localPosition = Vector3.New(-0.7, -1.055, -6.12)
				arg_167_1.actors_["1074ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_167_1.actors_["1074ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_167_1.actors_["1074ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_167_1.actors_["1074ui_story"].transform.position).z)
				arg_167_1.actors_["1074ui_story"].transform.localEulerAngles.z = 0
				arg_167_1.actors_["1074ui_story"].transform.localEulerAngles.x = 0
				arg_167_1.actors_["1074ui_story"].transform.localEulerAngles = arg_167_1.actors_["1074ui_story"].transform.localEulerAngles
			end

			local var_170_1 = arg_167_1.actors_["1074ui_story"]

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 and not isNil(var_170_1) and arg_167_1.var_.characterEffect1074ui_story == nil then
				arg_167_1.var_.characterEffect1074ui_story = var_170_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_170_2 = 0.200000002980232

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_2 and not isNil(var_170_1) then
				if arg_167_1.var_.characterEffect1074ui_story and not isNil(var_170_1) then
					arg_167_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_167_1.var_.characterEffect1074ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_167_1.time_ - 0) / var_170_2)
				end
			end

			if arg_167_1.time_ >= 0 + var_170_2 and arg_167_1.time_ < 0 + var_170_2 + arg_170_0 and not isNil(var_170_1) and arg_167_1.var_.characterEffect1074ui_story then
				arg_167_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_167_1.var_.characterEffect1074ui_story.fillRatio = 0.5
			end

			local var_170_3 = arg_167_1.actors_["1070ui_story"].transform

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 then
				arg_167_1.var_.moveOldPos1070ui_story = var_170_3.localPosition
			end

			local var_170_4 = 0.001

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_4 then
				var_170_3.localPosition = Vector3.Lerp(arg_167_1.var_.moveOldPos1070ui_story, Vector3.New(0.7, -0.95, -6.05), (arg_167_1.time_ - 0) / var_170_4)
				var_170_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_170_3.position).x, (manager.ui.mainCamera.transform.position - var_170_3.position).y, (manager.ui.mainCamera.transform.position - var_170_3.position).z)
				var_170_3.localEulerAngles.z = 0
				var_170_3.localEulerAngles.x = 0
				var_170_3.localEulerAngles = var_170_3.localEulerAngles
			end

			if arg_167_1.time_ >= 0 + var_170_4 and arg_167_1.time_ < 0 + var_170_4 + arg_170_0 then
				var_170_3.localPosition = Vector3.New(0.7, -0.95, -6.05)
				var_170_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_170_3.position).x, (manager.ui.mainCamera.transform.position - var_170_3.position).y, (manager.ui.mainCamera.transform.position - var_170_3.position).z)
				var_170_3.localEulerAngles.z = 0
				var_170_3.localEulerAngles.x = 0
				var_170_3.localEulerAngles = var_170_3.localEulerAngles
			end

			local var_170_5 = arg_167_1.actors_["1070ui_story"]

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 and not isNil(var_170_5) and arg_167_1.var_.characterEffect1070ui_story == nil then
				arg_167_1.var_.characterEffect1070ui_story = var_170_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_170_6 = 0.200000002980232

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_6 and not isNil(var_170_5) then
				if arg_167_1.var_.characterEffect1070ui_story and not isNil(var_170_5) then
					arg_167_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_167_1.time_ >= 0 + var_170_6 and arg_167_1.time_ < 0 + var_170_6 + arg_170_0 and not isNil(var_170_5) and arg_167_1.var_.characterEffect1070ui_story then
				arg_167_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 then
				arg_167_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action3_1")
			end

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 then
				arg_167_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_170_8 = 0
			local var_170_9 = 0.4

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= var_170_8 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, true)

				arg_167_1.leftNameTxt_.text = arg_167_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, false)
				arg_167_1.callingController_:SetSelectedState("normal")

				local var_170_10 = arg_167_1:GetWordFromCfg(222072040)
				local var_170_11 = arg_167_1:FormatText(var_170_10.content)

				arg_167_1.text_.text = var_170_11

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_13 = 16 <= 0 and var_170_9 or var_170_9 * (utf8.len(var_170_11) / 16)

				if (16 <= 0 and var_170_9 or var_170_9 * (utf8.len(var_170_11) / 16)) > 0 and var_170_9 < var_170_13 then
					arg_167_1.talkMaxDuration = var_170_13

					if var_170_13 + var_170_8 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_13 + var_170_8
					end
				end

				arg_167_1.text_.text = var_170_11
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222072", "222072040", "story_v_out_222072.awb") ~= 0 then
					local var_170_14 = manager.audio:GetVoiceLength("story_v_out_222072", "222072040", "story_v_out_222072.awb") / 1000

					if var_170_14 + var_170_8 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_14 + var_170_8
					end

					if var_170_10.prefab_name ~= "" and arg_167_1.actors_[var_170_10.prefab_name] ~= nil then
						local var_170_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_167_1.actors_[var_170_10.prefab_name].transform, "story_v_out_222072", "222072040", "story_v_out_222072.awb")

						arg_167_1:RecordAudio("222072040", var_170_15)
						arg_167_1:RecordAudio("222072040", var_170_15)
					else
						arg_167_1:AudioAction("play", "voice", "story_v_out_222072", "222072040", "story_v_out_222072.awb")
					end

					arg_167_1:RecordHistoryTalkVoice("story_v_out_222072", "222072040", "story_v_out_222072.awb")
				end

				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_16 = math.max(var_170_9, arg_167_1.talkMaxDuration)

			if var_170_8 <= arg_167_1.time_ and arg_167_1.time_ < var_170_8 + var_170_16 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - var_170_8) / var_170_16

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= var_170_8 + var_170_16 and arg_167_1.time_ < var_170_8 + var_170_16 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_167_1:InitPlayNodeList()
	end,
	Play222072041 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 222072041
		arg_171_1.duration_ = 3.77

		local var_171_0 = {
			ja = 3.766,
			ko = 3.233,
			zh = 3.3
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
				arg_171_0:Play222072042(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 and not isNil(arg_171_1.actors_["1070ui_story"]) and arg_171_1.var_.characterEffect1070ui_story == nil then
				arg_171_1.var_.characterEffect1070ui_story = arg_171_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_174_0 = 0.200000002980232

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_0 and not isNil(arg_171_1.actors_["1070ui_story"]) then
				if arg_171_1.var_.characterEffect1070ui_story and not isNil(arg_171_1.actors_["1070ui_story"]) then
					arg_171_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_171_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_171_1.time_ - 0) / var_174_0)
				end
			end

			if arg_171_1.time_ >= 0 + var_174_0 and arg_171_1.time_ < 0 + var_174_0 + arg_174_0 and not isNil(arg_171_1.actors_["1070ui_story"]) and arg_171_1.var_.characterEffect1070ui_story then
				arg_171_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_171_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_174_1 = 0
			local var_174_2 = 0.2

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= var_174_1 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, true)

				arg_171_1.leftNameTxt_.text = arg_171_1:FormatText(StoryNameCfg[461].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_171_1.leftNameTxt_.transform)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1.leftNameTxt_.text)
				SetActive(arg_171_1.iconTrs_.gameObject, true)
				arg_171_1.iconController_:SetSelectedState("hero")

				arg_171_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_grandpaa")

				arg_171_1.callingController_:SetSelectedState("normal")

				arg_171_1.keyicon_.color = Color.New(1, 1, 1)
				arg_171_1.icon_.color = Color.New(1, 1, 1)

				local var_174_3 = arg_171_1:GetWordFromCfg(222072041)
				local var_174_4 = arg_171_1:FormatText(var_174_3.content)

				arg_171_1.text_.text = var_174_4

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_6 = 8 <= 0 and var_174_2 or var_174_2 * (utf8.len(var_174_4) / 8)

				if (8 <= 0 and var_174_2 or var_174_2 * (utf8.len(var_174_4) / 8)) > 0 and var_174_2 < var_174_6 then
					arg_171_1.talkMaxDuration = var_174_6

					if var_174_6 + var_174_1 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_6 + var_174_1
					end
				end

				arg_171_1.text_.text = var_174_4
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222072", "222072041", "story_v_out_222072.awb") ~= 0 then
					local var_174_7 = manager.audio:GetVoiceLength("story_v_out_222072", "222072041", "story_v_out_222072.awb") / 1000

					if var_174_7 + var_174_1 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_7 + var_174_1
					end

					if var_174_3.prefab_name ~= "" and arg_171_1.actors_[var_174_3.prefab_name] ~= nil then
						local var_174_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_171_1.actors_[var_174_3.prefab_name].transform, "story_v_out_222072", "222072041", "story_v_out_222072.awb")

						arg_171_1:RecordAudio("222072041", var_174_8)
						arg_171_1:RecordAudio("222072041", var_174_8)
					else
						arg_171_1:AudioAction("play", "voice", "story_v_out_222072", "222072041", "story_v_out_222072.awb")
					end

					arg_171_1:RecordHistoryTalkVoice("story_v_out_222072", "222072041", "story_v_out_222072.awb")
				end

				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_9 = math.max(var_174_2, arg_171_1.talkMaxDuration)

			if var_174_1 <= arg_171_1.time_ and arg_171_1.time_ < var_174_1 + var_174_9 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - var_174_1) / var_174_9

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= var_174_1 + var_174_9 and arg_171_1.time_ < var_174_1 + var_174_9 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {}

		arg_171_1:InitPlayNodeList()
	end,
	Play222072042 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 222072042
		arg_175_1.duration_ = 10.63

		local var_175_0 = {
			ja = 10.633,
			ko = 8.6,
			zh = 8.6
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
				arg_175_0:Play222072043(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 then
				arg_175_1.var_.moveOldPos1070ui_story = arg_175_1.actors_["1070ui_story"].transform.localPosition
			end

			local var_178_0 = 0.001

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_0 then
				arg_175_1.actors_["1070ui_story"].transform.localPosition = Vector3.Lerp(arg_175_1.var_.moveOldPos1070ui_story, Vector3.New(0, 100, 0), (arg_175_1.time_ - 0) / var_178_0)
				arg_175_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_175_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_175_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_175_1.actors_["1070ui_story"].transform.position).z)
				arg_175_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_175_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_175_1.actors_["1070ui_story"].transform.localEulerAngles = arg_175_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			if arg_175_1.time_ >= 0 + var_178_0 and arg_175_1.time_ < 0 + var_178_0 + arg_178_0 then
				arg_175_1.actors_["1070ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_175_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_175_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_175_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_175_1.actors_["1070ui_story"].transform.position).z)
				arg_175_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_175_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_175_1.actors_["1070ui_story"].transform.localEulerAngles = arg_175_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			local var_178_1 = arg_175_1.actors_["1070ui_story"]

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 and not isNil(var_178_1) and arg_175_1.var_.characterEffect1070ui_story == nil then
				arg_175_1.var_.characterEffect1070ui_story = var_178_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_178_2 = 0.200000002980232

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_2 and not isNil(var_178_1) then
				if arg_175_1.var_.characterEffect1070ui_story and not isNil(var_178_1) then
					arg_175_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_175_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_175_1.time_ - 0) / var_178_2)
				end
			end

			if arg_175_1.time_ >= 0 + var_178_2 and arg_175_1.time_ < 0 + var_178_2 + arg_178_0 and not isNil(var_178_1) and arg_175_1.var_.characterEffect1070ui_story then
				arg_175_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_175_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_178_3 = arg_175_1.actors_["1071ui_story"].transform

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 then
				arg_175_1.var_.moveOldPos1071ui_story = var_178_3.localPosition
			end

			local var_178_4 = 0.001

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_4 then
				var_178_3.localPosition = Vector3.Lerp(arg_175_1.var_.moveOldPos1071ui_story, Vector3.New(0.7, -1.05, -6.2), (arg_175_1.time_ - 0) / var_178_4)
				var_178_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_178_3.position).x, (manager.ui.mainCamera.transform.position - var_178_3.position).y, (manager.ui.mainCamera.transform.position - var_178_3.position).z)
				var_178_3.localEulerAngles.z = 0
				var_178_3.localEulerAngles.x = 0
				var_178_3.localEulerAngles = var_178_3.localEulerAngles
			end

			if arg_175_1.time_ >= 0 + var_178_4 and arg_175_1.time_ < 0 + var_178_4 + arg_178_0 then
				var_178_3.localPosition = Vector3.New(0.7, -1.05, -6.2)
				var_178_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_178_3.position).x, (manager.ui.mainCamera.transform.position - var_178_3.position).y, (manager.ui.mainCamera.transform.position - var_178_3.position).z)
				var_178_3.localEulerAngles.z = 0
				var_178_3.localEulerAngles.x = 0
				var_178_3.localEulerAngles = var_178_3.localEulerAngles
			end

			local var_178_5 = arg_175_1.actors_["1071ui_story"]

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 and not isNil(var_178_5) and arg_175_1.var_.characterEffect1071ui_story == nil then
				arg_175_1.var_.characterEffect1071ui_story = var_178_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_178_6 = 0.200000002980232

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_6 and not isNil(var_178_5) then
				if arg_175_1.var_.characterEffect1071ui_story and not isNil(var_178_5) then
					arg_175_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_175_1.time_ >= 0 + var_178_6 and arg_175_1.time_ < 0 + var_178_6 + arg_178_0 and not isNil(var_178_5) and arg_175_1.var_.characterEffect1071ui_story then
				arg_175_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 then
				arg_175_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action1_1")
			end

			local var_178_8 = 0
			local var_178_9 = 0.975

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= var_178_8 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, true)

				arg_175_1.leftNameTxt_.text = arg_175_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_175_1.leftNameTxt_.transform)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1.leftNameTxt_.text)
				SetActive(arg_175_1.iconTrs_.gameObject, false)
				arg_175_1.callingController_:SetSelectedState("normal")

				local var_178_10 = arg_175_1:GetWordFromCfg(222072042)
				local var_178_11 = arg_175_1:FormatText(var_178_10.content)

				arg_175_1.text_.text = var_178_11

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_13 = 38 <= 0 and var_178_9 or var_178_9 * (utf8.len(var_178_11) / 38)

				if (38 <= 0 and var_178_9 or var_178_9 * (utf8.len(var_178_11) / 38)) > 0 and var_178_9 < var_178_13 then
					arg_175_1.talkMaxDuration = var_178_13

					if var_178_13 + var_178_8 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_13 + var_178_8
					end
				end

				arg_175_1.text_.text = var_178_11
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222072", "222072042", "story_v_out_222072.awb") ~= 0 then
					local var_178_14 = manager.audio:GetVoiceLength("story_v_out_222072", "222072042", "story_v_out_222072.awb") / 1000

					if var_178_14 + var_178_8 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_14 + var_178_8
					end

					if var_178_10.prefab_name ~= "" and arg_175_1.actors_[var_178_10.prefab_name] ~= nil then
						local var_178_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_175_1.actors_[var_178_10.prefab_name].transform, "story_v_out_222072", "222072042", "story_v_out_222072.awb")

						arg_175_1:RecordAudio("222072042", var_178_15)
						arg_175_1:RecordAudio("222072042", var_178_15)
					else
						arg_175_1:AudioAction("play", "voice", "story_v_out_222072", "222072042", "story_v_out_222072.awb")
					end

					arg_175_1:RecordHistoryTalkVoice("story_v_out_222072", "222072042", "story_v_out_222072.awb")
				end

				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_16 = math.max(var_178_9, arg_175_1.talkMaxDuration)

			if var_178_8 <= arg_175_1.time_ and arg_175_1.time_ < var_178_8 + var_178_16 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - var_178_8) / var_178_16

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= var_178_8 + var_178_16 and arg_175_1.time_ < var_178_8 + var_178_16 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_175_1:InitPlayNodeList()
	end,
	Play222072043 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 222072043
		arg_179_1.duration_ = 8.6

		local var_179_0 = {
			ja = 8.6,
			ko = 5.533,
			zh = 5.533
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
				arg_179_0:Play222072044(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 then
				arg_179_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action3_1")
			end

			local var_182_0 = 0
			local var_182_1 = 0.65

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= var_182_0 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, true)

				arg_179_1.leftNameTxt_.text = arg_179_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_179_1.leftNameTxt_.transform)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1.leftNameTxt_.text)
				SetActive(arg_179_1.iconTrs_.gameObject, false)
				arg_179_1.callingController_:SetSelectedState("normal")

				local var_182_2 = arg_179_1:GetWordFromCfg(222072043)
				local var_182_3 = arg_179_1:FormatText(var_182_2.content)

				arg_179_1.text_.text = var_182_3

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_5 = 26 <= 0 and var_182_1 or var_182_1 * (utf8.len(var_182_3) / 26)

				if (26 <= 0 and var_182_1 or var_182_1 * (utf8.len(var_182_3) / 26)) > 0 and var_182_1 < var_182_5 then
					arg_179_1.talkMaxDuration = var_182_5

					if var_182_5 + var_182_0 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_5 + var_182_0
					end
				end

				arg_179_1.text_.text = var_182_3
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222072", "222072043", "story_v_out_222072.awb") ~= 0 then
					local var_182_6 = manager.audio:GetVoiceLength("story_v_out_222072", "222072043", "story_v_out_222072.awb") / 1000

					if var_182_6 + var_182_0 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_6 + var_182_0
					end

					if var_182_2.prefab_name ~= "" and arg_179_1.actors_[var_182_2.prefab_name] ~= nil then
						local var_182_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_179_1.actors_[var_182_2.prefab_name].transform, "story_v_out_222072", "222072043", "story_v_out_222072.awb")

						arg_179_1:RecordAudio("222072043", var_182_7)
						arg_179_1:RecordAudio("222072043", var_182_7)
					else
						arg_179_1:AudioAction("play", "voice", "story_v_out_222072", "222072043", "story_v_out_222072.awb")
					end

					arg_179_1:RecordHistoryTalkVoice("story_v_out_222072", "222072043", "story_v_out_222072.awb")
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
	Play222072044 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 222072044
		arg_183_1.duration_ = 11.13

		local var_183_0 = {
			ja = 11.133,
			ko = 7.9,
			zh = 7.9
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
				arg_183_0:Play222072045(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 and not isNil(arg_183_1.actors_["1074ui_story"]) and arg_183_1.var_.characterEffect1074ui_story == nil then
				arg_183_1.var_.characterEffect1074ui_story = arg_183_1.actors_["1074ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_186_0 = 0.200000002980232

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_0 and not isNil(arg_183_1.actors_["1074ui_story"]) then
				if arg_183_1.var_.characterEffect1074ui_story and not isNil(arg_183_1.actors_["1074ui_story"]) then
					arg_183_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_183_1.time_ >= 0 + var_186_0 and arg_183_1.time_ < 0 + var_186_0 + arg_186_0 and not isNil(arg_183_1.actors_["1074ui_story"]) and arg_183_1.var_.characterEffect1074ui_story then
				arg_183_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				arg_183_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action5_1")
			end

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				arg_183_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_186_2 = arg_183_1.actors_["1071ui_story"]

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 and not isNil(var_186_2) and arg_183_1.var_.characterEffect1071ui_story == nil then
				arg_183_1.var_.characterEffect1071ui_story = var_186_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_186_3 = 0.200000002980232

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_3 and not isNil(var_186_2) then
				if arg_183_1.var_.characterEffect1071ui_story and not isNil(var_186_2) then
					arg_183_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_183_1.var_.characterEffect1071ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_183_1.time_ - 0) / var_186_3)
				end
			end

			if arg_183_1.time_ >= 0 + var_186_3 and arg_183_1.time_ < 0 + var_186_3 + arg_186_0 and not isNil(var_186_2) and arg_183_1.var_.characterEffect1071ui_story then
				arg_183_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_183_1.var_.characterEffect1071ui_story.fillRatio = 0.5
			end

			local var_186_4 = 0
			local var_186_5 = 0.775

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= var_186_4 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, true)

				arg_183_1.leftNameTxt_.text = arg_183_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_183_1.leftNameTxt_.transform)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1.leftNameTxt_.text)
				SetActive(arg_183_1.iconTrs_.gameObject, false)
				arg_183_1.callingController_:SetSelectedState("normal")

				local var_186_6 = arg_183_1:GetWordFromCfg(222072044)
				local var_186_7 = arg_183_1:FormatText(var_186_6.content)

				arg_183_1.text_.text = var_186_7

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_9 = 31 <= 0 and var_186_5 or var_186_5 * (utf8.len(var_186_7) / 31)

				if (31 <= 0 and var_186_5 or var_186_5 * (utf8.len(var_186_7) / 31)) > 0 and var_186_5 < var_186_9 then
					arg_183_1.talkMaxDuration = var_186_9

					if var_186_9 + var_186_4 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_9 + var_186_4
					end
				end

				arg_183_1.text_.text = var_186_7
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222072", "222072044", "story_v_out_222072.awb") ~= 0 then
					local var_186_10 = manager.audio:GetVoiceLength("story_v_out_222072", "222072044", "story_v_out_222072.awb") / 1000

					if var_186_10 + var_186_4 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_10 + var_186_4
					end

					if var_186_6.prefab_name ~= "" and arg_183_1.actors_[var_186_6.prefab_name] ~= nil then
						local var_186_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_183_1.actors_[var_186_6.prefab_name].transform, "story_v_out_222072", "222072044", "story_v_out_222072.awb")

						arg_183_1:RecordAudio("222072044", var_186_11)
						arg_183_1:RecordAudio("222072044", var_186_11)
					else
						arg_183_1:AudioAction("play", "voice", "story_v_out_222072", "222072044", "story_v_out_222072.awb")
					end

					arg_183_1:RecordHistoryTalkVoice("story_v_out_222072", "222072044", "story_v_out_222072.awb")
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
	Play222072045 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 222072045
		arg_187_1.duration_ = 8.17

		local var_187_0 = {
			ja = 8.166,
			ko = 7.166,
			zh = 7.166
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
				arg_187_0:Play222072046(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 and not isNil(arg_187_1.actors_["1071ui_story"]) and arg_187_1.var_.characterEffect1071ui_story == nil then
				arg_187_1.var_.characterEffect1071ui_story = arg_187_1.actors_["1071ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_190_0 = 0.200000002980232

			if 0 <= arg_187_1.time_ and arg_187_1.time_ < 0 + var_190_0 and not isNil(arg_187_1.actors_["1071ui_story"]) then
				if arg_187_1.var_.characterEffect1071ui_story and not isNil(arg_187_1.actors_["1071ui_story"]) then
					arg_187_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_187_1.time_ >= 0 + var_190_0 and arg_187_1.time_ < 0 + var_190_0 + arg_190_0 and not isNil(arg_187_1.actors_["1071ui_story"]) and arg_187_1.var_.characterEffect1071ui_story then
				arg_187_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 then
				arg_187_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action3_2")
			end

			local var_190_2 = arg_187_1.actors_["1074ui_story"]

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 and not isNil(var_190_2) and arg_187_1.var_.characterEffect1074ui_story == nil then
				arg_187_1.var_.characterEffect1074ui_story = var_190_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_190_3 = 0.200000002980232

			if 0 <= arg_187_1.time_ and arg_187_1.time_ < 0 + var_190_3 and not isNil(var_190_2) then
				if arg_187_1.var_.characterEffect1074ui_story and not isNil(var_190_2) then
					arg_187_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_187_1.var_.characterEffect1074ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_187_1.time_ - 0) / var_190_3)
				end
			end

			if arg_187_1.time_ >= 0 + var_190_3 and arg_187_1.time_ < 0 + var_190_3 + arg_190_0 and not isNil(var_190_2) and arg_187_1.var_.characterEffect1074ui_story then
				arg_187_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_187_1.var_.characterEffect1074ui_story.fillRatio = 0.5
			end

			local var_190_4 = 0
			local var_190_5 = 0.925

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= var_190_4 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, true)

				arg_187_1.leftNameTxt_.text = arg_187_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_187_1.leftNameTxt_.transform)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1.leftNameTxt_.text)
				SetActive(arg_187_1.iconTrs_.gameObject, false)
				arg_187_1.callingController_:SetSelectedState("normal")

				local var_190_6 = arg_187_1:GetWordFromCfg(222072045)
				local var_190_7 = arg_187_1:FormatText(var_190_6.content)

				arg_187_1.text_.text = var_190_7

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_9 = 37 <= 0 and var_190_5 or var_190_5 * (utf8.len(var_190_7) / 37)

				if (37 <= 0 and var_190_5 or var_190_5 * (utf8.len(var_190_7) / 37)) > 0 and var_190_5 < var_190_9 then
					arg_187_1.talkMaxDuration = var_190_9

					if var_190_9 + var_190_4 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_9 + var_190_4
					end
				end

				arg_187_1.text_.text = var_190_7
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222072", "222072045", "story_v_out_222072.awb") ~= 0 then
					local var_190_10 = manager.audio:GetVoiceLength("story_v_out_222072", "222072045", "story_v_out_222072.awb") / 1000

					if var_190_10 + var_190_4 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_10 + var_190_4
					end

					if var_190_6.prefab_name ~= "" and arg_187_1.actors_[var_190_6.prefab_name] ~= nil then
						local var_190_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_187_1.actors_[var_190_6.prefab_name].transform, "story_v_out_222072", "222072045", "story_v_out_222072.awb")

						arg_187_1:RecordAudio("222072045", var_190_11)
						arg_187_1:RecordAudio("222072045", var_190_11)
					else
						arg_187_1:AudioAction("play", "voice", "story_v_out_222072", "222072045", "story_v_out_222072.awb")
					end

					arg_187_1:RecordHistoryTalkVoice("story_v_out_222072", "222072045", "story_v_out_222072.awb")
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
	Play222072046 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 222072046
		arg_191_1.duration_ = 8.77

		local var_191_0 = {
			ja = 8.766,
			ko = 5.366,
			zh = 5.4
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
				arg_191_0:Play222072047(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			local var_194_0 = 0.575

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, true)

				arg_191_1.leftNameTxt_.text = arg_191_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_191_1.leftNameTxt_.transform)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1.leftNameTxt_.text)
				SetActive(arg_191_1.iconTrs_.gameObject, false)
				arg_191_1.callingController_:SetSelectedState("normal")

				local var_194_1 = arg_191_1:GetWordFromCfg(222072046)
				local var_194_2 = arg_191_1:FormatText(var_194_1.content)

				arg_191_1.text_.text = var_194_2

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_4 = 23 <= 0 and var_194_0 or var_194_0 * (utf8.len(var_194_2) / 23)

				if (23 <= 0 and var_194_0 or var_194_0 * (utf8.len(var_194_2) / 23)) > 0 and var_194_0 < var_194_4 then
					arg_191_1.talkMaxDuration = var_194_4

					if var_194_4 + 0 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_4 + 0
					end
				end

				arg_191_1.text_.text = var_194_2
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222072", "222072046", "story_v_out_222072.awb") ~= 0 then
					local var_194_5 = manager.audio:GetVoiceLength("story_v_out_222072", "222072046", "story_v_out_222072.awb") / 1000

					if var_194_5 + 0 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_5 + 0
					end

					if var_194_1.prefab_name ~= "" and arg_191_1.actors_[var_194_1.prefab_name] ~= nil then
						local var_194_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_191_1.actors_[var_194_1.prefab_name].transform, "story_v_out_222072", "222072046", "story_v_out_222072.awb")

						arg_191_1:RecordAudio("222072046", var_194_6)
						arg_191_1:RecordAudio("222072046", var_194_6)
					else
						arg_191_1:AudioAction("play", "voice", "story_v_out_222072", "222072046", "story_v_out_222072.awb")
					end

					arg_191_1:RecordHistoryTalkVoice("story_v_out_222072", "222072046", "story_v_out_222072.awb")
				end

				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_7 = math.max(var_194_0, arg_191_1.talkMaxDuration)

			if 0 <= arg_191_1.time_ and arg_191_1.time_ < 0 + var_194_7 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - 0) / var_194_7

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= 0 + var_194_7 and arg_191_1.time_ < 0 + var_194_7 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {}

		arg_191_1:InitPlayNodeList()
	end,
	Play222072047 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 222072047
		arg_195_1.duration_ = 5.2

		local var_195_0 = {
			ja = 4.666,
			ko = 5.166,
			zh = 5.2
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
				arg_195_0:Play222072048(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 then
				arg_195_1.var_.moveOldPos1074ui_story = arg_195_1.actors_["1074ui_story"].transform.localPosition
			end

			local var_198_0 = 0.001

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_0 then
				arg_195_1.actors_["1074ui_story"].transform.localPosition = Vector3.Lerp(arg_195_1.var_.moveOldPos1074ui_story, Vector3.New(0, 100, 0), (arg_195_1.time_ - 0) / var_198_0)
				arg_195_1.actors_["1074ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_195_1.actors_["1074ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_195_1.actors_["1074ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_195_1.actors_["1074ui_story"].transform.position).z)
				arg_195_1.actors_["1074ui_story"].transform.localEulerAngles.z = 0
				arg_195_1.actors_["1074ui_story"].transform.localEulerAngles.x = 0
				arg_195_1.actors_["1074ui_story"].transform.localEulerAngles = arg_195_1.actors_["1074ui_story"].transform.localEulerAngles
			end

			if arg_195_1.time_ >= 0 + var_198_0 and arg_195_1.time_ < 0 + var_198_0 + arg_198_0 then
				arg_195_1.actors_["1074ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_195_1.actors_["1074ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_195_1.actors_["1074ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_195_1.actors_["1074ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_195_1.actors_["1074ui_story"].transform.position).z)
				arg_195_1.actors_["1074ui_story"].transform.localEulerAngles.z = 0
				arg_195_1.actors_["1074ui_story"].transform.localEulerAngles.x = 0
				arg_195_1.actors_["1074ui_story"].transform.localEulerAngles = arg_195_1.actors_["1074ui_story"].transform.localEulerAngles
			end

			local var_198_1 = arg_195_1.actors_["1074ui_story"]

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 and not isNil(var_198_1) and arg_195_1.var_.characterEffect1074ui_story == nil then
				arg_195_1.var_.characterEffect1074ui_story = var_198_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_198_2 = 0.200000002980232

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_2 and not isNil(var_198_1) then
				if arg_195_1.var_.characterEffect1074ui_story and not isNil(var_198_1) then
					arg_195_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_195_1.var_.characterEffect1074ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_195_1.time_ - 0) / var_198_2)
				end
			end

			if arg_195_1.time_ >= 0 + var_198_2 and arg_195_1.time_ < 0 + var_198_2 + arg_198_0 and not isNil(var_198_1) and arg_195_1.var_.characterEffect1074ui_story then
				arg_195_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_195_1.var_.characterEffect1074ui_story.fillRatio = 0.5
			end

			local var_198_3 = arg_195_1.actors_["1070ui_story"].transform

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 then
				arg_195_1.var_.moveOldPos1070ui_story = var_198_3.localPosition
			end

			local var_198_4 = 0.001

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_4 then
				var_198_3.localPosition = Vector3.Lerp(arg_195_1.var_.moveOldPos1070ui_story, Vector3.New(-0.7, -0.95, -6.05), (arg_195_1.time_ - 0) / var_198_4)
				var_198_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_198_3.position).x, (manager.ui.mainCamera.transform.position - var_198_3.position).y, (manager.ui.mainCamera.transform.position - var_198_3.position).z)
				var_198_3.localEulerAngles.z = 0
				var_198_3.localEulerAngles.x = 0
				var_198_3.localEulerAngles = var_198_3.localEulerAngles
			end

			if arg_195_1.time_ >= 0 + var_198_4 and arg_195_1.time_ < 0 + var_198_4 + arg_198_0 then
				var_198_3.localPosition = Vector3.New(-0.7, -0.95, -6.05)
				var_198_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_198_3.position).x, (manager.ui.mainCamera.transform.position - var_198_3.position).y, (manager.ui.mainCamera.transform.position - var_198_3.position).z)
				var_198_3.localEulerAngles.z = 0
				var_198_3.localEulerAngles.x = 0
				var_198_3.localEulerAngles = var_198_3.localEulerAngles
			end

			local var_198_5 = arg_195_1.actors_["1070ui_story"]

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 and not isNil(var_198_5) and arg_195_1.var_.characterEffect1070ui_story == nil then
				arg_195_1.var_.characterEffect1070ui_story = var_198_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_198_6 = 0.200000002980232

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_6 and not isNil(var_198_5) then
				if arg_195_1.var_.characterEffect1070ui_story and not isNil(var_198_5) then
					arg_195_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_195_1.time_ >= 0 + var_198_6 and arg_195_1.time_ < 0 + var_198_6 + arg_198_0 and not isNil(var_198_5) and arg_195_1.var_.characterEffect1070ui_story then
				arg_195_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 then
				arg_195_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action1_1")
			end

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 then
				arg_195_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_198_8 = arg_195_1.actors_["1071ui_story"]

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 and not isNil(var_198_8) and arg_195_1.var_.characterEffect1071ui_story == nil then
				arg_195_1.var_.characterEffect1071ui_story = var_198_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_198_9 = 0.200000002980232

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_9 and not isNil(var_198_8) then
				if arg_195_1.var_.characterEffect1071ui_story and not isNil(var_198_8) then
					arg_195_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_195_1.var_.characterEffect1071ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_195_1.time_ - 0) / var_198_9)
				end
			end

			if arg_195_1.time_ >= 0 + var_198_9 and arg_195_1.time_ < 0 + var_198_9 + arg_198_0 and not isNil(var_198_8) and arg_195_1.var_.characterEffect1071ui_story then
				arg_195_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_195_1.var_.characterEffect1071ui_story.fillRatio = 0.5
			end

			local var_198_10 = 0
			local var_198_11 = 0.45

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= var_198_10 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, true)

				arg_195_1.leftNameTxt_.text = arg_195_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_195_1.leftNameTxt_.transform)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1.leftNameTxt_.text)
				SetActive(arg_195_1.iconTrs_.gameObject, false)
				arg_195_1.callingController_:SetSelectedState("normal")

				local var_198_12 = arg_195_1:GetWordFromCfg(222072047)
				local var_198_13 = arg_195_1:FormatText(var_198_12.content)

				arg_195_1.text_.text = var_198_13

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_15 = 18 <= 0 and var_198_11 or var_198_11 * (utf8.len(var_198_13) / 18)

				if (18 <= 0 and var_198_11 or var_198_11 * (utf8.len(var_198_13) / 18)) > 0 and var_198_11 < var_198_15 then
					arg_195_1.talkMaxDuration = var_198_15

					if var_198_15 + var_198_10 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_15 + var_198_10
					end
				end

				arg_195_1.text_.text = var_198_13
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222072", "222072047", "story_v_out_222072.awb") ~= 0 then
					local var_198_16 = manager.audio:GetVoiceLength("story_v_out_222072", "222072047", "story_v_out_222072.awb") / 1000

					if var_198_16 + var_198_10 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_16 + var_198_10
					end

					if var_198_12.prefab_name ~= "" and arg_195_1.actors_[var_198_12.prefab_name] ~= nil then
						local var_198_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_195_1.actors_[var_198_12.prefab_name].transform, "story_v_out_222072", "222072047", "story_v_out_222072.awb")

						arg_195_1:RecordAudio("222072047", var_198_17)
						arg_195_1:RecordAudio("222072047", var_198_17)
					else
						arg_195_1:AudioAction("play", "voice", "story_v_out_222072", "222072047", "story_v_out_222072.awb")
					end

					arg_195_1:RecordHistoryTalkVoice("story_v_out_222072", "222072047", "story_v_out_222072.awb")
				end

				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_18 = math.max(var_198_11, arg_195_1.talkMaxDuration)

			if var_198_10 <= arg_195_1.time_ and arg_195_1.time_ < var_198_10 + var_198_18 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - var_198_10) / var_198_18

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= var_198_10 + var_198_18 and arg_195_1.time_ < var_198_10 + var_198_18 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_195_1:InitPlayNodeList()
	end,
	Play222072048 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 222072048
		arg_199_1.duration_ = 8.6

		local var_199_0 = {
			ja = 8.6,
			ko = 6.466,
			zh = 6.466
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
				arg_199_0:Play222072049(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 and not isNil(arg_199_1.actors_["1071ui_story"]) and arg_199_1.var_.characterEffect1071ui_story == nil then
				arg_199_1.var_.characterEffect1071ui_story = arg_199_1.actors_["1071ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_202_0 = 0.200000002980232

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_0 and not isNil(arg_199_1.actors_["1071ui_story"]) then
				if arg_199_1.var_.characterEffect1071ui_story and not isNil(arg_199_1.actors_["1071ui_story"]) then
					arg_199_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_199_1.time_ >= 0 + var_202_0 and arg_199_1.time_ < 0 + var_202_0 + arg_202_0 and not isNil(arg_199_1.actors_["1071ui_story"]) and arg_199_1.var_.characterEffect1071ui_story then
				arg_199_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_202_2 = arg_199_1.actors_["1070ui_story"]

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 and not isNil(var_202_2) and arg_199_1.var_.characterEffect1070ui_story == nil then
				arg_199_1.var_.characterEffect1070ui_story = var_202_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_202_3 = 0.200000002980232

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_3 and not isNil(var_202_2) then
				if arg_199_1.var_.characterEffect1070ui_story and not isNil(var_202_2) then
					arg_199_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_199_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_199_1.time_ - 0) / var_202_3)
				end
			end

			if arg_199_1.time_ >= 0 + var_202_3 and arg_199_1.time_ < 0 + var_202_3 + arg_202_0 and not isNil(var_202_2) and arg_199_1.var_.characterEffect1070ui_story then
				arg_199_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_199_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_202_4 = 0
			local var_202_5 = 0.625

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= var_202_4 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, true)

				arg_199_1.leftNameTxt_.text = arg_199_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_199_1.leftNameTxt_.transform)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1.leftNameTxt_.text)
				SetActive(arg_199_1.iconTrs_.gameObject, false)
				arg_199_1.callingController_:SetSelectedState("normal")

				local var_202_6 = arg_199_1:GetWordFromCfg(222072048)
				local var_202_7 = arg_199_1:FormatText(var_202_6.content)

				arg_199_1.text_.text = var_202_7

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_9 = 25 <= 0 and var_202_5 or var_202_5 * (utf8.len(var_202_7) / 25)

				if (25 <= 0 and var_202_5 or var_202_5 * (utf8.len(var_202_7) / 25)) > 0 and var_202_5 < var_202_9 then
					arg_199_1.talkMaxDuration = var_202_9

					if var_202_9 + var_202_4 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_9 + var_202_4
					end
				end

				arg_199_1.text_.text = var_202_7
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222072", "222072048", "story_v_out_222072.awb") ~= 0 then
					local var_202_10 = manager.audio:GetVoiceLength("story_v_out_222072", "222072048", "story_v_out_222072.awb") / 1000

					if var_202_10 + var_202_4 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_10 + var_202_4
					end

					if var_202_6.prefab_name ~= "" and arg_199_1.actors_[var_202_6.prefab_name] ~= nil then
						local var_202_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_199_1.actors_[var_202_6.prefab_name].transform, "story_v_out_222072", "222072048", "story_v_out_222072.awb")

						arg_199_1:RecordAudio("222072048", var_202_11)
						arg_199_1:RecordAudio("222072048", var_202_11)
					else
						arg_199_1:AudioAction("play", "voice", "story_v_out_222072", "222072048", "story_v_out_222072.awb")
					end

					arg_199_1:RecordHistoryTalkVoice("story_v_out_222072", "222072048", "story_v_out_222072.awb")
				end

				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_12 = math.max(var_202_5, arg_199_1.talkMaxDuration)

			if var_202_4 <= arg_199_1.time_ and arg_199_1.time_ < var_202_4 + var_202_12 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - var_202_4) / var_202_12

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= var_202_4 + var_202_12 and arg_199_1.time_ < var_202_4 + var_202_12 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {}

		arg_199_1:InitPlayNodeList()
	end,
	Play222072049 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 222072049
		arg_203_1.duration_ = 9.33

		local var_203_0 = {
			ja = 9.333,
			ko = 6.666,
			zh = 6.666
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
				arg_203_0:Play222072050(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 and not isNil(arg_203_1.actors_["1070ui_story"]) and arg_203_1.var_.characterEffect1070ui_story == nil then
				arg_203_1.var_.characterEffect1070ui_story = arg_203_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_206_0 = 0.200000002980232

			if 0 <= arg_203_1.time_ and arg_203_1.time_ < 0 + var_206_0 and not isNil(arg_203_1.actors_["1070ui_story"]) then
				if arg_203_1.var_.characterEffect1070ui_story and not isNil(arg_203_1.actors_["1070ui_story"]) then
					arg_203_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_203_1.time_ >= 0 + var_206_0 and arg_203_1.time_ < 0 + var_206_0 + arg_206_0 and not isNil(arg_203_1.actors_["1070ui_story"]) and arg_203_1.var_.characterEffect1070ui_story then
				arg_203_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				arg_203_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action1_1")
			end

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				arg_203_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_206_2 = arg_203_1.actors_["1071ui_story"]

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 and not isNil(var_206_2) and arg_203_1.var_.characterEffect1071ui_story == nil then
				arg_203_1.var_.characterEffect1071ui_story = var_206_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_206_3 = 0.200000002980232

			if 0 <= arg_203_1.time_ and arg_203_1.time_ < 0 + var_206_3 and not isNil(var_206_2) then
				if arg_203_1.var_.characterEffect1071ui_story and not isNil(var_206_2) then
					arg_203_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_203_1.var_.characterEffect1071ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_203_1.time_ - 0) / var_206_3)
				end
			end

			if arg_203_1.time_ >= 0 + var_206_3 and arg_203_1.time_ < 0 + var_206_3 + arg_206_0 and not isNil(var_206_2) and arg_203_1.var_.characterEffect1071ui_story then
				arg_203_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_203_1.var_.characterEffect1071ui_story.fillRatio = 0.5
			end

			local var_206_4 = 0
			local var_206_5 = 0.775

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= var_206_4 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, true)

				arg_203_1.leftNameTxt_.text = arg_203_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_203_1.leftNameTxt_.transform)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1.leftNameTxt_.text)
				SetActive(arg_203_1.iconTrs_.gameObject, false)
				arg_203_1.callingController_:SetSelectedState("normal")

				local var_206_6 = arg_203_1:GetWordFromCfg(222072049)
				local var_206_7 = arg_203_1:FormatText(var_206_6.content)

				arg_203_1.text_.text = var_206_7

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_9 = 31 <= 0 and var_206_5 or var_206_5 * (utf8.len(var_206_7) / 31)

				if (31 <= 0 and var_206_5 or var_206_5 * (utf8.len(var_206_7) / 31)) > 0 and var_206_5 < var_206_9 then
					arg_203_1.talkMaxDuration = var_206_9

					if var_206_9 + var_206_4 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_9 + var_206_4
					end
				end

				arg_203_1.text_.text = var_206_7
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222072", "222072049", "story_v_out_222072.awb") ~= 0 then
					local var_206_10 = manager.audio:GetVoiceLength("story_v_out_222072", "222072049", "story_v_out_222072.awb") / 1000

					if var_206_10 + var_206_4 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_10 + var_206_4
					end

					if var_206_6.prefab_name ~= "" and arg_203_1.actors_[var_206_6.prefab_name] ~= nil then
						local var_206_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_203_1.actors_[var_206_6.prefab_name].transform, "story_v_out_222072", "222072049", "story_v_out_222072.awb")

						arg_203_1:RecordAudio("222072049", var_206_11)
						arg_203_1:RecordAudio("222072049", var_206_11)
					else
						arg_203_1:AudioAction("play", "voice", "story_v_out_222072", "222072049", "story_v_out_222072.awb")
					end

					arg_203_1:RecordHistoryTalkVoice("story_v_out_222072", "222072049", "story_v_out_222072.awb")
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

		arg_203_1.nodeConfigList_ = {}

		arg_203_1:InitPlayNodeList()
	end,
	Play222072050 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 222072050
		arg_207_1.duration_ = 9.37

		local var_207_0 = {
			ja = 9.366,
			ko = 9.1,
			zh = 9.1
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
				arg_207_0:Play222072051(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 then
				arg_207_1.var_.moveOldPos1071ui_story = arg_207_1.actors_["1071ui_story"].transform.localPosition
			end

			local var_210_0 = 0.001

			if 0 <= arg_207_1.time_ and arg_207_1.time_ < 0 + var_210_0 then
				arg_207_1.actors_["1071ui_story"].transform.localPosition = Vector3.Lerp(arg_207_1.var_.moveOldPos1071ui_story, Vector3.New(0, 100, 0), (arg_207_1.time_ - 0) / var_210_0)
				arg_207_1.actors_["1071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_207_1.actors_["1071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_207_1.actors_["1071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_207_1.actors_["1071ui_story"].transform.position).z)
				arg_207_1.actors_["1071ui_story"].transform.localEulerAngles.z = 0
				arg_207_1.actors_["1071ui_story"].transform.localEulerAngles.x = 0
				arg_207_1.actors_["1071ui_story"].transform.localEulerAngles = arg_207_1.actors_["1071ui_story"].transform.localEulerAngles
			end

			if arg_207_1.time_ >= 0 + var_210_0 and arg_207_1.time_ < 0 + var_210_0 + arg_210_0 then
				arg_207_1.actors_["1071ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_207_1.actors_["1071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_207_1.actors_["1071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_207_1.actors_["1071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_207_1.actors_["1071ui_story"].transform.position).z)
				arg_207_1.actors_["1071ui_story"].transform.localEulerAngles.z = 0
				arg_207_1.actors_["1071ui_story"].transform.localEulerAngles.x = 0
				arg_207_1.actors_["1071ui_story"].transform.localEulerAngles = arg_207_1.actors_["1071ui_story"].transform.localEulerAngles
			end

			local var_210_1 = arg_207_1.actors_["1071ui_story"]

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 and not isNil(var_210_1) and arg_207_1.var_.characterEffect1071ui_story == nil then
				arg_207_1.var_.characterEffect1071ui_story = var_210_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_210_2 = 0.200000002980232

			if 0 <= arg_207_1.time_ and arg_207_1.time_ < 0 + var_210_2 and not isNil(var_210_1) then
				if arg_207_1.var_.characterEffect1071ui_story and not isNil(var_210_1) then
					arg_207_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_207_1.var_.characterEffect1071ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_207_1.time_ - 0) / var_210_2)
				end
			end

			if arg_207_1.time_ >= 0 + var_210_2 and arg_207_1.time_ < 0 + var_210_2 + arg_210_0 and not isNil(var_210_1) and arg_207_1.var_.characterEffect1071ui_story then
				arg_207_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_207_1.var_.characterEffect1071ui_story.fillRatio = 0.5
			end

			local var_210_3 = arg_207_1.actors_["1074ui_story"].transform

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 then
				arg_207_1.var_.moveOldPos1074ui_story = var_210_3.localPosition
			end

			local var_210_4 = 0.001

			if 0 <= arg_207_1.time_ and arg_207_1.time_ < 0 + var_210_4 then
				var_210_3.localPosition = Vector3.Lerp(arg_207_1.var_.moveOldPos1074ui_story, Vector3.New(0.7, -1.055, -6.12), (arg_207_1.time_ - 0) / var_210_4)
				var_210_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_210_3.position).x, (manager.ui.mainCamera.transform.position - var_210_3.position).y, (manager.ui.mainCamera.transform.position - var_210_3.position).z)
				var_210_3.localEulerAngles.z = 0
				var_210_3.localEulerAngles.x = 0
				var_210_3.localEulerAngles = var_210_3.localEulerAngles
			end

			if arg_207_1.time_ >= 0 + var_210_4 and arg_207_1.time_ < 0 + var_210_4 + arg_210_0 then
				var_210_3.localPosition = Vector3.New(0.7, -1.055, -6.12)
				var_210_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_210_3.position).x, (manager.ui.mainCamera.transform.position - var_210_3.position).y, (manager.ui.mainCamera.transform.position - var_210_3.position).z)
				var_210_3.localEulerAngles.z = 0
				var_210_3.localEulerAngles.x = 0
				var_210_3.localEulerAngles = var_210_3.localEulerAngles
			end

			local var_210_5 = arg_207_1.actors_["1074ui_story"]

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 and not isNil(var_210_5) and arg_207_1.var_.characterEffect1074ui_story == nil then
				arg_207_1.var_.characterEffect1074ui_story = var_210_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_210_6 = 0.200000002980232

			if 0 <= arg_207_1.time_ and arg_207_1.time_ < 0 + var_210_6 and not isNil(var_210_5) then
				if arg_207_1.var_.characterEffect1074ui_story and not isNil(var_210_5) then
					arg_207_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_207_1.time_ >= 0 + var_210_6 and arg_207_1.time_ < 0 + var_210_6 + arg_210_0 and not isNil(var_210_5) and arg_207_1.var_.characterEffect1074ui_story then
				arg_207_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 then
				arg_207_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action1_1")
			end

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 then
				arg_207_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_210_8 = arg_207_1.actors_["1070ui_story"]

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 and not isNil(var_210_8) and arg_207_1.var_.characterEffect1070ui_story == nil then
				arg_207_1.var_.characterEffect1070ui_story = var_210_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_210_9 = 0.200000002980232

			if 0 <= arg_207_1.time_ and arg_207_1.time_ < 0 + var_210_9 and not isNil(var_210_8) then
				if arg_207_1.var_.characterEffect1070ui_story and not isNil(var_210_8) then
					arg_207_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_207_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_207_1.time_ - 0) / var_210_9)
				end
			end

			if arg_207_1.time_ >= 0 + var_210_9 and arg_207_1.time_ < 0 + var_210_9 + arg_210_0 and not isNil(var_210_8) and arg_207_1.var_.characterEffect1070ui_story then
				arg_207_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_207_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_210_10 = 0
			local var_210_11 = 0.925

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= var_210_10 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, true)

				arg_207_1.leftNameTxt_.text = arg_207_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_207_1.leftNameTxt_.transform)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1.leftNameTxt_.text)
				SetActive(arg_207_1.iconTrs_.gameObject, false)
				arg_207_1.callingController_:SetSelectedState("normal")

				local var_210_12 = arg_207_1:GetWordFromCfg(222072050)
				local var_210_13 = arg_207_1:FormatText(var_210_12.content)

				arg_207_1.text_.text = var_210_13

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_15 = 37 <= 0 and var_210_11 or var_210_11 * (utf8.len(var_210_13) / 37)

				if (37 <= 0 and var_210_11 or var_210_11 * (utf8.len(var_210_13) / 37)) > 0 and var_210_11 < var_210_15 then
					arg_207_1.talkMaxDuration = var_210_15

					if var_210_15 + var_210_10 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_15 + var_210_10
					end
				end

				arg_207_1.text_.text = var_210_13
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222072", "222072050", "story_v_out_222072.awb") ~= 0 then
					local var_210_16 = manager.audio:GetVoiceLength("story_v_out_222072", "222072050", "story_v_out_222072.awb") / 1000

					if var_210_16 + var_210_10 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_16 + var_210_10
					end

					if var_210_12.prefab_name ~= "" and arg_207_1.actors_[var_210_12.prefab_name] ~= nil then
						local var_210_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_207_1.actors_[var_210_12.prefab_name].transform, "story_v_out_222072", "222072050", "story_v_out_222072.awb")

						arg_207_1:RecordAudio("222072050", var_210_17)
						arg_207_1:RecordAudio("222072050", var_210_17)
					else
						arg_207_1:AudioAction("play", "voice", "story_v_out_222072", "222072050", "story_v_out_222072.awb")
					end

					arg_207_1:RecordHistoryTalkVoice("story_v_out_222072", "222072050", "story_v_out_222072.awb")
				end

				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_18 = math.max(var_210_11, arg_207_1.talkMaxDuration)

			if var_210_10 <= arg_207_1.time_ and arg_207_1.time_ < var_210_10 + var_210_18 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - var_210_10) / var_210_18

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= var_210_10 + var_210_18 and arg_207_1.time_ < var_210_10 + var_210_18 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1074ui_story",
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
	Play222072051 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 222072051
		arg_211_1.duration_ = 2

		SetActive(arg_211_1.tipsGo_, false)

		function arg_211_1.onSingleLineFinish_()
			arg_211_1.onSingleLineUpdate_ = nil
			arg_211_1.onSingleLineFinish_ = nil
			arg_211_1.state_ = "waiting"
		end

		function arg_211_1.playNext_(arg_213_0)
			if arg_213_0 == 1 then
				arg_211_0:Play222072052(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 and not isNil(arg_211_1.actors_["1070ui_story"]) and arg_211_1.var_.characterEffect1070ui_story == nil then
				arg_211_1.var_.characterEffect1070ui_story = arg_211_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_214_0 = 0.200000002980232

			if 0 <= arg_211_1.time_ and arg_211_1.time_ < 0 + var_214_0 and not isNil(arg_211_1.actors_["1070ui_story"]) then
				if arg_211_1.var_.characterEffect1070ui_story and not isNil(arg_211_1.actors_["1070ui_story"]) then
					arg_211_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_211_1.time_ >= 0 + var_214_0 and arg_211_1.time_ < 0 + var_214_0 + arg_214_0 and not isNil(arg_211_1.actors_["1070ui_story"]) and arg_211_1.var_.characterEffect1070ui_story then
				arg_211_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 then
				arg_211_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action1_1")
			end

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 then
				arg_211_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_214_2 = arg_211_1.actors_["1074ui_story"]

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 and not isNil(var_214_2) and arg_211_1.var_.characterEffect1074ui_story == nil then
				arg_211_1.var_.characterEffect1074ui_story = var_214_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_214_3 = 0.200000002980232

			if 0 <= arg_211_1.time_ and arg_211_1.time_ < 0 + var_214_3 and not isNil(var_214_2) then
				if arg_211_1.var_.characterEffect1074ui_story and not isNil(var_214_2) then
					arg_211_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_211_1.var_.characterEffect1074ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_211_1.time_ - 0) / var_214_3)
				end
			end

			if arg_211_1.time_ >= 0 + var_214_3 and arg_211_1.time_ < 0 + var_214_3 + arg_214_0 and not isNil(var_214_2) and arg_211_1.var_.characterEffect1074ui_story then
				arg_211_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_211_1.var_.characterEffect1074ui_story.fillRatio = 0.5
			end

			local var_214_4 = 0
			local var_214_5 = 0.1

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= var_214_4 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, true)

				arg_211_1.leftNameTxt_.text = arg_211_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_211_1.leftNameTxt_.transform)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1.leftNameTxt_.text)
				SetActive(arg_211_1.iconTrs_.gameObject, false)
				arg_211_1.callingController_:SetSelectedState("normal")

				local var_214_6 = arg_211_1:GetWordFromCfg(222072051)
				local var_214_7 = arg_211_1:FormatText(var_214_6.content)

				arg_211_1.text_.text = var_214_7

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_9 = 4 <= 0 and var_214_5 or var_214_5 * (utf8.len(var_214_7) / 4)

				if (4 <= 0 and var_214_5 or var_214_5 * (utf8.len(var_214_7) / 4)) > 0 and var_214_5 < var_214_9 then
					arg_211_1.talkMaxDuration = var_214_9

					if var_214_9 + var_214_4 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_9 + var_214_4
					end
				end

				arg_211_1.text_.text = var_214_7
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222072", "222072051", "story_v_out_222072.awb") ~= 0 then
					local var_214_10 = manager.audio:GetVoiceLength("story_v_out_222072", "222072051", "story_v_out_222072.awb") / 1000

					if var_214_10 + var_214_4 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_10 + var_214_4
					end

					if var_214_6.prefab_name ~= "" and arg_211_1.actors_[var_214_6.prefab_name] ~= nil then
						local var_214_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_211_1.actors_[var_214_6.prefab_name].transform, "story_v_out_222072", "222072051", "story_v_out_222072.awb")

						arg_211_1:RecordAudio("222072051", var_214_11)
						arg_211_1:RecordAudio("222072051", var_214_11)
					else
						arg_211_1:AudioAction("play", "voice", "story_v_out_222072", "222072051", "story_v_out_222072.awb")
					end

					arg_211_1:RecordHistoryTalkVoice("story_v_out_222072", "222072051", "story_v_out_222072.awb")
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

		arg_211_1.nodeConfigList_ = {}

		arg_211_1:InitPlayNodeList()
	end,
	Play222072052 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 222072052
		arg_215_1.duration_ = 3.33

		local var_215_0 = {
			ja = 3.333,
			ko = 2.633,
			zh = 2.766
		}
		local var_215_1 = manager.audio:GetLocalizationFlag()

		if var_215_0[var_215_1] ~= nil then
			arg_215_1.duration_ = var_215_0[var_215_1]
		end

		SetActive(arg_215_1.tipsGo_, false)

		function arg_215_1.onSingleLineFinish_()
			arg_215_1.onSingleLineUpdate_ = nil
			arg_215_1.onSingleLineFinish_ = nil
			arg_215_1.state_ = "waiting"
		end

		function arg_215_1.playNext_(arg_217_0)
			if arg_217_0 == 1 then
				arg_215_0:Play222072053(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 and not isNil(arg_215_1.actors_["1074ui_story"]) and arg_215_1.var_.characterEffect1074ui_story == nil then
				arg_215_1.var_.characterEffect1074ui_story = arg_215_1.actors_["1074ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_218_0 = 0.200000002980232

			if 0 <= arg_215_1.time_ and arg_215_1.time_ < 0 + var_218_0 and not isNil(arg_215_1.actors_["1074ui_story"]) then
				if arg_215_1.var_.characterEffect1074ui_story and not isNil(arg_215_1.actors_["1074ui_story"]) then
					arg_215_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_215_1.time_ >= 0 + var_218_0 and arg_215_1.time_ < 0 + var_218_0 + arg_218_0 and not isNil(arg_215_1.actors_["1074ui_story"]) and arg_215_1.var_.characterEffect1074ui_story then
				arg_215_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 then
				arg_215_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action1_1")
			end

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 then
				arg_215_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_218_2 = arg_215_1.actors_["1070ui_story"]

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 and not isNil(var_218_2) and arg_215_1.var_.characterEffect1070ui_story == nil then
				arg_215_1.var_.characterEffect1070ui_story = var_218_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_218_3 = 0.200000002980232

			if 0 <= arg_215_1.time_ and arg_215_1.time_ < 0 + var_218_3 and not isNil(var_218_2) then
				if arg_215_1.var_.characterEffect1070ui_story and not isNil(var_218_2) then
					arg_215_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_215_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_215_1.time_ - 0) / var_218_3)
				end
			end

			if arg_215_1.time_ >= 0 + var_218_3 and arg_215_1.time_ < 0 + var_218_3 + arg_218_0 and not isNil(var_218_2) and arg_215_1.var_.characterEffect1070ui_story then
				arg_215_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_215_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_218_4 = 0
			local var_218_5 = 0.175

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= var_218_4 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, true)

				arg_215_1.leftNameTxt_.text = arg_215_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_215_1.leftNameTxt_.transform)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1.leftNameTxt_.text)
				SetActive(arg_215_1.iconTrs_.gameObject, false)
				arg_215_1.callingController_:SetSelectedState("normal")

				local var_218_6 = arg_215_1:GetWordFromCfg(222072052)
				local var_218_7 = arg_215_1:FormatText(var_218_6.content)

				arg_215_1.text_.text = var_218_7

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_9 = 7 <= 0 and var_218_5 or var_218_5 * (utf8.len(var_218_7) / 7)

				if (7 <= 0 and var_218_5 or var_218_5 * (utf8.len(var_218_7) / 7)) > 0 and var_218_5 < var_218_9 then
					arg_215_1.talkMaxDuration = var_218_9

					if var_218_9 + var_218_4 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_9 + var_218_4
					end
				end

				arg_215_1.text_.text = var_218_7
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222072", "222072052", "story_v_out_222072.awb") ~= 0 then
					local var_218_10 = manager.audio:GetVoiceLength("story_v_out_222072", "222072052", "story_v_out_222072.awb") / 1000

					if var_218_10 + var_218_4 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_10 + var_218_4
					end

					if var_218_6.prefab_name ~= "" and arg_215_1.actors_[var_218_6.prefab_name] ~= nil then
						local var_218_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_215_1.actors_[var_218_6.prefab_name].transform, "story_v_out_222072", "222072052", "story_v_out_222072.awb")

						arg_215_1:RecordAudio("222072052", var_218_11)
						arg_215_1:RecordAudio("222072052", var_218_11)
					else
						arg_215_1:AudioAction("play", "voice", "story_v_out_222072", "222072052", "story_v_out_222072.awb")
					end

					arg_215_1:RecordHistoryTalkVoice("story_v_out_222072", "222072052", "story_v_out_222072.awb")
				end

				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_12 = math.max(var_218_5, arg_215_1.talkMaxDuration)

			if var_218_4 <= arg_215_1.time_ and arg_215_1.time_ < var_218_4 + var_218_12 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - var_218_4) / var_218_12

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= var_218_4 + var_218_12 and arg_215_1.time_ < var_218_4 + var_218_12 + arg_218_0 then
				arg_215_1.typewritter.percent = 1

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(true)
			end
		end

		arg_215_1.nodeConfigList_ = {}

		arg_215_1:InitPlayNodeList()
	end,
	Play222072053 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 222072053
		arg_219_1.duration_ = 9.97

		local var_219_0 = {
			ja = 9.966,
			ko = 7.266,
			zh = 7.233
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
				arg_219_0:Play222072054(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 and not isNil(arg_219_1.actors_["1070ui_story"]) and arg_219_1.var_.characterEffect1070ui_story == nil then
				arg_219_1.var_.characterEffect1070ui_story = arg_219_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_222_0 = 0.200000002980232

			if 0 <= arg_219_1.time_ and arg_219_1.time_ < 0 + var_222_0 and not isNil(arg_219_1.actors_["1070ui_story"]) then
				if arg_219_1.var_.characterEffect1070ui_story and not isNil(arg_219_1.actors_["1070ui_story"]) then
					arg_219_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_219_1.time_ >= 0 + var_222_0 and arg_219_1.time_ < 0 + var_222_0 + arg_222_0 and not isNil(arg_219_1.actors_["1070ui_story"]) and arg_219_1.var_.characterEffect1070ui_story then
				arg_219_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 then
				arg_219_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action6_1")
			end

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 then
				arg_219_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_222_2 = arg_219_1.actors_["1074ui_story"]

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 and not isNil(var_222_2) and arg_219_1.var_.characterEffect1074ui_story == nil then
				arg_219_1.var_.characterEffect1074ui_story = var_222_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_222_3 = 0.200000002980232

			if 0 <= arg_219_1.time_ and arg_219_1.time_ < 0 + var_222_3 and not isNil(var_222_2) then
				if arg_219_1.var_.characterEffect1074ui_story and not isNil(var_222_2) then
					arg_219_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_219_1.var_.characterEffect1074ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_219_1.time_ - 0) / var_222_3)
				end
			end

			if arg_219_1.time_ >= 0 + var_222_3 and arg_219_1.time_ < 0 + var_222_3 + arg_222_0 and not isNil(var_222_2) and arg_219_1.var_.characterEffect1074ui_story then
				arg_219_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_219_1.var_.characterEffect1074ui_story.fillRatio = 0.5
			end

			local var_222_4 = 0
			local var_222_5 = 0.975

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= var_222_4 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0
				arg_219_1.dialogCg_.alpha = 1

				arg_219_1.dialog_:SetActive(true)
				SetActive(arg_219_1.leftNameGo_, true)

				arg_219_1.leftNameTxt_.text = arg_219_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_219_1.leftNameTxt_.transform)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1.leftNameTxt_.text)
				SetActive(arg_219_1.iconTrs_.gameObject, false)
				arg_219_1.callingController_:SetSelectedState("normal")

				local var_222_6 = arg_219_1:GetWordFromCfg(222072053)
				local var_222_7 = arg_219_1:FormatText(var_222_6.content)

				arg_219_1.text_.text = var_222_7

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_9 = 38 <= 0 and var_222_5 or var_222_5 * (utf8.len(var_222_7) / 38)

				if (38 <= 0 and var_222_5 or var_222_5 * (utf8.len(var_222_7) / 38)) > 0 and var_222_5 < var_222_9 then
					arg_219_1.talkMaxDuration = var_222_9

					if var_222_9 + var_222_4 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_9 + var_222_4
					end
				end

				arg_219_1.text_.text = var_222_7
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222072", "222072053", "story_v_out_222072.awb") ~= 0 then
					local var_222_10 = manager.audio:GetVoiceLength("story_v_out_222072", "222072053", "story_v_out_222072.awb") / 1000

					if var_222_10 + var_222_4 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_10 + var_222_4
					end

					if var_222_6.prefab_name ~= "" and arg_219_1.actors_[var_222_6.prefab_name] ~= nil then
						local var_222_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_219_1.actors_[var_222_6.prefab_name].transform, "story_v_out_222072", "222072053", "story_v_out_222072.awb")

						arg_219_1:RecordAudio("222072053", var_222_11)
						arg_219_1:RecordAudio("222072053", var_222_11)
					else
						arg_219_1:AudioAction("play", "voice", "story_v_out_222072", "222072053", "story_v_out_222072.awb")
					end

					arg_219_1:RecordHistoryTalkVoice("story_v_out_222072", "222072053", "story_v_out_222072.awb")
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

		arg_219_1.nodeConfigList_ = {}

		arg_219_1:InitPlayNodeList()
	end,
	Play222072054 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 222072054
		arg_223_1.duration_ = 9.77

		local var_223_0 = {
			ja = 9.766,
			ko = 8.633,
			zh = 8.7
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
				arg_223_0:Play222072055(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 then
				arg_223_1.var_.moveOldPos1074ui_story = arg_223_1.actors_["1074ui_story"].transform.localPosition
			end

			local var_226_0 = 0.001

			if 0 <= arg_223_1.time_ and arg_223_1.time_ < 0 + var_226_0 then
				arg_223_1.actors_["1074ui_story"].transform.localPosition = Vector3.Lerp(arg_223_1.var_.moveOldPos1074ui_story, Vector3.New(0, 100, 0), (arg_223_1.time_ - 0) / var_226_0)
				arg_223_1.actors_["1074ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_223_1.actors_["1074ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_223_1.actors_["1074ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_223_1.actors_["1074ui_story"].transform.position).z)
				arg_223_1.actors_["1074ui_story"].transform.localEulerAngles.z = 0
				arg_223_1.actors_["1074ui_story"].transform.localEulerAngles.x = 0
				arg_223_1.actors_["1074ui_story"].transform.localEulerAngles = arg_223_1.actors_["1074ui_story"].transform.localEulerAngles
			end

			if arg_223_1.time_ >= 0 + var_226_0 and arg_223_1.time_ < 0 + var_226_0 + arg_226_0 then
				arg_223_1.actors_["1074ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_223_1.actors_["1074ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_223_1.actors_["1074ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_223_1.actors_["1074ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_223_1.actors_["1074ui_story"].transform.position).z)
				arg_223_1.actors_["1074ui_story"].transform.localEulerAngles.z = 0
				arg_223_1.actors_["1074ui_story"].transform.localEulerAngles.x = 0
				arg_223_1.actors_["1074ui_story"].transform.localEulerAngles = arg_223_1.actors_["1074ui_story"].transform.localEulerAngles
			end

			local var_226_1 = arg_223_1.actors_["1074ui_story"]

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 and not isNil(var_226_1) and arg_223_1.var_.characterEffect1074ui_story == nil then
				arg_223_1.var_.characterEffect1074ui_story = var_226_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_226_2 = 0.200000002980232

			if 0 <= arg_223_1.time_ and arg_223_1.time_ < 0 + var_226_2 and not isNil(var_226_1) then
				if arg_223_1.var_.characterEffect1074ui_story and not isNil(var_226_1) then
					arg_223_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_223_1.var_.characterEffect1074ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_223_1.time_ - 0) / var_226_2)
				end
			end

			if arg_223_1.time_ >= 0 + var_226_2 and arg_223_1.time_ < 0 + var_226_2 + arg_226_0 and not isNil(var_226_1) and arg_223_1.var_.characterEffect1074ui_story then
				arg_223_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_223_1.var_.characterEffect1074ui_story.fillRatio = 0.5
			end

			local var_226_3 = arg_223_1.actors_["1071ui_story"].transform

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 then
				arg_223_1.var_.moveOldPos1071ui_story = var_226_3.localPosition
			end

			local var_226_4 = 0.001

			if 0 <= arg_223_1.time_ and arg_223_1.time_ < 0 + var_226_4 then
				var_226_3.localPosition = Vector3.Lerp(arg_223_1.var_.moveOldPos1071ui_story, Vector3.New(0.7, -1.05, -6.2), (arg_223_1.time_ - 0) / var_226_4)
				var_226_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_226_3.position).x, (manager.ui.mainCamera.transform.position - var_226_3.position).y, (manager.ui.mainCamera.transform.position - var_226_3.position).z)
				var_226_3.localEulerAngles.z = 0
				var_226_3.localEulerAngles.x = 0
				var_226_3.localEulerAngles = var_226_3.localEulerAngles
			end

			if arg_223_1.time_ >= 0 + var_226_4 and arg_223_1.time_ < 0 + var_226_4 + arg_226_0 then
				var_226_3.localPosition = Vector3.New(0.7, -1.05, -6.2)
				var_226_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_226_3.position).x, (manager.ui.mainCamera.transform.position - var_226_3.position).y, (manager.ui.mainCamera.transform.position - var_226_3.position).z)
				var_226_3.localEulerAngles.z = 0
				var_226_3.localEulerAngles.x = 0
				var_226_3.localEulerAngles = var_226_3.localEulerAngles
			end

			local var_226_5 = arg_223_1.actors_["1071ui_story"]

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 and not isNil(var_226_5) and arg_223_1.var_.characterEffect1071ui_story == nil then
				arg_223_1.var_.characterEffect1071ui_story = var_226_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_226_6 = 0.200000002980232

			if 0 <= arg_223_1.time_ and arg_223_1.time_ < 0 + var_226_6 and not isNil(var_226_5) then
				if arg_223_1.var_.characterEffect1071ui_story and not isNil(var_226_5) then
					arg_223_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_223_1.time_ >= 0 + var_226_6 and arg_223_1.time_ < 0 + var_226_6 + arg_226_0 and not isNil(var_226_5) and arg_223_1.var_.characterEffect1071ui_story then
				arg_223_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 then
				arg_223_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action1_1")
			end

			local var_226_8 = arg_223_1.actors_["1070ui_story"]

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 and not isNil(var_226_8) and arg_223_1.var_.characterEffect1070ui_story == nil then
				arg_223_1.var_.characterEffect1070ui_story = var_226_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_226_9 = 0.200000002980232

			if 0 <= arg_223_1.time_ and arg_223_1.time_ < 0 + var_226_9 and not isNil(var_226_8) then
				if arg_223_1.var_.characterEffect1070ui_story and not isNil(var_226_8) then
					arg_223_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_223_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_223_1.time_ - 0) / var_226_9)
				end
			end

			if arg_223_1.time_ >= 0 + var_226_9 and arg_223_1.time_ < 0 + var_226_9 + arg_226_0 and not isNil(var_226_8) and arg_223_1.var_.characterEffect1070ui_story then
				arg_223_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_223_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_226_10 = 0
			local var_226_11 = 0.95

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= var_226_10 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0
				arg_223_1.dialogCg_.alpha = 1

				arg_223_1.dialog_:SetActive(true)
				SetActive(arg_223_1.leftNameGo_, true)

				arg_223_1.leftNameTxt_.text = arg_223_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_223_1.leftNameTxt_.transform)

				arg_223_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_223_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_223_1:RecordName(arg_223_1.leftNameTxt_.text)
				SetActive(arg_223_1.iconTrs_.gameObject, false)
				arg_223_1.callingController_:SetSelectedState("normal")

				local var_226_12 = arg_223_1:GetWordFromCfg(222072054)
				local var_226_13 = arg_223_1:FormatText(var_226_12.content)

				arg_223_1.text_.text = var_226_13

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_15 = 38 <= 0 and var_226_11 or var_226_11 * (utf8.len(var_226_13) / 38)

				if (38 <= 0 and var_226_11 or var_226_11 * (utf8.len(var_226_13) / 38)) > 0 and var_226_11 < var_226_15 then
					arg_223_1.talkMaxDuration = var_226_15

					if var_226_15 + var_226_10 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_15 + var_226_10
					end
				end

				arg_223_1.text_.text = var_226_13
				arg_223_1.typewritter.percent = 0

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222072", "222072054", "story_v_out_222072.awb") ~= 0 then
					local var_226_16 = manager.audio:GetVoiceLength("story_v_out_222072", "222072054", "story_v_out_222072.awb") / 1000

					if var_226_16 + var_226_10 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_16 + var_226_10
					end

					if var_226_12.prefab_name ~= "" and arg_223_1.actors_[var_226_12.prefab_name] ~= nil then
						local var_226_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_223_1.actors_[var_226_12.prefab_name].transform, "story_v_out_222072", "222072054", "story_v_out_222072.awb")

						arg_223_1:RecordAudio("222072054", var_226_17)
						arg_223_1:RecordAudio("222072054", var_226_17)
					else
						arg_223_1:AudioAction("play", "voice", "story_v_out_222072", "222072054", "story_v_out_222072.awb")
					end

					arg_223_1:RecordHistoryTalkVoice("story_v_out_222072", "222072054", "story_v_out_222072.awb")
				end

				arg_223_1:RecordContent(arg_223_1.text_.text)
			end

			local var_226_18 = math.max(var_226_11, arg_223_1.talkMaxDuration)

			if var_226_10 <= arg_223_1.time_ and arg_223_1.time_ < var_226_10 + var_226_18 then
				arg_223_1.typewritter.percent = (arg_223_1.time_ - var_226_10) / var_226_18

				arg_223_1.typewritter:SetDirty()
			end

			if arg_223_1.time_ >= var_226_10 + var_226_18 and arg_223_1.time_ < var_226_10 + var_226_18 + arg_226_0 then
				arg_223_1.typewritter.percent = 1

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(true)
			end
		end

		arg_223_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1071ui_story",
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
	Play222072055 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 222072055
		arg_227_1.duration_ = 5

		SetActive(arg_227_1.tipsGo_, false)

		function arg_227_1.onSingleLineFinish_()
			arg_227_1.onSingleLineUpdate_ = nil
			arg_227_1.onSingleLineFinish_ = nil
			arg_227_1.state_ = "waiting"
		end

		function arg_227_1.playNext_(arg_229_0)
			if arg_229_0 == 1 then
				arg_227_0:Play222072056(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 then
				arg_227_1.var_.moveOldPos1071ui_story = arg_227_1.actors_["1071ui_story"].transform.localPosition
			end

			local var_230_0 = 0.001

			if 0 <= arg_227_1.time_ and arg_227_1.time_ < 0 + var_230_0 then
				arg_227_1.actors_["1071ui_story"].transform.localPosition = Vector3.Lerp(arg_227_1.var_.moveOldPos1071ui_story, Vector3.New(0, 100, 0), (arg_227_1.time_ - 0) / var_230_0)
				arg_227_1.actors_["1071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_227_1.actors_["1071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_227_1.actors_["1071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_227_1.actors_["1071ui_story"].transform.position).z)
				arg_227_1.actors_["1071ui_story"].transform.localEulerAngles.z = 0
				arg_227_1.actors_["1071ui_story"].transform.localEulerAngles.x = 0
				arg_227_1.actors_["1071ui_story"].transform.localEulerAngles = arg_227_1.actors_["1071ui_story"].transform.localEulerAngles
			end

			if arg_227_1.time_ >= 0 + var_230_0 and arg_227_1.time_ < 0 + var_230_0 + arg_230_0 then
				arg_227_1.actors_["1071ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_227_1.actors_["1071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_227_1.actors_["1071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_227_1.actors_["1071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_227_1.actors_["1071ui_story"].transform.position).z)
				arg_227_1.actors_["1071ui_story"].transform.localEulerAngles.z = 0
				arg_227_1.actors_["1071ui_story"].transform.localEulerAngles.x = 0
				arg_227_1.actors_["1071ui_story"].transform.localEulerAngles = arg_227_1.actors_["1071ui_story"].transform.localEulerAngles
			end

			local var_230_1 = arg_227_1.actors_["1071ui_story"]

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 and not isNil(var_230_1) and arg_227_1.var_.characterEffect1071ui_story == nil then
				arg_227_1.var_.characterEffect1071ui_story = var_230_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_230_2 = 0.200000002980232

			if 0 <= arg_227_1.time_ and arg_227_1.time_ < 0 + var_230_2 and not isNil(var_230_1) then
				if arg_227_1.var_.characterEffect1071ui_story and not isNil(var_230_1) then
					arg_227_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_227_1.var_.characterEffect1071ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_227_1.time_ - 0) / var_230_2)
				end
			end

			if arg_227_1.time_ >= 0 + var_230_2 and arg_227_1.time_ < 0 + var_230_2 + arg_230_0 and not isNil(var_230_1) and arg_227_1.var_.characterEffect1071ui_story then
				arg_227_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_227_1.var_.characterEffect1071ui_story.fillRatio = 0.5
			end

			local var_230_3 = arg_227_1.actors_["1070ui_story"].transform

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 then
				arg_227_1.var_.moveOldPos1070ui_story = var_230_3.localPosition
			end

			local var_230_4 = 0.001

			if 0 <= arg_227_1.time_ and arg_227_1.time_ < 0 + var_230_4 then
				var_230_3.localPosition = Vector3.Lerp(arg_227_1.var_.moveOldPos1070ui_story, Vector3.New(0, 100, 0), (arg_227_1.time_ - 0) / var_230_4)
				var_230_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_230_3.position).x, (manager.ui.mainCamera.transform.position - var_230_3.position).y, (manager.ui.mainCamera.transform.position - var_230_3.position).z)
				var_230_3.localEulerAngles.z = 0
				var_230_3.localEulerAngles.x = 0
				var_230_3.localEulerAngles = var_230_3.localEulerAngles
			end

			if arg_227_1.time_ >= 0 + var_230_4 and arg_227_1.time_ < 0 + var_230_4 + arg_230_0 then
				var_230_3.localPosition = Vector3.New(0, 100, 0)
				var_230_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_230_3.position).x, (manager.ui.mainCamera.transform.position - var_230_3.position).y, (manager.ui.mainCamera.transform.position - var_230_3.position).z)
				var_230_3.localEulerAngles.z = 0
				var_230_3.localEulerAngles.x = 0
				var_230_3.localEulerAngles = var_230_3.localEulerAngles
			end

			local var_230_5 = arg_227_1.actors_["1070ui_story"]

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 and not isNil(var_230_5) and arg_227_1.var_.characterEffect1070ui_story == nil then
				arg_227_1.var_.characterEffect1070ui_story = var_230_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_230_6 = 0.200000002980232

			if 0 <= arg_227_1.time_ and arg_227_1.time_ < 0 + var_230_6 and not isNil(var_230_5) then
				if arg_227_1.var_.characterEffect1070ui_story and not isNil(var_230_5) then
					arg_227_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_227_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_227_1.time_ - 0) / var_230_6)
				end
			end

			if arg_227_1.time_ >= 0 + var_230_6 and arg_227_1.time_ < 0 + var_230_6 + arg_230_0 and not isNil(var_230_5) and arg_227_1.var_.characterEffect1070ui_story then
				arg_227_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_227_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_230_7 = 0
			local var_230_8 = 0.875

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= var_230_7 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0
				arg_227_1.dialogCg_.alpha = 1

				arg_227_1.dialog_:SetActive(true)
				SetActive(arg_227_1.leftNameGo_, false)

				arg_227_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_227_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_227_1:RecordName(arg_227_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_227_1.iconTrs_.gameObject, false)
				arg_227_1.callingController_:SetSelectedState("normal")

				local var_230_9 = arg_227_1:FormatText(arg_227_1:GetWordFromCfg(222072055).content)

				arg_227_1.text_.text = var_230_9

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_11 = 35 <= 0 and var_230_8 or var_230_8 * (utf8.len(var_230_9) / 35)

				if (35 <= 0 and var_230_8 or var_230_8 * (utf8.len(var_230_9) / 35)) > 0 and var_230_8 < var_230_11 then
					arg_227_1.talkMaxDuration = var_230_11

					if var_230_11 + var_230_7 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_11 + var_230_7
					end
				end

				arg_227_1.text_.text = var_230_9
				arg_227_1.typewritter.percent = 0

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(false)
				arg_227_1:RecordContent(arg_227_1.text_.text)
			end

			local var_230_12 = math.max(var_230_8, arg_227_1.talkMaxDuration)

			if var_230_7 <= arg_227_1.time_ and arg_227_1.time_ < var_230_7 + var_230_12 then
				arg_227_1.typewritter.percent = (arg_227_1.time_ - var_230_7) / var_230_12

				arg_227_1.typewritter:SetDirty()
			end

			if arg_227_1.time_ >= var_230_7 + var_230_12 and arg_227_1.time_ < var_230_7 + var_230_12 + arg_230_0 then
				arg_227_1.typewritter.percent = 1

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(true)
			end
		end

		arg_227_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1070ui_story",
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
	Play222072056 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 222072056
		arg_231_1.duration_ = 13.17

		local var_231_0 = {
			ja = 13.166,
			ko = 8.9,
			zh = 8.9
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
				arg_231_0:Play222072057(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 then
				arg_231_1.var_.moveOldPos1074ui_story = arg_231_1.actors_["1074ui_story"].transform.localPosition
			end

			local var_234_0 = 0.001

			if 0 <= arg_231_1.time_ and arg_231_1.time_ < 0 + var_234_0 then
				arg_231_1.actors_["1074ui_story"].transform.localPosition = Vector3.Lerp(arg_231_1.var_.moveOldPos1074ui_story, Vector3.New(0, -1.055, -6.12), (arg_231_1.time_ - 0) / var_234_0)
				arg_231_1.actors_["1074ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_231_1.actors_["1074ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_231_1.actors_["1074ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_231_1.actors_["1074ui_story"].transform.position).z)
				arg_231_1.actors_["1074ui_story"].transform.localEulerAngles.z = 0
				arg_231_1.actors_["1074ui_story"].transform.localEulerAngles.x = 0
				arg_231_1.actors_["1074ui_story"].transform.localEulerAngles = arg_231_1.actors_["1074ui_story"].transform.localEulerAngles
			end

			if arg_231_1.time_ >= 0 + var_234_0 and arg_231_1.time_ < 0 + var_234_0 + arg_234_0 then
				arg_231_1.actors_["1074ui_story"].transform.localPosition = Vector3.New(0, -1.055, -6.12)
				arg_231_1.actors_["1074ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_231_1.actors_["1074ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_231_1.actors_["1074ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_231_1.actors_["1074ui_story"].transform.position).z)
				arg_231_1.actors_["1074ui_story"].transform.localEulerAngles.z = 0
				arg_231_1.actors_["1074ui_story"].transform.localEulerAngles.x = 0
				arg_231_1.actors_["1074ui_story"].transform.localEulerAngles = arg_231_1.actors_["1074ui_story"].transform.localEulerAngles
			end

			local var_234_1 = arg_231_1.actors_["1074ui_story"]

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 and not isNil(var_234_1) and arg_231_1.var_.characterEffect1074ui_story == nil then
				arg_231_1.var_.characterEffect1074ui_story = var_234_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_234_2 = 0.200000002980232

			if 0 <= arg_231_1.time_ and arg_231_1.time_ < 0 + var_234_2 and not isNil(var_234_1) then
				if arg_231_1.var_.characterEffect1074ui_story and not isNil(var_234_1) then
					arg_231_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_231_1.time_ >= 0 + var_234_2 and arg_231_1.time_ < 0 + var_234_2 + arg_234_0 and not isNil(var_234_1) and arg_231_1.var_.characterEffect1074ui_story then
				arg_231_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 then
				arg_231_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action1_1")
			end

			local var_234_4 = 0
			local var_234_5 = 1.1

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= var_234_4 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0
				arg_231_1.dialogCg_.alpha = 1

				arg_231_1.dialog_:SetActive(true)
				SetActive(arg_231_1.leftNameGo_, true)

				arg_231_1.leftNameTxt_.text = arg_231_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_231_1.leftNameTxt_.transform)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1.leftNameTxt_.text)
				SetActive(arg_231_1.iconTrs_.gameObject, false)
				arg_231_1.callingController_:SetSelectedState("normal")

				local var_234_6 = arg_231_1:GetWordFromCfg(222072056)
				local var_234_7 = arg_231_1:FormatText(var_234_6.content)

				arg_231_1.text_.text = var_234_7

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_9 = 44 <= 0 and var_234_5 or var_234_5 * (utf8.len(var_234_7) / 44)

				if (44 <= 0 and var_234_5 or var_234_5 * (utf8.len(var_234_7) / 44)) > 0 and var_234_5 < var_234_9 then
					arg_231_1.talkMaxDuration = var_234_9

					if var_234_9 + var_234_4 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_9 + var_234_4
					end
				end

				arg_231_1.text_.text = var_234_7
				arg_231_1.typewritter.percent = 0

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222072", "222072056", "story_v_out_222072.awb") ~= 0 then
					local var_234_10 = manager.audio:GetVoiceLength("story_v_out_222072", "222072056", "story_v_out_222072.awb") / 1000

					if var_234_10 + var_234_4 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_10 + var_234_4
					end

					if var_234_6.prefab_name ~= "" and arg_231_1.actors_[var_234_6.prefab_name] ~= nil then
						local var_234_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_231_1.actors_[var_234_6.prefab_name].transform, "story_v_out_222072", "222072056", "story_v_out_222072.awb")

						arg_231_1:RecordAudio("222072056", var_234_11)
						arg_231_1:RecordAudio("222072056", var_234_11)
					else
						arg_231_1:AudioAction("play", "voice", "story_v_out_222072", "222072056", "story_v_out_222072.awb")
					end

					arg_231_1:RecordHistoryTalkVoice("story_v_out_222072", "222072056", "story_v_out_222072.awb")
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
				actorName = "1074ui_story",
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
	Play222072057 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 222072057
		arg_235_1.duration_ = 17.63

		local var_235_0 = {
			ja = 17.633,
			ko = 8.9,
			zh = 8.9
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
				arg_235_0:Play222072058(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			local var_238_0 = 0.95

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0
				arg_235_1.dialogCg_.alpha = 1

				arg_235_1.dialog_:SetActive(true)
				SetActive(arg_235_1.leftNameGo_, true)

				arg_235_1.leftNameTxt_.text = arg_235_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_235_1.leftNameTxt_.transform)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1.leftNameTxt_.text)
				SetActive(arg_235_1.iconTrs_.gameObject, false)
				arg_235_1.callingController_:SetSelectedState("normal")

				local var_238_1 = arg_235_1:GetWordFromCfg(222072057)
				local var_238_2 = arg_235_1:FormatText(var_238_1.content)

				arg_235_1.text_.text = var_238_2

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_4 = 38 <= 0 and var_238_0 or var_238_0 * (utf8.len(var_238_2) / 38)

				if (38 <= 0 and var_238_0 or var_238_0 * (utf8.len(var_238_2) / 38)) > 0 and var_238_0 < var_238_4 then
					arg_235_1.talkMaxDuration = var_238_4

					if var_238_4 + 0 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_4 + 0
					end
				end

				arg_235_1.text_.text = var_238_2
				arg_235_1.typewritter.percent = 0

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222072", "222072057", "story_v_out_222072.awb") ~= 0 then
					local var_238_5 = manager.audio:GetVoiceLength("story_v_out_222072", "222072057", "story_v_out_222072.awb") / 1000

					if var_238_5 + 0 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_5 + 0
					end

					if var_238_1.prefab_name ~= "" and arg_235_1.actors_[var_238_1.prefab_name] ~= nil then
						local var_238_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_235_1.actors_[var_238_1.prefab_name].transform, "story_v_out_222072", "222072057", "story_v_out_222072.awb")

						arg_235_1:RecordAudio("222072057", var_238_6)
						arg_235_1:RecordAudio("222072057", var_238_6)
					else
						arg_235_1:AudioAction("play", "voice", "story_v_out_222072", "222072057", "story_v_out_222072.awb")
					end

					arg_235_1:RecordHistoryTalkVoice("story_v_out_222072", "222072057", "story_v_out_222072.awb")
				end

				arg_235_1:RecordContent(arg_235_1.text_.text)
			end

			local var_238_7 = math.max(var_238_0, arg_235_1.talkMaxDuration)

			if 0 <= arg_235_1.time_ and arg_235_1.time_ < 0 + var_238_7 then
				arg_235_1.typewritter.percent = (arg_235_1.time_ - 0) / var_238_7

				arg_235_1.typewritter:SetDirty()
			end

			if arg_235_1.time_ >= 0 + var_238_7 and arg_235_1.time_ < 0 + var_238_7 + arg_238_0 then
				arg_235_1.typewritter.percent = 1

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(true)
			end
		end

		arg_235_1.nodeConfigList_ = {}

		arg_235_1:InitPlayNodeList()
	end,
	Play222072058 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 222072058
		arg_239_1.duration_ = 9.33

		local var_239_0 = {
			ja = 9.333,
			ko = 7.7,
			zh = 7.7
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
				arg_239_0:Play222072059(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			local var_242_0 = 0.95

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0
				arg_239_1.dialogCg_.alpha = 1

				arg_239_1.dialog_:SetActive(true)
				SetActive(arg_239_1.leftNameGo_, true)

				arg_239_1.leftNameTxt_.text = arg_239_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_239_1.leftNameTxt_.transform)

				arg_239_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_239_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_239_1:RecordName(arg_239_1.leftNameTxt_.text)
				SetActive(arg_239_1.iconTrs_.gameObject, false)
				arg_239_1.callingController_:SetSelectedState("normal")

				local var_242_1 = arg_239_1:GetWordFromCfg(222072058)
				local var_242_2 = arg_239_1:FormatText(var_242_1.content)

				arg_239_1.text_.text = var_242_2

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_4 = 37 <= 0 and var_242_0 or var_242_0 * (utf8.len(var_242_2) / 37)

				if (37 <= 0 and var_242_0 or var_242_0 * (utf8.len(var_242_2) / 37)) > 0 and var_242_0 < var_242_4 then
					arg_239_1.talkMaxDuration = var_242_4

					if var_242_4 + 0 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_4 + 0
					end
				end

				arg_239_1.text_.text = var_242_2
				arg_239_1.typewritter.percent = 0

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222072", "222072058", "story_v_out_222072.awb") ~= 0 then
					local var_242_5 = manager.audio:GetVoiceLength("story_v_out_222072", "222072058", "story_v_out_222072.awb") / 1000

					if var_242_5 + 0 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_5 + 0
					end

					if var_242_1.prefab_name ~= "" and arg_239_1.actors_[var_242_1.prefab_name] ~= nil then
						local var_242_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_239_1.actors_[var_242_1.prefab_name].transform, "story_v_out_222072", "222072058", "story_v_out_222072.awb")

						arg_239_1:RecordAudio("222072058", var_242_6)
						arg_239_1:RecordAudio("222072058", var_242_6)
					else
						arg_239_1:AudioAction("play", "voice", "story_v_out_222072", "222072058", "story_v_out_222072.awb")
					end

					arg_239_1:RecordHistoryTalkVoice("story_v_out_222072", "222072058", "story_v_out_222072.awb")
				end

				arg_239_1:RecordContent(arg_239_1.text_.text)
			end

			local var_242_7 = math.max(var_242_0, arg_239_1.talkMaxDuration)

			if 0 <= arg_239_1.time_ and arg_239_1.time_ < 0 + var_242_7 then
				arg_239_1.typewritter.percent = (arg_239_1.time_ - 0) / var_242_7

				arg_239_1.typewritter:SetDirty()
			end

			if arg_239_1.time_ >= 0 + var_242_7 and arg_239_1.time_ < 0 + var_242_7 + arg_242_0 then
				arg_239_1.typewritter.percent = 1

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(true)
			end
		end

		arg_239_1.nodeConfigList_ = {}

		arg_239_1:InitPlayNodeList()
	end,
	Play222072059 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 222072059
		arg_243_1.duration_ = 8.23

		local var_243_0 = {
			ja = 8.233,
			ko = 5.5,
			zh = 5.5
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
				arg_243_0:Play222072060(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			local var_246_0 = 0.575

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 then
				arg_243_1.talkMaxDuration = 0
				arg_243_1.dialogCg_.alpha = 1

				arg_243_1.dialog_:SetActive(true)
				SetActive(arg_243_1.leftNameGo_, true)

				arg_243_1.leftNameTxt_.text = arg_243_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_243_1.leftNameTxt_.transform)

				arg_243_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_243_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_243_1:RecordName(arg_243_1.leftNameTxt_.text)
				SetActive(arg_243_1.iconTrs_.gameObject, false)
				arg_243_1.callingController_:SetSelectedState("normal")

				local var_246_1 = arg_243_1:GetWordFromCfg(222072059)
				local var_246_2 = arg_243_1:FormatText(var_246_1.content)

				arg_243_1.text_.text = var_246_2

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_4 = 23 <= 0 and var_246_0 or var_246_0 * (utf8.len(var_246_2) / 23)

				if (23 <= 0 and var_246_0 or var_246_0 * (utf8.len(var_246_2) / 23)) > 0 and var_246_0 < var_246_4 then
					arg_243_1.talkMaxDuration = var_246_4

					if var_246_4 + 0 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_4 + 0
					end
				end

				arg_243_1.text_.text = var_246_2
				arg_243_1.typewritter.percent = 0

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222072", "222072059", "story_v_out_222072.awb") ~= 0 then
					local var_246_5 = manager.audio:GetVoiceLength("story_v_out_222072", "222072059", "story_v_out_222072.awb") / 1000

					if var_246_5 + 0 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_5 + 0
					end

					if var_246_1.prefab_name ~= "" and arg_243_1.actors_[var_246_1.prefab_name] ~= nil then
						local var_246_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_243_1.actors_[var_246_1.prefab_name].transform, "story_v_out_222072", "222072059", "story_v_out_222072.awb")

						arg_243_1:RecordAudio("222072059", var_246_6)
						arg_243_1:RecordAudio("222072059", var_246_6)
					else
						arg_243_1:AudioAction("play", "voice", "story_v_out_222072", "222072059", "story_v_out_222072.awb")
					end

					arg_243_1:RecordHistoryTalkVoice("story_v_out_222072", "222072059", "story_v_out_222072.awb")
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
	Play222072060 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 222072060
		arg_247_1.duration_ = 9

		SetActive(arg_247_1.tipsGo_, false)

		function arg_247_1.onSingleLineFinish_()
			arg_247_1.onSingleLineUpdate_ = nil
			arg_247_1.onSingleLineFinish_ = nil
			arg_247_1.state_ = "waiting"
		end

		function arg_247_1.playNext_(arg_249_0)
			if arg_249_0 == 1 then
				arg_247_0:Play222072061(arg_247_1)
			end
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			if arg_247_1.bgs_.ST47 == nil then
				local var_250_0 = Object.Instantiate(arg_247_1.paintGo_)

				var_250_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST47")
				var_250_0.name = "ST47"
				var_250_0.transform.parent = arg_247_1.stage_.transform
				var_250_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_247_1.bgs_.ST47 = var_250_0
			end

			if 2 < arg_247_1.time_ and arg_247_1.time_ <= 2 + arg_250_0 then
				local var_250_1 = arg_247_1.bgs_.ST47

				arg_247_1.bgs_.ST47.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_250_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_250_2 = var_250_1:GetComponent("SpriteRenderer")

				if var_250_2 and var_250_2.sprite then
					local var_250_3 = 2 * (var_250_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_250_1.transform.localScale = Vector3.New(var_250_3 / var_250_2.sprite.bounds.size.y < var_250_3 * manager.ui.mainCameraCom_.aspect / var_250_2.sprite.bounds.size.x and var_250_3 * manager.ui.mainCameraCom_.aspect / var_250_2.sprite.bounds.size.x or var_250_3 / var_250_2.sprite.bounds.size.y, var_250_3 / var_250_2.sprite.bounds.size.y < var_250_3 * manager.ui.mainCameraCom_.aspect / var_250_2.sprite.bounds.size.x and var_250_3 * manager.ui.mainCameraCom_.aspect / var_250_2.sprite.bounds.size.x or var_250_3 / var_250_2.sprite.bounds.size.y, 0)
				end

				for iter_250_0, iter_250_1 in pairs(arg_247_1.bgs_) do
					if iter_250_0 ~= "ST47" then
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

			local var_250_12 = arg_247_1.actors_["1074ui_story"].transform

			if 1.96599999815226 < arg_247_1.time_ and arg_247_1.time_ <= 1.96599999815226 + arg_250_0 then
				arg_247_1.var_.moveOldPos1074ui_story = var_250_12.localPosition
			end

			local var_250_13 = 0.001

			if 1.96599999815226 <= arg_247_1.time_ and arg_247_1.time_ < 1.96599999815226 + var_250_13 then
				var_250_12.localPosition = Vector3.Lerp(arg_247_1.var_.moveOldPos1074ui_story, Vector3.New(0, 100, 0), (arg_247_1.time_ - 1.96599999815226) / var_250_13)
				var_250_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_250_12.position).x, (manager.ui.mainCamera.transform.position - var_250_12.position).y, (manager.ui.mainCamera.transform.position - var_250_12.position).z)
				var_250_12.localEulerAngles.z = 0
				var_250_12.localEulerAngles.x = 0
				var_250_12.localEulerAngles = var_250_12.localEulerAngles
			end

			if arg_247_1.time_ >= 1.96599999815226 + var_250_13 and arg_247_1.time_ < 1.96599999815226 + var_250_13 + arg_250_0 then
				var_250_12.localPosition = Vector3.New(0, 100, 0)
				var_250_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_250_12.position).x, (manager.ui.mainCamera.transform.position - var_250_12.position).y, (manager.ui.mainCamera.transform.position - var_250_12.position).z)
				var_250_12.localEulerAngles.z = 0
				var_250_12.localEulerAngles.x = 0
				var_250_12.localEulerAngles = var_250_12.localEulerAngles
			end

			local var_250_14 = arg_247_1.actors_["1071ui_story"]

			if 1.96599999815226 < arg_247_1.time_ and arg_247_1.time_ <= 1.96599999815226 + arg_250_0 and not isNil(var_250_14) and arg_247_1.var_.characterEffect1071ui_story == nil then
				arg_247_1.var_.characterEffect1071ui_story = var_250_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_250_15 = 0.034000001847744

			if 1.96599999815226 <= arg_247_1.time_ and arg_247_1.time_ < 1.96599999815226 + var_250_15 and not isNil(var_250_14) then
				if arg_247_1.var_.characterEffect1071ui_story and not isNil(var_250_14) then
					arg_247_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_247_1.var_.characterEffect1071ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_247_1.time_ - 1.96599999815226) / var_250_15)
				end
			end

			if arg_247_1.time_ >= 1.96599999815226 + var_250_15 and arg_247_1.time_ < 1.96599999815226 + var_250_15 + arg_250_0 and not isNil(var_250_14) and arg_247_1.var_.characterEffect1071ui_story then
				arg_247_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_247_1.var_.characterEffect1071ui_story.fillRatio = 0.5
			end

			if arg_247_1.frameCnt_ <= 1 then
				arg_247_1.dialog_:SetActive(false)
			end

			local var_250_16 = 4
			local var_250_17 = 1.35

			if 4 < arg_247_1.time_ and arg_247_1.time_ <= var_250_16 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0

				arg_247_1.dialog_:SetActive(true)

				arg_247_1.dialogCg_.alpha = 0

				local var_250_18 = LeanTween.value(arg_247_1.dialog_, 0, 1, 0.3)

				var_250_18:setOnUpdate(LuaHelper.FloatAction(function(arg_251_0)
					arg_247_1.dialogCg_.alpha = arg_251_0
				end))
				var_250_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_247_1.dialog_)
					var_250_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_247_1.duration_ = arg_247_1.duration_ + 0.3

				SetActive(arg_247_1.leftNameGo_, false)

				arg_247_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_247_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_247_1:RecordName(arg_247_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_247_1.iconTrs_.gameObject, false)
				arg_247_1.callingController_:SetSelectedState("normal")

				local var_250_19 = arg_247_1:FormatText(arg_247_1:GetWordFromCfg(222072060).content)

				arg_247_1.text_.text = var_250_19

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_21 = 54 <= 0 and var_250_17 or var_250_17 * (utf8.len(var_250_19) / 54)

				if (54 <= 0 and var_250_17 or var_250_17 * (utf8.len(var_250_19) / 54)) > 0 and var_250_17 < var_250_21 then
					arg_247_1.talkMaxDuration = var_250_21
					var_250_16 = var_250_16 + 0.3

					if var_250_21 + var_250_16 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_21 + var_250_16
					end
				end

				arg_247_1.text_.text = var_250_19
				arg_247_1.typewritter.percent = 0

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(false)
				arg_247_1:RecordContent(arg_247_1.text_.text)
			end

			local var_250_22 = var_250_16 + 0.3
			local var_250_23 = math.max(var_250_17, arg_247_1.talkMaxDuration)

			if var_250_16 + 0.3 <= arg_247_1.time_ and arg_247_1.time_ < var_250_22 + var_250_23 then
				arg_247_1.typewritter.percent = (arg_247_1.time_ - var_250_22) / var_250_23

				arg_247_1.typewritter:SetDirty()
			end

			if arg_247_1.time_ >= var_250_22 + var_250_23 and arg_247_1.time_ < var_250_22 + var_250_23 + arg_250_0 then
				arg_247_1.typewritter.percent = 1

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(true)
			end
		end

		arg_247_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_247_1:InitPlayNodeList()
	end,
	Play222072061 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 222072061
		arg_253_1.duration_ = 10.9

		local var_253_0 = {
			ja = 10.9,
			ko = 5.6,
			zh = 5.6
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
				arg_253_0:Play222072062(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 then
				arg_253_1.var_.moveOldPos1074ui_story = arg_253_1.actors_["1074ui_story"].transform.localPosition
			end

			local var_256_0 = 0.001

			if 0 <= arg_253_1.time_ and arg_253_1.time_ < 0 + var_256_0 then
				arg_253_1.actors_["1074ui_story"].transform.localPosition = Vector3.Lerp(arg_253_1.var_.moveOldPos1074ui_story, Vector3.New(-0.7, -1.055, -6.12), (arg_253_1.time_ - 0) / var_256_0)
				arg_253_1.actors_["1074ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_253_1.actors_["1074ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_253_1.actors_["1074ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_253_1.actors_["1074ui_story"].transform.position).z)
				arg_253_1.actors_["1074ui_story"].transform.localEulerAngles.z = 0
				arg_253_1.actors_["1074ui_story"].transform.localEulerAngles.x = 0
				arg_253_1.actors_["1074ui_story"].transform.localEulerAngles = arg_253_1.actors_["1074ui_story"].transform.localEulerAngles
			end

			if arg_253_1.time_ >= 0 + var_256_0 and arg_253_1.time_ < 0 + var_256_0 + arg_256_0 then
				arg_253_1.actors_["1074ui_story"].transform.localPosition = Vector3.New(-0.7, -1.055, -6.12)
				arg_253_1.actors_["1074ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_253_1.actors_["1074ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_253_1.actors_["1074ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_253_1.actors_["1074ui_story"].transform.position).z)
				arg_253_1.actors_["1074ui_story"].transform.localEulerAngles.z = 0
				arg_253_1.actors_["1074ui_story"].transform.localEulerAngles.x = 0
				arg_253_1.actors_["1074ui_story"].transform.localEulerAngles = arg_253_1.actors_["1074ui_story"].transform.localEulerAngles
			end

			local var_256_1 = arg_253_1.actors_["1074ui_story"]

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 and not isNil(var_256_1) and arg_253_1.var_.characterEffect1074ui_story == nil then
				arg_253_1.var_.characterEffect1074ui_story = var_256_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_256_2 = 0.200000002980232

			if 0 <= arg_253_1.time_ and arg_253_1.time_ < 0 + var_256_2 and not isNil(var_256_1) then
				if arg_253_1.var_.characterEffect1074ui_story and not isNil(var_256_1) then
					arg_253_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_253_1.time_ >= 0 + var_256_2 and arg_253_1.time_ < 0 + var_256_2 + arg_256_0 and not isNil(var_256_1) and arg_253_1.var_.characterEffect1074ui_story then
				arg_253_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 then
				arg_253_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action1_1")
			end

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 then
				arg_253_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_256_4 = 0
			local var_256_5 = 0.65

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= var_256_4 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, true)

				arg_253_1.leftNameTxt_.text = arg_253_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_253_1.leftNameTxt_.transform)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1.leftNameTxt_.text)
				SetActive(arg_253_1.iconTrs_.gameObject, false)
				arg_253_1.callingController_:SetSelectedState("normal")

				local var_256_6 = arg_253_1:GetWordFromCfg(222072061)
				local var_256_7 = arg_253_1:FormatText(var_256_6.content)

				arg_253_1.text_.text = var_256_7

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_9 = 26 <= 0 and var_256_5 or var_256_5 * (utf8.len(var_256_7) / 26)

				if (26 <= 0 and var_256_5 or var_256_5 * (utf8.len(var_256_7) / 26)) > 0 and var_256_5 < var_256_9 then
					arg_253_1.talkMaxDuration = var_256_9

					if var_256_9 + var_256_4 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_9 + var_256_4
					end
				end

				arg_253_1.text_.text = var_256_7
				arg_253_1.typewritter.percent = 0

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222072", "222072061", "story_v_out_222072.awb") ~= 0 then
					local var_256_10 = manager.audio:GetVoiceLength("story_v_out_222072", "222072061", "story_v_out_222072.awb") / 1000

					if var_256_10 + var_256_4 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_10 + var_256_4
					end

					if var_256_6.prefab_name ~= "" and arg_253_1.actors_[var_256_6.prefab_name] ~= nil then
						local var_256_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_253_1.actors_[var_256_6.prefab_name].transform, "story_v_out_222072", "222072061", "story_v_out_222072.awb")

						arg_253_1:RecordAudio("222072061", var_256_11)
						arg_253_1:RecordAudio("222072061", var_256_11)
					else
						arg_253_1:AudioAction("play", "voice", "story_v_out_222072", "222072061", "story_v_out_222072.awb")
					end

					arg_253_1:RecordHistoryTalkVoice("story_v_out_222072", "222072061", "story_v_out_222072.awb")
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

		arg_253_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_253_1:InitPlayNodeList()
	end,
	Play222072062 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 222072062
		arg_257_1.duration_ = 18.07

		local var_257_0 = {
			ja = 18.066,
			ko = 12.8,
			zh = 12.8
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
				arg_257_0:Play222072063(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 then
				arg_257_1.var_.moveOldPos1071ui_story = arg_257_1.actors_["1071ui_story"].transform.localPosition
			end

			local var_260_0 = 0.001

			if 0 <= arg_257_1.time_ and arg_257_1.time_ < 0 + var_260_0 then
				arg_257_1.actors_["1071ui_story"].transform.localPosition = Vector3.Lerp(arg_257_1.var_.moveOldPos1071ui_story, Vector3.New(0.7, -1.05, -6.2), (arg_257_1.time_ - 0) / var_260_0)
				arg_257_1.actors_["1071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_257_1.actors_["1071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_257_1.actors_["1071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_257_1.actors_["1071ui_story"].transform.position).z)
				arg_257_1.actors_["1071ui_story"].transform.localEulerAngles.z = 0
				arg_257_1.actors_["1071ui_story"].transform.localEulerAngles.x = 0
				arg_257_1.actors_["1071ui_story"].transform.localEulerAngles = arg_257_1.actors_["1071ui_story"].transform.localEulerAngles
			end

			if arg_257_1.time_ >= 0 + var_260_0 and arg_257_1.time_ < 0 + var_260_0 + arg_260_0 then
				arg_257_1.actors_["1071ui_story"].transform.localPosition = Vector3.New(0.7, -1.05, -6.2)
				arg_257_1.actors_["1071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_257_1.actors_["1071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_257_1.actors_["1071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_257_1.actors_["1071ui_story"].transform.position).z)
				arg_257_1.actors_["1071ui_story"].transform.localEulerAngles.z = 0
				arg_257_1.actors_["1071ui_story"].transform.localEulerAngles.x = 0
				arg_257_1.actors_["1071ui_story"].transform.localEulerAngles = arg_257_1.actors_["1071ui_story"].transform.localEulerAngles
			end

			local var_260_1 = arg_257_1.actors_["1071ui_story"]

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 and not isNil(var_260_1) and arg_257_1.var_.characterEffect1071ui_story == nil then
				arg_257_1.var_.characterEffect1071ui_story = var_260_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_260_2 = 0.200000002980232

			if 0 <= arg_257_1.time_ and arg_257_1.time_ < 0 + var_260_2 and not isNil(var_260_1) then
				if arg_257_1.var_.characterEffect1071ui_story and not isNil(var_260_1) then
					arg_257_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_257_1.time_ >= 0 + var_260_2 and arg_257_1.time_ < 0 + var_260_2 + arg_260_0 and not isNil(var_260_1) and arg_257_1.var_.characterEffect1071ui_story then
				arg_257_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 then
				arg_257_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action1_1")
			end

			local var_260_4 = arg_257_1.actors_["1074ui_story"]

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 and not isNil(var_260_4) and arg_257_1.var_.characterEffect1074ui_story == nil then
				arg_257_1.var_.characterEffect1074ui_story = var_260_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_260_5 = 0.200000002980232

			if 0 <= arg_257_1.time_ and arg_257_1.time_ < 0 + var_260_5 and not isNil(var_260_4) then
				if arg_257_1.var_.characterEffect1074ui_story and not isNil(var_260_4) then
					arg_257_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_257_1.var_.characterEffect1074ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_257_1.time_ - 0) / var_260_5)
				end
			end

			if arg_257_1.time_ >= 0 + var_260_5 and arg_257_1.time_ < 0 + var_260_5 + arg_260_0 and not isNil(var_260_4) and arg_257_1.var_.characterEffect1074ui_story then
				arg_257_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_257_1.var_.characterEffect1074ui_story.fillRatio = 0.5
			end

			local var_260_6 = 0
			local var_260_7 = 1.125

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= var_260_6 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0
				arg_257_1.dialogCg_.alpha = 1

				arg_257_1.dialog_:SetActive(true)
				SetActive(arg_257_1.leftNameGo_, true)

				arg_257_1.leftNameTxt_.text = arg_257_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_257_1.leftNameTxt_.transform)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1.leftNameTxt_.text)
				SetActive(arg_257_1.iconTrs_.gameObject, false)
				arg_257_1.callingController_:SetSelectedState("normal")

				local var_260_8 = arg_257_1:GetWordFromCfg(222072062)
				local var_260_9 = arg_257_1:FormatText(var_260_8.content)

				arg_257_1.text_.text = var_260_9

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_11 = 45 <= 0 and var_260_7 or var_260_7 * (utf8.len(var_260_9) / 45)

				if (45 <= 0 and var_260_7 or var_260_7 * (utf8.len(var_260_9) / 45)) > 0 and var_260_7 < var_260_11 then
					arg_257_1.talkMaxDuration = var_260_11

					if var_260_11 + var_260_6 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_11 + var_260_6
					end
				end

				arg_257_1.text_.text = var_260_9
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222072", "222072062", "story_v_out_222072.awb") ~= 0 then
					local var_260_12 = manager.audio:GetVoiceLength("story_v_out_222072", "222072062", "story_v_out_222072.awb") / 1000

					if var_260_12 + var_260_6 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_12 + var_260_6
					end

					if var_260_8.prefab_name ~= "" and arg_257_1.actors_[var_260_8.prefab_name] ~= nil then
						local var_260_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_257_1.actors_[var_260_8.prefab_name].transform, "story_v_out_222072", "222072062", "story_v_out_222072.awb")

						arg_257_1:RecordAudio("222072062", var_260_13)
						arg_257_1:RecordAudio("222072062", var_260_13)
					else
						arg_257_1:AudioAction("play", "voice", "story_v_out_222072", "222072062", "story_v_out_222072.awb")
					end

					arg_257_1:RecordHistoryTalkVoice("story_v_out_222072", "222072062", "story_v_out_222072.awb")
				end

				arg_257_1:RecordContent(arg_257_1.text_.text)
			end

			local var_260_14 = math.max(var_260_7, arg_257_1.talkMaxDuration)

			if var_260_6 <= arg_257_1.time_ and arg_257_1.time_ < var_260_6 + var_260_14 then
				arg_257_1.typewritter.percent = (arg_257_1.time_ - var_260_6) / var_260_14

				arg_257_1.typewritter:SetDirty()
			end

			if arg_257_1.time_ >= var_260_6 + var_260_14 and arg_257_1.time_ < var_260_6 + var_260_14 + arg_260_0 then
				arg_257_1.typewritter.percent = 1

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(true)
			end
		end

		arg_257_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_257_1:InitPlayNodeList()
	end,
	Play222072063 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 222072063
		arg_261_1.duration_ = 6

		SetActive(arg_261_1.tipsGo_, false)

		function arg_261_1.onSingleLineFinish_()
			arg_261_1.onSingleLineUpdate_ = nil
			arg_261_1.onSingleLineFinish_ = nil
			arg_261_1.state_ = "waiting"
		end

		function arg_261_1.playNext_(arg_263_0)
			if arg_263_0 == 1 then
				arg_261_0:Play222072064(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 then
				arg_261_1.var_.moveOldPos1074ui_story = arg_261_1.actors_["1074ui_story"].transform.localPosition
			end

			local var_264_0 = 0.001

			if 0 <= arg_261_1.time_ and arg_261_1.time_ < 0 + var_264_0 then
				arg_261_1.actors_["1074ui_story"].transform.localPosition = Vector3.Lerp(arg_261_1.var_.moveOldPos1074ui_story, Vector3.New(0, 100, 0), (arg_261_1.time_ - 0) / var_264_0)
				arg_261_1.actors_["1074ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_261_1.actors_["1074ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_261_1.actors_["1074ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_261_1.actors_["1074ui_story"].transform.position).z)
				arg_261_1.actors_["1074ui_story"].transform.localEulerAngles.z = 0
				arg_261_1.actors_["1074ui_story"].transform.localEulerAngles.x = 0
				arg_261_1.actors_["1074ui_story"].transform.localEulerAngles = arg_261_1.actors_["1074ui_story"].transform.localEulerAngles
			end

			if arg_261_1.time_ >= 0 + var_264_0 and arg_261_1.time_ < 0 + var_264_0 + arg_264_0 then
				arg_261_1.actors_["1074ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_261_1.actors_["1074ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_261_1.actors_["1074ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_261_1.actors_["1074ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_261_1.actors_["1074ui_story"].transform.position).z)
				arg_261_1.actors_["1074ui_story"].transform.localEulerAngles.z = 0
				arg_261_1.actors_["1074ui_story"].transform.localEulerAngles.x = 0
				arg_261_1.actors_["1074ui_story"].transform.localEulerAngles = arg_261_1.actors_["1074ui_story"].transform.localEulerAngles
			end

			local var_264_1 = arg_261_1.actors_["1074ui_story"]

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 and not isNil(var_264_1) and arg_261_1.var_.characterEffect1074ui_story == nil then
				arg_261_1.var_.characterEffect1074ui_story = var_264_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_264_2 = 0.200000002980232

			if 0 <= arg_261_1.time_ and arg_261_1.time_ < 0 + var_264_2 and not isNil(var_264_1) then
				if arg_261_1.var_.characterEffect1074ui_story and not isNil(var_264_1) then
					arg_261_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_261_1.var_.characterEffect1074ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_261_1.time_ - 0) / var_264_2)
				end
			end

			if arg_261_1.time_ >= 0 + var_264_2 and arg_261_1.time_ < 0 + var_264_2 + arg_264_0 and not isNil(var_264_1) and arg_261_1.var_.characterEffect1074ui_story then
				arg_261_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_261_1.var_.characterEffect1074ui_story.fillRatio = 0.5
			end

			local var_264_3 = arg_261_1.actors_["1070ui_story"].transform

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 then
				arg_261_1.var_.moveOldPos1070ui_story = var_264_3.localPosition
			end

			local var_264_4 = 0.001

			if 0 <= arg_261_1.time_ and arg_261_1.time_ < 0 + var_264_4 then
				var_264_3.localPosition = Vector3.Lerp(arg_261_1.var_.moveOldPos1070ui_story, Vector3.New(-0.7, -0.95, -6.05), (arg_261_1.time_ - 0) / var_264_4)
				var_264_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_264_3.position).x, (manager.ui.mainCamera.transform.position - var_264_3.position).y, (manager.ui.mainCamera.transform.position - var_264_3.position).z)
				var_264_3.localEulerAngles.z = 0
				var_264_3.localEulerAngles.x = 0
				var_264_3.localEulerAngles = var_264_3.localEulerAngles
			end

			if arg_261_1.time_ >= 0 + var_264_4 and arg_261_1.time_ < 0 + var_264_4 + arg_264_0 then
				var_264_3.localPosition = Vector3.New(-0.7, -0.95, -6.05)
				var_264_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_264_3.position).x, (manager.ui.mainCamera.transform.position - var_264_3.position).y, (manager.ui.mainCamera.transform.position - var_264_3.position).z)
				var_264_3.localEulerAngles.z = 0
				var_264_3.localEulerAngles.x = 0
				var_264_3.localEulerAngles = var_264_3.localEulerAngles
			end

			local var_264_5 = arg_261_1.actors_["1070ui_story"]

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 and not isNil(var_264_5) and arg_261_1.var_.characterEffect1070ui_story == nil then
				arg_261_1.var_.characterEffect1070ui_story = var_264_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_264_6 = 0.200000002980232

			if 0 <= arg_261_1.time_ and arg_261_1.time_ < 0 + var_264_6 and not isNil(var_264_5) then
				if arg_261_1.var_.characterEffect1070ui_story and not isNil(var_264_5) then
					arg_261_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_261_1.time_ >= 0 + var_264_6 and arg_261_1.time_ < 0 + var_264_6 + arg_264_0 and not isNil(var_264_5) and arg_261_1.var_.characterEffect1070ui_story then
				arg_261_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 then
				arg_261_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action7_1")
			end

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 then
				arg_261_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_264_8 = arg_261_1.actors_["1071ui_story"]

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 and not isNil(var_264_8) and arg_261_1.var_.characterEffect1071ui_story == nil then
				arg_261_1.var_.characterEffect1071ui_story = var_264_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_264_9 = 0.200000002980232

			if 0 <= arg_261_1.time_ and arg_261_1.time_ < 0 + var_264_9 and not isNil(var_264_8) then
				if arg_261_1.var_.characterEffect1071ui_story and not isNil(var_264_8) then
					arg_261_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_261_1.var_.characterEffect1071ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_261_1.time_ - 0) / var_264_9)
				end
			end

			if arg_261_1.time_ >= 0 + var_264_9 and arg_261_1.time_ < 0 + var_264_9 + arg_264_0 and not isNil(var_264_8) and arg_261_1.var_.characterEffect1071ui_story then
				arg_261_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_261_1.var_.characterEffect1071ui_story.fillRatio = 0.5
			end

			local var_264_10 = 0
			local var_264_11 = 0.75

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= var_264_10 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0
				arg_261_1.dialogCg_.alpha = 1

				arg_261_1.dialog_:SetActive(true)
				SetActive(arg_261_1.leftNameGo_, true)

				arg_261_1.leftNameTxt_.text = arg_261_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_261_1.leftNameTxt_.transform)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1.leftNameTxt_.text)
				SetActive(arg_261_1.iconTrs_.gameObject, false)
				arg_261_1.callingController_:SetSelectedState("normal")

				local var_264_12 = arg_261_1:GetWordFromCfg(222072063)
				local var_264_13 = arg_261_1:FormatText(var_264_12.content)

				arg_261_1.text_.text = var_264_13

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_15 = 30 <= 0 and var_264_11 or var_264_11 * (utf8.len(var_264_13) / 30)

				if (30 <= 0 and var_264_11 or var_264_11 * (utf8.len(var_264_13) / 30)) > 0 and var_264_11 < var_264_15 then
					arg_261_1.talkMaxDuration = var_264_15

					if var_264_15 + var_264_10 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_15 + var_264_10
					end
				end

				arg_261_1.text_.text = var_264_13
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222072", "222072063", "story_v_out_222072.awb") ~= 0 then
					local var_264_16 = manager.audio:GetVoiceLength("story_v_out_222072", "222072063", "story_v_out_222072.awb") / 1000

					if var_264_16 + var_264_10 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_16 + var_264_10
					end

					if var_264_12.prefab_name ~= "" and arg_261_1.actors_[var_264_12.prefab_name] ~= nil then
						local var_264_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_261_1.actors_[var_264_12.prefab_name].transform, "story_v_out_222072", "222072063", "story_v_out_222072.awb")

						arg_261_1:RecordAudio("222072063", var_264_17)
						arg_261_1:RecordAudio("222072063", var_264_17)
					else
						arg_261_1:AudioAction("play", "voice", "story_v_out_222072", "222072063", "story_v_out_222072.awb")
					end

					arg_261_1:RecordHistoryTalkVoice("story_v_out_222072", "222072063", "story_v_out_222072.awb")
				end

				arg_261_1:RecordContent(arg_261_1.text_.text)
			end

			local var_264_18 = math.max(var_264_11, arg_261_1.talkMaxDuration)

			if var_264_10 <= arg_261_1.time_ and arg_261_1.time_ < var_264_10 + var_264_18 then
				arg_261_1.typewritter.percent = (arg_261_1.time_ - var_264_10) / var_264_18

				arg_261_1.typewritter:SetDirty()
			end

			if arg_261_1.time_ >= var_264_10 + var_264_18 and arg_261_1.time_ < var_264_10 + var_264_18 + arg_264_0 then
				arg_261_1.typewritter.percent = 1

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(true)
			end
		end

		arg_261_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1070ui_story",
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
	Play222072064 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 222072064
		arg_265_1.duration_ = 15.5

		local var_265_0 = {
			ja = 15.5,
			ko = 10.966,
			zh = 10.966
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
		end

		function arg_265_1.playNext_(arg_267_0)
			if arg_267_0 == 1 then
				arg_265_0:Play222072065(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 and not isNil(arg_265_1.actors_["1071ui_story"]) and arg_265_1.var_.characterEffect1071ui_story == nil then
				arg_265_1.var_.characterEffect1071ui_story = arg_265_1.actors_["1071ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_268_0 = 0.200000002980232

			if 0 <= arg_265_1.time_ and arg_265_1.time_ < 0 + var_268_0 and not isNil(arg_265_1.actors_["1071ui_story"]) then
				if arg_265_1.var_.characterEffect1071ui_story and not isNil(arg_265_1.actors_["1071ui_story"]) then
					arg_265_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_265_1.time_ >= 0 + var_268_0 and arg_265_1.time_ < 0 + var_268_0 + arg_268_0 and not isNil(arg_265_1.actors_["1071ui_story"]) and arg_265_1.var_.characterEffect1071ui_story then
				arg_265_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 then
				arg_265_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action1_1")
			end

			local var_268_2 = arg_265_1.actors_["1070ui_story"]

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 and not isNil(var_268_2) and arg_265_1.var_.characterEffect1070ui_story == nil then
				arg_265_1.var_.characterEffect1070ui_story = var_268_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_268_3 = 0.200000002980232

			if 0 <= arg_265_1.time_ and arg_265_1.time_ < 0 + var_268_3 and not isNil(var_268_2) then
				if arg_265_1.var_.characterEffect1070ui_story and not isNil(var_268_2) then
					arg_265_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_265_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_265_1.time_ - 0) / var_268_3)
				end
			end

			if arg_265_1.time_ >= 0 + var_268_3 and arg_265_1.time_ < 0 + var_268_3 + arg_268_0 and not isNil(var_268_2) and arg_265_1.var_.characterEffect1070ui_story then
				arg_265_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_265_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_268_4 = 0
			local var_268_5 = 0.95

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= var_268_4 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0
				arg_265_1.dialogCg_.alpha = 1

				arg_265_1.dialog_:SetActive(true)
				SetActive(arg_265_1.leftNameGo_, true)

				arg_265_1.leftNameTxt_.text = arg_265_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_265_1.leftNameTxt_.transform)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1.leftNameTxt_.text)
				SetActive(arg_265_1.iconTrs_.gameObject, false)
				arg_265_1.callingController_:SetSelectedState("normal")

				local var_268_6 = arg_265_1:GetWordFromCfg(222072064)
				local var_268_7 = arg_265_1:FormatText(var_268_6.content)

				arg_265_1.text_.text = var_268_7

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_9 = 38 <= 0 and var_268_5 or var_268_5 * (utf8.len(var_268_7) / 38)

				if (38 <= 0 and var_268_5 or var_268_5 * (utf8.len(var_268_7) / 38)) > 0 and var_268_5 < var_268_9 then
					arg_265_1.talkMaxDuration = var_268_9

					if var_268_9 + var_268_4 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_9 + var_268_4
					end
				end

				arg_265_1.text_.text = var_268_7
				arg_265_1.typewritter.percent = 0

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222072", "222072064", "story_v_out_222072.awb") ~= 0 then
					local var_268_10 = manager.audio:GetVoiceLength("story_v_out_222072", "222072064", "story_v_out_222072.awb") / 1000

					if var_268_10 + var_268_4 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_10 + var_268_4
					end

					if var_268_6.prefab_name ~= "" and arg_265_1.actors_[var_268_6.prefab_name] ~= nil then
						local var_268_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_265_1.actors_[var_268_6.prefab_name].transform, "story_v_out_222072", "222072064", "story_v_out_222072.awb")

						arg_265_1:RecordAudio("222072064", var_268_11)
						arg_265_1:RecordAudio("222072064", var_268_11)
					else
						arg_265_1:AudioAction("play", "voice", "story_v_out_222072", "222072064", "story_v_out_222072.awb")
					end

					arg_265_1:RecordHistoryTalkVoice("story_v_out_222072", "222072064", "story_v_out_222072.awb")
				end

				arg_265_1:RecordContent(arg_265_1.text_.text)
			end

			local var_268_12 = math.max(var_268_5, arg_265_1.talkMaxDuration)

			if var_268_4 <= arg_265_1.time_ and arg_265_1.time_ < var_268_4 + var_268_12 then
				arg_265_1.typewritter.percent = (arg_265_1.time_ - var_268_4) / var_268_12

				arg_265_1.typewritter:SetDirty()
			end

			if arg_265_1.time_ >= var_268_4 + var_268_12 and arg_265_1.time_ < var_268_4 + var_268_12 + arg_268_0 then
				arg_265_1.typewritter.percent = 1

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(true)
			end
		end

		arg_265_1.nodeConfigList_ = {}

		arg_265_1:InitPlayNodeList()
	end,
	Play222072065 = function(arg_269_0, arg_269_1)
		arg_269_1.time_ = 0
		arg_269_1.frameCnt_ = 0
		arg_269_1.state_ = "playing"
		arg_269_1.curTalkId_ = 222072065
		arg_269_1.duration_ = 2

		SetActive(arg_269_1.tipsGo_, false)

		function arg_269_1.onSingleLineFinish_()
			arg_269_1.onSingleLineUpdate_ = nil
			arg_269_1.onSingleLineFinish_ = nil
			arg_269_1.state_ = "waiting"
		end

		function arg_269_1.playNext_(arg_271_0)
			if arg_271_0 == 1 then
				arg_269_0:Play222072066(arg_269_1)
			end
		end

		function arg_269_1.onSingleLineUpdate_(arg_272_0)
			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 then
				arg_269_1.var_.moveOldPos1070ui_story = arg_269_1.actors_["1070ui_story"].transform.localPosition
			end

			local var_272_0 = 0.001

			if 0 <= arg_269_1.time_ and arg_269_1.time_ < 0 + var_272_0 then
				arg_269_1.actors_["1070ui_story"].transform.localPosition = Vector3.Lerp(arg_269_1.var_.moveOldPos1070ui_story, Vector3.New(0, 100, 0), (arg_269_1.time_ - 0) / var_272_0)
				arg_269_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_269_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_269_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_269_1.actors_["1070ui_story"].transform.position).z)
				arg_269_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_269_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_269_1.actors_["1070ui_story"].transform.localEulerAngles = arg_269_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			if arg_269_1.time_ >= 0 + var_272_0 and arg_269_1.time_ < 0 + var_272_0 + arg_272_0 then
				arg_269_1.actors_["1070ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_269_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_269_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_269_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_269_1.actors_["1070ui_story"].transform.position).z)
				arg_269_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_269_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_269_1.actors_["1070ui_story"].transform.localEulerAngles = arg_269_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			local var_272_1 = arg_269_1.actors_["1070ui_story"]

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 and not isNil(var_272_1) and arg_269_1.var_.characterEffect1070ui_story == nil then
				arg_269_1.var_.characterEffect1070ui_story = var_272_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_272_2 = 0.200000002980232

			if 0 <= arg_269_1.time_ and arg_269_1.time_ < 0 + var_272_2 and not isNil(var_272_1) then
				if arg_269_1.var_.characterEffect1070ui_story and not isNil(var_272_1) then
					arg_269_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_269_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_269_1.time_ - 0) / var_272_2)
				end
			end

			if arg_269_1.time_ >= 0 + var_272_2 and arg_269_1.time_ < 0 + var_272_2 + arg_272_0 and not isNil(var_272_1) and arg_269_1.var_.characterEffect1070ui_story then
				arg_269_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_269_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_272_3 = arg_269_1.actors_["1074ui_story"].transform

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 then
				arg_269_1.var_.moveOldPos1074ui_story = var_272_3.localPosition
			end

			local var_272_4 = 0.001

			if 0 <= arg_269_1.time_ and arg_269_1.time_ < 0 + var_272_4 then
				var_272_3.localPosition = Vector3.Lerp(arg_269_1.var_.moveOldPos1074ui_story, Vector3.New(-0.7, -1.055, -6.12), (arg_269_1.time_ - 0) / var_272_4)
				var_272_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_272_3.position).x, (manager.ui.mainCamera.transform.position - var_272_3.position).y, (manager.ui.mainCamera.transform.position - var_272_3.position).z)
				var_272_3.localEulerAngles.z = 0
				var_272_3.localEulerAngles.x = 0
				var_272_3.localEulerAngles = var_272_3.localEulerAngles
			end

			if arg_269_1.time_ >= 0 + var_272_4 and arg_269_1.time_ < 0 + var_272_4 + arg_272_0 then
				var_272_3.localPosition = Vector3.New(-0.7, -1.055, -6.12)
				var_272_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_272_3.position).x, (manager.ui.mainCamera.transform.position - var_272_3.position).y, (manager.ui.mainCamera.transform.position - var_272_3.position).z)
				var_272_3.localEulerAngles.z = 0
				var_272_3.localEulerAngles.x = 0
				var_272_3.localEulerAngles = var_272_3.localEulerAngles
			end

			local var_272_5 = arg_269_1.actors_["1074ui_story"]

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 and not isNil(var_272_5) and arg_269_1.var_.characterEffect1074ui_story == nil then
				arg_269_1.var_.characterEffect1074ui_story = var_272_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_272_6 = 0.200000002980232

			if 0 <= arg_269_1.time_ and arg_269_1.time_ < 0 + var_272_6 and not isNil(var_272_5) then
				if arg_269_1.var_.characterEffect1074ui_story and not isNil(var_272_5) then
					arg_269_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_269_1.time_ >= 0 + var_272_6 and arg_269_1.time_ < 0 + var_272_6 + arg_272_0 and not isNil(var_272_5) and arg_269_1.var_.characterEffect1074ui_story then
				arg_269_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 then
				arg_269_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action1_1")
			end

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 then
				arg_269_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_272_8 = arg_269_1.actors_["1071ui_story"]

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 and not isNil(var_272_8) and arg_269_1.var_.characterEffect1071ui_story == nil then
				arg_269_1.var_.characterEffect1071ui_story = var_272_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_272_9 = 0.200000002980232

			if 0 <= arg_269_1.time_ and arg_269_1.time_ < 0 + var_272_9 and not isNil(var_272_8) then
				if arg_269_1.var_.characterEffect1071ui_story and not isNil(var_272_8) then
					arg_269_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_269_1.var_.characterEffect1071ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_269_1.time_ - 0) / var_272_9)
				end
			end

			if arg_269_1.time_ >= 0 + var_272_9 and arg_269_1.time_ < 0 + var_272_9 + arg_272_0 and not isNil(var_272_8) and arg_269_1.var_.characterEffect1071ui_story then
				arg_269_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_269_1.var_.characterEffect1071ui_story.fillRatio = 0.5
			end

			local var_272_10 = 0
			local var_272_11 = 0.125

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= var_272_10 + arg_272_0 then
				arg_269_1.talkMaxDuration = 0
				arg_269_1.dialogCg_.alpha = 1

				arg_269_1.dialog_:SetActive(true)
				SetActive(arg_269_1.leftNameGo_, true)

				arg_269_1.leftNameTxt_.text = arg_269_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_269_1.leftNameTxt_.transform)

				arg_269_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_269_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_269_1:RecordName(arg_269_1.leftNameTxt_.text)
				SetActive(arg_269_1.iconTrs_.gameObject, false)
				arg_269_1.callingController_:SetSelectedState("normal")

				local var_272_12 = arg_269_1:GetWordFromCfg(222072065)
				local var_272_13 = arg_269_1:FormatText(var_272_12.content)

				arg_269_1.text_.text = var_272_13

				LuaForUtil.ClearLinePrefixSymbol(arg_269_1.text_)

				local var_272_15 = 5 <= 0 and var_272_11 or var_272_11 * (utf8.len(var_272_13) / 5)

				if (5 <= 0 and var_272_11 or var_272_11 * (utf8.len(var_272_13) / 5)) > 0 and var_272_11 < var_272_15 then
					arg_269_1.talkMaxDuration = var_272_15

					if var_272_15 + var_272_10 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_15 + var_272_10
					end
				end

				arg_269_1.text_.text = var_272_13
				arg_269_1.typewritter.percent = 0

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222072", "222072065", "story_v_out_222072.awb") ~= 0 then
					local var_272_16 = manager.audio:GetVoiceLength("story_v_out_222072", "222072065", "story_v_out_222072.awb") / 1000

					if var_272_16 + var_272_10 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_16 + var_272_10
					end

					if var_272_12.prefab_name ~= "" and arg_269_1.actors_[var_272_12.prefab_name] ~= nil then
						local var_272_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_269_1.actors_[var_272_12.prefab_name].transform, "story_v_out_222072", "222072065", "story_v_out_222072.awb")

						arg_269_1:RecordAudio("222072065", var_272_17)
						arg_269_1:RecordAudio("222072065", var_272_17)
					else
						arg_269_1:AudioAction("play", "voice", "story_v_out_222072", "222072065", "story_v_out_222072.awb")
					end

					arg_269_1:RecordHistoryTalkVoice("story_v_out_222072", "222072065", "story_v_out_222072.awb")
				end

				arg_269_1:RecordContent(arg_269_1.text_.text)
			end

			local var_272_18 = math.max(var_272_11, arg_269_1.talkMaxDuration)

			if var_272_10 <= arg_269_1.time_ and arg_269_1.time_ < var_272_10 + var_272_18 then
				arg_269_1.typewritter.percent = (arg_269_1.time_ - var_272_10) / var_272_18

				arg_269_1.typewritter:SetDirty()
			end

			if arg_269_1.time_ >= var_272_10 + var_272_18 and arg_269_1.time_ < var_272_10 + var_272_18 + arg_272_0 then
				arg_269_1.typewritter.percent = 1

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(true)
			end
		end

		arg_269_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_269_1:InitPlayNodeList()
	end,
	Play222072066 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 222072066
		arg_273_1.duration_ = 7.7

		local var_273_0 = {
			ja = 7.7,
			ko = 3.9,
			zh = 3.9
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
				arg_273_0:Play222072067(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 and not isNil(arg_273_1.actors_["1071ui_story"]) and arg_273_1.var_.characterEffect1071ui_story == nil then
				arg_273_1.var_.characterEffect1071ui_story = arg_273_1.actors_["1071ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_276_0 = 0.200000002980232

			if 0 <= arg_273_1.time_ and arg_273_1.time_ < 0 + var_276_0 and not isNil(arg_273_1.actors_["1071ui_story"]) then
				if arg_273_1.var_.characterEffect1071ui_story and not isNil(arg_273_1.actors_["1071ui_story"]) then
					arg_273_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_273_1.time_ >= 0 + var_276_0 and arg_273_1.time_ < 0 + var_276_0 + arg_276_0 and not isNil(arg_273_1.actors_["1071ui_story"]) and arg_273_1.var_.characterEffect1071ui_story then
				arg_273_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 then
				arg_273_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action3_1")
			end

			local var_276_2 = arg_273_1.actors_["1074ui_story"]

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 and not isNil(var_276_2) and arg_273_1.var_.characterEffect1074ui_story == nil then
				arg_273_1.var_.characterEffect1074ui_story = var_276_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_276_3 = 0.200000002980232

			if 0 <= arg_273_1.time_ and arg_273_1.time_ < 0 + var_276_3 and not isNil(var_276_2) then
				if arg_273_1.var_.characterEffect1074ui_story and not isNil(var_276_2) then
					arg_273_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_273_1.var_.characterEffect1074ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_273_1.time_ - 0) / var_276_3)
				end
			end

			if arg_273_1.time_ >= 0 + var_276_3 and arg_273_1.time_ < 0 + var_276_3 + arg_276_0 and not isNil(var_276_2) and arg_273_1.var_.characterEffect1074ui_story then
				arg_273_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_273_1.var_.characterEffect1074ui_story.fillRatio = 0.5
			end

			local var_276_4 = 0
			local var_276_5 = 0.425

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= var_276_4 + arg_276_0 then
				arg_273_1.talkMaxDuration = 0
				arg_273_1.dialogCg_.alpha = 1

				arg_273_1.dialog_:SetActive(true)
				SetActive(arg_273_1.leftNameGo_, true)

				arg_273_1.leftNameTxt_.text = arg_273_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_273_1.leftNameTxt_.transform)

				arg_273_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_273_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_273_1:RecordName(arg_273_1.leftNameTxt_.text)
				SetActive(arg_273_1.iconTrs_.gameObject, false)
				arg_273_1.callingController_:SetSelectedState("normal")

				local var_276_6 = arg_273_1:GetWordFromCfg(222072066)
				local var_276_7 = arg_273_1:FormatText(var_276_6.content)

				arg_273_1.text_.text = var_276_7

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_9 = 17 <= 0 and var_276_5 or var_276_5 * (utf8.len(var_276_7) / 17)

				if (17 <= 0 and var_276_5 or var_276_5 * (utf8.len(var_276_7) / 17)) > 0 and var_276_5 < var_276_9 then
					arg_273_1.talkMaxDuration = var_276_9

					if var_276_9 + var_276_4 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_9 + var_276_4
					end
				end

				arg_273_1.text_.text = var_276_7
				arg_273_1.typewritter.percent = 0

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222072", "222072066", "story_v_out_222072.awb") ~= 0 then
					local var_276_10 = manager.audio:GetVoiceLength("story_v_out_222072", "222072066", "story_v_out_222072.awb") / 1000

					if var_276_10 + var_276_4 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_10 + var_276_4
					end

					if var_276_6.prefab_name ~= "" and arg_273_1.actors_[var_276_6.prefab_name] ~= nil then
						local var_276_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_273_1.actors_[var_276_6.prefab_name].transform, "story_v_out_222072", "222072066", "story_v_out_222072.awb")

						arg_273_1:RecordAudio("222072066", var_276_11)
						arg_273_1:RecordAudio("222072066", var_276_11)
					else
						arg_273_1:AudioAction("play", "voice", "story_v_out_222072", "222072066", "story_v_out_222072.awb")
					end

					arg_273_1:RecordHistoryTalkVoice("story_v_out_222072", "222072066", "story_v_out_222072.awb")
				end

				arg_273_1:RecordContent(arg_273_1.text_.text)
			end

			local var_276_12 = math.max(var_276_5, arg_273_1.talkMaxDuration)

			if var_276_4 <= arg_273_1.time_ and arg_273_1.time_ < var_276_4 + var_276_12 then
				arg_273_1.typewritter.percent = (arg_273_1.time_ - var_276_4) / var_276_12

				arg_273_1.typewritter:SetDirty()
			end

			if arg_273_1.time_ >= var_276_4 + var_276_12 and arg_273_1.time_ < var_276_4 + var_276_12 + arg_276_0 then
				arg_273_1.typewritter.percent = 1

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(true)
			end
		end

		arg_273_1.nodeConfigList_ = {}

		arg_273_1:InitPlayNodeList()
	end,
	Play222072067 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 222072067
		arg_277_1.duration_ = 7.03

		local var_277_0 = {
			ja = 6.2,
			ko = 7.033,
			zh = 7.033
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
				arg_277_0:Play222072068(arg_277_1)
			end
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 then
				arg_277_1.var_.moveOldPos1074ui_story = arg_277_1.actors_["1074ui_story"].transform.localPosition
			end

			local var_280_0 = 0.001

			if 0 <= arg_277_1.time_ and arg_277_1.time_ < 0 + var_280_0 then
				arg_277_1.actors_["1074ui_story"].transform.localPosition = Vector3.Lerp(arg_277_1.var_.moveOldPos1074ui_story, Vector3.New(0, 100, 0), (arg_277_1.time_ - 0) / var_280_0)
				arg_277_1.actors_["1074ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_277_1.actors_["1074ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_277_1.actors_["1074ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_277_1.actors_["1074ui_story"].transform.position).z)
				arg_277_1.actors_["1074ui_story"].transform.localEulerAngles.z = 0
				arg_277_1.actors_["1074ui_story"].transform.localEulerAngles.x = 0
				arg_277_1.actors_["1074ui_story"].transform.localEulerAngles = arg_277_1.actors_["1074ui_story"].transform.localEulerAngles
			end

			if arg_277_1.time_ >= 0 + var_280_0 and arg_277_1.time_ < 0 + var_280_0 + arg_280_0 then
				arg_277_1.actors_["1074ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_277_1.actors_["1074ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_277_1.actors_["1074ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_277_1.actors_["1074ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_277_1.actors_["1074ui_story"].transform.position).z)
				arg_277_1.actors_["1074ui_story"].transform.localEulerAngles.z = 0
				arg_277_1.actors_["1074ui_story"].transform.localEulerAngles.x = 0
				arg_277_1.actors_["1074ui_story"].transform.localEulerAngles = arg_277_1.actors_["1074ui_story"].transform.localEulerAngles
			end

			local var_280_1 = arg_277_1.actors_["1074ui_story"]

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 and not isNil(var_280_1) and arg_277_1.var_.characterEffect1074ui_story == nil then
				arg_277_1.var_.characterEffect1074ui_story = var_280_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_280_2 = 0.200000002980232

			if 0 <= arg_277_1.time_ and arg_277_1.time_ < 0 + var_280_2 and not isNil(var_280_1) then
				if arg_277_1.var_.characterEffect1074ui_story and not isNil(var_280_1) then
					arg_277_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_277_1.var_.characterEffect1074ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_277_1.time_ - 0) / var_280_2)
				end
			end

			if arg_277_1.time_ >= 0 + var_280_2 and arg_277_1.time_ < 0 + var_280_2 + arg_280_0 and not isNil(var_280_1) and arg_277_1.var_.characterEffect1074ui_story then
				arg_277_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_277_1.var_.characterEffect1074ui_story.fillRatio = 0.5
			end

			local var_280_3 = arg_277_1.actors_["1070ui_story"].transform

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 then
				arg_277_1.var_.moveOldPos1070ui_story = var_280_3.localPosition
			end

			local var_280_4 = 0.001

			if 0 <= arg_277_1.time_ and arg_277_1.time_ < 0 + var_280_4 then
				var_280_3.localPosition = Vector3.Lerp(arg_277_1.var_.moveOldPos1070ui_story, Vector3.New(-0.7, -0.95, -6.05), (arg_277_1.time_ - 0) / var_280_4)
				var_280_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_280_3.position).x, (manager.ui.mainCamera.transform.position - var_280_3.position).y, (manager.ui.mainCamera.transform.position - var_280_3.position).z)
				var_280_3.localEulerAngles.z = 0
				var_280_3.localEulerAngles.x = 0
				var_280_3.localEulerAngles = var_280_3.localEulerAngles
			end

			if arg_277_1.time_ >= 0 + var_280_4 and arg_277_1.time_ < 0 + var_280_4 + arg_280_0 then
				var_280_3.localPosition = Vector3.New(-0.7, -0.95, -6.05)
				var_280_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_280_3.position).x, (manager.ui.mainCamera.transform.position - var_280_3.position).y, (manager.ui.mainCamera.transform.position - var_280_3.position).z)
				var_280_3.localEulerAngles.z = 0
				var_280_3.localEulerAngles.x = 0
				var_280_3.localEulerAngles = var_280_3.localEulerAngles
			end

			local var_280_5 = arg_277_1.actors_["1070ui_story"]

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 and not isNil(var_280_5) and arg_277_1.var_.characterEffect1070ui_story == nil then
				arg_277_1.var_.characterEffect1070ui_story = var_280_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_280_6 = 0.200000002980232

			if 0 <= arg_277_1.time_ and arg_277_1.time_ < 0 + var_280_6 and not isNil(var_280_5) then
				if arg_277_1.var_.characterEffect1070ui_story and not isNil(var_280_5) then
					arg_277_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_277_1.time_ >= 0 + var_280_6 and arg_277_1.time_ < 0 + var_280_6 + arg_280_0 and not isNil(var_280_5) and arg_277_1.var_.characterEffect1070ui_story then
				arg_277_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 then
				arg_277_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action6_1")
			end

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 then
				arg_277_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_280_8 = arg_277_1.actors_["1071ui_story"]

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 and not isNil(var_280_8) and arg_277_1.var_.characterEffect1071ui_story == nil then
				arg_277_1.var_.characterEffect1071ui_story = var_280_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_280_9 = 0.200000002980232

			if 0 <= arg_277_1.time_ and arg_277_1.time_ < 0 + var_280_9 and not isNil(var_280_8) then
				if arg_277_1.var_.characterEffect1071ui_story and not isNil(var_280_8) then
					arg_277_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_277_1.var_.characterEffect1071ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_277_1.time_ - 0) / var_280_9)
				end
			end

			if arg_277_1.time_ >= 0 + var_280_9 and arg_277_1.time_ < 0 + var_280_9 + arg_280_0 and not isNil(var_280_8) and arg_277_1.var_.characterEffect1071ui_story then
				arg_277_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_277_1.var_.characterEffect1071ui_story.fillRatio = 0.5
			end

			local var_280_10 = 0
			local var_280_11 = 0.725

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= var_280_10 + arg_280_0 then
				arg_277_1.talkMaxDuration = 0
				arg_277_1.dialogCg_.alpha = 1

				arg_277_1.dialog_:SetActive(true)
				SetActive(arg_277_1.leftNameGo_, true)

				arg_277_1.leftNameTxt_.text = arg_277_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_277_1.leftNameTxt_.transform)

				arg_277_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_277_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_277_1:RecordName(arg_277_1.leftNameTxt_.text)
				SetActive(arg_277_1.iconTrs_.gameObject, false)
				arg_277_1.callingController_:SetSelectedState("normal")

				local var_280_12 = arg_277_1:GetWordFromCfg(222072067)
				local var_280_13 = arg_277_1:FormatText(var_280_12.content)

				arg_277_1.text_.text = var_280_13

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_)

				local var_280_15 = 29 <= 0 and var_280_11 or var_280_11 * (utf8.len(var_280_13) / 29)

				if (29 <= 0 and var_280_11 or var_280_11 * (utf8.len(var_280_13) / 29)) > 0 and var_280_11 < var_280_15 then
					arg_277_1.talkMaxDuration = var_280_15

					if var_280_15 + var_280_10 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_15 + var_280_10
					end
				end

				arg_277_1.text_.text = var_280_13
				arg_277_1.typewritter.percent = 0

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222072", "222072067", "story_v_out_222072.awb") ~= 0 then
					local var_280_16 = manager.audio:GetVoiceLength("story_v_out_222072", "222072067", "story_v_out_222072.awb") / 1000

					if var_280_16 + var_280_10 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_16 + var_280_10
					end

					if var_280_12.prefab_name ~= "" and arg_277_1.actors_[var_280_12.prefab_name] ~= nil then
						local var_280_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_277_1.actors_[var_280_12.prefab_name].transform, "story_v_out_222072", "222072067", "story_v_out_222072.awb")

						arg_277_1:RecordAudio("222072067", var_280_17)
						arg_277_1:RecordAudio("222072067", var_280_17)
					else
						arg_277_1:AudioAction("play", "voice", "story_v_out_222072", "222072067", "story_v_out_222072.awb")
					end

					arg_277_1:RecordHistoryTalkVoice("story_v_out_222072", "222072067", "story_v_out_222072.awb")
				end

				arg_277_1:RecordContent(arg_277_1.text_.text)
			end

			local var_280_18 = math.max(var_280_11, arg_277_1.talkMaxDuration)

			if var_280_10 <= arg_277_1.time_ and arg_277_1.time_ < var_280_10 + var_280_18 then
				arg_277_1.typewritter.percent = (arg_277_1.time_ - var_280_10) / var_280_18

				arg_277_1.typewritter:SetDirty()
			end

			if arg_277_1.time_ >= var_280_10 + var_280_18 and arg_277_1.time_ < var_280_10 + var_280_18 + arg_280_0 then
				arg_277_1.typewritter.percent = 1

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(true)
			end
		end

		arg_277_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_277_1:InitPlayNodeList()
	end,
	Play222072068 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 222072068
		arg_281_1.duration_ = 6.83

		local var_281_0 = {
			ja = 6.833,
			ko = 4.633,
			zh = 4.633
		}
		local var_281_1 = manager.audio:GetLocalizationFlag()

		if var_281_0[var_281_1] ~= nil then
			arg_281_1.duration_ = var_281_0[var_281_1]
		end

		SetActive(arg_281_1.tipsGo_, false)

		function arg_281_1.onSingleLineFinish_()
			arg_281_1.onSingleLineUpdate_ = nil
			arg_281_1.onSingleLineFinish_ = nil
			arg_281_1.state_ = "waiting"
		end

		function arg_281_1.playNext_(arg_283_0)
			if arg_283_0 == 1 then
				arg_281_0:Play222072069(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 and not isNil(arg_281_1.actors_["1071ui_story"]) and arg_281_1.var_.characterEffect1071ui_story == nil then
				arg_281_1.var_.characterEffect1071ui_story = arg_281_1.actors_["1071ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_284_0 = 0.200000002980232

			if 0 <= arg_281_1.time_ and arg_281_1.time_ < 0 + var_284_0 and not isNil(arg_281_1.actors_["1071ui_story"]) then
				if arg_281_1.var_.characterEffect1071ui_story and not isNil(arg_281_1.actors_["1071ui_story"]) then
					arg_281_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_281_1.time_ >= 0 + var_284_0 and arg_281_1.time_ < 0 + var_284_0 + arg_284_0 and not isNil(arg_281_1.actors_["1071ui_story"]) and arg_281_1.var_.characterEffect1071ui_story then
				arg_281_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 then
				arg_281_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071actionlink/1071action434")
			end

			local var_284_2 = arg_281_1.actors_["1070ui_story"]

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 and not isNil(var_284_2) and arg_281_1.var_.characterEffect1070ui_story == nil then
				arg_281_1.var_.characterEffect1070ui_story = var_284_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_284_3 = 0.200000002980232

			if 0 <= arg_281_1.time_ and arg_281_1.time_ < 0 + var_284_3 and not isNil(var_284_2) then
				if arg_281_1.var_.characterEffect1070ui_story and not isNil(var_284_2) then
					arg_281_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_281_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_281_1.time_ - 0) / var_284_3)
				end
			end

			if arg_281_1.time_ >= 0 + var_284_3 and arg_281_1.time_ < 0 + var_284_3 + arg_284_0 and not isNil(var_284_2) and arg_281_1.var_.characterEffect1070ui_story then
				arg_281_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_281_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_284_4 = 0
			local var_284_5 = 0.525

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= var_284_4 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0
				arg_281_1.dialogCg_.alpha = 1

				arg_281_1.dialog_:SetActive(true)
				SetActive(arg_281_1.leftNameGo_, true)

				arg_281_1.leftNameTxt_.text = arg_281_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_281_1.leftNameTxt_.transform)

				arg_281_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_281_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_281_1:RecordName(arg_281_1.leftNameTxt_.text)
				SetActive(arg_281_1.iconTrs_.gameObject, false)
				arg_281_1.callingController_:SetSelectedState("normal")

				local var_284_6 = arg_281_1:GetWordFromCfg(222072068)
				local var_284_7 = arg_281_1:FormatText(var_284_6.content)

				arg_281_1.text_.text = var_284_7

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_9 = 21 <= 0 and var_284_5 or var_284_5 * (utf8.len(var_284_7) / 21)

				if (21 <= 0 and var_284_5 or var_284_5 * (utf8.len(var_284_7) / 21)) > 0 and var_284_5 < var_284_9 then
					arg_281_1.talkMaxDuration = var_284_9

					if var_284_9 + var_284_4 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_9 + var_284_4
					end
				end

				arg_281_1.text_.text = var_284_7
				arg_281_1.typewritter.percent = 0

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222072", "222072068", "story_v_out_222072.awb") ~= 0 then
					local var_284_10 = manager.audio:GetVoiceLength("story_v_out_222072", "222072068", "story_v_out_222072.awb") / 1000

					if var_284_10 + var_284_4 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_10 + var_284_4
					end

					if var_284_6.prefab_name ~= "" and arg_281_1.actors_[var_284_6.prefab_name] ~= nil then
						local var_284_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_281_1.actors_[var_284_6.prefab_name].transform, "story_v_out_222072", "222072068", "story_v_out_222072.awb")

						arg_281_1:RecordAudio("222072068", var_284_11)
						arg_281_1:RecordAudio("222072068", var_284_11)
					else
						arg_281_1:AudioAction("play", "voice", "story_v_out_222072", "222072068", "story_v_out_222072.awb")
					end

					arg_281_1:RecordHistoryTalkVoice("story_v_out_222072", "222072068", "story_v_out_222072.awb")
				end

				arg_281_1:RecordContent(arg_281_1.text_.text)
			end

			local var_284_12 = math.max(var_284_5, arg_281_1.talkMaxDuration)

			if var_284_4 <= arg_281_1.time_ and arg_281_1.time_ < var_284_4 + var_284_12 then
				arg_281_1.typewritter.percent = (arg_281_1.time_ - var_284_4) / var_284_12

				arg_281_1.typewritter:SetDirty()
			end

			if arg_281_1.time_ >= var_284_4 + var_284_12 and arg_281_1.time_ < var_284_4 + var_284_12 + arg_284_0 then
				arg_281_1.typewritter.percent = 1

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(true)
			end
		end

		arg_281_1.nodeConfigList_ = {}

		arg_281_1:InitPlayNodeList()
	end,
	Play222072069 = function(arg_285_0, arg_285_1)
		arg_285_1.time_ = 0
		arg_285_1.frameCnt_ = 0
		arg_285_1.state_ = "playing"
		arg_285_1.curTalkId_ = 222072069
		arg_285_1.duration_ = 4.43

		local var_285_0 = {
			ja = 4.433,
			ko = 1.999999999999,
			zh = 1.999999999999
		}
		local var_285_1 = manager.audio:GetLocalizationFlag()

		if var_285_0[var_285_1] ~= nil then
			arg_285_1.duration_ = var_285_0[var_285_1]
		end

		SetActive(arg_285_1.tipsGo_, false)

		function arg_285_1.onSingleLineFinish_()
			arg_285_1.onSingleLineUpdate_ = nil
			arg_285_1.onSingleLineFinish_ = nil
			arg_285_1.state_ = "waiting"
		end

		function arg_285_1.playNext_(arg_287_0)
			if arg_287_0 == 1 then
				arg_285_0:Play222072070(arg_285_1)
			end
		end

		function arg_285_1.onSingleLineUpdate_(arg_288_0)
			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 then
				arg_285_1.var_.moveOldPos1070ui_story = arg_285_1.actors_["1070ui_story"].transform.localPosition
			end

			local var_288_0 = 0.001

			if 0 <= arg_285_1.time_ and arg_285_1.time_ < 0 + var_288_0 then
				arg_285_1.actors_["1070ui_story"].transform.localPosition = Vector3.Lerp(arg_285_1.var_.moveOldPos1070ui_story, Vector3.New(0, 100, 0), (arg_285_1.time_ - 0) / var_288_0)
				arg_285_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_285_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_285_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_285_1.actors_["1070ui_story"].transform.position).z)
				arg_285_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_285_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_285_1.actors_["1070ui_story"].transform.localEulerAngles = arg_285_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			if arg_285_1.time_ >= 0 + var_288_0 and arg_285_1.time_ < 0 + var_288_0 + arg_288_0 then
				arg_285_1.actors_["1070ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_285_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_285_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_285_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_285_1.actors_["1070ui_story"].transform.position).z)
				arg_285_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_285_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_285_1.actors_["1070ui_story"].transform.localEulerAngles = arg_285_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			local var_288_1 = arg_285_1.actors_["1070ui_story"]

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 and not isNil(var_288_1) and arg_285_1.var_.characterEffect1070ui_story == nil then
				arg_285_1.var_.characterEffect1070ui_story = var_288_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_288_2 = 0.200000002980232

			if 0 <= arg_285_1.time_ and arg_285_1.time_ < 0 + var_288_2 and not isNil(var_288_1) then
				if arg_285_1.var_.characterEffect1070ui_story and not isNil(var_288_1) then
					arg_285_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_285_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_285_1.time_ - 0) / var_288_2)
				end
			end

			if arg_285_1.time_ >= 0 + var_288_2 and arg_285_1.time_ < 0 + var_288_2 + arg_288_0 and not isNil(var_288_1) and arg_285_1.var_.characterEffect1070ui_story then
				arg_285_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_285_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_288_3 = arg_285_1.actors_["1074ui_story"].transform

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 then
				arg_285_1.var_.moveOldPos1074ui_story = var_288_3.localPosition
			end

			local var_288_4 = 0.001

			if 0 <= arg_285_1.time_ and arg_285_1.time_ < 0 + var_288_4 then
				var_288_3.localPosition = Vector3.Lerp(arg_285_1.var_.moveOldPos1074ui_story, Vector3.New(-0.7, -1.055, -6.12), (arg_285_1.time_ - 0) / var_288_4)
				var_288_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_288_3.position).x, (manager.ui.mainCamera.transform.position - var_288_3.position).y, (manager.ui.mainCamera.transform.position - var_288_3.position).z)
				var_288_3.localEulerAngles.z = 0
				var_288_3.localEulerAngles.x = 0
				var_288_3.localEulerAngles = var_288_3.localEulerAngles
			end

			if arg_285_1.time_ >= 0 + var_288_4 and arg_285_1.time_ < 0 + var_288_4 + arg_288_0 then
				var_288_3.localPosition = Vector3.New(-0.7, -1.055, -6.12)
				var_288_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_288_3.position).x, (manager.ui.mainCamera.transform.position - var_288_3.position).y, (manager.ui.mainCamera.transform.position - var_288_3.position).z)
				var_288_3.localEulerAngles.z = 0
				var_288_3.localEulerAngles.x = 0
				var_288_3.localEulerAngles = var_288_3.localEulerAngles
			end

			local var_288_5 = arg_285_1.actors_["1074ui_story"]

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 and not isNil(var_288_5) and arg_285_1.var_.characterEffect1074ui_story == nil then
				arg_285_1.var_.characterEffect1074ui_story = var_288_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_288_6 = 0.200000002980232

			if 0 <= arg_285_1.time_ and arg_285_1.time_ < 0 + var_288_6 and not isNil(var_288_5) then
				if arg_285_1.var_.characterEffect1074ui_story and not isNil(var_288_5) then
					arg_285_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_285_1.time_ >= 0 + var_288_6 and arg_285_1.time_ < 0 + var_288_6 + arg_288_0 and not isNil(var_288_5) and arg_285_1.var_.characterEffect1074ui_story then
				arg_285_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 then
				arg_285_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action1_1")
			end

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 then
				arg_285_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_288_8 = arg_285_1.actors_["1071ui_story"]

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 and not isNil(var_288_8) and arg_285_1.var_.characterEffect1071ui_story == nil then
				arg_285_1.var_.characterEffect1071ui_story = var_288_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_288_9 = 0.200000002980232

			if 0 <= arg_285_1.time_ and arg_285_1.time_ < 0 + var_288_9 and not isNil(var_288_8) then
				if arg_285_1.var_.characterEffect1071ui_story and not isNil(var_288_8) then
					arg_285_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_285_1.var_.characterEffect1071ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_285_1.time_ - 0) / var_288_9)
				end
			end

			if arg_285_1.time_ >= 0 + var_288_9 and arg_285_1.time_ < 0 + var_288_9 + arg_288_0 and not isNil(var_288_8) and arg_285_1.var_.characterEffect1071ui_story then
				arg_285_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_285_1.var_.characterEffect1071ui_story.fillRatio = 0.5
			end

			local var_288_10 = 0
			local var_288_11 = 0.25

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= var_288_10 + arg_288_0 then
				arg_285_1.talkMaxDuration = 0
				arg_285_1.dialogCg_.alpha = 1

				arg_285_1.dialog_:SetActive(true)
				SetActive(arg_285_1.leftNameGo_, true)

				arg_285_1.leftNameTxt_.text = arg_285_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_285_1.leftNameTxt_.transform)

				arg_285_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_285_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_285_1:RecordName(arg_285_1.leftNameTxt_.text)
				SetActive(arg_285_1.iconTrs_.gameObject, false)
				arg_285_1.callingController_:SetSelectedState("normal")

				local var_288_12 = arg_285_1:GetWordFromCfg(222072069)
				local var_288_13 = arg_285_1:FormatText(var_288_12.content)

				arg_285_1.text_.text = var_288_13

				LuaForUtil.ClearLinePrefixSymbol(arg_285_1.text_)

				local var_288_15 = 10 <= 0 and var_288_11 or var_288_11 * (utf8.len(var_288_13) / 10)

				if (10 <= 0 and var_288_11 or var_288_11 * (utf8.len(var_288_13) / 10)) > 0 and var_288_11 < var_288_15 then
					arg_285_1.talkMaxDuration = var_288_15

					if var_288_15 + var_288_10 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_15 + var_288_10
					end
				end

				arg_285_1.text_.text = var_288_13
				arg_285_1.typewritter.percent = 0

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222072", "222072069", "story_v_out_222072.awb") ~= 0 then
					local var_288_16 = manager.audio:GetVoiceLength("story_v_out_222072", "222072069", "story_v_out_222072.awb") / 1000

					if var_288_16 + var_288_10 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_16 + var_288_10
					end

					if var_288_12.prefab_name ~= "" and arg_285_1.actors_[var_288_12.prefab_name] ~= nil then
						local var_288_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_285_1.actors_[var_288_12.prefab_name].transform, "story_v_out_222072", "222072069", "story_v_out_222072.awb")

						arg_285_1:RecordAudio("222072069", var_288_17)
						arg_285_1:RecordAudio("222072069", var_288_17)
					else
						arg_285_1:AudioAction("play", "voice", "story_v_out_222072", "222072069", "story_v_out_222072.awb")
					end

					arg_285_1:RecordHistoryTalkVoice("story_v_out_222072", "222072069", "story_v_out_222072.awb")
				end

				arg_285_1:RecordContent(arg_285_1.text_.text)
			end

			local var_288_18 = math.max(var_288_11, arg_285_1.talkMaxDuration)

			if var_288_10 <= arg_285_1.time_ and arg_285_1.time_ < var_288_10 + var_288_18 then
				arg_285_1.typewritter.percent = (arg_285_1.time_ - var_288_10) / var_288_18

				arg_285_1.typewritter:SetDirty()
			end

			if arg_285_1.time_ >= var_288_10 + var_288_18 and arg_285_1.time_ < var_288_10 + var_288_18 + arg_288_0 then
				arg_285_1.typewritter.percent = 1

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(true)
			end
		end

		arg_285_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_285_1:InitPlayNodeList()
	end,
	Play222072070 = function(arg_289_0, arg_289_1)
		arg_289_1.time_ = 0
		arg_289_1.frameCnt_ = 0
		arg_289_1.state_ = "playing"
		arg_289_1.curTalkId_ = 222072070
		arg_289_1.duration_ = 6.8

		local var_289_0 = {
			ja = 6.8,
			ko = 3.566,
			zh = 3.533
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
				arg_289_0:Play222072071(arg_289_1)
			end
		end

		function arg_289_1.onSingleLineUpdate_(arg_292_0)
			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 and not isNil(arg_289_1.actors_["1071ui_story"]) and arg_289_1.var_.characterEffect1071ui_story == nil then
				arg_289_1.var_.characterEffect1071ui_story = arg_289_1.actors_["1071ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_292_0 = 0.200000002980232

			if 0 <= arg_289_1.time_ and arg_289_1.time_ < 0 + var_292_0 and not isNil(arg_289_1.actors_["1071ui_story"]) then
				if arg_289_1.var_.characterEffect1071ui_story and not isNil(arg_289_1.actors_["1071ui_story"]) then
					arg_289_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_289_1.time_ >= 0 + var_292_0 and arg_289_1.time_ < 0 + var_292_0 + arg_292_0 and not isNil(arg_289_1.actors_["1071ui_story"]) and arg_289_1.var_.characterEffect1071ui_story then
				arg_289_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 then
				arg_289_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action4_2")
			end

			local var_292_2 = arg_289_1.actors_["1074ui_story"]

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 and not isNil(var_292_2) and arg_289_1.var_.characterEffect1074ui_story == nil then
				arg_289_1.var_.characterEffect1074ui_story = var_292_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_292_3 = 0.200000002980232

			if 0 <= arg_289_1.time_ and arg_289_1.time_ < 0 + var_292_3 and not isNil(var_292_2) then
				if arg_289_1.var_.characterEffect1074ui_story and not isNil(var_292_2) then
					arg_289_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_289_1.var_.characterEffect1074ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_289_1.time_ - 0) / var_292_3)
				end
			end

			if arg_289_1.time_ >= 0 + var_292_3 and arg_289_1.time_ < 0 + var_292_3 + arg_292_0 and not isNil(var_292_2) and arg_289_1.var_.characterEffect1074ui_story then
				arg_289_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_289_1.var_.characterEffect1074ui_story.fillRatio = 0.5
			end

			local var_292_4 = 0
			local var_292_5 = 0.35

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= var_292_4 + arg_292_0 then
				arg_289_1.talkMaxDuration = 0
				arg_289_1.dialogCg_.alpha = 1

				arg_289_1.dialog_:SetActive(true)
				SetActive(arg_289_1.leftNameGo_, true)

				arg_289_1.leftNameTxt_.text = arg_289_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_289_1.leftNameTxt_.transform)

				arg_289_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_289_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_289_1:RecordName(arg_289_1.leftNameTxt_.text)
				SetActive(arg_289_1.iconTrs_.gameObject, false)
				arg_289_1.callingController_:SetSelectedState("normal")

				local var_292_6 = arg_289_1:GetWordFromCfg(222072070)
				local var_292_7 = arg_289_1:FormatText(var_292_6.content)

				arg_289_1.text_.text = var_292_7

				LuaForUtil.ClearLinePrefixSymbol(arg_289_1.text_)

				local var_292_9 = 14 <= 0 and var_292_5 or var_292_5 * (utf8.len(var_292_7) / 14)

				if (14 <= 0 and var_292_5 or var_292_5 * (utf8.len(var_292_7) / 14)) > 0 and var_292_5 < var_292_9 then
					arg_289_1.talkMaxDuration = var_292_9

					if var_292_9 + var_292_4 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_9 + var_292_4
					end
				end

				arg_289_1.text_.text = var_292_7
				arg_289_1.typewritter.percent = 0

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222072", "222072070", "story_v_out_222072.awb") ~= 0 then
					local var_292_10 = manager.audio:GetVoiceLength("story_v_out_222072", "222072070", "story_v_out_222072.awb") / 1000

					if var_292_10 + var_292_4 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_10 + var_292_4
					end

					if var_292_6.prefab_name ~= "" and arg_289_1.actors_[var_292_6.prefab_name] ~= nil then
						local var_292_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_289_1.actors_[var_292_6.prefab_name].transform, "story_v_out_222072", "222072070", "story_v_out_222072.awb")

						arg_289_1:RecordAudio("222072070", var_292_11)
						arg_289_1:RecordAudio("222072070", var_292_11)
					else
						arg_289_1:AudioAction("play", "voice", "story_v_out_222072", "222072070", "story_v_out_222072.awb")
					end

					arg_289_1:RecordHistoryTalkVoice("story_v_out_222072", "222072070", "story_v_out_222072.awb")
				end

				arg_289_1:RecordContent(arg_289_1.text_.text)
			end

			local var_292_12 = math.max(var_292_5, arg_289_1.talkMaxDuration)

			if var_292_4 <= arg_289_1.time_ and arg_289_1.time_ < var_292_4 + var_292_12 then
				arg_289_1.typewritter.percent = (arg_289_1.time_ - var_292_4) / var_292_12

				arg_289_1.typewritter:SetDirty()
			end

			if arg_289_1.time_ >= var_292_4 + var_292_12 and arg_289_1.time_ < var_292_4 + var_292_12 + arg_292_0 then
				arg_289_1.typewritter.percent = 1

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(true)
			end
		end

		arg_289_1.nodeConfigList_ = {}

		arg_289_1:InitPlayNodeList()
	end,
	Play222072071 = function(arg_293_0, arg_293_1)
		arg_293_1.time_ = 0
		arg_293_1.frameCnt_ = 0
		arg_293_1.state_ = "playing"
		arg_293_1.curTalkId_ = 222072071
		arg_293_1.duration_ = 15.23

		local var_293_0 = {
			ja = 15.233,
			ko = 8.333,
			zh = 8.333
		}
		local var_293_1 = manager.audio:GetLocalizationFlag()

		if var_293_0[var_293_1] ~= nil then
			arg_293_1.duration_ = var_293_0[var_293_1]
		end

		SetActive(arg_293_1.tipsGo_, false)

		function arg_293_1.onSingleLineFinish_()
			arg_293_1.onSingleLineUpdate_ = nil
			arg_293_1.onSingleLineFinish_ = nil
			arg_293_1.state_ = "waiting"
		end

		function arg_293_1.playNext_(arg_295_0)
			if arg_295_0 == 1 then
				arg_293_0:Play222072072(arg_293_1)
			end
		end

		function arg_293_1.onSingleLineUpdate_(arg_296_0)
			local var_296_0 = 1.025

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 then
				arg_293_1.talkMaxDuration = 0
				arg_293_1.dialogCg_.alpha = 1

				arg_293_1.dialog_:SetActive(true)
				SetActive(arg_293_1.leftNameGo_, true)

				arg_293_1.leftNameTxt_.text = arg_293_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_293_1.leftNameTxt_.transform)

				arg_293_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_293_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_293_1:RecordName(arg_293_1.leftNameTxt_.text)
				SetActive(arg_293_1.iconTrs_.gameObject, false)
				arg_293_1.callingController_:SetSelectedState("normal")

				local var_296_1 = arg_293_1:GetWordFromCfg(222072071)
				local var_296_2 = arg_293_1:FormatText(var_296_1.content)

				arg_293_1.text_.text = var_296_2

				LuaForUtil.ClearLinePrefixSymbol(arg_293_1.text_)

				local var_296_4 = 41 <= 0 and var_296_0 or var_296_0 * (utf8.len(var_296_2) / 41)

				if (41 <= 0 and var_296_0 or var_296_0 * (utf8.len(var_296_2) / 41)) > 0 and var_296_0 < var_296_4 then
					arg_293_1.talkMaxDuration = var_296_4

					if var_296_4 + 0 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_4 + 0
					end
				end

				arg_293_1.text_.text = var_296_2
				arg_293_1.typewritter.percent = 0

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222072", "222072071", "story_v_out_222072.awb") ~= 0 then
					local var_296_5 = manager.audio:GetVoiceLength("story_v_out_222072", "222072071", "story_v_out_222072.awb") / 1000

					if var_296_5 + 0 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_5 + 0
					end

					if var_296_1.prefab_name ~= "" and arg_293_1.actors_[var_296_1.prefab_name] ~= nil then
						local var_296_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_293_1.actors_[var_296_1.prefab_name].transform, "story_v_out_222072", "222072071", "story_v_out_222072.awb")

						arg_293_1:RecordAudio("222072071", var_296_6)
						arg_293_1:RecordAudio("222072071", var_296_6)
					else
						arg_293_1:AudioAction("play", "voice", "story_v_out_222072", "222072071", "story_v_out_222072.awb")
					end

					arg_293_1:RecordHistoryTalkVoice("story_v_out_222072", "222072071", "story_v_out_222072.awb")
				end

				arg_293_1:RecordContent(arg_293_1.text_.text)
			end

			local var_296_7 = math.max(var_296_0, arg_293_1.talkMaxDuration)

			if 0 <= arg_293_1.time_ and arg_293_1.time_ < 0 + var_296_7 then
				arg_293_1.typewritter.percent = (arg_293_1.time_ - 0) / var_296_7

				arg_293_1.typewritter:SetDirty()
			end

			if arg_293_1.time_ >= 0 + var_296_7 and arg_293_1.time_ < 0 + var_296_7 + arg_296_0 then
				arg_293_1.typewritter.percent = 1

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(true)
			end
		end

		arg_293_1.nodeConfigList_ = {}

		arg_293_1:InitPlayNodeList()
	end,
	Play222072072 = function(arg_297_0, arg_297_1)
		arg_297_1.time_ = 0
		arg_297_1.frameCnt_ = 0
		arg_297_1.state_ = "playing"
		arg_297_1.curTalkId_ = 222072072
		arg_297_1.duration_ = 15.57

		local var_297_0 = {
			ja = 15.566,
			ko = 9.966,
			zh = 10.033
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
				arg_297_0:Play222072073(arg_297_1)
			end
		end

		function arg_297_1.onSingleLineUpdate_(arg_300_0)
			if 0 < arg_297_1.time_ and arg_297_1.time_ <= 0 + arg_300_0 and not isNil(arg_297_1.actors_["1074ui_story"]) and arg_297_1.var_.characterEffect1074ui_story == nil then
				arg_297_1.var_.characterEffect1074ui_story = arg_297_1.actors_["1074ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_300_0 = 0.200000002980232

			if 0 <= arg_297_1.time_ and arg_297_1.time_ < 0 + var_300_0 and not isNil(arg_297_1.actors_["1074ui_story"]) then
				if arg_297_1.var_.characterEffect1074ui_story and not isNil(arg_297_1.actors_["1074ui_story"]) then
					arg_297_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_297_1.time_ >= 0 + var_300_0 and arg_297_1.time_ < 0 + var_300_0 + arg_300_0 and not isNil(arg_297_1.actors_["1074ui_story"]) and arg_297_1.var_.characterEffect1074ui_story then
				arg_297_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			if 0 < arg_297_1.time_ and arg_297_1.time_ <= 0 + arg_300_0 then
				arg_297_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action5_1")
			end

			if 0 < arg_297_1.time_ and arg_297_1.time_ <= 0 + arg_300_0 then
				arg_297_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_300_2 = arg_297_1.actors_["1071ui_story"]

			if 0 < arg_297_1.time_ and arg_297_1.time_ <= 0 + arg_300_0 and not isNil(var_300_2) and arg_297_1.var_.characterEffect1071ui_story == nil then
				arg_297_1.var_.characterEffect1071ui_story = var_300_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_300_3 = 0.200000002980232

			if 0 <= arg_297_1.time_ and arg_297_1.time_ < 0 + var_300_3 and not isNil(var_300_2) then
				if arg_297_1.var_.characterEffect1071ui_story and not isNil(var_300_2) then
					arg_297_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_297_1.var_.characterEffect1071ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_297_1.time_ - 0) / var_300_3)
				end
			end

			if arg_297_1.time_ >= 0 + var_300_3 and arg_297_1.time_ < 0 + var_300_3 + arg_300_0 and not isNil(var_300_2) and arg_297_1.var_.characterEffect1071ui_story then
				arg_297_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_297_1.var_.characterEffect1071ui_story.fillRatio = 0.5
			end

			local var_300_4 = 0
			local var_300_5 = 1.25

			if 0 < arg_297_1.time_ and arg_297_1.time_ <= var_300_4 + arg_300_0 then
				arg_297_1.talkMaxDuration = 0
				arg_297_1.dialogCg_.alpha = 1

				arg_297_1.dialog_:SetActive(true)
				SetActive(arg_297_1.leftNameGo_, true)

				arg_297_1.leftNameTxt_.text = arg_297_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_297_1.leftNameTxt_.transform)

				arg_297_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_297_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_297_1:RecordName(arg_297_1.leftNameTxt_.text)
				SetActive(arg_297_1.iconTrs_.gameObject, false)
				arg_297_1.callingController_:SetSelectedState("normal")

				local var_300_6 = arg_297_1:GetWordFromCfg(222072072)
				local var_300_7 = arg_297_1:FormatText(var_300_6.content)

				arg_297_1.text_.text = var_300_7

				LuaForUtil.ClearLinePrefixSymbol(arg_297_1.text_)

				local var_300_9 = 50 <= 0 and var_300_5 or var_300_5 * (utf8.len(var_300_7) / 50)

				if (50 <= 0 and var_300_5 or var_300_5 * (utf8.len(var_300_7) / 50)) > 0 and var_300_5 < var_300_9 then
					arg_297_1.talkMaxDuration = var_300_9

					if var_300_9 + var_300_4 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_9 + var_300_4
					end
				end

				arg_297_1.text_.text = var_300_7
				arg_297_1.typewritter.percent = 0

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222072", "222072072", "story_v_out_222072.awb") ~= 0 then
					local var_300_10 = manager.audio:GetVoiceLength("story_v_out_222072", "222072072", "story_v_out_222072.awb") / 1000

					if var_300_10 + var_300_4 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_10 + var_300_4
					end

					if var_300_6.prefab_name ~= "" and arg_297_1.actors_[var_300_6.prefab_name] ~= nil then
						local var_300_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_297_1.actors_[var_300_6.prefab_name].transform, "story_v_out_222072", "222072072", "story_v_out_222072.awb")

						arg_297_1:RecordAudio("222072072", var_300_11)
						arg_297_1:RecordAudio("222072072", var_300_11)
					else
						arg_297_1:AudioAction("play", "voice", "story_v_out_222072", "222072072", "story_v_out_222072.awb")
					end

					arg_297_1:RecordHistoryTalkVoice("story_v_out_222072", "222072072", "story_v_out_222072.awb")
				end

				arg_297_1:RecordContent(arg_297_1.text_.text)
			end

			local var_300_12 = math.max(var_300_5, arg_297_1.talkMaxDuration)

			if var_300_4 <= arg_297_1.time_ and arg_297_1.time_ < var_300_4 + var_300_12 then
				arg_297_1.typewritter.percent = (arg_297_1.time_ - var_300_4) / var_300_12

				arg_297_1.typewritter:SetDirty()
			end

			if arg_297_1.time_ >= var_300_4 + var_300_12 and arg_297_1.time_ < var_300_4 + var_300_12 + arg_300_0 then
				arg_297_1.typewritter.percent = 1

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(true)
			end
		end

		arg_297_1.nodeConfigList_ = {}

		arg_297_1:InitPlayNodeList()
	end,
	Play222072073 = function(arg_301_0, arg_301_1)
		arg_301_1.time_ = 0
		arg_301_1.frameCnt_ = 0
		arg_301_1.state_ = "playing"
		arg_301_1.curTalkId_ = 222072073
		arg_301_1.duration_ = 12.5

		local var_301_0 = {
			ja = 12.5,
			ko = 9.6,
			zh = 9.566
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
				arg_301_0:Play222072074(arg_301_1)
			end
		end

		function arg_301_1.onSingleLineUpdate_(arg_304_0)
			local var_304_0 = 1.15

			if 0 < arg_301_1.time_ and arg_301_1.time_ <= 0 + arg_304_0 then
				arg_301_1.talkMaxDuration = 0
				arg_301_1.dialogCg_.alpha = 1

				arg_301_1.dialog_:SetActive(true)
				SetActive(arg_301_1.leftNameGo_, true)

				arg_301_1.leftNameTxt_.text = arg_301_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_301_1.leftNameTxt_.transform)

				arg_301_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_301_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_301_1:RecordName(arg_301_1.leftNameTxt_.text)
				SetActive(arg_301_1.iconTrs_.gameObject, false)
				arg_301_1.callingController_:SetSelectedState("normal")

				local var_304_1 = arg_301_1:GetWordFromCfg(222072073)
				local var_304_2 = arg_301_1:FormatText(var_304_1.content)

				arg_301_1.text_.text = var_304_2

				LuaForUtil.ClearLinePrefixSymbol(arg_301_1.text_)

				local var_304_4 = 46 <= 0 and var_304_0 or var_304_0 * (utf8.len(var_304_2) / 46)

				if (46 <= 0 and var_304_0 or var_304_0 * (utf8.len(var_304_2) / 46)) > 0 and var_304_0 < var_304_4 then
					arg_301_1.talkMaxDuration = var_304_4

					if var_304_4 + 0 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_4 + 0
					end
				end

				arg_301_1.text_.text = var_304_2
				arg_301_1.typewritter.percent = 0

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222072", "222072073", "story_v_out_222072.awb") ~= 0 then
					local var_304_5 = manager.audio:GetVoiceLength("story_v_out_222072", "222072073", "story_v_out_222072.awb") / 1000

					if var_304_5 + 0 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_5 + 0
					end

					if var_304_1.prefab_name ~= "" and arg_301_1.actors_[var_304_1.prefab_name] ~= nil then
						local var_304_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_301_1.actors_[var_304_1.prefab_name].transform, "story_v_out_222072", "222072073", "story_v_out_222072.awb")

						arg_301_1:RecordAudio("222072073", var_304_6)
						arg_301_1:RecordAudio("222072073", var_304_6)
					else
						arg_301_1:AudioAction("play", "voice", "story_v_out_222072", "222072073", "story_v_out_222072.awb")
					end

					arg_301_1:RecordHistoryTalkVoice("story_v_out_222072", "222072073", "story_v_out_222072.awb")
				end

				arg_301_1:RecordContent(arg_301_1.text_.text)
			end

			local var_304_7 = math.max(var_304_0, arg_301_1.talkMaxDuration)

			if 0 <= arg_301_1.time_ and arg_301_1.time_ < 0 + var_304_7 then
				arg_301_1.typewritter.percent = (arg_301_1.time_ - 0) / var_304_7

				arg_301_1.typewritter:SetDirty()
			end

			if arg_301_1.time_ >= 0 + var_304_7 and arg_301_1.time_ < 0 + var_304_7 + arg_304_0 then
				arg_301_1.typewritter.percent = 1

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(true)
			end
		end

		arg_301_1.nodeConfigList_ = {}

		arg_301_1:InitPlayNodeList()
	end,
	Play222072074 = function(arg_305_0, arg_305_1)
		arg_305_1.time_ = 0
		arg_305_1.frameCnt_ = 0
		arg_305_1.state_ = "playing"
		arg_305_1.curTalkId_ = 222072074
		arg_305_1.duration_ = 11.3

		local var_305_0 = {
			ja = 11.3,
			ko = 7.2,
			zh = 7.2
		}
		local var_305_1 = manager.audio:GetLocalizationFlag()

		if var_305_0[var_305_1] ~= nil then
			arg_305_1.duration_ = var_305_0[var_305_1]
		end

		SetActive(arg_305_1.tipsGo_, false)

		function arg_305_1.onSingleLineFinish_()
			arg_305_1.onSingleLineUpdate_ = nil
			arg_305_1.onSingleLineFinish_ = nil
			arg_305_1.state_ = "waiting"
		end

		function arg_305_1.playNext_(arg_307_0)
			if arg_307_0 == 1 then
				arg_305_0:Play222072075(arg_305_1)
			end
		end

		function arg_305_1.onSingleLineUpdate_(arg_308_0)
			if 0 < arg_305_1.time_ and arg_305_1.time_ <= 0 + arg_308_0 then
				arg_305_1.var_.moveOldPos1074ui_story = arg_305_1.actors_["1074ui_story"].transform.localPosition
			end

			local var_308_0 = 0.001

			if 0 <= arg_305_1.time_ and arg_305_1.time_ < 0 + var_308_0 then
				arg_305_1.actors_["1074ui_story"].transform.localPosition = Vector3.Lerp(arg_305_1.var_.moveOldPos1074ui_story, Vector3.New(0, 100, 0), (arg_305_1.time_ - 0) / var_308_0)
				arg_305_1.actors_["1074ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_305_1.actors_["1074ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_305_1.actors_["1074ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_305_1.actors_["1074ui_story"].transform.position).z)
				arg_305_1.actors_["1074ui_story"].transform.localEulerAngles.z = 0
				arg_305_1.actors_["1074ui_story"].transform.localEulerAngles.x = 0
				arg_305_1.actors_["1074ui_story"].transform.localEulerAngles = arg_305_1.actors_["1074ui_story"].transform.localEulerAngles
			end

			if arg_305_1.time_ >= 0 + var_308_0 and arg_305_1.time_ < 0 + var_308_0 + arg_308_0 then
				arg_305_1.actors_["1074ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_305_1.actors_["1074ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_305_1.actors_["1074ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_305_1.actors_["1074ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_305_1.actors_["1074ui_story"].transform.position).z)
				arg_305_1.actors_["1074ui_story"].transform.localEulerAngles.z = 0
				arg_305_1.actors_["1074ui_story"].transform.localEulerAngles.x = 0
				arg_305_1.actors_["1074ui_story"].transform.localEulerAngles = arg_305_1.actors_["1074ui_story"].transform.localEulerAngles
			end

			local var_308_1 = arg_305_1.actors_["1074ui_story"]

			if 0 < arg_305_1.time_ and arg_305_1.time_ <= 0 + arg_308_0 and not isNil(var_308_1) and arg_305_1.var_.characterEffect1074ui_story == nil then
				arg_305_1.var_.characterEffect1074ui_story = var_308_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_308_2 = 0.200000002980232

			if 0 <= arg_305_1.time_ and arg_305_1.time_ < 0 + var_308_2 and not isNil(var_308_1) then
				if arg_305_1.var_.characterEffect1074ui_story and not isNil(var_308_1) then
					arg_305_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_305_1.var_.characterEffect1074ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_305_1.time_ - 0) / var_308_2)
				end
			end

			if arg_305_1.time_ >= 0 + var_308_2 and arg_305_1.time_ < 0 + var_308_2 + arg_308_0 and not isNil(var_308_1) and arg_305_1.var_.characterEffect1074ui_story then
				arg_305_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_305_1.var_.characterEffect1074ui_story.fillRatio = 0.5
			end

			local var_308_3 = arg_305_1.actors_["1070ui_story"].transform

			if 0 < arg_305_1.time_ and arg_305_1.time_ <= 0 + arg_308_0 then
				arg_305_1.var_.moveOldPos1070ui_story = var_308_3.localPosition
			end

			local var_308_4 = 0.001

			if 0 <= arg_305_1.time_ and arg_305_1.time_ < 0 + var_308_4 then
				var_308_3.localPosition = Vector3.Lerp(arg_305_1.var_.moveOldPos1070ui_story, Vector3.New(-0.7, -0.95, -6.05), (arg_305_1.time_ - 0) / var_308_4)
				var_308_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_308_3.position).x, (manager.ui.mainCamera.transform.position - var_308_3.position).y, (manager.ui.mainCamera.transform.position - var_308_3.position).z)
				var_308_3.localEulerAngles.z = 0
				var_308_3.localEulerAngles.x = 0
				var_308_3.localEulerAngles = var_308_3.localEulerAngles
			end

			if arg_305_1.time_ >= 0 + var_308_4 and arg_305_1.time_ < 0 + var_308_4 + arg_308_0 then
				var_308_3.localPosition = Vector3.New(-0.7, -0.95, -6.05)
				var_308_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_308_3.position).x, (manager.ui.mainCamera.transform.position - var_308_3.position).y, (manager.ui.mainCamera.transform.position - var_308_3.position).z)
				var_308_3.localEulerAngles.z = 0
				var_308_3.localEulerAngles.x = 0
				var_308_3.localEulerAngles = var_308_3.localEulerAngles
			end

			local var_308_5 = arg_305_1.actors_["1070ui_story"]

			if 0 < arg_305_1.time_ and arg_305_1.time_ <= 0 + arg_308_0 and not isNil(var_308_5) and arg_305_1.var_.characterEffect1070ui_story == nil then
				arg_305_1.var_.characterEffect1070ui_story = var_308_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_308_6 = 0.200000002980232

			if 0 <= arg_305_1.time_ and arg_305_1.time_ < 0 + var_308_6 and not isNil(var_308_5) then
				if arg_305_1.var_.characterEffect1070ui_story and not isNil(var_308_5) then
					arg_305_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_305_1.time_ >= 0 + var_308_6 and arg_305_1.time_ < 0 + var_308_6 + arg_308_0 and not isNil(var_308_5) and arg_305_1.var_.characterEffect1070ui_story then
				arg_305_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			if 0 < arg_305_1.time_ and arg_305_1.time_ <= 0 + arg_308_0 then
				arg_305_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action6_1")
			end

			if 0 < arg_305_1.time_ and arg_305_1.time_ <= 0 + arg_308_0 then
				arg_305_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_308_8 = 0
			local var_308_9 = 0.925

			if 0 < arg_305_1.time_ and arg_305_1.time_ <= var_308_8 + arg_308_0 then
				arg_305_1.talkMaxDuration = 0
				arg_305_1.dialogCg_.alpha = 1

				arg_305_1.dialog_:SetActive(true)
				SetActive(arg_305_1.leftNameGo_, true)

				arg_305_1.leftNameTxt_.text = arg_305_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_305_1.leftNameTxt_.transform)

				arg_305_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_305_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_305_1:RecordName(arg_305_1.leftNameTxt_.text)
				SetActive(arg_305_1.iconTrs_.gameObject, false)
				arg_305_1.callingController_:SetSelectedState("normal")

				local var_308_10 = arg_305_1:GetWordFromCfg(222072074)
				local var_308_11 = arg_305_1:FormatText(var_308_10.content)

				arg_305_1.text_.text = var_308_11

				LuaForUtil.ClearLinePrefixSymbol(arg_305_1.text_)

				local var_308_13 = 37 <= 0 and var_308_9 or var_308_9 * (utf8.len(var_308_11) / 37)

				if (37 <= 0 and var_308_9 or var_308_9 * (utf8.len(var_308_11) / 37)) > 0 and var_308_9 < var_308_13 then
					arg_305_1.talkMaxDuration = var_308_13

					if var_308_13 + var_308_8 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_13 + var_308_8
					end
				end

				arg_305_1.text_.text = var_308_11
				arg_305_1.typewritter.percent = 0

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222072", "222072074", "story_v_out_222072.awb") ~= 0 then
					local var_308_14 = manager.audio:GetVoiceLength("story_v_out_222072", "222072074", "story_v_out_222072.awb") / 1000

					if var_308_14 + var_308_8 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_14 + var_308_8
					end

					if var_308_10.prefab_name ~= "" and arg_305_1.actors_[var_308_10.prefab_name] ~= nil then
						local var_308_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_305_1.actors_[var_308_10.prefab_name].transform, "story_v_out_222072", "222072074", "story_v_out_222072.awb")

						arg_305_1:RecordAudio("222072074", var_308_15)
						arg_305_1:RecordAudio("222072074", var_308_15)
					else
						arg_305_1:AudioAction("play", "voice", "story_v_out_222072", "222072074", "story_v_out_222072.awb")
					end

					arg_305_1:RecordHistoryTalkVoice("story_v_out_222072", "222072074", "story_v_out_222072.awb")
				end

				arg_305_1:RecordContent(arg_305_1.text_.text)
			end

			local var_308_16 = math.max(var_308_9, arg_305_1.talkMaxDuration)

			if var_308_8 <= arg_305_1.time_ and arg_305_1.time_ < var_308_8 + var_308_16 then
				arg_305_1.typewritter.percent = (arg_305_1.time_ - var_308_8) / var_308_16

				arg_305_1.typewritter:SetDirty()
			end

			if arg_305_1.time_ >= var_308_8 + var_308_16 and arg_305_1.time_ < var_308_8 + var_308_16 + arg_308_0 then
				arg_305_1.typewritter.percent = 1

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(true)
			end
		end

		arg_305_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_305_1:InitPlayNodeList()
	end,
	Play222072075 = function(arg_309_0, arg_309_1)
		arg_309_1.time_ = 0
		arg_309_1.frameCnt_ = 0
		arg_309_1.state_ = "playing"
		arg_309_1.curTalkId_ = 222072075
		arg_309_1.duration_ = 12.93

		local var_309_0 = {
			ja = 12.933,
			ko = 7.7,
			zh = 7.7
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
				arg_309_0:Play222072076(arg_309_1)
			end
		end

		function arg_309_1.onSingleLineUpdate_(arg_312_0)
			if 0 < arg_309_1.time_ and arg_309_1.time_ <= 0 + arg_312_0 and not isNil(arg_309_1.actors_["1071ui_story"]) and arg_309_1.var_.characterEffect1071ui_story == nil then
				arg_309_1.var_.characterEffect1071ui_story = arg_309_1.actors_["1071ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_312_0 = 0.200000002980232

			if 0 <= arg_309_1.time_ and arg_309_1.time_ < 0 + var_312_0 and not isNil(arg_309_1.actors_["1071ui_story"]) then
				if arg_309_1.var_.characterEffect1071ui_story and not isNil(arg_309_1.actors_["1071ui_story"]) then
					arg_309_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_309_1.time_ >= 0 + var_312_0 and arg_309_1.time_ < 0 + var_312_0 + arg_312_0 and not isNil(arg_309_1.actors_["1071ui_story"]) and arg_309_1.var_.characterEffect1071ui_story then
				arg_309_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			if 0 < arg_309_1.time_ and arg_309_1.time_ <= 0 + arg_312_0 then
				arg_309_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action1_1")
			end

			local var_312_2 = arg_309_1.actors_["1070ui_story"]

			if 0 < arg_309_1.time_ and arg_309_1.time_ <= 0 + arg_312_0 and not isNil(var_312_2) and arg_309_1.var_.characterEffect1070ui_story == nil then
				arg_309_1.var_.characterEffect1070ui_story = var_312_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_312_3 = 0.200000002980232

			if 0 <= arg_309_1.time_ and arg_309_1.time_ < 0 + var_312_3 and not isNil(var_312_2) then
				if arg_309_1.var_.characterEffect1070ui_story and not isNil(var_312_2) then
					arg_309_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_309_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_309_1.time_ - 0) / var_312_3)
				end
			end

			if arg_309_1.time_ >= 0 + var_312_3 and arg_309_1.time_ < 0 + var_312_3 + arg_312_0 and not isNil(var_312_2) and arg_309_1.var_.characterEffect1070ui_story then
				arg_309_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_309_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_312_4 = 0
			local var_312_5 = 0.7

			if 0 < arg_309_1.time_ and arg_309_1.time_ <= var_312_4 + arg_312_0 then
				arg_309_1.talkMaxDuration = 0
				arg_309_1.dialogCg_.alpha = 1

				arg_309_1.dialog_:SetActive(true)
				SetActive(arg_309_1.leftNameGo_, true)

				arg_309_1.leftNameTxt_.text = arg_309_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_309_1.leftNameTxt_.transform)

				arg_309_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_309_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_309_1:RecordName(arg_309_1.leftNameTxt_.text)
				SetActive(arg_309_1.iconTrs_.gameObject, false)
				arg_309_1.callingController_:SetSelectedState("normal")

				local var_312_6 = arg_309_1:GetWordFromCfg(222072075)
				local var_312_7 = arg_309_1:FormatText(var_312_6.content)

				arg_309_1.text_.text = var_312_7

				LuaForUtil.ClearLinePrefixSymbol(arg_309_1.text_)

				local var_312_9 = 28 <= 0 and var_312_5 or var_312_5 * (utf8.len(var_312_7) / 28)

				if (28 <= 0 and var_312_5 or var_312_5 * (utf8.len(var_312_7) / 28)) > 0 and var_312_5 < var_312_9 then
					arg_309_1.talkMaxDuration = var_312_9

					if var_312_9 + var_312_4 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_9 + var_312_4
					end
				end

				arg_309_1.text_.text = var_312_7
				arg_309_1.typewritter.percent = 0

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222072", "222072075", "story_v_out_222072.awb") ~= 0 then
					local var_312_10 = manager.audio:GetVoiceLength("story_v_out_222072", "222072075", "story_v_out_222072.awb") / 1000

					if var_312_10 + var_312_4 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_10 + var_312_4
					end

					if var_312_6.prefab_name ~= "" and arg_309_1.actors_[var_312_6.prefab_name] ~= nil then
						local var_312_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_309_1.actors_[var_312_6.prefab_name].transform, "story_v_out_222072", "222072075", "story_v_out_222072.awb")

						arg_309_1:RecordAudio("222072075", var_312_11)
						arg_309_1:RecordAudio("222072075", var_312_11)
					else
						arg_309_1:AudioAction("play", "voice", "story_v_out_222072", "222072075", "story_v_out_222072.awb")
					end

					arg_309_1:RecordHistoryTalkVoice("story_v_out_222072", "222072075", "story_v_out_222072.awb")
				end

				arg_309_1:RecordContent(arg_309_1.text_.text)
			end

			local var_312_12 = math.max(var_312_5, arg_309_1.talkMaxDuration)

			if var_312_4 <= arg_309_1.time_ and arg_309_1.time_ < var_312_4 + var_312_12 then
				arg_309_1.typewritter.percent = (arg_309_1.time_ - var_312_4) / var_312_12

				arg_309_1.typewritter:SetDirty()
			end

			if arg_309_1.time_ >= var_312_4 + var_312_12 and arg_309_1.time_ < var_312_4 + var_312_12 + arg_312_0 then
				arg_309_1.typewritter.percent = 1

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(true)
			end
		end

		arg_309_1.nodeConfigList_ = {}

		arg_309_1:InitPlayNodeList()
	end,
	Play222072076 = function(arg_313_0, arg_313_1)
		arg_313_1.time_ = 0
		arg_313_1.frameCnt_ = 0
		arg_313_1.state_ = "playing"
		arg_313_1.curTalkId_ = 222072076
		arg_313_1.duration_ = 5

		SetActive(arg_313_1.tipsGo_, false)

		function arg_313_1.onSingleLineFinish_()
			arg_313_1.onSingleLineUpdate_ = nil
			arg_313_1.onSingleLineFinish_ = nil
			arg_313_1.state_ = "waiting"
		end

		function arg_313_1.playNext_(arg_315_0)
			if arg_315_0 == 1 then
				arg_313_0:Play222072077(arg_313_1)
			end
		end

		function arg_313_1.onSingleLineUpdate_(arg_316_0)
			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 then
				arg_313_1.var_.moveOldPos1071ui_story = arg_313_1.actors_["1071ui_story"].transform.localPosition
			end

			local var_316_0 = 0.001

			if 0 <= arg_313_1.time_ and arg_313_1.time_ < 0 + var_316_0 then
				arg_313_1.actors_["1071ui_story"].transform.localPosition = Vector3.Lerp(arg_313_1.var_.moveOldPos1071ui_story, Vector3.New(0, 100, 0), (arg_313_1.time_ - 0) / var_316_0)
				arg_313_1.actors_["1071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_313_1.actors_["1071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_313_1.actors_["1071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_313_1.actors_["1071ui_story"].transform.position).z)
				arg_313_1.actors_["1071ui_story"].transform.localEulerAngles.z = 0
				arg_313_1.actors_["1071ui_story"].transform.localEulerAngles.x = 0
				arg_313_1.actors_["1071ui_story"].transform.localEulerAngles = arg_313_1.actors_["1071ui_story"].transform.localEulerAngles
			end

			if arg_313_1.time_ >= 0 + var_316_0 and arg_313_1.time_ < 0 + var_316_0 + arg_316_0 then
				arg_313_1.actors_["1071ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_313_1.actors_["1071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_313_1.actors_["1071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_313_1.actors_["1071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_313_1.actors_["1071ui_story"].transform.position).z)
				arg_313_1.actors_["1071ui_story"].transform.localEulerAngles.z = 0
				arg_313_1.actors_["1071ui_story"].transform.localEulerAngles.x = 0
				arg_313_1.actors_["1071ui_story"].transform.localEulerAngles = arg_313_1.actors_["1071ui_story"].transform.localEulerAngles
			end

			local var_316_1 = arg_313_1.actors_["1071ui_story"]

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 and not isNil(var_316_1) and arg_313_1.var_.characterEffect1071ui_story == nil then
				arg_313_1.var_.characterEffect1071ui_story = var_316_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_316_2 = 0.200000002980232

			if 0 <= arg_313_1.time_ and arg_313_1.time_ < 0 + var_316_2 and not isNil(var_316_1) then
				if arg_313_1.var_.characterEffect1071ui_story and not isNil(var_316_1) then
					arg_313_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_313_1.var_.characterEffect1071ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_313_1.time_ - 0) / var_316_2)
				end
			end

			if arg_313_1.time_ >= 0 + var_316_2 and arg_313_1.time_ < 0 + var_316_2 + arg_316_0 and not isNil(var_316_1) and arg_313_1.var_.characterEffect1071ui_story then
				arg_313_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_313_1.var_.characterEffect1071ui_story.fillRatio = 0.5
			end

			local var_316_3 = arg_313_1.actors_["1070ui_story"].transform

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 then
				arg_313_1.var_.moveOldPos1070ui_story = var_316_3.localPosition
			end

			local var_316_4 = 0.001

			if 0 <= arg_313_1.time_ and arg_313_1.time_ < 0 + var_316_4 then
				var_316_3.localPosition = Vector3.Lerp(arg_313_1.var_.moveOldPos1070ui_story, Vector3.New(0, 100, 0), (arg_313_1.time_ - 0) / var_316_4)
				var_316_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_316_3.position).x, (manager.ui.mainCamera.transform.position - var_316_3.position).y, (manager.ui.mainCamera.transform.position - var_316_3.position).z)
				var_316_3.localEulerAngles.z = 0
				var_316_3.localEulerAngles.x = 0
				var_316_3.localEulerAngles = var_316_3.localEulerAngles
			end

			if arg_313_1.time_ >= 0 + var_316_4 and arg_313_1.time_ < 0 + var_316_4 + arg_316_0 then
				var_316_3.localPosition = Vector3.New(0, 100, 0)
				var_316_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_316_3.position).x, (manager.ui.mainCamera.transform.position - var_316_3.position).y, (manager.ui.mainCamera.transform.position - var_316_3.position).z)
				var_316_3.localEulerAngles.z = 0
				var_316_3.localEulerAngles.x = 0
				var_316_3.localEulerAngles = var_316_3.localEulerAngles
			end

			local var_316_5 = arg_313_1.actors_["1070ui_story"]

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 and not isNil(var_316_5) and arg_313_1.var_.characterEffect1070ui_story == nil then
				arg_313_1.var_.characterEffect1070ui_story = var_316_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_316_6 = 0.200000002980232

			if 0 <= arg_313_1.time_ and arg_313_1.time_ < 0 + var_316_6 and not isNil(var_316_5) then
				if arg_313_1.var_.characterEffect1070ui_story and not isNil(var_316_5) then
					arg_313_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_313_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_313_1.time_ - 0) / var_316_6)
				end
			end

			if arg_313_1.time_ >= 0 + var_316_6 and arg_313_1.time_ < 0 + var_316_6 + arg_316_0 and not isNil(var_316_5) and arg_313_1.var_.characterEffect1070ui_story then
				arg_313_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_313_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_316_7 = 0
			local var_316_8 = 1.125

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= var_316_7 + arg_316_0 then
				arg_313_1.talkMaxDuration = 0
				arg_313_1.dialogCg_.alpha = 1

				arg_313_1.dialog_:SetActive(true)
				SetActive(arg_313_1.leftNameGo_, false)

				arg_313_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_313_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_313_1:RecordName(arg_313_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_313_1.iconTrs_.gameObject, false)
				arg_313_1.callingController_:SetSelectedState("normal")

				local var_316_9 = arg_313_1:FormatText(arg_313_1:GetWordFromCfg(222072076).content)

				arg_313_1.text_.text = var_316_9

				LuaForUtil.ClearLinePrefixSymbol(arg_313_1.text_)

				local var_316_11 = 45 <= 0 and var_316_8 or var_316_8 * (utf8.len(var_316_9) / 45)

				if (45 <= 0 and var_316_8 or var_316_8 * (utf8.len(var_316_9) / 45)) > 0 and var_316_8 < var_316_11 then
					arg_313_1.talkMaxDuration = var_316_11

					if var_316_11 + var_316_7 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_11 + var_316_7
					end
				end

				arg_313_1.text_.text = var_316_9
				arg_313_1.typewritter.percent = 0

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(false)
				arg_313_1:RecordContent(arg_313_1.text_.text)
			end

			local var_316_12 = math.max(var_316_8, arg_313_1.talkMaxDuration)

			if var_316_7 <= arg_313_1.time_ and arg_313_1.time_ < var_316_7 + var_316_12 then
				arg_313_1.typewritter.percent = (arg_313_1.time_ - var_316_7) / var_316_12

				arg_313_1.typewritter:SetDirty()
			end

			if arg_313_1.time_ >= var_316_7 + var_316_12 and arg_313_1.time_ < var_316_7 + var_316_12 + arg_316_0 then
				arg_313_1.typewritter.percent = 1

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(true)
			end
		end

		arg_313_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1070ui_story",
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
	Play222072077 = function(arg_317_0, arg_317_1)
		arg_317_1.time_ = 0
		arg_317_1.frameCnt_ = 0
		arg_317_1.state_ = "playing"
		arg_317_1.curTalkId_ = 222072077
		arg_317_1.duration_ = 8.17

		local var_317_0 = {
			ja = 8.166,
			ko = 7.166,
			zh = 7.133
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
				arg_317_0:Play222072078(arg_317_1)
			end
		end

		function arg_317_1.onSingleLineUpdate_(arg_320_0)
			local var_320_0 = 0.8

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 then
				arg_317_1.talkMaxDuration = 0
				arg_317_1.dialogCg_.alpha = 1

				arg_317_1.dialog_:SetActive(true)
				SetActive(arg_317_1.leftNameGo_, true)

				arg_317_1.leftNameTxt_.text = arg_317_1:FormatText(StoryNameCfg[473].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_317_1.leftNameTxt_.transform)

				arg_317_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_317_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_317_1:RecordName(arg_317_1.leftNameTxt_.text)
				SetActive(arg_317_1.iconTrs_.gameObject, true)
				arg_317_1.iconController_:SetSelectedState("hero")

				arg_317_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_boffinm")

				arg_317_1.callingController_:SetSelectedState("normal")

				arg_317_1.keyicon_.color = Color.New(1, 1, 1)
				arg_317_1.icon_.color = Color.New(1, 1, 1)

				local var_320_1 = arg_317_1:GetWordFromCfg(222072077)
				local var_320_2 = arg_317_1:FormatText(var_320_1.content)

				arg_317_1.text_.text = var_320_2

				LuaForUtil.ClearLinePrefixSymbol(arg_317_1.text_)

				local var_320_4 = 32 <= 0 and var_320_0 or var_320_0 * (utf8.len(var_320_2) / 32)

				if (32 <= 0 and var_320_0 or var_320_0 * (utf8.len(var_320_2) / 32)) > 0 and var_320_0 < var_320_4 then
					arg_317_1.talkMaxDuration = var_320_4

					if var_320_4 + 0 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_4 + 0
					end
				end

				arg_317_1.text_.text = var_320_2
				arg_317_1.typewritter.percent = 0

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222072", "222072077", "story_v_out_222072.awb") ~= 0 then
					local var_320_5 = manager.audio:GetVoiceLength("story_v_out_222072", "222072077", "story_v_out_222072.awb") / 1000

					if var_320_5 + 0 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_5 + 0
					end

					if var_320_1.prefab_name ~= "" and arg_317_1.actors_[var_320_1.prefab_name] ~= nil then
						local var_320_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_317_1.actors_[var_320_1.prefab_name].transform, "story_v_out_222072", "222072077", "story_v_out_222072.awb")

						arg_317_1:RecordAudio("222072077", var_320_6)
						arg_317_1:RecordAudio("222072077", var_320_6)
					else
						arg_317_1:AudioAction("play", "voice", "story_v_out_222072", "222072077", "story_v_out_222072.awb")
					end

					arg_317_1:RecordHistoryTalkVoice("story_v_out_222072", "222072077", "story_v_out_222072.awb")
				end

				arg_317_1:RecordContent(arg_317_1.text_.text)
			end

			local var_320_7 = math.max(var_320_0, arg_317_1.talkMaxDuration)

			if 0 <= arg_317_1.time_ and arg_317_1.time_ < 0 + var_320_7 then
				arg_317_1.typewritter.percent = (arg_317_1.time_ - 0) / var_320_7

				arg_317_1.typewritter:SetDirty()
			end

			if arg_317_1.time_ >= 0 + var_320_7 and arg_317_1.time_ < 0 + var_320_7 + arg_320_0 then
				arg_317_1.typewritter.percent = 1

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(true)
			end
		end

		arg_317_1.nodeConfigList_ = {}

		arg_317_1:InitPlayNodeList()
	end,
	Play222072078 = function(arg_321_0, arg_321_1)
		arg_321_1.time_ = 0
		arg_321_1.frameCnt_ = 0
		arg_321_1.state_ = "playing"
		arg_321_1.curTalkId_ = 222072078
		arg_321_1.duration_ = 5.23

		local var_321_0 = {
			ja = 4.4,
			ko = 5.233,
			zh = 5.2
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
			arg_321_1.auto_ = false
		end

		function arg_321_1.playNext_(arg_323_0)
			arg_321_1.onStoryFinished_()
		end

		function arg_321_1.onSingleLineUpdate_(arg_324_0)
			local var_324_0 = 0.75

			if 0 < arg_321_1.time_ and arg_321_1.time_ <= 0 + arg_324_0 then
				arg_321_1.talkMaxDuration = 0
				arg_321_1.dialogCg_.alpha = 1

				arg_321_1.dialog_:SetActive(true)
				SetActive(arg_321_1.leftNameGo_, true)

				arg_321_1.leftNameTxt_.text = arg_321_1:FormatText(StoryNameCfg[473].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_321_1.leftNameTxt_.transform)

				arg_321_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_321_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_321_1:RecordName(arg_321_1.leftNameTxt_.text)
				SetActive(arg_321_1.iconTrs_.gameObject, true)
				arg_321_1.iconController_:SetSelectedState("hero")

				arg_321_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_boffinm")

				arg_321_1.callingController_:SetSelectedState("normal")

				arg_321_1.keyicon_.color = Color.New(1, 1, 1)
				arg_321_1.icon_.color = Color.New(1, 1, 1)

				local var_324_1 = arg_321_1:GetWordFromCfg(222072078)
				local var_324_2 = arg_321_1:FormatText(var_324_1.content)

				arg_321_1.text_.text = var_324_2

				LuaForUtil.ClearLinePrefixSymbol(arg_321_1.text_)

				local var_324_4 = 30 <= 0 and var_324_0 or var_324_0 * (utf8.len(var_324_2) / 30)

				if (30 <= 0 and var_324_0 or var_324_0 * (utf8.len(var_324_2) / 30)) > 0 and var_324_0 < var_324_4 then
					arg_321_1.talkMaxDuration = var_324_4

					if var_324_4 + 0 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_4 + 0
					end
				end

				arg_321_1.text_.text = var_324_2
				arg_321_1.typewritter.percent = 0

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222072", "222072078", "story_v_out_222072.awb") ~= 0 then
					local var_324_5 = manager.audio:GetVoiceLength("story_v_out_222072", "222072078", "story_v_out_222072.awb") / 1000

					if var_324_5 + 0 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_5 + 0
					end

					if var_324_1.prefab_name ~= "" and arg_321_1.actors_[var_324_1.prefab_name] ~= nil then
						local var_324_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_321_1.actors_[var_324_1.prefab_name].transform, "story_v_out_222072", "222072078", "story_v_out_222072.awb")

						arg_321_1:RecordAudio("222072078", var_324_6)
						arg_321_1:RecordAudio("222072078", var_324_6)
					else
						arg_321_1:AudioAction("play", "voice", "story_v_out_222072", "222072078", "story_v_out_222072.awb")
					end

					arg_321_1:RecordHistoryTalkVoice("story_v_out_222072", "222072078", "story_v_out_222072.awb")
				end

				arg_321_1:RecordContent(arg_321_1.text_.text)
			end

			local var_324_7 = math.max(var_324_0, arg_321_1.talkMaxDuration)

			if 0 <= arg_321_1.time_ and arg_321_1.time_ < 0 + var_324_7 then
				arg_321_1.typewritter.percent = (arg_321_1.time_ - 0) / var_324_7

				arg_321_1.typewritter:SetDirty()
			end

			if arg_321_1.time_ >= 0 + var_324_7 and arg_321_1.time_ < 0 + var_324_7 + arg_324_0 then
				arg_321_1.typewritter.percent = 1

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(true)
			end
		end

		arg_321_1.nodeConfigList_ = {}

		arg_321_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST52",
		"TextureConfig/Background/J03g",
		"TextureConfig/Background/ST39",
		"TextureConfig/Background/ST47"
	},
	voices = {
		"story_v_out_222072.awb"
	}
}
