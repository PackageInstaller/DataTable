return {
	Play116171001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 116171001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play116171002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.I06 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "I06")
				var_4_0.name = "I06"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.I06 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.I06

				arg_1_1.bgs_.I06.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "I06" then
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
				arg_1_1:AudioAction("play", "music", "bgm_side_daily04", "bgm_side_daily04", "bgm_side_daily04.awb")

				local var_4_13 = manager.audio:GetAudioName("bgm_side_daily04", "bgm_side_daily04")

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
			local var_4_15 = 0.8

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_14 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0
				arg_1_1.dialogCg_.alpha = 1

				arg_1_1.dialog_:SetActive(true)
				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_16 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(116171001).content)

				arg_1_1.text_.text = var_4_16

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_18 = 32 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_16) / 32)

				if (32 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_16) / 32)) > 0 and var_4_15 < var_4_18 then
					arg_1_1.talkMaxDuration = var_4_18

					if var_4_18 + var_4_14 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_18 + var_4_14
					end
				end

				arg_1_1.text_.text = var_4_16
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_19 = math.max(var_4_15, arg_1_1.talkMaxDuration)

			if var_4_14 <= arg_1_1.time_ and arg_1_1.time_ < var_4_14 + var_4_19 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_14) / var_4_19

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_14 + var_4_19 and arg_1_1.time_ < var_4_14 + var_4_19 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play116171002 = function(arg_7_0, arg_7_1)
		arg_7_1.time_ = 0
		arg_7_1.frameCnt_ = 0
		arg_7_1.state_ = "playing"
		arg_7_1.curTalkId_ = 116171002
		arg_7_1.duration_ = 7.53

		local var_7_0 = {
			zh = 5.433,
			ja = 7.533
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
				arg_7_0:Play116171003(arg_7_1)
			end
		end

		function arg_7_1.onSingleLineUpdate_(arg_10_0)
			if arg_7_1.actors_["2079ui_story"] == nil and not isNil((Asset.Load("Char/" .. "2079ui_story"))) then
				local var_10_0 = Object.Instantiate(Asset.Load("Char/" .. "2079ui_story"), arg_7_1.stage_.transform)

				var_10_0.name = "2079ui_story"
				var_10_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_7_1.actors_["2079ui_story"] = var_10_0

				local var_10_1 = var_10_0:GetComponentInChildren(typeof(CharacterEffect))

				var_10_1.enabled = true

				local var_10_2 = GameObjectTools.GetOrAddComponent(var_10_0, typeof(DynamicBoneHelper))

				if var_10_2 then
					var_10_2:EnableDynamicBone(false)
				end

				arg_7_1:ShowWeapon(var_10_1.transform, false)

				arg_7_1.var_["2079ui_story" .. "Animator"] = var_10_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_7_1.var_["2079ui_story" .. "Animator"].applyRootMotion = true
				arg_7_1.var_["2079ui_story" .. "LipSync"] = var_10_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_10_3 = arg_7_1.actors_["2079ui_story"].transform

			if 0 < arg_7_1.time_ and arg_7_1.time_ <= 0 + arg_10_0 then
				arg_7_1.var_.moveOldPos2079ui_story = var_10_3.localPosition
			end

			local var_10_4 = 0.001

			if 0 <= arg_7_1.time_ and arg_7_1.time_ < 0 + var_10_4 then
				var_10_3.localPosition = Vector3.Lerp(arg_7_1.var_.moveOldPos2079ui_story, Vector3.New(-0.7, -1.28, -5.6), (arg_7_1.time_ - 0) / var_10_4)
				var_10_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_10_3.position).x, (manager.ui.mainCamera.transform.position - var_10_3.position).y, (manager.ui.mainCamera.transform.position - var_10_3.position).z)
				var_10_3.localEulerAngles.z = 0
				var_10_3.localEulerAngles.x = 0
				var_10_3.localEulerAngles = var_10_3.localEulerAngles
			end

			if arg_7_1.time_ >= 0 + var_10_4 and arg_7_1.time_ < 0 + var_10_4 + arg_10_0 then
				var_10_3.localPosition = Vector3.New(-0.7, -1.28, -5.6)
				var_10_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_10_3.position).x, (manager.ui.mainCamera.transform.position - var_10_3.position).y, (manager.ui.mainCamera.transform.position - var_10_3.position).z)
				var_10_3.localEulerAngles.z = 0
				var_10_3.localEulerAngles.x = 0
				var_10_3.localEulerAngles = var_10_3.localEulerAngles
			end

			if 0 < arg_7_1.time_ and arg_7_1.time_ <= 0 + arg_10_0 then
				arg_7_1:PlayTimeline("2079ui_story", "StoryTimeline/CharAction/story2079/story2079action/2079action1_1")
			end

			local var_10_5 = arg_7_1.actors_["2079ui_story"]

			if 0 < arg_7_1.time_ and arg_7_1.time_ <= 0 + arg_10_0 and not isNil(var_10_5) and arg_7_1.var_.characterEffect2079ui_story == nil then
				arg_7_1.var_.characterEffect2079ui_story = var_10_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_10_6 = 0.2

			if 0 <= arg_7_1.time_ and arg_7_1.time_ < 0 + var_10_6 and not isNil(var_10_5) then
				if arg_7_1.var_.characterEffect2079ui_story and not isNil(var_10_5) then
					arg_7_1.var_.characterEffect2079ui_story.fillFlat = false
				end
			end

			if arg_7_1.time_ >= 0 + var_10_6 and arg_7_1.time_ < 0 + var_10_6 + arg_10_0 and not isNil(var_10_5) and arg_7_1.var_.characterEffect2079ui_story then
				arg_7_1.var_.characterEffect2079ui_story.fillFlat = false
			end

			local var_10_8 = 0
			local var_10_9 = 0.75

			if 0 < arg_7_1.time_ and arg_7_1.time_ <= var_10_8 + arg_10_0 then
				arg_7_1.talkMaxDuration = 0
				arg_7_1.dialogCg_.alpha = 1

				arg_7_1.dialog_:SetActive(true)
				SetActive(arg_7_1.leftNameGo_, true)

				arg_7_1.leftNameTxt_.text = arg_7_1:FormatText(StoryNameCfg[323].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_7_1.leftNameTxt_.transform)

				arg_7_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_7_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_7_1:RecordName(arg_7_1.leftNameTxt_.text)
				SetActive(arg_7_1.iconTrs_.gameObject, false)
				arg_7_1.callingController_:SetSelectedState("normal")

				local var_10_10 = arg_7_1:GetWordFromCfg(116171002)
				local var_10_11 = arg_7_1:FormatText(var_10_10.content)

				arg_7_1.text_.text = var_10_11

				LuaForUtil.ClearLinePrefixSymbol(arg_7_1.text_)

				local var_10_13 = 30 <= 0 and var_10_9 or var_10_9 * (utf8.len(var_10_11) / 30)

				if (30 <= 0 and var_10_9 or var_10_9 * (utf8.len(var_10_11) / 30)) > 0 and var_10_9 < var_10_13 then
					arg_7_1.talkMaxDuration = var_10_13

					if var_10_13 + var_10_8 > arg_7_1.duration_ then
						arg_7_1.duration_ = var_10_13 + var_10_8
					end
				end

				arg_7_1.text_.text = var_10_11
				arg_7_1.typewritter.percent = 0

				arg_7_1.typewritter:SetDirty()
				arg_7_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116171", "116171002", "story_v_out_116171.awb") ~= 0 then
					local var_10_14 = manager.audio:GetVoiceLength("story_v_out_116171", "116171002", "story_v_out_116171.awb") / 1000

					if var_10_14 + var_10_8 > arg_7_1.duration_ then
						arg_7_1.duration_ = var_10_14 + var_10_8
					end

					if var_10_10.prefab_name ~= "" and arg_7_1.actors_[var_10_10.prefab_name] ~= nil then
						local var_10_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_7_1.actors_[var_10_10.prefab_name].transform, "story_v_out_116171", "116171002", "story_v_out_116171.awb")

						arg_7_1:RecordAudio("116171002", var_10_15)
						arg_7_1:RecordAudio("116171002", var_10_15)
					else
						arg_7_1:AudioAction("play", "voice", "story_v_out_116171", "116171002", "story_v_out_116171.awb")
					end

					arg_7_1:RecordHistoryTalkVoice("story_v_out_116171", "116171002", "story_v_out_116171.awb")
				end

				arg_7_1:RecordContent(arg_7_1.text_.text)
			end

			local var_10_16 = math.max(var_10_9, arg_7_1.talkMaxDuration)

			if var_10_8 <= arg_7_1.time_ and arg_7_1.time_ < var_10_8 + var_10_16 then
				arg_7_1.typewritter.percent = (arg_7_1.time_ - var_10_8) / var_10_16

				arg_7_1.typewritter:SetDirty()
			end

			if arg_7_1.time_ >= var_10_8 + var_10_16 and arg_7_1.time_ < var_10_8 + var_10_16 + arg_10_0 then
				arg_7_1.typewritter.percent = 1

				arg_7_1.typewritter:SetDirty()
				arg_7_1:ShowNextGo(true)
			end
		end

		arg_7_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2079ui_story",
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
	Play116171003 = function(arg_11_0, arg_11_1)
		arg_11_1.time_ = 0
		arg_11_1.frameCnt_ = 0
		arg_11_1.state_ = "playing"
		arg_11_1.curTalkId_ = 116171003
		arg_11_1.duration_ = 5.73

		local var_11_0 = {
			zh = 3.433,
			ja = 5.733
		}
		local var_11_1 = manager.audio:GetLocalizationFlag()

		if var_11_0[var_11_1] ~= nil then
			arg_11_1.duration_ = var_11_0[var_11_1]
		end

		SetActive(arg_11_1.tipsGo_, false)

		function arg_11_1.onSingleLineFinish_()
			arg_11_1.onSingleLineUpdate_ = nil
			arg_11_1.onSingleLineFinish_ = nil
			arg_11_1.state_ = "waiting"
		end

		function arg_11_1.playNext_(arg_13_0)
			if arg_13_0 == 1 then
				arg_11_0:Play116171004(arg_11_1)
			end
		end

		function arg_11_1.onSingleLineUpdate_(arg_14_0)
			if arg_11_1.actors_["10014ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10014ui_story"))) then
				local var_14_0 = Object.Instantiate(Asset.Load("Char/" .. "10014ui_story"), arg_11_1.stage_.transform)

				var_14_0.name = "10014ui_story"
				var_14_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_11_1.actors_["10014ui_story"] = var_14_0

				local var_14_1 = var_14_0:GetComponentInChildren(typeof(CharacterEffect))

				var_14_1.enabled = true

				local var_14_2 = GameObjectTools.GetOrAddComponent(var_14_0, typeof(DynamicBoneHelper))

				if var_14_2 then
					var_14_2:EnableDynamicBone(false)
				end

				arg_11_1:ShowWeapon(var_14_1.transform, false)

				arg_11_1.var_["10014ui_story" .. "Animator"] = var_14_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_11_1.var_["10014ui_story" .. "Animator"].applyRootMotion = true
				arg_11_1.var_["10014ui_story" .. "LipSync"] = var_14_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_11_1.time_ and arg_11_1.time_ <= 0 + arg_14_0 then
				arg_11_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/story10014/story10014action/10014action1_1")
			end

			local var_14_3 = arg_11_1.actors_["10014ui_story"].transform

			if 0 < arg_11_1.time_ and arg_11_1.time_ <= 0 + arg_14_0 then
				arg_11_1.var_.moveOldPos10014ui_story = var_14_3.localPosition
			end

			local var_14_4 = 0.001

			if 0 <= arg_11_1.time_ and arg_11_1.time_ < 0 + var_14_4 then
				var_14_3.localPosition = Vector3.Lerp(arg_11_1.var_.moveOldPos10014ui_story, Vector3.New(0.7, -1.06, -6.2), (arg_11_1.time_ - 0) / var_14_4)
				var_14_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_14_3.position).x, (manager.ui.mainCamera.transform.position - var_14_3.position).y, (manager.ui.mainCamera.transform.position - var_14_3.position).z)
				var_14_3.localEulerAngles.z = 0
				var_14_3.localEulerAngles.x = 0
				var_14_3.localEulerAngles = var_14_3.localEulerAngles
			end

			if arg_11_1.time_ >= 0 + var_14_4 and arg_11_1.time_ < 0 + var_14_4 + arg_14_0 then
				var_14_3.localPosition = Vector3.New(0.7, -1.06, -6.2)
				var_14_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_14_3.position).x, (manager.ui.mainCamera.transform.position - var_14_3.position).y, (manager.ui.mainCamera.transform.position - var_14_3.position).z)
				var_14_3.localEulerAngles.z = 0
				var_14_3.localEulerAngles.x = 0
				var_14_3.localEulerAngles = var_14_3.localEulerAngles
			end

			local var_14_5 = arg_11_1.actors_["2079ui_story"]

			if 0 < arg_11_1.time_ and arg_11_1.time_ <= 0 + arg_14_0 and not isNil(var_14_5) and arg_11_1.var_.characterEffect2079ui_story == nil then
				arg_11_1.var_.characterEffect2079ui_story = var_14_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_14_6 = 0.2

			if 0 <= arg_11_1.time_ and arg_11_1.time_ < 0 + var_14_6 and not isNil(var_14_5) then
				if arg_11_1.var_.characterEffect2079ui_story and not isNil(var_14_5) then
					arg_11_1.var_.characterEffect2079ui_story.fillFlat = true
					arg_11_1.var_.characterEffect2079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_11_1.time_ - 0) / var_14_6)
				end
			end

			if arg_11_1.time_ >= 0 + var_14_6 and arg_11_1.time_ < 0 + var_14_6 + arg_14_0 and not isNil(var_14_5) and arg_11_1.var_.characterEffect2079ui_story then
				arg_11_1.var_.characterEffect2079ui_story.fillFlat = true
				arg_11_1.var_.characterEffect2079ui_story.fillRatio = 0.5
			end

			if 0 < arg_11_1.time_ and arg_11_1.time_ <= 0 + arg_14_0 then
				arg_11_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			if 0 < arg_11_1.time_ and arg_11_1.time_ <= 0 + arg_14_0 then
				if arg_11_1.var_.characterEffect10014ui_story == nil then
					arg_11_1.var_.characterEffect10014ui_story = arg_11_1.actors_["10014ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_14_7 = arg_11_1.var_.characterEffect10014ui_story

				arg_11_1.var_.characterEffect10014ui_story.imageEffect:turnOff()

				var_14_7.interferenceEffect.enabled = true
				var_14_7.interferenceEffect.noise = 0.001
				var_14_7.interferenceEffect.simTimeScale = 1
				var_14_7.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			if 0 < arg_11_1.time_ and arg_11_1.time_ <= 0 + arg_14_0 then
				if arg_11_1.var_.characterEffect10014ui_story == nil then
					arg_11_1.var_.characterEffect10014ui_story = arg_11_1.actors_["10014ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_11_1.var_.characterEffect10014ui_story.imageEffect:turnOn(false)
			end

			local var_14_9 = 0
			local var_14_10 = 0.3

			if 0 < arg_11_1.time_ and arg_11_1.time_ <= var_14_9 + arg_14_0 then
				arg_11_1.talkMaxDuration = 0
				arg_11_1.dialogCg_.alpha = 1

				arg_11_1.dialog_:SetActive(true)
				SetActive(arg_11_1.leftNameGo_, true)

				arg_11_1.leftNameTxt_.text = arg_11_1:FormatText(StoryNameCfg[264].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_11_1.leftNameTxt_.transform)

				arg_11_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_11_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_11_1:RecordName(arg_11_1.leftNameTxt_.text)
				SetActive(arg_11_1.iconTrs_.gameObject, false)
				arg_11_1.callingController_:SetSelectedState("normal")

				local var_14_11 = arg_11_1:GetWordFromCfg(116171003)
				local var_14_12 = arg_11_1:FormatText(var_14_11.content)

				arg_11_1.text_.text = var_14_12

				LuaForUtil.ClearLinePrefixSymbol(arg_11_1.text_)

				local var_14_14 = 12 <= 0 and var_14_10 or var_14_10 * (utf8.len(var_14_12) / 12)

				if (12 <= 0 and var_14_10 or var_14_10 * (utf8.len(var_14_12) / 12)) > 0 and var_14_10 < var_14_14 then
					arg_11_1.talkMaxDuration = var_14_14

					if var_14_14 + var_14_9 > arg_11_1.duration_ then
						arg_11_1.duration_ = var_14_14 + var_14_9
					end
				end

				arg_11_1.text_.text = var_14_12
				arg_11_1.typewritter.percent = 0

				arg_11_1.typewritter:SetDirty()
				arg_11_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116171", "116171003", "story_v_out_116171.awb") ~= 0 then
					local var_14_15 = manager.audio:GetVoiceLength("story_v_out_116171", "116171003", "story_v_out_116171.awb") / 1000

					if var_14_15 + var_14_9 > arg_11_1.duration_ then
						arg_11_1.duration_ = var_14_15 + var_14_9
					end

					if var_14_11.prefab_name ~= "" and arg_11_1.actors_[var_14_11.prefab_name] ~= nil then
						local var_14_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_11_1.actors_[var_14_11.prefab_name].transform, "story_v_out_116171", "116171003", "story_v_out_116171.awb")

						arg_11_1:RecordAudio("116171003", var_14_16)
						arg_11_1:RecordAudio("116171003", var_14_16)
					else
						arg_11_1:AudioAction("play", "voice", "story_v_out_116171", "116171003", "story_v_out_116171.awb")
					end

					arg_11_1:RecordHistoryTalkVoice("story_v_out_116171", "116171003", "story_v_out_116171.awb")
				end

				arg_11_1:RecordContent(arg_11_1.text_.text)
			end

			local var_14_17 = math.max(var_14_10, arg_11_1.talkMaxDuration)

			if var_14_9 <= arg_11_1.time_ and arg_11_1.time_ < var_14_9 + var_14_17 then
				arg_11_1.typewritter.percent = (arg_11_1.time_ - var_14_9) / var_14_17

				arg_11_1.typewritter:SetDirty()
			end

			if arg_11_1.time_ >= var_14_9 + var_14_17 and arg_11_1.time_ < var_14_9 + var_14_17 + arg_14_0 then
				arg_11_1.typewritter.percent = 1

				arg_11_1.typewritter:SetDirty()
				arg_11_1:ShowNextGo(true)
			end
		end

		arg_11_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10014ui_story",
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
	Play116171004 = function(arg_15_0, arg_15_1)
		arg_15_1.time_ = 0
		arg_15_1.frameCnt_ = 0
		arg_15_1.state_ = "playing"
		arg_15_1.curTalkId_ = 116171004
		arg_15_1.duration_ = 5.37

		local var_15_0 = {
			zh = 3.233,
			ja = 5.366
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
				arg_15_0:Play116171005(arg_15_1)
			end
		end

		function arg_15_1.onSingleLineUpdate_(arg_18_0)
			if 0 < arg_15_1.time_ and arg_15_1.time_ <= 0 + arg_18_0 and not isNil(arg_15_1.actors_["2079ui_story"]) and arg_15_1.var_.characterEffect2079ui_story == nil then
				arg_15_1.var_.characterEffect2079ui_story = arg_15_1.actors_["2079ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_18_0 = 0.2

			if 0 <= arg_15_1.time_ and arg_15_1.time_ < 0 + var_18_0 and not isNil(arg_15_1.actors_["2079ui_story"]) then
				if arg_15_1.var_.characterEffect2079ui_story and not isNil(arg_15_1.actors_["2079ui_story"]) then
					arg_15_1.var_.characterEffect2079ui_story.fillFlat = false
				end
			end

			if arg_15_1.time_ >= 0 + var_18_0 and arg_15_1.time_ < 0 + var_18_0 + arg_18_0 and not isNil(arg_15_1.actors_["2079ui_story"]) and arg_15_1.var_.characterEffect2079ui_story then
				arg_15_1.var_.characterEffect2079ui_story.fillFlat = false
			end

			local var_18_2 = 0
			local var_18_3 = 0.5

			if 0 < arg_15_1.time_ and arg_15_1.time_ <= var_18_2 + arg_18_0 then
				arg_15_1.talkMaxDuration = 0
				arg_15_1.dialogCg_.alpha = 1

				arg_15_1.dialog_:SetActive(true)
				SetActive(arg_15_1.leftNameGo_, true)

				arg_15_1.leftNameTxt_.text = arg_15_1:FormatText(StoryNameCfg[323].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_15_1.leftNameTxt_.transform)

				arg_15_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_15_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_15_1:RecordName(arg_15_1.leftNameTxt_.text)
				SetActive(arg_15_1.iconTrs_.gameObject, false)
				arg_15_1.callingController_:SetSelectedState("normal")

				local var_18_4 = arg_15_1:GetWordFromCfg(116171004)
				local var_18_5 = arg_15_1:FormatText(var_18_4.content)

				arg_15_1.text_.text = var_18_5

				LuaForUtil.ClearLinePrefixSymbol(arg_15_1.text_)

				local var_18_7 = 20 <= 0 and var_18_3 or var_18_3 * (utf8.len(var_18_5) / 20)

				if (20 <= 0 and var_18_3 or var_18_3 * (utf8.len(var_18_5) / 20)) > 0 and var_18_3 < var_18_7 then
					arg_15_1.talkMaxDuration = var_18_7

					if var_18_7 + var_18_2 > arg_15_1.duration_ then
						arg_15_1.duration_ = var_18_7 + var_18_2
					end
				end

				arg_15_1.text_.text = var_18_5
				arg_15_1.typewritter.percent = 0

				arg_15_1.typewritter:SetDirty()
				arg_15_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116171", "116171004", "story_v_out_116171.awb") ~= 0 then
					local var_18_8 = manager.audio:GetVoiceLength("story_v_out_116171", "116171004", "story_v_out_116171.awb") / 1000

					if var_18_8 + var_18_2 > arg_15_1.duration_ then
						arg_15_1.duration_ = var_18_8 + var_18_2
					end

					if var_18_4.prefab_name ~= "" and arg_15_1.actors_[var_18_4.prefab_name] ~= nil then
						local var_18_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_15_1.actors_[var_18_4.prefab_name].transform, "story_v_out_116171", "116171004", "story_v_out_116171.awb")

						arg_15_1:RecordAudio("116171004", var_18_9)
						arg_15_1:RecordAudio("116171004", var_18_9)
					else
						arg_15_1:AudioAction("play", "voice", "story_v_out_116171", "116171004", "story_v_out_116171.awb")
					end

					arg_15_1:RecordHistoryTalkVoice("story_v_out_116171", "116171004", "story_v_out_116171.awb")
				end

				arg_15_1:RecordContent(arg_15_1.text_.text)
			end

			local var_18_10 = math.max(var_18_3, arg_15_1.talkMaxDuration)

			if var_18_2 <= arg_15_1.time_ and arg_15_1.time_ < var_18_2 + var_18_10 then
				arg_15_1.typewritter.percent = (arg_15_1.time_ - var_18_2) / var_18_10

				arg_15_1.typewritter:SetDirty()
			end

			if arg_15_1.time_ >= var_18_2 + var_18_10 and arg_15_1.time_ < var_18_2 + var_18_10 + arg_18_0 then
				arg_15_1.typewritter.percent = 1

				arg_15_1.typewritter:SetDirty()
				arg_15_1:ShowNextGo(true)
			end
		end

		arg_15_1.nodeConfigList_ = {}

		arg_15_1:InitPlayNodeList()
	end,
	Play116171005 = function(arg_19_0, arg_19_1)
		arg_19_1.time_ = 0
		arg_19_1.frameCnt_ = 0
		arg_19_1.state_ = "playing"
		arg_19_1.curTalkId_ = 116171005
		arg_19_1.duration_ = 8.63

		local var_19_0 = {
			zh = 8.633,
			ja = 7.6
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
				arg_19_0:Play116171006(arg_19_1)
			end
		end

		function arg_19_1.onSingleLineUpdate_(arg_22_0)
			if 0 < arg_19_1.time_ and arg_19_1.time_ <= 0 + arg_22_0 and not isNil(arg_19_1.actors_["2079ui_story"]) and arg_19_1.var_.characterEffect2079ui_story == nil then
				arg_19_1.var_.characterEffect2079ui_story = arg_19_1.actors_["2079ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_22_0 = 0.2

			if 0 <= arg_19_1.time_ and arg_19_1.time_ < 0 + var_22_0 and not isNil(arg_19_1.actors_["2079ui_story"]) then
				if arg_19_1.var_.characterEffect2079ui_story and not isNil(arg_19_1.actors_["2079ui_story"]) then
					arg_19_1.var_.characterEffect2079ui_story.fillFlat = true
					arg_19_1.var_.characterEffect2079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_19_1.time_ - 0) / var_22_0)
				end
			end

			if arg_19_1.time_ >= 0 + var_22_0 and arg_19_1.time_ < 0 + var_22_0 + arg_22_0 and not isNil(arg_19_1.actors_["2079ui_story"]) and arg_19_1.var_.characterEffect2079ui_story then
				arg_19_1.var_.characterEffect2079ui_story.fillFlat = true
				arg_19_1.var_.characterEffect2079ui_story.fillRatio = 0.5
			end

			local var_22_1 = 0
			local var_22_2 = 0.975

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= var_22_1 + arg_22_0 then
				arg_19_1.talkMaxDuration = 0
				arg_19_1.dialogCg_.alpha = 1

				arg_19_1.dialog_:SetActive(true)
				SetActive(arg_19_1.leftNameGo_, true)

				arg_19_1.leftNameTxt_.text = arg_19_1:FormatText(StoryNameCfg[264].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_19_1.leftNameTxt_.transform)

				arg_19_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_19_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_19_1:RecordName(arg_19_1.leftNameTxt_.text)
				SetActive(arg_19_1.iconTrs_.gameObject, false)
				arg_19_1.callingController_:SetSelectedState("normal")

				local var_22_3 = arg_19_1:GetWordFromCfg(116171005)
				local var_22_4 = arg_19_1:FormatText(var_22_3.content)

				arg_19_1.text_.text = var_22_4

				LuaForUtil.ClearLinePrefixSymbol(arg_19_1.text_)

				local var_22_6 = 39 <= 0 and var_22_2 or var_22_2 * (utf8.len(var_22_4) / 39)

				if (39 <= 0 and var_22_2 or var_22_2 * (utf8.len(var_22_4) / 39)) > 0 and var_22_2 < var_22_6 then
					arg_19_1.talkMaxDuration = var_22_6

					if var_22_6 + var_22_1 > arg_19_1.duration_ then
						arg_19_1.duration_ = var_22_6 + var_22_1
					end
				end

				arg_19_1.text_.text = var_22_4
				arg_19_1.typewritter.percent = 0

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116171", "116171005", "story_v_out_116171.awb") ~= 0 then
					local var_22_7 = manager.audio:GetVoiceLength("story_v_out_116171", "116171005", "story_v_out_116171.awb") / 1000

					if var_22_7 + var_22_1 > arg_19_1.duration_ then
						arg_19_1.duration_ = var_22_7 + var_22_1
					end

					if var_22_3.prefab_name ~= "" and arg_19_1.actors_[var_22_3.prefab_name] ~= nil then
						local var_22_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_19_1.actors_[var_22_3.prefab_name].transform, "story_v_out_116171", "116171005", "story_v_out_116171.awb")

						arg_19_1:RecordAudio("116171005", var_22_8)
						arg_19_1:RecordAudio("116171005", var_22_8)
					else
						arg_19_1:AudioAction("play", "voice", "story_v_out_116171", "116171005", "story_v_out_116171.awb")
					end

					arg_19_1:RecordHistoryTalkVoice("story_v_out_116171", "116171005", "story_v_out_116171.awb")
				end

				arg_19_1:RecordContent(arg_19_1.text_.text)
			end

			local var_22_9 = math.max(var_22_2, arg_19_1.talkMaxDuration)

			if var_22_1 <= arg_19_1.time_ and arg_19_1.time_ < var_22_1 + var_22_9 then
				arg_19_1.typewritter.percent = (arg_19_1.time_ - var_22_1) / var_22_9

				arg_19_1.typewritter:SetDirty()
			end

			if arg_19_1.time_ >= var_22_1 + var_22_9 and arg_19_1.time_ < var_22_1 + var_22_9 + arg_22_0 then
				arg_19_1.typewritter.percent = 1

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(true)
			end
		end

		arg_19_1.nodeConfigList_ = {}

		arg_19_1:InitPlayNodeList()
	end,
	Play116171006 = function(arg_23_0, arg_23_1)
		arg_23_1.time_ = 0
		arg_23_1.frameCnt_ = 0
		arg_23_1.state_ = "playing"
		arg_23_1.curTalkId_ = 116171006
		arg_23_1.duration_ = 6.73

		local var_23_0 = {
			zh = 4.866,
			ja = 6.733
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
				arg_23_0:Play116171007(arg_23_1)
			end
		end

		function arg_23_1.onSingleLineUpdate_(arg_26_0)
			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 and not isNil(arg_23_1.actors_["2079ui_story"]) and arg_23_1.var_.characterEffect2079ui_story == nil then
				arg_23_1.var_.characterEffect2079ui_story = arg_23_1.actors_["2079ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_26_0 = 0.2

			if 0 <= arg_23_1.time_ and arg_23_1.time_ < 0 + var_26_0 and not isNil(arg_23_1.actors_["2079ui_story"]) then
				if arg_23_1.var_.characterEffect2079ui_story and not isNil(arg_23_1.actors_["2079ui_story"]) then
					arg_23_1.var_.characterEffect2079ui_story.fillFlat = false
				end
			end

			if arg_23_1.time_ >= 0 + var_26_0 and arg_23_1.time_ < 0 + var_26_0 + arg_26_0 and not isNil(arg_23_1.actors_["2079ui_story"]) and arg_23_1.var_.characterEffect2079ui_story then
				arg_23_1.var_.characterEffect2079ui_story.fillFlat = false
			end

			local var_26_2 = 0
			local var_26_3 = 0.6

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= var_26_2 + arg_26_0 then
				arg_23_1.talkMaxDuration = 0
				arg_23_1.dialogCg_.alpha = 1

				arg_23_1.dialog_:SetActive(true)
				SetActive(arg_23_1.leftNameGo_, true)

				arg_23_1.leftNameTxt_.text = arg_23_1:FormatText(StoryNameCfg[323].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_23_1.leftNameTxt_.transform)

				arg_23_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_23_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_23_1:RecordName(arg_23_1.leftNameTxt_.text)
				SetActive(arg_23_1.iconTrs_.gameObject, false)
				arg_23_1.callingController_:SetSelectedState("normal")

				local var_26_4 = arg_23_1:GetWordFromCfg(116171006)
				local var_26_5 = arg_23_1:FormatText(var_26_4.content)

				arg_23_1.text_.text = var_26_5

				LuaForUtil.ClearLinePrefixSymbol(arg_23_1.text_)

				local var_26_7 = 24 <= 0 and var_26_3 or var_26_3 * (utf8.len(var_26_5) / 24)

				if (24 <= 0 and var_26_3 or var_26_3 * (utf8.len(var_26_5) / 24)) > 0 and var_26_3 < var_26_7 then
					arg_23_1.talkMaxDuration = var_26_7

					if var_26_7 + var_26_2 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_7 + var_26_2
					end
				end

				arg_23_1.text_.text = var_26_5
				arg_23_1.typewritter.percent = 0

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116171", "116171006", "story_v_out_116171.awb") ~= 0 then
					local var_26_8 = manager.audio:GetVoiceLength("story_v_out_116171", "116171006", "story_v_out_116171.awb") / 1000

					if var_26_8 + var_26_2 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_8 + var_26_2
					end

					if var_26_4.prefab_name ~= "" and arg_23_1.actors_[var_26_4.prefab_name] ~= nil then
						local var_26_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_23_1.actors_[var_26_4.prefab_name].transform, "story_v_out_116171", "116171006", "story_v_out_116171.awb")

						arg_23_1:RecordAudio("116171006", var_26_9)
						arg_23_1:RecordAudio("116171006", var_26_9)
					else
						arg_23_1:AudioAction("play", "voice", "story_v_out_116171", "116171006", "story_v_out_116171.awb")
					end

					arg_23_1:RecordHistoryTalkVoice("story_v_out_116171", "116171006", "story_v_out_116171.awb")
				end

				arg_23_1:RecordContent(arg_23_1.text_.text)
			end

			local var_26_10 = math.max(var_26_3, arg_23_1.talkMaxDuration)

			if var_26_2 <= arg_23_1.time_ and arg_23_1.time_ < var_26_2 + var_26_10 then
				arg_23_1.typewritter.percent = (arg_23_1.time_ - var_26_2) / var_26_10

				arg_23_1.typewritter:SetDirty()
			end

			if arg_23_1.time_ >= var_26_2 + var_26_10 and arg_23_1.time_ < var_26_2 + var_26_10 + arg_26_0 then
				arg_23_1.typewritter.percent = 1

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(true)
			end
		end

		arg_23_1.nodeConfigList_ = {}

		arg_23_1:InitPlayNodeList()
	end,
	Play116171007 = function(arg_27_0, arg_27_1)
		arg_27_1.time_ = 0
		arg_27_1.frameCnt_ = 0
		arg_27_1.state_ = "playing"
		arg_27_1.curTalkId_ = 116171007
		arg_27_1.duration_ = 8.57

		local var_27_0 = {
			zh = 6.499999999999,
			ja = 8.566
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
				arg_27_0:Play116171008(arg_27_1)
			end
		end

		function arg_27_1.onSingleLineUpdate_(arg_30_0)
			if 2 < arg_27_1.time_ and arg_27_1.time_ <= 2 + arg_30_0 then
				local var_30_0 = arg_27_1.bgs_.I06

				arg_27_1.bgs_.I06.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_30_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_30_1 = var_30_0:GetComponent("SpriteRenderer")

				if var_30_1 and var_30_1.sprite then
					local var_30_2 = 2 * (var_30_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_30_0.transform.localScale = Vector3.New(var_30_2 / var_30_1.sprite.bounds.size.y < var_30_2 * manager.ui.mainCameraCom_.aspect / var_30_1.sprite.bounds.size.x and var_30_2 * manager.ui.mainCameraCom_.aspect / var_30_1.sprite.bounds.size.x or var_30_2 / var_30_1.sprite.bounds.size.y, var_30_2 / var_30_1.sprite.bounds.size.y < var_30_2 * manager.ui.mainCameraCom_.aspect / var_30_1.sprite.bounds.size.x and var_30_2 * manager.ui.mainCameraCom_.aspect / var_30_1.sprite.bounds.size.x or var_30_2 / var_30_1.sprite.bounds.size.y, 0)
				end

				for iter_30_0, iter_30_1 in pairs(arg_27_1.bgs_) do
					if iter_30_0 ~= "I06" then
						iter_30_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_30_3 = 0

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= var_30_3 + arg_30_0 then
				arg_27_1.mask_.enabled = true
				arg_27_1.mask_.raycastTarget = true

				arg_27_1:SetGaussion(false)
			end

			local var_30_4 = 2

			if var_30_3 <= arg_27_1.time_ and arg_27_1.time_ < var_30_3 + var_30_4 then
				local var_30_5 = Color.New(0, 0, 0)

				var_30_5.a = Mathf.Lerp(0, 1, (arg_27_1.time_ - var_30_3) / var_30_4)
				arg_27_1.mask_.color = var_30_5
			end

			if arg_27_1.time_ >= var_30_3 + var_30_4 and arg_27_1.time_ < var_30_3 + var_30_4 + arg_30_0 then
				local var_30_6 = Color.New(0, 0, 0)

				var_30_6.a = 1
				arg_27_1.mask_.color = var_30_6
			end

			local var_30_7 = 2

			if 2 < arg_27_1.time_ and arg_27_1.time_ <= var_30_7 + arg_30_0 then
				arg_27_1.mask_.enabled = true
				arg_27_1.mask_.raycastTarget = true

				arg_27_1:SetGaussion(false)
			end

			local var_30_8 = 2

			if var_30_7 <= arg_27_1.time_ and arg_27_1.time_ < var_30_7 + var_30_8 then
				local var_30_9 = Color.New(0, 0, 0)

				var_30_9.a = Mathf.Lerp(1, 0, (arg_27_1.time_ - var_30_7) / var_30_8)
				arg_27_1.mask_.color = var_30_9
			end

			if arg_27_1.time_ >= var_30_7 + var_30_8 and arg_27_1.time_ < var_30_7 + var_30_8 + arg_30_0 then
				local var_30_10 = Color.New(0, 0, 0)

				arg_27_1.mask_.enabled = false
				var_30_10.a = 0
				arg_27_1.mask_.color = var_30_10
			end

			local var_30_11 = "1011ui_story"

			if arg_27_1.actors_["1011ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1011ui_story"))) then
				local var_30_12 = Object.Instantiate(Asset.Load("Char/" .. "1011ui_story"), arg_27_1.stage_.transform)

				var_30_12.name = var_30_11
				var_30_12.transform.localPosition = Vector3.New(0, 100, 0)
				arg_27_1.actors_[var_30_11] = var_30_12

				local var_30_13 = var_30_12:GetComponentInChildren(typeof(CharacterEffect))

				var_30_13.enabled = true

				local var_30_14 = GameObjectTools.GetOrAddComponent(var_30_12, typeof(DynamicBoneHelper))

				if var_30_14 then
					var_30_14:EnableDynamicBone(false)
				end

				arg_27_1:ShowWeapon(var_30_13.transform, false)

				arg_27_1.var_[var_30_11 .. "Animator"] = var_30_13.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_27_1.var_[var_30_11 .. "Animator"].applyRootMotion = true
				arg_27_1.var_[var_30_11 .. "LipSync"] = var_30_13.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_30_15 = arg_27_1.actors_["1011ui_story"].transform

			if 3.8 < arg_27_1.time_ and arg_27_1.time_ <= 3.8 + arg_30_0 then
				arg_27_1.var_.moveOldPos1011ui_story = var_30_15.localPosition
			end

			local var_30_16 = 0.001

			if 3.8 <= arg_27_1.time_ and arg_27_1.time_ < 3.8 + var_30_16 then
				var_30_15.localPosition = Vector3.Lerp(arg_27_1.var_.moveOldPos1011ui_story, Vector3.New(-0.7, -0.71, -6), (arg_27_1.time_ - 3.8) / var_30_16)
				var_30_15.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_30_15.position).x, (manager.ui.mainCamera.transform.position - var_30_15.position).y, (manager.ui.mainCamera.transform.position - var_30_15.position).z)
				var_30_15.localEulerAngles.z = 0
				var_30_15.localEulerAngles.x = 0
				var_30_15.localEulerAngles = var_30_15.localEulerAngles
			end

			if arg_27_1.time_ >= 3.8 + var_30_16 and arg_27_1.time_ < 3.8 + var_30_16 + arg_30_0 then
				var_30_15.localPosition = Vector3.New(-0.7, -0.71, -6)
				var_30_15.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_30_15.position).x, (manager.ui.mainCamera.transform.position - var_30_15.position).y, (manager.ui.mainCamera.transform.position - var_30_15.position).z)
				var_30_15.localEulerAngles.z = 0
				var_30_15.localEulerAngles.x = 0
				var_30_15.localEulerAngles = var_30_15.localEulerAngles
			end

			if 3.8 < arg_27_1.time_ and arg_27_1.time_ <= 3.8 + arg_30_0 then
				arg_27_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action6_1")
			end

			if 3.8 < arg_27_1.time_ and arg_27_1.time_ <= 3.8 + arg_30_0 then
				arg_27_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_30_17 = arg_27_1.actors_["1011ui_story"]

			if 3.8 < arg_27_1.time_ and arg_27_1.time_ <= 3.8 + arg_30_0 and not isNil(var_30_17) and arg_27_1.var_.characterEffect1011ui_story == nil then
				arg_27_1.var_.characterEffect1011ui_story = var_30_17:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_30_18 = 0.2

			if 3.8 <= arg_27_1.time_ and arg_27_1.time_ < 3.8 + var_30_18 and not isNil(var_30_17) then
				if arg_27_1.var_.characterEffect1011ui_story and not isNil(var_30_17) then
					arg_27_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_27_1.time_ >= 3.8 + var_30_18 and arg_27_1.time_ < 3.8 + var_30_18 + arg_30_0 and not isNil(var_30_17) and arg_27_1.var_.characterEffect1011ui_story then
				arg_27_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_30_20 = arg_27_1.actors_["2079ui_story"].transform

			if 1.966 < arg_27_1.time_ and arg_27_1.time_ <= 1.966 + arg_30_0 then
				arg_27_1.var_.moveOldPos2079ui_story = var_30_20.localPosition
			end

			local var_30_21 = 0.001

			if 1.966 <= arg_27_1.time_ and arg_27_1.time_ < 1.966 + var_30_21 then
				var_30_20.localPosition = Vector3.Lerp(arg_27_1.var_.moveOldPos2079ui_story, Vector3.New(0, 100, 0), (arg_27_1.time_ - 1.966) / var_30_21)
				var_30_20.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_30_20.position).x, (manager.ui.mainCamera.transform.position - var_30_20.position).y, (manager.ui.mainCamera.transform.position - var_30_20.position).z)
				var_30_20.localEulerAngles.z = 0
				var_30_20.localEulerAngles.x = 0
				var_30_20.localEulerAngles = var_30_20.localEulerAngles
			end

			if arg_27_1.time_ >= 1.966 + var_30_21 and arg_27_1.time_ < 1.966 + var_30_21 + arg_30_0 then
				var_30_20.localPosition = Vector3.New(0, 100, 0)
				var_30_20.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_30_20.position).x, (manager.ui.mainCamera.transform.position - var_30_20.position).y, (manager.ui.mainCamera.transform.position - var_30_20.position).z)
				var_30_20.localEulerAngles.z = 0
				var_30_20.localEulerAngles.x = 0
				var_30_20.localEulerAngles = var_30_20.localEulerAngles
			end

			local var_30_22 = arg_27_1.actors_["10014ui_story"].transform

			if 1.966 < arg_27_1.time_ and arg_27_1.time_ <= 1.966 + arg_30_0 then
				arg_27_1.var_.moveOldPos10014ui_story = var_30_22.localPosition
			end

			local var_30_23 = 0.001

			if 1.966 <= arg_27_1.time_ and arg_27_1.time_ < 1.966 + var_30_23 then
				var_30_22.localPosition = Vector3.Lerp(arg_27_1.var_.moveOldPos10014ui_story, Vector3.New(0, 100, 0), (arg_27_1.time_ - 1.966) / var_30_23)
				var_30_22.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_30_22.position).x, (manager.ui.mainCamera.transform.position - var_30_22.position).y, (manager.ui.mainCamera.transform.position - var_30_22.position).z)
				var_30_22.localEulerAngles.z = 0
				var_30_22.localEulerAngles.x = 0
				var_30_22.localEulerAngles = var_30_22.localEulerAngles
			end

			if arg_27_1.time_ >= 1.966 + var_30_23 and arg_27_1.time_ < 1.966 + var_30_23 + arg_30_0 then
				var_30_22.localPosition = Vector3.New(0, 100, 0)
				var_30_22.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_30_22.position).x, (manager.ui.mainCamera.transform.position - var_30_22.position).y, (manager.ui.mainCamera.transform.position - var_30_22.position).z)
				var_30_22.localEulerAngles.z = 0
				var_30_22.localEulerAngles.x = 0
				var_30_22.localEulerAngles = var_30_22.localEulerAngles
			end

			if arg_27_1.frameCnt_ <= 1 then
				arg_27_1.dialog_:SetActive(false)
			end

			local var_30_24 = 4
			local var_30_25 = 0.25

			if 4 < arg_27_1.time_ and arg_27_1.time_ <= var_30_24 + arg_30_0 then
				arg_27_1.talkMaxDuration = 0

				arg_27_1.dialog_:SetActive(true)

				arg_27_1.dialogCg_.alpha = 0

				local var_30_26 = LeanTween.value(arg_27_1.dialog_, 0, 1, 0.3)

				var_30_26:setOnUpdate(LuaHelper.FloatAction(function(arg_31_0)
					arg_27_1.dialogCg_.alpha = arg_31_0
				end))
				var_30_26:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_27_1.dialog_)
					var_30_26:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_27_1.duration_ = arg_27_1.duration_ + 0.3

				SetActive(arg_27_1.leftNameGo_, true)

				arg_27_1.leftNameTxt_.text = arg_27_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_27_1.leftNameTxt_.transform)

				arg_27_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_27_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_27_1:RecordName(arg_27_1.leftNameTxt_.text)
				SetActive(arg_27_1.iconTrs_.gameObject, false)
				arg_27_1.callingController_:SetSelectedState("normal")

				local var_30_27 = arg_27_1:GetWordFromCfg(116171007)
				local var_30_28 = arg_27_1:FormatText(var_30_27.content)

				arg_27_1.text_.text = var_30_28

				LuaForUtil.ClearLinePrefixSymbol(arg_27_1.text_)

				local var_30_30 = 10 <= 0 and var_30_25 or var_30_25 * (utf8.len(var_30_28) / 10)

				if (10 <= 0 and var_30_25 or var_30_25 * (utf8.len(var_30_28) / 10)) > 0 and var_30_25 < var_30_30 then
					arg_27_1.talkMaxDuration = var_30_30
					var_30_24 = var_30_24 + 0.3

					if var_30_30 + var_30_24 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_30 + var_30_24
					end
				end

				arg_27_1.text_.text = var_30_28
				arg_27_1.typewritter.percent = 0

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116171", "116171007", "story_v_out_116171.awb") ~= 0 then
					local var_30_31 = manager.audio:GetVoiceLength("story_v_out_116171", "116171007", "story_v_out_116171.awb") / 1000

					if var_30_31 + var_30_24 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_31 + var_30_24
					end

					if var_30_27.prefab_name ~= "" and arg_27_1.actors_[var_30_27.prefab_name] ~= nil then
						local var_30_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_27_1.actors_[var_30_27.prefab_name].transform, "story_v_out_116171", "116171007", "story_v_out_116171.awb")

						arg_27_1:RecordAudio("116171007", var_30_32)
						arg_27_1:RecordAudio("116171007", var_30_32)
					else
						arg_27_1:AudioAction("play", "voice", "story_v_out_116171", "116171007", "story_v_out_116171.awb")
					end

					arg_27_1:RecordHistoryTalkVoice("story_v_out_116171", "116171007", "story_v_out_116171.awb")
				end

				arg_27_1:RecordContent(arg_27_1.text_.text)
			end

			local var_30_33 = var_30_24 + 0.3
			local var_30_34 = math.max(var_30_25, arg_27_1.talkMaxDuration)

			if var_30_24 + 0.3 <= arg_27_1.time_ and arg_27_1.time_ < var_30_33 + var_30_34 then
				arg_27_1.typewritter.percent = (arg_27_1.time_ - var_30_33) / var_30_34

				arg_27_1.typewritter:SetDirty()
			end

			if arg_27_1.time_ >= var_30_33 + var_30_34 and arg_27_1.time_ < var_30_33 + var_30_34 + arg_30_0 then
				arg_27_1.typewritter.percent = 1

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(true)
			end
		end

		arg_27_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "2079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10014ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_27_1:InitPlayNodeList()
	end,
	Play116171008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 116171008
		arg_33_1.duration_ = 5.4

		local var_33_0 = {
			zh = 4.766,
			ja = 5.4
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
				arg_33_0:Play116171009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if arg_33_1.actors_["1084ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1084ui_story"))) then
				local var_36_0 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_33_1.stage_.transform)

				var_36_0.name = "1084ui_story"
				var_36_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_33_1.actors_["1084ui_story"] = var_36_0

				local var_36_1 = var_36_0:GetComponentInChildren(typeof(CharacterEffect))

				var_36_1.enabled = true

				local var_36_2 = GameObjectTools.GetOrAddComponent(var_36_0, typeof(DynamicBoneHelper))

				if var_36_2 then
					var_36_2:EnableDynamicBone(false)
				end

				arg_33_1:ShowWeapon(var_36_1.transform, false)

				arg_33_1.var_["1084ui_story" .. "Animator"] = var_36_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_33_1.var_["1084ui_story" .. "Animator"].applyRootMotion = true
				arg_33_1.var_["1084ui_story" .. "LipSync"] = var_36_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_36_3 = arg_33_1.actors_["1084ui_story"].transform

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1.var_.moveOldPos1084ui_story = var_36_3.localPosition
			end

			local var_36_4 = 0.001

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_4 then
				var_36_3.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos1084ui_story, Vector3.New(0.7, -0.97, -6), (arg_33_1.time_ - 0) / var_36_4)
				var_36_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_36_3.position).x, (manager.ui.mainCamera.transform.position - var_36_3.position).y, (manager.ui.mainCamera.transform.position - var_36_3.position).z)
				var_36_3.localEulerAngles.z = 0
				var_36_3.localEulerAngles.x = 0
				var_36_3.localEulerAngles = var_36_3.localEulerAngles
			end

			if arg_33_1.time_ >= 0 + var_36_4 and arg_33_1.time_ < 0 + var_36_4 + arg_36_0 then
				var_36_3.localPosition = Vector3.New(0.7, -0.97, -6)
				var_36_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_36_3.position).x, (manager.ui.mainCamera.transform.position - var_36_3.position).y, (manager.ui.mainCamera.transform.position - var_36_3.position).z)
				var_36_3.localEulerAngles.z = 0
				var_36_3.localEulerAngles.x = 0
				var_36_3.localEulerAngles = var_36_3.localEulerAngles
			end

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action10_2")
			end

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_36_5 = arg_33_1.actors_["1084ui_story"]

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(var_36_5) and arg_33_1.var_.characterEffect1084ui_story == nil then
				arg_33_1.var_.characterEffect1084ui_story = var_36_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_6 = 0.2

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_6 and not isNil(var_36_5) then
				if arg_33_1.var_.characterEffect1084ui_story and not isNil(var_36_5) then
					arg_33_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_33_1.time_ >= 0 + var_36_6 and arg_33_1.time_ < 0 + var_36_6 + arg_36_0 and not isNil(var_36_5) and arg_33_1.var_.characterEffect1084ui_story then
				arg_33_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_36_8 = arg_33_1.actors_["1011ui_story"]

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(var_36_8) and arg_33_1.var_.characterEffect1011ui_story == nil then
				arg_33_1.var_.characterEffect1011ui_story = var_36_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_9 = 0.2

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_9 and not isNil(var_36_8) then
				if arg_33_1.var_.characterEffect1011ui_story and not isNil(var_36_8) then
					arg_33_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_33_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_33_1.time_ - 0) / var_36_9)
				end
			end

			if arg_33_1.time_ >= 0 + var_36_9 and arg_33_1.time_ < 0 + var_36_9 + arg_36_0 and not isNil(var_36_8) and arg_33_1.var_.characterEffect1011ui_story then
				arg_33_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_33_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			local var_36_10 = 0
			local var_36_11 = 0.325

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_10 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				arg_33_1.leftNameTxt_.text = arg_33_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_12 = arg_33_1:GetWordFromCfg(116171008)
				local var_36_13 = arg_33_1:FormatText(var_36_12.content)

				arg_33_1.text_.text = var_36_13

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_15 = 13 <= 0 and var_36_11 or var_36_11 * (utf8.len(var_36_13) / 13)

				if (13 <= 0 and var_36_11 or var_36_11 * (utf8.len(var_36_13) / 13)) > 0 and var_36_11 < var_36_15 then
					arg_33_1.talkMaxDuration = var_36_15

					if var_36_15 + var_36_10 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_15 + var_36_10
					end
				end

				arg_33_1.text_.text = var_36_13
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116171", "116171008", "story_v_out_116171.awb") ~= 0 then
					local var_36_16 = manager.audio:GetVoiceLength("story_v_out_116171", "116171008", "story_v_out_116171.awb") / 1000

					if var_36_16 + var_36_10 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_16 + var_36_10
					end

					if var_36_12.prefab_name ~= "" and arg_33_1.actors_[var_36_12.prefab_name] ~= nil then
						local var_36_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_12.prefab_name].transform, "story_v_out_116171", "116171008", "story_v_out_116171.awb")

						arg_33_1:RecordAudio("116171008", var_36_17)
						arg_33_1:RecordAudio("116171008", var_36_17)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_116171", "116171008", "story_v_out_116171.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_116171", "116171008", "story_v_out_116171.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_18 = math.max(var_36_11, arg_33_1.talkMaxDuration)

			if var_36_10 <= arg_33_1.time_ and arg_33_1.time_ < var_36_10 + var_36_18 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_10) / var_36_18

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_10 + var_36_18 and arg_33_1.time_ < var_36_10 + var_36_18 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_33_1:InitPlayNodeList()
	end,
	Play116171009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 116171009
		arg_37_1.duration_ = 5.7

		local var_37_0 = {
			zh = 5.1,
			ja = 5.7
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
				arg_37_0:Play116171010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(arg_37_1.actors_["1011ui_story"]) and arg_37_1.var_.characterEffect1011ui_story == nil then
				arg_37_1.var_.characterEffect1011ui_story = arg_37_1.actors_["1011ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_0 = 0.2

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_0 and not isNil(arg_37_1.actors_["1011ui_story"]) then
				if arg_37_1.var_.characterEffect1011ui_story and not isNil(arg_37_1.actors_["1011ui_story"]) then
					arg_37_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_37_1.time_ >= 0 + var_40_0 and arg_37_1.time_ < 0 + var_40_0 + arg_40_0 and not isNil(arg_37_1.actors_["1011ui_story"]) and arg_37_1.var_.characterEffect1011ui_story then
				arg_37_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_40_2 = arg_37_1.actors_["1084ui_story"]

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(var_40_2) and arg_37_1.var_.characterEffect1084ui_story == nil then
				arg_37_1.var_.characterEffect1084ui_story = var_40_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_3 = 0.2

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_3 and not isNil(var_40_2) then
				if arg_37_1.var_.characterEffect1084ui_story and not isNil(var_40_2) then
					arg_37_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_37_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_37_1.time_ - 0) / var_40_3)
				end
			end

			if arg_37_1.time_ >= 0 + var_40_3 and arg_37_1.time_ < 0 + var_40_3 + arg_40_0 and not isNil(var_40_2) and arg_37_1.var_.characterEffect1084ui_story then
				arg_37_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_37_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_40_4 = 0
			local var_40_5 = 0.5

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_4 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				arg_37_1.leftNameTxt_.text = arg_37_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_6 = arg_37_1:GetWordFromCfg(116171009)
				local var_40_7 = arg_37_1:FormatText(var_40_6.content)

				arg_37_1.text_.text = var_40_7

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_9 = 20 <= 0 and var_40_5 or var_40_5 * (utf8.len(var_40_7) / 20)

				if (20 <= 0 and var_40_5 or var_40_5 * (utf8.len(var_40_7) / 20)) > 0 and var_40_5 < var_40_9 then
					arg_37_1.talkMaxDuration = var_40_9

					if var_40_9 + var_40_4 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_9 + var_40_4
					end
				end

				arg_37_1.text_.text = var_40_7
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116171", "116171009", "story_v_out_116171.awb") ~= 0 then
					local var_40_10 = manager.audio:GetVoiceLength("story_v_out_116171", "116171009", "story_v_out_116171.awb") / 1000

					if var_40_10 + var_40_4 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_10 + var_40_4
					end

					if var_40_6.prefab_name ~= "" and arg_37_1.actors_[var_40_6.prefab_name] ~= nil then
						local var_40_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_6.prefab_name].transform, "story_v_out_116171", "116171009", "story_v_out_116171.awb")

						arg_37_1:RecordAudio("116171009", var_40_11)
						arg_37_1:RecordAudio("116171009", var_40_11)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_116171", "116171009", "story_v_out_116171.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_116171", "116171009", "story_v_out_116171.awb")
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

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play116171010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 116171010
		arg_41_1.duration_ = 5

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play116171011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.var_.moveOldPos1011ui_story = arg_41_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_44_0 = 0.001

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_0 then
				arg_41_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos1011ui_story, Vector3.New(0, 100, 0), (arg_41_1.time_ - 0) / var_44_0)
				arg_41_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_41_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["1011ui_story"].transform.position).z)
				arg_41_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_41_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_41_1.actors_["1011ui_story"].transform.localEulerAngles = arg_41_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_41_1.time_ >= 0 + var_44_0 and arg_41_1.time_ < 0 + var_44_0 + arg_44_0 then
				arg_41_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_41_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_41_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["1011ui_story"].transform.position).z)
				arg_41_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_41_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_41_1.actors_["1011ui_story"].transform.localEulerAngles = arg_41_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_44_1 = arg_41_1.actors_["1084ui_story"].transform

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.var_.moveOldPos1084ui_story = var_44_1.localPosition
			end

			local var_44_2 = 0.001

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_2 then
				var_44_1.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_41_1.time_ - 0) / var_44_2)
				var_44_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_44_1.position).x, (manager.ui.mainCamera.transform.position - var_44_1.position).y, (manager.ui.mainCamera.transform.position - var_44_1.position).z)
				var_44_1.localEulerAngles.z = 0
				var_44_1.localEulerAngles.x = 0
				var_44_1.localEulerAngles = var_44_1.localEulerAngles
			end

			if arg_41_1.time_ >= 0 + var_44_2 and arg_41_1.time_ < 0 + var_44_2 + arg_44_0 then
				var_44_1.localPosition = Vector3.New(0, 100, 0)
				var_44_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_44_1.position).x, (manager.ui.mainCamera.transform.position - var_44_1.position).y, (manager.ui.mainCamera.transform.position - var_44_1.position).z)
				var_44_1.localEulerAngles.z = 0
				var_44_1.localEulerAngles.x = 0
				var_44_1.localEulerAngles = var_44_1.localEulerAngles
			end

			local var_44_3 = 0
			local var_44_4 = 0.65

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_3 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, false)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_5 = arg_41_1:FormatText(arg_41_1:GetWordFromCfg(116171010).content)

				arg_41_1.text_.text = var_44_5

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_7 = 26 <= 0 and var_44_4 or var_44_4 * (utf8.len(var_44_5) / 26)

				if (26 <= 0 and var_44_4 or var_44_4 * (utf8.len(var_44_5) / 26)) > 0 and var_44_4 < var_44_7 then
					arg_41_1.talkMaxDuration = var_44_7

					if var_44_7 + var_44_3 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_7 + var_44_3
					end
				end

				arg_41_1.text_.text = var_44_5
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)
				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_8 = math.max(var_44_4, arg_41_1.talkMaxDuration)

			if var_44_3 <= arg_41_1.time_ and arg_41_1.time_ < var_44_3 + var_44_8 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_3) / var_44_8

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_3 + var_44_8 and arg_41_1.time_ < var_44_3 + var_44_8 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_41_1:InitPlayNodeList()
	end,
	Play116171011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 116171011
		arg_45_1.duration_ = 7.4

		local var_45_0 = {
			zh = 7,
			ja = 7.4
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
				arg_45_0:Play116171012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_1")
			end

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_48_0 = arg_45_1.actors_["1084ui_story"]

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 and not isNil(var_48_0) and arg_45_1.var_.characterEffect1084ui_story == nil then
				arg_45_1.var_.characterEffect1084ui_story = var_48_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_1 = 0.2

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_1 and not isNil(var_48_0) then
				if arg_45_1.var_.characterEffect1084ui_story and not isNil(var_48_0) then
					arg_45_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_45_1.time_ >= 0 + var_48_1 and arg_45_1.time_ < 0 + var_48_1 + arg_48_0 and not isNil(var_48_0) and arg_45_1.var_.characterEffect1084ui_story then
				arg_45_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_48_3 = arg_45_1.actors_["1084ui_story"].transform

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1.var_.moveOldPos1084ui_story = var_48_3.localPosition
			end

			local var_48_4 = 0.001

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_4 then
				var_48_3.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos1084ui_story, Vector3.New(-0.7, -0.97, -6), (arg_45_1.time_ - 0) / var_48_4)
				var_48_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_48_3.position).x, (manager.ui.mainCamera.transform.position - var_48_3.position).y, (manager.ui.mainCamera.transform.position - var_48_3.position).z)
				var_48_3.localEulerAngles.z = 0
				var_48_3.localEulerAngles.x = 0
				var_48_3.localEulerAngles = var_48_3.localEulerAngles
			end

			if arg_45_1.time_ >= 0 + var_48_4 and arg_45_1.time_ < 0 + var_48_4 + arg_48_0 then
				var_48_3.localPosition = Vector3.New(-0.7, -0.97, -6)
				var_48_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_48_3.position).x, (manager.ui.mainCamera.transform.position - var_48_3.position).y, (manager.ui.mainCamera.transform.position - var_48_3.position).z)
				var_48_3.localEulerAngles.z = 0
				var_48_3.localEulerAngles.x = 0
				var_48_3.localEulerAngles = var_48_3.localEulerAngles
			end

			local var_48_5 = 0
			local var_48_6 = 0.575

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_5 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				arg_45_1.leftNameTxt_.text = arg_45_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_7 = arg_45_1:GetWordFromCfg(116171011)
				local var_48_8 = arg_45_1:FormatText(var_48_7.content)

				arg_45_1.text_.text = var_48_8

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_10 = 23 <= 0 and var_48_6 or var_48_6 * (utf8.len(var_48_8) / 23)

				if (23 <= 0 and var_48_6 or var_48_6 * (utf8.len(var_48_8) / 23)) > 0 and var_48_6 < var_48_10 then
					arg_45_1.talkMaxDuration = var_48_10

					if var_48_10 + var_48_5 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_10 + var_48_5
					end
				end

				arg_45_1.text_.text = var_48_8
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116171", "116171011", "story_v_out_116171.awb") ~= 0 then
					local var_48_11 = manager.audio:GetVoiceLength("story_v_out_116171", "116171011", "story_v_out_116171.awb") / 1000

					if var_48_11 + var_48_5 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_11 + var_48_5
					end

					if var_48_7.prefab_name ~= "" and arg_45_1.actors_[var_48_7.prefab_name] ~= nil then
						local var_48_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_7.prefab_name].transform, "story_v_out_116171", "116171011", "story_v_out_116171.awb")

						arg_45_1:RecordAudio("116171011", var_48_12)
						arg_45_1:RecordAudio("116171011", var_48_12)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_116171", "116171011", "story_v_out_116171.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_116171", "116171011", "story_v_out_116171.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_13 = math.max(var_48_6, arg_45_1.talkMaxDuration)

			if var_48_5 <= arg_45_1.time_ and arg_45_1.time_ < var_48_5 + var_48_13 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_5) / var_48_13

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_5 + var_48_13 and arg_45_1.time_ < var_48_5 + var_48_13 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
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
	Play116171012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 116171012
		arg_49_1.duration_ = 3.4

		local var_49_0 = {
			zh = 2.733,
			ja = 3.4
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
				arg_49_0:Play116171013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 and not isNil(arg_49_1.actors_["1011ui_story"]) and arg_49_1.var_.characterEffect1011ui_story == nil then
				arg_49_1.var_.characterEffect1011ui_story = arg_49_1.actors_["1011ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_0 = 0.2

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_0 and not isNil(arg_49_1.actors_["1011ui_story"]) then
				if arg_49_1.var_.characterEffect1011ui_story and not isNil(arg_49_1.actors_["1011ui_story"]) then
					arg_49_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_49_1.time_ >= 0 + var_52_0 and arg_49_1.time_ < 0 + var_52_0 + arg_52_0 and not isNil(arg_49_1.actors_["1011ui_story"]) and arg_49_1.var_.characterEffect1011ui_story then
				arg_49_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action2_1")
			end

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_52_2 = arg_49_1.actors_["1084ui_story"]

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 and not isNil(var_52_2) and arg_49_1.var_.characterEffect1084ui_story == nil then
				arg_49_1.var_.characterEffect1084ui_story = var_52_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_3 = 0.2

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_3 and not isNil(var_52_2) then
				if arg_49_1.var_.characterEffect1084ui_story and not isNil(var_52_2) then
					arg_49_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_49_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_49_1.time_ - 0) / var_52_3)
				end
			end

			if arg_49_1.time_ >= 0 + var_52_3 and arg_49_1.time_ < 0 + var_52_3 + arg_52_0 and not isNil(var_52_2) and arg_49_1.var_.characterEffect1084ui_story then
				arg_49_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_49_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_52_4 = arg_49_1.actors_["1011ui_story"].transform

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1.var_.moveOldPos1011ui_story = var_52_4.localPosition
			end

			local var_52_5 = 0.001

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_5 then
				var_52_4.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos1011ui_story, Vector3.New(0.7, -0.71, -6), (arg_49_1.time_ - 0) / var_52_5)
				var_52_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_52_4.position).x, (manager.ui.mainCamera.transform.position - var_52_4.position).y, (manager.ui.mainCamera.transform.position - var_52_4.position).z)
				var_52_4.localEulerAngles.z = 0
				var_52_4.localEulerAngles.x = 0
				var_52_4.localEulerAngles = var_52_4.localEulerAngles
			end

			if arg_49_1.time_ >= 0 + var_52_5 and arg_49_1.time_ < 0 + var_52_5 + arg_52_0 then
				var_52_4.localPosition = Vector3.New(0.7, -0.71, -6)
				var_52_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_52_4.position).x, (manager.ui.mainCamera.transform.position - var_52_4.position).y, (manager.ui.mainCamera.transform.position - var_52_4.position).z)
				var_52_4.localEulerAngles.z = 0
				var_52_4.localEulerAngles.x = 0
				var_52_4.localEulerAngles = var_52_4.localEulerAngles
			end

			local var_52_6 = 0
			local var_52_7 = 0.275

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_6 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				arg_49_1.leftNameTxt_.text = arg_49_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_8 = arg_49_1:GetWordFromCfg(116171012)
				local var_52_9 = arg_49_1:FormatText(var_52_8.content)

				arg_49_1.text_.text = var_52_9

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_11 = 11 <= 0 and var_52_7 or var_52_7 * (utf8.len(var_52_9) / 11)

				if (11 <= 0 and var_52_7 or var_52_7 * (utf8.len(var_52_9) / 11)) > 0 and var_52_7 < var_52_11 then
					arg_49_1.talkMaxDuration = var_52_11

					if var_52_11 + var_52_6 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_11 + var_52_6
					end
				end

				arg_49_1.text_.text = var_52_9
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116171", "116171012", "story_v_out_116171.awb") ~= 0 then
					local var_52_12 = manager.audio:GetVoiceLength("story_v_out_116171", "116171012", "story_v_out_116171.awb") / 1000

					if var_52_12 + var_52_6 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_12 + var_52_6
					end

					if var_52_8.prefab_name ~= "" and arg_49_1.actors_[var_52_8.prefab_name] ~= nil then
						local var_52_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_8.prefab_name].transform, "story_v_out_116171", "116171012", "story_v_out_116171.awb")

						arg_49_1:RecordAudio("116171012", var_52_13)
						arg_49_1:RecordAudio("116171012", var_52_13)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_116171", "116171012", "story_v_out_116171.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_116171", "116171012", "story_v_out_116171.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_14 = math.max(var_52_7, arg_49_1.talkMaxDuration)

			if var_52_6 <= arg_49_1.time_ and arg_49_1.time_ < var_52_6 + var_52_14 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_6) / var_52_14

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_6 + var_52_14 and arg_49_1.time_ < var_52_6 + var_52_14 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
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
	Play116171013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 116171013
		arg_53_1.duration_ = 4.93

		local var_53_0 = {
			zh = 3.666,
			ja = 4.933
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
				arg_53_0:Play116171014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1.var_.moveOldPos1011ui_story = arg_53_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_56_0 = 0.001

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_0 then
				arg_53_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos1011ui_story, Vector3.New(0, 100, 0), (arg_53_1.time_ - 0) / var_56_0)
				arg_53_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_53_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["1011ui_story"].transform.position).z)
				arg_53_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_53_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_53_1.actors_["1011ui_story"].transform.localEulerAngles = arg_53_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_53_1.time_ >= 0 + var_56_0 and arg_53_1.time_ < 0 + var_56_0 + arg_56_0 then
				arg_53_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_53_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_53_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["1011ui_story"].transform.position).z)
				arg_53_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_53_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_53_1.actors_["1011ui_story"].transform.localEulerAngles = arg_53_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_56_1 = arg_53_1.actors_["1084ui_story"].transform

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1.var_.moveOldPos1084ui_story = var_56_1.localPosition
			end

			local var_56_2 = 0.001

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_2 then
				var_56_1.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_53_1.time_ - 0) / var_56_2)
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

			local var_56_3 = 0
			local var_56_4 = 0.3

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_3 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				arg_53_1.leftNameTxt_.text = arg_53_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, true)
				arg_53_1.iconController_:SetSelectedState("hero")

				arg_53_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1084")

				arg_53_1.callingController_:SetSelectedState("normal")

				arg_53_1.keyicon_.color = Color.New(1, 1, 1)
				arg_53_1.icon_.color = Color.New(1, 1, 1)

				local var_56_5 = arg_53_1:GetWordFromCfg(116171013)
				local var_56_6 = arg_53_1:FormatText(var_56_5.content)

				arg_53_1.text_.text = var_56_6

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_8 = 12 <= 0 and var_56_4 or var_56_4 * (utf8.len(var_56_6) / 12)

				if (12 <= 0 and var_56_4 or var_56_4 * (utf8.len(var_56_6) / 12)) > 0 and var_56_4 < var_56_8 then
					arg_53_1.talkMaxDuration = var_56_8

					if var_56_8 + var_56_3 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_8 + var_56_3
					end
				end

				arg_53_1.text_.text = var_56_6
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116171", "116171013", "story_v_out_116171.awb") ~= 0 then
					local var_56_9 = manager.audio:GetVoiceLength("story_v_out_116171", "116171013", "story_v_out_116171.awb") / 1000

					if var_56_9 + var_56_3 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_9 + var_56_3
					end

					if var_56_5.prefab_name ~= "" and arg_53_1.actors_[var_56_5.prefab_name] ~= nil then
						local var_56_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_5.prefab_name].transform, "story_v_out_116171", "116171013", "story_v_out_116171.awb")

						arg_53_1:RecordAudio("116171013", var_56_10)
						arg_53_1:RecordAudio("116171013", var_56_10)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_116171", "116171013", "story_v_out_116171.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_116171", "116171013", "story_v_out_116171.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_11 = math.max(var_56_4, arg_53_1.talkMaxDuration)

			if var_56_3 <= arg_53_1.time_ and arg_53_1.time_ < var_56_3 + var_56_11 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_3) / var_56_11

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_3 + var_56_11 and arg_53_1.time_ < var_56_3 + var_56_11 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
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
	Play116171014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 116171014
		arg_57_1.duration_ = 3.73

		local var_57_0 = {
			zh = 2.933,
			ja = 3.733
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
				arg_57_0:Play116171015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action3_1")
			end

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_60_0 = arg_57_1.actors_["1084ui_story"]

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 and not isNil(var_60_0) and arg_57_1.var_.characterEffect1084ui_story == nil then
				arg_57_1.var_.characterEffect1084ui_story = var_60_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_1 = 0.2

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_1 and not isNil(var_60_0) then
				if arg_57_1.var_.characterEffect1084ui_story and not isNil(var_60_0) then
					arg_57_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_57_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_57_1.time_ - 0) / var_60_1)
				end
			end

			if arg_57_1.time_ >= 0 + var_60_1 and arg_57_1.time_ < 0 + var_60_1 + arg_60_0 and not isNil(var_60_0) and arg_57_1.var_.characterEffect1084ui_story then
				arg_57_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_57_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_60_2 = arg_57_1.actors_["1011ui_story"].transform

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1.var_.moveOldPos1011ui_story = var_60_2.localPosition
			end

			local var_60_3 = 0.001

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_3 then
				var_60_2.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos1011ui_story, Vector3.New(-0.7, -0.71, -6), (arg_57_1.time_ - 0) / var_60_3)
				var_60_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_60_2.position).x, (manager.ui.mainCamera.transform.position - var_60_2.position).y, (manager.ui.mainCamera.transform.position - var_60_2.position).z)
				var_60_2.localEulerAngles.z = 0
				var_60_2.localEulerAngles.x = 0
				var_60_2.localEulerAngles = var_60_2.localEulerAngles
			end

			if arg_57_1.time_ >= 0 + var_60_3 and arg_57_1.time_ < 0 + var_60_3 + arg_60_0 then
				var_60_2.localPosition = Vector3.New(-0.7, -0.71, -6)
				var_60_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_60_2.position).x, (manager.ui.mainCamera.transform.position - var_60_2.position).y, (manager.ui.mainCamera.transform.position - var_60_2.position).z)
				var_60_2.localEulerAngles.z = 0
				var_60_2.localEulerAngles.x = 0
				var_60_2.localEulerAngles = var_60_2.localEulerAngles
			end

			local var_60_4 = 0
			local var_60_5 = 0.25

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_4 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				arg_57_1.leftNameTxt_.text = arg_57_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_6 = arg_57_1:GetWordFromCfg(116171014)
				local var_60_7 = arg_57_1:FormatText(var_60_6.content)

				arg_57_1.text_.text = var_60_7

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_9 = 10 <= 0 and var_60_5 or var_60_5 * (utf8.len(var_60_7) / 10)

				if (10 <= 0 and var_60_5 or var_60_5 * (utf8.len(var_60_7) / 10)) > 0 and var_60_5 < var_60_9 then
					arg_57_1.talkMaxDuration = var_60_9

					if var_60_9 + var_60_4 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_9 + var_60_4
					end
				end

				arg_57_1.text_.text = var_60_7
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116171", "116171014", "story_v_out_116171.awb") ~= 0 then
					local var_60_10 = manager.audio:GetVoiceLength("story_v_out_116171", "116171014", "story_v_out_116171.awb") / 1000

					if var_60_10 + var_60_4 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_10 + var_60_4
					end

					if var_60_6.prefab_name ~= "" and arg_57_1.actors_[var_60_6.prefab_name] ~= nil then
						local var_60_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_6.prefab_name].transform, "story_v_out_116171", "116171014", "story_v_out_116171.awb")

						arg_57_1:RecordAudio("116171014", var_60_11)
						arg_57_1:RecordAudio("116171014", var_60_11)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_116171", "116171014", "story_v_out_116171.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_116171", "116171014", "story_v_out_116171.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_12 = math.max(var_60_5, arg_57_1.talkMaxDuration)

			if var_60_4 <= arg_57_1.time_ and arg_57_1.time_ < var_60_4 + var_60_12 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_4) / var_60_12

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_4 + var_60_12 and arg_57_1.time_ < var_60_4 + var_60_12 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
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
	Play116171015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 116171015
		arg_61_1.duration_ = 6.5

		local var_61_0 = {
			zh = 6.066,
			ja = 6.5
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
				arg_61_0:Play116171016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_64_0 = arg_61_1.actors_["1084ui_story"]

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 and not isNil(var_64_0) and arg_61_1.var_.characterEffect1084ui_story == nil then
				arg_61_1.var_.characterEffect1084ui_story = var_64_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_1 = 0.2

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_1 and not isNil(var_64_0) then
				if arg_61_1.var_.characterEffect1084ui_story and not isNil(var_64_0) then
					arg_61_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_61_1.time_ >= 0 + var_64_1 and arg_61_1.time_ < 0 + var_64_1 + arg_64_0 and not isNil(var_64_0) and arg_61_1.var_.characterEffect1084ui_story then
				arg_61_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_64_3 = arg_61_1.actors_["1011ui_story"]

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 and not isNil(var_64_3) and arg_61_1.var_.characterEffect1011ui_story == nil then
				arg_61_1.var_.characterEffect1011ui_story = var_64_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_4 = 0.2

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_4 and not isNil(var_64_3) then
				if arg_61_1.var_.characterEffect1011ui_story and not isNil(var_64_3) then
					arg_61_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_61_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_61_1.time_ - 0) / var_64_4)
				end
			end

			if arg_61_1.time_ >= 0 + var_64_4 and arg_61_1.time_ < 0 + var_64_4 + arg_64_0 and not isNil(var_64_3) and arg_61_1.var_.characterEffect1011ui_story then
				arg_61_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_61_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			local var_64_5 = arg_61_1.actors_["1084ui_story"].transform

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1.var_.moveOldPos1084ui_story = var_64_5.localPosition
			end

			local var_64_6 = 0.001

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_6 then
				var_64_5.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos1084ui_story, Vector3.New(0.7, -0.97, -6), (arg_61_1.time_ - 0) / var_64_6)
				var_64_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_64_5.position).x, (manager.ui.mainCamera.transform.position - var_64_5.position).y, (manager.ui.mainCamera.transform.position - var_64_5.position).z)
				var_64_5.localEulerAngles.z = 0
				var_64_5.localEulerAngles.x = 0
				var_64_5.localEulerAngles = var_64_5.localEulerAngles
			end

			if arg_61_1.time_ >= 0 + var_64_6 and arg_61_1.time_ < 0 + var_64_6 + arg_64_0 then
				var_64_5.localPosition = Vector3.New(0.7, -0.97, -6)
				var_64_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_64_5.position).x, (manager.ui.mainCamera.transform.position - var_64_5.position).y, (manager.ui.mainCamera.transform.position - var_64_5.position).z)
				var_64_5.localEulerAngles.z = 0
				var_64_5.localEulerAngles.x = 0
				var_64_5.localEulerAngles = var_64_5.localEulerAngles
			end

			local var_64_7 = 0
			local var_64_8 = 0.35

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_7 + arg_64_0 then
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

				local var_64_9 = arg_61_1:GetWordFromCfg(116171015)
				local var_64_10 = arg_61_1:FormatText(var_64_9.content)

				arg_61_1.text_.text = var_64_10

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_12 = 14 <= 0 and var_64_8 or var_64_8 * (utf8.len(var_64_10) / 14)

				if (14 <= 0 and var_64_8 or var_64_8 * (utf8.len(var_64_10) / 14)) > 0 and var_64_8 < var_64_12 then
					arg_61_1.talkMaxDuration = var_64_12

					if var_64_12 + var_64_7 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_12 + var_64_7
					end
				end

				arg_61_1.text_.text = var_64_10
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116171", "116171015", "story_v_out_116171.awb") ~= 0 then
					local var_64_13 = manager.audio:GetVoiceLength("story_v_out_116171", "116171015", "story_v_out_116171.awb") / 1000

					if var_64_13 + var_64_7 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_13 + var_64_7
					end

					if var_64_9.prefab_name ~= "" and arg_61_1.actors_[var_64_9.prefab_name] ~= nil then
						local var_64_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_9.prefab_name].transform, "story_v_out_116171", "116171015", "story_v_out_116171.awb")

						arg_61_1:RecordAudio("116171015", var_64_14)
						arg_61_1:RecordAudio("116171015", var_64_14)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_116171", "116171015", "story_v_out_116171.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_116171", "116171015", "story_v_out_116171.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_15 = math.max(var_64_8, arg_61_1.talkMaxDuration)

			if var_64_7 <= arg_61_1.time_ and arg_61_1.time_ < var_64_7 + var_64_15 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_7) / var_64_15

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_7 + var_64_15 and arg_61_1.time_ < var_64_7 + var_64_15 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
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
	Play116171016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 116171016
		arg_65_1.duration_ = 5

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play116171017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(arg_65_1.actors_["1084ui_story"]) and arg_65_1.var_.characterEffect1084ui_story == nil then
				arg_65_1.var_.characterEffect1084ui_story = arg_65_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_0 = 0.2

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_0 and not isNil(arg_65_1.actors_["1084ui_story"]) then
				if arg_65_1.var_.characterEffect1084ui_story and not isNil(arg_65_1.actors_["1084ui_story"]) then
					arg_65_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_65_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_65_1.time_ - 0) / var_68_0)
				end
			end

			if arg_65_1.time_ >= 0 + var_68_0 and arg_65_1.time_ < 0 + var_68_0 + arg_68_0 and not isNil(arg_65_1.actors_["1084ui_story"]) and arg_65_1.var_.characterEffect1084ui_story then
				arg_65_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_65_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_68_1 = 0
			local var_68_2 = 0.7

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

				local var_68_3 = arg_65_1:FormatText(arg_65_1:GetWordFromCfg(116171016).content)

				arg_65_1.text_.text = var_68_3

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_5 = 28 <= 0 and var_68_2 or var_68_2 * (utf8.len(var_68_3) / 28)

				if (28 <= 0 and var_68_2 or var_68_2 * (utf8.len(var_68_3) / 28)) > 0 and var_68_2 < var_68_5 then
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

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play116171017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 116171017
		arg_69_1.duration_ = 8.13

		local var_69_0 = {
			zh = 5.233,
			ja = 8.133
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
				arg_69_0:Play116171018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action12_1")
			end

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_72_0 = arg_69_1.actors_["1084ui_story"]

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 and not isNil(var_72_0) and arg_69_1.var_.characterEffect1084ui_story == nil then
				arg_69_1.var_.characterEffect1084ui_story = var_72_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_1 = 0.2

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_1 and not isNil(var_72_0) then
				if arg_69_1.var_.characterEffect1084ui_story and not isNil(var_72_0) then
					arg_69_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_69_1.time_ >= 0 + var_72_1 and arg_69_1.time_ < 0 + var_72_1 + arg_72_0 and not isNil(var_72_0) and arg_69_1.var_.characterEffect1084ui_story then
				arg_69_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_72_3 = 0
			local var_72_4 = 0.45

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_3 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				arg_69_1.leftNameTxt_.text = arg_69_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_5 = arg_69_1:GetWordFromCfg(116171017)
				local var_72_6 = arg_69_1:FormatText(var_72_5.content)

				arg_69_1.text_.text = var_72_6

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_8 = 18 <= 0 and var_72_4 or var_72_4 * (utf8.len(var_72_6) / 18)

				if (18 <= 0 and var_72_4 or var_72_4 * (utf8.len(var_72_6) / 18)) > 0 and var_72_4 < var_72_8 then
					arg_69_1.talkMaxDuration = var_72_8

					if var_72_8 + var_72_3 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_8 + var_72_3
					end
				end

				arg_69_1.text_.text = var_72_6
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116171", "116171017", "story_v_out_116171.awb") ~= 0 then
					local var_72_9 = manager.audio:GetVoiceLength("story_v_out_116171", "116171017", "story_v_out_116171.awb") / 1000

					if var_72_9 + var_72_3 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_9 + var_72_3
					end

					if var_72_5.prefab_name ~= "" and arg_69_1.actors_[var_72_5.prefab_name] ~= nil then
						local var_72_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_5.prefab_name].transform, "story_v_out_116171", "116171017", "story_v_out_116171.awb")

						arg_69_1:RecordAudio("116171017", var_72_10)
						arg_69_1:RecordAudio("116171017", var_72_10)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_116171", "116171017", "story_v_out_116171.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_116171", "116171017", "story_v_out_116171.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_11 = math.max(var_72_4, arg_69_1.talkMaxDuration)

			if var_72_3 <= arg_69_1.time_ and arg_69_1.time_ < var_72_3 + var_72_11 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_3) / var_72_11

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_3 + var_72_11 and arg_69_1.time_ < var_72_3 + var_72_11 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play116171018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 116171018
		arg_73_1.duration_ = 6.37

		local var_73_0 = {
			zh = 5.766,
			ja = 6.366
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
				arg_73_0:Play116171019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 and not isNil(arg_73_1.actors_["1011ui_story"]) and arg_73_1.var_.characterEffect1011ui_story == nil then
				arg_73_1.var_.characterEffect1011ui_story = arg_73_1.actors_["1011ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_0 = 0.2

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_0 and not isNil(arg_73_1.actors_["1011ui_story"]) then
				if arg_73_1.var_.characterEffect1011ui_story and not isNil(arg_73_1.actors_["1011ui_story"]) then
					arg_73_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_73_1.time_ >= 0 + var_76_0 and arg_73_1.time_ < 0 + var_76_0 + arg_76_0 and not isNil(arg_73_1.actors_["1011ui_story"]) and arg_73_1.var_.characterEffect1011ui_story then
				arg_73_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action3_2")
			end

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_76_2 = arg_73_1.actors_["1084ui_story"]

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 and not isNil(var_76_2) and arg_73_1.var_.characterEffect1084ui_story == nil then
				arg_73_1.var_.characterEffect1084ui_story = var_76_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_3 = 0.2

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_3 and not isNil(var_76_2) then
				if arg_73_1.var_.characterEffect1084ui_story and not isNil(var_76_2) then
					arg_73_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_73_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_73_1.time_ - 0) / var_76_3)
				end
			end

			if arg_73_1.time_ >= 0 + var_76_3 and arg_73_1.time_ < 0 + var_76_3 + arg_76_0 and not isNil(var_76_2) and arg_73_1.var_.characterEffect1084ui_story then
				arg_73_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_73_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_76_4 = 0
			local var_76_5 = 0.675

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_4 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				arg_73_1.leftNameTxt_.text = arg_73_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_6 = arg_73_1:GetWordFromCfg(116171018)
				local var_76_7 = arg_73_1:FormatText(var_76_6.content)

				arg_73_1.text_.text = var_76_7

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_9 = 27 <= 0 and var_76_5 or var_76_5 * (utf8.len(var_76_7) / 27)

				if (27 <= 0 and var_76_5 or var_76_5 * (utf8.len(var_76_7) / 27)) > 0 and var_76_5 < var_76_9 then
					arg_73_1.talkMaxDuration = var_76_9

					if var_76_9 + var_76_4 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_9 + var_76_4
					end
				end

				arg_73_1.text_.text = var_76_7
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116171", "116171018", "story_v_out_116171.awb") ~= 0 then
					local var_76_10 = manager.audio:GetVoiceLength("story_v_out_116171", "116171018", "story_v_out_116171.awb") / 1000

					if var_76_10 + var_76_4 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_10 + var_76_4
					end

					if var_76_6.prefab_name ~= "" and arg_73_1.actors_[var_76_6.prefab_name] ~= nil then
						local var_76_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_6.prefab_name].transform, "story_v_out_116171", "116171018", "story_v_out_116171.awb")

						arg_73_1:RecordAudio("116171018", var_76_11)
						arg_73_1:RecordAudio("116171018", var_76_11)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_116171", "116171018", "story_v_out_116171.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_116171", "116171018", "story_v_out_116171.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_12 = math.max(var_76_5, arg_73_1.talkMaxDuration)

			if var_76_4 <= arg_73_1.time_ and arg_73_1.time_ < var_76_4 + var_76_12 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_4) / var_76_12

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_4 + var_76_12 and arg_73_1.time_ < var_76_4 + var_76_12 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play116171019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 116171019
		arg_77_1.duration_ = 2.5

		SetActive(arg_77_1.tipsGo_, false)

		function arg_77_1.onSingleLineFinish_()
			arg_77_1.onSingleLineUpdate_ = nil
			arg_77_1.onSingleLineFinish_ = nil
			arg_77_1.state_ = "waiting"
		end

		function arg_77_1.playNext_(arg_79_0)
			if arg_79_0 == 1 then
				arg_77_0:Play116171020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_80_0 = arg_77_1.actors_["1084ui_story"]

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 and not isNil(var_80_0) and arg_77_1.var_.characterEffect1084ui_story == nil then
				arg_77_1.var_.characterEffect1084ui_story = var_80_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_1 = 0.2

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_1 and not isNil(var_80_0) then
				if arg_77_1.var_.characterEffect1084ui_story and not isNil(var_80_0) then
					arg_77_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_77_1.time_ >= 0 + var_80_1 and arg_77_1.time_ < 0 + var_80_1 + arg_80_0 and not isNil(var_80_0) and arg_77_1.var_.characterEffect1084ui_story then
				arg_77_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_80_3 = arg_77_1.actors_["1011ui_story"]

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 and not isNil(var_80_3) and arg_77_1.var_.characterEffect1011ui_story == nil then
				arg_77_1.var_.characterEffect1011ui_story = var_80_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_4 = 0.2

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_4 and not isNil(var_80_3) then
				if arg_77_1.var_.characterEffect1011ui_story and not isNil(var_80_3) then
					arg_77_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_77_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_77_1.time_ - 0) / var_80_4)
				end
			end

			if arg_77_1.time_ >= 0 + var_80_4 and arg_77_1.time_ < 0 + var_80_4 + arg_80_0 and not isNil(var_80_3) and arg_77_1.var_.characterEffect1011ui_story then
				arg_77_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_77_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			local var_80_5 = 0
			local var_80_6 = 0.05

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_5 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				arg_77_1.leftNameTxt_.text = arg_77_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_7 = arg_77_1:GetWordFromCfg(116171019)
				local var_80_8 = arg_77_1:FormatText(var_80_7.content)

				arg_77_1.text_.text = var_80_8

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_10 = 2 <= 0 and var_80_6 or var_80_6 * (utf8.len(var_80_8) / 2)

				if (2 <= 0 and var_80_6 or var_80_6 * (utf8.len(var_80_8) / 2)) > 0 and var_80_6 < var_80_10 then
					arg_77_1.talkMaxDuration = var_80_10

					if var_80_10 + var_80_5 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_10 + var_80_5
					end
				end

				arg_77_1.text_.text = var_80_8
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116171", "116171019", "story_v_out_116171.awb") ~= 0 then
					local var_80_11 = manager.audio:GetVoiceLength("story_v_out_116171", "116171019", "story_v_out_116171.awb") / 1000

					if var_80_11 + var_80_5 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_11 + var_80_5
					end

					if var_80_7.prefab_name ~= "" and arg_77_1.actors_[var_80_7.prefab_name] ~= nil then
						local var_80_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_7.prefab_name].transform, "story_v_out_116171", "116171019", "story_v_out_116171.awb")

						arg_77_1:RecordAudio("116171019", var_80_12)
						arg_77_1:RecordAudio("116171019", var_80_12)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_116171", "116171019", "story_v_out_116171.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_116171", "116171019", "story_v_out_116171.awb")
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
	Play116171020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 116171020
		arg_81_1.duration_ = 9

		SetActive(arg_81_1.tipsGo_, false)

		function arg_81_1.onSingleLineFinish_()
			arg_81_1.onSingleLineUpdate_ = nil
			arg_81_1.onSingleLineFinish_ = nil
			arg_81_1.state_ = "waiting"
		end

		function arg_81_1.playNext_(arg_83_0)
			if arg_83_0 == 1 then
				arg_81_0:Play116171021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			if arg_81_1.bgs_.SK0202 == nil then
				local var_84_0 = Object.Instantiate(arg_81_1.paintGo_)

				var_84_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "SK0202")
				var_84_0.name = "SK0202"
				var_84_0.transform.parent = arg_81_1.stage_.transform
				var_84_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_81_1.bgs_.SK0202 = var_84_0
			end

			if 2 < arg_81_1.time_ and arg_81_1.time_ <= 2 + arg_84_0 then
				local var_84_1 = arg_81_1.bgs_.SK0202

				arg_81_1.bgs_.SK0202.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_84_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_84_2 = var_84_1:GetComponent("SpriteRenderer")

				if var_84_2 and var_84_2.sprite then
					local var_84_3 = 2 * (var_84_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_84_1.transform.localScale = Vector3.New(var_84_3 / var_84_2.sprite.bounds.size.y < var_84_3 * manager.ui.mainCameraCom_.aspect / var_84_2.sprite.bounds.size.x and var_84_3 * manager.ui.mainCameraCom_.aspect / var_84_2.sprite.bounds.size.x or var_84_3 / var_84_2.sprite.bounds.size.y, var_84_3 / var_84_2.sprite.bounds.size.y < var_84_3 * manager.ui.mainCameraCom_.aspect / var_84_2.sprite.bounds.size.x and var_84_3 * manager.ui.mainCameraCom_.aspect / var_84_2.sprite.bounds.size.x or var_84_3 / var_84_2.sprite.bounds.size.y, 0)
				end

				for iter_84_0, iter_84_1 in pairs(arg_81_1.bgs_) do
					if iter_84_0 ~= "SK0202" then
						iter_84_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_84_4 = 0

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_4 + arg_84_0 then
				arg_81_1.mask_.enabled = true
				arg_81_1.mask_.raycastTarget = true

				arg_81_1:SetGaussion(false)
			end

			local var_84_5 = 2

			if var_84_4 <= arg_81_1.time_ and arg_81_1.time_ < var_84_4 + var_84_5 then
				local var_84_6 = Color.New(0, 0, 0)

				var_84_6.a = Mathf.Lerp(0, 1, (arg_81_1.time_ - var_84_4) / var_84_5)
				arg_81_1.mask_.color = var_84_6
			end

			if arg_81_1.time_ >= var_84_4 + var_84_5 and arg_81_1.time_ < var_84_4 + var_84_5 + arg_84_0 then
				local var_84_7 = Color.New(0, 0, 0)

				var_84_7.a = 1
				arg_81_1.mask_.color = var_84_7
			end

			local var_84_8 = 2

			if 2 < arg_81_1.time_ and arg_81_1.time_ <= var_84_8 + arg_84_0 then
				arg_81_1.mask_.enabled = true
				arg_81_1.mask_.raycastTarget = true

				arg_81_1:SetGaussion(false)
			end

			local var_84_9 = 2

			if var_84_8 <= arg_81_1.time_ and arg_81_1.time_ < var_84_8 + var_84_9 then
				local var_84_10 = Color.New(0, 0, 0)

				var_84_10.a = Mathf.Lerp(1, 0, (arg_81_1.time_ - var_84_8) / var_84_9)
				arg_81_1.mask_.color = var_84_10
			end

			if arg_81_1.time_ >= var_84_8 + var_84_9 and arg_81_1.time_ < var_84_8 + var_84_9 + arg_84_0 then
				local var_84_11 = Color.New(0, 0, 0)

				arg_81_1.mask_.enabled = false
				var_84_11.a = 0
				arg_81_1.mask_.color = var_84_11
			end

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1:AudioAction("play", "effect", "se_story_16", "se_story_16_torrent_loop", "")
			end

			local var_84_13 = arg_81_1.actors_["1084ui_story"].transform

			if 1.966 < arg_81_1.time_ and arg_81_1.time_ <= 1.966 + arg_84_0 then
				arg_81_1.var_.moveOldPos1084ui_story = var_84_13.localPosition
			end

			local var_84_14 = 0.001

			if 1.966 <= arg_81_1.time_ and arg_81_1.time_ < 1.966 + var_84_14 then
				var_84_13.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_81_1.time_ - 1.966) / var_84_14)
				var_84_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_84_13.position).x, (manager.ui.mainCamera.transform.position - var_84_13.position).y, (manager.ui.mainCamera.transform.position - var_84_13.position).z)
				var_84_13.localEulerAngles.z = 0
				var_84_13.localEulerAngles.x = 0
				var_84_13.localEulerAngles = var_84_13.localEulerAngles
			end

			if arg_81_1.time_ >= 1.966 + var_84_14 and arg_81_1.time_ < 1.966 + var_84_14 + arg_84_0 then
				var_84_13.localPosition = Vector3.New(0, 100, 0)
				var_84_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_84_13.position).x, (manager.ui.mainCamera.transform.position - var_84_13.position).y, (manager.ui.mainCamera.transform.position - var_84_13.position).z)
				var_84_13.localEulerAngles.z = 0
				var_84_13.localEulerAngles.x = 0
				var_84_13.localEulerAngles = var_84_13.localEulerAngles
			end

			local var_84_15 = arg_81_1.actors_["1011ui_story"].transform

			if 1.966 < arg_81_1.time_ and arg_81_1.time_ <= 1.966 + arg_84_0 then
				arg_81_1.var_.moveOldPos1011ui_story = var_84_15.localPosition
			end

			local var_84_16 = 0.001

			if 1.966 <= arg_81_1.time_ and arg_81_1.time_ < 1.966 + var_84_16 then
				var_84_15.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPos1011ui_story, Vector3.New(0, 100, 0), (arg_81_1.time_ - 1.966) / var_84_16)
				var_84_15.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_84_15.position).x, (manager.ui.mainCamera.transform.position - var_84_15.position).y, (manager.ui.mainCamera.transform.position - var_84_15.position).z)
				var_84_15.localEulerAngles.z = 0
				var_84_15.localEulerAngles.x = 0
				var_84_15.localEulerAngles = var_84_15.localEulerAngles
			end

			if arg_81_1.time_ >= 1.966 + var_84_16 and arg_81_1.time_ < 1.966 + var_84_16 + arg_84_0 then
				var_84_15.localPosition = Vector3.New(0, 100, 0)
				var_84_15.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_84_15.position).x, (manager.ui.mainCamera.transform.position - var_84_15.position).y, (manager.ui.mainCamera.transform.position - var_84_15.position).z)
				var_84_15.localEulerAngles.z = 0
				var_84_15.localEulerAngles.x = 0
				var_84_15.localEulerAngles = var_84_15.localEulerAngles
			end

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_84_19 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_81_1.bgmTxt_.text ~= var_84_19 and arg_81_1.bgmTxt_.text ~= "" then
						if arg_81_1.bgmTxt2_.text ~= "" then
							arg_81_1.bgmTxt_.text = arg_81_1.bgmTxt2_.text
						end

						arg_81_1.bgmTxt2_.text = var_84_19

						arg_81_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_81_1.bgmTxt_.text = var_84_19
						arg_81_1.bgmTxt2_.text = var_84_19
					end

					if arg_81_1.bgmTimer then
						arg_81_1.bgmTimer:Stop()

						arg_81_1.bgmTimer = nil
					end

					if arg_81_1.settingData.show_music_name == 1 then
						arg_81_1.musicController:SetSelectedState("show")
						arg_81_1.musicAnimator_:Play("open", 0, 0)

						if arg_81_1.settingData.music_time ~= 0 then
							arg_81_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_81_1.settingData.music_time), function()
								if arg_81_1 == nil or isNil(arg_81_1.bgmTxt_) then
									return
								end

								arg_81_1.musicController:SetSelectedState("hide")
								arg_81_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 1.966 < arg_81_1.time_ and arg_81_1.time_ <= 1.966 + arg_84_0 then
				arg_81_1:AudioAction("play", "music", "bgm_activity_1_6_story_story", "bgm_activity_1_6_story_story", "bgm_activity_1_6_story_story.awb")

				if "" ~= "" then
					if arg_81_1.bgmTxt_.text ~= "" and arg_81_1.bgmTxt_.text ~= "" then
						if arg_81_1.bgmTxt2_.text ~= "" then
							arg_81_1.bgmTxt_.text = arg_81_1.bgmTxt2_.text
						end

						arg_81_1.bgmTxt2_.text = ""

						arg_81_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_81_1.bgmTxt_.text = ""
						arg_81_1.bgmTxt2_.text = ""
					end

					if arg_81_1.bgmTimer then
						arg_81_1.bgmTimer:Stop()

						arg_81_1.bgmTimer = nil
					end

					if arg_81_1.settingData.show_music_name == 1 then
						arg_81_1.musicController:SetSelectedState("show")
						arg_81_1.musicAnimator_:Play("open", 0, 0)

						if arg_81_1.settingData.music_time ~= 0 then
							arg_81_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_81_1.settingData.music_time), function()
								if arg_81_1 == nil or isNil(arg_81_1.bgmTxt_) then
									return
								end

								arg_81_1.musicController:SetSelectedState("hide")
								arg_81_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 2.141 < arg_81_1.time_ and arg_81_1.time_ <= 2.141 + arg_84_0 then
				arg_81_1:AudioAction("play", "music", "bgm_activity_1_6_story_story", "dialog", "bgm_activity_1_6_story_story.awb")

				if MusicRecordCfg[95].musicName ~= "" then
					if arg_81_1.bgmTxt_.text ~= MusicRecordCfg[95].musicName and arg_81_1.bgmTxt_.text ~= "" then
						if arg_81_1.bgmTxt2_.text ~= "" then
							arg_81_1.bgmTxt_.text = arg_81_1.bgmTxt2_.text
						end

						arg_81_1.bgmTxt2_.text = MusicRecordCfg[95].musicName

						arg_81_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_81_1.bgmTxt_.text = MusicRecordCfg[95].musicName
						arg_81_1.bgmTxt2_.text = MusicRecordCfg[95].musicName
					end

					if arg_81_1.bgmTimer then
						arg_81_1.bgmTimer:Stop()

						arg_81_1.bgmTimer = nil
					end

					if arg_81_1.settingData.show_music_name == 1 then
						arg_81_1.musicController:SetSelectedState("show")
						arg_81_1.musicAnimator_:Play("open", 0, 0)

						if arg_81_1.settingData.music_time ~= 0 then
							arg_81_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_81_1.settingData.music_time), function()
								if arg_81_1 == nil or isNil(arg_81_1.bgmTxt_) then
									return
								end

								arg_81_1.musicController:SetSelectedState("hide")
								arg_81_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_81_1.frameCnt_ <= 1 then
				arg_81_1.dialog_:SetActive(false)
			end

			local var_84_23 = 4
			local var_84_24 = 0.525

			if 4 < arg_81_1.time_ and arg_81_1.time_ <= var_84_23 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0

				arg_81_1.dialog_:SetActive(true)

				arg_81_1.dialogCg_.alpha = 0

				local var_84_25 = LeanTween.value(arg_81_1.dialog_, 0, 1, 0.3)

				var_84_25:setOnUpdate(LuaHelper.FloatAction(function(arg_88_0)
					arg_81_1.dialogCg_.alpha = arg_88_0
				end))
				var_84_25:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_81_1.dialog_)
					var_84_25:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_81_1.duration_ = arg_81_1.duration_ + 0.3

				SetActive(arg_81_1.leftNameGo_, false)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_26 = arg_81_1:FormatText(arg_81_1:GetWordFromCfg(116171020).content)

				arg_81_1.text_.text = var_84_26

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_28 = 21 <= 0 and var_84_24 or var_84_24 * (utf8.len(var_84_26) / 21)

				if (21 <= 0 and var_84_24 or var_84_24 * (utf8.len(var_84_26) / 21)) > 0 and var_84_24 < var_84_28 then
					arg_81_1.talkMaxDuration = var_84_28
					var_84_23 = var_84_23 + 0.3

					if var_84_28 + var_84_23 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_28 + var_84_23
					end
				end

				arg_81_1.text_.text = var_84_26
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)
				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_29 = var_84_23 + 0.3
			local var_84_30 = math.max(var_84_24, arg_81_1.talkMaxDuration)

			if var_84_23 + 0.3 <= arg_81_1.time_ and arg_81_1.time_ < var_84_29 + var_84_30 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_29) / var_84_30

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_29 + var_84_30 and arg_81_1.time_ < var_84_29 + var_84_30 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_81_1:InitPlayNodeList()
	end,
	Play116171021 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 116171021
		arg_90_1.duration_ = 5

		SetActive(arg_90_1.tipsGo_, false)

		function arg_90_1.onSingleLineFinish_()
			arg_90_1.onSingleLineUpdate_ = nil
			arg_90_1.onSingleLineFinish_ = nil
			arg_90_1.state_ = "waiting"
		end

		function arg_90_1.playNext_(arg_92_0)
			if arg_92_0 == 1 then
				arg_90_0:Play116171022(arg_90_1)
			end
		end

		function arg_90_1.onSingleLineUpdate_(arg_93_0)
			local var_93_0 = 1.125

			if 0 < arg_90_1.time_ and arg_90_1.time_ <= 0 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0
				arg_90_1.dialogCg_.alpha = 1

				arg_90_1.dialog_:SetActive(true)
				SetActive(arg_90_1.leftNameGo_, false)

				arg_90_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_90_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_90_1:RecordName(arg_90_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_90_1.iconTrs_.gameObject, false)
				arg_90_1.callingController_:SetSelectedState("normal")

				local var_93_1 = arg_90_1:FormatText(arg_90_1:GetWordFromCfg(116171021).content)

				arg_90_1.text_.text = var_93_1

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_3 = 45 <= 0 and var_93_0 or var_93_0 * (utf8.len(var_93_1) / 45)

				if (45 <= 0 and var_93_0 or var_93_0 * (utf8.len(var_93_1) / 45)) > 0 and var_93_0 < var_93_3 then
					arg_90_1.talkMaxDuration = var_93_3

					if var_93_3 + 0 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_3 + 0
					end
				end

				arg_90_1.text_.text = var_93_1
				arg_90_1.typewritter.percent = 0

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(false)
				arg_90_1:RecordContent(arg_90_1.text_.text)
			end

			local var_93_4 = math.max(var_93_0, arg_90_1.talkMaxDuration)

			if 0 <= arg_90_1.time_ and arg_90_1.time_ < 0 + var_93_4 then
				arg_90_1.typewritter.percent = (arg_90_1.time_ - 0) / var_93_4

				arg_90_1.typewritter:SetDirty()
			end

			if arg_90_1.time_ >= 0 + var_93_4 and arg_90_1.time_ < 0 + var_93_4 + arg_93_0 then
				arg_90_1.typewritter.percent = 1

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(true)
			end
		end

		arg_90_1.nodeConfigList_ = {}

		arg_90_1:InitPlayNodeList()
	end,
	Play116171022 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 116171022
		arg_94_1.duration_ = 5

		SetActive(arg_94_1.tipsGo_, false)

		function arg_94_1.onSingleLineFinish_()
			arg_94_1.onSingleLineUpdate_ = nil
			arg_94_1.onSingleLineFinish_ = nil
			arg_94_1.state_ = "waiting"
		end

		function arg_94_1.playNext_(arg_96_0)
			if arg_96_0 == 1 then
				arg_94_0:Play116171023(arg_94_1)
			end
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			local var_97_0 = 1.7

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0
				arg_94_1.dialogCg_.alpha = 1

				arg_94_1.dialog_:SetActive(true)
				SetActive(arg_94_1.leftNameGo_, false)

				arg_94_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_94_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_94_1:RecordName(arg_94_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_94_1.iconTrs_.gameObject, false)
				arg_94_1.callingController_:SetSelectedState("normal")

				local var_97_1 = arg_94_1:FormatText(arg_94_1:GetWordFromCfg(116171022).content)

				arg_94_1.text_.text = var_97_1

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_3 = 68 <= 0 and var_97_0 or var_97_0 * (utf8.len(var_97_1) / 68)

				if (68 <= 0 and var_97_0 or var_97_0 * (utf8.len(var_97_1) / 68)) > 0 and var_97_0 < var_97_3 then
					arg_94_1.talkMaxDuration = var_97_3

					if var_97_3 + 0 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_3 + 0
					end
				end

				arg_94_1.text_.text = var_97_1
				arg_94_1.typewritter.percent = 0

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(false)
				arg_94_1:RecordContent(arg_94_1.text_.text)
			end

			local var_97_4 = math.max(var_97_0, arg_94_1.talkMaxDuration)

			if 0 <= arg_94_1.time_ and arg_94_1.time_ < 0 + var_97_4 then
				arg_94_1.typewritter.percent = (arg_94_1.time_ - 0) / var_97_4

				arg_94_1.typewritter:SetDirty()
			end

			if arg_94_1.time_ >= 0 + var_97_4 and arg_94_1.time_ < 0 + var_97_4 + arg_97_0 then
				arg_94_1.typewritter.percent = 1

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(true)
			end
		end

		arg_94_1.nodeConfigList_ = {}

		arg_94_1:InitPlayNodeList()
	end,
	Play116171023 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 116171023
		arg_98_1.duration_ = 5

		SetActive(arg_98_1.tipsGo_, false)

		function arg_98_1.onSingleLineFinish_()
			arg_98_1.onSingleLineUpdate_ = nil
			arg_98_1.onSingleLineFinish_ = nil
			arg_98_1.state_ = "waiting"
		end

		function arg_98_1.playNext_(arg_100_0)
			if arg_100_0 == 1 then
				arg_98_0:Play116171024(arg_98_1)
			end
		end

		function arg_98_1.onSingleLineUpdate_(arg_101_0)
			local var_101_0 = 0.875

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0
				arg_98_1.dialogCg_.alpha = 1

				arg_98_1.dialog_:SetActive(true)
				SetActive(arg_98_1.leftNameGo_, false)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_98_1.iconTrs_.gameObject, false)
				arg_98_1.callingController_:SetSelectedState("normal")

				local var_101_1 = arg_98_1:FormatText(arg_98_1:GetWordFromCfg(116171023).content)

				arg_98_1.text_.text = var_101_1

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_3 = 35 <= 0 and var_101_0 or var_101_0 * (utf8.len(var_101_1) / 35)

				if (35 <= 0 and var_101_0 or var_101_0 * (utf8.len(var_101_1) / 35)) > 0 and var_101_0 < var_101_3 then
					arg_98_1.talkMaxDuration = var_101_3

					if var_101_3 + 0 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_3 + 0
					end
				end

				arg_98_1.text_.text = var_101_1
				arg_98_1.typewritter.percent = 0

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(false)
				arg_98_1:RecordContent(arg_98_1.text_.text)
			end

			local var_101_4 = math.max(var_101_0, arg_98_1.talkMaxDuration)

			if 0 <= arg_98_1.time_ and arg_98_1.time_ < 0 + var_101_4 then
				arg_98_1.typewritter.percent = (arg_98_1.time_ - 0) / var_101_4

				arg_98_1.typewritter:SetDirty()
			end

			if arg_98_1.time_ >= 0 + var_101_4 and arg_98_1.time_ < 0 + var_101_4 + arg_101_0 then
				arg_98_1.typewritter.percent = 1

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(true)
			end
		end

		arg_98_1.nodeConfigList_ = {}

		arg_98_1:InitPlayNodeList()
	end,
	Play116171024 = function(arg_102_0, arg_102_1)
		arg_102_1.time_ = 0
		arg_102_1.frameCnt_ = 0
		arg_102_1.state_ = "playing"
		arg_102_1.curTalkId_ = 116171024
		arg_102_1.duration_ = 3.63

		local var_102_0 = {
			zh = 3.633,
			ja = 3
		}
		local var_102_1 = manager.audio:GetLocalizationFlag()

		if var_102_0[var_102_1] ~= nil then
			arg_102_1.duration_ = var_102_0[var_102_1]
		end

		SetActive(arg_102_1.tipsGo_, false)

		function arg_102_1.onSingleLineFinish_()
			arg_102_1.onSingleLineUpdate_ = nil
			arg_102_1.onSingleLineFinish_ = nil
			arg_102_1.state_ = "waiting"
		end

		function arg_102_1.playNext_(arg_104_0)
			if arg_104_0 == 1 then
				arg_102_0:Play116171025(arg_102_1)
			end
		end

		function arg_102_1.onSingleLineUpdate_(arg_105_0)
			local var_105_0 = 0.1

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 then
				arg_102_1.talkMaxDuration = 0
				arg_102_1.dialogCg_.alpha = 1

				arg_102_1.dialog_:SetActive(true)
				SetActive(arg_102_1.leftNameGo_, true)

				arg_102_1.leftNameTxt_.text = arg_102_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_102_1.leftNameTxt_.transform)

				arg_102_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_102_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_102_1:RecordName(arg_102_1.leftNameTxt_.text)
				SetActive(arg_102_1.iconTrs_.gameObject, false)
				arg_102_1.callingController_:SetSelectedState("normal")

				local var_105_1 = arg_102_1:GetWordFromCfg(116171024)
				local var_105_2 = arg_102_1:FormatText(var_105_1.content)

				arg_102_1.text_.text = var_105_2

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.text_)

				local var_105_4 = 4 <= 0 and var_105_0 or var_105_0 * (utf8.len(var_105_2) / 4)

				if (4 <= 0 and var_105_0 or var_105_0 * (utf8.len(var_105_2) / 4)) > 0 and var_105_0 < var_105_4 then
					arg_102_1.talkMaxDuration = var_105_4

					if var_105_4 + 0 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_4 + 0
					end
				end

				arg_102_1.text_.text = var_105_2
				arg_102_1.typewritter.percent = 0

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116171", "116171024", "story_v_out_116171.awb") ~= 0 then
					local var_105_5 = manager.audio:GetVoiceLength("story_v_out_116171", "116171024", "story_v_out_116171.awb") / 1000

					if var_105_5 + 0 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_5 + 0
					end

					if var_105_1.prefab_name ~= "" and arg_102_1.actors_[var_105_1.prefab_name] ~= nil then
						local var_105_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_102_1.actors_[var_105_1.prefab_name].transform, "story_v_out_116171", "116171024", "story_v_out_116171.awb")

						arg_102_1:RecordAudio("116171024", var_105_6)
						arg_102_1:RecordAudio("116171024", var_105_6)
					else
						arg_102_1:AudioAction("play", "voice", "story_v_out_116171", "116171024", "story_v_out_116171.awb")
					end

					arg_102_1:RecordHistoryTalkVoice("story_v_out_116171", "116171024", "story_v_out_116171.awb")
				end

				arg_102_1:RecordContent(arg_102_1.text_.text)
			end

			local var_105_7 = math.max(var_105_0, arg_102_1.talkMaxDuration)

			if 0 <= arg_102_1.time_ and arg_102_1.time_ < 0 + var_105_7 then
				arg_102_1.typewritter.percent = (arg_102_1.time_ - 0) / var_105_7

				arg_102_1.typewritter:SetDirty()
			end

			if arg_102_1.time_ >= 0 + var_105_7 and arg_102_1.time_ < 0 + var_105_7 + arg_105_0 then
				arg_102_1.typewritter.percent = 1

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(true)
			end
		end

		arg_102_1.nodeConfigList_ = {}

		arg_102_1:InitPlayNodeList()
	end,
	Play116171025 = function(arg_106_0, arg_106_1)
		arg_106_1.time_ = 0
		arg_106_1.frameCnt_ = 0
		arg_106_1.state_ = "playing"
		arg_106_1.curTalkId_ = 116171025
		arg_106_1.duration_ = 5

		SetActive(arg_106_1.tipsGo_, false)

		function arg_106_1.onSingleLineFinish_()
			arg_106_1.onSingleLineUpdate_ = nil
			arg_106_1.onSingleLineFinish_ = nil
			arg_106_1.state_ = "waiting"
		end

		function arg_106_1.playNext_(arg_108_0)
			if arg_108_0 == 1 then
				arg_106_0:Play116171026(arg_106_1)
			end
		end

		function arg_106_1.onSingleLineUpdate_(arg_109_0)
			local var_109_0 = 0.875

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 then
				arg_106_1.talkMaxDuration = 0
				arg_106_1.dialogCg_.alpha = 1

				arg_106_1.dialog_:SetActive(true)
				SetActive(arg_106_1.leftNameGo_, false)

				arg_106_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_106_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_106_1:RecordName(arg_106_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_106_1.iconTrs_.gameObject, false)
				arg_106_1.callingController_:SetSelectedState("normal")

				local var_109_1 = arg_106_1:FormatText(arg_106_1:GetWordFromCfg(116171025).content)

				arg_106_1.text_.text = var_109_1

				LuaForUtil.ClearLinePrefixSymbol(arg_106_1.text_)

				local var_109_3 = 35 <= 0 and var_109_0 or var_109_0 * (utf8.len(var_109_1) / 35)

				if (35 <= 0 and var_109_0 or var_109_0 * (utf8.len(var_109_1) / 35)) > 0 and var_109_0 < var_109_3 then
					arg_106_1.talkMaxDuration = var_109_3

					if var_109_3 + 0 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_3 + 0
					end
				end

				arg_106_1.text_.text = var_109_1
				arg_106_1.typewritter.percent = 0

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(false)
				arg_106_1:RecordContent(arg_106_1.text_.text)
			end

			local var_109_4 = math.max(var_109_0, arg_106_1.talkMaxDuration)

			if 0 <= arg_106_1.time_ and arg_106_1.time_ < 0 + var_109_4 then
				arg_106_1.typewritter.percent = (arg_106_1.time_ - 0) / var_109_4

				arg_106_1.typewritter:SetDirty()
			end

			if arg_106_1.time_ >= 0 + var_109_4 and arg_106_1.time_ < 0 + var_109_4 + arg_109_0 then
				arg_106_1.typewritter.percent = 1

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(true)
			end
		end

		arg_106_1.nodeConfigList_ = {}

		arg_106_1:InitPlayNodeList()
	end,
	Play116171026 = function(arg_110_0, arg_110_1)
		arg_110_1.time_ = 0
		arg_110_1.frameCnt_ = 0
		arg_110_1.state_ = "playing"
		arg_110_1.curTalkId_ = 116171026
		arg_110_1.duration_ = 5

		SetActive(arg_110_1.tipsGo_, false)

		function arg_110_1.onSingleLineFinish_()
			arg_110_1.onSingleLineUpdate_ = nil
			arg_110_1.onSingleLineFinish_ = nil
			arg_110_1.state_ = "waiting"
		end

		function arg_110_1.playNext_(arg_112_0)
			if arg_112_0 == 1 then
				arg_110_0:Play116171027(arg_110_1)
			end
		end

		function arg_110_1.onSingleLineUpdate_(arg_113_0)
			local var_113_0 = 0.575

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= 0 + arg_113_0 then
				arg_110_1.talkMaxDuration = 0
				arg_110_1.dialogCg_.alpha = 1

				arg_110_1.dialog_:SetActive(true)
				SetActive(arg_110_1.leftNameGo_, false)

				arg_110_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_110_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_110_1:RecordName(arg_110_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_110_1.iconTrs_.gameObject, false)
				arg_110_1.callingController_:SetSelectedState("normal")

				local var_113_1 = arg_110_1:FormatText(arg_110_1:GetWordFromCfg(116171026).content)

				arg_110_1.text_.text = var_113_1

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_3 = 23 <= 0 and var_113_0 or var_113_0 * (utf8.len(var_113_1) / 23)

				if (23 <= 0 and var_113_0 or var_113_0 * (utf8.len(var_113_1) / 23)) > 0 and var_113_0 < var_113_3 then
					arg_110_1.talkMaxDuration = var_113_3

					if var_113_3 + 0 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_3 + 0
					end
				end

				arg_110_1.text_.text = var_113_1
				arg_110_1.typewritter.percent = 0

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(false)
				arg_110_1:RecordContent(arg_110_1.text_.text)
			end

			local var_113_4 = math.max(var_113_0, arg_110_1.talkMaxDuration)

			if 0 <= arg_110_1.time_ and arg_110_1.time_ < 0 + var_113_4 then
				arg_110_1.typewritter.percent = (arg_110_1.time_ - 0) / var_113_4

				arg_110_1.typewritter:SetDirty()
			end

			if arg_110_1.time_ >= 0 + var_113_4 and arg_110_1.time_ < 0 + var_113_4 + arg_113_0 then
				arg_110_1.typewritter.percent = 1

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(true)
			end
		end

		arg_110_1.nodeConfigList_ = {}

		arg_110_1:InitPlayNodeList()
	end,
	Play116171027 = function(arg_114_0, arg_114_1)
		arg_114_1.time_ = 0
		arg_114_1.frameCnt_ = 0
		arg_114_1.state_ = "playing"
		arg_114_1.curTalkId_ = 116171027
		arg_114_1.duration_ = 5

		SetActive(arg_114_1.tipsGo_, false)

		function arg_114_1.onSingleLineFinish_()
			arg_114_1.onSingleLineUpdate_ = nil
			arg_114_1.onSingleLineFinish_ = nil
			arg_114_1.state_ = "waiting"
		end

		function arg_114_1.playNext_(arg_116_0)
			if arg_116_0 == 1 then
				arg_114_0:Play116171028(arg_114_1)
			end
		end

		function arg_114_1.onSingleLineUpdate_(arg_117_0)
			local var_117_0 = 0.625

			if 0 < arg_114_1.time_ and arg_114_1.time_ <= 0 + arg_117_0 then
				arg_114_1.talkMaxDuration = 0
				arg_114_1.dialogCg_.alpha = 1

				arg_114_1.dialog_:SetActive(true)
				SetActive(arg_114_1.leftNameGo_, true)

				arg_114_1.leftNameTxt_.text = arg_114_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_114_1.leftNameTxt_.transform)

				arg_114_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_114_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_114_1:RecordName(arg_114_1.leftNameTxt_.text)
				SetActive(arg_114_1.iconTrs_.gameObject, true)
				arg_114_1.iconController_:SetSelectedState("hero")

				arg_114_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_114_1.callingController_:SetSelectedState("normal")

				arg_114_1.keyicon_.color = Color.New(1, 1, 1)
				arg_114_1.icon_.color = Color.New(1, 1, 1)

				local var_117_1 = arg_114_1:FormatText(arg_114_1:GetWordFromCfg(116171027).content)

				arg_114_1.text_.text = var_117_1

				LuaForUtil.ClearLinePrefixSymbol(arg_114_1.text_)

				local var_117_3 = 24 <= 0 and var_117_0 or var_117_0 * (utf8.len(var_117_1) / 24)

				if (24 <= 0 and var_117_0 or var_117_0 * (utf8.len(var_117_1) / 24)) > 0 and var_117_0 < var_117_3 then
					arg_114_1.talkMaxDuration = var_117_3

					if var_117_3 + 0 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_3 + 0
					end
				end

				arg_114_1.text_.text = var_117_1
				arg_114_1.typewritter.percent = 0

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(false)
				arg_114_1:RecordContent(arg_114_1.text_.text)
			end

			local var_117_4 = math.max(var_117_0, arg_114_1.talkMaxDuration)

			if 0 <= arg_114_1.time_ and arg_114_1.time_ < 0 + var_117_4 then
				arg_114_1.typewritter.percent = (arg_114_1.time_ - 0) / var_117_4

				arg_114_1.typewritter:SetDirty()
			end

			if arg_114_1.time_ >= 0 + var_117_4 and arg_114_1.time_ < 0 + var_117_4 + arg_117_0 then
				arg_114_1.typewritter.percent = 1

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(true)
			end
		end

		arg_114_1.nodeConfigList_ = {}

		arg_114_1:InitPlayNodeList()
	end,
	Play116171028 = function(arg_118_0, arg_118_1)
		arg_118_1.time_ = 0
		arg_118_1.frameCnt_ = 0
		arg_118_1.state_ = "playing"
		arg_118_1.curTalkId_ = 116171028
		arg_118_1.duration_ = 6.03

		local var_118_0 = {
			zh = 4.566,
			ja = 6.033
		}
		local var_118_1 = manager.audio:GetLocalizationFlag()

		if var_118_0[var_118_1] ~= nil then
			arg_118_1.duration_ = var_118_0[var_118_1]
		end

		SetActive(arg_118_1.tipsGo_, false)

		function arg_118_1.onSingleLineFinish_()
			arg_118_1.onSingleLineUpdate_ = nil
			arg_118_1.onSingleLineFinish_ = nil
			arg_118_1.state_ = "waiting"
		end

		function arg_118_1.playNext_(arg_120_0)
			if arg_120_0 == 1 then
				arg_118_0:Play116171029(arg_118_1)
			end
		end

		function arg_118_1.onSingleLineUpdate_(arg_121_0)
			local var_121_0 = 0.35

			if 0 < arg_118_1.time_ and arg_118_1.time_ <= 0 + arg_121_0 then
				arg_118_1.talkMaxDuration = 0
				arg_118_1.dialogCg_.alpha = 1

				arg_118_1.dialog_:SetActive(true)
				SetActive(arg_118_1.leftNameGo_, true)

				arg_118_1.leftNameTxt_.text = arg_118_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_118_1.leftNameTxt_.transform)

				arg_118_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_118_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_118_1:RecordName(arg_118_1.leftNameTxt_.text)
				SetActive(arg_118_1.iconTrs_.gameObject, false)
				arg_118_1.callingController_:SetSelectedState("normal")

				local var_121_1 = arg_118_1:GetWordFromCfg(116171028)
				local var_121_2 = arg_118_1:FormatText(var_121_1.content)

				arg_118_1.text_.text = var_121_2

				LuaForUtil.ClearLinePrefixSymbol(arg_118_1.text_)

				local var_121_4 = 14 <= 0 and var_121_0 or var_121_0 * (utf8.len(var_121_2) / 14)

				if (14 <= 0 and var_121_0 or var_121_0 * (utf8.len(var_121_2) / 14)) > 0 and var_121_0 < var_121_4 then
					arg_118_1.talkMaxDuration = var_121_4

					if var_121_4 + 0 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_4 + 0
					end
				end

				arg_118_1.text_.text = var_121_2
				arg_118_1.typewritter.percent = 0

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116171", "116171028", "story_v_out_116171.awb") ~= 0 then
					local var_121_5 = manager.audio:GetVoiceLength("story_v_out_116171", "116171028", "story_v_out_116171.awb") / 1000

					if var_121_5 + 0 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_5 + 0
					end

					if var_121_1.prefab_name ~= "" and arg_118_1.actors_[var_121_1.prefab_name] ~= nil then
						local var_121_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_118_1.actors_[var_121_1.prefab_name].transform, "story_v_out_116171", "116171028", "story_v_out_116171.awb")

						arg_118_1:RecordAudio("116171028", var_121_6)
						arg_118_1:RecordAudio("116171028", var_121_6)
					else
						arg_118_1:AudioAction("play", "voice", "story_v_out_116171", "116171028", "story_v_out_116171.awb")
					end

					arg_118_1:RecordHistoryTalkVoice("story_v_out_116171", "116171028", "story_v_out_116171.awb")
				end

				arg_118_1:RecordContent(arg_118_1.text_.text)
			end

			local var_121_7 = math.max(var_121_0, arg_118_1.talkMaxDuration)

			if 0 <= arg_118_1.time_ and arg_118_1.time_ < 0 + var_121_7 then
				arg_118_1.typewritter.percent = (arg_118_1.time_ - 0) / var_121_7

				arg_118_1.typewritter:SetDirty()
			end

			if arg_118_1.time_ >= 0 + var_121_7 and arg_118_1.time_ < 0 + var_121_7 + arg_121_0 then
				arg_118_1.typewritter.percent = 1

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(true)
			end
		end

		arg_118_1.nodeConfigList_ = {}

		arg_118_1:InitPlayNodeList()
	end,
	Play116171029 = function(arg_122_0, arg_122_1)
		arg_122_1.time_ = 0
		arg_122_1.frameCnt_ = 0
		arg_122_1.state_ = "playing"
		arg_122_1.curTalkId_ = 116171029
		arg_122_1.duration_ = 5

		SetActive(arg_122_1.tipsGo_, false)

		function arg_122_1.onSingleLineFinish_()
			arg_122_1.onSingleLineUpdate_ = nil
			arg_122_1.onSingleLineFinish_ = nil
			arg_122_1.state_ = "waiting"
		end

		function arg_122_1.playNext_(arg_124_0)
			if arg_124_0 == 1 then
				arg_122_0:Play116171030(arg_122_1)
			end
		end

		function arg_122_1.onSingleLineUpdate_(arg_125_0)
			local var_125_0 = 0.2

			if 0 < arg_122_1.time_ and arg_122_1.time_ <= 0 + arg_125_0 then
				arg_122_1.talkMaxDuration = 0
				arg_122_1.dialogCg_.alpha = 1

				arg_122_1.dialog_:SetActive(true)
				SetActive(arg_122_1.leftNameGo_, true)

				arg_122_1.leftNameTxt_.text = arg_122_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_122_1.leftNameTxt_.transform)

				arg_122_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_122_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_122_1:RecordName(arg_122_1.leftNameTxt_.text)
				SetActive(arg_122_1.iconTrs_.gameObject, true)
				arg_122_1.iconController_:SetSelectedState("hero")

				arg_122_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_122_1.callingController_:SetSelectedState("normal")

				arg_122_1.keyicon_.color = Color.New(1, 1, 1)
				arg_122_1.icon_.color = Color.New(1, 1, 1)

				local var_125_1 = arg_122_1:FormatText(arg_122_1:GetWordFromCfg(116171029).content)

				arg_122_1.text_.text = var_125_1

				LuaForUtil.ClearLinePrefixSymbol(arg_122_1.text_)

				local var_125_3 = 8 <= 0 and var_125_0 or var_125_0 * (utf8.len(var_125_1) / 8)

				if (8 <= 0 and var_125_0 or var_125_0 * (utf8.len(var_125_1) / 8)) > 0 and var_125_0 < var_125_3 then
					arg_122_1.talkMaxDuration = var_125_3

					if var_125_3 + 0 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_3 + 0
					end
				end

				arg_122_1.text_.text = var_125_1
				arg_122_1.typewritter.percent = 0

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(false)
				arg_122_1:RecordContent(arg_122_1.text_.text)
			end

			local var_125_4 = math.max(var_125_0, arg_122_1.talkMaxDuration)

			if 0 <= arg_122_1.time_ and arg_122_1.time_ < 0 + var_125_4 then
				arg_122_1.typewritter.percent = (arg_122_1.time_ - 0) / var_125_4

				arg_122_1.typewritter:SetDirty()
			end

			if arg_122_1.time_ >= 0 + var_125_4 and arg_122_1.time_ < 0 + var_125_4 + arg_125_0 then
				arg_122_1.typewritter.percent = 1

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(true)
			end
		end

		arg_122_1.nodeConfigList_ = {}

		arg_122_1:InitPlayNodeList()
	end,
	Play116171030 = function(arg_126_0, arg_126_1)
		arg_126_1.time_ = 0
		arg_126_1.frameCnt_ = 0
		arg_126_1.state_ = "playing"
		arg_126_1.curTalkId_ = 116171030
		arg_126_1.duration_ = 5

		SetActive(arg_126_1.tipsGo_, false)

		function arg_126_1.onSingleLineFinish_()
			arg_126_1.onSingleLineUpdate_ = nil
			arg_126_1.onSingleLineFinish_ = nil
			arg_126_1.state_ = "waiting"
		end

		function arg_126_1.playNext_(arg_128_0)
			if arg_128_0 == 1 then
				arg_126_0:Play116171031(arg_126_1)
			end
		end

		function arg_126_1.onSingleLineUpdate_(arg_129_0)
			local var_129_0 = 0.775

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= 0 + arg_129_0 then
				arg_126_1.talkMaxDuration = 0
				arg_126_1.dialogCg_.alpha = 1

				arg_126_1.dialog_:SetActive(true)
				SetActive(arg_126_1.leftNameGo_, false)

				arg_126_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_126_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_126_1:RecordName(arg_126_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_126_1.iconTrs_.gameObject, false)
				arg_126_1.callingController_:SetSelectedState("normal")

				local var_129_1 = arg_126_1:FormatText(arg_126_1:GetWordFromCfg(116171030).content)

				arg_126_1.text_.text = var_129_1

				LuaForUtil.ClearLinePrefixSymbol(arg_126_1.text_)

				local var_129_3 = 31 <= 0 and var_129_0 or var_129_0 * (utf8.len(var_129_1) / 31)

				if (31 <= 0 and var_129_0 or var_129_0 * (utf8.len(var_129_1) / 31)) > 0 and var_129_0 < var_129_3 then
					arg_126_1.talkMaxDuration = var_129_3

					if var_129_3 + 0 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_3 + 0
					end
				end

				arg_126_1.text_.text = var_129_1
				arg_126_1.typewritter.percent = 0

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(false)
				arg_126_1:RecordContent(arg_126_1.text_.text)
			end

			local var_129_4 = math.max(var_129_0, arg_126_1.talkMaxDuration)

			if 0 <= arg_126_1.time_ and arg_126_1.time_ < 0 + var_129_4 then
				arg_126_1.typewritter.percent = (arg_126_1.time_ - 0) / var_129_4

				arg_126_1.typewritter:SetDirty()
			end

			if arg_126_1.time_ >= 0 + var_129_4 and arg_126_1.time_ < 0 + var_129_4 + arg_129_0 then
				arg_126_1.typewritter.percent = 1

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(true)
			end
		end

		arg_126_1.nodeConfigList_ = {}

		arg_126_1:InitPlayNodeList()
	end,
	Play116171031 = function(arg_130_0, arg_130_1)
		arg_130_1.time_ = 0
		arg_130_1.frameCnt_ = 0
		arg_130_1.state_ = "playing"
		arg_130_1.curTalkId_ = 116171031
		arg_130_1.duration_ = 5

		SetActive(arg_130_1.tipsGo_, false)

		function arg_130_1.onSingleLineFinish_()
			arg_130_1.onSingleLineUpdate_ = nil
			arg_130_1.onSingleLineFinish_ = nil
			arg_130_1.state_ = "waiting"
			arg_130_1.auto_ = false
		end

		function arg_130_1.playNext_(arg_132_0)
			arg_130_1.onStoryFinished_()
		end

		function arg_130_1.onSingleLineUpdate_(arg_133_0)
			local var_133_0 = 0.3

			if 0 < arg_130_1.time_ and arg_130_1.time_ <= 0 + arg_133_0 then
				arg_130_1.talkMaxDuration = 0
				arg_130_1.dialogCg_.alpha = 1

				arg_130_1.dialog_:SetActive(true)
				SetActive(arg_130_1.leftNameGo_, false)

				arg_130_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_130_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_130_1:RecordName(arg_130_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_130_1.iconTrs_.gameObject, false)
				arg_130_1.callingController_:SetSelectedState("normal")

				local var_133_1 = arg_130_1:FormatText(arg_130_1:GetWordFromCfg(116171031).content)

				arg_130_1.text_.text = var_133_1

				LuaForUtil.ClearLinePrefixSymbol(arg_130_1.text_)

				local var_133_3 = 12 <= 0 and var_133_0 or var_133_0 * (utf8.len(var_133_1) / 12)

				if (12 <= 0 and var_133_0 or var_133_0 * (utf8.len(var_133_1) / 12)) > 0 and var_133_0 < var_133_3 then
					arg_130_1.talkMaxDuration = var_133_3

					if var_133_3 + 0 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_3 + 0
					end
				end

				arg_130_1.text_.text = var_133_1
				arg_130_1.typewritter.percent = 0

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(false)
				arg_130_1:RecordContent(arg_130_1.text_.text)
			end

			local var_133_4 = math.max(var_133_0, arg_130_1.talkMaxDuration)

			if 0 <= arg_130_1.time_ and arg_130_1.time_ < 0 + var_133_4 then
				arg_130_1.typewritter.percent = (arg_130_1.time_ - 0) / var_133_4

				arg_130_1.typewritter:SetDirty()
			end

			if arg_130_1.time_ >= 0 + var_133_4 and arg_130_1.time_ < 0 + var_133_4 + arg_133_0 then
				arg_130_1.typewritter.percent = 1

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(true)
			end
		end

		arg_130_1.nodeConfigList_ = {}

		arg_130_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/I06",
		"TextureConfig/Background/SK0202"
	},
	voices = {
		"story_v_out_116171.awb"
	}
}
