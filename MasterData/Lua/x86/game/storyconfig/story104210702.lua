return {
	Play421072001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 421072001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play421072002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.D10 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "D10")
				var_4_0.name = "D10"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.D10 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.D10

				arg_1_1.bgs_.D10.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "D10" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_4 = 2

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_4 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			if arg_1_1.time_ >= var_4_4 + 0.133333333333333 and arg_1_1.time_ < var_4_4 + 0.133333333333333 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			local var_4_5 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_5 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_6 = 2

			if var_4_5 <= arg_1_1.time_ and arg_1_1.time_ < var_4_5 + var_4_6 then
				local var_4_7 = Color.New(0, 0, 0)

				var_4_7.a = Mathf.Lerp(1, 0, (arg_1_1.time_ - var_4_5) / var_4_6)
				arg_1_1.mask_.color = var_4_7
			end

			if arg_1_1.time_ >= var_4_5 + var_4_6 and arg_1_1.time_ < var_4_5 + var_4_6 + arg_4_0 then
				local var_4_8 = Color.New(0, 0, 0)

				arg_1_1.mask_.enabled = false
				var_4_8.a = 0
				arg_1_1.mask_.color = var_4_8
			end

			if 0.1 < arg_1_1.time_ and arg_1_1.time_ <= 0.1 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_140", "se_story_140_amb_lab", "")
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_12 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_12 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_12

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_12
						arg_1_1.bgmTxt2_.text = var_4_12
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

			if 0.433333333333333 < arg_1_1.time_ and arg_1_1.time_ <= 0.433333333333333 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_4_3_story_talk", "bgm_activity_4_3_story_talk", "bgm_activity_4_3_story_talk.awb")

				local var_4_15 = manager.audio:GetAudioName("bgm_activity_4_3_story_talk", "bgm_activity_4_3_story_talk")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_15 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_15

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_15
						arg_1_1.bgmTxt2_.text = var_4_15
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

			local var_4_16 = 2
			local var_4_17 = 0.225

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_16 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_18 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_18:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_19 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(421072001).content)

				arg_1_1.text_.text = var_4_19

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_21 = 9 <= 0 and var_4_17 or var_4_17 * (utf8.len(var_4_19) / 9)

				if (9 <= 0 and var_4_17 or var_4_17 * (utf8.len(var_4_19) / 9)) > 0 and var_4_17 < var_4_21 then
					arg_1_1.talkMaxDuration = var_4_21
					var_4_16 = var_4_16 + 0.3

					if var_4_21 + var_4_16 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_21 + var_4_16
					end
				end

				arg_1_1.text_.text = var_4_19
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_22 = var_4_16 + 0.3
			local var_4_23 = math.max(var_4_17, arg_1_1.talkMaxDuration)

			if var_4_16 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_22 + var_4_23 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_22) / var_4_23

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_22 + var_4_23 and arg_1_1.time_ < var_4_22 + var_4_23 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play421072002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 421072002
		arg_9_1.duration_ = 9.13

		local var_9_0 = {
			zh = 6.533,
			ja = 9.133
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
				arg_9_0:Play421072003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			if arg_9_1.actors_["10145ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10145ui_story"))) then
				local var_12_0 = Object.Instantiate(Asset.Load("Char/" .. "10145ui_story"), arg_9_1.stage_.transform)

				var_12_0.name = "10145ui_story"
				var_12_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_9_1.actors_["10145ui_story"] = var_12_0

				local var_12_1 = var_12_0:GetComponentInChildren(typeof(CharacterEffect))

				var_12_1.enabled = true

				local var_12_2 = GameObjectTools.GetOrAddComponent(var_12_0, typeof(DynamicBoneHelper))

				if var_12_2 then
					var_12_2:EnableDynamicBone(false)
				end

				arg_9_1:ShowWeapon(var_12_1.transform, false)

				arg_9_1.var_["10145ui_story" .. "Animator"] = var_12_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_9_1.var_["10145ui_story" .. "Animator"].applyRootMotion = true
				arg_9_1.var_["10145ui_story" .. "LipSync"] = var_12_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_12_3 = arg_9_1.actors_["10145ui_story"].transform

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.var_.moveOldPos10145ui_story = var_12_3.localPosition
			end

			local var_12_4 = 0.001

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_4 then
				var_12_3.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos10145ui_story, Vector3.New(0, -1, -6.2), (arg_9_1.time_ - 0) / var_12_4)
				var_12_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_12_3.position).x, (manager.ui.mainCamera.transform.position - var_12_3.position).y, (manager.ui.mainCamera.transform.position - var_12_3.position).z)
				var_12_3.localEulerAngles.z = 0
				var_12_3.localEulerAngles.x = 0
				var_12_3.localEulerAngles = var_12_3.localEulerAngles
			end

			if arg_9_1.time_ >= 0 + var_12_4 and arg_9_1.time_ < 0 + var_12_4 + arg_12_0 then
				var_12_3.localPosition = Vector3.New(0, -1, -6.2)
				var_12_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_12_3.position).x, (manager.ui.mainCamera.transform.position - var_12_3.position).y, (manager.ui.mainCamera.transform.position - var_12_3.position).z)
				var_12_3.localEulerAngles.z = 0
				var_12_3.localEulerAngles.x = 0
				var_12_3.localEulerAngles = var_12_3.localEulerAngles
			end

			local var_12_5 = arg_9_1.actors_["10145ui_story"]

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 and not isNil(var_12_5) and arg_9_1.var_.characterEffect10145ui_story == nil then
				arg_9_1.var_.characterEffect10145ui_story = var_12_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_6 = 0.200000002980232

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_6 and not isNil(var_12_5) then
				if arg_9_1.var_.characterEffect10145ui_story and not isNil(var_12_5) then
					arg_9_1.var_.characterEffect10145ui_story.fillFlat = false
				end
			end

			if arg_9_1.time_ >= 0 + var_12_6 and arg_9_1.time_ < 0 + var_12_6 + arg_12_0 and not isNil(var_12_5) and arg_9_1.var_.characterEffect10145ui_story then
				arg_9_1.var_.characterEffect10145ui_story.fillFlat = false
			end

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/story10145/story10145action/10145action9_1")
			end

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_12_8 = 0
			local var_12_9 = 0.875

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_8 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				arg_9_1.leftNameTxt_.text = arg_9_1:FormatText(StoryNameCfg[1308].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_10 = arg_9_1:GetWordFromCfg(421072002)
				local var_12_11 = arg_9_1:FormatText(var_12_10.content)

				arg_9_1.text_.text = var_12_11

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_13 = 35 <= 0 and var_12_9 or var_12_9 * (utf8.len(var_12_11) / 35)

				if (35 <= 0 and var_12_9 or var_12_9 * (utf8.len(var_12_11) / 35)) > 0 and var_12_9 < var_12_13 then
					arg_9_1.talkMaxDuration = var_12_13

					if var_12_13 + var_12_8 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_13 + var_12_8
					end
				end

				arg_9_1.text_.text = var_12_11
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421072", "421072002", "story_v_out_421072.awb") ~= 0 then
					local var_12_14 = manager.audio:GetVoiceLength("story_v_out_421072", "421072002", "story_v_out_421072.awb") / 1000

					if var_12_14 + var_12_8 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_14 + var_12_8
					end

					if var_12_10.prefab_name ~= "" and arg_9_1.actors_[var_12_10.prefab_name] ~= nil then
						local var_12_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_10.prefab_name].transform, "story_v_out_421072", "421072002", "story_v_out_421072.awb")

						arg_9_1:RecordAudio("421072002", var_12_15)
						arg_9_1:RecordAudio("421072002", var_12_15)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_421072", "421072002", "story_v_out_421072.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_421072", "421072002", "story_v_out_421072.awb")
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
				actorName = "10145ui_story",
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
	Play421072003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 421072003
		arg_13_1.duration_ = 7.83

		local var_13_0 = {
			zh = 5.3,
			ja = 7.833
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
				arg_13_0:Play421072004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			if arg_13_1.actors_["1047ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1047ui_story"))) then
				local var_16_0 = Object.Instantiate(Asset.Load("Char/" .. "1047ui_story"), arg_13_1.stage_.transform)

				var_16_0.name = "1047ui_story"
				var_16_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_13_1.actors_["1047ui_story"] = var_16_0

				local var_16_1 = var_16_0:GetComponentInChildren(typeof(CharacterEffect))

				var_16_1.enabled = true

				local var_16_2 = GameObjectTools.GetOrAddComponent(var_16_0, typeof(DynamicBoneHelper))

				if var_16_2 then
					var_16_2:EnableDynamicBone(false)
				end

				arg_13_1:ShowWeapon(var_16_1.transform, false)

				arg_13_1.var_["1047ui_story" .. "Animator"] = var_16_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_13_1.var_["1047ui_story" .. "Animator"].applyRootMotion = true
				arg_13_1.var_["1047ui_story" .. "LipSync"] = var_16_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_16_3 = arg_13_1.actors_["1047ui_story"].transform

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.var_.moveOldPos1047ui_story = var_16_3.localPosition

				arg_13_1:ShowWeapon(arg_13_1.var_["1047ui_story" .. "Animator"].transform, false)
			end

			local var_16_4 = 0.001

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_4 then
				var_16_3.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos1047ui_story, Vector3.New(0.74, -1.13, -6.2), (arg_13_1.time_ - 0) / var_16_4)
				var_16_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_16_3.position).x, (manager.ui.mainCamera.transform.position - var_16_3.position).y, (manager.ui.mainCamera.transform.position - var_16_3.position).z)
				var_16_3.localEulerAngles.z = 0
				var_16_3.localEulerAngles.x = 0
				var_16_3.localEulerAngles = var_16_3.localEulerAngles
			end

			if arg_13_1.time_ >= 0 + var_16_4 and arg_13_1.time_ < 0 + var_16_4 + arg_16_0 then
				var_16_3.localPosition = Vector3.New(0.74, -1.13, -6.2)
				var_16_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_16_3.position).x, (manager.ui.mainCamera.transform.position - var_16_3.position).y, (manager.ui.mainCamera.transform.position - var_16_3.position).z)
				var_16_3.localEulerAngles.z = 0
				var_16_3.localEulerAngles.x = 0
				var_16_3.localEulerAngles = var_16_3.localEulerAngles
			end

			local var_16_5 = arg_13_1.actors_["10145ui_story"].transform

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.var_.moveOldPos10145ui_story = var_16_5.localPosition
			end

			local var_16_6 = 0.001

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_6 then
				var_16_5.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos10145ui_story, Vector3.New(-0.65, -1, -6.2), (arg_13_1.time_ - 0) / var_16_6)
				var_16_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_16_5.position).x, (manager.ui.mainCamera.transform.position - var_16_5.position).y, (manager.ui.mainCamera.transform.position - var_16_5.position).z)
				var_16_5.localEulerAngles.z = 0
				var_16_5.localEulerAngles.x = 0
				var_16_5.localEulerAngles = var_16_5.localEulerAngles
			end

			if arg_13_1.time_ >= 0 + var_16_6 and arg_13_1.time_ < 0 + var_16_6 + arg_16_0 then
				var_16_5.localPosition = Vector3.New(-0.65, -1, -6.2)
				var_16_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_16_5.position).x, (manager.ui.mainCamera.transform.position - var_16_5.position).y, (manager.ui.mainCamera.transform.position - var_16_5.position).z)
				var_16_5.localEulerAngles.z = 0
				var_16_5.localEulerAngles.x = 0
				var_16_5.localEulerAngles = var_16_5.localEulerAngles
			end

			local var_16_7 = arg_13_1.actors_["1047ui_story"]

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(var_16_7) and arg_13_1.var_.characterEffect1047ui_story == nil then
				arg_13_1.var_.characterEffect1047ui_story = var_16_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_8 = 0.200000002980232

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_8 and not isNil(var_16_7) then
				if arg_13_1.var_.characterEffect1047ui_story and not isNil(var_16_7) then
					arg_13_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_13_1.time_ >= 0 + var_16_8 and arg_13_1.time_ < 0 + var_16_8 + arg_16_0 and not isNil(var_16_7) and arg_13_1.var_.characterEffect1047ui_story then
				arg_13_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_16_10 = arg_13_1.actors_["10145ui_story"]

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(var_16_10) and arg_13_1.var_.characterEffect10145ui_story == nil then
				arg_13_1.var_.characterEffect10145ui_story = var_16_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_11 = 0.200000002980232

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_11 and not isNil(var_16_10) then
				if arg_13_1.var_.characterEffect10145ui_story and not isNil(var_16_10) then
					arg_13_1.var_.characterEffect10145ui_story.fillFlat = true
					arg_13_1.var_.characterEffect10145ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_13_1.time_ - 0) / var_16_11)
				end
			end

			if arg_13_1.time_ >= 0 + var_16_11 and arg_13_1.time_ < 0 + var_16_11 + arg_16_0 and not isNil(var_16_10) and arg_13_1.var_.characterEffect10145ui_story then
				arg_13_1.var_.characterEffect10145ui_story.fillFlat = true
				arg_13_1.var_.characterEffect10145ui_story.fillRatio = 0.5
			end

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_16_12 = 0
			local var_16_13 = 0.775

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_12 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_14 = arg_13_1:GetWordFromCfg(421072003)
				local var_16_15 = arg_13_1:FormatText(var_16_14.content)

				arg_13_1.text_.text = var_16_15

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_17 = 31 <= 0 and var_16_13 or var_16_13 * (utf8.len(var_16_15) / 31)

				if (31 <= 0 and var_16_13 or var_16_13 * (utf8.len(var_16_15) / 31)) > 0 and var_16_13 < var_16_17 then
					arg_13_1.talkMaxDuration = var_16_17

					if var_16_17 + var_16_12 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_17 + var_16_12
					end
				end

				arg_13_1.text_.text = var_16_15
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421072", "421072003", "story_v_out_421072.awb") ~= 0 then
					local var_16_18 = manager.audio:GetVoiceLength("story_v_out_421072", "421072003", "story_v_out_421072.awb") / 1000

					if var_16_18 + var_16_12 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_18 + var_16_12
					end

					if var_16_14.prefab_name ~= "" and arg_13_1.actors_[var_16_14.prefab_name] ~= nil then
						local var_16_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_14.prefab_name].transform, "story_v_out_421072", "421072003", "story_v_out_421072.awb")

						arg_13_1:RecordAudio("421072003", var_16_19)
						arg_13_1:RecordAudio("421072003", var_16_19)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_421072", "421072003", "story_v_out_421072.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_421072", "421072003", "story_v_out_421072.awb")
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
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10145ui_story",
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
	Play421072004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 421072004
		arg_17_1.duration_ = 2.33

		local var_17_0 = {
			zh = 1.999999999999,
			ja = 2.333
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
				arg_17_0:Play421072005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.var_.moveOldPos10145ui_story = arg_17_1.actors_["10145ui_story"].transform.localPosition
			end

			local var_20_0 = 0.001

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_0 then
				arg_17_1.actors_["10145ui_story"].transform.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos10145ui_story, Vector3.New(-0.65, -1, -6.2), (arg_17_1.time_ - 0) / var_20_0)
				arg_17_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_17_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["10145ui_story"].transform.position).z)
				arg_17_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_17_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_17_1.actors_["10145ui_story"].transform.localEulerAngles = arg_17_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			if arg_17_1.time_ >= 0 + var_20_0 and arg_17_1.time_ < 0 + var_20_0 + arg_20_0 then
				arg_17_1.actors_["10145ui_story"].transform.localPosition = Vector3.New(-0.65, -1, -6.2)
				arg_17_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_17_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["10145ui_story"].transform.position).z)
				arg_17_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_17_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_17_1.actors_["10145ui_story"].transform.localEulerAngles = arg_17_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			local var_20_1 = arg_17_1.actors_["10145ui_story"]

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(var_20_1) and arg_17_1.var_.characterEffect10145ui_story == nil then
				arg_17_1.var_.characterEffect10145ui_story = var_20_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_2 = 0.200000002980232

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_2 and not isNil(var_20_1) then
				if arg_17_1.var_.characterEffect10145ui_story and not isNil(var_20_1) then
					arg_17_1.var_.characterEffect10145ui_story.fillFlat = false
				end
			end

			if arg_17_1.time_ >= 0 + var_20_2 and arg_17_1.time_ < 0 + var_20_2 + arg_20_0 and not isNil(var_20_1) and arg_17_1.var_.characterEffect10145ui_story then
				arg_17_1.var_.characterEffect10145ui_story.fillFlat = false
			end

			local var_20_4 = arg_17_1.actors_["1047ui_story"]

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(var_20_4) and arg_17_1.var_.characterEffect1047ui_story == nil then
				arg_17_1.var_.characterEffect1047ui_story = var_20_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_5 = 0.200000002980232

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_5 and not isNil(var_20_4) then
				if arg_17_1.var_.characterEffect1047ui_story and not isNil(var_20_4) then
					arg_17_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_17_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_17_1.time_ - 0) / var_20_5)
				end
			end

			if arg_17_1.time_ >= 0 + var_20_5 and arg_17_1.time_ < 0 + var_20_5 + arg_20_0 and not isNil(var_20_4) and arg_17_1.var_.characterEffect1047ui_story then
				arg_17_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_17_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/story10145/story10145action/10145action9_2")
			end

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			local var_20_6 = 0
			local var_20_7 = 0.125

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_6 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[1308].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_8 = arg_17_1:GetWordFromCfg(421072004)
				local var_20_9 = arg_17_1:FormatText(var_20_8.content)

				arg_17_1.text_.text = var_20_9

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_11 = 5 <= 0 and var_20_7 or var_20_7 * (utf8.len(var_20_9) / 5)

				if (5 <= 0 and var_20_7 or var_20_7 * (utf8.len(var_20_9) / 5)) > 0 and var_20_7 < var_20_11 then
					arg_17_1.talkMaxDuration = var_20_11

					if var_20_11 + var_20_6 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_11 + var_20_6
					end
				end

				arg_17_1.text_.text = var_20_9
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421072", "421072004", "story_v_out_421072.awb") ~= 0 then
					local var_20_12 = manager.audio:GetVoiceLength("story_v_out_421072", "421072004", "story_v_out_421072.awb") / 1000

					if var_20_12 + var_20_6 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_12 + var_20_6
					end

					if var_20_8.prefab_name ~= "" and arg_17_1.actors_[var_20_8.prefab_name] ~= nil then
						local var_20_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_8.prefab_name].transform, "story_v_out_421072", "421072004", "story_v_out_421072.awb")

						arg_17_1:RecordAudio("421072004", var_20_13)
						arg_17_1:RecordAudio("421072004", var_20_13)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_421072", "421072004", "story_v_out_421072.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_421072", "421072004", "story_v_out_421072.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_14 = math.max(var_20_7, arg_17_1.talkMaxDuration)

			if var_20_6 <= arg_17_1.time_ and arg_17_1.time_ < var_20_6 + var_20_14 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_6) / var_20_14

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_6 + var_20_14 and arg_17_1.time_ < var_20_6 + var_20_14 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10145ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_17_1:InitPlayNodeList()
	end,
	Play421072005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 421072005
		arg_21_1.duration_ = 5.6

		local var_21_0 = {
			zh = 3.633,
			ja = 5.6
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
				arg_21_0:Play421072006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.var_.moveOldPos1047ui_story = arg_21_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_24_0 = 0.001

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_0 then
				arg_21_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos1047ui_story, Vector3.New(0.74, -1.13, -6.2), (arg_21_1.time_ - 0) / var_24_0)
				arg_21_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_21_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["1047ui_story"].transform.position).z)
				arg_21_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_21_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_21_1.actors_["1047ui_story"].transform.localEulerAngles = arg_21_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_21_1.time_ >= 0 + var_24_0 and arg_21_1.time_ < 0 + var_24_0 + arg_24_0 then
				arg_21_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0.74, -1.13, -6.2)
				arg_21_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_21_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["1047ui_story"].transform.position).z)
				arg_21_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_21_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_21_1.actors_["1047ui_story"].transform.localEulerAngles = arg_21_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_24_1 = arg_21_1.actors_["1047ui_story"]

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(var_24_1) and arg_21_1.var_.characterEffect1047ui_story == nil then
				arg_21_1.var_.characterEffect1047ui_story = var_24_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_2 = 0.200000002980232

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_2 and not isNil(var_24_1) then
				if arg_21_1.var_.characterEffect1047ui_story and not isNil(var_24_1) then
					arg_21_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_21_1.time_ >= 0 + var_24_2 and arg_21_1.time_ < 0 + var_24_2 + arg_24_0 and not isNil(var_24_1) and arg_21_1.var_.characterEffect1047ui_story then
				arg_21_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_24_4 = arg_21_1.actors_["10145ui_story"]

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(var_24_4) and arg_21_1.var_.characterEffect10145ui_story == nil then
				arg_21_1.var_.characterEffect10145ui_story = var_24_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_5 = 0.200000002980232

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_5 and not isNil(var_24_4) then
				if arg_21_1.var_.characterEffect10145ui_story and not isNil(var_24_4) then
					arg_21_1.var_.characterEffect10145ui_story.fillFlat = true
					arg_21_1.var_.characterEffect10145ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_21_1.time_ - 0) / var_24_5)
				end
			end

			if arg_21_1.time_ >= 0 + var_24_5 and arg_21_1.time_ < 0 + var_24_5 + arg_24_0 and not isNil(var_24_4) and arg_21_1.var_.characterEffect10145ui_story then
				arg_21_1.var_.characterEffect10145ui_story.fillFlat = true
				arg_21_1.var_.characterEffect10145ui_story.fillRatio = 0.5
			end

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action6_1")
			end

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_24_6 = 0
			local var_24_7 = 0.375

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_6 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_8 = arg_21_1:GetWordFromCfg(421072005)
				local var_24_9 = arg_21_1:FormatText(var_24_8.content)

				arg_21_1.text_.text = var_24_9

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_11 = 15 <= 0 and var_24_7 or var_24_7 * (utf8.len(var_24_9) / 15)

				if (15 <= 0 and var_24_7 or var_24_7 * (utf8.len(var_24_9) / 15)) > 0 and var_24_7 < var_24_11 then
					arg_21_1.talkMaxDuration = var_24_11

					if var_24_11 + var_24_6 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_11 + var_24_6
					end
				end

				arg_21_1.text_.text = var_24_9
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421072", "421072005", "story_v_out_421072.awb") ~= 0 then
					local var_24_12 = manager.audio:GetVoiceLength("story_v_out_421072", "421072005", "story_v_out_421072.awb") / 1000

					if var_24_12 + var_24_6 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_12 + var_24_6
					end

					if var_24_8.prefab_name ~= "" and arg_21_1.actors_[var_24_8.prefab_name] ~= nil then
						local var_24_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_8.prefab_name].transform, "story_v_out_421072", "421072005", "story_v_out_421072.awb")

						arg_21_1:RecordAudio("421072005", var_24_13)
						arg_21_1:RecordAudio("421072005", var_24_13)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_421072", "421072005", "story_v_out_421072.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_421072", "421072005", "story_v_out_421072.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_14 = math.max(var_24_7, arg_21_1.talkMaxDuration)

			if var_24_6 <= arg_21_1.time_ and arg_21_1.time_ < var_24_6 + var_24_14 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_6) / var_24_14

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_6 + var_24_14 and arg_21_1.time_ < var_24_6 + var_24_14 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
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
	Play421072006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 421072006
		arg_25_1.duration_ = 4.3

		local var_25_0 = {
			zh = 3.3,
			ja = 4.3
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
				arg_25_0:Play421072007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.var_.moveOldPos1047ui_story = arg_25_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_28_0 = 0.001

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_0 then
				arg_25_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos1047ui_story, Vector3.New(0, 100, 0), (arg_25_1.time_ - 0) / var_28_0)
				arg_25_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_25_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["1047ui_story"].transform.position).z)
				arg_25_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_25_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_25_1.actors_["1047ui_story"].transform.localEulerAngles = arg_25_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_25_1.time_ >= 0 + var_28_0 and arg_25_1.time_ < 0 + var_28_0 + arg_28_0 then
				arg_25_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_25_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_25_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["1047ui_story"].transform.position).z)
				arg_25_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_25_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_25_1.actors_["1047ui_story"].transform.localEulerAngles = arg_25_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_28_1 = arg_25_1.actors_["10145ui_story"].transform

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.var_.moveOldPos10145ui_story = var_28_1.localPosition
			end

			local var_28_2 = 0.001

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_2 then
				var_28_1.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos10145ui_story, Vector3.New(0, 100, 0), (arg_25_1.time_ - 0) / var_28_2)
				var_28_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_28_1.position).x, (manager.ui.mainCamera.transform.position - var_28_1.position).y, (manager.ui.mainCamera.transform.position - var_28_1.position).z)
				var_28_1.localEulerAngles.z = 0
				var_28_1.localEulerAngles.x = 0
				var_28_1.localEulerAngles = var_28_1.localEulerAngles
			end

			if arg_25_1.time_ >= 0 + var_28_2 and arg_25_1.time_ < 0 + var_28_2 + arg_28_0 then
				var_28_1.localPosition = Vector3.New(0, 100, 0)
				var_28_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_28_1.position).x, (manager.ui.mainCamera.transform.position - var_28_1.position).y, (manager.ui.mainCamera.transform.position - var_28_1.position).z)
				var_28_1.localEulerAngles.z = 0
				var_28_1.localEulerAngles.x = 0
				var_28_1.localEulerAngles = var_28_1.localEulerAngles
			end

			local var_28_3 = 0
			local var_28_4 = 0.275

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_3 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[1320].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, true)
				arg_25_1.iconController_:SetSelectedState("hero")

				arg_25_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Jackson")

				arg_25_1.callingController_:SetSelectedState("normal")

				arg_25_1.keyicon_.color = Color.New(1, 1, 1)
				arg_25_1.icon_.color = Color.New(1, 1, 1)

				local var_28_5 = arg_25_1:GetWordFromCfg(421072006)
				local var_28_6 = arg_25_1:FormatText(var_28_5.content)

				arg_25_1.text_.text = var_28_6

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_8 = 11 <= 0 and var_28_4 or var_28_4 * (utf8.len(var_28_6) / 11)

				if (11 <= 0 and var_28_4 or var_28_4 * (utf8.len(var_28_6) / 11)) > 0 and var_28_4 < var_28_8 then
					arg_25_1.talkMaxDuration = var_28_8

					if var_28_8 + var_28_3 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_8 + var_28_3
					end
				end

				arg_25_1.text_.text = var_28_6
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421072", "421072006", "story_v_out_421072.awb") ~= 0 then
					local var_28_9 = manager.audio:GetVoiceLength("story_v_out_421072", "421072006", "story_v_out_421072.awb") / 1000

					if var_28_9 + var_28_3 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_9 + var_28_3
					end

					if var_28_5.prefab_name ~= "" and arg_25_1.actors_[var_28_5.prefab_name] ~= nil then
						local var_28_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_5.prefab_name].transform, "story_v_out_421072", "421072006", "story_v_out_421072.awb")

						arg_25_1:RecordAudio("421072006", var_28_10)
						arg_25_1:RecordAudio("421072006", var_28_10)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_421072", "421072006", "story_v_out_421072.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_421072", "421072006", "story_v_out_421072.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_11 = math.max(var_28_4, arg_25_1.talkMaxDuration)

			if var_28_3 <= arg_25_1.time_ and arg_25_1.time_ < var_28_3 + var_28_11 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_3) / var_28_11

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_3 + var_28_11 and arg_25_1.time_ < var_28_3 + var_28_11 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10145ui_story",
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
	Play421072007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 421072007
		arg_29_1.duration_ = 1.4

		local var_29_0 = {
			zh = 1.033,
			ja = 1.4
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
				arg_29_0:Play421072008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.var_.moveOldPos1047ui_story = arg_29_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_32_0 = 0.001

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_0 then
				arg_29_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_29_1.time_ - 0) / var_32_0)
				arg_29_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_29_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_29_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_29_1.actors_["1047ui_story"].transform.position).z)
				arg_29_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_29_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_29_1.actors_["1047ui_story"].transform.localEulerAngles = arg_29_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_29_1.time_ >= 0 + var_32_0 and arg_29_1.time_ < 0 + var_32_0 + arg_32_0 then
				arg_29_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_29_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_29_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_29_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_29_1.actors_["1047ui_story"].transform.position).z)
				arg_29_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_29_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_29_1.actors_["1047ui_story"].transform.localEulerAngles = arg_29_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_32_1 = arg_29_1.actors_["1047ui_story"]

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(var_32_1) and arg_29_1.var_.characterEffect1047ui_story == nil then
				arg_29_1.var_.characterEffect1047ui_story = var_32_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_2 = 0.200000002980232

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_2 and not isNil(var_32_1) then
				if arg_29_1.var_.characterEffect1047ui_story and not isNil(var_32_1) then
					arg_29_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_29_1.time_ >= 0 + var_32_2 and arg_29_1.time_ < 0 + var_32_2 + arg_32_0 and not isNil(var_32_1) and arg_29_1.var_.characterEffect1047ui_story then
				arg_29_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_32_4 = 0
			local var_32_5 = 0.075

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_4 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_6 = arg_29_1:GetWordFromCfg(421072007)
				local var_32_7 = arg_29_1:FormatText(var_32_6.content)

				arg_29_1.text_.text = var_32_7

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_9 = 3 <= 0 and var_32_5 or var_32_5 * (utf8.len(var_32_7) / 3)

				if (3 <= 0 and var_32_5 or var_32_5 * (utf8.len(var_32_7) / 3)) > 0 and var_32_5 < var_32_9 then
					arg_29_1.talkMaxDuration = var_32_9

					if var_32_9 + var_32_4 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_9 + var_32_4
					end
				end

				arg_29_1.text_.text = var_32_7
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421072", "421072007", "story_v_out_421072.awb") ~= 0 then
					local var_32_10 = manager.audio:GetVoiceLength("story_v_out_421072", "421072007", "story_v_out_421072.awb") / 1000

					if var_32_10 + var_32_4 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_10 + var_32_4
					end

					if var_32_6.prefab_name ~= "" and arg_29_1.actors_[var_32_6.prefab_name] ~= nil then
						local var_32_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_6.prefab_name].transform, "story_v_out_421072", "421072007", "story_v_out_421072.awb")

						arg_29_1:RecordAudio("421072007", var_32_11)
						arg_29_1:RecordAudio("421072007", var_32_11)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_421072", "421072007", "story_v_out_421072.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_421072", "421072007", "story_v_out_421072.awb")
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

		arg_29_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_29_1:InitPlayNodeList()
	end,
	Play421072008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 421072008
		arg_33_1.duration_ = 8.07

		local var_33_0 = {
			zh = 4.733,
			ja = 8.066
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
				arg_33_0:Play421072009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(arg_33_1.actors_["1047ui_story"]) and arg_33_1.var_.characterEffect1047ui_story == nil then
				arg_33_1.var_.characterEffect1047ui_story = arg_33_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_0 = 0.200000002980232

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_0 and not isNil(arg_33_1.actors_["1047ui_story"]) then
				if arg_33_1.var_.characterEffect1047ui_story and not isNil(arg_33_1.actors_["1047ui_story"]) then
					arg_33_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_33_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_33_1.time_ - 0) / var_36_0)
				end
			end

			if arg_33_1.time_ >= 0 + var_36_0 and arg_33_1.time_ < 0 + var_36_0 + arg_36_0 and not isNil(arg_33_1.actors_["1047ui_story"]) and arg_33_1.var_.characterEffect1047ui_story then
				arg_33_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_33_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_36_1 = 0
			local var_36_2 = 0.525

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_1 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				arg_33_1.leftNameTxt_.text = arg_33_1:FormatText(StoryNameCfg[1320].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, true)
				arg_33_1.iconController_:SetSelectedState("hero")

				arg_33_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Jackson")

				arg_33_1.callingController_:SetSelectedState("normal")

				arg_33_1.keyicon_.color = Color.New(1, 1, 1)
				arg_33_1.icon_.color = Color.New(1, 1, 1)

				local var_36_3 = arg_33_1:GetWordFromCfg(421072008)
				local var_36_4 = arg_33_1:FormatText(var_36_3.content)

				arg_33_1.text_.text = var_36_4

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_6 = 21 <= 0 and var_36_2 or var_36_2 * (utf8.len(var_36_4) / 21)

				if (21 <= 0 and var_36_2 or var_36_2 * (utf8.len(var_36_4) / 21)) > 0 and var_36_2 < var_36_6 then
					arg_33_1.talkMaxDuration = var_36_6

					if var_36_6 + var_36_1 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_6 + var_36_1
					end
				end

				arg_33_1.text_.text = var_36_4
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421072", "421072008", "story_v_out_421072.awb") ~= 0 then
					local var_36_7 = manager.audio:GetVoiceLength("story_v_out_421072", "421072008", "story_v_out_421072.awb") / 1000

					if var_36_7 + var_36_1 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_7 + var_36_1
					end

					if var_36_3.prefab_name ~= "" and arg_33_1.actors_[var_36_3.prefab_name] ~= nil then
						local var_36_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_3.prefab_name].transform, "story_v_out_421072", "421072008", "story_v_out_421072.awb")

						arg_33_1:RecordAudio("421072008", var_36_8)
						arg_33_1:RecordAudio("421072008", var_36_8)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_421072", "421072008", "story_v_out_421072.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_421072", "421072008", "story_v_out_421072.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_9 = math.max(var_36_2, arg_33_1.talkMaxDuration)

			if var_36_1 <= arg_33_1.time_ and arg_33_1.time_ < var_36_1 + var_36_9 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_1) / var_36_9

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_1 + var_36_9 and arg_33_1.time_ < var_36_1 + var_36_9 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play421072009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 421072009
		arg_37_1.duration_ = 2.03

		local var_37_0 = {
			zh = 1.999999999999,
			ja = 2.033
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
				arg_37_0:Play421072010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1.var_.moveOldPos1047ui_story = arg_37_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_40_0 = 0.001

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_0 then
				arg_37_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_37_1.time_ - 0) / var_40_0)
				arg_37_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_37_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_37_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_37_1.actors_["1047ui_story"].transform.position).z)
				arg_37_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_37_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_37_1.actors_["1047ui_story"].transform.localEulerAngles = arg_37_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_37_1.time_ >= 0 + var_40_0 and arg_37_1.time_ < 0 + var_40_0 + arg_40_0 then
				arg_37_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_37_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_37_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_37_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_37_1.actors_["1047ui_story"].transform.position).z)
				arg_37_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_37_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_37_1.actors_["1047ui_story"].transform.localEulerAngles = arg_37_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_40_1 = arg_37_1.actors_["1047ui_story"]

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(var_40_1) and arg_37_1.var_.characterEffect1047ui_story == nil then
				arg_37_1.var_.characterEffect1047ui_story = var_40_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_2 = 0.200000002980232

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_2 and not isNil(var_40_1) then
				if arg_37_1.var_.characterEffect1047ui_story and not isNil(var_40_1) then
					arg_37_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_37_1.time_ >= 0 + var_40_2 and arg_37_1.time_ < 0 + var_40_2 + arg_40_0 and not isNil(var_40_1) and arg_37_1.var_.characterEffect1047ui_story then
				arg_37_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action7_1")
			end

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_40_4 = 0
			local var_40_5 = 0.175

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_4 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				arg_37_1.leftNameTxt_.text = arg_37_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_6 = arg_37_1:GetWordFromCfg(421072009)
				local var_40_7 = arg_37_1:FormatText(var_40_6.content)

				arg_37_1.text_.text = var_40_7

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_9 = 7 <= 0 and var_40_5 or var_40_5 * (utf8.len(var_40_7) / 7)

				if (7 <= 0 and var_40_5 or var_40_5 * (utf8.len(var_40_7) / 7)) > 0 and var_40_5 < var_40_9 then
					arg_37_1.talkMaxDuration = var_40_9

					if var_40_9 + var_40_4 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_9 + var_40_4
					end
				end

				arg_37_1.text_.text = var_40_7
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421072", "421072009", "story_v_out_421072.awb") ~= 0 then
					local var_40_10 = manager.audio:GetVoiceLength("story_v_out_421072", "421072009", "story_v_out_421072.awb") / 1000

					if var_40_10 + var_40_4 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_10 + var_40_4
					end

					if var_40_6.prefab_name ~= "" and arg_37_1.actors_[var_40_6.prefab_name] ~= nil then
						local var_40_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_6.prefab_name].transform, "story_v_out_421072", "421072009", "story_v_out_421072.awb")

						arg_37_1:RecordAudio("421072009", var_40_11)
						arg_37_1:RecordAudio("421072009", var_40_11)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_421072", "421072009", "story_v_out_421072.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_421072", "421072009", "story_v_out_421072.awb")
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
				actorName = "1047ui_story",
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
	Play421072010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 421072010
		arg_41_1.duration_ = 5

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play421072011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(arg_41_1.actors_["1047ui_story"]) and arg_41_1.var_.characterEffect1047ui_story == nil then
				arg_41_1.var_.characterEffect1047ui_story = arg_41_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_0 = 0.200000002980232

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_0 and not isNil(arg_41_1.actors_["1047ui_story"]) then
				if arg_41_1.var_.characterEffect1047ui_story and not isNil(arg_41_1.actors_["1047ui_story"]) then
					arg_41_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_41_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_41_1.time_ - 0) / var_44_0)
				end
			end

			if arg_41_1.time_ >= 0 + var_44_0 and arg_41_1.time_ < 0 + var_44_0 + arg_44_0 and not isNil(arg_41_1.actors_["1047ui_story"]) and arg_41_1.var_.characterEffect1047ui_story then
				arg_41_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_41_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_44_1 = 0
			local var_44_2 = 0.325

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_1 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				arg_41_1.leftNameTxt_.text = arg_41_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, true)
				arg_41_1.iconController_:SetSelectedState("hero")

				arg_41_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_41_1.callingController_:SetSelectedState("normal")

				arg_41_1.keyicon_.color = Color.New(1, 1, 1)
				arg_41_1.icon_.color = Color.New(1, 1, 1)

				local var_44_3 = arg_41_1:FormatText(arg_41_1:GetWordFromCfg(421072010).content)

				arg_41_1.text_.text = var_44_3

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_5 = 13 <= 0 and var_44_2 or var_44_2 * (utf8.len(var_44_3) / 13)

				if (13 <= 0 and var_44_2 or var_44_2 * (utf8.len(var_44_3) / 13)) > 0 and var_44_2 < var_44_5 then
					arg_41_1.talkMaxDuration = var_44_5

					if var_44_5 + var_44_1 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_5 + var_44_1
					end
				end

				arg_41_1.text_.text = var_44_3
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)
				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_6 = math.max(var_44_2, arg_41_1.talkMaxDuration)

			if var_44_1 <= arg_41_1.time_ and arg_41_1.time_ < var_44_1 + var_44_6 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_1) / var_44_6

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_1 + var_44_6 and arg_41_1.time_ < var_44_1 + var_44_6 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play421072011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 421072011
		arg_45_1.duration_ = 4.93

		local var_45_0 = {
			zh = 3.166,
			ja = 4.933
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
				arg_45_0:Play421072012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1.var_.moveOldPos1047ui_story = arg_45_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_48_0 = 0.001

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_0 then
				arg_45_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_45_1.time_ - 0) / var_48_0)
				arg_45_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_45_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_45_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_45_1.actors_["1047ui_story"].transform.position).z)
				arg_45_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_45_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_45_1.actors_["1047ui_story"].transform.localEulerAngles = arg_45_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_45_1.time_ >= 0 + var_48_0 and arg_45_1.time_ < 0 + var_48_0 + arg_48_0 then
				arg_45_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_45_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_45_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_45_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_45_1.actors_["1047ui_story"].transform.position).z)
				arg_45_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_45_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_45_1.actors_["1047ui_story"].transform.localEulerAngles = arg_45_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_48_1 = arg_45_1.actors_["1047ui_story"]

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 and not isNil(var_48_1) and arg_45_1.var_.characterEffect1047ui_story == nil then
				arg_45_1.var_.characterEffect1047ui_story = var_48_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_2 = 0.200000002980232

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_2 and not isNil(var_48_1) then
				if arg_45_1.var_.characterEffect1047ui_story and not isNil(var_48_1) then
					arg_45_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_45_1.time_ >= 0 + var_48_2 and arg_45_1.time_ < 0 + var_48_2 + arg_48_0 and not isNil(var_48_1) and arg_45_1.var_.characterEffect1047ui_story then
				arg_45_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047actionlink/1047action476")
			end

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_48_4 = 0
			local var_48_5 = 0.35

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_4 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				arg_45_1.leftNameTxt_.text = arg_45_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_6 = arg_45_1:GetWordFromCfg(421072011)
				local var_48_7 = arg_45_1:FormatText(var_48_6.content)

				arg_45_1.text_.text = var_48_7

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_9 = 14 <= 0 and var_48_5 or var_48_5 * (utf8.len(var_48_7) / 14)

				if (14 <= 0 and var_48_5 or var_48_5 * (utf8.len(var_48_7) / 14)) > 0 and var_48_5 < var_48_9 then
					arg_45_1.talkMaxDuration = var_48_9

					if var_48_9 + var_48_4 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_9 + var_48_4
					end
				end

				arg_45_1.text_.text = var_48_7
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421072", "421072011", "story_v_out_421072.awb") ~= 0 then
					local var_48_10 = manager.audio:GetVoiceLength("story_v_out_421072", "421072011", "story_v_out_421072.awb") / 1000

					if var_48_10 + var_48_4 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_10 + var_48_4
					end

					if var_48_6.prefab_name ~= "" and arg_45_1.actors_[var_48_6.prefab_name] ~= nil then
						local var_48_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_6.prefab_name].transform, "story_v_out_421072", "421072011", "story_v_out_421072.awb")

						arg_45_1:RecordAudio("421072011", var_48_11)
						arg_45_1:RecordAudio("421072011", var_48_11)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_421072", "421072011", "story_v_out_421072.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_421072", "421072011", "story_v_out_421072.awb")
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
				actorName = "1047ui_story",
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
	Play421072012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 421072012
		arg_49_1.duration_ = 9.2

		local var_49_0 = {
			zh = 5.966,
			ja = 9.2
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
				arg_49_0:Play421072013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1.var_.moveOldPos1047ui_story = arg_49_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_52_0 = 0.001

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_0 then
				arg_49_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_49_1.time_ - 0) / var_52_0)
				arg_49_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_49_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_49_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_49_1.actors_["1047ui_story"].transform.position).z)
				arg_49_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_49_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_49_1.actors_["1047ui_story"].transform.localEulerAngles = arg_49_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_49_1.time_ >= 0 + var_52_0 and arg_49_1.time_ < 0 + var_52_0 + arg_52_0 then
				arg_49_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_49_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_49_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_49_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_49_1.actors_["1047ui_story"].transform.position).z)
				arg_49_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_49_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_49_1.actors_["1047ui_story"].transform.localEulerAngles = arg_49_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action6_2")
			end

			local var_52_1 = 0
			local var_52_2 = 0.7

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_1 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				arg_49_1.leftNameTxt_.text = arg_49_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_3 = arg_49_1:GetWordFromCfg(421072012)
				local var_52_4 = arg_49_1:FormatText(var_52_3.content)

				arg_49_1.text_.text = var_52_4

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_6 = 28 <= 0 and var_52_2 or var_52_2 * (utf8.len(var_52_4) / 28)

				if (28 <= 0 and var_52_2 or var_52_2 * (utf8.len(var_52_4) / 28)) > 0 and var_52_2 < var_52_6 then
					arg_49_1.talkMaxDuration = var_52_6

					if var_52_6 + var_52_1 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_6 + var_52_1
					end
				end

				arg_49_1.text_.text = var_52_4
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421072", "421072012", "story_v_out_421072.awb") ~= 0 then
					local var_52_7 = manager.audio:GetVoiceLength("story_v_out_421072", "421072012", "story_v_out_421072.awb") / 1000

					if var_52_7 + var_52_1 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_7 + var_52_1
					end

					if var_52_3.prefab_name ~= "" and arg_49_1.actors_[var_52_3.prefab_name] ~= nil then
						local var_52_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_3.prefab_name].transform, "story_v_out_421072", "421072012", "story_v_out_421072.awb")

						arg_49_1:RecordAudio("421072012", var_52_8)
						arg_49_1:RecordAudio("421072012", var_52_8)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_421072", "421072012", "story_v_out_421072.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_421072", "421072012", "story_v_out_421072.awb")
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

		arg_49_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_49_1:InitPlayNodeList()
	end,
	Play421072013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 421072013
		arg_53_1.duration_ = 9.83

		local var_53_0 = {
			zh = 9.833,
			ja = 8.833
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
				arg_53_0:Play421072014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 and not isNil(arg_53_1.actors_["1047ui_story"]) and arg_53_1.var_.characterEffect1047ui_story == nil then
				arg_53_1.var_.characterEffect1047ui_story = arg_53_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_0 = 0.200000002980232

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_0 and not isNil(arg_53_1.actors_["1047ui_story"]) then
				if arg_53_1.var_.characterEffect1047ui_story and not isNil(arg_53_1.actors_["1047ui_story"]) then
					arg_53_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_53_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_53_1.time_ - 0) / var_56_0)
				end
			end

			if arg_53_1.time_ >= 0 + var_56_0 and arg_53_1.time_ < 0 + var_56_0 + arg_56_0 and not isNil(arg_53_1.actors_["1047ui_story"]) and arg_53_1.var_.characterEffect1047ui_story then
				arg_53_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_53_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_56_1 = 0
			local var_56_2 = 0.7

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_1 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				arg_53_1.leftNameTxt_.text = arg_53_1:FormatText(StoryNameCfg[1320].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, true)
				arg_53_1.iconController_:SetSelectedState("hero")

				arg_53_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Jackson")

				arg_53_1.callingController_:SetSelectedState("normal")

				arg_53_1.keyicon_.color = Color.New(1, 1, 1)
				arg_53_1.icon_.color = Color.New(1, 1, 1)

				local var_56_3 = arg_53_1:GetWordFromCfg(421072013)
				local var_56_4 = arg_53_1:FormatText(var_56_3.content)

				arg_53_1.text_.text = var_56_4

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_6 = 28 <= 0 and var_56_2 or var_56_2 * (utf8.len(var_56_4) / 28)

				if (28 <= 0 and var_56_2 or var_56_2 * (utf8.len(var_56_4) / 28)) > 0 and var_56_2 < var_56_6 then
					arg_53_1.talkMaxDuration = var_56_6

					if var_56_6 + var_56_1 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_6 + var_56_1
					end
				end

				arg_53_1.text_.text = var_56_4
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421072", "421072013", "story_v_out_421072.awb") ~= 0 then
					local var_56_7 = manager.audio:GetVoiceLength("story_v_out_421072", "421072013", "story_v_out_421072.awb") / 1000

					if var_56_7 + var_56_1 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_7 + var_56_1
					end

					if var_56_3.prefab_name ~= "" and arg_53_1.actors_[var_56_3.prefab_name] ~= nil then
						local var_56_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_3.prefab_name].transform, "story_v_out_421072", "421072013", "story_v_out_421072.awb")

						arg_53_1:RecordAudio("421072013", var_56_8)
						arg_53_1:RecordAudio("421072013", var_56_8)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_421072", "421072013", "story_v_out_421072.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_421072", "421072013", "story_v_out_421072.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_9 = math.max(var_56_2, arg_53_1.talkMaxDuration)

			if var_56_1 <= arg_53_1.time_ and arg_53_1.time_ < var_56_1 + var_56_9 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_1) / var_56_9

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_1 + var_56_9 and arg_53_1.time_ < var_56_1 + var_56_9 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play421072014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 421072014
		arg_57_1.duration_ = 4.17

		local var_57_0 = {
			zh = 3.466,
			ja = 4.166
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
				arg_57_0:Play421072015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1.var_.moveOldPos10145ui_story = arg_57_1.actors_["10145ui_story"].transform.localPosition
			end

			local var_60_0 = 0.001

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_0 then
				arg_57_1.actors_["10145ui_story"].transform.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos10145ui_story, Vector3.New(0, -1, -6.2), (arg_57_1.time_ - 0) / var_60_0)
				arg_57_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_57_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["10145ui_story"].transform.position).z)
				arg_57_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_57_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_57_1.actors_["10145ui_story"].transform.localEulerAngles = arg_57_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			if arg_57_1.time_ >= 0 + var_60_0 and arg_57_1.time_ < 0 + var_60_0 + arg_60_0 then
				arg_57_1.actors_["10145ui_story"].transform.localPosition = Vector3.New(0, -1, -6.2)
				arg_57_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_57_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["10145ui_story"].transform.position).z)
				arg_57_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_57_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_57_1.actors_["10145ui_story"].transform.localEulerAngles = arg_57_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			local var_60_1 = arg_57_1.actors_["1047ui_story"].transform

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1.var_.moveOldPos1047ui_story = var_60_1.localPosition
			end

			local var_60_2 = 0.001

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_2 then
				var_60_1.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos1047ui_story, Vector3.New(0, 100, 0), (arg_57_1.time_ - 0) / var_60_2)
				var_60_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_60_1.position).x, (manager.ui.mainCamera.transform.position - var_60_1.position).y, (manager.ui.mainCamera.transform.position - var_60_1.position).z)
				var_60_1.localEulerAngles.z = 0
				var_60_1.localEulerAngles.x = 0
				var_60_1.localEulerAngles = var_60_1.localEulerAngles
			end

			if arg_57_1.time_ >= 0 + var_60_2 and arg_57_1.time_ < 0 + var_60_2 + arg_60_0 then
				var_60_1.localPosition = Vector3.New(0, 100, 0)
				var_60_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_60_1.position).x, (manager.ui.mainCamera.transform.position - var_60_1.position).y, (manager.ui.mainCamera.transform.position - var_60_1.position).z)
				var_60_1.localEulerAngles.z = 0
				var_60_1.localEulerAngles.x = 0
				var_60_1.localEulerAngles = var_60_1.localEulerAngles
			end

			local var_60_3 = arg_57_1.actors_["10145ui_story"]

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 and not isNil(var_60_3) and arg_57_1.var_.characterEffect10145ui_story == nil then
				arg_57_1.var_.characterEffect10145ui_story = var_60_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_4 = 0.200000002980232

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_4 and not isNil(var_60_3) then
				if arg_57_1.var_.characterEffect10145ui_story and not isNil(var_60_3) then
					arg_57_1.var_.characterEffect10145ui_story.fillFlat = false
				end
			end

			if arg_57_1.time_ >= 0 + var_60_4 and arg_57_1.time_ < 0 + var_60_4 + arg_60_0 and not isNil(var_60_3) and arg_57_1.var_.characterEffect10145ui_story then
				arg_57_1.var_.characterEffect10145ui_story.fillFlat = false
			end

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/story10145/story10145action/10145action2_1")
			end

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_60_6 = 0
			local var_60_7 = 0.375

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_6 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				arg_57_1.leftNameTxt_.text = arg_57_1:FormatText(StoryNameCfg[1308].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_8 = arg_57_1:GetWordFromCfg(421072014)
				local var_60_9 = arg_57_1:FormatText(var_60_8.content)

				arg_57_1.text_.text = var_60_9

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_11 = 15 <= 0 and var_60_7 or var_60_7 * (utf8.len(var_60_9) / 15)

				if (15 <= 0 and var_60_7 or var_60_7 * (utf8.len(var_60_9) / 15)) > 0 and var_60_7 < var_60_11 then
					arg_57_1.talkMaxDuration = var_60_11

					if var_60_11 + var_60_6 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_11 + var_60_6
					end
				end

				arg_57_1.text_.text = var_60_9
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421072", "421072014", "story_v_out_421072.awb") ~= 0 then
					local var_60_12 = manager.audio:GetVoiceLength("story_v_out_421072", "421072014", "story_v_out_421072.awb") / 1000

					if var_60_12 + var_60_6 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_12 + var_60_6
					end

					if var_60_8.prefab_name ~= "" and arg_57_1.actors_[var_60_8.prefab_name] ~= nil then
						local var_60_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_8.prefab_name].transform, "story_v_out_421072", "421072014", "story_v_out_421072.awb")

						arg_57_1:RecordAudio("421072014", var_60_13)
						arg_57_1:RecordAudio("421072014", var_60_13)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_421072", "421072014", "story_v_out_421072.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_421072", "421072014", "story_v_out_421072.awb")
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
				actorName = "10145ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1047ui_story",
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
	Play421072015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 421072015
		arg_61_1.duration_ = 8.1

		local var_61_0 = {
			zh = 8.1,
			ja = 7.033
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
				arg_61_0:Play421072016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 and not isNil(arg_61_1.actors_["10145ui_story"]) and arg_61_1.var_.characterEffect10145ui_story == nil then
				arg_61_1.var_.characterEffect10145ui_story = arg_61_1.actors_["10145ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_0 = 0.200000002980232

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_0 and not isNil(arg_61_1.actors_["10145ui_story"]) then
				if arg_61_1.var_.characterEffect10145ui_story and not isNil(arg_61_1.actors_["10145ui_story"]) then
					arg_61_1.var_.characterEffect10145ui_story.fillFlat = true
					arg_61_1.var_.characterEffect10145ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_61_1.time_ - 0) / var_64_0)
				end
			end

			if arg_61_1.time_ >= 0 + var_64_0 and arg_61_1.time_ < 0 + var_64_0 + arg_64_0 and not isNil(arg_61_1.actors_["10145ui_story"]) and arg_61_1.var_.characterEffect10145ui_story then
				arg_61_1.var_.characterEffect10145ui_story.fillFlat = true
				arg_61_1.var_.characterEffect10145ui_story.fillRatio = 0.5
			end

			local var_64_1 = 0
			local var_64_2 = 0.65

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_1 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				arg_61_1.leftNameTxt_.text = arg_61_1:FormatText(StoryNameCfg[1320].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, true)
				arg_61_1.iconController_:SetSelectedState("hero")

				arg_61_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Jackson")

				arg_61_1.callingController_:SetSelectedState("normal")

				arg_61_1.keyicon_.color = Color.New(1, 1, 1)
				arg_61_1.icon_.color = Color.New(1, 1, 1)

				local var_64_3 = arg_61_1:GetWordFromCfg(421072015)
				local var_64_4 = arg_61_1:FormatText(var_64_3.content)

				arg_61_1.text_.text = var_64_4

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_6 = 26 <= 0 and var_64_2 or var_64_2 * (utf8.len(var_64_4) / 26)

				if (26 <= 0 and var_64_2 or var_64_2 * (utf8.len(var_64_4) / 26)) > 0 and var_64_2 < var_64_6 then
					arg_61_1.talkMaxDuration = var_64_6

					if var_64_6 + var_64_1 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_6 + var_64_1
					end
				end

				arg_61_1.text_.text = var_64_4
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421072", "421072015", "story_v_out_421072.awb") ~= 0 then
					local var_64_7 = manager.audio:GetVoiceLength("story_v_out_421072", "421072015", "story_v_out_421072.awb") / 1000

					if var_64_7 + var_64_1 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_7 + var_64_1
					end

					if var_64_3.prefab_name ~= "" and arg_61_1.actors_[var_64_3.prefab_name] ~= nil then
						local var_64_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_3.prefab_name].transform, "story_v_out_421072", "421072015", "story_v_out_421072.awb")

						arg_61_1:RecordAudio("421072015", var_64_8)
						arg_61_1:RecordAudio("421072015", var_64_8)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_421072", "421072015", "story_v_out_421072.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_421072", "421072015", "story_v_out_421072.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_9 = math.max(var_64_2, arg_61_1.talkMaxDuration)

			if var_64_1 <= arg_61_1.time_ and arg_61_1.time_ < var_64_1 + var_64_9 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_1) / var_64_9

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_1 + var_64_9 and arg_61_1.time_ < var_64_1 + var_64_9 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play421072016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 421072016
		arg_65_1.duration_ = 5

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play421072017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1.var_.moveOldPos10145ui_story = arg_65_1.actors_["10145ui_story"].transform.localPosition
			end

			local var_68_0 = 0.001

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_0 then
				arg_65_1.actors_["10145ui_story"].transform.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos10145ui_story, Vector3.New(0, 100, 0), (arg_65_1.time_ - 0) / var_68_0)
				arg_65_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_65_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["10145ui_story"].transform.position).z)
				arg_65_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_65_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_65_1.actors_["10145ui_story"].transform.localEulerAngles = arg_65_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			if arg_65_1.time_ >= 0 + var_68_0 and arg_65_1.time_ < 0 + var_68_0 + arg_68_0 then
				arg_65_1.actors_["10145ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_65_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_65_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["10145ui_story"].transform.position).z)
				arg_65_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_65_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_65_1.actors_["10145ui_story"].transform.localEulerAngles = arg_65_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			local var_68_1 = 0
			local var_68_2 = 0.9

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_1 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, false)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_3 = arg_65_1:FormatText(arg_65_1:GetWordFromCfg(421072016).content)

				arg_65_1.text_.text = var_68_3

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_5 = 36 <= 0 and var_68_2 or var_68_2 * (utf8.len(var_68_3) / 36)

				if (36 <= 0 and var_68_2 or var_68_2 * (utf8.len(var_68_3) / 36)) > 0 and var_68_2 < var_68_5 then
					arg_65_1.talkMaxDuration = var_68_5

					if var_68_5 + var_68_1 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_5 + var_68_1
					end
				end

				arg_65_1.text_.text = var_68_3
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)
				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_6 = math.max(var_68_2, arg_65_1.talkMaxDuration)

			if var_68_1 <= arg_65_1.time_ and arg_65_1.time_ < var_68_1 + var_68_6 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_1) / var_68_6

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_1 + var_68_6 and arg_65_1.time_ < var_68_1 + var_68_6 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10145ui_story",
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
	Play421072017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 421072017
		arg_69_1.duration_ = 5.2

		local var_69_0 = {
			zh = 4.433,
			ja = 5.2
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
				arg_69_0:Play421072018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1.var_.moveOldPos10145ui_story = arg_69_1.actors_["10145ui_story"].transform.localPosition
			end

			local var_72_0 = 0.001

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_0 then
				arg_69_1.actors_["10145ui_story"].transform.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos10145ui_story, Vector3.New(0, -1, -6.2), (arg_69_1.time_ - 0) / var_72_0)
				arg_69_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_69_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_69_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_69_1.actors_["10145ui_story"].transform.position).z)
				arg_69_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_69_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_69_1.actors_["10145ui_story"].transform.localEulerAngles = arg_69_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			if arg_69_1.time_ >= 0 + var_72_0 and arg_69_1.time_ < 0 + var_72_0 + arg_72_0 then
				arg_69_1.actors_["10145ui_story"].transform.localPosition = Vector3.New(0, -1, -6.2)
				arg_69_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_69_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_69_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_69_1.actors_["10145ui_story"].transform.position).z)
				arg_69_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_69_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_69_1.actors_["10145ui_story"].transform.localEulerAngles = arg_69_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			local var_72_1 = arg_69_1.actors_["10145ui_story"]

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 and not isNil(var_72_1) and arg_69_1.var_.characterEffect10145ui_story == nil then
				arg_69_1.var_.characterEffect10145ui_story = var_72_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_2 = 0.200000002980232

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_2 and not isNil(var_72_1) then
				if arg_69_1.var_.characterEffect10145ui_story and not isNil(var_72_1) then
					arg_69_1.var_.characterEffect10145ui_story.fillFlat = false
				end
			end

			if arg_69_1.time_ >= 0 + var_72_2 and arg_69_1.time_ < 0 + var_72_2 + arg_72_0 and not isNil(var_72_1) and arg_69_1.var_.characterEffect10145ui_story then
				arg_69_1.var_.characterEffect10145ui_story.fillFlat = false
			end

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/story10145/story10145action/10145action2_2")
			end

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_72_4 = 0
			local var_72_5 = 0.425

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_4 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				arg_69_1.leftNameTxt_.text = arg_69_1:FormatText(StoryNameCfg[1308].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_6 = arg_69_1:GetWordFromCfg(421072017)
				local var_72_7 = arg_69_1:FormatText(var_72_6.content)

				arg_69_1.text_.text = var_72_7

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_9 = 17 <= 0 and var_72_5 or var_72_5 * (utf8.len(var_72_7) / 17)

				if (17 <= 0 and var_72_5 or var_72_5 * (utf8.len(var_72_7) / 17)) > 0 and var_72_5 < var_72_9 then
					arg_69_1.talkMaxDuration = var_72_9

					if var_72_9 + var_72_4 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_9 + var_72_4
					end
				end

				arg_69_1.text_.text = var_72_7
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421072", "421072017", "story_v_out_421072.awb") ~= 0 then
					local var_72_10 = manager.audio:GetVoiceLength("story_v_out_421072", "421072017", "story_v_out_421072.awb") / 1000

					if var_72_10 + var_72_4 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_10 + var_72_4
					end

					if var_72_6.prefab_name ~= "" and arg_69_1.actors_[var_72_6.prefab_name] ~= nil then
						local var_72_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_6.prefab_name].transform, "story_v_out_421072", "421072017", "story_v_out_421072.awb")

						arg_69_1:RecordAudio("421072017", var_72_11)
						arg_69_1:RecordAudio("421072017", var_72_11)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_421072", "421072017", "story_v_out_421072.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_421072", "421072017", "story_v_out_421072.awb")
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

		arg_69_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10145ui_story",
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
	Play421072018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 421072018
		arg_73_1.duration_ = 23.67

		local var_73_0 = {
			zh = 14.633,
			ja = 23.666
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
				arg_73_0:Play421072019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 and not isNil(arg_73_1.actors_["10145ui_story"]) and arg_73_1.var_.characterEffect10145ui_story == nil then
				arg_73_1.var_.characterEffect10145ui_story = arg_73_1.actors_["10145ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_0 = 0.200000002980232

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_0 and not isNil(arg_73_1.actors_["10145ui_story"]) then
				if arg_73_1.var_.characterEffect10145ui_story and not isNil(arg_73_1.actors_["10145ui_story"]) then
					arg_73_1.var_.characterEffect10145ui_story.fillFlat = true
					arg_73_1.var_.characterEffect10145ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_73_1.time_ - 0) / var_76_0)
				end
			end

			if arg_73_1.time_ >= 0 + var_76_0 and arg_73_1.time_ < 0 + var_76_0 + arg_76_0 and not isNil(arg_73_1.actors_["10145ui_story"]) and arg_73_1.var_.characterEffect10145ui_story then
				arg_73_1.var_.characterEffect10145ui_story.fillFlat = true
				arg_73_1.var_.characterEffect10145ui_story.fillRatio = 0.5
			end

			local var_76_1 = 0
			local var_76_2 = 1.35

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_1 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				arg_73_1.leftNameTxt_.text = arg_73_1:FormatText(StoryNameCfg[1320].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, true)
				arg_73_1.iconController_:SetSelectedState("hero")

				arg_73_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Jackson")

				arg_73_1.callingController_:SetSelectedState("normal")

				arg_73_1.keyicon_.color = Color.New(1, 1, 1)
				arg_73_1.icon_.color = Color.New(1, 1, 1)

				local var_76_3 = arg_73_1:GetWordFromCfg(421072018)
				local var_76_4 = arg_73_1:FormatText(var_76_3.content)

				arg_73_1.text_.text = var_76_4

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_6 = 54 <= 0 and var_76_2 or var_76_2 * (utf8.len(var_76_4) / 54)

				if (54 <= 0 and var_76_2 or var_76_2 * (utf8.len(var_76_4) / 54)) > 0 and var_76_2 < var_76_6 then
					arg_73_1.talkMaxDuration = var_76_6

					if var_76_6 + var_76_1 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_6 + var_76_1
					end
				end

				arg_73_1.text_.text = var_76_4
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421072", "421072018", "story_v_out_421072.awb") ~= 0 then
					local var_76_7 = manager.audio:GetVoiceLength("story_v_out_421072", "421072018", "story_v_out_421072.awb") / 1000

					if var_76_7 + var_76_1 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_7 + var_76_1
					end

					if var_76_3.prefab_name ~= "" and arg_73_1.actors_[var_76_3.prefab_name] ~= nil then
						local var_76_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_3.prefab_name].transform, "story_v_out_421072", "421072018", "story_v_out_421072.awb")

						arg_73_1:RecordAudio("421072018", var_76_8)
						arg_73_1:RecordAudio("421072018", var_76_8)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_421072", "421072018", "story_v_out_421072.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_421072", "421072018", "story_v_out_421072.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_9 = math.max(var_76_2, arg_73_1.talkMaxDuration)

			if var_76_1 <= arg_73_1.time_ and arg_73_1.time_ < var_76_1 + var_76_9 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_1) / var_76_9

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_1 + var_76_9 and arg_73_1.time_ < var_76_1 + var_76_9 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play421072019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 421072019
		arg_77_1.duration_ = 9.9

		local var_77_0 = {
			zh = 5.8,
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
				arg_77_0:Play421072020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1.var_.moveOldPos10145ui_story = arg_77_1.actors_["10145ui_story"].transform.localPosition
			end

			local var_80_0 = 0.001

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_0 then
				arg_77_1.actors_["10145ui_story"].transform.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos10145ui_story, Vector3.New(0, -1, -6.2), (arg_77_1.time_ - 0) / var_80_0)
				arg_77_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_77_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_77_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_77_1.actors_["10145ui_story"].transform.position).z)
				arg_77_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_77_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_77_1.actors_["10145ui_story"].transform.localEulerAngles = arg_77_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			if arg_77_1.time_ >= 0 + var_80_0 and arg_77_1.time_ < 0 + var_80_0 + arg_80_0 then
				arg_77_1.actors_["10145ui_story"].transform.localPosition = Vector3.New(0, -1, -6.2)
				arg_77_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_77_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_77_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_77_1.actors_["10145ui_story"].transform.position).z)
				arg_77_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_77_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_77_1.actors_["10145ui_story"].transform.localEulerAngles = arg_77_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			local var_80_1 = arg_77_1.actors_["10145ui_story"]

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 and not isNil(var_80_1) and arg_77_1.var_.characterEffect10145ui_story == nil then
				arg_77_1.var_.characterEffect10145ui_story = var_80_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_2 = 0.200000002980232

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_2 and not isNil(var_80_1) then
				if arg_77_1.var_.characterEffect10145ui_story and not isNil(var_80_1) then
					arg_77_1.var_.characterEffect10145ui_story.fillFlat = false
				end
			end

			if arg_77_1.time_ >= 0 + var_80_2 and arg_77_1.time_ < 0 + var_80_2 + arg_80_0 and not isNil(var_80_1) and arg_77_1.var_.characterEffect10145ui_story then
				arg_77_1.var_.characterEffect10145ui_story.fillFlat = false
			end

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/story10145/story10145action/10145action3_1")
			end

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_80_4 = 0
			local var_80_5 = 0.7

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_4 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				arg_77_1.leftNameTxt_.text = arg_77_1:FormatText(StoryNameCfg[1308].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_6 = arg_77_1:GetWordFromCfg(421072019)
				local var_80_7 = arg_77_1:FormatText(var_80_6.content)

				arg_77_1.text_.text = var_80_7

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_9 = 28 <= 0 and var_80_5 or var_80_5 * (utf8.len(var_80_7) / 28)

				if (28 <= 0 and var_80_5 or var_80_5 * (utf8.len(var_80_7) / 28)) > 0 and var_80_5 < var_80_9 then
					arg_77_1.talkMaxDuration = var_80_9

					if var_80_9 + var_80_4 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_9 + var_80_4
					end
				end

				arg_77_1.text_.text = var_80_7
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421072", "421072019", "story_v_out_421072.awb") ~= 0 then
					local var_80_10 = manager.audio:GetVoiceLength("story_v_out_421072", "421072019", "story_v_out_421072.awb") / 1000

					if var_80_10 + var_80_4 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_10 + var_80_4
					end

					if var_80_6.prefab_name ~= "" and arg_77_1.actors_[var_80_6.prefab_name] ~= nil then
						local var_80_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_6.prefab_name].transform, "story_v_out_421072", "421072019", "story_v_out_421072.awb")

						arg_77_1:RecordAudio("421072019", var_80_11)
						arg_77_1:RecordAudio("421072019", var_80_11)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_421072", "421072019", "story_v_out_421072.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_421072", "421072019", "story_v_out_421072.awb")
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
				actorName = "10145ui_story",
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
	Play421072020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 421072020
		arg_81_1.duration_ = 1.5

		local var_81_0 = {
			zh = 1.5,
			ja = 1.4
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
				arg_81_0:Play421072021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 and not isNil(arg_81_1.actors_["10145ui_story"]) and arg_81_1.var_.characterEffect10145ui_story == nil then
				arg_81_1.var_.characterEffect10145ui_story = arg_81_1.actors_["10145ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_0 = 0.200000002980232

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_0 and not isNil(arg_81_1.actors_["10145ui_story"]) then
				if arg_81_1.var_.characterEffect10145ui_story and not isNil(arg_81_1.actors_["10145ui_story"]) then
					arg_81_1.var_.characterEffect10145ui_story.fillFlat = true
					arg_81_1.var_.characterEffect10145ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_81_1.time_ - 0) / var_84_0)
				end
			end

			if arg_81_1.time_ >= 0 + var_84_0 and arg_81_1.time_ < 0 + var_84_0 + arg_84_0 and not isNil(arg_81_1.actors_["10145ui_story"]) and arg_81_1.var_.characterEffect10145ui_story then
				arg_81_1.var_.characterEffect10145ui_story.fillFlat = true
				arg_81_1.var_.characterEffect10145ui_story.fillRatio = 0.5
			end

			local var_84_1 = 0
			local var_84_2 = 0.1

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_1 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				arg_81_1.leftNameTxt_.text = arg_81_1:FormatText(StoryNameCfg[1320].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, true)
				arg_81_1.iconController_:SetSelectedState("hero")

				arg_81_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Jackson")

				arg_81_1.callingController_:SetSelectedState("normal")

				arg_81_1.keyicon_.color = Color.New(1, 1, 1)
				arg_81_1.icon_.color = Color.New(1, 1, 1)

				local var_84_3 = arg_81_1:GetWordFromCfg(421072020)
				local var_84_4 = arg_81_1:FormatText(var_84_3.content)

				arg_81_1.text_.text = var_84_4

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_6 = 4 <= 0 and var_84_2 or var_84_2 * (utf8.len(var_84_4) / 4)

				if (4 <= 0 and var_84_2 or var_84_2 * (utf8.len(var_84_4) / 4)) > 0 and var_84_2 < var_84_6 then
					arg_81_1.talkMaxDuration = var_84_6

					if var_84_6 + var_84_1 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_6 + var_84_1
					end
				end

				arg_81_1.text_.text = var_84_4
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421072", "421072020", "story_v_out_421072.awb") ~= 0 then
					local var_84_7 = manager.audio:GetVoiceLength("story_v_out_421072", "421072020", "story_v_out_421072.awb") / 1000

					if var_84_7 + var_84_1 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_7 + var_84_1
					end

					if var_84_3.prefab_name ~= "" and arg_81_1.actors_[var_84_3.prefab_name] ~= nil then
						local var_84_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_3.prefab_name].transform, "story_v_out_421072", "421072020", "story_v_out_421072.awb")

						arg_81_1:RecordAudio("421072020", var_84_8)
						arg_81_1:RecordAudio("421072020", var_84_8)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_421072", "421072020", "story_v_out_421072.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_421072", "421072020", "story_v_out_421072.awb")
				end

				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_9 = math.max(var_84_2, arg_81_1.talkMaxDuration)

			if var_84_1 <= arg_81_1.time_ and arg_81_1.time_ < var_84_1 + var_84_9 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_1) / var_84_9

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_1 + var_84_9 and arg_81_1.time_ < var_84_1 + var_84_9 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {}

		arg_81_1:InitPlayNodeList()
	end,
	Play421072021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 421072021
		arg_85_1.duration_ = 12.5

		local var_85_0 = {
			zh = 8.266,
			ja = 12.5
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
				arg_85_0:Play421072022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1.var_.moveOldPos10145ui_story = arg_85_1.actors_["10145ui_story"].transform.localPosition
			end

			local var_88_0 = 0.001

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_0 then
				arg_85_1.actors_["10145ui_story"].transform.localPosition = Vector3.Lerp(arg_85_1.var_.moveOldPos10145ui_story, Vector3.New(0, -1, -6.2), (arg_85_1.time_ - 0) / var_88_0)
				arg_85_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_85_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_85_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_85_1.actors_["10145ui_story"].transform.position).z)
				arg_85_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_85_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_85_1.actors_["10145ui_story"].transform.localEulerAngles = arg_85_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			if arg_85_1.time_ >= 0 + var_88_0 and arg_85_1.time_ < 0 + var_88_0 + arg_88_0 then
				arg_85_1.actors_["10145ui_story"].transform.localPosition = Vector3.New(0, -1, -6.2)
				arg_85_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_85_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_85_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_85_1.actors_["10145ui_story"].transform.position).z)
				arg_85_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_85_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_85_1.actors_["10145ui_story"].transform.localEulerAngles = arg_85_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			local var_88_1 = arg_85_1.actors_["10145ui_story"]

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 and not isNil(var_88_1) and arg_85_1.var_.characterEffect10145ui_story == nil then
				arg_85_1.var_.characterEffect10145ui_story = var_88_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_2 = 0.200000002980232

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_2 and not isNil(var_88_1) then
				if arg_85_1.var_.characterEffect10145ui_story and not isNil(var_88_1) then
					arg_85_1.var_.characterEffect10145ui_story.fillFlat = false
				end
			end

			if arg_85_1.time_ >= 0 + var_88_2 and arg_85_1.time_ < 0 + var_88_2 + arg_88_0 and not isNil(var_88_1) and arg_85_1.var_.characterEffect10145ui_story then
				arg_85_1.var_.characterEffect10145ui_story.fillFlat = false
			end

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/story10145/story10145action/10145action3_2")
			end

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/public_expression/expr_renzhen", "EmotionTimelineAnimator")
			end

			local var_88_4 = 0
			local var_88_5 = 1.2

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_4 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				arg_85_1.leftNameTxt_.text = arg_85_1:FormatText(StoryNameCfg[1308].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_6 = arg_85_1:GetWordFromCfg(421072021)
				local var_88_7 = arg_85_1:FormatText(var_88_6.content)

				arg_85_1.text_.text = var_88_7

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_9 = 48 <= 0 and var_88_5 or var_88_5 * (utf8.len(var_88_7) / 48)

				if (48 <= 0 and var_88_5 or var_88_5 * (utf8.len(var_88_7) / 48)) > 0 and var_88_5 < var_88_9 then
					arg_85_1.talkMaxDuration = var_88_9

					if var_88_9 + var_88_4 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_9 + var_88_4
					end
				end

				arg_85_1.text_.text = var_88_7
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421072", "421072021", "story_v_out_421072.awb") ~= 0 then
					local var_88_10 = manager.audio:GetVoiceLength("story_v_out_421072", "421072021", "story_v_out_421072.awb") / 1000

					if var_88_10 + var_88_4 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_10 + var_88_4
					end

					if var_88_6.prefab_name ~= "" and arg_85_1.actors_[var_88_6.prefab_name] ~= nil then
						local var_88_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_6.prefab_name].transform, "story_v_out_421072", "421072021", "story_v_out_421072.awb")

						arg_85_1:RecordAudio("421072021", var_88_11)
						arg_85_1:RecordAudio("421072021", var_88_11)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_421072", "421072021", "story_v_out_421072.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_421072", "421072021", "story_v_out_421072.awb")
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
				actorName = "10145ui_story",
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
	Play421072022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 421072022
		arg_89_1.duration_ = 16.27

		local var_89_0 = {
			zh = 10.166,
			ja = 16.266
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
				arg_89_0:Play421072023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 and not isNil(arg_89_1.actors_["10145ui_story"]) and arg_89_1.var_.characterEffect10145ui_story == nil then
				arg_89_1.var_.characterEffect10145ui_story = arg_89_1.actors_["10145ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_0 = 0.200000002980232

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_0 and not isNil(arg_89_1.actors_["10145ui_story"]) then
				if arg_89_1.var_.characterEffect10145ui_story and not isNil(arg_89_1.actors_["10145ui_story"]) then
					arg_89_1.var_.characterEffect10145ui_story.fillFlat = true
					arg_89_1.var_.characterEffect10145ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_89_1.time_ - 0) / var_92_0)
				end
			end

			if arg_89_1.time_ >= 0 + var_92_0 and arg_89_1.time_ < 0 + var_92_0 + arg_92_0 and not isNil(arg_89_1.actors_["10145ui_story"]) and arg_89_1.var_.characterEffect10145ui_story then
				arg_89_1.var_.characterEffect10145ui_story.fillFlat = true
				arg_89_1.var_.characterEffect10145ui_story.fillRatio = 0.5
			end

			local var_92_1 = 0
			local var_92_2 = 1

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_1 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				arg_89_1.leftNameTxt_.text = arg_89_1:FormatText(StoryNameCfg[1320].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, true)
				arg_89_1.iconController_:SetSelectedState("hero")

				arg_89_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Jackson")

				arg_89_1.callingController_:SetSelectedState("normal")

				arg_89_1.keyicon_.color = Color.New(1, 1, 1)
				arg_89_1.icon_.color = Color.New(1, 1, 1)

				local var_92_3 = arg_89_1:GetWordFromCfg(421072022)
				local var_92_4 = arg_89_1:FormatText(var_92_3.content)

				arg_89_1.text_.text = var_92_4

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_6 = 40 <= 0 and var_92_2 or var_92_2 * (utf8.len(var_92_4) / 40)

				if (40 <= 0 and var_92_2 or var_92_2 * (utf8.len(var_92_4) / 40)) > 0 and var_92_2 < var_92_6 then
					arg_89_1.talkMaxDuration = var_92_6

					if var_92_6 + var_92_1 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_6 + var_92_1
					end
				end

				arg_89_1.text_.text = var_92_4
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421072", "421072022", "story_v_out_421072.awb") ~= 0 then
					local var_92_7 = manager.audio:GetVoiceLength("story_v_out_421072", "421072022", "story_v_out_421072.awb") / 1000

					if var_92_7 + var_92_1 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_7 + var_92_1
					end

					if var_92_3.prefab_name ~= "" and arg_89_1.actors_[var_92_3.prefab_name] ~= nil then
						local var_92_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_3.prefab_name].transform, "story_v_out_421072", "421072022", "story_v_out_421072.awb")

						arg_89_1:RecordAudio("421072022", var_92_8)
						arg_89_1:RecordAudio("421072022", var_92_8)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_421072", "421072022", "story_v_out_421072.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_421072", "421072022", "story_v_out_421072.awb")
				end

				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_9 = math.max(var_92_2, arg_89_1.talkMaxDuration)

			if var_92_1 <= arg_89_1.time_ and arg_89_1.time_ < var_92_1 + var_92_9 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_1) / var_92_9

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_1 + var_92_9 and arg_89_1.time_ < var_92_1 + var_92_9 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {}

		arg_89_1:InitPlayNodeList()
	end,
	Play421072023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 421072023
		arg_93_1.duration_ = 5.13

		local var_93_0 = {
			zh = 4.266,
			ja = 5.133
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
				arg_93_0:Play421072024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1.var_.moveOldPos10145ui_story = arg_93_1.actors_["10145ui_story"].transform.localPosition
			end

			local var_96_0 = 0.001

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_0 then
				arg_93_1.actors_["10145ui_story"].transform.localPosition = Vector3.Lerp(arg_93_1.var_.moveOldPos10145ui_story, Vector3.New(0, -1, -6.2), (arg_93_1.time_ - 0) / var_96_0)
				arg_93_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_93_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_93_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_93_1.actors_["10145ui_story"].transform.position).z)
				arg_93_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_93_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_93_1.actors_["10145ui_story"].transform.localEulerAngles = arg_93_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			if arg_93_1.time_ >= 0 + var_96_0 and arg_93_1.time_ < 0 + var_96_0 + arg_96_0 then
				arg_93_1.actors_["10145ui_story"].transform.localPosition = Vector3.New(0, -1, -6.2)
				arg_93_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_93_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_93_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_93_1.actors_["10145ui_story"].transform.position).z)
				arg_93_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_93_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_93_1.actors_["10145ui_story"].transform.localEulerAngles = arg_93_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			local var_96_1 = arg_93_1.actors_["10145ui_story"]

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 and not isNil(var_96_1) and arg_93_1.var_.characterEffect10145ui_story == nil then
				arg_93_1.var_.characterEffect10145ui_story = var_96_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_2 = 0.200000002980232

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_2 and not isNil(var_96_1) then
				if arg_93_1.var_.characterEffect10145ui_story and not isNil(var_96_1) then
					arg_93_1.var_.characterEffect10145ui_story.fillFlat = false
				end
			end

			if arg_93_1.time_ >= 0 + var_96_2 and arg_93_1.time_ < 0 + var_96_2 + arg_96_0 and not isNil(var_96_1) and arg_93_1.var_.characterEffect10145ui_story then
				arg_93_1.var_.characterEffect10145ui_story.fillFlat = false
			end

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/story10145/story10145action/10145action4_1")
			end

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_96_4 = 0
			local var_96_5 = 0.5

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_4 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				arg_93_1.leftNameTxt_.text = arg_93_1:FormatText(StoryNameCfg[1308].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_6 = arg_93_1:GetWordFromCfg(421072023)
				local var_96_7 = arg_93_1:FormatText(var_96_6.content)

				arg_93_1.text_.text = var_96_7

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_9 = 20 <= 0 and var_96_5 or var_96_5 * (utf8.len(var_96_7) / 20)

				if (20 <= 0 and var_96_5 or var_96_5 * (utf8.len(var_96_7) / 20)) > 0 and var_96_5 < var_96_9 then
					arg_93_1.talkMaxDuration = var_96_9

					if var_96_9 + var_96_4 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_9 + var_96_4
					end
				end

				arg_93_1.text_.text = var_96_7
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421072", "421072023", "story_v_out_421072.awb") ~= 0 then
					local var_96_10 = manager.audio:GetVoiceLength("story_v_out_421072", "421072023", "story_v_out_421072.awb") / 1000

					if var_96_10 + var_96_4 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_10 + var_96_4
					end

					if var_96_6.prefab_name ~= "" and arg_93_1.actors_[var_96_6.prefab_name] ~= nil then
						local var_96_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_6.prefab_name].transform, "story_v_out_421072", "421072023", "story_v_out_421072.awb")

						arg_93_1:RecordAudio("421072023", var_96_11)
						arg_93_1:RecordAudio("421072023", var_96_11)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_421072", "421072023", "story_v_out_421072.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_421072", "421072023", "story_v_out_421072.awb")
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

		arg_93_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10145ui_story",
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
	Play421072024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 421072024
		arg_97_1.duration_ = 11.1

		local var_97_0 = {
			zh = 8.333,
			ja = 11.1
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
				arg_97_0:Play421072025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 and not isNil(arg_97_1.actors_["10145ui_story"]) and arg_97_1.var_.characterEffect10145ui_story == nil then
				arg_97_1.var_.characterEffect10145ui_story = arg_97_1.actors_["10145ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_0 = 0.200000002980232

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_0 and not isNil(arg_97_1.actors_["10145ui_story"]) then
				if arg_97_1.var_.characterEffect10145ui_story and not isNil(arg_97_1.actors_["10145ui_story"]) then
					arg_97_1.var_.characterEffect10145ui_story.fillFlat = true
					arg_97_1.var_.characterEffect10145ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_97_1.time_ - 0) / var_100_0)
				end
			end

			if arg_97_1.time_ >= 0 + var_100_0 and arg_97_1.time_ < 0 + var_100_0 + arg_100_0 and not isNil(arg_97_1.actors_["10145ui_story"]) and arg_97_1.var_.characterEffect10145ui_story then
				arg_97_1.var_.characterEffect10145ui_story.fillFlat = true
				arg_97_1.var_.characterEffect10145ui_story.fillRatio = 0.5
			end

			local var_100_1 = 0
			local var_100_2 = 0.65

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_1 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				arg_97_1.leftNameTxt_.text = arg_97_1:FormatText(StoryNameCfg[1320].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, true)
				arg_97_1.iconController_:SetSelectedState("hero")

				arg_97_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Jackson")

				arg_97_1.callingController_:SetSelectedState("normal")

				arg_97_1.keyicon_.color = Color.New(1, 1, 1)
				arg_97_1.icon_.color = Color.New(1, 1, 1)

				local var_100_3 = arg_97_1:GetWordFromCfg(421072024)
				local var_100_4 = arg_97_1:FormatText(var_100_3.content)

				arg_97_1.text_.text = var_100_4

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_6 = 26 <= 0 and var_100_2 or var_100_2 * (utf8.len(var_100_4) / 26)

				if (26 <= 0 and var_100_2 or var_100_2 * (utf8.len(var_100_4) / 26)) > 0 and var_100_2 < var_100_6 then
					arg_97_1.talkMaxDuration = var_100_6

					if var_100_6 + var_100_1 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_6 + var_100_1
					end
				end

				arg_97_1.text_.text = var_100_4
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421072", "421072024", "story_v_out_421072.awb") ~= 0 then
					local var_100_7 = manager.audio:GetVoiceLength("story_v_out_421072", "421072024", "story_v_out_421072.awb") / 1000

					if var_100_7 + var_100_1 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_7 + var_100_1
					end

					if var_100_3.prefab_name ~= "" and arg_97_1.actors_[var_100_3.prefab_name] ~= nil then
						local var_100_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_3.prefab_name].transform, "story_v_out_421072", "421072024", "story_v_out_421072.awb")

						arg_97_1:RecordAudio("421072024", var_100_8)
						arg_97_1:RecordAudio("421072024", var_100_8)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_421072", "421072024", "story_v_out_421072.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_421072", "421072024", "story_v_out_421072.awb")
				end

				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_9 = math.max(var_100_2, arg_97_1.talkMaxDuration)

			if var_100_1 <= arg_97_1.time_ and arg_97_1.time_ < var_100_1 + var_100_9 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_1) / var_100_9

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_1 + var_100_9 and arg_97_1.time_ < var_100_1 + var_100_9 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {}

		arg_97_1:InitPlayNodeList()
	end,
	Play421072025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 421072025
		arg_101_1.duration_ = 17.23

		local var_101_0 = {
			zh = 14.2,
			ja = 17.233
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
				arg_101_0:Play421072026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = 1.3

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				arg_101_1.leftNameTxt_.text = arg_101_1:FormatText(StoryNameCfg[1320].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, true)
				arg_101_1.iconController_:SetSelectedState("hero")

				arg_101_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Jackson")

				arg_101_1.callingController_:SetSelectedState("normal")

				arg_101_1.keyicon_.color = Color.New(1, 1, 1)
				arg_101_1.icon_.color = Color.New(1, 1, 1)

				local var_104_1 = arg_101_1:GetWordFromCfg(421072025)
				local var_104_2 = arg_101_1:FormatText(var_104_1.content)

				arg_101_1.text_.text = var_104_2

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_4 = 52 <= 0 and var_104_0 or var_104_0 * (utf8.len(var_104_2) / 52)

				if (52 <= 0 and var_104_0 or var_104_0 * (utf8.len(var_104_2) / 52)) > 0 and var_104_0 < var_104_4 then
					arg_101_1.talkMaxDuration = var_104_4

					if var_104_4 + 0 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_4 + 0
					end
				end

				arg_101_1.text_.text = var_104_2
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421072", "421072025", "story_v_out_421072.awb") ~= 0 then
					local var_104_5 = manager.audio:GetVoiceLength("story_v_out_421072", "421072025", "story_v_out_421072.awb") / 1000

					if var_104_5 + 0 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_5 + 0
					end

					if var_104_1.prefab_name ~= "" and arg_101_1.actors_[var_104_1.prefab_name] ~= nil then
						local var_104_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_1.prefab_name].transform, "story_v_out_421072", "421072025", "story_v_out_421072.awb")

						arg_101_1:RecordAudio("421072025", var_104_6)
						arg_101_1:RecordAudio("421072025", var_104_6)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_421072", "421072025", "story_v_out_421072.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_421072", "421072025", "story_v_out_421072.awb")
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
	Play421072026 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 421072026
		arg_105_1.duration_ = 2

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play421072027(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1.var_.moveOldPos10145ui_story = arg_105_1.actors_["10145ui_story"].transform.localPosition
			end

			local var_108_0 = 0.001

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_0 then
				arg_105_1.actors_["10145ui_story"].transform.localPosition = Vector3.Lerp(arg_105_1.var_.moveOldPos10145ui_story, Vector3.New(0, -1, -6.2), (arg_105_1.time_ - 0) / var_108_0)
				arg_105_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_105_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_105_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_105_1.actors_["10145ui_story"].transform.position).z)
				arg_105_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_105_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_105_1.actors_["10145ui_story"].transform.localEulerAngles = arg_105_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			if arg_105_1.time_ >= 0 + var_108_0 and arg_105_1.time_ < 0 + var_108_0 + arg_108_0 then
				arg_105_1.actors_["10145ui_story"].transform.localPosition = Vector3.New(0, -1, -6.2)
				arg_105_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_105_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_105_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_105_1.actors_["10145ui_story"].transform.position).z)
				arg_105_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_105_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_105_1.actors_["10145ui_story"].transform.localEulerAngles = arg_105_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			local var_108_1 = arg_105_1.actors_["10145ui_story"]

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 and not isNil(var_108_1) and arg_105_1.var_.characterEffect10145ui_story == nil then
				arg_105_1.var_.characterEffect10145ui_story = var_108_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_2 = 0.200000002980232

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_2 and not isNil(var_108_1) then
				if arg_105_1.var_.characterEffect10145ui_story and not isNil(var_108_1) then
					arg_105_1.var_.characterEffect10145ui_story.fillFlat = false
				end
			end

			if arg_105_1.time_ >= 0 + var_108_2 and arg_105_1.time_ < 0 + var_108_2 + arg_108_0 and not isNil(var_108_1) and arg_105_1.var_.characterEffect10145ui_story then
				arg_105_1.var_.characterEffect10145ui_story.fillFlat = false
			end

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/story10145/story10145action/10145action4_2")
			end

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/public_expression/expr_renzhen", "EmotionTimelineAnimator")
			end

			local var_108_4 = 0
			local var_108_5 = 0.1

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= var_108_4 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				arg_105_1.leftNameTxt_.text = arg_105_1:FormatText(StoryNameCfg[1308].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_6 = arg_105_1:GetWordFromCfg(421072026)
				local var_108_7 = arg_105_1:FormatText(var_108_6.content)

				arg_105_1.text_.text = var_108_7

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_9 = 4 <= 0 and var_108_5 or var_108_5 * (utf8.len(var_108_7) / 4)

				if (4 <= 0 and var_108_5 or var_108_5 * (utf8.len(var_108_7) / 4)) > 0 and var_108_5 < var_108_9 then
					arg_105_1.talkMaxDuration = var_108_9

					if var_108_9 + var_108_4 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_9 + var_108_4
					end
				end

				arg_105_1.text_.text = var_108_7
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421072", "421072026", "story_v_out_421072.awb") ~= 0 then
					local var_108_10 = manager.audio:GetVoiceLength("story_v_out_421072", "421072026", "story_v_out_421072.awb") / 1000

					if var_108_10 + var_108_4 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_10 + var_108_4
					end

					if var_108_6.prefab_name ~= "" and arg_105_1.actors_[var_108_6.prefab_name] ~= nil then
						local var_108_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_6.prefab_name].transform, "story_v_out_421072", "421072026", "story_v_out_421072.awb")

						arg_105_1:RecordAudio("421072026", var_108_11)
						arg_105_1:RecordAudio("421072026", var_108_11)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_421072", "421072026", "story_v_out_421072.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_421072", "421072026", "story_v_out_421072.awb")
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
				actorName = "10145ui_story",
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
	Play421072027 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 421072027
		arg_109_1.duration_ = 5

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
		end

		function arg_109_1.playNext_(arg_111_0)
			if arg_111_0 == 1 then
				arg_109_0:Play421072028(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1.var_.moveOldPos10145ui_story = arg_109_1.actors_["10145ui_story"].transform.localPosition
			end

			local var_112_0 = 0.001

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_0 then
				arg_109_1.actors_["10145ui_story"].transform.localPosition = Vector3.Lerp(arg_109_1.var_.moveOldPos10145ui_story, Vector3.New(0, 100, 0), (arg_109_1.time_ - 0) / var_112_0)
				arg_109_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_109_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_109_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_109_1.actors_["10145ui_story"].transform.position).z)
				arg_109_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_109_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_109_1.actors_["10145ui_story"].transform.localEulerAngles = arg_109_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			if arg_109_1.time_ >= 0 + var_112_0 and arg_109_1.time_ < 0 + var_112_0 + arg_112_0 then
				arg_109_1.actors_["10145ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_109_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_109_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_109_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_109_1.actors_["10145ui_story"].transform.position).z)
				arg_109_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_109_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_109_1.actors_["10145ui_story"].transform.localEulerAngles = arg_109_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			local var_112_1 = 0
			local var_112_2 = 0.75

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= var_112_1 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, false)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_3 = arg_109_1:FormatText(arg_109_1:GetWordFromCfg(421072027).content)

				arg_109_1.text_.text = var_112_3

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_5 = 30 <= 0 and var_112_2 or var_112_2 * (utf8.len(var_112_3) / 30)

				if (30 <= 0 and var_112_2 or var_112_2 * (utf8.len(var_112_3) / 30)) > 0 and var_112_2 < var_112_5 then
					arg_109_1.talkMaxDuration = var_112_5

					if var_112_5 + var_112_1 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_5 + var_112_1
					end
				end

				arg_109_1.text_.text = var_112_3
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)
				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_6 = math.max(var_112_2, arg_109_1.talkMaxDuration)

			if var_112_1 <= arg_109_1.time_ and arg_109_1.time_ < var_112_1 + var_112_6 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_1) / var_112_6

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_1 + var_112_6 and arg_109_1.time_ < var_112_1 + var_112_6 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10145ui_story",
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
	Play421072028 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 421072028
		arg_113_1.duration_ = 6.23

		local var_113_0 = {
			zh = 5.1,
			ja = 6.233
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
				arg_113_0:Play421072029(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			local var_116_0 = 0.35

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				arg_113_1.leftNameTxt_.text = arg_113_1:FormatText(StoryNameCfg[1320].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, true)
				arg_113_1.iconController_:SetSelectedState("hero")

				arg_113_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Jackson")

				arg_113_1.callingController_:SetSelectedState("normal")

				arg_113_1.keyicon_.color = Color.New(1, 1, 1)
				arg_113_1.icon_.color = Color.New(1, 1, 1)

				local var_116_1 = arg_113_1:GetWordFromCfg(421072028)
				local var_116_2 = arg_113_1:FormatText(var_116_1.content)

				arg_113_1.text_.text = var_116_2

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_4 = 14 <= 0 and var_116_0 or var_116_0 * (utf8.len(var_116_2) / 14)

				if (14 <= 0 and var_116_0 or var_116_0 * (utf8.len(var_116_2) / 14)) > 0 and var_116_0 < var_116_4 then
					arg_113_1.talkMaxDuration = var_116_4

					if var_116_4 + 0 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_4 + 0
					end
				end

				arg_113_1.text_.text = var_116_2
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421072", "421072028", "story_v_out_421072.awb") ~= 0 then
					local var_116_5 = manager.audio:GetVoiceLength("story_v_out_421072", "421072028", "story_v_out_421072.awb") / 1000

					if var_116_5 + 0 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_5 + 0
					end

					if var_116_1.prefab_name ~= "" and arg_113_1.actors_[var_116_1.prefab_name] ~= nil then
						local var_116_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_1.prefab_name].transform, "story_v_out_421072", "421072028", "story_v_out_421072.awb")

						arg_113_1:RecordAudio("421072028", var_116_6)
						arg_113_1:RecordAudio("421072028", var_116_6)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_out_421072", "421072028", "story_v_out_421072.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_out_421072", "421072028", "story_v_out_421072.awb")
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
	Play421072029 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 421072029
		arg_117_1.duration_ = 6.5

		local var_117_0 = {
			zh = 4.333,
			ja = 6.5
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
				arg_117_0:Play421072030(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1.var_.moveOldPos1047ui_story = arg_117_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_120_0 = 0.001

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_0 then
				arg_117_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_117_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_117_1.time_ - 0) / var_120_0)
				arg_117_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_117_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_117_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_117_1.actors_["1047ui_story"].transform.position).z)
				arg_117_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_117_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_117_1.actors_["1047ui_story"].transform.localEulerAngles = arg_117_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_117_1.time_ >= 0 + var_120_0 and arg_117_1.time_ < 0 + var_120_0 + arg_120_0 then
				arg_117_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_117_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_117_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_117_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_117_1.actors_["1047ui_story"].transform.position).z)
				arg_117_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_117_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_117_1.actors_["1047ui_story"].transform.localEulerAngles = arg_117_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_120_1 = arg_117_1.actors_["10145ui_story"].transform

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1.var_.moveOldPos10145ui_story = var_120_1.localPosition
			end

			local var_120_2 = 0.001

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_2 then
				var_120_1.localPosition = Vector3.Lerp(arg_117_1.var_.moveOldPos10145ui_story, Vector3.New(0, 100, 0), (arg_117_1.time_ - 0) / var_120_2)
				var_120_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_120_1.position).x, (manager.ui.mainCamera.transform.position - var_120_1.position).y, (manager.ui.mainCamera.transform.position - var_120_1.position).z)
				var_120_1.localEulerAngles.z = 0
				var_120_1.localEulerAngles.x = 0
				var_120_1.localEulerAngles = var_120_1.localEulerAngles
			end

			if arg_117_1.time_ >= 0 + var_120_2 and arg_117_1.time_ < 0 + var_120_2 + arg_120_0 then
				var_120_1.localPosition = Vector3.New(0, 100, 0)
				var_120_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_120_1.position).x, (manager.ui.mainCamera.transform.position - var_120_1.position).y, (manager.ui.mainCamera.transform.position - var_120_1.position).z)
				var_120_1.localEulerAngles.z = 0
				var_120_1.localEulerAngles.x = 0
				var_120_1.localEulerAngles = var_120_1.localEulerAngles
			end

			local var_120_3 = arg_117_1.actors_["1047ui_story"]

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 and not isNil(var_120_3) and arg_117_1.var_.characterEffect1047ui_story == nil then
				arg_117_1.var_.characterEffect1047ui_story = var_120_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_120_4 = 0.200000002980232

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_4 and not isNil(var_120_3) then
				if arg_117_1.var_.characterEffect1047ui_story and not isNil(var_120_3) then
					arg_117_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_117_1.time_ >= 0 + var_120_4 and arg_117_1.time_ < 0 + var_120_4 + arg_120_0 and not isNil(var_120_3) and arg_117_1.var_.characterEffect1047ui_story then
				arg_117_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_120_6 = 0
			local var_120_7 = 0.475

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= var_120_6 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				arg_117_1.leftNameTxt_.text = arg_117_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_8 = arg_117_1:GetWordFromCfg(421072029)
				local var_120_9 = arg_117_1:FormatText(var_120_8.content)

				arg_117_1.text_.text = var_120_9

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_11 = 19 <= 0 and var_120_7 or var_120_7 * (utf8.len(var_120_9) / 19)

				if (19 <= 0 and var_120_7 or var_120_7 * (utf8.len(var_120_9) / 19)) > 0 and var_120_7 < var_120_11 then
					arg_117_1.talkMaxDuration = var_120_11

					if var_120_11 + var_120_6 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_11 + var_120_6
					end
				end

				arg_117_1.text_.text = var_120_9
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421072", "421072029", "story_v_out_421072.awb") ~= 0 then
					local var_120_12 = manager.audio:GetVoiceLength("story_v_out_421072", "421072029", "story_v_out_421072.awb") / 1000

					if var_120_12 + var_120_6 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_12 + var_120_6
					end

					if var_120_8.prefab_name ~= "" and arg_117_1.actors_[var_120_8.prefab_name] ~= nil then
						local var_120_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_8.prefab_name].transform, "story_v_out_421072", "421072029", "story_v_out_421072.awb")

						arg_117_1:RecordAudio("421072029", var_120_13)
						arg_117_1:RecordAudio("421072029", var_120_13)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_out_421072", "421072029", "story_v_out_421072.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_out_421072", "421072029", "story_v_out_421072.awb")
				end

				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_14 = math.max(var_120_7, arg_117_1.talkMaxDuration)

			if var_120_6 <= arg_117_1.time_ and arg_117_1.time_ < var_120_6 + var_120_14 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_6) / var_120_14

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_6 + var_120_14 and arg_117_1.time_ < var_120_6 + var_120_14 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10145ui_story",
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
	Play421072030 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 421072030
		arg_121_1.duration_ = 5.83

		local var_121_0 = {
			zh = 5,
			ja = 5.833
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
				arg_121_0:Play421072031(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 and not isNil(arg_121_1.actors_["1047ui_story"]) and arg_121_1.var_.characterEffect1047ui_story == nil then
				arg_121_1.var_.characterEffect1047ui_story = arg_121_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_0 = 0.200000002980232

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_0 and not isNil(arg_121_1.actors_["1047ui_story"]) then
				if arg_121_1.var_.characterEffect1047ui_story and not isNil(arg_121_1.actors_["1047ui_story"]) then
					arg_121_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_121_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_121_1.time_ - 0) / var_124_0)
				end
			end

			if arg_121_1.time_ >= 0 + var_124_0 and arg_121_1.time_ < 0 + var_124_0 + arg_124_0 and not isNil(arg_121_1.actors_["1047ui_story"]) and arg_121_1.var_.characterEffect1047ui_story then
				arg_121_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_121_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_124_1 = 0
			local var_124_2 = 0.325

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= var_124_1 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				arg_121_1.leftNameTxt_.text = arg_121_1:FormatText(StoryNameCfg[1320].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, true)
				arg_121_1.iconController_:SetSelectedState("hero")

				arg_121_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Jackson")

				arg_121_1.callingController_:SetSelectedState("normal")

				arg_121_1.keyicon_.color = Color.New(1, 1, 1)
				arg_121_1.icon_.color = Color.New(1, 1, 1)

				local var_124_3 = arg_121_1:GetWordFromCfg(421072030)
				local var_124_4 = arg_121_1:FormatText(var_124_3.content)

				arg_121_1.text_.text = var_124_4

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_6 = 13 <= 0 and var_124_2 or var_124_2 * (utf8.len(var_124_4) / 13)

				if (13 <= 0 and var_124_2 or var_124_2 * (utf8.len(var_124_4) / 13)) > 0 and var_124_2 < var_124_6 then
					arg_121_1.talkMaxDuration = var_124_6

					if var_124_6 + var_124_1 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_6 + var_124_1
					end
				end

				arg_121_1.text_.text = var_124_4
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421072", "421072030", "story_v_out_421072.awb") ~= 0 then
					local var_124_7 = manager.audio:GetVoiceLength("story_v_out_421072", "421072030", "story_v_out_421072.awb") / 1000

					if var_124_7 + var_124_1 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_7 + var_124_1
					end

					if var_124_3.prefab_name ~= "" and arg_121_1.actors_[var_124_3.prefab_name] ~= nil then
						local var_124_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_3.prefab_name].transform, "story_v_out_421072", "421072030", "story_v_out_421072.awb")

						arg_121_1:RecordAudio("421072030", var_124_8)
						arg_121_1:RecordAudio("421072030", var_124_8)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_out_421072", "421072030", "story_v_out_421072.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_out_421072", "421072030", "story_v_out_421072.awb")
				end

				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_9 = math.max(var_124_2, arg_121_1.talkMaxDuration)

			if var_124_1 <= arg_121_1.time_ and arg_121_1.time_ < var_124_1 + var_124_9 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_1) / var_124_9

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_1 + var_124_9 and arg_121_1.time_ < var_124_1 + var_124_9 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {}

		arg_121_1:InitPlayNodeList()
	end,
	Play421072031 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 421072031
		arg_125_1.duration_ = 8.73

		local var_125_0 = {
			zh = 5.366,
			ja = 8.733
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
				arg_125_0:Play421072032(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1.var_.moveOldPos1047ui_story = arg_125_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_128_0 = 0.001

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_0 then
				arg_125_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_125_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_125_1.time_ - 0) / var_128_0)
				arg_125_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_125_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_125_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_125_1.actors_["1047ui_story"].transform.position).z)
				arg_125_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_125_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_125_1.actors_["1047ui_story"].transform.localEulerAngles = arg_125_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_125_1.time_ >= 0 + var_128_0 and arg_125_1.time_ < 0 + var_128_0 + arg_128_0 then
				arg_125_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_125_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_125_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_125_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_125_1.actors_["1047ui_story"].transform.position).z)
				arg_125_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_125_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_125_1.actors_["1047ui_story"].transform.localEulerAngles = arg_125_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_128_1 = arg_125_1.actors_["1047ui_story"]

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 and not isNil(var_128_1) and arg_125_1.var_.characterEffect1047ui_story == nil then
				arg_125_1.var_.characterEffect1047ui_story = var_128_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_2 = 0.200000002980232

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_2 and not isNil(var_128_1) then
				if arg_125_1.var_.characterEffect1047ui_story and not isNil(var_128_1) then
					arg_125_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_125_1.time_ >= 0 + var_128_2 and arg_125_1.time_ < 0 + var_128_2 + arg_128_0 and not isNil(var_128_1) and arg_125_1.var_.characterEffect1047ui_story then
				arg_125_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action4_1")
			end

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_128_4 = 0
			local var_128_5 = 0.65

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= var_128_4 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				arg_125_1.leftNameTxt_.text = arg_125_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_6 = arg_125_1:GetWordFromCfg(421072031)
				local var_128_7 = arg_125_1:FormatText(var_128_6.content)

				arg_125_1.text_.text = var_128_7

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_9 = 26 <= 0 and var_128_5 or var_128_5 * (utf8.len(var_128_7) / 26)

				if (26 <= 0 and var_128_5 or var_128_5 * (utf8.len(var_128_7) / 26)) > 0 and var_128_5 < var_128_9 then
					arg_125_1.talkMaxDuration = var_128_9

					if var_128_9 + var_128_4 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_9 + var_128_4
					end
				end

				arg_125_1.text_.text = var_128_7
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421072", "421072031", "story_v_out_421072.awb") ~= 0 then
					local var_128_10 = manager.audio:GetVoiceLength("story_v_out_421072", "421072031", "story_v_out_421072.awb") / 1000

					if var_128_10 + var_128_4 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_10 + var_128_4
					end

					if var_128_6.prefab_name ~= "" and arg_125_1.actors_[var_128_6.prefab_name] ~= nil then
						local var_128_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_125_1.actors_[var_128_6.prefab_name].transform, "story_v_out_421072", "421072031", "story_v_out_421072.awb")

						arg_125_1:RecordAudio("421072031", var_128_11)
						arg_125_1:RecordAudio("421072031", var_128_11)
					else
						arg_125_1:AudioAction("play", "voice", "story_v_out_421072", "421072031", "story_v_out_421072.awb")
					end

					arg_125_1:RecordHistoryTalkVoice("story_v_out_421072", "421072031", "story_v_out_421072.awb")
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
				actorName = "1047ui_story",
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
	Play421072032 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 421072032
		arg_129_1.duration_ = 14.7

		local var_129_0 = {
			zh = 10.533,
			ja = 14.7
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
				arg_129_0:Play421072033(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 and not isNil(arg_129_1.actors_["1047ui_story"]) and arg_129_1.var_.characterEffect1047ui_story == nil then
				arg_129_1.var_.characterEffect1047ui_story = arg_129_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_132_0 = 0.200000002980232

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_0 and not isNil(arg_129_1.actors_["1047ui_story"]) then
				if arg_129_1.var_.characterEffect1047ui_story and not isNil(arg_129_1.actors_["1047ui_story"]) then
					arg_129_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_129_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_129_1.time_ - 0) / var_132_0)
				end
			end

			if arg_129_1.time_ >= 0 + var_132_0 and arg_129_1.time_ < 0 + var_132_0 + arg_132_0 and not isNil(arg_129_1.actors_["1047ui_story"]) and arg_129_1.var_.characterEffect1047ui_story then
				arg_129_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_129_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_132_1 = 0
			local var_132_2 = 0.95

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= var_132_1 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				arg_129_1.leftNameTxt_.text = arg_129_1:FormatText(StoryNameCfg[1320].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, true)
				arg_129_1.iconController_:SetSelectedState("hero")

				arg_129_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Jackson")

				arg_129_1.callingController_:SetSelectedState("normal")

				arg_129_1.keyicon_.color = Color.New(1, 1, 1)
				arg_129_1.icon_.color = Color.New(1, 1, 1)

				local var_132_3 = arg_129_1:GetWordFromCfg(421072032)
				local var_132_4 = arg_129_1:FormatText(var_132_3.content)

				arg_129_1.text_.text = var_132_4

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_6 = 38 <= 0 and var_132_2 or var_132_2 * (utf8.len(var_132_4) / 38)

				if (38 <= 0 and var_132_2 or var_132_2 * (utf8.len(var_132_4) / 38)) > 0 and var_132_2 < var_132_6 then
					arg_129_1.talkMaxDuration = var_132_6

					if var_132_6 + var_132_1 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_6 + var_132_1
					end
				end

				arg_129_1.text_.text = var_132_4
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421072", "421072032", "story_v_out_421072.awb") ~= 0 then
					local var_132_7 = manager.audio:GetVoiceLength("story_v_out_421072", "421072032", "story_v_out_421072.awb") / 1000

					if var_132_7 + var_132_1 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_7 + var_132_1
					end

					if var_132_3.prefab_name ~= "" and arg_129_1.actors_[var_132_3.prefab_name] ~= nil then
						local var_132_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_3.prefab_name].transform, "story_v_out_421072", "421072032", "story_v_out_421072.awb")

						arg_129_1:RecordAudio("421072032", var_132_8)
						arg_129_1:RecordAudio("421072032", var_132_8)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_out_421072", "421072032", "story_v_out_421072.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_out_421072", "421072032", "story_v_out_421072.awb")
				end

				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_9 = math.max(var_132_2, arg_129_1.talkMaxDuration)

			if var_132_1 <= arg_129_1.time_ and arg_129_1.time_ < var_132_1 + var_132_9 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_1) / var_132_9

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_1 + var_132_9 and arg_129_1.time_ < var_132_1 + var_132_9 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {}

		arg_129_1:InitPlayNodeList()
	end,
	Play421072033 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 421072033
		arg_133_1.duration_ = 5

		local var_133_0 = {
			zh = 4.233,
			ja = 5
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
				arg_133_0:Play421072034(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1.var_.moveOldPos1047ui_story = arg_133_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_136_0 = 0.001

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_0 then
				arg_133_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_133_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_133_1.time_ - 0) / var_136_0)
				arg_133_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_133_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_133_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_133_1.actors_["1047ui_story"].transform.position).z)
				arg_133_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_133_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_133_1.actors_["1047ui_story"].transform.localEulerAngles = arg_133_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_133_1.time_ >= 0 + var_136_0 and arg_133_1.time_ < 0 + var_136_0 + arg_136_0 then
				arg_133_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_133_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_133_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_133_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_133_1.actors_["1047ui_story"].transform.position).z)
				arg_133_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_133_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_133_1.actors_["1047ui_story"].transform.localEulerAngles = arg_133_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_136_1 = arg_133_1.actors_["1047ui_story"]

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 and not isNil(var_136_1) and arg_133_1.var_.characterEffect1047ui_story == nil then
				arg_133_1.var_.characterEffect1047ui_story = var_136_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_2 = 0.200000002980232

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_2 and not isNil(var_136_1) then
				if arg_133_1.var_.characterEffect1047ui_story and not isNil(var_136_1) then
					arg_133_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_133_1.time_ >= 0 + var_136_2 and arg_133_1.time_ < 0 + var_136_2 + arg_136_0 and not isNil(var_136_1) and arg_133_1.var_.characterEffect1047ui_story then
				arg_133_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action4_2")
			end

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_136_4 = 0
			local var_136_5 = 0.375

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= var_136_4 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				arg_133_1.leftNameTxt_.text = arg_133_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_6 = arg_133_1:GetWordFromCfg(421072033)
				local var_136_7 = arg_133_1:FormatText(var_136_6.content)

				arg_133_1.text_.text = var_136_7

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_9 = 15 <= 0 and var_136_5 or var_136_5 * (utf8.len(var_136_7) / 15)

				if (15 <= 0 and var_136_5 or var_136_5 * (utf8.len(var_136_7) / 15)) > 0 and var_136_5 < var_136_9 then
					arg_133_1.talkMaxDuration = var_136_9

					if var_136_9 + var_136_4 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_9 + var_136_4
					end
				end

				arg_133_1.text_.text = var_136_7
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421072", "421072033", "story_v_out_421072.awb") ~= 0 then
					local var_136_10 = manager.audio:GetVoiceLength("story_v_out_421072", "421072033", "story_v_out_421072.awb") / 1000

					if var_136_10 + var_136_4 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_10 + var_136_4
					end

					if var_136_6.prefab_name ~= "" and arg_133_1.actors_[var_136_6.prefab_name] ~= nil then
						local var_136_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_6.prefab_name].transform, "story_v_out_421072", "421072033", "story_v_out_421072.awb")

						arg_133_1:RecordAudio("421072033", var_136_11)
						arg_133_1:RecordAudio("421072033", var_136_11)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_out_421072", "421072033", "story_v_out_421072.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_out_421072", "421072033", "story_v_out_421072.awb")
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
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_133_1:InitPlayNodeList()
	end,
	Play421072034 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 421072034
		arg_137_1.duration_ = 4.7

		local var_137_0 = {
			zh = 4.7,
			ja = 4.533
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
				arg_137_0:Play421072035(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 and not isNil(arg_137_1.actors_["1047ui_story"]) and arg_137_1.var_.characterEffect1047ui_story == nil then
				arg_137_1.var_.characterEffect1047ui_story = arg_137_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_140_0 = 0.200000002980232

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_0 and not isNil(arg_137_1.actors_["1047ui_story"]) then
				if arg_137_1.var_.characterEffect1047ui_story and not isNil(arg_137_1.actors_["1047ui_story"]) then
					arg_137_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_137_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_137_1.time_ - 0) / var_140_0)
				end
			end

			if arg_137_1.time_ >= 0 + var_140_0 and arg_137_1.time_ < 0 + var_140_0 + arg_140_0 and not isNil(arg_137_1.actors_["1047ui_story"]) and arg_137_1.var_.characterEffect1047ui_story then
				arg_137_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_137_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_140_1 = 0
			local var_140_2 = 0.35

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= var_140_1 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				arg_137_1.leftNameTxt_.text = arg_137_1:FormatText(StoryNameCfg[1320].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, true)
				arg_137_1.iconController_:SetSelectedState("hero")

				arg_137_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Jackson")

				arg_137_1.callingController_:SetSelectedState("normal")

				arg_137_1.keyicon_.color = Color.New(1, 1, 1)
				arg_137_1.icon_.color = Color.New(1, 1, 1)

				local var_140_3 = arg_137_1:GetWordFromCfg(421072034)
				local var_140_4 = arg_137_1:FormatText(var_140_3.content)

				arg_137_1.text_.text = var_140_4

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_6 = 14 <= 0 and var_140_2 or var_140_2 * (utf8.len(var_140_4) / 14)

				if (14 <= 0 and var_140_2 or var_140_2 * (utf8.len(var_140_4) / 14)) > 0 and var_140_2 < var_140_6 then
					arg_137_1.talkMaxDuration = var_140_6

					if var_140_6 + var_140_1 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_6 + var_140_1
					end
				end

				arg_137_1.text_.text = var_140_4
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421072", "421072034", "story_v_out_421072.awb") ~= 0 then
					local var_140_7 = manager.audio:GetVoiceLength("story_v_out_421072", "421072034", "story_v_out_421072.awb") / 1000

					if var_140_7 + var_140_1 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_7 + var_140_1
					end

					if var_140_3.prefab_name ~= "" and arg_137_1.actors_[var_140_3.prefab_name] ~= nil then
						local var_140_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_137_1.actors_[var_140_3.prefab_name].transform, "story_v_out_421072", "421072034", "story_v_out_421072.awb")

						arg_137_1:RecordAudio("421072034", var_140_8)
						arg_137_1:RecordAudio("421072034", var_140_8)
					else
						arg_137_1:AudioAction("play", "voice", "story_v_out_421072", "421072034", "story_v_out_421072.awb")
					end

					arg_137_1:RecordHistoryTalkVoice("story_v_out_421072", "421072034", "story_v_out_421072.awb")
				end

				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_9 = math.max(var_140_2, arg_137_1.talkMaxDuration)

			if var_140_1 <= arg_137_1.time_ and arg_137_1.time_ < var_140_1 + var_140_9 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_1) / var_140_9

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_1 + var_140_9 and arg_137_1.time_ < var_140_1 + var_140_9 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {}

		arg_137_1:InitPlayNodeList()
	end,
	Play421072035 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 421072035
		arg_141_1.duration_ = 2

		SetActive(arg_141_1.tipsGo_, false)

		function arg_141_1.onSingleLineFinish_()
			arg_141_1.onSingleLineUpdate_ = nil
			arg_141_1.onSingleLineFinish_ = nil
			arg_141_1.state_ = "waiting"
		end

		function arg_141_1.playNext_(arg_143_0)
			if arg_143_0 == 1 then
				arg_141_0:Play421072036(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1.var_.moveOldPos1047ui_story = arg_141_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_144_0 = 0.001

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_0 then
				arg_141_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_141_1.var_.moveOldPos1047ui_story, Vector3.New(0, 100, 0), (arg_141_1.time_ - 0) / var_144_0)
				arg_141_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_141_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_141_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_141_1.actors_["1047ui_story"].transform.position).z)
				arg_141_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_141_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_141_1.actors_["1047ui_story"].transform.localEulerAngles = arg_141_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_141_1.time_ >= 0 + var_144_0 and arg_141_1.time_ < 0 + var_144_0 + arg_144_0 then
				arg_141_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_141_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_141_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_141_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_141_1.actors_["1047ui_story"].transform.position).z)
				arg_141_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_141_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_141_1.actors_["1047ui_story"].transform.localEulerAngles = arg_141_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_144_1 = "10102ui_story"

			if arg_141_1.actors_["10102ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10102ui_story"))) then
				local var_144_2 = Object.Instantiate(Asset.Load("Char/" .. "10102ui_story"), arg_141_1.stage_.transform)

				var_144_2.name = var_144_1
				var_144_2.transform.localPosition = Vector3.New(0, 100, 0)
				arg_141_1.actors_[var_144_1] = var_144_2

				local var_144_3 = var_144_2:GetComponentInChildren(typeof(CharacterEffect))

				var_144_3.enabled = true

				local var_144_4 = GameObjectTools.GetOrAddComponent(var_144_2, typeof(DynamicBoneHelper))

				if var_144_4 then
					var_144_4:EnableDynamicBone(false)
				end

				arg_141_1:ShowWeapon(var_144_3.transform, false)

				arg_141_1.var_[var_144_1 .. "Animator"] = var_144_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_141_1.var_[var_144_1 .. "Animator"].applyRootMotion = true
				arg_141_1.var_[var_144_1 .. "LipSync"] = var_144_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_144_5 = arg_141_1.actors_["10102ui_story"].transform

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1.var_.moveOldPos10102ui_story = var_144_5.localPosition
			end

			local var_144_6 = 0.001

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_6 then
				var_144_5.localPosition = Vector3.Lerp(arg_141_1.var_.moveOldPos10102ui_story, Vector3.New(0, -0.985, -6.275), (arg_141_1.time_ - 0) / var_144_6)
				var_144_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_144_5.position).x, (manager.ui.mainCamera.transform.position - var_144_5.position).y, (manager.ui.mainCamera.transform.position - var_144_5.position).z)
				var_144_5.localEulerAngles.z = 0
				var_144_5.localEulerAngles.x = 0
				var_144_5.localEulerAngles = var_144_5.localEulerAngles
			end

			if arg_141_1.time_ >= 0 + var_144_6 and arg_141_1.time_ < 0 + var_144_6 + arg_144_0 then
				var_144_5.localPosition = Vector3.New(0, -0.985, -6.275)
				var_144_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_144_5.position).x, (manager.ui.mainCamera.transform.position - var_144_5.position).y, (manager.ui.mainCamera.transform.position - var_144_5.position).z)
				var_144_5.localEulerAngles.z = 0
				var_144_5.localEulerAngles.x = 0
				var_144_5.localEulerAngles = var_144_5.localEulerAngles
			end

			local var_144_7 = arg_141_1.actors_["10102ui_story"]

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 and not isNil(var_144_7) and arg_141_1.var_.characterEffect10102ui_story == nil then
				arg_141_1.var_.characterEffect10102ui_story = var_144_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_144_8 = 0.200000002980232

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_8 and not isNil(var_144_7) then
				if arg_141_1.var_.characterEffect10102ui_story and not isNil(var_144_7) then
					arg_141_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_141_1.time_ >= 0 + var_144_8 and arg_141_1.time_ < 0 + var_144_8 + arg_144_0 and not isNil(var_144_7) and arg_141_1.var_.characterEffect10102ui_story then
				arg_141_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action2_1")
			end

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_144_10 = 0
			local var_144_11 = 0.2

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= var_144_10 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				arg_141_1.leftNameTxt_.text = arg_141_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_12 = arg_141_1:GetWordFromCfg(421072035)
				local var_144_13 = arg_141_1:FormatText(var_144_12.content)

				arg_141_1.text_.text = var_144_13

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_15 = 8 <= 0 and var_144_11 or var_144_11 * (utf8.len(var_144_13) / 8)

				if (8 <= 0 and var_144_11 or var_144_11 * (utf8.len(var_144_13) / 8)) > 0 and var_144_11 < var_144_15 then
					arg_141_1.talkMaxDuration = var_144_15

					if var_144_15 + var_144_10 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_15 + var_144_10
					end
				end

				arg_141_1.text_.text = var_144_13
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421072", "421072035", "story_v_out_421072.awb") ~= 0 then
					local var_144_16 = manager.audio:GetVoiceLength("story_v_out_421072", "421072035", "story_v_out_421072.awb") / 1000

					if var_144_16 + var_144_10 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_16 + var_144_10
					end

					if var_144_12.prefab_name ~= "" and arg_141_1.actors_[var_144_12.prefab_name] ~= nil then
						local var_144_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_12.prefab_name].transform, "story_v_out_421072", "421072035", "story_v_out_421072.awb")

						arg_141_1:RecordAudio("421072035", var_144_17)
						arg_141_1:RecordAudio("421072035", var_144_17)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_out_421072", "421072035", "story_v_out_421072.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_out_421072", "421072035", "story_v_out_421072.awb")
				end

				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_18 = math.max(var_144_11, arg_141_1.talkMaxDuration)

			if var_144_10 <= arg_141_1.time_ and arg_141_1.time_ < var_144_10 + var_144_18 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_10) / var_144_18

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_10 + var_144_18 and arg_141_1.time_ < var_144_10 + var_144_18 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_141_1:InitPlayNodeList()
	end,
	Play421072036 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 421072036
		arg_145_1.duration_ = 5

		SetActive(arg_145_1.tipsGo_, false)

		function arg_145_1.onSingleLineFinish_()
			arg_145_1.onSingleLineUpdate_ = nil
			arg_145_1.onSingleLineFinish_ = nil
			arg_145_1.state_ = "waiting"
		end

		function arg_145_1.playNext_(arg_147_0)
			if arg_147_0 == 1 then
				arg_145_0:Play421072037(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1.var_.moveOldPos10102ui_story = arg_145_1.actors_["10102ui_story"].transform.localPosition
			end

			local var_148_0 = 0.001

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_0 then
				arg_145_1.actors_["10102ui_story"].transform.localPosition = Vector3.Lerp(arg_145_1.var_.moveOldPos10102ui_story, Vector3.New(0, 100, 0), (arg_145_1.time_ - 0) / var_148_0)
				arg_145_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_145_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_145_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_145_1.actors_["10102ui_story"].transform.position).z)
				arg_145_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_145_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_145_1.actors_["10102ui_story"].transform.localEulerAngles = arg_145_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			if arg_145_1.time_ >= 0 + var_148_0 and arg_145_1.time_ < 0 + var_148_0 + arg_148_0 then
				arg_145_1.actors_["10102ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_145_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_145_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_145_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_145_1.actors_["10102ui_story"].transform.position).z)
				arg_145_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_145_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_145_1.actors_["10102ui_story"].transform.localEulerAngles = arg_145_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			local var_148_1 = 0
			local var_148_2 = 1.45

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= var_148_1 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, false)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_3 = arg_145_1:FormatText(arg_145_1:GetWordFromCfg(421072036).content)

				arg_145_1.text_.text = var_148_3

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_5 = 58 <= 0 and var_148_2 or var_148_2 * (utf8.len(var_148_3) / 58)

				if (58 <= 0 and var_148_2 or var_148_2 * (utf8.len(var_148_3) / 58)) > 0 and var_148_2 < var_148_5 then
					arg_145_1.talkMaxDuration = var_148_5

					if var_148_5 + var_148_1 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_5 + var_148_1
					end
				end

				arg_145_1.text_.text = var_148_3
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)
				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_6 = math.max(var_148_2, arg_145_1.talkMaxDuration)

			if var_148_1 <= arg_145_1.time_ and arg_145_1.time_ < var_148_1 + var_148_6 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_1) / var_148_6

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_1 + var_148_6 and arg_145_1.time_ < var_148_1 + var_148_6 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_145_1:InitPlayNodeList()
	end,
	Play421072037 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 421072037
		arg_149_1.duration_ = 5

		SetActive(arg_149_1.tipsGo_, false)

		function arg_149_1.onSingleLineFinish_()
			arg_149_1.onSingleLineUpdate_ = nil
			arg_149_1.onSingleLineFinish_ = nil
			arg_149_1.state_ = "waiting"
		end

		function arg_149_1.playNext_(arg_151_0)
			if arg_151_0 == 1 then
				arg_149_0:Play421072038(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			local var_152_0 = 0.25

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				arg_149_1.leftNameTxt_.text = arg_149_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, true)
				arg_149_1.iconController_:SetSelectedState("hero")

				arg_149_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_149_1.callingController_:SetSelectedState("normal")

				arg_149_1.keyicon_.color = Color.New(1, 1, 1)
				arg_149_1.icon_.color = Color.New(1, 1, 1)

				local var_152_1 = arg_149_1:FormatText(arg_149_1:GetWordFromCfg(421072037).content)

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
	Play421072038 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 421072038
		arg_153_1.duration_ = 6.5

		local var_153_0 = {
			zh = 3.5,
			ja = 6.5
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
				arg_153_0:Play421072039(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1.var_.moveOldPos10102ui_story = arg_153_1.actors_["10102ui_story"].transform.localPosition
			end

			local var_156_0 = 0.001

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_0 then
				arg_153_1.actors_["10102ui_story"].transform.localPosition = Vector3.Lerp(arg_153_1.var_.moveOldPos10102ui_story, Vector3.New(0, -0.985, -6.275), (arg_153_1.time_ - 0) / var_156_0)
				arg_153_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_153_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_153_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_153_1.actors_["10102ui_story"].transform.position).z)
				arg_153_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_153_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_153_1.actors_["10102ui_story"].transform.localEulerAngles = arg_153_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			if arg_153_1.time_ >= 0 + var_156_0 and arg_153_1.time_ < 0 + var_156_0 + arg_156_0 then
				arg_153_1.actors_["10102ui_story"].transform.localPosition = Vector3.New(0, -0.985, -6.275)
				arg_153_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_153_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_153_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_153_1.actors_["10102ui_story"].transform.position).z)
				arg_153_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_153_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_153_1.actors_["10102ui_story"].transform.localEulerAngles = arg_153_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			local var_156_1 = arg_153_1.actors_["10102ui_story"]

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 and not isNil(var_156_1) and arg_153_1.var_.characterEffect10102ui_story == nil then
				arg_153_1.var_.characterEffect10102ui_story = var_156_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_156_2 = 0.200000002980232

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_2 and not isNil(var_156_1) then
				if arg_153_1.var_.characterEffect10102ui_story and not isNil(var_156_1) then
					arg_153_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_153_1.time_ >= 0 + var_156_2 and arg_153_1.time_ < 0 + var_156_2 + arg_156_0 and not isNil(var_156_1) and arg_153_1.var_.characterEffect10102ui_story then
				arg_153_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action2_2")
			end

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/expr_renzhen", "EmotionTimelineAnimator")
			end

			local var_156_4 = 0
			local var_156_5 = 0.525

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= var_156_4 + arg_156_0 then
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

				local var_156_6 = arg_153_1:GetWordFromCfg(421072038)
				local var_156_7 = arg_153_1:FormatText(var_156_6.content)

				arg_153_1.text_.text = var_156_7

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_9 = 21 <= 0 and var_156_5 or var_156_5 * (utf8.len(var_156_7) / 21)

				if (21 <= 0 and var_156_5 or var_156_5 * (utf8.len(var_156_7) / 21)) > 0 and var_156_5 < var_156_9 then
					arg_153_1.talkMaxDuration = var_156_9

					if var_156_9 + var_156_4 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_9 + var_156_4
					end
				end

				arg_153_1.text_.text = var_156_7
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421072", "421072038", "story_v_out_421072.awb") ~= 0 then
					local var_156_10 = manager.audio:GetVoiceLength("story_v_out_421072", "421072038", "story_v_out_421072.awb") / 1000

					if var_156_10 + var_156_4 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_10 + var_156_4
					end

					if var_156_6.prefab_name ~= "" and arg_153_1.actors_[var_156_6.prefab_name] ~= nil then
						local var_156_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_6.prefab_name].transform, "story_v_out_421072", "421072038", "story_v_out_421072.awb")

						arg_153_1:RecordAudio("421072038", var_156_11)
						arg_153_1:RecordAudio("421072038", var_156_11)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_out_421072", "421072038", "story_v_out_421072.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_out_421072", "421072038", "story_v_out_421072.awb")
				end

				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_12 = math.max(var_156_5, arg_153_1.talkMaxDuration)

			if var_156_4 <= arg_153_1.time_ and arg_153_1.time_ < var_156_4 + var_156_12 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_4) / var_156_12

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_4 + var_156_12 and arg_153_1.time_ < var_156_4 + var_156_12 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
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
	Play421072039 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 421072039
		arg_157_1.duration_ = 5

		SetActive(arg_157_1.tipsGo_, false)

		function arg_157_1.onSingleLineFinish_()
			arg_157_1.onSingleLineUpdate_ = nil
			arg_157_1.onSingleLineFinish_ = nil
			arg_157_1.state_ = "waiting"
		end

		function arg_157_1.playNext_(arg_159_0)
			if arg_159_0 == 1 then
				arg_157_0:Play421072040(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 and not isNil(arg_157_1.actors_["10102ui_story"]) and arg_157_1.var_.characterEffect10102ui_story == nil then
				arg_157_1.var_.characterEffect10102ui_story = arg_157_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_160_0 = 0.200000002980232

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_0 and not isNil(arg_157_1.actors_["10102ui_story"]) then
				if arg_157_1.var_.characterEffect10102ui_story and not isNil(arg_157_1.actors_["10102ui_story"]) then
					arg_157_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_157_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_157_1.time_ - 0) / var_160_0)
				end
			end

			if arg_157_1.time_ >= 0 + var_160_0 and arg_157_1.time_ < 0 + var_160_0 + arg_160_0 and not isNil(arg_157_1.actors_["10102ui_story"]) and arg_157_1.var_.characterEffect10102ui_story then
				arg_157_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_157_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			local var_160_1 = 0
			local var_160_2 = 0.125

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= var_160_1 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, true)

				arg_157_1.leftNameTxt_.text = arg_157_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, true)
				arg_157_1.iconController_:SetSelectedState("hero")

				arg_157_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_157_1.callingController_:SetSelectedState("normal")

				arg_157_1.keyicon_.color = Color.New(1, 1, 1)
				arg_157_1.icon_.color = Color.New(1, 1, 1)

				local var_160_3 = arg_157_1:FormatText(arg_157_1:GetWordFromCfg(421072039).content)

				arg_157_1.text_.text = var_160_3

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_5 = 5 <= 0 and var_160_2 or var_160_2 * (utf8.len(var_160_3) / 5)

				if (5 <= 0 and var_160_2 or var_160_2 * (utf8.len(var_160_3) / 5)) > 0 and var_160_2 < var_160_5 then
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
	Play421072040 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 421072040
		arg_161_1.duration_ = 5

		local var_161_0 = {
			zh = 3.266,
			ja = 5
		}
		local var_161_1 = manager.audio:GetLocalizationFlag()

		if var_161_0[var_161_1] ~= nil then
			arg_161_1.duration_ = var_161_0[var_161_1]
		end

		SetActive(arg_161_1.tipsGo_, false)

		function arg_161_1.onSingleLineFinish_()
			arg_161_1.onSingleLineUpdate_ = nil
			arg_161_1.onSingleLineFinish_ = nil
			arg_161_1.state_ = "waiting"
		end

		function arg_161_1.playNext_(arg_163_0)
			if arg_163_0 == 1 then
				arg_161_0:Play421072041(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1.var_.moveOldPos10102ui_story = arg_161_1.actors_["10102ui_story"].transform.localPosition
			end

			local var_164_0 = 0.001

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_0 then
				arg_161_1.actors_["10102ui_story"].transform.localPosition = Vector3.Lerp(arg_161_1.var_.moveOldPos10102ui_story, Vector3.New(0, 100, 0), (arg_161_1.time_ - 0) / var_164_0)
				arg_161_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_161_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_161_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_161_1.actors_["10102ui_story"].transform.position).z)
				arg_161_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_161_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_161_1.actors_["10102ui_story"].transform.localEulerAngles = arg_161_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			if arg_161_1.time_ >= 0 + var_164_0 and arg_161_1.time_ < 0 + var_164_0 + arg_164_0 then
				arg_161_1.actors_["10102ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_161_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_161_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_161_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_161_1.actors_["10102ui_story"].transform.position).z)
				arg_161_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_161_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_161_1.actors_["10102ui_story"].transform.localEulerAngles = arg_161_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			local var_164_1 = "10143ui_story"

			if arg_161_1.actors_["10143ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10143ui_story"))) then
				local var_164_2 = Object.Instantiate(Asset.Load("Char/" .. "10143ui_story"), arg_161_1.stage_.transform)

				var_164_2.name = var_164_1
				var_164_2.transform.localPosition = Vector3.New(0, 100, 0)
				arg_161_1.actors_[var_164_1] = var_164_2

				local var_164_3 = var_164_2:GetComponentInChildren(typeof(CharacterEffect))

				var_164_3.enabled = true

				local var_164_4 = GameObjectTools.GetOrAddComponent(var_164_2, typeof(DynamicBoneHelper))

				if var_164_4 then
					var_164_4:EnableDynamicBone(false)
				end

				arg_161_1:ShowWeapon(var_164_3.transform, false)

				arg_161_1.var_[var_164_1 .. "Animator"] = var_164_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_161_1.var_[var_164_1 .. "Animator"].applyRootMotion = true
				arg_161_1.var_[var_164_1 .. "LipSync"] = var_164_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_164_5 = arg_161_1.actors_["10143ui_story"].transform

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1.var_.moveOldPos10143ui_story = var_164_5.localPosition
			end

			local var_164_6 = 0.001

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_6 then
				var_164_5.localPosition = Vector3.Lerp(arg_161_1.var_.moveOldPos10143ui_story, Vector3.New(0, -1.06, -6), (arg_161_1.time_ - 0) / var_164_6)
				var_164_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_164_5.position).x, (manager.ui.mainCamera.transform.position - var_164_5.position).y, (manager.ui.mainCamera.transform.position - var_164_5.position).z)
				var_164_5.localEulerAngles.z = 0
				var_164_5.localEulerAngles.x = 0
				var_164_5.localEulerAngles = var_164_5.localEulerAngles
			end

			if arg_161_1.time_ >= 0 + var_164_6 and arg_161_1.time_ < 0 + var_164_6 + arg_164_0 then
				var_164_5.localPosition = Vector3.New(0, -1.06, -6)
				var_164_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_164_5.position).x, (manager.ui.mainCamera.transform.position - var_164_5.position).y, (manager.ui.mainCamera.transform.position - var_164_5.position).z)
				var_164_5.localEulerAngles.z = 0
				var_164_5.localEulerAngles.x = 0
				var_164_5.localEulerAngles = var_164_5.localEulerAngles
			end

			local var_164_7 = arg_161_1.actors_["10143ui_story"]

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 and not isNil(var_164_7) and arg_161_1.var_.characterEffect10143ui_story == nil then
				arg_161_1.var_.characterEffect10143ui_story = var_164_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_164_8 = 0.200000002980232

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_8 and not isNil(var_164_7) then
				if arg_161_1.var_.characterEffect10143ui_story and not isNil(var_164_7) then
					arg_161_1.var_.characterEffect10143ui_story.fillFlat = false
				end
			end

			if arg_161_1.time_ >= 0 + var_164_8 and arg_161_1.time_ < 0 + var_164_8 + arg_164_0 and not isNil(var_164_7) and arg_161_1.var_.characterEffect10143ui_story then
				arg_161_1.var_.characterEffect10143ui_story.fillFlat = false
			end

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1:PlayTimeline("10143ui_story", "StoryTimeline/CharAction/story10143/story10143action/10143action1_1")
			end

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1:PlayTimeline("10143ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_164_10 = 0
			local var_164_11 = 0.35

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= var_164_10 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				arg_161_1.leftNameTxt_.text = arg_161_1:FormatText(StoryNameCfg[1307].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_12 = arg_161_1:GetWordFromCfg(421072040)
				local var_164_13 = arg_161_1:FormatText(var_164_12.content)

				arg_161_1.text_.text = var_164_13

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_15 = 14 <= 0 and var_164_11 or var_164_11 * (utf8.len(var_164_13) / 14)

				if (14 <= 0 and var_164_11 or var_164_11 * (utf8.len(var_164_13) / 14)) > 0 and var_164_11 < var_164_15 then
					arg_161_1.talkMaxDuration = var_164_15

					if var_164_15 + var_164_10 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_15 + var_164_10
					end
				end

				arg_161_1.text_.text = var_164_13
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421072", "421072040", "story_v_out_421072.awb") ~= 0 then
					local var_164_16 = manager.audio:GetVoiceLength("story_v_out_421072", "421072040", "story_v_out_421072.awb") / 1000

					if var_164_16 + var_164_10 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_16 + var_164_10
					end

					if var_164_12.prefab_name ~= "" and arg_161_1.actors_[var_164_12.prefab_name] ~= nil then
						local var_164_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_161_1.actors_[var_164_12.prefab_name].transform, "story_v_out_421072", "421072040", "story_v_out_421072.awb")

						arg_161_1:RecordAudio("421072040", var_164_17)
						arg_161_1:RecordAudio("421072040", var_164_17)
					else
						arg_161_1:AudioAction("play", "voice", "story_v_out_421072", "421072040", "story_v_out_421072.awb")
					end

					arg_161_1:RecordHistoryTalkVoice("story_v_out_421072", "421072040", "story_v_out_421072.awb")
				end

				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_18 = math.max(var_164_11, arg_161_1.talkMaxDuration)

			if var_164_10 <= arg_161_1.time_ and arg_161_1.time_ < var_164_10 + var_164_18 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - var_164_10) / var_164_18

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= var_164_10 + var_164_18 and arg_161_1.time_ < var_164_10 + var_164_18 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10143ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_161_1:InitPlayNodeList()
	end,
	Play421072041 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 421072041
		arg_165_1.duration_ = 5

		SetActive(arg_165_1.tipsGo_, false)

		function arg_165_1.onSingleLineFinish_()
			arg_165_1.onSingleLineUpdate_ = nil
			arg_165_1.onSingleLineFinish_ = nil
			arg_165_1.state_ = "waiting"
		end

		function arg_165_1.playNext_(arg_167_0)
			if arg_167_0 == 1 then
				arg_165_0:Play421072042(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 and not isNil(arg_165_1.actors_["10143ui_story"]) and arg_165_1.var_.characterEffect10143ui_story == nil then
				arg_165_1.var_.characterEffect10143ui_story = arg_165_1.actors_["10143ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_168_0 = 0.200000002980232

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_0 and not isNil(arg_165_1.actors_["10143ui_story"]) then
				if arg_165_1.var_.characterEffect10143ui_story and not isNil(arg_165_1.actors_["10143ui_story"]) then
					arg_165_1.var_.characterEffect10143ui_story.fillFlat = true
					arg_165_1.var_.characterEffect10143ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_165_1.time_ - 0) / var_168_0)
				end
			end

			if arg_165_1.time_ >= 0 + var_168_0 and arg_165_1.time_ < 0 + var_168_0 + arg_168_0 and not isNil(arg_165_1.actors_["10143ui_story"]) and arg_165_1.var_.characterEffect10143ui_story then
				arg_165_1.var_.characterEffect10143ui_story.fillFlat = true
				arg_165_1.var_.characterEffect10143ui_story.fillRatio = 0.5
			end

			local var_168_1 = 0
			local var_168_2 = 0.975

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= var_168_1 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, false)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_3 = arg_165_1:FormatText(arg_165_1:GetWordFromCfg(421072041).content)

				arg_165_1.text_.text = var_168_3

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_5 = 39 <= 0 and var_168_2 or var_168_2 * (utf8.len(var_168_3) / 39)

				if (39 <= 0 and var_168_2 or var_168_2 * (utf8.len(var_168_3) / 39)) > 0 and var_168_2 < var_168_5 then
					arg_165_1.talkMaxDuration = var_168_5

					if var_168_5 + var_168_1 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_5 + var_168_1
					end
				end

				arg_165_1.text_.text = var_168_3
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)
				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_6 = math.max(var_168_2, arg_165_1.talkMaxDuration)

			if var_168_1 <= arg_165_1.time_ and arg_165_1.time_ < var_168_1 + var_168_6 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_1) / var_168_6

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_1 + var_168_6 and arg_165_1.time_ < var_168_1 + var_168_6 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {}

		arg_165_1:InitPlayNodeList()
	end,
	Play421072042 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 421072042
		arg_169_1.duration_ = 6.93

		local var_169_0 = {
			zh = 5,
			ja = 6.933
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
				arg_169_0:Play421072043(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			local var_172_0 = 0.5

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, true)

				arg_169_1.leftNameTxt_.text = arg_169_1:FormatText(StoryNameCfg[1320].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, true)
				arg_169_1.iconController_:SetSelectedState("hero")

				arg_169_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Jackson")

				arg_169_1.callingController_:SetSelectedState("normal")

				arg_169_1.keyicon_.color = Color.New(1, 1, 1)
				arg_169_1.icon_.color = Color.New(1, 1, 1)

				local var_172_1 = arg_169_1:GetWordFromCfg(421072042)
				local var_172_2 = arg_169_1:FormatText(var_172_1.content)

				arg_169_1.text_.text = var_172_2

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_4 = 20 <= 0 and var_172_0 or var_172_0 * (utf8.len(var_172_2) / 20)

				if (20 <= 0 and var_172_0 or var_172_0 * (utf8.len(var_172_2) / 20)) > 0 and var_172_0 < var_172_4 then
					arg_169_1.talkMaxDuration = var_172_4

					if var_172_4 + 0 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_4 + 0
					end
				end

				arg_169_1.text_.text = var_172_2
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421072", "421072042", "story_v_out_421072.awb") ~= 0 then
					local var_172_5 = manager.audio:GetVoiceLength("story_v_out_421072", "421072042", "story_v_out_421072.awb") / 1000

					if var_172_5 + 0 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_5 + 0
					end

					if var_172_1.prefab_name ~= "" and arg_169_1.actors_[var_172_1.prefab_name] ~= nil then
						local var_172_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_169_1.actors_[var_172_1.prefab_name].transform, "story_v_out_421072", "421072042", "story_v_out_421072.awb")

						arg_169_1:RecordAudio("421072042", var_172_6)
						arg_169_1:RecordAudio("421072042", var_172_6)
					else
						arg_169_1:AudioAction("play", "voice", "story_v_out_421072", "421072042", "story_v_out_421072.awb")
					end

					arg_169_1:RecordHistoryTalkVoice("story_v_out_421072", "421072042", "story_v_out_421072.awb")
				end

				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_7 = math.max(var_172_0, arg_169_1.talkMaxDuration)

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_7 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - 0) / var_172_7

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= 0 + var_172_7 and arg_169_1.time_ < 0 + var_172_7 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {}

		arg_169_1:InitPlayNodeList()
	end,
	Play421072043 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 421072043
		arg_173_1.duration_ = 2

		SetActive(arg_173_1.tipsGo_, false)

		function arg_173_1.onSingleLineFinish_()
			arg_173_1.onSingleLineUpdate_ = nil
			arg_173_1.onSingleLineFinish_ = nil
			arg_173_1.state_ = "waiting"
		end

		function arg_173_1.playNext_(arg_175_0)
			if arg_175_0 == 1 then
				arg_173_0:Play421072044(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1.var_.moveOldPos10143ui_story = arg_173_1.actors_["10143ui_story"].transform.localPosition
			end

			local var_176_0 = 0.001

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_0 then
				arg_173_1.actors_["10143ui_story"].transform.localPosition = Vector3.Lerp(arg_173_1.var_.moveOldPos10143ui_story, Vector3.New(0, -1.06, -6), (arg_173_1.time_ - 0) / var_176_0)
				arg_173_1.actors_["10143ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_173_1.actors_["10143ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_173_1.actors_["10143ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_173_1.actors_["10143ui_story"].transform.position).z)
				arg_173_1.actors_["10143ui_story"].transform.localEulerAngles.z = 0
				arg_173_1.actors_["10143ui_story"].transform.localEulerAngles.x = 0
				arg_173_1.actors_["10143ui_story"].transform.localEulerAngles = arg_173_1.actors_["10143ui_story"].transform.localEulerAngles
			end

			if arg_173_1.time_ >= 0 + var_176_0 and arg_173_1.time_ < 0 + var_176_0 + arg_176_0 then
				arg_173_1.actors_["10143ui_story"].transform.localPosition = Vector3.New(0, -1.06, -6)
				arg_173_1.actors_["10143ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_173_1.actors_["10143ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_173_1.actors_["10143ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_173_1.actors_["10143ui_story"].transform.position).z)
				arg_173_1.actors_["10143ui_story"].transform.localEulerAngles.z = 0
				arg_173_1.actors_["10143ui_story"].transform.localEulerAngles.x = 0
				arg_173_1.actors_["10143ui_story"].transform.localEulerAngles = arg_173_1.actors_["10143ui_story"].transform.localEulerAngles
			end

			local var_176_1 = arg_173_1.actors_["10143ui_story"]

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 and not isNil(var_176_1) and arg_173_1.var_.characterEffect10143ui_story == nil then
				arg_173_1.var_.characterEffect10143ui_story = var_176_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_176_2 = 0.200000002980232

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_2 and not isNil(var_176_1) then
				if arg_173_1.var_.characterEffect10143ui_story and not isNil(var_176_1) then
					arg_173_1.var_.characterEffect10143ui_story.fillFlat = false
				end
			end

			if arg_173_1.time_ >= 0 + var_176_2 and arg_173_1.time_ < 0 + var_176_2 + arg_176_0 and not isNil(var_176_1) and arg_173_1.var_.characterEffect10143ui_story then
				arg_173_1.var_.characterEffect10143ui_story.fillFlat = false
			end

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1:PlayTimeline("10143ui_story", "StoryTimeline/CharAction/story10143/story10143action/10143action3_1")
			end

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1:PlayTimeline("10143ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_176_4 = 0
			local var_176_5 = 0.075

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= var_176_4 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, true)

				arg_173_1.leftNameTxt_.text = arg_173_1:FormatText(StoryNameCfg[1307].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_173_1.leftNameTxt_.transform)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1.leftNameTxt_.text)
				SetActive(arg_173_1.iconTrs_.gameObject, false)
				arg_173_1.callingController_:SetSelectedState("normal")

				local var_176_6 = arg_173_1:GetWordFromCfg(421072043)
				local var_176_7 = arg_173_1:FormatText(var_176_6.content)

				arg_173_1.text_.text = var_176_7

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_9 = 3 <= 0 and var_176_5 or var_176_5 * (utf8.len(var_176_7) / 3)

				if (3 <= 0 and var_176_5 or var_176_5 * (utf8.len(var_176_7) / 3)) > 0 and var_176_5 < var_176_9 then
					arg_173_1.talkMaxDuration = var_176_9

					if var_176_9 + var_176_4 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_9 + var_176_4
					end
				end

				arg_173_1.text_.text = var_176_7
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421072", "421072043", "story_v_out_421072.awb") ~= 0 then
					local var_176_10 = manager.audio:GetVoiceLength("story_v_out_421072", "421072043", "story_v_out_421072.awb") / 1000

					if var_176_10 + var_176_4 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_10 + var_176_4
					end

					if var_176_6.prefab_name ~= "" and arg_173_1.actors_[var_176_6.prefab_name] ~= nil then
						local var_176_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_173_1.actors_[var_176_6.prefab_name].transform, "story_v_out_421072", "421072043", "story_v_out_421072.awb")

						arg_173_1:RecordAudio("421072043", var_176_11)
						arg_173_1:RecordAudio("421072043", var_176_11)
					else
						arg_173_1:AudioAction("play", "voice", "story_v_out_421072", "421072043", "story_v_out_421072.awb")
					end

					arg_173_1:RecordHistoryTalkVoice("story_v_out_421072", "421072043", "story_v_out_421072.awb")
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

		arg_173_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10143ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_173_1:InitPlayNodeList()
	end,
	Play421072044 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 421072044
		arg_177_1.duration_ = 7.7

		local var_177_0 = {
			zh = 5.033,
			ja = 7.7
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
				arg_177_0:Play421072045(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1.var_.moveOldPos10145ui_story = arg_177_1.actors_["10145ui_story"].transform.localPosition
			end

			local var_180_0 = 0.001

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_0 then
				arg_177_1.actors_["10145ui_story"].transform.localPosition = Vector3.Lerp(arg_177_1.var_.moveOldPos10145ui_story, Vector3.New(0.78, -1, -6.2), (arg_177_1.time_ - 0) / var_180_0)
				arg_177_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_177_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_177_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_177_1.actors_["10145ui_story"].transform.position).z)
				arg_177_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_177_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_177_1.actors_["10145ui_story"].transform.localEulerAngles = arg_177_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			if arg_177_1.time_ >= 0 + var_180_0 and arg_177_1.time_ < 0 + var_180_0 + arg_180_0 then
				arg_177_1.actors_["10145ui_story"].transform.localPosition = Vector3.New(0.78, -1, -6.2)
				arg_177_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_177_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_177_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_177_1.actors_["10145ui_story"].transform.position).z)
				arg_177_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_177_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_177_1.actors_["10145ui_story"].transform.localEulerAngles = arg_177_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			local var_180_1 = arg_177_1.actors_["10143ui_story"].transform

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1.var_.moveOldPos10143ui_story = var_180_1.localPosition
			end

			local var_180_2 = 0.001

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_2 then
				var_180_1.localPosition = Vector3.Lerp(arg_177_1.var_.moveOldPos10143ui_story, Vector3.New(-0.72, -1.06, -6), (arg_177_1.time_ - 0) / var_180_2)
				var_180_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_180_1.position).x, (manager.ui.mainCamera.transform.position - var_180_1.position).y, (manager.ui.mainCamera.transform.position - var_180_1.position).z)
				var_180_1.localEulerAngles.z = 0
				var_180_1.localEulerAngles.x = 0
				var_180_1.localEulerAngles = var_180_1.localEulerAngles
			end

			if arg_177_1.time_ >= 0 + var_180_2 and arg_177_1.time_ < 0 + var_180_2 + arg_180_0 then
				var_180_1.localPosition = Vector3.New(-0.72, -1.06, -6)
				var_180_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_180_1.position).x, (manager.ui.mainCamera.transform.position - var_180_1.position).y, (manager.ui.mainCamera.transform.position - var_180_1.position).z)
				var_180_1.localEulerAngles.z = 0
				var_180_1.localEulerAngles.x = 0
				var_180_1.localEulerAngles = var_180_1.localEulerAngles
			end

			local var_180_3 = arg_177_1.actors_["10145ui_story"]

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 and not isNil(var_180_3) and arg_177_1.var_.characterEffect10145ui_story == nil then
				arg_177_1.var_.characterEffect10145ui_story = var_180_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_180_4 = 0.200000002980232

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_4 and not isNil(var_180_3) then
				if arg_177_1.var_.characterEffect10145ui_story and not isNil(var_180_3) then
					arg_177_1.var_.characterEffect10145ui_story.fillFlat = false
				end
			end

			if arg_177_1.time_ >= 0 + var_180_4 and arg_177_1.time_ < 0 + var_180_4 + arg_180_0 and not isNil(var_180_3) and arg_177_1.var_.characterEffect10145ui_story then
				arg_177_1.var_.characterEffect10145ui_story.fillFlat = false
			end

			local var_180_6 = arg_177_1.actors_["10143ui_story"]

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 and not isNil(var_180_6) and arg_177_1.var_.characterEffect10143ui_story == nil then
				arg_177_1.var_.characterEffect10143ui_story = var_180_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_180_7 = 0.200000002980232

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_7 and not isNil(var_180_6) then
				if arg_177_1.var_.characterEffect10143ui_story and not isNil(var_180_6) then
					arg_177_1.var_.characterEffect10143ui_story.fillFlat = true
					arg_177_1.var_.characterEffect10143ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_177_1.time_ - 0) / var_180_7)
				end
			end

			if arg_177_1.time_ >= 0 + var_180_7 and arg_177_1.time_ < 0 + var_180_7 + arg_180_0 and not isNil(var_180_6) and arg_177_1.var_.characterEffect10143ui_story then
				arg_177_1.var_.characterEffect10143ui_story.fillFlat = true
				arg_177_1.var_.characterEffect10143ui_story.fillRatio = 0.5
			end

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/story10145/story10145action/10145action4_1")
			end

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_180_8 = 0
			local var_180_9 = 0.575

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= var_180_8 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				arg_177_1.leftNameTxt_.text = arg_177_1:FormatText(StoryNameCfg[1308].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_10 = arg_177_1:GetWordFromCfg(421072044)
				local var_180_11 = arg_177_1:FormatText(var_180_10.content)

				arg_177_1.text_.text = var_180_11

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_13 = 24 <= 0 and var_180_9 or var_180_9 * (utf8.len(var_180_11) / 24)

				if (24 <= 0 and var_180_9 or var_180_9 * (utf8.len(var_180_11) / 24)) > 0 and var_180_9 < var_180_13 then
					arg_177_1.talkMaxDuration = var_180_13

					if var_180_13 + var_180_8 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_13 + var_180_8
					end
				end

				arg_177_1.text_.text = var_180_11
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421072", "421072044", "story_v_out_421072.awb") ~= 0 then
					local var_180_14 = manager.audio:GetVoiceLength("story_v_out_421072", "421072044", "story_v_out_421072.awb") / 1000

					if var_180_14 + var_180_8 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_14 + var_180_8
					end

					if var_180_10.prefab_name ~= "" and arg_177_1.actors_[var_180_10.prefab_name] ~= nil then
						local var_180_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_177_1.actors_[var_180_10.prefab_name].transform, "story_v_out_421072", "421072044", "story_v_out_421072.awb")

						arg_177_1:RecordAudio("421072044", var_180_15)
						arg_177_1:RecordAudio("421072044", var_180_15)
					else
						arg_177_1:AudioAction("play", "voice", "story_v_out_421072", "421072044", "story_v_out_421072.awb")
					end

					arg_177_1:RecordHistoryTalkVoice("story_v_out_421072", "421072044", "story_v_out_421072.awb")
				end

				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_16 = math.max(var_180_9, arg_177_1.talkMaxDuration)

			if var_180_8 <= arg_177_1.time_ and arg_177_1.time_ < var_180_8 + var_180_16 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - var_180_8) / var_180_16

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= var_180_8 + var_180_16 and arg_177_1.time_ < var_180_8 + var_180_16 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10145ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10143ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_177_1:InitPlayNodeList()
	end,
	Play421072045 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 421072045
		arg_181_1.duration_ = 5.53

		local var_181_0 = {
			zh = 3.533,
			ja = 5.533
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
				arg_181_0:Play421072046(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
				arg_181_1.var_.moveOldPos10143ui_story = arg_181_1.actors_["10143ui_story"].transform.localPosition
			end

			local var_184_0 = 0.001

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_0 then
				arg_181_1.actors_["10143ui_story"].transform.localPosition = Vector3.Lerp(arg_181_1.var_.moveOldPos10143ui_story, Vector3.New(-0.72, -1.06, -6), (arg_181_1.time_ - 0) / var_184_0)
				arg_181_1.actors_["10143ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_181_1.actors_["10143ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_181_1.actors_["10143ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_181_1.actors_["10143ui_story"].transform.position).z)
				arg_181_1.actors_["10143ui_story"].transform.localEulerAngles.z = 0
				arg_181_1.actors_["10143ui_story"].transform.localEulerAngles.x = 0
				arg_181_1.actors_["10143ui_story"].transform.localEulerAngles = arg_181_1.actors_["10143ui_story"].transform.localEulerAngles
			end

			if arg_181_1.time_ >= 0 + var_184_0 and arg_181_1.time_ < 0 + var_184_0 + arg_184_0 then
				arg_181_1.actors_["10143ui_story"].transform.localPosition = Vector3.New(-0.72, -1.06, -6)
				arg_181_1.actors_["10143ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_181_1.actors_["10143ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_181_1.actors_["10143ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_181_1.actors_["10143ui_story"].transform.position).z)
				arg_181_1.actors_["10143ui_story"].transform.localEulerAngles.z = 0
				arg_181_1.actors_["10143ui_story"].transform.localEulerAngles.x = 0
				arg_181_1.actors_["10143ui_story"].transform.localEulerAngles = arg_181_1.actors_["10143ui_story"].transform.localEulerAngles
			end

			local var_184_1 = arg_181_1.actors_["10143ui_story"]

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 and not isNil(var_184_1) and arg_181_1.var_.characterEffect10143ui_story == nil then
				arg_181_1.var_.characterEffect10143ui_story = var_184_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_184_2 = 0.200000002980232

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_2 and not isNil(var_184_1) then
				if arg_181_1.var_.characterEffect10143ui_story and not isNil(var_184_1) then
					arg_181_1.var_.characterEffect10143ui_story.fillFlat = false
				end
			end

			if arg_181_1.time_ >= 0 + var_184_2 and arg_181_1.time_ < 0 + var_184_2 + arg_184_0 and not isNil(var_184_1) and arg_181_1.var_.characterEffect10143ui_story then
				arg_181_1.var_.characterEffect10143ui_story.fillFlat = false
			end

			local var_184_4 = arg_181_1.actors_["10145ui_story"]

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 and not isNil(var_184_4) and arg_181_1.var_.characterEffect10145ui_story == nil then
				arg_181_1.var_.characterEffect10145ui_story = var_184_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_184_5 = 0.200000002980232

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_5 and not isNil(var_184_4) then
				if arg_181_1.var_.characterEffect10145ui_story and not isNil(var_184_4) then
					arg_181_1.var_.characterEffect10145ui_story.fillFlat = true
					arg_181_1.var_.characterEffect10145ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_181_1.time_ - 0) / var_184_5)
				end
			end

			if arg_181_1.time_ >= 0 + var_184_5 and arg_181_1.time_ < 0 + var_184_5 + arg_184_0 and not isNil(var_184_4) and arg_181_1.var_.characterEffect10145ui_story then
				arg_181_1.var_.characterEffect10145ui_story.fillFlat = true
				arg_181_1.var_.characterEffect10145ui_story.fillRatio = 0.5
			end

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
				arg_181_1:PlayTimeline("10143ui_story", "StoryTimeline/CharAction/story10143/story10143action/10143action3_2")
			end

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
				arg_181_1:PlayTimeline("10143ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_184_6 = 0
			local var_184_7 = 0.45

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= var_184_6 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				arg_181_1.leftNameTxt_.text = arg_181_1:FormatText(StoryNameCfg[1307].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_8 = arg_181_1:GetWordFromCfg(421072045)
				local var_184_9 = arg_181_1:FormatText(var_184_8.content)

				arg_181_1.text_.text = var_184_9

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_11 = 18 <= 0 and var_184_7 or var_184_7 * (utf8.len(var_184_9) / 18)

				if (18 <= 0 and var_184_7 or var_184_7 * (utf8.len(var_184_9) / 18)) > 0 and var_184_7 < var_184_11 then
					arg_181_1.talkMaxDuration = var_184_11

					if var_184_11 + var_184_6 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_11 + var_184_6
					end
				end

				arg_181_1.text_.text = var_184_9
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421072", "421072045", "story_v_out_421072.awb") ~= 0 then
					local var_184_12 = manager.audio:GetVoiceLength("story_v_out_421072", "421072045", "story_v_out_421072.awb") / 1000

					if var_184_12 + var_184_6 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_12 + var_184_6
					end

					if var_184_8.prefab_name ~= "" and arg_181_1.actors_[var_184_8.prefab_name] ~= nil then
						local var_184_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_181_1.actors_[var_184_8.prefab_name].transform, "story_v_out_421072", "421072045", "story_v_out_421072.awb")

						arg_181_1:RecordAudio("421072045", var_184_13)
						arg_181_1:RecordAudio("421072045", var_184_13)
					else
						arg_181_1:AudioAction("play", "voice", "story_v_out_421072", "421072045", "story_v_out_421072.awb")
					end

					arg_181_1:RecordHistoryTalkVoice("story_v_out_421072", "421072045", "story_v_out_421072.awb")
				end

				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_14 = math.max(var_184_7, arg_181_1.talkMaxDuration)

			if var_184_6 <= arg_181_1.time_ and arg_181_1.time_ < var_184_6 + var_184_14 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_6) / var_184_14

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_6 + var_184_14 and arg_181_1.time_ < var_184_6 + var_184_14 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10143ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_181_1:InitPlayNodeList()
	end,
	Play421072046 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 421072046
		arg_185_1.duration_ = 3.73

		local var_185_0 = {
			zh = 2.366,
			ja = 3.733
		}
		local var_185_1 = manager.audio:GetLocalizationFlag()

		if var_185_0[var_185_1] ~= nil then
			arg_185_1.duration_ = var_185_0[var_185_1]
		end

		SetActive(arg_185_1.tipsGo_, false)

		function arg_185_1.onSingleLineFinish_()
			arg_185_1.onSingleLineUpdate_ = nil
			arg_185_1.onSingleLineFinish_ = nil
			arg_185_1.state_ = "waiting"
		end

		function arg_185_1.playNext_(arg_187_0)
			if arg_187_0 == 1 then
				arg_185_0:Play421072047(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 then
				arg_185_1.var_.moveOldPos10145ui_story = arg_185_1.actors_["10145ui_story"].transform.localPosition
			end

			local var_188_0 = 0.001

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_0 then
				arg_185_1.actors_["10145ui_story"].transform.localPosition = Vector3.Lerp(arg_185_1.var_.moveOldPos10145ui_story, Vector3.New(0.78, -1, -6.2), (arg_185_1.time_ - 0) / var_188_0)
				arg_185_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_185_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_185_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_185_1.actors_["10145ui_story"].transform.position).z)
				arg_185_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_185_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_185_1.actors_["10145ui_story"].transform.localEulerAngles = arg_185_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			if arg_185_1.time_ >= 0 + var_188_0 and arg_185_1.time_ < 0 + var_188_0 + arg_188_0 then
				arg_185_1.actors_["10145ui_story"].transform.localPosition = Vector3.New(0.78, -1, -6.2)
				arg_185_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_185_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_185_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_185_1.actors_["10145ui_story"].transform.position).z)
				arg_185_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_185_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_185_1.actors_["10145ui_story"].transform.localEulerAngles = arg_185_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			local var_188_1 = arg_185_1.actors_["10145ui_story"]

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 and not isNil(var_188_1) and arg_185_1.var_.characterEffect10145ui_story == nil then
				arg_185_1.var_.characterEffect10145ui_story = var_188_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_188_2 = 0.200000002980232

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_2 and not isNil(var_188_1) then
				if arg_185_1.var_.characterEffect10145ui_story and not isNil(var_188_1) then
					arg_185_1.var_.characterEffect10145ui_story.fillFlat = false
				end
			end

			if arg_185_1.time_ >= 0 + var_188_2 and arg_185_1.time_ < 0 + var_188_2 + arg_188_0 and not isNil(var_188_1) and arg_185_1.var_.characterEffect10145ui_story then
				arg_185_1.var_.characterEffect10145ui_story.fillFlat = false
			end

			local var_188_4 = arg_185_1.actors_["10143ui_story"]

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 and not isNil(var_188_4) and arg_185_1.var_.characterEffect10143ui_story == nil then
				arg_185_1.var_.characterEffect10143ui_story = var_188_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_188_5 = 0.200000002980232

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_5 and not isNil(var_188_4) then
				if arg_185_1.var_.characterEffect10143ui_story and not isNil(var_188_4) then
					arg_185_1.var_.characterEffect10143ui_story.fillFlat = true
					arg_185_1.var_.characterEffect10143ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_185_1.time_ - 0) / var_188_5)
				end
			end

			if arg_185_1.time_ >= 0 + var_188_5 and arg_185_1.time_ < 0 + var_188_5 + arg_188_0 and not isNil(var_188_4) and arg_185_1.var_.characterEffect10143ui_story then
				arg_185_1.var_.characterEffect10143ui_story.fillFlat = true
				arg_185_1.var_.characterEffect10143ui_story.fillRatio = 0.5
			end

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 then
				arg_185_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/story10145/story10145action/10145action4_2")
			end

			local var_188_6 = 0
			local var_188_7 = 0.35

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= var_188_6 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, true)

				arg_185_1.leftNameTxt_.text = arg_185_1:FormatText(StoryNameCfg[1308].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_8 = arg_185_1:GetWordFromCfg(421072046)
				local var_188_9 = arg_185_1:FormatText(var_188_8.content)

				arg_185_1.text_.text = var_188_9

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_11 = 14 <= 0 and var_188_7 or var_188_7 * (utf8.len(var_188_9) / 14)

				if (14 <= 0 and var_188_7 or var_188_7 * (utf8.len(var_188_9) / 14)) > 0 and var_188_7 < var_188_11 then
					arg_185_1.talkMaxDuration = var_188_11

					if var_188_11 + var_188_6 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_11 + var_188_6
					end
				end

				arg_185_1.text_.text = var_188_9
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421072", "421072046", "story_v_out_421072.awb") ~= 0 then
					local var_188_12 = manager.audio:GetVoiceLength("story_v_out_421072", "421072046", "story_v_out_421072.awb") / 1000

					if var_188_12 + var_188_6 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_12 + var_188_6
					end

					if var_188_8.prefab_name ~= "" and arg_185_1.actors_[var_188_8.prefab_name] ~= nil then
						local var_188_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_185_1.actors_[var_188_8.prefab_name].transform, "story_v_out_421072", "421072046", "story_v_out_421072.awb")

						arg_185_1:RecordAudio("421072046", var_188_13)
						arg_185_1:RecordAudio("421072046", var_188_13)
					else
						arg_185_1:AudioAction("play", "voice", "story_v_out_421072", "421072046", "story_v_out_421072.awb")
					end

					arg_185_1:RecordHistoryTalkVoice("story_v_out_421072", "421072046", "story_v_out_421072.awb")
				end

				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_14 = math.max(var_188_7, arg_185_1.talkMaxDuration)

			if var_188_6 <= arg_185_1.time_ and arg_185_1.time_ < var_188_6 + var_188_14 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_6) / var_188_14

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_6 + var_188_14 and arg_185_1.time_ < var_188_6 + var_188_14 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10145ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_185_1:InitPlayNodeList()
	end,
	Play421072047 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 421072047
		arg_189_1.duration_ = 5

		SetActive(arg_189_1.tipsGo_, false)

		function arg_189_1.onSingleLineFinish_()
			arg_189_1.onSingleLineUpdate_ = nil
			arg_189_1.onSingleLineFinish_ = nil
			arg_189_1.state_ = "waiting"
		end

		function arg_189_1.playNext_(arg_191_0)
			if arg_191_0 == 1 then
				arg_189_0:Play421072048(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 and not isNil(arg_189_1.actors_["10145ui_story"]) and arg_189_1.var_.characterEffect10145ui_story == nil then
				arg_189_1.var_.characterEffect10145ui_story = arg_189_1.actors_["10145ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_192_0 = 0.200000002980232

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_0 and not isNil(arg_189_1.actors_["10145ui_story"]) then
				if arg_189_1.var_.characterEffect10145ui_story and not isNil(arg_189_1.actors_["10145ui_story"]) then
					arg_189_1.var_.characterEffect10145ui_story.fillFlat = true
					arg_189_1.var_.characterEffect10145ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_189_1.time_ - 0) / var_192_0)
				end
			end

			if arg_189_1.time_ >= 0 + var_192_0 and arg_189_1.time_ < 0 + var_192_0 + arg_192_0 and not isNil(arg_189_1.actors_["10145ui_story"]) and arg_189_1.var_.characterEffect10145ui_story then
				arg_189_1.var_.characterEffect10145ui_story.fillFlat = true
				arg_189_1.var_.characterEffect10145ui_story.fillRatio = 0.5
			end

			local var_192_1 = 0
			local var_192_2 = 0.6

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= var_192_1 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				arg_189_1.leftNameTxt_.text = arg_189_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, true)
				arg_189_1.iconController_:SetSelectedState("hero")

				arg_189_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_189_1.callingController_:SetSelectedState("normal")

				arg_189_1.keyicon_.color = Color.New(1, 1, 1)
				arg_189_1.icon_.color = Color.New(1, 1, 1)

				local var_192_3 = arg_189_1:FormatText(arg_189_1:GetWordFromCfg(421072047).content)

				arg_189_1.text_.text = var_192_3

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_5 = 24 <= 0 and var_192_2 or var_192_2 * (utf8.len(var_192_3) / 24)

				if (24 <= 0 and var_192_2 or var_192_2 * (utf8.len(var_192_3) / 24)) > 0 and var_192_2 < var_192_5 then
					arg_189_1.talkMaxDuration = var_192_5

					if var_192_5 + var_192_1 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_5 + var_192_1
					end
				end

				arg_189_1.text_.text = var_192_3
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)
				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_6 = math.max(var_192_2, arg_189_1.talkMaxDuration)

			if var_192_1 <= arg_189_1.time_ and arg_189_1.time_ < var_192_1 + var_192_6 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_1) / var_192_6

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_1 + var_192_6 and arg_189_1.time_ < var_192_1 + var_192_6 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {}

		arg_189_1:InitPlayNodeList()
	end,
	Play421072048 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 421072048
		arg_193_1.duration_ = 1.67

		local var_193_0 = {
			zh = 0.999999999999,
			ja = 1.666
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
				arg_193_0:Play421072049(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				arg_193_1.var_.moveOldPos10145ui_story = arg_193_1.actors_["10145ui_story"].transform.localPosition
			end

			local var_196_0 = 0.001

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_0 then
				arg_193_1.actors_["10145ui_story"].transform.localPosition = Vector3.Lerp(arg_193_1.var_.moveOldPos10145ui_story, Vector3.New(0.78, -1, -6.2), (arg_193_1.time_ - 0) / var_196_0)
				arg_193_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_193_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_193_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_193_1.actors_["10145ui_story"].transform.position).z)
				arg_193_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_193_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_193_1.actors_["10145ui_story"].transform.localEulerAngles = arg_193_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			if arg_193_1.time_ >= 0 + var_196_0 and arg_193_1.time_ < 0 + var_196_0 + arg_196_0 then
				arg_193_1.actors_["10145ui_story"].transform.localPosition = Vector3.New(0.78, -1, -6.2)
				arg_193_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_193_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_193_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_193_1.actors_["10145ui_story"].transform.position).z)
				arg_193_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_193_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_193_1.actors_["10145ui_story"].transform.localEulerAngles = arg_193_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			local var_196_1 = arg_193_1.actors_["10145ui_story"]

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 and not isNil(var_196_1) and arg_193_1.var_.characterEffect10145ui_story == nil then
				arg_193_1.var_.characterEffect10145ui_story = var_196_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_196_2 = 0.200000002980232

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_2 and not isNil(var_196_1) then
				if arg_193_1.var_.characterEffect10145ui_story and not isNil(var_196_1) then
					arg_193_1.var_.characterEffect10145ui_story.fillFlat = false
				end
			end

			if arg_193_1.time_ >= 0 + var_196_2 and arg_193_1.time_ < 0 + var_196_2 + arg_196_0 and not isNil(var_196_1) and arg_193_1.var_.characterEffect10145ui_story then
				arg_193_1.var_.characterEffect10145ui_story.fillFlat = false
			end

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				arg_193_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/story10145/story10145action/10145action1_1")
			end

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				arg_193_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_196_4 = 0
			local var_196_5 = 0.075

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= var_196_4 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, true)

				arg_193_1.leftNameTxt_.text = arg_193_1:FormatText(StoryNameCfg[1308].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_193_1.leftNameTxt_.transform)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1.leftNameTxt_.text)
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_6 = arg_193_1:GetWordFromCfg(421072048)
				local var_196_7 = arg_193_1:FormatText(var_196_6.content)

				arg_193_1.text_.text = var_196_7

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_9 = 3 <= 0 and var_196_5 or var_196_5 * (utf8.len(var_196_7) / 3)

				if (3 <= 0 and var_196_5 or var_196_5 * (utf8.len(var_196_7) / 3)) > 0 and var_196_5 < var_196_9 then
					arg_193_1.talkMaxDuration = var_196_9

					if var_196_9 + var_196_4 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_9 + var_196_4
					end
				end

				arg_193_1.text_.text = var_196_7
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421072", "421072048", "story_v_out_421072.awb") ~= 0 then
					local var_196_10 = manager.audio:GetVoiceLength("story_v_out_421072", "421072048", "story_v_out_421072.awb") / 1000

					if var_196_10 + var_196_4 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_10 + var_196_4
					end

					if var_196_6.prefab_name ~= "" and arg_193_1.actors_[var_196_6.prefab_name] ~= nil then
						local var_196_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_193_1.actors_[var_196_6.prefab_name].transform, "story_v_out_421072", "421072048", "story_v_out_421072.awb")

						arg_193_1:RecordAudio("421072048", var_196_11)
						arg_193_1:RecordAudio("421072048", var_196_11)
					else
						arg_193_1:AudioAction("play", "voice", "story_v_out_421072", "421072048", "story_v_out_421072.awb")
					end

					arg_193_1:RecordHistoryTalkVoice("story_v_out_421072", "421072048", "story_v_out_421072.awb")
				end

				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_12 = math.max(var_196_5, arg_193_1.talkMaxDuration)

			if var_196_4 <= arg_193_1.time_ and arg_193_1.time_ < var_196_4 + var_196_12 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - var_196_4) / var_196_12

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= var_196_4 + var_196_12 and arg_193_1.time_ < var_196_4 + var_196_12 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10145ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_193_1:InitPlayNodeList()
	end,
	Play421072049 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 421072049
		arg_197_1.duration_ = 6.17

		local var_197_0 = {
			zh = 3.566,
			ja = 6.166
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
				arg_197_0:Play421072050(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 and not isNil(arg_197_1.actors_["10145ui_story"]) and arg_197_1.var_.characterEffect10145ui_story == nil then
				arg_197_1.var_.characterEffect10145ui_story = arg_197_1.actors_["10145ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_200_0 = 0.200000002980232

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_0 and not isNil(arg_197_1.actors_["10145ui_story"]) then
				if arg_197_1.var_.characterEffect10145ui_story and not isNil(arg_197_1.actors_["10145ui_story"]) then
					arg_197_1.var_.characterEffect10145ui_story.fillFlat = true
					arg_197_1.var_.characterEffect10145ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_197_1.time_ - 0) / var_200_0)
				end
			end

			if arg_197_1.time_ >= 0 + var_200_0 and arg_197_1.time_ < 0 + var_200_0 + arg_200_0 and not isNil(arg_197_1.actors_["10145ui_story"]) and arg_197_1.var_.characterEffect10145ui_story then
				arg_197_1.var_.characterEffect10145ui_story.fillFlat = true
				arg_197_1.var_.characterEffect10145ui_story.fillRatio = 0.5
			end

			local var_200_1 = 0
			local var_200_2 = 0.375

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= var_200_1 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, true)

				arg_197_1.leftNameTxt_.text = arg_197_1:FormatText(StoryNameCfg[1320].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, true)
				arg_197_1.iconController_:SetSelectedState("hero")

				arg_197_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Jackson")

				arg_197_1.callingController_:SetSelectedState("normal")

				arg_197_1.keyicon_.color = Color.New(1, 1, 1)
				arg_197_1.icon_.color = Color.New(1, 1, 1)

				local var_200_3 = arg_197_1:GetWordFromCfg(421072049)
				local var_200_4 = arg_197_1:FormatText(var_200_3.content)

				arg_197_1.text_.text = var_200_4

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_6 = 15 <= 0 and var_200_2 or var_200_2 * (utf8.len(var_200_4) / 15)

				if (15 <= 0 and var_200_2 or var_200_2 * (utf8.len(var_200_4) / 15)) > 0 and var_200_2 < var_200_6 then
					arg_197_1.talkMaxDuration = var_200_6

					if var_200_6 + var_200_1 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_6 + var_200_1
					end
				end

				arg_197_1.text_.text = var_200_4
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421072", "421072049", "story_v_out_421072.awb") ~= 0 then
					local var_200_7 = manager.audio:GetVoiceLength("story_v_out_421072", "421072049", "story_v_out_421072.awb") / 1000

					if var_200_7 + var_200_1 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_7 + var_200_1
					end

					if var_200_3.prefab_name ~= "" and arg_197_1.actors_[var_200_3.prefab_name] ~= nil then
						local var_200_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_197_1.actors_[var_200_3.prefab_name].transform, "story_v_out_421072", "421072049", "story_v_out_421072.awb")

						arg_197_1:RecordAudio("421072049", var_200_8)
						arg_197_1:RecordAudio("421072049", var_200_8)
					else
						arg_197_1:AudioAction("play", "voice", "story_v_out_421072", "421072049", "story_v_out_421072.awb")
					end

					arg_197_1:RecordHistoryTalkVoice("story_v_out_421072", "421072049", "story_v_out_421072.awb")
				end

				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_9 = math.max(var_200_2, arg_197_1.talkMaxDuration)

			if var_200_1 <= arg_197_1.time_ and arg_197_1.time_ < var_200_1 + var_200_9 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - var_200_1) / var_200_9

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= var_200_1 + var_200_9 and arg_197_1.time_ < var_200_1 + var_200_9 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {}

		arg_197_1:InitPlayNodeList()
	end,
	Play421072050 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 421072050
		arg_201_1.duration_ = 7.73

		local var_201_0 = {
			zh = 6.666,
			ja = 7.733
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
				arg_201_0:Play421072051(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			if arg_201_1.bgs_.ST34a == nil then
				local var_204_0 = Object.Instantiate(arg_201_1.paintGo_)

				var_204_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST34a")
				var_204_0.name = "ST34a"
				var_204_0.transform.parent = arg_201_1.stage_.transform
				var_204_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_201_1.bgs_.ST34a = var_204_0
			end

			if 2 < arg_201_1.time_ and arg_201_1.time_ <= 2 + arg_204_0 then
				local var_204_1 = arg_201_1.bgs_.ST34a

				arg_201_1.bgs_.ST34a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_204_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_204_2 = var_204_1:GetComponent("SpriteRenderer")

				if var_204_2 and var_204_2.sprite then
					local var_204_3 = 2 * (var_204_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_204_1.transform.localScale = Vector3.New(var_204_3 / var_204_2.sprite.bounds.size.y < var_204_3 * manager.ui.mainCameraCom_.aspect / var_204_2.sprite.bounds.size.x and var_204_3 * manager.ui.mainCameraCom_.aspect / var_204_2.sprite.bounds.size.x or var_204_3 / var_204_2.sprite.bounds.size.y, var_204_3 / var_204_2.sprite.bounds.size.y < var_204_3 * manager.ui.mainCameraCom_.aspect / var_204_2.sprite.bounds.size.x and var_204_3 * manager.ui.mainCameraCom_.aspect / var_204_2.sprite.bounds.size.x or var_204_3 / var_204_2.sprite.bounds.size.y, 0)
				end

				for iter_204_0, iter_204_1 in pairs(arg_201_1.bgs_) do
					if iter_204_0 ~= "ST34a" then
						iter_204_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_204_4 = 4

			if 4 < arg_201_1.time_ and arg_201_1.time_ <= var_204_4 + arg_204_0 then
				arg_201_1.allBtn_.enabled = false
			end

			if arg_201_1.time_ >= var_204_4 + 0.3 and arg_201_1.time_ < var_204_4 + 0.3 + arg_204_0 then
				arg_201_1.allBtn_.enabled = true
			end

			local var_204_5 = 0

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= var_204_5 + arg_204_0 then
				arg_201_1.mask_.enabled = true
				arg_201_1.mask_.raycastTarget = true

				arg_201_1:SetGaussion(false)
			end

			local var_204_6 = 2

			if var_204_5 <= arg_201_1.time_ and arg_201_1.time_ < var_204_5 + var_204_6 then
				local var_204_7 = Color.New(0, 0, 0)

				var_204_7.a = Mathf.Lerp(0, 1, (arg_201_1.time_ - var_204_5) / var_204_6)
				arg_201_1.mask_.color = var_204_7
			end

			if arg_201_1.time_ >= var_204_5 + var_204_6 and arg_201_1.time_ < var_204_5 + var_204_6 + arg_204_0 then
				local var_204_8 = Color.New(0, 0, 0)

				var_204_8.a = 1
				arg_201_1.mask_.color = var_204_8
			end

			local var_204_9 = 2

			if 2 < arg_201_1.time_ and arg_201_1.time_ <= var_204_9 + arg_204_0 then
				arg_201_1.mask_.enabled = true
				arg_201_1.mask_.raycastTarget = true

				arg_201_1:SetGaussion(false)
			end

			local var_204_10 = 2

			if var_204_9 <= arg_201_1.time_ and arg_201_1.time_ < var_204_9 + var_204_10 then
				local var_204_11 = Color.New(0, 0, 0)

				var_204_11.a = Mathf.Lerp(1, 0, (arg_201_1.time_ - var_204_9) / var_204_10)
				arg_201_1.mask_.color = var_204_11
			end

			if arg_201_1.time_ >= var_204_9 + var_204_10 and arg_201_1.time_ < var_204_9 + var_204_10 + arg_204_0 then
				local var_204_12 = Color.New(0, 0, 0)

				arg_201_1.mask_.enabled = false
				var_204_12.a = 0
				arg_201_1.mask_.color = var_204_12
			end

			local var_204_13 = arg_201_1.actors_["10145ui_story"].transform

			if 2 < arg_201_1.time_ and arg_201_1.time_ <= 2 + arg_204_0 then
				arg_201_1.var_.moveOldPos10145ui_story = var_204_13.localPosition
			end

			local var_204_14 = 0.001

			if 2 <= arg_201_1.time_ and arg_201_1.time_ < 2 + var_204_14 then
				var_204_13.localPosition = Vector3.Lerp(arg_201_1.var_.moveOldPos10145ui_story, Vector3.New(0, 100, 0), (arg_201_1.time_ - 2) / var_204_14)
				var_204_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_204_13.position).x, (manager.ui.mainCamera.transform.position - var_204_13.position).y, (manager.ui.mainCamera.transform.position - var_204_13.position).z)
				var_204_13.localEulerAngles.z = 0
				var_204_13.localEulerAngles.x = 0
				var_204_13.localEulerAngles = var_204_13.localEulerAngles
			end

			if arg_201_1.time_ >= 2 + var_204_14 and arg_201_1.time_ < 2 + var_204_14 + arg_204_0 then
				var_204_13.localPosition = Vector3.New(0, 100, 0)
				var_204_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_204_13.position).x, (manager.ui.mainCamera.transform.position - var_204_13.position).y, (manager.ui.mainCamera.transform.position - var_204_13.position).z)
				var_204_13.localEulerAngles.z = 0
				var_204_13.localEulerAngles.x = 0
				var_204_13.localEulerAngles = var_204_13.localEulerAngles
			end

			local var_204_15 = arg_201_1.actors_["10143ui_story"].transform

			if 2 < arg_201_1.time_ and arg_201_1.time_ <= 2 + arg_204_0 then
				arg_201_1.var_.moveOldPos10143ui_story = var_204_15.localPosition
			end

			local var_204_16 = 0.001

			if 2 <= arg_201_1.time_ and arg_201_1.time_ < 2 + var_204_16 then
				var_204_15.localPosition = Vector3.Lerp(arg_201_1.var_.moveOldPos10143ui_story, Vector3.New(0, 100, 0), (arg_201_1.time_ - 2) / var_204_16)
				var_204_15.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_204_15.position).x, (manager.ui.mainCamera.transform.position - var_204_15.position).y, (manager.ui.mainCamera.transform.position - var_204_15.position).z)
				var_204_15.localEulerAngles.z = 0
				var_204_15.localEulerAngles.x = 0
				var_204_15.localEulerAngles = var_204_15.localEulerAngles
			end

			if arg_201_1.time_ >= 2 + var_204_16 and arg_201_1.time_ < 2 + var_204_16 + arg_204_0 then
				var_204_15.localPosition = Vector3.New(0, 100, 0)
				var_204_15.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_204_15.position).x, (manager.ui.mainCamera.transform.position - var_204_15.position).y, (manager.ui.mainCamera.transform.position - var_204_15.position).z)
				var_204_15.localEulerAngles.z = 0
				var_204_15.localEulerAngles.x = 0
				var_204_15.localEulerAngles = var_204_15.localEulerAngles
			end

			local var_204_17 = arg_201_1.actors_["10102ui_story"].transform

			if 3.83333333333333 < arg_201_1.time_ and arg_201_1.time_ <= 3.83333333333333 + arg_204_0 then
				arg_201_1.var_.moveOldPos10102ui_story = var_204_17.localPosition
			end

			local var_204_18 = 0.001

			if 3.83333333333333 <= arg_201_1.time_ and arg_201_1.time_ < 3.83333333333333 + var_204_18 then
				var_204_17.localPosition = Vector3.Lerp(arg_201_1.var_.moveOldPos10102ui_story, Vector3.New(0, -0.985, -6.275), (arg_201_1.time_ - 3.83333333333333) / var_204_18)
				var_204_17.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_204_17.position).x, (manager.ui.mainCamera.transform.position - var_204_17.position).y, (manager.ui.mainCamera.transform.position - var_204_17.position).z)
				var_204_17.localEulerAngles.z = 0
				var_204_17.localEulerAngles.x = 0
				var_204_17.localEulerAngles = var_204_17.localEulerAngles
			end

			if arg_201_1.time_ >= 3.83333333333333 + var_204_18 and arg_201_1.time_ < 3.83333333333333 + var_204_18 + arg_204_0 then
				var_204_17.localPosition = Vector3.New(0, -0.985, -6.275)
				var_204_17.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_204_17.position).x, (manager.ui.mainCamera.transform.position - var_204_17.position).y, (manager.ui.mainCamera.transform.position - var_204_17.position).z)
				var_204_17.localEulerAngles.z = 0
				var_204_17.localEulerAngles.x = 0
				var_204_17.localEulerAngles = var_204_17.localEulerAngles
			end

			local var_204_19 = arg_201_1.actors_["10102ui_story"]

			if 3.83333333333333 < arg_201_1.time_ and arg_201_1.time_ <= 3.83333333333333 + arg_204_0 and not isNil(var_204_19) and arg_201_1.var_.characterEffect10102ui_story == nil then
				arg_201_1.var_.characterEffect10102ui_story = var_204_19:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_204_20 = 0.200000002980232

			if 3.83333333333333 <= arg_201_1.time_ and arg_201_1.time_ < 3.83333333333333 + var_204_20 and not isNil(var_204_19) then
				if arg_201_1.var_.characterEffect10102ui_story and not isNil(var_204_19) then
					arg_201_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_201_1.time_ >= 3.83333333333333 + var_204_20 and arg_201_1.time_ < 3.83333333333333 + var_204_20 + arg_204_0 and not isNil(var_204_19) and arg_201_1.var_.characterEffect10102ui_story then
				arg_201_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			if 3.83333333333333 < arg_201_1.time_ and arg_201_1.time_ <= 3.83333333333333 + arg_204_0 then
				arg_201_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action6_1")
			end

			if 3.83333333333333 < arg_201_1.time_ and arg_201_1.time_ <= 3.83333333333333 + arg_204_0 then
				arg_201_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			if 0.1 < arg_201_1.time_ and arg_201_1.time_ <= 0.1 + arg_204_0 then
				arg_201_1:AudioAction("stop", "effect", "se_story_140", "se_story_140_amb_lab", "")
			end

			if 1.6 < arg_201_1.time_ and arg_201_1.time_ <= 1.6 + arg_204_0 then
				arg_201_1:AudioAction("play", "effect", "se_story_143", "se_story_143_amb_lift", "")
			end

			if arg_201_1.frameCnt_ <= 1 then
				arg_201_1.dialog_:SetActive(false)
			end

			local var_204_24 = 4
			local var_204_25 = 0.25

			if 4 < arg_201_1.time_ and arg_201_1.time_ <= var_204_24 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0

				arg_201_1.dialog_:SetActive(true)

				arg_201_1.dialogCg_.alpha = 0

				local var_204_26 = LeanTween.value(arg_201_1.dialog_, 0, 1, 0.3)

				var_204_26:setOnUpdate(LuaHelper.FloatAction(function(arg_205_0)
					arg_201_1.dialogCg_.alpha = arg_205_0
				end))
				var_204_26:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_201_1.dialog_)
					var_204_26:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_201_1.duration_ = arg_201_1.duration_ + 0.3

				SetActive(arg_201_1.leftNameGo_, true)

				arg_201_1.leftNameTxt_.text = arg_201_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_201_1.leftNameTxt_.transform)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1.leftNameTxt_.text)
				SetActive(arg_201_1.iconTrs_.gameObject, false)
				arg_201_1.callingController_:SetSelectedState("normal")

				local var_204_27 = arg_201_1:GetWordFromCfg(421072050)
				local var_204_28 = arg_201_1:FormatText(var_204_27.content)

				arg_201_1.text_.text = var_204_28

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_30 = 10 <= 0 and var_204_25 or var_204_25 * (utf8.len(var_204_28) / 10)

				if (10 <= 0 and var_204_25 or var_204_25 * (utf8.len(var_204_28) / 10)) > 0 and var_204_25 < var_204_30 then
					arg_201_1.talkMaxDuration = var_204_30
					var_204_24 = var_204_24 + 0.3

					if var_204_30 + var_204_24 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_30 + var_204_24
					end
				end

				arg_201_1.text_.text = var_204_28
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421072", "421072050", "story_v_out_421072.awb") ~= 0 then
					local var_204_31 = manager.audio:GetVoiceLength("story_v_out_421072", "421072050", "story_v_out_421072.awb") / 1000

					if var_204_31 + var_204_24 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_31 + var_204_24
					end

					if var_204_27.prefab_name ~= "" and arg_201_1.actors_[var_204_27.prefab_name] ~= nil then
						local var_204_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_201_1.actors_[var_204_27.prefab_name].transform, "story_v_out_421072", "421072050", "story_v_out_421072.awb")

						arg_201_1:RecordAudio("421072050", var_204_32)
						arg_201_1:RecordAudio("421072050", var_204_32)
					else
						arg_201_1:AudioAction("play", "voice", "story_v_out_421072", "421072050", "story_v_out_421072.awb")
					end

					arg_201_1:RecordHistoryTalkVoice("story_v_out_421072", "421072050", "story_v_out_421072.awb")
				end

				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_33 = var_204_24 + 0.3
			local var_204_34 = math.max(var_204_25, arg_201_1.talkMaxDuration)

			if var_204_24 + 0.3 <= arg_201_1.time_ and arg_201_1.time_ < var_204_33 + var_204_34 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - var_204_33) / var_204_34

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= var_204_33 + var_204_34 and arg_201_1.time_ < var_204_33 + var_204_34 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10145ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10143ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.83333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_201_1:InitPlayNodeList()
	end,
	Play421072051 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 421072051
		arg_207_1.duration_ = 5

		SetActive(arg_207_1.tipsGo_, false)

		function arg_207_1.onSingleLineFinish_()
			arg_207_1.onSingleLineUpdate_ = nil
			arg_207_1.onSingleLineFinish_ = nil
			arg_207_1.state_ = "waiting"
		end

		function arg_207_1.playNext_(arg_209_0)
			if arg_209_0 == 1 then
				arg_207_0:Play421072052(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 and not isNil(arg_207_1.actors_["10102ui_story"]) and arg_207_1.var_.characterEffect10102ui_story == nil then
				arg_207_1.var_.characterEffect10102ui_story = arg_207_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_210_0 = 0.200000002980232

			if 0 <= arg_207_1.time_ and arg_207_1.time_ < 0 + var_210_0 and not isNil(arg_207_1.actors_["10102ui_story"]) then
				if arg_207_1.var_.characterEffect10102ui_story and not isNil(arg_207_1.actors_["10102ui_story"]) then
					arg_207_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_207_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_207_1.time_ - 0) / var_210_0)
				end
			end

			if arg_207_1.time_ >= 0 + var_210_0 and arg_207_1.time_ < 0 + var_210_0 + arg_210_0 and not isNil(arg_207_1.actors_["10102ui_story"]) and arg_207_1.var_.characterEffect10102ui_story then
				arg_207_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_207_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			local var_210_1 = 0
			local var_210_2 = 0.275

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

				local var_210_3 = arg_207_1:FormatText(arg_207_1:GetWordFromCfg(421072051).content)

				arg_207_1.text_.text = var_210_3

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_5 = 11 <= 0 and var_210_2 or var_210_2 * (utf8.len(var_210_3) / 11)

				if (11 <= 0 and var_210_2 or var_210_2 * (utf8.len(var_210_3) / 11)) > 0 and var_210_2 < var_210_5 then
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
	Play421072052 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 421072052
		arg_211_1.duration_ = 8.37

		local var_211_0 = {
			zh = 6.866,
			ja = 8.366
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
				arg_211_0:Play421072053(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 then
				arg_211_1.var_.moveOldPos10102ui_story = arg_211_1.actors_["10102ui_story"].transform.localPosition
			end

			local var_214_0 = 0.001

			if 0 <= arg_211_1.time_ and arg_211_1.time_ < 0 + var_214_0 then
				arg_211_1.actors_["10102ui_story"].transform.localPosition = Vector3.Lerp(arg_211_1.var_.moveOldPos10102ui_story, Vector3.New(0, 100, 0), (arg_211_1.time_ - 0) / var_214_0)
				arg_211_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_211_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_211_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_211_1.actors_["10102ui_story"].transform.position).z)
				arg_211_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_211_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_211_1.actors_["10102ui_story"].transform.localEulerAngles = arg_211_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			if arg_211_1.time_ >= 0 + var_214_0 and arg_211_1.time_ < 0 + var_214_0 + arg_214_0 then
				arg_211_1.actors_["10102ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_211_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_211_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_211_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_211_1.actors_["10102ui_story"].transform.position).z)
				arg_211_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_211_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_211_1.actors_["10102ui_story"].transform.localEulerAngles = arg_211_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			local var_214_1 = 0
			local var_214_2 = 0.675

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= var_214_1 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, true)

				arg_211_1.leftNameTxt_.text = arg_211_1:FormatText(StoryNameCfg[1320].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_211_1.leftNameTxt_.transform)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1.leftNameTxt_.text)
				SetActive(arg_211_1.iconTrs_.gameObject, true)
				arg_211_1.iconController_:SetSelectedState("hero")

				arg_211_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Jackson")

				arg_211_1.callingController_:SetSelectedState("normal")

				arg_211_1.keyicon_.color = Color.New(1, 1, 1)
				arg_211_1.icon_.color = Color.New(1, 1, 1)

				local var_214_3 = arg_211_1:GetWordFromCfg(421072052)
				local var_214_4 = arg_211_1:FormatText(var_214_3.content)

				arg_211_1.text_.text = var_214_4

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_6 = 27 <= 0 and var_214_2 or var_214_2 * (utf8.len(var_214_4) / 27)

				if (27 <= 0 and var_214_2 or var_214_2 * (utf8.len(var_214_4) / 27)) > 0 and var_214_2 < var_214_6 then
					arg_211_1.talkMaxDuration = var_214_6

					if var_214_6 + var_214_1 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_6 + var_214_1
					end
				end

				arg_211_1.text_.text = var_214_4
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421072", "421072052", "story_v_out_421072.awb") ~= 0 then
					local var_214_7 = manager.audio:GetVoiceLength("story_v_out_421072", "421072052", "story_v_out_421072.awb") / 1000

					if var_214_7 + var_214_1 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_7 + var_214_1
					end

					if var_214_3.prefab_name ~= "" and arg_211_1.actors_[var_214_3.prefab_name] ~= nil then
						local var_214_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_211_1.actors_[var_214_3.prefab_name].transform, "story_v_out_421072", "421072052", "story_v_out_421072.awb")

						arg_211_1:RecordAudio("421072052", var_214_8)
						arg_211_1:RecordAudio("421072052", var_214_8)
					else
						arg_211_1:AudioAction("play", "voice", "story_v_out_421072", "421072052", "story_v_out_421072.awb")
					end

					arg_211_1:RecordHistoryTalkVoice("story_v_out_421072", "421072052", "story_v_out_421072.awb")
				end

				arg_211_1:RecordContent(arg_211_1.text_.text)
			end

			local var_214_9 = math.max(var_214_2, arg_211_1.talkMaxDuration)

			if var_214_1 <= arg_211_1.time_ and arg_211_1.time_ < var_214_1 + var_214_9 then
				arg_211_1.typewritter.percent = (arg_211_1.time_ - var_214_1) / var_214_9

				arg_211_1.typewritter:SetDirty()
			end

			if arg_211_1.time_ >= var_214_1 + var_214_9 and arg_211_1.time_ < var_214_1 + var_214_9 + arg_214_0 then
				arg_211_1.typewritter.percent = 1

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(true)
			end
		end

		arg_211_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
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
	Play421072053 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 421072053
		arg_215_1.duration_ = 5.83

		local var_215_0 = {
			zh = 4.333,
			ja = 5.833
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
				arg_215_0:Play421072054(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 then
				arg_215_1.var_.moveOldPos10143ui_story = arg_215_1.actors_["10143ui_story"].transform.localPosition
			end

			local var_218_0 = 0.001

			if 0 <= arg_215_1.time_ and arg_215_1.time_ < 0 + var_218_0 then
				arg_215_1.actors_["10143ui_story"].transform.localPosition = Vector3.Lerp(arg_215_1.var_.moveOldPos10143ui_story, Vector3.New(0, -1.06, -6), (arg_215_1.time_ - 0) / var_218_0)
				arg_215_1.actors_["10143ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_215_1.actors_["10143ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_215_1.actors_["10143ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_215_1.actors_["10143ui_story"].transform.position).z)
				arg_215_1.actors_["10143ui_story"].transform.localEulerAngles.z = 0
				arg_215_1.actors_["10143ui_story"].transform.localEulerAngles.x = 0
				arg_215_1.actors_["10143ui_story"].transform.localEulerAngles = arg_215_1.actors_["10143ui_story"].transform.localEulerAngles
			end

			if arg_215_1.time_ >= 0 + var_218_0 and arg_215_1.time_ < 0 + var_218_0 + arg_218_0 then
				arg_215_1.actors_["10143ui_story"].transform.localPosition = Vector3.New(0, -1.06, -6)
				arg_215_1.actors_["10143ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_215_1.actors_["10143ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_215_1.actors_["10143ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_215_1.actors_["10143ui_story"].transform.position).z)
				arg_215_1.actors_["10143ui_story"].transform.localEulerAngles.z = 0
				arg_215_1.actors_["10143ui_story"].transform.localEulerAngles.x = 0
				arg_215_1.actors_["10143ui_story"].transform.localEulerAngles = arg_215_1.actors_["10143ui_story"].transform.localEulerAngles
			end

			local var_218_1 = arg_215_1.actors_["10143ui_story"]

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 and not isNil(var_218_1) and arg_215_1.var_.characterEffect10143ui_story == nil then
				arg_215_1.var_.characterEffect10143ui_story = var_218_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_218_2 = 0.200000002980232

			if 0 <= arg_215_1.time_ and arg_215_1.time_ < 0 + var_218_2 and not isNil(var_218_1) then
				if arg_215_1.var_.characterEffect10143ui_story and not isNil(var_218_1) then
					arg_215_1.var_.characterEffect10143ui_story.fillFlat = false
				end
			end

			if arg_215_1.time_ >= 0 + var_218_2 and arg_215_1.time_ < 0 + var_218_2 + arg_218_0 and not isNil(var_218_1) and arg_215_1.var_.characterEffect10143ui_story then
				arg_215_1.var_.characterEffect10143ui_story.fillFlat = false
			end

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 then
				arg_215_1:PlayTimeline("10143ui_story", "StoryTimeline/CharAction/story10143/story10143action/10143action6_1")
			end

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 then
				arg_215_1:PlayTimeline("10143ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_218_4 = 0
			local var_218_5 = 0.45

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= var_218_4 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, true)

				arg_215_1.leftNameTxt_.text = arg_215_1:FormatText(StoryNameCfg[1307].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_215_1.leftNameTxt_.transform)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1.leftNameTxt_.text)
				SetActive(arg_215_1.iconTrs_.gameObject, false)
				arg_215_1.callingController_:SetSelectedState("normal")

				local var_218_6 = arg_215_1:GetWordFromCfg(421072053)
				local var_218_7 = arg_215_1:FormatText(var_218_6.content)

				arg_215_1.text_.text = var_218_7

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_9 = 18 <= 0 and var_218_5 or var_218_5 * (utf8.len(var_218_7) / 18)

				if (18 <= 0 and var_218_5 or var_218_5 * (utf8.len(var_218_7) / 18)) > 0 and var_218_5 < var_218_9 then
					arg_215_1.talkMaxDuration = var_218_9

					if var_218_9 + var_218_4 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_9 + var_218_4
					end
				end

				arg_215_1.text_.text = var_218_7
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421072", "421072053", "story_v_out_421072.awb") ~= 0 then
					local var_218_10 = manager.audio:GetVoiceLength("story_v_out_421072", "421072053", "story_v_out_421072.awb") / 1000

					if var_218_10 + var_218_4 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_10 + var_218_4
					end

					if var_218_6.prefab_name ~= "" and arg_215_1.actors_[var_218_6.prefab_name] ~= nil then
						local var_218_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_215_1.actors_[var_218_6.prefab_name].transform, "story_v_out_421072", "421072053", "story_v_out_421072.awb")

						arg_215_1:RecordAudio("421072053", var_218_11)
						arg_215_1:RecordAudio("421072053", var_218_11)
					else
						arg_215_1:AudioAction("play", "voice", "story_v_out_421072", "421072053", "story_v_out_421072.awb")
					end

					arg_215_1:RecordHistoryTalkVoice("story_v_out_421072", "421072053", "story_v_out_421072.awb")
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

		arg_215_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10143ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_215_1:InitPlayNodeList()
	end,
	Play421072054 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 421072054
		arg_219_1.duration_ = 4.63

		local var_219_0 = {
			zh = 4.166,
			ja = 4.633
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
				arg_219_0:Play421072055(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 and not isNil(arg_219_1.actors_["10143ui_story"]) and arg_219_1.var_.characterEffect10143ui_story == nil then
				arg_219_1.var_.characterEffect10143ui_story = arg_219_1.actors_["10143ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_222_0 = 0.200000002980232

			if 0 <= arg_219_1.time_ and arg_219_1.time_ < 0 + var_222_0 and not isNil(arg_219_1.actors_["10143ui_story"]) then
				if arg_219_1.var_.characterEffect10143ui_story and not isNil(arg_219_1.actors_["10143ui_story"]) then
					arg_219_1.var_.characterEffect10143ui_story.fillFlat = true
					arg_219_1.var_.characterEffect10143ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_219_1.time_ - 0) / var_222_0)
				end
			end

			if arg_219_1.time_ >= 0 + var_222_0 and arg_219_1.time_ < 0 + var_222_0 + arg_222_0 and not isNil(arg_219_1.actors_["10143ui_story"]) and arg_219_1.var_.characterEffect10143ui_story then
				arg_219_1.var_.characterEffect10143ui_story.fillFlat = true
				arg_219_1.var_.characterEffect10143ui_story.fillRatio = 0.5
			end

			local var_222_1 = 0
			local var_222_2 = 0.375

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= var_222_1 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0
				arg_219_1.dialogCg_.alpha = 1

				arg_219_1.dialog_:SetActive(true)
				SetActive(arg_219_1.leftNameGo_, true)

				arg_219_1.leftNameTxt_.text = arg_219_1:FormatText(StoryNameCfg[1320].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_219_1.leftNameTxt_.transform)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1.leftNameTxt_.text)
				SetActive(arg_219_1.iconTrs_.gameObject, true)
				arg_219_1.iconController_:SetSelectedState("hero")

				arg_219_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Jackson")

				arg_219_1.callingController_:SetSelectedState("normal")

				arg_219_1.keyicon_.color = Color.New(1, 1, 1)
				arg_219_1.icon_.color = Color.New(1, 1, 1)

				local var_222_3 = arg_219_1:GetWordFromCfg(421072054)
				local var_222_4 = arg_219_1:FormatText(var_222_3.content)

				arg_219_1.text_.text = var_222_4

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_6 = 15 <= 0 and var_222_2 or var_222_2 * (utf8.len(var_222_4) / 15)

				if (15 <= 0 and var_222_2 or var_222_2 * (utf8.len(var_222_4) / 15)) > 0 and var_222_2 < var_222_6 then
					arg_219_1.talkMaxDuration = var_222_6

					if var_222_6 + var_222_1 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_6 + var_222_1
					end
				end

				arg_219_1.text_.text = var_222_4
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421072", "421072054", "story_v_out_421072.awb") ~= 0 then
					local var_222_7 = manager.audio:GetVoiceLength("story_v_out_421072", "421072054", "story_v_out_421072.awb") / 1000

					if var_222_7 + var_222_1 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_7 + var_222_1
					end

					if var_222_3.prefab_name ~= "" and arg_219_1.actors_[var_222_3.prefab_name] ~= nil then
						local var_222_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_219_1.actors_[var_222_3.prefab_name].transform, "story_v_out_421072", "421072054", "story_v_out_421072.awb")

						arg_219_1:RecordAudio("421072054", var_222_8)
						arg_219_1:RecordAudio("421072054", var_222_8)
					else
						arg_219_1:AudioAction("play", "voice", "story_v_out_421072", "421072054", "story_v_out_421072.awb")
					end

					arg_219_1:RecordHistoryTalkVoice("story_v_out_421072", "421072054", "story_v_out_421072.awb")
				end

				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_9 = math.max(var_222_2, arg_219_1.talkMaxDuration)

			if var_222_1 <= arg_219_1.time_ and arg_219_1.time_ < var_222_1 + var_222_9 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - var_222_1) / var_222_9

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= var_222_1 + var_222_9 and arg_219_1.time_ < var_222_1 + var_222_9 + arg_222_0 then
				arg_219_1.typewritter.percent = 1

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(true)
			end
		end

		arg_219_1.nodeConfigList_ = {}

		arg_219_1:InitPlayNodeList()
	end,
	Play421072055 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 421072055
		arg_223_1.duration_ = 8.17

		local var_223_0 = {
			zh = 5.933,
			ja = 8.166
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
				arg_223_0:Play421072056(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 then
				arg_223_1.var_.moveOldPos1047ui_story = arg_223_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_226_0 = 0.001

			if 0 <= arg_223_1.time_ and arg_223_1.time_ < 0 + var_226_0 then
				arg_223_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_223_1.var_.moveOldPos1047ui_story, Vector3.New(0.74, -1.13, -6.2), (arg_223_1.time_ - 0) / var_226_0)
				arg_223_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_223_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_223_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_223_1.actors_["1047ui_story"].transform.position).z)
				arg_223_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_223_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_223_1.actors_["1047ui_story"].transform.localEulerAngles = arg_223_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_223_1.time_ >= 0 + var_226_0 and arg_223_1.time_ < 0 + var_226_0 + arg_226_0 then
				arg_223_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0.74, -1.13, -6.2)
				arg_223_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_223_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_223_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_223_1.actors_["1047ui_story"].transform.position).z)
				arg_223_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_223_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_223_1.actors_["1047ui_story"].transform.localEulerAngles = arg_223_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_226_1 = arg_223_1.actors_["10143ui_story"].transform

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 then
				arg_223_1.var_.moveOldPos10143ui_story = var_226_1.localPosition
			end

			local var_226_2 = 0.001

			if 0 <= arg_223_1.time_ and arg_223_1.time_ < 0 + var_226_2 then
				var_226_1.localPosition = Vector3.Lerp(arg_223_1.var_.moveOldPos10143ui_story, Vector3.New(-0.72, -1.06, -6), (arg_223_1.time_ - 0) / var_226_2)
				var_226_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_226_1.position).x, (manager.ui.mainCamera.transform.position - var_226_1.position).y, (manager.ui.mainCamera.transform.position - var_226_1.position).z)
				var_226_1.localEulerAngles.z = 0
				var_226_1.localEulerAngles.x = 0
				var_226_1.localEulerAngles = var_226_1.localEulerAngles
			end

			if arg_223_1.time_ >= 0 + var_226_2 and arg_223_1.time_ < 0 + var_226_2 + arg_226_0 then
				var_226_1.localPosition = Vector3.New(-0.72, -1.06, -6)
				var_226_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_226_1.position).x, (manager.ui.mainCamera.transform.position - var_226_1.position).y, (manager.ui.mainCamera.transform.position - var_226_1.position).z)
				var_226_1.localEulerAngles.z = 0
				var_226_1.localEulerAngles.x = 0
				var_226_1.localEulerAngles = var_226_1.localEulerAngles
			end

			local var_226_3 = arg_223_1.actors_["1047ui_story"]

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 and not isNil(var_226_3) and arg_223_1.var_.characterEffect1047ui_story == nil then
				arg_223_1.var_.characterEffect1047ui_story = var_226_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_226_4 = 0.200000002980232

			if 0 <= arg_223_1.time_ and arg_223_1.time_ < 0 + var_226_4 and not isNil(var_226_3) then
				if arg_223_1.var_.characterEffect1047ui_story and not isNil(var_226_3) then
					arg_223_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_223_1.time_ >= 0 + var_226_4 and arg_223_1.time_ < 0 + var_226_4 + arg_226_0 and not isNil(var_226_3) and arg_223_1.var_.characterEffect1047ui_story then
				arg_223_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 then
				arg_223_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action7_1")
			end

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 then
				arg_223_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_226_6 = 0
			local var_226_7 = 0.7

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= var_226_6 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0
				arg_223_1.dialogCg_.alpha = 1

				arg_223_1.dialog_:SetActive(true)
				SetActive(arg_223_1.leftNameGo_, true)

				arg_223_1.leftNameTxt_.text = arg_223_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_223_1.leftNameTxt_.transform)

				arg_223_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_223_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_223_1:RecordName(arg_223_1.leftNameTxt_.text)
				SetActive(arg_223_1.iconTrs_.gameObject, false)
				arg_223_1.callingController_:SetSelectedState("normal")

				local var_226_8 = arg_223_1:GetWordFromCfg(421072055)
				local var_226_9 = arg_223_1:FormatText(var_226_8.content)

				arg_223_1.text_.text = var_226_9

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_11 = 28 <= 0 and var_226_7 or var_226_7 * (utf8.len(var_226_9) / 28)

				if (28 <= 0 and var_226_7 or var_226_7 * (utf8.len(var_226_9) / 28)) > 0 and var_226_7 < var_226_11 then
					arg_223_1.talkMaxDuration = var_226_11

					if var_226_11 + var_226_6 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_11 + var_226_6
					end
				end

				arg_223_1.text_.text = var_226_9
				arg_223_1.typewritter.percent = 0

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421072", "421072055", "story_v_out_421072.awb") ~= 0 then
					local var_226_12 = manager.audio:GetVoiceLength("story_v_out_421072", "421072055", "story_v_out_421072.awb") / 1000

					if var_226_12 + var_226_6 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_12 + var_226_6
					end

					if var_226_8.prefab_name ~= "" and arg_223_1.actors_[var_226_8.prefab_name] ~= nil then
						local var_226_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_223_1.actors_[var_226_8.prefab_name].transform, "story_v_out_421072", "421072055", "story_v_out_421072.awb")

						arg_223_1:RecordAudio("421072055", var_226_13)
						arg_223_1:RecordAudio("421072055", var_226_13)
					else
						arg_223_1:AudioAction("play", "voice", "story_v_out_421072", "421072055", "story_v_out_421072.awb")
					end

					arg_223_1:RecordHistoryTalkVoice("story_v_out_421072", "421072055", "story_v_out_421072.awb")
				end

				arg_223_1:RecordContent(arg_223_1.text_.text)
			end

			local var_226_14 = math.max(var_226_7, arg_223_1.talkMaxDuration)

			if var_226_6 <= arg_223_1.time_ and arg_223_1.time_ < var_226_6 + var_226_14 then
				arg_223_1.typewritter.percent = (arg_223_1.time_ - var_226_6) / var_226_14

				arg_223_1.typewritter:SetDirty()
			end

			if arg_223_1.time_ >= var_226_6 + var_226_14 and arg_223_1.time_ < var_226_6 + var_226_14 + arg_226_0 then
				arg_223_1.typewritter.percent = 1

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(true)
			end
		end

		arg_223_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10143ui_story",
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
	Play421072056 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 421072056
		arg_227_1.duration_ = 4

		local var_227_0 = {
			zh = 4,
			ja = 2.466
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
				arg_227_0:Play421072057(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 then
				arg_227_1.var_.moveOldPos10143ui_story = arg_227_1.actors_["10143ui_story"].transform.localPosition
			end

			local var_230_0 = 0.001

			if 0 <= arg_227_1.time_ and arg_227_1.time_ < 0 + var_230_0 then
				arg_227_1.actors_["10143ui_story"].transform.localPosition = Vector3.Lerp(arg_227_1.var_.moveOldPos10143ui_story, Vector3.New(-0.72, -1.06, -6), (arg_227_1.time_ - 0) / var_230_0)
				arg_227_1.actors_["10143ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_227_1.actors_["10143ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_227_1.actors_["10143ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_227_1.actors_["10143ui_story"].transform.position).z)
				arg_227_1.actors_["10143ui_story"].transform.localEulerAngles.z = 0
				arg_227_1.actors_["10143ui_story"].transform.localEulerAngles.x = 0
				arg_227_1.actors_["10143ui_story"].transform.localEulerAngles = arg_227_1.actors_["10143ui_story"].transform.localEulerAngles
			end

			if arg_227_1.time_ >= 0 + var_230_0 and arg_227_1.time_ < 0 + var_230_0 + arg_230_0 then
				arg_227_1.actors_["10143ui_story"].transform.localPosition = Vector3.New(-0.72, -1.06, -6)
				arg_227_1.actors_["10143ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_227_1.actors_["10143ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_227_1.actors_["10143ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_227_1.actors_["10143ui_story"].transform.position).z)
				arg_227_1.actors_["10143ui_story"].transform.localEulerAngles.z = 0
				arg_227_1.actors_["10143ui_story"].transform.localEulerAngles.x = 0
				arg_227_1.actors_["10143ui_story"].transform.localEulerAngles = arg_227_1.actors_["10143ui_story"].transform.localEulerAngles
			end

			local var_230_1 = arg_227_1.actors_["10143ui_story"]

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 and not isNil(var_230_1) and arg_227_1.var_.characterEffect10143ui_story == nil then
				arg_227_1.var_.characterEffect10143ui_story = var_230_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_230_2 = 0.200000002980232

			if 0 <= arg_227_1.time_ and arg_227_1.time_ < 0 + var_230_2 and not isNil(var_230_1) then
				if arg_227_1.var_.characterEffect10143ui_story and not isNil(var_230_1) then
					arg_227_1.var_.characterEffect10143ui_story.fillFlat = false
				end
			end

			if arg_227_1.time_ >= 0 + var_230_2 and arg_227_1.time_ < 0 + var_230_2 + arg_230_0 and not isNil(var_230_1) and arg_227_1.var_.characterEffect10143ui_story then
				arg_227_1.var_.characterEffect10143ui_story.fillFlat = false
			end

			local var_230_4 = arg_227_1.actors_["1047ui_story"]

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 and not isNil(var_230_4) and arg_227_1.var_.characterEffect1047ui_story == nil then
				arg_227_1.var_.characterEffect1047ui_story = var_230_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_230_5 = 0.200000002980232

			if 0 <= arg_227_1.time_ and arg_227_1.time_ < 0 + var_230_5 and not isNil(var_230_4) then
				if arg_227_1.var_.characterEffect1047ui_story and not isNil(var_230_4) then
					arg_227_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_227_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_227_1.time_ - 0) / var_230_5)
				end
			end

			if arg_227_1.time_ >= 0 + var_230_5 and arg_227_1.time_ < 0 + var_230_5 + arg_230_0 and not isNil(var_230_4) and arg_227_1.var_.characterEffect1047ui_story then
				arg_227_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_227_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 then
				arg_227_1:PlayTimeline("10143ui_story", "StoryTimeline/CharAction/story10143/story10143actionlink/10143action467")
			end

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 then
				arg_227_1:PlayTimeline("10143ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_230_6 = 0
			local var_230_7 = 0.375

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= var_230_6 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0
				arg_227_1.dialogCg_.alpha = 1

				arg_227_1.dialog_:SetActive(true)
				SetActive(arg_227_1.leftNameGo_, true)

				arg_227_1.leftNameTxt_.text = arg_227_1:FormatText(StoryNameCfg[1307].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_227_1.leftNameTxt_.transform)

				arg_227_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_227_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_227_1:RecordName(arg_227_1.leftNameTxt_.text)
				SetActive(arg_227_1.iconTrs_.gameObject, false)
				arg_227_1.callingController_:SetSelectedState("normal")

				local var_230_8 = arg_227_1:GetWordFromCfg(421072056)
				local var_230_9 = arg_227_1:FormatText(var_230_8.content)

				arg_227_1.text_.text = var_230_9

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_11 = 15 <= 0 and var_230_7 or var_230_7 * (utf8.len(var_230_9) / 15)

				if (15 <= 0 and var_230_7 or var_230_7 * (utf8.len(var_230_9) / 15)) > 0 and var_230_7 < var_230_11 then
					arg_227_1.talkMaxDuration = var_230_11

					if var_230_11 + var_230_6 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_11 + var_230_6
					end
				end

				arg_227_1.text_.text = var_230_9
				arg_227_1.typewritter.percent = 0

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421072", "421072056", "story_v_out_421072.awb") ~= 0 then
					local var_230_12 = manager.audio:GetVoiceLength("story_v_out_421072", "421072056", "story_v_out_421072.awb") / 1000

					if var_230_12 + var_230_6 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_12 + var_230_6
					end

					if var_230_8.prefab_name ~= "" and arg_227_1.actors_[var_230_8.prefab_name] ~= nil then
						local var_230_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_227_1.actors_[var_230_8.prefab_name].transform, "story_v_out_421072", "421072056", "story_v_out_421072.awb")

						arg_227_1:RecordAudio("421072056", var_230_13)
						arg_227_1:RecordAudio("421072056", var_230_13)
					else
						arg_227_1:AudioAction("play", "voice", "story_v_out_421072", "421072056", "story_v_out_421072.awb")
					end

					arg_227_1:RecordHistoryTalkVoice("story_v_out_421072", "421072056", "story_v_out_421072.awb")
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
				actorName = "10143ui_story",
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
	Play421072057 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 421072057
		arg_231_1.duration_ = 5.97

		local var_231_0 = {
			zh = 4.2,
			ja = 5.966
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
				arg_231_0:Play421072058(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 then
				arg_231_1.var_.moveOldPos10102ui_story = arg_231_1.actors_["10102ui_story"].transform.localPosition
			end

			local var_234_0 = 0.001

			if 0 <= arg_231_1.time_ and arg_231_1.time_ < 0 + var_234_0 then
				arg_231_1.actors_["10102ui_story"].transform.localPosition = Vector3.Lerp(arg_231_1.var_.moveOldPos10102ui_story, Vector3.New(0.7, -0.985, -6.275), (arg_231_1.time_ - 0) / var_234_0)
				arg_231_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_231_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_231_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_231_1.actors_["10102ui_story"].transform.position).z)
				arg_231_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_231_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_231_1.actors_["10102ui_story"].transform.localEulerAngles = arg_231_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			if arg_231_1.time_ >= 0 + var_234_0 and arg_231_1.time_ < 0 + var_234_0 + arg_234_0 then
				arg_231_1.actors_["10102ui_story"].transform.localPosition = Vector3.New(0.7, -0.985, -6.275)
				arg_231_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_231_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_231_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_231_1.actors_["10102ui_story"].transform.position).z)
				arg_231_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_231_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_231_1.actors_["10102ui_story"].transform.localEulerAngles = arg_231_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			local var_234_1 = arg_231_1.actors_["1047ui_story"].transform

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 then
				arg_231_1.var_.moveOldPos1047ui_story = var_234_1.localPosition
			end

			local var_234_2 = 0.001

			if 0 <= arg_231_1.time_ and arg_231_1.time_ < 0 + var_234_2 then
				var_234_1.localPosition = Vector3.Lerp(arg_231_1.var_.moveOldPos1047ui_story, Vector3.New(0, 100, 0), (arg_231_1.time_ - 0) / var_234_2)
				var_234_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_234_1.position).x, (manager.ui.mainCamera.transform.position - var_234_1.position).y, (manager.ui.mainCamera.transform.position - var_234_1.position).z)
				var_234_1.localEulerAngles.z = 0
				var_234_1.localEulerAngles.x = 0
				var_234_1.localEulerAngles = var_234_1.localEulerAngles
			end

			if arg_231_1.time_ >= 0 + var_234_2 and arg_231_1.time_ < 0 + var_234_2 + arg_234_0 then
				var_234_1.localPosition = Vector3.New(0, 100, 0)
				var_234_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_234_1.position).x, (manager.ui.mainCamera.transform.position - var_234_1.position).y, (manager.ui.mainCamera.transform.position - var_234_1.position).z)
				var_234_1.localEulerAngles.z = 0
				var_234_1.localEulerAngles.x = 0
				var_234_1.localEulerAngles = var_234_1.localEulerAngles
			end

			local var_234_3 = arg_231_1.actors_["10102ui_story"]

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 and not isNil(var_234_3) and arg_231_1.var_.characterEffect10102ui_story == nil then
				arg_231_1.var_.characterEffect10102ui_story = var_234_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_234_4 = 0.200000002980232

			if 0 <= arg_231_1.time_ and arg_231_1.time_ < 0 + var_234_4 and not isNil(var_234_3) then
				if arg_231_1.var_.characterEffect10102ui_story and not isNil(var_234_3) then
					arg_231_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_231_1.time_ >= 0 + var_234_4 and arg_231_1.time_ < 0 + var_234_4 + arg_234_0 and not isNil(var_234_3) and arg_231_1.var_.characterEffect10102ui_story then
				arg_231_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			local var_234_6 = arg_231_1.actors_["10143ui_story"]

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 and not isNil(var_234_6) and arg_231_1.var_.characterEffect10143ui_story == nil then
				arg_231_1.var_.characterEffect10143ui_story = var_234_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_234_7 = 0.200000002980232

			if 0 <= arg_231_1.time_ and arg_231_1.time_ < 0 + var_234_7 and not isNil(var_234_6) then
				if arg_231_1.var_.characterEffect10143ui_story and not isNil(var_234_6) then
					arg_231_1.var_.characterEffect10143ui_story.fillFlat = true
					arg_231_1.var_.characterEffect10143ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_231_1.time_ - 0) / var_234_7)
				end
			end

			if arg_231_1.time_ >= 0 + var_234_7 and arg_231_1.time_ < 0 + var_234_7 + arg_234_0 and not isNil(var_234_6) and arg_231_1.var_.characterEffect10143ui_story then
				arg_231_1.var_.characterEffect10143ui_story.fillFlat = true
				arg_231_1.var_.characterEffect10143ui_story.fillRatio = 0.5
			end

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 then
				arg_231_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action4_1")
			end

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 then
				arg_231_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_234_8 = 0
			local var_234_9 = 0.6

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= var_234_8 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0
				arg_231_1.dialogCg_.alpha = 1

				arg_231_1.dialog_:SetActive(true)
				SetActive(arg_231_1.leftNameGo_, true)

				arg_231_1.leftNameTxt_.text = arg_231_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_231_1.leftNameTxt_.transform)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1.leftNameTxt_.text)
				SetActive(arg_231_1.iconTrs_.gameObject, false)
				arg_231_1.callingController_:SetSelectedState("normal")

				local var_234_10 = arg_231_1:GetWordFromCfg(421072057)
				local var_234_11 = arg_231_1:FormatText(var_234_10.content)

				arg_231_1.text_.text = var_234_11

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_13 = 24 <= 0 and var_234_9 or var_234_9 * (utf8.len(var_234_11) / 24)

				if (24 <= 0 and var_234_9 or var_234_9 * (utf8.len(var_234_11) / 24)) > 0 and var_234_9 < var_234_13 then
					arg_231_1.talkMaxDuration = var_234_13

					if var_234_13 + var_234_8 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_13 + var_234_8
					end
				end

				arg_231_1.text_.text = var_234_11
				arg_231_1.typewritter.percent = 0

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421072", "421072057", "story_v_out_421072.awb") ~= 0 then
					local var_234_14 = manager.audio:GetVoiceLength("story_v_out_421072", "421072057", "story_v_out_421072.awb") / 1000

					if var_234_14 + var_234_8 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_14 + var_234_8
					end

					if var_234_10.prefab_name ~= "" and arg_231_1.actors_[var_234_10.prefab_name] ~= nil then
						local var_234_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_231_1.actors_[var_234_10.prefab_name].transform, "story_v_out_421072", "421072057", "story_v_out_421072.awb")

						arg_231_1:RecordAudio("421072057", var_234_15)
						arg_231_1:RecordAudio("421072057", var_234_15)
					else
						arg_231_1:AudioAction("play", "voice", "story_v_out_421072", "421072057", "story_v_out_421072.awb")
					end

					arg_231_1:RecordHistoryTalkVoice("story_v_out_421072", "421072057", "story_v_out_421072.awb")
				end

				arg_231_1:RecordContent(arg_231_1.text_.text)
			end

			local var_234_16 = math.max(var_234_9, arg_231_1.talkMaxDuration)

			if var_234_8 <= arg_231_1.time_ and arg_231_1.time_ < var_234_8 + var_234_16 then
				arg_231_1.typewritter.percent = (arg_231_1.time_ - var_234_8) / var_234_16

				arg_231_1.typewritter:SetDirty()
			end

			if arg_231_1.time_ >= var_234_8 + var_234_16 and arg_231_1.time_ < var_234_8 + var_234_16 + arg_234_0 then
				arg_231_1.typewritter.percent = 1

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(true)
			end
		end

		arg_231_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1047ui_story",
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
	Play421072058 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 421072058
		arg_235_1.duration_ = 5.63

		local var_235_0 = {
			zh = 3.9,
			ja = 5.633
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
				arg_235_0:Play421072059(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 then
				arg_235_1.var_.moveOldPos1047ui_story = arg_235_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_238_0 = 0.001

			if 0 <= arg_235_1.time_ and arg_235_1.time_ < 0 + var_238_0 then
				arg_235_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_235_1.var_.moveOldPos1047ui_story, Vector3.New(0.74, -1.13, -6.2), (arg_235_1.time_ - 0) / var_238_0)
				arg_235_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_235_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_235_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_235_1.actors_["1047ui_story"].transform.position).z)
				arg_235_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_235_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_235_1.actors_["1047ui_story"].transform.localEulerAngles = arg_235_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_235_1.time_ >= 0 + var_238_0 and arg_235_1.time_ < 0 + var_238_0 + arg_238_0 then
				arg_235_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0.74, -1.13, -6.2)
				arg_235_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_235_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_235_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_235_1.actors_["1047ui_story"].transform.position).z)
				arg_235_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_235_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_235_1.actors_["1047ui_story"].transform.localEulerAngles = arg_235_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_238_1 = arg_235_1.actors_["10102ui_story"].transform

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 then
				arg_235_1.var_.moveOldPos10102ui_story = var_238_1.localPosition
			end

			local var_238_2 = 0.001

			if 0 <= arg_235_1.time_ and arg_235_1.time_ < 0 + var_238_2 then
				var_238_1.localPosition = Vector3.Lerp(arg_235_1.var_.moveOldPos10102ui_story, Vector3.New(0, 100, 0), (arg_235_1.time_ - 0) / var_238_2)
				var_238_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_238_1.position).x, (manager.ui.mainCamera.transform.position - var_238_1.position).y, (manager.ui.mainCamera.transform.position - var_238_1.position).z)
				var_238_1.localEulerAngles.z = 0
				var_238_1.localEulerAngles.x = 0
				var_238_1.localEulerAngles = var_238_1.localEulerAngles
			end

			if arg_235_1.time_ >= 0 + var_238_2 and arg_235_1.time_ < 0 + var_238_2 + arg_238_0 then
				var_238_1.localPosition = Vector3.New(0, 100, 0)
				var_238_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_238_1.position).x, (manager.ui.mainCamera.transform.position - var_238_1.position).y, (manager.ui.mainCamera.transform.position - var_238_1.position).z)
				var_238_1.localEulerAngles.z = 0
				var_238_1.localEulerAngles.x = 0
				var_238_1.localEulerAngles = var_238_1.localEulerAngles
			end

			local var_238_3 = arg_235_1.actors_["1047ui_story"]

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 and not isNil(var_238_3) and arg_235_1.var_.characterEffect1047ui_story == nil then
				arg_235_1.var_.characterEffect1047ui_story = var_238_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_238_4 = 0.200000002980232

			if 0 <= arg_235_1.time_ and arg_235_1.time_ < 0 + var_238_4 and not isNil(var_238_3) then
				if arg_235_1.var_.characterEffect1047ui_story and not isNil(var_238_3) then
					arg_235_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_235_1.time_ >= 0 + var_238_4 and arg_235_1.time_ < 0 + var_238_4 + arg_238_0 and not isNil(var_238_3) and arg_235_1.var_.characterEffect1047ui_story then
				arg_235_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_238_6 = arg_235_1.actors_["10102ui_story"]

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 and not isNil(var_238_6) and arg_235_1.var_.characterEffect10102ui_story == nil then
				arg_235_1.var_.characterEffect10102ui_story = var_238_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_238_7 = 0.200000002980232

			if 0 <= arg_235_1.time_ and arg_235_1.time_ < 0 + var_238_7 and not isNil(var_238_6) then
				if arg_235_1.var_.characterEffect10102ui_story and not isNil(var_238_6) then
					arg_235_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_235_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_235_1.time_ - 0) / var_238_7)
				end
			end

			if arg_235_1.time_ >= 0 + var_238_7 and arg_235_1.time_ < 0 + var_238_7 + arg_238_0 and not isNil(var_238_6) and arg_235_1.var_.characterEffect10102ui_story then
				arg_235_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_235_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 then
				arg_235_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action7_2")
			end

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 then
				arg_235_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_238_8 = 0
			local var_238_9 = 0.45

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= var_238_8 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0
				arg_235_1.dialogCg_.alpha = 1

				arg_235_1.dialog_:SetActive(true)
				SetActive(arg_235_1.leftNameGo_, true)

				arg_235_1.leftNameTxt_.text = arg_235_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_235_1.leftNameTxt_.transform)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1.leftNameTxt_.text)
				SetActive(arg_235_1.iconTrs_.gameObject, false)
				arg_235_1.callingController_:SetSelectedState("normal")

				local var_238_10 = arg_235_1:GetWordFromCfg(421072058)
				local var_238_11 = arg_235_1:FormatText(var_238_10.content)

				arg_235_1.text_.text = var_238_11

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_13 = 18 <= 0 and var_238_9 or var_238_9 * (utf8.len(var_238_11) / 18)

				if (18 <= 0 and var_238_9 or var_238_9 * (utf8.len(var_238_11) / 18)) > 0 and var_238_9 < var_238_13 then
					arg_235_1.talkMaxDuration = var_238_13

					if var_238_13 + var_238_8 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_13 + var_238_8
					end
				end

				arg_235_1.text_.text = var_238_11
				arg_235_1.typewritter.percent = 0

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421072", "421072058", "story_v_out_421072.awb") ~= 0 then
					local var_238_14 = manager.audio:GetVoiceLength("story_v_out_421072", "421072058", "story_v_out_421072.awb") / 1000

					if var_238_14 + var_238_8 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_14 + var_238_8
					end

					if var_238_10.prefab_name ~= "" and arg_235_1.actors_[var_238_10.prefab_name] ~= nil then
						local var_238_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_235_1.actors_[var_238_10.prefab_name].transform, "story_v_out_421072", "421072058", "story_v_out_421072.awb")

						arg_235_1:RecordAudio("421072058", var_238_15)
						arg_235_1:RecordAudio("421072058", var_238_15)
					else
						arg_235_1:AudioAction("play", "voice", "story_v_out_421072", "421072058", "story_v_out_421072.awb")
					end

					arg_235_1:RecordHistoryTalkVoice("story_v_out_421072", "421072058", "story_v_out_421072.awb")
				end

				arg_235_1:RecordContent(arg_235_1.text_.text)
			end

			local var_238_16 = math.max(var_238_9, arg_235_1.talkMaxDuration)

			if var_238_8 <= arg_235_1.time_ and arg_235_1.time_ < var_238_8 + var_238_16 then
				arg_235_1.typewritter.percent = (arg_235_1.time_ - var_238_8) / var_238_16

				arg_235_1.typewritter:SetDirty()
			end

			if arg_235_1.time_ >= var_238_8 + var_238_16 and arg_235_1.time_ < var_238_8 + var_238_16 + arg_238_0 then
				arg_235_1.typewritter.percent = 1

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(true)
			end
		end

		arg_235_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_235_1:InitPlayNodeList()
	end,
	Play421072059 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 421072059
		arg_239_1.duration_ = 3.37

		local var_239_0 = {
			zh = 3.366,
			ja = 2.666
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
				arg_239_0:Play421072060(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 then
				arg_239_1.var_.moveOldPos10143ui_story = arg_239_1.actors_["10143ui_story"].transform.localPosition
			end

			local var_242_0 = 0.001

			if 0 <= arg_239_1.time_ and arg_239_1.time_ < 0 + var_242_0 then
				arg_239_1.actors_["10143ui_story"].transform.localPosition = Vector3.Lerp(arg_239_1.var_.moveOldPos10143ui_story, Vector3.New(-0.72, -1.06, -6), (arg_239_1.time_ - 0) / var_242_0)
				arg_239_1.actors_["10143ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_239_1.actors_["10143ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_239_1.actors_["10143ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_239_1.actors_["10143ui_story"].transform.position).z)
				arg_239_1.actors_["10143ui_story"].transform.localEulerAngles.z = 0
				arg_239_1.actors_["10143ui_story"].transform.localEulerAngles.x = 0
				arg_239_1.actors_["10143ui_story"].transform.localEulerAngles = arg_239_1.actors_["10143ui_story"].transform.localEulerAngles
			end

			if arg_239_1.time_ >= 0 + var_242_0 and arg_239_1.time_ < 0 + var_242_0 + arg_242_0 then
				arg_239_1.actors_["10143ui_story"].transform.localPosition = Vector3.New(-0.72, -1.06, -6)
				arg_239_1.actors_["10143ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_239_1.actors_["10143ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_239_1.actors_["10143ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_239_1.actors_["10143ui_story"].transform.position).z)
				arg_239_1.actors_["10143ui_story"].transform.localEulerAngles.z = 0
				arg_239_1.actors_["10143ui_story"].transform.localEulerAngles.x = 0
				arg_239_1.actors_["10143ui_story"].transform.localEulerAngles = arg_239_1.actors_["10143ui_story"].transform.localEulerAngles
			end

			local var_242_1 = arg_239_1.actors_["10143ui_story"]

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 and not isNil(var_242_1) and arg_239_1.var_.characterEffect10143ui_story == nil then
				arg_239_1.var_.characterEffect10143ui_story = var_242_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_242_2 = 0.200000002980232

			if 0 <= arg_239_1.time_ and arg_239_1.time_ < 0 + var_242_2 and not isNil(var_242_1) then
				if arg_239_1.var_.characterEffect10143ui_story and not isNil(var_242_1) then
					arg_239_1.var_.characterEffect10143ui_story.fillFlat = false
				end
			end

			if arg_239_1.time_ >= 0 + var_242_2 and arg_239_1.time_ < 0 + var_242_2 + arg_242_0 and not isNil(var_242_1) and arg_239_1.var_.characterEffect10143ui_story then
				arg_239_1.var_.characterEffect10143ui_story.fillFlat = false
			end

			local var_242_4 = arg_239_1.actors_["1047ui_story"]

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 and not isNil(var_242_4) and arg_239_1.var_.characterEffect1047ui_story == nil then
				arg_239_1.var_.characterEffect1047ui_story = var_242_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_242_5 = 0.200000002980232

			if 0 <= arg_239_1.time_ and arg_239_1.time_ < 0 + var_242_5 and not isNil(var_242_4) then
				if arg_239_1.var_.characterEffect1047ui_story and not isNil(var_242_4) then
					arg_239_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_239_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_239_1.time_ - 0) / var_242_5)
				end
			end

			if arg_239_1.time_ >= 0 + var_242_5 and arg_239_1.time_ < 0 + var_242_5 + arg_242_0 and not isNil(var_242_4) and arg_239_1.var_.characterEffect1047ui_story then
				arg_239_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_239_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 then
				arg_239_1:PlayTimeline("10143ui_story", "StoryTimeline/CharAction/story10143/story10143action/10143action7_2")
			end

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 then
				arg_239_1:PlayTimeline("10143ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_242_6 = 0
			local var_242_7 = 0.375

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= var_242_6 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0
				arg_239_1.dialogCg_.alpha = 1

				arg_239_1.dialog_:SetActive(true)
				SetActive(arg_239_1.leftNameGo_, true)

				arg_239_1.leftNameTxt_.text = arg_239_1:FormatText(StoryNameCfg[1307].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_239_1.leftNameTxt_.transform)

				arg_239_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_239_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_239_1:RecordName(arg_239_1.leftNameTxt_.text)
				SetActive(arg_239_1.iconTrs_.gameObject, false)
				arg_239_1.callingController_:SetSelectedState("normal")

				local var_242_8 = arg_239_1:GetWordFromCfg(421072059)
				local var_242_9 = arg_239_1:FormatText(var_242_8.content)

				arg_239_1.text_.text = var_242_9

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_11 = 15 <= 0 and var_242_7 or var_242_7 * (utf8.len(var_242_9) / 15)

				if (15 <= 0 and var_242_7 or var_242_7 * (utf8.len(var_242_9) / 15)) > 0 and var_242_7 < var_242_11 then
					arg_239_1.talkMaxDuration = var_242_11

					if var_242_11 + var_242_6 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_11 + var_242_6
					end
				end

				arg_239_1.text_.text = var_242_9
				arg_239_1.typewritter.percent = 0

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421072", "421072059", "story_v_out_421072.awb") ~= 0 then
					local var_242_12 = manager.audio:GetVoiceLength("story_v_out_421072", "421072059", "story_v_out_421072.awb") / 1000

					if var_242_12 + var_242_6 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_12 + var_242_6
					end

					if var_242_8.prefab_name ~= "" and arg_239_1.actors_[var_242_8.prefab_name] ~= nil then
						local var_242_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_239_1.actors_[var_242_8.prefab_name].transform, "story_v_out_421072", "421072059", "story_v_out_421072.awb")

						arg_239_1:RecordAudio("421072059", var_242_13)
						arg_239_1:RecordAudio("421072059", var_242_13)
					else
						arg_239_1:AudioAction("play", "voice", "story_v_out_421072", "421072059", "story_v_out_421072.awb")
					end

					arg_239_1:RecordHistoryTalkVoice("story_v_out_421072", "421072059", "story_v_out_421072.awb")
				end

				arg_239_1:RecordContent(arg_239_1.text_.text)
			end

			local var_242_14 = math.max(var_242_7, arg_239_1.talkMaxDuration)

			if var_242_6 <= arg_239_1.time_ and arg_239_1.time_ < var_242_6 + var_242_14 then
				arg_239_1.typewritter.percent = (arg_239_1.time_ - var_242_6) / var_242_14

				arg_239_1.typewritter:SetDirty()
			end

			if arg_239_1.time_ >= var_242_6 + var_242_14 and arg_239_1.time_ < var_242_6 + var_242_14 + arg_242_0 then
				arg_239_1.typewritter.percent = 1

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(true)
			end
		end

		arg_239_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10143ui_story",
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
	Play421072060 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 421072060
		arg_243_1.duration_ = 5

		SetActive(arg_243_1.tipsGo_, false)

		function arg_243_1.onSingleLineFinish_()
			arg_243_1.onSingleLineUpdate_ = nil
			arg_243_1.onSingleLineFinish_ = nil
			arg_243_1.state_ = "waiting"
		end

		function arg_243_1.playNext_(arg_245_0)
			if arg_245_0 == 1 then
				arg_243_0:Play421072061(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 and not isNil(arg_243_1.actors_["10143ui_story"]) and arg_243_1.var_.characterEffect10143ui_story == nil then
				arg_243_1.var_.characterEffect10143ui_story = arg_243_1.actors_["10143ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_246_0 = 0.200000002980232

			if 0 <= arg_243_1.time_ and arg_243_1.time_ < 0 + var_246_0 and not isNil(arg_243_1.actors_["10143ui_story"]) then
				if arg_243_1.var_.characterEffect10143ui_story and not isNil(arg_243_1.actors_["10143ui_story"]) then
					arg_243_1.var_.characterEffect10143ui_story.fillFlat = true
					arg_243_1.var_.characterEffect10143ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_243_1.time_ - 0) / var_246_0)
				end
			end

			if arg_243_1.time_ >= 0 + var_246_0 and arg_243_1.time_ < 0 + var_246_0 + arg_246_0 and not isNil(arg_243_1.actors_["10143ui_story"]) and arg_243_1.var_.characterEffect10143ui_story then
				arg_243_1.var_.characterEffect10143ui_story.fillFlat = true
				arg_243_1.var_.characterEffect10143ui_story.fillRatio = 0.5
			end

			local var_246_1 = 0
			local var_246_2 = 0.325

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= var_246_1 + arg_246_0 then
				arg_243_1.talkMaxDuration = 0
				arg_243_1.dialogCg_.alpha = 1

				arg_243_1.dialog_:SetActive(true)
				SetActive(arg_243_1.leftNameGo_, true)

				arg_243_1.leftNameTxt_.text = arg_243_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_243_1.leftNameTxt_.transform)

				arg_243_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_243_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_243_1:RecordName(arg_243_1.leftNameTxt_.text)
				SetActive(arg_243_1.iconTrs_.gameObject, true)
				arg_243_1.iconController_:SetSelectedState("hero")

				arg_243_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_243_1.callingController_:SetSelectedState("normal")

				arg_243_1.keyicon_.color = Color.New(1, 1, 1)
				arg_243_1.icon_.color = Color.New(1, 1, 1)

				local var_246_3 = arg_243_1:FormatText(arg_243_1:GetWordFromCfg(421072060).content)

				arg_243_1.text_.text = var_246_3

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_5 = 13 <= 0 and var_246_2 or var_246_2 * (utf8.len(var_246_3) / 13)

				if (13 <= 0 and var_246_2 or var_246_2 * (utf8.len(var_246_3) / 13)) > 0 and var_246_2 < var_246_5 then
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

		arg_243_1.nodeConfigList_ = {}

		arg_243_1:InitPlayNodeList()
	end,
	Play421072061 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 421072061
		arg_247_1.duration_ = 5

		SetActive(arg_247_1.tipsGo_, false)

		function arg_247_1.onSingleLineFinish_()
			arg_247_1.onSingleLineUpdate_ = nil
			arg_247_1.onSingleLineFinish_ = nil
			arg_247_1.state_ = "waiting"
		end

		function arg_247_1.playNext_(arg_249_0)
			if arg_249_0 == 1 then
				arg_247_0:Play421072062(arg_247_1)
			end
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 then
				arg_247_1.var_.moveOldPos10143ui_story = arg_247_1.actors_["10143ui_story"].transform.localPosition
			end

			local var_250_0 = 0.001

			if 0 <= arg_247_1.time_ and arg_247_1.time_ < 0 + var_250_0 then
				arg_247_1.actors_["10143ui_story"].transform.localPosition = Vector3.Lerp(arg_247_1.var_.moveOldPos10143ui_story, Vector3.New(0, 100, 0), (arg_247_1.time_ - 0) / var_250_0)
				arg_247_1.actors_["10143ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_247_1.actors_["10143ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_247_1.actors_["10143ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_247_1.actors_["10143ui_story"].transform.position).z)
				arg_247_1.actors_["10143ui_story"].transform.localEulerAngles.z = 0
				arg_247_1.actors_["10143ui_story"].transform.localEulerAngles.x = 0
				arg_247_1.actors_["10143ui_story"].transform.localEulerAngles = arg_247_1.actors_["10143ui_story"].transform.localEulerAngles
			end

			if arg_247_1.time_ >= 0 + var_250_0 and arg_247_1.time_ < 0 + var_250_0 + arg_250_0 then
				arg_247_1.actors_["10143ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_247_1.actors_["10143ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_247_1.actors_["10143ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_247_1.actors_["10143ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_247_1.actors_["10143ui_story"].transform.position).z)
				arg_247_1.actors_["10143ui_story"].transform.localEulerAngles.z = 0
				arg_247_1.actors_["10143ui_story"].transform.localEulerAngles.x = 0
				arg_247_1.actors_["10143ui_story"].transform.localEulerAngles = arg_247_1.actors_["10143ui_story"].transform.localEulerAngles
			end

			local var_250_1 = arg_247_1.actors_["1047ui_story"].transform

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 then
				arg_247_1.var_.moveOldPos1047ui_story = var_250_1.localPosition
			end

			local var_250_2 = 0.001

			if 0 <= arg_247_1.time_ and arg_247_1.time_ < 0 + var_250_2 then
				var_250_1.localPosition = Vector3.Lerp(arg_247_1.var_.moveOldPos1047ui_story, Vector3.New(0, 100, 0), (arg_247_1.time_ - 0) / var_250_2)
				var_250_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_250_1.position).x, (manager.ui.mainCamera.transform.position - var_250_1.position).y, (manager.ui.mainCamera.transform.position - var_250_1.position).z)
				var_250_1.localEulerAngles.z = 0
				var_250_1.localEulerAngles.x = 0
				var_250_1.localEulerAngles = var_250_1.localEulerAngles
			end

			if arg_247_1.time_ >= 0 + var_250_2 and arg_247_1.time_ < 0 + var_250_2 + arg_250_0 then
				var_250_1.localPosition = Vector3.New(0, 100, 0)
				var_250_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_250_1.position).x, (manager.ui.mainCamera.transform.position - var_250_1.position).y, (manager.ui.mainCamera.transform.position - var_250_1.position).z)
				var_250_1.localEulerAngles.z = 0
				var_250_1.localEulerAngles.x = 0
				var_250_1.localEulerAngles = var_250_1.localEulerAngles
			end

			if 0.633333333333333 < arg_247_1.time_ and arg_247_1.time_ <= 0.633333333333333 + arg_250_0 then
				arg_247_1:AudioAction("play", "effect", "se_story_143", "se_story_143_footstep08", "")
			end

			local var_250_4 = 0
			local var_250_5 = 1.075

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= var_250_4 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0
				arg_247_1.dialogCg_.alpha = 1

				arg_247_1.dialog_:SetActive(true)
				SetActive(arg_247_1.leftNameGo_, false)

				arg_247_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_247_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_247_1:RecordName(arg_247_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_247_1.iconTrs_.gameObject, false)
				arg_247_1.callingController_:SetSelectedState("normal")

				local var_250_6 = arg_247_1:FormatText(arg_247_1:GetWordFromCfg(421072061).content)

				arg_247_1.text_.text = var_250_6

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_8 = 43 <= 0 and var_250_5 or var_250_5 * (utf8.len(var_250_6) / 43)

				if (43 <= 0 and var_250_5 or var_250_5 * (utf8.len(var_250_6) / 43)) > 0 and var_250_5 < var_250_8 then
					arg_247_1.talkMaxDuration = var_250_8

					if var_250_8 + var_250_4 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_8 + var_250_4
					end
				end

				arg_247_1.text_.text = var_250_6
				arg_247_1.typewritter.percent = 0

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(false)
				arg_247_1:RecordContent(arg_247_1.text_.text)
			end

			local var_250_9 = math.max(var_250_5, arg_247_1.talkMaxDuration)

			if var_250_4 <= arg_247_1.time_ and arg_247_1.time_ < var_250_4 + var_250_9 then
				arg_247_1.typewritter.percent = (arg_247_1.time_ - var_250_4) / var_250_9

				arg_247_1.typewritter:SetDirty()
			end

			if arg_247_1.time_ >= var_250_4 + var_250_9 and arg_247_1.time_ < var_250_4 + var_250_9 + arg_250_0 then
				arg_247_1.typewritter.percent = 1

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(true)
			end
		end

		arg_247_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10143ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_247_1:InitPlayNodeList()
	end,
	Play421072062 = function(arg_251_0, arg_251_1)
		arg_251_1.time_ = 0
		arg_251_1.frameCnt_ = 0
		arg_251_1.state_ = "playing"
		arg_251_1.curTalkId_ = 421072062
		arg_251_1.duration_ = 2.73

		local var_251_0 = {
			zh = 1.566,
			ja = 2.733
		}
		local var_251_1 = manager.audio:GetLocalizationFlag()

		if var_251_0[var_251_1] ~= nil then
			arg_251_1.duration_ = var_251_0[var_251_1]
		end

		SetActive(arg_251_1.tipsGo_, false)

		function arg_251_1.onSingleLineFinish_()
			arg_251_1.onSingleLineUpdate_ = nil
			arg_251_1.onSingleLineFinish_ = nil
			arg_251_1.state_ = "waiting"
		end

		function arg_251_1.playNext_(arg_253_0)
			if arg_253_0 == 1 then
				arg_251_0:Play421072063(arg_251_1)
			end
		end

		function arg_251_1.onSingleLineUpdate_(arg_254_0)
			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 then
				arg_251_1.var_.moveOldPos1047ui_story = arg_251_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_254_0 = 0.001

			if 0 <= arg_251_1.time_ and arg_251_1.time_ < 0 + var_254_0 then
				arg_251_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_251_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_251_1.time_ - 0) / var_254_0)
				arg_251_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_251_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_251_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_251_1.actors_["1047ui_story"].transform.position).z)
				arg_251_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_251_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_251_1.actors_["1047ui_story"].transform.localEulerAngles = arg_251_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_251_1.time_ >= 0 + var_254_0 and arg_251_1.time_ < 0 + var_254_0 + arg_254_0 then
				arg_251_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_251_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_251_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_251_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_251_1.actors_["1047ui_story"].transform.position).z)
				arg_251_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_251_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_251_1.actors_["1047ui_story"].transform.localEulerAngles = arg_251_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_254_1 = arg_251_1.actors_["1047ui_story"]

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 and not isNil(var_254_1) and arg_251_1.var_.characterEffect1047ui_story == nil then
				arg_251_1.var_.characterEffect1047ui_story = var_254_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_254_2 = 0.200000002980232

			if 0 <= arg_251_1.time_ and arg_251_1.time_ < 0 + var_254_2 and not isNil(var_254_1) then
				if arg_251_1.var_.characterEffect1047ui_story and not isNil(var_254_1) then
					arg_251_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_251_1.time_ >= 0 + var_254_2 and arg_251_1.time_ < 0 + var_254_2 + arg_254_0 and not isNil(var_254_1) and arg_251_1.var_.characterEffect1047ui_story then
				arg_251_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 then
				arg_251_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 then
				arg_251_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_254_4 = 0
			local var_254_5 = 0.175

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= var_254_4 + arg_254_0 then
				arg_251_1.talkMaxDuration = 0
				arg_251_1.dialogCg_.alpha = 1

				arg_251_1.dialog_:SetActive(true)
				SetActive(arg_251_1.leftNameGo_, true)

				arg_251_1.leftNameTxt_.text = arg_251_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_251_1.leftNameTxt_.transform)

				arg_251_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_251_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_251_1:RecordName(arg_251_1.leftNameTxt_.text)
				SetActive(arg_251_1.iconTrs_.gameObject, false)
				arg_251_1.callingController_:SetSelectedState("normal")

				local var_254_6 = arg_251_1:GetWordFromCfg(421072062)
				local var_254_7 = arg_251_1:FormatText(var_254_6.content)

				arg_251_1.text_.text = var_254_7

				LuaForUtil.ClearLinePrefixSymbol(arg_251_1.text_)

				local var_254_9 = 7 <= 0 and var_254_5 or var_254_5 * (utf8.len(var_254_7) / 7)

				if (7 <= 0 and var_254_5 or var_254_5 * (utf8.len(var_254_7) / 7)) > 0 and var_254_5 < var_254_9 then
					arg_251_1.talkMaxDuration = var_254_9

					if var_254_9 + var_254_4 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_9 + var_254_4
					end
				end

				arg_251_1.text_.text = var_254_7
				arg_251_1.typewritter.percent = 0

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421072", "421072062", "story_v_out_421072.awb") ~= 0 then
					local var_254_10 = manager.audio:GetVoiceLength("story_v_out_421072", "421072062", "story_v_out_421072.awb") / 1000

					if var_254_10 + var_254_4 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_10 + var_254_4
					end

					if var_254_6.prefab_name ~= "" and arg_251_1.actors_[var_254_6.prefab_name] ~= nil then
						local var_254_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_251_1.actors_[var_254_6.prefab_name].transform, "story_v_out_421072", "421072062", "story_v_out_421072.awb")

						arg_251_1:RecordAudio("421072062", var_254_11)
						arg_251_1:RecordAudio("421072062", var_254_11)
					else
						arg_251_1:AudioAction("play", "voice", "story_v_out_421072", "421072062", "story_v_out_421072.awb")
					end

					arg_251_1:RecordHistoryTalkVoice("story_v_out_421072", "421072062", "story_v_out_421072.awb")
				end

				arg_251_1:RecordContent(arg_251_1.text_.text)
			end

			local var_254_12 = math.max(var_254_5, arg_251_1.talkMaxDuration)

			if var_254_4 <= arg_251_1.time_ and arg_251_1.time_ < var_254_4 + var_254_12 then
				arg_251_1.typewritter.percent = (arg_251_1.time_ - var_254_4) / var_254_12

				arg_251_1.typewritter:SetDirty()
			end

			if arg_251_1.time_ >= var_254_4 + var_254_12 and arg_251_1.time_ < var_254_4 + var_254_12 + arg_254_0 then
				arg_251_1.typewritter.percent = 1

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(true)
			end
		end

		arg_251_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_251_1:InitPlayNodeList()
	end,
	Play421072063 = function(arg_255_0, arg_255_1)
		arg_255_1.time_ = 0
		arg_255_1.frameCnt_ = 0
		arg_255_1.state_ = "playing"
		arg_255_1.curTalkId_ = 421072063
		arg_255_1.duration_ = 3.73

		local var_255_0 = {
			zh = 1.999999999999,
			ja = 3.733
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
				arg_255_0:Play421072064(arg_255_1)
			end
		end

		function arg_255_1.onSingleLineUpdate_(arg_258_0)
			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 then
				arg_255_1.var_.moveOldPos10145ui_story = arg_255_1.actors_["10145ui_story"].transform.localPosition
			end

			local var_258_0 = 0.001

			if 0 <= arg_255_1.time_ and arg_255_1.time_ < 0 + var_258_0 then
				arg_255_1.actors_["10145ui_story"].transform.localPosition = Vector3.Lerp(arg_255_1.var_.moveOldPos10145ui_story, Vector3.New(0.78, -1, -6.2), (arg_255_1.time_ - 0) / var_258_0)
				arg_255_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_255_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_255_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_255_1.actors_["10145ui_story"].transform.position).z)
				arg_255_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_255_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_255_1.actors_["10145ui_story"].transform.localEulerAngles = arg_255_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			if arg_255_1.time_ >= 0 + var_258_0 and arg_255_1.time_ < 0 + var_258_0 + arg_258_0 then
				arg_255_1.actors_["10145ui_story"].transform.localPosition = Vector3.New(0.78, -1, -6.2)
				arg_255_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_255_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_255_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_255_1.actors_["10145ui_story"].transform.position).z)
				arg_255_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_255_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_255_1.actors_["10145ui_story"].transform.localEulerAngles = arg_255_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			local var_258_1 = arg_255_1.actors_["1047ui_story"].transform

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 then
				arg_255_1.var_.moveOldPos1047ui_story = var_258_1.localPosition
			end

			local var_258_2 = 0.001

			if 0 <= arg_255_1.time_ and arg_255_1.time_ < 0 + var_258_2 then
				var_258_1.localPosition = Vector3.Lerp(arg_255_1.var_.moveOldPos1047ui_story, Vector3.New(-0.6, -1.13, -6.2), (arg_255_1.time_ - 0) / var_258_2)
				var_258_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_258_1.position).x, (manager.ui.mainCamera.transform.position - var_258_1.position).y, (manager.ui.mainCamera.transform.position - var_258_1.position).z)
				var_258_1.localEulerAngles.z = 0
				var_258_1.localEulerAngles.x = 0
				var_258_1.localEulerAngles = var_258_1.localEulerAngles
			end

			if arg_255_1.time_ >= 0 + var_258_2 and arg_255_1.time_ < 0 + var_258_2 + arg_258_0 then
				var_258_1.localPosition = Vector3.New(-0.6, -1.13, -6.2)
				var_258_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_258_1.position).x, (manager.ui.mainCamera.transform.position - var_258_1.position).y, (manager.ui.mainCamera.transform.position - var_258_1.position).z)
				var_258_1.localEulerAngles.z = 0
				var_258_1.localEulerAngles.x = 0
				var_258_1.localEulerAngles = var_258_1.localEulerAngles
			end

			local var_258_3 = arg_255_1.actors_["10145ui_story"]

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 and not isNil(var_258_3) and arg_255_1.var_.characterEffect10145ui_story == nil then
				arg_255_1.var_.characterEffect10145ui_story = var_258_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_258_4 = 0.200000002980232

			if 0 <= arg_255_1.time_ and arg_255_1.time_ < 0 + var_258_4 and not isNil(var_258_3) then
				if arg_255_1.var_.characterEffect10145ui_story and not isNil(var_258_3) then
					arg_255_1.var_.characterEffect10145ui_story.fillFlat = false
				end
			end

			if arg_255_1.time_ >= 0 + var_258_4 and arg_255_1.time_ < 0 + var_258_4 + arg_258_0 and not isNil(var_258_3) and arg_255_1.var_.characterEffect10145ui_story then
				arg_255_1.var_.characterEffect10145ui_story.fillFlat = false
			end

			local var_258_6 = arg_255_1.actors_["1047ui_story"]

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 and not isNil(var_258_6) and arg_255_1.var_.characterEffect1047ui_story == nil then
				arg_255_1.var_.characterEffect1047ui_story = var_258_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_258_7 = 0.200000002980232

			if 0 <= arg_255_1.time_ and arg_255_1.time_ < 0 + var_258_7 and not isNil(var_258_6) then
				if arg_255_1.var_.characterEffect1047ui_story and not isNil(var_258_6) then
					arg_255_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_255_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_255_1.time_ - 0) / var_258_7)
				end
			end

			if arg_255_1.time_ >= 0 + var_258_7 and arg_255_1.time_ < 0 + var_258_7 + arg_258_0 and not isNil(var_258_6) and arg_255_1.var_.characterEffect1047ui_story then
				arg_255_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_255_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 then
				arg_255_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/story10145/story10145action/10145action3_1")
			end

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 then
				arg_255_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_258_8 = 0
			local var_258_9 = 0.125

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= var_258_8 + arg_258_0 then
				arg_255_1.talkMaxDuration = 0
				arg_255_1.dialogCg_.alpha = 1

				arg_255_1.dialog_:SetActive(true)
				SetActive(arg_255_1.leftNameGo_, true)

				arg_255_1.leftNameTxt_.text = arg_255_1:FormatText(StoryNameCfg[1308].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_255_1.leftNameTxt_.transform)

				arg_255_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_255_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_255_1:RecordName(arg_255_1.leftNameTxt_.text)
				SetActive(arg_255_1.iconTrs_.gameObject, false)
				arg_255_1.callingController_:SetSelectedState("normal")

				local var_258_10 = arg_255_1:GetWordFromCfg(421072063)
				local var_258_11 = arg_255_1:FormatText(var_258_10.content)

				arg_255_1.text_.text = var_258_11

				LuaForUtil.ClearLinePrefixSymbol(arg_255_1.text_)

				local var_258_13 = 5 <= 0 and var_258_9 or var_258_9 * (utf8.len(var_258_11) / 5)

				if (5 <= 0 and var_258_9 or var_258_9 * (utf8.len(var_258_11) / 5)) > 0 and var_258_9 < var_258_13 then
					arg_255_1.talkMaxDuration = var_258_13

					if var_258_13 + var_258_8 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_13 + var_258_8
					end
				end

				arg_255_1.text_.text = var_258_11
				arg_255_1.typewritter.percent = 0

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421072", "421072063", "story_v_out_421072.awb") ~= 0 then
					local var_258_14 = manager.audio:GetVoiceLength("story_v_out_421072", "421072063", "story_v_out_421072.awb") / 1000

					if var_258_14 + var_258_8 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_14 + var_258_8
					end

					if var_258_10.prefab_name ~= "" and arg_255_1.actors_[var_258_10.prefab_name] ~= nil then
						local var_258_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_255_1.actors_[var_258_10.prefab_name].transform, "story_v_out_421072", "421072063", "story_v_out_421072.awb")

						arg_255_1:RecordAudio("421072063", var_258_15)
						arg_255_1:RecordAudio("421072063", var_258_15)
					else
						arg_255_1:AudioAction("play", "voice", "story_v_out_421072", "421072063", "story_v_out_421072.awb")
					end

					arg_255_1:RecordHistoryTalkVoice("story_v_out_421072", "421072063", "story_v_out_421072.awb")
				end

				arg_255_1:RecordContent(arg_255_1.text_.text)
			end

			local var_258_16 = math.max(var_258_9, arg_255_1.talkMaxDuration)

			if var_258_8 <= arg_255_1.time_ and arg_255_1.time_ < var_258_8 + var_258_16 then
				arg_255_1.typewritter.percent = (arg_255_1.time_ - var_258_8) / var_258_16

				arg_255_1.typewritter:SetDirty()
			end

			if arg_255_1.time_ >= var_258_8 + var_258_16 and arg_255_1.time_ < var_258_8 + var_258_16 + arg_258_0 then
				arg_255_1.typewritter.percent = 1

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(true)
			end
		end

		arg_255_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10145ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_255_1:InitPlayNodeList()
	end,
	Play421072064 = function(arg_259_0, arg_259_1)
		arg_259_1.time_ = 0
		arg_259_1.frameCnt_ = 0
		arg_259_1.state_ = "playing"
		arg_259_1.curTalkId_ = 421072064
		arg_259_1.duration_ = 8.53

		local var_259_0 = {
			zh = 5.533,
			ja = 8.533
		}
		local var_259_1 = manager.audio:GetLocalizationFlag()

		if var_259_0[var_259_1] ~= nil then
			arg_259_1.duration_ = var_259_0[var_259_1]
		end

		SetActive(arg_259_1.tipsGo_, false)

		function arg_259_1.onSingleLineFinish_()
			arg_259_1.onSingleLineUpdate_ = nil
			arg_259_1.onSingleLineFinish_ = nil
			arg_259_1.state_ = "waiting"
		end

		function arg_259_1.playNext_(arg_261_0)
			if arg_261_0 == 1 then
				arg_259_0:Play421072065(arg_259_1)
			end
		end

		function arg_259_1.onSingleLineUpdate_(arg_262_0)
			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 then
				arg_259_1.var_.moveOldPos1047ui_story = arg_259_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_262_0 = 0.001

			if 0 <= arg_259_1.time_ and arg_259_1.time_ < 0 + var_262_0 then
				arg_259_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_259_1.var_.moveOldPos1047ui_story, Vector3.New(-0.6, -1.13, -6.2), (arg_259_1.time_ - 0) / var_262_0)
				arg_259_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_259_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_259_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_259_1.actors_["1047ui_story"].transform.position).z)
				arg_259_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_259_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_259_1.actors_["1047ui_story"].transform.localEulerAngles = arg_259_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_259_1.time_ >= 0 + var_262_0 and arg_259_1.time_ < 0 + var_262_0 + arg_262_0 then
				arg_259_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(-0.6, -1.13, -6.2)
				arg_259_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_259_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_259_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_259_1.actors_["1047ui_story"].transform.position).z)
				arg_259_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_259_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_259_1.actors_["1047ui_story"].transform.localEulerAngles = arg_259_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_262_1 = arg_259_1.actors_["1047ui_story"]

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 and not isNil(var_262_1) and arg_259_1.var_.characterEffect1047ui_story == nil then
				arg_259_1.var_.characterEffect1047ui_story = var_262_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_262_2 = 0.200000002980232

			if 0 <= arg_259_1.time_ and arg_259_1.time_ < 0 + var_262_2 and not isNil(var_262_1) then
				if arg_259_1.var_.characterEffect1047ui_story and not isNil(var_262_1) then
					arg_259_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_259_1.time_ >= 0 + var_262_2 and arg_259_1.time_ < 0 + var_262_2 + arg_262_0 and not isNil(var_262_1) and arg_259_1.var_.characterEffect1047ui_story then
				arg_259_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_262_4 = arg_259_1.actors_["10145ui_story"]

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 and not isNil(var_262_4) and arg_259_1.var_.characterEffect10145ui_story == nil then
				arg_259_1.var_.characterEffect10145ui_story = var_262_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_262_5 = 0.200000002980232

			if 0 <= arg_259_1.time_ and arg_259_1.time_ < 0 + var_262_5 and not isNil(var_262_4) then
				if arg_259_1.var_.characterEffect10145ui_story and not isNil(var_262_4) then
					arg_259_1.var_.characterEffect10145ui_story.fillFlat = true
					arg_259_1.var_.characterEffect10145ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_259_1.time_ - 0) / var_262_5)
				end
			end

			if arg_259_1.time_ >= 0 + var_262_5 and arg_259_1.time_ < 0 + var_262_5 + arg_262_0 and not isNil(var_262_4) and arg_259_1.var_.characterEffect10145ui_story then
				arg_259_1.var_.characterEffect10145ui_story.fillFlat = true
				arg_259_1.var_.characterEffect10145ui_story.fillRatio = 0.5
			end

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 then
				arg_259_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action7_1")
			end

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 then
				arg_259_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_262_6 = 0
			local var_262_7 = 0.625

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= var_262_6 + arg_262_0 then
				arg_259_1.talkMaxDuration = 0
				arg_259_1.dialogCg_.alpha = 1

				arg_259_1.dialog_:SetActive(true)
				SetActive(arg_259_1.leftNameGo_, true)

				arg_259_1.leftNameTxt_.text = arg_259_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_259_1.leftNameTxt_.transform)

				arg_259_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_259_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_259_1:RecordName(arg_259_1.leftNameTxt_.text)
				SetActive(arg_259_1.iconTrs_.gameObject, false)
				arg_259_1.callingController_:SetSelectedState("normal")

				local var_262_8 = arg_259_1:GetWordFromCfg(421072064)
				local var_262_9 = arg_259_1:FormatText(var_262_8.content)

				arg_259_1.text_.text = var_262_9

				LuaForUtil.ClearLinePrefixSymbol(arg_259_1.text_)

				local var_262_11 = 25 <= 0 and var_262_7 or var_262_7 * (utf8.len(var_262_9) / 25)

				if (25 <= 0 and var_262_7 or var_262_7 * (utf8.len(var_262_9) / 25)) > 0 and var_262_7 < var_262_11 then
					arg_259_1.talkMaxDuration = var_262_11

					if var_262_11 + var_262_6 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_11 + var_262_6
					end
				end

				arg_259_1.text_.text = var_262_9
				arg_259_1.typewritter.percent = 0

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421072", "421072064", "story_v_out_421072.awb") ~= 0 then
					local var_262_12 = manager.audio:GetVoiceLength("story_v_out_421072", "421072064", "story_v_out_421072.awb") / 1000

					if var_262_12 + var_262_6 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_12 + var_262_6
					end

					if var_262_8.prefab_name ~= "" and arg_259_1.actors_[var_262_8.prefab_name] ~= nil then
						local var_262_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_259_1.actors_[var_262_8.prefab_name].transform, "story_v_out_421072", "421072064", "story_v_out_421072.awb")

						arg_259_1:RecordAudio("421072064", var_262_13)
						arg_259_1:RecordAudio("421072064", var_262_13)
					else
						arg_259_1:AudioAction("play", "voice", "story_v_out_421072", "421072064", "story_v_out_421072.awb")
					end

					arg_259_1:RecordHistoryTalkVoice("story_v_out_421072", "421072064", "story_v_out_421072.awb")
				end

				arg_259_1:RecordContent(arg_259_1.text_.text)
			end

			local var_262_14 = math.max(var_262_7, arg_259_1.talkMaxDuration)

			if var_262_6 <= arg_259_1.time_ and arg_259_1.time_ < var_262_6 + var_262_14 then
				arg_259_1.typewritter.percent = (arg_259_1.time_ - var_262_6) / var_262_14

				arg_259_1.typewritter:SetDirty()
			end

			if arg_259_1.time_ >= var_262_6 + var_262_14 and arg_259_1.time_ < var_262_6 + var_262_14 + arg_262_0 then
				arg_259_1.typewritter.percent = 1

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(true)
			end
		end

		arg_259_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_259_1:InitPlayNodeList()
	end,
	Play421072065 = function(arg_263_0, arg_263_1)
		arg_263_1.time_ = 0
		arg_263_1.frameCnt_ = 0
		arg_263_1.state_ = "playing"
		arg_263_1.curTalkId_ = 421072065
		arg_263_1.duration_ = 3.53

		local var_263_0 = {
			zh = 3.366,
			ja = 3.533
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
				arg_263_0:Play421072066(arg_263_1)
			end
		end

		function arg_263_1.onSingleLineUpdate_(arg_266_0)
			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 then
				arg_263_1.var_.moveOldPos10145ui_story = arg_263_1.actors_["10145ui_story"].transform.localPosition
			end

			local var_266_0 = 0.001

			if 0 <= arg_263_1.time_ and arg_263_1.time_ < 0 + var_266_0 then
				arg_263_1.actors_["10145ui_story"].transform.localPosition = Vector3.Lerp(arg_263_1.var_.moveOldPos10145ui_story, Vector3.New(0.78, -1, -6.2), (arg_263_1.time_ - 0) / var_266_0)
				arg_263_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_263_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_263_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_263_1.actors_["10145ui_story"].transform.position).z)
				arg_263_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_263_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_263_1.actors_["10145ui_story"].transform.localEulerAngles = arg_263_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			if arg_263_1.time_ >= 0 + var_266_0 and arg_263_1.time_ < 0 + var_266_0 + arg_266_0 then
				arg_263_1.actors_["10145ui_story"].transform.localPosition = Vector3.New(0.78, -1, -6.2)
				arg_263_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_263_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_263_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_263_1.actors_["10145ui_story"].transform.position).z)
				arg_263_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_263_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_263_1.actors_["10145ui_story"].transform.localEulerAngles = arg_263_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			local var_266_1 = arg_263_1.actors_["10145ui_story"]

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 and not isNil(var_266_1) and arg_263_1.var_.characterEffect10145ui_story == nil then
				arg_263_1.var_.characterEffect10145ui_story = var_266_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_266_2 = 0.200000002980232

			if 0 <= arg_263_1.time_ and arg_263_1.time_ < 0 + var_266_2 and not isNil(var_266_1) then
				if arg_263_1.var_.characterEffect10145ui_story and not isNil(var_266_1) then
					arg_263_1.var_.characterEffect10145ui_story.fillFlat = false
				end
			end

			if arg_263_1.time_ >= 0 + var_266_2 and arg_263_1.time_ < 0 + var_266_2 + arg_266_0 and not isNil(var_266_1) and arg_263_1.var_.characterEffect10145ui_story then
				arg_263_1.var_.characterEffect10145ui_story.fillFlat = false
			end

			local var_266_4 = arg_263_1.actors_["1047ui_story"]

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 and not isNil(var_266_4) and arg_263_1.var_.characterEffect1047ui_story == nil then
				arg_263_1.var_.characterEffect1047ui_story = var_266_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_266_5 = 0.200000002980232

			if 0 <= arg_263_1.time_ and arg_263_1.time_ < 0 + var_266_5 and not isNil(var_266_4) then
				if arg_263_1.var_.characterEffect1047ui_story and not isNil(var_266_4) then
					arg_263_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_263_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_263_1.time_ - 0) / var_266_5)
				end
			end

			if arg_263_1.time_ >= 0 + var_266_5 and arg_263_1.time_ < 0 + var_266_5 + arg_266_0 and not isNil(var_266_4) and arg_263_1.var_.characterEffect1047ui_story then
				arg_263_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_263_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 then
				arg_263_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/story10145/story10145action/10145action3_2")
			end

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 then
				arg_263_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/public_expression/expr_renzhen", "EmotionTimelineAnimator")
			end

			local var_266_6 = 0
			local var_266_7 = 0.4

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= var_266_6 + arg_266_0 then
				arg_263_1.talkMaxDuration = 0
				arg_263_1.dialogCg_.alpha = 1

				arg_263_1.dialog_:SetActive(true)
				SetActive(arg_263_1.leftNameGo_, true)

				arg_263_1.leftNameTxt_.text = arg_263_1:FormatText(StoryNameCfg[1308].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_263_1.leftNameTxt_.transform)

				arg_263_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_263_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_263_1:RecordName(arg_263_1.leftNameTxt_.text)
				SetActive(arg_263_1.iconTrs_.gameObject, false)
				arg_263_1.callingController_:SetSelectedState("normal")

				local var_266_8 = arg_263_1:GetWordFromCfg(421072065)
				local var_266_9 = arg_263_1:FormatText(var_266_8.content)

				arg_263_1.text_.text = var_266_9

				LuaForUtil.ClearLinePrefixSymbol(arg_263_1.text_)

				local var_266_11 = 16 <= 0 and var_266_7 or var_266_7 * (utf8.len(var_266_9) / 16)

				if (16 <= 0 and var_266_7 or var_266_7 * (utf8.len(var_266_9) / 16)) > 0 and var_266_7 < var_266_11 then
					arg_263_1.talkMaxDuration = var_266_11

					if var_266_11 + var_266_6 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_11 + var_266_6
					end
				end

				arg_263_1.text_.text = var_266_9
				arg_263_1.typewritter.percent = 0

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421072", "421072065", "story_v_out_421072.awb") ~= 0 then
					local var_266_12 = manager.audio:GetVoiceLength("story_v_out_421072", "421072065", "story_v_out_421072.awb") / 1000

					if var_266_12 + var_266_6 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_12 + var_266_6
					end

					if var_266_8.prefab_name ~= "" and arg_263_1.actors_[var_266_8.prefab_name] ~= nil then
						local var_266_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_263_1.actors_[var_266_8.prefab_name].transform, "story_v_out_421072", "421072065", "story_v_out_421072.awb")

						arg_263_1:RecordAudio("421072065", var_266_13)
						arg_263_1:RecordAudio("421072065", var_266_13)
					else
						arg_263_1:AudioAction("play", "voice", "story_v_out_421072", "421072065", "story_v_out_421072.awb")
					end

					arg_263_1:RecordHistoryTalkVoice("story_v_out_421072", "421072065", "story_v_out_421072.awb")
				end

				arg_263_1:RecordContent(arg_263_1.text_.text)
			end

			local var_266_14 = math.max(var_266_7, arg_263_1.talkMaxDuration)

			if var_266_6 <= arg_263_1.time_ and arg_263_1.time_ < var_266_6 + var_266_14 then
				arg_263_1.typewritter.percent = (arg_263_1.time_ - var_266_6) / var_266_14

				arg_263_1.typewritter:SetDirty()
			end

			if arg_263_1.time_ >= var_266_6 + var_266_14 and arg_263_1.time_ < var_266_6 + var_266_14 + arg_266_0 then
				arg_263_1.typewritter.percent = 1

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(true)
			end
		end

		arg_263_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10145ui_story",
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
	Play421072066 = function(arg_267_0, arg_267_1)
		arg_267_1.time_ = 0
		arg_267_1.frameCnt_ = 0
		arg_267_1.state_ = "playing"
		arg_267_1.curTalkId_ = 421072066
		arg_267_1.duration_ = 5.5

		local var_267_0 = {
			zh = 5.5,
			ja = 5.233
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
				arg_267_0:Play421072067(arg_267_1)
			end
		end

		function arg_267_1.onSingleLineUpdate_(arg_270_0)
			if 0 < arg_267_1.time_ and arg_267_1.time_ <= 0 + arg_270_0 then
				arg_267_1.var_.moveOldPos1047ui_story = arg_267_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_270_0 = 0.001

			if 0 <= arg_267_1.time_ and arg_267_1.time_ < 0 + var_270_0 then
				arg_267_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_267_1.var_.moveOldPos1047ui_story, Vector3.New(-0.6, -1.13, -6.2), (arg_267_1.time_ - 0) / var_270_0)
				arg_267_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_267_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_267_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_267_1.actors_["1047ui_story"].transform.position).z)
				arg_267_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_267_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_267_1.actors_["1047ui_story"].transform.localEulerAngles = arg_267_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_267_1.time_ >= 0 + var_270_0 and arg_267_1.time_ < 0 + var_270_0 + arg_270_0 then
				arg_267_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(-0.6, -1.13, -6.2)
				arg_267_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_267_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_267_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_267_1.actors_["1047ui_story"].transform.position).z)
				arg_267_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_267_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_267_1.actors_["1047ui_story"].transform.localEulerAngles = arg_267_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_270_1 = arg_267_1.actors_["1047ui_story"]

			if 0 < arg_267_1.time_ and arg_267_1.time_ <= 0 + arg_270_0 and not isNil(var_270_1) and arg_267_1.var_.characterEffect1047ui_story == nil then
				arg_267_1.var_.characterEffect1047ui_story = var_270_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_270_2 = 0.200000002980232

			if 0 <= arg_267_1.time_ and arg_267_1.time_ < 0 + var_270_2 and not isNil(var_270_1) then
				if arg_267_1.var_.characterEffect1047ui_story and not isNil(var_270_1) then
					arg_267_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_267_1.time_ >= 0 + var_270_2 and arg_267_1.time_ < 0 + var_270_2 + arg_270_0 and not isNil(var_270_1) and arg_267_1.var_.characterEffect1047ui_story then
				arg_267_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_270_4 = arg_267_1.actors_["10145ui_story"]

			if 0 < arg_267_1.time_ and arg_267_1.time_ <= 0 + arg_270_0 and not isNil(var_270_4) and arg_267_1.var_.characterEffect10145ui_story == nil then
				arg_267_1.var_.characterEffect10145ui_story = var_270_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_270_5 = 0.200000002980232

			if 0 <= arg_267_1.time_ and arg_267_1.time_ < 0 + var_270_5 and not isNil(var_270_4) then
				if arg_267_1.var_.characterEffect10145ui_story and not isNil(var_270_4) then
					arg_267_1.var_.characterEffect10145ui_story.fillFlat = true
					arg_267_1.var_.characterEffect10145ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_267_1.time_ - 0) / var_270_5)
				end
			end

			if arg_267_1.time_ >= 0 + var_270_5 and arg_267_1.time_ < 0 + var_270_5 + arg_270_0 and not isNil(var_270_4) and arg_267_1.var_.characterEffect10145ui_story then
				arg_267_1.var_.characterEffect10145ui_story.fillFlat = true
				arg_267_1.var_.characterEffect10145ui_story.fillRatio = 0.5
			end

			if 0 < arg_267_1.time_ and arg_267_1.time_ <= 0 + arg_270_0 then
				arg_267_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action7_2")
			end

			if 0 < arg_267_1.time_ and arg_267_1.time_ <= 0 + arg_270_0 then
				arg_267_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_270_6 = 0
			local var_270_7 = 0.625

			if 0 < arg_267_1.time_ and arg_267_1.time_ <= var_270_6 + arg_270_0 then
				arg_267_1.talkMaxDuration = 0
				arg_267_1.dialogCg_.alpha = 1

				arg_267_1.dialog_:SetActive(true)
				SetActive(arg_267_1.leftNameGo_, true)

				arg_267_1.leftNameTxt_.text = arg_267_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_267_1.leftNameTxt_.transform)

				arg_267_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_267_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_267_1:RecordName(arg_267_1.leftNameTxt_.text)
				SetActive(arg_267_1.iconTrs_.gameObject, false)
				arg_267_1.callingController_:SetSelectedState("normal")

				local var_270_8 = arg_267_1:GetWordFromCfg(421072066)
				local var_270_9 = arg_267_1:FormatText(var_270_8.content)

				arg_267_1.text_.text = var_270_9

				LuaForUtil.ClearLinePrefixSymbol(arg_267_1.text_)

				local var_270_11 = 25 <= 0 and var_270_7 or var_270_7 * (utf8.len(var_270_9) / 25)

				if (25 <= 0 and var_270_7 or var_270_7 * (utf8.len(var_270_9) / 25)) > 0 and var_270_7 < var_270_11 then
					arg_267_1.talkMaxDuration = var_270_11

					if var_270_11 + var_270_6 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_11 + var_270_6
					end
				end

				arg_267_1.text_.text = var_270_9
				arg_267_1.typewritter.percent = 0

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421072", "421072066", "story_v_out_421072.awb") ~= 0 then
					local var_270_12 = manager.audio:GetVoiceLength("story_v_out_421072", "421072066", "story_v_out_421072.awb") / 1000

					if var_270_12 + var_270_6 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_12 + var_270_6
					end

					if var_270_8.prefab_name ~= "" and arg_267_1.actors_[var_270_8.prefab_name] ~= nil then
						local var_270_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_267_1.actors_[var_270_8.prefab_name].transform, "story_v_out_421072", "421072066", "story_v_out_421072.awb")

						arg_267_1:RecordAudio("421072066", var_270_13)
						arg_267_1:RecordAudio("421072066", var_270_13)
					else
						arg_267_1:AudioAction("play", "voice", "story_v_out_421072", "421072066", "story_v_out_421072.awb")
					end

					arg_267_1:RecordHistoryTalkVoice("story_v_out_421072", "421072066", "story_v_out_421072.awb")
				end

				arg_267_1:RecordContent(arg_267_1.text_.text)
			end

			local var_270_14 = math.max(var_270_7, arg_267_1.talkMaxDuration)

			if var_270_6 <= arg_267_1.time_ and arg_267_1.time_ < var_270_6 + var_270_14 then
				arg_267_1.typewritter.percent = (arg_267_1.time_ - var_270_6) / var_270_14

				arg_267_1.typewritter:SetDirty()
			end

			if arg_267_1.time_ >= var_270_6 + var_270_14 and arg_267_1.time_ < var_270_6 + var_270_14 + arg_270_0 then
				arg_267_1.typewritter.percent = 1

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(true)
			end
		end

		arg_267_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
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
	Play421072067 = function(arg_271_0, arg_271_1)
		arg_271_1.time_ = 0
		arg_271_1.frameCnt_ = 0
		arg_271_1.state_ = "playing"
		arg_271_1.curTalkId_ = 421072067
		arg_271_1.duration_ = 5

		SetActive(arg_271_1.tipsGo_, false)

		function arg_271_1.onSingleLineFinish_()
			arg_271_1.onSingleLineUpdate_ = nil
			arg_271_1.onSingleLineFinish_ = nil
			arg_271_1.state_ = "waiting"
		end

		function arg_271_1.playNext_(arg_273_0)
			if arg_273_0 == 1 then
				arg_271_0:Play421072068(arg_271_1)
			end
		end

		function arg_271_1.onSingleLineUpdate_(arg_274_0)
			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 then
				arg_271_1.var_.moveOldPos10145ui_story = arg_271_1.actors_["10145ui_story"].transform.localPosition
			end

			local var_274_0 = 0.001

			if 0 <= arg_271_1.time_ and arg_271_1.time_ < 0 + var_274_0 then
				arg_271_1.actors_["10145ui_story"].transform.localPosition = Vector3.Lerp(arg_271_1.var_.moveOldPos10145ui_story, Vector3.New(0, 100, 0), (arg_271_1.time_ - 0) / var_274_0)
				arg_271_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_271_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_271_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_271_1.actors_["10145ui_story"].transform.position).z)
				arg_271_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_271_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_271_1.actors_["10145ui_story"].transform.localEulerAngles = arg_271_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			if arg_271_1.time_ >= 0 + var_274_0 and arg_271_1.time_ < 0 + var_274_0 + arg_274_0 then
				arg_271_1.actors_["10145ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_271_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_271_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_271_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_271_1.actors_["10145ui_story"].transform.position).z)
				arg_271_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_271_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_271_1.actors_["10145ui_story"].transform.localEulerAngles = arg_271_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			local var_274_1 = arg_271_1.actors_["1047ui_story"].transform

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 then
				arg_271_1.var_.moveOldPos1047ui_story = var_274_1.localPosition
			end

			local var_274_2 = 0.001

			if 0 <= arg_271_1.time_ and arg_271_1.time_ < 0 + var_274_2 then
				var_274_1.localPosition = Vector3.Lerp(arg_271_1.var_.moveOldPos1047ui_story, Vector3.New(0, 100, 0), (arg_271_1.time_ - 0) / var_274_2)
				var_274_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_274_1.position).x, (manager.ui.mainCamera.transform.position - var_274_1.position).y, (manager.ui.mainCamera.transform.position - var_274_1.position).z)
				var_274_1.localEulerAngles.z = 0
				var_274_1.localEulerAngles.x = 0
				var_274_1.localEulerAngles = var_274_1.localEulerAngles
			end

			if arg_271_1.time_ >= 0 + var_274_2 and arg_271_1.time_ < 0 + var_274_2 + arg_274_0 then
				var_274_1.localPosition = Vector3.New(0, 100, 0)
				var_274_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_274_1.position).x, (manager.ui.mainCamera.transform.position - var_274_1.position).y, (manager.ui.mainCamera.transform.position - var_274_1.position).z)
				var_274_1.localEulerAngles.z = 0
				var_274_1.localEulerAngles.x = 0
				var_274_1.localEulerAngles = var_274_1.localEulerAngles
			end

			if 0.1 < arg_271_1.time_ and arg_271_1.time_ <= 0.1 + arg_274_0 then
				arg_271_1:AudioAction("play", "effect", "se_story_142", "se_story_142_footstep01", "")
			end

			local var_274_4 = 0
			local var_274_5 = 0.475

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= var_274_4 + arg_274_0 then
				arg_271_1.talkMaxDuration = 0
				arg_271_1.dialogCg_.alpha = 1

				arg_271_1.dialog_:SetActive(true)
				SetActive(arg_271_1.leftNameGo_, false)

				arg_271_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_271_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_271_1:RecordName(arg_271_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_271_1.iconTrs_.gameObject, false)
				arg_271_1.callingController_:SetSelectedState("normal")

				local var_274_6 = arg_271_1:FormatText(arg_271_1:GetWordFromCfg(421072067).content)

				arg_271_1.text_.text = var_274_6

				LuaForUtil.ClearLinePrefixSymbol(arg_271_1.text_)

				local var_274_8 = 19 <= 0 and var_274_5 or var_274_5 * (utf8.len(var_274_6) / 19)

				if (19 <= 0 and var_274_5 or var_274_5 * (utf8.len(var_274_6) / 19)) > 0 and var_274_5 < var_274_8 then
					arg_271_1.talkMaxDuration = var_274_8

					if var_274_8 + var_274_4 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_8 + var_274_4
					end
				end

				arg_271_1.text_.text = var_274_6
				arg_271_1.typewritter.percent = 0

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(false)
				arg_271_1:RecordContent(arg_271_1.text_.text)
			end

			local var_274_9 = math.max(var_274_5, arg_271_1.talkMaxDuration)

			if var_274_4 <= arg_271_1.time_ and arg_271_1.time_ < var_274_4 + var_274_9 then
				arg_271_1.typewritter.percent = (arg_271_1.time_ - var_274_4) / var_274_9

				arg_271_1.typewritter:SetDirty()
			end

			if arg_271_1.time_ >= var_274_4 + var_274_9 and arg_271_1.time_ < var_274_4 + var_274_9 + arg_274_0 then
				arg_271_1.typewritter.percent = 1

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(true)
			end
		end

		arg_271_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10145ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_271_1:InitPlayNodeList()
	end,
	Play421072068 = function(arg_275_0, arg_275_1)
		arg_275_1.time_ = 0
		arg_275_1.frameCnt_ = 0
		arg_275_1.state_ = "playing"
		arg_275_1.curTalkId_ = 421072068
		arg_275_1.duration_ = 7.1

		local var_275_0 = {
			zh = 4.033,
			ja = 7.1
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
			arg_275_1.auto_ = false
		end

		function arg_275_1.playNext_(arg_277_0)
			arg_275_1.onStoryFinished_()
		end

		function arg_275_1.onSingleLineUpdate_(arg_278_0)
			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 then
				arg_275_1.var_.moveOldPos10145ui_story = arg_275_1.actors_["10145ui_story"].transform.localPosition
			end

			local var_278_0 = 0.001

			if 0 <= arg_275_1.time_ and arg_275_1.time_ < 0 + var_278_0 then
				arg_275_1.actors_["10145ui_story"].transform.localPosition = Vector3.Lerp(arg_275_1.var_.moveOldPos10145ui_story, Vector3.New(0, -1, -6.2), (arg_275_1.time_ - 0) / var_278_0)
				arg_275_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_275_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_275_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_275_1.actors_["10145ui_story"].transform.position).z)
				arg_275_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_275_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_275_1.actors_["10145ui_story"].transform.localEulerAngles = arg_275_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			if arg_275_1.time_ >= 0 + var_278_0 and arg_275_1.time_ < 0 + var_278_0 + arg_278_0 then
				arg_275_1.actors_["10145ui_story"].transform.localPosition = Vector3.New(0, -1, -6.2)
				arg_275_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_275_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_275_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_275_1.actors_["10145ui_story"].transform.position).z)
				arg_275_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_275_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_275_1.actors_["10145ui_story"].transform.localEulerAngles = arg_275_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			local var_278_1 = arg_275_1.actors_["10145ui_story"]

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 and not isNil(var_278_1) and arg_275_1.var_.characterEffect10145ui_story == nil then
				arg_275_1.var_.characterEffect10145ui_story = var_278_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_278_2 = 0.200000002980232

			if 0 <= arg_275_1.time_ and arg_275_1.time_ < 0 + var_278_2 and not isNil(var_278_1) then
				if arg_275_1.var_.characterEffect10145ui_story and not isNil(var_278_1) then
					arg_275_1.var_.characterEffect10145ui_story.fillFlat = false
				end
			end

			if arg_275_1.time_ >= 0 + var_278_2 and arg_275_1.time_ < 0 + var_278_2 + arg_278_0 and not isNil(var_278_1) and arg_275_1.var_.characterEffect10145ui_story then
				arg_275_1.var_.characterEffect10145ui_story.fillFlat = false
			end

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 then
				arg_275_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/story10145/story10145action/10145action9_1")
			end

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 then
				arg_275_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_278_4 = 0
			local var_278_5 = 0.55

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= var_278_4 + arg_278_0 then
				arg_275_1.talkMaxDuration = 0
				arg_275_1.dialogCg_.alpha = 1

				arg_275_1.dialog_:SetActive(true)
				SetActive(arg_275_1.leftNameGo_, true)

				arg_275_1.leftNameTxt_.text = arg_275_1:FormatText(StoryNameCfg[1308].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_275_1.leftNameTxt_.transform)

				arg_275_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_275_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_275_1:RecordName(arg_275_1.leftNameTxt_.text)
				SetActive(arg_275_1.iconTrs_.gameObject, false)
				arg_275_1.callingController_:SetSelectedState("normal")

				local var_278_6 = arg_275_1:GetWordFromCfg(421072068)
				local var_278_7 = arg_275_1:FormatText(var_278_6.content)

				arg_275_1.text_.text = var_278_7

				LuaForUtil.ClearLinePrefixSymbol(arg_275_1.text_)

				local var_278_9 = 22 <= 0 and var_278_5 or var_278_5 * (utf8.len(var_278_7) / 22)

				if (22 <= 0 and var_278_5 or var_278_5 * (utf8.len(var_278_7) / 22)) > 0 and var_278_5 < var_278_9 then
					arg_275_1.talkMaxDuration = var_278_9

					if var_278_9 + var_278_4 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_9 + var_278_4
					end
				end

				arg_275_1.text_.text = var_278_7
				arg_275_1.typewritter.percent = 0

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421072", "421072068", "story_v_out_421072.awb") ~= 0 then
					local var_278_10 = manager.audio:GetVoiceLength("story_v_out_421072", "421072068", "story_v_out_421072.awb") / 1000

					if var_278_10 + var_278_4 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_10 + var_278_4
					end

					if var_278_6.prefab_name ~= "" and arg_275_1.actors_[var_278_6.prefab_name] ~= nil then
						local var_278_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_275_1.actors_[var_278_6.prefab_name].transform, "story_v_out_421072", "421072068", "story_v_out_421072.awb")

						arg_275_1:RecordAudio("421072068", var_278_11)
						arg_275_1:RecordAudio("421072068", var_278_11)
					else
						arg_275_1:AudioAction("play", "voice", "story_v_out_421072", "421072068", "story_v_out_421072.awb")
					end

					arg_275_1:RecordHistoryTalkVoice("story_v_out_421072", "421072068", "story_v_out_421072.awb")
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

		arg_275_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10145ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_275_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/D10",
		"TextureConfig/Background/ST34a"
	},
	voices = {
		"story_v_out_421072.awb"
	}
}
