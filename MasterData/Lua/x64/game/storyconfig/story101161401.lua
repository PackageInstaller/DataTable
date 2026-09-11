return {
	Play116141001 = function(arg_1_0, arg_1_1)
		arg_1_1.marker = "Mark1"
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 116141001
		arg_1_1.duration_ = 9.7

		local var_1_0 = {
			zh = 9.69999999999999,
			ja = 9.19999999999999
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
			arg_1_1.marker = ""

			if arg_3_0 == 1 then
				arg_1_0:Play116141002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.ST07b == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST07b")
				var_4_0.name = "ST07b"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.ST07b = var_4_0
			end

			if 3.666667 < arg_1_1.time_ and arg_1_1.time_ <= 3.666667 + arg_4_0 then
				if arg_1_0.sceneSettingEffect_ then
					arg_1_1.sceneSettingEffect_.enabled = false
				end

				arg_1_1.sceneSettingGo_:SetActive(true)

				local var_4_1 = arg_1_1.bgs_.ST07b

				arg_1_1.bgs_.ST07b.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "ST07b" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_4 = "1059ui_story"

			if arg_1_1.actors_["1059ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1059ui_story"))) then
				local var_4_5 = Object.Instantiate(Asset.Load("Char/" .. "1059ui_story"), arg_1_1.stage_.transform)

				var_4_5.name = var_4_4
				var_4_5.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.actors_[var_4_4] = var_4_5

				local var_4_6 = var_4_5:GetComponentInChildren(typeof(CharacterEffect))

				var_4_6.enabled = true

				local var_4_7 = GameObjectTools.GetOrAddComponent(var_4_5, typeof(DynamicBoneHelper))

				if var_4_7 then
					var_4_7:EnableDynamicBone(false)
				end

				arg_1_1:ShowWeapon(var_4_6.transform, false)

				arg_1_1.var_[var_4_4 .. "Animator"] = var_4_6.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_1_1.var_[var_4_4 .. "Animator"].applyRootMotion = true
				arg_1_1.var_[var_4_4 .. "LipSync"] = var_4_6.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_4_8 = arg_1_1.actors_["1059ui_story"].transform

			if 5.63333333333333 < arg_1_1.time_ and arg_1_1.time_ <= 5.63333333333333 + arg_4_0 then
				arg_1_1.var_.moveOldPos1059ui_story = var_4_8.localPosition
			end

			local var_4_9 = 0.001

			if 5.63333333333333 <= arg_1_1.time_ and arg_1_1.time_ < 5.63333333333333 + var_4_9 then
				var_4_8.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1059ui_story, Vector3.New(0, -1.05, -6), (arg_1_1.time_ - 5.63333333333333) / var_4_9)
				var_4_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_8.position).x, (manager.ui.mainCamera.transform.position - var_4_8.position).y, (manager.ui.mainCamera.transform.position - var_4_8.position).z)
				var_4_8.localEulerAngles.z = 0
				var_4_8.localEulerAngles.x = 0
				var_4_8.localEulerAngles = var_4_8.localEulerAngles
			end

			if arg_1_1.time_ >= 5.63333333333333 + var_4_9 and arg_1_1.time_ < 5.63333333333333 + var_4_9 + arg_4_0 then
				var_4_8.localPosition = Vector3.New(0, -1.05, -6)
				var_4_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_8.position).x, (manager.ui.mainCamera.transform.position - var_4_8.position).y, (manager.ui.mainCamera.transform.position - var_4_8.position).z)
				var_4_8.localEulerAngles.z = 0
				var_4_8.localEulerAngles.x = 0
				var_4_8.localEulerAngles = var_4_8.localEulerAngles
			end

			if 5.63333333333333 < arg_1_1.time_ and arg_1_1.time_ <= 5.63333333333333 + arg_4_0 then
				arg_1_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/story1059/story1059action/1059action3_1")
			end

			if 5.63333333333333 < arg_1_1.time_ and arg_1_1.time_ <= 5.63333333333333 + arg_4_0 then
				arg_1_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_4_10 = 3.666667

			if 3.666667 < arg_1_1.time_ and arg_1_1.time_ <= var_4_10 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_11 = 2.133333

			if var_4_10 <= arg_1_1.time_ and arg_1_1.time_ < var_4_10 + var_4_11 then
				local var_4_12 = Color.New(0, 0, 0)

				var_4_12.a = Mathf.Lerp(1, 0, (arg_1_1.time_ - var_4_10) / var_4_11)
				arg_1_1.mask_.color = var_4_12
			end

			if arg_1_1.time_ >= var_4_10 + var_4_11 and arg_1_1.time_ < var_4_10 + var_4_11 + arg_4_0 then
				local var_4_13 = Color.New(0, 0, 0)

				arg_1_1.mask_.enabled = false
				var_4_13.a = 0
				arg_1_1.mask_.color = var_4_13
			end

			local var_4_14 = arg_1_1.actors_["1059ui_story"]

			if 5.63333333333333 < arg_1_1.time_ and arg_1_1.time_ <= 5.63333333333333 + arg_4_0 and not isNil(var_4_14) and arg_1_1.var_.characterEffect1059ui_story == nil then
				arg_1_1.var_.characterEffect1059ui_story = var_4_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_15 = 0.2

			if 5.63333333333333 <= arg_1_1.time_ and arg_1_1.time_ < 5.63333333333333 + var_4_15 and not isNil(var_4_14) then
				if arg_1_1.var_.characterEffect1059ui_story and not isNil(var_4_14) then
					arg_1_1.var_.characterEffect1059ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= 5.63333333333333 + var_4_15 and arg_1_1.time_ < 5.63333333333333 + var_4_15 + arg_4_0 and not isNil(var_4_14) and arg_1_1.var_.characterEffect1059ui_story then
				arg_1_1.var_.characterEffect1059ui_story.fillFlat = false
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

			if 5.8 < arg_1_1.time_ and arg_1_1.time_ <= 5.8 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_side_daily03", "bgm_side_daily03", "bgm_side_daily03.awb")

				local var_4_22 = manager.audio:GetAudioName("bgm_side_daily03", "bgm_side_daily03")

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

			local var_4_23 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_23 + arg_4_0 then
				SetActive(arg_1_1.dialog_, false)
				SetActive(arg_1_1.allBtn_.gameObject, true)
				arg_1_1.hideBtnsController_:SetSelectedIndex(1)

				arg_1_1.marker = "PlayCantSkipVideo"

				manager.video:Play("SofdecAsset/story/story_101161201.usm", function(arg_7_0)
					manager.video:Dispose()
				end, nil, nil, function(arg_8_0)
					arg_1_1.state_ = arg_8_0 and "pause" or "playing"
				end)
				manager.video.transform_:SetSiblingIndex(1)
			end

			local var_4_24 = 3.666667

			if var_4_23 <= arg_1_1.time_ and arg_1_1.time_ < var_4_23 + var_4_24 then
				-- block empty
			end

			if arg_1_1.time_ >= var_4_23 + var_4_24 and arg_1_1.time_ < var_4_23 + var_4_24 + arg_4_0 then
				arg_1_1.marker = ""
			end

			local var_4_25 = 3.666667

			if 3.666667 < arg_1_1.time_ and arg_1_1.time_ <= var_4_25 + arg_4_0 then
				SetActive(arg_1_1.dialog_, true)
				SetActive(arg_1_1.allBtn_.gameObject, true)
				arg_1_1.hideBtnsController_:SetSelectedIndex(0)
				manager.video:Dispose()

				arg_1_1.isInLoopVideo = false
			end

			local var_4_26 = 0.0166666666666667

			if var_4_25 <= arg_1_1.time_ and arg_1_1.time_ < var_4_25 + var_4_26 then
				-- block empty
			end

			if arg_1_1.time_ >= var_4_25 + var_4_26 and arg_1_1.time_ < var_4_25 + var_4_26 + arg_4_0 then
				-- block empty
			end

			local var_4_27 = 5.79999999999999
			local var_4_28 = 0.475

			if 5.79999999999999 < arg_1_1.time_ and arg_1_1.time_ <= var_4_27 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0
				arg_1_1.dialogCg_.alpha = 1

				arg_1_1.dialog_:SetActive(true)
				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_29 = arg_1_1:GetWordFromCfg(116141001)
				local var_4_30 = arg_1_1:FormatText(var_4_29.content)

				arg_1_1.text_.text = var_4_30

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_32 = 19 <= 0 and var_4_28 or var_4_28 * (utf8.len(var_4_30) / 19)

				if (19 <= 0 and var_4_28 or var_4_28 * (utf8.len(var_4_30) / 19)) > 0 and var_4_28 < var_4_32 then
					arg_1_1.talkMaxDuration = var_4_32

					if var_4_32 + var_4_27 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_32 + var_4_27
					end
				end

				arg_1_1.text_.text = var_4_30
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116141", "116141001", "story_v_out_116141.awb") ~= 0 then
					local var_4_33 = manager.audio:GetVoiceLength("story_v_out_116141", "116141001", "story_v_out_116141.awb") / 1000

					if var_4_33 + var_4_27 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_33 + var_4_27
					end

					if var_4_29.prefab_name ~= "" and arg_1_1.actors_[var_4_29.prefab_name] ~= nil then
						local var_4_34 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_29.prefab_name].transform, "story_v_out_116141", "116141001", "story_v_out_116141.awb")

						arg_1_1:RecordAudio("116141001", var_4_34)
						arg_1_1:RecordAudio("116141001", var_4_34)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_116141", "116141001", "story_v_out_116141.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_116141", "116141001", "story_v_out_116141.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_35 = math.max(var_4_28, arg_1_1.talkMaxDuration)

			if var_4_27 <= arg_1_1.time_ and arg_1_1.time_ < var_4_27 + var_4_35 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_27) / var_4_35

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_27 + var_4_35 and arg_1_1.time_ < var_4_27 + var_4_35 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1059ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 5.63333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play116141002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 116141002
		arg_9_1.duration_ = 6.53

		local var_9_0 = {
			zh = 5.3,
			ja = 6.533
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
				arg_9_0:Play116141003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/story1059/story1059actionlink/1059action436")
			end

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0203cva")
			end

			local var_12_0 = 0
			local var_12_1 = 0.65

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_0 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				arg_9_1.leftNameTxt_.text = arg_9_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_2 = arg_9_1:GetWordFromCfg(116141002)
				local var_12_3 = arg_9_1:FormatText(var_12_2.content)

				arg_9_1.text_.text = var_12_3

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_5 = 26 <= 0 and var_12_1 or var_12_1 * (utf8.len(var_12_3) / 26)

				if (26 <= 0 and var_12_1 or var_12_1 * (utf8.len(var_12_3) / 26)) > 0 and var_12_1 < var_12_5 then
					arg_9_1.talkMaxDuration = var_12_5

					if var_12_5 + var_12_0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_5 + var_12_0
					end
				end

				arg_9_1.text_.text = var_12_3
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116141", "116141002", "story_v_out_116141.awb") ~= 0 then
					local var_12_6 = manager.audio:GetVoiceLength("story_v_out_116141", "116141002", "story_v_out_116141.awb") / 1000

					if var_12_6 + var_12_0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_6 + var_12_0
					end

					if var_12_2.prefab_name ~= "" and arg_9_1.actors_[var_12_2.prefab_name] ~= nil then
						local var_12_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_2.prefab_name].transform, "story_v_out_116141", "116141002", "story_v_out_116141.awb")

						arg_9_1:RecordAudio("116141002", var_12_7)
						arg_9_1:RecordAudio("116141002", var_12_7)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_116141", "116141002", "story_v_out_116141.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_116141", "116141002", "story_v_out_116141.awb")
				end

				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_8 = math.max(var_12_1, arg_9_1.talkMaxDuration)

			if var_12_0 <= arg_9_1.time_ and arg_9_1.time_ < var_12_0 + var_12_8 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_0) / var_12_8

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_0 + var_12_8 and arg_9_1.time_ < var_12_0 + var_12_8 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {}

		arg_9_1:InitPlayNodeList()
	end,
	Play116141003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 116141003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play116141004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(arg_13_1.actors_["1059ui_story"]) and arg_13_1.var_.characterEffect1059ui_story == nil then
				arg_13_1.var_.characterEffect1059ui_story = arg_13_1.actors_["1059ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_0 = 0.2

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_0 and not isNil(arg_13_1.actors_["1059ui_story"]) then
				if arg_13_1.var_.characterEffect1059ui_story and not isNil(arg_13_1.actors_["1059ui_story"]) then
					arg_13_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_13_1.var_.characterEffect1059ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_13_1.time_ - 0) / var_16_0)
				end
			end

			if arg_13_1.time_ >= 0 + var_16_0 and arg_13_1.time_ < 0 + var_16_0 + arg_16_0 and not isNil(arg_13_1.actors_["1059ui_story"]) and arg_13_1.var_.characterEffect1059ui_story then
				arg_13_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_13_1.var_.characterEffect1059ui_story.fillRatio = 0.5
			end

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_16_1 = 0
			local var_16_2 = 0.85

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

				local var_16_3 = arg_13_1:FormatText(arg_13_1:GetWordFromCfg(116141003).content)

				arg_13_1.text_.text = var_16_3

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_5 = 34 <= 0 and var_16_2 or var_16_2 * (utf8.len(var_16_3) / 34)

				if (34 <= 0 and var_16_2 or var_16_2 * (utf8.len(var_16_3) / 34)) > 0 and var_16_2 < var_16_5 then
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
	Play116141004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 116141004
		arg_17_1.duration_ = 6.57

		local var_17_0 = {
			zh = 5.933,
			ja = 6.566
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
				arg_17_0:Play116141005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(arg_17_1.actors_["1059ui_story"]) and arg_17_1.var_.characterEffect1059ui_story == nil then
				arg_17_1.var_.characterEffect1059ui_story = arg_17_1.actors_["1059ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_0 = 0.2

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_0 and not isNil(arg_17_1.actors_["1059ui_story"]) then
				if arg_17_1.var_.characterEffect1059ui_story and not isNil(arg_17_1.actors_["1059ui_story"]) then
					arg_17_1.var_.characterEffect1059ui_story.fillFlat = false
				end
			end

			if arg_17_1.time_ >= 0 + var_20_0 and arg_17_1.time_ < 0 + var_20_0 + arg_20_0 and not isNil(arg_17_1.actors_["1059ui_story"]) and arg_17_1.var_.characterEffect1059ui_story then
				arg_17_1.var_.characterEffect1059ui_story.fillFlat = false
			end

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/story1059/story1059actionlink/1059action464")
			end

			local var_20_2 = 0
			local var_20_3 = 0.45

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_2 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_4 = arg_17_1:GetWordFromCfg(116141004)
				local var_20_5 = arg_17_1:FormatText(var_20_4.content)

				arg_17_1.text_.text = var_20_5

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_7 = 18 <= 0 and var_20_3 or var_20_3 * (utf8.len(var_20_5) / 18)

				if (18 <= 0 and var_20_3 or var_20_3 * (utf8.len(var_20_5) / 18)) > 0 and var_20_3 < var_20_7 then
					arg_17_1.talkMaxDuration = var_20_7

					if var_20_7 + var_20_2 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_7 + var_20_2
					end
				end

				arg_17_1.text_.text = var_20_5
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116141", "116141004", "story_v_out_116141.awb") ~= 0 then
					local var_20_8 = manager.audio:GetVoiceLength("story_v_out_116141", "116141004", "story_v_out_116141.awb") / 1000

					if var_20_8 + var_20_2 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_8 + var_20_2
					end

					if var_20_4.prefab_name ~= "" and arg_17_1.actors_[var_20_4.prefab_name] ~= nil then
						local var_20_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_4.prefab_name].transform, "story_v_out_116141", "116141004", "story_v_out_116141.awb")

						arg_17_1:RecordAudio("116141004", var_20_9)
						arg_17_1:RecordAudio("116141004", var_20_9)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_116141", "116141004", "story_v_out_116141.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_116141", "116141004", "story_v_out_116141.awb")
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
	Play116141005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 116141005
		arg_21_1.duration_ = 5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play116141006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1:AudioAction("play", "effect", "se_story_16", "se_story_16_beat", "")
			end

			if 0.85 < arg_21_1.time_ and arg_21_1.time_ <= 0.85 + arg_24_0 then
				arg_21_1:AudioAction("play", "effect", "se_story_16", "se_story_16_door04", "")
			end

			local var_24_2 = arg_21_1.actors_["1059ui_story"].transform

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.var_.moveOldPos1059ui_story = var_24_2.localPosition
			end

			local var_24_3 = 0.001

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_3 then
				var_24_2.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos1059ui_story, Vector3.New(0, 100, 0), (arg_21_1.time_ - 0) / var_24_3)
				var_24_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_24_2.position).x, (manager.ui.mainCamera.transform.position - var_24_2.position).y, (manager.ui.mainCamera.transform.position - var_24_2.position).z)
				var_24_2.localEulerAngles.z = 0
				var_24_2.localEulerAngles.x = 0
				var_24_2.localEulerAngles = var_24_2.localEulerAngles
			end

			if arg_21_1.time_ >= 0 + var_24_3 and arg_21_1.time_ < 0 + var_24_3 + arg_24_0 then
				var_24_2.localPosition = Vector3.New(0, 100, 0)
				var_24_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_24_2.position).x, (manager.ui.mainCamera.transform.position - var_24_2.position).y, (manager.ui.mainCamera.transform.position - var_24_2.position).z)
				var_24_2.localEulerAngles.z = 0
				var_24_2.localEulerAngles.x = 0
				var_24_2.localEulerAngles = var_24_2.localEulerAngles
			end

			local var_24_4 = 0
			local var_24_5 = 0.85

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_4 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, false)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_6 = arg_21_1:FormatText(arg_21_1:GetWordFromCfg(116141005).content)

				arg_21_1.text_.text = var_24_6

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_8 = 34 <= 0 and var_24_5 or var_24_5 * (utf8.len(var_24_6) / 34)

				if (34 <= 0 and var_24_5 or var_24_5 * (utf8.len(var_24_6) / 34)) > 0 and var_24_5 < var_24_8 then
					arg_21_1.talkMaxDuration = var_24_8

					if var_24_8 + var_24_4 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_8 + var_24_4
					end
				end

				arg_21_1.text_.text = var_24_6
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)
				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_9 = math.max(var_24_5, arg_21_1.talkMaxDuration)

			if var_24_4 <= arg_21_1.time_ and arg_21_1.time_ < var_24_4 + var_24_9 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_4) / var_24_9

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_4 + var_24_9 and arg_21_1.time_ < var_24_4 + var_24_9 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {
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

		arg_21_1:InitPlayNodeList()
	end,
	Play116141006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 116141006
		arg_25_1.duration_ = 3.5

		local var_25_0 = {
			zh = 2.166,
			ja = 3.5
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
				arg_25_0:Play116141007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if arg_25_1.actors_["1028ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1028ui_story"))) then
				local var_28_0 = Object.Instantiate(Asset.Load("Char/" .. "1028ui_story"), arg_25_1.stage_.transform)

				var_28_0.name = "1028ui_story"
				var_28_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_25_1.actors_["1028ui_story"] = var_28_0

				local var_28_1 = var_28_0:GetComponentInChildren(typeof(CharacterEffect))

				var_28_1.enabled = true

				local var_28_2 = GameObjectTools.GetOrAddComponent(var_28_0, typeof(DynamicBoneHelper))

				if var_28_2 then
					var_28_2:EnableDynamicBone(false)
				end

				arg_25_1:ShowWeapon(var_28_1.transform, false)

				arg_25_1.var_["1028ui_story" .. "Animator"] = var_28_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_25_1.var_["1028ui_story" .. "Animator"].applyRootMotion = true
				arg_25_1.var_["1028ui_story" .. "LipSync"] = var_28_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_28_3 = arg_25_1.actors_["1028ui_story"].transform

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.var_.moveOldPos1028ui_story = var_28_3.localPosition
			end

			local var_28_4 = 0.001

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_4 then
				var_28_3.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos1028ui_story, Vector3.New(-0.7, -0.9, -5.9), (arg_25_1.time_ - 0) / var_28_4)
				var_28_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_28_3.position).x, (manager.ui.mainCamera.transform.position - var_28_3.position).y, (manager.ui.mainCamera.transform.position - var_28_3.position).z)
				var_28_3.localEulerAngles.z = 0
				var_28_3.localEulerAngles.x = 0
				var_28_3.localEulerAngles = var_28_3.localEulerAngles
			end

			if arg_25_1.time_ >= 0 + var_28_4 and arg_25_1.time_ < 0 + var_28_4 + arg_28_0 then
				var_28_3.localPosition = Vector3.New(-0.7, -0.9, -5.9)
				var_28_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_28_3.position).x, (manager.ui.mainCamera.transform.position - var_28_3.position).y, (manager.ui.mainCamera.transform.position - var_28_3.position).z)
				var_28_3.localEulerAngles.z = 0
				var_28_3.localEulerAngles.x = 0
				var_28_3.localEulerAngles = var_28_3.localEulerAngles
			end

			local var_28_5 = arg_25_1.actors_["1028ui_story"]

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(var_28_5) and arg_25_1.var_.characterEffect1028ui_story == nil then
				arg_25_1.var_.characterEffect1028ui_story = var_28_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_6 = 0.2

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_6 and not isNil(var_28_5) then
				if arg_25_1.var_.characterEffect1028ui_story and not isNil(var_28_5) then
					arg_25_1.var_.characterEffect1028ui_story.fillFlat = false
				end
			end

			if arg_25_1.time_ >= 0 + var_28_6 and arg_25_1.time_ < 0 + var_28_6 + arg_28_0 and not isNil(var_28_5) and arg_25_1.var_.characterEffect1028ui_story then
				arg_25_1.var_.characterEffect1028ui_story.fillFlat = false
			end

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/story1028/story1028action/1028action1_1")
			end

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_28_8 = 0
			local var_28_9 = 0.25

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_8 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_10 = arg_25_1:GetWordFromCfg(116141006)
				local var_28_11 = arg_25_1:FormatText(var_28_10.content)

				arg_25_1.text_.text = var_28_11

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_13 = 10 <= 0 and var_28_9 or var_28_9 * (utf8.len(var_28_11) / 10)

				if (10 <= 0 and var_28_9 or var_28_9 * (utf8.len(var_28_11) / 10)) > 0 and var_28_9 < var_28_13 then
					arg_25_1.talkMaxDuration = var_28_13

					if var_28_13 + var_28_8 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_13 + var_28_8
					end
				end

				arg_25_1.text_.text = var_28_11
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116141", "116141006", "story_v_out_116141.awb") ~= 0 then
					local var_28_14 = manager.audio:GetVoiceLength("story_v_out_116141", "116141006", "story_v_out_116141.awb") / 1000

					if var_28_14 + var_28_8 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_14 + var_28_8
					end

					if var_28_10.prefab_name ~= "" and arg_25_1.actors_[var_28_10.prefab_name] ~= nil then
						local var_28_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_10.prefab_name].transform, "story_v_out_116141", "116141006", "story_v_out_116141.awb")

						arg_25_1:RecordAudio("116141006", var_28_15)
						arg_25_1:RecordAudio("116141006", var_28_15)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_116141", "116141006", "story_v_out_116141.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_116141", "116141006", "story_v_out_116141.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_16 = math.max(var_28_9, arg_25_1.talkMaxDuration)

			if var_28_8 <= arg_25_1.time_ and arg_25_1.time_ < var_28_8 + var_28_16 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_8) / var_28_16

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_8 + var_28_16 and arg_25_1.time_ < var_28_8 + var_28_16 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1028ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0333333333333333,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_25_1:InitPlayNodeList()
	end,
	Play116141007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 116141007
		arg_29_1.duration_ = 6

		local var_29_0 = {
			zh = 6,
			ja = 3.533
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
				arg_29_0:Play116141008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(arg_29_1.actors_["1059ui_story"]) and arg_29_1.var_.characterEffect1059ui_story == nil then
				arg_29_1.var_.characterEffect1059ui_story = arg_29_1.actors_["1059ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_0 = 0.2

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_0 and not isNil(arg_29_1.actors_["1059ui_story"]) then
				if arg_29_1.var_.characterEffect1059ui_story and not isNil(arg_29_1.actors_["1059ui_story"]) then
					arg_29_1.var_.characterEffect1059ui_story.fillFlat = false
				end
			end

			if arg_29_1.time_ >= 0 + var_32_0 and arg_29_1.time_ < 0 + var_32_0 + arg_32_0 and not isNil(arg_29_1.actors_["1059ui_story"]) and arg_29_1.var_.characterEffect1059ui_story then
				arg_29_1.var_.characterEffect1059ui_story.fillFlat = false
			end

			local var_32_2 = arg_29_1.actors_["1028ui_story"]

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(var_32_2) and arg_29_1.var_.characterEffect1028ui_story == nil then
				arg_29_1.var_.characterEffect1028ui_story = var_32_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_3 = 0.2

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_3 and not isNil(var_32_2) then
				if arg_29_1.var_.characterEffect1028ui_story and not isNil(var_32_2) then
					arg_29_1.var_.characterEffect1028ui_story.fillFlat = true
					arg_29_1.var_.characterEffect1028ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_29_1.time_ - 0) / var_32_3)
				end
			end

			if arg_29_1.time_ >= 0 + var_32_3 and arg_29_1.time_ < 0 + var_32_3 + arg_32_0 and not isNil(var_32_2) and arg_29_1.var_.characterEffect1028ui_story then
				arg_29_1.var_.characterEffect1028ui_story.fillFlat = true
				arg_29_1.var_.characterEffect1028ui_story.fillRatio = 0.5
			end

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/story1059/story1059action/1059action1_1")
			end

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_32_4 = arg_29_1.actors_["1059ui_story"].transform

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.var_.moveOldPos1059ui_story = var_32_4.localPosition
			end

			local var_32_5 = 0.001

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_5 then
				var_32_4.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos1059ui_story, Vector3.New(0.7, -1.05, -6), (arg_29_1.time_ - 0) / var_32_5)
				var_32_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_32_4.position).x, (manager.ui.mainCamera.transform.position - var_32_4.position).y, (manager.ui.mainCamera.transform.position - var_32_4.position).z)
				var_32_4.localEulerAngles.z = 0
				var_32_4.localEulerAngles.x = 0
				var_32_4.localEulerAngles = var_32_4.localEulerAngles
			end

			if arg_29_1.time_ >= 0 + var_32_5 and arg_29_1.time_ < 0 + var_32_5 + arg_32_0 then
				var_32_4.localPosition = Vector3.New(0.7, -1.05, -6)
				var_32_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_32_4.position).x, (manager.ui.mainCamera.transform.position - var_32_4.position).y, (manager.ui.mainCamera.transform.position - var_32_4.position).z)
				var_32_4.localEulerAngles.z = 0
				var_32_4.localEulerAngles.x = 0
				var_32_4.localEulerAngles = var_32_4.localEulerAngles
			end

			local var_32_6 = 0
			local var_32_7 = 0.8

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_6 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_8 = arg_29_1:GetWordFromCfg(116141007)
				local var_32_9 = arg_29_1:FormatText(var_32_8.content)

				arg_29_1.text_.text = var_32_9

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_11 = 32 <= 0 and var_32_7 or var_32_7 * (utf8.len(var_32_9) / 32)

				if (32 <= 0 and var_32_7 or var_32_7 * (utf8.len(var_32_9) / 32)) > 0 and var_32_7 < var_32_11 then
					arg_29_1.talkMaxDuration = var_32_11

					if var_32_11 + var_32_6 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_11 + var_32_6
					end
				end

				arg_29_1.text_.text = var_32_9
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116141", "116141007", "story_v_out_116141.awb") ~= 0 then
					local var_32_12 = manager.audio:GetVoiceLength("story_v_out_116141", "116141007", "story_v_out_116141.awb") / 1000

					if var_32_12 + var_32_6 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_12 + var_32_6
					end

					if var_32_8.prefab_name ~= "" and arg_29_1.actors_[var_32_8.prefab_name] ~= nil then
						local var_32_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_8.prefab_name].transform, "story_v_out_116141", "116141007", "story_v_out_116141.awb")

						arg_29_1:RecordAudio("116141007", var_32_13)
						arg_29_1:RecordAudio("116141007", var_32_13)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_116141", "116141007", "story_v_out_116141.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_116141", "116141007", "story_v_out_116141.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_14 = math.max(var_32_7, arg_29_1.talkMaxDuration)

			if var_32_6 <= arg_29_1.time_ and arg_29_1.time_ < var_32_6 + var_32_14 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_6) / var_32_14

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_6 + var_32_14 and arg_29_1.time_ < var_32_6 + var_32_14 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {
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

		arg_29_1:InitPlayNodeList()
	end,
	Play116141008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 116141008
		arg_33_1.duration_ = 5.93

		local var_33_0 = {
			zh = 5.933,
			ja = 4.666
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
				arg_33_0:Play116141009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(arg_33_1.actors_["1028ui_story"]) and arg_33_1.var_.characterEffect1028ui_story == nil then
				arg_33_1.var_.characterEffect1028ui_story = arg_33_1.actors_["1028ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_0 = 0.2

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_0 and not isNil(arg_33_1.actors_["1028ui_story"]) then
				if arg_33_1.var_.characterEffect1028ui_story and not isNil(arg_33_1.actors_["1028ui_story"]) then
					arg_33_1.var_.characterEffect1028ui_story.fillFlat = false
				end
			end

			if arg_33_1.time_ >= 0 + var_36_0 and arg_33_1.time_ < 0 + var_36_0 + arg_36_0 and not isNil(arg_33_1.actors_["1028ui_story"]) and arg_33_1.var_.characterEffect1028ui_story then
				arg_33_1.var_.characterEffect1028ui_story.fillFlat = false
			end

			local var_36_2 = arg_33_1.actors_["1059ui_story"]

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(var_36_2) and arg_33_1.var_.characterEffect1059ui_story == nil then
				arg_33_1.var_.characterEffect1059ui_story = var_36_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_3 = 0.2

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_3 and not isNil(var_36_2) then
				if arg_33_1.var_.characterEffect1059ui_story and not isNil(var_36_2) then
					arg_33_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_33_1.var_.characterEffect1059ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_33_1.time_ - 0) / var_36_3)
				end
			end

			if arg_33_1.time_ >= 0 + var_36_3 and arg_33_1.time_ < 0 + var_36_3 + arg_36_0 and not isNil(var_36_2) and arg_33_1.var_.characterEffect1059ui_story then
				arg_33_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_33_1.var_.characterEffect1059ui_story.fillRatio = 0.5
			end

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_36_4 = 0
			local var_36_5 = 0.675

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_4 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				arg_33_1.leftNameTxt_.text = arg_33_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_6 = arg_33_1:GetWordFromCfg(116141008)
				local var_36_7 = arg_33_1:FormatText(var_36_6.content)

				arg_33_1.text_.text = var_36_7

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_9 = 27 <= 0 and var_36_5 or var_36_5 * (utf8.len(var_36_7) / 27)

				if (27 <= 0 and var_36_5 or var_36_5 * (utf8.len(var_36_7) / 27)) > 0 and var_36_5 < var_36_9 then
					arg_33_1.talkMaxDuration = var_36_9

					if var_36_9 + var_36_4 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_9 + var_36_4
					end
				end

				arg_33_1.text_.text = var_36_7
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116141", "116141008", "story_v_out_116141.awb") ~= 0 then
					local var_36_10 = manager.audio:GetVoiceLength("story_v_out_116141", "116141008", "story_v_out_116141.awb") / 1000

					if var_36_10 + var_36_4 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_10 + var_36_4
					end

					if var_36_6.prefab_name ~= "" and arg_33_1.actors_[var_36_6.prefab_name] ~= nil then
						local var_36_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_6.prefab_name].transform, "story_v_out_116141", "116141008", "story_v_out_116141.awb")

						arg_33_1:RecordAudio("116141008", var_36_11)
						arg_33_1:RecordAudio("116141008", var_36_11)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_116141", "116141008", "story_v_out_116141.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_116141", "116141008", "story_v_out_116141.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_12 = math.max(var_36_5, arg_33_1.talkMaxDuration)

			if var_36_4 <= arg_33_1.time_ and arg_33_1.time_ < var_36_4 + var_36_12 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_4) / var_36_12

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_4 + var_36_12 and arg_33_1.time_ < var_36_4 + var_36_12 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play116141009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 116141009
		arg_37_1.duration_ = 9.13

		local var_37_0 = {
			zh = 8.5,
			ja = 9.133
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
				arg_37_0:Play116141010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(arg_37_1.actors_["1059ui_story"]) and arg_37_1.var_.characterEffect1059ui_story == nil then
				arg_37_1.var_.characterEffect1059ui_story = arg_37_1.actors_["1059ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_0 = 0.2

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_0 and not isNil(arg_37_1.actors_["1059ui_story"]) then
				if arg_37_1.var_.characterEffect1059ui_story and not isNil(arg_37_1.actors_["1059ui_story"]) then
					arg_37_1.var_.characterEffect1059ui_story.fillFlat = false
				end
			end

			if arg_37_1.time_ >= 0 + var_40_0 and arg_37_1.time_ < 0 + var_40_0 + arg_40_0 and not isNil(arg_37_1.actors_["1059ui_story"]) and arg_37_1.var_.characterEffect1059ui_story then
				arg_37_1.var_.characterEffect1059ui_story.fillFlat = false
			end

			local var_40_2 = arg_37_1.actors_["1028ui_story"]

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(var_40_2) and arg_37_1.var_.characterEffect1028ui_story == nil then
				arg_37_1.var_.characterEffect1028ui_story = var_40_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_3 = 0.2

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_3 and not isNil(var_40_2) then
				if arg_37_1.var_.characterEffect1028ui_story and not isNil(var_40_2) then
					arg_37_1.var_.characterEffect1028ui_story.fillFlat = true
					arg_37_1.var_.characterEffect1028ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_37_1.time_ - 0) / var_40_3)
				end
			end

			if arg_37_1.time_ >= 0 + var_40_3 and arg_37_1.time_ < 0 + var_40_3 + arg_40_0 and not isNil(var_40_2) and arg_37_1.var_.characterEffect1028ui_story then
				arg_37_1.var_.characterEffect1028ui_story.fillFlat = true
				arg_37_1.var_.characterEffect1028ui_story.fillRatio = 0.5
			end

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/story1059/story1059action/1059action5_1")
			end

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_40_4 = 0
			local var_40_5 = 1.075

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_4 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				arg_37_1.leftNameTxt_.text = arg_37_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_6 = arg_37_1:GetWordFromCfg(116141009)
				local var_40_7 = arg_37_1:FormatText(var_40_6.content)

				arg_37_1.text_.text = var_40_7

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_9 = 43 <= 0 and var_40_5 or var_40_5 * (utf8.len(var_40_7) / 43)

				if (43 <= 0 and var_40_5 or var_40_5 * (utf8.len(var_40_7) / 43)) > 0 and var_40_5 < var_40_9 then
					arg_37_1.talkMaxDuration = var_40_9

					if var_40_9 + var_40_4 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_9 + var_40_4
					end
				end

				arg_37_1.text_.text = var_40_7
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116141", "116141009", "story_v_out_116141.awb") ~= 0 then
					local var_40_10 = manager.audio:GetVoiceLength("story_v_out_116141", "116141009", "story_v_out_116141.awb") / 1000

					if var_40_10 + var_40_4 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_10 + var_40_4
					end

					if var_40_6.prefab_name ~= "" and arg_37_1.actors_[var_40_6.prefab_name] ~= nil then
						local var_40_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_6.prefab_name].transform, "story_v_out_116141", "116141009", "story_v_out_116141.awb")

						arg_37_1:RecordAudio("116141009", var_40_11)
						arg_37_1:RecordAudio("116141009", var_40_11)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_116141", "116141009", "story_v_out_116141.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_116141", "116141009", "story_v_out_116141.awb")
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
	Play116141010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 116141010
		arg_41_1.duration_ = 8.07

		local var_41_0 = {
			zh = 8.066,
			ja = 7.466
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
				arg_41_0:Play116141011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(arg_41_1.actors_["1028ui_story"]) and arg_41_1.var_.characterEffect1028ui_story == nil then
				arg_41_1.var_.characterEffect1028ui_story = arg_41_1.actors_["1028ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_0 = 0.2

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_0 and not isNil(arg_41_1.actors_["1028ui_story"]) then
				if arg_41_1.var_.characterEffect1028ui_story and not isNil(arg_41_1.actors_["1028ui_story"]) then
					arg_41_1.var_.characterEffect1028ui_story.fillFlat = false
				end
			end

			if arg_41_1.time_ >= 0 + var_44_0 and arg_41_1.time_ < 0 + var_44_0 + arg_44_0 and not isNil(arg_41_1.actors_["1028ui_story"]) and arg_41_1.var_.characterEffect1028ui_story then
				arg_41_1.var_.characterEffect1028ui_story.fillFlat = false
			end

			local var_44_2 = arg_41_1.actors_["1059ui_story"]

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(var_44_2) and arg_41_1.var_.characterEffect1059ui_story == nil then
				arg_41_1.var_.characterEffect1059ui_story = var_44_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_3 = 0.2

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_3 and not isNil(var_44_2) then
				if arg_41_1.var_.characterEffect1059ui_story and not isNil(var_44_2) then
					arg_41_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_41_1.var_.characterEffect1059ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_41_1.time_ - 0) / var_44_3)
				end
			end

			if arg_41_1.time_ >= 0 + var_44_3 and arg_41_1.time_ < 0 + var_44_3 + arg_44_0 and not isNil(var_44_2) and arg_41_1.var_.characterEffect1059ui_story then
				arg_41_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_41_1.var_.characterEffect1059ui_story.fillRatio = 0.5
			end

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_44_4 = 0
			local var_44_5 = 0.775

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_4 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				arg_41_1.leftNameTxt_.text = arg_41_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_6 = arg_41_1:GetWordFromCfg(116141010)
				local var_44_7 = arg_41_1:FormatText(var_44_6.content)

				arg_41_1.text_.text = var_44_7

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_9 = 31 <= 0 and var_44_5 or var_44_5 * (utf8.len(var_44_7) / 31)

				if (31 <= 0 and var_44_5 or var_44_5 * (utf8.len(var_44_7) / 31)) > 0 and var_44_5 < var_44_9 then
					arg_41_1.talkMaxDuration = var_44_9

					if var_44_9 + var_44_4 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_9 + var_44_4
					end
				end

				arg_41_1.text_.text = var_44_7
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116141", "116141010", "story_v_out_116141.awb") ~= 0 then
					local var_44_10 = manager.audio:GetVoiceLength("story_v_out_116141", "116141010", "story_v_out_116141.awb") / 1000

					if var_44_10 + var_44_4 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_10 + var_44_4
					end

					if var_44_6.prefab_name ~= "" and arg_41_1.actors_[var_44_6.prefab_name] ~= nil then
						local var_44_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_6.prefab_name].transform, "story_v_out_116141", "116141010", "story_v_out_116141.awb")

						arg_41_1:RecordAudio("116141010", var_44_11)
						arg_41_1:RecordAudio("116141010", var_44_11)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_116141", "116141010", "story_v_out_116141.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_116141", "116141010", "story_v_out_116141.awb")
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
	Play116141011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 116141011
		arg_45_1.duration_ = 2

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play116141012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 and not isNil(arg_45_1.actors_["1059ui_story"]) and arg_45_1.var_.characterEffect1059ui_story == nil then
				arg_45_1.var_.characterEffect1059ui_story = arg_45_1.actors_["1059ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_0 = 0.2

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_0 and not isNil(arg_45_1.actors_["1059ui_story"]) then
				if arg_45_1.var_.characterEffect1059ui_story and not isNil(arg_45_1.actors_["1059ui_story"]) then
					arg_45_1.var_.characterEffect1059ui_story.fillFlat = false
				end
			end

			if arg_45_1.time_ >= 0 + var_48_0 and arg_45_1.time_ < 0 + var_48_0 + arg_48_0 and not isNil(arg_45_1.actors_["1059ui_story"]) and arg_45_1.var_.characterEffect1059ui_story then
				arg_45_1.var_.characterEffect1059ui_story.fillFlat = false
			end

			local var_48_2 = arg_45_1.actors_["1028ui_story"]

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 and not isNil(var_48_2) and arg_45_1.var_.characterEffect1028ui_story == nil then
				arg_45_1.var_.characterEffect1028ui_story = var_48_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_3 = 0.2

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_3 and not isNil(var_48_2) then
				if arg_45_1.var_.characterEffect1028ui_story and not isNil(var_48_2) then
					arg_45_1.var_.characterEffect1028ui_story.fillFlat = true
					arg_45_1.var_.characterEffect1028ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_45_1.time_ - 0) / var_48_3)
				end
			end

			if arg_45_1.time_ >= 0 + var_48_3 and arg_45_1.time_ < 0 + var_48_3 + arg_48_0 and not isNil(var_48_2) and arg_45_1.var_.characterEffect1028ui_story then
				arg_45_1.var_.characterEffect1028ui_story.fillFlat = true
				arg_45_1.var_.characterEffect1028ui_story.fillRatio = 0.5
			end

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/story1059/story1059actionlink/1059action452")
			end

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_48_4 = 0
			local var_48_5 = 0.1

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_4 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				arg_45_1.leftNameTxt_.text = arg_45_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_6 = arg_45_1:GetWordFromCfg(116141011)
				local var_48_7 = arg_45_1:FormatText(var_48_6.content)

				arg_45_1.text_.text = var_48_7

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_9 = 4 <= 0 and var_48_5 or var_48_5 * (utf8.len(var_48_7) / 4)

				if (4 <= 0 and var_48_5 or var_48_5 * (utf8.len(var_48_7) / 4)) > 0 and var_48_5 < var_48_9 then
					arg_45_1.talkMaxDuration = var_48_9

					if var_48_9 + var_48_4 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_9 + var_48_4
					end
				end

				arg_45_1.text_.text = var_48_7
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116141", "116141011", "story_v_out_116141.awb") ~= 0 then
					local var_48_10 = manager.audio:GetVoiceLength("story_v_out_116141", "116141011", "story_v_out_116141.awb") / 1000

					if var_48_10 + var_48_4 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_10 + var_48_4
					end

					if var_48_6.prefab_name ~= "" and arg_45_1.actors_[var_48_6.prefab_name] ~= nil then
						local var_48_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_6.prefab_name].transform, "story_v_out_116141", "116141011", "story_v_out_116141.awb")

						arg_45_1:RecordAudio("116141011", var_48_11)
						arg_45_1:RecordAudio("116141011", var_48_11)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_116141", "116141011", "story_v_out_116141.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_116141", "116141011", "story_v_out_116141.awb")
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

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play116141012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 116141012
		arg_49_1.duration_ = 2

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play116141013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 and not isNil(arg_49_1.actors_["1028ui_story"]) and arg_49_1.var_.characterEffect1028ui_story == nil then
				arg_49_1.var_.characterEffect1028ui_story = arg_49_1.actors_["1028ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_0 = 0.2

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_0 and not isNil(arg_49_1.actors_["1028ui_story"]) then
				if arg_49_1.var_.characterEffect1028ui_story and not isNil(arg_49_1.actors_["1028ui_story"]) then
					arg_49_1.var_.characterEffect1028ui_story.fillFlat = false
				end
			end

			if arg_49_1.time_ >= 0 + var_52_0 and arg_49_1.time_ < 0 + var_52_0 + arg_52_0 and not isNil(arg_49_1.actors_["1028ui_story"]) and arg_49_1.var_.characterEffect1028ui_story then
				arg_49_1.var_.characterEffect1028ui_story.fillFlat = false
			end

			local var_52_2 = arg_49_1.actors_["1059ui_story"]

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 and not isNil(var_52_2) and arg_49_1.var_.characterEffect1059ui_story == nil then
				arg_49_1.var_.characterEffect1059ui_story = var_52_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_3 = 0.2

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_3 and not isNil(var_52_2) then
				if arg_49_1.var_.characterEffect1059ui_story and not isNil(var_52_2) then
					arg_49_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_49_1.var_.characterEffect1059ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_49_1.time_ - 0) / var_52_3)
				end
			end

			if arg_49_1.time_ >= 0 + var_52_3 and arg_49_1.time_ < 0 + var_52_3 + arg_52_0 and not isNil(var_52_2) and arg_49_1.var_.characterEffect1059ui_story then
				arg_49_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_49_1.var_.characterEffect1059ui_story.fillRatio = 0.5
			end

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/story1028/story1028action/1028action1_1")
			end

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_52_4 = 0
			local var_52_5 = 0.1

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_4 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				arg_49_1.leftNameTxt_.text = arg_49_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_6 = arg_49_1:GetWordFromCfg(116141012)
				local var_52_7 = arg_49_1:FormatText(var_52_6.content)

				arg_49_1.text_.text = var_52_7

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_9 = 4 <= 0 and var_52_5 or var_52_5 * (utf8.len(var_52_7) / 4)

				if (4 <= 0 and var_52_5 or var_52_5 * (utf8.len(var_52_7) / 4)) > 0 and var_52_5 < var_52_9 then
					arg_49_1.talkMaxDuration = var_52_9

					if var_52_9 + var_52_4 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_9 + var_52_4
					end
				end

				arg_49_1.text_.text = var_52_7
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116141", "116141012", "story_v_out_116141.awb") ~= 0 then
					local var_52_10 = manager.audio:GetVoiceLength("story_v_out_116141", "116141012", "story_v_out_116141.awb") / 1000

					if var_52_10 + var_52_4 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_10 + var_52_4
					end

					if var_52_6.prefab_name ~= "" and arg_49_1.actors_[var_52_6.prefab_name] ~= nil then
						local var_52_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_6.prefab_name].transform, "story_v_out_116141", "116141012", "story_v_out_116141.awb")

						arg_49_1:RecordAudio("116141012", var_52_11)
						arg_49_1:RecordAudio("116141012", var_52_11)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_116141", "116141012", "story_v_out_116141.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_116141", "116141012", "story_v_out_116141.awb")
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
	Play116141013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 116141013
		arg_53_1.duration_ = 12.47

		local var_53_0 = {
			zh = 10,
			ja = 12.466
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
				arg_53_0:Play116141014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 and not isNil(arg_53_1.actors_["1059ui_story"]) and arg_53_1.var_.characterEffect1059ui_story == nil then
				arg_53_1.var_.characterEffect1059ui_story = arg_53_1.actors_["1059ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_0 = 0.2

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_0 and not isNil(arg_53_1.actors_["1059ui_story"]) then
				if arg_53_1.var_.characterEffect1059ui_story and not isNil(arg_53_1.actors_["1059ui_story"]) then
					arg_53_1.var_.characterEffect1059ui_story.fillFlat = false
				end
			end

			if arg_53_1.time_ >= 0 + var_56_0 and arg_53_1.time_ < 0 + var_56_0 + arg_56_0 and not isNil(arg_53_1.actors_["1059ui_story"]) and arg_53_1.var_.characterEffect1059ui_story then
				arg_53_1.var_.characterEffect1059ui_story.fillFlat = false
			end

			local var_56_2 = arg_53_1.actors_["1028ui_story"]

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 and not isNil(var_56_2) and arg_53_1.var_.characterEffect1028ui_story == nil then
				arg_53_1.var_.characterEffect1028ui_story = var_56_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_3 = 0.2

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_3 and not isNil(var_56_2) then
				if arg_53_1.var_.characterEffect1028ui_story and not isNil(var_56_2) then
					arg_53_1.var_.characterEffect1028ui_story.fillFlat = true
					arg_53_1.var_.characterEffect1028ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_53_1.time_ - 0) / var_56_3)
				end
			end

			if arg_53_1.time_ >= 0 + var_56_3 and arg_53_1.time_ < 0 + var_56_3 + arg_56_0 and not isNil(var_56_2) and arg_53_1.var_.characterEffect1028ui_story then
				arg_53_1.var_.characterEffect1028ui_story.fillFlat = true
				arg_53_1.var_.characterEffect1028ui_story.fillRatio = 0.5
			end

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/story1059/story1059action/1059action2_2")
			end

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_56_4 = 0
			local var_56_5 = 1.15

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_4 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				arg_53_1.leftNameTxt_.text = arg_53_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_6 = arg_53_1:GetWordFromCfg(116141013)
				local var_56_7 = arg_53_1:FormatText(var_56_6.content)

				arg_53_1.text_.text = var_56_7

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_9 = 46 <= 0 and var_56_5 or var_56_5 * (utf8.len(var_56_7) / 46)

				if (46 <= 0 and var_56_5 or var_56_5 * (utf8.len(var_56_7) / 46)) > 0 and var_56_5 < var_56_9 then
					arg_53_1.talkMaxDuration = var_56_9

					if var_56_9 + var_56_4 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_9 + var_56_4
					end
				end

				arg_53_1.text_.text = var_56_7
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116141", "116141013", "story_v_out_116141.awb") ~= 0 then
					local var_56_10 = manager.audio:GetVoiceLength("story_v_out_116141", "116141013", "story_v_out_116141.awb") / 1000

					if var_56_10 + var_56_4 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_10 + var_56_4
					end

					if var_56_6.prefab_name ~= "" and arg_53_1.actors_[var_56_6.prefab_name] ~= nil then
						local var_56_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_6.prefab_name].transform, "story_v_out_116141", "116141013", "story_v_out_116141.awb")

						arg_53_1:RecordAudio("116141013", var_56_11)
						arg_53_1:RecordAudio("116141013", var_56_11)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_116141", "116141013", "story_v_out_116141.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_116141", "116141013", "story_v_out_116141.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_12 = math.max(var_56_5, arg_53_1.talkMaxDuration)

			if var_56_4 <= arg_53_1.time_ and arg_53_1.time_ < var_56_4 + var_56_12 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_4) / var_56_12

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_4 + var_56_12 and arg_53_1.time_ < var_56_4 + var_56_12 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play116141014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 116141014
		arg_57_1.duration_ = 4.8

		local var_57_0 = {
			zh = 4.8,
			ja = 4.033
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
				arg_57_0:Play116141015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 and not isNil(arg_57_1.actors_["1028ui_story"]) and arg_57_1.var_.characterEffect1028ui_story == nil then
				arg_57_1.var_.characterEffect1028ui_story = arg_57_1.actors_["1028ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_0 = 0.2

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_0 and not isNil(arg_57_1.actors_["1028ui_story"]) then
				if arg_57_1.var_.characterEffect1028ui_story and not isNil(arg_57_1.actors_["1028ui_story"]) then
					arg_57_1.var_.characterEffect1028ui_story.fillFlat = false
				end
			end

			if arg_57_1.time_ >= 0 + var_60_0 and arg_57_1.time_ < 0 + var_60_0 + arg_60_0 and not isNil(arg_57_1.actors_["1028ui_story"]) and arg_57_1.var_.characterEffect1028ui_story then
				arg_57_1.var_.characterEffect1028ui_story.fillFlat = false
			end

			local var_60_2 = arg_57_1.actors_["1059ui_story"]

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 and not isNil(var_60_2) and arg_57_1.var_.characterEffect1059ui_story == nil then
				arg_57_1.var_.characterEffect1059ui_story = var_60_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_3 = 0.2

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_3 and not isNil(var_60_2) then
				if arg_57_1.var_.characterEffect1059ui_story and not isNil(var_60_2) then
					arg_57_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_57_1.var_.characterEffect1059ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_57_1.time_ - 0) / var_60_3)
				end
			end

			if arg_57_1.time_ >= 0 + var_60_3 and arg_57_1.time_ < 0 + var_60_3 + arg_60_0 and not isNil(var_60_2) and arg_57_1.var_.characterEffect1059ui_story then
				arg_57_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_57_1.var_.characterEffect1059ui_story.fillRatio = 0.5
			end

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/story1028/story1028action/1028action5_1")
			end

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_60_4 = 0
			local var_60_5 = 0.575

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_4 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				arg_57_1.leftNameTxt_.text = arg_57_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_6 = arg_57_1:GetWordFromCfg(116141014)
				local var_60_7 = arg_57_1:FormatText(var_60_6.content)

				arg_57_1.text_.text = var_60_7

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_9 = 23 <= 0 and var_60_5 or var_60_5 * (utf8.len(var_60_7) / 23)

				if (23 <= 0 and var_60_5 or var_60_5 * (utf8.len(var_60_7) / 23)) > 0 and var_60_5 < var_60_9 then
					arg_57_1.talkMaxDuration = var_60_9

					if var_60_9 + var_60_4 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_9 + var_60_4
					end
				end

				arg_57_1.text_.text = var_60_7
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116141", "116141014", "story_v_out_116141.awb") ~= 0 then
					local var_60_10 = manager.audio:GetVoiceLength("story_v_out_116141", "116141014", "story_v_out_116141.awb") / 1000

					if var_60_10 + var_60_4 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_10 + var_60_4
					end

					if var_60_6.prefab_name ~= "" and arg_57_1.actors_[var_60_6.prefab_name] ~= nil then
						local var_60_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_6.prefab_name].transform, "story_v_out_116141", "116141014", "story_v_out_116141.awb")

						arg_57_1:RecordAudio("116141014", var_60_11)
						arg_57_1:RecordAudio("116141014", var_60_11)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_116141", "116141014", "story_v_out_116141.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_116141", "116141014", "story_v_out_116141.awb")
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

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play116141015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 116141015
		arg_61_1.duration_ = 5.4

		local var_61_0 = {
			zh = 5.2,
			ja = 5.4
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
				arg_61_0:Play116141016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 and not isNil(arg_61_1.actors_["1059ui_story"]) and arg_61_1.var_.characterEffect1059ui_story == nil then
				arg_61_1.var_.characterEffect1059ui_story = arg_61_1.actors_["1059ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_0 = 0.2

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_0 and not isNil(arg_61_1.actors_["1059ui_story"]) then
				if arg_61_1.var_.characterEffect1059ui_story and not isNil(arg_61_1.actors_["1059ui_story"]) then
					arg_61_1.var_.characterEffect1059ui_story.fillFlat = false
				end
			end

			if arg_61_1.time_ >= 0 + var_64_0 and arg_61_1.time_ < 0 + var_64_0 + arg_64_0 and not isNil(arg_61_1.actors_["1059ui_story"]) and arg_61_1.var_.characterEffect1059ui_story then
				arg_61_1.var_.characterEffect1059ui_story.fillFlat = false
			end

			local var_64_2 = arg_61_1.actors_["1028ui_story"]

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 and not isNil(var_64_2) and arg_61_1.var_.characterEffect1028ui_story == nil then
				arg_61_1.var_.characterEffect1028ui_story = var_64_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_3 = 0.2

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_3 and not isNil(var_64_2) then
				if arg_61_1.var_.characterEffect1028ui_story and not isNil(var_64_2) then
					arg_61_1.var_.characterEffect1028ui_story.fillFlat = true
					arg_61_1.var_.characterEffect1028ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_61_1.time_ - 0) / var_64_3)
				end
			end

			if arg_61_1.time_ >= 0 + var_64_3 and arg_61_1.time_ < 0 + var_64_3 + arg_64_0 and not isNil(var_64_2) and arg_61_1.var_.characterEffect1028ui_story then
				arg_61_1.var_.characterEffect1028ui_story.fillFlat = true
				arg_61_1.var_.characterEffect1028ui_story.fillRatio = 0.5
			end

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/story1059/story1059action/1059action6_1")
			end

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_64_4 = 0
			local var_64_5 = 0.525

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_4 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				arg_61_1.leftNameTxt_.text = arg_61_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_6 = arg_61_1:GetWordFromCfg(116141015)
				local var_64_7 = arg_61_1:FormatText(var_64_6.content)

				arg_61_1.text_.text = var_64_7

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_9 = 21 <= 0 and var_64_5 or var_64_5 * (utf8.len(var_64_7) / 21)

				if (21 <= 0 and var_64_5 or var_64_5 * (utf8.len(var_64_7) / 21)) > 0 and var_64_5 < var_64_9 then
					arg_61_1.talkMaxDuration = var_64_9

					if var_64_9 + var_64_4 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_9 + var_64_4
					end
				end

				arg_61_1.text_.text = var_64_7
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116141", "116141015", "story_v_out_116141.awb") ~= 0 then
					local var_64_10 = manager.audio:GetVoiceLength("story_v_out_116141", "116141015", "story_v_out_116141.awb") / 1000

					if var_64_10 + var_64_4 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_10 + var_64_4
					end

					if var_64_6.prefab_name ~= "" and arg_61_1.actors_[var_64_6.prefab_name] ~= nil then
						local var_64_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_6.prefab_name].transform, "story_v_out_116141", "116141015", "story_v_out_116141.awb")

						arg_61_1:RecordAudio("116141015", var_64_11)
						arg_61_1:RecordAudio("116141015", var_64_11)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_116141", "116141015", "story_v_out_116141.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_116141", "116141015", "story_v_out_116141.awb")
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
	Play116141016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 116141016
		arg_65_1.duration_ = 7.97

		local var_65_0 = {
			zh = 4.566,
			ja = 7.966
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
				arg_65_0:Play116141017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_68_0 = 0
			local var_68_1 = 0.65

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_0 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				arg_65_1.leftNameTxt_.text = arg_65_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_2 = arg_65_1:GetWordFromCfg(116141016)
				local var_68_3 = arg_65_1:FormatText(var_68_2.content)

				arg_65_1.text_.text = var_68_3

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_5 = 26 <= 0 and var_68_1 or var_68_1 * (utf8.len(var_68_3) / 26)

				if (26 <= 0 and var_68_1 or var_68_1 * (utf8.len(var_68_3) / 26)) > 0 and var_68_1 < var_68_5 then
					arg_65_1.talkMaxDuration = var_68_5

					if var_68_5 + var_68_0 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_5 + var_68_0
					end
				end

				arg_65_1.text_.text = var_68_3
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116141", "116141016", "story_v_out_116141.awb") ~= 0 then
					local var_68_6 = manager.audio:GetVoiceLength("story_v_out_116141", "116141016", "story_v_out_116141.awb") / 1000

					if var_68_6 + var_68_0 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_6 + var_68_0
					end

					if var_68_2.prefab_name ~= "" and arg_65_1.actors_[var_68_2.prefab_name] ~= nil then
						local var_68_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_2.prefab_name].transform, "story_v_out_116141", "116141016", "story_v_out_116141.awb")

						arg_65_1:RecordAudio("116141016", var_68_7)
						arg_65_1:RecordAudio("116141016", var_68_7)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_116141", "116141016", "story_v_out_116141.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_116141", "116141016", "story_v_out_116141.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_8 = math.max(var_68_1, arg_65_1.talkMaxDuration)

			if var_68_0 <= arg_65_1.time_ and arg_65_1.time_ < var_68_0 + var_68_8 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_0) / var_68_8

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_0 + var_68_8 and arg_65_1.time_ < var_68_0 + var_68_8 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play116141017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 116141017
		arg_69_1.duration_ = 7.03

		local var_69_0 = {
			zh = 7.033,
			ja = 4.6
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
				arg_69_0:Play116141018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 and not isNil(arg_69_1.actors_["1028ui_story"]) and arg_69_1.var_.characterEffect1028ui_story == nil then
				arg_69_1.var_.characterEffect1028ui_story = arg_69_1.actors_["1028ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_0 = 0.2

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_0 and not isNil(arg_69_1.actors_["1028ui_story"]) then
				if arg_69_1.var_.characterEffect1028ui_story and not isNil(arg_69_1.actors_["1028ui_story"]) then
					arg_69_1.var_.characterEffect1028ui_story.fillFlat = false
				end
			end

			if arg_69_1.time_ >= 0 + var_72_0 and arg_69_1.time_ < 0 + var_72_0 + arg_72_0 and not isNil(arg_69_1.actors_["1028ui_story"]) and arg_69_1.var_.characterEffect1028ui_story then
				arg_69_1.var_.characterEffect1028ui_story.fillFlat = false
			end

			local var_72_2 = arg_69_1.actors_["1059ui_story"]

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 and not isNil(var_72_2) and arg_69_1.var_.characterEffect1059ui_story == nil then
				arg_69_1.var_.characterEffect1059ui_story = var_72_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_3 = 0.2

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_3 and not isNil(var_72_2) then
				if arg_69_1.var_.characterEffect1059ui_story and not isNil(var_72_2) then
					arg_69_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_69_1.var_.characterEffect1059ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_69_1.time_ - 0) / var_72_3)
				end
			end

			if arg_69_1.time_ >= 0 + var_72_3 and arg_69_1.time_ < 0 + var_72_3 + arg_72_0 and not isNil(var_72_2) and arg_69_1.var_.characterEffect1059ui_story then
				arg_69_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_69_1.var_.characterEffect1059ui_story.fillRatio = 0.5
			end

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/story1028/story1028actionlink/1028action456")
			end

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_72_4 = 0
			local var_72_5 = 0.45

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_4 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				arg_69_1.leftNameTxt_.text = arg_69_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_6 = arg_69_1:GetWordFromCfg(116141017)
				local var_72_7 = arg_69_1:FormatText(var_72_6.content)

				arg_69_1.text_.text = var_72_7

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_9 = 18 <= 0 and var_72_5 or var_72_5 * (utf8.len(var_72_7) / 18)

				if (18 <= 0 and var_72_5 or var_72_5 * (utf8.len(var_72_7) / 18)) > 0 and var_72_5 < var_72_9 then
					arg_69_1.talkMaxDuration = var_72_9

					if var_72_9 + var_72_4 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_9 + var_72_4
					end
				end

				arg_69_1.text_.text = var_72_7
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116141", "116141017", "story_v_out_116141.awb") ~= 0 then
					local var_72_10 = manager.audio:GetVoiceLength("story_v_out_116141", "116141017", "story_v_out_116141.awb") / 1000

					if var_72_10 + var_72_4 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_10 + var_72_4
					end

					if var_72_6.prefab_name ~= "" and arg_69_1.actors_[var_72_6.prefab_name] ~= nil then
						local var_72_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_6.prefab_name].transform, "story_v_out_116141", "116141017", "story_v_out_116141.awb")

						arg_69_1:RecordAudio("116141017", var_72_11)
						arg_69_1:RecordAudio("116141017", var_72_11)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_116141", "116141017", "story_v_out_116141.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_116141", "116141017", "story_v_out_116141.awb")
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

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play116141018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 116141018
		arg_73_1.duration_ = 19.73

		local var_73_0 = {
			zh = 9.433,
			ja = 19.733
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
				arg_73_0:Play116141019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 and not isNil(arg_73_1.actors_["1059ui_story"]) and arg_73_1.var_.characterEffect1059ui_story == nil then
				arg_73_1.var_.characterEffect1059ui_story = arg_73_1.actors_["1059ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_0 = 0.2

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_0 and not isNil(arg_73_1.actors_["1059ui_story"]) then
				if arg_73_1.var_.characterEffect1059ui_story and not isNil(arg_73_1.actors_["1059ui_story"]) then
					arg_73_1.var_.characterEffect1059ui_story.fillFlat = false
				end
			end

			if arg_73_1.time_ >= 0 + var_76_0 and arg_73_1.time_ < 0 + var_76_0 + arg_76_0 and not isNil(arg_73_1.actors_["1059ui_story"]) and arg_73_1.var_.characterEffect1059ui_story then
				arg_73_1.var_.characterEffect1059ui_story.fillFlat = false
			end

			local var_76_2 = arg_73_1.actors_["1028ui_story"]

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 and not isNil(var_76_2) and arg_73_1.var_.characterEffect1028ui_story == nil then
				arg_73_1.var_.characterEffect1028ui_story = var_76_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_3 = 0.2

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_3 and not isNil(var_76_2) then
				if arg_73_1.var_.characterEffect1028ui_story and not isNil(var_76_2) then
					arg_73_1.var_.characterEffect1028ui_story.fillFlat = true
					arg_73_1.var_.characterEffect1028ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_73_1.time_ - 0) / var_76_3)
				end
			end

			if arg_73_1.time_ >= 0 + var_76_3 and arg_73_1.time_ < 0 + var_76_3 + arg_76_0 and not isNil(var_76_2) and arg_73_1.var_.characterEffect1028ui_story then
				arg_73_1.var_.characterEffect1028ui_story.fillFlat = true
				arg_73_1.var_.characterEffect1028ui_story.fillRatio = 0.5
			end

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/story1059/story1059action/1059action6_2")
			end

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1204cva")
			end

			local var_76_4 = 0
			local var_76_5 = 1.125

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_4 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				arg_73_1.leftNameTxt_.text = arg_73_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_6 = arg_73_1:GetWordFromCfg(116141018)
				local var_76_7 = arg_73_1:FormatText(var_76_6.content)

				arg_73_1.text_.text = var_76_7

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_9 = 45 <= 0 and var_76_5 or var_76_5 * (utf8.len(var_76_7) / 45)

				if (45 <= 0 and var_76_5 or var_76_5 * (utf8.len(var_76_7) / 45)) > 0 and var_76_5 < var_76_9 then
					arg_73_1.talkMaxDuration = var_76_9

					if var_76_9 + var_76_4 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_9 + var_76_4
					end
				end

				arg_73_1.text_.text = var_76_7
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116141", "116141018", "story_v_out_116141.awb") ~= 0 then
					local var_76_10 = manager.audio:GetVoiceLength("story_v_out_116141", "116141018", "story_v_out_116141.awb") / 1000

					if var_76_10 + var_76_4 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_10 + var_76_4
					end

					if var_76_6.prefab_name ~= "" and arg_73_1.actors_[var_76_6.prefab_name] ~= nil then
						local var_76_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_6.prefab_name].transform, "story_v_out_116141", "116141018", "story_v_out_116141.awb")

						arg_73_1:RecordAudio("116141018", var_76_11)
						arg_73_1:RecordAudio("116141018", var_76_11)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_116141", "116141018", "story_v_out_116141.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_116141", "116141018", "story_v_out_116141.awb")
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
	Play116141019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 116141019
		arg_77_1.duration_ = 9.4

		local var_77_0 = {
			zh = 4.8,
			ja = 9.4
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
				arg_77_0:Play116141020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 and not isNil(arg_77_1.actors_["1028ui_story"]) and arg_77_1.var_.characterEffect1028ui_story == nil then
				arg_77_1.var_.characterEffect1028ui_story = arg_77_1.actors_["1028ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_0 = 0.2

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_0 and not isNil(arg_77_1.actors_["1028ui_story"]) then
				if arg_77_1.var_.characterEffect1028ui_story and not isNil(arg_77_1.actors_["1028ui_story"]) then
					arg_77_1.var_.characterEffect1028ui_story.fillFlat = false
				end
			end

			if arg_77_1.time_ >= 0 + var_80_0 and arg_77_1.time_ < 0 + var_80_0 + arg_80_0 and not isNil(arg_77_1.actors_["1028ui_story"]) and arg_77_1.var_.characterEffect1028ui_story then
				arg_77_1.var_.characterEffect1028ui_story.fillFlat = false
			end

			local var_80_2 = arg_77_1.actors_["1059ui_story"]

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 and not isNil(var_80_2) and arg_77_1.var_.characterEffect1059ui_story == nil then
				arg_77_1.var_.characterEffect1059ui_story = var_80_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_3 = 0.2

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_3 and not isNil(var_80_2) then
				if arg_77_1.var_.characterEffect1059ui_story and not isNil(var_80_2) then
					arg_77_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_77_1.var_.characterEffect1059ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_77_1.time_ - 0) / var_80_3)
				end
			end

			if arg_77_1.time_ >= 0 + var_80_3 and arg_77_1.time_ < 0 + var_80_3 + arg_80_0 and not isNil(var_80_2) and arg_77_1.var_.characterEffect1059ui_story then
				arg_77_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_77_1.var_.characterEffect1059ui_story.fillRatio = 0.5
			end

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/story1028/story1028action/1028action6_2")
			end

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_80_4 = 0
			local var_80_5 = 0.55

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_4 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				arg_77_1.leftNameTxt_.text = arg_77_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_6 = arg_77_1:GetWordFromCfg(116141019)
				local var_80_7 = arg_77_1:FormatText(var_80_6.content)

				arg_77_1.text_.text = var_80_7

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_9 = 22 <= 0 and var_80_5 or var_80_5 * (utf8.len(var_80_7) / 22)

				if (22 <= 0 and var_80_5 or var_80_5 * (utf8.len(var_80_7) / 22)) > 0 and var_80_5 < var_80_9 then
					arg_77_1.talkMaxDuration = var_80_9

					if var_80_9 + var_80_4 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_9 + var_80_4
					end
				end

				arg_77_1.text_.text = var_80_7
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116141", "116141019", "story_v_out_116141.awb") ~= 0 then
					local var_80_10 = manager.audio:GetVoiceLength("story_v_out_116141", "116141019", "story_v_out_116141.awb") / 1000

					if var_80_10 + var_80_4 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_10 + var_80_4
					end

					if var_80_6.prefab_name ~= "" and arg_77_1.actors_[var_80_6.prefab_name] ~= nil then
						local var_80_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_6.prefab_name].transform, "story_v_out_116141", "116141019", "story_v_out_116141.awb")

						arg_77_1:RecordAudio("116141019", var_80_11)
						arg_77_1:RecordAudio("116141019", var_80_11)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_116141", "116141019", "story_v_out_116141.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_116141", "116141019", "story_v_out_116141.awb")
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

		arg_77_1.nodeConfigList_ = {}

		arg_77_1:InitPlayNodeList()
	end,
	Play116141020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 116141020
		arg_81_1.duration_ = 7.13

		local var_81_0 = {
			zh = 4.9,
			ja = 7.133
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
				arg_81_0:Play116141021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 and not isNil(arg_81_1.actors_["1059ui_story"]) and arg_81_1.var_.characterEffect1059ui_story == nil then
				arg_81_1.var_.characterEffect1059ui_story = arg_81_1.actors_["1059ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_0 = 0.2

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_0 and not isNil(arg_81_1.actors_["1059ui_story"]) then
				if arg_81_1.var_.characterEffect1059ui_story and not isNil(arg_81_1.actors_["1059ui_story"]) then
					arg_81_1.var_.characterEffect1059ui_story.fillFlat = false
				end
			end

			if arg_81_1.time_ >= 0 + var_84_0 and arg_81_1.time_ < 0 + var_84_0 + arg_84_0 and not isNil(arg_81_1.actors_["1059ui_story"]) and arg_81_1.var_.characterEffect1059ui_story then
				arg_81_1.var_.characterEffect1059ui_story.fillFlat = false
			end

			local var_84_2 = arg_81_1.actors_["1028ui_story"]

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 and not isNil(var_84_2) and arg_81_1.var_.characterEffect1028ui_story == nil then
				arg_81_1.var_.characterEffect1028ui_story = var_84_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_3 = 0.2

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_3 and not isNil(var_84_2) then
				if arg_81_1.var_.characterEffect1028ui_story and not isNil(var_84_2) then
					arg_81_1.var_.characterEffect1028ui_story.fillFlat = true
					arg_81_1.var_.characterEffect1028ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_81_1.time_ - 0) / var_84_3)
				end
			end

			if arg_81_1.time_ >= 0 + var_84_3 and arg_81_1.time_ < 0 + var_84_3 + arg_84_0 and not isNil(var_84_2) and arg_81_1.var_.characterEffect1028ui_story then
				arg_81_1.var_.characterEffect1028ui_story.fillFlat = true
				arg_81_1.var_.characterEffect1028ui_story.fillRatio = 0.5
			end

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_84_4 = 0
			local var_84_5 = 0.525

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_4 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				arg_81_1.leftNameTxt_.text = arg_81_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_6 = arg_81_1:GetWordFromCfg(116141020)
				local var_84_7 = arg_81_1:FormatText(var_84_6.content)

				arg_81_1.text_.text = var_84_7

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_9 = 21 <= 0 and var_84_5 or var_84_5 * (utf8.len(var_84_7) / 21)

				if (21 <= 0 and var_84_5 or var_84_5 * (utf8.len(var_84_7) / 21)) > 0 and var_84_5 < var_84_9 then
					arg_81_1.talkMaxDuration = var_84_9

					if var_84_9 + var_84_4 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_9 + var_84_4
					end
				end

				arg_81_1.text_.text = var_84_7
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116141", "116141020", "story_v_out_116141.awb") ~= 0 then
					local var_84_10 = manager.audio:GetVoiceLength("story_v_out_116141", "116141020", "story_v_out_116141.awb") / 1000

					if var_84_10 + var_84_4 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_10 + var_84_4
					end

					if var_84_6.prefab_name ~= "" and arg_81_1.actors_[var_84_6.prefab_name] ~= nil then
						local var_84_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_6.prefab_name].transform, "story_v_out_116141", "116141020", "story_v_out_116141.awb")

						arg_81_1:RecordAudio("116141020", var_84_11)
						arg_81_1:RecordAudio("116141020", var_84_11)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_116141", "116141020", "story_v_out_116141.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_116141", "116141020", "story_v_out_116141.awb")
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
	Play116141021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 116141021
		arg_85_1.duration_ = 4.23

		local var_85_0 = {
			zh = 4.233,
			ja = 2.9
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
				arg_85_0:Play116141022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 and not isNil(arg_85_1.actors_["1028ui_story"]) and arg_85_1.var_.characterEffect1028ui_story == nil then
				arg_85_1.var_.characterEffect1028ui_story = arg_85_1.actors_["1028ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_0 = 0.2

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_0 and not isNil(arg_85_1.actors_["1028ui_story"]) then
				if arg_85_1.var_.characterEffect1028ui_story and not isNil(arg_85_1.actors_["1028ui_story"]) then
					arg_85_1.var_.characterEffect1028ui_story.fillFlat = false
				end
			end

			if arg_85_1.time_ >= 0 + var_88_0 and arg_85_1.time_ < 0 + var_88_0 + arg_88_0 and not isNil(arg_85_1.actors_["1028ui_story"]) and arg_85_1.var_.characterEffect1028ui_story then
				arg_85_1.var_.characterEffect1028ui_story.fillFlat = false
			end

			local var_88_2 = arg_85_1.actors_["1059ui_story"]

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 and not isNil(var_88_2) and arg_85_1.var_.characterEffect1059ui_story == nil then
				arg_85_1.var_.characterEffect1059ui_story = var_88_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_3 = 0.2

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_3 and not isNil(var_88_2) then
				if arg_85_1.var_.characterEffect1059ui_story and not isNil(var_88_2) then
					arg_85_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_85_1.var_.characterEffect1059ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_85_1.time_ - 0) / var_88_3)
				end
			end

			if arg_85_1.time_ >= 0 + var_88_3 and arg_85_1.time_ < 0 + var_88_3 + arg_88_0 and not isNil(var_88_2) and arg_85_1.var_.characterEffect1059ui_story then
				arg_85_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_85_1.var_.characterEffect1059ui_story.fillRatio = 0.5
			end

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/story1028/story1028action/1028action6_1")
			end

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_88_4 = 0
			local var_88_5 = 0.4

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_4 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				arg_85_1.leftNameTxt_.text = arg_85_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_6 = arg_85_1:GetWordFromCfg(116141021)
				local var_88_7 = arg_85_1:FormatText(var_88_6.content)

				arg_85_1.text_.text = var_88_7

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_9 = 16 <= 0 and var_88_5 or var_88_5 * (utf8.len(var_88_7) / 16)

				if (16 <= 0 and var_88_5 or var_88_5 * (utf8.len(var_88_7) / 16)) > 0 and var_88_5 < var_88_9 then
					arg_85_1.talkMaxDuration = var_88_9

					if var_88_9 + var_88_4 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_9 + var_88_4
					end
				end

				arg_85_1.text_.text = var_88_7
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116141", "116141021", "story_v_out_116141.awb") ~= 0 then
					local var_88_10 = manager.audio:GetVoiceLength("story_v_out_116141", "116141021", "story_v_out_116141.awb") / 1000

					if var_88_10 + var_88_4 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_10 + var_88_4
					end

					if var_88_6.prefab_name ~= "" and arg_85_1.actors_[var_88_6.prefab_name] ~= nil then
						local var_88_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_6.prefab_name].transform, "story_v_out_116141", "116141021", "story_v_out_116141.awb")

						arg_85_1:RecordAudio("116141021", var_88_11)
						arg_85_1:RecordAudio("116141021", var_88_11)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_116141", "116141021", "story_v_out_116141.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_116141", "116141021", "story_v_out_116141.awb")
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
	Play116141022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 116141022
		arg_89_1.duration_ = 3.73

		local var_89_0 = {
			zh = 2.333,
			ja = 3.733
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
				arg_89_0:Play116141023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 and not isNil(arg_89_1.actors_["1059ui_story"]) and arg_89_1.var_.characterEffect1059ui_story == nil then
				arg_89_1.var_.characterEffect1059ui_story = arg_89_1.actors_["1059ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_0 = 0.2

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_0 and not isNil(arg_89_1.actors_["1059ui_story"]) then
				if arg_89_1.var_.characterEffect1059ui_story and not isNil(arg_89_1.actors_["1059ui_story"]) then
					arg_89_1.var_.characterEffect1059ui_story.fillFlat = false
				end
			end

			if arg_89_1.time_ >= 0 + var_92_0 and arg_89_1.time_ < 0 + var_92_0 + arg_92_0 and not isNil(arg_89_1.actors_["1059ui_story"]) and arg_89_1.var_.characterEffect1059ui_story then
				arg_89_1.var_.characterEffect1059ui_story.fillFlat = false
			end

			local var_92_2 = arg_89_1.actors_["1028ui_story"]

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 and not isNil(var_92_2) and arg_89_1.var_.characterEffect1028ui_story == nil then
				arg_89_1.var_.characterEffect1028ui_story = var_92_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_3 = 0.2

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_3 and not isNil(var_92_2) then
				if arg_89_1.var_.characterEffect1028ui_story and not isNil(var_92_2) then
					arg_89_1.var_.characterEffect1028ui_story.fillFlat = true
					arg_89_1.var_.characterEffect1028ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_89_1.time_ - 0) / var_92_3)
				end
			end

			if arg_89_1.time_ >= 0 + var_92_3 and arg_89_1.time_ < 0 + var_92_3 + arg_92_0 and not isNil(var_92_2) and arg_89_1.var_.characterEffect1028ui_story then
				arg_89_1.var_.characterEffect1028ui_story.fillFlat = true
				arg_89_1.var_.characterEffect1028ui_story.fillRatio = 0.5
			end

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/story1059/story1059action/1059action7_1")
			end

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_92_4 = 0
			local var_92_5 = 0.175

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_4 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				arg_89_1.leftNameTxt_.text = arg_89_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_6 = arg_89_1:GetWordFromCfg(116141022)
				local var_92_7 = arg_89_1:FormatText(var_92_6.content)

				arg_89_1.text_.text = var_92_7

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_9 = 7 <= 0 and var_92_5 or var_92_5 * (utf8.len(var_92_7) / 7)

				if (7 <= 0 and var_92_5 or var_92_5 * (utf8.len(var_92_7) / 7)) > 0 and var_92_5 < var_92_9 then
					arg_89_1.talkMaxDuration = var_92_9

					if var_92_9 + var_92_4 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_9 + var_92_4
					end
				end

				arg_89_1.text_.text = var_92_7
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116141", "116141022", "story_v_out_116141.awb") ~= 0 then
					local var_92_10 = manager.audio:GetVoiceLength("story_v_out_116141", "116141022", "story_v_out_116141.awb") / 1000

					if var_92_10 + var_92_4 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_10 + var_92_4
					end

					if var_92_6.prefab_name ~= "" and arg_89_1.actors_[var_92_6.prefab_name] ~= nil then
						local var_92_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_6.prefab_name].transform, "story_v_out_116141", "116141022", "story_v_out_116141.awb")

						arg_89_1:RecordAudio("116141022", var_92_11)
						arg_89_1:RecordAudio("116141022", var_92_11)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_116141", "116141022", "story_v_out_116141.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_116141", "116141022", "story_v_out_116141.awb")
				end

				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_12 = math.max(var_92_5, arg_89_1.talkMaxDuration)

			if var_92_4 <= arg_89_1.time_ and arg_89_1.time_ < var_92_4 + var_92_12 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_4) / var_92_12

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_4 + var_92_12 and arg_89_1.time_ < var_92_4 + var_92_12 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {}

		arg_89_1:InitPlayNodeList()
	end,
	Play116141023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 116141023
		arg_93_1.duration_ = 5.97

		local var_93_0 = {
			zh = 5.966,
			ja = 5.7
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
				arg_93_0:Play116141024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 and not isNil(arg_93_1.actors_["1028ui_story"]) and arg_93_1.var_.characterEffect1028ui_story == nil then
				arg_93_1.var_.characterEffect1028ui_story = arg_93_1.actors_["1028ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_0 = 0.2

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_0 and not isNil(arg_93_1.actors_["1028ui_story"]) then
				if arg_93_1.var_.characterEffect1028ui_story and not isNil(arg_93_1.actors_["1028ui_story"]) then
					arg_93_1.var_.characterEffect1028ui_story.fillFlat = false
				end
			end

			if arg_93_1.time_ >= 0 + var_96_0 and arg_93_1.time_ < 0 + var_96_0 + arg_96_0 and not isNil(arg_93_1.actors_["1028ui_story"]) and arg_93_1.var_.characterEffect1028ui_story then
				arg_93_1.var_.characterEffect1028ui_story.fillFlat = false
			end

			local var_96_2 = arg_93_1.actors_["1059ui_story"]

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 and not isNil(var_96_2) and arg_93_1.var_.characterEffect1059ui_story == nil then
				arg_93_1.var_.characterEffect1059ui_story = var_96_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_3 = 0.2

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_3 and not isNil(var_96_2) then
				if arg_93_1.var_.characterEffect1059ui_story and not isNil(var_96_2) then
					arg_93_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_93_1.var_.characterEffect1059ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_93_1.time_ - 0) / var_96_3)
				end
			end

			if arg_93_1.time_ >= 0 + var_96_3 and arg_93_1.time_ < 0 + var_96_3 + arg_96_0 and not isNil(var_96_2) and arg_93_1.var_.characterEffect1059ui_story then
				arg_93_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_93_1.var_.characterEffect1059ui_story.fillRatio = 0.5
			end

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/story1028/story1028actionlink/1028action465")
			end

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_96_4 = 0
			local var_96_5 = 0.2

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_4 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				arg_93_1.leftNameTxt_.text = arg_93_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_6 = arg_93_1:GetWordFromCfg(116141023)
				local var_96_7 = arg_93_1:FormatText(var_96_6.content)

				arg_93_1.text_.text = var_96_7

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_9 = 8 <= 0 and var_96_5 or var_96_5 * (utf8.len(var_96_7) / 8)

				if (8 <= 0 and var_96_5 or var_96_5 * (utf8.len(var_96_7) / 8)) > 0 and var_96_5 < var_96_9 then
					arg_93_1.talkMaxDuration = var_96_9

					if var_96_9 + var_96_4 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_9 + var_96_4
					end
				end

				arg_93_1.text_.text = var_96_7
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116141", "116141023", "story_v_out_116141.awb") ~= 0 then
					local var_96_10 = manager.audio:GetVoiceLength("story_v_out_116141", "116141023", "story_v_out_116141.awb") / 1000

					if var_96_10 + var_96_4 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_10 + var_96_4
					end

					if var_96_6.prefab_name ~= "" and arg_93_1.actors_[var_96_6.prefab_name] ~= nil then
						local var_96_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_6.prefab_name].transform, "story_v_out_116141", "116141023", "story_v_out_116141.awb")

						arg_93_1:RecordAudio("116141023", var_96_11)
						arg_93_1:RecordAudio("116141023", var_96_11)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_116141", "116141023", "story_v_out_116141.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_116141", "116141023", "story_v_out_116141.awb")
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

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play116141024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 116141024
		arg_97_1.duration_ = 3.73

		local var_97_0 = {
			zh = 3.733,
			ja = 3.6
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
				arg_97_0:Play116141025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 and not isNil(arg_97_1.actors_["1059ui_story"]) and arg_97_1.var_.characterEffect1059ui_story == nil then
				arg_97_1.var_.characterEffect1059ui_story = arg_97_1.actors_["1059ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_0 = 0.2

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_0 and not isNil(arg_97_1.actors_["1059ui_story"]) then
				if arg_97_1.var_.characterEffect1059ui_story and not isNil(arg_97_1.actors_["1059ui_story"]) then
					arg_97_1.var_.characterEffect1059ui_story.fillFlat = false
				end
			end

			if arg_97_1.time_ >= 0 + var_100_0 and arg_97_1.time_ < 0 + var_100_0 + arg_100_0 and not isNil(arg_97_1.actors_["1059ui_story"]) and arg_97_1.var_.characterEffect1059ui_story then
				arg_97_1.var_.characterEffect1059ui_story.fillFlat = false
			end

			local var_100_2 = arg_97_1.actors_["1028ui_story"]

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 and not isNil(var_100_2) and arg_97_1.var_.characterEffect1028ui_story == nil then
				arg_97_1.var_.characterEffect1028ui_story = var_100_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_3 = 0.2

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_3 and not isNil(var_100_2) then
				if arg_97_1.var_.characterEffect1028ui_story and not isNil(var_100_2) then
					arg_97_1.var_.characterEffect1028ui_story.fillFlat = true
					arg_97_1.var_.characterEffect1028ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_97_1.time_ - 0) / var_100_3)
				end
			end

			if arg_97_1.time_ >= 0 + var_100_3 and arg_97_1.time_ < 0 + var_100_3 + arg_100_0 and not isNil(var_100_2) and arg_97_1.var_.characterEffect1028ui_story then
				arg_97_1.var_.characterEffect1028ui_story.fillFlat = true
				arg_97_1.var_.characterEffect1028ui_story.fillRatio = 0.5
			end

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/story1059/story1059action/1059action7_2")
			end

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_100_4 = 0
			local var_100_5 = 0.35

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_4 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				arg_97_1.leftNameTxt_.text = arg_97_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_6 = arg_97_1:GetWordFromCfg(116141024)
				local var_100_7 = arg_97_1:FormatText(var_100_6.content)

				arg_97_1.text_.text = var_100_7

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_9 = 14 <= 0 and var_100_5 or var_100_5 * (utf8.len(var_100_7) / 14)

				if (14 <= 0 and var_100_5 or var_100_5 * (utf8.len(var_100_7) / 14)) > 0 and var_100_5 < var_100_9 then
					arg_97_1.talkMaxDuration = var_100_9

					if var_100_9 + var_100_4 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_9 + var_100_4
					end
				end

				arg_97_1.text_.text = var_100_7
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116141", "116141024", "story_v_out_116141.awb") ~= 0 then
					local var_100_10 = manager.audio:GetVoiceLength("story_v_out_116141", "116141024", "story_v_out_116141.awb") / 1000

					if var_100_10 + var_100_4 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_10 + var_100_4
					end

					if var_100_6.prefab_name ~= "" and arg_97_1.actors_[var_100_6.prefab_name] ~= nil then
						local var_100_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_6.prefab_name].transform, "story_v_out_116141", "116141024", "story_v_out_116141.awb")

						arg_97_1:RecordAudio("116141024", var_100_11)
						arg_97_1:RecordAudio("116141024", var_100_11)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_116141", "116141024", "story_v_out_116141.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_116141", "116141024", "story_v_out_116141.awb")
				end

				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_12 = math.max(var_100_5, arg_97_1.talkMaxDuration)

			if var_100_4 <= arg_97_1.time_ and arg_97_1.time_ < var_100_4 + var_100_12 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_4) / var_100_12

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_4 + var_100_12 and arg_97_1.time_ < var_100_4 + var_100_12 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {}

		arg_97_1:InitPlayNodeList()
	end,
	Play116141025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 116141025
		arg_101_1.duration_ = 8.73

		local var_101_0 = {
			zh = 5.3,
			ja = 8.733
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
				arg_101_0:Play116141026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 and not isNil(arg_101_1.actors_["1028ui_story"]) and arg_101_1.var_.characterEffect1028ui_story == nil then
				arg_101_1.var_.characterEffect1028ui_story = arg_101_1.actors_["1028ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_0 = 0.2

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_0 and not isNil(arg_101_1.actors_["1028ui_story"]) then
				if arg_101_1.var_.characterEffect1028ui_story and not isNil(arg_101_1.actors_["1028ui_story"]) then
					arg_101_1.var_.characterEffect1028ui_story.fillFlat = false
				end
			end

			if arg_101_1.time_ >= 0 + var_104_0 and arg_101_1.time_ < 0 + var_104_0 + arg_104_0 and not isNil(arg_101_1.actors_["1028ui_story"]) and arg_101_1.var_.characterEffect1028ui_story then
				arg_101_1.var_.characterEffect1028ui_story.fillFlat = false
			end

			local var_104_2 = arg_101_1.actors_["1059ui_story"]

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 and not isNil(var_104_2) and arg_101_1.var_.characterEffect1059ui_story == nil then
				arg_101_1.var_.characterEffect1059ui_story = var_104_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_3 = 0.2

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_3 and not isNil(var_104_2) then
				if arg_101_1.var_.characterEffect1059ui_story and not isNil(var_104_2) then
					arg_101_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_101_1.var_.characterEffect1059ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_101_1.time_ - 0) / var_104_3)
				end
			end

			if arg_101_1.time_ >= 0 + var_104_3 and arg_101_1.time_ < 0 + var_104_3 + arg_104_0 and not isNil(var_104_2) and arg_101_1.var_.characterEffect1059ui_story then
				arg_101_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_101_1.var_.characterEffect1059ui_story.fillRatio = 0.5
			end

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/story1028/story1028action/1028action5_2")
			end

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0203cva")
			end

			local var_104_4 = 0
			local var_104_5 = 0.575

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= var_104_4 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				arg_101_1.leftNameTxt_.text = arg_101_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_6 = arg_101_1:GetWordFromCfg(116141025)
				local var_104_7 = arg_101_1:FormatText(var_104_6.content)

				arg_101_1.text_.text = var_104_7

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_9 = 23 <= 0 and var_104_5 or var_104_5 * (utf8.len(var_104_7) / 23)

				if (23 <= 0 and var_104_5 or var_104_5 * (utf8.len(var_104_7) / 23)) > 0 and var_104_5 < var_104_9 then
					arg_101_1.talkMaxDuration = var_104_9

					if var_104_9 + var_104_4 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_9 + var_104_4
					end
				end

				arg_101_1.text_.text = var_104_7
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116141", "116141025", "story_v_out_116141.awb") ~= 0 then
					local var_104_10 = manager.audio:GetVoiceLength("story_v_out_116141", "116141025", "story_v_out_116141.awb") / 1000

					if var_104_10 + var_104_4 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_10 + var_104_4
					end

					if var_104_6.prefab_name ~= "" and arg_101_1.actors_[var_104_6.prefab_name] ~= nil then
						local var_104_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_6.prefab_name].transform, "story_v_out_116141", "116141025", "story_v_out_116141.awb")

						arg_101_1:RecordAudio("116141025", var_104_11)
						arg_101_1:RecordAudio("116141025", var_104_11)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_116141", "116141025", "story_v_out_116141.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_116141", "116141025", "story_v_out_116141.awb")
				end

				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_12 = math.max(var_104_5, arg_101_1.talkMaxDuration)

			if var_104_4 <= arg_101_1.time_ and arg_101_1.time_ < var_104_4 + var_104_12 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_4) / var_104_12

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_4 + var_104_12 and arg_101_1.time_ < var_104_4 + var_104_12 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {}

		arg_101_1:InitPlayNodeList()
	end,
	Play116141026 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 116141026
		arg_105_1.duration_ = 2.87

		local var_105_0 = {
			zh = 1.999999999999,
			ja = 2.866
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
				arg_105_0:Play116141027(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 and not isNil(arg_105_1.actors_["1059ui_story"]) and arg_105_1.var_.characterEffect1059ui_story == nil then
				arg_105_1.var_.characterEffect1059ui_story = arg_105_1.actors_["1059ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_0 = 0.2

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_0 and not isNil(arg_105_1.actors_["1059ui_story"]) then
				if arg_105_1.var_.characterEffect1059ui_story and not isNil(arg_105_1.actors_["1059ui_story"]) then
					arg_105_1.var_.characterEffect1059ui_story.fillFlat = false
				end
			end

			if arg_105_1.time_ >= 0 + var_108_0 and arg_105_1.time_ < 0 + var_108_0 + arg_108_0 and not isNil(arg_105_1.actors_["1059ui_story"]) and arg_105_1.var_.characterEffect1059ui_story then
				arg_105_1.var_.characterEffect1059ui_story.fillFlat = false
			end

			local var_108_2 = arg_105_1.actors_["1028ui_story"]

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 and not isNil(var_108_2) and arg_105_1.var_.characterEffect1028ui_story == nil then
				arg_105_1.var_.characterEffect1028ui_story = var_108_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_3 = 0.2

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_3 and not isNil(var_108_2) then
				if arg_105_1.var_.characterEffect1028ui_story and not isNil(var_108_2) then
					arg_105_1.var_.characterEffect1028ui_story.fillFlat = true
					arg_105_1.var_.characterEffect1028ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_105_1.time_ - 0) / var_108_3)
				end
			end

			if arg_105_1.time_ >= 0 + var_108_3 and arg_105_1.time_ < 0 + var_108_3 + arg_108_0 and not isNil(var_108_2) and arg_105_1.var_.characterEffect1028ui_story then
				arg_105_1.var_.characterEffect1028ui_story.fillFlat = true
				arg_105_1.var_.characterEffect1028ui_story.fillRatio = 0.5
			end

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_108_4 = 0
			local var_108_5 = 0.15

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= var_108_4 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				arg_105_1.leftNameTxt_.text = arg_105_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_6 = arg_105_1:GetWordFromCfg(116141026)
				local var_108_7 = arg_105_1:FormatText(var_108_6.content)

				arg_105_1.text_.text = var_108_7

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_9 = 6 <= 0 and var_108_5 or var_108_5 * (utf8.len(var_108_7) / 6)

				if (6 <= 0 and var_108_5 or var_108_5 * (utf8.len(var_108_7) / 6)) > 0 and var_108_5 < var_108_9 then
					arg_105_1.talkMaxDuration = var_108_9

					if var_108_9 + var_108_4 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_9 + var_108_4
					end
				end

				arg_105_1.text_.text = var_108_7
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116141", "116141026", "story_v_out_116141.awb") ~= 0 then
					local var_108_10 = manager.audio:GetVoiceLength("story_v_out_116141", "116141026", "story_v_out_116141.awb") / 1000

					if var_108_10 + var_108_4 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_10 + var_108_4
					end

					if var_108_6.prefab_name ~= "" and arg_105_1.actors_[var_108_6.prefab_name] ~= nil then
						local var_108_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_6.prefab_name].transform, "story_v_out_116141", "116141026", "story_v_out_116141.awb")

						arg_105_1:RecordAudio("116141026", var_108_11)
						arg_105_1:RecordAudio("116141026", var_108_11)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_116141", "116141026", "story_v_out_116141.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_116141", "116141026", "story_v_out_116141.awb")
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

		arg_105_1.nodeConfigList_ = {}

		arg_105_1:InitPlayNodeList()
	end,
	Play116141027 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 116141027
		arg_109_1.duration_ = 5

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
		end

		function arg_109_1.playNext_(arg_111_0)
			if arg_111_0 == 1 then
				arg_109_0:Play116141028(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1.var_.moveOldPos1028ui_story = arg_109_1.actors_["1028ui_story"].transform.localPosition
			end

			local var_112_0 = 0.001

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_0 then
				arg_109_1.actors_["1028ui_story"].transform.localPosition = Vector3.Lerp(arg_109_1.var_.moveOldPos1028ui_story, Vector3.New(0, 100, 0), (arg_109_1.time_ - 0) / var_112_0)
				arg_109_1.actors_["1028ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_109_1.actors_["1028ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_109_1.actors_["1028ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_109_1.actors_["1028ui_story"].transform.position).z)
				arg_109_1.actors_["1028ui_story"].transform.localEulerAngles.z = 0
				arg_109_1.actors_["1028ui_story"].transform.localEulerAngles.x = 0
				arg_109_1.actors_["1028ui_story"].transform.localEulerAngles = arg_109_1.actors_["1028ui_story"].transform.localEulerAngles
			end

			if arg_109_1.time_ >= 0 + var_112_0 and arg_109_1.time_ < 0 + var_112_0 + arg_112_0 then
				arg_109_1.actors_["1028ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_109_1.actors_["1028ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_109_1.actors_["1028ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_109_1.actors_["1028ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_109_1.actors_["1028ui_story"].transform.position).z)
				arg_109_1.actors_["1028ui_story"].transform.localEulerAngles.z = 0
				arg_109_1.actors_["1028ui_story"].transform.localEulerAngles.x = 0
				arg_109_1.actors_["1028ui_story"].transform.localEulerAngles = arg_109_1.actors_["1028ui_story"].transform.localEulerAngles
			end

			local var_112_1 = arg_109_1.actors_["1059ui_story"].transform

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1.var_.moveOldPos1059ui_story = var_112_1.localPosition
			end

			local var_112_2 = 0.001

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_2 then
				var_112_1.localPosition = Vector3.Lerp(arg_109_1.var_.moveOldPos1059ui_story, Vector3.New(0, 100, 0), (arg_109_1.time_ - 0) / var_112_2)
				var_112_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_112_1.position).x, (manager.ui.mainCamera.transform.position - var_112_1.position).y, (manager.ui.mainCamera.transform.position - var_112_1.position).z)
				var_112_1.localEulerAngles.z = 0
				var_112_1.localEulerAngles.x = 0
				var_112_1.localEulerAngles = var_112_1.localEulerAngles
			end

			if arg_109_1.time_ >= 0 + var_112_2 and arg_109_1.time_ < 0 + var_112_2 + arg_112_0 then
				var_112_1.localPosition = Vector3.New(0, 100, 0)
				var_112_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_112_1.position).x, (manager.ui.mainCamera.transform.position - var_112_1.position).y, (manager.ui.mainCamera.transform.position - var_112_1.position).z)
				var_112_1.localEulerAngles.z = 0
				var_112_1.localEulerAngles.x = 0
				var_112_1.localEulerAngles = var_112_1.localEulerAngles
			end

			local var_112_3 = 0
			local var_112_4 = 1.3

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= var_112_3 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, false)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_5 = arg_109_1:FormatText(arg_109_1:GetWordFromCfg(116141027).content)

				arg_109_1.text_.text = var_112_5

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_7 = 52 <= 0 and var_112_4 or var_112_4 * (utf8.len(var_112_5) / 52)

				if (52 <= 0 and var_112_4 or var_112_4 * (utf8.len(var_112_5) / 52)) > 0 and var_112_4 < var_112_7 then
					arg_109_1.talkMaxDuration = var_112_7

					if var_112_7 + var_112_3 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_7 + var_112_3
					end
				end

				arg_109_1.text_.text = var_112_5
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)
				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_8 = math.max(var_112_4, arg_109_1.talkMaxDuration)

			if var_112_3 <= arg_109_1.time_ and arg_109_1.time_ < var_112_3 + var_112_8 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_3) / var_112_8

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_3 + var_112_8 and arg_109_1.time_ < var_112_3 + var_112_8 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {
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
				actorName = "1059ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_109_1:InitPlayNodeList()
	end,
	Play116141028 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 116141028
		arg_113_1.duration_ = 8.63

		local var_113_0 = {
			zh = 6.766,
			ja = 8.633
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
				arg_113_0:Play116141029(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 and not isNil(arg_113_1.actors_["1028ui_story"]) and arg_113_1.var_.characterEffect1028ui_story == nil then
				arg_113_1.var_.characterEffect1028ui_story = arg_113_1.actors_["1028ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_0 = 0.2

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_0 and not isNil(arg_113_1.actors_["1028ui_story"]) then
				if arg_113_1.var_.characterEffect1028ui_story and not isNil(arg_113_1.actors_["1028ui_story"]) then
					arg_113_1.var_.characterEffect1028ui_story.fillFlat = false
				end
			end

			if arg_113_1.time_ >= 0 + var_116_0 and arg_113_1.time_ < 0 + var_116_0 + arg_116_0 and not isNil(arg_113_1.actors_["1028ui_story"]) and arg_113_1.var_.characterEffect1028ui_story then
				arg_113_1.var_.characterEffect1028ui_story.fillFlat = false
			end

			local var_116_2 = arg_113_1.actors_["1059ui_story"]

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 and not isNil(var_116_2) and arg_113_1.var_.characterEffect1059ui_story == nil then
				arg_113_1.var_.characterEffect1059ui_story = var_116_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_3 = 0.2

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_3 and not isNil(var_116_2) then
				if arg_113_1.var_.characterEffect1059ui_story and not isNil(var_116_2) then
					arg_113_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_113_1.var_.characterEffect1059ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_113_1.time_ - 0) / var_116_3)
				end
			end

			if arg_113_1.time_ >= 0 + var_116_3 and arg_113_1.time_ < 0 + var_116_3 + arg_116_0 and not isNil(var_116_2) and arg_113_1.var_.characterEffect1059ui_story then
				arg_113_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_113_1.var_.characterEffect1059ui_story.fillRatio = 0.5
			end

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/story1028/story1028action/1028action1_1")
			end

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_116_4 = arg_113_1.actors_["1028ui_story"].transform

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1.var_.moveOldPos1028ui_story = var_116_4.localPosition
			end

			local var_116_5 = 0.001

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_5 then
				var_116_4.localPosition = Vector3.Lerp(arg_113_1.var_.moveOldPos1028ui_story, Vector3.New(0, -0.9, -5.9), (arg_113_1.time_ - 0) / var_116_5)
				var_116_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_116_4.position).x, (manager.ui.mainCamera.transform.position - var_116_4.position).y, (manager.ui.mainCamera.transform.position - var_116_4.position).z)
				var_116_4.localEulerAngles.z = 0
				var_116_4.localEulerAngles.x = 0
				var_116_4.localEulerAngles = var_116_4.localEulerAngles
			end

			if arg_113_1.time_ >= 0 + var_116_5 and arg_113_1.time_ < 0 + var_116_5 + arg_116_0 then
				var_116_4.localPosition = Vector3.New(0, -0.9, -5.9)
				var_116_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_116_4.position).x, (manager.ui.mainCamera.transform.position - var_116_4.position).y, (manager.ui.mainCamera.transform.position - var_116_4.position).z)
				var_116_4.localEulerAngles.z = 0
				var_116_4.localEulerAngles.x = 0
				var_116_4.localEulerAngles = var_116_4.localEulerAngles
			end

			local var_116_6 = 0
			local var_116_7 = 0.7

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= var_116_6 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				arg_113_1.leftNameTxt_.text = arg_113_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_8 = arg_113_1:GetWordFromCfg(116141028)
				local var_116_9 = arg_113_1:FormatText(var_116_8.content)

				arg_113_1.text_.text = var_116_9

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_11 = 28 <= 0 and var_116_7 or var_116_7 * (utf8.len(var_116_9) / 28)

				if (28 <= 0 and var_116_7 or var_116_7 * (utf8.len(var_116_9) / 28)) > 0 and var_116_7 < var_116_11 then
					arg_113_1.talkMaxDuration = var_116_11

					if var_116_11 + var_116_6 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_11 + var_116_6
					end
				end

				arg_113_1.text_.text = var_116_9
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116141", "116141028", "story_v_out_116141.awb") ~= 0 then
					local var_116_12 = manager.audio:GetVoiceLength("story_v_out_116141", "116141028", "story_v_out_116141.awb") / 1000

					if var_116_12 + var_116_6 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_12 + var_116_6
					end

					if var_116_8.prefab_name ~= "" and arg_113_1.actors_[var_116_8.prefab_name] ~= nil then
						local var_116_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_8.prefab_name].transform, "story_v_out_116141", "116141028", "story_v_out_116141.awb")

						arg_113_1:RecordAudio("116141028", var_116_13)
						arg_113_1:RecordAudio("116141028", var_116_13)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_out_116141", "116141028", "story_v_out_116141.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_out_116141", "116141028", "story_v_out_116141.awb")
				end

				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_14 = math.max(var_116_7, arg_113_1.talkMaxDuration)

			if var_116_6 <= arg_113_1.time_ and arg_113_1.time_ < var_116_6 + var_116_14 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_6) / var_116_14

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_6 + var_116_14 and arg_113_1.time_ < var_116_6 + var_116_14 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1028ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_113_1:InitPlayNodeList()
	end,
	Play116141029 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 116141029
		arg_117_1.duration_ = 5

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"
		end

		function arg_117_1.playNext_(arg_119_0)
			if arg_119_0 == 1 then
				arg_117_0:Play116141030(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1.var_.moveOldPos1028ui_story = arg_117_1.actors_["1028ui_story"].transform.localPosition
			end

			local var_120_0 = 0.001

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_0 then
				arg_117_1.actors_["1028ui_story"].transform.localPosition = Vector3.Lerp(arg_117_1.var_.moveOldPos1028ui_story, Vector3.New(0, 100, 0), (arg_117_1.time_ - 0) / var_120_0)
				arg_117_1.actors_["1028ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_117_1.actors_["1028ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_117_1.actors_["1028ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_117_1.actors_["1028ui_story"].transform.position).z)
				arg_117_1.actors_["1028ui_story"].transform.localEulerAngles.z = 0
				arg_117_1.actors_["1028ui_story"].transform.localEulerAngles.x = 0
				arg_117_1.actors_["1028ui_story"].transform.localEulerAngles = arg_117_1.actors_["1028ui_story"].transform.localEulerAngles
			end

			if arg_117_1.time_ >= 0 + var_120_0 and arg_117_1.time_ < 0 + var_120_0 + arg_120_0 then
				arg_117_1.actors_["1028ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_117_1.actors_["1028ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_117_1.actors_["1028ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_117_1.actors_["1028ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_117_1.actors_["1028ui_story"].transform.position).z)
				arg_117_1.actors_["1028ui_story"].transform.localEulerAngles.z = 0
				arg_117_1.actors_["1028ui_story"].transform.localEulerAngles.x = 0
				arg_117_1.actors_["1028ui_story"].transform.localEulerAngles = arg_117_1.actors_["1028ui_story"].transform.localEulerAngles
			end

			local var_120_1 = arg_117_1.actors_["1059ui_story"].transform

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1.var_.moveOldPos1059ui_story = var_120_1.localPosition
			end

			local var_120_2 = 0.001

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_2 then
				var_120_1.localPosition = Vector3.Lerp(arg_117_1.var_.moveOldPos1059ui_story, Vector3.New(0, 100, 0), (arg_117_1.time_ - 0) / var_120_2)
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

			local var_120_3 = 0
			local var_120_4 = 0.75

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= var_120_3 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, false)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_5 = arg_117_1:FormatText(arg_117_1:GetWordFromCfg(116141029).content)

				arg_117_1.text_.text = var_120_5

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_7 = 30 <= 0 and var_120_4 or var_120_4 * (utf8.len(var_120_5) / 30)

				if (30 <= 0 and var_120_4 or var_120_4 * (utf8.len(var_120_5) / 30)) > 0 and var_120_4 < var_120_7 then
					arg_117_1.talkMaxDuration = var_120_7

					if var_120_7 + var_120_3 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_7 + var_120_3
					end
				end

				arg_117_1.text_.text = var_120_5
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)
				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_8 = math.max(var_120_4, arg_117_1.talkMaxDuration)

			if var_120_3 <= arg_117_1.time_ and arg_117_1.time_ < var_120_3 + var_120_8 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_3) / var_120_8

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_3 + var_120_8 and arg_117_1.time_ < var_120_3 + var_120_8 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {
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
				actorName = "1059ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_117_1:InitPlayNodeList()
	end,
	Play116141030 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 116141030
		arg_121_1.duration_ = 5.3

		local var_121_0 = {
			zh = 2.3,
			ja = 5.3
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
				arg_121_0:Play116141031(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 and not isNil(arg_121_1.actors_["1059ui_story"]) and arg_121_1.var_.characterEffect1059ui_story == nil then
				arg_121_1.var_.characterEffect1059ui_story = arg_121_1.actors_["1059ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_0 = 0.2

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_0 and not isNil(arg_121_1.actors_["1059ui_story"]) then
				if arg_121_1.var_.characterEffect1059ui_story and not isNil(arg_121_1.actors_["1059ui_story"]) then
					arg_121_1.var_.characterEffect1059ui_story.fillFlat = false
				end
			end

			if arg_121_1.time_ >= 0 + var_124_0 and arg_121_1.time_ < 0 + var_124_0 + arg_124_0 and not isNil(arg_121_1.actors_["1059ui_story"]) and arg_121_1.var_.characterEffect1059ui_story then
				arg_121_1.var_.characterEffect1059ui_story.fillFlat = false
			end

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/story1059/story1059action/1059action2_1")
			end

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_124_2 = arg_121_1.actors_["1059ui_story"].transform

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1.var_.moveOldPos1059ui_story = var_124_2.localPosition
			end

			local var_124_3 = 0.001

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_3 then
				var_124_2.localPosition = Vector3.Lerp(arg_121_1.var_.moveOldPos1059ui_story, Vector3.New(0, -1.05, -6), (arg_121_1.time_ - 0) / var_124_3)
				var_124_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_124_2.position).x, (manager.ui.mainCamera.transform.position - var_124_2.position).y, (manager.ui.mainCamera.transform.position - var_124_2.position).z)
				var_124_2.localEulerAngles.z = 0
				var_124_2.localEulerAngles.x = 0
				var_124_2.localEulerAngles = var_124_2.localEulerAngles
			end

			if arg_121_1.time_ >= 0 + var_124_3 and arg_121_1.time_ < 0 + var_124_3 + arg_124_0 then
				var_124_2.localPosition = Vector3.New(0, -1.05, -6)
				var_124_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_124_2.position).x, (manager.ui.mainCamera.transform.position - var_124_2.position).y, (manager.ui.mainCamera.transform.position - var_124_2.position).z)
				var_124_2.localEulerAngles.z = 0
				var_124_2.localEulerAngles.x = 0
				var_124_2.localEulerAngles = var_124_2.localEulerAngles
			end

			local var_124_4 = 0
			local var_124_5 = 0.275

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= var_124_4 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				arg_121_1.leftNameTxt_.text = arg_121_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_6 = arg_121_1:GetWordFromCfg(116141030)
				local var_124_7 = arg_121_1:FormatText(var_124_6.content)

				arg_121_1.text_.text = var_124_7

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_9 = 11 <= 0 and var_124_5 or var_124_5 * (utf8.len(var_124_7) / 11)

				if (11 <= 0 and var_124_5 or var_124_5 * (utf8.len(var_124_7) / 11)) > 0 and var_124_5 < var_124_9 then
					arg_121_1.talkMaxDuration = var_124_9

					if var_124_9 + var_124_4 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_9 + var_124_4
					end
				end

				arg_121_1.text_.text = var_124_7
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116141", "116141030", "story_v_out_116141.awb") ~= 0 then
					local var_124_10 = manager.audio:GetVoiceLength("story_v_out_116141", "116141030", "story_v_out_116141.awb") / 1000

					if var_124_10 + var_124_4 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_10 + var_124_4
					end

					if var_124_6.prefab_name ~= "" and arg_121_1.actors_[var_124_6.prefab_name] ~= nil then
						local var_124_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_6.prefab_name].transform, "story_v_out_116141", "116141030", "story_v_out_116141.awb")

						arg_121_1:RecordAudio("116141030", var_124_11)
						arg_121_1:RecordAudio("116141030", var_124_11)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_out_116141", "116141030", "story_v_out_116141.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_out_116141", "116141030", "story_v_out_116141.awb")
				end

				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_12 = math.max(var_124_5, arg_121_1.talkMaxDuration)

			if var_124_4 <= arg_121_1.time_ and arg_121_1.time_ < var_124_4 + var_124_12 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_4) / var_124_12

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_4 + var_124_12 and arg_121_1.time_ < var_124_4 + var_124_12 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {
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

		arg_121_1:InitPlayNodeList()
	end,
	Play116141031 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 116141031
		arg_125_1.duration_ = 8.97

		local var_125_0 = {
			zh = 6.133,
			ja = 8.966
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
				arg_125_0:Play116141032(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0204cva")
			end

			local var_128_0 = 0
			local var_128_1 = 0.775

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= var_128_0 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				arg_125_1.leftNameTxt_.text = arg_125_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_2 = arg_125_1:GetWordFromCfg(116141031)
				local var_128_3 = arg_125_1:FormatText(var_128_2.content)

				arg_125_1.text_.text = var_128_3

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_5 = 31 <= 0 and var_128_1 or var_128_1 * (utf8.len(var_128_3) / 31)

				if (31 <= 0 and var_128_1 or var_128_1 * (utf8.len(var_128_3) / 31)) > 0 and var_128_1 < var_128_5 then
					arg_125_1.talkMaxDuration = var_128_5

					if var_128_5 + var_128_0 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_5 + var_128_0
					end
				end

				arg_125_1.text_.text = var_128_3
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116141", "116141031", "story_v_out_116141.awb") ~= 0 then
					local var_128_6 = manager.audio:GetVoiceLength("story_v_out_116141", "116141031", "story_v_out_116141.awb") / 1000

					if var_128_6 + var_128_0 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_6 + var_128_0
					end

					if var_128_2.prefab_name ~= "" and arg_125_1.actors_[var_128_2.prefab_name] ~= nil then
						local var_128_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_125_1.actors_[var_128_2.prefab_name].transform, "story_v_out_116141", "116141031", "story_v_out_116141.awb")

						arg_125_1:RecordAudio("116141031", var_128_7)
						arg_125_1:RecordAudio("116141031", var_128_7)
					else
						arg_125_1:AudioAction("play", "voice", "story_v_out_116141", "116141031", "story_v_out_116141.awb")
					end

					arg_125_1:RecordHistoryTalkVoice("story_v_out_116141", "116141031", "story_v_out_116141.awb")
				end

				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_8 = math.max(var_128_1, arg_125_1.talkMaxDuration)

			if var_128_0 <= arg_125_1.time_ and arg_125_1.time_ < var_128_0 + var_128_8 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_0) / var_128_8

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_0 + var_128_8 and arg_125_1.time_ < var_128_0 + var_128_8 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {}

		arg_125_1:InitPlayNodeList()
	end,
	Play116141032 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 116141032
		arg_129_1.duration_ = 5

		SetActive(arg_129_1.tipsGo_, false)

		function arg_129_1.onSingleLineFinish_()
			arg_129_1.onSingleLineUpdate_ = nil
			arg_129_1.onSingleLineFinish_ = nil
			arg_129_1.state_ = "waiting"
		end

		function arg_129_1.playNext_(arg_131_0)
			if arg_131_0 == 1 then
				arg_129_0:Play116141033(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 and not isNil(arg_129_1.actors_["1059ui_story"]) and arg_129_1.var_.characterEffect1059ui_story == nil then
				arg_129_1.var_.characterEffect1059ui_story = arg_129_1.actors_["1059ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_132_0 = 0.2

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_0 and not isNil(arg_129_1.actors_["1059ui_story"]) then
				if arg_129_1.var_.characterEffect1059ui_story and not isNil(arg_129_1.actors_["1059ui_story"]) then
					arg_129_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_129_1.var_.characterEffect1059ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_129_1.time_ - 0) / var_132_0)
				end
			end

			if arg_129_1.time_ >= 0 + var_132_0 and arg_129_1.time_ < 0 + var_132_0 + arg_132_0 and not isNil(arg_129_1.actors_["1059ui_story"]) and arg_129_1.var_.characterEffect1059ui_story then
				arg_129_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_129_1.var_.characterEffect1059ui_story.fillRatio = 0.5
			end

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1:AudioAction("play", "effect", "se_story_16", "se_story_16_beat02", "")
			end

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_132_2 = 0
			local var_132_3 = 0.3

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= var_132_2 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, false)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_4 = arg_129_1:FormatText(arg_129_1:GetWordFromCfg(116141032).content)

				arg_129_1.text_.text = var_132_4

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_6 = 12 <= 0 and var_132_3 or var_132_3 * (utf8.len(var_132_4) / 12)

				if (12 <= 0 and var_132_3 or var_132_3 * (utf8.len(var_132_4) / 12)) > 0 and var_132_3 < var_132_6 then
					arg_129_1.talkMaxDuration = var_132_6

					if var_132_6 + var_132_2 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_6 + var_132_2
					end
				end

				arg_129_1.text_.text = var_132_4
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)
				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_7 = math.max(var_132_3, arg_129_1.talkMaxDuration)

			if var_132_2 <= arg_129_1.time_ and arg_129_1.time_ < var_132_2 + var_132_7 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_2) / var_132_7

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_2 + var_132_7 and arg_129_1.time_ < var_132_2 + var_132_7 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {}

		arg_129_1:InitPlayNodeList()
	end,
	Play116141033 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 116141033
		arg_133_1.duration_ = 7.1

		local var_133_0 = {
			zh = 4.4,
			ja = 7.1
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
				arg_133_0:Play116141034(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 and not isNil(arg_133_1.actors_["1059ui_story"]) and arg_133_1.var_.characterEffect1059ui_story == nil then
				arg_133_1.var_.characterEffect1059ui_story = arg_133_1.actors_["1059ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_0 = 0.2

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_0 and not isNil(arg_133_1.actors_["1059ui_story"]) then
				if arg_133_1.var_.characterEffect1059ui_story and not isNil(arg_133_1.actors_["1059ui_story"]) then
					arg_133_1.var_.characterEffect1059ui_story.fillFlat = false
				end
			end

			if arg_133_1.time_ >= 0 + var_136_0 and arg_133_1.time_ < 0 + var_136_0 + arg_136_0 and not isNil(arg_133_1.actors_["1059ui_story"]) and arg_133_1.var_.characterEffect1059ui_story then
				arg_133_1.var_.characterEffect1059ui_story.fillFlat = false
			end

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/story1059/story1059action/1059action2_2")
			end

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_136_2 = 0
			local var_136_3 = 0.35

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= var_136_2 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				arg_133_1.leftNameTxt_.text = arg_133_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_4 = arg_133_1:GetWordFromCfg(116141033)
				local var_136_5 = arg_133_1:FormatText(var_136_4.content)

				arg_133_1.text_.text = var_136_5

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_7 = 14 <= 0 and var_136_3 or var_136_3 * (utf8.len(var_136_5) / 14)

				if (14 <= 0 and var_136_3 or var_136_3 * (utf8.len(var_136_5) / 14)) > 0 and var_136_3 < var_136_7 then
					arg_133_1.talkMaxDuration = var_136_7

					if var_136_7 + var_136_2 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_7 + var_136_2
					end
				end

				arg_133_1.text_.text = var_136_5
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116141", "116141033", "story_v_out_116141.awb") ~= 0 then
					local var_136_8 = manager.audio:GetVoiceLength("story_v_out_116141", "116141033", "story_v_out_116141.awb") / 1000

					if var_136_8 + var_136_2 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_8 + var_136_2
					end

					if var_136_4.prefab_name ~= "" and arg_133_1.actors_[var_136_4.prefab_name] ~= nil then
						local var_136_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_4.prefab_name].transform, "story_v_out_116141", "116141033", "story_v_out_116141.awb")

						arg_133_1:RecordAudio("116141033", var_136_9)
						arg_133_1:RecordAudio("116141033", var_136_9)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_out_116141", "116141033", "story_v_out_116141.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_out_116141", "116141033", "story_v_out_116141.awb")
				end

				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_10 = math.max(var_136_3, arg_133_1.talkMaxDuration)

			if var_136_2 <= arg_133_1.time_ and arg_133_1.time_ < var_136_2 + var_136_10 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_2) / var_136_10

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_2 + var_136_10 and arg_133_1.time_ < var_136_2 + var_136_10 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {}

		arg_133_1:InitPlayNodeList()
	end,
	Play116141034 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 116141034
		arg_137_1.duration_ = 5

		SetActive(arg_137_1.tipsGo_, false)

		function arg_137_1.onSingleLineFinish_()
			arg_137_1.onSingleLineUpdate_ = nil
			arg_137_1.onSingleLineFinish_ = nil
			arg_137_1.state_ = "waiting"
		end

		function arg_137_1.playNext_(arg_139_0)
			if arg_139_0 == 1 then
				arg_137_0:Play116141035(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 and not isNil(arg_137_1.actors_["1059ui_story"]) and arg_137_1.var_.characterEffect1059ui_story == nil then
				arg_137_1.var_.characterEffect1059ui_story = arg_137_1.actors_["1059ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_140_0 = 0.2

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_0 and not isNil(arg_137_1.actors_["1059ui_story"]) then
				if arg_137_1.var_.characterEffect1059ui_story and not isNil(arg_137_1.actors_["1059ui_story"]) then
					arg_137_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_137_1.var_.characterEffect1059ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_137_1.time_ - 0) / var_140_0)
				end
			end

			if arg_137_1.time_ >= 0 + var_140_0 and arg_137_1.time_ < 0 + var_140_0 + arg_140_0 and not isNil(arg_137_1.actors_["1059ui_story"]) and arg_137_1.var_.characterEffect1059ui_story then
				arg_137_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_137_1.var_.characterEffect1059ui_story.fillRatio = 0.5
			end

			local var_140_1 = 0
			local var_140_2 = 0.375

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= var_140_1 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, false)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_3 = arg_137_1:FormatText(arg_137_1:GetWordFromCfg(116141034).content)

				arg_137_1.text_.text = var_140_3

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_5 = 15 <= 0 and var_140_2 or var_140_2 * (utf8.len(var_140_3) / 15)

				if (15 <= 0 and var_140_2 or var_140_2 * (utf8.len(var_140_3) / 15)) > 0 and var_140_2 < var_140_5 then
					arg_137_1.talkMaxDuration = var_140_5

					if var_140_5 + var_140_1 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_5 + var_140_1
					end
				end

				arg_137_1.text_.text = var_140_3
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)
				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_6 = math.max(var_140_2, arg_137_1.talkMaxDuration)

			if var_140_1 <= arg_137_1.time_ and arg_137_1.time_ < var_140_1 + var_140_6 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_1) / var_140_6

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_1 + var_140_6 and arg_137_1.time_ < var_140_1 + var_140_6 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {}

		arg_137_1:InitPlayNodeList()
	end,
	Play116141035 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 116141035
		arg_141_1.duration_ = 12.83

		local var_141_0 = {
			zh = 12.833,
			ja = 9.633
		}
		local var_141_1 = manager.audio:GetLocalizationFlag()

		if var_141_0[var_141_1] ~= nil then
			arg_141_1.duration_ = var_141_0[var_141_1]
		end

		SetActive(arg_141_1.tipsGo_, false)

		function arg_141_1.onSingleLineFinish_()
			arg_141_1.onSingleLineUpdate_ = nil
			arg_141_1.onSingleLineFinish_ = nil
			arg_141_1.state_ = "waiting"
		end

		function arg_141_1.playNext_(arg_143_0)
			if arg_143_0 == 1 then
				arg_141_0:Play116141036(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 and not isNil(arg_141_1.actors_["1059ui_story"]) and arg_141_1.var_.characterEffect1059ui_story == nil then
				arg_141_1.var_.characterEffect1059ui_story = arg_141_1.actors_["1059ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_144_0 = 0.2

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_0 and not isNil(arg_141_1.actors_["1059ui_story"]) then
				if arg_141_1.var_.characterEffect1059ui_story and not isNil(arg_141_1.actors_["1059ui_story"]) then
					arg_141_1.var_.characterEffect1059ui_story.fillFlat = false
				end
			end

			if arg_141_1.time_ >= 0 + var_144_0 and arg_141_1.time_ < 0 + var_144_0 + arg_144_0 and not isNil(arg_141_1.actors_["1059ui_story"]) and arg_141_1.var_.characterEffect1059ui_story then
				arg_141_1.var_.characterEffect1059ui_story.fillFlat = false
			end

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/story1059/story1059action/1059action5_1")
			end

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3204cva")
			end

			local var_144_2 = 0
			local var_144_3 = 1.175

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= var_144_2 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				arg_141_1.leftNameTxt_.text = arg_141_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_4 = arg_141_1:GetWordFromCfg(116141035)
				local var_144_5 = arg_141_1:FormatText(var_144_4.content)

				arg_141_1.text_.text = var_144_5

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_7 = 47 <= 0 and var_144_3 or var_144_3 * (utf8.len(var_144_5) / 47)

				if (47 <= 0 and var_144_3 or var_144_3 * (utf8.len(var_144_5) / 47)) > 0 and var_144_3 < var_144_7 then
					arg_141_1.talkMaxDuration = var_144_7

					if var_144_7 + var_144_2 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_7 + var_144_2
					end
				end

				arg_141_1.text_.text = var_144_5
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116141", "116141035", "story_v_out_116141.awb") ~= 0 then
					local var_144_8 = manager.audio:GetVoiceLength("story_v_out_116141", "116141035", "story_v_out_116141.awb") / 1000

					if var_144_8 + var_144_2 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_8 + var_144_2
					end

					if var_144_4.prefab_name ~= "" and arg_141_1.actors_[var_144_4.prefab_name] ~= nil then
						local var_144_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_4.prefab_name].transform, "story_v_out_116141", "116141035", "story_v_out_116141.awb")

						arg_141_1:RecordAudio("116141035", var_144_9)
						arg_141_1:RecordAudio("116141035", var_144_9)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_out_116141", "116141035", "story_v_out_116141.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_out_116141", "116141035", "story_v_out_116141.awb")
				end

				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_10 = math.max(var_144_3, arg_141_1.talkMaxDuration)

			if var_144_2 <= arg_141_1.time_ and arg_141_1.time_ < var_144_2 + var_144_10 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_2) / var_144_10

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_2 + var_144_10 and arg_141_1.time_ < var_144_2 + var_144_10 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {}

		arg_141_1:InitPlayNodeList()
	end,
	Play116141036 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 116141036
		arg_145_1.duration_ = 8.73

		local var_145_0 = {
			zh = 3.8,
			ja = 8.733
		}
		local var_145_1 = manager.audio:GetLocalizationFlag()

		if var_145_0[var_145_1] ~= nil then
			arg_145_1.duration_ = var_145_0[var_145_1]
		end

		SetActive(arg_145_1.tipsGo_, false)

		function arg_145_1.onSingleLineFinish_()
			arg_145_1.onSingleLineUpdate_ = nil
			arg_145_1.onSingleLineFinish_ = nil
			arg_145_1.state_ = "waiting"
		end

		function arg_145_1.playNext_(arg_147_0)
			if arg_147_0 == 1 then
				arg_145_0:Play116141037(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1.var_.moveOldPos1059ui_story = arg_145_1.actors_["1059ui_story"].transform.localPosition
			end

			local var_148_0 = 0.001

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_0 then
				arg_145_1.actors_["1059ui_story"].transform.localPosition = Vector3.Lerp(arg_145_1.var_.moveOldPos1059ui_story, Vector3.New(0, 100, 0), (arg_145_1.time_ - 0) / var_148_0)
				arg_145_1.actors_["1059ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_145_1.actors_["1059ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_145_1.actors_["1059ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_145_1.actors_["1059ui_story"].transform.position).z)
				arg_145_1.actors_["1059ui_story"].transform.localEulerAngles.z = 0
				arg_145_1.actors_["1059ui_story"].transform.localEulerAngles.x = 0
				arg_145_1.actors_["1059ui_story"].transform.localEulerAngles = arg_145_1.actors_["1059ui_story"].transform.localEulerAngles
			end

			if arg_145_1.time_ >= 0 + var_148_0 and arg_145_1.time_ < 0 + var_148_0 + arg_148_0 then
				arg_145_1.actors_["1059ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_145_1.actors_["1059ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_145_1.actors_["1059ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_145_1.actors_["1059ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_145_1.actors_["1059ui_story"].transform.position).z)
				arg_145_1.actors_["1059ui_story"].transform.localEulerAngles.z = 0
				arg_145_1.actors_["1059ui_story"].transform.localEulerAngles.x = 0
				arg_145_1.actors_["1059ui_story"].transform.localEulerAngles = arg_145_1.actors_["1059ui_story"].transform.localEulerAngles
			end

			local var_148_1 = "10025ui_story"

			if arg_145_1.actors_["10025ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10025ui_story"))) then
				local var_148_2 = Object.Instantiate(Asset.Load("Char/" .. "10025ui_story"), arg_145_1.stage_.transform)

				var_148_2.name = var_148_1
				var_148_2.transform.localPosition = Vector3.New(0, 100, 0)
				arg_145_1.actors_[var_148_1] = var_148_2

				local var_148_3 = var_148_2:GetComponentInChildren(typeof(CharacterEffect))

				var_148_3.enabled = true

				local var_148_4 = GameObjectTools.GetOrAddComponent(var_148_2, typeof(DynamicBoneHelper))

				if var_148_4 then
					var_148_4:EnableDynamicBone(false)
				end

				arg_145_1:ShowWeapon(var_148_3.transform, false)

				arg_145_1.var_[var_148_1 .. "Animator"] = var_148_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_145_1.var_[var_148_1 .. "Animator"].applyRootMotion = true
				arg_145_1.var_[var_148_1 .. "LipSync"] = var_148_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_148_5 = arg_145_1.actors_["10025ui_story"].transform

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1.var_.moveOldPos10025ui_story = var_148_5.localPosition
			end

			local var_148_6 = 0.001

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_6 then
				var_148_5.localPosition = Vector3.Lerp(arg_145_1.var_.moveOldPos10025ui_story, Vector3.New(0, -1.1, -5.9), (arg_145_1.time_ - 0) / var_148_6)
				var_148_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_148_5.position).x, (manager.ui.mainCamera.transform.position - var_148_5.position).y, (manager.ui.mainCamera.transform.position - var_148_5.position).z)
				var_148_5.localEulerAngles.z = 0
				var_148_5.localEulerAngles.x = 0
				var_148_5.localEulerAngles = var_148_5.localEulerAngles
			end

			if arg_145_1.time_ >= 0 + var_148_6 and arg_145_1.time_ < 0 + var_148_6 + arg_148_0 then
				var_148_5.localPosition = Vector3.New(0, -1.1, -5.9)
				var_148_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_148_5.position).x, (manager.ui.mainCamera.transform.position - var_148_5.position).y, (manager.ui.mainCamera.transform.position - var_148_5.position).z)
				var_148_5.localEulerAngles.z = 0
				var_148_5.localEulerAngles.x = 0
				var_148_5.localEulerAngles = var_148_5.localEulerAngles
			end

			local var_148_7 = arg_145_1.actors_["1059ui_story"]

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 and not isNil(var_148_7) and arg_145_1.var_.characterEffect1059ui_story == nil then
				arg_145_1.var_.characterEffect1059ui_story = var_148_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_148_8 = 0.2

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_8 and not isNil(var_148_7) then
				if arg_145_1.var_.characterEffect1059ui_story and not isNil(var_148_7) then
					arg_145_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_145_1.var_.characterEffect1059ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_145_1.time_ - 0) / var_148_8)
				end
			end

			if arg_145_1.time_ >= 0 + var_148_8 and arg_145_1.time_ < 0 + var_148_8 + arg_148_0 and not isNil(var_148_7) and arg_145_1.var_.characterEffect1059ui_story then
				arg_145_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_145_1.var_.characterEffect1059ui_story.fillRatio = 0.5
			end

			local var_148_9 = arg_145_1.actors_["10025ui_story"]

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 and not isNil(var_148_9) and arg_145_1.var_.characterEffect10025ui_story == nil then
				arg_145_1.var_.characterEffect10025ui_story = var_148_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_148_10 = 0.2

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_10 and not isNil(var_148_9) then
				if arg_145_1.var_.characterEffect10025ui_story and not isNil(var_148_9) then
					arg_145_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_145_1.time_ >= 0 + var_148_10 and arg_145_1.time_ < 0 + var_148_10 + arg_148_0 and not isNil(var_148_9) and arg_145_1.var_.characterEffect10025ui_story then
				arg_145_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action7_1")
			end

			local var_148_12 = 0
			local var_148_13 = 0.325

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= var_148_12 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				arg_145_1.leftNameTxt_.text = arg_145_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_14 = arg_145_1:GetWordFromCfg(116141036)
				local var_148_15 = arg_145_1:FormatText(var_148_14.content)

				arg_145_1.text_.text = var_148_15

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_17 = 13 <= 0 and var_148_13 or var_148_13 * (utf8.len(var_148_15) / 13)

				if (13 <= 0 and var_148_13 or var_148_13 * (utf8.len(var_148_15) / 13)) > 0 and var_148_13 < var_148_17 then
					arg_145_1.talkMaxDuration = var_148_17

					if var_148_17 + var_148_12 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_17 + var_148_12
					end
				end

				arg_145_1.text_.text = var_148_15
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116141", "116141036", "story_v_out_116141.awb") ~= 0 then
					local var_148_18 = manager.audio:GetVoiceLength("story_v_out_116141", "116141036", "story_v_out_116141.awb") / 1000

					if var_148_18 + var_148_12 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_18 + var_148_12
					end

					if var_148_14.prefab_name ~= "" and arg_145_1.actors_[var_148_14.prefab_name] ~= nil then
						local var_148_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_145_1.actors_[var_148_14.prefab_name].transform, "story_v_out_116141", "116141036", "story_v_out_116141.awb")

						arg_145_1:RecordAudio("116141036", var_148_19)
						arg_145_1:RecordAudio("116141036", var_148_19)
					else
						arg_145_1:AudioAction("play", "voice", "story_v_out_116141", "116141036", "story_v_out_116141.awb")
					end

					arg_145_1:RecordHistoryTalkVoice("story_v_out_116141", "116141036", "story_v_out_116141.awb")
				end

				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_20 = math.max(var_148_13, arg_145_1.talkMaxDuration)

			if var_148_12 <= arg_145_1.time_ and arg_145_1.time_ < var_148_12 + var_148_20 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_12) / var_148_20

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_12 + var_148_20 and arg_145_1.time_ < var_148_12 + var_148_20 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {
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

		arg_145_1:InitPlayNodeList()
	end,
	Play116141037 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 116141037
		arg_149_1.duration_ = 3.53

		local var_149_0 = {
			zh = 2.066,
			ja = 3.533
		}
		local var_149_1 = manager.audio:GetLocalizationFlag()

		if var_149_0[var_149_1] ~= nil then
			arg_149_1.duration_ = var_149_0[var_149_1]
		end

		SetActive(arg_149_1.tipsGo_, false)

		function arg_149_1.onSingleLineFinish_()
			arg_149_1.onSingleLineUpdate_ = nil
			arg_149_1.onSingleLineFinish_ = nil
			arg_149_1.state_ = "waiting"
		end

		function arg_149_1.playNext_(arg_151_0)
			if arg_151_0 == 1 then
				arg_149_0:Play116141038(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 and not isNil(arg_149_1.actors_["10025ui_story"]) and arg_149_1.var_.characterEffect10025ui_story == nil then
				arg_149_1.var_.characterEffect10025ui_story = arg_149_1.actors_["10025ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_152_0 = 0.2

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_0 and not isNil(arg_149_1.actors_["10025ui_story"]) then
				if arg_149_1.var_.characterEffect10025ui_story and not isNil(arg_149_1.actors_["10025ui_story"]) then
					arg_149_1.var_.characterEffect10025ui_story.fillFlat = true
					arg_149_1.var_.characterEffect10025ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_149_1.time_ - 0) / var_152_0)
				end
			end

			if arg_149_1.time_ >= 0 + var_152_0 and arg_149_1.time_ < 0 + var_152_0 + arg_152_0 and not isNil(arg_149_1.actors_["10025ui_story"]) and arg_149_1.var_.characterEffect10025ui_story then
				arg_149_1.var_.characterEffect10025ui_story.fillFlat = true
				arg_149_1.var_.characterEffect10025ui_story.fillRatio = 0.5
			end

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1203cva")
			end

			local var_152_1 = 0
			local var_152_2 = 0.225

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= var_152_1 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				arg_149_1.leftNameTxt_.text = arg_149_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, true)
				arg_149_1.iconController_:SetSelectedState("hero")

				arg_149_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1059")

				arg_149_1.callingController_:SetSelectedState("normal")

				arg_149_1.keyicon_.color = Color.New(1, 1, 1)
				arg_149_1.icon_.color = Color.New(1, 1, 1)

				local var_152_3 = arg_149_1:GetWordFromCfg(116141037)
				local var_152_4 = arg_149_1:FormatText(var_152_3.content)

				arg_149_1.text_.text = var_152_4

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_6 = 9 <= 0 and var_152_2 or var_152_2 * (utf8.len(var_152_4) / 9)

				if (9 <= 0 and var_152_2 or var_152_2 * (utf8.len(var_152_4) / 9)) > 0 and var_152_2 < var_152_6 then
					arg_149_1.talkMaxDuration = var_152_6

					if var_152_6 + var_152_1 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_6 + var_152_1
					end
				end

				arg_149_1.text_.text = var_152_4
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116141", "116141037", "story_v_out_116141.awb") ~= 0 then
					local var_152_7 = manager.audio:GetVoiceLength("story_v_out_116141", "116141037", "story_v_out_116141.awb") / 1000

					if var_152_7 + var_152_1 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_7 + var_152_1
					end

					if var_152_3.prefab_name ~= "" and arg_149_1.actors_[var_152_3.prefab_name] ~= nil then
						local var_152_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_149_1.actors_[var_152_3.prefab_name].transform, "story_v_out_116141", "116141037", "story_v_out_116141.awb")

						arg_149_1:RecordAudio("116141037", var_152_8)
						arg_149_1:RecordAudio("116141037", var_152_8)
					else
						arg_149_1:AudioAction("play", "voice", "story_v_out_116141", "116141037", "story_v_out_116141.awb")
					end

					arg_149_1:RecordHistoryTalkVoice("story_v_out_116141", "116141037", "story_v_out_116141.awb")
				end

				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_9 = math.max(var_152_2, arg_149_1.talkMaxDuration)

			if var_152_1 <= arg_149_1.time_ and arg_149_1.time_ < var_152_1 + var_152_9 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_1) / var_152_9

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_1 + var_152_9 and arg_149_1.time_ < var_152_1 + var_152_9 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {}

		arg_149_1:InitPlayNodeList()
	end,
	Play116141038 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 116141038
		arg_153_1.duration_ = 5

		SetActive(arg_153_1.tipsGo_, false)

		function arg_153_1.onSingleLineFinish_()
			arg_153_1.onSingleLineUpdate_ = nil
			arg_153_1.onSingleLineFinish_ = nil
			arg_153_1.state_ = "waiting"
		end

		function arg_153_1.playNext_(arg_155_0)
			if arg_155_0 == 1 then
				arg_153_0:Play116141039(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1.var_.moveOldPos10025ui_story = arg_153_1.actors_["10025ui_story"].transform.localPosition
			end

			local var_156_0 = 0.001

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_0 then
				arg_153_1.actors_["10025ui_story"].transform.localPosition = Vector3.Lerp(arg_153_1.var_.moveOldPos10025ui_story, Vector3.New(0, 100, 0), (arg_153_1.time_ - 0) / var_156_0)
				arg_153_1.actors_["10025ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_153_1.actors_["10025ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_153_1.actors_["10025ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_153_1.actors_["10025ui_story"].transform.position).z)
				arg_153_1.actors_["10025ui_story"].transform.localEulerAngles.z = 0
				arg_153_1.actors_["10025ui_story"].transform.localEulerAngles.x = 0
				arg_153_1.actors_["10025ui_story"].transform.localEulerAngles = arg_153_1.actors_["10025ui_story"].transform.localEulerAngles
			end

			if arg_153_1.time_ >= 0 + var_156_0 and arg_153_1.time_ < 0 + var_156_0 + arg_156_0 then
				arg_153_1.actors_["10025ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_153_1.actors_["10025ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_153_1.actors_["10025ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_153_1.actors_["10025ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_153_1.actors_["10025ui_story"].transform.position).z)
				arg_153_1.actors_["10025ui_story"].transform.localEulerAngles.z = 0
				arg_153_1.actors_["10025ui_story"].transform.localEulerAngles.x = 0
				arg_153_1.actors_["10025ui_story"].transform.localEulerAngles = arg_153_1.actors_["10025ui_story"].transform.localEulerAngles
			end

			local var_156_1 = 0
			local var_156_2 = 0.875

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= var_156_1 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, false)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_3 = arg_153_1:FormatText(arg_153_1:GetWordFromCfg(116141038).content)

				arg_153_1.text_.text = var_156_3

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_5 = 35 <= 0 and var_156_2 or var_156_2 * (utf8.len(var_156_3) / 35)

				if (35 <= 0 and var_156_2 or var_156_2 * (utf8.len(var_156_3) / 35)) > 0 and var_156_2 < var_156_5 then
					arg_153_1.talkMaxDuration = var_156_5

					if var_156_5 + var_156_1 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_5 + var_156_1
					end
				end

				arg_153_1.text_.text = var_156_3
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)
				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_6 = math.max(var_156_2, arg_153_1.talkMaxDuration)

			if var_156_1 <= arg_153_1.time_ and arg_153_1.time_ < var_156_1 + var_156_6 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_1) / var_156_6

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_1 + var_156_6 and arg_153_1.time_ < var_156_1 + var_156_6 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {
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

		arg_153_1:InitPlayNodeList()
	end,
	Play116141039 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 116141039
		arg_157_1.duration_ = 5

		SetActive(arg_157_1.tipsGo_, false)

		function arg_157_1.onSingleLineFinish_()
			arg_157_1.onSingleLineUpdate_ = nil
			arg_157_1.onSingleLineFinish_ = nil
			arg_157_1.state_ = "waiting"
		end

		function arg_157_1.playNext_(arg_159_0)
			if arg_159_0 == 1 then
				arg_157_0:Play116141040(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			local var_160_0 = 0.8

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, false)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_1 = arg_157_1:FormatText(arg_157_1:GetWordFromCfg(116141039).content)

				arg_157_1.text_.text = var_160_1

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_3 = 32 <= 0 and var_160_0 or var_160_0 * (utf8.len(var_160_1) / 32)

				if (32 <= 0 and var_160_0 or var_160_0 * (utf8.len(var_160_1) / 32)) > 0 and var_160_0 < var_160_3 then
					arg_157_1.talkMaxDuration = var_160_3

					if var_160_3 + 0 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_3 + 0
					end
				end

				arg_157_1.text_.text = var_160_1
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)
				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_4 = math.max(var_160_0, arg_157_1.talkMaxDuration)

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_4 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - 0) / var_160_4

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= 0 + var_160_4 and arg_157_1.time_ < 0 + var_160_4 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {}

		arg_157_1:InitPlayNodeList()
	end,
	Play116141040 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 116141040
		arg_161_1.duration_ = 5

		SetActive(arg_161_1.tipsGo_, false)

		function arg_161_1.onSingleLineFinish_()
			arg_161_1.onSingleLineUpdate_ = nil
			arg_161_1.onSingleLineFinish_ = nil
			arg_161_1.state_ = "waiting"
		end

		function arg_161_1.playNext_(arg_163_0)
			if arg_163_0 == 1 then
				arg_161_0:Play116141041(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			local var_164_0 = 0.425

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, false)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_1 = arg_161_1:FormatText(arg_161_1:GetWordFromCfg(116141040).content)

				arg_161_1.text_.text = var_164_1

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_3 = 17 <= 0 and var_164_0 or var_164_0 * (utf8.len(var_164_1) / 17)

				if (17 <= 0 and var_164_0 or var_164_0 * (utf8.len(var_164_1) / 17)) > 0 and var_164_0 < var_164_3 then
					arg_161_1.talkMaxDuration = var_164_3

					if var_164_3 + 0 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_3 + 0
					end
				end

				arg_161_1.text_.text = var_164_1
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)
				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_4 = math.max(var_164_0, arg_161_1.talkMaxDuration)

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_4 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - 0) / var_164_4

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= 0 + var_164_4 and arg_161_1.time_ < 0 + var_164_4 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {}

		arg_161_1:InitPlayNodeList()
	end,
	Play116141041 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 116141041
		arg_165_1.duration_ = 7

		SetActive(arg_165_1.tipsGo_, false)

		function arg_165_1.onSingleLineFinish_()
			arg_165_1.onSingleLineUpdate_ = nil
			arg_165_1.onSingleLineFinish_ = nil
			arg_165_1.state_ = "waiting"
		end

		function arg_165_1.playNext_(arg_167_0)
			if arg_167_0 == 1 then
				arg_165_0:Play116141042(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			if arg_165_1.bgs_.STwhite == nil then
				local var_168_0 = Object.Instantiate(arg_165_1.paintGo_)

				var_168_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "STwhite")
				var_168_0.name = "STwhite"
				var_168_0.transform.parent = arg_165_1.stage_.transform
				var_168_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_165_1.bgs_.STwhite = var_168_0
			end

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				local var_168_1 = arg_165_1.bgs_.STwhite

				arg_165_1.bgs_.STwhite.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_168_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_168_2 = var_168_1:GetComponent("SpriteRenderer")

				if var_168_2 and var_168_2.sprite then
					local var_168_3 = 2 * (var_168_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_168_1.transform.localScale = Vector3.New(var_168_3 / var_168_2.sprite.bounds.size.y < var_168_3 * manager.ui.mainCameraCom_.aspect / var_168_2.sprite.bounds.size.x and var_168_3 * manager.ui.mainCameraCom_.aspect / var_168_2.sprite.bounds.size.x or var_168_3 / var_168_2.sprite.bounds.size.y, var_168_3 / var_168_2.sprite.bounds.size.y < var_168_3 * manager.ui.mainCameraCom_.aspect / var_168_2.sprite.bounds.size.x and var_168_3 * manager.ui.mainCameraCom_.aspect / var_168_2.sprite.bounds.size.x or var_168_3 / var_168_2.sprite.bounds.size.y, 0)
				end

				for iter_168_0, iter_168_1 in pairs(arg_165_1.bgs_) do
					if iter_168_0 ~= "STwhite" then
						iter_168_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_168_4 = 0

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= var_168_4 + arg_168_0 then
				arg_165_1.mask_.enabled = true
				arg_165_1.mask_.raycastTarget = true

				arg_165_1:SetGaussion(false)
			end

			local var_168_5 = 2

			if var_168_4 <= arg_165_1.time_ and arg_165_1.time_ < var_168_4 + var_168_5 then
				local var_168_6 = Color.New(1, 1, 1)

				var_168_6.a = Mathf.Lerp(1, 0, (arg_165_1.time_ - var_168_4) / var_168_5)
				arg_165_1.mask_.color = var_168_6
			end

			if arg_165_1.time_ >= var_168_4 + var_168_5 and arg_165_1.time_ < var_168_4 + var_168_5 + arg_168_0 then
				local var_168_7 = Color.New(1, 1, 1)

				arg_165_1.mask_.enabled = false
				var_168_7.a = 0
				arg_165_1.mask_.color = var_168_7
			end

			local var_168_8 = arg_165_1.bgs_.STwhite.transform

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1.var_.moveOldPosSTwhite = var_168_8.localPosition
				var_168_8.localScale = Vector3.New(12, 12, 12)
			end

			local var_168_9 = 0.001

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_9 then
				var_168_8.localPosition = Vector3.Lerp(arg_165_1.var_.moveOldPosSTwhite, Vector3.New(0, 0, 0), (arg_165_1.time_ - 0) / var_168_9)
			end

			if arg_165_1.time_ >= 0 + var_168_9 and arg_165_1.time_ < 0 + var_168_9 + arg_168_0 then
				var_168_8.localPosition = Vector3.New(0, 0, 0)
			end

			if arg_165_1.frameCnt_ <= 1 then
				arg_165_1.dialog_:SetActive(false)
			end

			local var_168_10 = 2
			local var_168_11 = 0.05

			if 2 < arg_165_1.time_ and arg_165_1.time_ <= var_168_10 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0

				arg_165_1.dialog_:SetActive(true)

				arg_165_1.dialogCg_.alpha = 0

				local var_168_12 = LeanTween.value(arg_165_1.dialog_, 0, 1, 0.3)

				var_168_12:setOnUpdate(LuaHelper.FloatAction(function(arg_169_0)
					arg_165_1.dialogCg_.alpha = arg_169_0
				end))
				var_168_12:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_165_1.dialog_)
					var_168_12:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_165_1.duration_ = arg_165_1.duration_ + 0.3

				SetActive(arg_165_1.leftNameGo_, false)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_13 = arg_165_1:FormatText(arg_165_1:GetWordFromCfg(116141041).content)

				arg_165_1.text_.text = var_168_13

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_15 = 2 <= 0 and var_168_11 or var_168_11 * (utf8.len(var_168_13) / 2)

				if (2 <= 0 and var_168_11 or var_168_11 * (utf8.len(var_168_13) / 2)) > 0 and var_168_11 < var_168_15 then
					arg_165_1.talkMaxDuration = var_168_15
					var_168_10 = var_168_10 + 0.3

					if var_168_15 + var_168_10 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_15 + var_168_10
					end
				end

				arg_165_1.text_.text = var_168_13
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)
				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_16 = var_168_10 + 0.3
			local var_168_17 = math.max(var_168_11, arg_165_1.talkMaxDuration)

			if var_168_10 + 0.3 <= arg_165_1.time_ and arg_165_1.time_ < var_168_16 + var_168_17 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_16) / var_168_17

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_16 + var_168_17 and arg_165_1.time_ < var_168_16 + var_168_17 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "STwhite",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_165_1:InitPlayNodeList()
	end,
	Play116141042 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 116141042
		arg_171_1.duration_ = 7

		SetActive(arg_171_1.tipsGo_, false)

		function arg_171_1.onSingleLineFinish_()
			arg_171_1.onSingleLineUpdate_ = nil
			arg_171_1.onSingleLineFinish_ = nil
			arg_171_1.state_ = "waiting"
		end

		function arg_171_1.playNext_(arg_173_0)
			if arg_173_0 == 1 then
				arg_171_0:Play116141043(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 then
				local var_174_0 = arg_171_1.bgs_.ST07b

				arg_171_1.bgs_.ST07b.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_174_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_174_1 = var_174_0:GetComponent("SpriteRenderer")

				if var_174_1 and var_174_1.sprite then
					local var_174_2 = 2 * (var_174_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_174_0.transform.localScale = Vector3.New(var_174_2 / var_174_1.sprite.bounds.size.y < var_174_2 * manager.ui.mainCameraCom_.aspect / var_174_1.sprite.bounds.size.x and var_174_2 * manager.ui.mainCameraCom_.aspect / var_174_1.sprite.bounds.size.x or var_174_2 / var_174_1.sprite.bounds.size.y, var_174_2 / var_174_1.sprite.bounds.size.y < var_174_2 * manager.ui.mainCameraCom_.aspect / var_174_1.sprite.bounds.size.x and var_174_2 * manager.ui.mainCameraCom_.aspect / var_174_1.sprite.bounds.size.x or var_174_2 / var_174_1.sprite.bounds.size.y, 0)
				end

				for iter_174_0, iter_174_1 in pairs(arg_171_1.bgs_) do
					if iter_174_0 ~= "ST07b" then
						iter_174_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_174_3 = 0

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= var_174_3 + arg_174_0 then
				arg_171_1.mask_.enabled = true
				arg_171_1.mask_.raycastTarget = true

				arg_171_1:SetGaussion(false)
			end

			local var_174_4 = 2

			if var_174_3 <= arg_171_1.time_ and arg_171_1.time_ < var_174_3 + var_174_4 then
				local var_174_5 = Color.New(1, 1, 1)

				var_174_5.a = Mathf.Lerp(1, 0, (arg_171_1.time_ - var_174_3) / var_174_4)
				arg_171_1.mask_.color = var_174_5
			end

			if arg_171_1.time_ >= var_174_3 + var_174_4 and arg_171_1.time_ < var_174_3 + var_174_4 + arg_174_0 then
				local var_174_6 = Color.New(1, 1, 1)

				arg_171_1.mask_.enabled = false
				var_174_6.a = 0
				arg_171_1.mask_.color = var_174_6
			end

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 then
				arg_171_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_174_9 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_171_1.bgmTxt_.text ~= var_174_9 and arg_171_1.bgmTxt_.text ~= "" then
						if arg_171_1.bgmTxt2_.text ~= "" then
							arg_171_1.bgmTxt_.text = arg_171_1.bgmTxt2_.text
						end

						arg_171_1.bgmTxt2_.text = var_174_9

						arg_171_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_171_1.bgmTxt_.text = var_174_9
						arg_171_1.bgmTxt2_.text = var_174_9
					end

					if arg_171_1.bgmTimer then
						arg_171_1.bgmTimer:Stop()

						arg_171_1.bgmTimer = nil
					end

					if arg_171_1.settingData.show_music_name == 1 then
						arg_171_1.musicController:SetSelectedState("show")
						arg_171_1.musicAnimator_:Play("open", 0, 0)

						if arg_171_1.settingData.music_time ~= 0 then
							arg_171_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_171_1.settingData.music_time), function()
								if arg_171_1 == nil or isNil(arg_171_1.bgmTxt_) then
									return
								end

								arg_171_1.musicController:SetSelectedState("hide")
								arg_171_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_171_1.frameCnt_ <= 1 then
				arg_171_1.dialog_:SetActive(false)
			end

			local var_174_10 = 2
			local var_174_11 = 1.025

			if 2 < arg_171_1.time_ and arg_171_1.time_ <= var_174_10 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0

				arg_171_1.dialog_:SetActive(true)

				arg_171_1.dialogCg_.alpha = 0

				local var_174_12 = LeanTween.value(arg_171_1.dialog_, 0, 1, 0.3)

				var_174_12:setOnUpdate(LuaHelper.FloatAction(function(arg_176_0)
					arg_171_1.dialogCg_.alpha = arg_176_0
				end))
				var_174_12:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_171_1.dialog_)
					var_174_12:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_171_1.duration_ = arg_171_1.duration_ + 0.3

				SetActive(arg_171_1.leftNameGo_, false)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_171_1.iconTrs_.gameObject, false)
				arg_171_1.callingController_:SetSelectedState("normal")

				local var_174_13 = arg_171_1:FormatText(arg_171_1:GetWordFromCfg(116141042).content)

				arg_171_1.text_.text = var_174_13

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_15 = 41 <= 0 and var_174_11 or var_174_11 * (utf8.len(var_174_13) / 41)

				if (41 <= 0 and var_174_11 or var_174_11 * (utf8.len(var_174_13) / 41)) > 0 and var_174_11 < var_174_15 then
					arg_171_1.talkMaxDuration = var_174_15
					var_174_10 = var_174_10 + 0.3

					if var_174_15 + var_174_10 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_15 + var_174_10
					end
				end

				arg_171_1.text_.text = var_174_13
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)
				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_16 = var_174_10 + 0.3
			local var_174_17 = math.max(var_174_11, arg_171_1.talkMaxDuration)

			if var_174_10 + 0.3 <= arg_171_1.time_ and arg_171_1.time_ < var_174_16 + var_174_17 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - var_174_16) / var_174_17

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= var_174_16 + var_174_17 and arg_171_1.time_ < var_174_16 + var_174_17 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {}

		arg_171_1:InitPlayNodeList()
	end,
	Play116141043 = function(arg_178_0, arg_178_1)
		arg_178_1.time_ = 0
		arg_178_1.frameCnt_ = 0
		arg_178_1.state_ = "playing"
		arg_178_1.curTalkId_ = 116141043
		arg_178_1.duration_ = 5

		SetActive(arg_178_1.tipsGo_, false)

		function arg_178_1.onSingleLineFinish_()
			arg_178_1.onSingleLineUpdate_ = nil
			arg_178_1.onSingleLineFinish_ = nil
			arg_178_1.state_ = "waiting"
		end

		function arg_178_1.playNext_(arg_180_0)
			if arg_180_0 == 1 then
				arg_178_0:Play116141044(arg_178_1)
			end
		end

		function arg_178_1.onSingleLineUpdate_(arg_181_0)
			local var_181_0 = 0.725

			if 0 < arg_178_1.time_ and arg_178_1.time_ <= 0 + arg_181_0 then
				arg_178_1.talkMaxDuration = 0
				arg_178_1.dialogCg_.alpha = 1

				arg_178_1.dialog_:SetActive(true)
				SetActive(arg_178_1.leftNameGo_, false)

				arg_178_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_178_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_178_1:RecordName(arg_178_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_178_1.iconTrs_.gameObject, false)
				arg_178_1.callingController_:SetSelectedState("normal")

				local var_181_1 = arg_178_1:FormatText(arg_178_1:GetWordFromCfg(116141043).content)

				arg_178_1.text_.text = var_181_1

				LuaForUtil.ClearLinePrefixSymbol(arg_178_1.text_)

				local var_181_3 = 29 <= 0 and var_181_0 or var_181_0 * (utf8.len(var_181_1) / 29)

				if (29 <= 0 and var_181_0 or var_181_0 * (utf8.len(var_181_1) / 29)) > 0 and var_181_0 < var_181_3 then
					arg_178_1.talkMaxDuration = var_181_3

					if var_181_3 + 0 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_3 + 0
					end
				end

				arg_178_1.text_.text = var_181_1
				arg_178_1.typewritter.percent = 0

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(false)
				arg_178_1:RecordContent(arg_178_1.text_.text)
			end

			local var_181_4 = math.max(var_181_0, arg_178_1.talkMaxDuration)

			if 0 <= arg_178_1.time_ and arg_178_1.time_ < 0 + var_181_4 then
				arg_178_1.typewritter.percent = (arg_178_1.time_ - 0) / var_181_4

				arg_178_1.typewritter:SetDirty()
			end

			if arg_178_1.time_ >= 0 + var_181_4 and arg_178_1.time_ < 0 + var_181_4 + arg_181_0 then
				arg_178_1.typewritter.percent = 1

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(true)
			end
		end

		arg_178_1.nodeConfigList_ = {}

		arg_178_1:InitPlayNodeList()
	end,
	Play116141044 = function(arg_182_0, arg_182_1)
		arg_182_1.time_ = 0
		arg_182_1.frameCnt_ = 0
		arg_182_1.state_ = "playing"
		arg_182_1.curTalkId_ = 116141044
		arg_182_1.duration_ = 5

		SetActive(arg_182_1.tipsGo_, false)

		function arg_182_1.onSingleLineFinish_()
			arg_182_1.onSingleLineUpdate_ = nil
			arg_182_1.onSingleLineFinish_ = nil
			arg_182_1.state_ = "waiting"
		end

		function arg_182_1.playNext_(arg_184_0)
			if arg_184_0 == 1 then
				arg_182_0:Play116141045(arg_182_1)
			end
		end

		function arg_182_1.onSingleLineUpdate_(arg_185_0)
			if 0 < arg_182_1.time_ and arg_182_1.time_ <= 0 + arg_185_0 then
				arg_182_1:AudioAction("play", "effect", "se_story_16", "se_story_16_door04", "")
			end

			if 0.433333333333333 < arg_182_1.time_ and arg_182_1.time_ <= 0.433333333333333 + arg_185_0 then
				arg_182_1:AudioAction("play", "effect", "se_story_16", "se_story_16_arch", "")
			end

			local var_185_2 = 0
			local var_185_3 = 0.775

			if 0 < arg_182_1.time_ and arg_182_1.time_ <= var_185_2 + arg_185_0 then
				arg_182_1.talkMaxDuration = 0
				arg_182_1.dialogCg_.alpha = 1

				arg_182_1.dialog_:SetActive(true)
				SetActive(arg_182_1.leftNameGo_, false)

				arg_182_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_182_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_182_1:RecordName(arg_182_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_182_1.iconTrs_.gameObject, false)
				arg_182_1.callingController_:SetSelectedState("normal")

				local var_185_4 = arg_182_1:FormatText(arg_182_1:GetWordFromCfg(116141044).content)

				arg_182_1.text_.text = var_185_4

				LuaForUtil.ClearLinePrefixSymbol(arg_182_1.text_)

				local var_185_6 = 31 <= 0 and var_185_3 or var_185_3 * (utf8.len(var_185_4) / 31)

				if (31 <= 0 and var_185_3 or var_185_3 * (utf8.len(var_185_4) / 31)) > 0 and var_185_3 < var_185_6 then
					arg_182_1.talkMaxDuration = var_185_6

					if var_185_6 + var_185_2 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_6 + var_185_2
					end
				end

				arg_182_1.text_.text = var_185_4
				arg_182_1.typewritter.percent = 0

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(false)
				arg_182_1:RecordContent(arg_182_1.text_.text)
			end

			local var_185_7 = math.max(var_185_3, arg_182_1.talkMaxDuration)

			if var_185_2 <= arg_182_1.time_ and arg_182_1.time_ < var_185_2 + var_185_7 then
				arg_182_1.typewritter.percent = (arg_182_1.time_ - var_185_2) / var_185_7

				arg_182_1.typewritter:SetDirty()
			end

			if arg_182_1.time_ >= var_185_2 + var_185_7 and arg_182_1.time_ < var_185_2 + var_185_7 + arg_185_0 then
				arg_182_1.typewritter.percent = 1

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(true)
			end
		end

		arg_182_1.nodeConfigList_ = {}

		arg_182_1:InitPlayNodeList()
	end,
	Play116141045 = function(arg_186_0, arg_186_1)
		arg_186_1.time_ = 0
		arg_186_1.frameCnt_ = 0
		arg_186_1.state_ = "playing"
		arg_186_1.curTalkId_ = 116141045
		arg_186_1.duration_ = 2.43

		local var_186_0 = {
			zh = 2.433,
			ja = 2.366
		}
		local var_186_1 = manager.audio:GetLocalizationFlag()

		if var_186_0[var_186_1] ~= nil then
			arg_186_1.duration_ = var_186_0[var_186_1]
		end

		SetActive(arg_186_1.tipsGo_, false)

		function arg_186_1.onSingleLineFinish_()
			arg_186_1.onSingleLineUpdate_ = nil
			arg_186_1.onSingleLineFinish_ = nil
			arg_186_1.state_ = "waiting"
		end

		function arg_186_1.playNext_(arg_188_0)
			if arg_188_0 == 1 then
				arg_186_0:Play116141046(arg_186_1)
			end
		end

		function arg_186_1.onSingleLineUpdate_(arg_189_0)
			if 0 < arg_186_1.time_ and arg_186_1.time_ <= 0 + arg_189_0 then
				arg_186_1.var_.moveOldPos1059ui_story = arg_186_1.actors_["1059ui_story"].transform.localPosition
			end

			local var_189_0 = 0.001

			if 0 <= arg_186_1.time_ and arg_186_1.time_ < 0 + var_189_0 then
				arg_186_1.actors_["1059ui_story"].transform.localPosition = Vector3.Lerp(arg_186_1.var_.moveOldPos1059ui_story, Vector3.New(-0.7, -1.05, -6), (arg_186_1.time_ - 0) / var_189_0)
				arg_186_1.actors_["1059ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_186_1.actors_["1059ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_186_1.actors_["1059ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_186_1.actors_["1059ui_story"].transform.position).z)
				arg_186_1.actors_["1059ui_story"].transform.localEulerAngles.z = 0
				arg_186_1.actors_["1059ui_story"].transform.localEulerAngles.x = 0
				arg_186_1.actors_["1059ui_story"].transform.localEulerAngles = arg_186_1.actors_["1059ui_story"].transform.localEulerAngles
			end

			if arg_186_1.time_ >= 0 + var_189_0 and arg_186_1.time_ < 0 + var_189_0 + arg_189_0 then
				arg_186_1.actors_["1059ui_story"].transform.localPosition = Vector3.New(-0.7, -1.05, -6)
				arg_186_1.actors_["1059ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_186_1.actors_["1059ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_186_1.actors_["1059ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_186_1.actors_["1059ui_story"].transform.position).z)
				arg_186_1.actors_["1059ui_story"].transform.localEulerAngles.z = 0
				arg_186_1.actors_["1059ui_story"].transform.localEulerAngles.x = 0
				arg_186_1.actors_["1059ui_story"].transform.localEulerAngles = arg_186_1.actors_["1059ui_story"].transform.localEulerAngles
			end

			local var_189_1 = arg_186_1.actors_["1059ui_story"]

			if 0 < arg_186_1.time_ and arg_186_1.time_ <= 0 + arg_189_0 and not isNil(var_189_1) and arg_186_1.var_.characterEffect1059ui_story == nil then
				arg_186_1.var_.characterEffect1059ui_story = var_189_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_189_2 = 0.2

			if 0 <= arg_186_1.time_ and arg_186_1.time_ < 0 + var_189_2 and not isNil(var_189_1) then
				if arg_186_1.var_.characterEffect1059ui_story and not isNil(var_189_1) then
					arg_186_1.var_.characterEffect1059ui_story.fillFlat = false
				end
			end

			if arg_186_1.time_ >= 0 + var_189_2 and arg_186_1.time_ < 0 + var_189_2 + arg_189_0 and not isNil(var_189_1) and arg_186_1.var_.characterEffect1059ui_story then
				arg_186_1.var_.characterEffect1059ui_story.fillFlat = false
			end

			if 0 < arg_186_1.time_ and arg_186_1.time_ <= 0 + arg_189_0 then
				arg_186_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/story1059/story1059action/1059action1_1")
			end

			if 0 < arg_186_1.time_ and arg_186_1.time_ <= 0 + arg_189_0 then
				arg_186_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			if 0 < arg_186_1.time_ and arg_186_1.time_ <= 0 + arg_189_0 then
				arg_186_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_189_6 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_186_1.bgmTxt_.text ~= var_189_6 and arg_186_1.bgmTxt_.text ~= "" then
						if arg_186_1.bgmTxt2_.text ~= "" then
							arg_186_1.bgmTxt_.text = arg_186_1.bgmTxt2_.text
						end

						arg_186_1.bgmTxt2_.text = var_189_6

						arg_186_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_186_1.bgmTxt_.text = var_189_6
						arg_186_1.bgmTxt2_.text = var_189_6
					end

					if arg_186_1.bgmTimer then
						arg_186_1.bgmTimer:Stop()

						arg_186_1.bgmTimer = nil
					end

					if arg_186_1.settingData.show_music_name == 1 then
						arg_186_1.musicController:SetSelectedState("show")
						arg_186_1.musicAnimator_:Play("open", 0, 0)

						if arg_186_1.settingData.music_time ~= 0 then
							arg_186_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_186_1.settingData.music_time), function()
								if arg_186_1 == nil or isNil(arg_186_1.bgmTxt_) then
									return
								end

								arg_186_1.musicController:SetSelectedState("hide")
								arg_186_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.225 < arg_186_1.time_ and arg_186_1.time_ <= 0.225 + arg_189_0 then
				arg_186_1:AudioAction("play", "music", "bgm_activity_1_6_story_intense", "bgm_activity_1_6_story_intense", "bgm_activity_1_6_story_intense.awb")

				local var_189_9 = manager.audio:GetAudioName("bgm_activity_1_6_story_intense", "bgm_activity_1_6_story_intense")

				if "" ~= "" then
					if arg_186_1.bgmTxt_.text ~= var_189_9 and arg_186_1.bgmTxt_.text ~= "" then
						if arg_186_1.bgmTxt2_.text ~= "" then
							arg_186_1.bgmTxt_.text = arg_186_1.bgmTxt2_.text
						end

						arg_186_1.bgmTxt2_.text = var_189_9

						arg_186_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_186_1.bgmTxt_.text = var_189_9
						arg_186_1.bgmTxt2_.text = var_189_9
					end

					if arg_186_1.bgmTimer then
						arg_186_1.bgmTimer:Stop()

						arg_186_1.bgmTimer = nil
					end

					if arg_186_1.settingData.show_music_name == 1 then
						arg_186_1.musicController:SetSelectedState("show")
						arg_186_1.musicAnimator_:Play("open", 0, 0)

						if arg_186_1.settingData.music_time ~= 0 then
							arg_186_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_186_1.settingData.music_time), function()
								if arg_186_1 == nil or isNil(arg_186_1.bgmTxt_) then
									return
								end

								arg_186_1.musicController:SetSelectedState("hide")
								arg_186_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.366666666666667 < arg_186_1.time_ and arg_186_1.time_ <= 0.366666666666667 + arg_189_0 then
				arg_186_1:AudioAction("play", "music", "bgm_activity_1_6_story_intense", "OG", "bgm_activity_1_6_story_intense.awb")

				local var_189_12 = manager.audio:GetAudioName("bgm_activity_1_6_story_intense", "OG")

				if "" ~= "" then
					if arg_186_1.bgmTxt_.text ~= var_189_12 and arg_186_1.bgmTxt_.text ~= "" then
						if arg_186_1.bgmTxt2_.text ~= "" then
							arg_186_1.bgmTxt_.text = arg_186_1.bgmTxt2_.text
						end

						arg_186_1.bgmTxt2_.text = var_189_12

						arg_186_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_186_1.bgmTxt_.text = var_189_12
						arg_186_1.bgmTxt2_.text = var_189_12
					end

					if arg_186_1.bgmTimer then
						arg_186_1.bgmTimer:Stop()

						arg_186_1.bgmTimer = nil
					end

					if arg_186_1.settingData.show_music_name == 1 then
						arg_186_1.musicController:SetSelectedState("show")
						arg_186_1.musicAnimator_:Play("open", 0, 0)

						if arg_186_1.settingData.music_time ~= 0 then
							arg_186_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_186_1.settingData.music_time), function()
								if arg_186_1 == nil or isNil(arg_186_1.bgmTxt_) then
									return
								end

								arg_186_1.musicController:SetSelectedState("hide")
								arg_186_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_189_13 = 0
			local var_189_14 = 0.225

			if 0 < arg_186_1.time_ and arg_186_1.time_ <= var_189_13 + arg_189_0 then
				arg_186_1.talkMaxDuration = 0
				arg_186_1.dialogCg_.alpha = 1

				arg_186_1.dialog_:SetActive(true)
				SetActive(arg_186_1.leftNameGo_, true)

				arg_186_1.leftNameTxt_.text = arg_186_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_186_1.leftNameTxt_.transform)

				arg_186_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_186_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_186_1:RecordName(arg_186_1.leftNameTxt_.text)
				SetActive(arg_186_1.iconTrs_.gameObject, false)
				arg_186_1.callingController_:SetSelectedState("normal")

				local var_189_15 = arg_186_1:GetWordFromCfg(116141045)
				local var_189_16 = arg_186_1:FormatText(var_189_15.content)

				arg_186_1.text_.text = var_189_16

				LuaForUtil.ClearLinePrefixSymbol(arg_186_1.text_)

				local var_189_18 = 9 <= 0 and var_189_14 or var_189_14 * (utf8.len(var_189_16) / 9)

				if (9 <= 0 and var_189_14 or var_189_14 * (utf8.len(var_189_16) / 9)) > 0 and var_189_14 < var_189_18 then
					arg_186_1.talkMaxDuration = var_189_18

					if var_189_18 + var_189_13 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_18 + var_189_13
					end
				end

				arg_186_1.text_.text = var_189_16
				arg_186_1.typewritter.percent = 0

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116141", "116141045", "story_v_out_116141.awb") ~= 0 then
					local var_189_19 = manager.audio:GetVoiceLength("story_v_out_116141", "116141045", "story_v_out_116141.awb") / 1000

					if var_189_19 + var_189_13 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_19 + var_189_13
					end

					if var_189_15.prefab_name ~= "" and arg_186_1.actors_[var_189_15.prefab_name] ~= nil then
						local var_189_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_186_1.actors_[var_189_15.prefab_name].transform, "story_v_out_116141", "116141045", "story_v_out_116141.awb")

						arg_186_1:RecordAudio("116141045", var_189_20)
						arg_186_1:RecordAudio("116141045", var_189_20)
					else
						arg_186_1:AudioAction("play", "voice", "story_v_out_116141", "116141045", "story_v_out_116141.awb")
					end

					arg_186_1:RecordHistoryTalkVoice("story_v_out_116141", "116141045", "story_v_out_116141.awb")
				end

				arg_186_1:RecordContent(arg_186_1.text_.text)
			end

			local var_189_21 = math.max(var_189_14, arg_186_1.talkMaxDuration)

			if var_189_13 <= arg_186_1.time_ and arg_186_1.time_ < var_189_13 + var_189_21 then
				arg_186_1.typewritter.percent = (arg_186_1.time_ - var_189_13) / var_189_21

				arg_186_1.typewritter:SetDirty()
			end

			if arg_186_1.time_ >= var_189_13 + var_189_21 and arg_186_1.time_ < var_189_13 + var_189_21 + arg_189_0 then
				arg_186_1.typewritter.percent = 1

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(true)
			end
		end

		arg_186_1.nodeConfigList_ = {
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

		arg_186_1:InitPlayNodeList()
	end,
	Play116141046 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 116141046
		arg_193_1.duration_ = 6.13

		local var_193_0 = {
			zh = 4.9,
			ja = 6.133
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
				arg_193_0:Play116141047(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 and not isNil(arg_193_1.actors_["1028ui_story"]) and arg_193_1.var_.characterEffect1028ui_story == nil then
				arg_193_1.var_.characterEffect1028ui_story = arg_193_1.actors_["1028ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_196_0 = 0.2

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_0 and not isNil(arg_193_1.actors_["1028ui_story"]) then
				if arg_193_1.var_.characterEffect1028ui_story and not isNil(arg_193_1.actors_["1028ui_story"]) then
					arg_193_1.var_.characterEffect1028ui_story.fillFlat = false
				end
			end

			if arg_193_1.time_ >= 0 + var_196_0 and arg_193_1.time_ < 0 + var_196_0 + arg_196_0 and not isNil(arg_193_1.actors_["1028ui_story"]) and arg_193_1.var_.characterEffect1028ui_story then
				arg_193_1.var_.characterEffect1028ui_story.fillFlat = false
			end

			local var_196_2 = arg_193_1.actors_["1059ui_story"]

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 and not isNil(var_196_2) and arg_193_1.var_.characterEffect1059ui_story == nil then
				arg_193_1.var_.characterEffect1059ui_story = var_196_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_196_3 = 0.2

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_3 and not isNil(var_196_2) then
				if arg_193_1.var_.characterEffect1059ui_story and not isNil(var_196_2) then
					arg_193_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_193_1.var_.characterEffect1059ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_193_1.time_ - 0) / var_196_3)
				end
			end

			if arg_193_1.time_ >= 0 + var_196_3 and arg_193_1.time_ < 0 + var_196_3 + arg_196_0 and not isNil(var_196_2) and arg_193_1.var_.characterEffect1059ui_story then
				arg_193_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_193_1.var_.characterEffect1059ui_story.fillRatio = 0.5
			end

			local var_196_4 = arg_193_1.actors_["1059ui_story"].transform

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				arg_193_1.var_.moveOldPos1059ui_story = var_196_4.localPosition
			end

			local var_196_5 = 0.001

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_5 then
				var_196_4.localPosition = Vector3.Lerp(arg_193_1.var_.moveOldPos1059ui_story, Vector3.New(-0.7, -1.05, -6), (arg_193_1.time_ - 0) / var_196_5)
				var_196_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_196_4.position).x, (manager.ui.mainCamera.transform.position - var_196_4.position).y, (manager.ui.mainCamera.transform.position - var_196_4.position).z)
				var_196_4.localEulerAngles.z = 0
				var_196_4.localEulerAngles.x = 0
				var_196_4.localEulerAngles = var_196_4.localEulerAngles
			end

			if arg_193_1.time_ >= 0 + var_196_5 and arg_193_1.time_ < 0 + var_196_5 + arg_196_0 then
				var_196_4.localPosition = Vector3.New(-0.7, -1.05, -6)
				var_196_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_196_4.position).x, (manager.ui.mainCamera.transform.position - var_196_4.position).y, (manager.ui.mainCamera.transform.position - var_196_4.position).z)
				var_196_4.localEulerAngles.z = 0
				var_196_4.localEulerAngles.x = 0
				var_196_4.localEulerAngles = var_196_4.localEulerAngles
			end

			local var_196_6 = arg_193_1.actors_["1028ui_story"].transform

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				arg_193_1.var_.moveOldPos1028ui_story = var_196_6.localPosition
			end

			local var_196_7 = 0.001

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_7 then
				var_196_6.localPosition = Vector3.Lerp(arg_193_1.var_.moveOldPos1028ui_story, Vector3.New(0.7, -0.9, -5.9), (arg_193_1.time_ - 0) / var_196_7)
				var_196_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_196_6.position).x, (manager.ui.mainCamera.transform.position - var_196_6.position).y, (manager.ui.mainCamera.transform.position - var_196_6.position).z)
				var_196_6.localEulerAngles.z = 0
				var_196_6.localEulerAngles.x = 0
				var_196_6.localEulerAngles = var_196_6.localEulerAngles
			end

			if arg_193_1.time_ >= 0 + var_196_7 and arg_193_1.time_ < 0 + var_196_7 + arg_196_0 then
				var_196_6.localPosition = Vector3.New(0.7, -0.9, -5.9)
				var_196_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_196_6.position).x, (manager.ui.mainCamera.transform.position - var_196_6.position).y, (manager.ui.mainCamera.transform.position - var_196_6.position).z)
				var_196_6.localEulerAngles.z = 0
				var_196_6.localEulerAngles.x = 0
				var_196_6.localEulerAngles = var_196_6.localEulerAngles
			end

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				arg_193_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/story1028/story1028action/1028action1_1")
			end

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				arg_193_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_196_8 = 0
			local var_196_9 = 0.475

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= var_196_8 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, true)

				arg_193_1.leftNameTxt_.text = arg_193_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_193_1.leftNameTxt_.transform)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1.leftNameTxt_.text)
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_10 = arg_193_1:GetWordFromCfg(116141046)
				local var_196_11 = arg_193_1:FormatText(var_196_10.content)

				arg_193_1.text_.text = var_196_11

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_13 = 19 <= 0 and var_196_9 or var_196_9 * (utf8.len(var_196_11) / 19)

				if (19 <= 0 and var_196_9 or var_196_9 * (utf8.len(var_196_11) / 19)) > 0 and var_196_9 < var_196_13 then
					arg_193_1.talkMaxDuration = var_196_13

					if var_196_13 + var_196_8 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_13 + var_196_8
					end
				end

				arg_193_1.text_.text = var_196_11
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116141", "116141046", "story_v_out_116141.awb") ~= 0 then
					local var_196_14 = manager.audio:GetVoiceLength("story_v_out_116141", "116141046", "story_v_out_116141.awb") / 1000

					if var_196_14 + var_196_8 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_14 + var_196_8
					end

					if var_196_10.prefab_name ~= "" and arg_193_1.actors_[var_196_10.prefab_name] ~= nil then
						local var_196_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_193_1.actors_[var_196_10.prefab_name].transform, "story_v_out_116141", "116141046", "story_v_out_116141.awb")

						arg_193_1:RecordAudio("116141046", var_196_15)
						arg_193_1:RecordAudio("116141046", var_196_15)
					else
						arg_193_1:AudioAction("play", "voice", "story_v_out_116141", "116141046", "story_v_out_116141.awb")
					end

					arg_193_1:RecordHistoryTalkVoice("story_v_out_116141", "116141046", "story_v_out_116141.awb")
				end

				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_16 = math.max(var_196_9, arg_193_1.talkMaxDuration)

			if var_196_8 <= arg_193_1.time_ and arg_193_1.time_ < var_196_8 + var_196_16 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - var_196_8) / var_196_16

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= var_196_8 + var_196_16 and arg_193_1.time_ < var_196_8 + var_196_16 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {
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
			}
		}

		arg_193_1:InitPlayNodeList()
	end,
	Play116141047 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 116141047
		arg_197_1.duration_ = 4.63

		local var_197_0 = {
			zh = 4.633,
			ja = 3.2
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
				arg_197_0:Play116141048(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 and not isNil(arg_197_1.actors_["1028ui_story"]) and arg_197_1.var_.characterEffect1028ui_story == nil then
				arg_197_1.var_.characterEffect1028ui_story = arg_197_1.actors_["1028ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_200_0 = 0.2

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_0 and not isNil(arg_197_1.actors_["1028ui_story"]) then
				if arg_197_1.var_.characterEffect1028ui_story and not isNil(arg_197_1.actors_["1028ui_story"]) then
					arg_197_1.var_.characterEffect1028ui_story.fillFlat = true
					arg_197_1.var_.characterEffect1028ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_197_1.time_ - 0) / var_200_0)
				end
			end

			if arg_197_1.time_ >= 0 + var_200_0 and arg_197_1.time_ < 0 + var_200_0 + arg_200_0 and not isNil(arg_197_1.actors_["1028ui_story"]) and arg_197_1.var_.characterEffect1028ui_story then
				arg_197_1.var_.characterEffect1028ui_story.fillFlat = true
				arg_197_1.var_.characterEffect1028ui_story.fillRatio = 0.5
			end

			local var_200_1 = arg_197_1.actors_["1059ui_story"]

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 and not isNil(var_200_1) and arg_197_1.var_.characterEffect1059ui_story == nil then
				arg_197_1.var_.characterEffect1059ui_story = var_200_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_200_2 = 0.2

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_2 and not isNil(var_200_1) then
				if arg_197_1.var_.characterEffect1059ui_story and not isNil(var_200_1) then
					arg_197_1.var_.characterEffect1059ui_story.fillFlat = false
				end
			end

			if arg_197_1.time_ >= 0 + var_200_2 and arg_197_1.time_ < 0 + var_200_2 + arg_200_0 and not isNil(var_200_1) and arg_197_1.var_.characterEffect1059ui_story then
				arg_197_1.var_.characterEffect1059ui_story.fillFlat = false
			end

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				arg_197_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/story1059/story1059action/1059action1_1")
			end

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				arg_197_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_200_4 = 0
			local var_200_5 = 0.425

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= var_200_4 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, true)

				arg_197_1.leftNameTxt_.text = arg_197_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, false)
				arg_197_1.callingController_:SetSelectedState("normal")

				local var_200_6 = arg_197_1:GetWordFromCfg(116141047)
				local var_200_7 = arg_197_1:FormatText(var_200_6.content)

				arg_197_1.text_.text = var_200_7

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_9 = 17 <= 0 and var_200_5 or var_200_5 * (utf8.len(var_200_7) / 17)

				if (17 <= 0 and var_200_5 or var_200_5 * (utf8.len(var_200_7) / 17)) > 0 and var_200_5 < var_200_9 then
					arg_197_1.talkMaxDuration = var_200_9

					if var_200_9 + var_200_4 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_9 + var_200_4
					end
				end

				arg_197_1.text_.text = var_200_7
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116141", "116141047", "story_v_out_116141.awb") ~= 0 then
					local var_200_10 = manager.audio:GetVoiceLength("story_v_out_116141", "116141047", "story_v_out_116141.awb") / 1000

					if var_200_10 + var_200_4 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_10 + var_200_4
					end

					if var_200_6.prefab_name ~= "" and arg_197_1.actors_[var_200_6.prefab_name] ~= nil then
						local var_200_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_197_1.actors_[var_200_6.prefab_name].transform, "story_v_out_116141", "116141047", "story_v_out_116141.awb")

						arg_197_1:RecordAudio("116141047", var_200_11)
						arg_197_1:RecordAudio("116141047", var_200_11)
					else
						arg_197_1:AudioAction("play", "voice", "story_v_out_116141", "116141047", "story_v_out_116141.awb")
					end

					arg_197_1:RecordHistoryTalkVoice("story_v_out_116141", "116141047", "story_v_out_116141.awb")
				end

				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_12 = math.max(var_200_5, arg_197_1.talkMaxDuration)

			if var_200_4 <= arg_197_1.time_ and arg_197_1.time_ < var_200_4 + var_200_12 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - var_200_4) / var_200_12

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= var_200_4 + var_200_12 and arg_197_1.time_ < var_200_4 + var_200_12 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {}

		arg_197_1:InitPlayNodeList()
	end,
	Play116141048 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 116141048
		arg_201_1.duration_ = 8.33

		local var_201_0 = {
			zh = 8.333,
			ja = 4.966
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
				arg_201_0:Play116141049(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 and not isNil(arg_201_1.actors_["1028ui_story"]) and arg_201_1.var_.characterEffect1028ui_story == nil then
				arg_201_1.var_.characterEffect1028ui_story = arg_201_1.actors_["1028ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_204_0 = 0.2

			if 0 <= arg_201_1.time_ and arg_201_1.time_ < 0 + var_204_0 and not isNil(arg_201_1.actors_["1028ui_story"]) then
				if arg_201_1.var_.characterEffect1028ui_story and not isNil(arg_201_1.actors_["1028ui_story"]) then
					arg_201_1.var_.characterEffect1028ui_story.fillFlat = false
				end
			end

			if arg_201_1.time_ >= 0 + var_204_0 and arg_201_1.time_ < 0 + var_204_0 + arg_204_0 and not isNil(arg_201_1.actors_["1028ui_story"]) and arg_201_1.var_.characterEffect1028ui_story then
				arg_201_1.var_.characterEffect1028ui_story.fillFlat = false
			end

			local var_204_2 = arg_201_1.actors_["1059ui_story"]

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 and not isNil(var_204_2) and arg_201_1.var_.characterEffect1059ui_story == nil then
				arg_201_1.var_.characterEffect1059ui_story = var_204_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_204_3 = 0.2

			if 0 <= arg_201_1.time_ and arg_201_1.time_ < 0 + var_204_3 and not isNil(var_204_2) then
				if arg_201_1.var_.characterEffect1059ui_story and not isNil(var_204_2) then
					arg_201_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_201_1.var_.characterEffect1059ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_201_1.time_ - 0) / var_204_3)
				end
			end

			if arg_201_1.time_ >= 0 + var_204_3 and arg_201_1.time_ < 0 + var_204_3 + arg_204_0 and not isNil(var_204_2) and arg_201_1.var_.characterEffect1059ui_story then
				arg_201_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_201_1.var_.characterEffect1059ui_story.fillRatio = 0.5
			end

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 then
				arg_201_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/story1028/story1028action/1028action2_1")
			end

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 then
				arg_201_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_204_4 = arg_201_1.actors_["1028ui_story"].transform

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 then
				arg_201_1.var_.moveOldPos1028ui_story = var_204_4.localPosition

				arg_201_1:ShowWeapon(arg_201_1.var_["1028ui_story" .. "Animator"].transform, true)
			end

			local var_204_5 = 0.001

			if 0 <= arg_201_1.time_ and arg_201_1.time_ < 0 + var_204_5 then
				var_204_4.localPosition = Vector3.Lerp(arg_201_1.var_.moveOldPos1028ui_story, Vector3.New(0.7, -0.9, -5.9), (arg_201_1.time_ - 0) / var_204_5)
				var_204_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_204_4.position).x, (manager.ui.mainCamera.transform.position - var_204_4.position).y, (manager.ui.mainCamera.transform.position - var_204_4.position).z)
				var_204_4.localEulerAngles.z = 0
				var_204_4.localEulerAngles.x = 0
				var_204_4.localEulerAngles = var_204_4.localEulerAngles
			end

			if arg_201_1.time_ >= 0 + var_204_5 and arg_201_1.time_ < 0 + var_204_5 + arg_204_0 then
				var_204_4.localPosition = Vector3.New(0.7, -0.9, -5.9)
				var_204_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_204_4.position).x, (manager.ui.mainCamera.transform.position - var_204_4.position).y, (manager.ui.mainCamera.transform.position - var_204_4.position).z)
				var_204_4.localEulerAngles.z = 0
				var_204_4.localEulerAngles.x = 0
				var_204_4.localEulerAngles = var_204_4.localEulerAngles
			end

			local var_204_6 = 0
			local var_204_7 = 0.375

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= var_204_6 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, true)

				arg_201_1.leftNameTxt_.text = arg_201_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_201_1.leftNameTxt_.transform)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1.leftNameTxt_.text)
				SetActive(arg_201_1.iconTrs_.gameObject, false)
				arg_201_1.callingController_:SetSelectedState("normal")

				local var_204_8 = arg_201_1:GetWordFromCfg(116141048)
				local var_204_9 = arg_201_1:FormatText(var_204_8.content)

				arg_201_1.text_.text = var_204_9

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_11 = 15 <= 0 and var_204_7 or var_204_7 * (utf8.len(var_204_9) / 15)

				if (15 <= 0 and var_204_7 or var_204_7 * (utf8.len(var_204_9) / 15)) > 0 and var_204_7 < var_204_11 then
					arg_201_1.talkMaxDuration = var_204_11

					if var_204_11 + var_204_6 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_11 + var_204_6
					end
				end

				arg_201_1.text_.text = var_204_9
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116141", "116141048", "story_v_out_116141.awb") ~= 0 then
					local var_204_12 = manager.audio:GetVoiceLength("story_v_out_116141", "116141048", "story_v_out_116141.awb") / 1000

					if var_204_12 + var_204_6 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_12 + var_204_6
					end

					if var_204_8.prefab_name ~= "" and arg_201_1.actors_[var_204_8.prefab_name] ~= nil then
						local var_204_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_201_1.actors_[var_204_8.prefab_name].transform, "story_v_out_116141", "116141048", "story_v_out_116141.awb")

						arg_201_1:RecordAudio("116141048", var_204_13)
						arg_201_1:RecordAudio("116141048", var_204_13)
					else
						arg_201_1:AudioAction("play", "voice", "story_v_out_116141", "116141048", "story_v_out_116141.awb")
					end

					arg_201_1:RecordHistoryTalkVoice("story_v_out_116141", "116141048", "story_v_out_116141.awb")
				end

				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_14 = math.max(var_204_7, arg_201_1.talkMaxDuration)

			if var_204_6 <= arg_201_1.time_ and arg_201_1.time_ < var_204_6 + var_204_14 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - var_204_6) / var_204_14

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= var_204_6 + var_204_14 and arg_201_1.time_ < var_204_6 + var_204_14 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1028ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_201_1:InitPlayNodeList()
	end,
	Play116141049 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 116141049
		arg_205_1.duration_ = 11.53

		local var_205_0 = {
			zh = 10.6,
			ja = 11.533
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
				arg_205_0:Play116141050(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 and not isNil(arg_205_1.actors_["1028ui_story"]) and arg_205_1.var_.characterEffect1028ui_story == nil then
				arg_205_1.var_.characterEffect1028ui_story = arg_205_1.actors_["1028ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_208_0 = 0.2

			if 0 <= arg_205_1.time_ and arg_205_1.time_ < 0 + var_208_0 and not isNil(arg_205_1.actors_["1028ui_story"]) then
				if arg_205_1.var_.characterEffect1028ui_story and not isNil(arg_205_1.actors_["1028ui_story"]) then
					arg_205_1.var_.characterEffect1028ui_story.fillFlat = true
					arg_205_1.var_.characterEffect1028ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_205_1.time_ - 0) / var_208_0)
				end
			end

			if arg_205_1.time_ >= 0 + var_208_0 and arg_205_1.time_ < 0 + var_208_0 + arg_208_0 and not isNil(arg_205_1.actors_["1028ui_story"]) and arg_205_1.var_.characterEffect1028ui_story then
				arg_205_1.var_.characterEffect1028ui_story.fillFlat = true
				arg_205_1.var_.characterEffect1028ui_story.fillRatio = 0.5
			end

			local var_208_1 = arg_205_1.actors_["1059ui_story"]

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 and not isNil(var_208_1) and arg_205_1.var_.characterEffect1059ui_story == nil then
				arg_205_1.var_.characterEffect1059ui_story = var_208_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_208_2 = 0.2

			if 0 <= arg_205_1.time_ and arg_205_1.time_ < 0 + var_208_2 and not isNil(var_208_1) then
				if arg_205_1.var_.characterEffect1059ui_story and not isNil(var_208_1) then
					arg_205_1.var_.characterEffect1059ui_story.fillFlat = false
				end
			end

			if arg_205_1.time_ >= 0 + var_208_2 and arg_205_1.time_ < 0 + var_208_2 + arg_208_0 and not isNil(var_208_1) and arg_205_1.var_.characterEffect1059ui_story then
				arg_205_1.var_.characterEffect1059ui_story.fillFlat = false
			end

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 then
				arg_205_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/story1059/story1059action/1059action4_1")
			end

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 then
				arg_205_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_208_4 = 0
			local var_208_5 = 1.175

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= var_208_4 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, true)

				arg_205_1.leftNameTxt_.text = arg_205_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_205_1.leftNameTxt_.transform)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1.leftNameTxt_.text)
				SetActive(arg_205_1.iconTrs_.gameObject, false)
				arg_205_1.callingController_:SetSelectedState("normal")

				local var_208_6 = arg_205_1:GetWordFromCfg(116141049)
				local var_208_7 = arg_205_1:FormatText(var_208_6.content)

				arg_205_1.text_.text = var_208_7

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_9 = 47 <= 0 and var_208_5 or var_208_5 * (utf8.len(var_208_7) / 47)

				if (47 <= 0 and var_208_5 or var_208_5 * (utf8.len(var_208_7) / 47)) > 0 and var_208_5 < var_208_9 then
					arg_205_1.talkMaxDuration = var_208_9

					if var_208_9 + var_208_4 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_9 + var_208_4
					end
				end

				arg_205_1.text_.text = var_208_7
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116141", "116141049", "story_v_out_116141.awb") ~= 0 then
					local var_208_10 = manager.audio:GetVoiceLength("story_v_out_116141", "116141049", "story_v_out_116141.awb") / 1000

					if var_208_10 + var_208_4 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_10 + var_208_4
					end

					if var_208_6.prefab_name ~= "" and arg_205_1.actors_[var_208_6.prefab_name] ~= nil then
						local var_208_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_205_1.actors_[var_208_6.prefab_name].transform, "story_v_out_116141", "116141049", "story_v_out_116141.awb")

						arg_205_1:RecordAudio("116141049", var_208_11)
						arg_205_1:RecordAudio("116141049", var_208_11)
					else
						arg_205_1:AudioAction("play", "voice", "story_v_out_116141", "116141049", "story_v_out_116141.awb")
					end

					arg_205_1:RecordHistoryTalkVoice("story_v_out_116141", "116141049", "story_v_out_116141.awb")
				end

				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_12 = math.max(var_208_5, arg_205_1.talkMaxDuration)

			if var_208_4 <= arg_205_1.time_ and arg_205_1.time_ < var_208_4 + var_208_12 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - var_208_4) / var_208_12

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= var_208_4 + var_208_12 and arg_205_1.time_ < var_208_4 + var_208_12 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {}

		arg_205_1:InitPlayNodeList()
	end,
	Play116141050 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 116141050
		arg_209_1.duration_ = 5

		SetActive(arg_209_1.tipsGo_, false)

		function arg_209_1.onSingleLineFinish_()
			arg_209_1.onSingleLineUpdate_ = nil
			arg_209_1.onSingleLineFinish_ = nil
			arg_209_1.state_ = "waiting"
		end

		function arg_209_1.playNext_(arg_211_0)
			if arg_211_0 == 1 then
				arg_209_0:Play116141051(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1.var_.moveOldPos1028ui_story = arg_209_1.actors_["1028ui_story"].transform.localPosition
			end

			local var_212_0 = 0.001

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_0 then
				arg_209_1.actors_["1028ui_story"].transform.localPosition = Vector3.Lerp(arg_209_1.var_.moveOldPos1028ui_story, Vector3.New(0, 100, 0), (arg_209_1.time_ - 0) / var_212_0)
				arg_209_1.actors_["1028ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_209_1.actors_["1028ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_209_1.actors_["1028ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_209_1.actors_["1028ui_story"].transform.position).z)
				arg_209_1.actors_["1028ui_story"].transform.localEulerAngles.z = 0
				arg_209_1.actors_["1028ui_story"].transform.localEulerAngles.x = 0
				arg_209_1.actors_["1028ui_story"].transform.localEulerAngles = arg_209_1.actors_["1028ui_story"].transform.localEulerAngles
			end

			if arg_209_1.time_ >= 0 + var_212_0 and arg_209_1.time_ < 0 + var_212_0 + arg_212_0 then
				arg_209_1.actors_["1028ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_209_1.actors_["1028ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_209_1.actors_["1028ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_209_1.actors_["1028ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_209_1.actors_["1028ui_story"].transform.position).z)
				arg_209_1.actors_["1028ui_story"].transform.localEulerAngles.z = 0
				arg_209_1.actors_["1028ui_story"].transform.localEulerAngles.x = 0
				arg_209_1.actors_["1028ui_story"].transform.localEulerAngles = arg_209_1.actors_["1028ui_story"].transform.localEulerAngles
			end

			local var_212_1 = arg_209_1.actors_["1059ui_story"].transform

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1.var_.moveOldPos1059ui_story = var_212_1.localPosition
			end

			local var_212_2 = 0.001

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_2 then
				var_212_1.localPosition = Vector3.Lerp(arg_209_1.var_.moveOldPos1059ui_story, Vector3.New(0, 100, 0), (arg_209_1.time_ - 0) / var_212_2)
				var_212_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_212_1.position).x, (manager.ui.mainCamera.transform.position - var_212_1.position).y, (manager.ui.mainCamera.transform.position - var_212_1.position).z)
				var_212_1.localEulerAngles.z = 0
				var_212_1.localEulerAngles.x = 0
				var_212_1.localEulerAngles = var_212_1.localEulerAngles
			end

			if arg_209_1.time_ >= 0 + var_212_2 and arg_209_1.time_ < 0 + var_212_2 + arg_212_0 then
				var_212_1.localPosition = Vector3.New(0, 100, 0)
				var_212_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_212_1.position).x, (manager.ui.mainCamera.transform.position - var_212_1.position).y, (manager.ui.mainCamera.transform.position - var_212_1.position).z)
				var_212_1.localEulerAngles.z = 0
				var_212_1.localEulerAngles.x = 0
				var_212_1.localEulerAngles = var_212_1.localEulerAngles
			end

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1:AudioAction("play", "effect", "se_story_16", "se_story_16_shine", "")
			end

			local var_212_4 = 0
			local var_212_5 = 1.175

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= var_212_4 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, false)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_209_1.iconTrs_.gameObject, false)
				arg_209_1.callingController_:SetSelectedState("normal")

				local var_212_6 = arg_209_1:FormatText(arg_209_1:GetWordFromCfg(116141050).content)

				arg_209_1.text_.text = var_212_6

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_8 = 47 <= 0 and var_212_5 or var_212_5 * (utf8.len(var_212_6) / 47)

				if (47 <= 0 and var_212_5 or var_212_5 * (utf8.len(var_212_6) / 47)) > 0 and var_212_5 < var_212_8 then
					arg_209_1.talkMaxDuration = var_212_8

					if var_212_8 + var_212_4 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_8 + var_212_4
					end
				end

				arg_209_1.text_.text = var_212_6
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)
				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_9 = math.max(var_212_5, arg_209_1.talkMaxDuration)

			if var_212_4 <= arg_209_1.time_ and arg_209_1.time_ < var_212_4 + var_212_9 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - var_212_4) / var_212_9

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= var_212_4 + var_212_9 and arg_209_1.time_ < var_212_4 + var_212_9 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {
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
				actorName = "1059ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_209_1:InitPlayNodeList()
	end,
	Play116141051 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 116141051
		arg_213_1.duration_ = 2.47

		local var_213_0 = {
			zh = 2.466,
			ja = 2
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
				arg_213_0:Play116141052(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 and not isNil(arg_213_1.actors_["1028ui_story"]) and arg_213_1.var_.characterEffect1028ui_story == nil then
				arg_213_1.var_.characterEffect1028ui_story = arg_213_1.actors_["1028ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_216_0 = 0.2

			if 0 <= arg_213_1.time_ and arg_213_1.time_ < 0 + var_216_0 and not isNil(arg_213_1.actors_["1028ui_story"]) then
				if arg_213_1.var_.characterEffect1028ui_story and not isNil(arg_213_1.actors_["1028ui_story"]) then
					arg_213_1.var_.characterEffect1028ui_story.fillFlat = false
				end
			end

			if arg_213_1.time_ >= 0 + var_216_0 and arg_213_1.time_ < 0 + var_216_0 + arg_216_0 and not isNil(arg_213_1.actors_["1028ui_story"]) and arg_213_1.var_.characterEffect1028ui_story then
				arg_213_1.var_.characterEffect1028ui_story.fillFlat = false
			end

			local var_216_2 = arg_213_1.actors_["1059ui_story"]

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 and not isNil(var_216_2) and arg_213_1.var_.characterEffect1059ui_story == nil then
				arg_213_1.var_.characterEffect1059ui_story = var_216_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_216_3 = 0.2

			if 0 <= arg_213_1.time_ and arg_213_1.time_ < 0 + var_216_3 and not isNil(var_216_2) then
				if arg_213_1.var_.characterEffect1059ui_story and not isNil(var_216_2) then
					arg_213_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_213_1.var_.characterEffect1059ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_213_1.time_ - 0) / var_216_3)
				end
			end

			if arg_213_1.time_ >= 0 + var_216_3 and arg_213_1.time_ < 0 + var_216_3 + arg_216_0 and not isNil(var_216_2) and arg_213_1.var_.characterEffect1059ui_story then
				arg_213_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_213_1.var_.characterEffect1059ui_story.fillRatio = 0.5
			end

			local var_216_4 = arg_213_1.actors_["1028ui_story"].transform

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 then
				arg_213_1.var_.moveOldPos1028ui_story = var_216_4.localPosition
			end

			local var_216_5 = 0.001

			if 0 <= arg_213_1.time_ and arg_213_1.time_ < 0 + var_216_5 then
				var_216_4.localPosition = Vector3.Lerp(arg_213_1.var_.moveOldPos1028ui_story, Vector3.New(0.7, -0.9, -5.9), (arg_213_1.time_ - 0) / var_216_5)
				var_216_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_216_4.position).x, (manager.ui.mainCamera.transform.position - var_216_4.position).y, (manager.ui.mainCamera.transform.position - var_216_4.position).z)
				var_216_4.localEulerAngles.z = 0
				var_216_4.localEulerAngles.x = 0
				var_216_4.localEulerAngles = var_216_4.localEulerAngles
			end

			if arg_213_1.time_ >= 0 + var_216_5 and arg_213_1.time_ < 0 + var_216_5 + arg_216_0 then
				var_216_4.localPosition = Vector3.New(0.7, -0.9, -5.9)
				var_216_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_216_4.position).x, (manager.ui.mainCamera.transform.position - var_216_4.position).y, (manager.ui.mainCamera.transform.position - var_216_4.position).z)
				var_216_4.localEulerAngles.z = 0
				var_216_4.localEulerAngles.x = 0
				var_216_4.localEulerAngles = var_216_4.localEulerAngles
			end

			local var_216_6 = arg_213_1.actors_["1059ui_story"].transform

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 then
				arg_213_1.var_.moveOldPos1059ui_story = var_216_6.localPosition
			end

			local var_216_7 = 0.001

			if 0 <= arg_213_1.time_ and arg_213_1.time_ < 0 + var_216_7 then
				var_216_6.localPosition = Vector3.Lerp(arg_213_1.var_.moveOldPos1059ui_story, Vector3.New(-0.7, -1.05, -6), (arg_213_1.time_ - 0) / var_216_7)
				var_216_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_216_6.position).x, (manager.ui.mainCamera.transform.position - var_216_6.position).y, (manager.ui.mainCamera.transform.position - var_216_6.position).z)
				var_216_6.localEulerAngles.z = 0
				var_216_6.localEulerAngles.x = 0
				var_216_6.localEulerAngles = var_216_6.localEulerAngles
			end

			if arg_213_1.time_ >= 0 + var_216_7 and arg_213_1.time_ < 0 + var_216_7 + arg_216_0 then
				var_216_6.localPosition = Vector3.New(-0.7, -1.05, -6)
				var_216_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_216_6.position).x, (manager.ui.mainCamera.transform.position - var_216_6.position).y, (manager.ui.mainCamera.transform.position - var_216_6.position).z)
				var_216_6.localEulerAngles.z = 0
				var_216_6.localEulerAngles.x = 0
				var_216_6.localEulerAngles = var_216_6.localEulerAngles
			end

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 then
				arg_213_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/story1059/story1059action/1059action1_1")
			end

			local var_216_8 = 0
			local var_216_9 = 0.3

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= var_216_8 + arg_216_0 then
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

				local var_216_10 = arg_213_1:GetWordFromCfg(116141051)
				local var_216_11 = arg_213_1:FormatText(var_216_10.content)

				arg_213_1.text_.text = var_216_11

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_13 = 12 <= 0 and var_216_9 or var_216_9 * (utf8.len(var_216_11) / 12)

				if (12 <= 0 and var_216_9 or var_216_9 * (utf8.len(var_216_11) / 12)) > 0 and var_216_9 < var_216_13 then
					arg_213_1.talkMaxDuration = var_216_13

					if var_216_13 + var_216_8 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_13 + var_216_8
					end
				end

				arg_213_1.text_.text = var_216_11
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116141", "116141051", "story_v_out_116141.awb") ~= 0 then
					local var_216_14 = manager.audio:GetVoiceLength("story_v_out_116141", "116141051", "story_v_out_116141.awb") / 1000

					if var_216_14 + var_216_8 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_14 + var_216_8
					end

					if var_216_10.prefab_name ~= "" and arg_213_1.actors_[var_216_10.prefab_name] ~= nil then
						local var_216_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_213_1.actors_[var_216_10.prefab_name].transform, "story_v_out_116141", "116141051", "story_v_out_116141.awb")

						arg_213_1:RecordAudio("116141051", var_216_15)
						arg_213_1:RecordAudio("116141051", var_216_15)
					else
						arg_213_1:AudioAction("play", "voice", "story_v_out_116141", "116141051", "story_v_out_116141.awb")
					end

					arg_213_1:RecordHistoryTalkVoice("story_v_out_116141", "116141051", "story_v_out_116141.awb")
				end

				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_16 = math.max(var_216_9, arg_213_1.talkMaxDuration)

			if var_216_8 <= arg_213_1.time_ and arg_213_1.time_ < var_216_8 + var_216_16 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - var_216_8) / var_216_16

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= var_216_8 + var_216_16 and arg_213_1.time_ < var_216_8 + var_216_16 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {
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
				actorName = "1059ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_213_1:InitPlayNodeList()
	end,
	Play116141052 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 116141052
		arg_217_1.duration_ = 6.33

		local var_217_0 = {
			zh = 6,
			ja = 6.333
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
				arg_217_0:Play116141053(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 and not isNil(arg_217_1.actors_["1028ui_story"]) and arg_217_1.var_.characterEffect1028ui_story == nil then
				arg_217_1.var_.characterEffect1028ui_story = arg_217_1.actors_["1028ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_220_0 = 0.2

			if 0 <= arg_217_1.time_ and arg_217_1.time_ < 0 + var_220_0 and not isNil(arg_217_1.actors_["1028ui_story"]) then
				if arg_217_1.var_.characterEffect1028ui_story and not isNil(arg_217_1.actors_["1028ui_story"]) then
					arg_217_1.var_.characterEffect1028ui_story.fillFlat = true
					arg_217_1.var_.characterEffect1028ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_217_1.time_ - 0) / var_220_0)
				end
			end

			if arg_217_1.time_ >= 0 + var_220_0 and arg_217_1.time_ < 0 + var_220_0 + arg_220_0 and not isNil(arg_217_1.actors_["1028ui_story"]) and arg_217_1.var_.characterEffect1028ui_story then
				arg_217_1.var_.characterEffect1028ui_story.fillFlat = true
				arg_217_1.var_.characterEffect1028ui_story.fillRatio = 0.5
			end

			local var_220_1 = arg_217_1.actors_["1059ui_story"]

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 and not isNil(var_220_1) and arg_217_1.var_.characterEffect1059ui_story == nil then
				arg_217_1.var_.characterEffect1059ui_story = var_220_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_220_2 = 0.2

			if 0 <= arg_217_1.time_ and arg_217_1.time_ < 0 + var_220_2 and not isNil(var_220_1) then
				if arg_217_1.var_.characterEffect1059ui_story and not isNil(var_220_1) then
					arg_217_1.var_.characterEffect1059ui_story.fillFlat = false
				end
			end

			if arg_217_1.time_ >= 0 + var_220_2 and arg_217_1.time_ < 0 + var_220_2 + arg_220_0 and not isNil(var_220_1) and arg_217_1.var_.characterEffect1059ui_story then
				arg_217_1.var_.characterEffect1059ui_story.fillFlat = false
			end

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 then
				arg_217_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/story1059/story1059action/1059action4_1")
			end

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 then
				arg_217_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_220_4 = 0
			local var_220_5 = 0.65

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= var_220_4 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0
				arg_217_1.dialogCg_.alpha = 1

				arg_217_1.dialog_:SetActive(true)
				SetActive(arg_217_1.leftNameGo_, true)

				arg_217_1.leftNameTxt_.text = arg_217_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_217_1.leftNameTxt_.transform)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1.leftNameTxt_.text)
				SetActive(arg_217_1.iconTrs_.gameObject, false)
				arg_217_1.callingController_:SetSelectedState("normal")

				local var_220_6 = arg_217_1:GetWordFromCfg(116141052)
				local var_220_7 = arg_217_1:FormatText(var_220_6.content)

				arg_217_1.text_.text = var_220_7

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_9 = 26 <= 0 and var_220_5 or var_220_5 * (utf8.len(var_220_7) / 26)

				if (26 <= 0 and var_220_5 or var_220_5 * (utf8.len(var_220_7) / 26)) > 0 and var_220_5 < var_220_9 then
					arg_217_1.talkMaxDuration = var_220_9

					if var_220_9 + var_220_4 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_9 + var_220_4
					end
				end

				arg_217_1.text_.text = var_220_7
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116141", "116141052", "story_v_out_116141.awb") ~= 0 then
					local var_220_10 = manager.audio:GetVoiceLength("story_v_out_116141", "116141052", "story_v_out_116141.awb") / 1000

					if var_220_10 + var_220_4 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_10 + var_220_4
					end

					if var_220_6.prefab_name ~= "" and arg_217_1.actors_[var_220_6.prefab_name] ~= nil then
						local var_220_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_217_1.actors_[var_220_6.prefab_name].transform, "story_v_out_116141", "116141052", "story_v_out_116141.awb")

						arg_217_1:RecordAudio("116141052", var_220_11)
						arg_217_1:RecordAudio("116141052", var_220_11)
					else
						arg_217_1:AudioAction("play", "voice", "story_v_out_116141", "116141052", "story_v_out_116141.awb")
					end

					arg_217_1:RecordHistoryTalkVoice("story_v_out_116141", "116141052", "story_v_out_116141.awb")
				end

				arg_217_1:RecordContent(arg_217_1.text_.text)
			end

			local var_220_12 = math.max(var_220_5, arg_217_1.talkMaxDuration)

			if var_220_4 <= arg_217_1.time_ and arg_217_1.time_ < var_220_4 + var_220_12 then
				arg_217_1.typewritter.percent = (arg_217_1.time_ - var_220_4) / var_220_12

				arg_217_1.typewritter:SetDirty()
			end

			if arg_217_1.time_ >= var_220_4 + var_220_12 and arg_217_1.time_ < var_220_4 + var_220_12 + arg_220_0 then
				arg_217_1.typewritter.percent = 1

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(true)
			end
		end

		arg_217_1.nodeConfigList_ = {}

		arg_217_1:InitPlayNodeList()
	end,
	Play116141053 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 116141053
		arg_221_1.duration_ = 10.9

		local var_221_0 = {
			zh = 9.666,
			ja = 10.9
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
				arg_221_0:Play116141054(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 then
				arg_221_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3204cva")
			end

			local var_224_0 = 0
			local var_224_1 = 1.275

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= var_224_0 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, true)

				arg_221_1.leftNameTxt_.text = arg_221_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_221_1.leftNameTxt_.transform)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1.leftNameTxt_.text)
				SetActive(arg_221_1.iconTrs_.gameObject, false)
				arg_221_1.callingController_:SetSelectedState("normal")

				local var_224_2 = arg_221_1:GetWordFromCfg(116141053)
				local var_224_3 = arg_221_1:FormatText(var_224_2.content)

				arg_221_1.text_.text = var_224_3

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_5 = 51 <= 0 and var_224_1 or var_224_1 * (utf8.len(var_224_3) / 51)

				if (51 <= 0 and var_224_1 or var_224_1 * (utf8.len(var_224_3) / 51)) > 0 and var_224_1 < var_224_5 then
					arg_221_1.talkMaxDuration = var_224_5

					if var_224_5 + var_224_0 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_5 + var_224_0
					end
				end

				arg_221_1.text_.text = var_224_3
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116141", "116141053", "story_v_out_116141.awb") ~= 0 then
					local var_224_6 = manager.audio:GetVoiceLength("story_v_out_116141", "116141053", "story_v_out_116141.awb") / 1000

					if var_224_6 + var_224_0 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_6 + var_224_0
					end

					if var_224_2.prefab_name ~= "" and arg_221_1.actors_[var_224_2.prefab_name] ~= nil then
						local var_224_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_221_1.actors_[var_224_2.prefab_name].transform, "story_v_out_116141", "116141053", "story_v_out_116141.awb")

						arg_221_1:RecordAudio("116141053", var_224_7)
						arg_221_1:RecordAudio("116141053", var_224_7)
					else
						arg_221_1:AudioAction("play", "voice", "story_v_out_116141", "116141053", "story_v_out_116141.awb")
					end

					arg_221_1:RecordHistoryTalkVoice("story_v_out_116141", "116141053", "story_v_out_116141.awb")
				end

				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_8 = math.max(var_224_1, arg_221_1.talkMaxDuration)

			if var_224_0 <= arg_221_1.time_ and arg_221_1.time_ < var_224_0 + var_224_8 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - var_224_0) / var_224_8

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= var_224_0 + var_224_8 and arg_221_1.time_ < var_224_0 + var_224_8 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end

		arg_221_1.nodeConfigList_ = {}

		arg_221_1:InitPlayNodeList()
	end,
	Play116141054 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 116141054
		arg_225_1.duration_ = 4.5

		local var_225_0 = {
			zh = 4.333,
			ja = 4.5
		}
		local var_225_1 = manager.audio:GetLocalizationFlag()

		if var_225_0[var_225_1] ~= nil then
			arg_225_1.duration_ = var_225_0[var_225_1]
		end

		SetActive(arg_225_1.tipsGo_, false)

		function arg_225_1.onSingleLineFinish_()
			arg_225_1.onSingleLineUpdate_ = nil
			arg_225_1.onSingleLineFinish_ = nil
			arg_225_1.state_ = "waiting"
		end

		function arg_225_1.playNext_(arg_227_0)
			if arg_227_0 == 1 then
				arg_225_0:Play116141055(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 and not isNil(arg_225_1.actors_["1028ui_story"]) and arg_225_1.var_.characterEffect1028ui_story == nil then
				arg_225_1.var_.characterEffect1028ui_story = arg_225_1.actors_["1028ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_228_0 = 0.2

			if 0 <= arg_225_1.time_ and arg_225_1.time_ < 0 + var_228_0 and not isNil(arg_225_1.actors_["1028ui_story"]) then
				if arg_225_1.var_.characterEffect1028ui_story and not isNil(arg_225_1.actors_["1028ui_story"]) then
					arg_225_1.var_.characterEffect1028ui_story.fillFlat = false
				end
			end

			if arg_225_1.time_ >= 0 + var_228_0 and arg_225_1.time_ < 0 + var_228_0 + arg_228_0 and not isNil(arg_225_1.actors_["1028ui_story"]) and arg_225_1.var_.characterEffect1028ui_story then
				arg_225_1.var_.characterEffect1028ui_story.fillFlat = false
			end

			local var_228_2 = arg_225_1.actors_["1059ui_story"]

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 and not isNil(var_228_2) and arg_225_1.var_.characterEffect1059ui_story == nil then
				arg_225_1.var_.characterEffect1059ui_story = var_228_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_228_3 = 0.2

			if 0 <= arg_225_1.time_ and arg_225_1.time_ < 0 + var_228_3 and not isNil(var_228_2) then
				if arg_225_1.var_.characterEffect1059ui_story and not isNil(var_228_2) then
					arg_225_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_225_1.var_.characterEffect1059ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_225_1.time_ - 0) / var_228_3)
				end
			end

			if arg_225_1.time_ >= 0 + var_228_3 and arg_225_1.time_ < 0 + var_228_3 + arg_228_0 and not isNil(var_228_2) and arg_225_1.var_.characterEffect1059ui_story then
				arg_225_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_225_1.var_.characterEffect1059ui_story.fillRatio = 0.5
			end

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 then
				arg_225_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_228_4 = 0
			local var_228_5 = 0.4

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= var_228_4 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, true)

				arg_225_1.leftNameTxt_.text = arg_225_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_225_1.leftNameTxt_.transform)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1.leftNameTxt_.text)
				SetActive(arg_225_1.iconTrs_.gameObject, false)
				arg_225_1.callingController_:SetSelectedState("normal")

				local var_228_6 = arg_225_1:GetWordFromCfg(116141054)
				local var_228_7 = arg_225_1:FormatText(var_228_6.content)

				arg_225_1.text_.text = var_228_7

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_9 = 16 <= 0 and var_228_5 or var_228_5 * (utf8.len(var_228_7) / 16)

				if (16 <= 0 and var_228_5 or var_228_5 * (utf8.len(var_228_7) / 16)) > 0 and var_228_5 < var_228_9 then
					arg_225_1.talkMaxDuration = var_228_9

					if var_228_9 + var_228_4 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_9 + var_228_4
					end
				end

				arg_225_1.text_.text = var_228_7
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116141", "116141054", "story_v_out_116141.awb") ~= 0 then
					local var_228_10 = manager.audio:GetVoiceLength("story_v_out_116141", "116141054", "story_v_out_116141.awb") / 1000

					if var_228_10 + var_228_4 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_10 + var_228_4
					end

					if var_228_6.prefab_name ~= "" and arg_225_1.actors_[var_228_6.prefab_name] ~= nil then
						local var_228_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_225_1.actors_[var_228_6.prefab_name].transform, "story_v_out_116141", "116141054", "story_v_out_116141.awb")

						arg_225_1:RecordAudio("116141054", var_228_11)
						arg_225_1:RecordAudio("116141054", var_228_11)
					else
						arg_225_1:AudioAction("play", "voice", "story_v_out_116141", "116141054", "story_v_out_116141.awb")
					end

					arg_225_1:RecordHistoryTalkVoice("story_v_out_116141", "116141054", "story_v_out_116141.awb")
				end

				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_12 = math.max(var_228_5, arg_225_1.talkMaxDuration)

			if var_228_4 <= arg_225_1.time_ and arg_225_1.time_ < var_228_4 + var_228_12 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - var_228_4) / var_228_12

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= var_228_4 + var_228_12 and arg_225_1.time_ < var_228_4 + var_228_12 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {}

		arg_225_1:InitPlayNodeList()
	end,
	Play116141055 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 116141055
		arg_229_1.duration_ = 6

		local var_229_0 = {
			zh = 4.1,
			ja = 6
		}
		local var_229_1 = manager.audio:GetLocalizationFlag()

		if var_229_0[var_229_1] ~= nil then
			arg_229_1.duration_ = var_229_0[var_229_1]
		end

		SetActive(arg_229_1.tipsGo_, false)

		function arg_229_1.onSingleLineFinish_()
			arg_229_1.onSingleLineUpdate_ = nil
			arg_229_1.onSingleLineFinish_ = nil
			arg_229_1.state_ = "waiting"
		end

		function arg_229_1.playNext_(arg_231_0)
			if arg_231_0 == 1 then
				arg_229_0:Play116141056(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 and not isNil(arg_229_1.actors_["1028ui_story"]) and arg_229_1.var_.characterEffect1028ui_story == nil then
				arg_229_1.var_.characterEffect1028ui_story = arg_229_1.actors_["1028ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_232_0 = 0.2

			if 0 <= arg_229_1.time_ and arg_229_1.time_ < 0 + var_232_0 and not isNil(arg_229_1.actors_["1028ui_story"]) then
				if arg_229_1.var_.characterEffect1028ui_story and not isNil(arg_229_1.actors_["1028ui_story"]) then
					arg_229_1.var_.characterEffect1028ui_story.fillFlat = true
					arg_229_1.var_.characterEffect1028ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_229_1.time_ - 0) / var_232_0)
				end
			end

			if arg_229_1.time_ >= 0 + var_232_0 and arg_229_1.time_ < 0 + var_232_0 + arg_232_0 and not isNil(arg_229_1.actors_["1028ui_story"]) and arg_229_1.var_.characterEffect1028ui_story then
				arg_229_1.var_.characterEffect1028ui_story.fillFlat = true
				arg_229_1.var_.characterEffect1028ui_story.fillRatio = 0.5
			end

			local var_232_1 = arg_229_1.actors_["1059ui_story"]

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 and not isNil(var_232_1) and arg_229_1.var_.characterEffect1059ui_story == nil then
				arg_229_1.var_.characterEffect1059ui_story = var_232_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_232_2 = 0.2

			if 0 <= arg_229_1.time_ and arg_229_1.time_ < 0 + var_232_2 and not isNil(var_232_1) then
				if arg_229_1.var_.characterEffect1059ui_story and not isNil(var_232_1) then
					arg_229_1.var_.characterEffect1059ui_story.fillFlat = false
				end
			end

			if arg_229_1.time_ >= 0 + var_232_2 and arg_229_1.time_ < 0 + var_232_2 + arg_232_0 and not isNil(var_232_1) and arg_229_1.var_.characterEffect1059ui_story then
				arg_229_1.var_.characterEffect1059ui_story.fillFlat = false
			end

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 then
				arg_229_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/story1059/story1059actionlink/1059action442")
			end

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 then
				arg_229_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_232_4 = 0
			local var_232_5 = 0.4

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= var_232_4 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, true)

				arg_229_1.leftNameTxt_.text = arg_229_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_229_1.leftNameTxt_.transform)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1.leftNameTxt_.text)
				SetActive(arg_229_1.iconTrs_.gameObject, false)
				arg_229_1.callingController_:SetSelectedState("normal")

				local var_232_6 = arg_229_1:GetWordFromCfg(116141055)
				local var_232_7 = arg_229_1:FormatText(var_232_6.content)

				arg_229_1.text_.text = var_232_7

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_9 = 16 <= 0 and var_232_5 or var_232_5 * (utf8.len(var_232_7) / 16)

				if (16 <= 0 and var_232_5 or var_232_5 * (utf8.len(var_232_7) / 16)) > 0 and var_232_5 < var_232_9 then
					arg_229_1.talkMaxDuration = var_232_9

					if var_232_9 + var_232_4 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_9 + var_232_4
					end
				end

				arg_229_1.text_.text = var_232_7
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116141", "116141055", "story_v_out_116141.awb") ~= 0 then
					local var_232_10 = manager.audio:GetVoiceLength("story_v_out_116141", "116141055", "story_v_out_116141.awb") / 1000

					if var_232_10 + var_232_4 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_10 + var_232_4
					end

					if var_232_6.prefab_name ~= "" and arg_229_1.actors_[var_232_6.prefab_name] ~= nil then
						local var_232_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_229_1.actors_[var_232_6.prefab_name].transform, "story_v_out_116141", "116141055", "story_v_out_116141.awb")

						arg_229_1:RecordAudio("116141055", var_232_11)
						arg_229_1:RecordAudio("116141055", var_232_11)
					else
						arg_229_1:AudioAction("play", "voice", "story_v_out_116141", "116141055", "story_v_out_116141.awb")
					end

					arg_229_1:RecordHistoryTalkVoice("story_v_out_116141", "116141055", "story_v_out_116141.awb")
				end

				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_12 = math.max(var_232_5, arg_229_1.talkMaxDuration)

			if var_232_4 <= arg_229_1.time_ and arg_229_1.time_ < var_232_4 + var_232_12 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - var_232_4) / var_232_12

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= var_232_4 + var_232_12 and arg_229_1.time_ < var_232_4 + var_232_12 + arg_232_0 then
				arg_229_1.typewritter.percent = 1

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(true)
			end
		end

		arg_229_1.nodeConfigList_ = {}

		arg_229_1:InitPlayNodeList()
	end,
	Play116141056 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 116141056
		arg_233_1.duration_ = 6.9

		local var_233_0 = {
			zh = 6.5,
			ja = 6.9
		}
		local var_233_1 = manager.audio:GetLocalizationFlag()

		if var_233_0[var_233_1] ~= nil then
			arg_233_1.duration_ = var_233_0[var_233_1]
		end

		SetActive(arg_233_1.tipsGo_, false)

		function arg_233_1.onSingleLineFinish_()
			arg_233_1.onSingleLineUpdate_ = nil
			arg_233_1.onSingleLineFinish_ = nil
			arg_233_1.state_ = "waiting"
		end

		function arg_233_1.playNext_(arg_235_0)
			if arg_235_0 == 1 then
				arg_233_0:Play116141057(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 and not isNil(arg_233_1.actors_["1028ui_story"]) and arg_233_1.var_.characterEffect1028ui_story == nil then
				arg_233_1.var_.characterEffect1028ui_story = arg_233_1.actors_["1028ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_236_0 = 0.2

			if 0 <= arg_233_1.time_ and arg_233_1.time_ < 0 + var_236_0 and not isNil(arg_233_1.actors_["1028ui_story"]) then
				if arg_233_1.var_.characterEffect1028ui_story and not isNil(arg_233_1.actors_["1028ui_story"]) then
					arg_233_1.var_.characterEffect1028ui_story.fillFlat = false
				end
			end

			if arg_233_1.time_ >= 0 + var_236_0 and arg_233_1.time_ < 0 + var_236_0 + arg_236_0 and not isNil(arg_233_1.actors_["1028ui_story"]) and arg_233_1.var_.characterEffect1028ui_story then
				arg_233_1.var_.characterEffect1028ui_story.fillFlat = false
			end

			local var_236_2 = arg_233_1.actors_["1059ui_story"]

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 and not isNil(var_236_2) and arg_233_1.var_.characterEffect1059ui_story == nil then
				arg_233_1.var_.characterEffect1059ui_story = var_236_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_236_3 = 0.2

			if 0 <= arg_233_1.time_ and arg_233_1.time_ < 0 + var_236_3 and not isNil(var_236_2) then
				if arg_233_1.var_.characterEffect1059ui_story and not isNil(var_236_2) then
					arg_233_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_233_1.var_.characterEffect1059ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_233_1.time_ - 0) / var_236_3)
				end
			end

			if arg_233_1.time_ >= 0 + var_236_3 and arg_233_1.time_ < 0 + var_236_3 + arg_236_0 and not isNil(var_236_2) and arg_233_1.var_.characterEffect1059ui_story then
				arg_233_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_233_1.var_.characterEffect1059ui_story.fillRatio = 0.5
			end

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 then
				arg_233_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_236_4 = 0
			local var_236_5 = 0.5

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= var_236_4 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0
				arg_233_1.dialogCg_.alpha = 1

				arg_233_1.dialog_:SetActive(true)
				SetActive(arg_233_1.leftNameGo_, true)

				arg_233_1.leftNameTxt_.text = arg_233_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_233_1.leftNameTxt_.transform)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1.leftNameTxt_.text)
				SetActive(arg_233_1.iconTrs_.gameObject, false)
				arg_233_1.callingController_:SetSelectedState("normal")

				local var_236_6 = arg_233_1:GetWordFromCfg(116141056)
				local var_236_7 = arg_233_1:FormatText(var_236_6.content)

				arg_233_1.text_.text = var_236_7

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_9 = 20 <= 0 and var_236_5 or var_236_5 * (utf8.len(var_236_7) / 20)

				if (20 <= 0 and var_236_5 or var_236_5 * (utf8.len(var_236_7) / 20)) > 0 and var_236_5 < var_236_9 then
					arg_233_1.talkMaxDuration = var_236_9

					if var_236_9 + var_236_4 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_9 + var_236_4
					end
				end

				arg_233_1.text_.text = var_236_7
				arg_233_1.typewritter.percent = 0

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116141", "116141056", "story_v_out_116141.awb") ~= 0 then
					local var_236_10 = manager.audio:GetVoiceLength("story_v_out_116141", "116141056", "story_v_out_116141.awb") / 1000

					if var_236_10 + var_236_4 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_10 + var_236_4
					end

					if var_236_6.prefab_name ~= "" and arg_233_1.actors_[var_236_6.prefab_name] ~= nil then
						local var_236_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_233_1.actors_[var_236_6.prefab_name].transform, "story_v_out_116141", "116141056", "story_v_out_116141.awb")

						arg_233_1:RecordAudio("116141056", var_236_11)
						arg_233_1:RecordAudio("116141056", var_236_11)
					else
						arg_233_1:AudioAction("play", "voice", "story_v_out_116141", "116141056", "story_v_out_116141.awb")
					end

					arg_233_1:RecordHistoryTalkVoice("story_v_out_116141", "116141056", "story_v_out_116141.awb")
				end

				arg_233_1:RecordContent(arg_233_1.text_.text)
			end

			local var_236_12 = math.max(var_236_5, arg_233_1.talkMaxDuration)

			if var_236_4 <= arg_233_1.time_ and arg_233_1.time_ < var_236_4 + var_236_12 then
				arg_233_1.typewritter.percent = (arg_233_1.time_ - var_236_4) / var_236_12

				arg_233_1.typewritter:SetDirty()
			end

			if arg_233_1.time_ >= var_236_4 + var_236_12 and arg_233_1.time_ < var_236_4 + var_236_12 + arg_236_0 then
				arg_233_1.typewritter.percent = 1

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(true)
			end
		end

		arg_233_1.nodeConfigList_ = {}

		arg_233_1:InitPlayNodeList()
	end,
	Play116141057 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 116141057
		arg_237_1.duration_ = 5.5

		local var_237_0 = {
			zh = 5.5,
			ja = 2.933
		}
		local var_237_1 = manager.audio:GetLocalizationFlag()

		if var_237_0[var_237_1] ~= nil then
			arg_237_1.duration_ = var_237_0[var_237_1]
		end

		SetActive(arg_237_1.tipsGo_, false)

		function arg_237_1.onSingleLineFinish_()
			arg_237_1.onSingleLineUpdate_ = nil
			arg_237_1.onSingleLineFinish_ = nil
			arg_237_1.state_ = "waiting"
		end

		function arg_237_1.playNext_(arg_239_0)
			if arg_239_0 == 1 then
				arg_237_0:Play116141058(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 and not isNil(arg_237_1.actors_["1028ui_story"]) and arg_237_1.var_.characterEffect1028ui_story == nil then
				arg_237_1.var_.characterEffect1028ui_story = arg_237_1.actors_["1028ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_240_0 = 0.2

			if 0 <= arg_237_1.time_ and arg_237_1.time_ < 0 + var_240_0 and not isNil(arg_237_1.actors_["1028ui_story"]) then
				if arg_237_1.var_.characterEffect1028ui_story and not isNil(arg_237_1.actors_["1028ui_story"]) then
					arg_237_1.var_.characterEffect1028ui_story.fillFlat = true
					arg_237_1.var_.characterEffect1028ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_237_1.time_ - 0) / var_240_0)
				end
			end

			if arg_237_1.time_ >= 0 + var_240_0 and arg_237_1.time_ < 0 + var_240_0 + arg_240_0 and not isNil(arg_237_1.actors_["1028ui_story"]) and arg_237_1.var_.characterEffect1028ui_story then
				arg_237_1.var_.characterEffect1028ui_story.fillFlat = true
				arg_237_1.var_.characterEffect1028ui_story.fillRatio = 0.5
			end

			local var_240_1 = arg_237_1.actors_["1059ui_story"]

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 and not isNil(var_240_1) and arg_237_1.var_.characterEffect1059ui_story == nil then
				arg_237_1.var_.characterEffect1059ui_story = var_240_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_240_2 = 0.2

			if 0 <= arg_237_1.time_ and arg_237_1.time_ < 0 + var_240_2 and not isNil(var_240_1) then
				if arg_237_1.var_.characterEffect1059ui_story and not isNil(var_240_1) then
					arg_237_1.var_.characterEffect1059ui_story.fillFlat = false
				end
			end

			if arg_237_1.time_ >= 0 + var_240_2 and arg_237_1.time_ < 0 + var_240_2 + arg_240_0 and not isNil(var_240_1) and arg_237_1.var_.characterEffect1059ui_story then
				arg_237_1.var_.characterEffect1059ui_story.fillFlat = false
			end

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 then
				arg_237_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/story1059/story1059action/1059action2_2")
			end

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 then
				arg_237_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_240_4 = 0
			local var_240_5 = 0.625

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= var_240_4 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0
				arg_237_1.dialogCg_.alpha = 1

				arg_237_1.dialog_:SetActive(true)
				SetActive(arg_237_1.leftNameGo_, true)

				arg_237_1.leftNameTxt_.text = arg_237_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_237_1.leftNameTxt_.transform)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1.leftNameTxt_.text)
				SetActive(arg_237_1.iconTrs_.gameObject, false)
				arg_237_1.callingController_:SetSelectedState("normal")

				local var_240_6 = arg_237_1:GetWordFromCfg(116141057)
				local var_240_7 = arg_237_1:FormatText(var_240_6.content)

				arg_237_1.text_.text = var_240_7

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_9 = 23 <= 0 and var_240_5 or var_240_5 * (utf8.len(var_240_7) / 23)

				if (23 <= 0 and var_240_5 or var_240_5 * (utf8.len(var_240_7) / 23)) > 0 and var_240_5 < var_240_9 then
					arg_237_1.talkMaxDuration = var_240_9

					if var_240_9 + var_240_4 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_9 + var_240_4
					end
				end

				arg_237_1.text_.text = var_240_7
				arg_237_1.typewritter.percent = 0

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116141", "116141057", "story_v_out_116141.awb") ~= 0 then
					local var_240_10 = manager.audio:GetVoiceLength("story_v_out_116141", "116141057", "story_v_out_116141.awb") / 1000

					if var_240_10 + var_240_4 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_10 + var_240_4
					end

					if var_240_6.prefab_name ~= "" and arg_237_1.actors_[var_240_6.prefab_name] ~= nil then
						local var_240_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_237_1.actors_[var_240_6.prefab_name].transform, "story_v_out_116141", "116141057", "story_v_out_116141.awb")

						arg_237_1:RecordAudio("116141057", var_240_11)
						arg_237_1:RecordAudio("116141057", var_240_11)
					else
						arg_237_1:AudioAction("play", "voice", "story_v_out_116141", "116141057", "story_v_out_116141.awb")
					end

					arg_237_1:RecordHistoryTalkVoice("story_v_out_116141", "116141057", "story_v_out_116141.awb")
				end

				arg_237_1:RecordContent(arg_237_1.text_.text)
			end

			local var_240_12 = math.max(var_240_5, arg_237_1.talkMaxDuration)

			if var_240_4 <= arg_237_1.time_ and arg_237_1.time_ < var_240_4 + var_240_12 then
				arg_237_1.typewritter.percent = (arg_237_1.time_ - var_240_4) / var_240_12

				arg_237_1.typewritter:SetDirty()
			end

			if arg_237_1.time_ >= var_240_4 + var_240_12 and arg_237_1.time_ < var_240_4 + var_240_12 + arg_240_0 then
				arg_237_1.typewritter.percent = 1

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(true)
			end
		end

		arg_237_1.nodeConfigList_ = {}

		arg_237_1:InitPlayNodeList()
	end,
	Play116141058 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 116141058
		arg_241_1.duration_ = 7

		local var_241_0 = {
			zh = 7,
			ja = 5.233
		}
		local var_241_1 = manager.audio:GetLocalizationFlag()

		if var_241_0[var_241_1] ~= nil then
			arg_241_1.duration_ = var_241_0[var_241_1]
		end

		SetActive(arg_241_1.tipsGo_, false)

		function arg_241_1.onSingleLineFinish_()
			arg_241_1.onSingleLineUpdate_ = nil
			arg_241_1.onSingleLineFinish_ = nil
			arg_241_1.state_ = "waiting"
		end

		function arg_241_1.playNext_(arg_243_0)
			if arg_243_0 == 1 then
				arg_241_0:Play116141059(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 then
				arg_241_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3204cva")
			end

			local var_244_0 = 0
			local var_244_1 = 1.025

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= var_244_0 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0
				arg_241_1.dialogCg_.alpha = 1

				arg_241_1.dialog_:SetActive(true)
				SetActive(arg_241_1.leftNameGo_, true)

				arg_241_1.leftNameTxt_.text = arg_241_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_241_1.leftNameTxt_.transform)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1.leftNameTxt_.text)
				SetActive(arg_241_1.iconTrs_.gameObject, false)
				arg_241_1.callingController_:SetSelectedState("normal")

				local var_244_2 = arg_241_1:GetWordFromCfg(116141058)
				local var_244_3 = arg_241_1:FormatText(var_244_2.content)

				arg_241_1.text_.text = var_244_3

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_5 = 40 <= 0 and var_244_1 or var_244_1 * (utf8.len(var_244_3) / 40)

				if (40 <= 0 and var_244_1 or var_244_1 * (utf8.len(var_244_3) / 40)) > 0 and var_244_1 < var_244_5 then
					arg_241_1.talkMaxDuration = var_244_5

					if var_244_5 + var_244_0 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_5 + var_244_0
					end
				end

				arg_241_1.text_.text = var_244_3
				arg_241_1.typewritter.percent = 0

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116141", "116141058", "story_v_out_116141.awb") ~= 0 then
					local var_244_6 = manager.audio:GetVoiceLength("story_v_out_116141", "116141058", "story_v_out_116141.awb") / 1000

					if var_244_6 + var_244_0 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_6 + var_244_0
					end

					if var_244_2.prefab_name ~= "" and arg_241_1.actors_[var_244_2.prefab_name] ~= nil then
						local var_244_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_241_1.actors_[var_244_2.prefab_name].transform, "story_v_out_116141", "116141058", "story_v_out_116141.awb")

						arg_241_1:RecordAudio("116141058", var_244_7)
						arg_241_1:RecordAudio("116141058", var_244_7)
					else
						arg_241_1:AudioAction("play", "voice", "story_v_out_116141", "116141058", "story_v_out_116141.awb")
					end

					arg_241_1:RecordHistoryTalkVoice("story_v_out_116141", "116141058", "story_v_out_116141.awb")
				end

				arg_241_1:RecordContent(arg_241_1.text_.text)
			end

			local var_244_8 = math.max(var_244_1, arg_241_1.talkMaxDuration)

			if var_244_0 <= arg_241_1.time_ and arg_241_1.time_ < var_244_0 + var_244_8 then
				arg_241_1.typewritter.percent = (arg_241_1.time_ - var_244_0) / var_244_8

				arg_241_1.typewritter:SetDirty()
			end

			if arg_241_1.time_ >= var_244_0 + var_244_8 and arg_241_1.time_ < var_244_0 + var_244_8 + arg_244_0 then
				arg_241_1.typewritter.percent = 1

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(true)
			end
		end

		arg_241_1.nodeConfigList_ = {}

		arg_241_1:InitPlayNodeList()
	end,
	Play116141059 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 116141059
		arg_245_1.duration_ = 5

		SetActive(arg_245_1.tipsGo_, false)

		function arg_245_1.onSingleLineFinish_()
			arg_245_1.onSingleLineUpdate_ = nil
			arg_245_1.onSingleLineFinish_ = nil
			arg_245_1.state_ = "waiting"
		end

		function arg_245_1.playNext_(arg_247_0)
			if arg_247_0 == 1 then
				arg_245_0:Play116141060(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 then
				arg_245_1.var_.moveOldPos1028ui_story = arg_245_1.actors_["1028ui_story"].transform.localPosition
			end

			local var_248_0 = 0.001

			if 0 <= arg_245_1.time_ and arg_245_1.time_ < 0 + var_248_0 then
				arg_245_1.actors_["1028ui_story"].transform.localPosition = Vector3.Lerp(arg_245_1.var_.moveOldPos1028ui_story, Vector3.New(0, 100, 0), (arg_245_1.time_ - 0) / var_248_0)
				arg_245_1.actors_["1028ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_245_1.actors_["1028ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_245_1.actors_["1028ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_245_1.actors_["1028ui_story"].transform.position).z)
				arg_245_1.actors_["1028ui_story"].transform.localEulerAngles.z = 0
				arg_245_1.actors_["1028ui_story"].transform.localEulerAngles.x = 0
				arg_245_1.actors_["1028ui_story"].transform.localEulerAngles = arg_245_1.actors_["1028ui_story"].transform.localEulerAngles
			end

			if arg_245_1.time_ >= 0 + var_248_0 and arg_245_1.time_ < 0 + var_248_0 + arg_248_0 then
				arg_245_1.actors_["1028ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_245_1.actors_["1028ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_245_1.actors_["1028ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_245_1.actors_["1028ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_245_1.actors_["1028ui_story"].transform.position).z)
				arg_245_1.actors_["1028ui_story"].transform.localEulerAngles.z = 0
				arg_245_1.actors_["1028ui_story"].transform.localEulerAngles.x = 0
				arg_245_1.actors_["1028ui_story"].transform.localEulerAngles = arg_245_1.actors_["1028ui_story"].transform.localEulerAngles
			end

			local var_248_1 = arg_245_1.actors_["1059ui_story"].transform

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 then
				arg_245_1.var_.moveOldPos1059ui_story = var_248_1.localPosition
			end

			local var_248_2 = 0.001

			if 0 <= arg_245_1.time_ and arg_245_1.time_ < 0 + var_248_2 then
				var_248_1.localPosition = Vector3.Lerp(arg_245_1.var_.moveOldPos1059ui_story, Vector3.New(0, 100, 0), (arg_245_1.time_ - 0) / var_248_2)
				var_248_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_248_1.position).x, (manager.ui.mainCamera.transform.position - var_248_1.position).y, (manager.ui.mainCamera.transform.position - var_248_1.position).z)
				var_248_1.localEulerAngles.z = 0
				var_248_1.localEulerAngles.x = 0
				var_248_1.localEulerAngles = var_248_1.localEulerAngles
			end

			if arg_245_1.time_ >= 0 + var_248_2 and arg_245_1.time_ < 0 + var_248_2 + arg_248_0 then
				var_248_1.localPosition = Vector3.New(0, 100, 0)
				var_248_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_248_1.position).x, (manager.ui.mainCamera.transform.position - var_248_1.position).y, (manager.ui.mainCamera.transform.position - var_248_1.position).z)
				var_248_1.localEulerAngles.z = 0
				var_248_1.localEulerAngles.x = 0
				var_248_1.localEulerAngles = var_248_1.localEulerAngles
			end

			local var_248_3 = 0
			local var_248_4 = 0.9

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= var_248_3 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0
				arg_245_1.dialogCg_.alpha = 1

				arg_245_1.dialog_:SetActive(true)
				SetActive(arg_245_1.leftNameGo_, false)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_245_1.iconTrs_.gameObject, false)
				arg_245_1.callingController_:SetSelectedState("normal")

				local var_248_5 = arg_245_1:FormatText(arg_245_1:GetWordFromCfg(116141059).content)

				arg_245_1.text_.text = var_248_5

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_7 = 36 <= 0 and var_248_4 or var_248_4 * (utf8.len(var_248_5) / 36)

				if (36 <= 0 and var_248_4 or var_248_4 * (utf8.len(var_248_5) / 36)) > 0 and var_248_4 < var_248_7 then
					arg_245_1.talkMaxDuration = var_248_7

					if var_248_7 + var_248_3 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_7 + var_248_3
					end
				end

				arg_245_1.text_.text = var_248_5
				arg_245_1.typewritter.percent = 0

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(false)
				arg_245_1:RecordContent(arg_245_1.text_.text)
			end

			local var_248_8 = math.max(var_248_4, arg_245_1.talkMaxDuration)

			if var_248_3 <= arg_245_1.time_ and arg_245_1.time_ < var_248_3 + var_248_8 then
				arg_245_1.typewritter.percent = (arg_245_1.time_ - var_248_3) / var_248_8

				arg_245_1.typewritter:SetDirty()
			end

			if arg_245_1.time_ >= var_248_3 + var_248_8 and arg_245_1.time_ < var_248_3 + var_248_8 + arg_248_0 then
				arg_245_1.typewritter.percent = 1

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(true)
			end
		end

		arg_245_1.nodeConfigList_ = {
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
				actorName = "1059ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_245_1:InitPlayNodeList()
	end,
	Play116141060 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 116141060
		arg_249_1.duration_ = 9.4

		local var_249_0 = {
			zh = 9.4,
			ja = 6.9
		}
		local var_249_1 = manager.audio:GetLocalizationFlag()

		if var_249_0[var_249_1] ~= nil then
			arg_249_1.duration_ = var_249_0[var_249_1]
		end

		SetActive(arg_249_1.tipsGo_, false)

		function arg_249_1.onSingleLineFinish_()
			arg_249_1.onSingleLineUpdate_ = nil
			arg_249_1.onSingleLineFinish_ = nil
			arg_249_1.state_ = "waiting"
		end

		function arg_249_1.playNext_(arg_251_0)
			if arg_251_0 == 1 then
				arg_249_0:Play116141061(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 and not isNil(arg_249_1.actors_["1028ui_story"]) and arg_249_1.var_.characterEffect1028ui_story == nil then
				arg_249_1.var_.characterEffect1028ui_story = arg_249_1.actors_["1028ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_252_0 = 0.2

			if 0 <= arg_249_1.time_ and arg_249_1.time_ < 0 + var_252_0 and not isNil(arg_249_1.actors_["1028ui_story"]) then
				if arg_249_1.var_.characterEffect1028ui_story and not isNil(arg_249_1.actors_["1028ui_story"]) then
					arg_249_1.var_.characterEffect1028ui_story.fillFlat = false
				end
			end

			if arg_249_1.time_ >= 0 + var_252_0 and arg_249_1.time_ < 0 + var_252_0 + arg_252_0 and not isNil(arg_249_1.actors_["1028ui_story"]) and arg_249_1.var_.characterEffect1028ui_story then
				arg_249_1.var_.characterEffect1028ui_story.fillFlat = false
			end

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 then
				arg_249_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/story1028/story1028action/1028action7_1")
			end

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 then
				arg_249_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_252_2 = arg_249_1.actors_["1028ui_story"].transform

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 then
				arg_249_1.var_.moveOldPos1028ui_story = var_252_2.localPosition

				arg_249_1:ShowWeapon(arg_249_1.var_["1028ui_story" .. "Animator"].transform, false)
			end

			local var_252_3 = 0.001

			if 0 <= arg_249_1.time_ and arg_249_1.time_ < 0 + var_252_3 then
				var_252_2.localPosition = Vector3.Lerp(arg_249_1.var_.moveOldPos1028ui_story, Vector3.New(0, -0.9, -5.9), (arg_249_1.time_ - 0) / var_252_3)
				var_252_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_252_2.position).x, (manager.ui.mainCamera.transform.position - var_252_2.position).y, (manager.ui.mainCamera.transform.position - var_252_2.position).z)
				var_252_2.localEulerAngles.z = 0
				var_252_2.localEulerAngles.x = 0
				var_252_2.localEulerAngles = var_252_2.localEulerAngles
			end

			if arg_249_1.time_ >= 0 + var_252_3 and arg_249_1.time_ < 0 + var_252_3 + arg_252_0 then
				var_252_2.localPosition = Vector3.New(0, -0.9, -5.9)
				var_252_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_252_2.position).x, (manager.ui.mainCamera.transform.position - var_252_2.position).y, (manager.ui.mainCamera.transform.position - var_252_2.position).z)
				var_252_2.localEulerAngles.z = 0
				var_252_2.localEulerAngles.x = 0
				var_252_2.localEulerAngles = var_252_2.localEulerAngles
			end

			local var_252_4 = 0
			local var_252_5 = 0.475

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= var_252_4 + arg_252_0 then
				arg_249_1.talkMaxDuration = 0
				arg_249_1.dialogCg_.alpha = 1

				arg_249_1.dialog_:SetActive(true)
				SetActive(arg_249_1.leftNameGo_, true)

				arg_249_1.leftNameTxt_.text = arg_249_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_249_1.leftNameTxt_.transform)

				arg_249_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_249_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_249_1:RecordName(arg_249_1.leftNameTxt_.text)
				SetActive(arg_249_1.iconTrs_.gameObject, false)
				arg_249_1.callingController_:SetSelectedState("normal")

				local var_252_6 = arg_249_1:GetWordFromCfg(116141060)
				local var_252_7 = arg_249_1:FormatText(var_252_6.content)

				arg_249_1.text_.text = var_252_7

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_9 = 19 <= 0 and var_252_5 or var_252_5 * (utf8.len(var_252_7) / 19)

				if (19 <= 0 and var_252_5 or var_252_5 * (utf8.len(var_252_7) / 19)) > 0 and var_252_5 < var_252_9 then
					arg_249_1.talkMaxDuration = var_252_9

					if var_252_9 + var_252_4 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_9 + var_252_4
					end
				end

				arg_249_1.text_.text = var_252_7
				arg_249_1.typewritter.percent = 0

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116141", "116141060", "story_v_out_116141.awb") ~= 0 then
					local var_252_10 = manager.audio:GetVoiceLength("story_v_out_116141", "116141060", "story_v_out_116141.awb") / 1000

					if var_252_10 + var_252_4 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_10 + var_252_4
					end

					if var_252_6.prefab_name ~= "" and arg_249_1.actors_[var_252_6.prefab_name] ~= nil then
						local var_252_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_249_1.actors_[var_252_6.prefab_name].transform, "story_v_out_116141", "116141060", "story_v_out_116141.awb")

						arg_249_1:RecordAudio("116141060", var_252_11)
						arg_249_1:RecordAudio("116141060", var_252_11)
					else
						arg_249_1:AudioAction("play", "voice", "story_v_out_116141", "116141060", "story_v_out_116141.awb")
					end

					arg_249_1:RecordHistoryTalkVoice("story_v_out_116141", "116141060", "story_v_out_116141.awb")
				end

				arg_249_1:RecordContent(arg_249_1.text_.text)
			end

			local var_252_12 = math.max(var_252_5, arg_249_1.talkMaxDuration)

			if var_252_4 <= arg_249_1.time_ and arg_249_1.time_ < var_252_4 + var_252_12 then
				arg_249_1.typewritter.percent = (arg_249_1.time_ - var_252_4) / var_252_12

				arg_249_1.typewritter:SetDirty()
			end

			if arg_249_1.time_ >= var_252_4 + var_252_12 and arg_249_1.time_ < var_252_4 + var_252_12 + arg_252_0 then
				arg_249_1.typewritter.percent = 1

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(true)
			end
		end

		arg_249_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1028ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_249_1:InitPlayNodeList()
	end,
	Play116141061 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 116141061
		arg_253_1.duration_ = 5

		SetActive(arg_253_1.tipsGo_, false)

		function arg_253_1.onSingleLineFinish_()
			arg_253_1.onSingleLineUpdate_ = nil
			arg_253_1.onSingleLineFinish_ = nil
			arg_253_1.state_ = "waiting"
		end

		function arg_253_1.playNext_(arg_255_0)
			if arg_255_0 == 1 then
				arg_253_0:Play116141062(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 then
				arg_253_1:AudioAction("play", "effect", "se_story_6", "se_story_6_purple_lightning_loop", "")
			end

			local var_256_1 = arg_253_1.actors_["1028ui_story"].transform

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 then
				arg_253_1.var_.moveOldPos1028ui_story = var_256_1.localPosition
			end

			local var_256_2 = 0.001

			if 0 <= arg_253_1.time_ and arg_253_1.time_ < 0 + var_256_2 then
				var_256_1.localPosition = Vector3.Lerp(arg_253_1.var_.moveOldPos1028ui_story, Vector3.New(0, 100, 0), (arg_253_1.time_ - 0) / var_256_2)
				var_256_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_256_1.position).x, (manager.ui.mainCamera.transform.position - var_256_1.position).y, (manager.ui.mainCamera.transform.position - var_256_1.position).z)
				var_256_1.localEulerAngles.z = 0
				var_256_1.localEulerAngles.x = 0
				var_256_1.localEulerAngles = var_256_1.localEulerAngles
			end

			if arg_253_1.time_ >= 0 + var_256_2 and arg_253_1.time_ < 0 + var_256_2 + arg_256_0 then
				var_256_1.localPosition = Vector3.New(0, 100, 0)
				var_256_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_256_1.position).x, (manager.ui.mainCamera.transform.position - var_256_1.position).y, (manager.ui.mainCamera.transform.position - var_256_1.position).z)
				var_256_1.localEulerAngles.z = 0
				var_256_1.localEulerAngles.x = 0
				var_256_1.localEulerAngles = var_256_1.localEulerAngles
			end

			local var_256_3 = 0
			local var_256_4 = 1.4

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= var_256_3 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, false)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_253_1.iconTrs_.gameObject, false)
				arg_253_1.callingController_:SetSelectedState("normal")

				local var_256_5 = arg_253_1:FormatText(arg_253_1:GetWordFromCfg(116141061).content)

				arg_253_1.text_.text = var_256_5

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_7 = 56 <= 0 and var_256_4 or var_256_4 * (utf8.len(var_256_5) / 56)

				if (56 <= 0 and var_256_4 or var_256_4 * (utf8.len(var_256_5) / 56)) > 0 and var_256_4 < var_256_7 then
					arg_253_1.talkMaxDuration = var_256_7

					if var_256_7 + var_256_3 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_7 + var_256_3
					end
				end

				arg_253_1.text_.text = var_256_5
				arg_253_1.typewritter.percent = 0

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(false)
				arg_253_1:RecordContent(arg_253_1.text_.text)
			end

			local var_256_8 = math.max(var_256_4, arg_253_1.talkMaxDuration)

			if var_256_3 <= arg_253_1.time_ and arg_253_1.time_ < var_256_3 + var_256_8 then
				arg_253_1.typewritter.percent = (arg_253_1.time_ - var_256_3) / var_256_8

				arg_253_1.typewritter:SetDirty()
			end

			if arg_253_1.time_ >= var_256_3 + var_256_8 and arg_253_1.time_ < var_256_3 + var_256_8 + arg_256_0 then
				arg_253_1.typewritter.percent = 1

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(true)
			end
		end

		arg_253_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1028ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_253_1:InitPlayNodeList()
	end,
	Play116141062 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 116141062
		arg_257_1.duration_ = 8.2

		local var_257_0 = {
			zh = 6.033,
			ja = 8.2
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
				arg_257_0:Play116141063(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 and not isNil(arg_257_1.actors_["1028ui_story"]) and arg_257_1.var_.characterEffect1028ui_story == nil then
				arg_257_1.var_.characterEffect1028ui_story = arg_257_1.actors_["1028ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_260_0 = 0.2

			if 0 <= arg_257_1.time_ and arg_257_1.time_ < 0 + var_260_0 and not isNil(arg_257_1.actors_["1028ui_story"]) then
				if arg_257_1.var_.characterEffect1028ui_story and not isNil(arg_257_1.actors_["1028ui_story"]) then
					arg_257_1.var_.characterEffect1028ui_story.fillFlat = false
				end
			end

			if arg_257_1.time_ >= 0 + var_260_0 and arg_257_1.time_ < 0 + var_260_0 + arg_260_0 and not isNil(arg_257_1.actors_["1028ui_story"]) and arg_257_1.var_.characterEffect1028ui_story then
				arg_257_1.var_.characterEffect1028ui_story.fillFlat = false
			end

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 then
				arg_257_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/story1028/story1028action/1028action4_1")
			end

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 then
				arg_257_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_260_2 = arg_257_1.actors_["1028ui_story"].transform

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 then
				arg_257_1.var_.moveOldPos1028ui_story = var_260_2.localPosition
			end

			local var_260_3 = 0.001

			if 0 <= arg_257_1.time_ and arg_257_1.time_ < 0 + var_260_3 then
				var_260_2.localPosition = Vector3.Lerp(arg_257_1.var_.moveOldPos1028ui_story, Vector3.New(0, -0.9, -5.9), (arg_257_1.time_ - 0) / var_260_3)
				var_260_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_260_2.position).x, (manager.ui.mainCamera.transform.position - var_260_2.position).y, (manager.ui.mainCamera.transform.position - var_260_2.position).z)
				var_260_2.localEulerAngles.z = 0
				var_260_2.localEulerAngles.x = 0
				var_260_2.localEulerAngles = var_260_2.localEulerAngles
			end

			if arg_257_1.time_ >= 0 + var_260_3 and arg_257_1.time_ < 0 + var_260_3 + arg_260_0 then
				var_260_2.localPosition = Vector3.New(0, -0.9, -5.9)
				var_260_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_260_2.position).x, (manager.ui.mainCamera.transform.position - var_260_2.position).y, (manager.ui.mainCamera.transform.position - var_260_2.position).z)
				var_260_2.localEulerAngles.z = 0
				var_260_2.localEulerAngles.x = 0
				var_260_2.localEulerAngles = var_260_2.localEulerAngles
			end

			local var_260_4 = 0
			local var_260_5 = 0.45

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= var_260_4 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0
				arg_257_1.dialogCg_.alpha = 1

				arg_257_1.dialog_:SetActive(true)
				SetActive(arg_257_1.leftNameGo_, true)

				arg_257_1.leftNameTxt_.text = arg_257_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_257_1.leftNameTxt_.transform)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1.leftNameTxt_.text)
				SetActive(arg_257_1.iconTrs_.gameObject, false)
				arg_257_1.callingController_:SetSelectedState("normal")

				local var_260_6 = arg_257_1:GetWordFromCfg(116141062)
				local var_260_7 = arg_257_1:FormatText(var_260_6.content)

				arg_257_1.text_.text = var_260_7

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_9 = 18 <= 0 and var_260_5 or var_260_5 * (utf8.len(var_260_7) / 18)

				if (18 <= 0 and var_260_5 or var_260_5 * (utf8.len(var_260_7) / 18)) > 0 and var_260_5 < var_260_9 then
					arg_257_1.talkMaxDuration = var_260_9

					if var_260_9 + var_260_4 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_9 + var_260_4
					end
				end

				arg_257_1.text_.text = var_260_7
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116141", "116141062", "story_v_out_116141.awb") ~= 0 then
					local var_260_10 = manager.audio:GetVoiceLength("story_v_out_116141", "116141062", "story_v_out_116141.awb") / 1000

					if var_260_10 + var_260_4 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_10 + var_260_4
					end

					if var_260_6.prefab_name ~= "" and arg_257_1.actors_[var_260_6.prefab_name] ~= nil then
						local var_260_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_257_1.actors_[var_260_6.prefab_name].transform, "story_v_out_116141", "116141062", "story_v_out_116141.awb")

						arg_257_1:RecordAudio("116141062", var_260_11)
						arg_257_1:RecordAudio("116141062", var_260_11)
					else
						arg_257_1:AudioAction("play", "voice", "story_v_out_116141", "116141062", "story_v_out_116141.awb")
					end

					arg_257_1:RecordHistoryTalkVoice("story_v_out_116141", "116141062", "story_v_out_116141.awb")
				end

				arg_257_1:RecordContent(arg_257_1.text_.text)
			end

			local var_260_12 = math.max(var_260_5, arg_257_1.talkMaxDuration)

			if var_260_4 <= arg_257_1.time_ and arg_257_1.time_ < var_260_4 + var_260_12 then
				arg_257_1.typewritter.percent = (arg_257_1.time_ - var_260_4) / var_260_12

				arg_257_1.typewritter:SetDirty()
			end

			if arg_257_1.time_ >= var_260_4 + var_260_12 and arg_257_1.time_ < var_260_4 + var_260_12 + arg_260_0 then
				arg_257_1.typewritter.percent = 1

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(true)
			end
		end

		arg_257_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1028ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_257_1:InitPlayNodeList()
	end,
	Play116141063 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 116141063
		arg_261_1.duration_ = 7.47

		local var_261_0 = {
			zh = 7.466,
			ja = 3.8
		}
		local var_261_1 = manager.audio:GetLocalizationFlag()

		if var_261_0[var_261_1] ~= nil then
			arg_261_1.duration_ = var_261_0[var_261_1]
		end

		SetActive(arg_261_1.tipsGo_, false)

		function arg_261_1.onSingleLineFinish_()
			arg_261_1.onSingleLineUpdate_ = nil
			arg_261_1.onSingleLineFinish_ = nil
			arg_261_1.state_ = "waiting"
		end

		function arg_261_1.playNext_(arg_263_0)
			if arg_263_0 == 1 then
				arg_261_0:Play116141064(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 then
				arg_261_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_264_0 = 0
			local var_264_1 = 0.725

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= var_264_0 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0
				arg_261_1.dialogCg_.alpha = 1

				arg_261_1.dialog_:SetActive(true)
				SetActive(arg_261_1.leftNameGo_, true)

				arg_261_1.leftNameTxt_.text = arg_261_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_261_1.leftNameTxt_.transform)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1.leftNameTxt_.text)
				SetActive(arg_261_1.iconTrs_.gameObject, false)
				arg_261_1.callingController_:SetSelectedState("normal")

				local var_264_2 = arg_261_1:GetWordFromCfg(116141063)
				local var_264_3 = arg_261_1:FormatText(var_264_2.content)

				arg_261_1.text_.text = var_264_3

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_5 = 29 <= 0 and var_264_1 or var_264_1 * (utf8.len(var_264_3) / 29)

				if (29 <= 0 and var_264_1 or var_264_1 * (utf8.len(var_264_3) / 29)) > 0 and var_264_1 < var_264_5 then
					arg_261_1.talkMaxDuration = var_264_5

					if var_264_5 + var_264_0 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_5 + var_264_0
					end
				end

				arg_261_1.text_.text = var_264_3
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116141", "116141063", "story_v_out_116141.awb") ~= 0 then
					local var_264_6 = manager.audio:GetVoiceLength("story_v_out_116141", "116141063", "story_v_out_116141.awb") / 1000

					if var_264_6 + var_264_0 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_6 + var_264_0
					end

					if var_264_2.prefab_name ~= "" and arg_261_1.actors_[var_264_2.prefab_name] ~= nil then
						local var_264_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_261_1.actors_[var_264_2.prefab_name].transform, "story_v_out_116141", "116141063", "story_v_out_116141.awb")

						arg_261_1:RecordAudio("116141063", var_264_7)
						arg_261_1:RecordAudio("116141063", var_264_7)
					else
						arg_261_1:AudioAction("play", "voice", "story_v_out_116141", "116141063", "story_v_out_116141.awb")
					end

					arg_261_1:RecordHistoryTalkVoice("story_v_out_116141", "116141063", "story_v_out_116141.awb")
				end

				arg_261_1:RecordContent(arg_261_1.text_.text)
			end

			local var_264_8 = math.max(var_264_1, arg_261_1.talkMaxDuration)

			if var_264_0 <= arg_261_1.time_ and arg_261_1.time_ < var_264_0 + var_264_8 then
				arg_261_1.typewritter.percent = (arg_261_1.time_ - var_264_0) / var_264_8

				arg_261_1.typewritter:SetDirty()
			end

			if arg_261_1.time_ >= var_264_0 + var_264_8 and arg_261_1.time_ < var_264_0 + var_264_8 + arg_264_0 then
				arg_261_1.typewritter.percent = 1

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(true)
			end
		end

		arg_261_1.nodeConfigList_ = {}

		arg_261_1:InitPlayNodeList()
	end,
	Play116141064 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 116141064
		arg_265_1.duration_ = 5

		SetActive(arg_265_1.tipsGo_, false)

		function arg_265_1.onSingleLineFinish_()
			arg_265_1.onSingleLineUpdate_ = nil
			arg_265_1.onSingleLineFinish_ = nil
			arg_265_1.state_ = "waiting"
		end

		function arg_265_1.playNext_(arg_267_0)
			if arg_267_0 == 1 then
				arg_265_0:Play116141065(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 then
				arg_265_1.var_.moveOldPos1028ui_story = arg_265_1.actors_["1028ui_story"].transform.localPosition
			end

			local var_268_0 = 0.001

			if 0 <= arg_265_1.time_ and arg_265_1.time_ < 0 + var_268_0 then
				arg_265_1.actors_["1028ui_story"].transform.localPosition = Vector3.Lerp(arg_265_1.var_.moveOldPos1028ui_story, Vector3.New(0, 100, 0), (arg_265_1.time_ - 0) / var_268_0)
				arg_265_1.actors_["1028ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_265_1.actors_["1028ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_265_1.actors_["1028ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_265_1.actors_["1028ui_story"].transform.position).z)
				arg_265_1.actors_["1028ui_story"].transform.localEulerAngles.z = 0
				arg_265_1.actors_["1028ui_story"].transform.localEulerAngles.x = 0
				arg_265_1.actors_["1028ui_story"].transform.localEulerAngles = arg_265_1.actors_["1028ui_story"].transform.localEulerAngles
			end

			if arg_265_1.time_ >= 0 + var_268_0 and arg_265_1.time_ < 0 + var_268_0 + arg_268_0 then
				arg_265_1.actors_["1028ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_265_1.actors_["1028ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_265_1.actors_["1028ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_265_1.actors_["1028ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_265_1.actors_["1028ui_story"].transform.position).z)
				arg_265_1.actors_["1028ui_story"].transform.localEulerAngles.z = 0
				arg_265_1.actors_["1028ui_story"].transform.localEulerAngles.x = 0
				arg_265_1.actors_["1028ui_story"].transform.localEulerAngles = arg_265_1.actors_["1028ui_story"].transform.localEulerAngles
			end

			local var_268_1 = 0
			local var_268_2 = 1.15

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= var_268_1 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0
				arg_265_1.dialogCg_.alpha = 1

				arg_265_1.dialog_:SetActive(true)
				SetActive(arg_265_1.leftNameGo_, false)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_265_1.iconTrs_.gameObject, false)
				arg_265_1.callingController_:SetSelectedState("normal")

				local var_268_3 = arg_265_1:FormatText(arg_265_1:GetWordFromCfg(116141064).content)

				arg_265_1.text_.text = var_268_3

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_5 = 47 <= 0 and var_268_2 or var_268_2 * (utf8.len(var_268_3) / 47)

				if (47 <= 0 and var_268_2 or var_268_2 * (utf8.len(var_268_3) / 47)) > 0 and var_268_2 < var_268_5 then
					arg_265_1.talkMaxDuration = var_268_5

					if var_268_5 + var_268_1 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_5 + var_268_1
					end
				end

				arg_265_1.text_.text = var_268_3
				arg_265_1.typewritter.percent = 0

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(false)
				arg_265_1:RecordContent(arg_265_1.text_.text)
			end

			local var_268_6 = math.max(var_268_2, arg_265_1.talkMaxDuration)

			if var_268_1 <= arg_265_1.time_ and arg_265_1.time_ < var_268_1 + var_268_6 then
				arg_265_1.typewritter.percent = (arg_265_1.time_ - var_268_1) / var_268_6

				arg_265_1.typewritter:SetDirty()
			end

			if arg_265_1.time_ >= var_268_1 + var_268_6 and arg_265_1.time_ < var_268_1 + var_268_6 + arg_268_0 then
				arg_265_1.typewritter.percent = 1

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(true)
			end
		end

		arg_265_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1028ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_265_1:InitPlayNodeList()
	end,
	Play116141065 = function(arg_269_0, arg_269_1)
		arg_269_1.time_ = 0
		arg_269_1.frameCnt_ = 0
		arg_269_1.state_ = "playing"
		arg_269_1.curTalkId_ = 116141065
		arg_269_1.duration_ = 9.53

		local var_269_0 = {
			zh = 7.333,
			ja = 9.533
		}
		local var_269_1 = manager.audio:GetLocalizationFlag()

		if var_269_0[var_269_1] ~= nil then
			arg_269_1.duration_ = var_269_0[var_269_1]
		end

		SetActive(arg_269_1.tipsGo_, false)

		function arg_269_1.onSingleLineFinish_()
			arg_269_1.onSingleLineUpdate_ = nil
			arg_269_1.onSingleLineFinish_ = nil
			arg_269_1.state_ = "waiting"
			arg_269_1.auto_ = false
		end

		function arg_269_1.playNext_(arg_271_0)
			arg_269_1.onStoryFinished_()
		end

		function arg_269_1.onSingleLineUpdate_(arg_272_0)
			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 and not isNil(arg_269_1.actors_["1028ui_story"]) and arg_269_1.var_.characterEffect1028ui_story == nil then
				arg_269_1.var_.characterEffect1028ui_story = arg_269_1.actors_["1028ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_272_0 = 0.2

			if 0 <= arg_269_1.time_ and arg_269_1.time_ < 0 + var_272_0 and not isNil(arg_269_1.actors_["1028ui_story"]) then
				if arg_269_1.var_.characterEffect1028ui_story and not isNil(arg_269_1.actors_["1028ui_story"]) then
					arg_269_1.var_.characterEffect1028ui_story.fillFlat = true
					arg_269_1.var_.characterEffect1028ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_269_1.time_ - 0) / var_272_0)
				end
			end

			if arg_269_1.time_ >= 0 + var_272_0 and arg_269_1.time_ < 0 + var_272_0 + arg_272_0 and not isNil(arg_269_1.actors_["1028ui_story"]) and arg_269_1.var_.characterEffect1028ui_story then
				arg_269_1.var_.characterEffect1028ui_story.fillFlat = true
				arg_269_1.var_.characterEffect1028ui_story.fillRatio = 0.5
			end

			local var_272_1 = arg_269_1.actors_["1059ui_story"]

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 and not isNil(var_272_1) and arg_269_1.var_.characterEffect1059ui_story == nil then
				arg_269_1.var_.characterEffect1059ui_story = var_272_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_272_2 = 0.2

			if 0 <= arg_269_1.time_ and arg_269_1.time_ < 0 + var_272_2 and not isNil(var_272_1) then
				if arg_269_1.var_.characterEffect1059ui_story and not isNil(var_272_1) then
					arg_269_1.var_.characterEffect1059ui_story.fillFlat = false
				end
			end

			if arg_269_1.time_ >= 0 + var_272_2 and arg_269_1.time_ < 0 + var_272_2 + arg_272_0 and not isNil(var_272_1) and arg_269_1.var_.characterEffect1059ui_story then
				arg_269_1.var_.characterEffect1059ui_story.fillFlat = false
			end

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 then
				arg_269_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/story1059/story1059action/1059action1_1")
			end

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 then
				arg_269_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_272_4 = arg_269_1.actors_["1059ui_story"].transform

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 then
				arg_269_1.var_.moveOldPos1059ui_story = var_272_4.localPosition
			end

			local var_272_5 = 0.001

			if 0 <= arg_269_1.time_ and arg_269_1.time_ < 0 + var_272_5 then
				var_272_4.localPosition = Vector3.Lerp(arg_269_1.var_.moveOldPos1059ui_story, Vector3.New(0, -1.05, -6), (arg_269_1.time_ - 0) / var_272_5)
				var_272_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_272_4.position).x, (manager.ui.mainCamera.transform.position - var_272_4.position).y, (manager.ui.mainCamera.transform.position - var_272_4.position).z)
				var_272_4.localEulerAngles.z = 0
				var_272_4.localEulerAngles.x = 0
				var_272_4.localEulerAngles = var_272_4.localEulerAngles
			end

			if arg_269_1.time_ >= 0 + var_272_5 and arg_269_1.time_ < 0 + var_272_5 + arg_272_0 then
				var_272_4.localPosition = Vector3.New(0, -1.05, -6)
				var_272_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_272_4.position).x, (manager.ui.mainCamera.transform.position - var_272_4.position).y, (manager.ui.mainCamera.transform.position - var_272_4.position).z)
				var_272_4.localEulerAngles.z = 0
				var_272_4.localEulerAngles.x = 0
				var_272_4.localEulerAngles = var_272_4.localEulerAngles
			end

			local var_272_6 = 0
			local var_272_7 = 0.825

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= var_272_6 + arg_272_0 then
				arg_269_1.talkMaxDuration = 0
				arg_269_1.dialogCg_.alpha = 1

				arg_269_1.dialog_:SetActive(true)
				SetActive(arg_269_1.leftNameGo_, true)

				arg_269_1.leftNameTxt_.text = arg_269_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_269_1.leftNameTxt_.transform)

				arg_269_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_269_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_269_1:RecordName(arg_269_1.leftNameTxt_.text)
				SetActive(arg_269_1.iconTrs_.gameObject, false)
				arg_269_1.callingController_:SetSelectedState("normal")

				local var_272_8 = arg_269_1:GetWordFromCfg(116141065)
				local var_272_9 = arg_269_1:FormatText(var_272_8.content)

				arg_269_1.text_.text = var_272_9

				LuaForUtil.ClearLinePrefixSymbol(arg_269_1.text_)

				local var_272_11 = 33 <= 0 and var_272_7 or var_272_7 * (utf8.len(var_272_9) / 33)

				if (33 <= 0 and var_272_7 or var_272_7 * (utf8.len(var_272_9) / 33)) > 0 and var_272_7 < var_272_11 then
					arg_269_1.talkMaxDuration = var_272_11

					if var_272_11 + var_272_6 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_11 + var_272_6
					end
				end

				arg_269_1.text_.text = var_272_9
				arg_269_1.typewritter.percent = 0

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116141", "116141065", "story_v_out_116141.awb") ~= 0 then
					local var_272_12 = manager.audio:GetVoiceLength("story_v_out_116141", "116141065", "story_v_out_116141.awb") / 1000

					if var_272_12 + var_272_6 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_12 + var_272_6
					end

					if var_272_8.prefab_name ~= "" and arg_269_1.actors_[var_272_8.prefab_name] ~= nil then
						local var_272_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_269_1.actors_[var_272_8.prefab_name].transform, "story_v_out_116141", "116141065", "story_v_out_116141.awb")

						arg_269_1:RecordAudio("116141065", var_272_13)
						arg_269_1:RecordAudio("116141065", var_272_13)
					else
						arg_269_1:AudioAction("play", "voice", "story_v_out_116141", "116141065", "story_v_out_116141.awb")
					end

					arg_269_1:RecordHistoryTalkVoice("story_v_out_116141", "116141065", "story_v_out_116141.awb")
				end

				arg_269_1:RecordContent(arg_269_1.text_.text)
			end

			local var_272_14 = math.max(var_272_7, arg_269_1.talkMaxDuration)

			if var_272_6 <= arg_269_1.time_ and arg_269_1.time_ < var_272_6 + var_272_14 then
				arg_269_1.typewritter.percent = (arg_269_1.time_ - var_272_6) / var_272_14

				arg_269_1.typewritter:SetDirty()
			end

			if arg_269_1.time_ >= var_272_6 + var_272_14 and arg_269_1.time_ < var_272_6 + var_272_14 + arg_272_0 then
				arg_269_1.typewritter.percent = 1

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(true)
			end
		end

		arg_269_1.nodeConfigList_ = {
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

		arg_269_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST07b",
		"SofdecAsset/story/story_101161201.usm",
		"TextureConfig/Background/STwhite"
	},
	voices = {
		"story_v_out_116141.awb"
	},
	skipMarkers = {
		116141001
	}
}
