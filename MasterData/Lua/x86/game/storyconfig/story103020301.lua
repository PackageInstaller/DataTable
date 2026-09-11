return {
	Play302031001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 302031001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play302031002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.A00 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "A00")
				var_4_0.name = "A00"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.A00 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.A00

				arg_1_1.bgs_.A00.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "A00" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_4 = 2

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_4 + arg_4_0 then
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

			if 0.2 < arg_1_1.time_ and arg_1_1.time_ <= 0.2 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_142", "se_story_142_amb_commandroom", "")
			end

			if 1 < arg_1_1.time_ and arg_1_1.time_ <= 1 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_story_office_new", "bgm_story_office_new", "bgm_story_office_new.awb")

				local var_4_12 = manager.audio:GetAudioName("bgm_story_office_new", "bgm_story_office_new")

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

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "ui_battle", "ui_battle_stopbgm", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_14 = 2
			local var_4_15 = 1.925

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_14 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_16 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_16:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_17 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(302031001).content)

				arg_1_1.text_.text = var_4_17

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_19 = 77 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_17) / 77)

				if (77 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_17) / 77)) > 0 and var_4_15 < var_4_19 then
					arg_1_1.talkMaxDuration = var_4_19
					var_4_14 = var_4_14 + 0.3

					if var_4_19 + var_4_14 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_19 + var_4_14
					end
				end

				arg_1_1.text_.text = var_4_17
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_20 = var_4_14 + 0.3
			local var_4_21 = math.max(var_4_15, arg_1_1.talkMaxDuration)

			if var_4_14 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_20 + var_4_21 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_20) / var_4_21

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_20 + var_4_21 and arg_1_1.time_ < var_4_20 + var_4_21 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play302031002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 302031002
		arg_8_1.duration_ = 3.5

		local var_8_0 = {
			zh = 2.733,
			ja = 3.5
		}
		local var_8_1 = manager.audio:GetLocalizationFlag()

		if var_8_0[var_8_1] ~= nil then
			arg_8_1.duration_ = var_8_0[var_8_1]
		end

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play302031003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			if arg_8_1.actors_["1019ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1019ui_story"))) then
				local var_11_0 = Object.Instantiate(Asset.Load("Char/" .. "1019ui_story"), arg_8_1.stage_.transform)

				var_11_0.name = "1019ui_story"
				var_11_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_8_1.actors_["1019ui_story"] = var_11_0

				local var_11_1 = var_11_0:GetComponentInChildren(typeof(CharacterEffect))

				var_11_1.enabled = true

				local var_11_2 = GameObjectTools.GetOrAddComponent(var_11_0, typeof(DynamicBoneHelper))

				if var_11_2 then
					var_11_2:EnableDynamicBone(false)
				end

				arg_8_1:ShowWeapon(var_11_1.transform, false)

				arg_8_1.var_["1019ui_story" .. "Animator"] = var_11_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_8_1.var_["1019ui_story" .. "Animator"].applyRootMotion = true
				arg_8_1.var_["1019ui_story" .. "LipSync"] = var_11_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_11_3 = arg_8_1.actors_["1019ui_story"].transform

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1.var_.moveOldPos1019ui_story = var_11_3.localPosition
			end

			local var_11_4 = 0.001

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_4 then
				var_11_3.localPosition = Vector3.Lerp(arg_8_1.var_.moveOldPos1019ui_story, Vector3.New(-0.7, -1.08, -5.9), (arg_8_1.time_ - 0) / var_11_4)
				var_11_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_11_3.position).x, (manager.ui.mainCamera.transform.position - var_11_3.position).y, (manager.ui.mainCamera.transform.position - var_11_3.position).z)
				var_11_3.localEulerAngles.z = 0
				var_11_3.localEulerAngles.x = 0
				var_11_3.localEulerAngles = var_11_3.localEulerAngles
			end

			if arg_8_1.time_ >= 0 + var_11_4 and arg_8_1.time_ < 0 + var_11_4 + arg_11_0 then
				var_11_3.localPosition = Vector3.New(-0.7, -1.08, -5.9)
				var_11_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_11_3.position).x, (manager.ui.mainCamera.transform.position - var_11_3.position).y, (manager.ui.mainCamera.transform.position - var_11_3.position).z)
				var_11_3.localEulerAngles.z = 0
				var_11_3.localEulerAngles.x = 0
				var_11_3.localEulerAngles = var_11_3.localEulerAngles
			end

			local var_11_5 = arg_8_1.actors_["1019ui_story"]

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 and not isNil(var_11_5) and arg_8_1.var_.characterEffect1019ui_story == nil then
				arg_8_1.var_.characterEffect1019ui_story = var_11_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_11_6 = 0.200000002980232

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_6 and not isNil(var_11_5) then
				if arg_8_1.var_.characterEffect1019ui_story and not isNil(var_11_5) then
					arg_8_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_8_1.time_ >= 0 + var_11_6 and arg_8_1.time_ < 0 + var_11_6 + arg_11_0 and not isNil(var_11_5) and arg_8_1.var_.characterEffect1019ui_story then
				arg_8_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action1_1")
			end

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_11_8 = 0
			local var_11_9 = 0.325

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= var_11_8 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				arg_8_1.leftNameTxt_.text = arg_8_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_10 = arg_8_1:GetWordFromCfg(302031002)
				local var_11_11 = arg_8_1:FormatText(var_11_10.content)

				arg_8_1.text_.text = var_11_11

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_13 = 13 <= 0 and var_11_9 or var_11_9 * (utf8.len(var_11_11) / 13)

				if (13 <= 0 and var_11_9 or var_11_9 * (utf8.len(var_11_11) / 13)) > 0 and var_11_9 < var_11_13 then
					arg_8_1.talkMaxDuration = var_11_13

					if var_11_13 + var_11_8 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_13 + var_11_8
					end
				end

				arg_8_1.text_.text = var_11_11
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302031", "302031002", "story_v_out_302031.awb") ~= 0 then
					local var_11_14 = manager.audio:GetVoiceLength("story_v_out_302031", "302031002", "story_v_out_302031.awb") / 1000

					if var_11_14 + var_11_8 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_14 + var_11_8
					end

					if var_11_10.prefab_name ~= "" and arg_8_1.actors_[var_11_10.prefab_name] ~= nil then
						local var_11_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_8_1.actors_[var_11_10.prefab_name].transform, "story_v_out_302031", "302031002", "story_v_out_302031.awb")

						arg_8_1:RecordAudio("302031002", var_11_15)
						arg_8_1:RecordAudio("302031002", var_11_15)
					else
						arg_8_1:AudioAction("play", "voice", "story_v_out_302031", "302031002", "story_v_out_302031.awb")
					end

					arg_8_1:RecordHistoryTalkVoice("story_v_out_302031", "302031002", "story_v_out_302031.awb")
				end

				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_16 = math.max(var_11_9, arg_8_1.talkMaxDuration)

			if var_11_8 <= arg_8_1.time_ and arg_8_1.time_ < var_11_8 + var_11_16 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_8) / var_11_16

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_8 + var_11_16 and arg_8_1.time_ < var_11_8 + var_11_16 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_8_1:InitPlayNodeList()
	end,
	Play302031003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 302031003
		arg_12_1.duration_ = 4.5

		local var_12_0 = {
			zh = 3.666,
			ja = 4.5
		}
		local var_12_1 = manager.audio:GetLocalizationFlag()

		if var_12_0[var_12_1] ~= nil then
			arg_12_1.duration_ = var_12_0[var_12_1]
		end

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play302031004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			if arg_12_1.actors_["1084ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1084ui_story"))) then
				local var_15_0 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_12_1.stage_.transform)

				var_15_0.name = "1084ui_story"
				var_15_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_12_1.actors_["1084ui_story"] = var_15_0

				local var_15_1 = var_15_0:GetComponentInChildren(typeof(CharacterEffect))

				var_15_1.enabled = true

				local var_15_2 = GameObjectTools.GetOrAddComponent(var_15_0, typeof(DynamicBoneHelper))

				if var_15_2 then
					var_15_2:EnableDynamicBone(false)
				end

				arg_12_1:ShowWeapon(var_15_1.transform, false)

				arg_12_1.var_["1084ui_story" .. "Animator"] = var_15_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_12_1.var_["1084ui_story" .. "Animator"].applyRootMotion = true
				arg_12_1.var_["1084ui_story" .. "LipSync"] = var_15_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_15_3 = arg_12_1.actors_["1084ui_story"].transform

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1.var_.moveOldPos1084ui_story = var_15_3.localPosition
			end

			local var_15_4 = 0.001

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_4 then
				var_15_3.localPosition = Vector3.Lerp(arg_12_1.var_.moveOldPos1084ui_story, Vector3.New(0.7, -0.97, -6), (arg_12_1.time_ - 0) / var_15_4)
				var_15_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_15_3.position).x, (manager.ui.mainCamera.transform.position - var_15_3.position).y, (manager.ui.mainCamera.transform.position - var_15_3.position).z)
				var_15_3.localEulerAngles.z = 0
				var_15_3.localEulerAngles.x = 0
				var_15_3.localEulerAngles = var_15_3.localEulerAngles
			end

			if arg_12_1.time_ >= 0 + var_15_4 and arg_12_1.time_ < 0 + var_15_4 + arg_15_0 then
				var_15_3.localPosition = Vector3.New(0.7, -0.97, -6)
				var_15_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_15_3.position).x, (manager.ui.mainCamera.transform.position - var_15_3.position).y, (manager.ui.mainCamera.transform.position - var_15_3.position).z)
				var_15_3.localEulerAngles.z = 0
				var_15_3.localEulerAngles.x = 0
				var_15_3.localEulerAngles = var_15_3.localEulerAngles
			end

			local var_15_5 = arg_12_1.actors_["1084ui_story"]

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 and not isNil(var_15_5) and arg_12_1.var_.characterEffect1084ui_story == nil then
				arg_12_1.var_.characterEffect1084ui_story = var_15_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_15_6 = 0.200000002980232

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_6 and not isNil(var_15_5) then
				if arg_12_1.var_.characterEffect1084ui_story and not isNil(var_15_5) then
					arg_12_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_12_1.time_ >= 0 + var_15_6 and arg_12_1.time_ < 0 + var_15_6 + arg_15_0 and not isNil(var_15_5) and arg_12_1.var_.characterEffect1084ui_story then
				arg_12_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_15_8 = arg_12_1.actors_["1019ui_story"]

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 and not isNil(var_15_8) and arg_12_1.var_.characterEffect1019ui_story == nil then
				arg_12_1.var_.characterEffect1019ui_story = var_15_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_15_9 = 0.200000002980232

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_9 and not isNil(var_15_8) then
				if arg_12_1.var_.characterEffect1019ui_story and not isNil(var_15_8) then
					arg_12_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_12_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_12_1.time_ - 0) / var_15_9)
				end
			end

			if arg_12_1.time_ >= 0 + var_15_9 and arg_12_1.time_ < 0 + var_15_9 + arg_15_0 and not isNil(var_15_8) and arg_12_1.var_.characterEffect1019ui_story then
				arg_12_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_12_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_1")
			end

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_15_10 = 0
			local var_15_11 = 0.325

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= var_15_10 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				arg_12_1.leftNameTxt_.text = arg_12_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_12 = arg_12_1:GetWordFromCfg(302031003)
				local var_15_13 = arg_12_1:FormatText(var_15_12.content)

				arg_12_1.text_.text = var_15_13

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_15 = 13 <= 0 and var_15_11 or var_15_11 * (utf8.len(var_15_13) / 13)

				if (13 <= 0 and var_15_11 or var_15_11 * (utf8.len(var_15_13) / 13)) > 0 and var_15_11 < var_15_15 then
					arg_12_1.talkMaxDuration = var_15_15

					if var_15_15 + var_15_10 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_15 + var_15_10
					end
				end

				arg_12_1.text_.text = var_15_13
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302031", "302031003", "story_v_out_302031.awb") ~= 0 then
					local var_15_16 = manager.audio:GetVoiceLength("story_v_out_302031", "302031003", "story_v_out_302031.awb") / 1000

					if var_15_16 + var_15_10 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_16 + var_15_10
					end

					if var_15_12.prefab_name ~= "" and arg_12_1.actors_[var_15_12.prefab_name] ~= nil then
						local var_15_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_12_1.actors_[var_15_12.prefab_name].transform, "story_v_out_302031", "302031003", "story_v_out_302031.awb")

						arg_12_1:RecordAudio("302031003", var_15_17)
						arg_12_1:RecordAudio("302031003", var_15_17)
					else
						arg_12_1:AudioAction("play", "voice", "story_v_out_302031", "302031003", "story_v_out_302031.awb")
					end

					arg_12_1:RecordHistoryTalkVoice("story_v_out_302031", "302031003", "story_v_out_302031.awb")
				end

				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_18 = math.max(var_15_11, arg_12_1.talkMaxDuration)

			if var_15_10 <= arg_12_1.time_ and arg_12_1.time_ < var_15_10 + var_15_18 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_10) / var_15_18

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_10 + var_15_18 and arg_12_1.time_ < var_15_10 + var_15_18 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {
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

		arg_12_1:InitPlayNodeList()
	end,
	Play302031004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 302031004
		arg_16_1.duration_ = 8.73

		local var_16_0 = {
			zh = 7.866,
			ja = 8.733
		}
		local var_16_1 = manager.audio:GetLocalizationFlag()

		if var_16_0[var_16_1] ~= nil then
			arg_16_1.duration_ = var_16_0[var_16_1]
		end

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play302031005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 and not isNil(arg_16_1.actors_["1019ui_story"]) and arg_16_1.var_.characterEffect1019ui_story == nil then
				arg_16_1.var_.characterEffect1019ui_story = arg_16_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_0 = 0.200000002980232

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_0 and not isNil(arg_16_1.actors_["1019ui_story"]) then
				if arg_16_1.var_.characterEffect1019ui_story and not isNil(arg_16_1.actors_["1019ui_story"]) then
					arg_16_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_16_1.time_ >= 0 + var_19_0 and arg_16_1.time_ < 0 + var_19_0 + arg_19_0 and not isNil(arg_16_1.actors_["1019ui_story"]) and arg_16_1.var_.characterEffect1019ui_story then
				arg_16_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_19_2 = arg_16_1.actors_["1084ui_story"]

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 and not isNil(var_19_2) and arg_16_1.var_.characterEffect1084ui_story == nil then
				arg_16_1.var_.characterEffect1084ui_story = var_19_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_3 = 0.200000002980232

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_3 and not isNil(var_19_2) then
				if arg_16_1.var_.characterEffect1084ui_story and not isNil(var_19_2) then
					arg_16_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_16_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_16_1.time_ - 0) / var_19_3)
				end
			end

			if arg_16_1.time_ >= 0 + var_19_3 and arg_16_1.time_ < 0 + var_19_3 + arg_19_0 and not isNil(var_19_2) and arg_16_1.var_.characterEffect1084ui_story then
				arg_16_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_16_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action1_1")
			end

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_19_4 = 0
			local var_19_5 = 0.85

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= var_19_4 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				arg_16_1.leftNameTxt_.text = arg_16_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_6 = arg_16_1:GetWordFromCfg(302031004)
				local var_19_7 = arg_16_1:FormatText(var_19_6.content)

				arg_16_1.text_.text = var_19_7

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_9 = 34 <= 0 and var_19_5 or var_19_5 * (utf8.len(var_19_7) / 34)

				if (34 <= 0 and var_19_5 or var_19_5 * (utf8.len(var_19_7) / 34)) > 0 and var_19_5 < var_19_9 then
					arg_16_1.talkMaxDuration = var_19_9

					if var_19_9 + var_19_4 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_9 + var_19_4
					end
				end

				arg_16_1.text_.text = var_19_7
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302031", "302031004", "story_v_out_302031.awb") ~= 0 then
					local var_19_10 = manager.audio:GetVoiceLength("story_v_out_302031", "302031004", "story_v_out_302031.awb") / 1000

					if var_19_10 + var_19_4 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_10 + var_19_4
					end

					if var_19_6.prefab_name ~= "" and arg_16_1.actors_[var_19_6.prefab_name] ~= nil then
						local var_19_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_6.prefab_name].transform, "story_v_out_302031", "302031004", "story_v_out_302031.awb")

						arg_16_1:RecordAudio("302031004", var_19_11)
						arg_16_1:RecordAudio("302031004", var_19_11)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_out_302031", "302031004", "story_v_out_302031.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_out_302031", "302031004", "story_v_out_302031.awb")
				end

				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_12 = math.max(var_19_5, arg_16_1.talkMaxDuration)

			if var_19_4 <= arg_16_1.time_ and arg_16_1.time_ < var_19_4 + var_19_12 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_4) / var_19_12

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_4 + var_19_12 and arg_16_1.time_ < var_19_4 + var_19_12 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {}

		arg_16_1:InitPlayNodeList()
	end,
	Play302031005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 302031005
		arg_20_1.duration_ = 11.73

		local var_20_0 = {
			zh = 5.9,
			ja = 11.733
		}
		local var_20_1 = manager.audio:GetLocalizationFlag()

		if var_20_0[var_20_1] ~= nil then
			arg_20_1.duration_ = var_20_0[var_20_1]
		end

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play302031006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action2_1")
			end

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_23_0 = 0
			local var_23_1 = 0.775

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= var_23_0 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				arg_20_1.leftNameTxt_.text = arg_20_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_2 = arg_20_1:GetWordFromCfg(302031005)
				local var_23_3 = arg_20_1:FormatText(var_23_2.content)

				arg_20_1.text_.text = var_23_3

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_5 = 31 <= 0 and var_23_1 or var_23_1 * (utf8.len(var_23_3) / 31)

				if (31 <= 0 and var_23_1 or var_23_1 * (utf8.len(var_23_3) / 31)) > 0 and var_23_1 < var_23_5 then
					arg_20_1.talkMaxDuration = var_23_5

					if var_23_5 + var_23_0 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_5 + var_23_0
					end
				end

				arg_20_1.text_.text = var_23_3
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302031", "302031005", "story_v_out_302031.awb") ~= 0 then
					local var_23_6 = manager.audio:GetVoiceLength("story_v_out_302031", "302031005", "story_v_out_302031.awb") / 1000

					if var_23_6 + var_23_0 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_6 + var_23_0
					end

					if var_23_2.prefab_name ~= "" and arg_20_1.actors_[var_23_2.prefab_name] ~= nil then
						local var_23_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_2.prefab_name].transform, "story_v_out_302031", "302031005", "story_v_out_302031.awb")

						arg_20_1:RecordAudio("302031005", var_23_7)
						arg_20_1:RecordAudio("302031005", var_23_7)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_out_302031", "302031005", "story_v_out_302031.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_out_302031", "302031005", "story_v_out_302031.awb")
				end

				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_8 = math.max(var_23_1, arg_20_1.talkMaxDuration)

			if var_23_0 <= arg_20_1.time_ and arg_20_1.time_ < var_23_0 + var_23_8 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_0) / var_23_8

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_0 + var_23_8 and arg_20_1.time_ < var_23_0 + var_23_8 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {}

		arg_20_1:InitPlayNodeList()
	end,
	Play302031006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 302031006
		arg_24_1.duration_ = 5

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play302031007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 and not isNil(arg_24_1.actors_["1019ui_story"]) and arg_24_1.var_.characterEffect1019ui_story == nil then
				arg_24_1.var_.characterEffect1019ui_story = arg_24_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_0 = 0.200000002980232

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_0 and not isNil(arg_24_1.actors_["1019ui_story"]) then
				if arg_24_1.var_.characterEffect1019ui_story and not isNil(arg_24_1.actors_["1019ui_story"]) then
					arg_24_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_24_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_24_1.time_ - 0) / var_27_0)
				end
			end

			if arg_24_1.time_ >= 0 + var_27_0 and arg_24_1.time_ < 0 + var_27_0 + arg_27_0 and not isNil(arg_24_1.actors_["1019ui_story"]) and arg_24_1.var_.characterEffect1019ui_story then
				arg_24_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_24_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_27_1 = 0
			local var_27_2 = 0.4

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= var_27_1 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				arg_24_1.leftNameTxt_.text = arg_24_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, true)
				arg_24_1.iconController_:SetSelectedState("hero")

				arg_24_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_24_1.callingController_:SetSelectedState("normal")

				arg_24_1.keyicon_.color = Color.New(1, 1, 1)
				arg_24_1.icon_.color = Color.New(1, 1, 1)

				local var_27_3 = arg_24_1:FormatText(arg_24_1:GetWordFromCfg(302031006).content)

				arg_24_1.text_.text = var_27_3

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_5 = 16 <= 0 and var_27_2 or var_27_2 * (utf8.len(var_27_3) / 16)

				if (16 <= 0 and var_27_2 or var_27_2 * (utf8.len(var_27_3) / 16)) > 0 and var_27_2 < var_27_5 then
					arg_24_1.talkMaxDuration = var_27_5

					if var_27_5 + var_27_1 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_5 + var_27_1
					end
				end

				arg_24_1.text_.text = var_27_3
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)
				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_6 = math.max(var_27_2, arg_24_1.talkMaxDuration)

			if var_27_1 <= arg_24_1.time_ and arg_24_1.time_ < var_27_1 + var_27_6 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_1) / var_27_6

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_1 + var_27_6 and arg_24_1.time_ < var_27_1 + var_27_6 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {}

		arg_24_1:InitPlayNodeList()
	end,
	Play302031007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 302031007
		arg_28_1.duration_ = 5.77

		local var_28_0 = {
			zh = 3.9,
			ja = 5.766
		}
		local var_28_1 = manager.audio:GetLocalizationFlag()

		if var_28_0[var_28_1] ~= nil then
			arg_28_1.duration_ = var_28_0[var_28_1]
		end

		SetActive(arg_28_1.tipsGo_, false)

		function arg_28_1.onSingleLineFinish_()
			arg_28_1.onSingleLineUpdate_ = nil
			arg_28_1.onSingleLineFinish_ = nil
			arg_28_1.state_ = "waiting"
		end

		function arg_28_1.playNext_(arg_30_0)
			if arg_30_0 == 1 then
				arg_28_0:Play302031008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 and not isNil(arg_28_1.actors_["1019ui_story"]) and arg_28_1.var_.characterEffect1019ui_story == nil then
				arg_28_1.var_.characterEffect1019ui_story = arg_28_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_0 = 0.200000002980232

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_0 and not isNil(arg_28_1.actors_["1019ui_story"]) then
				if arg_28_1.var_.characterEffect1019ui_story and not isNil(arg_28_1.actors_["1019ui_story"]) then
					arg_28_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_28_1.time_ >= 0 + var_31_0 and arg_28_1.time_ < 0 + var_31_0 + arg_31_0 and not isNil(arg_28_1.actors_["1019ui_story"]) and arg_28_1.var_.characterEffect1019ui_story then
				arg_28_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action2_2")
			end

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_31_2 = 0
			local var_31_3 = 0.525

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= var_31_2 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				arg_28_1.leftNameTxt_.text = arg_28_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_4 = arg_28_1:GetWordFromCfg(302031007)
				local var_31_5 = arg_28_1:FormatText(var_31_4.content)

				arg_28_1.text_.text = var_31_5

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_7 = 21 <= 0 and var_31_3 or var_31_3 * (utf8.len(var_31_5) / 21)

				if (21 <= 0 and var_31_3 or var_31_3 * (utf8.len(var_31_5) / 21)) > 0 and var_31_3 < var_31_7 then
					arg_28_1.talkMaxDuration = var_31_7

					if var_31_7 + var_31_2 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_7 + var_31_2
					end
				end

				arg_28_1.text_.text = var_31_5
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302031", "302031007", "story_v_out_302031.awb") ~= 0 then
					local var_31_8 = manager.audio:GetVoiceLength("story_v_out_302031", "302031007", "story_v_out_302031.awb") / 1000

					if var_31_8 + var_31_2 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_8 + var_31_2
					end

					if var_31_4.prefab_name ~= "" and arg_28_1.actors_[var_31_4.prefab_name] ~= nil then
						local var_31_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_4.prefab_name].transform, "story_v_out_302031", "302031007", "story_v_out_302031.awb")

						arg_28_1:RecordAudio("302031007", var_31_9)
						arg_28_1:RecordAudio("302031007", var_31_9)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_out_302031", "302031007", "story_v_out_302031.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_out_302031", "302031007", "story_v_out_302031.awb")
				end

				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_10 = math.max(var_31_3, arg_28_1.talkMaxDuration)

			if var_31_2 <= arg_28_1.time_ and arg_28_1.time_ < var_31_2 + var_31_10 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_2) / var_31_10

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_2 + var_31_10 and arg_28_1.time_ < var_31_2 + var_31_10 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {}

		arg_28_1:InitPlayNodeList()
	end,
	Play302031008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 302031008
		arg_32_1.duration_ = 10.1

		local var_32_0 = {
			zh = 7.5,
			ja = 10.1
		}
		local var_32_1 = manager.audio:GetLocalizationFlag()

		if var_32_0[var_32_1] ~= nil then
			arg_32_1.duration_ = var_32_0[var_32_1]
		end

		SetActive(arg_32_1.tipsGo_, false)

		function arg_32_1.onSingleLineFinish_()
			arg_32_1.onSingleLineUpdate_ = nil
			arg_32_1.onSingleLineFinish_ = nil
			arg_32_1.state_ = "waiting"
		end

		function arg_32_1.playNext_(arg_34_0)
			if arg_34_0 == 1 then
				arg_32_0:Play302031009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = 0.925

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				arg_32_1.leftNameTxt_.text = arg_32_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_1 = arg_32_1:GetWordFromCfg(302031008)
				local var_35_2 = arg_32_1:FormatText(var_35_1.content)

				arg_32_1.text_.text = var_35_2

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_4 = 37 <= 0 and var_35_0 or var_35_0 * (utf8.len(var_35_2) / 37)

				if (37 <= 0 and var_35_0 or var_35_0 * (utf8.len(var_35_2) / 37)) > 0 and var_35_0 < var_35_4 then
					arg_32_1.talkMaxDuration = var_35_4

					if var_35_4 + 0 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_4 + 0
					end
				end

				arg_32_1.text_.text = var_35_2
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302031", "302031008", "story_v_out_302031.awb") ~= 0 then
					local var_35_5 = manager.audio:GetVoiceLength("story_v_out_302031", "302031008", "story_v_out_302031.awb") / 1000

					if var_35_5 + 0 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_5 + 0
					end

					if var_35_1.prefab_name ~= "" and arg_32_1.actors_[var_35_1.prefab_name] ~= nil then
						local var_35_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_1.prefab_name].transform, "story_v_out_302031", "302031008", "story_v_out_302031.awb")

						arg_32_1:RecordAudio("302031008", var_35_6)
						arg_32_1:RecordAudio("302031008", var_35_6)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_out_302031", "302031008", "story_v_out_302031.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_out_302031", "302031008", "story_v_out_302031.awb")
				end

				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_7 = math.max(var_35_0, arg_32_1.talkMaxDuration)

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_7 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - 0) / var_35_7

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= 0 + var_35_7 and arg_32_1.time_ < 0 + var_35_7 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {}

		arg_32_1:InitPlayNodeList()
	end,
	Play302031009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 302031009
		arg_36_1.duration_ = 8.47

		local var_36_0 = {
			zh = 6.6,
			ja = 8.466
		}
		local var_36_1 = manager.audio:GetLocalizationFlag()

		if var_36_0[var_36_1] ~= nil then
			arg_36_1.duration_ = var_36_0[var_36_1]
		end

		SetActive(arg_36_1.tipsGo_, false)

		function arg_36_1.onSingleLineFinish_()
			arg_36_1.onSingleLineUpdate_ = nil
			arg_36_1.onSingleLineFinish_ = nil
			arg_36_1.state_ = "waiting"
		end

		function arg_36_1.playNext_(arg_38_0)
			if arg_38_0 == 1 then
				arg_36_0:Play302031010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action1_1")
			end

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_39_0 = 0
			local var_39_1 = 0.85

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= var_39_0 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				arg_36_1.leftNameTxt_.text = arg_36_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_2 = arg_36_1:GetWordFromCfg(302031009)
				local var_39_3 = arg_36_1:FormatText(var_39_2.content)

				arg_36_1.text_.text = var_39_3

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_5 = 34 <= 0 and var_39_1 or var_39_1 * (utf8.len(var_39_3) / 34)

				if (34 <= 0 and var_39_1 or var_39_1 * (utf8.len(var_39_3) / 34)) > 0 and var_39_1 < var_39_5 then
					arg_36_1.talkMaxDuration = var_39_5

					if var_39_5 + var_39_0 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_5 + var_39_0
					end
				end

				arg_36_1.text_.text = var_39_3
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302031", "302031009", "story_v_out_302031.awb") ~= 0 then
					local var_39_6 = manager.audio:GetVoiceLength("story_v_out_302031", "302031009", "story_v_out_302031.awb") / 1000

					if var_39_6 + var_39_0 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_6 + var_39_0
					end

					if var_39_2.prefab_name ~= "" and arg_36_1.actors_[var_39_2.prefab_name] ~= nil then
						local var_39_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_2.prefab_name].transform, "story_v_out_302031", "302031009", "story_v_out_302031.awb")

						arg_36_1:RecordAudio("302031009", var_39_7)
						arg_36_1:RecordAudio("302031009", var_39_7)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_out_302031", "302031009", "story_v_out_302031.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_out_302031", "302031009", "story_v_out_302031.awb")
				end

				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_8 = math.max(var_39_1, arg_36_1.talkMaxDuration)

			if var_39_0 <= arg_36_1.time_ and arg_36_1.time_ < var_39_0 + var_39_8 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_0) / var_39_8

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_0 + var_39_8 and arg_36_1.time_ < var_39_0 + var_39_8 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {}

		arg_36_1:InitPlayNodeList()
	end,
	Play302031010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 302031010
		arg_40_1.duration_ = 2.5

		local var_40_0 = {
			zh = 2.5,
			ja = 1.999999999999
		}
		local var_40_1 = manager.audio:GetLocalizationFlag()

		if var_40_0[var_40_1] ~= nil then
			arg_40_1.duration_ = var_40_0[var_40_1]
		end

		SetActive(arg_40_1.tipsGo_, false)

		function arg_40_1.onSingleLineFinish_()
			arg_40_1.onSingleLineUpdate_ = nil
			arg_40_1.onSingleLineFinish_ = nil
			arg_40_1.state_ = "waiting"
		end

		function arg_40_1.playNext_(arg_42_0)
			if arg_42_0 == 1 then
				arg_40_0:Play302031011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			if arg_40_1.actors_["1166ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1166ui_story"))) then
				local var_43_0 = Object.Instantiate(Asset.Load("Char/" .. "1166ui_story"), arg_40_1.stage_.transform)

				var_43_0.name = "1166ui_story"
				var_43_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_40_1.actors_["1166ui_story"] = var_43_0

				local var_43_1 = var_43_0:GetComponentInChildren(typeof(CharacterEffect))

				var_43_1.enabled = true

				local var_43_2 = GameObjectTools.GetOrAddComponent(var_43_0, typeof(DynamicBoneHelper))

				if var_43_2 then
					var_43_2:EnableDynamicBone(false)
				end

				arg_40_1:ShowWeapon(var_43_1.transform, false)

				arg_40_1.var_["1166ui_story" .. "Animator"] = var_43_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_40_1.var_["1166ui_story" .. "Animator"].applyRootMotion = true
				arg_40_1.var_["1166ui_story" .. "LipSync"] = var_43_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_43_3 = arg_40_1.actors_["1166ui_story"].transform

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1.var_.moveOldPos1166ui_story = var_43_3.localPosition

				local var_43_4 = GameObjectTools.GetOrAddComponent(var_43_3.gameObject, typeof(DynamicBoneHelper))

				if var_43_4 then
					var_43_4:EnableDynamicBone(false)
				end
			end

			local var_43_5 = 0.001

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_5 then
				var_43_3.localPosition = Vector3.Lerp(arg_40_1.var_.moveOldPos1166ui_story, Vector3.New(0.7, -0.75, -6.25), (arg_40_1.time_ - 0) / var_43_5)
				var_43_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_43_3.position).x, (manager.ui.mainCamera.transform.position - var_43_3.position).y, (manager.ui.mainCamera.transform.position - var_43_3.position).z)
				var_43_3.localEulerAngles.z = 0
				var_43_3.localEulerAngles.x = 0
				var_43_3.localEulerAngles = var_43_3.localEulerAngles
			end

			if arg_40_1.time_ >= 0 + var_43_5 and arg_40_1.time_ < 0 + var_43_5 + arg_43_0 then
				var_43_3.localPosition = Vector3.New(0.7, -0.75, -6.25)
				var_43_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_43_3.position).x, (manager.ui.mainCamera.transform.position - var_43_3.position).y, (manager.ui.mainCamera.transform.position - var_43_3.position).z)
				var_43_3.localEulerAngles.z = 0
				var_43_3.localEulerAngles.x = 0
				var_43_3.localEulerAngles = var_43_3.localEulerAngles

				local var_43_6 = GameObjectTools.GetOrAddComponent(var_43_3.gameObject, typeof(DynamicBoneHelper))

				if var_43_6 then
					var_43_6:EnableDynamicBone(true)
				end
			end

			local var_43_7 = arg_40_1.actors_["1084ui_story"].transform

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1.var_.moveOldPos1084ui_story = var_43_7.localPosition
			end

			local var_43_8 = 0.001

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_8 then
				var_43_7.localPosition = Vector3.Lerp(arg_40_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_40_1.time_ - 0) / var_43_8)
				var_43_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_43_7.position).x, (manager.ui.mainCamera.transform.position - var_43_7.position).y, (manager.ui.mainCamera.transform.position - var_43_7.position).z)
				var_43_7.localEulerAngles.z = 0
				var_43_7.localEulerAngles.x = 0
				var_43_7.localEulerAngles = var_43_7.localEulerAngles
			end

			if arg_40_1.time_ >= 0 + var_43_8 and arg_40_1.time_ < 0 + var_43_8 + arg_43_0 then
				var_43_7.localPosition = Vector3.New(0, 100, 0)
				var_43_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_43_7.position).x, (manager.ui.mainCamera.transform.position - var_43_7.position).y, (manager.ui.mainCamera.transform.position - var_43_7.position).z)
				var_43_7.localEulerAngles.z = 0
				var_43_7.localEulerAngles.x = 0
				var_43_7.localEulerAngles = var_43_7.localEulerAngles
			end

			local var_43_9 = arg_40_1.actors_["1166ui_story"]

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 and not isNil(var_43_9) and arg_40_1.var_.characterEffect1166ui_story == nil then
				arg_40_1.var_.characterEffect1166ui_story = var_43_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_10 = 0.200000002980232

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_10 and not isNil(var_43_9) then
				if arg_40_1.var_.characterEffect1166ui_story and not isNil(var_43_9) then
					arg_40_1.var_.characterEffect1166ui_story.fillFlat = false
				end
			end

			if arg_40_1.time_ >= 0 + var_43_10 and arg_40_1.time_ < 0 + var_43_10 + arg_43_0 and not isNil(var_43_9) and arg_40_1.var_.characterEffect1166ui_story then
				arg_40_1.var_.characterEffect1166ui_story.fillFlat = false
			end

			local var_43_12 = arg_40_1.actors_["1019ui_story"]

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 and not isNil(var_43_12) and arg_40_1.var_.characterEffect1019ui_story == nil then
				arg_40_1.var_.characterEffect1019ui_story = var_43_12:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_13 = 0.200000002980232

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_13 and not isNil(var_43_12) then
				if arg_40_1.var_.characterEffect1019ui_story and not isNil(var_43_12) then
					arg_40_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_40_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_40_1.time_ - 0) / var_43_13)
				end
			end

			if arg_40_1.time_ >= 0 + var_43_13 and arg_40_1.time_ < 0 + var_43_13 + arg_43_0 and not isNil(var_43_12) and arg_40_1.var_.characterEffect1019ui_story then
				arg_40_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_40_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1:PlayTimeline("1166ui_story", "StoryTimeline/CharAction/story1166/story1166action/1166action4_1")
			end

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1:PlayTimeline("1166ui_story", "StoryTimeline/CharAction/public_expression/expr_wuganB", "EmotionTimelineAnimator")
			end

			local var_43_14 = 0
			local var_43_15 = 0.175

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= var_43_14 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				arg_40_1.leftNameTxt_.text = arg_40_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_16 = arg_40_1:GetWordFromCfg(302031010)
				local var_43_17 = arg_40_1:FormatText(var_43_16.content)

				arg_40_1.text_.text = var_43_17

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_19 = 7 <= 0 and var_43_15 or var_43_15 * (utf8.len(var_43_17) / 7)

				if (7 <= 0 and var_43_15 or var_43_15 * (utf8.len(var_43_17) / 7)) > 0 and var_43_15 < var_43_19 then
					arg_40_1.talkMaxDuration = var_43_19

					if var_43_19 + var_43_14 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_19 + var_43_14
					end
				end

				arg_40_1.text_.text = var_43_17
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302031", "302031010", "story_v_out_302031.awb") ~= 0 then
					local var_43_20 = manager.audio:GetVoiceLength("story_v_out_302031", "302031010", "story_v_out_302031.awb") / 1000

					if var_43_20 + var_43_14 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_20 + var_43_14
					end

					if var_43_16.prefab_name ~= "" and arg_40_1.actors_[var_43_16.prefab_name] ~= nil then
						local var_43_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_16.prefab_name].transform, "story_v_out_302031", "302031010", "story_v_out_302031.awb")

						arg_40_1:RecordAudio("302031010", var_43_21)
						arg_40_1:RecordAudio("302031010", var_43_21)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_out_302031", "302031010", "story_v_out_302031.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_out_302031", "302031010", "story_v_out_302031.awb")
				end

				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_22 = math.max(var_43_15, arg_40_1.talkMaxDuration)

			if var_43_14 <= arg_40_1.time_ and arg_40_1.time_ < var_43_14 + var_43_22 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_14) / var_43_22

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_14 + var_43_22 and arg_40_1.time_ < var_43_14 + var_43_22 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1166ui_story",
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

		arg_40_1:InitPlayNodeList()
	end,
	Play302031011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 302031011
		arg_44_1.duration_ = 6.7

		local var_44_0 = {
			zh = 5.9,
			ja = 6.7
		}
		local var_44_1 = manager.audio:GetLocalizationFlag()

		if var_44_0[var_44_1] ~= nil then
			arg_44_1.duration_ = var_44_0[var_44_1]
		end

		SetActive(arg_44_1.tipsGo_, false)

		function arg_44_1.onSingleLineFinish_()
			arg_44_1.onSingleLineUpdate_ = nil
			arg_44_1.onSingleLineFinish_ = nil
			arg_44_1.state_ = "waiting"
		end

		function arg_44_1.playNext_(arg_46_0)
			if arg_46_0 == 1 then
				arg_44_0:Play302031012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 and not isNil(arg_44_1.actors_["1019ui_story"]) and arg_44_1.var_.characterEffect1019ui_story == nil then
				arg_44_1.var_.characterEffect1019ui_story = arg_44_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_0 = 0.200000002980232

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_0 and not isNil(arg_44_1.actors_["1019ui_story"]) then
				if arg_44_1.var_.characterEffect1019ui_story and not isNil(arg_44_1.actors_["1019ui_story"]) then
					arg_44_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_44_1.time_ >= 0 + var_47_0 and arg_44_1.time_ < 0 + var_47_0 + arg_47_0 and not isNil(arg_44_1.actors_["1019ui_story"]) and arg_44_1.var_.characterEffect1019ui_story then
				arg_44_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_47_2 = arg_44_1.actors_["1166ui_story"]

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 and not isNil(var_47_2) and arg_44_1.var_.characterEffect1166ui_story == nil then
				arg_44_1.var_.characterEffect1166ui_story = var_47_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_3 = 0.200000002980232

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_3 and not isNil(var_47_2) then
				if arg_44_1.var_.characterEffect1166ui_story and not isNil(var_47_2) then
					arg_44_1.var_.characterEffect1166ui_story.fillFlat = true
					arg_44_1.var_.characterEffect1166ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_44_1.time_ - 0) / var_47_3)
				end
			end

			if arg_44_1.time_ >= 0 + var_47_3 and arg_44_1.time_ < 0 + var_47_3 + arg_47_0 and not isNil(var_47_2) and arg_44_1.var_.characterEffect1166ui_story then
				arg_44_1.var_.characterEffect1166ui_story.fillFlat = true
				arg_44_1.var_.characterEffect1166ui_story.fillRatio = 0.5
			end

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action1_1")
			end

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_47_4 = 0
			local var_47_5 = 0.725

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= var_47_4 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				arg_44_1.leftNameTxt_.text = arg_44_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_6 = arg_44_1:GetWordFromCfg(302031011)
				local var_47_7 = arg_44_1:FormatText(var_47_6.content)

				arg_44_1.text_.text = var_47_7

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_9 = 29 <= 0 and var_47_5 or var_47_5 * (utf8.len(var_47_7) / 29)

				if (29 <= 0 and var_47_5 or var_47_5 * (utf8.len(var_47_7) / 29)) > 0 and var_47_5 < var_47_9 then
					arg_44_1.talkMaxDuration = var_47_9

					if var_47_9 + var_47_4 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_9 + var_47_4
					end
				end

				arg_44_1.text_.text = var_47_7
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302031", "302031011", "story_v_out_302031.awb") ~= 0 then
					local var_47_10 = manager.audio:GetVoiceLength("story_v_out_302031", "302031011", "story_v_out_302031.awb") / 1000

					if var_47_10 + var_47_4 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_10 + var_47_4
					end

					if var_47_6.prefab_name ~= "" and arg_44_1.actors_[var_47_6.prefab_name] ~= nil then
						local var_47_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_6.prefab_name].transform, "story_v_out_302031", "302031011", "story_v_out_302031.awb")

						arg_44_1:RecordAudio("302031011", var_47_11)
						arg_44_1:RecordAudio("302031011", var_47_11)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_out_302031", "302031011", "story_v_out_302031.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_out_302031", "302031011", "story_v_out_302031.awb")
				end

				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_12 = math.max(var_47_5, arg_44_1.talkMaxDuration)

			if var_47_4 <= arg_44_1.time_ and arg_44_1.time_ < var_47_4 + var_47_12 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_4) / var_47_12

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_4 + var_47_12 and arg_44_1.time_ < var_47_4 + var_47_12 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {}

		arg_44_1:InitPlayNodeList()
	end,
	Play302031012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 302031012
		arg_48_1.duration_ = 8.83

		local var_48_0 = {
			zh = 5.666,
			ja = 8.833
		}
		local var_48_1 = manager.audio:GetLocalizationFlag()

		if var_48_0[var_48_1] ~= nil then
			arg_48_1.duration_ = var_48_0[var_48_1]
		end

		SetActive(arg_48_1.tipsGo_, false)

		function arg_48_1.onSingleLineFinish_()
			arg_48_1.onSingleLineUpdate_ = nil
			arg_48_1.onSingleLineFinish_ = nil
			arg_48_1.state_ = "waiting"
		end

		function arg_48_1.playNext_(arg_50_0)
			if arg_50_0 == 1 then
				arg_48_0:Play302031013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action5_1")
			end

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_51_0 = 0
			local var_51_1 = 0.7

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= var_51_0 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				arg_48_1.leftNameTxt_.text = arg_48_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_2 = arg_48_1:GetWordFromCfg(302031012)
				local var_51_3 = arg_48_1:FormatText(var_51_2.content)

				arg_48_1.text_.text = var_51_3

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_5 = 28 <= 0 and var_51_1 or var_51_1 * (utf8.len(var_51_3) / 28)

				if (28 <= 0 and var_51_1 or var_51_1 * (utf8.len(var_51_3) / 28)) > 0 and var_51_1 < var_51_5 then
					arg_48_1.talkMaxDuration = var_51_5

					if var_51_5 + var_51_0 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_5 + var_51_0
					end
				end

				arg_48_1.text_.text = var_51_3
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302031", "302031012", "story_v_out_302031.awb") ~= 0 then
					local var_51_6 = manager.audio:GetVoiceLength("story_v_out_302031", "302031012", "story_v_out_302031.awb") / 1000

					if var_51_6 + var_51_0 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_6 + var_51_0
					end

					if var_51_2.prefab_name ~= "" and arg_48_1.actors_[var_51_2.prefab_name] ~= nil then
						local var_51_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_2.prefab_name].transform, "story_v_out_302031", "302031012", "story_v_out_302031.awb")

						arg_48_1:RecordAudio("302031012", var_51_7)
						arg_48_1:RecordAudio("302031012", var_51_7)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_out_302031", "302031012", "story_v_out_302031.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_out_302031", "302031012", "story_v_out_302031.awb")
				end

				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_8 = math.max(var_51_1, arg_48_1.talkMaxDuration)

			if var_51_0 <= arg_48_1.time_ and arg_48_1.time_ < var_51_0 + var_51_8 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_0) / var_51_8

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_0 + var_51_8 and arg_48_1.time_ < var_51_0 + var_51_8 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {}

		arg_48_1:InitPlayNodeList()
	end,
	Play302031013 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 302031013
		arg_52_1.duration_ = 4.7

		local var_52_0 = {
			zh = 4.7,
			ja = 4.566
		}
		local var_52_1 = manager.audio:GetLocalizationFlag()

		if var_52_0[var_52_1] ~= nil then
			arg_52_1.duration_ = var_52_0[var_52_1]
		end

		SetActive(arg_52_1.tipsGo_, false)

		function arg_52_1.onSingleLineFinish_()
			arg_52_1.onSingleLineUpdate_ = nil
			arg_52_1.onSingleLineFinish_ = nil
			arg_52_1.state_ = "waiting"
		end

		function arg_52_1.playNext_(arg_54_0)
			if arg_54_0 == 1 then
				arg_52_0:Play302031014(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 then
				arg_52_1.var_.moveOldPos1166ui_story = arg_52_1.actors_["1166ui_story"].transform.localPosition

				local var_55_0 = GameObjectTools.GetOrAddComponent(arg_52_1.actors_["1166ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_55_0 then
					var_55_0:EnableDynamicBone(false)
				end
			end

			local var_55_1 = 0.001

			if 0 <= arg_52_1.time_ and arg_52_1.time_ < 0 + var_55_1 then
				arg_52_1.actors_["1166ui_story"].transform.localPosition = Vector3.Lerp(arg_52_1.var_.moveOldPos1166ui_story, Vector3.New(0, 100, 0), (arg_52_1.time_ - 0) / var_55_1)
				arg_52_1.actors_["1166ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_52_1.actors_["1166ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_52_1.actors_["1166ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_52_1.actors_["1166ui_story"].transform.position).z)
				arg_52_1.actors_["1166ui_story"].transform.localEulerAngles.z = 0
				arg_52_1.actors_["1166ui_story"].transform.localEulerAngles.x = 0
				arg_52_1.actors_["1166ui_story"].transform.localEulerAngles = arg_52_1.actors_["1166ui_story"].transform.localEulerAngles
			end

			if arg_52_1.time_ >= 0 + var_55_1 and arg_52_1.time_ < 0 + var_55_1 + arg_55_0 then
				arg_52_1.actors_["1166ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_52_1.actors_["1166ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_52_1.actors_["1166ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_52_1.actors_["1166ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_52_1.actors_["1166ui_story"].transform.position).z)
				arg_52_1.actors_["1166ui_story"].transform.localEulerAngles.z = 0
				arg_52_1.actors_["1166ui_story"].transform.localEulerAngles.x = 0
				arg_52_1.actors_["1166ui_story"].transform.localEulerAngles = arg_52_1.actors_["1166ui_story"].transform.localEulerAngles

				local var_55_2 = GameObjectTools.GetOrAddComponent(arg_52_1.actors_["1166ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_55_2 then
					var_55_2:EnableDynamicBone(true)
				end
			end

			local var_55_3 = arg_52_1.actors_["1084ui_story"].transform

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 then
				arg_52_1.var_.moveOldPos1084ui_story = var_55_3.localPosition
			end

			local var_55_4 = 0.001

			if 0 <= arg_52_1.time_ and arg_52_1.time_ < 0 + var_55_4 then
				var_55_3.localPosition = Vector3.Lerp(arg_52_1.var_.moveOldPos1084ui_story, Vector3.New(0.7, -0.97, -6), (arg_52_1.time_ - 0) / var_55_4)
				var_55_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_55_3.position).x, (manager.ui.mainCamera.transform.position - var_55_3.position).y, (manager.ui.mainCamera.transform.position - var_55_3.position).z)
				var_55_3.localEulerAngles.z = 0
				var_55_3.localEulerAngles.x = 0
				var_55_3.localEulerAngles = var_55_3.localEulerAngles
			end

			if arg_52_1.time_ >= 0 + var_55_4 and arg_52_1.time_ < 0 + var_55_4 + arg_55_0 then
				var_55_3.localPosition = Vector3.New(0.7, -0.97, -6)
				var_55_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_55_3.position).x, (manager.ui.mainCamera.transform.position - var_55_3.position).y, (manager.ui.mainCamera.transform.position - var_55_3.position).z)
				var_55_3.localEulerAngles.z = 0
				var_55_3.localEulerAngles.x = 0
				var_55_3.localEulerAngles = var_55_3.localEulerAngles
			end

			local var_55_5 = arg_52_1.actors_["1084ui_story"]

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 and not isNil(var_55_5) and arg_52_1.var_.characterEffect1084ui_story == nil then
				arg_52_1.var_.characterEffect1084ui_story = var_55_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_6 = 0.200000002980232

			if 0 <= arg_52_1.time_ and arg_52_1.time_ < 0 + var_55_6 and not isNil(var_55_5) then
				if arg_52_1.var_.characterEffect1084ui_story and not isNil(var_55_5) then
					arg_52_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_52_1.time_ >= 0 + var_55_6 and arg_52_1.time_ < 0 + var_55_6 + arg_55_0 and not isNil(var_55_5) and arg_52_1.var_.characterEffect1084ui_story then
				arg_52_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_55_8 = arg_52_1.actors_["1019ui_story"]

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 and not isNil(var_55_8) and arg_52_1.var_.characterEffect1019ui_story == nil then
				arg_52_1.var_.characterEffect1019ui_story = var_55_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_9 = 0.200000002980232

			if 0 <= arg_52_1.time_ and arg_52_1.time_ < 0 + var_55_9 and not isNil(var_55_8) then
				if arg_52_1.var_.characterEffect1019ui_story and not isNil(var_55_8) then
					arg_52_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_52_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_52_1.time_ - 0) / var_55_9)
				end
			end

			if arg_52_1.time_ >= 0 + var_55_9 and arg_52_1.time_ < 0 + var_55_9 + arg_55_0 and not isNil(var_55_8) and arg_52_1.var_.characterEffect1019ui_story then
				arg_52_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_52_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 then
				arg_52_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action8_1")
			end

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 then
				arg_52_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_55_10 = 0
			local var_55_11 = 0.5

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= var_55_10 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				arg_52_1.leftNameTxt_.text = arg_52_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_12 = arg_52_1:GetWordFromCfg(302031013)
				local var_55_13 = arg_52_1:FormatText(var_55_12.content)

				arg_52_1.text_.text = var_55_13

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_15 = 20 <= 0 and var_55_11 or var_55_11 * (utf8.len(var_55_13) / 20)

				if (20 <= 0 and var_55_11 or var_55_11 * (utf8.len(var_55_13) / 20)) > 0 and var_55_11 < var_55_15 then
					arg_52_1.talkMaxDuration = var_55_15

					if var_55_15 + var_55_10 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_15 + var_55_10
					end
				end

				arg_52_1.text_.text = var_55_13
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302031", "302031013", "story_v_out_302031.awb") ~= 0 then
					local var_55_16 = manager.audio:GetVoiceLength("story_v_out_302031", "302031013", "story_v_out_302031.awb") / 1000

					if var_55_16 + var_55_10 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_16 + var_55_10
					end

					if var_55_12.prefab_name ~= "" and arg_52_1.actors_[var_55_12.prefab_name] ~= nil then
						local var_55_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_12.prefab_name].transform, "story_v_out_302031", "302031013", "story_v_out_302031.awb")

						arg_52_1:RecordAudio("302031013", var_55_17)
						arg_52_1:RecordAudio("302031013", var_55_17)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_out_302031", "302031013", "story_v_out_302031.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_out_302031", "302031013", "story_v_out_302031.awb")
				end

				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_18 = math.max(var_55_11, arg_52_1.talkMaxDuration)

			if var_55_10 <= arg_52_1.time_ and arg_52_1.time_ < var_55_10 + var_55_18 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_10) / var_55_18

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_10 + var_55_18 and arg_52_1.time_ < var_55_10 + var_55_18 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1166ui_story",
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

		arg_52_1:InitPlayNodeList()
	end,
	Play302031014 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 302031014
		arg_56_1.duration_ = 5

		SetActive(arg_56_1.tipsGo_, false)

		function arg_56_1.onSingleLineFinish_()
			arg_56_1.onSingleLineUpdate_ = nil
			arg_56_1.onSingleLineFinish_ = nil
			arg_56_1.state_ = "waiting"
		end

		function arg_56_1.playNext_(arg_58_0)
			if arg_58_0 == 1 then
				arg_56_0:Play302031015(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 and not isNil(arg_56_1.actors_["1084ui_story"]) and arg_56_1.var_.characterEffect1084ui_story == nil then
				arg_56_1.var_.characterEffect1084ui_story = arg_56_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_59_0 = 0.200000002980232

			if 0 <= arg_56_1.time_ and arg_56_1.time_ < 0 + var_59_0 and not isNil(arg_56_1.actors_["1084ui_story"]) then
				if arg_56_1.var_.characterEffect1084ui_story and not isNil(arg_56_1.actors_["1084ui_story"]) then
					arg_56_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_56_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_56_1.time_ - 0) / var_59_0)
				end
			end

			if arg_56_1.time_ >= 0 + var_59_0 and arg_56_1.time_ < 0 + var_59_0 + arg_59_0 and not isNil(arg_56_1.actors_["1084ui_story"]) and arg_56_1.var_.characterEffect1084ui_story then
				arg_56_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_56_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_59_1 = arg_56_1.actors_["1084ui_story"].transform

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 then
				arg_56_1.var_.moveOldPos1084ui_story = var_59_1.localPosition
			end

			local var_59_2 = 0.001

			if 0 <= arg_56_1.time_ and arg_56_1.time_ < 0 + var_59_2 then
				var_59_1.localPosition = Vector3.Lerp(arg_56_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_56_1.time_ - 0) / var_59_2)
				var_59_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_59_1.position).x, (manager.ui.mainCamera.transform.position - var_59_1.position).y, (manager.ui.mainCamera.transform.position - var_59_1.position).z)
				var_59_1.localEulerAngles.z = 0
				var_59_1.localEulerAngles.x = 0
				var_59_1.localEulerAngles = var_59_1.localEulerAngles
			end

			if arg_56_1.time_ >= 0 + var_59_2 and arg_56_1.time_ < 0 + var_59_2 + arg_59_0 then
				var_59_1.localPosition = Vector3.New(0, 100, 0)
				var_59_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_59_1.position).x, (manager.ui.mainCamera.transform.position - var_59_1.position).y, (manager.ui.mainCamera.transform.position - var_59_1.position).z)
				var_59_1.localEulerAngles.z = 0
				var_59_1.localEulerAngles.x = 0
				var_59_1.localEulerAngles = var_59_1.localEulerAngles
			end

			local var_59_3 = arg_56_1.actors_["1019ui_story"].transform

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 then
				arg_56_1.var_.moveOldPos1019ui_story = var_59_3.localPosition
			end

			local var_59_4 = 0.001

			if 0 <= arg_56_1.time_ and arg_56_1.time_ < 0 + var_59_4 then
				var_59_3.localPosition = Vector3.Lerp(arg_56_1.var_.moveOldPos1019ui_story, Vector3.New(0, 100, 0), (arg_56_1.time_ - 0) / var_59_4)
				var_59_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_59_3.position).x, (manager.ui.mainCamera.transform.position - var_59_3.position).y, (manager.ui.mainCamera.transform.position - var_59_3.position).z)
				var_59_3.localEulerAngles.z = 0
				var_59_3.localEulerAngles.x = 0
				var_59_3.localEulerAngles = var_59_3.localEulerAngles
			end

			if arg_56_1.time_ >= 0 + var_59_4 and arg_56_1.time_ < 0 + var_59_4 + arg_59_0 then
				var_59_3.localPosition = Vector3.New(0, 100, 0)
				var_59_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_59_3.position).x, (manager.ui.mainCamera.transform.position - var_59_3.position).y, (manager.ui.mainCamera.transform.position - var_59_3.position).z)
				var_59_3.localEulerAngles.z = 0
				var_59_3.localEulerAngles.x = 0
				var_59_3.localEulerAngles = var_59_3.localEulerAngles
			end

			local var_59_5 = 0
			local var_59_6 = 1

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= var_59_5 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, false)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_7 = arg_56_1:FormatText(arg_56_1:GetWordFromCfg(302031014).content)

				arg_56_1.text_.text = var_59_7

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_9 = 40 <= 0 and var_59_6 or var_59_6 * (utf8.len(var_59_7) / 40)

				if (40 <= 0 and var_59_6 or var_59_6 * (utf8.len(var_59_7) / 40)) > 0 and var_59_6 < var_59_9 then
					arg_56_1.talkMaxDuration = var_59_9

					if var_59_9 + var_59_5 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_9 + var_59_5
					end
				end

				arg_56_1.text_.text = var_59_7
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)
				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_10 = math.max(var_59_6, arg_56_1.talkMaxDuration)

			if var_59_5 <= arg_56_1.time_ and arg_56_1.time_ < var_59_5 + var_59_10 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_5) / var_59_10

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_5 + var_59_10 and arg_56_1.time_ < var_59_5 + var_59_10 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {
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
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_56_1:InitPlayNodeList()
	end,
	Play302031015 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 302031015
		arg_60_1.duration_ = 5

		SetActive(arg_60_1.tipsGo_, false)

		function arg_60_1.onSingleLineFinish_()
			arg_60_1.onSingleLineUpdate_ = nil
			arg_60_1.onSingleLineFinish_ = nil
			arg_60_1.state_ = "waiting"
		end

		function arg_60_1.playNext_(arg_62_0)
			if arg_62_0 == 1 then
				arg_60_0:Play302031016(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			local var_63_0 = 1.825

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, false)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_60_1.iconTrs_.gameObject, false)
				arg_60_1.callingController_:SetSelectedState("normal")

				local var_63_1 = arg_60_1:FormatText(arg_60_1:GetWordFromCfg(302031015).content)

				arg_60_1.text_.text = var_63_1

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_3 = 73 <= 0 and var_63_0 or var_63_0 * (utf8.len(var_63_1) / 73)

				if (73 <= 0 and var_63_0 or var_63_0 * (utf8.len(var_63_1) / 73)) > 0 and var_63_0 < var_63_3 then
					arg_60_1.talkMaxDuration = var_63_3

					if var_63_3 + 0 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_3 + 0
					end
				end

				arg_60_1.text_.text = var_63_1
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)
				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_4 = math.max(var_63_0, arg_60_1.talkMaxDuration)

			if 0 <= arg_60_1.time_ and arg_60_1.time_ < 0 + var_63_4 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - 0) / var_63_4

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= 0 + var_63_4 and arg_60_1.time_ < 0 + var_63_4 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {}

		arg_60_1:InitPlayNodeList()
	end,
	Play302031016 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 302031016
		arg_64_1.duration_ = 10.97

		local var_64_0 = {
			zh = 9.233,
			ja = 10.966
		}
		local var_64_1 = manager.audio:GetLocalizationFlag()

		if var_64_0[var_64_1] ~= nil then
			arg_64_1.duration_ = var_64_0[var_64_1]
		end

		SetActive(arg_64_1.tipsGo_, false)

		function arg_64_1.onSingleLineFinish_()
			arg_64_1.onSingleLineUpdate_ = nil
			arg_64_1.onSingleLineFinish_ = nil
			arg_64_1.state_ = "waiting"
		end

		function arg_64_1.playNext_(arg_66_0)
			if arg_66_0 == 1 then
				arg_64_0:Play302031017(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 then
				arg_64_1.var_.moveOldPos1019ui_story = arg_64_1.actors_["1019ui_story"].transform.localPosition
			end

			local var_67_0 = 0.001

			if 0 <= arg_64_1.time_ and arg_64_1.time_ < 0 + var_67_0 then
				arg_64_1.actors_["1019ui_story"].transform.localPosition = Vector3.Lerp(arg_64_1.var_.moveOldPos1019ui_story, Vector3.New(-0.2, -1.08, -5.9), (arg_64_1.time_ - 0) / var_67_0)
				arg_64_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_64_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_64_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_64_1.actors_["1019ui_story"].transform.position).z)
				arg_64_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_64_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_64_1.actors_["1019ui_story"].transform.localEulerAngles = arg_64_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			if arg_64_1.time_ >= 0 + var_67_0 and arg_64_1.time_ < 0 + var_67_0 + arg_67_0 then
				arg_64_1.actors_["1019ui_story"].transform.localPosition = Vector3.New(-0.2, -1.08, -5.9)
				arg_64_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_64_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_64_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_64_1.actors_["1019ui_story"].transform.position).z)
				arg_64_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_64_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_64_1.actors_["1019ui_story"].transform.localEulerAngles = arg_64_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			local var_67_1 = arg_64_1.actors_["1019ui_story"]

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 and not isNil(var_67_1) and arg_64_1.var_.characterEffect1019ui_story == nil then
				arg_64_1.var_.characterEffect1019ui_story = var_67_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_67_2 = 0.200000002980232

			if 0 <= arg_64_1.time_ and arg_64_1.time_ < 0 + var_67_2 and not isNil(var_67_1) then
				if arg_64_1.var_.characterEffect1019ui_story and not isNil(var_67_1) then
					arg_64_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_64_1.time_ >= 0 + var_67_2 and arg_64_1.time_ < 0 + var_67_2 + arg_67_0 and not isNil(var_67_1) and arg_64_1.var_.characterEffect1019ui_story then
				arg_64_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 then
				arg_64_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action1_1")
			end

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 then
				arg_64_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_67_4 = 0
			local var_67_5 = 1.225

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= var_67_4 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, true)

				arg_64_1.leftNameTxt_.text = arg_64_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_64_1.leftNameTxt_.transform)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1.leftNameTxt_.text)
				SetActive(arg_64_1.iconTrs_.gameObject, false)
				arg_64_1.callingController_:SetSelectedState("normal")

				local var_67_6 = arg_64_1:GetWordFromCfg(302031016)
				local var_67_7 = arg_64_1:FormatText(var_67_6.content)

				arg_64_1.text_.text = var_67_7

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_9 = 49 <= 0 and var_67_5 or var_67_5 * (utf8.len(var_67_7) / 49)

				if (49 <= 0 and var_67_5 or var_67_5 * (utf8.len(var_67_7) / 49)) > 0 and var_67_5 < var_67_9 then
					arg_64_1.talkMaxDuration = var_67_9

					if var_67_9 + var_67_4 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_9 + var_67_4
					end
				end

				arg_64_1.text_.text = var_67_7
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302031", "302031016", "story_v_out_302031.awb") ~= 0 then
					local var_67_10 = manager.audio:GetVoiceLength("story_v_out_302031", "302031016", "story_v_out_302031.awb") / 1000

					if var_67_10 + var_67_4 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_10 + var_67_4
					end

					if var_67_6.prefab_name ~= "" and arg_64_1.actors_[var_67_6.prefab_name] ~= nil then
						local var_67_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_64_1.actors_[var_67_6.prefab_name].transform, "story_v_out_302031", "302031016", "story_v_out_302031.awb")

						arg_64_1:RecordAudio("302031016", var_67_11)
						arg_64_1:RecordAudio("302031016", var_67_11)
					else
						arg_64_1:AudioAction("play", "voice", "story_v_out_302031", "302031016", "story_v_out_302031.awb")
					end

					arg_64_1:RecordHistoryTalkVoice("story_v_out_302031", "302031016", "story_v_out_302031.awb")
				end

				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_12 = math.max(var_67_5, arg_64_1.talkMaxDuration)

			if var_67_4 <= arg_64_1.time_ and arg_64_1.time_ < var_67_4 + var_67_12 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_4) / var_67_12

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_4 + var_67_12 and arg_64_1.time_ < var_67_4 + var_67_12 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_64_1:InitPlayNodeList()
	end,
	Play302031017 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 302031017
		arg_68_1.duration_ = 7.3

		local var_68_0 = {
			zh = 5.266,
			ja = 7.3
		}
		local var_68_1 = manager.audio:GetLocalizationFlag()

		if var_68_0[var_68_1] ~= nil then
			arg_68_1.duration_ = var_68_0[var_68_1]
		end

		SetActive(arg_68_1.tipsGo_, false)

		function arg_68_1.onSingleLineFinish_()
			arg_68_1.onSingleLineUpdate_ = nil
			arg_68_1.onSingleLineFinish_ = nil
			arg_68_1.state_ = "waiting"
		end

		function arg_68_1.playNext_(arg_70_0)
			if arg_70_0 == 1 then
				arg_68_0:Play302031018(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 then
				arg_68_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action1_1")
			end

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 then
				arg_68_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_71_0 = 0
			local var_71_1 = 0.7

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= var_71_0 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, true)

				arg_68_1.leftNameTxt_.text = arg_68_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_68_1.leftNameTxt_.transform)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1.leftNameTxt_.text)
				SetActive(arg_68_1.iconTrs_.gameObject, false)
				arg_68_1.callingController_:SetSelectedState("normal")

				local var_71_2 = arg_68_1:GetWordFromCfg(302031017)
				local var_71_3 = arg_68_1:FormatText(var_71_2.content)

				arg_68_1.text_.text = var_71_3

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_5 = 28 <= 0 and var_71_1 or var_71_1 * (utf8.len(var_71_3) / 28)

				if (28 <= 0 and var_71_1 or var_71_1 * (utf8.len(var_71_3) / 28)) > 0 and var_71_1 < var_71_5 then
					arg_68_1.talkMaxDuration = var_71_5

					if var_71_5 + var_71_0 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_5 + var_71_0
					end
				end

				arg_68_1.text_.text = var_71_3
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302031", "302031017", "story_v_out_302031.awb") ~= 0 then
					local var_71_6 = manager.audio:GetVoiceLength("story_v_out_302031", "302031017", "story_v_out_302031.awb") / 1000

					if var_71_6 + var_71_0 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_6 + var_71_0
					end

					if var_71_2.prefab_name ~= "" and arg_68_1.actors_[var_71_2.prefab_name] ~= nil then
						local var_71_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_68_1.actors_[var_71_2.prefab_name].transform, "story_v_out_302031", "302031017", "story_v_out_302031.awb")

						arg_68_1:RecordAudio("302031017", var_71_7)
						arg_68_1:RecordAudio("302031017", var_71_7)
					else
						arg_68_1:AudioAction("play", "voice", "story_v_out_302031", "302031017", "story_v_out_302031.awb")
					end

					arg_68_1:RecordHistoryTalkVoice("story_v_out_302031", "302031017", "story_v_out_302031.awb")
				end

				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_8 = math.max(var_71_1, arg_68_1.talkMaxDuration)

			if var_71_0 <= arg_68_1.time_ and arg_68_1.time_ < var_71_0 + var_71_8 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - var_71_0) / var_71_8

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= var_71_0 + var_71_8 and arg_68_1.time_ < var_71_0 + var_71_8 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {}

		arg_68_1:InitPlayNodeList()
	end,
	Play302031018 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 302031018
		arg_72_1.duration_ = 2.27

		local var_72_0 = {
			zh = 2.266,
			ja = 1.999999999999
		}
		local var_72_1 = manager.audio:GetLocalizationFlag()

		if var_72_0[var_72_1] ~= nil then
			arg_72_1.duration_ = var_72_0[var_72_1]
		end

		SetActive(arg_72_1.tipsGo_, false)

		function arg_72_1.onSingleLineFinish_()
			arg_72_1.onSingleLineUpdate_ = nil
			arg_72_1.onSingleLineFinish_ = nil
			arg_72_1.state_ = "waiting"
		end

		function arg_72_1.playNext_(arg_74_0)
			if arg_74_0 == 1 then
				arg_72_0:Play302031019(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			if arg_72_1.actors_["1080ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1080ui_story"))) then
				local var_75_0 = Object.Instantiate(Asset.Load("Char/" .. "1080ui_story"), arg_72_1.stage_.transform)

				var_75_0.name = "1080ui_story"
				var_75_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_72_1.actors_["1080ui_story"] = var_75_0

				local var_75_1 = var_75_0:GetComponentInChildren(typeof(CharacterEffect))

				var_75_1.enabled = true

				local var_75_2 = GameObjectTools.GetOrAddComponent(var_75_0, typeof(DynamicBoneHelper))

				if var_75_2 then
					var_75_2:EnableDynamicBone(false)
				end

				arg_72_1:ShowWeapon(var_75_1.transform, false)

				arg_72_1.var_["1080ui_story" .. "Animator"] = var_75_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_72_1.var_["1080ui_story" .. "Animator"].applyRootMotion = true
				arg_72_1.var_["1080ui_story" .. "LipSync"] = var_75_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_75_3 = arg_72_1.actors_["1080ui_story"].transform

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 then
				arg_72_1.var_.moveOldPos1080ui_story = var_75_3.localPosition
			end

			local var_75_4 = 0.001

			if 0 <= arg_72_1.time_ and arg_72_1.time_ < 0 + var_75_4 then
				var_75_3.localPosition = Vector3.Lerp(arg_72_1.var_.moveOldPos1080ui_story, Vector3.New(0.7, -1.01, -6.05), (arg_72_1.time_ - 0) / var_75_4)
				var_75_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_75_3.position).x, (manager.ui.mainCamera.transform.position - var_75_3.position).y, (manager.ui.mainCamera.transform.position - var_75_3.position).z)
				var_75_3.localEulerAngles.z = 0
				var_75_3.localEulerAngles.x = 0
				var_75_3.localEulerAngles = var_75_3.localEulerAngles
			end

			if arg_72_1.time_ >= 0 + var_75_4 and arg_72_1.time_ < 0 + var_75_4 + arg_75_0 then
				var_75_3.localPosition = Vector3.New(0.7, -1.01, -6.05)
				var_75_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_75_3.position).x, (manager.ui.mainCamera.transform.position - var_75_3.position).y, (manager.ui.mainCamera.transform.position - var_75_3.position).z)
				var_75_3.localEulerAngles.z = 0
				var_75_3.localEulerAngles.x = 0
				var_75_3.localEulerAngles = var_75_3.localEulerAngles
			end

			local var_75_5 = arg_72_1.actors_["1019ui_story"].transform

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 then
				arg_72_1.var_.moveOldPos1019ui_story = var_75_5.localPosition
			end

			local var_75_6 = 0.001

			if 0 <= arg_72_1.time_ and arg_72_1.time_ < 0 + var_75_6 then
				var_75_5.localPosition = Vector3.Lerp(arg_72_1.var_.moveOldPos1019ui_story, Vector3.New(-0.7, -1.08, -5.9), (arg_72_1.time_ - 0) / var_75_6)
				var_75_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_75_5.position).x, (manager.ui.mainCamera.transform.position - var_75_5.position).y, (manager.ui.mainCamera.transform.position - var_75_5.position).z)
				var_75_5.localEulerAngles.z = 0
				var_75_5.localEulerAngles.x = 0
				var_75_5.localEulerAngles = var_75_5.localEulerAngles
			end

			if arg_72_1.time_ >= 0 + var_75_6 and arg_72_1.time_ < 0 + var_75_6 + arg_75_0 then
				var_75_5.localPosition = Vector3.New(-0.7, -1.08, -5.9)
				var_75_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_75_5.position).x, (manager.ui.mainCamera.transform.position - var_75_5.position).y, (manager.ui.mainCamera.transform.position - var_75_5.position).z)
				var_75_5.localEulerAngles.z = 0
				var_75_5.localEulerAngles.x = 0
				var_75_5.localEulerAngles = var_75_5.localEulerAngles
			end

			local var_75_7 = arg_72_1.actors_["1080ui_story"]

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 and not isNil(var_75_7) and arg_72_1.var_.characterEffect1080ui_story == nil then
				arg_72_1.var_.characterEffect1080ui_story = var_75_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_75_8 = 0.200000002980232

			if 0 <= arg_72_1.time_ and arg_72_1.time_ < 0 + var_75_8 and not isNil(var_75_7) then
				if arg_72_1.var_.characterEffect1080ui_story and not isNil(var_75_7) then
					arg_72_1.var_.characterEffect1080ui_story.fillFlat = false
				end
			end

			if arg_72_1.time_ >= 0 + var_75_8 and arg_72_1.time_ < 0 + var_75_8 + arg_75_0 and not isNil(var_75_7) and arg_72_1.var_.characterEffect1080ui_story then
				arg_72_1.var_.characterEffect1080ui_story.fillFlat = false
			end

			local var_75_10 = arg_72_1.actors_["1019ui_story"]

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 and not isNil(var_75_10) and arg_72_1.var_.characterEffect1019ui_story == nil then
				arg_72_1.var_.characterEffect1019ui_story = var_75_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_75_11 = 0.200000002980232

			if 0 <= arg_72_1.time_ and arg_72_1.time_ < 0 + var_75_11 and not isNil(var_75_10) then
				if arg_72_1.var_.characterEffect1019ui_story and not isNil(var_75_10) then
					arg_72_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_72_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_72_1.time_ - 0) / var_75_11)
				end
			end

			if arg_72_1.time_ >= 0 + var_75_11 and arg_72_1.time_ < 0 + var_75_11 + arg_75_0 and not isNil(var_75_10) and arg_72_1.var_.characterEffect1019ui_story then
				arg_72_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_72_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 then
				arg_72_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/story1080/story1080action/1080action6_1")
			end

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 then
				arg_72_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_75_12 = 0
			local var_75_13 = 0.225

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= var_75_12 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, true)

				arg_72_1.leftNameTxt_.text = arg_72_1:FormatText(StoryNameCfg[55].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_72_1.leftNameTxt_.transform)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1.leftNameTxt_.text)
				SetActive(arg_72_1.iconTrs_.gameObject, false)
				arg_72_1.callingController_:SetSelectedState("normal")

				local var_75_14 = arg_72_1:GetWordFromCfg(302031018)
				local var_75_15 = arg_72_1:FormatText(var_75_14.content)

				arg_72_1.text_.text = var_75_15

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_17 = 9 <= 0 and var_75_13 or var_75_13 * (utf8.len(var_75_15) / 9)

				if (9 <= 0 and var_75_13 or var_75_13 * (utf8.len(var_75_15) / 9)) > 0 and var_75_13 < var_75_17 then
					arg_72_1.talkMaxDuration = var_75_17

					if var_75_17 + var_75_12 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_17 + var_75_12
					end
				end

				arg_72_1.text_.text = var_75_15
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302031", "302031018", "story_v_out_302031.awb") ~= 0 then
					local var_75_18 = manager.audio:GetVoiceLength("story_v_out_302031", "302031018", "story_v_out_302031.awb") / 1000

					if var_75_18 + var_75_12 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_18 + var_75_12
					end

					if var_75_14.prefab_name ~= "" and arg_72_1.actors_[var_75_14.prefab_name] ~= nil then
						local var_75_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_72_1.actors_[var_75_14.prefab_name].transform, "story_v_out_302031", "302031018", "story_v_out_302031.awb")

						arg_72_1:RecordAudio("302031018", var_75_19)
						arg_72_1:RecordAudio("302031018", var_75_19)
					else
						arg_72_1:AudioAction("play", "voice", "story_v_out_302031", "302031018", "story_v_out_302031.awb")
					end

					arg_72_1:RecordHistoryTalkVoice("story_v_out_302031", "302031018", "story_v_out_302031.awb")
				end

				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_20 = math.max(var_75_13, arg_72_1.talkMaxDuration)

			if var_75_12 <= arg_72_1.time_ and arg_72_1.time_ < var_75_12 + var_75_20 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_12) / var_75_20

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_12 + var_75_20 and arg_72_1.time_ < var_75_12 + var_75_20 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1080ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_72_1:InitPlayNodeList()
	end,
	Play302031019 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 302031019
		arg_76_1.duration_ = 5

		SetActive(arg_76_1.tipsGo_, false)

		function arg_76_1.onSingleLineFinish_()
			arg_76_1.onSingleLineUpdate_ = nil
			arg_76_1.onSingleLineFinish_ = nil
			arg_76_1.state_ = "waiting"
		end

		function arg_76_1.playNext_(arg_78_0)
			if arg_78_0 == 1 then
				arg_76_0:Play302031020(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 and not isNil(arg_76_1.actors_["1080ui_story"]) and arg_76_1.var_.characterEffect1080ui_story == nil then
				arg_76_1.var_.characterEffect1080ui_story = arg_76_1.actors_["1080ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_79_0 = 0.200000002980232

			if 0 <= arg_76_1.time_ and arg_76_1.time_ < 0 + var_79_0 and not isNil(arg_76_1.actors_["1080ui_story"]) then
				if arg_76_1.var_.characterEffect1080ui_story and not isNil(arg_76_1.actors_["1080ui_story"]) then
					arg_76_1.var_.characterEffect1080ui_story.fillFlat = true
					arg_76_1.var_.characterEffect1080ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_76_1.time_ - 0) / var_79_0)
				end
			end

			if arg_76_1.time_ >= 0 + var_79_0 and arg_76_1.time_ < 0 + var_79_0 + arg_79_0 and not isNil(arg_76_1.actors_["1080ui_story"]) and arg_76_1.var_.characterEffect1080ui_story then
				arg_76_1.var_.characterEffect1080ui_story.fillFlat = true
				arg_76_1.var_.characterEffect1080ui_story.fillRatio = 0.5
			end

			local var_79_1 = 0
			local var_79_2 = 0.2

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= var_79_1 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, true)

				arg_76_1.leftNameTxt_.text = arg_76_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_76_1.leftNameTxt_.transform)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1.leftNameTxt_.text)
				SetActive(arg_76_1.iconTrs_.gameObject, true)
				arg_76_1.iconController_:SetSelectedState("hero")

				arg_76_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_76_1.callingController_:SetSelectedState("normal")

				arg_76_1.keyicon_.color = Color.New(1, 1, 1)
				arg_76_1.icon_.color = Color.New(1, 1, 1)

				local var_79_3 = arg_76_1:FormatText(arg_76_1:GetWordFromCfg(302031019).content)

				arg_76_1.text_.text = var_79_3

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_5 = 8 <= 0 and var_79_2 or var_79_2 * (utf8.len(var_79_3) / 8)

				if (8 <= 0 and var_79_2 or var_79_2 * (utf8.len(var_79_3) / 8)) > 0 and var_79_2 < var_79_5 then
					arg_76_1.talkMaxDuration = var_79_5

					if var_79_5 + var_79_1 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_5 + var_79_1
					end
				end

				arg_76_1.text_.text = var_79_3
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)
				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_6 = math.max(var_79_2, arg_76_1.talkMaxDuration)

			if var_79_1 <= arg_76_1.time_ and arg_76_1.time_ < var_79_1 + var_79_6 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_1) / var_79_6

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_1 + var_79_6 and arg_76_1.time_ < var_79_1 + var_79_6 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {}

		arg_76_1:InitPlayNodeList()
	end,
	Play302031020 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 302031020
		arg_80_1.duration_ = 5

		SetActive(arg_80_1.tipsGo_, false)

		function arg_80_1.onSingleLineFinish_()
			arg_80_1.onSingleLineUpdate_ = nil
			arg_80_1.onSingleLineFinish_ = nil
			arg_80_1.state_ = "waiting"
		end

		function arg_80_1.playNext_(arg_82_0)
			if arg_82_0 == 1 then
				arg_80_0:Play302031021(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 then
				arg_80_1.var_.moveOldPos1080ui_story = arg_80_1.actors_["1080ui_story"].transform.localPosition
			end

			local var_83_0 = 0.001

			if 0 <= arg_80_1.time_ and arg_80_1.time_ < 0 + var_83_0 then
				arg_80_1.actors_["1080ui_story"].transform.localPosition = Vector3.Lerp(arg_80_1.var_.moveOldPos1080ui_story, Vector3.New(0, 100, 0), (arg_80_1.time_ - 0) / var_83_0)
				arg_80_1.actors_["1080ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_80_1.actors_["1080ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_80_1.actors_["1080ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_80_1.actors_["1080ui_story"].transform.position).z)
				arg_80_1.actors_["1080ui_story"].transform.localEulerAngles.z = 0
				arg_80_1.actors_["1080ui_story"].transform.localEulerAngles.x = 0
				arg_80_1.actors_["1080ui_story"].transform.localEulerAngles = arg_80_1.actors_["1080ui_story"].transform.localEulerAngles
			end

			if arg_80_1.time_ >= 0 + var_83_0 and arg_80_1.time_ < 0 + var_83_0 + arg_83_0 then
				arg_80_1.actors_["1080ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_80_1.actors_["1080ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_80_1.actors_["1080ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_80_1.actors_["1080ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_80_1.actors_["1080ui_story"].transform.position).z)
				arg_80_1.actors_["1080ui_story"].transform.localEulerAngles.z = 0
				arg_80_1.actors_["1080ui_story"].transform.localEulerAngles.x = 0
				arg_80_1.actors_["1080ui_story"].transform.localEulerAngles = arg_80_1.actors_["1080ui_story"].transform.localEulerAngles
			end

			local var_83_1 = arg_80_1.actors_["1019ui_story"].transform

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 then
				arg_80_1.var_.moveOldPos1019ui_story = var_83_1.localPosition
			end

			local var_83_2 = 0.001

			if 0 <= arg_80_1.time_ and arg_80_1.time_ < 0 + var_83_2 then
				var_83_1.localPosition = Vector3.Lerp(arg_80_1.var_.moveOldPos1019ui_story, Vector3.New(0, 100, 0), (arg_80_1.time_ - 0) / var_83_2)
				var_83_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_83_1.position).x, (manager.ui.mainCamera.transform.position - var_83_1.position).y, (manager.ui.mainCamera.transform.position - var_83_1.position).z)
				var_83_1.localEulerAngles.z = 0
				var_83_1.localEulerAngles.x = 0
				var_83_1.localEulerAngles = var_83_1.localEulerAngles
			end

			if arg_80_1.time_ >= 0 + var_83_2 and arg_80_1.time_ < 0 + var_83_2 + arg_83_0 then
				var_83_1.localPosition = Vector3.New(0, 100, 0)
				var_83_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_83_1.position).x, (manager.ui.mainCamera.transform.position - var_83_1.position).y, (manager.ui.mainCamera.transform.position - var_83_1.position).z)
				var_83_1.localEulerAngles.z = 0
				var_83_1.localEulerAngles.x = 0
				var_83_1.localEulerAngles = var_83_1.localEulerAngles
			end

			local var_83_3 = 0
			local var_83_4 = 1.55

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= var_83_3 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, false)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_80_1.iconTrs_.gameObject, false)
				arg_80_1.callingController_:SetSelectedState("normal")

				local var_83_5 = arg_80_1:FormatText(arg_80_1:GetWordFromCfg(302031020).content)

				arg_80_1.text_.text = var_83_5

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_7 = 62 <= 0 and var_83_4 or var_83_4 * (utf8.len(var_83_5) / 62)

				if (62 <= 0 and var_83_4 or var_83_4 * (utf8.len(var_83_5) / 62)) > 0 and var_83_4 < var_83_7 then
					arg_80_1.talkMaxDuration = var_83_7

					if var_83_7 + var_83_3 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_7 + var_83_3
					end
				end

				arg_80_1.text_.text = var_83_5
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)
				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_8 = math.max(var_83_4, arg_80_1.talkMaxDuration)

			if var_83_3 <= arg_80_1.time_ and arg_80_1.time_ < var_83_3 + var_83_8 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - var_83_3) / var_83_8

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= var_83_3 + var_83_8 and arg_80_1.time_ < var_83_3 + var_83_8 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1080ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_80_1:InitPlayNodeList()
	end,
	Play302031021 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 302031021
		arg_84_1.duration_ = 5

		SetActive(arg_84_1.tipsGo_, false)

		function arg_84_1.onSingleLineFinish_()
			arg_84_1.onSingleLineUpdate_ = nil
			arg_84_1.onSingleLineFinish_ = nil
			arg_84_1.state_ = "waiting"
		end

		function arg_84_1.playNext_(arg_86_0)
			if arg_86_0 == 1 then
				arg_84_0:Play302031022(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			local var_87_0 = 0.325

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, true)

				arg_84_1.leftNameTxt_.text = arg_84_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_84_1.leftNameTxt_.transform)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1.leftNameTxt_.text)
				SetActive(arg_84_1.iconTrs_.gameObject, true)
				arg_84_1.iconController_:SetSelectedState("hero")

				arg_84_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_84_1.callingController_:SetSelectedState("normal")

				arg_84_1.keyicon_.color = Color.New(1, 1, 1)
				arg_84_1.icon_.color = Color.New(1, 1, 1)

				local var_87_1 = arg_84_1:FormatText(arg_84_1:GetWordFromCfg(302031021).content)

				arg_84_1.text_.text = var_87_1

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_3 = 13 <= 0 and var_87_0 or var_87_0 * (utf8.len(var_87_1) / 13)

				if (13 <= 0 and var_87_0 or var_87_0 * (utf8.len(var_87_1) / 13)) > 0 and var_87_0 < var_87_3 then
					arg_84_1.talkMaxDuration = var_87_3

					if var_87_3 + 0 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_3 + 0
					end
				end

				arg_84_1.text_.text = var_87_1
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)
				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_4 = math.max(var_87_0, arg_84_1.talkMaxDuration)

			if 0 <= arg_84_1.time_ and arg_84_1.time_ < 0 + var_87_4 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - 0) / var_87_4

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= 0 + var_87_4 and arg_84_1.time_ < 0 + var_87_4 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {}

		arg_84_1:InitPlayNodeList()
	end,
	Play302031022 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 302031022
		arg_88_1.duration_ = 8.97

		local var_88_0 = {
			zh = 6.1,
			ja = 8.966
		}
		local var_88_1 = manager.audio:GetLocalizationFlag()

		if var_88_0[var_88_1] ~= nil then
			arg_88_1.duration_ = var_88_0[var_88_1]
		end

		SetActive(arg_88_1.tipsGo_, false)

		function arg_88_1.onSingleLineFinish_()
			arg_88_1.onSingleLineUpdate_ = nil
			arg_88_1.onSingleLineFinish_ = nil
			arg_88_1.state_ = "waiting"
		end

		function arg_88_1.playNext_(arg_90_0)
			if arg_90_0 == 1 then
				arg_88_0:Play302031023(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			if arg_88_1.actors_["1027ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1027ui_story"))) then
				local var_91_0 = Object.Instantiate(Asset.Load("Char/" .. "1027ui_story"), arg_88_1.stage_.transform)

				var_91_0.name = "1027ui_story"
				var_91_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_88_1.actors_["1027ui_story"] = var_91_0

				local var_91_1 = var_91_0:GetComponentInChildren(typeof(CharacterEffect))

				var_91_1.enabled = true

				local var_91_2 = GameObjectTools.GetOrAddComponent(var_91_0, typeof(DynamicBoneHelper))

				if var_91_2 then
					var_91_2:EnableDynamicBone(false)
				end

				arg_88_1:ShowWeapon(var_91_1.transform, false)

				arg_88_1.var_["1027ui_story" .. "Animator"] = var_91_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_88_1.var_["1027ui_story" .. "Animator"].applyRootMotion = true
				arg_88_1.var_["1027ui_story" .. "LipSync"] = var_91_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_91_3 = arg_88_1.actors_["1027ui_story"].transform

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 then
				arg_88_1.var_.moveOldPos1027ui_story = var_91_3.localPosition
			end

			local var_91_4 = 0.001

			if 0 <= arg_88_1.time_ and arg_88_1.time_ < 0 + var_91_4 then
				var_91_3.localPosition = Vector3.Lerp(arg_88_1.var_.moveOldPos1027ui_story, Vector3.New(-0.7, -0.81, -5.8), (arg_88_1.time_ - 0) / var_91_4)
				var_91_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_91_3.position).x, (manager.ui.mainCamera.transform.position - var_91_3.position).y, (manager.ui.mainCamera.transform.position - var_91_3.position).z)
				var_91_3.localEulerAngles.z = 0
				var_91_3.localEulerAngles.x = 0
				var_91_3.localEulerAngles = var_91_3.localEulerAngles
			end

			if arg_88_1.time_ >= 0 + var_91_4 and arg_88_1.time_ < 0 + var_91_4 + arg_91_0 then
				var_91_3.localPosition = Vector3.New(-0.7, -0.81, -5.8)
				var_91_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_91_3.position).x, (manager.ui.mainCamera.transform.position - var_91_3.position).y, (manager.ui.mainCamera.transform.position - var_91_3.position).z)
				var_91_3.localEulerAngles.z = 0
				var_91_3.localEulerAngles.x = 0
				var_91_3.localEulerAngles = var_91_3.localEulerAngles
			end

			local var_91_5 = arg_88_1.actors_["1027ui_story"]

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 and not isNil(var_91_5) and arg_88_1.var_.characterEffect1027ui_story == nil then
				arg_88_1.var_.characterEffect1027ui_story = var_91_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_91_6 = 0.200000002980232

			if 0 <= arg_88_1.time_ and arg_88_1.time_ < 0 + var_91_6 and not isNil(var_91_5) then
				if arg_88_1.var_.characterEffect1027ui_story and not isNil(var_91_5) then
					arg_88_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_88_1.time_ >= 0 + var_91_6 and arg_88_1.time_ < 0 + var_91_6 + arg_91_0 and not isNil(var_91_5) and arg_88_1.var_.characterEffect1027ui_story then
				arg_88_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 then
				arg_88_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action4_1")
			end

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 then
				arg_88_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_91_8 = 0
			local var_91_9 = 0.7

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= var_91_8 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, true)

				arg_88_1.leftNameTxt_.text = arg_88_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_88_1.leftNameTxt_.transform)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1.leftNameTxt_.text)
				SetActive(arg_88_1.iconTrs_.gameObject, false)
				arg_88_1.callingController_:SetSelectedState("normal")

				local var_91_10 = arg_88_1:GetWordFromCfg(302031022)
				local var_91_11 = arg_88_1:FormatText(var_91_10.content)

				arg_88_1.text_.text = var_91_11

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_13 = 28 <= 0 and var_91_9 or var_91_9 * (utf8.len(var_91_11) / 28)

				if (28 <= 0 and var_91_9 or var_91_9 * (utf8.len(var_91_11) / 28)) > 0 and var_91_9 < var_91_13 then
					arg_88_1.talkMaxDuration = var_91_13

					if var_91_13 + var_91_8 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_13 + var_91_8
					end
				end

				arg_88_1.text_.text = var_91_11
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302031", "302031022", "story_v_out_302031.awb") ~= 0 then
					local var_91_14 = manager.audio:GetVoiceLength("story_v_out_302031", "302031022", "story_v_out_302031.awb") / 1000

					if var_91_14 + var_91_8 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_14 + var_91_8
					end

					if var_91_10.prefab_name ~= "" and arg_88_1.actors_[var_91_10.prefab_name] ~= nil then
						local var_91_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_88_1.actors_[var_91_10.prefab_name].transform, "story_v_out_302031", "302031022", "story_v_out_302031.awb")

						arg_88_1:RecordAudio("302031022", var_91_15)
						arg_88_1:RecordAudio("302031022", var_91_15)
					else
						arg_88_1:AudioAction("play", "voice", "story_v_out_302031", "302031022", "story_v_out_302031.awb")
					end

					arg_88_1:RecordHistoryTalkVoice("story_v_out_302031", "302031022", "story_v_out_302031.awb")
				end

				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_16 = math.max(var_91_9, arg_88_1.talkMaxDuration)

			if var_91_8 <= arg_88_1.time_ and arg_88_1.time_ < var_91_8 + var_91_16 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - var_91_8) / var_91_16

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= var_91_8 + var_91_16 and arg_88_1.time_ < var_91_8 + var_91_16 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_88_1:InitPlayNodeList()
	end,
	Play302031023 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 302031023
		arg_92_1.duration_ = 8

		local var_92_0 = {
			zh = 7.1,
			ja = 8
		}
		local var_92_1 = manager.audio:GetLocalizationFlag()

		if var_92_0[var_92_1] ~= nil then
			arg_92_1.duration_ = var_92_0[var_92_1]
		end

		SetActive(arg_92_1.tipsGo_, false)

		function arg_92_1.onSingleLineFinish_()
			arg_92_1.onSingleLineUpdate_ = nil
			arg_92_1.onSingleLineFinish_ = nil
			arg_92_1.state_ = "waiting"
		end

		function arg_92_1.playNext_(arg_94_0)
			if arg_94_0 == 1 then
				arg_92_0:Play302031024(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 then
				arg_92_1.var_.moveOldPos1084ui_story = arg_92_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_95_0 = 0.001

			if 0 <= arg_92_1.time_ and arg_92_1.time_ < 0 + var_95_0 then
				arg_92_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_92_1.var_.moveOldPos1084ui_story, Vector3.New(0.7, -0.97, -6), (arg_92_1.time_ - 0) / var_95_0)
				arg_92_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_92_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_92_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_92_1.actors_["1084ui_story"].transform.position).z)
				arg_92_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_92_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_92_1.actors_["1084ui_story"].transform.localEulerAngles = arg_92_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_92_1.time_ >= 0 + var_95_0 and arg_92_1.time_ < 0 + var_95_0 + arg_95_0 then
				arg_92_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0.7, -0.97, -6)
				arg_92_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_92_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_92_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_92_1.actors_["1084ui_story"].transform.position).z)
				arg_92_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_92_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_92_1.actors_["1084ui_story"].transform.localEulerAngles = arg_92_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_95_1 = arg_92_1.actors_["1084ui_story"]

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 and not isNil(var_95_1) and arg_92_1.var_.characterEffect1084ui_story == nil then
				arg_92_1.var_.characterEffect1084ui_story = var_95_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_95_2 = 0.200000002980232

			if 0 <= arg_92_1.time_ and arg_92_1.time_ < 0 + var_95_2 and not isNil(var_95_1) then
				if arg_92_1.var_.characterEffect1084ui_story and not isNil(var_95_1) then
					arg_92_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_92_1.time_ >= 0 + var_95_2 and arg_92_1.time_ < 0 + var_95_2 + arg_95_0 and not isNil(var_95_1) and arg_92_1.var_.characterEffect1084ui_story then
				arg_92_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_95_4 = arg_92_1.actors_["1027ui_story"]

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 and not isNil(var_95_4) and arg_92_1.var_.characterEffect1027ui_story == nil then
				arg_92_1.var_.characterEffect1027ui_story = var_95_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_95_5 = 0.200000002980232

			if 0 <= arg_92_1.time_ and arg_92_1.time_ < 0 + var_95_5 and not isNil(var_95_4) then
				if arg_92_1.var_.characterEffect1027ui_story and not isNil(var_95_4) then
					arg_92_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_92_1.var_.characterEffect1027ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_92_1.time_ - 0) / var_95_5)
				end
			end

			if arg_92_1.time_ >= 0 + var_95_5 and arg_92_1.time_ < 0 + var_95_5 + arg_95_0 and not isNil(var_95_4) and arg_92_1.var_.characterEffect1027ui_story then
				arg_92_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_92_1.var_.characterEffect1027ui_story.fillRatio = 0.5
			end

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 then
				arg_92_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 then
				arg_92_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_95_6 = 0
			local var_95_7 = 0.925

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= var_95_6 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, true)

				arg_92_1.leftNameTxt_.text = arg_92_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_92_1.leftNameTxt_.transform)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1.leftNameTxt_.text)
				SetActive(arg_92_1.iconTrs_.gameObject, false)
				arg_92_1.callingController_:SetSelectedState("normal")

				local var_95_8 = arg_92_1:GetWordFromCfg(302031023)
				local var_95_9 = arg_92_1:FormatText(var_95_8.content)

				arg_92_1.text_.text = var_95_9

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_11 = 37 <= 0 and var_95_7 or var_95_7 * (utf8.len(var_95_9) / 37)

				if (37 <= 0 and var_95_7 or var_95_7 * (utf8.len(var_95_9) / 37)) > 0 and var_95_7 < var_95_11 then
					arg_92_1.talkMaxDuration = var_95_11

					if var_95_11 + var_95_6 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_11 + var_95_6
					end
				end

				arg_92_1.text_.text = var_95_9
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302031", "302031023", "story_v_out_302031.awb") ~= 0 then
					local var_95_12 = manager.audio:GetVoiceLength("story_v_out_302031", "302031023", "story_v_out_302031.awb") / 1000

					if var_95_12 + var_95_6 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_12 + var_95_6
					end

					if var_95_8.prefab_name ~= "" and arg_92_1.actors_[var_95_8.prefab_name] ~= nil then
						local var_95_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_92_1.actors_[var_95_8.prefab_name].transform, "story_v_out_302031", "302031023", "story_v_out_302031.awb")

						arg_92_1:RecordAudio("302031023", var_95_13)
						arg_92_1:RecordAudio("302031023", var_95_13)
					else
						arg_92_1:AudioAction("play", "voice", "story_v_out_302031", "302031023", "story_v_out_302031.awb")
					end

					arg_92_1:RecordHistoryTalkVoice("story_v_out_302031", "302031023", "story_v_out_302031.awb")
				end

				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_14 = math.max(var_95_7, arg_92_1.talkMaxDuration)

			if var_95_6 <= arg_92_1.time_ and arg_92_1.time_ < var_95_6 + var_95_14 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - var_95_6) / var_95_14

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= var_95_6 + var_95_14 and arg_92_1.time_ < var_95_6 + var_95_14 + arg_95_0 then
				arg_92_1.typewritter.percent = 1

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(true)
			end
		end

		arg_92_1.nodeConfigList_ = {
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

		arg_92_1:InitPlayNodeList()
	end,
	Play302031024 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 302031024
		arg_96_1.duration_ = 5

		SetActive(arg_96_1.tipsGo_, false)

		function arg_96_1.onSingleLineFinish_()
			arg_96_1.onSingleLineUpdate_ = nil
			arg_96_1.onSingleLineFinish_ = nil
			arg_96_1.state_ = "waiting"
		end

		function arg_96_1.playNext_(arg_98_0)
			if arg_98_0 == 1 then
				arg_96_0:Play302031025(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 and not isNil(arg_96_1.actors_["1084ui_story"]) and arg_96_1.var_.characterEffect1084ui_story == nil then
				arg_96_1.var_.characterEffect1084ui_story = arg_96_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_99_0 = 0.200000002980232

			if 0 <= arg_96_1.time_ and arg_96_1.time_ < 0 + var_99_0 and not isNil(arg_96_1.actors_["1084ui_story"]) then
				if arg_96_1.var_.characterEffect1084ui_story and not isNil(arg_96_1.actors_["1084ui_story"]) then
					arg_96_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_96_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_96_1.time_ - 0) / var_99_0)
				end
			end

			if arg_96_1.time_ >= 0 + var_99_0 and arg_96_1.time_ < 0 + var_99_0 + arg_99_0 and not isNil(arg_96_1.actors_["1084ui_story"]) and arg_96_1.var_.characterEffect1084ui_story then
				arg_96_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_96_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 then
				arg_96_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action4_2")
			end

			local var_99_1 = 0
			local var_99_2 = 0.325

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= var_99_1 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, true)

				arg_96_1.leftNameTxt_.text = arg_96_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_96_1.leftNameTxt_.transform)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1.leftNameTxt_.text)
				SetActive(arg_96_1.iconTrs_.gameObject, true)
				arg_96_1.iconController_:SetSelectedState("hero")

				arg_96_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_96_1.callingController_:SetSelectedState("normal")

				arg_96_1.keyicon_.color = Color.New(1, 1, 1)
				arg_96_1.icon_.color = Color.New(1, 1, 1)

				local var_99_3 = arg_96_1:FormatText(arg_96_1:GetWordFromCfg(302031024).content)

				arg_96_1.text_.text = var_99_3

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_5 = 13 <= 0 and var_99_2 or var_99_2 * (utf8.len(var_99_3) / 13)

				if (13 <= 0 and var_99_2 or var_99_2 * (utf8.len(var_99_3) / 13)) > 0 and var_99_2 < var_99_5 then
					arg_96_1.talkMaxDuration = var_99_5

					if var_99_5 + var_99_1 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_5 + var_99_1
					end
				end

				arg_96_1.text_.text = var_99_3
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)
				arg_96_1:RecordContent(arg_96_1.text_.text)
			end

			local var_99_6 = math.max(var_99_2, arg_96_1.talkMaxDuration)

			if var_99_1 <= arg_96_1.time_ and arg_96_1.time_ < var_99_1 + var_99_6 then
				arg_96_1.typewritter.percent = (arg_96_1.time_ - var_99_1) / var_99_6

				arg_96_1.typewritter:SetDirty()
			end

			if arg_96_1.time_ >= var_99_1 + var_99_6 and arg_96_1.time_ < var_99_1 + var_99_6 + arg_99_0 then
				arg_96_1.typewritter.percent = 1

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(true)
			end
		end

		arg_96_1.nodeConfigList_ = {}

		arg_96_1:InitPlayNodeList()
	end,
	Play302031025 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 302031025
		arg_100_1.duration_ = 6.77

		local var_100_0 = {
			zh = 5.033,
			ja = 6.766
		}
		local var_100_1 = manager.audio:GetLocalizationFlag()

		if var_100_0[var_100_1] ~= nil then
			arg_100_1.duration_ = var_100_0[var_100_1]
		end

		SetActive(arg_100_1.tipsGo_, false)

		function arg_100_1.onSingleLineFinish_()
			arg_100_1.onSingleLineUpdate_ = nil
			arg_100_1.onSingleLineFinish_ = nil
			arg_100_1.state_ = "waiting"
		end

		function arg_100_1.playNext_(arg_102_0)
			if arg_102_0 == 1 then
				arg_100_0:Play302031026(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 and not isNil(arg_100_1.actors_["1084ui_story"]) and arg_100_1.var_.characterEffect1084ui_story == nil then
				arg_100_1.var_.characterEffect1084ui_story = arg_100_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_103_0 = 0.200000002980232

			if 0 <= arg_100_1.time_ and arg_100_1.time_ < 0 + var_103_0 and not isNil(arg_100_1.actors_["1084ui_story"]) then
				if arg_100_1.var_.characterEffect1084ui_story and not isNil(arg_100_1.actors_["1084ui_story"]) then
					arg_100_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_100_1.time_ >= 0 + var_103_0 and arg_100_1.time_ < 0 + var_103_0 + arg_103_0 and not isNil(arg_100_1.actors_["1084ui_story"]) and arg_100_1.var_.characterEffect1084ui_story then
				arg_100_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 then
				arg_100_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_1")
			end

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 then
				arg_100_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_103_2 = 0
			local var_103_3 = 0.525

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= var_103_2 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, true)

				arg_100_1.leftNameTxt_.text = arg_100_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_100_1.leftNameTxt_.transform)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1.leftNameTxt_.text)
				SetActive(arg_100_1.iconTrs_.gameObject, false)
				arg_100_1.callingController_:SetSelectedState("normal")

				local var_103_4 = arg_100_1:GetWordFromCfg(302031025)
				local var_103_5 = arg_100_1:FormatText(var_103_4.content)

				arg_100_1.text_.text = var_103_5

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_7 = 21 <= 0 and var_103_3 or var_103_3 * (utf8.len(var_103_5) / 21)

				if (21 <= 0 and var_103_3 or var_103_3 * (utf8.len(var_103_5) / 21)) > 0 and var_103_3 < var_103_7 then
					arg_100_1.talkMaxDuration = var_103_7

					if var_103_7 + var_103_2 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_7 + var_103_2
					end
				end

				arg_100_1.text_.text = var_103_5
				arg_100_1.typewritter.percent = 0

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302031", "302031025", "story_v_out_302031.awb") ~= 0 then
					local var_103_8 = manager.audio:GetVoiceLength("story_v_out_302031", "302031025", "story_v_out_302031.awb") / 1000

					if var_103_8 + var_103_2 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_8 + var_103_2
					end

					if var_103_4.prefab_name ~= "" and arg_100_1.actors_[var_103_4.prefab_name] ~= nil then
						local var_103_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_100_1.actors_[var_103_4.prefab_name].transform, "story_v_out_302031", "302031025", "story_v_out_302031.awb")

						arg_100_1:RecordAudio("302031025", var_103_9)
						arg_100_1:RecordAudio("302031025", var_103_9)
					else
						arg_100_1:AudioAction("play", "voice", "story_v_out_302031", "302031025", "story_v_out_302031.awb")
					end

					arg_100_1:RecordHistoryTalkVoice("story_v_out_302031", "302031025", "story_v_out_302031.awb")
				end

				arg_100_1:RecordContent(arg_100_1.text_.text)
			end

			local var_103_10 = math.max(var_103_3, arg_100_1.talkMaxDuration)

			if var_103_2 <= arg_100_1.time_ and arg_100_1.time_ < var_103_2 + var_103_10 then
				arg_100_1.typewritter.percent = (arg_100_1.time_ - var_103_2) / var_103_10

				arg_100_1.typewritter:SetDirty()
			end

			if arg_100_1.time_ >= var_103_2 + var_103_10 and arg_100_1.time_ < var_103_2 + var_103_10 + arg_103_0 then
				arg_100_1.typewritter.percent = 1

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(true)
			end
		end

		arg_100_1.nodeConfigList_ = {}

		arg_100_1:InitPlayNodeList()
	end,
	Play302031026 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 302031026
		arg_104_1.duration_ = 9.8

		local var_104_0 = {
			zh = 5.033,
			ja = 9.8
		}
		local var_104_1 = manager.audio:GetLocalizationFlag()

		if var_104_0[var_104_1] ~= nil then
			arg_104_1.duration_ = var_104_0[var_104_1]
		end

		SetActive(arg_104_1.tipsGo_, false)

		function arg_104_1.onSingleLineFinish_()
			arg_104_1.onSingleLineUpdate_ = nil
			arg_104_1.onSingleLineFinish_ = nil
			arg_104_1.state_ = "waiting"
		end

		function arg_104_1.playNext_(arg_106_0)
			if arg_106_0 == 1 then
				arg_104_0:Play302031027(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 then
				arg_104_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_2")
			end

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 then
				arg_104_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_107_0 = 0
			local var_107_1 = 0.55

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= var_107_0 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, true)

				arg_104_1.leftNameTxt_.text = arg_104_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_104_1.leftNameTxt_.transform)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1.leftNameTxt_.text)
				SetActive(arg_104_1.iconTrs_.gameObject, false)
				arg_104_1.callingController_:SetSelectedState("normal")

				local var_107_2 = arg_104_1:GetWordFromCfg(302031026)
				local var_107_3 = arg_104_1:FormatText(var_107_2.content)

				arg_104_1.text_.text = var_107_3

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_5 = 22 <= 0 and var_107_1 or var_107_1 * (utf8.len(var_107_3) / 22)

				if (22 <= 0 and var_107_1 or var_107_1 * (utf8.len(var_107_3) / 22)) > 0 and var_107_1 < var_107_5 then
					arg_104_1.talkMaxDuration = var_107_5

					if var_107_5 + var_107_0 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_5 + var_107_0
					end
				end

				arg_104_1.text_.text = var_107_3
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302031", "302031026", "story_v_out_302031.awb") ~= 0 then
					local var_107_6 = manager.audio:GetVoiceLength("story_v_out_302031", "302031026", "story_v_out_302031.awb") / 1000

					if var_107_6 + var_107_0 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_6 + var_107_0
					end

					if var_107_2.prefab_name ~= "" and arg_104_1.actors_[var_107_2.prefab_name] ~= nil then
						local var_107_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_104_1.actors_[var_107_2.prefab_name].transform, "story_v_out_302031", "302031026", "story_v_out_302031.awb")

						arg_104_1:RecordAudio("302031026", var_107_7)
						arg_104_1:RecordAudio("302031026", var_107_7)
					else
						arg_104_1:AudioAction("play", "voice", "story_v_out_302031", "302031026", "story_v_out_302031.awb")
					end

					arg_104_1:RecordHistoryTalkVoice("story_v_out_302031", "302031026", "story_v_out_302031.awb")
				end

				arg_104_1:RecordContent(arg_104_1.text_.text)
			end

			local var_107_8 = math.max(var_107_1, arg_104_1.talkMaxDuration)

			if var_107_0 <= arg_104_1.time_ and arg_104_1.time_ < var_107_0 + var_107_8 then
				arg_104_1.typewritter.percent = (arg_104_1.time_ - var_107_0) / var_107_8

				arg_104_1.typewritter:SetDirty()
			end

			if arg_104_1.time_ >= var_107_0 + var_107_8 and arg_104_1.time_ < var_107_0 + var_107_8 + arg_107_0 then
				arg_104_1.typewritter.percent = 1

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(true)
			end
		end

		arg_104_1.nodeConfigList_ = {}

		arg_104_1:InitPlayNodeList()
	end,
	Play302031027 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 302031027
		arg_108_1.duration_ = 5

		SetActive(arg_108_1.tipsGo_, false)

		function arg_108_1.onSingleLineFinish_()
			arg_108_1.onSingleLineUpdate_ = nil
			arg_108_1.onSingleLineFinish_ = nil
			arg_108_1.state_ = "waiting"
		end

		function arg_108_1.playNext_(arg_110_0)
			if arg_110_0 == 1 then
				arg_108_0:Play302031028(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 and not isNil(arg_108_1.actors_["1084ui_story"]) and arg_108_1.var_.characterEffect1084ui_story == nil then
				arg_108_1.var_.characterEffect1084ui_story = arg_108_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_111_0 = 0.200000002980232

			if 0 <= arg_108_1.time_ and arg_108_1.time_ < 0 + var_111_0 and not isNil(arg_108_1.actors_["1084ui_story"]) then
				if arg_108_1.var_.characterEffect1084ui_story and not isNil(arg_108_1.actors_["1084ui_story"]) then
					arg_108_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_108_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_108_1.time_ - 0) / var_111_0)
				end
			end

			if arg_108_1.time_ >= 0 + var_111_0 and arg_108_1.time_ < 0 + var_111_0 + arg_111_0 and not isNil(arg_108_1.actors_["1084ui_story"]) and arg_108_1.var_.characterEffect1084ui_story then
				arg_108_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_108_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_111_1 = 0
			local var_111_2 = 0.65

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= var_111_1 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, true)

				arg_108_1.leftNameTxt_.text = arg_108_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_108_1.leftNameTxt_.transform)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1.leftNameTxt_.text)
				SetActive(arg_108_1.iconTrs_.gameObject, true)
				arg_108_1.iconController_:SetSelectedState("hero")

				arg_108_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_108_1.callingController_:SetSelectedState("normal")

				arg_108_1.keyicon_.color = Color.New(1, 1, 1)
				arg_108_1.icon_.color = Color.New(1, 1, 1)

				local var_111_3 = arg_108_1:FormatText(arg_108_1:GetWordFromCfg(302031027).content)

				arg_108_1.text_.text = var_111_3

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_5 = 26 <= 0 and var_111_2 or var_111_2 * (utf8.len(var_111_3) / 26)

				if (26 <= 0 and var_111_2 or var_111_2 * (utf8.len(var_111_3) / 26)) > 0 and var_111_2 < var_111_5 then
					arg_108_1.talkMaxDuration = var_111_5

					if var_111_5 + var_111_1 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_5 + var_111_1
					end
				end

				arg_108_1.text_.text = var_111_3
				arg_108_1.typewritter.percent = 0

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(false)
				arg_108_1:RecordContent(arg_108_1.text_.text)
			end

			local var_111_6 = math.max(var_111_2, arg_108_1.talkMaxDuration)

			if var_111_1 <= arg_108_1.time_ and arg_108_1.time_ < var_111_1 + var_111_6 then
				arg_108_1.typewritter.percent = (arg_108_1.time_ - var_111_1) / var_111_6

				arg_108_1.typewritter:SetDirty()
			end

			if arg_108_1.time_ >= var_111_1 + var_111_6 and arg_108_1.time_ < var_111_1 + var_111_6 + arg_111_0 then
				arg_108_1.typewritter.percent = 1

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(true)
			end
		end

		arg_108_1.nodeConfigList_ = {}

		arg_108_1:InitPlayNodeList()
	end,
	Play302031028 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 302031028
		arg_112_1.duration_ = 5.87

		local var_112_0 = {
			zh = 5.4,
			ja = 5.866
		}
		local var_112_1 = manager.audio:GetLocalizationFlag()

		if var_112_0[var_112_1] ~= nil then
			arg_112_1.duration_ = var_112_0[var_112_1]
		end

		SetActive(arg_112_1.tipsGo_, false)

		function arg_112_1.onSingleLineFinish_()
			arg_112_1.onSingleLineUpdate_ = nil
			arg_112_1.onSingleLineFinish_ = nil
			arg_112_1.state_ = "waiting"
		end

		function arg_112_1.playNext_(arg_114_0)
			if arg_114_0 == 1 then
				arg_112_0:Play302031029(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 and not isNil(arg_112_1.actors_["1084ui_story"]) and arg_112_1.var_.characterEffect1084ui_story == nil then
				arg_112_1.var_.characterEffect1084ui_story = arg_112_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_115_0 = 0.200000002980232

			if 0 <= arg_112_1.time_ and arg_112_1.time_ < 0 + var_115_0 and not isNil(arg_112_1.actors_["1084ui_story"]) then
				if arg_112_1.var_.characterEffect1084ui_story and not isNil(arg_112_1.actors_["1084ui_story"]) then
					arg_112_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_112_1.time_ >= 0 + var_115_0 and arg_112_1.time_ < 0 + var_115_0 + arg_115_0 and not isNil(arg_112_1.actors_["1084ui_story"]) and arg_112_1.var_.characterEffect1084ui_story then
				arg_112_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 then
				arg_112_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 then
				arg_112_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_115_2 = 0
			local var_115_3 = 0.725

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= var_115_2 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, true)

				arg_112_1.leftNameTxt_.text = arg_112_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_112_1.leftNameTxt_.transform)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1.leftNameTxt_.text)
				SetActive(arg_112_1.iconTrs_.gameObject, false)
				arg_112_1.callingController_:SetSelectedState("normal")

				local var_115_4 = arg_112_1:GetWordFromCfg(302031028)
				local var_115_5 = arg_112_1:FormatText(var_115_4.content)

				arg_112_1.text_.text = var_115_5

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_7 = 29 <= 0 and var_115_3 or var_115_3 * (utf8.len(var_115_5) / 29)

				if (29 <= 0 and var_115_3 or var_115_3 * (utf8.len(var_115_5) / 29)) > 0 and var_115_3 < var_115_7 then
					arg_112_1.talkMaxDuration = var_115_7

					if var_115_7 + var_115_2 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_7 + var_115_2
					end
				end

				arg_112_1.text_.text = var_115_5
				arg_112_1.typewritter.percent = 0

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302031", "302031028", "story_v_out_302031.awb") ~= 0 then
					local var_115_8 = manager.audio:GetVoiceLength("story_v_out_302031", "302031028", "story_v_out_302031.awb") / 1000

					if var_115_8 + var_115_2 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_8 + var_115_2
					end

					if var_115_4.prefab_name ~= "" and arg_112_1.actors_[var_115_4.prefab_name] ~= nil then
						local var_115_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_112_1.actors_[var_115_4.prefab_name].transform, "story_v_out_302031", "302031028", "story_v_out_302031.awb")

						arg_112_1:RecordAudio("302031028", var_115_9)
						arg_112_1:RecordAudio("302031028", var_115_9)
					else
						arg_112_1:AudioAction("play", "voice", "story_v_out_302031", "302031028", "story_v_out_302031.awb")
					end

					arg_112_1:RecordHistoryTalkVoice("story_v_out_302031", "302031028", "story_v_out_302031.awb")
				end

				arg_112_1:RecordContent(arg_112_1.text_.text)
			end

			local var_115_10 = math.max(var_115_3, arg_112_1.talkMaxDuration)

			if var_115_2 <= arg_112_1.time_ and arg_112_1.time_ < var_115_2 + var_115_10 then
				arg_112_1.typewritter.percent = (arg_112_1.time_ - var_115_2) / var_115_10

				arg_112_1.typewritter:SetDirty()
			end

			if arg_112_1.time_ >= var_115_2 + var_115_10 and arg_112_1.time_ < var_115_2 + var_115_10 + arg_115_0 then
				arg_112_1.typewritter.percent = 1

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(true)
			end
		end

		arg_112_1.nodeConfigList_ = {}

		arg_112_1:InitPlayNodeList()
	end,
	Play302031029 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 302031029
		arg_116_1.duration_ = 5

		SetActive(arg_116_1.tipsGo_, false)

		function arg_116_1.onSingleLineFinish_()
			arg_116_1.onSingleLineUpdate_ = nil
			arg_116_1.onSingleLineFinish_ = nil
			arg_116_1.state_ = "waiting"
		end

		function arg_116_1.playNext_(arg_118_0)
			if arg_118_0 == 1 then
				arg_116_0:Play302031030(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 and not isNil(arg_116_1.actors_["1084ui_story"]) and arg_116_1.var_.characterEffect1084ui_story == nil then
				arg_116_1.var_.characterEffect1084ui_story = arg_116_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_119_0 = 0.200000002980232

			if 0 <= arg_116_1.time_ and arg_116_1.time_ < 0 + var_119_0 and not isNil(arg_116_1.actors_["1084ui_story"]) then
				if arg_116_1.var_.characterEffect1084ui_story and not isNil(arg_116_1.actors_["1084ui_story"]) then
					arg_116_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_116_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_116_1.time_ - 0) / var_119_0)
				end
			end

			if arg_116_1.time_ >= 0 + var_119_0 and arg_116_1.time_ < 0 + var_119_0 + arg_119_0 and not isNil(arg_116_1.actors_["1084ui_story"]) and arg_116_1.var_.characterEffect1084ui_story then
				arg_116_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_116_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_119_1 = 0
			local var_119_2 = 0.35

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= var_119_1 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0
				arg_116_1.dialogCg_.alpha = 1

				arg_116_1.dialog_:SetActive(true)
				SetActive(arg_116_1.leftNameGo_, true)

				arg_116_1.leftNameTxt_.text = arg_116_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_116_1.leftNameTxt_.transform)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1.leftNameTxt_.text)
				SetActive(arg_116_1.iconTrs_.gameObject, true)
				arg_116_1.iconController_:SetSelectedState("hero")

				arg_116_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_116_1.callingController_:SetSelectedState("normal")

				arg_116_1.keyicon_.color = Color.New(1, 1, 1)
				arg_116_1.icon_.color = Color.New(1, 1, 1)

				local var_119_3 = arg_116_1:FormatText(arg_116_1:GetWordFromCfg(302031029).content)

				arg_116_1.text_.text = var_119_3

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_5 = 14 <= 0 and var_119_2 or var_119_2 * (utf8.len(var_119_3) / 14)

				if (14 <= 0 and var_119_2 or var_119_2 * (utf8.len(var_119_3) / 14)) > 0 and var_119_2 < var_119_5 then
					arg_116_1.talkMaxDuration = var_119_5

					if var_119_5 + var_119_1 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_5 + var_119_1
					end
				end

				arg_116_1.text_.text = var_119_3
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)
				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_6 = math.max(var_119_2, arg_116_1.talkMaxDuration)

			if var_119_1 <= arg_116_1.time_ and arg_116_1.time_ < var_119_1 + var_119_6 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - var_119_1) / var_119_6

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= var_119_1 + var_119_6 and arg_116_1.time_ < var_119_1 + var_119_6 + arg_119_0 then
				arg_116_1.typewritter.percent = 1

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(true)
			end
		end

		arg_116_1.nodeConfigList_ = {}

		arg_116_1:InitPlayNodeList()
	end,
	Play302031030 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 302031030
		arg_120_1.duration_ = 6.9

		local var_120_0 = {
			zh = 6.9,
			ja = 5.4
		}
		local var_120_1 = manager.audio:GetLocalizationFlag()

		if var_120_0[var_120_1] ~= nil then
			arg_120_1.duration_ = var_120_0[var_120_1]
		end

		SetActive(arg_120_1.tipsGo_, false)

		function arg_120_1.onSingleLineFinish_()
			arg_120_1.onSingleLineUpdate_ = nil
			arg_120_1.onSingleLineFinish_ = nil
			arg_120_1.state_ = "waiting"
		end

		function arg_120_1.playNext_(arg_122_0)
			if arg_122_0 == 1 then
				arg_120_0:Play302031031(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 and not isNil(arg_120_1.actors_["1027ui_story"]) and arg_120_1.var_.characterEffect1027ui_story == nil then
				arg_120_1.var_.characterEffect1027ui_story = arg_120_1.actors_["1027ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_123_0 = 0.200000002980232

			if 0 <= arg_120_1.time_ and arg_120_1.time_ < 0 + var_123_0 and not isNil(arg_120_1.actors_["1027ui_story"]) then
				if arg_120_1.var_.characterEffect1027ui_story and not isNil(arg_120_1.actors_["1027ui_story"]) then
					arg_120_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_120_1.time_ >= 0 + var_123_0 and arg_120_1.time_ < 0 + var_123_0 + arg_123_0 and not isNil(arg_120_1.actors_["1027ui_story"]) and arg_120_1.var_.characterEffect1027ui_story then
				arg_120_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 then
				arg_120_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action1_1")
			end

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 then
				arg_120_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_123_2 = 0
			local var_123_3 = 0.85

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= var_123_2 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0
				arg_120_1.dialogCg_.alpha = 1

				arg_120_1.dialog_:SetActive(true)
				SetActive(arg_120_1.leftNameGo_, true)

				arg_120_1.leftNameTxt_.text = arg_120_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_120_1.leftNameTxt_.transform)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1.leftNameTxt_.text)
				SetActive(arg_120_1.iconTrs_.gameObject, false)
				arg_120_1.callingController_:SetSelectedState("normal")

				local var_123_4 = arg_120_1:GetWordFromCfg(302031030)
				local var_123_5 = arg_120_1:FormatText(var_123_4.content)

				arg_120_1.text_.text = var_123_5

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_7 = 34 <= 0 and var_123_3 or var_123_3 * (utf8.len(var_123_5) / 34)

				if (34 <= 0 and var_123_3 or var_123_3 * (utf8.len(var_123_5) / 34)) > 0 and var_123_3 < var_123_7 then
					arg_120_1.talkMaxDuration = var_123_7

					if var_123_7 + var_123_2 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_7 + var_123_2
					end
				end

				arg_120_1.text_.text = var_123_5
				arg_120_1.typewritter.percent = 0

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302031", "302031030", "story_v_out_302031.awb") ~= 0 then
					local var_123_8 = manager.audio:GetVoiceLength("story_v_out_302031", "302031030", "story_v_out_302031.awb") / 1000

					if var_123_8 + var_123_2 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_8 + var_123_2
					end

					if var_123_4.prefab_name ~= "" and arg_120_1.actors_[var_123_4.prefab_name] ~= nil then
						local var_123_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_120_1.actors_[var_123_4.prefab_name].transform, "story_v_out_302031", "302031030", "story_v_out_302031.awb")

						arg_120_1:RecordAudio("302031030", var_123_9)
						arg_120_1:RecordAudio("302031030", var_123_9)
					else
						arg_120_1:AudioAction("play", "voice", "story_v_out_302031", "302031030", "story_v_out_302031.awb")
					end

					arg_120_1:RecordHistoryTalkVoice("story_v_out_302031", "302031030", "story_v_out_302031.awb")
				end

				arg_120_1:RecordContent(arg_120_1.text_.text)
			end

			local var_123_10 = math.max(var_123_3, arg_120_1.talkMaxDuration)

			if var_123_2 <= arg_120_1.time_ and arg_120_1.time_ < var_123_2 + var_123_10 then
				arg_120_1.typewritter.percent = (arg_120_1.time_ - var_123_2) / var_123_10

				arg_120_1.typewritter:SetDirty()
			end

			if arg_120_1.time_ >= var_123_2 + var_123_10 and arg_120_1.time_ < var_123_2 + var_123_10 + arg_123_0 then
				arg_120_1.typewritter.percent = 1

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(true)
			end
		end

		arg_120_1.nodeConfigList_ = {}

		arg_120_1:InitPlayNodeList()
	end,
	Play302031031 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 302031031
		arg_124_1.duration_ = 1

		SetActive(arg_124_1.tipsGo_, false)

		function arg_124_1.onSingleLineFinish_()
			arg_124_1.onSingleLineUpdate_ = nil
			arg_124_1.onSingleLineFinish_ = nil
			arg_124_1.state_ = "waiting"

			SetActive(arg_124_1.choicesGo_, true)

			for iter_125_0, iter_125_1 in ipairs(arg_124_1.choices_) do
				SetActive(iter_125_1.go, iter_125_0 <= 2)
			end

			arg_124_1.choices_[1].txt.text = arg_124_1:FormatText(StoryChoiceCfg[1732].name)
			arg_124_1.choices_[2].txt.text = arg_124_1:FormatText(StoryChoiceCfg[1733].name)
		end

		function arg_124_1.playNext_(arg_126_0)
			if arg_126_0 == 1 then
				arg_124_0:Play302031032(arg_124_1)
			end

			if arg_126_0 == 2 then
				arg_124_0:Play302031034(arg_124_1)
			end

			arg_124_1:RecordChoiceLog(302031031, 1732, 1733)
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 then
				arg_124_1.allBtn_.enabled = false
			end

			if arg_124_1.time_ >= 0 + 1 and arg_124_1.time_ < 0 + 1 + arg_127_0 then
				arg_124_1.allBtn_.enabled = true
			end
		end

		arg_124_1.nodeConfigList_ = {}

		arg_124_1:InitPlayNodeList()
	end,
	Play302031032 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 302031032
		arg_128_1.duration_ = 8.27

		local var_128_0 = {
			zh = 5.5,
			ja = 8.266
		}
		local var_128_1 = manager.audio:GetLocalizationFlag()

		if var_128_0[var_128_1] ~= nil then
			arg_128_1.duration_ = var_128_0[var_128_1]
		end

		SetActive(arg_128_1.tipsGo_, false)

		function arg_128_1.onSingleLineFinish_()
			arg_128_1.onSingleLineUpdate_ = nil
			arg_128_1.onSingleLineFinish_ = nil
			arg_128_1.state_ = "waiting"
		end

		function arg_128_1.playNext_(arg_130_0)
			if arg_130_0 == 1 then
				arg_128_0:Play302031033(arg_128_1)
			end
		end

		function arg_128_1.onSingleLineUpdate_(arg_131_0)
			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 and not isNil(arg_128_1.actors_["1027ui_story"]) and arg_128_1.var_.characterEffect1027ui_story == nil then
				arg_128_1.var_.characterEffect1027ui_story = arg_128_1.actors_["1027ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_131_0 = 0.200000002980232

			if 0 <= arg_128_1.time_ and arg_128_1.time_ < 0 + var_131_0 and not isNil(arg_128_1.actors_["1027ui_story"]) then
				if arg_128_1.var_.characterEffect1027ui_story and not isNil(arg_128_1.actors_["1027ui_story"]) then
					arg_128_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_128_1.time_ >= 0 + var_131_0 and arg_128_1.time_ < 0 + var_131_0 + arg_131_0 and not isNil(arg_128_1.actors_["1027ui_story"]) and arg_128_1.var_.characterEffect1027ui_story then
				arg_128_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 then
				arg_128_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action2_1")
			end

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 then
				arg_128_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_131_2 = 0
			local var_131_3 = 0.675

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= var_131_2 + arg_131_0 then
				arg_128_1.talkMaxDuration = 0
				arg_128_1.dialogCg_.alpha = 1

				arg_128_1.dialog_:SetActive(true)
				SetActive(arg_128_1.leftNameGo_, true)

				arg_128_1.leftNameTxt_.text = arg_128_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_128_1.leftNameTxt_.transform)

				arg_128_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_128_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_128_1:RecordName(arg_128_1.leftNameTxt_.text)
				SetActive(arg_128_1.iconTrs_.gameObject, false)
				arg_128_1.callingController_:SetSelectedState("normal")

				local var_131_4 = arg_128_1:GetWordFromCfg(302031032)
				local var_131_5 = arg_128_1:FormatText(var_131_4.content)

				arg_128_1.text_.text = var_131_5

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_7 = 27 <= 0 and var_131_3 or var_131_3 * (utf8.len(var_131_5) / 27)

				if (27 <= 0 and var_131_3 or var_131_3 * (utf8.len(var_131_5) / 27)) > 0 and var_131_3 < var_131_7 then
					arg_128_1.talkMaxDuration = var_131_7

					if var_131_7 + var_131_2 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_7 + var_131_2
					end
				end

				arg_128_1.text_.text = var_131_5
				arg_128_1.typewritter.percent = 0

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302031", "302031032", "story_v_out_302031.awb") ~= 0 then
					local var_131_8 = manager.audio:GetVoiceLength("story_v_out_302031", "302031032", "story_v_out_302031.awb") / 1000

					if var_131_8 + var_131_2 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_8 + var_131_2
					end

					if var_131_4.prefab_name ~= "" and arg_128_1.actors_[var_131_4.prefab_name] ~= nil then
						local var_131_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_128_1.actors_[var_131_4.prefab_name].transform, "story_v_out_302031", "302031032", "story_v_out_302031.awb")

						arg_128_1:RecordAudio("302031032", var_131_9)
						arg_128_1:RecordAudio("302031032", var_131_9)
					else
						arg_128_1:AudioAction("play", "voice", "story_v_out_302031", "302031032", "story_v_out_302031.awb")
					end

					arg_128_1:RecordHistoryTalkVoice("story_v_out_302031", "302031032", "story_v_out_302031.awb")
				end

				arg_128_1:RecordContent(arg_128_1.text_.text)
			end

			local var_131_10 = math.max(var_131_3, arg_128_1.talkMaxDuration)

			if var_131_2 <= arg_128_1.time_ and arg_128_1.time_ < var_131_2 + var_131_10 then
				arg_128_1.typewritter.percent = (arg_128_1.time_ - var_131_2) / var_131_10

				arg_128_1.typewritter:SetDirty()
			end

			if arg_128_1.time_ >= var_131_2 + var_131_10 and arg_128_1.time_ < var_131_2 + var_131_10 + arg_131_0 then
				arg_128_1.typewritter.percent = 1

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(true)
			end
		end

		arg_128_1.nodeConfigList_ = {}

		arg_128_1:InitPlayNodeList()
	end,
	Play302031033 = function(arg_132_0, arg_132_1)
		arg_132_1.time_ = 0
		arg_132_1.frameCnt_ = 0
		arg_132_1.state_ = "playing"
		arg_132_1.curTalkId_ = 302031033
		arg_132_1.duration_ = 7.83

		local var_132_0 = {
			zh = 7.833,
			ja = 6
		}
		local var_132_1 = manager.audio:GetLocalizationFlag()

		if var_132_0[var_132_1] ~= nil then
			arg_132_1.duration_ = var_132_0[var_132_1]
		end

		SetActive(arg_132_1.tipsGo_, false)

		function arg_132_1.onSingleLineFinish_()
			arg_132_1.onSingleLineUpdate_ = nil
			arg_132_1.onSingleLineFinish_ = nil
			arg_132_1.state_ = "waiting"
		end

		function arg_132_1.playNext_(arg_134_0)
			if arg_134_0 == 1 then
				arg_132_0:Play302031036(arg_132_1)
			end
		end

		function arg_132_1.onSingleLineUpdate_(arg_135_0)
			local var_135_0 = 0.975

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 then
				arg_132_1.talkMaxDuration = 0
				arg_132_1.dialogCg_.alpha = 1

				arg_132_1.dialog_:SetActive(true)
				SetActive(arg_132_1.leftNameGo_, true)

				arg_132_1.leftNameTxt_.text = arg_132_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_132_1.leftNameTxt_.transform)

				arg_132_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_132_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_132_1:RecordName(arg_132_1.leftNameTxt_.text)
				SetActive(arg_132_1.iconTrs_.gameObject, false)
				arg_132_1.callingController_:SetSelectedState("normal")

				local var_135_1 = arg_132_1:GetWordFromCfg(302031033)
				local var_135_2 = arg_132_1:FormatText(var_135_1.content)

				arg_132_1.text_.text = var_135_2

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_)

				local var_135_4 = 39 <= 0 and var_135_0 or var_135_0 * (utf8.len(var_135_2) / 39)

				if (39 <= 0 and var_135_0 or var_135_0 * (utf8.len(var_135_2) / 39)) > 0 and var_135_0 < var_135_4 then
					arg_132_1.talkMaxDuration = var_135_4

					if var_135_4 + 0 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_4 + 0
					end
				end

				arg_132_1.text_.text = var_135_2
				arg_132_1.typewritter.percent = 0

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302031", "302031033", "story_v_out_302031.awb") ~= 0 then
					local var_135_5 = manager.audio:GetVoiceLength("story_v_out_302031", "302031033", "story_v_out_302031.awb") / 1000

					if var_135_5 + 0 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_5 + 0
					end

					if var_135_1.prefab_name ~= "" and arg_132_1.actors_[var_135_1.prefab_name] ~= nil then
						local var_135_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_132_1.actors_[var_135_1.prefab_name].transform, "story_v_out_302031", "302031033", "story_v_out_302031.awb")

						arg_132_1:RecordAudio("302031033", var_135_6)
						arg_132_1:RecordAudio("302031033", var_135_6)
					else
						arg_132_1:AudioAction("play", "voice", "story_v_out_302031", "302031033", "story_v_out_302031.awb")
					end

					arg_132_1:RecordHistoryTalkVoice("story_v_out_302031", "302031033", "story_v_out_302031.awb")
				end

				arg_132_1:RecordContent(arg_132_1.text_.text)
			end

			local var_135_7 = math.max(var_135_0, arg_132_1.talkMaxDuration)

			if 0 <= arg_132_1.time_ and arg_132_1.time_ < 0 + var_135_7 then
				arg_132_1.typewritter.percent = (arg_132_1.time_ - 0) / var_135_7

				arg_132_1.typewritter:SetDirty()
			end

			if arg_132_1.time_ >= 0 + var_135_7 and arg_132_1.time_ < 0 + var_135_7 + arg_135_0 then
				arg_132_1.typewritter.percent = 1

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(true)
			end
		end

		arg_132_1.nodeConfigList_ = {}

		arg_132_1:InitPlayNodeList()
	end,
	Play302031036 = function(arg_136_0, arg_136_1)
		arg_136_1.time_ = 0
		arg_136_1.frameCnt_ = 0
		arg_136_1.state_ = "playing"
		arg_136_1.curTalkId_ = 302031036
		arg_136_1.duration_ = 5.6

		local var_136_0 = {
			zh = 4.066,
			ja = 5.6
		}
		local var_136_1 = manager.audio:GetLocalizationFlag()

		if var_136_0[var_136_1] ~= nil then
			arg_136_1.duration_ = var_136_0[var_136_1]
		end

		SetActive(arg_136_1.tipsGo_, false)

		function arg_136_1.onSingleLineFinish_()
			arg_136_1.onSingleLineUpdate_ = nil
			arg_136_1.onSingleLineFinish_ = nil
			arg_136_1.state_ = "waiting"
		end

		function arg_136_1.playNext_(arg_138_0)
			if arg_138_0 == 1 then
				arg_136_0:Play302031037(arg_136_1)
			end
		end

		function arg_136_1.onSingleLineUpdate_(arg_139_0)
			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 then
				arg_136_1.var_.moveOldPos1084ui_story = arg_136_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_139_0 = 0.001

			if 0 <= arg_136_1.time_ and arg_136_1.time_ < 0 + var_139_0 then
				arg_136_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_136_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_136_1.time_ - 0) / var_139_0)
				arg_136_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_136_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_136_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_136_1.actors_["1084ui_story"].transform.position).z)
				arg_136_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_136_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_136_1.actors_["1084ui_story"].transform.localEulerAngles = arg_136_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_136_1.time_ >= 0 + var_139_0 and arg_136_1.time_ < 0 + var_139_0 + arg_139_0 then
				arg_136_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_136_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_136_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_136_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_136_1.actors_["1084ui_story"].transform.position).z)
				arg_136_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_136_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_136_1.actors_["1084ui_story"].transform.localEulerAngles = arg_136_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_139_1 = arg_136_1.actors_["1019ui_story"].transform

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 then
				arg_136_1.var_.moveOldPos1019ui_story = var_139_1.localPosition
			end

			local var_139_2 = 0.001

			if 0 <= arg_136_1.time_ and arg_136_1.time_ < 0 + var_139_2 then
				var_139_1.localPosition = Vector3.Lerp(arg_136_1.var_.moveOldPos1019ui_story, Vector3.New(0.7, -1.08, -5.9), (arg_136_1.time_ - 0) / var_139_2)
				var_139_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_139_1.position).x, (manager.ui.mainCamera.transform.position - var_139_1.position).y, (manager.ui.mainCamera.transform.position - var_139_1.position).z)
				var_139_1.localEulerAngles.z = 0
				var_139_1.localEulerAngles.x = 0
				var_139_1.localEulerAngles = var_139_1.localEulerAngles
			end

			if arg_136_1.time_ >= 0 + var_139_2 and arg_136_1.time_ < 0 + var_139_2 + arg_139_0 then
				var_139_1.localPosition = Vector3.New(0.7, -1.08, -5.9)
				var_139_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_139_1.position).x, (manager.ui.mainCamera.transform.position - var_139_1.position).y, (manager.ui.mainCamera.transform.position - var_139_1.position).z)
				var_139_1.localEulerAngles.z = 0
				var_139_1.localEulerAngles.x = 0
				var_139_1.localEulerAngles = var_139_1.localEulerAngles
			end

			local var_139_3 = arg_136_1.actors_["1019ui_story"]

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 and not isNil(var_139_3) and arg_136_1.var_.characterEffect1019ui_story == nil then
				arg_136_1.var_.characterEffect1019ui_story = var_139_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_139_4 = 0.200000002980232

			if 0 <= arg_136_1.time_ and arg_136_1.time_ < 0 + var_139_4 and not isNil(var_139_3) then
				if arg_136_1.var_.characterEffect1019ui_story and not isNil(var_139_3) then
					arg_136_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_136_1.time_ >= 0 + var_139_4 and arg_136_1.time_ < 0 + var_139_4 + arg_139_0 and not isNil(var_139_3) and arg_136_1.var_.characterEffect1019ui_story then
				arg_136_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_139_6 = arg_136_1.actors_["1027ui_story"]

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 and not isNil(var_139_6) and arg_136_1.var_.characterEffect1027ui_story == nil then
				arg_136_1.var_.characterEffect1027ui_story = var_139_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_139_7 = 0.200000002980232

			if 0 <= arg_136_1.time_ and arg_136_1.time_ < 0 + var_139_7 and not isNil(var_139_6) then
				if arg_136_1.var_.characterEffect1027ui_story and not isNil(var_139_6) then
					arg_136_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_136_1.var_.characterEffect1027ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_136_1.time_ - 0) / var_139_7)
				end
			end

			if arg_136_1.time_ >= 0 + var_139_7 and arg_136_1.time_ < 0 + var_139_7 + arg_139_0 and not isNil(var_139_6) and arg_136_1.var_.characterEffect1027ui_story then
				arg_136_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_136_1.var_.characterEffect1027ui_story.fillRatio = 0.5
			end

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 then
				arg_136_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action1_1")
			end

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 then
				arg_136_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_139_8 = 0
			local var_139_9 = 0.45

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= var_139_8 + arg_139_0 then
				arg_136_1.talkMaxDuration = 0
				arg_136_1.dialogCg_.alpha = 1

				arg_136_1.dialog_:SetActive(true)
				SetActive(arg_136_1.leftNameGo_, true)

				arg_136_1.leftNameTxt_.text = arg_136_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_136_1.leftNameTxt_.transform)

				arg_136_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_136_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_136_1:RecordName(arg_136_1.leftNameTxt_.text)
				SetActive(arg_136_1.iconTrs_.gameObject, false)
				arg_136_1.callingController_:SetSelectedState("normal")

				local var_139_10 = arg_136_1:GetWordFromCfg(302031036)
				local var_139_11 = arg_136_1:FormatText(var_139_10.content)

				arg_136_1.text_.text = var_139_11

				LuaForUtil.ClearLinePrefixSymbol(arg_136_1.text_)

				local var_139_13 = 18 <= 0 and var_139_9 or var_139_9 * (utf8.len(var_139_11) / 18)

				if (18 <= 0 and var_139_9 or var_139_9 * (utf8.len(var_139_11) / 18)) > 0 and var_139_9 < var_139_13 then
					arg_136_1.talkMaxDuration = var_139_13

					if var_139_13 + var_139_8 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_13 + var_139_8
					end
				end

				arg_136_1.text_.text = var_139_11
				arg_136_1.typewritter.percent = 0

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302031", "302031036", "story_v_out_302031.awb") ~= 0 then
					local var_139_14 = manager.audio:GetVoiceLength("story_v_out_302031", "302031036", "story_v_out_302031.awb") / 1000

					if var_139_14 + var_139_8 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_14 + var_139_8
					end

					if var_139_10.prefab_name ~= "" and arg_136_1.actors_[var_139_10.prefab_name] ~= nil then
						local var_139_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_136_1.actors_[var_139_10.prefab_name].transform, "story_v_out_302031", "302031036", "story_v_out_302031.awb")

						arg_136_1:RecordAudio("302031036", var_139_15)
						arg_136_1:RecordAudio("302031036", var_139_15)
					else
						arg_136_1:AudioAction("play", "voice", "story_v_out_302031", "302031036", "story_v_out_302031.awb")
					end

					arg_136_1:RecordHistoryTalkVoice("story_v_out_302031", "302031036", "story_v_out_302031.awb")
				end

				arg_136_1:RecordContent(arg_136_1.text_.text)
			end

			local var_139_16 = math.max(var_139_9, arg_136_1.talkMaxDuration)

			if var_139_8 <= arg_136_1.time_ and arg_136_1.time_ < var_139_8 + var_139_16 then
				arg_136_1.typewritter.percent = (arg_136_1.time_ - var_139_8) / var_139_16

				arg_136_1.typewritter:SetDirty()
			end

			if arg_136_1.time_ >= var_139_8 + var_139_16 and arg_136_1.time_ < var_139_8 + var_139_16 + arg_139_0 then
				arg_136_1.typewritter.percent = 1

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(true)
			end
		end

		arg_136_1.nodeConfigList_ = {
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
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_136_1:InitPlayNodeList()
	end,
	Play302031037 = function(arg_140_0, arg_140_1)
		arg_140_1.time_ = 0
		arg_140_1.frameCnt_ = 0
		arg_140_1.state_ = "playing"
		arg_140_1.curTalkId_ = 302031037
		arg_140_1.duration_ = 6.9

		local var_140_0 = {
			zh = 3.866,
			ja = 6.9
		}
		local var_140_1 = manager.audio:GetLocalizationFlag()

		if var_140_0[var_140_1] ~= nil then
			arg_140_1.duration_ = var_140_0[var_140_1]
		end

		SetActive(arg_140_1.tipsGo_, false)

		function arg_140_1.onSingleLineFinish_()
			arg_140_1.onSingleLineUpdate_ = nil
			arg_140_1.onSingleLineFinish_ = nil
			arg_140_1.state_ = "waiting"
		end

		function arg_140_1.playNext_(arg_142_0)
			if arg_142_0 == 1 then
				arg_140_0:Play302031038(arg_140_1)
			end
		end

		function arg_140_1.onSingleLineUpdate_(arg_143_0)
			if 0 < arg_140_1.time_ and arg_140_1.time_ <= 0 + arg_143_0 then
				arg_140_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action5_1")
			end

			if 0 < arg_140_1.time_ and arg_140_1.time_ <= 0 + arg_143_0 then
				arg_140_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_143_0 = 0
			local var_143_1 = 0.5

			if 0 < arg_140_1.time_ and arg_140_1.time_ <= var_143_0 + arg_143_0 then
				arg_140_1.talkMaxDuration = 0
				arg_140_1.dialogCg_.alpha = 1

				arg_140_1.dialog_:SetActive(true)
				SetActive(arg_140_1.leftNameGo_, true)

				arg_140_1.leftNameTxt_.text = arg_140_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_140_1.leftNameTxt_.transform)

				arg_140_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_140_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_140_1:RecordName(arg_140_1.leftNameTxt_.text)
				SetActive(arg_140_1.iconTrs_.gameObject, false)
				arg_140_1.callingController_:SetSelectedState("normal")

				local var_143_2 = arg_140_1:GetWordFromCfg(302031037)
				local var_143_3 = arg_140_1:FormatText(var_143_2.content)

				arg_140_1.text_.text = var_143_3

				LuaForUtil.ClearLinePrefixSymbol(arg_140_1.text_)

				local var_143_5 = 20 <= 0 and var_143_1 or var_143_1 * (utf8.len(var_143_3) / 20)

				if (20 <= 0 and var_143_1 or var_143_1 * (utf8.len(var_143_3) / 20)) > 0 and var_143_1 < var_143_5 then
					arg_140_1.talkMaxDuration = var_143_5

					if var_143_5 + var_143_0 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_5 + var_143_0
					end
				end

				arg_140_1.text_.text = var_143_3
				arg_140_1.typewritter.percent = 0

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302031", "302031037", "story_v_out_302031.awb") ~= 0 then
					local var_143_6 = manager.audio:GetVoiceLength("story_v_out_302031", "302031037", "story_v_out_302031.awb") / 1000

					if var_143_6 + var_143_0 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_6 + var_143_0
					end

					if var_143_2.prefab_name ~= "" and arg_140_1.actors_[var_143_2.prefab_name] ~= nil then
						local var_143_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_140_1.actors_[var_143_2.prefab_name].transform, "story_v_out_302031", "302031037", "story_v_out_302031.awb")

						arg_140_1:RecordAudio("302031037", var_143_7)
						arg_140_1:RecordAudio("302031037", var_143_7)
					else
						arg_140_1:AudioAction("play", "voice", "story_v_out_302031", "302031037", "story_v_out_302031.awb")
					end

					arg_140_1:RecordHistoryTalkVoice("story_v_out_302031", "302031037", "story_v_out_302031.awb")
				end

				arg_140_1:RecordContent(arg_140_1.text_.text)
			end

			local var_143_8 = math.max(var_143_1, arg_140_1.talkMaxDuration)

			if var_143_0 <= arg_140_1.time_ and arg_140_1.time_ < var_143_0 + var_143_8 then
				arg_140_1.typewritter.percent = (arg_140_1.time_ - var_143_0) / var_143_8

				arg_140_1.typewritter:SetDirty()
			end

			if arg_140_1.time_ >= var_143_0 + var_143_8 and arg_140_1.time_ < var_143_0 + var_143_8 + arg_143_0 then
				arg_140_1.typewritter.percent = 1

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(true)
			end
		end

		arg_140_1.nodeConfigList_ = {}

		arg_140_1:InitPlayNodeList()
	end,
	Play302031038 = function(arg_144_0, arg_144_1)
		arg_144_1.time_ = 0
		arg_144_1.frameCnt_ = 0
		arg_144_1.state_ = "playing"
		arg_144_1.curTalkId_ = 302031038
		arg_144_1.duration_ = 4.8

		local var_144_0 = {
			zh = 4.8,
			ja = 1.999999999999
		}
		local var_144_1 = manager.audio:GetLocalizationFlag()

		if var_144_0[var_144_1] ~= nil then
			arg_144_1.duration_ = var_144_0[var_144_1]
		end

		SetActive(arg_144_1.tipsGo_, false)

		function arg_144_1.onSingleLineFinish_()
			arg_144_1.onSingleLineUpdate_ = nil
			arg_144_1.onSingleLineFinish_ = nil
			arg_144_1.state_ = "waiting"
		end

		function arg_144_1.playNext_(arg_146_0)
			if arg_146_0 == 1 then
				arg_144_0:Play302031039(arg_144_1)
			end
		end

		function arg_144_1.onSingleLineUpdate_(arg_147_0)
			if 0 < arg_144_1.time_ and arg_144_1.time_ <= 0 + arg_147_0 then
				arg_144_1.var_.moveOldPos1166ui_story = arg_144_1.actors_["1166ui_story"].transform.localPosition

				local var_147_0 = GameObjectTools.GetOrAddComponent(arg_144_1.actors_["1166ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_147_0 then
					var_147_0:EnableDynamicBone(false)
				end
			end

			local var_147_1 = 0.001

			if 0 <= arg_144_1.time_ and arg_144_1.time_ < 0 + var_147_1 then
				arg_144_1.actors_["1166ui_story"].transform.localPosition = Vector3.Lerp(arg_144_1.var_.moveOldPos1166ui_story, Vector3.New(-0.7, -0.75, -6.25), (arg_144_1.time_ - 0) / var_147_1)
				arg_144_1.actors_["1166ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_144_1.actors_["1166ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_144_1.actors_["1166ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_144_1.actors_["1166ui_story"].transform.position).z)
				arg_144_1.actors_["1166ui_story"].transform.localEulerAngles.z = 0
				arg_144_1.actors_["1166ui_story"].transform.localEulerAngles.x = 0
				arg_144_1.actors_["1166ui_story"].transform.localEulerAngles = arg_144_1.actors_["1166ui_story"].transform.localEulerAngles
			end

			if arg_144_1.time_ >= 0 + var_147_1 and arg_144_1.time_ < 0 + var_147_1 + arg_147_0 then
				arg_144_1.actors_["1166ui_story"].transform.localPosition = Vector3.New(-0.7, -0.75, -6.25)
				arg_144_1.actors_["1166ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_144_1.actors_["1166ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_144_1.actors_["1166ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_144_1.actors_["1166ui_story"].transform.position).z)
				arg_144_1.actors_["1166ui_story"].transform.localEulerAngles.z = 0
				arg_144_1.actors_["1166ui_story"].transform.localEulerAngles.x = 0
				arg_144_1.actors_["1166ui_story"].transform.localEulerAngles = arg_144_1.actors_["1166ui_story"].transform.localEulerAngles

				local var_147_2 = GameObjectTools.GetOrAddComponent(arg_144_1.actors_["1166ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_147_2 then
					var_147_2:EnableDynamicBone(true)
				end
			end

			local var_147_3 = arg_144_1.actors_["1027ui_story"].transform

			if 0 < arg_144_1.time_ and arg_144_1.time_ <= 0 + arg_147_0 then
				arg_144_1.var_.moveOldPos1027ui_story = var_147_3.localPosition
			end

			local var_147_4 = 0.001

			if 0 <= arg_144_1.time_ and arg_144_1.time_ < 0 + var_147_4 then
				var_147_3.localPosition = Vector3.Lerp(arg_144_1.var_.moveOldPos1027ui_story, Vector3.New(0, 100, 0), (arg_144_1.time_ - 0) / var_147_4)
				var_147_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_147_3.position).x, (manager.ui.mainCamera.transform.position - var_147_3.position).y, (manager.ui.mainCamera.transform.position - var_147_3.position).z)
				var_147_3.localEulerAngles.z = 0
				var_147_3.localEulerAngles.x = 0
				var_147_3.localEulerAngles = var_147_3.localEulerAngles
			end

			if arg_144_1.time_ >= 0 + var_147_4 and arg_144_1.time_ < 0 + var_147_4 + arg_147_0 then
				var_147_3.localPosition = Vector3.New(0, 100, 0)
				var_147_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_147_3.position).x, (manager.ui.mainCamera.transform.position - var_147_3.position).y, (manager.ui.mainCamera.transform.position - var_147_3.position).z)
				var_147_3.localEulerAngles.z = 0
				var_147_3.localEulerAngles.x = 0
				var_147_3.localEulerAngles = var_147_3.localEulerAngles
			end

			local var_147_5 = arg_144_1.actors_["1166ui_story"]

			if 0 < arg_144_1.time_ and arg_144_1.time_ <= 0 + arg_147_0 and not isNil(var_147_5) and arg_144_1.var_.characterEffect1166ui_story == nil then
				arg_144_1.var_.characterEffect1166ui_story = var_147_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_147_6 = 0.200000002980232

			if 0 <= arg_144_1.time_ and arg_144_1.time_ < 0 + var_147_6 and not isNil(var_147_5) then
				if arg_144_1.var_.characterEffect1166ui_story and not isNil(var_147_5) then
					arg_144_1.var_.characterEffect1166ui_story.fillFlat = false
				end
			end

			if arg_144_1.time_ >= 0 + var_147_6 and arg_144_1.time_ < 0 + var_147_6 + arg_147_0 and not isNil(var_147_5) and arg_144_1.var_.characterEffect1166ui_story then
				arg_144_1.var_.characterEffect1166ui_story.fillFlat = false
			end

			local var_147_8 = arg_144_1.actors_["1019ui_story"]

			if 0 < arg_144_1.time_ and arg_144_1.time_ <= 0 + arg_147_0 and not isNil(var_147_8) and arg_144_1.var_.characterEffect1019ui_story == nil then
				arg_144_1.var_.characterEffect1019ui_story = var_147_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_147_9 = 0.200000002980232

			if 0 <= arg_144_1.time_ and arg_144_1.time_ < 0 + var_147_9 and not isNil(var_147_8) then
				if arg_144_1.var_.characterEffect1019ui_story and not isNil(var_147_8) then
					arg_144_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_144_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_144_1.time_ - 0) / var_147_9)
				end
			end

			if arg_144_1.time_ >= 0 + var_147_9 and arg_144_1.time_ < 0 + var_147_9 + arg_147_0 and not isNil(var_147_8) and arg_144_1.var_.characterEffect1019ui_story then
				arg_144_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_144_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			if 0 < arg_144_1.time_ and arg_144_1.time_ <= 0 + arg_147_0 then
				arg_144_1:PlayTimeline("1166ui_story", "StoryTimeline/CharAction/story1166/story1166action/1166action4_1")
			end

			if 0 < arg_144_1.time_ and arg_144_1.time_ <= 0 + arg_147_0 then
				arg_144_1:PlayTimeline("1166ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			if 0 < arg_144_1.time_ and arg_144_1.time_ <= 0 + arg_147_0 then
				arg_144_1:AudioAction("play", "effect", "ui_battle", "ui_battle_stopbgm", "")
			end

			local var_147_11 = 0
			local var_147_12 = 0.55

			if 0 < arg_144_1.time_ and arg_144_1.time_ <= var_147_11 + arg_147_0 then
				arg_144_1.talkMaxDuration = 0
				arg_144_1.dialogCg_.alpha = 1

				arg_144_1.dialog_:SetActive(true)
				SetActive(arg_144_1.leftNameGo_, true)

				arg_144_1.leftNameTxt_.text = arg_144_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_144_1.leftNameTxt_.transform)

				arg_144_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_144_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_144_1:RecordName(arg_144_1.leftNameTxt_.text)
				SetActive(arg_144_1.iconTrs_.gameObject, false)
				arg_144_1.callingController_:SetSelectedState("normal")

				local var_147_13 = arg_144_1:GetWordFromCfg(302031038)
				local var_147_14 = arg_144_1:FormatText(var_147_13.content)

				arg_144_1.text_.text = var_147_14

				LuaForUtil.ClearLinePrefixSymbol(arg_144_1.text_)

				local var_147_16 = 22 <= 0 and var_147_12 or var_147_12 * (utf8.len(var_147_14) / 22)

				if (22 <= 0 and var_147_12 or var_147_12 * (utf8.len(var_147_14) / 22)) > 0 and var_147_12 < var_147_16 then
					arg_144_1.talkMaxDuration = var_147_16

					if var_147_16 + var_147_11 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_16 + var_147_11
					end
				end

				arg_144_1.text_.text = var_147_14
				arg_144_1.typewritter.percent = 0

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302031", "302031038", "story_v_out_302031.awb") ~= 0 then
					local var_147_17 = manager.audio:GetVoiceLength("story_v_out_302031", "302031038", "story_v_out_302031.awb") / 1000

					if var_147_17 + var_147_11 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_17 + var_147_11
					end

					if var_147_13.prefab_name ~= "" and arg_144_1.actors_[var_147_13.prefab_name] ~= nil then
						local var_147_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_144_1.actors_[var_147_13.prefab_name].transform, "story_v_out_302031", "302031038", "story_v_out_302031.awb")

						arg_144_1:RecordAudio("302031038", var_147_18)
						arg_144_1:RecordAudio("302031038", var_147_18)
					else
						arg_144_1:AudioAction("play", "voice", "story_v_out_302031", "302031038", "story_v_out_302031.awb")
					end

					arg_144_1:RecordHistoryTalkVoice("story_v_out_302031", "302031038", "story_v_out_302031.awb")
				end

				arg_144_1:RecordContent(arg_144_1.text_.text)
			end

			local var_147_19 = math.max(var_147_12, arg_144_1.talkMaxDuration)

			if var_147_11 <= arg_144_1.time_ and arg_144_1.time_ < var_147_11 + var_147_19 then
				arg_144_1.typewritter.percent = (arg_144_1.time_ - var_147_11) / var_147_19

				arg_144_1.typewritter:SetDirty()
			end

			if arg_144_1.time_ >= var_147_11 + var_147_19 and arg_144_1.time_ < var_147_11 + var_147_19 + arg_147_0 then
				arg_144_1.typewritter.percent = 1

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(true)
			end
		end

		arg_144_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1166ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_144_1:InitPlayNodeList()
	end,
	Play302031039 = function(arg_148_0, arg_148_1)
		arg_148_1.time_ = 0
		arg_148_1.frameCnt_ = 0
		arg_148_1.state_ = "playing"
		arg_148_1.curTalkId_ = 302031039
		arg_148_1.duration_ = 9

		SetActive(arg_148_1.tipsGo_, false)

		function arg_148_1.onSingleLineFinish_()
			arg_148_1.onSingleLineUpdate_ = nil
			arg_148_1.onSingleLineFinish_ = nil
			arg_148_1.state_ = "waiting"
		end

		function arg_148_1.playNext_(arg_150_0)
			if arg_150_0 == 1 then
				arg_148_0:Play302031040(arg_148_1)
			end
		end

		function arg_148_1.onSingleLineUpdate_(arg_151_0)
			if arg_148_1.bgs_.I27f == nil then
				local var_151_0 = Object.Instantiate(arg_148_1.paintGo_)

				var_151_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "I27f")
				var_151_0.name = "I27f"
				var_151_0.transform.parent = arg_148_1.stage_.transform
				var_151_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_148_1.bgs_.I27f = var_151_0
			end

			if 2 < arg_148_1.time_ and arg_148_1.time_ <= 2 + arg_151_0 then
				local var_151_1 = arg_148_1.bgs_.I27f

				arg_148_1.bgs_.I27f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_151_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_151_2 = var_151_1:GetComponent("SpriteRenderer")

				if var_151_2 and var_151_2.sprite then
					local var_151_3 = 2 * (var_151_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_151_1.transform.localScale = Vector3.New(var_151_3 / var_151_2.sprite.bounds.size.y < var_151_3 * manager.ui.mainCameraCom_.aspect / var_151_2.sprite.bounds.size.x and var_151_3 * manager.ui.mainCameraCom_.aspect / var_151_2.sprite.bounds.size.x or var_151_3 / var_151_2.sprite.bounds.size.y, var_151_3 / var_151_2.sprite.bounds.size.y < var_151_3 * manager.ui.mainCameraCom_.aspect / var_151_2.sprite.bounds.size.x and var_151_3 * manager.ui.mainCameraCom_.aspect / var_151_2.sprite.bounds.size.x or var_151_3 / var_151_2.sprite.bounds.size.y, 0)
				end

				for iter_151_0, iter_151_1 in pairs(arg_148_1.bgs_) do
					if iter_151_0 ~= "I27f" then
						iter_151_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_151_4 = 3.999999999999

			if 3.999999999999 < arg_148_1.time_ and arg_148_1.time_ <= var_151_4 + arg_151_0 then
				arg_148_1.allBtn_.enabled = false
			end

			if arg_148_1.time_ >= var_151_4 + 0.3 and arg_148_1.time_ < var_151_4 + 0.3 + arg_151_0 then
				arg_148_1.allBtn_.enabled = true
			end

			local var_151_5 = 0

			if 0 < arg_148_1.time_ and arg_148_1.time_ <= var_151_5 + arg_151_0 then
				arg_148_1.mask_.enabled = true
				arg_148_1.mask_.raycastTarget = true

				arg_148_1:SetGaussion(false)
			end

			local var_151_6 = 2

			if var_151_5 <= arg_148_1.time_ and arg_148_1.time_ < var_151_5 + var_151_6 then
				local var_151_7 = Color.New(0, 0, 0)

				var_151_7.a = Mathf.Lerp(0, 1, (arg_148_1.time_ - var_151_5) / var_151_6)
				arg_148_1.mask_.color = var_151_7
			end

			if arg_148_1.time_ >= var_151_5 + var_151_6 and arg_148_1.time_ < var_151_5 + var_151_6 + arg_151_0 then
				local var_151_8 = Color.New(0, 0, 0)

				var_151_8.a = 1
				arg_148_1.mask_.color = var_151_8
			end

			local var_151_9 = 2

			if 2 < arg_148_1.time_ and arg_148_1.time_ <= var_151_9 + arg_151_0 then
				arg_148_1.mask_.enabled = true
				arg_148_1.mask_.raycastTarget = true

				arg_148_1:SetGaussion(false)
			end

			local var_151_10 = 2

			if var_151_9 <= arg_148_1.time_ and arg_148_1.time_ < var_151_9 + var_151_10 then
				local var_151_11 = Color.New(0, 0, 0)

				var_151_11.a = Mathf.Lerp(1, 0, (arg_148_1.time_ - var_151_9) / var_151_10)
				arg_148_1.mask_.color = var_151_11
			end

			if arg_148_1.time_ >= var_151_9 + var_151_10 and arg_148_1.time_ < var_151_9 + var_151_10 + arg_151_0 then
				local var_151_12 = Color.New(0, 0, 0)

				arg_148_1.mask_.enabled = false
				var_151_12.a = 0
				arg_148_1.mask_.color = var_151_12
			end

			local var_151_13 = arg_148_1.actors_["1166ui_story"].transform

			if 1.96599999815226 < arg_148_1.time_ and arg_148_1.time_ <= 1.96599999815226 + arg_151_0 then
				arg_148_1.var_.moveOldPos1166ui_story = var_151_13.localPosition

				local var_151_14 = GameObjectTools.GetOrAddComponent(var_151_13.gameObject, typeof(DynamicBoneHelper))

				if var_151_14 then
					var_151_14:EnableDynamicBone(false)
				end
			end

			local var_151_15 = 0.001

			if 1.96599999815226 <= arg_148_1.time_ and arg_148_1.time_ < 1.96599999815226 + var_151_15 then
				var_151_13.localPosition = Vector3.Lerp(arg_148_1.var_.moveOldPos1166ui_story, Vector3.New(0, 100, 0), (arg_148_1.time_ - 1.96599999815226) / var_151_15)
				var_151_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_151_13.position).x, (manager.ui.mainCamera.transform.position - var_151_13.position).y, (manager.ui.mainCamera.transform.position - var_151_13.position).z)
				var_151_13.localEulerAngles.z = 0
				var_151_13.localEulerAngles.x = 0
				var_151_13.localEulerAngles = var_151_13.localEulerAngles
			end

			if arg_148_1.time_ >= 1.96599999815226 + var_151_15 and arg_148_1.time_ < 1.96599999815226 + var_151_15 + arg_151_0 then
				var_151_13.localPosition = Vector3.New(0, 100, 0)
				var_151_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_151_13.position).x, (manager.ui.mainCamera.transform.position - var_151_13.position).y, (manager.ui.mainCamera.transform.position - var_151_13.position).z)
				var_151_13.localEulerAngles.z = 0
				var_151_13.localEulerAngles.x = 0
				var_151_13.localEulerAngles = var_151_13.localEulerAngles

				local var_151_16 = GameObjectTools.GetOrAddComponent(var_151_13.gameObject, typeof(DynamicBoneHelper))

				if var_151_16 then
					var_151_16:EnableDynamicBone(true)
				end
			end

			local var_151_17 = arg_148_1.actors_["1019ui_story"].transform

			if 1.96599999815226 < arg_148_1.time_ and arg_148_1.time_ <= 1.96599999815226 + arg_151_0 then
				arg_148_1.var_.moveOldPos1019ui_story = var_151_17.localPosition
			end

			local var_151_18 = 0.001

			if 1.96599999815226 <= arg_148_1.time_ and arg_148_1.time_ < 1.96599999815226 + var_151_18 then
				var_151_17.localPosition = Vector3.Lerp(arg_148_1.var_.moveOldPos1019ui_story, Vector3.New(0, 100, 0), (arg_148_1.time_ - 1.96599999815226) / var_151_18)
				var_151_17.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_151_17.position).x, (manager.ui.mainCamera.transform.position - var_151_17.position).y, (manager.ui.mainCamera.transform.position - var_151_17.position).z)
				var_151_17.localEulerAngles.z = 0
				var_151_17.localEulerAngles.x = 0
				var_151_17.localEulerAngles = var_151_17.localEulerAngles
			end

			if arg_148_1.time_ >= 1.96599999815226 + var_151_18 and arg_148_1.time_ < 1.96599999815226 + var_151_18 + arg_151_0 then
				var_151_17.localPosition = Vector3.New(0, 100, 0)
				var_151_17.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_151_17.position).x, (manager.ui.mainCamera.transform.position - var_151_17.position).y, (manager.ui.mainCamera.transform.position - var_151_17.position).z)
				var_151_17.localEulerAngles.z = 0
				var_151_17.localEulerAngles.x = 0
				var_151_17.localEulerAngles = var_151_17.localEulerAngles
			end

			local var_151_19 = arg_148_1.actors_["1166ui_story"]

			if 1.96599999815226 < arg_148_1.time_ and arg_148_1.time_ <= 1.96599999815226 + arg_151_0 and not isNil(var_151_19) and arg_148_1.var_.characterEffect1166ui_story == nil then
				arg_148_1.var_.characterEffect1166ui_story = var_151_19:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_151_20 = 0.034000001847744

			if 1.96599999815226 <= arg_148_1.time_ and arg_148_1.time_ < 1.96599999815226 + var_151_20 and not isNil(var_151_19) then
				if arg_148_1.var_.characterEffect1166ui_story and not isNil(var_151_19) then
					arg_148_1.var_.characterEffect1166ui_story.fillFlat = true
					arg_148_1.var_.characterEffect1166ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_148_1.time_ - 1.96599999815226) / var_151_20)
				end
			end

			if arg_148_1.time_ >= 1.96599999815226 + var_151_20 and arg_148_1.time_ < 1.96599999815226 + var_151_20 + arg_151_0 and not isNil(var_151_19) and arg_148_1.var_.characterEffect1166ui_story then
				arg_148_1.var_.characterEffect1166ui_story.fillFlat = true
				arg_148_1.var_.characterEffect1166ui_story.fillRatio = 0.5
			end

			if 1.2 < arg_148_1.time_ and arg_148_1.time_ <= 1.2 + arg_151_0 then
				arg_148_1:AudioAction("play", "effect", "se_story_140", "se_story_140_amb_street01", "")
			end

			if 0.2 < arg_148_1.time_ and arg_148_1.time_ <= 0.2 + arg_151_0 then
				arg_148_1:AudioAction("stop", "effect", "se_story_142", "se_story_142_amb_commandroom", "")
			end

			if 1 < arg_148_1.time_ and arg_148_1.time_ <= 1 + arg_151_0 then
				arg_148_1:AudioAction("play", "music", "bgm_side_daily04", "bgm_side_daily04", "bgm_side_daily04.awb")

				local var_151_25 = manager.audio:GetAudioName("bgm_side_daily04", "bgm_side_daily04")

				if "" ~= "" then
					if arg_148_1.bgmTxt_.text ~= var_151_25 and arg_148_1.bgmTxt_.text ~= "" then
						if arg_148_1.bgmTxt2_.text ~= "" then
							arg_148_1.bgmTxt_.text = arg_148_1.bgmTxt2_.text
						end

						arg_148_1.bgmTxt2_.text = var_151_25

						arg_148_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_148_1.bgmTxt_.text = var_151_25
						arg_148_1.bgmTxt2_.text = var_151_25
					end

					if arg_148_1.bgmTimer then
						arg_148_1.bgmTimer:Stop()

						arg_148_1.bgmTimer = nil
					end

					if arg_148_1.settingData.show_music_name == 1 then
						arg_148_1.musicController:SetSelectedState("show")
						arg_148_1.musicAnimator_:Play("open", 0, 0)

						if arg_148_1.settingData.music_time ~= 0 then
							arg_148_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_148_1.settingData.music_time), function()
								if arg_148_1 == nil or isNil(arg_148_1.bgmTxt_) then
									return
								end

								arg_148_1.musicController:SetSelectedState("hide")
								arg_148_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_148_1.frameCnt_ <= 1 then
				arg_148_1.dialog_:SetActive(false)
			end

			local var_151_26 = 4
			local var_151_27 = 0.175

			if 4 < arg_148_1.time_ and arg_148_1.time_ <= var_151_26 + arg_151_0 then
				arg_148_1.talkMaxDuration = 0

				arg_148_1.dialog_:SetActive(true)

				arg_148_1.dialogCg_.alpha = 0

				local var_151_28 = LeanTween.value(arg_148_1.dialog_, 0, 1, 0.3)

				var_151_28:setOnUpdate(LuaHelper.FloatAction(function(arg_153_0)
					arg_148_1.dialogCg_.alpha = arg_153_0
				end))
				var_151_28:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_148_1.dialog_)
					var_151_28:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_148_1.duration_ = arg_148_1.duration_ + 0.3

				SetActive(arg_148_1.leftNameGo_, true)

				arg_148_1.leftNameTxt_.text = arg_148_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_148_1.leftNameTxt_.transform)

				arg_148_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_148_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_148_1:RecordName(arg_148_1.leftNameTxt_.text)
				SetActive(arg_148_1.iconTrs_.gameObject, true)
				arg_148_1.iconController_:SetSelectedState("hero")

				arg_148_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_148_1.callingController_:SetSelectedState("normal")

				arg_148_1.keyicon_.color = Color.New(1, 1, 1)
				arg_148_1.icon_.color = Color.New(1, 1, 1)

				local var_151_29 = arg_148_1:FormatText(arg_148_1:GetWordFromCfg(302031039).content)

				arg_148_1.text_.text = var_151_29

				LuaForUtil.ClearLinePrefixSymbol(arg_148_1.text_)

				local var_151_31 = 7 <= 0 and var_151_27 or var_151_27 * (utf8.len(var_151_29) / 7)

				if (7 <= 0 and var_151_27 or var_151_27 * (utf8.len(var_151_29) / 7)) > 0 and var_151_27 < var_151_31 then
					arg_148_1.talkMaxDuration = var_151_31
					var_151_26 = var_151_26 + 0.3

					if var_151_31 + var_151_26 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_31 + var_151_26
					end
				end

				arg_148_1.text_.text = var_151_29
				arg_148_1.typewritter.percent = 0

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(false)
				arg_148_1:RecordContent(arg_148_1.text_.text)
			end

			local var_151_32 = var_151_26 + 0.3
			local var_151_33 = math.max(var_151_27, arg_148_1.talkMaxDuration)

			if var_151_26 + 0.3 <= arg_148_1.time_ and arg_148_1.time_ < var_151_32 + var_151_33 then
				arg_148_1.typewritter.percent = (arg_148_1.time_ - var_151_32) / var_151_33

				arg_148_1.typewritter:SetDirty()
			end

			if arg_148_1.time_ >= var_151_32 + var_151_33 and arg_148_1.time_ < var_151_32 + var_151_33 + arg_151_0 then
				arg_148_1.typewritter.percent = 1

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(true)
			end
		end

		arg_148_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1166ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_148_1:InitPlayNodeList()
	end,
	Play302031040 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 302031040
		arg_155_1.duration_ = 5

		SetActive(arg_155_1.tipsGo_, false)

		function arg_155_1.onSingleLineFinish_()
			arg_155_1.onSingleLineUpdate_ = nil
			arg_155_1.onSingleLineFinish_ = nil
			arg_155_1.state_ = "waiting"
		end

		function arg_155_1.playNext_(arg_157_0)
			if arg_157_0 == 1 then
				arg_155_0:Play302031041(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			local var_158_0 = 1.575

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, false)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_1 = arg_155_1:FormatText(arg_155_1:GetWordFromCfg(302031040).content)

				arg_155_1.text_.text = var_158_1

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_3 = 63 <= 0 and var_158_0 or var_158_0 * (utf8.len(var_158_1) / 63)

				if (63 <= 0 and var_158_0 or var_158_0 * (utf8.len(var_158_1) / 63)) > 0 and var_158_0 < var_158_3 then
					arg_155_1.talkMaxDuration = var_158_3

					if var_158_3 + 0 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_3 + 0
					end
				end

				arg_155_1.text_.text = var_158_1
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)
				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_4 = math.max(var_158_0, arg_155_1.talkMaxDuration)

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_4 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - 0) / var_158_4

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= 0 + var_158_4 and arg_155_1.time_ < 0 + var_158_4 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {}

		arg_155_1:InitPlayNodeList()
	end,
	Play302031041 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 302031041
		arg_159_1.duration_ = 5

		SetActive(arg_159_1.tipsGo_, false)

		function arg_159_1.onSingleLineFinish_()
			arg_159_1.onSingleLineUpdate_ = nil
			arg_159_1.onSingleLineFinish_ = nil
			arg_159_1.state_ = "waiting"
		end

		function arg_159_1.playNext_(arg_161_0)
			if arg_161_0 == 1 then
				arg_159_0:Play302031042(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			local var_162_0 = 0.375

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, true)

				arg_159_1.leftNameTxt_.text = arg_159_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_159_1.leftNameTxt_.transform)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1.leftNameTxt_.text)
				SetActive(arg_159_1.iconTrs_.gameObject, true)
				arg_159_1.iconController_:SetSelectedState("hero")

				arg_159_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_159_1.callingController_:SetSelectedState("normal")

				arg_159_1.keyicon_.color = Color.New(1, 1, 1)
				arg_159_1.icon_.color = Color.New(1, 1, 1)

				local var_162_1 = arg_159_1:FormatText(arg_159_1:GetWordFromCfg(302031041).content)

				arg_159_1.text_.text = var_162_1

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_3 = 15 <= 0 and var_162_0 or var_162_0 * (utf8.len(var_162_1) / 15)

				if (15 <= 0 and var_162_0 or var_162_0 * (utf8.len(var_162_1) / 15)) > 0 and var_162_0 < var_162_3 then
					arg_159_1.talkMaxDuration = var_162_3

					if var_162_3 + 0 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_3 + 0
					end
				end

				arg_159_1.text_.text = var_162_1
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)
				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_4 = math.max(var_162_0, arg_159_1.talkMaxDuration)

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_4 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - 0) / var_162_4

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= 0 + var_162_4 and arg_159_1.time_ < 0 + var_162_4 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {}

		arg_159_1:InitPlayNodeList()
	end,
	Play302031042 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 302031042
		arg_163_1.duration_ = 6.63

		local var_163_0 = {
			zh = 6.633,
			ja = 1.999999999999
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
				arg_163_0:Play302031043(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 then
				arg_163_1.var_.moveOldPos1166ui_story = arg_163_1.actors_["1166ui_story"].transform.localPosition

				local var_166_0 = GameObjectTools.GetOrAddComponent(arg_163_1.actors_["1166ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_166_0 then
					var_166_0:EnableDynamicBone(false)
				end
			end

			local var_166_1 = 0.001

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_1 then
				arg_163_1.actors_["1166ui_story"].transform.localPosition = Vector3.Lerp(arg_163_1.var_.moveOldPos1166ui_story, Vector3.New(0, -0.75, -6.25), (arg_163_1.time_ - 0) / var_166_1)
				arg_163_1.actors_["1166ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_163_1.actors_["1166ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_163_1.actors_["1166ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_163_1.actors_["1166ui_story"].transform.position).z)
				arg_163_1.actors_["1166ui_story"].transform.localEulerAngles.z = 0
				arg_163_1.actors_["1166ui_story"].transform.localEulerAngles.x = 0
				arg_163_1.actors_["1166ui_story"].transform.localEulerAngles = arg_163_1.actors_["1166ui_story"].transform.localEulerAngles
			end

			if arg_163_1.time_ >= 0 + var_166_1 and arg_163_1.time_ < 0 + var_166_1 + arg_166_0 then
				arg_163_1.actors_["1166ui_story"].transform.localPosition = Vector3.New(0, -0.75, -6.25)
				arg_163_1.actors_["1166ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_163_1.actors_["1166ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_163_1.actors_["1166ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_163_1.actors_["1166ui_story"].transform.position).z)
				arg_163_1.actors_["1166ui_story"].transform.localEulerAngles.z = 0
				arg_163_1.actors_["1166ui_story"].transform.localEulerAngles.x = 0
				arg_163_1.actors_["1166ui_story"].transform.localEulerAngles = arg_163_1.actors_["1166ui_story"].transform.localEulerAngles

				local var_166_2 = GameObjectTools.GetOrAddComponent(arg_163_1.actors_["1166ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_166_2 then
					var_166_2:EnableDynamicBone(true)
				end
			end

			local var_166_3 = arg_163_1.actors_["1166ui_story"]

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 and not isNil(var_166_3) and arg_163_1.var_.characterEffect1166ui_story == nil then
				arg_163_1.var_.characterEffect1166ui_story = var_166_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_166_4 = 0.200000002980232

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_4 and not isNil(var_166_3) then
				if arg_163_1.var_.characterEffect1166ui_story and not isNil(var_166_3) then
					arg_163_1.var_.characterEffect1166ui_story.fillFlat = false
				end
			end

			if arg_163_1.time_ >= 0 + var_166_4 and arg_163_1.time_ < 0 + var_166_4 + arg_166_0 and not isNil(var_166_3) and arg_163_1.var_.characterEffect1166ui_story then
				arg_163_1.var_.characterEffect1166ui_story.fillFlat = false
			end

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 then
				arg_163_1:PlayTimeline("1166ui_story", "StoryTimeline/CharAction/story1166/story1166action/1166action1_1")
			end

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 then
				arg_163_1:PlayTimeline("1166ui_story", "StoryTimeline/CharAction/public_expression/expr_wuganB", "EmotionTimelineAnimator")
			end

			local var_166_6 = 0
			local var_166_7 = 0.775

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= var_166_6 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, true)

				arg_163_1.leftNameTxt_.text = arg_163_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_163_1.leftNameTxt_.transform)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1.leftNameTxt_.text)
				SetActive(arg_163_1.iconTrs_.gameObject, false)
				arg_163_1.callingController_:SetSelectedState("normal")

				local var_166_8 = arg_163_1:GetWordFromCfg(302031042)
				local var_166_9 = arg_163_1:FormatText(var_166_8.content)

				arg_163_1.text_.text = var_166_9

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_11 = 31 <= 0 and var_166_7 or var_166_7 * (utf8.len(var_166_9) / 31)

				if (31 <= 0 and var_166_7 or var_166_7 * (utf8.len(var_166_9) / 31)) > 0 and var_166_7 < var_166_11 then
					arg_163_1.talkMaxDuration = var_166_11

					if var_166_11 + var_166_6 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_11 + var_166_6
					end
				end

				arg_163_1.text_.text = var_166_9
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302031", "302031042", "story_v_out_302031.awb") ~= 0 then
					local var_166_12 = manager.audio:GetVoiceLength("story_v_out_302031", "302031042", "story_v_out_302031.awb") / 1000

					if var_166_12 + var_166_6 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_12 + var_166_6
					end

					if var_166_8.prefab_name ~= "" and arg_163_1.actors_[var_166_8.prefab_name] ~= nil then
						local var_166_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_163_1.actors_[var_166_8.prefab_name].transform, "story_v_out_302031", "302031042", "story_v_out_302031.awb")

						arg_163_1:RecordAudio("302031042", var_166_13)
						arg_163_1:RecordAudio("302031042", var_166_13)
					else
						arg_163_1:AudioAction("play", "voice", "story_v_out_302031", "302031042", "story_v_out_302031.awb")
					end

					arg_163_1:RecordHistoryTalkVoice("story_v_out_302031", "302031042", "story_v_out_302031.awb")
				end

				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_14 = math.max(var_166_7, arg_163_1.talkMaxDuration)

			if var_166_6 <= arg_163_1.time_ and arg_163_1.time_ < var_166_6 + var_166_14 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - var_166_6) / var_166_14

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= var_166_6 + var_166_14 and arg_163_1.time_ < var_166_6 + var_166_14 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1166ui_story",
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
	Play302031043 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 302031043
		arg_167_1.duration_ = 5

		SetActive(arg_167_1.tipsGo_, false)

		function arg_167_1.onSingleLineFinish_()
			arg_167_1.onSingleLineUpdate_ = nil
			arg_167_1.onSingleLineFinish_ = nil
			arg_167_1.state_ = "waiting"
		end

		function arg_167_1.playNext_(arg_169_0)
			if arg_169_0 == 1 then
				arg_167_0:Play302031044(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 and not isNil(arg_167_1.actors_["1166ui_story"]) and arg_167_1.var_.characterEffect1166ui_story == nil then
				arg_167_1.var_.characterEffect1166ui_story = arg_167_1.actors_["1166ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_170_0 = 0.200000002980232

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_0 and not isNil(arg_167_1.actors_["1166ui_story"]) then
				if arg_167_1.var_.characterEffect1166ui_story and not isNil(arg_167_1.actors_["1166ui_story"]) then
					arg_167_1.var_.characterEffect1166ui_story.fillFlat = true
					arg_167_1.var_.characterEffect1166ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_167_1.time_ - 0) / var_170_0)
				end
			end

			if arg_167_1.time_ >= 0 + var_170_0 and arg_167_1.time_ < 0 + var_170_0 + arg_170_0 and not isNil(arg_167_1.actors_["1166ui_story"]) and arg_167_1.var_.characterEffect1166ui_story then
				arg_167_1.var_.characterEffect1166ui_story.fillFlat = true
				arg_167_1.var_.characterEffect1166ui_story.fillRatio = 0.5
			end

			local var_170_1 = 0
			local var_170_2 = 0.875

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= var_170_1 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, true)

				arg_167_1.leftNameTxt_.text = arg_167_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, true)
				arg_167_1.iconController_:SetSelectedState("hero")

				arg_167_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_167_1.callingController_:SetSelectedState("normal")

				arg_167_1.keyicon_.color = Color.New(1, 1, 1)
				arg_167_1.icon_.color = Color.New(1, 1, 1)

				local var_170_3 = arg_167_1:FormatText(arg_167_1:GetWordFromCfg(302031043).content)

				arg_167_1.text_.text = var_170_3

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_5 = 35 <= 0 and var_170_2 or var_170_2 * (utf8.len(var_170_3) / 35)

				if (35 <= 0 and var_170_2 or var_170_2 * (utf8.len(var_170_3) / 35)) > 0 and var_170_2 < var_170_5 then
					arg_167_1.talkMaxDuration = var_170_5

					if var_170_5 + var_170_1 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_5 + var_170_1
					end
				end

				arg_167_1.text_.text = var_170_3
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)
				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_6 = math.max(var_170_2, arg_167_1.talkMaxDuration)

			if var_170_1 <= arg_167_1.time_ and arg_167_1.time_ < var_170_1 + var_170_6 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - var_170_1) / var_170_6

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= var_170_1 + var_170_6 and arg_167_1.time_ < var_170_1 + var_170_6 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {}

		arg_167_1:InitPlayNodeList()
	end,
	Play302031044 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 302031044
		arg_171_1.duration_ = 7.47

		local var_171_0 = {
			zh = 5.766,
			ja = 7.466
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
				arg_171_0:Play302031045(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 then
				arg_171_1.var_.moveOldPos1084ui_story = arg_171_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_174_0 = 0.001

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_0 then
				arg_171_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_171_1.var_.moveOldPos1084ui_story, Vector3.New(0.7, -0.97, -6), (arg_171_1.time_ - 0) / var_174_0)
				arg_171_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_171_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_171_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_171_1.actors_["1084ui_story"].transform.position).z)
				arg_171_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_171_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_171_1.actors_["1084ui_story"].transform.localEulerAngles = arg_171_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_171_1.time_ >= 0 + var_174_0 and arg_171_1.time_ < 0 + var_174_0 + arg_174_0 then
				arg_171_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0.7, -0.97, -6)
				arg_171_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_171_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_171_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_171_1.actors_["1084ui_story"].transform.position).z)
				arg_171_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_171_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_171_1.actors_["1084ui_story"].transform.localEulerAngles = arg_171_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_174_1 = arg_171_1.actors_["1166ui_story"].transform

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 then
				arg_171_1.var_.moveOldPos1166ui_story = var_174_1.localPosition

				local var_174_2 = GameObjectTools.GetOrAddComponent(var_174_1.gameObject, typeof(DynamicBoneHelper))

				if var_174_2 then
					var_174_2:EnableDynamicBone(false)
				end
			end

			local var_174_3 = 0.001

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_3 then
				var_174_1.localPosition = Vector3.Lerp(arg_171_1.var_.moveOldPos1166ui_story, Vector3.New(-0.7, -0.75, -6.25), (arg_171_1.time_ - 0) / var_174_3)
				var_174_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_174_1.position).x, (manager.ui.mainCamera.transform.position - var_174_1.position).y, (manager.ui.mainCamera.transform.position - var_174_1.position).z)
				var_174_1.localEulerAngles.z = 0
				var_174_1.localEulerAngles.x = 0
				var_174_1.localEulerAngles = var_174_1.localEulerAngles
			end

			if arg_171_1.time_ >= 0 + var_174_3 and arg_171_1.time_ < 0 + var_174_3 + arg_174_0 then
				var_174_1.localPosition = Vector3.New(-0.7, -0.75, -6.25)
				var_174_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_174_1.position).x, (manager.ui.mainCamera.transform.position - var_174_1.position).y, (manager.ui.mainCamera.transform.position - var_174_1.position).z)
				var_174_1.localEulerAngles.z = 0
				var_174_1.localEulerAngles.x = 0
				var_174_1.localEulerAngles = var_174_1.localEulerAngles

				local var_174_4 = GameObjectTools.GetOrAddComponent(var_174_1.gameObject, typeof(DynamicBoneHelper))

				if var_174_4 then
					var_174_4:EnableDynamicBone(true)
				end
			end

			local var_174_5 = arg_171_1.actors_["1084ui_story"]

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 and not isNil(var_174_5) and arg_171_1.var_.characterEffect1084ui_story == nil then
				arg_171_1.var_.characterEffect1084ui_story = var_174_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_174_6 = 0.200000002980232

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_6 and not isNil(var_174_5) then
				if arg_171_1.var_.characterEffect1084ui_story and not isNil(var_174_5) then
					arg_171_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_171_1.time_ >= 0 + var_174_6 and arg_171_1.time_ < 0 + var_174_6 + arg_174_0 and not isNil(var_174_5) and arg_171_1.var_.characterEffect1084ui_story then
				arg_171_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 then
				arg_171_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_1")
			end

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 then
				arg_171_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_174_8 = 0
			local var_174_9 = 0.625

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= var_174_8 + arg_174_0 then
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

				local var_174_10 = arg_171_1:GetWordFromCfg(302031044)
				local var_174_11 = arg_171_1:FormatText(var_174_10.content)

				arg_171_1.text_.text = var_174_11

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_13 = 25 <= 0 and var_174_9 or var_174_9 * (utf8.len(var_174_11) / 25)

				if (25 <= 0 and var_174_9 or var_174_9 * (utf8.len(var_174_11) / 25)) > 0 and var_174_9 < var_174_13 then
					arg_171_1.talkMaxDuration = var_174_13

					if var_174_13 + var_174_8 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_13 + var_174_8
					end
				end

				arg_171_1.text_.text = var_174_11
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302031", "302031044", "story_v_out_302031.awb") ~= 0 then
					local var_174_14 = manager.audio:GetVoiceLength("story_v_out_302031", "302031044", "story_v_out_302031.awb") / 1000

					if var_174_14 + var_174_8 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_14 + var_174_8
					end

					if var_174_10.prefab_name ~= "" and arg_171_1.actors_[var_174_10.prefab_name] ~= nil then
						local var_174_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_171_1.actors_[var_174_10.prefab_name].transform, "story_v_out_302031", "302031044", "story_v_out_302031.awb")

						arg_171_1:RecordAudio("302031044", var_174_15)
						arg_171_1:RecordAudio("302031044", var_174_15)
					else
						arg_171_1:AudioAction("play", "voice", "story_v_out_302031", "302031044", "story_v_out_302031.awb")
					end

					arg_171_1:RecordHistoryTalkVoice("story_v_out_302031", "302031044", "story_v_out_302031.awb")
				end

				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_16 = math.max(var_174_9, arg_171_1.talkMaxDuration)

			if var_174_8 <= arg_171_1.time_ and arg_171_1.time_ < var_174_8 + var_174_16 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - var_174_8) / var_174_16

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= var_174_8 + var_174_16 and arg_171_1.time_ < var_174_8 + var_174_16 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {
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
				actorName = "1166ui_story",
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
	Play302031045 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 302031045
		arg_175_1.duration_ = 5

		SetActive(arg_175_1.tipsGo_, false)

		function arg_175_1.onSingleLineFinish_()
			arg_175_1.onSingleLineUpdate_ = nil
			arg_175_1.onSingleLineFinish_ = nil
			arg_175_1.state_ = "waiting"
		end

		function arg_175_1.playNext_(arg_177_0)
			if arg_177_0 == 1 then
				arg_175_0:Play302031046(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 then
				arg_175_1.var_.moveOldPos1084ui_story = arg_175_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_178_0 = 0.001

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_0 then
				arg_175_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_175_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_175_1.time_ - 0) / var_178_0)
				arg_175_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_175_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_175_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_175_1.actors_["1084ui_story"].transform.position).z)
				arg_175_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_175_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_175_1.actors_["1084ui_story"].transform.localEulerAngles = arg_175_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_175_1.time_ >= 0 + var_178_0 and arg_175_1.time_ < 0 + var_178_0 + arg_178_0 then
				arg_175_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_175_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_175_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_175_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_175_1.actors_["1084ui_story"].transform.position).z)
				arg_175_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_175_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_175_1.actors_["1084ui_story"].transform.localEulerAngles = arg_175_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_178_1 = arg_175_1.actors_["1166ui_story"].transform

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 then
				arg_175_1.var_.moveOldPos1166ui_story = var_178_1.localPosition

				local var_178_2 = GameObjectTools.GetOrAddComponent(var_178_1.gameObject, typeof(DynamicBoneHelper))

				if var_178_2 then
					var_178_2:EnableDynamicBone(false)
				end
			end

			local var_178_3 = 0.001

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_3 then
				var_178_1.localPosition = Vector3.Lerp(arg_175_1.var_.moveOldPos1166ui_story, Vector3.New(0, 100, 0), (arg_175_1.time_ - 0) / var_178_3)
				var_178_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_178_1.position).x, (manager.ui.mainCamera.transform.position - var_178_1.position).y, (manager.ui.mainCamera.transform.position - var_178_1.position).z)
				var_178_1.localEulerAngles.z = 0
				var_178_1.localEulerAngles.x = 0
				var_178_1.localEulerAngles = var_178_1.localEulerAngles
			end

			if arg_175_1.time_ >= 0 + var_178_3 and arg_175_1.time_ < 0 + var_178_3 + arg_178_0 then
				var_178_1.localPosition = Vector3.New(0, 100, 0)
				var_178_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_178_1.position).x, (manager.ui.mainCamera.transform.position - var_178_1.position).y, (manager.ui.mainCamera.transform.position - var_178_1.position).z)
				var_178_1.localEulerAngles.z = 0
				var_178_1.localEulerAngles.x = 0
				var_178_1.localEulerAngles = var_178_1.localEulerAngles

				local var_178_4 = GameObjectTools.GetOrAddComponent(var_178_1.gameObject, typeof(DynamicBoneHelper))

				if var_178_4 then
					var_178_4:EnableDynamicBone(true)
				end
			end

			local var_178_5 = arg_175_1.actors_["1084ui_story"]

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 and not isNil(var_178_5) and arg_175_1.var_.characterEffect1084ui_story == nil then
				arg_175_1.var_.characterEffect1084ui_story = var_178_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_178_6 = 0.200000002980232

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_6 and not isNil(var_178_5) then
				if arg_175_1.var_.characterEffect1084ui_story and not isNil(var_178_5) then
					arg_175_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_175_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_175_1.time_ - 0) / var_178_6)
				end
			end

			if arg_175_1.time_ >= 0 + var_178_6 and arg_175_1.time_ < 0 + var_178_6 + arg_178_0 and not isNil(var_178_5) and arg_175_1.var_.characterEffect1084ui_story then
				arg_175_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_175_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_178_7 = 0
			local var_178_8 = 1.325

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= var_178_7 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, false)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_175_1.iconTrs_.gameObject, false)
				arg_175_1.callingController_:SetSelectedState("normal")

				local var_178_9 = arg_175_1:FormatText(arg_175_1:GetWordFromCfg(302031045).content)

				arg_175_1.text_.text = var_178_9

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_11 = 53 <= 0 and var_178_8 or var_178_8 * (utf8.len(var_178_9) / 53)

				if (53 <= 0 and var_178_8 or var_178_8 * (utf8.len(var_178_9) / 53)) > 0 and var_178_8 < var_178_11 then
					arg_175_1.talkMaxDuration = var_178_11

					if var_178_11 + var_178_7 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_11 + var_178_7
					end
				end

				arg_175_1.text_.text = var_178_9
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)
				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_12 = math.max(var_178_8, arg_175_1.talkMaxDuration)

			if var_178_7 <= arg_175_1.time_ and arg_175_1.time_ < var_178_7 + var_178_12 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - var_178_7) / var_178_12

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= var_178_7 + var_178_12 and arg_175_1.time_ < var_178_7 + var_178_12 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {
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
				actorName = "1166ui_story",
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
	Play302031046 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 302031046
		arg_179_1.duration_ = 2.13

		local var_179_0 = {
			zh = 2.133,
			ja = 1.999999999999
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
				arg_179_0:Play302031047(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 then
				arg_179_1.var_.moveOldPos1166ui_story = arg_179_1.actors_["1166ui_story"].transform.localPosition

				local var_182_0 = GameObjectTools.GetOrAddComponent(arg_179_1.actors_["1166ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_182_0 then
					var_182_0:EnableDynamicBone(false)
				end
			end

			local var_182_1 = 0.001

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_1 then
				arg_179_1.actors_["1166ui_story"].transform.localPosition = Vector3.Lerp(arg_179_1.var_.moveOldPos1166ui_story, Vector3.New(0, -0.75, -6.25), (arg_179_1.time_ - 0) / var_182_1)
				arg_179_1.actors_["1166ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_179_1.actors_["1166ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_179_1.actors_["1166ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_179_1.actors_["1166ui_story"].transform.position).z)
				arg_179_1.actors_["1166ui_story"].transform.localEulerAngles.z = 0
				arg_179_1.actors_["1166ui_story"].transform.localEulerAngles.x = 0
				arg_179_1.actors_["1166ui_story"].transform.localEulerAngles = arg_179_1.actors_["1166ui_story"].transform.localEulerAngles
			end

			if arg_179_1.time_ >= 0 + var_182_1 and arg_179_1.time_ < 0 + var_182_1 + arg_182_0 then
				arg_179_1.actors_["1166ui_story"].transform.localPosition = Vector3.New(0, -0.75, -6.25)
				arg_179_1.actors_["1166ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_179_1.actors_["1166ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_179_1.actors_["1166ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_179_1.actors_["1166ui_story"].transform.position).z)
				arg_179_1.actors_["1166ui_story"].transform.localEulerAngles.z = 0
				arg_179_1.actors_["1166ui_story"].transform.localEulerAngles.x = 0
				arg_179_1.actors_["1166ui_story"].transform.localEulerAngles = arg_179_1.actors_["1166ui_story"].transform.localEulerAngles

				local var_182_2 = GameObjectTools.GetOrAddComponent(arg_179_1.actors_["1166ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_182_2 then
					var_182_2:EnableDynamicBone(true)
				end
			end

			local var_182_3 = arg_179_1.actors_["1166ui_story"]

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 and not isNil(var_182_3) and arg_179_1.var_.characterEffect1166ui_story == nil then
				arg_179_1.var_.characterEffect1166ui_story = var_182_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_182_4 = 0.200000002980232

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_4 and not isNil(var_182_3) then
				if arg_179_1.var_.characterEffect1166ui_story and not isNil(var_182_3) then
					arg_179_1.var_.characterEffect1166ui_story.fillFlat = false
				end
			end

			if arg_179_1.time_ >= 0 + var_182_4 and arg_179_1.time_ < 0 + var_182_4 + arg_182_0 and not isNil(var_182_3) and arg_179_1.var_.characterEffect1166ui_story then
				arg_179_1.var_.characterEffect1166ui_story.fillFlat = false
			end

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 then
				arg_179_1:PlayTimeline("1166ui_story", "StoryTimeline/CharAction/story1166/story1166action/1166action4_1")
			end

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 then
				arg_179_1:PlayTimeline("1166ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiB", "EmotionTimelineAnimator")
			end

			local var_182_6 = 0
			local var_182_7 = 0.25

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= var_182_6 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, true)

				arg_179_1.leftNameTxt_.text = arg_179_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_179_1.leftNameTxt_.transform)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1.leftNameTxt_.text)
				SetActive(arg_179_1.iconTrs_.gameObject, false)
				arg_179_1.callingController_:SetSelectedState("normal")

				local var_182_8 = arg_179_1:GetWordFromCfg(302031046)
				local var_182_9 = arg_179_1:FormatText(var_182_8.content)

				arg_179_1.text_.text = var_182_9

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_11 = 10 <= 0 and var_182_7 or var_182_7 * (utf8.len(var_182_9) / 10)

				if (10 <= 0 and var_182_7 or var_182_7 * (utf8.len(var_182_9) / 10)) > 0 and var_182_7 < var_182_11 then
					arg_179_1.talkMaxDuration = var_182_11

					if var_182_11 + var_182_6 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_11 + var_182_6
					end
				end

				arg_179_1.text_.text = var_182_9
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302031", "302031046", "story_v_out_302031.awb") ~= 0 then
					local var_182_12 = manager.audio:GetVoiceLength("story_v_out_302031", "302031046", "story_v_out_302031.awb") / 1000

					if var_182_12 + var_182_6 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_12 + var_182_6
					end

					if var_182_8.prefab_name ~= "" and arg_179_1.actors_[var_182_8.prefab_name] ~= nil then
						local var_182_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_179_1.actors_[var_182_8.prefab_name].transform, "story_v_out_302031", "302031046", "story_v_out_302031.awb")

						arg_179_1:RecordAudio("302031046", var_182_13)
						arg_179_1:RecordAudio("302031046", var_182_13)
					else
						arg_179_1:AudioAction("play", "voice", "story_v_out_302031", "302031046", "story_v_out_302031.awb")
					end

					arg_179_1:RecordHistoryTalkVoice("story_v_out_302031", "302031046", "story_v_out_302031.awb")
				end

				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_14 = math.max(var_182_7, arg_179_1.talkMaxDuration)

			if var_182_6 <= arg_179_1.time_ and arg_179_1.time_ < var_182_6 + var_182_14 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - var_182_6) / var_182_14

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= var_182_6 + var_182_14 and arg_179_1.time_ < var_182_6 + var_182_14 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1166ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_179_1:InitPlayNodeList()
	end,
	Play302031047 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 302031047
		arg_183_1.duration_ = 5

		SetActive(arg_183_1.tipsGo_, false)

		function arg_183_1.onSingleLineFinish_()
			arg_183_1.onSingleLineUpdate_ = nil
			arg_183_1.onSingleLineFinish_ = nil
			arg_183_1.state_ = "waiting"
		end

		function arg_183_1.playNext_(arg_185_0)
			if arg_185_0 == 1 then
				arg_183_0:Play302031048(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 and not isNil(arg_183_1.actors_["1166ui_story"]) and arg_183_1.var_.characterEffect1166ui_story == nil then
				arg_183_1.var_.characterEffect1166ui_story = arg_183_1.actors_["1166ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_186_0 = 0.200000002980232

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_0 and not isNil(arg_183_1.actors_["1166ui_story"]) then
				if arg_183_1.var_.characterEffect1166ui_story and not isNil(arg_183_1.actors_["1166ui_story"]) then
					arg_183_1.var_.characterEffect1166ui_story.fillFlat = true
					arg_183_1.var_.characterEffect1166ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_183_1.time_ - 0) / var_186_0)
				end
			end

			if arg_183_1.time_ >= 0 + var_186_0 and arg_183_1.time_ < 0 + var_186_0 + arg_186_0 and not isNil(arg_183_1.actors_["1166ui_story"]) and arg_183_1.var_.characterEffect1166ui_story then
				arg_183_1.var_.characterEffect1166ui_story.fillFlat = true
				arg_183_1.var_.characterEffect1166ui_story.fillRatio = 0.5
			end

			local var_186_1 = 0
			local var_186_2 = 0.275

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= var_186_1 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, true)

				arg_183_1.leftNameTxt_.text = arg_183_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_183_1.leftNameTxt_.transform)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1.leftNameTxt_.text)
				SetActive(arg_183_1.iconTrs_.gameObject, true)
				arg_183_1.iconController_:SetSelectedState("hero")

				arg_183_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_183_1.callingController_:SetSelectedState("normal")

				arg_183_1.keyicon_.color = Color.New(1, 1, 1)
				arg_183_1.icon_.color = Color.New(1, 1, 1)

				local var_186_3 = arg_183_1:FormatText(arg_183_1:GetWordFromCfg(302031047).content)

				arg_183_1.text_.text = var_186_3

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_5 = 11 <= 0 and var_186_2 or var_186_2 * (utf8.len(var_186_3) / 11)

				if (11 <= 0 and var_186_2 or var_186_2 * (utf8.len(var_186_3) / 11)) > 0 and var_186_2 < var_186_5 then
					arg_183_1.talkMaxDuration = var_186_5

					if var_186_5 + var_186_1 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_5 + var_186_1
					end
				end

				arg_183_1.text_.text = var_186_3
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)
				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_6 = math.max(var_186_2, arg_183_1.talkMaxDuration)

			if var_186_1 <= arg_183_1.time_ and arg_183_1.time_ < var_186_1 + var_186_6 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - var_186_1) / var_186_6

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= var_186_1 + var_186_6 and arg_183_1.time_ < var_186_1 + var_186_6 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {}

		arg_183_1:InitPlayNodeList()
	end,
	Play302031048 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 302031048
		arg_187_1.duration_ = 4.2

		local var_187_0 = {
			zh = 4.2,
			ja = 1.333
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
				arg_187_0:Play302031049(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 and not isNil(arg_187_1.actors_["1166ui_story"]) and arg_187_1.var_.characterEffect1166ui_story == nil then
				arg_187_1.var_.characterEffect1166ui_story = arg_187_1.actors_["1166ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_190_0 = 0.200000002980232

			if 0 <= arg_187_1.time_ and arg_187_1.time_ < 0 + var_190_0 and not isNil(arg_187_1.actors_["1166ui_story"]) then
				if arg_187_1.var_.characterEffect1166ui_story and not isNil(arg_187_1.actors_["1166ui_story"]) then
					arg_187_1.var_.characterEffect1166ui_story.fillFlat = false
				end
			end

			if arg_187_1.time_ >= 0 + var_190_0 and arg_187_1.time_ < 0 + var_190_0 + arg_190_0 and not isNil(arg_187_1.actors_["1166ui_story"]) and arg_187_1.var_.characterEffect1166ui_story then
				arg_187_1.var_.characterEffect1166ui_story.fillFlat = false
			end

			local var_190_2 = 0
			local var_190_3 = 0.525

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= var_190_2 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, true)

				arg_187_1.leftNameTxt_.text = arg_187_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_187_1.leftNameTxt_.transform)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1.leftNameTxt_.text)
				SetActive(arg_187_1.iconTrs_.gameObject, false)
				arg_187_1.callingController_:SetSelectedState("normal")

				local var_190_4 = arg_187_1:GetWordFromCfg(302031048)
				local var_190_5 = arg_187_1:FormatText(var_190_4.content)

				arg_187_1.text_.text = var_190_5

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_7 = 21 <= 0 and var_190_3 or var_190_3 * (utf8.len(var_190_5) / 21)

				if (21 <= 0 and var_190_3 or var_190_3 * (utf8.len(var_190_5) / 21)) > 0 and var_190_3 < var_190_7 then
					arg_187_1.talkMaxDuration = var_190_7

					if var_190_7 + var_190_2 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_7 + var_190_2
					end
				end

				arg_187_1.text_.text = var_190_5
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302031", "302031048", "story_v_out_302031.awb") ~= 0 then
					local var_190_8 = manager.audio:GetVoiceLength("story_v_out_302031", "302031048", "story_v_out_302031.awb") / 1000

					if var_190_8 + var_190_2 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_8 + var_190_2
					end

					if var_190_4.prefab_name ~= "" and arg_187_1.actors_[var_190_4.prefab_name] ~= nil then
						local var_190_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_187_1.actors_[var_190_4.prefab_name].transform, "story_v_out_302031", "302031048", "story_v_out_302031.awb")

						arg_187_1:RecordAudio("302031048", var_190_9)
						arg_187_1:RecordAudio("302031048", var_190_9)
					else
						arg_187_1:AudioAction("play", "voice", "story_v_out_302031", "302031048", "story_v_out_302031.awb")
					end

					arg_187_1:RecordHistoryTalkVoice("story_v_out_302031", "302031048", "story_v_out_302031.awb")
				end

				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_10 = math.max(var_190_3, arg_187_1.talkMaxDuration)

			if var_190_2 <= arg_187_1.time_ and arg_187_1.time_ < var_190_2 + var_190_10 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - var_190_2) / var_190_10

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= var_190_2 + var_190_10 and arg_187_1.time_ < var_190_2 + var_190_10 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {}

		arg_187_1:InitPlayNodeList()
	end,
	Play302031049 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 302031049
		arg_191_1.duration_ = 5

		SetActive(arg_191_1.tipsGo_, false)

		function arg_191_1.onSingleLineFinish_()
			arg_191_1.onSingleLineUpdate_ = nil
			arg_191_1.onSingleLineFinish_ = nil
			arg_191_1.state_ = "waiting"
		end

		function arg_191_1.playNext_(arg_193_0)
			if arg_193_0 == 1 then
				arg_191_0:Play302031050(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 then
				arg_191_1.var_.moveOldPos1166ui_story = arg_191_1.actors_["1166ui_story"].transform.localPosition

				local var_194_0 = GameObjectTools.GetOrAddComponent(arg_191_1.actors_["1166ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_194_0 then
					var_194_0:EnableDynamicBone(false)
				end
			end

			local var_194_1 = 0.001

			if 0 <= arg_191_1.time_ and arg_191_1.time_ < 0 + var_194_1 then
				arg_191_1.actors_["1166ui_story"].transform.localPosition = Vector3.Lerp(arg_191_1.var_.moveOldPos1166ui_story, Vector3.New(0, 100, 0), (arg_191_1.time_ - 0) / var_194_1)
				arg_191_1.actors_["1166ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_191_1.actors_["1166ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_191_1.actors_["1166ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_191_1.actors_["1166ui_story"].transform.position).z)
				arg_191_1.actors_["1166ui_story"].transform.localEulerAngles.z = 0
				arg_191_1.actors_["1166ui_story"].transform.localEulerAngles.x = 0
				arg_191_1.actors_["1166ui_story"].transform.localEulerAngles = arg_191_1.actors_["1166ui_story"].transform.localEulerAngles
			end

			if arg_191_1.time_ >= 0 + var_194_1 and arg_191_1.time_ < 0 + var_194_1 + arg_194_0 then
				arg_191_1.actors_["1166ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_191_1.actors_["1166ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_191_1.actors_["1166ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_191_1.actors_["1166ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_191_1.actors_["1166ui_story"].transform.position).z)
				arg_191_1.actors_["1166ui_story"].transform.localEulerAngles.z = 0
				arg_191_1.actors_["1166ui_story"].transform.localEulerAngles.x = 0
				arg_191_1.actors_["1166ui_story"].transform.localEulerAngles = arg_191_1.actors_["1166ui_story"].transform.localEulerAngles

				local var_194_2 = GameObjectTools.GetOrAddComponent(arg_191_1.actors_["1166ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_194_2 then
					var_194_2:EnableDynamicBone(true)
				end
			end

			local var_194_3 = arg_191_1.actors_["1166ui_story"]

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 and not isNil(var_194_3) and arg_191_1.var_.characterEffect1166ui_story == nil then
				arg_191_1.var_.characterEffect1166ui_story = var_194_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_194_4 = 0.200000002980232

			if 0 <= arg_191_1.time_ and arg_191_1.time_ < 0 + var_194_4 and not isNil(var_194_3) then
				if arg_191_1.var_.characterEffect1166ui_story and not isNil(var_194_3) then
					arg_191_1.var_.characterEffect1166ui_story.fillFlat = true
					arg_191_1.var_.characterEffect1166ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_191_1.time_ - 0) / var_194_4)
				end
			end

			if arg_191_1.time_ >= 0 + var_194_4 and arg_191_1.time_ < 0 + var_194_4 + arg_194_0 and not isNil(var_194_3) and arg_191_1.var_.characterEffect1166ui_story then
				arg_191_1.var_.characterEffect1166ui_story.fillFlat = true
				arg_191_1.var_.characterEffect1166ui_story.fillRatio = 0.5
			end

			local var_194_5 = 0
			local var_194_6 = 1.025

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= var_194_5 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, false)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_191_1.iconTrs_.gameObject, false)
				arg_191_1.callingController_:SetSelectedState("normal")

				local var_194_7 = arg_191_1:FormatText(arg_191_1:GetWordFromCfg(302031049).content)

				arg_191_1.text_.text = var_194_7

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_9 = 41 <= 0 and var_194_6 or var_194_6 * (utf8.len(var_194_7) / 41)

				if (41 <= 0 and var_194_6 or var_194_6 * (utf8.len(var_194_7) / 41)) > 0 and var_194_6 < var_194_9 then
					arg_191_1.talkMaxDuration = var_194_9

					if var_194_9 + var_194_5 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_9 + var_194_5
					end
				end

				arg_191_1.text_.text = var_194_7
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)
				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_10 = math.max(var_194_6, arg_191_1.talkMaxDuration)

			if var_194_5 <= arg_191_1.time_ and arg_191_1.time_ < var_194_5 + var_194_10 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - var_194_5) / var_194_10

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= var_194_5 + var_194_10 and arg_191_1.time_ < var_194_5 + var_194_10 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1166ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_191_1:InitPlayNodeList()
	end,
	Play302031050 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 302031050
		arg_195_1.duration_ = 5

		SetActive(arg_195_1.tipsGo_, false)

		function arg_195_1.onSingleLineFinish_()
			arg_195_1.onSingleLineUpdate_ = nil
			arg_195_1.onSingleLineFinish_ = nil
			arg_195_1.state_ = "waiting"
		end

		function arg_195_1.playNext_(arg_197_0)
			if arg_197_0 == 1 then
				arg_195_0:Play302031051(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			local var_198_0 = 1.775

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, false)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_195_1.iconTrs_.gameObject, false)
				arg_195_1.callingController_:SetSelectedState("normal")

				local var_198_1 = arg_195_1:FormatText(arg_195_1:GetWordFromCfg(302031050).content)

				arg_195_1.text_.text = var_198_1

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_3 = 71 <= 0 and var_198_0 or var_198_0 * (utf8.len(var_198_1) / 71)

				if (71 <= 0 and var_198_0 or var_198_0 * (utf8.len(var_198_1) / 71)) > 0 and var_198_0 < var_198_3 then
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
	Play302031051 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 302031051
		arg_199_1.duration_ = 5

		SetActive(arg_199_1.tipsGo_, false)

		function arg_199_1.onSingleLineFinish_()
			arg_199_1.onSingleLineUpdate_ = nil
			arg_199_1.onSingleLineFinish_ = nil
			arg_199_1.state_ = "waiting"
		end

		function arg_199_1.playNext_(arg_201_0)
			if arg_201_0 == 1 then
				arg_199_0:Play302031052(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			local var_202_0 = 0.175

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, true)

				arg_199_1.leftNameTxt_.text = arg_199_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_199_1.leftNameTxt_.transform)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1.leftNameTxt_.text)
				SetActive(arg_199_1.iconTrs_.gameObject, true)
				arg_199_1.iconController_:SetSelectedState("hero")

				arg_199_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_199_1.callingController_:SetSelectedState("normal")

				arg_199_1.keyicon_.color = Color.New(1, 1, 1)
				arg_199_1.icon_.color = Color.New(1, 1, 1)

				local var_202_1 = arg_199_1:FormatText(arg_199_1:GetWordFromCfg(302031051).content)

				arg_199_1.text_.text = var_202_1

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_3 = 7 <= 0 and var_202_0 or var_202_0 * (utf8.len(var_202_1) / 7)

				if (7 <= 0 and var_202_0 or var_202_0 * (utf8.len(var_202_1) / 7)) > 0 and var_202_0 < var_202_3 then
					arg_199_1.talkMaxDuration = var_202_3

					if var_202_3 + 0 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_3 + 0
					end
				end

				arg_199_1.text_.text = var_202_1
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)
				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_4 = math.max(var_202_0, arg_199_1.talkMaxDuration)

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_4 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - 0) / var_202_4

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= 0 + var_202_4 and arg_199_1.time_ < 0 + var_202_4 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {}

		arg_199_1:InitPlayNodeList()
	end,
	Play302031052 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 302031052
		arg_203_1.duration_ = 5.3

		local var_203_0 = {
			zh = 5.3,
			ja = 1.333
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
				arg_203_0:Play302031053(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				arg_203_1.var_.moveOldPos1166ui_story = arg_203_1.actors_["1166ui_story"].transform.localPosition

				local var_206_0 = GameObjectTools.GetOrAddComponent(arg_203_1.actors_["1166ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_206_0 then
					var_206_0:EnableDynamicBone(false)
				end
			end

			local var_206_1 = 0.001

			if 0 <= arg_203_1.time_ and arg_203_1.time_ < 0 + var_206_1 then
				arg_203_1.actors_["1166ui_story"].transform.localPosition = Vector3.Lerp(arg_203_1.var_.moveOldPos1166ui_story, Vector3.New(-0.7, -0.75, -6.25), (arg_203_1.time_ - 0) / var_206_1)
				arg_203_1.actors_["1166ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_203_1.actors_["1166ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_203_1.actors_["1166ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_203_1.actors_["1166ui_story"].transform.position).z)
				arg_203_1.actors_["1166ui_story"].transform.localEulerAngles.z = 0
				arg_203_1.actors_["1166ui_story"].transform.localEulerAngles.x = 0
				arg_203_1.actors_["1166ui_story"].transform.localEulerAngles = arg_203_1.actors_["1166ui_story"].transform.localEulerAngles
			end

			if arg_203_1.time_ >= 0 + var_206_1 and arg_203_1.time_ < 0 + var_206_1 + arg_206_0 then
				arg_203_1.actors_["1166ui_story"].transform.localPosition = Vector3.New(-0.7, -0.75, -6.25)
				arg_203_1.actors_["1166ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_203_1.actors_["1166ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_203_1.actors_["1166ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_203_1.actors_["1166ui_story"].transform.position).z)
				arg_203_1.actors_["1166ui_story"].transform.localEulerAngles.z = 0
				arg_203_1.actors_["1166ui_story"].transform.localEulerAngles.x = 0
				arg_203_1.actors_["1166ui_story"].transform.localEulerAngles = arg_203_1.actors_["1166ui_story"].transform.localEulerAngles

				local var_206_2 = GameObjectTools.GetOrAddComponent(arg_203_1.actors_["1166ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_206_2 then
					var_206_2:EnableDynamicBone(true)
				end
			end

			local var_206_3 = arg_203_1.actors_["1166ui_story"]

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 and not isNil(var_206_3) and arg_203_1.var_.characterEffect1166ui_story == nil then
				arg_203_1.var_.characterEffect1166ui_story = var_206_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_206_4 = 0.200000002980232

			if 0 <= arg_203_1.time_ and arg_203_1.time_ < 0 + var_206_4 and not isNil(var_206_3) then
				if arg_203_1.var_.characterEffect1166ui_story and not isNil(var_206_3) then
					arg_203_1.var_.characterEffect1166ui_story.fillFlat = false
				end
			end

			if arg_203_1.time_ >= 0 + var_206_4 and arg_203_1.time_ < 0 + var_206_4 + arg_206_0 and not isNil(var_206_3) and arg_203_1.var_.characterEffect1166ui_story then
				arg_203_1.var_.characterEffect1166ui_story.fillFlat = false
			end

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				arg_203_1:PlayTimeline("1166ui_story", "StoryTimeline/CharAction/story1166/story1166action/1166action1_1")
			end

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				arg_203_1:PlayTimeline("1166ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_206_6 = 0
			local var_206_7 = 0.55

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= var_206_6 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, true)

				arg_203_1.leftNameTxt_.text = arg_203_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_203_1.leftNameTxt_.transform)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1.leftNameTxt_.text)
				SetActive(arg_203_1.iconTrs_.gameObject, false)
				arg_203_1.callingController_:SetSelectedState("normal")

				local var_206_8 = arg_203_1:GetWordFromCfg(302031052)
				local var_206_9 = arg_203_1:FormatText(var_206_8.content)

				arg_203_1.text_.text = var_206_9

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_11 = 22 <= 0 and var_206_7 or var_206_7 * (utf8.len(var_206_9) / 22)

				if (22 <= 0 and var_206_7 or var_206_7 * (utf8.len(var_206_9) / 22)) > 0 and var_206_7 < var_206_11 then
					arg_203_1.talkMaxDuration = var_206_11

					if var_206_11 + var_206_6 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_11 + var_206_6
					end
				end

				arg_203_1.text_.text = var_206_9
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302031", "302031052", "story_v_out_302031.awb") ~= 0 then
					local var_206_12 = manager.audio:GetVoiceLength("story_v_out_302031", "302031052", "story_v_out_302031.awb") / 1000

					if var_206_12 + var_206_6 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_12 + var_206_6
					end

					if var_206_8.prefab_name ~= "" and arg_203_1.actors_[var_206_8.prefab_name] ~= nil then
						local var_206_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_203_1.actors_[var_206_8.prefab_name].transform, "story_v_out_302031", "302031052", "story_v_out_302031.awb")

						arg_203_1:RecordAudio("302031052", var_206_13)
						arg_203_1:RecordAudio("302031052", var_206_13)
					else
						arg_203_1:AudioAction("play", "voice", "story_v_out_302031", "302031052", "story_v_out_302031.awb")
					end

					arg_203_1:RecordHistoryTalkVoice("story_v_out_302031", "302031052", "story_v_out_302031.awb")
				end

				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_14 = math.max(var_206_7, arg_203_1.talkMaxDuration)

			if var_206_6 <= arg_203_1.time_ and arg_203_1.time_ < var_206_6 + var_206_14 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - var_206_6) / var_206_14

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= var_206_6 + var_206_14 and arg_203_1.time_ < var_206_6 + var_206_14 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1166ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_203_1:InitPlayNodeList()
	end,
	Play302031053 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 302031053
		arg_207_1.duration_ = 3.97

		local var_207_0 = {
			zh = 2.2,
			ja = 3.966
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
				arg_207_0:Play302031054(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 then
				arg_207_1.var_.moveOldPos1084ui_story = arg_207_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_210_0 = 0.001

			if 0 <= arg_207_1.time_ and arg_207_1.time_ < 0 + var_210_0 then
				arg_207_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_207_1.var_.moveOldPos1084ui_story, Vector3.New(0.7, -0.97, -6), (arg_207_1.time_ - 0) / var_210_0)
				arg_207_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_207_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_207_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_207_1.actors_["1084ui_story"].transform.position).z)
				arg_207_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_207_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_207_1.actors_["1084ui_story"].transform.localEulerAngles = arg_207_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_207_1.time_ >= 0 + var_210_0 and arg_207_1.time_ < 0 + var_210_0 + arg_210_0 then
				arg_207_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0.7, -0.97, -6)
				arg_207_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_207_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_207_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_207_1.actors_["1084ui_story"].transform.position).z)
				arg_207_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_207_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_207_1.actors_["1084ui_story"].transform.localEulerAngles = arg_207_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_210_1 = arg_207_1.actors_["1084ui_story"]

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 and not isNil(var_210_1) and arg_207_1.var_.characterEffect1084ui_story == nil then
				arg_207_1.var_.characterEffect1084ui_story = var_210_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_210_2 = 0.200000002980232

			if 0 <= arg_207_1.time_ and arg_207_1.time_ < 0 + var_210_2 and not isNil(var_210_1) then
				if arg_207_1.var_.characterEffect1084ui_story and not isNil(var_210_1) then
					arg_207_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_207_1.time_ >= 0 + var_210_2 and arg_207_1.time_ < 0 + var_210_2 + arg_210_0 and not isNil(var_210_1) and arg_207_1.var_.characterEffect1084ui_story then
				arg_207_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_210_4 = arg_207_1.actors_["1166ui_story"]

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 and not isNil(var_210_4) and arg_207_1.var_.characterEffect1166ui_story == nil then
				arg_207_1.var_.characterEffect1166ui_story = var_210_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_210_5 = 0.200000002980232

			if 0 <= arg_207_1.time_ and arg_207_1.time_ < 0 + var_210_5 and not isNil(var_210_4) then
				if arg_207_1.var_.characterEffect1166ui_story and not isNil(var_210_4) then
					arg_207_1.var_.characterEffect1166ui_story.fillFlat = true
					arg_207_1.var_.characterEffect1166ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_207_1.time_ - 0) / var_210_5)
				end
			end

			if arg_207_1.time_ >= 0 + var_210_5 and arg_207_1.time_ < 0 + var_210_5 + arg_210_0 and not isNil(var_210_4) and arg_207_1.var_.characterEffect1166ui_story then
				arg_207_1.var_.characterEffect1166ui_story.fillFlat = true
				arg_207_1.var_.characterEffect1166ui_story.fillRatio = 0.5
			end

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 then
				arg_207_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action6_1")
			end

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 then
				arg_207_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_210_6 = 0
			local var_210_7 = 0.2

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= var_210_6 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, true)

				arg_207_1.leftNameTxt_.text = arg_207_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_207_1.leftNameTxt_.transform)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1.leftNameTxt_.text)
				SetActive(arg_207_1.iconTrs_.gameObject, false)
				arg_207_1.callingController_:SetSelectedState("normal")

				local var_210_8 = arg_207_1:GetWordFromCfg(302031053)
				local var_210_9 = arg_207_1:FormatText(var_210_8.content)

				arg_207_1.text_.text = var_210_9

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_11 = 8 <= 0 and var_210_7 or var_210_7 * (utf8.len(var_210_9) / 8)

				if (8 <= 0 and var_210_7 or var_210_7 * (utf8.len(var_210_9) / 8)) > 0 and var_210_7 < var_210_11 then
					arg_207_1.talkMaxDuration = var_210_11

					if var_210_11 + var_210_6 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_11 + var_210_6
					end
				end

				arg_207_1.text_.text = var_210_9
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302031", "302031053", "story_v_out_302031.awb") ~= 0 then
					local var_210_12 = manager.audio:GetVoiceLength("story_v_out_302031", "302031053", "story_v_out_302031.awb") / 1000

					if var_210_12 + var_210_6 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_12 + var_210_6
					end

					if var_210_8.prefab_name ~= "" and arg_207_1.actors_[var_210_8.prefab_name] ~= nil then
						local var_210_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_207_1.actors_[var_210_8.prefab_name].transform, "story_v_out_302031", "302031053", "story_v_out_302031.awb")

						arg_207_1:RecordAudio("302031053", var_210_13)
						arg_207_1:RecordAudio("302031053", var_210_13)
					else
						arg_207_1:AudioAction("play", "voice", "story_v_out_302031", "302031053", "story_v_out_302031.awb")
					end

					arg_207_1:RecordHistoryTalkVoice("story_v_out_302031", "302031053", "story_v_out_302031.awb")
				end

				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_14 = math.max(var_210_7, arg_207_1.talkMaxDuration)

			if var_210_6 <= arg_207_1.time_ and arg_207_1.time_ < var_210_6 + var_210_14 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - var_210_6) / var_210_14

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= var_210_6 + var_210_14 and arg_207_1.time_ < var_210_6 + var_210_14 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {
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

		arg_207_1:InitPlayNodeList()
	end,
	Play302031054 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 302031054
		arg_211_1.duration_ = 2.43

		local var_211_0 = {
			zh = 2.433,
			ja = 1.999999999999
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
				arg_211_0:Play302031055(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 and not isNil(arg_211_1.actors_["1166ui_story"]) and arg_211_1.var_.characterEffect1166ui_story == nil then
				arg_211_1.var_.characterEffect1166ui_story = arg_211_1.actors_["1166ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_214_0 = 0.200000002980232

			if 0 <= arg_211_1.time_ and arg_211_1.time_ < 0 + var_214_0 and not isNil(arg_211_1.actors_["1166ui_story"]) then
				if arg_211_1.var_.characterEffect1166ui_story and not isNil(arg_211_1.actors_["1166ui_story"]) then
					arg_211_1.var_.characterEffect1166ui_story.fillFlat = false
				end
			end

			if arg_211_1.time_ >= 0 + var_214_0 and arg_211_1.time_ < 0 + var_214_0 + arg_214_0 and not isNil(arg_211_1.actors_["1166ui_story"]) and arg_211_1.var_.characterEffect1166ui_story then
				arg_211_1.var_.characterEffect1166ui_story.fillFlat = false
			end

			local var_214_2 = arg_211_1.actors_["1084ui_story"]

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 and not isNil(var_214_2) and arg_211_1.var_.characterEffect1084ui_story == nil then
				arg_211_1.var_.characterEffect1084ui_story = var_214_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_214_3 = 0.200000002980232

			if 0 <= arg_211_1.time_ and arg_211_1.time_ < 0 + var_214_3 and not isNil(var_214_2) then
				if arg_211_1.var_.characterEffect1084ui_story and not isNil(var_214_2) then
					arg_211_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_211_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_211_1.time_ - 0) / var_214_3)
				end
			end

			if arg_211_1.time_ >= 0 + var_214_3 and arg_211_1.time_ < 0 + var_214_3 + arg_214_0 and not isNil(var_214_2) and arg_211_1.var_.characterEffect1084ui_story then
				arg_211_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_211_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 then
				arg_211_1:PlayTimeline("1166ui_story", "StoryTimeline/CharAction/story1166/story1166action/1166action3_1")
			end

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 then
				arg_211_1:PlayTimeline("1166ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_214_4 = 0
			local var_214_5 = 0.25

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= var_214_4 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, true)

				arg_211_1.leftNameTxt_.text = arg_211_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_211_1.leftNameTxt_.transform)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1.leftNameTxt_.text)
				SetActive(arg_211_1.iconTrs_.gameObject, false)
				arg_211_1.callingController_:SetSelectedState("normal")

				local var_214_6 = arg_211_1:GetWordFromCfg(302031054)
				local var_214_7 = arg_211_1:FormatText(var_214_6.content)

				arg_211_1.text_.text = var_214_7

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_9 = 10 <= 0 and var_214_5 or var_214_5 * (utf8.len(var_214_7) / 10)

				if (10 <= 0 and var_214_5 or var_214_5 * (utf8.len(var_214_7) / 10)) > 0 and var_214_5 < var_214_9 then
					arg_211_1.talkMaxDuration = var_214_9

					if var_214_9 + var_214_4 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_9 + var_214_4
					end
				end

				arg_211_1.text_.text = var_214_7
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302031", "302031054", "story_v_out_302031.awb") ~= 0 then
					local var_214_10 = manager.audio:GetVoiceLength("story_v_out_302031", "302031054", "story_v_out_302031.awb") / 1000

					if var_214_10 + var_214_4 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_10 + var_214_4
					end

					if var_214_6.prefab_name ~= "" and arg_211_1.actors_[var_214_6.prefab_name] ~= nil then
						local var_214_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_211_1.actors_[var_214_6.prefab_name].transform, "story_v_out_302031", "302031054", "story_v_out_302031.awb")

						arg_211_1:RecordAudio("302031054", var_214_11)
						arg_211_1:RecordAudio("302031054", var_214_11)
					else
						arg_211_1:AudioAction("play", "voice", "story_v_out_302031", "302031054", "story_v_out_302031.awb")
					end

					arg_211_1:RecordHistoryTalkVoice("story_v_out_302031", "302031054", "story_v_out_302031.awb")
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
	Play302031055 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 302031055
		arg_215_1.duration_ = 5

		SetActive(arg_215_1.tipsGo_, false)

		function arg_215_1.onSingleLineFinish_()
			arg_215_1.onSingleLineUpdate_ = nil
			arg_215_1.onSingleLineFinish_ = nil
			arg_215_1.state_ = "waiting"
		end

		function arg_215_1.playNext_(arg_217_0)
			if arg_217_0 == 1 then
				arg_215_0:Play302031056(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 and not isNil(arg_215_1.actors_["1166ui_story"]) and arg_215_1.var_.characterEffect1166ui_story == nil then
				arg_215_1.var_.characterEffect1166ui_story = arg_215_1.actors_["1166ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_218_0 = 0.200000002980232

			if 0 <= arg_215_1.time_ and arg_215_1.time_ < 0 + var_218_0 and not isNil(arg_215_1.actors_["1166ui_story"]) then
				if arg_215_1.var_.characterEffect1166ui_story and not isNil(arg_215_1.actors_["1166ui_story"]) then
					arg_215_1.var_.characterEffect1166ui_story.fillFlat = true
					arg_215_1.var_.characterEffect1166ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_215_1.time_ - 0) / var_218_0)
				end
			end

			if arg_215_1.time_ >= 0 + var_218_0 and arg_215_1.time_ < 0 + var_218_0 + arg_218_0 and not isNil(arg_215_1.actors_["1166ui_story"]) and arg_215_1.var_.characterEffect1166ui_story then
				arg_215_1.var_.characterEffect1166ui_story.fillFlat = true
				arg_215_1.var_.characterEffect1166ui_story.fillRatio = 0.5
			end

			local var_218_1 = 0
			local var_218_2 = 0.175

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= var_218_1 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, true)

				arg_215_1.leftNameTxt_.text = arg_215_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_215_1.leftNameTxt_.transform)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1.leftNameTxt_.text)
				SetActive(arg_215_1.iconTrs_.gameObject, true)
				arg_215_1.iconController_:SetSelectedState("hero")

				arg_215_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_215_1.callingController_:SetSelectedState("normal")

				arg_215_1.keyicon_.color = Color.New(1, 1, 1)
				arg_215_1.icon_.color = Color.New(1, 1, 1)

				local var_218_3 = arg_215_1:FormatText(arg_215_1:GetWordFromCfg(302031055).content)

				arg_215_1.text_.text = var_218_3

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_5 = 7 <= 0 and var_218_2 or var_218_2 * (utf8.len(var_218_3) / 7)

				if (7 <= 0 and var_218_2 or var_218_2 * (utf8.len(var_218_3) / 7)) > 0 and var_218_2 < var_218_5 then
					arg_215_1.talkMaxDuration = var_218_5

					if var_218_5 + var_218_1 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_5 + var_218_1
					end
				end

				arg_215_1.text_.text = var_218_3
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)
				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_6 = math.max(var_218_2, arg_215_1.talkMaxDuration)

			if var_218_1 <= arg_215_1.time_ and arg_215_1.time_ < var_218_1 + var_218_6 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - var_218_1) / var_218_6

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= var_218_1 + var_218_6 and arg_215_1.time_ < var_218_1 + var_218_6 + arg_218_0 then
				arg_215_1.typewritter.percent = 1

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(true)
			end
		end

		arg_215_1.nodeConfigList_ = {}

		arg_215_1:InitPlayNodeList()
	end,
	Play302031056 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 302031056
		arg_219_1.duration_ = 5

		SetActive(arg_219_1.tipsGo_, false)

		function arg_219_1.onSingleLineFinish_()
			arg_219_1.onSingleLineUpdate_ = nil
			arg_219_1.onSingleLineFinish_ = nil
			arg_219_1.state_ = "waiting"
		end

		function arg_219_1.playNext_(arg_221_0)
			if arg_221_0 == 1 then
				arg_219_0:Play302031057(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 then
				arg_219_1.var_.moveOldPos1166ui_story = arg_219_1.actors_["1166ui_story"].transform.localPosition

				local var_222_0 = GameObjectTools.GetOrAddComponent(arg_219_1.actors_["1166ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_222_0 then
					var_222_0:EnableDynamicBone(false)
				end
			end

			local var_222_1 = 0.001

			if 0 <= arg_219_1.time_ and arg_219_1.time_ < 0 + var_222_1 then
				arg_219_1.actors_["1166ui_story"].transform.localPosition = Vector3.Lerp(arg_219_1.var_.moveOldPos1166ui_story, Vector3.New(0, 100, 0), (arg_219_1.time_ - 0) / var_222_1)
				arg_219_1.actors_["1166ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_219_1.actors_["1166ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_219_1.actors_["1166ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_219_1.actors_["1166ui_story"].transform.position).z)
				arg_219_1.actors_["1166ui_story"].transform.localEulerAngles.z = 0
				arg_219_1.actors_["1166ui_story"].transform.localEulerAngles.x = 0
				arg_219_1.actors_["1166ui_story"].transform.localEulerAngles = arg_219_1.actors_["1166ui_story"].transform.localEulerAngles
			end

			if arg_219_1.time_ >= 0 + var_222_1 and arg_219_1.time_ < 0 + var_222_1 + arg_222_0 then
				arg_219_1.actors_["1166ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_219_1.actors_["1166ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_219_1.actors_["1166ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_219_1.actors_["1166ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_219_1.actors_["1166ui_story"].transform.position).z)
				arg_219_1.actors_["1166ui_story"].transform.localEulerAngles.z = 0
				arg_219_1.actors_["1166ui_story"].transform.localEulerAngles.x = 0
				arg_219_1.actors_["1166ui_story"].transform.localEulerAngles = arg_219_1.actors_["1166ui_story"].transform.localEulerAngles

				local var_222_2 = GameObjectTools.GetOrAddComponent(arg_219_1.actors_["1166ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_222_2 then
					var_222_2:EnableDynamicBone(true)
				end
			end

			local var_222_3 = arg_219_1.actors_["1084ui_story"].transform

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 then
				arg_219_1.var_.moveOldPos1084ui_story = var_222_3.localPosition
			end

			local var_222_4 = 0.001

			if 0 <= arg_219_1.time_ and arg_219_1.time_ < 0 + var_222_4 then
				var_222_3.localPosition = Vector3.Lerp(arg_219_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_219_1.time_ - 0) / var_222_4)
				var_222_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_222_3.position).x, (manager.ui.mainCamera.transform.position - var_222_3.position).y, (manager.ui.mainCamera.transform.position - var_222_3.position).z)
				var_222_3.localEulerAngles.z = 0
				var_222_3.localEulerAngles.x = 0
				var_222_3.localEulerAngles = var_222_3.localEulerAngles
			end

			if arg_219_1.time_ >= 0 + var_222_4 and arg_219_1.time_ < 0 + var_222_4 + arg_222_0 then
				var_222_3.localPosition = Vector3.New(0, 100, 0)
				var_222_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_222_3.position).x, (manager.ui.mainCamera.transform.position - var_222_3.position).y, (manager.ui.mainCamera.transform.position - var_222_3.position).z)
				var_222_3.localEulerAngles.z = 0
				var_222_3.localEulerAngles.x = 0
				var_222_3.localEulerAngles = var_222_3.localEulerAngles
			end

			local var_222_5 = 0
			local var_222_6 = 1.35

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= var_222_5 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0
				arg_219_1.dialogCg_.alpha = 1

				arg_219_1.dialog_:SetActive(true)
				SetActive(arg_219_1.leftNameGo_, false)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_219_1.iconTrs_.gameObject, false)
				arg_219_1.callingController_:SetSelectedState("normal")

				local var_222_7 = arg_219_1:FormatText(arg_219_1:GetWordFromCfg(302031056).content)

				arg_219_1.text_.text = var_222_7

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_9 = 54 <= 0 and var_222_6 or var_222_6 * (utf8.len(var_222_7) / 54)

				if (54 <= 0 and var_222_6 or var_222_6 * (utf8.len(var_222_7) / 54)) > 0 and var_222_6 < var_222_9 then
					arg_219_1.talkMaxDuration = var_222_9

					if var_222_9 + var_222_5 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_9 + var_222_5
					end
				end

				arg_219_1.text_.text = var_222_7
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)
				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_10 = math.max(var_222_6, arg_219_1.talkMaxDuration)

			if var_222_5 <= arg_219_1.time_ and arg_219_1.time_ < var_222_5 + var_222_10 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - var_222_5) / var_222_10

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= var_222_5 + var_222_10 and arg_219_1.time_ < var_222_5 + var_222_10 + arg_222_0 then
				arg_219_1.typewritter.percent = 1

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(true)
			end
		end

		arg_219_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1166ui_story",
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

		arg_219_1:InitPlayNodeList()
	end,
	Play302031057 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 302031057
		arg_223_1.duration_ = 5

		SetActive(arg_223_1.tipsGo_, false)

		function arg_223_1.onSingleLineFinish_()
			arg_223_1.onSingleLineUpdate_ = nil
			arg_223_1.onSingleLineFinish_ = nil
			arg_223_1.state_ = "waiting"
		end

		function arg_223_1.playNext_(arg_225_0)
			if arg_225_0 == 1 then
				arg_223_0:Play302031058(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			local var_226_0 = 1.35

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0
				arg_223_1.dialogCg_.alpha = 1

				arg_223_1.dialog_:SetActive(true)
				SetActive(arg_223_1.leftNameGo_, false)

				arg_223_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_223_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_223_1:RecordName(arg_223_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_223_1.iconTrs_.gameObject, false)
				arg_223_1.callingController_:SetSelectedState("normal")

				local var_226_1 = arg_223_1:FormatText(arg_223_1:GetWordFromCfg(302031057).content)

				arg_223_1.text_.text = var_226_1

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_3 = 54 <= 0 and var_226_0 or var_226_0 * (utf8.len(var_226_1) / 54)

				if (54 <= 0 and var_226_0 or var_226_0 * (utf8.len(var_226_1) / 54)) > 0 and var_226_0 < var_226_3 then
					arg_223_1.talkMaxDuration = var_226_3

					if var_226_3 + 0 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_3 + 0
					end
				end

				arg_223_1.text_.text = var_226_1
				arg_223_1.typewritter.percent = 0

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(false)
				arg_223_1:RecordContent(arg_223_1.text_.text)
			end

			local var_226_4 = math.max(var_226_0, arg_223_1.talkMaxDuration)

			if 0 <= arg_223_1.time_ and arg_223_1.time_ < 0 + var_226_4 then
				arg_223_1.typewritter.percent = (arg_223_1.time_ - 0) / var_226_4

				arg_223_1.typewritter:SetDirty()
			end

			if arg_223_1.time_ >= 0 + var_226_4 and arg_223_1.time_ < 0 + var_226_4 + arg_226_0 then
				arg_223_1.typewritter.percent = 1

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(true)
			end
		end

		arg_223_1.nodeConfigList_ = {}

		arg_223_1:InitPlayNodeList()
	end,
	Play302031058 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 302031058
		arg_227_1.duration_ = 5

		SetActive(arg_227_1.tipsGo_, false)

		function arg_227_1.onSingleLineFinish_()
			arg_227_1.onSingleLineUpdate_ = nil
			arg_227_1.onSingleLineFinish_ = nil
			arg_227_1.state_ = "waiting"
		end

		function arg_227_1.playNext_(arg_229_0)
			if arg_229_0 == 1 then
				arg_227_0:Play302031059(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			local var_230_0 = 0.15

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0
				arg_227_1.dialogCg_.alpha = 1

				arg_227_1.dialog_:SetActive(true)
				SetActive(arg_227_1.leftNameGo_, true)

				arg_227_1.leftNameTxt_.text = arg_227_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_227_1.leftNameTxt_.transform)

				arg_227_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_227_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_227_1:RecordName(arg_227_1.leftNameTxt_.text)
				SetActive(arg_227_1.iconTrs_.gameObject, true)
				arg_227_1.iconController_:SetSelectedState("hero")

				arg_227_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_227_1.callingController_:SetSelectedState("normal")

				arg_227_1.keyicon_.color = Color.New(1, 1, 1)
				arg_227_1.icon_.color = Color.New(1, 1, 1)

				local var_230_1 = arg_227_1:FormatText(arg_227_1:GetWordFromCfg(302031058).content)

				arg_227_1.text_.text = var_230_1

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_3 = 6 <= 0 and var_230_0 or var_230_0 * (utf8.len(var_230_1) / 6)

				if (6 <= 0 and var_230_0 or var_230_0 * (utf8.len(var_230_1) / 6)) > 0 and var_230_0 < var_230_3 then
					arg_227_1.talkMaxDuration = var_230_3

					if var_230_3 + 0 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_3 + 0
					end
				end

				arg_227_1.text_.text = var_230_1
				arg_227_1.typewritter.percent = 0

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(false)
				arg_227_1:RecordContent(arg_227_1.text_.text)
			end

			local var_230_4 = math.max(var_230_0, arg_227_1.talkMaxDuration)

			if 0 <= arg_227_1.time_ and arg_227_1.time_ < 0 + var_230_4 then
				arg_227_1.typewritter.percent = (arg_227_1.time_ - 0) / var_230_4

				arg_227_1.typewritter:SetDirty()
			end

			if arg_227_1.time_ >= 0 + var_230_4 and arg_227_1.time_ < 0 + var_230_4 + arg_230_0 then
				arg_227_1.typewritter.percent = 1

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(true)
			end
		end

		arg_227_1.nodeConfigList_ = {}

		arg_227_1:InitPlayNodeList()
	end,
	Play302031059 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 302031059
		arg_231_1.duration_ = 9

		SetActive(arg_231_1.tipsGo_, false)

		function arg_231_1.onSingleLineFinish_()
			arg_231_1.onSingleLineUpdate_ = nil
			arg_231_1.onSingleLineFinish_ = nil
			arg_231_1.state_ = "waiting"
		end

		function arg_231_1.playNext_(arg_233_0)
			if arg_233_0 == 1 then
				arg_231_0:Play302031060(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			if 2 < arg_231_1.time_ and arg_231_1.time_ <= 2 + arg_234_0 then
				local var_234_0 = arg_231_1.bgs_.I27f

				arg_231_1.bgs_.I27f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_234_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_234_1 = var_234_0:GetComponent("SpriteRenderer")

				if var_234_1 and var_234_1.sprite then
					local var_234_2 = 2 * (var_234_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_234_0.transform.localScale = Vector3.New(var_234_2 / var_234_1.sprite.bounds.size.y < var_234_2 * manager.ui.mainCameraCom_.aspect / var_234_1.sprite.bounds.size.x and var_234_2 * manager.ui.mainCameraCom_.aspect / var_234_1.sprite.bounds.size.x or var_234_2 / var_234_1.sprite.bounds.size.y, var_234_2 / var_234_1.sprite.bounds.size.y < var_234_2 * manager.ui.mainCameraCom_.aspect / var_234_1.sprite.bounds.size.x and var_234_2 * manager.ui.mainCameraCom_.aspect / var_234_1.sprite.bounds.size.x or var_234_2 / var_234_1.sprite.bounds.size.y, 0)
				end

				for iter_234_0, iter_234_1 in pairs(arg_231_1.bgs_) do
					if iter_234_0 ~= "I27f" then
						iter_234_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_234_3 = 3.999999999999

			if 3.999999999999 < arg_231_1.time_ and arg_231_1.time_ <= var_234_3 + arg_234_0 then
				arg_231_1.allBtn_.enabled = false
			end

			if arg_231_1.time_ >= var_234_3 + 0.3 and arg_231_1.time_ < var_234_3 + 0.3 + arg_234_0 then
				arg_231_1.allBtn_.enabled = true
			end

			local var_234_4 = 0

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= var_234_4 + arg_234_0 then
				arg_231_1.mask_.enabled = true
				arg_231_1.mask_.raycastTarget = true

				arg_231_1:SetGaussion(false)
			end

			local var_234_5 = 2

			if var_234_4 <= arg_231_1.time_ and arg_231_1.time_ < var_234_4 + var_234_5 then
				local var_234_6 = Color.New(0, 0, 0)

				var_234_6.a = Mathf.Lerp(0, 1, (arg_231_1.time_ - var_234_4) / var_234_5)
				arg_231_1.mask_.color = var_234_6
			end

			if arg_231_1.time_ >= var_234_4 + var_234_5 and arg_231_1.time_ < var_234_4 + var_234_5 + arg_234_0 then
				local var_234_7 = Color.New(0, 0, 0)

				var_234_7.a = 1
				arg_231_1.mask_.color = var_234_7
			end

			local var_234_8 = 2

			if 2 < arg_231_1.time_ and arg_231_1.time_ <= var_234_8 + arg_234_0 then
				arg_231_1.mask_.enabled = true
				arg_231_1.mask_.raycastTarget = true

				arg_231_1:SetGaussion(false)
			end

			local var_234_9 = 2

			if var_234_8 <= arg_231_1.time_ and arg_231_1.time_ < var_234_8 + var_234_9 then
				local var_234_10 = Color.New(0, 0, 0)

				var_234_10.a = Mathf.Lerp(1, 0, (arg_231_1.time_ - var_234_8) / var_234_9)
				arg_231_1.mask_.color = var_234_10
			end

			if arg_231_1.time_ >= var_234_8 + var_234_9 and arg_231_1.time_ < var_234_8 + var_234_9 + arg_234_0 then
				local var_234_11 = Color.New(0, 0, 0)

				arg_231_1.mask_.enabled = false
				var_234_11.a = 0
				arg_231_1.mask_.color = var_234_11
			end

			if arg_231_1.frameCnt_ <= 1 then
				arg_231_1.dialog_:SetActive(false)
			end

			local var_234_12 = 3.999999999999
			local var_234_13 = 1.55

			if 3.999999999999 < arg_231_1.time_ and arg_231_1.time_ <= var_234_12 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0

				arg_231_1.dialog_:SetActive(true)

				arg_231_1.dialogCg_.alpha = 0

				local var_234_14 = LeanTween.value(arg_231_1.dialog_, 0, 1, 0.3)

				var_234_14:setOnUpdate(LuaHelper.FloatAction(function(arg_235_0)
					arg_231_1.dialogCg_.alpha = arg_235_0
				end))
				var_234_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_231_1.dialog_)
					var_234_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_231_1.duration_ = arg_231_1.duration_ + 0.3

				SetActive(arg_231_1.leftNameGo_, false)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_231_1.iconTrs_.gameObject, false)
				arg_231_1.callingController_:SetSelectedState("normal")

				local var_234_15 = arg_231_1:FormatText(arg_231_1:GetWordFromCfg(302031059).content)

				arg_231_1.text_.text = var_234_15

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_17 = 62 <= 0 and var_234_13 or var_234_13 * (utf8.len(var_234_15) / 62)

				if (62 <= 0 and var_234_13 or var_234_13 * (utf8.len(var_234_15) / 62)) > 0 and var_234_13 < var_234_17 then
					arg_231_1.talkMaxDuration = var_234_17
					var_234_12 = var_234_12 + 0.3

					if var_234_17 + var_234_12 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_17 + var_234_12
					end
				end

				arg_231_1.text_.text = var_234_15
				arg_231_1.typewritter.percent = 0

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(false)
				arg_231_1:RecordContent(arg_231_1.text_.text)
			end

			local var_234_18 = var_234_12 + 0.3
			local var_234_19 = math.max(var_234_13, arg_231_1.talkMaxDuration)

			if var_234_12 + 0.3 <= arg_231_1.time_ and arg_231_1.time_ < var_234_18 + var_234_19 then
				arg_231_1.typewritter.percent = (arg_231_1.time_ - var_234_18) / var_234_19

				arg_231_1.typewritter:SetDirty()
			end

			if arg_231_1.time_ >= var_234_18 + var_234_19 and arg_231_1.time_ < var_234_18 + var_234_19 + arg_234_0 then
				arg_231_1.typewritter.percent = 1

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(true)
			end
		end

		arg_231_1.nodeConfigList_ = {}

		arg_231_1:InitPlayNodeList()
	end,
	Play302031060 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 302031060
		arg_237_1.duration_ = 5

		SetActive(arg_237_1.tipsGo_, false)

		function arg_237_1.onSingleLineFinish_()
			arg_237_1.onSingleLineUpdate_ = nil
			arg_237_1.onSingleLineFinish_ = nil
			arg_237_1.state_ = "waiting"
		end

		function arg_237_1.playNext_(arg_239_0)
			if arg_239_0 == 1 then
				arg_237_0:Play302031061(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			local var_240_0 = 1.125

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0
				arg_237_1.dialogCg_.alpha = 1

				arg_237_1.dialog_:SetActive(true)
				SetActive(arg_237_1.leftNameGo_, false)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_237_1.iconTrs_.gameObject, false)
				arg_237_1.callingController_:SetSelectedState("normal")

				local var_240_1 = arg_237_1:FormatText(arg_237_1:GetWordFromCfg(302031060).content)

				arg_237_1.text_.text = var_240_1

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_3 = 45 <= 0 and var_240_0 or var_240_0 * (utf8.len(var_240_1) / 45)

				if (45 <= 0 and var_240_0 or var_240_0 * (utf8.len(var_240_1) / 45)) > 0 and var_240_0 < var_240_3 then
					arg_237_1.talkMaxDuration = var_240_3

					if var_240_3 + 0 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_3 + 0
					end
				end

				arg_237_1.text_.text = var_240_1
				arg_237_1.typewritter.percent = 0

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(false)
				arg_237_1:RecordContent(arg_237_1.text_.text)
			end

			local var_240_4 = math.max(var_240_0, arg_237_1.talkMaxDuration)

			if 0 <= arg_237_1.time_ and arg_237_1.time_ < 0 + var_240_4 then
				arg_237_1.typewritter.percent = (arg_237_1.time_ - 0) / var_240_4

				arg_237_1.typewritter:SetDirty()
			end

			if arg_237_1.time_ >= 0 + var_240_4 and arg_237_1.time_ < 0 + var_240_4 + arg_240_0 then
				arg_237_1.typewritter.percent = 1

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(true)
			end
		end

		arg_237_1.nodeConfigList_ = {}

		arg_237_1:InitPlayNodeList()
	end,
	Play302031061 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 302031061
		arg_241_1.duration_ = 4.43

		local var_241_0 = {
			zh = 4.433,
			ja = 3.866
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
				arg_241_0:Play302031062(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			if arg_241_1.actors_["10141ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10141ui_story"))) then
				local var_244_0 = Object.Instantiate(Asset.Load("Char/" .. "10141ui_story"), arg_241_1.stage_.transform)

				var_244_0.name = "10141ui_story"
				var_244_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_241_1.actors_["10141ui_story"] = var_244_0

				local var_244_1 = var_244_0:GetComponentInChildren(typeof(CharacterEffect))

				var_244_1.enabled = true

				local var_244_2 = GameObjectTools.GetOrAddComponent(var_244_0, typeof(DynamicBoneHelper))

				if var_244_2 then
					var_244_2:EnableDynamicBone(false)
				end

				arg_241_1:ShowWeapon(var_244_1.transform, false)

				arg_241_1.var_["10141ui_story" .. "Animator"] = var_244_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_241_1.var_["10141ui_story" .. "Animator"].applyRootMotion = true
				arg_241_1.var_["10141ui_story" .. "LipSync"] = var_244_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_244_3 = arg_241_1.actors_["10141ui_story"].transform

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 then
				arg_241_1.var_.moveOldPos10141ui_story = var_244_3.localPosition

				local var_244_4 = GameObjectTools.GetOrAddComponent(var_244_3.gameObject, typeof(DynamicBoneHelper))

				if var_244_4 then
					var_244_4:EnableDynamicBone(false)
				end
			end

			local var_244_5 = 0.001

			if 0 <= arg_241_1.time_ and arg_241_1.time_ < 0 + var_244_5 then
				var_244_3.localPosition = Vector3.Lerp(arg_241_1.var_.moveOldPos10141ui_story, Vector3.New(0, -1.16, -6.15), (arg_241_1.time_ - 0) / var_244_5)
				var_244_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_244_3.position).x, (manager.ui.mainCamera.transform.position - var_244_3.position).y, (manager.ui.mainCamera.transform.position - var_244_3.position).z)
				var_244_3.localEulerAngles.z = 0
				var_244_3.localEulerAngles.x = 0
				var_244_3.localEulerAngles = var_244_3.localEulerAngles
			end

			if arg_241_1.time_ >= 0 + var_244_5 and arg_241_1.time_ < 0 + var_244_5 + arg_244_0 then
				var_244_3.localPosition = Vector3.New(0, -1.16, -6.15)
				var_244_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_244_3.position).x, (manager.ui.mainCamera.transform.position - var_244_3.position).y, (manager.ui.mainCamera.transform.position - var_244_3.position).z)
				var_244_3.localEulerAngles.z = 0
				var_244_3.localEulerAngles.x = 0
				var_244_3.localEulerAngles = var_244_3.localEulerAngles

				local var_244_6 = GameObjectTools.GetOrAddComponent(var_244_3.gameObject, typeof(DynamicBoneHelper))

				if var_244_6 then
					var_244_6:EnableDynamicBone(true)
				end
			end

			local var_244_7 = arg_241_1.actors_["10141ui_story"]

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 and not isNil(var_244_7) and arg_241_1.var_.characterEffect10141ui_story == nil then
				arg_241_1.var_.characterEffect10141ui_story = var_244_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_244_8 = 0.200000002980232

			if 0 <= arg_241_1.time_ and arg_241_1.time_ < 0 + var_244_8 and not isNil(var_244_7) then
				if arg_241_1.var_.characterEffect10141ui_story and not isNil(var_244_7) then
					arg_241_1.var_.characterEffect10141ui_story.fillFlat = false
				end
			end

			if arg_241_1.time_ >= 0 + var_244_8 and arg_241_1.time_ < 0 + var_244_8 + arg_244_0 and not isNil(var_244_7) and arg_241_1.var_.characterEffect10141ui_story then
				arg_241_1.var_.characterEffect10141ui_story.fillFlat = false
			end

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 then
				arg_241_1:PlayTimeline("10141ui_story", "StoryTimeline/CharAction/story10141/story10141action/10141action16_1")
			end

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 then
				arg_241_1:PlayTimeline("10141ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_244_10 = 0
			local var_244_11 = 0.45

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= var_244_10 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0
				arg_241_1.dialogCg_.alpha = 1

				arg_241_1.dialog_:SetActive(true)
				SetActive(arg_241_1.leftNameGo_, true)

				arg_241_1.leftNameTxt_.text = arg_241_1:FormatText(StoryNameCfg[1551].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_241_1.leftNameTxt_.transform)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1.leftNameTxt_.text)
				SetActive(arg_241_1.iconTrs_.gameObject, false)
				arg_241_1.callingController_:SetSelectedState("normal")

				local var_244_12 = arg_241_1:GetWordFromCfg(302031061)
				local var_244_13 = arg_241_1:FormatText(var_244_12.content)

				arg_241_1.text_.text = var_244_13

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_15 = 18 <= 0 and var_244_11 or var_244_11 * (utf8.len(var_244_13) / 18)

				if (18 <= 0 and var_244_11 or var_244_11 * (utf8.len(var_244_13) / 18)) > 0 and var_244_11 < var_244_15 then
					arg_241_1.talkMaxDuration = var_244_15

					if var_244_15 + var_244_10 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_15 + var_244_10
					end
				end

				arg_241_1.text_.text = var_244_13
				arg_241_1.typewritter.percent = 0

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302031", "302031061", "story_v_out_302031.awb") ~= 0 then
					local var_244_16 = manager.audio:GetVoiceLength("story_v_out_302031", "302031061", "story_v_out_302031.awb") / 1000

					if var_244_16 + var_244_10 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_16 + var_244_10
					end

					if var_244_12.prefab_name ~= "" and arg_241_1.actors_[var_244_12.prefab_name] ~= nil then
						local var_244_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_241_1.actors_[var_244_12.prefab_name].transform, "story_v_out_302031", "302031061", "story_v_out_302031.awb")

						arg_241_1:RecordAudio("302031061", var_244_17)
						arg_241_1:RecordAudio("302031061", var_244_17)
					else
						arg_241_1:AudioAction("play", "voice", "story_v_out_302031", "302031061", "story_v_out_302031.awb")
					end

					arg_241_1:RecordHistoryTalkVoice("story_v_out_302031", "302031061", "story_v_out_302031.awb")
				end

				arg_241_1:RecordContent(arg_241_1.text_.text)
			end

			local var_244_18 = math.max(var_244_11, arg_241_1.talkMaxDuration)

			if var_244_10 <= arg_241_1.time_ and arg_241_1.time_ < var_244_10 + var_244_18 then
				arg_241_1.typewritter.percent = (arg_241_1.time_ - var_244_10) / var_244_18

				arg_241_1.typewritter:SetDirty()
			end

			if arg_241_1.time_ >= var_244_10 + var_244_18 and arg_241_1.time_ < var_244_10 + var_244_18 + arg_244_0 then
				arg_241_1.typewritter.percent = 1

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(true)
			end
		end

		arg_241_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10141ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_241_1:InitPlayNodeList()
	end,
	Play302031062 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 302031062
		arg_245_1.duration_ = 7.17

		local var_245_0 = {
			zh = 7.166,
			ja = 5.933
		}
		local var_245_1 = manager.audio:GetLocalizationFlag()

		if var_245_0[var_245_1] ~= nil then
			arg_245_1.duration_ = var_245_0[var_245_1]
		end

		SetActive(arg_245_1.tipsGo_, false)

		function arg_245_1.onSingleLineFinish_()
			arg_245_1.onSingleLineUpdate_ = nil
			arg_245_1.onSingleLineFinish_ = nil
			arg_245_1.state_ = "waiting"
		end

		function arg_245_1.playNext_(arg_247_0)
			if arg_247_0 == 1 then
				arg_245_0:Play302031063(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 then
				arg_245_1:PlayTimeline("10141ui_story", "StoryTimeline/CharAction/story10141/story10141actionlink/10141action41623")
			end

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 then
				arg_245_1:PlayTimeline("10141ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_248_0 = 0
			local var_248_1 = 0.875

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= var_248_0 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0
				arg_245_1.dialogCg_.alpha = 1

				arg_245_1.dialog_:SetActive(true)
				SetActive(arg_245_1.leftNameGo_, true)

				arg_245_1.leftNameTxt_.text = arg_245_1:FormatText(StoryNameCfg[1551].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_245_1.leftNameTxt_.transform)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1.leftNameTxt_.text)
				SetActive(arg_245_1.iconTrs_.gameObject, false)
				arg_245_1.callingController_:SetSelectedState("normal")

				local var_248_2 = arg_245_1:GetWordFromCfg(302031062)
				local var_248_3 = arg_245_1:FormatText(var_248_2.content)

				arg_245_1.text_.text = var_248_3

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_5 = 36 <= 0 and var_248_1 or var_248_1 * (utf8.len(var_248_3) / 36)

				if (36 <= 0 and var_248_1 or var_248_1 * (utf8.len(var_248_3) / 36)) > 0 and var_248_1 < var_248_5 then
					arg_245_1.talkMaxDuration = var_248_5

					if var_248_5 + var_248_0 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_5 + var_248_0
					end
				end

				arg_245_1.text_.text = var_248_3
				arg_245_1.typewritter.percent = 0

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302031", "302031062", "story_v_out_302031.awb") ~= 0 then
					local var_248_6 = manager.audio:GetVoiceLength("story_v_out_302031", "302031062", "story_v_out_302031.awb") / 1000

					if var_248_6 + var_248_0 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_6 + var_248_0
					end

					if var_248_2.prefab_name ~= "" and arg_245_1.actors_[var_248_2.prefab_name] ~= nil then
						local var_248_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_245_1.actors_[var_248_2.prefab_name].transform, "story_v_out_302031", "302031062", "story_v_out_302031.awb")

						arg_245_1:RecordAudio("302031062", var_248_7)
						arg_245_1:RecordAudio("302031062", var_248_7)
					else
						arg_245_1:AudioAction("play", "voice", "story_v_out_302031", "302031062", "story_v_out_302031.awb")
					end

					arg_245_1:RecordHistoryTalkVoice("story_v_out_302031", "302031062", "story_v_out_302031.awb")
				end

				arg_245_1:RecordContent(arg_245_1.text_.text)
			end

			local var_248_8 = math.max(var_248_1, arg_245_1.talkMaxDuration)

			if var_248_0 <= arg_245_1.time_ and arg_245_1.time_ < var_248_0 + var_248_8 then
				arg_245_1.typewritter.percent = (arg_245_1.time_ - var_248_0) / var_248_8

				arg_245_1.typewritter:SetDirty()
			end

			if arg_245_1.time_ >= var_248_0 + var_248_8 and arg_245_1.time_ < var_248_0 + var_248_8 + arg_248_0 then
				arg_245_1.typewritter.percent = 1

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(true)
			end
		end

		arg_245_1.nodeConfigList_ = {}

		arg_245_1:InitPlayNodeList()
	end,
	Play302031063 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 302031063
		arg_249_1.duration_ = 4.13

		local var_249_0 = {
			zh = 4.133,
			ja = 3.3
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
				arg_249_0:Play302031064(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 then
				arg_249_1.var_.moveOldPos10141ui_story = arg_249_1.actors_["10141ui_story"].transform.localPosition

				local var_252_0 = GameObjectTools.GetOrAddComponent(arg_249_1.actors_["10141ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_252_0 then
					var_252_0:EnableDynamicBone(false)
				end
			end

			local var_252_1 = 0.001

			if 0 <= arg_249_1.time_ and arg_249_1.time_ < 0 + var_252_1 then
				arg_249_1.actors_["10141ui_story"].transform.localPosition = Vector3.Lerp(arg_249_1.var_.moveOldPos10141ui_story, Vector3.New(0, 100, 0), (arg_249_1.time_ - 0) / var_252_1)
				arg_249_1.actors_["10141ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_249_1.actors_["10141ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_249_1.actors_["10141ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_249_1.actors_["10141ui_story"].transform.position).z)
				arg_249_1.actors_["10141ui_story"].transform.localEulerAngles.z = 0
				arg_249_1.actors_["10141ui_story"].transform.localEulerAngles.x = 0
				arg_249_1.actors_["10141ui_story"].transform.localEulerAngles = arg_249_1.actors_["10141ui_story"].transform.localEulerAngles
			end

			if arg_249_1.time_ >= 0 + var_252_1 and arg_249_1.time_ < 0 + var_252_1 + arg_252_0 then
				arg_249_1.actors_["10141ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_249_1.actors_["10141ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_249_1.actors_["10141ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_249_1.actors_["10141ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_249_1.actors_["10141ui_story"].transform.position).z)
				arg_249_1.actors_["10141ui_story"].transform.localEulerAngles.z = 0
				arg_249_1.actors_["10141ui_story"].transform.localEulerAngles.x = 0
				arg_249_1.actors_["10141ui_story"].transform.localEulerAngles = arg_249_1.actors_["10141ui_story"].transform.localEulerAngles

				local var_252_2 = GameObjectTools.GetOrAddComponent(arg_249_1.actors_["10141ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_252_2 then
					var_252_2:EnableDynamicBone(true)
				end
			end

			local var_252_3 = arg_249_1.actors_["1084ui_story"].transform

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 then
				arg_249_1.var_.moveOldPos1084ui_story = var_252_3.localPosition
			end

			local var_252_4 = 0.001

			if 0 <= arg_249_1.time_ and arg_249_1.time_ < 0 + var_252_4 then
				var_252_3.localPosition = Vector3.Lerp(arg_249_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_249_1.time_ - 0) / var_252_4)
				var_252_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_252_3.position).x, (manager.ui.mainCamera.transform.position - var_252_3.position).y, (manager.ui.mainCamera.transform.position - var_252_3.position).z)
				var_252_3.localEulerAngles.z = 0
				var_252_3.localEulerAngles.x = 0
				var_252_3.localEulerAngles = var_252_3.localEulerAngles
			end

			if arg_249_1.time_ >= 0 + var_252_4 and arg_249_1.time_ < 0 + var_252_4 + arg_252_0 then
				var_252_3.localPosition = Vector3.New(0, -0.97, -6)
				var_252_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_252_3.position).x, (manager.ui.mainCamera.transform.position - var_252_3.position).y, (manager.ui.mainCamera.transform.position - var_252_3.position).z)
				var_252_3.localEulerAngles.z = 0
				var_252_3.localEulerAngles.x = 0
				var_252_3.localEulerAngles = var_252_3.localEulerAngles
			end

			local var_252_5 = arg_249_1.actors_["1084ui_story"]

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 and not isNil(var_252_5) and arg_249_1.var_.characterEffect1084ui_story == nil then
				arg_249_1.var_.characterEffect1084ui_story = var_252_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_252_6 = 0.200000002980232

			if 0 <= arg_249_1.time_ and arg_249_1.time_ < 0 + var_252_6 and not isNil(var_252_5) then
				if arg_249_1.var_.characterEffect1084ui_story and not isNil(var_252_5) then
					arg_249_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_249_1.time_ >= 0 + var_252_6 and arg_249_1.time_ < 0 + var_252_6 + arg_252_0 and not isNil(var_252_5) and arg_249_1.var_.characterEffect1084ui_story then
				arg_249_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_252_8 = arg_249_1.actors_["10141ui_story"]

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 and not isNil(var_252_8) and arg_249_1.var_.characterEffect10141ui_story == nil then
				arg_249_1.var_.characterEffect10141ui_story = var_252_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_252_9 = 0.200000002980232

			if 0 <= arg_249_1.time_ and arg_249_1.time_ < 0 + var_252_9 and not isNil(var_252_8) then
				if arg_249_1.var_.characterEffect10141ui_story and not isNil(var_252_8) then
					arg_249_1.var_.characterEffect10141ui_story.fillFlat = true
					arg_249_1.var_.characterEffect10141ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_249_1.time_ - 0) / var_252_9)
				end
			end

			if arg_249_1.time_ >= 0 + var_252_9 and arg_249_1.time_ < 0 + var_252_9 + arg_252_0 and not isNil(var_252_8) and arg_249_1.var_.characterEffect10141ui_story then
				arg_249_1.var_.characterEffect10141ui_story.fillFlat = true
				arg_249_1.var_.characterEffect10141ui_story.fillRatio = 0.5
			end

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 then
				arg_249_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_1")
			end

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 then
				arg_249_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_252_10 = 0
			local var_252_11 = 0.35

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= var_252_10 + arg_252_0 then
				arg_249_1.talkMaxDuration = 0
				arg_249_1.dialogCg_.alpha = 1

				arg_249_1.dialog_:SetActive(true)
				SetActive(arg_249_1.leftNameGo_, true)

				arg_249_1.leftNameTxt_.text = arg_249_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_249_1.leftNameTxt_.transform)

				arg_249_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_249_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_249_1:RecordName(arg_249_1.leftNameTxt_.text)
				SetActive(arg_249_1.iconTrs_.gameObject, false)
				arg_249_1.callingController_:SetSelectedState("normal")

				local var_252_12 = arg_249_1:GetWordFromCfg(302031063)
				local var_252_13 = arg_249_1:FormatText(var_252_12.content)

				arg_249_1.text_.text = var_252_13

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_15 = 14 <= 0 and var_252_11 or var_252_11 * (utf8.len(var_252_13) / 14)

				if (14 <= 0 and var_252_11 or var_252_11 * (utf8.len(var_252_13) / 14)) > 0 and var_252_11 < var_252_15 then
					arg_249_1.talkMaxDuration = var_252_15

					if var_252_15 + var_252_10 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_15 + var_252_10
					end
				end

				arg_249_1.text_.text = var_252_13
				arg_249_1.typewritter.percent = 0

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302031", "302031063", "story_v_out_302031.awb") ~= 0 then
					local var_252_16 = manager.audio:GetVoiceLength("story_v_out_302031", "302031063", "story_v_out_302031.awb") / 1000

					if var_252_16 + var_252_10 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_16 + var_252_10
					end

					if var_252_12.prefab_name ~= "" and arg_249_1.actors_[var_252_12.prefab_name] ~= nil then
						local var_252_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_249_1.actors_[var_252_12.prefab_name].transform, "story_v_out_302031", "302031063", "story_v_out_302031.awb")

						arg_249_1:RecordAudio("302031063", var_252_17)
						arg_249_1:RecordAudio("302031063", var_252_17)
					else
						arg_249_1:AudioAction("play", "voice", "story_v_out_302031", "302031063", "story_v_out_302031.awb")
					end

					arg_249_1:RecordHistoryTalkVoice("story_v_out_302031", "302031063", "story_v_out_302031.awb")
				end

				arg_249_1:RecordContent(arg_249_1.text_.text)
			end

			local var_252_18 = math.max(var_252_11, arg_249_1.talkMaxDuration)

			if var_252_10 <= arg_249_1.time_ and arg_249_1.time_ < var_252_10 + var_252_18 then
				arg_249_1.typewritter.percent = (arg_249_1.time_ - var_252_10) / var_252_18

				arg_249_1.typewritter:SetDirty()
			end

			if arg_249_1.time_ >= var_252_10 + var_252_18 and arg_249_1.time_ < var_252_10 + var_252_18 + arg_252_0 then
				arg_249_1.typewritter.percent = 1

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(true)
			end
		end

		arg_249_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10141ui_story",
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

		arg_249_1:InitPlayNodeList()
	end,
	Play302031064 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 302031064
		arg_253_1.duration_ = 5

		SetActive(arg_253_1.tipsGo_, false)

		function arg_253_1.onSingleLineFinish_()
			arg_253_1.onSingleLineUpdate_ = nil
			arg_253_1.onSingleLineFinish_ = nil
			arg_253_1.state_ = "waiting"
		end

		function arg_253_1.playNext_(arg_255_0)
			if arg_255_0 == 1 then
				arg_253_0:Play302031065(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 and not isNil(arg_253_1.actors_["1084ui_story"]) and arg_253_1.var_.characterEffect1084ui_story == nil then
				arg_253_1.var_.characterEffect1084ui_story = arg_253_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_256_0 = 0.200000002980232

			if 0 <= arg_253_1.time_ and arg_253_1.time_ < 0 + var_256_0 and not isNil(arg_253_1.actors_["1084ui_story"]) then
				if arg_253_1.var_.characterEffect1084ui_story and not isNil(arg_253_1.actors_["1084ui_story"]) then
					arg_253_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_253_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_253_1.time_ - 0) / var_256_0)
				end
			end

			if arg_253_1.time_ >= 0 + var_256_0 and arg_253_1.time_ < 0 + var_256_0 + arg_256_0 and not isNil(arg_253_1.actors_["1084ui_story"]) and arg_253_1.var_.characterEffect1084ui_story then
				arg_253_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_253_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_256_1 = 0
			local var_256_2 = 0.525

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= var_256_1 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, true)

				arg_253_1.leftNameTxt_.text = arg_253_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_253_1.leftNameTxt_.transform)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1.leftNameTxt_.text)
				SetActive(arg_253_1.iconTrs_.gameObject, true)
				arg_253_1.iconController_:SetSelectedState("hero")

				arg_253_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_253_1.callingController_:SetSelectedState("normal")

				arg_253_1.keyicon_.color = Color.New(1, 1, 1)
				arg_253_1.icon_.color = Color.New(1, 1, 1)

				local var_256_3 = arg_253_1:FormatText(arg_253_1:GetWordFromCfg(302031064).content)

				arg_253_1.text_.text = var_256_3

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_5 = 21 <= 0 and var_256_2 or var_256_2 * (utf8.len(var_256_3) / 21)

				if (21 <= 0 and var_256_2 or var_256_2 * (utf8.len(var_256_3) / 21)) > 0 and var_256_2 < var_256_5 then
					arg_253_1.talkMaxDuration = var_256_5

					if var_256_5 + var_256_1 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_5 + var_256_1
					end
				end

				arg_253_1.text_.text = var_256_3
				arg_253_1.typewritter.percent = 0

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(false)
				arg_253_1:RecordContent(arg_253_1.text_.text)
			end

			local var_256_6 = math.max(var_256_2, arg_253_1.talkMaxDuration)

			if var_256_1 <= arg_253_1.time_ and arg_253_1.time_ < var_256_1 + var_256_6 then
				arg_253_1.typewritter.percent = (arg_253_1.time_ - var_256_1) / var_256_6

				arg_253_1.typewritter:SetDirty()
			end

			if arg_253_1.time_ >= var_256_1 + var_256_6 and arg_253_1.time_ < var_256_1 + var_256_6 + arg_256_0 then
				arg_253_1.typewritter.percent = 1

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(true)
			end
		end

		arg_253_1.nodeConfigList_ = {}

		arg_253_1:InitPlayNodeList()
	end,
	Play302031065 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 302031065
		arg_257_1.duration_ = 5

		SetActive(arg_257_1.tipsGo_, false)

		function arg_257_1.onSingleLineFinish_()
			arg_257_1.onSingleLineUpdate_ = nil
			arg_257_1.onSingleLineFinish_ = nil
			arg_257_1.state_ = "waiting"
		end

		function arg_257_1.playNext_(arg_259_0)
			if arg_259_0 == 1 then
				arg_257_0:Play302031066(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			local var_260_0 = 0.45

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0
				arg_257_1.dialogCg_.alpha = 1

				arg_257_1.dialog_:SetActive(true)
				SetActive(arg_257_1.leftNameGo_, true)

				arg_257_1.leftNameTxt_.text = arg_257_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_257_1.leftNameTxt_.transform)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1.leftNameTxt_.text)
				SetActive(arg_257_1.iconTrs_.gameObject, true)
				arg_257_1.iconController_:SetSelectedState("hero")

				arg_257_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_257_1.callingController_:SetSelectedState("normal")

				arg_257_1.keyicon_.color = Color.New(1, 1, 1)
				arg_257_1.icon_.color = Color.New(1, 1, 1)

				local var_260_1 = arg_257_1:FormatText(arg_257_1:GetWordFromCfg(302031065).content)

				arg_257_1.text_.text = var_260_1

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_3 = 18 <= 0 and var_260_0 or var_260_0 * (utf8.len(var_260_1) / 18)

				if (18 <= 0 and var_260_0 or var_260_0 * (utf8.len(var_260_1) / 18)) > 0 and var_260_0 < var_260_3 then
					arg_257_1.talkMaxDuration = var_260_3

					if var_260_3 + 0 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_3 + 0
					end
				end

				arg_257_1.text_.text = var_260_1
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)
				arg_257_1:RecordContent(arg_257_1.text_.text)
			end

			local var_260_4 = math.max(var_260_0, arg_257_1.talkMaxDuration)

			if 0 <= arg_257_1.time_ and arg_257_1.time_ < 0 + var_260_4 then
				arg_257_1.typewritter.percent = (arg_257_1.time_ - 0) / var_260_4

				arg_257_1.typewritter:SetDirty()
			end

			if arg_257_1.time_ >= 0 + var_260_4 and arg_257_1.time_ < 0 + var_260_4 + arg_260_0 then
				arg_257_1.typewritter.percent = 1

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(true)
			end
		end

		arg_257_1.nodeConfigList_ = {}

		arg_257_1:InitPlayNodeList()
	end,
	Play302031066 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 302031066
		arg_261_1.duration_ = 2.8

		local var_261_0 = {
			zh = 2.8,
			ja = 1.999999999999
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
				arg_261_0:Play302031067(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 then
				arg_261_1.var_.moveOldPos1084ui_story = arg_261_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_264_0 = 0.001

			if 0 <= arg_261_1.time_ and arg_261_1.time_ < 0 + var_264_0 then
				arg_261_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_261_1.var_.moveOldPos1084ui_story, Vector3.New(-0.7, -0.97, -6), (arg_261_1.time_ - 0) / var_264_0)
				arg_261_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_261_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_261_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_261_1.actors_["1084ui_story"].transform.position).z)
				arg_261_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_261_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_261_1.actors_["1084ui_story"].transform.localEulerAngles = arg_261_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_261_1.time_ >= 0 + var_264_0 and arg_261_1.time_ < 0 + var_264_0 + arg_264_0 then
				arg_261_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(-0.7, -0.97, -6)
				arg_261_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_261_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_261_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_261_1.actors_["1084ui_story"].transform.position).z)
				arg_261_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_261_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_261_1.actors_["1084ui_story"].transform.localEulerAngles = arg_261_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_264_1 = arg_261_1.actors_["1166ui_story"].transform

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 then
				arg_261_1.var_.moveOldPos1166ui_story = var_264_1.localPosition

				local var_264_2 = GameObjectTools.GetOrAddComponent(var_264_1.gameObject, typeof(DynamicBoneHelper))

				if var_264_2 then
					var_264_2:EnableDynamicBone(false)
				end
			end

			local var_264_3 = 0.001

			if 0 <= arg_261_1.time_ and arg_261_1.time_ < 0 + var_264_3 then
				var_264_1.localPosition = Vector3.Lerp(arg_261_1.var_.moveOldPos1166ui_story, Vector3.New(0.7, -0.75, -6.25), (arg_261_1.time_ - 0) / var_264_3)
				var_264_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_264_1.position).x, (manager.ui.mainCamera.transform.position - var_264_1.position).y, (manager.ui.mainCamera.transform.position - var_264_1.position).z)
				var_264_1.localEulerAngles.z = 0
				var_264_1.localEulerAngles.x = 0
				var_264_1.localEulerAngles = var_264_1.localEulerAngles
			end

			if arg_261_1.time_ >= 0 + var_264_3 and arg_261_1.time_ < 0 + var_264_3 + arg_264_0 then
				var_264_1.localPosition = Vector3.New(0.7, -0.75, -6.25)
				var_264_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_264_1.position).x, (manager.ui.mainCamera.transform.position - var_264_1.position).y, (manager.ui.mainCamera.transform.position - var_264_1.position).z)
				var_264_1.localEulerAngles.z = 0
				var_264_1.localEulerAngles.x = 0
				var_264_1.localEulerAngles = var_264_1.localEulerAngles

				local var_264_4 = GameObjectTools.GetOrAddComponent(var_264_1.gameObject, typeof(DynamicBoneHelper))

				if var_264_4 then
					var_264_4:EnableDynamicBone(true)
				end
			end

			local var_264_5 = arg_261_1.actors_["1166ui_story"]

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 and not isNil(var_264_5) and arg_261_1.var_.characterEffect1166ui_story == nil then
				arg_261_1.var_.characterEffect1166ui_story = var_264_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_264_6 = 0.200000002980232

			if 0 <= arg_261_1.time_ and arg_261_1.time_ < 0 + var_264_6 and not isNil(var_264_5) then
				if arg_261_1.var_.characterEffect1166ui_story and not isNil(var_264_5) then
					arg_261_1.var_.characterEffect1166ui_story.fillFlat = false
				end
			end

			if arg_261_1.time_ >= 0 + var_264_6 and arg_261_1.time_ < 0 + var_264_6 + arg_264_0 and not isNil(var_264_5) and arg_261_1.var_.characterEffect1166ui_story then
				arg_261_1.var_.characterEffect1166ui_story.fillFlat = false
			end

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 then
				arg_261_1:PlayTimeline("1166ui_story", "StoryTimeline/CharAction/story1166/story1166action/1166action3_1")
			end

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 then
				arg_261_1:PlayTimeline("1166ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_264_8 = 0
			local var_264_9 = 0.3

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= var_264_8 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0
				arg_261_1.dialogCg_.alpha = 1

				arg_261_1.dialog_:SetActive(true)
				SetActive(arg_261_1.leftNameGo_, true)

				arg_261_1.leftNameTxt_.text = arg_261_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_261_1.leftNameTxt_.transform)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1.leftNameTxt_.text)
				SetActive(arg_261_1.iconTrs_.gameObject, false)
				arg_261_1.callingController_:SetSelectedState("normal")

				local var_264_10 = arg_261_1:GetWordFromCfg(302031066)
				local var_264_11 = arg_261_1:FormatText(var_264_10.content)

				arg_261_1.text_.text = var_264_11

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_13 = 12 <= 0 and var_264_9 or var_264_9 * (utf8.len(var_264_11) / 12)

				if (12 <= 0 and var_264_9 or var_264_9 * (utf8.len(var_264_11) / 12)) > 0 and var_264_9 < var_264_13 then
					arg_261_1.talkMaxDuration = var_264_13

					if var_264_13 + var_264_8 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_13 + var_264_8
					end
				end

				arg_261_1.text_.text = var_264_11
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302031", "302031066", "story_v_out_302031.awb") ~= 0 then
					local var_264_14 = manager.audio:GetVoiceLength("story_v_out_302031", "302031066", "story_v_out_302031.awb") / 1000

					if var_264_14 + var_264_8 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_14 + var_264_8
					end

					if var_264_10.prefab_name ~= "" and arg_261_1.actors_[var_264_10.prefab_name] ~= nil then
						local var_264_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_261_1.actors_[var_264_10.prefab_name].transform, "story_v_out_302031", "302031066", "story_v_out_302031.awb")

						arg_261_1:RecordAudio("302031066", var_264_15)
						arg_261_1:RecordAudio("302031066", var_264_15)
					else
						arg_261_1:AudioAction("play", "voice", "story_v_out_302031", "302031066", "story_v_out_302031.awb")
					end

					arg_261_1:RecordHistoryTalkVoice("story_v_out_302031", "302031066", "story_v_out_302031.awb")
				end

				arg_261_1:RecordContent(arg_261_1.text_.text)
			end

			local var_264_16 = math.max(var_264_9, arg_261_1.talkMaxDuration)

			if var_264_8 <= arg_261_1.time_ and arg_261_1.time_ < var_264_8 + var_264_16 then
				arg_261_1.typewritter.percent = (arg_261_1.time_ - var_264_8) / var_264_16

				arg_261_1.typewritter:SetDirty()
			end

			if arg_261_1.time_ >= var_264_8 + var_264_16 and arg_261_1.time_ < var_264_8 + var_264_16 + arg_264_0 then
				arg_261_1.typewritter.percent = 1

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(true)
			end
		end

		arg_261_1.nodeConfigList_ = {
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
				actorName = "1166ui_story",
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
	Play302031067 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 302031067
		arg_265_1.duration_ = 5

		SetActive(arg_265_1.tipsGo_, false)

		function arg_265_1.onSingleLineFinish_()
			arg_265_1.onSingleLineUpdate_ = nil
			arg_265_1.onSingleLineFinish_ = nil
			arg_265_1.state_ = "waiting"
		end

		function arg_265_1.playNext_(arg_267_0)
			if arg_267_0 == 1 then
				arg_265_0:Play302031068(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 then
				arg_265_1.var_.moveOldPos1084ui_story = arg_265_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_268_0 = 0.001

			if 0 <= arg_265_1.time_ and arg_265_1.time_ < 0 + var_268_0 then
				arg_265_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_265_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_265_1.time_ - 0) / var_268_0)
				arg_265_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_265_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_265_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_265_1.actors_["1084ui_story"].transform.position).z)
				arg_265_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_265_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_265_1.actors_["1084ui_story"].transform.localEulerAngles = arg_265_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_265_1.time_ >= 0 + var_268_0 and arg_265_1.time_ < 0 + var_268_0 + arg_268_0 then
				arg_265_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_265_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_265_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_265_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_265_1.actors_["1084ui_story"].transform.position).z)
				arg_265_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_265_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_265_1.actors_["1084ui_story"].transform.localEulerAngles = arg_265_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_268_1 = arg_265_1.actors_["1166ui_story"].transform

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 then
				arg_265_1.var_.moveOldPos1166ui_story = var_268_1.localPosition

				local var_268_2 = GameObjectTools.GetOrAddComponent(var_268_1.gameObject, typeof(DynamicBoneHelper))

				if var_268_2 then
					var_268_2:EnableDynamicBone(false)
				end
			end

			local var_268_3 = 0.001

			if 0 <= arg_265_1.time_ and arg_265_1.time_ < 0 + var_268_3 then
				var_268_1.localPosition = Vector3.Lerp(arg_265_1.var_.moveOldPos1166ui_story, Vector3.New(0, 100, 0), (arg_265_1.time_ - 0) / var_268_3)
				var_268_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_268_1.position).x, (manager.ui.mainCamera.transform.position - var_268_1.position).y, (manager.ui.mainCamera.transform.position - var_268_1.position).z)
				var_268_1.localEulerAngles.z = 0
				var_268_1.localEulerAngles.x = 0
				var_268_1.localEulerAngles = var_268_1.localEulerAngles
			end

			if arg_265_1.time_ >= 0 + var_268_3 and arg_265_1.time_ < 0 + var_268_3 + arg_268_0 then
				var_268_1.localPosition = Vector3.New(0, 100, 0)
				var_268_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_268_1.position).x, (manager.ui.mainCamera.transform.position - var_268_1.position).y, (manager.ui.mainCamera.transform.position - var_268_1.position).z)
				var_268_1.localEulerAngles.z = 0
				var_268_1.localEulerAngles.x = 0
				var_268_1.localEulerAngles = var_268_1.localEulerAngles

				local var_268_4 = GameObjectTools.GetOrAddComponent(var_268_1.gameObject, typeof(DynamicBoneHelper))

				if var_268_4 then
					var_268_4:EnableDynamicBone(true)
				end
			end

			local var_268_5 = arg_265_1.actors_["1166ui_story"]

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 and not isNil(var_268_5) and arg_265_1.var_.characterEffect1166ui_story == nil then
				arg_265_1.var_.characterEffect1166ui_story = var_268_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_268_6 = 0.200000002980232

			if 0 <= arg_265_1.time_ and arg_265_1.time_ < 0 + var_268_6 and not isNil(var_268_5) then
				if arg_265_1.var_.characterEffect1166ui_story and not isNil(var_268_5) then
					arg_265_1.var_.characterEffect1166ui_story.fillFlat = true
					arg_265_1.var_.characterEffect1166ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_265_1.time_ - 0) / var_268_6)
				end
			end

			if arg_265_1.time_ >= 0 + var_268_6 and arg_265_1.time_ < 0 + var_268_6 + arg_268_0 and not isNil(var_268_5) and arg_265_1.var_.characterEffect1166ui_story then
				arg_265_1.var_.characterEffect1166ui_story.fillFlat = true
				arg_265_1.var_.characterEffect1166ui_story.fillRatio = 0.5
			end

			local var_268_7 = 0
			local var_268_8 = 1.775

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= var_268_7 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0
				arg_265_1.dialogCg_.alpha = 1

				arg_265_1.dialog_:SetActive(true)
				SetActive(arg_265_1.leftNameGo_, false)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_265_1.iconTrs_.gameObject, false)
				arg_265_1.callingController_:SetSelectedState("normal")

				local var_268_9 = arg_265_1:FormatText(arg_265_1:GetWordFromCfg(302031067).content)

				arg_265_1.text_.text = var_268_9

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_11 = 71 <= 0 and var_268_8 or var_268_8 * (utf8.len(var_268_9) / 71)

				if (71 <= 0 and var_268_8 or var_268_8 * (utf8.len(var_268_9) / 71)) > 0 and var_268_8 < var_268_11 then
					arg_265_1.talkMaxDuration = var_268_11

					if var_268_11 + var_268_7 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_11 + var_268_7
					end
				end

				arg_265_1.text_.text = var_268_9
				arg_265_1.typewritter.percent = 0

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(false)
				arg_265_1:RecordContent(arg_265_1.text_.text)
			end

			local var_268_12 = math.max(var_268_8, arg_265_1.talkMaxDuration)

			if var_268_7 <= arg_265_1.time_ and arg_265_1.time_ < var_268_7 + var_268_12 then
				arg_265_1.typewritter.percent = (arg_265_1.time_ - var_268_7) / var_268_12

				arg_265_1.typewritter:SetDirty()
			end

			if arg_265_1.time_ >= var_268_7 + var_268_12 and arg_265_1.time_ < var_268_7 + var_268_12 + arg_268_0 then
				arg_265_1.typewritter.percent = 1

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(true)
			end
		end

		arg_265_1.nodeConfigList_ = {
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
				actorName = "1166ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_265_1:InitPlayNodeList()
	end,
	Play302031068 = function(arg_269_0, arg_269_1)
		arg_269_1.time_ = 0
		arg_269_1.frameCnt_ = 0
		arg_269_1.state_ = "playing"
		arg_269_1.curTalkId_ = 302031068
		arg_269_1.duration_ = 3.9

		local var_269_0 = {
			zh = 3.9,
			ja = 2.4
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
		end

		function arg_269_1.playNext_(arg_271_0)
			if arg_271_0 == 1 then
				arg_269_0:Play302031069(arg_269_1)
			end
		end

		function arg_269_1.onSingleLineUpdate_(arg_272_0)
			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 then
				arg_269_1.var_.moveOldPos1084ui_story = arg_269_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_272_0 = 0.001

			if 0 <= arg_269_1.time_ and arg_269_1.time_ < 0 + var_272_0 then
				arg_269_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_269_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_269_1.time_ - 0) / var_272_0)
				arg_269_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_269_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_269_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_269_1.actors_["1084ui_story"].transform.position).z)
				arg_269_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_269_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_269_1.actors_["1084ui_story"].transform.localEulerAngles = arg_269_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_269_1.time_ >= 0 + var_272_0 and arg_269_1.time_ < 0 + var_272_0 + arg_272_0 then
				arg_269_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, -0.97, -6)
				arg_269_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_269_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_269_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_269_1.actors_["1084ui_story"].transform.position).z)
				arg_269_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_269_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_269_1.actors_["1084ui_story"].transform.localEulerAngles = arg_269_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_272_1 = arg_269_1.actors_["1084ui_story"]

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 and not isNil(var_272_1) and arg_269_1.var_.characterEffect1084ui_story == nil then
				arg_269_1.var_.characterEffect1084ui_story = var_272_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_272_2 = 0.200000002980232

			if 0 <= arg_269_1.time_ and arg_269_1.time_ < 0 + var_272_2 and not isNil(var_272_1) then
				if arg_269_1.var_.characterEffect1084ui_story and not isNil(var_272_1) then
					arg_269_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_269_1.time_ >= 0 + var_272_2 and arg_269_1.time_ < 0 + var_272_2 + arg_272_0 and not isNil(var_272_1) and arg_269_1.var_.characterEffect1084ui_story then
				arg_269_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 then
				arg_269_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action4_1")
			end

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 then
				arg_269_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva", "EmotionTimelineAnimator")
			end

			local var_272_4 = 0
			local var_272_5 = 0.375

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= var_272_4 + arg_272_0 then
				arg_269_1.talkMaxDuration = 0
				arg_269_1.dialogCg_.alpha = 1

				arg_269_1.dialog_:SetActive(true)
				SetActive(arg_269_1.leftNameGo_, true)

				arg_269_1.leftNameTxt_.text = arg_269_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_269_1.leftNameTxt_.transform)

				arg_269_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_269_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_269_1:RecordName(arg_269_1.leftNameTxt_.text)
				SetActive(arg_269_1.iconTrs_.gameObject, false)
				arg_269_1.callingController_:SetSelectedState("normal")

				local var_272_6 = arg_269_1:GetWordFromCfg(302031068)
				local var_272_7 = arg_269_1:FormatText(var_272_6.content)

				arg_269_1.text_.text = var_272_7

				LuaForUtil.ClearLinePrefixSymbol(arg_269_1.text_)

				local var_272_9 = 15 <= 0 and var_272_5 or var_272_5 * (utf8.len(var_272_7) / 15)

				if (15 <= 0 and var_272_5 or var_272_5 * (utf8.len(var_272_7) / 15)) > 0 and var_272_5 < var_272_9 then
					arg_269_1.talkMaxDuration = var_272_9

					if var_272_9 + var_272_4 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_9 + var_272_4
					end
				end

				arg_269_1.text_.text = var_272_7
				arg_269_1.typewritter.percent = 0

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302031", "302031068", "story_v_out_302031.awb") ~= 0 then
					local var_272_10 = manager.audio:GetVoiceLength("story_v_out_302031", "302031068", "story_v_out_302031.awb") / 1000

					if var_272_10 + var_272_4 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_10 + var_272_4
					end

					if var_272_6.prefab_name ~= "" and arg_269_1.actors_[var_272_6.prefab_name] ~= nil then
						local var_272_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_269_1.actors_[var_272_6.prefab_name].transform, "story_v_out_302031", "302031068", "story_v_out_302031.awb")

						arg_269_1:RecordAudio("302031068", var_272_11)
						arg_269_1:RecordAudio("302031068", var_272_11)
					else
						arg_269_1:AudioAction("play", "voice", "story_v_out_302031", "302031068", "story_v_out_302031.awb")
					end

					arg_269_1:RecordHistoryTalkVoice("story_v_out_302031", "302031068", "story_v_out_302031.awb")
				end

				arg_269_1:RecordContent(arg_269_1.text_.text)
			end

			local var_272_12 = math.max(var_272_5, arg_269_1.talkMaxDuration)

			if var_272_4 <= arg_269_1.time_ and arg_269_1.time_ < var_272_4 + var_272_12 then
				arg_269_1.typewritter.percent = (arg_269_1.time_ - var_272_4) / var_272_12

				arg_269_1.typewritter:SetDirty()
			end

			if arg_269_1.time_ >= var_272_4 + var_272_12 and arg_269_1.time_ < var_272_4 + var_272_12 + arg_272_0 then
				arg_269_1.typewritter.percent = 1

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(true)
			end
		end

		arg_269_1.nodeConfigList_ = {
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

		arg_269_1:InitPlayNodeList()
	end,
	Play302031069 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 302031069
		arg_273_1.duration_ = 5

		SetActive(arg_273_1.tipsGo_, false)

		function arg_273_1.onSingleLineFinish_()
			arg_273_1.onSingleLineUpdate_ = nil
			arg_273_1.onSingleLineFinish_ = nil
			arg_273_1.state_ = "waiting"
		end

		function arg_273_1.playNext_(arg_275_0)
			if arg_275_0 == 1 then
				arg_273_0:Play302031070(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 and not isNil(arg_273_1.actors_["1084ui_story"]) and arg_273_1.var_.characterEffect1084ui_story == nil then
				arg_273_1.var_.characterEffect1084ui_story = arg_273_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_276_0 = 0.200000002980232

			if 0 <= arg_273_1.time_ and arg_273_1.time_ < 0 + var_276_0 and not isNil(arg_273_1.actors_["1084ui_story"]) then
				if arg_273_1.var_.characterEffect1084ui_story and not isNil(arg_273_1.actors_["1084ui_story"]) then
					arg_273_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_273_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_273_1.time_ - 0) / var_276_0)
				end
			end

			if arg_273_1.time_ >= 0 + var_276_0 and arg_273_1.time_ < 0 + var_276_0 + arg_276_0 and not isNil(arg_273_1.actors_["1084ui_story"]) and arg_273_1.var_.characterEffect1084ui_story then
				arg_273_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_273_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_276_1 = 0
			local var_276_2 = 0.3

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= var_276_1 + arg_276_0 then
				arg_273_1.talkMaxDuration = 0
				arg_273_1.dialogCg_.alpha = 1

				arg_273_1.dialog_:SetActive(true)
				SetActive(arg_273_1.leftNameGo_, true)

				arg_273_1.leftNameTxt_.text = arg_273_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_273_1.leftNameTxt_.transform)

				arg_273_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_273_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_273_1:RecordName(arg_273_1.leftNameTxt_.text)
				SetActive(arg_273_1.iconTrs_.gameObject, true)
				arg_273_1.iconController_:SetSelectedState("hero")

				arg_273_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_273_1.callingController_:SetSelectedState("normal")

				arg_273_1.keyicon_.color = Color.New(1, 1, 1)
				arg_273_1.icon_.color = Color.New(1, 1, 1)

				local var_276_3 = arg_273_1:FormatText(arg_273_1:GetWordFromCfg(302031069).content)

				arg_273_1.text_.text = var_276_3

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_5 = 12 <= 0 and var_276_2 or var_276_2 * (utf8.len(var_276_3) / 12)

				if (12 <= 0 and var_276_2 or var_276_2 * (utf8.len(var_276_3) / 12)) > 0 and var_276_2 < var_276_5 then
					arg_273_1.talkMaxDuration = var_276_5

					if var_276_5 + var_276_1 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_5 + var_276_1
					end
				end

				arg_273_1.text_.text = var_276_3
				arg_273_1.typewritter.percent = 0

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(false)
				arg_273_1:RecordContent(arg_273_1.text_.text)
			end

			local var_276_6 = math.max(var_276_2, arg_273_1.talkMaxDuration)

			if var_276_1 <= arg_273_1.time_ and arg_273_1.time_ < var_276_1 + var_276_6 then
				arg_273_1.typewritter.percent = (arg_273_1.time_ - var_276_1) / var_276_6

				arg_273_1.typewritter:SetDirty()
			end

			if arg_273_1.time_ >= var_276_1 + var_276_6 and arg_273_1.time_ < var_276_1 + var_276_6 + arg_276_0 then
				arg_273_1.typewritter.percent = 1

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(true)
			end
		end

		arg_273_1.nodeConfigList_ = {}

		arg_273_1:InitPlayNodeList()
	end,
	Play302031070 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 302031070
		arg_277_1.duration_ = 5

		SetActive(arg_277_1.tipsGo_, false)

		function arg_277_1.onSingleLineFinish_()
			arg_277_1.onSingleLineUpdate_ = nil
			arg_277_1.onSingleLineFinish_ = nil
			arg_277_1.state_ = "waiting"
		end

		function arg_277_1.playNext_(arg_279_0)
			if arg_279_0 == 1 then
				arg_277_0:Play302031071(arg_277_1)
			end
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			local var_280_0 = 0.45

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 then
				arg_277_1.talkMaxDuration = 0
				arg_277_1.dialogCg_.alpha = 1

				arg_277_1.dialog_:SetActive(true)
				SetActive(arg_277_1.leftNameGo_, true)

				arg_277_1.leftNameTxt_.text = arg_277_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_277_1.leftNameTxt_.transform)

				arg_277_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_277_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_277_1:RecordName(arg_277_1.leftNameTxt_.text)
				SetActive(arg_277_1.iconTrs_.gameObject, true)
				arg_277_1.iconController_:SetSelectedState("hero")

				arg_277_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_277_1.callingController_:SetSelectedState("normal")

				arg_277_1.keyicon_.color = Color.New(1, 1, 1)
				arg_277_1.icon_.color = Color.New(1, 1, 1)

				local var_280_1 = arg_277_1:FormatText(arg_277_1:GetWordFromCfg(302031070).content)

				arg_277_1.text_.text = var_280_1

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_)

				local var_280_3 = 18 <= 0 and var_280_0 or var_280_0 * (utf8.len(var_280_1) / 18)

				if (18 <= 0 and var_280_0 or var_280_0 * (utf8.len(var_280_1) / 18)) > 0 and var_280_0 < var_280_3 then
					arg_277_1.talkMaxDuration = var_280_3

					if var_280_3 + 0 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_3 + 0
					end
				end

				arg_277_1.text_.text = var_280_1
				arg_277_1.typewritter.percent = 0

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(false)
				arg_277_1:RecordContent(arg_277_1.text_.text)
			end

			local var_280_4 = math.max(var_280_0, arg_277_1.talkMaxDuration)

			if 0 <= arg_277_1.time_ and arg_277_1.time_ < 0 + var_280_4 then
				arg_277_1.typewritter.percent = (arg_277_1.time_ - 0) / var_280_4

				arg_277_1.typewritter:SetDirty()
			end

			if arg_277_1.time_ >= 0 + var_280_4 and arg_277_1.time_ < 0 + var_280_4 + arg_280_0 then
				arg_277_1.typewritter.percent = 1

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(true)
			end
		end

		arg_277_1.nodeConfigList_ = {}

		arg_277_1:InitPlayNodeList()
	end,
	Play302031071 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 302031071
		arg_281_1.duration_ = 5

		SetActive(arg_281_1.tipsGo_, false)

		function arg_281_1.onSingleLineFinish_()
			arg_281_1.onSingleLineUpdate_ = nil
			arg_281_1.onSingleLineFinish_ = nil
			arg_281_1.state_ = "waiting"
		end

		function arg_281_1.playNext_(arg_283_0)
			if arg_283_0 == 1 then
				arg_281_0:Play302031072(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 then
				arg_281_1.var_.moveOldPos1084ui_story = arg_281_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_284_0 = 0.001

			if 0 <= arg_281_1.time_ and arg_281_1.time_ < 0 + var_284_0 then
				arg_281_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_281_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_281_1.time_ - 0) / var_284_0)
				arg_281_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_281_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_281_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_281_1.actors_["1084ui_story"].transform.position).z)
				arg_281_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_281_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_281_1.actors_["1084ui_story"].transform.localEulerAngles = arg_281_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_281_1.time_ >= 0 + var_284_0 and arg_281_1.time_ < 0 + var_284_0 + arg_284_0 then
				arg_281_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_281_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_281_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_281_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_281_1.actors_["1084ui_story"].transform.position).z)
				arg_281_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_281_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_281_1.actors_["1084ui_story"].transform.localEulerAngles = arg_281_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_284_1 = 0
			local var_284_2 = 1.6

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= var_284_1 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0
				arg_281_1.dialogCg_.alpha = 1

				arg_281_1.dialog_:SetActive(true)
				SetActive(arg_281_1.leftNameGo_, false)

				arg_281_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_281_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_281_1:RecordName(arg_281_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_281_1.iconTrs_.gameObject, false)
				arg_281_1.callingController_:SetSelectedState("normal")

				local var_284_3 = arg_281_1:FormatText(arg_281_1:GetWordFromCfg(302031071).content)

				arg_281_1.text_.text = var_284_3

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_5 = 64 <= 0 and var_284_2 or var_284_2 * (utf8.len(var_284_3) / 64)

				if (64 <= 0 and var_284_2 or var_284_2 * (utf8.len(var_284_3) / 64)) > 0 and var_284_2 < var_284_5 then
					arg_281_1.talkMaxDuration = var_284_5

					if var_284_5 + var_284_1 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_5 + var_284_1
					end
				end

				arg_281_1.text_.text = var_284_3
				arg_281_1.typewritter.percent = 0

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(false)
				arg_281_1:RecordContent(arg_281_1.text_.text)
			end

			local var_284_6 = math.max(var_284_2, arg_281_1.talkMaxDuration)

			if var_284_1 <= arg_281_1.time_ and arg_281_1.time_ < var_284_1 + var_284_6 then
				arg_281_1.typewritter.percent = (arg_281_1.time_ - var_284_1) / var_284_6

				arg_281_1.typewritter:SetDirty()
			end

			if arg_281_1.time_ >= var_284_1 + var_284_6 and arg_281_1.time_ < var_284_1 + var_284_6 + arg_284_0 then
				arg_281_1.typewritter.percent = 1

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(true)
			end
		end

		arg_281_1.nodeConfigList_ = {
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

		arg_281_1:InitPlayNodeList()
	end,
	Play302031072 = function(arg_285_0, arg_285_1)
		arg_285_1.time_ = 0
		arg_285_1.frameCnt_ = 0
		arg_285_1.state_ = "playing"
		arg_285_1.curTalkId_ = 302031072
		arg_285_1.duration_ = 5

		SetActive(arg_285_1.tipsGo_, false)

		function arg_285_1.onSingleLineFinish_()
			arg_285_1.onSingleLineUpdate_ = nil
			arg_285_1.onSingleLineFinish_ = nil
			arg_285_1.state_ = "waiting"
		end

		function arg_285_1.playNext_(arg_287_0)
			if arg_287_0 == 1 then
				arg_285_0:Play302031073(arg_285_1)
			end
		end

		function arg_285_1.onSingleLineUpdate_(arg_288_0)
			local var_288_0 = 0.15

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 then
				arg_285_1.talkMaxDuration = 0
				arg_285_1.dialogCg_.alpha = 1

				arg_285_1.dialog_:SetActive(true)
				SetActive(arg_285_1.leftNameGo_, true)

				arg_285_1.leftNameTxt_.text = arg_285_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_285_1.leftNameTxt_.transform)

				arg_285_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_285_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_285_1:RecordName(arg_285_1.leftNameTxt_.text)
				SetActive(arg_285_1.iconTrs_.gameObject, true)
				arg_285_1.iconController_:SetSelectedState("hero")

				arg_285_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_285_1.callingController_:SetSelectedState("normal")

				arg_285_1.keyicon_.color = Color.New(1, 1, 1)
				arg_285_1.icon_.color = Color.New(1, 1, 1)

				local var_288_1 = arg_285_1:FormatText(arg_285_1:GetWordFromCfg(302031072).content)

				arg_285_1.text_.text = var_288_1

				LuaForUtil.ClearLinePrefixSymbol(arg_285_1.text_)

				local var_288_3 = 6 <= 0 and var_288_0 or var_288_0 * (utf8.len(var_288_1) / 6)

				if (6 <= 0 and var_288_0 or var_288_0 * (utf8.len(var_288_1) / 6)) > 0 and var_288_0 < var_288_3 then
					arg_285_1.talkMaxDuration = var_288_3

					if var_288_3 + 0 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_3 + 0
					end
				end

				arg_285_1.text_.text = var_288_1
				arg_285_1.typewritter.percent = 0

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(false)
				arg_285_1:RecordContent(arg_285_1.text_.text)
			end

			local var_288_4 = math.max(var_288_0, arg_285_1.talkMaxDuration)

			if 0 <= arg_285_1.time_ and arg_285_1.time_ < 0 + var_288_4 then
				arg_285_1.typewritter.percent = (arg_285_1.time_ - 0) / var_288_4

				arg_285_1.typewritter:SetDirty()
			end

			if arg_285_1.time_ >= 0 + var_288_4 and arg_285_1.time_ < 0 + var_288_4 + arg_288_0 then
				arg_285_1.typewritter.percent = 1

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(true)
			end
		end

		arg_285_1.nodeConfigList_ = {}

		arg_285_1:InitPlayNodeList()
	end,
	Play302031073 = function(arg_289_0, arg_289_1)
		arg_289_1.time_ = 0
		arg_289_1.frameCnt_ = 0
		arg_289_1.state_ = "playing"
		arg_289_1.curTalkId_ = 302031073
		arg_289_1.duration_ = 4.1

		local var_289_0 = {
			zh = 4.1,
			ja = 1.999999999999
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
				arg_289_0:Play302031074(arg_289_1)
			end
		end

		function arg_289_1.onSingleLineUpdate_(arg_292_0)
			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 then
				arg_289_1.var_.moveOldPos1166ui_story = arg_289_1.actors_["1166ui_story"].transform.localPosition

				local var_292_0 = GameObjectTools.GetOrAddComponent(arg_289_1.actors_["1166ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_292_0 then
					var_292_0:EnableDynamicBone(false)
				end
			end

			local var_292_1 = 0.001

			if 0 <= arg_289_1.time_ and arg_289_1.time_ < 0 + var_292_1 then
				arg_289_1.actors_["1166ui_story"].transform.localPosition = Vector3.Lerp(arg_289_1.var_.moveOldPos1166ui_story, Vector3.New(0, -0.75, -6.25), (arg_289_1.time_ - 0) / var_292_1)
				arg_289_1.actors_["1166ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_289_1.actors_["1166ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_289_1.actors_["1166ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_289_1.actors_["1166ui_story"].transform.position).z)
				arg_289_1.actors_["1166ui_story"].transform.localEulerAngles.z = 0
				arg_289_1.actors_["1166ui_story"].transform.localEulerAngles.x = 0
				arg_289_1.actors_["1166ui_story"].transform.localEulerAngles = arg_289_1.actors_["1166ui_story"].transform.localEulerAngles
			end

			if arg_289_1.time_ >= 0 + var_292_1 and arg_289_1.time_ < 0 + var_292_1 + arg_292_0 then
				arg_289_1.actors_["1166ui_story"].transform.localPosition = Vector3.New(0, -0.75, -6.25)
				arg_289_1.actors_["1166ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_289_1.actors_["1166ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_289_1.actors_["1166ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_289_1.actors_["1166ui_story"].transform.position).z)
				arg_289_1.actors_["1166ui_story"].transform.localEulerAngles.z = 0
				arg_289_1.actors_["1166ui_story"].transform.localEulerAngles.x = 0
				arg_289_1.actors_["1166ui_story"].transform.localEulerAngles = arg_289_1.actors_["1166ui_story"].transform.localEulerAngles

				local var_292_2 = GameObjectTools.GetOrAddComponent(arg_289_1.actors_["1166ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_292_2 then
					var_292_2:EnableDynamicBone(true)
				end
			end

			local var_292_3 = arg_289_1.actors_["1166ui_story"]

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 and not isNil(var_292_3) and arg_289_1.var_.characterEffect1166ui_story == nil then
				arg_289_1.var_.characterEffect1166ui_story = var_292_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_292_4 = 0.200000002980232

			if 0 <= arg_289_1.time_ and arg_289_1.time_ < 0 + var_292_4 and not isNil(var_292_3) then
				if arg_289_1.var_.characterEffect1166ui_story and not isNil(var_292_3) then
					arg_289_1.var_.characterEffect1166ui_story.fillFlat = false
				end
			end

			if arg_289_1.time_ >= 0 + var_292_4 and arg_289_1.time_ < 0 + var_292_4 + arg_292_0 and not isNil(var_292_3) and arg_289_1.var_.characterEffect1166ui_story then
				arg_289_1.var_.characterEffect1166ui_story.fillFlat = false
			end

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 then
				arg_289_1:PlayTimeline("1166ui_story", "StoryTimeline/CharAction/story1166/story1166action/1166action1_1")
			end

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 then
				arg_289_1:PlayTimeline("1166ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiB", "EmotionTimelineAnimator")
			end

			local var_292_6 = 0
			local var_292_7 = 0.4

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= var_292_6 + arg_292_0 then
				arg_289_1.talkMaxDuration = 0
				arg_289_1.dialogCg_.alpha = 1

				arg_289_1.dialog_:SetActive(true)
				SetActive(arg_289_1.leftNameGo_, true)

				arg_289_1.leftNameTxt_.text = arg_289_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_289_1.leftNameTxt_.transform)

				arg_289_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_289_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_289_1:RecordName(arg_289_1.leftNameTxt_.text)
				SetActive(arg_289_1.iconTrs_.gameObject, false)
				arg_289_1.callingController_:SetSelectedState("normal")

				local var_292_8 = arg_289_1:GetWordFromCfg(302031073)
				local var_292_9 = arg_289_1:FormatText(var_292_8.content)

				arg_289_1.text_.text = var_292_9

				LuaForUtil.ClearLinePrefixSymbol(arg_289_1.text_)

				local var_292_11 = 16 <= 0 and var_292_7 or var_292_7 * (utf8.len(var_292_9) / 16)

				if (16 <= 0 and var_292_7 or var_292_7 * (utf8.len(var_292_9) / 16)) > 0 and var_292_7 < var_292_11 then
					arg_289_1.talkMaxDuration = var_292_11

					if var_292_11 + var_292_6 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_11 + var_292_6
					end
				end

				arg_289_1.text_.text = var_292_9
				arg_289_1.typewritter.percent = 0

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302031", "302031073", "story_v_out_302031.awb") ~= 0 then
					local var_292_12 = manager.audio:GetVoiceLength("story_v_out_302031", "302031073", "story_v_out_302031.awb") / 1000

					if var_292_12 + var_292_6 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_12 + var_292_6
					end

					if var_292_8.prefab_name ~= "" and arg_289_1.actors_[var_292_8.prefab_name] ~= nil then
						local var_292_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_289_1.actors_[var_292_8.prefab_name].transform, "story_v_out_302031", "302031073", "story_v_out_302031.awb")

						arg_289_1:RecordAudio("302031073", var_292_13)
						arg_289_1:RecordAudio("302031073", var_292_13)
					else
						arg_289_1:AudioAction("play", "voice", "story_v_out_302031", "302031073", "story_v_out_302031.awb")
					end

					arg_289_1:RecordHistoryTalkVoice("story_v_out_302031", "302031073", "story_v_out_302031.awb")
				end

				arg_289_1:RecordContent(arg_289_1.text_.text)
			end

			local var_292_14 = math.max(var_292_7, arg_289_1.talkMaxDuration)

			if var_292_6 <= arg_289_1.time_ and arg_289_1.time_ < var_292_6 + var_292_14 then
				arg_289_1.typewritter.percent = (arg_289_1.time_ - var_292_6) / var_292_14

				arg_289_1.typewritter:SetDirty()
			end

			if arg_289_1.time_ >= var_292_6 + var_292_14 and arg_289_1.time_ < var_292_6 + var_292_14 + arg_292_0 then
				arg_289_1.typewritter.percent = 1

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(true)
			end
		end

		arg_289_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1166ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_289_1:InitPlayNodeList()
	end,
	Play302031074 = function(arg_293_0, arg_293_1)
		arg_293_1.time_ = 0
		arg_293_1.frameCnt_ = 0
		arg_293_1.state_ = "playing"
		arg_293_1.curTalkId_ = 302031074
		arg_293_1.duration_ = 5

		SetActive(arg_293_1.tipsGo_, false)

		function arg_293_1.onSingleLineFinish_()
			arg_293_1.onSingleLineUpdate_ = nil
			arg_293_1.onSingleLineFinish_ = nil
			arg_293_1.state_ = "waiting"
		end

		function arg_293_1.playNext_(arg_295_0)
			if arg_295_0 == 1 then
				arg_293_0:Play302031075(arg_293_1)
			end
		end

		function arg_293_1.onSingleLineUpdate_(arg_296_0)
			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 and not isNil(arg_293_1.actors_["1166ui_story"]) and arg_293_1.var_.characterEffect1166ui_story == nil then
				arg_293_1.var_.characterEffect1166ui_story = arg_293_1.actors_["1166ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_296_0 = 0.200000002980232

			if 0 <= arg_293_1.time_ and arg_293_1.time_ < 0 + var_296_0 and not isNil(arg_293_1.actors_["1166ui_story"]) then
				if arg_293_1.var_.characterEffect1166ui_story and not isNil(arg_293_1.actors_["1166ui_story"]) then
					arg_293_1.var_.characterEffect1166ui_story.fillFlat = true
					arg_293_1.var_.characterEffect1166ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_293_1.time_ - 0) / var_296_0)
				end
			end

			if arg_293_1.time_ >= 0 + var_296_0 and arg_293_1.time_ < 0 + var_296_0 + arg_296_0 and not isNil(arg_293_1.actors_["1166ui_story"]) and arg_293_1.var_.characterEffect1166ui_story then
				arg_293_1.var_.characterEffect1166ui_story.fillFlat = true
				arg_293_1.var_.characterEffect1166ui_story.fillRatio = 0.5
			end

			local var_296_1 = 0
			local var_296_2 = 0.35

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= var_296_1 + arg_296_0 then
				arg_293_1.talkMaxDuration = 0
				arg_293_1.dialogCg_.alpha = 1

				arg_293_1.dialog_:SetActive(true)
				SetActive(arg_293_1.leftNameGo_, true)

				arg_293_1.leftNameTxt_.text = arg_293_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_293_1.leftNameTxt_.transform)

				arg_293_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_293_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_293_1:RecordName(arg_293_1.leftNameTxt_.text)
				SetActive(arg_293_1.iconTrs_.gameObject, true)
				arg_293_1.iconController_:SetSelectedState("hero")

				arg_293_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_293_1.callingController_:SetSelectedState("normal")

				arg_293_1.keyicon_.color = Color.New(1, 1, 1)
				arg_293_1.icon_.color = Color.New(1, 1, 1)

				local var_296_3 = arg_293_1:FormatText(arg_293_1:GetWordFromCfg(302031074).content)

				arg_293_1.text_.text = var_296_3

				LuaForUtil.ClearLinePrefixSymbol(arg_293_1.text_)

				local var_296_5 = 14 <= 0 and var_296_2 or var_296_2 * (utf8.len(var_296_3) / 14)

				if (14 <= 0 and var_296_2 or var_296_2 * (utf8.len(var_296_3) / 14)) > 0 and var_296_2 < var_296_5 then
					arg_293_1.talkMaxDuration = var_296_5

					if var_296_5 + var_296_1 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_5 + var_296_1
					end
				end

				arg_293_1.text_.text = var_296_3
				arg_293_1.typewritter.percent = 0

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(false)
				arg_293_1:RecordContent(arg_293_1.text_.text)
			end

			local var_296_6 = math.max(var_296_2, arg_293_1.talkMaxDuration)

			if var_296_1 <= arg_293_1.time_ and arg_293_1.time_ < var_296_1 + var_296_6 then
				arg_293_1.typewritter.percent = (arg_293_1.time_ - var_296_1) / var_296_6

				arg_293_1.typewritter:SetDirty()
			end

			if arg_293_1.time_ >= var_296_1 + var_296_6 and arg_293_1.time_ < var_296_1 + var_296_6 + arg_296_0 then
				arg_293_1.typewritter.percent = 1

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(true)
			end
		end

		arg_293_1.nodeConfigList_ = {}

		arg_293_1:InitPlayNodeList()
	end,
	Play302031075 = function(arg_297_0, arg_297_1)
		arg_297_1.time_ = 0
		arg_297_1.frameCnt_ = 0
		arg_297_1.state_ = "playing"
		arg_297_1.curTalkId_ = 302031075
		arg_297_1.duration_ = 8.53

		local var_297_0 = {
			zh = 4.3,
			ja = 8.533
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
				arg_297_0:Play302031076(arg_297_1)
			end
		end

		function arg_297_1.onSingleLineUpdate_(arg_300_0)
			if 0 < arg_297_1.time_ and arg_297_1.time_ <= 0 + arg_300_0 then
				arg_297_1.var_.moveOldPos1084ui_story = arg_297_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_300_0 = 0.001

			if 0 <= arg_297_1.time_ and arg_297_1.time_ < 0 + var_300_0 then
				arg_297_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_297_1.var_.moveOldPos1084ui_story, Vector3.New(0.7, -0.97, -6), (arg_297_1.time_ - 0) / var_300_0)
				arg_297_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_297_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_297_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_297_1.actors_["1084ui_story"].transform.position).z)
				arg_297_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_297_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_297_1.actors_["1084ui_story"].transform.localEulerAngles = arg_297_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_297_1.time_ >= 0 + var_300_0 and arg_297_1.time_ < 0 + var_300_0 + arg_300_0 then
				arg_297_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0.7, -0.97, -6)
				arg_297_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_297_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_297_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_297_1.actors_["1084ui_story"].transform.position).z)
				arg_297_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_297_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_297_1.actors_["1084ui_story"].transform.localEulerAngles = arg_297_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_300_1 = arg_297_1.actors_["1166ui_story"].transform

			if 0 < arg_297_1.time_ and arg_297_1.time_ <= 0 + arg_300_0 then
				arg_297_1.var_.moveOldPos1166ui_story = var_300_1.localPosition

				local var_300_2 = GameObjectTools.GetOrAddComponent(var_300_1.gameObject, typeof(DynamicBoneHelper))

				if var_300_2 then
					var_300_2:EnableDynamicBone(false)
				end
			end

			local var_300_3 = 0.001

			if 0 <= arg_297_1.time_ and arg_297_1.time_ < 0 + var_300_3 then
				var_300_1.localPosition = Vector3.Lerp(arg_297_1.var_.moveOldPos1166ui_story, Vector3.New(-0.7, -0.75, -6.25), (arg_297_1.time_ - 0) / var_300_3)
				var_300_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_300_1.position).x, (manager.ui.mainCamera.transform.position - var_300_1.position).y, (manager.ui.mainCamera.transform.position - var_300_1.position).z)
				var_300_1.localEulerAngles.z = 0
				var_300_1.localEulerAngles.x = 0
				var_300_1.localEulerAngles = var_300_1.localEulerAngles
			end

			if arg_297_1.time_ >= 0 + var_300_3 and arg_297_1.time_ < 0 + var_300_3 + arg_300_0 then
				var_300_1.localPosition = Vector3.New(-0.7, -0.75, -6.25)
				var_300_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_300_1.position).x, (manager.ui.mainCamera.transform.position - var_300_1.position).y, (manager.ui.mainCamera.transform.position - var_300_1.position).z)
				var_300_1.localEulerAngles.z = 0
				var_300_1.localEulerAngles.x = 0
				var_300_1.localEulerAngles = var_300_1.localEulerAngles

				local var_300_4 = GameObjectTools.GetOrAddComponent(var_300_1.gameObject, typeof(DynamicBoneHelper))

				if var_300_4 then
					var_300_4:EnableDynamicBone(true)
				end
			end

			local var_300_5 = arg_297_1.actors_["1084ui_story"]

			if 0 < arg_297_1.time_ and arg_297_1.time_ <= 0 + arg_300_0 and not isNil(var_300_5) and arg_297_1.var_.characterEffect1084ui_story == nil then
				arg_297_1.var_.characterEffect1084ui_story = var_300_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_300_6 = 0.200000002980232

			if 0 <= arg_297_1.time_ and arg_297_1.time_ < 0 + var_300_6 and not isNil(var_300_5) then
				if arg_297_1.var_.characterEffect1084ui_story and not isNil(var_300_5) then
					arg_297_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_297_1.time_ >= 0 + var_300_6 and arg_297_1.time_ < 0 + var_300_6 + arg_300_0 and not isNil(var_300_5) and arg_297_1.var_.characterEffect1084ui_story then
				arg_297_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_297_1.time_ and arg_297_1.time_ <= 0 + arg_300_0 then
				arg_297_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action12_1")
			end

			if 0 < arg_297_1.time_ and arg_297_1.time_ <= 0 + arg_300_0 then
				arg_297_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_300_8 = 0
			local var_300_9 = 0.55

			if 0 < arg_297_1.time_ and arg_297_1.time_ <= var_300_8 + arg_300_0 then
				arg_297_1.talkMaxDuration = 0
				arg_297_1.dialogCg_.alpha = 1

				arg_297_1.dialog_:SetActive(true)
				SetActive(arg_297_1.leftNameGo_, true)

				arg_297_1.leftNameTxt_.text = arg_297_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_297_1.leftNameTxt_.transform)

				arg_297_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_297_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_297_1:RecordName(arg_297_1.leftNameTxt_.text)
				SetActive(arg_297_1.iconTrs_.gameObject, false)
				arg_297_1.callingController_:SetSelectedState("normal")

				local var_300_10 = arg_297_1:GetWordFromCfg(302031075)
				local var_300_11 = arg_297_1:FormatText(var_300_10.content)

				arg_297_1.text_.text = var_300_11

				LuaForUtil.ClearLinePrefixSymbol(arg_297_1.text_)

				local var_300_13 = 22 <= 0 and var_300_9 or var_300_9 * (utf8.len(var_300_11) / 22)

				if (22 <= 0 and var_300_9 or var_300_9 * (utf8.len(var_300_11) / 22)) > 0 and var_300_9 < var_300_13 then
					arg_297_1.talkMaxDuration = var_300_13

					if var_300_13 + var_300_8 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_13 + var_300_8
					end
				end

				arg_297_1.text_.text = var_300_11
				arg_297_1.typewritter.percent = 0

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302031", "302031075", "story_v_out_302031.awb") ~= 0 then
					local var_300_14 = manager.audio:GetVoiceLength("story_v_out_302031", "302031075", "story_v_out_302031.awb") / 1000

					if var_300_14 + var_300_8 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_14 + var_300_8
					end

					if var_300_10.prefab_name ~= "" and arg_297_1.actors_[var_300_10.prefab_name] ~= nil then
						local var_300_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_297_1.actors_[var_300_10.prefab_name].transform, "story_v_out_302031", "302031075", "story_v_out_302031.awb")

						arg_297_1:RecordAudio("302031075", var_300_15)
						arg_297_1:RecordAudio("302031075", var_300_15)
					else
						arg_297_1:AudioAction("play", "voice", "story_v_out_302031", "302031075", "story_v_out_302031.awb")
					end

					arg_297_1:RecordHistoryTalkVoice("story_v_out_302031", "302031075", "story_v_out_302031.awb")
				end

				arg_297_1:RecordContent(arg_297_1.text_.text)
			end

			local var_300_16 = math.max(var_300_9, arg_297_1.talkMaxDuration)

			if var_300_8 <= arg_297_1.time_ and arg_297_1.time_ < var_300_8 + var_300_16 then
				arg_297_1.typewritter.percent = (arg_297_1.time_ - var_300_8) / var_300_16

				arg_297_1.typewritter:SetDirty()
			end

			if arg_297_1.time_ >= var_300_8 + var_300_16 and arg_297_1.time_ < var_300_8 + var_300_16 + arg_300_0 then
				arg_297_1.typewritter.percent = 1

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(true)
			end
		end

		arg_297_1.nodeConfigList_ = {
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
				actorName = "1166ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_297_1:InitPlayNodeList()
	end,
	Play302031076 = function(arg_301_0, arg_301_1)
		arg_301_1.time_ = 0
		arg_301_1.frameCnt_ = 0
		arg_301_1.state_ = "playing"
		arg_301_1.curTalkId_ = 302031076
		arg_301_1.duration_ = 5

		SetActive(arg_301_1.tipsGo_, false)

		function arg_301_1.onSingleLineFinish_()
			arg_301_1.onSingleLineUpdate_ = nil
			arg_301_1.onSingleLineFinish_ = nil
			arg_301_1.state_ = "waiting"
		end

		function arg_301_1.playNext_(arg_303_0)
			if arg_303_0 == 1 then
				arg_301_0:Play302031077(arg_301_1)
			end
		end

		function arg_301_1.onSingleLineUpdate_(arg_304_0)
			if 0 < arg_301_1.time_ and arg_301_1.time_ <= 0 + arg_304_0 and not isNil(arg_301_1.actors_["1084ui_story"]) and arg_301_1.var_.characterEffect1084ui_story == nil then
				arg_301_1.var_.characterEffect1084ui_story = arg_301_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_304_0 = 0.200000002980232

			if 0 <= arg_301_1.time_ and arg_301_1.time_ < 0 + var_304_0 and not isNil(arg_301_1.actors_["1084ui_story"]) then
				if arg_301_1.var_.characterEffect1084ui_story and not isNil(arg_301_1.actors_["1084ui_story"]) then
					arg_301_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_301_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_301_1.time_ - 0) / var_304_0)
				end
			end

			if arg_301_1.time_ >= 0 + var_304_0 and arg_301_1.time_ < 0 + var_304_0 + arg_304_0 and not isNil(arg_301_1.actors_["1084ui_story"]) and arg_301_1.var_.characterEffect1084ui_story then
				arg_301_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_301_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_304_1 = 0
			local var_304_2 = 1

			if 0 < arg_301_1.time_ and arg_301_1.time_ <= var_304_1 + arg_304_0 then
				arg_301_1.talkMaxDuration = 0
				arg_301_1.dialogCg_.alpha = 1

				arg_301_1.dialog_:SetActive(true)
				SetActive(arg_301_1.leftNameGo_, true)

				arg_301_1.leftNameTxt_.text = arg_301_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_301_1.leftNameTxt_.transform)

				arg_301_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_301_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_301_1:RecordName(arg_301_1.leftNameTxt_.text)
				SetActive(arg_301_1.iconTrs_.gameObject, true)
				arg_301_1.iconController_:SetSelectedState("hero")

				arg_301_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_301_1.callingController_:SetSelectedState("normal")

				arg_301_1.keyicon_.color = Color.New(1, 1, 1)
				arg_301_1.icon_.color = Color.New(1, 1, 1)

				local var_304_3 = arg_301_1:FormatText(arg_301_1:GetWordFromCfg(302031076).content)

				arg_301_1.text_.text = var_304_3

				LuaForUtil.ClearLinePrefixSymbol(arg_301_1.text_)

				local var_304_5 = 40 <= 0 and var_304_2 or var_304_2 * (utf8.len(var_304_3) / 40)

				if (40 <= 0 and var_304_2 or var_304_2 * (utf8.len(var_304_3) / 40)) > 0 and var_304_2 < var_304_5 then
					arg_301_1.talkMaxDuration = var_304_5

					if var_304_5 + var_304_1 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_5 + var_304_1
					end
				end

				arg_301_1.text_.text = var_304_3
				arg_301_1.typewritter.percent = 0

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(false)
				arg_301_1:RecordContent(arg_301_1.text_.text)
			end

			local var_304_6 = math.max(var_304_2, arg_301_1.talkMaxDuration)

			if var_304_1 <= arg_301_1.time_ and arg_301_1.time_ < var_304_1 + var_304_6 then
				arg_301_1.typewritter.percent = (arg_301_1.time_ - var_304_1) / var_304_6

				arg_301_1.typewritter:SetDirty()
			end

			if arg_301_1.time_ >= var_304_1 + var_304_6 and arg_301_1.time_ < var_304_1 + var_304_6 + arg_304_0 then
				arg_301_1.typewritter.percent = 1

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(true)
			end
		end

		arg_301_1.nodeConfigList_ = {}

		arg_301_1:InitPlayNodeList()
	end,
	Play302031077 = function(arg_305_0, arg_305_1)
		arg_305_1.time_ = 0
		arg_305_1.frameCnt_ = 0
		arg_305_1.state_ = "playing"
		arg_305_1.curTalkId_ = 302031077
		arg_305_1.duration_ = 5

		SetActive(arg_305_1.tipsGo_, false)

		function arg_305_1.onSingleLineFinish_()
			arg_305_1.onSingleLineUpdate_ = nil
			arg_305_1.onSingleLineFinish_ = nil
			arg_305_1.state_ = "waiting"
		end

		function arg_305_1.playNext_(arg_307_0)
			if arg_307_0 == 1 then
				arg_305_0:Play302031078(arg_305_1)
			end
		end

		function arg_305_1.onSingleLineUpdate_(arg_308_0)
			local var_308_0 = 0.55

			if 0 < arg_305_1.time_ and arg_305_1.time_ <= 0 + arg_308_0 then
				arg_305_1.talkMaxDuration = 0
				arg_305_1.dialogCg_.alpha = 1

				arg_305_1.dialog_:SetActive(true)
				SetActive(arg_305_1.leftNameGo_, true)

				arg_305_1.leftNameTxt_.text = arg_305_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_305_1.leftNameTxt_.transform)

				arg_305_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_305_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_305_1:RecordName(arg_305_1.leftNameTxt_.text)
				SetActive(arg_305_1.iconTrs_.gameObject, true)
				arg_305_1.iconController_:SetSelectedState("hero")

				arg_305_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_305_1.callingController_:SetSelectedState("normal")

				arg_305_1.keyicon_.color = Color.New(1, 1, 1)
				arg_305_1.icon_.color = Color.New(1, 1, 1)

				local var_308_1 = arg_305_1:FormatText(arg_305_1:GetWordFromCfg(302031077).content)

				arg_305_1.text_.text = var_308_1

				LuaForUtil.ClearLinePrefixSymbol(arg_305_1.text_)

				local var_308_3 = 22 <= 0 and var_308_0 or var_308_0 * (utf8.len(var_308_1) / 22)

				if (22 <= 0 and var_308_0 or var_308_0 * (utf8.len(var_308_1) / 22)) > 0 and var_308_0 < var_308_3 then
					arg_305_1.talkMaxDuration = var_308_3

					if var_308_3 + 0 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_3 + 0
					end
				end

				arg_305_1.text_.text = var_308_1
				arg_305_1.typewritter.percent = 0

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(false)
				arg_305_1:RecordContent(arg_305_1.text_.text)
			end

			local var_308_4 = math.max(var_308_0, arg_305_1.talkMaxDuration)

			if 0 <= arg_305_1.time_ and arg_305_1.time_ < 0 + var_308_4 then
				arg_305_1.typewritter.percent = (arg_305_1.time_ - 0) / var_308_4

				arg_305_1.typewritter:SetDirty()
			end

			if arg_305_1.time_ >= 0 + var_308_4 and arg_305_1.time_ < 0 + var_308_4 + arg_308_0 then
				arg_305_1.typewritter.percent = 1

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(true)
			end
		end

		arg_305_1.nodeConfigList_ = {}

		arg_305_1:InitPlayNodeList()
	end,
	Play302031078 = function(arg_309_0, arg_309_1)
		arg_309_1.time_ = 0
		arg_309_1.frameCnt_ = 0
		arg_309_1.state_ = "playing"
		arg_309_1.curTalkId_ = 302031078
		arg_309_1.duration_ = 2.9

		local var_309_0 = {
			zh = 2.9,
			ja = 1.999999999999
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
				arg_309_0:Play302031079(arg_309_1)
			end
		end

		function arg_309_1.onSingleLineUpdate_(arg_312_0)
			if 0 < arg_309_1.time_ and arg_309_1.time_ <= 0 + arg_312_0 and not isNil(arg_309_1.actors_["1166ui_story"]) and arg_309_1.var_.characterEffect1166ui_story == nil then
				arg_309_1.var_.characterEffect1166ui_story = arg_309_1.actors_["1166ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_312_0 = 0.200000002980232

			if 0 <= arg_309_1.time_ and arg_309_1.time_ < 0 + var_312_0 and not isNil(arg_309_1.actors_["1166ui_story"]) then
				if arg_309_1.var_.characterEffect1166ui_story and not isNil(arg_309_1.actors_["1166ui_story"]) then
					arg_309_1.var_.characterEffect1166ui_story.fillFlat = false
				end
			end

			if arg_309_1.time_ >= 0 + var_312_0 and arg_309_1.time_ < 0 + var_312_0 + arg_312_0 and not isNil(arg_309_1.actors_["1166ui_story"]) and arg_309_1.var_.characterEffect1166ui_story then
				arg_309_1.var_.characterEffect1166ui_story.fillFlat = false
			end

			if 0 < arg_309_1.time_ and arg_309_1.time_ <= 0 + arg_312_0 then
				arg_309_1:PlayTimeline("1166ui_story", "StoryTimeline/CharAction/story1166/story1166action/1166action3_1")
			end

			if 0 < arg_309_1.time_ and arg_309_1.time_ <= 0 + arg_312_0 then
				arg_309_1:PlayTimeline("1166ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_312_2 = 0
			local var_312_3 = 0.325

			if 0 < arg_309_1.time_ and arg_309_1.time_ <= var_312_2 + arg_312_0 then
				arg_309_1.talkMaxDuration = 0
				arg_309_1.dialogCg_.alpha = 1

				arg_309_1.dialog_:SetActive(true)
				SetActive(arg_309_1.leftNameGo_, true)

				arg_309_1.leftNameTxt_.text = arg_309_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_309_1.leftNameTxt_.transform)

				arg_309_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_309_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_309_1:RecordName(arg_309_1.leftNameTxt_.text)
				SetActive(arg_309_1.iconTrs_.gameObject, false)
				arg_309_1.callingController_:SetSelectedState("normal")

				local var_312_4 = arg_309_1:GetWordFromCfg(302031078)
				local var_312_5 = arg_309_1:FormatText(var_312_4.content)

				arg_309_1.text_.text = var_312_5

				LuaForUtil.ClearLinePrefixSymbol(arg_309_1.text_)

				local var_312_7 = 13 <= 0 and var_312_3 or var_312_3 * (utf8.len(var_312_5) / 13)

				if (13 <= 0 and var_312_3 or var_312_3 * (utf8.len(var_312_5) / 13)) > 0 and var_312_3 < var_312_7 then
					arg_309_1.talkMaxDuration = var_312_7

					if var_312_7 + var_312_2 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_7 + var_312_2
					end
				end

				arg_309_1.text_.text = var_312_5
				arg_309_1.typewritter.percent = 0

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302031", "302031078", "story_v_out_302031.awb") ~= 0 then
					local var_312_8 = manager.audio:GetVoiceLength("story_v_out_302031", "302031078", "story_v_out_302031.awb") / 1000

					if var_312_8 + var_312_2 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_8 + var_312_2
					end

					if var_312_4.prefab_name ~= "" and arg_309_1.actors_[var_312_4.prefab_name] ~= nil then
						local var_312_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_309_1.actors_[var_312_4.prefab_name].transform, "story_v_out_302031", "302031078", "story_v_out_302031.awb")

						arg_309_1:RecordAudio("302031078", var_312_9)
						arg_309_1:RecordAudio("302031078", var_312_9)
					else
						arg_309_1:AudioAction("play", "voice", "story_v_out_302031", "302031078", "story_v_out_302031.awb")
					end

					arg_309_1:RecordHistoryTalkVoice("story_v_out_302031", "302031078", "story_v_out_302031.awb")
				end

				arg_309_1:RecordContent(arg_309_1.text_.text)
			end

			local var_312_10 = math.max(var_312_3, arg_309_1.talkMaxDuration)

			if var_312_2 <= arg_309_1.time_ and arg_309_1.time_ < var_312_2 + var_312_10 then
				arg_309_1.typewritter.percent = (arg_309_1.time_ - var_312_2) / var_312_10

				arg_309_1.typewritter:SetDirty()
			end

			if arg_309_1.time_ >= var_312_2 + var_312_10 and arg_309_1.time_ < var_312_2 + var_312_10 + arg_312_0 then
				arg_309_1.typewritter.percent = 1

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(true)
			end
		end

		arg_309_1.nodeConfigList_ = {}

		arg_309_1:InitPlayNodeList()
	end,
	Play302031079 = function(arg_313_0, arg_313_1)
		arg_313_1.time_ = 0
		arg_313_1.frameCnt_ = 0
		arg_313_1.state_ = "playing"
		arg_313_1.curTalkId_ = 302031079
		arg_313_1.duration_ = 5.83

		local var_313_0 = {
			zh = 4.866,
			ja = 5.833
		}
		local var_313_1 = manager.audio:GetLocalizationFlag()

		if var_313_0[var_313_1] ~= nil then
			arg_313_1.duration_ = var_313_0[var_313_1]
		end

		SetActive(arg_313_1.tipsGo_, false)

		function arg_313_1.onSingleLineFinish_()
			arg_313_1.onSingleLineUpdate_ = nil
			arg_313_1.onSingleLineFinish_ = nil
			arg_313_1.state_ = "waiting"
		end

		function arg_313_1.playNext_(arg_315_0)
			if arg_315_0 == 1 then
				arg_313_0:Play302031080(arg_313_1)
			end
		end

		function arg_313_1.onSingleLineUpdate_(arg_316_0)
			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 and not isNil(arg_313_1.actors_["1084ui_story"]) and arg_313_1.var_.characterEffect1084ui_story == nil then
				arg_313_1.var_.characterEffect1084ui_story = arg_313_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_316_0 = 0.200000002980232

			if 0 <= arg_313_1.time_ and arg_313_1.time_ < 0 + var_316_0 and not isNil(arg_313_1.actors_["1084ui_story"]) then
				if arg_313_1.var_.characterEffect1084ui_story and not isNil(arg_313_1.actors_["1084ui_story"]) then
					arg_313_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_313_1.time_ >= 0 + var_316_0 and arg_313_1.time_ < 0 + var_316_0 + arg_316_0 and not isNil(arg_313_1.actors_["1084ui_story"]) and arg_313_1.var_.characterEffect1084ui_story then
				arg_313_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_316_2 = arg_313_1.actors_["1166ui_story"]

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 and not isNil(var_316_2) and arg_313_1.var_.characterEffect1166ui_story == nil then
				arg_313_1.var_.characterEffect1166ui_story = var_316_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_316_3 = 0.200000002980232

			if 0 <= arg_313_1.time_ and arg_313_1.time_ < 0 + var_316_3 and not isNil(var_316_2) then
				if arg_313_1.var_.characterEffect1166ui_story and not isNil(var_316_2) then
					arg_313_1.var_.characterEffect1166ui_story.fillFlat = true
					arg_313_1.var_.characterEffect1166ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_313_1.time_ - 0) / var_316_3)
				end
			end

			if arg_313_1.time_ >= 0 + var_316_3 and arg_313_1.time_ < 0 + var_316_3 + arg_316_0 and not isNil(var_316_2) and arg_313_1.var_.characterEffect1166ui_story then
				arg_313_1.var_.characterEffect1166ui_story.fillFlat = true
				arg_313_1.var_.characterEffect1166ui_story.fillRatio = 0.5
			end

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 then
				arg_313_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action12_2")
			end

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 then
				arg_313_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_316_4 = 0
			local var_316_5 = 0.525

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= var_316_4 + arg_316_0 then
				arg_313_1.talkMaxDuration = 0
				arg_313_1.dialogCg_.alpha = 1

				arg_313_1.dialog_:SetActive(true)
				SetActive(arg_313_1.leftNameGo_, true)

				arg_313_1.leftNameTxt_.text = arg_313_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_313_1.leftNameTxt_.transform)

				arg_313_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_313_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_313_1:RecordName(arg_313_1.leftNameTxt_.text)
				SetActive(arg_313_1.iconTrs_.gameObject, false)
				arg_313_1.callingController_:SetSelectedState("normal")

				local var_316_6 = arg_313_1:GetWordFromCfg(302031079)
				local var_316_7 = arg_313_1:FormatText(var_316_6.content)

				arg_313_1.text_.text = var_316_7

				LuaForUtil.ClearLinePrefixSymbol(arg_313_1.text_)

				local var_316_9 = 21 <= 0 and var_316_5 or var_316_5 * (utf8.len(var_316_7) / 21)

				if (21 <= 0 and var_316_5 or var_316_5 * (utf8.len(var_316_7) / 21)) > 0 and var_316_5 < var_316_9 then
					arg_313_1.talkMaxDuration = var_316_9

					if var_316_9 + var_316_4 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_9 + var_316_4
					end
				end

				arg_313_1.text_.text = var_316_7
				arg_313_1.typewritter.percent = 0

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302031", "302031079", "story_v_out_302031.awb") ~= 0 then
					local var_316_10 = manager.audio:GetVoiceLength("story_v_out_302031", "302031079", "story_v_out_302031.awb") / 1000

					if var_316_10 + var_316_4 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_10 + var_316_4
					end

					if var_316_6.prefab_name ~= "" and arg_313_1.actors_[var_316_6.prefab_name] ~= nil then
						local var_316_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_313_1.actors_[var_316_6.prefab_name].transform, "story_v_out_302031", "302031079", "story_v_out_302031.awb")

						arg_313_1:RecordAudio("302031079", var_316_11)
						arg_313_1:RecordAudio("302031079", var_316_11)
					else
						arg_313_1:AudioAction("play", "voice", "story_v_out_302031", "302031079", "story_v_out_302031.awb")
					end

					arg_313_1:RecordHistoryTalkVoice("story_v_out_302031", "302031079", "story_v_out_302031.awb")
				end

				arg_313_1:RecordContent(arg_313_1.text_.text)
			end

			local var_316_12 = math.max(var_316_5, arg_313_1.talkMaxDuration)

			if var_316_4 <= arg_313_1.time_ and arg_313_1.time_ < var_316_4 + var_316_12 then
				arg_313_1.typewritter.percent = (arg_313_1.time_ - var_316_4) / var_316_12

				arg_313_1.typewritter:SetDirty()
			end

			if arg_313_1.time_ >= var_316_4 + var_316_12 and arg_313_1.time_ < var_316_4 + var_316_12 + arg_316_0 then
				arg_313_1.typewritter.percent = 1

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(true)
			end
		end

		arg_313_1.nodeConfigList_ = {}

		arg_313_1:InitPlayNodeList()
	end,
	Play302031080 = function(arg_317_0, arg_317_1)
		arg_317_1.time_ = 0
		arg_317_1.frameCnt_ = 0
		arg_317_1.state_ = "playing"
		arg_317_1.curTalkId_ = 302031080
		arg_317_1.duration_ = 5

		SetActive(arg_317_1.tipsGo_, false)

		function arg_317_1.onSingleLineFinish_()
			arg_317_1.onSingleLineUpdate_ = nil
			arg_317_1.onSingleLineFinish_ = nil
			arg_317_1.state_ = "waiting"
			arg_317_1.auto_ = false
		end

		function arg_317_1.playNext_(arg_319_0)
			arg_317_1.onStoryFinished_()
		end

		function arg_317_1.onSingleLineUpdate_(arg_320_0)
			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 and not isNil(arg_317_1.actors_["1084ui_story"]) and arg_317_1.var_.characterEffect1084ui_story == nil then
				arg_317_1.var_.characterEffect1084ui_story = arg_317_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_320_0 = 0.200000002980232

			if 0 <= arg_317_1.time_ and arg_317_1.time_ < 0 + var_320_0 and not isNil(arg_317_1.actors_["1084ui_story"]) then
				if arg_317_1.var_.characterEffect1084ui_story and not isNil(arg_317_1.actors_["1084ui_story"]) then
					arg_317_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_317_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_317_1.time_ - 0) / var_320_0)
				end
			end

			if arg_317_1.time_ >= 0 + var_320_0 and arg_317_1.time_ < 0 + var_320_0 + arg_320_0 and not isNil(arg_317_1.actors_["1084ui_story"]) and arg_317_1.var_.characterEffect1084ui_story then
				arg_317_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_317_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_320_1 = 0
			local var_320_2 = 0.275

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= var_320_1 + arg_320_0 then
				arg_317_1.talkMaxDuration = 0
				arg_317_1.dialogCg_.alpha = 1

				arg_317_1.dialog_:SetActive(true)
				SetActive(arg_317_1.leftNameGo_, true)

				arg_317_1.leftNameTxt_.text = arg_317_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_317_1.leftNameTxt_.transform)

				arg_317_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_317_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_317_1:RecordName(arg_317_1.leftNameTxt_.text)
				SetActive(arg_317_1.iconTrs_.gameObject, true)
				arg_317_1.iconController_:SetSelectedState("hero")

				arg_317_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_317_1.callingController_:SetSelectedState("normal")

				arg_317_1.keyicon_.color = Color.New(1, 1, 1)
				arg_317_1.icon_.color = Color.New(1, 1, 1)

				local var_320_3 = arg_317_1:FormatText(arg_317_1:GetWordFromCfg(302031080).content)

				arg_317_1.text_.text = var_320_3

				LuaForUtil.ClearLinePrefixSymbol(arg_317_1.text_)

				local var_320_5 = 11 <= 0 and var_320_2 or var_320_2 * (utf8.len(var_320_3) / 11)

				if (11 <= 0 and var_320_2 or var_320_2 * (utf8.len(var_320_3) / 11)) > 0 and var_320_2 < var_320_5 then
					arg_317_1.talkMaxDuration = var_320_5

					if var_320_5 + var_320_1 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_5 + var_320_1
					end
				end

				arg_317_1.text_.text = var_320_3
				arg_317_1.typewritter.percent = 0

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(false)
				arg_317_1:RecordContent(arg_317_1.text_.text)
			end

			local var_320_6 = math.max(var_320_2, arg_317_1.talkMaxDuration)

			if var_320_1 <= arg_317_1.time_ and arg_317_1.time_ < var_320_1 + var_320_6 then
				arg_317_1.typewritter.percent = (arg_317_1.time_ - var_320_1) / var_320_6

				arg_317_1.typewritter:SetDirty()
			end

			if arg_317_1.time_ >= var_320_1 + var_320_6 and arg_317_1.time_ < var_320_1 + var_320_6 + arg_320_0 then
				arg_317_1.typewritter.percent = 1

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(true)
			end
		end

		arg_317_1.nodeConfigList_ = {}

		arg_317_1:InitPlayNodeList()
	end,
	Play302031034 = function(arg_321_0, arg_321_1)
		arg_321_1.time_ = 0
		arg_321_1.frameCnt_ = 0
		arg_321_1.state_ = "playing"
		arg_321_1.curTalkId_ = 302031034
		arg_321_1.duration_ = 6.1

		local var_321_0 = {
			zh = 4.9,
			ja = 6.1
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
		end

		function arg_321_1.playNext_(arg_323_0)
			if arg_323_0 == 1 then
				arg_321_0:Play302031035(arg_321_1)
			end
		end

		function arg_321_1.onSingleLineUpdate_(arg_324_0)
			if arg_321_1.actors_["1027ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1027ui_story"))) then
				local var_324_0 = Object.Instantiate(Asset.Load("Char/" .. "1027ui_story"), arg_321_1.stage_.transform)

				var_324_0.name = "1027ui_story"
				var_324_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_321_1.actors_["1027ui_story"] = var_324_0

				local var_324_1 = var_324_0:GetComponentInChildren(typeof(CharacterEffect))

				var_324_1.enabled = true

				local var_324_2 = GameObjectTools.GetOrAddComponent(var_324_0, typeof(DynamicBoneHelper))

				if var_324_2 then
					var_324_2:EnableDynamicBone(false)
				end

				arg_321_1:ShowWeapon(var_324_1.transform, false)

				arg_321_1.var_["1027ui_story" .. "Animator"] = var_324_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_321_1.var_["1027ui_story" .. "Animator"].applyRootMotion = true
				arg_321_1.var_["1027ui_story" .. "LipSync"] = var_324_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_321_1.time_ and arg_321_1.time_ <= 0 + arg_324_0 then
				arg_321_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action1_1")
			end

			local var_324_3 = "1027ui_story"

			if arg_321_1.actors_["1027ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1027ui_story"))) then
				local var_324_4 = Object.Instantiate(Asset.Load("Char/" .. "1027ui_story"), arg_321_1.stage_.transform)

				var_324_4.name = var_324_3
				var_324_4.transform.localPosition = Vector3.New(0, 100, 0)
				arg_321_1.actors_[var_324_3] = var_324_4

				local var_324_5 = var_324_4:GetComponentInChildren(typeof(CharacterEffect))

				var_324_5.enabled = true

				local var_324_6 = GameObjectTools.GetOrAddComponent(var_324_4, typeof(DynamicBoneHelper))

				if var_324_6 then
					var_324_6:EnableDynamicBone(false)
				end

				arg_321_1:ShowWeapon(var_324_5.transform, false)

				arg_321_1.var_[var_324_3 .. "Animator"] = var_324_5.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_321_1.var_[var_324_3 .. "Animator"].applyRootMotion = true
				arg_321_1.var_[var_324_3 .. "LipSync"] = var_324_5.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_321_1.time_ and arg_321_1.time_ <= 0 + arg_324_0 then
				arg_321_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_324_7 = 0
			local var_324_8 = 0.5

			if 0 < arg_321_1.time_ and arg_321_1.time_ <= var_324_7 + arg_324_0 then
				arg_321_1.talkMaxDuration = 0
				arg_321_1.dialogCg_.alpha = 1

				arg_321_1.dialog_:SetActive(true)
				SetActive(arg_321_1.leftNameGo_, true)

				arg_321_1.leftNameTxt_.text = arg_321_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_321_1.leftNameTxt_.transform)

				arg_321_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_321_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_321_1:RecordName(arg_321_1.leftNameTxt_.text)
				SetActive(arg_321_1.iconTrs_.gameObject, false)
				arg_321_1.callingController_:SetSelectedState("normal")

				local var_324_9 = arg_321_1:GetWordFromCfg(302031034)
				local var_324_10 = arg_321_1:FormatText(var_324_9.content)

				arg_321_1.text_.text = var_324_10

				LuaForUtil.ClearLinePrefixSymbol(arg_321_1.text_)

				local var_324_12 = 20 <= 0 and var_324_8 or var_324_8 * (utf8.len(var_324_10) / 20)

				if (20 <= 0 and var_324_8 or var_324_8 * (utf8.len(var_324_10) / 20)) > 0 and var_324_8 < var_324_12 then
					arg_321_1.talkMaxDuration = var_324_12

					if var_324_12 + var_324_7 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_12 + var_324_7
					end
				end

				arg_321_1.text_.text = var_324_10
				arg_321_1.typewritter.percent = 0

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302031", "302031034", "story_v_out_302031.awb") ~= 0 then
					local var_324_13 = manager.audio:GetVoiceLength("story_v_out_302031", "302031034", "story_v_out_302031.awb") / 1000

					if var_324_13 + var_324_7 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_13 + var_324_7
					end

					if var_324_9.prefab_name ~= "" and arg_321_1.actors_[var_324_9.prefab_name] ~= nil then
						local var_324_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_321_1.actors_[var_324_9.prefab_name].transform, "story_v_out_302031", "302031034", "story_v_out_302031.awb")

						arg_321_1:RecordAudio("302031034", var_324_14)
						arg_321_1:RecordAudio("302031034", var_324_14)
					else
						arg_321_1:AudioAction("play", "voice", "story_v_out_302031", "302031034", "story_v_out_302031.awb")
					end

					arg_321_1:RecordHistoryTalkVoice("story_v_out_302031", "302031034", "story_v_out_302031.awb")
				end

				arg_321_1:RecordContent(arg_321_1.text_.text)
			end

			local var_324_15 = math.max(var_324_8, arg_321_1.talkMaxDuration)

			if var_324_7 <= arg_321_1.time_ and arg_321_1.time_ < var_324_7 + var_324_15 then
				arg_321_1.typewritter.percent = (arg_321_1.time_ - var_324_7) / var_324_15

				arg_321_1.typewritter:SetDirty()
			end

			if arg_321_1.time_ >= var_324_7 + var_324_15 and arg_321_1.time_ < var_324_7 + var_324_15 + arg_324_0 then
				arg_321_1.typewritter.percent = 1

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(true)
			end
		end

		arg_321_1.nodeConfigList_ = {}

		arg_321_1:InitPlayNodeList()
	end,
	Play302031035 = function(arg_325_0, arg_325_1)
		arg_325_1.time_ = 0
		arg_325_1.frameCnt_ = 0
		arg_325_1.state_ = "playing"
		arg_325_1.curTalkId_ = 302031035
		arg_325_1.duration_ = 3.77

		local var_325_0 = {
			zh = 3.566,
			ja = 3.766
		}
		local var_325_1 = manager.audio:GetLocalizationFlag()

		if var_325_0[var_325_1] ~= nil then
			arg_325_1.duration_ = var_325_0[var_325_1]
		end

		SetActive(arg_325_1.tipsGo_, false)

		function arg_325_1.onSingleLineFinish_()
			arg_325_1.onSingleLineUpdate_ = nil
			arg_325_1.onSingleLineFinish_ = nil
			arg_325_1.state_ = "waiting"
		end

		function arg_325_1.playNext_(arg_327_0)
			if arg_327_0 == 1 then
				arg_325_0:Play302031036(arg_325_1)
			end
		end

		function arg_325_1.onSingleLineUpdate_(arg_328_0)
			if 0 < arg_325_1.time_ and arg_325_1.time_ <= 0 + arg_328_0 then
				arg_325_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action1_1")
			end

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= 0 + arg_328_0 then
				arg_325_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_328_0 = 0
			local var_328_1 = 0.45

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= var_328_0 + arg_328_0 then
				arg_325_1.talkMaxDuration = 0
				arg_325_1.dialogCg_.alpha = 1

				arg_325_1.dialog_:SetActive(true)
				SetActive(arg_325_1.leftNameGo_, true)

				arg_325_1.leftNameTxt_.text = arg_325_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_325_1.leftNameTxt_.transform)

				arg_325_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_325_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_325_1:RecordName(arg_325_1.leftNameTxt_.text)
				SetActive(arg_325_1.iconTrs_.gameObject, false)
				arg_325_1.callingController_:SetSelectedState("normal")

				local var_328_2 = arg_325_1:GetWordFromCfg(302031035)
				local var_328_3 = arg_325_1:FormatText(var_328_2.content)

				arg_325_1.text_.text = var_328_3

				LuaForUtil.ClearLinePrefixSymbol(arg_325_1.text_)

				local var_328_5 = 18 <= 0 and var_328_1 or var_328_1 * (utf8.len(var_328_3) / 18)

				if (18 <= 0 and var_328_1 or var_328_1 * (utf8.len(var_328_3) / 18)) > 0 and var_328_1 < var_328_5 then
					arg_325_1.talkMaxDuration = var_328_5

					if var_328_5 + var_328_0 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_5 + var_328_0
					end
				end

				arg_325_1.text_.text = var_328_3
				arg_325_1.typewritter.percent = 0

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302031", "302031035", "story_v_out_302031.awb") ~= 0 then
					local var_328_6 = manager.audio:GetVoiceLength("story_v_out_302031", "302031035", "story_v_out_302031.awb") / 1000

					if var_328_6 + var_328_0 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_6 + var_328_0
					end

					if var_328_2.prefab_name ~= "" and arg_325_1.actors_[var_328_2.prefab_name] ~= nil then
						local var_328_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_325_1.actors_[var_328_2.prefab_name].transform, "story_v_out_302031", "302031035", "story_v_out_302031.awb")

						arg_325_1:RecordAudio("302031035", var_328_7)
						arg_325_1:RecordAudio("302031035", var_328_7)
					else
						arg_325_1:AudioAction("play", "voice", "story_v_out_302031", "302031035", "story_v_out_302031.awb")
					end

					arg_325_1:RecordHistoryTalkVoice("story_v_out_302031", "302031035", "story_v_out_302031.awb")
				end

				arg_325_1:RecordContent(arg_325_1.text_.text)
			end

			local var_328_8 = math.max(var_328_1, arg_325_1.talkMaxDuration)

			if var_328_0 <= arg_325_1.time_ and arg_325_1.time_ < var_328_0 + var_328_8 then
				arg_325_1.typewritter.percent = (arg_325_1.time_ - var_328_0) / var_328_8

				arg_325_1.typewritter:SetDirty()
			end

			if arg_325_1.time_ >= var_328_0 + var_328_8 and arg_325_1.time_ < var_328_0 + var_328_8 + arg_328_0 then
				arg_325_1.typewritter.percent = 1

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(true)
			end
		end

		arg_325_1.nodeConfigList_ = {}

		arg_325_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/A00",
		"TextureConfig/Background/I27f"
	},
	voices = {
		"story_v_out_302031.awb"
	}
}
