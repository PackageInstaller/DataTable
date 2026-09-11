return {
	Play116301001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 116301001
		arg_1_1.duration_ = 15

		local var_1_0 = {
			zh = 15,
			ja = 9.266
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
				arg_1_0:Play116301002(arg_1_1)
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
				arg_1_1:AudioAction("play", "music", "bgm_story_scheme", "bgm_story_scheme", "bgm_story_scheme.awb")

				local var_4_13 = manager.audio:GetAudioName("bgm_story_scheme", "bgm_story_scheme")

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

			local var_4_14 = "10024ui_story"

			if arg_1_1.actors_["10024ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10024ui_story"))) then
				local var_4_15 = Object.Instantiate(Asset.Load("Char/" .. "10024ui_story"), arg_1_1.stage_.transform)

				var_4_15.name = var_4_14
				var_4_15.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.actors_[var_4_14] = var_4_15

				local var_4_16 = var_4_15:GetComponentInChildren(typeof(CharacterEffect))

				var_4_16.enabled = true

				local var_4_17 = GameObjectTools.GetOrAddComponent(var_4_15, typeof(DynamicBoneHelper))

				if var_4_17 then
					var_4_17:EnableDynamicBone(false)
				end

				arg_1_1:ShowWeapon(var_4_16.transform, false)

				arg_1_1.var_[var_4_14 .. "Animator"] = var_4_16.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_1_1.var_[var_4_14 .. "Animator"].applyRootMotion = true
				arg_1_1.var_[var_4_14 .. "LipSync"] = var_4_16.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_4_18 = arg_1_1.actors_["10024ui_story"].transform

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 then
				arg_1_1.var_.moveOldPos10024ui_story = var_4_18.localPosition
			end

			local var_4_19 = 0.001

			if 2 <= arg_1_1.time_ and arg_1_1.time_ < 2 + var_4_19 then
				var_4_18.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos10024ui_story, Vector3.New(0, -1, -6), (arg_1_1.time_ - 2) / var_4_19)
				var_4_18.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_18.position).x, (manager.ui.mainCamera.transform.position - var_4_18.position).y, (manager.ui.mainCamera.transform.position - var_4_18.position).z)
				var_4_18.localEulerAngles.z = 0
				var_4_18.localEulerAngles.x = 0
				var_4_18.localEulerAngles = var_4_18.localEulerAngles
			end

			if arg_1_1.time_ >= 2 + var_4_19 and arg_1_1.time_ < 2 + var_4_19 + arg_4_0 then
				var_4_18.localPosition = Vector3.New(0, -1, -6)
				var_4_18.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_18.position).x, (manager.ui.mainCamera.transform.position - var_4_18.position).y, (manager.ui.mainCamera.transform.position - var_4_18.position).z)
				var_4_18.localEulerAngles.z = 0
				var_4_18.localEulerAngles.x = 0
				var_4_18.localEulerAngles = var_4_18.localEulerAngles
			end

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 then
				arg_1_1:PlayTimeline("10024ui_story", "StoryTimeline/CharAction/story10024/story10024action/10024action1_1")
			end

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 then
				arg_1_1:PlayTimeline("10024ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_4_20 = arg_1_1.actors_["10024ui_story"]

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 and not isNil(var_4_20) and arg_1_1.var_.characterEffect10024ui_story == nil then
				arg_1_1.var_.characterEffect10024ui_story = var_4_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_21 = 0.2

			if 2 <= arg_1_1.time_ and arg_1_1.time_ < 2 + var_4_21 and not isNil(var_4_20) then
				if arg_1_1.var_.characterEffect10024ui_story and not isNil(var_4_20) then
					arg_1_1.var_.characterEffect10024ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= 2 + var_4_21 and arg_1_1.time_ < 2 + var_4_21 + arg_4_0 and not isNil(var_4_20) and arg_1_1.var_.characterEffect10024ui_story then
				arg_1_1.var_.characterEffect10024ui_story.fillFlat = false
			end

			local var_4_23 = 2
			local var_4_24 = 1.125

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_23 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0
				arg_1_1.dialogCg_.alpha = 1

				arg_1_1.dialog_:SetActive(true)
				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_25 = arg_1_1:GetWordFromCfg(116301001)
				local var_4_26 = arg_1_1:FormatText(var_4_25.content)

				arg_1_1.text_.text = var_4_26

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_28 = 45 <= 0 and var_4_24 or var_4_24 * (utf8.len(var_4_26) / 45)

				if (45 <= 0 and var_4_24 or var_4_24 * (utf8.len(var_4_26) / 45)) > 0 and var_4_24 < var_4_28 then
					arg_1_1.talkMaxDuration = var_4_28

					if var_4_28 + var_4_23 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_28 + var_4_23
					end
				end

				arg_1_1.text_.text = var_4_26
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116301", "116301001", "story_v_out_116301.awb") ~= 0 then
					local var_4_29 = manager.audio:GetVoiceLength("story_v_out_116301", "116301001", "story_v_out_116301.awb") / 1000

					if var_4_29 + var_4_23 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_29 + var_4_23
					end

					if var_4_25.prefab_name ~= "" and arg_1_1.actors_[var_4_25.prefab_name] ~= nil then
						local var_4_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_25.prefab_name].transform, "story_v_out_116301", "116301001", "story_v_out_116301.awb")

						arg_1_1:RecordAudio("116301001", var_4_30)
						arg_1_1:RecordAudio("116301001", var_4_30)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_116301", "116301001", "story_v_out_116301.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_116301", "116301001", "story_v_out_116301.awb")
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
				actorName = "10024ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play116301002 = function(arg_7_0, arg_7_1)
		arg_7_1.time_ = 0
		arg_7_1.frameCnt_ = 0
		arg_7_1.state_ = "playing"
		arg_7_1.curTalkId_ = 116301002
		arg_7_1.duration_ = 11.47

		local var_7_0 = {
			zh = 10.033,
			ja = 11.466
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
				arg_7_0:Play116301003(arg_7_1)
			end
		end

		function arg_7_1.onSingleLineUpdate_(arg_10_0)
			if 0 < arg_7_1.time_ and arg_7_1.time_ <= 0 + arg_10_0 then
				arg_7_1:PlayTimeline("10024ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			if 0 < arg_7_1.time_ and arg_7_1.time_ <= 0 + arg_10_0 then
				arg_7_1:PlayTimeline("10024ui_story", "StoryTimeline/CharAction/story10024/story10024action/10024action6_1")
			end

			local var_10_0 = 0
			local var_10_1 = 0.975

			if 0 < arg_7_1.time_ and arg_7_1.time_ <= var_10_0 + arg_10_0 then
				arg_7_1.talkMaxDuration = 0
				arg_7_1.dialogCg_.alpha = 1

				arg_7_1.dialog_:SetActive(true)
				SetActive(arg_7_1.leftNameGo_, true)

				arg_7_1.leftNameTxt_.text = arg_7_1:FormatText(StoryNameCfg[332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_7_1.leftNameTxt_.transform)

				arg_7_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_7_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_7_1:RecordName(arg_7_1.leftNameTxt_.text)
				SetActive(arg_7_1.iconTrs_.gameObject, false)
				arg_7_1.callingController_:SetSelectedState("normal")

				local var_10_2 = arg_7_1:GetWordFromCfg(116301002)
				local var_10_3 = arg_7_1:FormatText(var_10_2.content)

				arg_7_1.text_.text = var_10_3

				LuaForUtil.ClearLinePrefixSymbol(arg_7_1.text_)

				local var_10_5 = 39 <= 0 and var_10_1 or var_10_1 * (utf8.len(var_10_3) / 39)

				if (39 <= 0 and var_10_1 or var_10_1 * (utf8.len(var_10_3) / 39)) > 0 and var_10_1 < var_10_5 then
					arg_7_1.talkMaxDuration = var_10_5

					if var_10_5 + var_10_0 > arg_7_1.duration_ then
						arg_7_1.duration_ = var_10_5 + var_10_0
					end
				end

				arg_7_1.text_.text = var_10_3
				arg_7_1.typewritter.percent = 0

				arg_7_1.typewritter:SetDirty()
				arg_7_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116301", "116301002", "story_v_out_116301.awb") ~= 0 then
					local var_10_6 = manager.audio:GetVoiceLength("story_v_out_116301", "116301002", "story_v_out_116301.awb") / 1000

					if var_10_6 + var_10_0 > arg_7_1.duration_ then
						arg_7_1.duration_ = var_10_6 + var_10_0
					end

					if var_10_2.prefab_name ~= "" and arg_7_1.actors_[var_10_2.prefab_name] ~= nil then
						local var_10_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_7_1.actors_[var_10_2.prefab_name].transform, "story_v_out_116301", "116301002", "story_v_out_116301.awb")

						arg_7_1:RecordAudio("116301002", var_10_7)
						arg_7_1:RecordAudio("116301002", var_10_7)
					else
						arg_7_1:AudioAction("play", "voice", "story_v_out_116301", "116301002", "story_v_out_116301.awb")
					end

					arg_7_1:RecordHistoryTalkVoice("story_v_out_116301", "116301002", "story_v_out_116301.awb")
				end

				arg_7_1:RecordContent(arg_7_1.text_.text)
			end

			local var_10_8 = math.max(var_10_1, arg_7_1.talkMaxDuration)

			if var_10_0 <= arg_7_1.time_ and arg_7_1.time_ < var_10_0 + var_10_8 then
				arg_7_1.typewritter.percent = (arg_7_1.time_ - var_10_0) / var_10_8

				arg_7_1.typewritter:SetDirty()
			end

			if arg_7_1.time_ >= var_10_0 + var_10_8 and arg_7_1.time_ < var_10_0 + var_10_8 + arg_10_0 then
				arg_7_1.typewritter.percent = 1

				arg_7_1.typewritter:SetDirty()
				arg_7_1:ShowNextGo(true)
			end
		end

		arg_7_1.nodeConfigList_ = {}

		arg_7_1:InitPlayNodeList()
	end,
	Play116301003 = function(arg_11_0, arg_11_1)
		arg_11_1.time_ = 0
		arg_11_1.frameCnt_ = 0
		arg_11_1.state_ = "playing"
		arg_11_1.curTalkId_ = 116301003
		arg_11_1.duration_ = 5

		SetActive(arg_11_1.tipsGo_, false)

		function arg_11_1.onSingleLineFinish_()
			arg_11_1.onSingleLineUpdate_ = nil
			arg_11_1.onSingleLineFinish_ = nil
			arg_11_1.state_ = "waiting"
		end

		function arg_11_1.playNext_(arg_13_0)
			if arg_13_0 == 1 then
				arg_11_0:Play116301004(arg_11_1)
			end
		end

		function arg_11_1.onSingleLineUpdate_(arg_14_0)
			if 0 < arg_11_1.time_ and arg_11_1.time_ <= 0 + arg_14_0 and not isNil(arg_11_1.actors_["10024ui_story"]) and arg_11_1.var_.characterEffect10024ui_story == nil then
				arg_11_1.var_.characterEffect10024ui_story = arg_11_1.actors_["10024ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_14_0 = 0.2

			if 0 <= arg_11_1.time_ and arg_11_1.time_ < 0 + var_14_0 and not isNil(arg_11_1.actors_["10024ui_story"]) then
				if arg_11_1.var_.characterEffect10024ui_story and not isNil(arg_11_1.actors_["10024ui_story"]) then
					arg_11_1.var_.characterEffect10024ui_story.fillFlat = true
					arg_11_1.var_.characterEffect10024ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_11_1.time_ - 0) / var_14_0)
				end
			end

			if arg_11_1.time_ >= 0 + var_14_0 and arg_11_1.time_ < 0 + var_14_0 + arg_14_0 and not isNil(arg_11_1.actors_["10024ui_story"]) and arg_11_1.var_.characterEffect10024ui_story then
				arg_11_1.var_.characterEffect10024ui_story.fillFlat = true
				arg_11_1.var_.characterEffect10024ui_story.fillRatio = 0.5
			end

			local var_14_1 = 0
			local var_14_2 = 0.95

			if 0 < arg_11_1.time_ and arg_11_1.time_ <= var_14_1 + arg_14_0 then
				arg_11_1.talkMaxDuration = 0
				arg_11_1.dialogCg_.alpha = 1

				arg_11_1.dialog_:SetActive(true)
				SetActive(arg_11_1.leftNameGo_, true)

				arg_11_1.leftNameTxt_.text = arg_11_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_11_1.leftNameTxt_.transform)

				arg_11_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_11_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_11_1:RecordName(arg_11_1.leftNameTxt_.text)
				SetActive(arg_11_1.iconTrs_.gameObject, true)
				arg_11_1.iconController_:SetSelectedState("hero")

				arg_11_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_11_1.callingController_:SetSelectedState("normal")

				arg_11_1.keyicon_.color = Color.New(1, 1, 1)
				arg_11_1.icon_.color = Color.New(1, 1, 1)

				local var_14_3 = arg_11_1:FormatText(arg_11_1:GetWordFromCfg(116301003).content)

				arg_11_1.text_.text = var_14_3

				LuaForUtil.ClearLinePrefixSymbol(arg_11_1.text_)

				local var_14_5 = 38 <= 0 and var_14_2 or var_14_2 * (utf8.len(var_14_3) / 38)

				if (38 <= 0 and var_14_2 or var_14_2 * (utf8.len(var_14_3) / 38)) > 0 and var_14_2 < var_14_5 then
					arg_11_1.talkMaxDuration = var_14_5

					if var_14_5 + var_14_1 > arg_11_1.duration_ then
						arg_11_1.duration_ = var_14_5 + var_14_1
					end
				end

				arg_11_1.text_.text = var_14_3
				arg_11_1.typewritter.percent = 0

				arg_11_1.typewritter:SetDirty()
				arg_11_1:ShowNextGo(false)
				arg_11_1:RecordContent(arg_11_1.text_.text)
			end

			local var_14_6 = math.max(var_14_2, arg_11_1.talkMaxDuration)

			if var_14_1 <= arg_11_1.time_ and arg_11_1.time_ < var_14_1 + var_14_6 then
				arg_11_1.typewritter.percent = (arg_11_1.time_ - var_14_1) / var_14_6

				arg_11_1.typewritter:SetDirty()
			end

			if arg_11_1.time_ >= var_14_1 + var_14_6 and arg_11_1.time_ < var_14_1 + var_14_6 + arg_14_0 then
				arg_11_1.typewritter.percent = 1

				arg_11_1.typewritter:SetDirty()
				arg_11_1:ShowNextGo(true)
			end
		end

		arg_11_1.nodeConfigList_ = {}

		arg_11_1:InitPlayNodeList()
	end,
	Play116301004 = function(arg_15_0, arg_15_1)
		arg_15_1.time_ = 0
		arg_15_1.frameCnt_ = 0
		arg_15_1.state_ = "playing"
		arg_15_1.curTalkId_ = 116301004
		arg_15_1.duration_ = 5.97

		local var_15_0 = {
			zh = 4.6,
			ja = 5.966
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
				arg_15_0:Play116301005(arg_15_1)
			end
		end

		function arg_15_1.onSingleLineUpdate_(arg_18_0)
			if 0 < arg_15_1.time_ and arg_15_1.time_ <= 0 + arg_18_0 and not isNil(arg_15_1.actors_["10024ui_story"]) and arg_15_1.var_.characterEffect10024ui_story == nil then
				arg_15_1.var_.characterEffect10024ui_story = arg_15_1.actors_["10024ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_18_0 = 0.2

			if 0 <= arg_15_1.time_ and arg_15_1.time_ < 0 + var_18_0 and not isNil(arg_15_1.actors_["10024ui_story"]) then
				if arg_15_1.var_.characterEffect10024ui_story and not isNil(arg_15_1.actors_["10024ui_story"]) then
					arg_15_1.var_.characterEffect10024ui_story.fillFlat = false
				end
			end

			if arg_15_1.time_ >= 0 + var_18_0 and arg_15_1.time_ < 0 + var_18_0 + arg_18_0 and not isNil(arg_15_1.actors_["10024ui_story"]) and arg_15_1.var_.characterEffect10024ui_story then
				arg_15_1.var_.characterEffect10024ui_story.fillFlat = false
			end

			if 0 < arg_15_1.time_ and arg_15_1.time_ <= 0 + arg_18_0 then
				arg_15_1:PlayTimeline("10024ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_18_2 = 0
			local var_18_3 = 0.475

			if 0 < arg_15_1.time_ and arg_15_1.time_ <= var_18_2 + arg_18_0 then
				arg_15_1.talkMaxDuration = 0
				arg_15_1.dialogCg_.alpha = 1

				arg_15_1.dialog_:SetActive(true)
				SetActive(arg_15_1.leftNameGo_, true)

				arg_15_1.leftNameTxt_.text = arg_15_1:FormatText(StoryNameCfg[332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_15_1.leftNameTxt_.transform)

				arg_15_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_15_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_15_1:RecordName(arg_15_1.leftNameTxt_.text)
				SetActive(arg_15_1.iconTrs_.gameObject, false)
				arg_15_1.callingController_:SetSelectedState("normal")

				local var_18_4 = arg_15_1:GetWordFromCfg(116301004)
				local var_18_5 = arg_15_1:FormatText(var_18_4.content)

				arg_15_1.text_.text = var_18_5

				LuaForUtil.ClearLinePrefixSymbol(arg_15_1.text_)

				local var_18_7 = 19 <= 0 and var_18_3 or var_18_3 * (utf8.len(var_18_5) / 19)

				if (19 <= 0 and var_18_3 or var_18_3 * (utf8.len(var_18_5) / 19)) > 0 and var_18_3 < var_18_7 then
					arg_15_1.talkMaxDuration = var_18_7

					if var_18_7 + var_18_2 > arg_15_1.duration_ then
						arg_15_1.duration_ = var_18_7 + var_18_2
					end
				end

				arg_15_1.text_.text = var_18_5
				arg_15_1.typewritter.percent = 0

				arg_15_1.typewritter:SetDirty()
				arg_15_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116301", "116301004", "story_v_out_116301.awb") ~= 0 then
					local var_18_8 = manager.audio:GetVoiceLength("story_v_out_116301", "116301004", "story_v_out_116301.awb") / 1000

					if var_18_8 + var_18_2 > arg_15_1.duration_ then
						arg_15_1.duration_ = var_18_8 + var_18_2
					end

					if var_18_4.prefab_name ~= "" and arg_15_1.actors_[var_18_4.prefab_name] ~= nil then
						local var_18_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_15_1.actors_[var_18_4.prefab_name].transform, "story_v_out_116301", "116301004", "story_v_out_116301.awb")

						arg_15_1:RecordAudio("116301004", var_18_9)
						arg_15_1:RecordAudio("116301004", var_18_9)
					else
						arg_15_1:AudioAction("play", "voice", "story_v_out_116301", "116301004", "story_v_out_116301.awb")
					end

					arg_15_1:RecordHistoryTalkVoice("story_v_out_116301", "116301004", "story_v_out_116301.awb")
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
	Play116301005 = function(arg_19_0, arg_19_1)
		arg_19_1.time_ = 0
		arg_19_1.frameCnt_ = 0
		arg_19_1.state_ = "playing"
		arg_19_1.curTalkId_ = 116301005
		arg_19_1.duration_ = 6.07

		local var_19_0 = {
			zh = 6.066,
			ja = 3.666
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
				arg_19_0:Play116301006(arg_19_1)
			end
		end

		function arg_19_1.onSingleLineUpdate_(arg_22_0)
			if 0 < arg_19_1.time_ and arg_19_1.time_ <= 0 + arg_22_0 then
				arg_19_1:PlayTimeline("10024ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= 0 + arg_22_0 then
				arg_19_1:PlayTimeline("10024ui_story", "StoryTimeline/CharAction/story10024/story10024actionlink/10024action462")
			end

			local var_22_0 = 0
			local var_22_1 = 0.65

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= var_22_0 + arg_22_0 then
				arg_19_1.talkMaxDuration = 0
				arg_19_1.dialogCg_.alpha = 1

				arg_19_1.dialog_:SetActive(true)
				SetActive(arg_19_1.leftNameGo_, true)

				arg_19_1.leftNameTxt_.text = arg_19_1:FormatText(StoryNameCfg[332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_19_1.leftNameTxt_.transform)

				arg_19_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_19_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_19_1:RecordName(arg_19_1.leftNameTxt_.text)
				SetActive(arg_19_1.iconTrs_.gameObject, false)
				arg_19_1.callingController_:SetSelectedState("normal")

				local var_22_2 = arg_19_1:GetWordFromCfg(116301005)
				local var_22_3 = arg_19_1:FormatText(var_22_2.content)

				arg_19_1.text_.text = var_22_3

				LuaForUtil.ClearLinePrefixSymbol(arg_19_1.text_)

				local var_22_5 = 26 <= 0 and var_22_1 or var_22_1 * (utf8.len(var_22_3) / 26)

				if (26 <= 0 and var_22_1 or var_22_1 * (utf8.len(var_22_3) / 26)) > 0 and var_22_1 < var_22_5 then
					arg_19_1.talkMaxDuration = var_22_5

					if var_22_5 + var_22_0 > arg_19_1.duration_ then
						arg_19_1.duration_ = var_22_5 + var_22_0
					end
				end

				arg_19_1.text_.text = var_22_3
				arg_19_1.typewritter.percent = 0

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116301", "116301005", "story_v_out_116301.awb") ~= 0 then
					local var_22_6 = manager.audio:GetVoiceLength("story_v_out_116301", "116301005", "story_v_out_116301.awb") / 1000

					if var_22_6 + var_22_0 > arg_19_1.duration_ then
						arg_19_1.duration_ = var_22_6 + var_22_0
					end

					if var_22_2.prefab_name ~= "" and arg_19_1.actors_[var_22_2.prefab_name] ~= nil then
						local var_22_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_19_1.actors_[var_22_2.prefab_name].transform, "story_v_out_116301", "116301005", "story_v_out_116301.awb")

						arg_19_1:RecordAudio("116301005", var_22_7)
						arg_19_1:RecordAudio("116301005", var_22_7)
					else
						arg_19_1:AudioAction("play", "voice", "story_v_out_116301", "116301005", "story_v_out_116301.awb")
					end

					arg_19_1:RecordHistoryTalkVoice("story_v_out_116301", "116301005", "story_v_out_116301.awb")
				end

				arg_19_1:RecordContent(arg_19_1.text_.text)
			end

			local var_22_8 = math.max(var_22_1, arg_19_1.talkMaxDuration)

			if var_22_0 <= arg_19_1.time_ and arg_19_1.time_ < var_22_0 + var_22_8 then
				arg_19_1.typewritter.percent = (arg_19_1.time_ - var_22_0) / var_22_8

				arg_19_1.typewritter:SetDirty()
			end

			if arg_19_1.time_ >= var_22_0 + var_22_8 and arg_19_1.time_ < var_22_0 + var_22_8 + arg_22_0 then
				arg_19_1.typewritter.percent = 1

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(true)
			end
		end

		arg_19_1.nodeConfigList_ = {}

		arg_19_1:InitPlayNodeList()
	end,
	Play116301006 = function(arg_23_0, arg_23_1)
		arg_23_1.time_ = 0
		arg_23_1.frameCnt_ = 0
		arg_23_1.state_ = "playing"
		arg_23_1.curTalkId_ = 116301006
		arg_23_1.duration_ = 14.2

		local var_23_0 = {
			zh = 14.2,
			ja = 12.733
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
				arg_23_0:Play116301007(arg_23_1)
			end
		end

		function arg_23_1.onSingleLineUpdate_(arg_26_0)
			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 then
				arg_23_1:PlayTimeline("10024ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_26_0 = 0
			local var_26_1 = 1.5

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= var_26_0 + arg_26_0 then
				arg_23_1.talkMaxDuration = 0
				arg_23_1.dialogCg_.alpha = 1

				arg_23_1.dialog_:SetActive(true)
				SetActive(arg_23_1.leftNameGo_, true)

				arg_23_1.leftNameTxt_.text = arg_23_1:FormatText(StoryNameCfg[332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_23_1.leftNameTxt_.transform)

				arg_23_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_23_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_23_1:RecordName(arg_23_1.leftNameTxt_.text)
				SetActive(arg_23_1.iconTrs_.gameObject, false)
				arg_23_1.callingController_:SetSelectedState("normal")

				local var_26_2 = arg_23_1:GetWordFromCfg(116301006)
				local var_26_3 = arg_23_1:FormatText(var_26_2.content)

				arg_23_1.text_.text = var_26_3

				LuaForUtil.ClearLinePrefixSymbol(arg_23_1.text_)

				local var_26_5 = 60 <= 0 and var_26_1 or var_26_1 * (utf8.len(var_26_3) / 60)

				if (60 <= 0 and var_26_1 or var_26_1 * (utf8.len(var_26_3) / 60)) > 0 and var_26_1 < var_26_5 then
					arg_23_1.talkMaxDuration = var_26_5

					if var_26_5 + var_26_0 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_5 + var_26_0
					end
				end

				arg_23_1.text_.text = var_26_3
				arg_23_1.typewritter.percent = 0

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116301", "116301006", "story_v_out_116301.awb") ~= 0 then
					local var_26_6 = manager.audio:GetVoiceLength("story_v_out_116301", "116301006", "story_v_out_116301.awb") / 1000

					if var_26_6 + var_26_0 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_6 + var_26_0
					end

					if var_26_2.prefab_name ~= "" and arg_23_1.actors_[var_26_2.prefab_name] ~= nil then
						local var_26_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_23_1.actors_[var_26_2.prefab_name].transform, "story_v_out_116301", "116301006", "story_v_out_116301.awb")

						arg_23_1:RecordAudio("116301006", var_26_7)
						arg_23_1:RecordAudio("116301006", var_26_7)
					else
						arg_23_1:AudioAction("play", "voice", "story_v_out_116301", "116301006", "story_v_out_116301.awb")
					end

					arg_23_1:RecordHistoryTalkVoice("story_v_out_116301", "116301006", "story_v_out_116301.awb")
				end

				arg_23_1:RecordContent(arg_23_1.text_.text)
			end

			local var_26_8 = math.max(var_26_1, arg_23_1.talkMaxDuration)

			if var_26_0 <= arg_23_1.time_ and arg_23_1.time_ < var_26_0 + var_26_8 then
				arg_23_1.typewritter.percent = (arg_23_1.time_ - var_26_0) / var_26_8

				arg_23_1.typewritter:SetDirty()
			end

			if arg_23_1.time_ >= var_26_0 + var_26_8 and arg_23_1.time_ < var_26_0 + var_26_8 + arg_26_0 then
				arg_23_1.typewritter.percent = 1

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(true)
			end
		end

		arg_23_1.nodeConfigList_ = {}

		arg_23_1:InitPlayNodeList()
	end,
	Play116301007 = function(arg_27_0, arg_27_1)
		arg_27_1.time_ = 0
		arg_27_1.frameCnt_ = 0
		arg_27_1.state_ = "playing"
		arg_27_1.curTalkId_ = 116301007
		arg_27_1.duration_ = 9.37

		local var_27_0 = {
			zh = 8.8,
			ja = 9.366
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
				arg_27_0:Play116301008(arg_27_1)
			end
		end

		function arg_27_1.onSingleLineUpdate_(arg_30_0)
			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 then
				arg_27_1:PlayTimeline("10024ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 then
				arg_27_1:PlayTimeline("10024ui_story", "StoryTimeline/CharAction/story10024/story10024action/10024action2_2")
			end

			local var_30_0 = 0
			local var_30_1 = 0.875

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= var_30_0 + arg_30_0 then
				arg_27_1.talkMaxDuration = 0
				arg_27_1.dialogCg_.alpha = 1

				arg_27_1.dialog_:SetActive(true)
				SetActive(arg_27_1.leftNameGo_, true)

				arg_27_1.leftNameTxt_.text = arg_27_1:FormatText(StoryNameCfg[332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_27_1.leftNameTxt_.transform)

				arg_27_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_27_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_27_1:RecordName(arg_27_1.leftNameTxt_.text)
				SetActive(arg_27_1.iconTrs_.gameObject, false)
				arg_27_1.callingController_:SetSelectedState("normal")

				local var_30_2 = arg_27_1:GetWordFromCfg(116301007)
				local var_30_3 = arg_27_1:FormatText(var_30_2.content)

				arg_27_1.text_.text = var_30_3

				LuaForUtil.ClearLinePrefixSymbol(arg_27_1.text_)

				local var_30_5 = 35 <= 0 and var_30_1 or var_30_1 * (utf8.len(var_30_3) / 35)

				if (35 <= 0 and var_30_1 or var_30_1 * (utf8.len(var_30_3) / 35)) > 0 and var_30_1 < var_30_5 then
					arg_27_1.talkMaxDuration = var_30_5

					if var_30_5 + var_30_0 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_5 + var_30_0
					end
				end

				arg_27_1.text_.text = var_30_3
				arg_27_1.typewritter.percent = 0

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116301", "116301007", "story_v_out_116301.awb") ~= 0 then
					local var_30_6 = manager.audio:GetVoiceLength("story_v_out_116301", "116301007", "story_v_out_116301.awb") / 1000

					if var_30_6 + var_30_0 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_6 + var_30_0
					end

					if var_30_2.prefab_name ~= "" and arg_27_1.actors_[var_30_2.prefab_name] ~= nil then
						local var_30_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_27_1.actors_[var_30_2.prefab_name].transform, "story_v_out_116301", "116301007", "story_v_out_116301.awb")

						arg_27_1:RecordAudio("116301007", var_30_7)
						arg_27_1:RecordAudio("116301007", var_30_7)
					else
						arg_27_1:AudioAction("play", "voice", "story_v_out_116301", "116301007", "story_v_out_116301.awb")
					end

					arg_27_1:RecordHistoryTalkVoice("story_v_out_116301", "116301007", "story_v_out_116301.awb")
				end

				arg_27_1:RecordContent(arg_27_1.text_.text)
			end

			local var_30_8 = math.max(var_30_1, arg_27_1.talkMaxDuration)

			if var_30_0 <= arg_27_1.time_ and arg_27_1.time_ < var_30_0 + var_30_8 then
				arg_27_1.typewritter.percent = (arg_27_1.time_ - var_30_0) / var_30_8

				arg_27_1.typewritter:SetDirty()
			end

			if arg_27_1.time_ >= var_30_0 + var_30_8 and arg_27_1.time_ < var_30_0 + var_30_8 + arg_30_0 then
				arg_27_1.typewritter.percent = 1

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(true)
			end
		end

		arg_27_1.nodeConfigList_ = {}

		arg_27_1:InitPlayNodeList()
	end,
	Play116301008 = function(arg_31_0, arg_31_1)
		arg_31_1.time_ = 0
		arg_31_1.frameCnt_ = 0
		arg_31_1.state_ = "playing"
		arg_31_1.curTalkId_ = 116301008
		arg_31_1.duration_ = 15.63

		local var_31_0 = {
			zh = 14,
			ja = 15.633
		}
		local var_31_1 = manager.audio:GetLocalizationFlag()

		if var_31_0[var_31_1] ~= nil then
			arg_31_1.duration_ = var_31_0[var_31_1]
		end

		SetActive(arg_31_1.tipsGo_, false)

		function arg_31_1.onSingleLineFinish_()
			arg_31_1.onSingleLineUpdate_ = nil
			arg_31_1.onSingleLineFinish_ = nil
			arg_31_1.state_ = "waiting"
		end

		function arg_31_1.playNext_(arg_33_0)
			if arg_33_0 == 1 then
				arg_31_0:Play116301009(arg_31_1)
			end
		end

		function arg_31_1.onSingleLineUpdate_(arg_34_0)
			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 then
				arg_31_1:PlayTimeline("10024ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_34_0 = 0
			local var_34_1 = 1.325

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= var_34_0 + arg_34_0 then
				arg_31_1.talkMaxDuration = 0
				arg_31_1.dialogCg_.alpha = 1

				arg_31_1.dialog_:SetActive(true)
				SetActive(arg_31_1.leftNameGo_, true)

				arg_31_1.leftNameTxt_.text = arg_31_1:FormatText(StoryNameCfg[332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_31_1.leftNameTxt_.transform)

				arg_31_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_31_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_31_1:RecordName(arg_31_1.leftNameTxt_.text)
				SetActive(arg_31_1.iconTrs_.gameObject, false)
				arg_31_1.callingController_:SetSelectedState("normal")

				local var_34_2 = arg_31_1:GetWordFromCfg(116301008)
				local var_34_3 = arg_31_1:FormatText(var_34_2.content)

				arg_31_1.text_.text = var_34_3

				LuaForUtil.ClearLinePrefixSymbol(arg_31_1.text_)

				local var_34_5 = 53 <= 0 and var_34_1 or var_34_1 * (utf8.len(var_34_3) / 53)

				if (53 <= 0 and var_34_1 or var_34_1 * (utf8.len(var_34_3) / 53)) > 0 and var_34_1 < var_34_5 then
					arg_31_1.talkMaxDuration = var_34_5

					if var_34_5 + var_34_0 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_5 + var_34_0
					end
				end

				arg_31_1.text_.text = var_34_3
				arg_31_1.typewritter.percent = 0

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116301", "116301008", "story_v_out_116301.awb") ~= 0 then
					local var_34_6 = manager.audio:GetVoiceLength("story_v_out_116301", "116301008", "story_v_out_116301.awb") / 1000

					if var_34_6 + var_34_0 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_6 + var_34_0
					end

					if var_34_2.prefab_name ~= "" and arg_31_1.actors_[var_34_2.prefab_name] ~= nil then
						local var_34_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_31_1.actors_[var_34_2.prefab_name].transform, "story_v_out_116301", "116301008", "story_v_out_116301.awb")

						arg_31_1:RecordAudio("116301008", var_34_7)
						arg_31_1:RecordAudio("116301008", var_34_7)
					else
						arg_31_1:AudioAction("play", "voice", "story_v_out_116301", "116301008", "story_v_out_116301.awb")
					end

					arg_31_1:RecordHistoryTalkVoice("story_v_out_116301", "116301008", "story_v_out_116301.awb")
				end

				arg_31_1:RecordContent(arg_31_1.text_.text)
			end

			local var_34_8 = math.max(var_34_1, arg_31_1.talkMaxDuration)

			if var_34_0 <= arg_31_1.time_ and arg_31_1.time_ < var_34_0 + var_34_8 then
				arg_31_1.typewritter.percent = (arg_31_1.time_ - var_34_0) / var_34_8

				arg_31_1.typewritter:SetDirty()
			end

			if arg_31_1.time_ >= var_34_0 + var_34_8 and arg_31_1.time_ < var_34_0 + var_34_8 + arg_34_0 then
				arg_31_1.typewritter.percent = 1

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(true)
			end
		end

		arg_31_1.nodeConfigList_ = {}

		arg_31_1:InitPlayNodeList()
	end,
	Play116301009 = function(arg_35_0, arg_35_1)
		arg_35_1.time_ = 0
		arg_35_1.frameCnt_ = 0
		arg_35_1.state_ = "playing"
		arg_35_1.curTalkId_ = 116301009
		arg_35_1.duration_ = 6.37

		local var_35_0 = {
			zh = 6.366,
			ja = 6.333
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
				arg_35_0:Play116301010(arg_35_1)
			end
		end

		function arg_35_1.onSingleLineUpdate_(arg_38_0)
			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 and not isNil(arg_35_1.actors_["10024ui_story"]) and arg_35_1.var_.characterEffect10024ui_story == nil then
				arg_35_1.var_.characterEffect10024ui_story = arg_35_1.actors_["10024ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_38_0 = 0.2

			if 0 <= arg_35_1.time_ and arg_35_1.time_ < 0 + var_38_0 and not isNil(arg_35_1.actors_["10024ui_story"]) then
				if arg_35_1.var_.characterEffect10024ui_story and not isNil(arg_35_1.actors_["10024ui_story"]) then
					arg_35_1.var_.characterEffect10024ui_story.fillFlat = true
					arg_35_1.var_.characterEffect10024ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_35_1.time_ - 0) / var_38_0)
				end
			end

			if arg_35_1.time_ >= 0 + var_38_0 and arg_35_1.time_ < 0 + var_38_0 + arg_38_0 and not isNil(arg_35_1.actors_["10024ui_story"]) and arg_35_1.var_.characterEffect10024ui_story then
				arg_35_1.var_.characterEffect10024ui_story.fillFlat = true
				arg_35_1.var_.characterEffect10024ui_story.fillRatio = 0.5
			end

			local var_38_1 = 0
			local var_38_2 = 0.65

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= var_38_1 + arg_38_0 then
				arg_35_1.talkMaxDuration = 0
				arg_35_1.dialogCg_.alpha = 1

				arg_35_1.dialog_:SetActive(true)
				SetActive(arg_35_1.leftNameGo_, true)

				arg_35_1.leftNameTxt_.text = arg_35_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_35_1.leftNameTxt_.transform)

				arg_35_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_35_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_35_1:RecordName(arg_35_1.leftNameTxt_.text)
				SetActive(arg_35_1.iconTrs_.gameObject, true)
				arg_35_1.iconController_:SetSelectedState("hero")

				arg_35_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1184")

				arg_35_1.callingController_:SetSelectedState("normal")

				arg_35_1.keyicon_.color = Color.New(1, 1, 1)
				arg_35_1.icon_.color = Color.New(1, 1, 1)

				local var_38_3 = arg_35_1:GetWordFromCfg(116301009)
				local var_38_4 = arg_35_1:FormatText(var_38_3.content)

				arg_35_1.text_.text = var_38_4

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_6 = 26 <= 0 and var_38_2 or var_38_2 * (utf8.len(var_38_4) / 26)

				if (26 <= 0 and var_38_2 or var_38_2 * (utf8.len(var_38_4) / 26)) > 0 and var_38_2 < var_38_6 then
					arg_35_1.talkMaxDuration = var_38_6

					if var_38_6 + var_38_1 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_6 + var_38_1
					end
				end

				arg_35_1.text_.text = var_38_4
				arg_35_1.typewritter.percent = 0

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116301", "116301009", "story_v_out_116301.awb") ~= 0 then
					local var_38_7 = manager.audio:GetVoiceLength("story_v_out_116301", "116301009", "story_v_out_116301.awb") / 1000

					if var_38_7 + var_38_1 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_7 + var_38_1
					end

					if var_38_3.prefab_name ~= "" and arg_35_1.actors_[var_38_3.prefab_name] ~= nil then
						local var_38_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_35_1.actors_[var_38_3.prefab_name].transform, "story_v_out_116301", "116301009", "story_v_out_116301.awb")

						arg_35_1:RecordAudio("116301009", var_38_8)
						arg_35_1:RecordAudio("116301009", var_38_8)
					else
						arg_35_1:AudioAction("play", "voice", "story_v_out_116301", "116301009", "story_v_out_116301.awb")
					end

					arg_35_1:RecordHistoryTalkVoice("story_v_out_116301", "116301009", "story_v_out_116301.awb")
				end

				arg_35_1:RecordContent(arg_35_1.text_.text)
			end

			local var_38_9 = math.max(var_38_2, arg_35_1.talkMaxDuration)

			if var_38_1 <= arg_35_1.time_ and arg_35_1.time_ < var_38_1 + var_38_9 then
				arg_35_1.typewritter.percent = (arg_35_1.time_ - var_38_1) / var_38_9

				arg_35_1.typewritter:SetDirty()
			end

			if arg_35_1.time_ >= var_38_1 + var_38_9 and arg_35_1.time_ < var_38_1 + var_38_9 + arg_38_0 then
				arg_35_1.typewritter.percent = 1

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(true)
			end
		end

		arg_35_1.nodeConfigList_ = {}

		arg_35_1:InitPlayNodeList()
	end,
	Play116301010 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 116301010
		arg_39_1.duration_ = 5.87

		local var_39_0 = {
			zh = 5.866,
			ja = 5.7
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
				arg_39_0:Play116301011(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			local var_42_0 = 0.75

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0
				arg_39_1.dialogCg_.alpha = 1

				arg_39_1.dialog_:SetActive(true)
				SetActive(arg_39_1.leftNameGo_, true)

				arg_39_1.leftNameTxt_.text = arg_39_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_39_1.leftNameTxt_.transform)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1.leftNameTxt_.text)
				SetActive(arg_39_1.iconTrs_.gameObject, true)
				arg_39_1.iconController_:SetSelectedState("hero")

				arg_39_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1184")

				arg_39_1.callingController_:SetSelectedState("normal")

				arg_39_1.keyicon_.color = Color.New(1, 1, 1)
				arg_39_1.icon_.color = Color.New(1, 1, 1)

				local var_42_1 = arg_39_1:GetWordFromCfg(116301010)
				local var_42_2 = arg_39_1:FormatText(var_42_1.content)

				arg_39_1.text_.text = var_42_2

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_4 = 30 <= 0 and var_42_0 or var_42_0 * (utf8.len(var_42_2) / 30)

				if (30 <= 0 and var_42_0 or var_42_0 * (utf8.len(var_42_2) / 30)) > 0 and var_42_0 < var_42_4 then
					arg_39_1.talkMaxDuration = var_42_4

					if var_42_4 + 0 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_4 + 0
					end
				end

				arg_39_1.text_.text = var_42_2
				arg_39_1.typewritter.percent = 0

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116301", "116301010", "story_v_out_116301.awb") ~= 0 then
					local var_42_5 = manager.audio:GetVoiceLength("story_v_out_116301", "116301010", "story_v_out_116301.awb") / 1000

					if var_42_5 + 0 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_5 + 0
					end

					if var_42_1.prefab_name ~= "" and arg_39_1.actors_[var_42_1.prefab_name] ~= nil then
						local var_42_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_39_1.actors_[var_42_1.prefab_name].transform, "story_v_out_116301", "116301010", "story_v_out_116301.awb")

						arg_39_1:RecordAudio("116301010", var_42_6)
						arg_39_1:RecordAudio("116301010", var_42_6)
					else
						arg_39_1:AudioAction("play", "voice", "story_v_out_116301", "116301010", "story_v_out_116301.awb")
					end

					arg_39_1:RecordHistoryTalkVoice("story_v_out_116301", "116301010", "story_v_out_116301.awb")
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
	Play116301011 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 116301011
		arg_43_1.duration_ = 13.1

		local var_43_0 = {
			zh = 7.333,
			ja = 13.1
		}
		local var_43_1 = manager.audio:GetLocalizationFlag()

		if var_43_0[var_43_1] ~= nil then
			arg_43_1.duration_ = var_43_0[var_43_1]
		end

		SetActive(arg_43_1.tipsGo_, false)

		function arg_43_1.onSingleLineFinish_()
			arg_43_1.onSingleLineUpdate_ = nil
			arg_43_1.onSingleLineFinish_ = nil
			arg_43_1.state_ = "waiting"
		end

		function arg_43_1.playNext_(arg_45_0)
			if arg_45_0 == 1 then
				arg_43_0:Play116301012(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 and not isNil(arg_43_1.actors_["10024ui_story"]) and arg_43_1.var_.characterEffect10024ui_story == nil then
				arg_43_1.var_.characterEffect10024ui_story = arg_43_1.actors_["10024ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_46_0 = 0.2

			if 0 <= arg_43_1.time_ and arg_43_1.time_ < 0 + var_46_0 and not isNil(arg_43_1.actors_["10024ui_story"]) then
				if arg_43_1.var_.characterEffect10024ui_story and not isNil(arg_43_1.actors_["10024ui_story"]) then
					arg_43_1.var_.characterEffect10024ui_story.fillFlat = false
				end
			end

			if arg_43_1.time_ >= 0 + var_46_0 and arg_43_1.time_ < 0 + var_46_0 + arg_46_0 and not isNil(arg_43_1.actors_["10024ui_story"]) and arg_43_1.var_.characterEffect10024ui_story then
				arg_43_1.var_.characterEffect10024ui_story.fillFlat = false
			end

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				arg_43_1:PlayTimeline("10024ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				arg_43_1:PlayTimeline("10024ui_story", "StoryTimeline/CharAction/story10024/story10024action/10024action6_1")
			end

			local var_46_2 = 0
			local var_46_3 = 0.8

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= var_46_2 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0
				arg_43_1.dialogCg_.alpha = 1

				arg_43_1.dialog_:SetActive(true)
				SetActive(arg_43_1.leftNameGo_, true)

				arg_43_1.leftNameTxt_.text = arg_43_1:FormatText(StoryNameCfg[332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_43_1.leftNameTxt_.transform)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1.leftNameTxt_.text)
				SetActive(arg_43_1.iconTrs_.gameObject, false)
				arg_43_1.callingController_:SetSelectedState("normal")

				local var_46_4 = arg_43_1:GetWordFromCfg(116301011)
				local var_46_5 = arg_43_1:FormatText(var_46_4.content)

				arg_43_1.text_.text = var_46_5

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_7 = 32 <= 0 and var_46_3 or var_46_3 * (utf8.len(var_46_5) / 32)

				if (32 <= 0 and var_46_3 or var_46_3 * (utf8.len(var_46_5) / 32)) > 0 and var_46_3 < var_46_7 then
					arg_43_1.talkMaxDuration = var_46_7

					if var_46_7 + var_46_2 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_7 + var_46_2
					end
				end

				arg_43_1.text_.text = var_46_5
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116301", "116301011", "story_v_out_116301.awb") ~= 0 then
					local var_46_8 = manager.audio:GetVoiceLength("story_v_out_116301", "116301011", "story_v_out_116301.awb") / 1000

					if var_46_8 + var_46_2 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_8 + var_46_2
					end

					if var_46_4.prefab_name ~= "" and arg_43_1.actors_[var_46_4.prefab_name] ~= nil then
						local var_46_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_43_1.actors_[var_46_4.prefab_name].transform, "story_v_out_116301", "116301011", "story_v_out_116301.awb")

						arg_43_1:RecordAudio("116301011", var_46_9)
						arg_43_1:RecordAudio("116301011", var_46_9)
					else
						arg_43_1:AudioAction("play", "voice", "story_v_out_116301", "116301011", "story_v_out_116301.awb")
					end

					arg_43_1:RecordHistoryTalkVoice("story_v_out_116301", "116301011", "story_v_out_116301.awb")
				end

				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_10 = math.max(var_46_3, arg_43_1.talkMaxDuration)

			if var_46_2 <= arg_43_1.time_ and arg_43_1.time_ < var_46_2 + var_46_10 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - var_46_2) / var_46_10

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= var_46_2 + var_46_10 and arg_43_1.time_ < var_46_2 + var_46_10 + arg_46_0 then
				arg_43_1.typewritter.percent = 1

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(true)
			end
		end

		arg_43_1.nodeConfigList_ = {}

		arg_43_1:InitPlayNodeList()
	end,
	Play116301012 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 116301012
		arg_47_1.duration_ = 5

		SetActive(arg_47_1.tipsGo_, false)

		function arg_47_1.onSingleLineFinish_()
			arg_47_1.onSingleLineUpdate_ = nil
			arg_47_1.onSingleLineFinish_ = nil
			arg_47_1.state_ = "waiting"
		end

		function arg_47_1.playNext_(arg_49_0)
			if arg_49_0 == 1 then
				arg_47_0:Play116301013(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 then
				arg_47_1.var_.moveOldPos10024ui_story = arg_47_1.actors_["10024ui_story"].transform.localPosition
			end

			local var_50_0 = 0.001

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_0 then
				arg_47_1.actors_["10024ui_story"].transform.localPosition = Vector3.Lerp(arg_47_1.var_.moveOldPos10024ui_story, Vector3.New(0, 100, 0), (arg_47_1.time_ - 0) / var_50_0)
				arg_47_1.actors_["10024ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_47_1.actors_["10024ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_47_1.actors_["10024ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_47_1.actors_["10024ui_story"].transform.position).z)
				arg_47_1.actors_["10024ui_story"].transform.localEulerAngles.z = 0
				arg_47_1.actors_["10024ui_story"].transform.localEulerAngles.x = 0
				arg_47_1.actors_["10024ui_story"].transform.localEulerAngles = arg_47_1.actors_["10024ui_story"].transform.localEulerAngles
			end

			if arg_47_1.time_ >= 0 + var_50_0 and arg_47_1.time_ < 0 + var_50_0 + arg_50_0 then
				arg_47_1.actors_["10024ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_47_1.actors_["10024ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_47_1.actors_["10024ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_47_1.actors_["10024ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_47_1.actors_["10024ui_story"].transform.position).z)
				arg_47_1.actors_["10024ui_story"].transform.localEulerAngles.z = 0
				arg_47_1.actors_["10024ui_story"].transform.localEulerAngles.x = 0
				arg_47_1.actors_["10024ui_story"].transform.localEulerAngles = arg_47_1.actors_["10024ui_story"].transform.localEulerAngles
			end

			local var_50_1 = 0
			local var_50_2 = 0.6

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

				local var_50_3 = arg_47_1:FormatText(arg_47_1:GetWordFromCfg(116301012).content)

				arg_47_1.text_.text = var_50_3

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_5 = 24 <= 0 and var_50_2 or var_50_2 * (utf8.len(var_50_3) / 24)

				if (24 <= 0 and var_50_2 or var_50_2 * (utf8.len(var_50_3) / 24)) > 0 and var_50_2 < var_50_5 then
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

		arg_47_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10024ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_47_1:InitPlayNodeList()
	end,
	Play116301013 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 116301013
		arg_51_1.duration_ = 9.33

		local var_51_0 = {
			zh = 9.333,
			ja = 6.8
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
				arg_51_0:Play116301014(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 and not isNil(arg_51_1.actors_["10024ui_story"]) and arg_51_1.var_.characterEffect10024ui_story == nil then
				arg_51_1.var_.characterEffect10024ui_story = arg_51_1.actors_["10024ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_54_0 = 0.2

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_0 and not isNil(arg_51_1.actors_["10024ui_story"]) then
				if arg_51_1.var_.characterEffect10024ui_story and not isNil(arg_51_1.actors_["10024ui_story"]) then
					arg_51_1.var_.characterEffect10024ui_story.fillFlat = false
				end
			end

			if arg_51_1.time_ >= 0 + var_54_0 and arg_51_1.time_ < 0 + var_54_0 + arg_54_0 and not isNil(arg_51_1.actors_["10024ui_story"]) and arg_51_1.var_.characterEffect10024ui_story then
				arg_51_1.var_.characterEffect10024ui_story.fillFlat = false
			end

			local var_54_2 = arg_51_1.actors_["10024ui_story"].transform

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 then
				arg_51_1.var_.moveOldPos10024ui_story = var_54_2.localPosition
			end

			local var_54_3 = 0.001

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_3 then
				var_54_2.localPosition = Vector3.Lerp(arg_51_1.var_.moveOldPos10024ui_story, Vector3.New(0, -1, -6), (arg_51_1.time_ - 0) / var_54_3)
				var_54_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_54_2.position).x, (manager.ui.mainCamera.transform.position - var_54_2.position).y, (manager.ui.mainCamera.transform.position - var_54_2.position).z)
				var_54_2.localEulerAngles.z = 0
				var_54_2.localEulerAngles.x = 0
				var_54_2.localEulerAngles = var_54_2.localEulerAngles
			end

			if arg_51_1.time_ >= 0 + var_54_3 and arg_51_1.time_ < 0 + var_54_3 + arg_54_0 then
				var_54_2.localPosition = Vector3.New(0, -1, -6)
				var_54_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_54_2.position).x, (manager.ui.mainCamera.transform.position - var_54_2.position).y, (manager.ui.mainCamera.transform.position - var_54_2.position).z)
				var_54_2.localEulerAngles.z = 0
				var_54_2.localEulerAngles.x = 0
				var_54_2.localEulerAngles = var_54_2.localEulerAngles
			end

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 then
				arg_51_1:PlayTimeline("10024ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 then
				arg_51_1:PlayTimeline("10024ui_story", "StoryTimeline/CharAction/story10024/story10024action/10024action1_1")
			end

			local var_54_4 = 0
			local var_54_5 = 1

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= var_54_4 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, true)

				arg_51_1.leftNameTxt_.text = arg_51_1:FormatText(StoryNameCfg[332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_51_1.leftNameTxt_.transform)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1.leftNameTxt_.text)
				SetActive(arg_51_1.iconTrs_.gameObject, false)
				arg_51_1.callingController_:SetSelectedState("normal")

				local var_54_6 = arg_51_1:GetWordFromCfg(116301013)
				local var_54_7 = arg_51_1:FormatText(var_54_6.content)

				arg_51_1.text_.text = var_54_7

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_9 = 40 <= 0 and var_54_5 or var_54_5 * (utf8.len(var_54_7) / 40)

				if (40 <= 0 and var_54_5 or var_54_5 * (utf8.len(var_54_7) / 40)) > 0 and var_54_5 < var_54_9 then
					arg_51_1.talkMaxDuration = var_54_9

					if var_54_9 + var_54_4 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_9 + var_54_4
					end
				end

				arg_51_1.text_.text = var_54_7
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116301", "116301013", "story_v_out_116301.awb") ~= 0 then
					local var_54_10 = manager.audio:GetVoiceLength("story_v_out_116301", "116301013", "story_v_out_116301.awb") / 1000

					if var_54_10 + var_54_4 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_10 + var_54_4
					end

					if var_54_6.prefab_name ~= "" and arg_51_1.actors_[var_54_6.prefab_name] ~= nil then
						local var_54_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_51_1.actors_[var_54_6.prefab_name].transform, "story_v_out_116301", "116301013", "story_v_out_116301.awb")

						arg_51_1:RecordAudio("116301013", var_54_11)
						arg_51_1:RecordAudio("116301013", var_54_11)
					else
						arg_51_1:AudioAction("play", "voice", "story_v_out_116301", "116301013", "story_v_out_116301.awb")
					end

					arg_51_1:RecordHistoryTalkVoice("story_v_out_116301", "116301013", "story_v_out_116301.awb")
				end

				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_12 = math.max(var_54_5, arg_51_1.talkMaxDuration)

			if var_54_4 <= arg_51_1.time_ and arg_51_1.time_ < var_54_4 + var_54_12 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - var_54_4) / var_54_12

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= var_54_4 + var_54_12 and arg_51_1.time_ < var_54_4 + var_54_12 + arg_54_0 then
				arg_51_1.typewritter.percent = 1

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(true)
			end
		end

		arg_51_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10024ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_51_1:InitPlayNodeList()
	end,
	Play116301014 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 116301014
		arg_55_1.duration_ = 6.7

		local var_55_0 = {
			zh = 6.7,
			ja = 6.066
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
				arg_55_0:Play116301015(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 then
				arg_55_1:PlayTimeline("10024ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_58_0 = 0
			local var_58_1 = 0.675

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= var_58_0 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, true)

				arg_55_1.leftNameTxt_.text = arg_55_1:FormatText(StoryNameCfg[332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_55_1.leftNameTxt_.transform)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1.leftNameTxt_.text)
				SetActive(arg_55_1.iconTrs_.gameObject, false)
				arg_55_1.callingController_:SetSelectedState("normal")

				local var_58_2 = arg_55_1:GetWordFromCfg(116301014)
				local var_58_3 = arg_55_1:FormatText(var_58_2.content)

				arg_55_1.text_.text = var_58_3

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_5 = 27 <= 0 and var_58_1 or var_58_1 * (utf8.len(var_58_3) / 27)

				if (27 <= 0 and var_58_1 or var_58_1 * (utf8.len(var_58_3) / 27)) > 0 and var_58_1 < var_58_5 then
					arg_55_1.talkMaxDuration = var_58_5

					if var_58_5 + var_58_0 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_5 + var_58_0
					end
				end

				arg_55_1.text_.text = var_58_3
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116301", "116301014", "story_v_out_116301.awb") ~= 0 then
					local var_58_6 = manager.audio:GetVoiceLength("story_v_out_116301", "116301014", "story_v_out_116301.awb") / 1000

					if var_58_6 + var_58_0 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_6 + var_58_0
					end

					if var_58_2.prefab_name ~= "" and arg_55_1.actors_[var_58_2.prefab_name] ~= nil then
						local var_58_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_55_1.actors_[var_58_2.prefab_name].transform, "story_v_out_116301", "116301014", "story_v_out_116301.awb")

						arg_55_1:RecordAudio("116301014", var_58_7)
						arg_55_1:RecordAudio("116301014", var_58_7)
					else
						arg_55_1:AudioAction("play", "voice", "story_v_out_116301", "116301014", "story_v_out_116301.awb")
					end

					arg_55_1:RecordHistoryTalkVoice("story_v_out_116301", "116301014", "story_v_out_116301.awb")
				end

				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_8 = math.max(var_58_1, arg_55_1.talkMaxDuration)

			if var_58_0 <= arg_55_1.time_ and arg_55_1.time_ < var_58_0 + var_58_8 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - var_58_0) / var_58_8

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= var_58_0 + var_58_8 and arg_55_1.time_ < var_58_0 + var_58_8 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end

		arg_55_1.nodeConfigList_ = {}

		arg_55_1:InitPlayNodeList()
	end,
	Play116301015 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 116301015
		arg_59_1.duration_ = 13.37

		local var_59_0 = {
			zh = 6,
			ja = 13.366
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
				arg_59_0:Play116301016(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 then
				arg_59_1.var_.moveOldPos10024ui_story = arg_59_1.actors_["10024ui_story"].transform.localPosition
			end

			local var_62_0 = 0.001

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_0 then
				arg_59_1.actors_["10024ui_story"].transform.localPosition = Vector3.Lerp(arg_59_1.var_.moveOldPos10024ui_story, Vector3.New(-0.7, -1, -6), (arg_59_1.time_ - 0) / var_62_0)
				arg_59_1.actors_["10024ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_59_1.actors_["10024ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_59_1.actors_["10024ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_59_1.actors_["10024ui_story"].transform.position).z)
				arg_59_1.actors_["10024ui_story"].transform.localEulerAngles.z = 0
				arg_59_1.actors_["10024ui_story"].transform.localEulerAngles.x = 0
				arg_59_1.actors_["10024ui_story"].transform.localEulerAngles = arg_59_1.actors_["10024ui_story"].transform.localEulerAngles
			end

			if arg_59_1.time_ >= 0 + var_62_0 and arg_59_1.time_ < 0 + var_62_0 + arg_62_0 then
				arg_59_1.actors_["10024ui_story"].transform.localPosition = Vector3.New(-0.7, -1, -6)
				arg_59_1.actors_["10024ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_59_1.actors_["10024ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_59_1.actors_["10024ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_59_1.actors_["10024ui_story"].transform.position).z)
				arg_59_1.actors_["10024ui_story"].transform.localEulerAngles.z = 0
				arg_59_1.actors_["10024ui_story"].transform.localEulerAngles.x = 0
				arg_59_1.actors_["10024ui_story"].transform.localEulerAngles = arg_59_1.actors_["10024ui_story"].transform.localEulerAngles
			end

			local var_62_1 = "10025ui_story"

			if arg_59_1.actors_["10025ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10025ui_story"))) then
				local var_62_2 = Object.Instantiate(Asset.Load("Char/" .. "10025ui_story"), arg_59_1.stage_.transform)

				var_62_2.name = var_62_1
				var_62_2.transform.localPosition = Vector3.New(0, 100, 0)
				arg_59_1.actors_[var_62_1] = var_62_2

				local var_62_3 = var_62_2:GetComponentInChildren(typeof(CharacterEffect))

				var_62_3.enabled = true

				local var_62_4 = GameObjectTools.GetOrAddComponent(var_62_2, typeof(DynamicBoneHelper))

				if var_62_4 then
					var_62_4:EnableDynamicBone(false)
				end

				arg_59_1:ShowWeapon(var_62_3.transform, false)

				arg_59_1.var_[var_62_1 .. "Animator"] = var_62_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_59_1.var_[var_62_1 .. "Animator"].applyRootMotion = true
				arg_59_1.var_[var_62_1 .. "LipSync"] = var_62_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_62_5 = arg_59_1.actors_["10025ui_story"].transform

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 then
				arg_59_1.var_.moveOldPos10025ui_story = var_62_5.localPosition
			end

			local var_62_6 = 0.001

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_6 then
				var_62_5.localPosition = Vector3.Lerp(arg_59_1.var_.moveOldPos10025ui_story, Vector3.New(0.7, -1.1, -5.9), (arg_59_1.time_ - 0) / var_62_6)
				var_62_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_62_5.position).x, (manager.ui.mainCamera.transform.position - var_62_5.position).y, (manager.ui.mainCamera.transform.position - var_62_5.position).z)
				var_62_5.localEulerAngles.z = 0
				var_62_5.localEulerAngles.x = 0
				var_62_5.localEulerAngles = var_62_5.localEulerAngles
			end

			if arg_59_1.time_ >= 0 + var_62_6 and arg_59_1.time_ < 0 + var_62_6 + arg_62_0 then
				var_62_5.localPosition = Vector3.New(0.7, -1.1, -5.9)
				var_62_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_62_5.position).x, (manager.ui.mainCamera.transform.position - var_62_5.position).y, (manager.ui.mainCamera.transform.position - var_62_5.position).z)
				var_62_5.localEulerAngles.z = 0
				var_62_5.localEulerAngles.x = 0
				var_62_5.localEulerAngles = var_62_5.localEulerAngles
			end

			local var_62_7 = arg_59_1.actors_["10024ui_story"]

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 and not isNil(var_62_7) and arg_59_1.var_.characterEffect10024ui_story == nil then
				arg_59_1.var_.characterEffect10024ui_story = var_62_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_62_8 = 0.2

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_8 and not isNil(var_62_7) then
				if arg_59_1.var_.characterEffect10024ui_story and not isNil(var_62_7) then
					arg_59_1.var_.characterEffect10024ui_story.fillFlat = true
					arg_59_1.var_.characterEffect10024ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_59_1.time_ - 0) / var_62_8)
				end
			end

			if arg_59_1.time_ >= 0 + var_62_8 and arg_59_1.time_ < 0 + var_62_8 + arg_62_0 and not isNil(var_62_7) and arg_59_1.var_.characterEffect10024ui_story then
				arg_59_1.var_.characterEffect10024ui_story.fillFlat = true
				arg_59_1.var_.characterEffect10024ui_story.fillRatio = 0.5
			end

			local var_62_9 = arg_59_1.actors_["10025ui_story"]

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 and not isNil(var_62_9) and arg_59_1.var_.characterEffect10025ui_story == nil then
				arg_59_1.var_.characterEffect10025ui_story = var_62_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_62_10 = 0.2

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_10 and not isNil(var_62_9) then
				if arg_59_1.var_.characterEffect10025ui_story and not isNil(var_62_9) then
					arg_59_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_59_1.time_ >= 0 + var_62_10 and arg_59_1.time_ < 0 + var_62_10 + arg_62_0 and not isNil(var_62_9) and arg_59_1.var_.characterEffect10025ui_story then
				arg_59_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 then
				arg_59_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action7_1")
			end

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 then
				arg_59_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_62_12 = 0
			local var_62_13 = 0.575

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= var_62_12 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, true)

				arg_59_1.leftNameTxt_.text = arg_59_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_59_1.leftNameTxt_.transform)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1.leftNameTxt_.text)
				SetActive(arg_59_1.iconTrs_.gameObject, false)
				arg_59_1.callingController_:SetSelectedState("normal")

				local var_62_14 = arg_59_1:GetWordFromCfg(116301015)
				local var_62_15 = arg_59_1:FormatText(var_62_14.content)

				arg_59_1.text_.text = var_62_15

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_17 = 23 <= 0 and var_62_13 or var_62_13 * (utf8.len(var_62_15) / 23)

				if (23 <= 0 and var_62_13 or var_62_13 * (utf8.len(var_62_15) / 23)) > 0 and var_62_13 < var_62_17 then
					arg_59_1.talkMaxDuration = var_62_17

					if var_62_17 + var_62_12 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_17 + var_62_12
					end
				end

				arg_59_1.text_.text = var_62_15
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116301", "116301015", "story_v_out_116301.awb") ~= 0 then
					local var_62_18 = manager.audio:GetVoiceLength("story_v_out_116301", "116301015", "story_v_out_116301.awb") / 1000

					if var_62_18 + var_62_12 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_18 + var_62_12
					end

					if var_62_14.prefab_name ~= "" and arg_59_1.actors_[var_62_14.prefab_name] ~= nil then
						local var_62_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_59_1.actors_[var_62_14.prefab_name].transform, "story_v_out_116301", "116301015", "story_v_out_116301.awb")

						arg_59_1:RecordAudio("116301015", var_62_19)
						arg_59_1:RecordAudio("116301015", var_62_19)
					else
						arg_59_1:AudioAction("play", "voice", "story_v_out_116301", "116301015", "story_v_out_116301.awb")
					end

					arg_59_1:RecordHistoryTalkVoice("story_v_out_116301", "116301015", "story_v_out_116301.awb")
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
				actorName = "10024ui_story",
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

		arg_59_1:InitPlayNodeList()
	end,
	Play116301016 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 116301016
		arg_63_1.duration_ = 5

		SetActive(arg_63_1.tipsGo_, false)

		function arg_63_1.onSingleLineFinish_()
			arg_63_1.onSingleLineUpdate_ = nil
			arg_63_1.onSingleLineFinish_ = nil
			arg_63_1.state_ = "waiting"
		end

		function arg_63_1.playNext_(arg_65_0)
			if arg_65_0 == 1 then
				arg_63_0:Play116301017(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 and not isNil(arg_63_1.actors_["10025ui_story"]) and arg_63_1.var_.characterEffect10025ui_story == nil then
				arg_63_1.var_.characterEffect10025ui_story = arg_63_1.actors_["10025ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_66_0 = 0.2

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_0 and not isNil(arg_63_1.actors_["10025ui_story"]) then
				if arg_63_1.var_.characterEffect10025ui_story and not isNil(arg_63_1.actors_["10025ui_story"]) then
					arg_63_1.var_.characterEffect10025ui_story.fillFlat = true
					arg_63_1.var_.characterEffect10025ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_63_1.time_ - 0) / var_66_0)
				end
			end

			if arg_63_1.time_ >= 0 + var_66_0 and arg_63_1.time_ < 0 + var_66_0 + arg_66_0 and not isNil(arg_63_1.actors_["10025ui_story"]) and arg_63_1.var_.characterEffect10025ui_story then
				arg_63_1.var_.characterEffect10025ui_story.fillFlat = true
				arg_63_1.var_.characterEffect10025ui_story.fillRatio = 0.5
			end

			local var_66_1 = 0
			local var_66_2 = 0.75

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

				local var_66_3 = arg_63_1:FormatText(arg_63_1:GetWordFromCfg(116301016).content)

				arg_63_1.text_.text = var_66_3

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_5 = 30 <= 0 and var_66_2 or var_66_2 * (utf8.len(var_66_3) / 30)

				if (30 <= 0 and var_66_2 or var_66_2 * (utf8.len(var_66_3) / 30)) > 0 and var_66_2 < var_66_5 then
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
	Play116301017 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 116301017
		arg_67_1.duration_ = 12.27

		local var_67_0 = {
			zh = 7.366,
			ja = 12.266
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
				arg_67_0:Play116301018(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 and not isNil(arg_67_1.actors_["10024ui_story"]) and arg_67_1.var_.characterEffect10024ui_story == nil then
				arg_67_1.var_.characterEffect10024ui_story = arg_67_1.actors_["10024ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_70_0 = 0.2

			if 0 <= arg_67_1.time_ and arg_67_1.time_ < 0 + var_70_0 and not isNil(arg_67_1.actors_["10024ui_story"]) then
				if arg_67_1.var_.characterEffect10024ui_story and not isNil(arg_67_1.actors_["10024ui_story"]) then
					arg_67_1.var_.characterEffect10024ui_story.fillFlat = false
				end
			end

			if arg_67_1.time_ >= 0 + var_70_0 and arg_67_1.time_ < 0 + var_70_0 + arg_70_0 and not isNil(arg_67_1.actors_["10024ui_story"]) and arg_67_1.var_.characterEffect10024ui_story then
				arg_67_1.var_.characterEffect10024ui_story.fillFlat = false
			end

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 then
				arg_67_1:PlayTimeline("10024ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_70_2 = 0
			local var_70_3 = 0.675

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= var_70_2 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, true)

				arg_67_1.leftNameTxt_.text = arg_67_1:FormatText(StoryNameCfg[332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_67_1.leftNameTxt_.transform)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1.leftNameTxt_.text)
				SetActive(arg_67_1.iconTrs_.gameObject, false)
				arg_67_1.callingController_:SetSelectedState("normal")

				local var_70_4 = arg_67_1:GetWordFromCfg(116301017)
				local var_70_5 = arg_67_1:FormatText(var_70_4.content)

				arg_67_1.text_.text = var_70_5

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_7 = 27 <= 0 and var_70_3 or var_70_3 * (utf8.len(var_70_5) / 27)

				if (27 <= 0 and var_70_3 or var_70_3 * (utf8.len(var_70_5) / 27)) > 0 and var_70_3 < var_70_7 then
					arg_67_1.talkMaxDuration = var_70_7

					if var_70_7 + var_70_2 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_7 + var_70_2
					end
				end

				arg_67_1.text_.text = var_70_5
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116301", "116301017", "story_v_out_116301.awb") ~= 0 then
					local var_70_8 = manager.audio:GetVoiceLength("story_v_out_116301", "116301017", "story_v_out_116301.awb") / 1000

					if var_70_8 + var_70_2 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_8 + var_70_2
					end

					if var_70_4.prefab_name ~= "" and arg_67_1.actors_[var_70_4.prefab_name] ~= nil then
						local var_70_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_67_1.actors_[var_70_4.prefab_name].transform, "story_v_out_116301", "116301017", "story_v_out_116301.awb")

						arg_67_1:RecordAudio("116301017", var_70_9)
						arg_67_1:RecordAudio("116301017", var_70_9)
					else
						arg_67_1:AudioAction("play", "voice", "story_v_out_116301", "116301017", "story_v_out_116301.awb")
					end

					arg_67_1:RecordHistoryTalkVoice("story_v_out_116301", "116301017", "story_v_out_116301.awb")
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
	Play116301018 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 116301018
		arg_71_1.duration_ = 12.87

		local var_71_0 = {
			zh = 11.966,
			ja = 12.866
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
				arg_71_0:Play116301019(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1:PlayTimeline("10024ui_story", "StoryTimeline/CharAction/story10024/story10024action/10024action6_1")
			end

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1:PlayTimeline("10024ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_74_0 = 0
			local var_74_1 = 1.225

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= var_74_0 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, true)

				arg_71_1.leftNameTxt_.text = arg_71_1:FormatText(StoryNameCfg[332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_71_1.leftNameTxt_.transform)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1.leftNameTxt_.text)
				SetActive(arg_71_1.iconTrs_.gameObject, false)
				arg_71_1.callingController_:SetSelectedState("normal")

				local var_74_2 = arg_71_1:GetWordFromCfg(116301018)
				local var_74_3 = arg_71_1:FormatText(var_74_2.content)

				arg_71_1.text_.text = var_74_3

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_5 = 49 <= 0 and var_74_1 or var_74_1 * (utf8.len(var_74_3) / 49)

				if (49 <= 0 and var_74_1 or var_74_1 * (utf8.len(var_74_3) / 49)) > 0 and var_74_1 < var_74_5 then
					arg_71_1.talkMaxDuration = var_74_5

					if var_74_5 + var_74_0 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_5 + var_74_0
					end
				end

				arg_71_1.text_.text = var_74_3
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116301", "116301018", "story_v_out_116301.awb") ~= 0 then
					local var_74_6 = manager.audio:GetVoiceLength("story_v_out_116301", "116301018", "story_v_out_116301.awb") / 1000

					if var_74_6 + var_74_0 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_6 + var_74_0
					end

					if var_74_2.prefab_name ~= "" and arg_71_1.actors_[var_74_2.prefab_name] ~= nil then
						local var_74_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_71_1.actors_[var_74_2.prefab_name].transform, "story_v_out_116301", "116301018", "story_v_out_116301.awb")

						arg_71_1:RecordAudio("116301018", var_74_7)
						arg_71_1:RecordAudio("116301018", var_74_7)
					else
						arg_71_1:AudioAction("play", "voice", "story_v_out_116301", "116301018", "story_v_out_116301.awb")
					end

					arg_71_1:RecordHistoryTalkVoice("story_v_out_116301", "116301018", "story_v_out_116301.awb")
				end

				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_8 = math.max(var_74_1, arg_71_1.talkMaxDuration)

			if var_74_0 <= arg_71_1.time_ and arg_71_1.time_ < var_74_0 + var_74_8 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - var_74_0) / var_74_8

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= var_74_0 + var_74_8 and arg_71_1.time_ < var_74_0 + var_74_8 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {}

		arg_71_1:InitPlayNodeList()
	end,
	Play116301019 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 116301019
		arg_75_1.duration_ = 5

		SetActive(arg_75_1.tipsGo_, false)

		function arg_75_1.onSingleLineFinish_()
			arg_75_1.onSingleLineUpdate_ = nil
			arg_75_1.onSingleLineFinish_ = nil
			arg_75_1.state_ = "waiting"
		end

		function arg_75_1.playNext_(arg_77_0)
			if arg_77_0 == 1 then
				arg_75_0:Play116301020(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 then
				arg_75_1.var_.moveOldPos10024ui_story = arg_75_1.actors_["10024ui_story"].transform.localPosition
			end

			local var_78_0 = 0.001

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_0 then
				arg_75_1.actors_["10024ui_story"].transform.localPosition = Vector3.Lerp(arg_75_1.var_.moveOldPos10024ui_story, Vector3.New(0, 100, 0), (arg_75_1.time_ - 0) / var_78_0)
				arg_75_1.actors_["10024ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_75_1.actors_["10024ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_75_1.actors_["10024ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_75_1.actors_["10024ui_story"].transform.position).z)
				arg_75_1.actors_["10024ui_story"].transform.localEulerAngles.z = 0
				arg_75_1.actors_["10024ui_story"].transform.localEulerAngles.x = 0
				arg_75_1.actors_["10024ui_story"].transform.localEulerAngles = arg_75_1.actors_["10024ui_story"].transform.localEulerAngles
			end

			if arg_75_1.time_ >= 0 + var_78_0 and arg_75_1.time_ < 0 + var_78_0 + arg_78_0 then
				arg_75_1.actors_["10024ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_75_1.actors_["10024ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_75_1.actors_["10024ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_75_1.actors_["10024ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_75_1.actors_["10024ui_story"].transform.position).z)
				arg_75_1.actors_["10024ui_story"].transform.localEulerAngles.z = 0
				arg_75_1.actors_["10024ui_story"].transform.localEulerAngles.x = 0
				arg_75_1.actors_["10024ui_story"].transform.localEulerAngles = arg_75_1.actors_["10024ui_story"].transform.localEulerAngles
			end

			local var_78_1 = arg_75_1.actors_["10025ui_story"].transform

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 then
				arg_75_1.var_.moveOldPos10025ui_story = var_78_1.localPosition
			end

			local var_78_2 = 0.001

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_2 then
				var_78_1.localPosition = Vector3.Lerp(arg_75_1.var_.moveOldPos10025ui_story, Vector3.New(0, 100, 0), (arg_75_1.time_ - 0) / var_78_2)
				var_78_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_78_1.position).x, (manager.ui.mainCamera.transform.position - var_78_1.position).y, (manager.ui.mainCamera.transform.position - var_78_1.position).z)
				var_78_1.localEulerAngles.z = 0
				var_78_1.localEulerAngles.x = 0
				var_78_1.localEulerAngles = var_78_1.localEulerAngles
			end

			if arg_75_1.time_ >= 0 + var_78_2 and arg_75_1.time_ < 0 + var_78_2 + arg_78_0 then
				var_78_1.localPosition = Vector3.New(0, 100, 0)
				var_78_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_78_1.position).x, (manager.ui.mainCamera.transform.position - var_78_1.position).y, (manager.ui.mainCamera.transform.position - var_78_1.position).z)
				var_78_1.localEulerAngles.z = 0
				var_78_1.localEulerAngles.x = 0
				var_78_1.localEulerAngles = var_78_1.localEulerAngles
			end

			local var_78_3 = 0
			local var_78_4 = 1.1

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= var_78_3 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, false)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_75_1.iconTrs_.gameObject, false)
				arg_75_1.callingController_:SetSelectedState("normal")

				local var_78_5 = arg_75_1:FormatText(arg_75_1:GetWordFromCfg(116301019).content)

				arg_75_1.text_.text = var_78_5

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_7 = 44 <= 0 and var_78_4 or var_78_4 * (utf8.len(var_78_5) / 44)

				if (44 <= 0 and var_78_4 or var_78_4 * (utf8.len(var_78_5) / 44)) > 0 and var_78_4 < var_78_7 then
					arg_75_1.talkMaxDuration = var_78_7

					if var_78_7 + var_78_3 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_7 + var_78_3
					end
				end

				arg_75_1.text_.text = var_78_5
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)
				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_8 = math.max(var_78_4, arg_75_1.talkMaxDuration)

			if var_78_3 <= arg_75_1.time_ and arg_75_1.time_ < var_78_3 + var_78_8 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - var_78_3) / var_78_8

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= var_78_3 + var_78_8 and arg_75_1.time_ < var_78_3 + var_78_8 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10024ui_story",
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

		arg_75_1:InitPlayNodeList()
	end,
	Play116301020 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 116301020
		arg_79_1.duration_ = 14.83

		local var_79_0 = {
			zh = 14.833,
			ja = 10.833
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
				arg_79_0:Play116301021(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1.var_.moveOldPos10024ui_story = arg_79_1.actors_["10024ui_story"].transform.localPosition
			end

			local var_82_0 = 0.001

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_0 then
				arg_79_1.actors_["10024ui_story"].transform.localPosition = Vector3.Lerp(arg_79_1.var_.moveOldPos10024ui_story, Vector3.New(-0.7, -1, -6), (arg_79_1.time_ - 0) / var_82_0)
				arg_79_1.actors_["10024ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_79_1.actors_["10024ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_79_1.actors_["10024ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_79_1.actors_["10024ui_story"].transform.position).z)
				arg_79_1.actors_["10024ui_story"].transform.localEulerAngles.z = 0
				arg_79_1.actors_["10024ui_story"].transform.localEulerAngles.x = 0
				arg_79_1.actors_["10024ui_story"].transform.localEulerAngles = arg_79_1.actors_["10024ui_story"].transform.localEulerAngles
			end

			if arg_79_1.time_ >= 0 + var_82_0 and arg_79_1.time_ < 0 + var_82_0 + arg_82_0 then
				arg_79_1.actors_["10024ui_story"].transform.localPosition = Vector3.New(-0.7, -1, -6)
				arg_79_1.actors_["10024ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_79_1.actors_["10024ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_79_1.actors_["10024ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_79_1.actors_["10024ui_story"].transform.position).z)
				arg_79_1.actors_["10024ui_story"].transform.localEulerAngles.z = 0
				arg_79_1.actors_["10024ui_story"].transform.localEulerAngles.x = 0
				arg_79_1.actors_["10024ui_story"].transform.localEulerAngles = arg_79_1.actors_["10024ui_story"].transform.localEulerAngles
			end

			local var_82_1 = arg_79_1.actors_["10024ui_story"]

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 and not isNil(var_82_1) and arg_79_1.var_.characterEffect10024ui_story == nil then
				arg_79_1.var_.characterEffect10024ui_story = var_82_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_82_2 = 0.2

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_2 and not isNil(var_82_1) then
				if arg_79_1.var_.characterEffect10024ui_story and not isNil(var_82_1) then
					arg_79_1.var_.characterEffect10024ui_story.fillFlat = false
				end
			end

			if arg_79_1.time_ >= 0 + var_82_2 and arg_79_1.time_ < 0 + var_82_2 + arg_82_0 and not isNil(var_82_1) and arg_79_1.var_.characterEffect10024ui_story then
				arg_79_1.var_.characterEffect10024ui_story.fillFlat = false
			end

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1:PlayTimeline("10024ui_story", "StoryTimeline/CharAction/story10024/story10024action/10024action1_1")
			end

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1:PlayTimeline("10024ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_82_4 = 0
			local var_82_5 = 1.275

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= var_82_4 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, true)

				arg_79_1.leftNameTxt_.text = arg_79_1:FormatText(StoryNameCfg[332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_79_1.leftNameTxt_.transform)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1.leftNameTxt_.text)
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_6 = arg_79_1:GetWordFromCfg(116301020)
				local var_82_7 = arg_79_1:FormatText(var_82_6.content)

				arg_79_1.text_.text = var_82_7

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_9 = 51 <= 0 and var_82_5 or var_82_5 * (utf8.len(var_82_7) / 51)

				if (51 <= 0 and var_82_5 or var_82_5 * (utf8.len(var_82_7) / 51)) > 0 and var_82_5 < var_82_9 then
					arg_79_1.talkMaxDuration = var_82_9

					if var_82_9 + var_82_4 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_9 + var_82_4
					end
				end

				arg_79_1.text_.text = var_82_7
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116301", "116301020", "story_v_out_116301.awb") ~= 0 then
					local var_82_10 = manager.audio:GetVoiceLength("story_v_out_116301", "116301020", "story_v_out_116301.awb") / 1000

					if var_82_10 + var_82_4 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_10 + var_82_4
					end

					if var_82_6.prefab_name ~= "" and arg_79_1.actors_[var_82_6.prefab_name] ~= nil then
						local var_82_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_79_1.actors_[var_82_6.prefab_name].transform, "story_v_out_116301", "116301020", "story_v_out_116301.awb")

						arg_79_1:RecordAudio("116301020", var_82_11)
						arg_79_1:RecordAudio("116301020", var_82_11)
					else
						arg_79_1:AudioAction("play", "voice", "story_v_out_116301", "116301020", "story_v_out_116301.awb")
					end

					arg_79_1:RecordHistoryTalkVoice("story_v_out_116301", "116301020", "story_v_out_116301.awb")
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
				actorName = "10024ui_story",
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
	Play116301021 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 116301021
		arg_83_1.duration_ = 10.3

		local var_83_0 = {
			zh = 10.3,
			ja = 5.733
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
				arg_83_0:Play116301022(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			if arg_83_1.actors_["1184ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1184ui_story"))) then
				local var_86_0 = Object.Instantiate(Asset.Load("Char/" .. "1184ui_story"), arg_83_1.stage_.transform)

				var_86_0.name = "1184ui_story"
				var_86_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_83_1.actors_["1184ui_story"] = var_86_0

				local var_86_1 = var_86_0:GetComponentInChildren(typeof(CharacterEffect))

				var_86_1.enabled = true

				local var_86_2 = GameObjectTools.GetOrAddComponent(var_86_0, typeof(DynamicBoneHelper))

				if var_86_2 then
					var_86_2:EnableDynamicBone(false)
				end

				arg_83_1:ShowWeapon(var_86_1.transform, false)

				arg_83_1.var_["1184ui_story" .. "Animator"] = var_86_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_83_1.var_["1184ui_story" .. "Animator"].applyRootMotion = true
				arg_83_1.var_["1184ui_story" .. "LipSync"] = var_86_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_86_3 = arg_83_1.actors_["1184ui_story"].transform

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 then
				arg_83_1.var_.moveOldPos1184ui_story = var_86_3.localPosition
			end

			local var_86_4 = 0.001

			if 0 <= arg_83_1.time_ and arg_83_1.time_ < 0 + var_86_4 then
				var_86_3.localPosition = Vector3.Lerp(arg_83_1.var_.moveOldPos1184ui_story, Vector3.New(0.7, -0.97, -6), (arg_83_1.time_ - 0) / var_86_4)
				var_86_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_86_3.position).x, (manager.ui.mainCamera.transform.position - var_86_3.position).y, (manager.ui.mainCamera.transform.position - var_86_3.position).z)
				var_86_3.localEulerAngles.z = 0
				var_86_3.localEulerAngles.x = 0
				var_86_3.localEulerAngles = var_86_3.localEulerAngles
			end

			if arg_83_1.time_ >= 0 + var_86_4 and arg_83_1.time_ < 0 + var_86_4 + arg_86_0 then
				var_86_3.localPosition = Vector3.New(0.7, -0.97, -6)
				var_86_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_86_3.position).x, (manager.ui.mainCamera.transform.position - var_86_3.position).y, (manager.ui.mainCamera.transform.position - var_86_3.position).z)
				var_86_3.localEulerAngles.z = 0
				var_86_3.localEulerAngles.x = 0
				var_86_3.localEulerAngles = var_86_3.localEulerAngles
			end

			local var_86_5 = arg_83_1.actors_["1184ui_story"]

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 and not isNil(var_86_5) and arg_83_1.var_.characterEffect1184ui_story == nil then
				arg_83_1.var_.characterEffect1184ui_story = var_86_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_86_6 = 0.2

			if 0 <= arg_83_1.time_ and arg_83_1.time_ < 0 + var_86_6 and not isNil(var_86_5) then
				if arg_83_1.var_.characterEffect1184ui_story and not isNil(var_86_5) then
					arg_83_1.var_.characterEffect1184ui_story.fillFlat = false
				end
			end

			if arg_83_1.time_ >= 0 + var_86_6 and arg_83_1.time_ < 0 + var_86_6 + arg_86_0 and not isNil(var_86_5) and arg_83_1.var_.characterEffect1184ui_story then
				arg_83_1.var_.characterEffect1184ui_story.fillFlat = false
			end

			local var_86_8 = arg_83_1.actors_["10024ui_story"]

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 and not isNil(var_86_8) and arg_83_1.var_.characterEffect10024ui_story == nil then
				arg_83_1.var_.characterEffect10024ui_story = var_86_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_86_9 = 0.2

			if 0 <= arg_83_1.time_ and arg_83_1.time_ < 0 + var_86_9 and not isNil(var_86_8) then
				if arg_83_1.var_.characterEffect10024ui_story and not isNil(var_86_8) then
					arg_83_1.var_.characterEffect10024ui_story.fillFlat = true
					arg_83_1.var_.characterEffect10024ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_83_1.time_ - 0) / var_86_9)
				end
			end

			if arg_83_1.time_ >= 0 + var_86_9 and arg_83_1.time_ < 0 + var_86_9 + arg_86_0 and not isNil(var_86_8) and arg_83_1.var_.characterEffect10024ui_story then
				arg_83_1.var_.characterEffect10024ui_story.fillFlat = true
				arg_83_1.var_.characterEffect10024ui_story.fillRatio = 0.5
			end

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 then
				arg_83_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action5_1")
			end

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 then
				arg_83_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_86_10 = 0
			local var_86_11 = 1.3

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= var_86_10 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, true)

				arg_83_1.leftNameTxt_.text = arg_83_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_83_1.leftNameTxt_.transform)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1.leftNameTxt_.text)
				SetActive(arg_83_1.iconTrs_.gameObject, false)
				arg_83_1.callingController_:SetSelectedState("normal")

				local var_86_12 = arg_83_1:GetWordFromCfg(116301021)
				local var_86_13 = arg_83_1:FormatText(var_86_12.content)

				arg_83_1.text_.text = var_86_13

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_15 = 52 <= 0 and var_86_11 or var_86_11 * (utf8.len(var_86_13) / 52)

				if (52 <= 0 and var_86_11 or var_86_11 * (utf8.len(var_86_13) / 52)) > 0 and var_86_11 < var_86_15 then
					arg_83_1.talkMaxDuration = var_86_15

					if var_86_15 + var_86_10 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_15 + var_86_10
					end
				end

				arg_83_1.text_.text = var_86_13
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116301", "116301021", "story_v_out_116301.awb") ~= 0 then
					local var_86_16 = manager.audio:GetVoiceLength("story_v_out_116301", "116301021", "story_v_out_116301.awb") / 1000

					if var_86_16 + var_86_10 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_16 + var_86_10
					end

					if var_86_12.prefab_name ~= "" and arg_83_1.actors_[var_86_12.prefab_name] ~= nil then
						local var_86_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_83_1.actors_[var_86_12.prefab_name].transform, "story_v_out_116301", "116301021", "story_v_out_116301.awb")

						arg_83_1:RecordAudio("116301021", var_86_17)
						arg_83_1:RecordAudio("116301021", var_86_17)
					else
						arg_83_1:AudioAction("play", "voice", "story_v_out_116301", "116301021", "story_v_out_116301.awb")
					end

					arg_83_1:RecordHistoryTalkVoice("story_v_out_116301", "116301021", "story_v_out_116301.awb")
				end

				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_18 = math.max(var_86_11, arg_83_1.talkMaxDuration)

			if var_86_10 <= arg_83_1.time_ and arg_83_1.time_ < var_86_10 + var_86_18 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - var_86_10) / var_86_18

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= var_86_10 + var_86_18 and arg_83_1.time_ < var_86_10 + var_86_18 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {
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

		arg_83_1:InitPlayNodeList()
	end,
	Play116301022 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 116301022
		arg_87_1.duration_ = 6.3

		local var_87_0 = {
			zh = 5.466,
			ja = 6.3
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
				arg_87_0:Play116301023(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 then
				arg_87_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 then
				arg_87_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action459")
			end

			local var_90_0 = 0
			local var_90_1 = 0.625

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= var_90_0 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, true)

				arg_87_1.leftNameTxt_.text = arg_87_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_87_1.leftNameTxt_.transform)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1.leftNameTxt_.text)
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_2 = arg_87_1:GetWordFromCfg(116301022)
				local var_90_3 = arg_87_1:FormatText(var_90_2.content)

				arg_87_1.text_.text = var_90_3

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_5 = 25 <= 0 and var_90_1 or var_90_1 * (utf8.len(var_90_3) / 25)

				if (25 <= 0 and var_90_1 or var_90_1 * (utf8.len(var_90_3) / 25)) > 0 and var_90_1 < var_90_5 then
					arg_87_1.talkMaxDuration = var_90_5

					if var_90_5 + var_90_0 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_5 + var_90_0
					end
				end

				arg_87_1.text_.text = var_90_3
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116301", "116301022", "story_v_out_116301.awb") ~= 0 then
					local var_90_6 = manager.audio:GetVoiceLength("story_v_out_116301", "116301022", "story_v_out_116301.awb") / 1000

					if var_90_6 + var_90_0 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_6 + var_90_0
					end

					if var_90_2.prefab_name ~= "" and arg_87_1.actors_[var_90_2.prefab_name] ~= nil then
						local var_90_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_87_1.actors_[var_90_2.prefab_name].transform, "story_v_out_116301", "116301022", "story_v_out_116301.awb")

						arg_87_1:RecordAudio("116301022", var_90_7)
						arg_87_1:RecordAudio("116301022", var_90_7)
					else
						arg_87_1:AudioAction("play", "voice", "story_v_out_116301", "116301022", "story_v_out_116301.awb")
					end

					arg_87_1:RecordHistoryTalkVoice("story_v_out_116301", "116301022", "story_v_out_116301.awb")
				end

				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_8 = math.max(var_90_1, arg_87_1.talkMaxDuration)

			if var_90_0 <= arg_87_1.time_ and arg_87_1.time_ < var_90_0 + var_90_8 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - var_90_0) / var_90_8

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= var_90_0 + var_90_8 and arg_87_1.time_ < var_90_0 + var_90_8 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {}

		arg_87_1:InitPlayNodeList()
	end,
	Play116301023 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 116301023
		arg_91_1.duration_ = 5.93

		local var_91_0 = {
			zh = 5.866,
			ja = 5.933
		}
		local var_91_1 = manager.audio:GetLocalizationFlag()

		if var_91_0[var_91_1] ~= nil then
			arg_91_1.duration_ = var_91_0[var_91_1]
		end

		SetActive(arg_91_1.tipsGo_, false)

		function arg_91_1.onSingleLineFinish_()
			arg_91_1.onSingleLineUpdate_ = nil
			arg_91_1.onSingleLineFinish_ = nil
			arg_91_1.state_ = "waiting"
		end

		function arg_91_1.playNext_(arg_93_0)
			if arg_93_0 == 1 then
				arg_91_0:Play116301024(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 and not isNil(arg_91_1.actors_["1184ui_story"]) and arg_91_1.var_.characterEffect1184ui_story == nil then
				arg_91_1.var_.characterEffect1184ui_story = arg_91_1.actors_["1184ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_94_0 = 0.2

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_0 and not isNil(arg_91_1.actors_["1184ui_story"]) then
				if arg_91_1.var_.characterEffect1184ui_story and not isNil(arg_91_1.actors_["1184ui_story"]) then
					arg_91_1.var_.characterEffect1184ui_story.fillFlat = true
					arg_91_1.var_.characterEffect1184ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_91_1.time_ - 0) / var_94_0)
				end
			end

			if arg_91_1.time_ >= 0 + var_94_0 and arg_91_1.time_ < 0 + var_94_0 + arg_94_0 and not isNil(arg_91_1.actors_["1184ui_story"]) and arg_91_1.var_.characterEffect1184ui_story then
				arg_91_1.var_.characterEffect1184ui_story.fillFlat = true
				arg_91_1.var_.characterEffect1184ui_story.fillRatio = 0.5
			end

			local var_94_1 = arg_91_1.actors_["10024ui_story"]

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 and not isNil(var_94_1) and arg_91_1.var_.characterEffect10024ui_story == nil then
				arg_91_1.var_.characterEffect10024ui_story = var_94_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_94_2 = 0.2

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_2 and not isNil(var_94_1) then
				if arg_91_1.var_.characterEffect10024ui_story and not isNil(var_94_1) then
					arg_91_1.var_.characterEffect10024ui_story.fillFlat = false
				end
			end

			if arg_91_1.time_ >= 0 + var_94_2 and arg_91_1.time_ < 0 + var_94_2 + arg_94_0 and not isNil(var_94_1) and arg_91_1.var_.characterEffect10024ui_story then
				arg_91_1.var_.characterEffect10024ui_story.fillFlat = false
			end

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				arg_91_1:PlayTimeline("10024ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				arg_91_1:PlayTimeline("10024ui_story", "StoryTimeline/CharAction/story10024/story10024action/10024action6_1")
			end

			local var_94_4 = 0
			local var_94_5 = 0.4

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= var_94_4 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, true)

				arg_91_1.leftNameTxt_.text = arg_91_1:FormatText(StoryNameCfg[332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_91_1.leftNameTxt_.transform)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1.leftNameTxt_.text)
				SetActive(arg_91_1.iconTrs_.gameObject, false)
				arg_91_1.callingController_:SetSelectedState("normal")

				local var_94_6 = arg_91_1:GetWordFromCfg(116301023)
				local var_94_7 = arg_91_1:FormatText(var_94_6.content)

				arg_91_1.text_.text = var_94_7

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_9 = 16 <= 0 and var_94_5 or var_94_5 * (utf8.len(var_94_7) / 16)

				if (16 <= 0 and var_94_5 or var_94_5 * (utf8.len(var_94_7) / 16)) > 0 and var_94_5 < var_94_9 then
					arg_91_1.talkMaxDuration = var_94_9

					if var_94_9 + var_94_4 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_9 + var_94_4
					end
				end

				arg_91_1.text_.text = var_94_7
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116301", "116301023", "story_v_out_116301.awb") ~= 0 then
					local var_94_10 = manager.audio:GetVoiceLength("story_v_out_116301", "116301023", "story_v_out_116301.awb") / 1000

					if var_94_10 + var_94_4 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_10 + var_94_4
					end

					if var_94_6.prefab_name ~= "" and arg_91_1.actors_[var_94_6.prefab_name] ~= nil then
						local var_94_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_91_1.actors_[var_94_6.prefab_name].transform, "story_v_out_116301", "116301023", "story_v_out_116301.awb")

						arg_91_1:RecordAudio("116301023", var_94_11)
						arg_91_1:RecordAudio("116301023", var_94_11)
					else
						arg_91_1:AudioAction("play", "voice", "story_v_out_116301", "116301023", "story_v_out_116301.awb")
					end

					arg_91_1:RecordHistoryTalkVoice("story_v_out_116301", "116301023", "story_v_out_116301.awb")
				end

				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_12 = math.max(var_94_5, arg_91_1.talkMaxDuration)

			if var_94_4 <= arg_91_1.time_ and arg_91_1.time_ < var_94_4 + var_94_12 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - var_94_4) / var_94_12

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= var_94_4 + var_94_12 and arg_91_1.time_ < var_94_4 + var_94_12 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {}

		arg_91_1:InitPlayNodeList()
	end,
	Play116301024 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 116301024
		arg_95_1.duration_ = 5

		SetActive(arg_95_1.tipsGo_, false)

		function arg_95_1.onSingleLineFinish_()
			arg_95_1.onSingleLineUpdate_ = nil
			arg_95_1.onSingleLineFinish_ = nil
			arg_95_1.state_ = "waiting"
		end

		function arg_95_1.playNext_(arg_97_0)
			if arg_97_0 == 1 then
				arg_95_0:Play116301025(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 then
				arg_95_1:AudioAction("play", "effect", "se_story_6", "se_story_6_black_fog", "")
			end

			local var_98_1 = arg_95_1.actors_["10024ui_story"].transform

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 then
				arg_95_1.var_.moveOldPos10024ui_story = var_98_1.localPosition
			end

			local var_98_2 = 0.001

			if 0 <= arg_95_1.time_ and arg_95_1.time_ < 0 + var_98_2 then
				var_98_1.localPosition = Vector3.Lerp(arg_95_1.var_.moveOldPos10024ui_story, Vector3.New(0, 100, 0), (arg_95_1.time_ - 0) / var_98_2)
				var_98_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_98_1.position).x, (manager.ui.mainCamera.transform.position - var_98_1.position).y, (manager.ui.mainCamera.transform.position - var_98_1.position).z)
				var_98_1.localEulerAngles.z = 0
				var_98_1.localEulerAngles.x = 0
				var_98_1.localEulerAngles = var_98_1.localEulerAngles
			end

			if arg_95_1.time_ >= 0 + var_98_2 and arg_95_1.time_ < 0 + var_98_2 + arg_98_0 then
				var_98_1.localPosition = Vector3.New(0, 100, 0)
				var_98_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_98_1.position).x, (manager.ui.mainCamera.transform.position - var_98_1.position).y, (manager.ui.mainCamera.transform.position - var_98_1.position).z)
				var_98_1.localEulerAngles.z = 0
				var_98_1.localEulerAngles.x = 0
				var_98_1.localEulerAngles = var_98_1.localEulerAngles
			end

			local var_98_3 = arg_95_1.actors_["1184ui_story"].transform

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 then
				arg_95_1.var_.moveOldPos1184ui_story = var_98_3.localPosition
			end

			local var_98_4 = 0.001

			if 0 <= arg_95_1.time_ and arg_95_1.time_ < 0 + var_98_4 then
				var_98_3.localPosition = Vector3.Lerp(arg_95_1.var_.moveOldPos1184ui_story, Vector3.New(0, 100, 0), (arg_95_1.time_ - 0) / var_98_4)
				var_98_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_98_3.position).x, (manager.ui.mainCamera.transform.position - var_98_3.position).y, (manager.ui.mainCamera.transform.position - var_98_3.position).z)
				var_98_3.localEulerAngles.z = 0
				var_98_3.localEulerAngles.x = 0
				var_98_3.localEulerAngles = var_98_3.localEulerAngles
			end

			if arg_95_1.time_ >= 0 + var_98_4 and arg_95_1.time_ < 0 + var_98_4 + arg_98_0 then
				var_98_3.localPosition = Vector3.New(0, 100, 0)
				var_98_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_98_3.position).x, (manager.ui.mainCamera.transform.position - var_98_3.position).y, (manager.ui.mainCamera.transform.position - var_98_3.position).z)
				var_98_3.localEulerAngles.z = 0
				var_98_3.localEulerAngles.x = 0
				var_98_3.localEulerAngles = var_98_3.localEulerAngles
			end

			local var_98_5 = 0
			local var_98_6 = 1.225

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= var_98_5 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, false)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_95_1.iconTrs_.gameObject, false)
				arg_95_1.callingController_:SetSelectedState("normal")

				local var_98_7 = arg_95_1:FormatText(arg_95_1:GetWordFromCfg(116301024).content)

				arg_95_1.text_.text = var_98_7

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_9 = 49 <= 0 and var_98_6 or var_98_6 * (utf8.len(var_98_7) / 49)

				if (49 <= 0 and var_98_6 or var_98_6 * (utf8.len(var_98_7) / 49)) > 0 and var_98_6 < var_98_9 then
					arg_95_1.talkMaxDuration = var_98_9

					if var_98_9 + var_98_5 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_9 + var_98_5
					end
				end

				arg_95_1.text_.text = var_98_7
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)
				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_10 = math.max(var_98_6, arg_95_1.talkMaxDuration)

			if var_98_5 <= arg_95_1.time_ and arg_95_1.time_ < var_98_5 + var_98_10 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - var_98_5) / var_98_10

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= var_98_5 + var_98_10 and arg_95_1.time_ < var_98_5 + var_98_10 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10024ui_story",
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

		arg_95_1:InitPlayNodeList()
	end,
	Play116301025 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 116301025
		arg_99_1.duration_ = 6.5

		local var_99_0 = {
			zh = 6.5,
			ja = 3.5
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
				arg_99_0:Play116301026(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 then
				arg_99_1.var_.moveOldPos10024ui_story = arg_99_1.actors_["10024ui_story"].transform.localPosition
			end

			local var_102_0 = 0.001

			if 0 <= arg_99_1.time_ and arg_99_1.time_ < 0 + var_102_0 then
				arg_99_1.actors_["10024ui_story"].transform.localPosition = Vector3.Lerp(arg_99_1.var_.moveOldPos10024ui_story, Vector3.New(0, -1, -6), (arg_99_1.time_ - 0) / var_102_0)
				arg_99_1.actors_["10024ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_99_1.actors_["10024ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_99_1.actors_["10024ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_99_1.actors_["10024ui_story"].transform.position).z)
				arg_99_1.actors_["10024ui_story"].transform.localEulerAngles.z = 0
				arg_99_1.actors_["10024ui_story"].transform.localEulerAngles.x = 0
				arg_99_1.actors_["10024ui_story"].transform.localEulerAngles = arg_99_1.actors_["10024ui_story"].transform.localEulerAngles
			end

			if arg_99_1.time_ >= 0 + var_102_0 and arg_99_1.time_ < 0 + var_102_0 + arg_102_0 then
				arg_99_1.actors_["10024ui_story"].transform.localPosition = Vector3.New(0, -1, -6)
				arg_99_1.actors_["10024ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_99_1.actors_["10024ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_99_1.actors_["10024ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_99_1.actors_["10024ui_story"].transform.position).z)
				arg_99_1.actors_["10024ui_story"].transform.localEulerAngles.z = 0
				arg_99_1.actors_["10024ui_story"].transform.localEulerAngles.x = 0
				arg_99_1.actors_["10024ui_story"].transform.localEulerAngles = arg_99_1.actors_["10024ui_story"].transform.localEulerAngles
			end

			local var_102_1 = arg_99_1.actors_["10024ui_story"]

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 and not isNil(var_102_1) and arg_99_1.var_.characterEffect10024ui_story == nil then
				arg_99_1.var_.characterEffect10024ui_story = var_102_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_102_2 = 0.2

			if 0 <= arg_99_1.time_ and arg_99_1.time_ < 0 + var_102_2 and not isNil(var_102_1) then
				if arg_99_1.var_.characterEffect10024ui_story and not isNil(var_102_1) then
					arg_99_1.var_.characterEffect10024ui_story.fillFlat = false
				end
			end

			if arg_99_1.time_ >= 0 + var_102_2 and arg_99_1.time_ < 0 + var_102_2 + arg_102_0 and not isNil(var_102_1) and arg_99_1.var_.characterEffect10024ui_story then
				arg_99_1.var_.characterEffect10024ui_story.fillFlat = false
			end

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 then
				arg_99_1:PlayTimeline("10024ui_story", "StoryTimeline/CharAction/story10024/story10024action/10024action2_1")
			end

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 then
				arg_99_1:PlayTimeline("10024ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_102_4 = 0
			local var_102_5 = 0.6

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= var_102_4 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, true)

				arg_99_1.leftNameTxt_.text = arg_99_1:FormatText(StoryNameCfg[332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_99_1.leftNameTxt_.transform)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1.leftNameTxt_.text)
				SetActive(arg_99_1.iconTrs_.gameObject, false)
				arg_99_1.callingController_:SetSelectedState("normal")

				local var_102_6 = arg_99_1:GetWordFromCfg(116301025)
				local var_102_7 = arg_99_1:FormatText(var_102_6.content)

				arg_99_1.text_.text = var_102_7

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_9 = 24 <= 0 and var_102_5 or var_102_5 * (utf8.len(var_102_7) / 24)

				if (24 <= 0 and var_102_5 or var_102_5 * (utf8.len(var_102_7) / 24)) > 0 and var_102_5 < var_102_9 then
					arg_99_1.talkMaxDuration = var_102_9

					if var_102_9 + var_102_4 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_9 + var_102_4
					end
				end

				arg_99_1.text_.text = var_102_7
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116301", "116301025", "story_v_out_116301.awb") ~= 0 then
					local var_102_10 = manager.audio:GetVoiceLength("story_v_out_116301", "116301025", "story_v_out_116301.awb") / 1000

					if var_102_10 + var_102_4 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_10 + var_102_4
					end

					if var_102_6.prefab_name ~= "" and arg_99_1.actors_[var_102_6.prefab_name] ~= nil then
						local var_102_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_99_1.actors_[var_102_6.prefab_name].transform, "story_v_out_116301", "116301025", "story_v_out_116301.awb")

						arg_99_1:RecordAudio("116301025", var_102_11)
						arg_99_1:RecordAudio("116301025", var_102_11)
					else
						arg_99_1:AudioAction("play", "voice", "story_v_out_116301", "116301025", "story_v_out_116301.awb")
					end

					arg_99_1:RecordHistoryTalkVoice("story_v_out_116301", "116301025", "story_v_out_116301.awb")
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
				actorName = "10024ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_99_1:InitPlayNodeList()
	end,
	Play116301026 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 116301026
		arg_103_1.duration_ = 8.47

		local var_103_0 = {
			zh = 8.133,
			ja = 8.466
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
				arg_103_0:Play116301027(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 then
				arg_103_1:PlayTimeline("10024ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_106_0 = 0
			local var_106_1 = 0.8

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= var_106_0 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, true)

				arg_103_1.leftNameTxt_.text = arg_103_1:FormatText(StoryNameCfg[332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_103_1.leftNameTxt_.transform)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1.leftNameTxt_.text)
				SetActive(arg_103_1.iconTrs_.gameObject, false)
				arg_103_1.callingController_:SetSelectedState("normal")

				local var_106_2 = arg_103_1:GetWordFromCfg(116301026)
				local var_106_3 = arg_103_1:FormatText(var_106_2.content)

				arg_103_1.text_.text = var_106_3

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_5 = 32 <= 0 and var_106_1 or var_106_1 * (utf8.len(var_106_3) / 32)

				if (32 <= 0 and var_106_1 or var_106_1 * (utf8.len(var_106_3) / 32)) > 0 and var_106_1 < var_106_5 then
					arg_103_1.talkMaxDuration = var_106_5

					if var_106_5 + var_106_0 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_5 + var_106_0
					end
				end

				arg_103_1.text_.text = var_106_3
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116301", "116301026", "story_v_out_116301.awb") ~= 0 then
					local var_106_6 = manager.audio:GetVoiceLength("story_v_out_116301", "116301026", "story_v_out_116301.awb") / 1000

					if var_106_6 + var_106_0 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_6 + var_106_0
					end

					if var_106_2.prefab_name ~= "" and arg_103_1.actors_[var_106_2.prefab_name] ~= nil then
						local var_106_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_103_1.actors_[var_106_2.prefab_name].transform, "story_v_out_116301", "116301026", "story_v_out_116301.awb")

						arg_103_1:RecordAudio("116301026", var_106_7)
						arg_103_1:RecordAudio("116301026", var_106_7)
					else
						arg_103_1:AudioAction("play", "voice", "story_v_out_116301", "116301026", "story_v_out_116301.awb")
					end

					arg_103_1:RecordHistoryTalkVoice("story_v_out_116301", "116301026", "story_v_out_116301.awb")
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
	Play116301027 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 116301027
		arg_107_1.duration_ = 5.1

		local var_107_0 = {
			zh = 5.1,
			ja = 3.033
		}
		local var_107_1 = manager.audio:GetLocalizationFlag()

		if var_107_0[var_107_1] ~= nil then
			arg_107_1.duration_ = var_107_0[var_107_1]
		end

		SetActive(arg_107_1.tipsGo_, false)

		function arg_107_1.onSingleLineFinish_()
			arg_107_1.onSingleLineUpdate_ = nil
			arg_107_1.onSingleLineFinish_ = nil
			arg_107_1.state_ = "waiting"
		end

		function arg_107_1.playNext_(arg_109_0)
			if arg_109_0 == 1 then
				arg_107_0:Play116301028(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 and not isNil(arg_107_1.actors_["10024ui_story"]) and arg_107_1.var_.characterEffect10024ui_story == nil then
				arg_107_1.var_.characterEffect10024ui_story = arg_107_1.actors_["10024ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_110_0 = 0.2

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_0 and not isNil(arg_107_1.actors_["10024ui_story"]) then
				if arg_107_1.var_.characterEffect10024ui_story and not isNil(arg_107_1.actors_["10024ui_story"]) then
					arg_107_1.var_.characterEffect10024ui_story.fillFlat = true
					arg_107_1.var_.characterEffect10024ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_107_1.time_ - 0) / var_110_0)
				end
			end

			if arg_107_1.time_ >= 0 + var_110_0 and arg_107_1.time_ < 0 + var_110_0 + arg_110_0 and not isNil(arg_107_1.actors_["10024ui_story"]) and arg_107_1.var_.characterEffect10024ui_story then
				arg_107_1.var_.characterEffect10024ui_story.fillFlat = true
				arg_107_1.var_.characterEffect10024ui_story.fillRatio = 0.5
			end

			local var_110_1 = arg_107_1.actors_["10025ui_story"]

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 and not isNil(var_110_1) and arg_107_1.var_.characterEffect10025ui_story == nil then
				arg_107_1.var_.characterEffect10025ui_story = var_110_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_110_2 = 0.2

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_2 and not isNil(var_110_1) then
				if arg_107_1.var_.characterEffect10025ui_story and not isNil(var_110_1) then
					arg_107_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_107_1.time_ >= 0 + var_110_2 and arg_107_1.time_ < 0 + var_110_2 + arg_110_0 and not isNil(var_110_1) and arg_107_1.var_.characterEffect10025ui_story then
				arg_107_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 then
				arg_107_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action7_1")
			end

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 then
				arg_107_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 then
				arg_107_1:PlayTimeline("10024ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1301cva")
			end

			local var_110_4 = arg_107_1.actors_["10025ui_story"].transform

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 then
				arg_107_1.var_.moveOldPos10025ui_story = var_110_4.localPosition
			end

			local var_110_5 = 0.001

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_5 then
				var_110_4.localPosition = Vector3.Lerp(arg_107_1.var_.moveOldPos10025ui_story, Vector3.New(0, -1.1, -5.9), (arg_107_1.time_ - 0) / var_110_5)
				var_110_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_110_4.position).x, (manager.ui.mainCamera.transform.position - var_110_4.position).y, (manager.ui.mainCamera.transform.position - var_110_4.position).z)
				var_110_4.localEulerAngles.z = 0
				var_110_4.localEulerAngles.x = 0
				var_110_4.localEulerAngles = var_110_4.localEulerAngles
			end

			if arg_107_1.time_ >= 0 + var_110_5 and arg_107_1.time_ < 0 + var_110_5 + arg_110_0 then
				var_110_4.localPosition = Vector3.New(0, -1.1, -5.9)
				var_110_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_110_4.position).x, (manager.ui.mainCamera.transform.position - var_110_4.position).y, (manager.ui.mainCamera.transform.position - var_110_4.position).z)
				var_110_4.localEulerAngles.z = 0
				var_110_4.localEulerAngles.x = 0
				var_110_4.localEulerAngles = var_110_4.localEulerAngles
			end

			local var_110_6 = arg_107_1.actors_["10024ui_story"].transform

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 then
				arg_107_1.var_.moveOldPos10024ui_story = var_110_6.localPosition
			end

			local var_110_7 = 0.001

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_7 then
				var_110_6.localPosition = Vector3.Lerp(arg_107_1.var_.moveOldPos10024ui_story, Vector3.New(0, 100, 0), (arg_107_1.time_ - 0) / var_110_7)
				var_110_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_110_6.position).x, (manager.ui.mainCamera.transform.position - var_110_6.position).y, (manager.ui.mainCamera.transform.position - var_110_6.position).z)
				var_110_6.localEulerAngles.z = 0
				var_110_6.localEulerAngles.x = 0
				var_110_6.localEulerAngles = var_110_6.localEulerAngles
			end

			if arg_107_1.time_ >= 0 + var_110_7 and arg_107_1.time_ < 0 + var_110_7 + arg_110_0 then
				var_110_6.localPosition = Vector3.New(0, 100, 0)
				var_110_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_110_6.position).x, (manager.ui.mainCamera.transform.position - var_110_6.position).y, (manager.ui.mainCamera.transform.position - var_110_6.position).z)
				var_110_6.localEulerAngles.z = 0
				var_110_6.localEulerAngles.x = 0
				var_110_6.localEulerAngles = var_110_6.localEulerAngles
			end

			local var_110_8 = 0
			local var_110_9 = 0.275

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= var_110_8 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, true)

				arg_107_1.leftNameTxt_.text = arg_107_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_107_1.leftNameTxt_.transform)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1.leftNameTxt_.text)
				SetActive(arg_107_1.iconTrs_.gameObject, false)
				arg_107_1.callingController_:SetSelectedState("normal")

				local var_110_10 = arg_107_1:GetWordFromCfg(116301027)
				local var_110_11 = arg_107_1:FormatText(var_110_10.content)

				arg_107_1.text_.text = var_110_11

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_13 = 11 <= 0 and var_110_9 or var_110_9 * (utf8.len(var_110_11) / 11)

				if (11 <= 0 and var_110_9 or var_110_9 * (utf8.len(var_110_11) / 11)) > 0 and var_110_9 < var_110_13 then
					arg_107_1.talkMaxDuration = var_110_13

					if var_110_13 + var_110_8 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_13 + var_110_8
					end
				end

				arg_107_1.text_.text = var_110_11
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116301", "116301027", "story_v_out_116301.awb") ~= 0 then
					local var_110_14 = manager.audio:GetVoiceLength("story_v_out_116301", "116301027", "story_v_out_116301.awb") / 1000

					if var_110_14 + var_110_8 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_14 + var_110_8
					end

					if var_110_10.prefab_name ~= "" and arg_107_1.actors_[var_110_10.prefab_name] ~= nil then
						local var_110_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_107_1.actors_[var_110_10.prefab_name].transform, "story_v_out_116301", "116301027", "story_v_out_116301.awb")

						arg_107_1:RecordAudio("116301027", var_110_15)
						arg_107_1:RecordAudio("116301027", var_110_15)
					else
						arg_107_1:AudioAction("play", "voice", "story_v_out_116301", "116301027", "story_v_out_116301.awb")
					end

					arg_107_1:RecordHistoryTalkVoice("story_v_out_116301", "116301027", "story_v_out_116301.awb")
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
				actorName = "10025ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10024ui_story",
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
	Play116301028 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 116301028
		arg_111_1.duration_ = 8

		SetActive(arg_111_1.tipsGo_, false)

		function arg_111_1.onSingleLineFinish_()
			arg_111_1.onSingleLineUpdate_ = nil
			arg_111_1.onSingleLineFinish_ = nil
			arg_111_1.state_ = "waiting"
		end

		function arg_111_1.playNext_(arg_113_0)
			if arg_113_0 == 1 then
				arg_111_0:Play116301029(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			if 2 < arg_111_1.time_ and arg_111_1.time_ <= 2 + arg_114_0 then
				arg_111_1:AudioAction("play", "effect", "se_story_9", "se_story_9_black_fog02", "")
			end

			local var_114_1 = arg_111_1.actors_["10024ui_story"].transform

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 then
				arg_111_1.var_.moveOldPos10024ui_story = var_114_1.localPosition
			end

			local var_114_2 = 0.001

			if 0 <= arg_111_1.time_ and arg_111_1.time_ < 0 + var_114_2 then
				var_114_1.localPosition = Vector3.Lerp(arg_111_1.var_.moveOldPos10024ui_story, Vector3.New(0, 100, 0), (arg_111_1.time_ - 0) / var_114_2)
				var_114_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_114_1.position).x, (manager.ui.mainCamera.transform.position - var_114_1.position).y, (manager.ui.mainCamera.transform.position - var_114_1.position).z)
				var_114_1.localEulerAngles.z = 0
				var_114_1.localEulerAngles.x = 0
				var_114_1.localEulerAngles = var_114_1.localEulerAngles
			end

			if arg_111_1.time_ >= 0 + var_114_2 and arg_111_1.time_ < 0 + var_114_2 + arg_114_0 then
				var_114_1.localPosition = Vector3.New(0, 100, 0)
				var_114_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_114_1.position).x, (manager.ui.mainCamera.transform.position - var_114_1.position).y, (manager.ui.mainCamera.transform.position - var_114_1.position).z)
				var_114_1.localEulerAngles.z = 0
				var_114_1.localEulerAngles.x = 0
				var_114_1.localEulerAngles = var_114_1.localEulerAngles
			end

			local var_114_3 = arg_111_1.actors_["10025ui_story"].transform

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 then
				arg_111_1.var_.moveOldPos10025ui_story = var_114_3.localPosition
			end

			local var_114_4 = 0.001

			if 0 <= arg_111_1.time_ and arg_111_1.time_ < 0 + var_114_4 then
				var_114_3.localPosition = Vector3.Lerp(arg_111_1.var_.moveOldPos10025ui_story, Vector3.New(0, 100, 0), (arg_111_1.time_ - 0) / var_114_4)
				var_114_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_114_3.position).x, (manager.ui.mainCamera.transform.position - var_114_3.position).y, (manager.ui.mainCamera.transform.position - var_114_3.position).z)
				var_114_3.localEulerAngles.z = 0
				var_114_3.localEulerAngles.x = 0
				var_114_3.localEulerAngles = var_114_3.localEulerAngles
			end

			if arg_111_1.time_ >= 0 + var_114_4 and arg_111_1.time_ < 0 + var_114_4 + arg_114_0 then
				var_114_3.localPosition = Vector3.New(0, 100, 0)
				var_114_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_114_3.position).x, (manager.ui.mainCamera.transform.position - var_114_3.position).y, (manager.ui.mainCamera.transform.position - var_114_3.position).z)
				var_114_3.localEulerAngles.z = 0
				var_114_3.localEulerAngles.x = 0
				var_114_3.localEulerAngles = var_114_3.localEulerAngles
			end

			local var_114_5 = manager.ui.mainCamera.transform

			if 2 < arg_111_1.time_ and arg_111_1.time_ <= 2 + arg_114_0 then
				arg_111_1.var_.shakeOldPos = var_114_5.localPosition
			end

			local var_114_6 = 1

			if 2 <= arg_111_1.time_ and arg_111_1.time_ < 2 + var_114_6 then
				local var_114_7, var_114_8 = math.modf((arg_111_1.time_ - 2) / 0.066)

				var_114_5.localPosition = Vector3.New(var_114_8 * 0.13, var_114_8 * 0.13, var_114_8 * 0.13) + arg_111_1.var_.shakeOldPos
			end

			if arg_111_1.time_ >= 2 + var_114_6 and arg_111_1.time_ < 2 + var_114_6 + arg_114_0 then
				var_114_5.localPosition = arg_111_1.var_.shakeOldPos
			end

			local var_114_9 = 0

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= var_114_9 + arg_114_0 then
				arg_111_1.mask_.enabled = true
				arg_111_1.mask_.raycastTarget = true

				arg_111_1:SetGaussion(false)
			end

			local var_114_10 = 2

			if var_114_9 <= arg_111_1.time_ and arg_111_1.time_ < var_114_9 + var_114_10 then
				local var_114_11 = Color.New(0, 0, 0)

				var_114_11.a = Mathf.Lerp(0, 1, (arg_111_1.time_ - var_114_9) / var_114_10)
				arg_111_1.mask_.color = var_114_11
			end

			if arg_111_1.time_ >= var_114_9 + var_114_10 and arg_111_1.time_ < var_114_9 + var_114_10 + arg_114_0 then
				local var_114_12 = Color.New(0, 0, 0)

				var_114_12.a = 1
				arg_111_1.mask_.color = var_114_12
			end

			local var_114_13 = 2

			if 2 < arg_111_1.time_ and arg_111_1.time_ <= var_114_13 + arg_114_0 then
				arg_111_1.mask_.enabled = true
				arg_111_1.mask_.raycastTarget = true

				arg_111_1:SetGaussion(false)
			end

			local var_114_14 = 0.75

			if var_114_13 <= arg_111_1.time_ and arg_111_1.time_ < var_114_13 + var_114_14 then
				local var_114_15 = Color.New(0, 0, 0)

				var_114_15.a = Mathf.Lerp(1, 0, (arg_111_1.time_ - var_114_13) / var_114_14)
				arg_111_1.mask_.color = var_114_15
			end

			if arg_111_1.time_ >= var_114_13 + var_114_14 and arg_111_1.time_ < var_114_13 + var_114_14 + arg_114_0 then
				local var_114_16 = Color.New(0, 0, 0)

				arg_111_1.mask_.enabled = false
				var_114_16.a = 0
				arg_111_1.mask_.color = var_114_16
			end

			if arg_111_1.frameCnt_ <= 1 then
				arg_111_1.dialog_:SetActive(false)
			end

			local var_114_17 = 3
			local var_114_18 = 0.9

			if 3 < arg_111_1.time_ and arg_111_1.time_ <= var_114_17 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0

				arg_111_1.dialog_:SetActive(true)

				arg_111_1.dialogCg_.alpha = 0

				local var_114_19 = LeanTween.value(arg_111_1.dialog_, 0, 1, 0.3)

				var_114_19:setOnUpdate(LuaHelper.FloatAction(function(arg_115_0)
					arg_111_1.dialogCg_.alpha = arg_115_0
				end))
				var_114_19:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_111_1.dialog_)
					var_114_19:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_111_1.duration_ = arg_111_1.duration_ + 0.3

				SetActive(arg_111_1.leftNameGo_, false)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_20 = arg_111_1:FormatText(arg_111_1:GetWordFromCfg(116301028).content)

				arg_111_1.text_.text = var_114_20

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_22 = 36 <= 0 and var_114_18 or var_114_18 * (utf8.len(var_114_20) / 36)

				if (36 <= 0 and var_114_18 or var_114_18 * (utf8.len(var_114_20) / 36)) > 0 and var_114_18 < var_114_22 then
					arg_111_1.talkMaxDuration = var_114_22
					var_114_17 = var_114_17 + 0.3

					if var_114_22 + var_114_17 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_22 + var_114_17
					end
				end

				arg_111_1.text_.text = var_114_20
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)
				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_23 = var_114_17 + 0.3
			local var_114_24 = math.max(var_114_18, arg_111_1.talkMaxDuration)

			if var_114_17 + 0.3 <= arg_111_1.time_ and arg_111_1.time_ < var_114_23 + var_114_24 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_23) / var_114_24

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_23 + var_114_24 and arg_111_1.time_ < var_114_23 + var_114_24 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10024ui_story",
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

		arg_111_1:InitPlayNodeList()
	end,
	Play116301029 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 116301029
		arg_117_1.duration_ = 6.53

		local var_117_0 = {
			zh = 6.533,
			ja = 4.5
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
			arg_117_1.auto_ = false
		end

		function arg_117_1.playNext_(arg_119_0)
			arg_117_1.onStoryFinished_()
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			local var_120_0 = 0.5

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				arg_117_1.leftNameTxt_.text = arg_117_1:FormatText(StoryNameCfg[332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, true)
				arg_117_1.iconController_:SetSelectedState("hero")

				arg_117_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4031")

				arg_117_1.callingController_:SetSelectedState("normal")

				arg_117_1.keyicon_.color = Color.New(1, 1, 1)
				arg_117_1.icon_.color = Color.New(1, 1, 1)

				local var_120_1 = arg_117_1:GetWordFromCfg(116301029)
				local var_120_2 = arg_117_1:FormatText(var_120_1.content)

				arg_117_1.text_.text = var_120_2

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_4 = 20 <= 0 and var_120_0 or var_120_0 * (utf8.len(var_120_2) / 20)

				if (20 <= 0 and var_120_0 or var_120_0 * (utf8.len(var_120_2) / 20)) > 0 and var_120_0 < var_120_4 then
					arg_117_1.talkMaxDuration = var_120_4

					if var_120_4 + 0 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_4 + 0
					end
				end

				arg_117_1.text_.text = var_120_2
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116301", "116301029", "story_v_out_116301.awb") ~= 0 then
					local var_120_5 = manager.audio:GetVoiceLength("story_v_out_116301", "116301029", "story_v_out_116301.awb") / 1000

					if var_120_5 + 0 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_5 + 0
					end

					if var_120_1.prefab_name ~= "" and arg_117_1.actors_[var_120_1.prefab_name] ~= nil then
						local var_120_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_1.prefab_name].transform, "story_v_out_116301", "116301029", "story_v_out_116301.awb")

						arg_117_1:RecordAudio("116301029", var_120_6)
						arg_117_1:RecordAudio("116301029", var_120_6)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_out_116301", "116301029", "story_v_out_116301.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_out_116301", "116301029", "story_v_out_116301.awb")
				end

				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_7 = math.max(var_120_0, arg_117_1.talkMaxDuration)

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_7 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - 0) / var_120_7

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= 0 + var_120_7 and arg_117_1.time_ < 0 + var_120_7 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {}

		arg_117_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/B13c"
	},
	voices = {
		"story_v_out_116301.awb"
	}
}
