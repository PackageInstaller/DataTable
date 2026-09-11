return {
	Play1109703001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 1109703001
		arg_1_1.duration_ = 5.93

		local var_1_0 = {
			zh = 5.93333333518108,
			ja = 5.36733333518108
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
				arg_1_0:Play1109703002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.B13 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "B13")
				var_4_0.name = "B13"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.B13 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.B13

				arg_1_1.bgs_.B13.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "B13" then
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

			local var_4_8 = "1019ui_story"

			if arg_1_1.actors_["1019ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1019ui_story"))) then
				local var_4_9 = Object.Instantiate(Asset.Load("Char/" .. "1019ui_story"), arg_1_1.stage_.transform)

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

			local var_4_12 = arg_1_1.actors_["1019ui_story"].transform

			if 1.83333333333333 < arg_1_1.time_ and arg_1_1.time_ <= 1.83333333333333 + arg_4_0 then
				arg_1_1.var_.moveOldPos1019ui_story = var_4_12.localPosition
			end

			local var_4_13 = 0.001

			if 1.83333333333333 <= arg_1_1.time_ and arg_1_1.time_ < 1.83333333333333 + var_4_13 then
				var_4_12.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1019ui_story, Vector3.New(-0.2, -1.08, -5.9), (arg_1_1.time_ - 1.83333333333333) / var_4_13)
				var_4_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_12.position).x, (manager.ui.mainCamera.transform.position - var_4_12.position).y, (manager.ui.mainCamera.transform.position - var_4_12.position).z)
				var_4_12.localEulerAngles.z = 0
				var_4_12.localEulerAngles.x = 0
				var_4_12.localEulerAngles = var_4_12.localEulerAngles
			end

			if arg_1_1.time_ >= 1.83333333333333 + var_4_13 and arg_1_1.time_ < 1.83333333333333 + var_4_13 + arg_4_0 then
				var_4_12.localPosition = Vector3.New(-0.2, -1.08, -5.9)
				var_4_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_12.position).x, (manager.ui.mainCamera.transform.position - var_4_12.position).y, (manager.ui.mainCamera.transform.position - var_4_12.position).z)
				var_4_12.localEulerAngles.z = 0
				var_4_12.localEulerAngles.x = 0
				var_4_12.localEulerAngles = var_4_12.localEulerAngles
			end

			local var_4_14 = arg_1_1.actors_["1019ui_story"]

			if 1.83333333333333 < arg_1_1.time_ and arg_1_1.time_ <= 1.83333333333333 + arg_4_0 and not isNil(var_4_14) and arg_1_1.var_.characterEffect1019ui_story == nil then
				arg_1_1.var_.characterEffect1019ui_story = var_4_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_15 = 0.200000002980232

			if 1.83333333333333 <= arg_1_1.time_ and arg_1_1.time_ < 1.83333333333333 + var_4_15 and not isNil(var_4_14) then
				if arg_1_1.var_.characterEffect1019ui_story and not isNil(var_4_14) then
					arg_1_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= 1.83333333333333 + var_4_15 and arg_1_1.time_ < 1.83333333333333 + var_4_15 + arg_4_0 and not isNil(var_4_14) and arg_1_1.var_.characterEffect1019ui_story then
				arg_1_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			if 1.83333333333333 < arg_1_1.time_ and arg_1_1.time_ <= 1.83333333333333 + arg_4_0 then
				arg_1_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action1_1")
			end

			if 1.83333333333333 < arg_1_1.time_ and arg_1_1.time_ <= 1.83333333333333 + arg_4_0 then
				arg_1_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
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

			if 0.3 < arg_1_1.time_ and arg_1_1.time_ <= 0.3 + arg_4_0 then
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

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_23 = 1.86733333518108
			local var_4_24 = 0.475

			if 1.86733333518108 < arg_1_1.time_ and arg_1_1.time_ <= var_4_23 + arg_4_0 then
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

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_26 = arg_1_1:GetWordFromCfg(1109703001)
				local var_4_27 = arg_1_1:FormatText(var_4_26.content)

				arg_1_1.text_.text = var_4_27

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_29 = 19 <= 0 and var_4_24 or var_4_24 * (utf8.len(var_4_27) / 19)

				if (19 <= 0 and var_4_24 or var_4_24 * (utf8.len(var_4_27) / 19)) > 0 and var_4_24 < var_4_29 then
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

				if manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703001", "story_v_side_new_1109703.awb") ~= 0 then
					local var_4_30 = manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703001", "story_v_side_new_1109703.awb") / 1000

					if var_4_30 + var_4_23 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_30 + var_4_23
					end

					if var_4_26.prefab_name ~= "" and arg_1_1.actors_[var_4_26.prefab_name] ~= nil then
						local var_4_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_26.prefab_name].transform, "story_v_side_new_1109703", "1109703001", "story_v_side_new_1109703.awb")

						arg_1_1:RecordAudio("1109703001", var_4_31)
						arg_1_1:RecordAudio("1109703001", var_4_31)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_side_new_1109703", "1109703001", "story_v_side_new_1109703.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_side_new_1109703", "1109703001", "story_v_side_new_1109703.awb")
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
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.83333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play1109703002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 1109703002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play1109703003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 and not isNil(arg_9_1.actors_["1019ui_story"]) and arg_9_1.var_.characterEffect1019ui_story == nil then
				arg_9_1.var_.characterEffect1019ui_story = arg_9_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_0 = 0.200000002980232

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_0 and not isNil(arg_9_1.actors_["1019ui_story"]) then
				if arg_9_1.var_.characterEffect1019ui_story and not isNil(arg_9_1.actors_["1019ui_story"]) then
					arg_9_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_9_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_9_1.time_ - 0) / var_12_0)
				end
			end

			if arg_9_1.time_ >= 0 + var_12_0 and arg_9_1.time_ < 0 + var_12_0 + arg_12_0 and not isNil(arg_9_1.actors_["1019ui_story"]) and arg_9_1.var_.characterEffect1019ui_story then
				arg_9_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_9_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_12_1 = 0
			local var_12_2 = 0.125

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_1 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				arg_9_1.leftNameTxt_.text = arg_9_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, true)
				arg_9_1.iconController_:SetSelectedState("hero")

				arg_9_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_9_1.callingController_:SetSelectedState("normal")

				arg_9_1.keyicon_.color = Color.New(1, 1, 1)
				arg_9_1.icon_.color = Color.New(1, 1, 1)

				local var_12_3 = arg_9_1:FormatText(arg_9_1:GetWordFromCfg(1109703002).content)

				arg_9_1.text_.text = var_12_3

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_5 = 5 <= 0 and var_12_2 or var_12_2 * (utf8.len(var_12_3) / 5)

				if (5 <= 0 and var_12_2 or var_12_2 * (utf8.len(var_12_3) / 5)) > 0 and var_12_2 < var_12_5 then
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

		arg_9_1.nodeConfigList_ = {}

		arg_9_1:InitPlayNodeList()
	end,
	Play1109703003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 1109703003
		arg_13_1.duration_ = 7.47

		local var_13_0 = {
			zh = 7.133,
			ja = 7.466
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
				arg_13_0:Play1109703004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.var_.moveOldPos1019ui_story = arg_13_1.actors_["1019ui_story"].transform.localPosition
			end

			local var_16_0 = 0.001

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_0 then
				arg_13_1.actors_["1019ui_story"].transform.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos1019ui_story, Vector3.New(-0.2, -1.08, -5.9), (arg_13_1.time_ - 0) / var_16_0)
				arg_13_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_13_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_13_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_13_1.actors_["1019ui_story"].transform.position).z)
				arg_13_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_13_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_13_1.actors_["1019ui_story"].transform.localEulerAngles = arg_13_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			if arg_13_1.time_ >= 0 + var_16_0 and arg_13_1.time_ < 0 + var_16_0 + arg_16_0 then
				arg_13_1.actors_["1019ui_story"].transform.localPosition = Vector3.New(-0.2, -1.08, -5.9)
				arg_13_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_13_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_13_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_13_1.actors_["1019ui_story"].transform.position).z)
				arg_13_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_13_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_13_1.actors_["1019ui_story"].transform.localEulerAngles = arg_13_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			local var_16_1 = arg_13_1.actors_["1019ui_story"]

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(var_16_1) and arg_13_1.var_.characterEffect1019ui_story == nil then
				arg_13_1.var_.characterEffect1019ui_story = var_16_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_2 = 0.200000002980232

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_2 and not isNil(var_16_1) then
				if arg_13_1.var_.characterEffect1019ui_story and not isNil(var_16_1) then
					arg_13_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_13_1.time_ >= 0 + var_16_2 and arg_13_1.time_ < 0 + var_16_2 + arg_16_0 and not isNil(var_16_1) and arg_13_1.var_.characterEffect1019ui_story then
				arg_13_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action2_1")
			end

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_16_4 = 0
			local var_16_5 = 0.875

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_4 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_6 = arg_13_1:GetWordFromCfg(1109703003)
				local var_16_7 = arg_13_1:FormatText(var_16_6.content)

				arg_13_1.text_.text = var_16_7

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_9 = 35 <= 0 and var_16_5 or var_16_5 * (utf8.len(var_16_7) / 35)

				if (35 <= 0 and var_16_5 or var_16_5 * (utf8.len(var_16_7) / 35)) > 0 and var_16_5 < var_16_9 then
					arg_13_1.talkMaxDuration = var_16_9

					if var_16_9 + var_16_4 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_9 + var_16_4
					end
				end

				arg_13_1.text_.text = var_16_7
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703003", "story_v_side_new_1109703.awb") ~= 0 then
					local var_16_10 = manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703003", "story_v_side_new_1109703.awb") / 1000

					if var_16_10 + var_16_4 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_10 + var_16_4
					end

					if var_16_6.prefab_name ~= "" and arg_13_1.actors_[var_16_6.prefab_name] ~= nil then
						local var_16_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_6.prefab_name].transform, "story_v_side_new_1109703", "1109703003", "story_v_side_new_1109703.awb")

						arg_13_1:RecordAudio("1109703003", var_16_11)
						arg_13_1:RecordAudio("1109703003", var_16_11)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_side_new_1109703", "1109703003", "story_v_side_new_1109703.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_side_new_1109703", "1109703003", "story_v_side_new_1109703.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_12 = math.max(var_16_5, arg_13_1.talkMaxDuration)

			if var_16_4 <= arg_13_1.time_ and arg_13_1.time_ < var_16_4 + var_16_12 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_4) / var_16_12

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_4 + var_16_12 and arg_13_1.time_ < var_16_4 + var_16_12 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {
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

		arg_13_1:InitPlayNodeList()
	end,
	Play1109703004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 1109703004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play1109703005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(arg_17_1.actors_["1019ui_story"]) and arg_17_1.var_.characterEffect1019ui_story == nil then
				arg_17_1.var_.characterEffect1019ui_story = arg_17_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_0 = 0.200000002980232

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_0 and not isNil(arg_17_1.actors_["1019ui_story"]) then
				if arg_17_1.var_.characterEffect1019ui_story and not isNil(arg_17_1.actors_["1019ui_story"]) then
					arg_17_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_17_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_17_1.time_ - 0) / var_20_0)
				end
			end

			if arg_17_1.time_ >= 0 + var_20_0 and arg_17_1.time_ < 0 + var_20_0 + arg_20_0 and not isNil(arg_17_1.actors_["1019ui_story"]) and arg_17_1.var_.characterEffect1019ui_story then
				arg_17_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_17_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_20_1 = 0
			local var_20_2 = 0.225

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_1 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, true)
				arg_17_1.iconController_:SetSelectedState("hero")

				arg_17_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_17_1.callingController_:SetSelectedState("normal")

				arg_17_1.keyicon_.color = Color.New(1, 1, 1)
				arg_17_1.icon_.color = Color.New(1, 1, 1)

				local var_20_3 = arg_17_1:FormatText(arg_17_1:GetWordFromCfg(1109703004).content)

				arg_17_1.text_.text = var_20_3

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_5 = 9 <= 0 and var_20_2 or var_20_2 * (utf8.len(var_20_3) / 9)

				if (9 <= 0 and var_20_2 or var_20_2 * (utf8.len(var_20_3) / 9)) > 0 and var_20_2 < var_20_5 then
					arg_17_1.talkMaxDuration = var_20_5

					if var_20_5 + var_20_1 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_5 + var_20_1
					end
				end

				arg_17_1.text_.text = var_20_3
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)
				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_6 = math.max(var_20_2, arg_17_1.talkMaxDuration)

			if var_20_1 <= arg_17_1.time_ and arg_17_1.time_ < var_20_1 + var_20_6 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_1) / var_20_6

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_1 + var_20_6 and arg_17_1.time_ < var_20_1 + var_20_6 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play1109703005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 1109703005
		arg_21_1.duration_ = 9.3

		local var_21_0 = {
			zh = 5.266,
			ja = 9.3
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
				arg_21_0:Play1109703006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(arg_21_1.actors_["1019ui_story"]) and arg_21_1.var_.characterEffect1019ui_story == nil then
				arg_21_1.var_.characterEffect1019ui_story = arg_21_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_0 = 0.200000002980232

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_0 and not isNil(arg_21_1.actors_["1019ui_story"]) then
				if arg_21_1.var_.characterEffect1019ui_story and not isNil(arg_21_1.actors_["1019ui_story"]) then
					arg_21_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_21_1.time_ >= 0 + var_24_0 and arg_21_1.time_ < 0 + var_24_0 + arg_24_0 and not isNil(arg_21_1.actors_["1019ui_story"]) and arg_21_1.var_.characterEffect1019ui_story then
				arg_21_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019actionlink/1019action425")
			end

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_24_2 = 0
			local var_24_3 = 0.675

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_2 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_4 = arg_21_1:GetWordFromCfg(1109703005)
				local var_24_5 = arg_21_1:FormatText(var_24_4.content)

				arg_21_1.text_.text = var_24_5

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_7 = 27 <= 0 and var_24_3 or var_24_3 * (utf8.len(var_24_5) / 27)

				if (27 <= 0 and var_24_3 or var_24_3 * (utf8.len(var_24_5) / 27)) > 0 and var_24_3 < var_24_7 then
					arg_21_1.talkMaxDuration = var_24_7

					if var_24_7 + var_24_2 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_7 + var_24_2
					end
				end

				arg_21_1.text_.text = var_24_5
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703005", "story_v_side_new_1109703.awb") ~= 0 then
					local var_24_8 = manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703005", "story_v_side_new_1109703.awb") / 1000

					if var_24_8 + var_24_2 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_8 + var_24_2
					end

					if var_24_4.prefab_name ~= "" and arg_21_1.actors_[var_24_4.prefab_name] ~= nil then
						local var_24_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_4.prefab_name].transform, "story_v_side_new_1109703", "1109703005", "story_v_side_new_1109703.awb")

						arg_21_1:RecordAudio("1109703005", var_24_9)
						arg_21_1:RecordAudio("1109703005", var_24_9)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_side_new_1109703", "1109703005", "story_v_side_new_1109703.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_side_new_1109703", "1109703005", "story_v_side_new_1109703.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_10 = math.max(var_24_3, arg_21_1.talkMaxDuration)

			if var_24_2 <= arg_21_1.time_ and arg_21_1.time_ < var_24_2 + var_24_10 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_2) / var_24_10

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_2 + var_24_10 and arg_21_1.time_ < var_24_2 + var_24_10 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play1109703006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 1109703006
		arg_25_1.duration_ = 5

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play1109703007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.var_.moveOldPos1019ui_story = arg_25_1.actors_["1019ui_story"].transform.localPosition
			end

			local var_28_0 = 0.001

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_0 then
				arg_25_1.actors_["1019ui_story"].transform.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos1019ui_story, Vector3.New(0, 100, 0), (arg_25_1.time_ - 0) / var_28_0)
				arg_25_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_25_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["1019ui_story"].transform.position).z)
				arg_25_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_25_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_25_1.actors_["1019ui_story"].transform.localEulerAngles = arg_25_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			if arg_25_1.time_ >= 0 + var_28_0 and arg_25_1.time_ < 0 + var_28_0 + arg_28_0 then
				arg_25_1.actors_["1019ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_25_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_25_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["1019ui_story"].transform.position).z)
				arg_25_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_25_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_25_1.actors_["1019ui_story"].transform.localEulerAngles = arg_25_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			local var_28_1 = arg_25_1.actors_["1019ui_story"]

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(var_28_1) and arg_25_1.var_.characterEffect1019ui_story == nil then
				arg_25_1.var_.characterEffect1019ui_story = var_28_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_2 = 0.200000002980232

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_2 and not isNil(var_28_1) then
				if arg_25_1.var_.characterEffect1019ui_story and not isNil(var_28_1) then
					arg_25_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_25_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_25_1.time_ - 0) / var_28_2)
				end
			end

			if arg_25_1.time_ >= 0 + var_28_2 and arg_25_1.time_ < 0 + var_28_2 + arg_28_0 and not isNil(var_28_1) and arg_25_1.var_.characterEffect1019ui_story then
				arg_25_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_25_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_28_3 = 0
			local var_28_4 = 0.4

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_3 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, true)
				arg_25_1.iconController_:SetSelectedState("hero")

				arg_25_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_25_1.callingController_:SetSelectedState("normal")

				arg_25_1.keyicon_.color = Color.New(1, 1, 1)
				arg_25_1.icon_.color = Color.New(1, 1, 1)

				local var_28_5 = arg_25_1:FormatText(arg_25_1:GetWordFromCfg(1109703006).content)

				arg_25_1.text_.text = var_28_5

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_7 = 16 <= 0 and var_28_4 or var_28_4 * (utf8.len(var_28_5) / 16)

				if (16 <= 0 and var_28_4 or var_28_4 * (utf8.len(var_28_5) / 16)) > 0 and var_28_4 < var_28_7 then
					arg_25_1.talkMaxDuration = var_28_7

					if var_28_7 + var_28_3 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_7 + var_28_3
					end
				end

				arg_25_1.text_.text = var_28_5
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)
				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_8 = math.max(var_28_4, arg_25_1.talkMaxDuration)

			if var_28_3 <= arg_25_1.time_ and arg_25_1.time_ < var_28_3 + var_28_8 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_3) / var_28_8

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_3 + var_28_8 and arg_25_1.time_ < var_28_3 + var_28_8 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {
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

		arg_25_1:InitPlayNodeList()
	end,
	Play1109703007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 1109703007
		arg_29_1.duration_ = 3.9

		local var_29_0 = {
			zh = 3,
			ja = 3.9
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
				arg_29_0:Play1109703008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if arg_29_1.actors_["1097ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1097ui_story"))) then
				local var_32_0 = Object.Instantiate(Asset.Load("Char/" .. "1097ui_story"), arg_29_1.stage_.transform)

				var_32_0.name = "1097ui_story"
				var_32_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_29_1.actors_["1097ui_story"] = var_32_0

				local var_32_1 = var_32_0:GetComponentInChildren(typeof(CharacterEffect))

				var_32_1.enabled = true

				local var_32_2 = GameObjectTools.GetOrAddComponent(var_32_0, typeof(DynamicBoneHelper))

				if var_32_2 then
					var_32_2:EnableDynamicBone(false)
				end

				arg_29_1:ShowWeapon(var_32_1.transform, false)

				arg_29_1.var_["1097ui_story" .. "Animator"] = var_32_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_29_1.var_["1097ui_story" .. "Animator"].applyRootMotion = true
				arg_29_1.var_["1097ui_story" .. "LipSync"] = var_32_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_32_3 = arg_29_1.actors_["1097ui_story"].transform

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.var_.moveOldPos1097ui_story = var_32_3.localPosition
			end

			local var_32_4 = 0.001

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_4 then
				var_32_3.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos1097ui_story, Vector3.New(0, -0.54, -6.3), (arg_29_1.time_ - 0) / var_32_4)
				var_32_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_32_3.position).x, (manager.ui.mainCamera.transform.position - var_32_3.position).y, (manager.ui.mainCamera.transform.position - var_32_3.position).z)
				var_32_3.localEulerAngles.z = 0
				var_32_3.localEulerAngles.x = 0
				var_32_3.localEulerAngles = var_32_3.localEulerAngles
			end

			if arg_29_1.time_ >= 0 + var_32_4 and arg_29_1.time_ < 0 + var_32_4 + arg_32_0 then
				var_32_3.localPosition = Vector3.New(0, -0.54, -6.3)
				var_32_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_32_3.position).x, (manager.ui.mainCamera.transform.position - var_32_3.position).y, (manager.ui.mainCamera.transform.position - var_32_3.position).z)
				var_32_3.localEulerAngles.z = 0
				var_32_3.localEulerAngles.x = 0
				var_32_3.localEulerAngles = var_32_3.localEulerAngles
			end

			local var_32_5 = arg_29_1.actors_["1097ui_story"]

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(var_32_5) and arg_29_1.var_.characterEffect1097ui_story == nil then
				arg_29_1.var_.characterEffect1097ui_story = var_32_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_6 = 0.200000002980232

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_6 and not isNil(var_32_5) then
				if arg_29_1.var_.characterEffect1097ui_story and not isNil(var_32_5) then
					arg_29_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_29_1.time_ >= 0 + var_32_6 and arg_29_1.time_ < 0 + var_32_6 + arg_32_0 and not isNil(var_32_5) and arg_29_1.var_.characterEffect1097ui_story then
				arg_29_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_32_8 = 0
			local var_32_9 = 0.25

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_8 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_10 = arg_29_1:GetWordFromCfg(1109703007)
				local var_32_11 = arg_29_1:FormatText(var_32_10.content)

				arg_29_1.text_.text = var_32_11

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_13 = 10 <= 0 and var_32_9 or var_32_9 * (utf8.len(var_32_11) / 10)

				if (10 <= 0 and var_32_9 or var_32_9 * (utf8.len(var_32_11) / 10)) > 0 and var_32_9 < var_32_13 then
					arg_29_1.talkMaxDuration = var_32_13

					if var_32_13 + var_32_8 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_13 + var_32_8
					end
				end

				arg_29_1.text_.text = var_32_11
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703007", "story_v_side_new_1109703.awb") ~= 0 then
					local var_32_14 = manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703007", "story_v_side_new_1109703.awb") / 1000

					if var_32_14 + var_32_8 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_14 + var_32_8
					end

					if var_32_10.prefab_name ~= "" and arg_29_1.actors_[var_32_10.prefab_name] ~= nil then
						local var_32_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_10.prefab_name].transform, "story_v_side_new_1109703", "1109703007", "story_v_side_new_1109703.awb")

						arg_29_1:RecordAudio("1109703007", var_32_15)
						arg_29_1:RecordAudio("1109703007", var_32_15)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_side_new_1109703", "1109703007", "story_v_side_new_1109703.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_side_new_1109703", "1109703007", "story_v_side_new_1109703.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_16 = math.max(var_32_9, arg_29_1.talkMaxDuration)

			if var_32_8 <= arg_29_1.time_ and arg_29_1.time_ < var_32_8 + var_32_16 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_8) / var_32_16

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_8 + var_32_16 and arg_29_1.time_ < var_32_8 + var_32_16 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
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
	Play1109703008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 1109703008
		arg_33_1.duration_ = 5

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play1109703009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(arg_33_1.actors_["1097ui_story"]) and arg_33_1.var_.characterEffect1097ui_story == nil then
				arg_33_1.var_.characterEffect1097ui_story = arg_33_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_0 = 0.200000002980232

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_0 and not isNil(arg_33_1.actors_["1097ui_story"]) then
				if arg_33_1.var_.characterEffect1097ui_story and not isNil(arg_33_1.actors_["1097ui_story"]) then
					arg_33_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_33_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_33_1.time_ - 0) / var_36_0)
				end
			end

			if arg_33_1.time_ >= 0 + var_36_0 and arg_33_1.time_ < 0 + var_36_0 + arg_36_0 and not isNil(arg_33_1.actors_["1097ui_story"]) and arg_33_1.var_.characterEffect1097ui_story then
				arg_33_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_33_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_36_1 = 0
			local var_36_2 = 0.375

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_1 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				arg_33_1.leftNameTxt_.text = arg_33_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, true)
				arg_33_1.iconController_:SetSelectedState("hero")

				arg_33_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_33_1.callingController_:SetSelectedState("normal")

				arg_33_1.keyicon_.color = Color.New(1, 1, 1)
				arg_33_1.icon_.color = Color.New(1, 1, 1)

				local var_36_3 = arg_33_1:FormatText(arg_33_1:GetWordFromCfg(1109703008).content)

				arg_33_1.text_.text = var_36_3

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_5 = 15 <= 0 and var_36_2 or var_36_2 * (utf8.len(var_36_3) / 15)

				if (15 <= 0 and var_36_2 or var_36_2 * (utf8.len(var_36_3) / 15)) > 0 and var_36_2 < var_36_5 then
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

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play1109703009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 1109703009
		arg_37_1.duration_ = 9

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play1109703010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			if arg_37_1.bgs_.ST12 == nil then
				local var_40_0 = Object.Instantiate(arg_37_1.paintGo_)

				var_40_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST12")
				var_40_0.name = "ST12"
				var_40_0.transform.parent = arg_37_1.stage_.transform
				var_40_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_37_1.bgs_.ST12 = var_40_0
			end

			if 2 < arg_37_1.time_ and arg_37_1.time_ <= 2 + arg_40_0 then
				local var_40_1 = arg_37_1.bgs_.ST12

				arg_37_1.bgs_.ST12.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_40_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_40_2 = var_40_1:GetComponent("SpriteRenderer")

				if var_40_2 and var_40_2.sprite then
					local var_40_3 = 2 * (var_40_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_40_1.transform.localScale = Vector3.New(var_40_3 / var_40_2.sprite.bounds.size.y < var_40_3 * manager.ui.mainCameraCom_.aspect / var_40_2.sprite.bounds.size.x and var_40_3 * manager.ui.mainCameraCom_.aspect / var_40_2.sprite.bounds.size.x or var_40_3 / var_40_2.sprite.bounds.size.y, var_40_3 / var_40_2.sprite.bounds.size.y < var_40_3 * manager.ui.mainCameraCom_.aspect / var_40_2.sprite.bounds.size.x and var_40_3 * manager.ui.mainCameraCom_.aspect / var_40_2.sprite.bounds.size.x or var_40_3 / var_40_2.sprite.bounds.size.y, 0)
				end

				for iter_40_0, iter_40_1 in pairs(arg_37_1.bgs_) do
					if iter_40_0 ~= "ST12" then
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

			local var_40_12 = arg_37_1.actors_["1097ui_story"].transform

			if 1.966 < arg_37_1.time_ and arg_37_1.time_ <= 1.966 + arg_40_0 then
				arg_37_1.var_.moveOldPos1097ui_story = var_40_12.localPosition
			end

			local var_40_13 = 0.001

			if 1.966 <= arg_37_1.time_ and arg_37_1.time_ < 1.966 + var_40_13 then
				var_40_12.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos1097ui_story, Vector3.New(0, 100, 0), (arg_37_1.time_ - 1.966) / var_40_13)
				var_40_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_40_12.position).x, (manager.ui.mainCamera.transform.position - var_40_12.position).y, (manager.ui.mainCamera.transform.position - var_40_12.position).z)
				var_40_12.localEulerAngles.z = 0
				var_40_12.localEulerAngles.x = 0
				var_40_12.localEulerAngles = var_40_12.localEulerAngles
			end

			if arg_37_1.time_ >= 1.966 + var_40_13 and arg_37_1.time_ < 1.966 + var_40_13 + arg_40_0 then
				var_40_12.localPosition = Vector3.New(0, 100, 0)
				var_40_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_40_12.position).x, (manager.ui.mainCamera.transform.position - var_40_12.position).y, (manager.ui.mainCamera.transform.position - var_40_12.position).z)
				var_40_12.localEulerAngles.z = 0
				var_40_12.localEulerAngles.x = 0
				var_40_12.localEulerAngles = var_40_12.localEulerAngles
			end

			if arg_37_1.frameCnt_ <= 1 then
				arg_37_1.dialog_:SetActive(false)
			end

			local var_40_14 = 4
			local var_40_15 = 0.35

			if 4 < arg_37_1.time_ and arg_37_1.time_ <= var_40_14 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0

				arg_37_1.dialog_:SetActive(true)

				arg_37_1.dialogCg_.alpha = 0

				local var_40_16 = LeanTween.value(arg_37_1.dialog_, 0, 1, 0.3)

				var_40_16:setOnUpdate(LuaHelper.FloatAction(function(arg_41_0)
					arg_37_1.dialogCg_.alpha = arg_41_0
				end))
				var_40_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_37_1.dialog_)
					var_40_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_37_1.duration_ = arg_37_1.duration_ + 0.3

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

				local var_40_17 = arg_37_1:FormatText(arg_37_1:GetWordFromCfg(1109703009).content)

				arg_37_1.text_.text = var_40_17

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_19 = 14 <= 0 and var_40_15 or var_40_15 * (utf8.len(var_40_17) / 14)

				if (14 <= 0 and var_40_15 or var_40_15 * (utf8.len(var_40_17) / 14)) > 0 and var_40_15 < var_40_19 then
					arg_37_1.talkMaxDuration = var_40_19
					var_40_14 = var_40_14 + 0.3

					if var_40_19 + var_40_14 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_19 + var_40_14
					end
				end

				arg_37_1.text_.text = var_40_17
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)
				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_20 = var_40_14 + 0.3
			local var_40_21 = math.max(var_40_15, arg_37_1.talkMaxDuration)

			if var_40_14 + 0.3 <= arg_37_1.time_ and arg_37_1.time_ < var_40_20 + var_40_21 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_20) / var_40_21

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_20 + var_40_21 and arg_37_1.time_ < var_40_20 + var_40_21 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_37_1:InitPlayNodeList()
	end,
	Play1109703010 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 1109703010
		arg_43_1.duration_ = 4.4

		local var_43_0 = {
			zh = 4.033,
			ja = 4.4
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
				arg_43_0:Play1109703011(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				arg_43_1.var_.moveOldPos1097ui_story = arg_43_1.actors_["1097ui_story"].transform.localPosition
			end

			local var_46_0 = 0.001

			if 0 <= arg_43_1.time_ and arg_43_1.time_ < 0 + var_46_0 then
				arg_43_1.actors_["1097ui_story"].transform.localPosition = Vector3.Lerp(arg_43_1.var_.moveOldPos1097ui_story, Vector3.New(0, -0.54, -6.3), (arg_43_1.time_ - 0) / var_46_0)
				arg_43_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_43_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_43_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_43_1.actors_["1097ui_story"].transform.position).z)
				arg_43_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_43_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_43_1.actors_["1097ui_story"].transform.localEulerAngles = arg_43_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			if arg_43_1.time_ >= 0 + var_46_0 and arg_43_1.time_ < 0 + var_46_0 + arg_46_0 then
				arg_43_1.actors_["1097ui_story"].transform.localPosition = Vector3.New(0, -0.54, -6.3)
				arg_43_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_43_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_43_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_43_1.actors_["1097ui_story"].transform.position).z)
				arg_43_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_43_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_43_1.actors_["1097ui_story"].transform.localEulerAngles = arg_43_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			local var_46_1 = arg_43_1.actors_["1097ui_story"]

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 and not isNil(var_46_1) and arg_43_1.var_.characterEffect1097ui_story == nil then
				arg_43_1.var_.characterEffect1097ui_story = var_46_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_46_2 = 0.200000002980232

			if 0 <= arg_43_1.time_ and arg_43_1.time_ < 0 + var_46_2 and not isNil(var_46_1) then
				if arg_43_1.var_.characterEffect1097ui_story and not isNil(var_46_1) then
					arg_43_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_43_1.time_ >= 0 + var_46_2 and arg_43_1.time_ < 0 + var_46_2 + arg_46_0 and not isNil(var_46_1) and arg_43_1.var_.characterEffect1097ui_story then
				arg_43_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				arg_43_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				arg_43_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_46_4 = 0
			local var_46_5 = 0.325

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= var_46_4 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0
				arg_43_1.dialogCg_.alpha = 1

				arg_43_1.dialog_:SetActive(true)
				SetActive(arg_43_1.leftNameGo_, true)

				arg_43_1.leftNameTxt_.text = arg_43_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_43_1.leftNameTxt_.transform)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1.leftNameTxt_.text)
				SetActive(arg_43_1.iconTrs_.gameObject, false)
				arg_43_1.callingController_:SetSelectedState("normal")

				local var_46_6 = arg_43_1:GetWordFromCfg(1109703010)
				local var_46_7 = arg_43_1:FormatText(var_46_6.content)

				arg_43_1.text_.text = var_46_7

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_9 = 13 <= 0 and var_46_5 or var_46_5 * (utf8.len(var_46_7) / 13)

				if (13 <= 0 and var_46_5 or var_46_5 * (utf8.len(var_46_7) / 13)) > 0 and var_46_5 < var_46_9 then
					arg_43_1.talkMaxDuration = var_46_9

					if var_46_9 + var_46_4 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_9 + var_46_4
					end
				end

				arg_43_1.text_.text = var_46_7
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703010", "story_v_side_new_1109703.awb") ~= 0 then
					local var_46_10 = manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703010", "story_v_side_new_1109703.awb") / 1000

					if var_46_10 + var_46_4 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_10 + var_46_4
					end

					if var_46_6.prefab_name ~= "" and arg_43_1.actors_[var_46_6.prefab_name] ~= nil then
						local var_46_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_43_1.actors_[var_46_6.prefab_name].transform, "story_v_side_new_1109703", "1109703010", "story_v_side_new_1109703.awb")

						arg_43_1:RecordAudio("1109703010", var_46_11)
						arg_43_1:RecordAudio("1109703010", var_46_11)
					else
						arg_43_1:AudioAction("play", "voice", "story_v_side_new_1109703", "1109703010", "story_v_side_new_1109703.awb")
					end

					arg_43_1:RecordHistoryTalkVoice("story_v_side_new_1109703", "1109703010", "story_v_side_new_1109703.awb")
				end

				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_12 = math.max(var_46_5, arg_43_1.talkMaxDuration)

			if var_46_4 <= arg_43_1.time_ and arg_43_1.time_ < var_46_4 + var_46_12 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - var_46_4) / var_46_12

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= var_46_4 + var_46_12 and arg_43_1.time_ < var_46_4 + var_46_12 + arg_46_0 then
				arg_43_1.typewritter.percent = 1

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(true)
			end
		end

		arg_43_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
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
	Play1109703011 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 1109703011
		arg_47_1.duration_ = 5

		SetActive(arg_47_1.tipsGo_, false)

		function arg_47_1.onSingleLineFinish_()
			arg_47_1.onSingleLineUpdate_ = nil
			arg_47_1.onSingleLineFinish_ = nil
			arg_47_1.state_ = "waiting"
		end

		function arg_47_1.playNext_(arg_49_0)
			if arg_49_0 == 1 then
				arg_47_0:Play1109703012(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 and not isNil(arg_47_1.actors_["1097ui_story"]) and arg_47_1.var_.characterEffect1097ui_story == nil then
				arg_47_1.var_.characterEffect1097ui_story = arg_47_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_50_0 = 0.200000002980232

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_0 and not isNil(arg_47_1.actors_["1097ui_story"]) then
				if arg_47_1.var_.characterEffect1097ui_story and not isNil(arg_47_1.actors_["1097ui_story"]) then
					arg_47_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_47_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_47_1.time_ - 0) / var_50_0)
				end
			end

			if arg_47_1.time_ >= 0 + var_50_0 and arg_47_1.time_ < 0 + var_50_0 + arg_50_0 and not isNil(arg_47_1.actors_["1097ui_story"]) and arg_47_1.var_.characterEffect1097ui_story then
				arg_47_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_47_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_50_1 = 0
			local var_50_2 = 0.35

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

				local var_50_3 = arg_47_1:FormatText(arg_47_1:GetWordFromCfg(1109703011).content)

				arg_47_1.text_.text = var_50_3

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_5 = 14 <= 0 and var_50_2 or var_50_2 * (utf8.len(var_50_3) / 14)

				if (14 <= 0 and var_50_2 or var_50_2 * (utf8.len(var_50_3) / 14)) > 0 and var_50_2 < var_50_5 then
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
	Play1109703012 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 1109703012
		arg_51_1.duration_ = 5

		SetActive(arg_51_1.tipsGo_, false)

		function arg_51_1.onSingleLineFinish_()
			arg_51_1.onSingleLineUpdate_ = nil
			arg_51_1.onSingleLineFinish_ = nil
			arg_51_1.state_ = "waiting"
		end

		function arg_51_1.playNext_(arg_53_0)
			if arg_53_0 == 1 then
				arg_51_0:Play1109703013(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			local var_54_0 = 0.475

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, true)

				arg_51_1.leftNameTxt_.text = arg_51_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_51_1.leftNameTxt_.transform)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1.leftNameTxt_.text)
				SetActive(arg_51_1.iconTrs_.gameObject, true)
				arg_51_1.iconController_:SetSelectedState("hero")

				arg_51_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_51_1.callingController_:SetSelectedState("normal")

				arg_51_1.keyicon_.color = Color.New(1, 1, 1)
				arg_51_1.icon_.color = Color.New(1, 1, 1)

				local var_54_1 = arg_51_1:FormatText(arg_51_1:GetWordFromCfg(1109703012).content)

				arg_51_1.text_.text = var_54_1

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_3 = 19 <= 0 and var_54_0 or var_54_0 * (utf8.len(var_54_1) / 19)

				if (19 <= 0 and var_54_0 or var_54_0 * (utf8.len(var_54_1) / 19)) > 0 and var_54_0 < var_54_3 then
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
	Play1109703013 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 1109703013
		arg_55_1.duration_ = 9.6

		local var_55_0 = {
			zh = 8.133,
			ja = 9.6
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
				arg_55_0:Play1109703014(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 and not isNil(arg_55_1.actors_["1097ui_story"]) and arg_55_1.var_.characterEffect1097ui_story == nil then
				arg_55_1.var_.characterEffect1097ui_story = arg_55_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_58_0 = 0.200000002980232

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_0 and not isNil(arg_55_1.actors_["1097ui_story"]) then
				if arg_55_1.var_.characterEffect1097ui_story and not isNil(arg_55_1.actors_["1097ui_story"]) then
					arg_55_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_55_1.time_ >= 0 + var_58_0 and arg_55_1.time_ < 0 + var_58_0 + arg_58_0 and not isNil(arg_55_1.actors_["1097ui_story"]) and arg_55_1.var_.characterEffect1097ui_story then
				arg_55_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 then
				arg_55_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action7_1")
			end

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 then
				arg_55_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_58_2 = 0
			local var_58_3 = 1

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= var_58_2 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, true)

				arg_55_1.leftNameTxt_.text = arg_55_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_55_1.leftNameTxt_.transform)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1.leftNameTxt_.text)
				SetActive(arg_55_1.iconTrs_.gameObject, false)
				arg_55_1.callingController_:SetSelectedState("normal")

				local var_58_4 = arg_55_1:GetWordFromCfg(1109703013)
				local var_58_5 = arg_55_1:FormatText(var_58_4.content)

				arg_55_1.text_.text = var_58_5

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_7 = 40 <= 0 and var_58_3 or var_58_3 * (utf8.len(var_58_5) / 40)

				if (40 <= 0 and var_58_3 or var_58_3 * (utf8.len(var_58_5) / 40)) > 0 and var_58_3 < var_58_7 then
					arg_55_1.talkMaxDuration = var_58_7

					if var_58_7 + var_58_2 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_7 + var_58_2
					end
				end

				arg_55_1.text_.text = var_58_5
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703013", "story_v_side_new_1109703.awb") ~= 0 then
					local var_58_8 = manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703013", "story_v_side_new_1109703.awb") / 1000

					if var_58_8 + var_58_2 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_8 + var_58_2
					end

					if var_58_4.prefab_name ~= "" and arg_55_1.actors_[var_58_4.prefab_name] ~= nil then
						local var_58_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_55_1.actors_[var_58_4.prefab_name].transform, "story_v_side_new_1109703", "1109703013", "story_v_side_new_1109703.awb")

						arg_55_1:RecordAudio("1109703013", var_58_9)
						arg_55_1:RecordAudio("1109703013", var_58_9)
					else
						arg_55_1:AudioAction("play", "voice", "story_v_side_new_1109703", "1109703013", "story_v_side_new_1109703.awb")
					end

					arg_55_1:RecordHistoryTalkVoice("story_v_side_new_1109703", "1109703013", "story_v_side_new_1109703.awb")
				end

				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_10 = math.max(var_58_3, arg_55_1.talkMaxDuration)

			if var_58_2 <= arg_55_1.time_ and arg_55_1.time_ < var_58_2 + var_58_10 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - var_58_2) / var_58_10

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= var_58_2 + var_58_10 and arg_55_1.time_ < var_58_2 + var_58_10 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end

		arg_55_1.nodeConfigList_ = {}

		arg_55_1:InitPlayNodeList()
	end,
	Play1109703014 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 1109703014
		arg_59_1.duration_ = 5

		SetActive(arg_59_1.tipsGo_, false)

		function arg_59_1.onSingleLineFinish_()
			arg_59_1.onSingleLineUpdate_ = nil
			arg_59_1.onSingleLineFinish_ = nil
			arg_59_1.state_ = "waiting"
		end

		function arg_59_1.playNext_(arg_61_0)
			if arg_61_0 == 1 then
				arg_59_0:Play1109703015(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 and not isNil(arg_59_1.actors_["1097ui_story"]) and arg_59_1.var_.characterEffect1097ui_story == nil then
				arg_59_1.var_.characterEffect1097ui_story = arg_59_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_62_0 = 0.200000002980232

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_0 and not isNil(arg_59_1.actors_["1097ui_story"]) then
				if arg_59_1.var_.characterEffect1097ui_story and not isNil(arg_59_1.actors_["1097ui_story"]) then
					arg_59_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_59_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_59_1.time_ - 0) / var_62_0)
				end
			end

			if arg_59_1.time_ >= 0 + var_62_0 and arg_59_1.time_ < 0 + var_62_0 + arg_62_0 and not isNil(arg_59_1.actors_["1097ui_story"]) and arg_59_1.var_.characterEffect1097ui_story then
				arg_59_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_59_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_62_1 = 0
			local var_62_2 = 0.25

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= var_62_1 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, true)

				arg_59_1.leftNameTxt_.text = arg_59_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_59_1.leftNameTxt_.transform)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1.leftNameTxt_.text)
				SetActive(arg_59_1.iconTrs_.gameObject, true)
				arg_59_1.iconController_:SetSelectedState("hero")

				arg_59_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_59_1.callingController_:SetSelectedState("normal")

				arg_59_1.keyicon_.color = Color.New(1, 1, 1)
				arg_59_1.icon_.color = Color.New(1, 1, 1)

				local var_62_3 = arg_59_1:FormatText(arg_59_1:GetWordFromCfg(1109703014).content)

				arg_59_1.text_.text = var_62_3

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_5 = 10 <= 0 and var_62_2 or var_62_2 * (utf8.len(var_62_3) / 10)

				if (10 <= 0 and var_62_2 or var_62_2 * (utf8.len(var_62_3) / 10)) > 0 and var_62_2 < var_62_5 then
					arg_59_1.talkMaxDuration = var_62_5

					if var_62_5 + var_62_1 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_5 + var_62_1
					end
				end

				arg_59_1.text_.text = var_62_3
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)
				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_6 = math.max(var_62_2, arg_59_1.talkMaxDuration)

			if var_62_1 <= arg_59_1.time_ and arg_59_1.time_ < var_62_1 + var_62_6 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - var_62_1) / var_62_6

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= var_62_1 + var_62_6 and arg_59_1.time_ < var_62_1 + var_62_6 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end

		arg_59_1.nodeConfigList_ = {}

		arg_59_1:InitPlayNodeList()
	end,
	Play1109703015 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 1109703015
		arg_63_1.duration_ = 5

		SetActive(arg_63_1.tipsGo_, false)

		function arg_63_1.onSingleLineFinish_()
			arg_63_1.onSingleLineUpdate_ = nil
			arg_63_1.onSingleLineFinish_ = nil
			arg_63_1.state_ = "waiting"
		end

		function arg_63_1.playNext_(arg_65_0)
			if arg_65_0 == 1 then
				arg_63_0:Play1109703016(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			local var_66_0 = 0.775

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, false)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_63_1.iconTrs_.gameObject, false)
				arg_63_1.callingController_:SetSelectedState("normal")

				local var_66_1 = arg_63_1:FormatText(arg_63_1:GetWordFromCfg(1109703015).content)

				arg_63_1.text_.text = var_66_1

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_3 = 31 <= 0 and var_66_0 or var_66_0 * (utf8.len(var_66_1) / 31)

				if (31 <= 0 and var_66_0 or var_66_0 * (utf8.len(var_66_1) / 31)) > 0 and var_66_0 < var_66_3 then
					arg_63_1.talkMaxDuration = var_66_3

					if var_66_3 + 0 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_3 + 0
					end
				end

				arg_63_1.text_.text = var_66_1
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)
				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_4 = math.max(var_66_0, arg_63_1.talkMaxDuration)

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_4 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - 0) / var_66_4

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= 0 + var_66_4 and arg_63_1.time_ < 0 + var_66_4 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end

		arg_63_1.nodeConfigList_ = {}

		arg_63_1:InitPlayNodeList()
	end,
	Play1109703016 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 1109703016
		arg_67_1.duration_ = 5

		SetActive(arg_67_1.tipsGo_, false)

		function arg_67_1.onSingleLineFinish_()
			arg_67_1.onSingleLineUpdate_ = nil
			arg_67_1.onSingleLineFinish_ = nil
			arg_67_1.state_ = "waiting"
		end

		function arg_67_1.playNext_(arg_69_0)
			if arg_69_0 == 1 then
				arg_67_0:Play1109703017(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			local var_70_0 = 0.8

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, true)

				arg_67_1.leftNameTxt_.text = arg_67_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_67_1.leftNameTxt_.transform)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1.leftNameTxt_.text)
				SetActive(arg_67_1.iconTrs_.gameObject, true)
				arg_67_1.iconController_:SetSelectedState("hero")

				arg_67_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_67_1.callingController_:SetSelectedState("normal")

				arg_67_1.keyicon_.color = Color.New(1, 1, 1)
				arg_67_1.icon_.color = Color.New(1, 1, 1)

				local var_70_1 = arg_67_1:FormatText(arg_67_1:GetWordFromCfg(1109703016).content)

				arg_67_1.text_.text = var_70_1

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_3 = 32 <= 0 and var_70_0 or var_70_0 * (utf8.len(var_70_1) / 32)

				if (32 <= 0 and var_70_0 or var_70_0 * (utf8.len(var_70_1) / 32)) > 0 and var_70_0 < var_70_3 then
					arg_67_1.talkMaxDuration = var_70_3

					if var_70_3 + 0 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_3 + 0
					end
				end

				arg_67_1.text_.text = var_70_1
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)
				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_4 = math.max(var_70_0, arg_67_1.talkMaxDuration)

			if 0 <= arg_67_1.time_ and arg_67_1.time_ < 0 + var_70_4 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - 0) / var_70_4

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= 0 + var_70_4 and arg_67_1.time_ < 0 + var_70_4 + arg_70_0 then
				arg_67_1.typewritter.percent = 1

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(true)
			end
		end

		arg_67_1.nodeConfigList_ = {}

		arg_67_1:InitPlayNodeList()
	end,
	Play1109703017 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 1109703017
		arg_71_1.duration_ = 7.23

		local var_71_0 = {
			zh = 5.133,
			ja = 7.233
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
				arg_71_0:Play1109703018(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1.var_.moveOldPos1097ui_story = arg_71_1.actors_["1097ui_story"].transform.localPosition
			end

			local var_74_0 = 0.001

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_0 then
				arg_71_1.actors_["1097ui_story"].transform.localPosition = Vector3.Lerp(arg_71_1.var_.moveOldPos1097ui_story, Vector3.New(0, -0.54, -6.3), (arg_71_1.time_ - 0) / var_74_0)
				arg_71_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_71_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_71_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_71_1.actors_["1097ui_story"].transform.position).z)
				arg_71_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_71_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_71_1.actors_["1097ui_story"].transform.localEulerAngles = arg_71_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			if arg_71_1.time_ >= 0 + var_74_0 and arg_71_1.time_ < 0 + var_74_0 + arg_74_0 then
				arg_71_1.actors_["1097ui_story"].transform.localPosition = Vector3.New(0, -0.54, -6.3)
				arg_71_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_71_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_71_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_71_1.actors_["1097ui_story"].transform.position).z)
				arg_71_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_71_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_71_1.actors_["1097ui_story"].transform.localEulerAngles = arg_71_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			local var_74_1 = arg_71_1.actors_["1097ui_story"]

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 and not isNil(var_74_1) and arg_71_1.var_.characterEffect1097ui_story == nil then
				arg_71_1.var_.characterEffect1097ui_story = var_74_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_74_2 = 0.200000002980232

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_2 and not isNil(var_74_1) then
				if arg_71_1.var_.characterEffect1097ui_story and not isNil(var_74_1) then
					arg_71_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_71_1.time_ >= 0 + var_74_2 and arg_71_1.time_ < 0 + var_74_2 + arg_74_0 and not isNil(var_74_1) and arg_71_1.var_.characterEffect1097ui_story then
				arg_71_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action7_2")
			end

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_74_4 = 0
			local var_74_5 = 0.775

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= var_74_4 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, true)

				arg_71_1.leftNameTxt_.text = arg_71_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_71_1.leftNameTxt_.transform)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1.leftNameTxt_.text)
				SetActive(arg_71_1.iconTrs_.gameObject, false)
				arg_71_1.callingController_:SetSelectedState("normal")

				local var_74_6 = arg_71_1:GetWordFromCfg(1109703017)
				local var_74_7 = arg_71_1:FormatText(var_74_6.content)

				arg_71_1.text_.text = var_74_7

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_9 = 31 <= 0 and var_74_5 or var_74_5 * (utf8.len(var_74_7) / 31)

				if (31 <= 0 and var_74_5 or var_74_5 * (utf8.len(var_74_7) / 31)) > 0 and var_74_5 < var_74_9 then
					arg_71_1.talkMaxDuration = var_74_9

					if var_74_9 + var_74_4 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_9 + var_74_4
					end
				end

				arg_71_1.text_.text = var_74_7
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703017", "story_v_side_new_1109703.awb") ~= 0 then
					local var_74_10 = manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703017", "story_v_side_new_1109703.awb") / 1000

					if var_74_10 + var_74_4 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_10 + var_74_4
					end

					if var_74_6.prefab_name ~= "" and arg_71_1.actors_[var_74_6.prefab_name] ~= nil then
						local var_74_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_71_1.actors_[var_74_6.prefab_name].transform, "story_v_side_new_1109703", "1109703017", "story_v_side_new_1109703.awb")

						arg_71_1:RecordAudio("1109703017", var_74_11)
						arg_71_1:RecordAudio("1109703017", var_74_11)
					else
						arg_71_1:AudioAction("play", "voice", "story_v_side_new_1109703", "1109703017", "story_v_side_new_1109703.awb")
					end

					arg_71_1:RecordHistoryTalkVoice("story_v_side_new_1109703", "1109703017", "story_v_side_new_1109703.awb")
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

		arg_71_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
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
	Play1109703018 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 1109703018
		arg_75_1.duration_ = 5

		SetActive(arg_75_1.tipsGo_, false)

		function arg_75_1.onSingleLineFinish_()
			arg_75_1.onSingleLineUpdate_ = nil
			arg_75_1.onSingleLineFinish_ = nil
			arg_75_1.state_ = "waiting"
		end

		function arg_75_1.playNext_(arg_77_0)
			if arg_77_0 == 1 then
				arg_75_0:Play1109703019(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 and not isNil(arg_75_1.actors_["1097ui_story"]) and arg_75_1.var_.characterEffect1097ui_story == nil then
				arg_75_1.var_.characterEffect1097ui_story = arg_75_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_78_0 = 0.200000002980232

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_0 and not isNil(arg_75_1.actors_["1097ui_story"]) then
				if arg_75_1.var_.characterEffect1097ui_story and not isNil(arg_75_1.actors_["1097ui_story"]) then
					arg_75_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_75_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_75_1.time_ - 0) / var_78_0)
				end
			end

			if arg_75_1.time_ >= 0 + var_78_0 and arg_75_1.time_ < 0 + var_78_0 + arg_78_0 and not isNil(arg_75_1.actors_["1097ui_story"]) and arg_75_1.var_.characterEffect1097ui_story then
				arg_75_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_75_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_78_1 = 0
			local var_78_2 = 0.925

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= var_78_1 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, true)

				arg_75_1.leftNameTxt_.text = arg_75_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_75_1.leftNameTxt_.transform)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1.leftNameTxt_.text)
				SetActive(arg_75_1.iconTrs_.gameObject, true)
				arg_75_1.iconController_:SetSelectedState("hero")

				arg_75_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_75_1.callingController_:SetSelectedState("normal")

				arg_75_1.keyicon_.color = Color.New(1, 1, 1)
				arg_75_1.icon_.color = Color.New(1, 1, 1)

				local var_78_3 = arg_75_1:FormatText(arg_75_1:GetWordFromCfg(1109703018).content)

				arg_75_1.text_.text = var_78_3

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_5 = 37 <= 0 and var_78_2 or var_78_2 * (utf8.len(var_78_3) / 37)

				if (37 <= 0 and var_78_2 or var_78_2 * (utf8.len(var_78_3) / 37)) > 0 and var_78_2 < var_78_5 then
					arg_75_1.talkMaxDuration = var_78_5

					if var_78_5 + var_78_1 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_5 + var_78_1
					end
				end

				arg_75_1.text_.text = var_78_3
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)
				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_6 = math.max(var_78_2, arg_75_1.talkMaxDuration)

			if var_78_1 <= arg_75_1.time_ and arg_75_1.time_ < var_78_1 + var_78_6 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - var_78_1) / var_78_6

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= var_78_1 + var_78_6 and arg_75_1.time_ < var_78_1 + var_78_6 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {}

		arg_75_1:InitPlayNodeList()
	end,
	Play1109703019 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 1109703019
		arg_79_1.duration_ = 6.9

		local var_79_0 = {
			zh = 4.066,
			ja = 6.9
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
				arg_79_0:Play1109703020(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 and not isNil(arg_79_1.actors_["1097ui_story"]) and arg_79_1.var_.characterEffect1097ui_story == nil then
				arg_79_1.var_.characterEffect1097ui_story = arg_79_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_82_0 = 0.200000002980232

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_0 and not isNil(arg_79_1.actors_["1097ui_story"]) then
				if arg_79_1.var_.characterEffect1097ui_story and not isNil(arg_79_1.actors_["1097ui_story"]) then
					arg_79_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_79_1.time_ >= 0 + var_82_0 and arg_79_1.time_ < 0 + var_82_0 + arg_82_0 and not isNil(arg_79_1.actors_["1097ui_story"]) and arg_79_1.var_.characterEffect1097ui_story then
				arg_79_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_82_2 = 0
			local var_82_3 = 0.375

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= var_82_2 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, true)

				arg_79_1.leftNameTxt_.text = arg_79_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_79_1.leftNameTxt_.transform)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1.leftNameTxt_.text)
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_4 = arg_79_1:GetWordFromCfg(1109703019)
				local var_82_5 = arg_79_1:FormatText(var_82_4.content)

				arg_79_1.text_.text = var_82_5

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_7 = 15 <= 0 and var_82_3 or var_82_3 * (utf8.len(var_82_5) / 15)

				if (15 <= 0 and var_82_3 or var_82_3 * (utf8.len(var_82_5) / 15)) > 0 and var_82_3 < var_82_7 then
					arg_79_1.talkMaxDuration = var_82_7

					if var_82_7 + var_82_2 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_7 + var_82_2
					end
				end

				arg_79_1.text_.text = var_82_5
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703019", "story_v_side_new_1109703.awb") ~= 0 then
					local var_82_8 = manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703019", "story_v_side_new_1109703.awb") / 1000

					if var_82_8 + var_82_2 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_8 + var_82_2
					end

					if var_82_4.prefab_name ~= "" and arg_79_1.actors_[var_82_4.prefab_name] ~= nil then
						local var_82_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_79_1.actors_[var_82_4.prefab_name].transform, "story_v_side_new_1109703", "1109703019", "story_v_side_new_1109703.awb")

						arg_79_1:RecordAudio("1109703019", var_82_9)
						arg_79_1:RecordAudio("1109703019", var_82_9)
					else
						arg_79_1:AudioAction("play", "voice", "story_v_side_new_1109703", "1109703019", "story_v_side_new_1109703.awb")
					end

					arg_79_1:RecordHistoryTalkVoice("story_v_side_new_1109703", "1109703019", "story_v_side_new_1109703.awb")
				end

				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_10 = math.max(var_82_3, arg_79_1.talkMaxDuration)

			if var_82_2 <= arg_79_1.time_ and arg_79_1.time_ < var_82_2 + var_82_10 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_2) / var_82_10

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_2 + var_82_10 and arg_79_1.time_ < var_82_2 + var_82_10 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {}

		arg_79_1:InitPlayNodeList()
	end,
	Play1109703020 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 1109703020
		arg_83_1.duration_ = 5

		SetActive(arg_83_1.tipsGo_, false)

		function arg_83_1.onSingleLineFinish_()
			arg_83_1.onSingleLineUpdate_ = nil
			arg_83_1.onSingleLineFinish_ = nil
			arg_83_1.state_ = "waiting"
		end

		function arg_83_1.playNext_(arg_85_0)
			if arg_85_0 == 1 then
				arg_83_0:Play1109703021(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 and not isNil(arg_83_1.actors_["1097ui_story"]) and arg_83_1.var_.characterEffect1097ui_story == nil then
				arg_83_1.var_.characterEffect1097ui_story = arg_83_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_86_0 = 0.200000002980232

			if 0 <= arg_83_1.time_ and arg_83_1.time_ < 0 + var_86_0 and not isNil(arg_83_1.actors_["1097ui_story"]) then
				if arg_83_1.var_.characterEffect1097ui_story and not isNil(arg_83_1.actors_["1097ui_story"]) then
					arg_83_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_83_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_83_1.time_ - 0) / var_86_0)
				end
			end

			if arg_83_1.time_ >= 0 + var_86_0 and arg_83_1.time_ < 0 + var_86_0 + arg_86_0 and not isNil(arg_83_1.actors_["1097ui_story"]) and arg_83_1.var_.characterEffect1097ui_story then
				arg_83_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_83_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_86_1 = 0
			local var_86_2 = 1.075

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= var_86_1 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, false)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_83_1.iconTrs_.gameObject, false)
				arg_83_1.callingController_:SetSelectedState("normal")

				local var_86_3 = arg_83_1:FormatText(arg_83_1:GetWordFromCfg(1109703020).content)

				arg_83_1.text_.text = var_86_3

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_5 = 43 <= 0 and var_86_2 or var_86_2 * (utf8.len(var_86_3) / 43)

				if (43 <= 0 and var_86_2 or var_86_2 * (utf8.len(var_86_3) / 43)) > 0 and var_86_2 < var_86_5 then
					arg_83_1.talkMaxDuration = var_86_5

					if var_86_5 + var_86_1 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_5 + var_86_1
					end
				end

				arg_83_1.text_.text = var_86_3
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)
				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_6 = math.max(var_86_2, arg_83_1.talkMaxDuration)

			if var_86_1 <= arg_83_1.time_ and arg_83_1.time_ < var_86_1 + var_86_6 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - var_86_1) / var_86_6

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= var_86_1 + var_86_6 and arg_83_1.time_ < var_86_1 + var_86_6 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {}

		arg_83_1:InitPlayNodeList()
	end,
	Play1109703021 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 1109703021
		arg_87_1.duration_ = 5

		SetActive(arg_87_1.tipsGo_, false)

		function arg_87_1.onSingleLineFinish_()
			arg_87_1.onSingleLineUpdate_ = nil
			arg_87_1.onSingleLineFinish_ = nil
			arg_87_1.state_ = "waiting"
		end

		function arg_87_1.playNext_(arg_89_0)
			if arg_89_0 == 1 then
				arg_87_0:Play1109703022(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			local var_90_0 = 0.8

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, true)

				arg_87_1.leftNameTxt_.text = arg_87_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_87_1.leftNameTxt_.transform)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1.leftNameTxt_.text)
				SetActive(arg_87_1.iconTrs_.gameObject, true)
				arg_87_1.iconController_:SetSelectedState("hero")

				arg_87_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_87_1.callingController_:SetSelectedState("normal")

				arg_87_1.keyicon_.color = Color.New(1, 1, 1)
				arg_87_1.icon_.color = Color.New(1, 1, 1)

				local var_90_1 = arg_87_1:FormatText(arg_87_1:GetWordFromCfg(1109703021).content)

				arg_87_1.text_.text = var_90_1

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_3 = 32 <= 0 and var_90_0 or var_90_0 * (utf8.len(var_90_1) / 32)

				if (32 <= 0 and var_90_0 or var_90_0 * (utf8.len(var_90_1) / 32)) > 0 and var_90_0 < var_90_3 then
					arg_87_1.talkMaxDuration = var_90_3

					if var_90_3 + 0 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_3 + 0
					end
				end

				arg_87_1.text_.text = var_90_1
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)
				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_4 = math.max(var_90_0, arg_87_1.talkMaxDuration)

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_4 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - 0) / var_90_4

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= 0 + var_90_4 and arg_87_1.time_ < 0 + var_90_4 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {}

		arg_87_1:InitPlayNodeList()
	end,
	Play1109703022 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 1109703022
		arg_91_1.duration_ = 3.97

		local var_91_0 = {
			zh = 3.4,
			ja = 3.966
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
				arg_91_0:Play1109703023(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 and not isNil(arg_91_1.actors_["1097ui_story"]) and arg_91_1.var_.characterEffect1097ui_story == nil then
				arg_91_1.var_.characterEffect1097ui_story = arg_91_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_94_0 = 0.200000002980232

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_0 and not isNil(arg_91_1.actors_["1097ui_story"]) then
				if arg_91_1.var_.characterEffect1097ui_story and not isNil(arg_91_1.actors_["1097ui_story"]) then
					arg_91_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_91_1.time_ >= 0 + var_94_0 and arg_91_1.time_ < 0 + var_94_0 + arg_94_0 and not isNil(arg_91_1.actors_["1097ui_story"]) and arg_91_1.var_.characterEffect1097ui_story then
				arg_91_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				arg_91_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			local var_94_2 = 0
			local var_94_3 = 0.25

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= var_94_2 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, true)

				arg_91_1.leftNameTxt_.text = arg_91_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_91_1.leftNameTxt_.transform)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1.leftNameTxt_.text)
				SetActive(arg_91_1.iconTrs_.gameObject, false)
				arg_91_1.callingController_:SetSelectedState("normal")

				local var_94_4 = arg_91_1:GetWordFromCfg(1109703022)
				local var_94_5 = arg_91_1:FormatText(var_94_4.content)

				arg_91_1.text_.text = var_94_5

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_7 = 10 <= 0 and var_94_3 or var_94_3 * (utf8.len(var_94_5) / 10)

				if (10 <= 0 and var_94_3 or var_94_3 * (utf8.len(var_94_5) / 10)) > 0 and var_94_3 < var_94_7 then
					arg_91_1.talkMaxDuration = var_94_7

					if var_94_7 + var_94_2 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_7 + var_94_2
					end
				end

				arg_91_1.text_.text = var_94_5
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703022", "story_v_side_new_1109703.awb") ~= 0 then
					local var_94_8 = manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703022", "story_v_side_new_1109703.awb") / 1000

					if var_94_8 + var_94_2 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_8 + var_94_2
					end

					if var_94_4.prefab_name ~= "" and arg_91_1.actors_[var_94_4.prefab_name] ~= nil then
						local var_94_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_91_1.actors_[var_94_4.prefab_name].transform, "story_v_side_new_1109703", "1109703022", "story_v_side_new_1109703.awb")

						arg_91_1:RecordAudio("1109703022", var_94_9)
						arg_91_1:RecordAudio("1109703022", var_94_9)
					else
						arg_91_1:AudioAction("play", "voice", "story_v_side_new_1109703", "1109703022", "story_v_side_new_1109703.awb")
					end

					arg_91_1:RecordHistoryTalkVoice("story_v_side_new_1109703", "1109703022", "story_v_side_new_1109703.awb")
				end

				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_10 = math.max(var_94_3, arg_91_1.talkMaxDuration)

			if var_94_2 <= arg_91_1.time_ and arg_91_1.time_ < var_94_2 + var_94_10 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - var_94_2) / var_94_10

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= var_94_2 + var_94_10 and arg_91_1.time_ < var_94_2 + var_94_10 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {}

		arg_91_1:InitPlayNodeList()
	end,
	Play1109703023 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 1109703023
		arg_95_1.duration_ = 5

		SetActive(arg_95_1.tipsGo_, false)

		function arg_95_1.onSingleLineFinish_()
			arg_95_1.onSingleLineUpdate_ = nil
			arg_95_1.onSingleLineFinish_ = nil
			arg_95_1.state_ = "waiting"
		end

		function arg_95_1.playNext_(arg_97_0)
			if arg_97_0 == 1 then
				arg_95_0:Play1109703024(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 and not isNil(arg_95_1.actors_["1097ui_story"]) and arg_95_1.var_.characterEffect1097ui_story == nil then
				arg_95_1.var_.characterEffect1097ui_story = arg_95_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_98_0 = 0.200000002980232

			if 0 <= arg_95_1.time_ and arg_95_1.time_ < 0 + var_98_0 and not isNil(arg_95_1.actors_["1097ui_story"]) then
				if arg_95_1.var_.characterEffect1097ui_story and not isNil(arg_95_1.actors_["1097ui_story"]) then
					arg_95_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_95_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_95_1.time_ - 0) / var_98_0)
				end
			end

			if arg_95_1.time_ >= 0 + var_98_0 and arg_95_1.time_ < 0 + var_98_0 + arg_98_0 and not isNil(arg_95_1.actors_["1097ui_story"]) and arg_95_1.var_.characterEffect1097ui_story then
				arg_95_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_95_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_98_1 = 0
			local var_98_2 = 0.675

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= var_98_1 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, true)

				arg_95_1.leftNameTxt_.text = arg_95_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_95_1.leftNameTxt_.transform)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1.leftNameTxt_.text)
				SetActive(arg_95_1.iconTrs_.gameObject, true)
				arg_95_1.iconController_:SetSelectedState("hero")

				arg_95_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_95_1.callingController_:SetSelectedState("normal")

				arg_95_1.keyicon_.color = Color.New(1, 1, 1)
				arg_95_1.icon_.color = Color.New(1, 1, 1)

				local var_98_3 = arg_95_1:FormatText(arg_95_1:GetWordFromCfg(1109703023).content)

				arg_95_1.text_.text = var_98_3

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_5 = 27 <= 0 and var_98_2 or var_98_2 * (utf8.len(var_98_3) / 27)

				if (27 <= 0 and var_98_2 or var_98_2 * (utf8.len(var_98_3) / 27)) > 0 and var_98_2 < var_98_5 then
					arg_95_1.talkMaxDuration = var_98_5

					if var_98_5 + var_98_1 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_5 + var_98_1
					end
				end

				arg_95_1.text_.text = var_98_3
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)
				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_6 = math.max(var_98_2, arg_95_1.talkMaxDuration)

			if var_98_1 <= arg_95_1.time_ and arg_95_1.time_ < var_98_1 + var_98_6 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - var_98_1) / var_98_6

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= var_98_1 + var_98_6 and arg_95_1.time_ < var_98_1 + var_98_6 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {}

		arg_95_1:InitPlayNodeList()
	end,
	Play1109703024 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 1109703024
		arg_99_1.duration_ = 5

		SetActive(arg_99_1.tipsGo_, false)

		function arg_99_1.onSingleLineFinish_()
			arg_99_1.onSingleLineUpdate_ = nil
			arg_99_1.onSingleLineFinish_ = nil
			arg_99_1.state_ = "waiting"
		end

		function arg_99_1.playNext_(arg_101_0)
			if arg_101_0 == 1 then
				arg_99_0:Play1109703025(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			local var_102_0 = 0.775

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, false)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_99_1.iconTrs_.gameObject, false)
				arg_99_1.callingController_:SetSelectedState("normal")

				local var_102_1 = arg_99_1:FormatText(arg_99_1:GetWordFromCfg(1109703024).content)

				arg_99_1.text_.text = var_102_1

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_3 = 31 <= 0 and var_102_0 or var_102_0 * (utf8.len(var_102_1) / 31)

				if (31 <= 0 and var_102_0 or var_102_0 * (utf8.len(var_102_1) / 31)) > 0 and var_102_0 < var_102_3 then
					arg_99_1.talkMaxDuration = var_102_3

					if var_102_3 + 0 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_3 + 0
					end
				end

				arg_99_1.text_.text = var_102_1
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)
				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_4 = math.max(var_102_0, arg_99_1.talkMaxDuration)

			if 0 <= arg_99_1.time_ and arg_99_1.time_ < 0 + var_102_4 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - 0) / var_102_4

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= 0 + var_102_4 and arg_99_1.time_ < 0 + var_102_4 + arg_102_0 then
				arg_99_1.typewritter.percent = 1

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(true)
			end
		end

		arg_99_1.nodeConfigList_ = {}

		arg_99_1:InitPlayNodeList()
	end,
	Play1109703025 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 1109703025
		arg_103_1.duration_ = 6.37

		local var_103_0 = {
			zh = 4.1,
			ja = 6.366
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
				arg_103_0:Play1109703026(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 and not isNil(arg_103_1.actors_["1097ui_story"]) and arg_103_1.var_.characterEffect1097ui_story == nil then
				arg_103_1.var_.characterEffect1097ui_story = arg_103_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_106_0 = 0.200000002980232

			if 0 <= arg_103_1.time_ and arg_103_1.time_ < 0 + var_106_0 and not isNil(arg_103_1.actors_["1097ui_story"]) then
				if arg_103_1.var_.characterEffect1097ui_story and not isNil(arg_103_1.actors_["1097ui_story"]) then
					arg_103_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_103_1.time_ >= 0 + var_106_0 and arg_103_1.time_ < 0 + var_106_0 + arg_106_0 and not isNil(arg_103_1.actors_["1097ui_story"]) and arg_103_1.var_.characterEffect1097ui_story then
				arg_103_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 then
				arg_103_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action7_1")
			end

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 then
				arg_103_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_106_2 = 0
			local var_106_3 = 0.45

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= var_106_2 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, true)

				arg_103_1.leftNameTxt_.text = arg_103_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_103_1.leftNameTxt_.transform)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1.leftNameTxt_.text)
				SetActive(arg_103_1.iconTrs_.gameObject, false)
				arg_103_1.callingController_:SetSelectedState("normal")

				local var_106_4 = arg_103_1:GetWordFromCfg(1109703025)
				local var_106_5 = arg_103_1:FormatText(var_106_4.content)

				arg_103_1.text_.text = var_106_5

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_7 = 18 <= 0 and var_106_3 or var_106_3 * (utf8.len(var_106_5) / 18)

				if (18 <= 0 and var_106_3 or var_106_3 * (utf8.len(var_106_5) / 18)) > 0 and var_106_3 < var_106_7 then
					arg_103_1.talkMaxDuration = var_106_7

					if var_106_7 + var_106_2 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_7 + var_106_2
					end
				end

				arg_103_1.text_.text = var_106_5
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703025", "story_v_side_new_1109703.awb") ~= 0 then
					local var_106_8 = manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703025", "story_v_side_new_1109703.awb") / 1000

					if var_106_8 + var_106_2 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_8 + var_106_2
					end

					if var_106_4.prefab_name ~= "" and arg_103_1.actors_[var_106_4.prefab_name] ~= nil then
						local var_106_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_103_1.actors_[var_106_4.prefab_name].transform, "story_v_side_new_1109703", "1109703025", "story_v_side_new_1109703.awb")

						arg_103_1:RecordAudio("1109703025", var_106_9)
						arg_103_1:RecordAudio("1109703025", var_106_9)
					else
						arg_103_1:AudioAction("play", "voice", "story_v_side_new_1109703", "1109703025", "story_v_side_new_1109703.awb")
					end

					arg_103_1:RecordHistoryTalkVoice("story_v_side_new_1109703", "1109703025", "story_v_side_new_1109703.awb")
				end

				arg_103_1:RecordContent(arg_103_1.text_.text)
			end

			local var_106_10 = math.max(var_106_3, arg_103_1.talkMaxDuration)

			if var_106_2 <= arg_103_1.time_ and arg_103_1.time_ < var_106_2 + var_106_10 then
				arg_103_1.typewritter.percent = (arg_103_1.time_ - var_106_2) / var_106_10

				arg_103_1.typewritter:SetDirty()
			end

			if arg_103_1.time_ >= var_106_2 + var_106_10 and arg_103_1.time_ < var_106_2 + var_106_10 + arg_106_0 then
				arg_103_1.typewritter.percent = 1

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(true)
			end
		end

		arg_103_1.nodeConfigList_ = {}

		arg_103_1:InitPlayNodeList()
	end,
	Play1109703026 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 1109703026
		arg_107_1.duration_ = 5

		SetActive(arg_107_1.tipsGo_, false)

		function arg_107_1.onSingleLineFinish_()
			arg_107_1.onSingleLineUpdate_ = nil
			arg_107_1.onSingleLineFinish_ = nil
			arg_107_1.state_ = "waiting"
		end

		function arg_107_1.playNext_(arg_109_0)
			if arg_109_0 == 1 then
				arg_107_0:Play1109703027(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 and not isNil(arg_107_1.actors_["1097ui_story"]) and arg_107_1.var_.characterEffect1097ui_story == nil then
				arg_107_1.var_.characterEffect1097ui_story = arg_107_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_110_0 = 0.200000002980232

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_0 and not isNil(arg_107_1.actors_["1097ui_story"]) then
				if arg_107_1.var_.characterEffect1097ui_story and not isNil(arg_107_1.actors_["1097ui_story"]) then
					arg_107_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_107_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_107_1.time_ - 0) / var_110_0)
				end
			end

			if arg_107_1.time_ >= 0 + var_110_0 and arg_107_1.time_ < 0 + var_110_0 + arg_110_0 and not isNil(arg_107_1.actors_["1097ui_story"]) and arg_107_1.var_.characterEffect1097ui_story then
				arg_107_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_107_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_110_1 = 0
			local var_110_2 = 0.325

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= var_110_1 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, false)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_107_1.iconTrs_.gameObject, false)
				arg_107_1.callingController_:SetSelectedState("normal")

				local var_110_3 = arg_107_1:FormatText(arg_107_1:GetWordFromCfg(1109703026).content)

				arg_107_1.text_.text = var_110_3

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_5 = 13 <= 0 and var_110_2 or var_110_2 * (utf8.len(var_110_3) / 13)

				if (13 <= 0 and var_110_2 or var_110_2 * (utf8.len(var_110_3) / 13)) > 0 and var_110_2 < var_110_5 then
					arg_107_1.talkMaxDuration = var_110_5

					if var_110_5 + var_110_1 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_5 + var_110_1
					end
				end

				arg_107_1.text_.text = var_110_3
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)
				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_6 = math.max(var_110_2, arg_107_1.talkMaxDuration)

			if var_110_1 <= arg_107_1.time_ and arg_107_1.time_ < var_110_1 + var_110_6 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - var_110_1) / var_110_6

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= var_110_1 + var_110_6 and arg_107_1.time_ < var_110_1 + var_110_6 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {}

		arg_107_1:InitPlayNodeList()
	end,
	Play1109703027 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 1109703027
		arg_111_1.duration_ = 5

		SetActive(arg_111_1.tipsGo_, false)

		function arg_111_1.onSingleLineFinish_()
			arg_111_1.onSingleLineUpdate_ = nil
			arg_111_1.onSingleLineFinish_ = nil
			arg_111_1.state_ = "waiting"
		end

		function arg_111_1.playNext_(arg_113_0)
			if arg_113_0 == 1 then
				arg_111_0:Play1109703028(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 then
				arg_111_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action7_2")
			end

			local var_114_0 = 0
			local var_114_1 = 0.2

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= var_114_0 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, true)

				arg_111_1.leftNameTxt_.text = arg_111_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_111_1.leftNameTxt_.transform)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1.leftNameTxt_.text)
				SetActive(arg_111_1.iconTrs_.gameObject, true)
				arg_111_1.iconController_:SetSelectedState("hero")

				arg_111_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_111_1.callingController_:SetSelectedState("normal")

				arg_111_1.keyicon_.color = Color.New(1, 1, 1)
				arg_111_1.icon_.color = Color.New(1, 1, 1)

				local var_114_2 = arg_111_1:FormatText(arg_111_1:GetWordFromCfg(1109703027).content)

				arg_111_1.text_.text = var_114_2

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_4 = 8 <= 0 and var_114_1 or var_114_1 * (utf8.len(var_114_2) / 8)

				if (8 <= 0 and var_114_1 or var_114_1 * (utf8.len(var_114_2) / 8)) > 0 and var_114_1 < var_114_4 then
					arg_111_1.talkMaxDuration = var_114_4

					if var_114_4 + var_114_0 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_4 + var_114_0
					end
				end

				arg_111_1.text_.text = var_114_2
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)
				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_5 = math.max(var_114_1, arg_111_1.talkMaxDuration)

			if var_114_0 <= arg_111_1.time_ and arg_111_1.time_ < var_114_0 + var_114_5 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_0) / var_114_5

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_0 + var_114_5 and arg_111_1.time_ < var_114_0 + var_114_5 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {}

		arg_111_1:InitPlayNodeList()
	end,
	Play1109703028 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 1109703028
		arg_115_1.duration_ = 10.6

		local var_115_0 = {
			zh = 8.165999999999,
			ja = 10.599999999999
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
				arg_115_0:Play1109703029(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			if 2 < arg_115_1.time_ and arg_115_1.time_ <= 2 + arg_118_0 then
				local var_118_0 = arg_115_1.bgs_.ST12

				arg_115_1.bgs_.ST12.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_118_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_118_1 = var_118_0:GetComponent("SpriteRenderer")

				if var_118_1 and var_118_1.sprite then
					local var_118_2 = 2 * (var_118_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_118_0.transform.localScale = Vector3.New(var_118_2 / var_118_1.sprite.bounds.size.y < var_118_2 * manager.ui.mainCameraCom_.aspect / var_118_1.sprite.bounds.size.x and var_118_2 * manager.ui.mainCameraCom_.aspect / var_118_1.sprite.bounds.size.x or var_118_2 / var_118_1.sprite.bounds.size.y, var_118_2 / var_118_1.sprite.bounds.size.y < var_118_2 * manager.ui.mainCameraCom_.aspect / var_118_1.sprite.bounds.size.x and var_118_2 * manager.ui.mainCameraCom_.aspect / var_118_1.sprite.bounds.size.x or var_118_2 / var_118_1.sprite.bounds.size.y, 0)
				end

				for iter_118_0, iter_118_1 in pairs(arg_115_1.bgs_) do
					if iter_118_0 ~= "ST12" then
						iter_118_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_118_3 = 0

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= var_118_3 + arg_118_0 then
				arg_115_1.mask_.enabled = true
				arg_115_1.mask_.raycastTarget = true

				arg_115_1:SetGaussion(false)
			end

			local var_118_4 = 2

			if var_118_3 <= arg_115_1.time_ and arg_115_1.time_ < var_118_3 + var_118_4 then
				local var_118_5 = Color.New(0, 0, 0)

				var_118_5.a = Mathf.Lerp(0, 1, (arg_115_1.time_ - var_118_3) / var_118_4)
				arg_115_1.mask_.color = var_118_5
			end

			if arg_115_1.time_ >= var_118_3 + var_118_4 and arg_115_1.time_ < var_118_3 + var_118_4 + arg_118_0 then
				local var_118_6 = Color.New(0, 0, 0)

				var_118_6.a = 1
				arg_115_1.mask_.color = var_118_6
			end

			local var_118_7 = 2

			if 2 < arg_115_1.time_ and arg_115_1.time_ <= var_118_7 + arg_118_0 then
				arg_115_1.mask_.enabled = true
				arg_115_1.mask_.raycastTarget = true

				arg_115_1:SetGaussion(false)
			end

			local var_118_8 = 2

			if var_118_7 <= arg_115_1.time_ and arg_115_1.time_ < var_118_7 + var_118_8 then
				local var_118_9 = Color.New(0, 0, 0)

				var_118_9.a = Mathf.Lerp(1, 0, (arg_115_1.time_ - var_118_7) / var_118_8)
				arg_115_1.mask_.color = var_118_9
			end

			if arg_115_1.time_ >= var_118_7 + var_118_8 and arg_115_1.time_ < var_118_7 + var_118_8 + arg_118_0 then
				local var_118_10 = Color.New(0, 0, 0)

				arg_115_1.mask_.enabled = false
				var_118_10.a = 0
				arg_115_1.mask_.color = var_118_10
			end

			local var_118_11 = arg_115_1.actors_["1097ui_story"].transform

			if 1.96599999815226 < arg_115_1.time_ and arg_115_1.time_ <= 1.96599999815226 + arg_118_0 then
				arg_115_1.var_.moveOldPos1097ui_story = var_118_11.localPosition
			end

			local var_118_12 = 0.001

			if 1.96599999815226 <= arg_115_1.time_ and arg_115_1.time_ < 1.96599999815226 + var_118_12 then
				var_118_11.localPosition = Vector3.Lerp(arg_115_1.var_.moveOldPos1097ui_story, Vector3.New(0, 100, 0), (arg_115_1.time_ - 1.96599999815226) / var_118_12)
				var_118_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_118_11.position).x, (manager.ui.mainCamera.transform.position - var_118_11.position).y, (manager.ui.mainCamera.transform.position - var_118_11.position).z)
				var_118_11.localEulerAngles.z = 0
				var_118_11.localEulerAngles.x = 0
				var_118_11.localEulerAngles = var_118_11.localEulerAngles
			end

			if arg_115_1.time_ >= 1.96599999815226 + var_118_12 and arg_115_1.time_ < 1.96599999815226 + var_118_12 + arg_118_0 then
				var_118_11.localPosition = Vector3.New(0, 100, 0)
				var_118_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_118_11.position).x, (manager.ui.mainCamera.transform.position - var_118_11.position).y, (manager.ui.mainCamera.transform.position - var_118_11.position).z)
				var_118_11.localEulerAngles.z = 0
				var_118_11.localEulerAngles.x = 0
				var_118_11.localEulerAngles = var_118_11.localEulerAngles
			end

			local var_118_13 = arg_115_1.actors_["1097ui_story"]

			if 1.96599999815226 < arg_115_1.time_ and arg_115_1.time_ <= 1.96599999815226 + arg_118_0 and not isNil(var_118_13) and arg_115_1.var_.characterEffect1097ui_story == nil then
				arg_115_1.var_.characterEffect1097ui_story = var_118_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_118_14 = 0.034000001847744

			if 1.96599999815226 <= arg_115_1.time_ and arg_115_1.time_ < 1.96599999815226 + var_118_14 and not isNil(var_118_13) then
				if arg_115_1.var_.characterEffect1097ui_story and not isNil(var_118_13) then
					arg_115_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_115_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_115_1.time_ - 1.96599999815226) / var_118_14)
				end
			end

			if arg_115_1.time_ >= 1.96599999815226 + var_118_14 and arg_115_1.time_ < 1.96599999815226 + var_118_14 + arg_118_0 and not isNil(var_118_13) and arg_115_1.var_.characterEffect1097ui_story then
				arg_115_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_115_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_118_15 = "1042ui_story"

			if arg_115_1.actors_["1042ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1042ui_story"))) then
				local var_118_16 = Object.Instantiate(Asset.Load("Char/" .. "1042ui_story"), arg_115_1.stage_.transform)

				var_118_16.name = var_118_15
				var_118_16.transform.localPosition = Vector3.New(0, 100, 0)
				arg_115_1.actors_[var_118_15] = var_118_16

				local var_118_17 = var_118_16:GetComponentInChildren(typeof(CharacterEffect))

				var_118_17.enabled = true

				local var_118_18 = GameObjectTools.GetOrAddComponent(var_118_16, typeof(DynamicBoneHelper))

				if var_118_18 then
					var_118_18:EnableDynamicBone(false)
				end

				arg_115_1:ShowWeapon(var_118_17.transform, false)

				arg_115_1.var_[var_118_15 .. "Animator"] = var_118_17.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_115_1.var_[var_118_15 .. "Animator"].applyRootMotion = true
				arg_115_1.var_[var_118_15 .. "LipSync"] = var_118_17.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_118_19 = arg_115_1.actors_["1042ui_story"].transform

			if 3.8 < arg_115_1.time_ and arg_115_1.time_ <= 3.8 + arg_118_0 then
				arg_115_1.var_.moveOldPos1042ui_story = var_118_19.localPosition
			end

			local var_118_20 = 0.001

			if 3.8 <= arg_115_1.time_ and arg_115_1.time_ < 3.8 + var_118_20 then
				var_118_19.localPosition = Vector3.Lerp(arg_115_1.var_.moveOldPos1042ui_story, Vector3.New(0.7, -1.06, -6.2), (arg_115_1.time_ - 3.8) / var_118_20)
				var_118_19.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_118_19.position).x, (manager.ui.mainCamera.transform.position - var_118_19.position).y, (manager.ui.mainCamera.transform.position - var_118_19.position).z)
				var_118_19.localEulerAngles.z = 0
				var_118_19.localEulerAngles.x = 0
				var_118_19.localEulerAngles = var_118_19.localEulerAngles
			end

			if arg_115_1.time_ >= 3.8 + var_118_20 and arg_115_1.time_ < 3.8 + var_118_20 + arg_118_0 then
				var_118_19.localPosition = Vector3.New(0.7, -1.06, -6.2)
				var_118_19.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_118_19.position).x, (manager.ui.mainCamera.transform.position - var_118_19.position).y, (manager.ui.mainCamera.transform.position - var_118_19.position).z)
				var_118_19.localEulerAngles.z = 0
				var_118_19.localEulerAngles.x = 0
				var_118_19.localEulerAngles = var_118_19.localEulerAngles
			end

			local var_118_21 = arg_115_1.actors_["1042ui_story"]

			if 3.8 < arg_115_1.time_ and arg_115_1.time_ <= 3.8 + arg_118_0 and not isNil(var_118_21) and arg_115_1.var_.characterEffect1042ui_story == nil then
				arg_115_1.var_.characterEffect1042ui_story = var_118_21:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_118_22 = 0.200000002980232

			if 3.8 <= arg_115_1.time_ and arg_115_1.time_ < 3.8 + var_118_22 and not isNil(var_118_21) then
				if arg_115_1.var_.characterEffect1042ui_story and not isNil(var_118_21) then
					arg_115_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_115_1.time_ >= 3.8 + var_118_22 and arg_115_1.time_ < 3.8 + var_118_22 + arg_118_0 and not isNil(var_118_21) and arg_115_1.var_.characterEffect1042ui_story then
				arg_115_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			if 3.8 < arg_115_1.time_ and arg_115_1.time_ <= 3.8 + arg_118_0 then
				arg_115_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042action/1042action1_1")
			end

			if 3.8 < arg_115_1.time_ and arg_115_1.time_ <= 3.8 + arg_118_0 then
				arg_115_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_118_24 = arg_115_1.actors_["1097ui_story"].transform

			if 3.8 < arg_115_1.time_ and arg_115_1.time_ <= 3.8 + arg_118_0 then
				arg_115_1.var_.moveOldPos1097ui_story = var_118_24.localPosition
			end

			local var_118_25 = 0.001

			if 3.8 <= arg_115_1.time_ and arg_115_1.time_ < 3.8 + var_118_25 then
				var_118_24.localPosition = Vector3.Lerp(arg_115_1.var_.moveOldPos1097ui_story, Vector3.New(-0.7, -0.54, -6.3), (arg_115_1.time_ - 3.8) / var_118_25)
				var_118_24.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_118_24.position).x, (manager.ui.mainCamera.transform.position - var_118_24.position).y, (manager.ui.mainCamera.transform.position - var_118_24.position).z)
				var_118_24.localEulerAngles.z = 0
				var_118_24.localEulerAngles.x = 0
				var_118_24.localEulerAngles = var_118_24.localEulerAngles
			end

			if arg_115_1.time_ >= 3.8 + var_118_25 and arg_115_1.time_ < 3.8 + var_118_25 + arg_118_0 then
				var_118_24.localPosition = Vector3.New(-0.7, -0.54, -6.3)
				var_118_24.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_118_24.position).x, (manager.ui.mainCamera.transform.position - var_118_24.position).y, (manager.ui.mainCamera.transform.position - var_118_24.position).z)
				var_118_24.localEulerAngles.z = 0
				var_118_24.localEulerAngles.x = 0
				var_118_24.localEulerAngles = var_118_24.localEulerAngles
			end

			if 3.8 < arg_115_1.time_ and arg_115_1.time_ <= 3.8 + arg_118_0 then
				if arg_115_1.var_.characterEffect1042ui_story == nil then
					arg_115_1.var_.characterEffect1042ui_story = arg_115_1.actors_["1042ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_118_26 = arg_115_1.var_.characterEffect1042ui_story

				arg_115_1.var_.characterEffect1042ui_story.imageEffect:turnOff()

				var_118_26.interferenceEffect.enabled = true
				var_118_26.interferenceEffect.noise = 0.001
				var_118_26.interferenceEffect.simTimeScale = 1
				var_118_26.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			if 3.8 < arg_115_1.time_ and arg_115_1.time_ <= 3.8 + arg_118_0 then
				if arg_115_1.var_.characterEffect1042ui_story == nil then
					arg_115_1.var_.characterEffect1042ui_story = arg_115_1.actors_["1042ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_115_1.var_.characterEffect1042ui_story.imageEffect:turnOn(false)
			end

			if arg_115_1.frameCnt_ <= 1 then
				arg_115_1.dialog_:SetActive(false)
			end

			local var_118_28 = 3.999999999999
			local var_118_29 = 0.475

			if 3.999999999999 < arg_115_1.time_ and arg_115_1.time_ <= var_118_28 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0

				arg_115_1.dialog_:SetActive(true)

				arg_115_1.dialogCg_.alpha = 0

				local var_118_30 = LeanTween.value(arg_115_1.dialog_, 0, 1, 0.3)

				var_118_30:setOnUpdate(LuaHelper.FloatAction(function(arg_119_0)
					arg_115_1.dialogCg_.alpha = arg_119_0
				end))
				var_118_30:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_115_1.dialog_)
					var_118_30:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_115_1.duration_ = arg_115_1.duration_ + 0.3

				SetActive(arg_115_1.leftNameGo_, true)

				arg_115_1.leftNameTxt_.text = arg_115_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_31 = arg_115_1:GetWordFromCfg(1109703028)
				local var_118_32 = arg_115_1:FormatText(var_118_31.content)

				arg_115_1.text_.text = var_118_32

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_34 = 19 <= 0 and var_118_29 or var_118_29 * (utf8.len(var_118_32) / 19)

				if (19 <= 0 and var_118_29 or var_118_29 * (utf8.len(var_118_32) / 19)) > 0 and var_118_29 < var_118_34 then
					arg_115_1.talkMaxDuration = var_118_34
					var_118_28 = var_118_28 + 0.3

					if var_118_34 + var_118_28 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_34 + var_118_28
					end
				end

				arg_115_1.text_.text = var_118_32
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703028", "story_v_side_new_1109703.awb") ~= 0 then
					local var_118_35 = manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703028", "story_v_side_new_1109703.awb") / 1000

					if var_118_35 + var_118_28 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_35 + var_118_28
					end

					if var_118_31.prefab_name ~= "" and arg_115_1.actors_[var_118_31.prefab_name] ~= nil then
						local var_118_36 = LuaForUtil.PlayVoiceWithCriLipsync(arg_115_1.actors_[var_118_31.prefab_name].transform, "story_v_side_new_1109703", "1109703028", "story_v_side_new_1109703.awb")

						arg_115_1:RecordAudio("1109703028", var_118_36)
						arg_115_1:RecordAudio("1109703028", var_118_36)
					else
						arg_115_1:AudioAction("play", "voice", "story_v_side_new_1109703", "1109703028", "story_v_side_new_1109703.awb")
					end

					arg_115_1:RecordHistoryTalkVoice("story_v_side_new_1109703", "1109703028", "story_v_side_new_1109703.awb")
				end

				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_37 = var_118_28 + 0.3
			local var_118_38 = math.max(var_118_29, arg_115_1.talkMaxDuration)

			if var_118_28 + 0.3 <= arg_115_1.time_ and arg_115_1.time_ < var_118_37 + var_118_38 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - var_118_37) / var_118_38

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= var_118_37 + var_118_38 and arg_115_1.time_ < var_118_37 + var_118_38 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1042ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_115_1:InitPlayNodeList()
	end,
	Play1109703029 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 1109703029
		arg_121_1.duration_ = 5.27

		local var_121_0 = {
			zh = 4.766,
			ja = 5.266
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
				arg_121_0:Play1109703030(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 and not isNil(arg_121_1.actors_["1097ui_story"]) and arg_121_1.var_.characterEffect1097ui_story == nil then
				arg_121_1.var_.characterEffect1097ui_story = arg_121_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_0 = 0.200000002980232

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_0 and not isNil(arg_121_1.actors_["1097ui_story"]) then
				if arg_121_1.var_.characterEffect1097ui_story and not isNil(arg_121_1.actors_["1097ui_story"]) then
					arg_121_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_121_1.time_ >= 0 + var_124_0 and arg_121_1.time_ < 0 + var_124_0 + arg_124_0 and not isNil(arg_121_1.actors_["1097ui_story"]) and arg_121_1.var_.characterEffect1097ui_story then
				arg_121_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action6_1")
			end

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_124_2 = arg_121_1.actors_["1042ui_story"]

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 and not isNil(var_124_2) and arg_121_1.var_.characterEffect1042ui_story == nil then
				arg_121_1.var_.characterEffect1042ui_story = var_124_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_3 = 0.200000002980232

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_3 and not isNil(var_124_2) then
				if arg_121_1.var_.characterEffect1042ui_story and not isNil(var_124_2) then
					arg_121_1.var_.characterEffect1042ui_story.fillFlat = true
					arg_121_1.var_.characterEffect1042ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_121_1.time_ - 0) / var_124_3)
				end
			end

			if arg_121_1.time_ >= 0 + var_124_3 and arg_121_1.time_ < 0 + var_124_3 + arg_124_0 and not isNil(var_124_2) and arg_121_1.var_.characterEffect1042ui_story then
				arg_121_1.var_.characterEffect1042ui_story.fillFlat = true
				arg_121_1.var_.characterEffect1042ui_story.fillRatio = 0.5
			end

			local var_124_4 = 0
			local var_124_5 = 0.5

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= var_124_4 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				arg_121_1.leftNameTxt_.text = arg_121_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_6 = arg_121_1:GetWordFromCfg(1109703029)
				local var_124_7 = arg_121_1:FormatText(var_124_6.content)

				arg_121_1.text_.text = var_124_7

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_9 = 20 <= 0 and var_124_5 or var_124_5 * (utf8.len(var_124_7) / 20)

				if (20 <= 0 and var_124_5 or var_124_5 * (utf8.len(var_124_7) / 20)) > 0 and var_124_5 < var_124_9 then
					arg_121_1.talkMaxDuration = var_124_9

					if var_124_9 + var_124_4 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_9 + var_124_4
					end
				end

				arg_121_1.text_.text = var_124_7
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703029", "story_v_side_new_1109703.awb") ~= 0 then
					local var_124_10 = manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703029", "story_v_side_new_1109703.awb") / 1000

					if var_124_10 + var_124_4 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_10 + var_124_4
					end

					if var_124_6.prefab_name ~= "" and arg_121_1.actors_[var_124_6.prefab_name] ~= nil then
						local var_124_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_6.prefab_name].transform, "story_v_side_new_1109703", "1109703029", "story_v_side_new_1109703.awb")

						arg_121_1:RecordAudio("1109703029", var_124_11)
						arg_121_1:RecordAudio("1109703029", var_124_11)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_side_new_1109703", "1109703029", "story_v_side_new_1109703.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_side_new_1109703", "1109703029", "story_v_side_new_1109703.awb")
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

		arg_121_1.nodeConfigList_ = {}

		arg_121_1:InitPlayNodeList()
	end,
	Play1109703030 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 1109703030
		arg_125_1.duration_ = 5.83

		local var_125_0 = {
			zh = 5.233,
			ja = 5.833
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
				arg_125_0:Play1109703031(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 and not isNil(arg_125_1.actors_["1042ui_story"]) and arg_125_1.var_.characterEffect1042ui_story == nil then
				arg_125_1.var_.characterEffect1042ui_story = arg_125_1.actors_["1042ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_0 = 0.200000002980232

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_0 and not isNil(arg_125_1.actors_["1042ui_story"]) then
				if arg_125_1.var_.characterEffect1042ui_story and not isNil(arg_125_1.actors_["1042ui_story"]) then
					arg_125_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_125_1.time_ >= 0 + var_128_0 and arg_125_1.time_ < 0 + var_128_0 + arg_128_0 and not isNil(arg_125_1.actors_["1042ui_story"]) and arg_125_1.var_.characterEffect1042ui_story then
				arg_125_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042action/1042action2_1")
			end

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_128_2 = arg_125_1.actors_["1097ui_story"]

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 and not isNil(var_128_2) and arg_125_1.var_.characterEffect1097ui_story == nil then
				arg_125_1.var_.characterEffect1097ui_story = var_128_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_3 = 0.200000002980232

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_3 and not isNil(var_128_2) then
				if arg_125_1.var_.characterEffect1097ui_story and not isNil(var_128_2) then
					arg_125_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_125_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_125_1.time_ - 0) / var_128_3)
				end
			end

			if arg_125_1.time_ >= 0 + var_128_3 and arg_125_1.time_ < 0 + var_128_3 + arg_128_0 and not isNil(var_128_2) and arg_125_1.var_.characterEffect1097ui_story then
				arg_125_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_125_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_128_4 = 0
			local var_128_5 = 0.55

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= var_128_4 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				arg_125_1.leftNameTxt_.text = arg_125_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_6 = arg_125_1:GetWordFromCfg(1109703030)
				local var_128_7 = arg_125_1:FormatText(var_128_6.content)

				arg_125_1.text_.text = var_128_7

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_9 = 22 <= 0 and var_128_5 or var_128_5 * (utf8.len(var_128_7) / 22)

				if (22 <= 0 and var_128_5 or var_128_5 * (utf8.len(var_128_7) / 22)) > 0 and var_128_5 < var_128_9 then
					arg_125_1.talkMaxDuration = var_128_9

					if var_128_9 + var_128_4 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_9 + var_128_4
					end
				end

				arg_125_1.text_.text = var_128_7
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703030", "story_v_side_new_1109703.awb") ~= 0 then
					local var_128_10 = manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703030", "story_v_side_new_1109703.awb") / 1000

					if var_128_10 + var_128_4 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_10 + var_128_4
					end

					if var_128_6.prefab_name ~= "" and arg_125_1.actors_[var_128_6.prefab_name] ~= nil then
						local var_128_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_125_1.actors_[var_128_6.prefab_name].transform, "story_v_side_new_1109703", "1109703030", "story_v_side_new_1109703.awb")

						arg_125_1:RecordAudio("1109703030", var_128_11)
						arg_125_1:RecordAudio("1109703030", var_128_11)
					else
						arg_125_1:AudioAction("play", "voice", "story_v_side_new_1109703", "1109703030", "story_v_side_new_1109703.awb")
					end

					arg_125_1:RecordHistoryTalkVoice("story_v_side_new_1109703", "1109703030", "story_v_side_new_1109703.awb")
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

		arg_125_1.nodeConfigList_ = {}

		arg_125_1:InitPlayNodeList()
	end,
	Play1109703031 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 1109703031
		arg_129_1.duration_ = 6.9

		local var_129_0 = {
			zh = 4.933,
			ja = 6.9
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
				arg_129_0:Play1109703032(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 and not isNil(arg_129_1.actors_["1097ui_story"]) and arg_129_1.var_.characterEffect1097ui_story == nil then
				arg_129_1.var_.characterEffect1097ui_story = arg_129_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_132_0 = 0.200000002980232

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_0 and not isNil(arg_129_1.actors_["1097ui_story"]) then
				if arg_129_1.var_.characterEffect1097ui_story and not isNil(arg_129_1.actors_["1097ui_story"]) then
					arg_129_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_129_1.time_ >= 0 + var_132_0 and arg_129_1.time_ < 0 + var_132_0 + arg_132_0 and not isNil(arg_129_1.actors_["1097ui_story"]) and arg_129_1.var_.characterEffect1097ui_story then
				arg_129_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva")
			end

			local var_132_2 = arg_129_1.actors_["1042ui_story"]

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 and not isNil(var_132_2) and arg_129_1.var_.characterEffect1042ui_story == nil then
				arg_129_1.var_.characterEffect1042ui_story = var_132_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_132_3 = 0.200000002980232

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_3 and not isNil(var_132_2) then
				if arg_129_1.var_.characterEffect1042ui_story and not isNil(var_132_2) then
					arg_129_1.var_.characterEffect1042ui_story.fillFlat = true
					arg_129_1.var_.characterEffect1042ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_129_1.time_ - 0) / var_132_3)
				end
			end

			if arg_129_1.time_ >= 0 + var_132_3 and arg_129_1.time_ < 0 + var_132_3 + arg_132_0 and not isNil(var_132_2) and arg_129_1.var_.characterEffect1042ui_story then
				arg_129_1.var_.characterEffect1042ui_story.fillFlat = true
				arg_129_1.var_.characterEffect1042ui_story.fillRatio = 0.5
			end

			local var_132_4 = 0
			local var_132_5 = 0.6

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= var_132_4 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				arg_129_1.leftNameTxt_.text = arg_129_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_6 = arg_129_1:GetWordFromCfg(1109703031)
				local var_132_7 = arg_129_1:FormatText(var_132_6.content)

				arg_129_1.text_.text = var_132_7

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_9 = 24 <= 0 and var_132_5 or var_132_5 * (utf8.len(var_132_7) / 24)

				if (24 <= 0 and var_132_5 or var_132_5 * (utf8.len(var_132_7) / 24)) > 0 and var_132_5 < var_132_9 then
					arg_129_1.talkMaxDuration = var_132_9

					if var_132_9 + var_132_4 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_9 + var_132_4
					end
				end

				arg_129_1.text_.text = var_132_7
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703031", "story_v_side_new_1109703.awb") ~= 0 then
					local var_132_10 = manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703031", "story_v_side_new_1109703.awb") / 1000

					if var_132_10 + var_132_4 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_10 + var_132_4
					end

					if var_132_6.prefab_name ~= "" and arg_129_1.actors_[var_132_6.prefab_name] ~= nil then
						local var_132_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_6.prefab_name].transform, "story_v_side_new_1109703", "1109703031", "story_v_side_new_1109703.awb")

						arg_129_1:RecordAudio("1109703031", var_132_11)
						arg_129_1:RecordAudio("1109703031", var_132_11)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_side_new_1109703", "1109703031", "story_v_side_new_1109703.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_side_new_1109703", "1109703031", "story_v_side_new_1109703.awb")
				end

				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_12 = math.max(var_132_5, arg_129_1.talkMaxDuration)

			if var_132_4 <= arg_129_1.time_ and arg_129_1.time_ < var_132_4 + var_132_12 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_4) / var_132_12

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_4 + var_132_12 and arg_129_1.time_ < var_132_4 + var_132_12 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {}

		arg_129_1:InitPlayNodeList()
	end,
	Play1109703032 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 1109703032
		arg_133_1.duration_ = 11.47

		local var_133_0 = {
			zh = 7.465999999999,
			ja = 11.465999999999
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
				arg_133_0:Play1109703033(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			if 2 < arg_133_1.time_ and arg_133_1.time_ <= 2 + arg_136_0 then
				local var_136_0 = arg_133_1.bgs_.ST12

				arg_133_1.bgs_.ST12.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_136_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_136_1 = var_136_0:GetComponent("SpriteRenderer")

				if var_136_1 and var_136_1.sprite then
					local var_136_2 = 2 * (var_136_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_136_0.transform.localScale = Vector3.New(var_136_2 / var_136_1.sprite.bounds.size.y < var_136_2 * manager.ui.mainCameraCom_.aspect / var_136_1.sprite.bounds.size.x and var_136_2 * manager.ui.mainCameraCom_.aspect / var_136_1.sprite.bounds.size.x or var_136_2 / var_136_1.sprite.bounds.size.y, var_136_2 / var_136_1.sprite.bounds.size.y < var_136_2 * manager.ui.mainCameraCom_.aspect / var_136_1.sprite.bounds.size.x and var_136_2 * manager.ui.mainCameraCom_.aspect / var_136_1.sprite.bounds.size.x or var_136_2 / var_136_1.sprite.bounds.size.y, 0)
				end

				for iter_136_0, iter_136_1 in pairs(arg_133_1.bgs_) do
					if iter_136_0 ~= "ST12" then
						iter_136_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_136_3 = 0

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= var_136_3 + arg_136_0 then
				arg_133_1.mask_.enabled = true
				arg_133_1.mask_.raycastTarget = true

				arg_133_1:SetGaussion(false)
			end

			local var_136_4 = 2

			if var_136_3 <= arg_133_1.time_ and arg_133_1.time_ < var_136_3 + var_136_4 then
				local var_136_5 = Color.New(0, 0, 0)

				var_136_5.a = Mathf.Lerp(0, 1, (arg_133_1.time_ - var_136_3) / var_136_4)
				arg_133_1.mask_.color = var_136_5
			end

			if arg_133_1.time_ >= var_136_3 + var_136_4 and arg_133_1.time_ < var_136_3 + var_136_4 + arg_136_0 then
				local var_136_6 = Color.New(0, 0, 0)

				var_136_6.a = 1
				arg_133_1.mask_.color = var_136_6
			end

			local var_136_7 = 2

			if 2 < arg_133_1.time_ and arg_133_1.time_ <= var_136_7 + arg_136_0 then
				arg_133_1.mask_.enabled = true
				arg_133_1.mask_.raycastTarget = true

				arg_133_1:SetGaussion(false)
			end

			local var_136_8 = 2

			if var_136_7 <= arg_133_1.time_ and arg_133_1.time_ < var_136_7 + var_136_8 then
				local var_136_9 = Color.New(0, 0, 0)

				var_136_9.a = Mathf.Lerp(1, 0, (arg_133_1.time_ - var_136_7) / var_136_8)
				arg_133_1.mask_.color = var_136_9
			end

			if arg_133_1.time_ >= var_136_7 + var_136_8 and arg_133_1.time_ < var_136_7 + var_136_8 + arg_136_0 then
				local var_136_10 = Color.New(0, 0, 0)

				arg_133_1.mask_.enabled = false
				var_136_10.a = 0
				arg_133_1.mask_.color = var_136_10
			end

			local var_136_11 = arg_133_1.actors_["1097ui_story"].transform

			if 3.8 < arg_133_1.time_ and arg_133_1.time_ <= 3.8 + arg_136_0 then
				arg_133_1.var_.moveOldPos1097ui_story = var_136_11.localPosition
			end

			local var_136_12 = 0.001

			if 3.8 <= arg_133_1.time_ and arg_133_1.time_ < 3.8 + var_136_12 then
				var_136_11.localPosition = Vector3.Lerp(arg_133_1.var_.moveOldPos1097ui_story, Vector3.New(0, -0.54, -6.3), (arg_133_1.time_ - 3.8) / var_136_12)
				var_136_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_136_11.position).x, (manager.ui.mainCamera.transform.position - var_136_11.position).y, (manager.ui.mainCamera.transform.position - var_136_11.position).z)
				var_136_11.localEulerAngles.z = 0
				var_136_11.localEulerAngles.x = 0
				var_136_11.localEulerAngles = var_136_11.localEulerAngles
			end

			if arg_133_1.time_ >= 3.8 + var_136_12 and arg_133_1.time_ < 3.8 + var_136_12 + arg_136_0 then
				var_136_11.localPosition = Vector3.New(0, -0.54, -6.3)
				var_136_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_136_11.position).x, (manager.ui.mainCamera.transform.position - var_136_11.position).y, (manager.ui.mainCamera.transform.position - var_136_11.position).z)
				var_136_11.localEulerAngles.z = 0
				var_136_11.localEulerAngles.x = 0
				var_136_11.localEulerAngles = var_136_11.localEulerAngles
			end

			local var_136_13 = arg_133_1.actors_["1097ui_story"]

			if 3.8 < arg_133_1.time_ and arg_133_1.time_ <= 3.8 + arg_136_0 and not isNil(var_136_13) and arg_133_1.var_.characterEffect1097ui_story == nil then
				arg_133_1.var_.characterEffect1097ui_story = var_136_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_14 = 0.200000002980232

			if 3.8 <= arg_133_1.time_ and arg_133_1.time_ < 3.8 + var_136_14 and not isNil(var_136_13) then
				if arg_133_1.var_.characterEffect1097ui_story and not isNil(var_136_13) then
					arg_133_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_133_1.time_ >= 3.8 + var_136_14 and arg_133_1.time_ < 3.8 + var_136_14 + arg_136_0 and not isNil(var_136_13) and arg_133_1.var_.characterEffect1097ui_story then
				arg_133_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 3.8 < arg_133_1.time_ and arg_133_1.time_ <= 3.8 + arg_136_0 then
				arg_133_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action7_1")
			end

			if 3.8 < arg_133_1.time_ and arg_133_1.time_ <= 3.8 + arg_136_0 then
				arg_133_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_136_16 = arg_133_1.actors_["1097ui_story"].transform

			if 1.96599999815226 < arg_133_1.time_ and arg_133_1.time_ <= 1.96599999815226 + arg_136_0 then
				arg_133_1.var_.moveOldPos1097ui_story = var_136_16.localPosition
			end

			local var_136_17 = 0.001

			if 1.96599999815226 <= arg_133_1.time_ and arg_133_1.time_ < 1.96599999815226 + var_136_17 then
				var_136_16.localPosition = Vector3.Lerp(arg_133_1.var_.moveOldPos1097ui_story, Vector3.New(0, 100, 0), (arg_133_1.time_ - 1.96599999815226) / var_136_17)
				var_136_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_136_16.position).x, (manager.ui.mainCamera.transform.position - var_136_16.position).y, (manager.ui.mainCamera.transform.position - var_136_16.position).z)
				var_136_16.localEulerAngles.z = 0
				var_136_16.localEulerAngles.x = 0
				var_136_16.localEulerAngles = var_136_16.localEulerAngles
			end

			if arg_133_1.time_ >= 1.96599999815226 + var_136_17 and arg_133_1.time_ < 1.96599999815226 + var_136_17 + arg_136_0 then
				var_136_16.localPosition = Vector3.New(0, 100, 0)
				var_136_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_136_16.position).x, (manager.ui.mainCamera.transform.position - var_136_16.position).y, (manager.ui.mainCamera.transform.position - var_136_16.position).z)
				var_136_16.localEulerAngles.z = 0
				var_136_16.localEulerAngles.x = 0
				var_136_16.localEulerAngles = var_136_16.localEulerAngles
			end

			local var_136_18 = arg_133_1.actors_["1042ui_story"].transform

			if 1.96599999815226 < arg_133_1.time_ and arg_133_1.time_ <= 1.96599999815226 + arg_136_0 then
				arg_133_1.var_.moveOldPos1042ui_story = var_136_18.localPosition
			end

			local var_136_19 = 0.001

			if 1.96599999815226 <= arg_133_1.time_ and arg_133_1.time_ < 1.96599999815226 + var_136_19 then
				var_136_18.localPosition = Vector3.Lerp(arg_133_1.var_.moveOldPos1042ui_story, Vector3.New(0, 100, 0), (arg_133_1.time_ - 1.96599999815226) / var_136_19)
				var_136_18.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_136_18.position).x, (manager.ui.mainCamera.transform.position - var_136_18.position).y, (manager.ui.mainCamera.transform.position - var_136_18.position).z)
				var_136_18.localEulerAngles.z = 0
				var_136_18.localEulerAngles.x = 0
				var_136_18.localEulerAngles = var_136_18.localEulerAngles
			end

			if arg_133_1.time_ >= 1.96599999815226 + var_136_19 and arg_133_1.time_ < 1.96599999815226 + var_136_19 + arg_136_0 then
				var_136_18.localPosition = Vector3.New(0, 100, 0)
				var_136_18.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_136_18.position).x, (manager.ui.mainCamera.transform.position - var_136_18.position).y, (manager.ui.mainCamera.transform.position - var_136_18.position).z)
				var_136_18.localEulerAngles.z = 0
				var_136_18.localEulerAngles.x = 0
				var_136_18.localEulerAngles = var_136_18.localEulerAngles
			end

			if arg_133_1.frameCnt_ <= 1 then
				arg_133_1.dialog_:SetActive(false)
			end

			local var_136_20 = 3.999999999999
			local var_136_21 = 0.275

			if 3.999999999999 < arg_133_1.time_ and arg_133_1.time_ <= var_136_20 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0

				arg_133_1.dialog_:SetActive(true)

				arg_133_1.dialogCg_.alpha = 0

				local var_136_22 = LeanTween.value(arg_133_1.dialog_, 0, 1, 0.3)

				var_136_22:setOnUpdate(LuaHelper.FloatAction(function(arg_137_0)
					arg_133_1.dialogCg_.alpha = arg_137_0
				end))
				var_136_22:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_133_1.dialog_)
					var_136_22:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_133_1.duration_ = arg_133_1.duration_ + 0.3

				SetActive(arg_133_1.leftNameGo_, true)

				arg_133_1.leftNameTxt_.text = arg_133_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_23 = arg_133_1:GetWordFromCfg(1109703032)
				local var_136_24 = arg_133_1:FormatText(var_136_23.content)

				arg_133_1.text_.text = var_136_24

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_26 = 11 <= 0 and var_136_21 or var_136_21 * (utf8.len(var_136_24) / 11)

				if (11 <= 0 and var_136_21 or var_136_21 * (utf8.len(var_136_24) / 11)) > 0 and var_136_21 < var_136_26 then
					arg_133_1.talkMaxDuration = var_136_26
					var_136_20 = var_136_20 + 0.3

					if var_136_26 + var_136_20 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_26 + var_136_20
					end
				end

				arg_133_1.text_.text = var_136_24
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703032", "story_v_side_new_1109703.awb") ~= 0 then
					local var_136_27 = manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703032", "story_v_side_new_1109703.awb") / 1000

					if var_136_27 + var_136_20 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_27 + var_136_20
					end

					if var_136_23.prefab_name ~= "" and arg_133_1.actors_[var_136_23.prefab_name] ~= nil then
						local var_136_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_23.prefab_name].transform, "story_v_side_new_1109703", "1109703032", "story_v_side_new_1109703.awb")

						arg_133_1:RecordAudio("1109703032", var_136_28)
						arg_133_1:RecordAudio("1109703032", var_136_28)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_side_new_1109703", "1109703032", "story_v_side_new_1109703.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_side_new_1109703", "1109703032", "story_v_side_new_1109703.awb")
				end

				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_29 = var_136_20 + 0.3
			local var_136_30 = math.max(var_136_21, arg_133_1.talkMaxDuration)

			if var_136_20 + 0.3 <= arg_133_1.time_ and arg_133_1.time_ < var_136_29 + var_136_30 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_29) / var_136_30

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_29 + var_136_30 and arg_133_1.time_ < var_136_29 + var_136_30 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1042ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_133_1:InitPlayNodeList()
	end,
	Play1109703033 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 1109703033
		arg_139_1.duration_ = 5

		SetActive(arg_139_1.tipsGo_, false)

		function arg_139_1.onSingleLineFinish_()
			arg_139_1.onSingleLineUpdate_ = nil
			arg_139_1.onSingleLineFinish_ = nil
			arg_139_1.state_ = "waiting"
		end

		function arg_139_1.playNext_(arg_141_0)
			if arg_141_0 == 1 then
				arg_139_0:Play1109703034(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 and not isNil(arg_139_1.actors_["1097ui_story"]) and arg_139_1.var_.characterEffect1097ui_story == nil then
				arg_139_1.var_.characterEffect1097ui_story = arg_139_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_142_0 = 0.200000002980232

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_0 and not isNil(arg_139_1.actors_["1097ui_story"]) then
				if arg_139_1.var_.characterEffect1097ui_story and not isNil(arg_139_1.actors_["1097ui_story"]) then
					arg_139_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_139_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_139_1.time_ - 0) / var_142_0)
				end
			end

			if arg_139_1.time_ >= 0 + var_142_0 and arg_139_1.time_ < 0 + var_142_0 + arg_142_0 and not isNil(arg_139_1.actors_["1097ui_story"]) and arg_139_1.var_.characterEffect1097ui_story then
				arg_139_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_139_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_142_1 = 0
			local var_142_2 = 0.7

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= var_142_1 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				arg_139_1.leftNameTxt_.text = arg_139_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, true)
				arg_139_1.iconController_:SetSelectedState("hero")

				arg_139_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_139_1.callingController_:SetSelectedState("normal")

				arg_139_1.keyicon_.color = Color.New(1, 1, 1)
				arg_139_1.icon_.color = Color.New(1, 1, 1)

				local var_142_3 = arg_139_1:FormatText(arg_139_1:GetWordFromCfg(1109703033).content)

				arg_139_1.text_.text = var_142_3

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_5 = 28 <= 0 and var_142_2 or var_142_2 * (utf8.len(var_142_3) / 28)

				if (28 <= 0 and var_142_2 or var_142_2 * (utf8.len(var_142_3) / 28)) > 0 and var_142_2 < var_142_5 then
					arg_139_1.talkMaxDuration = var_142_5

					if var_142_5 + var_142_1 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_5 + var_142_1
					end
				end

				arg_139_1.text_.text = var_142_3
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)
				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_6 = math.max(var_142_2, arg_139_1.talkMaxDuration)

			if var_142_1 <= arg_139_1.time_ and arg_139_1.time_ < var_142_1 + var_142_6 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_1) / var_142_6

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_1 + var_142_6 and arg_139_1.time_ < var_142_1 + var_142_6 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {}

		arg_139_1:InitPlayNodeList()
	end,
	Play1109703034 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 1109703034
		arg_143_1.duration_ = 5

		SetActive(arg_143_1.tipsGo_, false)

		function arg_143_1.onSingleLineFinish_()
			arg_143_1.onSingleLineUpdate_ = nil
			arg_143_1.onSingleLineFinish_ = nil
			arg_143_1.state_ = "waiting"
		end

		function arg_143_1.playNext_(arg_145_0)
			if arg_145_0 == 1 then
				arg_143_0:Play1109703035(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			local var_146_0 = 0.65

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

				local var_146_1 = arg_143_1:FormatText(arg_143_1:GetWordFromCfg(1109703034).content)

				arg_143_1.text_.text = var_146_1

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_3 = 26 <= 0 and var_146_0 or var_146_0 * (utf8.len(var_146_1) / 26)

				if (26 <= 0 and var_146_0 or var_146_0 * (utf8.len(var_146_1) / 26)) > 0 and var_146_0 < var_146_3 then
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
	Play1109703035 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 1109703035
		arg_147_1.duration_ = 6.2

		local var_147_0 = {
			zh = 4.066,
			ja = 6.2
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
				arg_147_0:Play1109703036(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 and not isNil(arg_147_1.actors_["1097ui_story"]) and arg_147_1.var_.characterEffect1097ui_story == nil then
				arg_147_1.var_.characterEffect1097ui_story = arg_147_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_150_0 = 0.200000002980232

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_0 and not isNil(arg_147_1.actors_["1097ui_story"]) then
				if arg_147_1.var_.characterEffect1097ui_story and not isNil(arg_147_1.actors_["1097ui_story"]) then
					arg_147_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_147_1.time_ >= 0 + var_150_0 and arg_147_1.time_ < 0 + var_150_0 + arg_150_0 and not isNil(arg_147_1.actors_["1097ui_story"]) and arg_147_1.var_.characterEffect1097ui_story then
				arg_147_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 then
				arg_147_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action7_2")
			end

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 then
				arg_147_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_150_2 = 0
			local var_150_3 = 0.4

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= var_150_2 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, true)

				arg_147_1.leftNameTxt_.text = arg_147_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_4 = arg_147_1:GetWordFromCfg(1109703035)
				local var_150_5 = arg_147_1:FormatText(var_150_4.content)

				arg_147_1.text_.text = var_150_5

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_7 = 16 <= 0 and var_150_3 or var_150_3 * (utf8.len(var_150_5) / 16)

				if (16 <= 0 and var_150_3 or var_150_3 * (utf8.len(var_150_5) / 16)) > 0 and var_150_3 < var_150_7 then
					arg_147_1.talkMaxDuration = var_150_7

					if var_150_7 + var_150_2 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_7 + var_150_2
					end
				end

				arg_147_1.text_.text = var_150_5
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703035", "story_v_side_new_1109703.awb") ~= 0 then
					local var_150_8 = manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703035", "story_v_side_new_1109703.awb") / 1000

					if var_150_8 + var_150_2 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_8 + var_150_2
					end

					if var_150_4.prefab_name ~= "" and arg_147_1.actors_[var_150_4.prefab_name] ~= nil then
						local var_150_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_147_1.actors_[var_150_4.prefab_name].transform, "story_v_side_new_1109703", "1109703035", "story_v_side_new_1109703.awb")

						arg_147_1:RecordAudio("1109703035", var_150_9)
						arg_147_1:RecordAudio("1109703035", var_150_9)
					else
						arg_147_1:AudioAction("play", "voice", "story_v_side_new_1109703", "1109703035", "story_v_side_new_1109703.awb")
					end

					arg_147_1:RecordHistoryTalkVoice("story_v_side_new_1109703", "1109703035", "story_v_side_new_1109703.awb")
				end

				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_10 = math.max(var_150_3, arg_147_1.talkMaxDuration)

			if var_150_2 <= arg_147_1.time_ and arg_147_1.time_ < var_150_2 + var_150_10 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_2) / var_150_10

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_2 + var_150_10 and arg_147_1.time_ < var_150_2 + var_150_10 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {}

		arg_147_1:InitPlayNodeList()
	end,
	Play1109703036 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 1109703036
		arg_151_1.duration_ = 5

		SetActive(arg_151_1.tipsGo_, false)

		function arg_151_1.onSingleLineFinish_()
			arg_151_1.onSingleLineUpdate_ = nil
			arg_151_1.onSingleLineFinish_ = nil
			arg_151_1.state_ = "waiting"
		end

		function arg_151_1.playNext_(arg_153_0)
			if arg_153_0 == 1 then
				arg_151_0:Play1109703037(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 and not isNil(arg_151_1.actors_["1097ui_story"]) and arg_151_1.var_.characterEffect1097ui_story == nil then
				arg_151_1.var_.characterEffect1097ui_story = arg_151_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_154_0 = 0.200000002980232

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_0 and not isNil(arg_151_1.actors_["1097ui_story"]) then
				if arg_151_1.var_.characterEffect1097ui_story and not isNil(arg_151_1.actors_["1097ui_story"]) then
					arg_151_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_151_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_151_1.time_ - 0) / var_154_0)
				end
			end

			if arg_151_1.time_ >= 0 + var_154_0 and arg_151_1.time_ < 0 + var_154_0 + arg_154_0 and not isNil(arg_151_1.actors_["1097ui_story"]) and arg_151_1.var_.characterEffect1097ui_story then
				arg_151_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_151_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_154_1 = 0
			local var_154_2 = 0.45

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= var_154_1 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				arg_151_1.leftNameTxt_.text = arg_151_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, true)
				arg_151_1.iconController_:SetSelectedState("hero")

				arg_151_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_151_1.callingController_:SetSelectedState("normal")

				arg_151_1.keyicon_.color = Color.New(1, 1, 1)
				arg_151_1.icon_.color = Color.New(1, 1, 1)

				local var_154_3 = arg_151_1:FormatText(arg_151_1:GetWordFromCfg(1109703036).content)

				arg_151_1.text_.text = var_154_3

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_5 = 18 <= 0 and var_154_2 or var_154_2 * (utf8.len(var_154_3) / 18)

				if (18 <= 0 and var_154_2 or var_154_2 * (utf8.len(var_154_3) / 18)) > 0 and var_154_2 < var_154_5 then
					arg_151_1.talkMaxDuration = var_154_5

					if var_154_5 + var_154_1 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_5 + var_154_1
					end
				end

				arg_151_1.text_.text = var_154_3
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)
				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_6 = math.max(var_154_2, arg_151_1.talkMaxDuration)

			if var_154_1 <= arg_151_1.time_ and arg_151_1.time_ < var_154_1 + var_154_6 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - var_154_1) / var_154_6

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= var_154_1 + var_154_6 and arg_151_1.time_ < var_154_1 + var_154_6 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {}

		arg_151_1:InitPlayNodeList()
	end,
	Play1109703037 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 1109703037
		arg_155_1.duration_ = 6.9

		local var_155_0 = {
			zh = 4.466,
			ja = 6.9
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
				arg_155_0:Play1109703038(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 and not isNil(arg_155_1.actors_["1097ui_story"]) and arg_155_1.var_.characterEffect1097ui_story == nil then
				arg_155_1.var_.characterEffect1097ui_story = arg_155_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_158_0 = 0.200000002980232

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_0 and not isNil(arg_155_1.actors_["1097ui_story"]) then
				if arg_155_1.var_.characterEffect1097ui_story and not isNil(arg_155_1.actors_["1097ui_story"]) then
					arg_155_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_155_1.time_ >= 0 + var_158_0 and arg_155_1.time_ < 0 + var_158_0 + arg_158_0 and not isNil(arg_155_1.actors_["1097ui_story"]) and arg_155_1.var_.characterEffect1097ui_story then
				arg_155_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 then
				arg_155_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 then
				arg_155_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva")
			end

			local var_158_2 = 0
			local var_158_3 = 0.5

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= var_158_2 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, true)

				arg_155_1.leftNameTxt_.text = arg_155_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_4 = arg_155_1:GetWordFromCfg(1109703037)
				local var_158_5 = arg_155_1:FormatText(var_158_4.content)

				arg_155_1.text_.text = var_158_5

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_7 = 20 <= 0 and var_158_3 or var_158_3 * (utf8.len(var_158_5) / 20)

				if (20 <= 0 and var_158_3 or var_158_3 * (utf8.len(var_158_5) / 20)) > 0 and var_158_3 < var_158_7 then
					arg_155_1.talkMaxDuration = var_158_7

					if var_158_7 + var_158_2 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_7 + var_158_2
					end
				end

				arg_155_1.text_.text = var_158_5
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703037", "story_v_side_new_1109703.awb") ~= 0 then
					local var_158_8 = manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703037", "story_v_side_new_1109703.awb") / 1000

					if var_158_8 + var_158_2 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_8 + var_158_2
					end

					if var_158_4.prefab_name ~= "" and arg_155_1.actors_[var_158_4.prefab_name] ~= nil then
						local var_158_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_155_1.actors_[var_158_4.prefab_name].transform, "story_v_side_new_1109703", "1109703037", "story_v_side_new_1109703.awb")

						arg_155_1:RecordAudio("1109703037", var_158_9)
						arg_155_1:RecordAudio("1109703037", var_158_9)
					else
						arg_155_1:AudioAction("play", "voice", "story_v_side_new_1109703", "1109703037", "story_v_side_new_1109703.awb")
					end

					arg_155_1:RecordHistoryTalkVoice("story_v_side_new_1109703", "1109703037", "story_v_side_new_1109703.awb")
				end

				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_10 = math.max(var_158_3, arg_155_1.talkMaxDuration)

			if var_158_2 <= arg_155_1.time_ and arg_155_1.time_ < var_158_2 + var_158_10 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - var_158_2) / var_158_10

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= var_158_2 + var_158_10 and arg_155_1.time_ < var_158_2 + var_158_10 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {}

		arg_155_1:InitPlayNodeList()
	end,
	Play1109703038 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 1109703038
		arg_159_1.duration_ = 5

		SetActive(arg_159_1.tipsGo_, false)

		function arg_159_1.onSingleLineFinish_()
			arg_159_1.onSingleLineUpdate_ = nil
			arg_159_1.onSingleLineFinish_ = nil
			arg_159_1.state_ = "waiting"
		end

		function arg_159_1.playNext_(arg_161_0)
			if arg_161_0 == 1 then
				arg_159_0:Play1109703039(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 and not isNil(arg_159_1.actors_["1097ui_story"]) and arg_159_1.var_.characterEffect1097ui_story == nil then
				arg_159_1.var_.characterEffect1097ui_story = arg_159_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_162_0 = 0.200000002980232

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_0 and not isNil(arg_159_1.actors_["1097ui_story"]) then
				if arg_159_1.var_.characterEffect1097ui_story and not isNil(arg_159_1.actors_["1097ui_story"]) then
					arg_159_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_159_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_159_1.time_ - 0) / var_162_0)
				end
			end

			if arg_159_1.time_ >= 0 + var_162_0 and arg_159_1.time_ < 0 + var_162_0 + arg_162_0 and not isNil(arg_159_1.actors_["1097ui_story"]) and arg_159_1.var_.characterEffect1097ui_story then
				arg_159_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_159_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_162_1 = 0
			local var_162_2 = 0.475

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= var_162_1 + arg_162_0 then
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

				arg_159_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_159_1.callingController_:SetSelectedState("normal")

				arg_159_1.keyicon_.color = Color.New(1, 1, 1)
				arg_159_1.icon_.color = Color.New(1, 1, 1)

				local var_162_3 = arg_159_1:FormatText(arg_159_1:GetWordFromCfg(1109703038).content)

				arg_159_1.text_.text = var_162_3

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_5 = 19 <= 0 and var_162_2 or var_162_2 * (utf8.len(var_162_3) / 19)

				if (19 <= 0 and var_162_2 or var_162_2 * (utf8.len(var_162_3) / 19)) > 0 and var_162_2 < var_162_5 then
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
	Play1109703039 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 1109703039
		arg_163_1.duration_ = 6.47

		local var_163_0 = {
			zh = 3.033,
			ja = 6.466
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
				arg_163_0:Play1109703040(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 and not isNil(arg_163_1.actors_["1097ui_story"]) and arg_163_1.var_.characterEffect1097ui_story == nil then
				arg_163_1.var_.characterEffect1097ui_story = arg_163_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_166_0 = 0.200000002980232

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_0 and not isNil(arg_163_1.actors_["1097ui_story"]) then
				if arg_163_1.var_.characterEffect1097ui_story and not isNil(arg_163_1.actors_["1097ui_story"]) then
					arg_163_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_163_1.time_ >= 0 + var_166_0 and arg_163_1.time_ < 0 + var_166_0 + arg_166_0 and not isNil(arg_163_1.actors_["1097ui_story"]) and arg_163_1.var_.characterEffect1097ui_story then
				arg_163_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 then
				arg_163_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 then
				arg_163_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_166_2 = 0
			local var_166_3 = 0.55

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= var_166_2 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, true)

				arg_163_1.leftNameTxt_.text = arg_163_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_163_1.leftNameTxt_.transform)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1.leftNameTxt_.text)
				SetActive(arg_163_1.iconTrs_.gameObject, false)
				arg_163_1.callingController_:SetSelectedState("normal")

				local var_166_4 = arg_163_1:GetWordFromCfg(1109703039)
				local var_166_5 = arg_163_1:FormatText(var_166_4.content)

				arg_163_1.text_.text = var_166_5

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_7 = 22 <= 0 and var_166_3 or var_166_3 * (utf8.len(var_166_5) / 22)

				if (22 <= 0 and var_166_3 or var_166_3 * (utf8.len(var_166_5) / 22)) > 0 and var_166_3 < var_166_7 then
					arg_163_1.talkMaxDuration = var_166_7

					if var_166_7 + var_166_2 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_7 + var_166_2
					end
				end

				arg_163_1.text_.text = var_166_5
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703039", "story_v_side_new_1109703.awb") ~= 0 then
					local var_166_8 = manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703039", "story_v_side_new_1109703.awb") / 1000

					if var_166_8 + var_166_2 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_8 + var_166_2
					end

					if var_166_4.prefab_name ~= "" and arg_163_1.actors_[var_166_4.prefab_name] ~= nil then
						local var_166_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_163_1.actors_[var_166_4.prefab_name].transform, "story_v_side_new_1109703", "1109703039", "story_v_side_new_1109703.awb")

						arg_163_1:RecordAudio("1109703039", var_166_9)
						arg_163_1:RecordAudio("1109703039", var_166_9)
					else
						arg_163_1:AudioAction("play", "voice", "story_v_side_new_1109703", "1109703039", "story_v_side_new_1109703.awb")
					end

					arg_163_1:RecordHistoryTalkVoice("story_v_side_new_1109703", "1109703039", "story_v_side_new_1109703.awb")
				end

				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_10 = math.max(var_166_3, arg_163_1.talkMaxDuration)

			if var_166_2 <= arg_163_1.time_ and arg_163_1.time_ < var_166_2 + var_166_10 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - var_166_2) / var_166_10

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= var_166_2 + var_166_10 and arg_163_1.time_ < var_166_2 + var_166_10 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {}

		arg_163_1:InitPlayNodeList()
	end,
	Play1109703040 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 1109703040
		arg_167_1.duration_ = 5

		SetActive(arg_167_1.tipsGo_, false)

		function arg_167_1.onSingleLineFinish_()
			arg_167_1.onSingleLineUpdate_ = nil
			arg_167_1.onSingleLineFinish_ = nil
			arg_167_1.state_ = "waiting"
		end

		function arg_167_1.playNext_(arg_169_0)
			if arg_169_0 == 1 then
				arg_167_0:Play1109703041(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 and not isNil(arg_167_1.actors_["1097ui_story"]) and arg_167_1.var_.characterEffect1097ui_story == nil then
				arg_167_1.var_.characterEffect1097ui_story = arg_167_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_170_0 = 0.200000002980232

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_0 and not isNil(arg_167_1.actors_["1097ui_story"]) then
				if arg_167_1.var_.characterEffect1097ui_story and not isNil(arg_167_1.actors_["1097ui_story"]) then
					arg_167_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_167_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_167_1.time_ - 0) / var_170_0)
				end
			end

			if arg_167_1.time_ >= 0 + var_170_0 and arg_167_1.time_ < 0 + var_170_0 + arg_170_0 and not isNil(arg_167_1.actors_["1097ui_story"]) and arg_167_1.var_.characterEffect1097ui_story then
				arg_167_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_167_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_170_1 = 0
			local var_170_2 = 0.5

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

				arg_167_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_167_1.callingController_:SetSelectedState("normal")

				arg_167_1.keyicon_.color = Color.New(1, 1, 1)
				arg_167_1.icon_.color = Color.New(1, 1, 1)

				local var_170_3 = arg_167_1:FormatText(arg_167_1:GetWordFromCfg(1109703040).content)

				arg_167_1.text_.text = var_170_3

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_5 = 20 <= 0 and var_170_2 or var_170_2 * (utf8.len(var_170_3) / 20)

				if (20 <= 0 and var_170_2 or var_170_2 * (utf8.len(var_170_3) / 20)) > 0 and var_170_2 < var_170_5 then
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
	Play1109703041 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 1109703041
		arg_171_1.duration_ = 6.13

		local var_171_0 = {
			zh = 4,
			ja = 6.133
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
				arg_171_0:Play1109703042(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 and not isNil(arg_171_1.actors_["1097ui_story"]) and arg_171_1.var_.characterEffect1097ui_story == nil then
				arg_171_1.var_.characterEffect1097ui_story = arg_171_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_174_0 = 0.200000002980232

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_0 and not isNil(arg_171_1.actors_["1097ui_story"]) then
				if arg_171_1.var_.characterEffect1097ui_story and not isNil(arg_171_1.actors_["1097ui_story"]) then
					arg_171_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_171_1.time_ >= 0 + var_174_0 and arg_171_1.time_ < 0 + var_174_0 + arg_174_0 and not isNil(arg_171_1.actors_["1097ui_story"]) and arg_171_1.var_.characterEffect1097ui_story then
				arg_171_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 then
				arg_171_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action3_1")
			end

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 then
				arg_171_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_174_2 = 0
			local var_174_3 = 0.625

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= var_174_2 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, true)

				arg_171_1.leftNameTxt_.text = arg_171_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_171_1.leftNameTxt_.transform)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1.leftNameTxt_.text)
				SetActive(arg_171_1.iconTrs_.gameObject, false)
				arg_171_1.callingController_:SetSelectedState("normal")

				local var_174_4 = arg_171_1:GetWordFromCfg(1109703041)
				local var_174_5 = arg_171_1:FormatText(var_174_4.content)

				arg_171_1.text_.text = var_174_5

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_7 = 25 <= 0 and var_174_3 or var_174_3 * (utf8.len(var_174_5) / 25)

				if (25 <= 0 and var_174_3 or var_174_3 * (utf8.len(var_174_5) / 25)) > 0 and var_174_3 < var_174_7 then
					arg_171_1.talkMaxDuration = var_174_7

					if var_174_7 + var_174_2 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_7 + var_174_2
					end
				end

				arg_171_1.text_.text = var_174_5
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703041", "story_v_side_new_1109703.awb") ~= 0 then
					local var_174_8 = manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703041", "story_v_side_new_1109703.awb") / 1000

					if var_174_8 + var_174_2 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_8 + var_174_2
					end

					if var_174_4.prefab_name ~= "" and arg_171_1.actors_[var_174_4.prefab_name] ~= nil then
						local var_174_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_171_1.actors_[var_174_4.prefab_name].transform, "story_v_side_new_1109703", "1109703041", "story_v_side_new_1109703.awb")

						arg_171_1:RecordAudio("1109703041", var_174_9)
						arg_171_1:RecordAudio("1109703041", var_174_9)
					else
						arg_171_1:AudioAction("play", "voice", "story_v_side_new_1109703", "1109703041", "story_v_side_new_1109703.awb")
					end

					arg_171_1:RecordHistoryTalkVoice("story_v_side_new_1109703", "1109703041", "story_v_side_new_1109703.awb")
				end

				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_10 = math.max(var_174_3, arg_171_1.talkMaxDuration)

			if var_174_2 <= arg_171_1.time_ and arg_171_1.time_ < var_174_2 + var_174_10 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - var_174_2) / var_174_10

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= var_174_2 + var_174_10 and arg_171_1.time_ < var_174_2 + var_174_10 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {}

		arg_171_1:InitPlayNodeList()
	end,
	Play1109703042 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 1109703042
		arg_175_1.duration_ = 5

		SetActive(arg_175_1.tipsGo_, false)

		function arg_175_1.onSingleLineFinish_()
			arg_175_1.onSingleLineUpdate_ = nil
			arg_175_1.onSingleLineFinish_ = nil
			arg_175_1.state_ = "waiting"
		end

		function arg_175_1.playNext_(arg_177_0)
			if arg_177_0 == 1 then
				arg_175_0:Play1109703043(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 and not isNil(arg_175_1.actors_["1097ui_story"]) and arg_175_1.var_.characterEffect1097ui_story == nil then
				arg_175_1.var_.characterEffect1097ui_story = arg_175_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_178_0 = 0.200000002980232

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_0 and not isNil(arg_175_1.actors_["1097ui_story"]) then
				if arg_175_1.var_.characterEffect1097ui_story and not isNil(arg_175_1.actors_["1097ui_story"]) then
					arg_175_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_175_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_175_1.time_ - 0) / var_178_0)
				end
			end

			if arg_175_1.time_ >= 0 + var_178_0 and arg_175_1.time_ < 0 + var_178_0 + arg_178_0 and not isNil(arg_175_1.actors_["1097ui_story"]) and arg_175_1.var_.characterEffect1097ui_story then
				arg_175_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_175_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_178_1 = 0
			local var_178_2 = 0.45

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= var_178_1 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, true)

				arg_175_1.leftNameTxt_.text = arg_175_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_175_1.leftNameTxt_.transform)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1.leftNameTxt_.text)
				SetActive(arg_175_1.iconTrs_.gameObject, true)
				arg_175_1.iconController_:SetSelectedState("hero")

				arg_175_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_175_1.callingController_:SetSelectedState("normal")

				arg_175_1.keyicon_.color = Color.New(1, 1, 1)
				arg_175_1.icon_.color = Color.New(1, 1, 1)

				local var_178_3 = arg_175_1:FormatText(arg_175_1:GetWordFromCfg(1109703042).content)

				arg_175_1.text_.text = var_178_3

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_5 = 18 <= 0 and var_178_2 or var_178_2 * (utf8.len(var_178_3) / 18)

				if (18 <= 0 and var_178_2 or var_178_2 * (utf8.len(var_178_3) / 18)) > 0 and var_178_2 < var_178_5 then
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
	Play1109703043 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 1109703043
		arg_179_1.duration_ = 4.6

		local var_179_0 = {
			zh = 2.3,
			ja = 4.6
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
				arg_179_0:Play1109703044(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 and not isNil(arg_179_1.actors_["1097ui_story"]) and arg_179_1.var_.characterEffect1097ui_story == nil then
				arg_179_1.var_.characterEffect1097ui_story = arg_179_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_182_0 = 0.200000002980232

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_0 and not isNil(arg_179_1.actors_["1097ui_story"]) then
				if arg_179_1.var_.characterEffect1097ui_story and not isNil(arg_179_1.actors_["1097ui_story"]) then
					arg_179_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_179_1.time_ >= 0 + var_182_0 and arg_179_1.time_ < 0 + var_182_0 + arg_182_0 and not isNil(arg_179_1.actors_["1097ui_story"]) and arg_179_1.var_.characterEffect1097ui_story then
				arg_179_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 then
				arg_179_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action3_2")
			end

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 then
				arg_179_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_182_2 = 0
			local var_182_3 = 0.2

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= var_182_2 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, true)

				arg_179_1.leftNameTxt_.text = arg_179_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_179_1.leftNameTxt_.transform)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1.leftNameTxt_.text)
				SetActive(arg_179_1.iconTrs_.gameObject, false)
				arg_179_1.callingController_:SetSelectedState("normal")

				local var_182_4 = arg_179_1:GetWordFromCfg(1109703043)
				local var_182_5 = arg_179_1:FormatText(var_182_4.content)

				arg_179_1.text_.text = var_182_5

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_7 = 8 <= 0 and var_182_3 or var_182_3 * (utf8.len(var_182_5) / 8)

				if (8 <= 0 and var_182_3 or var_182_3 * (utf8.len(var_182_5) / 8)) > 0 and var_182_3 < var_182_7 then
					arg_179_1.talkMaxDuration = var_182_7

					if var_182_7 + var_182_2 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_7 + var_182_2
					end
				end

				arg_179_1.text_.text = var_182_5
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703043", "story_v_side_new_1109703.awb") ~= 0 then
					local var_182_8 = manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703043", "story_v_side_new_1109703.awb") / 1000

					if var_182_8 + var_182_2 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_8 + var_182_2
					end

					if var_182_4.prefab_name ~= "" and arg_179_1.actors_[var_182_4.prefab_name] ~= nil then
						local var_182_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_179_1.actors_[var_182_4.prefab_name].transform, "story_v_side_new_1109703", "1109703043", "story_v_side_new_1109703.awb")

						arg_179_1:RecordAudio("1109703043", var_182_9)
						arg_179_1:RecordAudio("1109703043", var_182_9)
					else
						arg_179_1:AudioAction("play", "voice", "story_v_side_new_1109703", "1109703043", "story_v_side_new_1109703.awb")
					end

					arg_179_1:RecordHistoryTalkVoice("story_v_side_new_1109703", "1109703043", "story_v_side_new_1109703.awb")
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
	Play1109703044 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 1109703044
		arg_183_1.duration_ = 5

		SetActive(arg_183_1.tipsGo_, false)

		function arg_183_1.onSingleLineFinish_()
			arg_183_1.onSingleLineUpdate_ = nil
			arg_183_1.onSingleLineFinish_ = nil
			arg_183_1.state_ = "waiting"
		end

		function arg_183_1.playNext_(arg_185_0)
			if arg_185_0 == 1 then
				arg_183_0:Play1109703045(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 and not isNil(arg_183_1.actors_["1097ui_story"]) and arg_183_1.var_.characterEffect1097ui_story == nil then
				arg_183_1.var_.characterEffect1097ui_story = arg_183_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_186_0 = 0.200000002980232

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_0 and not isNil(arg_183_1.actors_["1097ui_story"]) then
				if arg_183_1.var_.characterEffect1097ui_story and not isNil(arg_183_1.actors_["1097ui_story"]) then
					arg_183_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_183_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_183_1.time_ - 0) / var_186_0)
				end
			end

			if arg_183_1.time_ >= 0 + var_186_0 and arg_183_1.time_ < 0 + var_186_0 + arg_186_0 and not isNil(arg_183_1.actors_["1097ui_story"]) and arg_183_1.var_.characterEffect1097ui_story then
				arg_183_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_183_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_186_1 = 0
			local var_186_2 = 0.775

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

				arg_183_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_183_1.callingController_:SetSelectedState("normal")

				arg_183_1.keyicon_.color = Color.New(1, 1, 1)
				arg_183_1.icon_.color = Color.New(1, 1, 1)

				local var_186_3 = arg_183_1:FormatText(arg_183_1:GetWordFromCfg(1109703044).content)

				arg_183_1.text_.text = var_186_3

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_5 = 31 <= 0 and var_186_2 or var_186_2 * (utf8.len(var_186_3) / 31)

				if (31 <= 0 and var_186_2 or var_186_2 * (utf8.len(var_186_3) / 31)) > 0 and var_186_2 < var_186_5 then
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
	Play1109703045 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 1109703045
		arg_187_1.duration_ = 8.97

		SetActive(arg_187_1.tipsGo_, false)

		function arg_187_1.onSingleLineFinish_()
			arg_187_1.onSingleLineUpdate_ = nil
			arg_187_1.onSingleLineFinish_ = nil
			arg_187_1.state_ = "waiting"
		end

		function arg_187_1.playNext_(arg_189_0)
			if arg_189_0 == 1 then
				arg_187_0:Play1109703046(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			if 1.96599999815226 < arg_187_1.time_ and arg_187_1.time_ <= 1.96599999815226 + arg_190_0 then
				local var_190_0 = arg_187_1.bgs_.ST12

				arg_187_1.bgs_.ST12.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_190_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_190_1 = var_190_0:GetComponent("SpriteRenderer")

				if var_190_1 and var_190_1.sprite then
					local var_190_2 = 2 * (var_190_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_190_0.transform.localScale = Vector3.New(var_190_2 / var_190_1.sprite.bounds.size.y < var_190_2 * manager.ui.mainCameraCom_.aspect / var_190_1.sprite.bounds.size.x and var_190_2 * manager.ui.mainCameraCom_.aspect / var_190_1.sprite.bounds.size.x or var_190_2 / var_190_1.sprite.bounds.size.y, var_190_2 / var_190_1.sprite.bounds.size.y < var_190_2 * manager.ui.mainCameraCom_.aspect / var_190_1.sprite.bounds.size.x and var_190_2 * manager.ui.mainCameraCom_.aspect / var_190_1.sprite.bounds.size.x or var_190_2 / var_190_1.sprite.bounds.size.y, 0)
				end

				for iter_190_0, iter_190_1 in pairs(arg_187_1.bgs_) do
					if iter_190_0 ~= "ST12" then
						iter_190_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_190_3 = 3.999999999999

			if 3.999999999999 < arg_187_1.time_ and arg_187_1.time_ <= var_190_3 + arg_190_0 then
				arg_187_1.allBtn_.enabled = false
			end

			if arg_187_1.time_ >= var_190_3 + 0.3 and arg_187_1.time_ < var_190_3 + 0.3 + arg_190_0 then
				arg_187_1.allBtn_.enabled = true
			end

			local var_190_4 = 0

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= var_190_4 + arg_190_0 then
				arg_187_1.mask_.enabled = true
				arg_187_1.mask_.raycastTarget = true

				arg_187_1:SetGaussion(false)
			end

			local var_190_5 = 2

			if var_190_4 <= arg_187_1.time_ and arg_187_1.time_ < var_190_4 + var_190_5 then
				local var_190_6 = Color.New(1, 1, 1)

				var_190_6.a = Mathf.Lerp(0, 1, (arg_187_1.time_ - var_190_4) / var_190_5)
				arg_187_1.mask_.color = var_190_6
			end

			if arg_187_1.time_ >= var_190_4 + var_190_5 and arg_187_1.time_ < var_190_4 + var_190_5 + arg_190_0 then
				local var_190_7 = Color.New(1, 1, 1)

				var_190_7.a = 1
				arg_187_1.mask_.color = var_190_7
			end

			local var_190_8 = 2

			if 2 < arg_187_1.time_ and arg_187_1.time_ <= var_190_8 + arg_190_0 then
				arg_187_1.mask_.enabled = true
				arg_187_1.mask_.raycastTarget = true

				arg_187_1:SetGaussion(false)
			end

			local var_190_9 = 2

			if var_190_8 <= arg_187_1.time_ and arg_187_1.time_ < var_190_8 + var_190_9 then
				local var_190_10 = Color.New(1, 1, 1)

				var_190_10.a = Mathf.Lerp(1, 0, (arg_187_1.time_ - var_190_8) / var_190_9)
				arg_187_1.mask_.color = var_190_10
			end

			if arg_187_1.time_ >= var_190_8 + var_190_9 and arg_187_1.time_ < var_190_8 + var_190_9 + arg_190_0 then
				local var_190_11 = Color.New(1, 1, 1)

				arg_187_1.mask_.enabled = false
				var_190_11.a = 0
				arg_187_1.mask_.color = var_190_11
			end

			local var_190_12 = arg_187_1.actors_["1097ui_story"].transform

			if 1.96599999815226 < arg_187_1.time_ and arg_187_1.time_ <= 1.96599999815226 + arg_190_0 then
				arg_187_1.var_.moveOldPos1097ui_story = var_190_12.localPosition
			end

			local var_190_13 = 0.001

			if 1.96599999815226 <= arg_187_1.time_ and arg_187_1.time_ < 1.96599999815226 + var_190_13 then
				var_190_12.localPosition = Vector3.Lerp(arg_187_1.var_.moveOldPos1097ui_story, Vector3.New(0, 100, 0), (arg_187_1.time_ - 1.96599999815226) / var_190_13)
				var_190_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_190_12.position).x, (manager.ui.mainCamera.transform.position - var_190_12.position).y, (manager.ui.mainCamera.transform.position - var_190_12.position).z)
				var_190_12.localEulerAngles.z = 0
				var_190_12.localEulerAngles.x = 0
				var_190_12.localEulerAngles = var_190_12.localEulerAngles
			end

			if arg_187_1.time_ >= 1.96599999815226 + var_190_13 and arg_187_1.time_ < 1.96599999815226 + var_190_13 + arg_190_0 then
				var_190_12.localPosition = Vector3.New(0, 100, 0)
				var_190_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_190_12.position).x, (manager.ui.mainCamera.transform.position - var_190_12.position).y, (manager.ui.mainCamera.transform.position - var_190_12.position).z)
				var_190_12.localEulerAngles.z = 0
				var_190_12.localEulerAngles.x = 0
				var_190_12.localEulerAngles = var_190_12.localEulerAngles
			end

			local var_190_14 = arg_187_1.actors_["1097ui_story"]

			if 1.96599999815226 < arg_187_1.time_ and arg_187_1.time_ <= 1.96599999815226 + arg_190_0 and not isNil(var_190_14) and arg_187_1.var_.characterEffect1097ui_story == nil then
				arg_187_1.var_.characterEffect1097ui_story = var_190_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_190_15 = 0.034000001847744

			if 1.96599999815226 <= arg_187_1.time_ and arg_187_1.time_ < 1.96599999815226 + var_190_15 and not isNil(var_190_14) then
				if arg_187_1.var_.characterEffect1097ui_story and not isNil(var_190_14) then
					arg_187_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_187_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_187_1.time_ - 1.96599999815226) / var_190_15)
				end
			end

			if arg_187_1.time_ >= 1.96599999815226 + var_190_15 and arg_187_1.time_ < 1.96599999815226 + var_190_15 + arg_190_0 and not isNil(var_190_14) and arg_187_1.var_.characterEffect1097ui_story then
				arg_187_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_187_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			if arg_187_1.frameCnt_ <= 1 then
				arg_187_1.dialog_:SetActive(false)
			end

			local var_190_16 = 3.96599999815226
			local var_190_17 = 0.575

			if 3.96599999815226 < arg_187_1.time_ and arg_187_1.time_ <= var_190_16 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0

				arg_187_1.dialog_:SetActive(true)

				arg_187_1.dialogCg_.alpha = 0

				local var_190_18 = LeanTween.value(arg_187_1.dialog_, 0, 1, 0.3)

				var_190_18:setOnUpdate(LuaHelper.FloatAction(function(arg_191_0)
					arg_187_1.dialogCg_.alpha = arg_191_0
				end))
				var_190_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_187_1.dialog_)
					var_190_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_187_1.duration_ = arg_187_1.duration_ + 0.3

				SetActive(arg_187_1.leftNameGo_, true)

				arg_187_1.leftNameTxt_.text = arg_187_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_187_1.leftNameTxt_.transform)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1.leftNameTxt_.text)
				SetActive(arg_187_1.iconTrs_.gameObject, true)
				arg_187_1.iconController_:SetSelectedState("hero")

				arg_187_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_187_1.callingController_:SetSelectedState("normal")

				arg_187_1.keyicon_.color = Color.New(1, 1, 1)
				arg_187_1.icon_.color = Color.New(1, 1, 1)

				local var_190_19 = arg_187_1:FormatText(arg_187_1:GetWordFromCfg(1109703045).content)

				arg_187_1.text_.text = var_190_19

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_21 = 23 <= 0 and var_190_17 or var_190_17 * (utf8.len(var_190_19) / 23)

				if (23 <= 0 and var_190_17 or var_190_17 * (utf8.len(var_190_19) / 23)) > 0 and var_190_17 < var_190_21 then
					arg_187_1.talkMaxDuration = var_190_21
					var_190_16 = var_190_16 + 0.3

					if var_190_21 + var_190_16 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_21 + var_190_16
					end
				end

				arg_187_1.text_.text = var_190_19
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)
				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_22 = var_190_16 + 0.3
			local var_190_23 = math.max(var_190_17, arg_187_1.talkMaxDuration)

			if var_190_16 + 0.3 <= arg_187_1.time_ and arg_187_1.time_ < var_190_22 + var_190_23 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - var_190_22) / var_190_23

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= var_190_22 + var_190_23 and arg_187_1.time_ < var_190_22 + var_190_23 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_187_1:InitPlayNodeList()
	end,
	Play1109703046 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 1109703046
		arg_193_1.duration_ = 6.2

		local var_193_0 = {
			zh = 3.7,
			ja = 6.2
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
				arg_193_0:Play1109703047(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				arg_193_1.var_.moveOldPos1097ui_story = arg_193_1.actors_["1097ui_story"].transform.localPosition
			end

			local var_196_0 = 0.001

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_0 then
				arg_193_1.actors_["1097ui_story"].transform.localPosition = Vector3.Lerp(arg_193_1.var_.moveOldPos1097ui_story, Vector3.New(0, -0.54, -6.3), (arg_193_1.time_ - 0) / var_196_0)
				arg_193_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_193_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_193_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_193_1.actors_["1097ui_story"].transform.position).z)
				arg_193_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_193_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_193_1.actors_["1097ui_story"].transform.localEulerAngles = arg_193_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			if arg_193_1.time_ >= 0 + var_196_0 and arg_193_1.time_ < 0 + var_196_0 + arg_196_0 then
				arg_193_1.actors_["1097ui_story"].transform.localPosition = Vector3.New(0, -0.54, -6.3)
				arg_193_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_193_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_193_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_193_1.actors_["1097ui_story"].transform.position).z)
				arg_193_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_193_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_193_1.actors_["1097ui_story"].transform.localEulerAngles = arg_193_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			local var_196_1 = arg_193_1.actors_["1097ui_story"]

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 and not isNil(var_196_1) and arg_193_1.var_.characterEffect1097ui_story == nil then
				arg_193_1.var_.characterEffect1097ui_story = var_196_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_196_2 = 0.200000002980232

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_2 and not isNil(var_196_1) then
				if arg_193_1.var_.characterEffect1097ui_story and not isNil(var_196_1) then
					arg_193_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_193_1.time_ >= 0 + var_196_2 and arg_193_1.time_ < 0 + var_196_2 + arg_196_0 and not isNil(var_196_1) and arg_193_1.var_.characterEffect1097ui_story then
				arg_193_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				arg_193_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				arg_193_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_196_4 = 0
			local var_196_5 = 0.4

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= var_196_4 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, true)

				arg_193_1.leftNameTxt_.text = arg_193_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_193_1.leftNameTxt_.transform)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1.leftNameTxt_.text)
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_6 = arg_193_1:GetWordFromCfg(1109703046)
				local var_196_7 = arg_193_1:FormatText(var_196_6.content)

				arg_193_1.text_.text = var_196_7

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_9 = 16 <= 0 and var_196_5 or var_196_5 * (utf8.len(var_196_7) / 16)

				if (16 <= 0 and var_196_5 or var_196_5 * (utf8.len(var_196_7) / 16)) > 0 and var_196_5 < var_196_9 then
					arg_193_1.talkMaxDuration = var_196_9

					if var_196_9 + var_196_4 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_9 + var_196_4
					end
				end

				arg_193_1.text_.text = var_196_7
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703046", "story_v_side_new_1109703.awb") ~= 0 then
					local var_196_10 = manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703046", "story_v_side_new_1109703.awb") / 1000

					if var_196_10 + var_196_4 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_10 + var_196_4
					end

					if var_196_6.prefab_name ~= "" and arg_193_1.actors_[var_196_6.prefab_name] ~= nil then
						local var_196_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_193_1.actors_[var_196_6.prefab_name].transform, "story_v_side_new_1109703", "1109703046", "story_v_side_new_1109703.awb")

						arg_193_1:RecordAudio("1109703046", var_196_11)
						arg_193_1:RecordAudio("1109703046", var_196_11)
					else
						arg_193_1:AudioAction("play", "voice", "story_v_side_new_1109703", "1109703046", "story_v_side_new_1109703.awb")
					end

					arg_193_1:RecordHistoryTalkVoice("story_v_side_new_1109703", "1109703046", "story_v_side_new_1109703.awb")
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
				actorName = "1097ui_story",
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
	Play1109703047 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 1109703047
		arg_197_1.duration_ = 5

		SetActive(arg_197_1.tipsGo_, false)

		function arg_197_1.onSingleLineFinish_()
			arg_197_1.onSingleLineUpdate_ = nil
			arg_197_1.onSingleLineFinish_ = nil
			arg_197_1.state_ = "waiting"
		end

		function arg_197_1.playNext_(arg_199_0)
			if arg_199_0 == 1 then
				arg_197_0:Play1109703048(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 and not isNil(arg_197_1.actors_["1097ui_story"]) and arg_197_1.var_.characterEffect1097ui_story == nil then
				arg_197_1.var_.characterEffect1097ui_story = arg_197_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_200_0 = 0.200000002980232

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_0 and not isNil(arg_197_1.actors_["1097ui_story"]) then
				if arg_197_1.var_.characterEffect1097ui_story and not isNil(arg_197_1.actors_["1097ui_story"]) then
					arg_197_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_197_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_197_1.time_ - 0) / var_200_0)
				end
			end

			if arg_197_1.time_ >= 0 + var_200_0 and arg_197_1.time_ < 0 + var_200_0 + arg_200_0 and not isNil(arg_197_1.actors_["1097ui_story"]) and arg_197_1.var_.characterEffect1097ui_story then
				arg_197_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_197_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_200_1 = 0
			local var_200_2 = 0.125

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= var_200_1 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, true)

				arg_197_1.leftNameTxt_.text = arg_197_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, true)
				arg_197_1.iconController_:SetSelectedState("hero")

				arg_197_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_197_1.callingController_:SetSelectedState("normal")

				arg_197_1.keyicon_.color = Color.New(1, 1, 1)
				arg_197_1.icon_.color = Color.New(1, 1, 1)

				local var_200_3 = arg_197_1:FormatText(arg_197_1:GetWordFromCfg(1109703047).content)

				arg_197_1.text_.text = var_200_3

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_5 = 5 <= 0 and var_200_2 or var_200_2 * (utf8.len(var_200_3) / 5)

				if (5 <= 0 and var_200_2 or var_200_2 * (utf8.len(var_200_3) / 5)) > 0 and var_200_2 < var_200_5 then
					arg_197_1.talkMaxDuration = var_200_5

					if var_200_5 + var_200_1 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_5 + var_200_1
					end
				end

				arg_197_1.text_.text = var_200_3
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)
				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_6 = math.max(var_200_2, arg_197_1.talkMaxDuration)

			if var_200_1 <= arg_197_1.time_ and arg_197_1.time_ < var_200_1 + var_200_6 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - var_200_1) / var_200_6

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= var_200_1 + var_200_6 and arg_197_1.time_ < var_200_1 + var_200_6 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {}

		arg_197_1:InitPlayNodeList()
	end,
	Play1109703048 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 1109703048
		arg_201_1.duration_ = 13.33

		local var_201_0 = {
			zh = 9.466,
			ja = 13.333
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
				arg_201_0:Play1109703049(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 and not isNil(arg_201_1.actors_["1097ui_story"]) and arg_201_1.var_.characterEffect1097ui_story == nil then
				arg_201_1.var_.characterEffect1097ui_story = arg_201_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_204_0 = 0.200000002980232

			if 0 <= arg_201_1.time_ and arg_201_1.time_ < 0 + var_204_0 and not isNil(arg_201_1.actors_["1097ui_story"]) then
				if arg_201_1.var_.characterEffect1097ui_story and not isNil(arg_201_1.actors_["1097ui_story"]) then
					arg_201_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_201_1.time_ >= 0 + var_204_0 and arg_201_1.time_ < 0 + var_204_0 + arg_204_0 and not isNil(arg_201_1.actors_["1097ui_story"]) and arg_201_1.var_.characterEffect1097ui_story then
				arg_201_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 then
				arg_201_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action7_1")
			end

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 then
				arg_201_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_204_2 = 0
			local var_204_3 = 0.85

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= var_204_2 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, true)

				arg_201_1.leftNameTxt_.text = arg_201_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_201_1.leftNameTxt_.transform)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1.leftNameTxt_.text)
				SetActive(arg_201_1.iconTrs_.gameObject, false)
				arg_201_1.callingController_:SetSelectedState("normal")

				local var_204_4 = arg_201_1:GetWordFromCfg(1109703048)
				local var_204_5 = arg_201_1:FormatText(var_204_4.content)

				arg_201_1.text_.text = var_204_5

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_7 = 34 <= 0 and var_204_3 or var_204_3 * (utf8.len(var_204_5) / 34)

				if (34 <= 0 and var_204_3 or var_204_3 * (utf8.len(var_204_5) / 34)) > 0 and var_204_3 < var_204_7 then
					arg_201_1.talkMaxDuration = var_204_7

					if var_204_7 + var_204_2 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_7 + var_204_2
					end
				end

				arg_201_1.text_.text = var_204_5
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703048", "story_v_side_new_1109703.awb") ~= 0 then
					local var_204_8 = manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703048", "story_v_side_new_1109703.awb") / 1000

					if var_204_8 + var_204_2 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_8 + var_204_2
					end

					if var_204_4.prefab_name ~= "" and arg_201_1.actors_[var_204_4.prefab_name] ~= nil then
						local var_204_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_201_1.actors_[var_204_4.prefab_name].transform, "story_v_side_new_1109703", "1109703048", "story_v_side_new_1109703.awb")

						arg_201_1:RecordAudio("1109703048", var_204_9)
						arg_201_1:RecordAudio("1109703048", var_204_9)
					else
						arg_201_1:AudioAction("play", "voice", "story_v_side_new_1109703", "1109703048", "story_v_side_new_1109703.awb")
					end

					arg_201_1:RecordHistoryTalkVoice("story_v_side_new_1109703", "1109703048", "story_v_side_new_1109703.awb")
				end

				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_10 = math.max(var_204_3, arg_201_1.talkMaxDuration)

			if var_204_2 <= arg_201_1.time_ and arg_201_1.time_ < var_204_2 + var_204_10 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - var_204_2) / var_204_10

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= var_204_2 + var_204_10 and arg_201_1.time_ < var_204_2 + var_204_10 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {}

		arg_201_1:InitPlayNodeList()
	end,
	Play1109703049 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 1109703049
		arg_205_1.duration_ = 11.77

		local var_205_0 = {
			zh = 11.766,
			ja = 11.466
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
				arg_205_0:Play1109703050(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 then
				arg_205_1.var_.moveOldPos1097ui_story = arg_205_1.actors_["1097ui_story"].transform.localPosition
			end

			local var_208_0 = 0.001

			if 0 <= arg_205_1.time_ and arg_205_1.time_ < 0 + var_208_0 then
				arg_205_1.actors_["1097ui_story"].transform.localPosition = Vector3.Lerp(arg_205_1.var_.moveOldPos1097ui_story, Vector3.New(0, -0.54, -6.3), (arg_205_1.time_ - 0) / var_208_0)
				arg_205_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_205_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_205_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_205_1.actors_["1097ui_story"].transform.position).z)
				arg_205_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_205_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_205_1.actors_["1097ui_story"].transform.localEulerAngles = arg_205_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			if arg_205_1.time_ >= 0 + var_208_0 and arg_205_1.time_ < 0 + var_208_0 + arg_208_0 then
				arg_205_1.actors_["1097ui_story"].transform.localPosition = Vector3.New(0, -0.54, -6.3)
				arg_205_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_205_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_205_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_205_1.actors_["1097ui_story"].transform.position).z)
				arg_205_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_205_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_205_1.actors_["1097ui_story"].transform.localEulerAngles = arg_205_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			local var_208_1 = arg_205_1.actors_["1097ui_story"]

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 and not isNil(var_208_1) and arg_205_1.var_.characterEffect1097ui_story == nil then
				arg_205_1.var_.characterEffect1097ui_story = var_208_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_208_2 = 0.200000002980232

			if 0 <= arg_205_1.time_ and arg_205_1.time_ < 0 + var_208_2 and not isNil(var_208_1) then
				if arg_205_1.var_.characterEffect1097ui_story and not isNil(var_208_1) then
					arg_205_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_205_1.time_ >= 0 + var_208_2 and arg_205_1.time_ < 0 + var_208_2 + arg_208_0 and not isNil(var_208_1) and arg_205_1.var_.characterEffect1097ui_story then
				arg_205_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 then
				arg_205_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097actionlink/1097action476")
			end

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 then
				arg_205_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_208_4 = 0
			local var_208_5 = 0.95

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= var_208_4 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, true)

				arg_205_1.leftNameTxt_.text = arg_205_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_205_1.leftNameTxt_.transform)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1.leftNameTxt_.text)
				SetActive(arg_205_1.iconTrs_.gameObject, false)
				arg_205_1.callingController_:SetSelectedState("normal")

				local var_208_6 = arg_205_1:GetWordFromCfg(1109703049)
				local var_208_7 = arg_205_1:FormatText(var_208_6.content)

				arg_205_1.text_.text = var_208_7

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_9 = 38 <= 0 and var_208_5 or var_208_5 * (utf8.len(var_208_7) / 38)

				if (38 <= 0 and var_208_5 or var_208_5 * (utf8.len(var_208_7) / 38)) > 0 and var_208_5 < var_208_9 then
					arg_205_1.talkMaxDuration = var_208_9

					if var_208_9 + var_208_4 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_9 + var_208_4
					end
				end

				arg_205_1.text_.text = var_208_7
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703049", "story_v_side_new_1109703.awb") ~= 0 then
					local var_208_10 = manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703049", "story_v_side_new_1109703.awb") / 1000

					if var_208_10 + var_208_4 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_10 + var_208_4
					end

					if var_208_6.prefab_name ~= "" and arg_205_1.actors_[var_208_6.prefab_name] ~= nil then
						local var_208_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_205_1.actors_[var_208_6.prefab_name].transform, "story_v_side_new_1109703", "1109703049", "story_v_side_new_1109703.awb")

						arg_205_1:RecordAudio("1109703049", var_208_11)
						arg_205_1:RecordAudio("1109703049", var_208_11)
					else
						arg_205_1:AudioAction("play", "voice", "story_v_side_new_1109703", "1109703049", "story_v_side_new_1109703.awb")
					end

					arg_205_1:RecordHistoryTalkVoice("story_v_side_new_1109703", "1109703049", "story_v_side_new_1109703.awb")
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

		arg_205_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_205_1:InitPlayNodeList()
	end,
	Play1109703050 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 1109703050
		arg_209_1.duration_ = 5

		SetActive(arg_209_1.tipsGo_, false)

		function arg_209_1.onSingleLineFinish_()
			arg_209_1.onSingleLineUpdate_ = nil
			arg_209_1.onSingleLineFinish_ = nil
			arg_209_1.state_ = "waiting"
		end

		function arg_209_1.playNext_(arg_211_0)
			if arg_211_0 == 1 then
				arg_209_0:Play1109703051(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 and not isNil(arg_209_1.actors_["1097ui_story"]) and arg_209_1.var_.characterEffect1097ui_story == nil then
				arg_209_1.var_.characterEffect1097ui_story = arg_209_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_212_0 = 0.200000002980232

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_0 and not isNil(arg_209_1.actors_["1097ui_story"]) then
				if arg_209_1.var_.characterEffect1097ui_story and not isNil(arg_209_1.actors_["1097ui_story"]) then
					arg_209_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_209_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_209_1.time_ - 0) / var_212_0)
				end
			end

			if arg_209_1.time_ >= 0 + var_212_0 and arg_209_1.time_ < 0 + var_212_0 + arg_212_0 and not isNil(arg_209_1.actors_["1097ui_story"]) and arg_209_1.var_.characterEffect1097ui_story then
				arg_209_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_209_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_212_1 = 0
			local var_212_2 = 0.7

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= var_212_1 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, true)

				arg_209_1.leftNameTxt_.text = arg_209_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_209_1.leftNameTxt_.transform)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1.leftNameTxt_.text)
				SetActive(arg_209_1.iconTrs_.gameObject, true)
				arg_209_1.iconController_:SetSelectedState("hero")

				arg_209_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_209_1.callingController_:SetSelectedState("normal")

				arg_209_1.keyicon_.color = Color.New(1, 1, 1)
				arg_209_1.icon_.color = Color.New(1, 1, 1)

				local var_212_3 = arg_209_1:FormatText(arg_209_1:GetWordFromCfg(1109703050).content)

				arg_209_1.text_.text = var_212_3

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_5 = 28 <= 0 and var_212_2 or var_212_2 * (utf8.len(var_212_3) / 28)

				if (28 <= 0 and var_212_2 or var_212_2 * (utf8.len(var_212_3) / 28)) > 0 and var_212_2 < var_212_5 then
					arg_209_1.talkMaxDuration = var_212_5

					if var_212_5 + var_212_1 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_5 + var_212_1
					end
				end

				arg_209_1.text_.text = var_212_3
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)
				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_6 = math.max(var_212_2, arg_209_1.talkMaxDuration)

			if var_212_1 <= arg_209_1.time_ and arg_209_1.time_ < var_212_1 + var_212_6 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - var_212_1) / var_212_6

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= var_212_1 + var_212_6 and arg_209_1.time_ < var_212_1 + var_212_6 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {}

		arg_209_1:InitPlayNodeList()
	end,
	Play1109703051 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 1109703051
		arg_213_1.duration_ = 13.5

		local var_213_0 = {
			zh = 13.5,
			ja = 12.5
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
				arg_213_0:Play1109703052(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 and not isNil(arg_213_1.actors_["1097ui_story"]) and arg_213_1.var_.characterEffect1097ui_story == nil then
				arg_213_1.var_.characterEffect1097ui_story = arg_213_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_216_0 = 0.200000002980232

			if 0 <= arg_213_1.time_ and arg_213_1.time_ < 0 + var_216_0 and not isNil(arg_213_1.actors_["1097ui_story"]) then
				if arg_213_1.var_.characterEffect1097ui_story and not isNil(arg_213_1.actors_["1097ui_story"]) then
					arg_213_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_213_1.time_ >= 0 + var_216_0 and arg_213_1.time_ < 0 + var_216_0 + arg_216_0 and not isNil(arg_213_1.actors_["1097ui_story"]) and arg_213_1.var_.characterEffect1097ui_story then
				arg_213_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 then
				arg_213_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action6_2")
			end

			if 2 < arg_213_1.time_ and arg_213_1.time_ <= 2 + arg_216_0 then
				arg_213_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action2_1")
			end

			if 2 < arg_213_1.time_ and arg_213_1.time_ <= 2 + arg_216_0 then
				arg_213_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_216_2 = 0
			local var_216_3 = 1.425

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= var_216_2 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, true)

				arg_213_1.leftNameTxt_.text = arg_213_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_213_1.leftNameTxt_.transform)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1.leftNameTxt_.text)
				SetActive(arg_213_1.iconTrs_.gameObject, false)
				arg_213_1.callingController_:SetSelectedState("normal")

				local var_216_4 = arg_213_1:GetWordFromCfg(1109703051)
				local var_216_5 = arg_213_1:FormatText(var_216_4.content)

				arg_213_1.text_.text = var_216_5

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_7 = 57 <= 0 and var_216_3 or var_216_3 * (utf8.len(var_216_5) / 57)

				if (57 <= 0 and var_216_3 or var_216_3 * (utf8.len(var_216_5) / 57)) > 0 and var_216_3 < var_216_7 then
					arg_213_1.talkMaxDuration = var_216_7

					if var_216_7 + var_216_2 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_7 + var_216_2
					end
				end

				arg_213_1.text_.text = var_216_5
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703051", "story_v_side_new_1109703.awb") ~= 0 then
					local var_216_8 = manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703051", "story_v_side_new_1109703.awb") / 1000

					if var_216_8 + var_216_2 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_8 + var_216_2
					end

					if var_216_4.prefab_name ~= "" and arg_213_1.actors_[var_216_4.prefab_name] ~= nil then
						local var_216_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_213_1.actors_[var_216_4.prefab_name].transform, "story_v_side_new_1109703", "1109703051", "story_v_side_new_1109703.awb")

						arg_213_1:RecordAudio("1109703051", var_216_9)
						arg_213_1:RecordAudio("1109703051", var_216_9)
					else
						arg_213_1:AudioAction("play", "voice", "story_v_side_new_1109703", "1109703051", "story_v_side_new_1109703.awb")
					end

					arg_213_1:RecordHistoryTalkVoice("story_v_side_new_1109703", "1109703051", "story_v_side_new_1109703.awb")
				end

				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_10 = math.max(var_216_3, arg_213_1.talkMaxDuration)

			if var_216_2 <= arg_213_1.time_ and arg_213_1.time_ < var_216_2 + var_216_10 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - var_216_2) / var_216_10

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= var_216_2 + var_216_10 and arg_213_1.time_ < var_216_2 + var_216_10 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {}

		arg_213_1:InitPlayNodeList()
	end,
	Play1109703052 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 1109703052
		arg_217_1.duration_ = 5

		SetActive(arg_217_1.tipsGo_, false)

		function arg_217_1.onSingleLineFinish_()
			arg_217_1.onSingleLineUpdate_ = nil
			arg_217_1.onSingleLineFinish_ = nil
			arg_217_1.state_ = "waiting"
		end

		function arg_217_1.playNext_(arg_219_0)
			if arg_219_0 == 1 then
				arg_217_0:Play1109703053(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 and not isNil(arg_217_1.actors_["1097ui_story"]) and arg_217_1.var_.characterEffect1097ui_story == nil then
				arg_217_1.var_.characterEffect1097ui_story = arg_217_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_220_0 = 0.200000002980232

			if 0 <= arg_217_1.time_ and arg_217_1.time_ < 0 + var_220_0 and not isNil(arg_217_1.actors_["1097ui_story"]) then
				if arg_217_1.var_.characterEffect1097ui_story and not isNil(arg_217_1.actors_["1097ui_story"]) then
					arg_217_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_217_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_217_1.time_ - 0) / var_220_0)
				end
			end

			if arg_217_1.time_ >= 0 + var_220_0 and arg_217_1.time_ < 0 + var_220_0 + arg_220_0 and not isNil(arg_217_1.actors_["1097ui_story"]) and arg_217_1.var_.characterEffect1097ui_story then
				arg_217_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_217_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 then
				arg_217_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 then
				arg_217_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action2_2")
			end

			local var_220_1 = 0
			local var_220_2 = 0.175

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= var_220_1 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0
				arg_217_1.dialogCg_.alpha = 1

				arg_217_1.dialog_:SetActive(true)
				SetActive(arg_217_1.leftNameGo_, true)

				arg_217_1.leftNameTxt_.text = arg_217_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_217_1.leftNameTxt_.transform)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1.leftNameTxt_.text)
				SetActive(arg_217_1.iconTrs_.gameObject, true)
				arg_217_1.iconController_:SetSelectedState("hero")

				arg_217_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_217_1.callingController_:SetSelectedState("normal")

				arg_217_1.keyicon_.color = Color.New(1, 1, 1)
				arg_217_1.icon_.color = Color.New(1, 1, 1)

				local var_220_3 = arg_217_1:FormatText(arg_217_1:GetWordFromCfg(1109703052).content)

				arg_217_1.text_.text = var_220_3

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_5 = 7 <= 0 and var_220_2 or var_220_2 * (utf8.len(var_220_3) / 7)

				if (7 <= 0 and var_220_2 or var_220_2 * (utf8.len(var_220_3) / 7)) > 0 and var_220_2 < var_220_5 then
					arg_217_1.talkMaxDuration = var_220_5

					if var_220_5 + var_220_1 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_5 + var_220_1
					end
				end

				arg_217_1.text_.text = var_220_3
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)
				arg_217_1:RecordContent(arg_217_1.text_.text)
			end

			local var_220_6 = math.max(var_220_2, arg_217_1.talkMaxDuration)

			if var_220_1 <= arg_217_1.time_ and arg_217_1.time_ < var_220_1 + var_220_6 then
				arg_217_1.typewritter.percent = (arg_217_1.time_ - var_220_1) / var_220_6

				arg_217_1.typewritter:SetDirty()
			end

			if arg_217_1.time_ >= var_220_1 + var_220_6 and arg_217_1.time_ < var_220_1 + var_220_6 + arg_220_0 then
				arg_217_1.typewritter.percent = 1

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(true)
			end
		end

		arg_217_1.nodeConfigList_ = {}

		arg_217_1:InitPlayNodeList()
	end,
	Play1109703053 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 1109703053
		arg_221_1.duration_ = 5

		SetActive(arg_221_1.tipsGo_, false)

		function arg_221_1.onSingleLineFinish_()
			arg_221_1.onSingleLineUpdate_ = nil
			arg_221_1.onSingleLineFinish_ = nil
			arg_221_1.state_ = "waiting"
		end

		function arg_221_1.playNext_(arg_223_0)
			if arg_223_0 == 1 then
				arg_221_0:Play1109703054(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 then
				arg_221_1.var_.moveOldPos1097ui_story = arg_221_1.actors_["1097ui_story"].transform.localPosition
			end

			local var_224_0 = 0.001

			if 0 <= arg_221_1.time_ and arg_221_1.time_ < 0 + var_224_0 then
				arg_221_1.actors_["1097ui_story"].transform.localPosition = Vector3.Lerp(arg_221_1.var_.moveOldPos1097ui_story, Vector3.New(0, 100, 0), (arg_221_1.time_ - 0) / var_224_0)
				arg_221_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_221_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_221_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_221_1.actors_["1097ui_story"].transform.position).z)
				arg_221_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_221_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_221_1.actors_["1097ui_story"].transform.localEulerAngles = arg_221_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			if arg_221_1.time_ >= 0 + var_224_0 and arg_221_1.time_ < 0 + var_224_0 + arg_224_0 then
				arg_221_1.actors_["1097ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_221_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_221_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_221_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_221_1.actors_["1097ui_story"].transform.position).z)
				arg_221_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_221_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_221_1.actors_["1097ui_story"].transform.localEulerAngles = arg_221_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			local var_224_1 = arg_221_1.actors_["1097ui_story"]

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 and not isNil(var_224_1) and arg_221_1.var_.characterEffect1097ui_story == nil then
				arg_221_1.var_.characterEffect1097ui_story = var_224_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_224_2 = 0.034000001847744

			if 0 <= arg_221_1.time_ and arg_221_1.time_ < 0 + var_224_2 and not isNil(var_224_1) then
				if arg_221_1.var_.characterEffect1097ui_story and not isNil(var_224_1) then
					arg_221_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_221_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_221_1.time_ - 0) / var_224_2)
				end
			end

			if arg_221_1.time_ >= 0 + var_224_2 and arg_221_1.time_ < 0 + var_224_2 + arg_224_0 and not isNil(var_224_1) and arg_221_1.var_.characterEffect1097ui_story then
				arg_221_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_221_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_224_3 = 0
			local var_224_4 = 1.025

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= var_224_3 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, false)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_221_1.iconTrs_.gameObject, false)
				arg_221_1.callingController_:SetSelectedState("normal")

				local var_224_5 = arg_221_1:FormatText(arg_221_1:GetWordFromCfg(1109703053).content)

				arg_221_1.text_.text = var_224_5

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_7 = 41 <= 0 and var_224_4 or var_224_4 * (utf8.len(var_224_5) / 41)

				if (41 <= 0 and var_224_4 or var_224_4 * (utf8.len(var_224_5) / 41)) > 0 and var_224_4 < var_224_7 then
					arg_221_1.talkMaxDuration = var_224_7

					if var_224_7 + var_224_3 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_7 + var_224_3
					end
				end

				arg_221_1.text_.text = var_224_5
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)
				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_8 = math.max(var_224_4, arg_221_1.talkMaxDuration)

			if var_224_3 <= arg_221_1.time_ and arg_221_1.time_ < var_224_3 + var_224_8 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - var_224_3) / var_224_8

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= var_224_3 + var_224_8 and arg_221_1.time_ < var_224_3 + var_224_8 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end

		arg_221_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_221_1:InitPlayNodeList()
	end,
	Play1109703054 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 1109703054
		arg_225_1.duration_ = 5

		SetActive(arg_225_1.tipsGo_, false)

		function arg_225_1.onSingleLineFinish_()
			arg_225_1.onSingleLineUpdate_ = nil
			arg_225_1.onSingleLineFinish_ = nil
			arg_225_1.state_ = "waiting"
		end

		function arg_225_1.playNext_(arg_227_0)
			if arg_227_0 == 1 then
				arg_225_0:Play1109703055(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			local var_228_0 = 0.45

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, true)

				arg_225_1.leftNameTxt_.text = arg_225_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_225_1.leftNameTxt_.transform)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1.leftNameTxt_.text)
				SetActive(arg_225_1.iconTrs_.gameObject, true)
				arg_225_1.iconController_:SetSelectedState("hero")

				arg_225_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_225_1.callingController_:SetSelectedState("normal")

				arg_225_1.keyicon_.color = Color.New(1, 1, 1)
				arg_225_1.icon_.color = Color.New(1, 1, 1)

				local var_228_1 = arg_225_1:FormatText(arg_225_1:GetWordFromCfg(1109703054).content)

				arg_225_1.text_.text = var_228_1

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_3 = 18 <= 0 and var_228_0 or var_228_0 * (utf8.len(var_228_1) / 18)

				if (18 <= 0 and var_228_0 or var_228_0 * (utf8.len(var_228_1) / 18)) > 0 and var_228_0 < var_228_3 then
					arg_225_1.talkMaxDuration = var_228_3

					if var_228_3 + 0 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_3 + 0
					end
				end

				arg_225_1.text_.text = var_228_1
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)
				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_4 = math.max(var_228_0, arg_225_1.talkMaxDuration)

			if 0 <= arg_225_1.time_ and arg_225_1.time_ < 0 + var_228_4 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - 0) / var_228_4

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= 0 + var_228_4 and arg_225_1.time_ < 0 + var_228_4 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {}

		arg_225_1:InitPlayNodeList()
	end,
	Play1109703055 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 1109703055
		arg_229_1.duration_ = 5

		SetActive(arg_229_1.tipsGo_, false)

		function arg_229_1.onSingleLineFinish_()
			arg_229_1.onSingleLineUpdate_ = nil
			arg_229_1.onSingleLineFinish_ = nil
			arg_229_1.state_ = "waiting"
		end

		function arg_229_1.playNext_(arg_231_0)
			if arg_231_0 == 1 then
				arg_229_0:Play1109703056(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			local var_232_0 = 0.475

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, true)

				arg_229_1.leftNameTxt_.text = arg_229_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_229_1.leftNameTxt_.transform)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1.leftNameTxt_.text)
				SetActive(arg_229_1.iconTrs_.gameObject, true)
				arg_229_1.iconController_:SetSelectedState("hero")

				arg_229_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_229_1.callingController_:SetSelectedState("normal")

				arg_229_1.keyicon_.color = Color.New(1, 1, 1)
				arg_229_1.icon_.color = Color.New(1, 1, 1)

				local var_232_1 = arg_229_1:FormatText(arg_229_1:GetWordFromCfg(1109703055).content)

				arg_229_1.text_.text = var_232_1

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_3 = 19 <= 0 and var_232_0 or var_232_0 * (utf8.len(var_232_1) / 19)

				if (19 <= 0 and var_232_0 or var_232_0 * (utf8.len(var_232_1) / 19)) > 0 and var_232_0 < var_232_3 then
					arg_229_1.talkMaxDuration = var_232_3

					if var_232_3 + 0 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_3 + 0
					end
				end

				arg_229_1.text_.text = var_232_1
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)
				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_4 = math.max(var_232_0, arg_229_1.talkMaxDuration)

			if 0 <= arg_229_1.time_ and arg_229_1.time_ < 0 + var_232_4 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - 0) / var_232_4

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= 0 + var_232_4 and arg_229_1.time_ < 0 + var_232_4 + arg_232_0 then
				arg_229_1.typewritter.percent = 1

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(true)
			end
		end

		arg_229_1.nodeConfigList_ = {}

		arg_229_1:InitPlayNodeList()
	end,
	Play1109703056 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 1109703056
		arg_233_1.duration_ = 10.63

		local var_233_0 = {
			zh = 8.7,
			ja = 10.633
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
				arg_233_0:Play1109703057(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			if 1.999999999999 < arg_233_1.time_ and arg_233_1.time_ <= 1.999999999999 + arg_236_0 then
				local var_236_0 = arg_233_1.bgs_.ST12

				arg_233_1.bgs_.ST12.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_236_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_236_1 = var_236_0:GetComponent("SpriteRenderer")

				if var_236_1 and var_236_1.sprite then
					local var_236_2 = 2 * (var_236_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_236_0.transform.localScale = Vector3.New(var_236_2 / var_236_1.sprite.bounds.size.y < var_236_2 * manager.ui.mainCameraCom_.aspect / var_236_1.sprite.bounds.size.x and var_236_2 * manager.ui.mainCameraCom_.aspect / var_236_1.sprite.bounds.size.x or var_236_2 / var_236_1.sprite.bounds.size.y, var_236_2 / var_236_1.sprite.bounds.size.y < var_236_2 * manager.ui.mainCameraCom_.aspect / var_236_1.sprite.bounds.size.x and var_236_2 * manager.ui.mainCameraCom_.aspect / var_236_1.sprite.bounds.size.x or var_236_2 / var_236_1.sprite.bounds.size.y, 0)
				end

				for iter_236_0, iter_236_1 in pairs(arg_233_1.bgs_) do
					if iter_236_0 ~= "ST12" then
						iter_236_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_236_3 = 3.999999999999

			if 3.999999999999 < arg_233_1.time_ and arg_233_1.time_ <= var_236_3 + arg_236_0 then
				arg_233_1.allBtn_.enabled = false
			end

			if arg_233_1.time_ >= var_236_3 + 0.3 and arg_233_1.time_ < var_236_3 + 0.3 + arg_236_0 then
				arg_233_1.allBtn_.enabled = true
			end

			local var_236_4 = 0

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= var_236_4 + arg_236_0 then
				arg_233_1.mask_.enabled = true
				arg_233_1.mask_.raycastTarget = true

				arg_233_1:SetGaussion(false)
			end

			local var_236_5 = 2

			if var_236_4 <= arg_233_1.time_ and arg_233_1.time_ < var_236_4 + var_236_5 then
				local var_236_6 = Color.New(1, 1, 1)

				var_236_6.a = Mathf.Lerp(0, 1, (arg_233_1.time_ - var_236_4) / var_236_5)
				arg_233_1.mask_.color = var_236_6
			end

			if arg_233_1.time_ >= var_236_4 + var_236_5 and arg_233_1.time_ < var_236_4 + var_236_5 + arg_236_0 then
				local var_236_7 = Color.New(1, 1, 1)

				var_236_7.a = 1
				arg_233_1.mask_.color = var_236_7
			end

			local var_236_8 = 2

			if 2 < arg_233_1.time_ and arg_233_1.time_ <= var_236_8 + arg_236_0 then
				arg_233_1.mask_.enabled = true
				arg_233_1.mask_.raycastTarget = true

				arg_233_1:SetGaussion(false)
			end

			local var_236_9 = 2

			if var_236_8 <= arg_233_1.time_ and arg_233_1.time_ < var_236_8 + var_236_9 then
				local var_236_10 = Color.New(1, 1, 1)

				var_236_10.a = Mathf.Lerp(1, 0, (arg_233_1.time_ - var_236_8) / var_236_9)
				arg_233_1.mask_.color = var_236_10
			end

			if arg_233_1.time_ >= var_236_8 + var_236_9 and arg_233_1.time_ < var_236_8 + var_236_9 + arg_236_0 then
				local var_236_11 = Color.New(1, 1, 1)

				arg_233_1.mask_.enabled = false
				var_236_11.a = 0
				arg_233_1.mask_.color = var_236_11
			end

			local var_236_12 = "1084ui_story"

			if arg_233_1.actors_["1084ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1084ui_story"))) then
				local var_236_13 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_233_1.stage_.transform)

				var_236_13.name = var_236_12
				var_236_13.transform.localPosition = Vector3.New(0, 100, 0)
				arg_233_1.actors_[var_236_12] = var_236_13

				local var_236_14 = var_236_13:GetComponentInChildren(typeof(CharacterEffect))

				var_236_14.enabled = true

				local var_236_15 = GameObjectTools.GetOrAddComponent(var_236_13, typeof(DynamicBoneHelper))

				if var_236_15 then
					var_236_15:EnableDynamicBone(false)
				end

				arg_233_1:ShowWeapon(var_236_14.transform, false)

				arg_233_1.var_[var_236_12 .. "Animator"] = var_236_14.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_233_1.var_[var_236_12 .. "Animator"].applyRootMotion = true
				arg_233_1.var_[var_236_12 .. "LipSync"] = var_236_14.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_236_16 = arg_233_1.actors_["1084ui_story"].transform

			if 3.8 < arg_233_1.time_ and arg_233_1.time_ <= 3.8 + arg_236_0 then
				arg_233_1.var_.moveOldPos1084ui_story = var_236_16.localPosition
			end

			local var_236_17 = 0.001

			if 3.8 <= arg_233_1.time_ and arg_233_1.time_ < 3.8 + var_236_17 then
				var_236_16.localPosition = Vector3.Lerp(arg_233_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_233_1.time_ - 3.8) / var_236_17)
				var_236_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_236_16.position).x, (manager.ui.mainCamera.transform.position - var_236_16.position).y, (manager.ui.mainCamera.transform.position - var_236_16.position).z)
				var_236_16.localEulerAngles.z = 0
				var_236_16.localEulerAngles.x = 0
				var_236_16.localEulerAngles = var_236_16.localEulerAngles
			end

			if arg_233_1.time_ >= 3.8 + var_236_17 and arg_233_1.time_ < 3.8 + var_236_17 + arg_236_0 then
				var_236_16.localPosition = Vector3.New(0, -0.97, -6)
				var_236_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_236_16.position).x, (manager.ui.mainCamera.transform.position - var_236_16.position).y, (manager.ui.mainCamera.transform.position - var_236_16.position).z)
				var_236_16.localEulerAngles.z = 0
				var_236_16.localEulerAngles.x = 0
				var_236_16.localEulerAngles = var_236_16.localEulerAngles
			end

			local var_236_18 = arg_233_1.actors_["1084ui_story"]

			if 3.8 < arg_233_1.time_ and arg_233_1.time_ <= 3.8 + arg_236_0 and not isNil(var_236_18) and arg_233_1.var_.characterEffect1084ui_story == nil then
				arg_233_1.var_.characterEffect1084ui_story = var_236_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_236_19 = 0.200000002980232

			if 3.8 <= arg_233_1.time_ and arg_233_1.time_ < 3.8 + var_236_19 and not isNil(var_236_18) then
				if arg_233_1.var_.characterEffect1084ui_story and not isNil(var_236_18) then
					arg_233_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_233_1.time_ >= 3.8 + var_236_19 and arg_233_1.time_ < 3.8 + var_236_19 + arg_236_0 and not isNil(var_236_18) and arg_233_1.var_.characterEffect1084ui_story then
				arg_233_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 3.8 < arg_233_1.time_ and arg_233_1.time_ <= 3.8 + arg_236_0 then
				arg_233_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action2_1")
			end

			if 3.8 < arg_233_1.time_ and arg_233_1.time_ <= 3.8 + arg_236_0 then
				arg_233_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva")
			end

			if 3.8 < arg_233_1.time_ and arg_233_1.time_ <= 3.8 + arg_236_0 then
				if arg_233_1.var_.characterEffect1084ui_story == nil then
					arg_233_1.var_.characterEffect1084ui_story = arg_233_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_236_21 = arg_233_1.var_.characterEffect1084ui_story

				arg_233_1.var_.characterEffect1084ui_story.imageEffect:turnOff()

				var_236_21.interferenceEffect.enabled = true
				var_236_21.interferenceEffect.noise = 0.001
				var_236_21.interferenceEffect.simTimeScale = 1
				var_236_21.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			if 3.8 < arg_233_1.time_ and arg_233_1.time_ <= 3.8 + arg_236_0 then
				if arg_233_1.var_.characterEffect1084ui_story == nil then
					arg_233_1.var_.characterEffect1084ui_story = arg_233_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_233_1.var_.characterEffect1084ui_story.imageEffect:turnOn(false)
			end

			if arg_233_1.frameCnt_ <= 1 then
				arg_233_1.dialog_:SetActive(false)
			end

			local var_236_23 = 4
			local var_236_24 = 0.625

			if 4 < arg_233_1.time_ and arg_233_1.time_ <= var_236_23 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0

				arg_233_1.dialog_:SetActive(true)

				arg_233_1.dialogCg_.alpha = 0

				local var_236_25 = LeanTween.value(arg_233_1.dialog_, 0, 1, 0.3)

				var_236_25:setOnUpdate(LuaHelper.FloatAction(function(arg_237_0)
					arg_233_1.dialogCg_.alpha = arg_237_0
				end))
				var_236_25:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_233_1.dialog_)
					var_236_25:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_233_1.duration_ = arg_233_1.duration_ + 0.3

				SetActive(arg_233_1.leftNameGo_, true)

				arg_233_1.leftNameTxt_.text = arg_233_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_233_1.leftNameTxt_.transform)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1.leftNameTxt_.text)
				SetActive(arg_233_1.iconTrs_.gameObject, false)
				arg_233_1.callingController_:SetSelectedState("normal")

				local var_236_26 = arg_233_1:GetWordFromCfg(1109703056)
				local var_236_27 = arg_233_1:FormatText(var_236_26.content)

				arg_233_1.text_.text = var_236_27

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_29 = 25 <= 0 and var_236_24 or var_236_24 * (utf8.len(var_236_27) / 25)

				if (25 <= 0 and var_236_24 or var_236_24 * (utf8.len(var_236_27) / 25)) > 0 and var_236_24 < var_236_29 then
					arg_233_1.talkMaxDuration = var_236_29
					var_236_23 = var_236_23 + 0.3

					if var_236_29 + var_236_23 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_29 + var_236_23
					end
				end

				arg_233_1.text_.text = var_236_27
				arg_233_1.typewritter.percent = 0

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703056", "story_v_side_new_1109703.awb") ~= 0 then
					local var_236_30 = manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703056", "story_v_side_new_1109703.awb") / 1000

					if var_236_30 + var_236_23 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_30 + var_236_23
					end

					if var_236_26.prefab_name ~= "" and arg_233_1.actors_[var_236_26.prefab_name] ~= nil then
						local var_236_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_233_1.actors_[var_236_26.prefab_name].transform, "story_v_side_new_1109703", "1109703056", "story_v_side_new_1109703.awb")

						arg_233_1:RecordAudio("1109703056", var_236_31)
						arg_233_1:RecordAudio("1109703056", var_236_31)
					else
						arg_233_1:AudioAction("play", "voice", "story_v_side_new_1109703", "1109703056", "story_v_side_new_1109703.awb")
					end

					arg_233_1:RecordHistoryTalkVoice("story_v_side_new_1109703", "1109703056", "story_v_side_new_1109703.awb")
				end

				arg_233_1:RecordContent(arg_233_1.text_.text)
			end

			local var_236_32 = var_236_23 + 0.3
			local var_236_33 = math.max(var_236_24, arg_233_1.talkMaxDuration)

			if var_236_23 + 0.3 <= arg_233_1.time_ and arg_233_1.time_ < var_236_32 + var_236_33 then
				arg_233_1.typewritter.percent = (arg_233_1.time_ - var_236_32) / var_236_33

				arg_233_1.typewritter:SetDirty()
			end

			if arg_233_1.time_ >= var_236_32 + var_236_33 and arg_233_1.time_ < var_236_32 + var_236_33 + arg_236_0 then
				arg_233_1.typewritter.percent = 1

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(true)
			end
		end

		arg_233_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_233_1:InitPlayNodeList()
	end,
	Play1109703057 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 1109703057
		arg_239_1.duration_ = 14.47

		local var_239_0 = {
			zh = 10.166,
			ja = 14.466
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
				arg_239_0:Play1109703058(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 then
				arg_239_1.var_.moveOldPos1084ui_story = arg_239_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_242_0 = 0.001

			if 0 <= arg_239_1.time_ and arg_239_1.time_ < 0 + var_242_0 then
				arg_239_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_239_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_239_1.time_ - 0) / var_242_0)
				arg_239_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_239_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_239_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_239_1.actors_["1084ui_story"].transform.position).z)
				arg_239_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_239_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_239_1.actors_["1084ui_story"].transform.localEulerAngles = arg_239_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_239_1.time_ >= 0 + var_242_0 and arg_239_1.time_ < 0 + var_242_0 + arg_242_0 then
				arg_239_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_239_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_239_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_239_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_239_1.actors_["1084ui_story"].transform.position).z)
				arg_239_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_239_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_239_1.actors_["1084ui_story"].transform.localEulerAngles = arg_239_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_242_1 = arg_239_1.actors_["1084ui_story"]

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 and not isNil(var_242_1) and arg_239_1.var_.characterEffect1084ui_story == nil then
				arg_239_1.var_.characterEffect1084ui_story = var_242_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_242_2 = 0.200000002980232

			if 0 <= arg_239_1.time_ and arg_239_1.time_ < 0 + var_242_2 and not isNil(var_242_1) then
				if arg_239_1.var_.characterEffect1084ui_story and not isNil(var_242_1) then
					arg_239_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_239_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_239_1.time_ - 0) / var_242_2)
				end
			end

			if arg_239_1.time_ >= 0 + var_242_2 and arg_239_1.time_ < 0 + var_242_2 + arg_242_0 and not isNil(var_242_1) and arg_239_1.var_.characterEffect1084ui_story then
				arg_239_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_239_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_242_3 = "1011ui_story"

			if arg_239_1.actors_["1011ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1011ui_story"))) then
				local var_242_4 = Object.Instantiate(Asset.Load("Char/" .. "1011ui_story"), arg_239_1.stage_.transform)

				var_242_4.name = var_242_3
				var_242_4.transform.localPosition = Vector3.New(0, 100, 0)
				arg_239_1.actors_[var_242_3] = var_242_4

				local var_242_5 = var_242_4:GetComponentInChildren(typeof(CharacterEffect))

				var_242_5.enabled = true

				local var_242_6 = GameObjectTools.GetOrAddComponent(var_242_4, typeof(DynamicBoneHelper))

				if var_242_6 then
					var_242_6:EnableDynamicBone(false)
				end

				arg_239_1:ShowWeapon(var_242_5.transform, false)

				arg_239_1.var_[var_242_3 .. "Animator"] = var_242_5.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_239_1.var_[var_242_3 .. "Animator"].applyRootMotion = true
				arg_239_1.var_[var_242_3 .. "LipSync"] = var_242_5.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_242_7 = arg_239_1.actors_["1011ui_story"].transform

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 then
				arg_239_1.var_.moveOldPos1011ui_story = var_242_7.localPosition
			end

			local var_242_8 = 0.001

			if 0 <= arg_239_1.time_ and arg_239_1.time_ < 0 + var_242_8 then
				var_242_7.localPosition = Vector3.Lerp(arg_239_1.var_.moveOldPos1011ui_story, Vector3.New(0, -0.71, -6), (arg_239_1.time_ - 0) / var_242_8)
				var_242_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_242_7.position).x, (manager.ui.mainCamera.transform.position - var_242_7.position).y, (manager.ui.mainCamera.transform.position - var_242_7.position).z)
				var_242_7.localEulerAngles.z = 0
				var_242_7.localEulerAngles.x = 0
				var_242_7.localEulerAngles = var_242_7.localEulerAngles
			end

			if arg_239_1.time_ >= 0 + var_242_8 and arg_239_1.time_ < 0 + var_242_8 + arg_242_0 then
				var_242_7.localPosition = Vector3.New(0, -0.71, -6)
				var_242_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_242_7.position).x, (manager.ui.mainCamera.transform.position - var_242_7.position).y, (manager.ui.mainCamera.transform.position - var_242_7.position).z)
				var_242_7.localEulerAngles.z = 0
				var_242_7.localEulerAngles.x = 0
				var_242_7.localEulerAngles = var_242_7.localEulerAngles
			end

			local var_242_9 = arg_239_1.actors_["1011ui_story"]

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 and not isNil(var_242_9) and arg_239_1.var_.characterEffect1011ui_story == nil then
				arg_239_1.var_.characterEffect1011ui_story = var_242_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_242_10 = 0.200000002980232

			if 0 <= arg_239_1.time_ and arg_239_1.time_ < 0 + var_242_10 and not isNil(var_242_9) then
				if arg_239_1.var_.characterEffect1011ui_story and not isNil(var_242_9) then
					arg_239_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_239_1.time_ >= 0 + var_242_10 and arg_239_1.time_ < 0 + var_242_10 + arg_242_0 and not isNil(var_242_9) and arg_239_1.var_.characterEffect1011ui_story then
				arg_239_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 then
				arg_239_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action3_1")
			end

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 then
				arg_239_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 then
				if arg_239_1.var_.characterEffect1011ui_story == nil then
					arg_239_1.var_.characterEffect1011ui_story = arg_239_1.actors_["1011ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_242_12 = arg_239_1.var_.characterEffect1011ui_story

				arg_239_1.var_.characterEffect1011ui_story.imageEffect:turnOff()

				var_242_12.interferenceEffect.enabled = true
				var_242_12.interferenceEffect.noise = 0.001
				var_242_12.interferenceEffect.simTimeScale = 1
				var_242_12.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 then
				if arg_239_1.var_.characterEffect1011ui_story == nil then
					arg_239_1.var_.characterEffect1011ui_story = arg_239_1.actors_["1011ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_239_1.var_.characterEffect1011ui_story.imageEffect:turnOn(false)
			end

			local var_242_14 = 0
			local var_242_15 = 1.325

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= var_242_14 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0
				arg_239_1.dialogCg_.alpha = 1

				arg_239_1.dialog_:SetActive(true)
				SetActive(arg_239_1.leftNameGo_, true)

				arg_239_1.leftNameTxt_.text = arg_239_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_239_1.leftNameTxt_.transform)

				arg_239_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_239_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_239_1:RecordName(arg_239_1.leftNameTxt_.text)
				SetActive(arg_239_1.iconTrs_.gameObject, false)
				arg_239_1.callingController_:SetSelectedState("normal")

				local var_242_16 = arg_239_1:GetWordFromCfg(1109703057)
				local var_242_17 = arg_239_1:FormatText(var_242_16.content)

				arg_239_1.text_.text = var_242_17

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_19 = 53 <= 0 and var_242_15 or var_242_15 * (utf8.len(var_242_17) / 53)

				if (53 <= 0 and var_242_15 or var_242_15 * (utf8.len(var_242_17) / 53)) > 0 and var_242_15 < var_242_19 then
					arg_239_1.talkMaxDuration = var_242_19

					if var_242_19 + var_242_14 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_19 + var_242_14
					end
				end

				arg_239_1.text_.text = var_242_17
				arg_239_1.typewritter.percent = 0

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703057", "story_v_side_new_1109703.awb") ~= 0 then
					local var_242_20 = manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703057", "story_v_side_new_1109703.awb") / 1000

					if var_242_20 + var_242_14 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_20 + var_242_14
					end

					if var_242_16.prefab_name ~= "" and arg_239_1.actors_[var_242_16.prefab_name] ~= nil then
						local var_242_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_239_1.actors_[var_242_16.prefab_name].transform, "story_v_side_new_1109703", "1109703057", "story_v_side_new_1109703.awb")

						arg_239_1:RecordAudio("1109703057", var_242_21)
						arg_239_1:RecordAudio("1109703057", var_242_21)
					else
						arg_239_1:AudioAction("play", "voice", "story_v_side_new_1109703", "1109703057", "story_v_side_new_1109703.awb")
					end

					arg_239_1:RecordHistoryTalkVoice("story_v_side_new_1109703", "1109703057", "story_v_side_new_1109703.awb")
				end

				arg_239_1:RecordContent(arg_239_1.text_.text)
			end

			local var_242_22 = math.max(var_242_15, arg_239_1.talkMaxDuration)

			if var_242_14 <= arg_239_1.time_ and arg_239_1.time_ < var_242_14 + var_242_22 then
				arg_239_1.typewritter.percent = (arg_239_1.time_ - var_242_14) / var_242_22

				arg_239_1.typewritter:SetDirty()
			end

			if arg_239_1.time_ >= var_242_14 + var_242_22 and arg_239_1.time_ < var_242_14 + var_242_22 + arg_242_0 then
				arg_239_1.typewritter.percent = 1

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(true)
			end
		end

		arg_239_1.nodeConfigList_ = {
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
				actorName = "1011ui_story",
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
	Play1109703058 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 1109703058
		arg_243_1.duration_ = 8

		local var_243_0 = {
			zh = 8,
			ja = 6.866
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
				arg_243_0:Play1109703059(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 then
				arg_243_1.var_.moveOldPos1011ui_story = arg_243_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_246_0 = 0.001

			if 0 <= arg_243_1.time_ and arg_243_1.time_ < 0 + var_246_0 then
				arg_243_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_243_1.var_.moveOldPos1011ui_story, Vector3.New(0, 100, 0), (arg_243_1.time_ - 0) / var_246_0)
				arg_243_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_243_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_243_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_243_1.actors_["1011ui_story"].transform.position).z)
				arg_243_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_243_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_243_1.actors_["1011ui_story"].transform.localEulerAngles = arg_243_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_243_1.time_ >= 0 + var_246_0 and arg_243_1.time_ < 0 + var_246_0 + arg_246_0 then
				arg_243_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_243_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_243_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_243_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_243_1.actors_["1011ui_story"].transform.position).z)
				arg_243_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_243_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_243_1.actors_["1011ui_story"].transform.localEulerAngles = arg_243_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_246_1 = arg_243_1.actors_["1011ui_story"]

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 and not isNil(var_246_1) and arg_243_1.var_.characterEffect1011ui_story == nil then
				arg_243_1.var_.characterEffect1011ui_story = var_246_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_246_2 = 0.200000002980232

			if 0 <= arg_243_1.time_ and arg_243_1.time_ < 0 + var_246_2 and not isNil(var_246_1) then
				if arg_243_1.var_.characterEffect1011ui_story and not isNil(var_246_1) then
					arg_243_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_243_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_243_1.time_ - 0) / var_246_2)
				end
			end

			if arg_243_1.time_ >= 0 + var_246_2 and arg_243_1.time_ < 0 + var_246_2 + arg_246_0 and not isNil(var_246_1) and arg_243_1.var_.characterEffect1011ui_story then
				arg_243_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_243_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			local var_246_3 = "1037ui_story"

			if arg_243_1.actors_["1037ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1037ui_story"))) then
				local var_246_4 = Object.Instantiate(Asset.Load("Char/" .. "1037ui_story"), arg_243_1.stage_.transform)

				var_246_4.name = var_246_3
				var_246_4.transform.localPosition = Vector3.New(0, 100, 0)
				arg_243_1.actors_[var_246_3] = var_246_4

				local var_246_5 = var_246_4:GetComponentInChildren(typeof(CharacterEffect))

				var_246_5.enabled = true

				local var_246_6 = GameObjectTools.GetOrAddComponent(var_246_4, typeof(DynamicBoneHelper))

				if var_246_6 then
					var_246_6:EnableDynamicBone(false)
				end

				arg_243_1:ShowWeapon(var_246_5.transform, false)

				arg_243_1.var_[var_246_3 .. "Animator"] = var_246_5.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_243_1.var_[var_246_3 .. "Animator"].applyRootMotion = true
				arg_243_1.var_[var_246_3 .. "LipSync"] = var_246_5.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_246_7 = arg_243_1.actors_["1037ui_story"].transform

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 then
				arg_243_1.var_.moveOldPos1037ui_story = var_246_7.localPosition
			end

			local var_246_8 = 0.001

			if 0 <= arg_243_1.time_ and arg_243_1.time_ < 0 + var_246_8 then
				var_246_7.localPosition = Vector3.Lerp(arg_243_1.var_.moveOldPos1037ui_story, Vector3.New(0, -1.09, -5.81), (arg_243_1.time_ - 0) / var_246_8)
				var_246_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_246_7.position).x, (manager.ui.mainCamera.transform.position - var_246_7.position).y, (manager.ui.mainCamera.transform.position - var_246_7.position).z)
				var_246_7.localEulerAngles.z = 0
				var_246_7.localEulerAngles.x = 0
				var_246_7.localEulerAngles = var_246_7.localEulerAngles
			end

			if arg_243_1.time_ >= 0 + var_246_8 and arg_243_1.time_ < 0 + var_246_8 + arg_246_0 then
				var_246_7.localPosition = Vector3.New(0, -1.09, -5.81)
				var_246_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_246_7.position).x, (manager.ui.mainCamera.transform.position - var_246_7.position).y, (manager.ui.mainCamera.transform.position - var_246_7.position).z)
				var_246_7.localEulerAngles.z = 0
				var_246_7.localEulerAngles.x = 0
				var_246_7.localEulerAngles = var_246_7.localEulerAngles
			end

			local var_246_9 = arg_243_1.actors_["1037ui_story"]

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 and not isNil(var_246_9) and arg_243_1.var_.characterEffect1037ui_story == nil then
				arg_243_1.var_.characterEffect1037ui_story = var_246_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_246_10 = 0.200000002980232

			if 0 <= arg_243_1.time_ and arg_243_1.time_ < 0 + var_246_10 and not isNil(var_246_9) then
				if arg_243_1.var_.characterEffect1037ui_story and not isNil(var_246_9) then
					arg_243_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_243_1.time_ >= 0 + var_246_10 and arg_243_1.time_ < 0 + var_246_10 + arg_246_0 and not isNil(var_246_9) and arg_243_1.var_.characterEffect1037ui_story then
				arg_243_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 then
				arg_243_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/story1037/story1037action/1037action1_1")
			end

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 then
				arg_243_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 then
				if arg_243_1.var_.characterEffect1037ui_story == nil then
					arg_243_1.var_.characterEffect1037ui_story = arg_243_1.actors_["1037ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_246_12 = arg_243_1.var_.characterEffect1037ui_story

				arg_243_1.var_.characterEffect1037ui_story.imageEffect:turnOff()

				var_246_12.interferenceEffect.enabled = true
				var_246_12.interferenceEffect.noise = 0.001
				var_246_12.interferenceEffect.simTimeScale = 1
				var_246_12.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 then
				if arg_243_1.var_.characterEffect1037ui_story == nil then
					arg_243_1.var_.characterEffect1037ui_story = arg_243_1.actors_["1037ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_243_1.var_.characterEffect1037ui_story.imageEffect:turnOn(false)
			end

			local var_246_14 = 0
			local var_246_15 = 0.9

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= var_246_14 + arg_246_0 then
				arg_243_1.talkMaxDuration = 0
				arg_243_1.dialogCg_.alpha = 1

				arg_243_1.dialog_:SetActive(true)
				SetActive(arg_243_1.leftNameGo_, true)

				arg_243_1.leftNameTxt_.text = arg_243_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_243_1.leftNameTxt_.transform)

				arg_243_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_243_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_243_1:RecordName(arg_243_1.leftNameTxt_.text)
				SetActive(arg_243_1.iconTrs_.gameObject, false)
				arg_243_1.callingController_:SetSelectedState("normal")

				local var_246_16 = arg_243_1:GetWordFromCfg(1109703058)
				local var_246_17 = arg_243_1:FormatText(var_246_16.content)

				arg_243_1.text_.text = var_246_17

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_19 = 36 <= 0 and var_246_15 or var_246_15 * (utf8.len(var_246_17) / 36)

				if (36 <= 0 and var_246_15 or var_246_15 * (utf8.len(var_246_17) / 36)) > 0 and var_246_15 < var_246_19 then
					arg_243_1.talkMaxDuration = var_246_19

					if var_246_19 + var_246_14 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_19 + var_246_14
					end
				end

				arg_243_1.text_.text = var_246_17
				arg_243_1.typewritter.percent = 0

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703058", "story_v_side_new_1109703.awb") ~= 0 then
					local var_246_20 = manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703058", "story_v_side_new_1109703.awb") / 1000

					if var_246_20 + var_246_14 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_20 + var_246_14
					end

					if var_246_16.prefab_name ~= "" and arg_243_1.actors_[var_246_16.prefab_name] ~= nil then
						local var_246_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_243_1.actors_[var_246_16.prefab_name].transform, "story_v_side_new_1109703", "1109703058", "story_v_side_new_1109703.awb")

						arg_243_1:RecordAudio("1109703058", var_246_21)
						arg_243_1:RecordAudio("1109703058", var_246_21)
					else
						arg_243_1:AudioAction("play", "voice", "story_v_side_new_1109703", "1109703058", "story_v_side_new_1109703.awb")
					end

					arg_243_1:RecordHistoryTalkVoice("story_v_side_new_1109703", "1109703058", "story_v_side_new_1109703.awb")
				end

				arg_243_1:RecordContent(arg_243_1.text_.text)
			end

			local var_246_22 = math.max(var_246_15, arg_243_1.talkMaxDuration)

			if var_246_14 <= arg_243_1.time_ and arg_243_1.time_ < var_246_14 + var_246_22 then
				arg_243_1.typewritter.percent = (arg_243_1.time_ - var_246_14) / var_246_22

				arg_243_1.typewritter:SetDirty()
			end

			if arg_243_1.time_ >= var_246_14 + var_246_22 and arg_243_1.time_ < var_246_14 + var_246_22 + arg_246_0 then
				arg_243_1.typewritter.percent = 1

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(true)
			end
		end

		arg_243_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_243_1:InitPlayNodeList()
	end,
	Play1109703059 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 1109703059
		arg_247_1.duration_ = 3.97

		local var_247_0 = {
			zh = 2.933,
			ja = 3.966
		}
		local var_247_1 = manager.audio:GetLocalizationFlag()

		if var_247_0[var_247_1] ~= nil then
			arg_247_1.duration_ = var_247_0[var_247_1]
		end

		SetActive(arg_247_1.tipsGo_, false)

		function arg_247_1.onSingleLineFinish_()
			arg_247_1.onSingleLineUpdate_ = nil
			arg_247_1.onSingleLineFinish_ = nil
			arg_247_1.state_ = "waiting"
		end

		function arg_247_1.playNext_(arg_249_0)
			if arg_249_0 == 1 then
				arg_247_0:Play1109703060(arg_247_1)
			end
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 then
				arg_247_1.var_.moveOldPos1037ui_story = arg_247_1.actors_["1037ui_story"].transform.localPosition
			end

			local var_250_0 = 0.001

			if 0 <= arg_247_1.time_ and arg_247_1.time_ < 0 + var_250_0 then
				arg_247_1.actors_["1037ui_story"].transform.localPosition = Vector3.Lerp(arg_247_1.var_.moveOldPos1037ui_story, Vector3.New(0, 100, 0), (arg_247_1.time_ - 0) / var_250_0)
				arg_247_1.actors_["1037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_247_1.actors_["1037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_247_1.actors_["1037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_247_1.actors_["1037ui_story"].transform.position).z)
				arg_247_1.actors_["1037ui_story"].transform.localEulerAngles.z = 0
				arg_247_1.actors_["1037ui_story"].transform.localEulerAngles.x = 0
				arg_247_1.actors_["1037ui_story"].transform.localEulerAngles = arg_247_1.actors_["1037ui_story"].transform.localEulerAngles
			end

			if arg_247_1.time_ >= 0 + var_250_0 and arg_247_1.time_ < 0 + var_250_0 + arg_250_0 then
				arg_247_1.actors_["1037ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_247_1.actors_["1037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_247_1.actors_["1037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_247_1.actors_["1037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_247_1.actors_["1037ui_story"].transform.position).z)
				arg_247_1.actors_["1037ui_story"].transform.localEulerAngles.z = 0
				arg_247_1.actors_["1037ui_story"].transform.localEulerAngles.x = 0
				arg_247_1.actors_["1037ui_story"].transform.localEulerAngles = arg_247_1.actors_["1037ui_story"].transform.localEulerAngles
			end

			local var_250_1 = arg_247_1.actors_["1037ui_story"]

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 and not isNil(var_250_1) and arg_247_1.var_.characterEffect1037ui_story == nil then
				arg_247_1.var_.characterEffect1037ui_story = var_250_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_250_2 = 0.200000002980232

			if 0 <= arg_247_1.time_ and arg_247_1.time_ < 0 + var_250_2 and not isNil(var_250_1) then
				if arg_247_1.var_.characterEffect1037ui_story and not isNil(var_250_1) then
					arg_247_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_247_1.var_.characterEffect1037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_247_1.time_ - 0) / var_250_2)
				end
			end

			if arg_247_1.time_ >= 0 + var_250_2 and arg_247_1.time_ < 0 + var_250_2 + arg_250_0 and not isNil(var_250_1) and arg_247_1.var_.characterEffect1037ui_story then
				arg_247_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_247_1.var_.characterEffect1037ui_story.fillRatio = 0.5
			end

			local var_250_3 = arg_247_1.actors_["1097ui_story"].transform

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 then
				arg_247_1.var_.moveOldPos1097ui_story = var_250_3.localPosition
			end

			local var_250_4 = 0.001

			if 0 <= arg_247_1.time_ and arg_247_1.time_ < 0 + var_250_4 then
				var_250_3.localPosition = Vector3.Lerp(arg_247_1.var_.moveOldPos1097ui_story, Vector3.New(0, -0.54, -6.3), (arg_247_1.time_ - 0) / var_250_4)
				var_250_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_250_3.position).x, (manager.ui.mainCamera.transform.position - var_250_3.position).y, (manager.ui.mainCamera.transform.position - var_250_3.position).z)
				var_250_3.localEulerAngles.z = 0
				var_250_3.localEulerAngles.x = 0
				var_250_3.localEulerAngles = var_250_3.localEulerAngles
			end

			if arg_247_1.time_ >= 0 + var_250_4 and arg_247_1.time_ < 0 + var_250_4 + arg_250_0 then
				var_250_3.localPosition = Vector3.New(0, -0.54, -6.3)
				var_250_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_250_3.position).x, (manager.ui.mainCamera.transform.position - var_250_3.position).y, (manager.ui.mainCamera.transform.position - var_250_3.position).z)
				var_250_3.localEulerAngles.z = 0
				var_250_3.localEulerAngles.x = 0
				var_250_3.localEulerAngles = var_250_3.localEulerAngles
			end

			local var_250_5 = arg_247_1.actors_["1097ui_story"]

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 and not isNil(var_250_5) and arg_247_1.var_.characterEffect1097ui_story == nil then
				arg_247_1.var_.characterEffect1097ui_story = var_250_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_250_6 = 0.200000002980232

			if 0 <= arg_247_1.time_ and arg_247_1.time_ < 0 + var_250_6 and not isNil(var_250_5) then
				if arg_247_1.var_.characterEffect1097ui_story and not isNil(var_250_5) then
					arg_247_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_247_1.time_ >= 0 + var_250_6 and arg_247_1.time_ < 0 + var_250_6 + arg_250_0 and not isNil(var_250_5) and arg_247_1.var_.characterEffect1097ui_story then
				arg_247_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 then
				arg_247_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action7_1")
			end

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 then
				arg_247_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_250_8 = 0
			local var_250_9 = 0.275

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= var_250_8 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0
				arg_247_1.dialogCg_.alpha = 1

				arg_247_1.dialog_:SetActive(true)
				SetActive(arg_247_1.leftNameGo_, true)

				arg_247_1.leftNameTxt_.text = arg_247_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_247_1.leftNameTxt_.transform)

				arg_247_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_247_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_247_1:RecordName(arg_247_1.leftNameTxt_.text)
				SetActive(arg_247_1.iconTrs_.gameObject, false)
				arg_247_1.callingController_:SetSelectedState("normal")

				local var_250_10 = arg_247_1:GetWordFromCfg(1109703059)
				local var_250_11 = arg_247_1:FormatText(var_250_10.content)

				arg_247_1.text_.text = var_250_11

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_13 = 11 <= 0 and var_250_9 or var_250_9 * (utf8.len(var_250_11) / 11)

				if (11 <= 0 and var_250_9 or var_250_9 * (utf8.len(var_250_11) / 11)) > 0 and var_250_9 < var_250_13 then
					arg_247_1.talkMaxDuration = var_250_13

					if var_250_13 + var_250_8 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_13 + var_250_8
					end
				end

				arg_247_1.text_.text = var_250_11
				arg_247_1.typewritter.percent = 0

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703059", "story_v_side_new_1109703.awb") ~= 0 then
					local var_250_14 = manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703059", "story_v_side_new_1109703.awb") / 1000

					if var_250_14 + var_250_8 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_14 + var_250_8
					end

					if var_250_10.prefab_name ~= "" and arg_247_1.actors_[var_250_10.prefab_name] ~= nil then
						local var_250_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_247_1.actors_[var_250_10.prefab_name].transform, "story_v_side_new_1109703", "1109703059", "story_v_side_new_1109703.awb")

						arg_247_1:RecordAudio("1109703059", var_250_15)
						arg_247_1:RecordAudio("1109703059", var_250_15)
					else
						arg_247_1:AudioAction("play", "voice", "story_v_side_new_1109703", "1109703059", "story_v_side_new_1109703.awb")
					end

					arg_247_1:RecordHistoryTalkVoice("story_v_side_new_1109703", "1109703059", "story_v_side_new_1109703.awb")
				end

				arg_247_1:RecordContent(arg_247_1.text_.text)
			end

			local var_250_16 = math.max(var_250_9, arg_247_1.talkMaxDuration)

			if var_250_8 <= arg_247_1.time_ and arg_247_1.time_ < var_250_8 + var_250_16 then
				arg_247_1.typewritter.percent = (arg_247_1.time_ - var_250_8) / var_250_16

				arg_247_1.typewritter:SetDirty()
			end

			if arg_247_1.time_ >= var_250_8 + var_250_16 and arg_247_1.time_ < var_250_8 + var_250_16 + arg_250_0 then
				arg_247_1.typewritter.percent = 1

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(true)
			end
		end

		arg_247_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1097ui_story",
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
	Play1109703060 = function(arg_251_0, arg_251_1)
		arg_251_1.time_ = 0
		arg_251_1.frameCnt_ = 0
		arg_251_1.state_ = "playing"
		arg_251_1.curTalkId_ = 1109703060
		arg_251_1.duration_ = 5

		SetActive(arg_251_1.tipsGo_, false)

		function arg_251_1.onSingleLineFinish_()
			arg_251_1.onSingleLineUpdate_ = nil
			arg_251_1.onSingleLineFinish_ = nil
			arg_251_1.state_ = "waiting"
		end

		function arg_251_1.playNext_(arg_253_0)
			if arg_253_0 == 1 then
				arg_251_0:Play1109703061(arg_251_1)
			end
		end

		function arg_251_1.onSingleLineUpdate_(arg_254_0)
			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 and not isNil(arg_251_1.actors_["1097ui_story"]) and arg_251_1.var_.characterEffect1097ui_story == nil then
				arg_251_1.var_.characterEffect1097ui_story = arg_251_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_254_0 = 0.200000002980232

			if 0 <= arg_251_1.time_ and arg_251_1.time_ < 0 + var_254_0 and not isNil(arg_251_1.actors_["1097ui_story"]) then
				if arg_251_1.var_.characterEffect1097ui_story and not isNil(arg_251_1.actors_["1097ui_story"]) then
					arg_251_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_251_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_251_1.time_ - 0) / var_254_0)
				end
			end

			if arg_251_1.time_ >= 0 + var_254_0 and arg_251_1.time_ < 0 + var_254_0 + arg_254_0 and not isNil(arg_251_1.actors_["1097ui_story"]) and arg_251_1.var_.characterEffect1097ui_story then
				arg_251_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_251_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_254_1 = 0
			local var_254_2 = 0.4

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= var_254_1 + arg_254_0 then
				arg_251_1.talkMaxDuration = 0
				arg_251_1.dialogCg_.alpha = 1

				arg_251_1.dialog_:SetActive(true)
				SetActive(arg_251_1.leftNameGo_, true)

				arg_251_1.leftNameTxt_.text = arg_251_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_251_1.leftNameTxt_.transform)

				arg_251_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_251_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_251_1:RecordName(arg_251_1.leftNameTxt_.text)
				SetActive(arg_251_1.iconTrs_.gameObject, true)
				arg_251_1.iconController_:SetSelectedState("hero")

				arg_251_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_251_1.callingController_:SetSelectedState("normal")

				arg_251_1.keyicon_.color = Color.New(1, 1, 1)
				arg_251_1.icon_.color = Color.New(1, 1, 1)

				local var_254_3 = arg_251_1:FormatText(arg_251_1:GetWordFromCfg(1109703060).content)

				arg_251_1.text_.text = var_254_3

				LuaForUtil.ClearLinePrefixSymbol(arg_251_1.text_)

				local var_254_5 = 16 <= 0 and var_254_2 or var_254_2 * (utf8.len(var_254_3) / 16)

				if (16 <= 0 and var_254_2 or var_254_2 * (utf8.len(var_254_3) / 16)) > 0 and var_254_2 < var_254_5 then
					arg_251_1.talkMaxDuration = var_254_5

					if var_254_5 + var_254_1 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_5 + var_254_1
					end
				end

				arg_251_1.text_.text = var_254_3
				arg_251_1.typewritter.percent = 0

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(false)
				arg_251_1:RecordContent(arg_251_1.text_.text)
			end

			local var_254_6 = math.max(var_254_2, arg_251_1.talkMaxDuration)

			if var_254_1 <= arg_251_1.time_ and arg_251_1.time_ < var_254_1 + var_254_6 then
				arg_251_1.typewritter.percent = (arg_251_1.time_ - var_254_1) / var_254_6

				arg_251_1.typewritter:SetDirty()
			end

			if arg_251_1.time_ >= var_254_1 + var_254_6 and arg_251_1.time_ < var_254_1 + var_254_6 + arg_254_0 then
				arg_251_1.typewritter.percent = 1

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(true)
			end
		end

		arg_251_1.nodeConfigList_ = {}

		arg_251_1:InitPlayNodeList()
	end,
	Play1109703061 = function(arg_255_0, arg_255_1)
		arg_255_1.time_ = 0
		arg_255_1.frameCnt_ = 0
		arg_255_1.state_ = "playing"
		arg_255_1.curTalkId_ = 1109703061
		arg_255_1.duration_ = 8.27

		local var_255_0 = {
			zh = 6.033,
			ja = 8.266
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
				arg_255_0:Play1109703062(arg_255_1)
			end
		end

		function arg_255_1.onSingleLineUpdate_(arg_258_0)
			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 and not isNil(arg_255_1.actors_["1097ui_story"]) and arg_255_1.var_.characterEffect1097ui_story == nil then
				arg_255_1.var_.characterEffect1097ui_story = arg_255_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_258_0 = 0.200000002980232

			if 0 <= arg_255_1.time_ and arg_255_1.time_ < 0 + var_258_0 and not isNil(arg_255_1.actors_["1097ui_story"]) then
				if arg_255_1.var_.characterEffect1097ui_story and not isNil(arg_255_1.actors_["1097ui_story"]) then
					arg_255_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_255_1.time_ >= 0 + var_258_0 and arg_255_1.time_ < 0 + var_258_0 + arg_258_0 and not isNil(arg_255_1.actors_["1097ui_story"]) and arg_255_1.var_.characterEffect1097ui_story then
				arg_255_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 then
				arg_255_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action7_2")
			end

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 then
				arg_255_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_258_2 = 0
			local var_258_3 = 0.6

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= var_258_2 + arg_258_0 then
				arg_255_1.talkMaxDuration = 0
				arg_255_1.dialogCg_.alpha = 1

				arg_255_1.dialog_:SetActive(true)
				SetActive(arg_255_1.leftNameGo_, true)

				arg_255_1.leftNameTxt_.text = arg_255_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_255_1.leftNameTxt_.transform)

				arg_255_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_255_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_255_1:RecordName(arg_255_1.leftNameTxt_.text)
				SetActive(arg_255_1.iconTrs_.gameObject, false)
				arg_255_1.callingController_:SetSelectedState("normal")

				local var_258_4 = arg_255_1:GetWordFromCfg(1109703061)
				local var_258_5 = arg_255_1:FormatText(var_258_4.content)

				arg_255_1.text_.text = var_258_5

				LuaForUtil.ClearLinePrefixSymbol(arg_255_1.text_)

				local var_258_7 = 24 <= 0 and var_258_3 or var_258_3 * (utf8.len(var_258_5) / 24)

				if (24 <= 0 and var_258_3 or var_258_3 * (utf8.len(var_258_5) / 24)) > 0 and var_258_3 < var_258_7 then
					arg_255_1.talkMaxDuration = var_258_7

					if var_258_7 + var_258_2 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_7 + var_258_2
					end
				end

				arg_255_1.text_.text = var_258_5
				arg_255_1.typewritter.percent = 0

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703061", "story_v_side_new_1109703.awb") ~= 0 then
					local var_258_8 = manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703061", "story_v_side_new_1109703.awb") / 1000

					if var_258_8 + var_258_2 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_8 + var_258_2
					end

					if var_258_4.prefab_name ~= "" and arg_255_1.actors_[var_258_4.prefab_name] ~= nil then
						local var_258_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_255_1.actors_[var_258_4.prefab_name].transform, "story_v_side_new_1109703", "1109703061", "story_v_side_new_1109703.awb")

						arg_255_1:RecordAudio("1109703061", var_258_9)
						arg_255_1:RecordAudio("1109703061", var_258_9)
					else
						arg_255_1:AudioAction("play", "voice", "story_v_side_new_1109703", "1109703061", "story_v_side_new_1109703.awb")
					end

					arg_255_1:RecordHistoryTalkVoice("story_v_side_new_1109703", "1109703061", "story_v_side_new_1109703.awb")
				end

				arg_255_1:RecordContent(arg_255_1.text_.text)
			end

			local var_258_10 = math.max(var_258_3, arg_255_1.talkMaxDuration)

			if var_258_2 <= arg_255_1.time_ and arg_255_1.time_ < var_258_2 + var_258_10 then
				arg_255_1.typewritter.percent = (arg_255_1.time_ - var_258_2) / var_258_10

				arg_255_1.typewritter:SetDirty()
			end

			if arg_255_1.time_ >= var_258_2 + var_258_10 and arg_255_1.time_ < var_258_2 + var_258_10 + arg_258_0 then
				arg_255_1.typewritter.percent = 1

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(true)
			end
		end

		arg_255_1.nodeConfigList_ = {}

		arg_255_1:InitPlayNodeList()
	end,
	Play1109703062 = function(arg_259_0, arg_259_1)
		arg_259_1.time_ = 0
		arg_259_1.frameCnt_ = 0
		arg_259_1.state_ = "playing"
		arg_259_1.curTalkId_ = 1109703062
		arg_259_1.duration_ = 5.37

		local var_259_0 = {
			zh = 2.7,
			ja = 5.366
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
				arg_259_0:Play1109703063(arg_259_1)
			end
		end

		function arg_259_1.onSingleLineUpdate_(arg_262_0)
			local var_262_0 = 0.25

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 then
				arg_259_1.talkMaxDuration = 0
				arg_259_1.dialogCg_.alpha = 1

				arg_259_1.dialog_:SetActive(true)
				SetActive(arg_259_1.leftNameGo_, true)

				arg_259_1.leftNameTxt_.text = arg_259_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_259_1.leftNameTxt_.transform)

				arg_259_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_259_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_259_1:RecordName(arg_259_1.leftNameTxt_.text)
				SetActive(arg_259_1.iconTrs_.gameObject, false)
				arg_259_1.callingController_:SetSelectedState("normal")

				local var_262_1 = arg_259_1:GetWordFromCfg(1109703062)
				local var_262_2 = arg_259_1:FormatText(var_262_1.content)

				arg_259_1.text_.text = var_262_2

				LuaForUtil.ClearLinePrefixSymbol(arg_259_1.text_)

				local var_262_4 = 10 <= 0 and var_262_0 or var_262_0 * (utf8.len(var_262_2) / 10)

				if (10 <= 0 and var_262_0 or var_262_0 * (utf8.len(var_262_2) / 10)) > 0 and var_262_0 < var_262_4 then
					arg_259_1.talkMaxDuration = var_262_4

					if var_262_4 + 0 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_4 + 0
					end
				end

				arg_259_1.text_.text = var_262_2
				arg_259_1.typewritter.percent = 0

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703062", "story_v_side_new_1109703.awb") ~= 0 then
					local var_262_5 = manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703062", "story_v_side_new_1109703.awb") / 1000

					if var_262_5 + 0 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_5 + 0
					end

					if var_262_1.prefab_name ~= "" and arg_259_1.actors_[var_262_1.prefab_name] ~= nil then
						local var_262_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_259_1.actors_[var_262_1.prefab_name].transform, "story_v_side_new_1109703", "1109703062", "story_v_side_new_1109703.awb")

						arg_259_1:RecordAudio("1109703062", var_262_6)
						arg_259_1:RecordAudio("1109703062", var_262_6)
					else
						arg_259_1:AudioAction("play", "voice", "story_v_side_new_1109703", "1109703062", "story_v_side_new_1109703.awb")
					end

					arg_259_1:RecordHistoryTalkVoice("story_v_side_new_1109703", "1109703062", "story_v_side_new_1109703.awb")
				end

				arg_259_1:RecordContent(arg_259_1.text_.text)
			end

			local var_262_7 = math.max(var_262_0, arg_259_1.talkMaxDuration)

			if 0 <= arg_259_1.time_ and arg_259_1.time_ < 0 + var_262_7 then
				arg_259_1.typewritter.percent = (arg_259_1.time_ - 0) / var_262_7

				arg_259_1.typewritter:SetDirty()
			end

			if arg_259_1.time_ >= 0 + var_262_7 and arg_259_1.time_ < 0 + var_262_7 + arg_262_0 then
				arg_259_1.typewritter.percent = 1

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(true)
			end
		end

		arg_259_1.nodeConfigList_ = {}

		arg_259_1:InitPlayNodeList()
	end,
	Play1109703063 = function(arg_263_0, arg_263_1)
		arg_263_1.time_ = 0
		arg_263_1.frameCnt_ = 0
		arg_263_1.state_ = "playing"
		arg_263_1.curTalkId_ = 1109703063
		arg_263_1.duration_ = 5

		SetActive(arg_263_1.tipsGo_, false)

		function arg_263_1.onSingleLineFinish_()
			arg_263_1.onSingleLineUpdate_ = nil
			arg_263_1.onSingleLineFinish_ = nil
			arg_263_1.state_ = "waiting"
		end

		function arg_263_1.playNext_(arg_265_0)
			if arg_265_0 == 1 then
				arg_263_0:Play1109703064(arg_263_1)
			end
		end

		function arg_263_1.onSingleLineUpdate_(arg_266_0)
			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 and not isNil(arg_263_1.actors_["1097ui_story"]) and arg_263_1.var_.characterEffect1097ui_story == nil then
				arg_263_1.var_.characterEffect1097ui_story = arg_263_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_266_0 = 0.200000002980232

			if 0 <= arg_263_1.time_ and arg_263_1.time_ < 0 + var_266_0 and not isNil(arg_263_1.actors_["1097ui_story"]) then
				if arg_263_1.var_.characterEffect1097ui_story and not isNil(arg_263_1.actors_["1097ui_story"]) then
					arg_263_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_263_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_263_1.time_ - 0) / var_266_0)
				end
			end

			if arg_263_1.time_ >= 0 + var_266_0 and arg_263_1.time_ < 0 + var_266_0 + arg_266_0 and not isNil(arg_263_1.actors_["1097ui_story"]) and arg_263_1.var_.characterEffect1097ui_story then
				arg_263_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_263_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_266_1 = 0
			local var_266_2 = 0.75

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= var_266_1 + arg_266_0 then
				arg_263_1.talkMaxDuration = 0
				arg_263_1.dialogCg_.alpha = 1

				arg_263_1.dialog_:SetActive(true)
				SetActive(arg_263_1.leftNameGo_, true)

				arg_263_1.leftNameTxt_.text = arg_263_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_263_1.leftNameTxt_.transform)

				arg_263_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_263_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_263_1:RecordName(arg_263_1.leftNameTxt_.text)
				SetActive(arg_263_1.iconTrs_.gameObject, true)
				arg_263_1.iconController_:SetSelectedState("hero")

				arg_263_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_263_1.callingController_:SetSelectedState("normal")

				arg_263_1.keyicon_.color = Color.New(1, 1, 1)
				arg_263_1.icon_.color = Color.New(1, 1, 1)

				local var_266_3 = arg_263_1:FormatText(arg_263_1:GetWordFromCfg(1109703063).content)

				arg_263_1.text_.text = var_266_3

				LuaForUtil.ClearLinePrefixSymbol(arg_263_1.text_)

				local var_266_5 = 30 <= 0 and var_266_2 or var_266_2 * (utf8.len(var_266_3) / 30)

				if (30 <= 0 and var_266_2 or var_266_2 * (utf8.len(var_266_3) / 30)) > 0 and var_266_2 < var_266_5 then
					arg_263_1.talkMaxDuration = var_266_5

					if var_266_5 + var_266_1 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_5 + var_266_1
					end
				end

				arg_263_1.text_.text = var_266_3
				arg_263_1.typewritter.percent = 0

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(false)
				arg_263_1:RecordContent(arg_263_1.text_.text)
			end

			local var_266_6 = math.max(var_266_2, arg_263_1.talkMaxDuration)

			if var_266_1 <= arg_263_1.time_ and arg_263_1.time_ < var_266_1 + var_266_6 then
				arg_263_1.typewritter.percent = (arg_263_1.time_ - var_266_1) / var_266_6

				arg_263_1.typewritter:SetDirty()
			end

			if arg_263_1.time_ >= var_266_1 + var_266_6 and arg_263_1.time_ < var_266_1 + var_266_6 + arg_266_0 then
				arg_263_1.typewritter.percent = 1

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(true)
			end
		end

		arg_263_1.nodeConfigList_ = {}

		arg_263_1:InitPlayNodeList()
	end,
	Play1109703064 = function(arg_267_0, arg_267_1)
		arg_267_1.time_ = 0
		arg_267_1.frameCnt_ = 0
		arg_267_1.state_ = "playing"
		arg_267_1.curTalkId_ = 1109703064
		arg_267_1.duration_ = 2.23

		local var_267_0 = {
			zh = 2.233,
			ja = 2.199999999999
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
				arg_267_0:Play1109703065(arg_267_1)
			end
		end

		function arg_267_1.onSingleLineUpdate_(arg_270_0)
			local var_270_9000

			if 0 < arg_267_1.time_ and arg_267_1.time_ <= 0 + arg_270_0 and not isNil(arg_267_1.actors_["1097ui_story"]) and arg_267_1.var_.characterEffect1097ui_story == nil then
				arg_267_1.var_.characterEffect1097ui_story = arg_267_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_270_0 = 0.200000002980232

			if 0 <= arg_267_1.time_ and arg_267_1.time_ < 0 + var_270_0 and not isNil(arg_267_1.actors_["1097ui_story"]) then
				if arg_267_1.var_.characterEffect1097ui_story and not isNil(arg_267_1.actors_["1097ui_story"]) then
					arg_267_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_267_1.time_ >= 0 + var_270_0 and arg_267_1.time_ < 0 + var_270_0 + arg_270_0 and not isNil(arg_267_1.actors_["1097ui_story"]) and arg_267_1.var_.characterEffect1097ui_story then
				arg_267_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_267_1.time_ and arg_267_1.time_ <= 0 + arg_270_0 then
				arg_267_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action5_1")
			end

			if 0 < arg_267_1.time_ and arg_267_1.time_ <= 0 + arg_270_0 then
				arg_267_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva")
			end

			if 0 < arg_267_1.time_ and arg_267_1.time_ <= 0 + arg_270_0 then
				local var_270_2 = arg_267_1.var_.effect1097ui_storykaixinxiaokun1

				if not arg_267_1.var_.effect1097ui_storykaixinxiaokun1 then
					var_270_2 = Object.Instantiate(Asset.Load("Effect/Hero/1097/fx_1097_story_smoke"), arg_267_1.actors_["1097ui_story"].transform)
					var_270_2.name = "kaixinxiaokun1"
					arg_267_1.var_.effect1097ui_storykaixinxiaokun1 = var_270_2
				else
					var_270_2.transform:SetParent(var_270_9000)
				end

				var_270_2.transform.localPosition = Vector3.New(0, 1.28, 0.3)
				var_270_2.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 2 < arg_267_1.time_ and arg_267_1.time_ <= 2 + arg_270_0 then
				if arg_267_1.var_.effect1097ui_storykaixinxiaokun1 then
					Object.Destroy(arg_267_1.var_.effect1097ui_storykaixinxiaokun1)

					arg_267_1.var_.effect1097ui_storykaixinxiaokun1 = nil
				end
			end

			local var_270_5 = 0
			local var_270_6 = 0.15

			if 0 < arg_267_1.time_ and arg_267_1.time_ <= var_270_5 + arg_270_0 then
				arg_267_1.talkMaxDuration = 0
				arg_267_1.dialogCg_.alpha = 1

				arg_267_1.dialog_:SetActive(true)
				SetActive(arg_267_1.leftNameGo_, true)

				arg_267_1.leftNameTxt_.text = arg_267_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_267_1.leftNameTxt_.transform)

				arg_267_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_267_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_267_1:RecordName(arg_267_1.leftNameTxt_.text)
				SetActive(arg_267_1.iconTrs_.gameObject, false)
				arg_267_1.callingController_:SetSelectedState("normal")

				local var_270_7 = arg_267_1:GetWordFromCfg(1109703064)
				local var_270_8 = arg_267_1:FormatText(var_270_7.content)

				arg_267_1.text_.text = var_270_8

				LuaForUtil.ClearLinePrefixSymbol(arg_267_1.text_)

				local var_270_10 = 6 <= 0 and var_270_6 or var_270_6 * (utf8.len(var_270_8) / 6)

				if (6 <= 0 and var_270_6 or var_270_6 * (utf8.len(var_270_8) / 6)) > 0 and var_270_6 < var_270_10 then
					arg_267_1.talkMaxDuration = var_270_10

					if var_270_10 + var_270_5 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_10 + var_270_5
					end
				end

				arg_267_1.text_.text = var_270_8
				arg_267_1.typewritter.percent = 0

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703064", "story_v_side_new_1109703.awb") ~= 0 then
					local var_270_11 = manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703064", "story_v_side_new_1109703.awb") / 1000

					if var_270_11 + var_270_5 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_11 + var_270_5
					end

					if var_270_7.prefab_name ~= "" and arg_267_1.actors_[var_270_7.prefab_name] ~= nil then
						local var_270_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_267_1.actors_[var_270_7.prefab_name].transform, "story_v_side_new_1109703", "1109703064", "story_v_side_new_1109703.awb")

						arg_267_1:RecordAudio("1109703064", var_270_12)
						arg_267_1:RecordAudio("1109703064", var_270_12)
					else
						arg_267_1:AudioAction("play", "voice", "story_v_side_new_1109703", "1109703064", "story_v_side_new_1109703.awb")
					end

					arg_267_1:RecordHistoryTalkVoice("story_v_side_new_1109703", "1109703064", "story_v_side_new_1109703.awb")
				end

				arg_267_1:RecordContent(arg_267_1.text_.text)
			end

			local var_270_13 = math.max(var_270_6, arg_267_1.talkMaxDuration)

			if var_270_5 <= arg_267_1.time_ and arg_267_1.time_ < var_270_5 + var_270_13 then
				arg_267_1.typewritter.percent = (arg_267_1.time_ - var_270_5) / var_270_13

				arg_267_1.typewritter:SetDirty()
			end

			if arg_267_1.time_ >= var_270_5 + var_270_13 and arg_267_1.time_ < var_270_5 + var_270_13 + arg_270_0 then
				arg_267_1.typewritter.percent = 1

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(true)
			end
		end

		arg_267_1.nodeConfigList_ = {}

		arg_267_1:InitPlayNodeList()
	end,
	Play1109703065 = function(arg_271_0, arg_271_1)
		arg_271_1.time_ = 0
		arg_271_1.frameCnt_ = 0
		arg_271_1.state_ = "playing"
		arg_271_1.curTalkId_ = 1109703065
		arg_271_1.duration_ = 5

		SetActive(arg_271_1.tipsGo_, false)

		function arg_271_1.onSingleLineFinish_()
			arg_271_1.onSingleLineUpdate_ = nil
			arg_271_1.onSingleLineFinish_ = nil
			arg_271_1.state_ = "waiting"
		end

		function arg_271_1.playNext_(arg_273_0)
			if arg_273_0 == 1 then
				arg_271_0:Play1109703066(arg_271_1)
			end
		end

		function arg_271_1.onSingleLineUpdate_(arg_274_0)
			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 and not isNil(arg_271_1.actors_["1097ui_story"]) and arg_271_1.var_.characterEffect1097ui_story == nil then
				arg_271_1.var_.characterEffect1097ui_story = arg_271_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_274_0 = 0.200000002980232

			if 0 <= arg_271_1.time_ and arg_271_1.time_ < 0 + var_274_0 and not isNil(arg_271_1.actors_["1097ui_story"]) then
				if arg_271_1.var_.characterEffect1097ui_story and not isNil(arg_271_1.actors_["1097ui_story"]) then
					arg_271_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_271_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_271_1.time_ - 0) / var_274_0)
				end
			end

			if arg_271_1.time_ >= 0 + var_274_0 and arg_271_1.time_ < 0 + var_274_0 + arg_274_0 and not isNil(arg_271_1.actors_["1097ui_story"]) and arg_271_1.var_.characterEffect1097ui_story then
				arg_271_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_271_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_274_1 = 0
			local var_274_2 = 0.775

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= var_274_1 + arg_274_0 then
				arg_271_1.talkMaxDuration = 0
				arg_271_1.dialogCg_.alpha = 1

				arg_271_1.dialog_:SetActive(true)
				SetActive(arg_271_1.leftNameGo_, false)

				arg_271_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_271_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_271_1:RecordName(arg_271_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_271_1.iconTrs_.gameObject, false)
				arg_271_1.callingController_:SetSelectedState("normal")

				local var_274_3 = arg_271_1:FormatText(arg_271_1:GetWordFromCfg(1109703065).content)

				arg_271_1.text_.text = var_274_3

				LuaForUtil.ClearLinePrefixSymbol(arg_271_1.text_)

				local var_274_5 = 31 <= 0 and var_274_2 or var_274_2 * (utf8.len(var_274_3) / 31)

				if (31 <= 0 and var_274_2 or var_274_2 * (utf8.len(var_274_3) / 31)) > 0 and var_274_2 < var_274_5 then
					arg_271_1.talkMaxDuration = var_274_5

					if var_274_5 + var_274_1 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_5 + var_274_1
					end
				end

				arg_271_1.text_.text = var_274_3
				arg_271_1.typewritter.percent = 0

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(false)
				arg_271_1:RecordContent(arg_271_1.text_.text)
			end

			local var_274_6 = math.max(var_274_2, arg_271_1.talkMaxDuration)

			if var_274_1 <= arg_271_1.time_ and arg_271_1.time_ < var_274_1 + var_274_6 then
				arg_271_1.typewritter.percent = (arg_271_1.time_ - var_274_1) / var_274_6

				arg_271_1.typewritter:SetDirty()
			end

			if arg_271_1.time_ >= var_274_1 + var_274_6 and arg_271_1.time_ < var_274_1 + var_274_6 + arg_274_0 then
				arg_271_1.typewritter.percent = 1

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(true)
			end
		end

		arg_271_1.nodeConfigList_ = {}

		arg_271_1:InitPlayNodeList()
	end,
	Play1109703066 = function(arg_275_0, arg_275_1)
		arg_275_1.time_ = 0
		arg_275_1.frameCnt_ = 0
		arg_275_1.state_ = "playing"
		arg_275_1.curTalkId_ = 1109703066
		arg_275_1.duration_ = 5

		SetActive(arg_275_1.tipsGo_, false)

		function arg_275_1.onSingleLineFinish_()
			arg_275_1.onSingleLineUpdate_ = nil
			arg_275_1.onSingleLineFinish_ = nil
			arg_275_1.state_ = "waiting"
		end

		function arg_275_1.playNext_(arg_277_0)
			if arg_277_0 == 1 then
				arg_275_0:Play1109703067(arg_275_1)
			end
		end

		function arg_275_1.onSingleLineUpdate_(arg_278_0)
			local var_278_0 = 0.45

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 then
				arg_275_1.talkMaxDuration = 0
				arg_275_1.dialogCg_.alpha = 1

				arg_275_1.dialog_:SetActive(true)
				SetActive(arg_275_1.leftNameGo_, true)

				arg_275_1.leftNameTxt_.text = arg_275_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_275_1.leftNameTxt_.transform)

				arg_275_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_275_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_275_1:RecordName(arg_275_1.leftNameTxt_.text)
				SetActive(arg_275_1.iconTrs_.gameObject, true)
				arg_275_1.iconController_:SetSelectedState("hero")

				arg_275_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_275_1.callingController_:SetSelectedState("normal")

				arg_275_1.keyicon_.color = Color.New(1, 1, 1)
				arg_275_1.icon_.color = Color.New(1, 1, 1)

				local var_278_1 = arg_275_1:FormatText(arg_275_1:GetWordFromCfg(1109703066).content)

				arg_275_1.text_.text = var_278_1

				LuaForUtil.ClearLinePrefixSymbol(arg_275_1.text_)

				local var_278_3 = 18 <= 0 and var_278_0 or var_278_0 * (utf8.len(var_278_1) / 18)

				if (18 <= 0 and var_278_0 or var_278_0 * (utf8.len(var_278_1) / 18)) > 0 and var_278_0 < var_278_3 then
					arg_275_1.talkMaxDuration = var_278_3

					if var_278_3 + 0 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_3 + 0
					end
				end

				arg_275_1.text_.text = var_278_1
				arg_275_1.typewritter.percent = 0

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(false)
				arg_275_1:RecordContent(arg_275_1.text_.text)
			end

			local var_278_4 = math.max(var_278_0, arg_275_1.talkMaxDuration)

			if 0 <= arg_275_1.time_ and arg_275_1.time_ < 0 + var_278_4 then
				arg_275_1.typewritter.percent = (arg_275_1.time_ - 0) / var_278_4

				arg_275_1.typewritter:SetDirty()
			end

			if arg_275_1.time_ >= 0 + var_278_4 and arg_275_1.time_ < 0 + var_278_4 + arg_278_0 then
				arg_275_1.typewritter.percent = 1

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(true)
			end
		end

		arg_275_1.nodeConfigList_ = {}

		arg_275_1:InitPlayNodeList()
	end,
	Play1109703067 = function(arg_279_0, arg_279_1)
		arg_279_1.time_ = 0
		arg_279_1.frameCnt_ = 0
		arg_279_1.state_ = "playing"
		arg_279_1.curTalkId_ = 1109703067
		arg_279_1.duration_ = 2.93

		local var_279_0 = {
			zh = 2.933,
			ja = 2.199999999999
		}
		local var_279_1 = manager.audio:GetLocalizationFlag()

		if var_279_0[var_279_1] ~= nil then
			arg_279_1.duration_ = var_279_0[var_279_1]
		end

		SetActive(arg_279_1.tipsGo_, false)

		function arg_279_1.onSingleLineFinish_()
			arg_279_1.onSingleLineUpdate_ = nil
			arg_279_1.onSingleLineFinish_ = nil
			arg_279_1.state_ = "waiting"
		end

		function arg_279_1.playNext_(arg_281_0)
			if arg_281_0 == 1 then
				arg_279_0:Play1109703068(arg_279_1)
			end
		end

		function arg_279_1.onSingleLineUpdate_(arg_282_0)
			local var_282_9000

			if 0 < arg_279_1.time_ and arg_279_1.time_ <= 0 + arg_282_0 and not isNil(arg_279_1.actors_["1097ui_story"]) and arg_279_1.var_.characterEffect1097ui_story == nil then
				arg_279_1.var_.characterEffect1097ui_story = arg_279_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_282_0 = 0.200000002980232

			if 0 <= arg_279_1.time_ and arg_279_1.time_ < 0 + var_282_0 and not isNil(arg_279_1.actors_["1097ui_story"]) then
				if arg_279_1.var_.characterEffect1097ui_story and not isNil(arg_279_1.actors_["1097ui_story"]) then
					arg_279_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_279_1.time_ >= 0 + var_282_0 and arg_279_1.time_ < 0 + var_282_0 + arg_282_0 and not isNil(arg_279_1.actors_["1097ui_story"]) and arg_279_1.var_.characterEffect1097ui_story then
				arg_279_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_279_1.time_ and arg_279_1.time_ <= 0 + arg_282_0 then
				arg_279_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action5_2")
			end

			if 0 < arg_279_1.time_ and arg_279_1.time_ <= 0 + arg_282_0 then
				arg_279_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			if 0 < arg_279_1.time_ and arg_279_1.time_ <= 0 + arg_282_0 then
				local var_282_2 = arg_279_1.var_.effect1097ui_storykaixinxiaokun1

				if not arg_279_1.var_.effect1097ui_storykaixinxiaokun1 then
					var_282_2 = Object.Instantiate(Asset.Load("Effect/Hero/1097/fx_1097_story_smoke"), arg_279_1.actors_["1097ui_story"].transform)
					var_282_2.name = "kaixinxiaokun1"
					arg_279_1.var_.effect1097ui_storykaixinxiaokun1 = var_282_2
				else
					var_282_2.transform:SetParent(var_282_9000)
				end

				var_282_2.transform.localPosition = Vector3.New(0, 1.28, 0.3)
				var_282_2.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 2 < arg_279_1.time_ and arg_279_1.time_ <= 2 + arg_282_0 then
				if arg_279_1.var_.effect1097ui_storykaixinxiaokun1 then
					Object.Destroy(arg_279_1.var_.effect1097ui_storykaixinxiaokun1)

					arg_279_1.var_.effect1097ui_storykaixinxiaokun1 = nil
				end
			end

			local var_282_5 = 0
			local var_282_6 = 0.275

			if 0 < arg_279_1.time_ and arg_279_1.time_ <= var_282_5 + arg_282_0 then
				arg_279_1.talkMaxDuration = 0
				arg_279_1.dialogCg_.alpha = 1

				arg_279_1.dialog_:SetActive(true)
				SetActive(arg_279_1.leftNameGo_, true)

				arg_279_1.leftNameTxt_.text = arg_279_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_279_1.leftNameTxt_.transform)

				arg_279_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_279_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_279_1:RecordName(arg_279_1.leftNameTxt_.text)
				SetActive(arg_279_1.iconTrs_.gameObject, false)
				arg_279_1.callingController_:SetSelectedState("normal")

				local var_282_7 = arg_279_1:GetWordFromCfg(1109703067)
				local var_282_8 = arg_279_1:FormatText(var_282_7.content)

				arg_279_1.text_.text = var_282_8

				LuaForUtil.ClearLinePrefixSymbol(arg_279_1.text_)

				local var_282_10 = 11 <= 0 and var_282_6 or var_282_6 * (utf8.len(var_282_8) / 11)

				if (11 <= 0 and var_282_6 or var_282_6 * (utf8.len(var_282_8) / 11)) > 0 and var_282_6 < var_282_10 then
					arg_279_1.talkMaxDuration = var_282_10

					if var_282_10 + var_282_5 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_10 + var_282_5
					end
				end

				arg_279_1.text_.text = var_282_8
				arg_279_1.typewritter.percent = 0

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703067", "story_v_side_new_1109703.awb") ~= 0 then
					local var_282_11 = manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703067", "story_v_side_new_1109703.awb") / 1000

					if var_282_11 + var_282_5 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_11 + var_282_5
					end

					if var_282_7.prefab_name ~= "" and arg_279_1.actors_[var_282_7.prefab_name] ~= nil then
						local var_282_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_279_1.actors_[var_282_7.prefab_name].transform, "story_v_side_new_1109703", "1109703067", "story_v_side_new_1109703.awb")

						arg_279_1:RecordAudio("1109703067", var_282_12)
						arg_279_1:RecordAudio("1109703067", var_282_12)
					else
						arg_279_1:AudioAction("play", "voice", "story_v_side_new_1109703", "1109703067", "story_v_side_new_1109703.awb")
					end

					arg_279_1:RecordHistoryTalkVoice("story_v_side_new_1109703", "1109703067", "story_v_side_new_1109703.awb")
				end

				arg_279_1:RecordContent(arg_279_1.text_.text)
			end

			local var_282_13 = math.max(var_282_6, arg_279_1.talkMaxDuration)

			if var_282_5 <= arg_279_1.time_ and arg_279_1.time_ < var_282_5 + var_282_13 then
				arg_279_1.typewritter.percent = (arg_279_1.time_ - var_282_5) / var_282_13

				arg_279_1.typewritter:SetDirty()
			end

			if arg_279_1.time_ >= var_282_5 + var_282_13 and arg_279_1.time_ < var_282_5 + var_282_13 + arg_282_0 then
				arg_279_1.typewritter.percent = 1

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(true)
			end
		end

		arg_279_1.nodeConfigList_ = {}

		arg_279_1:InitPlayNodeList()
	end,
	Play1109703068 = function(arg_283_0, arg_283_1)
		arg_283_1.time_ = 0
		arg_283_1.frameCnt_ = 0
		arg_283_1.state_ = "playing"
		arg_283_1.curTalkId_ = 1109703068
		arg_283_1.duration_ = 5

		SetActive(arg_283_1.tipsGo_, false)

		function arg_283_1.onSingleLineFinish_()
			arg_283_1.onSingleLineUpdate_ = nil
			arg_283_1.onSingleLineFinish_ = nil
			arg_283_1.state_ = "waiting"
		end

		function arg_283_1.playNext_(arg_285_0)
			if arg_285_0 == 1 then
				arg_283_0:Play1109703069(arg_283_1)
			end
		end

		function arg_283_1.onSingleLineUpdate_(arg_286_0)
			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 and not isNil(arg_283_1.actors_["1097ui_story"]) and arg_283_1.var_.characterEffect1097ui_story == nil then
				arg_283_1.var_.characterEffect1097ui_story = arg_283_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_286_0 = 0.200000002980232

			if 0 <= arg_283_1.time_ and arg_283_1.time_ < 0 + var_286_0 and not isNil(arg_283_1.actors_["1097ui_story"]) then
				if arg_283_1.var_.characterEffect1097ui_story and not isNil(arg_283_1.actors_["1097ui_story"]) then
					arg_283_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_283_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_283_1.time_ - 0) / var_286_0)
				end
			end

			if arg_283_1.time_ >= 0 + var_286_0 and arg_283_1.time_ < 0 + var_286_0 + arg_286_0 and not isNil(arg_283_1.actors_["1097ui_story"]) and arg_283_1.var_.characterEffect1097ui_story then
				arg_283_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_283_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_286_1 = 0
			local var_286_2 = 1.075

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= var_286_1 + arg_286_0 then
				arg_283_1.talkMaxDuration = 0
				arg_283_1.dialogCg_.alpha = 1

				arg_283_1.dialog_:SetActive(true)
				SetActive(arg_283_1.leftNameGo_, true)

				arg_283_1.leftNameTxt_.text = arg_283_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_283_1.leftNameTxt_.transform)

				arg_283_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_283_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_283_1:RecordName(arg_283_1.leftNameTxt_.text)
				SetActive(arg_283_1.iconTrs_.gameObject, true)
				arg_283_1.iconController_:SetSelectedState("hero")

				arg_283_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_283_1.callingController_:SetSelectedState("normal")

				arg_283_1.keyicon_.color = Color.New(1, 1, 1)
				arg_283_1.icon_.color = Color.New(1, 1, 1)

				local var_286_3 = arg_283_1:FormatText(arg_283_1:GetWordFromCfg(1109703068).content)

				arg_283_1.text_.text = var_286_3

				LuaForUtil.ClearLinePrefixSymbol(arg_283_1.text_)

				local var_286_5 = 43 <= 0 and var_286_2 or var_286_2 * (utf8.len(var_286_3) / 43)

				if (43 <= 0 and var_286_2 or var_286_2 * (utf8.len(var_286_3) / 43)) > 0 and var_286_2 < var_286_5 then
					arg_283_1.talkMaxDuration = var_286_5

					if var_286_5 + var_286_1 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_5 + var_286_1
					end
				end

				arg_283_1.text_.text = var_286_3
				arg_283_1.typewritter.percent = 0

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(false)
				arg_283_1:RecordContent(arg_283_1.text_.text)
			end

			local var_286_6 = math.max(var_286_2, arg_283_1.talkMaxDuration)

			if var_286_1 <= arg_283_1.time_ and arg_283_1.time_ < var_286_1 + var_286_6 then
				arg_283_1.typewritter.percent = (arg_283_1.time_ - var_286_1) / var_286_6

				arg_283_1.typewritter:SetDirty()
			end

			if arg_283_1.time_ >= var_286_1 + var_286_6 and arg_283_1.time_ < var_286_1 + var_286_6 + arg_286_0 then
				arg_283_1.typewritter.percent = 1

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(true)
			end
		end

		arg_283_1.nodeConfigList_ = {}

		arg_283_1:InitPlayNodeList()
	end,
	Play1109703069 = function(arg_287_0, arg_287_1)
		arg_287_1.time_ = 0
		arg_287_1.frameCnt_ = 0
		arg_287_1.state_ = "playing"
		arg_287_1.curTalkId_ = 1109703069
		arg_287_1.duration_ = 6.9

		local var_287_0 = {
			zh = 6.9,
			ja = 5.7
		}
		local var_287_1 = manager.audio:GetLocalizationFlag()

		if var_287_0[var_287_1] ~= nil then
			arg_287_1.duration_ = var_287_0[var_287_1]
		end

		SetActive(arg_287_1.tipsGo_, false)

		function arg_287_1.onSingleLineFinish_()
			arg_287_1.onSingleLineUpdate_ = nil
			arg_287_1.onSingleLineFinish_ = nil
			arg_287_1.state_ = "waiting"
		end

		function arg_287_1.playNext_(arg_289_0)
			if arg_289_0 == 1 then
				arg_287_0:Play1109703070(arg_287_1)
			end
		end

		function arg_287_1.onSingleLineUpdate_(arg_290_0)
			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 and not isNil(arg_287_1.actors_["1097ui_story"]) and arg_287_1.var_.characterEffect1097ui_story == nil then
				arg_287_1.var_.characterEffect1097ui_story = arg_287_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_290_0 = 0.200000002980232

			if 0 <= arg_287_1.time_ and arg_287_1.time_ < 0 + var_290_0 and not isNil(arg_287_1.actors_["1097ui_story"]) then
				if arg_287_1.var_.characterEffect1097ui_story and not isNil(arg_287_1.actors_["1097ui_story"]) then
					arg_287_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_287_1.time_ >= 0 + var_290_0 and arg_287_1.time_ < 0 + var_290_0 + arg_290_0 and not isNil(arg_287_1.actors_["1097ui_story"]) and arg_287_1.var_.characterEffect1097ui_story then
				arg_287_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 then
				arg_287_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 then
				arg_287_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_290_2 = 0
			local var_290_3 = 0.6

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= var_290_2 + arg_290_0 then
				arg_287_1.talkMaxDuration = 0
				arg_287_1.dialogCg_.alpha = 1

				arg_287_1.dialog_:SetActive(true)
				SetActive(arg_287_1.leftNameGo_, true)

				arg_287_1.leftNameTxt_.text = arg_287_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_287_1.leftNameTxt_.transform)

				arg_287_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_287_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_287_1:RecordName(arg_287_1.leftNameTxt_.text)
				SetActive(arg_287_1.iconTrs_.gameObject, false)
				arg_287_1.callingController_:SetSelectedState("normal")

				local var_290_4 = arg_287_1:GetWordFromCfg(1109703069)
				local var_290_5 = arg_287_1:FormatText(var_290_4.content)

				arg_287_1.text_.text = var_290_5

				LuaForUtil.ClearLinePrefixSymbol(arg_287_1.text_)

				local var_290_7 = 24 <= 0 and var_290_3 or var_290_3 * (utf8.len(var_290_5) / 24)

				if (24 <= 0 and var_290_3 or var_290_3 * (utf8.len(var_290_5) / 24)) > 0 and var_290_3 < var_290_7 then
					arg_287_1.talkMaxDuration = var_290_7

					if var_290_7 + var_290_2 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_7 + var_290_2
					end
				end

				arg_287_1.text_.text = var_290_5
				arg_287_1.typewritter.percent = 0

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703069", "story_v_side_new_1109703.awb") ~= 0 then
					local var_290_8 = manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703069", "story_v_side_new_1109703.awb") / 1000

					if var_290_8 + var_290_2 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_8 + var_290_2
					end

					if var_290_4.prefab_name ~= "" and arg_287_1.actors_[var_290_4.prefab_name] ~= nil then
						local var_290_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_287_1.actors_[var_290_4.prefab_name].transform, "story_v_side_new_1109703", "1109703069", "story_v_side_new_1109703.awb")

						arg_287_1:RecordAudio("1109703069", var_290_9)
						arg_287_1:RecordAudio("1109703069", var_290_9)
					else
						arg_287_1:AudioAction("play", "voice", "story_v_side_new_1109703", "1109703069", "story_v_side_new_1109703.awb")
					end

					arg_287_1:RecordHistoryTalkVoice("story_v_side_new_1109703", "1109703069", "story_v_side_new_1109703.awb")
				end

				arg_287_1:RecordContent(arg_287_1.text_.text)
			end

			local var_290_10 = math.max(var_290_3, arg_287_1.talkMaxDuration)

			if var_290_2 <= arg_287_1.time_ and arg_287_1.time_ < var_290_2 + var_290_10 then
				arg_287_1.typewritter.percent = (arg_287_1.time_ - var_290_2) / var_290_10

				arg_287_1.typewritter:SetDirty()
			end

			if arg_287_1.time_ >= var_290_2 + var_290_10 and arg_287_1.time_ < var_290_2 + var_290_10 + arg_290_0 then
				arg_287_1.typewritter.percent = 1

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(true)
			end
		end

		arg_287_1.nodeConfigList_ = {}

		arg_287_1:InitPlayNodeList()
	end,
	Play1109703070 = function(arg_291_0, arg_291_1)
		arg_291_1.time_ = 0
		arg_291_1.frameCnt_ = 0
		arg_291_1.state_ = "playing"
		arg_291_1.curTalkId_ = 1109703070
		arg_291_1.duration_ = 5

		SetActive(arg_291_1.tipsGo_, false)

		function arg_291_1.onSingleLineFinish_()
			arg_291_1.onSingleLineUpdate_ = nil
			arg_291_1.onSingleLineFinish_ = nil
			arg_291_1.state_ = "waiting"
		end

		function arg_291_1.playNext_(arg_293_0)
			if arg_293_0 == 1 then
				arg_291_0:Play1109703071(arg_291_1)
			end
		end

		function arg_291_1.onSingleLineUpdate_(arg_294_0)
			if 0 < arg_291_1.time_ and arg_291_1.time_ <= 0 + arg_294_0 and not isNil(arg_291_1.actors_["1097ui_story"]) and arg_291_1.var_.characterEffect1097ui_story == nil then
				arg_291_1.var_.characterEffect1097ui_story = arg_291_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_294_0 = 0.200000002980232

			if 0 <= arg_291_1.time_ and arg_291_1.time_ < 0 + var_294_0 and not isNil(arg_291_1.actors_["1097ui_story"]) then
				if arg_291_1.var_.characterEffect1097ui_story and not isNil(arg_291_1.actors_["1097ui_story"]) then
					arg_291_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_291_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_291_1.time_ - 0) / var_294_0)
				end
			end

			if arg_291_1.time_ >= 0 + var_294_0 and arg_291_1.time_ < 0 + var_294_0 + arg_294_0 and not isNil(arg_291_1.actors_["1097ui_story"]) and arg_291_1.var_.characterEffect1097ui_story then
				arg_291_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_291_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_294_1 = 0
			local var_294_2 = 0.775

			if 0 < arg_291_1.time_ and arg_291_1.time_ <= var_294_1 + arg_294_0 then
				arg_291_1.talkMaxDuration = 0
				arg_291_1.dialogCg_.alpha = 1

				arg_291_1.dialog_:SetActive(true)
				SetActive(arg_291_1.leftNameGo_, true)

				arg_291_1.leftNameTxt_.text = arg_291_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_291_1.leftNameTxt_.transform)

				arg_291_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_291_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_291_1:RecordName(arg_291_1.leftNameTxt_.text)
				SetActive(arg_291_1.iconTrs_.gameObject, true)
				arg_291_1.iconController_:SetSelectedState("hero")

				arg_291_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_291_1.callingController_:SetSelectedState("normal")

				arg_291_1.keyicon_.color = Color.New(1, 1, 1)
				arg_291_1.icon_.color = Color.New(1, 1, 1)

				local var_294_3 = arg_291_1:FormatText(arg_291_1:GetWordFromCfg(1109703070).content)

				arg_291_1.text_.text = var_294_3

				LuaForUtil.ClearLinePrefixSymbol(arg_291_1.text_)

				local var_294_5 = 31 <= 0 and var_294_2 or var_294_2 * (utf8.len(var_294_3) / 31)

				if (31 <= 0 and var_294_2 or var_294_2 * (utf8.len(var_294_3) / 31)) > 0 and var_294_2 < var_294_5 then
					arg_291_1.talkMaxDuration = var_294_5

					if var_294_5 + var_294_1 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_5 + var_294_1
					end
				end

				arg_291_1.text_.text = var_294_3
				arg_291_1.typewritter.percent = 0

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(false)
				arg_291_1:RecordContent(arg_291_1.text_.text)
			end

			local var_294_6 = math.max(var_294_2, arg_291_1.talkMaxDuration)

			if var_294_1 <= arg_291_1.time_ and arg_291_1.time_ < var_294_1 + var_294_6 then
				arg_291_1.typewritter.percent = (arg_291_1.time_ - var_294_1) / var_294_6

				arg_291_1.typewritter:SetDirty()
			end

			if arg_291_1.time_ >= var_294_1 + var_294_6 and arg_291_1.time_ < var_294_1 + var_294_6 + arg_294_0 then
				arg_291_1.typewritter.percent = 1

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(true)
			end
		end

		arg_291_1.nodeConfigList_ = {}

		arg_291_1:InitPlayNodeList()
	end,
	Play1109703071 = function(arg_295_0, arg_295_1)
		arg_295_1.time_ = 0
		arg_295_1.frameCnt_ = 0
		arg_295_1.state_ = "playing"
		arg_295_1.curTalkId_ = 1109703071
		arg_295_1.duration_ = 3.8

		local var_295_0 = {
			zh = 3.8,
			ja = 3.1
		}
		local var_295_1 = manager.audio:GetLocalizationFlag()

		if var_295_0[var_295_1] ~= nil then
			arg_295_1.duration_ = var_295_0[var_295_1]
		end

		SetActive(arg_295_1.tipsGo_, false)

		function arg_295_1.onSingleLineFinish_()
			arg_295_1.onSingleLineUpdate_ = nil
			arg_295_1.onSingleLineFinish_ = nil
			arg_295_1.state_ = "waiting"
		end

		function arg_295_1.playNext_(arg_297_0)
			if arg_297_0 == 1 then
				arg_295_0:Play1109703072(arg_295_1)
			end
		end

		function arg_295_1.onSingleLineUpdate_(arg_298_0)
			if 0 < arg_295_1.time_ and arg_295_1.time_ <= 0 + arg_298_0 and not isNil(arg_295_1.actors_["1097ui_story"]) and arg_295_1.var_.characterEffect1097ui_story == nil then
				arg_295_1.var_.characterEffect1097ui_story = arg_295_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_298_0 = 0.200000002980232

			if 0 <= arg_295_1.time_ and arg_295_1.time_ < 0 + var_298_0 and not isNil(arg_295_1.actors_["1097ui_story"]) then
				if arg_295_1.var_.characterEffect1097ui_story and not isNil(arg_295_1.actors_["1097ui_story"]) then
					arg_295_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_295_1.time_ >= 0 + var_298_0 and arg_295_1.time_ < 0 + var_298_0 + arg_298_0 and not isNil(arg_295_1.actors_["1097ui_story"]) and arg_295_1.var_.characterEffect1097ui_story then
				arg_295_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_295_1.time_ and arg_295_1.time_ <= 0 + arg_298_0 then
				arg_295_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action7_1")
			end

			if 0 < arg_295_1.time_ and arg_295_1.time_ <= 0 + arg_298_0 then
				arg_295_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_298_2 = 0
			local var_298_3 = 0.3

			if 0 < arg_295_1.time_ and arg_295_1.time_ <= var_298_2 + arg_298_0 then
				arg_295_1.talkMaxDuration = 0
				arg_295_1.dialogCg_.alpha = 1

				arg_295_1.dialog_:SetActive(true)
				SetActive(arg_295_1.leftNameGo_, true)

				arg_295_1.leftNameTxt_.text = arg_295_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_295_1.leftNameTxt_.transform)

				arg_295_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_295_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_295_1:RecordName(arg_295_1.leftNameTxt_.text)
				SetActive(arg_295_1.iconTrs_.gameObject, false)
				arg_295_1.callingController_:SetSelectedState("normal")

				local var_298_4 = arg_295_1:GetWordFromCfg(1109703071)
				local var_298_5 = arg_295_1:FormatText(var_298_4.content)

				arg_295_1.text_.text = var_298_5

				LuaForUtil.ClearLinePrefixSymbol(arg_295_1.text_)

				local var_298_7 = 12 <= 0 and var_298_3 or var_298_3 * (utf8.len(var_298_5) / 12)

				if (12 <= 0 and var_298_3 or var_298_3 * (utf8.len(var_298_5) / 12)) > 0 and var_298_3 < var_298_7 then
					arg_295_1.talkMaxDuration = var_298_7

					if var_298_7 + var_298_2 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_7 + var_298_2
					end
				end

				arg_295_1.text_.text = var_298_5
				arg_295_1.typewritter.percent = 0

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703071", "story_v_side_new_1109703.awb") ~= 0 then
					local var_298_8 = manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703071", "story_v_side_new_1109703.awb") / 1000

					if var_298_8 + var_298_2 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_8 + var_298_2
					end

					if var_298_4.prefab_name ~= "" and arg_295_1.actors_[var_298_4.prefab_name] ~= nil then
						local var_298_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_295_1.actors_[var_298_4.prefab_name].transform, "story_v_side_new_1109703", "1109703071", "story_v_side_new_1109703.awb")

						arg_295_1:RecordAudio("1109703071", var_298_9)
						arg_295_1:RecordAudio("1109703071", var_298_9)
					else
						arg_295_1:AudioAction("play", "voice", "story_v_side_new_1109703", "1109703071", "story_v_side_new_1109703.awb")
					end

					arg_295_1:RecordHistoryTalkVoice("story_v_side_new_1109703", "1109703071", "story_v_side_new_1109703.awb")
				end

				arg_295_1:RecordContent(arg_295_1.text_.text)
			end

			local var_298_10 = math.max(var_298_3, arg_295_1.talkMaxDuration)

			if var_298_2 <= arg_295_1.time_ and arg_295_1.time_ < var_298_2 + var_298_10 then
				arg_295_1.typewritter.percent = (arg_295_1.time_ - var_298_2) / var_298_10

				arg_295_1.typewritter:SetDirty()
			end

			if arg_295_1.time_ >= var_298_2 + var_298_10 and arg_295_1.time_ < var_298_2 + var_298_10 + arg_298_0 then
				arg_295_1.typewritter.percent = 1

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(true)
			end
		end

		arg_295_1.nodeConfigList_ = {}

		arg_295_1:InitPlayNodeList()
	end,
	Play1109703072 = function(arg_299_0, arg_299_1)
		arg_299_1.time_ = 0
		arg_299_1.frameCnt_ = 0
		arg_299_1.state_ = "playing"
		arg_299_1.curTalkId_ = 1109703072
		arg_299_1.duration_ = 5

		SetActive(arg_299_1.tipsGo_, false)

		function arg_299_1.onSingleLineFinish_()
			arg_299_1.onSingleLineUpdate_ = nil
			arg_299_1.onSingleLineFinish_ = nil
			arg_299_1.state_ = "waiting"
		end

		function arg_299_1.playNext_(arg_301_0)
			if arg_301_0 == 1 then
				arg_299_0:Play1109703073(arg_299_1)
			end
		end

		function arg_299_1.onSingleLineUpdate_(arg_302_0)
			if 0 < arg_299_1.time_ and arg_299_1.time_ <= 0 + arg_302_0 and not isNil(arg_299_1.actors_["1097ui_story"]) and arg_299_1.var_.characterEffect1097ui_story == nil then
				arg_299_1.var_.characterEffect1097ui_story = arg_299_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_302_0 = 0.200000002980232

			if 0 <= arg_299_1.time_ and arg_299_1.time_ < 0 + var_302_0 and not isNil(arg_299_1.actors_["1097ui_story"]) then
				if arg_299_1.var_.characterEffect1097ui_story and not isNil(arg_299_1.actors_["1097ui_story"]) then
					arg_299_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_299_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_299_1.time_ - 0) / var_302_0)
				end
			end

			if arg_299_1.time_ >= 0 + var_302_0 and arg_299_1.time_ < 0 + var_302_0 + arg_302_0 and not isNil(arg_299_1.actors_["1097ui_story"]) and arg_299_1.var_.characterEffect1097ui_story then
				arg_299_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_299_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_302_1 = 0
			local var_302_2 = 1.6

			if 0 < arg_299_1.time_ and arg_299_1.time_ <= var_302_1 + arg_302_0 then
				arg_299_1.talkMaxDuration = 0
				arg_299_1.dialogCg_.alpha = 1

				arg_299_1.dialog_:SetActive(true)
				SetActive(arg_299_1.leftNameGo_, true)

				arg_299_1.leftNameTxt_.text = arg_299_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_299_1.leftNameTxt_.transform)

				arg_299_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_299_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_299_1:RecordName(arg_299_1.leftNameTxt_.text)
				SetActive(arg_299_1.iconTrs_.gameObject, true)
				arg_299_1.iconController_:SetSelectedState("hero")

				arg_299_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_299_1.callingController_:SetSelectedState("normal")

				arg_299_1.keyicon_.color = Color.New(1, 1, 1)
				arg_299_1.icon_.color = Color.New(1, 1, 1)

				local var_302_3 = arg_299_1:FormatText(arg_299_1:GetWordFromCfg(1109703072).content)

				arg_299_1.text_.text = var_302_3

				LuaForUtil.ClearLinePrefixSymbol(arg_299_1.text_)

				local var_302_5 = 64 <= 0 and var_302_2 or var_302_2 * (utf8.len(var_302_3) / 64)

				if (64 <= 0 and var_302_2 or var_302_2 * (utf8.len(var_302_3) / 64)) > 0 and var_302_2 < var_302_5 then
					arg_299_1.talkMaxDuration = var_302_5

					if var_302_5 + var_302_1 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_5 + var_302_1
					end
				end

				arg_299_1.text_.text = var_302_3
				arg_299_1.typewritter.percent = 0

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(false)
				arg_299_1:RecordContent(arg_299_1.text_.text)
			end

			local var_302_6 = math.max(var_302_2, arg_299_1.talkMaxDuration)

			if var_302_1 <= arg_299_1.time_ and arg_299_1.time_ < var_302_1 + var_302_6 then
				arg_299_1.typewritter.percent = (arg_299_1.time_ - var_302_1) / var_302_6

				arg_299_1.typewritter:SetDirty()
			end

			if arg_299_1.time_ >= var_302_1 + var_302_6 and arg_299_1.time_ < var_302_1 + var_302_6 + arg_302_0 then
				arg_299_1.typewritter.percent = 1

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(true)
			end
		end

		arg_299_1.nodeConfigList_ = {}

		arg_299_1:InitPlayNodeList()
	end,
	Play1109703073 = function(arg_303_0, arg_303_1)
		arg_303_1.time_ = 0
		arg_303_1.frameCnt_ = 0
		arg_303_1.state_ = "playing"
		arg_303_1.curTalkId_ = 1109703073
		arg_303_1.duration_ = 5

		SetActive(arg_303_1.tipsGo_, false)

		function arg_303_1.onSingleLineFinish_()
			arg_303_1.onSingleLineUpdate_ = nil
			arg_303_1.onSingleLineFinish_ = nil
			arg_303_1.state_ = "waiting"
		end

		function arg_303_1.playNext_(arg_305_0)
			if arg_305_0 == 1 then
				arg_303_0:Play1109703074(arg_303_1)
			end
		end

		function arg_303_1.onSingleLineUpdate_(arg_306_0)
			local var_306_0 = 0.3

			if 0 < arg_303_1.time_ and arg_303_1.time_ <= 0 + arg_306_0 then
				arg_303_1.talkMaxDuration = 0
				arg_303_1.dialogCg_.alpha = 1

				arg_303_1.dialog_:SetActive(true)
				SetActive(arg_303_1.leftNameGo_, true)

				arg_303_1.leftNameTxt_.text = arg_303_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_303_1.leftNameTxt_.transform)

				arg_303_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_303_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_303_1:RecordName(arg_303_1.leftNameTxt_.text)
				SetActive(arg_303_1.iconTrs_.gameObject, true)
				arg_303_1.iconController_:SetSelectedState("hero")

				arg_303_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_303_1.callingController_:SetSelectedState("normal")

				arg_303_1.keyicon_.color = Color.New(1, 1, 1)
				arg_303_1.icon_.color = Color.New(1, 1, 1)

				local var_306_1 = arg_303_1:FormatText(arg_303_1:GetWordFromCfg(1109703073).content)

				arg_303_1.text_.text = var_306_1

				LuaForUtil.ClearLinePrefixSymbol(arg_303_1.text_)

				local var_306_3 = 12 <= 0 and var_306_0 or var_306_0 * (utf8.len(var_306_1) / 12)

				if (12 <= 0 and var_306_0 or var_306_0 * (utf8.len(var_306_1) / 12)) > 0 and var_306_0 < var_306_3 then
					arg_303_1.talkMaxDuration = var_306_3

					if var_306_3 + 0 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_3 + 0
					end
				end

				arg_303_1.text_.text = var_306_1
				arg_303_1.typewritter.percent = 0

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(false)
				arg_303_1:RecordContent(arg_303_1.text_.text)
			end

			local var_306_4 = math.max(var_306_0, arg_303_1.talkMaxDuration)

			if 0 <= arg_303_1.time_ and arg_303_1.time_ < 0 + var_306_4 then
				arg_303_1.typewritter.percent = (arg_303_1.time_ - 0) / var_306_4

				arg_303_1.typewritter:SetDirty()
			end

			if arg_303_1.time_ >= 0 + var_306_4 and arg_303_1.time_ < 0 + var_306_4 + arg_306_0 then
				arg_303_1.typewritter.percent = 1

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(true)
			end
		end

		arg_303_1.nodeConfigList_ = {}

		arg_303_1:InitPlayNodeList()
	end,
	Play1109703074 = function(arg_307_0, arg_307_1)
		arg_307_1.time_ = 0
		arg_307_1.frameCnt_ = 0
		arg_307_1.state_ = "playing"
		arg_307_1.curTalkId_ = 1109703074
		arg_307_1.duration_ = 7.7

		local var_307_0 = {
			zh = 5.866,
			ja = 7.7
		}
		local var_307_1 = manager.audio:GetLocalizationFlag()

		if var_307_0[var_307_1] ~= nil then
			arg_307_1.duration_ = var_307_0[var_307_1]
		end

		SetActive(arg_307_1.tipsGo_, false)

		function arg_307_1.onSingleLineFinish_()
			arg_307_1.onSingleLineUpdate_ = nil
			arg_307_1.onSingleLineFinish_ = nil
			arg_307_1.state_ = "waiting"
		end

		function arg_307_1.playNext_(arg_309_0)
			if arg_309_0 == 1 then
				arg_307_0:Play1109703075(arg_307_1)
			end
		end

		function arg_307_1.onSingleLineUpdate_(arg_310_0)
			if 0 < arg_307_1.time_ and arg_307_1.time_ <= 0 + arg_310_0 and not isNil(arg_307_1.actors_["1097ui_story"]) and arg_307_1.var_.characterEffect1097ui_story == nil then
				arg_307_1.var_.characterEffect1097ui_story = arg_307_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_310_0 = 0.200000002980232

			if 0 <= arg_307_1.time_ and arg_307_1.time_ < 0 + var_310_0 and not isNil(arg_307_1.actors_["1097ui_story"]) then
				if arg_307_1.var_.characterEffect1097ui_story and not isNil(arg_307_1.actors_["1097ui_story"]) then
					arg_307_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_307_1.time_ >= 0 + var_310_0 and arg_307_1.time_ < 0 + var_310_0 + arg_310_0 and not isNil(arg_307_1.actors_["1097ui_story"]) and arg_307_1.var_.characterEffect1097ui_story then
				arg_307_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_307_1.time_ and arg_307_1.time_ <= 0 + arg_310_0 then
				arg_307_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action7_2")
			end

			if 0 < arg_307_1.time_ and arg_307_1.time_ <= 0 + arg_310_0 then
				arg_307_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva")
			end

			local var_310_2 = 0
			local var_310_3 = 0.775

			if 0 < arg_307_1.time_ and arg_307_1.time_ <= var_310_2 + arg_310_0 then
				arg_307_1.talkMaxDuration = 0
				arg_307_1.dialogCg_.alpha = 1

				arg_307_1.dialog_:SetActive(true)
				SetActive(arg_307_1.leftNameGo_, true)

				arg_307_1.leftNameTxt_.text = arg_307_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_307_1.leftNameTxt_.transform)

				arg_307_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_307_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_307_1:RecordName(arg_307_1.leftNameTxt_.text)
				SetActive(arg_307_1.iconTrs_.gameObject, false)
				arg_307_1.callingController_:SetSelectedState("normal")

				local var_310_4 = arg_307_1:GetWordFromCfg(1109703074)
				local var_310_5 = arg_307_1:FormatText(var_310_4.content)

				arg_307_1.text_.text = var_310_5

				LuaForUtil.ClearLinePrefixSymbol(arg_307_1.text_)

				local var_310_7 = 31 <= 0 and var_310_3 or var_310_3 * (utf8.len(var_310_5) / 31)

				if (31 <= 0 and var_310_3 or var_310_3 * (utf8.len(var_310_5) / 31)) > 0 and var_310_3 < var_310_7 then
					arg_307_1.talkMaxDuration = var_310_7

					if var_310_7 + var_310_2 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_7 + var_310_2
					end
				end

				arg_307_1.text_.text = var_310_5
				arg_307_1.typewritter.percent = 0

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703074", "story_v_side_new_1109703.awb") ~= 0 then
					local var_310_8 = manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703074", "story_v_side_new_1109703.awb") / 1000

					if var_310_8 + var_310_2 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_8 + var_310_2
					end

					if var_310_4.prefab_name ~= "" and arg_307_1.actors_[var_310_4.prefab_name] ~= nil then
						local var_310_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_307_1.actors_[var_310_4.prefab_name].transform, "story_v_side_new_1109703", "1109703074", "story_v_side_new_1109703.awb")

						arg_307_1:RecordAudio("1109703074", var_310_9)
						arg_307_1:RecordAudio("1109703074", var_310_9)
					else
						arg_307_1:AudioAction("play", "voice", "story_v_side_new_1109703", "1109703074", "story_v_side_new_1109703.awb")
					end

					arg_307_1:RecordHistoryTalkVoice("story_v_side_new_1109703", "1109703074", "story_v_side_new_1109703.awb")
				end

				arg_307_1:RecordContent(arg_307_1.text_.text)
			end

			local var_310_10 = math.max(var_310_3, arg_307_1.talkMaxDuration)

			if var_310_2 <= arg_307_1.time_ and arg_307_1.time_ < var_310_2 + var_310_10 then
				arg_307_1.typewritter.percent = (arg_307_1.time_ - var_310_2) / var_310_10

				arg_307_1.typewritter:SetDirty()
			end

			if arg_307_1.time_ >= var_310_2 + var_310_10 and arg_307_1.time_ < var_310_2 + var_310_10 + arg_310_0 then
				arg_307_1.typewritter.percent = 1

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(true)
			end
		end

		arg_307_1.nodeConfigList_ = {}

		arg_307_1:InitPlayNodeList()
	end,
	Play1109703075 = function(arg_311_0, arg_311_1)
		arg_311_1.time_ = 0
		arg_311_1.frameCnt_ = 0
		arg_311_1.state_ = "playing"
		arg_311_1.curTalkId_ = 1109703075
		arg_311_1.duration_ = 5

		SetActive(arg_311_1.tipsGo_, false)

		function arg_311_1.onSingleLineFinish_()
			arg_311_1.onSingleLineUpdate_ = nil
			arg_311_1.onSingleLineFinish_ = nil
			arg_311_1.state_ = "waiting"
		end

		function arg_311_1.playNext_(arg_313_0)
			if arg_313_0 == 1 then
				arg_311_0:Play1109703076(arg_311_1)
			end
		end

		function arg_311_1.onSingleLineUpdate_(arg_314_0)
			if 0 < arg_311_1.time_ and arg_311_1.time_ <= 0 + arg_314_0 and not isNil(arg_311_1.actors_["1097ui_story"]) and arg_311_1.var_.characterEffect1097ui_story == nil then
				arg_311_1.var_.characterEffect1097ui_story = arg_311_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_314_0 = 0.200000002980232

			if 0 <= arg_311_1.time_ and arg_311_1.time_ < 0 + var_314_0 and not isNil(arg_311_1.actors_["1097ui_story"]) then
				if arg_311_1.var_.characterEffect1097ui_story and not isNil(arg_311_1.actors_["1097ui_story"]) then
					arg_311_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_311_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_311_1.time_ - 0) / var_314_0)
				end
			end

			if arg_311_1.time_ >= 0 + var_314_0 and arg_311_1.time_ < 0 + var_314_0 + arg_314_0 and not isNil(arg_311_1.actors_["1097ui_story"]) and arg_311_1.var_.characterEffect1097ui_story then
				arg_311_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_311_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_314_1 = 0
			local var_314_2 = 0.25

			if 0 < arg_311_1.time_ and arg_311_1.time_ <= var_314_1 + arg_314_0 then
				arg_311_1.talkMaxDuration = 0
				arg_311_1.dialogCg_.alpha = 1

				arg_311_1.dialog_:SetActive(true)
				SetActive(arg_311_1.leftNameGo_, true)

				arg_311_1.leftNameTxt_.text = arg_311_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_311_1.leftNameTxt_.transform)

				arg_311_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_311_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_311_1:RecordName(arg_311_1.leftNameTxt_.text)
				SetActive(arg_311_1.iconTrs_.gameObject, true)
				arg_311_1.iconController_:SetSelectedState("hero")

				arg_311_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_311_1.callingController_:SetSelectedState("normal")

				arg_311_1.keyicon_.color = Color.New(1, 1, 1)
				arg_311_1.icon_.color = Color.New(1, 1, 1)

				local var_314_3 = arg_311_1:FormatText(arg_311_1:GetWordFromCfg(1109703075).content)

				arg_311_1.text_.text = var_314_3

				LuaForUtil.ClearLinePrefixSymbol(arg_311_1.text_)

				local var_314_5 = 10 <= 0 and var_314_2 or var_314_2 * (utf8.len(var_314_3) / 10)

				if (10 <= 0 and var_314_2 or var_314_2 * (utf8.len(var_314_3) / 10)) > 0 and var_314_2 < var_314_5 then
					arg_311_1.talkMaxDuration = var_314_5

					if var_314_5 + var_314_1 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_5 + var_314_1
					end
				end

				arg_311_1.text_.text = var_314_3
				arg_311_1.typewritter.percent = 0

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(false)
				arg_311_1:RecordContent(arg_311_1.text_.text)
			end

			local var_314_6 = math.max(var_314_2, arg_311_1.talkMaxDuration)

			if var_314_1 <= arg_311_1.time_ and arg_311_1.time_ < var_314_1 + var_314_6 then
				arg_311_1.typewritter.percent = (arg_311_1.time_ - var_314_1) / var_314_6

				arg_311_1.typewritter:SetDirty()
			end

			if arg_311_1.time_ >= var_314_1 + var_314_6 and arg_311_1.time_ < var_314_1 + var_314_6 + arg_314_0 then
				arg_311_1.typewritter.percent = 1

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(true)
			end
		end

		arg_311_1.nodeConfigList_ = {}

		arg_311_1:InitPlayNodeList()
	end,
	Play1109703076 = function(arg_315_0, arg_315_1)
		arg_315_1.time_ = 0
		arg_315_1.frameCnt_ = 0
		arg_315_1.state_ = "playing"
		arg_315_1.curTalkId_ = 1109703076
		arg_315_1.duration_ = 14.17

		local var_315_0 = {
			zh = 11.4330000029802,
			ja = 14.1660000029802
		}
		local var_315_1 = manager.audio:GetLocalizationFlag()

		if var_315_0[var_315_1] ~= nil then
			arg_315_1.duration_ = var_315_0[var_315_1]
		end

		SetActive(arg_315_1.tipsGo_, false)

		function arg_315_1.onSingleLineFinish_()
			arg_315_1.onSingleLineUpdate_ = nil
			arg_315_1.onSingleLineFinish_ = nil
			arg_315_1.state_ = "waiting"
		end

		function arg_315_1.playNext_(arg_317_0)
			if arg_317_0 == 1 then
				arg_315_0:Play1109703077(arg_315_1)
			end
		end

		function arg_315_1.onSingleLineUpdate_(arg_318_0)
			if 2 < arg_315_1.time_ and arg_315_1.time_ <= 2 + arg_318_0 then
				local var_318_0 = arg_315_1.bgs_.ST12

				arg_315_1.bgs_.ST12.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_318_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_318_1 = var_318_0:GetComponent("SpriteRenderer")

				if var_318_1 and var_318_1.sprite then
					local var_318_2 = 2 * (var_318_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_318_0.transform.localScale = Vector3.New(var_318_2 / var_318_1.sprite.bounds.size.y < var_318_2 * manager.ui.mainCameraCom_.aspect / var_318_1.sprite.bounds.size.x and var_318_2 * manager.ui.mainCameraCom_.aspect / var_318_1.sprite.bounds.size.x or var_318_2 / var_318_1.sprite.bounds.size.y, var_318_2 / var_318_1.sprite.bounds.size.y < var_318_2 * manager.ui.mainCameraCom_.aspect / var_318_1.sprite.bounds.size.x and var_318_2 * manager.ui.mainCameraCom_.aspect / var_318_1.sprite.bounds.size.x or var_318_2 / var_318_1.sprite.bounds.size.y, 0)
				end

				for iter_318_0, iter_318_1 in pairs(arg_315_1.bgs_) do
					if iter_318_0 ~= "ST12" then
						iter_318_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_318_3 = 0

			if 0 < arg_315_1.time_ and arg_315_1.time_ <= var_318_3 + arg_318_0 then
				arg_315_1.mask_.enabled = true
				arg_315_1.mask_.raycastTarget = true

				arg_315_1:SetGaussion(false)
			end

			local var_318_4 = 2

			if var_318_3 <= arg_315_1.time_ and arg_315_1.time_ < var_318_3 + var_318_4 then
				local var_318_5 = Color.New(1, 1, 1)

				var_318_5.a = Mathf.Lerp(0, 1, (arg_315_1.time_ - var_318_3) / var_318_4)
				arg_315_1.mask_.color = var_318_5
			end

			if arg_315_1.time_ >= var_318_3 + var_318_4 and arg_315_1.time_ < var_318_3 + var_318_4 + arg_318_0 then
				local var_318_6 = Color.New(1, 1, 1)

				var_318_6.a = 1
				arg_315_1.mask_.color = var_318_6
			end

			local var_318_7 = 2

			if 2 < arg_315_1.time_ and arg_315_1.time_ <= var_318_7 + arg_318_0 then
				arg_315_1.mask_.enabled = true
				arg_315_1.mask_.raycastTarget = true

				arg_315_1:SetGaussion(false)
			end

			local var_318_8 = 2

			if var_318_7 <= arg_315_1.time_ and arg_315_1.time_ < var_318_7 + var_318_8 then
				local var_318_9 = Color.New(1, 1, 1)

				var_318_9.a = Mathf.Lerp(1, 0, (arg_315_1.time_ - var_318_7) / var_318_8)
				arg_315_1.mask_.color = var_318_9
			end

			if arg_315_1.time_ >= var_318_7 + var_318_8 and arg_315_1.time_ < var_318_7 + var_318_8 + arg_318_0 then
				local var_318_10 = Color.New(1, 1, 1)

				arg_315_1.mask_.enabled = false
				var_318_10.a = 0
				arg_315_1.mask_.color = var_318_10
			end

			local var_318_11 = arg_315_1.actors_["1097ui_story"].transform

			if 1.96599999815226 < arg_315_1.time_ and arg_315_1.time_ <= 1.96599999815226 + arg_318_0 then
				arg_315_1.var_.moveOldPos1097ui_story = var_318_11.localPosition
			end

			local var_318_12 = 0.001

			if 1.96599999815226 <= arg_315_1.time_ and arg_315_1.time_ < 1.96599999815226 + var_318_12 then
				var_318_11.localPosition = Vector3.Lerp(arg_315_1.var_.moveOldPos1097ui_story, Vector3.New(0, 100, 0), (arg_315_1.time_ - 1.96599999815226) / var_318_12)
				var_318_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_318_11.position).x, (manager.ui.mainCamera.transform.position - var_318_11.position).y, (manager.ui.mainCamera.transform.position - var_318_11.position).z)
				var_318_11.localEulerAngles.z = 0
				var_318_11.localEulerAngles.x = 0
				var_318_11.localEulerAngles = var_318_11.localEulerAngles
			end

			if arg_315_1.time_ >= 1.96599999815226 + var_318_12 and arg_315_1.time_ < 1.96599999815226 + var_318_12 + arg_318_0 then
				var_318_11.localPosition = Vector3.New(0, 100, 0)
				var_318_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_318_11.position).x, (manager.ui.mainCamera.transform.position - var_318_11.position).y, (manager.ui.mainCamera.transform.position - var_318_11.position).z)
				var_318_11.localEulerAngles.z = 0
				var_318_11.localEulerAngles.x = 0
				var_318_11.localEulerAngles = var_318_11.localEulerAngles
			end

			local var_318_13 = arg_315_1.actors_["1097ui_story"]

			if 1.96599999815226 < arg_315_1.time_ and arg_315_1.time_ <= 1.96599999815226 + arg_318_0 and not isNil(var_318_13) and arg_315_1.var_.characterEffect1097ui_story == nil then
				arg_315_1.var_.characterEffect1097ui_story = var_318_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_318_14 = 0.034000001847744

			if 1.96599999815226 <= arg_315_1.time_ and arg_315_1.time_ < 1.96599999815226 + var_318_14 and not isNil(var_318_13) then
				if arg_315_1.var_.characterEffect1097ui_story and not isNil(var_318_13) then
					arg_315_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_315_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_315_1.time_ - 1.96599999815226) / var_318_14)
				end
			end

			if arg_315_1.time_ >= 1.96599999815226 + var_318_14 and arg_315_1.time_ < 1.96599999815226 + var_318_14 + arg_318_0 and not isNil(var_318_13) and arg_315_1.var_.characterEffect1097ui_story then
				arg_315_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_315_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_318_15 = arg_315_1.actors_["1019ui_story"].transform

			if 3.8 < arg_315_1.time_ and arg_315_1.time_ <= 3.8 + arg_318_0 then
				arg_315_1.var_.moveOldPos1019ui_story = var_318_15.localPosition
			end

			local var_318_16 = 0.001

			if 3.8 <= arg_315_1.time_ and arg_315_1.time_ < 3.8 + var_318_16 then
				var_318_15.localPosition = Vector3.Lerp(arg_315_1.var_.moveOldPos1019ui_story, Vector3.New(-0.2, -1.08, -5.9), (arg_315_1.time_ - 3.8) / var_318_16)
				var_318_15.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_318_15.position).x, (manager.ui.mainCamera.transform.position - var_318_15.position).y, (manager.ui.mainCamera.transform.position - var_318_15.position).z)
				var_318_15.localEulerAngles.z = 0
				var_318_15.localEulerAngles.x = 0
				var_318_15.localEulerAngles = var_318_15.localEulerAngles
			end

			if arg_315_1.time_ >= 3.8 + var_318_16 and arg_315_1.time_ < 3.8 + var_318_16 + arg_318_0 then
				var_318_15.localPosition = Vector3.New(-0.2, -1.08, -5.9)
				var_318_15.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_318_15.position).x, (manager.ui.mainCamera.transform.position - var_318_15.position).y, (manager.ui.mainCamera.transform.position - var_318_15.position).z)
				var_318_15.localEulerAngles.z = 0
				var_318_15.localEulerAngles.x = 0
				var_318_15.localEulerAngles = var_318_15.localEulerAngles
			end

			local var_318_17 = arg_315_1.actors_["1019ui_story"]

			if 3.8 < arg_315_1.time_ and arg_315_1.time_ <= 3.8 + arg_318_0 and not isNil(var_318_17) and arg_315_1.var_.characterEffect1019ui_story == nil then
				arg_315_1.var_.characterEffect1019ui_story = var_318_17:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_318_18 = 0.200000002980232

			if 3.8 <= arg_315_1.time_ and arg_315_1.time_ < 3.8 + var_318_18 and not isNil(var_318_17) then
				if arg_315_1.var_.characterEffect1019ui_story and not isNil(var_318_17) then
					arg_315_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_315_1.time_ >= 3.8 + var_318_18 and arg_315_1.time_ < 3.8 + var_318_18 + arg_318_0 and not isNil(var_318_17) and arg_315_1.var_.characterEffect1019ui_story then
				arg_315_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			if 3.8 < arg_315_1.time_ and arg_315_1.time_ <= 3.8 + arg_318_0 then
				arg_315_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action1_1")
			end

			if 3.8 < arg_315_1.time_ and arg_315_1.time_ <= 3.8 + arg_318_0 then
				arg_315_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			if 3.8 < arg_315_1.time_ and arg_315_1.time_ <= 3.8 + arg_318_0 then
				if arg_315_1.var_.characterEffect1019ui_story == nil then
					arg_315_1.var_.characterEffect1019ui_story = arg_315_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_315_1.var_.characterEffect1019ui_story.imageEffect:turnOn(false)
			end

			if 3.8 < arg_315_1.time_ and arg_315_1.time_ <= 3.8 + arg_318_0 then
				if arg_315_1.var_.characterEffect1019ui_story == nil then
					arg_315_1.var_.characterEffect1019ui_story = arg_315_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_318_21 = arg_315_1.var_.characterEffect1019ui_story

				arg_315_1.var_.characterEffect1019ui_story.imageEffect:turnOff()

				var_318_21.interferenceEffect.enabled = true
				var_318_21.interferenceEffect.noise = 0.001
				var_318_21.interferenceEffect.simTimeScale = 1
				var_318_21.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			if arg_315_1.frameCnt_ <= 1 then
				arg_315_1.dialog_:SetActive(false)
			end

			local var_318_22 = 4.00000000298023
			local var_318_23 = 1.05

			if 4.00000000298023 < arg_315_1.time_ and arg_315_1.time_ <= var_318_22 + arg_318_0 then
				arg_315_1.talkMaxDuration = 0

				arg_315_1.dialog_:SetActive(true)

				arg_315_1.dialogCg_.alpha = 0

				local var_318_24 = LeanTween.value(arg_315_1.dialog_, 0, 1, 0.3)

				var_318_24:setOnUpdate(LuaHelper.FloatAction(function(arg_319_0)
					arg_315_1.dialogCg_.alpha = arg_319_0
				end))
				var_318_24:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_315_1.dialog_)
					var_318_24:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_315_1.duration_ = arg_315_1.duration_ + 0.3

				SetActive(arg_315_1.leftNameGo_, true)

				arg_315_1.leftNameTxt_.text = arg_315_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_315_1.leftNameTxt_.transform)

				arg_315_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_315_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_315_1:RecordName(arg_315_1.leftNameTxt_.text)
				SetActive(arg_315_1.iconTrs_.gameObject, false)
				arg_315_1.callingController_:SetSelectedState("normal")

				local var_318_25 = arg_315_1:GetWordFromCfg(1109703076)
				local var_318_26 = arg_315_1:FormatText(var_318_25.content)

				arg_315_1.text_.text = var_318_26

				LuaForUtil.ClearLinePrefixSymbol(arg_315_1.text_)

				local var_318_28 = 42 <= 0 and var_318_23 or var_318_23 * (utf8.len(var_318_26) / 42)

				if (42 <= 0 and var_318_23 or var_318_23 * (utf8.len(var_318_26) / 42)) > 0 and var_318_23 < var_318_28 then
					arg_315_1.talkMaxDuration = var_318_28
					var_318_22 = var_318_22 + 0.3

					if var_318_28 + var_318_22 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_28 + var_318_22
					end
				end

				arg_315_1.text_.text = var_318_26
				arg_315_1.typewritter.percent = 0

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703076", "story_v_side_new_1109703.awb") ~= 0 then
					local var_318_29 = manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703076", "story_v_side_new_1109703.awb") / 1000

					if var_318_29 + var_318_22 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_29 + var_318_22
					end

					if var_318_25.prefab_name ~= "" and arg_315_1.actors_[var_318_25.prefab_name] ~= nil then
						local var_318_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_315_1.actors_[var_318_25.prefab_name].transform, "story_v_side_new_1109703", "1109703076", "story_v_side_new_1109703.awb")

						arg_315_1:RecordAudio("1109703076", var_318_30)
						arg_315_1:RecordAudio("1109703076", var_318_30)
					else
						arg_315_1:AudioAction("play", "voice", "story_v_side_new_1109703", "1109703076", "story_v_side_new_1109703.awb")
					end

					arg_315_1:RecordHistoryTalkVoice("story_v_side_new_1109703", "1109703076", "story_v_side_new_1109703.awb")
				end

				arg_315_1:RecordContent(arg_315_1.text_.text)
			end

			local var_318_31 = var_318_22 + 0.3
			local var_318_32 = math.max(var_318_23, arg_315_1.talkMaxDuration)

			if var_318_22 + 0.3 <= arg_315_1.time_ and arg_315_1.time_ < var_318_31 + var_318_32 then
				arg_315_1.typewritter.percent = (arg_315_1.time_ - var_318_31) / var_318_32

				arg_315_1.typewritter:SetDirty()
			end

			if arg_315_1.time_ >= var_318_31 + var_318_32 and arg_315_1.time_ < var_318_31 + var_318_32 + arg_318_0 then
				arg_315_1.typewritter.percent = 1

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(true)
			end
		end

		arg_315_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
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
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_315_1:InitPlayNodeList()
	end,
	Play1109703077 = function(arg_321_0, arg_321_1)
		arg_321_1.time_ = 0
		arg_321_1.frameCnt_ = 0
		arg_321_1.state_ = "playing"
		arg_321_1.curTalkId_ = 1109703077
		arg_321_1.duration_ = 5

		SetActive(arg_321_1.tipsGo_, false)

		function arg_321_1.onSingleLineFinish_()
			arg_321_1.onSingleLineUpdate_ = nil
			arg_321_1.onSingleLineFinish_ = nil
			arg_321_1.state_ = "waiting"
		end

		function arg_321_1.playNext_(arg_323_0)
			if arg_323_0 == 1 then
				arg_321_0:Play1109703078(arg_321_1)
			end
		end

		function arg_321_1.onSingleLineUpdate_(arg_324_0)
			if 0 < arg_321_1.time_ and arg_321_1.time_ <= 0 + arg_324_0 and not isNil(arg_321_1.actors_["1019ui_story"]) and arg_321_1.var_.characterEffect1019ui_story == nil then
				arg_321_1.var_.characterEffect1019ui_story = arg_321_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_324_0 = 0.200000002980232

			if 0 <= arg_321_1.time_ and arg_321_1.time_ < 0 + var_324_0 and not isNil(arg_321_1.actors_["1019ui_story"]) then
				if arg_321_1.var_.characterEffect1019ui_story and not isNil(arg_321_1.actors_["1019ui_story"]) then
					arg_321_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_321_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_321_1.time_ - 0) / var_324_0)
				end
			end

			if arg_321_1.time_ >= 0 + var_324_0 and arg_321_1.time_ < 0 + var_324_0 + arg_324_0 and not isNil(arg_321_1.actors_["1019ui_story"]) and arg_321_1.var_.characterEffect1019ui_story then
				arg_321_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_321_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_324_1 = 0
			local var_324_2 = 0.1

			if 0 < arg_321_1.time_ and arg_321_1.time_ <= var_324_1 + arg_324_0 then
				arg_321_1.talkMaxDuration = 0
				arg_321_1.dialogCg_.alpha = 1

				arg_321_1.dialog_:SetActive(true)
				SetActive(arg_321_1.leftNameGo_, true)

				arg_321_1.leftNameTxt_.text = arg_321_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_321_1.leftNameTxt_.transform)

				arg_321_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_321_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_321_1:RecordName(arg_321_1.leftNameTxt_.text)
				SetActive(arg_321_1.iconTrs_.gameObject, true)
				arg_321_1.iconController_:SetSelectedState("hero")

				arg_321_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_321_1.callingController_:SetSelectedState("normal")

				arg_321_1.keyicon_.color = Color.New(1, 1, 1)
				arg_321_1.icon_.color = Color.New(1, 1, 1)

				local var_324_3 = arg_321_1:FormatText(arg_321_1:GetWordFromCfg(1109703077).content)

				arg_321_1.text_.text = var_324_3

				LuaForUtil.ClearLinePrefixSymbol(arg_321_1.text_)

				local var_324_5 = 4 <= 0 and var_324_2 or var_324_2 * (utf8.len(var_324_3) / 4)

				if (4 <= 0 and var_324_2 or var_324_2 * (utf8.len(var_324_3) / 4)) > 0 and var_324_2 < var_324_5 then
					arg_321_1.talkMaxDuration = var_324_5

					if var_324_5 + var_324_1 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_5 + var_324_1
					end
				end

				arg_321_1.text_.text = var_324_3
				arg_321_1.typewritter.percent = 0

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(false)
				arg_321_1:RecordContent(arg_321_1.text_.text)
			end

			local var_324_6 = math.max(var_324_2, arg_321_1.talkMaxDuration)

			if var_324_1 <= arg_321_1.time_ and arg_321_1.time_ < var_324_1 + var_324_6 then
				arg_321_1.typewritter.percent = (arg_321_1.time_ - var_324_1) / var_324_6

				arg_321_1.typewritter:SetDirty()
			end

			if arg_321_1.time_ >= var_324_1 + var_324_6 and arg_321_1.time_ < var_324_1 + var_324_6 + arg_324_0 then
				arg_321_1.typewritter.percent = 1

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(true)
			end
		end

		arg_321_1.nodeConfigList_ = {}

		arg_321_1:InitPlayNodeList()
	end,
	Play1109703078 = function(arg_325_0, arg_325_1)
		arg_325_1.time_ = 0
		arg_325_1.frameCnt_ = 0
		arg_325_1.state_ = "playing"
		arg_325_1.curTalkId_ = 1109703078
		arg_325_1.duration_ = 7.4

		local var_325_0 = {
			zh = 6.066,
			ja = 7.4
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
				arg_325_0:Play1109703079(arg_325_1)
			end
		end

		function arg_325_1.onSingleLineUpdate_(arg_328_0)
			if 0 < arg_325_1.time_ and arg_325_1.time_ <= 0 + arg_328_0 and not isNil(arg_325_1.actors_["1019ui_story"]) and arg_325_1.var_.characterEffect1019ui_story == nil then
				arg_325_1.var_.characterEffect1019ui_story = arg_325_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_328_0 = 0.200000002980232

			if 0 <= arg_325_1.time_ and arg_325_1.time_ < 0 + var_328_0 and not isNil(arg_325_1.actors_["1019ui_story"]) then
				if arg_325_1.var_.characterEffect1019ui_story and not isNil(arg_325_1.actors_["1019ui_story"]) then
					arg_325_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_325_1.time_ >= 0 + var_328_0 and arg_325_1.time_ < 0 + var_328_0 + arg_328_0 and not isNil(arg_325_1.actors_["1019ui_story"]) and arg_325_1.var_.characterEffect1019ui_story then
				arg_325_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= 0 + arg_328_0 then
				arg_325_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action7_1")
			end

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= 0 + arg_328_0 then
				arg_325_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_328_2 = 0
			local var_328_3 = 0.9

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= var_328_2 + arg_328_0 then
				arg_325_1.talkMaxDuration = 0
				arg_325_1.dialogCg_.alpha = 1

				arg_325_1.dialog_:SetActive(true)
				SetActive(arg_325_1.leftNameGo_, true)

				arg_325_1.leftNameTxt_.text = arg_325_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_325_1.leftNameTxt_.transform)

				arg_325_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_325_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_325_1:RecordName(arg_325_1.leftNameTxt_.text)
				SetActive(arg_325_1.iconTrs_.gameObject, false)
				arg_325_1.callingController_:SetSelectedState("normal")

				local var_328_4 = arg_325_1:GetWordFromCfg(1109703078)
				local var_328_5 = arg_325_1:FormatText(var_328_4.content)

				arg_325_1.text_.text = var_328_5

				LuaForUtil.ClearLinePrefixSymbol(arg_325_1.text_)

				local var_328_7 = 36 <= 0 and var_328_3 or var_328_3 * (utf8.len(var_328_5) / 36)

				if (36 <= 0 and var_328_3 or var_328_3 * (utf8.len(var_328_5) / 36)) > 0 and var_328_3 < var_328_7 then
					arg_325_1.talkMaxDuration = var_328_7

					if var_328_7 + var_328_2 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_7 + var_328_2
					end
				end

				arg_325_1.text_.text = var_328_5
				arg_325_1.typewritter.percent = 0

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703078", "story_v_side_new_1109703.awb") ~= 0 then
					local var_328_8 = manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703078", "story_v_side_new_1109703.awb") / 1000

					if var_328_8 + var_328_2 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_8 + var_328_2
					end

					if var_328_4.prefab_name ~= "" and arg_325_1.actors_[var_328_4.prefab_name] ~= nil then
						local var_328_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_325_1.actors_[var_328_4.prefab_name].transform, "story_v_side_new_1109703", "1109703078", "story_v_side_new_1109703.awb")

						arg_325_1:RecordAudio("1109703078", var_328_9)
						arg_325_1:RecordAudio("1109703078", var_328_9)
					else
						arg_325_1:AudioAction("play", "voice", "story_v_side_new_1109703", "1109703078", "story_v_side_new_1109703.awb")
					end

					arg_325_1:RecordHistoryTalkVoice("story_v_side_new_1109703", "1109703078", "story_v_side_new_1109703.awb")
				end

				arg_325_1:RecordContent(arg_325_1.text_.text)
			end

			local var_328_10 = math.max(var_328_3, arg_325_1.talkMaxDuration)

			if var_328_2 <= arg_325_1.time_ and arg_325_1.time_ < var_328_2 + var_328_10 then
				arg_325_1.typewritter.percent = (arg_325_1.time_ - var_328_2) / var_328_10

				arg_325_1.typewritter:SetDirty()
			end

			if arg_325_1.time_ >= var_328_2 + var_328_10 and arg_325_1.time_ < var_328_2 + var_328_10 + arg_328_0 then
				arg_325_1.typewritter.percent = 1

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(true)
			end
		end

		arg_325_1.nodeConfigList_ = {}

		arg_325_1:InitPlayNodeList()
	end,
	Play1109703079 = function(arg_329_0, arg_329_1)
		arg_329_1.time_ = 0
		arg_329_1.frameCnt_ = 0
		arg_329_1.state_ = "playing"
		arg_329_1.curTalkId_ = 1109703079
		arg_329_1.duration_ = 5

		SetActive(arg_329_1.tipsGo_, false)

		function arg_329_1.onSingleLineFinish_()
			arg_329_1.onSingleLineUpdate_ = nil
			arg_329_1.onSingleLineFinish_ = nil
			arg_329_1.state_ = "waiting"
		end

		function arg_329_1.playNext_(arg_331_0)
			if arg_331_0 == 1 then
				arg_329_0:Play1109703080(arg_329_1)
			end
		end

		function arg_329_1.onSingleLineUpdate_(arg_332_0)
			if 0 < arg_329_1.time_ and arg_329_1.time_ <= 0 + arg_332_0 and not isNil(arg_329_1.actors_["1019ui_story"]) and arg_329_1.var_.characterEffect1019ui_story == nil then
				arg_329_1.var_.characterEffect1019ui_story = arg_329_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_332_0 = 0.200000002980232

			if 0 <= arg_329_1.time_ and arg_329_1.time_ < 0 + var_332_0 and not isNil(arg_329_1.actors_["1019ui_story"]) then
				if arg_329_1.var_.characterEffect1019ui_story and not isNil(arg_329_1.actors_["1019ui_story"]) then
					arg_329_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_329_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_329_1.time_ - 0) / var_332_0)
				end
			end

			if arg_329_1.time_ >= 0 + var_332_0 and arg_329_1.time_ < 0 + var_332_0 + arg_332_0 and not isNil(arg_329_1.actors_["1019ui_story"]) and arg_329_1.var_.characterEffect1019ui_story then
				arg_329_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_329_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_332_1 = 0
			local var_332_2 = 0.1

			if 0 < arg_329_1.time_ and arg_329_1.time_ <= var_332_1 + arg_332_0 then
				arg_329_1.talkMaxDuration = 0
				arg_329_1.dialogCg_.alpha = 1

				arg_329_1.dialog_:SetActive(true)
				SetActive(arg_329_1.leftNameGo_, true)

				arg_329_1.leftNameTxt_.text = arg_329_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_329_1.leftNameTxt_.transform)

				arg_329_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_329_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_329_1:RecordName(arg_329_1.leftNameTxt_.text)
				SetActive(arg_329_1.iconTrs_.gameObject, true)
				arg_329_1.iconController_:SetSelectedState("hero")

				arg_329_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_329_1.callingController_:SetSelectedState("normal")

				arg_329_1.keyicon_.color = Color.New(1, 1, 1)
				arg_329_1.icon_.color = Color.New(1, 1, 1)

				local var_332_3 = arg_329_1:FormatText(arg_329_1:GetWordFromCfg(1109703079).content)

				arg_329_1.text_.text = var_332_3

				LuaForUtil.ClearLinePrefixSymbol(arg_329_1.text_)

				local var_332_5 = 4 <= 0 and var_332_2 or var_332_2 * (utf8.len(var_332_3) / 4)

				if (4 <= 0 and var_332_2 or var_332_2 * (utf8.len(var_332_3) / 4)) > 0 and var_332_2 < var_332_5 then
					arg_329_1.talkMaxDuration = var_332_5

					if var_332_5 + var_332_1 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_5 + var_332_1
					end
				end

				arg_329_1.text_.text = var_332_3
				arg_329_1.typewritter.percent = 0

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(false)
				arg_329_1:RecordContent(arg_329_1.text_.text)
			end

			local var_332_6 = math.max(var_332_2, arg_329_1.talkMaxDuration)

			if var_332_1 <= arg_329_1.time_ and arg_329_1.time_ < var_332_1 + var_332_6 then
				arg_329_1.typewritter.percent = (arg_329_1.time_ - var_332_1) / var_332_6

				arg_329_1.typewritter:SetDirty()
			end

			if arg_329_1.time_ >= var_332_1 + var_332_6 and arg_329_1.time_ < var_332_1 + var_332_6 + arg_332_0 then
				arg_329_1.typewritter.percent = 1

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(true)
			end
		end

		arg_329_1.nodeConfigList_ = {}

		arg_329_1:InitPlayNodeList()
	end,
	Play1109703080 = function(arg_333_0, arg_333_1)
		arg_333_1.time_ = 0
		arg_333_1.frameCnt_ = 0
		arg_333_1.state_ = "playing"
		arg_333_1.curTalkId_ = 1109703080
		arg_333_1.duration_ = 7.07

		local var_333_0 = {
			zh = 5.799999999999,
			ja = 7.066
		}
		local var_333_1 = manager.audio:GetLocalizationFlag()

		if var_333_0[var_333_1] ~= nil then
			arg_333_1.duration_ = var_333_0[var_333_1]
		end

		SetActive(arg_333_1.tipsGo_, false)

		function arg_333_1.onSingleLineFinish_()
			arg_333_1.onSingleLineUpdate_ = nil
			arg_333_1.onSingleLineFinish_ = nil
			arg_333_1.state_ = "waiting"
		end

		function arg_333_1.playNext_(arg_335_0)
			if arg_335_0 == 1 then
				arg_333_0:Play1109703081(arg_333_1)
			end
		end

		function arg_333_1.onSingleLineUpdate_(arg_336_0)
			if 2.00000000298023 < arg_333_1.time_ and arg_333_1.time_ <= 2.00000000298023 + arg_336_0 then
				local var_336_0 = arg_333_1.bgs_.ST12

				arg_333_1.bgs_.ST12.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_336_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_336_1 = var_336_0:GetComponent("SpriteRenderer")

				if var_336_1 and var_336_1.sprite then
					local var_336_2 = 2 * (var_336_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_336_0.transform.localScale = Vector3.New(var_336_2 / var_336_1.sprite.bounds.size.y < var_336_2 * manager.ui.mainCameraCom_.aspect / var_336_1.sprite.bounds.size.x and var_336_2 * manager.ui.mainCameraCom_.aspect / var_336_1.sprite.bounds.size.x or var_336_2 / var_336_1.sprite.bounds.size.y, var_336_2 / var_336_1.sprite.bounds.size.y < var_336_2 * manager.ui.mainCameraCom_.aspect / var_336_1.sprite.bounds.size.x and var_336_2 * manager.ui.mainCameraCom_.aspect / var_336_1.sprite.bounds.size.x or var_336_2 / var_336_1.sprite.bounds.size.y, 0)
				end

				for iter_336_0, iter_336_1 in pairs(arg_333_1.bgs_) do
					if iter_336_0 ~= "ST12" then
						iter_336_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_336_3 = 0

			if 0 < arg_333_1.time_ and arg_333_1.time_ <= var_336_3 + arg_336_0 then
				arg_333_1.mask_.enabled = true
				arg_333_1.mask_.raycastTarget = true

				arg_333_1:SetGaussion(false)
			end

			local var_336_4 = 2

			if var_336_3 <= arg_333_1.time_ and arg_333_1.time_ < var_336_3 + var_336_4 then
				local var_336_5 = Color.New(1, 1, 1)

				var_336_5.a = Mathf.Lerp(0, 1, (arg_333_1.time_ - var_336_3) / var_336_4)
				arg_333_1.mask_.color = var_336_5
			end

			if arg_333_1.time_ >= var_336_3 + var_336_4 and arg_333_1.time_ < var_336_3 + var_336_4 + arg_336_0 then
				local var_336_6 = Color.New(1, 1, 1)

				var_336_6.a = 1
				arg_333_1.mask_.color = var_336_6
			end

			local var_336_7 = 2

			if 2 < arg_333_1.time_ and arg_333_1.time_ <= var_336_7 + arg_336_0 then
				arg_333_1.mask_.enabled = true
				arg_333_1.mask_.raycastTarget = true

				arg_333_1:SetGaussion(false)
			end

			local var_336_8 = 2

			if var_336_7 <= arg_333_1.time_ and arg_333_1.time_ < var_336_7 + var_336_8 then
				local var_336_9 = Color.New(1, 1, 1)

				var_336_9.a = Mathf.Lerp(1, 0, (arg_333_1.time_ - var_336_7) / var_336_8)
				arg_333_1.mask_.color = var_336_9
			end

			if arg_333_1.time_ >= var_336_7 + var_336_8 and arg_333_1.time_ < var_336_7 + var_336_8 + arg_336_0 then
				local var_336_10 = Color.New(1, 1, 1)

				arg_333_1.mask_.enabled = false
				var_336_10.a = 0
				arg_333_1.mask_.color = var_336_10
			end

			local var_336_11 = arg_333_1.actors_["1019ui_story"].transform

			if 1.96599999815226 < arg_333_1.time_ and arg_333_1.time_ <= 1.96599999815226 + arg_336_0 then
				arg_333_1.var_.moveOldPos1019ui_story = var_336_11.localPosition
			end

			local var_336_12 = 0.001

			if 1.96599999815226 <= arg_333_1.time_ and arg_333_1.time_ < 1.96599999815226 + var_336_12 then
				var_336_11.localPosition = Vector3.Lerp(arg_333_1.var_.moveOldPos1019ui_story, Vector3.New(0, 100, 0), (arg_333_1.time_ - 1.96599999815226) / var_336_12)
				var_336_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_336_11.position).x, (manager.ui.mainCamera.transform.position - var_336_11.position).y, (manager.ui.mainCamera.transform.position - var_336_11.position).z)
				var_336_11.localEulerAngles.z = 0
				var_336_11.localEulerAngles.x = 0
				var_336_11.localEulerAngles = var_336_11.localEulerAngles
			end

			if arg_333_1.time_ >= 1.96599999815226 + var_336_12 and arg_333_1.time_ < 1.96599999815226 + var_336_12 + arg_336_0 then
				var_336_11.localPosition = Vector3.New(0, 100, 0)
				var_336_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_336_11.position).x, (manager.ui.mainCamera.transform.position - var_336_11.position).y, (manager.ui.mainCamera.transform.position - var_336_11.position).z)
				var_336_11.localEulerAngles.z = 0
				var_336_11.localEulerAngles.x = 0
				var_336_11.localEulerAngles = var_336_11.localEulerAngles
			end

			local var_336_13 = arg_333_1.actors_["1019ui_story"]

			if 1.96599999815226 < arg_333_1.time_ and arg_333_1.time_ <= 1.96599999815226 + arg_336_0 and not isNil(var_336_13) and arg_333_1.var_.characterEffect1019ui_story == nil then
				arg_333_1.var_.characterEffect1019ui_story = var_336_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_336_14 = 0.034000001847744

			if 1.96599999815226 <= arg_333_1.time_ and arg_333_1.time_ < 1.96599999815226 + var_336_14 and not isNil(var_336_13) then
				if arg_333_1.var_.characterEffect1019ui_story and not isNil(var_336_13) then
					arg_333_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_333_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_333_1.time_ - 1.96599999815226) / var_336_14)
				end
			end

			if arg_333_1.time_ >= 1.96599999815226 + var_336_14 and arg_333_1.time_ < 1.96599999815226 + var_336_14 + arg_336_0 and not isNil(var_336_13) and arg_333_1.var_.characterEffect1019ui_story then
				arg_333_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_333_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_336_15 = arg_333_1.actors_["1097ui_story"].transform

			if 3.8 < arg_333_1.time_ and arg_333_1.time_ <= 3.8 + arg_336_0 then
				arg_333_1.var_.moveOldPos1097ui_story = var_336_15.localPosition
			end

			local var_336_16 = 0.001

			if 3.8 <= arg_333_1.time_ and arg_333_1.time_ < 3.8 + var_336_16 then
				var_336_15.localPosition = Vector3.Lerp(arg_333_1.var_.moveOldPos1097ui_story, Vector3.New(0, -0.54, -6.3), (arg_333_1.time_ - 3.8) / var_336_16)
				var_336_15.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_336_15.position).x, (manager.ui.mainCamera.transform.position - var_336_15.position).y, (manager.ui.mainCamera.transform.position - var_336_15.position).z)
				var_336_15.localEulerAngles.z = 0
				var_336_15.localEulerAngles.x = 0
				var_336_15.localEulerAngles = var_336_15.localEulerAngles
			end

			if arg_333_1.time_ >= 3.8 + var_336_16 and arg_333_1.time_ < 3.8 + var_336_16 + arg_336_0 then
				var_336_15.localPosition = Vector3.New(0, -0.54, -6.3)
				var_336_15.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_336_15.position).x, (manager.ui.mainCamera.transform.position - var_336_15.position).y, (manager.ui.mainCamera.transform.position - var_336_15.position).z)
				var_336_15.localEulerAngles.z = 0
				var_336_15.localEulerAngles.x = 0
				var_336_15.localEulerAngles = var_336_15.localEulerAngles
			end

			local var_336_17 = arg_333_1.actors_["1097ui_story"]

			if 3.8 < arg_333_1.time_ and arg_333_1.time_ <= 3.8 + arg_336_0 and not isNil(var_336_17) and arg_333_1.var_.characterEffect1097ui_story == nil then
				arg_333_1.var_.characterEffect1097ui_story = var_336_17:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_336_18 = 0.200000002980232

			if 3.8 <= arg_333_1.time_ and arg_333_1.time_ < 3.8 + var_336_18 and not isNil(var_336_17) then
				if arg_333_1.var_.characterEffect1097ui_story and not isNil(var_336_17) then
					arg_333_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_333_1.time_ >= 3.8 + var_336_18 and arg_333_1.time_ < 3.8 + var_336_18 + arg_336_0 and not isNil(var_336_17) and arg_333_1.var_.characterEffect1097ui_story then
				arg_333_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 3.8 < arg_333_1.time_ and arg_333_1.time_ <= 3.8 + arg_336_0 then
				arg_333_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			if 3.8 < arg_333_1.time_ and arg_333_1.time_ <= 3.8 + arg_336_0 then
				arg_333_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			if arg_333_1.frameCnt_ <= 1 then
				arg_333_1.dialog_:SetActive(false)
			end

			local var_336_20 = 4
			local var_336_21 = 0.1

			if 4 < arg_333_1.time_ and arg_333_1.time_ <= var_336_20 + arg_336_0 then
				arg_333_1.talkMaxDuration = 0

				arg_333_1.dialog_:SetActive(true)

				arg_333_1.dialogCg_.alpha = 0

				local var_336_22 = LeanTween.value(arg_333_1.dialog_, 0, 1, 0.3)

				var_336_22:setOnUpdate(LuaHelper.FloatAction(function(arg_337_0)
					arg_333_1.dialogCg_.alpha = arg_337_0
				end))
				var_336_22:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_333_1.dialog_)
					var_336_22:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_333_1.duration_ = arg_333_1.duration_ + 0.3

				SetActive(arg_333_1.leftNameGo_, true)

				arg_333_1.leftNameTxt_.text = arg_333_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_333_1.leftNameTxt_.transform)

				arg_333_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_333_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_333_1:RecordName(arg_333_1.leftNameTxt_.text)
				SetActive(arg_333_1.iconTrs_.gameObject, false)
				arg_333_1.callingController_:SetSelectedState("normal")

				local var_336_23 = arg_333_1:GetWordFromCfg(1109703080)
				local var_336_24 = arg_333_1:FormatText(var_336_23.content)

				arg_333_1.text_.text = var_336_24

				LuaForUtil.ClearLinePrefixSymbol(arg_333_1.text_)

				local var_336_26 = 4 <= 0 and var_336_21 or var_336_21 * (utf8.len(var_336_24) / 4)

				if (4 <= 0 and var_336_21 or var_336_21 * (utf8.len(var_336_24) / 4)) > 0 and var_336_21 < var_336_26 then
					arg_333_1.talkMaxDuration = var_336_26
					var_336_20 = var_336_20 + 0.3

					if var_336_26 + var_336_20 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_26 + var_336_20
					end
				end

				arg_333_1.text_.text = var_336_24
				arg_333_1.typewritter.percent = 0

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703080", "story_v_side_new_1109703.awb") ~= 0 then
					local var_336_27 = manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703080", "story_v_side_new_1109703.awb") / 1000

					if var_336_27 + var_336_20 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_27 + var_336_20
					end

					if var_336_23.prefab_name ~= "" and arg_333_1.actors_[var_336_23.prefab_name] ~= nil then
						local var_336_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_333_1.actors_[var_336_23.prefab_name].transform, "story_v_side_new_1109703", "1109703080", "story_v_side_new_1109703.awb")

						arg_333_1:RecordAudio("1109703080", var_336_28)
						arg_333_1:RecordAudio("1109703080", var_336_28)
					else
						arg_333_1:AudioAction("play", "voice", "story_v_side_new_1109703", "1109703080", "story_v_side_new_1109703.awb")
					end

					arg_333_1:RecordHistoryTalkVoice("story_v_side_new_1109703", "1109703080", "story_v_side_new_1109703.awb")
				end

				arg_333_1:RecordContent(arg_333_1.text_.text)
			end

			local var_336_29 = var_336_20 + 0.3
			local var_336_30 = math.max(var_336_21, arg_333_1.talkMaxDuration)

			if var_336_20 + 0.3 <= arg_333_1.time_ and arg_333_1.time_ < var_336_29 + var_336_30 then
				arg_333_1.typewritter.percent = (arg_333_1.time_ - var_336_29) / var_336_30

				arg_333_1.typewritter:SetDirty()
			end

			if arg_333_1.time_ >= var_336_29 + var_336_30 and arg_333_1.time_ < var_336_29 + var_336_30 + arg_336_0 then
				arg_333_1.typewritter.percent = 1

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(true)
			end
		end

		arg_333_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_333_1:InitPlayNodeList()
	end,
	Play1109703081 = function(arg_339_0, arg_339_1)
		arg_339_1.time_ = 0
		arg_339_1.frameCnt_ = 0
		arg_339_1.state_ = "playing"
		arg_339_1.curTalkId_ = 1109703081
		arg_339_1.duration_ = 5

		SetActive(arg_339_1.tipsGo_, false)

		function arg_339_1.onSingleLineFinish_()
			arg_339_1.onSingleLineUpdate_ = nil
			arg_339_1.onSingleLineFinish_ = nil
			arg_339_1.state_ = "waiting"
		end

		function arg_339_1.playNext_(arg_341_0)
			if arg_341_0 == 1 then
				arg_339_0:Play1109703082(arg_339_1)
			end
		end

		function arg_339_1.onSingleLineUpdate_(arg_342_0)
			if 0 < arg_339_1.time_ and arg_339_1.time_ <= 0 + arg_342_0 and not isNil(arg_339_1.actors_["1097ui_story"]) and arg_339_1.var_.characterEffect1097ui_story == nil then
				arg_339_1.var_.characterEffect1097ui_story = arg_339_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_342_0 = 0.200000002980232

			if 0 <= arg_339_1.time_ and arg_339_1.time_ < 0 + var_342_0 and not isNil(arg_339_1.actors_["1097ui_story"]) then
				if arg_339_1.var_.characterEffect1097ui_story and not isNil(arg_339_1.actors_["1097ui_story"]) then
					arg_339_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_339_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_339_1.time_ - 0) / var_342_0)
				end
			end

			if arg_339_1.time_ >= 0 + var_342_0 and arg_339_1.time_ < 0 + var_342_0 + arg_342_0 and not isNil(arg_339_1.actors_["1097ui_story"]) and arg_339_1.var_.characterEffect1097ui_story then
				arg_339_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_339_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_342_1 = 0
			local var_342_2 = 0.8

			if 0 < arg_339_1.time_ and arg_339_1.time_ <= var_342_1 + arg_342_0 then
				arg_339_1.talkMaxDuration = 0
				arg_339_1.dialogCg_.alpha = 1

				arg_339_1.dialog_:SetActive(true)
				SetActive(arg_339_1.leftNameGo_, true)

				arg_339_1.leftNameTxt_.text = arg_339_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_339_1.leftNameTxt_.transform)

				arg_339_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_339_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_339_1:RecordName(arg_339_1.leftNameTxt_.text)
				SetActive(arg_339_1.iconTrs_.gameObject, true)
				arg_339_1.iconController_:SetSelectedState("hero")

				arg_339_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_339_1.callingController_:SetSelectedState("normal")

				arg_339_1.keyicon_.color = Color.New(1, 1, 1)
				arg_339_1.icon_.color = Color.New(1, 1, 1)

				local var_342_3 = arg_339_1:FormatText(arg_339_1:GetWordFromCfg(1109703081).content)

				arg_339_1.text_.text = var_342_3

				LuaForUtil.ClearLinePrefixSymbol(arg_339_1.text_)

				local var_342_5 = 32 <= 0 and var_342_2 or var_342_2 * (utf8.len(var_342_3) / 32)

				if (32 <= 0 and var_342_2 or var_342_2 * (utf8.len(var_342_3) / 32)) > 0 and var_342_2 < var_342_5 then
					arg_339_1.talkMaxDuration = var_342_5

					if var_342_5 + var_342_1 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_5 + var_342_1
					end
				end

				arg_339_1.text_.text = var_342_3
				arg_339_1.typewritter.percent = 0

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(false)
				arg_339_1:RecordContent(arg_339_1.text_.text)
			end

			local var_342_6 = math.max(var_342_2, arg_339_1.talkMaxDuration)

			if var_342_1 <= arg_339_1.time_ and arg_339_1.time_ < var_342_1 + var_342_6 then
				arg_339_1.typewritter.percent = (arg_339_1.time_ - var_342_1) / var_342_6

				arg_339_1.typewritter:SetDirty()
			end

			if arg_339_1.time_ >= var_342_1 + var_342_6 and arg_339_1.time_ < var_342_1 + var_342_6 + arg_342_0 then
				arg_339_1.typewritter.percent = 1

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(true)
			end
		end

		arg_339_1.nodeConfigList_ = {}

		arg_339_1:InitPlayNodeList()
	end,
	Play1109703082 = function(arg_343_0, arg_343_1)
		arg_343_1.time_ = 0
		arg_343_1.frameCnt_ = 0
		arg_343_1.state_ = "playing"
		arg_343_1.curTalkId_ = 1109703082
		arg_343_1.duration_ = 8.83

		local var_343_0 = {
			zh = 5.233,
			ja = 8.833
		}
		local var_343_1 = manager.audio:GetLocalizationFlag()

		if var_343_0[var_343_1] ~= nil then
			arg_343_1.duration_ = var_343_0[var_343_1]
		end

		SetActive(arg_343_1.tipsGo_, false)

		function arg_343_1.onSingleLineFinish_()
			arg_343_1.onSingleLineUpdate_ = nil
			arg_343_1.onSingleLineFinish_ = nil
			arg_343_1.state_ = "waiting"
		end

		function arg_343_1.playNext_(arg_345_0)
			if arg_345_0 == 1 then
				arg_343_0:Play1109703083(arg_343_1)
			end
		end

		function arg_343_1.onSingleLineUpdate_(arg_346_0)
			if 0 < arg_343_1.time_ and arg_343_1.time_ <= 0 + arg_346_0 and not isNil(arg_343_1.actors_["1097ui_story"]) and arg_343_1.var_.characterEffect1097ui_story == nil then
				arg_343_1.var_.characterEffect1097ui_story = arg_343_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_346_0 = 0.200000002980232

			if 0 <= arg_343_1.time_ and arg_343_1.time_ < 0 + var_346_0 and not isNil(arg_343_1.actors_["1097ui_story"]) then
				if arg_343_1.var_.characterEffect1097ui_story and not isNil(arg_343_1.actors_["1097ui_story"]) then
					arg_343_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_343_1.time_ >= 0 + var_346_0 and arg_343_1.time_ < 0 + var_346_0 + arg_346_0 and not isNil(arg_343_1.actors_["1097ui_story"]) and arg_343_1.var_.characterEffect1097ui_story then
				arg_343_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_343_1.time_ and arg_343_1.time_ <= 0 + arg_346_0 then
				arg_343_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			if 0 < arg_343_1.time_ and arg_343_1.time_ <= 0 + arg_346_0 then
				arg_343_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_346_2 = 0
			local var_346_3 = 0.55

			if 0 < arg_343_1.time_ and arg_343_1.time_ <= var_346_2 + arg_346_0 then
				arg_343_1.talkMaxDuration = 0
				arg_343_1.dialogCg_.alpha = 1

				arg_343_1.dialog_:SetActive(true)
				SetActive(arg_343_1.leftNameGo_, true)

				arg_343_1.leftNameTxt_.text = arg_343_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_343_1.leftNameTxt_.transform)

				arg_343_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_343_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_343_1:RecordName(arg_343_1.leftNameTxt_.text)
				SetActive(arg_343_1.iconTrs_.gameObject, false)
				arg_343_1.callingController_:SetSelectedState("normal")

				local var_346_4 = arg_343_1:GetWordFromCfg(1109703082)
				local var_346_5 = arg_343_1:FormatText(var_346_4.content)

				arg_343_1.text_.text = var_346_5

				LuaForUtil.ClearLinePrefixSymbol(arg_343_1.text_)

				local var_346_7 = 22 <= 0 and var_346_3 or var_346_3 * (utf8.len(var_346_5) / 22)

				if (22 <= 0 and var_346_3 or var_346_3 * (utf8.len(var_346_5) / 22)) > 0 and var_346_3 < var_346_7 then
					arg_343_1.talkMaxDuration = var_346_7

					if var_346_7 + var_346_2 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_7 + var_346_2
					end
				end

				arg_343_1.text_.text = var_346_5
				arg_343_1.typewritter.percent = 0

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703082", "story_v_side_new_1109703.awb") ~= 0 then
					local var_346_8 = manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703082", "story_v_side_new_1109703.awb") / 1000

					if var_346_8 + var_346_2 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_8 + var_346_2
					end

					if var_346_4.prefab_name ~= "" and arg_343_1.actors_[var_346_4.prefab_name] ~= nil then
						local var_346_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_343_1.actors_[var_346_4.prefab_name].transform, "story_v_side_new_1109703", "1109703082", "story_v_side_new_1109703.awb")

						arg_343_1:RecordAudio("1109703082", var_346_9)
						arg_343_1:RecordAudio("1109703082", var_346_9)
					else
						arg_343_1:AudioAction("play", "voice", "story_v_side_new_1109703", "1109703082", "story_v_side_new_1109703.awb")
					end

					arg_343_1:RecordHistoryTalkVoice("story_v_side_new_1109703", "1109703082", "story_v_side_new_1109703.awb")
				end

				arg_343_1:RecordContent(arg_343_1.text_.text)
			end

			local var_346_10 = math.max(var_346_3, arg_343_1.talkMaxDuration)

			if var_346_2 <= arg_343_1.time_ and arg_343_1.time_ < var_346_2 + var_346_10 then
				arg_343_1.typewritter.percent = (arg_343_1.time_ - var_346_2) / var_346_10

				arg_343_1.typewritter:SetDirty()
			end

			if arg_343_1.time_ >= var_346_2 + var_346_10 and arg_343_1.time_ < var_346_2 + var_346_10 + arg_346_0 then
				arg_343_1.typewritter.percent = 1

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(true)
			end
		end

		arg_343_1.nodeConfigList_ = {}

		arg_343_1:InitPlayNodeList()
	end,
	Play1109703083 = function(arg_347_0, arg_347_1)
		arg_347_1.time_ = 0
		arg_347_1.frameCnt_ = 0
		arg_347_1.state_ = "playing"
		arg_347_1.curTalkId_ = 1109703083
		arg_347_1.duration_ = 5

		SetActive(arg_347_1.tipsGo_, false)

		function arg_347_1.onSingleLineFinish_()
			arg_347_1.onSingleLineUpdate_ = nil
			arg_347_1.onSingleLineFinish_ = nil
			arg_347_1.state_ = "waiting"
		end

		function arg_347_1.playNext_(arg_349_0)
			if arg_349_0 == 1 then
				arg_347_0:Play1109703084(arg_347_1)
			end
		end

		function arg_347_1.onSingleLineUpdate_(arg_350_0)
			if 0 < arg_347_1.time_ and arg_347_1.time_ <= 0 + arg_350_0 and not isNil(arg_347_1.actors_["1097ui_story"]) and arg_347_1.var_.characterEffect1097ui_story == nil then
				arg_347_1.var_.characterEffect1097ui_story = arg_347_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_350_0 = 0.200000002980232

			if 0 <= arg_347_1.time_ and arg_347_1.time_ < 0 + var_350_0 and not isNil(arg_347_1.actors_["1097ui_story"]) then
				if arg_347_1.var_.characterEffect1097ui_story and not isNil(arg_347_1.actors_["1097ui_story"]) then
					arg_347_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_347_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_347_1.time_ - 0) / var_350_0)
				end
			end

			if arg_347_1.time_ >= 0 + var_350_0 and arg_347_1.time_ < 0 + var_350_0 + arg_350_0 and not isNil(arg_347_1.actors_["1097ui_story"]) and arg_347_1.var_.characterEffect1097ui_story then
				arg_347_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_347_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_350_1 = 0
			local var_350_2 = 0.575

			if 0 < arg_347_1.time_ and arg_347_1.time_ <= var_350_1 + arg_350_0 then
				arg_347_1.talkMaxDuration = 0
				arg_347_1.dialogCg_.alpha = 1

				arg_347_1.dialog_:SetActive(true)
				SetActive(arg_347_1.leftNameGo_, true)

				arg_347_1.leftNameTxt_.text = arg_347_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_347_1.leftNameTxt_.transform)

				arg_347_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_347_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_347_1:RecordName(arg_347_1.leftNameTxt_.text)
				SetActive(arg_347_1.iconTrs_.gameObject, true)
				arg_347_1.iconController_:SetSelectedState("hero")

				arg_347_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_347_1.callingController_:SetSelectedState("normal")

				arg_347_1.keyicon_.color = Color.New(1, 1, 1)
				arg_347_1.icon_.color = Color.New(1, 1, 1)

				local var_350_3 = arg_347_1:FormatText(arg_347_1:GetWordFromCfg(1109703083).content)

				arg_347_1.text_.text = var_350_3

				LuaForUtil.ClearLinePrefixSymbol(arg_347_1.text_)

				local var_350_5 = 23 <= 0 and var_350_2 or var_350_2 * (utf8.len(var_350_3) / 23)

				if (23 <= 0 and var_350_2 or var_350_2 * (utf8.len(var_350_3) / 23)) > 0 and var_350_2 < var_350_5 then
					arg_347_1.talkMaxDuration = var_350_5

					if var_350_5 + var_350_1 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_5 + var_350_1
					end
				end

				arg_347_1.text_.text = var_350_3
				arg_347_1.typewritter.percent = 0

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(false)
				arg_347_1:RecordContent(arg_347_1.text_.text)
			end

			local var_350_6 = math.max(var_350_2, arg_347_1.talkMaxDuration)

			if var_350_1 <= arg_347_1.time_ and arg_347_1.time_ < var_350_1 + var_350_6 then
				arg_347_1.typewritter.percent = (arg_347_1.time_ - var_350_1) / var_350_6

				arg_347_1.typewritter:SetDirty()
			end

			if arg_347_1.time_ >= var_350_1 + var_350_6 and arg_347_1.time_ < var_350_1 + var_350_6 + arg_350_0 then
				arg_347_1.typewritter.percent = 1

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(true)
			end
		end

		arg_347_1.nodeConfigList_ = {}

		arg_347_1:InitPlayNodeList()
	end,
	Play1109703084 = function(arg_351_0, arg_351_1)
		arg_351_1.time_ = 0
		arg_351_1.frameCnt_ = 0
		arg_351_1.state_ = "playing"
		arg_351_1.curTalkId_ = 1109703084
		arg_351_1.duration_ = 24.13

		local var_351_0 = {
			zh = 16,
			ja = 24.133
		}
		local var_351_1 = manager.audio:GetLocalizationFlag()

		if var_351_0[var_351_1] ~= nil then
			arg_351_1.duration_ = var_351_0[var_351_1]
		end

		SetActive(arg_351_1.tipsGo_, false)

		function arg_351_1.onSingleLineFinish_()
			arg_351_1.onSingleLineUpdate_ = nil
			arg_351_1.onSingleLineFinish_ = nil
			arg_351_1.state_ = "waiting"
		end

		function arg_351_1.playNext_(arg_353_0)
			if arg_353_0 == 1 then
				arg_351_0:Play1109703085(arg_351_1)
			end
		end

		function arg_351_1.onSingleLineUpdate_(arg_354_0)
			if 0 < arg_351_1.time_ and arg_351_1.time_ <= 0 + arg_354_0 and not isNil(arg_351_1.actors_["1097ui_story"]) and arg_351_1.var_.characterEffect1097ui_story == nil then
				arg_351_1.var_.characterEffect1097ui_story = arg_351_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_354_0 = 0.200000002980232

			if 0 <= arg_351_1.time_ and arg_351_1.time_ < 0 + var_354_0 and not isNil(arg_351_1.actors_["1097ui_story"]) then
				if arg_351_1.var_.characterEffect1097ui_story and not isNil(arg_351_1.actors_["1097ui_story"]) then
					arg_351_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_351_1.time_ >= 0 + var_354_0 and arg_351_1.time_ < 0 + var_354_0 + arg_354_0 and not isNil(arg_351_1.actors_["1097ui_story"]) and arg_351_1.var_.characterEffect1097ui_story then
				arg_351_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_351_1.time_ and arg_351_1.time_ <= 0 + arg_354_0 then
				arg_351_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action6_1")
			end

			if 0 < arg_351_1.time_ and arg_351_1.time_ <= 0 + arg_354_0 then
				arg_351_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva")
			end

			local var_354_2 = 0
			local var_354_3 = 1.625

			if 0 < arg_351_1.time_ and arg_351_1.time_ <= var_354_2 + arg_354_0 then
				arg_351_1.talkMaxDuration = 0
				arg_351_1.dialogCg_.alpha = 1

				arg_351_1.dialog_:SetActive(true)
				SetActive(arg_351_1.leftNameGo_, true)

				arg_351_1.leftNameTxt_.text = arg_351_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_351_1.leftNameTxt_.transform)

				arg_351_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_351_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_351_1:RecordName(arg_351_1.leftNameTxt_.text)
				SetActive(arg_351_1.iconTrs_.gameObject, false)
				arg_351_1.callingController_:SetSelectedState("normal")

				local var_354_4 = arg_351_1:GetWordFromCfg(1109703084)
				local var_354_5 = arg_351_1:FormatText(var_354_4.content)

				arg_351_1.text_.text = var_354_5

				LuaForUtil.ClearLinePrefixSymbol(arg_351_1.text_)

				local var_354_7 = 65 <= 0 and var_354_3 or var_354_3 * (utf8.len(var_354_5) / 65)

				if (65 <= 0 and var_354_3 or var_354_3 * (utf8.len(var_354_5) / 65)) > 0 and var_354_3 < var_354_7 then
					arg_351_1.talkMaxDuration = var_354_7

					if var_354_7 + var_354_2 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_7 + var_354_2
					end
				end

				arg_351_1.text_.text = var_354_5
				arg_351_1.typewritter.percent = 0

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703084", "story_v_side_new_1109703.awb") ~= 0 then
					local var_354_8 = manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703084", "story_v_side_new_1109703.awb") / 1000

					if var_354_8 + var_354_2 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_8 + var_354_2
					end

					if var_354_4.prefab_name ~= "" and arg_351_1.actors_[var_354_4.prefab_name] ~= nil then
						local var_354_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_351_1.actors_[var_354_4.prefab_name].transform, "story_v_side_new_1109703", "1109703084", "story_v_side_new_1109703.awb")

						arg_351_1:RecordAudio("1109703084", var_354_9)
						arg_351_1:RecordAudio("1109703084", var_354_9)
					else
						arg_351_1:AudioAction("play", "voice", "story_v_side_new_1109703", "1109703084", "story_v_side_new_1109703.awb")
					end

					arg_351_1:RecordHistoryTalkVoice("story_v_side_new_1109703", "1109703084", "story_v_side_new_1109703.awb")
				end

				arg_351_1:RecordContent(arg_351_1.text_.text)
			end

			local var_354_10 = math.max(var_354_3, arg_351_1.talkMaxDuration)

			if var_354_2 <= arg_351_1.time_ and arg_351_1.time_ < var_354_2 + var_354_10 then
				arg_351_1.typewritter.percent = (arg_351_1.time_ - var_354_2) / var_354_10

				arg_351_1.typewritter:SetDirty()
			end

			if arg_351_1.time_ >= var_354_2 + var_354_10 and arg_351_1.time_ < var_354_2 + var_354_10 + arg_354_0 then
				arg_351_1.typewritter.percent = 1

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(true)
			end
		end

		arg_351_1.nodeConfigList_ = {}

		arg_351_1:InitPlayNodeList()
	end,
	Play1109703085 = function(arg_355_0, arg_355_1)
		arg_355_1.time_ = 0
		arg_355_1.frameCnt_ = 0
		arg_355_1.state_ = "playing"
		arg_355_1.curTalkId_ = 1109703085
		arg_355_1.duration_ = 5

		SetActive(arg_355_1.tipsGo_, false)

		function arg_355_1.onSingleLineFinish_()
			arg_355_1.onSingleLineUpdate_ = nil
			arg_355_1.onSingleLineFinish_ = nil
			arg_355_1.state_ = "waiting"
		end

		function arg_355_1.playNext_(arg_357_0)
			if arg_357_0 == 1 then
				arg_355_0:Play1109703086(arg_355_1)
			end
		end

		function arg_355_1.onSingleLineUpdate_(arg_358_0)
			if 0 < arg_355_1.time_ and arg_355_1.time_ <= 0 + arg_358_0 and not isNil(arg_355_1.actors_["1097ui_story"]) and arg_355_1.var_.characterEffect1097ui_story == nil then
				arg_355_1.var_.characterEffect1097ui_story = arg_355_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_358_0 = 0.200000002980232

			if 0 <= arg_355_1.time_ and arg_355_1.time_ < 0 + var_358_0 and not isNil(arg_355_1.actors_["1097ui_story"]) then
				if arg_355_1.var_.characterEffect1097ui_story and not isNil(arg_355_1.actors_["1097ui_story"]) then
					arg_355_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_355_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_355_1.time_ - 0) / var_358_0)
				end
			end

			if arg_355_1.time_ >= 0 + var_358_0 and arg_355_1.time_ < 0 + var_358_0 + arg_358_0 and not isNil(arg_355_1.actors_["1097ui_story"]) and arg_355_1.var_.characterEffect1097ui_story then
				arg_355_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_355_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_358_1 = 0
			local var_358_2 = 0.4

			if 0 < arg_355_1.time_ and arg_355_1.time_ <= var_358_1 + arg_358_0 then
				arg_355_1.talkMaxDuration = 0
				arg_355_1.dialogCg_.alpha = 1

				arg_355_1.dialog_:SetActive(true)
				SetActive(arg_355_1.leftNameGo_, true)

				arg_355_1.leftNameTxt_.text = arg_355_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_355_1.leftNameTxt_.transform)

				arg_355_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_355_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_355_1:RecordName(arg_355_1.leftNameTxt_.text)
				SetActive(arg_355_1.iconTrs_.gameObject, true)
				arg_355_1.iconController_:SetSelectedState("hero")

				arg_355_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_355_1.callingController_:SetSelectedState("normal")

				arg_355_1.keyicon_.color = Color.New(1, 1, 1)
				arg_355_1.icon_.color = Color.New(1, 1, 1)

				local var_358_3 = arg_355_1:FormatText(arg_355_1:GetWordFromCfg(1109703085).content)

				arg_355_1.text_.text = var_358_3

				LuaForUtil.ClearLinePrefixSymbol(arg_355_1.text_)

				local var_358_5 = 16 <= 0 and var_358_2 or var_358_2 * (utf8.len(var_358_3) / 16)

				if (16 <= 0 and var_358_2 or var_358_2 * (utf8.len(var_358_3) / 16)) > 0 and var_358_2 < var_358_5 then
					arg_355_1.talkMaxDuration = var_358_5

					if var_358_5 + var_358_1 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_5 + var_358_1
					end
				end

				arg_355_1.text_.text = var_358_3
				arg_355_1.typewritter.percent = 0

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(false)
				arg_355_1:RecordContent(arg_355_1.text_.text)
			end

			local var_358_6 = math.max(var_358_2, arg_355_1.talkMaxDuration)

			if var_358_1 <= arg_355_1.time_ and arg_355_1.time_ < var_358_1 + var_358_6 then
				arg_355_1.typewritter.percent = (arg_355_1.time_ - var_358_1) / var_358_6

				arg_355_1.typewritter:SetDirty()
			end

			if arg_355_1.time_ >= var_358_1 + var_358_6 and arg_355_1.time_ < var_358_1 + var_358_6 + arg_358_0 then
				arg_355_1.typewritter.percent = 1

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(true)
			end
		end

		arg_355_1.nodeConfigList_ = {}

		arg_355_1:InitPlayNodeList()
	end,
	Play1109703086 = function(arg_359_0, arg_359_1)
		arg_359_1.time_ = 0
		arg_359_1.frameCnt_ = 0
		arg_359_1.state_ = "playing"
		arg_359_1.curTalkId_ = 1109703086
		arg_359_1.duration_ = 2

		SetActive(arg_359_1.tipsGo_, false)

		function arg_359_1.onSingleLineFinish_()
			arg_359_1.onSingleLineUpdate_ = nil
			arg_359_1.onSingleLineFinish_ = nil
			arg_359_1.state_ = "waiting"
		end

		function arg_359_1.playNext_(arg_361_0)
			if arg_361_0 == 1 then
				arg_359_0:Play1109703087(arg_359_1)
			end
		end

		function arg_359_1.onSingleLineUpdate_(arg_362_0)
			if 0 < arg_359_1.time_ and arg_359_1.time_ <= 0 + arg_362_0 then
				arg_359_1.var_.moveOldPos1097ui_story = arg_359_1.actors_["1097ui_story"].transform.localPosition
			end

			local var_362_0 = 0.001

			if 0 <= arg_359_1.time_ and arg_359_1.time_ < 0 + var_362_0 then
				arg_359_1.actors_["1097ui_story"].transform.localPosition = Vector3.Lerp(arg_359_1.var_.moveOldPos1097ui_story, Vector3.New(0, -0.54, -6.3), (arg_359_1.time_ - 0) / var_362_0)
				arg_359_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_359_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_359_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_359_1.actors_["1097ui_story"].transform.position).z)
				arg_359_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_359_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_359_1.actors_["1097ui_story"].transform.localEulerAngles = arg_359_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			if arg_359_1.time_ >= 0 + var_362_0 and arg_359_1.time_ < 0 + var_362_0 + arg_362_0 then
				arg_359_1.actors_["1097ui_story"].transform.localPosition = Vector3.New(0, -0.54, -6.3)
				arg_359_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_359_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_359_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_359_1.actors_["1097ui_story"].transform.position).z)
				arg_359_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_359_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_359_1.actors_["1097ui_story"].transform.localEulerAngles = arg_359_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			local var_362_1 = arg_359_1.actors_["1097ui_story"]

			if 0 < arg_359_1.time_ and arg_359_1.time_ <= 0 + arg_362_0 and not isNil(var_362_1) and arg_359_1.var_.characterEffect1097ui_story == nil then
				arg_359_1.var_.characterEffect1097ui_story = var_362_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_362_2 = 0.200000002980232

			if 0 <= arg_359_1.time_ and arg_359_1.time_ < 0 + var_362_2 and not isNil(var_362_1) then
				if arg_359_1.var_.characterEffect1097ui_story and not isNil(var_362_1) then
					arg_359_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_359_1.time_ >= 0 + var_362_2 and arg_359_1.time_ < 0 + var_362_2 + arg_362_0 and not isNil(var_362_1) and arg_359_1.var_.characterEffect1097ui_story then
				arg_359_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_359_1.time_ and arg_359_1.time_ <= 0 + arg_362_0 then
				arg_359_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action6_2")
			end

			if 0 < arg_359_1.time_ and arg_359_1.time_ <= 0 + arg_362_0 then
				arg_359_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_362_4 = 0
			local var_362_5 = 0.125

			if 0 < arg_359_1.time_ and arg_359_1.time_ <= var_362_4 + arg_362_0 then
				arg_359_1.talkMaxDuration = 0
				arg_359_1.dialogCg_.alpha = 1

				arg_359_1.dialog_:SetActive(true)
				SetActive(arg_359_1.leftNameGo_, true)

				arg_359_1.leftNameTxt_.text = arg_359_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_359_1.leftNameTxt_.transform)

				arg_359_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_359_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_359_1:RecordName(arg_359_1.leftNameTxt_.text)
				SetActive(arg_359_1.iconTrs_.gameObject, false)
				arg_359_1.callingController_:SetSelectedState("normal")

				local var_362_6 = arg_359_1:GetWordFromCfg(1109703086)
				local var_362_7 = arg_359_1:FormatText(var_362_6.content)

				arg_359_1.text_.text = var_362_7

				LuaForUtil.ClearLinePrefixSymbol(arg_359_1.text_)

				local var_362_9 = 5 <= 0 and var_362_5 or var_362_5 * (utf8.len(var_362_7) / 5)

				if (5 <= 0 and var_362_5 or var_362_5 * (utf8.len(var_362_7) / 5)) > 0 and var_362_5 < var_362_9 then
					arg_359_1.talkMaxDuration = var_362_9

					if var_362_9 + var_362_4 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_9 + var_362_4
					end
				end

				arg_359_1.text_.text = var_362_7
				arg_359_1.typewritter.percent = 0

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703086", "story_v_side_new_1109703.awb") ~= 0 then
					local var_362_10 = manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703086", "story_v_side_new_1109703.awb") / 1000

					if var_362_10 + var_362_4 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_10 + var_362_4
					end

					if var_362_6.prefab_name ~= "" and arg_359_1.actors_[var_362_6.prefab_name] ~= nil then
						local var_362_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_359_1.actors_[var_362_6.prefab_name].transform, "story_v_side_new_1109703", "1109703086", "story_v_side_new_1109703.awb")

						arg_359_1:RecordAudio("1109703086", var_362_11)
						arg_359_1:RecordAudio("1109703086", var_362_11)
					else
						arg_359_1:AudioAction("play", "voice", "story_v_side_new_1109703", "1109703086", "story_v_side_new_1109703.awb")
					end

					arg_359_1:RecordHistoryTalkVoice("story_v_side_new_1109703", "1109703086", "story_v_side_new_1109703.awb")
				end

				arg_359_1:RecordContent(arg_359_1.text_.text)
			end

			local var_362_12 = math.max(var_362_5, arg_359_1.talkMaxDuration)

			if var_362_4 <= arg_359_1.time_ and arg_359_1.time_ < var_362_4 + var_362_12 then
				arg_359_1.typewritter.percent = (arg_359_1.time_ - var_362_4) / var_362_12

				arg_359_1.typewritter:SetDirty()
			end

			if arg_359_1.time_ >= var_362_4 + var_362_12 and arg_359_1.time_ < var_362_4 + var_362_12 + arg_362_0 then
				arg_359_1.typewritter.percent = 1

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(true)
			end
		end

		arg_359_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_359_1:InitPlayNodeList()
	end,
	Play1109703087 = function(arg_363_0, arg_363_1)
		arg_363_1.time_ = 0
		arg_363_1.frameCnt_ = 0
		arg_363_1.state_ = "playing"
		arg_363_1.curTalkId_ = 1109703087
		arg_363_1.duration_ = 5

		SetActive(arg_363_1.tipsGo_, false)

		function arg_363_1.onSingleLineFinish_()
			arg_363_1.onSingleLineUpdate_ = nil
			arg_363_1.onSingleLineFinish_ = nil
			arg_363_1.state_ = "waiting"
		end

		function arg_363_1.playNext_(arg_365_0)
			if arg_365_0 == 1 then
				arg_363_0:Play1109703088(arg_363_1)
			end
		end

		function arg_363_1.onSingleLineUpdate_(arg_366_0)
			if 0 < arg_363_1.time_ and arg_363_1.time_ <= 0 + arg_366_0 and not isNil(arg_363_1.actors_["1097ui_story"]) and arg_363_1.var_.characterEffect1097ui_story == nil then
				arg_363_1.var_.characterEffect1097ui_story = arg_363_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_366_0 = 0.200000002980232

			if 0 <= arg_363_1.time_ and arg_363_1.time_ < 0 + var_366_0 and not isNil(arg_363_1.actors_["1097ui_story"]) then
				if arg_363_1.var_.characterEffect1097ui_story and not isNil(arg_363_1.actors_["1097ui_story"]) then
					arg_363_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_363_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_363_1.time_ - 0) / var_366_0)
				end
			end

			if arg_363_1.time_ >= 0 + var_366_0 and arg_363_1.time_ < 0 + var_366_0 + arg_366_0 and not isNil(arg_363_1.actors_["1097ui_story"]) and arg_363_1.var_.characterEffect1097ui_story then
				arg_363_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_363_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_366_1 = 0
			local var_366_2 = 0.675

			if 0 < arg_363_1.time_ and arg_363_1.time_ <= var_366_1 + arg_366_0 then
				arg_363_1.talkMaxDuration = 0
				arg_363_1.dialogCg_.alpha = 1

				arg_363_1.dialog_:SetActive(true)
				SetActive(arg_363_1.leftNameGo_, false)

				arg_363_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_363_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_363_1:RecordName(arg_363_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_363_1.iconTrs_.gameObject, false)
				arg_363_1.callingController_:SetSelectedState("normal")

				local var_366_3 = arg_363_1:FormatText(arg_363_1:GetWordFromCfg(1109703087).content)

				arg_363_1.text_.text = var_366_3

				LuaForUtil.ClearLinePrefixSymbol(arg_363_1.text_)

				local var_366_5 = 27 <= 0 and var_366_2 or var_366_2 * (utf8.len(var_366_3) / 27)

				if (27 <= 0 and var_366_2 or var_366_2 * (utf8.len(var_366_3) / 27)) > 0 and var_366_2 < var_366_5 then
					arg_363_1.talkMaxDuration = var_366_5

					if var_366_5 + var_366_1 > arg_363_1.duration_ then
						arg_363_1.duration_ = var_366_5 + var_366_1
					end
				end

				arg_363_1.text_.text = var_366_3
				arg_363_1.typewritter.percent = 0

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(false)
				arg_363_1:RecordContent(arg_363_1.text_.text)
			end

			local var_366_6 = math.max(var_366_2, arg_363_1.talkMaxDuration)

			if var_366_1 <= arg_363_1.time_ and arg_363_1.time_ < var_366_1 + var_366_6 then
				arg_363_1.typewritter.percent = (arg_363_1.time_ - var_366_1) / var_366_6

				arg_363_1.typewritter:SetDirty()
			end

			if arg_363_1.time_ >= var_366_1 + var_366_6 and arg_363_1.time_ < var_366_1 + var_366_6 + arg_366_0 then
				arg_363_1.typewritter.percent = 1

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(true)
			end
		end

		arg_363_1.nodeConfigList_ = {}

		arg_363_1:InitPlayNodeList()
	end,
	Play1109703088 = function(arg_367_0, arg_367_1)
		arg_367_1.time_ = 0
		arg_367_1.frameCnt_ = 0
		arg_367_1.state_ = "playing"
		arg_367_1.curTalkId_ = 1109703088
		arg_367_1.duration_ = 5

		SetActive(arg_367_1.tipsGo_, false)

		function arg_367_1.onSingleLineFinish_()
			arg_367_1.onSingleLineUpdate_ = nil
			arg_367_1.onSingleLineFinish_ = nil
			arg_367_1.state_ = "waiting"
		end

		function arg_367_1.playNext_(arg_369_0)
			if arg_369_0 == 1 then
				arg_367_0:Play1109703089(arg_367_1)
			end
		end

		function arg_367_1.onSingleLineUpdate_(arg_370_0)
			local var_370_0 = 1.125

			if 0 < arg_367_1.time_ and arg_367_1.time_ <= 0 + arg_370_0 then
				arg_367_1.talkMaxDuration = 0
				arg_367_1.dialogCg_.alpha = 1

				arg_367_1.dialog_:SetActive(true)
				SetActive(arg_367_1.leftNameGo_, true)

				arg_367_1.leftNameTxt_.text = arg_367_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_367_1.leftNameTxt_.transform)

				arg_367_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_367_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_367_1:RecordName(arg_367_1.leftNameTxt_.text)
				SetActive(arg_367_1.iconTrs_.gameObject, true)
				arg_367_1.iconController_:SetSelectedState("hero")

				arg_367_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_367_1.callingController_:SetSelectedState("normal")

				arg_367_1.keyicon_.color = Color.New(1, 1, 1)
				arg_367_1.icon_.color = Color.New(1, 1, 1)

				local var_370_1 = arg_367_1:FormatText(arg_367_1:GetWordFromCfg(1109703088).content)

				arg_367_1.text_.text = var_370_1

				LuaForUtil.ClearLinePrefixSymbol(arg_367_1.text_)

				local var_370_3 = 45 <= 0 and var_370_0 or var_370_0 * (utf8.len(var_370_1) / 45)

				if (45 <= 0 and var_370_0 or var_370_0 * (utf8.len(var_370_1) / 45)) > 0 and var_370_0 < var_370_3 then
					arg_367_1.talkMaxDuration = var_370_3

					if var_370_3 + 0 > arg_367_1.duration_ then
						arg_367_1.duration_ = var_370_3 + 0
					end
				end

				arg_367_1.text_.text = var_370_1
				arg_367_1.typewritter.percent = 0

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(false)
				arg_367_1:RecordContent(arg_367_1.text_.text)
			end

			local var_370_4 = math.max(var_370_0, arg_367_1.talkMaxDuration)

			if 0 <= arg_367_1.time_ and arg_367_1.time_ < 0 + var_370_4 then
				arg_367_1.typewritter.percent = (arg_367_1.time_ - 0) / var_370_4

				arg_367_1.typewritter:SetDirty()
			end

			if arg_367_1.time_ >= 0 + var_370_4 and arg_367_1.time_ < 0 + var_370_4 + arg_370_0 then
				arg_367_1.typewritter.percent = 1

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(true)
			end
		end

		arg_367_1.nodeConfigList_ = {}

		arg_367_1:InitPlayNodeList()
	end,
	Play1109703089 = function(arg_371_0, arg_371_1)
		arg_371_1.time_ = 0
		arg_371_1.frameCnt_ = 0
		arg_371_1.state_ = "playing"
		arg_371_1.curTalkId_ = 1109703089
		arg_371_1.duration_ = 2

		SetActive(arg_371_1.tipsGo_, false)

		function arg_371_1.onSingleLineFinish_()
			arg_371_1.onSingleLineUpdate_ = nil
			arg_371_1.onSingleLineFinish_ = nil
			arg_371_1.state_ = "waiting"
		end

		function arg_371_1.playNext_(arg_373_0)
			if arg_373_0 == 1 then
				arg_371_0:Play1109703090(arg_371_1)
			end
		end

		function arg_371_1.onSingleLineUpdate_(arg_374_0)
			if 0 < arg_371_1.time_ and arg_371_1.time_ <= 0 + arg_374_0 then
				arg_371_1.var_.moveOldPos1097ui_story = arg_371_1.actors_["1097ui_story"].transform.localPosition
			end

			local var_374_0 = 0.001

			if 0 <= arg_371_1.time_ and arg_371_1.time_ < 0 + var_374_0 then
				arg_371_1.actors_["1097ui_story"].transform.localPosition = Vector3.Lerp(arg_371_1.var_.moveOldPos1097ui_story, Vector3.New(0, -0.54, -6.3), (arg_371_1.time_ - 0) / var_374_0)
				arg_371_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_371_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_371_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_371_1.actors_["1097ui_story"].transform.position).z)
				arg_371_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_371_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_371_1.actors_["1097ui_story"].transform.localEulerAngles = arg_371_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			if arg_371_1.time_ >= 0 + var_374_0 and arg_371_1.time_ < 0 + var_374_0 + arg_374_0 then
				arg_371_1.actors_["1097ui_story"].transform.localPosition = Vector3.New(0, -0.54, -6.3)
				arg_371_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_371_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_371_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_371_1.actors_["1097ui_story"].transform.position).z)
				arg_371_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_371_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_371_1.actors_["1097ui_story"].transform.localEulerAngles = arg_371_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			local var_374_1 = arg_371_1.actors_["1097ui_story"]

			if 0 < arg_371_1.time_ and arg_371_1.time_ <= 0 + arg_374_0 and not isNil(var_374_1) and arg_371_1.var_.characterEffect1097ui_story == nil then
				arg_371_1.var_.characterEffect1097ui_story = var_374_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_374_2 = 0.200000002980232

			if 0 <= arg_371_1.time_ and arg_371_1.time_ < 0 + var_374_2 and not isNil(var_374_1) then
				if arg_371_1.var_.characterEffect1097ui_story and not isNil(var_374_1) then
					arg_371_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_371_1.time_ >= 0 + var_374_2 and arg_371_1.time_ < 0 + var_374_2 + arg_374_0 and not isNil(var_374_1) and arg_371_1.var_.characterEffect1097ui_story then
				arg_371_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_371_1.time_ and arg_371_1.time_ <= 0 + arg_374_0 then
				arg_371_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			if 0 < arg_371_1.time_ and arg_371_1.time_ <= 0 + arg_374_0 then
				arg_371_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_374_4 = 0
			local var_374_5 = 0.15

			if 0 < arg_371_1.time_ and arg_371_1.time_ <= var_374_4 + arg_374_0 then
				arg_371_1.talkMaxDuration = 0
				arg_371_1.dialogCg_.alpha = 1

				arg_371_1.dialog_:SetActive(true)
				SetActive(arg_371_1.leftNameGo_, true)

				arg_371_1.leftNameTxt_.text = arg_371_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_371_1.leftNameTxt_.transform)

				arg_371_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_371_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_371_1:RecordName(arg_371_1.leftNameTxt_.text)
				SetActive(arg_371_1.iconTrs_.gameObject, false)
				arg_371_1.callingController_:SetSelectedState("normal")

				local var_374_6 = arg_371_1:GetWordFromCfg(1109703089)
				local var_374_7 = arg_371_1:FormatText(var_374_6.content)

				arg_371_1.text_.text = var_374_7

				LuaForUtil.ClearLinePrefixSymbol(arg_371_1.text_)

				local var_374_9 = 6 <= 0 and var_374_5 or var_374_5 * (utf8.len(var_374_7) / 6)

				if (6 <= 0 and var_374_5 or var_374_5 * (utf8.len(var_374_7) / 6)) > 0 and var_374_5 < var_374_9 then
					arg_371_1.talkMaxDuration = var_374_9

					if var_374_9 + var_374_4 > arg_371_1.duration_ then
						arg_371_1.duration_ = var_374_9 + var_374_4
					end
				end

				arg_371_1.text_.text = var_374_7
				arg_371_1.typewritter.percent = 0

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703089", "story_v_side_new_1109703.awb") ~= 0 then
					local var_374_10 = manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703089", "story_v_side_new_1109703.awb") / 1000

					if var_374_10 + var_374_4 > arg_371_1.duration_ then
						arg_371_1.duration_ = var_374_10 + var_374_4
					end

					if var_374_6.prefab_name ~= "" and arg_371_1.actors_[var_374_6.prefab_name] ~= nil then
						local var_374_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_371_1.actors_[var_374_6.prefab_name].transform, "story_v_side_new_1109703", "1109703089", "story_v_side_new_1109703.awb")

						arg_371_1:RecordAudio("1109703089", var_374_11)
						arg_371_1:RecordAudio("1109703089", var_374_11)
					else
						arg_371_1:AudioAction("play", "voice", "story_v_side_new_1109703", "1109703089", "story_v_side_new_1109703.awb")
					end

					arg_371_1:RecordHistoryTalkVoice("story_v_side_new_1109703", "1109703089", "story_v_side_new_1109703.awb")
				end

				arg_371_1:RecordContent(arg_371_1.text_.text)
			end

			local var_374_12 = math.max(var_374_5, arg_371_1.talkMaxDuration)

			if var_374_4 <= arg_371_1.time_ and arg_371_1.time_ < var_374_4 + var_374_12 then
				arg_371_1.typewritter.percent = (arg_371_1.time_ - var_374_4) / var_374_12

				arg_371_1.typewritter:SetDirty()
			end

			if arg_371_1.time_ >= var_374_4 + var_374_12 and arg_371_1.time_ < var_374_4 + var_374_12 + arg_374_0 then
				arg_371_1.typewritter.percent = 1

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(true)
			end
		end

		arg_371_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_371_1:InitPlayNodeList()
	end,
	Play1109703090 = function(arg_375_0, arg_375_1)
		arg_375_1.time_ = 0
		arg_375_1.frameCnt_ = 0
		arg_375_1.state_ = "playing"
		arg_375_1.curTalkId_ = 1109703090
		arg_375_1.duration_ = 5

		SetActive(arg_375_1.tipsGo_, false)

		function arg_375_1.onSingleLineFinish_()
			arg_375_1.onSingleLineUpdate_ = nil
			arg_375_1.onSingleLineFinish_ = nil
			arg_375_1.state_ = "waiting"
		end

		function arg_375_1.playNext_(arg_377_0)
			if arg_377_0 == 1 then
				arg_375_0:Play1109703091(arg_375_1)
			end
		end

		function arg_375_1.onSingleLineUpdate_(arg_378_0)
			if 0 < arg_375_1.time_ and arg_375_1.time_ <= 0 + arg_378_0 and not isNil(arg_375_1.actors_["1097ui_story"]) and arg_375_1.var_.characterEffect1097ui_story == nil then
				arg_375_1.var_.characterEffect1097ui_story = arg_375_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_378_0 = 0.200000002980232

			if 0 <= arg_375_1.time_ and arg_375_1.time_ < 0 + var_378_0 and not isNil(arg_375_1.actors_["1097ui_story"]) then
				if arg_375_1.var_.characterEffect1097ui_story and not isNil(arg_375_1.actors_["1097ui_story"]) then
					arg_375_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_375_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_375_1.time_ - 0) / var_378_0)
				end
			end

			if arg_375_1.time_ >= 0 + var_378_0 and arg_375_1.time_ < 0 + var_378_0 + arg_378_0 and not isNil(arg_375_1.actors_["1097ui_story"]) and arg_375_1.var_.characterEffect1097ui_story then
				arg_375_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_375_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_378_1 = 0
			local var_378_2 = 1.125

			if 0 < arg_375_1.time_ and arg_375_1.time_ <= var_378_1 + arg_378_0 then
				arg_375_1.talkMaxDuration = 0
				arg_375_1.dialogCg_.alpha = 1

				arg_375_1.dialog_:SetActive(true)
				SetActive(arg_375_1.leftNameGo_, true)

				arg_375_1.leftNameTxt_.text = arg_375_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_375_1.leftNameTxt_.transform)

				arg_375_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_375_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_375_1:RecordName(arg_375_1.leftNameTxt_.text)
				SetActive(arg_375_1.iconTrs_.gameObject, true)
				arg_375_1.iconController_:SetSelectedState("hero")

				arg_375_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_375_1.callingController_:SetSelectedState("normal")

				arg_375_1.keyicon_.color = Color.New(1, 1, 1)
				arg_375_1.icon_.color = Color.New(1, 1, 1)

				local var_378_3 = arg_375_1:FormatText(arg_375_1:GetWordFromCfg(1109703090).content)

				arg_375_1.text_.text = var_378_3

				LuaForUtil.ClearLinePrefixSymbol(arg_375_1.text_)

				local var_378_5 = 45 <= 0 and var_378_2 or var_378_2 * (utf8.len(var_378_3) / 45)

				if (45 <= 0 and var_378_2 or var_378_2 * (utf8.len(var_378_3) / 45)) > 0 and var_378_2 < var_378_5 then
					arg_375_1.talkMaxDuration = var_378_5

					if var_378_5 + var_378_1 > arg_375_1.duration_ then
						arg_375_1.duration_ = var_378_5 + var_378_1
					end
				end

				arg_375_1.text_.text = var_378_3
				arg_375_1.typewritter.percent = 0

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(false)
				arg_375_1:RecordContent(arg_375_1.text_.text)
			end

			local var_378_6 = math.max(var_378_2, arg_375_1.talkMaxDuration)

			if var_378_1 <= arg_375_1.time_ and arg_375_1.time_ < var_378_1 + var_378_6 then
				arg_375_1.typewritter.percent = (arg_375_1.time_ - var_378_1) / var_378_6

				arg_375_1.typewritter:SetDirty()
			end

			if arg_375_1.time_ >= var_378_1 + var_378_6 and arg_375_1.time_ < var_378_1 + var_378_6 + arg_378_0 then
				arg_375_1.typewritter.percent = 1

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(true)
			end
		end

		arg_375_1.nodeConfigList_ = {}

		arg_375_1:InitPlayNodeList()
	end,
	Play1109703091 = function(arg_379_0, arg_379_1)
		arg_379_1.time_ = 0
		arg_379_1.frameCnt_ = 0
		arg_379_1.state_ = "playing"
		arg_379_1.curTalkId_ = 1109703091
		arg_379_1.duration_ = 5

		local var_379_0 = {
			zh = 5,
			ja = 4.8
		}
		local var_379_1 = manager.audio:GetLocalizationFlag()

		if var_379_0[var_379_1] ~= nil then
			arg_379_1.duration_ = var_379_0[var_379_1]
		end

		SetActive(arg_379_1.tipsGo_, false)

		function arg_379_1.onSingleLineFinish_()
			arg_379_1.onSingleLineUpdate_ = nil
			arg_379_1.onSingleLineFinish_ = nil
			arg_379_1.state_ = "waiting"
		end

		function arg_379_1.playNext_(arg_381_0)
			if arg_381_0 == 1 then
				arg_379_0:Play1109703092(arg_379_1)
			end
		end

		function arg_379_1.onSingleLineUpdate_(arg_382_0)
			if 0 < arg_379_1.time_ and arg_379_1.time_ <= 0 + arg_382_0 then
				arg_379_1.var_.moveOldPos1097ui_story = arg_379_1.actors_["1097ui_story"].transform.localPosition
			end

			local var_382_0 = 0.001

			if 0 <= arg_379_1.time_ and arg_379_1.time_ < 0 + var_382_0 then
				arg_379_1.actors_["1097ui_story"].transform.localPosition = Vector3.Lerp(arg_379_1.var_.moveOldPos1097ui_story, Vector3.New(0, -0.54, -6.3), (arg_379_1.time_ - 0) / var_382_0)
				arg_379_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_379_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_379_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_379_1.actors_["1097ui_story"].transform.position).z)
				arg_379_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_379_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_379_1.actors_["1097ui_story"].transform.localEulerAngles = arg_379_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			if arg_379_1.time_ >= 0 + var_382_0 and arg_379_1.time_ < 0 + var_382_0 + arg_382_0 then
				arg_379_1.actors_["1097ui_story"].transform.localPosition = Vector3.New(0, -0.54, -6.3)
				arg_379_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_379_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_379_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_379_1.actors_["1097ui_story"].transform.position).z)
				arg_379_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_379_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_379_1.actors_["1097ui_story"].transform.localEulerAngles = arg_379_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			local var_382_1 = arg_379_1.actors_["1097ui_story"]

			if 0 < arg_379_1.time_ and arg_379_1.time_ <= 0 + arg_382_0 and not isNil(var_382_1) and arg_379_1.var_.characterEffect1097ui_story == nil then
				arg_379_1.var_.characterEffect1097ui_story = var_382_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_382_2 = 0.200000002980232

			if 0 <= arg_379_1.time_ and arg_379_1.time_ < 0 + var_382_2 and not isNil(var_382_1) then
				if arg_379_1.var_.characterEffect1097ui_story and not isNil(var_382_1) then
					arg_379_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_379_1.time_ >= 0 + var_382_2 and arg_379_1.time_ < 0 + var_382_2 + arg_382_0 and not isNil(var_382_1) and arg_379_1.var_.characterEffect1097ui_story then
				arg_379_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_382_4 = 0
			local var_382_5 = 0.55

			if 0 < arg_379_1.time_ and arg_379_1.time_ <= var_382_4 + arg_382_0 then
				arg_379_1.talkMaxDuration = 0
				arg_379_1.dialogCg_.alpha = 1

				arg_379_1.dialog_:SetActive(true)
				SetActive(arg_379_1.leftNameGo_, true)

				arg_379_1.leftNameTxt_.text = arg_379_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_379_1.leftNameTxt_.transform)

				arg_379_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_379_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_379_1:RecordName(arg_379_1.leftNameTxt_.text)
				SetActive(arg_379_1.iconTrs_.gameObject, false)
				arg_379_1.callingController_:SetSelectedState("normal")

				local var_382_6 = arg_379_1:GetWordFromCfg(1109703091)
				local var_382_7 = arg_379_1:FormatText(var_382_6.content)

				arg_379_1.text_.text = var_382_7

				LuaForUtil.ClearLinePrefixSymbol(arg_379_1.text_)

				local var_382_9 = 22 <= 0 and var_382_5 or var_382_5 * (utf8.len(var_382_7) / 22)

				if (22 <= 0 and var_382_5 or var_382_5 * (utf8.len(var_382_7) / 22)) > 0 and var_382_5 < var_382_9 then
					arg_379_1.talkMaxDuration = var_382_9

					if var_382_9 + var_382_4 > arg_379_1.duration_ then
						arg_379_1.duration_ = var_382_9 + var_382_4
					end
				end

				arg_379_1.text_.text = var_382_7
				arg_379_1.typewritter.percent = 0

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703091", "story_v_side_new_1109703.awb") ~= 0 then
					local var_382_10 = manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703091", "story_v_side_new_1109703.awb") / 1000

					if var_382_10 + var_382_4 > arg_379_1.duration_ then
						arg_379_1.duration_ = var_382_10 + var_382_4
					end

					if var_382_6.prefab_name ~= "" and arg_379_1.actors_[var_382_6.prefab_name] ~= nil then
						local var_382_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_379_1.actors_[var_382_6.prefab_name].transform, "story_v_side_new_1109703", "1109703091", "story_v_side_new_1109703.awb")

						arg_379_1:RecordAudio("1109703091", var_382_11)
						arg_379_1:RecordAudio("1109703091", var_382_11)
					else
						arg_379_1:AudioAction("play", "voice", "story_v_side_new_1109703", "1109703091", "story_v_side_new_1109703.awb")
					end

					arg_379_1:RecordHistoryTalkVoice("story_v_side_new_1109703", "1109703091", "story_v_side_new_1109703.awb")
				end

				arg_379_1:RecordContent(arg_379_1.text_.text)
			end

			local var_382_12 = math.max(var_382_5, arg_379_1.talkMaxDuration)

			if var_382_4 <= arg_379_1.time_ and arg_379_1.time_ < var_382_4 + var_382_12 then
				arg_379_1.typewritter.percent = (arg_379_1.time_ - var_382_4) / var_382_12

				arg_379_1.typewritter:SetDirty()
			end

			if arg_379_1.time_ >= var_382_4 + var_382_12 and arg_379_1.time_ < var_382_4 + var_382_12 + arg_382_0 then
				arg_379_1.typewritter.percent = 1

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(true)
			end
		end

		arg_379_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_379_1:InitPlayNodeList()
	end,
	Play1109703092 = function(arg_383_0, arg_383_1)
		arg_383_1.time_ = 0
		arg_383_1.frameCnt_ = 0
		arg_383_1.state_ = "playing"
		arg_383_1.curTalkId_ = 1109703092
		arg_383_1.duration_ = 5

		SetActive(arg_383_1.tipsGo_, false)

		function arg_383_1.onSingleLineFinish_()
			arg_383_1.onSingleLineUpdate_ = nil
			arg_383_1.onSingleLineFinish_ = nil
			arg_383_1.state_ = "waiting"
		end

		function arg_383_1.playNext_(arg_385_0)
			if arg_385_0 == 1 then
				arg_383_0:Play1109703093(arg_383_1)
			end
		end

		function arg_383_1.onSingleLineUpdate_(arg_386_0)
			if 0 < arg_383_1.time_ and arg_383_1.time_ <= 0 + arg_386_0 and not isNil(arg_383_1.actors_["1097ui_story"]) and arg_383_1.var_.characterEffect1097ui_story == nil then
				arg_383_1.var_.characterEffect1097ui_story = arg_383_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_386_0 = 0.200000002980232

			if 0 <= arg_383_1.time_ and arg_383_1.time_ < 0 + var_386_0 and not isNil(arg_383_1.actors_["1097ui_story"]) then
				if arg_383_1.var_.characterEffect1097ui_story and not isNil(arg_383_1.actors_["1097ui_story"]) then
					arg_383_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_383_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_383_1.time_ - 0) / var_386_0)
				end
			end

			if arg_383_1.time_ >= 0 + var_386_0 and arg_383_1.time_ < 0 + var_386_0 + arg_386_0 and not isNil(arg_383_1.actors_["1097ui_story"]) and arg_383_1.var_.characterEffect1097ui_story then
				arg_383_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_383_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_386_1 = 0
			local var_386_2 = 0.35

			if 0 < arg_383_1.time_ and arg_383_1.time_ <= var_386_1 + arg_386_0 then
				arg_383_1.talkMaxDuration = 0
				arg_383_1.dialogCg_.alpha = 1

				arg_383_1.dialog_:SetActive(true)
				SetActive(arg_383_1.leftNameGo_, false)

				arg_383_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_383_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_383_1:RecordName(arg_383_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_383_1.iconTrs_.gameObject, false)
				arg_383_1.callingController_:SetSelectedState("normal")

				local var_386_3 = arg_383_1:FormatText(arg_383_1:GetWordFromCfg(1109703092).content)

				arg_383_1.text_.text = var_386_3

				LuaForUtil.ClearLinePrefixSymbol(arg_383_1.text_)

				local var_386_5 = 14 <= 0 and var_386_2 or var_386_2 * (utf8.len(var_386_3) / 14)

				if (14 <= 0 and var_386_2 or var_386_2 * (utf8.len(var_386_3) / 14)) > 0 and var_386_2 < var_386_5 then
					arg_383_1.talkMaxDuration = var_386_5

					if var_386_5 + var_386_1 > arg_383_1.duration_ then
						arg_383_1.duration_ = var_386_5 + var_386_1
					end
				end

				arg_383_1.text_.text = var_386_3
				arg_383_1.typewritter.percent = 0

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(false)
				arg_383_1:RecordContent(arg_383_1.text_.text)
			end

			local var_386_6 = math.max(var_386_2, arg_383_1.talkMaxDuration)

			if var_386_1 <= arg_383_1.time_ and arg_383_1.time_ < var_386_1 + var_386_6 then
				arg_383_1.typewritter.percent = (arg_383_1.time_ - var_386_1) / var_386_6

				arg_383_1.typewritter:SetDirty()
			end

			if arg_383_1.time_ >= var_386_1 + var_386_6 and arg_383_1.time_ < var_386_1 + var_386_6 + arg_386_0 then
				arg_383_1.typewritter.percent = 1

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(true)
			end
		end

		arg_383_1.nodeConfigList_ = {}

		arg_383_1:InitPlayNodeList()
	end,
	Play1109703093 = function(arg_387_0, arg_387_1)
		arg_387_1.time_ = 0
		arg_387_1.frameCnt_ = 0
		arg_387_1.state_ = "playing"
		arg_387_1.curTalkId_ = 1109703093
		arg_387_1.duration_ = 5

		SetActive(arg_387_1.tipsGo_, false)

		function arg_387_1.onSingleLineFinish_()
			arg_387_1.onSingleLineUpdate_ = nil
			arg_387_1.onSingleLineFinish_ = nil
			arg_387_1.state_ = "waiting"
		end

		function arg_387_1.playNext_(arg_389_0)
			if arg_389_0 == 1 then
				arg_387_0:Play1109703094(arg_387_1)
			end
		end

		function arg_387_1.onSingleLineUpdate_(arg_390_0)
			local var_390_0 = 1.175

			if 0 < arg_387_1.time_ and arg_387_1.time_ <= 0 + arg_390_0 then
				arg_387_1.talkMaxDuration = 0
				arg_387_1.dialogCg_.alpha = 1

				arg_387_1.dialog_:SetActive(true)
				SetActive(arg_387_1.leftNameGo_, true)

				arg_387_1.leftNameTxt_.text = arg_387_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_387_1.leftNameTxt_.transform)

				arg_387_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_387_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_387_1:RecordName(arg_387_1.leftNameTxt_.text)
				SetActive(arg_387_1.iconTrs_.gameObject, true)
				arg_387_1.iconController_:SetSelectedState("hero")

				arg_387_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_387_1.callingController_:SetSelectedState("normal")

				arg_387_1.keyicon_.color = Color.New(1, 1, 1)
				arg_387_1.icon_.color = Color.New(1, 1, 1)

				local var_390_1 = arg_387_1:FormatText(arg_387_1:GetWordFromCfg(1109703093).content)

				arg_387_1.text_.text = var_390_1

				LuaForUtil.ClearLinePrefixSymbol(arg_387_1.text_)

				local var_390_3 = 47 <= 0 and var_390_0 or var_390_0 * (utf8.len(var_390_1) / 47)

				if (47 <= 0 and var_390_0 or var_390_0 * (utf8.len(var_390_1) / 47)) > 0 and var_390_0 < var_390_3 then
					arg_387_1.talkMaxDuration = var_390_3

					if var_390_3 + 0 > arg_387_1.duration_ then
						arg_387_1.duration_ = var_390_3 + 0
					end
				end

				arg_387_1.text_.text = var_390_1
				arg_387_1.typewritter.percent = 0

				arg_387_1.typewritter:SetDirty()
				arg_387_1:ShowNextGo(false)
				arg_387_1:RecordContent(arg_387_1.text_.text)
			end

			local var_390_4 = math.max(var_390_0, arg_387_1.talkMaxDuration)

			if 0 <= arg_387_1.time_ and arg_387_1.time_ < 0 + var_390_4 then
				arg_387_1.typewritter.percent = (arg_387_1.time_ - 0) / var_390_4

				arg_387_1.typewritter:SetDirty()
			end

			if arg_387_1.time_ >= 0 + var_390_4 and arg_387_1.time_ < 0 + var_390_4 + arg_390_0 then
				arg_387_1.typewritter.percent = 1

				arg_387_1.typewritter:SetDirty()
				arg_387_1:ShowNextGo(true)
			end
		end

		arg_387_1.nodeConfigList_ = {}

		arg_387_1:InitPlayNodeList()
	end,
	Play1109703094 = function(arg_391_0, arg_391_1)
		arg_391_1.time_ = 0
		arg_391_1.frameCnt_ = 0
		arg_391_1.state_ = "playing"
		arg_391_1.curTalkId_ = 1109703094
		arg_391_1.duration_ = 3.8

		SetActive(arg_391_1.tipsGo_, false)

		function arg_391_1.onSingleLineFinish_()
			arg_391_1.onSingleLineUpdate_ = nil
			arg_391_1.onSingleLineFinish_ = nil
			arg_391_1.state_ = "waiting"
		end

		function arg_391_1.playNext_(arg_393_0)
			if arg_393_0 == 1 then
				arg_391_0:Play1109703095(arg_391_1)
			end
		end

		function arg_391_1.onSingleLineUpdate_(arg_394_0)
			if 0 < arg_391_1.time_ and arg_391_1.time_ <= 0 + arg_394_0 and not isNil(arg_391_1.actors_["1097ui_story"]) and arg_391_1.var_.characterEffect1097ui_story == nil then
				arg_391_1.var_.characterEffect1097ui_story = arg_391_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_394_0 = 0.200000002980232

			if 0 <= arg_391_1.time_ and arg_391_1.time_ < 0 + var_394_0 and not isNil(arg_391_1.actors_["1097ui_story"]) then
				if arg_391_1.var_.characterEffect1097ui_story and not isNil(arg_391_1.actors_["1097ui_story"]) then
					arg_391_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_391_1.time_ >= 0 + var_394_0 and arg_391_1.time_ < 0 + var_394_0 + arg_394_0 and not isNil(arg_391_1.actors_["1097ui_story"]) and arg_391_1.var_.characterEffect1097ui_story then
				arg_391_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_391_1.time_ and arg_391_1.time_ <= 0 + arg_394_0 then
				arg_391_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action6_1")
			end

			if 0 < arg_391_1.time_ and arg_391_1.time_ <= 0 + arg_394_0 then
				arg_391_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_394_2 = 0
			local var_394_3 = 0.45

			if 0 < arg_391_1.time_ and arg_391_1.time_ <= var_394_2 + arg_394_0 then
				arg_391_1.talkMaxDuration = 0
				arg_391_1.dialogCg_.alpha = 1

				arg_391_1.dialog_:SetActive(true)
				SetActive(arg_391_1.leftNameGo_, true)

				arg_391_1.leftNameTxt_.text = arg_391_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_391_1.leftNameTxt_.transform)

				arg_391_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_391_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_391_1:RecordName(arg_391_1.leftNameTxt_.text)
				SetActive(arg_391_1.iconTrs_.gameObject, false)
				arg_391_1.callingController_:SetSelectedState("normal")

				local var_394_4 = arg_391_1:GetWordFromCfg(1109703094)
				local var_394_5 = arg_391_1:FormatText(var_394_4.content)

				arg_391_1.text_.text = var_394_5

				LuaForUtil.ClearLinePrefixSymbol(arg_391_1.text_)

				local var_394_7 = 18 <= 0 and var_394_3 or var_394_3 * (utf8.len(var_394_5) / 18)

				if (18 <= 0 and var_394_3 or var_394_3 * (utf8.len(var_394_5) / 18)) > 0 and var_394_3 < var_394_7 then
					arg_391_1.talkMaxDuration = var_394_7

					if var_394_7 + var_394_2 > arg_391_1.duration_ then
						arg_391_1.duration_ = var_394_7 + var_394_2
					end
				end

				arg_391_1.text_.text = var_394_5
				arg_391_1.typewritter.percent = 0

				arg_391_1.typewritter:SetDirty()
				arg_391_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703094", "story_v_side_new_1109703.awb") ~= 0 then
					local var_394_8 = manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703094", "story_v_side_new_1109703.awb") / 1000

					if var_394_8 + var_394_2 > arg_391_1.duration_ then
						arg_391_1.duration_ = var_394_8 + var_394_2
					end

					if var_394_4.prefab_name ~= "" and arg_391_1.actors_[var_394_4.prefab_name] ~= nil then
						local var_394_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_391_1.actors_[var_394_4.prefab_name].transform, "story_v_side_new_1109703", "1109703094", "story_v_side_new_1109703.awb")

						arg_391_1:RecordAudio("1109703094", var_394_9)
						arg_391_1:RecordAudio("1109703094", var_394_9)
					else
						arg_391_1:AudioAction("play", "voice", "story_v_side_new_1109703", "1109703094", "story_v_side_new_1109703.awb")
					end

					arg_391_1:RecordHistoryTalkVoice("story_v_side_new_1109703", "1109703094", "story_v_side_new_1109703.awb")
				end

				arg_391_1:RecordContent(arg_391_1.text_.text)
			end

			local var_394_10 = math.max(var_394_3, arg_391_1.talkMaxDuration)

			if var_394_2 <= arg_391_1.time_ and arg_391_1.time_ < var_394_2 + var_394_10 then
				arg_391_1.typewritter.percent = (arg_391_1.time_ - var_394_2) / var_394_10

				arg_391_1.typewritter:SetDirty()
			end

			if arg_391_1.time_ >= var_394_2 + var_394_10 and arg_391_1.time_ < var_394_2 + var_394_10 + arg_394_0 then
				arg_391_1.typewritter.percent = 1

				arg_391_1.typewritter:SetDirty()
				arg_391_1:ShowNextGo(true)
			end
		end

		arg_391_1.nodeConfigList_ = {}

		arg_391_1:InitPlayNodeList()
	end,
	Play1109703095 = function(arg_395_0, arg_395_1)
		arg_395_1.time_ = 0
		arg_395_1.frameCnt_ = 0
		arg_395_1.state_ = "playing"
		arg_395_1.curTalkId_ = 1109703095
		arg_395_1.duration_ = 5

		SetActive(arg_395_1.tipsGo_, false)

		function arg_395_1.onSingleLineFinish_()
			arg_395_1.onSingleLineUpdate_ = nil
			arg_395_1.onSingleLineFinish_ = nil
			arg_395_1.state_ = "waiting"
		end

		function arg_395_1.playNext_(arg_397_0)
			if arg_397_0 == 1 then
				arg_395_0:Play1109703096(arg_395_1)
			end
		end

		function arg_395_1.onSingleLineUpdate_(arg_398_0)
			if 0 < arg_395_1.time_ and arg_395_1.time_ <= 0 + arg_398_0 and not isNil(arg_395_1.actors_["1097ui_story"]) and arg_395_1.var_.characterEffect1097ui_story == nil then
				arg_395_1.var_.characterEffect1097ui_story = arg_395_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_398_0 = 0.200000002980232

			if 0 <= arg_395_1.time_ and arg_395_1.time_ < 0 + var_398_0 and not isNil(arg_395_1.actors_["1097ui_story"]) then
				if arg_395_1.var_.characterEffect1097ui_story and not isNil(arg_395_1.actors_["1097ui_story"]) then
					arg_395_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_395_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_395_1.time_ - 0) / var_398_0)
				end
			end

			if arg_395_1.time_ >= 0 + var_398_0 and arg_395_1.time_ < 0 + var_398_0 + arg_398_0 and not isNil(arg_395_1.actors_["1097ui_story"]) and arg_395_1.var_.characterEffect1097ui_story then
				arg_395_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_395_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_398_1 = 0
			local var_398_2 = 0.225

			if 0 < arg_395_1.time_ and arg_395_1.time_ <= var_398_1 + arg_398_0 then
				arg_395_1.talkMaxDuration = 0
				arg_395_1.dialogCg_.alpha = 1

				arg_395_1.dialog_:SetActive(true)
				SetActive(arg_395_1.leftNameGo_, true)

				arg_395_1.leftNameTxt_.text = arg_395_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_395_1.leftNameTxt_.transform)

				arg_395_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_395_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_395_1:RecordName(arg_395_1.leftNameTxt_.text)
				SetActive(arg_395_1.iconTrs_.gameObject, true)
				arg_395_1.iconController_:SetSelectedState("hero")

				arg_395_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_395_1.callingController_:SetSelectedState("normal")

				arg_395_1.keyicon_.color = Color.New(1, 1, 1)
				arg_395_1.icon_.color = Color.New(1, 1, 1)

				local var_398_3 = arg_395_1:FormatText(arg_395_1:GetWordFromCfg(1109703095).content)

				arg_395_1.text_.text = var_398_3

				LuaForUtil.ClearLinePrefixSymbol(arg_395_1.text_)

				local var_398_5 = 9 <= 0 and var_398_2 or var_398_2 * (utf8.len(var_398_3) / 9)

				if (9 <= 0 and var_398_2 or var_398_2 * (utf8.len(var_398_3) / 9)) > 0 and var_398_2 < var_398_5 then
					arg_395_1.talkMaxDuration = var_398_5

					if var_398_5 + var_398_1 > arg_395_1.duration_ then
						arg_395_1.duration_ = var_398_5 + var_398_1
					end
				end

				arg_395_1.text_.text = var_398_3
				arg_395_1.typewritter.percent = 0

				arg_395_1.typewritter:SetDirty()
				arg_395_1:ShowNextGo(false)
				arg_395_1:RecordContent(arg_395_1.text_.text)
			end

			local var_398_6 = math.max(var_398_2, arg_395_1.talkMaxDuration)

			if var_398_1 <= arg_395_1.time_ and arg_395_1.time_ < var_398_1 + var_398_6 then
				arg_395_1.typewritter.percent = (arg_395_1.time_ - var_398_1) / var_398_6

				arg_395_1.typewritter:SetDirty()
			end

			if arg_395_1.time_ >= var_398_1 + var_398_6 and arg_395_1.time_ < var_398_1 + var_398_6 + arg_398_0 then
				arg_395_1.typewritter.percent = 1

				arg_395_1.typewritter:SetDirty()
				arg_395_1:ShowNextGo(true)
			end
		end

		arg_395_1.nodeConfigList_ = {}

		arg_395_1:InitPlayNodeList()
	end,
	Play1109703096 = function(arg_399_0, arg_399_1)
		arg_399_1.time_ = 0
		arg_399_1.frameCnt_ = 0
		arg_399_1.state_ = "playing"
		arg_399_1.curTalkId_ = 1109703096
		arg_399_1.duration_ = 9

		SetActive(arg_399_1.tipsGo_, false)

		function arg_399_1.onSingleLineFinish_()
			arg_399_1.onSingleLineUpdate_ = nil
			arg_399_1.onSingleLineFinish_ = nil
			arg_399_1.state_ = "waiting"
		end

		function arg_399_1.playNext_(arg_401_0)
			if arg_401_0 == 1 then
				arg_399_0:Play1109703097(arg_399_1)
			end
		end

		function arg_399_1.onSingleLineUpdate_(arg_402_0)
			if 2 < arg_399_1.time_ and arg_399_1.time_ <= 2 + arg_402_0 then
				local var_402_0 = arg_399_1.bgs_.ST12

				arg_399_1.bgs_.ST12.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_402_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_402_1 = var_402_0:GetComponent("SpriteRenderer")

				if var_402_1 and var_402_1.sprite then
					local var_402_2 = 2 * (var_402_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_402_0.transform.localScale = Vector3.New(var_402_2 / var_402_1.sprite.bounds.size.y < var_402_2 * manager.ui.mainCameraCom_.aspect / var_402_1.sprite.bounds.size.x and var_402_2 * manager.ui.mainCameraCom_.aspect / var_402_1.sprite.bounds.size.x or var_402_2 / var_402_1.sprite.bounds.size.y, var_402_2 / var_402_1.sprite.bounds.size.y < var_402_2 * manager.ui.mainCameraCom_.aspect / var_402_1.sprite.bounds.size.x and var_402_2 * manager.ui.mainCameraCom_.aspect / var_402_1.sprite.bounds.size.x or var_402_2 / var_402_1.sprite.bounds.size.y, 0)
				end

				for iter_402_0, iter_402_1 in pairs(arg_399_1.bgs_) do
					if iter_402_0 ~= "ST12" then
						iter_402_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_402_3 = 0

			if 0 < arg_399_1.time_ and arg_399_1.time_ <= var_402_3 + arg_402_0 then
				arg_399_1.mask_.enabled = true
				arg_399_1.mask_.raycastTarget = true

				arg_399_1:SetGaussion(false)
			end

			local var_402_4 = 2

			if var_402_3 <= arg_399_1.time_ and arg_399_1.time_ < var_402_3 + var_402_4 then
				local var_402_5 = Color.New(1, 1, 1)

				var_402_5.a = Mathf.Lerp(0, 1, (arg_399_1.time_ - var_402_3) / var_402_4)
				arg_399_1.mask_.color = var_402_5
			end

			if arg_399_1.time_ >= var_402_3 + var_402_4 and arg_399_1.time_ < var_402_3 + var_402_4 + arg_402_0 then
				local var_402_6 = Color.New(1, 1, 1)

				var_402_6.a = 1
				arg_399_1.mask_.color = var_402_6
			end

			local var_402_7 = 2

			if 2 < arg_399_1.time_ and arg_399_1.time_ <= var_402_7 + arg_402_0 then
				arg_399_1.mask_.enabled = true
				arg_399_1.mask_.raycastTarget = true

				arg_399_1:SetGaussion(false)
			end

			local var_402_8 = 2

			if var_402_7 <= arg_399_1.time_ and arg_399_1.time_ < var_402_7 + var_402_8 then
				local var_402_9 = Color.New(1, 1, 1)

				var_402_9.a = Mathf.Lerp(1, 0, (arg_399_1.time_ - var_402_7) / var_402_8)
				arg_399_1.mask_.color = var_402_9
			end

			if arg_399_1.time_ >= var_402_7 + var_402_8 and arg_399_1.time_ < var_402_7 + var_402_8 + arg_402_0 then
				local var_402_10 = Color.New(1, 1, 1)

				arg_399_1.mask_.enabled = false
				var_402_10.a = 0
				arg_399_1.mask_.color = var_402_10
			end

			local var_402_11 = arg_399_1.actors_["1097ui_story"].transform

			if 1.95 < arg_399_1.time_ and arg_399_1.time_ <= 1.95 + arg_402_0 then
				arg_399_1.var_.moveOldPos1097ui_story = var_402_11.localPosition
			end

			local var_402_12 = 0.001

			if 1.95 <= arg_399_1.time_ and arg_399_1.time_ < 1.95 + var_402_12 then
				var_402_11.localPosition = Vector3.Lerp(arg_399_1.var_.moveOldPos1097ui_story, Vector3.New(0, 100, 0), (arg_399_1.time_ - 1.95) / var_402_12)
				var_402_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_402_11.position).x, (manager.ui.mainCamera.transform.position - var_402_11.position).y, (manager.ui.mainCamera.transform.position - var_402_11.position).z)
				var_402_11.localEulerAngles.z = 0
				var_402_11.localEulerAngles.x = 0
				var_402_11.localEulerAngles = var_402_11.localEulerAngles
			end

			if arg_399_1.time_ >= 1.95 + var_402_12 and arg_399_1.time_ < 1.95 + var_402_12 + arg_402_0 then
				var_402_11.localPosition = Vector3.New(0, 100, 0)
				var_402_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_402_11.position).x, (manager.ui.mainCamera.transform.position - var_402_11.position).y, (manager.ui.mainCamera.transform.position - var_402_11.position).z)
				var_402_11.localEulerAngles.z = 0
				var_402_11.localEulerAngles.x = 0
				var_402_11.localEulerAngles = var_402_11.localEulerAngles
			end

			local var_402_13 = arg_399_1.actors_["1097ui_story"]

			if 1.95 < arg_399_1.time_ and arg_399_1.time_ <= 1.95 + arg_402_0 and not isNil(var_402_13) and arg_399_1.var_.characterEffect1097ui_story == nil then
				arg_399_1.var_.characterEffect1097ui_story = var_402_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_402_14 = 0.05

			if 1.95 <= arg_399_1.time_ and arg_399_1.time_ < 1.95 + var_402_14 and not isNil(var_402_13) then
				if arg_399_1.var_.characterEffect1097ui_story and not isNil(var_402_13) then
					arg_399_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_399_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_399_1.time_ - 1.95) / var_402_14)
				end
			end

			if arg_399_1.time_ >= 1.95 + var_402_14 and arg_399_1.time_ < 1.95 + var_402_14 + arg_402_0 and not isNil(var_402_13) and arg_399_1.var_.characterEffect1097ui_story then
				arg_399_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_399_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			if arg_399_1.frameCnt_ <= 1 then
				arg_399_1.dialog_:SetActive(false)
			end

			local var_402_15 = 4
			local var_402_16 = 0.05

			if 4 < arg_399_1.time_ and arg_399_1.time_ <= var_402_15 + arg_402_0 then
				arg_399_1.talkMaxDuration = 0

				arg_399_1.dialog_:SetActive(true)

				arg_399_1.dialogCg_.alpha = 0

				local var_402_17 = LeanTween.value(arg_399_1.dialog_, 0, 1, 0.3)

				var_402_17:setOnUpdate(LuaHelper.FloatAction(function(arg_403_0)
					arg_399_1.dialogCg_.alpha = arg_403_0
				end))
				var_402_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_399_1.dialog_)
					var_402_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_399_1.duration_ = arg_399_1.duration_ + 0.3

				SetActive(arg_399_1.leftNameGo_, false)

				arg_399_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_399_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_399_1:RecordName(arg_399_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_399_1.iconTrs_.gameObject, false)
				arg_399_1.callingController_:SetSelectedState("normal")

				local var_402_18 = arg_399_1:FormatText(arg_399_1:GetWordFromCfg(1109703096).content)

				arg_399_1.text_.text = var_402_18

				LuaForUtil.ClearLinePrefixSymbol(arg_399_1.text_)

				local var_402_20 = 2 <= 0 and var_402_16 or var_402_16 * (utf8.len(var_402_18) / 2)

				if (2 <= 0 and var_402_16 or var_402_16 * (utf8.len(var_402_18) / 2)) > 0 and var_402_16 < var_402_20 then
					arg_399_1.talkMaxDuration = var_402_20
					var_402_15 = var_402_15 + 0.3

					if var_402_20 + var_402_15 > arg_399_1.duration_ then
						arg_399_1.duration_ = var_402_20 + var_402_15
					end
				end

				arg_399_1.text_.text = var_402_18
				arg_399_1.typewritter.percent = 0

				arg_399_1.typewritter:SetDirty()
				arg_399_1:ShowNextGo(false)
				arg_399_1:RecordContent(arg_399_1.text_.text)
			end

			local var_402_21 = var_402_15 + 0.3
			local var_402_22 = math.max(var_402_16, arg_399_1.talkMaxDuration)

			if var_402_15 + 0.3 <= arg_399_1.time_ and arg_399_1.time_ < var_402_21 + var_402_22 then
				arg_399_1.typewritter.percent = (arg_399_1.time_ - var_402_21) / var_402_22

				arg_399_1.typewritter:SetDirty()
			end

			if arg_399_1.time_ >= var_402_21 + var_402_22 and arg_399_1.time_ < var_402_21 + var_402_22 + arg_402_0 then
				arg_399_1.typewritter.percent = 1

				arg_399_1.typewritter:SetDirty()
				arg_399_1:ShowNextGo(true)
			end
		end

		arg_399_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.95,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_399_1:InitPlayNodeList()
	end,
	Play1109703097 = function(arg_405_0, arg_405_1)
		arg_405_1.time_ = 0
		arg_405_1.frameCnt_ = 0
		arg_405_1.state_ = "playing"
		arg_405_1.curTalkId_ = 1109703097
		arg_405_1.duration_ = 5.9

		local var_405_0 = {
			zh = 5.9,
			ja = 4.633
		}
		local var_405_1 = manager.audio:GetLocalizationFlag()

		if var_405_0[var_405_1] ~= nil then
			arg_405_1.duration_ = var_405_0[var_405_1]
		end

		SetActive(arg_405_1.tipsGo_, false)

		function arg_405_1.onSingleLineFinish_()
			arg_405_1.onSingleLineUpdate_ = nil
			arg_405_1.onSingleLineFinish_ = nil
			arg_405_1.state_ = "waiting"
		end

		function arg_405_1.playNext_(arg_407_0)
			if arg_407_0 == 1 then
				arg_405_0:Play1109703098(arg_405_1)
			end
		end

		function arg_405_1.onSingleLineUpdate_(arg_408_0)
			if arg_405_1.actors_["1027ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1027ui_story"))) then
				local var_408_0 = Object.Instantiate(Asset.Load("Char/" .. "1027ui_story"), arg_405_1.stage_.transform)

				var_408_0.name = "1027ui_story"
				var_408_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_405_1.actors_["1027ui_story"] = var_408_0

				local var_408_1 = var_408_0:GetComponentInChildren(typeof(CharacterEffect))

				var_408_1.enabled = true

				local var_408_2 = GameObjectTools.GetOrAddComponent(var_408_0, typeof(DynamicBoneHelper))

				if var_408_2 then
					var_408_2:EnableDynamicBone(false)
				end

				arg_405_1:ShowWeapon(var_408_1.transform, false)

				arg_405_1.var_["1027ui_story" .. "Animator"] = var_408_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_405_1.var_["1027ui_story" .. "Animator"].applyRootMotion = true
				arg_405_1.var_["1027ui_story" .. "LipSync"] = var_408_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_408_3 = arg_405_1.actors_["1027ui_story"].transform

			if 0 < arg_405_1.time_ and arg_405_1.time_ <= 0 + arg_408_0 then
				arg_405_1.var_.moveOldPos1027ui_story = var_408_3.localPosition
			end

			local var_408_4 = 0.001

			if 0 <= arg_405_1.time_ and arg_405_1.time_ < 0 + var_408_4 then
				var_408_3.localPosition = Vector3.Lerp(arg_405_1.var_.moveOldPos1027ui_story, Vector3.New(0, -0.81, -5.8), (arg_405_1.time_ - 0) / var_408_4)
				var_408_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_408_3.position).x, (manager.ui.mainCamera.transform.position - var_408_3.position).y, (manager.ui.mainCamera.transform.position - var_408_3.position).z)
				var_408_3.localEulerAngles.z = 0
				var_408_3.localEulerAngles.x = 0
				var_408_3.localEulerAngles = var_408_3.localEulerAngles
			end

			if arg_405_1.time_ >= 0 + var_408_4 and arg_405_1.time_ < 0 + var_408_4 + arg_408_0 then
				var_408_3.localPosition = Vector3.New(0, -0.81, -5.8)
				var_408_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_408_3.position).x, (manager.ui.mainCamera.transform.position - var_408_3.position).y, (manager.ui.mainCamera.transform.position - var_408_3.position).z)
				var_408_3.localEulerAngles.z = 0
				var_408_3.localEulerAngles.x = 0
				var_408_3.localEulerAngles = var_408_3.localEulerAngles
			end

			local var_408_5 = arg_405_1.actors_["1027ui_story"]

			if 0 < arg_405_1.time_ and arg_405_1.time_ <= 0 + arg_408_0 and not isNil(var_408_5) and arg_405_1.var_.characterEffect1027ui_story == nil then
				arg_405_1.var_.characterEffect1027ui_story = var_408_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_408_6 = 0.2

			if 0 <= arg_405_1.time_ and arg_405_1.time_ < 0 + var_408_6 and not isNil(var_408_5) then
				if arg_405_1.var_.characterEffect1027ui_story and not isNil(var_408_5) then
					arg_405_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_405_1.time_ >= 0 + var_408_6 and arg_405_1.time_ < 0 + var_408_6 + arg_408_0 and not isNil(var_408_5) and arg_405_1.var_.characterEffect1027ui_story then
				arg_405_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			if 0 < arg_405_1.time_ and arg_405_1.time_ <= 0 + arg_408_0 then
				arg_405_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action2_1")
			end

			if 0 < arg_405_1.time_ and arg_405_1.time_ <= 0 + arg_408_0 then
				arg_405_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			if 0 < arg_405_1.time_ and arg_405_1.time_ <= 0 + arg_408_0 then
				if arg_405_1.var_.characterEffect1027ui_story == nil then
					arg_405_1.var_.characterEffect1027ui_story = arg_405_1.actors_["1027ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_408_8 = arg_405_1.var_.characterEffect1027ui_story

				arg_405_1.var_.characterEffect1027ui_story.imageEffect:turnOff()

				var_408_8.interferenceEffect.enabled = true
				var_408_8.interferenceEffect.noise = 0.01
				var_408_8.interferenceEffect.simTimeScale = 1
				var_408_8.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			if 0 < arg_405_1.time_ and arg_405_1.time_ <= 0 + arg_408_0 then
				if arg_405_1.var_.characterEffect1027ui_story == nil then
					arg_405_1.var_.characterEffect1027ui_story = arg_405_1.actors_["1027ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_405_1.var_.characterEffect1027ui_story.imageEffect:turnOn(false)
			end

			local var_408_10 = 0
			local var_408_11 = 0.525

			if 0 < arg_405_1.time_ and arg_405_1.time_ <= var_408_10 + arg_408_0 then
				arg_405_1.talkMaxDuration = 0
				arg_405_1.dialogCg_.alpha = 1

				arg_405_1.dialog_:SetActive(true)
				SetActive(arg_405_1.leftNameGo_, true)

				arg_405_1.leftNameTxt_.text = arg_405_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_405_1.leftNameTxt_.transform)

				arg_405_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_405_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_405_1:RecordName(arg_405_1.leftNameTxt_.text)
				SetActive(arg_405_1.iconTrs_.gameObject, false)
				arg_405_1.callingController_:SetSelectedState("normal")

				local var_408_12 = arg_405_1:GetWordFromCfg(1109703097)
				local var_408_13 = arg_405_1:FormatText(var_408_12.content)

				arg_405_1.text_.text = var_408_13

				LuaForUtil.ClearLinePrefixSymbol(arg_405_1.text_)

				local var_408_15 = 21 <= 0 and var_408_11 or var_408_11 * (utf8.len(var_408_13) / 21)

				if (21 <= 0 and var_408_11 or var_408_11 * (utf8.len(var_408_13) / 21)) > 0 and var_408_11 < var_408_15 then
					arg_405_1.talkMaxDuration = var_408_15

					if var_408_15 + var_408_10 > arg_405_1.duration_ then
						arg_405_1.duration_ = var_408_15 + var_408_10
					end
				end

				arg_405_1.text_.text = var_408_13
				arg_405_1.typewritter.percent = 0

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703097", "story_v_side_new_1109703.awb") ~= 0 then
					local var_408_16 = manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703097", "story_v_side_new_1109703.awb") / 1000

					if var_408_16 + var_408_10 > arg_405_1.duration_ then
						arg_405_1.duration_ = var_408_16 + var_408_10
					end

					if var_408_12.prefab_name ~= "" and arg_405_1.actors_[var_408_12.prefab_name] ~= nil then
						local var_408_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_405_1.actors_[var_408_12.prefab_name].transform, "story_v_side_new_1109703", "1109703097", "story_v_side_new_1109703.awb")

						arg_405_1:RecordAudio("1109703097", var_408_17)
						arg_405_1:RecordAudio("1109703097", var_408_17)
					else
						arg_405_1:AudioAction("play", "voice", "story_v_side_new_1109703", "1109703097", "story_v_side_new_1109703.awb")
					end

					arg_405_1:RecordHistoryTalkVoice("story_v_side_new_1109703", "1109703097", "story_v_side_new_1109703.awb")
				end

				arg_405_1:RecordContent(arg_405_1.text_.text)
			end

			local var_408_18 = math.max(var_408_11, arg_405_1.talkMaxDuration)

			if var_408_10 <= arg_405_1.time_ and arg_405_1.time_ < var_408_10 + var_408_18 then
				arg_405_1.typewritter.percent = (arg_405_1.time_ - var_408_10) / var_408_18

				arg_405_1.typewritter:SetDirty()
			end

			if arg_405_1.time_ >= var_408_10 + var_408_18 and arg_405_1.time_ < var_408_10 + var_408_18 + arg_408_0 then
				arg_405_1.typewritter.percent = 1

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(true)
			end
		end

		arg_405_1.nodeConfigList_ = {
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

		arg_405_1:InitPlayNodeList()
	end,
	Play1109703098 = function(arg_409_0, arg_409_1)
		arg_409_1.time_ = 0
		arg_409_1.frameCnt_ = 0
		arg_409_1.state_ = "playing"
		arg_409_1.curTalkId_ = 1109703098
		arg_409_1.duration_ = 5

		SetActive(arg_409_1.tipsGo_, false)

		function arg_409_1.onSingleLineFinish_()
			arg_409_1.onSingleLineUpdate_ = nil
			arg_409_1.onSingleLineFinish_ = nil
			arg_409_1.state_ = "waiting"
		end

		function arg_409_1.playNext_(arg_411_0)
			if arg_411_0 == 1 then
				arg_409_0:Play1109703099(arg_409_1)
			end
		end

		function arg_409_1.onSingleLineUpdate_(arg_412_0)
			if 0 < arg_409_1.time_ and arg_409_1.time_ <= 0 + arg_412_0 and not isNil(arg_409_1.actors_["1027ui_story"]) and arg_409_1.var_.characterEffect1027ui_story == nil then
				arg_409_1.var_.characterEffect1027ui_story = arg_409_1.actors_["1027ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_412_0 = 0.2

			if 0 <= arg_409_1.time_ and arg_409_1.time_ < 0 + var_412_0 and not isNil(arg_409_1.actors_["1027ui_story"]) then
				if arg_409_1.var_.characterEffect1027ui_story and not isNil(arg_409_1.actors_["1027ui_story"]) then
					arg_409_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_409_1.var_.characterEffect1027ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_409_1.time_ - 0) / var_412_0)
				end
			end

			if arg_409_1.time_ >= 0 + var_412_0 and arg_409_1.time_ < 0 + var_412_0 + arg_412_0 and not isNil(arg_409_1.actors_["1027ui_story"]) and arg_409_1.var_.characterEffect1027ui_story then
				arg_409_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_409_1.var_.characterEffect1027ui_story.fillRatio = 0.5
			end

			local var_412_1 = 0
			local var_412_2 = 0.325

			if 0 < arg_409_1.time_ and arg_409_1.time_ <= var_412_1 + arg_412_0 then
				arg_409_1.talkMaxDuration = 0
				arg_409_1.dialogCg_.alpha = 1

				arg_409_1.dialog_:SetActive(true)
				SetActive(arg_409_1.leftNameGo_, true)

				arg_409_1.leftNameTxt_.text = arg_409_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_409_1.leftNameTxt_.transform)

				arg_409_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_409_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_409_1:RecordName(arg_409_1.leftNameTxt_.text)
				SetActive(arg_409_1.iconTrs_.gameObject, true)
				arg_409_1.iconController_:SetSelectedState("hero")

				arg_409_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_409_1.callingController_:SetSelectedState("normal")

				arg_409_1.keyicon_.color = Color.New(1, 1, 1)
				arg_409_1.icon_.color = Color.New(1, 1, 1)

				local var_412_3 = arg_409_1:FormatText(arg_409_1:GetWordFromCfg(1109703098).content)

				arg_409_1.text_.text = var_412_3

				LuaForUtil.ClearLinePrefixSymbol(arg_409_1.text_)

				local var_412_5 = 13 <= 0 and var_412_2 or var_412_2 * (utf8.len(var_412_3) / 13)

				if (13 <= 0 and var_412_2 or var_412_2 * (utf8.len(var_412_3) / 13)) > 0 and var_412_2 < var_412_5 then
					arg_409_1.talkMaxDuration = var_412_5

					if var_412_5 + var_412_1 > arg_409_1.duration_ then
						arg_409_1.duration_ = var_412_5 + var_412_1
					end
				end

				arg_409_1.text_.text = var_412_3
				arg_409_1.typewritter.percent = 0

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(false)
				arg_409_1:RecordContent(arg_409_1.text_.text)
			end

			local var_412_6 = math.max(var_412_2, arg_409_1.talkMaxDuration)

			if var_412_1 <= arg_409_1.time_ and arg_409_1.time_ < var_412_1 + var_412_6 then
				arg_409_1.typewritter.percent = (arg_409_1.time_ - var_412_1) / var_412_6

				arg_409_1.typewritter:SetDirty()
			end

			if arg_409_1.time_ >= var_412_1 + var_412_6 and arg_409_1.time_ < var_412_1 + var_412_6 + arg_412_0 then
				arg_409_1.typewritter.percent = 1

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(true)
			end
		end

		arg_409_1.nodeConfigList_ = {}

		arg_409_1:InitPlayNodeList()
	end,
	Play1109703099 = function(arg_413_0, arg_413_1)
		arg_413_1.time_ = 0
		arg_413_1.frameCnt_ = 0
		arg_413_1.state_ = "playing"
		arg_413_1.curTalkId_ = 1109703099
		arg_413_1.duration_ = 6.67

		local var_413_0 = {
			zh = 5.1,
			ja = 6.666
		}
		local var_413_1 = manager.audio:GetLocalizationFlag()

		if var_413_0[var_413_1] ~= nil then
			arg_413_1.duration_ = var_413_0[var_413_1]
		end

		SetActive(arg_413_1.tipsGo_, false)

		function arg_413_1.onSingleLineFinish_()
			arg_413_1.onSingleLineUpdate_ = nil
			arg_413_1.onSingleLineFinish_ = nil
			arg_413_1.state_ = "waiting"
		end

		function arg_413_1.playNext_(arg_415_0)
			if arg_415_0 == 1 then
				arg_413_0:Play1109703100(arg_413_1)
			end
		end

		function arg_413_1.onSingleLineUpdate_(arg_416_0)
			if 0 < arg_413_1.time_ and arg_413_1.time_ <= 0 + arg_416_0 then
				arg_413_1.var_.moveOldPos1027ui_story = arg_413_1.actors_["1027ui_story"].transform.localPosition
			end

			local var_416_0 = 0.001

			if 0 <= arg_413_1.time_ and arg_413_1.time_ < 0 + var_416_0 then
				arg_413_1.actors_["1027ui_story"].transform.localPosition = Vector3.Lerp(arg_413_1.var_.moveOldPos1027ui_story, Vector3.New(0, -0.81, -5.8), (arg_413_1.time_ - 0) / var_416_0)
				arg_413_1.actors_["1027ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_413_1.actors_["1027ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_413_1.actors_["1027ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_413_1.actors_["1027ui_story"].transform.position).z)
				arg_413_1.actors_["1027ui_story"].transform.localEulerAngles.z = 0
				arg_413_1.actors_["1027ui_story"].transform.localEulerAngles.x = 0
				arg_413_1.actors_["1027ui_story"].transform.localEulerAngles = arg_413_1.actors_["1027ui_story"].transform.localEulerAngles
			end

			if arg_413_1.time_ >= 0 + var_416_0 and arg_413_1.time_ < 0 + var_416_0 + arg_416_0 then
				arg_413_1.actors_["1027ui_story"].transform.localPosition = Vector3.New(0, -0.81, -5.8)
				arg_413_1.actors_["1027ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_413_1.actors_["1027ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_413_1.actors_["1027ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_413_1.actors_["1027ui_story"].transform.position).z)
				arg_413_1.actors_["1027ui_story"].transform.localEulerAngles.z = 0
				arg_413_1.actors_["1027ui_story"].transform.localEulerAngles.x = 0
				arg_413_1.actors_["1027ui_story"].transform.localEulerAngles = arg_413_1.actors_["1027ui_story"].transform.localEulerAngles
			end

			local var_416_1 = arg_413_1.actors_["1027ui_story"]

			if 0 < arg_413_1.time_ and arg_413_1.time_ <= 0 + arg_416_0 and not isNil(var_416_1) and arg_413_1.var_.characterEffect1027ui_story == nil then
				arg_413_1.var_.characterEffect1027ui_story = var_416_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_416_2 = 0.200000002980232

			if 0 <= arg_413_1.time_ and arg_413_1.time_ < 0 + var_416_2 and not isNil(var_416_1) then
				if arg_413_1.var_.characterEffect1027ui_story and not isNil(var_416_1) then
					arg_413_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_413_1.time_ >= 0 + var_416_2 and arg_413_1.time_ < 0 + var_416_2 + arg_416_0 and not isNil(var_416_1) and arg_413_1.var_.characterEffect1027ui_story then
				arg_413_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			if 0 < arg_413_1.time_ and arg_413_1.time_ <= 0 + arg_416_0 then
				arg_413_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027actionlink/1027action425")
			end

			if 0 < arg_413_1.time_ and arg_413_1.time_ <= 0 + arg_416_0 then
				arg_413_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_416_4 = 0
			local var_416_5 = 0.6

			if 0 < arg_413_1.time_ and arg_413_1.time_ <= var_416_4 + arg_416_0 then
				arg_413_1.talkMaxDuration = 0
				arg_413_1.dialogCg_.alpha = 1

				arg_413_1.dialog_:SetActive(true)
				SetActive(arg_413_1.leftNameGo_, true)

				arg_413_1.leftNameTxt_.text = arg_413_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_413_1.leftNameTxt_.transform)

				arg_413_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_413_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_413_1:RecordName(arg_413_1.leftNameTxt_.text)
				SetActive(arg_413_1.iconTrs_.gameObject, false)
				arg_413_1.callingController_:SetSelectedState("normal")

				local var_416_6 = arg_413_1:GetWordFromCfg(1109703099)
				local var_416_7 = arg_413_1:FormatText(var_416_6.content)

				arg_413_1.text_.text = var_416_7

				LuaForUtil.ClearLinePrefixSymbol(arg_413_1.text_)

				local var_416_9 = 24 <= 0 and var_416_5 or var_416_5 * (utf8.len(var_416_7) / 24)

				if (24 <= 0 and var_416_5 or var_416_5 * (utf8.len(var_416_7) / 24)) > 0 and var_416_5 < var_416_9 then
					arg_413_1.talkMaxDuration = var_416_9

					if var_416_9 + var_416_4 > arg_413_1.duration_ then
						arg_413_1.duration_ = var_416_9 + var_416_4
					end
				end

				arg_413_1.text_.text = var_416_7
				arg_413_1.typewritter.percent = 0

				arg_413_1.typewritter:SetDirty()
				arg_413_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703099", "story_v_side_new_1109703.awb") ~= 0 then
					local var_416_10 = manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703099", "story_v_side_new_1109703.awb") / 1000

					if var_416_10 + var_416_4 > arg_413_1.duration_ then
						arg_413_1.duration_ = var_416_10 + var_416_4
					end

					if var_416_6.prefab_name ~= "" and arg_413_1.actors_[var_416_6.prefab_name] ~= nil then
						local var_416_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_413_1.actors_[var_416_6.prefab_name].transform, "story_v_side_new_1109703", "1109703099", "story_v_side_new_1109703.awb")

						arg_413_1:RecordAudio("1109703099", var_416_11)
						arg_413_1:RecordAudio("1109703099", var_416_11)
					else
						arg_413_1:AudioAction("play", "voice", "story_v_side_new_1109703", "1109703099", "story_v_side_new_1109703.awb")
					end

					arg_413_1:RecordHistoryTalkVoice("story_v_side_new_1109703", "1109703099", "story_v_side_new_1109703.awb")
				end

				arg_413_1:RecordContent(arg_413_1.text_.text)
			end

			local var_416_12 = math.max(var_416_5, arg_413_1.talkMaxDuration)

			if var_416_4 <= arg_413_1.time_ and arg_413_1.time_ < var_416_4 + var_416_12 then
				arg_413_1.typewritter.percent = (arg_413_1.time_ - var_416_4) / var_416_12

				arg_413_1.typewritter:SetDirty()
			end

			if arg_413_1.time_ >= var_416_4 + var_416_12 and arg_413_1.time_ < var_416_4 + var_416_12 + arg_416_0 then
				arg_413_1.typewritter.percent = 1

				arg_413_1.typewritter:SetDirty()
				arg_413_1:ShowNextGo(true)
			end
		end

		arg_413_1.nodeConfigList_ = {
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

		arg_413_1:InitPlayNodeList()
	end,
	Play1109703100 = function(arg_417_0, arg_417_1)
		arg_417_1.time_ = 0
		arg_417_1.frameCnt_ = 0
		arg_417_1.state_ = "playing"
		arg_417_1.curTalkId_ = 1109703100
		arg_417_1.duration_ = 5

		SetActive(arg_417_1.tipsGo_, false)

		function arg_417_1.onSingleLineFinish_()
			arg_417_1.onSingleLineUpdate_ = nil
			arg_417_1.onSingleLineFinish_ = nil
			arg_417_1.state_ = "waiting"
		end

		function arg_417_1.playNext_(arg_419_0)
			if arg_419_0 == 1 then
				arg_417_0:Play1109703101(arg_417_1)
			end
		end

		function arg_417_1.onSingleLineUpdate_(arg_420_0)
			if 0 < arg_417_1.time_ and arg_417_1.time_ <= 0 + arg_420_0 and not isNil(arg_417_1.actors_["1027ui_story"]) and arg_417_1.var_.characterEffect1027ui_story == nil then
				arg_417_1.var_.characterEffect1027ui_story = arg_417_1.actors_["1027ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_420_0 = 0.200000002980232

			if 0 <= arg_417_1.time_ and arg_417_1.time_ < 0 + var_420_0 and not isNil(arg_417_1.actors_["1027ui_story"]) then
				if arg_417_1.var_.characterEffect1027ui_story and not isNil(arg_417_1.actors_["1027ui_story"]) then
					arg_417_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_417_1.var_.characterEffect1027ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_417_1.time_ - 0) / var_420_0)
				end
			end

			if arg_417_1.time_ >= 0 + var_420_0 and arg_417_1.time_ < 0 + var_420_0 + arg_420_0 and not isNil(arg_417_1.actors_["1027ui_story"]) and arg_417_1.var_.characterEffect1027ui_story then
				arg_417_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_417_1.var_.characterEffect1027ui_story.fillRatio = 0.5
			end

			local var_420_1 = 0
			local var_420_2 = 0.05

			if 0 < arg_417_1.time_ and arg_417_1.time_ <= var_420_1 + arg_420_0 then
				arg_417_1.talkMaxDuration = 0
				arg_417_1.dialogCg_.alpha = 1

				arg_417_1.dialog_:SetActive(true)
				SetActive(arg_417_1.leftNameGo_, true)

				arg_417_1.leftNameTxt_.text = arg_417_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_417_1.leftNameTxt_.transform)

				arg_417_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_417_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_417_1:RecordName(arg_417_1.leftNameTxt_.text)
				SetActive(arg_417_1.iconTrs_.gameObject, true)
				arg_417_1.iconController_:SetSelectedState("hero")

				arg_417_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_417_1.callingController_:SetSelectedState("normal")

				arg_417_1.keyicon_.color = Color.New(1, 1, 1)
				arg_417_1.icon_.color = Color.New(1, 1, 1)

				local var_420_3 = arg_417_1:FormatText(arg_417_1:GetWordFromCfg(1109703100).content)

				arg_417_1.text_.text = var_420_3

				LuaForUtil.ClearLinePrefixSymbol(arg_417_1.text_)

				local var_420_5 = 2 <= 0 and var_420_2 or var_420_2 * (utf8.len(var_420_3) / 2)

				if (2 <= 0 and var_420_2 or var_420_2 * (utf8.len(var_420_3) / 2)) > 0 and var_420_2 < var_420_5 then
					arg_417_1.talkMaxDuration = var_420_5

					if var_420_5 + var_420_1 > arg_417_1.duration_ then
						arg_417_1.duration_ = var_420_5 + var_420_1
					end
				end

				arg_417_1.text_.text = var_420_3
				arg_417_1.typewritter.percent = 0

				arg_417_1.typewritter:SetDirty()
				arg_417_1:ShowNextGo(false)
				arg_417_1:RecordContent(arg_417_1.text_.text)
			end

			local var_420_6 = math.max(var_420_2, arg_417_1.talkMaxDuration)

			if var_420_1 <= arg_417_1.time_ and arg_417_1.time_ < var_420_1 + var_420_6 then
				arg_417_1.typewritter.percent = (arg_417_1.time_ - var_420_1) / var_420_6

				arg_417_1.typewritter:SetDirty()
			end

			if arg_417_1.time_ >= var_420_1 + var_420_6 and arg_417_1.time_ < var_420_1 + var_420_6 + arg_420_0 then
				arg_417_1.typewritter.percent = 1

				arg_417_1.typewritter:SetDirty()
				arg_417_1:ShowNextGo(true)
			end
		end

		arg_417_1.nodeConfigList_ = {}

		arg_417_1:InitPlayNodeList()
	end,
	Play1109703101 = function(arg_421_0, arg_421_1)
		arg_421_1.time_ = 0
		arg_421_1.frameCnt_ = 0
		arg_421_1.state_ = "playing"
		arg_421_1.curTalkId_ = 1109703101
		arg_421_1.duration_ = 7.9

		local var_421_0 = {
			zh = 7.9,
			ja = 5.799999999999
		}
		local var_421_1 = manager.audio:GetLocalizationFlag()

		if var_421_0[var_421_1] ~= nil then
			arg_421_1.duration_ = var_421_0[var_421_1]
		end

		SetActive(arg_421_1.tipsGo_, false)

		function arg_421_1.onSingleLineFinish_()
			arg_421_1.onSingleLineUpdate_ = nil
			arg_421_1.onSingleLineFinish_ = nil
			arg_421_1.state_ = "waiting"
		end

		function arg_421_1.playNext_(arg_423_0)
			if arg_423_0 == 1 then
				arg_421_0:Play1109703102(arg_421_1)
			end
		end

		function arg_421_1.onSingleLineUpdate_(arg_424_0)
			if arg_421_1.bgs_.ST01 == nil then
				local var_424_0 = Object.Instantiate(arg_421_1.paintGo_)

				var_424_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST01")
				var_424_0.name = "ST01"
				var_424_0.transform.parent = arg_421_1.stage_.transform
				var_424_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_421_1.bgs_.ST01 = var_424_0
			end

			if 2 < arg_421_1.time_ and arg_421_1.time_ <= 2 + arg_424_0 then
				local var_424_1 = arg_421_1.bgs_.ST01

				arg_421_1.bgs_.ST01.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_424_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_424_2 = var_424_1:GetComponent("SpriteRenderer")

				if var_424_2 and var_424_2.sprite then
					local var_424_3 = 2 * (var_424_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_424_1.transform.localScale = Vector3.New(var_424_3 / var_424_2.sprite.bounds.size.y < var_424_3 * manager.ui.mainCameraCom_.aspect / var_424_2.sprite.bounds.size.x and var_424_3 * manager.ui.mainCameraCom_.aspect / var_424_2.sprite.bounds.size.x or var_424_3 / var_424_2.sprite.bounds.size.y, var_424_3 / var_424_2.sprite.bounds.size.y < var_424_3 * manager.ui.mainCameraCom_.aspect / var_424_2.sprite.bounds.size.x and var_424_3 * manager.ui.mainCameraCom_.aspect / var_424_2.sprite.bounds.size.x or var_424_3 / var_424_2.sprite.bounds.size.y, 0)
				end

				for iter_424_0, iter_424_1 in pairs(arg_421_1.bgs_) do
					if iter_424_0 ~= "ST01" then
						iter_424_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_424_4 = 0

			if 0 < arg_421_1.time_ and arg_421_1.time_ <= var_424_4 + arg_424_0 then
				arg_421_1.mask_.enabled = true
				arg_421_1.mask_.raycastTarget = true

				arg_421_1:SetGaussion(false)
			end

			local var_424_5 = 2

			if var_424_4 <= arg_421_1.time_ and arg_421_1.time_ < var_424_4 + var_424_5 then
				local var_424_6 = Color.New(0, 0, 0)

				var_424_6.a = Mathf.Lerp(0, 1, (arg_421_1.time_ - var_424_4) / var_424_5)
				arg_421_1.mask_.color = var_424_6
			end

			if arg_421_1.time_ >= var_424_4 + var_424_5 and arg_421_1.time_ < var_424_4 + var_424_5 + arg_424_0 then
				local var_424_7 = Color.New(0, 0, 0)

				var_424_7.a = 1
				arg_421_1.mask_.color = var_424_7
			end

			local var_424_8 = 2

			if 2 < arg_421_1.time_ and arg_421_1.time_ <= var_424_8 + arg_424_0 then
				arg_421_1.mask_.enabled = true
				arg_421_1.mask_.raycastTarget = true

				arg_421_1:SetGaussion(false)
			end

			local var_424_9 = 2

			if var_424_8 <= arg_421_1.time_ and arg_421_1.time_ < var_424_8 + var_424_9 then
				local var_424_10 = Color.New(0, 0, 0)

				var_424_10.a = Mathf.Lerp(1, 0, (arg_421_1.time_ - var_424_8) / var_424_9)
				arg_421_1.mask_.color = var_424_10
			end

			if arg_421_1.time_ >= var_424_8 + var_424_9 and arg_421_1.time_ < var_424_8 + var_424_9 + arg_424_0 then
				local var_424_11 = Color.New(0, 0, 0)

				arg_421_1.mask_.enabled = false
				var_424_11.a = 0
				arg_421_1.mask_.color = var_424_11
			end

			local var_424_12 = arg_421_1.actors_["1027ui_story"].transform

			if 1.96599999815226 < arg_421_1.time_ and arg_421_1.time_ <= 1.96599999815226 + arg_424_0 then
				arg_421_1.var_.moveOldPos1027ui_story = var_424_12.localPosition
			end

			local var_424_13 = 0.001

			if 1.96599999815226 <= arg_421_1.time_ and arg_421_1.time_ < 1.96599999815226 + var_424_13 then
				var_424_12.localPosition = Vector3.Lerp(arg_421_1.var_.moveOldPos1027ui_story, Vector3.New(0, 100, 0), (arg_421_1.time_ - 1.96599999815226) / var_424_13)
				var_424_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_424_12.position).x, (manager.ui.mainCamera.transform.position - var_424_12.position).y, (manager.ui.mainCamera.transform.position - var_424_12.position).z)
				var_424_12.localEulerAngles.z = 0
				var_424_12.localEulerAngles.x = 0
				var_424_12.localEulerAngles = var_424_12.localEulerAngles
			end

			if arg_421_1.time_ >= 1.96599999815226 + var_424_13 and arg_421_1.time_ < 1.96599999815226 + var_424_13 + arg_424_0 then
				var_424_12.localPosition = Vector3.New(0, 100, 0)
				var_424_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_424_12.position).x, (manager.ui.mainCamera.transform.position - var_424_12.position).y, (manager.ui.mainCamera.transform.position - var_424_12.position).z)
				var_424_12.localEulerAngles.z = 0
				var_424_12.localEulerAngles.x = 0
				var_424_12.localEulerAngles = var_424_12.localEulerAngles
			end

			local var_424_14 = arg_421_1.actors_["1027ui_story"]

			if 1.96599999815226 < arg_421_1.time_ and arg_421_1.time_ <= 1.96599999815226 + arg_424_0 and not isNil(var_424_14) and arg_421_1.var_.characterEffect1027ui_story == nil then
				arg_421_1.var_.characterEffect1027ui_story = var_424_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_424_15 = 0.034000001847744

			if 1.96599999815226 <= arg_421_1.time_ and arg_421_1.time_ < 1.96599999815226 + var_424_15 and not isNil(var_424_14) then
				if arg_421_1.var_.characterEffect1027ui_story and not isNil(var_424_14) then
					arg_421_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_421_1.var_.characterEffect1027ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_421_1.time_ - 1.96599999815226) / var_424_15)
				end
			end

			if arg_421_1.time_ >= 1.96599999815226 + var_424_15 and arg_421_1.time_ < 1.96599999815226 + var_424_15 + arg_424_0 and not isNil(var_424_14) and arg_421_1.var_.characterEffect1027ui_story then
				arg_421_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_421_1.var_.characterEffect1027ui_story.fillRatio = 0.5
			end

			local var_424_16 = "1080ui_story"

			if arg_421_1.actors_["1080ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1080ui_story"))) then
				local var_424_17 = Object.Instantiate(Asset.Load("Char/" .. "1080ui_story"), arg_421_1.stage_.transform)

				var_424_17.name = var_424_16
				var_424_17.transform.localPosition = Vector3.New(0, 100, 0)
				arg_421_1.actors_[var_424_16] = var_424_17

				local var_424_18 = var_424_17:GetComponentInChildren(typeof(CharacterEffect))

				var_424_18.enabled = true

				local var_424_19 = GameObjectTools.GetOrAddComponent(var_424_17, typeof(DynamicBoneHelper))

				if var_424_19 then
					var_424_19:EnableDynamicBone(false)
				end

				arg_421_1:ShowWeapon(var_424_18.transform, false)

				arg_421_1.var_[var_424_16 .. "Animator"] = var_424_18.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_421_1.var_[var_424_16 .. "Animator"].applyRootMotion = true
				arg_421_1.var_[var_424_16 .. "LipSync"] = var_424_18.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_424_20 = arg_421_1.actors_["1080ui_story"].transform

			if 3.8 < arg_421_1.time_ and arg_421_1.time_ <= 3.8 + arg_424_0 then
				arg_421_1.var_.moveOldPos1080ui_story = var_424_20.localPosition
			end

			local var_424_21 = 0.001

			if 3.8 <= arg_421_1.time_ and arg_421_1.time_ < 3.8 + var_424_21 then
				var_424_20.localPosition = Vector3.Lerp(arg_421_1.var_.moveOldPos1080ui_story, Vector3.New(0.7, -1.01, -6.05), (arg_421_1.time_ - 3.8) / var_424_21)
				var_424_20.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_424_20.position).x, (manager.ui.mainCamera.transform.position - var_424_20.position).y, (manager.ui.mainCamera.transform.position - var_424_20.position).z)
				var_424_20.localEulerAngles.z = 0
				var_424_20.localEulerAngles.x = 0
				var_424_20.localEulerAngles = var_424_20.localEulerAngles
			end

			if arg_421_1.time_ >= 3.8 + var_424_21 and arg_421_1.time_ < 3.8 + var_424_21 + arg_424_0 then
				var_424_20.localPosition = Vector3.New(0.7, -1.01, -6.05)
				var_424_20.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_424_20.position).x, (manager.ui.mainCamera.transform.position - var_424_20.position).y, (manager.ui.mainCamera.transform.position - var_424_20.position).z)
				var_424_20.localEulerAngles.z = 0
				var_424_20.localEulerAngles.x = 0
				var_424_20.localEulerAngles = var_424_20.localEulerAngles
			end

			local var_424_22 = arg_421_1.actors_["1080ui_story"]

			if 3.8 < arg_421_1.time_ and arg_421_1.time_ <= 3.8 + arg_424_0 and not isNil(var_424_22) and arg_421_1.var_.characterEffect1080ui_story == nil then
				arg_421_1.var_.characterEffect1080ui_story = var_424_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_424_23 = 0.200000002980232

			if 3.8 <= arg_421_1.time_ and arg_421_1.time_ < 3.8 + var_424_23 and not isNil(var_424_22) then
				if arg_421_1.var_.characterEffect1080ui_story and not isNil(var_424_22) then
					arg_421_1.var_.characterEffect1080ui_story.fillFlat = false
				end
			end

			if arg_421_1.time_ >= 3.8 + var_424_23 and arg_421_1.time_ < 3.8 + var_424_23 + arg_424_0 and not isNil(var_424_22) and arg_421_1.var_.characterEffect1080ui_story then
				arg_421_1.var_.characterEffect1080ui_story.fillFlat = false
			end

			if 3.8 < arg_421_1.time_ and arg_421_1.time_ <= 3.8 + arg_424_0 then
				arg_421_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/story1080/story1080action/1080action2_1")
			end

			if 3.8 < arg_421_1.time_ and arg_421_1.time_ <= 3.8 + arg_424_0 then
				arg_421_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_424_25 = arg_421_1.actors_["1027ui_story"].transform

			if 3.8 < arg_421_1.time_ and arg_421_1.time_ <= 3.8 + arg_424_0 then
				arg_421_1.var_.moveOldPos1027ui_story = var_424_25.localPosition
			end

			local var_424_26 = 0.001

			if 3.8 <= arg_421_1.time_ and arg_421_1.time_ < 3.8 + var_424_26 then
				var_424_25.localPosition = Vector3.Lerp(arg_421_1.var_.moveOldPos1027ui_story, Vector3.New(-0.7, -0.81, -5.8), (arg_421_1.time_ - 3.8) / var_424_26)
				var_424_25.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_424_25.position).x, (manager.ui.mainCamera.transform.position - var_424_25.position).y, (manager.ui.mainCamera.transform.position - var_424_25.position).z)
				var_424_25.localEulerAngles.z = 0
				var_424_25.localEulerAngles.x = 0
				var_424_25.localEulerAngles = var_424_25.localEulerAngles
			end

			if arg_421_1.time_ >= 3.8 + var_424_26 and arg_421_1.time_ < 3.8 + var_424_26 + arg_424_0 then
				var_424_25.localPosition = Vector3.New(-0.7, -0.81, -5.8)
				var_424_25.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_424_25.position).x, (manager.ui.mainCamera.transform.position - var_424_25.position).y, (manager.ui.mainCamera.transform.position - var_424_25.position).z)
				var_424_25.localEulerAngles.z = 0
				var_424_25.localEulerAngles.x = 0
				var_424_25.localEulerAngles = var_424_25.localEulerAngles
			end

			local var_424_27 = arg_421_1.actors_["1027ui_story"]

			if 3.8 < arg_421_1.time_ and arg_421_1.time_ <= 3.8 + arg_424_0 and not isNil(var_424_27) and arg_421_1.var_.characterEffect1027ui_story == nil then
				arg_421_1.var_.characterEffect1027ui_story = var_424_27:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_424_28 = 0.200000002980232

			if 3.8 <= arg_421_1.time_ and arg_421_1.time_ < 3.8 + var_424_28 and not isNil(var_424_27) then
				if arg_421_1.var_.characterEffect1027ui_story and not isNil(var_424_27) then
					arg_421_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_421_1.var_.characterEffect1027ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_421_1.time_ - 3.8) / var_424_28)
				end
			end

			if arg_421_1.time_ >= 3.8 + var_424_28 and arg_421_1.time_ < 3.8 + var_424_28 + arg_424_0 and not isNil(var_424_27) and arg_421_1.var_.characterEffect1027ui_story then
				arg_421_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_421_1.var_.characterEffect1027ui_story.fillRatio = 0.5
			end

			if 3.8 < arg_421_1.time_ and arg_421_1.time_ <= 3.8 + arg_424_0 then
				arg_421_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action1_1")
			end

			if 3.80000000298023 < arg_421_1.time_ and arg_421_1.time_ <= 3.80000000298023 + arg_424_0 then
				if arg_421_1.var_.characterEffect1027ui_story == nil then
					arg_421_1.var_.characterEffect1027ui_story = arg_421_1.actors_["1027ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_421_1.var_.characterEffect1027ui_story.imageEffect:turnOff()
			end

			if 3.8 < arg_421_1.time_ and arg_421_1.time_ <= 3.8 + arg_424_0 then
				if arg_421_1.var_.characterEffect1027ui_story == nil then
					arg_421_1.var_.characterEffect1027ui_story = arg_421_1.actors_["1027ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_424_30 = arg_421_1.var_.characterEffect1027ui_story

				arg_421_1.var_.characterEffect1027ui_story.imageEffect:turnOff()

				var_424_30.interferenceEffect.enabled = false
				var_424_30.interferenceEffect.noise = 0.01
				var_424_30.interferenceEffect.simTimeScale = 1
				var_424_30.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			if arg_421_1.frameCnt_ <= 1 then
				arg_421_1.dialog_:SetActive(false)
			end

			local var_424_31 = 4
			local var_424_32 = 0.35

			if 4 < arg_421_1.time_ and arg_421_1.time_ <= var_424_31 + arg_424_0 then
				arg_421_1.talkMaxDuration = 0

				arg_421_1.dialog_:SetActive(true)

				arg_421_1.dialogCg_.alpha = 0

				local var_424_33 = LeanTween.value(arg_421_1.dialog_, 0, 1, 0.3)

				var_424_33:setOnUpdate(LuaHelper.FloatAction(function(arg_425_0)
					arg_421_1.dialogCg_.alpha = arg_425_0
				end))
				var_424_33:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_421_1.dialog_)
					var_424_33:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_421_1.duration_ = arg_421_1.duration_ + 0.3

				SetActive(arg_421_1.leftNameGo_, true)

				arg_421_1.leftNameTxt_.text = arg_421_1:FormatText(StoryNameCfg[55].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_421_1.leftNameTxt_.transform)

				arg_421_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_421_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_421_1:RecordName(arg_421_1.leftNameTxt_.text)
				SetActive(arg_421_1.iconTrs_.gameObject, false)
				arg_421_1.callingController_:SetSelectedState("normal")

				local var_424_34 = arg_421_1:GetWordFromCfg(1109703101)
				local var_424_35 = arg_421_1:FormatText(var_424_34.content)

				arg_421_1.text_.text = var_424_35

				LuaForUtil.ClearLinePrefixSymbol(arg_421_1.text_)

				local var_424_37 = 14 <= 0 and var_424_32 or var_424_32 * (utf8.len(var_424_35) / 14)

				if (14 <= 0 and var_424_32 or var_424_32 * (utf8.len(var_424_35) / 14)) > 0 and var_424_32 < var_424_37 then
					arg_421_1.talkMaxDuration = var_424_37
					var_424_31 = var_424_31 + 0.3

					if var_424_37 + var_424_31 > arg_421_1.duration_ then
						arg_421_1.duration_ = var_424_37 + var_424_31
					end
				end

				arg_421_1.text_.text = var_424_35
				arg_421_1.typewritter.percent = 0

				arg_421_1.typewritter:SetDirty()
				arg_421_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703101", "story_v_side_new_1109703.awb") ~= 0 then
					local var_424_38 = manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703101", "story_v_side_new_1109703.awb") / 1000

					if var_424_38 + var_424_31 > arg_421_1.duration_ then
						arg_421_1.duration_ = var_424_38 + var_424_31
					end

					if var_424_34.prefab_name ~= "" and arg_421_1.actors_[var_424_34.prefab_name] ~= nil then
						local var_424_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_421_1.actors_[var_424_34.prefab_name].transform, "story_v_side_new_1109703", "1109703101", "story_v_side_new_1109703.awb")

						arg_421_1:RecordAudio("1109703101", var_424_39)
						arg_421_1:RecordAudio("1109703101", var_424_39)
					else
						arg_421_1:AudioAction("play", "voice", "story_v_side_new_1109703", "1109703101", "story_v_side_new_1109703.awb")
					end

					arg_421_1:RecordHistoryTalkVoice("story_v_side_new_1109703", "1109703101", "story_v_side_new_1109703.awb")
				end

				arg_421_1:RecordContent(arg_421_1.text_.text)
			end

			local var_424_40 = var_424_31 + 0.3
			local var_424_41 = math.max(var_424_32, arg_421_1.talkMaxDuration)

			if var_424_31 + 0.3 <= arg_421_1.time_ and arg_421_1.time_ < var_424_40 + var_424_41 then
				arg_421_1.typewritter.percent = (arg_421_1.time_ - var_424_40) / var_424_41

				arg_421_1.typewritter:SetDirty()
			end

			if arg_421_1.time_ >= var_424_40 + var_424_41 and arg_421_1.time_ < var_424_40 + var_424_41 + arg_424_0 then
				arg_421_1.typewritter.percent = 1

				arg_421_1.typewritter:SetDirty()
				arg_421_1:ShowNextGo(true)
			end
		end

		arg_421_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1080ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_421_1:InitPlayNodeList()
	end,
	Play1109703102 = function(arg_427_0, arg_427_1)
		arg_427_1.time_ = 0
		arg_427_1.frameCnt_ = 0
		arg_427_1.state_ = "playing"
		arg_427_1.curTalkId_ = 1109703102
		arg_427_1.duration_ = 5

		SetActive(arg_427_1.tipsGo_, false)

		function arg_427_1.onSingleLineFinish_()
			arg_427_1.onSingleLineUpdate_ = nil
			arg_427_1.onSingleLineFinish_ = nil
			arg_427_1.state_ = "waiting"
		end

		function arg_427_1.playNext_(arg_429_0)
			if arg_429_0 == 1 then
				arg_427_0:Play1109703103(arg_427_1)
			end
		end

		function arg_427_1.onSingleLineUpdate_(arg_430_0)
			if 0 < arg_427_1.time_ and arg_427_1.time_ <= 0 + arg_430_0 and not isNil(arg_427_1.actors_["1080ui_story"]) and arg_427_1.var_.characterEffect1080ui_story == nil then
				arg_427_1.var_.characterEffect1080ui_story = arg_427_1.actors_["1080ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_430_0 = 0.200000002980232

			if 0 <= arg_427_1.time_ and arg_427_1.time_ < 0 + var_430_0 and not isNil(arg_427_1.actors_["1080ui_story"]) then
				if arg_427_1.var_.characterEffect1080ui_story and not isNil(arg_427_1.actors_["1080ui_story"]) then
					arg_427_1.var_.characterEffect1080ui_story.fillFlat = true
					arg_427_1.var_.characterEffect1080ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_427_1.time_ - 0) / var_430_0)
				end
			end

			if arg_427_1.time_ >= 0 + var_430_0 and arg_427_1.time_ < 0 + var_430_0 + arg_430_0 and not isNil(arg_427_1.actors_["1080ui_story"]) and arg_427_1.var_.characterEffect1080ui_story then
				arg_427_1.var_.characterEffect1080ui_story.fillFlat = true
				arg_427_1.var_.characterEffect1080ui_story.fillRatio = 0.5
			end

			local var_430_1 = 0
			local var_430_2 = 0.275

			if 0 < arg_427_1.time_ and arg_427_1.time_ <= var_430_1 + arg_430_0 then
				arg_427_1.talkMaxDuration = 0
				arg_427_1.dialogCg_.alpha = 1

				arg_427_1.dialog_:SetActive(true)
				SetActive(arg_427_1.leftNameGo_, true)

				arg_427_1.leftNameTxt_.text = arg_427_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_427_1.leftNameTxt_.transform)

				arg_427_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_427_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_427_1:RecordName(arg_427_1.leftNameTxt_.text)
				SetActive(arg_427_1.iconTrs_.gameObject, true)
				arg_427_1.iconController_:SetSelectedState("hero")

				arg_427_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_427_1.callingController_:SetSelectedState("normal")

				arg_427_1.keyicon_.color = Color.New(1, 1, 1)
				arg_427_1.icon_.color = Color.New(1, 1, 1)

				local var_430_3 = arg_427_1:FormatText(arg_427_1:GetWordFromCfg(1109703102).content)

				arg_427_1.text_.text = var_430_3

				LuaForUtil.ClearLinePrefixSymbol(arg_427_1.text_)

				local var_430_5 = 11 <= 0 and var_430_2 or var_430_2 * (utf8.len(var_430_3) / 11)

				if (11 <= 0 and var_430_2 or var_430_2 * (utf8.len(var_430_3) / 11)) > 0 and var_430_2 < var_430_5 then
					arg_427_1.talkMaxDuration = var_430_5

					if var_430_5 + var_430_1 > arg_427_1.duration_ then
						arg_427_1.duration_ = var_430_5 + var_430_1
					end
				end

				arg_427_1.text_.text = var_430_3
				arg_427_1.typewritter.percent = 0

				arg_427_1.typewritter:SetDirty()
				arg_427_1:ShowNextGo(false)
				arg_427_1:RecordContent(arg_427_1.text_.text)
			end

			local var_430_6 = math.max(var_430_2, arg_427_1.talkMaxDuration)

			if var_430_1 <= arg_427_1.time_ and arg_427_1.time_ < var_430_1 + var_430_6 then
				arg_427_1.typewritter.percent = (arg_427_1.time_ - var_430_1) / var_430_6

				arg_427_1.typewritter:SetDirty()
			end

			if arg_427_1.time_ >= var_430_1 + var_430_6 and arg_427_1.time_ < var_430_1 + var_430_6 + arg_430_0 then
				arg_427_1.typewritter.percent = 1

				arg_427_1.typewritter:SetDirty()
				arg_427_1:ShowNextGo(true)
			end
		end

		arg_427_1.nodeConfigList_ = {}

		arg_427_1:InitPlayNodeList()
	end,
	Play1109703103 = function(arg_431_0, arg_431_1)
		arg_431_1.time_ = 0
		arg_431_1.frameCnt_ = 0
		arg_431_1.state_ = "playing"
		arg_431_1.curTalkId_ = 1109703103
		arg_431_1.duration_ = 8.23

		local var_431_0 = {
			zh = 8.233,
			ja = 8.2
		}
		local var_431_1 = manager.audio:GetLocalizationFlag()

		if var_431_0[var_431_1] ~= nil then
			arg_431_1.duration_ = var_431_0[var_431_1]
		end

		SetActive(arg_431_1.tipsGo_, false)

		function arg_431_1.onSingleLineFinish_()
			arg_431_1.onSingleLineUpdate_ = nil
			arg_431_1.onSingleLineFinish_ = nil
			arg_431_1.state_ = "waiting"
		end

		function arg_431_1.playNext_(arg_433_0)
			if arg_433_0 == 1 then
				arg_431_0:Play1109703104(arg_431_1)
			end
		end

		function arg_431_1.onSingleLineUpdate_(arg_434_0)
			if 0 < arg_431_1.time_ and arg_431_1.time_ <= 0 + arg_434_0 and not isNil(arg_431_1.actors_["1027ui_story"]) and arg_431_1.var_.characterEffect1027ui_story == nil then
				arg_431_1.var_.characterEffect1027ui_story = arg_431_1.actors_["1027ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_434_0 = 0.200000002980232

			if 0 <= arg_431_1.time_ and arg_431_1.time_ < 0 + var_434_0 and not isNil(arg_431_1.actors_["1027ui_story"]) then
				if arg_431_1.var_.characterEffect1027ui_story and not isNil(arg_431_1.actors_["1027ui_story"]) then
					arg_431_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_431_1.time_ >= 0 + var_434_0 and arg_431_1.time_ < 0 + var_434_0 + arg_434_0 and not isNil(arg_431_1.actors_["1027ui_story"]) and arg_431_1.var_.characterEffect1027ui_story then
				arg_431_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			if 0 < arg_431_1.time_ and arg_431_1.time_ <= 0 + arg_434_0 then
				arg_431_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action2_1")
			end

			if 0 < arg_431_1.time_ and arg_431_1.time_ <= 0 + arg_434_0 then
				arg_431_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_434_2 = 0
			local var_434_3 = 0.925

			if 0 < arg_431_1.time_ and arg_431_1.time_ <= var_434_2 + arg_434_0 then
				arg_431_1.talkMaxDuration = 0
				arg_431_1.dialogCg_.alpha = 1

				arg_431_1.dialog_:SetActive(true)
				SetActive(arg_431_1.leftNameGo_, true)

				arg_431_1.leftNameTxt_.text = arg_431_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_431_1.leftNameTxt_.transform)

				arg_431_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_431_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_431_1:RecordName(arg_431_1.leftNameTxt_.text)
				SetActive(arg_431_1.iconTrs_.gameObject, false)
				arg_431_1.callingController_:SetSelectedState("normal")

				local var_434_4 = arg_431_1:GetWordFromCfg(1109703103)
				local var_434_5 = arg_431_1:FormatText(var_434_4.content)

				arg_431_1.text_.text = var_434_5

				LuaForUtil.ClearLinePrefixSymbol(arg_431_1.text_)

				local var_434_7 = 37 <= 0 and var_434_3 or var_434_3 * (utf8.len(var_434_5) / 37)

				if (37 <= 0 and var_434_3 or var_434_3 * (utf8.len(var_434_5) / 37)) > 0 and var_434_3 < var_434_7 then
					arg_431_1.talkMaxDuration = var_434_7

					if var_434_7 + var_434_2 > arg_431_1.duration_ then
						arg_431_1.duration_ = var_434_7 + var_434_2
					end
				end

				arg_431_1.text_.text = var_434_5
				arg_431_1.typewritter.percent = 0

				arg_431_1.typewritter:SetDirty()
				arg_431_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703103", "story_v_side_new_1109703.awb") ~= 0 then
					local var_434_8 = manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703103", "story_v_side_new_1109703.awb") / 1000

					if var_434_8 + var_434_2 > arg_431_1.duration_ then
						arg_431_1.duration_ = var_434_8 + var_434_2
					end

					if var_434_4.prefab_name ~= "" and arg_431_1.actors_[var_434_4.prefab_name] ~= nil then
						local var_434_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_431_1.actors_[var_434_4.prefab_name].transform, "story_v_side_new_1109703", "1109703103", "story_v_side_new_1109703.awb")

						arg_431_1:RecordAudio("1109703103", var_434_9)
						arg_431_1:RecordAudio("1109703103", var_434_9)
					else
						arg_431_1:AudioAction("play", "voice", "story_v_side_new_1109703", "1109703103", "story_v_side_new_1109703.awb")
					end

					arg_431_1:RecordHistoryTalkVoice("story_v_side_new_1109703", "1109703103", "story_v_side_new_1109703.awb")
				end

				arg_431_1:RecordContent(arg_431_1.text_.text)
			end

			local var_434_10 = math.max(var_434_3, arg_431_1.talkMaxDuration)

			if var_434_2 <= arg_431_1.time_ and arg_431_1.time_ < var_434_2 + var_434_10 then
				arg_431_1.typewritter.percent = (arg_431_1.time_ - var_434_2) / var_434_10

				arg_431_1.typewritter:SetDirty()
			end

			if arg_431_1.time_ >= var_434_2 + var_434_10 and arg_431_1.time_ < var_434_2 + var_434_10 + arg_434_0 then
				arg_431_1.typewritter.percent = 1

				arg_431_1.typewritter:SetDirty()
				arg_431_1:ShowNextGo(true)
			end
		end

		arg_431_1.nodeConfigList_ = {}

		arg_431_1:InitPlayNodeList()
	end,
	Play1109703104 = function(arg_435_0, arg_435_1)
		arg_435_1.time_ = 0
		arg_435_1.frameCnt_ = 0
		arg_435_1.state_ = "playing"
		arg_435_1.curTalkId_ = 1109703104
		arg_435_1.duration_ = 5

		SetActive(arg_435_1.tipsGo_, false)

		function arg_435_1.onSingleLineFinish_()
			arg_435_1.onSingleLineUpdate_ = nil
			arg_435_1.onSingleLineFinish_ = nil
			arg_435_1.state_ = "waiting"
		end

		function arg_435_1.playNext_(arg_437_0)
			if arg_437_0 == 1 then
				arg_435_0:Play1109703105(arg_435_1)
			end
		end

		function arg_435_1.onSingleLineUpdate_(arg_438_0)
			if 0 < arg_435_1.time_ and arg_435_1.time_ <= 0 + arg_438_0 and not isNil(arg_435_1.actors_["1027ui_story"]) and arg_435_1.var_.characterEffect1027ui_story == nil then
				arg_435_1.var_.characterEffect1027ui_story = arg_435_1.actors_["1027ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_438_0 = 0.200000002980232

			if 0 <= arg_435_1.time_ and arg_435_1.time_ < 0 + var_438_0 and not isNil(arg_435_1.actors_["1027ui_story"]) then
				if arg_435_1.var_.characterEffect1027ui_story and not isNil(arg_435_1.actors_["1027ui_story"]) then
					arg_435_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_435_1.var_.characterEffect1027ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_435_1.time_ - 0) / var_438_0)
				end
			end

			if arg_435_1.time_ >= 0 + var_438_0 and arg_435_1.time_ < 0 + var_438_0 + arg_438_0 and not isNil(arg_435_1.actors_["1027ui_story"]) and arg_435_1.var_.characterEffect1027ui_story then
				arg_435_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_435_1.var_.characterEffect1027ui_story.fillRatio = 0.5
			end

			local var_438_1 = 0
			local var_438_2 = 1.25

			if 0 < arg_435_1.time_ and arg_435_1.time_ <= var_438_1 + arg_438_0 then
				arg_435_1.talkMaxDuration = 0
				arg_435_1.dialogCg_.alpha = 1

				arg_435_1.dialog_:SetActive(true)
				SetActive(arg_435_1.leftNameGo_, true)

				arg_435_1.leftNameTxt_.text = arg_435_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_435_1.leftNameTxt_.transform)

				arg_435_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_435_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_435_1:RecordName(arg_435_1.leftNameTxt_.text)
				SetActive(arg_435_1.iconTrs_.gameObject, true)
				arg_435_1.iconController_:SetSelectedState("hero")

				arg_435_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_435_1.callingController_:SetSelectedState("normal")

				arg_435_1.keyicon_.color = Color.New(1, 1, 1)
				arg_435_1.icon_.color = Color.New(1, 1, 1)

				local var_438_3 = arg_435_1:FormatText(arg_435_1:GetWordFromCfg(1109703104).content)

				arg_435_1.text_.text = var_438_3

				LuaForUtil.ClearLinePrefixSymbol(arg_435_1.text_)

				local var_438_5 = 50 <= 0 and var_438_2 or var_438_2 * (utf8.len(var_438_3) / 50)

				if (50 <= 0 and var_438_2 or var_438_2 * (utf8.len(var_438_3) / 50)) > 0 and var_438_2 < var_438_5 then
					arg_435_1.talkMaxDuration = var_438_5

					if var_438_5 + var_438_1 > arg_435_1.duration_ then
						arg_435_1.duration_ = var_438_5 + var_438_1
					end
				end

				arg_435_1.text_.text = var_438_3
				arg_435_1.typewritter.percent = 0

				arg_435_1.typewritter:SetDirty()
				arg_435_1:ShowNextGo(false)
				arg_435_1:RecordContent(arg_435_1.text_.text)
			end

			local var_438_6 = math.max(var_438_2, arg_435_1.talkMaxDuration)

			if var_438_1 <= arg_435_1.time_ and arg_435_1.time_ < var_438_1 + var_438_6 then
				arg_435_1.typewritter.percent = (arg_435_1.time_ - var_438_1) / var_438_6

				arg_435_1.typewritter:SetDirty()
			end

			if arg_435_1.time_ >= var_438_1 + var_438_6 and arg_435_1.time_ < var_438_1 + var_438_6 + arg_438_0 then
				arg_435_1.typewritter.percent = 1

				arg_435_1.typewritter:SetDirty()
				arg_435_1:ShowNextGo(true)
			end
		end

		arg_435_1.nodeConfigList_ = {}

		arg_435_1:InitPlayNodeList()
	end,
	Play1109703105 = function(arg_439_0, arg_439_1)
		arg_439_1.time_ = 0
		arg_439_1.frameCnt_ = 0
		arg_439_1.state_ = "playing"
		arg_439_1.curTalkId_ = 1109703105
		arg_439_1.duration_ = 10.77

		local var_439_0 = {
			zh = 10.766,
			ja = 9.266
		}
		local var_439_1 = manager.audio:GetLocalizationFlag()

		if var_439_0[var_439_1] ~= nil then
			arg_439_1.duration_ = var_439_0[var_439_1]
		end

		SetActive(arg_439_1.tipsGo_, false)

		function arg_439_1.onSingleLineFinish_()
			arg_439_1.onSingleLineUpdate_ = nil
			arg_439_1.onSingleLineFinish_ = nil
			arg_439_1.state_ = "waiting"
		end

		function arg_439_1.playNext_(arg_441_0)
			if arg_441_0 == 1 then
				arg_439_0:Play1109703106(arg_439_1)
			end
		end

		function arg_439_1.onSingleLineUpdate_(arg_442_0)
			if 0 < arg_439_1.time_ and arg_439_1.time_ <= 0 + arg_442_0 and not isNil(arg_439_1.actors_["1027ui_story"]) and arg_439_1.var_.characterEffect1027ui_story == nil then
				arg_439_1.var_.characterEffect1027ui_story = arg_439_1.actors_["1027ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_442_0 = 0.200000002980232

			if 0 <= arg_439_1.time_ and arg_439_1.time_ < 0 + var_442_0 and not isNil(arg_439_1.actors_["1027ui_story"]) then
				if arg_439_1.var_.characterEffect1027ui_story and not isNil(arg_439_1.actors_["1027ui_story"]) then
					arg_439_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_439_1.time_ >= 0 + var_442_0 and arg_439_1.time_ < 0 + var_442_0 + arg_442_0 and not isNil(arg_439_1.actors_["1027ui_story"]) and arg_439_1.var_.characterEffect1027ui_story then
				arg_439_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			if 0 < arg_439_1.time_ and arg_439_1.time_ <= 0 + arg_442_0 then
				arg_439_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027actionlink/1027action427")
			end

			if 0 < arg_439_1.time_ and arg_439_1.time_ <= 0 + arg_442_0 then
				arg_439_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_442_2 = 0
			local var_442_3 = 1.225

			if 0 < arg_439_1.time_ and arg_439_1.time_ <= var_442_2 + arg_442_0 then
				arg_439_1.talkMaxDuration = 0
				arg_439_1.dialogCg_.alpha = 1

				arg_439_1.dialog_:SetActive(true)
				SetActive(arg_439_1.leftNameGo_, true)

				arg_439_1.leftNameTxt_.text = arg_439_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_439_1.leftNameTxt_.transform)

				arg_439_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_439_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_439_1:RecordName(arg_439_1.leftNameTxt_.text)
				SetActive(arg_439_1.iconTrs_.gameObject, false)
				arg_439_1.callingController_:SetSelectedState("normal")

				local var_442_4 = arg_439_1:GetWordFromCfg(1109703105)
				local var_442_5 = arg_439_1:FormatText(var_442_4.content)

				arg_439_1.text_.text = var_442_5

				LuaForUtil.ClearLinePrefixSymbol(arg_439_1.text_)

				local var_442_7 = 49 <= 0 and var_442_3 or var_442_3 * (utf8.len(var_442_5) / 49)

				if (49 <= 0 and var_442_3 or var_442_3 * (utf8.len(var_442_5) / 49)) > 0 and var_442_3 < var_442_7 then
					arg_439_1.talkMaxDuration = var_442_7

					if var_442_7 + var_442_2 > arg_439_1.duration_ then
						arg_439_1.duration_ = var_442_7 + var_442_2
					end
				end

				arg_439_1.text_.text = var_442_5
				arg_439_1.typewritter.percent = 0

				arg_439_1.typewritter:SetDirty()
				arg_439_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703105", "story_v_side_new_1109703.awb") ~= 0 then
					local var_442_8 = manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703105", "story_v_side_new_1109703.awb") / 1000

					if var_442_8 + var_442_2 > arg_439_1.duration_ then
						arg_439_1.duration_ = var_442_8 + var_442_2
					end

					if var_442_4.prefab_name ~= "" and arg_439_1.actors_[var_442_4.prefab_name] ~= nil then
						local var_442_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_439_1.actors_[var_442_4.prefab_name].transform, "story_v_side_new_1109703", "1109703105", "story_v_side_new_1109703.awb")

						arg_439_1:RecordAudio("1109703105", var_442_9)
						arg_439_1:RecordAudio("1109703105", var_442_9)
					else
						arg_439_1:AudioAction("play", "voice", "story_v_side_new_1109703", "1109703105", "story_v_side_new_1109703.awb")
					end

					arg_439_1:RecordHistoryTalkVoice("story_v_side_new_1109703", "1109703105", "story_v_side_new_1109703.awb")
				end

				arg_439_1:RecordContent(arg_439_1.text_.text)
			end

			local var_442_10 = math.max(var_442_3, arg_439_1.talkMaxDuration)

			if var_442_2 <= arg_439_1.time_ and arg_439_1.time_ < var_442_2 + var_442_10 then
				arg_439_1.typewritter.percent = (arg_439_1.time_ - var_442_2) / var_442_10

				arg_439_1.typewritter:SetDirty()
			end

			if arg_439_1.time_ >= var_442_2 + var_442_10 and arg_439_1.time_ < var_442_2 + var_442_10 + arg_442_0 then
				arg_439_1.typewritter.percent = 1

				arg_439_1.typewritter:SetDirty()
				arg_439_1:ShowNextGo(true)
			end
		end

		arg_439_1.nodeConfigList_ = {}

		arg_439_1:InitPlayNodeList()
	end,
	Play1109703106 = function(arg_443_0, arg_443_1)
		arg_443_1.time_ = 0
		arg_443_1.frameCnt_ = 0
		arg_443_1.state_ = "playing"
		arg_443_1.curTalkId_ = 1109703106
		arg_443_1.duration_ = 2

		SetActive(arg_443_1.tipsGo_, false)

		function arg_443_1.onSingleLineFinish_()
			arg_443_1.onSingleLineUpdate_ = nil
			arg_443_1.onSingleLineFinish_ = nil
			arg_443_1.state_ = "waiting"
		end

		function arg_443_1.playNext_(arg_445_0)
			if arg_445_0 == 1 then
				arg_443_0:Play1109703107(arg_443_1)
			end
		end

		function arg_443_1.onSingleLineUpdate_(arg_446_0)
			if 0 < arg_443_1.time_ and arg_443_1.time_ <= 0 + arg_446_0 and not isNil(arg_443_1.actors_["1080ui_story"]) and arg_443_1.var_.characterEffect1080ui_story == nil then
				arg_443_1.var_.characterEffect1080ui_story = arg_443_1.actors_["1080ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_446_0 = 0.200000002980232

			if 0 <= arg_443_1.time_ and arg_443_1.time_ < 0 + var_446_0 and not isNil(arg_443_1.actors_["1080ui_story"]) then
				if arg_443_1.var_.characterEffect1080ui_story and not isNil(arg_443_1.actors_["1080ui_story"]) then
					arg_443_1.var_.characterEffect1080ui_story.fillFlat = false
				end
			end

			if arg_443_1.time_ >= 0 + var_446_0 and arg_443_1.time_ < 0 + var_446_0 + arg_446_0 and not isNil(arg_443_1.actors_["1080ui_story"]) and arg_443_1.var_.characterEffect1080ui_story then
				arg_443_1.var_.characterEffect1080ui_story.fillFlat = false
			end

			if 0 < arg_443_1.time_ and arg_443_1.time_ <= 0 + arg_446_0 then
				arg_443_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/story1080/story1080action/1080action2_2")
			end

			if 0 < arg_443_1.time_ and arg_443_1.time_ <= 0 + arg_446_0 then
				arg_443_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_446_2 = arg_443_1.actors_["1027ui_story"]

			if 0 < arg_443_1.time_ and arg_443_1.time_ <= 0 + arg_446_0 and not isNil(var_446_2) and arg_443_1.var_.characterEffect1027ui_story == nil then
				arg_443_1.var_.characterEffect1027ui_story = var_446_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_446_3 = 0.200000002980232

			if 0 <= arg_443_1.time_ and arg_443_1.time_ < 0 + var_446_3 and not isNil(var_446_2) then
				if arg_443_1.var_.characterEffect1027ui_story and not isNil(var_446_2) then
					arg_443_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_443_1.var_.characterEffect1027ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_443_1.time_ - 0) / var_446_3)
				end
			end

			if arg_443_1.time_ >= 0 + var_446_3 and arg_443_1.time_ < 0 + var_446_3 + arg_446_0 and not isNil(var_446_2) and arg_443_1.var_.characterEffect1027ui_story then
				arg_443_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_443_1.var_.characterEffect1027ui_story.fillRatio = 0.5
			end

			local var_446_4 = 0
			local var_446_5 = 0.125

			if 0 < arg_443_1.time_ and arg_443_1.time_ <= var_446_4 + arg_446_0 then
				arg_443_1.talkMaxDuration = 0
				arg_443_1.dialogCg_.alpha = 1

				arg_443_1.dialog_:SetActive(true)
				SetActive(arg_443_1.leftNameGo_, true)

				arg_443_1.leftNameTxt_.text = arg_443_1:FormatText(StoryNameCfg[55].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_443_1.leftNameTxt_.transform)

				arg_443_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_443_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_443_1:RecordName(arg_443_1.leftNameTxt_.text)
				SetActive(arg_443_1.iconTrs_.gameObject, false)
				arg_443_1.callingController_:SetSelectedState("normal")

				local var_446_6 = arg_443_1:GetWordFromCfg(1109703106)
				local var_446_7 = arg_443_1:FormatText(var_446_6.content)

				arg_443_1.text_.text = var_446_7

				LuaForUtil.ClearLinePrefixSymbol(arg_443_1.text_)

				local var_446_9 = 5 <= 0 and var_446_5 or var_446_5 * (utf8.len(var_446_7) / 5)

				if (5 <= 0 and var_446_5 or var_446_5 * (utf8.len(var_446_7) / 5)) > 0 and var_446_5 < var_446_9 then
					arg_443_1.talkMaxDuration = var_446_9

					if var_446_9 + var_446_4 > arg_443_1.duration_ then
						arg_443_1.duration_ = var_446_9 + var_446_4
					end
				end

				arg_443_1.text_.text = var_446_7
				arg_443_1.typewritter.percent = 0

				arg_443_1.typewritter:SetDirty()
				arg_443_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703106", "story_v_side_new_1109703.awb") ~= 0 then
					local var_446_10 = manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703106", "story_v_side_new_1109703.awb") / 1000

					if var_446_10 + var_446_4 > arg_443_1.duration_ then
						arg_443_1.duration_ = var_446_10 + var_446_4
					end

					if var_446_6.prefab_name ~= "" and arg_443_1.actors_[var_446_6.prefab_name] ~= nil then
						local var_446_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_443_1.actors_[var_446_6.prefab_name].transform, "story_v_side_new_1109703", "1109703106", "story_v_side_new_1109703.awb")

						arg_443_1:RecordAudio("1109703106", var_446_11)
						arg_443_1:RecordAudio("1109703106", var_446_11)
					else
						arg_443_1:AudioAction("play", "voice", "story_v_side_new_1109703", "1109703106", "story_v_side_new_1109703.awb")
					end

					arg_443_1:RecordHistoryTalkVoice("story_v_side_new_1109703", "1109703106", "story_v_side_new_1109703.awb")
				end

				arg_443_1:RecordContent(arg_443_1.text_.text)
			end

			local var_446_12 = math.max(var_446_5, arg_443_1.talkMaxDuration)

			if var_446_4 <= arg_443_1.time_ and arg_443_1.time_ < var_446_4 + var_446_12 then
				arg_443_1.typewritter.percent = (arg_443_1.time_ - var_446_4) / var_446_12

				arg_443_1.typewritter:SetDirty()
			end

			if arg_443_1.time_ >= var_446_4 + var_446_12 and arg_443_1.time_ < var_446_4 + var_446_12 + arg_446_0 then
				arg_443_1.typewritter.percent = 1

				arg_443_1.typewritter:SetDirty()
				arg_443_1:ShowNextGo(true)
			end
		end

		arg_443_1.nodeConfigList_ = {}

		arg_443_1:InitPlayNodeList()
	end,
	Play1109703107 = function(arg_447_0, arg_447_1)
		arg_447_1.time_ = 0
		arg_447_1.frameCnt_ = 0
		arg_447_1.state_ = "playing"
		arg_447_1.curTalkId_ = 1109703107
		arg_447_1.duration_ = 5

		SetActive(arg_447_1.tipsGo_, false)

		function arg_447_1.onSingleLineFinish_()
			arg_447_1.onSingleLineUpdate_ = nil
			arg_447_1.onSingleLineFinish_ = nil
			arg_447_1.state_ = "waiting"
		end

		function arg_447_1.playNext_(arg_449_0)
			if arg_449_0 == 1 then
				arg_447_0:Play1109703108(arg_447_1)
			end
		end

		function arg_447_1.onSingleLineUpdate_(arg_450_0)
			if 0 < arg_447_1.time_ and arg_447_1.time_ <= 0 + arg_450_0 and not isNil(arg_447_1.actors_["1080ui_story"]) and arg_447_1.var_.characterEffect1080ui_story == nil then
				arg_447_1.var_.characterEffect1080ui_story = arg_447_1.actors_["1080ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_450_0 = 0.200000002980232

			if 0 <= arg_447_1.time_ and arg_447_1.time_ < 0 + var_450_0 and not isNil(arg_447_1.actors_["1080ui_story"]) then
				if arg_447_1.var_.characterEffect1080ui_story and not isNil(arg_447_1.actors_["1080ui_story"]) then
					arg_447_1.var_.characterEffect1080ui_story.fillFlat = true
					arg_447_1.var_.characterEffect1080ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_447_1.time_ - 0) / var_450_0)
				end
			end

			if arg_447_1.time_ >= 0 + var_450_0 and arg_447_1.time_ < 0 + var_450_0 + arg_450_0 and not isNil(arg_447_1.actors_["1080ui_story"]) and arg_447_1.var_.characterEffect1080ui_story then
				arg_447_1.var_.characterEffect1080ui_story.fillFlat = true
				arg_447_1.var_.characterEffect1080ui_story.fillRatio = 0.5
			end

			local var_450_1 = 0
			local var_450_2 = 0.3

			if 0 < arg_447_1.time_ and arg_447_1.time_ <= var_450_1 + arg_450_0 then
				arg_447_1.talkMaxDuration = 0
				arg_447_1.dialogCg_.alpha = 1

				arg_447_1.dialog_:SetActive(true)
				SetActive(arg_447_1.leftNameGo_, true)

				arg_447_1.leftNameTxt_.text = arg_447_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_447_1.leftNameTxt_.transform)

				arg_447_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_447_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_447_1:RecordName(arg_447_1.leftNameTxt_.text)
				SetActive(arg_447_1.iconTrs_.gameObject, true)
				arg_447_1.iconController_:SetSelectedState("hero")

				arg_447_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_447_1.callingController_:SetSelectedState("normal")

				arg_447_1.keyicon_.color = Color.New(1, 1, 1)
				arg_447_1.icon_.color = Color.New(1, 1, 1)

				local var_450_3 = arg_447_1:FormatText(arg_447_1:GetWordFromCfg(1109703107).content)

				arg_447_1.text_.text = var_450_3

				LuaForUtil.ClearLinePrefixSymbol(arg_447_1.text_)

				local var_450_5 = 12 <= 0 and var_450_2 or var_450_2 * (utf8.len(var_450_3) / 12)

				if (12 <= 0 and var_450_2 or var_450_2 * (utf8.len(var_450_3) / 12)) > 0 and var_450_2 < var_450_5 then
					arg_447_1.talkMaxDuration = var_450_5

					if var_450_5 + var_450_1 > arg_447_1.duration_ then
						arg_447_1.duration_ = var_450_5 + var_450_1
					end
				end

				arg_447_1.text_.text = var_450_3
				arg_447_1.typewritter.percent = 0

				arg_447_1.typewritter:SetDirty()
				arg_447_1:ShowNextGo(false)
				arg_447_1:RecordContent(arg_447_1.text_.text)
			end

			local var_450_6 = math.max(var_450_2, arg_447_1.talkMaxDuration)

			if var_450_1 <= arg_447_1.time_ and arg_447_1.time_ < var_450_1 + var_450_6 then
				arg_447_1.typewritter.percent = (arg_447_1.time_ - var_450_1) / var_450_6

				arg_447_1.typewritter:SetDirty()
			end

			if arg_447_1.time_ >= var_450_1 + var_450_6 and arg_447_1.time_ < var_450_1 + var_450_6 + arg_450_0 then
				arg_447_1.typewritter.percent = 1

				arg_447_1.typewritter:SetDirty()
				arg_447_1:ShowNextGo(true)
			end
		end

		arg_447_1.nodeConfigList_ = {}

		arg_447_1:InitPlayNodeList()
	end,
	Play1109703108 = function(arg_451_0, arg_451_1)
		arg_451_1.time_ = 0
		arg_451_1.frameCnt_ = 0
		arg_451_1.state_ = "playing"
		arg_451_1.curTalkId_ = 1109703108
		arg_451_1.duration_ = 3.3

		local var_451_0 = {
			zh = 3.3,
			ja = 2.9
		}
		local var_451_1 = manager.audio:GetLocalizationFlag()

		if var_451_0[var_451_1] ~= nil then
			arg_451_1.duration_ = var_451_0[var_451_1]
		end

		SetActive(arg_451_1.tipsGo_, false)

		function arg_451_1.onSingleLineFinish_()
			arg_451_1.onSingleLineUpdate_ = nil
			arg_451_1.onSingleLineFinish_ = nil
			arg_451_1.state_ = "waiting"
		end

		function arg_451_1.playNext_(arg_453_0)
			if arg_453_0 == 1 then
				arg_451_0:Play1109703109(arg_451_1)
			end
		end

		function arg_451_1.onSingleLineUpdate_(arg_454_0)
			if 0 < arg_451_1.time_ and arg_451_1.time_ <= 0 + arg_454_0 then
				arg_451_1.var_.moveOldPos1097ui_story = arg_451_1.actors_["1097ui_story"].transform.localPosition
			end

			local var_454_0 = 0.001

			if 0 <= arg_451_1.time_ and arg_451_1.time_ < 0 + var_454_0 then
				arg_451_1.actors_["1097ui_story"].transform.localPosition = Vector3.Lerp(arg_451_1.var_.moveOldPos1097ui_story, Vector3.New(0, -0.54, -6.3), (arg_451_1.time_ - 0) / var_454_0)
				arg_451_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_451_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_451_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_451_1.actors_["1097ui_story"].transform.position).z)
				arg_451_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_451_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_451_1.actors_["1097ui_story"].transform.localEulerAngles = arg_451_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			if arg_451_1.time_ >= 0 + var_454_0 and arg_451_1.time_ < 0 + var_454_0 + arg_454_0 then
				arg_451_1.actors_["1097ui_story"].transform.localPosition = Vector3.New(0, -0.54, -6.3)
				arg_451_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_451_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_451_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_451_1.actors_["1097ui_story"].transform.position).z)
				arg_451_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_451_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_451_1.actors_["1097ui_story"].transform.localEulerAngles = arg_451_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			local var_454_1 = arg_451_1.actors_["1097ui_story"]

			if 0 < arg_451_1.time_ and arg_451_1.time_ <= 0 + arg_454_0 and not isNil(var_454_1) and arg_451_1.var_.characterEffect1097ui_story == nil then
				arg_451_1.var_.characterEffect1097ui_story = var_454_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_454_2 = 0.200000002980232

			if 0 <= arg_451_1.time_ and arg_451_1.time_ < 0 + var_454_2 and not isNil(var_454_1) then
				if arg_451_1.var_.characterEffect1097ui_story and not isNil(var_454_1) then
					arg_451_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_451_1.time_ >= 0 + var_454_2 and arg_451_1.time_ < 0 + var_454_2 + arg_454_0 and not isNil(var_454_1) and arg_451_1.var_.characterEffect1097ui_story then
				arg_451_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_451_1.time_ and arg_451_1.time_ <= 0 + arg_454_0 then
				arg_451_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			if 0 < arg_451_1.time_ and arg_451_1.time_ <= 0 + arg_454_0 then
				arg_451_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_454_4 = arg_451_1.actors_["1080ui_story"].transform

			if 0 < arg_451_1.time_ and arg_451_1.time_ <= 0 + arg_454_0 then
				arg_451_1.var_.moveOldPos1080ui_story = var_454_4.localPosition
			end

			local var_454_5 = 0.001

			if 0 <= arg_451_1.time_ and arg_451_1.time_ < 0 + var_454_5 then
				var_454_4.localPosition = Vector3.Lerp(arg_451_1.var_.moveOldPos1080ui_story, Vector3.New(0, 100, 0), (arg_451_1.time_ - 0) / var_454_5)
				var_454_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_454_4.position).x, (manager.ui.mainCamera.transform.position - var_454_4.position).y, (manager.ui.mainCamera.transform.position - var_454_4.position).z)
				var_454_4.localEulerAngles.z = 0
				var_454_4.localEulerAngles.x = 0
				var_454_4.localEulerAngles = var_454_4.localEulerAngles
			end

			if arg_451_1.time_ >= 0 + var_454_5 and arg_451_1.time_ < 0 + var_454_5 + arg_454_0 then
				var_454_4.localPosition = Vector3.New(0, 100, 0)
				var_454_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_454_4.position).x, (manager.ui.mainCamera.transform.position - var_454_4.position).y, (manager.ui.mainCamera.transform.position - var_454_4.position).z)
				var_454_4.localEulerAngles.z = 0
				var_454_4.localEulerAngles.x = 0
				var_454_4.localEulerAngles = var_454_4.localEulerAngles
			end

			local var_454_6 = arg_451_1.actors_["1080ui_story"]

			if 0 < arg_451_1.time_ and arg_451_1.time_ <= 0 + arg_454_0 and not isNil(var_454_6) and arg_451_1.var_.characterEffect1080ui_story == nil then
				arg_451_1.var_.characterEffect1080ui_story = var_454_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_454_7 = 0.200000002980232

			if 0 <= arg_451_1.time_ and arg_451_1.time_ < 0 + var_454_7 and not isNil(var_454_6) then
				if arg_451_1.var_.characterEffect1080ui_story and not isNil(var_454_6) then
					arg_451_1.var_.characterEffect1080ui_story.fillFlat = true
					arg_451_1.var_.characterEffect1080ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_451_1.time_ - 0) / var_454_7)
				end
			end

			if arg_451_1.time_ >= 0 + var_454_7 and arg_451_1.time_ < 0 + var_454_7 + arg_454_0 and not isNil(var_454_6) and arg_451_1.var_.characterEffect1080ui_story then
				arg_451_1.var_.characterEffect1080ui_story.fillFlat = true
				arg_451_1.var_.characterEffect1080ui_story.fillRatio = 0.5
			end

			local var_454_8 = arg_451_1.actors_["1027ui_story"].transform

			if 0 < arg_451_1.time_ and arg_451_1.time_ <= 0 + arg_454_0 then
				arg_451_1.var_.moveOldPos1027ui_story = var_454_8.localPosition
			end

			local var_454_9 = 0.001

			if 0 <= arg_451_1.time_ and arg_451_1.time_ < 0 + var_454_9 then
				var_454_8.localPosition = Vector3.Lerp(arg_451_1.var_.moveOldPos1027ui_story, Vector3.New(0, 100, 0), (arg_451_1.time_ - 0) / var_454_9)
				var_454_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_454_8.position).x, (manager.ui.mainCamera.transform.position - var_454_8.position).y, (manager.ui.mainCamera.transform.position - var_454_8.position).z)
				var_454_8.localEulerAngles.z = 0
				var_454_8.localEulerAngles.x = 0
				var_454_8.localEulerAngles = var_454_8.localEulerAngles
			end

			if arg_451_1.time_ >= 0 + var_454_9 and arg_451_1.time_ < 0 + var_454_9 + arg_454_0 then
				var_454_8.localPosition = Vector3.New(0, 100, 0)
				var_454_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_454_8.position).x, (manager.ui.mainCamera.transform.position - var_454_8.position).y, (manager.ui.mainCamera.transform.position - var_454_8.position).z)
				var_454_8.localEulerAngles.z = 0
				var_454_8.localEulerAngles.x = 0
				var_454_8.localEulerAngles = var_454_8.localEulerAngles
			end

			local var_454_10 = arg_451_1.actors_["1027ui_story"]

			if 0 < arg_451_1.time_ and arg_451_1.time_ <= 0 + arg_454_0 and not isNil(var_454_10) and arg_451_1.var_.characterEffect1027ui_story == nil then
				arg_451_1.var_.characterEffect1027ui_story = var_454_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_454_11 = 0.200000002980232

			if 0 <= arg_451_1.time_ and arg_451_1.time_ < 0 + var_454_11 and not isNil(var_454_10) then
				if arg_451_1.var_.characterEffect1027ui_story and not isNil(var_454_10) then
					arg_451_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_451_1.var_.characterEffect1027ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_451_1.time_ - 0) / var_454_11)
				end
			end

			if arg_451_1.time_ >= 0 + var_454_11 and arg_451_1.time_ < 0 + var_454_11 + arg_454_0 and not isNil(var_454_10) and arg_451_1.var_.characterEffect1027ui_story then
				arg_451_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_451_1.var_.characterEffect1027ui_story.fillRatio = 0.5
			end

			local var_454_12 = 0
			local var_454_13 = 0.3

			if 0 < arg_451_1.time_ and arg_451_1.time_ <= var_454_12 + arg_454_0 then
				arg_451_1.talkMaxDuration = 0
				arg_451_1.dialogCg_.alpha = 1

				arg_451_1.dialog_:SetActive(true)
				SetActive(arg_451_1.leftNameGo_, true)

				arg_451_1.leftNameTxt_.text = arg_451_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_451_1.leftNameTxt_.transform)

				arg_451_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_451_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_451_1:RecordName(arg_451_1.leftNameTxt_.text)
				SetActive(arg_451_1.iconTrs_.gameObject, false)
				arg_451_1.callingController_:SetSelectedState("normal")

				local var_454_14 = arg_451_1:GetWordFromCfg(1109703108)
				local var_454_15 = arg_451_1:FormatText(var_454_14.content)

				arg_451_1.text_.text = var_454_15

				LuaForUtil.ClearLinePrefixSymbol(arg_451_1.text_)

				local var_454_17 = 12 <= 0 and var_454_13 or var_454_13 * (utf8.len(var_454_15) / 12)

				if (12 <= 0 and var_454_13 or var_454_13 * (utf8.len(var_454_15) / 12)) > 0 and var_454_13 < var_454_17 then
					arg_451_1.talkMaxDuration = var_454_17

					if var_454_17 + var_454_12 > arg_451_1.duration_ then
						arg_451_1.duration_ = var_454_17 + var_454_12
					end
				end

				arg_451_1.text_.text = var_454_15
				arg_451_1.typewritter.percent = 0

				arg_451_1.typewritter:SetDirty()
				arg_451_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703108", "story_v_side_new_1109703.awb") ~= 0 then
					local var_454_18 = manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703108", "story_v_side_new_1109703.awb") / 1000

					if var_454_18 + var_454_12 > arg_451_1.duration_ then
						arg_451_1.duration_ = var_454_18 + var_454_12
					end

					if var_454_14.prefab_name ~= "" and arg_451_1.actors_[var_454_14.prefab_name] ~= nil then
						local var_454_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_451_1.actors_[var_454_14.prefab_name].transform, "story_v_side_new_1109703", "1109703108", "story_v_side_new_1109703.awb")

						arg_451_1:RecordAudio("1109703108", var_454_19)
						arg_451_1:RecordAudio("1109703108", var_454_19)
					else
						arg_451_1:AudioAction("play", "voice", "story_v_side_new_1109703", "1109703108", "story_v_side_new_1109703.awb")
					end

					arg_451_1:RecordHistoryTalkVoice("story_v_side_new_1109703", "1109703108", "story_v_side_new_1109703.awb")
				end

				arg_451_1:RecordContent(arg_451_1.text_.text)
			end

			local var_454_20 = math.max(var_454_13, arg_451_1.talkMaxDuration)

			if var_454_12 <= arg_451_1.time_ and arg_451_1.time_ < var_454_12 + var_454_20 then
				arg_451_1.typewritter.percent = (arg_451_1.time_ - var_454_12) / var_454_20

				arg_451_1.typewritter:SetDirty()
			end

			if arg_451_1.time_ >= var_454_12 + var_454_20 and arg_451_1.time_ < var_454_12 + var_454_20 + arg_454_0 then
				arg_451_1.typewritter.percent = 1

				arg_451_1.typewritter:SetDirty()
				arg_451_1:ShowNextGo(true)
			end
		end

		arg_451_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
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
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_451_1:InitPlayNodeList()
	end,
	Play1109703109 = function(arg_455_0, arg_455_1)
		arg_455_1.time_ = 0
		arg_455_1.frameCnt_ = 0
		arg_455_1.state_ = "playing"
		arg_455_1.curTalkId_ = 1109703109
		arg_455_1.duration_ = 5

		SetActive(arg_455_1.tipsGo_, false)

		function arg_455_1.onSingleLineFinish_()
			arg_455_1.onSingleLineUpdate_ = nil
			arg_455_1.onSingleLineFinish_ = nil
			arg_455_1.state_ = "waiting"
		end

		function arg_455_1.playNext_(arg_457_0)
			if arg_457_0 == 1 then
				arg_455_0:Play1109703110(arg_455_1)
			end
		end

		function arg_455_1.onSingleLineUpdate_(arg_458_0)
			if 0 < arg_455_1.time_ and arg_455_1.time_ <= 0 + arg_458_0 then
				arg_455_1.var_.moveOldPos1097ui_story = arg_455_1.actors_["1097ui_story"].transform.localPosition
			end

			local var_458_0 = 0.001

			if 0 <= arg_455_1.time_ and arg_455_1.time_ < 0 + var_458_0 then
				arg_455_1.actors_["1097ui_story"].transform.localPosition = Vector3.Lerp(arg_455_1.var_.moveOldPos1097ui_story, Vector3.New(0, 100, 0), (arg_455_1.time_ - 0) / var_458_0)
				arg_455_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_455_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_455_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_455_1.actors_["1097ui_story"].transform.position).z)
				arg_455_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_455_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_455_1.actors_["1097ui_story"].transform.localEulerAngles = arg_455_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			if arg_455_1.time_ >= 0 + var_458_0 and arg_455_1.time_ < 0 + var_458_0 + arg_458_0 then
				arg_455_1.actors_["1097ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_455_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_455_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_455_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_455_1.actors_["1097ui_story"].transform.position).z)
				arg_455_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_455_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_455_1.actors_["1097ui_story"].transform.localEulerAngles = arg_455_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			local var_458_1 = arg_455_1.actors_["1097ui_story"]

			if 0 < arg_455_1.time_ and arg_455_1.time_ <= 0 + arg_458_0 and not isNil(var_458_1) and arg_455_1.var_.characterEffect1097ui_story == nil then
				arg_455_1.var_.characterEffect1097ui_story = var_458_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_458_2 = 0.200000002980232

			if 0 <= arg_455_1.time_ and arg_455_1.time_ < 0 + var_458_2 and not isNil(var_458_1) then
				if arg_455_1.var_.characterEffect1097ui_story and not isNil(var_458_1) then
					arg_455_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_455_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_455_1.time_ - 0) / var_458_2)
				end
			end

			if arg_455_1.time_ >= 0 + var_458_2 and arg_455_1.time_ < 0 + var_458_2 + arg_458_0 and not isNil(var_458_1) and arg_455_1.var_.characterEffect1097ui_story then
				arg_455_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_455_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_458_3 = 0
			local var_458_4 = 0.5

			if 0 < arg_455_1.time_ and arg_455_1.time_ <= var_458_3 + arg_458_0 then
				arg_455_1.talkMaxDuration = 0
				arg_455_1.dialogCg_.alpha = 1

				arg_455_1.dialog_:SetActive(true)
				SetActive(arg_455_1.leftNameGo_, false)

				arg_455_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_455_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_455_1:RecordName(arg_455_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_455_1.iconTrs_.gameObject, false)
				arg_455_1.callingController_:SetSelectedState("normal")

				local var_458_5 = arg_455_1:FormatText(arg_455_1:GetWordFromCfg(1109703109).content)

				arg_455_1.text_.text = var_458_5

				LuaForUtil.ClearLinePrefixSymbol(arg_455_1.text_)

				local var_458_7 = 20 <= 0 and var_458_4 or var_458_4 * (utf8.len(var_458_5) / 20)

				if (20 <= 0 and var_458_4 or var_458_4 * (utf8.len(var_458_5) / 20)) > 0 and var_458_4 < var_458_7 then
					arg_455_1.talkMaxDuration = var_458_7

					if var_458_7 + var_458_3 > arg_455_1.duration_ then
						arg_455_1.duration_ = var_458_7 + var_458_3
					end
				end

				arg_455_1.text_.text = var_458_5
				arg_455_1.typewritter.percent = 0

				arg_455_1.typewritter:SetDirty()
				arg_455_1:ShowNextGo(false)
				arg_455_1:RecordContent(arg_455_1.text_.text)
			end

			local var_458_8 = math.max(var_458_4, arg_455_1.talkMaxDuration)

			if var_458_3 <= arg_455_1.time_ and arg_455_1.time_ < var_458_3 + var_458_8 then
				arg_455_1.typewritter.percent = (arg_455_1.time_ - var_458_3) / var_458_8

				arg_455_1.typewritter:SetDirty()
			end

			if arg_455_1.time_ >= var_458_3 + var_458_8 and arg_455_1.time_ < var_458_3 + var_458_8 + arg_458_0 then
				arg_455_1.typewritter.percent = 1

				arg_455_1.typewritter:SetDirty()
				arg_455_1:ShowNextGo(true)
			end
		end

		arg_455_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_455_1:InitPlayNodeList()
	end,
	Play1109703110 = function(arg_459_0, arg_459_1)
		arg_459_1.time_ = 0
		arg_459_1.frameCnt_ = 0
		arg_459_1.state_ = "playing"
		arg_459_1.curTalkId_ = 1109703110
		arg_459_1.duration_ = 5

		SetActive(arg_459_1.tipsGo_, false)

		function arg_459_1.onSingleLineFinish_()
			arg_459_1.onSingleLineUpdate_ = nil
			arg_459_1.onSingleLineFinish_ = nil
			arg_459_1.state_ = "waiting"
		end

		function arg_459_1.playNext_(arg_461_0)
			if arg_461_0 == 1 then
				arg_459_0:Play1109703111(arg_459_1)
			end
		end

		function arg_459_1.onSingleLineUpdate_(arg_462_0)
			local var_462_0 = 0.95

			if 0 < arg_459_1.time_ and arg_459_1.time_ <= 0 + arg_462_0 then
				arg_459_1.talkMaxDuration = 0
				arg_459_1.dialogCg_.alpha = 1

				arg_459_1.dialog_:SetActive(true)
				SetActive(arg_459_1.leftNameGo_, true)

				arg_459_1.leftNameTxt_.text = arg_459_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_459_1.leftNameTxt_.transform)

				arg_459_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_459_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_459_1:RecordName(arg_459_1.leftNameTxt_.text)
				SetActive(arg_459_1.iconTrs_.gameObject, true)
				arg_459_1.iconController_:SetSelectedState("hero")

				arg_459_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_459_1.callingController_:SetSelectedState("normal")

				arg_459_1.keyicon_.color = Color.New(1, 1, 1)
				arg_459_1.icon_.color = Color.New(1, 1, 1)

				local var_462_1 = arg_459_1:FormatText(arg_459_1:GetWordFromCfg(1109703110).content)

				arg_459_1.text_.text = var_462_1

				LuaForUtil.ClearLinePrefixSymbol(arg_459_1.text_)

				local var_462_3 = 38 <= 0 and var_462_0 or var_462_0 * (utf8.len(var_462_1) / 38)

				if (38 <= 0 and var_462_0 or var_462_0 * (utf8.len(var_462_1) / 38)) > 0 and var_462_0 < var_462_3 then
					arg_459_1.talkMaxDuration = var_462_3

					if var_462_3 + 0 > arg_459_1.duration_ then
						arg_459_1.duration_ = var_462_3 + 0
					end
				end

				arg_459_1.text_.text = var_462_1
				arg_459_1.typewritter.percent = 0

				arg_459_1.typewritter:SetDirty()
				arg_459_1:ShowNextGo(false)
				arg_459_1:RecordContent(arg_459_1.text_.text)
			end

			local var_462_4 = math.max(var_462_0, arg_459_1.talkMaxDuration)

			if 0 <= arg_459_1.time_ and arg_459_1.time_ < 0 + var_462_4 then
				arg_459_1.typewritter.percent = (arg_459_1.time_ - 0) / var_462_4

				arg_459_1.typewritter:SetDirty()
			end

			if arg_459_1.time_ >= 0 + var_462_4 and arg_459_1.time_ < 0 + var_462_4 + arg_462_0 then
				arg_459_1.typewritter.percent = 1

				arg_459_1.typewritter:SetDirty()
				arg_459_1:ShowNextGo(true)
			end
		end

		arg_459_1.nodeConfigList_ = {}

		arg_459_1:InitPlayNodeList()
	end,
	Play1109703111 = function(arg_463_0, arg_463_1)
		arg_463_1.time_ = 0
		arg_463_1.frameCnt_ = 0
		arg_463_1.state_ = "playing"
		arg_463_1.curTalkId_ = 1109703111
		arg_463_1.duration_ = 4.6

		local var_463_0 = {
			zh = 4.433,
			ja = 4.6
		}
		local var_463_1 = manager.audio:GetLocalizationFlag()

		if var_463_0[var_463_1] ~= nil then
			arg_463_1.duration_ = var_463_0[var_463_1]
		end

		SetActive(arg_463_1.tipsGo_, false)

		function arg_463_1.onSingleLineFinish_()
			arg_463_1.onSingleLineUpdate_ = nil
			arg_463_1.onSingleLineFinish_ = nil
			arg_463_1.state_ = "waiting"
		end

		function arg_463_1.playNext_(arg_465_0)
			if arg_465_0 == 1 then
				arg_463_0:Play1109703112(arg_463_1)
			end
		end

		function arg_463_1.onSingleLineUpdate_(arg_466_0)
			if 0 < arg_463_1.time_ and arg_463_1.time_ <= 0 + arg_466_0 then
				arg_463_1.var_.moveOldPos1080ui_story = arg_463_1.actors_["1080ui_story"].transform.localPosition
			end

			local var_466_0 = 0.001

			if 0 <= arg_463_1.time_ and arg_463_1.time_ < 0 + var_466_0 then
				arg_463_1.actors_["1080ui_story"].transform.localPosition = Vector3.Lerp(arg_463_1.var_.moveOldPos1080ui_story, Vector3.New(0.7, -1.01, -6.05), (arg_463_1.time_ - 0) / var_466_0)
				arg_463_1.actors_["1080ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_463_1.actors_["1080ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_463_1.actors_["1080ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_463_1.actors_["1080ui_story"].transform.position).z)
				arg_463_1.actors_["1080ui_story"].transform.localEulerAngles.z = 0
				arg_463_1.actors_["1080ui_story"].transform.localEulerAngles.x = 0
				arg_463_1.actors_["1080ui_story"].transform.localEulerAngles = arg_463_1.actors_["1080ui_story"].transform.localEulerAngles
			end

			if arg_463_1.time_ >= 0 + var_466_0 and arg_463_1.time_ < 0 + var_466_0 + arg_466_0 then
				arg_463_1.actors_["1080ui_story"].transform.localPosition = Vector3.New(0.7, -1.01, -6.05)
				arg_463_1.actors_["1080ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_463_1.actors_["1080ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_463_1.actors_["1080ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_463_1.actors_["1080ui_story"].transform.position).z)
				arg_463_1.actors_["1080ui_story"].transform.localEulerAngles.z = 0
				arg_463_1.actors_["1080ui_story"].transform.localEulerAngles.x = 0
				arg_463_1.actors_["1080ui_story"].transform.localEulerAngles = arg_463_1.actors_["1080ui_story"].transform.localEulerAngles
			end

			local var_466_1 = arg_463_1.actors_["1080ui_story"]

			if 0 < arg_463_1.time_ and arg_463_1.time_ <= 0 + arg_466_0 and not isNil(var_466_1) and arg_463_1.var_.characterEffect1080ui_story == nil then
				arg_463_1.var_.characterEffect1080ui_story = var_466_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_466_2 = 0.200000002980232

			if 0 <= arg_463_1.time_ and arg_463_1.time_ < 0 + var_466_2 and not isNil(var_466_1) then
				if arg_463_1.var_.characterEffect1080ui_story and not isNil(var_466_1) then
					arg_463_1.var_.characterEffect1080ui_story.fillFlat = false
				end
			end

			if arg_463_1.time_ >= 0 + var_466_2 and arg_463_1.time_ < 0 + var_466_2 + arg_466_0 and not isNil(var_466_1) and arg_463_1.var_.characterEffect1080ui_story then
				arg_463_1.var_.characterEffect1080ui_story.fillFlat = false
			end

			if 0 < arg_463_1.time_ and arg_463_1.time_ <= 0 + arg_466_0 then
				arg_463_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/story1080/story1080action/1080action1_1")
			end

			if 0 < arg_463_1.time_ and arg_463_1.time_ <= 0 + arg_466_0 then
				arg_463_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_466_4 = arg_463_1.actors_["1027ui_story"].transform

			if 0 < arg_463_1.time_ and arg_463_1.time_ <= 0 + arg_466_0 then
				arg_463_1.var_.moveOldPos1027ui_story = var_466_4.localPosition
			end

			local var_466_5 = 0.001

			if 0 <= arg_463_1.time_ and arg_463_1.time_ < 0 + var_466_5 then
				var_466_4.localPosition = Vector3.Lerp(arg_463_1.var_.moveOldPos1027ui_story, Vector3.New(-0.7, -0.81, -5.8), (arg_463_1.time_ - 0) / var_466_5)
				var_466_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_466_4.position).x, (manager.ui.mainCamera.transform.position - var_466_4.position).y, (manager.ui.mainCamera.transform.position - var_466_4.position).z)
				var_466_4.localEulerAngles.z = 0
				var_466_4.localEulerAngles.x = 0
				var_466_4.localEulerAngles = var_466_4.localEulerAngles
			end

			if arg_463_1.time_ >= 0 + var_466_5 and arg_463_1.time_ < 0 + var_466_5 + arg_466_0 then
				var_466_4.localPosition = Vector3.New(-0.7, -0.81, -5.8)
				var_466_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_466_4.position).x, (manager.ui.mainCamera.transform.position - var_466_4.position).y, (manager.ui.mainCamera.transform.position - var_466_4.position).z)
				var_466_4.localEulerAngles.z = 0
				var_466_4.localEulerAngles.x = 0
				var_466_4.localEulerAngles = var_466_4.localEulerAngles
			end

			local var_466_6 = arg_463_1.actors_["1027ui_story"]

			if 0 < arg_463_1.time_ and arg_463_1.time_ <= 0 + arg_466_0 and not isNil(var_466_6) and arg_463_1.var_.characterEffect1027ui_story == nil then
				arg_463_1.var_.characterEffect1027ui_story = var_466_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_466_7 = 0.200000002980232

			if 0 <= arg_463_1.time_ and arg_463_1.time_ < 0 + var_466_7 and not isNil(var_466_6) then
				if arg_463_1.var_.characterEffect1027ui_story and not isNil(var_466_6) then
					arg_463_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_463_1.var_.characterEffect1027ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_463_1.time_ - 0) / var_466_7)
				end
			end

			if arg_463_1.time_ >= 0 + var_466_7 and arg_463_1.time_ < 0 + var_466_7 + arg_466_0 and not isNil(var_466_6) and arg_463_1.var_.characterEffect1027ui_story then
				arg_463_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_463_1.var_.characterEffect1027ui_story.fillRatio = 0.5
			end

			if 0 < arg_463_1.time_ and arg_463_1.time_ <= 0 + arg_466_0 then
				arg_463_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027actionlink/1027action472")
			end

			local var_466_8 = 0
			local var_466_9 = 0.45

			if 0 < arg_463_1.time_ and arg_463_1.time_ <= var_466_8 + arg_466_0 then
				arg_463_1.talkMaxDuration = 0
				arg_463_1.dialogCg_.alpha = 1

				arg_463_1.dialog_:SetActive(true)
				SetActive(arg_463_1.leftNameGo_, true)

				arg_463_1.leftNameTxt_.text = arg_463_1:FormatText(StoryNameCfg[55].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_463_1.leftNameTxt_.transform)

				arg_463_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_463_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_463_1:RecordName(arg_463_1.leftNameTxt_.text)
				SetActive(arg_463_1.iconTrs_.gameObject, false)
				arg_463_1.callingController_:SetSelectedState("normal")

				local var_466_10 = arg_463_1:GetWordFromCfg(1109703111)
				local var_466_11 = arg_463_1:FormatText(var_466_10.content)

				arg_463_1.text_.text = var_466_11

				LuaForUtil.ClearLinePrefixSymbol(arg_463_1.text_)

				local var_466_13 = 18 <= 0 and var_466_9 or var_466_9 * (utf8.len(var_466_11) / 18)

				if (18 <= 0 and var_466_9 or var_466_9 * (utf8.len(var_466_11) / 18)) > 0 and var_466_9 < var_466_13 then
					arg_463_1.talkMaxDuration = var_466_13

					if var_466_13 + var_466_8 > arg_463_1.duration_ then
						arg_463_1.duration_ = var_466_13 + var_466_8
					end
				end

				arg_463_1.text_.text = var_466_11
				arg_463_1.typewritter.percent = 0

				arg_463_1.typewritter:SetDirty()
				arg_463_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703111", "story_v_side_new_1109703.awb") ~= 0 then
					local var_466_14 = manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703111", "story_v_side_new_1109703.awb") / 1000

					if var_466_14 + var_466_8 > arg_463_1.duration_ then
						arg_463_1.duration_ = var_466_14 + var_466_8
					end

					if var_466_10.prefab_name ~= "" and arg_463_1.actors_[var_466_10.prefab_name] ~= nil then
						local var_466_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_463_1.actors_[var_466_10.prefab_name].transform, "story_v_side_new_1109703", "1109703111", "story_v_side_new_1109703.awb")

						arg_463_1:RecordAudio("1109703111", var_466_15)
						arg_463_1:RecordAudio("1109703111", var_466_15)
					else
						arg_463_1:AudioAction("play", "voice", "story_v_side_new_1109703", "1109703111", "story_v_side_new_1109703.awb")
					end

					arg_463_1:RecordHistoryTalkVoice("story_v_side_new_1109703", "1109703111", "story_v_side_new_1109703.awb")
				end

				arg_463_1:RecordContent(arg_463_1.text_.text)
			end

			local var_466_16 = math.max(var_466_9, arg_463_1.talkMaxDuration)

			if var_466_8 <= arg_463_1.time_ and arg_463_1.time_ < var_466_8 + var_466_16 then
				arg_463_1.typewritter.percent = (arg_463_1.time_ - var_466_8) / var_466_16

				arg_463_1.typewritter:SetDirty()
			end

			if arg_463_1.time_ >= var_466_8 + var_466_16 and arg_463_1.time_ < var_466_8 + var_466_16 + arg_466_0 then
				arg_463_1.typewritter.percent = 1

				arg_463_1.typewritter:SetDirty()
				arg_463_1:ShowNextGo(true)
			end
		end

		arg_463_1.nodeConfigList_ = {
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
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_463_1:InitPlayNodeList()
	end,
	Play1109703112 = function(arg_467_0, arg_467_1)
		arg_467_1.time_ = 0
		arg_467_1.frameCnt_ = 0
		arg_467_1.state_ = "playing"
		arg_467_1.curTalkId_ = 1109703112
		arg_467_1.duration_ = 5.57

		local var_467_0 = {
			zh = 4.533,
			ja = 5.566
		}
		local var_467_1 = manager.audio:GetLocalizationFlag()

		if var_467_0[var_467_1] ~= nil then
			arg_467_1.duration_ = var_467_0[var_467_1]
		end

		SetActive(arg_467_1.tipsGo_, false)

		function arg_467_1.onSingleLineFinish_()
			arg_467_1.onSingleLineUpdate_ = nil
			arg_467_1.onSingleLineFinish_ = nil
			arg_467_1.state_ = "waiting"
		end

		function arg_467_1.playNext_(arg_469_0)
			if arg_469_0 == 1 then
				arg_467_0:Play1109703113(arg_467_1)
			end
		end

		function arg_467_1.onSingleLineUpdate_(arg_470_0)
			if 0 < arg_467_1.time_ and arg_467_1.time_ <= 0 + arg_470_0 and not isNil(arg_467_1.actors_["1027ui_story"]) and arg_467_1.var_.characterEffect1027ui_story == nil then
				arg_467_1.var_.characterEffect1027ui_story = arg_467_1.actors_["1027ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_470_0 = 0.200000002980232

			if 0 <= arg_467_1.time_ and arg_467_1.time_ < 0 + var_470_0 and not isNil(arg_467_1.actors_["1027ui_story"]) then
				if arg_467_1.var_.characterEffect1027ui_story and not isNil(arg_467_1.actors_["1027ui_story"]) then
					arg_467_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_467_1.time_ >= 0 + var_470_0 and arg_467_1.time_ < 0 + var_470_0 + arg_470_0 and not isNil(arg_467_1.actors_["1027ui_story"]) and arg_467_1.var_.characterEffect1027ui_story then
				arg_467_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			local var_470_2 = arg_467_1.actors_["1080ui_story"]

			if 0 < arg_467_1.time_ and arg_467_1.time_ <= 0 + arg_470_0 and not isNil(var_470_2) and arg_467_1.var_.characterEffect1080ui_story == nil then
				arg_467_1.var_.characterEffect1080ui_story = var_470_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_470_3 = 0.200000002980232

			if 0 <= arg_467_1.time_ and arg_467_1.time_ < 0 + var_470_3 and not isNil(var_470_2) then
				if arg_467_1.var_.characterEffect1080ui_story and not isNil(var_470_2) then
					arg_467_1.var_.characterEffect1080ui_story.fillFlat = true
					arg_467_1.var_.characterEffect1080ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_467_1.time_ - 0) / var_470_3)
				end
			end

			if arg_467_1.time_ >= 0 + var_470_3 and arg_467_1.time_ < 0 + var_470_3 + arg_470_0 and not isNil(var_470_2) and arg_467_1.var_.characterEffect1080ui_story then
				arg_467_1.var_.characterEffect1080ui_story.fillFlat = true
				arg_467_1.var_.characterEffect1080ui_story.fillRatio = 0.5
			end

			local var_470_4 = 0
			local var_470_5 = 0.55

			if 0 < arg_467_1.time_ and arg_467_1.time_ <= var_470_4 + arg_470_0 then
				arg_467_1.talkMaxDuration = 0
				arg_467_1.dialogCg_.alpha = 1

				arg_467_1.dialog_:SetActive(true)
				SetActive(arg_467_1.leftNameGo_, true)

				arg_467_1.leftNameTxt_.text = arg_467_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_467_1.leftNameTxt_.transform)

				arg_467_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_467_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_467_1:RecordName(arg_467_1.leftNameTxt_.text)
				SetActive(arg_467_1.iconTrs_.gameObject, false)
				arg_467_1.callingController_:SetSelectedState("normal")

				local var_470_6 = arg_467_1:GetWordFromCfg(1109703112)
				local var_470_7 = arg_467_1:FormatText(var_470_6.content)

				arg_467_1.text_.text = var_470_7

				LuaForUtil.ClearLinePrefixSymbol(arg_467_1.text_)

				local var_470_9 = 22 <= 0 and var_470_5 or var_470_5 * (utf8.len(var_470_7) / 22)

				if (22 <= 0 and var_470_5 or var_470_5 * (utf8.len(var_470_7) / 22)) > 0 and var_470_5 < var_470_9 then
					arg_467_1.talkMaxDuration = var_470_9

					if var_470_9 + var_470_4 > arg_467_1.duration_ then
						arg_467_1.duration_ = var_470_9 + var_470_4
					end
				end

				arg_467_1.text_.text = var_470_7
				arg_467_1.typewritter.percent = 0

				arg_467_1.typewritter:SetDirty()
				arg_467_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703112", "story_v_side_new_1109703.awb") ~= 0 then
					local var_470_10 = manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703112", "story_v_side_new_1109703.awb") / 1000

					if var_470_10 + var_470_4 > arg_467_1.duration_ then
						arg_467_1.duration_ = var_470_10 + var_470_4
					end

					if var_470_6.prefab_name ~= "" and arg_467_1.actors_[var_470_6.prefab_name] ~= nil then
						local var_470_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_467_1.actors_[var_470_6.prefab_name].transform, "story_v_side_new_1109703", "1109703112", "story_v_side_new_1109703.awb")

						arg_467_1:RecordAudio("1109703112", var_470_11)
						arg_467_1:RecordAudio("1109703112", var_470_11)
					else
						arg_467_1:AudioAction("play", "voice", "story_v_side_new_1109703", "1109703112", "story_v_side_new_1109703.awb")
					end

					arg_467_1:RecordHistoryTalkVoice("story_v_side_new_1109703", "1109703112", "story_v_side_new_1109703.awb")
				end

				arg_467_1:RecordContent(arg_467_1.text_.text)
			end

			local var_470_12 = math.max(var_470_5, arg_467_1.talkMaxDuration)

			if var_470_4 <= arg_467_1.time_ and arg_467_1.time_ < var_470_4 + var_470_12 then
				arg_467_1.typewritter.percent = (arg_467_1.time_ - var_470_4) / var_470_12

				arg_467_1.typewritter:SetDirty()
			end

			if arg_467_1.time_ >= var_470_4 + var_470_12 and arg_467_1.time_ < var_470_4 + var_470_12 + arg_470_0 then
				arg_467_1.typewritter.percent = 1

				arg_467_1.typewritter:SetDirty()
				arg_467_1:ShowNextGo(true)
			end
		end

		arg_467_1.nodeConfigList_ = {}

		arg_467_1:InitPlayNodeList()
	end,
	Play1109703113 = function(arg_471_0, arg_471_1)
		arg_471_1.time_ = 0
		arg_471_1.frameCnt_ = 0
		arg_471_1.state_ = "playing"
		arg_471_1.curTalkId_ = 1109703113
		arg_471_1.duration_ = 5

		SetActive(arg_471_1.tipsGo_, false)

		function arg_471_1.onSingleLineFinish_()
			arg_471_1.onSingleLineUpdate_ = nil
			arg_471_1.onSingleLineFinish_ = nil
			arg_471_1.state_ = "waiting"
		end

		function arg_471_1.playNext_(arg_473_0)
			if arg_473_0 == 1 then
				arg_471_0:Play1109703114(arg_471_1)
			end
		end

		function arg_471_1.onSingleLineUpdate_(arg_474_0)
			if 0 < arg_471_1.time_ and arg_471_1.time_ <= 0 + arg_474_0 and not isNil(arg_471_1.actors_["1027ui_story"]) and arg_471_1.var_.characterEffect1027ui_story == nil then
				arg_471_1.var_.characterEffect1027ui_story = arg_471_1.actors_["1027ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_474_0 = 0.200000002980232

			if 0 <= arg_471_1.time_ and arg_471_1.time_ < 0 + var_474_0 and not isNil(arg_471_1.actors_["1027ui_story"]) then
				if arg_471_1.var_.characterEffect1027ui_story and not isNil(arg_471_1.actors_["1027ui_story"]) then
					arg_471_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_471_1.var_.characterEffect1027ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_471_1.time_ - 0) / var_474_0)
				end
			end

			if arg_471_1.time_ >= 0 + var_474_0 and arg_471_1.time_ < 0 + var_474_0 + arg_474_0 and not isNil(arg_471_1.actors_["1027ui_story"]) and arg_471_1.var_.characterEffect1027ui_story then
				arg_471_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_471_1.var_.characterEffect1027ui_story.fillRatio = 0.5
			end

			local var_474_1 = 0
			local var_474_2 = 0.85

			if 0 < arg_471_1.time_ and arg_471_1.time_ <= var_474_1 + arg_474_0 then
				arg_471_1.talkMaxDuration = 0
				arg_471_1.dialogCg_.alpha = 1

				arg_471_1.dialog_:SetActive(true)
				SetActive(arg_471_1.leftNameGo_, false)

				arg_471_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_471_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_471_1:RecordName(arg_471_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_471_1.iconTrs_.gameObject, false)
				arg_471_1.callingController_:SetSelectedState("normal")

				local var_474_3 = arg_471_1:FormatText(arg_471_1:GetWordFromCfg(1109703113).content)

				arg_471_1.text_.text = var_474_3

				LuaForUtil.ClearLinePrefixSymbol(arg_471_1.text_)

				local var_474_5 = 34 <= 0 and var_474_2 or var_474_2 * (utf8.len(var_474_3) / 34)

				if (34 <= 0 and var_474_2 or var_474_2 * (utf8.len(var_474_3) / 34)) > 0 and var_474_2 < var_474_5 then
					arg_471_1.talkMaxDuration = var_474_5

					if var_474_5 + var_474_1 > arg_471_1.duration_ then
						arg_471_1.duration_ = var_474_5 + var_474_1
					end
				end

				arg_471_1.text_.text = var_474_3
				arg_471_1.typewritter.percent = 0

				arg_471_1.typewritter:SetDirty()
				arg_471_1:ShowNextGo(false)
				arg_471_1:RecordContent(arg_471_1.text_.text)
			end

			local var_474_6 = math.max(var_474_2, arg_471_1.talkMaxDuration)

			if var_474_1 <= arg_471_1.time_ and arg_471_1.time_ < var_474_1 + var_474_6 then
				arg_471_1.typewritter.percent = (arg_471_1.time_ - var_474_1) / var_474_6

				arg_471_1.typewritter:SetDirty()
			end

			if arg_471_1.time_ >= var_474_1 + var_474_6 and arg_471_1.time_ < var_474_1 + var_474_6 + arg_474_0 then
				arg_471_1.typewritter.percent = 1

				arg_471_1.typewritter:SetDirty()
				arg_471_1:ShowNextGo(true)
			end
		end

		arg_471_1.nodeConfigList_ = {}

		arg_471_1:InitPlayNodeList()
	end,
	Play1109703114 = function(arg_475_0, arg_475_1)
		arg_475_1.time_ = 0
		arg_475_1.frameCnt_ = 0
		arg_475_1.state_ = "playing"
		arg_475_1.curTalkId_ = 1109703114
		arg_475_1.duration_ = 5

		SetActive(arg_475_1.tipsGo_, false)

		function arg_475_1.onSingleLineFinish_()
			arg_475_1.onSingleLineUpdate_ = nil
			arg_475_1.onSingleLineFinish_ = nil
			arg_475_1.state_ = "waiting"
		end

		function arg_475_1.playNext_(arg_477_0)
			if arg_477_0 == 1 then
				arg_475_0:Play1109703115(arg_475_1)
			end
		end

		function arg_475_1.onSingleLineUpdate_(arg_478_0)
			if 0 < arg_475_1.time_ and arg_475_1.time_ <= 0 + arg_478_0 then
				arg_475_1.var_.moveOldPos1080ui_story = arg_475_1.actors_["1080ui_story"].transform.localPosition
			end

			local var_478_0 = 0.001

			if 0 <= arg_475_1.time_ and arg_475_1.time_ < 0 + var_478_0 then
				arg_475_1.actors_["1080ui_story"].transform.localPosition = Vector3.Lerp(arg_475_1.var_.moveOldPos1080ui_story, Vector3.New(0, 100, 0), (arg_475_1.time_ - 0) / var_478_0)
				arg_475_1.actors_["1080ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_475_1.actors_["1080ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_475_1.actors_["1080ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_475_1.actors_["1080ui_story"].transform.position).z)
				arg_475_1.actors_["1080ui_story"].transform.localEulerAngles.z = 0
				arg_475_1.actors_["1080ui_story"].transform.localEulerAngles.x = 0
				arg_475_1.actors_["1080ui_story"].transform.localEulerAngles = arg_475_1.actors_["1080ui_story"].transform.localEulerAngles
			end

			if arg_475_1.time_ >= 0 + var_478_0 and arg_475_1.time_ < 0 + var_478_0 + arg_478_0 then
				arg_475_1.actors_["1080ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_475_1.actors_["1080ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_475_1.actors_["1080ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_475_1.actors_["1080ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_475_1.actors_["1080ui_story"].transform.position).z)
				arg_475_1.actors_["1080ui_story"].transform.localEulerAngles.z = 0
				arg_475_1.actors_["1080ui_story"].transform.localEulerAngles.x = 0
				arg_475_1.actors_["1080ui_story"].transform.localEulerAngles = arg_475_1.actors_["1080ui_story"].transform.localEulerAngles
			end

			local var_478_1 = arg_475_1.actors_["1080ui_story"]

			if 0 < arg_475_1.time_ and arg_475_1.time_ <= 0 + arg_478_0 and not isNil(var_478_1) and arg_475_1.var_.characterEffect1080ui_story == nil then
				arg_475_1.var_.characterEffect1080ui_story = var_478_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_478_2 = 0.200000002980232

			if 0 <= arg_475_1.time_ and arg_475_1.time_ < 0 + var_478_2 and not isNil(var_478_1) then
				if arg_475_1.var_.characterEffect1080ui_story and not isNil(var_478_1) then
					arg_475_1.var_.characterEffect1080ui_story.fillFlat = true
					arg_475_1.var_.characterEffect1080ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_475_1.time_ - 0) / var_478_2)
				end
			end

			if arg_475_1.time_ >= 0 + var_478_2 and arg_475_1.time_ < 0 + var_478_2 + arg_478_0 and not isNil(var_478_1) and arg_475_1.var_.characterEffect1080ui_story then
				arg_475_1.var_.characterEffect1080ui_story.fillFlat = true
				arg_475_1.var_.characterEffect1080ui_story.fillRatio = 0.5
			end

			local var_478_3 = arg_475_1.actors_["1027ui_story"].transform

			if 0 < arg_475_1.time_ and arg_475_1.time_ <= 0 + arg_478_0 then
				arg_475_1.var_.moveOldPos1027ui_story = var_478_3.localPosition
			end

			local var_478_4 = 0.001

			if 0 <= arg_475_1.time_ and arg_475_1.time_ < 0 + var_478_4 then
				var_478_3.localPosition = Vector3.Lerp(arg_475_1.var_.moveOldPos1027ui_story, Vector3.New(0, 100, 0), (arg_475_1.time_ - 0) / var_478_4)
				var_478_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_478_3.position).x, (manager.ui.mainCamera.transform.position - var_478_3.position).y, (manager.ui.mainCamera.transform.position - var_478_3.position).z)
				var_478_3.localEulerAngles.z = 0
				var_478_3.localEulerAngles.x = 0
				var_478_3.localEulerAngles = var_478_3.localEulerAngles
			end

			if arg_475_1.time_ >= 0 + var_478_4 and arg_475_1.time_ < 0 + var_478_4 + arg_478_0 then
				var_478_3.localPosition = Vector3.New(0, 100, 0)
				var_478_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_478_3.position).x, (manager.ui.mainCamera.transform.position - var_478_3.position).y, (manager.ui.mainCamera.transform.position - var_478_3.position).z)
				var_478_3.localEulerAngles.z = 0
				var_478_3.localEulerAngles.x = 0
				var_478_3.localEulerAngles = var_478_3.localEulerAngles
			end

			local var_478_5 = arg_475_1.actors_["1027ui_story"]

			if 0 < arg_475_1.time_ and arg_475_1.time_ <= 0 + arg_478_0 and not isNil(var_478_5) and arg_475_1.var_.characterEffect1027ui_story == nil then
				arg_475_1.var_.characterEffect1027ui_story = var_478_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_478_6 = 0.200000002980232

			if 0 <= arg_475_1.time_ and arg_475_1.time_ < 0 + var_478_6 and not isNil(var_478_5) then
				if arg_475_1.var_.characterEffect1027ui_story and not isNil(var_478_5) then
					arg_475_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_475_1.var_.characterEffect1027ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_475_1.time_ - 0) / var_478_6)
				end
			end

			if arg_475_1.time_ >= 0 + var_478_6 and arg_475_1.time_ < 0 + var_478_6 + arg_478_0 and not isNil(var_478_5) and arg_475_1.var_.characterEffect1027ui_story then
				arg_475_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_475_1.var_.characterEffect1027ui_story.fillRatio = 0.5
			end

			local var_478_7 = 0
			local var_478_8 = 0.925

			if 0 < arg_475_1.time_ and arg_475_1.time_ <= var_478_7 + arg_478_0 then
				arg_475_1.talkMaxDuration = 0
				arg_475_1.dialogCg_.alpha = 1

				arg_475_1.dialog_:SetActive(true)
				SetActive(arg_475_1.leftNameGo_, true)

				arg_475_1.leftNameTxt_.text = arg_475_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_475_1.leftNameTxt_.transform)

				arg_475_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_475_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_475_1:RecordName(arg_475_1.leftNameTxt_.text)
				SetActive(arg_475_1.iconTrs_.gameObject, true)
				arg_475_1.iconController_:SetSelectedState("hero")

				arg_475_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_475_1.callingController_:SetSelectedState("normal")

				arg_475_1.keyicon_.color = Color.New(1, 1, 1)
				arg_475_1.icon_.color = Color.New(1, 1, 1)

				local var_478_9 = arg_475_1:FormatText(arg_475_1:GetWordFromCfg(1109703114).content)

				arg_475_1.text_.text = var_478_9

				LuaForUtil.ClearLinePrefixSymbol(arg_475_1.text_)

				local var_478_11 = 37 <= 0 and var_478_8 or var_478_8 * (utf8.len(var_478_9) / 37)

				if (37 <= 0 and var_478_8 or var_478_8 * (utf8.len(var_478_9) / 37)) > 0 and var_478_8 < var_478_11 then
					arg_475_1.talkMaxDuration = var_478_11

					if var_478_11 + var_478_7 > arg_475_1.duration_ then
						arg_475_1.duration_ = var_478_11 + var_478_7
					end
				end

				arg_475_1.text_.text = var_478_9
				arg_475_1.typewritter.percent = 0

				arg_475_1.typewritter:SetDirty()
				arg_475_1:ShowNextGo(false)
				arg_475_1:RecordContent(arg_475_1.text_.text)
			end

			local var_478_12 = math.max(var_478_8, arg_475_1.talkMaxDuration)

			if var_478_7 <= arg_475_1.time_ and arg_475_1.time_ < var_478_7 + var_478_12 then
				arg_475_1.typewritter.percent = (arg_475_1.time_ - var_478_7) / var_478_12

				arg_475_1.typewritter:SetDirty()
			end

			if arg_475_1.time_ >= var_478_7 + var_478_12 and arg_475_1.time_ < var_478_7 + var_478_12 + arg_478_0 then
				arg_475_1.typewritter.percent = 1

				arg_475_1.typewritter:SetDirty()
				arg_475_1:ShowNextGo(true)
			end
		end

		arg_475_1.nodeConfigList_ = {
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
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_475_1:InitPlayNodeList()
	end,
	Play1109703115 = function(arg_479_0, arg_479_1)
		arg_479_1.time_ = 0
		arg_479_1.frameCnt_ = 0
		arg_479_1.state_ = "playing"
		arg_479_1.curTalkId_ = 1109703115
		arg_479_1.duration_ = 5.63

		local var_479_0 = {
			zh = 1.533,
			ja = 5.633
		}
		local var_479_1 = manager.audio:GetLocalizationFlag()

		if var_479_0[var_479_1] ~= nil then
			arg_479_1.duration_ = var_479_0[var_479_1]
		end

		SetActive(arg_479_1.tipsGo_, false)

		function arg_479_1.onSingleLineFinish_()
			arg_479_1.onSingleLineUpdate_ = nil
			arg_479_1.onSingleLineFinish_ = nil
			arg_479_1.state_ = "waiting"
		end

		function arg_479_1.playNext_(arg_481_0)
			if arg_481_0 == 1 then
				arg_479_0:Play1109703116(arg_479_1)
			end
		end

		function arg_479_1.onSingleLineUpdate_(arg_482_0)
			if 0 < arg_479_1.time_ and arg_479_1.time_ <= 0 + arg_482_0 then
				arg_479_1.var_.moveOldPos1097ui_story = arg_479_1.actors_["1097ui_story"].transform.localPosition
			end

			local var_482_0 = 0.001

			if 0 <= arg_479_1.time_ and arg_479_1.time_ < 0 + var_482_0 then
				arg_479_1.actors_["1097ui_story"].transform.localPosition = Vector3.Lerp(arg_479_1.var_.moveOldPos1097ui_story, Vector3.New(0, -0.54, -6.3), (arg_479_1.time_ - 0) / var_482_0)
				arg_479_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_479_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_479_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_479_1.actors_["1097ui_story"].transform.position).z)
				arg_479_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_479_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_479_1.actors_["1097ui_story"].transform.localEulerAngles = arg_479_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			if arg_479_1.time_ >= 0 + var_482_0 and arg_479_1.time_ < 0 + var_482_0 + arg_482_0 then
				arg_479_1.actors_["1097ui_story"].transform.localPosition = Vector3.New(0, -0.54, -6.3)
				arg_479_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_479_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_479_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_479_1.actors_["1097ui_story"].transform.position).z)
				arg_479_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_479_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_479_1.actors_["1097ui_story"].transform.localEulerAngles = arg_479_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			local var_482_1 = arg_479_1.actors_["1097ui_story"]

			if 0 < arg_479_1.time_ and arg_479_1.time_ <= 0 + arg_482_0 and not isNil(var_482_1) and arg_479_1.var_.characterEffect1097ui_story == nil then
				arg_479_1.var_.characterEffect1097ui_story = var_482_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_482_2 = 0.200000002980232

			if 0 <= arg_479_1.time_ and arg_479_1.time_ < 0 + var_482_2 and not isNil(var_482_1) then
				if arg_479_1.var_.characterEffect1097ui_story and not isNil(var_482_1) then
					arg_479_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_479_1.time_ >= 0 + var_482_2 and arg_479_1.time_ < 0 + var_482_2 + arg_482_0 and not isNil(var_482_1) and arg_479_1.var_.characterEffect1097ui_story then
				arg_479_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_479_1.time_ and arg_479_1.time_ <= 0 + arg_482_0 then
				arg_479_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			if 0 < arg_479_1.time_ and arg_479_1.time_ <= 0 + arg_482_0 then
				arg_479_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_482_4 = 0
			local var_482_5 = 0.2

			if 0 < arg_479_1.time_ and arg_479_1.time_ <= var_482_4 + arg_482_0 then
				arg_479_1.talkMaxDuration = 0
				arg_479_1.dialogCg_.alpha = 1

				arg_479_1.dialog_:SetActive(true)
				SetActive(arg_479_1.leftNameGo_, true)

				arg_479_1.leftNameTxt_.text = arg_479_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_479_1.leftNameTxt_.transform)

				arg_479_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_479_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_479_1:RecordName(arg_479_1.leftNameTxt_.text)
				SetActive(arg_479_1.iconTrs_.gameObject, false)
				arg_479_1.callingController_:SetSelectedState("normal")

				local var_482_6 = arg_479_1:GetWordFromCfg(1109703115)
				local var_482_7 = arg_479_1:FormatText(var_482_6.content)

				arg_479_1.text_.text = var_482_7

				LuaForUtil.ClearLinePrefixSymbol(arg_479_1.text_)

				local var_482_9 = 8 <= 0 and var_482_5 or var_482_5 * (utf8.len(var_482_7) / 8)

				if (8 <= 0 and var_482_5 or var_482_5 * (utf8.len(var_482_7) / 8)) > 0 and var_482_5 < var_482_9 then
					arg_479_1.talkMaxDuration = var_482_9

					if var_482_9 + var_482_4 > arg_479_1.duration_ then
						arg_479_1.duration_ = var_482_9 + var_482_4
					end
				end

				arg_479_1.text_.text = var_482_7
				arg_479_1.typewritter.percent = 0

				arg_479_1.typewritter:SetDirty()
				arg_479_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703115", "story_v_side_new_1109703.awb") ~= 0 then
					local var_482_10 = manager.audio:GetVoiceLength("story_v_side_new_1109703", "1109703115", "story_v_side_new_1109703.awb") / 1000

					if var_482_10 + var_482_4 > arg_479_1.duration_ then
						arg_479_1.duration_ = var_482_10 + var_482_4
					end

					if var_482_6.prefab_name ~= "" and arg_479_1.actors_[var_482_6.prefab_name] ~= nil then
						local var_482_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_479_1.actors_[var_482_6.prefab_name].transform, "story_v_side_new_1109703", "1109703115", "story_v_side_new_1109703.awb")

						arg_479_1:RecordAudio("1109703115", var_482_11)
						arg_479_1:RecordAudio("1109703115", var_482_11)
					else
						arg_479_1:AudioAction("play", "voice", "story_v_side_new_1109703", "1109703115", "story_v_side_new_1109703.awb")
					end

					arg_479_1:RecordHistoryTalkVoice("story_v_side_new_1109703", "1109703115", "story_v_side_new_1109703.awb")
				end

				arg_479_1:RecordContent(arg_479_1.text_.text)
			end

			local var_482_12 = math.max(var_482_5, arg_479_1.talkMaxDuration)

			if var_482_4 <= arg_479_1.time_ and arg_479_1.time_ < var_482_4 + var_482_12 then
				arg_479_1.typewritter.percent = (arg_479_1.time_ - var_482_4) / var_482_12

				arg_479_1.typewritter:SetDirty()
			end

			if arg_479_1.time_ >= var_482_4 + var_482_12 and arg_479_1.time_ < var_482_4 + var_482_12 + arg_482_0 then
				arg_479_1.typewritter.percent = 1

				arg_479_1.typewritter:SetDirty()
				arg_479_1:ShowNextGo(true)
			end
		end

		arg_479_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_479_1:InitPlayNodeList()
	end,
	Play1109703116 = function(arg_483_0, arg_483_1)
		arg_483_1.time_ = 0
		arg_483_1.frameCnt_ = 0
		arg_483_1.state_ = "playing"
		arg_483_1.curTalkId_ = 1109703116
		arg_483_1.duration_ = 5

		SetActive(arg_483_1.tipsGo_, false)

		function arg_483_1.onSingleLineFinish_()
			arg_483_1.onSingleLineUpdate_ = nil
			arg_483_1.onSingleLineFinish_ = nil
			arg_483_1.state_ = "waiting"
			arg_483_1.auto_ = false
		end

		function arg_483_1.playNext_(arg_485_0)
			arg_483_1.onStoryFinished_()
		end

		function arg_483_1.onSingleLineUpdate_(arg_486_0)
			if 0 < arg_483_1.time_ and arg_483_1.time_ <= 0 + arg_486_0 and not isNil(arg_483_1.actors_["1097ui_story"]) and arg_483_1.var_.characterEffect1097ui_story == nil then
				arg_483_1.var_.characterEffect1097ui_story = arg_483_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_486_0 = 0.200000002980232

			if 0 <= arg_483_1.time_ and arg_483_1.time_ < 0 + var_486_0 and not isNil(arg_483_1.actors_["1097ui_story"]) then
				if arg_483_1.var_.characterEffect1097ui_story and not isNil(arg_483_1.actors_["1097ui_story"]) then
					arg_483_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_483_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_483_1.time_ - 0) / var_486_0)
				end
			end

			if arg_483_1.time_ >= 0 + var_486_0 and arg_483_1.time_ < 0 + var_486_0 + arg_486_0 and not isNil(arg_483_1.actors_["1097ui_story"]) and arg_483_1.var_.characterEffect1097ui_story then
				arg_483_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_483_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_486_1 = 0
			local var_486_2 = 0.05

			if 0 < arg_483_1.time_ and arg_483_1.time_ <= var_486_1 + arg_486_0 then
				arg_483_1.talkMaxDuration = 0
				arg_483_1.dialogCg_.alpha = 1

				arg_483_1.dialog_:SetActive(true)
				SetActive(arg_483_1.leftNameGo_, true)

				arg_483_1.leftNameTxt_.text = arg_483_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_483_1.leftNameTxt_.transform)

				arg_483_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_483_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_483_1:RecordName(arg_483_1.leftNameTxt_.text)
				SetActive(arg_483_1.iconTrs_.gameObject, true)
				arg_483_1.iconController_:SetSelectedState("hero")

				arg_483_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_483_1.callingController_:SetSelectedState("normal")

				arg_483_1.keyicon_.color = Color.New(1, 1, 1)
				arg_483_1.icon_.color = Color.New(1, 1, 1)

				local var_486_3 = arg_483_1:FormatText(arg_483_1:GetWordFromCfg(1109703116).content)

				arg_483_1.text_.text = var_486_3

				LuaForUtil.ClearLinePrefixSymbol(arg_483_1.text_)

				local var_486_5 = 2 <= 0 and var_486_2 or var_486_2 * (utf8.len(var_486_3) / 2)

				if (2 <= 0 and var_486_2 or var_486_2 * (utf8.len(var_486_3) / 2)) > 0 and var_486_2 < var_486_5 then
					arg_483_1.talkMaxDuration = var_486_5

					if var_486_5 + var_486_1 > arg_483_1.duration_ then
						arg_483_1.duration_ = var_486_5 + var_486_1
					end
				end

				arg_483_1.text_.text = var_486_3
				arg_483_1.typewritter.percent = 0

				arg_483_1.typewritter:SetDirty()
				arg_483_1:ShowNextGo(false)
				arg_483_1:RecordContent(arg_483_1.text_.text)
			end

			local var_486_6 = math.max(var_486_2, arg_483_1.talkMaxDuration)

			if var_486_1 <= arg_483_1.time_ and arg_483_1.time_ < var_486_1 + var_486_6 then
				arg_483_1.typewritter.percent = (arg_483_1.time_ - var_486_1) / var_486_6

				arg_483_1.typewritter:SetDirty()
			end

			if arg_483_1.time_ >= var_486_1 + var_486_6 and arg_483_1.time_ < var_486_1 + var_486_6 + arg_486_0 then
				arg_483_1.typewritter.percent = 1

				arg_483_1.typewritter:SetDirty()
				arg_483_1:ShowNextGo(true)
			end
		end

		arg_483_1.nodeConfigList_ = {}

		arg_483_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/B13",
		"TextureConfig/Background/ST12",
		"TextureConfig/Background/ST01"
	},
	voices = {
		"story_v_side_new_1109703.awb"
	}
}
