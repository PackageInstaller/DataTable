return {
	Play319741001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 319741001
		arg_1_1.duration_ = 7.9

		local var_1_0 = {
			zh = 5.932999999999,
			ja = 7.899999999999
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
				arg_1_0:Play319741002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.I11m == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "I11m")
				var_4_0.name = "I11m"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.I11m = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.I11m

				arg_1_1.bgs_.I11m.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "I11m" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_4 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_4 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			if arg_1_1.time_ >= var_4_4 + 0.3 and arg_1_1.time_ < var_4_4 + 0.3 + arg_4_0 then
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

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_11 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_11 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_11

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_11
						arg_1_1.bgmTxt2_.text = var_4_11
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
				arg_1_1:AudioAction("play", "music", "bgm_activity_3_0_story_daily_leisure", "bgm_activity_3_0_story_daily_leisure", "bgm_activity_3_0_story_daily_leisure.awb")

				local var_4_14 = manager.audio:GetAudioName("bgm_activity_3_0_story_daily_leisure", "bgm_activity_3_0_story_daily_leisure")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_14 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_14

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_14
						arg_1_1.bgmTxt2_.text = var_4_14
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

			local var_4_15 = 1.999999999999
			local var_4_16 = 0.675

			if 1.999999999999 < arg_1_1.time_ and arg_1_1.time_ <= var_4_15 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_17 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_17:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[648].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2078")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_18 = arg_1_1:GetWordFromCfg(319741001)
				local var_4_19 = arg_1_1:FormatText(var_4_18.content)

				arg_1_1.text_.text = var_4_19

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_21 = 27 <= 0 and var_4_16 or var_4_16 * (utf8.len(var_4_19) / 27)

				if (27 <= 0 and var_4_16 or var_4_16 * (utf8.len(var_4_19) / 27)) > 0 and var_4_16 < var_4_21 then
					arg_1_1.talkMaxDuration = var_4_21
					var_4_15 = var_4_15 + 0.3

					if var_4_21 + var_4_15 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_21 + var_4_15
					end
				end

				arg_1_1.text_.text = var_4_19
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319741", "319741001", "story_v_out_319741.awb") ~= 0 then
					local var_4_22 = manager.audio:GetVoiceLength("story_v_out_319741", "319741001", "story_v_out_319741.awb") / 1000

					if var_4_22 + var_4_15 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_22 + var_4_15
					end

					if var_4_18.prefab_name ~= "" and arg_1_1.actors_[var_4_18.prefab_name] ~= nil then
						local var_4_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_18.prefab_name].transform, "story_v_out_319741", "319741001", "story_v_out_319741.awb")

						arg_1_1:RecordAudio("319741001", var_4_23)
						arg_1_1:RecordAudio("319741001", var_4_23)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_319741", "319741001", "story_v_out_319741.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_319741", "319741001", "story_v_out_319741.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_24 = var_4_15 + 0.3
			local var_4_25 = math.max(var_4_16, arg_1_1.talkMaxDuration)

			if var_4_15 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_24 + var_4_25 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_24) / var_4_25

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_24 + var_4_25 and arg_1_1.time_ < var_4_24 + var_4_25 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play319741002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 319741002
		arg_9_1.duration_ = 3.27

		local var_9_0 = {
			zh = 1.999999999999,
			ja = 3.266
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
				arg_9_0:Play319741003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			if arg_9_1.actors_["10079ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10079ui_story"))) then
				local var_12_0 = Object.Instantiate(Asset.Load("Char/" .. "10079ui_story"), arg_9_1.stage_.transform)

				var_12_0.name = "10079ui_story"
				var_12_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_9_1.actors_["10079ui_story"] = var_12_0

				local var_12_1 = var_12_0:GetComponentInChildren(typeof(CharacterEffect))

				var_12_1.enabled = true

				local var_12_2 = GameObjectTools.GetOrAddComponent(var_12_0, typeof(DynamicBoneHelper))

				if var_12_2 then
					var_12_2:EnableDynamicBone(false)
				end

				arg_9_1:ShowWeapon(var_12_1.transform, false)

				arg_9_1.var_["10079ui_story" .. "Animator"] = var_12_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_9_1.var_["10079ui_story" .. "Animator"].applyRootMotion = true
				arg_9_1.var_["10079ui_story" .. "LipSync"] = var_12_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_12_3 = arg_9_1.actors_["10079ui_story"].transform

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.var_.moveOldPos10079ui_story = var_12_3.localPosition

				arg_9_1:ShowWeapon(arg_9_1.var_["10079ui_story" .. "Animator"].transform, false)
			end

			local var_12_4 = 0.001

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_4 then
				var_12_3.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos10079ui_story, Vector3.New(0, -0.95, -6.05), (arg_9_1.time_ - 0) / var_12_4)
				var_12_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_12_3.position).x, (manager.ui.mainCamera.transform.position - var_12_3.position).y, (manager.ui.mainCamera.transform.position - var_12_3.position).z)
				var_12_3.localEulerAngles.z = 0
				var_12_3.localEulerAngles.x = 0
				var_12_3.localEulerAngles = var_12_3.localEulerAngles
			end

			if arg_9_1.time_ >= 0 + var_12_4 and arg_9_1.time_ < 0 + var_12_4 + arg_12_0 then
				var_12_3.localPosition = Vector3.New(0, -0.95, -6.05)
				var_12_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_12_3.position).x, (manager.ui.mainCamera.transform.position - var_12_3.position).y, (manager.ui.mainCamera.transform.position - var_12_3.position).z)
				var_12_3.localEulerAngles.z = 0
				var_12_3.localEulerAngles.x = 0
				var_12_3.localEulerAngles = var_12_3.localEulerAngles
			end

			local var_12_5 = arg_9_1.actors_["10079ui_story"]

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 and not isNil(var_12_5) and arg_9_1.var_.characterEffect10079ui_story == nil then
				arg_9_1.var_.characterEffect10079ui_story = var_12_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_6 = 0.200000002980232

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_6 and not isNil(var_12_5) then
				if arg_9_1.var_.characterEffect10079ui_story and not isNil(var_12_5) then
					arg_9_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_9_1.time_ >= 0 + var_12_6 and arg_9_1.time_ < 0 + var_12_6 + arg_12_0 and not isNil(var_12_5) and arg_9_1.var_.characterEffect10079ui_story then
				arg_9_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_12_8 = 0
			local var_12_9 = 0.15

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_8 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				arg_9_1.leftNameTxt_.text = arg_9_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_10 = arg_9_1:GetWordFromCfg(319741002)
				local var_12_11 = arg_9_1:FormatText(var_12_10.content)

				arg_9_1.text_.text = var_12_11

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_13 = 6 <= 0 and var_12_9 or var_12_9 * (utf8.len(var_12_11) / 6)

				if (6 <= 0 and var_12_9 or var_12_9 * (utf8.len(var_12_11) / 6)) > 0 and var_12_9 < var_12_13 then
					arg_9_1.talkMaxDuration = var_12_13

					if var_12_13 + var_12_8 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_13 + var_12_8
					end
				end

				arg_9_1.text_.text = var_12_11
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319741", "319741002", "story_v_out_319741.awb") ~= 0 then
					local var_12_14 = manager.audio:GetVoiceLength("story_v_out_319741", "319741002", "story_v_out_319741.awb") / 1000

					if var_12_14 + var_12_8 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_14 + var_12_8
					end

					if var_12_10.prefab_name ~= "" and arg_9_1.actors_[var_12_10.prefab_name] ~= nil then
						local var_12_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_10.prefab_name].transform, "story_v_out_319741", "319741002", "story_v_out_319741.awb")

						arg_9_1:RecordAudio("319741002", var_12_15)
						arg_9_1:RecordAudio("319741002", var_12_15)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_319741", "319741002", "story_v_out_319741.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_319741", "319741002", "story_v_out_319741.awb")
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
				actorName = "10079ui_story",
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
	Play319741003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 319741003
		arg_13_1.duration_ = 3.67

		local var_13_0 = {
			zh = 3.666,
			ja = 2.566
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
				arg_13_0:Play319741004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(arg_13_1.actors_["10079ui_story"]) and arg_13_1.var_.characterEffect10079ui_story == nil then
				arg_13_1.var_.characterEffect10079ui_story = arg_13_1.actors_["10079ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_0 = 0.200000002980232

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_0 and not isNil(arg_13_1.actors_["10079ui_story"]) then
				if arg_13_1.var_.characterEffect10079ui_story and not isNil(arg_13_1.actors_["10079ui_story"]) then
					arg_13_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_13_1.var_.characterEffect10079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_13_1.time_ - 0) / var_16_0)
				end
			end

			if arg_13_1.time_ >= 0 + var_16_0 and arg_13_1.time_ < 0 + var_16_0 + arg_16_0 and not isNil(arg_13_1.actors_["10079ui_story"]) and arg_13_1.var_.characterEffect10079ui_story then
				arg_13_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_13_1.var_.characterEffect10079ui_story.fillRatio = 0.5
			end

			local var_16_1 = 0
			local var_16_2 = 0.475

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_1 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[648].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, true)
				arg_13_1.iconController_:SetSelectedState("hero")

				arg_13_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2078")

				arg_13_1.callingController_:SetSelectedState("normal")

				arg_13_1.keyicon_.color = Color.New(1, 1, 1)
				arg_13_1.icon_.color = Color.New(1, 1, 1)

				local var_16_3 = arg_13_1:GetWordFromCfg(319741003)
				local var_16_4 = arg_13_1:FormatText(var_16_3.content)

				arg_13_1.text_.text = var_16_4

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_6 = 19 <= 0 and var_16_2 or var_16_2 * (utf8.len(var_16_4) / 19)

				if (19 <= 0 and var_16_2 or var_16_2 * (utf8.len(var_16_4) / 19)) > 0 and var_16_2 < var_16_6 then
					arg_13_1.talkMaxDuration = var_16_6

					if var_16_6 + var_16_1 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_6 + var_16_1
					end
				end

				arg_13_1.text_.text = var_16_4
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319741", "319741003", "story_v_out_319741.awb") ~= 0 then
					local var_16_7 = manager.audio:GetVoiceLength("story_v_out_319741", "319741003", "story_v_out_319741.awb") / 1000

					if var_16_7 + var_16_1 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_7 + var_16_1
					end

					if var_16_3.prefab_name ~= "" and arg_13_1.actors_[var_16_3.prefab_name] ~= nil then
						local var_16_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_3.prefab_name].transform, "story_v_out_319741", "319741003", "story_v_out_319741.awb")

						arg_13_1:RecordAudio("319741003", var_16_8)
						arg_13_1:RecordAudio("319741003", var_16_8)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_319741", "319741003", "story_v_out_319741.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_319741", "319741003", "story_v_out_319741.awb")
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
	Play319741004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 319741004
		arg_17_1.duration_ = 6.3

		local var_17_0 = {
			zh = 6.033,
			ja = 6.3
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
				arg_17_0:Play319741005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = 0.825

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[648].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, true)
				arg_17_1.iconController_:SetSelectedState("hero")

				arg_17_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2078")

				arg_17_1.callingController_:SetSelectedState("normal")

				arg_17_1.keyicon_.color = Color.New(1, 1, 1)
				arg_17_1.icon_.color = Color.New(1, 1, 1)

				local var_20_1 = arg_17_1:GetWordFromCfg(319741004)
				local var_20_2 = arg_17_1:FormatText(var_20_1.content)

				arg_17_1.text_.text = var_20_2

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_4 = 33 <= 0 and var_20_0 or var_20_0 * (utf8.len(var_20_2) / 33)

				if (33 <= 0 and var_20_0 or var_20_0 * (utf8.len(var_20_2) / 33)) > 0 and var_20_0 < var_20_4 then
					arg_17_1.talkMaxDuration = var_20_4

					if var_20_4 + 0 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_4 + 0
					end
				end

				arg_17_1.text_.text = var_20_2
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319741", "319741004", "story_v_out_319741.awb") ~= 0 then
					local var_20_5 = manager.audio:GetVoiceLength("story_v_out_319741", "319741004", "story_v_out_319741.awb") / 1000

					if var_20_5 + 0 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_5 + 0
					end

					if var_20_1.prefab_name ~= "" and arg_17_1.actors_[var_20_1.prefab_name] ~= nil then
						local var_20_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_1.prefab_name].transform, "story_v_out_319741", "319741004", "story_v_out_319741.awb")

						arg_17_1:RecordAudio("319741004", var_20_6)
						arg_17_1:RecordAudio("319741004", var_20_6)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_319741", "319741004", "story_v_out_319741.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_319741", "319741004", "story_v_out_319741.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_7 = math.max(var_20_0, arg_17_1.talkMaxDuration)

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_7 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - 0) / var_20_7

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= 0 + var_20_7 and arg_17_1.time_ < 0 + var_20_7 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play319741005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 319741005
		arg_21_1.duration_ = 4.7

		local var_21_0 = {
			zh = 2.766,
			ja = 4.7
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
				arg_21_0:Play319741006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.var_.moveOldPos10079ui_story = arg_21_1.actors_["10079ui_story"].transform.localPosition
			end

			local var_24_0 = 0.001

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_0 then
				arg_21_1.actors_["10079ui_story"].transform.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos10079ui_story, Vector3.New(0, -0.95, -6.05), (arg_21_1.time_ - 0) / var_24_0)
				arg_21_1.actors_["10079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_21_1.actors_["10079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["10079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["10079ui_story"].transform.position).z)
				arg_21_1.actors_["10079ui_story"].transform.localEulerAngles.z = 0
				arg_21_1.actors_["10079ui_story"].transform.localEulerAngles.x = 0
				arg_21_1.actors_["10079ui_story"].transform.localEulerAngles = arg_21_1.actors_["10079ui_story"].transform.localEulerAngles
			end

			if arg_21_1.time_ >= 0 + var_24_0 and arg_21_1.time_ < 0 + var_24_0 + arg_24_0 then
				arg_21_1.actors_["10079ui_story"].transform.localPosition = Vector3.New(0, -0.95, -6.05)
				arg_21_1.actors_["10079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_21_1.actors_["10079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["10079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["10079ui_story"].transform.position).z)
				arg_21_1.actors_["10079ui_story"].transform.localEulerAngles.z = 0
				arg_21_1.actors_["10079ui_story"].transform.localEulerAngles.x = 0
				arg_21_1.actors_["10079ui_story"].transform.localEulerAngles = arg_21_1.actors_["10079ui_story"].transform.localEulerAngles
			end

			local var_24_1 = arg_21_1.actors_["10079ui_story"]

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(var_24_1) and arg_21_1.var_.characterEffect10079ui_story == nil then
				arg_21_1.var_.characterEffect10079ui_story = var_24_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_2 = 0.200000002980232

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_2 and not isNil(var_24_1) then
				if arg_21_1.var_.characterEffect10079ui_story and not isNil(var_24_1) then
					arg_21_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_21_1.time_ >= 0 + var_24_2 and arg_21_1.time_ < 0 + var_24_2 + arg_24_0 and not isNil(var_24_1) and arg_21_1.var_.characterEffect10079ui_story then
				arg_21_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action12_1")
			end

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_24_4 = 0
			local var_24_5 = 0.25

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

				local var_24_6 = arg_21_1:GetWordFromCfg(319741005)
				local var_24_7 = arg_21_1:FormatText(var_24_6.content)

				arg_21_1.text_.text = var_24_7

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_9 = 10 <= 0 and var_24_5 or var_24_5 * (utf8.len(var_24_7) / 10)

				if (10 <= 0 and var_24_5 or var_24_5 * (utf8.len(var_24_7) / 10)) > 0 and var_24_5 < var_24_9 then
					arg_21_1.talkMaxDuration = var_24_9

					if var_24_9 + var_24_4 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_9 + var_24_4
					end
				end

				arg_21_1.text_.text = var_24_7
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319741", "319741005", "story_v_out_319741.awb") ~= 0 then
					local var_24_10 = manager.audio:GetVoiceLength("story_v_out_319741", "319741005", "story_v_out_319741.awb") / 1000

					if var_24_10 + var_24_4 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_10 + var_24_4
					end

					if var_24_6.prefab_name ~= "" and arg_21_1.actors_[var_24_6.prefab_name] ~= nil then
						local var_24_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_6.prefab_name].transform, "story_v_out_319741", "319741005", "story_v_out_319741.awb")

						arg_21_1:RecordAudio("319741005", var_24_11)
						arg_21_1:RecordAudio("319741005", var_24_11)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_319741", "319741005", "story_v_out_319741.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_319741", "319741005", "story_v_out_319741.awb")
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
				actorName = "10079ui_story",
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
	Play319741006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 319741006
		arg_25_1.duration_ = 5

		local var_25_0 = {
			zh = 4.866,
			ja = 5
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
				arg_25_0:Play319741007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(arg_25_1.actors_["10079ui_story"]) and arg_25_1.var_.characterEffect10079ui_story == nil then
				arg_25_1.var_.characterEffect10079ui_story = arg_25_1.actors_["10079ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_0 = 0.200000002980232

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_0 and not isNil(arg_25_1.actors_["10079ui_story"]) then
				if arg_25_1.var_.characterEffect10079ui_story and not isNil(arg_25_1.actors_["10079ui_story"]) then
					arg_25_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_25_1.var_.characterEffect10079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_25_1.time_ - 0) / var_28_0)
				end
			end

			if arg_25_1.time_ >= 0 + var_28_0 and arg_25_1.time_ < 0 + var_28_0 + arg_28_0 and not isNil(arg_25_1.actors_["10079ui_story"]) and arg_25_1.var_.characterEffect10079ui_story then
				arg_25_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_25_1.var_.characterEffect10079ui_story.fillRatio = 0.5
			end

			local var_28_1 = 0
			local var_28_2 = 0.7

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_1 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[648].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, true)
				arg_25_1.iconController_:SetSelectedState("hero")

				arg_25_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2078")

				arg_25_1.callingController_:SetSelectedState("normal")

				arg_25_1.keyicon_.color = Color.New(1, 1, 1)
				arg_25_1.icon_.color = Color.New(1, 1, 1)

				local var_28_3 = arg_25_1:GetWordFromCfg(319741006)
				local var_28_4 = arg_25_1:FormatText(var_28_3.content)

				arg_25_1.text_.text = var_28_4

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_6 = 28 <= 0 and var_28_2 or var_28_2 * (utf8.len(var_28_4) / 28)

				if (28 <= 0 and var_28_2 or var_28_2 * (utf8.len(var_28_4) / 28)) > 0 and var_28_2 < var_28_6 then
					arg_25_1.talkMaxDuration = var_28_6

					if var_28_6 + var_28_1 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_6 + var_28_1
					end
				end

				arg_25_1.text_.text = var_28_4
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319741", "319741006", "story_v_out_319741.awb") ~= 0 then
					local var_28_7 = manager.audio:GetVoiceLength("story_v_out_319741", "319741006", "story_v_out_319741.awb") / 1000

					if var_28_7 + var_28_1 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_7 + var_28_1
					end

					if var_28_3.prefab_name ~= "" and arg_25_1.actors_[var_28_3.prefab_name] ~= nil then
						local var_28_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_3.prefab_name].transform, "story_v_out_319741", "319741006", "story_v_out_319741.awb")

						arg_25_1:RecordAudio("319741006", var_28_8)
						arg_25_1:RecordAudio("319741006", var_28_8)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_319741", "319741006", "story_v_out_319741.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_319741", "319741006", "story_v_out_319741.awb")
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
	Play319741007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 319741007
		arg_29_1.duration_ = 5

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play319741008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = 0.925

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

				local var_32_1 = arg_29_1:FormatText(arg_29_1:GetWordFromCfg(319741007).content)

				arg_29_1.text_.text = var_32_1

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_3 = 37 <= 0 and var_32_0 or var_32_0 * (utf8.len(var_32_1) / 37)

				if (37 <= 0 and var_32_0 or var_32_0 * (utf8.len(var_32_1) / 37)) > 0 and var_32_0 < var_32_3 then
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
	Play319741008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 319741008
		arg_33_1.duration_ = 5

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play319741009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1.var_.moveOldPos10079ui_story = arg_33_1.actors_["10079ui_story"].transform.localPosition

				arg_33_1:ShowWeapon(arg_33_1.var_["10079ui_story" .. "Animator"].transform, false)
			end

			local var_36_0 = 0.001

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_0 then
				arg_33_1.actors_["10079ui_story"].transform.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos10079ui_story, Vector3.New(0, 100, 0), (arg_33_1.time_ - 0) / var_36_0)
				arg_33_1.actors_["10079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_33_1.actors_["10079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["10079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["10079ui_story"].transform.position).z)
				arg_33_1.actors_["10079ui_story"].transform.localEulerAngles.z = 0
				arg_33_1.actors_["10079ui_story"].transform.localEulerAngles.x = 0
				arg_33_1.actors_["10079ui_story"].transform.localEulerAngles = arg_33_1.actors_["10079ui_story"].transform.localEulerAngles
			end

			if arg_33_1.time_ >= 0 + var_36_0 and arg_33_1.time_ < 0 + var_36_0 + arg_36_0 then
				arg_33_1.actors_["10079ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_33_1.actors_["10079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_33_1.actors_["10079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["10079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["10079ui_story"].transform.position).z)
				arg_33_1.actors_["10079ui_story"].transform.localEulerAngles.z = 0
				arg_33_1.actors_["10079ui_story"].transform.localEulerAngles.x = 0
				arg_33_1.actors_["10079ui_story"].transform.localEulerAngles = arg_33_1.actors_["10079ui_story"].transform.localEulerAngles
			end

			local var_36_1 = 0
			local var_36_2 = 1.075

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_1 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, false)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_3 = arg_33_1:FormatText(arg_33_1:GetWordFromCfg(319741008).content)

				arg_33_1.text_.text = var_36_3

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_5 = 43 <= 0 and var_36_2 or var_36_2 * (utf8.len(var_36_3) / 43)

				if (43 <= 0 and var_36_2 or var_36_2 * (utf8.len(var_36_3) / 43)) > 0 and var_36_2 < var_36_5 then
					arg_33_1.talkMaxDuration = var_36_5

					if var_36_5 + var_36_1 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_5 + var_36_1
					end
				end

				arg_33_1.text_.text = var_36_3
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)
				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_6 = math.max(var_36_2, arg_33_1.talkMaxDuration)

			if var_36_1 <= arg_33_1.time_ and arg_33_1.time_ < var_36_1 + var_36_6 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_1) / var_36_6

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_1 + var_36_6 and arg_33_1.time_ < var_36_1 + var_36_6 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {
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

		arg_33_1:InitPlayNodeList()
	end,
	Play319741009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 319741009
		arg_37_1.duration_ = 2.37

		local var_37_0 = {
			zh = 1.999999999999,
			ja = 2.366
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
				arg_37_0:Play319741010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			if arg_37_1.actors_["10066ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10066ui_story"))) then
				local var_40_0 = Object.Instantiate(Asset.Load("Char/" .. "10066ui_story"), arg_37_1.stage_.transform)

				var_40_0.name = "10066ui_story"
				var_40_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_37_1.actors_["10066ui_story"] = var_40_0

				local var_40_1 = var_40_0:GetComponentInChildren(typeof(CharacterEffect))

				var_40_1.enabled = true

				local var_40_2 = GameObjectTools.GetOrAddComponent(var_40_0, typeof(DynamicBoneHelper))

				if var_40_2 then
					var_40_2:EnableDynamicBone(false)
				end

				arg_37_1:ShowWeapon(var_40_1.transform, false)

				arg_37_1.var_["10066ui_story" .. "Animator"] = var_40_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_37_1.var_["10066ui_story" .. "Animator"].applyRootMotion = true
				arg_37_1.var_["10066ui_story" .. "LipSync"] = var_40_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_40_3 = arg_37_1.actors_["10066ui_story"].transform

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1.var_.moveOldPos10066ui_story = var_40_3.localPosition
			end

			local var_40_4 = 0.001

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_4 then
				var_40_3.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos10066ui_story, Vector3.New(0, -0.99, -5.83), (arg_37_1.time_ - 0) / var_40_4)
				var_40_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_40_3.position).x, (manager.ui.mainCamera.transform.position - var_40_3.position).y, (manager.ui.mainCamera.transform.position - var_40_3.position).z)
				var_40_3.localEulerAngles.z = 0
				var_40_3.localEulerAngles.x = 0
				var_40_3.localEulerAngles = var_40_3.localEulerAngles
			end

			if arg_37_1.time_ >= 0 + var_40_4 and arg_37_1.time_ < 0 + var_40_4 + arg_40_0 then
				var_40_3.localPosition = Vector3.New(0, -0.99, -5.83)
				var_40_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_40_3.position).x, (manager.ui.mainCamera.transform.position - var_40_3.position).y, (manager.ui.mainCamera.transform.position - var_40_3.position).z)
				var_40_3.localEulerAngles.z = 0
				var_40_3.localEulerAngles.x = 0
				var_40_3.localEulerAngles = var_40_3.localEulerAngles
			end

			local var_40_5 = arg_37_1.actors_["10066ui_story"]

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(var_40_5) and arg_37_1.var_.characterEffect10066ui_story == nil then
				arg_37_1.var_.characterEffect10066ui_story = var_40_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_6 = 0.200000002980232

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_6 and not isNil(var_40_5) then
				if arg_37_1.var_.characterEffect10066ui_story and not isNil(var_40_5) then
					arg_37_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_37_1.time_ >= 0 + var_40_6 and arg_37_1.time_ < 0 + var_40_6 + arg_40_0 and not isNil(var_40_5) and arg_37_1.var_.characterEffect10066ui_story then
				arg_37_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action3_1")
			end

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_40_8 = 0
			local var_40_9 = 0.125

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_8 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				arg_37_1.leftNameTxt_.text = arg_37_1:FormatText(StoryNameCfg[640].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_10 = arg_37_1:GetWordFromCfg(319741009)
				local var_40_11 = arg_37_1:FormatText(var_40_10.content)

				arg_37_1.text_.text = var_40_11

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_13 = 5 <= 0 and var_40_9 or var_40_9 * (utf8.len(var_40_11) / 5)

				if (5 <= 0 and var_40_9 or var_40_9 * (utf8.len(var_40_11) / 5)) > 0 and var_40_9 < var_40_13 then
					arg_37_1.talkMaxDuration = var_40_13

					if var_40_13 + var_40_8 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_13 + var_40_8
					end
				end

				arg_37_1.text_.text = var_40_11
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319741", "319741009", "story_v_out_319741.awb") ~= 0 then
					local var_40_14 = manager.audio:GetVoiceLength("story_v_out_319741", "319741009", "story_v_out_319741.awb") / 1000

					if var_40_14 + var_40_8 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_14 + var_40_8
					end

					if var_40_10.prefab_name ~= "" and arg_37_1.actors_[var_40_10.prefab_name] ~= nil then
						local var_40_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_10.prefab_name].transform, "story_v_out_319741", "319741009", "story_v_out_319741.awb")

						arg_37_1:RecordAudio("319741009", var_40_15)
						arg_37_1:RecordAudio("319741009", var_40_15)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_319741", "319741009", "story_v_out_319741.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_319741", "319741009", "story_v_out_319741.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_16 = math.max(var_40_9, arg_37_1.talkMaxDuration)

			if var_40_8 <= arg_37_1.time_ and arg_37_1.time_ < var_40_8 + var_40_16 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_8) / var_40_16

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_8 + var_40_16 and arg_37_1.time_ < var_40_8 + var_40_16 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10066ui_story",
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
	Play319741010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 319741010
		arg_41_1.duration_ = 6.33

		local var_41_0 = {
			zh = 3.3,
			ja = 6.333
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
				arg_41_0:Play319741011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(arg_41_1.actors_["10079ui_story"]) and arg_41_1.var_.characterEffect10079ui_story == nil then
				arg_41_1.var_.characterEffect10079ui_story = arg_41_1.actors_["10079ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_0 = 0.200000002980232

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_0 and not isNil(arg_41_1.actors_["10079ui_story"]) then
				if arg_41_1.var_.characterEffect10079ui_story and not isNil(arg_41_1.actors_["10079ui_story"]) then
					arg_41_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_41_1.time_ >= 0 + var_44_0 and arg_41_1.time_ < 0 + var_44_0 + arg_44_0 and not isNil(arg_41_1.actors_["10079ui_story"]) and arg_41_1.var_.characterEffect10079ui_story then
				arg_41_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action12_2")
			end

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_44_2 = arg_41_1.actors_["10066ui_story"]

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(var_44_2) and arg_41_1.var_.characterEffect10066ui_story == nil then
				arg_41_1.var_.characterEffect10066ui_story = var_44_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_3 = 0.200000002980232

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_3 and not isNil(var_44_2) then
				if arg_41_1.var_.characterEffect10066ui_story and not isNil(var_44_2) then
					arg_41_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_41_1.var_.characterEffect10066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_41_1.time_ - 0) / var_44_3)
				end
			end

			if arg_41_1.time_ >= 0 + var_44_3 and arg_41_1.time_ < 0 + var_44_3 + arg_44_0 and not isNil(var_44_2) and arg_41_1.var_.characterEffect10066ui_story then
				arg_41_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_41_1.var_.characterEffect10066ui_story.fillRatio = 0.5
			end

			local var_44_4 = arg_41_1.actors_["10079ui_story"].transform

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.var_.moveOldPos10079ui_story = var_44_4.localPosition
			end

			local var_44_5 = 0.001

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_5 then
				var_44_4.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos10079ui_story, Vector3.New(-0.7, -0.95, -6.05), (arg_41_1.time_ - 0) / var_44_5)
				var_44_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_44_4.position).x, (manager.ui.mainCamera.transform.position - var_44_4.position).y, (manager.ui.mainCamera.transform.position - var_44_4.position).z)
				var_44_4.localEulerAngles.z = 0
				var_44_4.localEulerAngles.x = 0
				var_44_4.localEulerAngles = var_44_4.localEulerAngles
			end

			if arg_41_1.time_ >= 0 + var_44_5 and arg_41_1.time_ < 0 + var_44_5 + arg_44_0 then
				var_44_4.localPosition = Vector3.New(-0.7, -0.95, -6.05)
				var_44_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_44_4.position).x, (manager.ui.mainCamera.transform.position - var_44_4.position).y, (manager.ui.mainCamera.transform.position - var_44_4.position).z)
				var_44_4.localEulerAngles.z = 0
				var_44_4.localEulerAngles.x = 0
				var_44_4.localEulerAngles = var_44_4.localEulerAngles
			end

			local var_44_6 = arg_41_1.actors_["10066ui_story"].transform

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.var_.moveOldPos10066ui_story = var_44_6.localPosition
			end

			local var_44_7 = 0.001

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_7 then
				var_44_6.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos10066ui_story, Vector3.New(0.7, -0.99, -5.83), (arg_41_1.time_ - 0) / var_44_7)
				var_44_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_44_6.position).x, (manager.ui.mainCamera.transform.position - var_44_6.position).y, (manager.ui.mainCamera.transform.position - var_44_6.position).z)
				var_44_6.localEulerAngles.z = 0
				var_44_6.localEulerAngles.x = 0
				var_44_6.localEulerAngles = var_44_6.localEulerAngles
			end

			if arg_41_1.time_ >= 0 + var_44_7 and arg_41_1.time_ < 0 + var_44_7 + arg_44_0 then
				var_44_6.localPosition = Vector3.New(0.7, -0.99, -5.83)
				var_44_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_44_6.position).x, (manager.ui.mainCamera.transform.position - var_44_6.position).y, (manager.ui.mainCamera.transform.position - var_44_6.position).z)
				var_44_6.localEulerAngles.z = 0
				var_44_6.localEulerAngles.x = 0
				var_44_6.localEulerAngles = var_44_6.localEulerAngles
			end

			local var_44_8 = 0
			local var_44_9 = 0.425

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_8 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				arg_41_1.leftNameTxt_.text = arg_41_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_10 = arg_41_1:GetWordFromCfg(319741010)
				local var_44_11 = arg_41_1:FormatText(var_44_10.content)

				arg_41_1.text_.text = var_44_11

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_13 = 17 <= 0 and var_44_9 or var_44_9 * (utf8.len(var_44_11) / 17)

				if (17 <= 0 and var_44_9 or var_44_9 * (utf8.len(var_44_11) / 17)) > 0 and var_44_9 < var_44_13 then
					arg_41_1.talkMaxDuration = var_44_13

					if var_44_13 + var_44_8 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_13 + var_44_8
					end
				end

				arg_41_1.text_.text = var_44_11
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319741", "319741010", "story_v_out_319741.awb") ~= 0 then
					local var_44_14 = manager.audio:GetVoiceLength("story_v_out_319741", "319741010", "story_v_out_319741.awb") / 1000

					if var_44_14 + var_44_8 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_14 + var_44_8
					end

					if var_44_10.prefab_name ~= "" and arg_41_1.actors_[var_44_10.prefab_name] ~= nil then
						local var_44_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_10.prefab_name].transform, "story_v_out_319741", "319741010", "story_v_out_319741.awb")

						arg_41_1:RecordAudio("319741010", var_44_15)
						arg_41_1:RecordAudio("319741010", var_44_15)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_319741", "319741010", "story_v_out_319741.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_319741", "319741010", "story_v_out_319741.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_16 = math.max(var_44_9, arg_41_1.talkMaxDuration)

			if var_44_8 <= arg_41_1.time_ and arg_41_1.time_ < var_44_8 + var_44_16 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_8) / var_44_16

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_8 + var_44_16 and arg_41_1.time_ < var_44_8 + var_44_16 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {
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
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_41_1:InitPlayNodeList()
	end,
	Play319741011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 319741011
		arg_45_1.duration_ = 7.6

		local var_45_0 = {
			zh = 7.6,
			ja = 7.233
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
				arg_45_0:Play319741012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			if arg_45_1.actors_["4040ui_story"] == nil and not isNil((Asset.Load("Char/" .. "4040ui_story"))) then
				local var_48_0 = Object.Instantiate(Asset.Load("Char/" .. "4040ui_story"), arg_45_1.stage_.transform)

				var_48_0.name = "4040ui_story"
				var_48_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_45_1.actors_["4040ui_story"] = var_48_0

				local var_48_1 = var_48_0:GetComponentInChildren(typeof(CharacterEffect))

				var_48_1.enabled = true

				local var_48_2 = GameObjectTools.GetOrAddComponent(var_48_0, typeof(DynamicBoneHelper))

				if var_48_2 then
					var_48_2:EnableDynamicBone(false)
				end

				arg_45_1:ShowWeapon(var_48_1.transform, false)

				arg_45_1.var_["4040ui_story" .. "Animator"] = var_48_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_45_1.var_["4040ui_story" .. "Animator"].applyRootMotion = true
				arg_45_1.var_["4040ui_story" .. "LipSync"] = var_48_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_48_3 = arg_45_1.actors_["4040ui_story"].transform

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1.var_.moveOldPos4040ui_story = var_48_3.localPosition
			end

			local var_48_4 = 0.001

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_4 then
				var_48_3.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos4040ui_story, Vector3.New(0, -1.55, -5.5), (arg_45_1.time_ - 0) / var_48_4)
				var_48_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_48_3.position).x, (manager.ui.mainCamera.transform.position - var_48_3.position).y, (manager.ui.mainCamera.transform.position - var_48_3.position).z)
				var_48_3.localEulerAngles.z = 0
				var_48_3.localEulerAngles.x = 0
				var_48_3.localEulerAngles = var_48_3.localEulerAngles
			end

			if arg_45_1.time_ >= 0 + var_48_4 and arg_45_1.time_ < 0 + var_48_4 + arg_48_0 then
				var_48_3.localPosition = Vector3.New(0, -1.55, -5.5)
				var_48_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_48_3.position).x, (manager.ui.mainCamera.transform.position - var_48_3.position).y, (manager.ui.mainCamera.transform.position - var_48_3.position).z)
				var_48_3.localEulerAngles.z = 0
				var_48_3.localEulerAngles.x = 0
				var_48_3.localEulerAngles = var_48_3.localEulerAngles
			end

			local var_48_5 = arg_45_1.actors_["4040ui_story"]

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 and not isNil(var_48_5) and arg_45_1.var_.characterEffect4040ui_story == nil then
				arg_45_1.var_.characterEffect4040ui_story = var_48_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_6 = 0.200000002980232

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_6 and not isNil(var_48_5) then
				if arg_45_1.var_.characterEffect4040ui_story and not isNil(var_48_5) then
					arg_45_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_45_1.time_ >= 0 + var_48_6 and arg_45_1.time_ < 0 + var_48_6 + arg_48_0 and not isNil(var_48_5) and arg_45_1.var_.characterEffect4040ui_story then
				arg_45_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action2_1")
			end

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_48_8 = arg_45_1.actors_["10066ui_story"].transform

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1.var_.moveOldPos10066ui_story = var_48_8.localPosition
			end

			local var_48_9 = 0.001

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_9 then
				var_48_8.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos10066ui_story, Vector3.New(0, 100, 0), (arg_45_1.time_ - 0) / var_48_9)
				var_48_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_48_8.position).x, (manager.ui.mainCamera.transform.position - var_48_8.position).y, (manager.ui.mainCamera.transform.position - var_48_8.position).z)
				var_48_8.localEulerAngles.z = 0
				var_48_8.localEulerAngles.x = 0
				var_48_8.localEulerAngles = var_48_8.localEulerAngles
			end

			if arg_45_1.time_ >= 0 + var_48_9 and arg_45_1.time_ < 0 + var_48_9 + arg_48_0 then
				var_48_8.localPosition = Vector3.New(0, 100, 0)
				var_48_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_48_8.position).x, (manager.ui.mainCamera.transform.position - var_48_8.position).y, (manager.ui.mainCamera.transform.position - var_48_8.position).z)
				var_48_8.localEulerAngles.z = 0
				var_48_8.localEulerAngles.x = 0
				var_48_8.localEulerAngles = var_48_8.localEulerAngles
			end

			local var_48_10 = arg_45_1.actors_["10066ui_story"]

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 and not isNil(var_48_10) and arg_45_1.var_.characterEffect10066ui_story == nil then
				arg_45_1.var_.characterEffect10066ui_story = var_48_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_11 = 0.200000002980232

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_11 and not isNil(var_48_10) then
				if arg_45_1.var_.characterEffect10066ui_story and not isNil(var_48_10) then
					arg_45_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_45_1.var_.characterEffect10066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_45_1.time_ - 0) / var_48_11)
				end
			end

			if arg_45_1.time_ >= 0 + var_48_11 and arg_45_1.time_ < 0 + var_48_11 + arg_48_0 and not isNil(var_48_10) and arg_45_1.var_.characterEffect10066ui_story then
				arg_45_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_45_1.var_.characterEffect10066ui_story.fillRatio = 0.5
			end

			local var_48_12 = arg_45_1.actors_["10079ui_story"].transform

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1.var_.moveOldPos10079ui_story = var_48_12.localPosition
			end

			local var_48_13 = 0.001

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_13 then
				var_48_12.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos10079ui_story, Vector3.New(0, 100, 0), (arg_45_1.time_ - 0) / var_48_13)
				var_48_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_48_12.position).x, (manager.ui.mainCamera.transform.position - var_48_12.position).y, (manager.ui.mainCamera.transform.position - var_48_12.position).z)
				var_48_12.localEulerAngles.z = 0
				var_48_12.localEulerAngles.x = 0
				var_48_12.localEulerAngles = var_48_12.localEulerAngles
			end

			if arg_45_1.time_ >= 0 + var_48_13 and arg_45_1.time_ < 0 + var_48_13 + arg_48_0 then
				var_48_12.localPosition = Vector3.New(0, 100, 0)
				var_48_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_48_12.position).x, (manager.ui.mainCamera.transform.position - var_48_12.position).y, (manager.ui.mainCamera.transform.position - var_48_12.position).z)
				var_48_12.localEulerAngles.z = 0
				var_48_12.localEulerAngles.x = 0
				var_48_12.localEulerAngles = var_48_12.localEulerAngles
			end

			local var_48_14 = arg_45_1.actors_["10079ui_story"]

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 and not isNil(var_48_14) and arg_45_1.var_.characterEffect10079ui_story == nil then
				arg_45_1.var_.characterEffect10079ui_story = var_48_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_15 = 0.200000002980232

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_15 and not isNil(var_48_14) then
				if arg_45_1.var_.characterEffect10079ui_story and not isNil(var_48_14) then
					arg_45_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_45_1.var_.characterEffect10079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_45_1.time_ - 0) / var_48_15)
				end
			end

			if arg_45_1.time_ >= 0 + var_48_15 and arg_45_1.time_ < 0 + var_48_15 + arg_48_0 and not isNil(var_48_14) and arg_45_1.var_.characterEffect10079ui_story then
				arg_45_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_45_1.var_.characterEffect10079ui_story.fillRatio = 0.5
			end

			local var_48_16 = 0
			local var_48_17 = 0.85

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_16 + arg_48_0 then
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

				local var_48_18 = arg_45_1:GetWordFromCfg(319741011)
				local var_48_19 = arg_45_1:FormatText(var_48_18.content)

				arg_45_1.text_.text = var_48_19

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_21 = 34 <= 0 and var_48_17 or var_48_17 * (utf8.len(var_48_19) / 34)

				if (34 <= 0 and var_48_17 or var_48_17 * (utf8.len(var_48_19) / 34)) > 0 and var_48_17 < var_48_21 then
					arg_45_1.talkMaxDuration = var_48_21

					if var_48_21 + var_48_16 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_21 + var_48_16
					end
				end

				arg_45_1.text_.text = var_48_19
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319741", "319741011", "story_v_out_319741.awb") ~= 0 then
					local var_48_22 = manager.audio:GetVoiceLength("story_v_out_319741", "319741011", "story_v_out_319741.awb") / 1000

					if var_48_22 + var_48_16 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_22 + var_48_16
					end

					if var_48_18.prefab_name ~= "" and arg_45_1.actors_[var_48_18.prefab_name] ~= nil then
						local var_48_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_18.prefab_name].transform, "story_v_out_319741", "319741011", "story_v_out_319741.awb")

						arg_45_1:RecordAudio("319741011", var_48_23)
						arg_45_1:RecordAudio("319741011", var_48_23)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_319741", "319741011", "story_v_out_319741.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_319741", "319741011", "story_v_out_319741.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_24 = math.max(var_48_17, arg_45_1.talkMaxDuration)

			if var_48_16 <= arg_45_1.time_ and arg_45_1.time_ < var_48_16 + var_48_24 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_16) / var_48_24

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_16 + var_48_24 and arg_45_1.time_ < var_48_16 + var_48_24 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {
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
				actorName = "10066ui_story",
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

		arg_45_1:InitPlayNodeList()
	end,
	Play319741012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 319741012
		arg_49_1.duration_ = 7.4

		local var_49_0 = {
			zh = 7.4,
			ja = 5.5
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
				arg_49_0:Play319741013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = 0.825

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
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

				local var_52_1 = arg_49_1:GetWordFromCfg(319741012)
				local var_52_2 = arg_49_1:FormatText(var_52_1.content)

				arg_49_1.text_.text = var_52_2

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_4 = 33 <= 0 and var_52_0 or var_52_0 * (utf8.len(var_52_2) / 33)

				if (33 <= 0 and var_52_0 or var_52_0 * (utf8.len(var_52_2) / 33)) > 0 and var_52_0 < var_52_4 then
					arg_49_1.talkMaxDuration = var_52_4

					if var_52_4 + 0 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_4 + 0
					end
				end

				arg_49_1.text_.text = var_52_2
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319741", "319741012", "story_v_out_319741.awb") ~= 0 then
					local var_52_5 = manager.audio:GetVoiceLength("story_v_out_319741", "319741012", "story_v_out_319741.awb") / 1000

					if var_52_5 + 0 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_5 + 0
					end

					if var_52_1.prefab_name ~= "" and arg_49_1.actors_[var_52_1.prefab_name] ~= nil then
						local var_52_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_1.prefab_name].transform, "story_v_out_319741", "319741012", "story_v_out_319741.awb")

						arg_49_1:RecordAudio("319741012", var_52_6)
						arg_49_1:RecordAudio("319741012", var_52_6)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_319741", "319741012", "story_v_out_319741.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_319741", "319741012", "story_v_out_319741.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_7 = math.max(var_52_0, arg_49_1.talkMaxDuration)

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_7 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - 0) / var_52_7

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= 0 + var_52_7 and arg_49_1.time_ < 0 + var_52_7 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play319741013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 319741013
		arg_53_1.duration_ = 14.67

		local var_53_0 = {
			zh = 7.166,
			ja = 14.666
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
				arg_53_0:Play319741014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1.var_.moveOldPos10079ui_story = arg_53_1.actors_["10079ui_story"].transform.localPosition
			end

			local var_56_0 = 0.001

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_0 then
				arg_53_1.actors_["10079ui_story"].transform.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos10079ui_story, Vector3.New(0, -0.95, -6.05), (arg_53_1.time_ - 0) / var_56_0)
				arg_53_1.actors_["10079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_53_1.actors_["10079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["10079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["10079ui_story"].transform.position).z)
				arg_53_1.actors_["10079ui_story"].transform.localEulerAngles.z = 0
				arg_53_1.actors_["10079ui_story"].transform.localEulerAngles.x = 0
				arg_53_1.actors_["10079ui_story"].transform.localEulerAngles = arg_53_1.actors_["10079ui_story"].transform.localEulerAngles
			end

			if arg_53_1.time_ >= 0 + var_56_0 and arg_53_1.time_ < 0 + var_56_0 + arg_56_0 then
				arg_53_1.actors_["10079ui_story"].transform.localPosition = Vector3.New(0, -0.95, -6.05)
				arg_53_1.actors_["10079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_53_1.actors_["10079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["10079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["10079ui_story"].transform.position).z)
				arg_53_1.actors_["10079ui_story"].transform.localEulerAngles.z = 0
				arg_53_1.actors_["10079ui_story"].transform.localEulerAngles.x = 0
				arg_53_1.actors_["10079ui_story"].transform.localEulerAngles = arg_53_1.actors_["10079ui_story"].transform.localEulerAngles
			end

			local var_56_1 = arg_53_1.actors_["10079ui_story"]

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 and not isNil(var_56_1) and arg_53_1.var_.characterEffect10079ui_story == nil then
				arg_53_1.var_.characterEffect10079ui_story = var_56_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_2 = 0.200000002980232

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_2 and not isNil(var_56_1) then
				if arg_53_1.var_.characterEffect10079ui_story and not isNil(var_56_1) then
					arg_53_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_53_1.time_ >= 0 + var_56_2 and arg_53_1.time_ < 0 + var_56_2 + arg_56_0 and not isNil(var_56_1) and arg_53_1.var_.characterEffect10079ui_story then
				arg_53_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_56_4 = arg_53_1.actors_["4040ui_story"].transform

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1.var_.moveOldPos4040ui_story = var_56_4.localPosition
			end

			local var_56_5 = 0.001

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_5 then
				var_56_4.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos4040ui_story, Vector3.New(0, 100, 0), (arg_53_1.time_ - 0) / var_56_5)
				var_56_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_56_4.position).x, (manager.ui.mainCamera.transform.position - var_56_4.position).y, (manager.ui.mainCamera.transform.position - var_56_4.position).z)
				var_56_4.localEulerAngles.z = 0
				var_56_4.localEulerAngles.x = 0
				var_56_4.localEulerAngles = var_56_4.localEulerAngles
			end

			if arg_53_1.time_ >= 0 + var_56_5 and arg_53_1.time_ < 0 + var_56_5 + arg_56_0 then
				var_56_4.localPosition = Vector3.New(0, 100, 0)
				var_56_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_56_4.position).x, (manager.ui.mainCamera.transform.position - var_56_4.position).y, (manager.ui.mainCamera.transform.position - var_56_4.position).z)
				var_56_4.localEulerAngles.z = 0
				var_56_4.localEulerAngles.x = 0
				var_56_4.localEulerAngles = var_56_4.localEulerAngles
			end

			local var_56_6 = arg_53_1.actors_["4040ui_story"]

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 and not isNil(var_56_6) and arg_53_1.var_.characterEffect4040ui_story == nil then
				arg_53_1.var_.characterEffect4040ui_story = var_56_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_7 = 0.200000002980232

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_7 and not isNil(var_56_6) then
				if arg_53_1.var_.characterEffect4040ui_story and not isNil(var_56_6) then
					arg_53_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_53_1.var_.characterEffect4040ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_53_1.time_ - 0) / var_56_7)
				end
			end

			if arg_53_1.time_ >= 0 + var_56_7 and arg_53_1.time_ < 0 + var_56_7 + arg_56_0 and not isNil(var_56_6) and arg_53_1.var_.characterEffect4040ui_story then
				arg_53_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_53_1.var_.characterEffect4040ui_story.fillRatio = 0.5
			end

			local var_56_8 = 0
			local var_56_9 = 0.975

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_8 + arg_56_0 then
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

				local var_56_10 = arg_53_1:GetWordFromCfg(319741013)
				local var_56_11 = arg_53_1:FormatText(var_56_10.content)

				arg_53_1.text_.text = var_56_11

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_13 = 39 <= 0 and var_56_9 or var_56_9 * (utf8.len(var_56_11) / 39)

				if (39 <= 0 and var_56_9 or var_56_9 * (utf8.len(var_56_11) / 39)) > 0 and var_56_9 < var_56_13 then
					arg_53_1.talkMaxDuration = var_56_13

					if var_56_13 + var_56_8 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_13 + var_56_8
					end
				end

				arg_53_1.text_.text = var_56_11
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319741", "319741013", "story_v_out_319741.awb") ~= 0 then
					local var_56_14 = manager.audio:GetVoiceLength("story_v_out_319741", "319741013", "story_v_out_319741.awb") / 1000

					if var_56_14 + var_56_8 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_14 + var_56_8
					end

					if var_56_10.prefab_name ~= "" and arg_53_1.actors_[var_56_10.prefab_name] ~= nil then
						local var_56_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_10.prefab_name].transform, "story_v_out_319741", "319741013", "story_v_out_319741.awb")

						arg_53_1:RecordAudio("319741013", var_56_15)
						arg_53_1:RecordAudio("319741013", var_56_15)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_319741", "319741013", "story_v_out_319741.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_319741", "319741013", "story_v_out_319741.awb")
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

		arg_53_1:InitPlayNodeList()
	end,
	Play319741014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 319741014
		arg_57_1.duration_ = 5.23

		local var_57_0 = {
			zh = 5.233,
			ja = 4.333
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
				arg_57_0:Play319741015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1.var_.moveOldPos10066ui_story = arg_57_1.actors_["10066ui_story"].transform.localPosition
			end

			local var_60_0 = 0.001

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_0 then
				arg_57_1.actors_["10066ui_story"].transform.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos10066ui_story, Vector3.New(0.7, -0.99, -5.83), (arg_57_1.time_ - 0) / var_60_0)
				arg_57_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_57_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["10066ui_story"].transform.position).z)
				arg_57_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_57_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_57_1.actors_["10066ui_story"].transform.localEulerAngles = arg_57_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			if arg_57_1.time_ >= 0 + var_60_0 and arg_57_1.time_ < 0 + var_60_0 + arg_60_0 then
				arg_57_1.actors_["10066ui_story"].transform.localPosition = Vector3.New(0.7, -0.99, -5.83)
				arg_57_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_57_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["10066ui_story"].transform.position).z)
				arg_57_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_57_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_57_1.actors_["10066ui_story"].transform.localEulerAngles = arg_57_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			local var_60_1 = arg_57_1.actors_["10066ui_story"]

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 and not isNil(var_60_1) and arg_57_1.var_.characterEffect10066ui_story == nil then
				arg_57_1.var_.characterEffect10066ui_story = var_60_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_2 = 0.200000002980232

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_2 and not isNil(var_60_1) then
				if arg_57_1.var_.characterEffect10066ui_story and not isNil(var_60_1) then
					arg_57_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_57_1.time_ >= 0 + var_60_2 and arg_57_1.time_ < 0 + var_60_2 + arg_60_0 and not isNil(var_60_1) and arg_57_1.var_.characterEffect10066ui_story then
				arg_57_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action3_2")
			end

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_60_4 = arg_57_1.actors_["10079ui_story"].transform

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1.var_.moveOldPos10079ui_story = var_60_4.localPosition
			end

			local var_60_5 = 0.001

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_5 then
				var_60_4.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos10079ui_story, Vector3.New(-0.7, -0.95, -6.05), (arg_57_1.time_ - 0) / var_60_5)
				var_60_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_60_4.position).x, (manager.ui.mainCamera.transform.position - var_60_4.position).y, (manager.ui.mainCamera.transform.position - var_60_4.position).z)
				var_60_4.localEulerAngles.z = 0
				var_60_4.localEulerAngles.x = 0
				var_60_4.localEulerAngles = var_60_4.localEulerAngles
			end

			if arg_57_1.time_ >= 0 + var_60_5 and arg_57_1.time_ < 0 + var_60_5 + arg_60_0 then
				var_60_4.localPosition = Vector3.New(-0.7, -0.95, -6.05)
				var_60_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_60_4.position).x, (manager.ui.mainCamera.transform.position - var_60_4.position).y, (manager.ui.mainCamera.transform.position - var_60_4.position).z)
				var_60_4.localEulerAngles.z = 0
				var_60_4.localEulerAngles.x = 0
				var_60_4.localEulerAngles = var_60_4.localEulerAngles
			end

			local var_60_6 = arg_57_1.actors_["10079ui_story"]

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 and not isNil(var_60_6) and arg_57_1.var_.characterEffect10079ui_story == nil then
				arg_57_1.var_.characterEffect10079ui_story = var_60_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_7 = 0.200000002980232

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_7 and not isNil(var_60_6) then
				if arg_57_1.var_.characterEffect10079ui_story and not isNil(var_60_6) then
					arg_57_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_57_1.var_.characterEffect10079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_57_1.time_ - 0) / var_60_7)
				end
			end

			if arg_57_1.time_ >= 0 + var_60_7 and arg_57_1.time_ < 0 + var_60_7 + arg_60_0 and not isNil(var_60_6) and arg_57_1.var_.characterEffect10079ui_story then
				arg_57_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_57_1.var_.characterEffect10079ui_story.fillRatio = 0.5
			end

			local var_60_8 = 0
			local var_60_9 = 0.5

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_8 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				arg_57_1.leftNameTxt_.text = arg_57_1:FormatText(StoryNameCfg[640].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_10 = arg_57_1:GetWordFromCfg(319741014)
				local var_60_11 = arg_57_1:FormatText(var_60_10.content)

				arg_57_1.text_.text = var_60_11

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_13 = 20 <= 0 and var_60_9 or var_60_9 * (utf8.len(var_60_11) / 20)

				if (20 <= 0 and var_60_9 or var_60_9 * (utf8.len(var_60_11) / 20)) > 0 and var_60_9 < var_60_13 then
					arg_57_1.talkMaxDuration = var_60_13

					if var_60_13 + var_60_8 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_13 + var_60_8
					end
				end

				arg_57_1.text_.text = var_60_11
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319741", "319741014", "story_v_out_319741.awb") ~= 0 then
					local var_60_14 = manager.audio:GetVoiceLength("story_v_out_319741", "319741014", "story_v_out_319741.awb") / 1000

					if var_60_14 + var_60_8 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_14 + var_60_8
					end

					if var_60_10.prefab_name ~= "" and arg_57_1.actors_[var_60_10.prefab_name] ~= nil then
						local var_60_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_10.prefab_name].transform, "story_v_out_319741", "319741014", "story_v_out_319741.awb")

						arg_57_1:RecordAudio("319741014", var_60_15)
						arg_57_1:RecordAudio("319741014", var_60_15)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_319741", "319741014", "story_v_out_319741.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_319741", "319741014", "story_v_out_319741.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_16 = math.max(var_60_9, arg_57_1.talkMaxDuration)

			if var_60_8 <= arg_57_1.time_ and arg_57_1.time_ < var_60_8 + var_60_16 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_8) / var_60_16

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_8 + var_60_16 and arg_57_1.time_ < var_60_8 + var_60_16 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10066ui_story",
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

		arg_57_1:InitPlayNodeList()
	end,
	Play319741015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 319741015
		arg_61_1.duration_ = 4.03

		local var_61_0 = {
			zh = 3.366,
			ja = 4.033
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
				arg_61_0:Play319741016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 and not isNil(arg_61_1.actors_["10066ui_story"]) and arg_61_1.var_.characterEffect10066ui_story == nil then
				arg_61_1.var_.characterEffect10066ui_story = arg_61_1.actors_["10066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_0 = 0.200000002980232

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_0 and not isNil(arg_61_1.actors_["10066ui_story"]) then
				if arg_61_1.var_.characterEffect10066ui_story and not isNil(arg_61_1.actors_["10066ui_story"]) then
					arg_61_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_61_1.var_.characterEffect10066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_61_1.time_ - 0) / var_64_0)
				end
			end

			if arg_61_1.time_ >= 0 + var_64_0 and arg_61_1.time_ < 0 + var_64_0 + arg_64_0 and not isNil(arg_61_1.actors_["10066ui_story"]) and arg_61_1.var_.characterEffect10066ui_story then
				arg_61_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_61_1.var_.characterEffect10066ui_story.fillRatio = 0.5
			end

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action7_1")
			end

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_64_1 = arg_61_1.actors_["10079ui_story"]

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 and not isNil(var_64_1) and arg_61_1.var_.characterEffect10079ui_story == nil then
				arg_61_1.var_.characterEffect10079ui_story = var_64_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_2 = 0.200000002980232

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_2 and not isNil(var_64_1) then
				if arg_61_1.var_.characterEffect10079ui_story and not isNil(var_64_1) then
					arg_61_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_61_1.time_ >= 0 + var_64_2 and arg_61_1.time_ < 0 + var_64_2 + arg_64_0 and not isNil(var_64_1) and arg_61_1.var_.characterEffect10079ui_story then
				arg_61_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			local var_64_4 = 0
			local var_64_5 = 0.45

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_4 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				arg_61_1.leftNameTxt_.text = arg_61_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_6 = arg_61_1:GetWordFromCfg(319741015)
				local var_64_7 = arg_61_1:FormatText(var_64_6.content)

				arg_61_1.text_.text = var_64_7

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_9 = 18 <= 0 and var_64_5 or var_64_5 * (utf8.len(var_64_7) / 18)

				if (18 <= 0 and var_64_5 or var_64_5 * (utf8.len(var_64_7) / 18)) > 0 and var_64_5 < var_64_9 then
					arg_61_1.talkMaxDuration = var_64_9

					if var_64_9 + var_64_4 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_9 + var_64_4
					end
				end

				arg_61_1.text_.text = var_64_7
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319741", "319741015", "story_v_out_319741.awb") ~= 0 then
					local var_64_10 = manager.audio:GetVoiceLength("story_v_out_319741", "319741015", "story_v_out_319741.awb") / 1000

					if var_64_10 + var_64_4 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_10 + var_64_4
					end

					if var_64_6.prefab_name ~= "" and arg_61_1.actors_[var_64_6.prefab_name] ~= nil then
						local var_64_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_6.prefab_name].transform, "story_v_out_319741", "319741015", "story_v_out_319741.awb")

						arg_61_1:RecordAudio("319741015", var_64_11)
						arg_61_1:RecordAudio("319741015", var_64_11)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_319741", "319741015", "story_v_out_319741.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_319741", "319741015", "story_v_out_319741.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_12 = math.max(var_64_5, arg_61_1.talkMaxDuration)

			if var_64_4 <= arg_61_1.time_ and arg_61_1.time_ < var_64_4 + var_64_12 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_4) / var_64_12

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_4 + var_64_12 and arg_61_1.time_ < var_64_4 + var_64_12 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play319741016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 319741016
		arg_65_1.duration_ = 6.1

		local var_65_0 = {
			zh = 2.3,
			ja = 6.1
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
				arg_65_0:Play319741017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_68_0 = arg_65_1.actors_["10066ui_story"]

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(var_68_0) and arg_65_1.var_.characterEffect10066ui_story == nil then
				arg_65_1.var_.characterEffect10066ui_story = var_68_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_1 = 0.200000002980232

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_1 and not isNil(var_68_0) then
				if arg_65_1.var_.characterEffect10066ui_story and not isNil(var_68_0) then
					arg_65_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_65_1.time_ >= 0 + var_68_1 and arg_65_1.time_ < 0 + var_68_1 + arg_68_0 and not isNil(var_68_0) and arg_65_1.var_.characterEffect10066ui_story then
				arg_65_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			local var_68_3 = arg_65_1.actors_["10079ui_story"]

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(var_68_3) and arg_65_1.var_.characterEffect10079ui_story == nil then
				arg_65_1.var_.characterEffect10079ui_story = var_68_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_4 = 0.200000002980232

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_4 and not isNil(var_68_3) then
				if arg_65_1.var_.characterEffect10079ui_story and not isNil(var_68_3) then
					arg_65_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_65_1.var_.characterEffect10079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_65_1.time_ - 0) / var_68_4)
				end
			end

			if arg_65_1.time_ >= 0 + var_68_4 and arg_65_1.time_ < 0 + var_68_4 + arg_68_0 and not isNil(var_68_3) and arg_65_1.var_.characterEffect10079ui_story then
				arg_65_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_65_1.var_.characterEffect10079ui_story.fillRatio = 0.5
			end

			local var_68_5 = 0
			local var_68_6 = 0.275

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_5 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				arg_65_1.leftNameTxt_.text = arg_65_1:FormatText(StoryNameCfg[640].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_7 = arg_65_1:GetWordFromCfg(319741016)
				local var_68_8 = arg_65_1:FormatText(var_68_7.content)

				arg_65_1.text_.text = var_68_8

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_10 = 11 <= 0 and var_68_6 or var_68_6 * (utf8.len(var_68_8) / 11)

				if (11 <= 0 and var_68_6 or var_68_6 * (utf8.len(var_68_8) / 11)) > 0 and var_68_6 < var_68_10 then
					arg_65_1.talkMaxDuration = var_68_10

					if var_68_10 + var_68_5 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_10 + var_68_5
					end
				end

				arg_65_1.text_.text = var_68_8
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319741", "319741016", "story_v_out_319741.awb") ~= 0 then
					local var_68_11 = manager.audio:GetVoiceLength("story_v_out_319741", "319741016", "story_v_out_319741.awb") / 1000

					if var_68_11 + var_68_5 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_11 + var_68_5
					end

					if var_68_7.prefab_name ~= "" and arg_65_1.actors_[var_68_7.prefab_name] ~= nil then
						local var_68_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_7.prefab_name].transform, "story_v_out_319741", "319741016", "story_v_out_319741.awb")

						arg_65_1:RecordAudio("319741016", var_68_12)
						arg_65_1:RecordAudio("319741016", var_68_12)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_319741", "319741016", "story_v_out_319741.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_319741", "319741016", "story_v_out_319741.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_13 = math.max(var_68_6, arg_65_1.talkMaxDuration)

			if var_68_5 <= arg_65_1.time_ and arg_65_1.time_ < var_68_5 + var_68_13 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_5) / var_68_13

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_5 + var_68_13 and arg_65_1.time_ < var_68_5 + var_68_13 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play319741017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 319741017
		arg_69_1.duration_ = 3.3

		local var_69_0 = {
			zh = 2.9,
			ja = 3.3
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
				arg_69_0:Play319741018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1.var_.moveOldPos4040ui_story = arg_69_1.actors_["4040ui_story"].transform.localPosition
			end

			local var_72_0 = 0.001

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_0 then
				arg_69_1.actors_["4040ui_story"].transform.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos4040ui_story, Vector3.New(0, -1.55, -5.5), (arg_69_1.time_ - 0) / var_72_0)
				arg_69_1.actors_["4040ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_69_1.actors_["4040ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_69_1.actors_["4040ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_69_1.actors_["4040ui_story"].transform.position).z)
				arg_69_1.actors_["4040ui_story"].transform.localEulerAngles.z = 0
				arg_69_1.actors_["4040ui_story"].transform.localEulerAngles.x = 0
				arg_69_1.actors_["4040ui_story"].transform.localEulerAngles = arg_69_1.actors_["4040ui_story"].transform.localEulerAngles
			end

			if arg_69_1.time_ >= 0 + var_72_0 and arg_69_1.time_ < 0 + var_72_0 + arg_72_0 then
				arg_69_1.actors_["4040ui_story"].transform.localPosition = Vector3.New(0, -1.55, -5.5)
				arg_69_1.actors_["4040ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_69_1.actors_["4040ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_69_1.actors_["4040ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_69_1.actors_["4040ui_story"].transform.position).z)
				arg_69_1.actors_["4040ui_story"].transform.localEulerAngles.z = 0
				arg_69_1.actors_["4040ui_story"].transform.localEulerAngles.x = 0
				arg_69_1.actors_["4040ui_story"].transform.localEulerAngles = arg_69_1.actors_["4040ui_story"].transform.localEulerAngles
			end

			local var_72_1 = arg_69_1.actors_["4040ui_story"]

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 and not isNil(var_72_1) and arg_69_1.var_.characterEffect4040ui_story == nil then
				arg_69_1.var_.characterEffect4040ui_story = var_72_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_2 = 0.200000002980232

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_2 and not isNil(var_72_1) then
				if arg_69_1.var_.characterEffect4040ui_story and not isNil(var_72_1) then
					arg_69_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_69_1.time_ >= 0 + var_72_2 and arg_69_1.time_ < 0 + var_72_2 + arg_72_0 and not isNil(var_72_1) and arg_69_1.var_.characterEffect4040ui_story then
				arg_69_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_72_4 = arg_69_1.actors_["10066ui_story"].transform

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1.var_.moveOldPos10066ui_story = var_72_4.localPosition
			end

			local var_72_5 = 0.001

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_5 then
				var_72_4.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos10066ui_story, Vector3.New(0, 100, 0), (arg_69_1.time_ - 0) / var_72_5)
				var_72_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_72_4.position).x, (manager.ui.mainCamera.transform.position - var_72_4.position).y, (manager.ui.mainCamera.transform.position - var_72_4.position).z)
				var_72_4.localEulerAngles.z = 0
				var_72_4.localEulerAngles.x = 0
				var_72_4.localEulerAngles = var_72_4.localEulerAngles
			end

			if arg_69_1.time_ >= 0 + var_72_5 and arg_69_1.time_ < 0 + var_72_5 + arg_72_0 then
				var_72_4.localPosition = Vector3.New(0, 100, 0)
				var_72_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_72_4.position).x, (manager.ui.mainCamera.transform.position - var_72_4.position).y, (manager.ui.mainCamera.transform.position - var_72_4.position).z)
				var_72_4.localEulerAngles.z = 0
				var_72_4.localEulerAngles.x = 0
				var_72_4.localEulerAngles = var_72_4.localEulerAngles
			end

			local var_72_6 = arg_69_1.actors_["10066ui_story"]

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 and not isNil(var_72_6) and arg_69_1.var_.characterEffect10066ui_story == nil then
				arg_69_1.var_.characterEffect10066ui_story = var_72_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_7 = 0.200000002980232

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_7 and not isNil(var_72_6) then
				if arg_69_1.var_.characterEffect10066ui_story and not isNil(var_72_6) then
					arg_69_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_69_1.var_.characterEffect10066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_69_1.time_ - 0) / var_72_7)
				end
			end

			if arg_69_1.time_ >= 0 + var_72_7 and arg_69_1.time_ < 0 + var_72_7 + arg_72_0 and not isNil(var_72_6) and arg_69_1.var_.characterEffect10066ui_story then
				arg_69_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_69_1.var_.characterEffect10066ui_story.fillRatio = 0.5
			end

			local var_72_8 = arg_69_1.actors_["10079ui_story"].transform

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1.var_.moveOldPos10079ui_story = var_72_8.localPosition
			end

			local var_72_9 = 0.001

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_9 then
				var_72_8.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos10079ui_story, Vector3.New(0, 100, 0), (arg_69_1.time_ - 0) / var_72_9)
				var_72_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_72_8.position).x, (manager.ui.mainCamera.transform.position - var_72_8.position).y, (manager.ui.mainCamera.transform.position - var_72_8.position).z)
				var_72_8.localEulerAngles.z = 0
				var_72_8.localEulerAngles.x = 0
				var_72_8.localEulerAngles = var_72_8.localEulerAngles
			end

			if arg_69_1.time_ >= 0 + var_72_9 and arg_69_1.time_ < 0 + var_72_9 + arg_72_0 then
				var_72_8.localPosition = Vector3.New(0, 100, 0)
				var_72_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_72_8.position).x, (manager.ui.mainCamera.transform.position - var_72_8.position).y, (manager.ui.mainCamera.transform.position - var_72_8.position).z)
				var_72_8.localEulerAngles.z = 0
				var_72_8.localEulerAngles.x = 0
				var_72_8.localEulerAngles = var_72_8.localEulerAngles
			end

			local var_72_10 = arg_69_1.actors_["10079ui_story"]

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 and not isNil(var_72_10) and arg_69_1.var_.characterEffect10079ui_story == nil then
				arg_69_1.var_.characterEffect10079ui_story = var_72_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_11 = 0.200000002980232

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_11 and not isNil(var_72_10) then
				if arg_69_1.var_.characterEffect10079ui_story and not isNil(var_72_10) then
					arg_69_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_69_1.var_.characterEffect10079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_69_1.time_ - 0) / var_72_11)
				end
			end

			if arg_69_1.time_ >= 0 + var_72_11 and arg_69_1.time_ < 0 + var_72_11 + arg_72_0 and not isNil(var_72_10) and arg_69_1.var_.characterEffect10079ui_story then
				arg_69_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_69_1.var_.characterEffect10079ui_story.fillRatio = 0.5
			end

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action2_2")
			end

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_72_12 = 0
			local var_72_13 = 0.325

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_12 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				arg_69_1.leftNameTxt_.text = arg_69_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_14 = arg_69_1:GetWordFromCfg(319741017)
				local var_72_15 = arg_69_1:FormatText(var_72_14.content)

				arg_69_1.text_.text = var_72_15

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_17 = 13 <= 0 and var_72_13 or var_72_13 * (utf8.len(var_72_15) / 13)

				if (13 <= 0 and var_72_13 or var_72_13 * (utf8.len(var_72_15) / 13)) > 0 and var_72_13 < var_72_17 then
					arg_69_1.talkMaxDuration = var_72_17

					if var_72_17 + var_72_12 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_17 + var_72_12
					end
				end

				arg_69_1.text_.text = var_72_15
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319741", "319741017", "story_v_out_319741.awb") ~= 0 then
					local var_72_18 = manager.audio:GetVoiceLength("story_v_out_319741", "319741017", "story_v_out_319741.awb") / 1000

					if var_72_18 + var_72_12 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_18 + var_72_12
					end

					if var_72_14.prefab_name ~= "" and arg_69_1.actors_[var_72_14.prefab_name] ~= nil then
						local var_72_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_14.prefab_name].transform, "story_v_out_319741", "319741017", "story_v_out_319741.awb")

						arg_69_1:RecordAudio("319741017", var_72_19)
						arg_69_1:RecordAudio("319741017", var_72_19)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_319741", "319741017", "story_v_out_319741.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_319741", "319741017", "story_v_out_319741.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_20 = math.max(var_72_13, arg_69_1.talkMaxDuration)

			if var_72_12 <= arg_69_1.time_ and arg_69_1.time_ < var_72_12 + var_72_20 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_12) / var_72_20

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_12 + var_72_20 and arg_69_1.time_ < var_72_12 + var_72_20 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {
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
				actorName = "10066ui_story",
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

		arg_69_1:InitPlayNodeList()
	end,
	Play319741018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 319741018
		arg_73_1.duration_ = 5

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play319741019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1.var_.moveOldPos4040ui_story = arg_73_1.actors_["4040ui_story"].transform.localPosition
			end

			local var_76_0 = 0.001

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_0 then
				arg_73_1.actors_["4040ui_story"].transform.localPosition = Vector3.Lerp(arg_73_1.var_.moveOldPos4040ui_story, Vector3.New(0, 100, 0), (arg_73_1.time_ - 0) / var_76_0)
				arg_73_1.actors_["4040ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_73_1.actors_["4040ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_73_1.actors_["4040ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_73_1.actors_["4040ui_story"].transform.position).z)
				arg_73_1.actors_["4040ui_story"].transform.localEulerAngles.z = 0
				arg_73_1.actors_["4040ui_story"].transform.localEulerAngles.x = 0
				arg_73_1.actors_["4040ui_story"].transform.localEulerAngles = arg_73_1.actors_["4040ui_story"].transform.localEulerAngles
			end

			if arg_73_1.time_ >= 0 + var_76_0 and arg_73_1.time_ < 0 + var_76_0 + arg_76_0 then
				arg_73_1.actors_["4040ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_73_1.actors_["4040ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_73_1.actors_["4040ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_73_1.actors_["4040ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_73_1.actors_["4040ui_story"].transform.position).z)
				arg_73_1.actors_["4040ui_story"].transform.localEulerAngles.z = 0
				arg_73_1.actors_["4040ui_story"].transform.localEulerAngles.x = 0
				arg_73_1.actors_["4040ui_story"].transform.localEulerAngles = arg_73_1.actors_["4040ui_story"].transform.localEulerAngles
			end

			local var_76_1 = arg_73_1.actors_["4040ui_story"]

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 and not isNil(var_76_1) and arg_73_1.var_.characterEffect4040ui_story == nil then
				arg_73_1.var_.characterEffect4040ui_story = var_76_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_2 = 0.200000002980232

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_2 and not isNil(var_76_1) then
				if arg_73_1.var_.characterEffect4040ui_story and not isNil(var_76_1) then
					arg_73_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_73_1.var_.characterEffect4040ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_73_1.time_ - 0) / var_76_2)
				end
			end

			if arg_73_1.time_ >= 0 + var_76_2 and arg_73_1.time_ < 0 + var_76_2 + arg_76_0 and not isNil(var_76_1) and arg_73_1.var_.characterEffect4040ui_story then
				arg_73_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_73_1.var_.characterEffect4040ui_story.fillRatio = 0.5
			end

			local var_76_3 = 0
			local var_76_4 = 0.975

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_3 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, false)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_5 = arg_73_1:FormatText(arg_73_1:GetWordFromCfg(319741018).content)

				arg_73_1.text_.text = var_76_5

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_7 = 39 <= 0 and var_76_4 or var_76_4 * (utf8.len(var_76_5) / 39)

				if (39 <= 0 and var_76_4 or var_76_4 * (utf8.len(var_76_5) / 39)) > 0 and var_76_4 < var_76_7 then
					arg_73_1.talkMaxDuration = var_76_7

					if var_76_7 + var_76_3 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_7 + var_76_3
					end
				end

				arg_73_1.text_.text = var_76_5
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)
				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_8 = math.max(var_76_4, arg_73_1.talkMaxDuration)

			if var_76_3 <= arg_73_1.time_ and arg_73_1.time_ < var_76_3 + var_76_8 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_3) / var_76_8

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_3 + var_76_8 and arg_73_1.time_ < var_76_3 + var_76_8 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {
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

		arg_73_1:InitPlayNodeList()
	end,
	Play319741019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 319741019
		arg_77_1.duration_ = 4.1

		local var_77_0 = {
			zh = 3.533,
			ja = 4.1
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
				arg_77_0:Play319741020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1.var_.moveOldPos10066ui_story = arg_77_1.actors_["10066ui_story"].transform.localPosition
			end

			local var_80_0 = 0.001

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_0 then
				arg_77_1.actors_["10066ui_story"].transform.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos10066ui_story, Vector3.New(0, -0.99, -5.83), (arg_77_1.time_ - 0) / var_80_0)
				arg_77_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_77_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_77_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_77_1.actors_["10066ui_story"].transform.position).z)
				arg_77_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_77_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_77_1.actors_["10066ui_story"].transform.localEulerAngles = arg_77_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			if arg_77_1.time_ >= 0 + var_80_0 and arg_77_1.time_ < 0 + var_80_0 + arg_80_0 then
				arg_77_1.actors_["10066ui_story"].transform.localPosition = Vector3.New(0, -0.99, -5.83)
				arg_77_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_77_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_77_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_77_1.actors_["10066ui_story"].transform.position).z)
				arg_77_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_77_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_77_1.actors_["10066ui_story"].transform.localEulerAngles = arg_77_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			local var_80_1 = arg_77_1.actors_["10066ui_story"]

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 and not isNil(var_80_1) and arg_77_1.var_.characterEffect10066ui_story == nil then
				arg_77_1.var_.characterEffect10066ui_story = var_80_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_2 = 0.200000002980232

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_2 and not isNil(var_80_1) then
				if arg_77_1.var_.characterEffect10066ui_story and not isNil(var_80_1) then
					arg_77_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_77_1.time_ >= 0 + var_80_2 and arg_77_1.time_ < 0 + var_80_2 + arg_80_0 and not isNil(var_80_1) and arg_77_1.var_.characterEffect10066ui_story then
				arg_77_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action1_1")
			end

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_80_4 = 0
			local var_80_5 = 0.375

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_4 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				arg_77_1.leftNameTxt_.text = arg_77_1:FormatText(StoryNameCfg[640].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_6 = arg_77_1:GetWordFromCfg(319741019)
				local var_80_7 = arg_77_1:FormatText(var_80_6.content)

				arg_77_1.text_.text = var_80_7

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_9 = 15 <= 0 and var_80_5 or var_80_5 * (utf8.len(var_80_7) / 15)

				if (15 <= 0 and var_80_5 or var_80_5 * (utf8.len(var_80_7) / 15)) > 0 and var_80_5 < var_80_9 then
					arg_77_1.talkMaxDuration = var_80_9

					if var_80_9 + var_80_4 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_9 + var_80_4
					end
				end

				arg_77_1.text_.text = var_80_7
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319741", "319741019", "story_v_out_319741.awb") ~= 0 then
					local var_80_10 = manager.audio:GetVoiceLength("story_v_out_319741", "319741019", "story_v_out_319741.awb") / 1000

					if var_80_10 + var_80_4 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_10 + var_80_4
					end

					if var_80_6.prefab_name ~= "" and arg_77_1.actors_[var_80_6.prefab_name] ~= nil then
						local var_80_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_6.prefab_name].transform, "story_v_out_319741", "319741019", "story_v_out_319741.awb")

						arg_77_1:RecordAudio("319741019", var_80_11)
						arg_77_1:RecordAudio("319741019", var_80_11)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_319741", "319741019", "story_v_out_319741.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_319741", "319741019", "story_v_out_319741.awb")
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
				actorName = "10066ui_story",
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
	Play319741020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 319741020
		arg_81_1.duration_ = 5

		SetActive(arg_81_1.tipsGo_, false)

		function arg_81_1.onSingleLineFinish_()
			arg_81_1.onSingleLineUpdate_ = nil
			arg_81_1.onSingleLineFinish_ = nil
			arg_81_1.state_ = "waiting"
		end

		function arg_81_1.playNext_(arg_83_0)
			if arg_83_0 == 1 then
				arg_81_0:Play319741021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 and not isNil(arg_81_1.actors_["10066ui_story"]) and arg_81_1.var_.characterEffect10066ui_story == nil then
				arg_81_1.var_.characterEffect10066ui_story = arg_81_1.actors_["10066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_0 = 0.200000002980232

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_0 and not isNil(arg_81_1.actors_["10066ui_story"]) then
				if arg_81_1.var_.characterEffect10066ui_story and not isNil(arg_81_1.actors_["10066ui_story"]) then
					arg_81_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_81_1.var_.characterEffect10066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_81_1.time_ - 0) / var_84_0)
				end
			end

			if arg_81_1.time_ >= 0 + var_84_0 and arg_81_1.time_ < 0 + var_84_0 + arg_84_0 and not isNil(arg_81_1.actors_["10066ui_story"]) and arg_81_1.var_.characterEffect10066ui_story then
				arg_81_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_81_1.var_.characterEffect10066ui_story.fillRatio = 0.5
			end

			local var_84_1 = arg_81_1.actors_["10066ui_story"].transform

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1.var_.moveOldPos10066ui_story = var_84_1.localPosition
			end

			local var_84_2 = 0.001

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_2 then
				var_84_1.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPos10066ui_story, Vector3.New(0, 100, 0), (arg_81_1.time_ - 0) / var_84_2)
				var_84_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_84_1.position).x, (manager.ui.mainCamera.transform.position - var_84_1.position).y, (manager.ui.mainCamera.transform.position - var_84_1.position).z)
				var_84_1.localEulerAngles.z = 0
				var_84_1.localEulerAngles.x = 0
				var_84_1.localEulerAngles = var_84_1.localEulerAngles
			end

			if arg_81_1.time_ >= 0 + var_84_2 and arg_81_1.time_ < 0 + var_84_2 + arg_84_0 then
				var_84_1.localPosition = Vector3.New(0, 100, 0)
				var_84_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_84_1.position).x, (manager.ui.mainCamera.transform.position - var_84_1.position).y, (manager.ui.mainCamera.transform.position - var_84_1.position).z)
				var_84_1.localEulerAngles.z = 0
				var_84_1.localEulerAngles.x = 0
				var_84_1.localEulerAngles = var_84_1.localEulerAngles
			end

			local var_84_3 = 0
			local var_84_4 = 1.05

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_3 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, false)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_5 = arg_81_1:FormatText(arg_81_1:GetWordFromCfg(319741020).content)

				arg_81_1.text_.text = var_84_5

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_7 = 42 <= 0 and var_84_4 or var_84_4 * (utf8.len(var_84_5) / 42)

				if (42 <= 0 and var_84_4 or var_84_4 * (utf8.len(var_84_5) / 42)) > 0 and var_84_4 < var_84_7 then
					arg_81_1.talkMaxDuration = var_84_7

					if var_84_7 + var_84_3 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_7 + var_84_3
					end
				end

				arg_81_1.text_.text = var_84_5
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)
				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_8 = math.max(var_84_4, arg_81_1.talkMaxDuration)

			if var_84_3 <= arg_81_1.time_ and arg_81_1.time_ < var_84_3 + var_84_8 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_3) / var_84_8

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_3 + var_84_8 and arg_81_1.time_ < var_84_3 + var_84_8 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10066ui_story",
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
	Play319741021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 319741021
		arg_85_1.duration_ = 11.9

		local var_85_0 = {
			zh = 7.066,
			ja = 11.9
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
				arg_85_0:Play319741022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 and not isNil(arg_85_1.actors_["10066ui_story"]) and arg_85_1.var_.characterEffect10066ui_story == nil then
				arg_85_1.var_.characterEffect10066ui_story = arg_85_1.actors_["10066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_0 = 0.200000002980232

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_0 and not isNil(arg_85_1.actors_["10066ui_story"]) then
				if arg_85_1.var_.characterEffect10066ui_story and not isNil(arg_85_1.actors_["10066ui_story"]) then
					arg_85_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_85_1.var_.characterEffect10066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_85_1.time_ - 0) / var_88_0)
				end
			end

			if arg_85_1.time_ >= 0 + var_88_0 and arg_85_1.time_ < 0 + var_88_0 + arg_88_0 and not isNil(arg_85_1.actors_["10066ui_story"]) and arg_85_1.var_.characterEffect10066ui_story then
				arg_85_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_85_1.var_.characterEffect10066ui_story.fillRatio = 0.5
			end

			local var_88_1 = 0
			local var_88_2 = 0.6

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_1 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				arg_85_1.leftNameTxt_.text = arg_85_1:FormatText(StoryNameCfg[640].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, true)
				arg_85_1.iconController_:SetSelectedState("hero")

				arg_85_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10066")

				arg_85_1.callingController_:SetSelectedState("normal")

				arg_85_1.keyicon_.color = Color.New(1, 1, 1)
				arg_85_1.icon_.color = Color.New(1, 1, 1)

				local var_88_3 = arg_85_1:GetWordFromCfg(319741021)
				local var_88_4 = arg_85_1:FormatText(var_88_3.content)

				arg_85_1.text_.text = var_88_4

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_6 = 24 <= 0 and var_88_2 or var_88_2 * (utf8.len(var_88_4) / 24)

				if (24 <= 0 and var_88_2 or var_88_2 * (utf8.len(var_88_4) / 24)) > 0 and var_88_2 < var_88_6 then
					arg_85_1.talkMaxDuration = var_88_6

					if var_88_6 + var_88_1 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_6 + var_88_1
					end
				end

				arg_85_1.text_.text = var_88_4
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319741", "319741021", "story_v_out_319741.awb") ~= 0 then
					local var_88_7 = manager.audio:GetVoiceLength("story_v_out_319741", "319741021", "story_v_out_319741.awb") / 1000

					if var_88_7 + var_88_1 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_7 + var_88_1
					end

					if var_88_3.prefab_name ~= "" and arg_85_1.actors_[var_88_3.prefab_name] ~= nil then
						local var_88_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_3.prefab_name].transform, "story_v_out_319741", "319741021", "story_v_out_319741.awb")

						arg_85_1:RecordAudio("319741021", var_88_8)
						arg_85_1:RecordAudio("319741021", var_88_8)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_319741", "319741021", "story_v_out_319741.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_319741", "319741021", "story_v_out_319741.awb")
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
	Play319741022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 319741022
		arg_89_1.duration_ = 12.37

		local var_89_0 = {
			zh = 11.5,
			ja = 12.366
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
				arg_89_0:Play319741023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = 1.1

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				arg_89_1.leftNameTxt_.text = arg_89_1:FormatText(StoryNameCfg[640].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, true)
				arg_89_1.iconController_:SetSelectedState("hero")

				arg_89_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10066")

				arg_89_1.callingController_:SetSelectedState("normal")

				arg_89_1.keyicon_.color = Color.New(1, 1, 1)
				arg_89_1.icon_.color = Color.New(1, 1, 1)

				local var_92_1 = arg_89_1:GetWordFromCfg(319741022)
				local var_92_2 = arg_89_1:FormatText(var_92_1.content)

				arg_89_1.text_.text = var_92_2

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_4 = 44 <= 0 and var_92_0 or var_92_0 * (utf8.len(var_92_2) / 44)

				if (44 <= 0 and var_92_0 or var_92_0 * (utf8.len(var_92_2) / 44)) > 0 and var_92_0 < var_92_4 then
					arg_89_1.talkMaxDuration = var_92_4

					if var_92_4 + 0 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_4 + 0
					end
				end

				arg_89_1.text_.text = var_92_2
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319741", "319741022", "story_v_out_319741.awb") ~= 0 then
					local var_92_5 = manager.audio:GetVoiceLength("story_v_out_319741", "319741022", "story_v_out_319741.awb") / 1000

					if var_92_5 + 0 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_5 + 0
					end

					if var_92_1.prefab_name ~= "" and arg_89_1.actors_[var_92_1.prefab_name] ~= nil then
						local var_92_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_1.prefab_name].transform, "story_v_out_319741", "319741022", "story_v_out_319741.awb")

						arg_89_1:RecordAudio("319741022", var_92_6)
						arg_89_1:RecordAudio("319741022", var_92_6)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_319741", "319741022", "story_v_out_319741.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_319741", "319741022", "story_v_out_319741.awb")
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
	Play319741023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 319741023
		arg_93_1.duration_ = 6.17

		local var_93_0 = {
			zh = 4.966,
			ja = 6.166
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
				arg_93_0:Play319741024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = 0.425

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				arg_93_1.leftNameTxt_.text = arg_93_1:FormatText(StoryNameCfg[640].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, true)
				arg_93_1.iconController_:SetSelectedState("hero")

				arg_93_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10066")

				arg_93_1.callingController_:SetSelectedState("normal")

				arg_93_1.keyicon_.color = Color.New(1, 1, 1)
				arg_93_1.icon_.color = Color.New(1, 1, 1)

				local var_96_1 = arg_93_1:GetWordFromCfg(319741023)
				local var_96_2 = arg_93_1:FormatText(var_96_1.content)

				arg_93_1.text_.text = var_96_2

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_4 = 17 <= 0 and var_96_0 or var_96_0 * (utf8.len(var_96_2) / 17)

				if (17 <= 0 and var_96_0 or var_96_0 * (utf8.len(var_96_2) / 17)) > 0 and var_96_0 < var_96_4 then
					arg_93_1.talkMaxDuration = var_96_4

					if var_96_4 + 0 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_4 + 0
					end
				end

				arg_93_1.text_.text = var_96_2
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319741", "319741023", "story_v_out_319741.awb") ~= 0 then
					local var_96_5 = manager.audio:GetVoiceLength("story_v_out_319741", "319741023", "story_v_out_319741.awb") / 1000

					if var_96_5 + 0 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_5 + 0
					end

					if var_96_1.prefab_name ~= "" and arg_93_1.actors_[var_96_1.prefab_name] ~= nil then
						local var_96_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_1.prefab_name].transform, "story_v_out_319741", "319741023", "story_v_out_319741.awb")

						arg_93_1:RecordAudio("319741023", var_96_6)
						arg_93_1:RecordAudio("319741023", var_96_6)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_319741", "319741023", "story_v_out_319741.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_319741", "319741023", "story_v_out_319741.awb")
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
	Play319741024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 319741024
		arg_97_1.duration_ = 5

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play319741025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1.var_.moveOldPos10066ui_story = arg_97_1.actors_["10066ui_story"].transform.localPosition
			end

			local var_100_0 = 0.001

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_0 then
				arg_97_1.actors_["10066ui_story"].transform.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos10066ui_story, Vector3.New(0, 100, 0), (arg_97_1.time_ - 0) / var_100_0)
				arg_97_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_97_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["10066ui_story"].transform.position).z)
				arg_97_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_97_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_97_1.actors_["10066ui_story"].transform.localEulerAngles = arg_97_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			if arg_97_1.time_ >= 0 + var_100_0 and arg_97_1.time_ < 0 + var_100_0 + arg_100_0 then
				arg_97_1.actors_["10066ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_97_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_97_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["10066ui_story"].transform.position).z)
				arg_97_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_97_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_97_1.actors_["10066ui_story"].transform.localEulerAngles = arg_97_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			local var_100_1 = arg_97_1.actors_["10066ui_story"]

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 and not isNil(var_100_1) and arg_97_1.var_.characterEffect10066ui_story == nil then
				arg_97_1.var_.characterEffect10066ui_story = var_100_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_2 = 0.200000002980232

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_2 and not isNil(var_100_1) then
				if arg_97_1.var_.characterEffect10066ui_story and not isNil(var_100_1) then
					arg_97_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_97_1.var_.characterEffect10066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_97_1.time_ - 0) / var_100_2)
				end
			end

			if arg_97_1.time_ >= 0 + var_100_2 and arg_97_1.time_ < 0 + var_100_2 + arg_100_0 and not isNil(var_100_1) and arg_97_1.var_.characterEffect10066ui_story then
				arg_97_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_97_1.var_.characterEffect10066ui_story.fillRatio = 0.5
			end

			local var_100_3 = 0
			local var_100_4 = 0.85

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_3 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, false)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_5 = arg_97_1:FormatText(arg_97_1:GetWordFromCfg(319741024).content)

				arg_97_1.text_.text = var_100_5

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_7 = 34 <= 0 and var_100_4 or var_100_4 * (utf8.len(var_100_5) / 34)

				if (34 <= 0 and var_100_4 or var_100_4 * (utf8.len(var_100_5) / 34)) > 0 and var_100_4 < var_100_7 then
					arg_97_1.talkMaxDuration = var_100_7

					if var_100_7 + var_100_3 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_7 + var_100_3
					end
				end

				arg_97_1.text_.text = var_100_5
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)
				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_8 = math.max(var_100_4, arg_97_1.talkMaxDuration)

			if var_100_3 <= arg_97_1.time_ and arg_97_1.time_ < var_100_3 + var_100_8 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_3) / var_100_8

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_3 + var_100_8 and arg_97_1.time_ < var_100_3 + var_100_8 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10066ui_story",
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
	Play319741025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 319741025
		arg_101_1.duration_ = 4.02

		local var_101_0 = {
			zh = 3.799999999999,
			ja = 4.01600000298023
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
				arg_101_0:Play319741026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			if 1.8 < arg_101_1.time_ and arg_101_1.time_ <= 1.8 + arg_104_0 then
				arg_101_1.var_.moveOldPos4040ui_story = arg_101_1.actors_["4040ui_story"].transform.localPosition
			end

			local var_104_0 = 0.001

			if 1.8 <= arg_101_1.time_ and arg_101_1.time_ < 1.8 + var_104_0 then
				arg_101_1.actors_["4040ui_story"].transform.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos4040ui_story, Vector3.New(0, -1.55, -5.5), (arg_101_1.time_ - 1.8) / var_104_0)
				arg_101_1.actors_["4040ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_101_1.actors_["4040ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_101_1.actors_["4040ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_101_1.actors_["4040ui_story"].transform.position).z)
				arg_101_1.actors_["4040ui_story"].transform.localEulerAngles.z = 0
				arg_101_1.actors_["4040ui_story"].transform.localEulerAngles.x = 0
				arg_101_1.actors_["4040ui_story"].transform.localEulerAngles = arg_101_1.actors_["4040ui_story"].transform.localEulerAngles
			end

			if arg_101_1.time_ >= 1.8 + var_104_0 and arg_101_1.time_ < 1.8 + var_104_0 + arg_104_0 then
				arg_101_1.actors_["4040ui_story"].transform.localPosition = Vector3.New(0, -1.55, -5.5)
				arg_101_1.actors_["4040ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_101_1.actors_["4040ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_101_1.actors_["4040ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_101_1.actors_["4040ui_story"].transform.position).z)
				arg_101_1.actors_["4040ui_story"].transform.localEulerAngles.z = 0
				arg_101_1.actors_["4040ui_story"].transform.localEulerAngles.x = 0
				arg_101_1.actors_["4040ui_story"].transform.localEulerAngles = arg_101_1.actors_["4040ui_story"].transform.localEulerAngles
			end

			local var_104_1 = arg_101_1.actors_["4040ui_story"]

			if 1.8 < arg_101_1.time_ and arg_101_1.time_ <= 1.8 + arg_104_0 and not isNil(var_104_1) and arg_101_1.var_.characterEffect4040ui_story == nil then
				arg_101_1.var_.characterEffect4040ui_story = var_104_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_2 = 0.200000002980232

			if 1.8 <= arg_101_1.time_ and arg_101_1.time_ < 1.8 + var_104_2 and not isNil(var_104_1) then
				if arg_101_1.var_.characterEffect4040ui_story and not isNil(var_104_1) then
					arg_101_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_101_1.time_ >= 1.8 + var_104_2 and arg_101_1.time_ < 1.8 + var_104_2 + arg_104_0 and not isNil(var_104_1) and arg_101_1.var_.characterEffect4040ui_story then
				arg_101_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			if 1.8 < arg_101_1.time_ and arg_101_1.time_ <= 1.8 + arg_104_0 then
				arg_101_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action1_1")
			end

			if 1.8 < arg_101_1.time_ and arg_101_1.time_ <= 1.8 + arg_104_0 then
				arg_101_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			if 1 < arg_101_1.time_ and arg_101_1.time_ <= 1 + arg_104_0 then
				local var_104_4 = arg_101_1.bgs_.I11m

				arg_101_1.bgs_.I11m.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_104_4.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_104_5 = var_104_4:GetComponent("SpriteRenderer")

				if var_104_5 and var_104_5.sprite then
					local var_104_6 = 2 * (var_104_4.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_104_4.transform.localScale = Vector3.New(var_104_6 / var_104_5.sprite.bounds.size.y < var_104_6 * manager.ui.mainCameraCom_.aspect / var_104_5.sprite.bounds.size.x and var_104_6 * manager.ui.mainCameraCom_.aspect / var_104_5.sprite.bounds.size.x or var_104_6 / var_104_5.sprite.bounds.size.y, var_104_6 / var_104_5.sprite.bounds.size.y < var_104_6 * manager.ui.mainCameraCom_.aspect / var_104_5.sprite.bounds.size.x and var_104_6 * manager.ui.mainCameraCom_.aspect / var_104_5.sprite.bounds.size.x or var_104_6 / var_104_5.sprite.bounds.size.y, 0)
				end

				for iter_104_0, iter_104_1 in pairs(arg_101_1.bgs_) do
					if iter_104_0 ~= "I11m" then
						iter_104_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_104_7 = 0

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= var_104_7 + arg_104_0 then
				arg_101_1.mask_.enabled = true
				arg_101_1.mask_.raycastTarget = true

				arg_101_1:SetGaussion(false)
			end

			local var_104_8 = 1

			if var_104_7 <= arg_101_1.time_ and arg_101_1.time_ < var_104_7 + var_104_8 then
				local var_104_9 = Color.New(0, 0, 0)

				var_104_9.a = Mathf.Lerp(0, 1, (arg_101_1.time_ - var_104_7) / var_104_8)
				arg_101_1.mask_.color = var_104_9
			end

			if arg_101_1.time_ >= var_104_7 + var_104_8 and arg_101_1.time_ < var_104_7 + var_104_8 + arg_104_0 then
				local var_104_10 = Color.New(0, 0, 0)

				var_104_10.a = 1
				arg_101_1.mask_.color = var_104_10
			end

			local var_104_11 = 1

			if 1 < arg_101_1.time_ and arg_101_1.time_ <= var_104_11 + arg_104_0 then
				arg_101_1.mask_.enabled = true
				arg_101_1.mask_.raycastTarget = true

				arg_101_1:SetGaussion(false)
			end

			local var_104_12 = 1

			if var_104_11 <= arg_101_1.time_ and arg_101_1.time_ < var_104_11 + var_104_12 then
				local var_104_13 = Color.New(0, 0, 0)

				var_104_13.a = Mathf.Lerp(1, 0, (arg_101_1.time_ - var_104_11) / var_104_12)
				arg_101_1.mask_.color = var_104_13
			end

			if arg_101_1.time_ >= var_104_11 + var_104_12 and arg_101_1.time_ < var_104_11 + var_104_12 + arg_104_0 then
				local var_104_14 = Color.New(0, 0, 0)

				arg_101_1.mask_.enabled = false
				var_104_14.a = 0
				arg_101_1.mask_.color = var_104_14
			end

			if arg_101_1.frameCnt_ <= 1 then
				arg_101_1.dialog_:SetActive(false)
			end

			local var_104_15 = 1.85000000298023
			local var_104_16 = 0.15

			if 1.85000000298023 < arg_101_1.time_ and arg_101_1.time_ <= var_104_15 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0

				arg_101_1.dialog_:SetActive(true)

				arg_101_1.dialogCg_.alpha = 0

				local var_104_17 = LeanTween.value(arg_101_1.dialog_, 0, 1, 0.3)

				var_104_17:setOnUpdate(LuaHelper.FloatAction(function(arg_105_0)
					arg_101_1.dialogCg_.alpha = arg_105_0
				end))
				var_104_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_101_1.dialog_)
					var_104_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_101_1.duration_ = arg_101_1.duration_ + 0.3

				SetActive(arg_101_1.leftNameGo_, true)

				arg_101_1.leftNameTxt_.text = arg_101_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_18 = arg_101_1:GetWordFromCfg(319741025)
				local var_104_19 = arg_101_1:FormatText(var_104_18.content)

				arg_101_1.text_.text = var_104_19

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_21 = 6 <= 0 and var_104_16 or var_104_16 * (utf8.len(var_104_19) / 6)

				if (6 <= 0 and var_104_16 or var_104_16 * (utf8.len(var_104_19) / 6)) > 0 and var_104_16 < var_104_21 then
					arg_101_1.talkMaxDuration = var_104_21
					var_104_15 = var_104_15 + 0.3

					if var_104_21 + var_104_15 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_21 + var_104_15
					end
				end

				arg_101_1.text_.text = var_104_19
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319741", "319741025", "story_v_out_319741.awb") ~= 0 then
					local var_104_22 = manager.audio:GetVoiceLength("story_v_out_319741", "319741025", "story_v_out_319741.awb") / 1000

					if var_104_22 + var_104_15 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_22 + var_104_15
					end

					if var_104_18.prefab_name ~= "" and arg_101_1.actors_[var_104_18.prefab_name] ~= nil then
						local var_104_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_18.prefab_name].transform, "story_v_out_319741", "319741025", "story_v_out_319741.awb")

						arg_101_1:RecordAudio("319741025", var_104_23)
						arg_101_1:RecordAudio("319741025", var_104_23)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_319741", "319741025", "story_v_out_319741.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_319741", "319741025", "story_v_out_319741.awb")
				end

				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_24 = var_104_15 + 0.3
			local var_104_25 = math.max(var_104_16, arg_101_1.talkMaxDuration)

			if var_104_15 + 0.3 <= arg_101_1.time_ and arg_101_1.time_ < var_104_24 + var_104_25 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_24) / var_104_25

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_24 + var_104_25 and arg_101_1.time_ < var_104_24 + var_104_25 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4040ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_101_1:InitPlayNodeList()
	end,
	Play319741026 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 319741026
		arg_107_1.duration_ = 2

		SetActive(arg_107_1.tipsGo_, false)

		function arg_107_1.onSingleLineFinish_()
			arg_107_1.onSingleLineUpdate_ = nil
			arg_107_1.onSingleLineFinish_ = nil
			arg_107_1.state_ = "waiting"
		end

		function arg_107_1.playNext_(arg_109_0)
			if arg_109_0 == 1 then
				arg_107_0:Play319741027(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 then
				arg_107_1.var_.moveOldPos10079ui_story = arg_107_1.actors_["10079ui_story"].transform.localPosition
			end

			local var_110_0 = 0.001

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_0 then
				arg_107_1.actors_["10079ui_story"].transform.localPosition = Vector3.Lerp(arg_107_1.var_.moveOldPos10079ui_story, Vector3.New(-0.7, -0.95, -6.05), (arg_107_1.time_ - 0) / var_110_0)
				arg_107_1.actors_["10079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_107_1.actors_["10079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_107_1.actors_["10079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_107_1.actors_["10079ui_story"].transform.position).z)
				arg_107_1.actors_["10079ui_story"].transform.localEulerAngles.z = 0
				arg_107_1.actors_["10079ui_story"].transform.localEulerAngles.x = 0
				arg_107_1.actors_["10079ui_story"].transform.localEulerAngles = arg_107_1.actors_["10079ui_story"].transform.localEulerAngles
			end

			if arg_107_1.time_ >= 0 + var_110_0 and arg_107_1.time_ < 0 + var_110_0 + arg_110_0 then
				arg_107_1.actors_["10079ui_story"].transform.localPosition = Vector3.New(-0.7, -0.95, -6.05)
				arg_107_1.actors_["10079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_107_1.actors_["10079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_107_1.actors_["10079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_107_1.actors_["10079ui_story"].transform.position).z)
				arg_107_1.actors_["10079ui_story"].transform.localEulerAngles.z = 0
				arg_107_1.actors_["10079ui_story"].transform.localEulerAngles.x = 0
				arg_107_1.actors_["10079ui_story"].transform.localEulerAngles = arg_107_1.actors_["10079ui_story"].transform.localEulerAngles
			end

			local var_110_1 = arg_107_1.actors_["10079ui_story"]

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 and not isNil(var_110_1) and arg_107_1.var_.characterEffect10079ui_story == nil then
				arg_107_1.var_.characterEffect10079ui_story = var_110_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_110_2 = 0.200000002980232

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_2 and not isNil(var_110_1) then
				if arg_107_1.var_.characterEffect10079ui_story and not isNil(var_110_1) then
					arg_107_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_107_1.time_ >= 0 + var_110_2 and arg_107_1.time_ < 0 + var_110_2 + arg_110_0 and not isNil(var_110_1) and arg_107_1.var_.characterEffect10079ui_story then
				arg_107_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 then
				arg_107_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action4_1")
			end

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 then
				arg_107_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_110_4 = arg_107_1.actors_["4040ui_story"].transform

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 then
				arg_107_1.var_.moveOldPos4040ui_story = var_110_4.localPosition
			end

			local var_110_5 = 0.001

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_5 then
				var_110_4.localPosition = Vector3.Lerp(arg_107_1.var_.moveOldPos4040ui_story, Vector3.New(0.7, -1.55, -5.5), (arg_107_1.time_ - 0) / var_110_5)
				var_110_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_110_4.position).x, (manager.ui.mainCamera.transform.position - var_110_4.position).y, (manager.ui.mainCamera.transform.position - var_110_4.position).z)
				var_110_4.localEulerAngles.z = 0
				var_110_4.localEulerAngles.x = 0
				var_110_4.localEulerAngles = var_110_4.localEulerAngles
			end

			if arg_107_1.time_ >= 0 + var_110_5 and arg_107_1.time_ < 0 + var_110_5 + arg_110_0 then
				var_110_4.localPosition = Vector3.New(0.7, -1.55, -5.5)
				var_110_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_110_4.position).x, (manager.ui.mainCamera.transform.position - var_110_4.position).y, (manager.ui.mainCamera.transform.position - var_110_4.position).z)
				var_110_4.localEulerAngles.z = 0
				var_110_4.localEulerAngles.x = 0
				var_110_4.localEulerAngles = var_110_4.localEulerAngles
			end

			local var_110_6 = arg_107_1.actors_["4040ui_story"]

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 and not isNil(var_110_6) and arg_107_1.var_.characterEffect4040ui_story == nil then
				arg_107_1.var_.characterEffect4040ui_story = var_110_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_110_7 = 0.200000002980232

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_7 and not isNil(var_110_6) then
				if arg_107_1.var_.characterEffect4040ui_story and not isNil(var_110_6) then
					arg_107_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_107_1.var_.characterEffect4040ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_107_1.time_ - 0) / var_110_7)
				end
			end

			if arg_107_1.time_ >= 0 + var_110_7 and arg_107_1.time_ < 0 + var_110_7 + arg_110_0 and not isNil(var_110_6) and arg_107_1.var_.characterEffect4040ui_story then
				arg_107_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_107_1.var_.characterEffect4040ui_story.fillRatio = 0.5
			end

			local var_110_8 = 0
			local var_110_9 = 0.05

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= var_110_8 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, true)

				arg_107_1.leftNameTxt_.text = arg_107_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_107_1.leftNameTxt_.transform)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1.leftNameTxt_.text)
				SetActive(arg_107_1.iconTrs_.gameObject, false)
				arg_107_1.callingController_:SetSelectedState("normal")

				local var_110_10 = arg_107_1:GetWordFromCfg(319741026)
				local var_110_11 = arg_107_1:FormatText(var_110_10.content)

				arg_107_1.text_.text = var_110_11

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_13 = 2 <= 0 and var_110_9 or var_110_9 * (utf8.len(var_110_11) / 2)

				if (2 <= 0 and var_110_9 or var_110_9 * (utf8.len(var_110_11) / 2)) > 0 and var_110_9 < var_110_13 then
					arg_107_1.talkMaxDuration = var_110_13

					if var_110_13 + var_110_8 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_13 + var_110_8
					end
				end

				arg_107_1.text_.text = var_110_11
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319741", "319741026", "story_v_out_319741.awb") ~= 0 then
					local var_110_14 = manager.audio:GetVoiceLength("story_v_out_319741", "319741026", "story_v_out_319741.awb") / 1000

					if var_110_14 + var_110_8 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_14 + var_110_8
					end

					if var_110_10.prefab_name ~= "" and arg_107_1.actors_[var_110_10.prefab_name] ~= nil then
						local var_110_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_107_1.actors_[var_110_10.prefab_name].transform, "story_v_out_319741", "319741026", "story_v_out_319741.awb")

						arg_107_1:RecordAudio("319741026", var_110_15)
						arg_107_1:RecordAudio("319741026", var_110_15)
					else
						arg_107_1:AudioAction("play", "voice", "story_v_out_319741", "319741026", "story_v_out_319741.awb")
					end

					arg_107_1:RecordHistoryTalkVoice("story_v_out_319741", "319741026", "story_v_out_319741.awb")
				end

				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_16 = math.max(var_110_9, arg_107_1.talkMaxDuration)

			if var_110_8 <= arg_107_1.time_ and arg_107_1.time_ < var_110_8 + var_110_16 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - var_110_8) / var_110_16

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= var_110_8 + var_110_16 and arg_107_1.time_ < var_110_8 + var_110_16 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {
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

		arg_107_1:InitPlayNodeList()
	end,
	Play319741027 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 319741027
		arg_111_1.duration_ = 3.33

		local var_111_0 = {
			zh = 3.333,
			ja = 2.9
		}
		local var_111_1 = manager.audio:GetLocalizationFlag()

		if var_111_0[var_111_1] ~= nil then
			arg_111_1.duration_ = var_111_0[var_111_1]
		end

		SetActive(arg_111_1.tipsGo_, false)

		function arg_111_1.onSingleLineFinish_()
			arg_111_1.onSingleLineUpdate_ = nil
			arg_111_1.onSingleLineFinish_ = nil
			arg_111_1.state_ = "waiting"
		end

		function arg_111_1.playNext_(arg_113_0)
			if arg_113_0 == 1 then
				arg_111_0:Play319741028(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			local var_114_0 = 0.3

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, true)

				arg_111_1.leftNameTxt_.text = arg_111_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_111_1.leftNameTxt_.transform)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1.leftNameTxt_.text)
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_1 = arg_111_1:GetWordFromCfg(319741027)
				local var_114_2 = arg_111_1:FormatText(var_114_1.content)

				arg_111_1.text_.text = var_114_2

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_4 = 12 <= 0 and var_114_0 or var_114_0 * (utf8.len(var_114_2) / 12)

				if (12 <= 0 and var_114_0 or var_114_0 * (utf8.len(var_114_2) / 12)) > 0 and var_114_0 < var_114_4 then
					arg_111_1.talkMaxDuration = var_114_4

					if var_114_4 + 0 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_4 + 0
					end
				end

				arg_111_1.text_.text = var_114_2
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319741", "319741027", "story_v_out_319741.awb") ~= 0 then
					local var_114_5 = manager.audio:GetVoiceLength("story_v_out_319741", "319741027", "story_v_out_319741.awb") / 1000

					if var_114_5 + 0 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_5 + 0
					end

					if var_114_1.prefab_name ~= "" and arg_111_1.actors_[var_114_1.prefab_name] ~= nil then
						local var_114_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_111_1.actors_[var_114_1.prefab_name].transform, "story_v_out_319741", "319741027", "story_v_out_319741.awb")

						arg_111_1:RecordAudio("319741027", var_114_6)
						arg_111_1:RecordAudio("319741027", var_114_6)
					else
						arg_111_1:AudioAction("play", "voice", "story_v_out_319741", "319741027", "story_v_out_319741.awb")
					end

					arg_111_1:RecordHistoryTalkVoice("story_v_out_319741", "319741027", "story_v_out_319741.awb")
				end

				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_7 = math.max(var_114_0, arg_111_1.talkMaxDuration)

			if 0 <= arg_111_1.time_ and arg_111_1.time_ < 0 + var_114_7 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - 0) / var_114_7

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= 0 + var_114_7 and arg_111_1.time_ < 0 + var_114_7 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {}

		arg_111_1:InitPlayNodeList()
	end,
	Play319741028 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 319741028
		arg_115_1.duration_ = 5.67

		local var_115_0 = {
			zh = 5.2,
			ja = 5.666
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
				arg_115_0:Play319741029(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 and not isNil(arg_115_1.actors_["10079ui_story"]) and arg_115_1.var_.characterEffect10079ui_story == nil then
				arg_115_1.var_.characterEffect10079ui_story = arg_115_1.actors_["10079ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_118_0 = 0.200000002980232

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_0 and not isNil(arg_115_1.actors_["10079ui_story"]) then
				if arg_115_1.var_.characterEffect10079ui_story and not isNil(arg_115_1.actors_["10079ui_story"]) then
					arg_115_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_115_1.var_.characterEffect10079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_115_1.time_ - 0) / var_118_0)
				end
			end

			if arg_115_1.time_ >= 0 + var_118_0 and arg_115_1.time_ < 0 + var_118_0 + arg_118_0 and not isNil(arg_115_1.actors_["10079ui_story"]) and arg_115_1.var_.characterEffect10079ui_story then
				arg_115_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_115_1.var_.characterEffect10079ui_story.fillRatio = 0.5
			end

			local var_118_1 = arg_115_1.actors_["4040ui_story"]

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 and not isNil(var_118_1) and arg_115_1.var_.characterEffect4040ui_story == nil then
				arg_115_1.var_.characterEffect4040ui_story = var_118_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_118_2 = 0.200000002980232

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_2 and not isNil(var_118_1) then
				if arg_115_1.var_.characterEffect4040ui_story and not isNil(var_118_1) then
					arg_115_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_115_1.time_ >= 0 + var_118_2 and arg_115_1.time_ < 0 + var_118_2 + arg_118_0 and not isNil(var_118_1) and arg_115_1.var_.characterEffect4040ui_story then
				arg_115_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				arg_115_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action5_1")
			end

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				arg_115_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_118_4 = 0
			local var_118_5 = 0.425

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= var_118_4 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, true)

				arg_115_1.leftNameTxt_.text = arg_115_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_6 = arg_115_1:GetWordFromCfg(319741028)
				local var_118_7 = arg_115_1:FormatText(var_118_6.content)

				arg_115_1.text_.text = var_118_7

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_9 = 17 <= 0 and var_118_5 or var_118_5 * (utf8.len(var_118_7) / 17)

				if (17 <= 0 and var_118_5 or var_118_5 * (utf8.len(var_118_7) / 17)) > 0 and var_118_5 < var_118_9 then
					arg_115_1.talkMaxDuration = var_118_9

					if var_118_9 + var_118_4 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_9 + var_118_4
					end
				end

				arg_115_1.text_.text = var_118_7
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319741", "319741028", "story_v_out_319741.awb") ~= 0 then
					local var_118_10 = manager.audio:GetVoiceLength("story_v_out_319741", "319741028", "story_v_out_319741.awb") / 1000

					if var_118_10 + var_118_4 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_10 + var_118_4
					end

					if var_118_6.prefab_name ~= "" and arg_115_1.actors_[var_118_6.prefab_name] ~= nil then
						local var_118_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_115_1.actors_[var_118_6.prefab_name].transform, "story_v_out_319741", "319741028", "story_v_out_319741.awb")

						arg_115_1:RecordAudio("319741028", var_118_11)
						arg_115_1:RecordAudio("319741028", var_118_11)
					else
						arg_115_1:AudioAction("play", "voice", "story_v_out_319741", "319741028", "story_v_out_319741.awb")
					end

					arg_115_1:RecordHistoryTalkVoice("story_v_out_319741", "319741028", "story_v_out_319741.awb")
				end

				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_12 = math.max(var_118_5, arg_115_1.talkMaxDuration)

			if var_118_4 <= arg_115_1.time_ and arg_115_1.time_ < var_118_4 + var_118_12 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - var_118_4) / var_118_12

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= var_118_4 + var_118_12 and arg_115_1.time_ < var_118_4 + var_118_12 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {}

		arg_115_1:InitPlayNodeList()
	end,
	Play319741029 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 319741029
		arg_119_1.duration_ = 5.5

		local var_119_0 = {
			zh = 4.433,
			ja = 5.5
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
				arg_119_0:Play319741030(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 and not isNil(arg_119_1.actors_["10079ui_story"]) and arg_119_1.var_.characterEffect10079ui_story == nil then
				arg_119_1.var_.characterEffect10079ui_story = arg_119_1.actors_["10079ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_122_0 = 0.200000002980232

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_0 and not isNil(arg_119_1.actors_["10079ui_story"]) then
				if arg_119_1.var_.characterEffect10079ui_story and not isNil(arg_119_1.actors_["10079ui_story"]) then
					arg_119_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_119_1.time_ >= 0 + var_122_0 and arg_119_1.time_ < 0 + var_122_0 + arg_122_0 and not isNil(arg_119_1.actors_["10079ui_story"]) and arg_119_1.var_.characterEffect10079ui_story then
				arg_119_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 then
				arg_119_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action4_2")
			end

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 then
				arg_119_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_122_2 = arg_119_1.actors_["4040ui_story"]

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 and not isNil(var_122_2) and arg_119_1.var_.characterEffect4040ui_story == nil then
				arg_119_1.var_.characterEffect4040ui_story = var_122_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_122_3 = 0.200000002980232

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_3 and not isNil(var_122_2) then
				if arg_119_1.var_.characterEffect4040ui_story and not isNil(var_122_2) then
					arg_119_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_119_1.var_.characterEffect4040ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_119_1.time_ - 0) / var_122_3)
				end
			end

			if arg_119_1.time_ >= 0 + var_122_3 and arg_119_1.time_ < 0 + var_122_3 + arg_122_0 and not isNil(var_122_2) and arg_119_1.var_.characterEffect4040ui_story then
				arg_119_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_119_1.var_.characterEffect4040ui_story.fillRatio = 0.5
			end

			local var_122_4 = 0
			local var_122_5 = 0.625

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= var_122_4 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, true)

				arg_119_1.leftNameTxt_.text = arg_119_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_119_1.leftNameTxt_.transform)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1.leftNameTxt_.text)
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_6 = arg_119_1:GetWordFromCfg(319741029)
				local var_122_7 = arg_119_1:FormatText(var_122_6.content)

				arg_119_1.text_.text = var_122_7

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_9 = 25 <= 0 and var_122_5 or var_122_5 * (utf8.len(var_122_7) / 25)

				if (25 <= 0 and var_122_5 or var_122_5 * (utf8.len(var_122_7) / 25)) > 0 and var_122_5 < var_122_9 then
					arg_119_1.talkMaxDuration = var_122_9

					if var_122_9 + var_122_4 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_9 + var_122_4
					end
				end

				arg_119_1.text_.text = var_122_7
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319741", "319741029", "story_v_out_319741.awb") ~= 0 then
					local var_122_10 = manager.audio:GetVoiceLength("story_v_out_319741", "319741029", "story_v_out_319741.awb") / 1000

					if var_122_10 + var_122_4 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_10 + var_122_4
					end

					if var_122_6.prefab_name ~= "" and arg_119_1.actors_[var_122_6.prefab_name] ~= nil then
						local var_122_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_119_1.actors_[var_122_6.prefab_name].transform, "story_v_out_319741", "319741029", "story_v_out_319741.awb")

						arg_119_1:RecordAudio("319741029", var_122_11)
						arg_119_1:RecordAudio("319741029", var_122_11)
					else
						arg_119_1:AudioAction("play", "voice", "story_v_out_319741", "319741029", "story_v_out_319741.awb")
					end

					arg_119_1:RecordHistoryTalkVoice("story_v_out_319741", "319741029", "story_v_out_319741.awb")
				end

				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_12 = math.max(var_122_5, arg_119_1.talkMaxDuration)

			if var_122_4 <= arg_119_1.time_ and arg_119_1.time_ < var_122_4 + var_122_12 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - var_122_4) / var_122_12

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= var_122_4 + var_122_12 and arg_119_1.time_ < var_122_4 + var_122_12 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {}

		arg_119_1:InitPlayNodeList()
	end,
	Play319741030 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 319741030
		arg_123_1.duration_ = 8.77

		local var_123_0 = {
			zh = 6.033,
			ja = 8.766
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
				arg_123_0:Play319741031(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 and not isNil(arg_123_1.actors_["10079ui_story"]) and arg_123_1.var_.characterEffect10079ui_story == nil then
				arg_123_1.var_.characterEffect10079ui_story = arg_123_1.actors_["10079ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_126_0 = 0.200000002980232

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_0 and not isNil(arg_123_1.actors_["10079ui_story"]) then
				if arg_123_1.var_.characterEffect10079ui_story and not isNil(arg_123_1.actors_["10079ui_story"]) then
					arg_123_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_123_1.var_.characterEffect10079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_123_1.time_ - 0) / var_126_0)
				end
			end

			if arg_123_1.time_ >= 0 + var_126_0 and arg_123_1.time_ < 0 + var_126_0 + arg_126_0 and not isNil(arg_123_1.actors_["10079ui_story"]) and arg_123_1.var_.characterEffect10079ui_story then
				arg_123_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_123_1.var_.characterEffect10079ui_story.fillRatio = 0.5
			end

			local var_126_1 = arg_123_1.actors_["4040ui_story"]

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 and not isNil(var_126_1) and arg_123_1.var_.characterEffect4040ui_story == nil then
				arg_123_1.var_.characterEffect4040ui_story = var_126_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_126_2 = 0.200000002980232

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_2 and not isNil(var_126_1) then
				if arg_123_1.var_.characterEffect4040ui_story and not isNil(var_126_1) then
					arg_123_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_123_1.time_ >= 0 + var_126_2 and arg_123_1.time_ < 0 + var_126_2 + arg_126_0 and not isNil(var_126_1) and arg_123_1.var_.characterEffect4040ui_story then
				arg_123_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_126_4 = 0
			local var_126_5 = 0.75

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= var_126_4 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, true)

				arg_123_1.leftNameTxt_.text = arg_123_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_123_1.leftNameTxt_.transform)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1.leftNameTxt_.text)
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_6 = arg_123_1:GetWordFromCfg(319741030)
				local var_126_7 = arg_123_1:FormatText(var_126_6.content)

				arg_123_1.text_.text = var_126_7

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_9 = 30 <= 0 and var_126_5 or var_126_5 * (utf8.len(var_126_7) / 30)

				if (30 <= 0 and var_126_5 or var_126_5 * (utf8.len(var_126_7) / 30)) > 0 and var_126_5 < var_126_9 then
					arg_123_1.talkMaxDuration = var_126_9

					if var_126_9 + var_126_4 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_9 + var_126_4
					end
				end

				arg_123_1.text_.text = var_126_7
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319741", "319741030", "story_v_out_319741.awb") ~= 0 then
					local var_126_10 = manager.audio:GetVoiceLength("story_v_out_319741", "319741030", "story_v_out_319741.awb") / 1000

					if var_126_10 + var_126_4 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_10 + var_126_4
					end

					if var_126_6.prefab_name ~= "" and arg_123_1.actors_[var_126_6.prefab_name] ~= nil then
						local var_126_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_123_1.actors_[var_126_6.prefab_name].transform, "story_v_out_319741", "319741030", "story_v_out_319741.awb")

						arg_123_1:RecordAudio("319741030", var_126_11)
						arg_123_1:RecordAudio("319741030", var_126_11)
					else
						arg_123_1:AudioAction("play", "voice", "story_v_out_319741", "319741030", "story_v_out_319741.awb")
					end

					arg_123_1:RecordHistoryTalkVoice("story_v_out_319741", "319741030", "story_v_out_319741.awb")
				end

				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_12 = math.max(var_126_5, arg_123_1.talkMaxDuration)

			if var_126_4 <= arg_123_1.time_ and arg_123_1.time_ < var_126_4 + var_126_12 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_4) / var_126_12

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_4 + var_126_12 and arg_123_1.time_ < var_126_4 + var_126_12 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {}

		arg_123_1:InitPlayNodeList()
	end,
	Play319741031 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 319741031
		arg_127_1.duration_ = 3.5

		local var_127_0 = {
			zh = 2.866,
			ja = 3.5
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
				arg_127_0:Play319741032(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 then
				arg_127_1.var_.moveOldPos10079ui_story = arg_127_1.actors_["10079ui_story"].transform.localPosition
			end

			local var_130_0 = 0.001

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_0 then
				arg_127_1.actors_["10079ui_story"].transform.localPosition = Vector3.Lerp(arg_127_1.var_.moveOldPos10079ui_story, Vector3.New(-0.7, -0.95, -6.05), (arg_127_1.time_ - 0) / var_130_0)
				arg_127_1.actors_["10079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_127_1.actors_["10079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_127_1.actors_["10079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_127_1.actors_["10079ui_story"].transform.position).z)
				arg_127_1.actors_["10079ui_story"].transform.localEulerAngles.z = 0
				arg_127_1.actors_["10079ui_story"].transform.localEulerAngles.x = 0
				arg_127_1.actors_["10079ui_story"].transform.localEulerAngles = arg_127_1.actors_["10079ui_story"].transform.localEulerAngles
			end

			if arg_127_1.time_ >= 0 + var_130_0 and arg_127_1.time_ < 0 + var_130_0 + arg_130_0 then
				arg_127_1.actors_["10079ui_story"].transform.localPosition = Vector3.New(-0.7, -0.95, -6.05)
				arg_127_1.actors_["10079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_127_1.actors_["10079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_127_1.actors_["10079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_127_1.actors_["10079ui_story"].transform.position).z)
				arg_127_1.actors_["10079ui_story"].transform.localEulerAngles.z = 0
				arg_127_1.actors_["10079ui_story"].transform.localEulerAngles.x = 0
				arg_127_1.actors_["10079ui_story"].transform.localEulerAngles = arg_127_1.actors_["10079ui_story"].transform.localEulerAngles
			end

			local var_130_1 = arg_127_1.actors_["10079ui_story"]

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 and not isNil(var_130_1) and arg_127_1.var_.characterEffect10079ui_story == nil then
				arg_127_1.var_.characterEffect10079ui_story = var_130_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_130_2 = 0.200000002980232

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_2 and not isNil(var_130_1) then
				if arg_127_1.var_.characterEffect10079ui_story and not isNil(var_130_1) then
					arg_127_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_127_1.time_ >= 0 + var_130_2 and arg_127_1.time_ < 0 + var_130_2 + arg_130_0 and not isNil(var_130_1) and arg_127_1.var_.characterEffect10079ui_story then
				arg_127_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			local var_130_4 = arg_127_1.actors_["4040ui_story"]

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 and not isNil(var_130_4) and arg_127_1.var_.characterEffect4040ui_story == nil then
				arg_127_1.var_.characterEffect4040ui_story = var_130_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_130_5 = 0.200000002980232

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_5 and not isNil(var_130_4) then
				if arg_127_1.var_.characterEffect4040ui_story and not isNil(var_130_4) then
					arg_127_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_127_1.var_.characterEffect4040ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_127_1.time_ - 0) / var_130_5)
				end
			end

			if arg_127_1.time_ >= 0 + var_130_5 and arg_127_1.time_ < 0 + var_130_5 + arg_130_0 and not isNil(var_130_4) and arg_127_1.var_.characterEffect4040ui_story then
				arg_127_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_127_1.var_.characterEffect4040ui_story.fillRatio = 0.5
			end

			local var_130_6 = 0
			local var_130_7 = 0.35

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= var_130_6 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, true)

				arg_127_1.leftNameTxt_.text = arg_127_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_8 = arg_127_1:GetWordFromCfg(319741031)
				local var_130_9 = arg_127_1:FormatText(var_130_8.content)

				arg_127_1.text_.text = var_130_9

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_11 = 14 <= 0 and var_130_7 or var_130_7 * (utf8.len(var_130_9) / 14)

				if (14 <= 0 and var_130_7 or var_130_7 * (utf8.len(var_130_9) / 14)) > 0 and var_130_7 < var_130_11 then
					arg_127_1.talkMaxDuration = var_130_11

					if var_130_11 + var_130_6 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_11 + var_130_6
					end
				end

				arg_127_1.text_.text = var_130_9
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319741", "319741031", "story_v_out_319741.awb") ~= 0 then
					local var_130_12 = manager.audio:GetVoiceLength("story_v_out_319741", "319741031", "story_v_out_319741.awb") / 1000

					if var_130_12 + var_130_6 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_12 + var_130_6
					end

					if var_130_8.prefab_name ~= "" and arg_127_1.actors_[var_130_8.prefab_name] ~= nil then
						local var_130_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_127_1.actors_[var_130_8.prefab_name].transform, "story_v_out_319741", "319741031", "story_v_out_319741.awb")

						arg_127_1:RecordAudio("319741031", var_130_13)
						arg_127_1:RecordAudio("319741031", var_130_13)
					else
						arg_127_1:AudioAction("play", "voice", "story_v_out_319741", "319741031", "story_v_out_319741.awb")
					end

					arg_127_1:RecordHistoryTalkVoice("story_v_out_319741", "319741031", "story_v_out_319741.awb")
				end

				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_14 = math.max(var_130_7, arg_127_1.talkMaxDuration)

			if var_130_6 <= arg_127_1.time_ and arg_127_1.time_ < var_130_6 + var_130_14 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_6) / var_130_14

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_6 + var_130_14 and arg_127_1.time_ < var_130_6 + var_130_14 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {
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

		arg_127_1:InitPlayNodeList()
	end,
	Play319741032 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 319741032
		arg_131_1.duration_ = 2.67

		local var_131_0 = {
			zh = 2.666,
			ja = 2
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
				arg_131_0:Play319741033(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1.var_.moveOldPos4040ui_story = arg_131_1.actors_["4040ui_story"].transform.localPosition
			end

			local var_134_0 = 0.001

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_0 then
				arg_131_1.actors_["4040ui_story"].transform.localPosition = Vector3.Lerp(arg_131_1.var_.moveOldPos4040ui_story, Vector3.New(0.7, -1.55, -5.5), (arg_131_1.time_ - 0) / var_134_0)
				arg_131_1.actors_["4040ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_131_1.actors_["4040ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_131_1.actors_["4040ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_131_1.actors_["4040ui_story"].transform.position).z)
				arg_131_1.actors_["4040ui_story"].transform.localEulerAngles.z = 0
				arg_131_1.actors_["4040ui_story"].transform.localEulerAngles.x = 0
				arg_131_1.actors_["4040ui_story"].transform.localEulerAngles = arg_131_1.actors_["4040ui_story"].transform.localEulerAngles
			end

			if arg_131_1.time_ >= 0 + var_134_0 and arg_131_1.time_ < 0 + var_134_0 + arg_134_0 then
				arg_131_1.actors_["4040ui_story"].transform.localPosition = Vector3.New(0.7, -1.55, -5.5)
				arg_131_1.actors_["4040ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_131_1.actors_["4040ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_131_1.actors_["4040ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_131_1.actors_["4040ui_story"].transform.position).z)
				arg_131_1.actors_["4040ui_story"].transform.localEulerAngles.z = 0
				arg_131_1.actors_["4040ui_story"].transform.localEulerAngles.x = 0
				arg_131_1.actors_["4040ui_story"].transform.localEulerAngles = arg_131_1.actors_["4040ui_story"].transform.localEulerAngles
			end

			local var_134_1 = arg_131_1.actors_["4040ui_story"]

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 and not isNil(var_134_1) and arg_131_1.var_.characterEffect4040ui_story == nil then
				arg_131_1.var_.characterEffect4040ui_story = var_134_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_134_2 = 0.200000002980232

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_2 and not isNil(var_134_1) then
				if arg_131_1.var_.characterEffect4040ui_story and not isNil(var_134_1) then
					arg_131_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_131_1.time_ >= 0 + var_134_2 and arg_131_1.time_ < 0 + var_134_2 + arg_134_0 and not isNil(var_134_1) and arg_131_1.var_.characterEffect4040ui_story then
				arg_131_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_134_4 = arg_131_1.actors_["10079ui_story"]

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 and not isNil(var_134_4) and arg_131_1.var_.characterEffect10079ui_story == nil then
				arg_131_1.var_.characterEffect10079ui_story = var_134_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_134_5 = 0.200000002980232

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_5 and not isNil(var_134_4) then
				if arg_131_1.var_.characterEffect10079ui_story and not isNil(var_134_4) then
					arg_131_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_131_1.var_.characterEffect10079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_131_1.time_ - 0) / var_134_5)
				end
			end

			if arg_131_1.time_ >= 0 + var_134_5 and arg_131_1.time_ < 0 + var_134_5 + arg_134_0 and not isNil(var_134_4) and arg_131_1.var_.characterEffect10079ui_story then
				arg_131_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_131_1.var_.characterEffect10079ui_story.fillRatio = 0.5
			end

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action5_2")
			end

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_134_6 = 0
			local var_134_7 = 0.225

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= var_134_6 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				arg_131_1.leftNameTxt_.text = arg_131_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_8 = arg_131_1:GetWordFromCfg(319741032)
				local var_134_9 = arg_131_1:FormatText(var_134_8.content)

				arg_131_1.text_.text = var_134_9

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_11 = 9 <= 0 and var_134_7 or var_134_7 * (utf8.len(var_134_9) / 9)

				if (9 <= 0 and var_134_7 or var_134_7 * (utf8.len(var_134_9) / 9)) > 0 and var_134_7 < var_134_11 then
					arg_131_1.talkMaxDuration = var_134_11

					if var_134_11 + var_134_6 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_11 + var_134_6
					end
				end

				arg_131_1.text_.text = var_134_9
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319741", "319741032", "story_v_out_319741.awb") ~= 0 then
					local var_134_12 = manager.audio:GetVoiceLength("story_v_out_319741", "319741032", "story_v_out_319741.awb") / 1000

					if var_134_12 + var_134_6 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_12 + var_134_6
					end

					if var_134_8.prefab_name ~= "" and arg_131_1.actors_[var_134_8.prefab_name] ~= nil then
						local var_134_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_131_1.actors_[var_134_8.prefab_name].transform, "story_v_out_319741", "319741032", "story_v_out_319741.awb")

						arg_131_1:RecordAudio("319741032", var_134_13)
						arg_131_1:RecordAudio("319741032", var_134_13)
					else
						arg_131_1:AudioAction("play", "voice", "story_v_out_319741", "319741032", "story_v_out_319741.awb")
					end

					arg_131_1:RecordHistoryTalkVoice("story_v_out_319741", "319741032", "story_v_out_319741.awb")
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
				actorName = "4040ui_story",
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
	Play319741033 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 319741033
		arg_135_1.duration_ = 3.47

		local var_135_0 = {
			zh = 3.3,
			ja = 3.466
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
				arg_135_0:Play319741034(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 and not isNil(arg_135_1.actors_["4040ui_story"]) and arg_135_1.var_.characterEffect4040ui_story == nil then
				arg_135_1.var_.characterEffect4040ui_story = arg_135_1.actors_["4040ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_138_0 = 0.200000002980232

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_0 and not isNil(arg_135_1.actors_["4040ui_story"]) then
				if arg_135_1.var_.characterEffect4040ui_story and not isNil(arg_135_1.actors_["4040ui_story"]) then
					arg_135_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_135_1.var_.characterEffect4040ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_135_1.time_ - 0) / var_138_0)
				end
			end

			if arg_135_1.time_ >= 0 + var_138_0 and arg_135_1.time_ < 0 + var_138_0 + arg_138_0 and not isNil(arg_135_1.actors_["4040ui_story"]) and arg_135_1.var_.characterEffect4040ui_story then
				arg_135_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_135_1.var_.characterEffect4040ui_story.fillRatio = 0.5
			end

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				arg_135_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action12_1")
			end

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				arg_135_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_138_1 = arg_135_1.actors_["10079ui_story"]

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 and not isNil(var_138_1) and arg_135_1.var_.characterEffect10079ui_story == nil then
				arg_135_1.var_.characterEffect10079ui_story = var_138_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_138_2 = 0.200000002980232

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_2 and not isNil(var_138_1) then
				if arg_135_1.var_.characterEffect10079ui_story and not isNil(var_138_1) then
					arg_135_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_135_1.time_ >= 0 + var_138_2 and arg_135_1.time_ < 0 + var_138_2 + arg_138_0 and not isNil(var_138_1) and arg_135_1.var_.characterEffect10079ui_story then
				arg_135_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			local var_138_4 = 0
			local var_138_5 = 0.4

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= var_138_4 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				arg_135_1.leftNameTxt_.text = arg_135_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_6 = arg_135_1:GetWordFromCfg(319741033)
				local var_138_7 = arg_135_1:FormatText(var_138_6.content)

				arg_135_1.text_.text = var_138_7

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_9 = 16 <= 0 and var_138_5 or var_138_5 * (utf8.len(var_138_7) / 16)

				if (16 <= 0 and var_138_5 or var_138_5 * (utf8.len(var_138_7) / 16)) > 0 and var_138_5 < var_138_9 then
					arg_135_1.talkMaxDuration = var_138_9

					if var_138_9 + var_138_4 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_9 + var_138_4
					end
				end

				arg_135_1.text_.text = var_138_7
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319741", "319741033", "story_v_out_319741.awb") ~= 0 then
					local var_138_10 = manager.audio:GetVoiceLength("story_v_out_319741", "319741033", "story_v_out_319741.awb") / 1000

					if var_138_10 + var_138_4 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_10 + var_138_4
					end

					if var_138_6.prefab_name ~= "" and arg_135_1.actors_[var_138_6.prefab_name] ~= nil then
						local var_138_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_135_1.actors_[var_138_6.prefab_name].transform, "story_v_out_319741", "319741033", "story_v_out_319741.awb")

						arg_135_1:RecordAudio("319741033", var_138_11)
						arg_135_1:RecordAudio("319741033", var_138_11)
					else
						arg_135_1:AudioAction("play", "voice", "story_v_out_319741", "319741033", "story_v_out_319741.awb")
					end

					arg_135_1:RecordHistoryTalkVoice("story_v_out_319741", "319741033", "story_v_out_319741.awb")
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

		arg_135_1.nodeConfigList_ = {}

		arg_135_1:InitPlayNodeList()
	end,
	Play319741034 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 319741034
		arg_139_1.duration_ = 15.57

		local var_139_0 = {
			zh = 10.433,
			ja = 15.566
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
				arg_139_0:Play319741035(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			local var_142_0 = 1.425

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				arg_139_1.leftNameTxt_.text = arg_139_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_1 = arg_139_1:GetWordFromCfg(319741034)
				local var_142_2 = arg_139_1:FormatText(var_142_1.content)

				arg_139_1.text_.text = var_142_2

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_4 = 57 <= 0 and var_142_0 or var_142_0 * (utf8.len(var_142_2) / 57)

				if (57 <= 0 and var_142_0 or var_142_0 * (utf8.len(var_142_2) / 57)) > 0 and var_142_0 < var_142_4 then
					arg_139_1.talkMaxDuration = var_142_4

					if var_142_4 + 0 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_4 + 0
					end
				end

				arg_139_1.text_.text = var_142_2
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319741", "319741034", "story_v_out_319741.awb") ~= 0 then
					local var_142_5 = manager.audio:GetVoiceLength("story_v_out_319741", "319741034", "story_v_out_319741.awb") / 1000

					if var_142_5 + 0 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_5 + 0
					end

					if var_142_1.prefab_name ~= "" and arg_139_1.actors_[var_142_1.prefab_name] ~= nil then
						local var_142_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_139_1.actors_[var_142_1.prefab_name].transform, "story_v_out_319741", "319741034", "story_v_out_319741.awb")

						arg_139_1:RecordAudio("319741034", var_142_6)
						arg_139_1:RecordAudio("319741034", var_142_6)
					else
						arg_139_1:AudioAction("play", "voice", "story_v_out_319741", "319741034", "story_v_out_319741.awb")
					end

					arg_139_1:RecordHistoryTalkVoice("story_v_out_319741", "319741034", "story_v_out_319741.awb")
				end

				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_7 = math.max(var_142_0, arg_139_1.talkMaxDuration)

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_7 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - 0) / var_142_7

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= 0 + var_142_7 and arg_139_1.time_ < 0 + var_142_7 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {}

		arg_139_1:InitPlayNodeList()
	end,
	Play319741035 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 319741035
		arg_143_1.duration_ = 4.2

		local var_143_0 = {
			zh = 3.533,
			ja = 4.2
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
				arg_143_0:Play319741036(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 and not isNil(arg_143_1.actors_["10079ui_story"]) and arg_143_1.var_.characterEffect10079ui_story == nil then
				arg_143_1.var_.characterEffect10079ui_story = arg_143_1.actors_["10079ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_146_0 = 0.200000002980232

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_0 and not isNil(arg_143_1.actors_["10079ui_story"]) then
				if arg_143_1.var_.characterEffect10079ui_story and not isNil(arg_143_1.actors_["10079ui_story"]) then
					arg_143_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_143_1.var_.characterEffect10079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_143_1.time_ - 0) / var_146_0)
				end
			end

			if arg_143_1.time_ >= 0 + var_146_0 and arg_143_1.time_ < 0 + var_146_0 + arg_146_0 and not isNil(arg_143_1.actors_["10079ui_story"]) and arg_143_1.var_.characterEffect10079ui_story then
				arg_143_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_143_1.var_.characterEffect10079ui_story.fillRatio = 0.5
			end

			local var_146_1 = arg_143_1.actors_["4040ui_story"]

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 and not isNil(var_146_1) and arg_143_1.var_.characterEffect4040ui_story == nil then
				arg_143_1.var_.characterEffect4040ui_story = var_146_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_146_2 = 0.200000002980232

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_2 and not isNil(var_146_1) then
				if arg_143_1.var_.characterEffect4040ui_story and not isNil(var_146_1) then
					arg_143_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_143_1.time_ >= 0 + var_146_2 and arg_143_1.time_ < 0 + var_146_2 + arg_146_0 and not isNil(var_146_1) and arg_143_1.var_.characterEffect4040ui_story then
				arg_143_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action7_1")
			end

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_146_4 = 0
			local var_146_5 = 0.325

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= var_146_4 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				arg_143_1.leftNameTxt_.text = arg_143_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, false)
				arg_143_1.callingController_:SetSelectedState("normal")

				local var_146_6 = arg_143_1:GetWordFromCfg(319741035)
				local var_146_7 = arg_143_1:FormatText(var_146_6.content)

				arg_143_1.text_.text = var_146_7

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_9 = 13 <= 0 and var_146_5 or var_146_5 * (utf8.len(var_146_7) / 13)

				if (13 <= 0 and var_146_5 or var_146_5 * (utf8.len(var_146_7) / 13)) > 0 and var_146_5 < var_146_9 then
					arg_143_1.talkMaxDuration = var_146_9

					if var_146_9 + var_146_4 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_9 + var_146_4
					end
				end

				arg_143_1.text_.text = var_146_7
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319741", "319741035", "story_v_out_319741.awb") ~= 0 then
					local var_146_10 = manager.audio:GetVoiceLength("story_v_out_319741", "319741035", "story_v_out_319741.awb") / 1000

					if var_146_10 + var_146_4 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_10 + var_146_4
					end

					if var_146_6.prefab_name ~= "" and arg_143_1.actors_[var_146_6.prefab_name] ~= nil then
						local var_146_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_143_1.actors_[var_146_6.prefab_name].transform, "story_v_out_319741", "319741035", "story_v_out_319741.awb")

						arg_143_1:RecordAudio("319741035", var_146_11)
						arg_143_1:RecordAudio("319741035", var_146_11)
					else
						arg_143_1:AudioAction("play", "voice", "story_v_out_319741", "319741035", "story_v_out_319741.awb")
					end

					arg_143_1:RecordHistoryTalkVoice("story_v_out_319741", "319741035", "story_v_out_319741.awb")
				end

				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_12 = math.max(var_146_5, arg_143_1.talkMaxDuration)

			if var_146_4 <= arg_143_1.time_ and arg_143_1.time_ < var_146_4 + var_146_12 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_4) / var_146_12

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_4 + var_146_12 and arg_143_1.time_ < var_146_4 + var_146_12 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {}

		arg_143_1:InitPlayNodeList()
	end,
	Play319741036 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 319741036
		arg_147_1.duration_ = 4.07

		local var_147_0 = {
			zh = 3,
			ja = 4.066
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
				arg_147_0:Play319741037(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 and not isNil(arg_147_1.actors_["4040ui_story"]) and arg_147_1.var_.characterEffect4040ui_story == nil then
				arg_147_1.var_.characterEffect4040ui_story = arg_147_1.actors_["4040ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_150_0 = 0.200000002980232

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_0 and not isNil(arg_147_1.actors_["4040ui_story"]) then
				if arg_147_1.var_.characterEffect4040ui_story and not isNil(arg_147_1.actors_["4040ui_story"]) then
					arg_147_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_147_1.var_.characterEffect4040ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_147_1.time_ - 0) / var_150_0)
				end
			end

			if arg_147_1.time_ >= 0 + var_150_0 and arg_147_1.time_ < 0 + var_150_0 + arg_150_0 and not isNil(arg_147_1.actors_["4040ui_story"]) and arg_147_1.var_.characterEffect4040ui_story then
				arg_147_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_147_1.var_.characterEffect4040ui_story.fillRatio = 0.5
			end

			local var_150_1 = arg_147_1.actors_["10079ui_story"]

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 and not isNil(var_150_1) and arg_147_1.var_.characterEffect10079ui_story == nil then
				arg_147_1.var_.characterEffect10079ui_story = var_150_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_150_2 = 0.200000002980232

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_2 and not isNil(var_150_1) then
				if arg_147_1.var_.characterEffect10079ui_story and not isNil(var_150_1) then
					arg_147_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_147_1.time_ >= 0 + var_150_2 and arg_147_1.time_ < 0 + var_150_2 + arg_150_0 and not isNil(var_150_1) and arg_147_1.var_.characterEffect10079ui_story then
				arg_147_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			local var_150_4 = 0
			local var_150_5 = 0.325

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= var_150_4 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, true)

				arg_147_1.leftNameTxt_.text = arg_147_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_6 = arg_147_1:GetWordFromCfg(319741036)
				local var_150_7 = arg_147_1:FormatText(var_150_6.content)

				arg_147_1.text_.text = var_150_7

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_9 = 13 <= 0 and var_150_5 or var_150_5 * (utf8.len(var_150_7) / 13)

				if (13 <= 0 and var_150_5 or var_150_5 * (utf8.len(var_150_7) / 13)) > 0 and var_150_5 < var_150_9 then
					arg_147_1.talkMaxDuration = var_150_9

					if var_150_9 + var_150_4 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_9 + var_150_4
					end
				end

				arg_147_1.text_.text = var_150_7
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319741", "319741036", "story_v_out_319741.awb") ~= 0 then
					local var_150_10 = manager.audio:GetVoiceLength("story_v_out_319741", "319741036", "story_v_out_319741.awb") / 1000

					if var_150_10 + var_150_4 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_10 + var_150_4
					end

					if var_150_6.prefab_name ~= "" and arg_147_1.actors_[var_150_6.prefab_name] ~= nil then
						local var_150_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_147_1.actors_[var_150_6.prefab_name].transform, "story_v_out_319741", "319741036", "story_v_out_319741.awb")

						arg_147_1:RecordAudio("319741036", var_150_11)
						arg_147_1:RecordAudio("319741036", var_150_11)
					else
						arg_147_1:AudioAction("play", "voice", "story_v_out_319741", "319741036", "story_v_out_319741.awb")
					end

					arg_147_1:RecordHistoryTalkVoice("story_v_out_319741", "319741036", "story_v_out_319741.awb")
				end

				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_12 = math.max(var_150_5, arg_147_1.talkMaxDuration)

			if var_150_4 <= arg_147_1.time_ and arg_147_1.time_ < var_150_4 + var_150_12 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_4) / var_150_12

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_4 + var_150_12 and arg_147_1.time_ < var_150_4 + var_150_12 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {}

		arg_147_1:InitPlayNodeList()
	end,
	Play319741037 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 319741037
		arg_151_1.duration_ = 1.8

		local var_151_0 = {
			zh = 1.8,
			ja = 1.666
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
				arg_151_0:Play319741038(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 and not isNil(arg_151_1.actors_["10079ui_story"]) and arg_151_1.var_.characterEffect10079ui_story == nil then
				arg_151_1.var_.characterEffect10079ui_story = arg_151_1.actors_["10079ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_154_0 = 0.200000002980232

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_0 and not isNil(arg_151_1.actors_["10079ui_story"]) then
				if arg_151_1.var_.characterEffect10079ui_story and not isNil(arg_151_1.actors_["10079ui_story"]) then
					arg_151_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_151_1.var_.characterEffect10079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_151_1.time_ - 0) / var_154_0)
				end
			end

			if arg_151_1.time_ >= 0 + var_154_0 and arg_151_1.time_ < 0 + var_154_0 + arg_154_0 and not isNil(arg_151_1.actors_["10079ui_story"]) and arg_151_1.var_.characterEffect10079ui_story then
				arg_151_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_151_1.var_.characterEffect10079ui_story.fillRatio = 0.5
			end

			local var_154_1 = arg_151_1.actors_["4040ui_story"]

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 and not isNil(var_154_1) and arg_151_1.var_.characterEffect4040ui_story == nil then
				arg_151_1.var_.characterEffect4040ui_story = var_154_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_154_2 = 0.200000002980232

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_2 and not isNil(var_154_1) then
				if arg_151_1.var_.characterEffect4040ui_story and not isNil(var_154_1) then
					arg_151_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_151_1.time_ >= 0 + var_154_2 and arg_151_1.time_ < 0 + var_154_2 + arg_154_0 and not isNil(var_154_1) and arg_151_1.var_.characterEffect4040ui_story then
				arg_151_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_154_4 = 0
			local var_154_5 = 0.15

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= var_154_4 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				arg_151_1.leftNameTxt_.text = arg_151_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, false)
				arg_151_1.callingController_:SetSelectedState("normal")

				local var_154_6 = arg_151_1:GetWordFromCfg(319741037)
				local var_154_7 = arg_151_1:FormatText(var_154_6.content)

				arg_151_1.text_.text = var_154_7

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_9 = 6 <= 0 and var_154_5 or var_154_5 * (utf8.len(var_154_7) / 6)

				if (6 <= 0 and var_154_5 or var_154_5 * (utf8.len(var_154_7) / 6)) > 0 and var_154_5 < var_154_9 then
					arg_151_1.talkMaxDuration = var_154_9

					if var_154_9 + var_154_4 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_9 + var_154_4
					end
				end

				arg_151_1.text_.text = var_154_7
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319741", "319741037", "story_v_out_319741.awb") ~= 0 then
					local var_154_10 = manager.audio:GetVoiceLength("story_v_out_319741", "319741037", "story_v_out_319741.awb") / 1000

					if var_154_10 + var_154_4 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_10 + var_154_4
					end

					if var_154_6.prefab_name ~= "" and arg_151_1.actors_[var_154_6.prefab_name] ~= nil then
						local var_154_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_151_1.actors_[var_154_6.prefab_name].transform, "story_v_out_319741", "319741037", "story_v_out_319741.awb")

						arg_151_1:RecordAudio("319741037", var_154_11)
						arg_151_1:RecordAudio("319741037", var_154_11)
					else
						arg_151_1:AudioAction("play", "voice", "story_v_out_319741", "319741037", "story_v_out_319741.awb")
					end

					arg_151_1:RecordHistoryTalkVoice("story_v_out_319741", "319741037", "story_v_out_319741.awb")
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

		arg_151_1.nodeConfigList_ = {}

		arg_151_1:InitPlayNodeList()
	end,
	Play319741038 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 319741038
		arg_155_1.duration_ = 8.33

		local var_155_0 = {
			zh = 5.733,
			ja = 8.333
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
				arg_155_0:Play319741039(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 then
				arg_155_1.var_.moveOldPos10079ui_story = arg_155_1.actors_["10079ui_story"].transform.localPosition
			end

			local var_158_0 = 0.001

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_0 then
				arg_155_1.actors_["10079ui_story"].transform.localPosition = Vector3.Lerp(arg_155_1.var_.moveOldPos10079ui_story, Vector3.New(-0.7, -0.95, -6.05), (arg_155_1.time_ - 0) / var_158_0)
				arg_155_1.actors_["10079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_155_1.actors_["10079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_155_1.actors_["10079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_155_1.actors_["10079ui_story"].transform.position).z)
				arg_155_1.actors_["10079ui_story"].transform.localEulerAngles.z = 0
				arg_155_1.actors_["10079ui_story"].transform.localEulerAngles.x = 0
				arg_155_1.actors_["10079ui_story"].transform.localEulerAngles = arg_155_1.actors_["10079ui_story"].transform.localEulerAngles
			end

			if arg_155_1.time_ >= 0 + var_158_0 and arg_155_1.time_ < 0 + var_158_0 + arg_158_0 then
				arg_155_1.actors_["10079ui_story"].transform.localPosition = Vector3.New(-0.7, -0.95, -6.05)
				arg_155_1.actors_["10079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_155_1.actors_["10079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_155_1.actors_["10079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_155_1.actors_["10079ui_story"].transform.position).z)
				arg_155_1.actors_["10079ui_story"].transform.localEulerAngles.z = 0
				arg_155_1.actors_["10079ui_story"].transform.localEulerAngles.x = 0
				arg_155_1.actors_["10079ui_story"].transform.localEulerAngles = arg_155_1.actors_["10079ui_story"].transform.localEulerAngles
			end

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 then
				arg_155_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action12_2")
			end

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 then
				arg_155_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_158_1 = arg_155_1.actors_["4040ui_story"]

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 and not isNil(var_158_1) and arg_155_1.var_.characterEffect4040ui_story == nil then
				arg_155_1.var_.characterEffect4040ui_story = var_158_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_158_2 = 0.200000002980232

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_2 and not isNil(var_158_1) then
				if arg_155_1.var_.characterEffect4040ui_story and not isNil(var_158_1) then
					arg_155_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_155_1.var_.characterEffect4040ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_155_1.time_ - 0) / var_158_2)
				end
			end

			if arg_155_1.time_ >= 0 + var_158_2 and arg_155_1.time_ < 0 + var_158_2 + arg_158_0 and not isNil(var_158_1) and arg_155_1.var_.characterEffect4040ui_story then
				arg_155_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_155_1.var_.characterEffect4040ui_story.fillRatio = 0.5
			end

			local var_158_3 = arg_155_1.actors_["10079ui_story"]

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 and not isNil(var_158_3) and arg_155_1.var_.characterEffect10079ui_story == nil then
				arg_155_1.var_.characterEffect10079ui_story = var_158_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_158_4 = 0.200000002980232

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_4 and not isNil(var_158_3) then
				if arg_155_1.var_.characterEffect10079ui_story and not isNil(var_158_3) then
					arg_155_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_155_1.time_ >= 0 + var_158_4 and arg_155_1.time_ < 0 + var_158_4 + arg_158_0 and not isNil(var_158_3) and arg_155_1.var_.characterEffect10079ui_story then
				arg_155_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			local var_158_6 = 0
			local var_158_7 = 0.7

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= var_158_6 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, true)

				arg_155_1.leftNameTxt_.text = arg_155_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_8 = arg_155_1:GetWordFromCfg(319741038)
				local var_158_9 = arg_155_1:FormatText(var_158_8.content)

				arg_155_1.text_.text = var_158_9

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_11 = 28 <= 0 and var_158_7 or var_158_7 * (utf8.len(var_158_9) / 28)

				if (28 <= 0 and var_158_7 or var_158_7 * (utf8.len(var_158_9) / 28)) > 0 and var_158_7 < var_158_11 then
					arg_155_1.talkMaxDuration = var_158_11

					if var_158_11 + var_158_6 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_11 + var_158_6
					end
				end

				arg_155_1.text_.text = var_158_9
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319741", "319741038", "story_v_out_319741.awb") ~= 0 then
					local var_158_12 = manager.audio:GetVoiceLength("story_v_out_319741", "319741038", "story_v_out_319741.awb") / 1000

					if var_158_12 + var_158_6 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_12 + var_158_6
					end

					if var_158_8.prefab_name ~= "" and arg_155_1.actors_[var_158_8.prefab_name] ~= nil then
						local var_158_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_155_1.actors_[var_158_8.prefab_name].transform, "story_v_out_319741", "319741038", "story_v_out_319741.awb")

						arg_155_1:RecordAudio("319741038", var_158_13)
						arg_155_1:RecordAudio("319741038", var_158_13)
					else
						arg_155_1:AudioAction("play", "voice", "story_v_out_319741", "319741038", "story_v_out_319741.awb")
					end

					arg_155_1:RecordHistoryTalkVoice("story_v_out_319741", "319741038", "story_v_out_319741.awb")
				end

				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_14 = math.max(var_158_7, arg_155_1.talkMaxDuration)

			if var_158_6 <= arg_155_1.time_ and arg_155_1.time_ < var_158_6 + var_158_14 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - var_158_6) / var_158_14

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= var_158_6 + var_158_14 and arg_155_1.time_ < var_158_6 + var_158_14 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {
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

		arg_155_1:InitPlayNodeList()
	end,
	Play319741039 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 319741039
		arg_159_1.duration_ = 5

		SetActive(arg_159_1.tipsGo_, false)

		function arg_159_1.onSingleLineFinish_()
			arg_159_1.onSingleLineUpdate_ = nil
			arg_159_1.onSingleLineFinish_ = nil
			arg_159_1.state_ = "waiting"
		end

		function arg_159_1.playNext_(arg_161_0)
			if arg_161_0 == 1 then
				arg_159_0:Play319741040(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 and not isNil(arg_159_1.actors_["10079ui_story"]) and arg_159_1.var_.characterEffect10079ui_story == nil then
				arg_159_1.var_.characterEffect10079ui_story = arg_159_1.actors_["10079ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_162_0 = 0.200000002980232

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_0 and not isNil(arg_159_1.actors_["10079ui_story"]) then
				if arg_159_1.var_.characterEffect10079ui_story and not isNil(arg_159_1.actors_["10079ui_story"]) then
					arg_159_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_159_1.var_.characterEffect10079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_159_1.time_ - 0) / var_162_0)
				end
			end

			if arg_159_1.time_ >= 0 + var_162_0 and arg_159_1.time_ < 0 + var_162_0 + arg_162_0 and not isNil(arg_159_1.actors_["10079ui_story"]) and arg_159_1.var_.characterEffect10079ui_story then
				arg_159_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_159_1.var_.characterEffect10079ui_story.fillRatio = 0.5
			end

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action7_2")
			end

			local var_162_1 = 0
			local var_162_2 = 1.725

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= var_162_1 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, false)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_159_1.iconTrs_.gameObject, false)
				arg_159_1.callingController_:SetSelectedState("normal")

				local var_162_3 = arg_159_1:FormatText(arg_159_1:GetWordFromCfg(319741039).content)

				arg_159_1.text_.text = var_162_3

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_5 = 69 <= 0 and var_162_2 or var_162_2 * (utf8.len(var_162_3) / 69)

				if (69 <= 0 and var_162_2 or var_162_2 * (utf8.len(var_162_3) / 69)) > 0 and var_162_2 < var_162_5 then
					arg_159_1.talkMaxDuration = var_162_5

					if var_162_5 + var_162_1 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_5 + var_162_1
					end
				end

				arg_159_1.text_.text = var_162_3
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)
				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_6 = math.max(var_162_2, arg_159_1.talkMaxDuration)

			if var_162_1 <= arg_159_1.time_ and arg_159_1.time_ < var_162_1 + var_162_6 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_1) / var_162_6

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_1 + var_162_6 and arg_159_1.time_ < var_162_1 + var_162_6 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {}

		arg_159_1:InitPlayNodeList()
	end,
	Play319741040 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 319741040
		arg_163_1.duration_ = 5.13

		local var_163_0 = {
			zh = 5.133,
			ja = 4.266
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
				arg_163_0:Play319741041(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 then
				arg_163_1.var_.moveOldPos4040ui_story = arg_163_1.actors_["4040ui_story"].transform.localPosition
			end

			local var_166_0 = 0.001

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_0 then
				arg_163_1.actors_["4040ui_story"].transform.localPosition = Vector3.Lerp(arg_163_1.var_.moveOldPos4040ui_story, Vector3.New(0.7, -1.55, -5.5), (arg_163_1.time_ - 0) / var_166_0)
				arg_163_1.actors_["4040ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_163_1.actors_["4040ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_163_1.actors_["4040ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_163_1.actors_["4040ui_story"].transform.position).z)
				arg_163_1.actors_["4040ui_story"].transform.localEulerAngles.z = 0
				arg_163_1.actors_["4040ui_story"].transform.localEulerAngles.x = 0
				arg_163_1.actors_["4040ui_story"].transform.localEulerAngles = arg_163_1.actors_["4040ui_story"].transform.localEulerAngles
			end

			if arg_163_1.time_ >= 0 + var_166_0 and arg_163_1.time_ < 0 + var_166_0 + arg_166_0 then
				arg_163_1.actors_["4040ui_story"].transform.localPosition = Vector3.New(0.7, -1.55, -5.5)
				arg_163_1.actors_["4040ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_163_1.actors_["4040ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_163_1.actors_["4040ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_163_1.actors_["4040ui_story"].transform.position).z)
				arg_163_1.actors_["4040ui_story"].transform.localEulerAngles.z = 0
				arg_163_1.actors_["4040ui_story"].transform.localEulerAngles.x = 0
				arg_163_1.actors_["4040ui_story"].transform.localEulerAngles = arg_163_1.actors_["4040ui_story"].transform.localEulerAngles
			end

			local var_166_1 = arg_163_1.actors_["4040ui_story"]

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 and not isNil(var_166_1) and arg_163_1.var_.characterEffect4040ui_story == nil then
				arg_163_1.var_.characterEffect4040ui_story = var_166_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_166_2 = 0.200000002980232

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_2 and not isNil(var_166_1) then
				if arg_163_1.var_.characterEffect4040ui_story and not isNil(var_166_1) then
					arg_163_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_163_1.time_ >= 0 + var_166_2 and arg_163_1.time_ < 0 + var_166_2 + arg_166_0 and not isNil(var_166_1) and arg_163_1.var_.characterEffect4040ui_story then
				arg_163_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 then
				arg_163_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_166_4 = 0
			local var_166_5 = 0.6

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= var_166_4 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, true)

				arg_163_1.leftNameTxt_.text = arg_163_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_163_1.leftNameTxt_.transform)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1.leftNameTxt_.text)
				SetActive(arg_163_1.iconTrs_.gameObject, false)
				arg_163_1.callingController_:SetSelectedState("normal")

				local var_166_6 = arg_163_1:GetWordFromCfg(319741040)
				local var_166_7 = arg_163_1:FormatText(var_166_6.content)

				arg_163_1.text_.text = var_166_7

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_9 = 24 <= 0 and var_166_5 or var_166_5 * (utf8.len(var_166_7) / 24)

				if (24 <= 0 and var_166_5 or var_166_5 * (utf8.len(var_166_7) / 24)) > 0 and var_166_5 < var_166_9 then
					arg_163_1.talkMaxDuration = var_166_9

					if var_166_9 + var_166_4 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_9 + var_166_4
					end
				end

				arg_163_1.text_.text = var_166_7
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319741", "319741040", "story_v_out_319741.awb") ~= 0 then
					local var_166_10 = manager.audio:GetVoiceLength("story_v_out_319741", "319741040", "story_v_out_319741.awb") / 1000

					if var_166_10 + var_166_4 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_10 + var_166_4
					end

					if var_166_6.prefab_name ~= "" and arg_163_1.actors_[var_166_6.prefab_name] ~= nil then
						local var_166_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_163_1.actors_[var_166_6.prefab_name].transform, "story_v_out_319741", "319741040", "story_v_out_319741.awb")

						arg_163_1:RecordAudio("319741040", var_166_11)
						arg_163_1:RecordAudio("319741040", var_166_11)
					else
						arg_163_1:AudioAction("play", "voice", "story_v_out_319741", "319741040", "story_v_out_319741.awb")
					end

					arg_163_1:RecordHistoryTalkVoice("story_v_out_319741", "319741040", "story_v_out_319741.awb")
				end

				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_12 = math.max(var_166_5, arg_163_1.talkMaxDuration)

			if var_166_4 <= arg_163_1.time_ and arg_163_1.time_ < var_166_4 + var_166_12 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - var_166_4) / var_166_12

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= var_166_4 + var_166_12 and arg_163_1.time_ < var_166_4 + var_166_12 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {
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

		arg_163_1:InitPlayNodeList()
	end,
	Play319741041 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 319741041
		arg_167_1.duration_ = 12.03

		local var_167_0 = {
			zh = 8.733,
			ja = 12.033
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
				arg_167_0:Play319741042(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			local var_170_0 = 1.05

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, true)

				arg_167_1.leftNameTxt_.text = arg_167_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, false)
				arg_167_1.callingController_:SetSelectedState("normal")

				local var_170_1 = arg_167_1:GetWordFromCfg(319741041)
				local var_170_2 = arg_167_1:FormatText(var_170_1.content)

				arg_167_1.text_.text = var_170_2

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_4 = 42 <= 0 and var_170_0 or var_170_0 * (utf8.len(var_170_2) / 42)

				if (42 <= 0 and var_170_0 or var_170_0 * (utf8.len(var_170_2) / 42)) > 0 and var_170_0 < var_170_4 then
					arg_167_1.talkMaxDuration = var_170_4

					if var_170_4 + 0 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_4 + 0
					end
				end

				arg_167_1.text_.text = var_170_2
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319741", "319741041", "story_v_out_319741.awb") ~= 0 then
					local var_170_5 = manager.audio:GetVoiceLength("story_v_out_319741", "319741041", "story_v_out_319741.awb") / 1000

					if var_170_5 + 0 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_5 + 0
					end

					if var_170_1.prefab_name ~= "" and arg_167_1.actors_[var_170_1.prefab_name] ~= nil then
						local var_170_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_167_1.actors_[var_170_1.prefab_name].transform, "story_v_out_319741", "319741041", "story_v_out_319741.awb")

						arg_167_1:RecordAudio("319741041", var_170_6)
						arg_167_1:RecordAudio("319741041", var_170_6)
					else
						arg_167_1:AudioAction("play", "voice", "story_v_out_319741", "319741041", "story_v_out_319741.awb")
					end

					arg_167_1:RecordHistoryTalkVoice("story_v_out_319741", "319741041", "story_v_out_319741.awb")
				end

				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_7 = math.max(var_170_0, arg_167_1.talkMaxDuration)

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_7 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - 0) / var_170_7

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= 0 + var_170_7 and arg_167_1.time_ < 0 + var_170_7 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {}

		arg_167_1:InitPlayNodeList()
	end,
	Play319741042 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 319741042
		arg_171_1.duration_ = 10.63

		local var_171_0 = {
			zh = 2.9,
			ja = 10.633
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
				arg_171_0:Play319741043(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 and not isNil(arg_171_1.actors_["4040ui_story"]) and arg_171_1.var_.characterEffect4040ui_story == nil then
				arg_171_1.var_.characterEffect4040ui_story = arg_171_1.actors_["4040ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_174_0 = 0.200000002980232

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_0 and not isNil(arg_171_1.actors_["4040ui_story"]) then
				if arg_171_1.var_.characterEffect4040ui_story and not isNil(arg_171_1.actors_["4040ui_story"]) then
					arg_171_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_171_1.var_.characterEffect4040ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_171_1.time_ - 0) / var_174_0)
				end
			end

			if arg_171_1.time_ >= 0 + var_174_0 and arg_171_1.time_ < 0 + var_174_0 + arg_174_0 and not isNil(arg_171_1.actors_["4040ui_story"]) and arg_171_1.var_.characterEffect4040ui_story then
				arg_171_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_171_1.var_.characterEffect4040ui_story.fillRatio = 0.5
			end

			local var_174_1 = arg_171_1.actors_["10079ui_story"]

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 and not isNil(var_174_1) and arg_171_1.var_.characterEffect10079ui_story == nil then
				arg_171_1.var_.characterEffect10079ui_story = var_174_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_174_2 = 0.200000002980232

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_2 and not isNil(var_174_1) then
				if arg_171_1.var_.characterEffect10079ui_story and not isNil(var_174_1) then
					arg_171_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_171_1.time_ >= 0 + var_174_2 and arg_171_1.time_ < 0 + var_174_2 + arg_174_0 and not isNil(var_174_1) and arg_171_1.var_.characterEffect10079ui_story then
				arg_171_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			local var_174_4 = 0
			local var_174_5 = 0.35

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= var_174_4 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, true)

				arg_171_1.leftNameTxt_.text = arg_171_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_171_1.leftNameTxt_.transform)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1.leftNameTxt_.text)
				SetActive(arg_171_1.iconTrs_.gameObject, false)
				arg_171_1.callingController_:SetSelectedState("normal")

				local var_174_6 = arg_171_1:GetWordFromCfg(319741042)
				local var_174_7 = arg_171_1:FormatText(var_174_6.content)

				arg_171_1.text_.text = var_174_7

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_9 = 14 <= 0 and var_174_5 or var_174_5 * (utf8.len(var_174_7) / 14)

				if (14 <= 0 and var_174_5 or var_174_5 * (utf8.len(var_174_7) / 14)) > 0 and var_174_5 < var_174_9 then
					arg_171_1.talkMaxDuration = var_174_9

					if var_174_9 + var_174_4 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_9 + var_174_4
					end
				end

				arg_171_1.text_.text = var_174_7
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319741", "319741042", "story_v_out_319741.awb") ~= 0 then
					local var_174_10 = manager.audio:GetVoiceLength("story_v_out_319741", "319741042", "story_v_out_319741.awb") / 1000

					if var_174_10 + var_174_4 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_10 + var_174_4
					end

					if var_174_6.prefab_name ~= "" and arg_171_1.actors_[var_174_6.prefab_name] ~= nil then
						local var_174_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_171_1.actors_[var_174_6.prefab_name].transform, "story_v_out_319741", "319741042", "story_v_out_319741.awb")

						arg_171_1:RecordAudio("319741042", var_174_11)
						arg_171_1:RecordAudio("319741042", var_174_11)
					else
						arg_171_1:AudioAction("play", "voice", "story_v_out_319741", "319741042", "story_v_out_319741.awb")
					end

					arg_171_1:RecordHistoryTalkVoice("story_v_out_319741", "319741042", "story_v_out_319741.awb")
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

		arg_171_1.nodeConfigList_ = {}

		arg_171_1:InitPlayNodeList()
	end,
	Play319741043 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 319741043
		arg_175_1.duration_ = 6.17

		local var_175_0 = {
			zh = 5.366,
			ja = 6.166
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
				arg_175_0:Play319741044(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 and not isNil(arg_175_1.actors_["10079ui_story"]) and arg_175_1.var_.characterEffect10079ui_story == nil then
				arg_175_1.var_.characterEffect10079ui_story = arg_175_1.actors_["10079ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_178_0 = 0.200000002980232

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_0 and not isNil(arg_175_1.actors_["10079ui_story"]) then
				if arg_175_1.var_.characterEffect10079ui_story and not isNil(arg_175_1.actors_["10079ui_story"]) then
					arg_175_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_175_1.var_.characterEffect10079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_175_1.time_ - 0) / var_178_0)
				end
			end

			if arg_175_1.time_ >= 0 + var_178_0 and arg_175_1.time_ < 0 + var_178_0 + arg_178_0 and not isNil(arg_175_1.actors_["10079ui_story"]) and arg_175_1.var_.characterEffect10079ui_story then
				arg_175_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_175_1.var_.characterEffect10079ui_story.fillRatio = 0.5
			end

			local var_178_1 = arg_175_1.actors_["4040ui_story"]

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 and not isNil(var_178_1) and arg_175_1.var_.characterEffect4040ui_story == nil then
				arg_175_1.var_.characterEffect4040ui_story = var_178_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_178_2 = 0.200000002980232

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_2 and not isNil(var_178_1) then
				if arg_175_1.var_.characterEffect4040ui_story and not isNil(var_178_1) then
					arg_175_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_175_1.time_ >= 0 + var_178_2 and arg_175_1.time_ < 0 + var_178_2 + arg_178_0 and not isNil(var_178_1) and arg_175_1.var_.characterEffect4040ui_story then
				arg_175_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 then
				arg_175_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action3_1")
			end

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 then
				arg_175_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_178_4 = 0
			local var_178_5 = 0.325

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= var_178_4 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, true)

				arg_175_1.leftNameTxt_.text = arg_175_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_175_1.leftNameTxt_.transform)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1.leftNameTxt_.text)
				SetActive(arg_175_1.iconTrs_.gameObject, false)
				arg_175_1.callingController_:SetSelectedState("normal")

				local var_178_6 = arg_175_1:GetWordFromCfg(319741043)
				local var_178_7 = arg_175_1:FormatText(var_178_6.content)

				arg_175_1.text_.text = var_178_7

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_9 = 13 <= 0 and var_178_5 or var_178_5 * (utf8.len(var_178_7) / 13)

				if (13 <= 0 and var_178_5 or var_178_5 * (utf8.len(var_178_7) / 13)) > 0 and var_178_5 < var_178_9 then
					arg_175_1.talkMaxDuration = var_178_9

					if var_178_9 + var_178_4 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_9 + var_178_4
					end
				end

				arg_175_1.text_.text = var_178_7
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319741", "319741043", "story_v_out_319741.awb") ~= 0 then
					local var_178_10 = manager.audio:GetVoiceLength("story_v_out_319741", "319741043", "story_v_out_319741.awb") / 1000

					if var_178_10 + var_178_4 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_10 + var_178_4
					end

					if var_178_6.prefab_name ~= "" and arg_175_1.actors_[var_178_6.prefab_name] ~= nil then
						local var_178_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_175_1.actors_[var_178_6.prefab_name].transform, "story_v_out_319741", "319741043", "story_v_out_319741.awb")

						arg_175_1:RecordAudio("319741043", var_178_11)
						arg_175_1:RecordAudio("319741043", var_178_11)
					else
						arg_175_1:AudioAction("play", "voice", "story_v_out_319741", "319741043", "story_v_out_319741.awb")
					end

					arg_175_1:RecordHistoryTalkVoice("story_v_out_319741", "319741043", "story_v_out_319741.awb")
				end

				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_12 = math.max(var_178_5, arg_175_1.talkMaxDuration)

			if var_178_4 <= arg_175_1.time_ and arg_175_1.time_ < var_178_4 + var_178_12 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - var_178_4) / var_178_12

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= var_178_4 + var_178_12 and arg_175_1.time_ < var_178_4 + var_178_12 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {}

		arg_175_1:InitPlayNodeList()
	end,
	Play319741044 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 319741044
		arg_179_1.duration_ = 10.53

		local var_179_0 = {
			zh = 3.7,
			ja = 10.533
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
				arg_179_0:Play319741045(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 then
				arg_179_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_182_0 = arg_179_1.actors_["4040ui_story"]

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 and not isNil(var_182_0) and arg_179_1.var_.characterEffect4040ui_story == nil then
				arg_179_1.var_.characterEffect4040ui_story = var_182_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_182_1 = 0.200000002980232

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_1 and not isNil(var_182_0) then
				if arg_179_1.var_.characterEffect4040ui_story and not isNil(var_182_0) then
					arg_179_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_179_1.var_.characterEffect4040ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_179_1.time_ - 0) / var_182_1)
				end
			end

			if arg_179_1.time_ >= 0 + var_182_1 and arg_179_1.time_ < 0 + var_182_1 + arg_182_0 and not isNil(var_182_0) and arg_179_1.var_.characterEffect4040ui_story then
				arg_179_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_179_1.var_.characterEffect4040ui_story.fillRatio = 0.5
			end

			local var_182_2 = arg_179_1.actors_["10079ui_story"]

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 and not isNil(var_182_2) and arg_179_1.var_.characterEffect10079ui_story == nil then
				arg_179_1.var_.characterEffect10079ui_story = var_182_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_182_3 = 0.200000002980232

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_3 and not isNil(var_182_2) then
				if arg_179_1.var_.characterEffect10079ui_story and not isNil(var_182_2) then
					arg_179_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_179_1.time_ >= 0 + var_182_3 and arg_179_1.time_ < 0 + var_182_3 + arg_182_0 and not isNil(var_182_2) and arg_179_1.var_.characterEffect10079ui_story then
				arg_179_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			local var_182_5 = 0
			local var_182_6 = 0.475

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= var_182_5 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, true)

				arg_179_1.leftNameTxt_.text = arg_179_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_179_1.leftNameTxt_.transform)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1.leftNameTxt_.text)
				SetActive(arg_179_1.iconTrs_.gameObject, false)
				arg_179_1.callingController_:SetSelectedState("normal")

				local var_182_7 = arg_179_1:GetWordFromCfg(319741044)
				local var_182_8 = arg_179_1:FormatText(var_182_7.content)

				arg_179_1.text_.text = var_182_8

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_10 = 19 <= 0 and var_182_6 or var_182_6 * (utf8.len(var_182_8) / 19)

				if (19 <= 0 and var_182_6 or var_182_6 * (utf8.len(var_182_8) / 19)) > 0 and var_182_6 < var_182_10 then
					arg_179_1.talkMaxDuration = var_182_10

					if var_182_10 + var_182_5 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_10 + var_182_5
					end
				end

				arg_179_1.text_.text = var_182_8
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319741", "319741044", "story_v_out_319741.awb") ~= 0 then
					local var_182_11 = manager.audio:GetVoiceLength("story_v_out_319741", "319741044", "story_v_out_319741.awb") / 1000

					if var_182_11 + var_182_5 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_11 + var_182_5
					end

					if var_182_7.prefab_name ~= "" and arg_179_1.actors_[var_182_7.prefab_name] ~= nil then
						local var_182_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_179_1.actors_[var_182_7.prefab_name].transform, "story_v_out_319741", "319741044", "story_v_out_319741.awb")

						arg_179_1:RecordAudio("319741044", var_182_12)
						arg_179_1:RecordAudio("319741044", var_182_12)
					else
						arg_179_1:AudioAction("play", "voice", "story_v_out_319741", "319741044", "story_v_out_319741.awb")
					end

					arg_179_1:RecordHistoryTalkVoice("story_v_out_319741", "319741044", "story_v_out_319741.awb")
				end

				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_13 = math.max(var_182_6, arg_179_1.talkMaxDuration)

			if var_182_5 <= arg_179_1.time_ and arg_179_1.time_ < var_182_5 + var_182_13 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - var_182_5) / var_182_13

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= var_182_5 + var_182_13 and arg_179_1.time_ < var_182_5 + var_182_13 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {}

		arg_179_1:InitPlayNodeList()
	end,
	Play319741045 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 319741045
		arg_183_1.duration_ = 3.47

		local var_183_0 = {
			zh = 3.466,
			ja = 3.266
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
				arg_183_0:Play319741046(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 and not isNil(arg_183_1.actors_["4040ui_story"]) and arg_183_1.var_.characterEffect4040ui_story == nil then
				arg_183_1.var_.characterEffect4040ui_story = arg_183_1.actors_["4040ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_186_0 = 0.200000002980232

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_0 and not isNil(arg_183_1.actors_["4040ui_story"]) then
				if arg_183_1.var_.characterEffect4040ui_story and not isNil(arg_183_1.actors_["4040ui_story"]) then
					arg_183_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_183_1.time_ >= 0 + var_186_0 and arg_183_1.time_ < 0 + var_186_0 + arg_186_0 and not isNil(arg_183_1.actors_["4040ui_story"]) and arg_183_1.var_.characterEffect4040ui_story then
				arg_183_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_186_2 = arg_183_1.actors_["10079ui_story"]

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 and not isNil(var_186_2) and arg_183_1.var_.characterEffect10079ui_story == nil then
				arg_183_1.var_.characterEffect10079ui_story = var_186_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_186_3 = 0.200000002980232

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_3 and not isNil(var_186_2) then
				if arg_183_1.var_.characterEffect10079ui_story and not isNil(var_186_2) then
					arg_183_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_183_1.var_.characterEffect10079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_183_1.time_ - 0) / var_186_3)
				end
			end

			if arg_183_1.time_ >= 0 + var_186_3 and arg_183_1.time_ < 0 + var_186_3 + arg_186_0 and not isNil(var_186_2) and arg_183_1.var_.characterEffect10079ui_story then
				arg_183_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_183_1.var_.characterEffect10079ui_story.fillRatio = 0.5
			end

			local var_186_4 = 0
			local var_186_5 = 0.4

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= var_186_4 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, true)

				arg_183_1.leftNameTxt_.text = arg_183_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_183_1.leftNameTxt_.transform)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1.leftNameTxt_.text)
				SetActive(arg_183_1.iconTrs_.gameObject, false)
				arg_183_1.callingController_:SetSelectedState("normal")

				local var_186_6 = arg_183_1:GetWordFromCfg(319741045)
				local var_186_7 = arg_183_1:FormatText(var_186_6.content)

				arg_183_1.text_.text = var_186_7

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_9 = 16 <= 0 and var_186_5 or var_186_5 * (utf8.len(var_186_7) / 16)

				if (16 <= 0 and var_186_5 or var_186_5 * (utf8.len(var_186_7) / 16)) > 0 and var_186_5 < var_186_9 then
					arg_183_1.talkMaxDuration = var_186_9

					if var_186_9 + var_186_4 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_9 + var_186_4
					end
				end

				arg_183_1.text_.text = var_186_7
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319741", "319741045", "story_v_out_319741.awb") ~= 0 then
					local var_186_10 = manager.audio:GetVoiceLength("story_v_out_319741", "319741045", "story_v_out_319741.awb") / 1000

					if var_186_10 + var_186_4 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_10 + var_186_4
					end

					if var_186_6.prefab_name ~= "" and arg_183_1.actors_[var_186_6.prefab_name] ~= nil then
						local var_186_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_183_1.actors_[var_186_6.prefab_name].transform, "story_v_out_319741", "319741045", "story_v_out_319741.awb")

						arg_183_1:RecordAudio("319741045", var_186_11)
						arg_183_1:RecordAudio("319741045", var_186_11)
					else
						arg_183_1:AudioAction("play", "voice", "story_v_out_319741", "319741045", "story_v_out_319741.awb")
					end

					arg_183_1:RecordHistoryTalkVoice("story_v_out_319741", "319741045", "story_v_out_319741.awb")
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
	Play319741046 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 319741046
		arg_187_1.duration_ = 13.97

		local var_187_0 = {
			zh = 8,
			ja = 13.966
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
				arg_187_0:Play319741047(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 then
				arg_187_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_1")
			end

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 then
				arg_187_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_190_0 = arg_187_1.actors_["4040ui_story"]

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 and not isNil(var_190_0) and arg_187_1.var_.characterEffect4040ui_story == nil then
				arg_187_1.var_.characterEffect4040ui_story = var_190_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_190_1 = 0.200000002980232

			if 0 <= arg_187_1.time_ and arg_187_1.time_ < 0 + var_190_1 and not isNil(var_190_0) then
				if arg_187_1.var_.characterEffect4040ui_story and not isNil(var_190_0) then
					arg_187_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_187_1.var_.characterEffect4040ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_187_1.time_ - 0) / var_190_1)
				end
			end

			if arg_187_1.time_ >= 0 + var_190_1 and arg_187_1.time_ < 0 + var_190_1 + arg_190_0 and not isNil(var_190_0) and arg_187_1.var_.characterEffect4040ui_story then
				arg_187_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_187_1.var_.characterEffect4040ui_story.fillRatio = 0.5
			end

			local var_190_2 = arg_187_1.actors_["10079ui_story"]

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 and not isNil(var_190_2) and arg_187_1.var_.characterEffect10079ui_story == nil then
				arg_187_1.var_.characterEffect10079ui_story = var_190_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_190_3 = 0.200000002980232

			if 0 <= arg_187_1.time_ and arg_187_1.time_ < 0 + var_190_3 and not isNil(var_190_2) then
				if arg_187_1.var_.characterEffect10079ui_story and not isNil(var_190_2) then
					arg_187_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_187_1.time_ >= 0 + var_190_3 and arg_187_1.time_ < 0 + var_190_3 + arg_190_0 and not isNil(var_190_2) and arg_187_1.var_.characterEffect10079ui_story then
				arg_187_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			local var_190_5 = 0
			local var_190_6 = 1

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= var_190_5 + arg_190_0 then
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

				local var_190_7 = arg_187_1:GetWordFromCfg(319741046)
				local var_190_8 = arg_187_1:FormatText(var_190_7.content)

				arg_187_1.text_.text = var_190_8

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_10 = 40 <= 0 and var_190_6 or var_190_6 * (utf8.len(var_190_8) / 40)

				if (40 <= 0 and var_190_6 or var_190_6 * (utf8.len(var_190_8) / 40)) > 0 and var_190_6 < var_190_10 then
					arg_187_1.talkMaxDuration = var_190_10

					if var_190_10 + var_190_5 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_10 + var_190_5
					end
				end

				arg_187_1.text_.text = var_190_8
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319741", "319741046", "story_v_out_319741.awb") ~= 0 then
					local var_190_11 = manager.audio:GetVoiceLength("story_v_out_319741", "319741046", "story_v_out_319741.awb") / 1000

					if var_190_11 + var_190_5 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_11 + var_190_5
					end

					if var_190_7.prefab_name ~= "" and arg_187_1.actors_[var_190_7.prefab_name] ~= nil then
						local var_190_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_187_1.actors_[var_190_7.prefab_name].transform, "story_v_out_319741", "319741046", "story_v_out_319741.awb")

						arg_187_1:RecordAudio("319741046", var_190_12)
						arg_187_1:RecordAudio("319741046", var_190_12)
					else
						arg_187_1:AudioAction("play", "voice", "story_v_out_319741", "319741046", "story_v_out_319741.awb")
					end

					arg_187_1:RecordHistoryTalkVoice("story_v_out_319741", "319741046", "story_v_out_319741.awb")
				end

				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_13 = math.max(var_190_6, arg_187_1.talkMaxDuration)

			if var_190_5 <= arg_187_1.time_ and arg_187_1.time_ < var_190_5 + var_190_13 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - var_190_5) / var_190_13

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= var_190_5 + var_190_13 and arg_187_1.time_ < var_190_5 + var_190_13 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {}

		arg_187_1:InitPlayNodeList()
	end,
	Play319741047 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 319741047
		arg_191_1.duration_ = 3.97

		local var_191_0 = {
			zh = 3.966,
			ja = 3.1
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
				arg_191_0:Play319741048(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 and not isNil(arg_191_1.actors_["4040ui_story"]) and arg_191_1.var_.characterEffect4040ui_story == nil then
				arg_191_1.var_.characterEffect4040ui_story = arg_191_1.actors_["4040ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_194_0 = 0.200000002980232

			if 0 <= arg_191_1.time_ and arg_191_1.time_ < 0 + var_194_0 and not isNil(arg_191_1.actors_["4040ui_story"]) then
				if arg_191_1.var_.characterEffect4040ui_story and not isNil(arg_191_1.actors_["4040ui_story"]) then
					arg_191_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_191_1.time_ >= 0 + var_194_0 and arg_191_1.time_ < 0 + var_194_0 + arg_194_0 and not isNil(arg_191_1.actors_["4040ui_story"]) and arg_191_1.var_.characterEffect4040ui_story then
				arg_191_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_194_2 = arg_191_1.actors_["10079ui_story"]

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 and not isNil(var_194_2) and arg_191_1.var_.characterEffect10079ui_story == nil then
				arg_191_1.var_.characterEffect10079ui_story = var_194_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_194_3 = 0.200000002980232

			if 0 <= arg_191_1.time_ and arg_191_1.time_ < 0 + var_194_3 and not isNil(var_194_2) then
				if arg_191_1.var_.characterEffect10079ui_story and not isNil(var_194_2) then
					arg_191_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_191_1.var_.characterEffect10079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_191_1.time_ - 0) / var_194_3)
				end
			end

			if arg_191_1.time_ >= 0 + var_194_3 and arg_191_1.time_ < 0 + var_194_3 + arg_194_0 and not isNil(var_194_2) and arg_191_1.var_.characterEffect10079ui_story then
				arg_191_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_191_1.var_.characterEffect10079ui_story.fillRatio = 0.5
			end

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 then
				arg_191_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action3_2")
			end

			local var_194_4 = 0
			local var_194_5 = 0.45

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= var_194_4 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, true)

				arg_191_1.leftNameTxt_.text = arg_191_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_191_1.leftNameTxt_.transform)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1.leftNameTxt_.text)
				SetActive(arg_191_1.iconTrs_.gameObject, false)
				arg_191_1.callingController_:SetSelectedState("normal")

				local var_194_6 = arg_191_1:GetWordFromCfg(319741047)
				local var_194_7 = arg_191_1:FormatText(var_194_6.content)

				arg_191_1.text_.text = var_194_7

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_9 = 18 <= 0 and var_194_5 or var_194_5 * (utf8.len(var_194_7) / 18)

				if (18 <= 0 and var_194_5 or var_194_5 * (utf8.len(var_194_7) / 18)) > 0 and var_194_5 < var_194_9 then
					arg_191_1.talkMaxDuration = var_194_9

					if var_194_9 + var_194_4 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_9 + var_194_4
					end
				end

				arg_191_1.text_.text = var_194_7
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319741", "319741047", "story_v_out_319741.awb") ~= 0 then
					local var_194_10 = manager.audio:GetVoiceLength("story_v_out_319741", "319741047", "story_v_out_319741.awb") / 1000

					if var_194_10 + var_194_4 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_10 + var_194_4
					end

					if var_194_6.prefab_name ~= "" and arg_191_1.actors_[var_194_6.prefab_name] ~= nil then
						local var_194_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_191_1.actors_[var_194_6.prefab_name].transform, "story_v_out_319741", "319741047", "story_v_out_319741.awb")

						arg_191_1:RecordAudio("319741047", var_194_11)
						arg_191_1:RecordAudio("319741047", var_194_11)
					else
						arg_191_1:AudioAction("play", "voice", "story_v_out_319741", "319741047", "story_v_out_319741.awb")
					end

					arg_191_1:RecordHistoryTalkVoice("story_v_out_319741", "319741047", "story_v_out_319741.awb")
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

		arg_191_1.nodeConfigList_ = {}

		arg_191_1:InitPlayNodeList()
	end,
	Play319741048 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 319741048
		arg_195_1.duration_ = 17.17

		local var_195_0 = {
			zh = 9.033,
			ja = 17.166
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
				arg_195_0:Play319741049(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			local var_198_0 = 0.975

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, true)

				arg_195_1.leftNameTxt_.text = arg_195_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_195_1.leftNameTxt_.transform)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1.leftNameTxt_.text)
				SetActive(arg_195_1.iconTrs_.gameObject, false)
				arg_195_1.callingController_:SetSelectedState("normal")

				local var_198_1 = arg_195_1:GetWordFromCfg(319741048)
				local var_198_2 = arg_195_1:FormatText(var_198_1.content)

				arg_195_1.text_.text = var_198_2

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_4 = 39 <= 0 and var_198_0 or var_198_0 * (utf8.len(var_198_2) / 39)

				if (39 <= 0 and var_198_0 or var_198_0 * (utf8.len(var_198_2) / 39)) > 0 and var_198_0 < var_198_4 then
					arg_195_1.talkMaxDuration = var_198_4

					if var_198_4 + 0 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_4 + 0
					end
				end

				arg_195_1.text_.text = var_198_2
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319741", "319741048", "story_v_out_319741.awb") ~= 0 then
					local var_198_5 = manager.audio:GetVoiceLength("story_v_out_319741", "319741048", "story_v_out_319741.awb") / 1000

					if var_198_5 + 0 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_5 + 0
					end

					if var_198_1.prefab_name ~= "" and arg_195_1.actors_[var_198_1.prefab_name] ~= nil then
						local var_198_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_195_1.actors_[var_198_1.prefab_name].transform, "story_v_out_319741", "319741048", "story_v_out_319741.awb")

						arg_195_1:RecordAudio("319741048", var_198_6)
						arg_195_1:RecordAudio("319741048", var_198_6)
					else
						arg_195_1:AudioAction("play", "voice", "story_v_out_319741", "319741048", "story_v_out_319741.awb")
					end

					arg_195_1:RecordHistoryTalkVoice("story_v_out_319741", "319741048", "story_v_out_319741.awb")
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
	Play319741049 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 319741049
		arg_199_1.duration_ = 8.77

		local var_199_0 = {
			zh = 8.766,
			ja = 8.633
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
				arg_199_0:Play319741050(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			local var_202_0 = 0.875

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, true)

				arg_199_1.leftNameTxt_.text = arg_199_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_199_1.leftNameTxt_.transform)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1.leftNameTxt_.text)
				SetActive(arg_199_1.iconTrs_.gameObject, false)
				arg_199_1.callingController_:SetSelectedState("normal")

				local var_202_1 = arg_199_1:GetWordFromCfg(319741049)
				local var_202_2 = arg_199_1:FormatText(var_202_1.content)

				arg_199_1.text_.text = var_202_2

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_4 = 35 <= 0 and var_202_0 or var_202_0 * (utf8.len(var_202_2) / 35)

				if (35 <= 0 and var_202_0 or var_202_0 * (utf8.len(var_202_2) / 35)) > 0 and var_202_0 < var_202_4 then
					arg_199_1.talkMaxDuration = var_202_4

					if var_202_4 + 0 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_4 + 0
					end
				end

				arg_199_1.text_.text = var_202_2
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319741", "319741049", "story_v_out_319741.awb") ~= 0 then
					local var_202_5 = manager.audio:GetVoiceLength("story_v_out_319741", "319741049", "story_v_out_319741.awb") / 1000

					if var_202_5 + 0 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_5 + 0
					end

					if var_202_1.prefab_name ~= "" and arg_199_1.actors_[var_202_1.prefab_name] ~= nil then
						local var_202_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_199_1.actors_[var_202_1.prefab_name].transform, "story_v_out_319741", "319741049", "story_v_out_319741.awb")

						arg_199_1:RecordAudio("319741049", var_202_6)
						arg_199_1:RecordAudio("319741049", var_202_6)
					else
						arg_199_1:AudioAction("play", "voice", "story_v_out_319741", "319741049", "story_v_out_319741.awb")
					end

					arg_199_1:RecordHistoryTalkVoice("story_v_out_319741", "319741049", "story_v_out_319741.awb")
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
	Play319741050 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 319741050
		arg_203_1.duration_ = 10.73

		local var_203_0 = {
			zh = 10.733,
			ja = 10.033
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
				arg_203_0:Play319741051(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			local var_206_0 = 1.175

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, true)

				arg_203_1.leftNameTxt_.text = arg_203_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_203_1.leftNameTxt_.transform)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1.leftNameTxt_.text)
				SetActive(arg_203_1.iconTrs_.gameObject, false)
				arg_203_1.callingController_:SetSelectedState("normal")

				local var_206_1 = arg_203_1:GetWordFromCfg(319741050)
				local var_206_2 = arg_203_1:FormatText(var_206_1.content)

				arg_203_1.text_.text = var_206_2

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_4 = 47 <= 0 and var_206_0 or var_206_0 * (utf8.len(var_206_2) / 47)

				if (47 <= 0 and var_206_0 or var_206_0 * (utf8.len(var_206_2) / 47)) > 0 and var_206_0 < var_206_4 then
					arg_203_1.talkMaxDuration = var_206_4

					if var_206_4 + 0 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_4 + 0
					end
				end

				arg_203_1.text_.text = var_206_2
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319741", "319741050", "story_v_out_319741.awb") ~= 0 then
					local var_206_5 = manager.audio:GetVoiceLength("story_v_out_319741", "319741050", "story_v_out_319741.awb") / 1000

					if var_206_5 + 0 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_5 + 0
					end

					if var_206_1.prefab_name ~= "" and arg_203_1.actors_[var_206_1.prefab_name] ~= nil then
						local var_206_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_203_1.actors_[var_206_1.prefab_name].transform, "story_v_out_319741", "319741050", "story_v_out_319741.awb")

						arg_203_1:RecordAudio("319741050", var_206_6)
						arg_203_1:RecordAudio("319741050", var_206_6)
					else
						arg_203_1:AudioAction("play", "voice", "story_v_out_319741", "319741050", "story_v_out_319741.awb")
					end

					arg_203_1:RecordHistoryTalkVoice("story_v_out_319741", "319741050", "story_v_out_319741.awb")
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
	Play319741051 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 319741051
		arg_207_1.duration_ = 12.37

		local var_207_0 = {
			zh = 12.133,
			ja = 12.366
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
				arg_207_0:Play319741052(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 then
				arg_207_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action2_1")
			end

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 then
				arg_207_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_210_0 = 0
			local var_210_1 = 1.425

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= var_210_0 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, true)

				arg_207_1.leftNameTxt_.text = arg_207_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_207_1.leftNameTxt_.transform)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1.leftNameTxt_.text)
				SetActive(arg_207_1.iconTrs_.gameObject, false)
				arg_207_1.callingController_:SetSelectedState("normal")

				local var_210_2 = arg_207_1:GetWordFromCfg(319741051)
				local var_210_3 = arg_207_1:FormatText(var_210_2.content)

				arg_207_1.text_.text = var_210_3

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_5 = 57 <= 0 and var_210_1 or var_210_1 * (utf8.len(var_210_3) / 57)

				if (57 <= 0 and var_210_1 or var_210_1 * (utf8.len(var_210_3) / 57)) > 0 and var_210_1 < var_210_5 then
					arg_207_1.talkMaxDuration = var_210_5

					if var_210_5 + var_210_0 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_5 + var_210_0
					end
				end

				arg_207_1.text_.text = var_210_3
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319741", "319741051", "story_v_out_319741.awb") ~= 0 then
					local var_210_6 = manager.audio:GetVoiceLength("story_v_out_319741", "319741051", "story_v_out_319741.awb") / 1000

					if var_210_6 + var_210_0 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_6 + var_210_0
					end

					if var_210_2.prefab_name ~= "" and arg_207_1.actors_[var_210_2.prefab_name] ~= nil then
						local var_210_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_207_1.actors_[var_210_2.prefab_name].transform, "story_v_out_319741", "319741051", "story_v_out_319741.awb")

						arg_207_1:RecordAudio("319741051", var_210_7)
						arg_207_1:RecordAudio("319741051", var_210_7)
					else
						arg_207_1:AudioAction("play", "voice", "story_v_out_319741", "319741051", "story_v_out_319741.awb")
					end

					arg_207_1:RecordHistoryTalkVoice("story_v_out_319741", "319741051", "story_v_out_319741.awb")
				end

				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_8 = math.max(var_210_1, arg_207_1.talkMaxDuration)

			if var_210_0 <= arg_207_1.time_ and arg_207_1.time_ < var_210_0 + var_210_8 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - var_210_0) / var_210_8

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= var_210_0 + var_210_8 and arg_207_1.time_ < var_210_0 + var_210_8 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {}

		arg_207_1:InitPlayNodeList()
	end,
	Play319741052 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 319741052
		arg_211_1.duration_ = 10.4

		local var_211_0 = {
			zh = 8.8,
			ja = 10.4
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
				arg_211_0:Play319741053(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			local var_214_0 = 0.85

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, true)

				arg_211_1.leftNameTxt_.text = arg_211_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_211_1.leftNameTxt_.transform)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1.leftNameTxt_.text)
				SetActive(arg_211_1.iconTrs_.gameObject, false)
				arg_211_1.callingController_:SetSelectedState("normal")

				local var_214_1 = arg_211_1:GetWordFromCfg(319741052)
				local var_214_2 = arg_211_1:FormatText(var_214_1.content)

				arg_211_1.text_.text = var_214_2

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_4 = 34 <= 0 and var_214_0 or var_214_0 * (utf8.len(var_214_2) / 34)

				if (34 <= 0 and var_214_0 or var_214_0 * (utf8.len(var_214_2) / 34)) > 0 and var_214_0 < var_214_4 then
					arg_211_1.talkMaxDuration = var_214_4

					if var_214_4 + 0 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_4 + 0
					end
				end

				arg_211_1.text_.text = var_214_2
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319741", "319741052", "story_v_out_319741.awb") ~= 0 then
					local var_214_5 = manager.audio:GetVoiceLength("story_v_out_319741", "319741052", "story_v_out_319741.awb") / 1000

					if var_214_5 + 0 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_5 + 0
					end

					if var_214_1.prefab_name ~= "" and arg_211_1.actors_[var_214_1.prefab_name] ~= nil then
						local var_214_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_211_1.actors_[var_214_1.prefab_name].transform, "story_v_out_319741", "319741052", "story_v_out_319741.awb")

						arg_211_1:RecordAudio("319741052", var_214_6)
						arg_211_1:RecordAudio("319741052", var_214_6)
					else
						arg_211_1:AudioAction("play", "voice", "story_v_out_319741", "319741052", "story_v_out_319741.awb")
					end

					arg_211_1:RecordHistoryTalkVoice("story_v_out_319741", "319741052", "story_v_out_319741.awb")
				end

				arg_211_1:RecordContent(arg_211_1.text_.text)
			end

			local var_214_7 = math.max(var_214_0, arg_211_1.talkMaxDuration)

			if 0 <= arg_211_1.time_ and arg_211_1.time_ < 0 + var_214_7 then
				arg_211_1.typewritter.percent = (arg_211_1.time_ - 0) / var_214_7

				arg_211_1.typewritter:SetDirty()
			end

			if arg_211_1.time_ >= 0 + var_214_7 and arg_211_1.time_ < 0 + var_214_7 + arg_214_0 then
				arg_211_1.typewritter.percent = 1

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(true)
			end
		end

		arg_211_1.nodeConfigList_ = {}

		arg_211_1:InitPlayNodeList()
	end,
	Play319741053 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 319741053
		arg_215_1.duration_ = 5

		SetActive(arg_215_1.tipsGo_, false)

		function arg_215_1.onSingleLineFinish_()
			arg_215_1.onSingleLineUpdate_ = nil
			arg_215_1.onSingleLineFinish_ = nil
			arg_215_1.state_ = "waiting"
		end

		function arg_215_1.playNext_(arg_217_0)
			if arg_217_0 == 1 then
				arg_215_0:Play319741054(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 and not isNil(arg_215_1.actors_["10079ui_story"]) and arg_215_1.var_.characterEffect10079ui_story == nil then
				arg_215_1.var_.characterEffect10079ui_story = arg_215_1.actors_["10079ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_218_0 = 0.200000002980232

			if 0 <= arg_215_1.time_ and arg_215_1.time_ < 0 + var_218_0 and not isNil(arg_215_1.actors_["10079ui_story"]) then
				if arg_215_1.var_.characterEffect10079ui_story and not isNil(arg_215_1.actors_["10079ui_story"]) then
					arg_215_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_215_1.var_.characterEffect10079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_215_1.time_ - 0) / var_218_0)
				end
			end

			if arg_215_1.time_ >= 0 + var_218_0 and arg_215_1.time_ < 0 + var_218_0 + arg_218_0 and not isNil(arg_215_1.actors_["10079ui_story"]) and arg_215_1.var_.characterEffect10079ui_story then
				arg_215_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_215_1.var_.characterEffect10079ui_story.fillRatio = 0.5
			end

			local var_218_1 = arg_215_1.actors_["4040ui_story"]

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 and not isNil(var_218_1) and arg_215_1.var_.characterEffect4040ui_story == nil then
				arg_215_1.var_.characterEffect4040ui_story = var_218_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_218_2 = 0.200000002980232

			if 0 <= arg_215_1.time_ and arg_215_1.time_ < 0 + var_218_2 and not isNil(var_218_1) then
				if arg_215_1.var_.characterEffect4040ui_story and not isNil(var_218_1) then
					arg_215_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_215_1.var_.characterEffect4040ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_215_1.time_ - 0) / var_218_2)
				end
			end

			if arg_215_1.time_ >= 0 + var_218_2 and arg_215_1.time_ < 0 + var_218_2 + arg_218_0 and not isNil(var_218_1) and arg_215_1.var_.characterEffect4040ui_story then
				arg_215_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_215_1.var_.characterEffect4040ui_story.fillRatio = 0.5
			end

			local var_218_3 = arg_215_1.actors_["4040ui_story"].transform

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 then
				arg_215_1.var_.moveOldPos4040ui_story = var_218_3.localPosition
			end

			local var_218_4 = 0.001

			if 0 <= arg_215_1.time_ and arg_215_1.time_ < 0 + var_218_4 then
				var_218_3.localPosition = Vector3.Lerp(arg_215_1.var_.moveOldPos4040ui_story, Vector3.New(0, 100, 0), (arg_215_1.time_ - 0) / var_218_4)
				var_218_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_218_3.position).x, (manager.ui.mainCamera.transform.position - var_218_3.position).y, (manager.ui.mainCamera.transform.position - var_218_3.position).z)
				var_218_3.localEulerAngles.z = 0
				var_218_3.localEulerAngles.x = 0
				var_218_3.localEulerAngles = var_218_3.localEulerAngles
			end

			if arg_215_1.time_ >= 0 + var_218_4 and arg_215_1.time_ < 0 + var_218_4 + arg_218_0 then
				var_218_3.localPosition = Vector3.New(0, 100, 0)
				var_218_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_218_3.position).x, (manager.ui.mainCamera.transform.position - var_218_3.position).y, (manager.ui.mainCamera.transform.position - var_218_3.position).z)
				var_218_3.localEulerAngles.z = 0
				var_218_3.localEulerAngles.x = 0
				var_218_3.localEulerAngles = var_218_3.localEulerAngles
			end

			local var_218_5 = arg_215_1.actors_["10079ui_story"].transform

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 then
				arg_215_1.var_.moveOldPos10079ui_story = var_218_5.localPosition
			end

			local var_218_6 = 0.001

			if 0 <= arg_215_1.time_ and arg_215_1.time_ < 0 + var_218_6 then
				var_218_5.localPosition = Vector3.Lerp(arg_215_1.var_.moveOldPos10079ui_story, Vector3.New(0, 100, 0), (arg_215_1.time_ - 0) / var_218_6)
				var_218_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_218_5.position).x, (manager.ui.mainCamera.transform.position - var_218_5.position).y, (manager.ui.mainCamera.transform.position - var_218_5.position).z)
				var_218_5.localEulerAngles.z = 0
				var_218_5.localEulerAngles.x = 0
				var_218_5.localEulerAngles = var_218_5.localEulerAngles
			end

			if arg_215_1.time_ >= 0 + var_218_6 and arg_215_1.time_ < 0 + var_218_6 + arg_218_0 then
				var_218_5.localPosition = Vector3.New(0, 100, 0)
				var_218_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_218_5.position).x, (manager.ui.mainCamera.transform.position - var_218_5.position).y, (manager.ui.mainCamera.transform.position - var_218_5.position).z)
				var_218_5.localEulerAngles.z = 0
				var_218_5.localEulerAngles.x = 0
				var_218_5.localEulerAngles = var_218_5.localEulerAngles
			end

			local var_218_7 = 0
			local var_218_8 = 1.05

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= var_218_7 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, false)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_215_1.iconTrs_.gameObject, false)
				arg_215_1.callingController_:SetSelectedState("normal")

				local var_218_9 = arg_215_1:FormatText(arg_215_1:GetWordFromCfg(319741053).content)

				arg_215_1.text_.text = var_218_9

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_11 = 42 <= 0 and var_218_8 or var_218_8 * (utf8.len(var_218_9) / 42)

				if (42 <= 0 and var_218_8 or var_218_8 * (utf8.len(var_218_9) / 42)) > 0 and var_218_8 < var_218_11 then
					arg_215_1.talkMaxDuration = var_218_11

					if var_218_11 + var_218_7 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_11 + var_218_7
					end
				end

				arg_215_1.text_.text = var_218_9
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)
				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_12 = math.max(var_218_8, arg_215_1.talkMaxDuration)

			if var_218_7 <= arg_215_1.time_ and arg_215_1.time_ < var_218_7 + var_218_12 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - var_218_7) / var_218_12

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= var_218_7 + var_218_12 and arg_215_1.time_ < var_218_7 + var_218_12 + arg_218_0 then
				arg_215_1.typewritter.percent = 1

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(true)
			end
		end

		arg_215_1.nodeConfigList_ = {
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

		arg_215_1:InitPlayNodeList()
	end,
	Play319741054 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 319741054
		arg_219_1.duration_ = 6.18

		SetActive(arg_219_1.tipsGo_, false)

		function arg_219_1.onSingleLineFinish_()
			arg_219_1.onSingleLineUpdate_ = nil
			arg_219_1.onSingleLineFinish_ = nil
			arg_219_1.state_ = "waiting"
		end

		function arg_219_1.playNext_(arg_221_0)
			if arg_221_0 == 1 then
				arg_219_0:Play319741055(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			local var_222_0 = manager.audio:GetVoiceLength("story_v_out_319741", "319741054", "story_v_out_319741.awb") / 1000

			if var_222_0 > 0 and 6.033 < var_222_0 and var_222_0 + 0.15 > arg_219_1.duration_ then
				arg_219_1.duration_ = var_222_0 + 0.15
			end

			if 0.15 < arg_219_1.time_ and arg_219_1.time_ <= 0.15 + arg_222_0 then
				arg_219_1:AudioAction("play", "voice", "story_v_out_319741", "319741054", "story_v_out_319741.awb")
			end

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 then
				arg_219_1.fswbg_:SetActive(true)
				arg_219_1.dialog_:SetActive(false)

				arg_219_1.fswtw_.percent = 0
				arg_219_1.fswt_.text = arg_219_1:FormatText(arg_219_1:GetWordFromCfg(319741054).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.fswt_)

				arg_219_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_219_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_219_1.fswtw_:SetDirty()

				arg_219_1.typewritterCharCountI18N = 0

				SetActive(arg_219_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_219_1:ShowNextGo(false)
			end

			local var_222_2 = 0.149999999998999

			if 0.149999999998999 < arg_219_1.time_ and arg_219_1.time_ <= var_222_2 + arg_222_0 then
				arg_219_1.var_.oldValueTypewriter = arg_219_1.fswtw_.percent

				SetActive(arg_219_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_219_1:ShowNextGo(false)
			end

			local var_222_3 = 0
			local var_222_4 = 0
			local var_222_5, var_222_6 = arg_219_1:GetPercentByPara(arg_219_1:FormatText(arg_219_1:GetWordFromCfg(319741054).content), 1)

			if var_222_2 < arg_219_1.time_ and arg_219_1.time_ <= var_222_2 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0

				local var_222_7 = var_222_3 <= 0 and var_222_4 or var_222_4 * ((var_222_6 - arg_219_1.typewritterCharCountI18N) / var_222_3)

				if (var_222_3 <= 0 and var_222_4 or var_222_4 * ((var_222_6 - arg_219_1.typewritterCharCountI18N) / var_222_3)) > 0 and var_222_4 < var_222_7 then
					arg_219_1.talkMaxDuration = var_222_7

					if var_222_7 + var_222_2 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_7 + var_222_2
					end
				end
			end

			local var_222_8 = math.max(0, arg_219_1.talkMaxDuration)

			if var_222_2 <= arg_219_1.time_ and arg_219_1.time_ < var_222_2 + var_222_8 then
				arg_219_1.fswtw_.percent = Mathf.Lerp(arg_219_1.var_.oldValueTypewriter, var_222_5, (arg_219_1.time_ - var_222_2) / var_222_8)
				arg_219_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_219_1.fswtw_:SetDirty()
			end

			if arg_219_1.time_ >= var_222_2 + var_222_8 and arg_219_1.time_ < var_222_2 + var_222_8 + arg_222_0 then
				arg_219_1.fswtw_.percent = var_222_5

				arg_219_1.fswtw_:SetDirty()
				arg_219_1:ShowNextGo(true)

				arg_219_1.typewritterCharCountI18N = var_222_6
			end

			local var_222_9 = 0.15

			if 0.15 < arg_219_1.time_ and arg_219_1.time_ <= var_222_9 + arg_222_0 then
				arg_219_1.var_.oldValueTypewriter = arg_219_1.fswtw_.percent

				SetActive(arg_219_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_219_1:ShowNextGo(false)
			end

			local var_222_10 = 24
			local var_222_11 = 1.6
			local var_222_12, var_222_13 = arg_219_1:GetPercentByPara(arg_219_1:FormatText(arg_219_1:GetWordFromCfg(319741054).content), 1)

			if var_222_9 < arg_219_1.time_ and arg_219_1.time_ <= var_222_9 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0

				local var_222_14 = var_222_10 <= 0 and var_222_11 or var_222_11 * ((var_222_13 - arg_219_1.typewritterCharCountI18N) / var_222_10)

				if (var_222_10 <= 0 and var_222_11 or var_222_11 * ((var_222_13 - arg_219_1.typewritterCharCountI18N) / var_222_10)) > 0 and var_222_11 < var_222_14 then
					arg_219_1.talkMaxDuration = var_222_14

					if var_222_14 + var_222_9 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_14 + var_222_9
					end
				end
			end

			local var_222_15 = math.max(1.6, arg_219_1.talkMaxDuration)

			if var_222_9 <= arg_219_1.time_ and arg_219_1.time_ < var_222_9 + var_222_15 then
				arg_219_1.fswtw_.percent = Mathf.Lerp(arg_219_1.var_.oldValueTypewriter, var_222_12, (arg_219_1.time_ - var_222_9) / var_222_15)
				arg_219_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_219_1.fswtw_:SetDirty()
			end

			if arg_219_1.time_ >= var_222_9 + var_222_15 and arg_219_1.time_ < var_222_9 + var_222_15 + arg_222_0 then
				arg_219_1.fswtw_.percent = var_222_12

				arg_219_1.fswtw_:SetDirty()
				arg_219_1:ShowNextGo(true)

				arg_219_1.typewritterCharCountI18N = var_222_13
			end

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 then
				arg_219_1.cswbg_:SetActive(true)

				local var_222_16 = arg_219_1.cswt_:GetComponent("RectTransform")

				arg_219_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_222_16.offsetMin = Vector2.New(400, 220)
				var_222_16.offsetMax = Vector2.New(-400, -200)
				arg_219_1.cswt_.text = arg_219_1:FormatText(arg_219_1:GetWordFromCfg(419050).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.cswt_)

				arg_219_1.cswt_.fontSize = 180
				arg_219_1.cswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_219_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_219_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 then
				local var_222_17 = arg_219_1.fswbg_.transform:Find("textbox/adapt/content") or arg_219_1.fswbg_.transform:Find("textbox/content")
				local var_222_18 = arg_219_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_222_19 = var_222_17:GetComponent("RectTransform")

				var_222_17:GetComponent("Text").alignment = UnityEngine.TextAnchor.LowerCenter
				var_222_19.offsetMin = Vector2.New(0, 0)
				var_222_19.offsetMax = Vector2.New(0, 0)
			end

			local var_222_20 = "STblack"

			if arg_219_1.bgs_.STblack == nil then
				local var_222_21 = Object.Instantiate(arg_219_1.paintGo_)

				var_222_21:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_222_20)
				var_222_21.name = var_222_20
				var_222_21.transform.parent = arg_219_1.stage_.transform
				var_222_21.transform.localPosition = Vector3.New(0, 100, 0)
				arg_219_1.bgs_[var_222_20] = var_222_21
			end

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 then
				local var_222_22 = arg_219_1.bgs_.STblack

				arg_219_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_222_22.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_222_23 = var_222_22:GetComponent("SpriteRenderer")

				if var_222_23 and var_222_23.sprite then
					local var_222_24 = 2 * (var_222_22.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_222_22.transform.localScale = Vector3.New(var_222_24 / var_222_23.sprite.bounds.size.y < var_222_24 * manager.ui.mainCameraCom_.aspect / var_222_23.sprite.bounds.size.x and var_222_24 * manager.ui.mainCameraCom_.aspect / var_222_23.sprite.bounds.size.x or var_222_24 / var_222_23.sprite.bounds.size.y, var_222_24 / var_222_23.sprite.bounds.size.y < var_222_24 * manager.ui.mainCameraCom_.aspect / var_222_23.sprite.bounds.size.x and var_222_24 * manager.ui.mainCameraCom_.aspect / var_222_23.sprite.bounds.size.x or var_222_24 / var_222_23.sprite.bounds.size.y, 0)
				end

				for iter_222_0, iter_222_1 in pairs(arg_219_1.bgs_) do
					if iter_222_0 ~= "STblack" then
						iter_222_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 then
				arg_219_1.cswbg_:SetActive(true)

				local var_222_25 = arg_219_1.cswt_:GetComponent("RectTransform")

				arg_219_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_222_25.offsetMin = Vector2.New(410, 330)
				var_222_25.offsetMax = Vector2.New(-400, -180)
				arg_219_1.cswt_.text = arg_219_1:FormatText(arg_219_1:GetWordFromCfg(419050).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.cswt_)

				arg_219_1.cswt_.fontSize = 175
				arg_219_1.cswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_219_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_219_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end
		end

		arg_219_1.nodeConfigList_ = {}

		arg_219_1:InitPlayNodeList()
	end,
	Play319741055 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 319741055
		arg_223_1.duration_ = 4.78

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
			local var_226_0 = manager.audio:GetVoiceLength("story_v_out_319741", "319741055", "story_v_out_319741.awb") / 1000

			if var_226_0 > 0 and 4.633 < var_226_0 and var_226_0 + 0.15 > arg_223_1.duration_ then
				arg_223_1.duration_ = var_226_0 + 0.15
			end

			if 0.15 < arg_223_1.time_ and arg_223_1.time_ <= 0.15 + arg_226_0 then
				arg_223_1:AudioAction("play", "voice", "story_v_out_319741", "319741055", "story_v_out_319741.awb")
			end

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 then
				arg_223_1.fswbg_:SetActive(true)
				arg_223_1.dialog_:SetActive(false)

				arg_223_1.fswtw_.percent = 0
				arg_223_1.fswt_.text = arg_223_1:FormatText(arg_223_1:GetWordFromCfg(319741055).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.fswt_)

				arg_223_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_223_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_223_1.fswtw_:SetDirty()

				arg_223_1.typewritterCharCountI18N = 0

				SetActive(arg_223_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_223_1:ShowNextGo(false)
			end

			local var_226_2 = 0.149999999998999

			if 0.149999999998999 < arg_223_1.time_ and arg_223_1.time_ <= var_226_2 + arg_226_0 then
				arg_223_1.var_.oldValueTypewriter = arg_223_1.fswtw_.percent

				SetActive(arg_223_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_223_1:ShowNextGo(false)
			end

			local var_226_3 = 0
			local var_226_4 = 0
			local var_226_5, var_226_6 = arg_223_1:GetPercentByPara(arg_223_1:FormatText(arg_223_1:GetWordFromCfg(319741055).content), 1)

			if var_226_2 < arg_223_1.time_ and arg_223_1.time_ <= var_226_2 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0

				local var_226_7 = var_226_3 <= 0 and var_226_4 or var_226_4 * ((var_226_6 - arg_223_1.typewritterCharCountI18N) / var_226_3)

				if (var_226_3 <= 0 and var_226_4 or var_226_4 * ((var_226_6 - arg_223_1.typewritterCharCountI18N) / var_226_3)) > 0 and var_226_4 < var_226_7 then
					arg_223_1.talkMaxDuration = var_226_7

					if var_226_7 + var_226_2 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_7 + var_226_2
					end
				end
			end

			local var_226_8 = math.max(0, arg_223_1.talkMaxDuration)

			if var_226_2 <= arg_223_1.time_ and arg_223_1.time_ < var_226_2 + var_226_8 then
				arg_223_1.fswtw_.percent = Mathf.Lerp(arg_223_1.var_.oldValueTypewriter, var_226_5, (arg_223_1.time_ - var_226_2) / var_226_8)
				arg_223_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_223_1.fswtw_:SetDirty()
			end

			if arg_223_1.time_ >= var_226_2 + var_226_8 and arg_223_1.time_ < var_226_2 + var_226_8 + arg_226_0 then
				arg_223_1.fswtw_.percent = var_226_5

				arg_223_1.fswtw_:SetDirty()
				arg_223_1:ShowNextGo(true)

				arg_223_1.typewritterCharCountI18N = var_226_6
			end

			local var_226_9 = 0.15

			if 0.15 < arg_223_1.time_ and arg_223_1.time_ <= var_226_9 + arg_226_0 then
				arg_223_1.var_.oldValueTypewriter = arg_223_1.fswtw_.percent

				SetActive(arg_223_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_223_1:ShowNextGo(false)
			end

			local var_226_10 = 24
			local var_226_11 = 1.6
			local var_226_12, var_226_13 = arg_223_1:GetPercentByPara(arg_223_1:FormatText(arg_223_1:GetWordFromCfg(319741055).content), 1)

			if var_226_9 < arg_223_1.time_ and arg_223_1.time_ <= var_226_9 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0

				local var_226_14 = var_226_10 <= 0 and var_226_11 or var_226_11 * ((var_226_13 - arg_223_1.typewritterCharCountI18N) / var_226_10)

				if (var_226_10 <= 0 and var_226_11 or var_226_11 * ((var_226_13 - arg_223_1.typewritterCharCountI18N) / var_226_10)) > 0 and var_226_11 < var_226_14 then
					arg_223_1.talkMaxDuration = var_226_14

					if var_226_14 + var_226_9 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_14 + var_226_9
					end
				end
			end

			local var_226_15 = math.max(1.6, arg_223_1.talkMaxDuration)

			if var_226_9 <= arg_223_1.time_ and arg_223_1.time_ < var_226_9 + var_226_15 then
				arg_223_1.fswtw_.percent = Mathf.Lerp(arg_223_1.var_.oldValueTypewriter, var_226_12, (arg_223_1.time_ - var_226_9) / var_226_15)
				arg_223_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_223_1.fswtw_:SetDirty()
			end

			if arg_223_1.time_ >= var_226_9 + var_226_15 and arg_223_1.time_ < var_226_9 + var_226_15 + arg_226_0 then
				arg_223_1.fswtw_.percent = var_226_12

				arg_223_1.fswtw_:SetDirty()
				arg_223_1:ShowNextGo(true)

				arg_223_1.typewritterCharCountI18N = var_226_13
			end
		end

		arg_223_1.nodeConfigList_ = {}

		arg_223_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/I11m",
		"TextureConfig/Background/STblack"
	},
	voices = {
		"story_v_out_319741.awb"
	}
}
