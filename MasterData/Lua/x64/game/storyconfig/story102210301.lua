return {
	Play221031001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 221031001
		arg_1_1.duration_ = 13.07

		local var_1_0 = {
			ja = 13.066,
			ko = 10.866,
			zh = 10.866
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
				arg_1_0:Play221031002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.ST31 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST31")
				var_4_0.name = "ST31"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.ST31 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.ST31

				arg_1_1.bgs_.ST31.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "ST31" then
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

			local var_4_8 = "1072ui_story"

			if arg_1_1.actors_["1072ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1072ui_story"))) then
				local var_4_9 = Object.Instantiate(Asset.Load("Char/" .. "1072ui_story"), arg_1_1.stage_.transform)

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

			local var_4_12 = arg_1_1.actors_["1072ui_story"].transform

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 then
				arg_1_1.var_.moveOldPos1072ui_story = var_4_12.localPosition
			end

			local var_4_13 = 0.001

			if 2 <= arg_1_1.time_ and arg_1_1.time_ < 2 + var_4_13 then
				var_4_12.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1072ui_story, Vector3.New(0, -0.71, -6), (arg_1_1.time_ - 2) / var_4_13)
				var_4_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_12.position).x, (manager.ui.mainCamera.transform.position - var_4_12.position).y, (manager.ui.mainCamera.transform.position - var_4_12.position).z)
				var_4_12.localEulerAngles.z = 0
				var_4_12.localEulerAngles.x = 0
				var_4_12.localEulerAngles = var_4_12.localEulerAngles
			end

			if arg_1_1.time_ >= 2 + var_4_13 and arg_1_1.time_ < 2 + var_4_13 + arg_4_0 then
				var_4_12.localPosition = Vector3.New(0, -0.71, -6)
				var_4_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_12.position).x, (manager.ui.mainCamera.transform.position - var_4_12.position).y, (manager.ui.mainCamera.transform.position - var_4_12.position).z)
				var_4_12.localEulerAngles.z = 0
				var_4_12.localEulerAngles.x = 0
				var_4_12.localEulerAngles = var_4_12.localEulerAngles
			end

			local var_4_14 = arg_1_1.actors_["1072ui_story"]

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 and not isNil(var_4_14) and arg_1_1.var_.characterEffect1072ui_story == nil then
				arg_1_1.var_.characterEffect1072ui_story = var_4_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_15 = 0.200000002980232

			if 2 <= arg_1_1.time_ and arg_1_1.time_ < 2 + var_4_15 and not isNil(var_4_14) then
				if arg_1_1.var_.characterEffect1072ui_story and not isNil(var_4_14) then
					arg_1_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= 2 + var_4_15 and arg_1_1.time_ < 2 + var_4_15 + arg_4_0 and not isNil(var_4_14) and arg_1_1.var_.characterEffect1072ui_story then
				arg_1_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 then
				arg_1_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action1_1")
			end

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 then
				arg_1_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
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

			if 1.20000000298023 < arg_1_1.time_ and arg_1_1.time_ <= 1.20000000298023 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_side_daily02", "bgm_side_daily02", "bgm_side_daily02.awb")

				local var_4_22 = manager.audio:GetAudioName("bgm_side_daily02", "bgm_side_daily02")

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

			if 1.5 < arg_1_1.time_ and arg_1_1.time_ <= 1.5 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_side_1096", "se_story_1096_crowd_loop", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_24 = 2
			local var_4_25 = 0.85

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_24 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_26 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_26:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_26:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_26:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_27 = arg_1_1:GetWordFromCfg(221031001)
				local var_4_28 = arg_1_1:FormatText(var_4_27.content)

				arg_1_1.text_.text = var_4_28

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_30 = 34 <= 0 and var_4_25 or var_4_25 * (utf8.len(var_4_28) / 34)

				if (34 <= 0 and var_4_25 or var_4_25 * (utf8.len(var_4_28) / 34)) > 0 and var_4_25 < var_4_30 then
					arg_1_1.talkMaxDuration = var_4_30
					var_4_24 = var_4_24 + 0.3

					if var_4_30 + var_4_24 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_30 + var_4_24
					end
				end

				arg_1_1.text_.text = var_4_28
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221031", "221031001", "story_v_out_221031.awb") ~= 0 then
					local var_4_31 = manager.audio:GetVoiceLength("story_v_out_221031", "221031001", "story_v_out_221031.awb") / 1000

					if var_4_31 + var_4_24 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_31 + var_4_24
					end

					if var_4_27.prefab_name ~= "" and arg_1_1.actors_[var_4_27.prefab_name] ~= nil then
						local var_4_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_27.prefab_name].transform, "story_v_out_221031", "221031001", "story_v_out_221031.awb")

						arg_1_1:RecordAudio("221031001", var_4_32)
						arg_1_1:RecordAudio("221031001", var_4_32)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_221031", "221031001", "story_v_out_221031.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_221031", "221031001", "story_v_out_221031.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_33 = var_4_24 + 0.3
			local var_4_34 = math.max(var_4_25, arg_1_1.talkMaxDuration)

			if var_4_24 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_33 + var_4_34 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_33) / var_4_34

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_33 + var_4_34 and arg_1_1.time_ < var_4_33 + var_4_34 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play221031002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 221031002
		arg_9_1.duration_ = 7.83

		local var_9_0 = {
			ja = 7.833,
			ko = 6.733,
			zh = 6.733
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
				arg_9_0:Play221031003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.var_.moveOldPos1072ui_story = arg_9_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_12_0 = 0.001

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_0 then
				arg_9_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos1072ui_story, Vector3.New(0, -0.71, -6), (arg_9_1.time_ - 0) / var_12_0)
				arg_9_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_9_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_9_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_9_1.actors_["1072ui_story"].transform.position).z)
				arg_9_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_9_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_9_1.actors_["1072ui_story"].transform.localEulerAngles = arg_9_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_9_1.time_ >= 0 + var_12_0 and arg_9_1.time_ < 0 + var_12_0 + arg_12_0 then
				arg_9_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_9_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_9_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_9_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_9_1.actors_["1072ui_story"].transform.position).z)
				arg_9_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_9_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_9_1.actors_["1072ui_story"].transform.localEulerAngles = arg_9_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action5_1")
			end

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_12_1 = 0
			local var_12_2 = 0.85

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_1 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				arg_9_1.leftNameTxt_.text = arg_9_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_3 = arg_9_1:GetWordFromCfg(221031002)
				local var_12_4 = arg_9_1:FormatText(var_12_3.content)

				arg_9_1.text_.text = var_12_4

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_6 = 34 <= 0 and var_12_2 or var_12_2 * (utf8.len(var_12_4) / 34)

				if (34 <= 0 and var_12_2 or var_12_2 * (utf8.len(var_12_4) / 34)) > 0 and var_12_2 < var_12_6 then
					arg_9_1.talkMaxDuration = var_12_6

					if var_12_6 + var_12_1 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_6 + var_12_1
					end
				end

				arg_9_1.text_.text = var_12_4
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221031", "221031002", "story_v_out_221031.awb") ~= 0 then
					local var_12_7 = manager.audio:GetVoiceLength("story_v_out_221031", "221031002", "story_v_out_221031.awb") / 1000

					if var_12_7 + var_12_1 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_7 + var_12_1
					end

					if var_12_3.prefab_name ~= "" and arg_9_1.actors_[var_12_3.prefab_name] ~= nil then
						local var_12_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_3.prefab_name].transform, "story_v_out_221031", "221031002", "story_v_out_221031.awb")

						arg_9_1:RecordAudio("221031002", var_12_8)
						arg_9_1:RecordAudio("221031002", var_12_8)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_221031", "221031002", "story_v_out_221031.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_221031", "221031002", "story_v_out_221031.awb")
				end

				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_9 = math.max(var_12_2, arg_9_1.talkMaxDuration)

			if var_12_1 <= arg_9_1.time_ and arg_9_1.time_ < var_12_1 + var_12_9 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_1) / var_12_9

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_1 + var_12_9 and arg_9_1.time_ < var_12_1 + var_12_9 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
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
	Play221031003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 221031003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play221031004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(arg_13_1.actors_["1072ui_story"]) and arg_13_1.var_.characterEffect1072ui_story == nil then
				arg_13_1.var_.characterEffect1072ui_story = arg_13_1.actors_["1072ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_0 = 0.200000002980232

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_0 and not isNil(arg_13_1.actors_["1072ui_story"]) then
				if arg_13_1.var_.characterEffect1072ui_story and not isNil(arg_13_1.actors_["1072ui_story"]) then
					arg_13_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_13_1.var_.characterEffect1072ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_13_1.time_ - 0) / var_16_0)
				end
			end

			if arg_13_1.time_ >= 0 + var_16_0 and arg_13_1.time_ < 0 + var_16_0 + arg_16_0 and not isNil(arg_13_1.actors_["1072ui_story"]) and arg_13_1.var_.characterEffect1072ui_story then
				arg_13_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_13_1.var_.characterEffect1072ui_story.fillRatio = 0.5
			end

			local var_16_1 = 0
			local var_16_2 = 1.05

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_1 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, false)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_3 = arg_13_1:FormatText(arg_13_1:GetWordFromCfg(221031003).content)

				arg_13_1.text_.text = var_16_3

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_5 = 42 <= 0 and var_16_2 or var_16_2 * (utf8.len(var_16_3) / 42)

				if (42 <= 0 and var_16_2 or var_16_2 * (utf8.len(var_16_3) / 42)) > 0 and var_16_2 < var_16_5 then
					arg_13_1.talkMaxDuration = var_16_5

					if var_16_5 + var_16_1 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_5 + var_16_1
					end
				end

				arg_13_1.text_.text = var_16_3
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)
				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_6 = math.max(var_16_2, arg_13_1.talkMaxDuration)

			if var_16_1 <= arg_13_1.time_ and arg_13_1.time_ < var_16_1 + var_16_6 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_1) / var_16_6

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_1 + var_16_6 and arg_13_1.time_ < var_16_1 + var_16_6 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play221031004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 221031004
		arg_17_1.duration_ = 8.7

		local var_17_0 = {
			ja = 8.7,
			ko = 8.166,
			zh = 8.166
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
				arg_17_0:Play221031005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.var_.moveOldPos1072ui_story = arg_17_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_20_0 = 0.001

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_0 then
				arg_17_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1072ui_story, Vector3.New(0, -0.71, -6), (arg_17_1.time_ - 0) / var_20_0)
				arg_17_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_17_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["1072ui_story"].transform.position).z)
				arg_17_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_17_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_17_1.actors_["1072ui_story"].transform.localEulerAngles = arg_17_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_17_1.time_ >= 0 + var_20_0 and arg_17_1.time_ < 0 + var_20_0 + arg_20_0 then
				arg_17_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_17_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_17_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["1072ui_story"].transform.position).z)
				arg_17_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_17_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_17_1.actors_["1072ui_story"].transform.localEulerAngles = arg_17_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			local var_20_1 = arg_17_1.actors_["1072ui_story"]

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(var_20_1) and arg_17_1.var_.characterEffect1072ui_story == nil then
				arg_17_1.var_.characterEffect1072ui_story = var_20_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_2 = 0.200000002980232

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_2 and not isNil(var_20_1) then
				if arg_17_1.var_.characterEffect1072ui_story and not isNil(var_20_1) then
					arg_17_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_17_1.time_ >= 0 + var_20_2 and arg_17_1.time_ < 0 + var_20_2 + arg_20_0 and not isNil(var_20_1) and arg_17_1.var_.characterEffect1072ui_story then
				arg_17_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072actionlink/1072action453")
			end

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_20_4 = 0
			local var_20_5 = 0.725

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_4 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_6 = arg_17_1:GetWordFromCfg(221031004)
				local var_20_7 = arg_17_1:FormatText(var_20_6.content)

				arg_17_1.text_.text = var_20_7

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_9 = 29 <= 0 and var_20_5 or var_20_5 * (utf8.len(var_20_7) / 29)

				if (29 <= 0 and var_20_5 or var_20_5 * (utf8.len(var_20_7) / 29)) > 0 and var_20_5 < var_20_9 then
					arg_17_1.talkMaxDuration = var_20_9

					if var_20_9 + var_20_4 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_9 + var_20_4
					end
				end

				arg_17_1.text_.text = var_20_7
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221031", "221031004", "story_v_out_221031.awb") ~= 0 then
					local var_20_10 = manager.audio:GetVoiceLength("story_v_out_221031", "221031004", "story_v_out_221031.awb") / 1000

					if var_20_10 + var_20_4 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_10 + var_20_4
					end

					if var_20_6.prefab_name ~= "" and arg_17_1.actors_[var_20_6.prefab_name] ~= nil then
						local var_20_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_6.prefab_name].transform, "story_v_out_221031", "221031004", "story_v_out_221031.awb")

						arg_17_1:RecordAudio("221031004", var_20_11)
						arg_17_1:RecordAudio("221031004", var_20_11)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_221031", "221031004", "story_v_out_221031.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_221031", "221031004", "story_v_out_221031.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_12 = math.max(var_20_5, arg_17_1.talkMaxDuration)

			if var_20_4 <= arg_17_1.time_ and arg_17_1.time_ < var_20_4 + var_20_12 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_4) / var_20_12

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_4 + var_20_12 and arg_17_1.time_ < var_20_4 + var_20_12 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
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
	Play221031005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 221031005
		arg_21_1.duration_ = 5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play221031006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.var_.moveOldPos1072ui_story = arg_21_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_24_0 = 0.001

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_0 then
				arg_21_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos1072ui_story, Vector3.New(0, 100, 0), (arg_21_1.time_ - 0) / var_24_0)
				arg_21_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_21_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["1072ui_story"].transform.position).z)
				arg_21_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_21_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_21_1.actors_["1072ui_story"].transform.localEulerAngles = arg_21_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_21_1.time_ >= 0 + var_24_0 and arg_21_1.time_ < 0 + var_24_0 + arg_24_0 then
				arg_21_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_21_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_21_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["1072ui_story"].transform.position).z)
				arg_21_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_21_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_21_1.actors_["1072ui_story"].transform.localEulerAngles = arg_21_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			local var_24_1 = arg_21_1.actors_["1072ui_story"]

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(var_24_1) and arg_21_1.var_.characterEffect1072ui_story == nil then
				arg_21_1.var_.characterEffect1072ui_story = var_24_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_2 = 0.200000002980232

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_2 and not isNil(var_24_1) then
				if arg_21_1.var_.characterEffect1072ui_story and not isNil(var_24_1) then
					arg_21_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_21_1.var_.characterEffect1072ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_21_1.time_ - 0) / var_24_2)
				end
			end

			if arg_21_1.time_ >= 0 + var_24_2 and arg_21_1.time_ < 0 + var_24_2 + arg_24_0 and not isNil(var_24_1) and arg_21_1.var_.characterEffect1072ui_story then
				arg_21_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_21_1.var_.characterEffect1072ui_story.fillRatio = 0.5
			end

			local var_24_3 = 0
			local var_24_4 = 1.15

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_3 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, false)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_5 = arg_21_1:FormatText(arg_21_1:GetWordFromCfg(221031005).content)

				arg_21_1.text_.text = var_24_5

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_7 = 46 <= 0 and var_24_4 or var_24_4 * (utf8.len(var_24_5) / 46)

				if (46 <= 0 and var_24_4 or var_24_4 * (utf8.len(var_24_5) / 46)) > 0 and var_24_4 < var_24_7 then
					arg_21_1.talkMaxDuration = var_24_7

					if var_24_7 + var_24_3 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_7 + var_24_3
					end
				end

				arg_21_1.text_.text = var_24_5
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)
				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_8 = math.max(var_24_4, arg_21_1.talkMaxDuration)

			if var_24_3 <= arg_21_1.time_ and arg_21_1.time_ < var_24_3 + var_24_8 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_3) / var_24_8

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_3 + var_24_8 and arg_21_1.time_ < var_24_3 + var_24_8 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
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
	Play221031006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 221031006
		arg_25_1.duration_ = 8.2

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play221031007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if arg_25_1.bgs_.STblack == nil then
				local var_28_0 = Object.Instantiate(arg_25_1.paintGo_)

				var_28_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "STblack")
				var_28_0.name = "STblack"
				var_28_0.transform.parent = arg_25_1.stage_.transform
				var_28_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_25_1.bgs_.STblack = var_28_0
			end

			if 2 < arg_25_1.time_ and arg_25_1.time_ <= 2 + arg_28_0 then
				local var_28_1 = arg_25_1.bgs_.STblack

				arg_25_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_28_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_28_2 = var_28_1:GetComponent("SpriteRenderer")

				if var_28_2 and var_28_2.sprite then
					local var_28_3 = 2 * (var_28_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_28_1.transform.localScale = Vector3.New(var_28_3 / var_28_2.sprite.bounds.size.y < var_28_3 * manager.ui.mainCameraCom_.aspect / var_28_2.sprite.bounds.size.x and var_28_3 * manager.ui.mainCameraCom_.aspect / var_28_2.sprite.bounds.size.x or var_28_3 / var_28_2.sprite.bounds.size.y, var_28_3 / var_28_2.sprite.bounds.size.y < var_28_3 * manager.ui.mainCameraCom_.aspect / var_28_2.sprite.bounds.size.x and var_28_3 * manager.ui.mainCameraCom_.aspect / var_28_2.sprite.bounds.size.x or var_28_3 / var_28_2.sprite.bounds.size.y, 0)
				end

				for iter_28_0, iter_28_1 in pairs(arg_25_1.bgs_) do
					if iter_28_0 ~= "STblack" then
						iter_28_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_28_4 = 0

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_4 + arg_28_0 then
				arg_25_1.mask_.enabled = true
				arg_25_1.mask_.raycastTarget = true

				arg_25_1:SetGaussion(false)
			end

			local var_28_5 = 2

			if var_28_4 <= arg_25_1.time_ and arg_25_1.time_ < var_28_4 + var_28_5 then
				local var_28_6 = Color.New(0, 0, 0)

				var_28_6.a = Mathf.Lerp(0, 1, (arg_25_1.time_ - var_28_4) / var_28_5)
				arg_25_1.mask_.color = var_28_6
			end

			if arg_25_1.time_ >= var_28_4 + var_28_5 and arg_25_1.time_ < var_28_4 + var_28_5 + arg_28_0 then
				local var_28_7 = Color.New(0, 0, 0)

				var_28_7.a = 1
				arg_25_1.mask_.color = var_28_7
			end

			local var_28_8 = 2

			if 2 < arg_25_1.time_ and arg_25_1.time_ <= var_28_8 + arg_28_0 then
				arg_25_1.mask_.enabled = true
				arg_25_1.mask_.raycastTarget = true

				arg_25_1:SetGaussion(false)
			end

			local var_28_9 = 2

			if var_28_8 <= arg_25_1.time_ and arg_25_1.time_ < var_28_8 + var_28_9 then
				local var_28_10 = Color.New(0, 0, 0)

				var_28_10.a = Mathf.Lerp(1, 0, (arg_25_1.time_ - var_28_8) / var_28_9)
				arg_25_1.mask_.color = var_28_10
			end

			if arg_25_1.time_ >= var_28_8 + var_28_9 and arg_25_1.time_ < var_28_8 + var_28_9 + arg_28_0 then
				local var_28_11 = Color.New(0, 0, 0)

				arg_25_1.mask_.enabled = false
				var_28_11.a = 0
				arg_25_1.mask_.color = var_28_11
			end

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.fswbg_:SetActive(true)
				arg_25_1.dialog_:SetActive(false)

				arg_25_1.fswtw_.percent = 0
				arg_25_1.fswt_.text = arg_25_1:FormatText(arg_25_1:GetWordFromCfg(221031006).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.fswt_)

				arg_25_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_25_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_25_1.fswtw_:SetDirty()

				arg_25_1.typewritterCharCountI18N = 0

				SetActive(arg_25_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_25_1:ShowNextGo(false)
			end

			local var_28_12 = 4

			if 4 < arg_25_1.time_ and arg_25_1.time_ <= var_28_12 + arg_28_0 then
				arg_25_1.var_.oldValueTypewriter = arg_25_1.fswtw_.percent

				SetActive(arg_25_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_25_1:ShowNextGo(false)
			end

			local var_28_13 = 63
			local var_28_14 = 4.2
			local var_28_15, var_28_16 = arg_25_1:GetPercentByPara(arg_25_1:FormatText(arg_25_1:GetWordFromCfg(221031006).content), 1)

			if var_28_12 < arg_25_1.time_ and arg_25_1.time_ <= var_28_12 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0

				local var_28_17 = var_28_13 <= 0 and var_28_14 or var_28_14 * ((var_28_16 - arg_25_1.typewritterCharCountI18N) / var_28_13)

				if (var_28_13 <= 0 and var_28_14 or var_28_14 * ((var_28_16 - arg_25_1.typewritterCharCountI18N) / var_28_13)) > 0 and var_28_14 < var_28_17 then
					arg_25_1.talkMaxDuration = var_28_17

					if var_28_17 + var_28_12 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_17 + var_28_12
					end
				end
			end

			local var_28_18 = math.max(4.2, arg_25_1.talkMaxDuration)

			if var_28_12 <= arg_25_1.time_ and arg_25_1.time_ < var_28_12 + var_28_18 then
				arg_25_1.fswtw_.percent = Mathf.Lerp(arg_25_1.var_.oldValueTypewriter, var_28_15, (arg_25_1.time_ - var_28_12) / var_28_18)
				arg_25_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_25_1.fswtw_:SetDirty()
			end

			if arg_25_1.time_ >= var_28_12 + var_28_18 and arg_25_1.time_ < var_28_12 + var_28_18 + arg_28_0 then
				arg_25_1.fswtw_.percent = var_28_15

				arg_25_1.fswtw_:SetDirty()
				arg_25_1:ShowNextGo(true)

				arg_25_1.typewritterCharCountI18N = var_28_16
			end

			if 4 < arg_25_1.time_ and arg_25_1.time_ <= 4 + arg_28_0 then
				local var_28_19 = arg_25_1.fswbg_.transform:Find("textbox/adapt/content") or arg_25_1.fswbg_.transform:Find("textbox/content")
				local var_28_20 = arg_25_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_28_21 = var_28_19:GetComponent("RectTransform")

				var_28_19:GetComponent("Text").alignment = UnityEngine.TextAnchor.MiddleCenter
				var_28_21.offsetMin = Vector2.New(0, 0)
				var_28_21.offsetMax = Vector2.New(0, 0)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play221031007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 221031007
		arg_29_1.duration_ = 16.6

		local var_29_0 = {
			ja = 16.6,
			ko = 15.8,
			zh = 15.8
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
				arg_29_0:Play221031008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if arg_29_1.bgs_.ST29 == nil then
				local var_32_0 = Object.Instantiate(arg_29_1.paintGo_)

				var_32_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST29")
				var_32_0.name = "ST29"
				var_32_0.transform.parent = arg_29_1.stage_.transform
				var_32_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_29_1.bgs_.ST29 = var_32_0
			end

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				local var_32_1 = arg_29_1.bgs_.ST29

				arg_29_1.bgs_.ST29.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_32_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_32_2 = var_32_1:GetComponent("SpriteRenderer")

				if var_32_2 and var_32_2.sprite then
					local var_32_3 = 2 * (var_32_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_32_1.transform.localScale = Vector3.New(var_32_3 / var_32_2.sprite.bounds.size.y < var_32_3 * manager.ui.mainCameraCom_.aspect / var_32_2.sprite.bounds.size.x and var_32_3 * manager.ui.mainCameraCom_.aspect / var_32_2.sprite.bounds.size.x or var_32_3 / var_32_2.sprite.bounds.size.y, var_32_3 / var_32_2.sprite.bounds.size.y < var_32_3 * manager.ui.mainCameraCom_.aspect / var_32_2.sprite.bounds.size.x and var_32_3 * manager.ui.mainCameraCom_.aspect / var_32_2.sprite.bounds.size.x or var_32_3 / var_32_2.sprite.bounds.size.y, 0)
				end

				for iter_32_0, iter_32_1 in pairs(arg_29_1.bgs_) do
					if iter_32_0 ~= "ST29" then
						iter_32_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_32_4 = 0

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_4 + arg_32_0 then
				arg_29_1.mask_.enabled = true
				arg_29_1.mask_.raycastTarget = true

				arg_29_1:SetGaussion(false)
			end

			local var_32_5 = 2

			if var_32_4 <= arg_29_1.time_ and arg_29_1.time_ < var_32_4 + var_32_5 then
				local var_32_6 = Color.New(0, 0, 0)

				var_32_6.a = Mathf.Lerp(1, 0, (arg_29_1.time_ - var_32_4) / var_32_5)
				arg_29_1.mask_.color = var_32_6
			end

			if arg_29_1.time_ >= var_32_4 + var_32_5 and arg_29_1.time_ < var_32_4 + var_32_5 + arg_32_0 then
				local var_32_7 = Color.New(0, 0, 0)

				arg_29_1.mask_.enabled = false
				var_32_7.a = 0
				arg_29_1.mask_.color = var_32_7
			end

			local var_32_8 = 0

			arg_29_1.isInRecall_ = false

			if var_32_8 < arg_29_1.time_ and arg_29_1.time_ <= var_32_8 + arg_32_0 then
				arg_29_1.screenFilterGo_:SetActive(true)

				arg_29_1.screenFilterEffect_.profile = Asset.Load("Effect/Scene/fx_vintageStyle_Profile")

				for iter_32_2, iter_32_3 in pairs(arg_29_1.actors_) do
					for iter_32_4, iter_32_5 in ipairs((iter_32_3:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_32_5.color = iter_32_5.color.r > 0.51 and Color.New(1, 1, 1) or Color.New(0.5, 0.5, 0.5)
					end
				end
			end

			local var_32_9 = 0.0166666666666667

			if var_32_8 <= arg_29_1.time_ and arg_29_1.time_ < var_32_8 + var_32_9 then
				arg_29_1.screenFilterEffect_.weight = Mathf.Lerp(0, 1, (arg_29_1.time_ - var_32_8) / var_32_9)
			end

			if arg_29_1.time_ >= var_32_8 + var_32_9 and arg_29_1.time_ < var_32_8 + var_32_9 + arg_32_0 then
				arg_29_1.screenFilterEffect_.weight = 1
			end

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.fswbg_:SetActive(false)
				arg_29_1.dialog_:SetActive(false)
				SetActive(arg_29_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_29_1:ShowNextGo(false)
			end

			if arg_29_1.frameCnt_ <= 1 then
				arg_29_1.dialog_:SetActive(false)
			end

			local var_32_10 = 2
			local var_32_11 = 1.35

			if 2 < arg_29_1.time_ and arg_29_1.time_ <= var_32_10 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0

				arg_29_1.dialog_:SetActive(true)

				arg_29_1.dialogCg_.alpha = 0

				local var_32_12 = LeanTween.value(arg_29_1.dialog_, 0, 1, 0.3)

				var_32_12:setOnUpdate(LuaHelper.FloatAction(function(arg_33_0)
					arg_29_1.dialogCg_.alpha = arg_33_0
				end))
				var_32_12:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_29_1.dialog_)
					var_32_12:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_29_1.duration_ = arg_29_1.duration_ + 0.3

				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[421].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, true)
				arg_29_1.iconController_:SetSelectedState("hero")

				arg_29_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossm")

				arg_29_1.callingController_:SetSelectedState("normal")

				arg_29_1.keyicon_.color = Color.New(1, 1, 1)
				arg_29_1.icon_.color = Color.New(1, 1, 1)

				local var_32_13 = arg_29_1:GetWordFromCfg(221031007)
				local var_32_14 = arg_29_1:FormatText(var_32_13.content)

				arg_29_1.text_.text = var_32_14

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_16 = 54 <= 0 and var_32_11 or var_32_11 * (utf8.len(var_32_14) / 54)

				if (54 <= 0 and var_32_11 or var_32_11 * (utf8.len(var_32_14) / 54)) > 0 and var_32_11 < var_32_16 then
					arg_29_1.talkMaxDuration = var_32_16
					var_32_10 = var_32_10 + 0.3

					if var_32_16 + var_32_10 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_16 + var_32_10
					end
				end

				arg_29_1.text_.text = var_32_14
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221031", "221031007", "story_v_out_221031.awb") ~= 0 then
					local var_32_17 = manager.audio:GetVoiceLength("story_v_out_221031", "221031007", "story_v_out_221031.awb") / 1000

					if var_32_17 + var_32_10 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_17 + var_32_10
					end

					if var_32_13.prefab_name ~= "" and arg_29_1.actors_[var_32_13.prefab_name] ~= nil then
						local var_32_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_13.prefab_name].transform, "story_v_out_221031", "221031007", "story_v_out_221031.awb")

						arg_29_1:RecordAudio("221031007", var_32_18)
						arg_29_1:RecordAudio("221031007", var_32_18)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_221031", "221031007", "story_v_out_221031.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_221031", "221031007", "story_v_out_221031.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_19 = var_32_10 + 0.3
			local var_32_20 = math.max(var_32_11, arg_29_1.talkMaxDuration)

			if var_32_10 + 0.3 <= arg_29_1.time_ and arg_29_1.time_ < var_32_19 + var_32_20 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_19) / var_32_20

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_19 + var_32_20 and arg_29_1.time_ < var_32_19 + var_32_20 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play221031008 = function(arg_35_0, arg_35_1)
		arg_35_1.time_ = 0
		arg_35_1.frameCnt_ = 0
		arg_35_1.state_ = "playing"
		arg_35_1.curTalkId_ = 221031008
		arg_35_1.duration_ = 17.53

		local var_35_0 = {
			ja = 17.533,
			ko = 15.6,
			zh = 15.6
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
				arg_35_0:Play221031009(arg_35_1)
			end
		end

		function arg_35_1.onSingleLineUpdate_(arg_38_0)
			local var_38_0 = 1.45

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 then
				arg_35_1.talkMaxDuration = 0
				arg_35_1.dialogCg_.alpha = 1

				arg_35_1.dialog_:SetActive(true)
				SetActive(arg_35_1.leftNameGo_, true)

				arg_35_1.leftNameTxt_.text = arg_35_1:FormatText(StoryNameCfg[421].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_35_1.leftNameTxt_.transform)

				arg_35_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_35_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_35_1:RecordName(arg_35_1.leftNameTxt_.text)
				SetActive(arg_35_1.iconTrs_.gameObject, true)
				arg_35_1.iconController_:SetSelectedState("hero")

				arg_35_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossm")

				arg_35_1.callingController_:SetSelectedState("normal")

				arg_35_1.keyicon_.color = Color.New(1, 1, 1)
				arg_35_1.icon_.color = Color.New(1, 1, 1)

				local var_38_1 = arg_35_1:GetWordFromCfg(221031008)
				local var_38_2 = arg_35_1:FormatText(var_38_1.content)

				arg_35_1.text_.text = var_38_2

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_4 = 58 <= 0 and var_38_0 or var_38_0 * (utf8.len(var_38_2) / 58)

				if (58 <= 0 and var_38_0 or var_38_0 * (utf8.len(var_38_2) / 58)) > 0 and var_38_0 < var_38_4 then
					arg_35_1.talkMaxDuration = var_38_4

					if var_38_4 + 0 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_4 + 0
					end
				end

				arg_35_1.text_.text = var_38_2
				arg_35_1.typewritter.percent = 0

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221031", "221031008", "story_v_out_221031.awb") ~= 0 then
					local var_38_5 = manager.audio:GetVoiceLength("story_v_out_221031", "221031008", "story_v_out_221031.awb") / 1000

					if var_38_5 + 0 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_5 + 0
					end

					if var_38_1.prefab_name ~= "" and arg_35_1.actors_[var_38_1.prefab_name] ~= nil then
						local var_38_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_35_1.actors_[var_38_1.prefab_name].transform, "story_v_out_221031", "221031008", "story_v_out_221031.awb")

						arg_35_1:RecordAudio("221031008", var_38_6)
						arg_35_1:RecordAudio("221031008", var_38_6)
					else
						arg_35_1:AudioAction("play", "voice", "story_v_out_221031", "221031008", "story_v_out_221031.awb")
					end

					arg_35_1:RecordHistoryTalkVoice("story_v_out_221031", "221031008", "story_v_out_221031.awb")
				end

				arg_35_1:RecordContent(arg_35_1.text_.text)
			end

			local var_38_7 = math.max(var_38_0, arg_35_1.talkMaxDuration)

			if 0 <= arg_35_1.time_ and arg_35_1.time_ < 0 + var_38_7 then
				arg_35_1.typewritter.percent = (arg_35_1.time_ - 0) / var_38_7

				arg_35_1.typewritter:SetDirty()
			end

			if arg_35_1.time_ >= 0 + var_38_7 and arg_35_1.time_ < 0 + var_38_7 + arg_38_0 then
				arg_35_1.typewritter.percent = 1

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(true)
			end
		end

		arg_35_1.nodeConfigList_ = {}

		arg_35_1:InitPlayNodeList()
	end,
	Play221031009 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 221031009
		arg_39_1.duration_ = 10

		local var_39_0 = {
			ja = 9.2,
			ko = 10,
			zh = 10
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
				arg_39_0:Play221031010(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 then
				arg_39_1.var_.moveOldPos1072ui_story = arg_39_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_42_0 = 0.001

			if 0 <= arg_39_1.time_ and arg_39_1.time_ < 0 + var_42_0 then
				arg_39_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_39_1.var_.moveOldPos1072ui_story, Vector3.New(-0.7, -0.71, -6), (arg_39_1.time_ - 0) / var_42_0)
				arg_39_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_39_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_39_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_39_1.actors_["1072ui_story"].transform.position).z)
				arg_39_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_39_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_39_1.actors_["1072ui_story"].transform.localEulerAngles = arg_39_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_39_1.time_ >= 0 + var_42_0 and arg_39_1.time_ < 0 + var_42_0 + arg_42_0 then
				arg_39_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(-0.7, -0.71, -6)
				arg_39_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_39_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_39_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_39_1.actors_["1072ui_story"].transform.position).z)
				arg_39_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_39_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_39_1.actors_["1072ui_story"].transform.localEulerAngles = arg_39_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			local var_42_1 = arg_39_1.actors_["1072ui_story"]

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 and not isNil(var_42_1) and arg_39_1.var_.characterEffect1072ui_story == nil then
				arg_39_1.var_.characterEffect1072ui_story = var_42_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_42_2 = 0.200000002980232

			if 0 <= arg_39_1.time_ and arg_39_1.time_ < 0 + var_42_2 and not isNil(var_42_1) then
				if arg_39_1.var_.characterEffect1072ui_story and not isNil(var_42_1) then
					arg_39_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_39_1.time_ >= 0 + var_42_2 and arg_39_1.time_ < 0 + var_42_2 + arg_42_0 and not isNil(var_42_1) and arg_39_1.var_.characterEffect1072ui_story then
				arg_39_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 then
				arg_39_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action1_1")
			end

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 then
				arg_39_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_42_4 = 0
			local var_42_5 = 1.15

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= var_42_4 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0
				arg_39_1.dialogCg_.alpha = 1

				arg_39_1.dialog_:SetActive(true)
				SetActive(arg_39_1.leftNameGo_, true)

				arg_39_1.leftNameTxt_.text = arg_39_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_39_1.leftNameTxt_.transform)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1.leftNameTxt_.text)
				SetActive(arg_39_1.iconTrs_.gameObject, false)
				arg_39_1.callingController_:SetSelectedState("normal")

				local var_42_6 = arg_39_1:GetWordFromCfg(221031009)
				local var_42_7 = arg_39_1:FormatText(var_42_6.content)

				arg_39_1.text_.text = var_42_7

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_9 = 46 <= 0 and var_42_5 or var_42_5 * (utf8.len(var_42_7) / 46)

				if (46 <= 0 and var_42_5 or var_42_5 * (utf8.len(var_42_7) / 46)) > 0 and var_42_5 < var_42_9 then
					arg_39_1.talkMaxDuration = var_42_9

					if var_42_9 + var_42_4 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_9 + var_42_4
					end
				end

				arg_39_1.text_.text = var_42_7
				arg_39_1.typewritter.percent = 0

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221031", "221031009", "story_v_out_221031.awb") ~= 0 then
					local var_42_10 = manager.audio:GetVoiceLength("story_v_out_221031", "221031009", "story_v_out_221031.awb") / 1000

					if var_42_10 + var_42_4 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_10 + var_42_4
					end

					if var_42_6.prefab_name ~= "" and arg_39_1.actors_[var_42_6.prefab_name] ~= nil then
						local var_42_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_39_1.actors_[var_42_6.prefab_name].transform, "story_v_out_221031", "221031009", "story_v_out_221031.awb")

						arg_39_1:RecordAudio("221031009", var_42_11)
						arg_39_1:RecordAudio("221031009", var_42_11)
					else
						arg_39_1:AudioAction("play", "voice", "story_v_out_221031", "221031009", "story_v_out_221031.awb")
					end

					arg_39_1:RecordHistoryTalkVoice("story_v_out_221031", "221031009", "story_v_out_221031.awb")
				end

				arg_39_1:RecordContent(arg_39_1.text_.text)
			end

			local var_42_12 = math.max(var_42_5, arg_39_1.talkMaxDuration)

			if var_42_4 <= arg_39_1.time_ and arg_39_1.time_ < var_42_4 + var_42_12 then
				arg_39_1.typewritter.percent = (arg_39_1.time_ - var_42_4) / var_42_12

				arg_39_1.typewritter:SetDirty()
			end

			if arg_39_1.time_ >= var_42_4 + var_42_12 and arg_39_1.time_ < var_42_4 + var_42_12 + arg_42_0 then
				arg_39_1.typewritter.percent = 1

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(true)
			end
		end

		arg_39_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_39_1:InitPlayNodeList()
	end,
	Play221031010 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 221031010
		arg_43_1.duration_ = 10.13

		local var_43_0 = {
			ja = 10.133,
			ko = 7.6,
			zh = 7.6
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
				arg_43_0:Play221031011(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			if arg_43_1.actors_["1074ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1074ui_story"))) then
				local var_46_0 = Object.Instantiate(Asset.Load("Char/" .. "1074ui_story"), arg_43_1.stage_.transform)

				var_46_0.name = "1074ui_story"
				var_46_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_43_1.actors_["1074ui_story"] = var_46_0

				local var_46_1 = var_46_0:GetComponentInChildren(typeof(CharacterEffect))

				var_46_1.enabled = true

				local var_46_2 = GameObjectTools.GetOrAddComponent(var_46_0, typeof(DynamicBoneHelper))

				if var_46_2 then
					var_46_2:EnableDynamicBone(false)
				end

				arg_43_1:ShowWeapon(var_46_1.transform, false)

				arg_43_1.var_["1074ui_story" .. "Animator"] = var_46_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_43_1.var_["1074ui_story" .. "Animator"].applyRootMotion = true
				arg_43_1.var_["1074ui_story" .. "LipSync"] = var_46_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_46_3 = arg_43_1.actors_["1074ui_story"].transform

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				arg_43_1.var_.moveOldPos1074ui_story = var_46_3.localPosition
			end

			local var_46_4 = 0.001

			if 0 <= arg_43_1.time_ and arg_43_1.time_ < 0 + var_46_4 then
				var_46_3.localPosition = Vector3.Lerp(arg_43_1.var_.moveOldPos1074ui_story, Vector3.New(0.7, -1.055, -6.12), (arg_43_1.time_ - 0) / var_46_4)
				var_46_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_46_3.position).x, (manager.ui.mainCamera.transform.position - var_46_3.position).y, (manager.ui.mainCamera.transform.position - var_46_3.position).z)
				var_46_3.localEulerAngles.z = 0
				var_46_3.localEulerAngles.x = 0
				var_46_3.localEulerAngles = var_46_3.localEulerAngles
			end

			if arg_43_1.time_ >= 0 + var_46_4 and arg_43_1.time_ < 0 + var_46_4 + arg_46_0 then
				var_46_3.localPosition = Vector3.New(0.7, -1.055, -6.12)
				var_46_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_46_3.position).x, (manager.ui.mainCamera.transform.position - var_46_3.position).y, (manager.ui.mainCamera.transform.position - var_46_3.position).z)
				var_46_3.localEulerAngles.z = 0
				var_46_3.localEulerAngles.x = 0
				var_46_3.localEulerAngles = var_46_3.localEulerAngles
			end

			local var_46_5 = arg_43_1.actors_["1074ui_story"]

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 and not isNil(var_46_5) and arg_43_1.var_.characterEffect1074ui_story == nil then
				arg_43_1.var_.characterEffect1074ui_story = var_46_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_46_6 = 0.200000002980232

			if 0 <= arg_43_1.time_ and arg_43_1.time_ < 0 + var_46_6 and not isNil(var_46_5) then
				if arg_43_1.var_.characterEffect1074ui_story and not isNil(var_46_5) then
					arg_43_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_43_1.time_ >= 0 + var_46_6 and arg_43_1.time_ < 0 + var_46_6 + arg_46_0 and not isNil(var_46_5) and arg_43_1.var_.characterEffect1074ui_story then
				arg_43_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				arg_43_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action1_1")
			end

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				arg_43_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_46_8 = arg_43_1.actors_["1072ui_story"]

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 and not isNil(var_46_8) and arg_43_1.var_.characterEffect1072ui_story == nil then
				arg_43_1.var_.characterEffect1072ui_story = var_46_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_46_9 = 0.200000002980232

			if 0 <= arg_43_1.time_ and arg_43_1.time_ < 0 + var_46_9 and not isNil(var_46_8) then
				if arg_43_1.var_.characterEffect1072ui_story and not isNil(var_46_8) then
					arg_43_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_43_1.var_.characterEffect1072ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_43_1.time_ - 0) / var_46_9)
				end
			end

			if arg_43_1.time_ >= 0 + var_46_9 and arg_43_1.time_ < 0 + var_46_9 + arg_46_0 and not isNil(var_46_8) and arg_43_1.var_.characterEffect1072ui_story then
				arg_43_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_43_1.var_.characterEffect1072ui_story.fillRatio = 0.5
			end

			local var_46_10 = 0
			local var_46_11 = 1.025

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= var_46_10 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0
				arg_43_1.dialogCg_.alpha = 1

				arg_43_1.dialog_:SetActive(true)
				SetActive(arg_43_1.leftNameGo_, true)

				arg_43_1.leftNameTxt_.text = arg_43_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_43_1.leftNameTxt_.transform)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1.leftNameTxt_.text)
				SetActive(arg_43_1.iconTrs_.gameObject, false)
				arg_43_1.callingController_:SetSelectedState("normal")

				local var_46_12 = arg_43_1:GetWordFromCfg(221031010)
				local var_46_13 = arg_43_1:FormatText(var_46_12.content)

				arg_43_1.text_.text = var_46_13

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_15 = 41 <= 0 and var_46_11 or var_46_11 * (utf8.len(var_46_13) / 41)

				if (41 <= 0 and var_46_11 or var_46_11 * (utf8.len(var_46_13) / 41)) > 0 and var_46_11 < var_46_15 then
					arg_43_1.talkMaxDuration = var_46_15

					if var_46_15 + var_46_10 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_15 + var_46_10
					end
				end

				arg_43_1.text_.text = var_46_13
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221031", "221031010", "story_v_out_221031.awb") ~= 0 then
					local var_46_16 = manager.audio:GetVoiceLength("story_v_out_221031", "221031010", "story_v_out_221031.awb") / 1000

					if var_46_16 + var_46_10 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_16 + var_46_10
					end

					if var_46_12.prefab_name ~= "" and arg_43_1.actors_[var_46_12.prefab_name] ~= nil then
						local var_46_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_43_1.actors_[var_46_12.prefab_name].transform, "story_v_out_221031", "221031010", "story_v_out_221031.awb")

						arg_43_1:RecordAudio("221031010", var_46_17)
						arg_43_1:RecordAudio("221031010", var_46_17)
					else
						arg_43_1:AudioAction("play", "voice", "story_v_out_221031", "221031010", "story_v_out_221031.awb")
					end

					arg_43_1:RecordHistoryTalkVoice("story_v_out_221031", "221031010", "story_v_out_221031.awb")
				end

				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_18 = math.max(var_46_11, arg_43_1.talkMaxDuration)

			if var_46_10 <= arg_43_1.time_ and arg_43_1.time_ < var_46_10 + var_46_18 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - var_46_10) / var_46_18

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= var_46_10 + var_46_18 and arg_43_1.time_ < var_46_10 + var_46_18 + arg_46_0 then
				arg_43_1.typewritter.percent = 1

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(true)
			end
		end

		arg_43_1.nodeConfigList_ = {
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

		arg_43_1:InitPlayNodeList()
	end,
	Play221031011 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 221031011
		arg_47_1.duration_ = 13.67

		local var_47_0 = {
			ja = 13.666,
			ko = 11.766,
			zh = 11.766
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
				arg_47_0:Play221031012(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			if 2 < arg_47_1.time_ and arg_47_1.time_ <= 2 + arg_50_0 then
				local var_50_0 = arg_47_1.bgs_.ST31

				arg_47_1.bgs_.ST31.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_50_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_50_1 = var_50_0:GetComponent("SpriteRenderer")

				if var_50_1 and var_50_1.sprite then
					local var_50_2 = 2 * (var_50_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_50_0.transform.localScale = Vector3.New(var_50_2 / var_50_1.sprite.bounds.size.y < var_50_2 * manager.ui.mainCameraCom_.aspect / var_50_1.sprite.bounds.size.x and var_50_2 * manager.ui.mainCameraCom_.aspect / var_50_1.sprite.bounds.size.x or var_50_2 / var_50_1.sprite.bounds.size.y, var_50_2 / var_50_1.sprite.bounds.size.y < var_50_2 * manager.ui.mainCameraCom_.aspect / var_50_1.sprite.bounds.size.x and var_50_2 * manager.ui.mainCameraCom_.aspect / var_50_1.sprite.bounds.size.x or var_50_2 / var_50_1.sprite.bounds.size.y, 0)
				end

				for iter_50_0, iter_50_1 in pairs(arg_47_1.bgs_) do
					if iter_50_0 ~= "ST31" then
						iter_50_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_50_3 = 0

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= var_50_3 + arg_50_0 then
				arg_47_1.mask_.enabled = true
				arg_47_1.mask_.raycastTarget = true

				arg_47_1:SetGaussion(false)
			end

			local var_50_4 = 2

			if var_50_3 <= arg_47_1.time_ and arg_47_1.time_ < var_50_3 + var_50_4 then
				local var_50_5 = Color.New(0, 0, 0)

				var_50_5.a = Mathf.Lerp(0, 1, (arg_47_1.time_ - var_50_3) / var_50_4)
				arg_47_1.mask_.color = var_50_5
			end

			if arg_47_1.time_ >= var_50_3 + var_50_4 and arg_47_1.time_ < var_50_3 + var_50_4 + arg_50_0 then
				local var_50_6 = Color.New(0, 0, 0)

				var_50_6.a = 1
				arg_47_1.mask_.color = var_50_6
			end

			local var_50_7 = 2

			if 2 < arg_47_1.time_ and arg_47_1.time_ <= var_50_7 + arg_50_0 then
				arg_47_1.mask_.enabled = true
				arg_47_1.mask_.raycastTarget = true

				arg_47_1:SetGaussion(false)
			end

			local var_50_8 = 2

			if var_50_7 <= arg_47_1.time_ and arg_47_1.time_ < var_50_7 + var_50_8 then
				local var_50_9 = Color.New(0, 0, 0)

				var_50_9.a = Mathf.Lerp(1, 0, (arg_47_1.time_ - var_50_7) / var_50_8)
				arg_47_1.mask_.color = var_50_9
			end

			if arg_47_1.time_ >= var_50_7 + var_50_8 and arg_47_1.time_ < var_50_7 + var_50_8 + arg_50_0 then
				local var_50_10 = Color.New(0, 0, 0)

				arg_47_1.mask_.enabled = false
				var_50_10.a = 0
				arg_47_1.mask_.color = var_50_10
			end

			local var_50_11 = arg_47_1.actors_["1072ui_story"].transform

			if 4 < arg_47_1.time_ and arg_47_1.time_ <= 4 + arg_50_0 then
				arg_47_1.var_.moveOldPos1072ui_story = var_50_11.localPosition
			end

			local var_50_12 = 0.001

			if 4 <= arg_47_1.time_ and arg_47_1.time_ < 4 + var_50_12 then
				var_50_11.localPosition = Vector3.Lerp(arg_47_1.var_.moveOldPos1072ui_story, Vector3.New(0, -0.71, -6), (arg_47_1.time_ - 4) / var_50_12)
				var_50_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_50_11.position).x, (manager.ui.mainCamera.transform.position - var_50_11.position).y, (manager.ui.mainCamera.transform.position - var_50_11.position).z)
				var_50_11.localEulerAngles.z = 0
				var_50_11.localEulerAngles.x = 0
				var_50_11.localEulerAngles = var_50_11.localEulerAngles
			end

			if arg_47_1.time_ >= 4 + var_50_12 and arg_47_1.time_ < 4 + var_50_12 + arg_50_0 then
				var_50_11.localPosition = Vector3.New(0, -0.71, -6)
				var_50_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_50_11.position).x, (manager.ui.mainCamera.transform.position - var_50_11.position).y, (manager.ui.mainCamera.transform.position - var_50_11.position).z)
				var_50_11.localEulerAngles.z = 0
				var_50_11.localEulerAngles.x = 0
				var_50_11.localEulerAngles = var_50_11.localEulerAngles
			end

			local var_50_13 = arg_47_1.actors_["1072ui_story"]

			if 4 < arg_47_1.time_ and arg_47_1.time_ <= 4 + arg_50_0 and not isNil(var_50_13) and arg_47_1.var_.characterEffect1072ui_story == nil then
				arg_47_1.var_.characterEffect1072ui_story = var_50_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_50_14 = 0.200000002980232

			if 4 <= arg_47_1.time_ and arg_47_1.time_ < 4 + var_50_14 and not isNil(var_50_13) then
				if arg_47_1.var_.characterEffect1072ui_story and not isNil(var_50_13) then
					arg_47_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_47_1.time_ >= 4 + var_50_14 and arg_47_1.time_ < 4 + var_50_14 + arg_50_0 and not isNil(var_50_13) and arg_47_1.var_.characterEffect1072ui_story then
				arg_47_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			if 4 < arg_47_1.time_ and arg_47_1.time_ <= 4 + arg_50_0 then
				arg_47_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action7_1")
			end

			if 4 < arg_47_1.time_ and arg_47_1.time_ <= 4 + arg_50_0 then
				arg_47_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_50_16 = arg_47_1.actors_["1074ui_story"].transform

			if 2.01666666666667 < arg_47_1.time_ and arg_47_1.time_ <= 2.01666666666667 + arg_50_0 then
				arg_47_1.var_.moveOldPos1074ui_story = var_50_16.localPosition
			end

			local var_50_17 = 0.001

			if 2.01666666666667 <= arg_47_1.time_ and arg_47_1.time_ < 2.01666666666667 + var_50_17 then
				var_50_16.localPosition = Vector3.Lerp(arg_47_1.var_.moveOldPos1074ui_story, Vector3.New(0, 100, 0), (arg_47_1.time_ - 2.01666666666667) / var_50_17)
				var_50_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_50_16.position).x, (manager.ui.mainCamera.transform.position - var_50_16.position).y, (manager.ui.mainCamera.transform.position - var_50_16.position).z)
				var_50_16.localEulerAngles.z = 0
				var_50_16.localEulerAngles.x = 0
				var_50_16.localEulerAngles = var_50_16.localEulerAngles
			end

			if arg_47_1.time_ >= 2.01666666666667 + var_50_17 and arg_47_1.time_ < 2.01666666666667 + var_50_17 + arg_50_0 then
				var_50_16.localPosition = Vector3.New(0, 100, 0)
				var_50_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_50_16.position).x, (manager.ui.mainCamera.transform.position - var_50_16.position).y, (manager.ui.mainCamera.transform.position - var_50_16.position).z)
				var_50_16.localEulerAngles.z = 0
				var_50_16.localEulerAngles.x = 0
				var_50_16.localEulerAngles = var_50_16.localEulerAngles
			end

			local var_50_18 = arg_47_1.actors_["1074ui_story"]

			if 2.01666666666667 < arg_47_1.time_ and arg_47_1.time_ <= 2.01666666666667 + arg_50_0 and not isNil(var_50_18) and arg_47_1.var_.characterEffect1074ui_story == nil then
				arg_47_1.var_.characterEffect1074ui_story = var_50_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_50_19 = 0.200000002980232

			if 2.01666666666667 <= arg_47_1.time_ and arg_47_1.time_ < 2.01666666666667 + var_50_19 and not isNil(var_50_18) then
				if arg_47_1.var_.characterEffect1074ui_story and not isNil(var_50_18) then
					arg_47_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_47_1.var_.characterEffect1074ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_47_1.time_ - 2.01666666666667) / var_50_19)
				end
			end

			if arg_47_1.time_ >= 2.01666666666667 + var_50_19 and arg_47_1.time_ < 2.01666666666667 + var_50_19 + arg_50_0 and not isNil(var_50_18) and arg_47_1.var_.characterEffect1074ui_story then
				arg_47_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_47_1.var_.characterEffect1074ui_story.fillRatio = 0.5
			end

			local var_50_20 = 2

			arg_47_1.isInRecall_ = false

			if var_50_20 < arg_47_1.time_ and arg_47_1.time_ <= var_50_20 + arg_50_0 then
				arg_47_1.screenFilterGo_:SetActive(false)

				for iter_50_2, iter_50_3 in pairs(arg_47_1.actors_) do
					for iter_50_4, iter_50_5 in ipairs((iter_50_3:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_50_5.color = iter_50_5.color.r > 0.51 and Color.New(1, 1, 1) or Color.New(0.5, 0.5, 0.5)
					end
				end
			end

			local var_50_21 = 0.0166666666666667

			if var_50_20 <= arg_47_1.time_ and arg_47_1.time_ < var_50_20 + var_50_21 then
				arg_47_1.screenFilterEffect_.weight = Mathf.Lerp(1, 0, (arg_47_1.time_ - var_50_20) / var_50_21)
			end

			if arg_47_1.time_ >= var_50_20 + var_50_21 and arg_47_1.time_ < var_50_20 + var_50_21 + arg_50_0 then
				arg_47_1.screenFilterEffect_.weight = 0
			end

			local var_50_22 = arg_47_1.actors_["1072ui_story"].transform

			if 2.01666666666667 < arg_47_1.time_ and arg_47_1.time_ <= 2.01666666666667 + arg_50_0 then
				arg_47_1.var_.moveOldPos1072ui_story = var_50_22.localPosition
			end

			local var_50_23 = 0.001

			if 2.01666666666667 <= arg_47_1.time_ and arg_47_1.time_ < 2.01666666666667 + var_50_23 then
				var_50_22.localPosition = Vector3.Lerp(arg_47_1.var_.moveOldPos1072ui_story, Vector3.New(0, 100, 0), (arg_47_1.time_ - 2.01666666666667) / var_50_23)
				var_50_22.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_50_22.position).x, (manager.ui.mainCamera.transform.position - var_50_22.position).y, (manager.ui.mainCamera.transform.position - var_50_22.position).z)
				var_50_22.localEulerAngles.z = 0
				var_50_22.localEulerAngles.x = 0
				var_50_22.localEulerAngles = var_50_22.localEulerAngles
			end

			if arg_47_1.time_ >= 2.01666666666667 + var_50_23 and arg_47_1.time_ < 2.01666666666667 + var_50_23 + arg_50_0 then
				var_50_22.localPosition = Vector3.New(0, 100, 0)
				var_50_22.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_50_22.position).x, (manager.ui.mainCamera.transform.position - var_50_22.position).y, (manager.ui.mainCamera.transform.position - var_50_22.position).z)
				var_50_22.localEulerAngles.z = 0
				var_50_22.localEulerAngles.x = 0
				var_50_22.localEulerAngles = var_50_22.localEulerAngles
			end

			if arg_47_1.frameCnt_ <= 1 then
				arg_47_1.dialog_:SetActive(false)
			end

			local var_50_24 = 4
			local var_50_25 = 0.95

			if 4 < arg_47_1.time_ and arg_47_1.time_ <= var_50_24 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0

				arg_47_1.dialog_:SetActive(true)

				arg_47_1.dialogCg_.alpha = 0

				local var_50_26 = LeanTween.value(arg_47_1.dialog_, 0, 1, 0.3)

				var_50_26:setOnUpdate(LuaHelper.FloatAction(function(arg_51_0)
					arg_47_1.dialogCg_.alpha = arg_51_0
				end))
				var_50_26:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_47_1.dialog_)
					var_50_26:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_47_1.duration_ = arg_47_1.duration_ + 0.3

				SetActive(arg_47_1.leftNameGo_, true)

				arg_47_1.leftNameTxt_.text = arg_47_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_47_1.leftNameTxt_.transform)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1.leftNameTxt_.text)
				SetActive(arg_47_1.iconTrs_.gameObject, false)
				arg_47_1.callingController_:SetSelectedState("normal")

				local var_50_27 = arg_47_1:GetWordFromCfg(221031011)
				local var_50_28 = arg_47_1:FormatText(var_50_27.content)

				arg_47_1.text_.text = var_50_28

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_30 = 38 <= 0 and var_50_25 or var_50_25 * (utf8.len(var_50_28) / 38)

				if (38 <= 0 and var_50_25 or var_50_25 * (utf8.len(var_50_28) / 38)) > 0 and var_50_25 < var_50_30 then
					arg_47_1.talkMaxDuration = var_50_30
					var_50_24 = var_50_24 + 0.3

					if var_50_30 + var_50_24 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_30 + var_50_24
					end
				end

				arg_47_1.text_.text = var_50_28
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221031", "221031011", "story_v_out_221031.awb") ~= 0 then
					local var_50_31 = manager.audio:GetVoiceLength("story_v_out_221031", "221031011", "story_v_out_221031.awb") / 1000

					if var_50_31 + var_50_24 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_31 + var_50_24
					end

					if var_50_27.prefab_name ~= "" and arg_47_1.actors_[var_50_27.prefab_name] ~= nil then
						local var_50_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_47_1.actors_[var_50_27.prefab_name].transform, "story_v_out_221031", "221031011", "story_v_out_221031.awb")

						arg_47_1:RecordAudio("221031011", var_50_32)
						arg_47_1:RecordAudio("221031011", var_50_32)
					else
						arg_47_1:AudioAction("play", "voice", "story_v_out_221031", "221031011", "story_v_out_221031.awb")
					end

					arg_47_1:RecordHistoryTalkVoice("story_v_out_221031", "221031011", "story_v_out_221031.awb")
				end

				arg_47_1:RecordContent(arg_47_1.text_.text)
			end

			local var_50_33 = var_50_24 + 0.3
			local var_50_34 = math.max(var_50_25, arg_47_1.talkMaxDuration)

			if var_50_24 + 0.3 <= arg_47_1.time_ and arg_47_1.time_ < var_50_33 + var_50_34 then
				arg_47_1.typewritter.percent = (arg_47_1.time_ - var_50_33) / var_50_34

				arg_47_1.typewritter:SetDirty()
			end

			if arg_47_1.time_ >= var_50_33 + var_50_34 and arg_47_1.time_ < var_50_33 + var_50_34 + arg_50_0 then
				arg_47_1.typewritter.percent = 1

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(true)
			end
		end

		arg_47_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 4,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2.01666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2.01666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_47_1:InitPlayNodeList()
	end,
	Play221031012 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 221031012
		arg_53_1.duration_ = 5

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play221031013(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1.var_.moveOldPos1072ui_story = arg_53_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_56_0 = 0.001

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_0 then
				arg_53_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos1072ui_story, Vector3.New(0, 100, 0), (arg_53_1.time_ - 0) / var_56_0)
				arg_53_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_53_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["1072ui_story"].transform.position).z)
				arg_53_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_53_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_53_1.actors_["1072ui_story"].transform.localEulerAngles = arg_53_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_53_1.time_ >= 0 + var_56_0 and arg_53_1.time_ < 0 + var_56_0 + arg_56_0 then
				arg_53_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_53_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_53_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["1072ui_story"].transform.position).z)
				arg_53_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_53_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_53_1.actors_["1072ui_story"].transform.localEulerAngles = arg_53_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			local var_56_1 = arg_53_1.actors_["1072ui_story"]

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 and not isNil(var_56_1) and arg_53_1.var_.characterEffect1072ui_story == nil then
				arg_53_1.var_.characterEffect1072ui_story = var_56_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_2 = 0.200000002980232

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_2 and not isNil(var_56_1) then
				if arg_53_1.var_.characterEffect1072ui_story and not isNil(var_56_1) then
					arg_53_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_53_1.var_.characterEffect1072ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_53_1.time_ - 0) / var_56_2)
				end
			end

			if arg_53_1.time_ >= 0 + var_56_2 and arg_53_1.time_ < 0 + var_56_2 + arg_56_0 and not isNil(var_56_1) and arg_53_1.var_.characterEffect1072ui_story then
				arg_53_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_53_1.var_.characterEffect1072ui_story.fillRatio = 0.5
			end

			local var_56_3 = 0
			local var_56_4 = 1.25

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_3 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, false)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_5 = arg_53_1:FormatText(arg_53_1:GetWordFromCfg(221031012).content)

				arg_53_1.text_.text = var_56_5

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_7 = 50 <= 0 and var_56_4 or var_56_4 * (utf8.len(var_56_5) / 50)

				if (50 <= 0 and var_56_4 or var_56_4 * (utf8.len(var_56_5) / 50)) > 0 and var_56_4 < var_56_7 then
					arg_53_1.talkMaxDuration = var_56_7

					if var_56_7 + var_56_3 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_7 + var_56_3
					end
				end

				arg_53_1.text_.text = var_56_5
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)
				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_8 = math.max(var_56_4, arg_53_1.talkMaxDuration)

			if var_56_3 <= arg_53_1.time_ and arg_53_1.time_ < var_56_3 + var_56_8 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_3) / var_56_8

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_3 + var_56_8 and arg_53_1.time_ < var_56_3 + var_56_8 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
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
	Play221031013 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 221031013
		arg_57_1.duration_ = 5

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play221031014(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = 0.05

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, false)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_1 = arg_57_1:FormatText(arg_57_1:GetWordFromCfg(221031013).content)

				arg_57_1.text_.text = var_60_1

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_3 = 2 <= 0 and var_60_0 or var_60_0 * (utf8.len(var_60_1) / 2)

				if (2 <= 0 and var_60_0 or var_60_0 * (utf8.len(var_60_1) / 2)) > 0 and var_60_0 < var_60_3 then
					arg_57_1.talkMaxDuration = var_60_3

					if var_60_3 + 0 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_3 + 0
					end
				end

				arg_57_1.text_.text = var_60_1
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)
				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_4 = math.max(var_60_0, arg_57_1.talkMaxDuration)

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_4 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - 0) / var_60_4

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= 0 + var_60_4 and arg_57_1.time_ < 0 + var_60_4 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play221031014 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 221031014
		arg_61_1.duration_ = 13

		local var_61_0 = {
			ja = 13,
			ko = 11.666,
			zh = 11.666
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
				arg_61_0:Play221031015(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			if 2 < arg_61_1.time_ and arg_61_1.time_ <= 2 + arg_64_0 then
				local var_64_0 = arg_61_1.bgs_.ST31

				arg_61_1.bgs_.ST31.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_64_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_64_1 = var_64_0:GetComponent("SpriteRenderer")

				if var_64_1 and var_64_1.sprite then
					local var_64_2 = 2 * (var_64_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_64_0.transform.localScale = Vector3.New(var_64_2 / var_64_1.sprite.bounds.size.y < var_64_2 * manager.ui.mainCameraCom_.aspect / var_64_1.sprite.bounds.size.x and var_64_2 * manager.ui.mainCameraCom_.aspect / var_64_1.sprite.bounds.size.x or var_64_2 / var_64_1.sprite.bounds.size.y, var_64_2 / var_64_1.sprite.bounds.size.y < var_64_2 * manager.ui.mainCameraCom_.aspect / var_64_1.sprite.bounds.size.x and var_64_2 * manager.ui.mainCameraCom_.aspect / var_64_1.sprite.bounds.size.x or var_64_2 / var_64_1.sprite.bounds.size.y, 0)
				end

				for iter_64_0, iter_64_1 in pairs(arg_61_1.bgs_) do
					if iter_64_0 ~= "ST31" then
						iter_64_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_64_3 = 0

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_3 + arg_64_0 then
				arg_61_1.mask_.enabled = true
				arg_61_1.mask_.raycastTarget = true

				arg_61_1:SetGaussion(false)
			end

			local var_64_4 = 2

			if var_64_3 <= arg_61_1.time_ and arg_61_1.time_ < var_64_3 + var_64_4 then
				local var_64_5 = Color.New(0, 0, 0)

				var_64_5.a = Mathf.Lerp(0, 1, (arg_61_1.time_ - var_64_3) / var_64_4)
				arg_61_1.mask_.color = var_64_5
			end

			if arg_61_1.time_ >= var_64_3 + var_64_4 and arg_61_1.time_ < var_64_3 + var_64_4 + arg_64_0 then
				local var_64_6 = Color.New(0, 0, 0)

				var_64_6.a = 1
				arg_61_1.mask_.color = var_64_6
			end

			local var_64_7 = 2

			if 2 < arg_61_1.time_ and arg_61_1.time_ <= var_64_7 + arg_64_0 then
				arg_61_1.mask_.enabled = true
				arg_61_1.mask_.raycastTarget = true

				arg_61_1:SetGaussion(false)
			end

			local var_64_8 = 2

			if var_64_7 <= arg_61_1.time_ and arg_61_1.time_ < var_64_7 + var_64_8 then
				local var_64_9 = Color.New(0, 0, 0)

				var_64_9.a = Mathf.Lerp(1, 0, (arg_61_1.time_ - var_64_7) / var_64_8)
				arg_61_1.mask_.color = var_64_9
			end

			if arg_61_1.time_ >= var_64_7 + var_64_8 and arg_61_1.time_ < var_64_7 + var_64_8 + arg_64_0 then
				local var_64_10 = Color.New(0, 0, 0)

				arg_61_1.mask_.enabled = false
				var_64_10.a = 0
				arg_61_1.mask_.color = var_64_10
			end

			local var_64_11 = arg_61_1.actors_["1072ui_story"].transform

			if 4 < arg_61_1.time_ and arg_61_1.time_ <= 4 + arg_64_0 then
				arg_61_1.var_.moveOldPos1072ui_story = var_64_11.localPosition
			end

			local var_64_12 = 0.001

			if 4 <= arg_61_1.time_ and arg_61_1.time_ < 4 + var_64_12 then
				var_64_11.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos1072ui_story, Vector3.New(0, -0.71, -6), (arg_61_1.time_ - 4) / var_64_12)
				var_64_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_64_11.position).x, (manager.ui.mainCamera.transform.position - var_64_11.position).y, (manager.ui.mainCamera.transform.position - var_64_11.position).z)
				var_64_11.localEulerAngles.z = 0
				var_64_11.localEulerAngles.x = 0
				var_64_11.localEulerAngles = var_64_11.localEulerAngles
			end

			if arg_61_1.time_ >= 4 + var_64_12 and arg_61_1.time_ < 4 + var_64_12 + arg_64_0 then
				var_64_11.localPosition = Vector3.New(0, -0.71, -6)
				var_64_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_64_11.position).x, (manager.ui.mainCamera.transform.position - var_64_11.position).y, (manager.ui.mainCamera.transform.position - var_64_11.position).z)
				var_64_11.localEulerAngles.z = 0
				var_64_11.localEulerAngles.x = 0
				var_64_11.localEulerAngles = var_64_11.localEulerAngles
			end

			local var_64_13 = arg_61_1.actors_["1072ui_story"]

			if 4 < arg_61_1.time_ and arg_61_1.time_ <= 4 + arg_64_0 and not isNil(var_64_13) and arg_61_1.var_.characterEffect1072ui_story == nil then
				arg_61_1.var_.characterEffect1072ui_story = var_64_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_14 = 0.200000002980232

			if 4 <= arg_61_1.time_ and arg_61_1.time_ < 4 + var_64_14 and not isNil(var_64_13) then
				if arg_61_1.var_.characterEffect1072ui_story and not isNil(var_64_13) then
					arg_61_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_61_1.time_ >= 4 + var_64_14 and arg_61_1.time_ < 4 + var_64_14 + arg_64_0 and not isNil(var_64_13) and arg_61_1.var_.characterEffect1072ui_story then
				arg_61_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			if 4 < arg_61_1.time_ and arg_61_1.time_ <= 4 + arg_64_0 then
				arg_61_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action4_1")
			end

			if 4 < arg_61_1.time_ and arg_61_1.time_ <= 4 + arg_64_0 then
				arg_61_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			if arg_61_1.frameCnt_ <= 1 then
				arg_61_1.dialog_:SetActive(false)
			end

			local var_64_16 = 4
			local var_64_17 = 0.725

			if 4 < arg_61_1.time_ and arg_61_1.time_ <= var_64_16 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0

				arg_61_1.dialog_:SetActive(true)

				arg_61_1.dialogCg_.alpha = 0

				local var_64_18 = LeanTween.value(arg_61_1.dialog_, 0, 1, 0.3)

				var_64_18:setOnUpdate(LuaHelper.FloatAction(function(arg_65_0)
					arg_61_1.dialogCg_.alpha = arg_65_0
				end))
				var_64_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_61_1.dialog_)
					var_64_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_61_1.duration_ = arg_61_1.duration_ + 0.3

				SetActive(arg_61_1.leftNameGo_, true)

				arg_61_1.leftNameTxt_.text = arg_61_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_19 = arg_61_1:GetWordFromCfg(221031014)
				local var_64_20 = arg_61_1:FormatText(var_64_19.content)

				arg_61_1.text_.text = var_64_20

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_22 = 29 <= 0 and var_64_17 or var_64_17 * (utf8.len(var_64_20) / 29)

				if (29 <= 0 and var_64_17 or var_64_17 * (utf8.len(var_64_20) / 29)) > 0 and var_64_17 < var_64_22 then
					arg_61_1.talkMaxDuration = var_64_22
					var_64_16 = var_64_16 + 0.3

					if var_64_22 + var_64_16 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_22 + var_64_16
					end
				end

				arg_61_1.text_.text = var_64_20
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221031", "221031014", "story_v_out_221031.awb") ~= 0 then
					local var_64_23 = manager.audio:GetVoiceLength("story_v_out_221031", "221031014", "story_v_out_221031.awb") / 1000

					if var_64_23 + var_64_16 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_23 + var_64_16
					end

					if var_64_19.prefab_name ~= "" and arg_61_1.actors_[var_64_19.prefab_name] ~= nil then
						local var_64_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_19.prefab_name].transform, "story_v_out_221031", "221031014", "story_v_out_221031.awb")

						arg_61_1:RecordAudio("221031014", var_64_24)
						arg_61_1:RecordAudio("221031014", var_64_24)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_221031", "221031014", "story_v_out_221031.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_221031", "221031014", "story_v_out_221031.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_25 = var_64_16 + 0.3
			local var_64_26 = math.max(var_64_17, arg_61_1.talkMaxDuration)

			if var_64_16 + 0.3 <= arg_61_1.time_ and arg_61_1.time_ < var_64_25 + var_64_26 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_25) / var_64_26

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_25 + var_64_26 and arg_61_1.time_ < var_64_25 + var_64_26 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 4,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_61_1:InitPlayNodeList()
	end,
	Play221031015 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 221031015
		arg_67_1.duration_ = 9.63

		local var_67_0 = {
			ja = 9.433,
			ko = 9.633,
			zh = 9.633
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
				arg_67_0:Play221031016(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 then
				arg_67_1.var_.moveOldPos1072ui_story = arg_67_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_70_0 = 0.001

			if 0 <= arg_67_1.time_ and arg_67_1.time_ < 0 + var_70_0 then
				arg_67_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_67_1.var_.moveOldPos1072ui_story, Vector3.New(0, -0.71, -6), (arg_67_1.time_ - 0) / var_70_0)
				arg_67_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_67_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_67_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_67_1.actors_["1072ui_story"].transform.position).z)
				arg_67_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_67_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_67_1.actors_["1072ui_story"].transform.localEulerAngles = arg_67_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_67_1.time_ >= 0 + var_70_0 and arg_67_1.time_ < 0 + var_70_0 + arg_70_0 then
				arg_67_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_67_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_67_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_67_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_67_1.actors_["1072ui_story"].transform.position).z)
				arg_67_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_67_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_67_1.actors_["1072ui_story"].transform.localEulerAngles = arg_67_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 then
				arg_67_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072actionlink/1072action448")
			end

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 then
				arg_67_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_70_1 = 0
			local var_70_2 = 1.05

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= var_70_1 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, true)

				arg_67_1.leftNameTxt_.text = arg_67_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_67_1.leftNameTxt_.transform)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1.leftNameTxt_.text)
				SetActive(arg_67_1.iconTrs_.gameObject, false)
				arg_67_1.callingController_:SetSelectedState("normal")

				local var_70_3 = arg_67_1:GetWordFromCfg(221031015)
				local var_70_4 = arg_67_1:FormatText(var_70_3.content)

				arg_67_1.text_.text = var_70_4

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_6 = 42 <= 0 and var_70_2 or var_70_2 * (utf8.len(var_70_4) / 42)

				if (42 <= 0 and var_70_2 or var_70_2 * (utf8.len(var_70_4) / 42)) > 0 and var_70_2 < var_70_6 then
					arg_67_1.talkMaxDuration = var_70_6

					if var_70_6 + var_70_1 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_6 + var_70_1
					end
				end

				arg_67_1.text_.text = var_70_4
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221031", "221031015", "story_v_out_221031.awb") ~= 0 then
					local var_70_7 = manager.audio:GetVoiceLength("story_v_out_221031", "221031015", "story_v_out_221031.awb") / 1000

					if var_70_7 + var_70_1 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_7 + var_70_1
					end

					if var_70_3.prefab_name ~= "" and arg_67_1.actors_[var_70_3.prefab_name] ~= nil then
						local var_70_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_67_1.actors_[var_70_3.prefab_name].transform, "story_v_out_221031", "221031015", "story_v_out_221031.awb")

						arg_67_1:RecordAudio("221031015", var_70_8)
						arg_67_1:RecordAudio("221031015", var_70_8)
					else
						arg_67_1:AudioAction("play", "voice", "story_v_out_221031", "221031015", "story_v_out_221031.awb")
					end

					arg_67_1:RecordHistoryTalkVoice("story_v_out_221031", "221031015", "story_v_out_221031.awb")
				end

				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_9 = math.max(var_70_2, arg_67_1.talkMaxDuration)

			if var_70_1 <= arg_67_1.time_ and arg_67_1.time_ < var_70_1 + var_70_9 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - var_70_1) / var_70_9

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= var_70_1 + var_70_9 and arg_67_1.time_ < var_70_1 + var_70_9 + arg_70_0 then
				arg_67_1.typewritter.percent = 1

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(true)
			end
		end

		arg_67_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_67_1:InitPlayNodeList()
	end,
	Play221031016 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 221031016
		arg_71_1.duration_ = 10.17

		local var_71_0 = {
			ja = 10.166,
			ko = 6.966,
			zh = 6.966
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
				arg_71_0:Play221031017(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1.var_.moveOldPos1072ui_story = arg_71_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_74_0 = 0.001

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_0 then
				arg_71_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_71_1.var_.moveOldPos1072ui_story, Vector3.New(0, -0.71, -6), (arg_71_1.time_ - 0) / var_74_0)
				arg_71_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_71_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_71_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_71_1.actors_["1072ui_story"].transform.position).z)
				arg_71_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_71_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_71_1.actors_["1072ui_story"].transform.localEulerAngles = arg_71_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_71_1.time_ >= 0 + var_74_0 and arg_71_1.time_ < 0 + var_74_0 + arg_74_0 then
				arg_71_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_71_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_71_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_71_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_71_1.actors_["1072ui_story"].transform.position).z)
				arg_71_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_71_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_71_1.actors_["1072ui_story"].transform.localEulerAngles = arg_71_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072actionlink/1072action486")
			end

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_74_1 = 0
			local var_74_2 = 0.95

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= var_74_1 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, true)

				arg_71_1.leftNameTxt_.text = arg_71_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_71_1.leftNameTxt_.transform)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1.leftNameTxt_.text)
				SetActive(arg_71_1.iconTrs_.gameObject, false)
				arg_71_1.callingController_:SetSelectedState("normal")

				local var_74_3 = arg_71_1:GetWordFromCfg(221031016)
				local var_74_4 = arg_71_1:FormatText(var_74_3.content)

				arg_71_1.text_.text = var_74_4

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_6 = 38 <= 0 and var_74_2 or var_74_2 * (utf8.len(var_74_4) / 38)

				if (38 <= 0 and var_74_2 or var_74_2 * (utf8.len(var_74_4) / 38)) > 0 and var_74_2 < var_74_6 then
					arg_71_1.talkMaxDuration = var_74_6

					if var_74_6 + var_74_1 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_6 + var_74_1
					end
				end

				arg_71_1.text_.text = var_74_4
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221031", "221031016", "story_v_out_221031.awb") ~= 0 then
					local var_74_7 = manager.audio:GetVoiceLength("story_v_out_221031", "221031016", "story_v_out_221031.awb") / 1000

					if var_74_7 + var_74_1 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_7 + var_74_1
					end

					if var_74_3.prefab_name ~= "" and arg_71_1.actors_[var_74_3.prefab_name] ~= nil then
						local var_74_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_71_1.actors_[var_74_3.prefab_name].transform, "story_v_out_221031", "221031016", "story_v_out_221031.awb")

						arg_71_1:RecordAudio("221031016", var_74_8)
						arg_71_1:RecordAudio("221031016", var_74_8)
					else
						arg_71_1:AudioAction("play", "voice", "story_v_out_221031", "221031016", "story_v_out_221031.awb")
					end

					arg_71_1:RecordHistoryTalkVoice("story_v_out_221031", "221031016", "story_v_out_221031.awb")
				end

				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_9 = math.max(var_74_2, arg_71_1.talkMaxDuration)

			if var_74_1 <= arg_71_1.time_ and arg_71_1.time_ < var_74_1 + var_74_9 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - var_74_1) / var_74_9

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= var_74_1 + var_74_9 and arg_71_1.time_ < var_74_1 + var_74_9 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_71_1:InitPlayNodeList()
	end,
	Play221031017 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 221031017
		arg_75_1.duration_ = 8.07

		local var_75_0 = {
			ja = 8.066,
			ko = 5,
			zh = 5
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
				arg_75_0:Play221031018(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 then
				arg_75_1.var_.moveOldPos1072ui_story = arg_75_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_78_0 = 0.001

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_0 then
				arg_75_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_75_1.var_.moveOldPos1072ui_story, Vector3.New(0, -0.71, -6), (arg_75_1.time_ - 0) / var_78_0)
				arg_75_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_75_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_75_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_75_1.actors_["1072ui_story"].transform.position).z)
				arg_75_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_75_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_75_1.actors_["1072ui_story"].transform.localEulerAngles = arg_75_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_75_1.time_ >= 0 + var_78_0 and arg_75_1.time_ < 0 + var_78_0 + arg_78_0 then
				arg_75_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_75_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_75_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_75_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_75_1.actors_["1072ui_story"].transform.position).z)
				arg_75_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_75_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_75_1.actors_["1072ui_story"].transform.localEulerAngles = arg_75_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 then
				arg_75_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0202cva")
			end

			local var_78_1 = 0
			local var_78_2 = 0.45

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= var_78_1 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, true)

				arg_75_1.leftNameTxt_.text = arg_75_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_75_1.leftNameTxt_.transform)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1.leftNameTxt_.text)
				SetActive(arg_75_1.iconTrs_.gameObject, false)
				arg_75_1.callingController_:SetSelectedState("normal")

				local var_78_3 = arg_75_1:GetWordFromCfg(221031017)
				local var_78_4 = arg_75_1:FormatText(var_78_3.content)

				arg_75_1.text_.text = var_78_4

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_6 = 18 <= 0 and var_78_2 or var_78_2 * (utf8.len(var_78_4) / 18)

				if (18 <= 0 and var_78_2 or var_78_2 * (utf8.len(var_78_4) / 18)) > 0 and var_78_2 < var_78_6 then
					arg_75_1.talkMaxDuration = var_78_6

					if var_78_6 + var_78_1 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_6 + var_78_1
					end
				end

				arg_75_1.text_.text = var_78_4
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221031", "221031017", "story_v_out_221031.awb") ~= 0 then
					local var_78_7 = manager.audio:GetVoiceLength("story_v_out_221031", "221031017", "story_v_out_221031.awb") / 1000

					if var_78_7 + var_78_1 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_7 + var_78_1
					end

					if var_78_3.prefab_name ~= "" and arg_75_1.actors_[var_78_3.prefab_name] ~= nil then
						local var_78_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_75_1.actors_[var_78_3.prefab_name].transform, "story_v_out_221031", "221031017", "story_v_out_221031.awb")

						arg_75_1:RecordAudio("221031017", var_78_8)
						arg_75_1:RecordAudio("221031017", var_78_8)
					else
						arg_75_1:AudioAction("play", "voice", "story_v_out_221031", "221031017", "story_v_out_221031.awb")
					end

					arg_75_1:RecordHistoryTalkVoice("story_v_out_221031", "221031017", "story_v_out_221031.awb")
				end

				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_9 = math.max(var_78_2, arg_75_1.talkMaxDuration)

			if var_78_1 <= arg_75_1.time_ and arg_75_1.time_ < var_78_1 + var_78_9 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - var_78_1) / var_78_9

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= var_78_1 + var_78_9 and arg_75_1.time_ < var_78_1 + var_78_9 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
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
	Play221031018 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 221031018
		arg_79_1.duration_ = 5

		SetActive(arg_79_1.tipsGo_, false)

		function arg_79_1.onSingleLineFinish_()
			arg_79_1.onSingleLineUpdate_ = nil
			arg_79_1.onSingleLineFinish_ = nil
			arg_79_1.state_ = "waiting"
		end

		function arg_79_1.playNext_(arg_81_0)
			if arg_81_0 == 1 then
				arg_79_0:Play221031019(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1.var_.moveOldPos1072ui_story = arg_79_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_82_0 = 0.001

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_0 then
				arg_79_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_79_1.var_.moveOldPos1072ui_story, Vector3.New(0, 100, 0), (arg_79_1.time_ - 0) / var_82_0)
				arg_79_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_79_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_79_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_79_1.actors_["1072ui_story"].transform.position).z)
				arg_79_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_79_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_79_1.actors_["1072ui_story"].transform.localEulerAngles = arg_79_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_79_1.time_ >= 0 + var_82_0 and arg_79_1.time_ < 0 + var_82_0 + arg_82_0 then
				arg_79_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_79_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_79_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_79_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_79_1.actors_["1072ui_story"].transform.position).z)
				arg_79_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_79_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_79_1.actors_["1072ui_story"].transform.localEulerAngles = arg_79_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			local var_82_1 = arg_79_1.actors_["1072ui_story"]

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 and not isNil(var_82_1) and arg_79_1.var_.characterEffect1072ui_story == nil then
				arg_79_1.var_.characterEffect1072ui_story = var_82_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_82_2 = 0.200000002980232

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_2 and not isNil(var_82_1) then
				if arg_79_1.var_.characterEffect1072ui_story and not isNil(var_82_1) then
					arg_79_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_79_1.var_.characterEffect1072ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_79_1.time_ - 0) / var_82_2)
				end
			end

			if arg_79_1.time_ >= 0 + var_82_2 and arg_79_1.time_ < 0 + var_82_2 + arg_82_0 and not isNil(var_82_1) and arg_79_1.var_.characterEffect1072ui_story then
				arg_79_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_79_1.var_.characterEffect1072ui_story.fillRatio = 0.5
			end

			local var_82_3 = 0
			local var_82_4 = 0.375

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= var_82_3 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, false)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_5 = arg_79_1:FormatText(arg_79_1:GetWordFromCfg(221031018).content)

				arg_79_1.text_.text = var_82_5

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_7 = 15 <= 0 and var_82_4 or var_82_4 * (utf8.len(var_82_5) / 15)

				if (15 <= 0 and var_82_4 or var_82_4 * (utf8.len(var_82_5) / 15)) > 0 and var_82_4 < var_82_7 then
					arg_79_1.talkMaxDuration = var_82_7

					if var_82_7 + var_82_3 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_7 + var_82_3
					end
				end

				arg_79_1.text_.text = var_82_5
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)
				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_8 = math.max(var_82_4, arg_79_1.talkMaxDuration)

			if var_82_3 <= arg_79_1.time_ and arg_79_1.time_ < var_82_3 + var_82_8 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_3) / var_82_8

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_3 + var_82_8 and arg_79_1.time_ < var_82_3 + var_82_8 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
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
	Play221031019 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 221031019
		arg_83_1.duration_ = 5.13

		local var_83_0 = {
			ja = 5.133,
			ko = 4.266,
			zh = 4.266
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
				arg_83_0:Play221031020(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			local var_86_0 = 0.45

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, true)

				arg_83_1.leftNameTxt_.text = arg_83_1:FormatText(StoryNameCfg[423].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_83_1.leftNameTxt_.transform)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1.leftNameTxt_.text)
				SetActive(arg_83_1.iconTrs_.gameObject, true)
				arg_83_1.iconController_:SetSelectedState("hero")

				arg_83_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwa")

				arg_83_1.callingController_:SetSelectedState("normal")

				arg_83_1.keyicon_.color = Color.New(1, 1, 1)
				arg_83_1.icon_.color = Color.New(1, 1, 1)

				local var_86_1 = arg_83_1:GetWordFromCfg(221031019)
				local var_86_2 = arg_83_1:FormatText(var_86_1.content)

				arg_83_1.text_.text = var_86_2

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_4 = 18 <= 0 and var_86_0 or var_86_0 * (utf8.len(var_86_2) / 18)

				if (18 <= 0 and var_86_0 or var_86_0 * (utf8.len(var_86_2) / 18)) > 0 and var_86_0 < var_86_4 then
					arg_83_1.talkMaxDuration = var_86_4

					if var_86_4 + 0 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_4 + 0
					end
				end

				arg_83_1.text_.text = var_86_2
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221031", "221031019", "story_v_out_221031.awb") ~= 0 then
					local var_86_5 = manager.audio:GetVoiceLength("story_v_out_221031", "221031019", "story_v_out_221031.awb") / 1000

					if var_86_5 + 0 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_5 + 0
					end

					if var_86_1.prefab_name ~= "" and arg_83_1.actors_[var_86_1.prefab_name] ~= nil then
						local var_86_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_83_1.actors_[var_86_1.prefab_name].transform, "story_v_out_221031", "221031019", "story_v_out_221031.awb")

						arg_83_1:RecordAudio("221031019", var_86_6)
						arg_83_1:RecordAudio("221031019", var_86_6)
					else
						arg_83_1:AudioAction("play", "voice", "story_v_out_221031", "221031019", "story_v_out_221031.awb")
					end

					arg_83_1:RecordHistoryTalkVoice("story_v_out_221031", "221031019", "story_v_out_221031.awb")
				end

				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_7 = math.max(var_86_0, arg_83_1.talkMaxDuration)

			if 0 <= arg_83_1.time_ and arg_83_1.time_ < 0 + var_86_7 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - 0) / var_86_7

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= 0 + var_86_7 and arg_83_1.time_ < 0 + var_86_7 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {}

		arg_83_1:InitPlayNodeList()
	end,
	Play221031020 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 221031020
		arg_87_1.duration_ = 4.3

		local var_87_0 = {
			ja = 4.3,
			ko = 2.033,
			zh = 2.033
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
				arg_87_0:Play221031021(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 then
				arg_87_1.var_.moveOldPos1072ui_story = arg_87_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_90_0 = 0.001

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_0 then
				arg_87_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_87_1.var_.moveOldPos1072ui_story, Vector3.New(0, -0.71, -6), (arg_87_1.time_ - 0) / var_90_0)
				arg_87_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_87_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_87_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_87_1.actors_["1072ui_story"].transform.position).z)
				arg_87_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_87_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_87_1.actors_["1072ui_story"].transform.localEulerAngles = arg_87_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_87_1.time_ >= 0 + var_90_0 and arg_87_1.time_ < 0 + var_90_0 + arg_90_0 then
				arg_87_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_87_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_87_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_87_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_87_1.actors_["1072ui_story"].transform.position).z)
				arg_87_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_87_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_87_1.actors_["1072ui_story"].transform.localEulerAngles = arg_87_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			local var_90_1 = arg_87_1.actors_["1072ui_story"]

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 and not isNil(var_90_1) and arg_87_1.var_.characterEffect1072ui_story == nil then
				arg_87_1.var_.characterEffect1072ui_story = var_90_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_90_2 = 0.200000002980232

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_2 and not isNil(var_90_1) then
				if arg_87_1.var_.characterEffect1072ui_story and not isNil(var_90_1) then
					arg_87_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_87_1.time_ >= 0 + var_90_2 and arg_87_1.time_ < 0 + var_90_2 + arg_90_0 and not isNil(var_90_1) and arg_87_1.var_.characterEffect1072ui_story then
				arg_87_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 then
				arg_87_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action6_1")
			end

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 then
				arg_87_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_90_4 = 0
			local var_90_5 = 0.3

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= var_90_4 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, true)

				arg_87_1.leftNameTxt_.text = arg_87_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_87_1.leftNameTxt_.transform)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1.leftNameTxt_.text)
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_6 = arg_87_1:GetWordFromCfg(221031020)
				local var_90_7 = arg_87_1:FormatText(var_90_6.content)

				arg_87_1.text_.text = var_90_7

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_9 = 12 <= 0 and var_90_5 or var_90_5 * (utf8.len(var_90_7) / 12)

				if (12 <= 0 and var_90_5 or var_90_5 * (utf8.len(var_90_7) / 12)) > 0 and var_90_5 < var_90_9 then
					arg_87_1.talkMaxDuration = var_90_9

					if var_90_9 + var_90_4 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_9 + var_90_4
					end
				end

				arg_87_1.text_.text = var_90_7
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221031", "221031020", "story_v_out_221031.awb") ~= 0 then
					local var_90_10 = manager.audio:GetVoiceLength("story_v_out_221031", "221031020", "story_v_out_221031.awb") / 1000

					if var_90_10 + var_90_4 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_10 + var_90_4
					end

					if var_90_6.prefab_name ~= "" and arg_87_1.actors_[var_90_6.prefab_name] ~= nil then
						local var_90_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_87_1.actors_[var_90_6.prefab_name].transform, "story_v_out_221031", "221031020", "story_v_out_221031.awb")

						arg_87_1:RecordAudio("221031020", var_90_11)
						arg_87_1:RecordAudio("221031020", var_90_11)
					else
						arg_87_1:AudioAction("play", "voice", "story_v_out_221031", "221031020", "story_v_out_221031.awb")
					end

					arg_87_1:RecordHistoryTalkVoice("story_v_out_221031", "221031020", "story_v_out_221031.awb")
				end

				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_12 = math.max(var_90_5, arg_87_1.talkMaxDuration)

			if var_90_4 <= arg_87_1.time_ and arg_87_1.time_ < var_90_4 + var_90_12 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - var_90_4) / var_90_12

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= var_90_4 + var_90_12 and arg_87_1.time_ < var_90_4 + var_90_12 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
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
	Play221031021 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 221031021
		arg_91_1.duration_ = 13.13

		local var_91_0 = {
			ja = 13.133,
			ko = 8.733,
			zh = 8.733
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
				arg_91_0:Play221031022(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				arg_91_1.var_.moveOldPos1072ui_story = arg_91_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_94_0 = 0.001

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_0 then
				arg_91_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_91_1.var_.moveOldPos1072ui_story, Vector3.New(0, -0.71, -6), (arg_91_1.time_ - 0) / var_94_0)
				arg_91_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_91_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_91_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_91_1.actors_["1072ui_story"].transform.position).z)
				arg_91_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_91_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_91_1.actors_["1072ui_story"].transform.localEulerAngles = arg_91_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_91_1.time_ >= 0 + var_94_0 and arg_91_1.time_ < 0 + var_94_0 + arg_94_0 then
				arg_91_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_91_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_91_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_91_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_91_1.actors_["1072ui_story"].transform.position).z)
				arg_91_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_91_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_91_1.actors_["1072ui_story"].transform.localEulerAngles = arg_91_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				arg_91_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072actionlink/1072action468")
			end

			local var_94_1 = 0
			local var_94_2 = 0.95

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= var_94_1 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, true)

				arg_91_1.leftNameTxt_.text = arg_91_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_91_1.leftNameTxt_.transform)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1.leftNameTxt_.text)
				SetActive(arg_91_1.iconTrs_.gameObject, false)
				arg_91_1.callingController_:SetSelectedState("normal")

				local var_94_3 = arg_91_1:GetWordFromCfg(221031021)
				local var_94_4 = arg_91_1:FormatText(var_94_3.content)

				arg_91_1.text_.text = var_94_4

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_6 = 38 <= 0 and var_94_2 or var_94_2 * (utf8.len(var_94_4) / 38)

				if (38 <= 0 and var_94_2 or var_94_2 * (utf8.len(var_94_4) / 38)) > 0 and var_94_2 < var_94_6 then
					arg_91_1.talkMaxDuration = var_94_6

					if var_94_6 + var_94_1 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_6 + var_94_1
					end
				end

				arg_91_1.text_.text = var_94_4
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221031", "221031021", "story_v_out_221031.awb") ~= 0 then
					local var_94_7 = manager.audio:GetVoiceLength("story_v_out_221031", "221031021", "story_v_out_221031.awb") / 1000

					if var_94_7 + var_94_1 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_7 + var_94_1
					end

					if var_94_3.prefab_name ~= "" and arg_91_1.actors_[var_94_3.prefab_name] ~= nil then
						local var_94_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_91_1.actors_[var_94_3.prefab_name].transform, "story_v_out_221031", "221031021", "story_v_out_221031.awb")

						arg_91_1:RecordAudio("221031021", var_94_8)
						arg_91_1:RecordAudio("221031021", var_94_8)
					else
						arg_91_1:AudioAction("play", "voice", "story_v_out_221031", "221031021", "story_v_out_221031.awb")
					end

					arg_91_1:RecordHistoryTalkVoice("story_v_out_221031", "221031021", "story_v_out_221031.awb")
				end

				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_9 = math.max(var_94_2, arg_91_1.talkMaxDuration)

			if var_94_1 <= arg_91_1.time_ and arg_91_1.time_ < var_94_1 + var_94_9 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - var_94_1) / var_94_9

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= var_94_1 + var_94_9 and arg_91_1.time_ < var_94_1 + var_94_9 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
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
	Play221031022 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 221031022
		arg_95_1.duration_ = 9.87

		local var_95_0 = {
			ja = 9.866,
			ko = 9.4,
			zh = 9.4
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
				arg_95_0:Play221031023(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 then
				arg_95_1.var_.moveOldPos1072ui_story = arg_95_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_98_0 = 0.001

			if 0 <= arg_95_1.time_ and arg_95_1.time_ < 0 + var_98_0 then
				arg_95_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_95_1.var_.moveOldPos1072ui_story, Vector3.New(0, 100, 0), (arg_95_1.time_ - 0) / var_98_0)
				arg_95_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_95_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_95_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_95_1.actors_["1072ui_story"].transform.position).z)
				arg_95_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_95_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_95_1.actors_["1072ui_story"].transform.localEulerAngles = arg_95_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_95_1.time_ >= 0 + var_98_0 and arg_95_1.time_ < 0 + var_98_0 + arg_98_0 then
				arg_95_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_95_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_95_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_95_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_95_1.actors_["1072ui_story"].transform.position).z)
				arg_95_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_95_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_95_1.actors_["1072ui_story"].transform.localEulerAngles = arg_95_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			local var_98_1 = arg_95_1.actors_["1072ui_story"]

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 and not isNil(var_98_1) and arg_95_1.var_.characterEffect1072ui_story == nil then
				arg_95_1.var_.characterEffect1072ui_story = var_98_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_98_2 = 0.200000002980232

			if 0 <= arg_95_1.time_ and arg_95_1.time_ < 0 + var_98_2 and not isNil(var_98_1) then
				if arg_95_1.var_.characterEffect1072ui_story and not isNil(var_98_1) then
					arg_95_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_95_1.var_.characterEffect1072ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_95_1.time_ - 0) / var_98_2)
				end
			end

			if arg_95_1.time_ >= 0 + var_98_2 and arg_95_1.time_ < 0 + var_98_2 + arg_98_0 and not isNil(var_98_1) and arg_95_1.var_.characterEffect1072ui_story then
				arg_95_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_95_1.var_.characterEffect1072ui_story.fillRatio = 0.5
			end

			local var_98_3 = 0
			local var_98_4 = 1.025

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= var_98_3 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, true)

				arg_95_1.leftNameTxt_.text = arg_95_1:FormatText(StoryNameCfg[424].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_95_1.leftNameTxt_.transform)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1.leftNameTxt_.text)
				SetActive(arg_95_1.iconTrs_.gameObject, true)
				arg_95_1.iconController_:SetSelectedState("hero")

				arg_95_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenmb")

				arg_95_1.callingController_:SetSelectedState("normal")

				arg_95_1.keyicon_.color = Color.New(1, 1, 1)
				arg_95_1.icon_.color = Color.New(1, 1, 1)

				local var_98_5 = arg_95_1:GetWordFromCfg(221031022)
				local var_98_6 = arg_95_1:FormatText(var_98_5.content)

				arg_95_1.text_.text = var_98_6

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_8 = 41 <= 0 and var_98_4 or var_98_4 * (utf8.len(var_98_6) / 41)

				if (41 <= 0 and var_98_4 or var_98_4 * (utf8.len(var_98_6) / 41)) > 0 and var_98_4 < var_98_8 then
					arg_95_1.talkMaxDuration = var_98_8

					if var_98_8 + var_98_3 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_8 + var_98_3
					end
				end

				arg_95_1.text_.text = var_98_6
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221031", "221031022", "story_v_out_221031.awb") ~= 0 then
					local var_98_9 = manager.audio:GetVoiceLength("story_v_out_221031", "221031022", "story_v_out_221031.awb") / 1000

					if var_98_9 + var_98_3 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_9 + var_98_3
					end

					if var_98_5.prefab_name ~= "" and arg_95_1.actors_[var_98_5.prefab_name] ~= nil then
						local var_98_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_95_1.actors_[var_98_5.prefab_name].transform, "story_v_out_221031", "221031022", "story_v_out_221031.awb")

						arg_95_1:RecordAudio("221031022", var_98_10)
						arg_95_1:RecordAudio("221031022", var_98_10)
					else
						arg_95_1:AudioAction("play", "voice", "story_v_out_221031", "221031022", "story_v_out_221031.awb")
					end

					arg_95_1:RecordHistoryTalkVoice("story_v_out_221031", "221031022", "story_v_out_221031.awb")
				end

				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_11 = math.max(var_98_4, arg_95_1.talkMaxDuration)

			if var_98_3 <= arg_95_1.time_ and arg_95_1.time_ < var_98_3 + var_98_11 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - var_98_3) / var_98_11

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= var_98_3 + var_98_11 and arg_95_1.time_ < var_98_3 + var_98_11 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_95_1:InitPlayNodeList()
	end,
	Play221031023 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 221031023
		arg_99_1.duration_ = 8.67

		local var_99_0 = {
			ja = 8.666,
			ko = 3.9,
			zh = 3.9
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
				arg_99_0:Play221031024(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			local var_102_0 = 0.575

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, true)

				arg_99_1.leftNameTxt_.text = arg_99_1:FormatText(StoryNameCfg[425].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_99_1.leftNameTxt_.transform)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1.leftNameTxt_.text)
				SetActive(arg_99_1.iconTrs_.gameObject, true)
				arg_99_1.iconController_:SetSelectedState("hero")

				arg_99_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwc")

				arg_99_1.callingController_:SetSelectedState("normal")

				arg_99_1.keyicon_.color = Color.New(1, 1, 1)
				arg_99_1.icon_.color = Color.New(1, 1, 1)

				local var_102_1 = arg_99_1:GetWordFromCfg(221031023)
				local var_102_2 = arg_99_1:FormatText(var_102_1.content)

				arg_99_1.text_.text = var_102_2

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_4 = 23 <= 0 and var_102_0 or var_102_0 * (utf8.len(var_102_2) / 23)

				if (23 <= 0 and var_102_0 or var_102_0 * (utf8.len(var_102_2) / 23)) > 0 and var_102_0 < var_102_4 then
					arg_99_1.talkMaxDuration = var_102_4

					if var_102_4 + 0 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_4 + 0
					end
				end

				arg_99_1.text_.text = var_102_2
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221031", "221031023", "story_v_out_221031.awb") ~= 0 then
					local var_102_5 = manager.audio:GetVoiceLength("story_v_out_221031", "221031023", "story_v_out_221031.awb") / 1000

					if var_102_5 + 0 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_5 + 0
					end

					if var_102_1.prefab_name ~= "" and arg_99_1.actors_[var_102_1.prefab_name] ~= nil then
						local var_102_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_99_1.actors_[var_102_1.prefab_name].transform, "story_v_out_221031", "221031023", "story_v_out_221031.awb")

						arg_99_1:RecordAudio("221031023", var_102_6)
						arg_99_1:RecordAudio("221031023", var_102_6)
					else
						arg_99_1:AudioAction("play", "voice", "story_v_out_221031", "221031023", "story_v_out_221031.awb")
					end

					arg_99_1:RecordHistoryTalkVoice("story_v_out_221031", "221031023", "story_v_out_221031.awb")
				end

				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_7 = math.max(var_102_0, arg_99_1.talkMaxDuration)

			if 0 <= arg_99_1.time_ and arg_99_1.time_ < 0 + var_102_7 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - 0) / var_102_7

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= 0 + var_102_7 and arg_99_1.time_ < 0 + var_102_7 + arg_102_0 then
				arg_99_1.typewritter.percent = 1

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(true)
			end
		end

		arg_99_1.nodeConfigList_ = {}

		arg_99_1:InitPlayNodeList()
	end,
	Play221031024 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 221031024
		arg_103_1.duration_ = 5

		SetActive(arg_103_1.tipsGo_, false)

		function arg_103_1.onSingleLineFinish_()
			arg_103_1.onSingleLineUpdate_ = nil
			arg_103_1.onSingleLineFinish_ = nil
			arg_103_1.state_ = "waiting"
		end

		function arg_103_1.playNext_(arg_105_0)
			if arg_105_0 == 1 then
				arg_103_0:Play221031025(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 then
				arg_103_1:AudioAction("play", "effect", "se_story_221_00", "se_story_221_00_cat", "")
			end

			local var_106_1 = 0
			local var_106_2 = 0.05

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= var_106_1 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, true)

				arg_103_1.leftNameTxt_.text = arg_103_1:FormatText(StoryNameCfg[197].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_103_1.leftNameTxt_.transform)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1.leftNameTxt_.text)
				SetActive(arg_103_1.iconTrs_.gameObject, true)
				arg_103_1.iconController_:SetSelectedState("hero")

				arg_103_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_cat")

				arg_103_1.callingController_:SetSelectedState("normal")

				arg_103_1.keyicon_.color = Color.New(1, 1, 1)
				arg_103_1.icon_.color = Color.New(1, 1, 1)

				local var_106_3 = arg_103_1:FormatText(arg_103_1:GetWordFromCfg(221031024).content)

				arg_103_1.text_.text = var_106_3

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_5 = 2 <= 0 and var_106_2 or var_106_2 * (utf8.len(var_106_3) / 2)

				if (2 <= 0 and var_106_2 or var_106_2 * (utf8.len(var_106_3) / 2)) > 0 and var_106_2 < var_106_5 then
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
	Play221031025 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 221031025
		arg_107_1.duration_ = 5

		SetActive(arg_107_1.tipsGo_, false)

		function arg_107_1.onSingleLineFinish_()
			arg_107_1.onSingleLineUpdate_ = nil
			arg_107_1.onSingleLineFinish_ = nil
			arg_107_1.state_ = "waiting"
		end

		function arg_107_1.playNext_(arg_109_0)
			if arg_109_0 == 1 then
				arg_107_0:Play221031026(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			local var_110_0 = 1.15

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

				local var_110_1 = arg_107_1:FormatText(arg_107_1:GetWordFromCfg(221031025).content)

				arg_107_1.text_.text = var_110_1

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_3 = 46 <= 0 and var_110_0 or var_110_0 * (utf8.len(var_110_1) / 46)

				if (46 <= 0 and var_110_0 or var_110_0 * (utf8.len(var_110_1) / 46)) > 0 and var_110_0 < var_110_3 then
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
	Play221031026 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 221031026
		arg_111_1.duration_ = 5

		SetActive(arg_111_1.tipsGo_, false)

		function arg_111_1.onSingleLineFinish_()
			arg_111_1.onSingleLineUpdate_ = nil
			arg_111_1.onSingleLineFinish_ = nil
			arg_111_1.state_ = "waiting"
		end

		function arg_111_1.playNext_(arg_113_0)
			if arg_113_0 == 1 then
				arg_111_0:Play221031027(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			local var_114_0 = 0.875

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

				local var_114_1 = arg_111_1:FormatText(arg_111_1:GetWordFromCfg(221031026).content)

				arg_111_1.text_.text = var_114_1

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_3 = 35 <= 0 and var_114_0 or var_114_0 * (utf8.len(var_114_1) / 35)

				if (35 <= 0 and var_114_0 or var_114_0 * (utf8.len(var_114_1) / 35)) > 0 and var_114_0 < var_114_3 then
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
	Play221031027 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 221031027
		arg_115_1.duration_ = 4.4

		local var_115_0 = {
			ja = 4.4,
			ko = 3.433,
			zh = 3.433
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
				arg_115_0:Play221031028(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				arg_115_1.var_.moveOldPos1072ui_story = arg_115_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_118_0 = 0.001

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_0 then
				arg_115_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_115_1.var_.moveOldPos1072ui_story, Vector3.New(0, -0.71, -6), (arg_115_1.time_ - 0) / var_118_0)
				arg_115_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_115_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_115_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_115_1.actors_["1072ui_story"].transform.position).z)
				arg_115_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_115_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_115_1.actors_["1072ui_story"].transform.localEulerAngles = arg_115_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_115_1.time_ >= 0 + var_118_0 and arg_115_1.time_ < 0 + var_118_0 + arg_118_0 then
				arg_115_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_115_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_115_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_115_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_115_1.actors_["1072ui_story"].transform.position).z)
				arg_115_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_115_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_115_1.actors_["1072ui_story"].transform.localEulerAngles = arg_115_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			local var_118_1 = arg_115_1.actors_["1072ui_story"]

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 and not isNil(var_118_1) and arg_115_1.var_.characterEffect1072ui_story == nil then
				arg_115_1.var_.characterEffect1072ui_story = var_118_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_118_2 = 0.200000002980232

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_2 and not isNil(var_118_1) then
				if arg_115_1.var_.characterEffect1072ui_story and not isNil(var_118_1) then
					arg_115_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_115_1.time_ >= 0 + var_118_2 and arg_115_1.time_ < 0 + var_118_2 + arg_118_0 and not isNil(var_118_1) and arg_115_1.var_.characterEffect1072ui_story then
				arg_115_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				arg_115_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action1_1")
			end

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				arg_115_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_118_4 = 0
			local var_118_5 = 0.3

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= var_118_4 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, true)

				arg_115_1.leftNameTxt_.text = arg_115_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_6 = arg_115_1:GetWordFromCfg(221031027)
				local var_118_7 = arg_115_1:FormatText(var_118_6.content)

				arg_115_1.text_.text = var_118_7

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_9 = 12 <= 0 and var_118_5 or var_118_5 * (utf8.len(var_118_7) / 12)

				if (12 <= 0 and var_118_5 or var_118_5 * (utf8.len(var_118_7) / 12)) > 0 and var_118_5 < var_118_9 then
					arg_115_1.talkMaxDuration = var_118_9

					if var_118_9 + var_118_4 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_9 + var_118_4
					end
				end

				arg_115_1.text_.text = var_118_7
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221031", "221031027", "story_v_out_221031.awb") ~= 0 then
					local var_118_10 = manager.audio:GetVoiceLength("story_v_out_221031", "221031027", "story_v_out_221031.awb") / 1000

					if var_118_10 + var_118_4 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_10 + var_118_4
					end

					if var_118_6.prefab_name ~= "" and arg_115_1.actors_[var_118_6.prefab_name] ~= nil then
						local var_118_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_115_1.actors_[var_118_6.prefab_name].transform, "story_v_out_221031", "221031027", "story_v_out_221031.awb")

						arg_115_1:RecordAudio("221031027", var_118_11)
						arg_115_1:RecordAudio("221031027", var_118_11)
					else
						arg_115_1:AudioAction("play", "voice", "story_v_out_221031", "221031027", "story_v_out_221031.awb")
					end

					arg_115_1:RecordHistoryTalkVoice("story_v_out_221031", "221031027", "story_v_out_221031.awb")
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

		arg_115_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
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
	Play221031028 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 221031028
		arg_119_1.duration_ = 6.23

		local var_119_0 = {
			ja = 6.233,
			ko = 5.7,
			zh = 5.7
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
				arg_119_0:Play221031029(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 then
				arg_119_1.var_.moveOldPos1072ui_story = arg_119_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_122_0 = 0.001

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_0 then
				arg_119_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_119_1.var_.moveOldPos1072ui_story, Vector3.New(0, -0.71, -6), (arg_119_1.time_ - 0) / var_122_0)
				arg_119_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_119_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_119_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_119_1.actors_["1072ui_story"].transform.position).z)
				arg_119_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_119_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_119_1.actors_["1072ui_story"].transform.localEulerAngles = arg_119_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_119_1.time_ >= 0 + var_122_0 and arg_119_1.time_ < 0 + var_122_0 + arg_122_0 then
				arg_119_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_119_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_119_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_119_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_119_1.actors_["1072ui_story"].transform.position).z)
				arg_119_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_119_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_119_1.actors_["1072ui_story"].transform.localEulerAngles = arg_119_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 then
				arg_119_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action5_1")
			end

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 then
				arg_119_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_122_1 = 0
			local var_122_2 = 0.7

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= var_122_1 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, true)

				arg_119_1.leftNameTxt_.text = arg_119_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_119_1.leftNameTxt_.transform)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1.leftNameTxt_.text)
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_3 = arg_119_1:GetWordFromCfg(221031028)
				local var_122_4 = arg_119_1:FormatText(var_122_3.content)

				arg_119_1.text_.text = var_122_4

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_6 = 28 <= 0 and var_122_2 or var_122_2 * (utf8.len(var_122_4) / 28)

				if (28 <= 0 and var_122_2 or var_122_2 * (utf8.len(var_122_4) / 28)) > 0 and var_122_2 < var_122_6 then
					arg_119_1.talkMaxDuration = var_122_6

					if var_122_6 + var_122_1 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_6 + var_122_1
					end
				end

				arg_119_1.text_.text = var_122_4
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221031", "221031028", "story_v_out_221031.awb") ~= 0 then
					local var_122_7 = manager.audio:GetVoiceLength("story_v_out_221031", "221031028", "story_v_out_221031.awb") / 1000

					if var_122_7 + var_122_1 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_7 + var_122_1
					end

					if var_122_3.prefab_name ~= "" and arg_119_1.actors_[var_122_3.prefab_name] ~= nil then
						local var_122_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_119_1.actors_[var_122_3.prefab_name].transform, "story_v_out_221031", "221031028", "story_v_out_221031.awb")

						arg_119_1:RecordAudio("221031028", var_122_8)
						arg_119_1:RecordAudio("221031028", var_122_8)
					else
						arg_119_1:AudioAction("play", "voice", "story_v_out_221031", "221031028", "story_v_out_221031.awb")
					end

					arg_119_1:RecordHistoryTalkVoice("story_v_out_221031", "221031028", "story_v_out_221031.awb")
				end

				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_9 = math.max(var_122_2, arg_119_1.talkMaxDuration)

			if var_122_1 <= arg_119_1.time_ and arg_119_1.time_ < var_122_1 + var_122_9 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - var_122_1) / var_122_9

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= var_122_1 + var_122_9 and arg_119_1.time_ < var_122_1 + var_122_9 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_119_1:InitPlayNodeList()
	end,
	Play221031029 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 221031029
		arg_123_1.duration_ = 9.27

		local var_123_0 = {
			ja = 9.266,
			ko = 8.166,
			zh = 8.166
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
				arg_123_0:Play221031030(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1.var_.moveOldPos1072ui_story = arg_123_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_126_0 = 0.001

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_0 then
				arg_123_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_123_1.var_.moveOldPos1072ui_story, Vector3.New(0, -0.71, -6), (arg_123_1.time_ - 0) / var_126_0)
				arg_123_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_123_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_123_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_123_1.actors_["1072ui_story"].transform.position).z)
				arg_123_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_123_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_123_1.actors_["1072ui_story"].transform.localEulerAngles = arg_123_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_123_1.time_ >= 0 + var_126_0 and arg_123_1.time_ < 0 + var_126_0 + arg_126_0 then
				arg_123_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_123_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_123_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_123_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_123_1.actors_["1072ui_story"].transform.position).z)
				arg_123_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_123_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_123_1.actors_["1072ui_story"].transform.localEulerAngles = arg_123_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action5_2")
			end

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_126_1 = 0
			local var_126_2 = 0.725

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= var_126_1 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, true)

				arg_123_1.leftNameTxt_.text = arg_123_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_123_1.leftNameTxt_.transform)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1.leftNameTxt_.text)
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_3 = arg_123_1:GetWordFromCfg(221031029)
				local var_126_4 = arg_123_1:FormatText(var_126_3.content)

				arg_123_1.text_.text = var_126_4

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_6 = 30 <= 0 and var_126_2 or var_126_2 * (utf8.len(var_126_4) / 30)

				if (30 <= 0 and var_126_2 or var_126_2 * (utf8.len(var_126_4) / 30)) > 0 and var_126_2 < var_126_6 then
					arg_123_1.talkMaxDuration = var_126_6

					if var_126_6 + var_126_1 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_6 + var_126_1
					end
				end

				arg_123_1.text_.text = var_126_4
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221031", "221031029", "story_v_out_221031.awb") ~= 0 then
					local var_126_7 = manager.audio:GetVoiceLength("story_v_out_221031", "221031029", "story_v_out_221031.awb") / 1000

					if var_126_7 + var_126_1 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_7 + var_126_1
					end

					if var_126_3.prefab_name ~= "" and arg_123_1.actors_[var_126_3.prefab_name] ~= nil then
						local var_126_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_123_1.actors_[var_126_3.prefab_name].transform, "story_v_out_221031", "221031029", "story_v_out_221031.awb")

						arg_123_1:RecordAudio("221031029", var_126_8)
						arg_123_1:RecordAudio("221031029", var_126_8)
					else
						arg_123_1:AudioAction("play", "voice", "story_v_out_221031", "221031029", "story_v_out_221031.awb")
					end

					arg_123_1:RecordHistoryTalkVoice("story_v_out_221031", "221031029", "story_v_out_221031.awb")
				end

				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_9 = math.max(var_126_2, arg_123_1.talkMaxDuration)

			if var_126_1 <= arg_123_1.time_ and arg_123_1.time_ < var_126_1 + var_126_9 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_1) / var_126_9

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_1 + var_126_9 and arg_123_1.time_ < var_126_1 + var_126_9 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_123_1:InitPlayNodeList()
	end,
	Play221031030 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 221031030
		arg_127_1.duration_ = 6.83

		local var_127_0 = {
			ja = 6.833,
			ko = 3.033,
			zh = 3.033
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
				arg_127_0:Play221031031(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 then
				arg_127_1.var_.moveOldPos1072ui_story = arg_127_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_130_0 = 0.001

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_0 then
				arg_127_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_127_1.var_.moveOldPos1072ui_story, Vector3.New(0, -0.71, -6), (arg_127_1.time_ - 0) / var_130_0)
				arg_127_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_127_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_127_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_127_1.actors_["1072ui_story"].transform.position).z)
				arg_127_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_127_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_127_1.actors_["1072ui_story"].transform.localEulerAngles = arg_127_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_127_1.time_ >= 0 + var_130_0 and arg_127_1.time_ < 0 + var_130_0 + arg_130_0 then
				arg_127_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_127_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_127_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_127_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_127_1.actors_["1072ui_story"].transform.position).z)
				arg_127_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_127_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_127_1.actors_["1072ui_story"].transform.localEulerAngles = arg_127_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 then
				arg_127_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_130_1 = 0
			local var_130_2 = 0.2

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= var_130_1 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, true)

				arg_127_1.leftNameTxt_.text = arg_127_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_3 = arg_127_1:GetWordFromCfg(221031030)
				local var_130_4 = arg_127_1:FormatText(var_130_3.content)

				arg_127_1.text_.text = var_130_4

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_6 = 8 <= 0 and var_130_2 or var_130_2 * (utf8.len(var_130_4) / 8)

				if (8 <= 0 and var_130_2 or var_130_2 * (utf8.len(var_130_4) / 8)) > 0 and var_130_2 < var_130_6 then
					arg_127_1.talkMaxDuration = var_130_6

					if var_130_6 + var_130_1 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_6 + var_130_1
					end
				end

				arg_127_1.text_.text = var_130_4
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221031", "221031030", "story_v_out_221031.awb") ~= 0 then
					local var_130_7 = manager.audio:GetVoiceLength("story_v_out_221031", "221031030", "story_v_out_221031.awb") / 1000

					if var_130_7 + var_130_1 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_7 + var_130_1
					end

					if var_130_3.prefab_name ~= "" and arg_127_1.actors_[var_130_3.prefab_name] ~= nil then
						local var_130_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_127_1.actors_[var_130_3.prefab_name].transform, "story_v_out_221031", "221031030", "story_v_out_221031.awb")

						arg_127_1:RecordAudio("221031030", var_130_8)
						arg_127_1:RecordAudio("221031030", var_130_8)
					else
						arg_127_1:AudioAction("play", "voice", "story_v_out_221031", "221031030", "story_v_out_221031.awb")
					end

					arg_127_1:RecordHistoryTalkVoice("story_v_out_221031", "221031030", "story_v_out_221031.awb")
				end

				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_9 = math.max(var_130_2, arg_127_1.talkMaxDuration)

			if var_130_1 <= arg_127_1.time_ and arg_127_1.time_ < var_130_1 + var_130_9 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_1) / var_130_9

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_1 + var_130_9 and arg_127_1.time_ < var_130_1 + var_130_9 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
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
	Play221031031 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 221031031
		arg_131_1.duration_ = 5

		SetActive(arg_131_1.tipsGo_, false)

		function arg_131_1.onSingleLineFinish_()
			arg_131_1.onSingleLineUpdate_ = nil
			arg_131_1.onSingleLineFinish_ = nil
			arg_131_1.state_ = "waiting"
		end

		function arg_131_1.playNext_(arg_133_0)
			if arg_133_0 == 1 then
				arg_131_0:Play221031032(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1.var_.moveOldPos1072ui_story = arg_131_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_134_0 = 0.001

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_0 then
				arg_131_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_131_1.var_.moveOldPos1072ui_story, Vector3.New(0, 100, 0), (arg_131_1.time_ - 0) / var_134_0)
				arg_131_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_131_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_131_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_131_1.actors_["1072ui_story"].transform.position).z)
				arg_131_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_131_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_131_1.actors_["1072ui_story"].transform.localEulerAngles = arg_131_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_131_1.time_ >= 0 + var_134_0 and arg_131_1.time_ < 0 + var_134_0 + arg_134_0 then
				arg_131_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_131_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_131_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_131_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_131_1.actors_["1072ui_story"].transform.position).z)
				arg_131_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_131_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_131_1.actors_["1072ui_story"].transform.localEulerAngles = arg_131_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			local var_134_1 = arg_131_1.actors_["1072ui_story"]

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 and not isNil(var_134_1) and arg_131_1.var_.characterEffect1072ui_story == nil then
				arg_131_1.var_.characterEffect1072ui_story = var_134_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_134_2 = 0.200000002980232

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_2 and not isNil(var_134_1) then
				if arg_131_1.var_.characterEffect1072ui_story and not isNil(var_134_1) then
					arg_131_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_131_1.var_.characterEffect1072ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_131_1.time_ - 0) / var_134_2)
				end
			end

			if arg_131_1.time_ >= 0 + var_134_2 and arg_131_1.time_ < 0 + var_134_2 + arg_134_0 and not isNil(var_134_1) and arg_131_1.var_.characterEffect1072ui_story then
				arg_131_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_131_1.var_.characterEffect1072ui_story.fillRatio = 0.5
			end

			local var_134_3 = 0
			local var_134_4 = 0.65

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= var_134_3 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, false)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_5 = arg_131_1:FormatText(arg_131_1:GetWordFromCfg(221031031).content)

				arg_131_1.text_.text = var_134_5

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_7 = 26 <= 0 and var_134_4 or var_134_4 * (utf8.len(var_134_5) / 26)

				if (26 <= 0 and var_134_4 or var_134_4 * (utf8.len(var_134_5) / 26)) > 0 and var_134_4 < var_134_7 then
					arg_131_1.talkMaxDuration = var_134_7

					if var_134_7 + var_134_3 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_7 + var_134_3
					end
				end

				arg_131_1.text_.text = var_134_5
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)
				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_8 = math.max(var_134_4, arg_131_1.talkMaxDuration)

			if var_134_3 <= arg_131_1.time_ and arg_131_1.time_ < var_134_3 + var_134_8 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - var_134_3) / var_134_8

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= var_134_3 + var_134_8 and arg_131_1.time_ < var_134_3 + var_134_8 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
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
	Play221031032 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 221031032
		arg_135_1.duration_ = 5.6

		local var_135_0 = {
			ja = 3.533,
			ko = 5.6,
			zh = 5.6
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
				arg_135_0:Play221031033(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			if arg_135_1.actors_["1076ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1076ui_story"))) then
				local var_138_0 = Object.Instantiate(Asset.Load("Char/" .. "1076ui_story"), arg_135_1.stage_.transform)

				var_138_0.name = "1076ui_story"
				var_138_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_135_1.actors_["1076ui_story"] = var_138_0

				local var_138_1 = var_138_0:GetComponentInChildren(typeof(CharacterEffect))

				var_138_1.enabled = true

				local var_138_2 = GameObjectTools.GetOrAddComponent(var_138_0, typeof(DynamicBoneHelper))

				if var_138_2 then
					var_138_2:EnableDynamicBone(false)
				end

				arg_135_1:ShowWeapon(var_138_1.transform, false)

				arg_135_1.var_["1076ui_story" .. "Animator"] = var_138_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_135_1.var_["1076ui_story" .. "Animator"].applyRootMotion = true
				arg_135_1.var_["1076ui_story" .. "LipSync"] = var_138_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_138_3 = arg_135_1.actors_["1076ui_story"].transform

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				arg_135_1.var_.moveOldPos1076ui_story = var_138_3.localPosition
			end

			local var_138_4 = 0.001

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_4 then
				var_138_3.localPosition = Vector3.Lerp(arg_135_1.var_.moveOldPos1076ui_story, Vector3.New(0, -1.06, -6.2), (arg_135_1.time_ - 0) / var_138_4)
				var_138_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_138_3.position).x, (manager.ui.mainCamera.transform.position - var_138_3.position).y, (manager.ui.mainCamera.transform.position - var_138_3.position).z)
				var_138_3.localEulerAngles.z = 0
				var_138_3.localEulerAngles.x = 0
				var_138_3.localEulerAngles = var_138_3.localEulerAngles
			end

			if arg_135_1.time_ >= 0 + var_138_4 and arg_135_1.time_ < 0 + var_138_4 + arg_138_0 then
				var_138_3.localPosition = Vector3.New(0, -1.06, -6.2)
				var_138_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_138_3.position).x, (manager.ui.mainCamera.transform.position - var_138_3.position).y, (manager.ui.mainCamera.transform.position - var_138_3.position).z)
				var_138_3.localEulerAngles.z = 0
				var_138_3.localEulerAngles.x = 0
				var_138_3.localEulerAngles = var_138_3.localEulerAngles
			end

			local var_138_5 = arg_135_1.actors_["1076ui_story"]

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 and not isNil(var_138_5) and arg_135_1.var_.characterEffect1076ui_story == nil then
				arg_135_1.var_.characterEffect1076ui_story = var_138_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_138_6 = 0.200000002980232

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_6 and not isNil(var_138_5) then
				if arg_135_1.var_.characterEffect1076ui_story and not isNil(var_138_5) then
					arg_135_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_135_1.time_ >= 0 + var_138_6 and arg_135_1.time_ < 0 + var_138_6 + arg_138_0 and not isNil(var_138_5) and arg_135_1.var_.characterEffect1076ui_story then
				arg_135_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				arg_135_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/story1076/story1076action/1076action1_1")
			end

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				arg_135_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_138_8 = 0
			local var_138_9 = 0.6

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= var_138_8 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				arg_135_1.leftNameTxt_.text = arg_135_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_10 = arg_135_1:GetWordFromCfg(221031032)
				local var_138_11 = arg_135_1:FormatText(var_138_10.content)

				arg_135_1.text_.text = var_138_11

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_13 = 24 <= 0 and var_138_9 or var_138_9 * (utf8.len(var_138_11) / 24)

				if (24 <= 0 and var_138_9 or var_138_9 * (utf8.len(var_138_11) / 24)) > 0 and var_138_9 < var_138_13 then
					arg_135_1.talkMaxDuration = var_138_13

					if var_138_13 + var_138_8 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_13 + var_138_8
					end
				end

				arg_135_1.text_.text = var_138_11
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221031", "221031032", "story_v_out_221031.awb") ~= 0 then
					local var_138_14 = manager.audio:GetVoiceLength("story_v_out_221031", "221031032", "story_v_out_221031.awb") / 1000

					if var_138_14 + var_138_8 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_14 + var_138_8
					end

					if var_138_10.prefab_name ~= "" and arg_135_1.actors_[var_138_10.prefab_name] ~= nil then
						local var_138_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_135_1.actors_[var_138_10.prefab_name].transform, "story_v_out_221031", "221031032", "story_v_out_221031.awb")

						arg_135_1:RecordAudio("221031032", var_138_15)
						arg_135_1:RecordAudio("221031032", var_138_15)
					else
						arg_135_1:AudioAction("play", "voice", "story_v_out_221031", "221031032", "story_v_out_221031.awb")
					end

					arg_135_1:RecordHistoryTalkVoice("story_v_out_221031", "221031032", "story_v_out_221031.awb")
				end

				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_16 = math.max(var_138_9, arg_135_1.talkMaxDuration)

			if var_138_8 <= arg_135_1.time_ and arg_135_1.time_ < var_138_8 + var_138_16 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_8) / var_138_16

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_8 + var_138_16 and arg_135_1.time_ < var_138_8 + var_138_16 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1076ui_story",
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
	Play221031033 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 221031033
		arg_139_1.duration_ = 5

		SetActive(arg_139_1.tipsGo_, false)

		function arg_139_1.onSingleLineFinish_()
			arg_139_1.onSingleLineUpdate_ = nil
			arg_139_1.onSingleLineFinish_ = nil
			arg_139_1.state_ = "waiting"
		end

		function arg_139_1.playNext_(arg_141_0)
			if arg_141_0 == 1 then
				arg_139_0:Play221031034(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1.var_.moveOldPos1076ui_story = arg_139_1.actors_["1076ui_story"].transform.localPosition
			end

			local var_142_0 = 0.001

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_0 then
				arg_139_1.actors_["1076ui_story"].transform.localPosition = Vector3.Lerp(arg_139_1.var_.moveOldPos1076ui_story, Vector3.New(0, 100, 0), (arg_139_1.time_ - 0) / var_142_0)
				arg_139_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_139_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_139_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_139_1.actors_["1076ui_story"].transform.position).z)
				arg_139_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_139_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_139_1.actors_["1076ui_story"].transform.localEulerAngles = arg_139_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			if arg_139_1.time_ >= 0 + var_142_0 and arg_139_1.time_ < 0 + var_142_0 + arg_142_0 then
				arg_139_1.actors_["1076ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_139_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_139_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_139_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_139_1.actors_["1076ui_story"].transform.position).z)
				arg_139_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_139_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_139_1.actors_["1076ui_story"].transform.localEulerAngles = arg_139_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			local var_142_1 = arg_139_1.actors_["1076ui_story"]

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 and not isNil(var_142_1) and arg_139_1.var_.characterEffect1076ui_story == nil then
				arg_139_1.var_.characterEffect1076ui_story = var_142_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_142_2 = 0.200000002980232

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_2 and not isNil(var_142_1) then
				if arg_139_1.var_.characterEffect1076ui_story and not isNil(var_142_1) then
					arg_139_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_139_1.var_.characterEffect1076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_139_1.time_ - 0) / var_142_2)
				end
			end

			if arg_139_1.time_ >= 0 + var_142_2 and arg_139_1.time_ < 0 + var_142_2 + arg_142_0 and not isNil(var_142_1) and arg_139_1.var_.characterEffect1076ui_story then
				arg_139_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_139_1.var_.characterEffect1076ui_story.fillRatio = 0.5
			end

			local var_142_3 = 0
			local var_142_4 = 1.225

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= var_142_3 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, false)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_5 = arg_139_1:FormatText(arg_139_1:GetWordFromCfg(221031033).content)

				arg_139_1.text_.text = var_142_5

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_7 = 49 <= 0 and var_142_4 or var_142_4 * (utf8.len(var_142_5) / 49)

				if (49 <= 0 and var_142_4 or var_142_4 * (utf8.len(var_142_5) / 49)) > 0 and var_142_4 < var_142_7 then
					arg_139_1.talkMaxDuration = var_142_7

					if var_142_7 + var_142_3 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_7 + var_142_3
					end
				end

				arg_139_1.text_.text = var_142_5
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)
				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_8 = math.max(var_142_4, arg_139_1.talkMaxDuration)

			if var_142_3 <= arg_139_1.time_ and arg_139_1.time_ < var_142_3 + var_142_8 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_3) / var_142_8

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_3 + var_142_8 and arg_139_1.time_ < var_142_3 + var_142_8 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1076ui_story",
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
	Play221031034 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 221031034
		arg_143_1.duration_ = 5

		SetActive(arg_143_1.tipsGo_, false)

		function arg_143_1.onSingleLineFinish_()
			arg_143_1.onSingleLineUpdate_ = nil
			arg_143_1.onSingleLineFinish_ = nil
			arg_143_1.state_ = "waiting"
		end

		function arg_143_1.playNext_(arg_145_0)
			if arg_145_0 == 1 then
				arg_143_0:Play221031035(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			local var_146_0 = 1.2

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, false)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_143_1.iconTrs_.gameObject, false)
				arg_143_1.callingController_:SetSelectedState("normal")

				local var_146_1 = arg_143_1:FormatText(arg_143_1:GetWordFromCfg(221031034).content)

				arg_143_1.text_.text = var_146_1

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_3 = 48 <= 0 and var_146_0 or var_146_0 * (utf8.len(var_146_1) / 48)

				if (48 <= 0 and var_146_0 or var_146_0 * (utf8.len(var_146_1) / 48)) > 0 and var_146_0 < var_146_3 then
					arg_143_1.talkMaxDuration = var_146_3

					if var_146_3 + 0 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_3 + 0
					end
				end

				arg_143_1.text_.text = var_146_1
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)
				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_4 = math.max(var_146_0, arg_143_1.talkMaxDuration)

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_4 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - 0) / var_146_4

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= 0 + var_146_4 and arg_143_1.time_ < 0 + var_146_4 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {}

		arg_143_1:InitPlayNodeList()
	end,
	Play221031035 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 221031035
		arg_147_1.duration_ = 5.73

		local var_147_0 = {
			ja = 5.533,
			ko = 5.733,
			zh = 5.733
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
				arg_147_0:Play221031036(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 then
				arg_147_1.var_.moveOldPos1076ui_story = arg_147_1.actors_["1076ui_story"].transform.localPosition
			end

			local var_150_0 = 0.001

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_0 then
				arg_147_1.actors_["1076ui_story"].transform.localPosition = Vector3.Lerp(arg_147_1.var_.moveOldPos1076ui_story, Vector3.New(0, -1.06, -6.2), (arg_147_1.time_ - 0) / var_150_0)
				arg_147_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_147_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_147_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_147_1.actors_["1076ui_story"].transform.position).z)
				arg_147_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_147_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_147_1.actors_["1076ui_story"].transform.localEulerAngles = arg_147_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			if arg_147_1.time_ >= 0 + var_150_0 and arg_147_1.time_ < 0 + var_150_0 + arg_150_0 then
				arg_147_1.actors_["1076ui_story"].transform.localPosition = Vector3.New(0, -1.06, -6.2)
				arg_147_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_147_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_147_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_147_1.actors_["1076ui_story"].transform.position).z)
				arg_147_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_147_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_147_1.actors_["1076ui_story"].transform.localEulerAngles = arg_147_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			local var_150_1 = arg_147_1.actors_["1076ui_story"]

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 and not isNil(var_150_1) and arg_147_1.var_.characterEffect1076ui_story == nil then
				arg_147_1.var_.characterEffect1076ui_story = var_150_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_150_2 = 0.200000002980232

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_2 and not isNil(var_150_1) then
				if arg_147_1.var_.characterEffect1076ui_story and not isNil(var_150_1) then
					arg_147_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_147_1.time_ >= 0 + var_150_2 and arg_147_1.time_ < 0 + var_150_2 + arg_150_0 and not isNil(var_150_1) and arg_147_1.var_.characterEffect1076ui_story then
				arg_147_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 then
				arg_147_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/story1076/story1076action/1076action2_1")
			end

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 then
				arg_147_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_150_4 = 0
			local var_150_5 = 0.5

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= var_150_4 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, true)

				arg_147_1.leftNameTxt_.text = arg_147_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_6 = arg_147_1:GetWordFromCfg(221031035)
				local var_150_7 = arg_147_1:FormatText(var_150_6.content)

				arg_147_1.text_.text = var_150_7

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_9 = 20 <= 0 and var_150_5 or var_150_5 * (utf8.len(var_150_7) / 20)

				if (20 <= 0 and var_150_5 or var_150_5 * (utf8.len(var_150_7) / 20)) > 0 and var_150_5 < var_150_9 then
					arg_147_1.talkMaxDuration = var_150_9

					if var_150_9 + var_150_4 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_9 + var_150_4
					end
				end

				arg_147_1.text_.text = var_150_7
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221031", "221031035", "story_v_out_221031.awb") ~= 0 then
					local var_150_10 = manager.audio:GetVoiceLength("story_v_out_221031", "221031035", "story_v_out_221031.awb") / 1000

					if var_150_10 + var_150_4 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_10 + var_150_4
					end

					if var_150_6.prefab_name ~= "" and arg_147_1.actors_[var_150_6.prefab_name] ~= nil then
						local var_150_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_147_1.actors_[var_150_6.prefab_name].transform, "story_v_out_221031", "221031035", "story_v_out_221031.awb")

						arg_147_1:RecordAudio("221031035", var_150_11)
						arg_147_1:RecordAudio("221031035", var_150_11)
					else
						arg_147_1:AudioAction("play", "voice", "story_v_out_221031", "221031035", "story_v_out_221031.awb")
					end

					arg_147_1:RecordHistoryTalkVoice("story_v_out_221031", "221031035", "story_v_out_221031.awb")
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

		arg_147_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_147_1:InitPlayNodeList()
	end,
	Play221031036 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 221031036
		arg_151_1.duration_ = 5

		SetActive(arg_151_1.tipsGo_, false)

		function arg_151_1.onSingleLineFinish_()
			arg_151_1.onSingleLineUpdate_ = nil
			arg_151_1.onSingleLineFinish_ = nil
			arg_151_1.state_ = "waiting"
		end

		function arg_151_1.playNext_(arg_153_0)
			if arg_153_0 == 1 then
				arg_151_0:Play221031037(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 and not isNil(arg_151_1.actors_["1076ui_story"]) and arg_151_1.var_.characterEffect1076ui_story == nil then
				arg_151_1.var_.characterEffect1076ui_story = arg_151_1.actors_["1076ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_154_0 = 0.200000002980232

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_0 and not isNil(arg_151_1.actors_["1076ui_story"]) then
				if arg_151_1.var_.characterEffect1076ui_story and not isNil(arg_151_1.actors_["1076ui_story"]) then
					arg_151_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_151_1.var_.characterEffect1076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_151_1.time_ - 0) / var_154_0)
				end
			end

			if arg_151_1.time_ >= 0 + var_154_0 and arg_151_1.time_ < 0 + var_154_0 + arg_154_0 and not isNil(arg_151_1.actors_["1076ui_story"]) and arg_151_1.var_.characterEffect1076ui_story then
				arg_151_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_151_1.var_.characterEffect1076ui_story.fillRatio = 0.5
			end

			local var_154_1 = arg_151_1.actors_["1076ui_story"].transform

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 then
				arg_151_1.var_.moveOldPos1076ui_story = var_154_1.localPosition
			end

			local var_154_2 = 0.001

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_2 then
				var_154_1.localPosition = Vector3.Lerp(arg_151_1.var_.moveOldPos1076ui_story, Vector3.New(0, 100, 0), (arg_151_1.time_ - 0) / var_154_2)
				var_154_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_154_1.position).x, (manager.ui.mainCamera.transform.position - var_154_1.position).y, (manager.ui.mainCamera.transform.position - var_154_1.position).z)
				var_154_1.localEulerAngles.z = 0
				var_154_1.localEulerAngles.x = 0
				var_154_1.localEulerAngles = var_154_1.localEulerAngles
			end

			if arg_151_1.time_ >= 0 + var_154_2 and arg_151_1.time_ < 0 + var_154_2 + arg_154_0 then
				var_154_1.localPosition = Vector3.New(0, 100, 0)
				var_154_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_154_1.position).x, (manager.ui.mainCamera.transform.position - var_154_1.position).y, (manager.ui.mainCamera.transform.position - var_154_1.position).z)
				var_154_1.localEulerAngles.z = 0
				var_154_1.localEulerAngles.x = 0
				var_154_1.localEulerAngles = var_154_1.localEulerAngles
			end

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 then
				arg_151_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_154_5 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_151_1.bgmTxt_.text ~= var_154_5 and arg_151_1.bgmTxt_.text ~= "" then
						if arg_151_1.bgmTxt2_.text ~= "" then
							arg_151_1.bgmTxt_.text = arg_151_1.bgmTxt2_.text
						end

						arg_151_1.bgmTxt2_.text = var_154_5

						arg_151_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_151_1.bgmTxt_.text = var_154_5
						arg_151_1.bgmTxt2_.text = var_154_5
					end

					if arg_151_1.bgmTimer then
						arg_151_1.bgmTimer:Stop()

						arg_151_1.bgmTimer = nil
					end

					if arg_151_1.settingData.show_music_name == 1 then
						arg_151_1.musicController:SetSelectedState("show")
						arg_151_1.musicAnimator_:Play("open", 0, 0)

						if arg_151_1.settingData.music_time ~= 0 then
							arg_151_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_151_1.settingData.music_time), function()
								if arg_151_1 == nil or isNil(arg_151_1.bgmTxt_) then
									return
								end

								arg_151_1.musicController:SetSelectedState("hide")
								arg_151_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_154_6 = 0
			local var_154_7 = 1.925

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= var_154_6 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, false)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_151_1.iconTrs_.gameObject, false)
				arg_151_1.callingController_:SetSelectedState("normal")

				local var_154_8 = arg_151_1:FormatText(arg_151_1:GetWordFromCfg(221031036).content)

				arg_151_1.text_.text = var_154_8

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_10 = 77 <= 0 and var_154_7 or var_154_7 * (utf8.len(var_154_8) / 77)

				if (77 <= 0 and var_154_7 or var_154_7 * (utf8.len(var_154_8) / 77)) > 0 and var_154_7 < var_154_10 then
					arg_151_1.talkMaxDuration = var_154_10

					if var_154_10 + var_154_6 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_10 + var_154_6
					end
				end

				arg_151_1.text_.text = var_154_8
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)
				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_11 = math.max(var_154_7, arg_151_1.talkMaxDuration)

			if var_154_6 <= arg_151_1.time_ and arg_151_1.time_ < var_154_6 + var_154_11 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - var_154_6) / var_154_11

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= var_154_6 + var_154_11 and arg_151_1.time_ < var_154_6 + var_154_11 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1076ui_story",
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
	Play221031037 = function(arg_156_0, arg_156_1)
		arg_156_1.time_ = 0
		arg_156_1.frameCnt_ = 0
		arg_156_1.state_ = "playing"
		arg_156_1.curTalkId_ = 221031037
		arg_156_1.duration_ = 1.17

		local var_156_0 = {
			ja = 1.166,
			ko = 0.999999999999,
			zh = 0.999999999999
		}
		local var_156_1 = manager.audio:GetLocalizationFlag()

		if var_156_0[var_156_1] ~= nil then
			arg_156_1.duration_ = var_156_0[var_156_1]
		end

		SetActive(arg_156_1.tipsGo_, false)

		function arg_156_1.onSingleLineFinish_()
			arg_156_1.onSingleLineUpdate_ = nil
			arg_156_1.onSingleLineFinish_ = nil
			arg_156_1.state_ = "waiting"
		end

		function arg_156_1.playNext_(arg_158_0)
			if arg_158_0 == 1 then
				arg_156_0:Play221031038(arg_156_1)
			end
		end

		function arg_156_1.onSingleLineUpdate_(arg_159_0)
			if 0 < arg_156_1.time_ and arg_156_1.time_ <= 0 + arg_159_0 then
				arg_156_1.var_.moveOldPos1076ui_story = arg_156_1.actors_["1076ui_story"].transform.localPosition
			end

			local var_159_0 = 0.001

			if 0 <= arg_156_1.time_ and arg_156_1.time_ < 0 + var_159_0 then
				arg_156_1.actors_["1076ui_story"].transform.localPosition = Vector3.Lerp(arg_156_1.var_.moveOldPos1076ui_story, Vector3.New(0, -1.06, -6.2), (arg_156_1.time_ - 0) / var_159_0)
				arg_156_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_156_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_156_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_156_1.actors_["1076ui_story"].transform.position).z)
				arg_156_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_156_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_156_1.actors_["1076ui_story"].transform.localEulerAngles = arg_156_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			if arg_156_1.time_ >= 0 + var_159_0 and arg_156_1.time_ < 0 + var_159_0 + arg_159_0 then
				arg_156_1.actors_["1076ui_story"].transform.localPosition = Vector3.New(0, -1.06, -6.2)
				arg_156_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_156_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_156_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_156_1.actors_["1076ui_story"].transform.position).z)
				arg_156_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_156_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_156_1.actors_["1076ui_story"].transform.localEulerAngles = arg_156_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			local var_159_1 = arg_156_1.actors_["1076ui_story"]

			if 0 < arg_156_1.time_ and arg_156_1.time_ <= 0 + arg_159_0 and not isNil(var_159_1) and arg_156_1.var_.characterEffect1076ui_story == nil then
				arg_156_1.var_.characterEffect1076ui_story = var_159_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_159_2 = 0.200000002980232

			if 0 <= arg_156_1.time_ and arg_156_1.time_ < 0 + var_159_2 and not isNil(var_159_1) then
				if arg_156_1.var_.characterEffect1076ui_story and not isNil(var_159_1) then
					arg_156_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_156_1.time_ >= 0 + var_159_2 and arg_156_1.time_ < 0 + var_159_2 + arg_159_0 and not isNil(var_159_1) and arg_156_1.var_.characterEffect1076ui_story then
				arg_156_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			if 0 < arg_156_1.time_ and arg_156_1.time_ <= 0 + arg_159_0 then
				arg_156_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/story1076/story1076action/1076action1_1")
			end

			if 0 < arg_156_1.time_ and arg_156_1.time_ <= 0 + arg_159_0 then
				arg_156_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_159_4 = 0
			local var_159_5 = 0.05

			if 0 < arg_156_1.time_ and arg_156_1.time_ <= var_159_4 + arg_159_0 then
				arg_156_1.talkMaxDuration = 0
				arg_156_1.dialogCg_.alpha = 1

				arg_156_1.dialog_:SetActive(true)
				SetActive(arg_156_1.leftNameGo_, true)

				arg_156_1.leftNameTxt_.text = arg_156_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_156_1.leftNameTxt_.transform)

				arg_156_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_156_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_156_1:RecordName(arg_156_1.leftNameTxt_.text)
				SetActive(arg_156_1.iconTrs_.gameObject, false)
				arg_156_1.callingController_:SetSelectedState("normal")

				local var_159_6 = arg_156_1:GetWordFromCfg(221031037)
				local var_159_7 = arg_156_1:FormatText(var_159_6.content)

				arg_156_1.text_.text = var_159_7

				LuaForUtil.ClearLinePrefixSymbol(arg_156_1.text_)

				local var_159_9 = 2 <= 0 and var_159_5 or var_159_5 * (utf8.len(var_159_7) / 2)

				if (2 <= 0 and var_159_5 or var_159_5 * (utf8.len(var_159_7) / 2)) > 0 and var_159_5 < var_159_9 then
					arg_156_1.talkMaxDuration = var_159_9

					if var_159_9 + var_159_4 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_9 + var_159_4
					end
				end

				arg_156_1.text_.text = var_159_7
				arg_156_1.typewritter.percent = 0

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221031", "221031037", "story_v_out_221031.awb") ~= 0 then
					local var_159_10 = manager.audio:GetVoiceLength("story_v_out_221031", "221031037", "story_v_out_221031.awb") / 1000

					if var_159_10 + var_159_4 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_10 + var_159_4
					end

					if var_159_6.prefab_name ~= "" and arg_156_1.actors_[var_159_6.prefab_name] ~= nil then
						local var_159_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_156_1.actors_[var_159_6.prefab_name].transform, "story_v_out_221031", "221031037", "story_v_out_221031.awb")

						arg_156_1:RecordAudio("221031037", var_159_11)
						arg_156_1:RecordAudio("221031037", var_159_11)
					else
						arg_156_1:AudioAction("play", "voice", "story_v_out_221031", "221031037", "story_v_out_221031.awb")
					end

					arg_156_1:RecordHistoryTalkVoice("story_v_out_221031", "221031037", "story_v_out_221031.awb")
				end

				arg_156_1:RecordContent(arg_156_1.text_.text)
			end

			local var_159_12 = math.max(var_159_5, arg_156_1.talkMaxDuration)

			if var_159_4 <= arg_156_1.time_ and arg_156_1.time_ < var_159_4 + var_159_12 then
				arg_156_1.typewritter.percent = (arg_156_1.time_ - var_159_4) / var_159_12

				arg_156_1.typewritter:SetDirty()
			end

			if arg_156_1.time_ >= var_159_4 + var_159_12 and arg_156_1.time_ < var_159_4 + var_159_12 + arg_159_0 then
				arg_156_1.typewritter.percent = 1

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(true)
			end
		end

		arg_156_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_156_1:InitPlayNodeList()
	end,
	Play221031038 = function(arg_160_0, arg_160_1)
		arg_160_1.time_ = 0
		arg_160_1.frameCnt_ = 0
		arg_160_1.state_ = "playing"
		arg_160_1.curTalkId_ = 221031038
		arg_160_1.duration_ = 9

		SetActive(arg_160_1.tipsGo_, false)

		function arg_160_1.onSingleLineFinish_()
			arg_160_1.onSingleLineUpdate_ = nil
			arg_160_1.onSingleLineFinish_ = nil
			arg_160_1.state_ = "waiting"
		end

		function arg_160_1.playNext_(arg_162_0)
			if arg_162_0 == 1 then
				arg_160_0:Play221031039(arg_160_1)
			end
		end

		function arg_160_1.onSingleLineUpdate_(arg_163_0)
			if arg_160_1.bgs_.ST39 == nil then
				local var_163_0 = Object.Instantiate(arg_160_1.paintGo_)

				var_163_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST39")
				var_163_0.name = "ST39"
				var_163_0.transform.parent = arg_160_1.stage_.transform
				var_163_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_160_1.bgs_.ST39 = var_163_0
			end

			if 2 < arg_160_1.time_ and arg_160_1.time_ <= 2 + arg_163_0 then
				local var_163_1 = arg_160_1.bgs_.ST39

				arg_160_1.bgs_.ST39.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_163_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_163_2 = var_163_1:GetComponent("SpriteRenderer")

				if var_163_2 and var_163_2.sprite then
					local var_163_3 = 2 * (var_163_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_163_1.transform.localScale = Vector3.New(var_163_3 / var_163_2.sprite.bounds.size.y < var_163_3 * manager.ui.mainCameraCom_.aspect / var_163_2.sprite.bounds.size.x and var_163_3 * manager.ui.mainCameraCom_.aspect / var_163_2.sprite.bounds.size.x or var_163_3 / var_163_2.sprite.bounds.size.y, var_163_3 / var_163_2.sprite.bounds.size.y < var_163_3 * manager.ui.mainCameraCom_.aspect / var_163_2.sprite.bounds.size.x and var_163_3 * manager.ui.mainCameraCom_.aspect / var_163_2.sprite.bounds.size.x or var_163_3 / var_163_2.sprite.bounds.size.y, 0)
				end

				for iter_163_0, iter_163_1 in pairs(arg_160_1.bgs_) do
					if iter_163_0 ~= "ST39" then
						iter_163_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_163_4 = 0

			if 0 < arg_160_1.time_ and arg_160_1.time_ <= var_163_4 + arg_163_0 then
				arg_160_1.mask_.enabled = true
				arg_160_1.mask_.raycastTarget = true

				arg_160_1:SetGaussion(false)
			end

			local var_163_5 = 2

			if var_163_4 <= arg_160_1.time_ and arg_160_1.time_ < var_163_4 + var_163_5 then
				local var_163_6 = Color.New(0, 0, 0)

				var_163_6.a = Mathf.Lerp(0, 1, (arg_160_1.time_ - var_163_4) / var_163_5)
				arg_160_1.mask_.color = var_163_6
			end

			if arg_160_1.time_ >= var_163_4 + var_163_5 and arg_160_1.time_ < var_163_4 + var_163_5 + arg_163_0 then
				local var_163_7 = Color.New(0, 0, 0)

				var_163_7.a = 1
				arg_160_1.mask_.color = var_163_7
			end

			local var_163_8 = 2

			if 2 < arg_160_1.time_ and arg_160_1.time_ <= var_163_8 + arg_163_0 then
				arg_160_1.mask_.enabled = true
				arg_160_1.mask_.raycastTarget = true

				arg_160_1:SetGaussion(false)
			end

			local var_163_9 = 2

			if var_163_8 <= arg_160_1.time_ and arg_160_1.time_ < var_163_8 + var_163_9 then
				local var_163_10 = Color.New(0, 0, 0)

				var_163_10.a = Mathf.Lerp(1, 0, (arg_160_1.time_ - var_163_8) / var_163_9)
				arg_160_1.mask_.color = var_163_10
			end

			if arg_160_1.time_ >= var_163_8 + var_163_9 and arg_160_1.time_ < var_163_8 + var_163_9 + arg_163_0 then
				local var_163_11 = Color.New(0, 0, 0)

				arg_160_1.mask_.enabled = false
				var_163_11.a = 0
				arg_160_1.mask_.color = var_163_11
			end

			local var_163_12 = arg_160_1.actors_["1076ui_story"].transform

			if 0 < arg_160_1.time_ and arg_160_1.time_ <= 0 + arg_163_0 then
				arg_160_1.var_.moveOldPos1076ui_story = var_163_12.localPosition
			end

			local var_163_13 = 0.001

			if 0 <= arg_160_1.time_ and arg_160_1.time_ < 0 + var_163_13 then
				var_163_12.localPosition = Vector3.Lerp(arg_160_1.var_.moveOldPos1076ui_story, Vector3.New(0, 100, 0), (arg_160_1.time_ - 0) / var_163_13)
				var_163_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_163_12.position).x, (manager.ui.mainCamera.transform.position - var_163_12.position).y, (manager.ui.mainCamera.transform.position - var_163_12.position).z)
				var_163_12.localEulerAngles.z = 0
				var_163_12.localEulerAngles.x = 0
				var_163_12.localEulerAngles = var_163_12.localEulerAngles
			end

			if arg_160_1.time_ >= 0 + var_163_13 and arg_160_1.time_ < 0 + var_163_13 + arg_163_0 then
				var_163_12.localPosition = Vector3.New(0, 100, 0)
				var_163_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_163_12.position).x, (manager.ui.mainCamera.transform.position - var_163_12.position).y, (manager.ui.mainCamera.transform.position - var_163_12.position).z)
				var_163_12.localEulerAngles.z = 0
				var_163_12.localEulerAngles.x = 0
				var_163_12.localEulerAngles = var_163_12.localEulerAngles
			end

			local var_163_14 = arg_160_1.actors_["1076ui_story"]

			if 0 < arg_160_1.time_ and arg_160_1.time_ <= 0 + arg_163_0 and not isNil(var_163_14) and arg_160_1.var_.characterEffect1076ui_story == nil then
				arg_160_1.var_.characterEffect1076ui_story = var_163_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_163_15 = 0.200000002980232

			if 0 <= arg_160_1.time_ and arg_160_1.time_ < 0 + var_163_15 and not isNil(var_163_14) then
				if arg_160_1.var_.characterEffect1076ui_story and not isNil(var_163_14) then
					arg_160_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_160_1.var_.characterEffect1076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_160_1.time_ - 0) / var_163_15)
				end
			end

			if arg_160_1.time_ >= 0 + var_163_15 and arg_160_1.time_ < 0 + var_163_15 + arg_163_0 and not isNil(var_163_14) and arg_160_1.var_.characterEffect1076ui_story then
				arg_160_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_160_1.var_.characterEffect1076ui_story.fillRatio = 0.5
			end

			if 0 < arg_160_1.time_ and arg_160_1.time_ <= 0 + arg_163_0 then
				arg_160_1:AudioAction("stop", "effect", "se_story_side_1096", "se_story_1096_crowd_loop", "")
			end

			if 0 < arg_160_1.time_ and arg_160_1.time_ <= 0 + arg_163_0 then
				arg_160_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_163_19 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_160_1.bgmTxt_.text ~= var_163_19 and arg_160_1.bgmTxt_.text ~= "" then
						if arg_160_1.bgmTxt2_.text ~= "" then
							arg_160_1.bgmTxt_.text = arg_160_1.bgmTxt2_.text
						end

						arg_160_1.bgmTxt2_.text = var_163_19

						arg_160_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_160_1.bgmTxt_.text = var_163_19
						arg_160_1.bgmTxt2_.text = var_163_19
					end

					if arg_160_1.bgmTimer then
						arg_160_1.bgmTimer:Stop()

						arg_160_1.bgmTimer = nil
					end

					if arg_160_1.settingData.show_music_name == 1 then
						arg_160_1.musicController:SetSelectedState("show")
						arg_160_1.musicAnimator_:Play("open", 0, 0)

						if arg_160_1.settingData.music_time ~= 0 then
							arg_160_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_160_1.settingData.music_time), function()
								if arg_160_1 == nil or isNil(arg_160_1.bgmTxt_) then
									return
								end

								arg_160_1.musicController:SetSelectedState("hide")
								arg_160_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.8 < arg_160_1.time_ and arg_160_1.time_ <= 0.8 + arg_163_0 then
				arg_160_1:AudioAction("play", "music", "bgm_activity_2_0_warchess", "bgm_activity_2_0_warchess", "bgm_activity_2_0_warchess.awb")

				local var_163_22 = manager.audio:GetAudioName("bgm_activity_2_0_warchess", "bgm_activity_2_0_warchess")

				if "" ~= "" then
					if arg_160_1.bgmTxt_.text ~= var_163_22 and arg_160_1.bgmTxt_.text ~= "" then
						if arg_160_1.bgmTxt2_.text ~= "" then
							arg_160_1.bgmTxt_.text = arg_160_1.bgmTxt2_.text
						end

						arg_160_1.bgmTxt2_.text = var_163_22

						arg_160_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_160_1.bgmTxt_.text = var_163_22
						arg_160_1.bgmTxt2_.text = var_163_22
					end

					if arg_160_1.bgmTimer then
						arg_160_1.bgmTimer:Stop()

						arg_160_1.bgmTimer = nil
					end

					if arg_160_1.settingData.show_music_name == 1 then
						arg_160_1.musicController:SetSelectedState("show")
						arg_160_1.musicAnimator_:Play("open", 0, 0)

						if arg_160_1.settingData.music_time ~= 0 then
							arg_160_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_160_1.settingData.music_time), function()
								if arg_160_1 == nil or isNil(arg_160_1.bgmTxt_) then
									return
								end

								arg_160_1.musicController:SetSelectedState("hide")
								arg_160_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_160_1.frameCnt_ <= 1 then
				arg_160_1.dialog_:SetActive(false)
			end

			local var_163_23 = 4
			local var_163_24 = 1.125

			if 4 < arg_160_1.time_ and arg_160_1.time_ <= var_163_23 + arg_163_0 then
				arg_160_1.talkMaxDuration = 0

				arg_160_1.dialog_:SetActive(true)

				arg_160_1.dialogCg_.alpha = 0

				local var_163_25 = LeanTween.value(arg_160_1.dialog_, 0, 1, 0.3)

				var_163_25:setOnUpdate(LuaHelper.FloatAction(function(arg_166_0)
					arg_160_1.dialogCg_.alpha = arg_166_0
				end))
				var_163_25:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_160_1.dialog_)
					var_163_25:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_160_1.duration_ = arg_160_1.duration_ + 0.3

				SetActive(arg_160_1.leftNameGo_, false)

				arg_160_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_160_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_160_1:RecordName(arg_160_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_160_1.iconTrs_.gameObject, false)
				arg_160_1.callingController_:SetSelectedState("normal")

				local var_163_26 = arg_160_1:FormatText(arg_160_1:GetWordFromCfg(221031038).content)

				arg_160_1.text_.text = var_163_26

				LuaForUtil.ClearLinePrefixSymbol(arg_160_1.text_)

				local var_163_28 = 45 <= 0 and var_163_24 or var_163_24 * (utf8.len(var_163_26) / 45)

				if (45 <= 0 and var_163_24 or var_163_24 * (utf8.len(var_163_26) / 45)) > 0 and var_163_24 < var_163_28 then
					arg_160_1.talkMaxDuration = var_163_28
					var_163_23 = var_163_23 + 0.3

					if var_163_28 + var_163_23 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_28 + var_163_23
					end
				end

				arg_160_1.text_.text = var_163_26
				arg_160_1.typewritter.percent = 0

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(false)
				arg_160_1:RecordContent(arg_160_1.text_.text)
			end

			local var_163_29 = var_163_23 + 0.3
			local var_163_30 = math.max(var_163_24, arg_160_1.talkMaxDuration)

			if var_163_23 + 0.3 <= arg_160_1.time_ and arg_160_1.time_ < var_163_29 + var_163_30 then
				arg_160_1.typewritter.percent = (arg_160_1.time_ - var_163_29) / var_163_30

				arg_160_1.typewritter:SetDirty()
			end

			if arg_160_1.time_ >= var_163_29 + var_163_30 and arg_160_1.time_ < var_163_29 + var_163_30 + arg_163_0 then
				arg_160_1.typewritter.percent = 1

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(true)
			end
		end

		arg_160_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_160_1:InitPlayNodeList()
	end,
	Play221031039 = function(arg_168_0, arg_168_1)
		arg_168_1.time_ = 0
		arg_168_1.frameCnt_ = 0
		arg_168_1.state_ = "playing"
		arg_168_1.curTalkId_ = 221031039
		arg_168_1.duration_ = 3.8

		local var_168_0 = {
			ja = 3.8,
			ko = 2.1,
			zh = 2.1
		}
		local var_168_1 = manager.audio:GetLocalizationFlag()

		if var_168_0[var_168_1] ~= nil then
			arg_168_1.duration_ = var_168_0[var_168_1]
		end

		SetActive(arg_168_1.tipsGo_, false)

		function arg_168_1.onSingleLineFinish_()
			arg_168_1.onSingleLineUpdate_ = nil
			arg_168_1.onSingleLineFinish_ = nil
			arg_168_1.state_ = "waiting"
		end

		function arg_168_1.playNext_(arg_170_0)
			if arg_170_0 == 1 then
				arg_168_0:Play221031040(arg_168_1)
			end
		end

		function arg_168_1.onSingleLineUpdate_(arg_171_0)
			if 0 < arg_168_1.time_ and arg_168_1.time_ <= 0 + arg_171_0 then
				arg_168_1.var_.moveOldPos1072ui_story = arg_168_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_171_0 = 0.001

			if 0 <= arg_168_1.time_ and arg_168_1.time_ < 0 + var_171_0 then
				arg_168_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_168_1.var_.moveOldPos1072ui_story, Vector3.New(0, -0.71, -6), (arg_168_1.time_ - 0) / var_171_0)
				arg_168_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_168_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_168_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_168_1.actors_["1072ui_story"].transform.position).z)
				arg_168_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_168_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_168_1.actors_["1072ui_story"].transform.localEulerAngles = arg_168_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_168_1.time_ >= 0 + var_171_0 and arg_168_1.time_ < 0 + var_171_0 + arg_171_0 then
				arg_168_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_168_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_168_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_168_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_168_1.actors_["1072ui_story"].transform.position).z)
				arg_168_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_168_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_168_1.actors_["1072ui_story"].transform.localEulerAngles = arg_168_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			local var_171_1 = arg_168_1.actors_["1072ui_story"]

			if 0 < arg_168_1.time_ and arg_168_1.time_ <= 0 + arg_171_0 and not isNil(var_171_1) and arg_168_1.var_.characterEffect1072ui_story == nil then
				arg_168_1.var_.characterEffect1072ui_story = var_171_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_171_2 = 0.200000002980232

			if 0 <= arg_168_1.time_ and arg_168_1.time_ < 0 + var_171_2 and not isNil(var_171_1) then
				if arg_168_1.var_.characterEffect1072ui_story and not isNil(var_171_1) then
					arg_168_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_168_1.time_ >= 0 + var_171_2 and arg_168_1.time_ < 0 + var_171_2 + arg_171_0 and not isNil(var_171_1) and arg_168_1.var_.characterEffect1072ui_story then
				arg_168_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			if 0 < arg_168_1.time_ and arg_168_1.time_ <= 0 + arg_171_0 then
				arg_168_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action1_1")
			end

			if 0 < arg_168_1.time_ and arg_168_1.time_ <= 0 + arg_171_0 then
				arg_168_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_171_4 = 0
			local var_171_5 = 0.225

			if 0 < arg_168_1.time_ and arg_168_1.time_ <= var_171_4 + arg_171_0 then
				arg_168_1.talkMaxDuration = 0
				arg_168_1.dialogCg_.alpha = 1

				arg_168_1.dialog_:SetActive(true)
				SetActive(arg_168_1.leftNameGo_, true)

				arg_168_1.leftNameTxt_.text = arg_168_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_168_1.leftNameTxt_.transform)

				arg_168_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_168_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_168_1:RecordName(arg_168_1.leftNameTxt_.text)
				SetActive(arg_168_1.iconTrs_.gameObject, false)
				arg_168_1.callingController_:SetSelectedState("normal")

				local var_171_6 = arg_168_1:GetWordFromCfg(221031039)
				local var_171_7 = arg_168_1:FormatText(var_171_6.content)

				arg_168_1.text_.text = var_171_7

				LuaForUtil.ClearLinePrefixSymbol(arg_168_1.text_)

				local var_171_9 = 9 <= 0 and var_171_5 or var_171_5 * (utf8.len(var_171_7) / 9)

				if (9 <= 0 and var_171_5 or var_171_5 * (utf8.len(var_171_7) / 9)) > 0 and var_171_5 < var_171_9 then
					arg_168_1.talkMaxDuration = var_171_9

					if var_171_9 + var_171_4 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_9 + var_171_4
					end
				end

				arg_168_1.text_.text = var_171_7
				arg_168_1.typewritter.percent = 0

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221031", "221031039", "story_v_out_221031.awb") ~= 0 then
					local var_171_10 = manager.audio:GetVoiceLength("story_v_out_221031", "221031039", "story_v_out_221031.awb") / 1000

					if var_171_10 + var_171_4 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_10 + var_171_4
					end

					if var_171_6.prefab_name ~= "" and arg_168_1.actors_[var_171_6.prefab_name] ~= nil then
						local var_171_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_168_1.actors_[var_171_6.prefab_name].transform, "story_v_out_221031", "221031039", "story_v_out_221031.awb")

						arg_168_1:RecordAudio("221031039", var_171_11)
						arg_168_1:RecordAudio("221031039", var_171_11)
					else
						arg_168_1:AudioAction("play", "voice", "story_v_out_221031", "221031039", "story_v_out_221031.awb")
					end

					arg_168_1:RecordHistoryTalkVoice("story_v_out_221031", "221031039", "story_v_out_221031.awb")
				end

				arg_168_1:RecordContent(arg_168_1.text_.text)
			end

			local var_171_12 = math.max(var_171_5, arg_168_1.talkMaxDuration)

			if var_171_4 <= arg_168_1.time_ and arg_168_1.time_ < var_171_4 + var_171_12 then
				arg_168_1.typewritter.percent = (arg_168_1.time_ - var_171_4) / var_171_12

				arg_168_1.typewritter:SetDirty()
			end

			if arg_168_1.time_ >= var_171_4 + var_171_12 and arg_168_1.time_ < var_171_4 + var_171_12 + arg_171_0 then
				arg_168_1.typewritter.percent = 1

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(true)
			end
		end

		arg_168_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_168_1:InitPlayNodeList()
	end,
	Play221031040 = function(arg_172_0, arg_172_1)
		arg_172_1.time_ = 0
		arg_172_1.frameCnt_ = 0
		arg_172_1.state_ = "playing"
		arg_172_1.curTalkId_ = 221031040
		arg_172_1.duration_ = 5

		SetActive(arg_172_1.tipsGo_, false)

		function arg_172_1.onSingleLineFinish_()
			arg_172_1.onSingleLineUpdate_ = nil
			arg_172_1.onSingleLineFinish_ = nil
			arg_172_1.state_ = "waiting"
		end

		function arg_172_1.playNext_(arg_174_0)
			if arg_174_0 == 1 then
				arg_172_0:Play221031041(arg_172_1)
			end
		end

		function arg_172_1.onSingleLineUpdate_(arg_175_0)
			if 0 < arg_172_1.time_ and arg_172_1.time_ <= 0 + arg_175_0 and not isNil(arg_172_1.actors_["1072ui_story"]) and arg_172_1.var_.characterEffect1072ui_story == nil then
				arg_172_1.var_.characterEffect1072ui_story = arg_172_1.actors_["1072ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_175_0 = 0.200000002980232

			if 0 <= arg_172_1.time_ and arg_172_1.time_ < 0 + var_175_0 and not isNil(arg_172_1.actors_["1072ui_story"]) then
				if arg_172_1.var_.characterEffect1072ui_story and not isNil(arg_172_1.actors_["1072ui_story"]) then
					arg_172_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_172_1.var_.characterEffect1072ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_172_1.time_ - 0) / var_175_0)
				end
			end

			if arg_172_1.time_ >= 0 + var_175_0 and arg_172_1.time_ < 0 + var_175_0 + arg_175_0 and not isNil(arg_172_1.actors_["1072ui_story"]) and arg_172_1.var_.characterEffect1072ui_story then
				arg_172_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_172_1.var_.characterEffect1072ui_story.fillRatio = 0.5
			end

			local var_175_1 = 0
			local var_175_2 = 1.925

			if 0 < arg_172_1.time_ and arg_172_1.time_ <= var_175_1 + arg_175_0 then
				arg_172_1.talkMaxDuration = 0
				arg_172_1.dialogCg_.alpha = 1

				arg_172_1.dialog_:SetActive(true)
				SetActive(arg_172_1.leftNameGo_, false)

				arg_172_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_172_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_172_1:RecordName(arg_172_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_172_1.iconTrs_.gameObject, false)
				arg_172_1.callingController_:SetSelectedState("normal")

				local var_175_3 = arg_172_1:FormatText(arg_172_1:GetWordFromCfg(221031040).content)

				arg_172_1.text_.text = var_175_3

				LuaForUtil.ClearLinePrefixSymbol(arg_172_1.text_)

				local var_175_5 = 77 <= 0 and var_175_2 or var_175_2 * (utf8.len(var_175_3) / 77)

				if (77 <= 0 and var_175_2 or var_175_2 * (utf8.len(var_175_3) / 77)) > 0 and var_175_2 < var_175_5 then
					arg_172_1.talkMaxDuration = var_175_5

					if var_175_5 + var_175_1 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_5 + var_175_1
					end
				end

				arg_172_1.text_.text = var_175_3
				arg_172_1.typewritter.percent = 0

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(false)
				arg_172_1:RecordContent(arg_172_1.text_.text)
			end

			local var_175_6 = math.max(var_175_2, arg_172_1.talkMaxDuration)

			if var_175_1 <= arg_172_1.time_ and arg_172_1.time_ < var_175_1 + var_175_6 then
				arg_172_1.typewritter.percent = (arg_172_1.time_ - var_175_1) / var_175_6

				arg_172_1.typewritter:SetDirty()
			end

			if arg_172_1.time_ >= var_175_1 + var_175_6 and arg_172_1.time_ < var_175_1 + var_175_6 + arg_175_0 then
				arg_172_1.typewritter.percent = 1

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(true)
			end
		end

		arg_172_1.nodeConfigList_ = {}

		arg_172_1:InitPlayNodeList()
	end,
	Play221031041 = function(arg_176_0, arg_176_1)
		arg_176_1.time_ = 0
		arg_176_1.frameCnt_ = 0
		arg_176_1.state_ = "playing"
		arg_176_1.curTalkId_ = 221031041
		arg_176_1.duration_ = 3.67

		local var_176_0 = {
			ja = 3.666,
			ko = 2.933,
			zh = 2.933
		}
		local var_176_1 = manager.audio:GetLocalizationFlag()

		if var_176_0[var_176_1] ~= nil then
			arg_176_1.duration_ = var_176_0[var_176_1]
		end

		SetActive(arg_176_1.tipsGo_, false)

		function arg_176_1.onSingleLineFinish_()
			arg_176_1.onSingleLineUpdate_ = nil
			arg_176_1.onSingleLineFinish_ = nil
			arg_176_1.state_ = "waiting"
		end

		function arg_176_1.playNext_(arg_178_0)
			if arg_178_0 == 1 then
				arg_176_0:Play221031042(arg_176_1)
			end
		end

		function arg_176_1.onSingleLineUpdate_(arg_179_0)
			if 0 < arg_176_1.time_ and arg_176_1.time_ <= 0 + arg_179_0 then
				arg_176_1.var_.moveOldPos1072ui_story = arg_176_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_179_0 = 0.001

			if 0 <= arg_176_1.time_ and arg_176_1.time_ < 0 + var_179_0 then
				arg_176_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_176_1.var_.moveOldPos1072ui_story, Vector3.New(0, -0.71, -6), (arg_176_1.time_ - 0) / var_179_0)
				arg_176_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_176_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_176_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_176_1.actors_["1072ui_story"].transform.position).z)
				arg_176_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_176_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_176_1.actors_["1072ui_story"].transform.localEulerAngles = arg_176_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_176_1.time_ >= 0 + var_179_0 and arg_176_1.time_ < 0 + var_179_0 + arg_179_0 then
				arg_176_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_176_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_176_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_176_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_176_1.actors_["1072ui_story"].transform.position).z)
				arg_176_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_176_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_176_1.actors_["1072ui_story"].transform.localEulerAngles = arg_176_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			local var_179_1 = arg_176_1.actors_["1072ui_story"]

			if 0 < arg_176_1.time_ and arg_176_1.time_ <= 0 + arg_179_0 and not isNil(var_179_1) and arg_176_1.var_.characterEffect1072ui_story == nil then
				arg_176_1.var_.characterEffect1072ui_story = var_179_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_179_2 = 0.200000002980232

			if 0 <= arg_176_1.time_ and arg_176_1.time_ < 0 + var_179_2 and not isNil(var_179_1) then
				if arg_176_1.var_.characterEffect1072ui_story and not isNil(var_179_1) then
					arg_176_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_176_1.time_ >= 0 + var_179_2 and arg_176_1.time_ < 0 + var_179_2 + arg_179_0 and not isNil(var_179_1) and arg_176_1.var_.characterEffect1072ui_story then
				arg_176_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			if 0 < arg_176_1.time_ and arg_176_1.time_ <= 0 + arg_179_0 then
				arg_176_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action5_1")
			end

			if 0 < arg_176_1.time_ and arg_176_1.time_ <= 0 + arg_179_0 then
				arg_176_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_179_4 = 0
			local var_179_5 = 0.25

			if 0 < arg_176_1.time_ and arg_176_1.time_ <= var_179_4 + arg_179_0 then
				arg_176_1.talkMaxDuration = 0
				arg_176_1.dialogCg_.alpha = 1

				arg_176_1.dialog_:SetActive(true)
				SetActive(arg_176_1.leftNameGo_, true)

				arg_176_1.leftNameTxt_.text = arg_176_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_176_1.leftNameTxt_.transform)

				arg_176_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_176_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_176_1:RecordName(arg_176_1.leftNameTxt_.text)
				SetActive(arg_176_1.iconTrs_.gameObject, false)
				arg_176_1.callingController_:SetSelectedState("normal")

				local var_179_6 = arg_176_1:GetWordFromCfg(221031041)
				local var_179_7 = arg_176_1:FormatText(var_179_6.content)

				arg_176_1.text_.text = var_179_7

				LuaForUtil.ClearLinePrefixSymbol(arg_176_1.text_)

				local var_179_9 = 10 <= 0 and var_179_5 or var_179_5 * (utf8.len(var_179_7) / 10)

				if (10 <= 0 and var_179_5 or var_179_5 * (utf8.len(var_179_7) / 10)) > 0 and var_179_5 < var_179_9 then
					arg_176_1.talkMaxDuration = var_179_9

					if var_179_9 + var_179_4 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_9 + var_179_4
					end
				end

				arg_176_1.text_.text = var_179_7
				arg_176_1.typewritter.percent = 0

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221031", "221031041", "story_v_out_221031.awb") ~= 0 then
					local var_179_10 = manager.audio:GetVoiceLength("story_v_out_221031", "221031041", "story_v_out_221031.awb") / 1000

					if var_179_10 + var_179_4 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_10 + var_179_4
					end

					if var_179_6.prefab_name ~= "" and arg_176_1.actors_[var_179_6.prefab_name] ~= nil then
						local var_179_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_176_1.actors_[var_179_6.prefab_name].transform, "story_v_out_221031", "221031041", "story_v_out_221031.awb")

						arg_176_1:RecordAudio("221031041", var_179_11)
						arg_176_1:RecordAudio("221031041", var_179_11)
					else
						arg_176_1:AudioAction("play", "voice", "story_v_out_221031", "221031041", "story_v_out_221031.awb")
					end

					arg_176_1:RecordHistoryTalkVoice("story_v_out_221031", "221031041", "story_v_out_221031.awb")
				end

				arg_176_1:RecordContent(arg_176_1.text_.text)
			end

			local var_179_12 = math.max(var_179_5, arg_176_1.talkMaxDuration)

			if var_179_4 <= arg_176_1.time_ and arg_176_1.time_ < var_179_4 + var_179_12 then
				arg_176_1.typewritter.percent = (arg_176_1.time_ - var_179_4) / var_179_12

				arg_176_1.typewritter:SetDirty()
			end

			if arg_176_1.time_ >= var_179_4 + var_179_12 and arg_176_1.time_ < var_179_4 + var_179_12 + arg_179_0 then
				arg_176_1.typewritter.percent = 1

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(true)
			end
		end

		arg_176_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_176_1:InitPlayNodeList()
	end,
	Play221031042 = function(arg_180_0, arg_180_1)
		arg_180_1.time_ = 0
		arg_180_1.frameCnt_ = 0
		arg_180_1.state_ = "playing"
		arg_180_1.curTalkId_ = 221031042
		arg_180_1.duration_ = 3.5

		local var_180_0 = {
			ja = 3.5,
			ko = 2.533,
			zh = 2.533
		}
		local var_180_1 = manager.audio:GetLocalizationFlag()

		if var_180_0[var_180_1] ~= nil then
			arg_180_1.duration_ = var_180_0[var_180_1]
		end

		SetActive(arg_180_1.tipsGo_, false)

		function arg_180_1.onSingleLineFinish_()
			arg_180_1.onSingleLineUpdate_ = nil
			arg_180_1.onSingleLineFinish_ = nil
			arg_180_1.state_ = "waiting"
		end

		function arg_180_1.playNext_(arg_182_0)
			if arg_182_0 == 1 then
				arg_180_0:Play221031043(arg_180_1)
			end
		end

		function arg_180_1.onSingleLineUpdate_(arg_183_0)
			if 0 < arg_180_1.time_ and arg_180_1.time_ <= 0 + arg_183_0 then
				arg_180_1.var_.moveOldPos1072ui_story = arg_180_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_183_0 = 0.001

			if 0 <= arg_180_1.time_ and arg_180_1.time_ < 0 + var_183_0 then
				arg_180_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_180_1.var_.moveOldPos1072ui_story, Vector3.New(0, -0.71, -6), (arg_180_1.time_ - 0) / var_183_0)
				arg_180_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_180_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_180_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_180_1.actors_["1072ui_story"].transform.position).z)
				arg_180_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_180_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_180_1.actors_["1072ui_story"].transform.localEulerAngles = arg_180_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_180_1.time_ >= 0 + var_183_0 and arg_180_1.time_ < 0 + var_183_0 + arg_183_0 then
				arg_180_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_180_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_180_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_180_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_180_1.actors_["1072ui_story"].transform.position).z)
				arg_180_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_180_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_180_1.actors_["1072ui_story"].transform.localEulerAngles = arg_180_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if 0 < arg_180_1.time_ and arg_180_1.time_ <= 0 + arg_183_0 then
				arg_180_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0202cva")
			end

			local var_183_1 = 0
			local var_183_2 = 0.3

			if 0 < arg_180_1.time_ and arg_180_1.time_ <= var_183_1 + arg_183_0 then
				arg_180_1.talkMaxDuration = 0
				arg_180_1.dialogCg_.alpha = 1

				arg_180_1.dialog_:SetActive(true)
				SetActive(arg_180_1.leftNameGo_, true)

				arg_180_1.leftNameTxt_.text = arg_180_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_180_1.leftNameTxt_.transform)

				arg_180_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_180_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_180_1:RecordName(arg_180_1.leftNameTxt_.text)
				SetActive(arg_180_1.iconTrs_.gameObject, false)
				arg_180_1.callingController_:SetSelectedState("normal")

				local var_183_3 = arg_180_1:GetWordFromCfg(221031042)
				local var_183_4 = arg_180_1:FormatText(var_183_3.content)

				arg_180_1.text_.text = var_183_4

				LuaForUtil.ClearLinePrefixSymbol(arg_180_1.text_)

				local var_183_6 = 12 <= 0 and var_183_2 or var_183_2 * (utf8.len(var_183_4) / 12)

				if (12 <= 0 and var_183_2 or var_183_2 * (utf8.len(var_183_4) / 12)) > 0 and var_183_2 < var_183_6 then
					arg_180_1.talkMaxDuration = var_183_6

					if var_183_6 + var_183_1 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_6 + var_183_1
					end
				end

				arg_180_1.text_.text = var_183_4
				arg_180_1.typewritter.percent = 0

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221031", "221031042", "story_v_out_221031.awb") ~= 0 then
					local var_183_7 = manager.audio:GetVoiceLength("story_v_out_221031", "221031042", "story_v_out_221031.awb") / 1000

					if var_183_7 + var_183_1 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_7 + var_183_1
					end

					if var_183_3.prefab_name ~= "" and arg_180_1.actors_[var_183_3.prefab_name] ~= nil then
						local var_183_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_180_1.actors_[var_183_3.prefab_name].transform, "story_v_out_221031", "221031042", "story_v_out_221031.awb")

						arg_180_1:RecordAudio("221031042", var_183_8)
						arg_180_1:RecordAudio("221031042", var_183_8)
					else
						arg_180_1:AudioAction("play", "voice", "story_v_out_221031", "221031042", "story_v_out_221031.awb")
					end

					arg_180_1:RecordHistoryTalkVoice("story_v_out_221031", "221031042", "story_v_out_221031.awb")
				end

				arg_180_1:RecordContent(arg_180_1.text_.text)
			end

			local var_183_9 = math.max(var_183_2, arg_180_1.talkMaxDuration)

			if var_183_1 <= arg_180_1.time_ and arg_180_1.time_ < var_183_1 + var_183_9 then
				arg_180_1.typewritter.percent = (arg_180_1.time_ - var_183_1) / var_183_9

				arg_180_1.typewritter:SetDirty()
			end

			if arg_180_1.time_ >= var_183_1 + var_183_9 and arg_180_1.time_ < var_183_1 + var_183_9 + arg_183_0 then
				arg_180_1.typewritter.percent = 1

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(true)
			end
		end

		arg_180_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_180_1:InitPlayNodeList()
	end,
	Play221031043 = function(arg_184_0, arg_184_1)
		arg_184_1.time_ = 0
		arg_184_1.frameCnt_ = 0
		arg_184_1.state_ = "playing"
		arg_184_1.curTalkId_ = 221031043
		arg_184_1.duration_ = 5

		SetActive(arg_184_1.tipsGo_, false)

		function arg_184_1.onSingleLineFinish_()
			arg_184_1.onSingleLineUpdate_ = nil
			arg_184_1.onSingleLineFinish_ = nil
			arg_184_1.state_ = "waiting"
		end

		function arg_184_1.playNext_(arg_186_0)
			if arg_186_0 == 1 then
				arg_184_0:Play221031044(arg_184_1)
			end
		end

		function arg_184_1.onSingleLineUpdate_(arg_187_0)
			if 0 < arg_184_1.time_ and arg_184_1.time_ <= 0 + arg_187_0 then
				arg_184_1.var_.moveOldPos1072ui_story = arg_184_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_187_0 = 0.001

			if 0 <= arg_184_1.time_ and arg_184_1.time_ < 0 + var_187_0 then
				arg_184_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_184_1.var_.moveOldPos1072ui_story, Vector3.New(0, 100, 0), (arg_184_1.time_ - 0) / var_187_0)
				arg_184_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_184_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_184_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_184_1.actors_["1072ui_story"].transform.position).z)
				arg_184_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_184_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_184_1.actors_["1072ui_story"].transform.localEulerAngles = arg_184_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_184_1.time_ >= 0 + var_187_0 and arg_184_1.time_ < 0 + var_187_0 + arg_187_0 then
				arg_184_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_184_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_184_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_184_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_184_1.actors_["1072ui_story"].transform.position).z)
				arg_184_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_184_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_184_1.actors_["1072ui_story"].transform.localEulerAngles = arg_184_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			local var_187_1 = arg_184_1.actors_["1072ui_story"]

			if 0 < arg_184_1.time_ and arg_184_1.time_ <= 0 + arg_187_0 and not isNil(var_187_1) and arg_184_1.var_.characterEffect1072ui_story == nil then
				arg_184_1.var_.characterEffect1072ui_story = var_187_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_187_2 = 0.200000002980232

			if 0 <= arg_184_1.time_ and arg_184_1.time_ < 0 + var_187_2 and not isNil(var_187_1) then
				if arg_184_1.var_.characterEffect1072ui_story and not isNil(var_187_1) then
					arg_184_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_184_1.var_.characterEffect1072ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_184_1.time_ - 0) / var_187_2)
				end
			end

			if arg_184_1.time_ >= 0 + var_187_2 and arg_184_1.time_ < 0 + var_187_2 + arg_187_0 and not isNil(var_187_1) and arg_184_1.var_.characterEffect1072ui_story then
				arg_184_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_184_1.var_.characterEffect1072ui_story.fillRatio = 0.5
			end

			local var_187_3 = 0
			local var_187_4 = 1.575

			if 0 < arg_184_1.time_ and arg_184_1.time_ <= var_187_3 + arg_187_0 then
				arg_184_1.talkMaxDuration = 0
				arg_184_1.dialogCg_.alpha = 1

				arg_184_1.dialog_:SetActive(true)
				SetActive(arg_184_1.leftNameGo_, false)

				arg_184_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_184_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_184_1:RecordName(arg_184_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_184_1.iconTrs_.gameObject, false)
				arg_184_1.callingController_:SetSelectedState("normal")

				local var_187_5 = arg_184_1:FormatText(arg_184_1:GetWordFromCfg(221031043).content)

				arg_184_1.text_.text = var_187_5

				LuaForUtil.ClearLinePrefixSymbol(arg_184_1.text_)

				local var_187_7 = 63 <= 0 and var_187_4 or var_187_4 * (utf8.len(var_187_5) / 63)

				if (63 <= 0 and var_187_4 or var_187_4 * (utf8.len(var_187_5) / 63)) > 0 and var_187_4 < var_187_7 then
					arg_184_1.talkMaxDuration = var_187_7

					if var_187_7 + var_187_3 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_7 + var_187_3
					end
				end

				arg_184_1.text_.text = var_187_5
				arg_184_1.typewritter.percent = 0

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(false)
				arg_184_1:RecordContent(arg_184_1.text_.text)
			end

			local var_187_8 = math.max(var_187_4, arg_184_1.talkMaxDuration)

			if var_187_3 <= arg_184_1.time_ and arg_184_1.time_ < var_187_3 + var_187_8 then
				arg_184_1.typewritter.percent = (arg_184_1.time_ - var_187_3) / var_187_8

				arg_184_1.typewritter:SetDirty()
			end

			if arg_184_1.time_ >= var_187_3 + var_187_8 and arg_184_1.time_ < var_187_3 + var_187_8 + arg_187_0 then
				arg_184_1.typewritter.percent = 1

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(true)
			end
		end

		arg_184_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_184_1:InitPlayNodeList()
	end,
	Play221031044 = function(arg_188_0, arg_188_1)
		arg_188_1.time_ = 0
		arg_188_1.frameCnt_ = 0
		arg_188_1.state_ = "playing"
		arg_188_1.curTalkId_ = 221031044
		arg_188_1.duration_ = 15.5

		local var_188_0 = {
			ja = 15.5,
			ko = 12.366,
			zh = 12.366
		}
		local var_188_1 = manager.audio:GetLocalizationFlag()

		if var_188_0[var_188_1] ~= nil then
			arg_188_1.duration_ = var_188_0[var_188_1]
		end

		SetActive(arg_188_1.tipsGo_, false)

		function arg_188_1.onSingleLineFinish_()
			arg_188_1.onSingleLineUpdate_ = nil
			arg_188_1.onSingleLineFinish_ = nil
			arg_188_1.state_ = "waiting"
		end

		function arg_188_1.playNext_(arg_190_0)
			if arg_190_0 == 1 then
				arg_188_0:Play221031045(arg_188_1)
			end
		end

		function arg_188_1.onSingleLineUpdate_(arg_191_0)
			if arg_188_1.bgs_.XH0801 == nil then
				local var_191_0 = Object.Instantiate(arg_188_1.paintGo_)

				var_191_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "XH0801")
				var_191_0.name = "XH0801"
				var_191_0.transform.parent = arg_188_1.stage_.transform
				var_191_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_188_1.bgs_.XH0801 = var_191_0
			end

			if 2 < arg_188_1.time_ and arg_188_1.time_ <= 2 + arg_191_0 then
				local var_191_1 = arg_188_1.bgs_.XH0801

				arg_188_1.bgs_.XH0801.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_191_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_191_2 = var_191_1:GetComponent("SpriteRenderer")

				if var_191_2 and var_191_2.sprite then
					local var_191_3 = 2 * (var_191_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_191_1.transform.localScale = Vector3.New(var_191_3 / var_191_2.sprite.bounds.size.y < var_191_3 * manager.ui.mainCameraCom_.aspect / var_191_2.sprite.bounds.size.x and var_191_3 * manager.ui.mainCameraCom_.aspect / var_191_2.sprite.bounds.size.x or var_191_3 / var_191_2.sprite.bounds.size.y, var_191_3 / var_191_2.sprite.bounds.size.y < var_191_3 * manager.ui.mainCameraCom_.aspect / var_191_2.sprite.bounds.size.x and var_191_3 * manager.ui.mainCameraCom_.aspect / var_191_2.sprite.bounds.size.x or var_191_3 / var_191_2.sprite.bounds.size.y, 0)
				end

				for iter_191_0, iter_191_1 in pairs(arg_188_1.bgs_) do
					if iter_191_0 ~= "XH0801" then
						iter_191_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_191_4 = 0

			if 0 < arg_188_1.time_ and arg_188_1.time_ <= var_191_4 + arg_191_0 then
				arg_188_1.mask_.enabled = true
				arg_188_1.mask_.raycastTarget = true

				arg_188_1:SetGaussion(false)
			end

			local var_191_5 = 2

			if var_191_4 <= arg_188_1.time_ and arg_188_1.time_ < var_191_4 + var_191_5 then
				local var_191_6 = Color.New(0, 0, 0)

				var_191_6.a = Mathf.Lerp(0, 1, (arg_188_1.time_ - var_191_4) / var_191_5)
				arg_188_1.mask_.color = var_191_6
			end

			if arg_188_1.time_ >= var_191_4 + var_191_5 and arg_188_1.time_ < var_191_4 + var_191_5 + arg_191_0 then
				local var_191_7 = Color.New(0, 0, 0)

				var_191_7.a = 1
				arg_188_1.mask_.color = var_191_7
			end

			local var_191_8 = 2

			if 2 < arg_188_1.time_ and arg_188_1.time_ <= var_191_8 + arg_191_0 then
				arg_188_1.mask_.enabled = true
				arg_188_1.mask_.raycastTarget = true

				arg_188_1:SetGaussion(false)
			end

			local var_191_9 = 2

			if var_191_8 <= arg_188_1.time_ and arg_188_1.time_ < var_191_8 + var_191_9 then
				local var_191_10 = Color.New(0, 0, 0)

				var_191_10.a = Mathf.Lerp(1, 0, (arg_188_1.time_ - var_191_8) / var_191_9)
				arg_188_1.mask_.color = var_191_10
			end

			if arg_188_1.time_ >= var_191_8 + var_191_9 and arg_188_1.time_ < var_191_8 + var_191_9 + arg_191_0 then
				local var_191_11 = Color.New(0, 0, 0)

				arg_188_1.mask_.enabled = false
				var_191_11.a = 0
				arg_188_1.mask_.color = var_191_11
			end

			if arg_188_1.frameCnt_ <= 1 then
				arg_188_1.dialog_:SetActive(false)
			end

			local var_191_12 = 4
			local var_191_13 = 0.75

			if 4 < arg_188_1.time_ and arg_188_1.time_ <= var_191_12 + arg_191_0 then
				arg_188_1.talkMaxDuration = 0

				arg_188_1.dialog_:SetActive(true)

				arg_188_1.dialogCg_.alpha = 0

				local var_191_14 = LeanTween.value(arg_188_1.dialog_, 0, 1, 0.3)

				var_191_14:setOnUpdate(LuaHelper.FloatAction(function(arg_192_0)
					arg_188_1.dialogCg_.alpha = arg_192_0
				end))
				var_191_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_188_1.dialog_)
					var_191_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_188_1.duration_ = arg_188_1.duration_ + 0.3

				SetActive(arg_188_1.leftNameGo_, true)

				arg_188_1.leftNameTxt_.text = arg_188_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_188_1.leftNameTxt_.transform)

				arg_188_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_188_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_188_1:RecordName(arg_188_1.leftNameTxt_.text)
				SetActive(arg_188_1.iconTrs_.gameObject, true)
				arg_188_1.iconController_:SetSelectedState("hero")

				arg_188_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1072")

				arg_188_1.callingController_:SetSelectedState("normal")

				arg_188_1.keyicon_.color = Color.New(1, 1, 1)
				arg_188_1.icon_.color = Color.New(1, 1, 1)

				local var_191_15 = arg_188_1:GetWordFromCfg(221031044)
				local var_191_16 = arg_188_1:FormatText(var_191_15.content)

				arg_188_1.text_.text = var_191_16

				LuaForUtil.ClearLinePrefixSymbol(arg_188_1.text_)

				local var_191_18 = 30 <= 0 and var_191_13 or var_191_13 * (utf8.len(var_191_16) / 30)

				if (30 <= 0 and var_191_13 or var_191_13 * (utf8.len(var_191_16) / 30)) > 0 and var_191_13 < var_191_18 then
					arg_188_1.talkMaxDuration = var_191_18
					var_191_12 = var_191_12 + 0.3

					if var_191_18 + var_191_12 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_18 + var_191_12
					end
				end

				arg_188_1.text_.text = var_191_16
				arg_188_1.typewritter.percent = 0

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221031", "221031044", "story_v_out_221031.awb") ~= 0 then
					local var_191_19 = manager.audio:GetVoiceLength("story_v_out_221031", "221031044", "story_v_out_221031.awb") / 1000

					if var_191_19 + var_191_12 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_19 + var_191_12
					end

					if var_191_15.prefab_name ~= "" and arg_188_1.actors_[var_191_15.prefab_name] ~= nil then
						local var_191_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_188_1.actors_[var_191_15.prefab_name].transform, "story_v_out_221031", "221031044", "story_v_out_221031.awb")

						arg_188_1:RecordAudio("221031044", var_191_20)
						arg_188_1:RecordAudio("221031044", var_191_20)
					else
						arg_188_1:AudioAction("play", "voice", "story_v_out_221031", "221031044", "story_v_out_221031.awb")
					end

					arg_188_1:RecordHistoryTalkVoice("story_v_out_221031", "221031044", "story_v_out_221031.awb")
				end

				arg_188_1:RecordContent(arg_188_1.text_.text)
			end

			local var_191_21 = var_191_12 + 0.3
			local var_191_22 = math.max(var_191_13, arg_188_1.talkMaxDuration)

			if var_191_12 + 0.3 <= arg_188_1.time_ and arg_188_1.time_ < var_191_21 + var_191_22 then
				arg_188_1.typewritter.percent = (arg_188_1.time_ - var_191_21) / var_191_22

				arg_188_1.typewritter:SetDirty()
			end

			if arg_188_1.time_ >= var_191_21 + var_191_22 and arg_188_1.time_ < var_191_21 + var_191_22 + arg_191_0 then
				arg_188_1.typewritter.percent = 1

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(true)
			end
		end

		arg_188_1.nodeConfigList_ = {}

		arg_188_1:InitPlayNodeList()
	end,
	Play221031045 = function(arg_194_0, arg_194_1)
		arg_194_1.time_ = 0
		arg_194_1.frameCnt_ = 0
		arg_194_1.state_ = "playing"
		arg_194_1.curTalkId_ = 221031045
		arg_194_1.duration_ = 10.57

		local var_194_0 = {
			ja = 10.4,
			ko = 10.566,
			zh = 10.566
		}
		local var_194_1 = manager.audio:GetLocalizationFlag()

		if var_194_0[var_194_1] ~= nil then
			arg_194_1.duration_ = var_194_0[var_194_1]
		end

		SetActive(arg_194_1.tipsGo_, false)

		function arg_194_1.onSingleLineFinish_()
			arg_194_1.onSingleLineUpdate_ = nil
			arg_194_1.onSingleLineFinish_ = nil
			arg_194_1.state_ = "waiting"
		end

		function arg_194_1.playNext_(arg_196_0)
			if arg_196_0 == 1 then
				arg_194_0:Play221031046(arg_194_1)
			end
		end

		function arg_194_1.onSingleLineUpdate_(arg_197_0)
			local var_197_0 = 0.95

			if 0 < arg_194_1.time_ and arg_194_1.time_ <= 0 + arg_197_0 then
				arg_194_1.talkMaxDuration = 0
				arg_194_1.dialogCg_.alpha = 1

				arg_194_1.dialog_:SetActive(true)
				SetActive(arg_194_1.leftNameGo_, true)

				arg_194_1.leftNameTxt_.text = arg_194_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_194_1.leftNameTxt_.transform)

				arg_194_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_194_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_194_1:RecordName(arg_194_1.leftNameTxt_.text)
				SetActive(arg_194_1.iconTrs_.gameObject, true)
				arg_194_1.iconController_:SetSelectedState("hero")

				arg_194_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1072")

				arg_194_1.callingController_:SetSelectedState("normal")

				arg_194_1.keyicon_.color = Color.New(1, 1, 1)
				arg_194_1.icon_.color = Color.New(1, 1, 1)

				local var_197_1 = arg_194_1:GetWordFromCfg(221031045)
				local var_197_2 = arg_194_1:FormatText(var_197_1.content)

				arg_194_1.text_.text = var_197_2

				LuaForUtil.ClearLinePrefixSymbol(arg_194_1.text_)

				local var_197_4 = 38 <= 0 and var_197_0 or var_197_0 * (utf8.len(var_197_2) / 38)

				if (38 <= 0 and var_197_0 or var_197_0 * (utf8.len(var_197_2) / 38)) > 0 and var_197_0 < var_197_4 then
					arg_194_1.talkMaxDuration = var_197_4

					if var_197_4 + 0 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_4 + 0
					end
				end

				arg_194_1.text_.text = var_197_2
				arg_194_1.typewritter.percent = 0

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221031", "221031045", "story_v_out_221031.awb") ~= 0 then
					local var_197_5 = manager.audio:GetVoiceLength("story_v_out_221031", "221031045", "story_v_out_221031.awb") / 1000

					if var_197_5 + 0 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_5 + 0
					end

					if var_197_1.prefab_name ~= "" and arg_194_1.actors_[var_197_1.prefab_name] ~= nil then
						local var_197_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_194_1.actors_[var_197_1.prefab_name].transform, "story_v_out_221031", "221031045", "story_v_out_221031.awb")

						arg_194_1:RecordAudio("221031045", var_197_6)
						arg_194_1:RecordAudio("221031045", var_197_6)
					else
						arg_194_1:AudioAction("play", "voice", "story_v_out_221031", "221031045", "story_v_out_221031.awb")
					end

					arg_194_1:RecordHistoryTalkVoice("story_v_out_221031", "221031045", "story_v_out_221031.awb")
				end

				arg_194_1:RecordContent(arg_194_1.text_.text)
			end

			local var_197_7 = math.max(var_197_0, arg_194_1.talkMaxDuration)

			if 0 <= arg_194_1.time_ and arg_194_1.time_ < 0 + var_197_7 then
				arg_194_1.typewritter.percent = (arg_194_1.time_ - 0) / var_197_7

				arg_194_1.typewritter:SetDirty()
			end

			if arg_194_1.time_ >= 0 + var_197_7 and arg_194_1.time_ < 0 + var_197_7 + arg_197_0 then
				arg_194_1.typewritter.percent = 1

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(true)
			end
		end

		arg_194_1.nodeConfigList_ = {}

		arg_194_1:InitPlayNodeList()
	end,
	Play221031046 = function(arg_198_0, arg_198_1)
		arg_198_1.time_ = 0
		arg_198_1.frameCnt_ = 0
		arg_198_1.state_ = "playing"
		arg_198_1.curTalkId_ = 221031046
		arg_198_1.duration_ = 8.57

		local var_198_0 = {
			ja = 8.566,
			ko = 8.4,
			zh = 8.4
		}
		local var_198_1 = manager.audio:GetLocalizationFlag()

		if var_198_0[var_198_1] ~= nil then
			arg_198_1.duration_ = var_198_0[var_198_1]
		end

		SetActive(arg_198_1.tipsGo_, false)

		function arg_198_1.onSingleLineFinish_()
			arg_198_1.onSingleLineUpdate_ = nil
			arg_198_1.onSingleLineFinish_ = nil
			arg_198_1.state_ = "waiting"
		end

		function arg_198_1.playNext_(arg_200_0)
			if arg_200_0 == 1 then
				arg_198_0:Play221031047(arg_198_1)
			end
		end

		function arg_198_1.onSingleLineUpdate_(arg_201_0)
			if arg_198_1.bgs_.XH0805 == nil then
				local var_201_0 = Object.Instantiate(arg_198_1.paintGo_)

				var_201_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "XH0805")
				var_201_0.name = "XH0805"
				var_201_0.transform.parent = arg_198_1.stage_.transform
				var_201_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_198_1.bgs_.XH0805 = var_201_0
			end

			if 2 < arg_198_1.time_ and arg_198_1.time_ <= 2 + arg_201_0 then
				local var_201_1 = arg_198_1.bgs_.XH0805

				arg_198_1.bgs_.XH0805.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_201_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_201_2 = var_201_1:GetComponent("SpriteRenderer")

				if var_201_2 and var_201_2.sprite then
					local var_201_3 = 2 * (var_201_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_201_1.transform.localScale = Vector3.New(var_201_3 / var_201_2.sprite.bounds.size.y < var_201_3 * manager.ui.mainCameraCom_.aspect / var_201_2.sprite.bounds.size.x and var_201_3 * manager.ui.mainCameraCom_.aspect / var_201_2.sprite.bounds.size.x or var_201_3 / var_201_2.sprite.bounds.size.y, var_201_3 / var_201_2.sprite.bounds.size.y < var_201_3 * manager.ui.mainCameraCom_.aspect / var_201_2.sprite.bounds.size.x and var_201_3 * manager.ui.mainCameraCom_.aspect / var_201_2.sprite.bounds.size.x or var_201_3 / var_201_2.sprite.bounds.size.y, 0)
				end

				for iter_201_0, iter_201_1 in pairs(arg_198_1.bgs_) do
					if iter_201_0 ~= "XH0805" then
						iter_201_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_201_4 = 0

			if 0 < arg_198_1.time_ and arg_198_1.time_ <= var_201_4 + arg_201_0 then
				arg_198_1.mask_.enabled = true
				arg_198_1.mask_.raycastTarget = true

				arg_198_1:SetGaussion(false)
			end

			local var_201_5 = 2

			if var_201_4 <= arg_198_1.time_ and arg_198_1.time_ < var_201_4 + var_201_5 then
				local var_201_6 = Color.New(0, 0, 0)

				var_201_6.a = Mathf.Lerp(0, 1, (arg_198_1.time_ - var_201_4) / var_201_5)
				arg_198_1.mask_.color = var_201_6
			end

			if arg_198_1.time_ >= var_201_4 + var_201_5 and arg_198_1.time_ < var_201_4 + var_201_5 + arg_201_0 then
				local var_201_7 = Color.New(0, 0, 0)

				var_201_7.a = 1
				arg_198_1.mask_.color = var_201_7
			end

			local var_201_8 = 2

			if 2 < arg_198_1.time_ and arg_198_1.time_ <= var_201_8 + arg_201_0 then
				arg_198_1.mask_.enabled = true
				arg_198_1.mask_.raycastTarget = true

				arg_198_1:SetGaussion(false)
			end

			local var_201_9 = 2

			if var_201_8 <= arg_198_1.time_ and arg_198_1.time_ < var_201_8 + var_201_9 then
				local var_201_10 = Color.New(0, 0, 0)

				var_201_10.a = Mathf.Lerp(1, 0, (arg_198_1.time_ - var_201_8) / var_201_9)
				arg_198_1.mask_.color = var_201_10
			end

			if arg_198_1.time_ >= var_201_8 + var_201_9 and arg_198_1.time_ < var_201_8 + var_201_9 + arg_201_0 then
				local var_201_11 = Color.New(0, 0, 0)

				arg_198_1.mask_.enabled = false
				var_201_11.a = 0
				arg_198_1.mask_.color = var_201_11
			end

			if arg_198_1.frameCnt_ <= 1 then
				arg_198_1.dialog_:SetActive(false)
			end

			local var_201_12 = 4
			local var_201_13 = 0.425

			if 4 < arg_198_1.time_ and arg_198_1.time_ <= var_201_12 + arg_201_0 then
				arg_198_1.talkMaxDuration = 0

				arg_198_1.dialog_:SetActive(true)

				arg_198_1.dialogCg_.alpha = 0

				local var_201_14 = LeanTween.value(arg_198_1.dialog_, 0, 1, 0.3)

				var_201_14:setOnUpdate(LuaHelper.FloatAction(function(arg_202_0)
					arg_198_1.dialogCg_.alpha = arg_202_0
				end))
				var_201_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_198_1.dialog_)
					var_201_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_198_1.duration_ = arg_198_1.duration_ + 0.3

				SetActive(arg_198_1.leftNameGo_, true)

				arg_198_1.leftNameTxt_.text = arg_198_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_198_1.leftNameTxt_.transform)

				arg_198_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_198_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_198_1:RecordName(arg_198_1.leftNameTxt_.text)
				SetActive(arg_198_1.iconTrs_.gameObject, true)
				arg_198_1.iconController_:SetSelectedState("hero")

				arg_198_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1072")

				arg_198_1.callingController_:SetSelectedState("normal")

				arg_198_1.keyicon_.color = Color.New(1, 1, 1)
				arg_198_1.icon_.color = Color.New(1, 1, 1)

				local var_201_15 = arg_198_1:GetWordFromCfg(221031046)
				local var_201_16 = arg_198_1:FormatText(var_201_15.content)

				arg_198_1.text_.text = var_201_16

				LuaForUtil.ClearLinePrefixSymbol(arg_198_1.text_)

				local var_201_18 = 17 <= 0 and var_201_13 or var_201_13 * (utf8.len(var_201_16) / 17)

				if (17 <= 0 and var_201_13 or var_201_13 * (utf8.len(var_201_16) / 17)) > 0 and var_201_13 < var_201_18 then
					arg_198_1.talkMaxDuration = var_201_18
					var_201_12 = var_201_12 + 0.3

					if var_201_18 + var_201_12 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_18 + var_201_12
					end
				end

				arg_198_1.text_.text = var_201_16
				arg_198_1.typewritter.percent = 0

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221031", "221031046", "story_v_out_221031.awb") ~= 0 then
					local var_201_19 = manager.audio:GetVoiceLength("story_v_out_221031", "221031046", "story_v_out_221031.awb") / 1000

					if var_201_19 + var_201_12 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_19 + var_201_12
					end

					if var_201_15.prefab_name ~= "" and arg_198_1.actors_[var_201_15.prefab_name] ~= nil then
						local var_201_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_198_1.actors_[var_201_15.prefab_name].transform, "story_v_out_221031", "221031046", "story_v_out_221031.awb")

						arg_198_1:RecordAudio("221031046", var_201_20)
						arg_198_1:RecordAudio("221031046", var_201_20)
					else
						arg_198_1:AudioAction("play", "voice", "story_v_out_221031", "221031046", "story_v_out_221031.awb")
					end

					arg_198_1:RecordHistoryTalkVoice("story_v_out_221031", "221031046", "story_v_out_221031.awb")
				end

				arg_198_1:RecordContent(arg_198_1.text_.text)
			end

			local var_201_21 = var_201_12 + 0.3
			local var_201_22 = math.max(var_201_13, arg_198_1.talkMaxDuration)

			if var_201_12 + 0.3 <= arg_198_1.time_ and arg_198_1.time_ < var_201_21 + var_201_22 then
				arg_198_1.typewritter.percent = (arg_198_1.time_ - var_201_21) / var_201_22

				arg_198_1.typewritter:SetDirty()
			end

			if arg_198_1.time_ >= var_201_21 + var_201_22 and arg_198_1.time_ < var_201_21 + var_201_22 + arg_201_0 then
				arg_198_1.typewritter.percent = 1

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(true)
			end
		end

		arg_198_1.nodeConfigList_ = {}

		arg_198_1:InitPlayNodeList()
	end,
	Play221031047 = function(arg_204_0, arg_204_1)
		arg_204_1.time_ = 0
		arg_204_1.frameCnt_ = 0
		arg_204_1.state_ = "playing"
		arg_204_1.curTalkId_ = 221031047
		arg_204_1.duration_ = 7.9

		local var_204_0 = {
			ja = 7.9,
			ko = 6.833,
			zh = 6.833
		}
		local var_204_1 = manager.audio:GetLocalizationFlag()

		if var_204_0[var_204_1] ~= nil then
			arg_204_1.duration_ = var_204_0[var_204_1]
		end

		SetActive(arg_204_1.tipsGo_, false)

		function arg_204_1.onSingleLineFinish_()
			arg_204_1.onSingleLineUpdate_ = nil
			arg_204_1.onSingleLineFinish_ = nil
			arg_204_1.state_ = "waiting"
		end

		function arg_204_1.playNext_(arg_206_0)
			if arg_206_0 == 1 then
				arg_204_0:Play221031048(arg_204_1)
			end
		end

		function arg_204_1.onSingleLineUpdate_(arg_207_0)
			local var_207_0 = 0.775

			if 0 < arg_204_1.time_ and arg_204_1.time_ <= 0 + arg_207_0 then
				arg_204_1.talkMaxDuration = 0
				arg_204_1.dialogCg_.alpha = 1

				arg_204_1.dialog_:SetActive(true)
				SetActive(arg_204_1.leftNameGo_, true)

				arg_204_1.leftNameTxt_.text = arg_204_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_204_1.leftNameTxt_.transform)

				arg_204_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_204_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_204_1:RecordName(arg_204_1.leftNameTxt_.text)
				SetActive(arg_204_1.iconTrs_.gameObject, true)
				arg_204_1.iconController_:SetSelectedState("hero")

				arg_204_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1072")

				arg_204_1.callingController_:SetSelectedState("normal")

				arg_204_1.keyicon_.color = Color.New(1, 1, 1)
				arg_204_1.icon_.color = Color.New(1, 1, 1)

				local var_207_1 = arg_204_1:GetWordFromCfg(221031047)
				local var_207_2 = arg_204_1:FormatText(var_207_1.content)

				arg_204_1.text_.text = var_207_2

				LuaForUtil.ClearLinePrefixSymbol(arg_204_1.text_)

				local var_207_4 = 31 <= 0 and var_207_0 or var_207_0 * (utf8.len(var_207_2) / 31)

				if (31 <= 0 and var_207_0 or var_207_0 * (utf8.len(var_207_2) / 31)) > 0 and var_207_0 < var_207_4 then
					arg_204_1.talkMaxDuration = var_207_4

					if var_207_4 + 0 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_4 + 0
					end
				end

				arg_204_1.text_.text = var_207_2
				arg_204_1.typewritter.percent = 0

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221031", "221031047", "story_v_out_221031.awb") ~= 0 then
					local var_207_5 = manager.audio:GetVoiceLength("story_v_out_221031", "221031047", "story_v_out_221031.awb") / 1000

					if var_207_5 + 0 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_5 + 0
					end

					if var_207_1.prefab_name ~= "" and arg_204_1.actors_[var_207_1.prefab_name] ~= nil then
						local var_207_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_204_1.actors_[var_207_1.prefab_name].transform, "story_v_out_221031", "221031047", "story_v_out_221031.awb")

						arg_204_1:RecordAudio("221031047", var_207_6)
						arg_204_1:RecordAudio("221031047", var_207_6)
					else
						arg_204_1:AudioAction("play", "voice", "story_v_out_221031", "221031047", "story_v_out_221031.awb")
					end

					arg_204_1:RecordHistoryTalkVoice("story_v_out_221031", "221031047", "story_v_out_221031.awb")
				end

				arg_204_1:RecordContent(arg_204_1.text_.text)
			end

			local var_207_7 = math.max(var_207_0, arg_204_1.talkMaxDuration)

			if 0 <= arg_204_1.time_ and arg_204_1.time_ < 0 + var_207_7 then
				arg_204_1.typewritter.percent = (arg_204_1.time_ - 0) / var_207_7

				arg_204_1.typewritter:SetDirty()
			end

			if arg_204_1.time_ >= 0 + var_207_7 and arg_204_1.time_ < 0 + var_207_7 + arg_207_0 then
				arg_204_1.typewritter.percent = 1

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(true)
			end
		end

		arg_204_1.nodeConfigList_ = {}

		arg_204_1:InitPlayNodeList()
	end,
	Play221031048 = function(arg_208_0, arg_208_1)
		arg_208_1.time_ = 0
		arg_208_1.frameCnt_ = 0
		arg_208_1.state_ = "playing"
		arg_208_1.curTalkId_ = 221031048
		arg_208_1.duration_ = 7

		SetActive(arg_208_1.tipsGo_, false)

		function arg_208_1.onSingleLineFinish_()
			arg_208_1.onSingleLineUpdate_ = nil
			arg_208_1.onSingleLineFinish_ = nil
			arg_208_1.state_ = "waiting"
		end

		function arg_208_1.playNext_(arg_210_0)
			if arg_210_0 == 1 then
				arg_208_0:Play221031049(arg_208_1)
			end
		end

		function arg_208_1.onSingleLineUpdate_(arg_211_0)
			if 0 < arg_208_1.time_ and arg_208_1.time_ <= 0 + arg_211_0 then
				local var_211_0 = arg_208_1.bgs_.STblack

				arg_208_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_211_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_211_1 = var_211_0:GetComponent("SpriteRenderer")

				if var_211_1 and var_211_1.sprite then
					local var_211_2 = 2 * (var_211_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_211_0.transform.localScale = Vector3.New(var_211_2 / var_211_1.sprite.bounds.size.y < var_211_2 * manager.ui.mainCameraCom_.aspect / var_211_1.sprite.bounds.size.x and var_211_2 * manager.ui.mainCameraCom_.aspect / var_211_1.sprite.bounds.size.x or var_211_2 / var_211_1.sprite.bounds.size.y, var_211_2 / var_211_1.sprite.bounds.size.y < var_211_2 * manager.ui.mainCameraCom_.aspect / var_211_1.sprite.bounds.size.x and var_211_2 * manager.ui.mainCameraCom_.aspect / var_211_1.sprite.bounds.size.x or var_211_2 / var_211_1.sprite.bounds.size.y, 0)
				end

				for iter_211_0, iter_211_1 in pairs(arg_208_1.bgs_) do
					if iter_211_0 ~= "STblack" then
						iter_211_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_211_3 = 0

			if 0 < arg_208_1.time_ and arg_208_1.time_ <= var_211_3 + arg_211_0 then
				arg_208_1.mask_.enabled = true
				arg_208_1.mask_.raycastTarget = true

				arg_208_1:SetGaussion(false)
			end

			local var_211_4 = 2

			if var_211_3 <= arg_208_1.time_ and arg_208_1.time_ < var_211_3 + var_211_4 then
				local var_211_5 = Color.New(0, 0, 0)

				var_211_5.a = Mathf.Lerp(1, 0, (arg_208_1.time_ - var_211_3) / var_211_4)
				arg_208_1.mask_.color = var_211_5
			end

			if arg_208_1.time_ >= var_211_3 + var_211_4 and arg_208_1.time_ < var_211_3 + var_211_4 + arg_211_0 then
				local var_211_6 = Color.New(0, 0, 0)

				arg_208_1.mask_.enabled = false
				var_211_6.a = 0
				arg_208_1.mask_.color = var_211_6
			end

			if arg_208_1.frameCnt_ <= 1 then
				arg_208_1.dialog_:SetActive(false)
			end

			local var_211_7 = 2
			local var_211_8 = 0.05

			if 2 < arg_208_1.time_ and arg_208_1.time_ <= var_211_7 + arg_211_0 then
				arg_208_1.talkMaxDuration = 0

				arg_208_1.dialog_:SetActive(true)

				arg_208_1.dialogCg_.alpha = 0

				local var_211_9 = LeanTween.value(arg_208_1.dialog_, 0, 1, 0.3)

				var_211_9:setOnUpdate(LuaHelper.FloatAction(function(arg_212_0)
					arg_208_1.dialogCg_.alpha = arg_212_0
				end))
				var_211_9:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_208_1.dialog_)
					var_211_9:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_208_1.duration_ = arg_208_1.duration_ + 0.3

				SetActive(arg_208_1.leftNameGo_, false)

				arg_208_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_208_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_208_1:RecordName(arg_208_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_208_1.iconTrs_.gameObject, false)
				arg_208_1.callingController_:SetSelectedState("normal")

				local var_211_10 = arg_208_1:FormatText(arg_208_1:GetWordFromCfg(221031048).content)

				arg_208_1.text_.text = var_211_10

				LuaForUtil.ClearLinePrefixSymbol(arg_208_1.text_)

				local var_211_12 = 2 <= 0 and var_211_8 or var_211_8 * (utf8.len(var_211_10) / 2)

				if (2 <= 0 and var_211_8 or var_211_8 * (utf8.len(var_211_10) / 2)) > 0 and var_211_8 < var_211_12 then
					arg_208_1.talkMaxDuration = var_211_12
					var_211_7 = var_211_7 + 0.3

					if var_211_12 + var_211_7 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_12 + var_211_7
					end
				end

				arg_208_1.text_.text = var_211_10
				arg_208_1.typewritter.percent = 0

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(false)
				arg_208_1:RecordContent(arg_208_1.text_.text)
			end

			local var_211_13 = var_211_7 + 0.3
			local var_211_14 = math.max(var_211_8, arg_208_1.talkMaxDuration)

			if var_211_7 + 0.3 <= arg_208_1.time_ and arg_208_1.time_ < var_211_13 + var_211_14 then
				arg_208_1.typewritter.percent = (arg_208_1.time_ - var_211_13) / var_211_14

				arg_208_1.typewritter:SetDirty()
			end

			if arg_208_1.time_ >= var_211_13 + var_211_14 and arg_208_1.time_ < var_211_13 + var_211_14 + arg_211_0 then
				arg_208_1.typewritter.percent = 1

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(true)
			end
		end

		arg_208_1.nodeConfigList_ = {}

		arg_208_1:InitPlayNodeList()
	end,
	Play221031049 = function(arg_214_0, arg_214_1)
		arg_214_1.time_ = 0
		arg_214_1.frameCnt_ = 0
		arg_214_1.state_ = "playing"
		arg_214_1.curTalkId_ = 221031049
		arg_214_1.duration_ = 7

		SetActive(arg_214_1.tipsGo_, false)

		function arg_214_1.onSingleLineFinish_()
			arg_214_1.onSingleLineUpdate_ = nil
			arg_214_1.onSingleLineFinish_ = nil
			arg_214_1.state_ = "waiting"
		end

		function arg_214_1.playNext_(arg_216_0)
			if arg_216_0 == 1 then
				arg_214_0:Play221031050(arg_214_1)
			end
		end

		function arg_214_1.onSingleLineUpdate_(arg_217_0)
			if 0 < arg_214_1.time_ and arg_214_1.time_ <= 0 + arg_217_0 then
				local var_217_0 = arg_214_1.bgs_.ST39

				arg_214_1.bgs_.ST39.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_217_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_217_1 = var_217_0:GetComponent("SpriteRenderer")

				if var_217_1 and var_217_1.sprite then
					local var_217_2 = 2 * (var_217_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_217_0.transform.localScale = Vector3.New(var_217_2 / var_217_1.sprite.bounds.size.y < var_217_2 * manager.ui.mainCameraCom_.aspect / var_217_1.sprite.bounds.size.x and var_217_2 * manager.ui.mainCameraCom_.aspect / var_217_1.sprite.bounds.size.x or var_217_2 / var_217_1.sprite.bounds.size.y, var_217_2 / var_217_1.sprite.bounds.size.y < var_217_2 * manager.ui.mainCameraCom_.aspect / var_217_1.sprite.bounds.size.x and var_217_2 * manager.ui.mainCameraCom_.aspect / var_217_1.sprite.bounds.size.x or var_217_2 / var_217_1.sprite.bounds.size.y, 0)
				end

				for iter_217_0, iter_217_1 in pairs(arg_214_1.bgs_) do
					if iter_217_0 ~= "ST39" then
						iter_217_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_217_3 = 0

			if 0 < arg_214_1.time_ and arg_214_1.time_ <= var_217_3 + arg_217_0 then
				arg_214_1.mask_.enabled = true
				arg_214_1.mask_.raycastTarget = true

				arg_214_1:SetGaussion(false)
			end

			local var_217_4 = 2

			if var_217_3 <= arg_214_1.time_ and arg_214_1.time_ < var_217_3 + var_217_4 then
				local var_217_5 = Color.New(0, 0, 0)

				var_217_5.a = Mathf.Lerp(1, 0, (arg_214_1.time_ - var_217_3) / var_217_4)
				arg_214_1.mask_.color = var_217_5
			end

			if arg_214_1.time_ >= var_217_3 + var_217_4 and arg_214_1.time_ < var_217_3 + var_217_4 + arg_217_0 then
				local var_217_6 = Color.New(0, 0, 0)

				arg_214_1.mask_.enabled = false
				var_217_6.a = 0
				arg_214_1.mask_.color = var_217_6
			end

			if arg_214_1.frameCnt_ <= 1 then
				arg_214_1.dialog_:SetActive(false)
			end

			local var_217_7 = 2
			local var_217_8 = 1.45

			if 2 < arg_214_1.time_ and arg_214_1.time_ <= var_217_7 + arg_217_0 then
				arg_214_1.talkMaxDuration = 0

				arg_214_1.dialog_:SetActive(true)

				arg_214_1.dialogCg_.alpha = 0

				local var_217_9 = LeanTween.value(arg_214_1.dialog_, 0, 1, 0.3)

				var_217_9:setOnUpdate(LuaHelper.FloatAction(function(arg_218_0)
					arg_214_1.dialogCg_.alpha = arg_218_0
				end))
				var_217_9:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_214_1.dialog_)
					var_217_9:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_214_1.duration_ = arg_214_1.duration_ + 0.3

				SetActive(arg_214_1.leftNameGo_, false)

				arg_214_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_214_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_214_1:RecordName(arg_214_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_214_1.iconTrs_.gameObject, false)
				arg_214_1.callingController_:SetSelectedState("normal")

				local var_217_10 = arg_214_1:FormatText(arg_214_1:GetWordFromCfg(221031049).content)

				arg_214_1.text_.text = var_217_10

				LuaForUtil.ClearLinePrefixSymbol(arg_214_1.text_)

				local var_217_12 = 58 <= 0 and var_217_8 or var_217_8 * (utf8.len(var_217_10) / 58)

				if (58 <= 0 and var_217_8 or var_217_8 * (utf8.len(var_217_10) / 58)) > 0 and var_217_8 < var_217_12 then
					arg_214_1.talkMaxDuration = var_217_12
					var_217_7 = var_217_7 + 0.3

					if var_217_12 + var_217_7 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_12 + var_217_7
					end
				end

				arg_214_1.text_.text = var_217_10
				arg_214_1.typewritter.percent = 0

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(false)
				arg_214_1:RecordContent(arg_214_1.text_.text)
			end

			local var_217_13 = var_217_7 + 0.3
			local var_217_14 = math.max(var_217_8, arg_214_1.talkMaxDuration)

			if var_217_7 + 0.3 <= arg_214_1.time_ and arg_214_1.time_ < var_217_13 + var_217_14 then
				arg_214_1.typewritter.percent = (arg_214_1.time_ - var_217_13) / var_217_14

				arg_214_1.typewritter:SetDirty()
			end

			if arg_214_1.time_ >= var_217_13 + var_217_14 and arg_214_1.time_ < var_217_13 + var_217_14 + arg_217_0 then
				arg_214_1.typewritter.percent = 1

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(true)
			end
		end

		arg_214_1.nodeConfigList_ = {}

		arg_214_1:InitPlayNodeList()
	end,
	Play221031050 = function(arg_220_0, arg_220_1)
		arg_220_1.time_ = 0
		arg_220_1.frameCnt_ = 0
		arg_220_1.state_ = "playing"
		arg_220_1.curTalkId_ = 221031050
		arg_220_1.duration_ = 3.07

		local var_220_0 = {
			ja = 2.833,
			ko = 3.066,
			zh = 3.066
		}
		local var_220_1 = manager.audio:GetLocalizationFlag()

		if var_220_0[var_220_1] ~= nil then
			arg_220_1.duration_ = var_220_0[var_220_1]
		end

		SetActive(arg_220_1.tipsGo_, false)

		function arg_220_1.onSingleLineFinish_()
			arg_220_1.onSingleLineUpdate_ = nil
			arg_220_1.onSingleLineFinish_ = nil
			arg_220_1.state_ = "waiting"
		end

		function arg_220_1.playNext_(arg_222_0)
			if arg_222_0 == 1 then
				arg_220_0:Play221031051(arg_220_1)
			end
		end

		function arg_220_1.onSingleLineUpdate_(arg_223_0)
			if 0 < arg_220_1.time_ and arg_220_1.time_ <= 0 + arg_223_0 then
				arg_220_1.var_.moveOldPos1072ui_story = arg_220_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_223_0 = 0.001

			if 0 <= arg_220_1.time_ and arg_220_1.time_ < 0 + var_223_0 then
				arg_220_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_220_1.var_.moveOldPos1072ui_story, Vector3.New(0, -0.71, -6), (arg_220_1.time_ - 0) / var_223_0)
				arg_220_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_220_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_220_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_220_1.actors_["1072ui_story"].transform.position).z)
				arg_220_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_220_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_220_1.actors_["1072ui_story"].transform.localEulerAngles = arg_220_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_220_1.time_ >= 0 + var_223_0 and arg_220_1.time_ < 0 + var_223_0 + arg_223_0 then
				arg_220_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_220_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_220_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_220_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_220_1.actors_["1072ui_story"].transform.position).z)
				arg_220_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_220_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_220_1.actors_["1072ui_story"].transform.localEulerAngles = arg_220_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			local var_223_1 = arg_220_1.actors_["1072ui_story"]

			if 0 < arg_220_1.time_ and arg_220_1.time_ <= 0 + arg_223_0 and not isNil(var_223_1) and arg_220_1.var_.characterEffect1072ui_story == nil then
				arg_220_1.var_.characterEffect1072ui_story = var_223_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_223_2 = 0.200000002980232

			if 0 <= arg_220_1.time_ and arg_220_1.time_ < 0 + var_223_2 and not isNil(var_223_1) then
				if arg_220_1.var_.characterEffect1072ui_story and not isNil(var_223_1) then
					arg_220_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_220_1.time_ >= 0 + var_223_2 and arg_220_1.time_ < 0 + var_223_2 + arg_223_0 and not isNil(var_223_1) and arg_220_1.var_.characterEffect1072ui_story then
				arg_220_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			if 0 < arg_220_1.time_ and arg_220_1.time_ <= 0 + arg_223_0 then
				arg_220_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action1_1")
			end

			if 0 < arg_220_1.time_ and arg_220_1.time_ <= 0 + arg_223_0 then
				arg_220_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_223_4 = 0
			local var_223_5 = 0.225

			if 0 < arg_220_1.time_ and arg_220_1.time_ <= var_223_4 + arg_223_0 then
				arg_220_1.talkMaxDuration = 0
				arg_220_1.dialogCg_.alpha = 1

				arg_220_1.dialog_:SetActive(true)
				SetActive(arg_220_1.leftNameGo_, true)

				arg_220_1.leftNameTxt_.text = arg_220_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_220_1.leftNameTxt_.transform)

				arg_220_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_220_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_220_1:RecordName(arg_220_1.leftNameTxt_.text)
				SetActive(arg_220_1.iconTrs_.gameObject, false)
				arg_220_1.callingController_:SetSelectedState("normal")

				local var_223_6 = arg_220_1:GetWordFromCfg(221031050)
				local var_223_7 = arg_220_1:FormatText(var_223_6.content)

				arg_220_1.text_.text = var_223_7

				LuaForUtil.ClearLinePrefixSymbol(arg_220_1.text_)

				local var_223_9 = 9 <= 0 and var_223_5 or var_223_5 * (utf8.len(var_223_7) / 9)

				if (9 <= 0 and var_223_5 or var_223_5 * (utf8.len(var_223_7) / 9)) > 0 and var_223_5 < var_223_9 then
					arg_220_1.talkMaxDuration = var_223_9

					if var_223_9 + var_223_4 > arg_220_1.duration_ then
						arg_220_1.duration_ = var_223_9 + var_223_4
					end
				end

				arg_220_1.text_.text = var_223_7
				arg_220_1.typewritter.percent = 0

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221031", "221031050", "story_v_out_221031.awb") ~= 0 then
					local var_223_10 = manager.audio:GetVoiceLength("story_v_out_221031", "221031050", "story_v_out_221031.awb") / 1000

					if var_223_10 + var_223_4 > arg_220_1.duration_ then
						arg_220_1.duration_ = var_223_10 + var_223_4
					end

					if var_223_6.prefab_name ~= "" and arg_220_1.actors_[var_223_6.prefab_name] ~= nil then
						local var_223_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_220_1.actors_[var_223_6.prefab_name].transform, "story_v_out_221031", "221031050", "story_v_out_221031.awb")

						arg_220_1:RecordAudio("221031050", var_223_11)
						arg_220_1:RecordAudio("221031050", var_223_11)
					else
						arg_220_1:AudioAction("play", "voice", "story_v_out_221031", "221031050", "story_v_out_221031.awb")
					end

					arg_220_1:RecordHistoryTalkVoice("story_v_out_221031", "221031050", "story_v_out_221031.awb")
				end

				arg_220_1:RecordContent(arg_220_1.text_.text)
			end

			local var_223_12 = math.max(var_223_5, arg_220_1.talkMaxDuration)

			if var_223_4 <= arg_220_1.time_ and arg_220_1.time_ < var_223_4 + var_223_12 then
				arg_220_1.typewritter.percent = (arg_220_1.time_ - var_223_4) / var_223_12

				arg_220_1.typewritter:SetDirty()
			end

			if arg_220_1.time_ >= var_223_4 + var_223_12 and arg_220_1.time_ < var_223_4 + var_223_12 + arg_223_0 then
				arg_220_1.typewritter.percent = 1

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(true)
			end
		end

		arg_220_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_220_1:InitPlayNodeList()
	end,
	Play221031051 = function(arg_224_0, arg_224_1)
		arg_224_1.time_ = 0
		arg_224_1.frameCnt_ = 0
		arg_224_1.state_ = "playing"
		arg_224_1.curTalkId_ = 221031051
		arg_224_1.duration_ = 5

		SetActive(arg_224_1.tipsGo_, false)

		function arg_224_1.onSingleLineFinish_()
			arg_224_1.onSingleLineUpdate_ = nil
			arg_224_1.onSingleLineFinish_ = nil
			arg_224_1.state_ = "waiting"
		end

		function arg_224_1.playNext_(arg_226_0)
			if arg_226_0 == 1 then
				arg_224_0:Play221031052(arg_224_1)
			end
		end

		function arg_224_1.onSingleLineUpdate_(arg_227_0)
			if 0 < arg_224_1.time_ and arg_224_1.time_ <= 0 + arg_227_0 and not isNil(arg_224_1.actors_["1072ui_story"]) and arg_224_1.var_.characterEffect1072ui_story == nil then
				arg_224_1.var_.characterEffect1072ui_story = arg_224_1.actors_["1072ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_227_0 = 0.200000002980232

			if 0 <= arg_224_1.time_ and arg_224_1.time_ < 0 + var_227_0 and not isNil(arg_224_1.actors_["1072ui_story"]) then
				if arg_224_1.var_.characterEffect1072ui_story and not isNil(arg_224_1.actors_["1072ui_story"]) then
					arg_224_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_224_1.var_.characterEffect1072ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_224_1.time_ - 0) / var_227_0)
				end
			end

			if arg_224_1.time_ >= 0 + var_227_0 and arg_224_1.time_ < 0 + var_227_0 + arg_227_0 and not isNil(arg_224_1.actors_["1072ui_story"]) and arg_224_1.var_.characterEffect1072ui_story then
				arg_224_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_224_1.var_.characterEffect1072ui_story.fillRatio = 0.5
			end

			local var_227_1 = 0
			local var_227_2 = 1.2

			if 0 < arg_224_1.time_ and arg_224_1.time_ <= var_227_1 + arg_227_0 then
				arg_224_1.talkMaxDuration = 0
				arg_224_1.dialogCg_.alpha = 1

				arg_224_1.dialog_:SetActive(true)
				SetActive(arg_224_1.leftNameGo_, false)

				arg_224_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_224_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_224_1:RecordName(arg_224_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_224_1.iconTrs_.gameObject, false)
				arg_224_1.callingController_:SetSelectedState("normal")

				local var_227_3 = arg_224_1:FormatText(arg_224_1:GetWordFromCfg(221031051).content)

				arg_224_1.text_.text = var_227_3

				LuaForUtil.ClearLinePrefixSymbol(arg_224_1.text_)

				local var_227_5 = 47 <= 0 and var_227_2 or var_227_2 * (utf8.len(var_227_3) / 47)

				if (47 <= 0 and var_227_2 or var_227_2 * (utf8.len(var_227_3) / 47)) > 0 and var_227_2 < var_227_5 then
					arg_224_1.talkMaxDuration = var_227_5

					if var_227_5 + var_227_1 > arg_224_1.duration_ then
						arg_224_1.duration_ = var_227_5 + var_227_1
					end
				end

				arg_224_1.text_.text = var_227_3
				arg_224_1.typewritter.percent = 0

				arg_224_1.typewritter:SetDirty()
				arg_224_1:ShowNextGo(false)
				arg_224_1:RecordContent(arg_224_1.text_.text)
			end

			local var_227_6 = math.max(var_227_2, arg_224_1.talkMaxDuration)

			if var_227_1 <= arg_224_1.time_ and arg_224_1.time_ < var_227_1 + var_227_6 then
				arg_224_1.typewritter.percent = (arg_224_1.time_ - var_227_1) / var_227_6

				arg_224_1.typewritter:SetDirty()
			end

			if arg_224_1.time_ >= var_227_1 + var_227_6 and arg_224_1.time_ < var_227_1 + var_227_6 + arg_227_0 then
				arg_224_1.typewritter.percent = 1

				arg_224_1.typewritter:SetDirty()
				arg_224_1:ShowNextGo(true)
			end
		end

		arg_224_1.nodeConfigList_ = {}

		arg_224_1:InitPlayNodeList()
	end,
	Play221031052 = function(arg_228_0, arg_228_1)
		arg_228_1.time_ = 0
		arg_228_1.frameCnt_ = 0
		arg_228_1.state_ = "playing"
		arg_228_1.curTalkId_ = 221031052
		arg_228_1.duration_ = 7.03

		local var_228_0 = {
			ja = 7.033,
			ko = 4.233,
			zh = 4.233
		}
		local var_228_1 = manager.audio:GetLocalizationFlag()

		if var_228_0[var_228_1] ~= nil then
			arg_228_1.duration_ = var_228_0[var_228_1]
		end

		SetActive(arg_228_1.tipsGo_, false)

		function arg_228_1.onSingleLineFinish_()
			arg_228_1.onSingleLineUpdate_ = nil
			arg_228_1.onSingleLineFinish_ = nil
			arg_228_1.state_ = "waiting"
		end

		function arg_228_1.playNext_(arg_230_0)
			if arg_230_0 == 1 then
				arg_228_0:Play221031053(arg_228_1)
			end
		end

		function arg_228_1.onSingleLineUpdate_(arg_231_0)
			if 0 < arg_228_1.time_ and arg_228_1.time_ <= 0 + arg_231_0 then
				arg_228_1.var_.moveOldPos1072ui_story = arg_228_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_231_0 = 0.001

			if 0 <= arg_228_1.time_ and arg_228_1.time_ < 0 + var_231_0 then
				arg_228_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_228_1.var_.moveOldPos1072ui_story, Vector3.New(0, -0.71, -6), (arg_228_1.time_ - 0) / var_231_0)
				arg_228_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_228_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_228_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_228_1.actors_["1072ui_story"].transform.position).z)
				arg_228_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_228_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_228_1.actors_["1072ui_story"].transform.localEulerAngles = arg_228_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_228_1.time_ >= 0 + var_231_0 and arg_228_1.time_ < 0 + var_231_0 + arg_231_0 then
				arg_228_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_228_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_228_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_228_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_228_1.actors_["1072ui_story"].transform.position).z)
				arg_228_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_228_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_228_1.actors_["1072ui_story"].transform.localEulerAngles = arg_228_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			local var_231_1 = arg_228_1.actors_["1072ui_story"]

			if 0 < arg_228_1.time_ and arg_228_1.time_ <= 0 + arg_231_0 and not isNil(var_231_1) and arg_228_1.var_.characterEffect1072ui_story == nil then
				arg_228_1.var_.characterEffect1072ui_story = var_231_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_231_2 = 0.200000002980232

			if 0 <= arg_228_1.time_ and arg_228_1.time_ < 0 + var_231_2 and not isNil(var_231_1) then
				if arg_228_1.var_.characterEffect1072ui_story and not isNil(var_231_1) then
					arg_228_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_228_1.time_ >= 0 + var_231_2 and arg_228_1.time_ < 0 + var_231_2 + arg_231_0 and not isNil(var_231_1) and arg_228_1.var_.characterEffect1072ui_story then
				arg_228_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			if 0 < arg_228_1.time_ and arg_228_1.time_ <= 0 + arg_231_0 then
				arg_228_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action7_1")
			end

			if 0 < arg_228_1.time_ and arg_228_1.time_ <= 0 + arg_231_0 then
				arg_228_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_231_4 = 0
			local var_231_5 = 0.425

			if 0 < arg_228_1.time_ and arg_228_1.time_ <= var_231_4 + arg_231_0 then
				arg_228_1.talkMaxDuration = 0
				arg_228_1.dialogCg_.alpha = 1

				arg_228_1.dialog_:SetActive(true)
				SetActive(arg_228_1.leftNameGo_, true)

				arg_228_1.leftNameTxt_.text = arg_228_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_228_1.leftNameTxt_.transform)

				arg_228_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_228_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_228_1:RecordName(arg_228_1.leftNameTxt_.text)
				SetActive(arg_228_1.iconTrs_.gameObject, false)
				arg_228_1.callingController_:SetSelectedState("normal")

				local var_231_6 = arg_228_1:GetWordFromCfg(221031052)
				local var_231_7 = arg_228_1:FormatText(var_231_6.content)

				arg_228_1.text_.text = var_231_7

				LuaForUtil.ClearLinePrefixSymbol(arg_228_1.text_)

				local var_231_9 = 17 <= 0 and var_231_5 or var_231_5 * (utf8.len(var_231_7) / 17)

				if (17 <= 0 and var_231_5 or var_231_5 * (utf8.len(var_231_7) / 17)) > 0 and var_231_5 < var_231_9 then
					arg_228_1.talkMaxDuration = var_231_9

					if var_231_9 + var_231_4 > arg_228_1.duration_ then
						arg_228_1.duration_ = var_231_9 + var_231_4
					end
				end

				arg_228_1.text_.text = var_231_7
				arg_228_1.typewritter.percent = 0

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221031", "221031052", "story_v_out_221031.awb") ~= 0 then
					local var_231_10 = manager.audio:GetVoiceLength("story_v_out_221031", "221031052", "story_v_out_221031.awb") / 1000

					if var_231_10 + var_231_4 > arg_228_1.duration_ then
						arg_228_1.duration_ = var_231_10 + var_231_4
					end

					if var_231_6.prefab_name ~= "" and arg_228_1.actors_[var_231_6.prefab_name] ~= nil then
						local var_231_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_228_1.actors_[var_231_6.prefab_name].transform, "story_v_out_221031", "221031052", "story_v_out_221031.awb")

						arg_228_1:RecordAudio("221031052", var_231_11)
						arg_228_1:RecordAudio("221031052", var_231_11)
					else
						arg_228_1:AudioAction("play", "voice", "story_v_out_221031", "221031052", "story_v_out_221031.awb")
					end

					arg_228_1:RecordHistoryTalkVoice("story_v_out_221031", "221031052", "story_v_out_221031.awb")
				end

				arg_228_1:RecordContent(arg_228_1.text_.text)
			end

			local var_231_12 = math.max(var_231_5, arg_228_1.talkMaxDuration)

			if var_231_4 <= arg_228_1.time_ and arg_228_1.time_ < var_231_4 + var_231_12 then
				arg_228_1.typewritter.percent = (arg_228_1.time_ - var_231_4) / var_231_12

				arg_228_1.typewritter:SetDirty()
			end

			if arg_228_1.time_ >= var_231_4 + var_231_12 and arg_228_1.time_ < var_231_4 + var_231_12 + arg_231_0 then
				arg_228_1.typewritter.percent = 1

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(true)
			end
		end

		arg_228_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_228_1:InitPlayNodeList()
	end,
	Play221031053 = function(arg_232_0, arg_232_1)
		arg_232_1.time_ = 0
		arg_232_1.frameCnt_ = 0
		arg_232_1.state_ = "playing"
		arg_232_1.curTalkId_ = 221031053
		arg_232_1.duration_ = 10.1

		local var_232_0 = {
			ja = 10.1,
			ko = 4.933,
			zh = 4.933
		}
		local var_232_1 = manager.audio:GetLocalizationFlag()

		if var_232_0[var_232_1] ~= nil then
			arg_232_1.duration_ = var_232_0[var_232_1]
		end

		SetActive(arg_232_1.tipsGo_, false)

		function arg_232_1.onSingleLineFinish_()
			arg_232_1.onSingleLineUpdate_ = nil
			arg_232_1.onSingleLineFinish_ = nil
			arg_232_1.state_ = "waiting"
		end

		function arg_232_1.playNext_(arg_234_0)
			if arg_234_0 == 1 then
				arg_232_0:Play221031054(arg_232_1)
			end
		end

		function arg_232_1.onSingleLineUpdate_(arg_235_0)
			if 0 < arg_232_1.time_ and arg_232_1.time_ <= 0 + arg_235_0 and not isNil(arg_232_1.actors_["1072ui_story"]) and arg_232_1.var_.characterEffect1072ui_story == nil then
				arg_232_1.var_.characterEffect1072ui_story = arg_232_1.actors_["1072ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_235_0 = 0.200000002980232

			if 0 <= arg_232_1.time_ and arg_232_1.time_ < 0 + var_235_0 and not isNil(arg_232_1.actors_["1072ui_story"]) then
				if arg_232_1.var_.characterEffect1072ui_story and not isNil(arg_232_1.actors_["1072ui_story"]) then
					arg_232_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_232_1.var_.characterEffect1072ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_232_1.time_ - 0) / var_235_0)
				end
			end

			if arg_232_1.time_ >= 0 + var_235_0 and arg_232_1.time_ < 0 + var_235_0 + arg_235_0 and not isNil(arg_232_1.actors_["1072ui_story"]) and arg_232_1.var_.characterEffect1072ui_story then
				arg_232_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_232_1.var_.characterEffect1072ui_story.fillRatio = 0.5
			end

			local var_235_1 = 0
			local var_235_2 = 0.425

			if 0 < arg_232_1.time_ and arg_232_1.time_ <= var_235_1 + arg_235_0 then
				arg_232_1.talkMaxDuration = 0
				arg_232_1.dialogCg_.alpha = 1

				arg_232_1.dialog_:SetActive(true)
				SetActive(arg_232_1.leftNameGo_, true)

				arg_232_1.leftNameTxt_.text = arg_232_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_232_1.leftNameTxt_.transform)

				arg_232_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_232_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_232_1:RecordName(arg_232_1.leftNameTxt_.text)
				SetActive(arg_232_1.iconTrs_.gameObject, false)
				arg_232_1.callingController_:SetSelectedState("normal")

				local var_235_3 = arg_232_1:GetWordFromCfg(221031053)
				local var_235_4 = arg_232_1:FormatText(var_235_3.content)

				arg_232_1.text_.text = var_235_4

				LuaForUtil.ClearLinePrefixSymbol(arg_232_1.text_)

				local var_235_6 = 17 <= 0 and var_235_2 or var_235_2 * (utf8.len(var_235_4) / 17)

				if (17 <= 0 and var_235_2 or var_235_2 * (utf8.len(var_235_4) / 17)) > 0 and var_235_2 < var_235_6 then
					arg_232_1.talkMaxDuration = var_235_6

					if var_235_6 + var_235_1 > arg_232_1.duration_ then
						arg_232_1.duration_ = var_235_6 + var_235_1
					end
				end

				arg_232_1.text_.text = var_235_4
				arg_232_1.typewritter.percent = 0

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221031", "221031053", "story_v_out_221031.awb") ~= 0 then
					local var_235_7 = manager.audio:GetVoiceLength("story_v_out_221031", "221031053", "story_v_out_221031.awb") / 1000

					if var_235_7 + var_235_1 > arg_232_1.duration_ then
						arg_232_1.duration_ = var_235_7 + var_235_1
					end

					if var_235_3.prefab_name ~= "" and arg_232_1.actors_[var_235_3.prefab_name] ~= nil then
						local var_235_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_232_1.actors_[var_235_3.prefab_name].transform, "story_v_out_221031", "221031053", "story_v_out_221031.awb")

						arg_232_1:RecordAudio("221031053", var_235_8)
						arg_232_1:RecordAudio("221031053", var_235_8)
					else
						arg_232_1:AudioAction("play", "voice", "story_v_out_221031", "221031053", "story_v_out_221031.awb")
					end

					arg_232_1:RecordHistoryTalkVoice("story_v_out_221031", "221031053", "story_v_out_221031.awb")
				end

				arg_232_1:RecordContent(arg_232_1.text_.text)
			end

			local var_235_9 = math.max(var_235_2, arg_232_1.talkMaxDuration)

			if var_235_1 <= arg_232_1.time_ and arg_232_1.time_ < var_235_1 + var_235_9 then
				arg_232_1.typewritter.percent = (arg_232_1.time_ - var_235_1) / var_235_9

				arg_232_1.typewritter:SetDirty()
			end

			if arg_232_1.time_ >= var_235_1 + var_235_9 and arg_232_1.time_ < var_235_1 + var_235_9 + arg_235_0 then
				arg_232_1.typewritter.percent = 1

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(true)
			end
		end

		arg_232_1.nodeConfigList_ = {}

		arg_232_1:InitPlayNodeList()
	end,
	Play221031054 = function(arg_236_0, arg_236_1)
		arg_236_1.time_ = 0
		arg_236_1.frameCnt_ = 0
		arg_236_1.state_ = "playing"
		arg_236_1.curTalkId_ = 221031054
		arg_236_1.duration_ = 2

		SetActive(arg_236_1.tipsGo_, false)

		function arg_236_1.onSingleLineFinish_()
			arg_236_1.onSingleLineUpdate_ = nil
			arg_236_1.onSingleLineFinish_ = nil
			arg_236_1.state_ = "waiting"
		end

		function arg_236_1.playNext_(arg_238_0)
			if arg_238_0 == 1 then
				arg_236_0:Play221031055(arg_236_1)
			end
		end

		function arg_236_1.onSingleLineUpdate_(arg_239_0)
			if 0 < arg_236_1.time_ and arg_236_1.time_ <= 0 + arg_239_0 then
				arg_236_1.var_.moveOldPos1072ui_story = arg_236_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_239_0 = 0.001

			if 0 <= arg_236_1.time_ and arg_236_1.time_ < 0 + var_239_0 then
				arg_236_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_236_1.var_.moveOldPos1072ui_story, Vector3.New(0, -0.71, -6), (arg_236_1.time_ - 0) / var_239_0)
				arg_236_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_236_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_236_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_236_1.actors_["1072ui_story"].transform.position).z)
				arg_236_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_236_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_236_1.actors_["1072ui_story"].transform.localEulerAngles = arg_236_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_236_1.time_ >= 0 + var_239_0 and arg_236_1.time_ < 0 + var_239_0 + arg_239_0 then
				arg_236_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_236_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_236_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_236_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_236_1.actors_["1072ui_story"].transform.position).z)
				arg_236_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_236_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_236_1.actors_["1072ui_story"].transform.localEulerAngles = arg_236_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			local var_239_1 = arg_236_1.actors_["1072ui_story"]

			if 0 < arg_236_1.time_ and arg_236_1.time_ <= 0 + arg_239_0 and not isNil(var_239_1) and arg_236_1.var_.characterEffect1072ui_story == nil then
				arg_236_1.var_.characterEffect1072ui_story = var_239_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_239_2 = 0.200000002980232

			if 0 <= arg_236_1.time_ and arg_236_1.time_ < 0 + var_239_2 and not isNil(var_239_1) then
				if arg_236_1.var_.characterEffect1072ui_story and not isNil(var_239_1) then
					arg_236_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_236_1.time_ >= 0 + var_239_2 and arg_236_1.time_ < 0 + var_239_2 + arg_239_0 and not isNil(var_239_1) and arg_236_1.var_.characterEffect1072ui_story then
				arg_236_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			if 0 < arg_236_1.time_ and arg_236_1.time_ <= 0 + arg_239_0 then
				arg_236_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072actionlink/1072action478")
			end

			if 0 < arg_236_1.time_ and arg_236_1.time_ <= 0 + arg_239_0 then
				arg_236_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_239_4 = 0
			local var_239_5 = 0.15

			if 0 < arg_236_1.time_ and arg_236_1.time_ <= var_239_4 + arg_239_0 then
				arg_236_1.talkMaxDuration = 0
				arg_236_1.dialogCg_.alpha = 1

				arg_236_1.dialog_:SetActive(true)
				SetActive(arg_236_1.leftNameGo_, true)

				arg_236_1.leftNameTxt_.text = arg_236_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_236_1.leftNameTxt_.transform)

				arg_236_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_236_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_236_1:RecordName(arg_236_1.leftNameTxt_.text)
				SetActive(arg_236_1.iconTrs_.gameObject, false)
				arg_236_1.callingController_:SetSelectedState("normal")

				local var_239_6 = arg_236_1:GetWordFromCfg(221031054)
				local var_239_7 = arg_236_1:FormatText(var_239_6.content)

				arg_236_1.text_.text = var_239_7

				LuaForUtil.ClearLinePrefixSymbol(arg_236_1.text_)

				local var_239_9 = 6 <= 0 and var_239_5 or var_239_5 * (utf8.len(var_239_7) / 6)

				if (6 <= 0 and var_239_5 or var_239_5 * (utf8.len(var_239_7) / 6)) > 0 and var_239_5 < var_239_9 then
					arg_236_1.talkMaxDuration = var_239_9

					if var_239_9 + var_239_4 > arg_236_1.duration_ then
						arg_236_1.duration_ = var_239_9 + var_239_4
					end
				end

				arg_236_1.text_.text = var_239_7
				arg_236_1.typewritter.percent = 0

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221031", "221031054", "story_v_out_221031.awb") ~= 0 then
					local var_239_10 = manager.audio:GetVoiceLength("story_v_out_221031", "221031054", "story_v_out_221031.awb") / 1000

					if var_239_10 + var_239_4 > arg_236_1.duration_ then
						arg_236_1.duration_ = var_239_10 + var_239_4
					end

					if var_239_6.prefab_name ~= "" and arg_236_1.actors_[var_239_6.prefab_name] ~= nil then
						local var_239_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_236_1.actors_[var_239_6.prefab_name].transform, "story_v_out_221031", "221031054", "story_v_out_221031.awb")

						arg_236_1:RecordAudio("221031054", var_239_11)
						arg_236_1:RecordAudio("221031054", var_239_11)
					else
						arg_236_1:AudioAction("play", "voice", "story_v_out_221031", "221031054", "story_v_out_221031.awb")
					end

					arg_236_1:RecordHistoryTalkVoice("story_v_out_221031", "221031054", "story_v_out_221031.awb")
				end

				arg_236_1:RecordContent(arg_236_1.text_.text)
			end

			local var_239_12 = math.max(var_239_5, arg_236_1.talkMaxDuration)

			if var_239_4 <= arg_236_1.time_ and arg_236_1.time_ < var_239_4 + var_239_12 then
				arg_236_1.typewritter.percent = (arg_236_1.time_ - var_239_4) / var_239_12

				arg_236_1.typewritter:SetDirty()
			end

			if arg_236_1.time_ >= var_239_4 + var_239_12 and arg_236_1.time_ < var_239_4 + var_239_12 + arg_239_0 then
				arg_236_1.typewritter.percent = 1

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(true)
			end
		end

		arg_236_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_236_1:InitPlayNodeList()
	end,
	Play221031055 = function(arg_240_0, arg_240_1)
		arg_240_1.time_ = 0
		arg_240_1.frameCnt_ = 0
		arg_240_1.state_ = "playing"
		arg_240_1.curTalkId_ = 221031055
		arg_240_1.duration_ = 5

		SetActive(arg_240_1.tipsGo_, false)

		function arg_240_1.onSingleLineFinish_()
			arg_240_1.onSingleLineUpdate_ = nil
			arg_240_1.onSingleLineFinish_ = nil
			arg_240_1.state_ = "waiting"
		end

		function arg_240_1.playNext_(arg_242_0)
			if arg_242_0 == 1 then
				arg_240_0:Play221031056(arg_240_1)
			end
		end

		function arg_240_1.onSingleLineUpdate_(arg_243_0)
			if 0 < arg_240_1.time_ and arg_240_1.time_ <= 0 + arg_243_0 and not isNil(arg_240_1.actors_["1072ui_story"]) and arg_240_1.var_.characterEffect1072ui_story == nil then
				arg_240_1.var_.characterEffect1072ui_story = arg_240_1.actors_["1072ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_243_0 = 0.200000002980232

			if 0 <= arg_240_1.time_ and arg_240_1.time_ < 0 + var_243_0 and not isNil(arg_240_1.actors_["1072ui_story"]) then
				if arg_240_1.var_.characterEffect1072ui_story and not isNil(arg_240_1.actors_["1072ui_story"]) then
					arg_240_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_240_1.var_.characterEffect1072ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_240_1.time_ - 0) / var_243_0)
				end
			end

			if arg_240_1.time_ >= 0 + var_243_0 and arg_240_1.time_ < 0 + var_243_0 + arg_243_0 and not isNil(arg_240_1.actors_["1072ui_story"]) and arg_240_1.var_.characterEffect1072ui_story then
				arg_240_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_240_1.var_.characterEffect1072ui_story.fillRatio = 0.5
			end

			local var_243_1 = 0
			local var_243_2 = 1.25

			if 0 < arg_240_1.time_ and arg_240_1.time_ <= var_243_1 + arg_243_0 then
				arg_240_1.talkMaxDuration = 0
				arg_240_1.dialogCg_.alpha = 1

				arg_240_1.dialog_:SetActive(true)
				SetActive(arg_240_1.leftNameGo_, false)

				arg_240_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_240_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_240_1:RecordName(arg_240_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_240_1.iconTrs_.gameObject, false)
				arg_240_1.callingController_:SetSelectedState("normal")

				local var_243_3 = arg_240_1:FormatText(arg_240_1:GetWordFromCfg(221031055).content)

				arg_240_1.text_.text = var_243_3

				LuaForUtil.ClearLinePrefixSymbol(arg_240_1.text_)

				local var_243_5 = 50 <= 0 and var_243_2 or var_243_2 * (utf8.len(var_243_3) / 50)

				if (50 <= 0 and var_243_2 or var_243_2 * (utf8.len(var_243_3) / 50)) > 0 and var_243_2 < var_243_5 then
					arg_240_1.talkMaxDuration = var_243_5

					if var_243_5 + var_243_1 > arg_240_1.duration_ then
						arg_240_1.duration_ = var_243_5 + var_243_1
					end
				end

				arg_240_1.text_.text = var_243_3
				arg_240_1.typewritter.percent = 0

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(false)
				arg_240_1:RecordContent(arg_240_1.text_.text)
			end

			local var_243_6 = math.max(var_243_2, arg_240_1.talkMaxDuration)

			if var_243_1 <= arg_240_1.time_ and arg_240_1.time_ < var_243_1 + var_243_6 then
				arg_240_1.typewritter.percent = (arg_240_1.time_ - var_243_1) / var_243_6

				arg_240_1.typewritter:SetDirty()
			end

			if arg_240_1.time_ >= var_243_1 + var_243_6 and arg_240_1.time_ < var_243_1 + var_243_6 + arg_243_0 then
				arg_240_1.typewritter.percent = 1

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(true)
			end
		end

		arg_240_1.nodeConfigList_ = {}

		arg_240_1:InitPlayNodeList()
	end,
	Play221031056 = function(arg_244_0, arg_244_1)
		arg_244_1.time_ = 0
		arg_244_1.frameCnt_ = 0
		arg_244_1.state_ = "playing"
		arg_244_1.curTalkId_ = 221031056
		arg_244_1.duration_ = 5.67

		local var_244_0 = {
			ja = 4.666,
			ko = 5.666,
			zh = 5.666
		}
		local var_244_1 = manager.audio:GetLocalizationFlag()

		if var_244_0[var_244_1] ~= nil then
			arg_244_1.duration_ = var_244_0[var_244_1]
		end

		SetActive(arg_244_1.tipsGo_, false)

		function arg_244_1.onSingleLineFinish_()
			arg_244_1.onSingleLineUpdate_ = nil
			arg_244_1.onSingleLineFinish_ = nil
			arg_244_1.state_ = "waiting"
		end

		function arg_244_1.playNext_(arg_246_0)
			if arg_246_0 == 1 then
				arg_244_0:Play221031057(arg_244_1)
			end
		end

		function arg_244_1.onSingleLineUpdate_(arg_247_0)
			if 0 < arg_244_1.time_ and arg_244_1.time_ <= 0 + arg_247_0 then
				arg_244_1.var_.moveOldPos1072ui_story = arg_244_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_247_0 = 0.001

			if 0 <= arg_244_1.time_ and arg_244_1.time_ < 0 + var_247_0 then
				arg_244_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_244_1.var_.moveOldPos1072ui_story, Vector3.New(0, -0.71, -6), (arg_244_1.time_ - 0) / var_247_0)
				arg_244_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_244_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_244_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_244_1.actors_["1072ui_story"].transform.position).z)
				arg_244_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_244_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_244_1.actors_["1072ui_story"].transform.localEulerAngles = arg_244_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_244_1.time_ >= 0 + var_247_0 and arg_244_1.time_ < 0 + var_247_0 + arg_247_0 then
				arg_244_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_244_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_244_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_244_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_244_1.actors_["1072ui_story"].transform.position).z)
				arg_244_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_244_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_244_1.actors_["1072ui_story"].transform.localEulerAngles = arg_244_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			local var_247_1 = arg_244_1.actors_["1072ui_story"]

			if 0 < arg_244_1.time_ and arg_244_1.time_ <= 0 + arg_247_0 and not isNil(var_247_1) and arg_244_1.var_.characterEffect1072ui_story == nil then
				arg_244_1.var_.characterEffect1072ui_story = var_247_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_247_2 = 0.200000002980232

			if 0 <= arg_244_1.time_ and arg_244_1.time_ < 0 + var_247_2 and not isNil(var_247_1) then
				if arg_244_1.var_.characterEffect1072ui_story and not isNil(var_247_1) then
					arg_244_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_244_1.time_ >= 0 + var_247_2 and arg_244_1.time_ < 0 + var_247_2 + arg_247_0 and not isNil(var_247_1) and arg_244_1.var_.characterEffect1072ui_story then
				arg_244_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			if 0 < arg_244_1.time_ and arg_244_1.time_ <= 0 + arg_247_0 then
				arg_244_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action8_2")
			end

			if 0 < arg_244_1.time_ and arg_244_1.time_ <= 0 + arg_247_0 then
				arg_244_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_247_4 = 0
			local var_247_5 = 0.475

			if 0 < arg_244_1.time_ and arg_244_1.time_ <= var_247_4 + arg_247_0 then
				arg_244_1.talkMaxDuration = 0
				arg_244_1.dialogCg_.alpha = 1

				arg_244_1.dialog_:SetActive(true)
				SetActive(arg_244_1.leftNameGo_, true)

				arg_244_1.leftNameTxt_.text = arg_244_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_244_1.leftNameTxt_.transform)

				arg_244_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_244_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_244_1:RecordName(arg_244_1.leftNameTxt_.text)
				SetActive(arg_244_1.iconTrs_.gameObject, false)
				arg_244_1.callingController_:SetSelectedState("normal")

				local var_247_6 = arg_244_1:GetWordFromCfg(221031056)
				local var_247_7 = arg_244_1:FormatText(var_247_6.content)

				arg_244_1.text_.text = var_247_7

				LuaForUtil.ClearLinePrefixSymbol(arg_244_1.text_)

				local var_247_9 = 19 <= 0 and var_247_5 or var_247_5 * (utf8.len(var_247_7) / 19)

				if (19 <= 0 and var_247_5 or var_247_5 * (utf8.len(var_247_7) / 19)) > 0 and var_247_5 < var_247_9 then
					arg_244_1.talkMaxDuration = var_247_9

					if var_247_9 + var_247_4 > arg_244_1.duration_ then
						arg_244_1.duration_ = var_247_9 + var_247_4
					end
				end

				arg_244_1.text_.text = var_247_7
				arg_244_1.typewritter.percent = 0

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221031", "221031056", "story_v_out_221031.awb") ~= 0 then
					local var_247_10 = manager.audio:GetVoiceLength("story_v_out_221031", "221031056", "story_v_out_221031.awb") / 1000

					if var_247_10 + var_247_4 > arg_244_1.duration_ then
						arg_244_1.duration_ = var_247_10 + var_247_4
					end

					if var_247_6.prefab_name ~= "" and arg_244_1.actors_[var_247_6.prefab_name] ~= nil then
						local var_247_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_244_1.actors_[var_247_6.prefab_name].transform, "story_v_out_221031", "221031056", "story_v_out_221031.awb")

						arg_244_1:RecordAudio("221031056", var_247_11)
						arg_244_1:RecordAudio("221031056", var_247_11)
					else
						arg_244_1:AudioAction("play", "voice", "story_v_out_221031", "221031056", "story_v_out_221031.awb")
					end

					arg_244_1:RecordHistoryTalkVoice("story_v_out_221031", "221031056", "story_v_out_221031.awb")
				end

				arg_244_1:RecordContent(arg_244_1.text_.text)
			end

			local var_247_12 = math.max(var_247_5, arg_244_1.talkMaxDuration)

			if var_247_4 <= arg_244_1.time_ and arg_244_1.time_ < var_247_4 + var_247_12 then
				arg_244_1.typewritter.percent = (arg_244_1.time_ - var_247_4) / var_247_12

				arg_244_1.typewritter:SetDirty()
			end

			if arg_244_1.time_ >= var_247_4 + var_247_12 and arg_244_1.time_ < var_247_4 + var_247_12 + arg_247_0 then
				arg_244_1.typewritter.percent = 1

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(true)
			end
		end

		arg_244_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_244_1:InitPlayNodeList()
	end,
	Play221031057 = function(arg_248_0, arg_248_1)
		arg_248_1.time_ = 0
		arg_248_1.frameCnt_ = 0
		arg_248_1.state_ = "playing"
		arg_248_1.curTalkId_ = 221031057
		arg_248_1.duration_ = 15.7

		local var_248_0 = {
			ja = 15.7,
			ko = 8.066,
			zh = 8.066
		}
		local var_248_1 = manager.audio:GetLocalizationFlag()

		if var_248_0[var_248_1] ~= nil then
			arg_248_1.duration_ = var_248_0[var_248_1]
		end

		SetActive(arg_248_1.tipsGo_, false)

		function arg_248_1.onSingleLineFinish_()
			arg_248_1.onSingleLineUpdate_ = nil
			arg_248_1.onSingleLineFinish_ = nil
			arg_248_1.state_ = "waiting"
		end

		function arg_248_1.playNext_(arg_250_0)
			if arg_250_0 == 1 then
				arg_248_0:Play221031058(arg_248_1)
			end
		end

		function arg_248_1.onSingleLineUpdate_(arg_251_0)
			if 0 < arg_248_1.time_ and arg_248_1.time_ <= 0 + arg_251_0 and not isNil(arg_248_1.actors_["1072ui_story"]) and arg_248_1.var_.characterEffect1072ui_story == nil then
				arg_248_1.var_.characterEffect1072ui_story = arg_248_1.actors_["1072ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_251_0 = 0.200000002980232

			if 0 <= arg_248_1.time_ and arg_248_1.time_ < 0 + var_251_0 and not isNil(arg_248_1.actors_["1072ui_story"]) then
				if arg_248_1.var_.characterEffect1072ui_story and not isNil(arg_248_1.actors_["1072ui_story"]) then
					arg_248_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_248_1.var_.characterEffect1072ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_248_1.time_ - 0) / var_251_0)
				end
			end

			if arg_248_1.time_ >= 0 + var_251_0 and arg_248_1.time_ < 0 + var_251_0 + arg_251_0 and not isNil(arg_248_1.actors_["1072ui_story"]) and arg_248_1.var_.characterEffect1072ui_story then
				arg_248_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_248_1.var_.characterEffect1072ui_story.fillRatio = 0.5
			end

			local var_251_1 = 0
			local var_251_2 = 0.9

			if 0 < arg_248_1.time_ and arg_248_1.time_ <= var_251_1 + arg_251_0 then
				arg_248_1.talkMaxDuration = 0
				arg_248_1.dialogCg_.alpha = 1

				arg_248_1.dialog_:SetActive(true)
				SetActive(arg_248_1.leftNameGo_, true)

				arg_248_1.leftNameTxt_.text = arg_248_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_248_1.leftNameTxt_.transform)

				arg_248_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_248_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_248_1:RecordName(arg_248_1.leftNameTxt_.text)
				SetActive(arg_248_1.iconTrs_.gameObject, false)
				arg_248_1.callingController_:SetSelectedState("normal")

				local var_251_3 = arg_248_1:GetWordFromCfg(221031057)
				local var_251_4 = arg_248_1:FormatText(var_251_3.content)

				arg_248_1.text_.text = var_251_4

				LuaForUtil.ClearLinePrefixSymbol(arg_248_1.text_)

				local var_251_6 = 36 <= 0 and var_251_2 or var_251_2 * (utf8.len(var_251_4) / 36)

				if (36 <= 0 and var_251_2 or var_251_2 * (utf8.len(var_251_4) / 36)) > 0 and var_251_2 < var_251_6 then
					arg_248_1.talkMaxDuration = var_251_6

					if var_251_6 + var_251_1 > arg_248_1.duration_ then
						arg_248_1.duration_ = var_251_6 + var_251_1
					end
				end

				arg_248_1.text_.text = var_251_4
				arg_248_1.typewritter.percent = 0

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221031", "221031057", "story_v_out_221031.awb") ~= 0 then
					local var_251_7 = manager.audio:GetVoiceLength("story_v_out_221031", "221031057", "story_v_out_221031.awb") / 1000

					if var_251_7 + var_251_1 > arg_248_1.duration_ then
						arg_248_1.duration_ = var_251_7 + var_251_1
					end

					if var_251_3.prefab_name ~= "" and arg_248_1.actors_[var_251_3.prefab_name] ~= nil then
						local var_251_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_248_1.actors_[var_251_3.prefab_name].transform, "story_v_out_221031", "221031057", "story_v_out_221031.awb")

						arg_248_1:RecordAudio("221031057", var_251_8)
						arg_248_1:RecordAudio("221031057", var_251_8)
					else
						arg_248_1:AudioAction("play", "voice", "story_v_out_221031", "221031057", "story_v_out_221031.awb")
					end

					arg_248_1:RecordHistoryTalkVoice("story_v_out_221031", "221031057", "story_v_out_221031.awb")
				end

				arg_248_1:RecordContent(arg_248_1.text_.text)
			end

			local var_251_9 = math.max(var_251_2, arg_248_1.talkMaxDuration)

			if var_251_1 <= arg_248_1.time_ and arg_248_1.time_ < var_251_1 + var_251_9 then
				arg_248_1.typewritter.percent = (arg_248_1.time_ - var_251_1) / var_251_9

				arg_248_1.typewritter:SetDirty()
			end

			if arg_248_1.time_ >= var_251_1 + var_251_9 and arg_248_1.time_ < var_251_1 + var_251_9 + arg_251_0 then
				arg_248_1.typewritter.percent = 1

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(true)
			end
		end

		arg_248_1.nodeConfigList_ = {}

		arg_248_1:InitPlayNodeList()
	end,
	Play221031058 = function(arg_252_0, arg_252_1)
		arg_252_1.time_ = 0
		arg_252_1.frameCnt_ = 0
		arg_252_1.state_ = "playing"
		arg_252_1.curTalkId_ = 221031058
		arg_252_1.duration_ = 6.63

		local var_252_0 = {
			ja = 6.633,
			ko = 4.1,
			zh = 4.1
		}
		local var_252_1 = manager.audio:GetLocalizationFlag()

		if var_252_0[var_252_1] ~= nil then
			arg_252_1.duration_ = var_252_0[var_252_1]
		end

		SetActive(arg_252_1.tipsGo_, false)

		function arg_252_1.onSingleLineFinish_()
			arg_252_1.onSingleLineUpdate_ = nil
			arg_252_1.onSingleLineFinish_ = nil
			arg_252_1.state_ = "waiting"
		end

		function arg_252_1.playNext_(arg_254_0)
			if arg_254_0 == 1 then
				arg_252_0:Play221031059(arg_252_1)
			end
		end

		function arg_252_1.onSingleLineUpdate_(arg_255_0)
			if 0 < arg_252_1.time_ and arg_252_1.time_ <= 0 + arg_255_0 then
				arg_252_1.var_.moveOldPos1072ui_story = arg_252_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_255_0 = 0.001

			if 0 <= arg_252_1.time_ and arg_252_1.time_ < 0 + var_255_0 then
				arg_252_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_252_1.var_.moveOldPos1072ui_story, Vector3.New(0, -0.71, -6), (arg_252_1.time_ - 0) / var_255_0)
				arg_252_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_252_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_252_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_252_1.actors_["1072ui_story"].transform.position).z)
				arg_252_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_252_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_252_1.actors_["1072ui_story"].transform.localEulerAngles = arg_252_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_252_1.time_ >= 0 + var_255_0 and arg_252_1.time_ < 0 + var_255_0 + arg_255_0 then
				arg_252_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_252_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_252_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_252_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_252_1.actors_["1072ui_story"].transform.position).z)
				arg_252_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_252_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_252_1.actors_["1072ui_story"].transform.localEulerAngles = arg_252_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			local var_255_1 = arg_252_1.actors_["1072ui_story"]

			if 0 < arg_252_1.time_ and arg_252_1.time_ <= 0 + arg_255_0 and not isNil(var_255_1) and arg_252_1.var_.characterEffect1072ui_story == nil then
				arg_252_1.var_.characterEffect1072ui_story = var_255_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_255_2 = 0.200000002980232

			if 0 <= arg_252_1.time_ and arg_252_1.time_ < 0 + var_255_2 and not isNil(var_255_1) then
				if arg_252_1.var_.characterEffect1072ui_story and not isNil(var_255_1) then
					arg_252_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_252_1.time_ >= 0 + var_255_2 and arg_252_1.time_ < 0 + var_255_2 + arg_255_0 and not isNil(var_255_1) and arg_252_1.var_.characterEffect1072ui_story then
				arg_252_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			if 0 < arg_252_1.time_ and arg_252_1.time_ <= 0 + arg_255_0 then
				arg_252_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action1_1")
			end

			if 0 < arg_252_1.time_ and arg_252_1.time_ <= 0 + arg_255_0 then
				arg_252_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_255_4 = 0
			local var_255_5 = 0.45

			if 0 < arg_252_1.time_ and arg_252_1.time_ <= var_255_4 + arg_255_0 then
				arg_252_1.talkMaxDuration = 0
				arg_252_1.dialogCg_.alpha = 1

				arg_252_1.dialog_:SetActive(true)
				SetActive(arg_252_1.leftNameGo_, true)

				arg_252_1.leftNameTxt_.text = arg_252_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_252_1.leftNameTxt_.transform)

				arg_252_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_252_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_252_1:RecordName(arg_252_1.leftNameTxt_.text)
				SetActive(arg_252_1.iconTrs_.gameObject, false)
				arg_252_1.callingController_:SetSelectedState("normal")

				local var_255_6 = arg_252_1:GetWordFromCfg(221031058)
				local var_255_7 = arg_252_1:FormatText(var_255_6.content)

				arg_252_1.text_.text = var_255_7

				LuaForUtil.ClearLinePrefixSymbol(arg_252_1.text_)

				local var_255_9 = 18 <= 0 and var_255_5 or var_255_5 * (utf8.len(var_255_7) / 18)

				if (18 <= 0 and var_255_5 or var_255_5 * (utf8.len(var_255_7) / 18)) > 0 and var_255_5 < var_255_9 then
					arg_252_1.talkMaxDuration = var_255_9

					if var_255_9 + var_255_4 > arg_252_1.duration_ then
						arg_252_1.duration_ = var_255_9 + var_255_4
					end
				end

				arg_252_1.text_.text = var_255_7
				arg_252_1.typewritter.percent = 0

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221031", "221031058", "story_v_out_221031.awb") ~= 0 then
					local var_255_10 = manager.audio:GetVoiceLength("story_v_out_221031", "221031058", "story_v_out_221031.awb") / 1000

					if var_255_10 + var_255_4 > arg_252_1.duration_ then
						arg_252_1.duration_ = var_255_10 + var_255_4
					end

					if var_255_6.prefab_name ~= "" and arg_252_1.actors_[var_255_6.prefab_name] ~= nil then
						local var_255_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_252_1.actors_[var_255_6.prefab_name].transform, "story_v_out_221031", "221031058", "story_v_out_221031.awb")

						arg_252_1:RecordAudio("221031058", var_255_11)
						arg_252_1:RecordAudio("221031058", var_255_11)
					else
						arg_252_1:AudioAction("play", "voice", "story_v_out_221031", "221031058", "story_v_out_221031.awb")
					end

					arg_252_1:RecordHistoryTalkVoice("story_v_out_221031", "221031058", "story_v_out_221031.awb")
				end

				arg_252_1:RecordContent(arg_252_1.text_.text)
			end

			local var_255_12 = math.max(var_255_5, arg_252_1.talkMaxDuration)

			if var_255_4 <= arg_252_1.time_ and arg_252_1.time_ < var_255_4 + var_255_12 then
				arg_252_1.typewritter.percent = (arg_252_1.time_ - var_255_4) / var_255_12

				arg_252_1.typewritter:SetDirty()
			end

			if arg_252_1.time_ >= var_255_4 + var_255_12 and arg_252_1.time_ < var_255_4 + var_255_12 + arg_255_0 then
				arg_252_1.typewritter.percent = 1

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(true)
			end
		end

		arg_252_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_252_1:InitPlayNodeList()
	end,
	Play221031059 = function(arg_256_0, arg_256_1)
		arg_256_1.time_ = 0
		arg_256_1.frameCnt_ = 0
		arg_256_1.state_ = "playing"
		arg_256_1.curTalkId_ = 221031059
		arg_256_1.duration_ = 5

		SetActive(arg_256_1.tipsGo_, false)

		function arg_256_1.onSingleLineFinish_()
			arg_256_1.onSingleLineUpdate_ = nil
			arg_256_1.onSingleLineFinish_ = nil
			arg_256_1.state_ = "waiting"
		end

		function arg_256_1.playNext_(arg_258_0)
			if arg_258_0 == 1 then
				arg_256_0:Play221031060(arg_256_1)
			end
		end

		function arg_256_1.onSingleLineUpdate_(arg_259_0)
			if 0 < arg_256_1.time_ and arg_256_1.time_ <= 0 + arg_259_0 and not isNil(arg_256_1.actors_["1072ui_story"]) and arg_256_1.var_.characterEffect1072ui_story == nil then
				arg_256_1.var_.characterEffect1072ui_story = arg_256_1.actors_["1072ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_259_0 = 0.200000002980232

			if 0 <= arg_256_1.time_ and arg_256_1.time_ < 0 + var_259_0 and not isNil(arg_256_1.actors_["1072ui_story"]) then
				if arg_256_1.var_.characterEffect1072ui_story and not isNil(arg_256_1.actors_["1072ui_story"]) then
					arg_256_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_256_1.var_.characterEffect1072ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_256_1.time_ - 0) / var_259_0)
				end
			end

			if arg_256_1.time_ >= 0 + var_259_0 and arg_256_1.time_ < 0 + var_259_0 + arg_259_0 and not isNil(arg_256_1.actors_["1072ui_story"]) and arg_256_1.var_.characterEffect1072ui_story then
				arg_256_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_256_1.var_.characterEffect1072ui_story.fillRatio = 0.5
			end

			local var_259_1 = 0
			local var_259_2 = 0.9

			if 0 < arg_256_1.time_ and arg_256_1.time_ <= var_259_1 + arg_259_0 then
				arg_256_1.talkMaxDuration = 0
				arg_256_1.dialogCg_.alpha = 1

				arg_256_1.dialog_:SetActive(true)
				SetActive(arg_256_1.leftNameGo_, false)

				arg_256_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_256_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_256_1:RecordName(arg_256_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_256_1.iconTrs_.gameObject, false)
				arg_256_1.callingController_:SetSelectedState("normal")

				local var_259_3 = arg_256_1:FormatText(arg_256_1:GetWordFromCfg(221031059).content)

				arg_256_1.text_.text = var_259_3

				LuaForUtil.ClearLinePrefixSymbol(arg_256_1.text_)

				local var_259_5 = 36 <= 0 and var_259_2 or var_259_2 * (utf8.len(var_259_3) / 36)

				if (36 <= 0 and var_259_2 or var_259_2 * (utf8.len(var_259_3) / 36)) > 0 and var_259_2 < var_259_5 then
					arg_256_1.talkMaxDuration = var_259_5

					if var_259_5 + var_259_1 > arg_256_1.duration_ then
						arg_256_1.duration_ = var_259_5 + var_259_1
					end
				end

				arg_256_1.text_.text = var_259_3
				arg_256_1.typewritter.percent = 0

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(false)
				arg_256_1:RecordContent(arg_256_1.text_.text)
			end

			local var_259_6 = math.max(var_259_2, arg_256_1.talkMaxDuration)

			if var_259_1 <= arg_256_1.time_ and arg_256_1.time_ < var_259_1 + var_259_6 then
				arg_256_1.typewritter.percent = (arg_256_1.time_ - var_259_1) / var_259_6

				arg_256_1.typewritter:SetDirty()
			end

			if arg_256_1.time_ >= var_259_1 + var_259_6 and arg_256_1.time_ < var_259_1 + var_259_6 + arg_259_0 then
				arg_256_1.typewritter.percent = 1

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(true)
			end
		end

		arg_256_1.nodeConfigList_ = {}

		arg_256_1:InitPlayNodeList()
	end,
	Play221031060 = function(arg_260_0, arg_260_1)
		arg_260_1.time_ = 0
		arg_260_1.frameCnt_ = 0
		arg_260_1.state_ = "playing"
		arg_260_1.curTalkId_ = 221031060
		arg_260_1.duration_ = 9.13

		local var_260_0 = {
			ja = 9.133,
			ko = 6.4,
			zh = 6.4
		}
		local var_260_1 = manager.audio:GetLocalizationFlag()

		if var_260_0[var_260_1] ~= nil then
			arg_260_1.duration_ = var_260_0[var_260_1]
		end

		SetActive(arg_260_1.tipsGo_, false)

		function arg_260_1.onSingleLineFinish_()
			arg_260_1.onSingleLineUpdate_ = nil
			arg_260_1.onSingleLineFinish_ = nil
			arg_260_1.state_ = "waiting"
		end

		function arg_260_1.playNext_(arg_262_0)
			if arg_262_0 == 1 then
				arg_260_0:Play221031061(arg_260_1)
			end
		end

		function arg_260_1.onSingleLineUpdate_(arg_263_0)
			local var_263_0 = 0.425

			if 0 < arg_260_1.time_ and arg_260_1.time_ <= 0 + arg_263_0 then
				arg_260_1.talkMaxDuration = 0
				arg_260_1.dialogCg_.alpha = 1

				arg_260_1.dialog_:SetActive(true)
				SetActive(arg_260_1.leftNameGo_, true)

				arg_260_1.leftNameTxt_.text = arg_260_1:FormatText(StoryNameCfg[422].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_260_1.leftNameTxt_.transform)

				arg_260_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_260_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_260_1:RecordName(arg_260_1.leftNameTxt_.text)
				SetActive(arg_260_1.iconTrs_.gameObject, true)
				arg_260_1.iconController_:SetSelectedState("hero")

				arg_260_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_260_1.callingController_:SetSelectedState("normal")

				arg_260_1.keyicon_.color = Color.New(1, 1, 1)
				arg_260_1.icon_.color = Color.New(1, 1, 1)

				local var_263_1 = arg_260_1:GetWordFromCfg(221031060)
				local var_263_2 = arg_260_1:FormatText(var_263_1.content)

				arg_260_1.text_.text = var_263_2

				LuaForUtil.ClearLinePrefixSymbol(arg_260_1.text_)

				local var_263_4 = 17 <= 0 and var_263_0 or var_263_0 * (utf8.len(var_263_2) / 17)

				if (17 <= 0 and var_263_0 or var_263_0 * (utf8.len(var_263_2) / 17)) > 0 and var_263_0 < var_263_4 then
					arg_260_1.talkMaxDuration = var_263_4

					if var_263_4 + 0 > arg_260_1.duration_ then
						arg_260_1.duration_ = var_263_4 + 0
					end
				end

				arg_260_1.text_.text = var_263_2
				arg_260_1.typewritter.percent = 0

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221031", "221031060", "story_v_out_221031.awb") ~= 0 then
					local var_263_5 = manager.audio:GetVoiceLength("story_v_out_221031", "221031060", "story_v_out_221031.awb") / 1000

					if var_263_5 + 0 > arg_260_1.duration_ then
						arg_260_1.duration_ = var_263_5 + 0
					end

					if var_263_1.prefab_name ~= "" and arg_260_1.actors_[var_263_1.prefab_name] ~= nil then
						local var_263_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_260_1.actors_[var_263_1.prefab_name].transform, "story_v_out_221031", "221031060", "story_v_out_221031.awb")

						arg_260_1:RecordAudio("221031060", var_263_6)
						arg_260_1:RecordAudio("221031060", var_263_6)
					else
						arg_260_1:AudioAction("play", "voice", "story_v_out_221031", "221031060", "story_v_out_221031.awb")
					end

					arg_260_1:RecordHistoryTalkVoice("story_v_out_221031", "221031060", "story_v_out_221031.awb")
				end

				arg_260_1:RecordContent(arg_260_1.text_.text)
			end

			local var_263_7 = math.max(var_263_0, arg_260_1.talkMaxDuration)

			if 0 <= arg_260_1.time_ and arg_260_1.time_ < 0 + var_263_7 then
				arg_260_1.typewritter.percent = (arg_260_1.time_ - 0) / var_263_7

				arg_260_1.typewritter:SetDirty()
			end

			if arg_260_1.time_ >= 0 + var_263_7 and arg_260_1.time_ < 0 + var_263_7 + arg_263_0 then
				arg_260_1.typewritter.percent = 1

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(true)
			end
		end

		arg_260_1.nodeConfigList_ = {}

		arg_260_1:InitPlayNodeList()
	end,
	Play221031061 = function(arg_264_0, arg_264_1)
		arg_264_1.time_ = 0
		arg_264_1.frameCnt_ = 0
		arg_264_1.state_ = "playing"
		arg_264_1.curTalkId_ = 221031061
		arg_264_1.duration_ = 10.7

		local var_264_0 = {
			ja = 10.7,
			ko = 6.9,
			zh = 6.9
		}
		local var_264_1 = manager.audio:GetLocalizationFlag()

		if var_264_0[var_264_1] ~= nil then
			arg_264_1.duration_ = var_264_0[var_264_1]
		end

		SetActive(arg_264_1.tipsGo_, false)

		function arg_264_1.onSingleLineFinish_()
			arg_264_1.onSingleLineUpdate_ = nil
			arg_264_1.onSingleLineFinish_ = nil
			arg_264_1.state_ = "waiting"
		end

		function arg_264_1.playNext_(arg_266_0)
			if arg_266_0 == 1 then
				arg_264_0:Play221031062(arg_264_1)
			end
		end

		function arg_264_1.onSingleLineUpdate_(arg_267_0)
			if 0 < arg_264_1.time_ and arg_264_1.time_ <= 0 + arg_267_0 then
				arg_264_1.var_.moveOldPos1072ui_story = arg_264_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_267_0 = 0.001

			if 0 <= arg_264_1.time_ and arg_264_1.time_ < 0 + var_267_0 then
				arg_264_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_264_1.var_.moveOldPos1072ui_story, Vector3.New(0, -0.71, -6), (arg_264_1.time_ - 0) / var_267_0)
				arg_264_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_264_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_264_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_264_1.actors_["1072ui_story"].transform.position).z)
				arg_264_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_264_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_264_1.actors_["1072ui_story"].transform.localEulerAngles = arg_264_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_264_1.time_ >= 0 + var_267_0 and arg_264_1.time_ < 0 + var_267_0 + arg_267_0 then
				arg_264_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_264_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_264_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_264_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_264_1.actors_["1072ui_story"].transform.position).z)
				arg_264_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_264_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_264_1.actors_["1072ui_story"].transform.localEulerAngles = arg_264_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			local var_267_1 = arg_264_1.actors_["1072ui_story"]

			if 0 < arg_264_1.time_ and arg_264_1.time_ <= 0 + arg_267_0 and not isNil(var_267_1) and arg_264_1.var_.characterEffect1072ui_story == nil then
				arg_264_1.var_.characterEffect1072ui_story = var_267_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_267_2 = 0.200000002980232

			if 0 <= arg_264_1.time_ and arg_264_1.time_ < 0 + var_267_2 and not isNil(var_267_1) then
				if arg_264_1.var_.characterEffect1072ui_story and not isNil(var_267_1) then
					arg_264_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_264_1.time_ >= 0 + var_267_2 and arg_264_1.time_ < 0 + var_267_2 + arg_267_0 and not isNil(var_267_1) and arg_264_1.var_.characterEffect1072ui_story then
				arg_264_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			if 0 < arg_264_1.time_ and arg_264_1.time_ <= 0 + arg_267_0 then
				arg_264_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action2_1")
			end

			if 0 < arg_264_1.time_ and arg_264_1.time_ <= 0 + arg_267_0 then
				arg_264_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_267_4 = 0
			local var_267_5 = 0.825

			if 0 < arg_264_1.time_ and arg_264_1.time_ <= var_267_4 + arg_267_0 then
				arg_264_1.talkMaxDuration = 0
				arg_264_1.dialogCg_.alpha = 1

				arg_264_1.dialog_:SetActive(true)
				SetActive(arg_264_1.leftNameGo_, true)

				arg_264_1.leftNameTxt_.text = arg_264_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_264_1.leftNameTxt_.transform)

				arg_264_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_264_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_264_1:RecordName(arg_264_1.leftNameTxt_.text)
				SetActive(arg_264_1.iconTrs_.gameObject, false)
				arg_264_1.callingController_:SetSelectedState("normal")

				local var_267_6 = arg_264_1:GetWordFromCfg(221031061)
				local var_267_7 = arg_264_1:FormatText(var_267_6.content)

				arg_264_1.text_.text = var_267_7

				LuaForUtil.ClearLinePrefixSymbol(arg_264_1.text_)

				local var_267_9 = 33 <= 0 and var_267_5 or var_267_5 * (utf8.len(var_267_7) / 33)

				if (33 <= 0 and var_267_5 or var_267_5 * (utf8.len(var_267_7) / 33)) > 0 and var_267_5 < var_267_9 then
					arg_264_1.talkMaxDuration = var_267_9

					if var_267_9 + var_267_4 > arg_264_1.duration_ then
						arg_264_1.duration_ = var_267_9 + var_267_4
					end
				end

				arg_264_1.text_.text = var_267_7
				arg_264_1.typewritter.percent = 0

				arg_264_1.typewritter:SetDirty()
				arg_264_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221031", "221031061", "story_v_out_221031.awb") ~= 0 then
					local var_267_10 = manager.audio:GetVoiceLength("story_v_out_221031", "221031061", "story_v_out_221031.awb") / 1000

					if var_267_10 + var_267_4 > arg_264_1.duration_ then
						arg_264_1.duration_ = var_267_10 + var_267_4
					end

					if var_267_6.prefab_name ~= "" and arg_264_1.actors_[var_267_6.prefab_name] ~= nil then
						local var_267_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_264_1.actors_[var_267_6.prefab_name].transform, "story_v_out_221031", "221031061", "story_v_out_221031.awb")

						arg_264_1:RecordAudio("221031061", var_267_11)
						arg_264_1:RecordAudio("221031061", var_267_11)
					else
						arg_264_1:AudioAction("play", "voice", "story_v_out_221031", "221031061", "story_v_out_221031.awb")
					end

					arg_264_1:RecordHistoryTalkVoice("story_v_out_221031", "221031061", "story_v_out_221031.awb")
				end

				arg_264_1:RecordContent(arg_264_1.text_.text)
			end

			local var_267_12 = math.max(var_267_5, arg_264_1.talkMaxDuration)

			if var_267_4 <= arg_264_1.time_ and arg_264_1.time_ < var_267_4 + var_267_12 then
				arg_264_1.typewritter.percent = (arg_264_1.time_ - var_267_4) / var_267_12

				arg_264_1.typewritter:SetDirty()
			end

			if arg_264_1.time_ >= var_267_4 + var_267_12 and arg_264_1.time_ < var_267_4 + var_267_12 + arg_267_0 then
				arg_264_1.typewritter.percent = 1

				arg_264_1.typewritter:SetDirty()
				arg_264_1:ShowNextGo(true)
			end
		end

		arg_264_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_264_1:InitPlayNodeList()
	end,
	Play221031062 = function(arg_268_0, arg_268_1)
		arg_268_1.time_ = 0
		arg_268_1.frameCnt_ = 0
		arg_268_1.state_ = "playing"
		arg_268_1.curTalkId_ = 221031062
		arg_268_1.duration_ = 12.7

		local var_268_0 = {
			ja = 12.5,
			ko = 12.7,
			zh = 12.7
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
				arg_268_0:Play221031063(arg_268_1)
			end
		end

		function arg_268_1.onSingleLineUpdate_(arg_271_0)
			if 0 < arg_268_1.time_ and arg_268_1.time_ <= 0 + arg_271_0 and not isNil(arg_268_1.actors_["1072ui_story"]) and arg_268_1.var_.characterEffect1072ui_story == nil then
				arg_268_1.var_.characterEffect1072ui_story = arg_268_1.actors_["1072ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_271_0 = 0.200000002980232

			if 0 <= arg_268_1.time_ and arg_268_1.time_ < 0 + var_271_0 and not isNil(arg_268_1.actors_["1072ui_story"]) then
				if arg_268_1.var_.characterEffect1072ui_story and not isNil(arg_268_1.actors_["1072ui_story"]) then
					arg_268_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_268_1.var_.characterEffect1072ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_268_1.time_ - 0) / var_271_0)
				end
			end

			if arg_268_1.time_ >= 0 + var_271_0 and arg_268_1.time_ < 0 + var_271_0 + arg_271_0 and not isNil(arg_268_1.actors_["1072ui_story"]) and arg_268_1.var_.characterEffect1072ui_story then
				arg_268_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_268_1.var_.characterEffect1072ui_story.fillRatio = 0.5
			end

			local var_271_1 = 0
			local var_271_2 = 1.45

			if 0 < arg_268_1.time_ and arg_268_1.time_ <= var_271_1 + arg_271_0 then
				arg_268_1.talkMaxDuration = 0
				arg_268_1.dialogCg_.alpha = 1

				arg_268_1.dialog_:SetActive(true)
				SetActive(arg_268_1.leftNameGo_, true)

				arg_268_1.leftNameTxt_.text = arg_268_1:FormatText(StoryNameCfg[422].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_268_1.leftNameTxt_.transform)

				arg_268_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_268_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_268_1:RecordName(arg_268_1.leftNameTxt_.text)
				SetActive(arg_268_1.iconTrs_.gameObject, true)
				arg_268_1.iconController_:SetSelectedState("hero")

				arg_268_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_268_1.callingController_:SetSelectedState("normal")

				arg_268_1.keyicon_.color = Color.New(1, 1, 1)
				arg_268_1.icon_.color = Color.New(1, 1, 1)

				local var_271_3 = arg_268_1:GetWordFromCfg(221031062)
				local var_271_4 = arg_268_1:FormatText(var_271_3.content)

				arg_268_1.text_.text = var_271_4

				LuaForUtil.ClearLinePrefixSymbol(arg_268_1.text_)

				local var_271_6 = 58 <= 0 and var_271_2 or var_271_2 * (utf8.len(var_271_4) / 58)

				if (58 <= 0 and var_271_2 or var_271_2 * (utf8.len(var_271_4) / 58)) > 0 and var_271_2 < var_271_6 then
					arg_268_1.talkMaxDuration = var_271_6

					if var_271_6 + var_271_1 > arg_268_1.duration_ then
						arg_268_1.duration_ = var_271_6 + var_271_1
					end
				end

				arg_268_1.text_.text = var_271_4
				arg_268_1.typewritter.percent = 0

				arg_268_1.typewritter:SetDirty()
				arg_268_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221031", "221031062", "story_v_out_221031.awb") ~= 0 then
					local var_271_7 = manager.audio:GetVoiceLength("story_v_out_221031", "221031062", "story_v_out_221031.awb") / 1000

					if var_271_7 + var_271_1 > arg_268_1.duration_ then
						arg_268_1.duration_ = var_271_7 + var_271_1
					end

					if var_271_3.prefab_name ~= "" and arg_268_1.actors_[var_271_3.prefab_name] ~= nil then
						local var_271_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_268_1.actors_[var_271_3.prefab_name].transform, "story_v_out_221031", "221031062", "story_v_out_221031.awb")

						arg_268_1:RecordAudio("221031062", var_271_8)
						arg_268_1:RecordAudio("221031062", var_271_8)
					else
						arg_268_1:AudioAction("play", "voice", "story_v_out_221031", "221031062", "story_v_out_221031.awb")
					end

					arg_268_1:RecordHistoryTalkVoice("story_v_out_221031", "221031062", "story_v_out_221031.awb")
				end

				arg_268_1:RecordContent(arg_268_1.text_.text)
			end

			local var_271_9 = math.max(var_271_2, arg_268_1.talkMaxDuration)

			if var_271_1 <= arg_268_1.time_ and arg_268_1.time_ < var_271_1 + var_271_9 then
				arg_268_1.typewritter.percent = (arg_268_1.time_ - var_271_1) / var_271_9

				arg_268_1.typewritter:SetDirty()
			end

			if arg_268_1.time_ >= var_271_1 + var_271_9 and arg_268_1.time_ < var_271_1 + var_271_9 + arg_271_0 then
				arg_268_1.typewritter.percent = 1

				arg_268_1.typewritter:SetDirty()
				arg_268_1:ShowNextGo(true)
			end
		end

		arg_268_1.nodeConfigList_ = {}

		arg_268_1:InitPlayNodeList()
	end,
	Play221031063 = function(arg_272_0, arg_272_1)
		arg_272_1.time_ = 0
		arg_272_1.frameCnt_ = 0
		arg_272_1.state_ = "playing"
		arg_272_1.curTalkId_ = 221031063
		arg_272_1.duration_ = 7.63

		local var_272_0 = {
			ja = 7.633,
			ko = 6.666,
			zh = 6.666
		}
		local var_272_1 = manager.audio:GetLocalizationFlag()

		if var_272_0[var_272_1] ~= nil then
			arg_272_1.duration_ = var_272_0[var_272_1]
		end

		SetActive(arg_272_1.tipsGo_, false)

		function arg_272_1.onSingleLineFinish_()
			arg_272_1.onSingleLineUpdate_ = nil
			arg_272_1.onSingleLineFinish_ = nil
			arg_272_1.state_ = "waiting"
		end

		function arg_272_1.playNext_(arg_274_0)
			if arg_274_0 == 1 then
				arg_272_0:Play221031064(arg_272_1)
			end
		end

		function arg_272_1.onSingleLineUpdate_(arg_275_0)
			if 0 < arg_272_1.time_ and arg_272_1.time_ <= 0 + arg_275_0 then
				arg_272_1.var_.moveOldPos1072ui_story = arg_272_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_275_0 = 0.001

			if 0 <= arg_272_1.time_ and arg_272_1.time_ < 0 + var_275_0 then
				arg_272_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_272_1.var_.moveOldPos1072ui_story, Vector3.New(0, -0.71, -6), (arg_272_1.time_ - 0) / var_275_0)
				arg_272_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_272_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_272_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_272_1.actors_["1072ui_story"].transform.position).z)
				arg_272_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_272_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_272_1.actors_["1072ui_story"].transform.localEulerAngles = arg_272_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_272_1.time_ >= 0 + var_275_0 and arg_272_1.time_ < 0 + var_275_0 + arg_275_0 then
				arg_272_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_272_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_272_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_272_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_272_1.actors_["1072ui_story"].transform.position).z)
				arg_272_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_272_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_272_1.actors_["1072ui_story"].transform.localEulerAngles = arg_272_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			local var_275_1 = arg_272_1.actors_["1072ui_story"]

			if 0 < arg_272_1.time_ and arg_272_1.time_ <= 0 + arg_275_0 and not isNil(var_275_1) and arg_272_1.var_.characterEffect1072ui_story == nil then
				arg_272_1.var_.characterEffect1072ui_story = var_275_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_275_2 = 0.200000002980232

			if 0 <= arg_272_1.time_ and arg_272_1.time_ < 0 + var_275_2 and not isNil(var_275_1) then
				if arg_272_1.var_.characterEffect1072ui_story and not isNil(var_275_1) then
					arg_272_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_272_1.time_ >= 0 + var_275_2 and arg_272_1.time_ < 0 + var_275_2 + arg_275_0 and not isNil(var_275_1) and arg_272_1.var_.characterEffect1072ui_story then
				arg_272_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			if 0 < arg_272_1.time_ and arg_272_1.time_ <= 0 + arg_275_0 then
				arg_272_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072actionlink/1072action423")
			end

			if 0 < arg_272_1.time_ and arg_272_1.time_ <= 0 + arg_275_0 then
				arg_272_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_275_4 = 0
			local var_275_5 = 0.5

			if 0 < arg_272_1.time_ and arg_272_1.time_ <= var_275_4 + arg_275_0 then
				arg_272_1.talkMaxDuration = 0
				arg_272_1.dialogCg_.alpha = 1

				arg_272_1.dialog_:SetActive(true)
				SetActive(arg_272_1.leftNameGo_, true)

				arg_272_1.leftNameTxt_.text = arg_272_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_272_1.leftNameTxt_.transform)

				arg_272_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_272_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_272_1:RecordName(arg_272_1.leftNameTxt_.text)
				SetActive(arg_272_1.iconTrs_.gameObject, false)
				arg_272_1.callingController_:SetSelectedState("normal")

				local var_275_6 = arg_272_1:GetWordFromCfg(221031063)
				local var_275_7 = arg_272_1:FormatText(var_275_6.content)

				arg_272_1.text_.text = var_275_7

				LuaForUtil.ClearLinePrefixSymbol(arg_272_1.text_)

				local var_275_9 = 20 <= 0 and var_275_5 or var_275_5 * (utf8.len(var_275_7) / 20)

				if (20 <= 0 and var_275_5 or var_275_5 * (utf8.len(var_275_7) / 20)) > 0 and var_275_5 < var_275_9 then
					arg_272_1.talkMaxDuration = var_275_9

					if var_275_9 + var_275_4 > arg_272_1.duration_ then
						arg_272_1.duration_ = var_275_9 + var_275_4
					end
				end

				arg_272_1.text_.text = var_275_7
				arg_272_1.typewritter.percent = 0

				arg_272_1.typewritter:SetDirty()
				arg_272_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221031", "221031063", "story_v_out_221031.awb") ~= 0 then
					local var_275_10 = manager.audio:GetVoiceLength("story_v_out_221031", "221031063", "story_v_out_221031.awb") / 1000

					if var_275_10 + var_275_4 > arg_272_1.duration_ then
						arg_272_1.duration_ = var_275_10 + var_275_4
					end

					if var_275_6.prefab_name ~= "" and arg_272_1.actors_[var_275_6.prefab_name] ~= nil then
						local var_275_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_272_1.actors_[var_275_6.prefab_name].transform, "story_v_out_221031", "221031063", "story_v_out_221031.awb")

						arg_272_1:RecordAudio("221031063", var_275_11)
						arg_272_1:RecordAudio("221031063", var_275_11)
					else
						arg_272_1:AudioAction("play", "voice", "story_v_out_221031", "221031063", "story_v_out_221031.awb")
					end

					arg_272_1:RecordHistoryTalkVoice("story_v_out_221031", "221031063", "story_v_out_221031.awb")
				end

				arg_272_1:RecordContent(arg_272_1.text_.text)
			end

			local var_275_12 = math.max(var_275_5, arg_272_1.talkMaxDuration)

			if var_275_4 <= arg_272_1.time_ and arg_272_1.time_ < var_275_4 + var_275_12 then
				arg_272_1.typewritter.percent = (arg_272_1.time_ - var_275_4) / var_275_12

				arg_272_1.typewritter:SetDirty()
			end

			if arg_272_1.time_ >= var_275_4 + var_275_12 and arg_272_1.time_ < var_275_4 + var_275_12 + arg_275_0 then
				arg_272_1.typewritter.percent = 1

				arg_272_1.typewritter:SetDirty()
				arg_272_1:ShowNextGo(true)
			end
		end

		arg_272_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_272_1:InitPlayNodeList()
	end,
	Play221031064 = function(arg_276_0, arg_276_1)
		arg_276_1.time_ = 0
		arg_276_1.frameCnt_ = 0
		arg_276_1.state_ = "playing"
		arg_276_1.curTalkId_ = 221031064
		arg_276_1.duration_ = 11.57

		local var_276_0 = {
			ja = 11.566,
			ko = 6.266,
			zh = 6.266
		}
		local var_276_1 = manager.audio:GetLocalizationFlag()

		if var_276_0[var_276_1] ~= nil then
			arg_276_1.duration_ = var_276_0[var_276_1]
		end

		SetActive(arg_276_1.tipsGo_, false)

		function arg_276_1.onSingleLineFinish_()
			arg_276_1.onSingleLineUpdate_ = nil
			arg_276_1.onSingleLineFinish_ = nil
			arg_276_1.state_ = "waiting"
		end

		function arg_276_1.playNext_(arg_278_0)
			if arg_278_0 == 1 then
				arg_276_0:Play221031065(arg_276_1)
			end
		end

		function arg_276_1.onSingleLineUpdate_(arg_279_0)
			if 0 < arg_276_1.time_ and arg_276_1.time_ <= 0 + arg_279_0 then
				arg_276_1.var_.moveOldPos1072ui_story = arg_276_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_279_0 = 0.001

			if 0 <= arg_276_1.time_ and arg_276_1.time_ < 0 + var_279_0 then
				arg_276_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_276_1.var_.moveOldPos1072ui_story, Vector3.New(0, -0.71, -6), (arg_276_1.time_ - 0) / var_279_0)
				arg_276_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_276_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_276_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_276_1.actors_["1072ui_story"].transform.position).z)
				arg_276_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_276_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_276_1.actors_["1072ui_story"].transform.localEulerAngles = arg_276_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_276_1.time_ >= 0 + var_279_0 and arg_276_1.time_ < 0 + var_279_0 + arg_279_0 then
				arg_276_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_276_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_276_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_276_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_276_1.actors_["1072ui_story"].transform.position).z)
				arg_276_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_276_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_276_1.actors_["1072ui_story"].transform.localEulerAngles = arg_276_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if 0 < arg_276_1.time_ and arg_276_1.time_ <= 0 + arg_279_0 then
				arg_276_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action3_2")
			end

			if 0 < arg_276_1.time_ and arg_276_1.time_ <= 0 + arg_279_0 then
				arg_276_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_279_1 = 0
			local var_279_2 = 0.8

			if 0 < arg_276_1.time_ and arg_276_1.time_ <= var_279_1 + arg_279_0 then
				arg_276_1.talkMaxDuration = 0
				arg_276_1.dialogCg_.alpha = 1

				arg_276_1.dialog_:SetActive(true)
				SetActive(arg_276_1.leftNameGo_, true)

				arg_276_1.leftNameTxt_.text = arg_276_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_276_1.leftNameTxt_.transform)

				arg_276_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_276_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_276_1:RecordName(arg_276_1.leftNameTxt_.text)
				SetActive(arg_276_1.iconTrs_.gameObject, false)
				arg_276_1.callingController_:SetSelectedState("normal")

				local var_279_3 = arg_276_1:GetWordFromCfg(221031064)
				local var_279_4 = arg_276_1:FormatText(var_279_3.content)

				arg_276_1.text_.text = var_279_4

				LuaForUtil.ClearLinePrefixSymbol(arg_276_1.text_)

				local var_279_6 = 32 <= 0 and var_279_2 or var_279_2 * (utf8.len(var_279_4) / 32)

				if (32 <= 0 and var_279_2 or var_279_2 * (utf8.len(var_279_4) / 32)) > 0 and var_279_2 < var_279_6 then
					arg_276_1.talkMaxDuration = var_279_6

					if var_279_6 + var_279_1 > arg_276_1.duration_ then
						arg_276_1.duration_ = var_279_6 + var_279_1
					end
				end

				arg_276_1.text_.text = var_279_4
				arg_276_1.typewritter.percent = 0

				arg_276_1.typewritter:SetDirty()
				arg_276_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221031", "221031064", "story_v_out_221031.awb") ~= 0 then
					local var_279_7 = manager.audio:GetVoiceLength("story_v_out_221031", "221031064", "story_v_out_221031.awb") / 1000

					if var_279_7 + var_279_1 > arg_276_1.duration_ then
						arg_276_1.duration_ = var_279_7 + var_279_1
					end

					if var_279_3.prefab_name ~= "" and arg_276_1.actors_[var_279_3.prefab_name] ~= nil then
						local var_279_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_276_1.actors_[var_279_3.prefab_name].transform, "story_v_out_221031", "221031064", "story_v_out_221031.awb")

						arg_276_1:RecordAudio("221031064", var_279_8)
						arg_276_1:RecordAudio("221031064", var_279_8)
					else
						arg_276_1:AudioAction("play", "voice", "story_v_out_221031", "221031064", "story_v_out_221031.awb")
					end

					arg_276_1:RecordHistoryTalkVoice("story_v_out_221031", "221031064", "story_v_out_221031.awb")
				end

				arg_276_1:RecordContent(arg_276_1.text_.text)
			end

			local var_279_9 = math.max(var_279_2, arg_276_1.talkMaxDuration)

			if var_279_1 <= arg_276_1.time_ and arg_276_1.time_ < var_279_1 + var_279_9 then
				arg_276_1.typewritter.percent = (arg_276_1.time_ - var_279_1) / var_279_9

				arg_276_1.typewritter:SetDirty()
			end

			if arg_276_1.time_ >= var_279_1 + var_279_9 and arg_276_1.time_ < var_279_1 + var_279_9 + arg_279_0 then
				arg_276_1.typewritter.percent = 1

				arg_276_1.typewritter:SetDirty()
				arg_276_1:ShowNextGo(true)
			end
		end

		arg_276_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_276_1:InitPlayNodeList()
	end,
	Play221031065 = function(arg_280_0, arg_280_1)
		arg_280_1.time_ = 0
		arg_280_1.frameCnt_ = 0
		arg_280_1.state_ = "playing"
		arg_280_1.curTalkId_ = 221031065
		arg_280_1.duration_ = 5

		SetActive(arg_280_1.tipsGo_, false)

		function arg_280_1.onSingleLineFinish_()
			arg_280_1.onSingleLineUpdate_ = nil
			arg_280_1.onSingleLineFinish_ = nil
			arg_280_1.state_ = "waiting"
		end

		function arg_280_1.playNext_(arg_282_0)
			if arg_282_0 == 1 then
				arg_280_0:Play221031066(arg_280_1)
			end
		end

		function arg_280_1.onSingleLineUpdate_(arg_283_0)
			if 0 < arg_280_1.time_ and arg_280_1.time_ <= 0 + arg_283_0 and not isNil(arg_280_1.actors_["1072ui_story"]) and arg_280_1.var_.characterEffect1072ui_story == nil then
				arg_280_1.var_.characterEffect1072ui_story = arg_280_1.actors_["1072ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_283_0 = 0.200000002980232

			if 0 <= arg_280_1.time_ and arg_280_1.time_ < 0 + var_283_0 and not isNil(arg_280_1.actors_["1072ui_story"]) then
				if arg_280_1.var_.characterEffect1072ui_story and not isNil(arg_280_1.actors_["1072ui_story"]) then
					arg_280_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_280_1.var_.characterEffect1072ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_280_1.time_ - 0) / var_283_0)
				end
			end

			if arg_280_1.time_ >= 0 + var_283_0 and arg_280_1.time_ < 0 + var_283_0 + arg_283_0 and not isNil(arg_280_1.actors_["1072ui_story"]) and arg_280_1.var_.characterEffect1072ui_story then
				arg_280_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_280_1.var_.characterEffect1072ui_story.fillRatio = 0.5
			end

			local var_283_1 = 0
			local var_283_2 = 0.725

			if 0 < arg_280_1.time_ and arg_280_1.time_ <= var_283_1 + arg_283_0 then
				arg_280_1.talkMaxDuration = 0
				arg_280_1.dialogCg_.alpha = 1

				arg_280_1.dialog_:SetActive(true)
				SetActive(arg_280_1.leftNameGo_, false)

				arg_280_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_280_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_280_1:RecordName(arg_280_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_280_1.iconTrs_.gameObject, false)
				arg_280_1.callingController_:SetSelectedState("normal")

				local var_283_3 = arg_280_1:FormatText(arg_280_1:GetWordFromCfg(221031065).content)

				arg_280_1.text_.text = var_283_3

				LuaForUtil.ClearLinePrefixSymbol(arg_280_1.text_)

				local var_283_5 = 29 <= 0 and var_283_2 or var_283_2 * (utf8.len(var_283_3) / 29)

				if (29 <= 0 and var_283_2 or var_283_2 * (utf8.len(var_283_3) / 29)) > 0 and var_283_2 < var_283_5 then
					arg_280_1.talkMaxDuration = var_283_5

					if var_283_5 + var_283_1 > arg_280_1.duration_ then
						arg_280_1.duration_ = var_283_5 + var_283_1
					end
				end

				arg_280_1.text_.text = var_283_3
				arg_280_1.typewritter.percent = 0

				arg_280_1.typewritter:SetDirty()
				arg_280_1:ShowNextGo(false)
				arg_280_1:RecordContent(arg_280_1.text_.text)
			end

			local var_283_6 = math.max(var_283_2, arg_280_1.talkMaxDuration)

			if var_283_1 <= arg_280_1.time_ and arg_280_1.time_ < var_283_1 + var_283_6 then
				arg_280_1.typewritter.percent = (arg_280_1.time_ - var_283_1) / var_283_6

				arg_280_1.typewritter:SetDirty()
			end

			if arg_280_1.time_ >= var_283_1 + var_283_6 and arg_280_1.time_ < var_283_1 + var_283_6 + arg_283_0 then
				arg_280_1.typewritter.percent = 1

				arg_280_1.typewritter:SetDirty()
				arg_280_1:ShowNextGo(true)
			end
		end

		arg_280_1.nodeConfigList_ = {}

		arg_280_1:InitPlayNodeList()
	end,
	Play221031066 = function(arg_284_0, arg_284_1)
		arg_284_1.time_ = 0
		arg_284_1.frameCnt_ = 0
		arg_284_1.state_ = "playing"
		arg_284_1.curTalkId_ = 221031066
		arg_284_1.duration_ = 7.03

		local var_284_0 = {
			ja = 7.033,
			ko = 3,
			zh = 3
		}
		local var_284_1 = manager.audio:GetLocalizationFlag()

		if var_284_0[var_284_1] ~= nil then
			arg_284_1.duration_ = var_284_0[var_284_1]
		end

		SetActive(arg_284_1.tipsGo_, false)

		function arg_284_1.onSingleLineFinish_()
			arg_284_1.onSingleLineUpdate_ = nil
			arg_284_1.onSingleLineFinish_ = nil
			arg_284_1.state_ = "waiting"
		end

		function arg_284_1.playNext_(arg_286_0)
			if arg_286_0 == 1 then
				arg_284_0:Play221031067(arg_284_1)
			end
		end

		function arg_284_1.onSingleLineUpdate_(arg_287_0)
			if 0 < arg_284_1.time_ and arg_284_1.time_ <= 0 + arg_287_0 then
				arg_284_1.var_.moveOldPos1072ui_story = arg_284_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_287_0 = 0.001

			if 0 <= arg_284_1.time_ and arg_284_1.time_ < 0 + var_287_0 then
				arg_284_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_284_1.var_.moveOldPos1072ui_story, Vector3.New(0, -0.71, -6), (arg_284_1.time_ - 0) / var_287_0)
				arg_284_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_284_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_284_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_284_1.actors_["1072ui_story"].transform.position).z)
				arg_284_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_284_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_284_1.actors_["1072ui_story"].transform.localEulerAngles = arg_284_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_284_1.time_ >= 0 + var_287_0 and arg_284_1.time_ < 0 + var_287_0 + arg_287_0 then
				arg_284_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_284_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_284_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_284_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_284_1.actors_["1072ui_story"].transform.position).z)
				arg_284_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_284_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_284_1.actors_["1072ui_story"].transform.localEulerAngles = arg_284_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			local var_287_1 = arg_284_1.actors_["1072ui_story"]

			if 0 < arg_284_1.time_ and arg_284_1.time_ <= 0 + arg_287_0 and not isNil(var_287_1) and arg_284_1.var_.characterEffect1072ui_story == nil then
				arg_284_1.var_.characterEffect1072ui_story = var_287_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_287_2 = 0.200000002980232

			if 0 <= arg_284_1.time_ and arg_284_1.time_ < 0 + var_287_2 and not isNil(var_287_1) then
				if arg_284_1.var_.characterEffect1072ui_story and not isNil(var_287_1) then
					arg_284_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_284_1.time_ >= 0 + var_287_2 and arg_284_1.time_ < 0 + var_287_2 + arg_287_0 and not isNil(var_287_1) and arg_284_1.var_.characterEffect1072ui_story then
				arg_284_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			if 0 < arg_284_1.time_ and arg_284_1.time_ <= 0 + arg_287_0 then
				arg_284_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action1_1")
			end

			if 0 < arg_284_1.time_ and arg_284_1.time_ <= 0 + arg_287_0 then
				arg_284_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_287_4 = 0
			local var_287_5 = 0.35

			if 0 < arg_284_1.time_ and arg_284_1.time_ <= var_287_4 + arg_287_0 then
				arg_284_1.talkMaxDuration = 0
				arg_284_1.dialogCg_.alpha = 1

				arg_284_1.dialog_:SetActive(true)
				SetActive(arg_284_1.leftNameGo_, true)

				arg_284_1.leftNameTxt_.text = arg_284_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_284_1.leftNameTxt_.transform)

				arg_284_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_284_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_284_1:RecordName(arg_284_1.leftNameTxt_.text)
				SetActive(arg_284_1.iconTrs_.gameObject, false)
				arg_284_1.callingController_:SetSelectedState("normal")

				local var_287_6 = arg_284_1:GetWordFromCfg(221031066)
				local var_287_7 = arg_284_1:FormatText(var_287_6.content)

				arg_284_1.text_.text = var_287_7

				LuaForUtil.ClearLinePrefixSymbol(arg_284_1.text_)

				local var_287_9 = 14 <= 0 and var_287_5 or var_287_5 * (utf8.len(var_287_7) / 14)

				if (14 <= 0 and var_287_5 or var_287_5 * (utf8.len(var_287_7) / 14)) > 0 and var_287_5 < var_287_9 then
					arg_284_1.talkMaxDuration = var_287_9

					if var_287_9 + var_287_4 > arg_284_1.duration_ then
						arg_284_1.duration_ = var_287_9 + var_287_4
					end
				end

				arg_284_1.text_.text = var_287_7
				arg_284_1.typewritter.percent = 0

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221031", "221031066", "story_v_out_221031.awb") ~= 0 then
					local var_287_10 = manager.audio:GetVoiceLength("story_v_out_221031", "221031066", "story_v_out_221031.awb") / 1000

					if var_287_10 + var_287_4 > arg_284_1.duration_ then
						arg_284_1.duration_ = var_287_10 + var_287_4
					end

					if var_287_6.prefab_name ~= "" and arg_284_1.actors_[var_287_6.prefab_name] ~= nil then
						local var_287_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_284_1.actors_[var_287_6.prefab_name].transform, "story_v_out_221031", "221031066", "story_v_out_221031.awb")

						arg_284_1:RecordAudio("221031066", var_287_11)
						arg_284_1:RecordAudio("221031066", var_287_11)
					else
						arg_284_1:AudioAction("play", "voice", "story_v_out_221031", "221031066", "story_v_out_221031.awb")
					end

					arg_284_1:RecordHistoryTalkVoice("story_v_out_221031", "221031066", "story_v_out_221031.awb")
				end

				arg_284_1:RecordContent(arg_284_1.text_.text)
			end

			local var_287_12 = math.max(var_287_5, arg_284_1.talkMaxDuration)

			if var_287_4 <= arg_284_1.time_ and arg_284_1.time_ < var_287_4 + var_287_12 then
				arg_284_1.typewritter.percent = (arg_284_1.time_ - var_287_4) / var_287_12

				arg_284_1.typewritter:SetDirty()
			end

			if arg_284_1.time_ >= var_287_4 + var_287_12 and arg_284_1.time_ < var_287_4 + var_287_12 + arg_287_0 then
				arg_284_1.typewritter.percent = 1

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(true)
			end
		end

		arg_284_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_284_1:InitPlayNodeList()
	end,
	Play221031067 = function(arg_288_0, arg_288_1)
		arg_288_1.time_ = 0
		arg_288_1.frameCnt_ = 0
		arg_288_1.state_ = "playing"
		arg_288_1.curTalkId_ = 221031067
		arg_288_1.duration_ = 5

		SetActive(arg_288_1.tipsGo_, false)

		function arg_288_1.onSingleLineFinish_()
			arg_288_1.onSingleLineUpdate_ = nil
			arg_288_1.onSingleLineFinish_ = nil
			arg_288_1.state_ = "waiting"
		end

		function arg_288_1.playNext_(arg_290_0)
			if arg_290_0 == 1 then
				arg_288_0:Play221031068(arg_288_1)
			end
		end

		function arg_288_1.onSingleLineUpdate_(arg_291_0)
			if 0 < arg_288_1.time_ and arg_288_1.time_ <= 0 + arg_291_0 and not isNil(arg_288_1.actors_["1072ui_story"]) and arg_288_1.var_.characterEffect1072ui_story == nil then
				arg_288_1.var_.characterEffect1072ui_story = arg_288_1.actors_["1072ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_291_0 = 0.200000002980232

			if 0 <= arg_288_1.time_ and arg_288_1.time_ < 0 + var_291_0 and not isNil(arg_288_1.actors_["1072ui_story"]) then
				if arg_288_1.var_.characterEffect1072ui_story and not isNil(arg_288_1.actors_["1072ui_story"]) then
					arg_288_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_288_1.var_.characterEffect1072ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_288_1.time_ - 0) / var_291_0)
				end
			end

			if arg_288_1.time_ >= 0 + var_291_0 and arg_288_1.time_ < 0 + var_291_0 + arg_291_0 and not isNil(arg_288_1.actors_["1072ui_story"]) and arg_288_1.var_.characterEffect1072ui_story then
				arg_288_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_288_1.var_.characterEffect1072ui_story.fillRatio = 0.5
			end

			local var_291_1 = 0
			local var_291_2 = 0.275

			if 0 < arg_288_1.time_ and arg_288_1.time_ <= var_291_1 + arg_291_0 then
				arg_288_1.talkMaxDuration = 0
				arg_288_1.dialogCg_.alpha = 1

				arg_288_1.dialog_:SetActive(true)
				SetActive(arg_288_1.leftNameGo_, false)

				arg_288_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_288_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_288_1:RecordName(arg_288_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_288_1.iconTrs_.gameObject, false)
				arg_288_1.callingController_:SetSelectedState("normal")

				local var_291_3 = arg_288_1:FormatText(arg_288_1:GetWordFromCfg(221031067).content)

				arg_288_1.text_.text = var_291_3

				LuaForUtil.ClearLinePrefixSymbol(arg_288_1.text_)

				local var_291_5 = 11 <= 0 and var_291_2 or var_291_2 * (utf8.len(var_291_3) / 11)

				if (11 <= 0 and var_291_2 or var_291_2 * (utf8.len(var_291_3) / 11)) > 0 and var_291_2 < var_291_5 then
					arg_288_1.talkMaxDuration = var_291_5

					if var_291_5 + var_291_1 > arg_288_1.duration_ then
						arg_288_1.duration_ = var_291_5 + var_291_1
					end
				end

				arg_288_1.text_.text = var_291_3
				arg_288_1.typewritter.percent = 0

				arg_288_1.typewritter:SetDirty()
				arg_288_1:ShowNextGo(false)
				arg_288_1:RecordContent(arg_288_1.text_.text)
			end

			local var_291_6 = math.max(var_291_2, arg_288_1.talkMaxDuration)

			if var_291_1 <= arg_288_1.time_ and arg_288_1.time_ < var_291_1 + var_291_6 then
				arg_288_1.typewritter.percent = (arg_288_1.time_ - var_291_1) / var_291_6

				arg_288_1.typewritter:SetDirty()
			end

			if arg_288_1.time_ >= var_291_1 + var_291_6 and arg_288_1.time_ < var_291_1 + var_291_6 + arg_291_0 then
				arg_288_1.typewritter.percent = 1

				arg_288_1.typewritter:SetDirty()
				arg_288_1:ShowNextGo(true)
			end
		end

		arg_288_1.nodeConfigList_ = {}

		arg_288_1:InitPlayNodeList()
	end,
	Play221031068 = function(arg_292_0, arg_292_1)
		arg_292_1.time_ = 0
		arg_292_1.frameCnt_ = 0
		arg_292_1.state_ = "playing"
		arg_292_1.curTalkId_ = 221031068
		arg_292_1.duration_ = 10.3

		local var_292_0 = {
			ja = 10.3,
			ko = 10.266,
			zh = 10.266
		}
		local var_292_1 = manager.audio:GetLocalizationFlag()

		if var_292_0[var_292_1] ~= nil then
			arg_292_1.duration_ = var_292_0[var_292_1]
		end

		SetActive(arg_292_1.tipsGo_, false)

		function arg_292_1.onSingleLineFinish_()
			arg_292_1.onSingleLineUpdate_ = nil
			arg_292_1.onSingleLineFinish_ = nil
			arg_292_1.state_ = "waiting"
		end

		function arg_292_1.playNext_(arg_294_0)
			if arg_294_0 == 1 then
				arg_292_0:Play221031069(arg_292_1)
			end
		end

		function arg_292_1.onSingleLineUpdate_(arg_295_0)
			local var_295_0 = 0.975

			if 0 < arg_292_1.time_ and arg_292_1.time_ <= 0 + arg_295_0 then
				arg_292_1.talkMaxDuration = 0
				arg_292_1.dialogCg_.alpha = 1

				arg_292_1.dialog_:SetActive(true)
				SetActive(arg_292_1.leftNameGo_, true)

				arg_292_1.leftNameTxt_.text = arg_292_1:FormatText(StoryNameCfg[422].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_292_1.leftNameTxt_.transform)

				arg_292_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_292_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_292_1:RecordName(arg_292_1.leftNameTxt_.text)
				SetActive(arg_292_1.iconTrs_.gameObject, true)
				arg_292_1.iconController_:SetSelectedState("hero")

				arg_292_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_292_1.callingController_:SetSelectedState("normal")

				arg_292_1.keyicon_.color = Color.New(1, 1, 1)
				arg_292_1.icon_.color = Color.New(1, 1, 1)

				local var_295_1 = arg_292_1:GetWordFromCfg(221031068)
				local var_295_2 = arg_292_1:FormatText(var_295_1.content)

				arg_292_1.text_.text = var_295_2

				LuaForUtil.ClearLinePrefixSymbol(arg_292_1.text_)

				local var_295_4 = 39 <= 0 and var_295_0 or var_295_0 * (utf8.len(var_295_2) / 39)

				if (39 <= 0 and var_295_0 or var_295_0 * (utf8.len(var_295_2) / 39)) > 0 and var_295_0 < var_295_4 then
					arg_292_1.talkMaxDuration = var_295_4

					if var_295_4 + 0 > arg_292_1.duration_ then
						arg_292_1.duration_ = var_295_4 + 0
					end
				end

				arg_292_1.text_.text = var_295_2
				arg_292_1.typewritter.percent = 0

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221031", "221031068", "story_v_out_221031.awb") ~= 0 then
					local var_295_5 = manager.audio:GetVoiceLength("story_v_out_221031", "221031068", "story_v_out_221031.awb") / 1000

					if var_295_5 + 0 > arg_292_1.duration_ then
						arg_292_1.duration_ = var_295_5 + 0
					end

					if var_295_1.prefab_name ~= "" and arg_292_1.actors_[var_295_1.prefab_name] ~= nil then
						local var_295_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_292_1.actors_[var_295_1.prefab_name].transform, "story_v_out_221031", "221031068", "story_v_out_221031.awb")

						arg_292_1:RecordAudio("221031068", var_295_6)
						arg_292_1:RecordAudio("221031068", var_295_6)
					else
						arg_292_1:AudioAction("play", "voice", "story_v_out_221031", "221031068", "story_v_out_221031.awb")
					end

					arg_292_1:RecordHistoryTalkVoice("story_v_out_221031", "221031068", "story_v_out_221031.awb")
				end

				arg_292_1:RecordContent(arg_292_1.text_.text)
			end

			local var_295_7 = math.max(var_295_0, arg_292_1.talkMaxDuration)

			if 0 <= arg_292_1.time_ and arg_292_1.time_ < 0 + var_295_7 then
				arg_292_1.typewritter.percent = (arg_292_1.time_ - 0) / var_295_7

				arg_292_1.typewritter:SetDirty()
			end

			if arg_292_1.time_ >= 0 + var_295_7 and arg_292_1.time_ < 0 + var_295_7 + arg_295_0 then
				arg_292_1.typewritter.percent = 1

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(true)
			end
		end

		arg_292_1.nodeConfigList_ = {}

		arg_292_1:InitPlayNodeList()
	end,
	Play221031069 = function(arg_296_0, arg_296_1)
		arg_296_1.time_ = 0
		arg_296_1.frameCnt_ = 0
		arg_296_1.state_ = "playing"
		arg_296_1.curTalkId_ = 221031069
		arg_296_1.duration_ = 2

		SetActive(arg_296_1.tipsGo_, false)

		function arg_296_1.onSingleLineFinish_()
			arg_296_1.onSingleLineUpdate_ = nil
			arg_296_1.onSingleLineFinish_ = nil
			arg_296_1.state_ = "waiting"
		end

		function arg_296_1.playNext_(arg_298_0)
			if arg_298_0 == 1 then
				arg_296_0:Play221031070(arg_296_1)
			end
		end

		function arg_296_1.onSingleLineUpdate_(arg_299_0)
			if 0 < arg_296_1.time_ and arg_296_1.time_ <= 0 + arg_299_0 then
				arg_296_1.var_.moveOldPos1072ui_story = arg_296_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_299_0 = 0.001

			if 0 <= arg_296_1.time_ and arg_296_1.time_ < 0 + var_299_0 then
				arg_296_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_296_1.var_.moveOldPos1072ui_story, Vector3.New(0, -0.71, -6), (arg_296_1.time_ - 0) / var_299_0)
				arg_296_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_296_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_296_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_296_1.actors_["1072ui_story"].transform.position).z)
				arg_296_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_296_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_296_1.actors_["1072ui_story"].transform.localEulerAngles = arg_296_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_296_1.time_ >= 0 + var_299_0 and arg_296_1.time_ < 0 + var_299_0 + arg_299_0 then
				arg_296_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_296_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_296_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_296_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_296_1.actors_["1072ui_story"].transform.position).z)
				arg_296_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_296_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_296_1.actors_["1072ui_story"].transform.localEulerAngles = arg_296_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			local var_299_1 = arg_296_1.actors_["1072ui_story"]

			if 0 < arg_296_1.time_ and arg_296_1.time_ <= 0 + arg_299_0 and not isNil(var_299_1) and arg_296_1.var_.characterEffect1072ui_story == nil then
				arg_296_1.var_.characterEffect1072ui_story = var_299_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_299_2 = 0.200000002980232

			if 0 <= arg_296_1.time_ and arg_296_1.time_ < 0 + var_299_2 and not isNil(var_299_1) then
				if arg_296_1.var_.characterEffect1072ui_story and not isNil(var_299_1) then
					arg_296_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_296_1.time_ >= 0 + var_299_2 and arg_296_1.time_ < 0 + var_299_2 + arg_299_0 and not isNil(var_299_1) and arg_296_1.var_.characterEffect1072ui_story then
				arg_296_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			if 0 < arg_296_1.time_ and arg_296_1.time_ <= 0 + arg_299_0 then
				arg_296_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action1_1")
			end

			if 0 < arg_296_1.time_ and arg_296_1.time_ <= 0 + arg_299_0 then
				arg_296_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_299_4 = 0
			local var_299_5 = 0.125

			if 0 < arg_296_1.time_ and arg_296_1.time_ <= var_299_4 + arg_299_0 then
				arg_296_1.talkMaxDuration = 0
				arg_296_1.dialogCg_.alpha = 1

				arg_296_1.dialog_:SetActive(true)
				SetActive(arg_296_1.leftNameGo_, true)

				arg_296_1.leftNameTxt_.text = arg_296_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_296_1.leftNameTxt_.transform)

				arg_296_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_296_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_296_1:RecordName(arg_296_1.leftNameTxt_.text)
				SetActive(arg_296_1.iconTrs_.gameObject, false)
				arg_296_1.callingController_:SetSelectedState("normal")

				local var_299_6 = arg_296_1:GetWordFromCfg(221031069)
				local var_299_7 = arg_296_1:FormatText(var_299_6.content)

				arg_296_1.text_.text = var_299_7

				LuaForUtil.ClearLinePrefixSymbol(arg_296_1.text_)

				local var_299_9 = 5 <= 0 and var_299_5 or var_299_5 * (utf8.len(var_299_7) / 5)

				if (5 <= 0 and var_299_5 or var_299_5 * (utf8.len(var_299_7) / 5)) > 0 and var_299_5 < var_299_9 then
					arg_296_1.talkMaxDuration = var_299_9

					if var_299_9 + var_299_4 > arg_296_1.duration_ then
						arg_296_1.duration_ = var_299_9 + var_299_4
					end
				end

				arg_296_1.text_.text = var_299_7
				arg_296_1.typewritter.percent = 0

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221031", "221031069", "story_v_out_221031.awb") ~= 0 then
					local var_299_10 = manager.audio:GetVoiceLength("story_v_out_221031", "221031069", "story_v_out_221031.awb") / 1000

					if var_299_10 + var_299_4 > arg_296_1.duration_ then
						arg_296_1.duration_ = var_299_10 + var_299_4
					end

					if var_299_6.prefab_name ~= "" and arg_296_1.actors_[var_299_6.prefab_name] ~= nil then
						local var_299_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_296_1.actors_[var_299_6.prefab_name].transform, "story_v_out_221031", "221031069", "story_v_out_221031.awb")

						arg_296_1:RecordAudio("221031069", var_299_11)
						arg_296_1:RecordAudio("221031069", var_299_11)
					else
						arg_296_1:AudioAction("play", "voice", "story_v_out_221031", "221031069", "story_v_out_221031.awb")
					end

					arg_296_1:RecordHistoryTalkVoice("story_v_out_221031", "221031069", "story_v_out_221031.awb")
				end

				arg_296_1:RecordContent(arg_296_1.text_.text)
			end

			local var_299_12 = math.max(var_299_5, arg_296_1.talkMaxDuration)

			if var_299_4 <= arg_296_1.time_ and arg_296_1.time_ < var_299_4 + var_299_12 then
				arg_296_1.typewritter.percent = (arg_296_1.time_ - var_299_4) / var_299_12

				arg_296_1.typewritter:SetDirty()
			end

			if arg_296_1.time_ >= var_299_4 + var_299_12 and arg_296_1.time_ < var_299_4 + var_299_12 + arg_299_0 then
				arg_296_1.typewritter.percent = 1

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(true)
			end
		end

		arg_296_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_296_1:InitPlayNodeList()
	end,
	Play221031070 = function(arg_300_0, arg_300_1)
		arg_300_1.time_ = 0
		arg_300_1.frameCnt_ = 0
		arg_300_1.state_ = "playing"
		arg_300_1.curTalkId_ = 221031070
		arg_300_1.duration_ = 1.93

		local var_300_0 = {
			ja = 1.933,
			ko = 1.9,
			zh = 1.9
		}
		local var_300_1 = manager.audio:GetLocalizationFlag()

		if var_300_0[var_300_1] ~= nil then
			arg_300_1.duration_ = var_300_0[var_300_1]
		end

		SetActive(arg_300_1.tipsGo_, false)

		function arg_300_1.onSingleLineFinish_()
			arg_300_1.onSingleLineUpdate_ = nil
			arg_300_1.onSingleLineFinish_ = nil
			arg_300_1.state_ = "waiting"
		end

		function arg_300_1.playNext_(arg_302_0)
			if arg_302_0 == 1 then
				arg_300_0:Play221031071(arg_300_1)
			end
		end

		function arg_300_1.onSingleLineUpdate_(arg_303_0)
			if 0 < arg_300_1.time_ and arg_300_1.time_ <= 0 + arg_303_0 and not isNil(arg_300_1.actors_["1072ui_story"]) and arg_300_1.var_.characterEffect1072ui_story == nil then
				arg_300_1.var_.characterEffect1072ui_story = arg_300_1.actors_["1072ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_303_0 = 0.200000002980232

			if 0 <= arg_300_1.time_ and arg_300_1.time_ < 0 + var_303_0 and not isNil(arg_300_1.actors_["1072ui_story"]) then
				if arg_300_1.var_.characterEffect1072ui_story and not isNil(arg_300_1.actors_["1072ui_story"]) then
					arg_300_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_300_1.var_.characterEffect1072ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_300_1.time_ - 0) / var_303_0)
				end
			end

			if arg_300_1.time_ >= 0 + var_303_0 and arg_300_1.time_ < 0 + var_303_0 + arg_303_0 and not isNil(arg_300_1.actors_["1072ui_story"]) and arg_300_1.var_.characterEffect1072ui_story then
				arg_300_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_300_1.var_.characterEffect1072ui_story.fillRatio = 0.5
			end

			local var_303_1 = 0
			local var_303_2 = 0.275

			if 0 < arg_300_1.time_ and arg_300_1.time_ <= var_303_1 + arg_303_0 then
				arg_300_1.talkMaxDuration = 0
				arg_300_1.dialogCg_.alpha = 1

				arg_300_1.dialog_:SetActive(true)
				SetActive(arg_300_1.leftNameGo_, true)

				arg_300_1.leftNameTxt_.text = arg_300_1:FormatText(StoryNameCfg[422].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_300_1.leftNameTxt_.transform)

				arg_300_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_300_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_300_1:RecordName(arg_300_1.leftNameTxt_.text)
				SetActive(arg_300_1.iconTrs_.gameObject, true)
				arg_300_1.iconController_:SetSelectedState("hero")

				arg_300_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_300_1.callingController_:SetSelectedState("normal")

				arg_300_1.keyicon_.color = Color.New(1, 1, 1)
				arg_300_1.icon_.color = Color.New(1, 1, 1)

				local var_303_3 = arg_300_1:GetWordFromCfg(221031070)
				local var_303_4 = arg_300_1:FormatText(var_303_3.content)

				arg_300_1.text_.text = var_303_4

				LuaForUtil.ClearLinePrefixSymbol(arg_300_1.text_)

				local var_303_6 = 11 <= 0 and var_303_2 or var_303_2 * (utf8.len(var_303_4) / 11)

				if (11 <= 0 and var_303_2 or var_303_2 * (utf8.len(var_303_4) / 11)) > 0 and var_303_2 < var_303_6 then
					arg_300_1.talkMaxDuration = var_303_6

					if var_303_6 + var_303_1 > arg_300_1.duration_ then
						arg_300_1.duration_ = var_303_6 + var_303_1
					end
				end

				arg_300_1.text_.text = var_303_4
				arg_300_1.typewritter.percent = 0

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221031", "221031070", "story_v_out_221031.awb") ~= 0 then
					local var_303_7 = manager.audio:GetVoiceLength("story_v_out_221031", "221031070", "story_v_out_221031.awb") / 1000

					if var_303_7 + var_303_1 > arg_300_1.duration_ then
						arg_300_1.duration_ = var_303_7 + var_303_1
					end

					if var_303_3.prefab_name ~= "" and arg_300_1.actors_[var_303_3.prefab_name] ~= nil then
						local var_303_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_300_1.actors_[var_303_3.prefab_name].transform, "story_v_out_221031", "221031070", "story_v_out_221031.awb")

						arg_300_1:RecordAudio("221031070", var_303_8)
						arg_300_1:RecordAudio("221031070", var_303_8)
					else
						arg_300_1:AudioAction("play", "voice", "story_v_out_221031", "221031070", "story_v_out_221031.awb")
					end

					arg_300_1:RecordHistoryTalkVoice("story_v_out_221031", "221031070", "story_v_out_221031.awb")
				end

				arg_300_1:RecordContent(arg_300_1.text_.text)
			end

			local var_303_9 = math.max(var_303_2, arg_300_1.talkMaxDuration)

			if var_303_1 <= arg_300_1.time_ and arg_300_1.time_ < var_303_1 + var_303_9 then
				arg_300_1.typewritter.percent = (arg_300_1.time_ - var_303_1) / var_303_9

				arg_300_1.typewritter:SetDirty()
			end

			if arg_300_1.time_ >= var_303_1 + var_303_9 and arg_300_1.time_ < var_303_1 + var_303_9 + arg_303_0 then
				arg_300_1.typewritter.percent = 1

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(true)
			end
		end

		arg_300_1.nodeConfigList_ = {}

		arg_300_1:InitPlayNodeList()
	end,
	Play221031071 = function(arg_304_0, arg_304_1)
		arg_304_1.time_ = 0
		arg_304_1.frameCnt_ = 0
		arg_304_1.state_ = "playing"
		arg_304_1.curTalkId_ = 221031071
		arg_304_1.duration_ = 8.93

		local var_304_0 = {
			ja = 8.933,
			ko = 7.833,
			zh = 7.833
		}
		local var_304_1 = manager.audio:GetLocalizationFlag()

		if var_304_0[var_304_1] ~= nil then
			arg_304_1.duration_ = var_304_0[var_304_1]
		end

		SetActive(arg_304_1.tipsGo_, false)

		function arg_304_1.onSingleLineFinish_()
			arg_304_1.onSingleLineUpdate_ = nil
			arg_304_1.onSingleLineFinish_ = nil
			arg_304_1.state_ = "waiting"
		end

		function arg_304_1.playNext_(arg_306_0)
			if arg_306_0 == 1 then
				arg_304_0:Play221031072(arg_304_1)
			end
		end

		function arg_304_1.onSingleLineUpdate_(arg_307_0)
			if 0 < arg_304_1.time_ and arg_304_1.time_ <= 0 + arg_307_0 then
				arg_304_1.var_.moveOldPos1072ui_story = arg_304_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_307_0 = 0.001

			if 0 <= arg_304_1.time_ and arg_304_1.time_ < 0 + var_307_0 then
				arg_304_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_304_1.var_.moveOldPos1072ui_story, Vector3.New(0, -0.71, -6), (arg_304_1.time_ - 0) / var_307_0)
				arg_304_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_304_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_304_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_304_1.actors_["1072ui_story"].transform.position).z)
				arg_304_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_304_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_304_1.actors_["1072ui_story"].transform.localEulerAngles = arg_304_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_304_1.time_ >= 0 + var_307_0 and arg_304_1.time_ < 0 + var_307_0 + arg_307_0 then
				arg_304_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_304_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_304_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_304_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_304_1.actors_["1072ui_story"].transform.position).z)
				arg_304_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_304_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_304_1.actors_["1072ui_story"].transform.localEulerAngles = arg_304_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			local var_307_1 = arg_304_1.actors_["1072ui_story"]

			if 0 < arg_304_1.time_ and arg_304_1.time_ <= 0 + arg_307_0 and not isNil(var_307_1) and arg_304_1.var_.characterEffect1072ui_story == nil then
				arg_304_1.var_.characterEffect1072ui_story = var_307_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_307_2 = 0.200000002980232

			if 0 <= arg_304_1.time_ and arg_304_1.time_ < 0 + var_307_2 and not isNil(var_307_1) then
				if arg_304_1.var_.characterEffect1072ui_story and not isNil(var_307_1) then
					arg_304_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_304_1.time_ >= 0 + var_307_2 and arg_304_1.time_ < 0 + var_307_2 + arg_307_0 and not isNil(var_307_1) and arg_304_1.var_.characterEffect1072ui_story then
				arg_304_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			if 0 < arg_304_1.time_ and arg_304_1.time_ <= 0 + arg_307_0 then
				arg_304_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action6_1")
			end

			if 0 < arg_304_1.time_ and arg_304_1.time_ <= 0 + arg_307_0 then
				arg_304_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_307_4 = 0
			local var_307_5 = 0.925

			if 0 < arg_304_1.time_ and arg_304_1.time_ <= var_307_4 + arg_307_0 then
				arg_304_1.talkMaxDuration = 0
				arg_304_1.dialogCg_.alpha = 1

				arg_304_1.dialog_:SetActive(true)
				SetActive(arg_304_1.leftNameGo_, true)

				arg_304_1.leftNameTxt_.text = arg_304_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_304_1.leftNameTxt_.transform)

				arg_304_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_304_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_304_1:RecordName(arg_304_1.leftNameTxt_.text)
				SetActive(arg_304_1.iconTrs_.gameObject, false)
				arg_304_1.callingController_:SetSelectedState("normal")

				local var_307_6 = arg_304_1:GetWordFromCfg(221031071)
				local var_307_7 = arg_304_1:FormatText(var_307_6.content)

				arg_304_1.text_.text = var_307_7

				LuaForUtil.ClearLinePrefixSymbol(arg_304_1.text_)

				local var_307_9 = 37 <= 0 and var_307_5 or var_307_5 * (utf8.len(var_307_7) / 37)

				if (37 <= 0 and var_307_5 or var_307_5 * (utf8.len(var_307_7) / 37)) > 0 and var_307_5 < var_307_9 then
					arg_304_1.talkMaxDuration = var_307_9

					if var_307_9 + var_307_4 > arg_304_1.duration_ then
						arg_304_1.duration_ = var_307_9 + var_307_4
					end
				end

				arg_304_1.text_.text = var_307_7
				arg_304_1.typewritter.percent = 0

				arg_304_1.typewritter:SetDirty()
				arg_304_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221031", "221031071", "story_v_out_221031.awb") ~= 0 then
					local var_307_10 = manager.audio:GetVoiceLength("story_v_out_221031", "221031071", "story_v_out_221031.awb") / 1000

					if var_307_10 + var_307_4 > arg_304_1.duration_ then
						arg_304_1.duration_ = var_307_10 + var_307_4
					end

					if var_307_6.prefab_name ~= "" and arg_304_1.actors_[var_307_6.prefab_name] ~= nil then
						local var_307_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_304_1.actors_[var_307_6.prefab_name].transform, "story_v_out_221031", "221031071", "story_v_out_221031.awb")

						arg_304_1:RecordAudio("221031071", var_307_11)
						arg_304_1:RecordAudio("221031071", var_307_11)
					else
						arg_304_1:AudioAction("play", "voice", "story_v_out_221031", "221031071", "story_v_out_221031.awb")
					end

					arg_304_1:RecordHistoryTalkVoice("story_v_out_221031", "221031071", "story_v_out_221031.awb")
				end

				arg_304_1:RecordContent(arg_304_1.text_.text)
			end

			local var_307_12 = math.max(var_307_5, arg_304_1.talkMaxDuration)

			if var_307_4 <= arg_304_1.time_ and arg_304_1.time_ < var_307_4 + var_307_12 then
				arg_304_1.typewritter.percent = (arg_304_1.time_ - var_307_4) / var_307_12

				arg_304_1.typewritter:SetDirty()
			end

			if arg_304_1.time_ >= var_307_4 + var_307_12 and arg_304_1.time_ < var_307_4 + var_307_12 + arg_307_0 then
				arg_304_1.typewritter.percent = 1

				arg_304_1.typewritter:SetDirty()
				arg_304_1:ShowNextGo(true)
			end
		end

		arg_304_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_304_1:InitPlayNodeList()
	end,
	Play221031072 = function(arg_308_0, arg_308_1)
		arg_308_1.time_ = 0
		arg_308_1.frameCnt_ = 0
		arg_308_1.state_ = "playing"
		arg_308_1.curTalkId_ = 221031072
		arg_308_1.duration_ = 7.6

		local var_308_0 = {
			ja = 7.6,
			ko = 6.4,
			zh = 6.4
		}
		local var_308_1 = manager.audio:GetLocalizationFlag()

		if var_308_0[var_308_1] ~= nil then
			arg_308_1.duration_ = var_308_0[var_308_1]
		end

		SetActive(arg_308_1.tipsGo_, false)

		function arg_308_1.onSingleLineFinish_()
			arg_308_1.onSingleLineUpdate_ = nil
			arg_308_1.onSingleLineFinish_ = nil
			arg_308_1.state_ = "waiting"
		end

		function arg_308_1.playNext_(arg_310_0)
			if arg_310_0 == 1 then
				arg_308_0:Play221031073(arg_308_1)
			end
		end

		function arg_308_1.onSingleLineUpdate_(arg_311_0)
			if 0 < arg_308_1.time_ and arg_308_1.time_ <= 0 + arg_311_0 then
				arg_308_1.var_.moveOldPos1072ui_story = arg_308_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_311_0 = 0.001

			if 0 <= arg_308_1.time_ and arg_308_1.time_ < 0 + var_311_0 then
				arg_308_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_308_1.var_.moveOldPos1072ui_story, Vector3.New(0, -0.71, -6), (arg_308_1.time_ - 0) / var_311_0)
				arg_308_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_308_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_308_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_308_1.actors_["1072ui_story"].transform.position).z)
				arg_308_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_308_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_308_1.actors_["1072ui_story"].transform.localEulerAngles = arg_308_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_308_1.time_ >= 0 + var_311_0 and arg_308_1.time_ < 0 + var_311_0 + arg_311_0 then
				arg_308_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_308_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_308_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_308_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_308_1.actors_["1072ui_story"].transform.position).z)
				arg_308_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_308_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_308_1.actors_["1072ui_story"].transform.localEulerAngles = arg_308_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if 0 < arg_308_1.time_ and arg_308_1.time_ <= 0 + arg_311_0 then
				arg_308_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0202cva")
			end

			local var_311_1 = 0
			local var_311_2 = 0.675

			if 0 < arg_308_1.time_ and arg_308_1.time_ <= var_311_1 + arg_311_0 then
				arg_308_1.talkMaxDuration = 0
				arg_308_1.dialogCg_.alpha = 1

				arg_308_1.dialog_:SetActive(true)
				SetActive(arg_308_1.leftNameGo_, true)

				arg_308_1.leftNameTxt_.text = arg_308_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_308_1.leftNameTxt_.transform)

				arg_308_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_308_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_308_1:RecordName(arg_308_1.leftNameTxt_.text)
				SetActive(arg_308_1.iconTrs_.gameObject, false)
				arg_308_1.callingController_:SetSelectedState("normal")

				local var_311_3 = arg_308_1:GetWordFromCfg(221031072)
				local var_311_4 = arg_308_1:FormatText(var_311_3.content)

				arg_308_1.text_.text = var_311_4

				LuaForUtil.ClearLinePrefixSymbol(arg_308_1.text_)

				local var_311_6 = 27 <= 0 and var_311_2 or var_311_2 * (utf8.len(var_311_4) / 27)

				if (27 <= 0 and var_311_2 or var_311_2 * (utf8.len(var_311_4) / 27)) > 0 and var_311_2 < var_311_6 then
					arg_308_1.talkMaxDuration = var_311_6

					if var_311_6 + var_311_1 > arg_308_1.duration_ then
						arg_308_1.duration_ = var_311_6 + var_311_1
					end
				end

				arg_308_1.text_.text = var_311_4
				arg_308_1.typewritter.percent = 0

				arg_308_1.typewritter:SetDirty()
				arg_308_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221031", "221031072", "story_v_out_221031.awb") ~= 0 then
					local var_311_7 = manager.audio:GetVoiceLength("story_v_out_221031", "221031072", "story_v_out_221031.awb") / 1000

					if var_311_7 + var_311_1 > arg_308_1.duration_ then
						arg_308_1.duration_ = var_311_7 + var_311_1
					end

					if var_311_3.prefab_name ~= "" and arg_308_1.actors_[var_311_3.prefab_name] ~= nil then
						local var_311_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_308_1.actors_[var_311_3.prefab_name].transform, "story_v_out_221031", "221031072", "story_v_out_221031.awb")

						arg_308_1:RecordAudio("221031072", var_311_8)
						arg_308_1:RecordAudio("221031072", var_311_8)
					else
						arg_308_1:AudioAction("play", "voice", "story_v_out_221031", "221031072", "story_v_out_221031.awb")
					end

					arg_308_1:RecordHistoryTalkVoice("story_v_out_221031", "221031072", "story_v_out_221031.awb")
				end

				arg_308_1:RecordContent(arg_308_1.text_.text)
			end

			local var_311_9 = math.max(var_311_2, arg_308_1.talkMaxDuration)

			if var_311_1 <= arg_308_1.time_ and arg_308_1.time_ < var_311_1 + var_311_9 then
				arg_308_1.typewritter.percent = (arg_308_1.time_ - var_311_1) / var_311_9

				arg_308_1.typewritter:SetDirty()
			end

			if arg_308_1.time_ >= var_311_1 + var_311_9 and arg_308_1.time_ < var_311_1 + var_311_9 + arg_311_0 then
				arg_308_1.typewritter.percent = 1

				arg_308_1.typewritter:SetDirty()
				arg_308_1:ShowNextGo(true)
			end
		end

		arg_308_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_308_1:InitPlayNodeList()
	end,
	Play221031073 = function(arg_312_0, arg_312_1)
		arg_312_1.time_ = 0
		arg_312_1.frameCnt_ = 0
		arg_312_1.state_ = "playing"
		arg_312_1.curTalkId_ = 221031073
		arg_312_1.duration_ = 1.9

		local var_312_0 = {
			ja = 1.9,
			ko = 1.1,
			zh = 1.1
		}
		local var_312_1 = manager.audio:GetLocalizationFlag()

		if var_312_0[var_312_1] ~= nil then
			arg_312_1.duration_ = var_312_0[var_312_1]
		end

		SetActive(arg_312_1.tipsGo_, false)

		function arg_312_1.onSingleLineFinish_()
			arg_312_1.onSingleLineUpdate_ = nil
			arg_312_1.onSingleLineFinish_ = nil
			arg_312_1.state_ = "waiting"
		end

		function arg_312_1.playNext_(arg_314_0)
			if arg_314_0 == 1 then
				arg_312_0:Play221031074(arg_312_1)
			end
		end

		function arg_312_1.onSingleLineUpdate_(arg_315_0)
			if 0 < arg_312_1.time_ and arg_312_1.time_ <= 0 + arg_315_0 and not isNil(arg_312_1.actors_["1072ui_story"]) and arg_312_1.var_.characterEffect1072ui_story == nil then
				arg_312_1.var_.characterEffect1072ui_story = arg_312_1.actors_["1072ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_315_0 = 0.200000002980232

			if 0 <= arg_312_1.time_ and arg_312_1.time_ < 0 + var_315_0 and not isNil(arg_312_1.actors_["1072ui_story"]) then
				if arg_312_1.var_.characterEffect1072ui_story and not isNil(arg_312_1.actors_["1072ui_story"]) then
					arg_312_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_312_1.var_.characterEffect1072ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_312_1.time_ - 0) / var_315_0)
				end
			end

			if arg_312_1.time_ >= 0 + var_315_0 and arg_312_1.time_ < 0 + var_315_0 + arg_315_0 and not isNil(arg_312_1.actors_["1072ui_story"]) and arg_312_1.var_.characterEffect1072ui_story then
				arg_312_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_312_1.var_.characterEffect1072ui_story.fillRatio = 0.5
			end

			local var_315_1 = 0
			local var_315_2 = 0.15

			if 0 < arg_312_1.time_ and arg_312_1.time_ <= var_315_1 + arg_315_0 then
				arg_312_1.talkMaxDuration = 0
				arg_312_1.dialogCg_.alpha = 1

				arg_312_1.dialog_:SetActive(true)
				SetActive(arg_312_1.leftNameGo_, true)

				arg_312_1.leftNameTxt_.text = arg_312_1:FormatText(StoryNameCfg[422].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_312_1.leftNameTxt_.transform)

				arg_312_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_312_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_312_1:RecordName(arg_312_1.leftNameTxt_.text)
				SetActive(arg_312_1.iconTrs_.gameObject, true)
				arg_312_1.iconController_:SetSelectedState("hero")

				arg_312_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_312_1.callingController_:SetSelectedState("normal")

				arg_312_1.keyicon_.color = Color.New(1, 1, 1)
				arg_312_1.icon_.color = Color.New(1, 1, 1)

				local var_315_3 = arg_312_1:GetWordFromCfg(221031073)
				local var_315_4 = arg_312_1:FormatText(var_315_3.content)

				arg_312_1.text_.text = var_315_4

				LuaForUtil.ClearLinePrefixSymbol(arg_312_1.text_)

				local var_315_6 = 6 <= 0 and var_315_2 or var_315_2 * (utf8.len(var_315_4) / 6)

				if (6 <= 0 and var_315_2 or var_315_2 * (utf8.len(var_315_4) / 6)) > 0 and var_315_2 < var_315_6 then
					arg_312_1.talkMaxDuration = var_315_6

					if var_315_6 + var_315_1 > arg_312_1.duration_ then
						arg_312_1.duration_ = var_315_6 + var_315_1
					end
				end

				arg_312_1.text_.text = var_315_4
				arg_312_1.typewritter.percent = 0

				arg_312_1.typewritter:SetDirty()
				arg_312_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221031", "221031073", "story_v_out_221031.awb") ~= 0 then
					local var_315_7 = manager.audio:GetVoiceLength("story_v_out_221031", "221031073", "story_v_out_221031.awb") / 1000

					if var_315_7 + var_315_1 > arg_312_1.duration_ then
						arg_312_1.duration_ = var_315_7 + var_315_1
					end

					if var_315_3.prefab_name ~= "" and arg_312_1.actors_[var_315_3.prefab_name] ~= nil then
						local var_315_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_312_1.actors_[var_315_3.prefab_name].transform, "story_v_out_221031", "221031073", "story_v_out_221031.awb")

						arg_312_1:RecordAudio("221031073", var_315_8)
						arg_312_1:RecordAudio("221031073", var_315_8)
					else
						arg_312_1:AudioAction("play", "voice", "story_v_out_221031", "221031073", "story_v_out_221031.awb")
					end

					arg_312_1:RecordHistoryTalkVoice("story_v_out_221031", "221031073", "story_v_out_221031.awb")
				end

				arg_312_1:RecordContent(arg_312_1.text_.text)
			end

			local var_315_9 = math.max(var_315_2, arg_312_1.talkMaxDuration)

			if var_315_1 <= arg_312_1.time_ and arg_312_1.time_ < var_315_1 + var_315_9 then
				arg_312_1.typewritter.percent = (arg_312_1.time_ - var_315_1) / var_315_9

				arg_312_1.typewritter:SetDirty()
			end

			if arg_312_1.time_ >= var_315_1 + var_315_9 and arg_312_1.time_ < var_315_1 + var_315_9 + arg_315_0 then
				arg_312_1.typewritter.percent = 1

				arg_312_1.typewritter:SetDirty()
				arg_312_1:ShowNextGo(true)
			end
		end

		arg_312_1.nodeConfigList_ = {}

		arg_312_1:InitPlayNodeList()
	end,
	Play221031074 = function(arg_316_0, arg_316_1)
		arg_316_1.time_ = 0
		arg_316_1.frameCnt_ = 0
		arg_316_1.state_ = "playing"
		arg_316_1.curTalkId_ = 221031074
		arg_316_1.duration_ = 14

		local var_316_0 = {
			ja = 14,
			ko = 10.933,
			zh = 10.933
		}
		local var_316_1 = manager.audio:GetLocalizationFlag()

		if var_316_0[var_316_1] ~= nil then
			arg_316_1.duration_ = var_316_0[var_316_1]
		end

		SetActive(arg_316_1.tipsGo_, false)

		function arg_316_1.onSingleLineFinish_()
			arg_316_1.onSingleLineUpdate_ = nil
			arg_316_1.onSingleLineFinish_ = nil
			arg_316_1.state_ = "waiting"
		end

		function arg_316_1.playNext_(arg_318_0)
			if arg_318_0 == 1 then
				arg_316_0:Play221031075(arg_316_1)
			end
		end

		function arg_316_1.onSingleLineUpdate_(arg_319_0)
			if 0 < arg_316_1.time_ and arg_316_1.time_ <= 0 + arg_319_0 then
				arg_316_1.var_.moveOldPos1072ui_story = arg_316_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_319_0 = 0.001

			if 0 <= arg_316_1.time_ and arg_316_1.time_ < 0 + var_319_0 then
				arg_316_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_316_1.var_.moveOldPos1072ui_story, Vector3.New(0, -0.71, -6), (arg_316_1.time_ - 0) / var_319_0)
				arg_316_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_316_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_316_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_316_1.actors_["1072ui_story"].transform.position).z)
				arg_316_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_316_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_316_1.actors_["1072ui_story"].transform.localEulerAngles = arg_316_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_316_1.time_ >= 0 + var_319_0 and arg_316_1.time_ < 0 + var_319_0 + arg_319_0 then
				arg_316_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_316_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_316_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_316_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_316_1.actors_["1072ui_story"].transform.position).z)
				arg_316_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_316_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_316_1.actors_["1072ui_story"].transform.localEulerAngles = arg_316_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			local var_319_1 = arg_316_1.actors_["1072ui_story"]

			if 0 < arg_316_1.time_ and arg_316_1.time_ <= 0 + arg_319_0 and not isNil(var_319_1) and arg_316_1.var_.characterEffect1072ui_story == nil then
				arg_316_1.var_.characterEffect1072ui_story = var_319_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_319_2 = 0.200000002980232

			if 0 <= arg_316_1.time_ and arg_316_1.time_ < 0 + var_319_2 and not isNil(var_319_1) then
				if arg_316_1.var_.characterEffect1072ui_story and not isNil(var_319_1) then
					arg_316_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_316_1.time_ >= 0 + var_319_2 and arg_316_1.time_ < 0 + var_319_2 + arg_319_0 and not isNil(var_319_1) and arg_316_1.var_.characterEffect1072ui_story then
				arg_316_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			if 0 < arg_316_1.time_ and arg_316_1.time_ <= 0 + arg_319_0 then
				arg_316_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072actionlink/1072action462")
			end

			if 0 < arg_316_1.time_ and arg_316_1.time_ <= 0 + arg_319_0 then
				arg_316_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_319_4 = 0
			local var_319_5 = 1.25

			if 0 < arg_316_1.time_ and arg_316_1.time_ <= var_319_4 + arg_319_0 then
				arg_316_1.talkMaxDuration = 0
				arg_316_1.dialogCg_.alpha = 1

				arg_316_1.dialog_:SetActive(true)
				SetActive(arg_316_1.leftNameGo_, true)

				arg_316_1.leftNameTxt_.text = arg_316_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_316_1.leftNameTxt_.transform)

				arg_316_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_316_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_316_1:RecordName(arg_316_1.leftNameTxt_.text)
				SetActive(arg_316_1.iconTrs_.gameObject, false)
				arg_316_1.callingController_:SetSelectedState("normal")

				local var_319_6 = arg_316_1:GetWordFromCfg(221031074)
				local var_319_7 = arg_316_1:FormatText(var_319_6.content)

				arg_316_1.text_.text = var_319_7

				LuaForUtil.ClearLinePrefixSymbol(arg_316_1.text_)

				local var_319_9 = 50 <= 0 and var_319_5 or var_319_5 * (utf8.len(var_319_7) / 50)

				if (50 <= 0 and var_319_5 or var_319_5 * (utf8.len(var_319_7) / 50)) > 0 and var_319_5 < var_319_9 then
					arg_316_1.talkMaxDuration = var_319_9

					if var_319_9 + var_319_4 > arg_316_1.duration_ then
						arg_316_1.duration_ = var_319_9 + var_319_4
					end
				end

				arg_316_1.text_.text = var_319_7
				arg_316_1.typewritter.percent = 0

				arg_316_1.typewritter:SetDirty()
				arg_316_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221031", "221031074", "story_v_out_221031.awb") ~= 0 then
					local var_319_10 = manager.audio:GetVoiceLength("story_v_out_221031", "221031074", "story_v_out_221031.awb") / 1000

					if var_319_10 + var_319_4 > arg_316_1.duration_ then
						arg_316_1.duration_ = var_319_10 + var_319_4
					end

					if var_319_6.prefab_name ~= "" and arg_316_1.actors_[var_319_6.prefab_name] ~= nil then
						local var_319_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_316_1.actors_[var_319_6.prefab_name].transform, "story_v_out_221031", "221031074", "story_v_out_221031.awb")

						arg_316_1:RecordAudio("221031074", var_319_11)
						arg_316_1:RecordAudio("221031074", var_319_11)
					else
						arg_316_1:AudioAction("play", "voice", "story_v_out_221031", "221031074", "story_v_out_221031.awb")
					end

					arg_316_1:RecordHistoryTalkVoice("story_v_out_221031", "221031074", "story_v_out_221031.awb")
				end

				arg_316_1:RecordContent(arg_316_1.text_.text)
			end

			local var_319_12 = math.max(var_319_5, arg_316_1.talkMaxDuration)

			if var_319_4 <= arg_316_1.time_ and arg_316_1.time_ < var_319_4 + var_319_12 then
				arg_316_1.typewritter.percent = (arg_316_1.time_ - var_319_4) / var_319_12

				arg_316_1.typewritter:SetDirty()
			end

			if arg_316_1.time_ >= var_319_4 + var_319_12 and arg_316_1.time_ < var_319_4 + var_319_12 + arg_319_0 then
				arg_316_1.typewritter.percent = 1

				arg_316_1.typewritter:SetDirty()
				arg_316_1:ShowNextGo(true)
			end
		end

		arg_316_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_316_1:InitPlayNodeList()
	end,
	Play221031075 = function(arg_320_0, arg_320_1)
		arg_320_1.time_ = 0
		arg_320_1.frameCnt_ = 0
		arg_320_1.state_ = "playing"
		arg_320_1.curTalkId_ = 221031075
		arg_320_1.duration_ = 1.9

		local var_320_0 = {
			ja = 1.1,
			ko = 1.9,
			zh = 1.9
		}
		local var_320_1 = manager.audio:GetLocalizationFlag()

		if var_320_0[var_320_1] ~= nil then
			arg_320_1.duration_ = var_320_0[var_320_1]
		end

		SetActive(arg_320_1.tipsGo_, false)

		function arg_320_1.onSingleLineFinish_()
			arg_320_1.onSingleLineUpdate_ = nil
			arg_320_1.onSingleLineFinish_ = nil
			arg_320_1.state_ = "waiting"
		end

		function arg_320_1.playNext_(arg_322_0)
			if arg_322_0 == 1 then
				arg_320_0:Play221031076(arg_320_1)
			end
		end

		function arg_320_1.onSingleLineUpdate_(arg_323_0)
			if 0 < arg_320_1.time_ and arg_320_1.time_ <= 0 + arg_323_0 and not isNil(arg_320_1.actors_["1072ui_story"]) and arg_320_1.var_.characterEffect1072ui_story == nil then
				arg_320_1.var_.characterEffect1072ui_story = arg_320_1.actors_["1072ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_323_0 = 0.200000002980232

			if 0 <= arg_320_1.time_ and arg_320_1.time_ < 0 + var_323_0 and not isNil(arg_320_1.actors_["1072ui_story"]) then
				if arg_320_1.var_.characterEffect1072ui_story and not isNil(arg_320_1.actors_["1072ui_story"]) then
					arg_320_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_320_1.var_.characterEffect1072ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_320_1.time_ - 0) / var_323_0)
				end
			end

			if arg_320_1.time_ >= 0 + var_323_0 and arg_320_1.time_ < 0 + var_323_0 + arg_323_0 and not isNil(arg_320_1.actors_["1072ui_story"]) and arg_320_1.var_.characterEffect1072ui_story then
				arg_320_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_320_1.var_.characterEffect1072ui_story.fillRatio = 0.5
			end

			local var_323_1 = 0
			local var_323_2 = 0.05

			if 0 < arg_320_1.time_ and arg_320_1.time_ <= var_323_1 + arg_323_0 then
				arg_320_1.talkMaxDuration = 0
				arg_320_1.dialogCg_.alpha = 1

				arg_320_1.dialog_:SetActive(true)
				SetActive(arg_320_1.leftNameGo_, true)

				arg_320_1.leftNameTxt_.text = arg_320_1:FormatText(StoryNameCfg[422].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_320_1.leftNameTxt_.transform)

				arg_320_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_320_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_320_1:RecordName(arg_320_1.leftNameTxt_.text)
				SetActive(arg_320_1.iconTrs_.gameObject, true)
				arg_320_1.iconController_:SetSelectedState("hero")

				arg_320_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_320_1.callingController_:SetSelectedState("normal")

				arg_320_1.keyicon_.color = Color.New(1, 1, 1)
				arg_320_1.icon_.color = Color.New(1, 1, 1)

				local var_323_3 = arg_320_1:GetWordFromCfg(221031075)
				local var_323_4 = arg_320_1:FormatText(var_323_3.content)

				arg_320_1.text_.text = var_323_4

				LuaForUtil.ClearLinePrefixSymbol(arg_320_1.text_)

				local var_323_6 = 2 <= 0 and var_323_2 or var_323_2 * (utf8.len(var_323_4) / 2)

				if (2 <= 0 and var_323_2 or var_323_2 * (utf8.len(var_323_4) / 2)) > 0 and var_323_2 < var_323_6 then
					arg_320_1.talkMaxDuration = var_323_6

					if var_323_6 + var_323_1 > arg_320_1.duration_ then
						arg_320_1.duration_ = var_323_6 + var_323_1
					end
				end

				arg_320_1.text_.text = var_323_4
				arg_320_1.typewritter.percent = 0

				arg_320_1.typewritter:SetDirty()
				arg_320_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221031", "221031075", "story_v_out_221031.awb") ~= 0 then
					local var_323_7 = manager.audio:GetVoiceLength("story_v_out_221031", "221031075", "story_v_out_221031.awb") / 1000

					if var_323_7 + var_323_1 > arg_320_1.duration_ then
						arg_320_1.duration_ = var_323_7 + var_323_1
					end

					if var_323_3.prefab_name ~= "" and arg_320_1.actors_[var_323_3.prefab_name] ~= nil then
						local var_323_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_320_1.actors_[var_323_3.prefab_name].transform, "story_v_out_221031", "221031075", "story_v_out_221031.awb")

						arg_320_1:RecordAudio("221031075", var_323_8)
						arg_320_1:RecordAudio("221031075", var_323_8)
					else
						arg_320_1:AudioAction("play", "voice", "story_v_out_221031", "221031075", "story_v_out_221031.awb")
					end

					arg_320_1:RecordHistoryTalkVoice("story_v_out_221031", "221031075", "story_v_out_221031.awb")
				end

				arg_320_1:RecordContent(arg_320_1.text_.text)
			end

			local var_323_9 = math.max(var_323_2, arg_320_1.talkMaxDuration)

			if var_323_1 <= arg_320_1.time_ and arg_320_1.time_ < var_323_1 + var_323_9 then
				arg_320_1.typewritter.percent = (arg_320_1.time_ - var_323_1) / var_323_9

				arg_320_1.typewritter:SetDirty()
			end

			if arg_320_1.time_ >= var_323_1 + var_323_9 and arg_320_1.time_ < var_323_1 + var_323_9 + arg_323_0 then
				arg_320_1.typewritter.percent = 1

				arg_320_1.typewritter:SetDirty()
				arg_320_1:ShowNextGo(true)
			end
		end

		arg_320_1.nodeConfigList_ = {}

		arg_320_1:InitPlayNodeList()
	end,
	Play221031076 = function(arg_324_0, arg_324_1)
		arg_324_1.time_ = 0
		arg_324_1.frameCnt_ = 0
		arg_324_1.state_ = "playing"
		arg_324_1.curTalkId_ = 221031076
		arg_324_1.duration_ = 14.3

		local var_324_0 = {
			ja = 12.8,
			ko = 14.3,
			zh = 14.3
		}
		local var_324_1 = manager.audio:GetLocalizationFlag()

		if var_324_0[var_324_1] ~= nil then
			arg_324_1.duration_ = var_324_0[var_324_1]
		end

		SetActive(arg_324_1.tipsGo_, false)

		function arg_324_1.onSingleLineFinish_()
			arg_324_1.onSingleLineUpdate_ = nil
			arg_324_1.onSingleLineFinish_ = nil
			arg_324_1.state_ = "waiting"
		end

		function arg_324_1.playNext_(arg_326_0)
			if arg_326_0 == 1 then
				arg_324_0:Play221031077(arg_324_1)
			end
		end

		function arg_324_1.onSingleLineUpdate_(arg_327_0)
			local var_327_0 = 1.025

			if 0 < arg_324_1.time_ and arg_324_1.time_ <= 0 + arg_327_0 then
				arg_324_1.talkMaxDuration = 0
				arg_324_1.dialogCg_.alpha = 1

				arg_324_1.dialog_:SetActive(true)
				SetActive(arg_324_1.leftNameGo_, true)

				arg_324_1.leftNameTxt_.text = arg_324_1:FormatText(StoryNameCfg[422].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_324_1.leftNameTxt_.transform)

				arg_324_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_324_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_324_1:RecordName(arg_324_1.leftNameTxt_.text)
				SetActive(arg_324_1.iconTrs_.gameObject, true)
				arg_324_1.iconController_:SetSelectedState("hero")

				arg_324_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_324_1.callingController_:SetSelectedState("normal")

				arg_324_1.keyicon_.color = Color.New(1, 1, 1)
				arg_324_1.icon_.color = Color.New(1, 1, 1)

				local var_327_1 = arg_324_1:GetWordFromCfg(221031076)
				local var_327_2 = arg_324_1:FormatText(var_327_1.content)

				arg_324_1.text_.text = var_327_2

				LuaForUtil.ClearLinePrefixSymbol(arg_324_1.text_)

				local var_327_4 = 41 <= 0 and var_327_0 or var_327_0 * (utf8.len(var_327_2) / 41)

				if (41 <= 0 and var_327_0 or var_327_0 * (utf8.len(var_327_2) / 41)) > 0 and var_327_0 < var_327_4 then
					arg_324_1.talkMaxDuration = var_327_4

					if var_327_4 + 0 > arg_324_1.duration_ then
						arg_324_1.duration_ = var_327_4 + 0
					end
				end

				arg_324_1.text_.text = var_327_2
				arg_324_1.typewritter.percent = 0

				arg_324_1.typewritter:SetDirty()
				arg_324_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221031", "221031076", "story_v_out_221031.awb") ~= 0 then
					local var_327_5 = manager.audio:GetVoiceLength("story_v_out_221031", "221031076", "story_v_out_221031.awb") / 1000

					if var_327_5 + 0 > arg_324_1.duration_ then
						arg_324_1.duration_ = var_327_5 + 0
					end

					if var_327_1.prefab_name ~= "" and arg_324_1.actors_[var_327_1.prefab_name] ~= nil then
						local var_327_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_324_1.actors_[var_327_1.prefab_name].transform, "story_v_out_221031", "221031076", "story_v_out_221031.awb")

						arg_324_1:RecordAudio("221031076", var_327_6)
						arg_324_1:RecordAudio("221031076", var_327_6)
					else
						arg_324_1:AudioAction("play", "voice", "story_v_out_221031", "221031076", "story_v_out_221031.awb")
					end

					arg_324_1:RecordHistoryTalkVoice("story_v_out_221031", "221031076", "story_v_out_221031.awb")
				end

				arg_324_1:RecordContent(arg_324_1.text_.text)
			end

			local var_327_7 = math.max(var_327_0, arg_324_1.talkMaxDuration)

			if 0 <= arg_324_1.time_ and arg_324_1.time_ < 0 + var_327_7 then
				arg_324_1.typewritter.percent = (arg_324_1.time_ - 0) / var_327_7

				arg_324_1.typewritter:SetDirty()
			end

			if arg_324_1.time_ >= 0 + var_327_7 and arg_324_1.time_ < 0 + var_327_7 + arg_327_0 then
				arg_324_1.typewritter.percent = 1

				arg_324_1.typewritter:SetDirty()
				arg_324_1:ShowNextGo(true)
			end
		end

		arg_324_1.nodeConfigList_ = {}

		arg_324_1:InitPlayNodeList()
	end,
	Play221031077 = function(arg_328_0, arg_328_1)
		arg_328_1.time_ = 0
		arg_328_1.frameCnt_ = 0
		arg_328_1.state_ = "playing"
		arg_328_1.curTalkId_ = 221031077
		arg_328_1.duration_ = 12.77

		local var_328_0 = {
			ja = 12.7,
			ko = 12.766,
			zh = 12.766
		}
		local var_328_1 = manager.audio:GetLocalizationFlag()

		if var_328_0[var_328_1] ~= nil then
			arg_328_1.duration_ = var_328_0[var_328_1]
		end

		SetActive(arg_328_1.tipsGo_, false)

		function arg_328_1.onSingleLineFinish_()
			arg_328_1.onSingleLineUpdate_ = nil
			arg_328_1.onSingleLineFinish_ = nil
			arg_328_1.state_ = "waiting"
		end

		function arg_328_1.playNext_(arg_330_0)
			if arg_330_0 == 1 then
				arg_328_0:Play221031078(arg_328_1)
			end
		end

		function arg_328_1.onSingleLineUpdate_(arg_331_0)
			if 0 < arg_328_1.time_ and arg_328_1.time_ <= 0 + arg_331_0 then
				arg_328_1.var_.moveOldPos1072ui_story = arg_328_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_331_0 = 0.001

			if 0 <= arg_328_1.time_ and arg_328_1.time_ < 0 + var_331_0 then
				arg_328_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_328_1.var_.moveOldPos1072ui_story, Vector3.New(0, -0.71, -6), (arg_328_1.time_ - 0) / var_331_0)
				arg_328_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_328_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_328_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_328_1.actors_["1072ui_story"].transform.position).z)
				arg_328_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_328_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_328_1.actors_["1072ui_story"].transform.localEulerAngles = arg_328_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_328_1.time_ >= 0 + var_331_0 and arg_328_1.time_ < 0 + var_331_0 + arg_331_0 then
				arg_328_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_328_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_328_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_328_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_328_1.actors_["1072ui_story"].transform.position).z)
				arg_328_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_328_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_328_1.actors_["1072ui_story"].transform.localEulerAngles = arg_328_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			local var_331_1 = arg_328_1.actors_["1072ui_story"]

			if 0 < arg_328_1.time_ and arg_328_1.time_ <= 0 + arg_331_0 and not isNil(var_331_1) and arg_328_1.var_.characterEffect1072ui_story == nil then
				arg_328_1.var_.characterEffect1072ui_story = var_331_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_331_2 = 0.200000002980232

			if 0 <= arg_328_1.time_ and arg_328_1.time_ < 0 + var_331_2 and not isNil(var_331_1) then
				if arg_328_1.var_.characterEffect1072ui_story and not isNil(var_331_1) then
					arg_328_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_328_1.time_ >= 0 + var_331_2 and arg_328_1.time_ < 0 + var_331_2 + arg_331_0 and not isNil(var_331_1) and arg_328_1.var_.characterEffect1072ui_story then
				arg_328_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			if 0 < arg_328_1.time_ and arg_328_1.time_ <= 0 + arg_331_0 then
				arg_328_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072actionlink/1072action427")
			end

			if 0 < arg_328_1.time_ and arg_328_1.time_ <= 0 + arg_331_0 then
				arg_328_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_331_4 = 0
			local var_331_5 = 1.175

			if 0 < arg_328_1.time_ and arg_328_1.time_ <= var_331_4 + arg_331_0 then
				arg_328_1.talkMaxDuration = 0
				arg_328_1.dialogCg_.alpha = 1

				arg_328_1.dialog_:SetActive(true)
				SetActive(arg_328_1.leftNameGo_, true)

				arg_328_1.leftNameTxt_.text = arg_328_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_328_1.leftNameTxt_.transform)

				arg_328_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_328_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_328_1:RecordName(arg_328_1.leftNameTxt_.text)
				SetActive(arg_328_1.iconTrs_.gameObject, false)
				arg_328_1.callingController_:SetSelectedState("normal")

				local var_331_6 = arg_328_1:GetWordFromCfg(221031077)
				local var_331_7 = arg_328_1:FormatText(var_331_6.content)

				arg_328_1.text_.text = var_331_7

				LuaForUtil.ClearLinePrefixSymbol(arg_328_1.text_)

				local var_331_9 = 47 <= 0 and var_331_5 or var_331_5 * (utf8.len(var_331_7) / 47)

				if (47 <= 0 and var_331_5 or var_331_5 * (utf8.len(var_331_7) / 47)) > 0 and var_331_5 < var_331_9 then
					arg_328_1.talkMaxDuration = var_331_9

					if var_331_9 + var_331_4 > arg_328_1.duration_ then
						arg_328_1.duration_ = var_331_9 + var_331_4
					end
				end

				arg_328_1.text_.text = var_331_7
				arg_328_1.typewritter.percent = 0

				arg_328_1.typewritter:SetDirty()
				arg_328_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221031", "221031077", "story_v_out_221031.awb") ~= 0 then
					local var_331_10 = manager.audio:GetVoiceLength("story_v_out_221031", "221031077", "story_v_out_221031.awb") / 1000

					if var_331_10 + var_331_4 > arg_328_1.duration_ then
						arg_328_1.duration_ = var_331_10 + var_331_4
					end

					if var_331_6.prefab_name ~= "" and arg_328_1.actors_[var_331_6.prefab_name] ~= nil then
						local var_331_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_328_1.actors_[var_331_6.prefab_name].transform, "story_v_out_221031", "221031077", "story_v_out_221031.awb")

						arg_328_1:RecordAudio("221031077", var_331_11)
						arg_328_1:RecordAudio("221031077", var_331_11)
					else
						arg_328_1:AudioAction("play", "voice", "story_v_out_221031", "221031077", "story_v_out_221031.awb")
					end

					arg_328_1:RecordHistoryTalkVoice("story_v_out_221031", "221031077", "story_v_out_221031.awb")
				end

				arg_328_1:RecordContent(arg_328_1.text_.text)
			end

			local var_331_12 = math.max(var_331_5, arg_328_1.talkMaxDuration)

			if var_331_4 <= arg_328_1.time_ and arg_328_1.time_ < var_331_4 + var_331_12 then
				arg_328_1.typewritter.percent = (arg_328_1.time_ - var_331_4) / var_331_12

				arg_328_1.typewritter:SetDirty()
			end

			if arg_328_1.time_ >= var_331_4 + var_331_12 and arg_328_1.time_ < var_331_4 + var_331_12 + arg_331_0 then
				arg_328_1.typewritter.percent = 1

				arg_328_1.typewritter:SetDirty()
				arg_328_1:ShowNextGo(true)
			end
		end

		arg_328_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_328_1:InitPlayNodeList()
	end,
	Play221031078 = function(arg_332_0, arg_332_1)
		arg_332_1.time_ = 0
		arg_332_1.frameCnt_ = 0
		arg_332_1.state_ = "playing"
		arg_332_1.curTalkId_ = 221031078
		arg_332_1.duration_ = 11.63

		local var_332_0 = {
			ja = 11.633,
			ko = 9.6,
			zh = 9.6
		}
		local var_332_1 = manager.audio:GetLocalizationFlag()

		if var_332_0[var_332_1] ~= nil then
			arg_332_1.duration_ = var_332_0[var_332_1]
		end

		SetActive(arg_332_1.tipsGo_, false)

		function arg_332_1.onSingleLineFinish_()
			arg_332_1.onSingleLineUpdate_ = nil
			arg_332_1.onSingleLineFinish_ = nil
			arg_332_1.state_ = "waiting"
		end

		function arg_332_1.playNext_(arg_334_0)
			if arg_334_0 == 1 then
				arg_332_0:Play221031079(arg_332_1)
			end
		end

		function arg_332_1.onSingleLineUpdate_(arg_335_0)
			if 0 < arg_332_1.time_ and arg_332_1.time_ <= 0 + arg_335_0 and not isNil(arg_332_1.actors_["1072ui_story"]) and arg_332_1.var_.characterEffect1072ui_story == nil then
				arg_332_1.var_.characterEffect1072ui_story = arg_332_1.actors_["1072ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_335_0 = 0.200000002980232

			if 0 <= arg_332_1.time_ and arg_332_1.time_ < 0 + var_335_0 and not isNil(arg_332_1.actors_["1072ui_story"]) then
				if arg_332_1.var_.characterEffect1072ui_story and not isNil(arg_332_1.actors_["1072ui_story"]) then
					arg_332_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_332_1.var_.characterEffect1072ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_332_1.time_ - 0) / var_335_0)
				end
			end

			if arg_332_1.time_ >= 0 + var_335_0 and arg_332_1.time_ < 0 + var_335_0 + arg_335_0 and not isNil(arg_332_1.actors_["1072ui_story"]) and arg_332_1.var_.characterEffect1072ui_story then
				arg_332_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_332_1.var_.characterEffect1072ui_story.fillRatio = 0.5
			end

			local var_335_1 = 0
			local var_335_2 = 0.95

			if 0 < arg_332_1.time_ and arg_332_1.time_ <= var_335_1 + arg_335_0 then
				arg_332_1.talkMaxDuration = 0
				arg_332_1.dialogCg_.alpha = 1

				arg_332_1.dialog_:SetActive(true)
				SetActive(arg_332_1.leftNameGo_, true)

				arg_332_1.leftNameTxt_.text = arg_332_1:FormatText(StoryNameCfg[422].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_332_1.leftNameTxt_.transform)

				arg_332_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_332_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_332_1:RecordName(arg_332_1.leftNameTxt_.text)
				SetActive(arg_332_1.iconTrs_.gameObject, true)
				arg_332_1.iconController_:SetSelectedState("hero")

				arg_332_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_332_1.callingController_:SetSelectedState("normal")

				arg_332_1.keyicon_.color = Color.New(1, 1, 1)
				arg_332_1.icon_.color = Color.New(1, 1, 1)

				local var_335_3 = arg_332_1:GetWordFromCfg(221031078)
				local var_335_4 = arg_332_1:FormatText(var_335_3.content)

				arg_332_1.text_.text = var_335_4

				LuaForUtil.ClearLinePrefixSymbol(arg_332_1.text_)

				local var_335_6 = 37 <= 0 and var_335_2 or var_335_2 * (utf8.len(var_335_4) / 37)

				if (37 <= 0 and var_335_2 or var_335_2 * (utf8.len(var_335_4) / 37)) > 0 and var_335_2 < var_335_6 then
					arg_332_1.talkMaxDuration = var_335_6

					if var_335_6 + var_335_1 > arg_332_1.duration_ then
						arg_332_1.duration_ = var_335_6 + var_335_1
					end
				end

				arg_332_1.text_.text = var_335_4
				arg_332_1.typewritter.percent = 0

				arg_332_1.typewritter:SetDirty()
				arg_332_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221031", "221031078", "story_v_out_221031.awb") ~= 0 then
					local var_335_7 = manager.audio:GetVoiceLength("story_v_out_221031", "221031078", "story_v_out_221031.awb") / 1000

					if var_335_7 + var_335_1 > arg_332_1.duration_ then
						arg_332_1.duration_ = var_335_7 + var_335_1
					end

					if var_335_3.prefab_name ~= "" and arg_332_1.actors_[var_335_3.prefab_name] ~= nil then
						local var_335_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_332_1.actors_[var_335_3.prefab_name].transform, "story_v_out_221031", "221031078", "story_v_out_221031.awb")

						arg_332_1:RecordAudio("221031078", var_335_8)
						arg_332_1:RecordAudio("221031078", var_335_8)
					else
						arg_332_1:AudioAction("play", "voice", "story_v_out_221031", "221031078", "story_v_out_221031.awb")
					end

					arg_332_1:RecordHistoryTalkVoice("story_v_out_221031", "221031078", "story_v_out_221031.awb")
				end

				arg_332_1:RecordContent(arg_332_1.text_.text)
			end

			local var_335_9 = math.max(var_335_2, arg_332_1.talkMaxDuration)

			if var_335_1 <= arg_332_1.time_ and arg_332_1.time_ < var_335_1 + var_335_9 then
				arg_332_1.typewritter.percent = (arg_332_1.time_ - var_335_1) / var_335_9

				arg_332_1.typewritter:SetDirty()
			end

			if arg_332_1.time_ >= var_335_1 + var_335_9 and arg_332_1.time_ < var_335_1 + var_335_9 + arg_335_0 then
				arg_332_1.typewritter.percent = 1

				arg_332_1.typewritter:SetDirty()
				arg_332_1:ShowNextGo(true)
			end
		end

		arg_332_1.nodeConfigList_ = {}

		arg_332_1:InitPlayNodeList()
	end,
	Play221031079 = function(arg_336_0, arg_336_1)
		arg_336_1.time_ = 0
		arg_336_1.frameCnt_ = 0
		arg_336_1.state_ = "playing"
		arg_336_1.curTalkId_ = 221031079
		arg_336_1.duration_ = 7.8

		local var_336_0 = {
			ja = 7.8,
			ko = 4.933,
			zh = 4.933
		}
		local var_336_1 = manager.audio:GetLocalizationFlag()

		if var_336_0[var_336_1] ~= nil then
			arg_336_1.duration_ = var_336_0[var_336_1]
		end

		SetActive(arg_336_1.tipsGo_, false)

		function arg_336_1.onSingleLineFinish_()
			arg_336_1.onSingleLineUpdate_ = nil
			arg_336_1.onSingleLineFinish_ = nil
			arg_336_1.state_ = "waiting"
		end

		function arg_336_1.playNext_(arg_338_0)
			if arg_338_0 == 1 then
				arg_336_0:Play221031080(arg_336_1)
			end
		end

		function arg_336_1.onSingleLineUpdate_(arg_339_0)
			local var_339_0 = 0.625

			if 0 < arg_336_1.time_ and arg_336_1.time_ <= 0 + arg_339_0 then
				arg_336_1.talkMaxDuration = 0
				arg_336_1.dialogCg_.alpha = 1

				arg_336_1.dialog_:SetActive(true)
				SetActive(arg_336_1.leftNameGo_, true)

				arg_336_1.leftNameTxt_.text = arg_336_1:FormatText(StoryNameCfg[422].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_336_1.leftNameTxt_.transform)

				arg_336_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_336_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_336_1:RecordName(arg_336_1.leftNameTxt_.text)
				SetActive(arg_336_1.iconTrs_.gameObject, true)
				arg_336_1.iconController_:SetSelectedState("hero")

				arg_336_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_336_1.callingController_:SetSelectedState("normal")

				arg_336_1.keyicon_.color = Color.New(1, 1, 1)
				arg_336_1.icon_.color = Color.New(1, 1, 1)

				local var_339_1 = arg_336_1:GetWordFromCfg(221031079)
				local var_339_2 = arg_336_1:FormatText(var_339_1.content)

				arg_336_1.text_.text = var_339_2

				LuaForUtil.ClearLinePrefixSymbol(arg_336_1.text_)

				local var_339_4 = 25 <= 0 and var_339_0 or var_339_0 * (utf8.len(var_339_2) / 25)

				if (25 <= 0 and var_339_0 or var_339_0 * (utf8.len(var_339_2) / 25)) > 0 and var_339_0 < var_339_4 then
					arg_336_1.talkMaxDuration = var_339_4

					if var_339_4 + 0 > arg_336_1.duration_ then
						arg_336_1.duration_ = var_339_4 + 0
					end
				end

				arg_336_1.text_.text = var_339_2
				arg_336_1.typewritter.percent = 0

				arg_336_1.typewritter:SetDirty()
				arg_336_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221031", "221031079", "story_v_out_221031.awb") ~= 0 then
					local var_339_5 = manager.audio:GetVoiceLength("story_v_out_221031", "221031079", "story_v_out_221031.awb") / 1000

					if var_339_5 + 0 > arg_336_1.duration_ then
						arg_336_1.duration_ = var_339_5 + 0
					end

					if var_339_1.prefab_name ~= "" and arg_336_1.actors_[var_339_1.prefab_name] ~= nil then
						local var_339_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_336_1.actors_[var_339_1.prefab_name].transform, "story_v_out_221031", "221031079", "story_v_out_221031.awb")

						arg_336_1:RecordAudio("221031079", var_339_6)
						arg_336_1:RecordAudio("221031079", var_339_6)
					else
						arg_336_1:AudioAction("play", "voice", "story_v_out_221031", "221031079", "story_v_out_221031.awb")
					end

					arg_336_1:RecordHistoryTalkVoice("story_v_out_221031", "221031079", "story_v_out_221031.awb")
				end

				arg_336_1:RecordContent(arg_336_1.text_.text)
			end

			local var_339_7 = math.max(var_339_0, arg_336_1.talkMaxDuration)

			if 0 <= arg_336_1.time_ and arg_336_1.time_ < 0 + var_339_7 then
				arg_336_1.typewritter.percent = (arg_336_1.time_ - 0) / var_339_7

				arg_336_1.typewritter:SetDirty()
			end

			if arg_336_1.time_ >= 0 + var_339_7 and arg_336_1.time_ < 0 + var_339_7 + arg_339_0 then
				arg_336_1.typewritter.percent = 1

				arg_336_1.typewritter:SetDirty()
				arg_336_1:ShowNextGo(true)
			end
		end

		arg_336_1.nodeConfigList_ = {}

		arg_336_1:InitPlayNodeList()
	end,
	Play221031080 = function(arg_340_0, arg_340_1)
		arg_340_1.time_ = 0
		arg_340_1.frameCnt_ = 0
		arg_340_1.state_ = "playing"
		arg_340_1.curTalkId_ = 221031080
		arg_340_1.duration_ = 3.67

		local var_340_0 = {
			ja = 3.666,
			ko = 3.433,
			zh = 3.433
		}
		local var_340_1 = manager.audio:GetLocalizationFlag()

		if var_340_0[var_340_1] ~= nil then
			arg_340_1.duration_ = var_340_0[var_340_1]
		end

		SetActive(arg_340_1.tipsGo_, false)

		function arg_340_1.onSingleLineFinish_()
			arg_340_1.onSingleLineUpdate_ = nil
			arg_340_1.onSingleLineFinish_ = nil
			arg_340_1.state_ = "waiting"
		end

		function arg_340_1.playNext_(arg_342_0)
			if arg_342_0 == 1 then
				arg_340_0:Play221031081(arg_340_1)
			end
		end

		function arg_340_1.onSingleLineUpdate_(arg_343_0)
			if 0 < arg_340_1.time_ and arg_340_1.time_ <= 0 + arg_343_0 then
				arg_340_1.var_.moveOldPos1072ui_story = arg_340_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_343_0 = 0.001

			if 0 <= arg_340_1.time_ and arg_340_1.time_ < 0 + var_343_0 then
				arg_340_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_340_1.var_.moveOldPos1072ui_story, Vector3.New(0, -0.71, -6), (arg_340_1.time_ - 0) / var_343_0)
				arg_340_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_340_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_340_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_340_1.actors_["1072ui_story"].transform.position).z)
				arg_340_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_340_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_340_1.actors_["1072ui_story"].transform.localEulerAngles = arg_340_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_340_1.time_ >= 0 + var_343_0 and arg_340_1.time_ < 0 + var_343_0 + arg_343_0 then
				arg_340_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_340_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_340_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_340_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_340_1.actors_["1072ui_story"].transform.position).z)
				arg_340_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_340_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_340_1.actors_["1072ui_story"].transform.localEulerAngles = arg_340_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			local var_343_1 = arg_340_1.actors_["1072ui_story"]

			if 0 < arg_340_1.time_ and arg_340_1.time_ <= 0 + arg_343_0 and not isNil(var_343_1) and arg_340_1.var_.characterEffect1072ui_story == nil then
				arg_340_1.var_.characterEffect1072ui_story = var_343_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_343_2 = 0.200000002980232

			if 0 <= arg_340_1.time_ and arg_340_1.time_ < 0 + var_343_2 and not isNil(var_343_1) then
				if arg_340_1.var_.characterEffect1072ui_story and not isNil(var_343_1) then
					arg_340_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_340_1.time_ >= 0 + var_343_2 and arg_340_1.time_ < 0 + var_343_2 + arg_343_0 and not isNil(var_343_1) and arg_340_1.var_.characterEffect1072ui_story then
				arg_340_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			if 0 < arg_340_1.time_ and arg_340_1.time_ <= 0 + arg_343_0 then
				arg_340_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action7_2")
			end

			if 0 < arg_340_1.time_ and arg_340_1.time_ <= 0 + arg_343_0 then
				arg_340_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_343_4 = 0
			local var_343_5 = 0.275

			if 0 < arg_340_1.time_ and arg_340_1.time_ <= var_343_4 + arg_343_0 then
				arg_340_1.talkMaxDuration = 0
				arg_340_1.dialogCg_.alpha = 1

				arg_340_1.dialog_:SetActive(true)
				SetActive(arg_340_1.leftNameGo_, true)

				arg_340_1.leftNameTxt_.text = arg_340_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_340_1.leftNameTxt_.transform)

				arg_340_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_340_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_340_1:RecordName(arg_340_1.leftNameTxt_.text)
				SetActive(arg_340_1.iconTrs_.gameObject, false)
				arg_340_1.callingController_:SetSelectedState("normal")

				local var_343_6 = arg_340_1:GetWordFromCfg(221031080)
				local var_343_7 = arg_340_1:FormatText(var_343_6.content)

				arg_340_1.text_.text = var_343_7

				LuaForUtil.ClearLinePrefixSymbol(arg_340_1.text_)

				local var_343_9 = 11 <= 0 and var_343_5 or var_343_5 * (utf8.len(var_343_7) / 11)

				if (11 <= 0 and var_343_5 or var_343_5 * (utf8.len(var_343_7) / 11)) > 0 and var_343_5 < var_343_9 then
					arg_340_1.talkMaxDuration = var_343_9

					if var_343_9 + var_343_4 > arg_340_1.duration_ then
						arg_340_1.duration_ = var_343_9 + var_343_4
					end
				end

				arg_340_1.text_.text = var_343_7
				arg_340_1.typewritter.percent = 0

				arg_340_1.typewritter:SetDirty()
				arg_340_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221031", "221031080", "story_v_out_221031.awb") ~= 0 then
					local var_343_10 = manager.audio:GetVoiceLength("story_v_out_221031", "221031080", "story_v_out_221031.awb") / 1000

					if var_343_10 + var_343_4 > arg_340_1.duration_ then
						arg_340_1.duration_ = var_343_10 + var_343_4
					end

					if var_343_6.prefab_name ~= "" and arg_340_1.actors_[var_343_6.prefab_name] ~= nil then
						local var_343_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_340_1.actors_[var_343_6.prefab_name].transform, "story_v_out_221031", "221031080", "story_v_out_221031.awb")

						arg_340_1:RecordAudio("221031080", var_343_11)
						arg_340_1:RecordAudio("221031080", var_343_11)
					else
						arg_340_1:AudioAction("play", "voice", "story_v_out_221031", "221031080", "story_v_out_221031.awb")
					end

					arg_340_1:RecordHistoryTalkVoice("story_v_out_221031", "221031080", "story_v_out_221031.awb")
				end

				arg_340_1:RecordContent(arg_340_1.text_.text)
			end

			local var_343_12 = math.max(var_343_5, arg_340_1.talkMaxDuration)

			if var_343_4 <= arg_340_1.time_ and arg_340_1.time_ < var_343_4 + var_343_12 then
				arg_340_1.typewritter.percent = (arg_340_1.time_ - var_343_4) / var_343_12

				arg_340_1.typewritter:SetDirty()
			end

			if arg_340_1.time_ >= var_343_4 + var_343_12 and arg_340_1.time_ < var_343_4 + var_343_12 + arg_343_0 then
				arg_340_1.typewritter.percent = 1

				arg_340_1.typewritter:SetDirty()
				arg_340_1:ShowNextGo(true)
			end
		end

		arg_340_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_340_1:InitPlayNodeList()
	end,
	Play221031081 = function(arg_344_0, arg_344_1)
		arg_344_1.time_ = 0
		arg_344_1.frameCnt_ = 0
		arg_344_1.state_ = "playing"
		arg_344_1.curTalkId_ = 221031081
		arg_344_1.duration_ = 5

		SetActive(arg_344_1.tipsGo_, false)

		function arg_344_1.onSingleLineFinish_()
			arg_344_1.onSingleLineUpdate_ = nil
			arg_344_1.onSingleLineFinish_ = nil
			arg_344_1.state_ = "waiting"
		end

		function arg_344_1.playNext_(arg_346_0)
			if arg_346_0 == 1 then
				arg_344_0:Play221031082(arg_344_1)
			end
		end

		function arg_344_1.onSingleLineUpdate_(arg_347_0)
			if 0 < arg_344_1.time_ and arg_344_1.time_ <= 0 + arg_347_0 and not isNil(arg_344_1.actors_["1072ui_story"]) and arg_344_1.var_.characterEffect1072ui_story == nil then
				arg_344_1.var_.characterEffect1072ui_story = arg_344_1.actors_["1072ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_347_0 = 0.200000002980232

			if 0 <= arg_344_1.time_ and arg_344_1.time_ < 0 + var_347_0 and not isNil(arg_344_1.actors_["1072ui_story"]) then
				if arg_344_1.var_.characterEffect1072ui_story and not isNil(arg_344_1.actors_["1072ui_story"]) then
					arg_344_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_344_1.var_.characterEffect1072ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_344_1.time_ - 0) / var_347_0)
				end
			end

			if arg_344_1.time_ >= 0 + var_347_0 and arg_344_1.time_ < 0 + var_347_0 + arg_347_0 and not isNil(arg_344_1.actors_["1072ui_story"]) and arg_344_1.var_.characterEffect1072ui_story then
				arg_344_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_344_1.var_.characterEffect1072ui_story.fillRatio = 0.5
			end

			local var_347_1 = 0
			local var_347_2 = 0.375

			if 0 < arg_344_1.time_ and arg_344_1.time_ <= var_347_1 + arg_347_0 then
				arg_344_1.talkMaxDuration = 0
				arg_344_1.dialogCg_.alpha = 1

				arg_344_1.dialog_:SetActive(true)
				SetActive(arg_344_1.leftNameGo_, false)

				arg_344_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_344_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_344_1:RecordName(arg_344_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_344_1.iconTrs_.gameObject, false)
				arg_344_1.callingController_:SetSelectedState("normal")

				local var_347_3 = arg_344_1:FormatText(arg_344_1:GetWordFromCfg(221031081).content)

				arg_344_1.text_.text = var_347_3

				LuaForUtil.ClearLinePrefixSymbol(arg_344_1.text_)

				local var_347_5 = 15 <= 0 and var_347_2 or var_347_2 * (utf8.len(var_347_3) / 15)

				if (15 <= 0 and var_347_2 or var_347_2 * (utf8.len(var_347_3) / 15)) > 0 and var_347_2 < var_347_5 then
					arg_344_1.talkMaxDuration = var_347_5

					if var_347_5 + var_347_1 > arg_344_1.duration_ then
						arg_344_1.duration_ = var_347_5 + var_347_1
					end
				end

				arg_344_1.text_.text = var_347_3
				arg_344_1.typewritter.percent = 0

				arg_344_1.typewritter:SetDirty()
				arg_344_1:ShowNextGo(false)
				arg_344_1:RecordContent(arg_344_1.text_.text)
			end

			local var_347_6 = math.max(var_347_2, arg_344_1.talkMaxDuration)

			if var_347_1 <= arg_344_1.time_ and arg_344_1.time_ < var_347_1 + var_347_6 then
				arg_344_1.typewritter.percent = (arg_344_1.time_ - var_347_1) / var_347_6

				arg_344_1.typewritter:SetDirty()
			end

			if arg_344_1.time_ >= var_347_1 + var_347_6 and arg_344_1.time_ < var_347_1 + var_347_6 + arg_347_0 then
				arg_344_1.typewritter.percent = 1

				arg_344_1.typewritter:SetDirty()
				arg_344_1:ShowNextGo(true)
			end
		end

		arg_344_1.nodeConfigList_ = {}

		arg_344_1:InitPlayNodeList()
	end,
	Play221031082 = function(arg_348_0, arg_348_1)
		arg_348_1.time_ = 0
		arg_348_1.frameCnt_ = 0
		arg_348_1.state_ = "playing"
		arg_348_1.curTalkId_ = 221031082
		arg_348_1.duration_ = 14.67

		local var_348_0 = {
			ja = 14.666,
			ko = 9.033,
			zh = 9.033
		}
		local var_348_1 = manager.audio:GetLocalizationFlag()

		if var_348_0[var_348_1] ~= nil then
			arg_348_1.duration_ = var_348_0[var_348_1]
		end

		SetActive(arg_348_1.tipsGo_, false)

		function arg_348_1.onSingleLineFinish_()
			arg_348_1.onSingleLineUpdate_ = nil
			arg_348_1.onSingleLineFinish_ = nil
			arg_348_1.state_ = "waiting"
		end

		function arg_348_1.playNext_(arg_350_0)
			if arg_350_0 == 1 then
				arg_348_0:Play221031083(arg_348_1)
			end
		end

		function arg_348_1.onSingleLineUpdate_(arg_351_0)
			local var_351_0 = 0.95

			if 0 < arg_348_1.time_ and arg_348_1.time_ <= 0 + arg_351_0 then
				arg_348_1.talkMaxDuration = 0
				arg_348_1.dialogCg_.alpha = 1

				arg_348_1.dialog_:SetActive(true)
				SetActive(arg_348_1.leftNameGo_, true)

				arg_348_1.leftNameTxt_.text = arg_348_1:FormatText(StoryNameCfg[422].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_348_1.leftNameTxt_.transform)

				arg_348_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_348_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_348_1:RecordName(arg_348_1.leftNameTxt_.text)
				SetActive(arg_348_1.iconTrs_.gameObject, true)
				arg_348_1.iconController_:SetSelectedState("hero")

				arg_348_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_348_1.callingController_:SetSelectedState("normal")

				arg_348_1.keyicon_.color = Color.New(1, 1, 1)
				arg_348_1.icon_.color = Color.New(1, 1, 1)

				local var_351_1 = arg_348_1:GetWordFromCfg(221031082)
				local var_351_2 = arg_348_1:FormatText(var_351_1.content)

				arg_348_1.text_.text = var_351_2

				LuaForUtil.ClearLinePrefixSymbol(arg_348_1.text_)

				local var_351_4 = 38 <= 0 and var_351_0 or var_351_0 * (utf8.len(var_351_2) / 38)

				if (38 <= 0 and var_351_0 or var_351_0 * (utf8.len(var_351_2) / 38)) > 0 and var_351_0 < var_351_4 then
					arg_348_1.talkMaxDuration = var_351_4

					if var_351_4 + 0 > arg_348_1.duration_ then
						arg_348_1.duration_ = var_351_4 + 0
					end
				end

				arg_348_1.text_.text = var_351_2
				arg_348_1.typewritter.percent = 0

				arg_348_1.typewritter:SetDirty()
				arg_348_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221031", "221031082", "story_v_out_221031.awb") ~= 0 then
					local var_351_5 = manager.audio:GetVoiceLength("story_v_out_221031", "221031082", "story_v_out_221031.awb") / 1000

					if var_351_5 + 0 > arg_348_1.duration_ then
						arg_348_1.duration_ = var_351_5 + 0
					end

					if var_351_1.prefab_name ~= "" and arg_348_1.actors_[var_351_1.prefab_name] ~= nil then
						local var_351_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_348_1.actors_[var_351_1.prefab_name].transform, "story_v_out_221031", "221031082", "story_v_out_221031.awb")

						arg_348_1:RecordAudio("221031082", var_351_6)
						arg_348_1:RecordAudio("221031082", var_351_6)
					else
						arg_348_1:AudioAction("play", "voice", "story_v_out_221031", "221031082", "story_v_out_221031.awb")
					end

					arg_348_1:RecordHistoryTalkVoice("story_v_out_221031", "221031082", "story_v_out_221031.awb")
				end

				arg_348_1:RecordContent(arg_348_1.text_.text)
			end

			local var_351_7 = math.max(var_351_0, arg_348_1.talkMaxDuration)

			if 0 <= arg_348_1.time_ and arg_348_1.time_ < 0 + var_351_7 then
				arg_348_1.typewritter.percent = (arg_348_1.time_ - 0) / var_351_7

				arg_348_1.typewritter:SetDirty()
			end

			if arg_348_1.time_ >= 0 + var_351_7 and arg_348_1.time_ < 0 + var_351_7 + arg_351_0 then
				arg_348_1.typewritter.percent = 1

				arg_348_1.typewritter:SetDirty()
				arg_348_1:ShowNextGo(true)
			end
		end

		arg_348_1.nodeConfigList_ = {}

		arg_348_1:InitPlayNodeList()
	end,
	Play221031083 = function(arg_352_0, arg_352_1)
		arg_352_1.time_ = 0
		arg_352_1.frameCnt_ = 0
		arg_352_1.state_ = "playing"
		arg_352_1.curTalkId_ = 221031083
		arg_352_1.duration_ = 12.47

		local var_352_0 = {
			ja = 12.466,
			ko = 11.166,
			zh = 11.166
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
				arg_352_0:Play221031084(arg_352_1)
			end
		end

		function arg_352_1.onSingleLineUpdate_(arg_355_0)
			if 0 < arg_352_1.time_ and arg_352_1.time_ <= 0 + arg_355_0 then
				arg_352_1.var_.moveOldPos1072ui_story = arg_352_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_355_0 = 0.001

			if 0 <= arg_352_1.time_ and arg_352_1.time_ < 0 + var_355_0 then
				arg_352_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_352_1.var_.moveOldPos1072ui_story, Vector3.New(0, -0.71, -6), (arg_352_1.time_ - 0) / var_355_0)
				arg_352_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_352_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_352_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_352_1.actors_["1072ui_story"].transform.position).z)
				arg_352_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_352_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_352_1.actors_["1072ui_story"].transform.localEulerAngles = arg_352_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_352_1.time_ >= 0 + var_355_0 and arg_352_1.time_ < 0 + var_355_0 + arg_355_0 then
				arg_352_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_352_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_352_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_352_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_352_1.actors_["1072ui_story"].transform.position).z)
				arg_352_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_352_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_352_1.actors_["1072ui_story"].transform.localEulerAngles = arg_352_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			local var_355_1 = arg_352_1.actors_["1072ui_story"]

			if 0 < arg_352_1.time_ and arg_352_1.time_ <= 0 + arg_355_0 and not isNil(var_355_1) and arg_352_1.var_.characterEffect1072ui_story == nil then
				arg_352_1.var_.characterEffect1072ui_story = var_355_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_355_2 = 0.200000002980232

			if 0 <= arg_352_1.time_ and arg_352_1.time_ < 0 + var_355_2 and not isNil(var_355_1) then
				if arg_352_1.var_.characterEffect1072ui_story and not isNil(var_355_1) then
					arg_352_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_352_1.time_ >= 0 + var_355_2 and arg_352_1.time_ < 0 + var_355_2 + arg_355_0 and not isNil(var_355_1) and arg_352_1.var_.characterEffect1072ui_story then
				arg_352_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			if 0 < arg_352_1.time_ and arg_352_1.time_ <= 0 + arg_355_0 then
				arg_352_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action8_1")
			end

			if 0 < arg_352_1.time_ and arg_352_1.time_ <= 0 + arg_355_0 then
				arg_352_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_355_4 = 0
			local var_355_5 = 1.1

			if 0 < arg_352_1.time_ and arg_352_1.time_ <= var_355_4 + arg_355_0 then
				arg_352_1.talkMaxDuration = 0
				arg_352_1.dialogCg_.alpha = 1

				arg_352_1.dialog_:SetActive(true)
				SetActive(arg_352_1.leftNameGo_, true)

				arg_352_1.leftNameTxt_.text = arg_352_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_352_1.leftNameTxt_.transform)

				arg_352_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_352_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_352_1:RecordName(arg_352_1.leftNameTxt_.text)
				SetActive(arg_352_1.iconTrs_.gameObject, false)
				arg_352_1.callingController_:SetSelectedState("normal")

				local var_355_6 = arg_352_1:GetWordFromCfg(221031083)
				local var_355_7 = arg_352_1:FormatText(var_355_6.content)

				arg_352_1.text_.text = var_355_7

				LuaForUtil.ClearLinePrefixSymbol(arg_352_1.text_)

				local var_355_9 = 44 <= 0 and var_355_5 or var_355_5 * (utf8.len(var_355_7) / 44)

				if (44 <= 0 and var_355_5 or var_355_5 * (utf8.len(var_355_7) / 44)) > 0 and var_355_5 < var_355_9 then
					arg_352_1.talkMaxDuration = var_355_9

					if var_355_9 + var_355_4 > arg_352_1.duration_ then
						arg_352_1.duration_ = var_355_9 + var_355_4
					end
				end

				arg_352_1.text_.text = var_355_7
				arg_352_1.typewritter.percent = 0

				arg_352_1.typewritter:SetDirty()
				arg_352_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221031", "221031083", "story_v_out_221031.awb") ~= 0 then
					local var_355_10 = manager.audio:GetVoiceLength("story_v_out_221031", "221031083", "story_v_out_221031.awb") / 1000

					if var_355_10 + var_355_4 > arg_352_1.duration_ then
						arg_352_1.duration_ = var_355_10 + var_355_4
					end

					if var_355_6.prefab_name ~= "" and arg_352_1.actors_[var_355_6.prefab_name] ~= nil then
						local var_355_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_352_1.actors_[var_355_6.prefab_name].transform, "story_v_out_221031", "221031083", "story_v_out_221031.awb")

						arg_352_1:RecordAudio("221031083", var_355_11)
						arg_352_1:RecordAudio("221031083", var_355_11)
					else
						arg_352_1:AudioAction("play", "voice", "story_v_out_221031", "221031083", "story_v_out_221031.awb")
					end

					arg_352_1:RecordHistoryTalkVoice("story_v_out_221031", "221031083", "story_v_out_221031.awb")
				end

				arg_352_1:RecordContent(arg_352_1.text_.text)
			end

			local var_355_12 = math.max(var_355_5, arg_352_1.talkMaxDuration)

			if var_355_4 <= arg_352_1.time_ and arg_352_1.time_ < var_355_4 + var_355_12 then
				arg_352_1.typewritter.percent = (arg_352_1.time_ - var_355_4) / var_355_12

				arg_352_1.typewritter:SetDirty()
			end

			if arg_352_1.time_ >= var_355_4 + var_355_12 and arg_352_1.time_ < var_355_4 + var_355_12 + arg_355_0 then
				arg_352_1.typewritter.percent = 1

				arg_352_1.typewritter:SetDirty()
				arg_352_1:ShowNextGo(true)
			end
		end

		arg_352_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_352_1:InitPlayNodeList()
	end,
	Play221031084 = function(arg_356_0, arg_356_1)
		arg_356_1.time_ = 0
		arg_356_1.frameCnt_ = 0
		arg_356_1.state_ = "playing"
		arg_356_1.curTalkId_ = 221031084
		arg_356_1.duration_ = 5.07

		local var_356_0 = {
			ja = 3.6,
			ko = 5.066,
			zh = 5.066
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
				arg_356_0:Play221031085(arg_356_1)
			end
		end

		function arg_356_1.onSingleLineUpdate_(arg_359_0)
			if 0 < arg_356_1.time_ and arg_356_1.time_ <= 0 + arg_359_0 then
				arg_356_1.var_.moveOldPos1072ui_story = arg_356_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_359_0 = 0.001

			if 0 <= arg_356_1.time_ and arg_356_1.time_ < 0 + var_359_0 then
				arg_356_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_356_1.var_.moveOldPos1072ui_story, Vector3.New(0, -0.71, -6), (arg_356_1.time_ - 0) / var_359_0)
				arg_356_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_356_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_356_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_356_1.actors_["1072ui_story"].transform.position).z)
				arg_356_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_356_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_356_1.actors_["1072ui_story"].transform.localEulerAngles = arg_356_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_356_1.time_ >= 0 + var_359_0 and arg_356_1.time_ < 0 + var_359_0 + arg_359_0 then
				arg_356_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_356_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_356_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_356_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_356_1.actors_["1072ui_story"].transform.position).z)
				arg_356_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_356_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_356_1.actors_["1072ui_story"].transform.localEulerAngles = arg_356_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if 0 < arg_356_1.time_ and arg_356_1.time_ <= 0 + arg_359_0 then
				arg_356_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0201cva")
			end

			if 0 < arg_356_1.time_ and arg_356_1.time_ <= 0 + arg_359_0 then
				arg_356_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action8_2")
			end

			local var_359_1 = 0
			local var_359_2 = 0.625

			if 0 < arg_356_1.time_ and arg_356_1.time_ <= var_359_1 + arg_359_0 then
				arg_356_1.talkMaxDuration = 0
				arg_356_1.dialogCg_.alpha = 1

				arg_356_1.dialog_:SetActive(true)
				SetActive(arg_356_1.leftNameGo_, true)

				arg_356_1.leftNameTxt_.text = arg_356_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_356_1.leftNameTxt_.transform)

				arg_356_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_356_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_356_1:RecordName(arg_356_1.leftNameTxt_.text)
				SetActive(arg_356_1.iconTrs_.gameObject, false)
				arg_356_1.callingController_:SetSelectedState("normal")

				local var_359_3 = arg_356_1:GetWordFromCfg(221031084)
				local var_359_4 = arg_356_1:FormatText(var_359_3.content)

				arg_356_1.text_.text = var_359_4

				LuaForUtil.ClearLinePrefixSymbol(arg_356_1.text_)

				local var_359_6 = 25 <= 0 and var_359_2 or var_359_2 * (utf8.len(var_359_4) / 25)

				if (25 <= 0 and var_359_2 or var_359_2 * (utf8.len(var_359_4) / 25)) > 0 and var_359_2 < var_359_6 then
					arg_356_1.talkMaxDuration = var_359_6

					if var_359_6 + var_359_1 > arg_356_1.duration_ then
						arg_356_1.duration_ = var_359_6 + var_359_1
					end
				end

				arg_356_1.text_.text = var_359_4
				arg_356_1.typewritter.percent = 0

				arg_356_1.typewritter:SetDirty()
				arg_356_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221031", "221031084", "story_v_out_221031.awb") ~= 0 then
					local var_359_7 = manager.audio:GetVoiceLength("story_v_out_221031", "221031084", "story_v_out_221031.awb") / 1000

					if var_359_7 + var_359_1 > arg_356_1.duration_ then
						arg_356_1.duration_ = var_359_7 + var_359_1
					end

					if var_359_3.prefab_name ~= "" and arg_356_1.actors_[var_359_3.prefab_name] ~= nil then
						local var_359_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_356_1.actors_[var_359_3.prefab_name].transform, "story_v_out_221031", "221031084", "story_v_out_221031.awb")

						arg_356_1:RecordAudio("221031084", var_359_8)
						arg_356_1:RecordAudio("221031084", var_359_8)
					else
						arg_356_1:AudioAction("play", "voice", "story_v_out_221031", "221031084", "story_v_out_221031.awb")
					end

					arg_356_1:RecordHistoryTalkVoice("story_v_out_221031", "221031084", "story_v_out_221031.awb")
				end

				arg_356_1:RecordContent(arg_356_1.text_.text)
			end

			local var_359_9 = math.max(var_359_2, arg_356_1.talkMaxDuration)

			if var_359_1 <= arg_356_1.time_ and arg_356_1.time_ < var_359_1 + var_359_9 then
				arg_356_1.typewritter.percent = (arg_356_1.time_ - var_359_1) / var_359_9

				arg_356_1.typewritter:SetDirty()
			end

			if arg_356_1.time_ >= var_359_1 + var_359_9 and arg_356_1.time_ < var_359_1 + var_359_9 + arg_359_0 then
				arg_356_1.typewritter.percent = 1

				arg_356_1.typewritter:SetDirty()
				arg_356_1:ShowNextGo(true)
			end
		end

		arg_356_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_356_1:InitPlayNodeList()
	end,
	Play221031085 = function(arg_360_0, arg_360_1)
		arg_360_1.time_ = 0
		arg_360_1.frameCnt_ = 0
		arg_360_1.state_ = "playing"
		arg_360_1.curTalkId_ = 221031085
		arg_360_1.duration_ = 15.37

		local var_360_0 = {
			ja = 15.366,
			ko = 8.4,
			zh = 8.4
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
				arg_360_0:Play221031086(arg_360_1)
			end
		end

		function arg_360_1.onSingleLineUpdate_(arg_363_0)
			if 0 < arg_360_1.time_ and arg_360_1.time_ <= 0 + arg_363_0 and not isNil(arg_360_1.actors_["1072ui_story"]) and arg_360_1.var_.characterEffect1072ui_story == nil then
				arg_360_1.var_.characterEffect1072ui_story = arg_360_1.actors_["1072ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_363_0 = 0.200000002980232

			if 0 <= arg_360_1.time_ and arg_360_1.time_ < 0 + var_363_0 and not isNil(arg_360_1.actors_["1072ui_story"]) then
				if arg_360_1.var_.characterEffect1072ui_story and not isNil(arg_360_1.actors_["1072ui_story"]) then
					arg_360_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_360_1.var_.characterEffect1072ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_360_1.time_ - 0) / var_363_0)
				end
			end

			if arg_360_1.time_ >= 0 + var_363_0 and arg_360_1.time_ < 0 + var_363_0 + arg_363_0 and not isNil(arg_360_1.actors_["1072ui_story"]) and arg_360_1.var_.characterEffect1072ui_story then
				arg_360_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_360_1.var_.characterEffect1072ui_story.fillRatio = 0.5
			end

			local var_363_1 = 0
			local var_363_2 = 0.875

			if 0 < arg_360_1.time_ and arg_360_1.time_ <= var_363_1 + arg_363_0 then
				arg_360_1.talkMaxDuration = 0
				arg_360_1.dialogCg_.alpha = 1

				arg_360_1.dialog_:SetActive(true)
				SetActive(arg_360_1.leftNameGo_, true)

				arg_360_1.leftNameTxt_.text = arg_360_1:FormatText(StoryNameCfg[422].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_360_1.leftNameTxt_.transform)

				arg_360_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_360_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_360_1:RecordName(arg_360_1.leftNameTxt_.text)
				SetActive(arg_360_1.iconTrs_.gameObject, true)
				arg_360_1.iconController_:SetSelectedState("hero")

				arg_360_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_360_1.callingController_:SetSelectedState("normal")

				arg_360_1.keyicon_.color = Color.New(1, 1, 1)
				arg_360_1.icon_.color = Color.New(1, 1, 1)

				local var_363_3 = arg_360_1:GetWordFromCfg(221031085)
				local var_363_4 = arg_360_1:FormatText(var_363_3.content)

				arg_360_1.text_.text = var_363_4

				LuaForUtil.ClearLinePrefixSymbol(arg_360_1.text_)

				local var_363_6 = 35 <= 0 and var_363_2 or var_363_2 * (utf8.len(var_363_4) / 35)

				if (35 <= 0 and var_363_2 or var_363_2 * (utf8.len(var_363_4) / 35)) > 0 and var_363_2 < var_363_6 then
					arg_360_1.talkMaxDuration = var_363_6

					if var_363_6 + var_363_1 > arg_360_1.duration_ then
						arg_360_1.duration_ = var_363_6 + var_363_1
					end
				end

				arg_360_1.text_.text = var_363_4
				arg_360_1.typewritter.percent = 0

				arg_360_1.typewritter:SetDirty()
				arg_360_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221031", "221031085", "story_v_out_221031.awb") ~= 0 then
					local var_363_7 = manager.audio:GetVoiceLength("story_v_out_221031", "221031085", "story_v_out_221031.awb") / 1000

					if var_363_7 + var_363_1 > arg_360_1.duration_ then
						arg_360_1.duration_ = var_363_7 + var_363_1
					end

					if var_363_3.prefab_name ~= "" and arg_360_1.actors_[var_363_3.prefab_name] ~= nil then
						local var_363_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_360_1.actors_[var_363_3.prefab_name].transform, "story_v_out_221031", "221031085", "story_v_out_221031.awb")

						arg_360_1:RecordAudio("221031085", var_363_8)
						arg_360_1:RecordAudio("221031085", var_363_8)
					else
						arg_360_1:AudioAction("play", "voice", "story_v_out_221031", "221031085", "story_v_out_221031.awb")
					end

					arg_360_1:RecordHistoryTalkVoice("story_v_out_221031", "221031085", "story_v_out_221031.awb")
				end

				arg_360_1:RecordContent(arg_360_1.text_.text)
			end

			local var_363_9 = math.max(var_363_2, arg_360_1.talkMaxDuration)

			if var_363_1 <= arg_360_1.time_ and arg_360_1.time_ < var_363_1 + var_363_9 then
				arg_360_1.typewritter.percent = (arg_360_1.time_ - var_363_1) / var_363_9

				arg_360_1.typewritter:SetDirty()
			end

			if arg_360_1.time_ >= var_363_1 + var_363_9 and arg_360_1.time_ < var_363_1 + var_363_9 + arg_363_0 then
				arg_360_1.typewritter.percent = 1

				arg_360_1.typewritter:SetDirty()
				arg_360_1:ShowNextGo(true)
			end
		end

		arg_360_1.nodeConfigList_ = {}

		arg_360_1:InitPlayNodeList()
	end,
	Play221031086 = function(arg_364_0, arg_364_1)
		arg_364_1.time_ = 0
		arg_364_1.frameCnt_ = 0
		arg_364_1.state_ = "playing"
		arg_364_1.curTalkId_ = 221031086
		arg_364_1.duration_ = 5

		SetActive(arg_364_1.tipsGo_, false)

		function arg_364_1.onSingleLineFinish_()
			arg_364_1.onSingleLineUpdate_ = nil
			arg_364_1.onSingleLineFinish_ = nil
			arg_364_1.state_ = "waiting"
		end

		function arg_364_1.playNext_(arg_366_0)
			if arg_366_0 == 1 then
				arg_364_0:Play221031087(arg_364_1)
			end
		end

		function arg_364_1.onSingleLineUpdate_(arg_367_0)
			local var_367_0 = 0.775

			if 0 < arg_364_1.time_ and arg_364_1.time_ <= 0 + arg_367_0 then
				arg_364_1.talkMaxDuration = 0
				arg_364_1.dialogCg_.alpha = 1

				arg_364_1.dialog_:SetActive(true)
				SetActive(arg_364_1.leftNameGo_, false)

				arg_364_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_364_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_364_1:RecordName(arg_364_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_364_1.iconTrs_.gameObject, false)
				arg_364_1.callingController_:SetSelectedState("normal")

				local var_367_1 = arg_364_1:FormatText(arg_364_1:GetWordFromCfg(221031086).content)

				arg_364_1.text_.text = var_367_1

				LuaForUtil.ClearLinePrefixSymbol(arg_364_1.text_)

				local var_367_3 = 31 <= 0 and var_367_0 or var_367_0 * (utf8.len(var_367_1) / 31)

				if (31 <= 0 and var_367_0 or var_367_0 * (utf8.len(var_367_1) / 31)) > 0 and var_367_0 < var_367_3 then
					arg_364_1.talkMaxDuration = var_367_3

					if var_367_3 + 0 > arg_364_1.duration_ then
						arg_364_1.duration_ = var_367_3 + 0
					end
				end

				arg_364_1.text_.text = var_367_1
				arg_364_1.typewritter.percent = 0

				arg_364_1.typewritter:SetDirty()
				arg_364_1:ShowNextGo(false)
				arg_364_1:RecordContent(arg_364_1.text_.text)
			end

			local var_367_4 = math.max(var_367_0, arg_364_1.talkMaxDuration)

			if 0 <= arg_364_1.time_ and arg_364_1.time_ < 0 + var_367_4 then
				arg_364_1.typewritter.percent = (arg_364_1.time_ - 0) / var_367_4

				arg_364_1.typewritter:SetDirty()
			end

			if arg_364_1.time_ >= 0 + var_367_4 and arg_364_1.time_ < 0 + var_367_4 + arg_367_0 then
				arg_364_1.typewritter.percent = 1

				arg_364_1.typewritter:SetDirty()
				arg_364_1:ShowNextGo(true)
			end
		end

		arg_364_1.nodeConfigList_ = {}

		arg_364_1:InitPlayNodeList()
	end,
	Play221031087 = function(arg_368_0, arg_368_1)
		arg_368_1.time_ = 0
		arg_368_1.frameCnt_ = 0
		arg_368_1.state_ = "playing"
		arg_368_1.curTalkId_ = 221031087
		arg_368_1.duration_ = 2.1

		local var_368_0 = {
			ja = 1.999999999999,
			ko = 2.1,
			zh = 2.1
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
				arg_368_0:Play221031088(arg_368_1)
			end
		end

		function arg_368_1.onSingleLineUpdate_(arg_371_0)
			if 0 < arg_368_1.time_ and arg_368_1.time_ <= 0 + arg_371_0 then
				arg_368_1.var_.moveOldPos1072ui_story = arg_368_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_371_0 = 0.001

			if 0 <= arg_368_1.time_ and arg_368_1.time_ < 0 + var_371_0 then
				arg_368_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_368_1.var_.moveOldPos1072ui_story, Vector3.New(0, -0.71, -6), (arg_368_1.time_ - 0) / var_371_0)
				arg_368_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_368_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_368_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_368_1.actors_["1072ui_story"].transform.position).z)
				arg_368_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_368_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_368_1.actors_["1072ui_story"].transform.localEulerAngles = arg_368_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_368_1.time_ >= 0 + var_371_0 and arg_368_1.time_ < 0 + var_371_0 + arg_371_0 then
				arg_368_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_368_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_368_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_368_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_368_1.actors_["1072ui_story"].transform.position).z)
				arg_368_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_368_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_368_1.actors_["1072ui_story"].transform.localEulerAngles = arg_368_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			local var_371_1 = arg_368_1.actors_["1072ui_story"]

			if 0 < arg_368_1.time_ and arg_368_1.time_ <= 0 + arg_371_0 and not isNil(var_371_1) and arg_368_1.var_.characterEffect1072ui_story == nil then
				arg_368_1.var_.characterEffect1072ui_story = var_371_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_371_2 = 0.200000002980232

			if 0 <= arg_368_1.time_ and arg_368_1.time_ < 0 + var_371_2 and not isNil(var_371_1) then
				if arg_368_1.var_.characterEffect1072ui_story and not isNil(var_371_1) then
					arg_368_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_368_1.time_ >= 0 + var_371_2 and arg_368_1.time_ < 0 + var_371_2 + arg_371_0 and not isNil(var_371_1) and arg_368_1.var_.characterEffect1072ui_story then
				arg_368_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			if 0 < arg_368_1.time_ and arg_368_1.time_ <= 0 + arg_371_0 then
				arg_368_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action5_1")
			end

			if 0 < arg_368_1.time_ and arg_368_1.time_ <= 0 + arg_371_0 then
				arg_368_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_371_4 = 0
			local var_371_5 = 0.175

			if 0 < arg_368_1.time_ and arg_368_1.time_ <= var_371_4 + arg_371_0 then
				arg_368_1.talkMaxDuration = 0
				arg_368_1.dialogCg_.alpha = 1

				arg_368_1.dialog_:SetActive(true)
				SetActive(arg_368_1.leftNameGo_, true)

				arg_368_1.leftNameTxt_.text = arg_368_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_368_1.leftNameTxt_.transform)

				arg_368_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_368_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_368_1:RecordName(arg_368_1.leftNameTxt_.text)
				SetActive(arg_368_1.iconTrs_.gameObject, false)
				arg_368_1.callingController_:SetSelectedState("normal")

				local var_371_6 = arg_368_1:GetWordFromCfg(221031087)
				local var_371_7 = arg_368_1:FormatText(var_371_6.content)

				arg_368_1.text_.text = var_371_7

				LuaForUtil.ClearLinePrefixSymbol(arg_368_1.text_)

				local var_371_9 = 7 <= 0 and var_371_5 or var_371_5 * (utf8.len(var_371_7) / 7)

				if (7 <= 0 and var_371_5 or var_371_5 * (utf8.len(var_371_7) / 7)) > 0 and var_371_5 < var_371_9 then
					arg_368_1.talkMaxDuration = var_371_9

					if var_371_9 + var_371_4 > arg_368_1.duration_ then
						arg_368_1.duration_ = var_371_9 + var_371_4
					end
				end

				arg_368_1.text_.text = var_371_7
				arg_368_1.typewritter.percent = 0

				arg_368_1.typewritter:SetDirty()
				arg_368_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221031", "221031087", "story_v_out_221031.awb") ~= 0 then
					local var_371_10 = manager.audio:GetVoiceLength("story_v_out_221031", "221031087", "story_v_out_221031.awb") / 1000

					if var_371_10 + var_371_4 > arg_368_1.duration_ then
						arg_368_1.duration_ = var_371_10 + var_371_4
					end

					if var_371_6.prefab_name ~= "" and arg_368_1.actors_[var_371_6.prefab_name] ~= nil then
						local var_371_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_368_1.actors_[var_371_6.prefab_name].transform, "story_v_out_221031", "221031087", "story_v_out_221031.awb")

						arg_368_1:RecordAudio("221031087", var_371_11)
						arg_368_1:RecordAudio("221031087", var_371_11)
					else
						arg_368_1:AudioAction("play", "voice", "story_v_out_221031", "221031087", "story_v_out_221031.awb")
					end

					arg_368_1:RecordHistoryTalkVoice("story_v_out_221031", "221031087", "story_v_out_221031.awb")
				end

				arg_368_1:RecordContent(arg_368_1.text_.text)
			end

			local var_371_12 = math.max(var_371_5, arg_368_1.talkMaxDuration)

			if var_371_4 <= arg_368_1.time_ and arg_368_1.time_ < var_371_4 + var_371_12 then
				arg_368_1.typewritter.percent = (arg_368_1.time_ - var_371_4) / var_371_12

				arg_368_1.typewritter:SetDirty()
			end

			if arg_368_1.time_ >= var_371_4 + var_371_12 and arg_368_1.time_ < var_371_4 + var_371_12 + arg_371_0 then
				arg_368_1.typewritter.percent = 1

				arg_368_1.typewritter:SetDirty()
				arg_368_1:ShowNextGo(true)
			end
		end

		arg_368_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_368_1:InitPlayNodeList()
	end,
	Play221031088 = function(arg_372_0, arg_372_1)
		arg_372_1.time_ = 0
		arg_372_1.frameCnt_ = 0
		arg_372_1.state_ = "playing"
		arg_372_1.curTalkId_ = 221031088
		arg_372_1.duration_ = 14.2

		local var_372_0 = {
			ja = 14.2,
			ko = 13.833,
			zh = 13.833
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
				arg_372_0:Play221031089(arg_372_1)
			end
		end

		function arg_372_1.onSingleLineUpdate_(arg_375_0)
			if 0 < arg_372_1.time_ and arg_372_1.time_ <= 0 + arg_375_0 then
				arg_372_1.var_.moveOldPos1072ui_story = arg_372_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_375_0 = 0.001

			if 0 <= arg_372_1.time_ and arg_372_1.time_ < 0 + var_375_0 then
				arg_372_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_372_1.var_.moveOldPos1072ui_story, Vector3.New(0, -0.71, -6), (arg_372_1.time_ - 0) / var_375_0)
				arg_372_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_372_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_372_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_372_1.actors_["1072ui_story"].transform.position).z)
				arg_372_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_372_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_372_1.actors_["1072ui_story"].transform.localEulerAngles = arg_372_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_372_1.time_ >= 0 + var_375_0 and arg_372_1.time_ < 0 + var_375_0 + arg_375_0 then
				arg_372_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_372_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_372_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_372_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_372_1.actors_["1072ui_story"].transform.position).z)
				arg_372_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_372_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_372_1.actors_["1072ui_story"].transform.localEulerAngles = arg_372_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if 0 < arg_372_1.time_ and arg_372_1.time_ <= 0 + arg_375_0 then
				arg_372_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_375_1 = 0
			local var_375_2 = 1.175

			if 0 < arg_372_1.time_ and arg_372_1.time_ <= var_375_1 + arg_375_0 then
				arg_372_1.talkMaxDuration = 0
				arg_372_1.dialogCg_.alpha = 1

				arg_372_1.dialog_:SetActive(true)
				SetActive(arg_372_1.leftNameGo_, true)

				arg_372_1.leftNameTxt_.text = arg_372_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_372_1.leftNameTxt_.transform)

				arg_372_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_372_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_372_1:RecordName(arg_372_1.leftNameTxt_.text)
				SetActive(arg_372_1.iconTrs_.gameObject, false)
				arg_372_1.callingController_:SetSelectedState("normal")

				local var_375_3 = arg_372_1:GetWordFromCfg(221031088)
				local var_375_4 = arg_372_1:FormatText(var_375_3.content)

				arg_372_1.text_.text = var_375_4

				LuaForUtil.ClearLinePrefixSymbol(arg_372_1.text_)

				local var_375_6 = 47 <= 0 and var_375_2 or var_375_2 * (utf8.len(var_375_4) / 47)

				if (47 <= 0 and var_375_2 or var_375_2 * (utf8.len(var_375_4) / 47)) > 0 and var_375_2 < var_375_6 then
					arg_372_1.talkMaxDuration = var_375_6

					if var_375_6 + var_375_1 > arg_372_1.duration_ then
						arg_372_1.duration_ = var_375_6 + var_375_1
					end
				end

				arg_372_1.text_.text = var_375_4
				arg_372_1.typewritter.percent = 0

				arg_372_1.typewritter:SetDirty()
				arg_372_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221031", "221031088", "story_v_out_221031.awb") ~= 0 then
					local var_375_7 = manager.audio:GetVoiceLength("story_v_out_221031", "221031088", "story_v_out_221031.awb") / 1000

					if var_375_7 + var_375_1 > arg_372_1.duration_ then
						arg_372_1.duration_ = var_375_7 + var_375_1
					end

					if var_375_3.prefab_name ~= "" and arg_372_1.actors_[var_375_3.prefab_name] ~= nil then
						local var_375_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_372_1.actors_[var_375_3.prefab_name].transform, "story_v_out_221031", "221031088", "story_v_out_221031.awb")

						arg_372_1:RecordAudio("221031088", var_375_8)
						arg_372_1:RecordAudio("221031088", var_375_8)
					else
						arg_372_1:AudioAction("play", "voice", "story_v_out_221031", "221031088", "story_v_out_221031.awb")
					end

					arg_372_1:RecordHistoryTalkVoice("story_v_out_221031", "221031088", "story_v_out_221031.awb")
				end

				arg_372_1:RecordContent(arg_372_1.text_.text)
			end

			local var_375_9 = math.max(var_375_2, arg_372_1.talkMaxDuration)

			if var_375_1 <= arg_372_1.time_ and arg_372_1.time_ < var_375_1 + var_375_9 then
				arg_372_1.typewritter.percent = (arg_372_1.time_ - var_375_1) / var_375_9

				arg_372_1.typewritter:SetDirty()
			end

			if arg_372_1.time_ >= var_375_1 + var_375_9 and arg_372_1.time_ < var_375_1 + var_375_9 + arg_375_0 then
				arg_372_1.typewritter.percent = 1

				arg_372_1.typewritter:SetDirty()
				arg_372_1:ShowNextGo(true)
			end
		end

		arg_372_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_372_1:InitPlayNodeList()
	end,
	Play221031089 = function(arg_376_0, arg_376_1)
		arg_376_1.time_ = 0
		arg_376_1.frameCnt_ = 0
		arg_376_1.state_ = "playing"
		arg_376_1.curTalkId_ = 221031089
		arg_376_1.duration_ = 5.37

		local var_376_0 = {
			ja = 5.366,
			ko = 3.233,
			zh = 3.233
		}
		local var_376_1 = manager.audio:GetLocalizationFlag()

		if var_376_0[var_376_1] ~= nil then
			arg_376_1.duration_ = var_376_0[var_376_1]
		end

		SetActive(arg_376_1.tipsGo_, false)

		function arg_376_1.onSingleLineFinish_()
			arg_376_1.onSingleLineUpdate_ = nil
			arg_376_1.onSingleLineFinish_ = nil
			arg_376_1.state_ = "waiting"
		end

		function arg_376_1.playNext_(arg_378_0)
			if arg_378_0 == 1 then
				arg_376_0:Play221031090(arg_376_1)
			end
		end

		function arg_376_1.onSingleLineUpdate_(arg_379_0)
			if 0 < arg_376_1.time_ and arg_376_1.time_ <= 0 + arg_379_0 then
				arg_376_1.var_.moveOldPos1072ui_story = arg_376_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_379_0 = 0.001

			if 0 <= arg_376_1.time_ and arg_376_1.time_ < 0 + var_379_0 then
				arg_376_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_376_1.var_.moveOldPos1072ui_story, Vector3.New(0, -0.71, -6), (arg_376_1.time_ - 0) / var_379_0)
				arg_376_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_376_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_376_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_376_1.actors_["1072ui_story"].transform.position).z)
				arg_376_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_376_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_376_1.actors_["1072ui_story"].transform.localEulerAngles = arg_376_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_376_1.time_ >= 0 + var_379_0 and arg_376_1.time_ < 0 + var_379_0 + arg_379_0 then
				arg_376_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_376_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_376_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_376_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_376_1.actors_["1072ui_story"].transform.position).z)
				arg_376_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_376_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_376_1.actors_["1072ui_story"].transform.localEulerAngles = arg_376_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if 0 < arg_376_1.time_ and arg_376_1.time_ <= 0 + arg_379_0 then
				arg_376_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action5_2")
			end

			if 0 < arg_376_1.time_ and arg_376_1.time_ <= 0 + arg_379_0 then
				arg_376_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_379_1 = 0
			local var_379_2 = 0.375

			if 0 < arg_376_1.time_ and arg_376_1.time_ <= var_379_1 + arg_379_0 then
				arg_376_1.talkMaxDuration = 0
				arg_376_1.dialogCg_.alpha = 1

				arg_376_1.dialog_:SetActive(true)
				SetActive(arg_376_1.leftNameGo_, true)

				arg_376_1.leftNameTxt_.text = arg_376_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_376_1.leftNameTxt_.transform)

				arg_376_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_376_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_376_1:RecordName(arg_376_1.leftNameTxt_.text)
				SetActive(arg_376_1.iconTrs_.gameObject, false)
				arg_376_1.callingController_:SetSelectedState("normal")

				local var_379_3 = arg_376_1:GetWordFromCfg(221031089)
				local var_379_4 = arg_376_1:FormatText(var_379_3.content)

				arg_376_1.text_.text = var_379_4

				LuaForUtil.ClearLinePrefixSymbol(arg_376_1.text_)

				local var_379_6 = 15 <= 0 and var_379_2 or var_379_2 * (utf8.len(var_379_4) / 15)

				if (15 <= 0 and var_379_2 or var_379_2 * (utf8.len(var_379_4) / 15)) > 0 and var_379_2 < var_379_6 then
					arg_376_1.talkMaxDuration = var_379_6

					if var_379_6 + var_379_1 > arg_376_1.duration_ then
						arg_376_1.duration_ = var_379_6 + var_379_1
					end
				end

				arg_376_1.text_.text = var_379_4
				arg_376_1.typewritter.percent = 0

				arg_376_1.typewritter:SetDirty()
				arg_376_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221031", "221031089", "story_v_out_221031.awb") ~= 0 then
					local var_379_7 = manager.audio:GetVoiceLength("story_v_out_221031", "221031089", "story_v_out_221031.awb") / 1000

					if var_379_7 + var_379_1 > arg_376_1.duration_ then
						arg_376_1.duration_ = var_379_7 + var_379_1
					end

					if var_379_3.prefab_name ~= "" and arg_376_1.actors_[var_379_3.prefab_name] ~= nil then
						local var_379_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_376_1.actors_[var_379_3.prefab_name].transform, "story_v_out_221031", "221031089", "story_v_out_221031.awb")

						arg_376_1:RecordAudio("221031089", var_379_8)
						arg_376_1:RecordAudio("221031089", var_379_8)
					else
						arg_376_1:AudioAction("play", "voice", "story_v_out_221031", "221031089", "story_v_out_221031.awb")
					end

					arg_376_1:RecordHistoryTalkVoice("story_v_out_221031", "221031089", "story_v_out_221031.awb")
				end

				arg_376_1:RecordContent(arg_376_1.text_.text)
			end

			local var_379_9 = math.max(var_379_2, arg_376_1.talkMaxDuration)

			if var_379_1 <= arg_376_1.time_ and arg_376_1.time_ < var_379_1 + var_379_9 then
				arg_376_1.typewritter.percent = (arg_376_1.time_ - var_379_1) / var_379_9

				arg_376_1.typewritter:SetDirty()
			end

			if arg_376_1.time_ >= var_379_1 + var_379_9 and arg_376_1.time_ < var_379_1 + var_379_9 + arg_379_0 then
				arg_376_1.typewritter.percent = 1

				arg_376_1.typewritter:SetDirty()
				arg_376_1:ShowNextGo(true)
			end
		end

		arg_376_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_376_1:InitPlayNodeList()
	end,
	Play221031090 = function(arg_380_0, arg_380_1)
		arg_380_1.time_ = 0
		arg_380_1.frameCnt_ = 0
		arg_380_1.state_ = "playing"
		arg_380_1.curTalkId_ = 221031090
		arg_380_1.duration_ = 5

		SetActive(arg_380_1.tipsGo_, false)

		function arg_380_1.onSingleLineFinish_()
			arg_380_1.onSingleLineUpdate_ = nil
			arg_380_1.onSingleLineFinish_ = nil
			arg_380_1.state_ = "waiting"
		end

		function arg_380_1.playNext_(arg_382_0)
			if arg_382_0 == 1 then
				arg_380_0:Play221031091(arg_380_1)
			end
		end

		function arg_380_1.onSingleLineUpdate_(arg_383_0)
			if 0 < arg_380_1.time_ and arg_380_1.time_ <= 0 + arg_383_0 and not isNil(arg_380_1.actors_["1072ui_story"]) and arg_380_1.var_.characterEffect1072ui_story == nil then
				arg_380_1.var_.characterEffect1072ui_story = arg_380_1.actors_["1072ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_383_0 = 0.200000002980232

			if 0 <= arg_380_1.time_ and arg_380_1.time_ < 0 + var_383_0 and not isNil(arg_380_1.actors_["1072ui_story"]) then
				if arg_380_1.var_.characterEffect1072ui_story and not isNil(arg_380_1.actors_["1072ui_story"]) then
					arg_380_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_380_1.var_.characterEffect1072ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_380_1.time_ - 0) / var_383_0)
				end
			end

			if arg_380_1.time_ >= 0 + var_383_0 and arg_380_1.time_ < 0 + var_383_0 + arg_383_0 and not isNil(arg_380_1.actors_["1072ui_story"]) and arg_380_1.var_.characterEffect1072ui_story then
				arg_380_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_380_1.var_.characterEffect1072ui_story.fillRatio = 0.5
			end

			local var_383_1 = 0
			local var_383_2 = 0.925

			if 0 < arg_380_1.time_ and arg_380_1.time_ <= var_383_1 + arg_383_0 then
				arg_380_1.talkMaxDuration = 0
				arg_380_1.dialogCg_.alpha = 1

				arg_380_1.dialog_:SetActive(true)
				SetActive(arg_380_1.leftNameGo_, false)

				arg_380_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_380_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_380_1:RecordName(arg_380_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_380_1.iconTrs_.gameObject, false)
				arg_380_1.callingController_:SetSelectedState("normal")

				local var_383_3 = arg_380_1:FormatText(arg_380_1:GetWordFromCfg(221031090).content)

				arg_380_1.text_.text = var_383_3

				LuaForUtil.ClearLinePrefixSymbol(arg_380_1.text_)

				local var_383_5 = 37 <= 0 and var_383_2 or var_383_2 * (utf8.len(var_383_3) / 37)

				if (37 <= 0 and var_383_2 or var_383_2 * (utf8.len(var_383_3) / 37)) > 0 and var_383_2 < var_383_5 then
					arg_380_1.talkMaxDuration = var_383_5

					if var_383_5 + var_383_1 > arg_380_1.duration_ then
						arg_380_1.duration_ = var_383_5 + var_383_1
					end
				end

				arg_380_1.text_.text = var_383_3
				arg_380_1.typewritter.percent = 0

				arg_380_1.typewritter:SetDirty()
				arg_380_1:ShowNextGo(false)
				arg_380_1:RecordContent(arg_380_1.text_.text)
			end

			local var_383_6 = math.max(var_383_2, arg_380_1.talkMaxDuration)

			if var_383_1 <= arg_380_1.time_ and arg_380_1.time_ < var_383_1 + var_383_6 then
				arg_380_1.typewritter.percent = (arg_380_1.time_ - var_383_1) / var_383_6

				arg_380_1.typewritter:SetDirty()
			end

			if arg_380_1.time_ >= var_383_1 + var_383_6 and arg_380_1.time_ < var_383_1 + var_383_6 + arg_383_0 then
				arg_380_1.typewritter.percent = 1

				arg_380_1.typewritter:SetDirty()
				arg_380_1:ShowNextGo(true)
			end
		end

		arg_380_1.nodeConfigList_ = {}

		arg_380_1:InitPlayNodeList()
	end,
	Play221031091 = function(arg_384_0, arg_384_1)
		arg_384_1.time_ = 0
		arg_384_1.frameCnt_ = 0
		arg_384_1.state_ = "playing"
		arg_384_1.curTalkId_ = 221031091
		arg_384_1.duration_ = 8

		local var_384_0 = {
			ja = 8,
			ko = 7.4,
			zh = 7.4
		}
		local var_384_1 = manager.audio:GetLocalizationFlag()

		if var_384_0[var_384_1] ~= nil then
			arg_384_1.duration_ = var_384_0[var_384_1]
		end

		SetActive(arg_384_1.tipsGo_, false)

		function arg_384_1.onSingleLineFinish_()
			arg_384_1.onSingleLineUpdate_ = nil
			arg_384_1.onSingleLineFinish_ = nil
			arg_384_1.state_ = "waiting"
		end

		function arg_384_1.playNext_(arg_386_0)
			if arg_386_0 == 1 then
				arg_384_0:Play221031092(arg_384_1)
			end
		end

		function arg_384_1.onSingleLineUpdate_(arg_387_0)
			local var_387_0 = 0.65

			if 0 < arg_384_1.time_ and arg_384_1.time_ <= 0 + arg_387_0 then
				arg_384_1.talkMaxDuration = 0
				arg_384_1.dialogCg_.alpha = 1

				arg_384_1.dialog_:SetActive(true)
				SetActive(arg_384_1.leftNameGo_, true)

				arg_384_1.leftNameTxt_.text = arg_384_1:FormatText(StoryNameCfg[422].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_384_1.leftNameTxt_.transform)

				arg_384_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_384_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_384_1:RecordName(arg_384_1.leftNameTxt_.text)
				SetActive(arg_384_1.iconTrs_.gameObject, true)
				arg_384_1.iconController_:SetSelectedState("hero")

				arg_384_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_384_1.callingController_:SetSelectedState("normal")

				arg_384_1.keyicon_.color = Color.New(1, 1, 1)
				arg_384_1.icon_.color = Color.New(1, 1, 1)

				local var_387_1 = arg_384_1:GetWordFromCfg(221031091)
				local var_387_2 = arg_384_1:FormatText(var_387_1.content)

				arg_384_1.text_.text = var_387_2

				LuaForUtil.ClearLinePrefixSymbol(arg_384_1.text_)

				local var_387_4 = 26 <= 0 and var_387_0 or var_387_0 * (utf8.len(var_387_2) / 26)

				if (26 <= 0 and var_387_0 or var_387_0 * (utf8.len(var_387_2) / 26)) > 0 and var_387_0 < var_387_4 then
					arg_384_1.talkMaxDuration = var_387_4

					if var_387_4 + 0 > arg_384_1.duration_ then
						arg_384_1.duration_ = var_387_4 + 0
					end
				end

				arg_384_1.text_.text = var_387_2
				arg_384_1.typewritter.percent = 0

				arg_384_1.typewritter:SetDirty()
				arg_384_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221031", "221031091", "story_v_out_221031.awb") ~= 0 then
					local var_387_5 = manager.audio:GetVoiceLength("story_v_out_221031", "221031091", "story_v_out_221031.awb") / 1000

					if var_387_5 + 0 > arg_384_1.duration_ then
						arg_384_1.duration_ = var_387_5 + 0
					end

					if var_387_1.prefab_name ~= "" and arg_384_1.actors_[var_387_1.prefab_name] ~= nil then
						local var_387_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_384_1.actors_[var_387_1.prefab_name].transform, "story_v_out_221031", "221031091", "story_v_out_221031.awb")

						arg_384_1:RecordAudio("221031091", var_387_6)
						arg_384_1:RecordAudio("221031091", var_387_6)
					else
						arg_384_1:AudioAction("play", "voice", "story_v_out_221031", "221031091", "story_v_out_221031.awb")
					end

					arg_384_1:RecordHistoryTalkVoice("story_v_out_221031", "221031091", "story_v_out_221031.awb")
				end

				arg_384_1:RecordContent(arg_384_1.text_.text)
			end

			local var_387_7 = math.max(var_387_0, arg_384_1.talkMaxDuration)

			if 0 <= arg_384_1.time_ and arg_384_1.time_ < 0 + var_387_7 then
				arg_384_1.typewritter.percent = (arg_384_1.time_ - 0) / var_387_7

				arg_384_1.typewritter:SetDirty()
			end

			if arg_384_1.time_ >= 0 + var_387_7 and arg_384_1.time_ < 0 + var_387_7 + arg_387_0 then
				arg_384_1.typewritter.percent = 1

				arg_384_1.typewritter:SetDirty()
				arg_384_1:ShowNextGo(true)
			end
		end

		arg_384_1.nodeConfigList_ = {}

		arg_384_1:InitPlayNodeList()
	end,
	Play221031092 = function(arg_388_0, arg_388_1)
		arg_388_1.time_ = 0
		arg_388_1.frameCnt_ = 0
		arg_388_1.state_ = "playing"
		arg_388_1.curTalkId_ = 221031092
		arg_388_1.duration_ = 2

		SetActive(arg_388_1.tipsGo_, false)

		function arg_388_1.onSingleLineFinish_()
			arg_388_1.onSingleLineUpdate_ = nil
			arg_388_1.onSingleLineFinish_ = nil
			arg_388_1.state_ = "waiting"
		end

		function arg_388_1.playNext_(arg_390_0)
			if arg_390_0 == 1 then
				arg_388_0:Play221031093(arg_388_1)
			end
		end

		function arg_388_1.onSingleLineUpdate_(arg_391_0)
			if 0 < arg_388_1.time_ and arg_388_1.time_ <= 0 + arg_391_0 then
				arg_388_1.var_.moveOldPos1072ui_story = arg_388_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_391_0 = 0.001

			if 0 <= arg_388_1.time_ and arg_388_1.time_ < 0 + var_391_0 then
				arg_388_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_388_1.var_.moveOldPos1072ui_story, Vector3.New(0, -0.71, -6), (arg_388_1.time_ - 0) / var_391_0)
				arg_388_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_388_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_388_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_388_1.actors_["1072ui_story"].transform.position).z)
				arg_388_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_388_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_388_1.actors_["1072ui_story"].transform.localEulerAngles = arg_388_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_388_1.time_ >= 0 + var_391_0 and arg_388_1.time_ < 0 + var_391_0 + arg_391_0 then
				arg_388_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_388_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_388_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_388_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_388_1.actors_["1072ui_story"].transform.position).z)
				arg_388_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_388_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_388_1.actors_["1072ui_story"].transform.localEulerAngles = arg_388_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			local var_391_1 = arg_388_1.actors_["1072ui_story"]

			if 0 < arg_388_1.time_ and arg_388_1.time_ <= 0 + arg_391_0 and not isNil(var_391_1) and arg_388_1.var_.characterEffect1072ui_story == nil then
				arg_388_1.var_.characterEffect1072ui_story = var_391_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_391_2 = 0.200000002980232

			if 0 <= arg_388_1.time_ and arg_388_1.time_ < 0 + var_391_2 and not isNil(var_391_1) then
				if arg_388_1.var_.characterEffect1072ui_story and not isNil(var_391_1) then
					arg_388_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_388_1.time_ >= 0 + var_391_2 and arg_388_1.time_ < 0 + var_391_2 + arg_391_0 and not isNil(var_391_1) and arg_388_1.var_.characterEffect1072ui_story then
				arg_388_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			if 0 < arg_388_1.time_ and arg_388_1.time_ <= 0 + arg_391_0 then
				arg_388_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action2_1")
			end

			if 0 < arg_388_1.time_ and arg_388_1.time_ <= 0 + arg_391_0 then
				arg_388_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_391_4 = 0
			local var_391_5 = 0.075

			if 0 < arg_388_1.time_ and arg_388_1.time_ <= var_391_4 + arg_391_0 then
				arg_388_1.talkMaxDuration = 0
				arg_388_1.dialogCg_.alpha = 1

				arg_388_1.dialog_:SetActive(true)
				SetActive(arg_388_1.leftNameGo_, true)

				arg_388_1.leftNameTxt_.text = arg_388_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_388_1.leftNameTxt_.transform)

				arg_388_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_388_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_388_1:RecordName(arg_388_1.leftNameTxt_.text)
				SetActive(arg_388_1.iconTrs_.gameObject, false)
				arg_388_1.callingController_:SetSelectedState("normal")

				local var_391_6 = arg_388_1:GetWordFromCfg(221031092)
				local var_391_7 = arg_388_1:FormatText(var_391_6.content)

				arg_388_1.text_.text = var_391_7

				LuaForUtil.ClearLinePrefixSymbol(arg_388_1.text_)

				local var_391_9 = 3 <= 0 and var_391_5 or var_391_5 * (utf8.len(var_391_7) / 3)

				if (3 <= 0 and var_391_5 or var_391_5 * (utf8.len(var_391_7) / 3)) > 0 and var_391_5 < var_391_9 then
					arg_388_1.talkMaxDuration = var_391_9

					if var_391_9 + var_391_4 > arg_388_1.duration_ then
						arg_388_1.duration_ = var_391_9 + var_391_4
					end
				end

				arg_388_1.text_.text = var_391_7
				arg_388_1.typewritter.percent = 0

				arg_388_1.typewritter:SetDirty()
				arg_388_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221031", "221031092", "story_v_out_221031.awb") ~= 0 then
					local var_391_10 = manager.audio:GetVoiceLength("story_v_out_221031", "221031092", "story_v_out_221031.awb") / 1000

					if var_391_10 + var_391_4 > arg_388_1.duration_ then
						arg_388_1.duration_ = var_391_10 + var_391_4
					end

					if var_391_6.prefab_name ~= "" and arg_388_1.actors_[var_391_6.prefab_name] ~= nil then
						local var_391_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_388_1.actors_[var_391_6.prefab_name].transform, "story_v_out_221031", "221031092", "story_v_out_221031.awb")

						arg_388_1:RecordAudio("221031092", var_391_11)
						arg_388_1:RecordAudio("221031092", var_391_11)
					else
						arg_388_1:AudioAction("play", "voice", "story_v_out_221031", "221031092", "story_v_out_221031.awb")
					end

					arg_388_1:RecordHistoryTalkVoice("story_v_out_221031", "221031092", "story_v_out_221031.awb")
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

		arg_388_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_388_1:InitPlayNodeList()
	end,
	Play221031093 = function(arg_392_0, arg_392_1)
		arg_392_1.time_ = 0
		arg_392_1.frameCnt_ = 0
		arg_392_1.state_ = "playing"
		arg_392_1.curTalkId_ = 221031093
		arg_392_1.duration_ = 10.3

		local var_392_0 = {
			ja = 10.3,
			ko = 8.633,
			zh = 8.633
		}
		local var_392_1 = manager.audio:GetLocalizationFlag()

		if var_392_0[var_392_1] ~= nil then
			arg_392_1.duration_ = var_392_0[var_392_1]
		end

		SetActive(arg_392_1.tipsGo_, false)

		function arg_392_1.onSingleLineFinish_()
			arg_392_1.onSingleLineUpdate_ = nil
			arg_392_1.onSingleLineFinish_ = nil
			arg_392_1.state_ = "waiting"
		end

		function arg_392_1.playNext_(arg_394_0)
			if arg_394_0 == 1 then
				arg_392_0:Play221031094(arg_392_1)
			end
		end

		function arg_392_1.onSingleLineUpdate_(arg_395_0)
			if 2 < arg_392_1.time_ and arg_392_1.time_ <= 2 + arg_395_0 then
				local var_395_0 = arg_392_1.bgs_.ST31

				arg_392_1.bgs_.ST31.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_395_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_395_1 = var_395_0:GetComponent("SpriteRenderer")

				if var_395_1 and var_395_1.sprite then
					local var_395_2 = 2 * (var_395_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_395_0.transform.localScale = Vector3.New(var_395_2 / var_395_1.sprite.bounds.size.y < var_395_2 * manager.ui.mainCameraCom_.aspect / var_395_1.sprite.bounds.size.x and var_395_2 * manager.ui.mainCameraCom_.aspect / var_395_1.sprite.bounds.size.x or var_395_2 / var_395_1.sprite.bounds.size.y, var_395_2 / var_395_1.sprite.bounds.size.y < var_395_2 * manager.ui.mainCameraCom_.aspect / var_395_1.sprite.bounds.size.x and var_395_2 * manager.ui.mainCameraCom_.aspect / var_395_1.sprite.bounds.size.x or var_395_2 / var_395_1.sprite.bounds.size.y, 0)
				end

				for iter_395_0, iter_395_1 in pairs(arg_392_1.bgs_) do
					if iter_395_0 ~= "ST31" then
						iter_395_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_395_3 = 0

			if 0 < arg_392_1.time_ and arg_392_1.time_ <= var_395_3 + arg_395_0 then
				arg_392_1.mask_.enabled = true
				arg_392_1.mask_.raycastTarget = true

				arg_392_1:SetGaussion(false)
			end

			local var_395_4 = 2

			if var_395_3 <= arg_392_1.time_ and arg_392_1.time_ < var_395_3 + var_395_4 then
				local var_395_5 = Color.New(0, 0, 0)

				var_395_5.a = Mathf.Lerp(0, 1, (arg_392_1.time_ - var_395_3) / var_395_4)
				arg_392_1.mask_.color = var_395_5
			end

			if arg_392_1.time_ >= var_395_3 + var_395_4 and arg_392_1.time_ < var_395_3 + var_395_4 + arg_395_0 then
				local var_395_6 = Color.New(0, 0, 0)

				var_395_6.a = 1
				arg_392_1.mask_.color = var_395_6
			end

			local var_395_7 = 2

			if 2 < arg_392_1.time_ and arg_392_1.time_ <= var_395_7 + arg_395_0 then
				arg_392_1.mask_.enabled = true
				arg_392_1.mask_.raycastTarget = true

				arg_392_1:SetGaussion(false)
			end

			local var_395_8 = 2

			if var_395_7 <= arg_392_1.time_ and arg_392_1.time_ < var_395_7 + var_395_8 then
				local var_395_9 = Color.New(0, 0, 0)

				var_395_9.a = Mathf.Lerp(1, 0, (arg_392_1.time_ - var_395_7) / var_395_8)
				arg_392_1.mask_.color = var_395_9
			end

			if arg_392_1.time_ >= var_395_7 + var_395_8 and arg_392_1.time_ < var_395_7 + var_395_8 + arg_395_0 then
				local var_395_10 = Color.New(0, 0, 0)

				arg_392_1.mask_.enabled = false
				var_395_10.a = 0
				arg_392_1.mask_.color = var_395_10
			end

			local var_395_11 = arg_392_1.actors_["1072ui_story"].transform

			if 4 < arg_392_1.time_ and arg_392_1.time_ <= 4 + arg_395_0 then
				arg_392_1.var_.moveOldPos1072ui_story = var_395_11.localPosition
			end

			local var_395_12 = 0.001

			if 4 <= arg_392_1.time_ and arg_392_1.time_ < 4 + var_395_12 then
				var_395_11.localPosition = Vector3.Lerp(arg_392_1.var_.moveOldPos1072ui_story, Vector3.New(0, -0.71, -6), (arg_392_1.time_ - 4) / var_395_12)
				var_395_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_395_11.position).x, (manager.ui.mainCamera.transform.position - var_395_11.position).y, (manager.ui.mainCamera.transform.position - var_395_11.position).z)
				var_395_11.localEulerAngles.z = 0
				var_395_11.localEulerAngles.x = 0
				var_395_11.localEulerAngles = var_395_11.localEulerAngles
			end

			if arg_392_1.time_ >= 4 + var_395_12 and arg_392_1.time_ < 4 + var_395_12 + arg_395_0 then
				var_395_11.localPosition = Vector3.New(0, -0.71, -6)
				var_395_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_395_11.position).x, (manager.ui.mainCamera.transform.position - var_395_11.position).y, (manager.ui.mainCamera.transform.position - var_395_11.position).z)
				var_395_11.localEulerAngles.z = 0
				var_395_11.localEulerAngles.x = 0
				var_395_11.localEulerAngles = var_395_11.localEulerAngles
			end

			local var_395_13 = arg_392_1.actors_["1072ui_story"]

			if 4 < arg_392_1.time_ and arg_392_1.time_ <= 4 + arg_395_0 and not isNil(var_395_13) and arg_392_1.var_.characterEffect1072ui_story == nil then
				arg_392_1.var_.characterEffect1072ui_story = var_395_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_395_14 = 0.200000002980232

			if 4 <= arg_392_1.time_ and arg_392_1.time_ < 4 + var_395_14 and not isNil(var_395_13) then
				if arg_392_1.var_.characterEffect1072ui_story and not isNil(var_395_13) then
					arg_392_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_392_1.time_ >= 4 + var_395_14 and arg_392_1.time_ < 4 + var_395_14 + arg_395_0 and not isNil(var_395_13) and arg_392_1.var_.characterEffect1072ui_story then
				arg_392_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			if 4 < arg_392_1.time_ and arg_392_1.time_ <= 4 + arg_395_0 then
				arg_392_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action7_1")
			end

			if 4 < arg_392_1.time_ and arg_392_1.time_ <= 4 + arg_395_0 then
				arg_392_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_395_16 = arg_392_1.actors_["1072ui_story"].transform

			if 0 < arg_392_1.time_ and arg_392_1.time_ <= 0 + arg_395_0 then
				arg_392_1.var_.moveOldPos1072ui_story = var_395_16.localPosition
			end

			local var_395_17 = 0.001

			if 0 <= arg_392_1.time_ and arg_392_1.time_ < 0 + var_395_17 then
				var_395_16.localPosition = Vector3.Lerp(arg_392_1.var_.moveOldPos1072ui_story, Vector3.New(0, 100, 0), (arg_392_1.time_ - 0) / var_395_17)
				var_395_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_395_16.position).x, (manager.ui.mainCamera.transform.position - var_395_16.position).y, (manager.ui.mainCamera.transform.position - var_395_16.position).z)
				var_395_16.localEulerAngles.z = 0
				var_395_16.localEulerAngles.x = 0
				var_395_16.localEulerAngles = var_395_16.localEulerAngles
			end

			if arg_392_1.time_ >= 0 + var_395_17 and arg_392_1.time_ < 0 + var_395_17 + arg_395_0 then
				var_395_16.localPosition = Vector3.New(0, 100, 0)
				var_395_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_395_16.position).x, (manager.ui.mainCamera.transform.position - var_395_16.position).y, (manager.ui.mainCamera.transform.position - var_395_16.position).z)
				var_395_16.localEulerAngles.z = 0
				var_395_16.localEulerAngles.x = 0
				var_395_16.localEulerAngles = var_395_16.localEulerAngles
			end

			if 0 < arg_392_1.time_ and arg_392_1.time_ <= 0 + arg_395_0 then
				arg_392_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_395_20 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_392_1.bgmTxt_.text ~= var_395_20 and arg_392_1.bgmTxt_.text ~= "" then
						if arg_392_1.bgmTxt2_.text ~= "" then
							arg_392_1.bgmTxt_.text = arg_392_1.bgmTxt2_.text
						end

						arg_392_1.bgmTxt2_.text = var_395_20

						arg_392_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_392_1.bgmTxt_.text = var_395_20
						arg_392_1.bgmTxt2_.text = var_395_20
					end

					if arg_392_1.bgmTimer then
						arg_392_1.bgmTimer:Stop()

						arg_392_1.bgmTimer = nil
					end

					if arg_392_1.settingData.show_music_name == 1 then
						arg_392_1.musicController:SetSelectedState("show")
						arg_392_1.musicAnimator_:Play("open", 0, 0)

						if arg_392_1.settingData.music_time ~= 0 then
							arg_392_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_392_1.settingData.music_time), function()
								if arg_392_1 == nil or isNil(arg_392_1.bgmTxt_) then
									return
								end

								arg_392_1.musicController:SetSelectedState("hide")
								arg_392_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.833333333333333 < arg_392_1.time_ and arg_392_1.time_ <= 0.833333333333333 + arg_395_0 then
				arg_392_1:AudioAction("play", "music", "bgm_side_daily02", "bgm_side_daily02", "bgm_side_daily02.awb")

				local var_395_23 = manager.audio:GetAudioName("bgm_side_daily02", "bgm_side_daily02")

				if "" ~= "" then
					if arg_392_1.bgmTxt_.text ~= var_395_23 and arg_392_1.bgmTxt_.text ~= "" then
						if arg_392_1.bgmTxt2_.text ~= "" then
							arg_392_1.bgmTxt_.text = arg_392_1.bgmTxt2_.text
						end

						arg_392_1.bgmTxt2_.text = var_395_23

						arg_392_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_392_1.bgmTxt_.text = var_395_23
						arg_392_1.bgmTxt2_.text = var_395_23
					end

					if arg_392_1.bgmTimer then
						arg_392_1.bgmTimer:Stop()

						arg_392_1.bgmTimer = nil
					end

					if arg_392_1.settingData.show_music_name == 1 then
						arg_392_1.musicController:SetSelectedState("show")
						arg_392_1.musicAnimator_:Play("open", 0, 0)

						if arg_392_1.settingData.music_time ~= 0 then
							arg_392_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_392_1.settingData.music_time), function()
								if arg_392_1 == nil or isNil(arg_392_1.bgmTxt_) then
									return
								end

								arg_392_1.musicController:SetSelectedState("hide")
								arg_392_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_392_1.frameCnt_ <= 1 then
				arg_392_1.dialog_:SetActive(false)
			end

			local var_395_24 = 4
			local var_395_25 = 0.425

			if 4 < arg_392_1.time_ and arg_392_1.time_ <= var_395_24 + arg_395_0 then
				arg_392_1.talkMaxDuration = 0

				arg_392_1.dialog_:SetActive(true)

				arg_392_1.dialogCg_.alpha = 0

				local var_395_26 = LeanTween.value(arg_392_1.dialog_, 0, 1, 0.3)

				var_395_26:setOnUpdate(LuaHelper.FloatAction(function(arg_398_0)
					arg_392_1.dialogCg_.alpha = arg_398_0
				end))
				var_395_26:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_392_1.dialog_)
					var_395_26:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_392_1.duration_ = arg_392_1.duration_ + 0.3

				SetActive(arg_392_1.leftNameGo_, true)

				arg_392_1.leftNameTxt_.text = arg_392_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_392_1.leftNameTxt_.transform)

				arg_392_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_392_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_392_1:RecordName(arg_392_1.leftNameTxt_.text)
				SetActive(arg_392_1.iconTrs_.gameObject, false)
				arg_392_1.callingController_:SetSelectedState("normal")

				local var_395_27 = arg_392_1:GetWordFromCfg(221031093)
				local var_395_28 = arg_392_1:FormatText(var_395_27.content)

				arg_392_1.text_.text = var_395_28

				LuaForUtil.ClearLinePrefixSymbol(arg_392_1.text_)

				local var_395_30 = 17 <= 0 and var_395_25 or var_395_25 * (utf8.len(var_395_28) / 17)

				if (17 <= 0 and var_395_25 or var_395_25 * (utf8.len(var_395_28) / 17)) > 0 and var_395_25 < var_395_30 then
					arg_392_1.talkMaxDuration = var_395_30
					var_395_24 = var_395_24 + 0.3

					if var_395_30 + var_395_24 > arg_392_1.duration_ then
						arg_392_1.duration_ = var_395_30 + var_395_24
					end
				end

				arg_392_1.text_.text = var_395_28
				arg_392_1.typewritter.percent = 0

				arg_392_1.typewritter:SetDirty()
				arg_392_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221031", "221031093", "story_v_out_221031.awb") ~= 0 then
					local var_395_31 = manager.audio:GetVoiceLength("story_v_out_221031", "221031093", "story_v_out_221031.awb") / 1000

					if var_395_31 + var_395_24 > arg_392_1.duration_ then
						arg_392_1.duration_ = var_395_31 + var_395_24
					end

					if var_395_27.prefab_name ~= "" and arg_392_1.actors_[var_395_27.prefab_name] ~= nil then
						local var_395_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_392_1.actors_[var_395_27.prefab_name].transform, "story_v_out_221031", "221031093", "story_v_out_221031.awb")

						arg_392_1:RecordAudio("221031093", var_395_32)
						arg_392_1:RecordAudio("221031093", var_395_32)
					else
						arg_392_1:AudioAction("play", "voice", "story_v_out_221031", "221031093", "story_v_out_221031.awb")
					end

					arg_392_1:RecordHistoryTalkVoice("story_v_out_221031", "221031093", "story_v_out_221031.awb")
				end

				arg_392_1:RecordContent(arg_392_1.text_.text)
			end

			local var_395_33 = var_395_24 + 0.3
			local var_395_34 = math.max(var_395_25, arg_392_1.talkMaxDuration)

			if var_395_24 + 0.3 <= arg_392_1.time_ and arg_392_1.time_ < var_395_33 + var_395_34 then
				arg_392_1.typewritter.percent = (arg_392_1.time_ - var_395_33) / var_395_34

				arg_392_1.typewritter:SetDirty()
			end

			if arg_392_1.time_ >= var_395_33 + var_395_34 and arg_392_1.time_ < var_395_33 + var_395_34 + arg_395_0 then
				arg_392_1.typewritter.percent = 1

				arg_392_1.typewritter:SetDirty()
				arg_392_1:ShowNextGo(true)
			end
		end

		arg_392_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 4,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_392_1:InitPlayNodeList()
	end,
	Play221031094 = function(arg_400_0, arg_400_1)
		arg_400_1.time_ = 0
		arg_400_1.frameCnt_ = 0
		arg_400_1.state_ = "playing"
		arg_400_1.curTalkId_ = 221031094
		arg_400_1.duration_ = 5

		SetActive(arg_400_1.tipsGo_, false)

		function arg_400_1.onSingleLineFinish_()
			arg_400_1.onSingleLineUpdate_ = nil
			arg_400_1.onSingleLineFinish_ = nil
			arg_400_1.state_ = "waiting"
		end

		function arg_400_1.playNext_(arg_402_0)
			if arg_402_0 == 1 then
				arg_400_0:Play221031095(arg_400_1)
			end
		end

		function arg_400_1.onSingleLineUpdate_(arg_403_0)
			if 0 < arg_400_1.time_ and arg_400_1.time_ <= 0 + arg_403_0 and not isNil(arg_400_1.actors_["1072ui_story"]) and arg_400_1.var_.characterEffect1072ui_story == nil then
				arg_400_1.var_.characterEffect1072ui_story = arg_400_1.actors_["1072ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_403_0 = 0.200000002980232

			if 0 <= arg_400_1.time_ and arg_400_1.time_ < 0 + var_403_0 and not isNil(arg_400_1.actors_["1072ui_story"]) then
				if arg_400_1.var_.characterEffect1072ui_story and not isNil(arg_400_1.actors_["1072ui_story"]) then
					arg_400_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_400_1.var_.characterEffect1072ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_400_1.time_ - 0) / var_403_0)
				end
			end

			if arg_400_1.time_ >= 0 + var_403_0 and arg_400_1.time_ < 0 + var_403_0 + arg_403_0 and not isNil(arg_400_1.actors_["1072ui_story"]) and arg_400_1.var_.characterEffect1072ui_story then
				arg_400_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_400_1.var_.characterEffect1072ui_story.fillRatio = 0.5
			end

			local var_403_1 = 0
			local var_403_2 = 0.475

			if 0 < arg_400_1.time_ and arg_400_1.time_ <= var_403_1 + arg_403_0 then
				arg_400_1.talkMaxDuration = 0
				arg_400_1.dialogCg_.alpha = 1

				arg_400_1.dialog_:SetActive(true)
				SetActive(arg_400_1.leftNameGo_, false)

				arg_400_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_400_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_400_1:RecordName(arg_400_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_400_1.iconTrs_.gameObject, false)
				arg_400_1.callingController_:SetSelectedState("normal")

				local var_403_3 = arg_400_1:FormatText(arg_400_1:GetWordFromCfg(221031094).content)

				arg_400_1.text_.text = var_403_3

				LuaForUtil.ClearLinePrefixSymbol(arg_400_1.text_)

				local var_403_5 = 19 <= 0 and var_403_2 or var_403_2 * (utf8.len(var_403_3) / 19)

				if (19 <= 0 and var_403_2 or var_403_2 * (utf8.len(var_403_3) / 19)) > 0 and var_403_2 < var_403_5 then
					arg_400_1.talkMaxDuration = var_403_5

					if var_403_5 + var_403_1 > arg_400_1.duration_ then
						arg_400_1.duration_ = var_403_5 + var_403_1
					end
				end

				arg_400_1.text_.text = var_403_3
				arg_400_1.typewritter.percent = 0

				arg_400_1.typewritter:SetDirty()
				arg_400_1:ShowNextGo(false)
				arg_400_1:RecordContent(arg_400_1.text_.text)
			end

			local var_403_6 = math.max(var_403_2, arg_400_1.talkMaxDuration)

			if var_403_1 <= arg_400_1.time_ and arg_400_1.time_ < var_403_1 + var_403_6 then
				arg_400_1.typewritter.percent = (arg_400_1.time_ - var_403_1) / var_403_6

				arg_400_1.typewritter:SetDirty()
			end

			if arg_400_1.time_ >= var_403_1 + var_403_6 and arg_400_1.time_ < var_403_1 + var_403_6 + arg_403_0 then
				arg_400_1.typewritter.percent = 1

				arg_400_1.typewritter:SetDirty()
				arg_400_1:ShowNextGo(true)
			end
		end

		arg_400_1.nodeConfigList_ = {}

		arg_400_1:InitPlayNodeList()
	end,
	Play221031095 = function(arg_404_0, arg_404_1)
		arg_404_1.time_ = 0
		arg_404_1.frameCnt_ = 0
		arg_404_1.state_ = "playing"
		arg_404_1.curTalkId_ = 221031095
		arg_404_1.duration_ = 7.63

		local var_404_0 = {
			ja = 5.2,
			ko = 7.633,
			zh = 7.633
		}
		local var_404_1 = manager.audio:GetLocalizationFlag()

		if var_404_0[var_404_1] ~= nil then
			arg_404_1.duration_ = var_404_0[var_404_1]
		end

		SetActive(arg_404_1.tipsGo_, false)

		function arg_404_1.onSingleLineFinish_()
			arg_404_1.onSingleLineUpdate_ = nil
			arg_404_1.onSingleLineFinish_ = nil
			arg_404_1.state_ = "waiting"
		end

		function arg_404_1.playNext_(arg_406_0)
			if arg_406_0 == 1 then
				arg_404_0:Play221031096(arg_404_1)
			end
		end

		function arg_404_1.onSingleLineUpdate_(arg_407_0)
			if 0 < arg_404_1.time_ and arg_404_1.time_ <= 0 + arg_407_0 then
				arg_404_1.var_.moveOldPos1072ui_story = arg_404_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_407_0 = 0.001

			if 0 <= arg_404_1.time_ and arg_404_1.time_ < 0 + var_407_0 then
				arg_404_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_404_1.var_.moveOldPos1072ui_story, Vector3.New(0, -0.71, -6), (arg_404_1.time_ - 0) / var_407_0)
				arg_404_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_404_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_404_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_404_1.actors_["1072ui_story"].transform.position).z)
				arg_404_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_404_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_404_1.actors_["1072ui_story"].transform.localEulerAngles = arg_404_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_404_1.time_ >= 0 + var_407_0 and arg_404_1.time_ < 0 + var_407_0 + arg_407_0 then
				arg_404_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_404_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_404_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_404_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_404_1.actors_["1072ui_story"].transform.position).z)
				arg_404_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_404_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_404_1.actors_["1072ui_story"].transform.localEulerAngles = arg_404_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			local var_407_1 = arg_404_1.actors_["1072ui_story"]

			if 0 < arg_404_1.time_ and arg_404_1.time_ <= 0 + arg_407_0 and not isNil(var_407_1) and arg_404_1.var_.characterEffect1072ui_story == nil then
				arg_404_1.var_.characterEffect1072ui_story = var_407_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_407_2 = 0.200000002980232

			if 0 <= arg_404_1.time_ and arg_404_1.time_ < 0 + var_407_2 and not isNil(var_407_1) then
				if arg_404_1.var_.characterEffect1072ui_story and not isNil(var_407_1) then
					arg_404_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_404_1.time_ >= 0 + var_407_2 and arg_404_1.time_ < 0 + var_407_2 + arg_407_0 and not isNil(var_407_1) and arg_404_1.var_.characterEffect1072ui_story then
				arg_404_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			if 0 < arg_404_1.time_ and arg_404_1.time_ <= 0 + arg_407_0 then
				arg_404_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0202cva")
			end

			local var_407_4 = 0
			local var_407_5 = 0.725

			if 0 < arg_404_1.time_ and arg_404_1.time_ <= var_407_4 + arg_407_0 then
				arg_404_1.talkMaxDuration = 0
				arg_404_1.dialogCg_.alpha = 1

				arg_404_1.dialog_:SetActive(true)
				SetActive(arg_404_1.leftNameGo_, true)

				arg_404_1.leftNameTxt_.text = arg_404_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_404_1.leftNameTxt_.transform)

				arg_404_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_404_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_404_1:RecordName(arg_404_1.leftNameTxt_.text)
				SetActive(arg_404_1.iconTrs_.gameObject, false)
				arg_404_1.callingController_:SetSelectedState("normal")

				local var_407_6 = arg_404_1:GetWordFromCfg(221031095)
				local var_407_7 = arg_404_1:FormatText(var_407_6.content)

				arg_404_1.text_.text = var_407_7

				LuaForUtil.ClearLinePrefixSymbol(arg_404_1.text_)

				local var_407_9 = 29 <= 0 and var_407_5 or var_407_5 * (utf8.len(var_407_7) / 29)

				if (29 <= 0 and var_407_5 or var_407_5 * (utf8.len(var_407_7) / 29)) > 0 and var_407_5 < var_407_9 then
					arg_404_1.talkMaxDuration = var_407_9

					if var_407_9 + var_407_4 > arg_404_1.duration_ then
						arg_404_1.duration_ = var_407_9 + var_407_4
					end
				end

				arg_404_1.text_.text = var_407_7
				arg_404_1.typewritter.percent = 0

				arg_404_1.typewritter:SetDirty()
				arg_404_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221031", "221031095", "story_v_out_221031.awb") ~= 0 then
					local var_407_10 = manager.audio:GetVoiceLength("story_v_out_221031", "221031095", "story_v_out_221031.awb") / 1000

					if var_407_10 + var_407_4 > arg_404_1.duration_ then
						arg_404_1.duration_ = var_407_10 + var_407_4
					end

					if var_407_6.prefab_name ~= "" and arg_404_1.actors_[var_407_6.prefab_name] ~= nil then
						local var_407_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_404_1.actors_[var_407_6.prefab_name].transform, "story_v_out_221031", "221031095", "story_v_out_221031.awb")

						arg_404_1:RecordAudio("221031095", var_407_11)
						arg_404_1:RecordAudio("221031095", var_407_11)
					else
						arg_404_1:AudioAction("play", "voice", "story_v_out_221031", "221031095", "story_v_out_221031.awb")
					end

					arg_404_1:RecordHistoryTalkVoice("story_v_out_221031", "221031095", "story_v_out_221031.awb")
				end

				arg_404_1:RecordContent(arg_404_1.text_.text)
			end

			local var_407_12 = math.max(var_407_5, arg_404_1.talkMaxDuration)

			if var_407_4 <= arg_404_1.time_ and arg_404_1.time_ < var_407_4 + var_407_12 then
				arg_404_1.typewritter.percent = (arg_404_1.time_ - var_407_4) / var_407_12

				arg_404_1.typewritter:SetDirty()
			end

			if arg_404_1.time_ >= var_407_4 + var_407_12 and arg_404_1.time_ < var_407_4 + var_407_12 + arg_407_0 then
				arg_404_1.typewritter.percent = 1

				arg_404_1.typewritter:SetDirty()
				arg_404_1:ShowNextGo(true)
			end
		end

		arg_404_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_404_1:InitPlayNodeList()
	end,
	Play221031096 = function(arg_408_0, arg_408_1)
		arg_408_1.time_ = 0
		arg_408_1.frameCnt_ = 0
		arg_408_1.state_ = "playing"
		arg_408_1.curTalkId_ = 221031096
		arg_408_1.duration_ = 9.3

		local var_408_0 = {
			ja = 7.7,
			ko = 9.3,
			zh = 9.3
		}
		local var_408_1 = manager.audio:GetLocalizationFlag()

		if var_408_0[var_408_1] ~= nil then
			arg_408_1.duration_ = var_408_0[var_408_1]
		end

		SetActive(arg_408_1.tipsGo_, false)

		function arg_408_1.onSingleLineFinish_()
			arg_408_1.onSingleLineUpdate_ = nil
			arg_408_1.onSingleLineFinish_ = nil
			arg_408_1.state_ = "waiting"
		end

		function arg_408_1.playNext_(arg_410_0)
			if arg_410_0 == 1 then
				arg_408_0:Play221031097(arg_408_1)
			end
		end

		function arg_408_1.onSingleLineUpdate_(arg_411_0)
			if 0 < arg_408_1.time_ and arg_408_1.time_ <= 0 + arg_411_0 then
				arg_408_1.var_.moveOldPos1072ui_story = arg_408_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_411_0 = 0.001

			if 0 <= arg_408_1.time_ and arg_408_1.time_ < 0 + var_411_0 then
				arg_408_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_408_1.var_.moveOldPos1072ui_story, Vector3.New(0, -0.71, -6), (arg_408_1.time_ - 0) / var_411_0)
				arg_408_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_408_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_408_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_408_1.actors_["1072ui_story"].transform.position).z)
				arg_408_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_408_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_408_1.actors_["1072ui_story"].transform.localEulerAngles = arg_408_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_408_1.time_ >= 0 + var_411_0 and arg_408_1.time_ < 0 + var_411_0 + arg_411_0 then
				arg_408_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_408_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_408_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_408_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_408_1.actors_["1072ui_story"].transform.position).z)
				arg_408_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_408_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_408_1.actors_["1072ui_story"].transform.localEulerAngles = arg_408_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if 0 < arg_408_1.time_ and arg_408_1.time_ <= 0 + arg_411_0 then
				arg_408_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action7_2")
			end

			if 0 < arg_408_1.time_ and arg_408_1.time_ <= 0 + arg_411_0 then
				arg_408_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_411_1 = 0
			local var_411_2 = 1.275

			if 0 < arg_408_1.time_ and arg_408_1.time_ <= var_411_1 + arg_411_0 then
				arg_408_1.talkMaxDuration = 0
				arg_408_1.dialogCg_.alpha = 1

				arg_408_1.dialog_:SetActive(true)
				SetActive(arg_408_1.leftNameGo_, true)

				arg_408_1.leftNameTxt_.text = arg_408_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_408_1.leftNameTxt_.transform)

				arg_408_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_408_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_408_1:RecordName(arg_408_1.leftNameTxt_.text)
				SetActive(arg_408_1.iconTrs_.gameObject, false)
				arg_408_1.callingController_:SetSelectedState("normal")

				local var_411_3 = arg_408_1:GetWordFromCfg(221031096)
				local var_411_4 = arg_408_1:FormatText(var_411_3.content)

				arg_408_1.text_.text = var_411_4

				LuaForUtil.ClearLinePrefixSymbol(arg_408_1.text_)

				local var_411_6 = 50 <= 0 and var_411_2 or var_411_2 * (utf8.len(var_411_4) / 50)

				if (50 <= 0 and var_411_2 or var_411_2 * (utf8.len(var_411_4) / 50)) > 0 and var_411_2 < var_411_6 then
					arg_408_1.talkMaxDuration = var_411_6

					if var_411_6 + var_411_1 > arg_408_1.duration_ then
						arg_408_1.duration_ = var_411_6 + var_411_1
					end
				end

				arg_408_1.text_.text = var_411_4
				arg_408_1.typewritter.percent = 0

				arg_408_1.typewritter:SetDirty()
				arg_408_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221031", "221031096", "story_v_out_221031.awb") ~= 0 then
					local var_411_7 = manager.audio:GetVoiceLength("story_v_out_221031", "221031096", "story_v_out_221031.awb") / 1000

					if var_411_7 + var_411_1 > arg_408_1.duration_ then
						arg_408_1.duration_ = var_411_7 + var_411_1
					end

					if var_411_3.prefab_name ~= "" and arg_408_1.actors_[var_411_3.prefab_name] ~= nil then
						local var_411_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_408_1.actors_[var_411_3.prefab_name].transform, "story_v_out_221031", "221031096", "story_v_out_221031.awb")

						arg_408_1:RecordAudio("221031096", var_411_8)
						arg_408_1:RecordAudio("221031096", var_411_8)
					else
						arg_408_1:AudioAction("play", "voice", "story_v_out_221031", "221031096", "story_v_out_221031.awb")
					end

					arg_408_1:RecordHistoryTalkVoice("story_v_out_221031", "221031096", "story_v_out_221031.awb")
				end

				arg_408_1:RecordContent(arg_408_1.text_.text)
			end

			local var_411_9 = math.max(var_411_2, arg_408_1.talkMaxDuration)

			if var_411_1 <= arg_408_1.time_ and arg_408_1.time_ < var_411_1 + var_411_9 then
				arg_408_1.typewritter.percent = (arg_408_1.time_ - var_411_1) / var_411_9

				arg_408_1.typewritter:SetDirty()
			end

			if arg_408_1.time_ >= var_411_1 + var_411_9 and arg_408_1.time_ < var_411_1 + var_411_9 + arg_411_0 then
				arg_408_1.typewritter.percent = 1

				arg_408_1.typewritter:SetDirty()
				arg_408_1:ShowNextGo(true)
			end
		end

		arg_408_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_408_1:InitPlayNodeList()
	end,
	Play221031097 = function(arg_412_0, arg_412_1)
		arg_412_1.time_ = 0
		arg_412_1.frameCnt_ = 0
		arg_412_1.state_ = "playing"
		arg_412_1.curTalkId_ = 221031097
		arg_412_1.duration_ = 7.83

		local var_412_0 = {
			ja = 7.833,
			ko = 3.3,
			zh = 3.3
		}
		local var_412_1 = manager.audio:GetLocalizationFlag()

		if var_412_0[var_412_1] ~= nil then
			arg_412_1.duration_ = var_412_0[var_412_1]
		end

		SetActive(arg_412_1.tipsGo_, false)

		function arg_412_1.onSingleLineFinish_()
			arg_412_1.onSingleLineUpdate_ = nil
			arg_412_1.onSingleLineFinish_ = nil
			arg_412_1.state_ = "waiting"
		end

		function arg_412_1.playNext_(arg_414_0)
			if arg_414_0 == 1 then
				arg_412_0:Play221031098(arg_412_1)
			end
		end

		function arg_412_1.onSingleLineUpdate_(arg_415_0)
			if 0 < arg_412_1.time_ and arg_412_1.time_ <= 0 + arg_415_0 then
				arg_412_1.var_.moveOldPos1072ui_story = arg_412_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_415_0 = 0.001

			if 0 <= arg_412_1.time_ and arg_412_1.time_ < 0 + var_415_0 then
				arg_412_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_412_1.var_.moveOldPos1072ui_story, Vector3.New(0, -0.71, -6), (arg_412_1.time_ - 0) / var_415_0)
				arg_412_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_412_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_412_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_412_1.actors_["1072ui_story"].transform.position).z)
				arg_412_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_412_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_412_1.actors_["1072ui_story"].transform.localEulerAngles = arg_412_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_412_1.time_ >= 0 + var_415_0 and arg_412_1.time_ < 0 + var_415_0 + arg_415_0 then
				arg_412_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_412_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_412_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_412_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_412_1.actors_["1072ui_story"].transform.position).z)
				arg_412_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_412_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_412_1.actors_["1072ui_story"].transform.localEulerAngles = arg_412_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if 0 < arg_412_1.time_ and arg_412_1.time_ <= 0 + arg_415_0 then
				arg_412_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action5_1")
			end

			if 0 < arg_412_1.time_ and arg_412_1.time_ <= 0 + arg_415_0 then
				arg_412_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_415_1 = 0
			local var_415_2 = 0.375

			if 0 < arg_412_1.time_ and arg_412_1.time_ <= var_415_1 + arg_415_0 then
				arg_412_1.talkMaxDuration = 0
				arg_412_1.dialogCg_.alpha = 1

				arg_412_1.dialog_:SetActive(true)
				SetActive(arg_412_1.leftNameGo_, true)

				arg_412_1.leftNameTxt_.text = arg_412_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_412_1.leftNameTxt_.transform)

				arg_412_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_412_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_412_1:RecordName(arg_412_1.leftNameTxt_.text)
				SetActive(arg_412_1.iconTrs_.gameObject, false)
				arg_412_1.callingController_:SetSelectedState("normal")

				local var_415_3 = arg_412_1:GetWordFromCfg(221031097)
				local var_415_4 = arg_412_1:FormatText(var_415_3.content)

				arg_412_1.text_.text = var_415_4

				LuaForUtil.ClearLinePrefixSymbol(arg_412_1.text_)

				local var_415_6 = 15 <= 0 and var_415_2 or var_415_2 * (utf8.len(var_415_4) / 15)

				if (15 <= 0 and var_415_2 or var_415_2 * (utf8.len(var_415_4) / 15)) > 0 and var_415_2 < var_415_6 then
					arg_412_1.talkMaxDuration = var_415_6

					if var_415_6 + var_415_1 > arg_412_1.duration_ then
						arg_412_1.duration_ = var_415_6 + var_415_1
					end
				end

				arg_412_1.text_.text = var_415_4
				arg_412_1.typewritter.percent = 0

				arg_412_1.typewritter:SetDirty()
				arg_412_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221031", "221031097", "story_v_out_221031.awb") ~= 0 then
					local var_415_7 = manager.audio:GetVoiceLength("story_v_out_221031", "221031097", "story_v_out_221031.awb") / 1000

					if var_415_7 + var_415_1 > arg_412_1.duration_ then
						arg_412_1.duration_ = var_415_7 + var_415_1
					end

					if var_415_3.prefab_name ~= "" and arg_412_1.actors_[var_415_3.prefab_name] ~= nil then
						local var_415_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_412_1.actors_[var_415_3.prefab_name].transform, "story_v_out_221031", "221031097", "story_v_out_221031.awb")

						arg_412_1:RecordAudio("221031097", var_415_8)
						arg_412_1:RecordAudio("221031097", var_415_8)
					else
						arg_412_1:AudioAction("play", "voice", "story_v_out_221031", "221031097", "story_v_out_221031.awb")
					end

					arg_412_1:RecordHistoryTalkVoice("story_v_out_221031", "221031097", "story_v_out_221031.awb")
				end

				arg_412_1:RecordContent(arg_412_1.text_.text)
			end

			local var_415_9 = math.max(var_415_2, arg_412_1.talkMaxDuration)

			if var_415_1 <= arg_412_1.time_ and arg_412_1.time_ < var_415_1 + var_415_9 then
				arg_412_1.typewritter.percent = (arg_412_1.time_ - var_415_1) / var_415_9

				arg_412_1.typewritter:SetDirty()
			end

			if arg_412_1.time_ >= var_415_1 + var_415_9 and arg_412_1.time_ < var_415_1 + var_415_9 + arg_415_0 then
				arg_412_1.typewritter.percent = 1

				arg_412_1.typewritter:SetDirty()
				arg_412_1:ShowNextGo(true)
			end
		end

		arg_412_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_412_1:InitPlayNodeList()
	end,
	Play221031098 = function(arg_416_0, arg_416_1)
		arg_416_1.time_ = 0
		arg_416_1.frameCnt_ = 0
		arg_416_1.state_ = "playing"
		arg_416_1.curTalkId_ = 221031098
		arg_416_1.duration_ = 7.9

		local var_416_0 = {
			ja = 7.9,
			ko = 2.7,
			zh = 2.7
		}
		local var_416_1 = manager.audio:GetLocalizationFlag()

		if var_416_0[var_416_1] ~= nil then
			arg_416_1.duration_ = var_416_0[var_416_1]
		end

		SetActive(arg_416_1.tipsGo_, false)

		function arg_416_1.onSingleLineFinish_()
			arg_416_1.onSingleLineUpdate_ = nil
			arg_416_1.onSingleLineFinish_ = nil
			arg_416_1.state_ = "waiting"
		end

		function arg_416_1.playNext_(arg_418_0)
			if arg_418_0 == 1 then
				arg_416_0:Play221031099(arg_416_1)
			end
		end

		function arg_416_1.onSingleLineUpdate_(arg_419_0)
			if 0 < arg_416_1.time_ and arg_416_1.time_ <= 0 + arg_419_0 then
				arg_416_1.var_.moveOldPos1072ui_story = arg_416_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_419_0 = 0.001

			if 0 <= arg_416_1.time_ and arg_416_1.time_ < 0 + var_419_0 then
				arg_416_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_416_1.var_.moveOldPos1072ui_story, Vector3.New(0, -0.71, -6), (arg_416_1.time_ - 0) / var_419_0)
				arg_416_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_416_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_416_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_416_1.actors_["1072ui_story"].transform.position).z)
				arg_416_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_416_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_416_1.actors_["1072ui_story"].transform.localEulerAngles = arg_416_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_416_1.time_ >= 0 + var_419_0 and arg_416_1.time_ < 0 + var_419_0 + arg_419_0 then
				arg_416_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_416_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_416_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_416_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_416_1.actors_["1072ui_story"].transform.position).z)
				arg_416_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_416_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_416_1.actors_["1072ui_story"].transform.localEulerAngles = arg_416_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if 0 < arg_416_1.time_ and arg_416_1.time_ <= 0 + arg_419_0 then
				arg_416_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_419_1 = 0
			local var_419_2 = 0.15

			if 0 < arg_416_1.time_ and arg_416_1.time_ <= var_419_1 + arg_419_0 then
				arg_416_1.talkMaxDuration = 0
				arg_416_1.dialogCg_.alpha = 1

				arg_416_1.dialog_:SetActive(true)
				SetActive(arg_416_1.leftNameGo_, true)

				arg_416_1.leftNameTxt_.text = arg_416_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_416_1.leftNameTxt_.transform)

				arg_416_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_416_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_416_1:RecordName(arg_416_1.leftNameTxt_.text)
				SetActive(arg_416_1.iconTrs_.gameObject, false)
				arg_416_1.callingController_:SetSelectedState("normal")

				local var_419_3 = arg_416_1:GetWordFromCfg(221031098)
				local var_419_4 = arg_416_1:FormatText(var_419_3.content)

				arg_416_1.text_.text = var_419_4

				LuaForUtil.ClearLinePrefixSymbol(arg_416_1.text_)

				local var_419_6 = 6 <= 0 and var_419_2 or var_419_2 * (utf8.len(var_419_4) / 6)

				if (6 <= 0 and var_419_2 or var_419_2 * (utf8.len(var_419_4) / 6)) > 0 and var_419_2 < var_419_6 then
					arg_416_1.talkMaxDuration = var_419_6

					if var_419_6 + var_419_1 > arg_416_1.duration_ then
						arg_416_1.duration_ = var_419_6 + var_419_1
					end
				end

				arg_416_1.text_.text = var_419_4
				arg_416_1.typewritter.percent = 0

				arg_416_1.typewritter:SetDirty()
				arg_416_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221031", "221031098", "story_v_out_221031.awb") ~= 0 then
					local var_419_7 = manager.audio:GetVoiceLength("story_v_out_221031", "221031098", "story_v_out_221031.awb") / 1000

					if var_419_7 + var_419_1 > arg_416_1.duration_ then
						arg_416_1.duration_ = var_419_7 + var_419_1
					end

					if var_419_3.prefab_name ~= "" and arg_416_1.actors_[var_419_3.prefab_name] ~= nil then
						local var_419_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_416_1.actors_[var_419_3.prefab_name].transform, "story_v_out_221031", "221031098", "story_v_out_221031.awb")

						arg_416_1:RecordAudio("221031098", var_419_8)
						arg_416_1:RecordAudio("221031098", var_419_8)
					else
						arg_416_1:AudioAction("play", "voice", "story_v_out_221031", "221031098", "story_v_out_221031.awb")
					end

					arg_416_1:RecordHistoryTalkVoice("story_v_out_221031", "221031098", "story_v_out_221031.awb")
				end

				arg_416_1:RecordContent(arg_416_1.text_.text)
			end

			local var_419_9 = math.max(var_419_2, arg_416_1.talkMaxDuration)

			if var_419_1 <= arg_416_1.time_ and arg_416_1.time_ < var_419_1 + var_419_9 then
				arg_416_1.typewritter.percent = (arg_416_1.time_ - var_419_1) / var_419_9

				arg_416_1.typewritter:SetDirty()
			end

			if arg_416_1.time_ >= var_419_1 + var_419_9 and arg_416_1.time_ < var_419_1 + var_419_9 + arg_419_0 then
				arg_416_1.typewritter.percent = 1

				arg_416_1.typewritter:SetDirty()
				arg_416_1:ShowNextGo(true)
			end
		end

		arg_416_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_416_1:InitPlayNodeList()
	end,
	Play221031099 = function(arg_420_0, arg_420_1)
		arg_420_1.time_ = 0
		arg_420_1.frameCnt_ = 0
		arg_420_1.state_ = "playing"
		arg_420_1.curTalkId_ = 221031099
		arg_420_1.duration_ = 5

		SetActive(arg_420_1.tipsGo_, false)

		function arg_420_1.onSingleLineFinish_()
			arg_420_1.onSingleLineUpdate_ = nil
			arg_420_1.onSingleLineFinish_ = nil
			arg_420_1.state_ = "waiting"
		end

		function arg_420_1.playNext_(arg_422_0)
			if arg_422_0 == 1 then
				arg_420_0:Play221031100(arg_420_1)
			end
		end

		function arg_420_1.onSingleLineUpdate_(arg_423_0)
			if 0 < arg_420_1.time_ and arg_420_1.time_ <= 0 + arg_423_0 and not isNil(arg_420_1.actors_["1072ui_story"]) and arg_420_1.var_.characterEffect1072ui_story == nil then
				arg_420_1.var_.characterEffect1072ui_story = arg_420_1.actors_["1072ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_423_0 = 0.200000002980232

			if 0 <= arg_420_1.time_ and arg_420_1.time_ < 0 + var_423_0 and not isNil(arg_420_1.actors_["1072ui_story"]) then
				if arg_420_1.var_.characterEffect1072ui_story and not isNil(arg_420_1.actors_["1072ui_story"]) then
					arg_420_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_420_1.var_.characterEffect1072ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_420_1.time_ - 0) / var_423_0)
				end
			end

			if arg_420_1.time_ >= 0 + var_423_0 and arg_420_1.time_ < 0 + var_423_0 + arg_423_0 and not isNil(arg_420_1.actors_["1072ui_story"]) and arg_420_1.var_.characterEffect1072ui_story then
				arg_420_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_420_1.var_.characterEffect1072ui_story.fillRatio = 0.5
			end

			local var_423_1 = arg_420_1.actors_["1072ui_story"].transform

			if 0 < arg_420_1.time_ and arg_420_1.time_ <= 0 + arg_423_0 then
				arg_420_1.var_.moveOldPos1072ui_story = var_423_1.localPosition
			end

			local var_423_2 = 0.001

			if 0 <= arg_420_1.time_ and arg_420_1.time_ < 0 + var_423_2 then
				var_423_1.localPosition = Vector3.Lerp(arg_420_1.var_.moveOldPos1072ui_story, Vector3.New(0, 100, 0), (arg_420_1.time_ - 0) / var_423_2)
				var_423_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_423_1.position).x, (manager.ui.mainCamera.transform.position - var_423_1.position).y, (manager.ui.mainCamera.transform.position - var_423_1.position).z)
				var_423_1.localEulerAngles.z = 0
				var_423_1.localEulerAngles.x = 0
				var_423_1.localEulerAngles = var_423_1.localEulerAngles
			end

			if arg_420_1.time_ >= 0 + var_423_2 and arg_420_1.time_ < 0 + var_423_2 + arg_423_0 then
				var_423_1.localPosition = Vector3.New(0, 100, 0)
				var_423_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_423_1.position).x, (manager.ui.mainCamera.transform.position - var_423_1.position).y, (manager.ui.mainCamera.transform.position - var_423_1.position).z)
				var_423_1.localEulerAngles.z = 0
				var_423_1.localEulerAngles.x = 0
				var_423_1.localEulerAngles = var_423_1.localEulerAngles
			end

			local var_423_3 = 0
			local var_423_4 = 0.6

			if 0 < arg_420_1.time_ and arg_420_1.time_ <= var_423_3 + arg_423_0 then
				arg_420_1.talkMaxDuration = 0
				arg_420_1.dialogCg_.alpha = 1

				arg_420_1.dialog_:SetActive(true)
				SetActive(arg_420_1.leftNameGo_, false)

				arg_420_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_420_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_420_1:RecordName(arg_420_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_420_1.iconTrs_.gameObject, false)
				arg_420_1.callingController_:SetSelectedState("normal")

				local var_423_5 = arg_420_1:FormatText(arg_420_1:GetWordFromCfg(221031099).content)

				arg_420_1.text_.text = var_423_5

				LuaForUtil.ClearLinePrefixSymbol(arg_420_1.text_)

				local var_423_7 = 24 <= 0 and var_423_4 or var_423_4 * (utf8.len(var_423_5) / 24)

				if (24 <= 0 and var_423_4 or var_423_4 * (utf8.len(var_423_5) / 24)) > 0 and var_423_4 < var_423_7 then
					arg_420_1.talkMaxDuration = var_423_7

					if var_423_7 + var_423_3 > arg_420_1.duration_ then
						arg_420_1.duration_ = var_423_7 + var_423_3
					end
				end

				arg_420_1.text_.text = var_423_5
				arg_420_1.typewritter.percent = 0

				arg_420_1.typewritter:SetDirty()
				arg_420_1:ShowNextGo(false)
				arg_420_1:RecordContent(arg_420_1.text_.text)
			end

			local var_423_8 = math.max(var_423_4, arg_420_1.talkMaxDuration)

			if var_423_3 <= arg_420_1.time_ and arg_420_1.time_ < var_423_3 + var_423_8 then
				arg_420_1.typewritter.percent = (arg_420_1.time_ - var_423_3) / var_423_8

				arg_420_1.typewritter:SetDirty()
			end

			if arg_420_1.time_ >= var_423_3 + var_423_8 and arg_420_1.time_ < var_423_3 + var_423_8 + arg_423_0 then
				arg_420_1.typewritter.percent = 1

				arg_420_1.typewritter:SetDirty()
				arg_420_1:ShowNextGo(true)
			end
		end

		arg_420_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_420_1:InitPlayNodeList()
	end,
	Play221031100 = function(arg_424_0, arg_424_1)
		arg_424_1.time_ = 0
		arg_424_1.frameCnt_ = 0
		arg_424_1.state_ = "playing"
		arg_424_1.curTalkId_ = 221031100
		arg_424_1.duration_ = 5

		SetActive(arg_424_1.tipsGo_, false)

		function arg_424_1.onSingleLineFinish_()
			arg_424_1.onSingleLineUpdate_ = nil
			arg_424_1.onSingleLineFinish_ = nil
			arg_424_1.state_ = "waiting"
			arg_424_1.auto_ = false
		end

		function arg_424_1.playNext_(arg_426_0)
			arg_424_1.onStoryFinished_()
		end

		function arg_424_1.onSingleLineUpdate_(arg_427_0)
			local var_427_0 = 0.55

			if 0 < arg_424_1.time_ and arg_424_1.time_ <= 0 + arg_427_0 then
				arg_424_1.talkMaxDuration = 0
				arg_424_1.dialogCg_.alpha = 1

				arg_424_1.dialog_:SetActive(true)
				SetActive(arg_424_1.leftNameGo_, false)

				arg_424_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_424_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_424_1:RecordName(arg_424_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_424_1.iconTrs_.gameObject, false)
				arg_424_1.callingController_:SetSelectedState("normal")

				local var_427_1 = arg_424_1:FormatText(arg_424_1:GetWordFromCfg(221031100).content)

				arg_424_1.text_.text = var_427_1

				LuaForUtil.ClearLinePrefixSymbol(arg_424_1.text_)

				local var_427_3 = 22 <= 0 and var_427_0 or var_427_0 * (utf8.len(var_427_1) / 22)

				if (22 <= 0 and var_427_0 or var_427_0 * (utf8.len(var_427_1) / 22)) > 0 and var_427_0 < var_427_3 then
					arg_424_1.talkMaxDuration = var_427_3

					if var_427_3 + 0 > arg_424_1.duration_ then
						arg_424_1.duration_ = var_427_3 + 0
					end
				end

				arg_424_1.text_.text = var_427_1
				arg_424_1.typewritter.percent = 0

				arg_424_1.typewritter:SetDirty()
				arg_424_1:ShowNextGo(false)
				arg_424_1:RecordContent(arg_424_1.text_.text)
			end

			local var_427_4 = math.max(var_427_0, arg_424_1.talkMaxDuration)

			if 0 <= arg_424_1.time_ and arg_424_1.time_ < 0 + var_427_4 then
				arg_424_1.typewritter.percent = (arg_424_1.time_ - 0) / var_427_4

				arg_424_1.typewritter:SetDirty()
			end

			if arg_424_1.time_ >= 0 + var_427_4 and arg_424_1.time_ < 0 + var_427_4 + arg_427_0 then
				arg_424_1.typewritter.percent = 1

				arg_424_1.typewritter:SetDirty()
				arg_424_1:ShowNextGo(true)
			end
		end

		arg_424_1.nodeConfigList_ = {}

		arg_424_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST31",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/ST29",
		"TextureConfig/Background/ST39",
		"TextureConfig/Background/XH0801",
		"TextureConfig/Background/XH0805"
	},
	voices = {
		"story_v_out_221031.awb"
	}
}
