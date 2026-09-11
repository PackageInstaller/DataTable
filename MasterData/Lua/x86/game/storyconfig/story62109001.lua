return {
	Play62109001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 62109001
		arg_1_1.duration_ = 4.17

		local var_1_0 = {
			ja = 4.166,
			ko = 3.799999999999,
			zh = 3.799999999999,
			en = 3.799999999999
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
				arg_1_0:Play62109002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.actors_["1111ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1111ui_story"))) then
				local var_4_0 = Object.Instantiate(Asset.Load("Char/" .. "1111ui_story"), arg_1_1.stage_.transform)

				var_4_0.name = "1111ui_story"
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.actors_["1111ui_story"] = var_4_0

				local var_4_1 = var_4_0:GetComponentInChildren(typeof(CharacterEffect))

				var_4_1.enabled = true

				local var_4_2 = GameObjectTools.GetOrAddComponent(var_4_0, typeof(DynamicBoneHelper))

				if var_4_2 then
					var_4_2:EnableDynamicBone(false)
				end

				arg_1_1:ShowWeapon(var_4_1.transform, false)

				arg_1_1.var_["1111ui_story" .. "Animator"] = var_4_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_1_1.var_["1111ui_story" .. "Animator"].applyRootMotion = true
				arg_1_1.var_["1111ui_story" .. "LipSync"] = var_4_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_4_3 = arg_1_1.actors_["1111ui_story"].transform

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				arg_1_1.var_.moveOldPos1111ui_story = var_4_3.localPosition
			end

			local var_4_4 = 0.001

			if 1.8 <= arg_1_1.time_ and arg_1_1.time_ < 1.8 + var_4_4 then
				var_4_3.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1111ui_story, Vector3.New(0, -0.87, -5.7), (arg_1_1.time_ - 1.8) / var_4_4)
				var_4_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_3.position).x, (manager.ui.mainCamera.transform.position - var_4_3.position).y, (manager.ui.mainCamera.transform.position - var_4_3.position).z)
				var_4_3.localEulerAngles.z = 0
				var_4_3.localEulerAngles.x = 0
				var_4_3.localEulerAngles = var_4_3.localEulerAngles
			end

			if arg_1_1.time_ >= 1.8 + var_4_4 and arg_1_1.time_ < 1.8 + var_4_4 + arg_4_0 then
				var_4_3.localPosition = Vector3.New(0, -0.87, -5.7)
				var_4_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_3.position).x, (manager.ui.mainCamera.transform.position - var_4_3.position).y, (manager.ui.mainCamera.transform.position - var_4_3.position).z)
				var_4_3.localEulerAngles.z = 0
				var_4_3.localEulerAngles.x = 0
				var_4_3.localEulerAngles = var_4_3.localEulerAngles
			end

			local var_4_5 = "B08a"

			if arg_1_1.bgs_.B08a == nil then
				local var_4_6 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_6:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_5)
				var_4_6.name = var_4_5
				var_4_6.transform.parent = arg_1_1.stage_.transform
				var_4_6.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_5] = var_4_6
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_7 = arg_1_1.bgs_.B08a

				arg_1_1.bgs_.B08a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_7.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_8 = var_4_7:GetComponent("SpriteRenderer")

				if var_4_8 and var_4_8.sprite then
					local var_4_9 = 2 * (var_4_7.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_7.transform.localScale = Vector3.New(var_4_9 / var_4_8.sprite.bounds.size.y < var_4_9 * manager.ui.mainCameraCom_.aspect / var_4_8.sprite.bounds.size.x and var_4_9 * manager.ui.mainCameraCom_.aspect / var_4_8.sprite.bounds.size.x or var_4_9 / var_4_8.sprite.bounds.size.y, var_4_9 / var_4_8.sprite.bounds.size.y < var_4_9 * manager.ui.mainCameraCom_.aspect / var_4_8.sprite.bounds.size.x and var_4_9 * manager.ui.mainCameraCom_.aspect / var_4_8.sprite.bounds.size.x or var_4_9 / var_4_8.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "B08a" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_10 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_10 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_11 = 2

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

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				arg_1_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action4_1")
			end

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				arg_1_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_4_14 = arg_1_1.actors_["1111ui_story"]

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 and not isNil(var_4_14) and arg_1_1.var_.characterEffect1111ui_story == nil then
				arg_1_1.var_.characterEffect1111ui_story = var_4_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_15 = 0.2

			if 1.8 <= arg_1_1.time_ and arg_1_1.time_ < 1.8 + var_4_15 and not isNil(var_4_14) then
				if arg_1_1.var_.characterEffect1111ui_story and not isNil(var_4_14) then
					arg_1_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= 1.8 + var_4_15 and arg_1_1.time_ < 1.8 + var_4_15 + arg_4_0 and not isNil(var_4_14) and arg_1_1.var_.characterEffect1111ui_story then
				arg_1_1.var_.characterEffect1111ui_story.fillFlat = false
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

			if 0.5 < arg_1_1.time_ and arg_1_1.time_ <= 0.5 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_1_0_1_osiris_ui", "bgm_activity_1_0_1_osiris_ui", "bgm_activity_1_0_1_osiris_ui.awb")

				local var_4_22 = manager.audio:GetAudioName("bgm_activity_1_0_1_osiris_ui", "bgm_activity_1_0_1_osiris_ui")

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

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_23 = 2
			local var_4_24 = 0.15

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_23 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_25 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_25:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_25:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_25:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_26 = arg_1_1:GetWordFromCfg(62109001)
				local var_4_27 = arg_1_1:FormatText(var_4_26.content)

				arg_1_1.text_.text = var_4_27

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_29 = 6 <= 0 and var_4_24 or var_4_24 * (utf8.len(var_4_27) / 6)

				if (6 <= 0 and var_4_24 or var_4_24 * (utf8.len(var_4_27) / 6)) > 0 and var_4_24 < var_4_29 then
					arg_1_1.talkMaxDuration = var_4_29
					var_4_23 = var_4_23 + 0.3

					if var_4_29 + var_4_23 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_29 + var_4_23
					end
				end

				arg_1_1.text_.text = var_4_27
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_chess_62109", "62109001", "story_v_chess_62109.awb") ~= 0 then
					local var_4_30 = manager.audio:GetVoiceLength("story_v_chess_62109", "62109001", "story_v_chess_62109.awb") / 1000

					if var_4_30 + var_4_23 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_30 + var_4_23
					end

					if var_4_26.prefab_name ~= "" and arg_1_1.actors_[var_4_26.prefab_name] ~= nil then
						local var_4_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_26.prefab_name].transform, "story_v_chess_62109", "62109001", "story_v_chess_62109.awb")

						arg_1_1:RecordAudio("62109001", var_4_31)
						arg_1_1:RecordAudio("62109001", var_4_31)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_chess_62109", "62109001", "story_v_chess_62109.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_chess_62109", "62109001", "story_v_chess_62109.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_32 = var_4_23 + 0.3
			local var_4_33 = math.max(var_4_24, arg_1_1.talkMaxDuration)

			if var_4_23 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_32 + var_4_33 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_32) / var_4_33

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_32 + var_4_33 and arg_1_1.time_ < var_4_32 + var_4_33 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play62109002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 62109002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play62109003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.var_.moveOldPos1111ui_story = arg_9_1.actors_["1111ui_story"].transform.localPosition
			end

			local var_12_0 = 0.001

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_0 then
				arg_9_1.actors_["1111ui_story"].transform.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos1111ui_story, Vector3.New(0, 100, 0), (arg_9_1.time_ - 0) / var_12_0)
				arg_9_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_9_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_9_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_9_1.actors_["1111ui_story"].transform.position).z)
				arg_9_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_9_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_9_1.actors_["1111ui_story"].transform.localEulerAngles = arg_9_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if arg_9_1.time_ >= 0 + var_12_0 and arg_9_1.time_ < 0 + var_12_0 + arg_12_0 then
				arg_9_1.actors_["1111ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_9_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_9_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_9_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_9_1.actors_["1111ui_story"].transform.position).z)
				arg_9_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_9_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_9_1.actors_["1111ui_story"].transform.localEulerAngles = arg_9_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			local var_12_1 = 0
			local var_12_2 = 0.975

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_1 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, false)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_3 = arg_9_1:FormatText(arg_9_1:GetWordFromCfg(62109002).content)

				arg_9_1.text_.text = var_12_3

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_5 = 39 <= 0 and var_12_2 or var_12_2 * (utf8.len(var_12_3) / 39)

				if (39 <= 0 and var_12_2 or var_12_2 * (utf8.len(var_12_3) / 39)) > 0 and var_12_2 < var_12_5 then
					arg_9_1.talkMaxDuration = var_12_5

					if var_12_5 + var_12_1 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_5 + var_12_1
					end
				end

				arg_9_1.text_.text = var_12_3
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)
				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_6 = math.max(var_12_2, arg_9_1.talkMaxDuration)

			if var_12_1 <= arg_9_1.time_ and arg_9_1.time_ < var_12_1 + var_12_6 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_1) / var_12_6

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_1 + var_12_6 and arg_9_1.time_ < var_12_1 + var_12_6 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_9_1:InitPlayNodeList()
	end,
	Play62109003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 62109003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play62109004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 0.25

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, true)
				arg_13_1.iconController_:SetSelectedState("hero")

				arg_13_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_13_1.callingController_:SetSelectedState("normal")

				arg_13_1.keyicon_.color = Color.New(1, 1, 1)
				arg_13_1.icon_.color = Color.New(1, 1, 1)

				local var_16_1 = arg_13_1:FormatText(arg_13_1:GetWordFromCfg(62109003).content)

				arg_13_1.text_.text = var_16_1

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_3 = 10 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_1) / 10)

				if (10 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_1) / 10)) > 0 and var_16_0 < var_16_3 then
					arg_13_1.talkMaxDuration = var_16_3

					if var_16_3 + 0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_3 + 0
					end
				end

				arg_13_1.text_.text = var_16_1
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)
				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_4 = math.max(var_16_0, arg_13_1.talkMaxDuration)

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_4 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - 0) / var_16_4

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= 0 + var_16_4 and arg_13_1.time_ < 0 + var_16_4 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play62109004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 62109004
		arg_17_1.duration_ = 6.2

		local var_17_0 = {
			ja = 6.2,
			ko = 3.433,
			zh = 3.9,
			en = 5.033
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
				arg_17_0:Play62109005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.var_.moveOldPos1111ui_story = arg_17_1.actors_["1111ui_story"].transform.localPosition
			end

			local var_20_0 = 0.001

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_0 then
				arg_17_1.actors_["1111ui_story"].transform.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1111ui_story, Vector3.New(0, -0.87, -5.7), (arg_17_1.time_ - 0) / var_20_0)
				arg_17_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_17_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["1111ui_story"].transform.position).z)
				arg_17_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_17_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_17_1.actors_["1111ui_story"].transform.localEulerAngles = arg_17_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if arg_17_1.time_ >= 0 + var_20_0 and arg_17_1.time_ < 0 + var_20_0 + arg_20_0 then
				arg_17_1.actors_["1111ui_story"].transform.localPosition = Vector3.New(0, -0.87, -5.7)
				arg_17_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_17_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["1111ui_story"].transform.position).z)
				arg_17_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_17_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_17_1.actors_["1111ui_story"].transform.localEulerAngles = arg_17_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action1_1")
			end

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_20_1 = arg_17_1.actors_["1111ui_story"]

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(var_20_1) and arg_17_1.var_.characterEffect1111ui_story == nil then
				arg_17_1.var_.characterEffect1111ui_story = var_20_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_2 = 0.2

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_2 and not isNil(var_20_1) then
				if arg_17_1.var_.characterEffect1111ui_story and not isNil(var_20_1) then
					arg_17_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_17_1.time_ >= 0 + var_20_2 and arg_17_1.time_ < 0 + var_20_2 + arg_20_0 and not isNil(var_20_1) and arg_17_1.var_.characterEffect1111ui_story then
				arg_17_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_20_4 = 0
			local var_20_5 = 0.475

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_4 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_6 = arg_17_1:GetWordFromCfg(62109004)
				local var_20_7 = arg_17_1:FormatText(var_20_6.content)

				arg_17_1.text_.text = var_20_7

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_9 = 19 <= 0 and var_20_5 or var_20_5 * (utf8.len(var_20_7) / 19)

				if (19 <= 0 and var_20_5 or var_20_5 * (utf8.len(var_20_7) / 19)) > 0 and var_20_5 < var_20_9 then
					arg_17_1.talkMaxDuration = var_20_9

					if var_20_9 + var_20_4 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_9 + var_20_4
					end
				end

				arg_17_1.text_.text = var_20_7
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_chess_62109", "62109004", "story_v_chess_62109.awb") ~= 0 then
					local var_20_10 = manager.audio:GetVoiceLength("story_v_chess_62109", "62109004", "story_v_chess_62109.awb") / 1000

					if var_20_10 + var_20_4 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_10 + var_20_4
					end

					if var_20_6.prefab_name ~= "" and arg_17_1.actors_[var_20_6.prefab_name] ~= nil then
						local var_20_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_6.prefab_name].transform, "story_v_chess_62109", "62109004", "story_v_chess_62109.awb")

						arg_17_1:RecordAudio("62109004", var_20_11)
						arg_17_1:RecordAudio("62109004", var_20_11)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_chess_62109", "62109004", "story_v_chess_62109.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_chess_62109", "62109004", "story_v_chess_62109.awb")
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
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_17_1:InitPlayNodeList()
	end,
	Play62109005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 62109005
		arg_21_1.duration_ = 5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play62109006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(arg_21_1.actors_["1111ui_story"]) and arg_21_1.var_.characterEffect1111ui_story == nil then
				arg_21_1.var_.characterEffect1111ui_story = arg_21_1.actors_["1111ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_0 = 0.2

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_0 and not isNil(arg_21_1.actors_["1111ui_story"]) then
				if arg_21_1.var_.characterEffect1111ui_story and not isNil(arg_21_1.actors_["1111ui_story"]) then
					arg_21_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_21_1.var_.characterEffect1111ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_21_1.time_ - 0) / var_24_0)
				end
			end

			if arg_21_1.time_ >= 0 + var_24_0 and arg_21_1.time_ < 0 + var_24_0 + arg_24_0 and not isNil(arg_21_1.actors_["1111ui_story"]) and arg_21_1.var_.characterEffect1111ui_story then
				arg_21_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_21_1.var_.characterEffect1111ui_story.fillRatio = 0.5
			end

			local var_24_1 = 0
			local var_24_2 = 1.375

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_1 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, true)
				arg_21_1.iconController_:SetSelectedState("hero")

				arg_21_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_21_1.callingController_:SetSelectedState("normal")

				arg_21_1.keyicon_.color = Color.New(1, 1, 1)
				arg_21_1.icon_.color = Color.New(1, 1, 1)

				local var_24_3 = arg_21_1:FormatText(arg_21_1:GetWordFromCfg(62109005).content)

				arg_21_1.text_.text = var_24_3

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_5 = 55 <= 0 and var_24_2 or var_24_2 * (utf8.len(var_24_3) / 55)

				if (55 <= 0 and var_24_2 or var_24_2 * (utf8.len(var_24_3) / 55)) > 0 and var_24_2 < var_24_5 then
					arg_21_1.talkMaxDuration = var_24_5

					if var_24_5 + var_24_1 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_5 + var_24_1
					end
				end

				arg_21_1.text_.text = var_24_3
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)
				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_6 = math.max(var_24_2, arg_21_1.talkMaxDuration)

			if var_24_1 <= arg_21_1.time_ and arg_21_1.time_ < var_24_1 + var_24_6 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_1) / var_24_6

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_1 + var_24_6 and arg_21_1.time_ < var_24_1 + var_24_6 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play62109006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 62109006
		arg_25_1.duration_ = 6.4

		local var_25_0 = {
			ja = 1.999999999999,
			ko = 6.266,
			zh = 6.4,
			en = 6.3
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
				arg_25_0:Play62109007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action4_1")
			end

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_28_0 = arg_25_1.actors_["1111ui_story"]

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(var_28_0) and arg_25_1.var_.characterEffect1111ui_story == nil then
				arg_25_1.var_.characterEffect1111ui_story = var_28_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_1 = 0.2

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_1 and not isNil(var_28_0) then
				if arg_25_1.var_.characterEffect1111ui_story and not isNil(var_28_0) then
					arg_25_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_25_1.time_ >= 0 + var_28_1 and arg_25_1.time_ < 0 + var_28_1 + arg_28_0 and not isNil(var_28_0) and arg_25_1.var_.characterEffect1111ui_story then
				arg_25_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_28_3 = 0
			local var_28_4 = 0.8

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_3 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_5 = arg_25_1:GetWordFromCfg(62109006)
				local var_28_6 = arg_25_1:FormatText(var_28_5.content)

				arg_25_1.text_.text = var_28_6

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_8 = 30 <= 0 and var_28_4 or var_28_4 * (utf8.len(var_28_6) / 30)

				if (30 <= 0 and var_28_4 or var_28_4 * (utf8.len(var_28_6) / 30)) > 0 and var_28_4 < var_28_8 then
					arg_25_1.talkMaxDuration = var_28_8

					if var_28_8 + var_28_3 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_8 + var_28_3
					end
				end

				arg_25_1.text_.text = var_28_6
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_chess_62109", "62109006", "story_v_chess_62109.awb") ~= 0 then
					local var_28_9 = manager.audio:GetVoiceLength("story_v_chess_62109", "62109006", "story_v_chess_62109.awb") / 1000

					if var_28_9 + var_28_3 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_9 + var_28_3
					end

					if var_28_5.prefab_name ~= "" and arg_25_1.actors_[var_28_5.prefab_name] ~= nil then
						local var_28_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_5.prefab_name].transform, "story_v_chess_62109", "62109006", "story_v_chess_62109.awb")

						arg_25_1:RecordAudio("62109006", var_28_10)
						arg_25_1:RecordAudio("62109006", var_28_10)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_chess_62109", "62109006", "story_v_chess_62109.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_chess_62109", "62109006", "story_v_chess_62109.awb")
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

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play62109007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 62109007
		arg_29_1.duration_ = 6.83

		local var_29_0 = {
			ja = 6.3,
			ko = 6.433,
			zh = 6.833,
			en = 5.766
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
				arg_29_0:Play62109008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111actionlink/1111action442")
			end

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0204cva")
			end

			local var_32_0 = 0
			local var_32_1 = 0.8

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_0 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_2 = arg_29_1:GetWordFromCfg(62109007)
				local var_32_3 = arg_29_1:FormatText(var_32_2.content)

				arg_29_1.text_.text = var_32_3

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_5 = 32 <= 0 and var_32_1 or var_32_1 * (utf8.len(var_32_3) / 32)

				if (32 <= 0 and var_32_1 or var_32_1 * (utf8.len(var_32_3) / 32)) > 0 and var_32_1 < var_32_5 then
					arg_29_1.talkMaxDuration = var_32_5

					if var_32_5 + var_32_0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_5 + var_32_0
					end
				end

				arg_29_1.text_.text = var_32_3
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_chess_62109", "62109007", "story_v_chess_62109.awb") ~= 0 then
					local var_32_6 = manager.audio:GetVoiceLength("story_v_chess_62109", "62109007", "story_v_chess_62109.awb") / 1000

					if var_32_6 + var_32_0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_6 + var_32_0
					end

					if var_32_2.prefab_name ~= "" and arg_29_1.actors_[var_32_2.prefab_name] ~= nil then
						local var_32_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_2.prefab_name].transform, "story_v_chess_62109", "62109007", "story_v_chess_62109.awb")

						arg_29_1:RecordAudio("62109007", var_32_7)
						arg_29_1:RecordAudio("62109007", var_32_7)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_chess_62109", "62109007", "story_v_chess_62109.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_chess_62109", "62109007", "story_v_chess_62109.awb")
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
	Play62109008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 62109008
		arg_33_1.duration_ = 10.2

		local var_33_0 = {
			ja = 6.766,
			ko = 7.833,
			zh = 10.2,
			en = 7.5
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
				arg_33_0:Play62109009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_36_0 = 0
			local var_36_1 = 1.05

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_0 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				arg_33_1.leftNameTxt_.text = arg_33_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_2 = arg_33_1:GetWordFromCfg(62109008)
				local var_36_3 = arg_33_1:FormatText(var_36_2.content)

				arg_33_1.text_.text = var_36_3

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_5 = 33 <= 0 and var_36_1 or var_36_1 * (utf8.len(var_36_3) / 33)

				if (33 <= 0 and var_36_1 or var_36_1 * (utf8.len(var_36_3) / 33)) > 0 and var_36_1 < var_36_5 then
					arg_33_1.talkMaxDuration = var_36_5

					if var_36_5 + var_36_0 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_5 + var_36_0
					end
				end

				arg_33_1.text_.text = var_36_3
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_chess_62109", "62109008", "story_v_chess_62109.awb") ~= 0 then
					local var_36_6 = manager.audio:GetVoiceLength("story_v_chess_62109", "62109008", "story_v_chess_62109.awb") / 1000

					if var_36_6 + var_36_0 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_6 + var_36_0
					end

					if var_36_2.prefab_name ~= "" and arg_33_1.actors_[var_36_2.prefab_name] ~= nil then
						local var_36_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_2.prefab_name].transform, "story_v_chess_62109", "62109008", "story_v_chess_62109.awb")

						arg_33_1:RecordAudio("62109008", var_36_7)
						arg_33_1:RecordAudio("62109008", var_36_7)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_chess_62109", "62109008", "story_v_chess_62109.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_chess_62109", "62109008", "story_v_chess_62109.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_8 = math.max(var_36_1, arg_33_1.talkMaxDuration)

			if var_36_0 <= arg_33_1.time_ and arg_33_1.time_ < var_36_0 + var_36_8 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_0) / var_36_8

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_0 + var_36_8 and arg_33_1.time_ < var_36_0 + var_36_8 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play62109009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 62109009
		arg_37_1.duration_ = 5

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
			arg_37_1.auto_ = false
		end

		function arg_37_1.playNext_(arg_39_0)
			arg_37_1.onStoryFinished_()
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(arg_37_1.actors_["1111ui_story"]) and arg_37_1.var_.characterEffect1111ui_story == nil then
				arg_37_1.var_.characterEffect1111ui_story = arg_37_1.actors_["1111ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_0 = 0.2

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_0 and not isNil(arg_37_1.actors_["1111ui_story"]) then
				if arg_37_1.var_.characterEffect1111ui_story and not isNil(arg_37_1.actors_["1111ui_story"]) then
					arg_37_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_37_1.var_.characterEffect1111ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_37_1.time_ - 0) / var_40_0)
				end
			end

			if arg_37_1.time_ >= 0 + var_40_0 and arg_37_1.time_ < 0 + var_40_0 + arg_40_0 and not isNil(arg_37_1.actors_["1111ui_story"]) and arg_37_1.var_.characterEffect1111ui_story then
				arg_37_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_37_1.var_.characterEffect1111ui_story.fillRatio = 0.5
			end

			local var_40_1 = 0
			local var_40_2 = 0.2

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_1 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				arg_37_1.leftNameTxt_.text = arg_37_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, true)
				arg_37_1.iconController_:SetSelectedState("hero")

				arg_37_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_37_1.callingController_:SetSelectedState("normal")

				arg_37_1.keyicon_.color = Color.New(1, 1, 1)
				arg_37_1.icon_.color = Color.New(1, 1, 1)

				local var_40_3 = arg_37_1:FormatText(arg_37_1:GetWordFromCfg(62109009).content)

				arg_37_1.text_.text = var_40_3

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_5 = 8 <= 0 and var_40_2 or var_40_2 * (utf8.len(var_40_3) / 8)

				if (8 <= 0 and var_40_2 or var_40_2 * (utf8.len(var_40_3) / 8)) > 0 and var_40_2 < var_40_5 then
					arg_37_1.talkMaxDuration = var_40_5

					if var_40_5 + var_40_1 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_5 + var_40_1
					end
				end

				arg_37_1.text_.text = var_40_3
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)
				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_6 = math.max(var_40_2, arg_37_1.talkMaxDuration)

			if var_40_1 <= arg_37_1.time_ and arg_37_1.time_ < var_40_1 + var_40_6 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_1) / var_40_6

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_1 + var_40_6 and arg_37_1.time_ < var_40_1 + var_40_6 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/B08a"
	},
	voices = {
		"story_v_chess_62109.awb"
	}
}
