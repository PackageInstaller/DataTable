return {
	Play319801001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 319801001
		arg_1_1.duration_ = 6.87

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play319801002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.ST72a == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST72a")
				var_4_0.name = "ST72a"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.ST72a = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.ST72a

				arg_1_1.bgs_.ST72a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "ST72a" then
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
				arg_1_1:AudioAction("play", "music", "bgm_activity_3_0_story_hospital", "bgm_activity_3_0_story_hospital", "bgm_activity_3_0_story_hospital.awb")

				local var_4_14 = manager.audio:GetAudioName("bgm_activity_3_0_story_hospital", "bgm_activity_3_0_story_hospital")

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

			local var_4_15 = 1.86666666666667
			local var_4_16 = 0.25

			if 1.86666666666667 < arg_1_1.time_ and arg_1_1.time_ <= var_4_15 + arg_4_0 then
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

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[698].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10073")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_18 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(319801001).content)

				arg_1_1.text_.text = var_4_18

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_20 = 10 <= 0 and var_4_16 or var_4_16 * (utf8.len(var_4_18) / 10)

				if (10 <= 0 and var_4_16 or var_4_16 * (utf8.len(var_4_18) / 10)) > 0 and var_4_16 < var_4_20 then
					arg_1_1.talkMaxDuration = var_4_20
					var_4_15 = var_4_15 + 0.3

					if var_4_20 + var_4_15 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_20 + var_4_15
					end
				end

				arg_1_1.text_.text = var_4_18
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_21 = var_4_15 + 0.3
			local var_4_22 = math.max(var_4_16, arg_1_1.talkMaxDuration)

			if var_4_15 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_21 + var_4_22 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_21) / var_4_22

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_21 + var_4_22 and arg_1_1.time_ < var_4_21 + var_4_22 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play319801002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 319801002
		arg_9_1.duration_ = 3.63

		local var_9_0 = {
			zh = 1.999999999999,
			ja = 3.63266666666667
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
				arg_9_0:Play319801003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			if arg_9_1.actors_["10066ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10066ui_story"))) then
				local var_12_0 = Object.Instantiate(Asset.Load("Char/" .. "10066ui_story"), arg_9_1.stage_.transform)

				var_12_0.name = "10066ui_story"
				var_12_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_9_1.actors_["10066ui_story"] = var_12_0

				local var_12_1 = var_12_0:GetComponentInChildren(typeof(CharacterEffect))

				var_12_1.enabled = true

				local var_12_2 = GameObjectTools.GetOrAddComponent(var_12_0, typeof(DynamicBoneHelper))

				if var_12_2 then
					var_12_2:EnableDynamicBone(false)
				end

				arg_9_1:ShowWeapon(var_12_1.transform, false)

				arg_9_1.var_["10066ui_story" .. "Animator"] = var_12_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_9_1.var_["10066ui_story" .. "Animator"].applyRootMotion = true
				arg_9_1.var_["10066ui_story" .. "LipSync"] = var_12_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_12_3 = arg_9_1.actors_["10066ui_story"].transform

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.var_.moveOldPos10066ui_story = var_12_3.localPosition
			end

			local var_12_4 = 0.001

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_4 then
				var_12_3.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos10066ui_story, Vector3.New(0, -0.99, -5.83), (arg_9_1.time_ - 0) / var_12_4)
				var_12_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_12_3.position).x, (manager.ui.mainCamera.transform.position - var_12_3.position).y, (manager.ui.mainCamera.transform.position - var_12_3.position).z)
				var_12_3.localEulerAngles.z = 0
				var_12_3.localEulerAngles.x = 0
				var_12_3.localEulerAngles = var_12_3.localEulerAngles
			end

			if arg_9_1.time_ >= 0 + var_12_4 and arg_9_1.time_ < 0 + var_12_4 + arg_12_0 then
				var_12_3.localPosition = Vector3.New(0, -0.99, -5.83)
				var_12_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_12_3.position).x, (manager.ui.mainCamera.transform.position - var_12_3.position).y, (manager.ui.mainCamera.transform.position - var_12_3.position).z)
				var_12_3.localEulerAngles.z = 0
				var_12_3.localEulerAngles.x = 0
				var_12_3.localEulerAngles = var_12_3.localEulerAngles
			end

			local var_12_5 = arg_9_1.actors_["10066ui_story"]

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 and not isNil(var_12_5) and arg_9_1.var_.characterEffect10066ui_story == nil then
				arg_9_1.var_.characterEffect10066ui_story = var_12_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_6 = 0.200000002980232

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_6 and not isNil(var_12_5) then
				if arg_9_1.var_.characterEffect10066ui_story and not isNil(var_12_5) then
					arg_9_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_9_1.time_ >= 0 + var_12_6 and arg_9_1.time_ < 0 + var_12_6 + arg_12_0 and not isNil(var_12_5) and arg_9_1.var_.characterEffect10066ui_story then
				arg_9_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action6_1")
			end

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			if arg_9_1.frameCnt_ <= 1 then
				arg_9_1.dialog_:SetActive(false)
			end

			local var_12_8 = 0.366666666666667
			local var_12_9 = 0.175

			if 0.366666666666667 < arg_9_1.time_ and arg_9_1.time_ <= var_12_8 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0

				arg_9_1.dialog_:SetActive(true)

				arg_9_1.dialogCg_.alpha = 0

				local var_12_10 = LeanTween.value(arg_9_1.dialog_, 0, 1, 0.3)

				var_12_10:setOnUpdate(LuaHelper.FloatAction(function(arg_13_0)
					arg_9_1.dialogCg_.alpha = arg_13_0
				end))
				var_12_10:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_9_1.dialog_)
					var_12_10:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_9_1.duration_ = arg_9_1.duration_ + 0.3

				SetActive(arg_9_1.leftNameGo_, true)

				arg_9_1.leftNameTxt_.text = arg_9_1:FormatText(StoryNameCfg[640].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_11 = arg_9_1:GetWordFromCfg(319801002)
				local var_12_12 = arg_9_1:FormatText(var_12_11.content)

				arg_9_1.text_.text = var_12_12

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_14 = 7 <= 0 and var_12_9 or var_12_9 * (utf8.len(var_12_12) / 7)

				if (7 <= 0 and var_12_9 or var_12_9 * (utf8.len(var_12_12) / 7)) > 0 and var_12_9 < var_12_14 then
					arg_9_1.talkMaxDuration = var_12_14
					var_12_8 = var_12_8 + 0.3

					if var_12_14 + var_12_8 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_14 + var_12_8
					end
				end

				arg_9_1.text_.text = var_12_12
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319801", "319801002", "story_v_out_319801.awb") ~= 0 then
					local var_12_15 = manager.audio:GetVoiceLength("story_v_out_319801", "319801002", "story_v_out_319801.awb") / 1000

					if var_12_15 + var_12_8 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_15 + var_12_8
					end

					if var_12_11.prefab_name ~= "" and arg_9_1.actors_[var_12_11.prefab_name] ~= nil then
						local var_12_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_11.prefab_name].transform, "story_v_out_319801", "319801002", "story_v_out_319801.awb")

						arg_9_1:RecordAudio("319801002", var_12_16)
						arg_9_1:RecordAudio("319801002", var_12_16)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_319801", "319801002", "story_v_out_319801.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_319801", "319801002", "story_v_out_319801.awb")
				end

				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_17 = var_12_8 + 0.3
			local var_12_18 = math.max(var_12_9, arg_9_1.talkMaxDuration)

			if var_12_8 + 0.3 <= arg_9_1.time_ and arg_9_1.time_ < var_12_17 + var_12_18 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_17) / var_12_18

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_17 + var_12_18 and arg_9_1.time_ < var_12_17 + var_12_18 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {
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

		arg_9_1:InitPlayNodeList()
	end,
	Play319801003 = function(arg_15_0, arg_15_1)
		arg_15_1.time_ = 0
		arg_15_1.frameCnt_ = 0
		arg_15_1.state_ = "playing"
		arg_15_1.curTalkId_ = 319801003
		arg_15_1.duration_ = 5

		SetActive(arg_15_1.tipsGo_, false)

		function arg_15_1.onSingleLineFinish_()
			arg_15_1.onSingleLineUpdate_ = nil
			arg_15_1.onSingleLineFinish_ = nil
			arg_15_1.state_ = "waiting"
		end

		function arg_15_1.playNext_(arg_17_0)
			if arg_17_0 == 1 then
				arg_15_0:Play319801004(arg_15_1)
			end
		end

		function arg_15_1.onSingleLineUpdate_(arg_18_0)
			if 0 < arg_15_1.time_ and arg_15_1.time_ <= 0 + arg_18_0 and not isNil(arg_15_1.actors_["10066ui_story"]) and arg_15_1.var_.characterEffect10066ui_story == nil then
				arg_15_1.var_.characterEffect10066ui_story = arg_15_1.actors_["10066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_18_0 = 0.200000002980232

			if 0 <= arg_15_1.time_ and arg_15_1.time_ < 0 + var_18_0 and not isNil(arg_15_1.actors_["10066ui_story"]) then
				if arg_15_1.var_.characterEffect10066ui_story and not isNil(arg_15_1.actors_["10066ui_story"]) then
					arg_15_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_15_1.var_.characterEffect10066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_15_1.time_ - 0) / var_18_0)
				end
			end

			if arg_15_1.time_ >= 0 + var_18_0 and arg_15_1.time_ < 0 + var_18_0 + arg_18_0 and not isNil(arg_15_1.actors_["10066ui_story"]) and arg_15_1.var_.characterEffect10066ui_story then
				arg_15_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_15_1.var_.characterEffect10066ui_story.fillRatio = 0.5
			end

			local var_18_1 = 0
			local var_18_2 = 1.275

			if 0 < arg_15_1.time_ and arg_15_1.time_ <= var_18_1 + arg_18_0 then
				arg_15_1.talkMaxDuration = 0
				arg_15_1.dialogCg_.alpha = 1

				arg_15_1.dialog_:SetActive(true)
				SetActive(arg_15_1.leftNameGo_, false)

				arg_15_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_15_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_15_1:RecordName(arg_15_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_15_1.iconTrs_.gameObject, false)
				arg_15_1.callingController_:SetSelectedState("normal")

				local var_18_3 = arg_15_1:FormatText(arg_15_1:GetWordFromCfg(319801003).content)

				arg_15_1.text_.text = var_18_3

				LuaForUtil.ClearLinePrefixSymbol(arg_15_1.text_)

				local var_18_5 = 51 <= 0 and var_18_2 or var_18_2 * (utf8.len(var_18_3) / 51)

				if (51 <= 0 and var_18_2 or var_18_2 * (utf8.len(var_18_3) / 51)) > 0 and var_18_2 < var_18_5 then
					arg_15_1.talkMaxDuration = var_18_5

					if var_18_5 + var_18_1 > arg_15_1.duration_ then
						arg_15_1.duration_ = var_18_5 + var_18_1
					end
				end

				arg_15_1.text_.text = var_18_3
				arg_15_1.typewritter.percent = 0

				arg_15_1.typewritter:SetDirty()
				arg_15_1:ShowNextGo(false)
				arg_15_1:RecordContent(arg_15_1.text_.text)
			end

			local var_18_6 = math.max(var_18_2, arg_15_1.talkMaxDuration)

			if var_18_1 <= arg_15_1.time_ and arg_15_1.time_ < var_18_1 + var_18_6 then
				arg_15_1.typewritter.percent = (arg_15_1.time_ - var_18_1) / var_18_6

				arg_15_1.typewritter:SetDirty()
			end

			if arg_15_1.time_ >= var_18_1 + var_18_6 and arg_15_1.time_ < var_18_1 + var_18_6 + arg_18_0 then
				arg_15_1.typewritter.percent = 1

				arg_15_1.typewritter:SetDirty()
				arg_15_1:ShowNextGo(true)
			end
		end

		arg_15_1.nodeConfigList_ = {}

		arg_15_1:InitPlayNodeList()
	end,
	Play319801004 = function(arg_19_0, arg_19_1)
		arg_19_1.time_ = 0
		arg_19_1.frameCnt_ = 0
		arg_19_1.state_ = "playing"
		arg_19_1.curTalkId_ = 319801004
		arg_19_1.duration_ = 5

		SetActive(arg_19_1.tipsGo_, false)

		function arg_19_1.onSingleLineFinish_()
			arg_19_1.onSingleLineUpdate_ = nil
			arg_19_1.onSingleLineFinish_ = nil
			arg_19_1.state_ = "waiting"
		end

		function arg_19_1.playNext_(arg_21_0)
			if arg_21_0 == 1 then
				arg_19_0:Play319801005(arg_19_1)
			end
		end

		function arg_19_1.onSingleLineUpdate_(arg_22_0)
			local var_22_0 = 0.8

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= 0 + arg_22_0 then
				arg_19_1.talkMaxDuration = 0
				arg_19_1.dialogCg_.alpha = 1

				arg_19_1.dialog_:SetActive(true)
				SetActive(arg_19_1.leftNameGo_, true)

				arg_19_1.leftNameTxt_.text = arg_19_1:FormatText(StoryNameCfg[698].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_19_1.leftNameTxt_.transform)

				arg_19_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_19_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_19_1:RecordName(arg_19_1.leftNameTxt_.text)
				SetActive(arg_19_1.iconTrs_.gameObject, true)
				arg_19_1.iconController_:SetSelectedState("hero")

				arg_19_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10073")

				arg_19_1.callingController_:SetSelectedState("normal")

				arg_19_1.keyicon_.color = Color.New(1, 1, 1)
				arg_19_1.icon_.color = Color.New(1, 1, 1)

				local var_22_1 = arg_19_1:FormatText(arg_19_1:GetWordFromCfg(319801004).content)

				arg_19_1.text_.text = var_22_1

				LuaForUtil.ClearLinePrefixSymbol(arg_19_1.text_)

				local var_22_3 = 32 <= 0 and var_22_0 or var_22_0 * (utf8.len(var_22_1) / 32)

				if (32 <= 0 and var_22_0 or var_22_0 * (utf8.len(var_22_1) / 32)) > 0 and var_22_0 < var_22_3 then
					arg_19_1.talkMaxDuration = var_22_3

					if var_22_3 + 0 > arg_19_1.duration_ then
						arg_19_1.duration_ = var_22_3 + 0
					end
				end

				arg_19_1.text_.text = var_22_1
				arg_19_1.typewritter.percent = 0

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(false)
				arg_19_1:RecordContent(arg_19_1.text_.text)
			end

			local var_22_4 = math.max(var_22_0, arg_19_1.talkMaxDuration)

			if 0 <= arg_19_1.time_ and arg_19_1.time_ < 0 + var_22_4 then
				arg_19_1.typewritter.percent = (arg_19_1.time_ - 0) / var_22_4

				arg_19_1.typewritter:SetDirty()
			end

			if arg_19_1.time_ >= 0 + var_22_4 and arg_19_1.time_ < 0 + var_22_4 + arg_22_0 then
				arg_19_1.typewritter.percent = 1

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(true)
			end
		end

		arg_19_1.nodeConfigList_ = {}

		arg_19_1:InitPlayNodeList()
	end,
	Play319801005 = function(arg_23_0, arg_23_1)
		arg_23_1.time_ = 0
		arg_23_1.frameCnt_ = 0
		arg_23_1.state_ = "playing"
		arg_23_1.curTalkId_ = 319801005
		arg_23_1.duration_ = 5

		SetActive(arg_23_1.tipsGo_, false)

		function arg_23_1.onSingleLineFinish_()
			arg_23_1.onSingleLineUpdate_ = nil
			arg_23_1.onSingleLineFinish_ = nil
			arg_23_1.state_ = "waiting"
		end

		function arg_23_1.playNext_(arg_25_0)
			if arg_25_0 == 1 then
				arg_23_0:Play319801006(arg_23_1)
			end
		end

		function arg_23_1.onSingleLineUpdate_(arg_26_0)
			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 then
				arg_23_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action6_2")
			end

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 then
				arg_23_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_26_0 = 0
			local var_26_1 = 0.75

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= var_26_0 + arg_26_0 then
				arg_23_1.talkMaxDuration = 0
				arg_23_1.dialogCg_.alpha = 1

				arg_23_1.dialog_:SetActive(true)
				SetActive(arg_23_1.leftNameGo_, true)

				arg_23_1.leftNameTxt_.text = arg_23_1:FormatText(StoryNameCfg[698].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_23_1.leftNameTxt_.transform)

				arg_23_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_23_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_23_1:RecordName(arg_23_1.leftNameTxt_.text)
				SetActive(arg_23_1.iconTrs_.gameObject, true)
				arg_23_1.iconController_:SetSelectedState("hero")

				arg_23_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10073")

				arg_23_1.callingController_:SetSelectedState("normal")

				arg_23_1.keyicon_.color = Color.New(1, 1, 1)
				arg_23_1.icon_.color = Color.New(1, 1, 1)

				local var_26_2 = arg_23_1:FormatText(arg_23_1:GetWordFromCfg(319801005).content)

				arg_23_1.text_.text = var_26_2

				LuaForUtil.ClearLinePrefixSymbol(arg_23_1.text_)

				local var_26_4 = 30 <= 0 and var_26_1 or var_26_1 * (utf8.len(var_26_2) / 30)

				if (30 <= 0 and var_26_1 or var_26_1 * (utf8.len(var_26_2) / 30)) > 0 and var_26_1 < var_26_4 then
					arg_23_1.talkMaxDuration = var_26_4

					if var_26_4 + var_26_0 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_4 + var_26_0
					end
				end

				arg_23_1.text_.text = var_26_2
				arg_23_1.typewritter.percent = 0

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(false)
				arg_23_1:RecordContent(arg_23_1.text_.text)
			end

			local var_26_5 = math.max(var_26_1, arg_23_1.talkMaxDuration)

			if var_26_0 <= arg_23_1.time_ and arg_23_1.time_ < var_26_0 + var_26_5 then
				arg_23_1.typewritter.percent = (arg_23_1.time_ - var_26_0) / var_26_5

				arg_23_1.typewritter:SetDirty()
			end

			if arg_23_1.time_ >= var_26_0 + var_26_5 and arg_23_1.time_ < var_26_0 + var_26_5 + arg_26_0 then
				arg_23_1.typewritter.percent = 1

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(true)
			end
		end

		arg_23_1.nodeConfigList_ = {}

		arg_23_1:InitPlayNodeList()
	end,
	Play319801006 = function(arg_27_0, arg_27_1)
		arg_27_1.time_ = 0
		arg_27_1.frameCnt_ = 0
		arg_27_1.state_ = "playing"
		arg_27_1.curTalkId_ = 319801006
		arg_27_1.duration_ = 2.83

		local var_27_0 = {
			zh = 2.2,
			ja = 2.833
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
				arg_27_0:Play319801007(arg_27_1)
			end
		end

		function arg_27_1.onSingleLineUpdate_(arg_30_0)
			if arg_27_1.actors_["1084ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1084ui_story"))) then
				local var_30_0 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_27_1.stage_.transform)

				var_30_0.name = "1084ui_story"
				var_30_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_27_1.actors_["1084ui_story"] = var_30_0

				local var_30_1 = var_30_0:GetComponentInChildren(typeof(CharacterEffect))

				var_30_1.enabled = true

				local var_30_2 = GameObjectTools.GetOrAddComponent(var_30_0, typeof(DynamicBoneHelper))

				if var_30_2 then
					var_30_2:EnableDynamicBone(false)
				end

				arg_27_1:ShowWeapon(var_30_1.transform, false)

				arg_27_1.var_["1084ui_story" .. "Animator"] = var_30_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_27_1.var_["1084ui_story" .. "Animator"].applyRootMotion = true
				arg_27_1.var_["1084ui_story" .. "LipSync"] = var_30_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_30_3 = arg_27_1.actors_["1084ui_story"].transform

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 then
				arg_27_1.var_.moveOldPos1084ui_story = var_30_3.localPosition

				arg_27_1:ShowWeapon(arg_27_1.var_["1084ui_story" .. "Animator"].transform, false)
			end

			local var_30_4 = 0.001

			if 0 <= arg_27_1.time_ and arg_27_1.time_ < 0 + var_30_4 then
				var_30_3.localPosition = Vector3.Lerp(arg_27_1.var_.moveOldPos1084ui_story, Vector3.New(0.7, -0.97, -6), (arg_27_1.time_ - 0) / var_30_4)
				var_30_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_30_3.position).x, (manager.ui.mainCamera.transform.position - var_30_3.position).y, (manager.ui.mainCamera.transform.position - var_30_3.position).z)
				var_30_3.localEulerAngles.z = 0
				var_30_3.localEulerAngles.x = 0
				var_30_3.localEulerAngles = var_30_3.localEulerAngles
			end

			if arg_27_1.time_ >= 0 + var_30_4 and arg_27_1.time_ < 0 + var_30_4 + arg_30_0 then
				var_30_3.localPosition = Vector3.New(0.7, -0.97, -6)
				var_30_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_30_3.position).x, (manager.ui.mainCamera.transform.position - var_30_3.position).y, (manager.ui.mainCamera.transform.position - var_30_3.position).z)
				var_30_3.localEulerAngles.z = 0
				var_30_3.localEulerAngles.x = 0
				var_30_3.localEulerAngles = var_30_3.localEulerAngles
			end

			local var_30_5 = arg_27_1.actors_["1084ui_story"]

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 and not isNil(var_30_5) and arg_27_1.var_.characterEffect1084ui_story == nil then
				arg_27_1.var_.characterEffect1084ui_story = var_30_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_30_6 = 0.200000002980232

			if 0 <= arg_27_1.time_ and arg_27_1.time_ < 0 + var_30_6 and not isNil(var_30_5) then
				if arg_27_1.var_.characterEffect1084ui_story and not isNil(var_30_5) then
					arg_27_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_27_1.time_ >= 0 + var_30_6 and arg_27_1.time_ < 0 + var_30_6 + arg_30_0 and not isNil(var_30_5) and arg_27_1.var_.characterEffect1084ui_story then
				arg_27_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 then
				arg_27_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_1")
			end

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 then
				arg_27_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_30_8 = arg_27_1.actors_["10066ui_story"].transform

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 then
				arg_27_1.var_.moveOldPos10066ui_story = var_30_8.localPosition
			end

			local var_30_9 = 0.001

			if 0 <= arg_27_1.time_ and arg_27_1.time_ < 0 + var_30_9 then
				var_30_8.localPosition = Vector3.Lerp(arg_27_1.var_.moveOldPos10066ui_story, Vector3.New(-0.7, -0.99, -5.83), (arg_27_1.time_ - 0) / var_30_9)
				var_30_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_30_8.position).x, (manager.ui.mainCamera.transform.position - var_30_8.position).y, (manager.ui.mainCamera.transform.position - var_30_8.position).z)
				var_30_8.localEulerAngles.z = 0
				var_30_8.localEulerAngles.x = 0
				var_30_8.localEulerAngles = var_30_8.localEulerAngles
			end

			if arg_27_1.time_ >= 0 + var_30_9 and arg_27_1.time_ < 0 + var_30_9 + arg_30_0 then
				var_30_8.localPosition = Vector3.New(-0.7, -0.99, -5.83)
				var_30_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_30_8.position).x, (manager.ui.mainCamera.transform.position - var_30_8.position).y, (manager.ui.mainCamera.transform.position - var_30_8.position).z)
				var_30_8.localEulerAngles.z = 0
				var_30_8.localEulerAngles.x = 0
				var_30_8.localEulerAngles = var_30_8.localEulerAngles
			end

			local var_30_10 = 0
			local var_30_11 = 0.3

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= var_30_10 + arg_30_0 then
				arg_27_1.talkMaxDuration = 0
				arg_27_1.dialogCg_.alpha = 1

				arg_27_1.dialog_:SetActive(true)
				SetActive(arg_27_1.leftNameGo_, true)

				arg_27_1.leftNameTxt_.text = arg_27_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_27_1.leftNameTxt_.transform)

				arg_27_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_27_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_27_1:RecordName(arg_27_1.leftNameTxt_.text)
				SetActive(arg_27_1.iconTrs_.gameObject, false)
				arg_27_1.callingController_:SetSelectedState("normal")

				local var_30_12 = arg_27_1:GetWordFromCfg(319801006)
				local var_30_13 = arg_27_1:FormatText(var_30_12.content)

				arg_27_1.text_.text = var_30_13

				LuaForUtil.ClearLinePrefixSymbol(arg_27_1.text_)

				local var_30_15 = 12 <= 0 and var_30_11 or var_30_11 * (utf8.len(var_30_13) / 12)

				if (12 <= 0 and var_30_11 or var_30_11 * (utf8.len(var_30_13) / 12)) > 0 and var_30_11 < var_30_15 then
					arg_27_1.talkMaxDuration = var_30_15

					if var_30_15 + var_30_10 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_15 + var_30_10
					end
				end

				arg_27_1.text_.text = var_30_13
				arg_27_1.typewritter.percent = 0

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319801", "319801006", "story_v_out_319801.awb") ~= 0 then
					local var_30_16 = manager.audio:GetVoiceLength("story_v_out_319801", "319801006", "story_v_out_319801.awb") / 1000

					if var_30_16 + var_30_10 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_16 + var_30_10
					end

					if var_30_12.prefab_name ~= "" and arg_27_1.actors_[var_30_12.prefab_name] ~= nil then
						local var_30_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_27_1.actors_[var_30_12.prefab_name].transform, "story_v_out_319801", "319801006", "story_v_out_319801.awb")

						arg_27_1:RecordAudio("319801006", var_30_17)
						arg_27_1:RecordAudio("319801006", var_30_17)
					else
						arg_27_1:AudioAction("play", "voice", "story_v_out_319801", "319801006", "story_v_out_319801.awb")
					end

					arg_27_1:RecordHistoryTalkVoice("story_v_out_319801", "319801006", "story_v_out_319801.awb")
				end

				arg_27_1:RecordContent(arg_27_1.text_.text)
			end

			local var_30_18 = math.max(var_30_11, arg_27_1.talkMaxDuration)

			if var_30_10 <= arg_27_1.time_ and arg_27_1.time_ < var_30_10 + var_30_18 then
				arg_27_1.typewritter.percent = (arg_27_1.time_ - var_30_10) / var_30_18

				arg_27_1.typewritter:SetDirty()
			end

			if arg_27_1.time_ >= var_30_10 + var_30_18 and arg_27_1.time_ < var_30_10 + var_30_18 + arg_30_0 then
				arg_27_1.typewritter.percent = 1

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(true)
			end
		end

		arg_27_1.nodeConfigList_ = {
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
				actorName = "10066ui_story",
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
	Play319801007 = function(arg_31_0, arg_31_1)
		arg_31_1.time_ = 0
		arg_31_1.frameCnt_ = 0
		arg_31_1.state_ = "playing"
		arg_31_1.curTalkId_ = 319801007
		arg_31_1.duration_ = 5

		SetActive(arg_31_1.tipsGo_, false)

		function arg_31_1.onSingleLineFinish_()
			arg_31_1.onSingleLineUpdate_ = nil
			arg_31_1.onSingleLineFinish_ = nil
			arg_31_1.state_ = "waiting"
		end

		function arg_31_1.playNext_(arg_33_0)
			if arg_33_0 == 1 then
				arg_31_0:Play319801008(arg_31_1)
			end
		end

		function arg_31_1.onSingleLineUpdate_(arg_34_0)
			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 and not isNil(arg_31_1.actors_["1084ui_story"]) and arg_31_1.var_.characterEffect1084ui_story == nil then
				arg_31_1.var_.characterEffect1084ui_story = arg_31_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_34_0 = 0.200000002980232

			if 0 <= arg_31_1.time_ and arg_31_1.time_ < 0 + var_34_0 and not isNil(arg_31_1.actors_["1084ui_story"]) then
				if arg_31_1.var_.characterEffect1084ui_story and not isNil(arg_31_1.actors_["1084ui_story"]) then
					arg_31_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_31_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_31_1.time_ - 0) / var_34_0)
				end
			end

			if arg_31_1.time_ >= 0 + var_34_0 and arg_31_1.time_ < 0 + var_34_0 + arg_34_0 and not isNil(arg_31_1.actors_["1084ui_story"]) and arg_31_1.var_.characterEffect1084ui_story then
				arg_31_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_31_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_34_1 = 0
			local var_34_2 = 1.075

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= var_34_1 + arg_34_0 then
				arg_31_1.talkMaxDuration = 0
				arg_31_1.dialogCg_.alpha = 1

				arg_31_1.dialog_:SetActive(true)
				SetActive(arg_31_1.leftNameGo_, true)

				arg_31_1.leftNameTxt_.text = arg_31_1:FormatText(StoryNameCfg[698].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_31_1.leftNameTxt_.transform)

				arg_31_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_31_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_31_1:RecordName(arg_31_1.leftNameTxt_.text)
				SetActive(arg_31_1.iconTrs_.gameObject, true)
				arg_31_1.iconController_:SetSelectedState("hero")

				arg_31_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10073")

				arg_31_1.callingController_:SetSelectedState("normal")

				arg_31_1.keyicon_.color = Color.New(1, 1, 1)
				arg_31_1.icon_.color = Color.New(1, 1, 1)

				local var_34_3 = arg_31_1:FormatText(arg_31_1:GetWordFromCfg(319801007).content)

				arg_31_1.text_.text = var_34_3

				LuaForUtil.ClearLinePrefixSymbol(arg_31_1.text_)

				local var_34_5 = 43 <= 0 and var_34_2 or var_34_2 * (utf8.len(var_34_3) / 43)

				if (43 <= 0 and var_34_2 or var_34_2 * (utf8.len(var_34_3) / 43)) > 0 and var_34_2 < var_34_5 then
					arg_31_1.talkMaxDuration = var_34_5

					if var_34_5 + var_34_1 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_5 + var_34_1
					end
				end

				arg_31_1.text_.text = var_34_3
				arg_31_1.typewritter.percent = 0

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(false)
				arg_31_1:RecordContent(arg_31_1.text_.text)
			end

			local var_34_6 = math.max(var_34_2, arg_31_1.talkMaxDuration)

			if var_34_1 <= arg_31_1.time_ and arg_31_1.time_ < var_34_1 + var_34_6 then
				arg_31_1.typewritter.percent = (arg_31_1.time_ - var_34_1) / var_34_6

				arg_31_1.typewritter:SetDirty()
			end

			if arg_31_1.time_ >= var_34_1 + var_34_6 and arg_31_1.time_ < var_34_1 + var_34_6 + arg_34_0 then
				arg_31_1.typewritter.percent = 1

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(true)
			end
		end

		arg_31_1.nodeConfigList_ = {}

		arg_31_1:InitPlayNodeList()
	end,
	Play319801008 = function(arg_35_0, arg_35_1)
		arg_35_1.time_ = 0
		arg_35_1.frameCnt_ = 0
		arg_35_1.state_ = "playing"
		arg_35_1.curTalkId_ = 319801008
		arg_35_1.duration_ = 5

		SetActive(arg_35_1.tipsGo_, false)

		function arg_35_1.onSingleLineFinish_()
			arg_35_1.onSingleLineUpdate_ = nil
			arg_35_1.onSingleLineFinish_ = nil
			arg_35_1.state_ = "waiting"
		end

		function arg_35_1.playNext_(arg_37_0)
			if arg_37_0 == 1 then
				arg_35_0:Play319801009(arg_35_1)
			end
		end

		function arg_35_1.onSingleLineUpdate_(arg_38_0)
			local var_38_0 = 0.575

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 then
				arg_35_1.talkMaxDuration = 0
				arg_35_1.dialogCg_.alpha = 1

				arg_35_1.dialog_:SetActive(true)
				SetActive(arg_35_1.leftNameGo_, true)

				arg_35_1.leftNameTxt_.text = arg_35_1:FormatText(StoryNameCfg[698].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_35_1.leftNameTxt_.transform)

				arg_35_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_35_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_35_1:RecordName(arg_35_1.leftNameTxt_.text)
				SetActive(arg_35_1.iconTrs_.gameObject, true)
				arg_35_1.iconController_:SetSelectedState("hero")

				arg_35_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10073")

				arg_35_1.callingController_:SetSelectedState("normal")

				arg_35_1.keyicon_.color = Color.New(1, 1, 1)
				arg_35_1.icon_.color = Color.New(1, 1, 1)

				local var_38_1 = arg_35_1:FormatText(arg_35_1:GetWordFromCfg(319801008).content)

				arg_35_1.text_.text = var_38_1

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_3 = 23 <= 0 and var_38_0 or var_38_0 * (utf8.len(var_38_1) / 23)

				if (23 <= 0 and var_38_0 or var_38_0 * (utf8.len(var_38_1) / 23)) > 0 and var_38_0 < var_38_3 then
					arg_35_1.talkMaxDuration = var_38_3

					if var_38_3 + 0 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_3 + 0
					end
				end

				arg_35_1.text_.text = var_38_1
				arg_35_1.typewritter.percent = 0

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(false)
				arg_35_1:RecordContent(arg_35_1.text_.text)
			end

			local var_38_4 = math.max(var_38_0, arg_35_1.talkMaxDuration)

			if 0 <= arg_35_1.time_ and arg_35_1.time_ < 0 + var_38_4 then
				arg_35_1.typewritter.percent = (arg_35_1.time_ - 0) / var_38_4

				arg_35_1.typewritter:SetDirty()
			end

			if arg_35_1.time_ >= 0 + var_38_4 and arg_35_1.time_ < 0 + var_38_4 + arg_38_0 then
				arg_35_1.typewritter.percent = 1

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(true)
			end
		end

		arg_35_1.nodeConfigList_ = {}

		arg_35_1:InitPlayNodeList()
	end,
	Play319801009 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 319801009
		arg_39_1.duration_ = 9.87

		local var_39_0 = {
			zh = 7.63266666666667,
			ja = 9.86666666666667
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
				arg_39_0:Play319801010(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			if arg_39_1.bgs_.ST71a == nil then
				local var_42_0 = Object.Instantiate(arg_39_1.paintGo_)

				var_42_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST71a")
				var_42_0.name = "ST71a"
				var_42_0.transform.parent = arg_39_1.stage_.transform
				var_42_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_39_1.bgs_.ST71a = var_42_0
			end

			if 1 < arg_39_1.time_ and arg_39_1.time_ <= 1 + arg_42_0 then
				local var_42_1 = arg_39_1.bgs_.ST71a

				arg_39_1.bgs_.ST71a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_42_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_42_2 = var_42_1:GetComponent("SpriteRenderer")

				if var_42_2 and var_42_2.sprite then
					local var_42_3 = 2 * (var_42_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_42_1.transform.localScale = Vector3.New(var_42_3 / var_42_2.sprite.bounds.size.y < var_42_3 * manager.ui.mainCameraCom_.aspect / var_42_2.sprite.bounds.size.x and var_42_3 * manager.ui.mainCameraCom_.aspect / var_42_2.sprite.bounds.size.x or var_42_3 / var_42_2.sprite.bounds.size.y, var_42_3 / var_42_2.sprite.bounds.size.y < var_42_3 * manager.ui.mainCameraCom_.aspect / var_42_2.sprite.bounds.size.x and var_42_3 * manager.ui.mainCameraCom_.aspect / var_42_2.sprite.bounds.size.x or var_42_3 / var_42_2.sprite.bounds.size.y, 0)
				end

				for iter_42_0, iter_42_1 in pairs(arg_39_1.bgs_) do
					if iter_42_0 ~= "ST71a" then
						iter_42_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_42_4 = 0

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= var_42_4 + arg_42_0 then
				arg_39_1.allBtn_.enabled = false
			end

			if arg_39_1.time_ >= var_42_4 + 0.3 and arg_39_1.time_ < var_42_4 + 0.3 + arg_42_0 then
				arg_39_1.allBtn_.enabled = true
			end

			local var_42_5 = 0

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= var_42_5 + arg_42_0 then
				arg_39_1.mask_.enabled = true
				arg_39_1.mask_.raycastTarget = true

				arg_39_1:SetGaussion(false)
			end

			local var_42_6 = 1

			if var_42_5 <= arg_39_1.time_ and arg_39_1.time_ < var_42_5 + var_42_6 then
				local var_42_7 = Color.New(0, 0, 0)

				var_42_7.a = Mathf.Lerp(0, 1, (arg_39_1.time_ - var_42_5) / var_42_6)
				arg_39_1.mask_.color = var_42_7
			end

			if arg_39_1.time_ >= var_42_5 + var_42_6 and arg_39_1.time_ < var_42_5 + var_42_6 + arg_42_0 then
				local var_42_8 = Color.New(0, 0, 0)

				var_42_8.a = 1
				arg_39_1.mask_.color = var_42_8
			end

			local var_42_9 = 1

			if 1 < arg_39_1.time_ and arg_39_1.time_ <= var_42_9 + arg_42_0 then
				arg_39_1.mask_.enabled = true
				arg_39_1.mask_.raycastTarget = true

				arg_39_1:SetGaussion(false)
			end

			local var_42_10 = 2

			if var_42_9 <= arg_39_1.time_ and arg_39_1.time_ < var_42_9 + var_42_10 then
				local var_42_11 = Color.New(0, 0, 0)

				var_42_11.a = Mathf.Lerp(1, 0, (arg_39_1.time_ - var_42_9) / var_42_10)
				arg_39_1.mask_.color = var_42_11
			end

			if arg_39_1.time_ >= var_42_9 + var_42_10 and arg_39_1.time_ < var_42_9 + var_42_10 + arg_42_0 then
				local var_42_12 = Color.New(0, 0, 0)

				arg_39_1.mask_.enabled = false
				var_42_12.a = 0
				arg_39_1.mask_.color = var_42_12
			end

			local var_42_13 = arg_39_1.actors_["10066ui_story"].transform

			if 1 < arg_39_1.time_ and arg_39_1.time_ <= 1 + arg_42_0 then
				arg_39_1.var_.moveOldPos10066ui_story = var_42_13.localPosition
			end

			local var_42_14 = 0.001

			if 1 <= arg_39_1.time_ and arg_39_1.time_ < 1 + var_42_14 then
				var_42_13.localPosition = Vector3.Lerp(arg_39_1.var_.moveOldPos10066ui_story, Vector3.New(0, 100, 0), (arg_39_1.time_ - 1) / var_42_14)
				var_42_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_42_13.position).x, (manager.ui.mainCamera.transform.position - var_42_13.position).y, (manager.ui.mainCamera.transform.position - var_42_13.position).z)
				var_42_13.localEulerAngles.z = 0
				var_42_13.localEulerAngles.x = 0
				var_42_13.localEulerAngles = var_42_13.localEulerAngles
			end

			if arg_39_1.time_ >= 1 + var_42_14 and arg_39_1.time_ < 1 + var_42_14 + arg_42_0 then
				var_42_13.localPosition = Vector3.New(0, 100, 0)
				var_42_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_42_13.position).x, (manager.ui.mainCamera.transform.position - var_42_13.position).y, (manager.ui.mainCamera.transform.position - var_42_13.position).z)
				var_42_13.localEulerAngles.z = 0
				var_42_13.localEulerAngles.x = 0
				var_42_13.localEulerAngles = var_42_13.localEulerAngles
			end

			local var_42_15 = arg_39_1.actors_["1084ui_story"].transform

			if 1 < arg_39_1.time_ and arg_39_1.time_ <= 1 + arg_42_0 then
				arg_39_1.var_.moveOldPos1084ui_story = var_42_15.localPosition
			end

			local var_42_16 = 0.001

			if 1 <= arg_39_1.time_ and arg_39_1.time_ < 1 + var_42_16 then
				var_42_15.localPosition = Vector3.Lerp(arg_39_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_39_1.time_ - 1) / var_42_16)
				var_42_15.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_42_15.position).x, (manager.ui.mainCamera.transform.position - var_42_15.position).y, (manager.ui.mainCamera.transform.position - var_42_15.position).z)
				var_42_15.localEulerAngles.z = 0
				var_42_15.localEulerAngles.x = 0
				var_42_15.localEulerAngles = var_42_15.localEulerAngles
			end

			if arg_39_1.time_ >= 1 + var_42_16 and arg_39_1.time_ < 1 + var_42_16 + arg_42_0 then
				var_42_15.localPosition = Vector3.New(0, 100, 0)
				var_42_15.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_42_15.position).x, (manager.ui.mainCamera.transform.position - var_42_15.position).y, (manager.ui.mainCamera.transform.position - var_42_15.position).z)
				var_42_15.localEulerAngles.z = 0
				var_42_15.localEulerAngles.x = 0
				var_42_15.localEulerAngles = var_42_15.localEulerAngles
			end

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 then
				arg_39_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_42_19 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_39_1.bgmTxt_.text ~= var_42_19 and arg_39_1.bgmTxt_.text ~= "" then
						if arg_39_1.bgmTxt2_.text ~= "" then
							arg_39_1.bgmTxt_.text = arg_39_1.bgmTxt2_.text
						end

						arg_39_1.bgmTxt2_.text = var_42_19

						arg_39_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_39_1.bgmTxt_.text = var_42_19
						arg_39_1.bgmTxt2_.text = var_42_19
					end

					if arg_39_1.bgmTimer then
						arg_39_1.bgmTimer:Stop()

						arg_39_1.bgmTimer = nil
					end

					if arg_39_1.settingData.show_music_name == 1 then
						arg_39_1.musicController:SetSelectedState("show")
						arg_39_1.musicAnimator_:Play("open", 0, 0)

						if arg_39_1.settingData.music_time ~= 0 then
							arg_39_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_39_1.settingData.music_time), function()
								if arg_39_1 == nil or isNil(arg_39_1.bgmTxt_) then
									return
								end

								arg_39_1.musicController:SetSelectedState("hide")
								arg_39_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.233333333333333 < arg_39_1.time_ and arg_39_1.time_ <= 0.233333333333333 + arg_42_0 then
				arg_39_1:AudioAction("play", "music", "bgm_activity_3_0_story_hospital_room", "bgm_activity_3_0_story_hospital_room", "bgm_activity_3_0_story_hospital_room.awb")

				local var_42_22 = manager.audio:GetAudioName("bgm_activity_3_0_story_hospital_room", "bgm_activity_3_0_story_hospital_room")

				if "" ~= "" then
					if arg_39_1.bgmTxt_.text ~= var_42_22 and arg_39_1.bgmTxt_.text ~= "" then
						if arg_39_1.bgmTxt2_.text ~= "" then
							arg_39_1.bgmTxt_.text = arg_39_1.bgmTxt2_.text
						end

						arg_39_1.bgmTxt2_.text = var_42_22

						arg_39_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_39_1.bgmTxt_.text = var_42_22
						arg_39_1.bgmTxt2_.text = var_42_22
					end

					if arg_39_1.bgmTimer then
						arg_39_1.bgmTimer:Stop()

						arg_39_1.bgmTimer = nil
					end

					if arg_39_1.settingData.show_music_name == 1 then
						arg_39_1.musicController:SetSelectedState("show")
						arg_39_1.musicAnimator_:Play("open", 0, 0)

						if arg_39_1.settingData.music_time ~= 0 then
							arg_39_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_39_1.settingData.music_time), function()
								if arg_39_1 == nil or isNil(arg_39_1.bgmTxt_) then
									return
								end

								arg_39_1.musicController:SetSelectedState("hide")
								arg_39_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_39_1.frameCnt_ <= 1 then
				arg_39_1.dialog_:SetActive(false)
			end

			local var_42_23 = 2.86666666666667
			local var_42_24 = 0.325

			if 2.86666666666667 < arg_39_1.time_ and arg_39_1.time_ <= var_42_23 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0

				arg_39_1.dialog_:SetActive(true)

				arg_39_1.dialogCg_.alpha = 0

				local var_42_25 = LeanTween.value(arg_39_1.dialog_, 0, 1, 0.3)

				var_42_25:setOnUpdate(LuaHelper.FloatAction(function(arg_45_0)
					arg_39_1.dialogCg_.alpha = arg_45_0
				end))
				var_42_25:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_39_1.dialog_)
					var_42_25:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_39_1.duration_ = arg_39_1.duration_ + 0.3

				SetActive(arg_39_1.leftNameGo_, true)

				arg_39_1.leftNameTxt_.text = arg_39_1:FormatText(StoryNameCfg[640].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_39_1.leftNameTxt_.transform)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1.leftNameTxt_.text)
				SetActive(arg_39_1.iconTrs_.gameObject, true)
				arg_39_1.iconController_:SetSelectedState("hero")

				arg_39_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10066")

				arg_39_1.callingController_:SetSelectedState("normal")

				arg_39_1.keyicon_.color = Color.New(1, 1, 1)
				arg_39_1.icon_.color = Color.New(1, 1, 1)

				local var_42_26 = arg_39_1:GetWordFromCfg(319801009)
				local var_42_27 = arg_39_1:FormatText(var_42_26.content)

				arg_39_1.text_.text = var_42_27

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_29 = 13 <= 0 and var_42_24 or var_42_24 * (utf8.len(var_42_27) / 13)

				if (13 <= 0 and var_42_24 or var_42_24 * (utf8.len(var_42_27) / 13)) > 0 and var_42_24 < var_42_29 then
					arg_39_1.talkMaxDuration = var_42_29
					var_42_23 = var_42_23 + 0.3

					if var_42_29 + var_42_23 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_29 + var_42_23
					end
				end

				arg_39_1.text_.text = var_42_27
				arg_39_1.typewritter.percent = 0

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319801", "319801009", "story_v_out_319801.awb") ~= 0 then
					local var_42_30 = manager.audio:GetVoiceLength("story_v_out_319801", "319801009", "story_v_out_319801.awb") / 1000

					if var_42_30 + var_42_23 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_30 + var_42_23
					end

					if var_42_26.prefab_name ~= "" and arg_39_1.actors_[var_42_26.prefab_name] ~= nil then
						local var_42_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_39_1.actors_[var_42_26.prefab_name].transform, "story_v_out_319801", "319801009", "story_v_out_319801.awb")

						arg_39_1:RecordAudio("319801009", var_42_31)
						arg_39_1:RecordAudio("319801009", var_42_31)
					else
						arg_39_1:AudioAction("play", "voice", "story_v_out_319801", "319801009", "story_v_out_319801.awb")
					end

					arg_39_1:RecordHistoryTalkVoice("story_v_out_319801", "319801009", "story_v_out_319801.awb")
				end

				arg_39_1:RecordContent(arg_39_1.text_.text)
			end

			local var_42_32 = var_42_23 + 0.3
			local var_42_33 = math.max(var_42_24, arg_39_1.talkMaxDuration)

			if var_42_23 + 0.3 <= arg_39_1.time_ and arg_39_1.time_ < var_42_32 + var_42_33 then
				arg_39_1.typewritter.percent = (arg_39_1.time_ - var_42_32) / var_42_33

				arg_39_1.typewritter:SetDirty()
			end

			if arg_39_1.time_ >= var_42_32 + var_42_33 and arg_39_1.time_ < var_42_32 + var_42_33 + arg_42_0 then
				arg_39_1.typewritter.percent = 1

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(true)
			end
		end

		arg_39_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_39_1:InitPlayNodeList()
	end,
	Play319801010 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 319801010
		arg_47_1.duration_ = 5

		SetActive(arg_47_1.tipsGo_, false)

		function arg_47_1.onSingleLineFinish_()
			arg_47_1.onSingleLineUpdate_ = nil
			arg_47_1.onSingleLineFinish_ = nil
			arg_47_1.state_ = "waiting"
		end

		function arg_47_1.playNext_(arg_49_0)
			if arg_49_0 == 1 then
				arg_47_0:Play319801011(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 and not isNil(arg_47_1.actors_["10066ui_story"]) and arg_47_1.var_.characterEffect10066ui_story == nil then
				arg_47_1.var_.characterEffect10066ui_story = arg_47_1.actors_["10066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_50_0 = 0.200000002980232

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_0 and not isNil(arg_47_1.actors_["10066ui_story"]) then
				if arg_47_1.var_.characterEffect10066ui_story and not isNil(arg_47_1.actors_["10066ui_story"]) then
					arg_47_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_47_1.var_.characterEffect10066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_47_1.time_ - 0) / var_50_0)
				end
			end

			if arg_47_1.time_ >= 0 + var_50_0 and arg_47_1.time_ < 0 + var_50_0 + arg_50_0 and not isNil(arg_47_1.actors_["10066ui_story"]) and arg_47_1.var_.characterEffect10066ui_story then
				arg_47_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_47_1.var_.characterEffect10066ui_story.fillRatio = 0.5
			end

			local var_50_1 = 0
			local var_50_2 = 1.3

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= var_50_1 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0
				arg_47_1.dialogCg_.alpha = 1

				arg_47_1.dialog_:SetActive(true)
				SetActive(arg_47_1.leftNameGo_, false)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_47_1.iconTrs_.gameObject, false)
				arg_47_1.callingController_:SetSelectedState("normal")

				local var_50_3 = arg_47_1:FormatText(arg_47_1:GetWordFromCfg(319801010).content)

				arg_47_1.text_.text = var_50_3

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_5 = 52 <= 0 and var_50_2 or var_50_2 * (utf8.len(var_50_3) / 52)

				if (52 <= 0 and var_50_2 or var_50_2 * (utf8.len(var_50_3) / 52)) > 0 and var_50_2 < var_50_5 then
					arg_47_1.talkMaxDuration = var_50_5

					if var_50_5 + var_50_1 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_5 + var_50_1
					end
				end

				arg_47_1.text_.text = var_50_3
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)
				arg_47_1:RecordContent(arg_47_1.text_.text)
			end

			local var_50_6 = math.max(var_50_2, arg_47_1.talkMaxDuration)

			if var_50_1 <= arg_47_1.time_ and arg_47_1.time_ < var_50_1 + var_50_6 then
				arg_47_1.typewritter.percent = (arg_47_1.time_ - var_50_1) / var_50_6

				arg_47_1.typewritter:SetDirty()
			end

			if arg_47_1.time_ >= var_50_1 + var_50_6 and arg_47_1.time_ < var_50_1 + var_50_6 + arg_50_0 then
				arg_47_1.typewritter.percent = 1

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(true)
			end
		end

		arg_47_1.nodeConfigList_ = {}

		arg_47_1:InitPlayNodeList()
	end,
	Play319801011 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 319801011
		arg_51_1.duration_ = 5

		SetActive(arg_51_1.tipsGo_, false)

		function arg_51_1.onSingleLineFinish_()
			arg_51_1.onSingleLineUpdate_ = nil
			arg_51_1.onSingleLineFinish_ = nil
			arg_51_1.state_ = "waiting"
		end

		function arg_51_1.playNext_(arg_53_0)
			if arg_53_0 == 1 then
				arg_51_0:Play319801012(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			local var_54_0 = 0.725

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, false)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_51_1.iconTrs_.gameObject, false)
				arg_51_1.callingController_:SetSelectedState("normal")

				local var_54_1 = arg_51_1:FormatText(arg_51_1:GetWordFromCfg(319801011).content)

				arg_51_1.text_.text = var_54_1

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_3 = 29 <= 0 and var_54_0 or var_54_0 * (utf8.len(var_54_1) / 29)

				if (29 <= 0 and var_54_0 or var_54_0 * (utf8.len(var_54_1) / 29)) > 0 and var_54_0 < var_54_3 then
					arg_51_1.talkMaxDuration = var_54_3

					if var_54_3 + 0 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_3 + 0
					end
				end

				arg_51_1.text_.text = var_54_1
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)
				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_4 = math.max(var_54_0, arg_51_1.talkMaxDuration)

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_4 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - 0) / var_54_4

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= 0 + var_54_4 and arg_51_1.time_ < 0 + var_54_4 + arg_54_0 then
				arg_51_1.typewritter.percent = 1

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(true)
			end
		end

		arg_51_1.nodeConfigList_ = {}

		arg_51_1:InitPlayNodeList()
	end,
	Play319801012 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 319801012
		arg_55_1.duration_ = 4.1

		local var_55_0 = {
			zh = 1.999999999999,
			ja = 4.1
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
				arg_55_0:Play319801013(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			if arg_55_1.actors_["10050ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10050ui_story"))) then
				local var_58_0 = Object.Instantiate(Asset.Load("Char/" .. "10050ui_story"), arg_55_1.stage_.transform)

				var_58_0.name = "10050ui_story"
				var_58_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_55_1.actors_["10050ui_story"] = var_58_0

				local var_58_1 = var_58_0:GetComponentInChildren(typeof(CharacterEffect))

				var_58_1.enabled = true

				local var_58_2 = GameObjectTools.GetOrAddComponent(var_58_0, typeof(DynamicBoneHelper))

				if var_58_2 then
					var_58_2:EnableDynamicBone(false)
				end

				arg_55_1:ShowWeapon(var_58_1.transform, false)

				arg_55_1.var_["10050ui_story" .. "Animator"] = var_58_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_55_1.var_["10050ui_story" .. "Animator"].applyRootMotion = true
				arg_55_1.var_["10050ui_story" .. "LipSync"] = var_58_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_58_3 = arg_55_1.actors_["10050ui_story"].transform

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 then
				arg_55_1.var_.moveOldPos10050ui_story = var_58_3.localPosition
			end

			local var_58_4 = 0.001

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_4 then
				var_58_3.localPosition = Vector3.Lerp(arg_55_1.var_.moveOldPos10050ui_story, Vector3.New(0, -0.715, -6.15), (arg_55_1.time_ - 0) / var_58_4)
				var_58_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_58_3.position).x, (manager.ui.mainCamera.transform.position - var_58_3.position).y, (manager.ui.mainCamera.transform.position - var_58_3.position).z)
				var_58_3.localEulerAngles.z = 0
				var_58_3.localEulerAngles.x = 0
				var_58_3.localEulerAngles = var_58_3.localEulerAngles
			end

			if arg_55_1.time_ >= 0 + var_58_4 and arg_55_1.time_ < 0 + var_58_4 + arg_58_0 then
				var_58_3.localPosition = Vector3.New(0, -0.715, -6.15)
				var_58_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_58_3.position).x, (manager.ui.mainCamera.transform.position - var_58_3.position).y, (manager.ui.mainCamera.transform.position - var_58_3.position).z)
				var_58_3.localEulerAngles.z = 0
				var_58_3.localEulerAngles.x = 0
				var_58_3.localEulerAngles = var_58_3.localEulerAngles
			end

			local var_58_5 = arg_55_1.actors_["10050ui_story"]

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 and not isNil(var_58_5) and arg_55_1.var_.characterEffect10050ui_story == nil then
				arg_55_1.var_.characterEffect10050ui_story = var_58_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_58_6 = 0.200000002980232

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_6 and not isNil(var_58_5) then
				if arg_55_1.var_.characterEffect10050ui_story and not isNil(var_58_5) then
					arg_55_1.var_.characterEffect10050ui_story.fillFlat = false
				end
			end

			if arg_55_1.time_ >= 0 + var_58_6 and arg_55_1.time_ < 0 + var_58_6 + arg_58_0 and not isNil(var_58_5) and arg_55_1.var_.characterEffect10050ui_story then
				arg_55_1.var_.characterEffect10050ui_story.fillFlat = false
			end

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 then
				arg_55_1:PlayTimeline("10050ui_story", "StoryTimeline/CharAction/story10050/story10050action/10050action2_1")
			end

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 then
				arg_55_1:PlayTimeline("10050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_58_8 = 0
			local var_58_9 = 0.2

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= var_58_8 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, true)

				arg_55_1.leftNameTxt_.text = arg_55_1:FormatText(StoryNameCfg[692].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_55_1.leftNameTxt_.transform)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1.leftNameTxt_.text)
				SetActive(arg_55_1.iconTrs_.gameObject, false)
				arg_55_1.callingController_:SetSelectedState("normal")

				local var_58_10 = arg_55_1:GetWordFromCfg(319801012)
				local var_58_11 = arg_55_1:FormatText(var_58_10.content)

				arg_55_1.text_.text = var_58_11

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_13 = 8 <= 0 and var_58_9 or var_58_9 * (utf8.len(var_58_11) / 8)

				if (8 <= 0 and var_58_9 or var_58_9 * (utf8.len(var_58_11) / 8)) > 0 and var_58_9 < var_58_13 then
					arg_55_1.talkMaxDuration = var_58_13

					if var_58_13 + var_58_8 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_13 + var_58_8
					end
				end

				arg_55_1.text_.text = var_58_11
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319801", "319801012", "story_v_out_319801.awb") ~= 0 then
					local var_58_14 = manager.audio:GetVoiceLength("story_v_out_319801", "319801012", "story_v_out_319801.awb") / 1000

					if var_58_14 + var_58_8 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_14 + var_58_8
					end

					if var_58_10.prefab_name ~= "" and arg_55_1.actors_[var_58_10.prefab_name] ~= nil then
						local var_58_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_55_1.actors_[var_58_10.prefab_name].transform, "story_v_out_319801", "319801012", "story_v_out_319801.awb")

						arg_55_1:RecordAudio("319801012", var_58_15)
						arg_55_1:RecordAudio("319801012", var_58_15)
					else
						arg_55_1:AudioAction("play", "voice", "story_v_out_319801", "319801012", "story_v_out_319801.awb")
					end

					arg_55_1:RecordHistoryTalkVoice("story_v_out_319801", "319801012", "story_v_out_319801.awb")
				end

				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_16 = math.max(var_58_9, arg_55_1.talkMaxDuration)

			if var_58_8 <= arg_55_1.time_ and arg_55_1.time_ < var_58_8 + var_58_16 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - var_58_8) / var_58_16

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= var_58_8 + var_58_16 and arg_55_1.time_ < var_58_8 + var_58_16 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end

		arg_55_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10050ui_story",
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
	Play319801013 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 319801013
		arg_59_1.duration_ = 7.1

		local var_59_0 = {
			zh = 3.433,
			ja = 7.1
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
				arg_59_0:Play319801014(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			if arg_59_1.actors_["10058ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10058ui_story"))) then
				local var_62_0 = Object.Instantiate(Asset.Load("Char/" .. "10058ui_story"), arg_59_1.stage_.transform)

				var_62_0.name = "10058ui_story"
				var_62_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_59_1.actors_["10058ui_story"] = var_62_0

				local var_62_1 = var_62_0:GetComponentInChildren(typeof(CharacterEffect))

				var_62_1.enabled = true

				local var_62_2 = GameObjectTools.GetOrAddComponent(var_62_0, typeof(DynamicBoneHelper))

				if var_62_2 then
					var_62_2:EnableDynamicBone(false)
				end

				arg_59_1:ShowWeapon(var_62_1.transform, false)

				arg_59_1.var_["10058ui_story" .. "Animator"] = var_62_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_59_1.var_["10058ui_story" .. "Animator"].applyRootMotion = true
				arg_59_1.var_["10058ui_story" .. "LipSync"] = var_62_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_62_3 = arg_59_1.actors_["10058ui_story"].transform

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 then
				arg_59_1.var_.moveOldPos10058ui_story = var_62_3.localPosition
			end

			local var_62_4 = 0.001

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_4 then
				var_62_3.localPosition = Vector3.Lerp(arg_59_1.var_.moveOldPos10058ui_story, Vector3.New(0.7, -0.98, -6.1), (arg_59_1.time_ - 0) / var_62_4)
				var_62_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_62_3.position).x, (manager.ui.mainCamera.transform.position - var_62_3.position).y, (manager.ui.mainCamera.transform.position - var_62_3.position).z)
				var_62_3.localEulerAngles.z = 0
				var_62_3.localEulerAngles.x = 0
				var_62_3.localEulerAngles = var_62_3.localEulerAngles
			end

			if arg_59_1.time_ >= 0 + var_62_4 and arg_59_1.time_ < 0 + var_62_4 + arg_62_0 then
				var_62_3.localPosition = Vector3.New(0.7, -0.98, -6.1)
				var_62_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_62_3.position).x, (manager.ui.mainCamera.transform.position - var_62_3.position).y, (manager.ui.mainCamera.transform.position - var_62_3.position).z)
				var_62_3.localEulerAngles.z = 0
				var_62_3.localEulerAngles.x = 0
				var_62_3.localEulerAngles = var_62_3.localEulerAngles
			end

			local var_62_5 = arg_59_1.actors_["10058ui_story"]

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 and not isNil(var_62_5) and arg_59_1.var_.characterEffect10058ui_story == nil then
				arg_59_1.var_.characterEffect10058ui_story = var_62_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_62_6 = 0.200000002980232

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_6 and not isNil(var_62_5) then
				if arg_59_1.var_.characterEffect10058ui_story and not isNil(var_62_5) then
					arg_59_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_59_1.time_ >= 0 + var_62_6 and arg_59_1.time_ < 0 + var_62_6 + arg_62_0 and not isNil(var_62_5) and arg_59_1.var_.characterEffect10058ui_story then
				arg_59_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 then
				arg_59_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 then
				arg_59_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_62_8 = arg_59_1.actors_["10050ui_story"].transform

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 then
				arg_59_1.var_.moveOldPos10050ui_story = var_62_8.localPosition
			end

			local var_62_9 = 0.001

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_9 then
				var_62_8.localPosition = Vector3.Lerp(arg_59_1.var_.moveOldPos10050ui_story, Vector3.New(-0.7, -0.715, -6.15), (arg_59_1.time_ - 0) / var_62_9)
				var_62_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_62_8.position).x, (manager.ui.mainCamera.transform.position - var_62_8.position).y, (manager.ui.mainCamera.transform.position - var_62_8.position).z)
				var_62_8.localEulerAngles.z = 0
				var_62_8.localEulerAngles.x = 0
				var_62_8.localEulerAngles = var_62_8.localEulerAngles
			end

			if arg_59_1.time_ >= 0 + var_62_9 and arg_59_1.time_ < 0 + var_62_9 + arg_62_0 then
				var_62_8.localPosition = Vector3.New(-0.7, -0.715, -6.15)
				var_62_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_62_8.position).x, (manager.ui.mainCamera.transform.position - var_62_8.position).y, (manager.ui.mainCamera.transform.position - var_62_8.position).z)
				var_62_8.localEulerAngles.z = 0
				var_62_8.localEulerAngles.x = 0
				var_62_8.localEulerAngles = var_62_8.localEulerAngles
			end

			local var_62_10 = arg_59_1.actors_["10050ui_story"]

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 and not isNil(var_62_10) and arg_59_1.var_.characterEffect10050ui_story == nil then
				arg_59_1.var_.characterEffect10050ui_story = var_62_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_62_11 = 0.200000002980232

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_11 and not isNil(var_62_10) then
				if arg_59_1.var_.characterEffect10050ui_story and not isNil(var_62_10) then
					arg_59_1.var_.characterEffect10050ui_story.fillFlat = true
					arg_59_1.var_.characterEffect10050ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_59_1.time_ - 0) / var_62_11)
				end
			end

			if arg_59_1.time_ >= 0 + var_62_11 and arg_59_1.time_ < 0 + var_62_11 + arg_62_0 and not isNil(var_62_10) and arg_59_1.var_.characterEffect10050ui_story then
				arg_59_1.var_.characterEffect10050ui_story.fillFlat = true
				arg_59_1.var_.characterEffect10050ui_story.fillRatio = 0.5
			end

			local var_62_12 = 0
			local var_62_13 = 0.35

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= var_62_12 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, true)

				arg_59_1.leftNameTxt_.text = arg_59_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_59_1.leftNameTxt_.transform)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1.leftNameTxt_.text)
				SetActive(arg_59_1.iconTrs_.gameObject, false)
				arg_59_1.callingController_:SetSelectedState("normal")

				local var_62_14 = arg_59_1:GetWordFromCfg(319801013)
				local var_62_15 = arg_59_1:FormatText(var_62_14.content)

				arg_59_1.text_.text = var_62_15

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_17 = 14 <= 0 and var_62_13 or var_62_13 * (utf8.len(var_62_15) / 14)

				if (14 <= 0 and var_62_13 or var_62_13 * (utf8.len(var_62_15) / 14)) > 0 and var_62_13 < var_62_17 then
					arg_59_1.talkMaxDuration = var_62_17

					if var_62_17 + var_62_12 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_17 + var_62_12
					end
				end

				arg_59_1.text_.text = var_62_15
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319801", "319801013", "story_v_out_319801.awb") ~= 0 then
					local var_62_18 = manager.audio:GetVoiceLength("story_v_out_319801", "319801013", "story_v_out_319801.awb") / 1000

					if var_62_18 + var_62_12 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_18 + var_62_12
					end

					if var_62_14.prefab_name ~= "" and arg_59_1.actors_[var_62_14.prefab_name] ~= nil then
						local var_62_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_59_1.actors_[var_62_14.prefab_name].transform, "story_v_out_319801", "319801013", "story_v_out_319801.awb")

						arg_59_1:RecordAudio("319801013", var_62_19)
						arg_59_1:RecordAudio("319801013", var_62_19)
					else
						arg_59_1:AudioAction("play", "voice", "story_v_out_319801", "319801013", "story_v_out_319801.awb")
					end

					arg_59_1:RecordHistoryTalkVoice("story_v_out_319801", "319801013", "story_v_out_319801.awb")
				end

				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_20 = math.max(var_62_13, arg_59_1.talkMaxDuration)

			if var_62_12 <= arg_59_1.time_ and arg_59_1.time_ < var_62_12 + var_62_20 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - var_62_12) / var_62_20

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= var_62_12 + var_62_20 and arg_59_1.time_ < var_62_12 + var_62_20 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end

		arg_59_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10050ui_story",
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
	Play319801014 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 319801014
		arg_63_1.duration_ = 5

		SetActive(arg_63_1.tipsGo_, false)

		function arg_63_1.onSingleLineFinish_()
			arg_63_1.onSingleLineUpdate_ = nil
			arg_63_1.onSingleLineFinish_ = nil
			arg_63_1.state_ = "waiting"
		end

		function arg_63_1.playNext_(arg_65_0)
			if arg_65_0 == 1 then
				arg_63_0:Play319801015(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 and not isNil(arg_63_1.actors_["10058ui_story"]) and arg_63_1.var_.characterEffect10058ui_story == nil then
				arg_63_1.var_.characterEffect10058ui_story = arg_63_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_66_0 = 0.200000002980232

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_0 and not isNil(arg_63_1.actors_["10058ui_story"]) then
				if arg_63_1.var_.characterEffect10058ui_story and not isNil(arg_63_1.actors_["10058ui_story"]) then
					arg_63_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_63_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_63_1.time_ - 0) / var_66_0)
				end
			end

			if arg_63_1.time_ >= 0 + var_66_0 and arg_63_1.time_ < 0 + var_66_0 + arg_66_0 and not isNil(arg_63_1.actors_["10058ui_story"]) and arg_63_1.var_.characterEffect10058ui_story then
				arg_63_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_63_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			local var_66_1 = 0
			local var_66_2 = 0.575

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= var_66_1 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, true)

				arg_63_1.leftNameTxt_.text = arg_63_1:FormatText(StoryNameCfg[698].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_63_1.leftNameTxt_.transform)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1.leftNameTxt_.text)
				SetActive(arg_63_1.iconTrs_.gameObject, true)
				arg_63_1.iconController_:SetSelectedState("hero")

				arg_63_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10073")

				arg_63_1.callingController_:SetSelectedState("normal")

				arg_63_1.keyicon_.color = Color.New(1, 1, 1)
				arg_63_1.icon_.color = Color.New(1, 1, 1)

				local var_66_3 = arg_63_1:FormatText(arg_63_1:GetWordFromCfg(319801014).content)

				arg_63_1.text_.text = var_66_3

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_5 = 23 <= 0 and var_66_2 or var_66_2 * (utf8.len(var_66_3) / 23)

				if (23 <= 0 and var_66_2 or var_66_2 * (utf8.len(var_66_3) / 23)) > 0 and var_66_2 < var_66_5 then
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
	Play319801015 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 319801015
		arg_67_1.duration_ = 5.5

		local var_67_0 = {
			zh = 4.666,
			ja = 5.5
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
		end

		function arg_67_1.playNext_(arg_69_0)
			if arg_69_0 == 1 then
				arg_67_0:Play319801016(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 and not isNil(arg_67_1.actors_["10050ui_story"]) and arg_67_1.var_.characterEffect10050ui_story == nil then
				arg_67_1.var_.characterEffect10050ui_story = arg_67_1.actors_["10050ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_70_0 = 0.200000002980232

			if 0 <= arg_67_1.time_ and arg_67_1.time_ < 0 + var_70_0 and not isNil(arg_67_1.actors_["10050ui_story"]) then
				if arg_67_1.var_.characterEffect10050ui_story and not isNil(arg_67_1.actors_["10050ui_story"]) then
					arg_67_1.var_.characterEffect10050ui_story.fillFlat = false
				end
			end

			if arg_67_1.time_ >= 0 + var_70_0 and arg_67_1.time_ < 0 + var_70_0 + arg_70_0 and not isNil(arg_67_1.actors_["10050ui_story"]) and arg_67_1.var_.characterEffect10050ui_story then
				arg_67_1.var_.characterEffect10050ui_story.fillFlat = false
			end

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 then
				arg_67_1:PlayTimeline("10050ui_story", "StoryTimeline/CharAction/story10050/story10050actionlink/10050action424")
			end

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 then
				arg_67_1:PlayTimeline("10050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_70_2 = 0
			local var_70_3 = 0.425

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= var_70_2 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, true)

				arg_67_1.leftNameTxt_.text = arg_67_1:FormatText(StoryNameCfg[692].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_67_1.leftNameTxt_.transform)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1.leftNameTxt_.text)
				SetActive(arg_67_1.iconTrs_.gameObject, false)
				arg_67_1.callingController_:SetSelectedState("normal")

				local var_70_4 = arg_67_1:GetWordFromCfg(319801015)
				local var_70_5 = arg_67_1:FormatText(var_70_4.content)

				arg_67_1.text_.text = var_70_5

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_7 = 17 <= 0 and var_70_3 or var_70_3 * (utf8.len(var_70_5) / 17)

				if (17 <= 0 and var_70_3 or var_70_3 * (utf8.len(var_70_5) / 17)) > 0 and var_70_3 < var_70_7 then
					arg_67_1.talkMaxDuration = var_70_7

					if var_70_7 + var_70_2 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_7 + var_70_2
					end
				end

				arg_67_1.text_.text = var_70_5
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319801", "319801015", "story_v_out_319801.awb") ~= 0 then
					local var_70_8 = manager.audio:GetVoiceLength("story_v_out_319801", "319801015", "story_v_out_319801.awb") / 1000

					if var_70_8 + var_70_2 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_8 + var_70_2
					end

					if var_70_4.prefab_name ~= "" and arg_67_1.actors_[var_70_4.prefab_name] ~= nil then
						local var_70_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_67_1.actors_[var_70_4.prefab_name].transform, "story_v_out_319801", "319801015", "story_v_out_319801.awb")

						arg_67_1:RecordAudio("319801015", var_70_9)
						arg_67_1:RecordAudio("319801015", var_70_9)
					else
						arg_67_1:AudioAction("play", "voice", "story_v_out_319801", "319801015", "story_v_out_319801.awb")
					end

					arg_67_1:RecordHistoryTalkVoice("story_v_out_319801", "319801015", "story_v_out_319801.awb")
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
	Play319801016 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 319801016
		arg_71_1.duration_ = 4.8

		local var_71_0 = {
			zh = 3.633,
			ja = 4.8
		}
		local var_71_1 = manager.audio:GetLocalizationFlag()

		if var_71_0[var_71_1] ~= nil then
			arg_71_1.duration_ = var_71_0[var_71_1]
		end

		SetActive(arg_71_1.tipsGo_, false)

		function arg_71_1.onSingleLineFinish_()
			arg_71_1.onSingleLineUpdate_ = nil
			arg_71_1.onSingleLineFinish_ = nil
			arg_71_1.state_ = "waiting"
		end

		function arg_71_1.playNext_(arg_73_0)
			if arg_73_0 == 1 then
				arg_71_0:Play319801017(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 and not isNil(arg_71_1.actors_["10058ui_story"]) and arg_71_1.var_.characterEffect10058ui_story == nil then
				arg_71_1.var_.characterEffect10058ui_story = arg_71_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_74_0 = 0.200000002980232

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_0 and not isNil(arg_71_1.actors_["10058ui_story"]) then
				if arg_71_1.var_.characterEffect10058ui_story and not isNil(arg_71_1.actors_["10058ui_story"]) then
					arg_71_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_71_1.time_ >= 0 + var_74_0 and arg_71_1.time_ < 0 + var_74_0 + arg_74_0 and not isNil(arg_71_1.actors_["10058ui_story"]) and arg_71_1.var_.characterEffect10058ui_story then
				arg_71_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action4_1")
			end

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_74_2 = arg_71_1.actors_["10050ui_story"]

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 and not isNil(var_74_2) and arg_71_1.var_.characterEffect10050ui_story == nil then
				arg_71_1.var_.characterEffect10050ui_story = var_74_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_74_3 = 0.200000002980232

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_3 and not isNil(var_74_2) then
				if arg_71_1.var_.characterEffect10050ui_story and not isNil(var_74_2) then
					arg_71_1.var_.characterEffect10050ui_story.fillFlat = true
					arg_71_1.var_.characterEffect10050ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_71_1.time_ - 0) / var_74_3)
				end
			end

			if arg_71_1.time_ >= 0 + var_74_3 and arg_71_1.time_ < 0 + var_74_3 + arg_74_0 and not isNil(var_74_2) and arg_71_1.var_.characterEffect10050ui_story then
				arg_71_1.var_.characterEffect10050ui_story.fillFlat = true
				arg_71_1.var_.characterEffect10050ui_story.fillRatio = 0.5
			end

			local var_74_4 = 0
			local var_74_5 = 0.425

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= var_74_4 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, true)

				arg_71_1.leftNameTxt_.text = arg_71_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_71_1.leftNameTxt_.transform)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1.leftNameTxt_.text)
				SetActive(arg_71_1.iconTrs_.gameObject, false)
				arg_71_1.callingController_:SetSelectedState("normal")

				local var_74_6 = arg_71_1:GetWordFromCfg(319801016)
				local var_74_7 = arg_71_1:FormatText(var_74_6.content)

				arg_71_1.text_.text = var_74_7

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_9 = 17 <= 0 and var_74_5 or var_74_5 * (utf8.len(var_74_7) / 17)

				if (17 <= 0 and var_74_5 or var_74_5 * (utf8.len(var_74_7) / 17)) > 0 and var_74_5 < var_74_9 then
					arg_71_1.talkMaxDuration = var_74_9

					if var_74_9 + var_74_4 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_9 + var_74_4
					end
				end

				arg_71_1.text_.text = var_74_7
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319801", "319801016", "story_v_out_319801.awb") ~= 0 then
					local var_74_10 = manager.audio:GetVoiceLength("story_v_out_319801", "319801016", "story_v_out_319801.awb") / 1000

					if var_74_10 + var_74_4 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_10 + var_74_4
					end

					if var_74_6.prefab_name ~= "" and arg_71_1.actors_[var_74_6.prefab_name] ~= nil then
						local var_74_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_71_1.actors_[var_74_6.prefab_name].transform, "story_v_out_319801", "319801016", "story_v_out_319801.awb")

						arg_71_1:RecordAudio("319801016", var_74_11)
						arg_71_1:RecordAudio("319801016", var_74_11)
					else
						arg_71_1:AudioAction("play", "voice", "story_v_out_319801", "319801016", "story_v_out_319801.awb")
					end

					arg_71_1:RecordHistoryTalkVoice("story_v_out_319801", "319801016", "story_v_out_319801.awb")
				end

				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_12 = math.max(var_74_5, arg_71_1.talkMaxDuration)

			if var_74_4 <= arg_71_1.time_ and arg_71_1.time_ < var_74_4 + var_74_12 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - var_74_4) / var_74_12

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= var_74_4 + var_74_12 and arg_71_1.time_ < var_74_4 + var_74_12 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {}

		arg_71_1:InitPlayNodeList()
	end,
	Play319801017 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 319801017
		arg_75_1.duration_ = 6.27

		local var_75_0 = {
			zh = 4.7,
			ja = 6.266
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
				arg_75_0:Play319801018(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 then
				arg_75_1.var_.moveOldPos1084ui_story = arg_75_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_78_0 = 0.001

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_0 then
				arg_75_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_75_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_75_1.time_ - 0) / var_78_0)
				arg_75_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_75_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_75_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_75_1.actors_["1084ui_story"].transform.position).z)
				arg_75_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_75_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_75_1.actors_["1084ui_story"].transform.localEulerAngles = arg_75_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_75_1.time_ >= 0 + var_78_0 and arg_75_1.time_ < 0 + var_78_0 + arg_78_0 then
				arg_75_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, -0.97, -6)
				arg_75_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_75_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_75_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_75_1.actors_["1084ui_story"].transform.position).z)
				arg_75_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_75_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_75_1.actors_["1084ui_story"].transform.localEulerAngles = arg_75_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_78_1 = arg_75_1.actors_["1084ui_story"]

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 and not isNil(var_78_1) and arg_75_1.var_.characterEffect1084ui_story == nil then
				arg_75_1.var_.characterEffect1084ui_story = var_78_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_78_2 = 0.200000002980232

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_2 and not isNil(var_78_1) then
				if arg_75_1.var_.characterEffect1084ui_story and not isNil(var_78_1) then
					arg_75_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_75_1.time_ >= 0 + var_78_2 and arg_75_1.time_ < 0 + var_78_2 + arg_78_0 and not isNil(var_78_1) and arg_75_1.var_.characterEffect1084ui_story then
				arg_75_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 then
				arg_75_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_78_4 = arg_75_1.actors_["10058ui_story"].transform

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 then
				arg_75_1.var_.moveOldPos10058ui_story = var_78_4.localPosition
			end

			local var_78_5 = 0.001

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_5 then
				var_78_4.localPosition = Vector3.Lerp(arg_75_1.var_.moveOldPos10058ui_story, Vector3.New(0, 100, 0), (arg_75_1.time_ - 0) / var_78_5)
				var_78_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_78_4.position).x, (manager.ui.mainCamera.transform.position - var_78_4.position).y, (manager.ui.mainCamera.transform.position - var_78_4.position).z)
				var_78_4.localEulerAngles.z = 0
				var_78_4.localEulerAngles.x = 0
				var_78_4.localEulerAngles = var_78_4.localEulerAngles
			end

			if arg_75_1.time_ >= 0 + var_78_5 and arg_75_1.time_ < 0 + var_78_5 + arg_78_0 then
				var_78_4.localPosition = Vector3.New(0, 100, 0)
				var_78_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_78_4.position).x, (manager.ui.mainCamera.transform.position - var_78_4.position).y, (manager.ui.mainCamera.transform.position - var_78_4.position).z)
				var_78_4.localEulerAngles.z = 0
				var_78_4.localEulerAngles.x = 0
				var_78_4.localEulerAngles = var_78_4.localEulerAngles
			end

			local var_78_6 = arg_75_1.actors_["10058ui_story"]

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 and not isNil(var_78_6) and arg_75_1.var_.characterEffect10058ui_story == nil then
				arg_75_1.var_.characterEffect10058ui_story = var_78_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_78_7 = 0.200000002980232

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_7 and not isNil(var_78_6) then
				if arg_75_1.var_.characterEffect10058ui_story and not isNil(var_78_6) then
					arg_75_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_75_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_75_1.time_ - 0) / var_78_7)
				end
			end

			if arg_75_1.time_ >= 0 + var_78_7 and arg_75_1.time_ < 0 + var_78_7 + arg_78_0 and not isNil(var_78_6) and arg_75_1.var_.characterEffect10058ui_story then
				arg_75_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_75_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			local var_78_8 = arg_75_1.actors_["10050ui_story"].transform

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 then
				arg_75_1.var_.moveOldPos10050ui_story = var_78_8.localPosition
			end

			local var_78_9 = 0.001

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_9 then
				var_78_8.localPosition = Vector3.Lerp(arg_75_1.var_.moveOldPos10050ui_story, Vector3.New(0, 100, 0), (arg_75_1.time_ - 0) / var_78_9)
				var_78_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_78_8.position).x, (manager.ui.mainCamera.transform.position - var_78_8.position).y, (manager.ui.mainCamera.transform.position - var_78_8.position).z)
				var_78_8.localEulerAngles.z = 0
				var_78_8.localEulerAngles.x = 0
				var_78_8.localEulerAngles = var_78_8.localEulerAngles
			end

			if arg_75_1.time_ >= 0 + var_78_9 and arg_75_1.time_ < 0 + var_78_9 + arg_78_0 then
				var_78_8.localPosition = Vector3.New(0, 100, 0)
				var_78_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_78_8.position).x, (manager.ui.mainCamera.transform.position - var_78_8.position).y, (manager.ui.mainCamera.transform.position - var_78_8.position).z)
				var_78_8.localEulerAngles.z = 0
				var_78_8.localEulerAngles.x = 0
				var_78_8.localEulerAngles = var_78_8.localEulerAngles
			end

			local var_78_10 = arg_75_1.actors_["10050ui_story"]

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 and not isNil(var_78_10) and arg_75_1.var_.characterEffect10050ui_story == nil then
				arg_75_1.var_.characterEffect10050ui_story = var_78_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_78_11 = 0.200000002980232

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_11 and not isNil(var_78_10) then
				if arg_75_1.var_.characterEffect10050ui_story and not isNil(var_78_10) then
					arg_75_1.var_.characterEffect10050ui_story.fillFlat = true
					arg_75_1.var_.characterEffect10050ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_75_1.time_ - 0) / var_78_11)
				end
			end

			if arg_75_1.time_ >= 0 + var_78_11 and arg_75_1.time_ < 0 + var_78_11 + arg_78_0 and not isNil(var_78_10) and arg_75_1.var_.characterEffect10050ui_story then
				arg_75_1.var_.characterEffect10050ui_story.fillFlat = true
				arg_75_1.var_.characterEffect10050ui_story.fillRatio = 0.5
			end

			local var_78_12 = 0
			local var_78_13 = 0.625

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= var_78_12 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, true)

				arg_75_1.leftNameTxt_.text = arg_75_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_75_1.leftNameTxt_.transform)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1.leftNameTxt_.text)
				SetActive(arg_75_1.iconTrs_.gameObject, false)
				arg_75_1.callingController_:SetSelectedState("normal")

				local var_78_14 = arg_75_1:GetWordFromCfg(319801017)
				local var_78_15 = arg_75_1:FormatText(var_78_14.content)

				arg_75_1.text_.text = var_78_15

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_17 = 25 <= 0 and var_78_13 or var_78_13 * (utf8.len(var_78_15) / 25)

				if (25 <= 0 and var_78_13 or var_78_13 * (utf8.len(var_78_15) / 25)) > 0 and var_78_13 < var_78_17 then
					arg_75_1.talkMaxDuration = var_78_17

					if var_78_17 + var_78_12 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_17 + var_78_12
					end
				end

				arg_75_1.text_.text = var_78_15
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319801", "319801017", "story_v_out_319801.awb") ~= 0 then
					local var_78_18 = manager.audio:GetVoiceLength("story_v_out_319801", "319801017", "story_v_out_319801.awb") / 1000

					if var_78_18 + var_78_12 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_18 + var_78_12
					end

					if var_78_14.prefab_name ~= "" and arg_75_1.actors_[var_78_14.prefab_name] ~= nil then
						local var_78_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_75_1.actors_[var_78_14.prefab_name].transform, "story_v_out_319801", "319801017", "story_v_out_319801.awb")

						arg_75_1:RecordAudio("319801017", var_78_19)
						arg_75_1:RecordAudio("319801017", var_78_19)
					else
						arg_75_1:AudioAction("play", "voice", "story_v_out_319801", "319801017", "story_v_out_319801.awb")
					end

					arg_75_1:RecordHistoryTalkVoice("story_v_out_319801", "319801017", "story_v_out_319801.awb")
				end

				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_20 = math.max(var_78_13, arg_75_1.talkMaxDuration)

			if var_78_12 <= arg_75_1.time_ and arg_75_1.time_ < var_78_12 + var_78_20 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - var_78_12) / var_78_20

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= var_78_12 + var_78_20 and arg_75_1.time_ < var_78_12 + var_78_20 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {
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
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10050ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_75_1:InitPlayNodeList()
	end,
	Play319801018 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 319801018
		arg_79_1.duration_ = 6.27

		local var_79_0 = {
			zh = 4.933,
			ja = 6.266
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
				arg_79_0:Play319801019(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1.var_.moveOldPos10050ui_story = arg_79_1.actors_["10050ui_story"].transform.localPosition
			end

			local var_82_0 = 0.001

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_0 then
				arg_79_1.actors_["10050ui_story"].transform.localPosition = Vector3.Lerp(arg_79_1.var_.moveOldPos10050ui_story, Vector3.New(0, -0.715, -6.15), (arg_79_1.time_ - 0) / var_82_0)
				arg_79_1.actors_["10050ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_79_1.actors_["10050ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_79_1.actors_["10050ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_79_1.actors_["10050ui_story"].transform.position).z)
				arg_79_1.actors_["10050ui_story"].transform.localEulerAngles.z = 0
				arg_79_1.actors_["10050ui_story"].transform.localEulerAngles.x = 0
				arg_79_1.actors_["10050ui_story"].transform.localEulerAngles = arg_79_1.actors_["10050ui_story"].transform.localEulerAngles
			end

			if arg_79_1.time_ >= 0 + var_82_0 and arg_79_1.time_ < 0 + var_82_0 + arg_82_0 then
				arg_79_1.actors_["10050ui_story"].transform.localPosition = Vector3.New(0, -0.715, -6.15)
				arg_79_1.actors_["10050ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_79_1.actors_["10050ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_79_1.actors_["10050ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_79_1.actors_["10050ui_story"].transform.position).z)
				arg_79_1.actors_["10050ui_story"].transform.localEulerAngles.z = 0
				arg_79_1.actors_["10050ui_story"].transform.localEulerAngles.x = 0
				arg_79_1.actors_["10050ui_story"].transform.localEulerAngles = arg_79_1.actors_["10050ui_story"].transform.localEulerAngles
			end

			local var_82_1 = arg_79_1.actors_["10050ui_story"]

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 and not isNil(var_82_1) and arg_79_1.var_.characterEffect10050ui_story == nil then
				arg_79_1.var_.characterEffect10050ui_story = var_82_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_82_2 = 0.200000002980232

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_2 and not isNil(var_82_1) then
				if arg_79_1.var_.characterEffect10050ui_story and not isNil(var_82_1) then
					arg_79_1.var_.characterEffect10050ui_story.fillFlat = false
				end
			end

			if arg_79_1.time_ >= 0 + var_82_2 and arg_79_1.time_ < 0 + var_82_2 + arg_82_0 and not isNil(var_82_1) and arg_79_1.var_.characterEffect10050ui_story then
				arg_79_1.var_.characterEffect10050ui_story.fillFlat = false
			end

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1:PlayTimeline("10050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1204cva")
			end

			local var_82_4 = arg_79_1.actors_["1084ui_story"].transform

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1.var_.moveOldPos1084ui_story = var_82_4.localPosition
			end

			local var_82_5 = 0.001

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_5 then
				var_82_4.localPosition = Vector3.Lerp(arg_79_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_79_1.time_ - 0) / var_82_5)
				var_82_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_82_4.position).x, (manager.ui.mainCamera.transform.position - var_82_4.position).y, (manager.ui.mainCamera.transform.position - var_82_4.position).z)
				var_82_4.localEulerAngles.z = 0
				var_82_4.localEulerAngles.x = 0
				var_82_4.localEulerAngles = var_82_4.localEulerAngles
			end

			if arg_79_1.time_ >= 0 + var_82_5 and arg_79_1.time_ < 0 + var_82_5 + arg_82_0 then
				var_82_4.localPosition = Vector3.New(0, 100, 0)
				var_82_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_82_4.position).x, (manager.ui.mainCamera.transform.position - var_82_4.position).y, (manager.ui.mainCamera.transform.position - var_82_4.position).z)
				var_82_4.localEulerAngles.z = 0
				var_82_4.localEulerAngles.x = 0
				var_82_4.localEulerAngles = var_82_4.localEulerAngles
			end

			local var_82_6 = arg_79_1.actors_["1084ui_story"]

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 and not isNil(var_82_6) and arg_79_1.var_.characterEffect1084ui_story == nil then
				arg_79_1.var_.characterEffect1084ui_story = var_82_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_82_7 = 0.200000002980232

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_7 and not isNil(var_82_6) then
				if arg_79_1.var_.characterEffect1084ui_story and not isNil(var_82_6) then
					arg_79_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_79_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_79_1.time_ - 0) / var_82_7)
				end
			end

			if arg_79_1.time_ >= 0 + var_82_7 and arg_79_1.time_ < 0 + var_82_7 + arg_82_0 and not isNil(var_82_6) and arg_79_1.var_.characterEffect1084ui_story then
				arg_79_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_79_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_82_8 = 0
			local var_82_9 = 0.55

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= var_82_8 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, true)

				arg_79_1.leftNameTxt_.text = arg_79_1:FormatText(StoryNameCfg[692].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_79_1.leftNameTxt_.transform)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1.leftNameTxt_.text)
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_10 = arg_79_1:GetWordFromCfg(319801018)
				local var_82_11 = arg_79_1:FormatText(var_82_10.content)

				arg_79_1.text_.text = var_82_11

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_13 = 22 <= 0 and var_82_9 or var_82_9 * (utf8.len(var_82_11) / 22)

				if (22 <= 0 and var_82_9 or var_82_9 * (utf8.len(var_82_11) / 22)) > 0 and var_82_9 < var_82_13 then
					arg_79_1.talkMaxDuration = var_82_13

					if var_82_13 + var_82_8 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_13 + var_82_8
					end
				end

				arg_79_1.text_.text = var_82_11
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319801", "319801018", "story_v_out_319801.awb") ~= 0 then
					local var_82_14 = manager.audio:GetVoiceLength("story_v_out_319801", "319801018", "story_v_out_319801.awb") / 1000

					if var_82_14 + var_82_8 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_14 + var_82_8
					end

					if var_82_10.prefab_name ~= "" and arg_79_1.actors_[var_82_10.prefab_name] ~= nil then
						local var_82_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_79_1.actors_[var_82_10.prefab_name].transform, "story_v_out_319801", "319801018", "story_v_out_319801.awb")

						arg_79_1:RecordAudio("319801018", var_82_15)
						arg_79_1:RecordAudio("319801018", var_82_15)
					else
						arg_79_1:AudioAction("play", "voice", "story_v_out_319801", "319801018", "story_v_out_319801.awb")
					end

					arg_79_1:RecordHistoryTalkVoice("story_v_out_319801", "319801018", "story_v_out_319801.awb")
				end

				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_16 = math.max(var_82_9, arg_79_1.talkMaxDuration)

			if var_82_8 <= arg_79_1.time_ and arg_79_1.time_ < var_82_8 + var_82_16 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_8) / var_82_16

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_8 + var_82_16 and arg_79_1.time_ < var_82_8 + var_82_16 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10050ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
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
			}
		}

		arg_79_1:InitPlayNodeList()
	end,
	Play319801019 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 319801019
		arg_83_1.duration_ = 8.33

		local var_83_0 = {
			zh = 4.4,
			ja = 8.333
		}
		local var_83_1 = manager.audio:GetLocalizationFlag()

		if var_83_0[var_83_1] ~= nil then
			arg_83_1.duration_ = var_83_0[var_83_1]
		end

		SetActive(arg_83_1.tipsGo_, false)

		function arg_83_1.onSingleLineFinish_()
			arg_83_1.onSingleLineUpdate_ = nil
			arg_83_1.onSingleLineFinish_ = nil
			arg_83_1.state_ = "waiting"
		end

		function arg_83_1.playNext_(arg_85_0)
			if arg_85_0 == 1 then
				arg_83_0:Play319801020(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 then
				arg_83_1:PlayTimeline("10050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_86_0 = 0
			local var_86_1 = 0.475

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= var_86_0 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, true)

				arg_83_1.leftNameTxt_.text = arg_83_1:FormatText(StoryNameCfg[692].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_83_1.leftNameTxt_.transform)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1.leftNameTxt_.text)
				SetActive(arg_83_1.iconTrs_.gameObject, false)
				arg_83_1.callingController_:SetSelectedState("normal")

				local var_86_2 = arg_83_1:GetWordFromCfg(319801019)
				local var_86_3 = arg_83_1:FormatText(var_86_2.content)

				arg_83_1.text_.text = var_86_3

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_5 = 19 <= 0 and var_86_1 or var_86_1 * (utf8.len(var_86_3) / 19)

				if (19 <= 0 and var_86_1 or var_86_1 * (utf8.len(var_86_3) / 19)) > 0 and var_86_1 < var_86_5 then
					arg_83_1.talkMaxDuration = var_86_5

					if var_86_5 + var_86_0 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_5 + var_86_0
					end
				end

				arg_83_1.text_.text = var_86_3
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319801", "319801019", "story_v_out_319801.awb") ~= 0 then
					local var_86_6 = manager.audio:GetVoiceLength("story_v_out_319801", "319801019", "story_v_out_319801.awb") / 1000

					if var_86_6 + var_86_0 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_6 + var_86_0
					end

					if var_86_2.prefab_name ~= "" and arg_83_1.actors_[var_86_2.prefab_name] ~= nil then
						local var_86_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_83_1.actors_[var_86_2.prefab_name].transform, "story_v_out_319801", "319801019", "story_v_out_319801.awb")

						arg_83_1:RecordAudio("319801019", var_86_7)
						arg_83_1:RecordAudio("319801019", var_86_7)
					else
						arg_83_1:AudioAction("play", "voice", "story_v_out_319801", "319801019", "story_v_out_319801.awb")
					end

					arg_83_1:RecordHistoryTalkVoice("story_v_out_319801", "319801019", "story_v_out_319801.awb")
				end

				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_8 = math.max(var_86_1, arg_83_1.talkMaxDuration)

			if var_86_0 <= arg_83_1.time_ and arg_83_1.time_ < var_86_0 + var_86_8 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - var_86_0) / var_86_8

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= var_86_0 + var_86_8 and arg_83_1.time_ < var_86_0 + var_86_8 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {}

		arg_83_1:InitPlayNodeList()
	end,
	Play319801020 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 319801020
		arg_87_1.duration_ = 2.93

		local var_87_0 = {
			zh = 2.4,
			ja = 2.933
		}
		local var_87_1 = manager.audio:GetLocalizationFlag()

		if var_87_0[var_87_1] ~= nil then
			arg_87_1.duration_ = var_87_0[var_87_1]
		end

		SetActive(arg_87_1.tipsGo_, false)

		function arg_87_1.onSingleLineFinish_()
			arg_87_1.onSingleLineUpdate_ = nil
			arg_87_1.onSingleLineFinish_ = nil
			arg_87_1.state_ = "waiting"
		end

		function arg_87_1.playNext_(arg_89_0)
			if arg_89_0 == 1 then
				arg_87_0:Play319801021(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 then
				arg_87_1.var_.moveOldPos10066ui_story = arg_87_1.actors_["10066ui_story"].transform.localPosition
			end

			local var_90_0 = 0.001

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_0 then
				arg_87_1.actors_["10066ui_story"].transform.localPosition = Vector3.Lerp(arg_87_1.var_.moveOldPos10066ui_story, Vector3.New(0, -0.99, -5.83), (arg_87_1.time_ - 0) / var_90_0)
				arg_87_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_87_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_87_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_87_1.actors_["10066ui_story"].transform.position).z)
				arg_87_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_87_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_87_1.actors_["10066ui_story"].transform.localEulerAngles = arg_87_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			if arg_87_1.time_ >= 0 + var_90_0 and arg_87_1.time_ < 0 + var_90_0 + arg_90_0 then
				arg_87_1.actors_["10066ui_story"].transform.localPosition = Vector3.New(0, -0.99, -5.83)
				arg_87_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_87_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_87_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_87_1.actors_["10066ui_story"].transform.position).z)
				arg_87_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_87_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_87_1.actors_["10066ui_story"].transform.localEulerAngles = arg_87_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			local var_90_1 = arg_87_1.actors_["10066ui_story"]

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 and not isNil(var_90_1) and arg_87_1.var_.characterEffect10066ui_story == nil then
				arg_87_1.var_.characterEffect10066ui_story = var_90_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_90_2 = 0.200000002980232

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_2 and not isNil(var_90_1) then
				if arg_87_1.var_.characterEffect10066ui_story and not isNil(var_90_1) then
					arg_87_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_87_1.time_ >= 0 + var_90_2 and arg_87_1.time_ < 0 + var_90_2 + arg_90_0 and not isNil(var_90_1) and arg_87_1.var_.characterEffect10066ui_story then
				arg_87_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 then
				arg_87_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action6_2")
			end

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 then
				arg_87_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_90_4 = arg_87_1.actors_["10050ui_story"].transform

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 then
				arg_87_1.var_.moveOldPos10050ui_story = var_90_4.localPosition
			end

			local var_90_5 = 0.001

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_5 then
				var_90_4.localPosition = Vector3.Lerp(arg_87_1.var_.moveOldPos10050ui_story, Vector3.New(0, 100, 0), (arg_87_1.time_ - 0) / var_90_5)
				var_90_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_90_4.position).x, (manager.ui.mainCamera.transform.position - var_90_4.position).y, (manager.ui.mainCamera.transform.position - var_90_4.position).z)
				var_90_4.localEulerAngles.z = 0
				var_90_4.localEulerAngles.x = 0
				var_90_4.localEulerAngles = var_90_4.localEulerAngles
			end

			if arg_87_1.time_ >= 0 + var_90_5 and arg_87_1.time_ < 0 + var_90_5 + arg_90_0 then
				var_90_4.localPosition = Vector3.New(0, 100, 0)
				var_90_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_90_4.position).x, (manager.ui.mainCamera.transform.position - var_90_4.position).y, (manager.ui.mainCamera.transform.position - var_90_4.position).z)
				var_90_4.localEulerAngles.z = 0
				var_90_4.localEulerAngles.x = 0
				var_90_4.localEulerAngles = var_90_4.localEulerAngles
			end

			local var_90_6 = arg_87_1.actors_["10050ui_story"]

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 and not isNil(var_90_6) and arg_87_1.var_.characterEffect10050ui_story == nil then
				arg_87_1.var_.characterEffect10050ui_story = var_90_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_90_7 = 0.200000002980232

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_7 and not isNil(var_90_6) then
				if arg_87_1.var_.characterEffect10050ui_story and not isNil(var_90_6) then
					arg_87_1.var_.characterEffect10050ui_story.fillFlat = true
					arg_87_1.var_.characterEffect10050ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_87_1.time_ - 0) / var_90_7)
				end
			end

			if arg_87_1.time_ >= 0 + var_90_7 and arg_87_1.time_ < 0 + var_90_7 + arg_90_0 and not isNil(var_90_6) and arg_87_1.var_.characterEffect10050ui_story then
				arg_87_1.var_.characterEffect10050ui_story.fillFlat = true
				arg_87_1.var_.characterEffect10050ui_story.fillRatio = 0.5
			end

			local var_90_8 = arg_87_1.actors_["1084ui_story"].transform

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 then
				arg_87_1.var_.moveOldPos1084ui_story = var_90_8.localPosition
			end

			local var_90_9 = 0.001

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_9 then
				var_90_8.localPosition = Vector3.Lerp(arg_87_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_87_1.time_ - 0) / var_90_9)
				var_90_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_90_8.position).x, (manager.ui.mainCamera.transform.position - var_90_8.position).y, (manager.ui.mainCamera.transform.position - var_90_8.position).z)
				var_90_8.localEulerAngles.z = 0
				var_90_8.localEulerAngles.x = 0
				var_90_8.localEulerAngles = var_90_8.localEulerAngles
			end

			if arg_87_1.time_ >= 0 + var_90_9 and arg_87_1.time_ < 0 + var_90_9 + arg_90_0 then
				var_90_8.localPosition = Vector3.New(0, 100, 0)
				var_90_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_90_8.position).x, (manager.ui.mainCamera.transform.position - var_90_8.position).y, (manager.ui.mainCamera.transform.position - var_90_8.position).z)
				var_90_8.localEulerAngles.z = 0
				var_90_8.localEulerAngles.x = 0
				var_90_8.localEulerAngles = var_90_8.localEulerAngles
			end

			local var_90_10 = arg_87_1.actors_["1084ui_story"]

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 and not isNil(var_90_10) and arg_87_1.var_.characterEffect1084ui_story == nil then
				arg_87_1.var_.characterEffect1084ui_story = var_90_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_90_11 = 0.200000002980232

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_11 and not isNil(var_90_10) then
				if arg_87_1.var_.characterEffect1084ui_story and not isNil(var_90_10) then
					arg_87_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_87_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_87_1.time_ - 0) / var_90_11)
				end
			end

			if arg_87_1.time_ >= 0 + var_90_11 and arg_87_1.time_ < 0 + var_90_11 + arg_90_0 and not isNil(var_90_10) and arg_87_1.var_.characterEffect1084ui_story then
				arg_87_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_87_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_90_12 = 0
			local var_90_13 = 0.225

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= var_90_12 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, true)

				arg_87_1.leftNameTxt_.text = arg_87_1:FormatText(StoryNameCfg[640].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_87_1.leftNameTxt_.transform)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1.leftNameTxt_.text)
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_14 = arg_87_1:GetWordFromCfg(319801020)
				local var_90_15 = arg_87_1:FormatText(var_90_14.content)

				arg_87_1.text_.text = var_90_15

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_17 = 9 <= 0 and var_90_13 or var_90_13 * (utf8.len(var_90_15) / 9)

				if (9 <= 0 and var_90_13 or var_90_13 * (utf8.len(var_90_15) / 9)) > 0 and var_90_13 < var_90_17 then
					arg_87_1.talkMaxDuration = var_90_17

					if var_90_17 + var_90_12 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_17 + var_90_12
					end
				end

				arg_87_1.text_.text = var_90_15
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319801", "319801020", "story_v_out_319801.awb") ~= 0 then
					local var_90_18 = manager.audio:GetVoiceLength("story_v_out_319801", "319801020", "story_v_out_319801.awb") / 1000

					if var_90_18 + var_90_12 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_18 + var_90_12
					end

					if var_90_14.prefab_name ~= "" and arg_87_1.actors_[var_90_14.prefab_name] ~= nil then
						local var_90_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_87_1.actors_[var_90_14.prefab_name].transform, "story_v_out_319801", "319801020", "story_v_out_319801.awb")

						arg_87_1:RecordAudio("319801020", var_90_19)
						arg_87_1:RecordAudio("319801020", var_90_19)
					else
						arg_87_1:AudioAction("play", "voice", "story_v_out_319801", "319801020", "story_v_out_319801.awb")
					end

					arg_87_1:RecordHistoryTalkVoice("story_v_out_319801", "319801020", "story_v_out_319801.awb")
				end

				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_20 = math.max(var_90_13, arg_87_1.talkMaxDuration)

			if var_90_12 <= arg_87_1.time_ and arg_87_1.time_ < var_90_12 + var_90_20 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - var_90_12) / var_90_20

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= var_90_12 + var_90_20 and arg_87_1.time_ < var_90_12 + var_90_20 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {
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
				actorName = "10050ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
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
			}
		}

		arg_87_1:InitPlayNodeList()
	end,
	Play319801021 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 319801021
		arg_91_1.duration_ = 5

		SetActive(arg_91_1.tipsGo_, false)

		function arg_91_1.onSingleLineFinish_()
			arg_91_1.onSingleLineUpdate_ = nil
			arg_91_1.onSingleLineFinish_ = nil
			arg_91_1.state_ = "waiting"
		end

		function arg_91_1.playNext_(arg_93_0)
			if arg_93_0 == 1 then
				arg_91_0:Play319801022(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				arg_91_1.var_.moveOldPos10066ui_story = arg_91_1.actors_["10066ui_story"].transform.localPosition
			end

			local var_94_0 = 0.001

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_0 then
				arg_91_1.actors_["10066ui_story"].transform.localPosition = Vector3.Lerp(arg_91_1.var_.moveOldPos10066ui_story, Vector3.New(0, 100, 0), (arg_91_1.time_ - 0) / var_94_0)
				arg_91_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_91_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_91_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_91_1.actors_["10066ui_story"].transform.position).z)
				arg_91_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_91_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_91_1.actors_["10066ui_story"].transform.localEulerAngles = arg_91_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			if arg_91_1.time_ >= 0 + var_94_0 and arg_91_1.time_ < 0 + var_94_0 + arg_94_0 then
				arg_91_1.actors_["10066ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_91_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_91_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_91_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_91_1.actors_["10066ui_story"].transform.position).z)
				arg_91_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_91_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_91_1.actors_["10066ui_story"].transform.localEulerAngles = arg_91_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			local var_94_1 = arg_91_1.actors_["10066ui_story"]

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 and not isNil(var_94_1) and arg_91_1.var_.characterEffect10066ui_story == nil then
				arg_91_1.var_.characterEffect10066ui_story = var_94_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_94_2 = 0.200000002980232

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_2 and not isNil(var_94_1) then
				if arg_91_1.var_.characterEffect10066ui_story and not isNil(var_94_1) then
					arg_91_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_91_1.var_.characterEffect10066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_91_1.time_ - 0) / var_94_2)
				end
			end

			if arg_91_1.time_ >= 0 + var_94_2 and arg_91_1.time_ < 0 + var_94_2 + arg_94_0 and not isNil(var_94_1) and arg_91_1.var_.characterEffect10066ui_story then
				arg_91_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_91_1.var_.characterEffect10066ui_story.fillRatio = 0.5
			end

			local var_94_3 = 0
			local var_94_4 = 0.75

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= var_94_3 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, false)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_91_1.iconTrs_.gameObject, false)
				arg_91_1.callingController_:SetSelectedState("normal")

				local var_94_5 = arg_91_1:FormatText(arg_91_1:GetWordFromCfg(319801021).content)

				arg_91_1.text_.text = var_94_5

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_7 = 30 <= 0 and var_94_4 or var_94_4 * (utf8.len(var_94_5) / 30)

				if (30 <= 0 and var_94_4 or var_94_4 * (utf8.len(var_94_5) / 30)) > 0 and var_94_4 < var_94_7 then
					arg_91_1.talkMaxDuration = var_94_7

					if var_94_7 + var_94_3 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_7 + var_94_3
					end
				end

				arg_91_1.text_.text = var_94_5
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)
				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_8 = math.max(var_94_4, arg_91_1.talkMaxDuration)

			if var_94_3 <= arg_91_1.time_ and arg_91_1.time_ < var_94_3 + var_94_8 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - var_94_3) / var_94_8

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= var_94_3 + var_94_8 and arg_91_1.time_ < var_94_3 + var_94_8 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {
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

		arg_91_1:InitPlayNodeList()
	end,
	Play319801022 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 319801022
		arg_95_1.duration_ = 5

		SetActive(arg_95_1.tipsGo_, false)

		function arg_95_1.onSingleLineFinish_()
			arg_95_1.onSingleLineUpdate_ = nil
			arg_95_1.onSingleLineFinish_ = nil
			arg_95_1.state_ = "waiting"
		end

		function arg_95_1.playNext_(arg_97_0)
			if arg_97_0 == 1 then
				arg_95_0:Play319801023(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			local var_98_0 = 0.325

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, true)

				arg_95_1.leftNameTxt_.text = arg_95_1:FormatText(StoryNameCfg[698].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_95_1.leftNameTxt_.transform)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1.leftNameTxt_.text)
				SetActive(arg_95_1.iconTrs_.gameObject, true)
				arg_95_1.iconController_:SetSelectedState("hero")

				arg_95_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10073")

				arg_95_1.callingController_:SetSelectedState("normal")

				arg_95_1.keyicon_.color = Color.New(1, 1, 1)
				arg_95_1.icon_.color = Color.New(1, 1, 1)

				local var_98_1 = arg_95_1:FormatText(arg_95_1:GetWordFromCfg(319801022).content)

				arg_95_1.text_.text = var_98_1

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_3 = 13 <= 0 and var_98_0 or var_98_0 * (utf8.len(var_98_1) / 13)

				if (13 <= 0 and var_98_0 or var_98_0 * (utf8.len(var_98_1) / 13)) > 0 and var_98_0 < var_98_3 then
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
	Play319801023 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 319801023
		arg_99_1.duration_ = 3.97

		local var_99_0 = {
			zh = 1.999999999999,
			ja = 3.966
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
				arg_99_0:Play319801024(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 then
				arg_99_1.var_.moveOldPos1084ui_story = arg_99_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_102_0 = 0.001

			if 0 <= arg_99_1.time_ and arg_99_1.time_ < 0 + var_102_0 then
				arg_99_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_99_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_99_1.time_ - 0) / var_102_0)
				arg_99_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_99_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_99_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_99_1.actors_["1084ui_story"].transform.position).z)
				arg_99_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_99_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_99_1.actors_["1084ui_story"].transform.localEulerAngles = arg_99_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_99_1.time_ >= 0 + var_102_0 and arg_99_1.time_ < 0 + var_102_0 + arg_102_0 then
				arg_99_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, -0.97, -6)
				arg_99_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_99_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_99_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_99_1.actors_["1084ui_story"].transform.position).z)
				arg_99_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_99_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_99_1.actors_["1084ui_story"].transform.localEulerAngles = arg_99_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_102_1 = arg_99_1.actors_["1084ui_story"]

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 and not isNil(var_102_1) and arg_99_1.var_.characterEffect1084ui_story == nil then
				arg_99_1.var_.characterEffect1084ui_story = var_102_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_102_2 = 0.200000002980232

			if 0 <= arg_99_1.time_ and arg_99_1.time_ < 0 + var_102_2 and not isNil(var_102_1) then
				if arg_99_1.var_.characterEffect1084ui_story and not isNil(var_102_1) then
					arg_99_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_99_1.time_ >= 0 + var_102_2 and arg_99_1.time_ < 0 + var_102_2 + arg_102_0 and not isNil(var_102_1) and arg_99_1.var_.characterEffect1084ui_story then
				arg_99_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 then
				arg_99_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action12_1")
			end

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 then
				arg_99_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_102_4 = 0
			local var_102_5 = 0.175

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= var_102_4 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, true)

				arg_99_1.leftNameTxt_.text = arg_99_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_99_1.leftNameTxt_.transform)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1.leftNameTxt_.text)
				SetActive(arg_99_1.iconTrs_.gameObject, false)
				arg_99_1.callingController_:SetSelectedState("normal")

				local var_102_6 = arg_99_1:GetWordFromCfg(319801023)
				local var_102_7 = arg_99_1:FormatText(var_102_6.content)

				arg_99_1.text_.text = var_102_7

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_9 = 7 <= 0 and var_102_5 or var_102_5 * (utf8.len(var_102_7) / 7)

				if (7 <= 0 and var_102_5 or var_102_5 * (utf8.len(var_102_7) / 7)) > 0 and var_102_5 < var_102_9 then
					arg_99_1.talkMaxDuration = var_102_9

					if var_102_9 + var_102_4 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_9 + var_102_4
					end
				end

				arg_99_1.text_.text = var_102_7
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319801", "319801023", "story_v_out_319801.awb") ~= 0 then
					local var_102_10 = manager.audio:GetVoiceLength("story_v_out_319801", "319801023", "story_v_out_319801.awb") / 1000

					if var_102_10 + var_102_4 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_10 + var_102_4
					end

					if var_102_6.prefab_name ~= "" and arg_99_1.actors_[var_102_6.prefab_name] ~= nil then
						local var_102_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_99_1.actors_[var_102_6.prefab_name].transform, "story_v_out_319801", "319801023", "story_v_out_319801.awb")

						arg_99_1:RecordAudio("319801023", var_102_11)
						arg_99_1:RecordAudio("319801023", var_102_11)
					else
						arg_99_1:AudioAction("play", "voice", "story_v_out_319801", "319801023", "story_v_out_319801.awb")
					end

					arg_99_1:RecordHistoryTalkVoice("story_v_out_319801", "319801023", "story_v_out_319801.awb")
				end

				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_12 = math.max(var_102_5, arg_99_1.talkMaxDuration)

			if var_102_4 <= arg_99_1.time_ and arg_99_1.time_ < var_102_4 + var_102_12 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - var_102_4) / var_102_12

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= var_102_4 + var_102_12 and arg_99_1.time_ < var_102_4 + var_102_12 + arg_102_0 then
				arg_99_1.typewritter.percent = 1

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(true)
			end
		end

		arg_99_1.nodeConfigList_ = {
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

		arg_99_1:InitPlayNodeList()
	end,
	Play319801024 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 319801024
		arg_103_1.duration_ = 5

		SetActive(arg_103_1.tipsGo_, false)

		function arg_103_1.onSingleLineFinish_()
			arg_103_1.onSingleLineUpdate_ = nil
			arg_103_1.onSingleLineFinish_ = nil
			arg_103_1.state_ = "waiting"
		end

		function arg_103_1.playNext_(arg_105_0)
			if arg_105_0 == 1 then
				arg_103_0:Play319801025(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 and not isNil(arg_103_1.actors_["1084ui_story"]) and arg_103_1.var_.characterEffect1084ui_story == nil then
				arg_103_1.var_.characterEffect1084ui_story = arg_103_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_106_0 = 0.200000002980232

			if 0 <= arg_103_1.time_ and arg_103_1.time_ < 0 + var_106_0 and not isNil(arg_103_1.actors_["1084ui_story"]) then
				if arg_103_1.var_.characterEffect1084ui_story and not isNil(arg_103_1.actors_["1084ui_story"]) then
					arg_103_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_103_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_103_1.time_ - 0) / var_106_0)
				end
			end

			if arg_103_1.time_ >= 0 + var_106_0 and arg_103_1.time_ < 0 + var_106_0 + arg_106_0 and not isNil(arg_103_1.actors_["1084ui_story"]) and arg_103_1.var_.characterEffect1084ui_story then
				arg_103_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_103_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_106_1 = 0
			local var_106_2 = 0.9

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= var_106_1 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, true)

				arg_103_1.leftNameTxt_.text = arg_103_1:FormatText(StoryNameCfg[698].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_103_1.leftNameTxt_.transform)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1.leftNameTxt_.text)
				SetActive(arg_103_1.iconTrs_.gameObject, true)
				arg_103_1.iconController_:SetSelectedState("hero")

				arg_103_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10073")

				arg_103_1.callingController_:SetSelectedState("normal")

				arg_103_1.keyicon_.color = Color.New(1, 1, 1)
				arg_103_1.icon_.color = Color.New(1, 1, 1)

				local var_106_3 = arg_103_1:FormatText(arg_103_1:GetWordFromCfg(319801024).content)

				arg_103_1.text_.text = var_106_3

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_5 = 36 <= 0 and var_106_2 or var_106_2 * (utf8.len(var_106_3) / 36)

				if (36 <= 0 and var_106_2 or var_106_2 * (utf8.len(var_106_3) / 36)) > 0 and var_106_2 < var_106_5 then
					arg_103_1.talkMaxDuration = var_106_5

					if var_106_5 + var_106_1 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_5 + var_106_1
					end
				end

				arg_103_1.text_.text = var_106_3
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)
				arg_103_1:RecordContent(arg_103_1.text_.text)
			end

			local var_106_6 = math.max(var_106_2, arg_103_1.talkMaxDuration)

			if var_106_1 <= arg_103_1.time_ and arg_103_1.time_ < var_106_1 + var_106_6 then
				arg_103_1.typewritter.percent = (arg_103_1.time_ - var_106_1) / var_106_6

				arg_103_1.typewritter:SetDirty()
			end

			if arg_103_1.time_ >= var_106_1 + var_106_6 and arg_103_1.time_ < var_106_1 + var_106_6 + arg_106_0 then
				arg_103_1.typewritter.percent = 1

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(true)
			end
		end

		arg_103_1.nodeConfigList_ = {}

		arg_103_1:InitPlayNodeList()
	end,
	Play319801025 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 319801025
		arg_107_1.duration_ = 5

		SetActive(arg_107_1.tipsGo_, false)

		function arg_107_1.onSingleLineFinish_()
			arg_107_1.onSingleLineUpdate_ = nil
			arg_107_1.onSingleLineFinish_ = nil
			arg_107_1.state_ = "waiting"
		end

		function arg_107_1.playNext_(arg_109_0)
			if arg_109_0 == 1 then
				arg_107_0:Play319801026(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			local var_110_0 = 0.975

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, false)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_107_1.iconTrs_.gameObject, false)
				arg_107_1.callingController_:SetSelectedState("normal")

				local var_110_1 = arg_107_1:FormatText(arg_107_1:GetWordFromCfg(319801025).content)

				arg_107_1.text_.text = var_110_1

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_3 = 39 <= 0 and var_110_0 or var_110_0 * (utf8.len(var_110_1) / 39)

				if (39 <= 0 and var_110_0 or var_110_0 * (utf8.len(var_110_1) / 39)) > 0 and var_110_0 < var_110_3 then
					arg_107_1.talkMaxDuration = var_110_3

					if var_110_3 + 0 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_3 + 0
					end
				end

				arg_107_1.text_.text = var_110_1
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)
				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_4 = math.max(var_110_0, arg_107_1.talkMaxDuration)

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_4 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - 0) / var_110_4

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= 0 + var_110_4 and arg_107_1.time_ < 0 + var_110_4 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {}

		arg_107_1:InitPlayNodeList()
	end,
	Play319801026 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 319801026
		arg_111_1.duration_ = 2.2

		local var_111_0 = {
			zh = 1.466,
			ja = 2.2
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
				arg_111_0:Play319801027(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 and not isNil(arg_111_1.actors_["1084ui_story"]) and arg_111_1.var_.characterEffect1084ui_story == nil then
				arg_111_1.var_.characterEffect1084ui_story = arg_111_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_114_0 = 0.200000002980232

			if 0 <= arg_111_1.time_ and arg_111_1.time_ < 0 + var_114_0 and not isNil(arg_111_1.actors_["1084ui_story"]) then
				if arg_111_1.var_.characterEffect1084ui_story and not isNil(arg_111_1.actors_["1084ui_story"]) then
					arg_111_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_111_1.time_ >= 0 + var_114_0 and arg_111_1.time_ < 0 + var_114_0 + arg_114_0 and not isNil(arg_111_1.actors_["1084ui_story"]) and arg_111_1.var_.characterEffect1084ui_story then
				arg_111_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_114_2 = 0
			local var_114_3 = 0.175

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= var_114_2 + arg_114_0 then
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

				local var_114_4 = arg_111_1:GetWordFromCfg(319801026)
				local var_114_5 = arg_111_1:FormatText(var_114_4.content)

				arg_111_1.text_.text = var_114_5

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_7 = 7 <= 0 and var_114_3 or var_114_3 * (utf8.len(var_114_5) / 7)

				if (7 <= 0 and var_114_3 or var_114_3 * (utf8.len(var_114_5) / 7)) > 0 and var_114_3 < var_114_7 then
					arg_111_1.talkMaxDuration = var_114_7

					if var_114_7 + var_114_2 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_7 + var_114_2
					end
				end

				arg_111_1.text_.text = var_114_5
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319801", "319801026", "story_v_out_319801.awb") ~= 0 then
					local var_114_8 = manager.audio:GetVoiceLength("story_v_out_319801", "319801026", "story_v_out_319801.awb") / 1000

					if var_114_8 + var_114_2 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_8 + var_114_2
					end

					if var_114_4.prefab_name ~= "" and arg_111_1.actors_[var_114_4.prefab_name] ~= nil then
						local var_114_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_111_1.actors_[var_114_4.prefab_name].transform, "story_v_out_319801", "319801026", "story_v_out_319801.awb")

						arg_111_1:RecordAudio("319801026", var_114_9)
						arg_111_1:RecordAudio("319801026", var_114_9)
					else
						arg_111_1:AudioAction("play", "voice", "story_v_out_319801", "319801026", "story_v_out_319801.awb")
					end

					arg_111_1:RecordHistoryTalkVoice("story_v_out_319801", "319801026", "story_v_out_319801.awb")
				end

				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_10 = math.max(var_114_3, arg_111_1.talkMaxDuration)

			if var_114_2 <= arg_111_1.time_ and arg_111_1.time_ < var_114_2 + var_114_10 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_2) / var_114_10

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_2 + var_114_10 and arg_111_1.time_ < var_114_2 + var_114_10 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {}

		arg_111_1:InitPlayNodeList()
	end,
	Play319801027 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 319801027
		arg_115_1.duration_ = 10.43

		local var_115_0 = {
			zh = 9.866,
			ja = 10.433
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
				arg_115_0:Play319801028(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				arg_115_1.var_.moveOldPos10058ui_story = arg_115_1.actors_["10058ui_story"].transform.localPosition
			end

			local var_118_0 = 0.001

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_0 then
				arg_115_1.actors_["10058ui_story"].transform.localPosition = Vector3.Lerp(arg_115_1.var_.moveOldPos10058ui_story, Vector3.New(0.7, -0.98, -6.1), (arg_115_1.time_ - 0) / var_118_0)
				arg_115_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_115_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_115_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_115_1.actors_["10058ui_story"].transform.position).z)
				arg_115_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_115_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_115_1.actors_["10058ui_story"].transform.localEulerAngles = arg_115_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			if arg_115_1.time_ >= 0 + var_118_0 and arg_115_1.time_ < 0 + var_118_0 + arg_118_0 then
				arg_115_1.actors_["10058ui_story"].transform.localPosition = Vector3.New(0.7, -0.98, -6.1)
				arg_115_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_115_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_115_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_115_1.actors_["10058ui_story"].transform.position).z)
				arg_115_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_115_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_115_1.actors_["10058ui_story"].transform.localEulerAngles = arg_115_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			local var_118_1 = arg_115_1.actors_["10058ui_story"]

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 and not isNil(var_118_1) and arg_115_1.var_.characterEffect10058ui_story == nil then
				arg_115_1.var_.characterEffect10058ui_story = var_118_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_118_2 = 0.200000002980232

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_2 and not isNil(var_118_1) then
				if arg_115_1.var_.characterEffect10058ui_story and not isNil(var_118_1) then
					arg_115_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_115_1.time_ >= 0 + var_118_2 and arg_115_1.time_ < 0 + var_118_2 + arg_118_0 and not isNil(var_118_1) and arg_115_1.var_.characterEffect10058ui_story then
				arg_115_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				arg_115_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action4_2")
			end

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				arg_115_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_118_4 = arg_115_1.actors_["1084ui_story"].transform

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				arg_115_1.var_.moveOldPos1084ui_story = var_118_4.localPosition
			end

			local var_118_5 = 0.001

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_5 then
				var_118_4.localPosition = Vector3.Lerp(arg_115_1.var_.moveOldPos1084ui_story, Vector3.New(-0.7, -0.97, -6), (arg_115_1.time_ - 0) / var_118_5)
				var_118_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_118_4.position).x, (manager.ui.mainCamera.transform.position - var_118_4.position).y, (manager.ui.mainCamera.transform.position - var_118_4.position).z)
				var_118_4.localEulerAngles.z = 0
				var_118_4.localEulerAngles.x = 0
				var_118_4.localEulerAngles = var_118_4.localEulerAngles
			end

			if arg_115_1.time_ >= 0 + var_118_5 and arg_115_1.time_ < 0 + var_118_5 + arg_118_0 then
				var_118_4.localPosition = Vector3.New(-0.7, -0.97, -6)
				var_118_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_118_4.position).x, (manager.ui.mainCamera.transform.position - var_118_4.position).y, (manager.ui.mainCamera.transform.position - var_118_4.position).z)
				var_118_4.localEulerAngles.z = 0
				var_118_4.localEulerAngles.x = 0
				var_118_4.localEulerAngles = var_118_4.localEulerAngles
			end

			local var_118_6 = arg_115_1.actors_["1084ui_story"]

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 and not isNil(var_118_6) and arg_115_1.var_.characterEffect1084ui_story == nil then
				arg_115_1.var_.characterEffect1084ui_story = var_118_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_118_7 = 0.200000002980232

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_7 and not isNil(var_118_6) then
				if arg_115_1.var_.characterEffect1084ui_story and not isNil(var_118_6) then
					arg_115_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_115_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_115_1.time_ - 0) / var_118_7)
				end
			end

			if arg_115_1.time_ >= 0 + var_118_7 and arg_115_1.time_ < 0 + var_118_7 + arg_118_0 and not isNil(var_118_6) and arg_115_1.var_.characterEffect1084ui_story then
				arg_115_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_115_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_118_8 = 0
			local var_118_9 = 1.175

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= var_118_8 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, true)

				arg_115_1.leftNameTxt_.text = arg_115_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_10 = arg_115_1:GetWordFromCfg(319801027)
				local var_118_11 = arg_115_1:FormatText(var_118_10.content)

				arg_115_1.text_.text = var_118_11

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_13 = 47 <= 0 and var_118_9 or var_118_9 * (utf8.len(var_118_11) / 47)

				if (47 <= 0 and var_118_9 or var_118_9 * (utf8.len(var_118_11) / 47)) > 0 and var_118_9 < var_118_13 then
					arg_115_1.talkMaxDuration = var_118_13

					if var_118_13 + var_118_8 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_13 + var_118_8
					end
				end

				arg_115_1.text_.text = var_118_11
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319801", "319801027", "story_v_out_319801.awb") ~= 0 then
					local var_118_14 = manager.audio:GetVoiceLength("story_v_out_319801", "319801027", "story_v_out_319801.awb") / 1000

					if var_118_14 + var_118_8 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_14 + var_118_8
					end

					if var_118_10.prefab_name ~= "" and arg_115_1.actors_[var_118_10.prefab_name] ~= nil then
						local var_118_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_115_1.actors_[var_118_10.prefab_name].transform, "story_v_out_319801", "319801027", "story_v_out_319801.awb")

						arg_115_1:RecordAudio("319801027", var_118_15)
						arg_115_1:RecordAudio("319801027", var_118_15)
					else
						arg_115_1:AudioAction("play", "voice", "story_v_out_319801", "319801027", "story_v_out_319801.awb")
					end

					arg_115_1:RecordHistoryTalkVoice("story_v_out_319801", "319801027", "story_v_out_319801.awb")
				end

				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_16 = math.max(var_118_9, arg_115_1.talkMaxDuration)

			if var_118_8 <= arg_115_1.time_ and arg_115_1.time_ < var_118_8 + var_118_16 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - var_118_8) / var_118_16

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= var_118_8 + var_118_16 and arg_115_1.time_ < var_118_8 + var_118_16 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
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
			}
		}

		arg_115_1:InitPlayNodeList()
	end,
	Play319801028 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 319801028
		arg_119_1.duration_ = 2.73

		local var_119_0 = {
			zh = 1.999999999999,
			ja = 2.733
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
				arg_119_0:Play319801029(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 and not isNil(arg_119_1.actors_["10058ui_story"]) and arg_119_1.var_.characterEffect10058ui_story == nil then
				arg_119_1.var_.characterEffect10058ui_story = arg_119_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_122_0 = 0.200000002980232

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_0 and not isNil(arg_119_1.actors_["10058ui_story"]) then
				if arg_119_1.var_.characterEffect10058ui_story and not isNil(arg_119_1.actors_["10058ui_story"]) then
					arg_119_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_119_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_119_1.time_ - 0) / var_122_0)
				end
			end

			if arg_119_1.time_ >= 0 + var_122_0 and arg_119_1.time_ < 0 + var_122_0 + arg_122_0 and not isNil(arg_119_1.actors_["10058ui_story"]) and arg_119_1.var_.characterEffect10058ui_story then
				arg_119_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_119_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			local var_122_1 = arg_119_1.actors_["1084ui_story"]

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 and not isNil(var_122_1) and arg_119_1.var_.characterEffect1084ui_story == nil then
				arg_119_1.var_.characterEffect1084ui_story = var_122_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_122_2 = 0.200000002980232

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_2 and not isNil(var_122_1) then
				if arg_119_1.var_.characterEffect1084ui_story and not isNil(var_122_1) then
					arg_119_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_119_1.time_ >= 0 + var_122_2 and arg_119_1.time_ < 0 + var_122_2 + arg_122_0 and not isNil(var_122_1) and arg_119_1.var_.characterEffect1084ui_story then
				arg_119_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 then
				arg_119_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action12_2")
			end

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 then
				arg_119_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_122_4 = 0
			local var_122_5 = 0.2

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

				local var_122_6 = arg_119_1:GetWordFromCfg(319801028)
				local var_122_7 = arg_119_1:FormatText(var_122_6.content)

				arg_119_1.text_.text = var_122_7

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_9 = 8 <= 0 and var_122_5 or var_122_5 * (utf8.len(var_122_7) / 8)

				if (8 <= 0 and var_122_5 or var_122_5 * (utf8.len(var_122_7) / 8)) > 0 and var_122_5 < var_122_9 then
					arg_119_1.talkMaxDuration = var_122_9

					if var_122_9 + var_122_4 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_9 + var_122_4
					end
				end

				arg_119_1.text_.text = var_122_7
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319801", "319801028", "story_v_out_319801.awb") ~= 0 then
					local var_122_10 = manager.audio:GetVoiceLength("story_v_out_319801", "319801028", "story_v_out_319801.awb") / 1000

					if var_122_10 + var_122_4 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_10 + var_122_4
					end

					if var_122_6.prefab_name ~= "" and arg_119_1.actors_[var_122_6.prefab_name] ~= nil then
						local var_122_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_119_1.actors_[var_122_6.prefab_name].transform, "story_v_out_319801", "319801028", "story_v_out_319801.awb")

						arg_119_1:RecordAudio("319801028", var_122_11)
						arg_119_1:RecordAudio("319801028", var_122_11)
					else
						arg_119_1:AudioAction("play", "voice", "story_v_out_319801", "319801028", "story_v_out_319801.awb")
					end

					arg_119_1:RecordHistoryTalkVoice("story_v_out_319801", "319801028", "story_v_out_319801.awb")
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
	Play319801029 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 319801029
		arg_123_1.duration_ = 15.5

		local var_123_0 = {
			zh = 11.333,
			ja = 15.5
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
				arg_123_0:Play319801030(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 and not isNil(arg_123_1.actors_["10058ui_story"]) and arg_123_1.var_.characterEffect10058ui_story == nil then
				arg_123_1.var_.characterEffect10058ui_story = arg_123_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_126_0 = 0.200000002980232

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_0 and not isNil(arg_123_1.actors_["10058ui_story"]) then
				if arg_123_1.var_.characterEffect10058ui_story and not isNil(arg_123_1.actors_["10058ui_story"]) then
					arg_123_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_123_1.time_ >= 0 + var_126_0 and arg_123_1.time_ < 0 + var_126_0 + arg_126_0 and not isNil(arg_123_1.actors_["10058ui_story"]) and arg_123_1.var_.characterEffect10058ui_story then
				arg_123_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_126_2 = arg_123_1.actors_["1084ui_story"]

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 and not isNil(var_126_2) and arg_123_1.var_.characterEffect1084ui_story == nil then
				arg_123_1.var_.characterEffect1084ui_story = var_126_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_126_3 = 0.200000002980232

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_3 and not isNil(var_126_2) then
				if arg_123_1.var_.characterEffect1084ui_story and not isNil(var_126_2) then
					arg_123_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_123_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_123_1.time_ - 0) / var_126_3)
				end
			end

			if arg_123_1.time_ >= 0 + var_126_3 and arg_123_1.time_ < 0 + var_126_3 + arg_126_0 and not isNil(var_126_2) and arg_123_1.var_.characterEffect1084ui_story then
				arg_123_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_123_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_126_4 = 0
			local var_126_5 = 1.05

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= var_126_4 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, true)

				arg_123_1.leftNameTxt_.text = arg_123_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_123_1.leftNameTxt_.transform)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1.leftNameTxt_.text)
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_6 = arg_123_1:GetWordFromCfg(319801029)
				local var_126_7 = arg_123_1:FormatText(var_126_6.content)

				arg_123_1.text_.text = var_126_7

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_9 = 42 <= 0 and var_126_5 or var_126_5 * (utf8.len(var_126_7) / 42)

				if (42 <= 0 and var_126_5 or var_126_5 * (utf8.len(var_126_7) / 42)) > 0 and var_126_5 < var_126_9 then
					arg_123_1.talkMaxDuration = var_126_9

					if var_126_9 + var_126_4 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_9 + var_126_4
					end
				end

				arg_123_1.text_.text = var_126_7
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319801", "319801029", "story_v_out_319801.awb") ~= 0 then
					local var_126_10 = manager.audio:GetVoiceLength("story_v_out_319801", "319801029", "story_v_out_319801.awb") / 1000

					if var_126_10 + var_126_4 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_10 + var_126_4
					end

					if var_126_6.prefab_name ~= "" and arg_123_1.actors_[var_126_6.prefab_name] ~= nil then
						local var_126_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_123_1.actors_[var_126_6.prefab_name].transform, "story_v_out_319801", "319801029", "story_v_out_319801.awb")

						arg_123_1:RecordAudio("319801029", var_126_11)
						arg_123_1:RecordAudio("319801029", var_126_11)
					else
						arg_123_1:AudioAction("play", "voice", "story_v_out_319801", "319801029", "story_v_out_319801.awb")
					end

					arg_123_1:RecordHistoryTalkVoice("story_v_out_319801", "319801029", "story_v_out_319801.awb")
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
	Play319801030 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 319801030
		arg_127_1.duration_ = 6.1

		local var_127_0 = {
			zh = 6.1,
			ja = 5.9
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
				arg_127_0:Play319801031(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 and not isNil(arg_127_1.actors_["10058ui_story"]) and arg_127_1.var_.characterEffect10058ui_story == nil then
				arg_127_1.var_.characterEffect10058ui_story = arg_127_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_130_0 = 0.200000002980232

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_0 and not isNil(arg_127_1.actors_["10058ui_story"]) then
				if arg_127_1.var_.characterEffect10058ui_story and not isNil(arg_127_1.actors_["10058ui_story"]) then
					arg_127_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_127_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_127_1.time_ - 0) / var_130_0)
				end
			end

			if arg_127_1.time_ >= 0 + var_130_0 and arg_127_1.time_ < 0 + var_130_0 + arg_130_0 and not isNil(arg_127_1.actors_["10058ui_story"]) and arg_127_1.var_.characterEffect10058ui_story then
				arg_127_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_127_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			local var_130_1 = arg_127_1.actors_["1084ui_story"]

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 and not isNil(var_130_1) and arg_127_1.var_.characterEffect1084ui_story == nil then
				arg_127_1.var_.characterEffect1084ui_story = var_130_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_130_2 = 0.200000002980232

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_2 and not isNil(var_130_1) then
				if arg_127_1.var_.characterEffect1084ui_story and not isNil(var_130_1) then
					arg_127_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_127_1.time_ >= 0 + var_130_2 and arg_127_1.time_ < 0 + var_130_2 + arg_130_0 and not isNil(var_130_1) and arg_127_1.var_.characterEffect1084ui_story then
				arg_127_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_130_4 = 0
			local var_130_5 = 0.85

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= var_130_4 + arg_130_0 then
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

				local var_130_6 = arg_127_1:GetWordFromCfg(319801030)
				local var_130_7 = arg_127_1:FormatText(var_130_6.content)

				arg_127_1.text_.text = var_130_7

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_9 = 34 <= 0 and var_130_5 or var_130_5 * (utf8.len(var_130_7) / 34)

				if (34 <= 0 and var_130_5 or var_130_5 * (utf8.len(var_130_7) / 34)) > 0 and var_130_5 < var_130_9 then
					arg_127_1.talkMaxDuration = var_130_9

					if var_130_9 + var_130_4 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_9 + var_130_4
					end
				end

				arg_127_1.text_.text = var_130_7
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319801", "319801030", "story_v_out_319801.awb") ~= 0 then
					local var_130_10 = manager.audio:GetVoiceLength("story_v_out_319801", "319801030", "story_v_out_319801.awb") / 1000

					if var_130_10 + var_130_4 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_10 + var_130_4
					end

					if var_130_6.prefab_name ~= "" and arg_127_1.actors_[var_130_6.prefab_name] ~= nil then
						local var_130_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_127_1.actors_[var_130_6.prefab_name].transform, "story_v_out_319801", "319801030", "story_v_out_319801.awb")

						arg_127_1:RecordAudio("319801030", var_130_11)
						arg_127_1:RecordAudio("319801030", var_130_11)
					else
						arg_127_1:AudioAction("play", "voice", "story_v_out_319801", "319801030", "story_v_out_319801.awb")
					end

					arg_127_1:RecordHistoryTalkVoice("story_v_out_319801", "319801030", "story_v_out_319801.awb")
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
	Play319801031 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 319801031
		arg_131_1.duration_ = 2.6

		local var_131_0 = {
			zh = 1.999999999999,
			ja = 2.6
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
				arg_131_0:Play319801032(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 and not isNil(arg_131_1.actors_["10058ui_story"]) and arg_131_1.var_.characterEffect10058ui_story == nil then
				arg_131_1.var_.characterEffect10058ui_story = arg_131_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_134_0 = 0.200000002980232

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_0 and not isNil(arg_131_1.actors_["10058ui_story"]) then
				if arg_131_1.var_.characterEffect10058ui_story and not isNil(arg_131_1.actors_["10058ui_story"]) then
					arg_131_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_131_1.time_ >= 0 + var_134_0 and arg_131_1.time_ < 0 + var_134_0 + arg_134_0 and not isNil(arg_131_1.actors_["10058ui_story"]) and arg_131_1.var_.characterEffect10058ui_story then
				arg_131_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_134_2 = arg_131_1.actors_["1084ui_story"]

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 and not isNil(var_134_2) and arg_131_1.var_.characterEffect1084ui_story == nil then
				arg_131_1.var_.characterEffect1084ui_story = var_134_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_134_3 = 0.200000002980232

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_3 and not isNil(var_134_2) then
				if arg_131_1.var_.characterEffect1084ui_story and not isNil(var_134_2) then
					arg_131_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_131_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_131_1.time_ - 0) / var_134_3)
				end
			end

			if arg_131_1.time_ >= 0 + var_134_3 and arg_131_1.time_ < 0 + var_134_3 + arg_134_0 and not isNil(var_134_2) and arg_131_1.var_.characterEffect1084ui_story then
				arg_131_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_131_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action3_1")
			end

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_134_4 = 0
			local var_134_5 = 0.375

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= var_134_4 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				arg_131_1.leftNameTxt_.text = arg_131_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_6 = arg_131_1:GetWordFromCfg(319801031)
				local var_134_7 = arg_131_1:FormatText(var_134_6.content)

				arg_131_1.text_.text = var_134_7

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_9 = 15 <= 0 and var_134_5 or var_134_5 * (utf8.len(var_134_7) / 15)

				if (15 <= 0 and var_134_5 or var_134_5 * (utf8.len(var_134_7) / 15)) > 0 and var_134_5 < var_134_9 then
					arg_131_1.talkMaxDuration = var_134_9

					if var_134_9 + var_134_4 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_9 + var_134_4
					end
				end

				arg_131_1.text_.text = var_134_7
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319801", "319801031", "story_v_out_319801.awb") ~= 0 then
					local var_134_10 = manager.audio:GetVoiceLength("story_v_out_319801", "319801031", "story_v_out_319801.awb") / 1000

					if var_134_10 + var_134_4 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_10 + var_134_4
					end

					if var_134_6.prefab_name ~= "" and arg_131_1.actors_[var_134_6.prefab_name] ~= nil then
						local var_134_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_131_1.actors_[var_134_6.prefab_name].transform, "story_v_out_319801", "319801031", "story_v_out_319801.awb")

						arg_131_1:RecordAudio("319801031", var_134_11)
						arg_131_1:RecordAudio("319801031", var_134_11)
					else
						arg_131_1:AudioAction("play", "voice", "story_v_out_319801", "319801031", "story_v_out_319801.awb")
					end

					arg_131_1:RecordHistoryTalkVoice("story_v_out_319801", "319801031", "story_v_out_319801.awb")
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

		arg_131_1.nodeConfigList_ = {}

		arg_131_1:InitPlayNodeList()
	end,
	Play319801032 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 319801032
		arg_135_1.duration_ = 5.17

		local var_135_0 = {
			zh = 3.833,
			ja = 5.166
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
				arg_135_0:Play319801033(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				arg_135_1.var_.moveOldPos1084ui_story = arg_135_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_138_0 = 0.001

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_0 then
				arg_135_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_135_1.var_.moveOldPos1084ui_story, Vector3.New(-0.7, -0.97, -6), (arg_135_1.time_ - 0) / var_138_0)
				arg_135_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_135_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_135_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_135_1.actors_["1084ui_story"].transform.position).z)
				arg_135_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_135_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_135_1.actors_["1084ui_story"].transform.localEulerAngles = arg_135_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_135_1.time_ >= 0 + var_138_0 and arg_135_1.time_ < 0 + var_138_0 + arg_138_0 then
				arg_135_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(-0.7, -0.97, -6)
				arg_135_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_135_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_135_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_135_1.actors_["1084ui_story"].transform.position).z)
				arg_135_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_135_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_135_1.actors_["1084ui_story"].transform.localEulerAngles = arg_135_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_138_1 = arg_135_1.actors_["1084ui_story"]

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 and not isNil(var_138_1) and arg_135_1.var_.characterEffect1084ui_story == nil then
				arg_135_1.var_.characterEffect1084ui_story = var_138_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_138_2 = 0.200000002980232

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_2 and not isNil(var_138_1) then
				if arg_135_1.var_.characterEffect1084ui_story and not isNil(var_138_1) then
					arg_135_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_135_1.time_ >= 0 + var_138_2 and arg_135_1.time_ < 0 + var_138_2 + arg_138_0 and not isNil(var_138_1) and arg_135_1.var_.characterEffect1084ui_story then
				arg_135_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				arg_135_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action7_1")
			end

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				arg_135_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_138_4 = arg_135_1.actors_["10058ui_story"]

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 and not isNil(var_138_4) and arg_135_1.var_.characterEffect10058ui_story == nil then
				arg_135_1.var_.characterEffect10058ui_story = var_138_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_138_5 = 0.200000002980232

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_5 and not isNil(var_138_4) then
				if arg_135_1.var_.characterEffect10058ui_story and not isNil(var_138_4) then
					arg_135_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_135_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_135_1.time_ - 0) / var_138_5)
				end
			end

			if arg_135_1.time_ >= 0 + var_138_5 and arg_135_1.time_ < 0 + var_138_5 + arg_138_0 and not isNil(var_138_4) and arg_135_1.var_.characterEffect10058ui_story then
				arg_135_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_135_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			local var_138_6 = 0
			local var_138_7 = 0.725

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= var_138_6 + arg_138_0 then
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

				local var_138_8 = arg_135_1:GetWordFromCfg(319801032)
				local var_138_9 = arg_135_1:FormatText(var_138_8.content)

				arg_135_1.text_.text = var_138_9

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_11 = 29 <= 0 and var_138_7 or var_138_7 * (utf8.len(var_138_9) / 29)

				if (29 <= 0 and var_138_7 or var_138_7 * (utf8.len(var_138_9) / 29)) > 0 and var_138_7 < var_138_11 then
					arg_135_1.talkMaxDuration = var_138_11

					if var_138_11 + var_138_6 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_11 + var_138_6
					end
				end

				arg_135_1.text_.text = var_138_9
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319801", "319801032", "story_v_out_319801.awb") ~= 0 then
					local var_138_12 = manager.audio:GetVoiceLength("story_v_out_319801", "319801032", "story_v_out_319801.awb") / 1000

					if var_138_12 + var_138_6 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_12 + var_138_6
					end

					if var_138_8.prefab_name ~= "" and arg_135_1.actors_[var_138_8.prefab_name] ~= nil then
						local var_138_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_135_1.actors_[var_138_8.prefab_name].transform, "story_v_out_319801", "319801032", "story_v_out_319801.awb")

						arg_135_1:RecordAudio("319801032", var_138_13)
						arg_135_1:RecordAudio("319801032", var_138_13)
					else
						arg_135_1:AudioAction("play", "voice", "story_v_out_319801", "319801032", "story_v_out_319801.awb")
					end

					arg_135_1:RecordHistoryTalkVoice("story_v_out_319801", "319801032", "story_v_out_319801.awb")
				end

				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_14 = math.max(var_138_7, arg_135_1.talkMaxDuration)

			if var_138_6 <= arg_135_1.time_ and arg_135_1.time_ < var_138_6 + var_138_14 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_6) / var_138_14

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_6 + var_138_14 and arg_135_1.time_ < var_138_6 + var_138_14 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {
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

		arg_135_1:InitPlayNodeList()
	end,
	Play319801033 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 319801033
		arg_139_1.duration_ = 7.83

		local var_139_0 = {
			zh = 6.566,
			ja = 7.833
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
				arg_139_0:Play319801034(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1.var_.moveOldPos10058ui_story = arg_139_1.actors_["10058ui_story"].transform.localPosition
			end

			local var_142_0 = 0.001

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_0 then
				arg_139_1.actors_["10058ui_story"].transform.localPosition = Vector3.Lerp(arg_139_1.var_.moveOldPos10058ui_story, Vector3.New(0.7, -0.98, -6.1), (arg_139_1.time_ - 0) / var_142_0)
				arg_139_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_139_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_139_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_139_1.actors_["10058ui_story"].transform.position).z)
				arg_139_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_139_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_139_1.actors_["10058ui_story"].transform.localEulerAngles = arg_139_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			if arg_139_1.time_ >= 0 + var_142_0 and arg_139_1.time_ < 0 + var_142_0 + arg_142_0 then
				arg_139_1.actors_["10058ui_story"].transform.localPosition = Vector3.New(0.7, -0.98, -6.1)
				arg_139_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_139_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_139_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_139_1.actors_["10058ui_story"].transform.position).z)
				arg_139_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_139_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_139_1.actors_["10058ui_story"].transform.localEulerAngles = arg_139_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			local var_142_1 = arg_139_1.actors_["10058ui_story"]

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 and not isNil(var_142_1) and arg_139_1.var_.characterEffect10058ui_story == nil then
				arg_139_1.var_.characterEffect10058ui_story = var_142_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_142_2 = 0.200000002980232

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_2 and not isNil(var_142_1) then
				if arg_139_1.var_.characterEffect10058ui_story and not isNil(var_142_1) then
					arg_139_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_139_1.time_ >= 0 + var_142_2 and arg_139_1.time_ < 0 + var_142_2 + arg_142_0 and not isNil(var_142_1) and arg_139_1.var_.characterEffect10058ui_story then
				arg_139_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_142_4 = arg_139_1.actors_["1084ui_story"]

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 and not isNil(var_142_4) and arg_139_1.var_.characterEffect1084ui_story == nil then
				arg_139_1.var_.characterEffect1084ui_story = var_142_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_142_5 = 0.200000002980232

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_5 and not isNil(var_142_4) then
				if arg_139_1.var_.characterEffect1084ui_story and not isNil(var_142_4) then
					arg_139_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_139_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_139_1.time_ - 0) / var_142_5)
				end
			end

			if arg_139_1.time_ >= 0 + var_142_5 and arg_139_1.time_ < 0 + var_142_5 + arg_142_0 and not isNil(var_142_4) and arg_139_1.var_.characterEffect1084ui_story then
				arg_139_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_139_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_142_6 = 0
			local var_142_7 = 0.7

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= var_142_6 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				arg_139_1.leftNameTxt_.text = arg_139_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_8 = arg_139_1:GetWordFromCfg(319801033)
				local var_142_9 = arg_139_1:FormatText(var_142_8.content)

				arg_139_1.text_.text = var_142_9

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_11 = 28 <= 0 and var_142_7 or var_142_7 * (utf8.len(var_142_9) / 28)

				if (28 <= 0 and var_142_7 or var_142_7 * (utf8.len(var_142_9) / 28)) > 0 and var_142_7 < var_142_11 then
					arg_139_1.talkMaxDuration = var_142_11

					if var_142_11 + var_142_6 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_11 + var_142_6
					end
				end

				arg_139_1.text_.text = var_142_9
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319801", "319801033", "story_v_out_319801.awb") ~= 0 then
					local var_142_12 = manager.audio:GetVoiceLength("story_v_out_319801", "319801033", "story_v_out_319801.awb") / 1000

					if var_142_12 + var_142_6 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_12 + var_142_6
					end

					if var_142_8.prefab_name ~= "" and arg_139_1.actors_[var_142_8.prefab_name] ~= nil then
						local var_142_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_139_1.actors_[var_142_8.prefab_name].transform, "story_v_out_319801", "319801033", "story_v_out_319801.awb")

						arg_139_1:RecordAudio("319801033", var_142_13)
						arg_139_1:RecordAudio("319801033", var_142_13)
					else
						arg_139_1:AudioAction("play", "voice", "story_v_out_319801", "319801033", "story_v_out_319801.awb")
					end

					arg_139_1:RecordHistoryTalkVoice("story_v_out_319801", "319801033", "story_v_out_319801.awb")
				end

				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_14 = math.max(var_142_7, arg_139_1.talkMaxDuration)

			if var_142_6 <= arg_139_1.time_ and arg_139_1.time_ < var_142_6 + var_142_14 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_6) / var_142_14

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_6 + var_142_14 and arg_139_1.time_ < var_142_6 + var_142_14 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
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
	Play319801034 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 319801034
		arg_143_1.duration_ = 9.07

		local var_143_0 = {
			zh = 5.166,
			ja = 9.066
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
				arg_143_0:Play319801035(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action3_2")
			end

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_146_0 = 0
			local var_146_1 = 0.575

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= var_146_0 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				arg_143_1.leftNameTxt_.text = arg_143_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, false)
				arg_143_1.callingController_:SetSelectedState("normal")

				local var_146_2 = arg_143_1:GetWordFromCfg(319801034)
				local var_146_3 = arg_143_1:FormatText(var_146_2.content)

				arg_143_1.text_.text = var_146_3

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_5 = 23 <= 0 and var_146_1 or var_146_1 * (utf8.len(var_146_3) / 23)

				if (23 <= 0 and var_146_1 or var_146_1 * (utf8.len(var_146_3) / 23)) > 0 and var_146_1 < var_146_5 then
					arg_143_1.talkMaxDuration = var_146_5

					if var_146_5 + var_146_0 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_5 + var_146_0
					end
				end

				arg_143_1.text_.text = var_146_3
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319801", "319801034", "story_v_out_319801.awb") ~= 0 then
					local var_146_6 = manager.audio:GetVoiceLength("story_v_out_319801", "319801034", "story_v_out_319801.awb") / 1000

					if var_146_6 + var_146_0 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_6 + var_146_0
					end

					if var_146_2.prefab_name ~= "" and arg_143_1.actors_[var_146_2.prefab_name] ~= nil then
						local var_146_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_143_1.actors_[var_146_2.prefab_name].transform, "story_v_out_319801", "319801034", "story_v_out_319801.awb")

						arg_143_1:RecordAudio("319801034", var_146_7)
						arg_143_1:RecordAudio("319801034", var_146_7)
					else
						arg_143_1:AudioAction("play", "voice", "story_v_out_319801", "319801034", "story_v_out_319801.awb")
					end

					arg_143_1:RecordHistoryTalkVoice("story_v_out_319801", "319801034", "story_v_out_319801.awb")
				end

				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_8 = math.max(var_146_1, arg_143_1.talkMaxDuration)

			if var_146_0 <= arg_143_1.time_ and arg_143_1.time_ < var_146_0 + var_146_8 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_0) / var_146_8

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_0 + var_146_8 and arg_143_1.time_ < var_146_0 + var_146_8 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {}

		arg_143_1:InitPlayNodeList()
	end,
	Play319801035 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 319801035
		arg_147_1.duration_ = 5

		SetActive(arg_147_1.tipsGo_, false)

		function arg_147_1.onSingleLineFinish_()
			arg_147_1.onSingleLineUpdate_ = nil
			arg_147_1.onSingleLineFinish_ = nil
			arg_147_1.state_ = "waiting"
		end

		function arg_147_1.playNext_(arg_149_0)
			if arg_149_0 == 1 then
				arg_147_0:Play319801036(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 and not isNil(arg_147_1.actors_["10058ui_story"]) and arg_147_1.var_.characterEffect10058ui_story == nil then
				arg_147_1.var_.characterEffect10058ui_story = arg_147_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_150_0 = 0.200000002980232

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_0 and not isNil(arg_147_1.actors_["10058ui_story"]) then
				if arg_147_1.var_.characterEffect10058ui_story and not isNil(arg_147_1.actors_["10058ui_story"]) then
					arg_147_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_147_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_147_1.time_ - 0) / var_150_0)
				end
			end

			if arg_147_1.time_ >= 0 + var_150_0 and arg_147_1.time_ < 0 + var_150_0 + arg_150_0 and not isNil(arg_147_1.actors_["10058ui_story"]) and arg_147_1.var_.characterEffect10058ui_story then
				arg_147_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_147_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			local var_150_1 = 0
			local var_150_2 = 1.1

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= var_150_1 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, false)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_3 = arg_147_1:FormatText(arg_147_1:GetWordFromCfg(319801035).content)

				arg_147_1.text_.text = var_150_3

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_5 = 44 <= 0 and var_150_2 or var_150_2 * (utf8.len(var_150_3) / 44)

				if (44 <= 0 and var_150_2 or var_150_2 * (utf8.len(var_150_3) / 44)) > 0 and var_150_2 < var_150_5 then
					arg_147_1.talkMaxDuration = var_150_5

					if var_150_5 + var_150_1 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_5 + var_150_1
					end
				end

				arg_147_1.text_.text = var_150_3
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)
				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_6 = math.max(var_150_2, arg_147_1.talkMaxDuration)

			if var_150_1 <= arg_147_1.time_ and arg_147_1.time_ < var_150_1 + var_150_6 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_1) / var_150_6

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_1 + var_150_6 and arg_147_1.time_ < var_150_1 + var_150_6 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {}

		arg_147_1:InitPlayNodeList()
	end,
	Play319801036 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 319801036
		arg_151_1.duration_ = 8.17

		local var_151_0 = {
			zh = 3.733,
			ja = 8.166
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
				arg_151_0:Play319801037(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			if arg_151_1.actors_["10068ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10068ui_story"))) then
				local var_154_0 = Object.Instantiate(Asset.Load("Char/" .. "10068ui_story"), arg_151_1.stage_.transform)

				var_154_0.name = "10068ui_story"
				var_154_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_151_1.actors_["10068ui_story"] = var_154_0

				local var_154_1 = var_154_0:GetComponentInChildren(typeof(CharacterEffect))

				var_154_1.enabled = true

				local var_154_2 = GameObjectTools.GetOrAddComponent(var_154_0, typeof(DynamicBoneHelper))

				if var_154_2 then
					var_154_2:EnableDynamicBone(false)
				end

				arg_151_1:ShowWeapon(var_154_1.transform, false)

				arg_151_1.var_["10068ui_story" .. "Animator"] = var_154_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_151_1.var_["10068ui_story" .. "Animator"].applyRootMotion = true
				arg_151_1.var_["10068ui_story" .. "LipSync"] = var_154_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_154_3 = arg_151_1.actors_["10068ui_story"].transform

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 then
				arg_151_1.var_.moveOldPos10068ui_story = var_154_3.localPosition
			end

			local var_154_4 = 0.001

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_4 then
				var_154_3.localPosition = Vector3.Lerp(arg_151_1.var_.moveOldPos10068ui_story, Vector3.New(0, -0.75, -6.18), (arg_151_1.time_ - 0) / var_154_4)
				var_154_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_154_3.position).x, (manager.ui.mainCamera.transform.position - var_154_3.position).y, (manager.ui.mainCamera.transform.position - var_154_3.position).z)
				var_154_3.localEulerAngles.z = 0
				var_154_3.localEulerAngles.x = 0
				var_154_3.localEulerAngles = var_154_3.localEulerAngles
			end

			if arg_151_1.time_ >= 0 + var_154_4 and arg_151_1.time_ < 0 + var_154_4 + arg_154_0 then
				var_154_3.localPosition = Vector3.New(0, -0.75, -6.18)
				var_154_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_154_3.position).x, (manager.ui.mainCamera.transform.position - var_154_3.position).y, (manager.ui.mainCamera.transform.position - var_154_3.position).z)
				var_154_3.localEulerAngles.z = 0
				var_154_3.localEulerAngles.x = 0
				var_154_3.localEulerAngles = var_154_3.localEulerAngles
			end

			local var_154_5 = arg_151_1.actors_["10068ui_story"]

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 and not isNil(var_154_5) and arg_151_1.var_.characterEffect10068ui_story == nil then
				arg_151_1.var_.characterEffect10068ui_story = var_154_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_154_6 = 0.200000002980232

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_6 and not isNil(var_154_5) then
				if arg_151_1.var_.characterEffect10068ui_story and not isNil(var_154_5) then
					arg_151_1.var_.characterEffect10068ui_story.fillFlat = false
				end
			end

			if arg_151_1.time_ >= 0 + var_154_6 and arg_151_1.time_ < 0 + var_154_6 + arg_154_0 and not isNil(var_154_5) and arg_151_1.var_.characterEffect10068ui_story then
				arg_151_1.var_.characterEffect10068ui_story.fillFlat = false
			end

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 then
				arg_151_1:PlayTimeline("10068ui_story", "StoryTimeline/CharAction/story10068/story10068action/10068action5_1")
			end

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 then
				arg_151_1:PlayTimeline("10068ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_154_8 = arg_151_1.actors_["10058ui_story"].transform

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 then
				arg_151_1.var_.moveOldPos10058ui_story = var_154_8.localPosition
			end

			local var_154_9 = 0.001

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_9 then
				var_154_8.localPosition = Vector3.Lerp(arg_151_1.var_.moveOldPos10058ui_story, Vector3.New(0, 100, 0), (arg_151_1.time_ - 0) / var_154_9)
				var_154_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_154_8.position).x, (manager.ui.mainCamera.transform.position - var_154_8.position).y, (manager.ui.mainCamera.transform.position - var_154_8.position).z)
				var_154_8.localEulerAngles.z = 0
				var_154_8.localEulerAngles.x = 0
				var_154_8.localEulerAngles = var_154_8.localEulerAngles
			end

			if arg_151_1.time_ >= 0 + var_154_9 and arg_151_1.time_ < 0 + var_154_9 + arg_154_0 then
				var_154_8.localPosition = Vector3.New(0, 100, 0)
				var_154_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_154_8.position).x, (manager.ui.mainCamera.transform.position - var_154_8.position).y, (manager.ui.mainCamera.transform.position - var_154_8.position).z)
				var_154_8.localEulerAngles.z = 0
				var_154_8.localEulerAngles.x = 0
				var_154_8.localEulerAngles = var_154_8.localEulerAngles
			end

			local var_154_10 = arg_151_1.actors_["1084ui_story"].transform

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 then
				arg_151_1.var_.moveOldPos1084ui_story = var_154_10.localPosition
			end

			local var_154_11 = 0.001

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_11 then
				var_154_10.localPosition = Vector3.Lerp(arg_151_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_151_1.time_ - 0) / var_154_11)
				var_154_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_154_10.position).x, (manager.ui.mainCamera.transform.position - var_154_10.position).y, (manager.ui.mainCamera.transform.position - var_154_10.position).z)
				var_154_10.localEulerAngles.z = 0
				var_154_10.localEulerAngles.x = 0
				var_154_10.localEulerAngles = var_154_10.localEulerAngles
			end

			if arg_151_1.time_ >= 0 + var_154_11 and arg_151_1.time_ < 0 + var_154_11 + arg_154_0 then
				var_154_10.localPosition = Vector3.New(0, 100, 0)
				var_154_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_154_10.position).x, (manager.ui.mainCamera.transform.position - var_154_10.position).y, (manager.ui.mainCamera.transform.position - var_154_10.position).z)
				var_154_10.localEulerAngles.z = 0
				var_154_10.localEulerAngles.x = 0
				var_154_10.localEulerAngles = var_154_10.localEulerAngles
			end

			local var_154_12 = 0
			local var_154_13 = 0.35

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= var_154_12 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				arg_151_1.leftNameTxt_.text = arg_151_1:FormatText(StoryNameCfg[697].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, false)
				arg_151_1.callingController_:SetSelectedState("normal")

				local var_154_14 = arg_151_1:GetWordFromCfg(319801036)
				local var_154_15 = arg_151_1:FormatText(var_154_14.content)

				arg_151_1.text_.text = var_154_15

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_17 = 14 <= 0 and var_154_13 or var_154_13 * (utf8.len(var_154_15) / 14)

				if (14 <= 0 and var_154_13 or var_154_13 * (utf8.len(var_154_15) / 14)) > 0 and var_154_13 < var_154_17 then
					arg_151_1.talkMaxDuration = var_154_17

					if var_154_17 + var_154_12 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_17 + var_154_12
					end
				end

				arg_151_1.text_.text = var_154_15
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319801", "319801036", "story_v_out_319801.awb") ~= 0 then
					local var_154_18 = manager.audio:GetVoiceLength("story_v_out_319801", "319801036", "story_v_out_319801.awb") / 1000

					if var_154_18 + var_154_12 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_18 + var_154_12
					end

					if var_154_14.prefab_name ~= "" and arg_151_1.actors_[var_154_14.prefab_name] ~= nil then
						local var_154_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_151_1.actors_[var_154_14.prefab_name].transform, "story_v_out_319801", "319801036", "story_v_out_319801.awb")

						arg_151_1:RecordAudio("319801036", var_154_19)
						arg_151_1:RecordAudio("319801036", var_154_19)
					else
						arg_151_1:AudioAction("play", "voice", "story_v_out_319801", "319801036", "story_v_out_319801.awb")
					end

					arg_151_1:RecordHistoryTalkVoice("story_v_out_319801", "319801036", "story_v_out_319801.awb")
				end

				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_20 = math.max(var_154_13, arg_151_1.talkMaxDuration)

			if var_154_12 <= arg_151_1.time_ and arg_151_1.time_ < var_154_12 + var_154_20 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - var_154_12) / var_154_20

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= var_154_12 + var_154_20 and arg_151_1.time_ < var_154_12 + var_154_20 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10068ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
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
			}
		}

		arg_151_1:InitPlayNodeList()
	end,
	Play319801037 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 319801037
		arg_155_1.duration_ = 2.6

		local var_155_0 = {
			zh = 2.6,
			ja = 2.233
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
				arg_155_0:Play319801038(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 then
				arg_155_1.var_.moveOldPos10058ui_story = arg_155_1.actors_["10058ui_story"].transform.localPosition
			end

			local var_158_0 = 0.001

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_0 then
				arg_155_1.actors_["10058ui_story"].transform.localPosition = Vector3.Lerp(arg_155_1.var_.moveOldPos10058ui_story, Vector3.New(0.7, -0.98, -6.1), (arg_155_1.time_ - 0) / var_158_0)
				arg_155_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_155_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_155_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_155_1.actors_["10058ui_story"].transform.position).z)
				arg_155_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_155_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_155_1.actors_["10058ui_story"].transform.localEulerAngles = arg_155_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			if arg_155_1.time_ >= 0 + var_158_0 and arg_155_1.time_ < 0 + var_158_0 + arg_158_0 then
				arg_155_1.actors_["10058ui_story"].transform.localPosition = Vector3.New(0.7, -0.98, -6.1)
				arg_155_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_155_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_155_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_155_1.actors_["10058ui_story"].transform.position).z)
				arg_155_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_155_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_155_1.actors_["10058ui_story"].transform.localEulerAngles = arg_155_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			local var_158_1 = arg_155_1.actors_["10058ui_story"]

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 and not isNil(var_158_1) and arg_155_1.var_.characterEffect10058ui_story == nil then
				arg_155_1.var_.characterEffect10058ui_story = var_158_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_158_2 = 0.200000002980232

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_2 and not isNil(var_158_1) then
				if arg_155_1.var_.characterEffect10058ui_story and not isNil(var_158_1) then
					arg_155_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_155_1.time_ >= 0 + var_158_2 and arg_155_1.time_ < 0 + var_158_2 + arg_158_0 and not isNil(var_158_1) and arg_155_1.var_.characterEffect10058ui_story then
				arg_155_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 then
				arg_155_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 then
				arg_155_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_158_4 = arg_155_1.actors_["10068ui_story"].transform

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 then
				arg_155_1.var_.moveOldPos10068ui_story = var_158_4.localPosition
			end

			local var_158_5 = 0.001

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_5 then
				var_158_4.localPosition = Vector3.Lerp(arg_155_1.var_.moveOldPos10068ui_story, Vector3.New(0, 100, 0), (arg_155_1.time_ - 0) / var_158_5)
				var_158_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_158_4.position).x, (manager.ui.mainCamera.transform.position - var_158_4.position).y, (manager.ui.mainCamera.transform.position - var_158_4.position).z)
				var_158_4.localEulerAngles.z = 0
				var_158_4.localEulerAngles.x = 0
				var_158_4.localEulerAngles = var_158_4.localEulerAngles
			end

			if arg_155_1.time_ >= 0 + var_158_5 and arg_155_1.time_ < 0 + var_158_5 + arg_158_0 then
				var_158_4.localPosition = Vector3.New(0, 100, 0)
				var_158_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_158_4.position).x, (manager.ui.mainCamera.transform.position - var_158_4.position).y, (manager.ui.mainCamera.transform.position - var_158_4.position).z)
				var_158_4.localEulerAngles.z = 0
				var_158_4.localEulerAngles.x = 0
				var_158_4.localEulerAngles = var_158_4.localEulerAngles
			end

			local var_158_6 = 0
			local var_158_7 = 0.2

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= var_158_6 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, true)

				arg_155_1.leftNameTxt_.text = arg_155_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_8 = arg_155_1:GetWordFromCfg(319801037)
				local var_158_9 = arg_155_1:FormatText(var_158_8.content)

				arg_155_1.text_.text = var_158_9

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_11 = 8 <= 0 and var_158_7 or var_158_7 * (utf8.len(var_158_9) / 8)

				if (8 <= 0 and var_158_7 or var_158_7 * (utf8.len(var_158_9) / 8)) > 0 and var_158_7 < var_158_11 then
					arg_155_1.talkMaxDuration = var_158_11

					if var_158_11 + var_158_6 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_11 + var_158_6
					end
				end

				arg_155_1.text_.text = var_158_9
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319801", "319801037", "story_v_out_319801.awb") ~= 0 then
					local var_158_12 = manager.audio:GetVoiceLength("story_v_out_319801", "319801037", "story_v_out_319801.awb") / 1000

					if var_158_12 + var_158_6 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_12 + var_158_6
					end

					if var_158_8.prefab_name ~= "" and arg_155_1.actors_[var_158_8.prefab_name] ~= nil then
						local var_158_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_155_1.actors_[var_158_8.prefab_name].transform, "story_v_out_319801", "319801037", "story_v_out_319801.awb")

						arg_155_1:RecordAudio("319801037", var_158_13)
						arg_155_1:RecordAudio("319801037", var_158_13)
					else
						arg_155_1:AudioAction("play", "voice", "story_v_out_319801", "319801037", "story_v_out_319801.awb")
					end

					arg_155_1:RecordHistoryTalkVoice("story_v_out_319801", "319801037", "story_v_out_319801.awb")
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
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10068ui_story",
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
	Play319801038 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 319801038
		arg_159_1.duration_ = 2.17

		local var_159_0 = {
			zh = 2.166,
			ja = 1.999999999999
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
				arg_159_0:Play319801039(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1.var_.moveOldPos10058ui_story = arg_159_1.actors_["10058ui_story"].transform.localPosition
			end

			local var_162_0 = 0.001

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_0 then
				arg_159_1.actors_["10058ui_story"].transform.localPosition = Vector3.Lerp(arg_159_1.var_.moveOldPos10058ui_story, Vector3.New(0.7, -0.98, -6.1), (arg_159_1.time_ - 0) / var_162_0)
				arg_159_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_159_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_159_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_159_1.actors_["10058ui_story"].transform.position).z)
				arg_159_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_159_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_159_1.actors_["10058ui_story"].transform.localEulerAngles = arg_159_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			if arg_159_1.time_ >= 0 + var_162_0 and arg_159_1.time_ < 0 + var_162_0 + arg_162_0 then
				arg_159_1.actors_["10058ui_story"].transform.localPosition = Vector3.New(0.7, -0.98, -6.1)
				arg_159_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_159_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_159_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_159_1.actors_["10058ui_story"].transform.position).z)
				arg_159_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_159_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_159_1.actors_["10058ui_story"].transform.localEulerAngles = arg_159_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			local var_162_1 = arg_159_1.actors_["1084ui_story"].transform

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1.var_.moveOldPos1084ui_story = var_162_1.localPosition
			end

			local var_162_2 = 0.001

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_2 then
				var_162_1.localPosition = Vector3.Lerp(arg_159_1.var_.moveOldPos1084ui_story, Vector3.New(-0.7, -0.97, -6), (arg_159_1.time_ - 0) / var_162_2)
				var_162_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_162_1.position).x, (manager.ui.mainCamera.transform.position - var_162_1.position).y, (manager.ui.mainCamera.transform.position - var_162_1.position).z)
				var_162_1.localEulerAngles.z = 0
				var_162_1.localEulerAngles.x = 0
				var_162_1.localEulerAngles = var_162_1.localEulerAngles
			end

			if arg_159_1.time_ >= 0 + var_162_2 and arg_159_1.time_ < 0 + var_162_2 + arg_162_0 then
				var_162_1.localPosition = Vector3.New(-0.7, -0.97, -6)
				var_162_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_162_1.position).x, (manager.ui.mainCamera.transform.position - var_162_1.position).y, (manager.ui.mainCamera.transform.position - var_162_1.position).z)
				var_162_1.localEulerAngles.z = 0
				var_162_1.localEulerAngles.x = 0
				var_162_1.localEulerAngles = var_162_1.localEulerAngles
			end

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_162_3 = arg_159_1.actors_["10058ui_story"]

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 and not isNil(var_162_3) and arg_159_1.var_.characterEffect10058ui_story == nil then
				arg_159_1.var_.characterEffect10058ui_story = var_162_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_162_4 = 0.200000002980232

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_4 and not isNil(var_162_3) then
				if arg_159_1.var_.characterEffect10058ui_story and not isNil(var_162_3) then
					arg_159_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_159_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_159_1.time_ - 0) / var_162_4)
				end
			end

			if arg_159_1.time_ >= 0 + var_162_4 and arg_159_1.time_ < 0 + var_162_4 + arg_162_0 and not isNil(var_162_3) and arg_159_1.var_.characterEffect10058ui_story then
				arg_159_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_159_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			local var_162_5 = arg_159_1.actors_["1084ui_story"]

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 and not isNil(var_162_5) and arg_159_1.var_.characterEffect1084ui_story == nil then
				arg_159_1.var_.characterEffect1084ui_story = var_162_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_162_6 = 0.200000002980232

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_6 and not isNil(var_162_5) then
				if arg_159_1.var_.characterEffect1084ui_story and not isNil(var_162_5) then
					arg_159_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_159_1.time_ >= 0 + var_162_6 and arg_159_1.time_ < 0 + var_162_6 + arg_162_0 and not isNil(var_162_5) and arg_159_1.var_.characterEffect1084ui_story then
				arg_159_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action7_2")
			end

			local var_162_8 = 0
			local var_162_9 = 0.175

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= var_162_8 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, true)

				arg_159_1.leftNameTxt_.text = arg_159_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_159_1.leftNameTxt_.transform)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1.leftNameTxt_.text)
				SetActive(arg_159_1.iconTrs_.gameObject, false)
				arg_159_1.callingController_:SetSelectedState("normal")

				local var_162_10 = arg_159_1:GetWordFromCfg(319801038)
				local var_162_11 = arg_159_1:FormatText(var_162_10.content)

				arg_159_1.text_.text = var_162_11

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_13 = 7 <= 0 and var_162_9 or var_162_9 * (utf8.len(var_162_11) / 7)

				if (7 <= 0 and var_162_9 or var_162_9 * (utf8.len(var_162_11) / 7)) > 0 and var_162_9 < var_162_13 then
					arg_159_1.talkMaxDuration = var_162_13

					if var_162_13 + var_162_8 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_13 + var_162_8
					end
				end

				arg_159_1.text_.text = var_162_11
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319801", "319801038", "story_v_out_319801.awb") ~= 0 then
					local var_162_14 = manager.audio:GetVoiceLength("story_v_out_319801", "319801038", "story_v_out_319801.awb") / 1000

					if var_162_14 + var_162_8 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_14 + var_162_8
					end

					if var_162_10.prefab_name ~= "" and arg_159_1.actors_[var_162_10.prefab_name] ~= nil then
						local var_162_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_159_1.actors_[var_162_10.prefab_name].transform, "story_v_out_319801", "319801038", "story_v_out_319801.awb")

						arg_159_1:RecordAudio("319801038", var_162_15)
						arg_159_1:RecordAudio("319801038", var_162_15)
					else
						arg_159_1:AudioAction("play", "voice", "story_v_out_319801", "319801038", "story_v_out_319801.awb")
					end

					arg_159_1:RecordHistoryTalkVoice("story_v_out_319801", "319801038", "story_v_out_319801.awb")
				end

				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_16 = math.max(var_162_9, arg_159_1.talkMaxDuration)

			if var_162_8 <= arg_159_1.time_ and arg_159_1.time_ < var_162_8 + var_162_16 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_8) / var_162_16

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_8 + var_162_16 and arg_159_1.time_ < var_162_8 + var_162_16 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
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
			}
		}

		arg_159_1:InitPlayNodeList()
	end,
	Play319801039 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 319801039
		arg_163_1.duration_ = 16.43

		local var_163_0 = {
			zh = 5.066,
			ja = 16.433
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
				arg_163_0:Play319801040(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 then
				arg_163_1.var_.moveOldPos10058ui_story = arg_163_1.actors_["10058ui_story"].transform.localPosition
			end

			local var_166_0 = 0.001

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_0 then
				arg_163_1.actors_["10058ui_story"].transform.localPosition = Vector3.Lerp(arg_163_1.var_.moveOldPos10058ui_story, Vector3.New(0, 100, 0), (arg_163_1.time_ - 0) / var_166_0)
				arg_163_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_163_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_163_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_163_1.actors_["10058ui_story"].transform.position).z)
				arg_163_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_163_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_163_1.actors_["10058ui_story"].transform.localEulerAngles = arg_163_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			if arg_163_1.time_ >= 0 + var_166_0 and arg_163_1.time_ < 0 + var_166_0 + arg_166_0 then
				arg_163_1.actors_["10058ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_163_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_163_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_163_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_163_1.actors_["10058ui_story"].transform.position).z)
				arg_163_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_163_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_163_1.actors_["10058ui_story"].transform.localEulerAngles = arg_163_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			local var_166_1 = arg_163_1.actors_["1084ui_story"].transform

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 then
				arg_163_1.var_.moveOldPos1084ui_story = var_166_1.localPosition
			end

			local var_166_2 = 0.001

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_2 then
				var_166_1.localPosition = Vector3.Lerp(arg_163_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_163_1.time_ - 0) / var_166_2)
				var_166_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_166_1.position).x, (manager.ui.mainCamera.transform.position - var_166_1.position).y, (manager.ui.mainCamera.transform.position - var_166_1.position).z)
				var_166_1.localEulerAngles.z = 0
				var_166_1.localEulerAngles.x = 0
				var_166_1.localEulerAngles = var_166_1.localEulerAngles
			end

			if arg_163_1.time_ >= 0 + var_166_2 and arg_163_1.time_ < 0 + var_166_2 + arg_166_0 then
				var_166_1.localPosition = Vector3.New(0, 100, 0)
				var_166_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_166_1.position).x, (manager.ui.mainCamera.transform.position - var_166_1.position).y, (manager.ui.mainCamera.transform.position - var_166_1.position).z)
				var_166_1.localEulerAngles.z = 0
				var_166_1.localEulerAngles.x = 0
				var_166_1.localEulerAngles = var_166_1.localEulerAngles
			end

			local var_166_3 = arg_163_1.actors_["10068ui_story"].transform

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 then
				arg_163_1.var_.moveOldPos10068ui_story = var_166_3.localPosition
			end

			local var_166_4 = 0.001

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_4 then
				var_166_3.localPosition = Vector3.Lerp(arg_163_1.var_.moveOldPos10068ui_story, Vector3.New(0, -0.75, -6.18), (arg_163_1.time_ - 0) / var_166_4)
				var_166_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_166_3.position).x, (manager.ui.mainCamera.transform.position - var_166_3.position).y, (manager.ui.mainCamera.transform.position - var_166_3.position).z)
				var_166_3.localEulerAngles.z = 0
				var_166_3.localEulerAngles.x = 0
				var_166_3.localEulerAngles = var_166_3.localEulerAngles
			end

			if arg_163_1.time_ >= 0 + var_166_4 and arg_163_1.time_ < 0 + var_166_4 + arg_166_0 then
				var_166_3.localPosition = Vector3.New(0, -0.75, -6.18)
				var_166_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_166_3.position).x, (manager.ui.mainCamera.transform.position - var_166_3.position).y, (manager.ui.mainCamera.transform.position - var_166_3.position).z)
				var_166_3.localEulerAngles.z = 0
				var_166_3.localEulerAngles.x = 0
				var_166_3.localEulerAngles = var_166_3.localEulerAngles
			end

			local var_166_5 = arg_163_1.actors_["10068ui_story"]

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 and not isNil(var_166_5) and arg_163_1.var_.characterEffect10068ui_story == nil then
				arg_163_1.var_.characterEffect10068ui_story = var_166_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_166_6 = 0.200000002980232

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_6 and not isNil(var_166_5) then
				if arg_163_1.var_.characterEffect10068ui_story and not isNil(var_166_5) then
					arg_163_1.var_.characterEffect10068ui_story.fillFlat = false
				end
			end

			if arg_163_1.time_ >= 0 + var_166_6 and arg_163_1.time_ < 0 + var_166_6 + arg_166_0 and not isNil(var_166_5) and arg_163_1.var_.characterEffect10068ui_story then
				arg_163_1.var_.characterEffect10068ui_story.fillFlat = false
			end

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 then
				arg_163_1:PlayTimeline("10068ui_story", "StoryTimeline/CharAction/story10068/story10068action/10068action5_2")
			end

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 then
				arg_163_1:PlayTimeline("10068ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_166_8 = 0
			local var_166_9 = 0.475

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= var_166_8 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, true)

				arg_163_1.leftNameTxt_.text = arg_163_1:FormatText(StoryNameCfg[697].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_163_1.leftNameTxt_.transform)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1.leftNameTxt_.text)
				SetActive(arg_163_1.iconTrs_.gameObject, false)
				arg_163_1.callingController_:SetSelectedState("normal")

				local var_166_10 = arg_163_1:GetWordFromCfg(319801039)
				local var_166_11 = arg_163_1:FormatText(var_166_10.content)

				arg_163_1.text_.text = var_166_11

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_13 = 19 <= 0 and var_166_9 or var_166_9 * (utf8.len(var_166_11) / 19)

				if (19 <= 0 and var_166_9 or var_166_9 * (utf8.len(var_166_11) / 19)) > 0 and var_166_9 < var_166_13 then
					arg_163_1.talkMaxDuration = var_166_13

					if var_166_13 + var_166_8 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_13 + var_166_8
					end
				end

				arg_163_1.text_.text = var_166_11
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319801", "319801039", "story_v_out_319801.awb") ~= 0 then
					local var_166_14 = manager.audio:GetVoiceLength("story_v_out_319801", "319801039", "story_v_out_319801.awb") / 1000

					if var_166_14 + var_166_8 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_14 + var_166_8
					end

					if var_166_10.prefab_name ~= "" and arg_163_1.actors_[var_166_10.prefab_name] ~= nil then
						local var_166_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_163_1.actors_[var_166_10.prefab_name].transform, "story_v_out_319801", "319801039", "story_v_out_319801.awb")

						arg_163_1:RecordAudio("319801039", var_166_15)
						arg_163_1:RecordAudio("319801039", var_166_15)
					else
						arg_163_1:AudioAction("play", "voice", "story_v_out_319801", "319801039", "story_v_out_319801.awb")
					end

					arg_163_1:RecordHistoryTalkVoice("story_v_out_319801", "319801039", "story_v_out_319801.awb")
				end

				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_16 = math.max(var_166_9, arg_163_1.talkMaxDuration)

			if var_166_8 <= arg_163_1.time_ and arg_163_1.time_ < var_166_8 + var_166_16 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - var_166_8) / var_166_16

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= var_166_8 + var_166_16 and arg_163_1.time_ < var_166_8 + var_166_16 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
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
				actorName = "10068ui_story",
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
	Play319801040 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 319801040
		arg_167_1.duration_ = 5

		SetActive(arg_167_1.tipsGo_, false)

		function arg_167_1.onSingleLineFinish_()
			arg_167_1.onSingleLineUpdate_ = nil
			arg_167_1.onSingleLineFinish_ = nil
			arg_167_1.state_ = "waiting"
		end

		function arg_167_1.playNext_(arg_169_0)
			if arg_169_0 == 1 then
				arg_167_0:Play319801041(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 and not isNil(arg_167_1.actors_["10058ui_story"]) and arg_167_1.var_.characterEffect10058ui_story == nil then
				arg_167_1.var_.characterEffect10058ui_story = arg_167_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_170_0 = 0.200000002980232

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_0 and not isNil(arg_167_1.actors_["10058ui_story"]) then
				if arg_167_1.var_.characterEffect10058ui_story and not isNil(arg_167_1.actors_["10058ui_story"]) then
					arg_167_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_167_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_167_1.time_ - 0) / var_170_0)
				end
			end

			if arg_167_1.time_ >= 0 + var_170_0 and arg_167_1.time_ < 0 + var_170_0 + arg_170_0 and not isNil(arg_167_1.actors_["10058ui_story"]) and arg_167_1.var_.characterEffect10058ui_story then
				arg_167_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_167_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			local var_170_1 = arg_167_1.actors_["10068ui_story"]

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 and not isNil(var_170_1) and arg_167_1.var_.characterEffect10068ui_story == nil then
				arg_167_1.var_.characterEffect10068ui_story = var_170_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_170_2 = 0.200000002980232

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_2 and not isNil(var_170_1) then
				if arg_167_1.var_.characterEffect10068ui_story and not isNil(var_170_1) then
					arg_167_1.var_.characterEffect10068ui_story.fillFlat = true
					arg_167_1.var_.characterEffect10068ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_167_1.time_ - 0) / var_170_2)
				end
			end

			if arg_167_1.time_ >= 0 + var_170_2 and arg_167_1.time_ < 0 + var_170_2 + arg_170_0 and not isNil(var_170_1) and arg_167_1.var_.characterEffect10068ui_story then
				arg_167_1.var_.characterEffect10068ui_story.fillFlat = true
				arg_167_1.var_.characterEffect10068ui_story.fillRatio = 0.5
			end

			local var_170_3 = arg_167_1.actors_["10068ui_story"].transform

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 then
				arg_167_1.var_.moveOldPos10068ui_story = var_170_3.localPosition
			end

			local var_170_4 = 0.001

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_4 then
				var_170_3.localPosition = Vector3.Lerp(arg_167_1.var_.moveOldPos10068ui_story, Vector3.New(0, 100, 0), (arg_167_1.time_ - 0) / var_170_4)
				var_170_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_170_3.position).x, (manager.ui.mainCamera.transform.position - var_170_3.position).y, (manager.ui.mainCamera.transform.position - var_170_3.position).z)
				var_170_3.localEulerAngles.z = 0
				var_170_3.localEulerAngles.x = 0
				var_170_3.localEulerAngles = var_170_3.localEulerAngles
			end

			if arg_167_1.time_ >= 0 + var_170_4 and arg_167_1.time_ < 0 + var_170_4 + arg_170_0 then
				var_170_3.localPosition = Vector3.New(0, 100, 0)
				var_170_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_170_3.position).x, (manager.ui.mainCamera.transform.position - var_170_3.position).y, (manager.ui.mainCamera.transform.position - var_170_3.position).z)
				var_170_3.localEulerAngles.z = 0
				var_170_3.localEulerAngles.x = 0
				var_170_3.localEulerAngles = var_170_3.localEulerAngles
			end

			local var_170_5 = 0
			local var_170_6 = 0.7

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= var_170_5 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, false)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_167_1.iconTrs_.gameObject, false)
				arg_167_1.callingController_:SetSelectedState("normal")

				local var_170_7 = arg_167_1:FormatText(arg_167_1:GetWordFromCfg(319801040).content)

				arg_167_1.text_.text = var_170_7

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_9 = 28 <= 0 and var_170_6 or var_170_6 * (utf8.len(var_170_7) / 28)

				if (28 <= 0 and var_170_6 or var_170_6 * (utf8.len(var_170_7) / 28)) > 0 and var_170_6 < var_170_9 then
					arg_167_1.talkMaxDuration = var_170_9

					if var_170_9 + var_170_5 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_9 + var_170_5
					end
				end

				arg_167_1.text_.text = var_170_7
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)
				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_10 = math.max(var_170_6, arg_167_1.talkMaxDuration)

			if var_170_5 <= arg_167_1.time_ and arg_167_1.time_ < var_170_5 + var_170_10 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - var_170_5) / var_170_10

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= var_170_5 + var_170_10 and arg_167_1.time_ < var_170_5 + var_170_10 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10068ui_story",
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
	Play319801041 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 319801041
		arg_171_1.duration_ = 4.37

		local var_171_0 = {
			zh = 2.033,
			ja = 4.366
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
				arg_171_0:Play319801042(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 then
				arg_171_1.var_.moveOldPos10058ui_story = arg_171_1.actors_["10058ui_story"].transform.localPosition
			end

			local var_174_0 = 0.001

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_0 then
				arg_171_1.actors_["10058ui_story"].transform.localPosition = Vector3.Lerp(arg_171_1.var_.moveOldPos10058ui_story, Vector3.New(0, -0.98, -6.1), (arg_171_1.time_ - 0) / var_174_0)
				arg_171_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_171_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_171_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_171_1.actors_["10058ui_story"].transform.position).z)
				arg_171_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_171_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_171_1.actors_["10058ui_story"].transform.localEulerAngles = arg_171_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			if arg_171_1.time_ >= 0 + var_174_0 and arg_171_1.time_ < 0 + var_174_0 + arg_174_0 then
				arg_171_1.actors_["10058ui_story"].transform.localPosition = Vector3.New(0, -0.98, -6.1)
				arg_171_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_171_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_171_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_171_1.actors_["10058ui_story"].transform.position).z)
				arg_171_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_171_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_171_1.actors_["10058ui_story"].transform.localEulerAngles = arg_171_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			local var_174_1 = arg_171_1.actors_["10058ui_story"]

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 and not isNil(var_174_1) and arg_171_1.var_.characterEffect10058ui_story == nil then
				arg_171_1.var_.characterEffect10058ui_story = var_174_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_174_2 = 0.200000002980232

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_2 and not isNil(var_174_1) then
				if arg_171_1.var_.characterEffect10058ui_story and not isNil(var_174_1) then
					arg_171_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_171_1.time_ >= 0 + var_174_2 and arg_171_1.time_ < 0 + var_174_2 + arg_174_0 and not isNil(var_174_1) and arg_171_1.var_.characterEffect10058ui_story then
				arg_171_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 then
				arg_171_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 then
				arg_171_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_174_4 = 0
			local var_174_5 = 0.275

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= var_174_4 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, true)

				arg_171_1.leftNameTxt_.text = arg_171_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_171_1.leftNameTxt_.transform)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1.leftNameTxt_.text)
				SetActive(arg_171_1.iconTrs_.gameObject, false)
				arg_171_1.callingController_:SetSelectedState("normal")

				local var_174_6 = arg_171_1:GetWordFromCfg(319801041)
				local var_174_7 = arg_171_1:FormatText(var_174_6.content)

				arg_171_1.text_.text = var_174_7

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_9 = 11 <= 0 and var_174_5 or var_174_5 * (utf8.len(var_174_7) / 11)

				if (11 <= 0 and var_174_5 or var_174_5 * (utf8.len(var_174_7) / 11)) > 0 and var_174_5 < var_174_9 then
					arg_171_1.talkMaxDuration = var_174_9

					if var_174_9 + var_174_4 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_9 + var_174_4
					end
				end

				arg_171_1.text_.text = var_174_7
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319801", "319801041", "story_v_out_319801.awb") ~= 0 then
					local var_174_10 = manager.audio:GetVoiceLength("story_v_out_319801", "319801041", "story_v_out_319801.awb") / 1000

					if var_174_10 + var_174_4 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_10 + var_174_4
					end

					if var_174_6.prefab_name ~= "" and arg_171_1.actors_[var_174_6.prefab_name] ~= nil then
						local var_174_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_171_1.actors_[var_174_6.prefab_name].transform, "story_v_out_319801", "319801041", "story_v_out_319801.awb")

						arg_171_1:RecordAudio("319801041", var_174_11)
						arg_171_1:RecordAudio("319801041", var_174_11)
					else
						arg_171_1:AudioAction("play", "voice", "story_v_out_319801", "319801041", "story_v_out_319801.awb")
					end

					arg_171_1:RecordHistoryTalkVoice("story_v_out_319801", "319801041", "story_v_out_319801.awb")
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
				actorName = "10058ui_story",
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
	Play319801042 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 319801042
		arg_175_1.duration_ = 5

		SetActive(arg_175_1.tipsGo_, false)

		function arg_175_1.onSingleLineFinish_()
			arg_175_1.onSingleLineUpdate_ = nil
			arg_175_1.onSingleLineFinish_ = nil
			arg_175_1.state_ = "waiting"
		end

		function arg_175_1.playNext_(arg_177_0)
			if arg_177_0 == 1 then
				arg_175_0:Play319801043(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 and not isNil(arg_175_1.actors_["10058ui_story"]) and arg_175_1.var_.characterEffect10058ui_story == nil then
				arg_175_1.var_.characterEffect10058ui_story = arg_175_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_178_0 = 0.200000002980232

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_0 and not isNil(arg_175_1.actors_["10058ui_story"]) then
				if arg_175_1.var_.characterEffect10058ui_story and not isNil(arg_175_1.actors_["10058ui_story"]) then
					arg_175_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_175_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_175_1.time_ - 0) / var_178_0)
				end
			end

			if arg_175_1.time_ >= 0 + var_178_0 and arg_175_1.time_ < 0 + var_178_0 + arg_178_0 and not isNil(arg_175_1.actors_["10058ui_story"]) and arg_175_1.var_.characterEffect10058ui_story then
				arg_175_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_175_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			local var_178_1 = 0
			local var_178_2 = 0.4

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= var_178_1 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, true)

				arg_175_1.leftNameTxt_.text = arg_175_1:FormatText(StoryNameCfg[698].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_175_1.leftNameTxt_.transform)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1.leftNameTxt_.text)
				SetActive(arg_175_1.iconTrs_.gameObject, true)
				arg_175_1.iconController_:SetSelectedState("hero")

				arg_175_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10073")

				arg_175_1.callingController_:SetSelectedState("normal")

				arg_175_1.keyicon_.color = Color.New(1, 1, 1)
				arg_175_1.icon_.color = Color.New(1, 1, 1)

				local var_178_3 = arg_175_1:FormatText(arg_175_1:GetWordFromCfg(319801042).content)

				arg_175_1.text_.text = var_178_3

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_5 = 16 <= 0 and var_178_2 or var_178_2 * (utf8.len(var_178_3) / 16)

				if (16 <= 0 and var_178_2 or var_178_2 * (utf8.len(var_178_3) / 16)) > 0 and var_178_2 < var_178_5 then
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
	Play319801043 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 319801043
		arg_179_1.duration_ = 2

		SetActive(arg_179_1.tipsGo_, false)

		function arg_179_1.onSingleLineFinish_()
			arg_179_1.onSingleLineUpdate_ = nil
			arg_179_1.onSingleLineFinish_ = nil
			arg_179_1.state_ = "waiting"
		end

		function arg_179_1.playNext_(arg_181_0)
			if arg_181_0 == 1 then
				arg_179_0:Play319801044(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 and not isNil(arg_179_1.actors_["10058ui_story"]) and arg_179_1.var_.characterEffect10058ui_story == nil then
				arg_179_1.var_.characterEffect10058ui_story = arg_179_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_182_0 = 0.200000002980232

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_0 and not isNil(arg_179_1.actors_["10058ui_story"]) then
				if arg_179_1.var_.characterEffect10058ui_story and not isNil(arg_179_1.actors_["10058ui_story"]) then
					arg_179_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_179_1.time_ >= 0 + var_182_0 and arg_179_1.time_ < 0 + var_182_0 + arg_182_0 and not isNil(arg_179_1.actors_["10058ui_story"]) and arg_179_1.var_.characterEffect10058ui_story then
				arg_179_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 then
				arg_179_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action2_1")
			end

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 then
				arg_179_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_182_2 = 0
			local var_182_3 = 0.075

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= var_182_2 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, true)

				arg_179_1.leftNameTxt_.text = arg_179_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_179_1.leftNameTxt_.transform)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1.leftNameTxt_.text)
				SetActive(arg_179_1.iconTrs_.gameObject, false)
				arg_179_1.callingController_:SetSelectedState("normal")

				local var_182_4 = arg_179_1:GetWordFromCfg(319801043)
				local var_182_5 = arg_179_1:FormatText(var_182_4.content)

				arg_179_1.text_.text = var_182_5

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_7 = 3 <= 0 and var_182_3 or var_182_3 * (utf8.len(var_182_5) / 3)

				if (3 <= 0 and var_182_3 or var_182_3 * (utf8.len(var_182_5) / 3)) > 0 and var_182_3 < var_182_7 then
					arg_179_1.talkMaxDuration = var_182_7

					if var_182_7 + var_182_2 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_7 + var_182_2
					end
				end

				arg_179_1.text_.text = var_182_5
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319801", "319801043", "story_v_out_319801.awb") ~= 0 then
					local var_182_8 = manager.audio:GetVoiceLength("story_v_out_319801", "319801043", "story_v_out_319801.awb") / 1000

					if var_182_8 + var_182_2 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_8 + var_182_2
					end

					if var_182_4.prefab_name ~= "" and arg_179_1.actors_[var_182_4.prefab_name] ~= nil then
						local var_182_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_179_1.actors_[var_182_4.prefab_name].transform, "story_v_out_319801", "319801043", "story_v_out_319801.awb")

						arg_179_1:RecordAudio("319801043", var_182_9)
						arg_179_1:RecordAudio("319801043", var_182_9)
					else
						arg_179_1:AudioAction("play", "voice", "story_v_out_319801", "319801043", "story_v_out_319801.awb")
					end

					arg_179_1:RecordHistoryTalkVoice("story_v_out_319801", "319801043", "story_v_out_319801.awb")
				end

				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_10 = math.max(var_182_3, arg_179_1.talkMaxDuration)

			if var_182_2 <= arg_179_1.time_ and arg_179_1.time_ < var_182_2 + var_182_10 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - var_182_2) / var_182_10

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= var_182_2 + var_182_10 and arg_179_1.time_ < var_182_2 + var_182_10 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {}

		arg_179_1:InitPlayNodeList()
	end,
	Play319801044 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 319801044
		arg_183_1.duration_ = 4.47

		local var_183_0 = {
			zh = 4.2,
			ja = 4.466
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
				arg_183_0:Play319801045(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				arg_183_1.var_.moveOldPos10068ui_story = arg_183_1.actors_["10068ui_story"].transform.localPosition
			end

			local var_186_0 = 0.001

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_0 then
				arg_183_1.actors_["10068ui_story"].transform.localPosition = Vector3.Lerp(arg_183_1.var_.moveOldPos10068ui_story, Vector3.New(0, -0.75, -6.18), (arg_183_1.time_ - 0) / var_186_0)
				arg_183_1.actors_["10068ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_183_1.actors_["10068ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_183_1.actors_["10068ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_183_1.actors_["10068ui_story"].transform.position).z)
				arg_183_1.actors_["10068ui_story"].transform.localEulerAngles.z = 0
				arg_183_1.actors_["10068ui_story"].transform.localEulerAngles.x = 0
				arg_183_1.actors_["10068ui_story"].transform.localEulerAngles = arg_183_1.actors_["10068ui_story"].transform.localEulerAngles
			end

			if arg_183_1.time_ >= 0 + var_186_0 and arg_183_1.time_ < 0 + var_186_0 + arg_186_0 then
				arg_183_1.actors_["10068ui_story"].transform.localPosition = Vector3.New(0, -0.75, -6.18)
				arg_183_1.actors_["10068ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_183_1.actors_["10068ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_183_1.actors_["10068ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_183_1.actors_["10068ui_story"].transform.position).z)
				arg_183_1.actors_["10068ui_story"].transform.localEulerAngles.z = 0
				arg_183_1.actors_["10068ui_story"].transform.localEulerAngles.x = 0
				arg_183_1.actors_["10068ui_story"].transform.localEulerAngles = arg_183_1.actors_["10068ui_story"].transform.localEulerAngles
			end

			local var_186_1 = arg_183_1.actors_["10068ui_story"]

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 and not isNil(var_186_1) and arg_183_1.var_.characterEffect10068ui_story == nil then
				arg_183_1.var_.characterEffect10068ui_story = var_186_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_186_2 = 0.200000002980232

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_2 and not isNil(var_186_1) then
				if arg_183_1.var_.characterEffect10068ui_story and not isNil(var_186_1) then
					arg_183_1.var_.characterEffect10068ui_story.fillFlat = false
				end
			end

			if arg_183_1.time_ >= 0 + var_186_2 and arg_183_1.time_ < 0 + var_186_2 + arg_186_0 and not isNil(var_186_1) and arg_183_1.var_.characterEffect10068ui_story then
				arg_183_1.var_.characterEffect10068ui_story.fillFlat = false
			end

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				arg_183_1:PlayTimeline("10068ui_story", "StoryTimeline/CharAction/story10068/story10068action/10068action3_1")
			end

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				arg_183_1:PlayTimeline("10068ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_186_4 = arg_183_1.actors_["10058ui_story"].transform

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				arg_183_1.var_.moveOldPos10058ui_story = var_186_4.localPosition
			end

			local var_186_5 = 0.001

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_5 then
				var_186_4.localPosition = Vector3.Lerp(arg_183_1.var_.moveOldPos10058ui_story, Vector3.New(0, 100, 0), (arg_183_1.time_ - 0) / var_186_5)
				var_186_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_186_4.position).x, (manager.ui.mainCamera.transform.position - var_186_4.position).y, (manager.ui.mainCamera.transform.position - var_186_4.position).z)
				var_186_4.localEulerAngles.z = 0
				var_186_4.localEulerAngles.x = 0
				var_186_4.localEulerAngles = var_186_4.localEulerAngles
			end

			if arg_183_1.time_ >= 0 + var_186_5 and arg_183_1.time_ < 0 + var_186_5 + arg_186_0 then
				var_186_4.localPosition = Vector3.New(0, 100, 0)
				var_186_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_186_4.position).x, (manager.ui.mainCamera.transform.position - var_186_4.position).y, (manager.ui.mainCamera.transform.position - var_186_4.position).z)
				var_186_4.localEulerAngles.z = 0
				var_186_4.localEulerAngles.x = 0
				var_186_4.localEulerAngles = var_186_4.localEulerAngles
			end

			local var_186_6 = 0
			local var_186_7 = 0.45

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= var_186_6 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, true)

				arg_183_1.leftNameTxt_.text = arg_183_1:FormatText(StoryNameCfg[697].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_183_1.leftNameTxt_.transform)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1.leftNameTxt_.text)
				SetActive(arg_183_1.iconTrs_.gameObject, false)
				arg_183_1.callingController_:SetSelectedState("normal")

				local var_186_8 = arg_183_1:GetWordFromCfg(319801044)
				local var_186_9 = arg_183_1:FormatText(var_186_8.content)

				arg_183_1.text_.text = var_186_9

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_11 = 18 <= 0 and var_186_7 or var_186_7 * (utf8.len(var_186_9) / 18)

				if (18 <= 0 and var_186_7 or var_186_7 * (utf8.len(var_186_9) / 18)) > 0 and var_186_7 < var_186_11 then
					arg_183_1.talkMaxDuration = var_186_11

					if var_186_11 + var_186_6 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_11 + var_186_6
					end
				end

				arg_183_1.text_.text = var_186_9
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319801", "319801044", "story_v_out_319801.awb") ~= 0 then
					local var_186_12 = manager.audio:GetVoiceLength("story_v_out_319801", "319801044", "story_v_out_319801.awb") / 1000

					if var_186_12 + var_186_6 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_12 + var_186_6
					end

					if var_186_8.prefab_name ~= "" and arg_183_1.actors_[var_186_8.prefab_name] ~= nil then
						local var_186_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_183_1.actors_[var_186_8.prefab_name].transform, "story_v_out_319801", "319801044", "story_v_out_319801.awb")

						arg_183_1:RecordAudio("319801044", var_186_13)
						arg_183_1:RecordAudio("319801044", var_186_13)
					else
						arg_183_1:AudioAction("play", "voice", "story_v_out_319801", "319801044", "story_v_out_319801.awb")
					end

					arg_183_1:RecordHistoryTalkVoice("story_v_out_319801", "319801044", "story_v_out_319801.awb")
				end

				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_14 = math.max(var_186_7, arg_183_1.talkMaxDuration)

			if var_186_6 <= arg_183_1.time_ and arg_183_1.time_ < var_186_6 + var_186_14 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - var_186_6) / var_186_14

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= var_186_6 + var_186_14 and arg_183_1.time_ < var_186_6 + var_186_14 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10068ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_183_1:InitPlayNodeList()
	end,
	Play319801045 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 319801045
		arg_187_1.duration_ = 5

		SetActive(arg_187_1.tipsGo_, false)

		function arg_187_1.onSingleLineFinish_()
			arg_187_1.onSingleLineUpdate_ = nil
			arg_187_1.onSingleLineFinish_ = nil
			arg_187_1.state_ = "waiting"
		end

		function arg_187_1.playNext_(arg_189_0)
			if arg_189_0 == 1 then
				arg_187_0:Play319801046(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 and not isNil(arg_187_1.actors_["10068ui_story"]) and arg_187_1.var_.characterEffect10068ui_story == nil then
				arg_187_1.var_.characterEffect10068ui_story = arg_187_1.actors_["10068ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_190_0 = 0.200000002980232

			if 0 <= arg_187_1.time_ and arg_187_1.time_ < 0 + var_190_0 and not isNil(arg_187_1.actors_["10068ui_story"]) then
				if arg_187_1.var_.characterEffect10068ui_story and not isNil(arg_187_1.actors_["10068ui_story"]) then
					arg_187_1.var_.characterEffect10068ui_story.fillFlat = true
					arg_187_1.var_.characterEffect10068ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_187_1.time_ - 0) / var_190_0)
				end
			end

			if arg_187_1.time_ >= 0 + var_190_0 and arg_187_1.time_ < 0 + var_190_0 + arg_190_0 and not isNil(arg_187_1.actors_["10068ui_story"]) and arg_187_1.var_.characterEffect10068ui_story then
				arg_187_1.var_.characterEffect10068ui_story.fillFlat = true
				arg_187_1.var_.characterEffect10068ui_story.fillRatio = 0.5
			end

			local var_190_1 = 0
			local var_190_2 = 0.275

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= var_190_1 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, true)

				arg_187_1.leftNameTxt_.text = arg_187_1:FormatText(StoryNameCfg[698].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_187_1.leftNameTxt_.transform)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1.leftNameTxt_.text)
				SetActive(arg_187_1.iconTrs_.gameObject, true)
				arg_187_1.iconController_:SetSelectedState("hero")

				arg_187_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10073")

				arg_187_1.callingController_:SetSelectedState("normal")

				arg_187_1.keyicon_.color = Color.New(1, 1, 1)
				arg_187_1.icon_.color = Color.New(1, 1, 1)

				local var_190_3 = arg_187_1:FormatText(arg_187_1:GetWordFromCfg(319801045).content)

				arg_187_1.text_.text = var_190_3

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_5 = 11 <= 0 and var_190_2 or var_190_2 * (utf8.len(var_190_3) / 11)

				if (11 <= 0 and var_190_2 or var_190_2 * (utf8.len(var_190_3) / 11)) > 0 and var_190_2 < var_190_5 then
					arg_187_1.talkMaxDuration = var_190_5

					if var_190_5 + var_190_1 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_5 + var_190_1
					end
				end

				arg_187_1.text_.text = var_190_3
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)
				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_6 = math.max(var_190_2, arg_187_1.talkMaxDuration)

			if var_190_1 <= arg_187_1.time_ and arg_187_1.time_ < var_190_1 + var_190_6 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - var_190_1) / var_190_6

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= var_190_1 + var_190_6 and arg_187_1.time_ < var_190_1 + var_190_6 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {}

		arg_187_1:InitPlayNodeList()
	end,
	Play319801046 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 319801046
		arg_191_1.duration_ = 5

		SetActive(arg_191_1.tipsGo_, false)

		function arg_191_1.onSingleLineFinish_()
			arg_191_1.onSingleLineUpdate_ = nil
			arg_191_1.onSingleLineFinish_ = nil
			arg_191_1.state_ = "waiting"
		end

		function arg_191_1.playNext_(arg_193_0)
			if arg_193_0 == 1 then
				arg_191_0:Play319801047(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			local var_194_0 = 0.475

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, false)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_191_1.iconTrs_.gameObject, false)
				arg_191_1.callingController_:SetSelectedState("normal")

				local var_194_1 = arg_191_1:FormatText(arg_191_1:GetWordFromCfg(319801046).content)

				arg_191_1.text_.text = var_194_1

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_3 = 19 <= 0 and var_194_0 or var_194_0 * (utf8.len(var_194_1) / 19)

				if (19 <= 0 and var_194_0 or var_194_0 * (utf8.len(var_194_1) / 19)) > 0 and var_194_0 < var_194_3 then
					arg_191_1.talkMaxDuration = var_194_3

					if var_194_3 + 0 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_3 + 0
					end
				end

				arg_191_1.text_.text = var_194_1
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)
				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_4 = math.max(var_194_0, arg_191_1.talkMaxDuration)

			if 0 <= arg_191_1.time_ and arg_191_1.time_ < 0 + var_194_4 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - 0) / var_194_4

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= 0 + var_194_4 and arg_191_1.time_ < 0 + var_194_4 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {}

		arg_191_1:InitPlayNodeList()
	end,
	Play319801047 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 319801047
		arg_195_1.duration_ = 5

		SetActive(arg_195_1.tipsGo_, false)

		function arg_195_1.onSingleLineFinish_()
			arg_195_1.onSingleLineUpdate_ = nil
			arg_195_1.onSingleLineFinish_ = nil
			arg_195_1.state_ = "waiting"
		end

		function arg_195_1.playNext_(arg_197_0)
			if arg_197_0 == 1 then
				arg_195_0:Play319801048(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			local var_198_0 = 0.375

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, true)

				arg_195_1.leftNameTxt_.text = arg_195_1:FormatText(StoryNameCfg[698].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_195_1.leftNameTxt_.transform)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1.leftNameTxt_.text)
				SetActive(arg_195_1.iconTrs_.gameObject, true)
				arg_195_1.iconController_:SetSelectedState("hero")

				arg_195_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10073")

				arg_195_1.callingController_:SetSelectedState("normal")

				arg_195_1.keyicon_.color = Color.New(1, 1, 1)
				arg_195_1.icon_.color = Color.New(1, 1, 1)

				local var_198_1 = arg_195_1:FormatText(arg_195_1:GetWordFromCfg(319801047).content)

				arg_195_1.text_.text = var_198_1

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_3 = 15 <= 0 and var_198_0 or var_198_0 * (utf8.len(var_198_1) / 15)

				if (15 <= 0 and var_198_0 or var_198_0 * (utf8.len(var_198_1) / 15)) > 0 and var_198_0 < var_198_3 then
					arg_195_1.talkMaxDuration = var_198_3

					if var_198_3 + 0 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_3 + 0
					end
				end

				arg_195_1.text_.text = var_198_1
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)
				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_4 = math.max(var_198_0, arg_195_1.talkMaxDuration)

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_4 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - 0) / var_198_4

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= 0 + var_198_4 and arg_195_1.time_ < 0 + var_198_4 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {}

		arg_195_1:InitPlayNodeList()
	end,
	Play319801048 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 319801048
		arg_199_1.duration_ = 5

		SetActive(arg_199_1.tipsGo_, false)

		function arg_199_1.onSingleLineFinish_()
			arg_199_1.onSingleLineUpdate_ = nil
			arg_199_1.onSingleLineFinish_ = nil
			arg_199_1.state_ = "waiting"
		end

		function arg_199_1.playNext_(arg_201_0)
			if arg_201_0 == 1 then
				arg_199_0:Play319801049(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 then
				arg_199_1:AudioAction("play", "effect", "se_story_130", "se_story_130_bowl", "")
			end

			local var_202_1 = arg_199_1.actors_["10068ui_story"].transform

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 then
				arg_199_1.var_.moveOldPos10068ui_story = var_202_1.localPosition
			end

			local var_202_2 = 0.001

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_2 then
				var_202_1.localPosition = Vector3.Lerp(arg_199_1.var_.moveOldPos10068ui_story, Vector3.New(0, 100, 0), (arg_199_1.time_ - 0) / var_202_2)
				var_202_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_202_1.position).x, (manager.ui.mainCamera.transform.position - var_202_1.position).y, (manager.ui.mainCamera.transform.position - var_202_1.position).z)
				var_202_1.localEulerAngles.z = 0
				var_202_1.localEulerAngles.x = 0
				var_202_1.localEulerAngles = var_202_1.localEulerAngles
			end

			if arg_199_1.time_ >= 0 + var_202_2 and arg_199_1.time_ < 0 + var_202_2 + arg_202_0 then
				var_202_1.localPosition = Vector3.New(0, 100, 0)
				var_202_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_202_1.position).x, (manager.ui.mainCamera.transform.position - var_202_1.position).y, (manager.ui.mainCamera.transform.position - var_202_1.position).z)
				var_202_1.localEulerAngles.z = 0
				var_202_1.localEulerAngles.x = 0
				var_202_1.localEulerAngles = var_202_1.localEulerAngles
			end

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 then
				arg_199_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_202_5 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_199_1.bgmTxt_.text ~= var_202_5 and arg_199_1.bgmTxt_.text ~= "" then
						if arg_199_1.bgmTxt2_.text ~= "" then
							arg_199_1.bgmTxt_.text = arg_199_1.bgmTxt2_.text
						end

						arg_199_1.bgmTxt2_.text = var_202_5

						arg_199_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_199_1.bgmTxt_.text = var_202_5
						arg_199_1.bgmTxt2_.text = var_202_5
					end

					if arg_199_1.bgmTimer then
						arg_199_1.bgmTimer:Stop()

						arg_199_1.bgmTimer = nil
					end

					if arg_199_1.settingData.show_music_name == 1 then
						arg_199_1.musicController:SetSelectedState("show")
						arg_199_1.musicAnimator_:Play("open", 0, 0)

						if arg_199_1.settingData.music_time ~= 0 then
							arg_199_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_199_1.settingData.music_time), function()
								if arg_199_1 == nil or isNil(arg_199_1.bgmTxt_) then
									return
								end

								arg_199_1.musicController:SetSelectedState("hide")
								arg_199_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_202_6 = 0
			local var_202_7 = 1.1

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= var_202_6 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, false)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_199_1.iconTrs_.gameObject, false)
				arg_199_1.callingController_:SetSelectedState("normal")

				local var_202_8 = arg_199_1:FormatText(arg_199_1:GetWordFromCfg(319801048).content)

				arg_199_1.text_.text = var_202_8

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_10 = 44 <= 0 and var_202_7 or var_202_7 * (utf8.len(var_202_8) / 44)

				if (44 <= 0 and var_202_7 or var_202_7 * (utf8.len(var_202_8) / 44)) > 0 and var_202_7 < var_202_10 then
					arg_199_1.talkMaxDuration = var_202_10

					if var_202_10 + var_202_6 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_10 + var_202_6
					end
				end

				arg_199_1.text_.text = var_202_8
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)
				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_11 = math.max(var_202_7, arg_199_1.talkMaxDuration)

			if var_202_6 <= arg_199_1.time_ and arg_199_1.time_ < var_202_6 + var_202_11 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - var_202_6) / var_202_11

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= var_202_6 + var_202_11 and arg_199_1.time_ < var_202_6 + var_202_11 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10068ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_199_1:InitPlayNodeList()
	end,
	Play319801049 = function(arg_204_0, arg_204_1)
		arg_204_1.time_ = 0
		arg_204_1.frameCnt_ = 0
		arg_204_1.state_ = "playing"
		arg_204_1.curTalkId_ = 319801049
		arg_204_1.duration_ = 5

		SetActive(arg_204_1.tipsGo_, false)

		function arg_204_1.onSingleLineFinish_()
			arg_204_1.onSingleLineUpdate_ = nil
			arg_204_1.onSingleLineFinish_ = nil
			arg_204_1.state_ = "waiting"
		end

		function arg_204_1.playNext_(arg_206_0)
			if arg_206_0 == 1 then
				arg_204_0:Play319801050(arg_204_1)
			end
		end

		function arg_204_1.onSingleLineUpdate_(arg_207_0)
			local var_207_0 = 0.55

			if 0 < arg_204_1.time_ and arg_204_1.time_ <= 0 + arg_207_0 then
				arg_204_1.talkMaxDuration = 0
				arg_204_1.dialogCg_.alpha = 1

				arg_204_1.dialog_:SetActive(true)
				SetActive(arg_204_1.leftNameGo_, false)

				arg_204_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_204_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_204_1:RecordName(arg_204_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_204_1.iconTrs_.gameObject, false)
				arg_204_1.callingController_:SetSelectedState("normal")

				local var_207_1 = arg_204_1:FormatText(arg_204_1:GetWordFromCfg(319801049).content)

				arg_204_1.text_.text = var_207_1

				LuaForUtil.ClearLinePrefixSymbol(arg_204_1.text_)

				local var_207_3 = 22 <= 0 and var_207_0 or var_207_0 * (utf8.len(var_207_1) / 22)

				if (22 <= 0 and var_207_0 or var_207_0 * (utf8.len(var_207_1) / 22)) > 0 and var_207_0 < var_207_3 then
					arg_204_1.talkMaxDuration = var_207_3

					if var_207_3 + 0 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_3 + 0
					end
				end

				arg_204_1.text_.text = var_207_1
				arg_204_1.typewritter.percent = 0

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(false)
				arg_204_1:RecordContent(arg_204_1.text_.text)
			end

			local var_207_4 = math.max(var_207_0, arg_204_1.talkMaxDuration)

			if 0 <= arg_204_1.time_ and arg_204_1.time_ < 0 + var_207_4 then
				arg_204_1.typewritter.percent = (arg_204_1.time_ - 0) / var_207_4

				arg_204_1.typewritter:SetDirty()
			end

			if arg_204_1.time_ >= 0 + var_207_4 and arg_204_1.time_ < 0 + var_207_4 + arg_207_0 then
				arg_204_1.typewritter.percent = 1

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(true)
			end
		end

		arg_204_1.nodeConfigList_ = {}

		arg_204_1:InitPlayNodeList()
	end,
	Play319801050 = function(arg_208_0, arg_208_1)
		arg_208_1.time_ = 0
		arg_208_1.frameCnt_ = 0
		arg_208_1.state_ = "playing"
		arg_208_1.curTalkId_ = 319801050
		arg_208_1.duration_ = 7.47

		SetActive(arg_208_1.tipsGo_, false)

		function arg_208_1.onSingleLineFinish_()
			arg_208_1.onSingleLineUpdate_ = nil
			arg_208_1.onSingleLineFinish_ = nil
			arg_208_1.state_ = "waiting"
		end

		function arg_208_1.playNext_(arg_210_0)
			if arg_210_0 == 1 then
				arg_208_0:Play319801051(arg_208_1)
			end
		end

		function arg_208_1.onSingleLineUpdate_(arg_211_0)
			if 1 < arg_208_1.time_ and arg_208_1.time_ <= 1 + arg_211_0 then
				local var_211_0 = arg_208_1.bgs_.ST72a

				arg_208_1.bgs_.ST72a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_211_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_211_1 = var_211_0:GetComponent("SpriteRenderer")

				if var_211_1 and var_211_1.sprite then
					local var_211_2 = 2 * (var_211_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_211_0.transform.localScale = Vector3.New(var_211_2 / var_211_1.sprite.bounds.size.y < var_211_2 * manager.ui.mainCameraCom_.aspect / var_211_1.sprite.bounds.size.x and var_211_2 * manager.ui.mainCameraCom_.aspect / var_211_1.sprite.bounds.size.x or var_211_2 / var_211_1.sprite.bounds.size.y, var_211_2 / var_211_1.sprite.bounds.size.y < var_211_2 * manager.ui.mainCameraCom_.aspect / var_211_1.sprite.bounds.size.x and var_211_2 * manager.ui.mainCameraCom_.aspect / var_211_1.sprite.bounds.size.x or var_211_2 / var_211_1.sprite.bounds.size.y, 0)
				end

				for iter_211_0, iter_211_1 in pairs(arg_208_1.bgs_) do
					if iter_211_0 ~= "ST72a" then
						iter_211_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_211_3 = 0

			if 0 < arg_208_1.time_ and arg_208_1.time_ <= var_211_3 + arg_211_0 then
				arg_208_1.allBtn_.enabled = false
			end

			if arg_208_1.time_ >= var_211_3 + 0.3 and arg_208_1.time_ < var_211_3 + 0.3 + arg_211_0 then
				arg_208_1.allBtn_.enabled = true
			end

			local var_211_4 = 0

			if 0 < arg_208_1.time_ and arg_208_1.time_ <= var_211_4 + arg_211_0 then
				arg_208_1.mask_.enabled = true
				arg_208_1.mask_.raycastTarget = true

				arg_208_1:SetGaussion(false)
			end

			local var_211_5 = 1

			if var_211_4 <= arg_208_1.time_ and arg_208_1.time_ < var_211_4 + var_211_5 then
				local var_211_6 = Color.New(0, 0, 0)

				var_211_6.a = Mathf.Lerp(0, 1, (arg_208_1.time_ - var_211_4) / var_211_5)
				arg_208_1.mask_.color = var_211_6
			end

			if arg_208_1.time_ >= var_211_4 + var_211_5 and arg_208_1.time_ < var_211_4 + var_211_5 + arg_211_0 then
				local var_211_7 = Color.New(0, 0, 0)

				var_211_7.a = 1
				arg_208_1.mask_.color = var_211_7
			end

			local var_211_8 = 1

			if 1 < arg_208_1.time_ and arg_208_1.time_ <= var_211_8 + arg_211_0 then
				arg_208_1.mask_.enabled = true
				arg_208_1.mask_.raycastTarget = true

				arg_208_1:SetGaussion(false)
			end

			local var_211_9 = 2

			if var_211_8 <= arg_208_1.time_ and arg_208_1.time_ < var_211_8 + var_211_9 then
				local var_211_10 = Color.New(0, 0, 0)

				var_211_10.a = Mathf.Lerp(1, 0, (arg_208_1.time_ - var_211_8) / var_211_9)
				arg_208_1.mask_.color = var_211_10
			end

			if arg_208_1.time_ >= var_211_8 + var_211_9 and arg_208_1.time_ < var_211_8 + var_211_9 + arg_211_0 then
				local var_211_11 = Color.New(0, 0, 0)

				arg_208_1.mask_.enabled = false
				var_211_11.a = 0
				arg_208_1.mask_.color = var_211_11
			end

			local var_211_12 = arg_208_1.actors_["10058ui_story"].transform

			if 0 < arg_208_1.time_ and arg_208_1.time_ <= 0 + arg_211_0 then
				arg_208_1.var_.moveOldPos10058ui_story = var_211_12.localPosition
			end

			local var_211_13 = 0.001

			if 0 <= arg_208_1.time_ and arg_208_1.time_ < 0 + var_211_13 then
				var_211_12.localPosition = Vector3.Lerp(arg_208_1.var_.moveOldPos10058ui_story, Vector3.New(0, 100, 0), (arg_208_1.time_ - 0) / var_211_13)
				var_211_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_211_12.position).x, (manager.ui.mainCamera.transform.position - var_211_12.position).y, (manager.ui.mainCamera.transform.position - var_211_12.position).z)
				var_211_12.localEulerAngles.z = 0
				var_211_12.localEulerAngles.x = 0
				var_211_12.localEulerAngles = var_211_12.localEulerAngles
			end

			if arg_208_1.time_ >= 0 + var_211_13 and arg_208_1.time_ < 0 + var_211_13 + arg_211_0 then
				var_211_12.localPosition = Vector3.New(0, 100, 0)
				var_211_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_211_12.position).x, (manager.ui.mainCamera.transform.position - var_211_12.position).y, (manager.ui.mainCamera.transform.position - var_211_12.position).z)
				var_211_12.localEulerAngles.z = 0
				var_211_12.localEulerAngles.x = 0
				var_211_12.localEulerAngles = var_211_12.localEulerAngles
			end

			local var_211_14 = arg_208_1.actors_["10058ui_story"]

			if 0 < arg_208_1.time_ and arg_208_1.time_ <= 0 + arg_211_0 and not isNil(var_211_14) and arg_208_1.var_.characterEffect10058ui_story == nil then
				arg_208_1.var_.characterEffect10058ui_story = var_211_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_211_15 = 0.200000002980232

			if 0 <= arg_208_1.time_ and arg_208_1.time_ < 0 + var_211_15 and not isNil(var_211_14) then
				if arg_208_1.var_.characterEffect10058ui_story and not isNil(var_211_14) then
					arg_208_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_208_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_208_1.time_ - 0) / var_211_15)
				end
			end

			if arg_208_1.time_ >= 0 + var_211_15 and arg_208_1.time_ < 0 + var_211_15 + arg_211_0 and not isNil(var_211_14) and arg_208_1.var_.characterEffect10058ui_story then
				arg_208_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_208_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			local var_211_16 = arg_208_1.actors_["1084ui_story"].transform

			if 0 < arg_208_1.time_ and arg_208_1.time_ <= 0 + arg_211_0 then
				arg_208_1.var_.moveOldPos1084ui_story = var_211_16.localPosition
			end

			local var_211_17 = 0.001

			if 0 <= arg_208_1.time_ and arg_208_1.time_ < 0 + var_211_17 then
				var_211_16.localPosition = Vector3.Lerp(arg_208_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_208_1.time_ - 0) / var_211_17)
				var_211_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_211_16.position).x, (manager.ui.mainCamera.transform.position - var_211_16.position).y, (manager.ui.mainCamera.transform.position - var_211_16.position).z)
				var_211_16.localEulerAngles.z = 0
				var_211_16.localEulerAngles.x = 0
				var_211_16.localEulerAngles = var_211_16.localEulerAngles
			end

			if arg_208_1.time_ >= 0 + var_211_17 and arg_208_1.time_ < 0 + var_211_17 + arg_211_0 then
				var_211_16.localPosition = Vector3.New(0, 100, 0)
				var_211_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_211_16.position).x, (manager.ui.mainCamera.transform.position - var_211_16.position).y, (manager.ui.mainCamera.transform.position - var_211_16.position).z)
				var_211_16.localEulerAngles.z = 0
				var_211_16.localEulerAngles.x = 0
				var_211_16.localEulerAngles = var_211_16.localEulerAngles
			end

			local var_211_18 = arg_208_1.actors_["1084ui_story"]

			if 0 < arg_208_1.time_ and arg_208_1.time_ <= 0 + arg_211_0 and not isNil(var_211_18) and arg_208_1.var_.characterEffect1084ui_story == nil then
				arg_208_1.var_.characterEffect1084ui_story = var_211_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_211_19 = 0.200000002980232

			if 0 <= arg_208_1.time_ and arg_208_1.time_ < 0 + var_211_19 and not isNil(var_211_18) then
				if arg_208_1.var_.characterEffect1084ui_story and not isNil(var_211_18) then
					arg_208_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_208_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_208_1.time_ - 0) / var_211_19)
				end
			end

			if arg_208_1.time_ >= 0 + var_211_19 and arg_208_1.time_ < 0 + var_211_19 + arg_211_0 and not isNil(var_211_18) and arg_208_1.var_.characterEffect1084ui_story then
				arg_208_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_208_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			if arg_208_1.frameCnt_ <= 1 then
				arg_208_1.dialog_:SetActive(false)
			end

			local var_211_20 = 2.46666666666667
			local var_211_21 = 1.425

			if 2.46666666666667 < arg_208_1.time_ and arg_208_1.time_ <= var_211_20 + arg_211_0 then
				arg_208_1.talkMaxDuration = 0

				arg_208_1.dialog_:SetActive(true)

				arg_208_1.dialogCg_.alpha = 0

				local var_211_22 = LeanTween.value(arg_208_1.dialog_, 0, 1, 0.3)

				var_211_22:setOnUpdate(LuaHelper.FloatAction(function(arg_212_0)
					arg_208_1.dialogCg_.alpha = arg_212_0
				end))
				var_211_22:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_208_1.dialog_)
					var_211_22:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_208_1.duration_ = arg_208_1.duration_ + 0.3

				SetActive(arg_208_1.leftNameGo_, false)

				arg_208_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_208_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_208_1:RecordName(arg_208_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_208_1.iconTrs_.gameObject, false)
				arg_208_1.callingController_:SetSelectedState("normal")

				local var_211_23 = arg_208_1:FormatText(arg_208_1:GetWordFromCfg(319801050).content)

				arg_208_1.text_.text = var_211_23

				LuaForUtil.ClearLinePrefixSymbol(arg_208_1.text_)

				local var_211_25 = 57 <= 0 and var_211_21 or var_211_21 * (utf8.len(var_211_23) / 57)

				if (57 <= 0 and var_211_21 or var_211_21 * (utf8.len(var_211_23) / 57)) > 0 and var_211_21 < var_211_25 then
					arg_208_1.talkMaxDuration = var_211_25
					var_211_20 = var_211_20 + 0.3

					if var_211_25 + var_211_20 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_25 + var_211_20
					end
				end

				arg_208_1.text_.text = var_211_23
				arg_208_1.typewritter.percent = 0

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(false)
				arg_208_1:RecordContent(arg_208_1.text_.text)
			end

			local var_211_26 = var_211_20 + 0.3
			local var_211_27 = math.max(var_211_21, arg_208_1.talkMaxDuration)

			if var_211_20 + 0.3 <= arg_208_1.time_ and arg_208_1.time_ < var_211_26 + var_211_27 then
				arg_208_1.typewritter.percent = (arg_208_1.time_ - var_211_26) / var_211_27

				arg_208_1.typewritter:SetDirty()
			end

			if arg_208_1.time_ >= var_211_26 + var_211_27 and arg_208_1.time_ < var_211_26 + var_211_27 + arg_211_0 then
				arg_208_1.typewritter.percent = 1

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(true)
			end
		end

		arg_208_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
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
			}
		}

		arg_208_1:InitPlayNodeList()
	end,
	Play319801051 = function(arg_214_0, arg_214_1)
		arg_214_1.time_ = 0
		arg_214_1.frameCnt_ = 0
		arg_214_1.state_ = "playing"
		arg_214_1.curTalkId_ = 319801051
		arg_214_1.duration_ = 3

		local var_214_0 = {
			zh = 2.166,
			ja = 3
		}
		local var_214_1 = manager.audio:GetLocalizationFlag()

		if var_214_0[var_214_1] ~= nil then
			arg_214_1.duration_ = var_214_0[var_214_1]
		end

		SetActive(arg_214_1.tipsGo_, false)

		function arg_214_1.onSingleLineFinish_()
			arg_214_1.onSingleLineUpdate_ = nil
			arg_214_1.onSingleLineFinish_ = nil
			arg_214_1.state_ = "waiting"
		end

		function arg_214_1.playNext_(arg_216_0)
			if arg_216_0 == 1 then
				arg_214_0:Play319801052(arg_214_1)
			end
		end

		function arg_214_1.onSingleLineUpdate_(arg_217_0)
			if 0 < arg_214_1.time_ and arg_214_1.time_ <= 0 + arg_217_0 then
				arg_214_1.var_.moveOldPos10058ui_story = arg_214_1.actors_["10058ui_story"].transform.localPosition
			end

			local var_217_0 = 0.001

			if 0 <= arg_214_1.time_ and arg_214_1.time_ < 0 + var_217_0 then
				arg_214_1.actors_["10058ui_story"].transform.localPosition = Vector3.Lerp(arg_214_1.var_.moveOldPos10058ui_story, Vector3.New(0, -0.98, -6.1), (arg_214_1.time_ - 0) / var_217_0)
				arg_214_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_214_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_214_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_214_1.actors_["10058ui_story"].transform.position).z)
				arg_214_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_214_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_214_1.actors_["10058ui_story"].transform.localEulerAngles = arg_214_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			if arg_214_1.time_ >= 0 + var_217_0 and arg_214_1.time_ < 0 + var_217_0 + arg_217_0 then
				arg_214_1.actors_["10058ui_story"].transform.localPosition = Vector3.New(0, -0.98, -6.1)
				arg_214_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_214_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_214_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_214_1.actors_["10058ui_story"].transform.position).z)
				arg_214_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_214_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_214_1.actors_["10058ui_story"].transform.localEulerAngles = arg_214_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			local var_217_1 = arg_214_1.actors_["10058ui_story"]

			if 0 < arg_214_1.time_ and arg_214_1.time_ <= 0 + arg_217_0 and not isNil(var_217_1) and arg_214_1.var_.characterEffect10058ui_story == nil then
				arg_214_1.var_.characterEffect10058ui_story = var_217_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_217_2 = 0.200000002980232

			if 0 <= arg_214_1.time_ and arg_214_1.time_ < 0 + var_217_2 and not isNil(var_217_1) then
				if arg_214_1.var_.characterEffect10058ui_story and not isNil(var_217_1) then
					arg_214_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_214_1.time_ >= 0 + var_217_2 and arg_214_1.time_ < 0 + var_217_2 + arg_217_0 and not isNil(var_217_1) and arg_214_1.var_.characterEffect10058ui_story then
				arg_214_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			if 0 < arg_214_1.time_ and arg_214_1.time_ <= 0 + arg_217_0 then
				arg_214_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			if 0 < arg_214_1.time_ and arg_214_1.time_ <= 0 + arg_217_0 then
				arg_214_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_217_4 = 0
			local var_217_5 = 0.225

			if 0 < arg_214_1.time_ and arg_214_1.time_ <= var_217_4 + arg_217_0 then
				arg_214_1.talkMaxDuration = 0
				arg_214_1.dialogCg_.alpha = 1

				arg_214_1.dialog_:SetActive(true)
				SetActive(arg_214_1.leftNameGo_, true)

				arg_214_1.leftNameTxt_.text = arg_214_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_214_1.leftNameTxt_.transform)

				arg_214_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_214_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_214_1:RecordName(arg_214_1.leftNameTxt_.text)
				SetActive(arg_214_1.iconTrs_.gameObject, false)
				arg_214_1.callingController_:SetSelectedState("normal")

				local var_217_6 = arg_214_1:GetWordFromCfg(319801051)
				local var_217_7 = arg_214_1:FormatText(var_217_6.content)

				arg_214_1.text_.text = var_217_7

				LuaForUtil.ClearLinePrefixSymbol(arg_214_1.text_)

				local var_217_9 = 9 <= 0 and var_217_5 or var_217_5 * (utf8.len(var_217_7) / 9)

				if (9 <= 0 and var_217_5 or var_217_5 * (utf8.len(var_217_7) / 9)) > 0 and var_217_5 < var_217_9 then
					arg_214_1.talkMaxDuration = var_217_9

					if var_217_9 + var_217_4 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_9 + var_217_4
					end
				end

				arg_214_1.text_.text = var_217_7
				arg_214_1.typewritter.percent = 0

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319801", "319801051", "story_v_out_319801.awb") ~= 0 then
					local var_217_10 = manager.audio:GetVoiceLength("story_v_out_319801", "319801051", "story_v_out_319801.awb") / 1000

					if var_217_10 + var_217_4 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_10 + var_217_4
					end

					if var_217_6.prefab_name ~= "" and arg_214_1.actors_[var_217_6.prefab_name] ~= nil then
						local var_217_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_214_1.actors_[var_217_6.prefab_name].transform, "story_v_out_319801", "319801051", "story_v_out_319801.awb")

						arg_214_1:RecordAudio("319801051", var_217_11)
						arg_214_1:RecordAudio("319801051", var_217_11)
					else
						arg_214_1:AudioAction("play", "voice", "story_v_out_319801", "319801051", "story_v_out_319801.awb")
					end

					arg_214_1:RecordHistoryTalkVoice("story_v_out_319801", "319801051", "story_v_out_319801.awb")
				end

				arg_214_1:RecordContent(arg_214_1.text_.text)
			end

			local var_217_12 = math.max(var_217_5, arg_214_1.talkMaxDuration)

			if var_217_4 <= arg_214_1.time_ and arg_214_1.time_ < var_217_4 + var_217_12 then
				arg_214_1.typewritter.percent = (arg_214_1.time_ - var_217_4) / var_217_12

				arg_214_1.typewritter:SetDirty()
			end

			if arg_214_1.time_ >= var_217_4 + var_217_12 and arg_214_1.time_ < var_217_4 + var_217_12 + arg_217_0 then
				arg_214_1.typewritter.percent = 1

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(true)
			end
		end

		arg_214_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_214_1:InitPlayNodeList()
	end,
	Play319801052 = function(arg_218_0, arg_218_1)
		arg_218_1.time_ = 0
		arg_218_1.frameCnt_ = 0
		arg_218_1.state_ = "playing"
		arg_218_1.curTalkId_ = 319801052
		arg_218_1.duration_ = 3.93

		local var_218_0 = {
			zh = 1.999999999999,
			ja = 3.933
		}
		local var_218_1 = manager.audio:GetLocalizationFlag()

		if var_218_0[var_218_1] ~= nil then
			arg_218_1.duration_ = var_218_0[var_218_1]
		end

		SetActive(arg_218_1.tipsGo_, false)

		function arg_218_1.onSingleLineFinish_()
			arg_218_1.onSingleLineUpdate_ = nil
			arg_218_1.onSingleLineFinish_ = nil
			arg_218_1.state_ = "waiting"
		end

		function arg_218_1.playNext_(arg_220_0)
			if arg_220_0 == 1 then
				arg_218_0:Play319801053(arg_218_1)
			end
		end

		function arg_218_1.onSingleLineUpdate_(arg_221_0)
			if 0 < arg_218_1.time_ and arg_218_1.time_ <= 0 + arg_221_0 then
				arg_218_1.var_.moveOldPos10066ui_story = arg_218_1.actors_["10066ui_story"].transform.localPosition
			end

			local var_221_0 = 0.001

			if 0 <= arg_218_1.time_ and arg_218_1.time_ < 0 + var_221_0 then
				arg_218_1.actors_["10066ui_story"].transform.localPosition = Vector3.Lerp(arg_218_1.var_.moveOldPos10066ui_story, Vector3.New(0, -0.99, -5.83), (arg_218_1.time_ - 0) / var_221_0)
				arg_218_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_218_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_218_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_218_1.actors_["10066ui_story"].transform.position).z)
				arg_218_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_218_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_218_1.actors_["10066ui_story"].transform.localEulerAngles = arg_218_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			if arg_218_1.time_ >= 0 + var_221_0 and arg_218_1.time_ < 0 + var_221_0 + arg_221_0 then
				arg_218_1.actors_["10066ui_story"].transform.localPosition = Vector3.New(0, -0.99, -5.83)
				arg_218_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_218_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_218_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_218_1.actors_["10066ui_story"].transform.position).z)
				arg_218_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_218_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_218_1.actors_["10066ui_story"].transform.localEulerAngles = arg_218_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			local var_221_1 = arg_218_1.actors_["10066ui_story"]

			if 0 < arg_218_1.time_ and arg_218_1.time_ <= 0 + arg_221_0 and not isNil(var_221_1) and arg_218_1.var_.characterEffect10066ui_story == nil then
				arg_218_1.var_.characterEffect10066ui_story = var_221_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_221_2 = 0.200000002980232

			if 0 <= arg_218_1.time_ and arg_218_1.time_ < 0 + var_221_2 and not isNil(var_221_1) then
				if arg_218_1.var_.characterEffect10066ui_story and not isNil(var_221_1) then
					arg_218_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_218_1.time_ >= 0 + var_221_2 and arg_218_1.time_ < 0 + var_221_2 + arg_221_0 and not isNil(var_221_1) and arg_218_1.var_.characterEffect10066ui_story then
				arg_218_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			if 0 < arg_218_1.time_ and arg_218_1.time_ <= 0 + arg_221_0 then
				arg_218_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action1_1")
			end

			if 0 < arg_218_1.time_ and arg_218_1.time_ <= 0 + arg_221_0 then
				arg_218_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2202cva")
			end

			local var_221_4 = arg_218_1.actors_["10058ui_story"].transform

			if 0 < arg_218_1.time_ and arg_218_1.time_ <= 0 + arg_221_0 then
				arg_218_1.var_.moveOldPos10058ui_story = var_221_4.localPosition
			end

			local var_221_5 = 0.001

			if 0 <= arg_218_1.time_ and arg_218_1.time_ < 0 + var_221_5 then
				var_221_4.localPosition = Vector3.Lerp(arg_218_1.var_.moveOldPos10058ui_story, Vector3.New(0, 100, 0), (arg_218_1.time_ - 0) / var_221_5)
				var_221_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_221_4.position).x, (manager.ui.mainCamera.transform.position - var_221_4.position).y, (manager.ui.mainCamera.transform.position - var_221_4.position).z)
				var_221_4.localEulerAngles.z = 0
				var_221_4.localEulerAngles.x = 0
				var_221_4.localEulerAngles = var_221_4.localEulerAngles
			end

			if arg_218_1.time_ >= 0 + var_221_5 and arg_218_1.time_ < 0 + var_221_5 + arg_221_0 then
				var_221_4.localPosition = Vector3.New(0, 100, 0)
				var_221_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_221_4.position).x, (manager.ui.mainCamera.transform.position - var_221_4.position).y, (manager.ui.mainCamera.transform.position - var_221_4.position).z)
				var_221_4.localEulerAngles.z = 0
				var_221_4.localEulerAngles.x = 0
				var_221_4.localEulerAngles = var_221_4.localEulerAngles
			end

			local var_221_6 = arg_218_1.actors_["10058ui_story"]

			if 0 < arg_218_1.time_ and arg_218_1.time_ <= 0 + arg_221_0 and not isNil(var_221_6) and arg_218_1.var_.characterEffect10058ui_story == nil then
				arg_218_1.var_.characterEffect10058ui_story = var_221_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_221_7 = 0.200000002980232

			if 0 <= arg_218_1.time_ and arg_218_1.time_ < 0 + var_221_7 and not isNil(var_221_6) then
				if arg_218_1.var_.characterEffect10058ui_story and not isNil(var_221_6) then
					arg_218_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_218_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_218_1.time_ - 0) / var_221_7)
				end
			end

			if arg_218_1.time_ >= 0 + var_221_7 and arg_218_1.time_ < 0 + var_221_7 + arg_221_0 and not isNil(var_221_6) and arg_218_1.var_.characterEffect10058ui_story then
				arg_218_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_218_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			local var_221_8 = 0
			local var_221_9 = 0.15

			if 0 < arg_218_1.time_ and arg_218_1.time_ <= var_221_8 + arg_221_0 then
				arg_218_1.talkMaxDuration = 0
				arg_218_1.dialogCg_.alpha = 1

				arg_218_1.dialog_:SetActive(true)
				SetActive(arg_218_1.leftNameGo_, true)

				arg_218_1.leftNameTxt_.text = arg_218_1:FormatText(StoryNameCfg[640].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_218_1.leftNameTxt_.transform)

				arg_218_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_218_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_218_1:RecordName(arg_218_1.leftNameTxt_.text)
				SetActive(arg_218_1.iconTrs_.gameObject, false)
				arg_218_1.callingController_:SetSelectedState("normal")

				local var_221_10 = arg_218_1:GetWordFromCfg(319801052)
				local var_221_11 = arg_218_1:FormatText(var_221_10.content)

				arg_218_1.text_.text = var_221_11

				LuaForUtil.ClearLinePrefixSymbol(arg_218_1.text_)

				local var_221_13 = 6 <= 0 and var_221_9 or var_221_9 * (utf8.len(var_221_11) / 6)

				if (6 <= 0 and var_221_9 or var_221_9 * (utf8.len(var_221_11) / 6)) > 0 and var_221_9 < var_221_13 then
					arg_218_1.talkMaxDuration = var_221_13

					if var_221_13 + var_221_8 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_13 + var_221_8
					end
				end

				arg_218_1.text_.text = var_221_11
				arg_218_1.typewritter.percent = 0

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319801", "319801052", "story_v_out_319801.awb") ~= 0 then
					local var_221_14 = manager.audio:GetVoiceLength("story_v_out_319801", "319801052", "story_v_out_319801.awb") / 1000

					if var_221_14 + var_221_8 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_14 + var_221_8
					end

					if var_221_10.prefab_name ~= "" and arg_218_1.actors_[var_221_10.prefab_name] ~= nil then
						local var_221_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_218_1.actors_[var_221_10.prefab_name].transform, "story_v_out_319801", "319801052", "story_v_out_319801.awb")

						arg_218_1:RecordAudio("319801052", var_221_15)
						arg_218_1:RecordAudio("319801052", var_221_15)
					else
						arg_218_1:AudioAction("play", "voice", "story_v_out_319801", "319801052", "story_v_out_319801.awb")
					end

					arg_218_1:RecordHistoryTalkVoice("story_v_out_319801", "319801052", "story_v_out_319801.awb")
				end

				arg_218_1:RecordContent(arg_218_1.text_.text)
			end

			local var_221_16 = math.max(var_221_9, arg_218_1.talkMaxDuration)

			if var_221_8 <= arg_218_1.time_ and arg_218_1.time_ < var_221_8 + var_221_16 then
				arg_218_1.typewritter.percent = (arg_218_1.time_ - var_221_8) / var_221_16

				arg_218_1.typewritter:SetDirty()
			end

			if arg_218_1.time_ >= var_221_8 + var_221_16 and arg_218_1.time_ < var_221_8 + var_221_16 + arg_221_0 then
				arg_218_1.typewritter.percent = 1

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(true)
			end
		end

		arg_218_1.nodeConfigList_ = {
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
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_218_1:InitPlayNodeList()
	end,
	Play319801053 = function(arg_222_0, arg_222_1)
		arg_222_1.time_ = 0
		arg_222_1.frameCnt_ = 0
		arg_222_1.state_ = "playing"
		arg_222_1.curTalkId_ = 319801053
		arg_222_1.duration_ = 5

		SetActive(arg_222_1.tipsGo_, false)

		function arg_222_1.onSingleLineFinish_()
			arg_222_1.onSingleLineUpdate_ = nil
			arg_222_1.onSingleLineFinish_ = nil
			arg_222_1.state_ = "waiting"
		end

		function arg_222_1.playNext_(arg_224_0)
			if arg_224_0 == 1 then
				arg_222_0:Play319801054(arg_222_1)
			end
		end

		function arg_222_1.onSingleLineUpdate_(arg_225_0)
			if 0 < arg_222_1.time_ and arg_222_1.time_ <= 0 + arg_225_0 and not isNil(arg_222_1.actors_["10066ui_story"]) and arg_222_1.var_.characterEffect10066ui_story == nil then
				arg_222_1.var_.characterEffect10066ui_story = arg_222_1.actors_["10066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_225_0 = 0.200000002980232

			if 0 <= arg_222_1.time_ and arg_222_1.time_ < 0 + var_225_0 and not isNil(arg_222_1.actors_["10066ui_story"]) then
				if arg_222_1.var_.characterEffect10066ui_story and not isNil(arg_222_1.actors_["10066ui_story"]) then
					arg_222_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_222_1.var_.characterEffect10066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_222_1.time_ - 0) / var_225_0)
				end
			end

			if arg_222_1.time_ >= 0 + var_225_0 and arg_222_1.time_ < 0 + var_225_0 + arg_225_0 and not isNil(arg_222_1.actors_["10066ui_story"]) and arg_222_1.var_.characterEffect10066ui_story then
				arg_222_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_222_1.var_.characterEffect10066ui_story.fillRatio = 0.5
			end

			local var_225_1 = arg_222_1.actors_["10066ui_story"].transform

			if 0 < arg_222_1.time_ and arg_222_1.time_ <= 0 + arg_225_0 then
				arg_222_1.var_.moveOldPos10066ui_story = var_225_1.localPosition
			end

			local var_225_2 = 0.001

			if 0 <= arg_222_1.time_ and arg_222_1.time_ < 0 + var_225_2 then
				var_225_1.localPosition = Vector3.Lerp(arg_222_1.var_.moveOldPos10066ui_story, Vector3.New(0, 100, 0), (arg_222_1.time_ - 0) / var_225_2)
				var_225_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_225_1.position).x, (manager.ui.mainCamera.transform.position - var_225_1.position).y, (manager.ui.mainCamera.transform.position - var_225_1.position).z)
				var_225_1.localEulerAngles.z = 0
				var_225_1.localEulerAngles.x = 0
				var_225_1.localEulerAngles = var_225_1.localEulerAngles
			end

			if arg_222_1.time_ >= 0 + var_225_2 and arg_222_1.time_ < 0 + var_225_2 + arg_225_0 then
				var_225_1.localPosition = Vector3.New(0, 100, 0)
				var_225_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_225_1.position).x, (manager.ui.mainCamera.transform.position - var_225_1.position).y, (manager.ui.mainCamera.transform.position - var_225_1.position).z)
				var_225_1.localEulerAngles.z = 0
				var_225_1.localEulerAngles.x = 0
				var_225_1.localEulerAngles = var_225_1.localEulerAngles
			end

			local var_225_3 = 0
			local var_225_4 = 0.95

			if 0 < arg_222_1.time_ and arg_222_1.time_ <= var_225_3 + arg_225_0 then
				arg_222_1.talkMaxDuration = 0
				arg_222_1.dialogCg_.alpha = 1

				arg_222_1.dialog_:SetActive(true)
				SetActive(arg_222_1.leftNameGo_, false)

				arg_222_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_222_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_222_1:RecordName(arg_222_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_222_1.iconTrs_.gameObject, false)
				arg_222_1.callingController_:SetSelectedState("normal")

				local var_225_5 = arg_222_1:FormatText(arg_222_1:GetWordFromCfg(319801053).content)

				arg_222_1.text_.text = var_225_5

				LuaForUtil.ClearLinePrefixSymbol(arg_222_1.text_)

				local var_225_7 = 38 <= 0 and var_225_4 or var_225_4 * (utf8.len(var_225_5) / 38)

				if (38 <= 0 and var_225_4 or var_225_4 * (utf8.len(var_225_5) / 38)) > 0 and var_225_4 < var_225_7 then
					arg_222_1.talkMaxDuration = var_225_7

					if var_225_7 + var_225_3 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_7 + var_225_3
					end
				end

				arg_222_1.text_.text = var_225_5
				arg_222_1.typewritter.percent = 0

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(false)
				arg_222_1:RecordContent(arg_222_1.text_.text)
			end

			local var_225_8 = math.max(var_225_4, arg_222_1.talkMaxDuration)

			if var_225_3 <= arg_222_1.time_ and arg_222_1.time_ < var_225_3 + var_225_8 then
				arg_222_1.typewritter.percent = (arg_222_1.time_ - var_225_3) / var_225_8

				arg_222_1.typewritter:SetDirty()
			end

			if arg_222_1.time_ >= var_225_3 + var_225_8 and arg_222_1.time_ < var_225_3 + var_225_8 + arg_225_0 then
				arg_222_1.typewritter.percent = 1

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(true)
			end
		end

		arg_222_1.nodeConfigList_ = {
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

		arg_222_1:InitPlayNodeList()
	end,
	Play319801054 = function(arg_226_0, arg_226_1)
		arg_226_1.time_ = 0
		arg_226_1.frameCnt_ = 0
		arg_226_1.state_ = "playing"
		arg_226_1.curTalkId_ = 319801054
		arg_226_1.duration_ = 5

		SetActive(arg_226_1.tipsGo_, false)

		function arg_226_1.onSingleLineFinish_()
			arg_226_1.onSingleLineUpdate_ = nil
			arg_226_1.onSingleLineFinish_ = nil
			arg_226_1.state_ = "waiting"
		end

		function arg_226_1.playNext_(arg_228_0)
			if arg_228_0 == 1 then
				arg_226_0:Play319801055(arg_226_1)
			end
		end

		function arg_226_1.onSingleLineUpdate_(arg_229_0)
			local var_229_0 = 0.475

			if 0 < arg_226_1.time_ and arg_226_1.time_ <= 0 + arg_229_0 then
				arg_226_1.talkMaxDuration = 0
				arg_226_1.dialogCg_.alpha = 1

				arg_226_1.dialog_:SetActive(true)
				SetActive(arg_226_1.leftNameGo_, true)

				arg_226_1.leftNameTxt_.text = arg_226_1:FormatText(StoryNameCfg[698].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_226_1.leftNameTxt_.transform)

				arg_226_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_226_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_226_1:RecordName(arg_226_1.leftNameTxt_.text)
				SetActive(arg_226_1.iconTrs_.gameObject, true)
				arg_226_1.iconController_:SetSelectedState("hero")

				arg_226_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10073")

				arg_226_1.callingController_:SetSelectedState("normal")

				arg_226_1.keyicon_.color = Color.New(1, 1, 1)
				arg_226_1.icon_.color = Color.New(1, 1, 1)

				local var_229_1 = arg_226_1:FormatText(arg_226_1:GetWordFromCfg(319801054).content)

				arg_226_1.text_.text = var_229_1

				LuaForUtil.ClearLinePrefixSymbol(arg_226_1.text_)

				local var_229_3 = 19 <= 0 and var_229_0 or var_229_0 * (utf8.len(var_229_1) / 19)

				if (19 <= 0 and var_229_0 or var_229_0 * (utf8.len(var_229_1) / 19)) > 0 and var_229_0 < var_229_3 then
					arg_226_1.talkMaxDuration = var_229_3

					if var_229_3 + 0 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_3 + 0
					end
				end

				arg_226_1.text_.text = var_229_1
				arg_226_1.typewritter.percent = 0

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(false)
				arg_226_1:RecordContent(arg_226_1.text_.text)
			end

			local var_229_4 = math.max(var_229_0, arg_226_1.talkMaxDuration)

			if 0 <= arg_226_1.time_ and arg_226_1.time_ < 0 + var_229_4 then
				arg_226_1.typewritter.percent = (arg_226_1.time_ - 0) / var_229_4

				arg_226_1.typewritter:SetDirty()
			end

			if arg_226_1.time_ >= 0 + var_229_4 and arg_226_1.time_ < 0 + var_229_4 + arg_229_0 then
				arg_226_1.typewritter.percent = 1

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(true)
			end
		end

		arg_226_1.nodeConfigList_ = {}

		arg_226_1:InitPlayNodeList()
	end,
	Play319801055 = function(arg_230_0, arg_230_1)
		arg_230_1.time_ = 0
		arg_230_1.frameCnt_ = 0
		arg_230_1.state_ = "playing"
		arg_230_1.curTalkId_ = 319801055
		arg_230_1.duration_ = 1.8

		local var_230_0 = {
			zh = 1.8,
			ja = 1.433
		}
		local var_230_1 = manager.audio:GetLocalizationFlag()

		if var_230_0[var_230_1] ~= nil then
			arg_230_1.duration_ = var_230_0[var_230_1]
		end

		SetActive(arg_230_1.tipsGo_, false)

		function arg_230_1.onSingleLineFinish_()
			arg_230_1.onSingleLineUpdate_ = nil
			arg_230_1.onSingleLineFinish_ = nil
			arg_230_1.state_ = "waiting"
		end

		function arg_230_1.playNext_(arg_232_0)
			if arg_232_0 == 1 then
				arg_230_0:Play319801056(arg_230_1)
			end
		end

		function arg_230_1.onSingleLineUpdate_(arg_233_0)
			if 0 < arg_230_1.time_ and arg_230_1.time_ <= 0 + arg_233_0 then
				arg_230_1.var_.moveOldPos10066ui_story = arg_230_1.actors_["10066ui_story"].transform.localPosition
			end

			local var_233_0 = 0.001

			if 0 <= arg_230_1.time_ and arg_230_1.time_ < 0 + var_233_0 then
				arg_230_1.actors_["10066ui_story"].transform.localPosition = Vector3.Lerp(arg_230_1.var_.moveOldPos10066ui_story, Vector3.New(0, -0.99, -5.83), (arg_230_1.time_ - 0) / var_233_0)
				arg_230_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_230_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_230_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_230_1.actors_["10066ui_story"].transform.position).z)
				arg_230_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_230_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_230_1.actors_["10066ui_story"].transform.localEulerAngles = arg_230_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			if arg_230_1.time_ >= 0 + var_233_0 and arg_230_1.time_ < 0 + var_233_0 + arg_233_0 then
				arg_230_1.actors_["10066ui_story"].transform.localPosition = Vector3.New(0, -0.99, -5.83)
				arg_230_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_230_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_230_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_230_1.actors_["10066ui_story"].transform.position).z)
				arg_230_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_230_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_230_1.actors_["10066ui_story"].transform.localEulerAngles = arg_230_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			local var_233_1 = arg_230_1.actors_["10066ui_story"]

			if 0 < arg_230_1.time_ and arg_230_1.time_ <= 0 + arg_233_0 and not isNil(var_233_1) and arg_230_1.var_.characterEffect10066ui_story == nil then
				arg_230_1.var_.characterEffect10066ui_story = var_233_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_233_2 = 0.200000002980232

			if 0 <= arg_230_1.time_ and arg_230_1.time_ < 0 + var_233_2 and not isNil(var_233_1) then
				if arg_230_1.var_.characterEffect10066ui_story and not isNil(var_233_1) then
					arg_230_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_230_1.time_ >= 0 + var_233_2 and arg_230_1.time_ < 0 + var_233_2 + arg_233_0 and not isNil(var_233_1) and arg_230_1.var_.characterEffect10066ui_story then
				arg_230_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			local var_233_4 = 0
			local var_233_5 = 0.1

			if 0 < arg_230_1.time_ and arg_230_1.time_ <= var_233_4 + arg_233_0 then
				arg_230_1.talkMaxDuration = 0
				arg_230_1.dialogCg_.alpha = 1

				arg_230_1.dialog_:SetActive(true)
				SetActive(arg_230_1.leftNameGo_, true)

				arg_230_1.leftNameTxt_.text = arg_230_1:FormatText(StoryNameCfg[640].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_230_1.leftNameTxt_.transform)

				arg_230_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_230_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_230_1:RecordName(arg_230_1.leftNameTxt_.text)
				SetActive(arg_230_1.iconTrs_.gameObject, false)
				arg_230_1.callingController_:SetSelectedState("normal")

				local var_233_6 = arg_230_1:GetWordFromCfg(319801055)
				local var_233_7 = arg_230_1:FormatText(var_233_6.content)

				arg_230_1.text_.text = var_233_7

				LuaForUtil.ClearLinePrefixSymbol(arg_230_1.text_)

				local var_233_9 = 4 <= 0 and var_233_5 or var_233_5 * (utf8.len(var_233_7) / 4)

				if (4 <= 0 and var_233_5 or var_233_5 * (utf8.len(var_233_7) / 4)) > 0 and var_233_5 < var_233_9 then
					arg_230_1.talkMaxDuration = var_233_9

					if var_233_9 + var_233_4 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_9 + var_233_4
					end
				end

				arg_230_1.text_.text = var_233_7
				arg_230_1.typewritter.percent = 0

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319801", "319801055", "story_v_out_319801.awb") ~= 0 then
					local var_233_10 = manager.audio:GetVoiceLength("story_v_out_319801", "319801055", "story_v_out_319801.awb") / 1000

					if var_233_10 + var_233_4 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_10 + var_233_4
					end

					if var_233_6.prefab_name ~= "" and arg_230_1.actors_[var_233_6.prefab_name] ~= nil then
						local var_233_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_230_1.actors_[var_233_6.prefab_name].transform, "story_v_out_319801", "319801055", "story_v_out_319801.awb")

						arg_230_1:RecordAudio("319801055", var_233_11)
						arg_230_1:RecordAudio("319801055", var_233_11)
					else
						arg_230_1:AudioAction("play", "voice", "story_v_out_319801", "319801055", "story_v_out_319801.awb")
					end

					arg_230_1:RecordHistoryTalkVoice("story_v_out_319801", "319801055", "story_v_out_319801.awb")
				end

				arg_230_1:RecordContent(arg_230_1.text_.text)
			end

			local var_233_12 = math.max(var_233_5, arg_230_1.talkMaxDuration)

			if var_233_4 <= arg_230_1.time_ and arg_230_1.time_ < var_233_4 + var_233_12 then
				arg_230_1.typewritter.percent = (arg_230_1.time_ - var_233_4) / var_233_12

				arg_230_1.typewritter:SetDirty()
			end

			if arg_230_1.time_ >= var_233_4 + var_233_12 and arg_230_1.time_ < var_233_4 + var_233_12 + arg_233_0 then
				arg_230_1.typewritter.percent = 1

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(true)
			end
		end

		arg_230_1.nodeConfigList_ = {
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

		arg_230_1:InitPlayNodeList()
	end,
	Play319801056 = function(arg_234_0, arg_234_1)
		arg_234_1.time_ = 0
		arg_234_1.frameCnt_ = 0
		arg_234_1.state_ = "playing"
		arg_234_1.curTalkId_ = 319801056
		arg_234_1.duration_ = 6

		SetActive(arg_234_1.tipsGo_, false)

		function arg_234_1.onSingleLineFinish_()
			arg_234_1.onSingleLineUpdate_ = nil
			arg_234_1.onSingleLineFinish_ = nil
			arg_234_1.state_ = "waiting"
		end

		function arg_234_1.playNext_(arg_236_0)
			if arg_236_0 == 1 then
				arg_234_0:Play319801057(arg_234_1)
			end
		end

		function arg_234_1.onSingleLineUpdate_(arg_237_0)
			if 0 < arg_234_1.time_ and arg_234_1.time_ <= 0 + arg_237_0 then
				arg_234_1:AudioAction("play", "effect", "se_story_121_04", "se_story_121_04_earthquake_loop", "")
			end

			local var_237_1 = arg_234_1.actors_["10066ui_story"].transform

			if 0 < arg_234_1.time_ and arg_234_1.time_ <= 0 + arg_237_0 then
				arg_234_1.var_.moveOldPos10066ui_story = var_237_1.localPosition
			end

			local var_237_2 = 0.001

			if 0 <= arg_234_1.time_ and arg_234_1.time_ < 0 + var_237_2 then
				var_237_1.localPosition = Vector3.Lerp(arg_234_1.var_.moveOldPos10066ui_story, Vector3.New(0, 100, 0), (arg_234_1.time_ - 0) / var_237_2)
				var_237_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_237_1.position).x, (manager.ui.mainCamera.transform.position - var_237_1.position).y, (manager.ui.mainCamera.transform.position - var_237_1.position).z)
				var_237_1.localEulerAngles.z = 0
				var_237_1.localEulerAngles.x = 0
				var_237_1.localEulerAngles = var_237_1.localEulerAngles
			end

			if arg_234_1.time_ >= 0 + var_237_2 and arg_234_1.time_ < 0 + var_237_2 + arg_237_0 then
				var_237_1.localPosition = Vector3.New(0, 100, 0)
				var_237_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_237_1.position).x, (manager.ui.mainCamera.transform.position - var_237_1.position).y, (manager.ui.mainCamera.transform.position - var_237_1.position).z)
				var_237_1.localEulerAngles.z = 0
				var_237_1.localEulerAngles.x = 0
				var_237_1.localEulerAngles = var_237_1.localEulerAngles
			end

			local var_237_3 = 0

			if 0 < arg_234_1.time_ and arg_234_1.time_ <= var_237_3 + arg_237_0 then
				arg_234_1.mask_.enabled = true
				arg_234_1.mask_.raycastTarget = false

				arg_234_1:SetGaussion(false)
			end

			local var_237_4 = 0.333333333333333

			if var_237_3 <= arg_234_1.time_ and arg_234_1.time_ < var_237_3 + var_237_4 then
				local var_237_5 = Color.New(1, 1, 1)

				var_237_5.a = Mathf.Lerp(1, 0, (arg_234_1.time_ - var_237_3) / var_237_4)
				arg_234_1.mask_.color = var_237_5
			end

			if arg_234_1.time_ >= var_237_3 + var_237_4 and arg_234_1.time_ < var_237_3 + var_237_4 + arg_237_0 then
				local var_237_6 = Color.New(1, 1, 1)

				arg_234_1.mask_.enabled = false
				var_237_6.a = 0
				arg_234_1.mask_.color = var_237_6
			end

			local var_237_7 = manager.ui.mainCamera.transform

			if 0.333333333333333 < arg_234_1.time_ and arg_234_1.time_ <= 0.333333333333333 + arg_237_0 then
				arg_234_1.var_.shakeOldPos = var_237_7.localPosition
			end

			local var_237_8 = 0.5

			if 0.333333333333333 <= arg_234_1.time_ and arg_234_1.time_ < 0.333333333333333 + var_237_8 then
				local var_237_9, var_237_10 = math.modf((arg_234_1.time_ - 0.333333333333333) / 0.066)

				var_237_7.localPosition = Vector3.New(var_237_10 * 0.13, var_237_10 * 0.13, var_237_10 * 0.13) + arg_234_1.var_.shakeOldPos
			end

			if arg_234_1.time_ >= 0.333333333333333 + var_237_8 and arg_234_1.time_ < 0.333333333333333 + var_237_8 + arg_237_0 then
				var_237_7.localPosition = arg_234_1.var_.shakeOldPos
			end

			if arg_234_1.frameCnt_ <= 1 then
				arg_234_1.dialog_:SetActive(false)
			end

			local var_237_11 = 1
			local var_237_12 = 1.2

			if 1 < arg_234_1.time_ and arg_234_1.time_ <= var_237_11 + arg_237_0 then
				arg_234_1.talkMaxDuration = 0

				arg_234_1.dialog_:SetActive(true)

				arg_234_1.dialogCg_.alpha = 0

				local var_237_13 = LeanTween.value(arg_234_1.dialog_, 0, 1, 0.3)

				var_237_13:setOnUpdate(LuaHelper.FloatAction(function(arg_238_0)
					arg_234_1.dialogCg_.alpha = arg_238_0
				end))
				var_237_13:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_234_1.dialog_)
					var_237_13:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_234_1.duration_ = arg_234_1.duration_ + 0.3

				SetActive(arg_234_1.leftNameGo_, false)

				arg_234_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_234_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_234_1:RecordName(arg_234_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_234_1.iconTrs_.gameObject, false)
				arg_234_1.callingController_:SetSelectedState("normal")

				local var_237_14 = arg_234_1:FormatText(arg_234_1:GetWordFromCfg(319801056).content)

				arg_234_1.text_.text = var_237_14

				LuaForUtil.ClearLinePrefixSymbol(arg_234_1.text_)

				local var_237_16 = 48 <= 0 and var_237_12 or var_237_12 * (utf8.len(var_237_14) / 48)

				if (48 <= 0 and var_237_12 or var_237_12 * (utf8.len(var_237_14) / 48)) > 0 and var_237_12 < var_237_16 then
					arg_234_1.talkMaxDuration = var_237_16
					var_237_11 = var_237_11 + 0.3

					if var_237_16 + var_237_11 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_16 + var_237_11
					end
				end

				arg_234_1.text_.text = var_237_14
				arg_234_1.typewritter.percent = 0

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(false)
				arg_234_1:RecordContent(arg_234_1.text_.text)
			end

			local var_237_17 = var_237_11 + 0.3
			local var_237_18 = math.max(var_237_12, arg_234_1.talkMaxDuration)

			if var_237_11 + 0.3 <= arg_234_1.time_ and arg_234_1.time_ < var_237_17 + var_237_18 then
				arg_234_1.typewritter.percent = (arg_234_1.time_ - var_237_17) / var_237_18

				arg_234_1.typewritter:SetDirty()
			end

			if arg_234_1.time_ >= var_237_17 + var_237_18 and arg_234_1.time_ < var_237_17 + var_237_18 + arg_237_0 then
				arg_234_1.typewritter.percent = 1

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(true)
			end
		end

		arg_234_1.nodeConfigList_ = {
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

		arg_234_1:InitPlayNodeList()
	end,
	Play319801057 = function(arg_240_0, arg_240_1)
		arg_240_1.time_ = 0
		arg_240_1.frameCnt_ = 0
		arg_240_1.state_ = "playing"
		arg_240_1.curTalkId_ = 319801057
		arg_240_1.duration_ = 3.73

		local var_240_0 = {
			zh = 2.133,
			ja = 3.733
		}
		local var_240_1 = manager.audio:GetLocalizationFlag()

		if var_240_0[var_240_1] ~= nil then
			arg_240_1.duration_ = var_240_0[var_240_1]
		end

		SetActive(arg_240_1.tipsGo_, false)

		function arg_240_1.onSingleLineFinish_()
			arg_240_1.onSingleLineUpdate_ = nil
			arg_240_1.onSingleLineFinish_ = nil
			arg_240_1.state_ = "waiting"
		end

		function arg_240_1.playNext_(arg_242_0)
			if arg_242_0 == 1 then
				arg_240_0:Play319801058(arg_240_1)
			end
		end

		function arg_240_1.onSingleLineUpdate_(arg_243_0)
			if 0 < arg_240_1.time_ and arg_240_1.time_ <= 0 + arg_243_0 then
				arg_240_1.var_.moveOldPos10066ui_story = arg_240_1.actors_["10066ui_story"].transform.localPosition
			end

			local var_243_0 = 0.001

			if 0 <= arg_240_1.time_ and arg_240_1.time_ < 0 + var_243_0 then
				arg_240_1.actors_["10066ui_story"].transform.localPosition = Vector3.Lerp(arg_240_1.var_.moveOldPos10066ui_story, Vector3.New(0, -0.99, -5.83), (arg_240_1.time_ - 0) / var_243_0)
				arg_240_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_240_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_240_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_240_1.actors_["10066ui_story"].transform.position).z)
				arg_240_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_240_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_240_1.actors_["10066ui_story"].transform.localEulerAngles = arg_240_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			if arg_240_1.time_ >= 0 + var_243_0 and arg_240_1.time_ < 0 + var_243_0 + arg_243_0 then
				arg_240_1.actors_["10066ui_story"].transform.localPosition = Vector3.New(0, -0.99, -5.83)
				arg_240_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_240_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_240_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_240_1.actors_["10066ui_story"].transform.position).z)
				arg_240_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_240_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_240_1.actors_["10066ui_story"].transform.localEulerAngles = arg_240_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			local var_243_1 = arg_240_1.actors_["10066ui_story"]

			if 0 < arg_240_1.time_ and arg_240_1.time_ <= 0 + arg_243_0 and not isNil(var_243_1) and arg_240_1.var_.characterEffect10066ui_story == nil then
				arg_240_1.var_.characterEffect10066ui_story = var_243_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_243_2 = 0.200000002980232

			if 0 <= arg_240_1.time_ and arg_240_1.time_ < 0 + var_243_2 and not isNil(var_243_1) then
				if arg_240_1.var_.characterEffect10066ui_story and not isNil(var_243_1) then
					arg_240_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_240_1.time_ >= 0 + var_243_2 and arg_240_1.time_ < 0 + var_243_2 + arg_243_0 and not isNil(var_243_1) and arg_240_1.var_.characterEffect10066ui_story then
				arg_240_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			if 0 < arg_240_1.time_ and arg_240_1.time_ <= 0 + arg_243_0 then
				arg_240_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action7_1")
			end

			if 0 < arg_240_1.time_ and arg_240_1.time_ <= 0 + arg_243_0 then
				arg_240_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_243_4 = 0
			local var_243_5 = 0.175

			if 0 < arg_240_1.time_ and arg_240_1.time_ <= var_243_4 + arg_243_0 then
				arg_240_1.talkMaxDuration = 0
				arg_240_1.dialogCg_.alpha = 1

				arg_240_1.dialog_:SetActive(true)
				SetActive(arg_240_1.leftNameGo_, true)

				arg_240_1.leftNameTxt_.text = arg_240_1:FormatText(StoryNameCfg[640].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_240_1.leftNameTxt_.transform)

				arg_240_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_240_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_240_1:RecordName(arg_240_1.leftNameTxt_.text)
				SetActive(arg_240_1.iconTrs_.gameObject, false)
				arg_240_1.callingController_:SetSelectedState("normal")

				local var_243_6 = arg_240_1:GetWordFromCfg(319801057)
				local var_243_7 = arg_240_1:FormatText(var_243_6.content)

				arg_240_1.text_.text = var_243_7

				LuaForUtil.ClearLinePrefixSymbol(arg_240_1.text_)

				local var_243_9 = 7 <= 0 and var_243_5 or var_243_5 * (utf8.len(var_243_7) / 7)

				if (7 <= 0 and var_243_5 or var_243_5 * (utf8.len(var_243_7) / 7)) > 0 and var_243_5 < var_243_9 then
					arg_240_1.talkMaxDuration = var_243_9

					if var_243_9 + var_243_4 > arg_240_1.duration_ then
						arg_240_1.duration_ = var_243_9 + var_243_4
					end
				end

				arg_240_1.text_.text = var_243_7
				arg_240_1.typewritter.percent = 0

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319801", "319801057", "story_v_out_319801.awb") ~= 0 then
					local var_243_10 = manager.audio:GetVoiceLength("story_v_out_319801", "319801057", "story_v_out_319801.awb") / 1000

					if var_243_10 + var_243_4 > arg_240_1.duration_ then
						arg_240_1.duration_ = var_243_10 + var_243_4
					end

					if var_243_6.prefab_name ~= "" and arg_240_1.actors_[var_243_6.prefab_name] ~= nil then
						local var_243_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_240_1.actors_[var_243_6.prefab_name].transform, "story_v_out_319801", "319801057", "story_v_out_319801.awb")

						arg_240_1:RecordAudio("319801057", var_243_11)
						arg_240_1:RecordAudio("319801057", var_243_11)
					else
						arg_240_1:AudioAction("play", "voice", "story_v_out_319801", "319801057", "story_v_out_319801.awb")
					end

					arg_240_1:RecordHistoryTalkVoice("story_v_out_319801", "319801057", "story_v_out_319801.awb")
				end

				arg_240_1:RecordContent(arg_240_1.text_.text)
			end

			local var_243_12 = math.max(var_243_5, arg_240_1.talkMaxDuration)

			if var_243_4 <= arg_240_1.time_ and arg_240_1.time_ < var_243_4 + var_243_12 then
				arg_240_1.typewritter.percent = (arg_240_1.time_ - var_243_4) / var_243_12

				arg_240_1.typewritter:SetDirty()
			end

			if arg_240_1.time_ >= var_243_4 + var_243_12 and arg_240_1.time_ < var_243_4 + var_243_12 + arg_243_0 then
				arg_240_1.typewritter.percent = 1

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(true)
			end
		end

		arg_240_1.nodeConfigList_ = {
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

		arg_240_1:InitPlayNodeList()
	end,
	Play319801058 = function(arg_244_0, arg_244_1)
		arg_244_1.time_ = 0
		arg_244_1.frameCnt_ = 0
		arg_244_1.state_ = "playing"
		arg_244_1.curTalkId_ = 319801058
		arg_244_1.duration_ = 5

		SetActive(arg_244_1.tipsGo_, false)

		function arg_244_1.onSingleLineFinish_()
			arg_244_1.onSingleLineUpdate_ = nil
			arg_244_1.onSingleLineFinish_ = nil
			arg_244_1.state_ = "waiting"
		end

		function arg_244_1.playNext_(arg_246_0)
			if arg_246_0 == 1 then
				arg_244_0:Play319801059(arg_244_1)
			end
		end

		function arg_244_1.onSingleLineUpdate_(arg_247_0)
			if 0 < arg_244_1.time_ and arg_244_1.time_ <= 0 + arg_247_0 and not isNil(arg_244_1.actors_["10066ui_story"]) and arg_244_1.var_.characterEffect10066ui_story == nil then
				arg_244_1.var_.characterEffect10066ui_story = arg_244_1.actors_["10066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_247_0 = 0.200000002980232

			if 0 <= arg_244_1.time_ and arg_244_1.time_ < 0 + var_247_0 and not isNil(arg_244_1.actors_["10066ui_story"]) then
				if arg_244_1.var_.characterEffect10066ui_story and not isNil(arg_244_1.actors_["10066ui_story"]) then
					arg_244_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_244_1.var_.characterEffect10066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_244_1.time_ - 0) / var_247_0)
				end
			end

			if arg_244_1.time_ >= 0 + var_247_0 and arg_244_1.time_ < 0 + var_247_0 + arg_247_0 and not isNil(arg_244_1.actors_["10066ui_story"]) and arg_244_1.var_.characterEffect10066ui_story then
				arg_244_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_244_1.var_.characterEffect10066ui_story.fillRatio = 0.5
			end

			local var_247_1 = 0
			local var_247_2 = 0.25

			if 0 < arg_244_1.time_ and arg_244_1.time_ <= var_247_1 + arg_247_0 then
				arg_244_1.talkMaxDuration = 0
				arg_244_1.dialogCg_.alpha = 1

				arg_244_1.dialog_:SetActive(true)
				SetActive(arg_244_1.leftNameGo_, true)

				arg_244_1.leftNameTxt_.text = arg_244_1:FormatText(StoryNameCfg[698].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_244_1.leftNameTxt_.transform)

				arg_244_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_244_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_244_1:RecordName(arg_244_1.leftNameTxt_.text)
				SetActive(arg_244_1.iconTrs_.gameObject, true)
				arg_244_1.iconController_:SetSelectedState("hero")

				arg_244_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10073")

				arg_244_1.callingController_:SetSelectedState("normal")

				arg_244_1.keyicon_.color = Color.New(1, 1, 1)
				arg_244_1.icon_.color = Color.New(1, 1, 1)

				local var_247_3 = arg_244_1:FormatText(arg_244_1:GetWordFromCfg(319801058).content)

				arg_244_1.text_.text = var_247_3

				LuaForUtil.ClearLinePrefixSymbol(arg_244_1.text_)

				local var_247_5 = 10 <= 0 and var_247_2 or var_247_2 * (utf8.len(var_247_3) / 10)

				if (10 <= 0 and var_247_2 or var_247_2 * (utf8.len(var_247_3) / 10)) > 0 and var_247_2 < var_247_5 then
					arg_244_1.talkMaxDuration = var_247_5

					if var_247_5 + var_247_1 > arg_244_1.duration_ then
						arg_244_1.duration_ = var_247_5 + var_247_1
					end
				end

				arg_244_1.text_.text = var_247_3
				arg_244_1.typewritter.percent = 0

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(false)
				arg_244_1:RecordContent(arg_244_1.text_.text)
			end

			local var_247_6 = math.max(var_247_2, arg_244_1.talkMaxDuration)

			if var_247_1 <= arg_244_1.time_ and arg_244_1.time_ < var_247_1 + var_247_6 then
				arg_244_1.typewritter.percent = (arg_244_1.time_ - var_247_1) / var_247_6

				arg_244_1.typewritter:SetDirty()
			end

			if arg_244_1.time_ >= var_247_1 + var_247_6 and arg_244_1.time_ < var_247_1 + var_247_6 + arg_247_0 then
				arg_244_1.typewritter.percent = 1

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(true)
			end
		end

		arg_244_1.nodeConfigList_ = {}

		arg_244_1:InitPlayNodeList()
	end,
	Play319801059 = function(arg_248_0, arg_248_1)
		arg_248_1.time_ = 0
		arg_248_1.frameCnt_ = 0
		arg_248_1.state_ = "playing"
		arg_248_1.curTalkId_ = 319801059
		arg_248_1.duration_ = 5

		SetActive(arg_248_1.tipsGo_, false)

		function arg_248_1.onSingleLineFinish_()
			arg_248_1.onSingleLineUpdate_ = nil
			arg_248_1.onSingleLineFinish_ = nil
			arg_248_1.state_ = "waiting"
		end

		function arg_248_1.playNext_(arg_250_0)
			if arg_250_0 == 1 then
				arg_248_0:Play319801060(arg_248_1)
			end
		end

		function arg_248_1.onSingleLineUpdate_(arg_251_0)
			if 0 < arg_248_1.time_ and arg_248_1.time_ <= 0 + arg_251_0 then
				arg_248_1.var_.moveOldPos10066ui_story = arg_248_1.actors_["10066ui_story"].transform.localPosition
			end

			local var_251_0 = 0.001

			if 0 <= arg_248_1.time_ and arg_248_1.time_ < 0 + var_251_0 then
				arg_248_1.actors_["10066ui_story"].transform.localPosition = Vector3.Lerp(arg_248_1.var_.moveOldPos10066ui_story, Vector3.New(0, 100, 0), (arg_248_1.time_ - 0) / var_251_0)
				arg_248_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_248_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_248_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_248_1.actors_["10066ui_story"].transform.position).z)
				arg_248_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_248_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_248_1.actors_["10066ui_story"].transform.localEulerAngles = arg_248_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			if arg_248_1.time_ >= 0 + var_251_0 and arg_248_1.time_ < 0 + var_251_0 + arg_251_0 then
				arg_248_1.actors_["10066ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_248_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_248_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_248_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_248_1.actors_["10066ui_story"].transform.position).z)
				arg_248_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_248_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_248_1.actors_["10066ui_story"].transform.localEulerAngles = arg_248_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			local var_251_1 = 0
			local var_251_2 = 1

			if 0 < arg_248_1.time_ and arg_248_1.time_ <= var_251_1 + arg_251_0 then
				arg_248_1.talkMaxDuration = 0
				arg_248_1.dialogCg_.alpha = 1

				arg_248_1.dialog_:SetActive(true)
				SetActive(arg_248_1.leftNameGo_, false)

				arg_248_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_248_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_248_1:RecordName(arg_248_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_248_1.iconTrs_.gameObject, false)
				arg_248_1.callingController_:SetSelectedState("normal")

				local var_251_3 = arg_248_1:FormatText(arg_248_1:GetWordFromCfg(319801059).content)

				arg_248_1.text_.text = var_251_3

				LuaForUtil.ClearLinePrefixSymbol(arg_248_1.text_)

				local var_251_5 = 40 <= 0 and var_251_2 or var_251_2 * (utf8.len(var_251_3) / 40)

				if (40 <= 0 and var_251_2 or var_251_2 * (utf8.len(var_251_3) / 40)) > 0 and var_251_2 < var_251_5 then
					arg_248_1.talkMaxDuration = var_251_5

					if var_251_5 + var_251_1 > arg_248_1.duration_ then
						arg_248_1.duration_ = var_251_5 + var_251_1
					end
				end

				arg_248_1.text_.text = var_251_3
				arg_248_1.typewritter.percent = 0

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(false)
				arg_248_1:RecordContent(arg_248_1.text_.text)
			end

			local var_251_6 = math.max(var_251_2, arg_248_1.talkMaxDuration)

			if var_251_1 <= arg_248_1.time_ and arg_248_1.time_ < var_251_1 + var_251_6 then
				arg_248_1.typewritter.percent = (arg_248_1.time_ - var_251_1) / var_251_6

				arg_248_1.typewritter:SetDirty()
			end

			if arg_248_1.time_ >= var_251_1 + var_251_6 and arg_248_1.time_ < var_251_1 + var_251_6 + arg_251_0 then
				arg_248_1.typewritter.percent = 1

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(true)
			end
		end

		arg_248_1.nodeConfigList_ = {
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

		arg_248_1:InitPlayNodeList()
	end,
	Play319801060 = function(arg_252_0, arg_252_1)
		arg_252_1.time_ = 0
		arg_252_1.frameCnt_ = 0
		arg_252_1.state_ = "playing"
		arg_252_1.curTalkId_ = 319801060
		arg_252_1.duration_ = 5

		SetActive(arg_252_1.tipsGo_, false)

		function arg_252_1.onSingleLineFinish_()
			arg_252_1.onSingleLineUpdate_ = nil
			arg_252_1.onSingleLineFinish_ = nil
			arg_252_1.state_ = "waiting"
		end

		function arg_252_1.playNext_(arg_254_0)
			if arg_254_0 == 1 then
				arg_252_0:Play319801061(arg_252_1)
			end
		end

		function arg_252_1.onSingleLineUpdate_(arg_255_0)
			local var_255_0 = 0.225

			if 0 < arg_252_1.time_ and arg_252_1.time_ <= 0 + arg_255_0 then
				arg_252_1.talkMaxDuration = 0
				arg_252_1.dialogCg_.alpha = 1

				arg_252_1.dialog_:SetActive(true)
				SetActive(arg_252_1.leftNameGo_, true)

				arg_252_1.leftNameTxt_.text = arg_252_1:FormatText(StoryNameCfg[698].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_252_1.leftNameTxt_.transform)

				arg_252_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_252_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_252_1:RecordName(arg_252_1.leftNameTxt_.text)
				SetActive(arg_252_1.iconTrs_.gameObject, true)
				arg_252_1.iconController_:SetSelectedState("hero")

				arg_252_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10073")

				arg_252_1.callingController_:SetSelectedState("normal")

				arg_252_1.keyicon_.color = Color.New(1, 1, 1)
				arg_252_1.icon_.color = Color.New(1, 1, 1)

				local var_255_1 = arg_252_1:FormatText(arg_252_1:GetWordFromCfg(319801060).content)

				arg_252_1.text_.text = var_255_1

				LuaForUtil.ClearLinePrefixSymbol(arg_252_1.text_)

				local var_255_3 = 9 <= 0 and var_255_0 or var_255_0 * (utf8.len(var_255_1) / 9)

				if (9 <= 0 and var_255_0 or var_255_0 * (utf8.len(var_255_1) / 9)) > 0 and var_255_0 < var_255_3 then
					arg_252_1.talkMaxDuration = var_255_3

					if var_255_3 + 0 > arg_252_1.duration_ then
						arg_252_1.duration_ = var_255_3 + 0
					end
				end

				arg_252_1.text_.text = var_255_1
				arg_252_1.typewritter.percent = 0

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(false)
				arg_252_1:RecordContent(arg_252_1.text_.text)
			end

			local var_255_4 = math.max(var_255_0, arg_252_1.talkMaxDuration)

			if 0 <= arg_252_1.time_ and arg_252_1.time_ < 0 + var_255_4 then
				arg_252_1.typewritter.percent = (arg_252_1.time_ - 0) / var_255_4

				arg_252_1.typewritter:SetDirty()
			end

			if arg_252_1.time_ >= 0 + var_255_4 and arg_252_1.time_ < 0 + var_255_4 + arg_255_0 then
				arg_252_1.typewritter.percent = 1

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(true)
			end
		end

		arg_252_1.nodeConfigList_ = {}

		arg_252_1:InitPlayNodeList()
	end,
	Play319801061 = function(arg_256_0, arg_256_1)
		arg_256_1.time_ = 0
		arg_256_1.frameCnt_ = 0
		arg_256_1.state_ = "playing"
		arg_256_1.curTalkId_ = 319801061
		arg_256_1.duration_ = 5.9

		SetActive(arg_256_1.tipsGo_, false)

		function arg_256_1.onSingleLineFinish_()
			arg_256_1.onSingleLineUpdate_ = nil
			arg_256_1.onSingleLineFinish_ = nil
			arg_256_1.state_ = "waiting"
		end

		function arg_256_1.playNext_(arg_258_0)
			if arg_258_0 == 1 then
				arg_256_0:Play319801062(arg_256_1)
			end
		end

		function arg_256_1.onSingleLineUpdate_(arg_259_0)
			if 0 < arg_256_1.time_ and arg_256_1.time_ <= 0 + arg_259_0 then
				arg_256_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_259_0 = 1

			if 0 <= arg_256_1.time_ and arg_256_1.time_ < 0 + var_259_0 then
				local var_259_1, var_259_2 = math.modf((arg_256_1.time_ - 0) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_259_2 * 0.13, var_259_2 * 0.13, var_259_2 * 0.13) + arg_256_1.var_.shakeOldPos
			end

			if arg_256_1.time_ >= 0 + var_259_0 and arg_256_1.time_ < 0 + var_259_0 + arg_259_0 then
				manager.ui.mainCamera.transform.localPosition = arg_256_1.var_.shakeOldPos
			end

			if arg_256_1.frameCnt_ <= 1 then
				arg_256_1.dialog_:SetActive(false)
			end

			local var_259_3 = 0.9
			local var_259_4 = 0.825

			if 0.9 < arg_256_1.time_ and arg_256_1.time_ <= var_259_3 + arg_259_0 then
				arg_256_1.talkMaxDuration = 0

				arg_256_1.dialog_:SetActive(true)

				arg_256_1.dialogCg_.alpha = 0

				local var_259_5 = LeanTween.value(arg_256_1.dialog_, 0, 1, 0.3)

				var_259_5:setOnUpdate(LuaHelper.FloatAction(function(arg_260_0)
					arg_256_1.dialogCg_.alpha = arg_260_0
				end))
				var_259_5:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_256_1.dialog_)
					var_259_5:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_256_1.duration_ = arg_256_1.duration_ + 0.3

				SetActive(arg_256_1.leftNameGo_, false)

				arg_256_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_256_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_256_1:RecordName(arg_256_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_256_1.iconTrs_.gameObject, false)
				arg_256_1.callingController_:SetSelectedState("normal")

				local var_259_6 = arg_256_1:FormatText(arg_256_1:GetWordFromCfg(319801061).content)

				arg_256_1.text_.text = var_259_6

				LuaForUtil.ClearLinePrefixSymbol(arg_256_1.text_)

				local var_259_8 = 33 <= 0 and var_259_4 or var_259_4 * (utf8.len(var_259_6) / 33)

				if (33 <= 0 and var_259_4 or var_259_4 * (utf8.len(var_259_6) / 33)) > 0 and var_259_4 < var_259_8 then
					arg_256_1.talkMaxDuration = var_259_8
					var_259_3 = var_259_3 + 0.3

					if var_259_8 + var_259_3 > arg_256_1.duration_ then
						arg_256_1.duration_ = var_259_8 + var_259_3
					end
				end

				arg_256_1.text_.text = var_259_6
				arg_256_1.typewritter.percent = 0

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(false)
				arg_256_1:RecordContent(arg_256_1.text_.text)
			end

			local var_259_9 = var_259_3 + 0.3
			local var_259_10 = math.max(var_259_4, arg_256_1.talkMaxDuration)

			if var_259_3 + 0.3 <= arg_256_1.time_ and arg_256_1.time_ < var_259_9 + var_259_10 then
				arg_256_1.typewritter.percent = (arg_256_1.time_ - var_259_9) / var_259_10

				arg_256_1.typewritter:SetDirty()
			end

			if arg_256_1.time_ >= var_259_9 + var_259_10 and arg_256_1.time_ < var_259_9 + var_259_10 + arg_259_0 then
				arg_256_1.typewritter.percent = 1

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(true)
			end
		end

		arg_256_1.nodeConfigList_ = {}

		arg_256_1:InitPlayNodeList()
	end,
	Play319801062 = function(arg_262_0, arg_262_1)
		arg_262_1.time_ = 0
		arg_262_1.frameCnt_ = 0
		arg_262_1.state_ = "playing"
		arg_262_1.curTalkId_ = 319801062
		arg_262_1.duration_ = 5.73

		SetActive(arg_262_1.tipsGo_, false)

		function arg_262_1.onSingleLineFinish_()
			arg_262_1.onSingleLineUpdate_ = nil
			arg_262_1.onSingleLineFinish_ = nil
			arg_262_1.state_ = "waiting"
		end

		function arg_262_1.playNext_(arg_264_0)
			if arg_264_0 == 1 then
				arg_262_0:Play319801063(arg_262_1)
			end
		end

		function arg_262_1.onSingleLineUpdate_(arg_265_0)
			if 0 < arg_262_1.time_ and arg_262_1.time_ <= 0 + arg_265_0 then
				local var_265_0 = arg_262_1.var_.effect111

				if not arg_262_1.var_.effect111 then
					var_265_0 = Object.Instantiate(Asset.Load("Effect/Scene/fx_ripple"), manager.ui.mainCamera.transform)
					var_265_0.name = "111"
					arg_262_1.var_.effect111 = var_265_0
				else
					var_265_0.transform:SetParent(manager.ui.mainCamera.transform)
				end

				var_265_0.transform.localPosition = Vector3.New(0, 0, 0.44)
				var_265_0.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if arg_262_1.frameCnt_ <= 1 then
				arg_262_1.dialog_:SetActive(false)
			end

			local var_265_2 = 0.733333333333333
			local var_265_3 = 1.125

			if 0.733333333333333 < arg_262_1.time_ and arg_262_1.time_ <= var_265_2 + arg_265_0 then
				arg_262_1.talkMaxDuration = 0

				arg_262_1.dialog_:SetActive(true)

				arg_262_1.dialogCg_.alpha = 0

				local var_265_4 = LeanTween.value(arg_262_1.dialog_, 0, 1, 0.3)

				var_265_4:setOnUpdate(LuaHelper.FloatAction(function(arg_266_0)
					arg_262_1.dialogCg_.alpha = arg_266_0
				end))
				var_265_4:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_262_1.dialog_)
					var_265_4:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_262_1.duration_ = arg_262_1.duration_ + 0.3

				SetActive(arg_262_1.leftNameGo_, false)

				arg_262_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_262_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_262_1:RecordName(arg_262_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_262_1.iconTrs_.gameObject, false)
				arg_262_1.callingController_:SetSelectedState("normal")

				local var_265_5 = arg_262_1:FormatText(arg_262_1:GetWordFromCfg(319801062).content)

				arg_262_1.text_.text = var_265_5

				LuaForUtil.ClearLinePrefixSymbol(arg_262_1.text_)

				local var_265_7 = 45 <= 0 and var_265_3 or var_265_3 * (utf8.len(var_265_5) / 45)

				if (45 <= 0 and var_265_3 or var_265_3 * (utf8.len(var_265_5) / 45)) > 0 and var_265_3 < var_265_7 then
					arg_262_1.talkMaxDuration = var_265_7
					var_265_2 = var_265_2 + 0.3

					if var_265_7 + var_265_2 > arg_262_1.duration_ then
						arg_262_1.duration_ = var_265_7 + var_265_2
					end
				end

				arg_262_1.text_.text = var_265_5
				arg_262_1.typewritter.percent = 0

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(false)
				arg_262_1:RecordContent(arg_262_1.text_.text)
			end

			local var_265_8 = var_265_2 + 0.3
			local var_265_9 = math.max(var_265_3, arg_262_1.talkMaxDuration)

			if var_265_2 + 0.3 <= arg_262_1.time_ and arg_262_1.time_ < var_265_8 + var_265_9 then
				arg_262_1.typewritter.percent = (arg_262_1.time_ - var_265_8) / var_265_9

				arg_262_1.typewritter:SetDirty()
			end

			if arg_262_1.time_ >= var_265_8 + var_265_9 and arg_262_1.time_ < var_265_8 + var_265_9 + arg_265_0 then
				arg_262_1.typewritter.percent = 1

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(true)
			end
		end

		arg_262_1.nodeConfigList_ = {}

		arg_262_1:InitPlayNodeList()
	end,
	Play319801063 = function(arg_268_0, arg_268_1)
		arg_268_1.time_ = 0
		arg_268_1.frameCnt_ = 0
		arg_268_1.state_ = "playing"
		arg_268_1.curTalkId_ = 319801063
		arg_268_1.duration_ = 2.6

		local var_268_0 = {
			zh = 2.433,
			ja = 2.6
		}
		local var_268_1 = manager.audio:GetLocalizationFlag()

		if var_268_0[var_268_1] ~= nil then
			arg_268_1.duration_ = var_268_0[var_268_1]
		end

		SetActive(arg_268_1.tipsGo_, false)

		function arg_268_1.onSingleLineFinish_()
			arg_268_1.onSingleLineUpdate_ = nil
			arg_268_1.onSingleLineFinish_ = nil
			arg_268_1.state_ = "waiting"
		end

		function arg_268_1.playNext_(arg_270_0)
			if arg_270_0 == 1 then
				arg_268_0:Play319801064(arg_268_1)
			end
		end

		function arg_268_1.onSingleLineUpdate_(arg_271_0)
			if 0.2 < arg_268_1.time_ and arg_268_1.time_ <= 0.2 + arg_271_0 then
				if arg_268_1.var_.effect111 then
					Object.Destroy(arg_268_1.var_.effect111)

					arg_268_1.var_.effect111 = nil
				end
			end

			local var_271_1 = 0

			if 0 < arg_268_1.time_ and arg_268_1.time_ <= var_271_1 + arg_271_0 then
				arg_268_1.mask_.enabled = true
				arg_268_1.mask_.raycastTarget = true

				arg_268_1:SetGaussion(false)
			end

			local var_271_2 = 0.333333333333333

			if var_271_1 <= arg_268_1.time_ and arg_268_1.time_ < var_271_1 + var_271_2 then
				local var_271_3 = Color.New(1, 1, 1)

				var_271_3.a = Mathf.Lerp(0, 1, (arg_268_1.time_ - var_271_1) / var_271_2)
				arg_268_1.mask_.color = var_271_3
			end

			if arg_268_1.time_ >= var_271_1 + var_271_2 and arg_268_1.time_ < var_271_1 + var_271_2 + arg_271_0 then
				local var_271_4 = Color.New(1, 1, 1)

				var_271_4.a = 1
				arg_268_1.mask_.color = var_271_4
			end

			local var_271_5 = 0.333333333333333

			if 0.333333333333333 < arg_268_1.time_ and arg_268_1.time_ <= var_271_5 + arg_271_0 then
				arg_268_1.mask_.enabled = true
				arg_268_1.mask_.raycastTarget = true

				arg_268_1:SetGaussion(false)
			end

			local var_271_6 = 0.666666666666667

			if var_271_5 <= arg_268_1.time_ and arg_268_1.time_ < var_271_5 + var_271_6 then
				local var_271_7 = Color.New(1, 1, 1)

				var_271_7.a = Mathf.Lerp(1, 0, (arg_268_1.time_ - var_271_5) / var_271_6)
				arg_268_1.mask_.color = var_271_7
			end

			if arg_268_1.time_ >= var_271_5 + var_271_6 and arg_268_1.time_ < var_271_5 + var_271_6 + arg_271_0 then
				local var_271_8 = Color.New(1, 1, 1)

				arg_268_1.mask_.enabled = false
				var_271_8.a = 0
				arg_268_1.mask_.color = var_271_8
			end

			if 0.333333333333333 < arg_268_1.time_ and arg_268_1.time_ <= 0.333333333333333 + arg_271_0 then
				local var_271_9 = arg_268_1.bgs_.ST72a

				arg_268_1.bgs_.ST72a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_271_9.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_271_10 = var_271_9:GetComponent("SpriteRenderer")

				if var_271_10 and var_271_10.sprite then
					local var_271_11 = 2 * (var_271_9.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_271_9.transform.localScale = Vector3.New(var_271_11 / var_271_10.sprite.bounds.size.y < var_271_11 * manager.ui.mainCameraCom_.aspect / var_271_10.sprite.bounds.size.x and var_271_11 * manager.ui.mainCameraCom_.aspect / var_271_10.sprite.bounds.size.x or var_271_11 / var_271_10.sprite.bounds.size.y, var_271_11 / var_271_10.sprite.bounds.size.y < var_271_11 * manager.ui.mainCameraCom_.aspect / var_271_10.sprite.bounds.size.x and var_271_11 * manager.ui.mainCameraCom_.aspect / var_271_10.sprite.bounds.size.x or var_271_11 / var_271_10.sprite.bounds.size.y, 0)
				end

				for iter_271_0, iter_271_1 in pairs(arg_268_1.bgs_) do
					if iter_271_0 ~= "ST72a" then
						iter_271_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if arg_268_1.frameCnt_ <= 1 then
				arg_268_1.dialog_:SetActive(false)
			end

			local var_271_12 = 1
			local var_271_13 = 0.125

			if 1 < arg_268_1.time_ and arg_268_1.time_ <= var_271_12 + arg_271_0 then
				arg_268_1.talkMaxDuration = 0

				arg_268_1.dialog_:SetActive(true)

				arg_268_1.dialogCg_.alpha = 0

				local var_271_14 = LeanTween.value(arg_268_1.dialog_, 0, 1, 0.3)

				var_271_14:setOnUpdate(LuaHelper.FloatAction(function(arg_272_0)
					arg_268_1.dialogCg_.alpha = arg_272_0
				end))
				var_271_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_268_1.dialog_)
					var_271_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_268_1.duration_ = arg_268_1.duration_ + 0.3

				SetActive(arg_268_1.leftNameGo_, true)

				arg_268_1.leftNameTxt_.text = arg_268_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_268_1.leftNameTxt_.transform)

				arg_268_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_268_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_268_1:RecordName(arg_268_1.leftNameTxt_.text)
				SetActive(arg_268_1.iconTrs_.gameObject, true)
				arg_268_1.iconController_:SetSelectedState("hero")

				arg_268_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1084")

				arg_268_1.callingController_:SetSelectedState("normal")

				arg_268_1.keyicon_.color = Color.New(1, 1, 1)
				arg_268_1.icon_.color = Color.New(1, 1, 1)

				local var_271_15 = arg_268_1:GetWordFromCfg(319801063)
				local var_271_16 = arg_268_1:FormatText(var_271_15.content)

				arg_268_1.text_.text = var_271_16

				LuaForUtil.ClearLinePrefixSymbol(arg_268_1.text_)

				local var_271_18 = 5 <= 0 and var_271_13 or var_271_13 * (utf8.len(var_271_16) / 5)

				if (5 <= 0 and var_271_13 or var_271_13 * (utf8.len(var_271_16) / 5)) > 0 and var_271_13 < var_271_18 then
					arg_268_1.talkMaxDuration = var_271_18
					var_271_12 = var_271_12 + 0.3

					if var_271_18 + var_271_12 > arg_268_1.duration_ then
						arg_268_1.duration_ = var_271_18 + var_271_12
					end
				end

				arg_268_1.text_.text = var_271_16
				arg_268_1.typewritter.percent = 0

				arg_268_1.typewritter:SetDirty()
				arg_268_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319801", "319801063", "story_v_out_319801.awb") ~= 0 then
					local var_271_19 = manager.audio:GetVoiceLength("story_v_out_319801", "319801063", "story_v_out_319801.awb") / 1000

					if var_271_19 + var_271_12 > arg_268_1.duration_ then
						arg_268_1.duration_ = var_271_19 + var_271_12
					end

					if var_271_15.prefab_name ~= "" and arg_268_1.actors_[var_271_15.prefab_name] ~= nil then
						local var_271_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_268_1.actors_[var_271_15.prefab_name].transform, "story_v_out_319801", "319801063", "story_v_out_319801.awb")

						arg_268_1:RecordAudio("319801063", var_271_20)
						arg_268_1:RecordAudio("319801063", var_271_20)
					else
						arg_268_1:AudioAction("play", "voice", "story_v_out_319801", "319801063", "story_v_out_319801.awb")
					end

					arg_268_1:RecordHistoryTalkVoice("story_v_out_319801", "319801063", "story_v_out_319801.awb")
				end

				arg_268_1:RecordContent(arg_268_1.text_.text)
			end

			local var_271_21 = var_271_12 + 0.3
			local var_271_22 = math.max(var_271_13, arg_268_1.talkMaxDuration)

			if var_271_12 + 0.3 <= arg_268_1.time_ and arg_268_1.time_ < var_271_21 + var_271_22 then
				arg_268_1.typewritter.percent = (arg_268_1.time_ - var_271_21) / var_271_22

				arg_268_1.typewritter:SetDirty()
			end

			if arg_268_1.time_ >= var_271_21 + var_271_22 and arg_268_1.time_ < var_271_21 + var_271_22 + arg_271_0 then
				arg_268_1.typewritter.percent = 1

				arg_268_1.typewritter:SetDirty()
				arg_268_1:ShowNextGo(true)
			end
		end

		arg_268_1.nodeConfigList_ = {}

		arg_268_1:InitPlayNodeList()
	end,
	Play319801064 = function(arg_274_0, arg_274_1)
		arg_274_1.time_ = 0
		arg_274_1.frameCnt_ = 0
		arg_274_1.state_ = "playing"
		arg_274_1.curTalkId_ = 319801064
		arg_274_1.duration_ = 5

		SetActive(arg_274_1.tipsGo_, false)

		function arg_274_1.onSingleLineFinish_()
			arg_274_1.onSingleLineUpdate_ = nil
			arg_274_1.onSingleLineFinish_ = nil
			arg_274_1.state_ = "waiting"
		end

		function arg_274_1.playNext_(arg_276_0)
			if arg_276_0 == 1 then
				arg_274_0:Play319801065(arg_274_1)
			end
		end

		function arg_274_1.onSingleLineUpdate_(arg_277_0)
			if 0 < arg_274_1.time_ and arg_274_1.time_ <= 0 + arg_277_0 then
				arg_274_1:AudioAction("play", "effect", "se_story_130", "se_story_130_shot", "")
			end

			local var_277_1 = 0
			local var_277_2 = 1.4

			if 0 < arg_274_1.time_ and arg_274_1.time_ <= var_277_1 + arg_277_0 then
				arg_274_1.talkMaxDuration = 0
				arg_274_1.dialogCg_.alpha = 1

				arg_274_1.dialog_:SetActive(true)
				SetActive(arg_274_1.leftNameGo_, false)

				arg_274_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_274_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_274_1:RecordName(arg_274_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_274_1.iconTrs_.gameObject, false)
				arg_274_1.callingController_:SetSelectedState("normal")

				local var_277_3 = arg_274_1:FormatText(arg_274_1:GetWordFromCfg(319801064).content)

				arg_274_1.text_.text = var_277_3

				LuaForUtil.ClearLinePrefixSymbol(arg_274_1.text_)

				local var_277_5 = 56 <= 0 and var_277_2 or var_277_2 * (utf8.len(var_277_3) / 56)

				if (56 <= 0 and var_277_2 or var_277_2 * (utf8.len(var_277_3) / 56)) > 0 and var_277_2 < var_277_5 then
					arg_274_1.talkMaxDuration = var_277_5

					if var_277_5 + var_277_1 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_5 + var_277_1
					end
				end

				arg_274_1.text_.text = var_277_3
				arg_274_1.typewritter.percent = 0

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(false)
				arg_274_1:RecordContent(arg_274_1.text_.text)
			end

			local var_277_6 = math.max(var_277_2, arg_274_1.talkMaxDuration)

			if var_277_1 <= arg_274_1.time_ and arg_274_1.time_ < var_277_1 + var_277_6 then
				arg_274_1.typewritter.percent = (arg_274_1.time_ - var_277_1) / var_277_6

				arg_274_1.typewritter:SetDirty()
			end

			if arg_274_1.time_ >= var_277_1 + var_277_6 and arg_274_1.time_ < var_277_1 + var_277_6 + arg_277_0 then
				arg_274_1.typewritter.percent = 1

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(true)
			end
		end

		arg_274_1.nodeConfigList_ = {}

		arg_274_1:InitPlayNodeList()
	end,
	Play319801065 = function(arg_278_0, arg_278_1)
		arg_278_1.time_ = 0
		arg_278_1.frameCnt_ = 0
		arg_278_1.state_ = "playing"
		arg_278_1.curTalkId_ = 319801065
		arg_278_1.duration_ = 5.67

		SetActive(arg_278_1.tipsGo_, false)

		function arg_278_1.onSingleLineFinish_()
			arg_278_1.onSingleLineUpdate_ = nil
			arg_278_1.onSingleLineFinish_ = nil
			arg_278_1.state_ = "waiting"
		end

		function arg_278_1.playNext_(arg_280_0)
			if arg_280_0 == 1 then
				arg_278_0:Play319801066(arg_278_1)
			end
		end

		function arg_278_1.onSingleLineUpdate_(arg_281_0)
			if 0 < arg_278_1.time_ and arg_278_1.time_ <= 0 + arg_281_0 then
				local var_281_0 = arg_278_1.var_.effect555

				if not arg_278_1.var_.effect555 then
					var_281_0 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_error"), manager.ui.mainCamera.transform)
					var_281_0.name = "555"
					arg_278_1.var_.effect555 = var_281_0
				else
					var_281_0.transform:SetParent(manager.ui.mainCamera.transform)
				end

				var_281_0.transform.localPosition = Vector3.New(0, 0, 0)
				var_281_0.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if arg_278_1.frameCnt_ <= 1 then
				arg_278_1.dialog_:SetActive(false)
			end

			local var_281_2 = 0.666666666666667
			local var_281_3 = 0.775

			if 0.666666666666667 < arg_278_1.time_ and arg_278_1.time_ <= var_281_2 + arg_281_0 then
				arg_278_1.talkMaxDuration = 0

				arg_278_1.dialog_:SetActive(true)

				arg_278_1.dialogCg_.alpha = 0

				local var_281_4 = LeanTween.value(arg_278_1.dialog_, 0, 1, 0.3)

				var_281_4:setOnUpdate(LuaHelper.FloatAction(function(arg_282_0)
					arg_278_1.dialogCg_.alpha = arg_282_0
				end))
				var_281_4:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_278_1.dialog_)
					var_281_4:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_278_1.duration_ = arg_278_1.duration_ + 0.3

				SetActive(arg_278_1.leftNameGo_, false)

				arg_278_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_278_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_278_1:RecordName(arg_278_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_278_1.iconTrs_.gameObject, false)
				arg_278_1.callingController_:SetSelectedState("normal")

				local var_281_5 = arg_278_1:FormatText(arg_278_1:GetWordFromCfg(319801065).content)

				arg_278_1.text_.text = var_281_5

				LuaForUtil.ClearLinePrefixSymbol(arg_278_1.text_)

				local var_281_7 = 31 <= 0 and var_281_3 or var_281_3 * (utf8.len(var_281_5) / 31)

				if (31 <= 0 and var_281_3 or var_281_3 * (utf8.len(var_281_5) / 31)) > 0 and var_281_3 < var_281_7 then
					arg_278_1.talkMaxDuration = var_281_7
					var_281_2 = var_281_2 + 0.3

					if var_281_7 + var_281_2 > arg_278_1.duration_ then
						arg_278_1.duration_ = var_281_7 + var_281_2
					end
				end

				arg_278_1.text_.text = var_281_5
				arg_278_1.typewritter.percent = 0

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(false)
				arg_278_1:RecordContent(arg_278_1.text_.text)
			end

			local var_281_8 = var_281_2 + 0.3
			local var_281_9 = math.max(var_281_3, arg_278_1.talkMaxDuration)

			if var_281_2 + 0.3 <= arg_278_1.time_ and arg_278_1.time_ < var_281_8 + var_281_9 then
				arg_278_1.typewritter.percent = (arg_278_1.time_ - var_281_8) / var_281_9

				arg_278_1.typewritter:SetDirty()
			end

			if arg_278_1.time_ >= var_281_8 + var_281_9 and arg_278_1.time_ < var_281_8 + var_281_9 + arg_281_0 then
				arg_278_1.typewritter.percent = 1

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(true)
			end
		end

		arg_278_1.nodeConfigList_ = {}

		arg_278_1:InitPlayNodeList()
	end,
	Play319801066 = function(arg_284_0, arg_284_1)
		arg_284_1.time_ = 0
		arg_284_1.frameCnt_ = 0
		arg_284_1.state_ = "playing"
		arg_284_1.curTalkId_ = 319801066
		arg_284_1.duration_ = 5

		SetActive(arg_284_1.tipsGo_, false)

		function arg_284_1.onSingleLineFinish_()
			arg_284_1.onSingleLineUpdate_ = nil
			arg_284_1.onSingleLineFinish_ = nil
			arg_284_1.state_ = "waiting"
		end

		function arg_284_1.playNext_(arg_286_0)
			if arg_286_0 == 1 then
				arg_284_0:Play319801067(arg_284_1)
			end
		end

		function arg_284_1.onSingleLineUpdate_(arg_287_0)
			if 0 < arg_284_1.time_ and arg_284_1.time_ <= 0 + arg_287_0 then
				if arg_284_1.var_.effect555 then
					Object.Destroy(arg_284_1.var_.effect555)

					arg_284_1.var_.effect555 = nil
				end
			end

			local var_287_1 = 0
			local var_287_2 = 1.2

			if 0 < arg_284_1.time_ and arg_284_1.time_ <= var_287_1 + arg_287_0 then
				arg_284_1.talkMaxDuration = 0
				arg_284_1.dialogCg_.alpha = 1

				arg_284_1.dialog_:SetActive(true)
				SetActive(arg_284_1.leftNameGo_, false)

				arg_284_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_284_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_284_1:RecordName(arg_284_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_284_1.iconTrs_.gameObject, false)
				arg_284_1.callingController_:SetSelectedState("normal")

				local var_287_3 = arg_284_1:FormatText(arg_284_1:GetWordFromCfg(319801066).content)

				arg_284_1.text_.text = var_287_3

				LuaForUtil.ClearLinePrefixSymbol(arg_284_1.text_)

				local var_287_5 = 48 <= 0 and var_287_2 or var_287_2 * (utf8.len(var_287_3) / 48)

				if (48 <= 0 and var_287_2 or var_287_2 * (utf8.len(var_287_3) / 48)) > 0 and var_287_2 < var_287_5 then
					arg_284_1.talkMaxDuration = var_287_5

					if var_287_5 + var_287_1 > arg_284_1.duration_ then
						arg_284_1.duration_ = var_287_5 + var_287_1
					end
				end

				arg_284_1.text_.text = var_287_3
				arg_284_1.typewritter.percent = 0

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(false)
				arg_284_1:RecordContent(arg_284_1.text_.text)
			end

			local var_287_6 = math.max(var_287_2, arg_284_1.talkMaxDuration)

			if var_287_1 <= arg_284_1.time_ and arg_284_1.time_ < var_287_1 + var_287_6 then
				arg_284_1.typewritter.percent = (arg_284_1.time_ - var_287_1) / var_287_6

				arg_284_1.typewritter:SetDirty()
			end

			if arg_284_1.time_ >= var_287_1 + var_287_6 and arg_284_1.time_ < var_287_1 + var_287_6 + arg_287_0 then
				arg_284_1.typewritter.percent = 1

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(true)
			end
		end

		arg_284_1.nodeConfigList_ = {}

		arg_284_1:InitPlayNodeList()
	end,
	Play319801067 = function(arg_288_0, arg_288_1)
		arg_288_1.time_ = 0
		arg_288_1.frameCnt_ = 0
		arg_288_1.state_ = "playing"
		arg_288_1.curTalkId_ = 319801067
		arg_288_1.duration_ = 6

		SetActive(arg_288_1.tipsGo_, false)

		function arg_288_1.onSingleLineFinish_()
			arg_288_1.onSingleLineUpdate_ = nil
			arg_288_1.onSingleLineFinish_ = nil
			arg_288_1.state_ = "waiting"
		end

		function arg_288_1.playNext_(arg_290_0)
			if arg_290_0 == 1 then
				arg_288_0:Play319801068(arg_288_1)
			end
		end

		function arg_288_1.onSingleLineUpdate_(arg_291_0)
			if 0 < arg_288_1.time_ and arg_288_1.time_ <= 0 + arg_291_0 then
				arg_288_1.mask_.enabled = true
				arg_288_1.mask_.raycastTarget = false

				arg_288_1:SetGaussion(false)
			end

			local var_291_0 = 0.866666666666667

			if 0 <= arg_288_1.time_ and arg_288_1.time_ < 0 + var_291_0 then
				local var_291_1 = Color.New(1, 1, 1)

				var_291_1.a = Mathf.Lerp(1, 0, (arg_288_1.time_ - 0) / var_291_0)
				arg_288_1.mask_.color = var_291_1
			end

			if arg_288_1.time_ >= 0 + var_291_0 and arg_288_1.time_ < 0 + var_291_0 + arg_291_0 then
				local var_291_2 = Color.New(1, 1, 1)

				arg_288_1.mask_.enabled = false
				var_291_2.a = 0
				arg_288_1.mask_.color = var_291_2
			end

			if arg_288_1.frameCnt_ <= 1 then
				arg_288_1.dialog_:SetActive(false)
			end

			local var_291_3 = 1
			local var_291_4 = 1.025

			if 1 < arg_288_1.time_ and arg_288_1.time_ <= var_291_3 + arg_291_0 then
				arg_288_1.talkMaxDuration = 0

				arg_288_1.dialog_:SetActive(true)

				arg_288_1.dialogCg_.alpha = 0

				local var_291_5 = LeanTween.value(arg_288_1.dialog_, 0, 1, 0.3)

				var_291_5:setOnUpdate(LuaHelper.FloatAction(function(arg_292_0)
					arg_288_1.dialogCg_.alpha = arg_292_0
				end))
				var_291_5:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_288_1.dialog_)
					var_291_5:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_288_1.duration_ = arg_288_1.duration_ + 0.3

				SetActive(arg_288_1.leftNameGo_, false)

				arg_288_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_288_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_288_1:RecordName(arg_288_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_288_1.iconTrs_.gameObject, false)
				arg_288_1.callingController_:SetSelectedState("normal")

				local var_291_6 = arg_288_1:FormatText(arg_288_1:GetWordFromCfg(319801067).content)

				arg_288_1.text_.text = var_291_6

				LuaForUtil.ClearLinePrefixSymbol(arg_288_1.text_)

				local var_291_8 = 41 <= 0 and var_291_4 or var_291_4 * (utf8.len(var_291_6) / 41)

				if (41 <= 0 and var_291_4 or var_291_4 * (utf8.len(var_291_6) / 41)) > 0 and var_291_4 < var_291_8 then
					arg_288_1.talkMaxDuration = var_291_8
					var_291_3 = var_291_3 + 0.3

					if var_291_8 + var_291_3 > arg_288_1.duration_ then
						arg_288_1.duration_ = var_291_8 + var_291_3
					end
				end

				arg_288_1.text_.text = var_291_6
				arg_288_1.typewritter.percent = 0

				arg_288_1.typewritter:SetDirty()
				arg_288_1:ShowNextGo(false)
				arg_288_1:RecordContent(arg_288_1.text_.text)
			end

			local var_291_9 = var_291_3 + 0.3
			local var_291_10 = math.max(var_291_4, arg_288_1.talkMaxDuration)

			if var_291_3 + 0.3 <= arg_288_1.time_ and arg_288_1.time_ < var_291_9 + var_291_10 then
				arg_288_1.typewritter.percent = (arg_288_1.time_ - var_291_9) / var_291_10

				arg_288_1.typewritter:SetDirty()
			end

			if arg_288_1.time_ >= var_291_9 + var_291_10 and arg_288_1.time_ < var_291_9 + var_291_10 + arg_291_0 then
				arg_288_1.typewritter.percent = 1

				arg_288_1.typewritter:SetDirty()
				arg_288_1:ShowNextGo(true)
			end
		end

		arg_288_1.nodeConfigList_ = {}

		arg_288_1:InitPlayNodeList()
	end,
	Play319801068 = function(arg_294_0, arg_294_1)
		arg_294_1.time_ = 0
		arg_294_1.frameCnt_ = 0
		arg_294_1.state_ = "playing"
		arg_294_1.curTalkId_ = 319801068
		arg_294_1.duration_ = 5

		SetActive(arg_294_1.tipsGo_, false)

		function arg_294_1.onSingleLineFinish_()
			arg_294_1.onSingleLineUpdate_ = nil
			arg_294_1.onSingleLineFinish_ = nil
			arg_294_1.state_ = "waiting"
		end

		function arg_294_1.playNext_(arg_296_0)
			if arg_296_0 == 1 then
				arg_294_0:Play319801069(arg_294_1)
			end
		end

		function arg_294_1.onSingleLineUpdate_(arg_297_0)
			local var_297_0 = 1.1

			if 0 < arg_294_1.time_ and arg_294_1.time_ <= 0 + arg_297_0 then
				arg_294_1.talkMaxDuration = 0
				arg_294_1.dialogCg_.alpha = 1

				arg_294_1.dialog_:SetActive(true)
				SetActive(arg_294_1.leftNameGo_, false)

				arg_294_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_294_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_294_1:RecordName(arg_294_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_294_1.iconTrs_.gameObject, false)
				arg_294_1.callingController_:SetSelectedState("normal")

				local var_297_1 = arg_294_1:FormatText(arg_294_1:GetWordFromCfg(319801068).content)

				arg_294_1.text_.text = var_297_1

				LuaForUtil.ClearLinePrefixSymbol(arg_294_1.text_)

				local var_297_3 = 44 <= 0 and var_297_0 or var_297_0 * (utf8.len(var_297_1) / 44)

				if (44 <= 0 and var_297_0 or var_297_0 * (utf8.len(var_297_1) / 44)) > 0 and var_297_0 < var_297_3 then
					arg_294_1.talkMaxDuration = var_297_3

					if var_297_3 + 0 > arg_294_1.duration_ then
						arg_294_1.duration_ = var_297_3 + 0
					end
				end

				arg_294_1.text_.text = var_297_1
				arg_294_1.typewritter.percent = 0

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(false)
				arg_294_1:RecordContent(arg_294_1.text_.text)
			end

			local var_297_4 = math.max(var_297_0, arg_294_1.talkMaxDuration)

			if 0 <= arg_294_1.time_ and arg_294_1.time_ < 0 + var_297_4 then
				arg_294_1.typewritter.percent = (arg_294_1.time_ - 0) / var_297_4

				arg_294_1.typewritter:SetDirty()
			end

			if arg_294_1.time_ >= 0 + var_297_4 and arg_294_1.time_ < 0 + var_297_4 + arg_297_0 then
				arg_294_1.typewritter.percent = 1

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(true)
			end
		end

		arg_294_1.nodeConfigList_ = {}

		arg_294_1:InitPlayNodeList()
	end,
	Play319801069 = function(arg_298_0, arg_298_1)
		arg_298_1.time_ = 0
		arg_298_1.frameCnt_ = 0
		arg_298_1.state_ = "playing"
		arg_298_1.curTalkId_ = 319801069
		arg_298_1.duration_ = 5

		SetActive(arg_298_1.tipsGo_, false)

		function arg_298_1.onSingleLineFinish_()
			arg_298_1.onSingleLineUpdate_ = nil
			arg_298_1.onSingleLineFinish_ = nil
			arg_298_1.state_ = "waiting"
		end

		function arg_298_1.playNext_(arg_300_0)
			if arg_300_0 == 1 then
				arg_298_0:Play319801070(arg_298_1)
			end
		end

		function arg_298_1.onSingleLineUpdate_(arg_301_0)
			local var_301_0 = 0.925

			if 0 < arg_298_1.time_ and arg_298_1.time_ <= 0 + arg_301_0 then
				arg_298_1.talkMaxDuration = 0
				arg_298_1.dialogCg_.alpha = 1

				arg_298_1.dialog_:SetActive(true)
				SetActive(arg_298_1.leftNameGo_, false)

				arg_298_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_298_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_298_1:RecordName(arg_298_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_298_1.iconTrs_.gameObject, false)
				arg_298_1.callingController_:SetSelectedState("normal")

				local var_301_1 = arg_298_1:FormatText(arg_298_1:GetWordFromCfg(319801069).content)

				arg_298_1.text_.text = var_301_1

				LuaForUtil.ClearLinePrefixSymbol(arg_298_1.text_)

				local var_301_3 = 37 <= 0 and var_301_0 or var_301_0 * (utf8.len(var_301_1) / 37)

				if (37 <= 0 and var_301_0 or var_301_0 * (utf8.len(var_301_1) / 37)) > 0 and var_301_0 < var_301_3 then
					arg_298_1.talkMaxDuration = var_301_3

					if var_301_3 + 0 > arg_298_1.duration_ then
						arg_298_1.duration_ = var_301_3 + 0
					end
				end

				arg_298_1.text_.text = var_301_1
				arg_298_1.typewritter.percent = 0

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(false)
				arg_298_1:RecordContent(arg_298_1.text_.text)
			end

			local var_301_4 = math.max(var_301_0, arg_298_1.talkMaxDuration)

			if 0 <= arg_298_1.time_ and arg_298_1.time_ < 0 + var_301_4 then
				arg_298_1.typewritter.percent = (arg_298_1.time_ - 0) / var_301_4

				arg_298_1.typewritter:SetDirty()
			end

			if arg_298_1.time_ >= 0 + var_301_4 and arg_298_1.time_ < 0 + var_301_4 + arg_301_0 then
				arg_298_1.typewritter.percent = 1

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(true)
			end
		end

		arg_298_1.nodeConfigList_ = {}

		arg_298_1:InitPlayNodeList()
	end,
	Play319801070 = function(arg_302_0, arg_302_1)
		arg_302_1.time_ = 0
		arg_302_1.frameCnt_ = 0
		arg_302_1.state_ = "playing"
		arg_302_1.curTalkId_ = 319801070
		arg_302_1.duration_ = 3.37

		SetActive(arg_302_1.tipsGo_, false)

		function arg_302_1.onSingleLineFinish_()
			arg_302_1.onSingleLineUpdate_ = nil
			arg_302_1.onSingleLineFinish_ = nil
			arg_302_1.state_ = "waiting"
		end

		function arg_302_1.playNext_(arg_304_0)
			if arg_304_0 == 1 then
				arg_302_0:Play319801071(arg_302_1)
			end
		end

		function arg_302_1.onSingleLineUpdate_(arg_305_0)
			if arg_302_1.bgs_.STblack == nil then
				local var_305_0 = Object.Instantiate(arg_302_1.paintGo_)

				var_305_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "STblack")
				var_305_0.name = "STblack"
				var_305_0.transform.parent = arg_302_1.stage_.transform
				var_305_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_302_1.bgs_.STblack = var_305_0
			end

			if 0 < arg_302_1.time_ and arg_302_1.time_ <= 0 + arg_305_0 then
				local var_305_1 = arg_302_1.bgs_.STblack

				arg_302_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_305_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_305_2 = var_305_1:GetComponent("SpriteRenderer")

				if var_305_2 and var_305_2.sprite then
					local var_305_3 = 2 * (var_305_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_305_1.transform.localScale = Vector3.New(var_305_3 / var_305_2.sprite.bounds.size.y < var_305_3 * manager.ui.mainCameraCom_.aspect / var_305_2.sprite.bounds.size.x and var_305_3 * manager.ui.mainCameraCom_.aspect / var_305_2.sprite.bounds.size.x or var_305_3 / var_305_2.sprite.bounds.size.y, var_305_3 / var_305_2.sprite.bounds.size.y < var_305_3 * manager.ui.mainCameraCom_.aspect / var_305_2.sprite.bounds.size.x and var_305_3 * manager.ui.mainCameraCom_.aspect / var_305_2.sprite.bounds.size.x or var_305_3 / var_305_2.sprite.bounds.size.y, 0)
				end

				for iter_305_0, iter_305_1 in pairs(arg_302_1.bgs_) do
					if iter_305_0 ~= "STblack" then
						iter_305_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 0 < arg_302_1.time_ and arg_302_1.time_ <= 0 + arg_305_0 then
				local var_305_4 = arg_302_1.fswbg_.transform:Find("textbox/adapt/content") or arg_302_1.fswbg_.transform:Find("textbox/content")
				local var_305_5 = arg_302_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_305_6 = var_305_4:GetComponent("RectTransform")

				var_305_4:GetComponent("Text").alignment = UnityEngine.TextAnchor.LowerCenter
				var_305_6.offsetMin = Vector2.New(0, 0)
				var_305_6.offsetMax = Vector2.New(0, 0)
			end

			if 0 < arg_302_1.time_ and arg_302_1.time_ <= 0 + arg_305_0 then
				arg_302_1.fswbg_:SetActive(true)
				arg_302_1.dialog_:SetActive(false)

				arg_302_1.fswtw_.percent = 0
				arg_302_1.fswt_.text = arg_302_1:FormatText(arg_302_1:GetWordFromCfg(319801070).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_302_1.fswt_)

				arg_302_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_302_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_302_1.fswtw_:SetDirty()

				arg_302_1.typewritterCharCountI18N = 0

				SetActive(arg_302_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_302_1:ShowNextGo(false)
			end

			local var_305_7 = 0.433333333333333

			if 0.433333333333333 < arg_302_1.time_ and arg_302_1.time_ <= var_305_7 + arg_305_0 then
				arg_302_1.var_.oldValueTypewriter = arg_302_1.fswtw_.percent

				SetActive(arg_302_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_302_1:ShowNextGo(false)
			end

			local var_305_8 = 0
			local var_305_9 = 0
			local var_305_10, var_305_11 = arg_302_1:GetPercentByPara(arg_302_1:FormatText(arg_302_1:GetWordFromCfg(319801070).content), 1)

			if var_305_7 < arg_302_1.time_ and arg_302_1.time_ <= var_305_7 + arg_305_0 then
				arg_302_1.talkMaxDuration = 0

				local var_305_12 = var_305_8 <= 0 and var_305_9 or var_305_9 * ((var_305_11 - arg_302_1.typewritterCharCountI18N) / var_305_8)

				if (var_305_8 <= 0 and var_305_9 or var_305_9 * ((var_305_11 - arg_302_1.typewritterCharCountI18N) / var_305_8)) > 0 and var_305_9 < var_305_12 then
					arg_302_1.talkMaxDuration = var_305_12

					if var_305_12 + var_305_7 > arg_302_1.duration_ then
						arg_302_1.duration_ = var_305_12 + var_305_7
					end
				end
			end

			local var_305_13 = math.max(0, arg_302_1.talkMaxDuration)

			if var_305_7 <= arg_302_1.time_ and arg_302_1.time_ < var_305_7 + var_305_13 then
				arg_302_1.fswtw_.percent = Mathf.Lerp(arg_302_1.var_.oldValueTypewriter, var_305_10, (arg_302_1.time_ - var_305_7) / var_305_13)
				arg_302_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_302_1.fswtw_:SetDirty()
			end

			if arg_302_1.time_ >= var_305_7 + var_305_13 and arg_302_1.time_ < var_305_7 + var_305_13 + arg_305_0 then
				arg_302_1.fswtw_.percent = var_305_10

				arg_302_1.fswtw_:SetDirty()
				arg_302_1:ShowNextGo(true)

				arg_302_1.typewritterCharCountI18N = var_305_11
			end

			if 0.433333333333333 < arg_302_1.time_ and arg_302_1.time_ <= 0.433333333333333 + arg_305_0 then
				arg_302_1.fswbg_:SetActive(true)
				arg_302_1.dialog_:SetActive(false)

				arg_302_1.fswtw_.percent = 0
				arg_302_1.fswt_.text = arg_302_1:FormatText(arg_302_1:GetWordFromCfg(319801070).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_302_1.fswt_)

				arg_302_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_302_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_302_1.fswtw_:SetDirty()

				arg_302_1.typewritterCharCountI18N = 0

				SetActive(arg_302_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_302_1:ShowNextGo(false)
			end

			local var_305_14 = 0.566666666666667

			if 0.566666666666667 < arg_302_1.time_ and arg_302_1.time_ <= var_305_14 + arg_305_0 then
				arg_302_1.var_.oldValueTypewriter = arg_302_1.fswtw_.percent

				SetActive(arg_302_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_302_1:ShowNextGo(false)
			end

			local var_305_15 = 10
			local var_305_16 = 0.666666666666667
			local var_305_17, var_305_18 = arg_302_1:GetPercentByPara(arg_302_1:FormatText(arg_302_1:GetWordFromCfg(319801070).content), 1)

			if var_305_14 < arg_302_1.time_ and arg_302_1.time_ <= var_305_14 + arg_305_0 then
				arg_302_1.talkMaxDuration = 0

				local var_305_19 = var_305_15 <= 0 and var_305_16 or var_305_16 * ((var_305_18 - arg_302_1.typewritterCharCountI18N) / var_305_15)

				if (var_305_15 <= 0 and var_305_16 or var_305_16 * ((var_305_18 - arg_302_1.typewritterCharCountI18N) / var_305_15)) > 0 and var_305_16 < var_305_19 then
					arg_302_1.talkMaxDuration = var_305_19

					if var_305_19 + var_305_14 > arg_302_1.duration_ then
						arg_302_1.duration_ = var_305_19 + var_305_14
					end
				end
			end

			local var_305_20 = math.max(0.666666666666667, arg_302_1.talkMaxDuration)

			if var_305_14 <= arg_302_1.time_ and arg_302_1.time_ < var_305_14 + var_305_20 then
				arg_302_1.fswtw_.percent = Mathf.Lerp(arg_302_1.var_.oldValueTypewriter, var_305_17, (arg_302_1.time_ - var_305_14) / var_305_20)
				arg_302_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_302_1.fswtw_:SetDirty()
			end

			if arg_302_1.time_ >= var_305_14 + var_305_20 and arg_302_1.time_ < var_305_14 + var_305_20 + arg_305_0 then
				arg_302_1.fswtw_.percent = var_305_17

				arg_302_1.fswtw_:SetDirty()
				arg_302_1:ShowNextGo(true)

				arg_302_1.typewritterCharCountI18N = var_305_18
			end

			local var_305_21 = 0.433333333333333
			local var_305_22 = manager.audio:GetVoiceLength("story_v_out_319801", "319801070", "story_v_out_319801.awb") / 1000

			if var_305_22 > 0 and 2.933 < var_305_22 and var_305_22 + var_305_21 > arg_302_1.duration_ then
				arg_302_1.duration_ = var_305_22 + var_305_21
			end

			if var_305_21 < arg_302_1.time_ and arg_302_1.time_ <= var_305_21 + arg_305_0 then
				arg_302_1:AudioAction("play", "voice", "story_v_out_319801", "319801070", "story_v_out_319801.awb")
			end

			if 0 < arg_302_1.time_ and arg_302_1.time_ <= 0 + arg_305_0 then
				arg_302_1.cswbg_:SetActive(true)

				local var_305_24 = arg_302_1.cswt_:GetComponent("RectTransform")

				arg_302_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_305_24.offsetMin = Vector2.New(410, 330)
				var_305_24.offsetMax = Vector2.New(-400, -175)
				arg_302_1.cswt_.text = arg_302_1:FormatText(arg_302_1:GetWordFromCfg(419055).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_302_1.cswt_)

				arg_302_1.cswt_.fontSize = 180
				arg_302_1.cswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_302_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_302_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end
		end

		arg_302_1.nodeConfigList_ = {}

		arg_302_1:InitPlayNodeList()
	end,
	Play319801071 = function(arg_306_0, arg_306_1)
		arg_306_1.time_ = 0
		arg_306_1.frameCnt_ = 0
		arg_306_1.state_ = "playing"
		arg_306_1.curTalkId_ = 319801071
		arg_306_1.duration_ = 6.17

		SetActive(arg_306_1.tipsGo_, false)

		function arg_306_1.onSingleLineFinish_()
			arg_306_1.onSingleLineUpdate_ = nil
			arg_306_1.onSingleLineFinish_ = nil
			arg_306_1.state_ = "waiting"
		end

		function arg_306_1.playNext_(arg_308_0)
			if arg_308_0 == 1 then
				arg_306_0:Play319801072(arg_306_1)
			end
		end

		function arg_306_1.onSingleLineUpdate_(arg_309_0)
			if 0 < arg_306_1.time_ and arg_306_1.time_ <= 0 + arg_309_0 then
				arg_306_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_309_2 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_306_1.bgmTxt_.text ~= var_309_2 and arg_306_1.bgmTxt_.text ~= "" then
						if arg_306_1.bgmTxt2_.text ~= "" then
							arg_306_1.bgmTxt_.text = arg_306_1.bgmTxt2_.text
						end

						arg_306_1.bgmTxt2_.text = var_309_2

						arg_306_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_306_1.bgmTxt_.text = var_309_2
						arg_306_1.bgmTxt2_.text = var_309_2
					end

					if arg_306_1.bgmTimer then
						arg_306_1.bgmTimer:Stop()

						arg_306_1.bgmTimer = nil
					end

					if arg_306_1.settingData.show_music_name == 1 then
						arg_306_1.musicController:SetSelectedState("show")
						arg_306_1.musicAnimator_:Play("open", 0, 0)

						if arg_306_1.settingData.music_time ~= 0 then
							arg_306_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_306_1.settingData.music_time), function()
								if arg_306_1 == nil or isNil(arg_306_1.bgmTxt_) then
									return
								end

								arg_306_1.musicController:SetSelectedState("hide")
								arg_306_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.233333333333333 < arg_306_1.time_ and arg_306_1.time_ <= 0.233333333333333 + arg_309_0 then
				arg_306_1:AudioAction("play", "music", "bgm_activity_3_0_story_special_death", "bgm_activity_3_0_story_special_death", "bgm_activity_3_0_story_special_death.awb")

				local var_309_5 = manager.audio:GetAudioName("bgm_activity_3_0_story_special_death", "bgm_activity_3_0_story_special_death")

				if "" ~= "" then
					if arg_306_1.bgmTxt_.text ~= var_309_5 and arg_306_1.bgmTxt_.text ~= "" then
						if arg_306_1.bgmTxt2_.text ~= "" then
							arg_306_1.bgmTxt_.text = arg_306_1.bgmTxt2_.text
						end

						arg_306_1.bgmTxt2_.text = var_309_5

						arg_306_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_306_1.bgmTxt_.text = var_309_5
						arg_306_1.bgmTxt2_.text = var_309_5
					end

					if arg_306_1.bgmTimer then
						arg_306_1.bgmTimer:Stop()

						arg_306_1.bgmTimer = nil
					end

					if arg_306_1.settingData.show_music_name == 1 then
						arg_306_1.musicController:SetSelectedState("show")
						arg_306_1.musicAnimator_:Play("open", 0, 0)

						if arg_306_1.settingData.music_time ~= 0 then
							arg_306_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_306_1.settingData.music_time), function()
								if arg_306_1 == nil or isNil(arg_306_1.bgmTxt_) then
									return
								end

								arg_306_1.musicController:SetSelectedState("hide")
								arg_306_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0 < arg_306_1.time_ and arg_306_1.time_ <= 0 + arg_309_0 then
				arg_306_1.fswbg_:SetActive(true)
				arg_306_1.dialog_:SetActive(false)

				arg_306_1.fswtw_.percent = 0
				arg_306_1.fswt_.text = arg_306_1:FormatText(arg_306_1:GetWordFromCfg(319801071).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_306_1.fswt_)

				arg_306_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_306_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_306_1.fswtw_:SetDirty()

				arg_306_1.typewritterCharCountI18N = 0

				SetActive(arg_306_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_306_1:ShowNextGo(false)
			end

			local var_309_6 = 0.333333333332

			if 0.333333333332 < arg_306_1.time_ and arg_306_1.time_ <= var_309_6 + arg_309_0 then
				arg_306_1.var_.oldValueTypewriter = arg_306_1.fswtw_.percent

				SetActive(arg_306_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_306_1:ShowNextGo(false)
			end

			local var_309_7 = 18
			local var_309_8 = 1.2
			local var_309_9, var_309_10 = arg_306_1:GetPercentByPara(arg_306_1:FormatText(arg_306_1:GetWordFromCfg(319801071).content), 1)

			if var_309_6 < arg_306_1.time_ and arg_306_1.time_ <= var_309_6 + arg_309_0 then
				arg_306_1.talkMaxDuration = 0

				local var_309_11 = var_309_7 <= 0 and var_309_8 or var_309_8 * ((var_309_10 - arg_306_1.typewritterCharCountI18N) / var_309_7)

				if (var_309_7 <= 0 and var_309_8 or var_309_8 * ((var_309_10 - arg_306_1.typewritterCharCountI18N) / var_309_7)) > 0 and var_309_8 < var_309_11 then
					arg_306_1.talkMaxDuration = var_309_11

					if var_309_11 + var_309_6 > arg_306_1.duration_ then
						arg_306_1.duration_ = var_309_11 + var_309_6
					end
				end
			end

			local var_309_12 = math.max(1.2, arg_306_1.talkMaxDuration)

			if var_309_6 <= arg_306_1.time_ and arg_306_1.time_ < var_309_6 + var_309_12 then
				arg_306_1.fswtw_.percent = Mathf.Lerp(arg_306_1.var_.oldValueTypewriter, var_309_9, (arg_306_1.time_ - var_309_6) / var_309_12)
				arg_306_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_306_1.fswtw_:SetDirty()
			end

			if arg_306_1.time_ >= var_309_6 + var_309_12 and arg_306_1.time_ < var_309_6 + var_309_12 + arg_309_0 then
				arg_306_1.fswtw_.percent = var_309_9

				arg_306_1.fswtw_:SetDirty()
				arg_306_1:ShowNextGo(true)

				arg_306_1.typewritterCharCountI18N = var_309_10
			end

			local var_309_13 = 0.233333333333333
			local var_309_14 = manager.audio:GetVoiceLength("story_v_out_319801", "319801071", "story_v_out_319801.awb") / 1000

			if var_309_14 > 0 and 5.933 < var_309_14 and var_309_14 + var_309_13 > arg_306_1.duration_ then
				arg_306_1.duration_ = var_309_14 + var_309_13
			end

			if var_309_13 < arg_306_1.time_ and arg_306_1.time_ <= var_309_13 + arg_309_0 then
				arg_306_1:AudioAction("play", "voice", "story_v_out_319801", "319801071", "story_v_out_319801.awb")
			end
		end

		arg_306_1.nodeConfigList_ = {}

		arg_306_1:InitPlayNodeList()
	end,
	Play319801072 = function(arg_312_0, arg_312_1)
		arg_312_1.time_ = 0
		arg_312_1.frameCnt_ = 0
		arg_312_1.state_ = "playing"
		arg_312_1.curTalkId_ = 319801072
		arg_312_1.duration_ = 6.7

		SetActive(arg_312_1.tipsGo_, false)

		function arg_312_1.onSingleLineFinish_()
			arg_312_1.onSingleLineUpdate_ = nil
			arg_312_1.onSingleLineFinish_ = nil
			arg_312_1.state_ = "waiting"
		end

		function arg_312_1.playNext_(arg_314_0)
			if arg_314_0 == 1 then
				arg_312_0:Play319801073(arg_312_1)
			end
		end

		function arg_312_1.onSingleLineUpdate_(arg_315_0)
			if arg_312_1.bgs_.ML0204 == nil then
				local var_315_0 = Object.Instantiate(arg_312_1.paintGo_)

				var_315_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ML0204")
				var_315_0.name = "ML0204"
				var_315_0.transform.parent = arg_312_1.stage_.transform
				var_315_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_312_1.bgs_.ML0204 = var_315_0
			end

			if 0.416666666666667 < arg_312_1.time_ and arg_312_1.time_ <= 0.416666666666667 + arg_315_0 then
				local var_315_1 = arg_312_1.bgs_.ML0204

				arg_312_1.bgs_.ML0204.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_315_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_315_2 = var_315_1:GetComponent("SpriteRenderer")

				if var_315_2 and var_315_2.sprite then
					local var_315_3 = 2 * (var_315_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_315_1.transform.localScale = Vector3.New(var_315_3 / var_315_2.sprite.bounds.size.y < var_315_3 * manager.ui.mainCameraCom_.aspect / var_315_2.sprite.bounds.size.x and var_315_3 * manager.ui.mainCameraCom_.aspect / var_315_2.sprite.bounds.size.x or var_315_3 / var_315_2.sprite.bounds.size.y, var_315_3 / var_315_2.sprite.bounds.size.y < var_315_3 * manager.ui.mainCameraCom_.aspect / var_315_2.sprite.bounds.size.x and var_315_3 * manager.ui.mainCameraCom_.aspect / var_315_2.sprite.bounds.size.x or var_315_3 / var_315_2.sprite.bounds.size.y, 0)
				end

				for iter_315_0, iter_315_1 in pairs(arg_312_1.bgs_) do
					if iter_315_0 ~= "ML0204" then
						iter_315_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_315_4 = 0

			if 0 < arg_312_1.time_ and arg_312_1.time_ <= var_315_4 + arg_315_0 then
				arg_312_1.mask_.enabled = true
				arg_312_1.mask_.raycastTarget = true

				arg_312_1:SetGaussion(false)
			end

			local var_315_5 = 0.433333333333333

			if var_315_4 <= arg_312_1.time_ and arg_312_1.time_ < var_315_4 + var_315_5 then
				local var_315_6 = Color.New(0, 0, 0)

				var_315_6.a = Mathf.Lerp(0, 1, (arg_312_1.time_ - var_315_4) / var_315_5)
				arg_312_1.mask_.color = var_315_6
			end

			if arg_312_1.time_ >= var_315_4 + var_315_5 and arg_312_1.time_ < var_315_4 + var_315_5 + arg_315_0 then
				local var_315_7 = Color.New(0, 0, 0)

				var_315_7.a = 1
				arg_312_1.mask_.color = var_315_7
			end

			local var_315_8 = 0.433333333333333

			if 0.433333333333333 < arg_312_1.time_ and arg_312_1.time_ <= var_315_8 + arg_315_0 then
				arg_312_1.mask_.enabled = true
				arg_312_1.mask_.raycastTarget = true

				arg_312_1:SetGaussion(false)
			end

			local var_315_9 = 2

			if var_315_8 <= arg_312_1.time_ and arg_312_1.time_ < var_315_8 + var_315_9 then
				local var_315_10 = Color.New(0, 0, 0)

				var_315_10.a = Mathf.Lerp(1, 0, (arg_312_1.time_ - var_315_8) / var_315_9)
				arg_312_1.mask_.color = var_315_10
			end

			if arg_312_1.time_ >= var_315_8 + var_315_9 and arg_312_1.time_ < var_315_8 + var_315_9 + arg_315_0 then
				local var_315_11 = Color.New(0, 0, 0)

				arg_312_1.mask_.enabled = false
				var_315_11.a = 0
				arg_312_1.mask_.color = var_315_11
			end

			local var_315_12 = arg_312_1.actors_["10066ui_story"].transform

			if 0 < arg_312_1.time_ and arg_312_1.time_ <= 0 + arg_315_0 then
				arg_312_1.var_.moveOldPos10066ui_story = var_315_12.localPosition
			end

			local var_315_13 = 0.001

			if 0 <= arg_312_1.time_ and arg_312_1.time_ < 0 + var_315_13 then
				var_315_12.localPosition = Vector3.Lerp(arg_312_1.var_.moveOldPos10066ui_story, Vector3.New(0, 100, 0), (arg_312_1.time_ - 0) / var_315_13)
				var_315_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_315_12.position).x, (manager.ui.mainCamera.transform.position - var_315_12.position).y, (manager.ui.mainCamera.transform.position - var_315_12.position).z)
				var_315_12.localEulerAngles.z = 0
				var_315_12.localEulerAngles.x = 0
				var_315_12.localEulerAngles = var_315_12.localEulerAngles
			end

			if arg_312_1.time_ >= 0 + var_315_13 and arg_312_1.time_ < 0 + var_315_13 + arg_315_0 then
				var_315_12.localPosition = Vector3.New(0, 100, 0)
				var_315_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_315_12.position).x, (manager.ui.mainCamera.transform.position - var_315_12.position).y, (manager.ui.mainCamera.transform.position - var_315_12.position).z)
				var_315_12.localEulerAngles.z = 0
				var_315_12.localEulerAngles.x = 0
				var_315_12.localEulerAngles = var_315_12.localEulerAngles
			end

			local var_315_14 = arg_312_1.actors_["10066ui_story"]

			if 0 < arg_312_1.time_ and arg_312_1.time_ <= 0 + arg_315_0 and not isNil(var_315_14) and arg_312_1.var_.characterEffect10066ui_story == nil then
				arg_312_1.var_.characterEffect10066ui_story = var_315_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_315_15 = 0.200000002980232

			if 0 <= arg_312_1.time_ and arg_312_1.time_ < 0 + var_315_15 and not isNil(var_315_14) then
				if arg_312_1.var_.characterEffect10066ui_story and not isNil(var_315_14) then
					arg_312_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_312_1.var_.characterEffect10066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_312_1.time_ - 0) / var_315_15)
				end
			end

			if arg_312_1.time_ >= 0 + var_315_15 and arg_312_1.time_ < 0 + var_315_15 + arg_315_0 and not isNil(var_315_14) and arg_312_1.var_.characterEffect10066ui_story then
				arg_312_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_312_1.var_.characterEffect10066ui_story.fillRatio = 0.5
			end

			if 0 < arg_312_1.time_ and arg_312_1.time_ <= 0 + arg_315_0 then
				arg_312_1.fswbg_:SetActive(false)
				arg_312_1.dialog_:SetActive(false)
				SetActive(arg_312_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_312_1:ShowNextGo(false)
			end

			if 0.1 < arg_312_1.time_ and arg_312_1.time_ <= 0.1 + arg_315_0 then
				arg_312_1.fswbg_:SetActive(false)
				arg_312_1.dialog_:SetActive(false)
				SetActive(arg_312_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_312_1:ShowNextGo(false)
			end

			local var_315_16 = 0.433333333333333

			if 0.433333333333333 < arg_312_1.time_ and arg_312_1.time_ <= var_315_16 + arg_315_0 then
				arg_312_1.var_.oldValueTypewriter = arg_312_1.fswtw_.percent

				SetActive(arg_312_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_312_1:ShowNextGo(false)
			end

			local var_315_17 = 0
			local var_315_18 = 0
			local var_315_19, var_315_20 = arg_312_1:GetPercentByPara(arg_312_1:FormatText(arg_312_1:GetWordFromCfg(319801071).content), 1)

			if var_315_16 < arg_312_1.time_ and arg_312_1.time_ <= var_315_16 + arg_315_0 then
				arg_312_1.talkMaxDuration = 0

				local var_315_21 = var_315_17 <= 0 and var_315_18 or var_315_18 * ((var_315_20 - arg_312_1.typewritterCharCountI18N) / var_315_17)

				if (var_315_17 <= 0 and var_315_18 or var_315_18 * ((var_315_20 - arg_312_1.typewritterCharCountI18N) / var_315_17)) > 0 and var_315_18 < var_315_21 then
					arg_312_1.talkMaxDuration = var_315_21

					if var_315_21 + var_315_16 > arg_312_1.duration_ then
						arg_312_1.duration_ = var_315_21 + var_315_16
					end
				end
			end

			local var_315_22 = math.max(0, arg_312_1.talkMaxDuration)

			if var_315_16 <= arg_312_1.time_ and arg_312_1.time_ < var_315_16 + var_315_22 then
				arg_312_1.fswtw_.percent = Mathf.Lerp(arg_312_1.var_.oldValueTypewriter, var_315_19, (arg_312_1.time_ - var_315_16) / var_315_22)
				arg_312_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_312_1.fswtw_:SetDirty()
			end

			if arg_312_1.time_ >= var_315_16 + var_315_22 and arg_312_1.time_ < var_315_16 + var_315_22 + arg_315_0 then
				arg_312_1.fswtw_.percent = var_315_19

				arg_312_1.fswtw_:SetDirty()
				arg_312_1:ShowNextGo(true)

				arg_312_1.typewritterCharCountI18N = var_315_20
			end

			if 0 < arg_312_1.time_ and arg_312_1.time_ <= 0 + arg_315_0 then
				arg_312_1.cswbg_:SetActive(false)
			end

			local var_315_23 = arg_312_1.bgs_.ML0204.transform

			if 0.433333333333333 < arg_312_1.time_ and arg_312_1.time_ <= 0.433333333333333 + arg_315_0 then
				arg_312_1.var_.moveOldPosML0204 = var_315_23.localPosition
			end

			local var_315_24 = 0.001

			if 0.433333333333333 <= arg_312_1.time_ and arg_312_1.time_ < 0.433333333333333 + var_315_24 then
				var_315_23.localPosition = Vector3.Lerp(arg_312_1.var_.moveOldPosML0204, Vector3.New(0, 1, 7.64), (arg_312_1.time_ - 0.433333333333333) / var_315_24)
			end

			if arg_312_1.time_ >= 0.433333333333333 + var_315_24 and arg_312_1.time_ < 0.433333333333333 + var_315_24 + arg_315_0 then
				var_315_23.localPosition = Vector3.New(0, 1, 7.64)
			end

			local var_315_25 = arg_312_1.bgs_.ML0204.transform

			if 0.45 < arg_312_1.time_ and arg_312_1.time_ <= 0.45 + arg_315_0 then
				arg_312_1.var_.moveOldPosML0204 = var_315_25.localPosition
			end

			local var_315_26 = 2.1

			if 0.45 <= arg_312_1.time_ and arg_312_1.time_ < 0.45 + var_315_26 then
				var_315_25.localPosition = Vector3.Lerp(arg_312_1.var_.moveOldPosML0204, Vector3.New(0, 1, 10), (arg_312_1.time_ - 0.45) / var_315_26)
			end

			if arg_312_1.time_ >= 0.45 + var_315_26 and arg_312_1.time_ < 0.45 + var_315_26 + arg_315_0 then
				var_315_25.localPosition = Vector3.New(0, 1, 10)
			end

			if arg_312_1.frameCnt_ <= 1 then
				arg_312_1.dialog_:SetActive(false)
			end

			local var_315_27 = 1.7
			local var_315_28 = 0.975

			if 1.7 < arg_312_1.time_ and arg_312_1.time_ <= var_315_27 + arg_315_0 then
				arg_312_1.talkMaxDuration = 0

				arg_312_1.dialog_:SetActive(true)

				arg_312_1.dialogCg_.alpha = 0

				local var_315_29 = LeanTween.value(arg_312_1.dialog_, 0, 1, 0.3)

				var_315_29:setOnUpdate(LuaHelper.FloatAction(function(arg_316_0)
					arg_312_1.dialogCg_.alpha = arg_316_0
				end))
				var_315_29:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_312_1.dialog_)
					var_315_29:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_312_1.duration_ = arg_312_1.duration_ + 0.3

				SetActive(arg_312_1.leftNameGo_, false)

				arg_312_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_312_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_312_1:RecordName(arg_312_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_312_1.iconTrs_.gameObject, false)
				arg_312_1.callingController_:SetSelectedState("normal")

				local var_315_30 = arg_312_1:FormatText(arg_312_1:GetWordFromCfg(319801072).content)

				arg_312_1.text_.text = var_315_30

				LuaForUtil.ClearLinePrefixSymbol(arg_312_1.text_)

				local var_315_32 = 39 <= 0 and var_315_28 or var_315_28 * (utf8.len(var_315_30) / 39)

				if (39 <= 0 and var_315_28 or var_315_28 * (utf8.len(var_315_30) / 39)) > 0 and var_315_28 < var_315_32 then
					arg_312_1.talkMaxDuration = var_315_32
					var_315_27 = var_315_27 + 0.3

					if var_315_32 + var_315_27 > arg_312_1.duration_ then
						arg_312_1.duration_ = var_315_32 + var_315_27
					end
				end

				arg_312_1.text_.text = var_315_30
				arg_312_1.typewritter.percent = 0

				arg_312_1.typewritter:SetDirty()
				arg_312_1:ShowNextGo(false)
				arg_312_1:RecordContent(arg_312_1.text_.text)
			end

			local var_315_33 = var_315_27 + 0.3
			local var_315_34 = math.max(var_315_28, arg_312_1.talkMaxDuration)

			if var_315_27 + 0.3 <= arg_312_1.time_ and arg_312_1.time_ < var_315_33 + var_315_34 then
				arg_312_1.typewritter.percent = (arg_312_1.time_ - var_315_33) / var_315_34

				arg_312_1.typewritter:SetDirty()
			end

			if arg_312_1.time_ >= var_315_33 + var_315_34 and arg_312_1.time_ < var_315_33 + var_315_34 + arg_315_0 then
				arg_312_1.typewritter.percent = 1

				arg_312_1.typewritter:SetDirty()
				arg_312_1:ShowNextGo(true)
			end
		end

		arg_312_1.nodeConfigList_ = {
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
				actorName = "ML0204",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0.433333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "ML0204",
				changeDisplayLayer = false,
				needEase = false,
				duration = 2.1,
				className = "StoryMoveNode",
				startTime = 0.45,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_312_1:InitPlayNodeList()
	end,
	Play319801073 = function(arg_318_0, arg_318_1)
		arg_318_1.time_ = 0
		arg_318_1.frameCnt_ = 0
		arg_318_1.state_ = "playing"
		arg_318_1.curTalkId_ = 319801073
		arg_318_1.duration_ = 5

		SetActive(arg_318_1.tipsGo_, false)

		function arg_318_1.onSingleLineFinish_()
			arg_318_1.onSingleLineUpdate_ = nil
			arg_318_1.onSingleLineFinish_ = nil
			arg_318_1.state_ = "waiting"
		end

		function arg_318_1.playNext_(arg_320_0)
			if arg_320_0 == 1 then
				arg_318_0:Play319801074(arg_318_1)
			end
		end

		function arg_318_1.onSingleLineUpdate_(arg_321_0)
			local var_321_0 = 0.975

			if 0 < arg_318_1.time_ and arg_318_1.time_ <= 0 + arg_321_0 then
				arg_318_1.talkMaxDuration = 0
				arg_318_1.dialogCg_.alpha = 1

				arg_318_1.dialog_:SetActive(true)
				SetActive(arg_318_1.leftNameGo_, false)

				arg_318_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_318_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_318_1:RecordName(arg_318_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_318_1.iconTrs_.gameObject, false)
				arg_318_1.callingController_:SetSelectedState("normal")

				local var_321_1 = arg_318_1:FormatText(arg_318_1:GetWordFromCfg(319801073).content)

				arg_318_1.text_.text = var_321_1

				LuaForUtil.ClearLinePrefixSymbol(arg_318_1.text_)

				local var_321_3 = 39 <= 0 and var_321_0 or var_321_0 * (utf8.len(var_321_1) / 39)

				if (39 <= 0 and var_321_0 or var_321_0 * (utf8.len(var_321_1) / 39)) > 0 and var_321_0 < var_321_3 then
					arg_318_1.talkMaxDuration = var_321_3

					if var_321_3 + 0 > arg_318_1.duration_ then
						arg_318_1.duration_ = var_321_3 + 0
					end
				end

				arg_318_1.text_.text = var_321_1
				arg_318_1.typewritter.percent = 0

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(false)
				arg_318_1:RecordContent(arg_318_1.text_.text)
			end

			local var_321_4 = math.max(var_321_0, arg_318_1.talkMaxDuration)

			if 0 <= arg_318_1.time_ and arg_318_1.time_ < 0 + var_321_4 then
				arg_318_1.typewritter.percent = (arg_318_1.time_ - 0) / var_321_4

				arg_318_1.typewritter:SetDirty()
			end

			if arg_318_1.time_ >= 0 + var_321_4 and arg_318_1.time_ < 0 + var_321_4 + arg_321_0 then
				arg_318_1.typewritter.percent = 1

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(true)
			end
		end

		arg_318_1.nodeConfigList_ = {}

		arg_318_1:InitPlayNodeList()
	end,
	Play319801074 = function(arg_322_0, arg_322_1)
		arg_322_1.time_ = 0
		arg_322_1.frameCnt_ = 0
		arg_322_1.state_ = "playing"
		arg_322_1.curTalkId_ = 319801074
		arg_322_1.duration_ = 3.07

		local var_322_0 = {
			zh = 2.933,
			ja = 3.066
		}
		local var_322_1 = manager.audio:GetLocalizationFlag()

		if var_322_0[var_322_1] ~= nil then
			arg_322_1.duration_ = var_322_0[var_322_1]
		end

		SetActive(arg_322_1.tipsGo_, false)

		function arg_322_1.onSingleLineFinish_()
			arg_322_1.onSingleLineUpdate_ = nil
			arg_322_1.onSingleLineFinish_ = nil
			arg_322_1.state_ = "waiting"
		end

		function arg_322_1.playNext_(arg_324_0)
			if arg_324_0 == 1 then
				arg_322_0:Play319801075(arg_322_1)
			end
		end

		function arg_322_1.onSingleLineUpdate_(arg_325_0)
			local var_325_0 = 0.3

			if 0 < arg_322_1.time_ and arg_322_1.time_ <= 0 + arg_325_0 then
				arg_322_1.talkMaxDuration = 0
				arg_322_1.dialogCg_.alpha = 1

				arg_322_1.dialog_:SetActive(true)
				SetActive(arg_322_1.leftNameGo_, true)

				arg_322_1.leftNameTxt_.text = arg_322_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_322_1.leftNameTxt_.transform)

				arg_322_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_322_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_322_1:RecordName(arg_322_1.leftNameTxt_.text)
				SetActive(arg_322_1.iconTrs_.gameObject, false)
				arg_322_1.callingController_:SetSelectedState("normal")

				local var_325_1 = arg_322_1:GetWordFromCfg(319801074)
				local var_325_2 = arg_322_1:FormatText(var_325_1.content)

				arg_322_1.text_.text = var_325_2

				LuaForUtil.ClearLinePrefixSymbol(arg_322_1.text_)

				local var_325_4 = 12 <= 0 and var_325_0 or var_325_0 * (utf8.len(var_325_2) / 12)

				if (12 <= 0 and var_325_0 or var_325_0 * (utf8.len(var_325_2) / 12)) > 0 and var_325_0 < var_325_4 then
					arg_322_1.talkMaxDuration = var_325_4

					if var_325_4 + 0 > arg_322_1.duration_ then
						arg_322_1.duration_ = var_325_4 + 0
					end
				end

				arg_322_1.text_.text = var_325_2
				arg_322_1.typewritter.percent = 0

				arg_322_1.typewritter:SetDirty()
				arg_322_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319801", "319801074", "story_v_out_319801.awb") ~= 0 then
					local var_325_5 = manager.audio:GetVoiceLength("story_v_out_319801", "319801074", "story_v_out_319801.awb") / 1000

					if var_325_5 + 0 > arg_322_1.duration_ then
						arg_322_1.duration_ = var_325_5 + 0
					end

					if var_325_1.prefab_name ~= "" and arg_322_1.actors_[var_325_1.prefab_name] ~= nil then
						local var_325_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_322_1.actors_[var_325_1.prefab_name].transform, "story_v_out_319801", "319801074", "story_v_out_319801.awb")

						arg_322_1:RecordAudio("319801074", var_325_6)
						arg_322_1:RecordAudio("319801074", var_325_6)
					else
						arg_322_1:AudioAction("play", "voice", "story_v_out_319801", "319801074", "story_v_out_319801.awb")
					end

					arg_322_1:RecordHistoryTalkVoice("story_v_out_319801", "319801074", "story_v_out_319801.awb")
				end

				arg_322_1:RecordContent(arg_322_1.text_.text)
			end

			local var_325_7 = math.max(var_325_0, arg_322_1.talkMaxDuration)

			if 0 <= arg_322_1.time_ and arg_322_1.time_ < 0 + var_325_7 then
				arg_322_1.typewritter.percent = (arg_322_1.time_ - 0) / var_325_7

				arg_322_1.typewritter:SetDirty()
			end

			if arg_322_1.time_ >= 0 + var_325_7 and arg_322_1.time_ < 0 + var_325_7 + arg_325_0 then
				arg_322_1.typewritter.percent = 1

				arg_322_1.typewritter:SetDirty()
				arg_322_1:ShowNextGo(true)
			end
		end

		arg_322_1.nodeConfigList_ = {}

		arg_322_1:InitPlayNodeList()
	end,
	Play319801075 = function(arg_326_0, arg_326_1)
		arg_326_1.time_ = 0
		arg_326_1.frameCnt_ = 0
		arg_326_1.state_ = "playing"
		arg_326_1.curTalkId_ = 319801075
		arg_326_1.duration_ = 9.5

		local var_326_0 = {
			zh = 4.433,
			ja = 9.5
		}
		local var_326_1 = manager.audio:GetLocalizationFlag()

		if var_326_0[var_326_1] ~= nil then
			arg_326_1.duration_ = var_326_0[var_326_1]
		end

		SetActive(arg_326_1.tipsGo_, false)

		function arg_326_1.onSingleLineFinish_()
			arg_326_1.onSingleLineUpdate_ = nil
			arg_326_1.onSingleLineFinish_ = nil
			arg_326_1.state_ = "waiting"
		end

		function arg_326_1.playNext_(arg_328_0)
			if arg_328_0 == 1 then
				arg_326_0:Play319801076(arg_326_1)
			end
		end

		function arg_326_1.onSingleLineUpdate_(arg_329_0)
			local var_329_0 = 0.275

			if 0 < arg_326_1.time_ and arg_326_1.time_ <= 0 + arg_329_0 then
				arg_326_1.talkMaxDuration = 0
				arg_326_1.dialogCg_.alpha = 1

				arg_326_1.dialog_:SetActive(true)
				SetActive(arg_326_1.leftNameGo_, true)

				arg_326_1.leftNameTxt_.text = arg_326_1:FormatText(StoryNameCfg[640].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_326_1.leftNameTxt_.transform)

				arg_326_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_326_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_326_1:RecordName(arg_326_1.leftNameTxt_.text)
				SetActive(arg_326_1.iconTrs_.gameObject, false)
				arg_326_1.callingController_:SetSelectedState("normal")

				local var_329_1 = arg_326_1:GetWordFromCfg(319801075)
				local var_329_2 = arg_326_1:FormatText(var_329_1.content)

				arg_326_1.text_.text = var_329_2

				LuaForUtil.ClearLinePrefixSymbol(arg_326_1.text_)

				local var_329_4 = 11 <= 0 and var_329_0 or var_329_0 * (utf8.len(var_329_2) / 11)

				if (11 <= 0 and var_329_0 or var_329_0 * (utf8.len(var_329_2) / 11)) > 0 and var_329_0 < var_329_4 then
					arg_326_1.talkMaxDuration = var_329_4

					if var_329_4 + 0 > arg_326_1.duration_ then
						arg_326_1.duration_ = var_329_4 + 0
					end
				end

				arg_326_1.text_.text = var_329_2
				arg_326_1.typewritter.percent = 0

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319801", "319801075", "story_v_out_319801.awb") ~= 0 then
					local var_329_5 = manager.audio:GetVoiceLength("story_v_out_319801", "319801075", "story_v_out_319801.awb") / 1000

					if var_329_5 + 0 > arg_326_1.duration_ then
						arg_326_1.duration_ = var_329_5 + 0
					end

					if var_329_1.prefab_name ~= "" and arg_326_1.actors_[var_329_1.prefab_name] ~= nil then
						local var_329_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_326_1.actors_[var_329_1.prefab_name].transform, "story_v_out_319801", "319801075", "story_v_out_319801.awb")

						arg_326_1:RecordAudio("319801075", var_329_6)
						arg_326_1:RecordAudio("319801075", var_329_6)
					else
						arg_326_1:AudioAction("play", "voice", "story_v_out_319801", "319801075", "story_v_out_319801.awb")
					end

					arg_326_1:RecordHistoryTalkVoice("story_v_out_319801", "319801075", "story_v_out_319801.awb")
				end

				arg_326_1:RecordContent(arg_326_1.text_.text)
			end

			local var_329_7 = math.max(var_329_0, arg_326_1.talkMaxDuration)

			if 0 <= arg_326_1.time_ and arg_326_1.time_ < 0 + var_329_7 then
				arg_326_1.typewritter.percent = (arg_326_1.time_ - 0) / var_329_7

				arg_326_1.typewritter:SetDirty()
			end

			if arg_326_1.time_ >= 0 + var_329_7 and arg_326_1.time_ < 0 + var_329_7 + arg_329_0 then
				arg_326_1.typewritter.percent = 1

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(true)
			end
		end

		arg_326_1.nodeConfigList_ = {}

		arg_326_1:InitPlayNodeList()
	end,
	Play319801076 = function(arg_330_0, arg_330_1)
		arg_330_1.time_ = 0
		arg_330_1.frameCnt_ = 0
		arg_330_1.state_ = "playing"
		arg_330_1.curTalkId_ = 319801076
		arg_330_1.duration_ = 2.8

		local var_330_0 = {
			zh = 1.733,
			ja = 2.8
		}
		local var_330_1 = manager.audio:GetLocalizationFlag()

		if var_330_0[var_330_1] ~= nil then
			arg_330_1.duration_ = var_330_0[var_330_1]
		end

		SetActive(arg_330_1.tipsGo_, false)

		function arg_330_1.onSingleLineFinish_()
			arg_330_1.onSingleLineUpdate_ = nil
			arg_330_1.onSingleLineFinish_ = nil
			arg_330_1.state_ = "waiting"
		end

		function arg_330_1.playNext_(arg_332_0)
			if arg_332_0 == 1 then
				arg_330_0:Play319801077(arg_330_1)
			end
		end

		function arg_330_1.onSingleLineUpdate_(arg_333_0)
			local var_333_0 = 0.175

			if 0 < arg_330_1.time_ and arg_330_1.time_ <= 0 + arg_333_0 then
				arg_330_1.talkMaxDuration = 0
				arg_330_1.dialogCg_.alpha = 1

				arg_330_1.dialog_:SetActive(true)
				SetActive(arg_330_1.leftNameGo_, true)

				arg_330_1.leftNameTxt_.text = arg_330_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_330_1.leftNameTxt_.transform)

				arg_330_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_330_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_330_1:RecordName(arg_330_1.leftNameTxt_.text)
				SetActive(arg_330_1.iconTrs_.gameObject, false)
				arg_330_1.callingController_:SetSelectedState("normal")

				local var_333_1 = arg_330_1:GetWordFromCfg(319801076)
				local var_333_2 = arg_330_1:FormatText(var_333_1.content)

				arg_330_1.text_.text = var_333_2

				LuaForUtil.ClearLinePrefixSymbol(arg_330_1.text_)

				local var_333_4 = 7 <= 0 and var_333_0 or var_333_0 * (utf8.len(var_333_2) / 7)

				if (7 <= 0 and var_333_0 or var_333_0 * (utf8.len(var_333_2) / 7)) > 0 and var_333_0 < var_333_4 then
					arg_330_1.talkMaxDuration = var_333_4

					if var_333_4 + 0 > arg_330_1.duration_ then
						arg_330_1.duration_ = var_333_4 + 0
					end
				end

				arg_330_1.text_.text = var_333_2
				arg_330_1.typewritter.percent = 0

				arg_330_1.typewritter:SetDirty()
				arg_330_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319801", "319801076", "story_v_out_319801.awb") ~= 0 then
					local var_333_5 = manager.audio:GetVoiceLength("story_v_out_319801", "319801076", "story_v_out_319801.awb") / 1000

					if var_333_5 + 0 > arg_330_1.duration_ then
						arg_330_1.duration_ = var_333_5 + 0
					end

					if var_333_1.prefab_name ~= "" and arg_330_1.actors_[var_333_1.prefab_name] ~= nil then
						local var_333_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_330_1.actors_[var_333_1.prefab_name].transform, "story_v_out_319801", "319801076", "story_v_out_319801.awb")

						arg_330_1:RecordAudio("319801076", var_333_6)
						arg_330_1:RecordAudio("319801076", var_333_6)
					else
						arg_330_1:AudioAction("play", "voice", "story_v_out_319801", "319801076", "story_v_out_319801.awb")
					end

					arg_330_1:RecordHistoryTalkVoice("story_v_out_319801", "319801076", "story_v_out_319801.awb")
				end

				arg_330_1:RecordContent(arg_330_1.text_.text)
			end

			local var_333_7 = math.max(var_333_0, arg_330_1.talkMaxDuration)

			if 0 <= arg_330_1.time_ and arg_330_1.time_ < 0 + var_333_7 then
				arg_330_1.typewritter.percent = (arg_330_1.time_ - 0) / var_333_7

				arg_330_1.typewritter:SetDirty()
			end

			if arg_330_1.time_ >= 0 + var_333_7 and arg_330_1.time_ < 0 + var_333_7 + arg_333_0 then
				arg_330_1.typewritter.percent = 1

				arg_330_1.typewritter:SetDirty()
				arg_330_1:ShowNextGo(true)
			end
		end

		arg_330_1.nodeConfigList_ = {}

		arg_330_1:InitPlayNodeList()
	end,
	Play319801077 = function(arg_334_0, arg_334_1)
		arg_334_1.time_ = 0
		arg_334_1.frameCnt_ = 0
		arg_334_1.state_ = "playing"
		arg_334_1.curTalkId_ = 319801077
		arg_334_1.duration_ = 5.57

		local var_334_0 = {
			zh = 3.8,
			ja = 5.566
		}
		local var_334_1 = manager.audio:GetLocalizationFlag()

		if var_334_0[var_334_1] ~= nil then
			arg_334_1.duration_ = var_334_0[var_334_1]
		end

		SetActive(arg_334_1.tipsGo_, false)

		function arg_334_1.onSingleLineFinish_()
			arg_334_1.onSingleLineUpdate_ = nil
			arg_334_1.onSingleLineFinish_ = nil
			arg_334_1.state_ = "waiting"
		end

		function arg_334_1.playNext_(arg_336_0)
			if arg_336_0 == 1 then
				arg_334_0:Play319801078(arg_334_1)
			end
		end

		function arg_334_1.onSingleLineUpdate_(arg_337_0)
			local var_337_0 = 0.425

			if 0 < arg_334_1.time_ and arg_334_1.time_ <= 0 + arg_337_0 then
				arg_334_1.talkMaxDuration = 0
				arg_334_1.dialogCg_.alpha = 1

				arg_334_1.dialog_:SetActive(true)
				SetActive(arg_334_1.leftNameGo_, true)

				arg_334_1.leftNameTxt_.text = arg_334_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_334_1.leftNameTxt_.transform)

				arg_334_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_334_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_334_1:RecordName(arg_334_1.leftNameTxt_.text)
				SetActive(arg_334_1.iconTrs_.gameObject, false)
				arg_334_1.callingController_:SetSelectedState("normal")

				local var_337_1 = arg_334_1:GetWordFromCfg(319801077)
				local var_337_2 = arg_334_1:FormatText(var_337_1.content)

				arg_334_1.text_.text = var_337_2

				LuaForUtil.ClearLinePrefixSymbol(arg_334_1.text_)

				local var_337_4 = 17 <= 0 and var_337_0 or var_337_0 * (utf8.len(var_337_2) / 17)

				if (17 <= 0 and var_337_0 or var_337_0 * (utf8.len(var_337_2) / 17)) > 0 and var_337_0 < var_337_4 then
					arg_334_1.talkMaxDuration = var_337_4

					if var_337_4 + 0 > arg_334_1.duration_ then
						arg_334_1.duration_ = var_337_4 + 0
					end
				end

				arg_334_1.text_.text = var_337_2
				arg_334_1.typewritter.percent = 0

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319801", "319801077", "story_v_out_319801.awb") ~= 0 then
					local var_337_5 = manager.audio:GetVoiceLength("story_v_out_319801", "319801077", "story_v_out_319801.awb") / 1000

					if var_337_5 + 0 > arg_334_1.duration_ then
						arg_334_1.duration_ = var_337_5 + 0
					end

					if var_337_1.prefab_name ~= "" and arg_334_1.actors_[var_337_1.prefab_name] ~= nil then
						local var_337_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_334_1.actors_[var_337_1.prefab_name].transform, "story_v_out_319801", "319801077", "story_v_out_319801.awb")

						arg_334_1:RecordAudio("319801077", var_337_6)
						arg_334_1:RecordAudio("319801077", var_337_6)
					else
						arg_334_1:AudioAction("play", "voice", "story_v_out_319801", "319801077", "story_v_out_319801.awb")
					end

					arg_334_1:RecordHistoryTalkVoice("story_v_out_319801", "319801077", "story_v_out_319801.awb")
				end

				arg_334_1:RecordContent(arg_334_1.text_.text)
			end

			local var_337_7 = math.max(var_337_0, arg_334_1.talkMaxDuration)

			if 0 <= arg_334_1.time_ and arg_334_1.time_ < 0 + var_337_7 then
				arg_334_1.typewritter.percent = (arg_334_1.time_ - 0) / var_337_7

				arg_334_1.typewritter:SetDirty()
			end

			if arg_334_1.time_ >= 0 + var_337_7 and arg_334_1.time_ < 0 + var_337_7 + arg_337_0 then
				arg_334_1.typewritter.percent = 1

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(true)
			end
		end

		arg_334_1.nodeConfigList_ = {}

		arg_334_1:InitPlayNodeList()
	end,
	Play319801078 = function(arg_338_0, arg_338_1)
		arg_338_1.time_ = 0
		arg_338_1.frameCnt_ = 0
		arg_338_1.state_ = "playing"
		arg_338_1.curTalkId_ = 319801078
		arg_338_1.duration_ = 5

		SetActive(arg_338_1.tipsGo_, false)

		function arg_338_1.onSingleLineFinish_()
			arg_338_1.onSingleLineUpdate_ = nil
			arg_338_1.onSingleLineFinish_ = nil
			arg_338_1.state_ = "waiting"
		end

		function arg_338_1.playNext_(arg_340_0)
			if arg_340_0 == 1 then
				arg_338_0:Play319801079(arg_338_1)
			end
		end

		function arg_338_1.onSingleLineUpdate_(arg_341_0)
			local var_341_0 = 0.05

			if 0 < arg_338_1.time_ and arg_338_1.time_ <= 0 + arg_341_0 then
				arg_338_1.talkMaxDuration = 0
				arg_338_1.dialogCg_.alpha = 1

				arg_338_1.dialog_:SetActive(true)
				SetActive(arg_338_1.leftNameGo_, true)

				arg_338_1.leftNameTxt_.text = arg_338_1:FormatText(StoryNameCfg[698].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_338_1.leftNameTxt_.transform)

				arg_338_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_338_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_338_1:RecordName(arg_338_1.leftNameTxt_.text)
				SetActive(arg_338_1.iconTrs_.gameObject, false)
				arg_338_1.callingController_:SetSelectedState("normal")

				local var_341_1 = arg_338_1:FormatText(arg_338_1:GetWordFromCfg(319801078).content)

				arg_338_1.text_.text = var_341_1

				LuaForUtil.ClearLinePrefixSymbol(arg_338_1.text_)

				local var_341_3 = 2 <= 0 and var_341_0 or var_341_0 * (utf8.len(var_341_1) / 2)

				if (2 <= 0 and var_341_0 or var_341_0 * (utf8.len(var_341_1) / 2)) > 0 and var_341_0 < var_341_3 then
					arg_338_1.talkMaxDuration = var_341_3

					if var_341_3 + 0 > arg_338_1.duration_ then
						arg_338_1.duration_ = var_341_3 + 0
					end
				end

				arg_338_1.text_.text = var_341_1
				arg_338_1.typewritter.percent = 0

				arg_338_1.typewritter:SetDirty()
				arg_338_1:ShowNextGo(false)
				arg_338_1:RecordContent(arg_338_1.text_.text)
			end

			local var_341_4 = math.max(var_341_0, arg_338_1.talkMaxDuration)

			if 0 <= arg_338_1.time_ and arg_338_1.time_ < 0 + var_341_4 then
				arg_338_1.typewritter.percent = (arg_338_1.time_ - 0) / var_341_4

				arg_338_1.typewritter:SetDirty()
			end

			if arg_338_1.time_ >= 0 + var_341_4 and arg_338_1.time_ < 0 + var_341_4 + arg_341_0 then
				arg_338_1.typewritter.percent = 1

				arg_338_1.typewritter:SetDirty()
				arg_338_1:ShowNextGo(true)
			end
		end

		arg_338_1.nodeConfigList_ = {}

		arg_338_1:InitPlayNodeList()
	end,
	Play319801079 = function(arg_342_0, arg_342_1)
		arg_342_1.time_ = 0
		arg_342_1.frameCnt_ = 0
		arg_342_1.state_ = "playing"
		arg_342_1.curTalkId_ = 319801079
		arg_342_1.duration_ = 4.37

		local var_342_0 = {
			zh = 4.366,
			ja = 3.3
		}
		local var_342_1 = manager.audio:GetLocalizationFlag()

		if var_342_0[var_342_1] ~= nil then
			arg_342_1.duration_ = var_342_0[var_342_1]
		end

		SetActive(arg_342_1.tipsGo_, false)

		function arg_342_1.onSingleLineFinish_()
			arg_342_1.onSingleLineUpdate_ = nil
			arg_342_1.onSingleLineFinish_ = nil
			arg_342_1.state_ = "waiting"
		end

		function arg_342_1.playNext_(arg_344_0)
			if arg_344_0 == 1 then
				arg_342_0:Play319801080(arg_342_1)
			end
		end

		function arg_342_1.onSingleLineUpdate_(arg_345_0)
			local var_345_0 = 0.325

			if 0 < arg_342_1.time_ and arg_342_1.time_ <= 0 + arg_345_0 then
				arg_342_1.talkMaxDuration = 0
				arg_342_1.dialogCg_.alpha = 1

				arg_342_1.dialog_:SetActive(true)
				SetActive(arg_342_1.leftNameGo_, true)

				arg_342_1.leftNameTxt_.text = arg_342_1:FormatText(StoryNameCfg[640].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_342_1.leftNameTxt_.transform)

				arg_342_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_342_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_342_1:RecordName(arg_342_1.leftNameTxt_.text)
				SetActive(arg_342_1.iconTrs_.gameObject, false)
				arg_342_1.callingController_:SetSelectedState("normal")

				local var_345_1 = arg_342_1:GetWordFromCfg(319801079)
				local var_345_2 = arg_342_1:FormatText(var_345_1.content)

				arg_342_1.text_.text = var_345_2

				LuaForUtil.ClearLinePrefixSymbol(arg_342_1.text_)

				local var_345_4 = 13 <= 0 and var_345_0 or var_345_0 * (utf8.len(var_345_2) / 13)

				if (13 <= 0 and var_345_0 or var_345_0 * (utf8.len(var_345_2) / 13)) > 0 and var_345_0 < var_345_4 then
					arg_342_1.talkMaxDuration = var_345_4

					if var_345_4 + 0 > arg_342_1.duration_ then
						arg_342_1.duration_ = var_345_4 + 0
					end
				end

				arg_342_1.text_.text = var_345_2
				arg_342_1.typewritter.percent = 0

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319801", "319801079", "story_v_out_319801.awb") ~= 0 then
					local var_345_5 = manager.audio:GetVoiceLength("story_v_out_319801", "319801079", "story_v_out_319801.awb") / 1000

					if var_345_5 + 0 > arg_342_1.duration_ then
						arg_342_1.duration_ = var_345_5 + 0
					end

					if var_345_1.prefab_name ~= "" and arg_342_1.actors_[var_345_1.prefab_name] ~= nil then
						local var_345_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_342_1.actors_[var_345_1.prefab_name].transform, "story_v_out_319801", "319801079", "story_v_out_319801.awb")

						arg_342_1:RecordAudio("319801079", var_345_6)
						arg_342_1:RecordAudio("319801079", var_345_6)
					else
						arg_342_1:AudioAction("play", "voice", "story_v_out_319801", "319801079", "story_v_out_319801.awb")
					end

					arg_342_1:RecordHistoryTalkVoice("story_v_out_319801", "319801079", "story_v_out_319801.awb")
				end

				arg_342_1:RecordContent(arg_342_1.text_.text)
			end

			local var_345_7 = math.max(var_345_0, arg_342_1.talkMaxDuration)

			if 0 <= arg_342_1.time_ and arg_342_1.time_ < 0 + var_345_7 then
				arg_342_1.typewritter.percent = (arg_342_1.time_ - 0) / var_345_7

				arg_342_1.typewritter:SetDirty()
			end

			if arg_342_1.time_ >= 0 + var_345_7 and arg_342_1.time_ < 0 + var_345_7 + arg_345_0 then
				arg_342_1.typewritter.percent = 1

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(true)
			end
		end

		arg_342_1.nodeConfigList_ = {}

		arg_342_1:InitPlayNodeList()
	end,
	Play319801080 = function(arg_346_0, arg_346_1)
		arg_346_1.time_ = 0
		arg_346_1.frameCnt_ = 0
		arg_346_1.state_ = "playing"
		arg_346_1.curTalkId_ = 319801080
		arg_346_1.duration_ = 6.37

		local var_346_0 = {
			zh = 5.53333333333333,
			ja = 6.36633333333333
		}
		local var_346_1 = manager.audio:GetLocalizationFlag()

		if var_346_0[var_346_1] ~= nil then
			arg_346_1.duration_ = var_346_0[var_346_1]
		end

		SetActive(arg_346_1.tipsGo_, false)

		function arg_346_1.onSingleLineFinish_()
			arg_346_1.onSingleLineUpdate_ = nil
			arg_346_1.onSingleLineFinish_ = nil
			arg_346_1.state_ = "waiting"
		end

		function arg_346_1.playNext_(arg_348_0)
			if arg_348_0 == 1 then
				arg_346_0:Play319801081(arg_346_1)
			end
		end

		function arg_346_1.onSingleLineUpdate_(arg_349_0)
			if 0 < arg_346_1.time_ and arg_346_1.time_ <= 0 + arg_349_0 then
				arg_346_1.var_.moveOldPosML0204 = arg_346_1.bgs_.ML0204.transform.localPosition
			end

			local var_349_0 = 0.001

			if 0 <= arg_346_1.time_ and arg_346_1.time_ < 0 + var_349_0 then
				arg_346_1.bgs_.ML0204.transform.localPosition = Vector3.Lerp(arg_346_1.var_.moveOldPosML0204, Vector3.New(0, 1, 10), (arg_346_1.time_ - 0) / var_349_0)
			end

			if arg_346_1.time_ >= 0 + var_349_0 and arg_346_1.time_ < 0 + var_349_0 + arg_349_0 then
				arg_346_1.bgs_.ML0204.transform.localPosition = Vector3.New(0, 1, 10)
			end

			local var_349_1 = arg_346_1.bgs_.ML0204.transform

			if 0.034 < arg_346_1.time_ and arg_346_1.time_ <= 0.034 + arg_349_0 then
				arg_346_1.var_.moveOldPosML0204 = var_349_1.localPosition
			end

			local var_349_2 = 3.266

			if 0.034 <= arg_346_1.time_ and arg_346_1.time_ < 0.034 + var_349_2 then
				var_349_1.localPosition = Vector3.Lerp(arg_346_1.var_.moveOldPosML0204, Vector3.New(0, 0.41, 7.27), (arg_346_1.time_ - 0.034) / var_349_2)
			end

			if arg_346_1.time_ >= 0.034 + var_349_2 and arg_346_1.time_ < 0.034 + var_349_2 + arg_349_0 then
				var_349_1.localPosition = Vector3.New(0, 0.41, 7.27)
			end

			local var_349_3 = 0

			if 0 < arg_346_1.time_ and arg_346_1.time_ <= var_349_3 + arg_349_0 then
				arg_346_1.allBtn_.enabled = false
			end

			if arg_346_1.time_ >= var_349_3 + 3.3 and arg_346_1.time_ < var_349_3 + 3.3 + arg_349_0 then
				arg_346_1.allBtn_.enabled = true
			end

			if arg_346_1.frameCnt_ <= 1 then
				arg_346_1.dialog_:SetActive(false)
			end

			local var_349_4 = 1.13333333333333
			local var_349_5 = 0.275

			if 1.13333333333333 < arg_346_1.time_ and arg_346_1.time_ <= var_349_4 + arg_349_0 then
				arg_346_1.talkMaxDuration = 0

				arg_346_1.dialog_:SetActive(true)

				arg_346_1.dialogCg_.alpha = 0

				local var_349_6 = LeanTween.value(arg_346_1.dialog_, 0, 1, 0.3)

				var_349_6:setOnUpdate(LuaHelper.FloatAction(function(arg_350_0)
					arg_346_1.dialogCg_.alpha = arg_350_0
				end))
				var_349_6:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_346_1.dialog_)
					var_349_6:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_346_1.duration_ = arg_346_1.duration_ + 0.3

				SetActive(arg_346_1.leftNameGo_, true)

				arg_346_1.leftNameTxt_.text = arg_346_1:FormatText(StoryNameCfg[640].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_346_1.leftNameTxt_.transform)

				arg_346_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_346_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_346_1:RecordName(arg_346_1.leftNameTxt_.text)
				SetActive(arg_346_1.iconTrs_.gameObject, false)
				arg_346_1.callingController_:SetSelectedState("normal")

				local var_349_7 = arg_346_1:GetWordFromCfg(319801080)
				local var_349_8 = arg_346_1:FormatText(var_349_7.content)

				arg_346_1.text_.text = var_349_8

				LuaForUtil.ClearLinePrefixSymbol(arg_346_1.text_)

				local var_349_10 = 11 <= 0 and var_349_5 or var_349_5 * (utf8.len(var_349_8) / 11)

				if (11 <= 0 and var_349_5 or var_349_5 * (utf8.len(var_349_8) / 11)) > 0 and var_349_5 < var_349_10 then
					arg_346_1.talkMaxDuration = var_349_10
					var_349_4 = var_349_4 + 0.3

					if var_349_10 + var_349_4 > arg_346_1.duration_ then
						arg_346_1.duration_ = var_349_10 + var_349_4
					end
				end

				arg_346_1.text_.text = var_349_8
				arg_346_1.typewritter.percent = 0

				arg_346_1.typewritter:SetDirty()
				arg_346_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319801", "319801080", "story_v_out_319801.awb") ~= 0 then
					local var_349_11 = manager.audio:GetVoiceLength("story_v_out_319801", "319801080", "story_v_out_319801.awb") / 1000

					if var_349_11 + var_349_4 > arg_346_1.duration_ then
						arg_346_1.duration_ = var_349_11 + var_349_4
					end

					if var_349_7.prefab_name ~= "" and arg_346_1.actors_[var_349_7.prefab_name] ~= nil then
						local var_349_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_346_1.actors_[var_349_7.prefab_name].transform, "story_v_out_319801", "319801080", "story_v_out_319801.awb")

						arg_346_1:RecordAudio("319801080", var_349_12)
						arg_346_1:RecordAudio("319801080", var_349_12)
					else
						arg_346_1:AudioAction("play", "voice", "story_v_out_319801", "319801080", "story_v_out_319801.awb")
					end

					arg_346_1:RecordHistoryTalkVoice("story_v_out_319801", "319801080", "story_v_out_319801.awb")
				end

				arg_346_1:RecordContent(arg_346_1.text_.text)
			end

			local var_349_13 = var_349_4 + 0.3
			local var_349_14 = math.max(var_349_5, arg_346_1.talkMaxDuration)

			if var_349_4 + 0.3 <= arg_346_1.time_ and arg_346_1.time_ < var_349_13 + var_349_14 then
				arg_346_1.typewritter.percent = (arg_346_1.time_ - var_349_13) / var_349_14

				arg_346_1.typewritter:SetDirty()
			end

			if arg_346_1.time_ >= var_349_13 + var_349_14 and arg_346_1.time_ < var_349_13 + var_349_14 + arg_349_0 then
				arg_346_1.typewritter.percent = 1

				arg_346_1.typewritter:SetDirty()
				arg_346_1:ShowNextGo(true)
			end
		end

		arg_346_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "ML0204",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "ML0204",
				changeDisplayLayer = false,
				needEase = false,
				duration = 3.266,
				className = "StoryMoveNode",
				startTime = 0.034,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_346_1:InitPlayNodeList()
	end,
	Play319801081 = function(arg_352_0, arg_352_1)
		arg_352_1.time_ = 0
		arg_352_1.frameCnt_ = 0
		arg_352_1.state_ = "playing"
		arg_352_1.curTalkId_ = 319801081
		arg_352_1.duration_ = 2

		local var_352_0 = {
			zh = 2,
			ja = 1.3
		}
		local var_352_1 = manager.audio:GetLocalizationFlag()

		if var_352_0[var_352_1] ~= nil then
			arg_352_1.duration_ = var_352_0[var_352_1]
		end

		SetActive(arg_352_1.tipsGo_, false)

		function arg_352_1.onSingleLineFinish_()
			arg_352_1.onSingleLineUpdate_ = nil
			arg_352_1.onSingleLineFinish_ = nil
			arg_352_1.state_ = "waiting"
		end

		function arg_352_1.playNext_(arg_354_0)
			if arg_354_0 == 1 then
				arg_352_0:Play319801082(arg_352_1)
			end
		end

		function arg_352_1.onSingleLineUpdate_(arg_355_0)
			local var_355_0 = 0.05

			if 0 < arg_352_1.time_ and arg_352_1.time_ <= 0 + arg_355_0 then
				arg_352_1.talkMaxDuration = 0
				arg_352_1.dialogCg_.alpha = 1

				arg_352_1.dialog_:SetActive(true)
				SetActive(arg_352_1.leftNameGo_, true)

				arg_352_1.leftNameTxt_.text = arg_352_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_352_1.leftNameTxt_.transform)

				arg_352_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_352_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_352_1:RecordName(arg_352_1.leftNameTxt_.text)
				SetActive(arg_352_1.iconTrs_.gameObject, false)
				arg_352_1.callingController_:SetSelectedState("normal")

				local var_355_1 = arg_352_1:GetWordFromCfg(319801081)
				local var_355_2 = arg_352_1:FormatText(var_355_1.content)

				arg_352_1.text_.text = var_355_2

				LuaForUtil.ClearLinePrefixSymbol(arg_352_1.text_)

				local var_355_4 = 2 <= 0 and var_355_0 or var_355_0 * (utf8.len(var_355_2) / 2)

				if (2 <= 0 and var_355_0 or var_355_0 * (utf8.len(var_355_2) / 2)) > 0 and var_355_0 < var_355_4 then
					arg_352_1.talkMaxDuration = var_355_4

					if var_355_4 + 0 > arg_352_1.duration_ then
						arg_352_1.duration_ = var_355_4 + 0
					end
				end

				arg_352_1.text_.text = var_355_2
				arg_352_1.typewritter.percent = 0

				arg_352_1.typewritter:SetDirty()
				arg_352_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319801", "319801081", "story_v_out_319801.awb") ~= 0 then
					local var_355_5 = manager.audio:GetVoiceLength("story_v_out_319801", "319801081", "story_v_out_319801.awb") / 1000

					if var_355_5 + 0 > arg_352_1.duration_ then
						arg_352_1.duration_ = var_355_5 + 0
					end

					if var_355_1.prefab_name ~= "" and arg_352_1.actors_[var_355_1.prefab_name] ~= nil then
						local var_355_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_352_1.actors_[var_355_1.prefab_name].transform, "story_v_out_319801", "319801081", "story_v_out_319801.awb")

						arg_352_1:RecordAudio("319801081", var_355_6)
						arg_352_1:RecordAudio("319801081", var_355_6)
					else
						arg_352_1:AudioAction("play", "voice", "story_v_out_319801", "319801081", "story_v_out_319801.awb")
					end

					arg_352_1:RecordHistoryTalkVoice("story_v_out_319801", "319801081", "story_v_out_319801.awb")
				end

				arg_352_1:RecordContent(arg_352_1.text_.text)
			end

			local var_355_7 = math.max(var_355_0, arg_352_1.talkMaxDuration)

			if 0 <= arg_352_1.time_ and arg_352_1.time_ < 0 + var_355_7 then
				arg_352_1.typewritter.percent = (arg_352_1.time_ - 0) / var_355_7

				arg_352_1.typewritter:SetDirty()
			end

			if arg_352_1.time_ >= 0 + var_355_7 and arg_352_1.time_ < 0 + var_355_7 + arg_355_0 then
				arg_352_1.typewritter.percent = 1

				arg_352_1.typewritter:SetDirty()
				arg_352_1:ShowNextGo(true)
			end
		end

		arg_352_1.nodeConfigList_ = {}

		arg_352_1:InitPlayNodeList()
	end,
	Play319801082 = function(arg_356_0, arg_356_1)
		arg_356_1.time_ = 0
		arg_356_1.frameCnt_ = 0
		arg_356_1.state_ = "playing"
		arg_356_1.curTalkId_ = 319801082
		arg_356_1.duration_ = 6.53

		local var_356_0 = {
			zh = 3.533,
			ja = 6.533
		}
		local var_356_1 = manager.audio:GetLocalizationFlag()

		if var_356_0[var_356_1] ~= nil then
			arg_356_1.duration_ = var_356_0[var_356_1]
		end

		SetActive(arg_356_1.tipsGo_, false)

		function arg_356_1.onSingleLineFinish_()
			arg_356_1.onSingleLineUpdate_ = nil
			arg_356_1.onSingleLineFinish_ = nil
			arg_356_1.state_ = "waiting"
		end

		function arg_356_1.playNext_(arg_358_0)
			if arg_358_0 == 1 then
				arg_356_0:Play319801083(arg_356_1)
			end
		end

		function arg_356_1.onSingleLineUpdate_(arg_359_0)
			local var_359_0 = 0.225

			if 0 < arg_356_1.time_ and arg_356_1.time_ <= 0 + arg_359_0 then
				arg_356_1.talkMaxDuration = 0
				arg_356_1.dialogCg_.alpha = 1

				arg_356_1.dialog_:SetActive(true)
				SetActive(arg_356_1.leftNameGo_, true)

				arg_356_1.leftNameTxt_.text = arg_356_1:FormatText(StoryNameCfg[640].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_356_1.leftNameTxt_.transform)

				arg_356_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_356_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_356_1:RecordName(arg_356_1.leftNameTxt_.text)
				SetActive(arg_356_1.iconTrs_.gameObject, false)
				arg_356_1.callingController_:SetSelectedState("normal")

				local var_359_1 = arg_356_1:GetWordFromCfg(319801082)
				local var_359_2 = arg_356_1:FormatText(var_359_1.content)

				arg_356_1.text_.text = var_359_2

				LuaForUtil.ClearLinePrefixSymbol(arg_356_1.text_)

				local var_359_4 = 9 <= 0 and var_359_0 or var_359_0 * (utf8.len(var_359_2) / 9)

				if (9 <= 0 and var_359_0 or var_359_0 * (utf8.len(var_359_2) / 9)) > 0 and var_359_0 < var_359_4 then
					arg_356_1.talkMaxDuration = var_359_4

					if var_359_4 + 0 > arg_356_1.duration_ then
						arg_356_1.duration_ = var_359_4 + 0
					end
				end

				arg_356_1.text_.text = var_359_2
				arg_356_1.typewritter.percent = 0

				arg_356_1.typewritter:SetDirty()
				arg_356_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319801", "319801082", "story_v_out_319801.awb") ~= 0 then
					local var_359_5 = manager.audio:GetVoiceLength("story_v_out_319801", "319801082", "story_v_out_319801.awb") / 1000

					if var_359_5 + 0 > arg_356_1.duration_ then
						arg_356_1.duration_ = var_359_5 + 0
					end

					if var_359_1.prefab_name ~= "" and arg_356_1.actors_[var_359_1.prefab_name] ~= nil then
						local var_359_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_356_1.actors_[var_359_1.prefab_name].transform, "story_v_out_319801", "319801082", "story_v_out_319801.awb")

						arg_356_1:RecordAudio("319801082", var_359_6)
						arg_356_1:RecordAudio("319801082", var_359_6)
					else
						arg_356_1:AudioAction("play", "voice", "story_v_out_319801", "319801082", "story_v_out_319801.awb")
					end

					arg_356_1:RecordHistoryTalkVoice("story_v_out_319801", "319801082", "story_v_out_319801.awb")
				end

				arg_356_1:RecordContent(arg_356_1.text_.text)
			end

			local var_359_7 = math.max(var_359_0, arg_356_1.talkMaxDuration)

			if 0 <= arg_356_1.time_ and arg_356_1.time_ < 0 + var_359_7 then
				arg_356_1.typewritter.percent = (arg_356_1.time_ - 0) / var_359_7

				arg_356_1.typewritter:SetDirty()
			end

			if arg_356_1.time_ >= 0 + var_359_7 and arg_356_1.time_ < 0 + var_359_7 + arg_359_0 then
				arg_356_1.typewritter.percent = 1

				arg_356_1.typewritter:SetDirty()
				arg_356_1:ShowNextGo(true)
			end
		end

		arg_356_1.nodeConfigList_ = {}

		arg_356_1:InitPlayNodeList()
	end,
	Play319801083 = function(arg_360_0, arg_360_1)
		arg_360_1.time_ = 0
		arg_360_1.frameCnt_ = 0
		arg_360_1.state_ = "playing"
		arg_360_1.curTalkId_ = 319801083
		arg_360_1.duration_ = 7.33

		local var_360_0 = {
			zh = 5.366,
			ja = 7.333
		}
		local var_360_1 = manager.audio:GetLocalizationFlag()

		if var_360_0[var_360_1] ~= nil then
			arg_360_1.duration_ = var_360_0[var_360_1]
		end

		SetActive(arg_360_1.tipsGo_, false)

		function arg_360_1.onSingleLineFinish_()
			arg_360_1.onSingleLineUpdate_ = nil
			arg_360_1.onSingleLineFinish_ = nil
			arg_360_1.state_ = "waiting"
		end

		function arg_360_1.playNext_(arg_362_0)
			if arg_362_0 == 1 then
				arg_360_0:Play319801084(arg_360_1)
			end
		end

		function arg_360_1.onSingleLineUpdate_(arg_363_0)
			local var_363_0 = 0.4

			if 0 < arg_360_1.time_ and arg_360_1.time_ <= 0 + arg_363_0 then
				arg_360_1.talkMaxDuration = 0
				arg_360_1.dialogCg_.alpha = 1

				arg_360_1.dialog_:SetActive(true)
				SetActive(arg_360_1.leftNameGo_, true)

				arg_360_1.leftNameTxt_.text = arg_360_1:FormatText(StoryNameCfg[640].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_360_1.leftNameTxt_.transform)

				arg_360_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_360_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_360_1:RecordName(arg_360_1.leftNameTxt_.text)
				SetActive(arg_360_1.iconTrs_.gameObject, false)
				arg_360_1.callingController_:SetSelectedState("normal")

				local var_363_1 = arg_360_1:GetWordFromCfg(319801083)
				local var_363_2 = arg_360_1:FormatText(var_363_1.content)

				arg_360_1.text_.text = var_363_2

				LuaForUtil.ClearLinePrefixSymbol(arg_360_1.text_)

				local var_363_4 = 16 <= 0 and var_363_0 or var_363_0 * (utf8.len(var_363_2) / 16)

				if (16 <= 0 and var_363_0 or var_363_0 * (utf8.len(var_363_2) / 16)) > 0 and var_363_0 < var_363_4 then
					arg_360_1.talkMaxDuration = var_363_4

					if var_363_4 + 0 > arg_360_1.duration_ then
						arg_360_1.duration_ = var_363_4 + 0
					end
				end

				arg_360_1.text_.text = var_363_2
				arg_360_1.typewritter.percent = 0

				arg_360_1.typewritter:SetDirty()
				arg_360_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319801", "319801083", "story_v_out_319801.awb") ~= 0 then
					local var_363_5 = manager.audio:GetVoiceLength("story_v_out_319801", "319801083", "story_v_out_319801.awb") / 1000

					if var_363_5 + 0 > arg_360_1.duration_ then
						arg_360_1.duration_ = var_363_5 + 0
					end

					if var_363_1.prefab_name ~= "" and arg_360_1.actors_[var_363_1.prefab_name] ~= nil then
						local var_363_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_360_1.actors_[var_363_1.prefab_name].transform, "story_v_out_319801", "319801083", "story_v_out_319801.awb")

						arg_360_1:RecordAudio("319801083", var_363_6)
						arg_360_1:RecordAudio("319801083", var_363_6)
					else
						arg_360_1:AudioAction("play", "voice", "story_v_out_319801", "319801083", "story_v_out_319801.awb")
					end

					arg_360_1:RecordHistoryTalkVoice("story_v_out_319801", "319801083", "story_v_out_319801.awb")
				end

				arg_360_1:RecordContent(arg_360_1.text_.text)
			end

			local var_363_7 = math.max(var_363_0, arg_360_1.talkMaxDuration)

			if 0 <= arg_360_1.time_ and arg_360_1.time_ < 0 + var_363_7 then
				arg_360_1.typewritter.percent = (arg_360_1.time_ - 0) / var_363_7

				arg_360_1.typewritter:SetDirty()
			end

			if arg_360_1.time_ >= 0 + var_363_7 and arg_360_1.time_ < 0 + var_363_7 + arg_363_0 then
				arg_360_1.typewritter.percent = 1

				arg_360_1.typewritter:SetDirty()
				arg_360_1:ShowNextGo(true)
			end
		end

		arg_360_1.nodeConfigList_ = {}

		arg_360_1:InitPlayNodeList()
	end,
	Play319801084 = function(arg_364_0, arg_364_1)
		arg_364_1.time_ = 0
		arg_364_1.frameCnt_ = 0
		arg_364_1.state_ = "playing"
		arg_364_1.curTalkId_ = 319801084
		arg_364_1.duration_ = 4.07

		local var_364_0 = {
			zh = 3.033,
			ja = 4.066
		}
		local var_364_1 = manager.audio:GetLocalizationFlag()

		if var_364_0[var_364_1] ~= nil then
			arg_364_1.duration_ = var_364_0[var_364_1]
		end

		SetActive(arg_364_1.tipsGo_, false)

		function arg_364_1.onSingleLineFinish_()
			arg_364_1.onSingleLineUpdate_ = nil
			arg_364_1.onSingleLineFinish_ = nil
			arg_364_1.state_ = "waiting"
		end

		function arg_364_1.playNext_(arg_366_0)
			if arg_366_0 == 1 then
				arg_364_0:Play319801085(arg_364_1)
			end
		end

		function arg_364_1.onSingleLineUpdate_(arg_367_0)
			local var_367_0 = 0.275

			if 0 < arg_364_1.time_ and arg_364_1.time_ <= 0 + arg_367_0 then
				arg_364_1.talkMaxDuration = 0
				arg_364_1.dialogCg_.alpha = 1

				arg_364_1.dialog_:SetActive(true)
				SetActive(arg_364_1.leftNameGo_, true)

				arg_364_1.leftNameTxt_.text = arg_364_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_364_1.leftNameTxt_.transform)

				arg_364_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_364_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_364_1:RecordName(arg_364_1.leftNameTxt_.text)
				SetActive(arg_364_1.iconTrs_.gameObject, false)
				arg_364_1.callingController_:SetSelectedState("normal")

				local var_367_1 = arg_364_1:GetWordFromCfg(319801084)
				local var_367_2 = arg_364_1:FormatText(var_367_1.content)

				arg_364_1.text_.text = var_367_2

				LuaForUtil.ClearLinePrefixSymbol(arg_364_1.text_)

				local var_367_4 = 11 <= 0 and var_367_0 or var_367_0 * (utf8.len(var_367_2) / 11)

				if (11 <= 0 and var_367_0 or var_367_0 * (utf8.len(var_367_2) / 11)) > 0 and var_367_0 < var_367_4 then
					arg_364_1.talkMaxDuration = var_367_4

					if var_367_4 + 0 > arg_364_1.duration_ then
						arg_364_1.duration_ = var_367_4 + 0
					end
				end

				arg_364_1.text_.text = var_367_2
				arg_364_1.typewritter.percent = 0

				arg_364_1.typewritter:SetDirty()
				arg_364_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319801", "319801084", "story_v_out_319801.awb") ~= 0 then
					local var_367_5 = manager.audio:GetVoiceLength("story_v_out_319801", "319801084", "story_v_out_319801.awb") / 1000

					if var_367_5 + 0 > arg_364_1.duration_ then
						arg_364_1.duration_ = var_367_5 + 0
					end

					if var_367_1.prefab_name ~= "" and arg_364_1.actors_[var_367_1.prefab_name] ~= nil then
						local var_367_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_364_1.actors_[var_367_1.prefab_name].transform, "story_v_out_319801", "319801084", "story_v_out_319801.awb")

						arg_364_1:RecordAudio("319801084", var_367_6)
						arg_364_1:RecordAudio("319801084", var_367_6)
					else
						arg_364_1:AudioAction("play", "voice", "story_v_out_319801", "319801084", "story_v_out_319801.awb")
					end

					arg_364_1:RecordHistoryTalkVoice("story_v_out_319801", "319801084", "story_v_out_319801.awb")
				end

				arg_364_1:RecordContent(arg_364_1.text_.text)
			end

			local var_367_7 = math.max(var_367_0, arg_364_1.talkMaxDuration)

			if 0 <= arg_364_1.time_ and arg_364_1.time_ < 0 + var_367_7 then
				arg_364_1.typewritter.percent = (arg_364_1.time_ - 0) / var_367_7

				arg_364_1.typewritter:SetDirty()
			end

			if arg_364_1.time_ >= 0 + var_367_7 and arg_364_1.time_ < 0 + var_367_7 + arg_367_0 then
				arg_364_1.typewritter.percent = 1

				arg_364_1.typewritter:SetDirty()
				arg_364_1:ShowNextGo(true)
			end
		end

		arg_364_1.nodeConfigList_ = {}

		arg_364_1:InitPlayNodeList()
	end,
	Play319801085 = function(arg_368_0, arg_368_1)
		arg_368_1.time_ = 0
		arg_368_1.frameCnt_ = 0
		arg_368_1.state_ = "playing"
		arg_368_1.curTalkId_ = 319801085
		arg_368_1.duration_ = 7.73

		local var_368_0 = {
			zh = 4.9,
			ja = 7.733
		}
		local var_368_1 = manager.audio:GetLocalizationFlag()

		if var_368_0[var_368_1] ~= nil then
			arg_368_1.duration_ = var_368_0[var_368_1]
		end

		SetActive(arg_368_1.tipsGo_, false)

		function arg_368_1.onSingleLineFinish_()
			arg_368_1.onSingleLineUpdate_ = nil
			arg_368_1.onSingleLineFinish_ = nil
			arg_368_1.state_ = "waiting"
		end

		function arg_368_1.playNext_(arg_370_0)
			if arg_370_0 == 1 then
				arg_368_0:Play319801086(arg_368_1)
			end
		end

		function arg_368_1.onSingleLineUpdate_(arg_371_0)
			local var_371_0 = 0.375

			if 0 < arg_368_1.time_ and arg_368_1.time_ <= 0 + arg_371_0 then
				arg_368_1.talkMaxDuration = 0
				arg_368_1.dialogCg_.alpha = 1

				arg_368_1.dialog_:SetActive(true)
				SetActive(arg_368_1.leftNameGo_, true)

				arg_368_1.leftNameTxt_.text = arg_368_1:FormatText(StoryNameCfg[640].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_368_1.leftNameTxt_.transform)

				arg_368_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_368_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_368_1:RecordName(arg_368_1.leftNameTxt_.text)
				SetActive(arg_368_1.iconTrs_.gameObject, false)
				arg_368_1.callingController_:SetSelectedState("normal")

				local var_371_1 = arg_368_1:GetWordFromCfg(319801085)
				local var_371_2 = arg_368_1:FormatText(var_371_1.content)

				arg_368_1.text_.text = var_371_2

				LuaForUtil.ClearLinePrefixSymbol(arg_368_1.text_)

				local var_371_4 = 15 <= 0 and var_371_0 or var_371_0 * (utf8.len(var_371_2) / 15)

				if (15 <= 0 and var_371_0 or var_371_0 * (utf8.len(var_371_2) / 15)) > 0 and var_371_0 < var_371_4 then
					arg_368_1.talkMaxDuration = var_371_4

					if var_371_4 + 0 > arg_368_1.duration_ then
						arg_368_1.duration_ = var_371_4 + 0
					end
				end

				arg_368_1.text_.text = var_371_2
				arg_368_1.typewritter.percent = 0

				arg_368_1.typewritter:SetDirty()
				arg_368_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319801", "319801085", "story_v_out_319801.awb") ~= 0 then
					local var_371_5 = manager.audio:GetVoiceLength("story_v_out_319801", "319801085", "story_v_out_319801.awb") / 1000

					if var_371_5 + 0 > arg_368_1.duration_ then
						arg_368_1.duration_ = var_371_5 + 0
					end

					if var_371_1.prefab_name ~= "" and arg_368_1.actors_[var_371_1.prefab_name] ~= nil then
						local var_371_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_368_1.actors_[var_371_1.prefab_name].transform, "story_v_out_319801", "319801085", "story_v_out_319801.awb")

						arg_368_1:RecordAudio("319801085", var_371_6)
						arg_368_1:RecordAudio("319801085", var_371_6)
					else
						arg_368_1:AudioAction("play", "voice", "story_v_out_319801", "319801085", "story_v_out_319801.awb")
					end

					arg_368_1:RecordHistoryTalkVoice("story_v_out_319801", "319801085", "story_v_out_319801.awb")
				end

				arg_368_1:RecordContent(arg_368_1.text_.text)
			end

			local var_371_7 = math.max(var_371_0, arg_368_1.talkMaxDuration)

			if 0 <= arg_368_1.time_ and arg_368_1.time_ < 0 + var_371_7 then
				arg_368_1.typewritter.percent = (arg_368_1.time_ - 0) / var_371_7

				arg_368_1.typewritter:SetDirty()
			end

			if arg_368_1.time_ >= 0 + var_371_7 and arg_368_1.time_ < 0 + var_371_7 + arg_371_0 then
				arg_368_1.typewritter.percent = 1

				arg_368_1.typewritter:SetDirty()
				arg_368_1:ShowNextGo(true)
			end
		end

		arg_368_1.nodeConfigList_ = {}

		arg_368_1:InitPlayNodeList()
	end,
	Play319801086 = function(arg_372_0, arg_372_1)
		arg_372_1.time_ = 0
		arg_372_1.frameCnt_ = 0
		arg_372_1.state_ = "playing"
		arg_372_1.curTalkId_ = 319801086
		arg_372_1.duration_ = 8.5

		local var_372_0 = {
			zh = 5.43333333333333,
			ja = 8.49933333333333
		}
		local var_372_1 = manager.audio:GetLocalizationFlag()

		if var_372_0[var_372_1] ~= nil then
			arg_372_1.duration_ = var_372_0[var_372_1]
		end

		SetActive(arg_372_1.tipsGo_, false)

		function arg_372_1.onSingleLineFinish_()
			arg_372_1.onSingleLineUpdate_ = nil
			arg_372_1.onSingleLineFinish_ = nil
			arg_372_1.state_ = "waiting"
		end

		function arg_372_1.playNext_(arg_374_0)
			if arg_374_0 == 1 then
				arg_372_0:Play319801087(arg_372_1)
			end
		end

		function arg_372_1.onSingleLineUpdate_(arg_375_0)
			if 0 < arg_372_1.time_ and arg_372_1.time_ <= 0 + arg_375_0 then
				arg_372_1.allBtn_.enabled = false
			end

			if arg_372_1.time_ >= 0 + 3.067333333332 and arg_372_1.time_ < 0 + 3.067333333332 + arg_375_0 then
				arg_372_1.allBtn_.enabled = true
			end

			local var_375_0 = arg_372_1.bgs_.ML0204.transform

			if 0 < arg_372_1.time_ and arg_372_1.time_ <= 0 + arg_375_0 then
				arg_372_1.var_.moveOldPosML0204 = var_375_0.localPosition
			end

			local var_375_1 = 0.001

			if 0 <= arg_372_1.time_ and arg_372_1.time_ < 0 + var_375_1 then
				var_375_0.localPosition = Vector3.Lerp(arg_372_1.var_.moveOldPosML0204, Vector3.New(0, 0.41, 7.27), (arg_372_1.time_ - 0) / var_375_1)
			end

			if arg_372_1.time_ >= 0 + var_375_1 and arg_372_1.time_ < 0 + var_375_1 + arg_375_0 then
				var_375_0.localPosition = Vector3.New(0, 0.41, 7.27)
			end

			local var_375_2 = arg_372_1.bgs_.ML0204.transform

			if 0.034 < arg_372_1.time_ and arg_372_1.time_ <= 0.034 + arg_375_0 then
				arg_372_1.var_.moveOldPosML0204 = var_375_2.localPosition
			end

			local var_375_3 = 2.79933333333333

			if 0.034 <= arg_372_1.time_ and arg_372_1.time_ < 0.034 + var_375_3 then
				var_375_2.localPosition = Vector3.Lerp(arg_372_1.var_.moveOldPosML0204, Vector3.New(0, 0.41, 5.53), (arg_372_1.time_ - 0.034) / var_375_3)
			end

			if arg_372_1.time_ >= 0.034 + var_375_3 and arg_372_1.time_ < 0.034 + var_375_3 + arg_375_0 then
				var_375_2.localPosition = Vector3.New(0, 0.41, 5.53)
			end

			if arg_372_1.frameCnt_ <= 1 then
				arg_372_1.dialog_:SetActive(false)
			end

			local var_375_4 = 1.23333333333333
			local var_375_5 = 0.3

			if 1.23333333333333 < arg_372_1.time_ and arg_372_1.time_ <= var_375_4 + arg_375_0 then
				arg_372_1.talkMaxDuration = 0

				arg_372_1.dialog_:SetActive(true)

				arg_372_1.dialogCg_.alpha = 0

				local var_375_6 = LeanTween.value(arg_372_1.dialog_, 0, 1, 0.3)

				var_375_6:setOnUpdate(LuaHelper.FloatAction(function(arg_376_0)
					arg_372_1.dialogCg_.alpha = arg_376_0
				end))
				var_375_6:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_372_1.dialog_)
					var_375_6:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_372_1.duration_ = arg_372_1.duration_ + 0.3

				SetActive(arg_372_1.leftNameGo_, true)

				arg_372_1.leftNameTxt_.text = arg_372_1:FormatText(StoryNameCfg[640].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_372_1.leftNameTxt_.transform)

				arg_372_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_372_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_372_1:RecordName(arg_372_1.leftNameTxt_.text)
				SetActive(arg_372_1.iconTrs_.gameObject, false)
				arg_372_1.callingController_:SetSelectedState("normal")

				local var_375_7 = arg_372_1:GetWordFromCfg(319801086)
				local var_375_8 = arg_372_1:FormatText(var_375_7.content)

				arg_372_1.text_.text = var_375_8

				LuaForUtil.ClearLinePrefixSymbol(arg_372_1.text_)

				local var_375_10 = 12 <= 0 and var_375_5 or var_375_5 * (utf8.len(var_375_8) / 12)

				if (12 <= 0 and var_375_5 or var_375_5 * (utf8.len(var_375_8) / 12)) > 0 and var_375_5 < var_375_10 then
					arg_372_1.talkMaxDuration = var_375_10
					var_375_4 = var_375_4 + 0.3

					if var_375_10 + var_375_4 > arg_372_1.duration_ then
						arg_372_1.duration_ = var_375_10 + var_375_4
					end
				end

				arg_372_1.text_.text = var_375_8
				arg_372_1.typewritter.percent = 0

				arg_372_1.typewritter:SetDirty()
				arg_372_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319801", "319801086", "story_v_out_319801.awb") ~= 0 then
					local var_375_11 = manager.audio:GetVoiceLength("story_v_out_319801", "319801086", "story_v_out_319801.awb") / 1000

					if var_375_11 + var_375_4 > arg_372_1.duration_ then
						arg_372_1.duration_ = var_375_11 + var_375_4
					end

					if var_375_7.prefab_name ~= "" and arg_372_1.actors_[var_375_7.prefab_name] ~= nil then
						local var_375_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_372_1.actors_[var_375_7.prefab_name].transform, "story_v_out_319801", "319801086", "story_v_out_319801.awb")

						arg_372_1:RecordAudio("319801086", var_375_12)
						arg_372_1:RecordAudio("319801086", var_375_12)
					else
						arg_372_1:AudioAction("play", "voice", "story_v_out_319801", "319801086", "story_v_out_319801.awb")
					end

					arg_372_1:RecordHistoryTalkVoice("story_v_out_319801", "319801086", "story_v_out_319801.awb")
				end

				arg_372_1:RecordContent(arg_372_1.text_.text)
			end

			local var_375_13 = var_375_4 + 0.3
			local var_375_14 = math.max(var_375_5, arg_372_1.talkMaxDuration)

			if var_375_4 + 0.3 <= arg_372_1.time_ and arg_372_1.time_ < var_375_13 + var_375_14 then
				arg_372_1.typewritter.percent = (arg_372_1.time_ - var_375_13) / var_375_14

				arg_372_1.typewritter:SetDirty()
			end

			if arg_372_1.time_ >= var_375_13 + var_375_14 and arg_372_1.time_ < var_375_13 + var_375_14 + arg_375_0 then
				arg_372_1.typewritter.percent = 1

				arg_372_1.typewritter:SetDirty()
				arg_372_1:ShowNextGo(true)
			end
		end

		arg_372_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "ML0204",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "ML0204",
				changeDisplayLayer = false,
				needEase = false,
				duration = 2.79933333333333,
				className = "StoryMoveNode",
				startTime = 0.034,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_372_1:InitPlayNodeList()
	end,
	Play319801087 = function(arg_378_0, arg_378_1)
		arg_378_1.time_ = 0
		arg_378_1.frameCnt_ = 0
		arg_378_1.state_ = "playing"
		arg_378_1.curTalkId_ = 319801087
		arg_378_1.duration_ = 6.03

		local var_378_0 = {
			zh = 2.666,
			ja = 6.033
		}
		local var_378_1 = manager.audio:GetLocalizationFlag()

		if var_378_0[var_378_1] ~= nil then
			arg_378_1.duration_ = var_378_0[var_378_1]
		end

		SetActive(arg_378_1.tipsGo_, false)

		function arg_378_1.onSingleLineFinish_()
			arg_378_1.onSingleLineUpdate_ = nil
			arg_378_1.onSingleLineFinish_ = nil
			arg_378_1.state_ = "waiting"
		end

		function arg_378_1.playNext_(arg_380_0)
			if arg_380_0 == 1 then
				arg_378_0:Play319801088(arg_378_1)
			end
		end

		function arg_378_1.onSingleLineUpdate_(arg_381_0)
			local var_381_0 = 0.2

			if 0 < arg_378_1.time_ and arg_378_1.time_ <= 0 + arg_381_0 then
				arg_378_1.talkMaxDuration = 0
				arg_378_1.dialogCg_.alpha = 1

				arg_378_1.dialog_:SetActive(true)
				SetActive(arg_378_1.leftNameGo_, true)

				arg_378_1.leftNameTxt_.text = arg_378_1:FormatText(StoryNameCfg[640].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_378_1.leftNameTxt_.transform)

				arg_378_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_378_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_378_1:RecordName(arg_378_1.leftNameTxt_.text)
				SetActive(arg_378_1.iconTrs_.gameObject, false)
				arg_378_1.callingController_:SetSelectedState("normal")

				local var_381_1 = arg_378_1:GetWordFromCfg(319801087)
				local var_381_2 = arg_378_1:FormatText(var_381_1.content)

				arg_378_1.text_.text = var_381_2

				LuaForUtil.ClearLinePrefixSymbol(arg_378_1.text_)

				local var_381_4 = 8 <= 0 and var_381_0 or var_381_0 * (utf8.len(var_381_2) / 8)

				if (8 <= 0 and var_381_0 or var_381_0 * (utf8.len(var_381_2) / 8)) > 0 and var_381_0 < var_381_4 then
					arg_378_1.talkMaxDuration = var_381_4

					if var_381_4 + 0 > arg_378_1.duration_ then
						arg_378_1.duration_ = var_381_4 + 0
					end
				end

				arg_378_1.text_.text = var_381_2
				arg_378_1.typewritter.percent = 0

				arg_378_1.typewritter:SetDirty()
				arg_378_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319801", "319801087", "story_v_out_319801.awb") ~= 0 then
					local var_381_5 = manager.audio:GetVoiceLength("story_v_out_319801", "319801087", "story_v_out_319801.awb") / 1000

					if var_381_5 + 0 > arg_378_1.duration_ then
						arg_378_1.duration_ = var_381_5 + 0
					end

					if var_381_1.prefab_name ~= "" and arg_378_1.actors_[var_381_1.prefab_name] ~= nil then
						local var_381_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_378_1.actors_[var_381_1.prefab_name].transform, "story_v_out_319801", "319801087", "story_v_out_319801.awb")

						arg_378_1:RecordAudio("319801087", var_381_6)
						arg_378_1:RecordAudio("319801087", var_381_6)
					else
						arg_378_1:AudioAction("play", "voice", "story_v_out_319801", "319801087", "story_v_out_319801.awb")
					end

					arg_378_1:RecordHistoryTalkVoice("story_v_out_319801", "319801087", "story_v_out_319801.awb")
				end

				arg_378_1:RecordContent(arg_378_1.text_.text)
			end

			local var_381_7 = math.max(var_381_0, arg_378_1.talkMaxDuration)

			if 0 <= arg_378_1.time_ and arg_378_1.time_ < 0 + var_381_7 then
				arg_378_1.typewritter.percent = (arg_378_1.time_ - 0) / var_381_7

				arg_378_1.typewritter:SetDirty()
			end

			if arg_378_1.time_ >= 0 + var_381_7 and arg_378_1.time_ < 0 + var_381_7 + arg_381_0 then
				arg_378_1.typewritter.percent = 1

				arg_378_1.typewritter:SetDirty()
				arg_378_1:ShowNextGo(true)
			end
		end

		arg_378_1.nodeConfigList_ = {}

		arg_378_1:InitPlayNodeList()
	end,
	Play319801088 = function(arg_382_0, arg_382_1)
		arg_382_1.time_ = 0
		arg_382_1.frameCnt_ = 0
		arg_382_1.state_ = "playing"
		arg_382_1.curTalkId_ = 319801088
		arg_382_1.duration_ = 8.63

		local var_382_0 = {
			zh = 2.466,
			ja = 8.633
		}
		local var_382_1 = manager.audio:GetLocalizationFlag()

		if var_382_0[var_382_1] ~= nil then
			arg_382_1.duration_ = var_382_0[var_382_1]
		end

		SetActive(arg_382_1.tipsGo_, false)

		function arg_382_1.onSingleLineFinish_()
			arg_382_1.onSingleLineUpdate_ = nil
			arg_382_1.onSingleLineFinish_ = nil
			arg_382_1.state_ = "waiting"
		end

		function arg_382_1.playNext_(arg_384_0)
			if arg_384_0 == 1 then
				arg_382_0:Play319801089(arg_382_1)
			end
		end

		function arg_382_1.onSingleLineUpdate_(arg_385_0)
			if 0 < arg_382_1.time_ and arg_382_1.time_ <= 0 + arg_385_0 then
				local var_385_0 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_385_0 then
					var_385_0.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_385_0.radialBlurScale = 1
					var_385_0.radialBlurGradient = 1
					var_385_0.radialBlurIntensity = 1

					if arg_382_1.actors_.ML0204 then
						var_385_0.radialBlurTarget = arg_382_1.actors_.ML0204.transform
					end
				end
			end

			local var_385_1 = 2.16666666666667

			if 0 <= arg_382_1.time_ and arg_382_1.time_ < 0 + var_385_1 then
				local var_385_2 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_385_2 then
					var_385_2.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_385_2.radialBlurScale = Mathf.Lerp(1, 0.143, (arg_382_1.time_ - 0) / var_385_1)
					var_385_2.radialBlurGradient = Mathf.Lerp(1, 1, (arg_382_1.time_ - 0) / var_385_1)
					var_385_2.radialBlurIntensity = Mathf.Lerp(1, 1, (arg_382_1.time_ - 0) / var_385_1)
				end
			end

			if arg_382_1.time_ >= 0 + var_385_1 and arg_382_1.time_ < 0 + var_385_1 + arg_385_0 then
				local var_385_3 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_385_3 then
					var_385_3.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_385_3.radialBlurScale = 0.143
					var_385_3.radialBlurGradient = 1
					var_385_3.radialBlurIntensity = 1
				end
			end

			if arg_382_1.frameCnt_ <= 1 then
				arg_382_1.dialog_:SetActive(false)
			end

			local var_385_4 = 0.7
			local var_385_5 = 0.125

			if 0.7 < arg_382_1.time_ and arg_382_1.time_ <= var_385_4 + arg_385_0 then
				arg_382_1.talkMaxDuration = 0

				arg_382_1.dialog_:SetActive(true)

				arg_382_1.dialogCg_.alpha = 0

				local var_385_6 = LeanTween.value(arg_382_1.dialog_, 0, 1, 0.3)

				var_385_6:setOnUpdate(LuaHelper.FloatAction(function(arg_386_0)
					arg_382_1.dialogCg_.alpha = arg_386_0
				end))
				var_385_6:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_382_1.dialog_)
					var_385_6:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_382_1.duration_ = arg_382_1.duration_ + 0.3

				SetActive(arg_382_1.leftNameGo_, true)

				arg_382_1.leftNameTxt_.text = arg_382_1:FormatText(StoryNameCfg[640].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_382_1.leftNameTxt_.transform)

				arg_382_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_382_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_382_1:RecordName(arg_382_1.leftNameTxt_.text)
				SetActive(arg_382_1.iconTrs_.gameObject, false)
				arg_382_1.callingController_:SetSelectedState("normal")

				local var_385_7 = arg_382_1:GetWordFromCfg(319801088)
				local var_385_8 = arg_382_1:FormatText(var_385_7.content)

				arg_382_1.text_.text = var_385_8

				LuaForUtil.ClearLinePrefixSymbol(arg_382_1.text_)

				local var_385_10 = 5 <= 0 and var_385_5 or var_385_5 * (utf8.len(var_385_8) / 5)

				if (5 <= 0 and var_385_5 or var_385_5 * (utf8.len(var_385_8) / 5)) > 0 and var_385_5 < var_385_10 then
					arg_382_1.talkMaxDuration = var_385_10
					var_385_4 = var_385_4 + 0.3

					if var_385_10 + var_385_4 > arg_382_1.duration_ then
						arg_382_1.duration_ = var_385_10 + var_385_4
					end
				end

				arg_382_1.text_.text = var_385_8
				arg_382_1.typewritter.percent = 0

				arg_382_1.typewritter:SetDirty()
				arg_382_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319801", "319801088", "story_v_out_319801.awb") ~= 0 then
					local var_385_11 = manager.audio:GetVoiceLength("story_v_out_319801", "319801088", "story_v_out_319801.awb") / 1000

					if var_385_11 + var_385_4 > arg_382_1.duration_ then
						arg_382_1.duration_ = var_385_11 + var_385_4
					end

					if var_385_7.prefab_name ~= "" and arg_382_1.actors_[var_385_7.prefab_name] ~= nil then
						local var_385_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_382_1.actors_[var_385_7.prefab_name].transform, "story_v_out_319801", "319801088", "story_v_out_319801.awb")

						arg_382_1:RecordAudio("319801088", var_385_12)
						arg_382_1:RecordAudio("319801088", var_385_12)
					else
						arg_382_1:AudioAction("play", "voice", "story_v_out_319801", "319801088", "story_v_out_319801.awb")
					end

					arg_382_1:RecordHistoryTalkVoice("story_v_out_319801", "319801088", "story_v_out_319801.awb")
				end

				arg_382_1:RecordContent(arg_382_1.text_.text)
			end

			local var_385_13 = var_385_4 + 0.3
			local var_385_14 = math.max(var_385_5, arg_382_1.talkMaxDuration)

			if var_385_4 + 0.3 <= arg_382_1.time_ and arg_382_1.time_ < var_385_13 + var_385_14 then
				arg_382_1.typewritter.percent = (arg_382_1.time_ - var_385_13) / var_385_14

				arg_382_1.typewritter:SetDirty()
			end

			if arg_382_1.time_ >= var_385_13 + var_385_14 and arg_382_1.time_ < var_385_13 + var_385_14 + arg_385_0 then
				arg_382_1.typewritter.percent = 1

				arg_382_1.typewritter:SetDirty()
				arg_382_1:ShowNextGo(true)
			end
		end

		arg_382_1.nodeConfigList_ = {}

		arg_382_1:InitPlayNodeList()
	end,
	Play319801089 = function(arg_388_0, arg_388_1)
		arg_388_1.time_ = 0
		arg_388_1.frameCnt_ = 0
		arg_388_1.state_ = "playing"
		arg_388_1.curTalkId_ = 319801089
		arg_388_1.duration_ = 4.9

		local var_388_0 = {
			zh = 4.9,
			ja = 4.166
		}
		local var_388_1 = manager.audio:GetLocalizationFlag()

		if var_388_0[var_388_1] ~= nil then
			arg_388_1.duration_ = var_388_0[var_388_1]
		end

		SetActive(arg_388_1.tipsGo_, false)

		function arg_388_1.onSingleLineFinish_()
			arg_388_1.onSingleLineUpdate_ = nil
			arg_388_1.onSingleLineFinish_ = nil
			arg_388_1.state_ = "waiting"
		end

		function arg_388_1.playNext_(arg_390_0)
			if arg_390_0 == 1 then
				arg_388_0:Play319801090(arg_388_1)
			end
		end

		function arg_388_1.onSingleLineUpdate_(arg_391_0)
			if 0 < arg_388_1.time_ and arg_388_1.time_ <= 0 + arg_391_0 then
				local var_391_0 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_391_0 then
					var_391_0.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_391_0.radialBlurScale = 0
					var_391_0.radialBlurGradient = 1
					var_391_0.radialBlurIntensity = 0.991

					if arg_388_1.actors_.ML0204 then
						var_391_0.radialBlurTarget = arg_388_1.actors_.ML0204.transform
					end
				end
			end

			local var_391_1 = 2.16666666666667

			if 0 <= arg_388_1.time_ and arg_388_1.time_ < 0 + var_391_1 then
				local var_391_2 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_391_2 then
					var_391_2.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_391_2.radialBlurScale = Mathf.Lerp(0, 0.138, (arg_388_1.time_ - 0) / var_391_1)
					var_391_2.radialBlurGradient = Mathf.Lerp(1, 1, (arg_388_1.time_ - 0) / var_391_1)
					var_391_2.radialBlurIntensity = Mathf.Lerp(0.991, 1, (arg_388_1.time_ - 0) / var_391_1)
				end
			end

			if arg_388_1.time_ >= 0 + var_391_1 and arg_388_1.time_ < 0 + var_391_1 + arg_391_0 then
				local var_391_3 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_391_3 then
					var_391_3.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_391_3.radialBlurScale = 0.138
					var_391_3.radialBlurGradient = 1
					var_391_3.radialBlurIntensity = 1
				end
			end

			local var_391_4 = 0
			local var_391_5 = 0.275

			if 0 < arg_388_1.time_ and arg_388_1.time_ <= var_391_4 + arg_391_0 then
				arg_388_1.talkMaxDuration = 0
				arg_388_1.dialogCg_.alpha = 1

				arg_388_1.dialog_:SetActive(true)
				SetActive(arg_388_1.leftNameGo_, true)

				arg_388_1.leftNameTxt_.text = arg_388_1:FormatText(StoryNameCfg[640].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_388_1.leftNameTxt_.transform)

				arg_388_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_388_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_388_1:RecordName(arg_388_1.leftNameTxt_.text)
				SetActive(arg_388_1.iconTrs_.gameObject, false)
				arg_388_1.callingController_:SetSelectedState("normal")

				local var_391_6 = arg_388_1:GetWordFromCfg(319801089)
				local var_391_7 = arg_388_1:FormatText(var_391_6.content)

				arg_388_1.text_.text = var_391_7

				LuaForUtil.ClearLinePrefixSymbol(arg_388_1.text_)

				local var_391_9 = 11 <= 0 and var_391_5 or var_391_5 * (utf8.len(var_391_7) / 11)

				if (11 <= 0 and var_391_5 or var_391_5 * (utf8.len(var_391_7) / 11)) > 0 and var_391_5 < var_391_9 then
					arg_388_1.talkMaxDuration = var_391_9

					if var_391_9 + var_391_4 > arg_388_1.duration_ then
						arg_388_1.duration_ = var_391_9 + var_391_4
					end
				end

				arg_388_1.text_.text = var_391_7
				arg_388_1.typewritter.percent = 0

				arg_388_1.typewritter:SetDirty()
				arg_388_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319801", "319801089", "story_v_out_319801.awb") ~= 0 then
					local var_391_10 = manager.audio:GetVoiceLength("story_v_out_319801", "319801089", "story_v_out_319801.awb") / 1000

					if var_391_10 + var_391_4 > arg_388_1.duration_ then
						arg_388_1.duration_ = var_391_10 + var_391_4
					end

					if var_391_6.prefab_name ~= "" and arg_388_1.actors_[var_391_6.prefab_name] ~= nil then
						local var_391_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_388_1.actors_[var_391_6.prefab_name].transform, "story_v_out_319801", "319801089", "story_v_out_319801.awb")

						arg_388_1:RecordAudio("319801089", var_391_11)
						arg_388_1:RecordAudio("319801089", var_391_11)
					else
						arg_388_1:AudioAction("play", "voice", "story_v_out_319801", "319801089", "story_v_out_319801.awb")
					end

					arg_388_1:RecordHistoryTalkVoice("story_v_out_319801", "319801089", "story_v_out_319801.awb")
				end

				arg_388_1:RecordContent(arg_388_1.text_.text)
			end

			local var_391_12 = math.max(var_391_5, arg_388_1.talkMaxDuration)

			if var_391_4 <= arg_388_1.time_ and arg_388_1.time_ < var_391_4 + var_391_12 then
				arg_388_1.typewritter.percent = (arg_388_1.time_ - var_391_4) / var_391_12

				arg_388_1.typewritter:SetDirty()
			end

			if arg_388_1.time_ >= var_391_4 + var_391_12 and arg_388_1.time_ < var_391_4 + var_391_12 + arg_391_0 then
				arg_388_1.typewritter.percent = 1

				arg_388_1.typewritter:SetDirty()
				arg_388_1:ShowNextGo(true)
			end
		end

		arg_388_1.nodeConfigList_ = {}

		arg_388_1:InitPlayNodeList()
	end,
	Play319801090 = function(arg_392_0, arg_392_1)
		arg_392_1.time_ = 0
		arg_392_1.frameCnt_ = 0
		arg_392_1.state_ = "playing"
		arg_392_1.curTalkId_ = 319801090
		arg_392_1.duration_ = 7.58

		SetActive(arg_392_1.tipsGo_, false)

		function arg_392_1.onSingleLineFinish_()
			arg_392_1.onSingleLineUpdate_ = nil
			arg_392_1.onSingleLineFinish_ = nil
			arg_392_1.state_ = "waiting"
		end

		function arg_392_1.playNext_(arg_394_0)
			if arg_394_0 == 1 then
				arg_392_0:Play319801091(arg_392_1)
			end
		end

		function arg_392_1.onSingleLineUpdate_(arg_395_0)
			if arg_392_1.bgs_.STwhite == nil then
				local var_395_0 = Object.Instantiate(arg_392_1.paintGo_)

				var_395_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "STwhite")
				var_395_0.name = "STwhite"
				var_395_0.transform.parent = arg_392_1.stage_.transform
				var_395_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_392_1.bgs_.STwhite = var_395_0
			end

			if 1.33333333333333 < arg_392_1.time_ and arg_392_1.time_ <= 1.33333333333333 + arg_395_0 then
				local var_395_1 = arg_392_1.bgs_.STwhite

				arg_392_1.bgs_.STwhite.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_395_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_395_2 = var_395_1:GetComponent("SpriteRenderer")

				if var_395_2 and var_395_2.sprite then
					local var_395_3 = 2 * (var_395_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_395_1.transform.localScale = Vector3.New(var_395_3 / var_395_2.sprite.bounds.size.y < var_395_3 * manager.ui.mainCameraCom_.aspect / var_395_2.sprite.bounds.size.x and var_395_3 * manager.ui.mainCameraCom_.aspect / var_395_2.sprite.bounds.size.x or var_395_3 / var_395_2.sprite.bounds.size.y, var_395_3 / var_395_2.sprite.bounds.size.y < var_395_3 * manager.ui.mainCameraCom_.aspect / var_395_2.sprite.bounds.size.x and var_395_3 * manager.ui.mainCameraCom_.aspect / var_395_2.sprite.bounds.size.x or var_395_3 / var_395_2.sprite.bounds.size.y, 0)
				end

				for iter_395_0, iter_395_1 in pairs(arg_392_1.bgs_) do
					if iter_395_0 ~= "STwhite" then
						iter_395_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_395_4 = 0

			if 0 < arg_392_1.time_ and arg_392_1.time_ <= var_395_4 + arg_395_0 then
				arg_392_1.allBtn_.enabled = false
			end

			if arg_392_1.time_ >= var_395_4 + 0.3 and arg_392_1.time_ < var_395_4 + 0.3 + arg_395_0 then
				arg_392_1.allBtn_.enabled = true
			end

			local var_395_5 = 0

			if 0 < arg_392_1.time_ and arg_392_1.time_ <= var_395_5 + arg_395_0 then
				arg_392_1.mask_.enabled = true
				arg_392_1.mask_.raycastTarget = true

				arg_392_1:SetGaussion(false)
			end

			local var_395_6 = 1.33333333333333

			if var_395_5 <= arg_392_1.time_ and arg_392_1.time_ < var_395_5 + var_395_6 then
				local var_395_7 = Color.New(1, 1, 1)

				var_395_7.a = Mathf.Lerp(0, 1, (arg_392_1.time_ - var_395_5) / var_395_6)
				arg_392_1.mask_.color = var_395_7
			end

			if arg_392_1.time_ >= var_395_5 + var_395_6 and arg_392_1.time_ < var_395_5 + var_395_6 + arg_395_0 then
				local var_395_8 = Color.New(1, 1, 1)

				var_395_8.a = 1
				arg_392_1.mask_.color = var_395_8
			end

			local var_395_9 = 1.33333333333333

			if 1.33333333333333 < arg_392_1.time_ and arg_392_1.time_ <= var_395_9 + arg_395_0 then
				arg_392_1.mask_.enabled = true
				arg_392_1.mask_.raycastTarget = true

				arg_392_1:SetGaussion(false)
			end

			local var_395_10 = 1.36666666666667

			if var_395_9 <= arg_392_1.time_ and arg_392_1.time_ < var_395_9 + var_395_10 then
				local var_395_11 = Color.New(1, 1, 1)

				var_395_11.a = Mathf.Lerp(1, 0, (arg_392_1.time_ - var_395_9) / var_395_10)
				arg_392_1.mask_.color = var_395_11
			end

			if arg_392_1.time_ >= var_395_9 + var_395_10 and arg_392_1.time_ < var_395_9 + var_395_10 + arg_395_0 then
				local var_395_12 = Color.New(1, 1, 1)

				arg_392_1.mask_.enabled = false
				var_395_12.a = 0
				arg_392_1.mask_.color = var_395_12
			end

			if 0 < arg_392_1.time_ and arg_392_1.time_ <= 0 + arg_395_0 then
				arg_392_1:AudioAction("stop", "effect", "se_story_121_04", "se_story_121_04_earthquake_loop", "")
			end

			local var_395_14 = arg_392_1.actors_.ML0204

			if 1.33333333333333 < arg_392_1.time_ and arg_392_1.time_ <= 1.33333333333333 + arg_395_0 then
				local var_395_15 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_395_15 then
					var_395_15.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.Disabled
					var_395_15.radialBlurScale = 1
					var_395_15.radialBlurGradient = 1
					var_395_15.radialBlurIntensity = 1

					if var_395_14 then
						var_395_15.radialBlurTarget = var_395_14.transform
					end
				end
			end

			local var_395_16 = 0.933333333333333

			if 1.33333333333333 <= arg_392_1.time_ and arg_392_1.time_ < 1.33333333333333 + var_395_16 then
				local var_395_17 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_395_17 then
					var_395_17.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.Disabled
					var_395_17.radialBlurScale = Mathf.Lerp(1, 0.143, (arg_392_1.time_ - 1.33333333333333) / var_395_16)
					var_395_17.radialBlurGradient = Mathf.Lerp(1, 1, (arg_392_1.time_ - 1.33333333333333) / var_395_16)
					var_395_17.radialBlurIntensity = Mathf.Lerp(1, 1, (arg_392_1.time_ - 1.33333333333333) / var_395_16)
				end
			end

			if arg_392_1.time_ >= 1.33333333333333 + var_395_16 and arg_392_1.time_ < 1.33333333333333 + var_395_16 + arg_395_0 then
				local var_395_18 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_395_18 then
					var_395_18.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.Disabled
					var_395_18.radialBlurScale = 0.143
					var_395_18.radialBlurGradient = 1
					var_395_18.radialBlurIntensity = 1
				end
			end

			if arg_392_1.frameCnt_ <= 1 then
				arg_392_1.dialog_:SetActive(false)
			end

			local var_395_19 = 2.5760286316586
			local var_395_20 = 0.05

			if 2.5760286316586 < arg_392_1.time_ and arg_392_1.time_ <= var_395_19 + arg_395_0 then
				arg_392_1.talkMaxDuration = 0

				arg_392_1.dialog_:SetActive(true)

				arg_392_1.dialogCg_.alpha = 0

				local var_395_21 = LeanTween.value(arg_392_1.dialog_, 0, 1, 0.3)

				var_395_21:setOnUpdate(LuaHelper.FloatAction(function(arg_396_0)
					arg_392_1.dialogCg_.alpha = arg_396_0
				end))
				var_395_21:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_392_1.dialog_)
					var_395_21:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_392_1.duration_ = arg_392_1.duration_ + 0.3

				SetActive(arg_392_1.leftNameGo_, false)

				arg_392_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_392_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_392_1:RecordName(arg_392_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_392_1.iconTrs_.gameObject, false)
				arg_392_1.callingController_:SetSelectedState("normal")

				local var_395_22 = arg_392_1:FormatText(arg_392_1:GetWordFromCfg(319801090).content)

				arg_392_1.text_.text = var_395_22

				LuaForUtil.ClearLinePrefixSymbol(arg_392_1.text_)

				local var_395_24 = 2 <= 0 and var_395_20 or var_395_20 * (utf8.len(var_395_22) / 2)

				if (2 <= 0 and var_395_20 or var_395_20 * (utf8.len(var_395_22) / 2)) > 0 and var_395_20 < var_395_24 then
					arg_392_1.talkMaxDuration = var_395_24
					var_395_19 = var_395_19 + 0.3

					if var_395_24 + var_395_19 > arg_392_1.duration_ then
						arg_392_1.duration_ = var_395_24 + var_395_19
					end
				end

				arg_392_1.text_.text = var_395_22
				arg_392_1.typewritter.percent = 0

				arg_392_1.typewritter:SetDirty()
				arg_392_1:ShowNextGo(false)
				arg_392_1:RecordContent(arg_392_1.text_.text)
			end

			local var_395_25 = var_395_19 + 0.3
			local var_395_26 = math.max(var_395_20, arg_392_1.talkMaxDuration)

			if var_395_19 + 0.3 <= arg_392_1.time_ and arg_392_1.time_ < var_395_25 + var_395_26 then
				arg_392_1.typewritter.percent = (arg_392_1.time_ - var_395_25) / var_395_26

				arg_392_1.typewritter:SetDirty()
			end

			if arg_392_1.time_ >= var_395_25 + var_395_26 and arg_392_1.time_ < var_395_25 + var_395_26 + arg_395_0 then
				arg_392_1.typewritter.percent = 1

				arg_392_1.typewritter:SetDirty()
				arg_392_1:ShowNextGo(true)
			end
		end

		arg_392_1.nodeConfigList_ = {}

		arg_392_1:InitPlayNodeList()
	end,
	Play319801091 = function(arg_398_0, arg_398_1)
		arg_398_1.time_ = 0
		arg_398_1.frameCnt_ = 0
		arg_398_1.state_ = "playing"
		arg_398_1.curTalkId_ = 319801091
		arg_398_1.duration_ = 1.73

		local var_398_0 = {
			zh = 1.733,
			ja = 1.466
		}
		local var_398_1 = manager.audio:GetLocalizationFlag()

		if var_398_0[var_398_1] ~= nil then
			arg_398_1.duration_ = var_398_0[var_398_1]
		end

		SetActive(arg_398_1.tipsGo_, false)

		function arg_398_1.onSingleLineFinish_()
			arg_398_1.onSingleLineUpdate_ = nil
			arg_398_1.onSingleLineFinish_ = nil
			arg_398_1.state_ = "waiting"
			arg_398_1.auto_ = false
		end

		function arg_398_1.playNext_(arg_400_0)
			arg_398_1.onStoryFinished_()
		end

		function arg_398_1.onSingleLineUpdate_(arg_401_0)
			local var_401_0 = 0.1

			if 0 < arg_398_1.time_ and arg_398_1.time_ <= 0 + arg_401_0 then
				arg_398_1.talkMaxDuration = 0
				arg_398_1.dialogCg_.alpha = 1

				arg_398_1.dialog_:SetActive(true)
				SetActive(arg_398_1.leftNameGo_, true)

				arg_398_1.leftNameTxt_.text = arg_398_1:FormatText(StoryNameCfg[640].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_398_1.leftNameTxt_.transform)

				arg_398_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_398_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_398_1:RecordName(arg_398_1.leftNameTxt_.text)
				SetActive(arg_398_1.iconTrs_.gameObject, false)
				arg_398_1.callingController_:SetSelectedState("normal")

				local var_401_1 = arg_398_1:GetWordFromCfg(319801091)
				local var_401_2 = arg_398_1:FormatText(var_401_1.content)

				arg_398_1.text_.text = var_401_2

				LuaForUtil.ClearLinePrefixSymbol(arg_398_1.text_)

				local var_401_4 = 4 <= 0 and var_401_0 or var_401_0 * (utf8.len(var_401_2) / 4)

				if (4 <= 0 and var_401_0 or var_401_0 * (utf8.len(var_401_2) / 4)) > 0 and var_401_0 < var_401_4 then
					arg_398_1.talkMaxDuration = var_401_4

					if var_401_4 + 0 > arg_398_1.duration_ then
						arg_398_1.duration_ = var_401_4 + 0
					end
				end

				arg_398_1.text_.text = var_401_2
				arg_398_1.typewritter.percent = 0

				arg_398_1.typewritter:SetDirty()
				arg_398_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319801", "319801091", "story_v_out_319801.awb") ~= 0 then
					local var_401_5 = manager.audio:GetVoiceLength("story_v_out_319801", "319801091", "story_v_out_319801.awb") / 1000

					if var_401_5 + 0 > arg_398_1.duration_ then
						arg_398_1.duration_ = var_401_5 + 0
					end

					if var_401_1.prefab_name ~= "" and arg_398_1.actors_[var_401_1.prefab_name] ~= nil then
						local var_401_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_398_1.actors_[var_401_1.prefab_name].transform, "story_v_out_319801", "319801091", "story_v_out_319801.awb")

						arg_398_1:RecordAudio("319801091", var_401_6)
						arg_398_1:RecordAudio("319801091", var_401_6)
					else
						arg_398_1:AudioAction("play", "voice", "story_v_out_319801", "319801091", "story_v_out_319801.awb")
					end

					arg_398_1:RecordHistoryTalkVoice("story_v_out_319801", "319801091", "story_v_out_319801.awb")
				end

				arg_398_1:RecordContent(arg_398_1.text_.text)
			end

			local var_401_7 = math.max(var_401_0, arg_398_1.talkMaxDuration)

			if 0 <= arg_398_1.time_ and arg_398_1.time_ < 0 + var_401_7 then
				arg_398_1.typewritter.percent = (arg_398_1.time_ - 0) / var_401_7

				arg_398_1.typewritter:SetDirty()
			end

			if arg_398_1.time_ >= 0 + var_401_7 and arg_398_1.time_ < 0 + var_401_7 + arg_401_0 then
				arg_398_1.typewritter.percent = 1

				arg_398_1.typewritter:SetDirty()
				arg_398_1:ShowNextGo(true)
			end
		end

		arg_398_1.nodeConfigList_ = {}

		arg_398_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST72a",
		"TextureConfig/Background/ST71a",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/ML0204",
		"TextureConfig/Background/STwhite"
	},
	voices = {
		"story_v_out_319801.awb"
	}
}
