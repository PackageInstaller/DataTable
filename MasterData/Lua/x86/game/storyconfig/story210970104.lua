return {
	Play1109704001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 1109704001
		arg_1_1.duration_ = 5.23

		local var_1_0 = {
			zh = 3.766666666666,
			ja = 5.233
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
				arg_1_0:Play1109704002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.ST01 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST01")
				var_4_0.name = "ST01"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.ST01 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.ST01

				arg_1_1.bgs_.ST01.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "ST01" then
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

			local var_4_8 = "1097ui_story"

			if arg_1_1.actors_["1097ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1097ui_story"))) then
				local var_4_9 = Object.Instantiate(Asset.Load("Char/" .. "1097ui_story"), arg_1_1.stage_.transform)

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

			local var_4_12 = arg_1_1.actors_["1097ui_story"].transform

			if 1.76666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 1.76666666666667 + arg_4_0 then
				arg_1_1.var_.moveOldPos1097ui_story = var_4_12.localPosition
			end

			local var_4_13 = 0.001

			if 1.76666666666667 <= arg_1_1.time_ and arg_1_1.time_ < 1.76666666666667 + var_4_13 then
				var_4_12.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1097ui_story, Vector3.New(0, -0.54, -6.3), (arg_1_1.time_ - 1.76666666666667) / var_4_13)
				var_4_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_12.position).x, (manager.ui.mainCamera.transform.position - var_4_12.position).y, (manager.ui.mainCamera.transform.position - var_4_12.position).z)
				var_4_12.localEulerAngles.z = 0
				var_4_12.localEulerAngles.x = 0
				var_4_12.localEulerAngles = var_4_12.localEulerAngles
			end

			if arg_1_1.time_ >= 1.76666666666667 + var_4_13 and arg_1_1.time_ < 1.76666666666667 + var_4_13 + arg_4_0 then
				var_4_12.localPosition = Vector3.New(0, -0.54, -6.3)
				var_4_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_12.position).x, (manager.ui.mainCamera.transform.position - var_4_12.position).y, (manager.ui.mainCamera.transform.position - var_4_12.position).z)
				var_4_12.localEulerAngles.z = 0
				var_4_12.localEulerAngles.x = 0
				var_4_12.localEulerAngles = var_4_12.localEulerAngles
			end

			local var_4_14 = arg_1_1.actors_["1097ui_story"]

			if 1.76666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 1.76666666666667 + arg_4_0 and not isNil(var_4_14) and arg_1_1.var_.characterEffect1097ui_story == nil then
				arg_1_1.var_.characterEffect1097ui_story = var_4_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_15 = 0.200000002980232

			if 1.76666666666667 <= arg_1_1.time_ and arg_1_1.time_ < 1.76666666666667 + var_4_15 and not isNil(var_4_14) then
				if arg_1_1.var_.characterEffect1097ui_story and not isNil(var_4_14) then
					arg_1_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= 1.76666666666667 + var_4_15 and arg_1_1.time_ < 1.76666666666667 + var_4_15 + arg_4_0 and not isNil(var_4_14) and arg_1_1.var_.characterEffect1097ui_story then
				arg_1_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 1.76666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 1.76666666666667 + arg_4_0 then
				arg_1_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			if 1.76666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 1.76666666666667 + arg_4_0 then
				arg_1_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
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

			local var_4_23 = 2
			local var_4_24 = 0.2

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

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_26 = arg_1_1:GetWordFromCfg(1109704001)
				local var_4_27 = arg_1_1:FormatText(var_4_26.content)

				arg_1_1.text_.text = var_4_27

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_29 = 8 <= 0 and var_4_24 or var_4_24 * (utf8.len(var_4_27) / 8)

				if (8 <= 0 and var_4_24 or var_4_24 * (utf8.len(var_4_27) / 8)) > 0 and var_4_24 < var_4_29 then
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

				if manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704001", "story_v_side_new_1109704.awb") ~= 0 then
					local var_4_30 = manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704001", "story_v_side_new_1109704.awb") / 1000

					if var_4_30 + var_4_23 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_30 + var_4_23
					end

					if var_4_26.prefab_name ~= "" and arg_1_1.actors_[var_4_26.prefab_name] ~= nil then
						local var_4_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_26.prefab_name].transform, "story_v_side_new_1109704", "1109704001", "story_v_side_new_1109704.awb")

						arg_1_1:RecordAudio("1109704001", var_4_31)
						arg_1_1:RecordAudio("1109704001", var_4_31)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_side_new_1109704", "1109704001", "story_v_side_new_1109704.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_side_new_1109704", "1109704001", "story_v_side_new_1109704.awb")
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
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.76666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play1109704002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 1109704002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play1109704003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 and not isNil(arg_9_1.actors_["1097ui_story"]) and arg_9_1.var_.characterEffect1097ui_story == nil then
				arg_9_1.var_.characterEffect1097ui_story = arg_9_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_0 = 0.200000002980232

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_0 and not isNil(arg_9_1.actors_["1097ui_story"]) then
				if arg_9_1.var_.characterEffect1097ui_story and not isNil(arg_9_1.actors_["1097ui_story"]) then
					arg_9_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_9_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_9_1.time_ - 0) / var_12_0)
				end
			end

			if arg_9_1.time_ >= 0 + var_12_0 and arg_9_1.time_ < 0 + var_12_0 + arg_12_0 and not isNil(arg_9_1.actors_["1097ui_story"]) and arg_9_1.var_.characterEffect1097ui_story then
				arg_9_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_9_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_12_1 = 0
			local var_12_2 = 0.725

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

				local var_12_3 = arg_9_1:FormatText(arg_9_1:GetWordFromCfg(1109704002).content)

				arg_9_1.text_.text = var_12_3

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_5 = 29 <= 0 and var_12_2 or var_12_2 * (utf8.len(var_12_3) / 29)

				if (29 <= 0 and var_12_2 or var_12_2 * (utf8.len(var_12_3) / 29)) > 0 and var_12_2 < var_12_5 then
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
	Play1109704003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 1109704003
		arg_13_1.duration_ = 5.07

		local var_13_0 = {
			zh = 4.4,
			ja = 5.066
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
				arg_13_0:Play1109704004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.var_.moveOldPos1097ui_story = arg_13_1.actors_["1097ui_story"].transform.localPosition
			end

			local var_16_0 = 0.001

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_0 then
				arg_13_1.actors_["1097ui_story"].transform.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos1097ui_story, Vector3.New(-0.7, -0.54, -6.3), (arg_13_1.time_ - 0) / var_16_0)
				arg_13_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_13_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_13_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_13_1.actors_["1097ui_story"].transform.position).z)
				arg_13_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_13_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_13_1.actors_["1097ui_story"].transform.localEulerAngles = arg_13_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			if arg_13_1.time_ >= 0 + var_16_0 and arg_13_1.time_ < 0 + var_16_0 + arg_16_0 then
				arg_13_1.actors_["1097ui_story"].transform.localPosition = Vector3.New(-0.7, -0.54, -6.3)
				arg_13_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_13_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_13_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_13_1.actors_["1097ui_story"].transform.position).z)
				arg_13_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_13_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_13_1.actors_["1097ui_story"].transform.localEulerAngles = arg_13_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			local var_16_1 = arg_13_1.actors_["1097ui_story"]

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(var_16_1) and arg_13_1.var_.characterEffect1097ui_story == nil then
				arg_13_1.var_.characterEffect1097ui_story = var_16_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_2 = 0.200000002980232

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_2 and not isNil(var_16_1) then
				if arg_13_1.var_.characterEffect1097ui_story and not isNil(var_16_1) then
					arg_13_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_13_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_13_1.time_ - 0) / var_16_2)
				end
			end

			if arg_13_1.time_ >= 0 + var_16_2 and arg_13_1.time_ < 0 + var_16_2 + arg_16_0 and not isNil(var_16_1) and arg_13_1.var_.characterEffect1097ui_story then
				arg_13_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_13_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_16_3 = "1027ui_story"

			if arg_13_1.actors_["1027ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1027ui_story"))) then
				local var_16_4 = Object.Instantiate(Asset.Load("Char/" .. "1027ui_story"), arg_13_1.stage_.transform)

				var_16_4.name = var_16_3
				var_16_4.transform.localPosition = Vector3.New(0, 100, 0)
				arg_13_1.actors_[var_16_3] = var_16_4

				local var_16_5 = var_16_4:GetComponentInChildren(typeof(CharacterEffect))

				var_16_5.enabled = true

				local var_16_6 = GameObjectTools.GetOrAddComponent(var_16_4, typeof(DynamicBoneHelper))

				if var_16_6 then
					var_16_6:EnableDynamicBone(false)
				end

				arg_13_1:ShowWeapon(var_16_5.transform, false)

				arg_13_1.var_[var_16_3 .. "Animator"] = var_16_5.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_13_1.var_[var_16_3 .. "Animator"].applyRootMotion = true
				arg_13_1.var_[var_16_3 .. "LipSync"] = var_16_5.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_16_7 = arg_13_1.actors_["1027ui_story"].transform

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.var_.moveOldPos1027ui_story = var_16_7.localPosition
			end

			local var_16_8 = 0.001

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_8 then
				var_16_7.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos1027ui_story, Vector3.New(0.7, -0.81, -5.8), (arg_13_1.time_ - 0) / var_16_8)
				var_16_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_16_7.position).x, (manager.ui.mainCamera.transform.position - var_16_7.position).y, (manager.ui.mainCamera.transform.position - var_16_7.position).z)
				var_16_7.localEulerAngles.z = 0
				var_16_7.localEulerAngles.x = 0
				var_16_7.localEulerAngles = var_16_7.localEulerAngles
			end

			if arg_13_1.time_ >= 0 + var_16_8 and arg_13_1.time_ < 0 + var_16_8 + arg_16_0 then
				var_16_7.localPosition = Vector3.New(0.7, -0.81, -5.8)
				var_16_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_16_7.position).x, (manager.ui.mainCamera.transform.position - var_16_7.position).y, (manager.ui.mainCamera.transform.position - var_16_7.position).z)
				var_16_7.localEulerAngles.z = 0
				var_16_7.localEulerAngles.x = 0
				var_16_7.localEulerAngles = var_16_7.localEulerAngles
			end

			local var_16_9 = arg_13_1.actors_["1027ui_story"]

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(var_16_9) and arg_13_1.var_.characterEffect1027ui_story == nil then
				arg_13_1.var_.characterEffect1027ui_story = var_16_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_10 = 0.200000002980232

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_10 and not isNil(var_16_9) then
				if arg_13_1.var_.characterEffect1027ui_story and not isNil(var_16_9) then
					arg_13_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_13_1.time_ >= 0 + var_16_10 and arg_13_1.time_ < 0 + var_16_10 + arg_16_0 and not isNil(var_16_9) and arg_13_1.var_.characterEffect1027ui_story then
				arg_13_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action2_1")
			end

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_16_12 = 0
			local var_16_13 = 0.575

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_12 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_14 = arg_13_1:GetWordFromCfg(1109704003)
				local var_16_15 = arg_13_1:FormatText(var_16_14.content)

				arg_13_1.text_.text = var_16_15

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_17 = 23 <= 0 and var_16_13 or var_16_13 * (utf8.len(var_16_15) / 23)

				if (23 <= 0 and var_16_13 or var_16_13 * (utf8.len(var_16_15) / 23)) > 0 and var_16_13 < var_16_17 then
					arg_13_1.talkMaxDuration = var_16_17

					if var_16_17 + var_16_12 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_17 + var_16_12
					end
				end

				arg_13_1.text_.text = var_16_15
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704003", "story_v_side_new_1109704.awb") ~= 0 then
					local var_16_18 = manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704003", "story_v_side_new_1109704.awb") / 1000

					if var_16_18 + var_16_12 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_18 + var_16_12
					end

					if var_16_14.prefab_name ~= "" and arg_13_1.actors_[var_16_14.prefab_name] ~= nil then
						local var_16_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_14.prefab_name].transform, "story_v_side_new_1109704", "1109704003", "story_v_side_new_1109704.awb")

						arg_13_1:RecordAudio("1109704003", var_16_19)
						arg_13_1:RecordAudio("1109704003", var_16_19)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_side_new_1109704", "1109704003", "story_v_side_new_1109704.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_side_new_1109704", "1109704003", "story_v_side_new_1109704.awb")
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
				actorName = "1027ui_story",
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
	Play1109704004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 1109704004
		arg_17_1.duration_ = 2

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play1109704005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.var_.moveOldPos1097ui_story = arg_17_1.actors_["1097ui_story"].transform.localPosition
			end

			local var_20_0 = 0.001

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_0 then
				arg_17_1.actors_["1097ui_story"].transform.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1097ui_story, Vector3.New(-0.7, -0.54, -6.3), (arg_17_1.time_ - 0) / var_20_0)
				arg_17_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_17_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["1097ui_story"].transform.position).z)
				arg_17_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_17_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_17_1.actors_["1097ui_story"].transform.localEulerAngles = arg_17_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			if arg_17_1.time_ >= 0 + var_20_0 and arg_17_1.time_ < 0 + var_20_0 + arg_20_0 then
				arg_17_1.actors_["1097ui_story"].transform.localPosition = Vector3.New(-0.7, -0.54, -6.3)
				arg_17_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_17_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["1097ui_story"].transform.position).z)
				arg_17_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_17_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_17_1.actors_["1097ui_story"].transform.localEulerAngles = arg_17_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			local var_20_1 = arg_17_1.actors_["1097ui_story"]

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(var_20_1) and arg_17_1.var_.characterEffect1097ui_story == nil then
				arg_17_1.var_.characterEffect1097ui_story = var_20_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_2 = 0.200000002980232

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_2 and not isNil(var_20_1) then
				if arg_17_1.var_.characterEffect1097ui_story and not isNil(var_20_1) then
					arg_17_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_17_1.time_ >= 0 + var_20_2 and arg_17_1.time_ < 0 + var_20_2 + arg_20_0 and not isNil(var_20_1) and arg_17_1.var_.characterEffect1097ui_story then
				arg_17_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action3_1")
			end

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_20_4 = arg_17_1.actors_["1027ui_story"]

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(var_20_4) and arg_17_1.var_.characterEffect1027ui_story == nil then
				arg_17_1.var_.characterEffect1027ui_story = var_20_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_5 = 0.200000002980232

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_5 and not isNil(var_20_4) then
				if arg_17_1.var_.characterEffect1027ui_story and not isNil(var_20_4) then
					arg_17_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_17_1.var_.characterEffect1027ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_17_1.time_ - 0) / var_20_5)
				end
			end

			if arg_17_1.time_ >= 0 + var_20_5 and arg_17_1.time_ < 0 + var_20_5 + arg_20_0 and not isNil(var_20_4) and arg_17_1.var_.characterEffect1027ui_story then
				arg_17_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_17_1.var_.characterEffect1027ui_story.fillRatio = 0.5
			end

			local var_20_6 = 0
			local var_20_7 = 0.125

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_6 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_8 = arg_17_1:GetWordFromCfg(1109704004)
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

				if manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704004", "story_v_side_new_1109704.awb") ~= 0 then
					local var_20_12 = manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704004", "story_v_side_new_1109704.awb") / 1000

					if var_20_12 + var_20_6 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_12 + var_20_6
					end

					if var_20_8.prefab_name ~= "" and arg_17_1.actors_[var_20_8.prefab_name] ~= nil then
						local var_20_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_8.prefab_name].transform, "story_v_side_new_1109704", "1109704004", "story_v_side_new_1109704.awb")

						arg_17_1:RecordAudio("1109704004", var_20_13)
						arg_17_1:RecordAudio("1109704004", var_20_13)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_side_new_1109704", "1109704004", "story_v_side_new_1109704.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_side_new_1109704", "1109704004", "story_v_side_new_1109704.awb")
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
				actorName = "1097ui_story",
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
	Play1109704005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 1109704005
		arg_21_1.duration_ = 5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play1109704006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(arg_21_1.actors_["1097ui_story"]) and arg_21_1.var_.characterEffect1097ui_story == nil then
				arg_21_1.var_.characterEffect1097ui_story = arg_21_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_0 = 0.200000002980232

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_0 and not isNil(arg_21_1.actors_["1097ui_story"]) then
				if arg_21_1.var_.characterEffect1097ui_story and not isNil(arg_21_1.actors_["1097ui_story"]) then
					arg_21_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_21_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_21_1.time_ - 0) / var_24_0)
				end
			end

			if arg_21_1.time_ >= 0 + var_24_0 and arg_21_1.time_ < 0 + var_24_0 + arg_24_0 and not isNil(arg_21_1.actors_["1097ui_story"]) and arg_21_1.var_.characterEffect1097ui_story then
				arg_21_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_21_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_24_1 = arg_21_1.actors_["1097ui_story"].transform

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.var_.moveOldPos1097ui_story = var_24_1.localPosition
			end

			local var_24_2 = 0.001

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_2 then
				var_24_1.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos1097ui_story, Vector3.New(0, 100, 0), (arg_21_1.time_ - 0) / var_24_2)
				var_24_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_24_1.position).x, (manager.ui.mainCamera.transform.position - var_24_1.position).y, (manager.ui.mainCamera.transform.position - var_24_1.position).z)
				var_24_1.localEulerAngles.z = 0
				var_24_1.localEulerAngles.x = 0
				var_24_1.localEulerAngles = var_24_1.localEulerAngles
			end

			if arg_21_1.time_ >= 0 + var_24_2 and arg_21_1.time_ < 0 + var_24_2 + arg_24_0 then
				var_24_1.localPosition = Vector3.New(0, 100, 0)
				var_24_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_24_1.position).x, (manager.ui.mainCamera.transform.position - var_24_1.position).y, (manager.ui.mainCamera.transform.position - var_24_1.position).z)
				var_24_1.localEulerAngles.z = 0
				var_24_1.localEulerAngles.x = 0
				var_24_1.localEulerAngles = var_24_1.localEulerAngles
			end

			local var_24_3 = arg_21_1.actors_["1027ui_story"].transform

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.var_.moveOldPos1027ui_story = var_24_3.localPosition
			end

			local var_24_4 = 0.001

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_4 then
				var_24_3.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos1027ui_story, Vector3.New(0, 100, 0), (arg_21_1.time_ - 0) / var_24_4)
				var_24_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_24_3.position).x, (manager.ui.mainCamera.transform.position - var_24_3.position).y, (manager.ui.mainCamera.transform.position - var_24_3.position).z)
				var_24_3.localEulerAngles.z = 0
				var_24_3.localEulerAngles.x = 0
				var_24_3.localEulerAngles = var_24_3.localEulerAngles
			end

			if arg_21_1.time_ >= 0 + var_24_4 and arg_21_1.time_ < 0 + var_24_4 + arg_24_0 then
				var_24_3.localPosition = Vector3.New(0, 100, 0)
				var_24_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_24_3.position).x, (manager.ui.mainCamera.transform.position - var_24_3.position).y, (manager.ui.mainCamera.transform.position - var_24_3.position).z)
				var_24_3.localEulerAngles.z = 0
				var_24_3.localEulerAngles.x = 0
				var_24_3.localEulerAngles = var_24_3.localEulerAngles
			end

			local var_24_5 = manager.ui.mainCamera.transform

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.var_.shakeOldPos = var_24_5.localPosition
			end

			local var_24_6 = 0.6

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_6 then
				local var_24_7, var_24_8 = math.modf((arg_21_1.time_ - 0) / 0.066)

				var_24_5.localPosition = Vector3.New(var_24_8 * 0.13, var_24_8 * 0.13, var_24_8 * 0.13) + arg_21_1.var_.shakeOldPos
			end

			if arg_21_1.time_ >= 0 + var_24_6 and arg_21_1.time_ < 0 + var_24_6 + arg_24_0 then
				var_24_5.localPosition = arg_21_1.var_.shakeOldPos
			end

			local var_24_9 = 0

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_9 + arg_24_0 then
				arg_21_1.allBtn_.enabled = false
			end

			if arg_21_1.time_ >= var_24_9 + 0.6 and arg_21_1.time_ < var_24_9 + 0.6 + arg_24_0 then
				arg_21_1.allBtn_.enabled = true
			end

			local var_24_10 = 0
			local var_24_11 = 1.125

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_10 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, false)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_12 = arg_21_1:FormatText(arg_21_1:GetWordFromCfg(1109704005).content)

				arg_21_1.text_.text = var_24_12

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_14 = 45 <= 0 and var_24_11 or var_24_11 * (utf8.len(var_24_12) / 45)

				if (45 <= 0 and var_24_11 or var_24_11 * (utf8.len(var_24_12) / 45)) > 0 and var_24_11 < var_24_14 then
					arg_21_1.talkMaxDuration = var_24_14

					if var_24_14 + var_24_10 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_14 + var_24_10
					end
				end

				arg_21_1.text_.text = var_24_12
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)
				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_15 = math.max(var_24_11, arg_21_1.talkMaxDuration)

			if var_24_10 <= arg_21_1.time_ and arg_21_1.time_ < var_24_10 + var_24_15 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_10) / var_24_15

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_10 + var_24_15 and arg_21_1.time_ < var_24_10 + var_24_15 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1027ui_story",
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
	Play1109704006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 1109704006
		arg_25_1.duration_ = 5

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play1109704007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = 0.55

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
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

				local var_28_1 = arg_25_1:FormatText(arg_25_1:GetWordFromCfg(1109704006).content)

				arg_25_1.text_.text = var_28_1

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_3 = 22 <= 0 and var_28_0 or var_28_0 * (utf8.len(var_28_1) / 22)

				if (22 <= 0 and var_28_0 or var_28_0 * (utf8.len(var_28_1) / 22)) > 0 and var_28_0 < var_28_3 then
					arg_25_1.talkMaxDuration = var_28_3

					if var_28_3 + 0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_3 + 0
					end
				end

				arg_25_1.text_.text = var_28_1
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)
				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_4 = math.max(var_28_0, arg_25_1.talkMaxDuration)

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_4 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - 0) / var_28_4

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= 0 + var_28_4 and arg_25_1.time_ < 0 + var_28_4 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play1109704007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 1109704007
		arg_29_1.duration_ = 5

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play1109704008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = 1.125

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

				local var_32_1 = arg_29_1:FormatText(arg_29_1:GetWordFromCfg(1109704007).content)

				arg_29_1.text_.text = var_32_1

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_3 = 45 <= 0 and var_32_0 or var_32_0 * (utf8.len(var_32_1) / 45)

				if (45 <= 0 and var_32_0 or var_32_0 * (utf8.len(var_32_1) / 45)) > 0 and var_32_0 < var_32_3 then
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
	Play1109704008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 1109704008
		arg_33_1.duration_ = 2.93

		local var_33_0 = {
			zh = 2.933,
			ja = 2.333
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
				arg_33_0:Play1109704009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1.var_.moveOldPos1027ui_story = arg_33_1.actors_["1027ui_story"].transform.localPosition
			end

			local var_36_0 = 0.001

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_0 then
				arg_33_1.actors_["1027ui_story"].transform.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos1027ui_story, Vector3.New(0.7, -0.81, -5.8), (arg_33_1.time_ - 0) / var_36_0)
				arg_33_1.actors_["1027ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_33_1.actors_["1027ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["1027ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["1027ui_story"].transform.position).z)
				arg_33_1.actors_["1027ui_story"].transform.localEulerAngles.z = 0
				arg_33_1.actors_["1027ui_story"].transform.localEulerAngles.x = 0
				arg_33_1.actors_["1027ui_story"].transform.localEulerAngles = arg_33_1.actors_["1027ui_story"].transform.localEulerAngles
			end

			if arg_33_1.time_ >= 0 + var_36_0 and arg_33_1.time_ < 0 + var_36_0 + arg_36_0 then
				arg_33_1.actors_["1027ui_story"].transform.localPosition = Vector3.New(0.7, -0.81, -5.8)
				arg_33_1.actors_["1027ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_33_1.actors_["1027ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["1027ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["1027ui_story"].transform.position).z)
				arg_33_1.actors_["1027ui_story"].transform.localEulerAngles.z = 0
				arg_33_1.actors_["1027ui_story"].transform.localEulerAngles.x = 0
				arg_33_1.actors_["1027ui_story"].transform.localEulerAngles = arg_33_1.actors_["1027ui_story"].transform.localEulerAngles
			end

			local var_36_1 = arg_33_1.actors_["1027ui_story"]

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(var_36_1) and arg_33_1.var_.characterEffect1027ui_story == nil then
				arg_33_1.var_.characterEffect1027ui_story = var_36_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_2 = 0.200000002980232

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_2 and not isNil(var_36_1) then
				if arg_33_1.var_.characterEffect1027ui_story and not isNil(var_36_1) then
					arg_33_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_33_1.time_ >= 0 + var_36_2 and arg_33_1.time_ < 0 + var_36_2 + arg_36_0 and not isNil(var_36_1) and arg_33_1.var_.characterEffect1027ui_story then
				arg_33_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action6_1")
			end

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_36_4 = 0
			local var_36_5 = 0.175

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_4 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				arg_33_1.leftNameTxt_.text = arg_33_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_6 = arg_33_1:GetWordFromCfg(1109704008)
				local var_36_7 = arg_33_1:FormatText(var_36_6.content)

				arg_33_1.text_.text = var_36_7

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_9 = 7 <= 0 and var_36_5 or var_36_5 * (utf8.len(var_36_7) / 7)

				if (7 <= 0 and var_36_5 or var_36_5 * (utf8.len(var_36_7) / 7)) > 0 and var_36_5 < var_36_9 then
					arg_33_1.talkMaxDuration = var_36_9

					if var_36_9 + var_36_4 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_9 + var_36_4
					end
				end

				arg_33_1.text_.text = var_36_7
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704008", "story_v_side_new_1109704.awb") ~= 0 then
					local var_36_10 = manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704008", "story_v_side_new_1109704.awb") / 1000

					if var_36_10 + var_36_4 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_10 + var_36_4
					end

					if var_36_6.prefab_name ~= "" and arg_33_1.actors_[var_36_6.prefab_name] ~= nil then
						local var_36_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_6.prefab_name].transform, "story_v_side_new_1109704", "1109704008", "story_v_side_new_1109704.awb")

						arg_33_1:RecordAudio("1109704008", var_36_11)
						arg_33_1:RecordAudio("1109704008", var_36_11)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_side_new_1109704", "1109704008", "story_v_side_new_1109704.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_side_new_1109704", "1109704008", "story_v_side_new_1109704.awb")
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

		arg_33_1.nodeConfigList_ = {
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

		arg_33_1:InitPlayNodeList()
	end,
	Play1109704009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 1109704009
		arg_37_1.duration_ = 6.3

		local var_37_0 = {
			zh = 5.233,
			ja = 6.3
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
				arg_37_0:Play1109704010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1.var_.moveOldPos1097ui_story = arg_37_1.actors_["1097ui_story"].transform.localPosition
			end

			local var_40_0 = 0.001

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_0 then
				arg_37_1.actors_["1097ui_story"].transform.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos1097ui_story, Vector3.New(-0.7, -0.54, -6.3), (arg_37_1.time_ - 0) / var_40_0)
				arg_37_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_37_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_37_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_37_1.actors_["1097ui_story"].transform.position).z)
				arg_37_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_37_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_37_1.actors_["1097ui_story"].transform.localEulerAngles = arg_37_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			if arg_37_1.time_ >= 0 + var_40_0 and arg_37_1.time_ < 0 + var_40_0 + arg_40_0 then
				arg_37_1.actors_["1097ui_story"].transform.localPosition = Vector3.New(-0.7, -0.54, -6.3)
				arg_37_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_37_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_37_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_37_1.actors_["1097ui_story"].transform.position).z)
				arg_37_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_37_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_37_1.actors_["1097ui_story"].transform.localEulerAngles = arg_37_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			local var_40_1 = arg_37_1.actors_["1097ui_story"]

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(var_40_1) and arg_37_1.var_.characterEffect1097ui_story == nil then
				arg_37_1.var_.characterEffect1097ui_story = var_40_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_2 = 0.200000002980232

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_2 and not isNil(var_40_1) then
				if arg_37_1.var_.characterEffect1097ui_story and not isNil(var_40_1) then
					arg_37_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_37_1.time_ >= 0 + var_40_2 and arg_37_1.time_ < 0 + var_40_2 + arg_40_0 and not isNil(var_40_1) and arg_37_1.var_.characterEffect1097ui_story then
				arg_37_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action6_1")
			end

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_40_4 = arg_37_1.actors_["1027ui_story"]

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(var_40_4) and arg_37_1.var_.characterEffect1027ui_story == nil then
				arg_37_1.var_.characterEffect1027ui_story = var_40_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_5 = 0.200000002980232

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_5 and not isNil(var_40_4) then
				if arg_37_1.var_.characterEffect1027ui_story and not isNil(var_40_4) then
					arg_37_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_37_1.var_.characterEffect1027ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_37_1.time_ - 0) / var_40_5)
				end
			end

			if arg_37_1.time_ >= 0 + var_40_5 and arg_37_1.time_ < 0 + var_40_5 + arg_40_0 and not isNil(var_40_4) and arg_37_1.var_.characterEffect1027ui_story then
				arg_37_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_37_1.var_.characterEffect1027ui_story.fillRatio = 0.5
			end

			local var_40_6 = 0
			local var_40_7 = 0.725

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_6 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				arg_37_1.leftNameTxt_.text = arg_37_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_8 = arg_37_1:GetWordFromCfg(1109704009)
				local var_40_9 = arg_37_1:FormatText(var_40_8.content)

				arg_37_1.text_.text = var_40_9

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_11 = 29 <= 0 and var_40_7 or var_40_7 * (utf8.len(var_40_9) / 29)

				if (29 <= 0 and var_40_7 or var_40_7 * (utf8.len(var_40_9) / 29)) > 0 and var_40_7 < var_40_11 then
					arg_37_1.talkMaxDuration = var_40_11

					if var_40_11 + var_40_6 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_11 + var_40_6
					end
				end

				arg_37_1.text_.text = var_40_9
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704009", "story_v_side_new_1109704.awb") ~= 0 then
					local var_40_12 = manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704009", "story_v_side_new_1109704.awb") / 1000

					if var_40_12 + var_40_6 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_12 + var_40_6
					end

					if var_40_8.prefab_name ~= "" and arg_37_1.actors_[var_40_8.prefab_name] ~= nil then
						local var_40_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_8.prefab_name].transform, "story_v_side_new_1109704", "1109704009", "story_v_side_new_1109704.awb")

						arg_37_1:RecordAudio("1109704009", var_40_13)
						arg_37_1:RecordAudio("1109704009", var_40_13)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_side_new_1109704", "1109704009", "story_v_side_new_1109704.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_side_new_1109704", "1109704009", "story_v_side_new_1109704.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_14 = math.max(var_40_7, arg_37_1.talkMaxDuration)

			if var_40_6 <= arg_37_1.time_ and arg_37_1.time_ < var_40_6 + var_40_14 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_6) / var_40_14

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_6 + var_40_14 and arg_37_1.time_ < var_40_6 + var_40_14 + arg_40_0 then
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
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_37_1:InitPlayNodeList()
	end,
	Play1109704010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 1109704010
		arg_41_1.duration_ = 5

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play1109704011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(arg_41_1.actors_["1097ui_story"]) and arg_41_1.var_.characterEffect1097ui_story == nil then
				arg_41_1.var_.characterEffect1097ui_story = arg_41_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_0 = 0.200000002980232

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_0 and not isNil(arg_41_1.actors_["1097ui_story"]) then
				if arg_41_1.var_.characterEffect1097ui_story and not isNil(arg_41_1.actors_["1097ui_story"]) then
					arg_41_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_41_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_41_1.time_ - 0) / var_44_0)
				end
			end

			if arg_41_1.time_ >= 0 + var_44_0 and arg_41_1.time_ < 0 + var_44_0 + arg_44_0 and not isNil(arg_41_1.actors_["1097ui_story"]) and arg_41_1.var_.characterEffect1097ui_story then
				arg_41_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_41_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_44_1 = 0
			local var_44_2 = 1.075

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

				local var_44_3 = arg_41_1:FormatText(arg_41_1:GetWordFromCfg(1109704010).content)

				arg_41_1.text_.text = var_44_3

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_5 = 43 <= 0 and var_44_2 or var_44_2 * (utf8.len(var_44_3) / 43)

				if (43 <= 0 and var_44_2 or var_44_2 * (utf8.len(var_44_3) / 43)) > 0 and var_44_2 < var_44_5 then
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
	Play1109704011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 1109704011
		arg_45_1.duration_ = 2

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play1109704012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1.var_.moveOldPos1097ui_story = arg_45_1.actors_["1097ui_story"].transform.localPosition
			end

			local var_48_0 = 0.001

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_0 then
				arg_45_1.actors_["1097ui_story"].transform.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos1097ui_story, Vector3.New(-0.7, -0.54, -6.3), (arg_45_1.time_ - 0) / var_48_0)
				arg_45_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_45_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_45_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_45_1.actors_["1097ui_story"].transform.position).z)
				arg_45_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_45_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_45_1.actors_["1097ui_story"].transform.localEulerAngles = arg_45_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			if arg_45_1.time_ >= 0 + var_48_0 and arg_45_1.time_ < 0 + var_48_0 + arg_48_0 then
				arg_45_1.actors_["1097ui_story"].transform.localPosition = Vector3.New(-0.7, -0.54, -6.3)
				arg_45_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_45_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_45_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_45_1.actors_["1097ui_story"].transform.position).z)
				arg_45_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_45_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_45_1.actors_["1097ui_story"].transform.localEulerAngles = arg_45_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			local var_48_1 = arg_45_1.actors_["1097ui_story"]

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 and not isNil(var_48_1) and arg_45_1.var_.characterEffect1097ui_story == nil then
				arg_45_1.var_.characterEffect1097ui_story = var_48_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_2 = 0.200000002980232

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_2 and not isNil(var_48_1) then
				if arg_45_1.var_.characterEffect1097ui_story and not isNil(var_48_1) then
					arg_45_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_45_1.time_ >= 0 + var_48_2 and arg_45_1.time_ < 0 + var_48_2 + arg_48_0 and not isNil(var_48_1) and arg_45_1.var_.characterEffect1097ui_story then
				arg_45_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_48_4 = arg_45_1.actors_["1027ui_story"].transform

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1.var_.moveOldPos1027ui_story = var_48_4.localPosition
			end

			local var_48_5 = 0.001

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_5 then
				var_48_4.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos1027ui_story, Vector3.New(0.7, -0.81, -5.8), (arg_45_1.time_ - 0) / var_48_5)
				var_48_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_48_4.position).x, (manager.ui.mainCamera.transform.position - var_48_4.position).y, (manager.ui.mainCamera.transform.position - var_48_4.position).z)
				var_48_4.localEulerAngles.z = 0
				var_48_4.localEulerAngles.x = 0
				var_48_4.localEulerAngles = var_48_4.localEulerAngles
			end

			if arg_45_1.time_ >= 0 + var_48_5 and arg_45_1.time_ < 0 + var_48_5 + arg_48_0 then
				var_48_4.localPosition = Vector3.New(0.7, -0.81, -5.8)
				var_48_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_48_4.position).x, (manager.ui.mainCamera.transform.position - var_48_4.position).y, (manager.ui.mainCamera.transform.position - var_48_4.position).z)
				var_48_4.localEulerAngles.z = 0
				var_48_4.localEulerAngles.x = 0
				var_48_4.localEulerAngles = var_48_4.localEulerAngles
			end

			local var_48_6 = arg_45_1.actors_["1027ui_story"]

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 and not isNil(var_48_6) and arg_45_1.var_.characterEffect1027ui_story == nil then
				arg_45_1.var_.characterEffect1027ui_story = var_48_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_7 = 0.200000002980232

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_7 and not isNil(var_48_6) then
				if arg_45_1.var_.characterEffect1027ui_story and not isNil(var_48_6) then
					arg_45_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_45_1.time_ >= 0 + var_48_7 and arg_45_1.time_ < 0 + var_48_7 + arg_48_0 and not isNil(var_48_6) and arg_45_1.var_.characterEffect1027ui_story then
				arg_45_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action6_2")
			end

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_48_9 = 0
			local var_48_10 = 0.05

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_9 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				arg_45_1.leftNameTxt_.text = arg_45_1:FormatText(StoryNameCfg[951].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_11 = arg_45_1:GetWordFromCfg(1109704011)
				local var_48_12 = arg_45_1:FormatText(var_48_11.content)

				arg_45_1.text_.text = var_48_12

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_14 = 2 <= 0 and var_48_10 or var_48_10 * (utf8.len(var_48_12) / 2)

				if (2 <= 0 and var_48_10 or var_48_10 * (utf8.len(var_48_12) / 2)) > 0 and var_48_10 < var_48_14 then
					arg_45_1.talkMaxDuration = var_48_14

					if var_48_14 + var_48_9 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_14 + var_48_9
					end
				end

				arg_45_1.text_.text = var_48_12
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704011", "story_v_side_new_1109704.awb") ~= 0 then
					local var_48_15 = manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704011", "story_v_side_new_1109704.awb") / 1000

					if var_48_15 + var_48_9 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_15 + var_48_9
					end

					if var_48_11.prefab_name ~= "" and arg_45_1.actors_[var_48_11.prefab_name] ~= nil then
						local var_48_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_11.prefab_name].transform, "story_v_side_new_1109704", "1109704011", "story_v_side_new_1109704.awb")

						arg_45_1:RecordAudio("1109704011", var_48_16)
						arg_45_1:RecordAudio("1109704011", var_48_16)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_side_new_1109704", "1109704011", "story_v_side_new_1109704.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_side_new_1109704", "1109704011", "story_v_side_new_1109704.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_17 = math.max(var_48_10, arg_45_1.talkMaxDuration)

			if var_48_9 <= arg_45_1.time_ and arg_45_1.time_ < var_48_9 + var_48_17 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_9) / var_48_17

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_9 + var_48_17 and arg_45_1.time_ < var_48_9 + var_48_17 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {
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
				actorName = "1027ui_story",
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
	Play1109704012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 1109704012
		arg_49_1.duration_ = 5

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play1109704013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 and not isNil(arg_49_1.actors_["1027ui_story"]) and arg_49_1.var_.characterEffect1027ui_story == nil then
				arg_49_1.var_.characterEffect1027ui_story = arg_49_1.actors_["1027ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_0 = 0.200000002980232

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_0 and not isNil(arg_49_1.actors_["1027ui_story"]) then
				if arg_49_1.var_.characterEffect1027ui_story and not isNil(arg_49_1.actors_["1027ui_story"]) then
					arg_49_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_49_1.var_.characterEffect1027ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_49_1.time_ - 0) / var_52_0)
				end
			end

			if arg_49_1.time_ >= 0 + var_52_0 and arg_49_1.time_ < 0 + var_52_0 + arg_52_0 and not isNil(arg_49_1.actors_["1027ui_story"]) and arg_49_1.var_.characterEffect1027ui_story then
				arg_49_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_49_1.var_.characterEffect1027ui_story.fillRatio = 0.5
			end

			local var_52_1 = arg_49_1.actors_["1097ui_story"]

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 and not isNil(var_52_1) and arg_49_1.var_.characterEffect1097ui_story == nil then
				arg_49_1.var_.characterEffect1097ui_story = var_52_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_2 = 0.200000002980232

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_2 and not isNil(var_52_1) then
				if arg_49_1.var_.characterEffect1097ui_story and not isNil(var_52_1) then
					arg_49_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_49_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_49_1.time_ - 0) / var_52_2)
				end
			end

			if arg_49_1.time_ >= 0 + var_52_2 and arg_49_1.time_ < 0 + var_52_2 + arg_52_0 and not isNil(var_52_1) and arg_49_1.var_.characterEffect1097ui_story then
				arg_49_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_49_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_52_3 = 0
			local var_52_4 = 1.225

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_3 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, false)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_5 = arg_49_1:FormatText(arg_49_1:GetWordFromCfg(1109704012).content)

				arg_49_1.text_.text = var_52_5

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_7 = 49 <= 0 and var_52_4 or var_52_4 * (utf8.len(var_52_5) / 49)

				if (49 <= 0 and var_52_4 or var_52_4 * (utf8.len(var_52_5) / 49)) > 0 and var_52_4 < var_52_7 then
					arg_49_1.talkMaxDuration = var_52_7

					if var_52_7 + var_52_3 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_7 + var_52_3
					end
				end

				arg_49_1.text_.text = var_52_5
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)
				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_8 = math.max(var_52_4, arg_49_1.talkMaxDuration)

			if var_52_3 <= arg_49_1.time_ and arg_49_1.time_ < var_52_3 + var_52_8 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_3) / var_52_8

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_3 + var_52_8 and arg_49_1.time_ < var_52_3 + var_52_8 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play1109704013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 1109704013
		arg_53_1.duration_ = 5

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play1109704014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = 0.425

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				arg_53_1.leftNameTxt_.text = arg_53_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, true)
				arg_53_1.iconController_:SetSelectedState("hero")

				arg_53_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_53_1.callingController_:SetSelectedState("normal")

				arg_53_1.keyicon_.color = Color.New(1, 1, 1)
				arg_53_1.icon_.color = Color.New(1, 1, 1)

				local var_56_1 = arg_53_1:FormatText(arg_53_1:GetWordFromCfg(1109704013).content)

				arg_53_1.text_.text = var_56_1

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_3 = 17 <= 0 and var_56_0 or var_56_0 * (utf8.len(var_56_1) / 17)

				if (17 <= 0 and var_56_0 or var_56_0 * (utf8.len(var_56_1) / 17)) > 0 and var_56_0 < var_56_3 then
					arg_53_1.talkMaxDuration = var_56_3

					if var_56_3 + 0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_3 + 0
					end
				end

				arg_53_1.text_.text = var_56_1
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)
				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_4 = math.max(var_56_0, arg_53_1.talkMaxDuration)

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_4 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - 0) / var_56_4

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= 0 + var_56_4 and arg_53_1.time_ < 0 + var_56_4 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play1109704014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 1109704014
		arg_57_1.duration_ = 8.9

		local var_57_0 = {
			zh = 6.366,
			ja = 8.9
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
				arg_57_0:Play1109704015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1.var_.moveOldPos1097ui_story = arg_57_1.actors_["1097ui_story"].transform.localPosition
			end

			local var_60_0 = 0.001

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_0 then
				arg_57_1.actors_["1097ui_story"].transform.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos1097ui_story, Vector3.New(-0.7, -0.54, -6.3), (arg_57_1.time_ - 0) / var_60_0)
				arg_57_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_57_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["1097ui_story"].transform.position).z)
				arg_57_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_57_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_57_1.actors_["1097ui_story"].transform.localEulerAngles = arg_57_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			if arg_57_1.time_ >= 0 + var_60_0 and arg_57_1.time_ < 0 + var_60_0 + arg_60_0 then
				arg_57_1.actors_["1097ui_story"].transform.localPosition = Vector3.New(-0.7, -0.54, -6.3)
				arg_57_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_57_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["1097ui_story"].transform.position).z)
				arg_57_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_57_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_57_1.actors_["1097ui_story"].transform.localEulerAngles = arg_57_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			local var_60_1 = arg_57_1.actors_["1097ui_story"]

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 and not isNil(var_60_1) and arg_57_1.var_.characterEffect1097ui_story == nil then
				arg_57_1.var_.characterEffect1097ui_story = var_60_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_2 = 0.200000002980232

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_2 and not isNil(var_60_1) then
				if arg_57_1.var_.characterEffect1097ui_story and not isNil(var_60_1) then
					arg_57_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_57_1.time_ >= 0 + var_60_2 and arg_57_1.time_ < 0 + var_60_2 + arg_60_0 and not isNil(var_60_1) and arg_57_1.var_.characterEffect1097ui_story then
				arg_57_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action6_2")
			end

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_60_4 = 0
			local var_60_5 = 0.625

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_4 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				arg_57_1.leftNameTxt_.text = arg_57_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_6 = arg_57_1:GetWordFromCfg(1109704014)
				local var_60_7 = arg_57_1:FormatText(var_60_6.content)

				arg_57_1.text_.text = var_60_7

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_9 = 25 <= 0 and var_60_5 or var_60_5 * (utf8.len(var_60_7) / 25)

				if (25 <= 0 and var_60_5 or var_60_5 * (utf8.len(var_60_7) / 25)) > 0 and var_60_5 < var_60_9 then
					arg_57_1.talkMaxDuration = var_60_9

					if var_60_9 + var_60_4 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_9 + var_60_4
					end
				end

				arg_57_1.text_.text = var_60_7
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704014", "story_v_side_new_1109704.awb") ~= 0 then
					local var_60_10 = manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704014", "story_v_side_new_1109704.awb") / 1000

					if var_60_10 + var_60_4 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_10 + var_60_4
					end

					if var_60_6.prefab_name ~= "" and arg_57_1.actors_[var_60_6.prefab_name] ~= nil then
						local var_60_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_6.prefab_name].transform, "story_v_side_new_1109704", "1109704014", "story_v_side_new_1109704.awb")

						arg_57_1:RecordAudio("1109704014", var_60_11)
						arg_57_1:RecordAudio("1109704014", var_60_11)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_side_new_1109704", "1109704014", "story_v_side_new_1109704.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_side_new_1109704", "1109704014", "story_v_side_new_1109704.awb")
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
				actorName = "1097ui_story",
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
	Play1109704015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 1109704015
		arg_61_1.duration_ = 3.4

		local var_61_0 = {
			zh = 3.033,
			ja = 3.4
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
				arg_61_0:Play1109704016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1.var_.moveOldPos1027ui_story = arg_61_1.actors_["1027ui_story"].transform.localPosition
			end

			local var_64_0 = 0.001

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_0 then
				arg_61_1.actors_["1027ui_story"].transform.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos1027ui_story, Vector3.New(0.7, -0.81, -5.8), (arg_61_1.time_ - 0) / var_64_0)
				arg_61_1.actors_["1027ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_61_1.actors_["1027ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["1027ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["1027ui_story"].transform.position).z)
				arg_61_1.actors_["1027ui_story"].transform.localEulerAngles.z = 0
				arg_61_1.actors_["1027ui_story"].transform.localEulerAngles.x = 0
				arg_61_1.actors_["1027ui_story"].transform.localEulerAngles = arg_61_1.actors_["1027ui_story"].transform.localEulerAngles
			end

			if arg_61_1.time_ >= 0 + var_64_0 and arg_61_1.time_ < 0 + var_64_0 + arg_64_0 then
				arg_61_1.actors_["1027ui_story"].transform.localPosition = Vector3.New(0.7, -0.81, -5.8)
				arg_61_1.actors_["1027ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_61_1.actors_["1027ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["1027ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["1027ui_story"].transform.position).z)
				arg_61_1.actors_["1027ui_story"].transform.localEulerAngles.z = 0
				arg_61_1.actors_["1027ui_story"].transform.localEulerAngles.x = 0
				arg_61_1.actors_["1027ui_story"].transform.localEulerAngles = arg_61_1.actors_["1027ui_story"].transform.localEulerAngles
			end

			local var_64_1 = arg_61_1.actors_["1027ui_story"]

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 and not isNil(var_64_1) and arg_61_1.var_.characterEffect1027ui_story == nil then
				arg_61_1.var_.characterEffect1027ui_story = var_64_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_2 = 0.200000002980232

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_2 and not isNil(var_64_1) then
				if arg_61_1.var_.characterEffect1027ui_story and not isNil(var_64_1) then
					arg_61_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_61_1.time_ >= 0 + var_64_2 and arg_61_1.time_ < 0 + var_64_2 + arg_64_0 and not isNil(var_64_1) and arg_61_1.var_.characterEffect1027ui_story then
				arg_61_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action1_1")
			end

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_64_4 = arg_61_1.actors_["1097ui_story"]

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 and not isNil(var_64_4) and arg_61_1.var_.characterEffect1097ui_story == nil then
				arg_61_1.var_.characterEffect1097ui_story = var_64_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_5 = 0.200000002980232

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_5 and not isNil(var_64_4) then
				if arg_61_1.var_.characterEffect1097ui_story and not isNil(var_64_4) then
					arg_61_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_61_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_61_1.time_ - 0) / var_64_5)
				end
			end

			if arg_61_1.time_ >= 0 + var_64_5 and arg_61_1.time_ < 0 + var_64_5 + arg_64_0 and not isNil(var_64_4) and arg_61_1.var_.characterEffect1097ui_story then
				arg_61_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_61_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_64_6 = 0
			local var_64_7 = 0.3

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_6 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				arg_61_1.leftNameTxt_.text = arg_61_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_8 = arg_61_1:GetWordFromCfg(1109704015)
				local var_64_9 = arg_61_1:FormatText(var_64_8.content)

				arg_61_1.text_.text = var_64_9

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_11 = 12 <= 0 and var_64_7 or var_64_7 * (utf8.len(var_64_9) / 12)

				if (12 <= 0 and var_64_7 or var_64_7 * (utf8.len(var_64_9) / 12)) > 0 and var_64_7 < var_64_11 then
					arg_61_1.talkMaxDuration = var_64_11

					if var_64_11 + var_64_6 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_11 + var_64_6
					end
				end

				arg_61_1.text_.text = var_64_9
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704015", "story_v_side_new_1109704.awb") ~= 0 then
					local var_64_12 = manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704015", "story_v_side_new_1109704.awb") / 1000

					if var_64_12 + var_64_6 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_12 + var_64_6
					end

					if var_64_8.prefab_name ~= "" and arg_61_1.actors_[var_64_8.prefab_name] ~= nil then
						local var_64_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_8.prefab_name].transform, "story_v_side_new_1109704", "1109704015", "story_v_side_new_1109704.awb")

						arg_61_1:RecordAudio("1109704015", var_64_13)
						arg_61_1:RecordAudio("1109704015", var_64_13)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_side_new_1109704", "1109704015", "story_v_side_new_1109704.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_side_new_1109704", "1109704015", "story_v_side_new_1109704.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_14 = math.max(var_64_7, arg_61_1.talkMaxDuration)

			if var_64_6 <= arg_61_1.time_ and arg_61_1.time_ < var_64_6 + var_64_14 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_6) / var_64_14

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_6 + var_64_14 and arg_61_1.time_ < var_64_6 + var_64_14 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {
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

		arg_61_1:InitPlayNodeList()
	end,
	Play1109704016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 1109704016
		arg_65_1.duration_ = 5

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play1109704017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(arg_65_1.actors_["1027ui_story"]) and arg_65_1.var_.characterEffect1027ui_story == nil then
				arg_65_1.var_.characterEffect1027ui_story = arg_65_1.actors_["1027ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_0 = 0.200000002980232

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_0 and not isNil(arg_65_1.actors_["1027ui_story"]) then
				if arg_65_1.var_.characterEffect1027ui_story and not isNil(arg_65_1.actors_["1027ui_story"]) then
					arg_65_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_65_1.var_.characterEffect1027ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_65_1.time_ - 0) / var_68_0)
				end
			end

			if arg_65_1.time_ >= 0 + var_68_0 and arg_65_1.time_ < 0 + var_68_0 + arg_68_0 and not isNil(arg_65_1.actors_["1027ui_story"]) and arg_65_1.var_.characterEffect1027ui_story then
				arg_65_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_65_1.var_.characterEffect1027ui_story.fillRatio = 0.5
			end

			local var_68_1 = 0
			local var_68_2 = 1.275

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_1 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				arg_65_1.leftNameTxt_.text = arg_65_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, true)
				arg_65_1.iconController_:SetSelectedState("hero")

				arg_65_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_65_1.callingController_:SetSelectedState("normal")

				arg_65_1.keyicon_.color = Color.New(1, 1, 1)
				arg_65_1.icon_.color = Color.New(1, 1, 1)

				local var_68_3 = arg_65_1:FormatText(arg_65_1:GetWordFromCfg(1109704016).content)

				arg_65_1.text_.text = var_68_3

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_5 = 51 <= 0 and var_68_2 or var_68_2 * (utf8.len(var_68_3) / 51)

				if (51 <= 0 and var_68_2 or var_68_2 * (utf8.len(var_68_3) / 51)) > 0 and var_68_2 < var_68_5 then
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
	Play1109704017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 1109704017
		arg_69_1.duration_ = 9.4

		local var_69_0 = {
			zh = 2.733,
			ja = 9.4
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
				arg_69_0:Play1109704018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1.var_.moveOldPos1027ui_story = arg_69_1.actors_["1027ui_story"].transform.localPosition
			end

			local var_72_0 = 0.001

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_0 then
				arg_69_1.actors_["1027ui_story"].transform.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos1027ui_story, Vector3.New(0.7, -0.81, -5.8), (arg_69_1.time_ - 0) / var_72_0)
				arg_69_1.actors_["1027ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_69_1.actors_["1027ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_69_1.actors_["1027ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_69_1.actors_["1027ui_story"].transform.position).z)
				arg_69_1.actors_["1027ui_story"].transform.localEulerAngles.z = 0
				arg_69_1.actors_["1027ui_story"].transform.localEulerAngles.x = 0
				arg_69_1.actors_["1027ui_story"].transform.localEulerAngles = arg_69_1.actors_["1027ui_story"].transform.localEulerAngles
			end

			if arg_69_1.time_ >= 0 + var_72_0 and arg_69_1.time_ < 0 + var_72_0 + arg_72_0 then
				arg_69_1.actors_["1027ui_story"].transform.localPosition = Vector3.New(0.7, -0.81, -5.8)
				arg_69_1.actors_["1027ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_69_1.actors_["1027ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_69_1.actors_["1027ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_69_1.actors_["1027ui_story"].transform.position).z)
				arg_69_1.actors_["1027ui_story"].transform.localEulerAngles.z = 0
				arg_69_1.actors_["1027ui_story"].transform.localEulerAngles.x = 0
				arg_69_1.actors_["1027ui_story"].transform.localEulerAngles = arg_69_1.actors_["1027ui_story"].transform.localEulerAngles
			end

			local var_72_1 = arg_69_1.actors_["1027ui_story"]

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 and not isNil(var_72_1) and arg_69_1.var_.characterEffect1027ui_story == nil then
				arg_69_1.var_.characterEffect1027ui_story = var_72_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_2 = 0.200000002980232

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_2 and not isNil(var_72_1) then
				if arg_69_1.var_.characterEffect1027ui_story and not isNil(var_72_1) then
					arg_69_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_69_1.time_ >= 0 + var_72_2 and arg_69_1.time_ < 0 + var_72_2 + arg_72_0 and not isNil(var_72_1) and arg_69_1.var_.characterEffect1027ui_story then
				arg_69_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action2_1")
			end

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_72_4 = 0
			local var_72_5 = 0.275

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_4 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				arg_69_1.leftNameTxt_.text = arg_69_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_6 = arg_69_1:GetWordFromCfg(1109704017)
				local var_72_7 = arg_69_1:FormatText(var_72_6.content)

				arg_69_1.text_.text = var_72_7

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_9 = 11 <= 0 and var_72_5 or var_72_5 * (utf8.len(var_72_7) / 11)

				if (11 <= 0 and var_72_5 or var_72_5 * (utf8.len(var_72_7) / 11)) > 0 and var_72_5 < var_72_9 then
					arg_69_1.talkMaxDuration = var_72_9

					if var_72_9 + var_72_4 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_9 + var_72_4
					end
				end

				arg_69_1.text_.text = var_72_7
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704017", "story_v_side_new_1109704.awb") ~= 0 then
					local var_72_10 = manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704017", "story_v_side_new_1109704.awb") / 1000

					if var_72_10 + var_72_4 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_10 + var_72_4
					end

					if var_72_6.prefab_name ~= "" and arg_69_1.actors_[var_72_6.prefab_name] ~= nil then
						local var_72_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_6.prefab_name].transform, "story_v_side_new_1109704", "1109704017", "story_v_side_new_1109704.awb")

						arg_69_1:RecordAudio("1109704017", var_72_11)
						arg_69_1:RecordAudio("1109704017", var_72_11)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_side_new_1109704", "1109704017", "story_v_side_new_1109704.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_side_new_1109704", "1109704017", "story_v_side_new_1109704.awb")
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
				actorName = "1027ui_story",
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
	Play1109704018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 1109704018
		arg_73_1.duration_ = 5.2

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play1109704019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1.var_.moveOldPos1097ui_story = arg_73_1.actors_["1097ui_story"].transform.localPosition
			end

			local var_76_0 = 0.001

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_0 then
				arg_73_1.actors_["1097ui_story"].transform.localPosition = Vector3.Lerp(arg_73_1.var_.moveOldPos1097ui_story, Vector3.New(-0.7, -0.54, -6.3), (arg_73_1.time_ - 0) / var_76_0)
				arg_73_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_73_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_73_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_73_1.actors_["1097ui_story"].transform.position).z)
				arg_73_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_73_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_73_1.actors_["1097ui_story"].transform.localEulerAngles = arg_73_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			if arg_73_1.time_ >= 0 + var_76_0 and arg_73_1.time_ < 0 + var_76_0 + arg_76_0 then
				arg_73_1.actors_["1097ui_story"].transform.localPosition = Vector3.New(-0.7, -0.54, -6.3)
				arg_73_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_73_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_73_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_73_1.actors_["1097ui_story"].transform.position).z)
				arg_73_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_73_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_73_1.actors_["1097ui_story"].transform.localEulerAngles = arg_73_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			local var_76_1 = arg_73_1.actors_["1097ui_story"]

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 and not isNil(var_76_1) and arg_73_1.var_.characterEffect1097ui_story == nil then
				arg_73_1.var_.characterEffect1097ui_story = var_76_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_2 = 0.200000002980232

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_2 and not isNil(var_76_1) then
				if arg_73_1.var_.characterEffect1097ui_story and not isNil(var_76_1) then
					arg_73_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_73_1.time_ >= 0 + var_76_2 and arg_73_1.time_ < 0 + var_76_2 + arg_76_0 and not isNil(var_76_1) and arg_73_1.var_.characterEffect1097ui_story then
				arg_73_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action6_1")
			end

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_76_4 = arg_73_1.actors_["1027ui_story"]

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 and not isNil(var_76_4) and arg_73_1.var_.characterEffect1027ui_story == nil then
				arg_73_1.var_.characterEffect1027ui_story = var_76_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_5 = 0.200000002980232

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_5 and not isNil(var_76_4) then
				if arg_73_1.var_.characterEffect1027ui_story and not isNil(var_76_4) then
					arg_73_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_73_1.var_.characterEffect1027ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_73_1.time_ - 0) / var_76_5)
				end
			end

			if arg_73_1.time_ >= 0 + var_76_5 and arg_73_1.time_ < 0 + var_76_5 + arg_76_0 and not isNil(var_76_4) and arg_73_1.var_.characterEffect1027ui_story then
				arg_73_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_73_1.var_.characterEffect1027ui_story.fillRatio = 0.5
			end

			local var_76_6 = 0
			local var_76_7 = 0.45

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_6 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				arg_73_1.leftNameTxt_.text = arg_73_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_8 = arg_73_1:GetWordFromCfg(1109704018)
				local var_76_9 = arg_73_1:FormatText(var_76_8.content)

				arg_73_1.text_.text = var_76_9

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_11 = 18 <= 0 and var_76_7 or var_76_7 * (utf8.len(var_76_9) / 18)

				if (18 <= 0 and var_76_7 or var_76_7 * (utf8.len(var_76_9) / 18)) > 0 and var_76_7 < var_76_11 then
					arg_73_1.talkMaxDuration = var_76_11

					if var_76_11 + var_76_6 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_11 + var_76_6
					end
				end

				arg_73_1.text_.text = var_76_9
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704018", "story_v_side_new_1109704.awb") ~= 0 then
					local var_76_12 = manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704018", "story_v_side_new_1109704.awb") / 1000

					if var_76_12 + var_76_6 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_12 + var_76_6
					end

					if var_76_8.prefab_name ~= "" and arg_73_1.actors_[var_76_8.prefab_name] ~= nil then
						local var_76_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_8.prefab_name].transform, "story_v_side_new_1109704", "1109704018", "story_v_side_new_1109704.awb")

						arg_73_1:RecordAudio("1109704018", var_76_13)
						arg_73_1:RecordAudio("1109704018", var_76_13)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_side_new_1109704", "1109704018", "story_v_side_new_1109704.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_side_new_1109704", "1109704018", "story_v_side_new_1109704.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_14 = math.max(var_76_7, arg_73_1.talkMaxDuration)

			if var_76_6 <= arg_73_1.time_ and arg_73_1.time_ < var_76_6 + var_76_14 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_6) / var_76_14

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_6 + var_76_14 and arg_73_1.time_ < var_76_6 + var_76_14 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {
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

		arg_73_1:InitPlayNodeList()
	end,
	Play1109704019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 1109704019
		arg_77_1.duration_ = 6.47

		local var_77_0 = {
			zh = 5.133,
			ja = 6.466
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
				arg_77_0:Play1109704020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			if arg_77_1.actors_["1080ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1080ui_story"))) then
				local var_80_0 = Object.Instantiate(Asset.Load("Char/" .. "1080ui_story"), arg_77_1.stage_.transform)

				var_80_0.name = "1080ui_story"
				var_80_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_77_1.actors_["1080ui_story"] = var_80_0

				local var_80_1 = var_80_0:GetComponentInChildren(typeof(CharacterEffect))

				var_80_1.enabled = true

				local var_80_2 = GameObjectTools.GetOrAddComponent(var_80_0, typeof(DynamicBoneHelper))

				if var_80_2 then
					var_80_2:EnableDynamicBone(false)
				end

				arg_77_1:ShowWeapon(var_80_1.transform, false)

				arg_77_1.var_["1080ui_story" .. "Animator"] = var_80_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_77_1.var_["1080ui_story" .. "Animator"].applyRootMotion = true
				arg_77_1.var_["1080ui_story" .. "LipSync"] = var_80_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_80_3 = arg_77_1.actors_["1080ui_story"].transform

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1.var_.moveOldPos1080ui_story = var_80_3.localPosition
			end

			local var_80_4 = 0.001

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_4 then
				var_80_3.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos1080ui_story, Vector3.New(0.7, -1.01, -6.05), (arg_77_1.time_ - 0) / var_80_4)
				var_80_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_80_3.position).x, (manager.ui.mainCamera.transform.position - var_80_3.position).y, (manager.ui.mainCamera.transform.position - var_80_3.position).z)
				var_80_3.localEulerAngles.z = 0
				var_80_3.localEulerAngles.x = 0
				var_80_3.localEulerAngles = var_80_3.localEulerAngles
			end

			if arg_77_1.time_ >= 0 + var_80_4 and arg_77_1.time_ < 0 + var_80_4 + arg_80_0 then
				var_80_3.localPosition = Vector3.New(0.7, -1.01, -6.05)
				var_80_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_80_3.position).x, (manager.ui.mainCamera.transform.position - var_80_3.position).y, (manager.ui.mainCamera.transform.position - var_80_3.position).z)
				var_80_3.localEulerAngles.z = 0
				var_80_3.localEulerAngles.x = 0
				var_80_3.localEulerAngles = var_80_3.localEulerAngles
			end

			local var_80_5 = arg_77_1.actors_["1080ui_story"]

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 and not isNil(var_80_5) and arg_77_1.var_.characterEffect1080ui_story == nil then
				arg_77_1.var_.characterEffect1080ui_story = var_80_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_6 = 0.200000002980232

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_6 and not isNil(var_80_5) then
				if arg_77_1.var_.characterEffect1080ui_story and not isNil(var_80_5) then
					arg_77_1.var_.characterEffect1080ui_story.fillFlat = false
				end
			end

			if arg_77_1.time_ >= 0 + var_80_6 and arg_77_1.time_ < 0 + var_80_6 + arg_80_0 and not isNil(var_80_5) and arg_77_1.var_.characterEffect1080ui_story then
				arg_77_1.var_.characterEffect1080ui_story.fillFlat = false
			end

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/story1080/story1080action/1080action1_1")
			end

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_80_8 = arg_77_1.actors_["1027ui_story"].transform

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1.var_.moveOldPos1027ui_story = var_80_8.localPosition
			end

			local var_80_9 = 0.001

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_9 then
				var_80_8.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos1027ui_story, Vector3.New(0, 100, 0), (arg_77_1.time_ - 0) / var_80_9)
				var_80_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_80_8.position).x, (manager.ui.mainCamera.transform.position - var_80_8.position).y, (manager.ui.mainCamera.transform.position - var_80_8.position).z)
				var_80_8.localEulerAngles.z = 0
				var_80_8.localEulerAngles.x = 0
				var_80_8.localEulerAngles = var_80_8.localEulerAngles
			end

			if arg_77_1.time_ >= 0 + var_80_9 and arg_77_1.time_ < 0 + var_80_9 + arg_80_0 then
				var_80_8.localPosition = Vector3.New(0, 100, 0)
				var_80_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_80_8.position).x, (manager.ui.mainCamera.transform.position - var_80_8.position).y, (manager.ui.mainCamera.transform.position - var_80_8.position).z)
				var_80_8.localEulerAngles.z = 0
				var_80_8.localEulerAngles.x = 0
				var_80_8.localEulerAngles = var_80_8.localEulerAngles
			end

			local var_80_10 = arg_77_1.actors_["1027ui_story"]

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 and not isNil(var_80_10) and arg_77_1.var_.characterEffect1027ui_story == nil then
				arg_77_1.var_.characterEffect1027ui_story = var_80_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_11 = 0.200000002980232

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_11 and not isNil(var_80_10) then
				if arg_77_1.var_.characterEffect1027ui_story and not isNil(var_80_10) then
					arg_77_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_77_1.var_.characterEffect1027ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_77_1.time_ - 0) / var_80_11)
				end
			end

			if arg_77_1.time_ >= 0 + var_80_11 and arg_77_1.time_ < 0 + var_80_11 + arg_80_0 and not isNil(var_80_10) and arg_77_1.var_.characterEffect1027ui_story then
				arg_77_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_77_1.var_.characterEffect1027ui_story.fillRatio = 0.5
			end

			local var_80_12 = arg_77_1.actors_["1097ui_story"]

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 and not isNil(var_80_12) and arg_77_1.var_.characterEffect1097ui_story == nil then
				arg_77_1.var_.characterEffect1097ui_story = var_80_12:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_13 = 0.200000002980232

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_13 and not isNil(var_80_12) then
				if arg_77_1.var_.characterEffect1097ui_story and not isNil(var_80_12) then
					arg_77_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_77_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_77_1.time_ - 0) / var_80_13)
				end
			end

			if arg_77_1.time_ >= 0 + var_80_13 and arg_77_1.time_ < 0 + var_80_13 + arg_80_0 and not isNil(var_80_12) and arg_77_1.var_.characterEffect1097ui_story then
				arg_77_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_77_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_80_14 = 0
			local var_80_15 = 0.45

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_14 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				arg_77_1.leftNameTxt_.text = arg_77_1:FormatText(StoryNameCfg[55].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_16 = arg_77_1:GetWordFromCfg(1109704019)
				local var_80_17 = arg_77_1:FormatText(var_80_16.content)

				arg_77_1.text_.text = var_80_17

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_19 = 18 <= 0 and var_80_15 or var_80_15 * (utf8.len(var_80_17) / 18)

				if (18 <= 0 and var_80_15 or var_80_15 * (utf8.len(var_80_17) / 18)) > 0 and var_80_15 < var_80_19 then
					arg_77_1.talkMaxDuration = var_80_19

					if var_80_19 + var_80_14 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_19 + var_80_14
					end
				end

				arg_77_1.text_.text = var_80_17
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704019", "story_v_side_new_1109704.awb") ~= 0 then
					local var_80_20 = manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704019", "story_v_side_new_1109704.awb") / 1000

					if var_80_20 + var_80_14 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_20 + var_80_14
					end

					if var_80_16.prefab_name ~= "" and arg_77_1.actors_[var_80_16.prefab_name] ~= nil then
						local var_80_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_16.prefab_name].transform, "story_v_side_new_1109704", "1109704019", "story_v_side_new_1109704.awb")

						arg_77_1:RecordAudio("1109704019", var_80_21)
						arg_77_1:RecordAudio("1109704019", var_80_21)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_side_new_1109704", "1109704019", "story_v_side_new_1109704.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_side_new_1109704", "1109704019", "story_v_side_new_1109704.awb")
				end

				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_22 = math.max(var_80_15, arg_77_1.talkMaxDuration)

			if var_80_14 <= arg_77_1.time_ and arg_77_1.time_ < var_80_14 + var_80_22 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_14) / var_80_22

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_14 + var_80_22 and arg_77_1.time_ < var_80_14 + var_80_22 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {
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

		arg_77_1:InitPlayNodeList()
	end,
	Play1109704020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 1109704020
		arg_81_1.duration_ = 5

		SetActive(arg_81_1.tipsGo_, false)

		function arg_81_1.onSingleLineFinish_()
			arg_81_1.onSingleLineUpdate_ = nil
			arg_81_1.onSingleLineFinish_ = nil
			arg_81_1.state_ = "waiting"
		end

		function arg_81_1.playNext_(arg_83_0)
			if arg_83_0 == 1 then
				arg_81_0:Play1109704021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 and not isNil(arg_81_1.actors_["1080ui_story"]) and arg_81_1.var_.characterEffect1080ui_story == nil then
				arg_81_1.var_.characterEffect1080ui_story = arg_81_1.actors_["1080ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_0 = 0.200000002980232

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_0 and not isNil(arg_81_1.actors_["1080ui_story"]) then
				if arg_81_1.var_.characterEffect1080ui_story and not isNil(arg_81_1.actors_["1080ui_story"]) then
					arg_81_1.var_.characterEffect1080ui_story.fillFlat = true
					arg_81_1.var_.characterEffect1080ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_81_1.time_ - 0) / var_84_0)
				end
			end

			if arg_81_1.time_ >= 0 + var_84_0 and arg_81_1.time_ < 0 + var_84_0 + arg_84_0 and not isNil(arg_81_1.actors_["1080ui_story"]) and arg_81_1.var_.characterEffect1080ui_story then
				arg_81_1.var_.characterEffect1080ui_story.fillFlat = true
				arg_81_1.var_.characterEffect1080ui_story.fillRatio = 0.5
			end

			local var_84_1 = 0
			local var_84_2 = 1.15

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_1 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, false)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_3 = arg_81_1:FormatText(arg_81_1:GetWordFromCfg(1109704020).content)

				arg_81_1.text_.text = var_84_3

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_5 = 46 <= 0 and var_84_2 or var_84_2 * (utf8.len(var_84_3) / 46)

				if (46 <= 0 and var_84_2 or var_84_2 * (utf8.len(var_84_3) / 46)) > 0 and var_84_2 < var_84_5 then
					arg_81_1.talkMaxDuration = var_84_5

					if var_84_5 + var_84_1 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_5 + var_84_1
					end
				end

				arg_81_1.text_.text = var_84_3
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)
				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_6 = math.max(var_84_2, arg_81_1.talkMaxDuration)

			if var_84_1 <= arg_81_1.time_ and arg_81_1.time_ < var_84_1 + var_84_6 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_1) / var_84_6

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_1 + var_84_6 and arg_81_1.time_ < var_84_1 + var_84_6 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {}

		arg_81_1:InitPlayNodeList()
	end,
	Play1109704021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 1109704021
		arg_85_1.duration_ = 6.43

		local var_85_0 = {
			zh = 4.033,
			ja = 6.433
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
				arg_85_0:Play1109704022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1.var_.moveOldPos1097ui_story = arg_85_1.actors_["1097ui_story"].transform.localPosition
			end

			local var_88_0 = 0.001

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_0 then
				arg_85_1.actors_["1097ui_story"].transform.localPosition = Vector3.Lerp(arg_85_1.var_.moveOldPos1097ui_story, Vector3.New(-0.7, -0.54, -6.3), (arg_85_1.time_ - 0) / var_88_0)
				arg_85_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_85_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_85_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_85_1.actors_["1097ui_story"].transform.position).z)
				arg_85_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_85_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_85_1.actors_["1097ui_story"].transform.localEulerAngles = arg_85_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			if arg_85_1.time_ >= 0 + var_88_0 and arg_85_1.time_ < 0 + var_88_0 + arg_88_0 then
				arg_85_1.actors_["1097ui_story"].transform.localPosition = Vector3.New(-0.7, -0.54, -6.3)
				arg_85_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_85_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_85_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_85_1.actors_["1097ui_story"].transform.position).z)
				arg_85_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_85_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_85_1.actors_["1097ui_story"].transform.localEulerAngles = arg_85_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			local var_88_1 = arg_85_1.actors_["1097ui_story"]

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 and not isNil(var_88_1) and arg_85_1.var_.characterEffect1097ui_story == nil then
				arg_85_1.var_.characterEffect1097ui_story = var_88_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_2 = 0.200000002980232

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_2 and not isNil(var_88_1) then
				if arg_85_1.var_.characterEffect1097ui_story and not isNil(var_88_1) then
					arg_85_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_85_1.time_ >= 0 + var_88_2 and arg_85_1.time_ < 0 + var_88_2 + arg_88_0 and not isNil(var_88_1) and arg_85_1.var_.characterEffect1097ui_story then
				arg_85_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action6_2")
			end

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_88_4 = 0
			local var_88_5 = 0.35

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_4 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				arg_85_1.leftNameTxt_.text = arg_85_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_6 = arg_85_1:GetWordFromCfg(1109704021)
				local var_88_7 = arg_85_1:FormatText(var_88_6.content)

				arg_85_1.text_.text = var_88_7

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_9 = 14 <= 0 and var_88_5 or var_88_5 * (utf8.len(var_88_7) / 14)

				if (14 <= 0 and var_88_5 or var_88_5 * (utf8.len(var_88_7) / 14)) > 0 and var_88_5 < var_88_9 then
					arg_85_1.talkMaxDuration = var_88_9

					if var_88_9 + var_88_4 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_9 + var_88_4
					end
				end

				arg_85_1.text_.text = var_88_7
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704021", "story_v_side_new_1109704.awb") ~= 0 then
					local var_88_10 = manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704021", "story_v_side_new_1109704.awb") / 1000

					if var_88_10 + var_88_4 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_10 + var_88_4
					end

					if var_88_6.prefab_name ~= "" and arg_85_1.actors_[var_88_6.prefab_name] ~= nil then
						local var_88_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_6.prefab_name].transform, "story_v_side_new_1109704", "1109704021", "story_v_side_new_1109704.awb")

						arg_85_1:RecordAudio("1109704021", var_88_11)
						arg_85_1:RecordAudio("1109704021", var_88_11)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_side_new_1109704", "1109704021", "story_v_side_new_1109704.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_side_new_1109704", "1109704021", "story_v_side_new_1109704.awb")
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
				actorName = "1097ui_story",
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
	Play1109704022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 1109704022
		arg_89_1.duration_ = 2

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play1109704023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1.var_.moveOldPos1080ui_story = arg_89_1.actors_["1080ui_story"].transform.localPosition
			end

			local var_92_0 = 0.001

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_0 then
				arg_89_1.actors_["1080ui_story"].transform.localPosition = Vector3.Lerp(arg_89_1.var_.moveOldPos1080ui_story, Vector3.New(0.7, -1.01, -6.05), (arg_89_1.time_ - 0) / var_92_0)
				arg_89_1.actors_["1080ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_89_1.actors_["1080ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["1080ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["1080ui_story"].transform.position).z)
				arg_89_1.actors_["1080ui_story"].transform.localEulerAngles.z = 0
				arg_89_1.actors_["1080ui_story"].transform.localEulerAngles.x = 0
				arg_89_1.actors_["1080ui_story"].transform.localEulerAngles = arg_89_1.actors_["1080ui_story"].transform.localEulerAngles
			end

			if arg_89_1.time_ >= 0 + var_92_0 and arg_89_1.time_ < 0 + var_92_0 + arg_92_0 then
				arg_89_1.actors_["1080ui_story"].transform.localPosition = Vector3.New(0.7, -1.01, -6.05)
				arg_89_1.actors_["1080ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_89_1.actors_["1080ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["1080ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["1080ui_story"].transform.position).z)
				arg_89_1.actors_["1080ui_story"].transform.localEulerAngles.z = 0
				arg_89_1.actors_["1080ui_story"].transform.localEulerAngles.x = 0
				arg_89_1.actors_["1080ui_story"].transform.localEulerAngles = arg_89_1.actors_["1080ui_story"].transform.localEulerAngles
			end

			local var_92_1 = arg_89_1.actors_["1080ui_story"]

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 and not isNil(var_92_1) and arg_89_1.var_.characterEffect1080ui_story == nil then
				arg_89_1.var_.characterEffect1080ui_story = var_92_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_2 = 0.200000002980232

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_2 and not isNil(var_92_1) then
				if arg_89_1.var_.characterEffect1080ui_story and not isNil(var_92_1) then
					arg_89_1.var_.characterEffect1080ui_story.fillFlat = false
				end
			end

			if arg_89_1.time_ >= 0 + var_92_2 and arg_89_1.time_ < 0 + var_92_2 + arg_92_0 and not isNil(var_92_1) and arg_89_1.var_.characterEffect1080ui_story then
				arg_89_1.var_.characterEffect1080ui_story.fillFlat = false
			end

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/story1080/story1080action/1080action1_1")
			end

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_92_4 = arg_89_1.actors_["1097ui_story"]

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 and not isNil(var_92_4) and arg_89_1.var_.characterEffect1097ui_story == nil then
				arg_89_1.var_.characterEffect1097ui_story = var_92_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_5 = 0.200000002980232

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_5 and not isNil(var_92_4) then
				if arg_89_1.var_.characterEffect1097ui_story and not isNil(var_92_4) then
					arg_89_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_89_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_89_1.time_ - 0) / var_92_5)
				end
			end

			if arg_89_1.time_ >= 0 + var_92_5 and arg_89_1.time_ < 0 + var_92_5 + arg_92_0 and not isNil(var_92_4) and arg_89_1.var_.characterEffect1097ui_story then
				arg_89_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_89_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_92_6 = 0
			local var_92_7 = 0.075

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_6 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				arg_89_1.leftNameTxt_.text = arg_89_1:FormatText(StoryNameCfg[55].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_8 = arg_89_1:GetWordFromCfg(1109704022)
				local var_92_9 = arg_89_1:FormatText(var_92_8.content)

				arg_89_1.text_.text = var_92_9

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_11 = 3 <= 0 and var_92_7 or var_92_7 * (utf8.len(var_92_9) / 3)

				if (3 <= 0 and var_92_7 or var_92_7 * (utf8.len(var_92_9) / 3)) > 0 and var_92_7 < var_92_11 then
					arg_89_1.talkMaxDuration = var_92_11

					if var_92_11 + var_92_6 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_11 + var_92_6
					end
				end

				arg_89_1.text_.text = var_92_9
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704022", "story_v_side_new_1109704.awb") ~= 0 then
					local var_92_12 = manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704022", "story_v_side_new_1109704.awb") / 1000

					if var_92_12 + var_92_6 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_12 + var_92_6
					end

					if var_92_8.prefab_name ~= "" and arg_89_1.actors_[var_92_8.prefab_name] ~= nil then
						local var_92_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_8.prefab_name].transform, "story_v_side_new_1109704", "1109704022", "story_v_side_new_1109704.awb")

						arg_89_1:RecordAudio("1109704022", var_92_13)
						arg_89_1:RecordAudio("1109704022", var_92_13)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_side_new_1109704", "1109704022", "story_v_side_new_1109704.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_side_new_1109704", "1109704022", "story_v_side_new_1109704.awb")
				end

				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_14 = math.max(var_92_7, arg_89_1.talkMaxDuration)

			if var_92_6 <= arg_89_1.time_ and arg_89_1.time_ < var_92_6 + var_92_14 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_6) / var_92_14

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_6 + var_92_14 and arg_89_1.time_ < var_92_6 + var_92_14 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1080ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_89_1:InitPlayNodeList()
	end,
	Play1109704023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 1109704023
		arg_93_1.duration_ = 5

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play1109704024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 and not isNil(arg_93_1.actors_["1080ui_story"]) and arg_93_1.var_.characterEffect1080ui_story == nil then
				arg_93_1.var_.characterEffect1080ui_story = arg_93_1.actors_["1080ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_0 = 0.200000002980232

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_0 and not isNil(arg_93_1.actors_["1080ui_story"]) then
				if arg_93_1.var_.characterEffect1080ui_story and not isNil(arg_93_1.actors_["1080ui_story"]) then
					arg_93_1.var_.characterEffect1080ui_story.fillFlat = true
					arg_93_1.var_.characterEffect1080ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_93_1.time_ - 0) / var_96_0)
				end
			end

			if arg_93_1.time_ >= 0 + var_96_0 and arg_93_1.time_ < 0 + var_96_0 + arg_96_0 and not isNil(arg_93_1.actors_["1080ui_story"]) and arg_93_1.var_.characterEffect1080ui_story then
				arg_93_1.var_.characterEffect1080ui_story.fillFlat = true
				arg_93_1.var_.characterEffect1080ui_story.fillRatio = 0.5
			end

			local var_96_1 = 0
			local var_96_2 = 0.65

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_1 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, false)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_3 = arg_93_1:FormatText(arg_93_1:GetWordFromCfg(1109704023).content)

				arg_93_1.text_.text = var_96_3

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_5 = 26 <= 0 and var_96_2 or var_96_2 * (utf8.len(var_96_3) / 26)

				if (26 <= 0 and var_96_2 or var_96_2 * (utf8.len(var_96_3) / 26)) > 0 and var_96_2 < var_96_5 then
					arg_93_1.talkMaxDuration = var_96_5

					if var_96_5 + var_96_1 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_5 + var_96_1
					end
				end

				arg_93_1.text_.text = var_96_3
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)
				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_6 = math.max(var_96_2, arg_93_1.talkMaxDuration)

			if var_96_1 <= arg_93_1.time_ and arg_93_1.time_ < var_96_1 + var_96_6 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_1) / var_96_6

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_1 + var_96_6 and arg_93_1.time_ < var_96_1 + var_96_6 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play1109704024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 1109704024
		arg_97_1.duration_ = 9

		local var_97_0 = {
			zh = 6.6,
			ja = 9
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
				arg_97_0:Play1109704025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1.var_.moveOldPos1027ui_story = arg_97_1.actors_["1027ui_story"].transform.localPosition
			end

			local var_100_0 = 0.001

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_0 then
				arg_97_1.actors_["1027ui_story"].transform.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos1027ui_story, Vector3.New(0.7, -0.81, -5.8), (arg_97_1.time_ - 0) / var_100_0)
				arg_97_1.actors_["1027ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_97_1.actors_["1027ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["1027ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["1027ui_story"].transform.position).z)
				arg_97_1.actors_["1027ui_story"].transform.localEulerAngles.z = 0
				arg_97_1.actors_["1027ui_story"].transform.localEulerAngles.x = 0
				arg_97_1.actors_["1027ui_story"].transform.localEulerAngles = arg_97_1.actors_["1027ui_story"].transform.localEulerAngles
			end

			if arg_97_1.time_ >= 0 + var_100_0 and arg_97_1.time_ < 0 + var_100_0 + arg_100_0 then
				arg_97_1.actors_["1027ui_story"].transform.localPosition = Vector3.New(0.7, -0.81, -5.8)
				arg_97_1.actors_["1027ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_97_1.actors_["1027ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["1027ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["1027ui_story"].transform.position).z)
				arg_97_1.actors_["1027ui_story"].transform.localEulerAngles.z = 0
				arg_97_1.actors_["1027ui_story"].transform.localEulerAngles.x = 0
				arg_97_1.actors_["1027ui_story"].transform.localEulerAngles = arg_97_1.actors_["1027ui_story"].transform.localEulerAngles
			end

			local var_100_1 = arg_97_1.actors_["1027ui_story"]

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 and not isNil(var_100_1) and arg_97_1.var_.characterEffect1027ui_story == nil then
				arg_97_1.var_.characterEffect1027ui_story = var_100_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_2 = 0.200000002980232

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_2 and not isNil(var_100_1) then
				if arg_97_1.var_.characterEffect1027ui_story and not isNil(var_100_1) then
					arg_97_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_97_1.time_ >= 0 + var_100_2 and arg_97_1.time_ < 0 + var_100_2 + arg_100_0 and not isNil(var_100_1) and arg_97_1.var_.characterEffect1027ui_story then
				arg_97_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action1_1")
			end

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_100_4 = arg_97_1.actors_["1080ui_story"].transform

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1.var_.moveOldPos1080ui_story = var_100_4.localPosition
			end

			local var_100_5 = 0.001

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_5 then
				var_100_4.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos1080ui_story, Vector3.New(0, 100, 0), (arg_97_1.time_ - 0) / var_100_5)
				var_100_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_100_4.position).x, (manager.ui.mainCamera.transform.position - var_100_4.position).y, (manager.ui.mainCamera.transform.position - var_100_4.position).z)
				var_100_4.localEulerAngles.z = 0
				var_100_4.localEulerAngles.x = 0
				var_100_4.localEulerAngles = var_100_4.localEulerAngles
			end

			if arg_97_1.time_ >= 0 + var_100_5 and arg_97_1.time_ < 0 + var_100_5 + arg_100_0 then
				var_100_4.localPosition = Vector3.New(0, 100, 0)
				var_100_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_100_4.position).x, (manager.ui.mainCamera.transform.position - var_100_4.position).y, (manager.ui.mainCamera.transform.position - var_100_4.position).z)
				var_100_4.localEulerAngles.z = 0
				var_100_4.localEulerAngles.x = 0
				var_100_4.localEulerAngles = var_100_4.localEulerAngles
			end

			local var_100_6 = arg_97_1.actors_["1080ui_story"]

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 and not isNil(var_100_6) and arg_97_1.var_.characterEffect1080ui_story == nil then
				arg_97_1.var_.characterEffect1080ui_story = var_100_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_7 = 0.200000002980232

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_7 and not isNil(var_100_6) then
				if arg_97_1.var_.characterEffect1080ui_story and not isNil(var_100_6) then
					arg_97_1.var_.characterEffect1080ui_story.fillFlat = true
					arg_97_1.var_.characterEffect1080ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_97_1.time_ - 0) / var_100_7)
				end
			end

			if arg_97_1.time_ >= 0 + var_100_7 and arg_97_1.time_ < 0 + var_100_7 + arg_100_0 and not isNil(var_100_6) and arg_97_1.var_.characterEffect1080ui_story then
				arg_97_1.var_.characterEffect1080ui_story.fillFlat = true
				arg_97_1.var_.characterEffect1080ui_story.fillRatio = 0.5
			end

			local var_100_8 = 0
			local var_100_9 = 0.85

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_8 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				arg_97_1.leftNameTxt_.text = arg_97_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_10 = arg_97_1:GetWordFromCfg(1109704024)
				local var_100_11 = arg_97_1:FormatText(var_100_10.content)

				arg_97_1.text_.text = var_100_11

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_13 = 34 <= 0 and var_100_9 or var_100_9 * (utf8.len(var_100_11) / 34)

				if (34 <= 0 and var_100_9 or var_100_9 * (utf8.len(var_100_11) / 34)) > 0 and var_100_9 < var_100_13 then
					arg_97_1.talkMaxDuration = var_100_13

					if var_100_13 + var_100_8 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_13 + var_100_8
					end
				end

				arg_97_1.text_.text = var_100_11
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704024", "story_v_side_new_1109704.awb") ~= 0 then
					local var_100_14 = manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704024", "story_v_side_new_1109704.awb") / 1000

					if var_100_14 + var_100_8 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_14 + var_100_8
					end

					if var_100_10.prefab_name ~= "" and arg_97_1.actors_[var_100_10.prefab_name] ~= nil then
						local var_100_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_10.prefab_name].transform, "story_v_side_new_1109704", "1109704024", "story_v_side_new_1109704.awb")

						arg_97_1:RecordAudio("1109704024", var_100_15)
						arg_97_1:RecordAudio("1109704024", var_100_15)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_side_new_1109704", "1109704024", "story_v_side_new_1109704.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_side_new_1109704", "1109704024", "story_v_side_new_1109704.awb")
				end

				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_16 = math.max(var_100_9, arg_97_1.talkMaxDuration)

			if var_100_8 <= arg_97_1.time_ and arg_97_1.time_ < var_100_8 + var_100_16 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_8) / var_100_16

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_8 + var_100_16 and arg_97_1.time_ < var_100_8 + var_100_16 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1027ui_story",
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
			}
		}

		arg_97_1:InitPlayNodeList()
	end,
	Play1109704025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 1109704025
		arg_101_1.duration_ = 7.7

		local var_101_0 = {
			zh = 6.533,
			ja = 7.7
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
				arg_101_0:Play1109704026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1.var_.moveOldPos1080ui_story = arg_101_1.actors_["1080ui_story"].transform.localPosition
			end

			local var_104_0 = 0.001

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_0 then
				arg_101_1.actors_["1080ui_story"].transform.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos1080ui_story, Vector3.New(0.7, -1.01, -6.05), (arg_101_1.time_ - 0) / var_104_0)
				arg_101_1.actors_["1080ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_101_1.actors_["1080ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_101_1.actors_["1080ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_101_1.actors_["1080ui_story"].transform.position).z)
				arg_101_1.actors_["1080ui_story"].transform.localEulerAngles.z = 0
				arg_101_1.actors_["1080ui_story"].transform.localEulerAngles.x = 0
				arg_101_1.actors_["1080ui_story"].transform.localEulerAngles = arg_101_1.actors_["1080ui_story"].transform.localEulerAngles
			end

			if arg_101_1.time_ >= 0 + var_104_0 and arg_101_1.time_ < 0 + var_104_0 + arg_104_0 then
				arg_101_1.actors_["1080ui_story"].transform.localPosition = Vector3.New(0.7, -1.01, -6.05)
				arg_101_1.actors_["1080ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_101_1.actors_["1080ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_101_1.actors_["1080ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_101_1.actors_["1080ui_story"].transform.position).z)
				arg_101_1.actors_["1080ui_story"].transform.localEulerAngles.z = 0
				arg_101_1.actors_["1080ui_story"].transform.localEulerAngles.x = 0
				arg_101_1.actors_["1080ui_story"].transform.localEulerAngles = arg_101_1.actors_["1080ui_story"].transform.localEulerAngles
			end

			local var_104_1 = arg_101_1.actors_["1080ui_story"]

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 and not isNil(var_104_1) and arg_101_1.var_.characterEffect1080ui_story == nil then
				arg_101_1.var_.characterEffect1080ui_story = var_104_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_2 = 0.200000002980232

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_2 and not isNil(var_104_1) then
				if arg_101_1.var_.characterEffect1080ui_story and not isNil(var_104_1) then
					arg_101_1.var_.characterEffect1080ui_story.fillFlat = false
				end
			end

			if arg_101_1.time_ >= 0 + var_104_2 and arg_101_1.time_ < 0 + var_104_2 + arg_104_0 and not isNil(var_104_1) and arg_101_1.var_.characterEffect1080ui_story then
				arg_101_1.var_.characterEffect1080ui_story.fillFlat = false
			end

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/story1080/story1080action/1080action1_1")
			end

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_104_4 = arg_101_1.actors_["1027ui_story"]

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 and not isNil(var_104_4) and arg_101_1.var_.characterEffect1027ui_story == nil then
				arg_101_1.var_.characterEffect1027ui_story = var_104_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_5 = 0.200000002980232

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_5 and not isNil(var_104_4) then
				if arg_101_1.var_.characterEffect1027ui_story and not isNil(var_104_4) then
					arg_101_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_101_1.var_.characterEffect1027ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_101_1.time_ - 0) / var_104_5)
				end
			end

			if arg_101_1.time_ >= 0 + var_104_5 and arg_101_1.time_ < 0 + var_104_5 + arg_104_0 and not isNil(var_104_4) and arg_101_1.var_.characterEffect1027ui_story then
				arg_101_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_101_1.var_.characterEffect1027ui_story.fillRatio = 0.5
			end

			local var_104_6 = arg_101_1.actors_["1027ui_story"].transform

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1.var_.moveOldPos1027ui_story = var_104_6.localPosition
			end

			local var_104_7 = 0.001

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_7 then
				var_104_6.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos1027ui_story, Vector3.New(0, 100, 0), (arg_101_1.time_ - 0) / var_104_7)
				var_104_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_104_6.position).x, (manager.ui.mainCamera.transform.position - var_104_6.position).y, (manager.ui.mainCamera.transform.position - var_104_6.position).z)
				var_104_6.localEulerAngles.z = 0
				var_104_6.localEulerAngles.x = 0
				var_104_6.localEulerAngles = var_104_6.localEulerAngles
			end

			if arg_101_1.time_ >= 0 + var_104_7 and arg_101_1.time_ < 0 + var_104_7 + arg_104_0 then
				var_104_6.localPosition = Vector3.New(0, 100, 0)
				var_104_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_104_6.position).x, (manager.ui.mainCamera.transform.position - var_104_6.position).y, (manager.ui.mainCamera.transform.position - var_104_6.position).z)
				var_104_6.localEulerAngles.z = 0
				var_104_6.localEulerAngles.x = 0
				var_104_6.localEulerAngles = var_104_6.localEulerAngles
			end

			local var_104_8 = 0
			local var_104_9 = 0.6

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= var_104_8 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				arg_101_1.leftNameTxt_.text = arg_101_1:FormatText(StoryNameCfg[55].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_10 = arg_101_1:GetWordFromCfg(1109704025)
				local var_104_11 = arg_101_1:FormatText(var_104_10.content)

				arg_101_1.text_.text = var_104_11

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_13 = 24 <= 0 and var_104_9 or var_104_9 * (utf8.len(var_104_11) / 24)

				if (24 <= 0 and var_104_9 or var_104_9 * (utf8.len(var_104_11) / 24)) > 0 and var_104_9 < var_104_13 then
					arg_101_1.talkMaxDuration = var_104_13

					if var_104_13 + var_104_8 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_13 + var_104_8
					end
				end

				arg_101_1.text_.text = var_104_11
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704025", "story_v_side_new_1109704.awb") ~= 0 then
					local var_104_14 = manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704025", "story_v_side_new_1109704.awb") / 1000

					if var_104_14 + var_104_8 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_14 + var_104_8
					end

					if var_104_10.prefab_name ~= "" and arg_101_1.actors_[var_104_10.prefab_name] ~= nil then
						local var_104_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_10.prefab_name].transform, "story_v_side_new_1109704", "1109704025", "story_v_side_new_1109704.awb")

						arg_101_1:RecordAudio("1109704025", var_104_15)
						arg_101_1:RecordAudio("1109704025", var_104_15)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_side_new_1109704", "1109704025", "story_v_side_new_1109704.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_side_new_1109704", "1109704025", "story_v_side_new_1109704.awb")
				end

				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_16 = math.max(var_104_9, arg_101_1.talkMaxDuration)

			if var_104_8 <= arg_101_1.time_ and arg_101_1.time_ < var_104_8 + var_104_16 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_8) / var_104_16

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_8 + var_104_16 and arg_101_1.time_ < var_104_8 + var_104_16 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {
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

		arg_101_1:InitPlayNodeList()
	end,
	Play1109704026 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 1109704026
		arg_105_1.duration_ = 5.7

		local var_105_0 = {
			zh = 5.333,
			ja = 5.7
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
				arg_105_0:Play1109704027(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1.var_.moveOldPos1027ui_story = arg_105_1.actors_["1027ui_story"].transform.localPosition
			end

			local var_108_0 = 0.001

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_0 then
				arg_105_1.actors_["1027ui_story"].transform.localPosition = Vector3.Lerp(arg_105_1.var_.moveOldPos1027ui_story, Vector3.New(0.7, -0.81, -5.8), (arg_105_1.time_ - 0) / var_108_0)
				arg_105_1.actors_["1027ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_105_1.actors_["1027ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_105_1.actors_["1027ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_105_1.actors_["1027ui_story"].transform.position).z)
				arg_105_1.actors_["1027ui_story"].transform.localEulerAngles.z = 0
				arg_105_1.actors_["1027ui_story"].transform.localEulerAngles.x = 0
				arg_105_1.actors_["1027ui_story"].transform.localEulerAngles = arg_105_1.actors_["1027ui_story"].transform.localEulerAngles
			end

			if arg_105_1.time_ >= 0 + var_108_0 and arg_105_1.time_ < 0 + var_108_0 + arg_108_0 then
				arg_105_1.actors_["1027ui_story"].transform.localPosition = Vector3.New(0.7, -0.81, -5.8)
				arg_105_1.actors_["1027ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_105_1.actors_["1027ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_105_1.actors_["1027ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_105_1.actors_["1027ui_story"].transform.position).z)
				arg_105_1.actors_["1027ui_story"].transform.localEulerAngles.z = 0
				arg_105_1.actors_["1027ui_story"].transform.localEulerAngles.x = 0
				arg_105_1.actors_["1027ui_story"].transform.localEulerAngles = arg_105_1.actors_["1027ui_story"].transform.localEulerAngles
			end

			local var_108_1 = arg_105_1.actors_["1027ui_story"]

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 and not isNil(var_108_1) and arg_105_1.var_.characterEffect1027ui_story == nil then
				arg_105_1.var_.characterEffect1027ui_story = var_108_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_2 = 0.200000002980232

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_2 and not isNil(var_108_1) then
				if arg_105_1.var_.characterEffect1027ui_story and not isNil(var_108_1) then
					arg_105_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_105_1.time_ >= 0 + var_108_2 and arg_105_1.time_ < 0 + var_108_2 + arg_108_0 and not isNil(var_108_1) and arg_105_1.var_.characterEffect1027ui_story then
				arg_105_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action2_1")
			end

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_108_4 = arg_105_1.actors_["1080ui_story"].transform

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1.var_.moveOldPos1080ui_story = var_108_4.localPosition
			end

			local var_108_5 = 0.001

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_5 then
				var_108_4.localPosition = Vector3.Lerp(arg_105_1.var_.moveOldPos1080ui_story, Vector3.New(0, 100, 0), (arg_105_1.time_ - 0) / var_108_5)
				var_108_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_108_4.position).x, (manager.ui.mainCamera.transform.position - var_108_4.position).y, (manager.ui.mainCamera.transform.position - var_108_4.position).z)
				var_108_4.localEulerAngles.z = 0
				var_108_4.localEulerAngles.x = 0
				var_108_4.localEulerAngles = var_108_4.localEulerAngles
			end

			if arg_105_1.time_ >= 0 + var_108_5 and arg_105_1.time_ < 0 + var_108_5 + arg_108_0 then
				var_108_4.localPosition = Vector3.New(0, 100, 0)
				var_108_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_108_4.position).x, (manager.ui.mainCamera.transform.position - var_108_4.position).y, (manager.ui.mainCamera.transform.position - var_108_4.position).z)
				var_108_4.localEulerAngles.z = 0
				var_108_4.localEulerAngles.x = 0
				var_108_4.localEulerAngles = var_108_4.localEulerAngles
			end

			local var_108_6 = arg_105_1.actors_["1080ui_story"]

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 and not isNil(var_108_6) and arg_105_1.var_.characterEffect1080ui_story == nil then
				arg_105_1.var_.characterEffect1080ui_story = var_108_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_7 = 0.200000002980232

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_7 and not isNil(var_108_6) then
				if arg_105_1.var_.characterEffect1080ui_story and not isNil(var_108_6) then
					arg_105_1.var_.characterEffect1080ui_story.fillFlat = true
					arg_105_1.var_.characterEffect1080ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_105_1.time_ - 0) / var_108_7)
				end
			end

			if arg_105_1.time_ >= 0 + var_108_7 and arg_105_1.time_ < 0 + var_108_7 + arg_108_0 and not isNil(var_108_6) and arg_105_1.var_.characterEffect1080ui_story then
				arg_105_1.var_.characterEffect1080ui_story.fillFlat = true
				arg_105_1.var_.characterEffect1080ui_story.fillRatio = 0.5
			end

			local var_108_8 = 0
			local var_108_9 = 0.475

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= var_108_8 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				arg_105_1.leftNameTxt_.text = arg_105_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_10 = arg_105_1:GetWordFromCfg(1109704026)
				local var_108_11 = arg_105_1:FormatText(var_108_10.content)

				arg_105_1.text_.text = var_108_11

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_13 = 19 <= 0 and var_108_9 or var_108_9 * (utf8.len(var_108_11) / 19)

				if (19 <= 0 and var_108_9 or var_108_9 * (utf8.len(var_108_11) / 19)) > 0 and var_108_9 < var_108_13 then
					arg_105_1.talkMaxDuration = var_108_13

					if var_108_13 + var_108_8 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_13 + var_108_8
					end
				end

				arg_105_1.text_.text = var_108_11
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704026", "story_v_side_new_1109704.awb") ~= 0 then
					local var_108_14 = manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704026", "story_v_side_new_1109704.awb") / 1000

					if var_108_14 + var_108_8 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_14 + var_108_8
					end

					if var_108_10.prefab_name ~= "" and arg_105_1.actors_[var_108_10.prefab_name] ~= nil then
						local var_108_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_10.prefab_name].transform, "story_v_side_new_1109704", "1109704026", "story_v_side_new_1109704.awb")

						arg_105_1:RecordAudio("1109704026", var_108_15)
						arg_105_1:RecordAudio("1109704026", var_108_15)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_side_new_1109704", "1109704026", "story_v_side_new_1109704.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_side_new_1109704", "1109704026", "story_v_side_new_1109704.awb")
				end

				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_16 = math.max(var_108_9, arg_105_1.talkMaxDuration)

			if var_108_8 <= arg_105_1.time_ and arg_105_1.time_ < var_108_8 + var_108_16 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_8) / var_108_16

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_8 + var_108_16 and arg_105_1.time_ < var_108_8 + var_108_16 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1027ui_story",
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
			}
		}

		arg_105_1:InitPlayNodeList()
	end,
	Play1109704027 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 1109704027
		arg_109_1.duration_ = 5.1

		local var_109_0 = {
			zh = 3.733,
			ja = 5.1
		}
		local var_109_1 = manager.audio:GetLocalizationFlag()

		if var_109_0[var_109_1] ~= nil then
			arg_109_1.duration_ = var_109_0[var_109_1]
		end

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
		end

		function arg_109_1.playNext_(arg_111_0)
			if arg_111_0 == 1 then
				arg_109_0:Play1109704028(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1.var_.moveOldPos1097ui_story = arg_109_1.actors_["1097ui_story"].transform.localPosition
			end

			local var_112_0 = 0.001

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_0 then
				arg_109_1.actors_["1097ui_story"].transform.localPosition = Vector3.Lerp(arg_109_1.var_.moveOldPos1097ui_story, Vector3.New(-0.7, -0.54, -6.3), (arg_109_1.time_ - 0) / var_112_0)
				arg_109_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_109_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_109_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_109_1.actors_["1097ui_story"].transform.position).z)
				arg_109_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_109_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_109_1.actors_["1097ui_story"].transform.localEulerAngles = arg_109_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			if arg_109_1.time_ >= 0 + var_112_0 and arg_109_1.time_ < 0 + var_112_0 + arg_112_0 then
				arg_109_1.actors_["1097ui_story"].transform.localPosition = Vector3.New(-0.7, -0.54, -6.3)
				arg_109_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_109_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_109_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_109_1.actors_["1097ui_story"].transform.position).z)
				arg_109_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_109_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_109_1.actors_["1097ui_story"].transform.localEulerAngles = arg_109_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			local var_112_1 = arg_109_1.actors_["1097ui_story"]

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 and not isNil(var_112_1) and arg_109_1.var_.characterEffect1097ui_story == nil then
				arg_109_1.var_.characterEffect1097ui_story = var_112_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_2 = 0.200000002980232

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_2 and not isNil(var_112_1) then
				if arg_109_1.var_.characterEffect1097ui_story and not isNil(var_112_1) then
					arg_109_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_109_1.time_ >= 0 + var_112_2 and arg_109_1.time_ < 0 + var_112_2 + arg_112_0 and not isNil(var_112_1) and arg_109_1.var_.characterEffect1097ui_story then
				arg_109_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action7_1")
			end

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_112_4 = arg_109_1.actors_["1080ui_story"].transform

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1.var_.moveOldPos1080ui_story = var_112_4.localPosition
			end

			local var_112_5 = 0.001

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_5 then
				var_112_4.localPosition = Vector3.Lerp(arg_109_1.var_.moveOldPos1080ui_story, Vector3.New(0.7, -1.01, -6.05), (arg_109_1.time_ - 0) / var_112_5)
				var_112_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_112_4.position).x, (manager.ui.mainCamera.transform.position - var_112_4.position).y, (manager.ui.mainCamera.transform.position - var_112_4.position).z)
				var_112_4.localEulerAngles.z = 0
				var_112_4.localEulerAngles.x = 0
				var_112_4.localEulerAngles = var_112_4.localEulerAngles
			end

			if arg_109_1.time_ >= 0 + var_112_5 and arg_109_1.time_ < 0 + var_112_5 + arg_112_0 then
				var_112_4.localPosition = Vector3.New(0.7, -1.01, -6.05)
				var_112_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_112_4.position).x, (manager.ui.mainCamera.transform.position - var_112_4.position).y, (manager.ui.mainCamera.transform.position - var_112_4.position).z)
				var_112_4.localEulerAngles.z = 0
				var_112_4.localEulerAngles.x = 0
				var_112_4.localEulerAngles = var_112_4.localEulerAngles
			end

			local var_112_6 = arg_109_1.actors_["1080ui_story"]

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 and not isNil(var_112_6) and arg_109_1.var_.characterEffect1080ui_story == nil then
				arg_109_1.var_.characterEffect1080ui_story = var_112_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_7 = 0.200000002980232

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_7 and not isNil(var_112_6) then
				if arg_109_1.var_.characterEffect1080ui_story and not isNil(var_112_6) then
					arg_109_1.var_.characterEffect1080ui_story.fillFlat = true
					arg_109_1.var_.characterEffect1080ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_109_1.time_ - 0) / var_112_7)
				end
			end

			if arg_109_1.time_ >= 0 + var_112_7 and arg_109_1.time_ < 0 + var_112_7 + arg_112_0 and not isNil(var_112_6) and arg_109_1.var_.characterEffect1080ui_story then
				arg_109_1.var_.characterEffect1080ui_story.fillFlat = true
				arg_109_1.var_.characterEffect1080ui_story.fillRatio = 0.5
			end

			local var_112_8 = arg_109_1.actors_["1027ui_story"].transform

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1.var_.moveOldPos1027ui_story = var_112_8.localPosition
			end

			local var_112_9 = 0.001

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_9 then
				var_112_8.localPosition = Vector3.Lerp(arg_109_1.var_.moveOldPos1027ui_story, Vector3.New(0, 100, 0), (arg_109_1.time_ - 0) / var_112_9)
				var_112_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_112_8.position).x, (manager.ui.mainCamera.transform.position - var_112_8.position).y, (manager.ui.mainCamera.transform.position - var_112_8.position).z)
				var_112_8.localEulerAngles.z = 0
				var_112_8.localEulerAngles.x = 0
				var_112_8.localEulerAngles = var_112_8.localEulerAngles
			end

			if arg_109_1.time_ >= 0 + var_112_9 and arg_109_1.time_ < 0 + var_112_9 + arg_112_0 then
				var_112_8.localPosition = Vector3.New(0, 100, 0)
				var_112_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_112_8.position).x, (manager.ui.mainCamera.transform.position - var_112_8.position).y, (manager.ui.mainCamera.transform.position - var_112_8.position).z)
				var_112_8.localEulerAngles.z = 0
				var_112_8.localEulerAngles.x = 0
				var_112_8.localEulerAngles = var_112_8.localEulerAngles
			end

			local var_112_10 = arg_109_1.actors_["1027ui_story"]

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 and not isNil(var_112_10) and arg_109_1.var_.characterEffect1027ui_story == nil then
				arg_109_1.var_.characterEffect1027ui_story = var_112_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_11 = 0.200000002980232

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_11 and not isNil(var_112_10) then
				if arg_109_1.var_.characterEffect1027ui_story and not isNil(var_112_10) then
					arg_109_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_109_1.var_.characterEffect1027ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_109_1.time_ - 0) / var_112_11)
				end
			end

			if arg_109_1.time_ >= 0 + var_112_11 and arg_109_1.time_ < 0 + var_112_11 + arg_112_0 and not isNil(var_112_10) and arg_109_1.var_.characterEffect1027ui_story then
				arg_109_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_109_1.var_.characterEffect1027ui_story.fillRatio = 0.5
			end

			local var_112_12 = 0
			local var_112_13 = 0.375

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= var_112_12 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				arg_109_1.leftNameTxt_.text = arg_109_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_14 = arg_109_1:GetWordFromCfg(1109704027)
				local var_112_15 = arg_109_1:FormatText(var_112_14.content)

				arg_109_1.text_.text = var_112_15

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_17 = 15 <= 0 and var_112_13 or var_112_13 * (utf8.len(var_112_15) / 15)

				if (15 <= 0 and var_112_13 or var_112_13 * (utf8.len(var_112_15) / 15)) > 0 and var_112_13 < var_112_17 then
					arg_109_1.talkMaxDuration = var_112_17

					if var_112_17 + var_112_12 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_17 + var_112_12
					end
				end

				arg_109_1.text_.text = var_112_15
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704027", "story_v_side_new_1109704.awb") ~= 0 then
					local var_112_18 = manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704027", "story_v_side_new_1109704.awb") / 1000

					if var_112_18 + var_112_12 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_18 + var_112_12
					end

					if var_112_14.prefab_name ~= "" and arg_109_1.actors_[var_112_14.prefab_name] ~= nil then
						local var_112_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_14.prefab_name].transform, "story_v_side_new_1109704", "1109704027", "story_v_side_new_1109704.awb")

						arg_109_1:RecordAudio("1109704027", var_112_19)
						arg_109_1:RecordAudio("1109704027", var_112_19)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_side_new_1109704", "1109704027", "story_v_side_new_1109704.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_side_new_1109704", "1109704027", "story_v_side_new_1109704.awb")
				end

				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_20 = math.max(var_112_13, arg_109_1.talkMaxDuration)

			if var_112_12 <= arg_109_1.time_ and arg_109_1.time_ < var_112_12 + var_112_20 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_12) / var_112_20

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_12 + var_112_20 and arg_109_1.time_ < var_112_12 + var_112_20 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {
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

		arg_109_1:InitPlayNodeList()
	end,
	Play1109704028 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 1109704028
		arg_113_1.duration_ = 5.4

		local var_113_0 = {
			zh = 5.4,
			ja = 4.366
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
				arg_113_0:Play1109704029(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action7_2")
			end

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_116_0 = 0
			local var_116_1 = 0.575

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= var_116_0 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				arg_113_1.leftNameTxt_.text = arg_113_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_2 = arg_113_1:GetWordFromCfg(1109704028)
				local var_116_3 = arg_113_1:FormatText(var_116_2.content)

				arg_113_1.text_.text = var_116_3

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_5 = 23 <= 0 and var_116_1 or var_116_1 * (utf8.len(var_116_3) / 23)

				if (23 <= 0 and var_116_1 or var_116_1 * (utf8.len(var_116_3) / 23)) > 0 and var_116_1 < var_116_5 then
					arg_113_1.talkMaxDuration = var_116_5

					if var_116_5 + var_116_0 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_5 + var_116_0
					end
				end

				arg_113_1.text_.text = var_116_3
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704028", "story_v_side_new_1109704.awb") ~= 0 then
					local var_116_6 = manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704028", "story_v_side_new_1109704.awb") / 1000

					if var_116_6 + var_116_0 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_6 + var_116_0
					end

					if var_116_2.prefab_name ~= "" and arg_113_1.actors_[var_116_2.prefab_name] ~= nil then
						local var_116_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_2.prefab_name].transform, "story_v_side_new_1109704", "1109704028", "story_v_side_new_1109704.awb")

						arg_113_1:RecordAudio("1109704028", var_116_7)
						arg_113_1:RecordAudio("1109704028", var_116_7)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_side_new_1109704", "1109704028", "story_v_side_new_1109704.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_side_new_1109704", "1109704028", "story_v_side_new_1109704.awb")
				end

				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_8 = math.max(var_116_1, arg_113_1.talkMaxDuration)

			if var_116_0 <= arg_113_1.time_ and arg_113_1.time_ < var_116_0 + var_116_8 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_0) / var_116_8

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_0 + var_116_8 and arg_113_1.time_ < var_116_0 + var_116_8 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {}

		arg_113_1:InitPlayNodeList()
	end,
	Play1109704029 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 1109704029
		arg_117_1.duration_ = 5

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"
		end

		function arg_117_1.playNext_(arg_119_0)
			if arg_119_0 == 1 then
				arg_117_0:Play1109704030(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 and not isNil(arg_117_1.actors_["1097ui_story"]) and arg_117_1.var_.characterEffect1097ui_story == nil then
				arg_117_1.var_.characterEffect1097ui_story = arg_117_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_120_0 = 0.200000002980232

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_0 and not isNil(arg_117_1.actors_["1097ui_story"]) then
				if arg_117_1.var_.characterEffect1097ui_story and not isNil(arg_117_1.actors_["1097ui_story"]) then
					arg_117_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_117_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_117_1.time_ - 0) / var_120_0)
				end
			end

			if arg_117_1.time_ >= 0 + var_120_0 and arg_117_1.time_ < 0 + var_120_0 + arg_120_0 and not isNil(arg_117_1.actors_["1097ui_story"]) and arg_117_1.var_.characterEffect1097ui_story then
				arg_117_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_117_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_120_1 = 0
			local var_120_2 = 0.25

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= var_120_1 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				arg_117_1.leftNameTxt_.text = arg_117_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, true)
				arg_117_1.iconController_:SetSelectedState("hero")

				arg_117_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_117_1.callingController_:SetSelectedState("normal")

				arg_117_1.keyicon_.color = Color.New(1, 1, 1)
				arg_117_1.icon_.color = Color.New(1, 1, 1)

				local var_120_3 = arg_117_1:FormatText(arg_117_1:GetWordFromCfg(1109704029).content)

				arg_117_1.text_.text = var_120_3

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_5 = 10 <= 0 and var_120_2 or var_120_2 * (utf8.len(var_120_3) / 10)

				if (10 <= 0 and var_120_2 or var_120_2 * (utf8.len(var_120_3) / 10)) > 0 and var_120_2 < var_120_5 then
					arg_117_1.talkMaxDuration = var_120_5

					if var_120_5 + var_120_1 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_5 + var_120_1
					end
				end

				arg_117_1.text_.text = var_120_3
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)
				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_6 = math.max(var_120_2, arg_117_1.talkMaxDuration)

			if var_120_1 <= arg_117_1.time_ and arg_117_1.time_ < var_120_1 + var_120_6 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_1) / var_120_6

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_1 + var_120_6 and arg_117_1.time_ < var_120_1 + var_120_6 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {}

		arg_117_1:InitPlayNodeList()
	end,
	Play1109704030 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 1109704030
		arg_121_1.duration_ = 4.27

		local var_121_0 = {
			zh = 3.666,
			ja = 4.266
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
				arg_121_0:Play1109704031(arg_121_1)
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
				arg_121_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_124_2 = 0
			local var_124_3 = 0.575

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= var_124_2 + arg_124_0 then
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

				local var_124_4 = arg_121_1:GetWordFromCfg(1109704030)
				local var_124_5 = arg_121_1:FormatText(var_124_4.content)

				arg_121_1.text_.text = var_124_5

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_7 = 23 <= 0 and var_124_3 or var_124_3 * (utf8.len(var_124_5) / 23)

				if (23 <= 0 and var_124_3 or var_124_3 * (utf8.len(var_124_5) / 23)) > 0 and var_124_3 < var_124_7 then
					arg_121_1.talkMaxDuration = var_124_7

					if var_124_7 + var_124_2 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_7 + var_124_2
					end
				end

				arg_121_1.text_.text = var_124_5
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704030", "story_v_side_new_1109704.awb") ~= 0 then
					local var_124_8 = manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704030", "story_v_side_new_1109704.awb") / 1000

					if var_124_8 + var_124_2 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_8 + var_124_2
					end

					if var_124_4.prefab_name ~= "" and arg_121_1.actors_[var_124_4.prefab_name] ~= nil then
						local var_124_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_4.prefab_name].transform, "story_v_side_new_1109704", "1109704030", "story_v_side_new_1109704.awb")

						arg_121_1:RecordAudio("1109704030", var_124_9)
						arg_121_1:RecordAudio("1109704030", var_124_9)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_side_new_1109704", "1109704030", "story_v_side_new_1109704.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_side_new_1109704", "1109704030", "story_v_side_new_1109704.awb")
				end

				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_10 = math.max(var_124_3, arg_121_1.talkMaxDuration)

			if var_124_2 <= arg_121_1.time_ and arg_121_1.time_ < var_124_2 + var_124_10 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_2) / var_124_10

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_2 + var_124_10 and arg_121_1.time_ < var_124_2 + var_124_10 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {}

		arg_121_1:InitPlayNodeList()
	end,
	Play1109704031 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 1109704031
		arg_125_1.duration_ = 7.8

		local var_125_0 = {
			zh = 6.666,
			ja = 7.8
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
				arg_125_0:Play1109704032(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1.var_.moveOldPos1027ui_story = arg_125_1.actors_["1027ui_story"].transform.localPosition
			end

			local var_128_0 = 0.001

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_0 then
				arg_125_1.actors_["1027ui_story"].transform.localPosition = Vector3.Lerp(arg_125_1.var_.moveOldPos1027ui_story, Vector3.New(0.7, -0.81, -5.8), (arg_125_1.time_ - 0) / var_128_0)
				arg_125_1.actors_["1027ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_125_1.actors_["1027ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_125_1.actors_["1027ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_125_1.actors_["1027ui_story"].transform.position).z)
				arg_125_1.actors_["1027ui_story"].transform.localEulerAngles.z = 0
				arg_125_1.actors_["1027ui_story"].transform.localEulerAngles.x = 0
				arg_125_1.actors_["1027ui_story"].transform.localEulerAngles = arg_125_1.actors_["1027ui_story"].transform.localEulerAngles
			end

			if arg_125_1.time_ >= 0 + var_128_0 and arg_125_1.time_ < 0 + var_128_0 + arg_128_0 then
				arg_125_1.actors_["1027ui_story"].transform.localPosition = Vector3.New(0.7, -0.81, -5.8)
				arg_125_1.actors_["1027ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_125_1.actors_["1027ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_125_1.actors_["1027ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_125_1.actors_["1027ui_story"].transform.position).z)
				arg_125_1.actors_["1027ui_story"].transform.localEulerAngles.z = 0
				arg_125_1.actors_["1027ui_story"].transform.localEulerAngles.x = 0
				arg_125_1.actors_["1027ui_story"].transform.localEulerAngles = arg_125_1.actors_["1027ui_story"].transform.localEulerAngles
			end

			local var_128_1 = arg_125_1.actors_["1027ui_story"]

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 and not isNil(var_128_1) and arg_125_1.var_.characterEffect1027ui_story == nil then
				arg_125_1.var_.characterEffect1027ui_story = var_128_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_2 = 0.200000002980232

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_2 and not isNil(var_128_1) then
				if arg_125_1.var_.characterEffect1027ui_story and not isNil(var_128_1) then
					arg_125_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_125_1.time_ >= 0 + var_128_2 and arg_125_1.time_ < 0 + var_128_2 + arg_128_0 and not isNil(var_128_1) and arg_125_1.var_.characterEffect1027ui_story then
				arg_125_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action4_1")
			end

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_128_4 = arg_125_1.actors_["1080ui_story"].transform

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1.var_.moveOldPos1080ui_story = var_128_4.localPosition
			end

			local var_128_5 = 0.001

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_5 then
				var_128_4.localPosition = Vector3.Lerp(arg_125_1.var_.moveOldPos1080ui_story, Vector3.New(0, 100, 0), (arg_125_1.time_ - 0) / var_128_5)
				var_128_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_128_4.position).x, (manager.ui.mainCamera.transform.position - var_128_4.position).y, (manager.ui.mainCamera.transform.position - var_128_4.position).z)
				var_128_4.localEulerAngles.z = 0
				var_128_4.localEulerAngles.x = 0
				var_128_4.localEulerAngles = var_128_4.localEulerAngles
			end

			if arg_125_1.time_ >= 0 + var_128_5 and arg_125_1.time_ < 0 + var_128_5 + arg_128_0 then
				var_128_4.localPosition = Vector3.New(0, 100, 0)
				var_128_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_128_4.position).x, (manager.ui.mainCamera.transform.position - var_128_4.position).y, (manager.ui.mainCamera.transform.position - var_128_4.position).z)
				var_128_4.localEulerAngles.z = 0
				var_128_4.localEulerAngles.x = 0
				var_128_4.localEulerAngles = var_128_4.localEulerAngles
			end

			local var_128_6 = arg_125_1.actors_["1080ui_story"]

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 and not isNil(var_128_6) and arg_125_1.var_.characterEffect1080ui_story == nil then
				arg_125_1.var_.characterEffect1080ui_story = var_128_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_7 = 0.200000002980232

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_7 and not isNil(var_128_6) then
				if arg_125_1.var_.characterEffect1080ui_story and not isNil(var_128_6) then
					arg_125_1.var_.characterEffect1080ui_story.fillFlat = true
					arg_125_1.var_.characterEffect1080ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_125_1.time_ - 0) / var_128_7)
				end
			end

			if arg_125_1.time_ >= 0 + var_128_7 and arg_125_1.time_ < 0 + var_128_7 + arg_128_0 and not isNil(var_128_6) and arg_125_1.var_.characterEffect1080ui_story then
				arg_125_1.var_.characterEffect1080ui_story.fillFlat = true
				arg_125_1.var_.characterEffect1080ui_story.fillRatio = 0.5
			end

			local var_128_8 = arg_125_1.actors_["1097ui_story"]

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 and not isNil(var_128_8) and arg_125_1.var_.characterEffect1097ui_story == nil then
				arg_125_1.var_.characterEffect1097ui_story = var_128_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_9 = 0.200000002980232

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_9 and not isNil(var_128_8) then
				if arg_125_1.var_.characterEffect1097ui_story and not isNil(var_128_8) then
					arg_125_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_125_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_125_1.time_ - 0) / var_128_9)
				end
			end

			if arg_125_1.time_ >= 0 + var_128_9 and arg_125_1.time_ < 0 + var_128_9 + arg_128_0 and not isNil(var_128_8) and arg_125_1.var_.characterEffect1097ui_story then
				arg_125_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_125_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_128_10 = 0
			local var_128_11 = 0.6

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= var_128_10 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				arg_125_1.leftNameTxt_.text = arg_125_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_12 = arg_125_1:GetWordFromCfg(1109704031)
				local var_128_13 = arg_125_1:FormatText(var_128_12.content)

				arg_125_1.text_.text = var_128_13

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_15 = 24 <= 0 and var_128_11 or var_128_11 * (utf8.len(var_128_13) / 24)

				if (24 <= 0 and var_128_11 or var_128_11 * (utf8.len(var_128_13) / 24)) > 0 and var_128_11 < var_128_15 then
					arg_125_1.talkMaxDuration = var_128_15

					if var_128_15 + var_128_10 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_15 + var_128_10
					end
				end

				arg_125_1.text_.text = var_128_13
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704031", "story_v_side_new_1109704.awb") ~= 0 then
					local var_128_16 = manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704031", "story_v_side_new_1109704.awb") / 1000

					if var_128_16 + var_128_10 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_16 + var_128_10
					end

					if var_128_12.prefab_name ~= "" and arg_125_1.actors_[var_128_12.prefab_name] ~= nil then
						local var_128_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_125_1.actors_[var_128_12.prefab_name].transform, "story_v_side_new_1109704", "1109704031", "story_v_side_new_1109704.awb")

						arg_125_1:RecordAudio("1109704031", var_128_17)
						arg_125_1:RecordAudio("1109704031", var_128_17)
					else
						arg_125_1:AudioAction("play", "voice", "story_v_side_new_1109704", "1109704031", "story_v_side_new_1109704.awb")
					end

					arg_125_1:RecordHistoryTalkVoice("story_v_side_new_1109704", "1109704031", "story_v_side_new_1109704.awb")
				end

				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_18 = math.max(var_128_11, arg_125_1.talkMaxDuration)

			if var_128_10 <= arg_125_1.time_ and arg_125_1.time_ < var_128_10 + var_128_18 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_10) / var_128_18

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_10 + var_128_18 and arg_125_1.time_ < var_128_10 + var_128_18 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1027ui_story",
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
			}
		}

		arg_125_1:InitPlayNodeList()
	end,
	Play1109704032 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 1109704032
		arg_129_1.duration_ = 8.83

		local var_129_0 = {
			zh = 4.9,
			ja = 8.833
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
				arg_129_0:Play1109704033(arg_129_1)
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
				arg_129_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_132_2 = arg_129_1.actors_["1027ui_story"]

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 and not isNil(var_132_2) and arg_129_1.var_.characterEffect1027ui_story == nil then
				arg_129_1.var_.characterEffect1027ui_story = var_132_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_132_3 = 0.200000002980232

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_3 and not isNil(var_132_2) then
				if arg_129_1.var_.characterEffect1027ui_story and not isNil(var_132_2) then
					arg_129_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_129_1.var_.characterEffect1027ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_129_1.time_ - 0) / var_132_3)
				end
			end

			if arg_129_1.time_ >= 0 + var_132_3 and arg_129_1.time_ < 0 + var_132_3 + arg_132_0 and not isNil(var_132_2) and arg_129_1.var_.characterEffect1027ui_story then
				arg_129_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_129_1.var_.characterEffect1027ui_story.fillRatio = 0.5
			end

			local var_132_4 = 0
			local var_132_5 = 0.55

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

				local var_132_6 = arg_129_1:GetWordFromCfg(1109704032)
				local var_132_7 = arg_129_1:FormatText(var_132_6.content)

				arg_129_1.text_.text = var_132_7

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_9 = 22 <= 0 and var_132_5 or var_132_5 * (utf8.len(var_132_7) / 22)

				if (22 <= 0 and var_132_5 or var_132_5 * (utf8.len(var_132_7) / 22)) > 0 and var_132_5 < var_132_9 then
					arg_129_1.talkMaxDuration = var_132_9

					if var_132_9 + var_132_4 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_9 + var_132_4
					end
				end

				arg_129_1.text_.text = var_132_7
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704032", "story_v_side_new_1109704.awb") ~= 0 then
					local var_132_10 = manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704032", "story_v_side_new_1109704.awb") / 1000

					if var_132_10 + var_132_4 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_10 + var_132_4
					end

					if var_132_6.prefab_name ~= "" and arg_129_1.actors_[var_132_6.prefab_name] ~= nil then
						local var_132_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_6.prefab_name].transform, "story_v_side_new_1109704", "1109704032", "story_v_side_new_1109704.awb")

						arg_129_1:RecordAudio("1109704032", var_132_11)
						arg_129_1:RecordAudio("1109704032", var_132_11)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_side_new_1109704", "1109704032", "story_v_side_new_1109704.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_side_new_1109704", "1109704032", "story_v_side_new_1109704.awb")
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
	Play1109704033 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 1109704033
		arg_133_1.duration_ = 5.6

		local var_133_0 = {
			zh = 5.6,
			ja = 5.333
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
				arg_133_0:Play1109704034(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 and not isNil(arg_133_1.actors_["1027ui_story"]) and arg_133_1.var_.characterEffect1027ui_story == nil then
				arg_133_1.var_.characterEffect1027ui_story = arg_133_1.actors_["1027ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_0 = 0.200000002980232

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_0 and not isNil(arg_133_1.actors_["1027ui_story"]) then
				if arg_133_1.var_.characterEffect1027ui_story and not isNil(arg_133_1.actors_["1027ui_story"]) then
					arg_133_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_133_1.time_ >= 0 + var_136_0 and arg_133_1.time_ < 0 + var_136_0 + arg_136_0 and not isNil(arg_133_1.actors_["1027ui_story"]) and arg_133_1.var_.characterEffect1027ui_story then
				arg_133_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action4_2")
			end

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_136_2 = arg_133_1.actors_["1097ui_story"]

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 and not isNil(var_136_2) and arg_133_1.var_.characterEffect1097ui_story == nil then
				arg_133_1.var_.characterEffect1097ui_story = var_136_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_3 = 0.200000002980232

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_3 and not isNil(var_136_2) then
				if arg_133_1.var_.characterEffect1097ui_story and not isNil(var_136_2) then
					arg_133_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_133_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_133_1.time_ - 0) / var_136_3)
				end
			end

			if arg_133_1.time_ >= 0 + var_136_3 and arg_133_1.time_ < 0 + var_136_3 + arg_136_0 and not isNil(var_136_2) and arg_133_1.var_.characterEffect1097ui_story then
				arg_133_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_133_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_136_4 = 0
			local var_136_5 = 0.55

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= var_136_4 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				arg_133_1.leftNameTxt_.text = arg_133_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_6 = arg_133_1:GetWordFromCfg(1109704033)
				local var_136_7 = arg_133_1:FormatText(var_136_6.content)

				arg_133_1.text_.text = var_136_7

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_9 = 22 <= 0 and var_136_5 or var_136_5 * (utf8.len(var_136_7) / 22)

				if (22 <= 0 and var_136_5 or var_136_5 * (utf8.len(var_136_7) / 22)) > 0 and var_136_5 < var_136_9 then
					arg_133_1.talkMaxDuration = var_136_9

					if var_136_9 + var_136_4 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_9 + var_136_4
					end
				end

				arg_133_1.text_.text = var_136_7
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704033", "story_v_side_new_1109704.awb") ~= 0 then
					local var_136_10 = manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704033", "story_v_side_new_1109704.awb") / 1000

					if var_136_10 + var_136_4 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_10 + var_136_4
					end

					if var_136_6.prefab_name ~= "" and arg_133_1.actors_[var_136_6.prefab_name] ~= nil then
						local var_136_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_6.prefab_name].transform, "story_v_side_new_1109704", "1109704033", "story_v_side_new_1109704.awb")

						arg_133_1:RecordAudio("1109704033", var_136_11)
						arg_133_1:RecordAudio("1109704033", var_136_11)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_side_new_1109704", "1109704033", "story_v_side_new_1109704.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_side_new_1109704", "1109704033", "story_v_side_new_1109704.awb")
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

		arg_133_1.nodeConfigList_ = {}

		arg_133_1:InitPlayNodeList()
	end,
	Play1109704034 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 1109704034
		arg_137_1.duration_ = 7.23

		local var_137_0 = {
			zh = 7.233,
			ja = 5.966
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
				arg_137_0:Play1109704035(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 and not isNil(arg_137_1.actors_["1097ui_story"]) and arg_137_1.var_.characterEffect1097ui_story == nil then
				arg_137_1.var_.characterEffect1097ui_story = arg_137_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_140_0 = 0.200000002980232

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_0 and not isNil(arg_137_1.actors_["1097ui_story"]) then
				if arg_137_1.var_.characterEffect1097ui_story and not isNil(arg_137_1.actors_["1097ui_story"]) then
					arg_137_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_137_1.time_ >= 0 + var_140_0 and arg_137_1.time_ < 0 + var_140_0 + arg_140_0 and not isNil(arg_137_1.actors_["1097ui_story"]) and arg_137_1.var_.characterEffect1097ui_story then
				arg_137_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_140_2 = arg_137_1.actors_["1027ui_story"]

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 and not isNil(var_140_2) and arg_137_1.var_.characterEffect1027ui_story == nil then
				arg_137_1.var_.characterEffect1027ui_story = var_140_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_140_3 = 0.200000002980232

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_3 and not isNil(var_140_2) then
				if arg_137_1.var_.characterEffect1027ui_story and not isNil(var_140_2) then
					arg_137_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_137_1.var_.characterEffect1027ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_137_1.time_ - 0) / var_140_3)
				end
			end

			if arg_137_1.time_ >= 0 + var_140_3 and arg_137_1.time_ < 0 + var_140_3 + arg_140_0 and not isNil(var_140_2) and arg_137_1.var_.characterEffect1027ui_story then
				arg_137_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_137_1.var_.characterEffect1027ui_story.fillRatio = 0.5
			end

			local var_140_4 = 0
			local var_140_5 = 0.825

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= var_140_4 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				arg_137_1.leftNameTxt_.text = arg_137_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_6 = arg_137_1:GetWordFromCfg(1109704034)
				local var_140_7 = arg_137_1:FormatText(var_140_6.content)

				arg_137_1.text_.text = var_140_7

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_9 = 33 <= 0 and var_140_5 or var_140_5 * (utf8.len(var_140_7) / 33)

				if (33 <= 0 and var_140_5 or var_140_5 * (utf8.len(var_140_7) / 33)) > 0 and var_140_5 < var_140_9 then
					arg_137_1.talkMaxDuration = var_140_9

					if var_140_9 + var_140_4 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_9 + var_140_4
					end
				end

				arg_137_1.text_.text = var_140_7
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704034", "story_v_side_new_1109704.awb") ~= 0 then
					local var_140_10 = manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704034", "story_v_side_new_1109704.awb") / 1000

					if var_140_10 + var_140_4 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_10 + var_140_4
					end

					if var_140_6.prefab_name ~= "" and arg_137_1.actors_[var_140_6.prefab_name] ~= nil then
						local var_140_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_137_1.actors_[var_140_6.prefab_name].transform, "story_v_side_new_1109704", "1109704034", "story_v_side_new_1109704.awb")

						arg_137_1:RecordAudio("1109704034", var_140_11)
						arg_137_1:RecordAudio("1109704034", var_140_11)
					else
						arg_137_1:AudioAction("play", "voice", "story_v_side_new_1109704", "1109704034", "story_v_side_new_1109704.awb")
					end

					arg_137_1:RecordHistoryTalkVoice("story_v_side_new_1109704", "1109704034", "story_v_side_new_1109704.awb")
				end

				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_12 = math.max(var_140_5, arg_137_1.talkMaxDuration)

			if var_140_4 <= arg_137_1.time_ and arg_137_1.time_ < var_140_4 + var_140_12 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_4) / var_140_12

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_4 + var_140_12 and arg_137_1.time_ < var_140_4 + var_140_12 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {}

		arg_137_1:InitPlayNodeList()
	end,
	Play1109704035 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 1109704035
		arg_141_1.duration_ = 3.1

		local var_141_0 = {
			zh = 2.566,
			ja = 3.1
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
				arg_141_0:Play1109704036(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 and not isNil(arg_141_1.actors_["1027ui_story"]) and arg_141_1.var_.characterEffect1027ui_story == nil then
				arg_141_1.var_.characterEffect1027ui_story = arg_141_1.actors_["1027ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_144_0 = 0.200000002980232

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_0 and not isNil(arg_141_1.actors_["1027ui_story"]) then
				if arg_141_1.var_.characterEffect1027ui_story and not isNil(arg_141_1.actors_["1027ui_story"]) then
					arg_141_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_141_1.time_ >= 0 + var_144_0 and arg_141_1.time_ < 0 + var_144_0 + arg_144_0 and not isNil(arg_141_1.actors_["1027ui_story"]) and arg_141_1.var_.characterEffect1027ui_story then
				arg_141_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action1_1")
			end

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_144_2 = arg_141_1.actors_["1097ui_story"]

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 and not isNil(var_144_2) and arg_141_1.var_.characterEffect1097ui_story == nil then
				arg_141_1.var_.characterEffect1097ui_story = var_144_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_144_3 = 0.200000002980232

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_3 and not isNil(var_144_2) then
				if arg_141_1.var_.characterEffect1097ui_story and not isNil(var_144_2) then
					arg_141_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_141_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_141_1.time_ - 0) / var_144_3)
				end
			end

			if arg_141_1.time_ >= 0 + var_144_3 and arg_141_1.time_ < 0 + var_144_3 + arg_144_0 and not isNil(var_144_2) and arg_141_1.var_.characterEffect1097ui_story then
				arg_141_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_141_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_144_4 = 0
			local var_144_5 = 0.125

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= var_144_4 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				arg_141_1.leftNameTxt_.text = arg_141_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_6 = arg_141_1:GetWordFromCfg(1109704035)
				local var_144_7 = arg_141_1:FormatText(var_144_6.content)

				arg_141_1.text_.text = var_144_7

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_9 = 5 <= 0 and var_144_5 or var_144_5 * (utf8.len(var_144_7) / 5)

				if (5 <= 0 and var_144_5 or var_144_5 * (utf8.len(var_144_7) / 5)) > 0 and var_144_5 < var_144_9 then
					arg_141_1.talkMaxDuration = var_144_9

					if var_144_9 + var_144_4 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_9 + var_144_4
					end
				end

				arg_141_1.text_.text = var_144_7
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704035", "story_v_side_new_1109704.awb") ~= 0 then
					local var_144_10 = manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704035", "story_v_side_new_1109704.awb") / 1000

					if var_144_10 + var_144_4 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_10 + var_144_4
					end

					if var_144_6.prefab_name ~= "" and arg_141_1.actors_[var_144_6.prefab_name] ~= nil then
						local var_144_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_6.prefab_name].transform, "story_v_side_new_1109704", "1109704035", "story_v_side_new_1109704.awb")

						arg_141_1:RecordAudio("1109704035", var_144_11)
						arg_141_1:RecordAudio("1109704035", var_144_11)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_side_new_1109704", "1109704035", "story_v_side_new_1109704.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_side_new_1109704", "1109704035", "story_v_side_new_1109704.awb")
				end

				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_12 = math.max(var_144_5, arg_141_1.talkMaxDuration)

			if var_144_4 <= arg_141_1.time_ and arg_141_1.time_ < var_144_4 + var_144_12 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_4) / var_144_12

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_4 + var_144_12 and arg_141_1.time_ < var_144_4 + var_144_12 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {}

		arg_141_1:InitPlayNodeList()
	end,
	Play1109704036 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 1109704036
		arg_145_1.duration_ = 5

		local var_145_0 = {
			zh = 5,
			ja = 3.066
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
				arg_145_0:Play1109704037(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 and not isNil(arg_145_1.actors_["1097ui_story"]) and arg_145_1.var_.characterEffect1097ui_story == nil then
				arg_145_1.var_.characterEffect1097ui_story = arg_145_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_148_0 = 0.200000002980232

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_0 and not isNil(arg_145_1.actors_["1097ui_story"]) then
				if arg_145_1.var_.characterEffect1097ui_story and not isNil(arg_145_1.actors_["1097ui_story"]) then
					arg_145_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_145_1.time_ >= 0 + var_148_0 and arg_145_1.time_ < 0 + var_148_0 + arg_148_0 and not isNil(arg_145_1.actors_["1097ui_story"]) and arg_145_1.var_.characterEffect1097ui_story then
				arg_145_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action6_1")
			end

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_148_2 = arg_145_1.actors_["1027ui_story"]

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 and not isNil(var_148_2) and arg_145_1.var_.characterEffect1027ui_story == nil then
				arg_145_1.var_.characterEffect1027ui_story = var_148_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_148_3 = 0.200000002980232

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_3 and not isNil(var_148_2) then
				if arg_145_1.var_.characterEffect1027ui_story and not isNil(var_148_2) then
					arg_145_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_145_1.var_.characterEffect1027ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_145_1.time_ - 0) / var_148_3)
				end
			end

			if arg_145_1.time_ >= 0 + var_148_3 and arg_145_1.time_ < 0 + var_148_3 + arg_148_0 and not isNil(var_148_2) and arg_145_1.var_.characterEffect1027ui_story then
				arg_145_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_145_1.var_.characterEffect1027ui_story.fillRatio = 0.5
			end

			local var_148_4 = 0
			local var_148_5 = 0.4

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= var_148_4 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				arg_145_1.leftNameTxt_.text = arg_145_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_6 = arg_145_1:GetWordFromCfg(1109704036)
				local var_148_7 = arg_145_1:FormatText(var_148_6.content)

				arg_145_1.text_.text = var_148_7

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_9 = 16 <= 0 and var_148_5 or var_148_5 * (utf8.len(var_148_7) / 16)

				if (16 <= 0 and var_148_5 or var_148_5 * (utf8.len(var_148_7) / 16)) > 0 and var_148_5 < var_148_9 then
					arg_145_1.talkMaxDuration = var_148_9

					if var_148_9 + var_148_4 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_9 + var_148_4
					end
				end

				arg_145_1.text_.text = var_148_7
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704036", "story_v_side_new_1109704.awb") ~= 0 then
					local var_148_10 = manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704036", "story_v_side_new_1109704.awb") / 1000

					if var_148_10 + var_148_4 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_10 + var_148_4
					end

					if var_148_6.prefab_name ~= "" and arg_145_1.actors_[var_148_6.prefab_name] ~= nil then
						local var_148_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_145_1.actors_[var_148_6.prefab_name].transform, "story_v_side_new_1109704", "1109704036", "story_v_side_new_1109704.awb")

						arg_145_1:RecordAudio("1109704036", var_148_11)
						arg_145_1:RecordAudio("1109704036", var_148_11)
					else
						arg_145_1:AudioAction("play", "voice", "story_v_side_new_1109704", "1109704036", "story_v_side_new_1109704.awb")
					end

					arg_145_1:RecordHistoryTalkVoice("story_v_side_new_1109704", "1109704036", "story_v_side_new_1109704.awb")
				end

				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_12 = math.max(var_148_5, arg_145_1.talkMaxDuration)

			if var_148_4 <= arg_145_1.time_ and arg_145_1.time_ < var_148_4 + var_148_12 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_4) / var_148_12

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_4 + var_148_12 and arg_145_1.time_ < var_148_4 + var_148_12 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {}

		arg_145_1:InitPlayNodeList()
	end,
	Play1109704037 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 1109704037
		arg_149_1.duration_ = 4.2

		local var_149_0 = {
			zh = 2.966,
			ja = 4.2
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
				arg_149_0:Play1109704038(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 and not isNil(arg_149_1.actors_["1027ui_story"]) and arg_149_1.var_.characterEffect1027ui_story == nil then
				arg_149_1.var_.characterEffect1027ui_story = arg_149_1.actors_["1027ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_152_0 = 0.200000002980232

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_0 and not isNil(arg_149_1.actors_["1027ui_story"]) then
				if arg_149_1.var_.characterEffect1027ui_story and not isNil(arg_149_1.actors_["1027ui_story"]) then
					arg_149_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_149_1.time_ >= 0 + var_152_0 and arg_149_1.time_ < 0 + var_152_0 + arg_152_0 and not isNil(arg_149_1.actors_["1027ui_story"]) and arg_149_1.var_.characterEffect1027ui_story then
				arg_149_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action2_1")
			end

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_152_2 = arg_149_1.actors_["1097ui_story"]

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 and not isNil(var_152_2) and arg_149_1.var_.characterEffect1097ui_story == nil then
				arg_149_1.var_.characterEffect1097ui_story = var_152_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_152_3 = 0.200000002980232

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_3 and not isNil(var_152_2) then
				if arg_149_1.var_.characterEffect1097ui_story and not isNil(var_152_2) then
					arg_149_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_149_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_149_1.time_ - 0) / var_152_3)
				end
			end

			if arg_149_1.time_ >= 0 + var_152_3 and arg_149_1.time_ < 0 + var_152_3 + arg_152_0 and not isNil(var_152_2) and arg_149_1.var_.characterEffect1097ui_story then
				arg_149_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_149_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_152_4 = 0
			local var_152_5 = 0.3

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= var_152_4 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				arg_149_1.leftNameTxt_.text = arg_149_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_6 = arg_149_1:GetWordFromCfg(1109704037)
				local var_152_7 = arg_149_1:FormatText(var_152_6.content)

				arg_149_1.text_.text = var_152_7

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_9 = 12 <= 0 and var_152_5 or var_152_5 * (utf8.len(var_152_7) / 12)

				if (12 <= 0 and var_152_5 or var_152_5 * (utf8.len(var_152_7) / 12)) > 0 and var_152_5 < var_152_9 then
					arg_149_1.talkMaxDuration = var_152_9

					if var_152_9 + var_152_4 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_9 + var_152_4
					end
				end

				arg_149_1.text_.text = var_152_7
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704037", "story_v_side_new_1109704.awb") ~= 0 then
					local var_152_10 = manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704037", "story_v_side_new_1109704.awb") / 1000

					if var_152_10 + var_152_4 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_10 + var_152_4
					end

					if var_152_6.prefab_name ~= "" and arg_149_1.actors_[var_152_6.prefab_name] ~= nil then
						local var_152_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_149_1.actors_[var_152_6.prefab_name].transform, "story_v_side_new_1109704", "1109704037", "story_v_side_new_1109704.awb")

						arg_149_1:RecordAudio("1109704037", var_152_11)
						arg_149_1:RecordAudio("1109704037", var_152_11)
					else
						arg_149_1:AudioAction("play", "voice", "story_v_side_new_1109704", "1109704037", "story_v_side_new_1109704.awb")
					end

					arg_149_1:RecordHistoryTalkVoice("story_v_side_new_1109704", "1109704037", "story_v_side_new_1109704.awb")
				end

				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_12 = math.max(var_152_5, arg_149_1.talkMaxDuration)

			if var_152_4 <= arg_149_1.time_ and arg_149_1.time_ < var_152_4 + var_152_12 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_4) / var_152_12

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_4 + var_152_12 and arg_149_1.time_ < var_152_4 + var_152_12 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {}

		arg_149_1:InitPlayNodeList()
	end,
	Play1109704038 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 1109704038
		arg_153_1.duration_ = 5

		SetActive(arg_153_1.tipsGo_, false)

		function arg_153_1.onSingleLineFinish_()
			arg_153_1.onSingleLineUpdate_ = nil
			arg_153_1.onSingleLineFinish_ = nil
			arg_153_1.state_ = "waiting"
		end

		function arg_153_1.playNext_(arg_155_0)
			if arg_155_0 == 1 then
				arg_153_0:Play1109704039(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1.var_.moveOldPos1027ui_story = arg_153_1.actors_["1027ui_story"].transform.localPosition
			end

			local var_156_0 = 0.001

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_0 then
				arg_153_1.actors_["1027ui_story"].transform.localPosition = Vector3.Lerp(arg_153_1.var_.moveOldPos1027ui_story, Vector3.New(0, 100, 0), (arg_153_1.time_ - 0) / var_156_0)
				arg_153_1.actors_["1027ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_153_1.actors_["1027ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_153_1.actors_["1027ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_153_1.actors_["1027ui_story"].transform.position).z)
				arg_153_1.actors_["1027ui_story"].transform.localEulerAngles.z = 0
				arg_153_1.actors_["1027ui_story"].transform.localEulerAngles.x = 0
				arg_153_1.actors_["1027ui_story"].transform.localEulerAngles = arg_153_1.actors_["1027ui_story"].transform.localEulerAngles
			end

			if arg_153_1.time_ >= 0 + var_156_0 and arg_153_1.time_ < 0 + var_156_0 + arg_156_0 then
				arg_153_1.actors_["1027ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_153_1.actors_["1027ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_153_1.actors_["1027ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_153_1.actors_["1027ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_153_1.actors_["1027ui_story"].transform.position).z)
				arg_153_1.actors_["1027ui_story"].transform.localEulerAngles.z = 0
				arg_153_1.actors_["1027ui_story"].transform.localEulerAngles.x = 0
				arg_153_1.actors_["1027ui_story"].transform.localEulerAngles = arg_153_1.actors_["1027ui_story"].transform.localEulerAngles
			end

			local var_156_1 = arg_153_1.actors_["1027ui_story"]

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 and not isNil(var_156_1) and arg_153_1.var_.characterEffect1027ui_story == nil then
				arg_153_1.var_.characterEffect1027ui_story = var_156_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_156_2 = 0.200000002980232

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_2 and not isNil(var_156_1) then
				if arg_153_1.var_.characterEffect1027ui_story and not isNil(var_156_1) then
					arg_153_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_153_1.var_.characterEffect1027ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_153_1.time_ - 0) / var_156_2)
				end
			end

			if arg_153_1.time_ >= 0 + var_156_2 and arg_153_1.time_ < 0 + var_156_2 + arg_156_0 and not isNil(var_156_1) and arg_153_1.var_.characterEffect1027ui_story then
				arg_153_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_153_1.var_.characterEffect1027ui_story.fillRatio = 0.5
			end

			local var_156_3 = arg_153_1.actors_["1097ui_story"].transform

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1.var_.moveOldPos1097ui_story = var_156_3.localPosition
			end

			local var_156_4 = 0.001

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_4 then
				var_156_3.localPosition = Vector3.Lerp(arg_153_1.var_.moveOldPos1097ui_story, Vector3.New(0, 100, 0), (arg_153_1.time_ - 0) / var_156_4)
				var_156_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_156_3.position).x, (manager.ui.mainCamera.transform.position - var_156_3.position).y, (manager.ui.mainCamera.transform.position - var_156_3.position).z)
				var_156_3.localEulerAngles.z = 0
				var_156_3.localEulerAngles.x = 0
				var_156_3.localEulerAngles = var_156_3.localEulerAngles
			end

			if arg_153_1.time_ >= 0 + var_156_4 and arg_153_1.time_ < 0 + var_156_4 + arg_156_0 then
				var_156_3.localPosition = Vector3.New(0, 100, 0)
				var_156_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_156_3.position).x, (manager.ui.mainCamera.transform.position - var_156_3.position).y, (manager.ui.mainCamera.transform.position - var_156_3.position).z)
				var_156_3.localEulerAngles.z = 0
				var_156_3.localEulerAngles.x = 0
				var_156_3.localEulerAngles = var_156_3.localEulerAngles
			end

			local var_156_5 = arg_153_1.actors_["1097ui_story"]

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 and not isNil(var_156_5) and arg_153_1.var_.characterEffect1097ui_story == nil then
				arg_153_1.var_.characterEffect1097ui_story = var_156_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_156_6 = 0.200000002980232

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_6 and not isNil(var_156_5) then
				if arg_153_1.var_.characterEffect1097ui_story and not isNil(var_156_5) then
					arg_153_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_153_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_153_1.time_ - 0) / var_156_6)
				end
			end

			if arg_153_1.time_ >= 0 + var_156_6 and arg_153_1.time_ < 0 + var_156_6 + arg_156_0 and not isNil(var_156_5) and arg_153_1.var_.characterEffect1097ui_story then
				arg_153_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_153_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_156_7 = 0
			local var_156_8 = 0.9

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= var_156_7 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, false)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_9 = arg_153_1:FormatText(arg_153_1:GetWordFromCfg(1109704038).content)

				arg_153_1.text_.text = var_156_9

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_11 = 29 <= 0 and var_156_8 or var_156_8 * (utf8.len(var_156_9) / 29)

				if (29 <= 0 and var_156_8 or var_156_8 * (utf8.len(var_156_9) / 29)) > 0 and var_156_8 < var_156_11 then
					arg_153_1.talkMaxDuration = var_156_11

					if var_156_11 + var_156_7 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_11 + var_156_7
					end
				end

				arg_153_1.text_.text = var_156_9
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)
				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_12 = math.max(var_156_8, arg_153_1.talkMaxDuration)

			if var_156_7 <= arg_153_1.time_ and arg_153_1.time_ < var_156_7 + var_156_12 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_7) / var_156_12

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_7 + var_156_12 and arg_153_1.time_ < var_156_7 + var_156_12 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1027ui_story",
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

		arg_153_1:InitPlayNodeList()
	end,
	Play1109704039 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 1109704039
		arg_157_1.duration_ = 7.6

		local var_157_0 = {
			zh = 7.6,
			ja = 7.1
		}
		local var_157_1 = manager.audio:GetLocalizationFlag()

		if var_157_0[var_157_1] ~= nil then
			arg_157_1.duration_ = var_157_0[var_157_1]
		end

		SetActive(arg_157_1.tipsGo_, false)

		function arg_157_1.onSingleLineFinish_()
			arg_157_1.onSingleLineUpdate_ = nil
			arg_157_1.onSingleLineFinish_ = nil
			arg_157_1.state_ = "waiting"
		end

		function arg_157_1.playNext_(arg_159_0)
			if arg_159_0 == 1 then
				arg_157_0:Play1109704040(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1.var_.moveOldPos1097ui_story = arg_157_1.actors_["1097ui_story"].transform.localPosition
			end

			local var_160_0 = 0.001

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_0 then
				arg_157_1.actors_["1097ui_story"].transform.localPosition = Vector3.Lerp(arg_157_1.var_.moveOldPos1097ui_story, Vector3.New(0, -0.54, -6.3), (arg_157_1.time_ - 0) / var_160_0)
				arg_157_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_157_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_157_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_157_1.actors_["1097ui_story"].transform.position).z)
				arg_157_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_157_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_157_1.actors_["1097ui_story"].transform.localEulerAngles = arg_157_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			if arg_157_1.time_ >= 0 + var_160_0 and arg_157_1.time_ < 0 + var_160_0 + arg_160_0 then
				arg_157_1.actors_["1097ui_story"].transform.localPosition = Vector3.New(0, -0.54, -6.3)
				arg_157_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_157_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_157_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_157_1.actors_["1097ui_story"].transform.position).z)
				arg_157_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_157_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_157_1.actors_["1097ui_story"].transform.localEulerAngles = arg_157_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			local var_160_1 = arg_157_1.actors_["1097ui_story"]

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 and not isNil(var_160_1) and arg_157_1.var_.characterEffect1097ui_story == nil then
				arg_157_1.var_.characterEffect1097ui_story = var_160_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_160_2 = 0.200000002980232

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_2 and not isNil(var_160_1) then
				if arg_157_1.var_.characterEffect1097ui_story and not isNil(var_160_1) then
					arg_157_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_157_1.time_ >= 0 + var_160_2 and arg_157_1.time_ < 0 + var_160_2 + arg_160_0 and not isNil(var_160_1) and arg_157_1.var_.characterEffect1097ui_story then
				arg_157_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_160_4 = 0
			local var_160_5 = 0.95

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= var_160_4 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, true)

				arg_157_1.leftNameTxt_.text = arg_157_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_6 = arg_157_1:GetWordFromCfg(1109704039)
				local var_160_7 = arg_157_1:FormatText(var_160_6.content)

				arg_157_1.text_.text = var_160_7

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_9 = 38 <= 0 and var_160_5 or var_160_5 * (utf8.len(var_160_7) / 38)

				if (38 <= 0 and var_160_5 or var_160_5 * (utf8.len(var_160_7) / 38)) > 0 and var_160_5 < var_160_9 then
					arg_157_1.talkMaxDuration = var_160_9

					if var_160_9 + var_160_4 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_9 + var_160_4
					end
				end

				arg_157_1.text_.text = var_160_7
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704039", "story_v_side_new_1109704.awb") ~= 0 then
					local var_160_10 = manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704039", "story_v_side_new_1109704.awb") / 1000

					if var_160_10 + var_160_4 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_10 + var_160_4
					end

					if var_160_6.prefab_name ~= "" and arg_157_1.actors_[var_160_6.prefab_name] ~= nil then
						local var_160_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_157_1.actors_[var_160_6.prefab_name].transform, "story_v_side_new_1109704", "1109704039", "story_v_side_new_1109704.awb")

						arg_157_1:RecordAudio("1109704039", var_160_11)
						arg_157_1:RecordAudio("1109704039", var_160_11)
					else
						arg_157_1:AudioAction("play", "voice", "story_v_side_new_1109704", "1109704039", "story_v_side_new_1109704.awb")
					end

					arg_157_1:RecordHistoryTalkVoice("story_v_side_new_1109704", "1109704039", "story_v_side_new_1109704.awb")
				end

				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_12 = math.max(var_160_5, arg_157_1.talkMaxDuration)

			if var_160_4 <= arg_157_1.time_ and arg_157_1.time_ < var_160_4 + var_160_12 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_4) / var_160_12

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_4 + var_160_12 and arg_157_1.time_ < var_160_4 + var_160_12 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {
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

		arg_157_1:InitPlayNodeList()
	end,
	Play1109704040 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 1109704040
		arg_161_1.duration_ = 5

		SetActive(arg_161_1.tipsGo_, false)

		function arg_161_1.onSingleLineFinish_()
			arg_161_1.onSingleLineUpdate_ = nil
			arg_161_1.onSingleLineFinish_ = nil
			arg_161_1.state_ = "waiting"
		end

		function arg_161_1.playNext_(arg_163_0)
			if arg_163_0 == 1 then
				arg_161_0:Play1109704041(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 and not isNil(arg_161_1.actors_["1097ui_story"]) and arg_161_1.var_.characterEffect1097ui_story == nil then
				arg_161_1.var_.characterEffect1097ui_story = arg_161_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_164_0 = 0.200000002980232

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_0 and not isNil(arg_161_1.actors_["1097ui_story"]) then
				if arg_161_1.var_.characterEffect1097ui_story and not isNil(arg_161_1.actors_["1097ui_story"]) then
					arg_161_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_161_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_161_1.time_ - 0) / var_164_0)
				end
			end

			if arg_161_1.time_ >= 0 + var_164_0 and arg_161_1.time_ < 0 + var_164_0 + arg_164_0 and not isNil(arg_161_1.actors_["1097ui_story"]) and arg_161_1.var_.characterEffect1097ui_story then
				arg_161_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_161_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_164_1 = 0
			local var_164_2 = 0.225

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= var_164_1 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				arg_161_1.leftNameTxt_.text = arg_161_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, true)
				arg_161_1.iconController_:SetSelectedState("hero")

				arg_161_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_161_1.callingController_:SetSelectedState("normal")

				arg_161_1.keyicon_.color = Color.New(1, 1, 1)
				arg_161_1.icon_.color = Color.New(1, 1, 1)

				local var_164_3 = arg_161_1:FormatText(arg_161_1:GetWordFromCfg(1109704040).content)

				arg_161_1.text_.text = var_164_3

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_5 = 9 <= 0 and var_164_2 or var_164_2 * (utf8.len(var_164_3) / 9)

				if (9 <= 0 and var_164_2 or var_164_2 * (utf8.len(var_164_3) / 9)) > 0 and var_164_2 < var_164_5 then
					arg_161_1.talkMaxDuration = var_164_5

					if var_164_5 + var_164_1 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_5 + var_164_1
					end
				end

				arg_161_1.text_.text = var_164_3
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)
				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_6 = math.max(var_164_2, arg_161_1.talkMaxDuration)

			if var_164_1 <= arg_161_1.time_ and arg_161_1.time_ < var_164_1 + var_164_6 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - var_164_1) / var_164_6

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= var_164_1 + var_164_6 and arg_161_1.time_ < var_164_1 + var_164_6 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {}

		arg_161_1:InitPlayNodeList()
	end,
	Play1109704041 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 1109704041
		arg_165_1.duration_ = 5

		SetActive(arg_165_1.tipsGo_, false)

		function arg_165_1.onSingleLineFinish_()
			arg_165_1.onSingleLineUpdate_ = nil
			arg_165_1.onSingleLineFinish_ = nil
			arg_165_1.state_ = "waiting"
		end

		function arg_165_1.playNext_(arg_167_0)
			if arg_167_0 == 1 then
				arg_165_0:Play1109704042(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			local var_168_0 = 1.025

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, false)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_1 = arg_165_1:FormatText(arg_165_1:GetWordFromCfg(1109704041).content)

				arg_165_1.text_.text = var_168_1

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_3 = 41 <= 0 and var_168_0 or var_168_0 * (utf8.len(var_168_1) / 41)

				if (41 <= 0 and var_168_0 or var_168_0 * (utf8.len(var_168_1) / 41)) > 0 and var_168_0 < var_168_3 then
					arg_165_1.talkMaxDuration = var_168_3

					if var_168_3 + 0 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_3 + 0
					end
				end

				arg_165_1.text_.text = var_168_1
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)
				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_4 = math.max(var_168_0, arg_165_1.talkMaxDuration)

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_4 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - 0) / var_168_4

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= 0 + var_168_4 and arg_165_1.time_ < 0 + var_168_4 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {}

		arg_165_1:InitPlayNodeList()
	end,
	Play1109704042 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 1109704042
		arg_169_1.duration_ = 3.7

		local var_169_0 = {
			zh = 3.7,
			ja = 3.533
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
				arg_169_0:Play1109704043(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 and not isNil(arg_169_1.actors_["1097ui_story"]) and arg_169_1.var_.characterEffect1097ui_story == nil then
				arg_169_1.var_.characterEffect1097ui_story = arg_169_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_172_0 = 0.200000002980232

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_0 and not isNil(arg_169_1.actors_["1097ui_story"]) then
				if arg_169_1.var_.characterEffect1097ui_story and not isNil(arg_169_1.actors_["1097ui_story"]) then
					arg_169_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_169_1.time_ >= 0 + var_172_0 and arg_169_1.time_ < 0 + var_172_0 + arg_172_0 and not isNil(arg_169_1.actors_["1097ui_story"]) and arg_169_1.var_.characterEffect1097ui_story then
				arg_169_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_172_2 = 0
			local var_172_3 = 0.65

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= var_172_2 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, true)

				arg_169_1.leftNameTxt_.text = arg_169_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_4 = arg_169_1:GetWordFromCfg(1109704042)
				local var_172_5 = arg_169_1:FormatText(var_172_4.content)

				arg_169_1.text_.text = var_172_5

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_7 = 26 <= 0 and var_172_3 or var_172_3 * (utf8.len(var_172_5) / 26)

				if (26 <= 0 and var_172_3 or var_172_3 * (utf8.len(var_172_5) / 26)) > 0 and var_172_3 < var_172_7 then
					arg_169_1.talkMaxDuration = var_172_7

					if var_172_7 + var_172_2 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_7 + var_172_2
					end
				end

				arg_169_1.text_.text = var_172_5
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704042", "story_v_side_new_1109704.awb") ~= 0 then
					local var_172_8 = manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704042", "story_v_side_new_1109704.awb") / 1000

					if var_172_8 + var_172_2 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_8 + var_172_2
					end

					if var_172_4.prefab_name ~= "" and arg_169_1.actors_[var_172_4.prefab_name] ~= nil then
						local var_172_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_169_1.actors_[var_172_4.prefab_name].transform, "story_v_side_new_1109704", "1109704042", "story_v_side_new_1109704.awb")

						arg_169_1:RecordAudio("1109704042", var_172_9)
						arg_169_1:RecordAudio("1109704042", var_172_9)
					else
						arg_169_1:AudioAction("play", "voice", "story_v_side_new_1109704", "1109704042", "story_v_side_new_1109704.awb")
					end

					arg_169_1:RecordHistoryTalkVoice("story_v_side_new_1109704", "1109704042", "story_v_side_new_1109704.awb")
				end

				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_10 = math.max(var_172_3, arg_169_1.talkMaxDuration)

			if var_172_2 <= arg_169_1.time_ and arg_169_1.time_ < var_172_2 + var_172_10 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_2) / var_172_10

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_2 + var_172_10 and arg_169_1.time_ < var_172_2 + var_172_10 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {}

		arg_169_1:InitPlayNodeList()
	end,
	Play1109704043 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 1109704043
		arg_173_1.duration_ = 5

		SetActive(arg_173_1.tipsGo_, false)

		function arg_173_1.onSingleLineFinish_()
			arg_173_1.onSingleLineUpdate_ = nil
			arg_173_1.onSingleLineFinish_ = nil
			arg_173_1.state_ = "waiting"
		end

		function arg_173_1.playNext_(arg_175_0)
			if arg_175_0 == 1 then
				arg_173_0:Play1109704044(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 and not isNil(arg_173_1.actors_["1097ui_story"]) and arg_173_1.var_.characterEffect1097ui_story == nil then
				arg_173_1.var_.characterEffect1097ui_story = arg_173_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_176_0 = 0.200000002980232

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_0 and not isNil(arg_173_1.actors_["1097ui_story"]) then
				if arg_173_1.var_.characterEffect1097ui_story and not isNil(arg_173_1.actors_["1097ui_story"]) then
					arg_173_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_173_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_173_1.time_ - 0) / var_176_0)
				end
			end

			if arg_173_1.time_ >= 0 + var_176_0 and arg_173_1.time_ < 0 + var_176_0 + arg_176_0 and not isNil(arg_173_1.actors_["1097ui_story"]) and arg_173_1.var_.characterEffect1097ui_story then
				arg_173_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_173_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_176_1 = 0
			local var_176_2 = 0.4

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= var_176_1 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, true)

				arg_173_1.leftNameTxt_.text = arg_173_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_173_1.leftNameTxt_.transform)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1.leftNameTxt_.text)
				SetActive(arg_173_1.iconTrs_.gameObject, true)
				arg_173_1.iconController_:SetSelectedState("hero")

				arg_173_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_173_1.callingController_:SetSelectedState("normal")

				arg_173_1.keyicon_.color = Color.New(1, 1, 1)
				arg_173_1.icon_.color = Color.New(1, 1, 1)

				local var_176_3 = arg_173_1:FormatText(arg_173_1:GetWordFromCfg(1109704043).content)

				arg_173_1.text_.text = var_176_3

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_5 = 16 <= 0 and var_176_2 or var_176_2 * (utf8.len(var_176_3) / 16)

				if (16 <= 0 and var_176_2 or var_176_2 * (utf8.len(var_176_3) / 16)) > 0 and var_176_2 < var_176_5 then
					arg_173_1.talkMaxDuration = var_176_5

					if var_176_5 + var_176_1 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_5 + var_176_1
					end
				end

				arg_173_1.text_.text = var_176_3
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)
				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_6 = math.max(var_176_2, arg_173_1.talkMaxDuration)

			if var_176_1 <= arg_173_1.time_ and arg_173_1.time_ < var_176_1 + var_176_6 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - var_176_1) / var_176_6

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= var_176_1 + var_176_6 and arg_173_1.time_ < var_176_1 + var_176_6 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {}

		arg_173_1:InitPlayNodeList()
	end,
	Play1109704044 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 1109704044
		arg_177_1.duration_ = 5.13

		local var_177_0 = {
			zh = 4.433,
			ja = 5.133
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
				arg_177_0:Play1109704045(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 and not isNil(arg_177_1.actors_["1097ui_story"]) and arg_177_1.var_.characterEffect1097ui_story == nil then
				arg_177_1.var_.characterEffect1097ui_story = arg_177_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_180_0 = 0.200000002980232

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_0 and not isNil(arg_177_1.actors_["1097ui_story"]) then
				if arg_177_1.var_.characterEffect1097ui_story and not isNil(arg_177_1.actors_["1097ui_story"]) then
					arg_177_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_177_1.time_ >= 0 + var_180_0 and arg_177_1.time_ < 0 + var_180_0 + arg_180_0 and not isNil(arg_177_1.actors_["1097ui_story"]) and arg_177_1.var_.characterEffect1097ui_story then
				arg_177_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_180_2 = 0
			local var_180_3 = 0.475

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= var_180_2 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				arg_177_1.leftNameTxt_.text = arg_177_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_4 = arg_177_1:GetWordFromCfg(1109704044)
				local var_180_5 = arg_177_1:FormatText(var_180_4.content)

				arg_177_1.text_.text = var_180_5

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_7 = 19 <= 0 and var_180_3 or var_180_3 * (utf8.len(var_180_5) / 19)

				if (19 <= 0 and var_180_3 or var_180_3 * (utf8.len(var_180_5) / 19)) > 0 and var_180_3 < var_180_7 then
					arg_177_1.talkMaxDuration = var_180_7

					if var_180_7 + var_180_2 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_7 + var_180_2
					end
				end

				arg_177_1.text_.text = var_180_5
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704044", "story_v_side_new_1109704.awb") ~= 0 then
					local var_180_8 = manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704044", "story_v_side_new_1109704.awb") / 1000

					if var_180_8 + var_180_2 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_8 + var_180_2
					end

					if var_180_4.prefab_name ~= "" and arg_177_1.actors_[var_180_4.prefab_name] ~= nil then
						local var_180_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_177_1.actors_[var_180_4.prefab_name].transform, "story_v_side_new_1109704", "1109704044", "story_v_side_new_1109704.awb")

						arg_177_1:RecordAudio("1109704044", var_180_9)
						arg_177_1:RecordAudio("1109704044", var_180_9)
					else
						arg_177_1:AudioAction("play", "voice", "story_v_side_new_1109704", "1109704044", "story_v_side_new_1109704.awb")
					end

					arg_177_1:RecordHistoryTalkVoice("story_v_side_new_1109704", "1109704044", "story_v_side_new_1109704.awb")
				end

				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_10 = math.max(var_180_3, arg_177_1.talkMaxDuration)

			if var_180_2 <= arg_177_1.time_ and arg_177_1.time_ < var_180_2 + var_180_10 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - var_180_2) / var_180_10

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= var_180_2 + var_180_10 and arg_177_1.time_ < var_180_2 + var_180_10 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {}

		arg_177_1:InitPlayNodeList()
	end,
	Play1109704045 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 1109704045
		arg_181_1.duration_ = 5

		SetActive(arg_181_1.tipsGo_, false)

		function arg_181_1.onSingleLineFinish_()
			arg_181_1.onSingleLineUpdate_ = nil
			arg_181_1.onSingleLineFinish_ = nil
			arg_181_1.state_ = "waiting"
		end

		function arg_181_1.playNext_(arg_183_0)
			if arg_183_0 == 1 then
				arg_181_0:Play1109704046(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 and not isNil(arg_181_1.actors_["1097ui_story"]) and arg_181_1.var_.characterEffect1097ui_story == nil then
				arg_181_1.var_.characterEffect1097ui_story = arg_181_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_184_0 = 0.200000002980232

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_0 and not isNil(arg_181_1.actors_["1097ui_story"]) then
				if arg_181_1.var_.characterEffect1097ui_story and not isNil(arg_181_1.actors_["1097ui_story"]) then
					arg_181_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_181_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_181_1.time_ - 0) / var_184_0)
				end
			end

			if arg_181_1.time_ >= 0 + var_184_0 and arg_181_1.time_ < 0 + var_184_0 + arg_184_0 and not isNil(arg_181_1.actors_["1097ui_story"]) and arg_181_1.var_.characterEffect1097ui_story then
				arg_181_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_181_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_184_1 = 0
			local var_184_2 = 1.05

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= var_184_1 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				arg_181_1.leftNameTxt_.text = arg_181_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, true)
				arg_181_1.iconController_:SetSelectedState("hero")

				arg_181_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_181_1.callingController_:SetSelectedState("normal")

				arg_181_1.keyicon_.color = Color.New(1, 1, 1)
				arg_181_1.icon_.color = Color.New(1, 1, 1)

				local var_184_3 = arg_181_1:FormatText(arg_181_1:GetWordFromCfg(1109704045).content)

				arg_181_1.text_.text = var_184_3

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_5 = 42 <= 0 and var_184_2 or var_184_2 * (utf8.len(var_184_3) / 42)

				if (42 <= 0 and var_184_2 or var_184_2 * (utf8.len(var_184_3) / 42)) > 0 and var_184_2 < var_184_5 then
					arg_181_1.talkMaxDuration = var_184_5

					if var_184_5 + var_184_1 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_5 + var_184_1
					end
				end

				arg_181_1.text_.text = var_184_3
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)
				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_6 = math.max(var_184_2, arg_181_1.talkMaxDuration)

			if var_184_1 <= arg_181_1.time_ and arg_181_1.time_ < var_184_1 + var_184_6 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_1) / var_184_6

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_1 + var_184_6 and arg_181_1.time_ < var_184_1 + var_184_6 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {}

		arg_181_1:InitPlayNodeList()
	end,
	Play1109704046 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 1109704046
		arg_185_1.duration_ = 9.97

		local var_185_0 = {
			zh = 2.766,
			ja = 9.966
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
				arg_185_0:Play1109704047(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 and not isNil(arg_185_1.actors_["1097ui_story"]) and arg_185_1.var_.characterEffect1097ui_story == nil then
				arg_185_1.var_.characterEffect1097ui_story = arg_185_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_188_0 = 0.200000002980232

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_0 and not isNil(arg_185_1.actors_["1097ui_story"]) then
				if arg_185_1.var_.characterEffect1097ui_story and not isNil(arg_185_1.actors_["1097ui_story"]) then
					arg_185_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_185_1.time_ >= 0 + var_188_0 and arg_185_1.time_ < 0 + var_188_0 + arg_188_0 and not isNil(arg_185_1.actors_["1097ui_story"]) and arg_185_1.var_.characterEffect1097ui_story then
				arg_185_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 then
				arg_185_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action6_1")
			end

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 then
				arg_185_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_188_2 = 0
			local var_188_3 = 0.3

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= var_188_2 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, true)

				arg_185_1.leftNameTxt_.text = arg_185_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_4 = arg_185_1:GetWordFromCfg(1109704046)
				local var_188_5 = arg_185_1:FormatText(var_188_4.content)

				arg_185_1.text_.text = var_188_5

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_7 = 12 <= 0 and var_188_3 or var_188_3 * (utf8.len(var_188_5) / 12)

				if (12 <= 0 and var_188_3 or var_188_3 * (utf8.len(var_188_5) / 12)) > 0 and var_188_3 < var_188_7 then
					arg_185_1.talkMaxDuration = var_188_7

					if var_188_7 + var_188_2 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_7 + var_188_2
					end
				end

				arg_185_1.text_.text = var_188_5
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704046", "story_v_side_new_1109704.awb") ~= 0 then
					local var_188_8 = manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704046", "story_v_side_new_1109704.awb") / 1000

					if var_188_8 + var_188_2 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_8 + var_188_2
					end

					if var_188_4.prefab_name ~= "" and arg_185_1.actors_[var_188_4.prefab_name] ~= nil then
						local var_188_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_185_1.actors_[var_188_4.prefab_name].transform, "story_v_side_new_1109704", "1109704046", "story_v_side_new_1109704.awb")

						arg_185_1:RecordAudio("1109704046", var_188_9)
						arg_185_1:RecordAudio("1109704046", var_188_9)
					else
						arg_185_1:AudioAction("play", "voice", "story_v_side_new_1109704", "1109704046", "story_v_side_new_1109704.awb")
					end

					arg_185_1:RecordHistoryTalkVoice("story_v_side_new_1109704", "1109704046", "story_v_side_new_1109704.awb")
				end

				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_10 = math.max(var_188_3, arg_185_1.talkMaxDuration)

			if var_188_2 <= arg_185_1.time_ and arg_185_1.time_ < var_188_2 + var_188_10 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_2) / var_188_10

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_2 + var_188_10 and arg_185_1.time_ < var_188_2 + var_188_10 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {}

		arg_185_1:InitPlayNodeList()
	end,
	Play1109704047 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 1109704047
		arg_189_1.duration_ = 5

		SetActive(arg_189_1.tipsGo_, false)

		function arg_189_1.onSingleLineFinish_()
			arg_189_1.onSingleLineUpdate_ = nil
			arg_189_1.onSingleLineFinish_ = nil
			arg_189_1.state_ = "waiting"
		end

		function arg_189_1.playNext_(arg_191_0)
			if arg_191_0 == 1 then
				arg_189_0:Play1109704048(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 and not isNil(arg_189_1.actors_["1097ui_story"]) and arg_189_1.var_.characterEffect1097ui_story == nil then
				arg_189_1.var_.characterEffect1097ui_story = arg_189_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_192_0 = 0.200000002980232

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_0 and not isNil(arg_189_1.actors_["1097ui_story"]) then
				if arg_189_1.var_.characterEffect1097ui_story and not isNil(arg_189_1.actors_["1097ui_story"]) then
					arg_189_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_189_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_189_1.time_ - 0) / var_192_0)
				end
			end

			if arg_189_1.time_ >= 0 + var_192_0 and arg_189_1.time_ < 0 + var_192_0 + arg_192_0 and not isNil(arg_189_1.actors_["1097ui_story"]) and arg_189_1.var_.characterEffect1097ui_story then
				arg_189_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_189_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_192_1 = 0
			local var_192_2 = 0.9

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= var_192_1 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, false)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_3 = arg_189_1:FormatText(arg_189_1:GetWordFromCfg(1109704047).content)

				arg_189_1.text_.text = var_192_3

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_5 = 36 <= 0 and var_192_2 or var_192_2 * (utf8.len(var_192_3) / 36)

				if (36 <= 0 and var_192_2 or var_192_2 * (utf8.len(var_192_3) / 36)) > 0 and var_192_2 < var_192_5 then
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
	Play1109704048 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 1109704048
		arg_193_1.duration_ = 5

		SetActive(arg_193_1.tipsGo_, false)

		function arg_193_1.onSingleLineFinish_()
			arg_193_1.onSingleLineUpdate_ = nil
			arg_193_1.onSingleLineFinish_ = nil
			arg_193_1.state_ = "waiting"
		end

		function arg_193_1.playNext_(arg_195_0)
			if arg_195_0 == 1 then
				arg_193_0:Play1109704049(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			local var_196_0 = 0.725

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, true)

				arg_193_1.leftNameTxt_.text = arg_193_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_193_1.leftNameTxt_.transform)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1.leftNameTxt_.text)
				SetActive(arg_193_1.iconTrs_.gameObject, true)
				arg_193_1.iconController_:SetSelectedState("hero")

				arg_193_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_193_1.callingController_:SetSelectedState("normal")

				arg_193_1.keyicon_.color = Color.New(1, 1, 1)
				arg_193_1.icon_.color = Color.New(1, 1, 1)

				local var_196_1 = arg_193_1:FormatText(arg_193_1:GetWordFromCfg(1109704048).content)

				arg_193_1.text_.text = var_196_1

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_3 = 29 <= 0 and var_196_0 or var_196_0 * (utf8.len(var_196_1) / 29)

				if (29 <= 0 and var_196_0 or var_196_0 * (utf8.len(var_196_1) / 29)) > 0 and var_196_0 < var_196_3 then
					arg_193_1.talkMaxDuration = var_196_3

					if var_196_3 + 0 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_3 + 0
					end
				end

				arg_193_1.text_.text = var_196_1
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)
				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_4 = math.max(var_196_0, arg_193_1.talkMaxDuration)

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_4 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - 0) / var_196_4

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= 0 + var_196_4 and arg_193_1.time_ < 0 + var_196_4 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {}

		arg_193_1:InitPlayNodeList()
	end,
	Play1109704049 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 1109704049
		arg_197_1.duration_ = 4.03

		local var_197_0 = {
			zh = 4.033,
			ja = 4
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
				arg_197_0:Play1109704050(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				arg_197_1.var_.moveOldPos1097ui_story = arg_197_1.actors_["1097ui_story"].transform.localPosition
			end

			local var_200_0 = 0.001

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_0 then
				arg_197_1.actors_["1097ui_story"].transform.localPosition = Vector3.Lerp(arg_197_1.var_.moveOldPos1097ui_story, Vector3.New(0, -0.54, -6.3), (arg_197_1.time_ - 0) / var_200_0)
				arg_197_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_197_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_197_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_197_1.actors_["1097ui_story"].transform.position).z)
				arg_197_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_197_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_197_1.actors_["1097ui_story"].transform.localEulerAngles = arg_197_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			if arg_197_1.time_ >= 0 + var_200_0 and arg_197_1.time_ < 0 + var_200_0 + arg_200_0 then
				arg_197_1.actors_["1097ui_story"].transform.localPosition = Vector3.New(0, -0.54, -6.3)
				arg_197_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_197_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_197_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_197_1.actors_["1097ui_story"].transform.position).z)
				arg_197_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_197_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_197_1.actors_["1097ui_story"].transform.localEulerAngles = arg_197_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			local var_200_1 = arg_197_1.actors_["1097ui_story"]

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 and not isNil(var_200_1) and arg_197_1.var_.characterEffect1097ui_story == nil then
				arg_197_1.var_.characterEffect1097ui_story = var_200_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_200_2 = 0.200000002980232

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_2 and not isNil(var_200_1) then
				if arg_197_1.var_.characterEffect1097ui_story and not isNil(var_200_1) then
					arg_197_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_197_1.time_ >= 0 + var_200_2 and arg_197_1.time_ < 0 + var_200_2 + arg_200_0 and not isNil(var_200_1) and arg_197_1.var_.characterEffect1097ui_story then
				arg_197_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				arg_197_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action6_2")
			end

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				arg_197_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva")
			end

			local var_200_4 = 0
			local var_200_5 = 0.3

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= var_200_4 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, true)

				arg_197_1.leftNameTxt_.text = arg_197_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, false)
				arg_197_1.callingController_:SetSelectedState("normal")

				local var_200_6 = arg_197_1:GetWordFromCfg(1109704049)
				local var_200_7 = arg_197_1:FormatText(var_200_6.content)

				arg_197_1.text_.text = var_200_7

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_9 = 12 <= 0 and var_200_5 or var_200_5 * (utf8.len(var_200_7) / 12)

				if (12 <= 0 and var_200_5 or var_200_5 * (utf8.len(var_200_7) / 12)) > 0 and var_200_5 < var_200_9 then
					arg_197_1.talkMaxDuration = var_200_9

					if var_200_9 + var_200_4 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_9 + var_200_4
					end
				end

				arg_197_1.text_.text = var_200_7
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704049", "story_v_side_new_1109704.awb") ~= 0 then
					local var_200_10 = manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704049", "story_v_side_new_1109704.awb") / 1000

					if var_200_10 + var_200_4 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_10 + var_200_4
					end

					if var_200_6.prefab_name ~= "" and arg_197_1.actors_[var_200_6.prefab_name] ~= nil then
						local var_200_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_197_1.actors_[var_200_6.prefab_name].transform, "story_v_side_new_1109704", "1109704049", "story_v_side_new_1109704.awb")

						arg_197_1:RecordAudio("1109704049", var_200_11)
						arg_197_1:RecordAudio("1109704049", var_200_11)
					else
						arg_197_1:AudioAction("play", "voice", "story_v_side_new_1109704", "1109704049", "story_v_side_new_1109704.awb")
					end

					arg_197_1:RecordHistoryTalkVoice("story_v_side_new_1109704", "1109704049", "story_v_side_new_1109704.awb")
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

		arg_197_1.nodeConfigList_ = {
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

		arg_197_1:InitPlayNodeList()
	end,
	Play1109704050 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 1109704050
		arg_201_1.duration_ = 5

		SetActive(arg_201_1.tipsGo_, false)

		function arg_201_1.onSingleLineFinish_()
			arg_201_1.onSingleLineUpdate_ = nil
			arg_201_1.onSingleLineFinish_ = nil
			arg_201_1.state_ = "waiting"
		end

		function arg_201_1.playNext_(arg_203_0)
			if arg_203_0 == 1 then
				arg_201_0:Play1109704051(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 and not isNil(arg_201_1.actors_["1097ui_story"]) and arg_201_1.var_.characterEffect1097ui_story == nil then
				arg_201_1.var_.characterEffect1097ui_story = arg_201_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_204_0 = 0.200000002980232

			if 0 <= arg_201_1.time_ and arg_201_1.time_ < 0 + var_204_0 and not isNil(arg_201_1.actors_["1097ui_story"]) then
				if arg_201_1.var_.characterEffect1097ui_story and not isNil(arg_201_1.actors_["1097ui_story"]) then
					arg_201_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_201_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_201_1.time_ - 0) / var_204_0)
				end
			end

			if arg_201_1.time_ >= 0 + var_204_0 and arg_201_1.time_ < 0 + var_204_0 + arg_204_0 and not isNil(arg_201_1.actors_["1097ui_story"]) and arg_201_1.var_.characterEffect1097ui_story then
				arg_201_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_201_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_204_1 = 0
			local var_204_2 = 0.625

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= var_204_1 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, false)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_201_1.iconTrs_.gameObject, false)
				arg_201_1.callingController_:SetSelectedState("normal")

				local var_204_3 = arg_201_1:FormatText(arg_201_1:GetWordFromCfg(1109704050).content)

				arg_201_1.text_.text = var_204_3

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_5 = 25 <= 0 and var_204_2 or var_204_2 * (utf8.len(var_204_3) / 25)

				if (25 <= 0 and var_204_2 or var_204_2 * (utf8.len(var_204_3) / 25)) > 0 and var_204_2 < var_204_5 then
					arg_201_1.talkMaxDuration = var_204_5

					if var_204_5 + var_204_1 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_5 + var_204_1
					end
				end

				arg_201_1.text_.text = var_204_3
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)
				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_6 = math.max(var_204_2, arg_201_1.talkMaxDuration)

			if var_204_1 <= arg_201_1.time_ and arg_201_1.time_ < var_204_1 + var_204_6 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - var_204_1) / var_204_6

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= var_204_1 + var_204_6 and arg_201_1.time_ < var_204_1 + var_204_6 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {}

		arg_201_1:InitPlayNodeList()
	end,
	Play1109704051 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 1109704051
		arg_205_1.duration_ = 5

		SetActive(arg_205_1.tipsGo_, false)

		function arg_205_1.onSingleLineFinish_()
			arg_205_1.onSingleLineUpdate_ = nil
			arg_205_1.onSingleLineFinish_ = nil
			arg_205_1.state_ = "waiting"
		end

		function arg_205_1.playNext_(arg_207_0)
			if arg_207_0 == 1 then
				arg_205_0:Play1109704052(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			local var_208_0 = 0.55

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, false)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_205_1.iconTrs_.gameObject, false)
				arg_205_1.callingController_:SetSelectedState("normal")

				local var_208_1 = arg_205_1:FormatText(arg_205_1:GetWordFromCfg(1109704051).content)

				arg_205_1.text_.text = var_208_1

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_3 = 22 <= 0 and var_208_0 or var_208_0 * (utf8.len(var_208_1) / 22)

				if (22 <= 0 and var_208_0 or var_208_0 * (utf8.len(var_208_1) / 22)) > 0 and var_208_0 < var_208_3 then
					arg_205_1.talkMaxDuration = var_208_3

					if var_208_3 + 0 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_3 + 0
					end
				end

				arg_205_1.text_.text = var_208_1
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)
				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_4 = math.max(var_208_0, arg_205_1.talkMaxDuration)

			if 0 <= arg_205_1.time_ and arg_205_1.time_ < 0 + var_208_4 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - 0) / var_208_4

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= 0 + var_208_4 and arg_205_1.time_ < 0 + var_208_4 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {}

		arg_205_1:InitPlayNodeList()
	end,
	Play1109704052 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 1109704052
		arg_209_1.duration_ = 7.13

		local var_209_0 = {
			zh = 2.933,
			ja = 7.133
		}
		local var_209_1 = manager.audio:GetLocalizationFlag()

		if var_209_0[var_209_1] ~= nil then
			arg_209_1.duration_ = var_209_0[var_209_1]
		end

		SetActive(arg_209_1.tipsGo_, false)

		function arg_209_1.onSingleLineFinish_()
			arg_209_1.onSingleLineUpdate_ = nil
			arg_209_1.onSingleLineFinish_ = nil
			arg_209_1.state_ = "waiting"
		end

		function arg_209_1.playNext_(arg_211_0)
			if arg_211_0 == 1 then
				arg_209_0:Play1109704053(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1.var_.moveOldPos1097ui_story = arg_209_1.actors_["1097ui_story"].transform.localPosition
			end

			local var_212_0 = 0.001

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_0 then
				arg_209_1.actors_["1097ui_story"].transform.localPosition = Vector3.Lerp(arg_209_1.var_.moveOldPos1097ui_story, Vector3.New(-0.7, -0.54, -6.3), (arg_209_1.time_ - 0) / var_212_0)
				arg_209_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_209_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_209_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_209_1.actors_["1097ui_story"].transform.position).z)
				arg_209_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_209_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_209_1.actors_["1097ui_story"].transform.localEulerAngles = arg_209_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			if arg_209_1.time_ >= 0 + var_212_0 and arg_209_1.time_ < 0 + var_212_0 + arg_212_0 then
				arg_209_1.actors_["1097ui_story"].transform.localPosition = Vector3.New(-0.7, -0.54, -6.3)
				arg_209_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_209_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_209_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_209_1.actors_["1097ui_story"].transform.position).z)
				arg_209_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_209_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_209_1.actors_["1097ui_story"].transform.localEulerAngles = arg_209_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			local var_212_1 = arg_209_1.actors_["1027ui_story"].transform

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1.var_.moveOldPos1027ui_story = var_212_1.localPosition
			end

			local var_212_2 = 0.001

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_2 then
				var_212_1.localPosition = Vector3.Lerp(arg_209_1.var_.moveOldPos1027ui_story, Vector3.New(0.7, -0.81, -5.8), (arg_209_1.time_ - 0) / var_212_2)
				var_212_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_212_1.position).x, (manager.ui.mainCamera.transform.position - var_212_1.position).y, (manager.ui.mainCamera.transform.position - var_212_1.position).z)
				var_212_1.localEulerAngles.z = 0
				var_212_1.localEulerAngles.x = 0
				var_212_1.localEulerAngles = var_212_1.localEulerAngles
			end

			if arg_209_1.time_ >= 0 + var_212_2 and arg_209_1.time_ < 0 + var_212_2 + arg_212_0 then
				var_212_1.localPosition = Vector3.New(0.7, -0.81, -5.8)
				var_212_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_212_1.position).x, (manager.ui.mainCamera.transform.position - var_212_1.position).y, (manager.ui.mainCamera.transform.position - var_212_1.position).z)
				var_212_1.localEulerAngles.z = 0
				var_212_1.localEulerAngles.x = 0
				var_212_1.localEulerAngles = var_212_1.localEulerAngles
			end

			local var_212_3 = arg_209_1.actors_["1027ui_story"]

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 and not isNil(var_212_3) and arg_209_1.var_.characterEffect1027ui_story == nil then
				arg_209_1.var_.characterEffect1027ui_story = var_212_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_212_4 = 0.200000002980232

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_4 and not isNil(var_212_3) then
				if arg_209_1.var_.characterEffect1027ui_story and not isNil(var_212_3) then
					arg_209_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_209_1.time_ >= 0 + var_212_4 and arg_209_1.time_ < 0 + var_212_4 + arg_212_0 and not isNil(var_212_3) and arg_209_1.var_.characterEffect1027ui_story then
				arg_209_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action1_1")
			end

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_212_6 = 0
			local var_212_7 = 0.375

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= var_212_6 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, true)

				arg_209_1.leftNameTxt_.text = arg_209_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_209_1.leftNameTxt_.transform)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1.leftNameTxt_.text)
				SetActive(arg_209_1.iconTrs_.gameObject, false)
				arg_209_1.callingController_:SetSelectedState("normal")

				local var_212_8 = arg_209_1:GetWordFromCfg(1109704052)
				local var_212_9 = arg_209_1:FormatText(var_212_8.content)

				arg_209_1.text_.text = var_212_9

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_11 = 15 <= 0 and var_212_7 or var_212_7 * (utf8.len(var_212_9) / 15)

				if (15 <= 0 and var_212_7 or var_212_7 * (utf8.len(var_212_9) / 15)) > 0 and var_212_7 < var_212_11 then
					arg_209_1.talkMaxDuration = var_212_11

					if var_212_11 + var_212_6 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_11 + var_212_6
					end
				end

				arg_209_1.text_.text = var_212_9
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704052", "story_v_side_new_1109704.awb") ~= 0 then
					local var_212_12 = manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704052", "story_v_side_new_1109704.awb") / 1000

					if var_212_12 + var_212_6 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_12 + var_212_6
					end

					if var_212_8.prefab_name ~= "" and arg_209_1.actors_[var_212_8.prefab_name] ~= nil then
						local var_212_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_209_1.actors_[var_212_8.prefab_name].transform, "story_v_side_new_1109704", "1109704052", "story_v_side_new_1109704.awb")

						arg_209_1:RecordAudio("1109704052", var_212_13)
						arg_209_1:RecordAudio("1109704052", var_212_13)
					else
						arg_209_1:AudioAction("play", "voice", "story_v_side_new_1109704", "1109704052", "story_v_side_new_1109704.awb")
					end

					arg_209_1:RecordHistoryTalkVoice("story_v_side_new_1109704", "1109704052", "story_v_side_new_1109704.awb")
				end

				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_14 = math.max(var_212_7, arg_209_1.talkMaxDuration)

			if var_212_6 <= arg_209_1.time_ and arg_209_1.time_ < var_212_6 + var_212_14 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - var_212_6) / var_212_14

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= var_212_6 + var_212_14 and arg_209_1.time_ < var_212_6 + var_212_14 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {
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
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_209_1:InitPlayNodeList()
	end,
	Play1109704053 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 1109704053
		arg_213_1.duration_ = 6.2

		local var_213_0 = {
			zh = 3.7,
			ja = 6.2
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
				arg_213_0:Play1109704054(arg_213_1)
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
				arg_213_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action7_1")
			end

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 then
				arg_213_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_216_2 = arg_213_1.actors_["1027ui_story"]

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 and not isNil(var_216_2) and arg_213_1.var_.characterEffect1027ui_story == nil then
				arg_213_1.var_.characterEffect1027ui_story = var_216_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_216_3 = 0.200000002980232

			if 0 <= arg_213_1.time_ and arg_213_1.time_ < 0 + var_216_3 and not isNil(var_216_2) then
				if arg_213_1.var_.characterEffect1027ui_story and not isNil(var_216_2) then
					arg_213_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_213_1.var_.characterEffect1027ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_213_1.time_ - 0) / var_216_3)
				end
			end

			if arg_213_1.time_ >= 0 + var_216_3 and arg_213_1.time_ < 0 + var_216_3 + arg_216_0 and not isNil(var_216_2) and arg_213_1.var_.characterEffect1027ui_story then
				arg_213_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_213_1.var_.characterEffect1027ui_story.fillRatio = 0.5
			end

			local var_216_4 = 0
			local var_216_5 = 0.425

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= var_216_4 + arg_216_0 then
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

				local var_216_6 = arg_213_1:GetWordFromCfg(1109704053)
				local var_216_7 = arg_213_1:FormatText(var_216_6.content)

				arg_213_1.text_.text = var_216_7

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_9 = 17 <= 0 and var_216_5 or var_216_5 * (utf8.len(var_216_7) / 17)

				if (17 <= 0 and var_216_5 or var_216_5 * (utf8.len(var_216_7) / 17)) > 0 and var_216_5 < var_216_9 then
					arg_213_1.talkMaxDuration = var_216_9

					if var_216_9 + var_216_4 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_9 + var_216_4
					end
				end

				arg_213_1.text_.text = var_216_7
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704053", "story_v_side_new_1109704.awb") ~= 0 then
					local var_216_10 = manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704053", "story_v_side_new_1109704.awb") / 1000

					if var_216_10 + var_216_4 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_10 + var_216_4
					end

					if var_216_6.prefab_name ~= "" and arg_213_1.actors_[var_216_6.prefab_name] ~= nil then
						local var_216_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_213_1.actors_[var_216_6.prefab_name].transform, "story_v_side_new_1109704", "1109704053", "story_v_side_new_1109704.awb")

						arg_213_1:RecordAudio("1109704053", var_216_11)
						arg_213_1:RecordAudio("1109704053", var_216_11)
					else
						arg_213_1:AudioAction("play", "voice", "story_v_side_new_1109704", "1109704053", "story_v_side_new_1109704.awb")
					end

					arg_213_1:RecordHistoryTalkVoice("story_v_side_new_1109704", "1109704053", "story_v_side_new_1109704.awb")
				end

				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_12 = math.max(var_216_5, arg_213_1.talkMaxDuration)

			if var_216_4 <= arg_213_1.time_ and arg_213_1.time_ < var_216_4 + var_216_12 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - var_216_4) / var_216_12

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= var_216_4 + var_216_12 and arg_213_1.time_ < var_216_4 + var_216_12 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {}

		arg_213_1:InitPlayNodeList()
	end,
	Play1109704054 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 1109704054
		arg_217_1.duration_ = 5

		SetActive(arg_217_1.tipsGo_, false)

		function arg_217_1.onSingleLineFinish_()
			arg_217_1.onSingleLineUpdate_ = nil
			arg_217_1.onSingleLineFinish_ = nil
			arg_217_1.state_ = "waiting"
		end

		function arg_217_1.playNext_(arg_219_0)
			if arg_219_0 == 1 then
				arg_217_0:Play1109704055(arg_217_1)
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

			local var_220_1 = 0
			local var_220_2 = 0.375

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

				local var_220_3 = arg_217_1:FormatText(arg_217_1:GetWordFromCfg(1109704054).content)

				arg_217_1.text_.text = var_220_3

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_5 = 15 <= 0 and var_220_2 or var_220_2 * (utf8.len(var_220_3) / 15)

				if (15 <= 0 and var_220_2 or var_220_2 * (utf8.len(var_220_3) / 15)) > 0 and var_220_2 < var_220_5 then
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
	Play1109704055 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 1109704055
		arg_221_1.duration_ = 4.8

		local var_221_0 = {
			zh = 4.8,
			ja = 4.633
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
				arg_221_0:Play1109704056(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 and not isNil(arg_221_1.actors_["1027ui_story"]) and arg_221_1.var_.characterEffect1027ui_story == nil then
				arg_221_1.var_.characterEffect1027ui_story = arg_221_1.actors_["1027ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_224_0 = 0.200000002980232

			if 0 <= arg_221_1.time_ and arg_221_1.time_ < 0 + var_224_0 and not isNil(arg_221_1.actors_["1027ui_story"]) then
				if arg_221_1.var_.characterEffect1027ui_story and not isNil(arg_221_1.actors_["1027ui_story"]) then
					arg_221_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_221_1.time_ >= 0 + var_224_0 and arg_221_1.time_ < 0 + var_224_0 + arg_224_0 and not isNil(arg_221_1.actors_["1027ui_story"]) and arg_221_1.var_.characterEffect1027ui_story then
				arg_221_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 then
				arg_221_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action2_1")
			end

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 then
				arg_221_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_224_2 = 0
			local var_224_3 = 0.525

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= var_224_2 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, true)

				arg_221_1.leftNameTxt_.text = arg_221_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_221_1.leftNameTxt_.transform)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1.leftNameTxt_.text)
				SetActive(arg_221_1.iconTrs_.gameObject, false)
				arg_221_1.callingController_:SetSelectedState("normal")

				local var_224_4 = arg_221_1:GetWordFromCfg(1109704055)
				local var_224_5 = arg_221_1:FormatText(var_224_4.content)

				arg_221_1.text_.text = var_224_5

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_7 = 21 <= 0 and var_224_3 or var_224_3 * (utf8.len(var_224_5) / 21)

				if (21 <= 0 and var_224_3 or var_224_3 * (utf8.len(var_224_5) / 21)) > 0 and var_224_3 < var_224_7 then
					arg_221_1.talkMaxDuration = var_224_7

					if var_224_7 + var_224_2 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_7 + var_224_2
					end
				end

				arg_221_1.text_.text = var_224_5
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704055", "story_v_side_new_1109704.awb") ~= 0 then
					local var_224_8 = manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704055", "story_v_side_new_1109704.awb") / 1000

					if var_224_8 + var_224_2 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_8 + var_224_2
					end

					if var_224_4.prefab_name ~= "" and arg_221_1.actors_[var_224_4.prefab_name] ~= nil then
						local var_224_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_221_1.actors_[var_224_4.prefab_name].transform, "story_v_side_new_1109704", "1109704055", "story_v_side_new_1109704.awb")

						arg_221_1:RecordAudio("1109704055", var_224_9)
						arg_221_1:RecordAudio("1109704055", var_224_9)
					else
						arg_221_1:AudioAction("play", "voice", "story_v_side_new_1109704", "1109704055", "story_v_side_new_1109704.awb")
					end

					arg_221_1:RecordHistoryTalkVoice("story_v_side_new_1109704", "1109704055", "story_v_side_new_1109704.awb")
				end

				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_10 = math.max(var_224_3, arg_221_1.talkMaxDuration)

			if var_224_2 <= arg_221_1.time_ and arg_221_1.time_ < var_224_2 + var_224_10 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - var_224_2) / var_224_10

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= var_224_2 + var_224_10 and arg_221_1.time_ < var_224_2 + var_224_10 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end

		arg_221_1.nodeConfigList_ = {}

		arg_221_1:InitPlayNodeList()
	end,
	Play1109704056 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 1109704056
		arg_225_1.duration_ = 5

		SetActive(arg_225_1.tipsGo_, false)

		function arg_225_1.onSingleLineFinish_()
			arg_225_1.onSingleLineUpdate_ = nil
			arg_225_1.onSingleLineFinish_ = nil
			arg_225_1.state_ = "waiting"
		end

		function arg_225_1.playNext_(arg_227_0)
			if arg_227_0 == 1 then
				arg_225_0:Play1109704057(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 and not isNil(arg_225_1.actors_["1027ui_story"]) and arg_225_1.var_.characterEffect1027ui_story == nil then
				arg_225_1.var_.characterEffect1027ui_story = arg_225_1.actors_["1027ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_228_0 = 0.200000002980232

			if 0 <= arg_225_1.time_ and arg_225_1.time_ < 0 + var_228_0 and not isNil(arg_225_1.actors_["1027ui_story"]) then
				if arg_225_1.var_.characterEffect1027ui_story and not isNil(arg_225_1.actors_["1027ui_story"]) then
					arg_225_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_225_1.var_.characterEffect1027ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_225_1.time_ - 0) / var_228_0)
				end
			end

			if arg_225_1.time_ >= 0 + var_228_0 and arg_225_1.time_ < 0 + var_228_0 + arg_228_0 and not isNil(arg_225_1.actors_["1027ui_story"]) and arg_225_1.var_.characterEffect1027ui_story then
				arg_225_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_225_1.var_.characterEffect1027ui_story.fillRatio = 0.5
			end

			local var_228_1 = 0
			local var_228_2 = 0.3

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= var_228_1 + arg_228_0 then
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

				local var_228_3 = arg_225_1:FormatText(arg_225_1:GetWordFromCfg(1109704056).content)

				arg_225_1.text_.text = var_228_3

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_5 = 12 <= 0 and var_228_2 or var_228_2 * (utf8.len(var_228_3) / 12)

				if (12 <= 0 and var_228_2 or var_228_2 * (utf8.len(var_228_3) / 12)) > 0 and var_228_2 < var_228_5 then
					arg_225_1.talkMaxDuration = var_228_5

					if var_228_5 + var_228_1 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_5 + var_228_1
					end
				end

				arg_225_1.text_.text = var_228_3
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)
				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_6 = math.max(var_228_2, arg_225_1.talkMaxDuration)

			if var_228_1 <= arg_225_1.time_ and arg_225_1.time_ < var_228_1 + var_228_6 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - var_228_1) / var_228_6

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= var_228_1 + var_228_6 and arg_225_1.time_ < var_228_1 + var_228_6 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {}

		arg_225_1:InitPlayNodeList()
	end,
	Play1109704057 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 1109704057
		arg_229_1.duration_ = 2

		SetActive(arg_229_1.tipsGo_, false)

		function arg_229_1.onSingleLineFinish_()
			arg_229_1.onSingleLineUpdate_ = nil
			arg_229_1.onSingleLineFinish_ = nil
			arg_229_1.state_ = "waiting"
		end

		function arg_229_1.playNext_(arg_231_0)
			if arg_231_0 == 1 then
				arg_229_0:Play1109704058(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 and not isNil(arg_229_1.actors_["1027ui_story"]) and arg_229_1.var_.characterEffect1027ui_story == nil then
				arg_229_1.var_.characterEffect1027ui_story = arg_229_1.actors_["1027ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_232_0 = 0.200000002980232

			if 0 <= arg_229_1.time_ and arg_229_1.time_ < 0 + var_232_0 and not isNil(arg_229_1.actors_["1027ui_story"]) then
				if arg_229_1.var_.characterEffect1027ui_story and not isNil(arg_229_1.actors_["1027ui_story"]) then
					arg_229_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_229_1.time_ >= 0 + var_232_0 and arg_229_1.time_ < 0 + var_232_0 + arg_232_0 and not isNil(arg_229_1.actors_["1027ui_story"]) and arg_229_1.var_.characterEffect1027ui_story then
				arg_229_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 then
				arg_229_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action2_2")
			end

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 then
				arg_229_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_232_2 = 0
			local var_232_3 = 0.1

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= var_232_2 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, true)

				arg_229_1.leftNameTxt_.text = arg_229_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_229_1.leftNameTxt_.transform)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1.leftNameTxt_.text)
				SetActive(arg_229_1.iconTrs_.gameObject, false)
				arg_229_1.callingController_:SetSelectedState("normal")

				local var_232_4 = arg_229_1:GetWordFromCfg(1109704057)
				local var_232_5 = arg_229_1:FormatText(var_232_4.content)

				arg_229_1.text_.text = var_232_5

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_7 = 4 <= 0 and var_232_3 or var_232_3 * (utf8.len(var_232_5) / 4)

				if (4 <= 0 and var_232_3 or var_232_3 * (utf8.len(var_232_5) / 4)) > 0 and var_232_3 < var_232_7 then
					arg_229_1.talkMaxDuration = var_232_7

					if var_232_7 + var_232_2 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_7 + var_232_2
					end
				end

				arg_229_1.text_.text = var_232_5
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704057", "story_v_side_new_1109704.awb") ~= 0 then
					local var_232_8 = manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704057", "story_v_side_new_1109704.awb") / 1000

					if var_232_8 + var_232_2 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_8 + var_232_2
					end

					if var_232_4.prefab_name ~= "" and arg_229_1.actors_[var_232_4.prefab_name] ~= nil then
						local var_232_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_229_1.actors_[var_232_4.prefab_name].transform, "story_v_side_new_1109704", "1109704057", "story_v_side_new_1109704.awb")

						arg_229_1:RecordAudio("1109704057", var_232_9)
						arg_229_1:RecordAudio("1109704057", var_232_9)
					else
						arg_229_1:AudioAction("play", "voice", "story_v_side_new_1109704", "1109704057", "story_v_side_new_1109704.awb")
					end

					arg_229_1:RecordHistoryTalkVoice("story_v_side_new_1109704", "1109704057", "story_v_side_new_1109704.awb")
				end

				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_10 = math.max(var_232_3, arg_229_1.talkMaxDuration)

			if var_232_2 <= arg_229_1.time_ and arg_229_1.time_ < var_232_2 + var_232_10 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - var_232_2) / var_232_10

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= var_232_2 + var_232_10 and arg_229_1.time_ < var_232_2 + var_232_10 + arg_232_0 then
				arg_229_1.typewritter.percent = 1

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(true)
			end
		end

		arg_229_1.nodeConfigList_ = {}

		arg_229_1:InitPlayNodeList()
	end,
	Play1109704058 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 1109704058
		arg_233_1.duration_ = 6.93

		local var_233_0 = {
			zh = 5.7,
			ja = 6.933
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
				arg_233_0:Play1109704059(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 and not isNil(arg_233_1.actors_["1097ui_story"]) and arg_233_1.var_.characterEffect1097ui_story == nil then
				arg_233_1.var_.characterEffect1097ui_story = arg_233_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_236_0 = 0.200000002980232

			if 0 <= arg_233_1.time_ and arg_233_1.time_ < 0 + var_236_0 and not isNil(arg_233_1.actors_["1097ui_story"]) then
				if arg_233_1.var_.characterEffect1097ui_story and not isNil(arg_233_1.actors_["1097ui_story"]) then
					arg_233_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_233_1.time_ >= 0 + var_236_0 and arg_233_1.time_ < 0 + var_236_0 + arg_236_0 and not isNil(arg_233_1.actors_["1097ui_story"]) and arg_233_1.var_.characterEffect1097ui_story then
				arg_233_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 then
				arg_233_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action7_2")
			end

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 then
				arg_233_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_236_2 = arg_233_1.actors_["1027ui_story"]

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 and not isNil(var_236_2) and arg_233_1.var_.characterEffect1027ui_story == nil then
				arg_233_1.var_.characterEffect1027ui_story = var_236_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_236_3 = 0.200000002980232

			if 0 <= arg_233_1.time_ and arg_233_1.time_ < 0 + var_236_3 and not isNil(var_236_2) then
				if arg_233_1.var_.characterEffect1027ui_story and not isNil(var_236_2) then
					arg_233_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_233_1.var_.characterEffect1027ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_233_1.time_ - 0) / var_236_3)
				end
			end

			if arg_233_1.time_ >= 0 + var_236_3 and arg_233_1.time_ < 0 + var_236_3 + arg_236_0 and not isNil(var_236_2) and arg_233_1.var_.characterEffect1027ui_story then
				arg_233_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_233_1.var_.characterEffect1027ui_story.fillRatio = 0.5
			end

			local var_236_4 = 0
			local var_236_5 = 0.775

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= var_236_4 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0
				arg_233_1.dialogCg_.alpha = 1

				arg_233_1.dialog_:SetActive(true)
				SetActive(arg_233_1.leftNameGo_, true)

				arg_233_1.leftNameTxt_.text = arg_233_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_233_1.leftNameTxt_.transform)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1.leftNameTxt_.text)
				SetActive(arg_233_1.iconTrs_.gameObject, false)
				arg_233_1.callingController_:SetSelectedState("normal")

				local var_236_6 = arg_233_1:GetWordFromCfg(1109704058)
				local var_236_7 = arg_233_1:FormatText(var_236_6.content)

				arg_233_1.text_.text = var_236_7

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_9 = 31 <= 0 and var_236_5 or var_236_5 * (utf8.len(var_236_7) / 31)

				if (31 <= 0 and var_236_5 or var_236_5 * (utf8.len(var_236_7) / 31)) > 0 and var_236_5 < var_236_9 then
					arg_233_1.talkMaxDuration = var_236_9

					if var_236_9 + var_236_4 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_9 + var_236_4
					end
				end

				arg_233_1.text_.text = var_236_7
				arg_233_1.typewritter.percent = 0

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704058", "story_v_side_new_1109704.awb") ~= 0 then
					local var_236_10 = manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704058", "story_v_side_new_1109704.awb") / 1000

					if var_236_10 + var_236_4 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_10 + var_236_4
					end

					if var_236_6.prefab_name ~= "" and arg_233_1.actors_[var_236_6.prefab_name] ~= nil then
						local var_236_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_233_1.actors_[var_236_6.prefab_name].transform, "story_v_side_new_1109704", "1109704058", "story_v_side_new_1109704.awb")

						arg_233_1:RecordAudio("1109704058", var_236_11)
						arg_233_1:RecordAudio("1109704058", var_236_11)
					else
						arg_233_1:AudioAction("play", "voice", "story_v_side_new_1109704", "1109704058", "story_v_side_new_1109704.awb")
					end

					arg_233_1:RecordHistoryTalkVoice("story_v_side_new_1109704", "1109704058", "story_v_side_new_1109704.awb")
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
	Play1109704059 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 1109704059
		arg_237_1.duration_ = 5

		SetActive(arg_237_1.tipsGo_, false)

		function arg_237_1.onSingleLineFinish_()
			arg_237_1.onSingleLineUpdate_ = nil
			arg_237_1.onSingleLineFinish_ = nil
			arg_237_1.state_ = "waiting"
		end

		function arg_237_1.playNext_(arg_239_0)
			if arg_239_0 == 1 then
				arg_237_0:Play1109704060(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 and not isNil(arg_237_1.actors_["1097ui_story"]) and arg_237_1.var_.characterEffect1097ui_story == nil then
				arg_237_1.var_.characterEffect1097ui_story = arg_237_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_240_0 = 0.200000002980232

			if 0 <= arg_237_1.time_ and arg_237_1.time_ < 0 + var_240_0 and not isNil(arg_237_1.actors_["1097ui_story"]) then
				if arg_237_1.var_.characterEffect1097ui_story and not isNil(arg_237_1.actors_["1097ui_story"]) then
					arg_237_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_237_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_237_1.time_ - 0) / var_240_0)
				end
			end

			if arg_237_1.time_ >= 0 + var_240_0 and arg_237_1.time_ < 0 + var_240_0 + arg_240_0 and not isNil(arg_237_1.actors_["1097ui_story"]) and arg_237_1.var_.characterEffect1097ui_story then
				arg_237_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_237_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_240_1 = 0
			local var_240_2 = 0.55

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= var_240_1 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0
				arg_237_1.dialogCg_.alpha = 1

				arg_237_1.dialog_:SetActive(true)
				SetActive(arg_237_1.leftNameGo_, true)

				arg_237_1.leftNameTxt_.text = arg_237_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_237_1.leftNameTxt_.transform)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1.leftNameTxt_.text)
				SetActive(arg_237_1.iconTrs_.gameObject, true)
				arg_237_1.iconController_:SetSelectedState("hero")

				arg_237_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_237_1.callingController_:SetSelectedState("normal")

				arg_237_1.keyicon_.color = Color.New(1, 1, 1)
				arg_237_1.icon_.color = Color.New(1, 1, 1)

				local var_240_3 = arg_237_1:FormatText(arg_237_1:GetWordFromCfg(1109704059).content)

				arg_237_1.text_.text = var_240_3

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_5 = 22 <= 0 and var_240_2 or var_240_2 * (utf8.len(var_240_3) / 22)

				if (22 <= 0 and var_240_2 or var_240_2 * (utf8.len(var_240_3) / 22)) > 0 and var_240_2 < var_240_5 then
					arg_237_1.talkMaxDuration = var_240_5

					if var_240_5 + var_240_1 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_5 + var_240_1
					end
				end

				arg_237_1.text_.text = var_240_3
				arg_237_1.typewritter.percent = 0

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(false)
				arg_237_1:RecordContent(arg_237_1.text_.text)
			end

			local var_240_6 = math.max(var_240_2, arg_237_1.talkMaxDuration)

			if var_240_1 <= arg_237_1.time_ and arg_237_1.time_ < var_240_1 + var_240_6 then
				arg_237_1.typewritter.percent = (arg_237_1.time_ - var_240_1) / var_240_6

				arg_237_1.typewritter:SetDirty()
			end

			if arg_237_1.time_ >= var_240_1 + var_240_6 and arg_237_1.time_ < var_240_1 + var_240_6 + arg_240_0 then
				arg_237_1.typewritter.percent = 1

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(true)
			end
		end

		arg_237_1.nodeConfigList_ = {}

		arg_237_1:InitPlayNodeList()
	end,
	Play1109704060 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 1109704060
		arg_241_1.duration_ = 5.1

		local var_241_0 = {
			zh = 3.5,
			ja = 5.1
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
				arg_241_0:Play1109704061(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 and not isNil(arg_241_1.actors_["1097ui_story"]) and arg_241_1.var_.characterEffect1097ui_story == nil then
				arg_241_1.var_.characterEffect1097ui_story = arg_241_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_244_0 = 0.200000002980232

			if 0 <= arg_241_1.time_ and arg_241_1.time_ < 0 + var_244_0 and not isNil(arg_241_1.actors_["1097ui_story"]) then
				if arg_241_1.var_.characterEffect1097ui_story and not isNil(arg_241_1.actors_["1097ui_story"]) then
					arg_241_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_241_1.time_ >= 0 + var_244_0 and arg_241_1.time_ < 0 + var_244_0 + arg_244_0 and not isNil(arg_241_1.actors_["1097ui_story"]) and arg_241_1.var_.characterEffect1097ui_story then
				arg_241_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 then
				arg_241_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 then
				arg_241_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_244_2 = 0
			local var_244_3 = 0.575

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= var_244_2 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0
				arg_241_1.dialogCg_.alpha = 1

				arg_241_1.dialog_:SetActive(true)
				SetActive(arg_241_1.leftNameGo_, true)

				arg_241_1.leftNameTxt_.text = arg_241_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_241_1.leftNameTxt_.transform)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1.leftNameTxt_.text)
				SetActive(arg_241_1.iconTrs_.gameObject, false)
				arg_241_1.callingController_:SetSelectedState("normal")

				local var_244_4 = arg_241_1:GetWordFromCfg(1109704060)
				local var_244_5 = arg_241_1:FormatText(var_244_4.content)

				arg_241_1.text_.text = var_244_5

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_7 = 23 <= 0 and var_244_3 or var_244_3 * (utf8.len(var_244_5) / 23)

				if (23 <= 0 and var_244_3 or var_244_3 * (utf8.len(var_244_5) / 23)) > 0 and var_244_3 < var_244_7 then
					arg_241_1.talkMaxDuration = var_244_7

					if var_244_7 + var_244_2 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_7 + var_244_2
					end
				end

				arg_241_1.text_.text = var_244_5
				arg_241_1.typewritter.percent = 0

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704060", "story_v_side_new_1109704.awb") ~= 0 then
					local var_244_8 = manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704060", "story_v_side_new_1109704.awb") / 1000

					if var_244_8 + var_244_2 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_8 + var_244_2
					end

					if var_244_4.prefab_name ~= "" and arg_241_1.actors_[var_244_4.prefab_name] ~= nil then
						local var_244_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_241_1.actors_[var_244_4.prefab_name].transform, "story_v_side_new_1109704", "1109704060", "story_v_side_new_1109704.awb")

						arg_241_1:RecordAudio("1109704060", var_244_9)
						arg_241_1:RecordAudio("1109704060", var_244_9)
					else
						arg_241_1:AudioAction("play", "voice", "story_v_side_new_1109704", "1109704060", "story_v_side_new_1109704.awb")
					end

					arg_241_1:RecordHistoryTalkVoice("story_v_side_new_1109704", "1109704060", "story_v_side_new_1109704.awb")
				end

				arg_241_1:RecordContent(arg_241_1.text_.text)
			end

			local var_244_10 = math.max(var_244_3, arg_241_1.talkMaxDuration)

			if var_244_2 <= arg_241_1.time_ and arg_241_1.time_ < var_244_2 + var_244_10 then
				arg_241_1.typewritter.percent = (arg_241_1.time_ - var_244_2) / var_244_10

				arg_241_1.typewritter:SetDirty()
			end

			if arg_241_1.time_ >= var_244_2 + var_244_10 and arg_241_1.time_ < var_244_2 + var_244_10 + arg_244_0 then
				arg_241_1.typewritter.percent = 1

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(true)
			end
		end

		arg_241_1.nodeConfigList_ = {}

		arg_241_1:InitPlayNodeList()
	end,
	Play1109704061 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 1109704061
		arg_245_1.duration_ = 5

		SetActive(arg_245_1.tipsGo_, false)

		function arg_245_1.onSingleLineFinish_()
			arg_245_1.onSingleLineUpdate_ = nil
			arg_245_1.onSingleLineFinish_ = nil
			arg_245_1.state_ = "waiting"
		end

		function arg_245_1.playNext_(arg_247_0)
			if arg_247_0 == 1 then
				arg_245_0:Play1109704062(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 and not isNil(arg_245_1.actors_["1097ui_story"]) and arg_245_1.var_.characterEffect1097ui_story == nil then
				arg_245_1.var_.characterEffect1097ui_story = arg_245_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_248_0 = 0.200000002980232

			if 0 <= arg_245_1.time_ and arg_245_1.time_ < 0 + var_248_0 and not isNil(arg_245_1.actors_["1097ui_story"]) then
				if arg_245_1.var_.characterEffect1097ui_story and not isNil(arg_245_1.actors_["1097ui_story"]) then
					arg_245_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_245_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_245_1.time_ - 0) / var_248_0)
				end
			end

			if arg_245_1.time_ >= 0 + var_248_0 and arg_245_1.time_ < 0 + var_248_0 + arg_248_0 and not isNil(arg_245_1.actors_["1097ui_story"]) and arg_245_1.var_.characterEffect1097ui_story then
				arg_245_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_245_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_248_1 = 0
			local var_248_2 = 0.7

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= var_248_1 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0
				arg_245_1.dialogCg_.alpha = 1

				arg_245_1.dialog_:SetActive(true)
				SetActive(arg_245_1.leftNameGo_, true)

				arg_245_1.leftNameTxt_.text = arg_245_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_245_1.leftNameTxt_.transform)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1.leftNameTxt_.text)
				SetActive(arg_245_1.iconTrs_.gameObject, true)
				arg_245_1.iconController_:SetSelectedState("hero")

				arg_245_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_245_1.callingController_:SetSelectedState("normal")

				arg_245_1.keyicon_.color = Color.New(1, 1, 1)
				arg_245_1.icon_.color = Color.New(1, 1, 1)

				local var_248_3 = arg_245_1:FormatText(arg_245_1:GetWordFromCfg(1109704061).content)

				arg_245_1.text_.text = var_248_3

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_5 = 28 <= 0 and var_248_2 or var_248_2 * (utf8.len(var_248_3) / 28)

				if (28 <= 0 and var_248_2 or var_248_2 * (utf8.len(var_248_3) / 28)) > 0 and var_248_2 < var_248_5 then
					arg_245_1.talkMaxDuration = var_248_5

					if var_248_5 + var_248_1 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_5 + var_248_1
					end
				end

				arg_245_1.text_.text = var_248_3
				arg_245_1.typewritter.percent = 0

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(false)
				arg_245_1:RecordContent(arg_245_1.text_.text)
			end

			local var_248_6 = math.max(var_248_2, arg_245_1.talkMaxDuration)

			if var_248_1 <= arg_245_1.time_ and arg_245_1.time_ < var_248_1 + var_248_6 then
				arg_245_1.typewritter.percent = (arg_245_1.time_ - var_248_1) / var_248_6

				arg_245_1.typewritter:SetDirty()
			end

			if arg_245_1.time_ >= var_248_1 + var_248_6 and arg_245_1.time_ < var_248_1 + var_248_6 + arg_248_0 then
				arg_245_1.typewritter.percent = 1

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(true)
			end
		end

		arg_245_1.nodeConfigList_ = {}

		arg_245_1:InitPlayNodeList()
	end,
	Play1109704062 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 1109704062
		arg_249_1.duration_ = 2.83

		local var_249_0 = {
			zh = 1.999999999999,
			ja = 2.833
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
				arg_249_0:Play1109704063(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 and not isNil(arg_249_1.actors_["1097ui_story"]) and arg_249_1.var_.characterEffect1097ui_story == nil then
				arg_249_1.var_.characterEffect1097ui_story = arg_249_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_252_0 = 0.200000002980232

			if 0 <= arg_249_1.time_ and arg_249_1.time_ < 0 + var_252_0 and not isNil(arg_249_1.actors_["1097ui_story"]) then
				if arg_249_1.var_.characterEffect1097ui_story and not isNil(arg_249_1.actors_["1097ui_story"]) then
					arg_249_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_249_1.time_ >= 0 + var_252_0 and arg_249_1.time_ < 0 + var_252_0 + arg_252_0 and not isNil(arg_249_1.actors_["1097ui_story"]) and arg_249_1.var_.characterEffect1097ui_story then
				arg_249_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 then
				arg_249_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 then
				arg_249_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_252_2 = 0
			local var_252_3 = 0.1

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= var_252_2 + arg_252_0 then
				arg_249_1.talkMaxDuration = 0
				arg_249_1.dialogCg_.alpha = 1

				arg_249_1.dialog_:SetActive(true)
				SetActive(arg_249_1.leftNameGo_, true)

				arg_249_1.leftNameTxt_.text = arg_249_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_249_1.leftNameTxt_.transform)

				arg_249_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_249_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_249_1:RecordName(arg_249_1.leftNameTxt_.text)
				SetActive(arg_249_1.iconTrs_.gameObject, false)
				arg_249_1.callingController_:SetSelectedState("normal")

				local var_252_4 = arg_249_1:GetWordFromCfg(1109704062)
				local var_252_5 = arg_249_1:FormatText(var_252_4.content)

				arg_249_1.text_.text = var_252_5

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_7 = 4 <= 0 and var_252_3 or var_252_3 * (utf8.len(var_252_5) / 4)

				if (4 <= 0 and var_252_3 or var_252_3 * (utf8.len(var_252_5) / 4)) > 0 and var_252_3 < var_252_7 then
					arg_249_1.talkMaxDuration = var_252_7

					if var_252_7 + var_252_2 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_7 + var_252_2
					end
				end

				arg_249_1.text_.text = var_252_5
				arg_249_1.typewritter.percent = 0

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704062", "story_v_side_new_1109704.awb") ~= 0 then
					local var_252_8 = manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704062", "story_v_side_new_1109704.awb") / 1000

					if var_252_8 + var_252_2 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_8 + var_252_2
					end

					if var_252_4.prefab_name ~= "" and arg_249_1.actors_[var_252_4.prefab_name] ~= nil then
						local var_252_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_249_1.actors_[var_252_4.prefab_name].transform, "story_v_side_new_1109704", "1109704062", "story_v_side_new_1109704.awb")

						arg_249_1:RecordAudio("1109704062", var_252_9)
						arg_249_1:RecordAudio("1109704062", var_252_9)
					else
						arg_249_1:AudioAction("play", "voice", "story_v_side_new_1109704", "1109704062", "story_v_side_new_1109704.awb")
					end

					arg_249_1:RecordHistoryTalkVoice("story_v_side_new_1109704", "1109704062", "story_v_side_new_1109704.awb")
				end

				arg_249_1:RecordContent(arg_249_1.text_.text)
			end

			local var_252_10 = math.max(var_252_3, arg_249_1.talkMaxDuration)

			if var_252_2 <= arg_249_1.time_ and arg_249_1.time_ < var_252_2 + var_252_10 then
				arg_249_1.typewritter.percent = (arg_249_1.time_ - var_252_2) / var_252_10

				arg_249_1.typewritter:SetDirty()
			end

			if arg_249_1.time_ >= var_252_2 + var_252_10 and arg_249_1.time_ < var_252_2 + var_252_10 + arg_252_0 then
				arg_249_1.typewritter.percent = 1

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(true)
			end
		end

		arg_249_1.nodeConfigList_ = {}

		arg_249_1:InitPlayNodeList()
	end,
	Play1109704063 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 1109704063
		arg_253_1.duration_ = 5

		SetActive(arg_253_1.tipsGo_, false)

		function arg_253_1.onSingleLineFinish_()
			arg_253_1.onSingleLineUpdate_ = nil
			arg_253_1.onSingleLineFinish_ = nil
			arg_253_1.state_ = "waiting"
		end

		function arg_253_1.playNext_(arg_255_0)
			if arg_255_0 == 1 then
				arg_253_0:Play1109704064(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 and not isNil(arg_253_1.actors_["1097ui_story"]) and arg_253_1.var_.characterEffect1097ui_story == nil then
				arg_253_1.var_.characterEffect1097ui_story = arg_253_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_256_0 = 0.200000002980232

			if 0 <= arg_253_1.time_ and arg_253_1.time_ < 0 + var_256_0 and not isNil(arg_253_1.actors_["1097ui_story"]) then
				if arg_253_1.var_.characterEffect1097ui_story and not isNil(arg_253_1.actors_["1097ui_story"]) then
					arg_253_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_253_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_253_1.time_ - 0) / var_256_0)
				end
			end

			if arg_253_1.time_ >= 0 + var_256_0 and arg_253_1.time_ < 0 + var_256_0 + arg_256_0 and not isNil(arg_253_1.actors_["1097ui_story"]) and arg_253_1.var_.characterEffect1097ui_story then
				arg_253_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_253_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_256_1 = 0
			local var_256_2 = 0.95

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= var_256_1 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, false)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_253_1.iconTrs_.gameObject, false)
				arg_253_1.callingController_:SetSelectedState("normal")

				local var_256_3 = arg_253_1:FormatText(arg_253_1:GetWordFromCfg(1109704063).content)

				arg_253_1.text_.text = var_256_3

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_5 = 38 <= 0 and var_256_2 or var_256_2 * (utf8.len(var_256_3) / 38)

				if (38 <= 0 and var_256_2 or var_256_2 * (utf8.len(var_256_3) / 38)) > 0 and var_256_2 < var_256_5 then
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
	Play1109704064 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 1109704064
		arg_257_1.duration_ = 7

		SetActive(arg_257_1.tipsGo_, false)

		function arg_257_1.onSingleLineFinish_()
			arg_257_1.onSingleLineUpdate_ = nil
			arg_257_1.onSingleLineFinish_ = nil
			arg_257_1.state_ = "waiting"
		end

		function arg_257_1.playNext_(arg_259_0)
			if arg_259_0 == 1 then
				arg_257_0:Play1109704065(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			if arg_257_1.bgs_.STwhite == nil then
				local var_260_0 = Object.Instantiate(arg_257_1.paintGo_)

				var_260_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "STwhite")
				var_260_0.name = "STwhite"
				var_260_0.transform.parent = arg_257_1.stage_.transform
				var_260_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_257_1.bgs_.STwhite = var_260_0
			end

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 then
				local var_260_1 = arg_257_1.bgs_.STwhite

				arg_257_1.bgs_.STwhite.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_260_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_260_2 = var_260_1:GetComponent("SpriteRenderer")

				if var_260_2 and var_260_2.sprite then
					local var_260_3 = 2 * (var_260_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_260_1.transform.localScale = Vector3.New(var_260_3 / var_260_2.sprite.bounds.size.y < var_260_3 * manager.ui.mainCameraCom_.aspect / var_260_2.sprite.bounds.size.x and var_260_3 * manager.ui.mainCameraCom_.aspect / var_260_2.sprite.bounds.size.x or var_260_3 / var_260_2.sprite.bounds.size.y, var_260_3 / var_260_2.sprite.bounds.size.y < var_260_3 * manager.ui.mainCameraCom_.aspect / var_260_2.sprite.bounds.size.x and var_260_3 * manager.ui.mainCameraCom_.aspect / var_260_2.sprite.bounds.size.x or var_260_3 / var_260_2.sprite.bounds.size.y, 0)
				end

				for iter_260_0, iter_260_1 in pairs(arg_257_1.bgs_) do
					if iter_260_0 ~= "STwhite" then
						iter_260_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_260_4 = 2

			if 2 < arg_257_1.time_ and arg_257_1.time_ <= var_260_4 + arg_260_0 then
				arg_257_1.allBtn_.enabled = false
			end

			if arg_257_1.time_ >= var_260_4 + 0.3 and arg_257_1.time_ < var_260_4 + 0.3 + arg_260_0 then
				arg_257_1.allBtn_.enabled = true
			end

			local var_260_5 = 0

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= var_260_5 + arg_260_0 then
				arg_257_1.mask_.enabled = true
				arg_257_1.mask_.raycastTarget = true

				arg_257_1:SetGaussion(false)
			end

			local var_260_6 = 2

			if var_260_5 <= arg_257_1.time_ and arg_257_1.time_ < var_260_5 + var_260_6 then
				local var_260_7 = Color.New(1, 1, 1)

				var_260_7.a = Mathf.Lerp(1, 0, (arg_257_1.time_ - var_260_5) / var_260_6)
				arg_257_1.mask_.color = var_260_7
			end

			if arg_257_1.time_ >= var_260_5 + var_260_6 and arg_257_1.time_ < var_260_5 + var_260_6 + arg_260_0 then
				local var_260_8 = Color.New(1, 1, 1)

				arg_257_1.mask_.enabled = false
				var_260_8.a = 0
				arg_257_1.mask_.color = var_260_8
			end

			local var_260_9 = arg_257_1.actors_["1097ui_story"].transform

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 then
				arg_257_1.var_.moveOldPos1097ui_story = var_260_9.localPosition
			end

			local var_260_10 = 0.001

			if 0 <= arg_257_1.time_ and arg_257_1.time_ < 0 + var_260_10 then
				var_260_9.localPosition = Vector3.Lerp(arg_257_1.var_.moveOldPos1097ui_story, Vector3.New(0, 100, 0), (arg_257_1.time_ - 0) / var_260_10)
				var_260_9.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_260_9.position).x, (manager.ui.mainCamera.transform.position - var_260_9.position).y, (manager.ui.mainCamera.transform.position - var_260_9.position).z)
				var_260_9.localEulerAngles.z = 0
				var_260_9.localEulerAngles.x = 0
				var_260_9.localEulerAngles = var_260_9.localEulerAngles
			end

			if arg_257_1.time_ >= 0 + var_260_10 and arg_257_1.time_ < 0 + var_260_10 + arg_260_0 then
				var_260_9.localPosition = Vector3.New(0, 100, 0)
				var_260_9.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_260_9.position).x, (manager.ui.mainCamera.transform.position - var_260_9.position).y, (manager.ui.mainCamera.transform.position - var_260_9.position).z)
				var_260_9.localEulerAngles.z = 0
				var_260_9.localEulerAngles.x = 0
				var_260_9.localEulerAngles = var_260_9.localEulerAngles
			end

			local var_260_11 = arg_257_1.actors_["1097ui_story"]

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 and not isNil(var_260_11) and arg_257_1.var_.characterEffect1097ui_story == nil then
				arg_257_1.var_.characterEffect1097ui_story = var_260_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_260_12 = 0.034000001847744

			if 0 <= arg_257_1.time_ and arg_257_1.time_ < 0 + var_260_12 and not isNil(var_260_11) then
				if arg_257_1.var_.characterEffect1097ui_story and not isNil(var_260_11) then
					arg_257_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_257_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_257_1.time_ - 0) / var_260_12)
				end
			end

			if arg_257_1.time_ >= 0 + var_260_12 and arg_257_1.time_ < 0 + var_260_12 + arg_260_0 and not isNil(var_260_11) and arg_257_1.var_.characterEffect1097ui_story then
				arg_257_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_257_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_260_13 = arg_257_1.actors_["1027ui_story"].transform

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 then
				arg_257_1.var_.moveOldPos1027ui_story = var_260_13.localPosition
			end

			local var_260_14 = 0.001

			if 0 <= arg_257_1.time_ and arg_257_1.time_ < 0 + var_260_14 then
				var_260_13.localPosition = Vector3.Lerp(arg_257_1.var_.moveOldPos1027ui_story, Vector3.New(0, 100, 0), (arg_257_1.time_ - 0) / var_260_14)
				var_260_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_260_13.position).x, (manager.ui.mainCamera.transform.position - var_260_13.position).y, (manager.ui.mainCamera.transform.position - var_260_13.position).z)
				var_260_13.localEulerAngles.z = 0
				var_260_13.localEulerAngles.x = 0
				var_260_13.localEulerAngles = var_260_13.localEulerAngles
			end

			if arg_257_1.time_ >= 0 + var_260_14 and arg_257_1.time_ < 0 + var_260_14 + arg_260_0 then
				var_260_13.localPosition = Vector3.New(0, 100, 0)
				var_260_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_260_13.position).x, (manager.ui.mainCamera.transform.position - var_260_13.position).y, (manager.ui.mainCamera.transform.position - var_260_13.position).z)
				var_260_13.localEulerAngles.z = 0
				var_260_13.localEulerAngles.x = 0
				var_260_13.localEulerAngles = var_260_13.localEulerAngles
			end

			if arg_257_1.frameCnt_ <= 1 then
				arg_257_1.dialog_:SetActive(false)
			end

			local var_260_15 = 2
			local var_260_16 = 0.875

			if 2 < arg_257_1.time_ and arg_257_1.time_ <= var_260_15 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0

				arg_257_1.dialog_:SetActive(true)

				arg_257_1.dialogCg_.alpha = 0

				local var_260_17 = LeanTween.value(arg_257_1.dialog_, 0, 1, 0.3)

				var_260_17:setOnUpdate(LuaHelper.FloatAction(function(arg_261_0)
					arg_257_1.dialogCg_.alpha = arg_261_0
				end))
				var_260_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_257_1.dialog_)
					var_260_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_257_1.duration_ = arg_257_1.duration_ + 0.3

				SetActive(arg_257_1.leftNameGo_, false)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_257_1.iconTrs_.gameObject, false)
				arg_257_1.callingController_:SetSelectedState("normal")

				local var_260_18 = arg_257_1:FormatText(arg_257_1:GetWordFromCfg(1109704064).content)

				arg_257_1.text_.text = var_260_18

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_20 = 35 <= 0 and var_260_16 or var_260_16 * (utf8.len(var_260_18) / 35)

				if (35 <= 0 and var_260_16 or var_260_16 * (utf8.len(var_260_18) / 35)) > 0 and var_260_16 < var_260_20 then
					arg_257_1.talkMaxDuration = var_260_20
					var_260_15 = var_260_15 + 0.3

					if var_260_20 + var_260_15 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_20 + var_260_15
					end
				end

				arg_257_1.text_.text = var_260_18
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)
				arg_257_1:RecordContent(arg_257_1.text_.text)
			end

			local var_260_21 = var_260_15 + 0.3
			local var_260_22 = math.max(var_260_16, arg_257_1.talkMaxDuration)

			if var_260_15 + 0.3 <= arg_257_1.time_ and arg_257_1.time_ < var_260_21 + var_260_22 then
				arg_257_1.typewritter.percent = (arg_257_1.time_ - var_260_21) / var_260_22

				arg_257_1.typewritter:SetDirty()
			end

			if arg_257_1.time_ >= var_260_21 + var_260_22 and arg_257_1.time_ < var_260_21 + var_260_22 + arg_260_0 then
				arg_257_1.typewritter.percent = 1

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(true)
			end
		end

		arg_257_1.nodeConfigList_ = {
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
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_257_1:InitPlayNodeList()
	end,
	Play1109704065 = function(arg_263_0, arg_263_1)
		arg_263_1.time_ = 0
		arg_263_1.frameCnt_ = 0
		arg_263_1.state_ = "playing"
		arg_263_1.curTalkId_ = 1109704065
		arg_263_1.duration_ = 5

		SetActive(arg_263_1.tipsGo_, false)

		function arg_263_1.onSingleLineFinish_()
			arg_263_1.onSingleLineUpdate_ = nil
			arg_263_1.onSingleLineFinish_ = nil
			arg_263_1.state_ = "waiting"
		end

		function arg_263_1.playNext_(arg_265_0)
			if arg_265_0 == 1 then
				arg_263_0:Play1109704066(arg_263_1)
			end
		end

		function arg_263_1.onSingleLineUpdate_(arg_266_0)
			local var_266_0 = 1.35

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 then
				arg_263_1.talkMaxDuration = 0
				arg_263_1.dialogCg_.alpha = 1

				arg_263_1.dialog_:SetActive(true)
				SetActive(arg_263_1.leftNameGo_, false)

				arg_263_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_263_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_263_1:RecordName(arg_263_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_263_1.iconTrs_.gameObject, false)
				arg_263_1.callingController_:SetSelectedState("normal")

				local var_266_1 = arg_263_1:FormatText(arg_263_1:GetWordFromCfg(1109704065).content)

				arg_263_1.text_.text = var_266_1

				LuaForUtil.ClearLinePrefixSymbol(arg_263_1.text_)

				local var_266_3 = 54 <= 0 and var_266_0 or var_266_0 * (utf8.len(var_266_1) / 54)

				if (54 <= 0 and var_266_0 or var_266_0 * (utf8.len(var_266_1) / 54)) > 0 and var_266_0 < var_266_3 then
					arg_263_1.talkMaxDuration = var_266_3

					if var_266_3 + 0 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_3 + 0
					end
				end

				arg_263_1.text_.text = var_266_1
				arg_263_1.typewritter.percent = 0

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(false)
				arg_263_1:RecordContent(arg_263_1.text_.text)
			end

			local var_266_4 = math.max(var_266_0, arg_263_1.talkMaxDuration)

			if 0 <= arg_263_1.time_ and arg_263_1.time_ < 0 + var_266_4 then
				arg_263_1.typewritter.percent = (arg_263_1.time_ - 0) / var_266_4

				arg_263_1.typewritter:SetDirty()
			end

			if arg_263_1.time_ >= 0 + var_266_4 and arg_263_1.time_ < 0 + var_266_4 + arg_266_0 then
				arg_263_1.typewritter.percent = 1

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(true)
			end
		end

		arg_263_1.nodeConfigList_ = {}

		arg_263_1:InitPlayNodeList()
	end,
	Play1109704066 = function(arg_267_0, arg_267_1)
		arg_267_1.time_ = 0
		arg_267_1.frameCnt_ = 0
		arg_267_1.state_ = "playing"
		arg_267_1.curTalkId_ = 1109704066
		arg_267_1.duration_ = 5

		SetActive(arg_267_1.tipsGo_, false)

		function arg_267_1.onSingleLineFinish_()
			arg_267_1.onSingleLineUpdate_ = nil
			arg_267_1.onSingleLineFinish_ = nil
			arg_267_1.state_ = "waiting"
		end

		function arg_267_1.playNext_(arg_269_0)
			if arg_269_0 == 1 then
				arg_267_0:Play1109704067(arg_267_1)
			end
		end

		function arg_267_1.onSingleLineUpdate_(arg_270_0)
			local var_270_0 = 1.175

			if 0 < arg_267_1.time_ and arg_267_1.time_ <= 0 + arg_270_0 then
				arg_267_1.talkMaxDuration = 0
				arg_267_1.dialogCg_.alpha = 1

				arg_267_1.dialog_:SetActive(true)
				SetActive(arg_267_1.leftNameGo_, false)

				arg_267_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_267_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_267_1:RecordName(arg_267_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_267_1.iconTrs_.gameObject, false)
				arg_267_1.callingController_:SetSelectedState("normal")

				local var_270_1 = arg_267_1:FormatText(arg_267_1:GetWordFromCfg(1109704066).content)

				arg_267_1.text_.text = var_270_1

				LuaForUtil.ClearLinePrefixSymbol(arg_267_1.text_)

				local var_270_3 = 47 <= 0 and var_270_0 or var_270_0 * (utf8.len(var_270_1) / 47)

				if (47 <= 0 and var_270_0 or var_270_0 * (utf8.len(var_270_1) / 47)) > 0 and var_270_0 < var_270_3 then
					arg_267_1.talkMaxDuration = var_270_3

					if var_270_3 + 0 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_3 + 0
					end
				end

				arg_267_1.text_.text = var_270_1
				arg_267_1.typewritter.percent = 0

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(false)
				arg_267_1:RecordContent(arg_267_1.text_.text)
			end

			local var_270_4 = math.max(var_270_0, arg_267_1.talkMaxDuration)

			if 0 <= arg_267_1.time_ and arg_267_1.time_ < 0 + var_270_4 then
				arg_267_1.typewritter.percent = (arg_267_1.time_ - 0) / var_270_4

				arg_267_1.typewritter:SetDirty()
			end

			if arg_267_1.time_ >= 0 + var_270_4 and arg_267_1.time_ < 0 + var_270_4 + arg_270_0 then
				arg_267_1.typewritter.percent = 1

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(true)
			end
		end

		arg_267_1.nodeConfigList_ = {}

		arg_267_1:InitPlayNodeList()
	end,
	Play1109704067 = function(arg_271_0, arg_271_1)
		arg_271_1.time_ = 0
		arg_271_1.frameCnt_ = 0
		arg_271_1.state_ = "playing"
		arg_271_1.curTalkId_ = 1109704067
		arg_271_1.duration_ = 8.4

		local var_271_0 = {
			zh = 6.133,
			ja = 8.4
		}
		local var_271_1 = manager.audio:GetLocalizationFlag()

		if var_271_0[var_271_1] ~= nil then
			arg_271_1.duration_ = var_271_0[var_271_1]
		end

		SetActive(arg_271_1.tipsGo_, false)

		function arg_271_1.onSingleLineFinish_()
			arg_271_1.onSingleLineUpdate_ = nil
			arg_271_1.onSingleLineFinish_ = nil
			arg_271_1.state_ = "waiting"
		end

		function arg_271_1.playNext_(arg_273_0)
			if arg_273_0 == 1 then
				arg_271_0:Play1109704068(arg_271_1)
			end
		end

		function arg_271_1.onSingleLineUpdate_(arg_274_0)
			local var_274_0 = 0.6

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 then
				arg_271_1.talkMaxDuration = 0
				arg_271_1.dialogCg_.alpha = 1

				arg_271_1.dialog_:SetActive(true)
				SetActive(arg_271_1.leftNameGo_, true)

				arg_271_1.leftNameTxt_.text = arg_271_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_271_1.leftNameTxt_.transform)

				arg_271_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_271_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_271_1:RecordName(arg_271_1.leftNameTxt_.text)
				SetActive(arg_271_1.iconTrs_.gameObject, true)
				arg_271_1.iconController_:SetSelectedState("hero")

				arg_271_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1027")

				arg_271_1.callingController_:SetSelectedState("normal")

				arg_271_1.keyicon_.color = Color.New(1, 1, 1)
				arg_271_1.icon_.color = Color.New(1, 1, 1)

				local var_274_1 = arg_271_1:GetWordFromCfg(1109704067)
				local var_274_2 = arg_271_1:FormatText(var_274_1.content)

				arg_271_1.text_.text = var_274_2

				LuaForUtil.ClearLinePrefixSymbol(arg_271_1.text_)

				local var_274_4 = 24 <= 0 and var_274_0 or var_274_0 * (utf8.len(var_274_2) / 24)

				if (24 <= 0 and var_274_0 or var_274_0 * (utf8.len(var_274_2) / 24)) > 0 and var_274_0 < var_274_4 then
					arg_271_1.talkMaxDuration = var_274_4

					if var_274_4 + 0 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_4 + 0
					end
				end

				arg_271_1.text_.text = var_274_2
				arg_271_1.typewritter.percent = 0

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704067", "story_v_side_new_1109704.awb") ~= 0 then
					local var_274_5 = manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704067", "story_v_side_new_1109704.awb") / 1000

					if var_274_5 + 0 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_5 + 0
					end

					if var_274_1.prefab_name ~= "" and arg_271_1.actors_[var_274_1.prefab_name] ~= nil then
						local var_274_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_271_1.actors_[var_274_1.prefab_name].transform, "story_v_side_new_1109704", "1109704067", "story_v_side_new_1109704.awb")

						arg_271_1:RecordAudio("1109704067", var_274_6)
						arg_271_1:RecordAudio("1109704067", var_274_6)
					else
						arg_271_1:AudioAction("play", "voice", "story_v_side_new_1109704", "1109704067", "story_v_side_new_1109704.awb")
					end

					arg_271_1:RecordHistoryTalkVoice("story_v_side_new_1109704", "1109704067", "story_v_side_new_1109704.awb")
				end

				arg_271_1:RecordContent(arg_271_1.text_.text)
			end

			local var_274_7 = math.max(var_274_0, arg_271_1.talkMaxDuration)

			if 0 <= arg_271_1.time_ and arg_271_1.time_ < 0 + var_274_7 then
				arg_271_1.typewritter.percent = (arg_271_1.time_ - 0) / var_274_7

				arg_271_1.typewritter:SetDirty()
			end

			if arg_271_1.time_ >= 0 + var_274_7 and arg_271_1.time_ < 0 + var_274_7 + arg_274_0 then
				arg_271_1.typewritter.percent = 1

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(true)
			end
		end

		arg_271_1.nodeConfigList_ = {}

		arg_271_1:InitPlayNodeList()
	end,
	Play1109704068 = function(arg_275_0, arg_275_1)
		arg_275_1.time_ = 0
		arg_275_1.frameCnt_ = 0
		arg_275_1.state_ = "playing"
		arg_275_1.curTalkId_ = 1109704068
		arg_275_1.duration_ = 5

		SetActive(arg_275_1.tipsGo_, false)

		function arg_275_1.onSingleLineFinish_()
			arg_275_1.onSingleLineUpdate_ = nil
			arg_275_1.onSingleLineFinish_ = nil
			arg_275_1.state_ = "waiting"
		end

		function arg_275_1.playNext_(arg_277_0)
			if arg_277_0 == 1 then
				arg_275_0:Play1109704069(arg_275_1)
			end
		end

		function arg_275_1.onSingleLineUpdate_(arg_278_0)
			local var_278_0 = 1.175

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 then
				arg_275_1.talkMaxDuration = 0
				arg_275_1.dialogCg_.alpha = 1

				arg_275_1.dialog_:SetActive(true)
				SetActive(arg_275_1.leftNameGo_, false)

				arg_275_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_275_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_275_1:RecordName(arg_275_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_275_1.iconTrs_.gameObject, false)
				arg_275_1.callingController_:SetSelectedState("normal")

				local var_278_1 = arg_275_1:FormatText(arg_275_1:GetWordFromCfg(1109704068).content)

				arg_275_1.text_.text = var_278_1

				LuaForUtil.ClearLinePrefixSymbol(arg_275_1.text_)

				local var_278_3 = 47 <= 0 and var_278_0 or var_278_0 * (utf8.len(var_278_1) / 47)

				if (47 <= 0 and var_278_0 or var_278_0 * (utf8.len(var_278_1) / 47)) > 0 and var_278_0 < var_278_3 then
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
	Play1109704069 = function(arg_279_0, arg_279_1)
		arg_279_1.time_ = 0
		arg_279_1.frameCnt_ = 0
		arg_279_1.state_ = "playing"
		arg_279_1.curTalkId_ = 1109704069
		arg_279_1.duration_ = 9

		SetActive(arg_279_1.tipsGo_, false)

		function arg_279_1.onSingleLineFinish_()
			arg_279_1.onSingleLineUpdate_ = nil
			arg_279_1.onSingleLineFinish_ = nil
			arg_279_1.state_ = "waiting"
		end

		function arg_279_1.playNext_(arg_281_0)
			if arg_281_0 == 1 then
				arg_279_0:Play1109704070(arg_279_1)
			end
		end

		function arg_279_1.onSingleLineUpdate_(arg_282_0)
			if arg_279_1.bgs_.ST60 == nil then
				local var_282_0 = Object.Instantiate(arg_279_1.paintGo_)

				var_282_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST60")
				var_282_0.name = "ST60"
				var_282_0.transform.parent = arg_279_1.stage_.transform
				var_282_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_279_1.bgs_.ST60 = var_282_0
			end

			if 1.999999999999 < arg_279_1.time_ and arg_279_1.time_ <= 1.999999999999 + arg_282_0 then
				local var_282_1 = arg_279_1.bgs_.ST60

				arg_279_1.bgs_.ST60.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_282_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_282_2 = var_282_1:GetComponent("SpriteRenderer")

				if var_282_2 and var_282_2.sprite then
					local var_282_3 = 2 * (var_282_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_282_1.transform.localScale = Vector3.New(var_282_3 / var_282_2.sprite.bounds.size.y < var_282_3 * manager.ui.mainCameraCom_.aspect / var_282_2.sprite.bounds.size.x and var_282_3 * manager.ui.mainCameraCom_.aspect / var_282_2.sprite.bounds.size.x or var_282_3 / var_282_2.sprite.bounds.size.y, var_282_3 / var_282_2.sprite.bounds.size.y < var_282_3 * manager.ui.mainCameraCom_.aspect / var_282_2.sprite.bounds.size.x and var_282_3 * manager.ui.mainCameraCom_.aspect / var_282_2.sprite.bounds.size.x or var_282_3 / var_282_2.sprite.bounds.size.y, 0)
				end

				for iter_282_0, iter_282_1 in pairs(arg_279_1.bgs_) do
					if iter_282_0 ~= "ST60" then
						iter_282_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_282_4 = 3.999999999999

			if 3.999999999999 < arg_279_1.time_ and arg_279_1.time_ <= var_282_4 + arg_282_0 then
				arg_279_1.allBtn_.enabled = false
			end

			if arg_279_1.time_ >= var_282_4 + 0.3 and arg_279_1.time_ < var_282_4 + 0.3 + arg_282_0 then
				arg_279_1.allBtn_.enabled = true
			end

			local var_282_5 = 0

			if 0 < arg_279_1.time_ and arg_279_1.time_ <= var_282_5 + arg_282_0 then
				arg_279_1.mask_.enabled = true
				arg_279_1.mask_.raycastTarget = true

				arg_279_1:SetGaussion(false)
			end

			local var_282_6 = 2

			if var_282_5 <= arg_279_1.time_ and arg_279_1.time_ < var_282_5 + var_282_6 then
				local var_282_7 = Color.New(1, 1, 1)

				var_282_7.a = Mathf.Lerp(0, 1, (arg_279_1.time_ - var_282_5) / var_282_6)
				arg_279_1.mask_.color = var_282_7
			end

			if arg_279_1.time_ >= var_282_5 + var_282_6 and arg_279_1.time_ < var_282_5 + var_282_6 + arg_282_0 then
				local var_282_8 = Color.New(1, 1, 1)

				var_282_8.a = 1
				arg_279_1.mask_.color = var_282_8
			end

			local var_282_9 = 2

			if 2 < arg_279_1.time_ and arg_279_1.time_ <= var_282_9 + arg_282_0 then
				arg_279_1.mask_.enabled = true
				arg_279_1.mask_.raycastTarget = true

				arg_279_1:SetGaussion(false)
			end

			local var_282_10 = 2

			if var_282_9 <= arg_279_1.time_ and arg_279_1.time_ < var_282_9 + var_282_10 then
				local var_282_11 = Color.New(1, 1, 1)

				var_282_11.a = Mathf.Lerp(1, 0, (arg_279_1.time_ - var_282_9) / var_282_10)
				arg_279_1.mask_.color = var_282_11
			end

			if arg_279_1.time_ >= var_282_9 + var_282_10 and arg_279_1.time_ < var_282_9 + var_282_10 + arg_282_0 then
				local var_282_12 = Color.New(1, 1, 1)

				arg_279_1.mask_.enabled = false
				var_282_12.a = 0
				arg_279_1.mask_.color = var_282_12
			end

			if arg_279_1.frameCnt_ <= 1 then
				arg_279_1.dialog_:SetActive(false)
			end

			local var_282_13 = 4
			local var_282_14 = 0.325

			if 4 < arg_279_1.time_ and arg_279_1.time_ <= var_282_13 + arg_282_0 then
				arg_279_1.talkMaxDuration = 0

				arg_279_1.dialog_:SetActive(true)

				arg_279_1.dialogCg_.alpha = 0

				local var_282_15 = LeanTween.value(arg_279_1.dialog_, 0, 1, 0.3)

				var_282_15:setOnUpdate(LuaHelper.FloatAction(function(arg_283_0)
					arg_279_1.dialogCg_.alpha = arg_283_0
				end))
				var_282_15:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_279_1.dialog_)
					var_282_15:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_279_1.duration_ = arg_279_1.duration_ + 0.3

				SetActive(arg_279_1.leftNameGo_, true)

				arg_279_1.leftNameTxt_.text = arg_279_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_279_1.leftNameTxt_.transform)

				arg_279_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_279_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_279_1:RecordName(arg_279_1.leftNameTxt_.text)
				SetActive(arg_279_1.iconTrs_.gameObject, true)
				arg_279_1.iconController_:SetSelectedState("hero")

				arg_279_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_279_1.callingController_:SetSelectedState("normal")

				arg_279_1.keyicon_.color = Color.New(1, 1, 1)
				arg_279_1.icon_.color = Color.New(1, 1, 1)

				local var_282_16 = arg_279_1:FormatText(arg_279_1:GetWordFromCfg(1109704069).content)

				arg_279_1.text_.text = var_282_16

				LuaForUtil.ClearLinePrefixSymbol(arg_279_1.text_)

				local var_282_18 = 13 <= 0 and var_282_14 or var_282_14 * (utf8.len(var_282_16) / 13)

				if (13 <= 0 and var_282_14 or var_282_14 * (utf8.len(var_282_16) / 13)) > 0 and var_282_14 < var_282_18 then
					arg_279_1.talkMaxDuration = var_282_18
					var_282_13 = var_282_13 + 0.3

					if var_282_18 + var_282_13 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_18 + var_282_13
					end
				end

				arg_279_1.text_.text = var_282_16
				arg_279_1.typewritter.percent = 0

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(false)
				arg_279_1:RecordContent(arg_279_1.text_.text)
			end

			local var_282_19 = var_282_13 + 0.3
			local var_282_20 = math.max(var_282_14, arg_279_1.talkMaxDuration)

			if var_282_13 + 0.3 <= arg_279_1.time_ and arg_279_1.time_ < var_282_19 + var_282_20 then
				arg_279_1.typewritter.percent = (arg_279_1.time_ - var_282_19) / var_282_20

				arg_279_1.typewritter:SetDirty()
			end

			if arg_279_1.time_ >= var_282_19 + var_282_20 and arg_279_1.time_ < var_282_19 + var_282_20 + arg_282_0 then
				arg_279_1.typewritter.percent = 1

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(true)
			end
		end

		arg_279_1.nodeConfigList_ = {}

		arg_279_1:InitPlayNodeList()
	end,
	Play1109704070 = function(arg_285_0, arg_285_1)
		arg_285_1.time_ = 0
		arg_285_1.frameCnt_ = 0
		arg_285_1.state_ = "playing"
		arg_285_1.curTalkId_ = 1109704070
		arg_285_1.duration_ = 5.2

		local var_285_0 = {
			zh = 3.9,
			ja = 5.2
		}
		local var_285_1 = manager.audio:GetLocalizationFlag()

		if var_285_0[var_285_1] ~= nil then
			arg_285_1.duration_ = var_285_0[var_285_1]
		end

		SetActive(arg_285_1.tipsGo_, false)

		function arg_285_1.onSingleLineFinish_()
			arg_285_1.onSingleLineUpdate_ = nil
			arg_285_1.onSingleLineFinish_ = nil
			arg_285_1.state_ = "waiting"
		end

		function arg_285_1.playNext_(arg_287_0)
			if arg_287_0 == 1 then
				arg_285_0:Play1109704071(arg_285_1)
			end
		end

		function arg_285_1.onSingleLineUpdate_(arg_288_0)
			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 then
				arg_285_1.var_.moveOldPos1097ui_story = arg_285_1.actors_["1097ui_story"].transform.localPosition
			end

			local var_288_0 = 0.001

			if 0 <= arg_285_1.time_ and arg_285_1.time_ < 0 + var_288_0 then
				arg_285_1.actors_["1097ui_story"].transform.localPosition = Vector3.Lerp(arg_285_1.var_.moveOldPos1097ui_story, Vector3.New(0, -0.54, -6.3), (arg_285_1.time_ - 0) / var_288_0)
				arg_285_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_285_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_285_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_285_1.actors_["1097ui_story"].transform.position).z)
				arg_285_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_285_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_285_1.actors_["1097ui_story"].transform.localEulerAngles = arg_285_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			if arg_285_1.time_ >= 0 + var_288_0 and arg_285_1.time_ < 0 + var_288_0 + arg_288_0 then
				arg_285_1.actors_["1097ui_story"].transform.localPosition = Vector3.New(0, -0.54, -6.3)
				arg_285_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_285_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_285_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_285_1.actors_["1097ui_story"].transform.position).z)
				arg_285_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_285_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_285_1.actors_["1097ui_story"].transform.localEulerAngles = arg_285_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			local var_288_1 = arg_285_1.actors_["1097ui_story"]

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 and not isNil(var_288_1) and arg_285_1.var_.characterEffect1097ui_story == nil then
				arg_285_1.var_.characterEffect1097ui_story = var_288_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_288_2 = 0.200000002980232

			if 0 <= arg_285_1.time_ and arg_285_1.time_ < 0 + var_288_2 and not isNil(var_288_1) then
				if arg_285_1.var_.characterEffect1097ui_story and not isNil(var_288_1) then
					arg_285_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_285_1.time_ >= 0 + var_288_2 and arg_285_1.time_ < 0 + var_288_2 + arg_288_0 and not isNil(var_288_1) and arg_285_1.var_.characterEffect1097ui_story then
				arg_285_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 then
				arg_285_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 then
				arg_285_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_288_4 = 0
			local var_288_5 = 0.3

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= var_288_4 + arg_288_0 then
				arg_285_1.talkMaxDuration = 0
				arg_285_1.dialogCg_.alpha = 1

				arg_285_1.dialog_:SetActive(true)
				SetActive(arg_285_1.leftNameGo_, true)

				arg_285_1.leftNameTxt_.text = arg_285_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_285_1.leftNameTxt_.transform)

				arg_285_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_285_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_285_1:RecordName(arg_285_1.leftNameTxt_.text)
				SetActive(arg_285_1.iconTrs_.gameObject, false)
				arg_285_1.callingController_:SetSelectedState("normal")

				local var_288_6 = arg_285_1:GetWordFromCfg(1109704070)
				local var_288_7 = arg_285_1:FormatText(var_288_6.content)

				arg_285_1.text_.text = var_288_7

				LuaForUtil.ClearLinePrefixSymbol(arg_285_1.text_)

				local var_288_9 = 12 <= 0 and var_288_5 or var_288_5 * (utf8.len(var_288_7) / 12)

				if (12 <= 0 and var_288_5 or var_288_5 * (utf8.len(var_288_7) / 12)) > 0 and var_288_5 < var_288_9 then
					arg_285_1.talkMaxDuration = var_288_9

					if var_288_9 + var_288_4 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_9 + var_288_4
					end
				end

				arg_285_1.text_.text = var_288_7
				arg_285_1.typewritter.percent = 0

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704070", "story_v_side_new_1109704.awb") ~= 0 then
					local var_288_10 = manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704070", "story_v_side_new_1109704.awb") / 1000

					if var_288_10 + var_288_4 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_10 + var_288_4
					end

					if var_288_6.prefab_name ~= "" and arg_285_1.actors_[var_288_6.prefab_name] ~= nil then
						local var_288_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_285_1.actors_[var_288_6.prefab_name].transform, "story_v_side_new_1109704", "1109704070", "story_v_side_new_1109704.awb")

						arg_285_1:RecordAudio("1109704070", var_288_11)
						arg_285_1:RecordAudio("1109704070", var_288_11)
					else
						arg_285_1:AudioAction("play", "voice", "story_v_side_new_1109704", "1109704070", "story_v_side_new_1109704.awb")
					end

					arg_285_1:RecordHistoryTalkVoice("story_v_side_new_1109704", "1109704070", "story_v_side_new_1109704.awb")
				end

				arg_285_1:RecordContent(arg_285_1.text_.text)
			end

			local var_288_12 = math.max(var_288_5, arg_285_1.talkMaxDuration)

			if var_288_4 <= arg_285_1.time_ and arg_285_1.time_ < var_288_4 + var_288_12 then
				arg_285_1.typewritter.percent = (arg_285_1.time_ - var_288_4) / var_288_12

				arg_285_1.typewritter:SetDirty()
			end

			if arg_285_1.time_ >= var_288_4 + var_288_12 and arg_285_1.time_ < var_288_4 + var_288_12 + arg_288_0 then
				arg_285_1.typewritter.percent = 1

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(true)
			end
		end

		arg_285_1.nodeConfigList_ = {
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

		arg_285_1:InitPlayNodeList()
	end,
	Play1109704071 = function(arg_289_0, arg_289_1)
		arg_289_1.time_ = 0
		arg_289_1.frameCnt_ = 0
		arg_289_1.state_ = "playing"
		arg_289_1.curTalkId_ = 1109704071
		arg_289_1.duration_ = 5

		SetActive(arg_289_1.tipsGo_, false)

		function arg_289_1.onSingleLineFinish_()
			arg_289_1.onSingleLineUpdate_ = nil
			arg_289_1.onSingleLineFinish_ = nil
			arg_289_1.state_ = "waiting"
		end

		function arg_289_1.playNext_(arg_291_0)
			if arg_291_0 == 1 then
				arg_289_0:Play1109704072(arg_289_1)
			end
		end

		function arg_289_1.onSingleLineUpdate_(arg_292_0)
			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 and not isNil(arg_289_1.actors_["1097ui_story"]) and arg_289_1.var_.characterEffect1097ui_story == nil then
				arg_289_1.var_.characterEffect1097ui_story = arg_289_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_292_0 = 0.200000002980232

			if 0 <= arg_289_1.time_ and arg_289_1.time_ < 0 + var_292_0 and not isNil(arg_289_1.actors_["1097ui_story"]) then
				if arg_289_1.var_.characterEffect1097ui_story and not isNil(arg_289_1.actors_["1097ui_story"]) then
					arg_289_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_289_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_289_1.time_ - 0) / var_292_0)
				end
			end

			if arg_289_1.time_ >= 0 + var_292_0 and arg_289_1.time_ < 0 + var_292_0 + arg_292_0 and not isNil(arg_289_1.actors_["1097ui_story"]) and arg_289_1.var_.characterEffect1097ui_story then
				arg_289_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_289_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_292_1 = 0
			local var_292_2 = 0.85

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= var_292_1 + arg_292_0 then
				arg_289_1.talkMaxDuration = 0
				arg_289_1.dialogCg_.alpha = 1

				arg_289_1.dialog_:SetActive(true)
				SetActive(arg_289_1.leftNameGo_, true)

				arg_289_1.leftNameTxt_.text = arg_289_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_289_1.leftNameTxt_.transform)

				arg_289_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_289_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_289_1:RecordName(arg_289_1.leftNameTxt_.text)
				SetActive(arg_289_1.iconTrs_.gameObject, true)
				arg_289_1.iconController_:SetSelectedState("hero")

				arg_289_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_289_1.callingController_:SetSelectedState("normal")

				arg_289_1.keyicon_.color = Color.New(1, 1, 1)
				arg_289_1.icon_.color = Color.New(1, 1, 1)

				local var_292_3 = arg_289_1:FormatText(arg_289_1:GetWordFromCfg(1109704071).content)

				arg_289_1.text_.text = var_292_3

				LuaForUtil.ClearLinePrefixSymbol(arg_289_1.text_)

				local var_292_5 = 34 <= 0 and var_292_2 or var_292_2 * (utf8.len(var_292_3) / 34)

				if (34 <= 0 and var_292_2 or var_292_2 * (utf8.len(var_292_3) / 34)) > 0 and var_292_2 < var_292_5 then
					arg_289_1.talkMaxDuration = var_292_5

					if var_292_5 + var_292_1 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_5 + var_292_1
					end
				end

				arg_289_1.text_.text = var_292_3
				arg_289_1.typewritter.percent = 0

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(false)
				arg_289_1:RecordContent(arg_289_1.text_.text)
			end

			local var_292_6 = math.max(var_292_2, arg_289_1.talkMaxDuration)

			if var_292_1 <= arg_289_1.time_ and arg_289_1.time_ < var_292_1 + var_292_6 then
				arg_289_1.typewritter.percent = (arg_289_1.time_ - var_292_1) / var_292_6

				arg_289_1.typewritter:SetDirty()
			end

			if arg_289_1.time_ >= var_292_1 + var_292_6 and arg_289_1.time_ < var_292_1 + var_292_6 + arg_292_0 then
				arg_289_1.typewritter.percent = 1

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(true)
			end
		end

		arg_289_1.nodeConfigList_ = {}

		arg_289_1:InitPlayNodeList()
	end,
	Play1109704072 = function(arg_293_0, arg_293_1)
		arg_293_1.time_ = 0
		arg_293_1.frameCnt_ = 0
		arg_293_1.state_ = "playing"
		arg_293_1.curTalkId_ = 1109704072
		arg_293_1.duration_ = 6.43

		local var_293_0 = {
			zh = 4.2,
			ja = 6.433
		}
		local var_293_1 = manager.audio:GetLocalizationFlag()

		if var_293_0[var_293_1] ~= nil then
			arg_293_1.duration_ = var_293_0[var_293_1]
		end

		SetActive(arg_293_1.tipsGo_, false)

		function arg_293_1.onSingleLineFinish_()
			arg_293_1.onSingleLineUpdate_ = nil
			arg_293_1.onSingleLineFinish_ = nil
			arg_293_1.state_ = "waiting"
		end

		function arg_293_1.playNext_(arg_295_0)
			if arg_295_0 == 1 then
				arg_293_0:Play1109704073(arg_293_1)
			end
		end

		function arg_293_1.onSingleLineUpdate_(arg_296_0)
			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 then
				arg_293_1.var_.moveOldPos1097ui_story = arg_293_1.actors_["1097ui_story"].transform.localPosition
			end

			local var_296_0 = 0.001

			if 0 <= arg_293_1.time_ and arg_293_1.time_ < 0 + var_296_0 then
				arg_293_1.actors_["1097ui_story"].transform.localPosition = Vector3.Lerp(arg_293_1.var_.moveOldPos1097ui_story, Vector3.New(0, -0.54, -6.3), (arg_293_1.time_ - 0) / var_296_0)
				arg_293_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_293_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_293_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_293_1.actors_["1097ui_story"].transform.position).z)
				arg_293_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_293_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_293_1.actors_["1097ui_story"].transform.localEulerAngles = arg_293_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			if arg_293_1.time_ >= 0 + var_296_0 and arg_293_1.time_ < 0 + var_296_0 + arg_296_0 then
				arg_293_1.actors_["1097ui_story"].transform.localPosition = Vector3.New(0, -0.54, -6.3)
				arg_293_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_293_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_293_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_293_1.actors_["1097ui_story"].transform.position).z)
				arg_293_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_293_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_293_1.actors_["1097ui_story"].transform.localEulerAngles = arg_293_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			local var_296_1 = arg_293_1.actors_["1097ui_story"]

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 and not isNil(var_296_1) and arg_293_1.var_.characterEffect1097ui_story == nil then
				arg_293_1.var_.characterEffect1097ui_story = var_296_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_296_2 = 0.200000002980232

			if 0 <= arg_293_1.time_ and arg_293_1.time_ < 0 + var_296_2 and not isNil(var_296_1) then
				if arg_293_1.var_.characterEffect1097ui_story and not isNil(var_296_1) then
					arg_293_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_293_1.time_ >= 0 + var_296_2 and arg_293_1.time_ < 0 + var_296_2 + arg_296_0 and not isNil(var_296_1) and arg_293_1.var_.characterEffect1097ui_story then
				arg_293_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 then
				arg_293_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 then
				arg_293_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_296_4 = 0
			local var_296_5 = 0.3

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= var_296_4 + arg_296_0 then
				arg_293_1.talkMaxDuration = 0
				arg_293_1.dialogCg_.alpha = 1

				arg_293_1.dialog_:SetActive(true)
				SetActive(arg_293_1.leftNameGo_, true)

				arg_293_1.leftNameTxt_.text = arg_293_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_293_1.leftNameTxt_.transform)

				arg_293_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_293_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_293_1:RecordName(arg_293_1.leftNameTxt_.text)
				SetActive(arg_293_1.iconTrs_.gameObject, false)
				arg_293_1.callingController_:SetSelectedState("normal")

				local var_296_6 = arg_293_1:GetWordFromCfg(1109704072)
				local var_296_7 = arg_293_1:FormatText(var_296_6.content)

				arg_293_1.text_.text = var_296_7

				LuaForUtil.ClearLinePrefixSymbol(arg_293_1.text_)

				local var_296_9 = 12 <= 0 and var_296_5 or var_296_5 * (utf8.len(var_296_7) / 12)

				if (12 <= 0 and var_296_5 or var_296_5 * (utf8.len(var_296_7) / 12)) > 0 and var_296_5 < var_296_9 then
					arg_293_1.talkMaxDuration = var_296_9

					if var_296_9 + var_296_4 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_9 + var_296_4
					end
				end

				arg_293_1.text_.text = var_296_7
				arg_293_1.typewritter.percent = 0

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704072", "story_v_side_new_1109704.awb") ~= 0 then
					local var_296_10 = manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704072", "story_v_side_new_1109704.awb") / 1000

					if var_296_10 + var_296_4 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_10 + var_296_4
					end

					if var_296_6.prefab_name ~= "" and arg_293_1.actors_[var_296_6.prefab_name] ~= nil then
						local var_296_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_293_1.actors_[var_296_6.prefab_name].transform, "story_v_side_new_1109704", "1109704072", "story_v_side_new_1109704.awb")

						arg_293_1:RecordAudio("1109704072", var_296_11)
						arg_293_1:RecordAudio("1109704072", var_296_11)
					else
						arg_293_1:AudioAction("play", "voice", "story_v_side_new_1109704", "1109704072", "story_v_side_new_1109704.awb")
					end

					arg_293_1:RecordHistoryTalkVoice("story_v_side_new_1109704", "1109704072", "story_v_side_new_1109704.awb")
				end

				arg_293_1:RecordContent(arg_293_1.text_.text)
			end

			local var_296_12 = math.max(var_296_5, arg_293_1.talkMaxDuration)

			if var_296_4 <= arg_293_1.time_ and arg_293_1.time_ < var_296_4 + var_296_12 then
				arg_293_1.typewritter.percent = (arg_293_1.time_ - var_296_4) / var_296_12

				arg_293_1.typewritter:SetDirty()
			end

			if arg_293_1.time_ >= var_296_4 + var_296_12 and arg_293_1.time_ < var_296_4 + var_296_12 + arg_296_0 then
				arg_293_1.typewritter.percent = 1

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(true)
			end
		end

		arg_293_1.nodeConfigList_ = {
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

		arg_293_1:InitPlayNodeList()
	end,
	Play1109704073 = function(arg_297_0, arg_297_1)
		arg_297_1.time_ = 0
		arg_297_1.frameCnt_ = 0
		arg_297_1.state_ = "playing"
		arg_297_1.curTalkId_ = 1109704073
		arg_297_1.duration_ = 5

		SetActive(arg_297_1.tipsGo_, false)

		function arg_297_1.onSingleLineFinish_()
			arg_297_1.onSingleLineUpdate_ = nil
			arg_297_1.onSingleLineFinish_ = nil
			arg_297_1.state_ = "waiting"
		end

		function arg_297_1.playNext_(arg_299_0)
			if arg_299_0 == 1 then
				arg_297_0:Play1109704074(arg_297_1)
			end
		end

		function arg_297_1.onSingleLineUpdate_(arg_300_0)
			if 0 < arg_297_1.time_ and arg_297_1.time_ <= 0 + arg_300_0 and not isNil(arg_297_1.actors_["1097ui_story"]) and arg_297_1.var_.characterEffect1097ui_story == nil then
				arg_297_1.var_.characterEffect1097ui_story = arg_297_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_300_0 = 0.200000002980232

			if 0 <= arg_297_1.time_ and arg_297_1.time_ < 0 + var_300_0 and not isNil(arg_297_1.actors_["1097ui_story"]) then
				if arg_297_1.var_.characterEffect1097ui_story and not isNil(arg_297_1.actors_["1097ui_story"]) then
					arg_297_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_297_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_297_1.time_ - 0) / var_300_0)
				end
			end

			if arg_297_1.time_ >= 0 + var_300_0 and arg_297_1.time_ < 0 + var_300_0 + arg_300_0 and not isNil(arg_297_1.actors_["1097ui_story"]) and arg_297_1.var_.characterEffect1097ui_story then
				arg_297_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_297_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_300_1 = 0
			local var_300_2 = 0.725

			if 0 < arg_297_1.time_ and arg_297_1.time_ <= var_300_1 + arg_300_0 then
				arg_297_1.talkMaxDuration = 0
				arg_297_1.dialogCg_.alpha = 1

				arg_297_1.dialog_:SetActive(true)
				SetActive(arg_297_1.leftNameGo_, true)

				arg_297_1.leftNameTxt_.text = arg_297_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_297_1.leftNameTxt_.transform)

				arg_297_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_297_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_297_1:RecordName(arg_297_1.leftNameTxt_.text)
				SetActive(arg_297_1.iconTrs_.gameObject, true)
				arg_297_1.iconController_:SetSelectedState("hero")

				arg_297_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_297_1.callingController_:SetSelectedState("normal")

				arg_297_1.keyicon_.color = Color.New(1, 1, 1)
				arg_297_1.icon_.color = Color.New(1, 1, 1)

				local var_300_3 = arg_297_1:FormatText(arg_297_1:GetWordFromCfg(1109704073).content)

				arg_297_1.text_.text = var_300_3

				LuaForUtil.ClearLinePrefixSymbol(arg_297_1.text_)

				local var_300_5 = 29 <= 0 and var_300_2 or var_300_2 * (utf8.len(var_300_3) / 29)

				if (29 <= 0 and var_300_2 or var_300_2 * (utf8.len(var_300_3) / 29)) > 0 and var_300_2 < var_300_5 then
					arg_297_1.talkMaxDuration = var_300_5

					if var_300_5 + var_300_1 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_5 + var_300_1
					end
				end

				arg_297_1.text_.text = var_300_3
				arg_297_1.typewritter.percent = 0

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(false)
				arg_297_1:RecordContent(arg_297_1.text_.text)
			end

			local var_300_6 = math.max(var_300_2, arg_297_1.talkMaxDuration)

			if var_300_1 <= arg_297_1.time_ and arg_297_1.time_ < var_300_1 + var_300_6 then
				arg_297_1.typewritter.percent = (arg_297_1.time_ - var_300_1) / var_300_6

				arg_297_1.typewritter:SetDirty()
			end

			if arg_297_1.time_ >= var_300_1 + var_300_6 and arg_297_1.time_ < var_300_1 + var_300_6 + arg_300_0 then
				arg_297_1.typewritter.percent = 1

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(true)
			end
		end

		arg_297_1.nodeConfigList_ = {}

		arg_297_1:InitPlayNodeList()
	end,
	Play1109704074 = function(arg_301_0, arg_301_1)
		arg_301_1.time_ = 0
		arg_301_1.frameCnt_ = 0
		arg_301_1.state_ = "playing"
		arg_301_1.curTalkId_ = 1109704074
		arg_301_1.duration_ = 4.07

		local var_301_0 = {
			zh = 4.066,
			ja = 2.933
		}
		local var_301_1 = manager.audio:GetLocalizationFlag()

		if var_301_0[var_301_1] ~= nil then
			arg_301_1.duration_ = var_301_0[var_301_1]
		end

		SetActive(arg_301_1.tipsGo_, false)

		function arg_301_1.onSingleLineFinish_()
			arg_301_1.onSingleLineUpdate_ = nil
			arg_301_1.onSingleLineFinish_ = nil
			arg_301_1.state_ = "waiting"
		end

		function arg_301_1.playNext_(arg_303_0)
			if arg_303_0 == 1 then
				arg_301_0:Play1109704075(arg_301_1)
			end
		end

		function arg_301_1.onSingleLineUpdate_(arg_304_0)
			if 0 < arg_301_1.time_ and arg_301_1.time_ <= 0 + arg_304_0 then
				arg_301_1.var_.moveOldPos1097ui_story = arg_301_1.actors_["1097ui_story"].transform.localPosition
			end

			local var_304_0 = 0.001

			if 0 <= arg_301_1.time_ and arg_301_1.time_ < 0 + var_304_0 then
				arg_301_1.actors_["1097ui_story"].transform.localPosition = Vector3.Lerp(arg_301_1.var_.moveOldPos1097ui_story, Vector3.New(0, -0.54, -6.3), (arg_301_1.time_ - 0) / var_304_0)
				arg_301_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_301_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_301_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_301_1.actors_["1097ui_story"].transform.position).z)
				arg_301_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_301_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_301_1.actors_["1097ui_story"].transform.localEulerAngles = arg_301_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			if arg_301_1.time_ >= 0 + var_304_0 and arg_301_1.time_ < 0 + var_304_0 + arg_304_0 then
				arg_301_1.actors_["1097ui_story"].transform.localPosition = Vector3.New(0, -0.54, -6.3)
				arg_301_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_301_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_301_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_301_1.actors_["1097ui_story"].transform.position).z)
				arg_301_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_301_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_301_1.actors_["1097ui_story"].transform.localEulerAngles = arg_301_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			local var_304_1 = arg_301_1.actors_["1097ui_story"]

			if 0 < arg_301_1.time_ and arg_301_1.time_ <= 0 + arg_304_0 and not isNil(var_304_1) and arg_301_1.var_.characterEffect1097ui_story == nil then
				arg_301_1.var_.characterEffect1097ui_story = var_304_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_304_2 = 0.200000002980232

			if 0 <= arg_301_1.time_ and arg_301_1.time_ < 0 + var_304_2 and not isNil(var_304_1) then
				if arg_301_1.var_.characterEffect1097ui_story and not isNil(var_304_1) then
					arg_301_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_301_1.time_ >= 0 + var_304_2 and arg_301_1.time_ < 0 + var_304_2 + arg_304_0 and not isNil(var_304_1) and arg_301_1.var_.characterEffect1097ui_story then
				arg_301_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_301_1.time_ and arg_301_1.time_ <= 0 + arg_304_0 then
				arg_301_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			if 0 < arg_301_1.time_ and arg_301_1.time_ <= 0 + arg_304_0 then
				arg_301_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_304_4 = 0
			local var_304_5 = 0.3

			if 0 < arg_301_1.time_ and arg_301_1.time_ <= var_304_4 + arg_304_0 then
				arg_301_1.talkMaxDuration = 0
				arg_301_1.dialogCg_.alpha = 1

				arg_301_1.dialog_:SetActive(true)
				SetActive(arg_301_1.leftNameGo_, true)

				arg_301_1.leftNameTxt_.text = arg_301_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_301_1.leftNameTxt_.transform)

				arg_301_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_301_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_301_1:RecordName(arg_301_1.leftNameTxt_.text)
				SetActive(arg_301_1.iconTrs_.gameObject, false)
				arg_301_1.callingController_:SetSelectedState("normal")

				local var_304_6 = arg_301_1:GetWordFromCfg(1109704074)
				local var_304_7 = arg_301_1:FormatText(var_304_6.content)

				arg_301_1.text_.text = var_304_7

				LuaForUtil.ClearLinePrefixSymbol(arg_301_1.text_)

				local var_304_9 = 12 <= 0 and var_304_5 or var_304_5 * (utf8.len(var_304_7) / 12)

				if (12 <= 0 and var_304_5 or var_304_5 * (utf8.len(var_304_7) / 12)) > 0 and var_304_5 < var_304_9 then
					arg_301_1.talkMaxDuration = var_304_9

					if var_304_9 + var_304_4 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_9 + var_304_4
					end
				end

				arg_301_1.text_.text = var_304_7
				arg_301_1.typewritter.percent = 0

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704074", "story_v_side_new_1109704.awb") ~= 0 then
					local var_304_10 = manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704074", "story_v_side_new_1109704.awb") / 1000

					if var_304_10 + var_304_4 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_10 + var_304_4
					end

					if var_304_6.prefab_name ~= "" and arg_301_1.actors_[var_304_6.prefab_name] ~= nil then
						local var_304_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_301_1.actors_[var_304_6.prefab_name].transform, "story_v_side_new_1109704", "1109704074", "story_v_side_new_1109704.awb")

						arg_301_1:RecordAudio("1109704074", var_304_11)
						arg_301_1:RecordAudio("1109704074", var_304_11)
					else
						arg_301_1:AudioAction("play", "voice", "story_v_side_new_1109704", "1109704074", "story_v_side_new_1109704.awb")
					end

					arg_301_1:RecordHistoryTalkVoice("story_v_side_new_1109704", "1109704074", "story_v_side_new_1109704.awb")
				end

				arg_301_1:RecordContent(arg_301_1.text_.text)
			end

			local var_304_12 = math.max(var_304_5, arg_301_1.talkMaxDuration)

			if var_304_4 <= arg_301_1.time_ and arg_301_1.time_ < var_304_4 + var_304_12 then
				arg_301_1.typewritter.percent = (arg_301_1.time_ - var_304_4) / var_304_12

				arg_301_1.typewritter:SetDirty()
			end

			if arg_301_1.time_ >= var_304_4 + var_304_12 and arg_301_1.time_ < var_304_4 + var_304_12 + arg_304_0 then
				arg_301_1.typewritter.percent = 1

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(true)
			end
		end

		arg_301_1.nodeConfigList_ = {
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

		arg_301_1:InitPlayNodeList()
	end,
	Play1109704075 = function(arg_305_0, arg_305_1)
		arg_305_1.time_ = 0
		arg_305_1.frameCnt_ = 0
		arg_305_1.state_ = "playing"
		arg_305_1.curTalkId_ = 1109704075
		arg_305_1.duration_ = 5

		SetActive(arg_305_1.tipsGo_, false)

		function arg_305_1.onSingleLineFinish_()
			arg_305_1.onSingleLineUpdate_ = nil
			arg_305_1.onSingleLineFinish_ = nil
			arg_305_1.state_ = "waiting"
		end

		function arg_305_1.playNext_(arg_307_0)
			if arg_307_0 == 1 then
				arg_305_0:Play1109704076(arg_305_1)
			end
		end

		function arg_305_1.onSingleLineUpdate_(arg_308_0)
			if 0 < arg_305_1.time_ and arg_305_1.time_ <= 0 + arg_308_0 and not isNil(arg_305_1.actors_["1097ui_story"]) and arg_305_1.var_.characterEffect1097ui_story == nil then
				arg_305_1.var_.characterEffect1097ui_story = arg_305_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_308_0 = 0.200000002980232

			if 0 <= arg_305_1.time_ and arg_305_1.time_ < 0 + var_308_0 and not isNil(arg_305_1.actors_["1097ui_story"]) then
				if arg_305_1.var_.characterEffect1097ui_story and not isNil(arg_305_1.actors_["1097ui_story"]) then
					arg_305_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_305_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_305_1.time_ - 0) / var_308_0)
				end
			end

			if arg_305_1.time_ >= 0 + var_308_0 and arg_305_1.time_ < 0 + var_308_0 + arg_308_0 and not isNil(arg_305_1.actors_["1097ui_story"]) and arg_305_1.var_.characterEffect1097ui_story then
				arg_305_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_305_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_308_1 = 0
			local var_308_2 = 0.825

			if 0 < arg_305_1.time_ and arg_305_1.time_ <= var_308_1 + arg_308_0 then
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

				arg_305_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_305_1.callingController_:SetSelectedState("normal")

				arg_305_1.keyicon_.color = Color.New(1, 1, 1)
				arg_305_1.icon_.color = Color.New(1, 1, 1)

				local var_308_3 = arg_305_1:FormatText(arg_305_1:GetWordFromCfg(1109704075).content)

				arg_305_1.text_.text = var_308_3

				LuaForUtil.ClearLinePrefixSymbol(arg_305_1.text_)

				local var_308_5 = 33 <= 0 and var_308_2 or var_308_2 * (utf8.len(var_308_3) / 33)

				if (33 <= 0 and var_308_2 or var_308_2 * (utf8.len(var_308_3) / 33)) > 0 and var_308_2 < var_308_5 then
					arg_305_1.talkMaxDuration = var_308_5

					if var_308_5 + var_308_1 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_5 + var_308_1
					end
				end

				arg_305_1.text_.text = var_308_3
				arg_305_1.typewritter.percent = 0

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(false)
				arg_305_1:RecordContent(arg_305_1.text_.text)
			end

			local var_308_6 = math.max(var_308_2, arg_305_1.talkMaxDuration)

			if var_308_1 <= arg_305_1.time_ and arg_305_1.time_ < var_308_1 + var_308_6 then
				arg_305_1.typewritter.percent = (arg_305_1.time_ - var_308_1) / var_308_6

				arg_305_1.typewritter:SetDirty()
			end

			if arg_305_1.time_ >= var_308_1 + var_308_6 and arg_305_1.time_ < var_308_1 + var_308_6 + arg_308_0 then
				arg_305_1.typewritter.percent = 1

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(true)
			end
		end

		arg_305_1.nodeConfigList_ = {}

		arg_305_1:InitPlayNodeList()
	end,
	Play1109704076 = function(arg_309_0, arg_309_1)
		arg_309_1.time_ = 0
		arg_309_1.frameCnt_ = 0
		arg_309_1.state_ = "playing"
		arg_309_1.curTalkId_ = 1109704076
		arg_309_1.duration_ = 2

		SetActive(arg_309_1.tipsGo_, false)

		function arg_309_1.onSingleLineFinish_()
			arg_309_1.onSingleLineUpdate_ = nil
			arg_309_1.onSingleLineFinish_ = nil
			arg_309_1.state_ = "waiting"
		end

		function arg_309_1.playNext_(arg_311_0)
			if arg_311_0 == 1 then
				arg_309_0:Play1109704077(arg_309_1)
			end
		end

		function arg_309_1.onSingleLineUpdate_(arg_312_0)
			if 0 < arg_309_1.time_ and arg_309_1.time_ <= 0 + arg_312_0 then
				arg_309_1.var_.moveOldPos1097ui_story = arg_309_1.actors_["1097ui_story"].transform.localPosition
			end

			local var_312_0 = 0.001

			if 0 <= arg_309_1.time_ and arg_309_1.time_ < 0 + var_312_0 then
				arg_309_1.actors_["1097ui_story"].transform.localPosition = Vector3.Lerp(arg_309_1.var_.moveOldPos1097ui_story, Vector3.New(0, -0.54, -6.3), (arg_309_1.time_ - 0) / var_312_0)
				arg_309_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_309_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_309_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_309_1.actors_["1097ui_story"].transform.position).z)
				arg_309_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_309_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_309_1.actors_["1097ui_story"].transform.localEulerAngles = arg_309_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			if arg_309_1.time_ >= 0 + var_312_0 and arg_309_1.time_ < 0 + var_312_0 + arg_312_0 then
				arg_309_1.actors_["1097ui_story"].transform.localPosition = Vector3.New(0, -0.54, -6.3)
				arg_309_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_309_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_309_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_309_1.actors_["1097ui_story"].transform.position).z)
				arg_309_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_309_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_309_1.actors_["1097ui_story"].transform.localEulerAngles = arg_309_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			local var_312_1 = arg_309_1.actors_["1097ui_story"]

			if 0 < arg_309_1.time_ and arg_309_1.time_ <= 0 + arg_312_0 and not isNil(var_312_1) and arg_309_1.var_.characterEffect1097ui_story == nil then
				arg_309_1.var_.characterEffect1097ui_story = var_312_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_312_2 = 0.200000002980232

			if 0 <= arg_309_1.time_ and arg_309_1.time_ < 0 + var_312_2 and not isNil(var_312_1) then
				if arg_309_1.var_.characterEffect1097ui_story and not isNil(var_312_1) then
					arg_309_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_309_1.time_ >= 0 + var_312_2 and arg_309_1.time_ < 0 + var_312_2 + arg_312_0 and not isNil(var_312_1) and arg_309_1.var_.characterEffect1097ui_story then
				arg_309_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_309_1.time_ and arg_309_1.time_ <= 0 + arg_312_0 then
				arg_309_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			if 0 < arg_309_1.time_ and arg_309_1.time_ <= 0 + arg_312_0 then
				arg_309_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_312_4 = 0
			local var_312_5 = 0.05

			if 0 < arg_309_1.time_ and arg_309_1.time_ <= var_312_4 + arg_312_0 then
				arg_309_1.talkMaxDuration = 0
				arg_309_1.dialogCg_.alpha = 1

				arg_309_1.dialog_:SetActive(true)
				SetActive(arg_309_1.leftNameGo_, true)

				arg_309_1.leftNameTxt_.text = arg_309_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_309_1.leftNameTxt_.transform)

				arg_309_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_309_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_309_1:RecordName(arg_309_1.leftNameTxt_.text)
				SetActive(arg_309_1.iconTrs_.gameObject, false)
				arg_309_1.callingController_:SetSelectedState("normal")

				local var_312_6 = arg_309_1:GetWordFromCfg(1109704076)
				local var_312_7 = arg_309_1:FormatText(var_312_6.content)

				arg_309_1.text_.text = var_312_7

				LuaForUtil.ClearLinePrefixSymbol(arg_309_1.text_)

				local var_312_9 = 2 <= 0 and var_312_5 or var_312_5 * (utf8.len(var_312_7) / 2)

				if (2 <= 0 and var_312_5 or var_312_5 * (utf8.len(var_312_7) / 2)) > 0 and var_312_5 < var_312_9 then
					arg_309_1.talkMaxDuration = var_312_9

					if var_312_9 + var_312_4 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_9 + var_312_4
					end
				end

				arg_309_1.text_.text = var_312_7
				arg_309_1.typewritter.percent = 0

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704076", "story_v_side_new_1109704.awb") ~= 0 then
					local var_312_10 = manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704076", "story_v_side_new_1109704.awb") / 1000

					if var_312_10 + var_312_4 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_10 + var_312_4
					end

					if var_312_6.prefab_name ~= "" and arg_309_1.actors_[var_312_6.prefab_name] ~= nil then
						local var_312_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_309_1.actors_[var_312_6.prefab_name].transform, "story_v_side_new_1109704", "1109704076", "story_v_side_new_1109704.awb")

						arg_309_1:RecordAudio("1109704076", var_312_11)
						arg_309_1:RecordAudio("1109704076", var_312_11)
					else
						arg_309_1:AudioAction("play", "voice", "story_v_side_new_1109704", "1109704076", "story_v_side_new_1109704.awb")
					end

					arg_309_1:RecordHistoryTalkVoice("story_v_side_new_1109704", "1109704076", "story_v_side_new_1109704.awb")
				end

				arg_309_1:RecordContent(arg_309_1.text_.text)
			end

			local var_312_12 = math.max(var_312_5, arg_309_1.talkMaxDuration)

			if var_312_4 <= arg_309_1.time_ and arg_309_1.time_ < var_312_4 + var_312_12 then
				arg_309_1.typewritter.percent = (arg_309_1.time_ - var_312_4) / var_312_12

				arg_309_1.typewritter:SetDirty()
			end

			if arg_309_1.time_ >= var_312_4 + var_312_12 and arg_309_1.time_ < var_312_4 + var_312_12 + arg_312_0 then
				arg_309_1.typewritter.percent = 1

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(true)
			end
		end

		arg_309_1.nodeConfigList_ = {
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

		arg_309_1:InitPlayNodeList()
	end,
	Play1109704077 = function(arg_313_0, arg_313_1)
		arg_313_1.time_ = 0
		arg_313_1.frameCnt_ = 0
		arg_313_1.state_ = "playing"
		arg_313_1.curTalkId_ = 1109704077
		arg_313_1.duration_ = 5

		SetActive(arg_313_1.tipsGo_, false)

		function arg_313_1.onSingleLineFinish_()
			arg_313_1.onSingleLineUpdate_ = nil
			arg_313_1.onSingleLineFinish_ = nil
			arg_313_1.state_ = "waiting"
		end

		function arg_313_1.playNext_(arg_315_0)
			if arg_315_0 == 1 then
				arg_313_0:Play1109704078(arg_313_1)
			end
		end

		function arg_313_1.onSingleLineUpdate_(arg_316_0)
			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 and not isNil(arg_313_1.actors_["1097ui_story"]) and arg_313_1.var_.characterEffect1097ui_story == nil then
				arg_313_1.var_.characterEffect1097ui_story = arg_313_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_316_0 = 0.200000002980232

			if 0 <= arg_313_1.time_ and arg_313_1.time_ < 0 + var_316_0 and not isNil(arg_313_1.actors_["1097ui_story"]) then
				if arg_313_1.var_.characterEffect1097ui_story and not isNil(arg_313_1.actors_["1097ui_story"]) then
					arg_313_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_313_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_313_1.time_ - 0) / var_316_0)
				end
			end

			if arg_313_1.time_ >= 0 + var_316_0 and arg_313_1.time_ < 0 + var_316_0 + arg_316_0 and not isNil(arg_313_1.actors_["1097ui_story"]) and arg_313_1.var_.characterEffect1097ui_story then
				arg_313_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_313_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_316_1 = 0
			local var_316_2 = 1.1

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= var_316_1 + arg_316_0 then
				arg_313_1.talkMaxDuration = 0
				arg_313_1.dialogCg_.alpha = 1

				arg_313_1.dialog_:SetActive(true)
				SetActive(arg_313_1.leftNameGo_, false)

				arg_313_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_313_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_313_1:RecordName(arg_313_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_313_1.iconTrs_.gameObject, false)
				arg_313_1.callingController_:SetSelectedState("normal")

				local var_316_3 = arg_313_1:FormatText(arg_313_1:GetWordFromCfg(1109704077).content)

				arg_313_1.text_.text = var_316_3

				LuaForUtil.ClearLinePrefixSymbol(arg_313_1.text_)

				local var_316_5 = 44 <= 0 and var_316_2 or var_316_2 * (utf8.len(var_316_3) / 44)

				if (44 <= 0 and var_316_2 or var_316_2 * (utf8.len(var_316_3) / 44)) > 0 and var_316_2 < var_316_5 then
					arg_313_1.talkMaxDuration = var_316_5

					if var_316_5 + var_316_1 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_5 + var_316_1
					end
				end

				arg_313_1.text_.text = var_316_3
				arg_313_1.typewritter.percent = 0

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(false)
				arg_313_1:RecordContent(arg_313_1.text_.text)
			end

			local var_316_6 = math.max(var_316_2, arg_313_1.talkMaxDuration)

			if var_316_1 <= arg_313_1.time_ and arg_313_1.time_ < var_316_1 + var_316_6 then
				arg_313_1.typewritter.percent = (arg_313_1.time_ - var_316_1) / var_316_6

				arg_313_1.typewritter:SetDirty()
			end

			if arg_313_1.time_ >= var_316_1 + var_316_6 and arg_313_1.time_ < var_316_1 + var_316_6 + arg_316_0 then
				arg_313_1.typewritter.percent = 1

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(true)
			end
		end

		arg_313_1.nodeConfigList_ = {}

		arg_313_1:InitPlayNodeList()
	end,
	Play1109704078 = function(arg_317_0, arg_317_1)
		arg_317_1.time_ = 0
		arg_317_1.frameCnt_ = 0
		arg_317_1.state_ = "playing"
		arg_317_1.curTalkId_ = 1109704078
		arg_317_1.duration_ = 2.53

		local var_317_0 = {
			zh = 1.999999999999,
			ja = 2.533
		}
		local var_317_1 = manager.audio:GetLocalizationFlag()

		if var_317_0[var_317_1] ~= nil then
			arg_317_1.duration_ = var_317_0[var_317_1]
		end

		SetActive(arg_317_1.tipsGo_, false)

		function arg_317_1.onSingleLineFinish_()
			arg_317_1.onSingleLineUpdate_ = nil
			arg_317_1.onSingleLineFinish_ = nil
			arg_317_1.state_ = "waiting"
		end

		function arg_317_1.playNext_(arg_319_0)
			if arg_319_0 == 1 then
				arg_317_0:Play1109704079(arg_317_1)
			end
		end

		function arg_317_1.onSingleLineUpdate_(arg_320_0)
			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 and not isNil(arg_317_1.actors_["1097ui_story"]) and arg_317_1.var_.characterEffect1097ui_story == nil then
				arg_317_1.var_.characterEffect1097ui_story = arg_317_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_320_0 = 0.200000002980232

			if 0 <= arg_317_1.time_ and arg_317_1.time_ < 0 + var_320_0 and not isNil(arg_317_1.actors_["1097ui_story"]) then
				if arg_317_1.var_.characterEffect1097ui_story and not isNil(arg_317_1.actors_["1097ui_story"]) then
					arg_317_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_317_1.time_ >= 0 + var_320_0 and arg_317_1.time_ < 0 + var_320_0 + arg_320_0 and not isNil(arg_317_1.actors_["1097ui_story"]) and arg_317_1.var_.characterEffect1097ui_story then
				arg_317_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 then
				arg_317_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 then
				arg_317_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_320_2 = 0
			local var_320_3 = 0.125

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= var_320_2 + arg_320_0 then
				arg_317_1.talkMaxDuration = 0
				arg_317_1.dialogCg_.alpha = 1

				arg_317_1.dialog_:SetActive(true)
				SetActive(arg_317_1.leftNameGo_, true)

				arg_317_1.leftNameTxt_.text = arg_317_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_317_1.leftNameTxt_.transform)

				arg_317_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_317_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_317_1:RecordName(arg_317_1.leftNameTxt_.text)
				SetActive(arg_317_1.iconTrs_.gameObject, false)
				arg_317_1.callingController_:SetSelectedState("normal")

				local var_320_4 = arg_317_1:GetWordFromCfg(1109704078)
				local var_320_5 = arg_317_1:FormatText(var_320_4.content)

				arg_317_1.text_.text = var_320_5

				LuaForUtil.ClearLinePrefixSymbol(arg_317_1.text_)

				local var_320_7 = 5 <= 0 and var_320_3 or var_320_3 * (utf8.len(var_320_5) / 5)

				if (5 <= 0 and var_320_3 or var_320_3 * (utf8.len(var_320_5) / 5)) > 0 and var_320_3 < var_320_7 then
					arg_317_1.talkMaxDuration = var_320_7

					if var_320_7 + var_320_2 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_7 + var_320_2
					end
				end

				arg_317_1.text_.text = var_320_5
				arg_317_1.typewritter.percent = 0

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704078", "story_v_side_new_1109704.awb") ~= 0 then
					local var_320_8 = manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704078", "story_v_side_new_1109704.awb") / 1000

					if var_320_8 + var_320_2 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_8 + var_320_2
					end

					if var_320_4.prefab_name ~= "" and arg_317_1.actors_[var_320_4.prefab_name] ~= nil then
						local var_320_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_317_1.actors_[var_320_4.prefab_name].transform, "story_v_side_new_1109704", "1109704078", "story_v_side_new_1109704.awb")

						arg_317_1:RecordAudio("1109704078", var_320_9)
						arg_317_1:RecordAudio("1109704078", var_320_9)
					else
						arg_317_1:AudioAction("play", "voice", "story_v_side_new_1109704", "1109704078", "story_v_side_new_1109704.awb")
					end

					arg_317_1:RecordHistoryTalkVoice("story_v_side_new_1109704", "1109704078", "story_v_side_new_1109704.awb")
				end

				arg_317_1:RecordContent(arg_317_1.text_.text)
			end

			local var_320_10 = math.max(var_320_3, arg_317_1.talkMaxDuration)

			if var_320_2 <= arg_317_1.time_ and arg_317_1.time_ < var_320_2 + var_320_10 then
				arg_317_1.typewritter.percent = (arg_317_1.time_ - var_320_2) / var_320_10

				arg_317_1.typewritter:SetDirty()
			end

			if arg_317_1.time_ >= var_320_2 + var_320_10 and arg_317_1.time_ < var_320_2 + var_320_10 + arg_320_0 then
				arg_317_1.typewritter.percent = 1

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(true)
			end
		end

		arg_317_1.nodeConfigList_ = {}

		arg_317_1:InitPlayNodeList()
	end,
	Play1109704079 = function(arg_321_0, arg_321_1)
		arg_321_1.time_ = 0
		arg_321_1.frameCnt_ = 0
		arg_321_1.state_ = "playing"
		arg_321_1.curTalkId_ = 1109704079
		arg_321_1.duration_ = 5

		SetActive(arg_321_1.tipsGo_, false)

		function arg_321_1.onSingleLineFinish_()
			arg_321_1.onSingleLineUpdate_ = nil
			arg_321_1.onSingleLineFinish_ = nil
			arg_321_1.state_ = "waiting"
		end

		function arg_321_1.playNext_(arg_323_0)
			if arg_323_0 == 1 then
				arg_321_0:Play1109704080(arg_321_1)
			end
		end

		function arg_321_1.onSingleLineUpdate_(arg_324_0)
			if 0 < arg_321_1.time_ and arg_321_1.time_ <= 0 + arg_324_0 and not isNil(arg_321_1.actors_["1097ui_story"]) and arg_321_1.var_.characterEffect1097ui_story == nil then
				arg_321_1.var_.characterEffect1097ui_story = arg_321_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_324_0 = 0.200000002980232

			if 0 <= arg_321_1.time_ and arg_321_1.time_ < 0 + var_324_0 and not isNil(arg_321_1.actors_["1097ui_story"]) then
				if arg_321_1.var_.characterEffect1097ui_story and not isNil(arg_321_1.actors_["1097ui_story"]) then
					arg_321_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_321_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_321_1.time_ - 0) / var_324_0)
				end
			end

			if arg_321_1.time_ >= 0 + var_324_0 and arg_321_1.time_ < 0 + var_324_0 + arg_324_0 and not isNil(arg_321_1.actors_["1097ui_story"]) and arg_321_1.var_.characterEffect1097ui_story then
				arg_321_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_321_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_324_1 = 0
			local var_324_2 = 0.7

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

				local var_324_3 = arg_321_1:FormatText(arg_321_1:GetWordFromCfg(1109704079).content)

				arg_321_1.text_.text = var_324_3

				LuaForUtil.ClearLinePrefixSymbol(arg_321_1.text_)

				local var_324_5 = 28 <= 0 and var_324_2 or var_324_2 * (utf8.len(var_324_3) / 28)

				if (28 <= 0 and var_324_2 or var_324_2 * (utf8.len(var_324_3) / 28)) > 0 and var_324_2 < var_324_5 then
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
	Play1109704080 = function(arg_325_0, arg_325_1)
		arg_325_1.time_ = 0
		arg_325_1.frameCnt_ = 0
		arg_325_1.state_ = "playing"
		arg_325_1.curTalkId_ = 1109704080
		arg_325_1.duration_ = 6.3

		local var_325_0 = {
			zh = 6.3,
			ja = 6.2
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
				arg_325_0:Play1109704081(arg_325_1)
			end
		end

		function arg_325_1.onSingleLineUpdate_(arg_328_0)
			if 0 < arg_325_1.time_ and arg_325_1.time_ <= 0 + arg_328_0 then
				arg_325_1.var_.moveOldPos1097ui_story = arg_325_1.actors_["1097ui_story"].transform.localPosition
			end

			local var_328_0 = 0.001

			if 0 <= arg_325_1.time_ and arg_325_1.time_ < 0 + var_328_0 then
				arg_325_1.actors_["1097ui_story"].transform.localPosition = Vector3.Lerp(arg_325_1.var_.moveOldPos1097ui_story, Vector3.New(0, -0.54, -6.3), (arg_325_1.time_ - 0) / var_328_0)
				arg_325_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_325_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_325_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_325_1.actors_["1097ui_story"].transform.position).z)
				arg_325_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_325_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_325_1.actors_["1097ui_story"].transform.localEulerAngles = arg_325_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			if arg_325_1.time_ >= 0 + var_328_0 and arg_325_1.time_ < 0 + var_328_0 + arg_328_0 then
				arg_325_1.actors_["1097ui_story"].transform.localPosition = Vector3.New(0, -0.54, -6.3)
				arg_325_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_325_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_325_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_325_1.actors_["1097ui_story"].transform.position).z)
				arg_325_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_325_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_325_1.actors_["1097ui_story"].transform.localEulerAngles = arg_325_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			local var_328_1 = arg_325_1.actors_["1097ui_story"]

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= 0 + arg_328_0 and not isNil(var_328_1) and arg_325_1.var_.characterEffect1097ui_story == nil then
				arg_325_1.var_.characterEffect1097ui_story = var_328_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_328_2 = 0.200000002980232

			if 0 <= arg_325_1.time_ and arg_325_1.time_ < 0 + var_328_2 and not isNil(var_328_1) then
				if arg_325_1.var_.characterEffect1097ui_story and not isNil(var_328_1) then
					arg_325_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_325_1.time_ >= 0 + var_328_2 and arg_325_1.time_ < 0 + var_328_2 + arg_328_0 and not isNil(var_328_1) and arg_325_1.var_.characterEffect1097ui_story then
				arg_325_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= 0 + arg_328_0 then
				arg_325_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= 0 + arg_328_0 then
				arg_325_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_328_4 = 0
			local var_328_5 = 0.525

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= var_328_4 + arg_328_0 then
				arg_325_1.talkMaxDuration = 0
				arg_325_1.dialogCg_.alpha = 1

				arg_325_1.dialog_:SetActive(true)
				SetActive(arg_325_1.leftNameGo_, true)

				arg_325_1.leftNameTxt_.text = arg_325_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_325_1.leftNameTxt_.transform)

				arg_325_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_325_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_325_1:RecordName(arg_325_1.leftNameTxt_.text)
				SetActive(arg_325_1.iconTrs_.gameObject, false)
				arg_325_1.callingController_:SetSelectedState("normal")

				local var_328_6 = arg_325_1:GetWordFromCfg(1109704080)
				local var_328_7 = arg_325_1:FormatText(var_328_6.content)

				arg_325_1.text_.text = var_328_7

				LuaForUtil.ClearLinePrefixSymbol(arg_325_1.text_)

				local var_328_9 = 21 <= 0 and var_328_5 or var_328_5 * (utf8.len(var_328_7) / 21)

				if (21 <= 0 and var_328_5 or var_328_5 * (utf8.len(var_328_7) / 21)) > 0 and var_328_5 < var_328_9 then
					arg_325_1.talkMaxDuration = var_328_9

					if var_328_9 + var_328_4 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_9 + var_328_4
					end
				end

				arg_325_1.text_.text = var_328_7
				arg_325_1.typewritter.percent = 0

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704080", "story_v_side_new_1109704.awb") ~= 0 then
					local var_328_10 = manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704080", "story_v_side_new_1109704.awb") / 1000

					if var_328_10 + var_328_4 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_10 + var_328_4
					end

					if var_328_6.prefab_name ~= "" and arg_325_1.actors_[var_328_6.prefab_name] ~= nil then
						local var_328_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_325_1.actors_[var_328_6.prefab_name].transform, "story_v_side_new_1109704", "1109704080", "story_v_side_new_1109704.awb")

						arg_325_1:RecordAudio("1109704080", var_328_11)
						arg_325_1:RecordAudio("1109704080", var_328_11)
					else
						arg_325_1:AudioAction("play", "voice", "story_v_side_new_1109704", "1109704080", "story_v_side_new_1109704.awb")
					end

					arg_325_1:RecordHistoryTalkVoice("story_v_side_new_1109704", "1109704080", "story_v_side_new_1109704.awb")
				end

				arg_325_1:RecordContent(arg_325_1.text_.text)
			end

			local var_328_12 = math.max(var_328_5, arg_325_1.talkMaxDuration)

			if var_328_4 <= arg_325_1.time_ and arg_325_1.time_ < var_328_4 + var_328_12 then
				arg_325_1.typewritter.percent = (arg_325_1.time_ - var_328_4) / var_328_12

				arg_325_1.typewritter:SetDirty()
			end

			if arg_325_1.time_ >= var_328_4 + var_328_12 and arg_325_1.time_ < var_328_4 + var_328_12 + arg_328_0 then
				arg_325_1.typewritter.percent = 1

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(true)
			end
		end

		arg_325_1.nodeConfigList_ = {
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

		arg_325_1:InitPlayNodeList()
	end,
	Play1109704081 = function(arg_329_0, arg_329_1)
		arg_329_1.time_ = 0
		arg_329_1.frameCnt_ = 0
		arg_329_1.state_ = "playing"
		arg_329_1.curTalkId_ = 1109704081
		arg_329_1.duration_ = 5

		SetActive(arg_329_1.tipsGo_, false)

		function arg_329_1.onSingleLineFinish_()
			arg_329_1.onSingleLineUpdate_ = nil
			arg_329_1.onSingleLineFinish_ = nil
			arg_329_1.state_ = "waiting"
		end

		function arg_329_1.playNext_(arg_331_0)
			if arg_331_0 == 1 then
				arg_329_0:Play1109704082(arg_329_1)
			end
		end

		function arg_329_1.onSingleLineUpdate_(arg_332_0)
			if 0 < arg_329_1.time_ and arg_329_1.time_ <= 0 + arg_332_0 and not isNil(arg_329_1.actors_["1097ui_story"]) and arg_329_1.var_.characterEffect1097ui_story == nil then
				arg_329_1.var_.characterEffect1097ui_story = arg_329_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_332_0 = 0.200000002980232

			if 0 <= arg_329_1.time_ and arg_329_1.time_ < 0 + var_332_0 and not isNil(arg_329_1.actors_["1097ui_story"]) then
				if arg_329_1.var_.characterEffect1097ui_story and not isNil(arg_329_1.actors_["1097ui_story"]) then
					arg_329_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_329_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_329_1.time_ - 0) / var_332_0)
				end
			end

			if arg_329_1.time_ >= 0 + var_332_0 and arg_329_1.time_ < 0 + var_332_0 + arg_332_0 and not isNil(arg_329_1.actors_["1097ui_story"]) and arg_329_1.var_.characterEffect1097ui_story then
				arg_329_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_329_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_332_1 = 0
			local var_332_2 = 0.075

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

				local var_332_3 = arg_329_1:FormatText(arg_329_1:GetWordFromCfg(1109704081).content)

				arg_329_1.text_.text = var_332_3

				LuaForUtil.ClearLinePrefixSymbol(arg_329_1.text_)

				local var_332_5 = 3 <= 0 and var_332_2 or var_332_2 * (utf8.len(var_332_3) / 3)

				if (3 <= 0 and var_332_2 or var_332_2 * (utf8.len(var_332_3) / 3)) > 0 and var_332_2 < var_332_5 then
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
	Play1109704082 = function(arg_333_0, arg_333_1)
		arg_333_1.time_ = 0
		arg_333_1.frameCnt_ = 0
		arg_333_1.state_ = "playing"
		arg_333_1.curTalkId_ = 1109704082
		arg_333_1.duration_ = 8.93

		local var_333_0 = {
			zh = 8.933,
			ja = 8.466
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
				arg_333_0:Play1109704083(arg_333_1)
			end
		end

		function arg_333_1.onSingleLineUpdate_(arg_336_0)
			if 0 < arg_333_1.time_ and arg_333_1.time_ <= 0 + arg_336_0 and not isNil(arg_333_1.actors_["1097ui_story"]) and arg_333_1.var_.characterEffect1097ui_story == nil then
				arg_333_1.var_.characterEffect1097ui_story = arg_333_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_336_0 = 0.200000002980232

			if 0 <= arg_333_1.time_ and arg_333_1.time_ < 0 + var_336_0 and not isNil(arg_333_1.actors_["1097ui_story"]) then
				if arg_333_1.var_.characterEffect1097ui_story and not isNil(arg_333_1.actors_["1097ui_story"]) then
					arg_333_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_333_1.time_ >= 0 + var_336_0 and arg_333_1.time_ < 0 + var_336_0 + arg_336_0 and not isNil(arg_333_1.actors_["1097ui_story"]) and arg_333_1.var_.characterEffect1097ui_story then
				arg_333_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_333_1.time_ and arg_333_1.time_ <= 0 + arg_336_0 then
				arg_333_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action7_1")
			end

			if 0 < arg_333_1.time_ and arg_333_1.time_ <= 0 + arg_336_0 then
				arg_333_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_336_2 = 0
			local var_336_3 = 0.65

			if 0 < arg_333_1.time_ and arg_333_1.time_ <= var_336_2 + arg_336_0 then
				arg_333_1.talkMaxDuration = 0
				arg_333_1.dialogCg_.alpha = 1

				arg_333_1.dialog_:SetActive(true)
				SetActive(arg_333_1.leftNameGo_, true)

				arg_333_1.leftNameTxt_.text = arg_333_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_333_1.leftNameTxt_.transform)

				arg_333_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_333_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_333_1:RecordName(arg_333_1.leftNameTxt_.text)
				SetActive(arg_333_1.iconTrs_.gameObject, false)
				arg_333_1.callingController_:SetSelectedState("normal")

				local var_336_4 = arg_333_1:GetWordFromCfg(1109704082)
				local var_336_5 = arg_333_1:FormatText(var_336_4.content)

				arg_333_1.text_.text = var_336_5

				LuaForUtil.ClearLinePrefixSymbol(arg_333_1.text_)

				local var_336_7 = 26 <= 0 and var_336_3 or var_336_3 * (utf8.len(var_336_5) / 26)

				if (26 <= 0 and var_336_3 or var_336_3 * (utf8.len(var_336_5) / 26)) > 0 and var_336_3 < var_336_7 then
					arg_333_1.talkMaxDuration = var_336_7

					if var_336_7 + var_336_2 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_7 + var_336_2
					end
				end

				arg_333_1.text_.text = var_336_5
				arg_333_1.typewritter.percent = 0

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704082", "story_v_side_new_1109704.awb") ~= 0 then
					local var_336_8 = manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704082", "story_v_side_new_1109704.awb") / 1000

					if var_336_8 + var_336_2 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_8 + var_336_2
					end

					if var_336_4.prefab_name ~= "" and arg_333_1.actors_[var_336_4.prefab_name] ~= nil then
						local var_336_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_333_1.actors_[var_336_4.prefab_name].transform, "story_v_side_new_1109704", "1109704082", "story_v_side_new_1109704.awb")

						arg_333_1:RecordAudio("1109704082", var_336_9)
						arg_333_1:RecordAudio("1109704082", var_336_9)
					else
						arg_333_1:AudioAction("play", "voice", "story_v_side_new_1109704", "1109704082", "story_v_side_new_1109704.awb")
					end

					arg_333_1:RecordHistoryTalkVoice("story_v_side_new_1109704", "1109704082", "story_v_side_new_1109704.awb")
				end

				arg_333_1:RecordContent(arg_333_1.text_.text)
			end

			local var_336_10 = math.max(var_336_3, arg_333_1.talkMaxDuration)

			if var_336_2 <= arg_333_1.time_ and arg_333_1.time_ < var_336_2 + var_336_10 then
				arg_333_1.typewritter.percent = (arg_333_1.time_ - var_336_2) / var_336_10

				arg_333_1.typewritter:SetDirty()
			end

			if arg_333_1.time_ >= var_336_2 + var_336_10 and arg_333_1.time_ < var_336_2 + var_336_10 + arg_336_0 then
				arg_333_1.typewritter.percent = 1

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(true)
			end
		end

		arg_333_1.nodeConfigList_ = {}

		arg_333_1:InitPlayNodeList()
	end,
	Play1109704083 = function(arg_337_0, arg_337_1)
		arg_337_1.time_ = 0
		arg_337_1.frameCnt_ = 0
		arg_337_1.state_ = "playing"
		arg_337_1.curTalkId_ = 1109704083
		arg_337_1.duration_ = 5

		SetActive(arg_337_1.tipsGo_, false)

		function arg_337_1.onSingleLineFinish_()
			arg_337_1.onSingleLineUpdate_ = nil
			arg_337_1.onSingleLineFinish_ = nil
			arg_337_1.state_ = "waiting"
		end

		function arg_337_1.playNext_(arg_339_0)
			if arg_339_0 == 1 then
				arg_337_0:Play1109704084(arg_337_1)
			end
		end

		function arg_337_1.onSingleLineUpdate_(arg_340_0)
			if 0 < arg_337_1.time_ and arg_337_1.time_ <= 0 + arg_340_0 and not isNil(arg_337_1.actors_["1097ui_story"]) and arg_337_1.var_.characterEffect1097ui_story == nil then
				arg_337_1.var_.characterEffect1097ui_story = arg_337_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_340_0 = 0.200000002980232

			if 0 <= arg_337_1.time_ and arg_337_1.time_ < 0 + var_340_0 and not isNil(arg_337_1.actors_["1097ui_story"]) then
				if arg_337_1.var_.characterEffect1097ui_story and not isNil(arg_337_1.actors_["1097ui_story"]) then
					arg_337_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_337_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_337_1.time_ - 0) / var_340_0)
				end
			end

			if arg_337_1.time_ >= 0 + var_340_0 and arg_337_1.time_ < 0 + var_340_0 + arg_340_0 and not isNil(arg_337_1.actors_["1097ui_story"]) and arg_337_1.var_.characterEffect1097ui_story then
				arg_337_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_337_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_340_1 = 0
			local var_340_2 = 1.375

			if 0 < arg_337_1.time_ and arg_337_1.time_ <= var_340_1 + arg_340_0 then
				arg_337_1.talkMaxDuration = 0
				arg_337_1.dialogCg_.alpha = 1

				arg_337_1.dialog_:SetActive(true)
				SetActive(arg_337_1.leftNameGo_, true)

				arg_337_1.leftNameTxt_.text = arg_337_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_337_1.leftNameTxt_.transform)

				arg_337_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_337_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_337_1:RecordName(arg_337_1.leftNameTxt_.text)
				SetActive(arg_337_1.iconTrs_.gameObject, true)
				arg_337_1.iconController_:SetSelectedState("hero")

				arg_337_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_337_1.callingController_:SetSelectedState("normal")

				arg_337_1.keyicon_.color = Color.New(1, 1, 1)
				arg_337_1.icon_.color = Color.New(1, 1, 1)

				local var_340_3 = arg_337_1:FormatText(arg_337_1:GetWordFromCfg(1109704083).content)

				arg_337_1.text_.text = var_340_3

				LuaForUtil.ClearLinePrefixSymbol(arg_337_1.text_)

				local var_340_5 = 55 <= 0 and var_340_2 or var_340_2 * (utf8.len(var_340_3) / 55)

				if (55 <= 0 and var_340_2 or var_340_2 * (utf8.len(var_340_3) / 55)) > 0 and var_340_2 < var_340_5 then
					arg_337_1.talkMaxDuration = var_340_5

					if var_340_5 + var_340_1 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_5 + var_340_1
					end
				end

				arg_337_1.text_.text = var_340_3
				arg_337_1.typewritter.percent = 0

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(false)
				arg_337_1:RecordContent(arg_337_1.text_.text)
			end

			local var_340_6 = math.max(var_340_2, arg_337_1.talkMaxDuration)

			if var_340_1 <= arg_337_1.time_ and arg_337_1.time_ < var_340_1 + var_340_6 then
				arg_337_1.typewritter.percent = (arg_337_1.time_ - var_340_1) / var_340_6

				arg_337_1.typewritter:SetDirty()
			end

			if arg_337_1.time_ >= var_340_1 + var_340_6 and arg_337_1.time_ < var_340_1 + var_340_6 + arg_340_0 then
				arg_337_1.typewritter.percent = 1

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(true)
			end
		end

		arg_337_1.nodeConfigList_ = {}

		arg_337_1:InitPlayNodeList()
	end,
	Play1109704084 = function(arg_341_0, arg_341_1)
		arg_341_1.time_ = 0
		arg_341_1.frameCnt_ = 0
		arg_341_1.state_ = "playing"
		arg_341_1.curTalkId_ = 1109704084
		arg_341_1.duration_ = 2.7

		local var_341_0 = {
			zh = 1.999999999999,
			ja = 2.7
		}
		local var_341_1 = manager.audio:GetLocalizationFlag()

		if var_341_0[var_341_1] ~= nil then
			arg_341_1.duration_ = var_341_0[var_341_1]
		end

		SetActive(arg_341_1.tipsGo_, false)

		function arg_341_1.onSingleLineFinish_()
			arg_341_1.onSingleLineUpdate_ = nil
			arg_341_1.onSingleLineFinish_ = nil
			arg_341_1.state_ = "waiting"
		end

		function arg_341_1.playNext_(arg_343_0)
			if arg_343_0 == 1 then
				arg_341_0:Play1109704085(arg_341_1)
			end
		end

		function arg_341_1.onSingleLineUpdate_(arg_344_0)
			if 0 < arg_341_1.time_ and arg_341_1.time_ <= 0 + arg_344_0 and not isNil(arg_341_1.actors_["1097ui_story"]) and arg_341_1.var_.characterEffect1097ui_story == nil then
				arg_341_1.var_.characterEffect1097ui_story = arg_341_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_344_0 = 0.200000002980232

			if 0 <= arg_341_1.time_ and arg_341_1.time_ < 0 + var_344_0 and not isNil(arg_341_1.actors_["1097ui_story"]) then
				if arg_341_1.var_.characterEffect1097ui_story and not isNil(arg_341_1.actors_["1097ui_story"]) then
					arg_341_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_341_1.time_ >= 0 + var_344_0 and arg_341_1.time_ < 0 + var_344_0 + arg_344_0 and not isNil(arg_341_1.actors_["1097ui_story"]) and arg_341_1.var_.characterEffect1097ui_story then
				arg_341_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_341_1.time_ and arg_341_1.time_ <= 0 + arg_344_0 then
				arg_341_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action7_2")
			end

			if 0 < arg_341_1.time_ and arg_341_1.time_ <= 0 + arg_344_0 then
				arg_341_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_344_2 = 0
			local var_344_3 = 0.1

			if 0 < arg_341_1.time_ and arg_341_1.time_ <= var_344_2 + arg_344_0 then
				arg_341_1.talkMaxDuration = 0
				arg_341_1.dialogCg_.alpha = 1

				arg_341_1.dialog_:SetActive(true)
				SetActive(arg_341_1.leftNameGo_, true)

				arg_341_1.leftNameTxt_.text = arg_341_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_341_1.leftNameTxt_.transform)

				arg_341_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_341_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_341_1:RecordName(arg_341_1.leftNameTxt_.text)
				SetActive(arg_341_1.iconTrs_.gameObject, false)
				arg_341_1.callingController_:SetSelectedState("normal")

				local var_344_4 = arg_341_1:GetWordFromCfg(1109704084)
				local var_344_5 = arg_341_1:FormatText(var_344_4.content)

				arg_341_1.text_.text = var_344_5

				LuaForUtil.ClearLinePrefixSymbol(arg_341_1.text_)

				local var_344_7 = 4 <= 0 and var_344_3 or var_344_3 * (utf8.len(var_344_5) / 4)

				if (4 <= 0 and var_344_3 or var_344_3 * (utf8.len(var_344_5) / 4)) > 0 and var_344_3 < var_344_7 then
					arg_341_1.talkMaxDuration = var_344_7

					if var_344_7 + var_344_2 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_7 + var_344_2
					end
				end

				arg_341_1.text_.text = var_344_5
				arg_341_1.typewritter.percent = 0

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704084", "story_v_side_new_1109704.awb") ~= 0 then
					local var_344_8 = manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704084", "story_v_side_new_1109704.awb") / 1000

					if var_344_8 + var_344_2 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_8 + var_344_2
					end

					if var_344_4.prefab_name ~= "" and arg_341_1.actors_[var_344_4.prefab_name] ~= nil then
						local var_344_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_341_1.actors_[var_344_4.prefab_name].transform, "story_v_side_new_1109704", "1109704084", "story_v_side_new_1109704.awb")

						arg_341_1:RecordAudio("1109704084", var_344_9)
						arg_341_1:RecordAudio("1109704084", var_344_9)
					else
						arg_341_1:AudioAction("play", "voice", "story_v_side_new_1109704", "1109704084", "story_v_side_new_1109704.awb")
					end

					arg_341_1:RecordHistoryTalkVoice("story_v_side_new_1109704", "1109704084", "story_v_side_new_1109704.awb")
				end

				arg_341_1:RecordContent(arg_341_1.text_.text)
			end

			local var_344_10 = math.max(var_344_3, arg_341_1.talkMaxDuration)

			if var_344_2 <= arg_341_1.time_ and arg_341_1.time_ < var_344_2 + var_344_10 then
				arg_341_1.typewritter.percent = (arg_341_1.time_ - var_344_2) / var_344_10

				arg_341_1.typewritter:SetDirty()
			end

			if arg_341_1.time_ >= var_344_2 + var_344_10 and arg_341_1.time_ < var_344_2 + var_344_10 + arg_344_0 then
				arg_341_1.typewritter.percent = 1

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(true)
			end
		end

		arg_341_1.nodeConfigList_ = {}

		arg_341_1:InitPlayNodeList()
	end,
	Play1109704085 = function(arg_345_0, arg_345_1)
		arg_345_1.time_ = 0
		arg_345_1.frameCnt_ = 0
		arg_345_1.state_ = "playing"
		arg_345_1.curTalkId_ = 1109704085
		arg_345_1.duration_ = 12.37

		local var_345_0 = {
			zh = 8.965999999999,
			ja = 12.365999999999
		}
		local var_345_1 = manager.audio:GetLocalizationFlag()

		if var_345_0[var_345_1] ~= nil then
			arg_345_1.duration_ = var_345_0[var_345_1]
		end

		SetActive(arg_345_1.tipsGo_, false)

		function arg_345_1.onSingleLineFinish_()
			arg_345_1.onSingleLineUpdate_ = nil
			arg_345_1.onSingleLineFinish_ = nil
			arg_345_1.state_ = "waiting"
		end

		function arg_345_1.playNext_(arg_347_0)
			if arg_347_0 == 1 then
				arg_345_0:Play1109704086(arg_345_1)
			end
		end

		function arg_345_1.onSingleLineUpdate_(arg_348_0)
			if 2.00000000298023 < arg_345_1.time_ and arg_345_1.time_ <= 2.00000000298023 + arg_348_0 then
				local var_348_0 = arg_345_1.bgs_.ST60

				arg_345_1.bgs_.ST60.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_348_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_348_1 = var_348_0:GetComponent("SpriteRenderer")

				if var_348_1 and var_348_1.sprite then
					local var_348_2 = 2 * (var_348_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_348_0.transform.localScale = Vector3.New(var_348_2 / var_348_1.sprite.bounds.size.y < var_348_2 * manager.ui.mainCameraCom_.aspect / var_348_1.sprite.bounds.size.x and var_348_2 * manager.ui.mainCameraCom_.aspect / var_348_1.sprite.bounds.size.x or var_348_2 / var_348_1.sprite.bounds.size.y, var_348_2 / var_348_1.sprite.bounds.size.y < var_348_2 * manager.ui.mainCameraCom_.aspect / var_348_1.sprite.bounds.size.x and var_348_2 * manager.ui.mainCameraCom_.aspect / var_348_1.sprite.bounds.size.x or var_348_2 / var_348_1.sprite.bounds.size.y, 0)
				end

				for iter_348_0, iter_348_1 in pairs(arg_345_1.bgs_) do
					if iter_348_0 ~= "ST60" then
						iter_348_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_348_3 = 3.999999999999

			if 3.999999999999 < arg_345_1.time_ and arg_345_1.time_ <= var_348_3 + arg_348_0 then
				arg_345_1.allBtn_.enabled = false
			end

			if arg_345_1.time_ >= var_348_3 + 0.3 and arg_345_1.time_ < var_348_3 + 0.3 + arg_348_0 then
				arg_345_1.allBtn_.enabled = true
			end

			local var_348_4 = 0

			if 0 < arg_345_1.time_ and arg_345_1.time_ <= var_348_4 + arg_348_0 then
				arg_345_1.mask_.enabled = true
				arg_345_1.mask_.raycastTarget = true

				arg_345_1:SetGaussion(false)
			end

			local var_348_5 = 2

			if var_348_4 <= arg_345_1.time_ and arg_345_1.time_ < var_348_4 + var_348_5 then
				local var_348_6 = Color.New(1, 1, 1)

				var_348_6.a = Mathf.Lerp(0, 1, (arg_345_1.time_ - var_348_4) / var_348_5)
				arg_345_1.mask_.color = var_348_6
			end

			if arg_345_1.time_ >= var_348_4 + var_348_5 and arg_345_1.time_ < var_348_4 + var_348_5 + arg_348_0 then
				local var_348_7 = Color.New(1, 1, 1)

				var_348_7.a = 1
				arg_345_1.mask_.color = var_348_7
			end

			local var_348_8 = 2

			if 2 < arg_345_1.time_ and arg_345_1.time_ <= var_348_8 + arg_348_0 then
				arg_345_1.mask_.enabled = true
				arg_345_1.mask_.raycastTarget = true

				arg_345_1:SetGaussion(false)
			end

			local var_348_9 = 2

			if var_348_8 <= arg_345_1.time_ and arg_345_1.time_ < var_348_8 + var_348_9 then
				local var_348_10 = Color.New(1, 1, 1)

				var_348_10.a = Mathf.Lerp(1, 0, (arg_345_1.time_ - var_348_8) / var_348_9)
				arg_345_1.mask_.color = var_348_10
			end

			if arg_345_1.time_ >= var_348_8 + var_348_9 and arg_345_1.time_ < var_348_8 + var_348_9 + arg_348_0 then
				local var_348_11 = Color.New(1, 1, 1)

				arg_345_1.mask_.enabled = false
				var_348_11.a = 0
				arg_345_1.mask_.color = var_348_11
			end

			local var_348_12 = arg_345_1.actors_["1097ui_story"].transform

			if 3.8 < arg_345_1.time_ and arg_345_1.time_ <= 3.8 + arg_348_0 then
				arg_345_1.var_.moveOldPos1097ui_story = var_348_12.localPosition
			end

			local var_348_13 = 0.001

			if 3.8 <= arg_345_1.time_ and arg_345_1.time_ < 3.8 + var_348_13 then
				var_348_12.localPosition = Vector3.Lerp(arg_345_1.var_.moveOldPos1097ui_story, Vector3.New(0, -0.54, -6.3), (arg_345_1.time_ - 3.8) / var_348_13)
				var_348_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_348_12.position).x, (manager.ui.mainCamera.transform.position - var_348_12.position).y, (manager.ui.mainCamera.transform.position - var_348_12.position).z)
				var_348_12.localEulerAngles.z = 0
				var_348_12.localEulerAngles.x = 0
				var_348_12.localEulerAngles = var_348_12.localEulerAngles
			end

			if arg_345_1.time_ >= 3.8 + var_348_13 and arg_345_1.time_ < 3.8 + var_348_13 + arg_348_0 then
				var_348_12.localPosition = Vector3.New(0, -0.54, -6.3)
				var_348_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_348_12.position).x, (manager.ui.mainCamera.transform.position - var_348_12.position).y, (manager.ui.mainCamera.transform.position - var_348_12.position).z)
				var_348_12.localEulerAngles.z = 0
				var_348_12.localEulerAngles.x = 0
				var_348_12.localEulerAngles = var_348_12.localEulerAngles
			end

			local var_348_14 = arg_345_1.actors_["1097ui_story"]

			if 3.8 < arg_345_1.time_ and arg_345_1.time_ <= 3.8 + arg_348_0 and not isNil(var_348_14) and arg_345_1.var_.characterEffect1097ui_story == nil then
				arg_345_1.var_.characterEffect1097ui_story = var_348_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_348_15 = 0.200000002980232

			if 3.8 <= arg_345_1.time_ and arg_345_1.time_ < 3.8 + var_348_15 and not isNil(var_348_14) then
				if arg_345_1.var_.characterEffect1097ui_story and not isNil(var_348_14) then
					arg_345_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_345_1.time_ >= 3.8 + var_348_15 and arg_345_1.time_ < 3.8 + var_348_15 + arg_348_0 and not isNil(var_348_14) and arg_345_1.var_.characterEffect1097ui_story then
				arg_345_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 3.8 < arg_345_1.time_ and arg_345_1.time_ <= 3.8 + arg_348_0 then
				arg_345_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			if 3.8 < arg_345_1.time_ and arg_345_1.time_ <= 3.8 + arg_348_0 then
				arg_345_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_348_17 = arg_345_1.actors_["1097ui_story"].transform

			if 1.96599999815226 < arg_345_1.time_ and arg_345_1.time_ <= 1.96599999815226 + arg_348_0 then
				arg_345_1.var_.moveOldPos1097ui_story = var_348_17.localPosition
			end

			local var_348_18 = 0.001

			if 1.96599999815226 <= arg_345_1.time_ and arg_345_1.time_ < 1.96599999815226 + var_348_18 then
				var_348_17.localPosition = Vector3.Lerp(arg_345_1.var_.moveOldPos1097ui_story, Vector3.New(0, 100, 0), (arg_345_1.time_ - 1.96599999815226) / var_348_18)
				var_348_17.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_348_17.position).x, (manager.ui.mainCamera.transform.position - var_348_17.position).y, (manager.ui.mainCamera.transform.position - var_348_17.position).z)
				var_348_17.localEulerAngles.z = 0
				var_348_17.localEulerAngles.x = 0
				var_348_17.localEulerAngles = var_348_17.localEulerAngles
			end

			if arg_345_1.time_ >= 1.96599999815226 + var_348_18 and arg_345_1.time_ < 1.96599999815226 + var_348_18 + arg_348_0 then
				var_348_17.localPosition = Vector3.New(0, 100, 0)
				var_348_17.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_348_17.position).x, (manager.ui.mainCamera.transform.position - var_348_17.position).y, (manager.ui.mainCamera.transform.position - var_348_17.position).z)
				var_348_17.localEulerAngles.z = 0
				var_348_17.localEulerAngles.x = 0
				var_348_17.localEulerAngles = var_348_17.localEulerAngles
			end

			if arg_345_1.frameCnt_ <= 1 then
				arg_345_1.dialog_:SetActive(false)
			end

			local var_348_19 = 3.999999999999
			local var_348_20 = 0.375

			if 3.999999999999 < arg_345_1.time_ and arg_345_1.time_ <= var_348_19 + arg_348_0 then
				arg_345_1.talkMaxDuration = 0

				arg_345_1.dialog_:SetActive(true)

				arg_345_1.dialogCg_.alpha = 0

				local var_348_21 = LeanTween.value(arg_345_1.dialog_, 0, 1, 0.3)

				var_348_21:setOnUpdate(LuaHelper.FloatAction(function(arg_349_0)
					arg_345_1.dialogCg_.alpha = arg_349_0
				end))
				var_348_21:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_345_1.dialog_)
					var_348_21:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_345_1.duration_ = arg_345_1.duration_ + 0.3

				SetActive(arg_345_1.leftNameGo_, true)

				arg_345_1.leftNameTxt_.text = arg_345_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_345_1.leftNameTxt_.transform)

				arg_345_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_345_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_345_1:RecordName(arg_345_1.leftNameTxt_.text)
				SetActive(arg_345_1.iconTrs_.gameObject, false)
				arg_345_1.callingController_:SetSelectedState("normal")

				local var_348_22 = arg_345_1:GetWordFromCfg(1109704085)
				local var_348_23 = arg_345_1:FormatText(var_348_22.content)

				arg_345_1.text_.text = var_348_23

				LuaForUtil.ClearLinePrefixSymbol(arg_345_1.text_)

				local var_348_25 = 15 <= 0 and var_348_20 or var_348_20 * (utf8.len(var_348_23) / 15)

				if (15 <= 0 and var_348_20 or var_348_20 * (utf8.len(var_348_23) / 15)) > 0 and var_348_20 < var_348_25 then
					arg_345_1.talkMaxDuration = var_348_25
					var_348_19 = var_348_19 + 0.3

					if var_348_25 + var_348_19 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_25 + var_348_19
					end
				end

				arg_345_1.text_.text = var_348_23
				arg_345_1.typewritter.percent = 0

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704085", "story_v_side_new_1109704.awb") ~= 0 then
					local var_348_26 = manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704085", "story_v_side_new_1109704.awb") / 1000

					if var_348_26 + var_348_19 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_26 + var_348_19
					end

					if var_348_22.prefab_name ~= "" and arg_345_1.actors_[var_348_22.prefab_name] ~= nil then
						local var_348_27 = LuaForUtil.PlayVoiceWithCriLipsync(arg_345_1.actors_[var_348_22.prefab_name].transform, "story_v_side_new_1109704", "1109704085", "story_v_side_new_1109704.awb")

						arg_345_1:RecordAudio("1109704085", var_348_27)
						arg_345_1:RecordAudio("1109704085", var_348_27)
					else
						arg_345_1:AudioAction("play", "voice", "story_v_side_new_1109704", "1109704085", "story_v_side_new_1109704.awb")
					end

					arg_345_1:RecordHistoryTalkVoice("story_v_side_new_1109704", "1109704085", "story_v_side_new_1109704.awb")
				end

				arg_345_1:RecordContent(arg_345_1.text_.text)
			end

			local var_348_28 = var_348_19 + 0.3
			local var_348_29 = math.max(var_348_20, arg_345_1.talkMaxDuration)

			if var_348_19 + 0.3 <= arg_345_1.time_ and arg_345_1.time_ < var_348_28 + var_348_29 then
				arg_345_1.typewritter.percent = (arg_345_1.time_ - var_348_28) / var_348_29

				arg_345_1.typewritter:SetDirty()
			end

			if arg_345_1.time_ >= var_348_28 + var_348_29 and arg_345_1.time_ < var_348_28 + var_348_29 + arg_348_0 then
				arg_345_1.typewritter.percent = 1

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(true)
			end
		end

		arg_345_1.nodeConfigList_ = {
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
			}
		}

		arg_345_1:InitPlayNodeList()
	end,
	Play1109704086 = function(arg_351_0, arg_351_1)
		arg_351_1.time_ = 0
		arg_351_1.frameCnt_ = 0
		arg_351_1.state_ = "playing"
		arg_351_1.curTalkId_ = 1109704086
		arg_351_1.duration_ = 5

		SetActive(arg_351_1.tipsGo_, false)

		function arg_351_1.onSingleLineFinish_()
			arg_351_1.onSingleLineUpdate_ = nil
			arg_351_1.onSingleLineFinish_ = nil
			arg_351_1.state_ = "waiting"
		end

		function arg_351_1.playNext_(arg_353_0)
			if arg_353_0 == 1 then
				arg_351_0:Play1109704087(arg_351_1)
			end
		end

		function arg_351_1.onSingleLineUpdate_(arg_354_0)
			if 0 < arg_351_1.time_ and arg_351_1.time_ <= 0 + arg_354_0 and not isNil(arg_351_1.actors_["1097ui_story"]) and arg_351_1.var_.characterEffect1097ui_story == nil then
				arg_351_1.var_.characterEffect1097ui_story = arg_351_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_354_0 = 0.200000002980232

			if 0 <= arg_351_1.time_ and arg_351_1.time_ < 0 + var_354_0 and not isNil(arg_351_1.actors_["1097ui_story"]) then
				if arg_351_1.var_.characterEffect1097ui_story and not isNil(arg_351_1.actors_["1097ui_story"]) then
					arg_351_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_351_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_351_1.time_ - 0) / var_354_0)
				end
			end

			if arg_351_1.time_ >= 0 + var_354_0 and arg_351_1.time_ < 0 + var_354_0 + arg_354_0 and not isNil(arg_351_1.actors_["1097ui_story"]) and arg_351_1.var_.characterEffect1097ui_story then
				arg_351_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_351_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_354_1 = 0
			local var_354_2 = 0.425

			if 0 < arg_351_1.time_ and arg_351_1.time_ <= var_354_1 + arg_354_0 then
				arg_351_1.talkMaxDuration = 0
				arg_351_1.dialogCg_.alpha = 1

				arg_351_1.dialog_:SetActive(true)
				SetActive(arg_351_1.leftNameGo_, true)

				arg_351_1.leftNameTxt_.text = arg_351_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_351_1.leftNameTxt_.transform)

				arg_351_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_351_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_351_1:RecordName(arg_351_1.leftNameTxt_.text)
				SetActive(arg_351_1.iconTrs_.gameObject, true)
				arg_351_1.iconController_:SetSelectedState("hero")

				arg_351_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_351_1.callingController_:SetSelectedState("normal")

				arg_351_1.keyicon_.color = Color.New(1, 1, 1)
				arg_351_1.icon_.color = Color.New(1, 1, 1)

				local var_354_3 = arg_351_1:FormatText(arg_351_1:GetWordFromCfg(1109704086).content)

				arg_351_1.text_.text = var_354_3

				LuaForUtil.ClearLinePrefixSymbol(arg_351_1.text_)

				local var_354_5 = 17 <= 0 and var_354_2 or var_354_2 * (utf8.len(var_354_3) / 17)

				if (17 <= 0 and var_354_2 or var_354_2 * (utf8.len(var_354_3) / 17)) > 0 and var_354_2 < var_354_5 then
					arg_351_1.talkMaxDuration = var_354_5

					if var_354_5 + var_354_1 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_5 + var_354_1
					end
				end

				arg_351_1.text_.text = var_354_3
				arg_351_1.typewritter.percent = 0

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(false)
				arg_351_1:RecordContent(arg_351_1.text_.text)
			end

			local var_354_6 = math.max(var_354_2, arg_351_1.talkMaxDuration)

			if var_354_1 <= arg_351_1.time_ and arg_351_1.time_ < var_354_1 + var_354_6 then
				arg_351_1.typewritter.percent = (arg_351_1.time_ - var_354_1) / var_354_6

				arg_351_1.typewritter:SetDirty()
			end

			if arg_351_1.time_ >= var_354_1 + var_354_6 and arg_351_1.time_ < var_354_1 + var_354_6 + arg_354_0 then
				arg_351_1.typewritter.percent = 1

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(true)
			end
		end

		arg_351_1.nodeConfigList_ = {}

		arg_351_1:InitPlayNodeList()
	end,
	Play1109704087 = function(arg_355_0, arg_355_1)
		arg_355_1.time_ = 0
		arg_355_1.frameCnt_ = 0
		arg_355_1.state_ = "playing"
		arg_355_1.curTalkId_ = 1109704087
		arg_355_1.duration_ = 5

		SetActive(arg_355_1.tipsGo_, false)

		function arg_355_1.onSingleLineFinish_()
			arg_355_1.onSingleLineUpdate_ = nil
			arg_355_1.onSingleLineFinish_ = nil
			arg_355_1.state_ = "waiting"
		end

		function arg_355_1.playNext_(arg_357_0)
			if arg_357_0 == 1 then
				arg_355_0:Play1109704088(arg_355_1)
			end
		end

		function arg_355_1.onSingleLineUpdate_(arg_358_0)
			local var_358_0 = 1.6

			if 0 < arg_355_1.time_ and arg_355_1.time_ <= 0 + arg_358_0 then
				arg_355_1.talkMaxDuration = 0
				arg_355_1.dialogCg_.alpha = 1

				arg_355_1.dialog_:SetActive(true)
				SetActive(arg_355_1.leftNameGo_, false)

				arg_355_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_355_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_355_1:RecordName(arg_355_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_355_1.iconTrs_.gameObject, false)
				arg_355_1.callingController_:SetSelectedState("normal")

				local var_358_1 = arg_355_1:FormatText(arg_355_1:GetWordFromCfg(1109704087).content)

				arg_355_1.text_.text = var_358_1

				LuaForUtil.ClearLinePrefixSymbol(arg_355_1.text_)

				local var_358_3 = 64 <= 0 and var_358_0 or var_358_0 * (utf8.len(var_358_1) / 64)

				if (64 <= 0 and var_358_0 or var_358_0 * (utf8.len(var_358_1) / 64)) > 0 and var_358_0 < var_358_3 then
					arg_355_1.talkMaxDuration = var_358_3

					if var_358_3 + 0 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_3 + 0
					end
				end

				arg_355_1.text_.text = var_358_1
				arg_355_1.typewritter.percent = 0

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(false)
				arg_355_1:RecordContent(arg_355_1.text_.text)
			end

			local var_358_4 = math.max(var_358_0, arg_355_1.talkMaxDuration)

			if 0 <= arg_355_1.time_ and arg_355_1.time_ < 0 + var_358_4 then
				arg_355_1.typewritter.percent = (arg_355_1.time_ - 0) / var_358_4

				arg_355_1.typewritter:SetDirty()
			end

			if arg_355_1.time_ >= 0 + var_358_4 and arg_355_1.time_ < 0 + var_358_4 + arg_358_0 then
				arg_355_1.typewritter.percent = 1

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(true)
			end
		end

		arg_355_1.nodeConfigList_ = {}

		arg_355_1:InitPlayNodeList()
	end,
	Play1109704088 = function(arg_359_0, arg_359_1)
		arg_359_1.time_ = 0
		arg_359_1.frameCnt_ = 0
		arg_359_1.state_ = "playing"
		arg_359_1.curTalkId_ = 1109704088
		arg_359_1.duration_ = 4.3

		local var_359_0 = {
			zh = 4.3,
			ja = 3.566
		}
		local var_359_1 = manager.audio:GetLocalizationFlag()

		if var_359_0[var_359_1] ~= nil then
			arg_359_1.duration_ = var_359_0[var_359_1]
		end

		SetActive(arg_359_1.tipsGo_, false)

		function arg_359_1.onSingleLineFinish_()
			arg_359_1.onSingleLineUpdate_ = nil
			arg_359_1.onSingleLineFinish_ = nil
			arg_359_1.state_ = "waiting"
		end

		function arg_359_1.playNext_(arg_361_0)
			if arg_361_0 == 1 then
				arg_359_0:Play1109704089(arg_359_1)
			end
		end

		function arg_359_1.onSingleLineUpdate_(arg_362_0)
			if 0 < arg_359_1.time_ and arg_359_1.time_ <= 0 + arg_362_0 and not isNil(arg_359_1.actors_["1097ui_story"]) and arg_359_1.var_.characterEffect1097ui_story == nil then
				arg_359_1.var_.characterEffect1097ui_story = arg_359_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_362_0 = 0.200000002980232

			if 0 <= arg_359_1.time_ and arg_359_1.time_ < 0 + var_362_0 and not isNil(arg_359_1.actors_["1097ui_story"]) then
				if arg_359_1.var_.characterEffect1097ui_story and not isNil(arg_359_1.actors_["1097ui_story"]) then
					arg_359_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_359_1.time_ >= 0 + var_362_0 and arg_359_1.time_ < 0 + var_362_0 + arg_362_0 and not isNil(arg_359_1.actors_["1097ui_story"]) and arg_359_1.var_.characterEffect1097ui_story then
				arg_359_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_359_1.time_ and arg_359_1.time_ <= 0 + arg_362_0 then
				arg_359_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action6_1")
			end

			if 0 < arg_359_1.time_ and arg_359_1.time_ <= 0 + arg_362_0 then
				arg_359_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_362_2 = 0
			local var_362_3 = 0.575

			if 0 < arg_359_1.time_ and arg_359_1.time_ <= var_362_2 + arg_362_0 then
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

				local var_362_4 = arg_359_1:GetWordFromCfg(1109704088)
				local var_362_5 = arg_359_1:FormatText(var_362_4.content)

				arg_359_1.text_.text = var_362_5

				LuaForUtil.ClearLinePrefixSymbol(arg_359_1.text_)

				local var_362_7 = 23 <= 0 and var_362_3 or var_362_3 * (utf8.len(var_362_5) / 23)

				if (23 <= 0 and var_362_3 or var_362_3 * (utf8.len(var_362_5) / 23)) > 0 and var_362_3 < var_362_7 then
					arg_359_1.talkMaxDuration = var_362_7

					if var_362_7 + var_362_2 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_7 + var_362_2
					end
				end

				arg_359_1.text_.text = var_362_5
				arg_359_1.typewritter.percent = 0

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704088", "story_v_side_new_1109704.awb") ~= 0 then
					local var_362_8 = manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704088", "story_v_side_new_1109704.awb") / 1000

					if var_362_8 + var_362_2 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_8 + var_362_2
					end

					if var_362_4.prefab_name ~= "" and arg_359_1.actors_[var_362_4.prefab_name] ~= nil then
						local var_362_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_359_1.actors_[var_362_4.prefab_name].transform, "story_v_side_new_1109704", "1109704088", "story_v_side_new_1109704.awb")

						arg_359_1:RecordAudio("1109704088", var_362_9)
						arg_359_1:RecordAudio("1109704088", var_362_9)
					else
						arg_359_1:AudioAction("play", "voice", "story_v_side_new_1109704", "1109704088", "story_v_side_new_1109704.awb")
					end

					arg_359_1:RecordHistoryTalkVoice("story_v_side_new_1109704", "1109704088", "story_v_side_new_1109704.awb")
				end

				arg_359_1:RecordContent(arg_359_1.text_.text)
			end

			local var_362_10 = math.max(var_362_3, arg_359_1.talkMaxDuration)

			if var_362_2 <= arg_359_1.time_ and arg_359_1.time_ < var_362_2 + var_362_10 then
				arg_359_1.typewritter.percent = (arg_359_1.time_ - var_362_2) / var_362_10

				arg_359_1.typewritter:SetDirty()
			end

			if arg_359_1.time_ >= var_362_2 + var_362_10 and arg_359_1.time_ < var_362_2 + var_362_10 + arg_362_0 then
				arg_359_1.typewritter.percent = 1

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(true)
			end
		end

		arg_359_1.nodeConfigList_ = {}

		arg_359_1:InitPlayNodeList()
	end,
	Play1109704089 = function(arg_363_0, arg_363_1)
		arg_363_1.time_ = 0
		arg_363_1.frameCnt_ = 0
		arg_363_1.state_ = "playing"
		arg_363_1.curTalkId_ = 1109704089
		arg_363_1.duration_ = 5

		SetActive(arg_363_1.tipsGo_, false)

		function arg_363_1.onSingleLineFinish_()
			arg_363_1.onSingleLineUpdate_ = nil
			arg_363_1.onSingleLineFinish_ = nil
			arg_363_1.state_ = "waiting"
		end

		function arg_363_1.playNext_(arg_365_0)
			if arg_365_0 == 1 then
				arg_363_0:Play1109704090(arg_363_1)
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
			local var_366_2 = 0.6

			if 0 < arg_363_1.time_ and arg_363_1.time_ <= var_366_1 + arg_366_0 then
				arg_363_1.talkMaxDuration = 0
				arg_363_1.dialogCg_.alpha = 1

				arg_363_1.dialog_:SetActive(true)
				SetActive(arg_363_1.leftNameGo_, true)

				arg_363_1.leftNameTxt_.text = arg_363_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_363_1.leftNameTxt_.transform)

				arg_363_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_363_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_363_1:RecordName(arg_363_1.leftNameTxt_.text)
				SetActive(arg_363_1.iconTrs_.gameObject, true)
				arg_363_1.iconController_:SetSelectedState("hero")

				arg_363_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_363_1.callingController_:SetSelectedState("normal")

				arg_363_1.keyicon_.color = Color.New(1, 1, 1)
				arg_363_1.icon_.color = Color.New(1, 1, 1)

				local var_366_3 = arg_363_1:FormatText(arg_363_1:GetWordFromCfg(1109704089).content)

				arg_363_1.text_.text = var_366_3

				LuaForUtil.ClearLinePrefixSymbol(arg_363_1.text_)

				local var_366_5 = 24 <= 0 and var_366_2 or var_366_2 * (utf8.len(var_366_3) / 24)

				if (24 <= 0 and var_366_2 or var_366_2 * (utf8.len(var_366_3) / 24)) > 0 and var_366_2 < var_366_5 then
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
	Play1109704090 = function(arg_367_0, arg_367_1)
		arg_367_1.time_ = 0
		arg_367_1.frameCnt_ = 0
		arg_367_1.state_ = "playing"
		arg_367_1.curTalkId_ = 1109704090
		arg_367_1.duration_ = 5

		SetActive(arg_367_1.tipsGo_, false)

		function arg_367_1.onSingleLineFinish_()
			arg_367_1.onSingleLineUpdate_ = nil
			arg_367_1.onSingleLineFinish_ = nil
			arg_367_1.state_ = "waiting"
		end

		function arg_367_1.playNext_(arg_369_0)
			if arg_369_0 == 1 then
				arg_367_0:Play1109704091(arg_367_1)
			end
		end

		function arg_367_1.onSingleLineUpdate_(arg_370_0)
			local var_370_0 = 0.3

			if 0 < arg_367_1.time_ and arg_367_1.time_ <= 0 + arg_370_0 then
				arg_367_1.talkMaxDuration = 0
				arg_367_1.dialogCg_.alpha = 1

				arg_367_1.dialog_:SetActive(true)
				SetActive(arg_367_1.leftNameGo_, false)

				arg_367_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_367_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_367_1:RecordName(arg_367_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_367_1.iconTrs_.gameObject, false)
				arg_367_1.callingController_:SetSelectedState("normal")

				local var_370_1 = arg_367_1:FormatText(arg_367_1:GetWordFromCfg(1109704090).content)

				arg_367_1.text_.text = var_370_1

				LuaForUtil.ClearLinePrefixSymbol(arg_367_1.text_)

				local var_370_3 = 12 <= 0 and var_370_0 or var_370_0 * (utf8.len(var_370_1) / 12)

				if (12 <= 0 and var_370_0 or var_370_0 * (utf8.len(var_370_1) / 12)) > 0 and var_370_0 < var_370_3 then
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
	Play1109704091 = function(arg_371_0, arg_371_1)
		arg_371_1.time_ = 0
		arg_371_1.frameCnt_ = 0
		arg_371_1.state_ = "playing"
		arg_371_1.curTalkId_ = 1109704091
		arg_371_1.duration_ = 4.33

		local var_371_0 = {
			zh = 4.333,
			ja = 2.933
		}
		local var_371_1 = manager.audio:GetLocalizationFlag()

		if var_371_0[var_371_1] ~= nil then
			arg_371_1.duration_ = var_371_0[var_371_1]
		end

		SetActive(arg_371_1.tipsGo_, false)

		function arg_371_1.onSingleLineFinish_()
			arg_371_1.onSingleLineUpdate_ = nil
			arg_371_1.onSingleLineFinish_ = nil
			arg_371_1.state_ = "waiting"
		end

		function arg_371_1.playNext_(arg_373_0)
			if arg_373_0 == 1 then
				arg_371_0:Play1109704092(arg_371_1)
			end
		end

		function arg_371_1.onSingleLineUpdate_(arg_374_0)
			if 0 < arg_371_1.time_ and arg_371_1.time_ <= 0 + arg_374_0 and not isNil(arg_371_1.actors_["1097ui_story"]) and arg_371_1.var_.characterEffect1097ui_story == nil then
				arg_371_1.var_.characterEffect1097ui_story = arg_371_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_374_0 = 0.200000002980232

			if 0 <= arg_371_1.time_ and arg_371_1.time_ < 0 + var_374_0 and not isNil(arg_371_1.actors_["1097ui_story"]) then
				if arg_371_1.var_.characterEffect1097ui_story and not isNil(arg_371_1.actors_["1097ui_story"]) then
					arg_371_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_371_1.time_ >= 0 + var_374_0 and arg_371_1.time_ < 0 + var_374_0 + arg_374_0 and not isNil(arg_371_1.actors_["1097ui_story"]) and arg_371_1.var_.characterEffect1097ui_story then
				arg_371_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_371_1.time_ and arg_371_1.time_ <= 0 + arg_374_0 then
				arg_371_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action6_2")
			end

			if 0 < arg_371_1.time_ and arg_371_1.time_ <= 0 + arg_374_0 then
				arg_371_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_374_2 = 0
			local var_374_3 = 0.575

			if 0 < arg_371_1.time_ and arg_371_1.time_ <= var_374_2 + arg_374_0 then
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

				local var_374_4 = arg_371_1:GetWordFromCfg(1109704091)
				local var_374_5 = arg_371_1:FormatText(var_374_4.content)

				arg_371_1.text_.text = var_374_5

				LuaForUtil.ClearLinePrefixSymbol(arg_371_1.text_)

				local var_374_7 = 23 <= 0 and var_374_3 or var_374_3 * (utf8.len(var_374_5) / 23)

				if (23 <= 0 and var_374_3 or var_374_3 * (utf8.len(var_374_5) / 23)) > 0 and var_374_3 < var_374_7 then
					arg_371_1.talkMaxDuration = var_374_7

					if var_374_7 + var_374_2 > arg_371_1.duration_ then
						arg_371_1.duration_ = var_374_7 + var_374_2
					end
				end

				arg_371_1.text_.text = var_374_5
				arg_371_1.typewritter.percent = 0

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704091", "story_v_side_new_1109704.awb") ~= 0 then
					local var_374_8 = manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704091", "story_v_side_new_1109704.awb") / 1000

					if var_374_8 + var_374_2 > arg_371_1.duration_ then
						arg_371_1.duration_ = var_374_8 + var_374_2
					end

					if var_374_4.prefab_name ~= "" and arg_371_1.actors_[var_374_4.prefab_name] ~= nil then
						local var_374_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_371_1.actors_[var_374_4.prefab_name].transform, "story_v_side_new_1109704", "1109704091", "story_v_side_new_1109704.awb")

						arg_371_1:RecordAudio("1109704091", var_374_9)
						arg_371_1:RecordAudio("1109704091", var_374_9)
					else
						arg_371_1:AudioAction("play", "voice", "story_v_side_new_1109704", "1109704091", "story_v_side_new_1109704.awb")
					end

					arg_371_1:RecordHistoryTalkVoice("story_v_side_new_1109704", "1109704091", "story_v_side_new_1109704.awb")
				end

				arg_371_1:RecordContent(arg_371_1.text_.text)
			end

			local var_374_10 = math.max(var_374_3, arg_371_1.talkMaxDuration)

			if var_374_2 <= arg_371_1.time_ and arg_371_1.time_ < var_374_2 + var_374_10 then
				arg_371_1.typewritter.percent = (arg_371_1.time_ - var_374_2) / var_374_10

				arg_371_1.typewritter:SetDirty()
			end

			if arg_371_1.time_ >= var_374_2 + var_374_10 and arg_371_1.time_ < var_374_2 + var_374_10 + arg_374_0 then
				arg_371_1.typewritter.percent = 1

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(true)
			end
		end

		arg_371_1.nodeConfigList_ = {}

		arg_371_1:InitPlayNodeList()
	end,
	Play1109704092 = function(arg_375_0, arg_375_1)
		arg_375_1.time_ = 0
		arg_375_1.frameCnt_ = 0
		arg_375_1.state_ = "playing"
		arg_375_1.curTalkId_ = 1109704092
		arg_375_1.duration_ = 9.07

		local var_375_0 = {
			zh = 7.433,
			ja = 9.066
		}
		local var_375_1 = manager.audio:GetLocalizationFlag()

		if var_375_0[var_375_1] ~= nil then
			arg_375_1.duration_ = var_375_0[var_375_1]
		end

		SetActive(arg_375_1.tipsGo_, false)

		function arg_375_1.onSingleLineFinish_()
			arg_375_1.onSingleLineUpdate_ = nil
			arg_375_1.onSingleLineFinish_ = nil
			arg_375_1.state_ = "waiting"
		end

		function arg_375_1.playNext_(arg_377_0)
			if arg_377_0 == 1 then
				arg_375_0:Play1109704093(arg_375_1)
			end
		end

		function arg_375_1.onSingleLineUpdate_(arg_378_0)
			if 0 < arg_375_1.time_ and arg_375_1.time_ <= 0 + arg_378_0 then
				arg_375_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			if 0 < arg_375_1.time_ and arg_375_1.time_ <= 0 + arg_378_0 then
				arg_375_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_378_0 = 0
			local var_378_1 = 0.9

			if 0 < arg_375_1.time_ and arg_375_1.time_ <= var_378_0 + arg_378_0 then
				arg_375_1.talkMaxDuration = 0
				arg_375_1.dialogCg_.alpha = 1

				arg_375_1.dialog_:SetActive(true)
				SetActive(arg_375_1.leftNameGo_, true)

				arg_375_1.leftNameTxt_.text = arg_375_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_375_1.leftNameTxt_.transform)

				arg_375_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_375_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_375_1:RecordName(arg_375_1.leftNameTxt_.text)
				SetActive(arg_375_1.iconTrs_.gameObject, false)
				arg_375_1.callingController_:SetSelectedState("normal")

				local var_378_2 = arg_375_1:GetWordFromCfg(1109704092)
				local var_378_3 = arg_375_1:FormatText(var_378_2.content)

				arg_375_1.text_.text = var_378_3

				LuaForUtil.ClearLinePrefixSymbol(arg_375_1.text_)

				local var_378_5 = 36 <= 0 and var_378_1 or var_378_1 * (utf8.len(var_378_3) / 36)

				if (36 <= 0 and var_378_1 or var_378_1 * (utf8.len(var_378_3) / 36)) > 0 and var_378_1 < var_378_5 then
					arg_375_1.talkMaxDuration = var_378_5

					if var_378_5 + var_378_0 > arg_375_1.duration_ then
						arg_375_1.duration_ = var_378_5 + var_378_0
					end
				end

				arg_375_1.text_.text = var_378_3
				arg_375_1.typewritter.percent = 0

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704092", "story_v_side_new_1109704.awb") ~= 0 then
					local var_378_6 = manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704092", "story_v_side_new_1109704.awb") / 1000

					if var_378_6 + var_378_0 > arg_375_1.duration_ then
						arg_375_1.duration_ = var_378_6 + var_378_0
					end

					if var_378_2.prefab_name ~= "" and arg_375_1.actors_[var_378_2.prefab_name] ~= nil then
						local var_378_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_375_1.actors_[var_378_2.prefab_name].transform, "story_v_side_new_1109704", "1109704092", "story_v_side_new_1109704.awb")

						arg_375_1:RecordAudio("1109704092", var_378_7)
						arg_375_1:RecordAudio("1109704092", var_378_7)
					else
						arg_375_1:AudioAction("play", "voice", "story_v_side_new_1109704", "1109704092", "story_v_side_new_1109704.awb")
					end

					arg_375_1:RecordHistoryTalkVoice("story_v_side_new_1109704", "1109704092", "story_v_side_new_1109704.awb")
				end

				arg_375_1:RecordContent(arg_375_1.text_.text)
			end

			local var_378_8 = math.max(var_378_1, arg_375_1.talkMaxDuration)

			if var_378_0 <= arg_375_1.time_ and arg_375_1.time_ < var_378_0 + var_378_8 then
				arg_375_1.typewritter.percent = (arg_375_1.time_ - var_378_0) / var_378_8

				arg_375_1.typewritter:SetDirty()
			end

			if arg_375_1.time_ >= var_378_0 + var_378_8 and arg_375_1.time_ < var_378_0 + var_378_8 + arg_378_0 then
				arg_375_1.typewritter.percent = 1

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(true)
			end
		end

		arg_375_1.nodeConfigList_ = {}

		arg_375_1:InitPlayNodeList()
	end,
	Play1109704093 = function(arg_379_0, arg_379_1)
		arg_379_1.time_ = 0
		arg_379_1.frameCnt_ = 0
		arg_379_1.state_ = "playing"
		arg_379_1.curTalkId_ = 1109704093
		arg_379_1.duration_ = 5

		SetActive(arg_379_1.tipsGo_, false)

		function arg_379_1.onSingleLineFinish_()
			arg_379_1.onSingleLineUpdate_ = nil
			arg_379_1.onSingleLineFinish_ = nil
			arg_379_1.state_ = "waiting"
		end

		function arg_379_1.playNext_(arg_381_0)
			if arg_381_0 == 1 then
				arg_379_0:Play1109704094(arg_379_1)
			end
		end

		function arg_379_1.onSingleLineUpdate_(arg_382_0)
			if 0 < arg_379_1.time_ and arg_379_1.time_ <= 0 + arg_382_0 and not isNil(arg_379_1.actors_["1097ui_story"]) and arg_379_1.var_.characterEffect1097ui_story == nil then
				arg_379_1.var_.characterEffect1097ui_story = arg_379_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_382_0 = 0.200000002980232

			if 0 <= arg_379_1.time_ and arg_379_1.time_ < 0 + var_382_0 and not isNil(arg_379_1.actors_["1097ui_story"]) then
				if arg_379_1.var_.characterEffect1097ui_story and not isNil(arg_379_1.actors_["1097ui_story"]) then
					arg_379_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_379_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_379_1.time_ - 0) / var_382_0)
				end
			end

			if arg_379_1.time_ >= 0 + var_382_0 and arg_379_1.time_ < 0 + var_382_0 + arg_382_0 and not isNil(arg_379_1.actors_["1097ui_story"]) and arg_379_1.var_.characterEffect1097ui_story then
				arg_379_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_379_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_382_1 = 0
			local var_382_2 = 1.15

			if 0 < arg_379_1.time_ and arg_379_1.time_ <= var_382_1 + arg_382_0 then
				arg_379_1.talkMaxDuration = 0
				arg_379_1.dialogCg_.alpha = 1

				arg_379_1.dialog_:SetActive(true)
				SetActive(arg_379_1.leftNameGo_, false)

				arg_379_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_379_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_379_1:RecordName(arg_379_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_379_1.iconTrs_.gameObject, false)
				arg_379_1.callingController_:SetSelectedState("normal")

				local var_382_3 = arg_379_1:FormatText(arg_379_1:GetWordFromCfg(1109704093).content)

				arg_379_1.text_.text = var_382_3

				LuaForUtil.ClearLinePrefixSymbol(arg_379_1.text_)

				local var_382_5 = 46 <= 0 and var_382_2 or var_382_2 * (utf8.len(var_382_3) / 46)

				if (46 <= 0 and var_382_2 or var_382_2 * (utf8.len(var_382_3) / 46)) > 0 and var_382_2 < var_382_5 then
					arg_379_1.talkMaxDuration = var_382_5

					if var_382_5 + var_382_1 > arg_379_1.duration_ then
						arg_379_1.duration_ = var_382_5 + var_382_1
					end
				end

				arg_379_1.text_.text = var_382_3
				arg_379_1.typewritter.percent = 0

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(false)
				arg_379_1:RecordContent(arg_379_1.text_.text)
			end

			local var_382_6 = math.max(var_382_2, arg_379_1.talkMaxDuration)

			if var_382_1 <= arg_379_1.time_ and arg_379_1.time_ < var_382_1 + var_382_6 then
				arg_379_1.typewritter.percent = (arg_379_1.time_ - var_382_1) / var_382_6

				arg_379_1.typewritter:SetDirty()
			end

			if arg_379_1.time_ >= var_382_1 + var_382_6 and arg_379_1.time_ < var_382_1 + var_382_6 + arg_382_0 then
				arg_379_1.typewritter.percent = 1

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(true)
			end
		end

		arg_379_1.nodeConfigList_ = {}

		arg_379_1:InitPlayNodeList()
	end,
	Play1109704094 = function(arg_383_0, arg_383_1)
		arg_383_1.time_ = 0
		arg_383_1.frameCnt_ = 0
		arg_383_1.state_ = "playing"
		arg_383_1.curTalkId_ = 1109704094
		arg_383_1.duration_ = 5

		SetActive(arg_383_1.tipsGo_, false)

		function arg_383_1.onSingleLineFinish_()
			arg_383_1.onSingleLineUpdate_ = nil
			arg_383_1.onSingleLineFinish_ = nil
			arg_383_1.state_ = "waiting"
		end

		function arg_383_1.playNext_(arg_385_0)
			if arg_385_0 == 1 then
				arg_383_0:Play1109704095(arg_383_1)
			end
		end

		function arg_383_1.onSingleLineUpdate_(arg_386_0)
			local var_386_0 = 0.15

			if 0 < arg_383_1.time_ and arg_383_1.time_ <= 0 + arg_386_0 then
				arg_383_1.talkMaxDuration = 0
				arg_383_1.dialogCg_.alpha = 1

				arg_383_1.dialog_:SetActive(true)
				SetActive(arg_383_1.leftNameGo_, true)

				arg_383_1.leftNameTxt_.text = arg_383_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_383_1.leftNameTxt_.transform)

				arg_383_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_383_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_383_1:RecordName(arg_383_1.leftNameTxt_.text)
				SetActive(arg_383_1.iconTrs_.gameObject, true)
				arg_383_1.iconController_:SetSelectedState("hero")

				arg_383_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_383_1.callingController_:SetSelectedState("normal")

				arg_383_1.keyicon_.color = Color.New(1, 1, 1)
				arg_383_1.icon_.color = Color.New(1, 1, 1)

				local var_386_1 = arg_383_1:FormatText(arg_383_1:GetWordFromCfg(1109704094).content)

				arg_383_1.text_.text = var_386_1

				LuaForUtil.ClearLinePrefixSymbol(arg_383_1.text_)

				local var_386_3 = 6 <= 0 and var_386_0 or var_386_0 * (utf8.len(var_386_1) / 6)

				if (6 <= 0 and var_386_0 or var_386_0 * (utf8.len(var_386_1) / 6)) > 0 and var_386_0 < var_386_3 then
					arg_383_1.talkMaxDuration = var_386_3

					if var_386_3 + 0 > arg_383_1.duration_ then
						arg_383_1.duration_ = var_386_3 + 0
					end
				end

				arg_383_1.text_.text = var_386_1
				arg_383_1.typewritter.percent = 0

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(false)
				arg_383_1:RecordContent(arg_383_1.text_.text)
			end

			local var_386_4 = math.max(var_386_0, arg_383_1.talkMaxDuration)

			if 0 <= arg_383_1.time_ and arg_383_1.time_ < 0 + var_386_4 then
				arg_383_1.typewritter.percent = (arg_383_1.time_ - 0) / var_386_4

				arg_383_1.typewritter:SetDirty()
			end

			if arg_383_1.time_ >= 0 + var_386_4 and arg_383_1.time_ < 0 + var_386_4 + arg_386_0 then
				arg_383_1.typewritter.percent = 1

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(true)
			end
		end

		arg_383_1.nodeConfigList_ = {}

		arg_383_1:InitPlayNodeList()
	end,
	Play1109704095 = function(arg_387_0, arg_387_1)
		arg_387_1.time_ = 0
		arg_387_1.frameCnt_ = 0
		arg_387_1.state_ = "playing"
		arg_387_1.curTalkId_ = 1109704095
		arg_387_1.duration_ = 5

		SetActive(arg_387_1.tipsGo_, false)

		function arg_387_1.onSingleLineFinish_()
			arg_387_1.onSingleLineUpdate_ = nil
			arg_387_1.onSingleLineFinish_ = nil
			arg_387_1.state_ = "waiting"
		end

		function arg_387_1.playNext_(arg_389_0)
			if arg_389_0 == 1 then
				arg_387_0:Play1109704096(arg_387_1)
			end
		end

		function arg_387_1.onSingleLineUpdate_(arg_390_0)
			local var_390_0 = 0.975

			if 0 < arg_387_1.time_ and arg_387_1.time_ <= 0 + arg_390_0 then
				arg_387_1.talkMaxDuration = 0
				arg_387_1.dialogCg_.alpha = 1

				arg_387_1.dialog_:SetActive(true)
				SetActive(arg_387_1.leftNameGo_, false)

				arg_387_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_387_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_387_1:RecordName(arg_387_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_387_1.iconTrs_.gameObject, false)
				arg_387_1.callingController_:SetSelectedState("normal")

				local var_390_1 = arg_387_1:FormatText(arg_387_1:GetWordFromCfg(1109704095).content)

				arg_387_1.text_.text = var_390_1

				LuaForUtil.ClearLinePrefixSymbol(arg_387_1.text_)

				local var_390_3 = 39 <= 0 and var_390_0 or var_390_0 * (utf8.len(var_390_1) / 39)

				if (39 <= 0 and var_390_0 or var_390_0 * (utf8.len(var_390_1) / 39)) > 0 and var_390_0 < var_390_3 then
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
	Play1109704096 = function(arg_391_0, arg_391_1)
		arg_391_1.time_ = 0
		arg_391_1.frameCnt_ = 0
		arg_391_1.state_ = "playing"
		arg_391_1.curTalkId_ = 1109704096
		arg_391_1.duration_ = 4.23

		local var_391_0 = {
			zh = 3.733,
			ja = 4.233
		}
		local var_391_1 = manager.audio:GetLocalizationFlag()

		if var_391_0[var_391_1] ~= nil then
			arg_391_1.duration_ = var_391_0[var_391_1]
		end

		SetActive(arg_391_1.tipsGo_, false)

		function arg_391_1.onSingleLineFinish_()
			arg_391_1.onSingleLineUpdate_ = nil
			arg_391_1.onSingleLineFinish_ = nil
			arg_391_1.state_ = "waiting"
		end

		function arg_391_1.playNext_(arg_393_0)
			if arg_393_0 == 1 then
				arg_391_0:Play1109704097(arg_391_1)
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
			local var_394_3 = 0.65

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

				local var_394_4 = arg_391_1:GetWordFromCfg(1109704096)
				local var_394_5 = arg_391_1:FormatText(var_394_4.content)

				arg_391_1.text_.text = var_394_5

				LuaForUtil.ClearLinePrefixSymbol(arg_391_1.text_)

				local var_394_7 = 26 <= 0 and var_394_3 or var_394_3 * (utf8.len(var_394_5) / 26)

				if (26 <= 0 and var_394_3 or var_394_3 * (utf8.len(var_394_5) / 26)) > 0 and var_394_3 < var_394_7 then
					arg_391_1.talkMaxDuration = var_394_7

					if var_394_7 + var_394_2 > arg_391_1.duration_ then
						arg_391_1.duration_ = var_394_7 + var_394_2
					end
				end

				arg_391_1.text_.text = var_394_5
				arg_391_1.typewritter.percent = 0

				arg_391_1.typewritter:SetDirty()
				arg_391_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704096", "story_v_side_new_1109704.awb") ~= 0 then
					local var_394_8 = manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704096", "story_v_side_new_1109704.awb") / 1000

					if var_394_8 + var_394_2 > arg_391_1.duration_ then
						arg_391_1.duration_ = var_394_8 + var_394_2
					end

					if var_394_4.prefab_name ~= "" and arg_391_1.actors_[var_394_4.prefab_name] ~= nil then
						local var_394_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_391_1.actors_[var_394_4.prefab_name].transform, "story_v_side_new_1109704", "1109704096", "story_v_side_new_1109704.awb")

						arg_391_1:RecordAudio("1109704096", var_394_9)
						arg_391_1:RecordAudio("1109704096", var_394_9)
					else
						arg_391_1:AudioAction("play", "voice", "story_v_side_new_1109704", "1109704096", "story_v_side_new_1109704.awb")
					end

					arg_391_1:RecordHistoryTalkVoice("story_v_side_new_1109704", "1109704096", "story_v_side_new_1109704.awb")
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
	Play1109704097 = function(arg_395_0, arg_395_1)
		arg_395_1.time_ = 0
		arg_395_1.frameCnt_ = 0
		arg_395_1.state_ = "playing"
		arg_395_1.curTalkId_ = 1109704097
		arg_395_1.duration_ = 5

		SetActive(arg_395_1.tipsGo_, false)

		function arg_395_1.onSingleLineFinish_()
			arg_395_1.onSingleLineUpdate_ = nil
			arg_395_1.onSingleLineFinish_ = nil
			arg_395_1.state_ = "waiting"
		end

		function arg_395_1.playNext_(arg_397_0)
			if arg_397_0 == 1 then
				arg_395_0:Play1109704098(arg_395_1)
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
			local var_398_2 = 0.825

			if 0 < arg_395_1.time_ and arg_395_1.time_ <= var_398_1 + arg_398_0 then
				arg_395_1.talkMaxDuration = 0
				arg_395_1.dialogCg_.alpha = 1

				arg_395_1.dialog_:SetActive(true)
				SetActive(arg_395_1.leftNameGo_, false)

				arg_395_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_395_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_395_1:RecordName(arg_395_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_395_1.iconTrs_.gameObject, false)
				arg_395_1.callingController_:SetSelectedState("normal")

				local var_398_3 = arg_395_1:FormatText(arg_395_1:GetWordFromCfg(1109704097).content)

				arg_395_1.text_.text = var_398_3

				LuaForUtil.ClearLinePrefixSymbol(arg_395_1.text_)

				local var_398_5 = 33 <= 0 and var_398_2 or var_398_2 * (utf8.len(var_398_3) / 33)

				if (33 <= 0 and var_398_2 or var_398_2 * (utf8.len(var_398_3) / 33)) > 0 and var_398_2 < var_398_5 then
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
	Play1109704098 = function(arg_399_0, arg_399_1)
		arg_399_1.time_ = 0
		arg_399_1.frameCnt_ = 0
		arg_399_1.state_ = "playing"
		arg_399_1.curTalkId_ = 1109704098
		arg_399_1.duration_ = 10.03

		local var_399_0 = {
			zh = 10.033,
			ja = 7.966
		}
		local var_399_1 = manager.audio:GetLocalizationFlag()

		if var_399_0[var_399_1] ~= nil then
			arg_399_1.duration_ = var_399_0[var_399_1]
		end

		SetActive(arg_399_1.tipsGo_, false)

		function arg_399_1.onSingleLineFinish_()
			arg_399_1.onSingleLineUpdate_ = nil
			arg_399_1.onSingleLineFinish_ = nil
			arg_399_1.state_ = "waiting"
		end

		function arg_399_1.playNext_(arg_401_0)
			if arg_401_0 == 1 then
				arg_399_0:Play1109704099(arg_399_1)
			end
		end

		function arg_399_1.onSingleLineUpdate_(arg_402_0)
			if 0 < arg_399_1.time_ and arg_399_1.time_ <= 0 + arg_402_0 and not isNil(arg_399_1.actors_["1097ui_story"]) and arg_399_1.var_.characterEffect1097ui_story == nil then
				arg_399_1.var_.characterEffect1097ui_story = arg_399_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_402_0 = 0.200000002980232

			if 0 <= arg_399_1.time_ and arg_399_1.time_ < 0 + var_402_0 and not isNil(arg_399_1.actors_["1097ui_story"]) then
				if arg_399_1.var_.characterEffect1097ui_story and not isNil(arg_399_1.actors_["1097ui_story"]) then
					arg_399_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_399_1.time_ >= 0 + var_402_0 and arg_399_1.time_ < 0 + var_402_0 + arg_402_0 and not isNil(arg_399_1.actors_["1097ui_story"]) and arg_399_1.var_.characterEffect1097ui_story then
				arg_399_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_399_1.time_ and arg_399_1.time_ <= 0 + arg_402_0 then
				arg_399_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action6_2")
			end

			if 0 < arg_399_1.time_ and arg_399_1.time_ <= 0 + arg_402_0 then
				arg_399_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_402_2 = 0
			local var_402_3 = 1.225

			if 0 < arg_399_1.time_ and arg_399_1.time_ <= var_402_2 + arg_402_0 then
				arg_399_1.talkMaxDuration = 0
				arg_399_1.dialogCg_.alpha = 1

				arg_399_1.dialog_:SetActive(true)
				SetActive(arg_399_1.leftNameGo_, true)

				arg_399_1.leftNameTxt_.text = arg_399_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_399_1.leftNameTxt_.transform)

				arg_399_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_399_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_399_1:RecordName(arg_399_1.leftNameTxt_.text)
				SetActive(arg_399_1.iconTrs_.gameObject, false)
				arg_399_1.callingController_:SetSelectedState("normal")

				local var_402_4 = arg_399_1:GetWordFromCfg(1109704098)
				local var_402_5 = arg_399_1:FormatText(var_402_4.content)

				arg_399_1.text_.text = var_402_5

				LuaForUtil.ClearLinePrefixSymbol(arg_399_1.text_)

				local var_402_7 = 49 <= 0 and var_402_3 or var_402_3 * (utf8.len(var_402_5) / 49)

				if (49 <= 0 and var_402_3 or var_402_3 * (utf8.len(var_402_5) / 49)) > 0 and var_402_3 < var_402_7 then
					arg_399_1.talkMaxDuration = var_402_7

					if var_402_7 + var_402_2 > arg_399_1.duration_ then
						arg_399_1.duration_ = var_402_7 + var_402_2
					end
				end

				arg_399_1.text_.text = var_402_5
				arg_399_1.typewritter.percent = 0

				arg_399_1.typewritter:SetDirty()
				arg_399_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704098", "story_v_side_new_1109704.awb") ~= 0 then
					local var_402_8 = manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704098", "story_v_side_new_1109704.awb") / 1000

					if var_402_8 + var_402_2 > arg_399_1.duration_ then
						arg_399_1.duration_ = var_402_8 + var_402_2
					end

					if var_402_4.prefab_name ~= "" and arg_399_1.actors_[var_402_4.prefab_name] ~= nil then
						local var_402_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_399_1.actors_[var_402_4.prefab_name].transform, "story_v_side_new_1109704", "1109704098", "story_v_side_new_1109704.awb")

						arg_399_1:RecordAudio("1109704098", var_402_9)
						arg_399_1:RecordAudio("1109704098", var_402_9)
					else
						arg_399_1:AudioAction("play", "voice", "story_v_side_new_1109704", "1109704098", "story_v_side_new_1109704.awb")
					end

					arg_399_1:RecordHistoryTalkVoice("story_v_side_new_1109704", "1109704098", "story_v_side_new_1109704.awb")
				end

				arg_399_1:RecordContent(arg_399_1.text_.text)
			end

			local var_402_10 = math.max(var_402_3, arg_399_1.talkMaxDuration)

			if var_402_2 <= arg_399_1.time_ and arg_399_1.time_ < var_402_2 + var_402_10 then
				arg_399_1.typewritter.percent = (arg_399_1.time_ - var_402_2) / var_402_10

				arg_399_1.typewritter:SetDirty()
			end

			if arg_399_1.time_ >= var_402_2 + var_402_10 and arg_399_1.time_ < var_402_2 + var_402_10 + arg_402_0 then
				arg_399_1.typewritter.percent = 1

				arg_399_1.typewritter:SetDirty()
				arg_399_1:ShowNextGo(true)
			end
		end

		arg_399_1.nodeConfigList_ = {}

		arg_399_1:InitPlayNodeList()
	end,
	Play1109704099 = function(arg_403_0, arg_403_1)
		arg_403_1.time_ = 0
		arg_403_1.frameCnt_ = 0
		arg_403_1.state_ = "playing"
		arg_403_1.curTalkId_ = 1109704099
		arg_403_1.duration_ = 9.17

		local var_403_0 = {
			zh = 9.166,
			ja = 7.733
		}
		local var_403_1 = manager.audio:GetLocalizationFlag()

		if var_403_0[var_403_1] ~= nil then
			arg_403_1.duration_ = var_403_0[var_403_1]
		end

		SetActive(arg_403_1.tipsGo_, false)

		function arg_403_1.onSingleLineFinish_()
			arg_403_1.onSingleLineUpdate_ = nil
			arg_403_1.onSingleLineFinish_ = nil
			arg_403_1.state_ = "waiting"
		end

		function arg_403_1.playNext_(arg_405_0)
			if arg_405_0 == 1 then
				arg_403_0:Play1109704100(arg_403_1)
			end
		end

		function arg_403_1.onSingleLineUpdate_(arg_406_0)
			if 0 < arg_403_1.time_ and arg_403_1.time_ <= 0 + arg_406_0 then
				arg_403_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			if 0 < arg_403_1.time_ and arg_403_1.time_ <= 0 + arg_406_0 then
				arg_403_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_406_0 = 0
			local var_406_1 = 1.025

			if 0 < arg_403_1.time_ and arg_403_1.time_ <= var_406_0 + arg_406_0 then
				arg_403_1.talkMaxDuration = 0
				arg_403_1.dialogCg_.alpha = 1

				arg_403_1.dialog_:SetActive(true)
				SetActive(arg_403_1.leftNameGo_, true)

				arg_403_1.leftNameTxt_.text = arg_403_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_403_1.leftNameTxt_.transform)

				arg_403_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_403_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_403_1:RecordName(arg_403_1.leftNameTxt_.text)
				SetActive(arg_403_1.iconTrs_.gameObject, false)
				arg_403_1.callingController_:SetSelectedState("normal")

				local var_406_2 = arg_403_1:GetWordFromCfg(1109704099)
				local var_406_3 = arg_403_1:FormatText(var_406_2.content)

				arg_403_1.text_.text = var_406_3

				LuaForUtil.ClearLinePrefixSymbol(arg_403_1.text_)

				local var_406_5 = 35 <= 0 and var_406_1 or var_406_1 * (utf8.len(var_406_3) / 35)

				if (35 <= 0 and var_406_1 or var_406_1 * (utf8.len(var_406_3) / 35)) > 0 and var_406_1 < var_406_5 then
					arg_403_1.talkMaxDuration = var_406_5

					if var_406_5 + var_406_0 > arg_403_1.duration_ then
						arg_403_1.duration_ = var_406_5 + var_406_0
					end
				end

				arg_403_1.text_.text = var_406_3
				arg_403_1.typewritter.percent = 0

				arg_403_1.typewritter:SetDirty()
				arg_403_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704099", "story_v_side_new_1109704.awb") ~= 0 then
					local var_406_6 = manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704099", "story_v_side_new_1109704.awb") / 1000

					if var_406_6 + var_406_0 > arg_403_1.duration_ then
						arg_403_1.duration_ = var_406_6 + var_406_0
					end

					if var_406_2.prefab_name ~= "" and arg_403_1.actors_[var_406_2.prefab_name] ~= nil then
						local var_406_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_403_1.actors_[var_406_2.prefab_name].transform, "story_v_side_new_1109704", "1109704099", "story_v_side_new_1109704.awb")

						arg_403_1:RecordAudio("1109704099", var_406_7)
						arg_403_1:RecordAudio("1109704099", var_406_7)
					else
						arg_403_1:AudioAction("play", "voice", "story_v_side_new_1109704", "1109704099", "story_v_side_new_1109704.awb")
					end

					arg_403_1:RecordHistoryTalkVoice("story_v_side_new_1109704", "1109704099", "story_v_side_new_1109704.awb")
				end

				arg_403_1:RecordContent(arg_403_1.text_.text)
			end

			local var_406_8 = math.max(var_406_1, arg_403_1.talkMaxDuration)

			if var_406_0 <= arg_403_1.time_ and arg_403_1.time_ < var_406_0 + var_406_8 then
				arg_403_1.typewritter.percent = (arg_403_1.time_ - var_406_0) / var_406_8

				arg_403_1.typewritter:SetDirty()
			end

			if arg_403_1.time_ >= var_406_0 + var_406_8 and arg_403_1.time_ < var_406_0 + var_406_8 + arg_406_0 then
				arg_403_1.typewritter.percent = 1

				arg_403_1.typewritter:SetDirty()
				arg_403_1:ShowNextGo(true)
			end
		end

		arg_403_1.nodeConfigList_ = {}

		arg_403_1:InitPlayNodeList()
	end,
	Play1109704100 = function(arg_407_0, arg_407_1)
		arg_407_1.time_ = 0
		arg_407_1.frameCnt_ = 0
		arg_407_1.state_ = "playing"
		arg_407_1.curTalkId_ = 1109704100
		arg_407_1.duration_ = 7.9

		local var_407_0 = {
			zh = 7.9,
			ja = 5.933
		}
		local var_407_1 = manager.audio:GetLocalizationFlag()

		if var_407_0[var_407_1] ~= nil then
			arg_407_1.duration_ = var_407_0[var_407_1]
		end

		SetActive(arg_407_1.tipsGo_, false)

		function arg_407_1.onSingleLineFinish_()
			arg_407_1.onSingleLineUpdate_ = nil
			arg_407_1.onSingleLineFinish_ = nil
			arg_407_1.state_ = "waiting"
		end

		function arg_407_1.playNext_(arg_409_0)
			if arg_409_0 == 1 then
				arg_407_0:Play1109704101(arg_407_1)
			end
		end

		function arg_407_1.onSingleLineUpdate_(arg_410_0)
			if 0 < arg_407_1.time_ and arg_407_1.time_ <= 0 + arg_410_0 then
				arg_407_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			if 0 < arg_407_1.time_ and arg_407_1.time_ <= 0 + arg_410_0 then
				arg_407_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva")
			end

			local var_410_0 = 0
			local var_410_1 = 1.1

			if 0 < arg_407_1.time_ and arg_407_1.time_ <= var_410_0 + arg_410_0 then
				arg_407_1.talkMaxDuration = 0
				arg_407_1.dialogCg_.alpha = 1

				arg_407_1.dialog_:SetActive(true)
				SetActive(arg_407_1.leftNameGo_, true)

				arg_407_1.leftNameTxt_.text = arg_407_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_407_1.leftNameTxt_.transform)

				arg_407_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_407_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_407_1:RecordName(arg_407_1.leftNameTxt_.text)
				SetActive(arg_407_1.iconTrs_.gameObject, false)
				arg_407_1.callingController_:SetSelectedState("normal")

				local var_410_2 = arg_407_1:GetWordFromCfg(1109704100)
				local var_410_3 = arg_407_1:FormatText(var_410_2.content)

				arg_407_1.text_.text = var_410_3

				LuaForUtil.ClearLinePrefixSymbol(arg_407_1.text_)

				local var_410_5 = 44 <= 0 and var_410_1 or var_410_1 * (utf8.len(var_410_3) / 44)

				if (44 <= 0 and var_410_1 or var_410_1 * (utf8.len(var_410_3) / 44)) > 0 and var_410_1 < var_410_5 then
					arg_407_1.talkMaxDuration = var_410_5

					if var_410_5 + var_410_0 > arg_407_1.duration_ then
						arg_407_1.duration_ = var_410_5 + var_410_0
					end
				end

				arg_407_1.text_.text = var_410_3
				arg_407_1.typewritter.percent = 0

				arg_407_1.typewritter:SetDirty()
				arg_407_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704100", "story_v_side_new_1109704.awb") ~= 0 then
					local var_410_6 = manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704100", "story_v_side_new_1109704.awb") / 1000

					if var_410_6 + var_410_0 > arg_407_1.duration_ then
						arg_407_1.duration_ = var_410_6 + var_410_0
					end

					if var_410_2.prefab_name ~= "" and arg_407_1.actors_[var_410_2.prefab_name] ~= nil then
						local var_410_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_407_1.actors_[var_410_2.prefab_name].transform, "story_v_side_new_1109704", "1109704100", "story_v_side_new_1109704.awb")

						arg_407_1:RecordAudio("1109704100", var_410_7)
						arg_407_1:RecordAudio("1109704100", var_410_7)
					else
						arg_407_1:AudioAction("play", "voice", "story_v_side_new_1109704", "1109704100", "story_v_side_new_1109704.awb")
					end

					arg_407_1:RecordHistoryTalkVoice("story_v_side_new_1109704", "1109704100", "story_v_side_new_1109704.awb")
				end

				arg_407_1:RecordContent(arg_407_1.text_.text)
			end

			local var_410_8 = math.max(var_410_1, arg_407_1.talkMaxDuration)

			if var_410_0 <= arg_407_1.time_ and arg_407_1.time_ < var_410_0 + var_410_8 then
				arg_407_1.typewritter.percent = (arg_407_1.time_ - var_410_0) / var_410_8

				arg_407_1.typewritter:SetDirty()
			end

			if arg_407_1.time_ >= var_410_0 + var_410_8 and arg_407_1.time_ < var_410_0 + var_410_8 + arg_410_0 then
				arg_407_1.typewritter.percent = 1

				arg_407_1.typewritter:SetDirty()
				arg_407_1:ShowNextGo(true)
			end
		end

		arg_407_1.nodeConfigList_ = {}

		arg_407_1:InitPlayNodeList()
	end,
	Play1109704101 = function(arg_411_0, arg_411_1)
		arg_411_1.time_ = 0
		arg_411_1.frameCnt_ = 0
		arg_411_1.state_ = "playing"
		arg_411_1.curTalkId_ = 1109704101
		arg_411_1.duration_ = 5

		SetActive(arg_411_1.tipsGo_, false)

		function arg_411_1.onSingleLineFinish_()
			arg_411_1.onSingleLineUpdate_ = nil
			arg_411_1.onSingleLineFinish_ = nil
			arg_411_1.state_ = "waiting"
		end

		function arg_411_1.playNext_(arg_413_0)
			if arg_413_0 == 1 then
				arg_411_0:Play1109704102(arg_411_1)
			end
		end

		function arg_411_1.onSingleLineUpdate_(arg_414_0)
			if 0 < arg_411_1.time_ and arg_411_1.time_ <= 0 + arg_414_0 and not isNil(arg_411_1.actors_["1097ui_story"]) and arg_411_1.var_.characterEffect1097ui_story == nil then
				arg_411_1.var_.characterEffect1097ui_story = arg_411_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_414_0 = 0.200000002980232

			if 0 <= arg_411_1.time_ and arg_411_1.time_ < 0 + var_414_0 and not isNil(arg_411_1.actors_["1097ui_story"]) then
				if arg_411_1.var_.characterEffect1097ui_story and not isNil(arg_411_1.actors_["1097ui_story"]) then
					arg_411_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_411_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_411_1.time_ - 0) / var_414_0)
				end
			end

			if arg_411_1.time_ >= 0 + var_414_0 and arg_411_1.time_ < 0 + var_414_0 + arg_414_0 and not isNil(arg_411_1.actors_["1097ui_story"]) and arg_411_1.var_.characterEffect1097ui_story then
				arg_411_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_411_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_414_1 = 0
			local var_414_2 = 0.05

			if 0 < arg_411_1.time_ and arg_411_1.time_ <= var_414_1 + arg_414_0 then
				arg_411_1.talkMaxDuration = 0
				arg_411_1.dialogCg_.alpha = 1

				arg_411_1.dialog_:SetActive(true)
				SetActive(arg_411_1.leftNameGo_, true)

				arg_411_1.leftNameTxt_.text = arg_411_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_411_1.leftNameTxt_.transform)

				arg_411_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_411_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_411_1:RecordName(arg_411_1.leftNameTxt_.text)
				SetActive(arg_411_1.iconTrs_.gameObject, true)
				arg_411_1.iconController_:SetSelectedState("hero")

				arg_411_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_411_1.callingController_:SetSelectedState("normal")

				arg_411_1.keyicon_.color = Color.New(1, 1, 1)
				arg_411_1.icon_.color = Color.New(1, 1, 1)

				local var_414_3 = arg_411_1:FormatText(arg_411_1:GetWordFromCfg(1109704101).content)

				arg_411_1.text_.text = var_414_3

				LuaForUtil.ClearLinePrefixSymbol(arg_411_1.text_)

				local var_414_5 = 2 <= 0 and var_414_2 or var_414_2 * (utf8.len(var_414_3) / 2)

				if (2 <= 0 and var_414_2 or var_414_2 * (utf8.len(var_414_3) / 2)) > 0 and var_414_2 < var_414_5 then
					arg_411_1.talkMaxDuration = var_414_5

					if var_414_5 + var_414_1 > arg_411_1.duration_ then
						arg_411_1.duration_ = var_414_5 + var_414_1
					end
				end

				arg_411_1.text_.text = var_414_3
				arg_411_1.typewritter.percent = 0

				arg_411_1.typewritter:SetDirty()
				arg_411_1:ShowNextGo(false)
				arg_411_1:RecordContent(arg_411_1.text_.text)
			end

			local var_414_6 = math.max(var_414_2, arg_411_1.talkMaxDuration)

			if var_414_1 <= arg_411_1.time_ and arg_411_1.time_ < var_414_1 + var_414_6 then
				arg_411_1.typewritter.percent = (arg_411_1.time_ - var_414_1) / var_414_6

				arg_411_1.typewritter:SetDirty()
			end

			if arg_411_1.time_ >= var_414_1 + var_414_6 and arg_411_1.time_ < var_414_1 + var_414_6 + arg_414_0 then
				arg_411_1.typewritter.percent = 1

				arg_411_1.typewritter:SetDirty()
				arg_411_1:ShowNextGo(true)
			end
		end

		arg_411_1.nodeConfigList_ = {}

		arg_411_1:InitPlayNodeList()
	end,
	Play1109704102 = function(arg_415_0, arg_415_1)
		arg_415_1.time_ = 0
		arg_415_1.frameCnt_ = 0
		arg_415_1.state_ = "playing"
		arg_415_1.curTalkId_ = 1109704102
		arg_415_1.duration_ = 7.23

		SetActive(arg_415_1.tipsGo_, false)

		function arg_415_1.onSingleLineFinish_()
			arg_415_1.onSingleLineUpdate_ = nil
			arg_415_1.onSingleLineFinish_ = nil
			arg_415_1.state_ = "waiting"
		end

		function arg_415_1.playNext_(arg_417_0)
			if arg_417_0 == 1 then
				arg_415_0:Play1109704103(arg_415_1)
			end
		end

		function arg_415_1.onSingleLineUpdate_(arg_418_0)
			if 0.5 < arg_415_1.time_ and arg_415_1.time_ <= 0.5 + arg_418_0 then
				local var_418_0 = arg_415_1.bgs_.STwhite

				arg_415_1.bgs_.STwhite.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_418_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_418_1 = var_418_0:GetComponent("SpriteRenderer")

				if var_418_1 and var_418_1.sprite then
					local var_418_2 = 2 * (var_418_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_418_0.transform.localScale = Vector3.New(var_418_2 / var_418_1.sprite.bounds.size.y < var_418_2 * manager.ui.mainCameraCom_.aspect / var_418_1.sprite.bounds.size.x and var_418_2 * manager.ui.mainCameraCom_.aspect / var_418_1.sprite.bounds.size.x or var_418_2 / var_418_1.sprite.bounds.size.y, var_418_2 / var_418_1.sprite.bounds.size.y < var_418_2 * manager.ui.mainCameraCom_.aspect / var_418_1.sprite.bounds.size.x and var_418_2 * manager.ui.mainCameraCom_.aspect / var_418_1.sprite.bounds.size.x or var_418_2 / var_418_1.sprite.bounds.size.y, 0)
				end

				for iter_418_0, iter_418_1 in pairs(arg_415_1.bgs_) do
					if iter_418_0 ~= "STwhite" then
						iter_418_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_418_3 = 2.233332999999

			if 2.233332999999 < arg_415_1.time_ and arg_415_1.time_ <= var_418_3 + arg_418_0 then
				arg_415_1.allBtn_.enabled = false
			end

			if arg_415_1.time_ >= var_418_3 + 0.3 and arg_415_1.time_ < var_418_3 + 0.3 + arg_418_0 then
				arg_415_1.allBtn_.enabled = true
			end

			local var_418_4 = 0.5

			if 0.5 < arg_415_1.time_ and arg_415_1.time_ <= var_418_4 + arg_418_0 then
				arg_415_1.mask_.enabled = true
				arg_415_1.mask_.raycastTarget = true

				arg_415_1:SetGaussion(false)
			end

			local var_418_5 = 2.033333

			if var_418_4 <= arg_415_1.time_ and arg_415_1.time_ < var_418_4 + var_418_5 then
				local var_418_6 = Color.New(1, 1, 1)

				var_418_6.a = Mathf.Lerp(1, 0, (arg_415_1.time_ - var_418_4) / var_418_5)
				arg_415_1.mask_.color = var_418_6
			end

			if arg_415_1.time_ >= var_418_4 + var_418_5 and arg_415_1.time_ < var_418_4 + var_418_5 + arg_418_0 then
				local var_418_7 = Color.New(1, 1, 1)

				arg_415_1.mask_.enabled = false
				var_418_7.a = 0
				arg_415_1.mask_.color = var_418_7
			end

			local var_418_8 = arg_415_1.actors_["1097ui_story"].transform

			if 0.5 < arg_415_1.time_ and arg_415_1.time_ <= 0.5 + arg_418_0 then
				arg_415_1.var_.moveOldPos1097ui_story = var_418_8.localPosition
			end

			local var_418_9 = 0.001

			if 0.5 <= arg_415_1.time_ and arg_415_1.time_ < 0.5 + var_418_9 then
				var_418_8.localPosition = Vector3.Lerp(arg_415_1.var_.moveOldPos1097ui_story, Vector3.New(0, 100, 0), (arg_415_1.time_ - 0.5) / var_418_9)
				var_418_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_418_8.position).x, (manager.ui.mainCamera.transform.position - var_418_8.position).y, (manager.ui.mainCamera.transform.position - var_418_8.position).z)
				var_418_8.localEulerAngles.z = 0
				var_418_8.localEulerAngles.x = 0
				var_418_8.localEulerAngles = var_418_8.localEulerAngles
			end

			if arg_415_1.time_ >= 0.5 + var_418_9 and arg_415_1.time_ < 0.5 + var_418_9 + arg_418_0 then
				var_418_8.localPosition = Vector3.New(0, 100, 0)
				var_418_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_418_8.position).x, (manager.ui.mainCamera.transform.position - var_418_8.position).y, (manager.ui.mainCamera.transform.position - var_418_8.position).z)
				var_418_8.localEulerAngles.z = 0
				var_418_8.localEulerAngles.x = 0
				var_418_8.localEulerAngles = var_418_8.localEulerAngles
			end

			local var_418_10 = arg_415_1.actors_["1097ui_story"]

			if 0.5 < arg_415_1.time_ and arg_415_1.time_ <= 0.5 + arg_418_0 and not isNil(var_418_10) and arg_415_1.var_.characterEffect1097ui_story == nil then
				arg_415_1.var_.characterEffect1097ui_story = var_418_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_418_11 = 0.034000001847744

			if 0.5 <= arg_415_1.time_ and arg_415_1.time_ < 0.5 + var_418_11 and not isNil(var_418_10) then
				if arg_415_1.var_.characterEffect1097ui_story and not isNil(var_418_10) then
					arg_415_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_415_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_415_1.time_ - 0.5) / var_418_11)
				end
			end

			if arg_415_1.time_ >= 0.5 + var_418_11 and arg_415_1.time_ < 0.5 + var_418_11 + arg_418_0 and not isNil(var_418_10) and arg_415_1.var_.characterEffect1097ui_story then
				arg_415_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_415_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			if arg_415_1.frameCnt_ <= 1 then
				arg_415_1.dialog_:SetActive(false)
			end

			local var_418_12 = 2.233332999999
			local var_418_13 = 0.625

			if 2.233332999999 < arg_415_1.time_ and arg_415_1.time_ <= var_418_12 + arg_418_0 then
				arg_415_1.talkMaxDuration = 0

				arg_415_1.dialog_:SetActive(true)

				arg_415_1.dialogCg_.alpha = 0

				local var_418_14 = LeanTween.value(arg_415_1.dialog_, 0, 1, 0.3)

				var_418_14:setOnUpdate(LuaHelper.FloatAction(function(arg_419_0)
					arg_415_1.dialogCg_.alpha = arg_419_0
				end))
				var_418_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_415_1.dialog_)
					var_418_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_415_1.duration_ = arg_415_1.duration_ + 0.3

				SetActive(arg_415_1.leftNameGo_, false)

				arg_415_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_415_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_415_1:RecordName(arg_415_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_415_1.iconTrs_.gameObject, false)
				arg_415_1.callingController_:SetSelectedState("normal")

				local var_418_15 = arg_415_1:FormatText(arg_415_1:GetWordFromCfg(1109704102).content)

				arg_415_1.text_.text = var_418_15

				LuaForUtil.ClearLinePrefixSymbol(arg_415_1.text_)

				local var_418_17 = 25 <= 0 and var_418_13 or var_418_13 * (utf8.len(var_418_15) / 25)

				if (25 <= 0 and var_418_13 or var_418_13 * (utf8.len(var_418_15) / 25)) > 0 and var_418_13 < var_418_17 then
					arg_415_1.talkMaxDuration = var_418_17
					var_418_12 = var_418_12 + 0.3

					if var_418_17 + var_418_12 > arg_415_1.duration_ then
						arg_415_1.duration_ = var_418_17 + var_418_12
					end
				end

				arg_415_1.text_.text = var_418_15
				arg_415_1.typewritter.percent = 0

				arg_415_1.typewritter:SetDirty()
				arg_415_1:ShowNextGo(false)
				arg_415_1:RecordContent(arg_415_1.text_.text)
			end

			local var_418_18 = var_418_12 + 0.3
			local var_418_19 = math.max(var_418_13, arg_415_1.talkMaxDuration)

			if var_418_12 + 0.3 <= arg_415_1.time_ and arg_415_1.time_ < var_418_18 + var_418_19 then
				arg_415_1.typewritter.percent = (arg_415_1.time_ - var_418_18) / var_418_19

				arg_415_1.typewritter:SetDirty()
			end

			if arg_415_1.time_ >= var_418_18 + var_418_19 and arg_415_1.time_ < var_418_18 + var_418_19 + arg_418_0 then
				arg_415_1.typewritter.percent = 1

				arg_415_1.typewritter:SetDirty()
				arg_415_1:ShowNextGo(true)
			end
		end

		arg_415_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0.5,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_415_1:InitPlayNodeList()
	end,
	Play1109704103 = function(arg_421_0, arg_421_1)
		arg_421_1.time_ = 0
		arg_421_1.frameCnt_ = 0
		arg_421_1.state_ = "playing"
		arg_421_1.curTalkId_ = 1109704103
		arg_421_1.duration_ = 9

		SetActive(arg_421_1.tipsGo_, false)

		function arg_421_1.onSingleLineFinish_()
			arg_421_1.onSingleLineUpdate_ = nil
			arg_421_1.onSingleLineFinish_ = nil
			arg_421_1.state_ = "waiting"
		end

		function arg_421_1.playNext_(arg_423_0)
			if arg_423_0 == 1 then
				arg_421_0:Play1109704104(arg_421_1)
			end
		end

		function arg_421_1.onSingleLineUpdate_(arg_424_0)
			if arg_421_1.bgs_.R9701 == nil then
				local var_424_0 = Object.Instantiate(arg_421_1.paintGo_)

				var_424_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "R9701")
				var_424_0.name = "R9701"
				var_424_0.transform.parent = arg_421_1.stage_.transform
				var_424_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_421_1.bgs_.R9701 = var_424_0
			end

			if 1.83333333333333 < arg_421_1.time_ and arg_421_1.time_ <= 1.83333333333333 + arg_424_0 then
				local var_424_1 = arg_421_1.bgs_.R9701

				arg_421_1.bgs_.R9701.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_424_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_424_2 = var_424_1:GetComponent("SpriteRenderer")

				if var_424_2 and var_424_2.sprite then
					local var_424_3 = 2 * (var_424_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_424_1.transform.localScale = Vector3.New(var_424_3 / var_424_2.sprite.bounds.size.y < var_424_3 * manager.ui.mainCameraCom_.aspect / var_424_2.sprite.bounds.size.x and var_424_3 * manager.ui.mainCameraCom_.aspect / var_424_2.sprite.bounds.size.x or var_424_3 / var_424_2.sprite.bounds.size.y, var_424_3 / var_424_2.sprite.bounds.size.y < var_424_3 * manager.ui.mainCameraCom_.aspect / var_424_2.sprite.bounds.size.x and var_424_3 * manager.ui.mainCameraCom_.aspect / var_424_2.sprite.bounds.size.x or var_424_3 / var_424_2.sprite.bounds.size.y, 0)
				end

				for iter_424_0, iter_424_1 in pairs(arg_421_1.bgs_) do
					if iter_424_0 ~= "R9701" then
						iter_424_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_424_4 = 4

			if 4 < arg_421_1.time_ and arg_421_1.time_ <= var_424_4 + arg_424_0 then
				arg_421_1.allBtn_.enabled = false
			end

			if arg_421_1.time_ >= var_424_4 + 0.3 and arg_421_1.time_ < var_424_4 + 0.3 + arg_424_0 then
				arg_421_1.allBtn_.enabled = true
			end

			local var_424_5 = 0

			if 0 < arg_421_1.time_ and arg_421_1.time_ <= var_424_5 + arg_424_0 then
				arg_421_1.mask_.enabled = true
				arg_421_1.mask_.raycastTarget = true

				arg_421_1:SetGaussion(false)
			end

			local var_424_6 = 2

			if var_424_5 <= arg_421_1.time_ and arg_421_1.time_ < var_424_5 + var_424_6 then
				local var_424_7 = Color.New(0, 0, 0)

				var_424_7.a = Mathf.Lerp(0, 1, (arg_421_1.time_ - var_424_5) / var_424_6)
				arg_421_1.mask_.color = var_424_7
			end

			if arg_421_1.time_ >= var_424_5 + var_424_6 and arg_421_1.time_ < var_424_5 + var_424_6 + arg_424_0 then
				local var_424_8 = Color.New(0, 0, 0)

				var_424_8.a = 1
				arg_421_1.mask_.color = var_424_8
			end

			local var_424_9 = 2

			if 2 < arg_421_1.time_ and arg_421_1.time_ <= var_424_9 + arg_424_0 then
				arg_421_1.mask_.enabled = true
				arg_421_1.mask_.raycastTarget = true

				arg_421_1:SetGaussion(false)
			end

			local var_424_10 = 2

			if var_424_9 <= arg_421_1.time_ and arg_421_1.time_ < var_424_9 + var_424_10 then
				local var_424_11 = Color.New(0, 0, 0)

				var_424_11.a = Mathf.Lerp(1, 0, (arg_421_1.time_ - var_424_9) / var_424_10)
				arg_421_1.mask_.color = var_424_11
			end

			if arg_421_1.time_ >= var_424_9 + var_424_10 and arg_421_1.time_ < var_424_9 + var_424_10 + arg_424_0 then
				local var_424_12 = Color.New(0, 0, 0)

				arg_421_1.mask_.enabled = false
				var_424_12.a = 0
				arg_421_1.mask_.color = var_424_12
			end

			local var_424_13 = arg_421_1.actors_["1097ui_story"].transform

			if 1.96599999815226 < arg_421_1.time_ and arg_421_1.time_ <= 1.96599999815226 + arg_424_0 then
				arg_421_1.var_.moveOldPos1097ui_story = var_424_13.localPosition
			end

			local var_424_14 = 0.001

			if 1.96599999815226 <= arg_421_1.time_ and arg_421_1.time_ < 1.96599999815226 + var_424_14 then
				var_424_13.localPosition = Vector3.Lerp(arg_421_1.var_.moveOldPos1097ui_story, Vector3.New(0, 100, 0), (arg_421_1.time_ - 1.96599999815226) / var_424_14)
				var_424_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_424_13.position).x, (manager.ui.mainCamera.transform.position - var_424_13.position).y, (manager.ui.mainCamera.transform.position - var_424_13.position).z)
				var_424_13.localEulerAngles.z = 0
				var_424_13.localEulerAngles.x = 0
				var_424_13.localEulerAngles = var_424_13.localEulerAngles
			end

			if arg_421_1.time_ >= 1.96599999815226 + var_424_14 and arg_421_1.time_ < 1.96599999815226 + var_424_14 + arg_424_0 then
				var_424_13.localPosition = Vector3.New(0, 100, 0)
				var_424_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_424_13.position).x, (manager.ui.mainCamera.transform.position - var_424_13.position).y, (manager.ui.mainCamera.transform.position - var_424_13.position).z)
				var_424_13.localEulerAngles.z = 0
				var_424_13.localEulerAngles.x = 0
				var_424_13.localEulerAngles = var_424_13.localEulerAngles
			end

			local var_424_15 = arg_421_1.actors_["1097ui_story"]

			if 1.96599999815226 < arg_421_1.time_ and arg_421_1.time_ <= 1.96599999815226 + arg_424_0 and not isNil(var_424_15) and arg_421_1.var_.characterEffect1097ui_story == nil then
				arg_421_1.var_.characterEffect1097ui_story = var_424_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_424_16 = 0.034000001847744

			if 1.96599999815226 <= arg_421_1.time_ and arg_421_1.time_ < 1.96599999815226 + var_424_16 and not isNil(var_424_15) then
				if arg_421_1.var_.characterEffect1097ui_story and not isNil(var_424_15) then
					arg_421_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_421_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_421_1.time_ - 1.96599999815226) / var_424_16)
				end
			end

			if arg_421_1.time_ >= 1.96599999815226 + var_424_16 and arg_421_1.time_ < 1.96599999815226 + var_424_16 + arg_424_0 and not isNil(var_424_15) and arg_421_1.var_.characterEffect1097ui_story then
				arg_421_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_421_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_424_17 = arg_421_1.bgs_.R9701.transform

			if 2 < arg_421_1.time_ and arg_421_1.time_ <= 2 + arg_424_0 then
				arg_421_1.var_.moveOldPosR9701 = var_424_17.localPosition
			end

			local var_424_18 = 0.001

			if 2 <= arg_421_1.time_ and arg_421_1.time_ < 2 + var_424_18 then
				var_424_17.localPosition = Vector3.Lerp(arg_421_1.var_.moveOldPosR9701, Vector3.New(-1, 0.7, 3.6), (arg_421_1.time_ - 2) / var_424_18)
			end

			if arg_421_1.time_ >= 2 + var_424_18 and arg_421_1.time_ < 2 + var_424_18 + arg_424_0 then
				var_424_17.localPosition = Vector3.New(-1, 0.7, 3.6)
			end

			local var_424_19 = arg_421_1.bgs_.R9701.transform

			if 2.01666666666667 < arg_421_1.time_ and arg_421_1.time_ <= 2.01666666666667 + arg_424_0 then
				arg_421_1.var_.moveOldPosR9701 = var_424_19.localPosition
			end

			local var_424_20 = 3.6

			if 2.01666666666667 <= arg_421_1.time_ and arg_421_1.time_ < 2.01666666666667 + var_424_20 then
				var_424_19.localPosition = Vector3.Lerp(arg_421_1.var_.moveOldPosR9701, Vector3.New(-1, 0.2, 3.6), (arg_421_1.time_ - 2.01666666666667) / var_424_20)
			end

			if arg_421_1.time_ >= 2.01666666666667 + var_424_20 and arg_421_1.time_ < 2.01666666666667 + var_424_20 + arg_424_0 then
				var_424_19.localPosition = Vector3.New(-1, 0.2, 3.6)
			end

			local var_424_21 = 4

			if 4 < arg_421_1.time_ and arg_421_1.time_ <= var_424_21 + arg_424_0 then
				arg_421_1.allBtn_.enabled = false
			end

			if arg_421_1.time_ >= var_424_21 + 1.61666666666667 and arg_421_1.time_ < var_424_21 + 1.61666666666667 + arg_424_0 then
				arg_421_1.allBtn_.enabled = true
			end

			if arg_421_1.frameCnt_ <= 1 then
				arg_421_1.dialog_:SetActive(false)
			end

			local var_424_22 = 4.00000000298023
			local var_424_23 = 0.225

			if 4.00000000298023 < arg_421_1.time_ and arg_421_1.time_ <= var_424_22 + arg_424_0 then
				arg_421_1.talkMaxDuration = 0

				arg_421_1.dialog_:SetActive(true)

				arg_421_1.dialogCg_.alpha = 0

				local var_424_24 = LeanTween.value(arg_421_1.dialog_, 0, 1, 0.3)

				var_424_24:setOnUpdate(LuaHelper.FloatAction(function(arg_425_0)
					arg_421_1.dialogCg_.alpha = arg_425_0
				end))
				var_424_24:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_421_1.dialog_)
					var_424_24:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_421_1.duration_ = arg_421_1.duration_ + 0.3

				SetActive(arg_421_1.leftNameGo_, true)

				arg_421_1.leftNameTxt_.text = arg_421_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_421_1.leftNameTxt_.transform)

				arg_421_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_421_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_421_1:RecordName(arg_421_1.leftNameTxt_.text)
				SetActive(arg_421_1.iconTrs_.gameObject, true)
				arg_421_1.iconController_:SetSelectedState("hero")

				arg_421_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_421_1.callingController_:SetSelectedState("normal")

				arg_421_1.keyicon_.color = Color.New(1, 1, 1)
				arg_421_1.icon_.color = Color.New(1, 1, 1)

				local var_424_25 = arg_421_1:FormatText(arg_421_1:GetWordFromCfg(1109704103).content)

				arg_421_1.text_.text = var_424_25

				LuaForUtil.ClearLinePrefixSymbol(arg_421_1.text_)

				local var_424_27 = 9 <= 0 and var_424_23 or var_424_23 * (utf8.len(var_424_25) / 9)

				if (9 <= 0 and var_424_23 or var_424_23 * (utf8.len(var_424_25) / 9)) > 0 and var_424_23 < var_424_27 then
					arg_421_1.talkMaxDuration = var_424_27
					var_424_22 = var_424_22 + 0.3

					if var_424_27 + var_424_22 > arg_421_1.duration_ then
						arg_421_1.duration_ = var_424_27 + var_424_22
					end
				end

				arg_421_1.text_.text = var_424_25
				arg_421_1.typewritter.percent = 0

				arg_421_1.typewritter:SetDirty()
				arg_421_1:ShowNextGo(false)
				arg_421_1:RecordContent(arg_421_1.text_.text)
			end

			local var_424_28 = var_424_22 + 0.3
			local var_424_29 = math.max(var_424_23, arg_421_1.talkMaxDuration)

			if var_424_22 + 0.3 <= arg_421_1.time_ and arg_421_1.time_ < var_424_28 + var_424_29 then
				arg_421_1.typewritter.percent = (arg_421_1.time_ - var_424_28) / var_424_29

				arg_421_1.typewritter:SetDirty()
			end

			if arg_421_1.time_ >= var_424_28 + var_424_29 and arg_421_1.time_ < var_424_28 + var_424_29 + arg_424_0 then
				arg_421_1.typewritter.percent = 1

				arg_421_1.typewritter:SetDirty()
				arg_421_1:ShowNextGo(true)
			end
		end

		arg_421_1.nodeConfigList_ = {
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
				actorName = "R9701",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "R9701",
				changeDisplayLayer = false,
				needEase = false,
				duration = 3.6,
				className = "StoryMoveNode",
				startTime = 2.01666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_421_1:InitPlayNodeList()
	end,
	Play1109704104 = function(arg_427_0, arg_427_1)
		arg_427_1.time_ = 0
		arg_427_1.frameCnt_ = 0
		arg_427_1.state_ = "playing"
		arg_427_1.curTalkId_ = 1109704104
		arg_427_1.duration_ = 4.4

		local var_427_0 = {
			zh = 4.4,
			ja = 4.366
		}
		local var_427_1 = manager.audio:GetLocalizationFlag()

		if var_427_0[var_427_1] ~= nil then
			arg_427_1.duration_ = var_427_0[var_427_1]
		end

		SetActive(arg_427_1.tipsGo_, false)

		function arg_427_1.onSingleLineFinish_()
			arg_427_1.onSingleLineUpdate_ = nil
			arg_427_1.onSingleLineFinish_ = nil
			arg_427_1.state_ = "waiting"
		end

		function arg_427_1.playNext_(arg_429_0)
			if arg_429_0 == 1 then
				arg_427_0:Play1109704105(arg_427_1)
			end
		end

		function arg_427_1.onSingleLineUpdate_(arg_430_0)
			local var_430_0 = 0.575

			if 0 < arg_427_1.time_ and arg_427_1.time_ <= 0 + arg_430_0 then
				arg_427_1.talkMaxDuration = 0
				arg_427_1.dialogCg_.alpha = 1

				arg_427_1.dialog_:SetActive(true)
				SetActive(arg_427_1.leftNameGo_, true)

				arg_427_1.leftNameTxt_.text = arg_427_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_427_1.leftNameTxt_.transform)

				arg_427_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_427_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_427_1:RecordName(arg_427_1.leftNameTxt_.text)
				SetActive(arg_427_1.iconTrs_.gameObject, false)
				arg_427_1.callingController_:SetSelectedState("normal")

				local var_430_1 = arg_427_1:GetWordFromCfg(1109704104)
				local var_430_2 = arg_427_1:FormatText(var_430_1.content)

				arg_427_1.text_.text = var_430_2

				LuaForUtil.ClearLinePrefixSymbol(arg_427_1.text_)

				local var_430_4 = 23 <= 0 and var_430_0 or var_430_0 * (utf8.len(var_430_2) / 23)

				if (23 <= 0 and var_430_0 or var_430_0 * (utf8.len(var_430_2) / 23)) > 0 and var_430_0 < var_430_4 then
					arg_427_1.talkMaxDuration = var_430_4

					if var_430_4 + 0 > arg_427_1.duration_ then
						arg_427_1.duration_ = var_430_4 + 0
					end
				end

				arg_427_1.text_.text = var_430_2
				arg_427_1.typewritter.percent = 0

				arg_427_1.typewritter:SetDirty()
				arg_427_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704104", "story_v_side_new_1109704.awb") ~= 0 then
					local var_430_5 = manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704104", "story_v_side_new_1109704.awb") / 1000

					if var_430_5 + 0 > arg_427_1.duration_ then
						arg_427_1.duration_ = var_430_5 + 0
					end

					if var_430_1.prefab_name ~= "" and arg_427_1.actors_[var_430_1.prefab_name] ~= nil then
						local var_430_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_427_1.actors_[var_430_1.prefab_name].transform, "story_v_side_new_1109704", "1109704104", "story_v_side_new_1109704.awb")

						arg_427_1:RecordAudio("1109704104", var_430_6)
						arg_427_1:RecordAudio("1109704104", var_430_6)
					else
						arg_427_1:AudioAction("play", "voice", "story_v_side_new_1109704", "1109704104", "story_v_side_new_1109704.awb")
					end

					arg_427_1:RecordHistoryTalkVoice("story_v_side_new_1109704", "1109704104", "story_v_side_new_1109704.awb")
				end

				arg_427_1:RecordContent(arg_427_1.text_.text)
			end

			local var_430_7 = math.max(var_430_0, arg_427_1.talkMaxDuration)

			if 0 <= arg_427_1.time_ and arg_427_1.time_ < 0 + var_430_7 then
				arg_427_1.typewritter.percent = (arg_427_1.time_ - 0) / var_430_7

				arg_427_1.typewritter:SetDirty()
			end

			if arg_427_1.time_ >= 0 + var_430_7 and arg_427_1.time_ < 0 + var_430_7 + arg_430_0 then
				arg_427_1.typewritter.percent = 1

				arg_427_1.typewritter:SetDirty()
				arg_427_1:ShowNextGo(true)
			end
		end

		arg_427_1.nodeConfigList_ = {}

		arg_427_1:InitPlayNodeList()
	end,
	Play1109704105 = function(arg_431_0, arg_431_1)
		arg_431_1.time_ = 0
		arg_431_1.frameCnt_ = 0
		arg_431_1.state_ = "playing"
		arg_431_1.curTalkId_ = 1109704105
		arg_431_1.duration_ = 5

		SetActive(arg_431_1.tipsGo_, false)

		function arg_431_1.onSingleLineFinish_()
			arg_431_1.onSingleLineUpdate_ = nil
			arg_431_1.onSingleLineFinish_ = nil
			arg_431_1.state_ = "waiting"
		end

		function arg_431_1.playNext_(arg_433_0)
			if arg_433_0 == 1 then
				arg_431_0:Play1109704106(arg_431_1)
			end
		end

		function arg_431_1.onSingleLineUpdate_(arg_434_0)
			if 0 < arg_431_1.time_ and arg_431_1.time_ <= 0 + arg_434_0 and not isNil(arg_431_1.actors_["1097ui_story"]) and arg_431_1.var_.characterEffect1097ui_story == nil then
				arg_431_1.var_.characterEffect1097ui_story = arg_431_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_434_0 = 0.200000002980232

			if 0 <= arg_431_1.time_ and arg_431_1.time_ < 0 + var_434_0 and not isNil(arg_431_1.actors_["1097ui_story"]) then
				if arg_431_1.var_.characterEffect1097ui_story and not isNil(arg_431_1.actors_["1097ui_story"]) then
					arg_431_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_431_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_431_1.time_ - 0) / var_434_0)
				end
			end

			if arg_431_1.time_ >= 0 + var_434_0 and arg_431_1.time_ < 0 + var_434_0 + arg_434_0 and not isNil(arg_431_1.actors_["1097ui_story"]) and arg_431_1.var_.characterEffect1097ui_story then
				arg_431_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_431_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_434_1 = 0
			local var_434_2 = 0.8

			if 0 < arg_431_1.time_ and arg_431_1.time_ <= var_434_1 + arg_434_0 then
				arg_431_1.talkMaxDuration = 0
				arg_431_1.dialogCg_.alpha = 1

				arg_431_1.dialog_:SetActive(true)
				SetActive(arg_431_1.leftNameGo_, true)

				arg_431_1.leftNameTxt_.text = arg_431_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_431_1.leftNameTxt_.transform)

				arg_431_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_431_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_431_1:RecordName(arg_431_1.leftNameTxt_.text)
				SetActive(arg_431_1.iconTrs_.gameObject, true)
				arg_431_1.iconController_:SetSelectedState("hero")

				arg_431_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_431_1.callingController_:SetSelectedState("normal")

				arg_431_1.keyicon_.color = Color.New(1, 1, 1)
				arg_431_1.icon_.color = Color.New(1, 1, 1)

				local var_434_3 = arg_431_1:FormatText(arg_431_1:GetWordFromCfg(1109704105).content)

				arg_431_1.text_.text = var_434_3

				LuaForUtil.ClearLinePrefixSymbol(arg_431_1.text_)

				local var_434_5 = 32 <= 0 and var_434_2 or var_434_2 * (utf8.len(var_434_3) / 32)

				if (32 <= 0 and var_434_2 or var_434_2 * (utf8.len(var_434_3) / 32)) > 0 and var_434_2 < var_434_5 then
					arg_431_1.talkMaxDuration = var_434_5

					if var_434_5 + var_434_1 > arg_431_1.duration_ then
						arg_431_1.duration_ = var_434_5 + var_434_1
					end
				end

				arg_431_1.text_.text = var_434_3
				arg_431_1.typewritter.percent = 0

				arg_431_1.typewritter:SetDirty()
				arg_431_1:ShowNextGo(false)
				arg_431_1:RecordContent(arg_431_1.text_.text)
			end

			local var_434_6 = math.max(var_434_2, arg_431_1.talkMaxDuration)

			if var_434_1 <= arg_431_1.time_ and arg_431_1.time_ < var_434_1 + var_434_6 then
				arg_431_1.typewritter.percent = (arg_431_1.time_ - var_434_1) / var_434_6

				arg_431_1.typewritter:SetDirty()
			end

			if arg_431_1.time_ >= var_434_1 + var_434_6 and arg_431_1.time_ < var_434_1 + var_434_6 + arg_434_0 then
				arg_431_1.typewritter.percent = 1

				arg_431_1.typewritter:SetDirty()
				arg_431_1:ShowNextGo(true)
			end
		end

		arg_431_1.nodeConfigList_ = {}

		arg_431_1:InitPlayNodeList()
	end,
	Play1109704106 = function(arg_435_0, arg_435_1)
		arg_435_1.time_ = 0
		arg_435_1.frameCnt_ = 0
		arg_435_1.state_ = "playing"
		arg_435_1.curTalkId_ = 1109704106
		arg_435_1.duration_ = 4.13

		local var_435_0 = {
			zh = 3.466,
			ja = 4.133
		}
		local var_435_1 = manager.audio:GetLocalizationFlag()

		if var_435_0[var_435_1] ~= nil then
			arg_435_1.duration_ = var_435_0[var_435_1]
		end

		SetActive(arg_435_1.tipsGo_, false)

		function arg_435_1.onSingleLineFinish_()
			arg_435_1.onSingleLineUpdate_ = nil
			arg_435_1.onSingleLineFinish_ = nil
			arg_435_1.state_ = "waiting"
		end

		function arg_435_1.playNext_(arg_437_0)
			if arg_437_0 == 1 then
				arg_435_0:Play1109704107(arg_435_1)
			end
		end

		function arg_435_1.onSingleLineUpdate_(arg_438_0)
			local var_438_0 = 0.475

			if 0 < arg_435_1.time_ and arg_435_1.time_ <= 0 + arg_438_0 then
				arg_435_1.talkMaxDuration = 0
				arg_435_1.dialogCg_.alpha = 1

				arg_435_1.dialog_:SetActive(true)
				SetActive(arg_435_1.leftNameGo_, true)

				arg_435_1.leftNameTxt_.text = arg_435_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_435_1.leftNameTxt_.transform)

				arg_435_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_435_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_435_1:RecordName(arg_435_1.leftNameTxt_.text)
				SetActive(arg_435_1.iconTrs_.gameObject, false)
				arg_435_1.callingController_:SetSelectedState("normal")

				local var_438_1 = arg_435_1:GetWordFromCfg(1109704106)
				local var_438_2 = arg_435_1:FormatText(var_438_1.content)

				arg_435_1.text_.text = var_438_2

				LuaForUtil.ClearLinePrefixSymbol(arg_435_1.text_)

				local var_438_4 = 19 <= 0 and var_438_0 or var_438_0 * (utf8.len(var_438_2) / 19)

				if (19 <= 0 and var_438_0 or var_438_0 * (utf8.len(var_438_2) / 19)) > 0 and var_438_0 < var_438_4 then
					arg_435_1.talkMaxDuration = var_438_4

					if var_438_4 + 0 > arg_435_1.duration_ then
						arg_435_1.duration_ = var_438_4 + 0
					end
				end

				arg_435_1.text_.text = var_438_2
				arg_435_1.typewritter.percent = 0

				arg_435_1.typewritter:SetDirty()
				arg_435_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704106", "story_v_side_new_1109704.awb") ~= 0 then
					local var_438_5 = manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704106", "story_v_side_new_1109704.awb") / 1000

					if var_438_5 + 0 > arg_435_1.duration_ then
						arg_435_1.duration_ = var_438_5 + 0
					end

					if var_438_1.prefab_name ~= "" and arg_435_1.actors_[var_438_1.prefab_name] ~= nil then
						local var_438_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_435_1.actors_[var_438_1.prefab_name].transform, "story_v_side_new_1109704", "1109704106", "story_v_side_new_1109704.awb")

						arg_435_1:RecordAudio("1109704106", var_438_6)
						arg_435_1:RecordAudio("1109704106", var_438_6)
					else
						arg_435_1:AudioAction("play", "voice", "story_v_side_new_1109704", "1109704106", "story_v_side_new_1109704.awb")
					end

					arg_435_1:RecordHistoryTalkVoice("story_v_side_new_1109704", "1109704106", "story_v_side_new_1109704.awb")
				end

				arg_435_1:RecordContent(arg_435_1.text_.text)
			end

			local var_438_7 = math.max(var_438_0, arg_435_1.talkMaxDuration)

			if 0 <= arg_435_1.time_ and arg_435_1.time_ < 0 + var_438_7 then
				arg_435_1.typewritter.percent = (arg_435_1.time_ - 0) / var_438_7

				arg_435_1.typewritter:SetDirty()
			end

			if arg_435_1.time_ >= 0 + var_438_7 and arg_435_1.time_ < 0 + var_438_7 + arg_438_0 then
				arg_435_1.typewritter.percent = 1

				arg_435_1.typewritter:SetDirty()
				arg_435_1:ShowNextGo(true)
			end
		end

		arg_435_1.nodeConfigList_ = {}

		arg_435_1:InitPlayNodeList()
	end,
	Play1109704107 = function(arg_439_0, arg_439_1)
		arg_439_1.time_ = 0
		arg_439_1.frameCnt_ = 0
		arg_439_1.state_ = "playing"
		arg_439_1.curTalkId_ = 1109704107
		arg_439_1.duration_ = 5

		SetActive(arg_439_1.tipsGo_, false)

		function arg_439_1.onSingleLineFinish_()
			arg_439_1.onSingleLineUpdate_ = nil
			arg_439_1.onSingleLineFinish_ = nil
			arg_439_1.state_ = "waiting"
		end

		function arg_439_1.playNext_(arg_441_0)
			if arg_441_0 == 1 then
				arg_439_0:Play1109704108(arg_439_1)
			end
		end

		function arg_439_1.onSingleLineUpdate_(arg_442_0)
			local var_442_0 = 0.65

			if 0 < arg_439_1.time_ and arg_439_1.time_ <= 0 + arg_442_0 then
				arg_439_1.talkMaxDuration = 0
				arg_439_1.dialogCg_.alpha = 1

				arg_439_1.dialog_:SetActive(true)
				SetActive(arg_439_1.leftNameGo_, true)

				arg_439_1.leftNameTxt_.text = arg_439_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_439_1.leftNameTxt_.transform)

				arg_439_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_439_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_439_1:RecordName(arg_439_1.leftNameTxt_.text)
				SetActive(arg_439_1.iconTrs_.gameObject, true)
				arg_439_1.iconController_:SetSelectedState("hero")

				arg_439_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_439_1.callingController_:SetSelectedState("normal")

				arg_439_1.keyicon_.color = Color.New(1, 1, 1)
				arg_439_1.icon_.color = Color.New(1, 1, 1)

				local var_442_1 = arg_439_1:FormatText(arg_439_1:GetWordFromCfg(1109704107).content)

				arg_439_1.text_.text = var_442_1

				LuaForUtil.ClearLinePrefixSymbol(arg_439_1.text_)

				local var_442_3 = 26 <= 0 and var_442_0 or var_442_0 * (utf8.len(var_442_1) / 26)

				if (26 <= 0 and var_442_0 or var_442_0 * (utf8.len(var_442_1) / 26)) > 0 and var_442_0 < var_442_3 then
					arg_439_1.talkMaxDuration = var_442_3

					if var_442_3 + 0 > arg_439_1.duration_ then
						arg_439_1.duration_ = var_442_3 + 0
					end
				end

				arg_439_1.text_.text = var_442_1
				arg_439_1.typewritter.percent = 0

				arg_439_1.typewritter:SetDirty()
				arg_439_1:ShowNextGo(false)
				arg_439_1:RecordContent(arg_439_1.text_.text)
			end

			local var_442_4 = math.max(var_442_0, arg_439_1.talkMaxDuration)

			if 0 <= arg_439_1.time_ and arg_439_1.time_ < 0 + var_442_4 then
				arg_439_1.typewritter.percent = (arg_439_1.time_ - 0) / var_442_4

				arg_439_1.typewritter:SetDirty()
			end

			if arg_439_1.time_ >= 0 + var_442_4 and arg_439_1.time_ < 0 + var_442_4 + arg_442_0 then
				arg_439_1.typewritter.percent = 1

				arg_439_1.typewritter:SetDirty()
				arg_439_1:ShowNextGo(true)
			end
		end

		arg_439_1.nodeConfigList_ = {}

		arg_439_1:InitPlayNodeList()
	end,
	Play1109704108 = function(arg_443_0, arg_443_1)
		arg_443_1.time_ = 0
		arg_443_1.frameCnt_ = 0
		arg_443_1.state_ = "playing"
		arg_443_1.curTalkId_ = 1109704108
		arg_443_1.duration_ = 5

		SetActive(arg_443_1.tipsGo_, false)

		function arg_443_1.onSingleLineFinish_()
			arg_443_1.onSingleLineUpdate_ = nil
			arg_443_1.onSingleLineFinish_ = nil
			arg_443_1.state_ = "waiting"
		end

		function arg_443_1.playNext_(arg_445_0)
			if arg_445_0 == 1 then
				arg_443_0:Play1109704109(arg_443_1)
			end
		end

		function arg_443_1.onSingleLineUpdate_(arg_446_0)
			local var_446_0 = 0.675

			if 0 < arg_443_1.time_ and arg_443_1.time_ <= 0 + arg_446_0 then
				arg_443_1.talkMaxDuration = 0
				arg_443_1.dialogCg_.alpha = 1

				arg_443_1.dialog_:SetActive(true)
				SetActive(arg_443_1.leftNameGo_, false)

				arg_443_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_443_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_443_1:RecordName(arg_443_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_443_1.iconTrs_.gameObject, false)
				arg_443_1.callingController_:SetSelectedState("normal")

				local var_446_1 = arg_443_1:FormatText(arg_443_1:GetWordFromCfg(1109704108).content)

				arg_443_1.text_.text = var_446_1

				LuaForUtil.ClearLinePrefixSymbol(arg_443_1.text_)

				local var_446_3 = 27 <= 0 and var_446_0 or var_446_0 * (utf8.len(var_446_1) / 27)

				if (27 <= 0 and var_446_0 or var_446_0 * (utf8.len(var_446_1) / 27)) > 0 and var_446_0 < var_446_3 then
					arg_443_1.talkMaxDuration = var_446_3

					if var_446_3 + 0 > arg_443_1.duration_ then
						arg_443_1.duration_ = var_446_3 + 0
					end
				end

				arg_443_1.text_.text = var_446_1
				arg_443_1.typewritter.percent = 0

				arg_443_1.typewritter:SetDirty()
				arg_443_1:ShowNextGo(false)
				arg_443_1:RecordContent(arg_443_1.text_.text)
			end

			local var_446_4 = math.max(var_446_0, arg_443_1.talkMaxDuration)

			if 0 <= arg_443_1.time_ and arg_443_1.time_ < 0 + var_446_4 then
				arg_443_1.typewritter.percent = (arg_443_1.time_ - 0) / var_446_4

				arg_443_1.typewritter:SetDirty()
			end

			if arg_443_1.time_ >= 0 + var_446_4 and arg_443_1.time_ < 0 + var_446_4 + arg_446_0 then
				arg_443_1.typewritter.percent = 1

				arg_443_1.typewritter:SetDirty()
				arg_443_1:ShowNextGo(true)
			end
		end

		arg_443_1.nodeConfigList_ = {}

		arg_443_1:InitPlayNodeList()
	end,
	Play1109704109 = function(arg_447_0, arg_447_1)
		arg_447_1.time_ = 0
		arg_447_1.frameCnt_ = 0
		arg_447_1.state_ = "playing"
		arg_447_1.curTalkId_ = 1109704109
		arg_447_1.duration_ = 3.4

		local var_447_0 = {
			zh = 1.2,
			ja = 3.4
		}
		local var_447_1 = manager.audio:GetLocalizationFlag()

		if var_447_0[var_447_1] ~= nil then
			arg_447_1.duration_ = var_447_0[var_447_1]
		end

		SetActive(arg_447_1.tipsGo_, false)

		function arg_447_1.onSingleLineFinish_()
			arg_447_1.onSingleLineUpdate_ = nil
			arg_447_1.onSingleLineFinish_ = nil
			arg_447_1.state_ = "waiting"
		end

		function arg_447_1.playNext_(arg_449_0)
			if arg_449_0 == 1 then
				arg_447_0:Play1109704110(arg_447_1)
			end
		end

		function arg_447_1.onSingleLineUpdate_(arg_450_0)
			local var_450_0 = 0.05

			if 0 < arg_447_1.time_ and arg_447_1.time_ <= 0 + arg_450_0 then
				arg_447_1.talkMaxDuration = 0
				arg_447_1.dialogCg_.alpha = 1

				arg_447_1.dialog_:SetActive(true)
				SetActive(arg_447_1.leftNameGo_, true)

				arg_447_1.leftNameTxt_.text = arg_447_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_447_1.leftNameTxt_.transform)

				arg_447_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_447_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_447_1:RecordName(arg_447_1.leftNameTxt_.text)
				SetActive(arg_447_1.iconTrs_.gameObject, false)
				arg_447_1.callingController_:SetSelectedState("normal")

				local var_450_1 = arg_447_1:GetWordFromCfg(1109704109)
				local var_450_2 = arg_447_1:FormatText(var_450_1.content)

				arg_447_1.text_.text = var_450_2

				LuaForUtil.ClearLinePrefixSymbol(arg_447_1.text_)

				local var_450_4 = 2 <= 0 and var_450_0 or var_450_0 * (utf8.len(var_450_2) / 2)

				if (2 <= 0 and var_450_0 or var_450_0 * (utf8.len(var_450_2) / 2)) > 0 and var_450_0 < var_450_4 then
					arg_447_1.talkMaxDuration = var_450_4

					if var_450_4 + 0 > arg_447_1.duration_ then
						arg_447_1.duration_ = var_450_4 + 0
					end
				end

				arg_447_1.text_.text = var_450_2
				arg_447_1.typewritter.percent = 0

				arg_447_1.typewritter:SetDirty()
				arg_447_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704109", "story_v_side_new_1109704.awb") ~= 0 then
					local var_450_5 = manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704109", "story_v_side_new_1109704.awb") / 1000

					if var_450_5 + 0 > arg_447_1.duration_ then
						arg_447_1.duration_ = var_450_5 + 0
					end

					if var_450_1.prefab_name ~= "" and arg_447_1.actors_[var_450_1.prefab_name] ~= nil then
						local var_450_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_447_1.actors_[var_450_1.prefab_name].transform, "story_v_side_new_1109704", "1109704109", "story_v_side_new_1109704.awb")

						arg_447_1:RecordAudio("1109704109", var_450_6)
						arg_447_1:RecordAudio("1109704109", var_450_6)
					else
						arg_447_1:AudioAction("play", "voice", "story_v_side_new_1109704", "1109704109", "story_v_side_new_1109704.awb")
					end

					arg_447_1:RecordHistoryTalkVoice("story_v_side_new_1109704", "1109704109", "story_v_side_new_1109704.awb")
				end

				arg_447_1:RecordContent(arg_447_1.text_.text)
			end

			local var_450_7 = math.max(var_450_0, arg_447_1.talkMaxDuration)

			if 0 <= arg_447_1.time_ and arg_447_1.time_ < 0 + var_450_7 then
				arg_447_1.typewritter.percent = (arg_447_1.time_ - 0) / var_450_7

				arg_447_1.typewritter:SetDirty()
			end

			if arg_447_1.time_ >= 0 + var_450_7 and arg_447_1.time_ < 0 + var_450_7 + arg_450_0 then
				arg_447_1.typewritter.percent = 1

				arg_447_1.typewritter:SetDirty()
				arg_447_1:ShowNextGo(true)
			end
		end

		arg_447_1.nodeConfigList_ = {}

		arg_447_1:InitPlayNodeList()
	end,
	Play1109704110 = function(arg_451_0, arg_451_1)
		arg_451_1.time_ = 0
		arg_451_1.frameCnt_ = 0
		arg_451_1.state_ = "playing"
		arg_451_1.curTalkId_ = 1109704110
		arg_451_1.duration_ = 5

		SetActive(arg_451_1.tipsGo_, false)

		function arg_451_1.onSingleLineFinish_()
			arg_451_1.onSingleLineUpdate_ = nil
			arg_451_1.onSingleLineFinish_ = nil
			arg_451_1.state_ = "waiting"
		end

		function arg_451_1.playNext_(arg_453_0)
			if arg_453_0 == 1 then
				arg_451_0:Play1109704111(arg_451_1)
			end
		end

		function arg_451_1.onSingleLineUpdate_(arg_454_0)
			if 0 < arg_451_1.time_ and arg_451_1.time_ <= 0 + arg_454_0 and not isNil(arg_451_1.actors_["1097ui_story"]) and arg_451_1.var_.characterEffect1097ui_story == nil then
				arg_451_1.var_.characterEffect1097ui_story = arg_451_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_454_0 = 0.200000002980232

			if 0 <= arg_451_1.time_ and arg_451_1.time_ < 0 + var_454_0 and not isNil(arg_451_1.actors_["1097ui_story"]) then
				if arg_451_1.var_.characterEffect1097ui_story and not isNil(arg_451_1.actors_["1097ui_story"]) then
					arg_451_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_451_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_451_1.time_ - 0) / var_454_0)
				end
			end

			if arg_451_1.time_ >= 0 + var_454_0 and arg_451_1.time_ < 0 + var_454_0 + arg_454_0 and not isNil(arg_451_1.actors_["1097ui_story"]) and arg_451_1.var_.characterEffect1097ui_story then
				arg_451_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_451_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_454_1 = 0
			local var_454_2 = 0.175

			if 0 < arg_451_1.time_ and arg_451_1.time_ <= var_454_1 + arg_454_0 then
				arg_451_1.talkMaxDuration = 0
				arg_451_1.dialogCg_.alpha = 1

				arg_451_1.dialog_:SetActive(true)
				SetActive(arg_451_1.leftNameGo_, true)

				arg_451_1.leftNameTxt_.text = arg_451_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_451_1.leftNameTxt_.transform)

				arg_451_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_451_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_451_1:RecordName(arg_451_1.leftNameTxt_.text)
				SetActive(arg_451_1.iconTrs_.gameObject, true)
				arg_451_1.iconController_:SetSelectedState("hero")

				arg_451_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_451_1.callingController_:SetSelectedState("normal")

				arg_451_1.keyicon_.color = Color.New(1, 1, 1)
				arg_451_1.icon_.color = Color.New(1, 1, 1)

				local var_454_3 = arg_451_1:FormatText(arg_451_1:GetWordFromCfg(1109704110).content)

				arg_451_1.text_.text = var_454_3

				LuaForUtil.ClearLinePrefixSymbol(arg_451_1.text_)

				local var_454_5 = 7 <= 0 and var_454_2 or var_454_2 * (utf8.len(var_454_3) / 7)

				if (7 <= 0 and var_454_2 or var_454_2 * (utf8.len(var_454_3) / 7)) > 0 and var_454_2 < var_454_5 then
					arg_451_1.talkMaxDuration = var_454_5

					if var_454_5 + var_454_1 > arg_451_1.duration_ then
						arg_451_1.duration_ = var_454_5 + var_454_1
					end
				end

				arg_451_1.text_.text = var_454_3
				arg_451_1.typewritter.percent = 0

				arg_451_1.typewritter:SetDirty()
				arg_451_1:ShowNextGo(false)
				arg_451_1:RecordContent(arg_451_1.text_.text)
			end

			local var_454_6 = math.max(var_454_2, arg_451_1.talkMaxDuration)

			if var_454_1 <= arg_451_1.time_ and arg_451_1.time_ < var_454_1 + var_454_6 then
				arg_451_1.typewritter.percent = (arg_451_1.time_ - var_454_1) / var_454_6

				arg_451_1.typewritter:SetDirty()
			end

			if arg_451_1.time_ >= var_454_1 + var_454_6 and arg_451_1.time_ < var_454_1 + var_454_6 + arg_454_0 then
				arg_451_1.typewritter.percent = 1

				arg_451_1.typewritter:SetDirty()
				arg_451_1:ShowNextGo(true)
			end
		end

		arg_451_1.nodeConfigList_ = {}

		arg_451_1:InitPlayNodeList()
	end,
	Play1109704111 = function(arg_455_0, arg_455_1)
		arg_455_1.time_ = 0
		arg_455_1.frameCnt_ = 0
		arg_455_1.state_ = "playing"
		arg_455_1.curTalkId_ = 1109704111
		arg_455_1.duration_ = 2.6

		SetActive(arg_455_1.tipsGo_, false)

		function arg_455_1.onSingleLineFinish_()
			arg_455_1.onSingleLineUpdate_ = nil
			arg_455_1.onSingleLineFinish_ = nil
			arg_455_1.state_ = "waiting"
		end

		function arg_455_1.playNext_(arg_457_0)
			if arg_457_0 == 1 then
				arg_455_0:Play1109704112(arg_455_1)
			end
		end

		function arg_455_1.onSingleLineUpdate_(arg_458_0)
			if 0 < arg_455_1.time_ and arg_455_1.time_ <= 0 + arg_458_0 then
				arg_455_1.var_.moveOldPosR9701 = arg_455_1.bgs_.R9701.transform.localPosition
			end

			local var_458_0 = 0.001

			if 0 <= arg_455_1.time_ and arg_455_1.time_ < 0 + var_458_0 then
				arg_455_1.bgs_.R9701.transform.localPosition = Vector3.Lerp(arg_455_1.var_.moveOldPosR9701, Vector3.New(-1.5, -1.5, 1), (arg_455_1.time_ - 0) / var_458_0)
			end

			if arg_455_1.time_ >= 0 + var_458_0 and arg_455_1.time_ < 0 + var_458_0 + arg_458_0 then
				arg_455_1.bgs_.R9701.transform.localPosition = Vector3.New(-1.5, -1.5, 1)
			end

			local var_458_1 = arg_455_1.bgs_.R9701.transform

			if 0.0166666666666666 < arg_455_1.time_ and arg_455_1.time_ <= 0.0166666666666666 + arg_458_0 then
				arg_455_1.var_.moveOldPosR9701 = var_458_1.localPosition
			end

			local var_458_2 = 2.583334

			if 0.0166666666666666 <= arg_455_1.time_ and arg_455_1.time_ < 0.0166666666666666 + var_458_2 then
				var_458_1.localPosition = Vector3.Lerp(arg_455_1.var_.moveOldPosR9701, Vector3.New(-1.5, -1.5, 0.5), (arg_455_1.time_ - 0.0166666666666666) / var_458_2)
			end

			if arg_455_1.time_ >= 0.0166666666666666 + var_458_2 and arg_455_1.time_ < 0.0166666666666666 + var_458_2 + arg_458_0 then
				var_458_1.localPosition = Vector3.New(-1.5, -1.5, 0.5)
			end

			local var_458_3 = 0

			if 0 < arg_455_1.time_ and arg_455_1.time_ <= var_458_3 + arg_458_0 then
				arg_455_1.mask_.enabled = true
				arg_455_1.mask_.raycastTarget = true

				arg_455_1:SetGaussion(false)
			end

			local var_458_4 = 0.5

			if var_458_3 <= arg_455_1.time_ and arg_455_1.time_ < var_458_3 + var_458_4 then
				local var_458_5 = Color.New(0, 0, 0)

				var_458_5.a = Mathf.Lerp(0, 1, (arg_455_1.time_ - var_458_3) / var_458_4)
				arg_455_1.mask_.color = var_458_5
			end

			if arg_455_1.time_ >= var_458_3 + var_458_4 and arg_455_1.time_ < var_458_3 + var_458_4 + arg_458_0 then
				local var_458_6 = Color.New(0, 0, 0)

				var_458_6.a = 1
				arg_455_1.mask_.color = var_458_6
			end

			local var_458_7 = 0.5

			if 0.5 < arg_455_1.time_ and arg_455_1.time_ <= var_458_7 + arg_458_0 then
				arg_455_1.mask_.enabled = true
				arg_455_1.mask_.raycastTarget = true

				arg_455_1:SetGaussion(false)
			end

			local var_458_8 = 0.5

			if var_458_7 <= arg_455_1.time_ and arg_455_1.time_ < var_458_7 + var_458_8 then
				local var_458_9 = Color.New(0, 0, 0)

				var_458_9.a = Mathf.Lerp(1, 0, (arg_455_1.time_ - var_458_7) / var_458_8)
				arg_455_1.mask_.color = var_458_9
			end

			if arg_455_1.time_ >= var_458_7 + var_458_8 and arg_455_1.time_ < var_458_7 + var_458_8 + arg_458_0 then
				local var_458_10 = Color.New(0, 0, 0)

				arg_455_1.mask_.enabled = false
				var_458_10.a = 0
				arg_455_1.mask_.color = var_458_10
			end

			local var_458_11 = 1

			if 1 < arg_455_1.time_ and arg_455_1.time_ <= var_458_11 + arg_458_0 then
				arg_455_1.allBtn_.enabled = false
			end

			if arg_455_1.time_ >= var_458_11 + 1.60000066666667 and arg_455_1.time_ < var_458_11 + 1.60000066666667 + arg_458_0 then
				arg_455_1.allBtn_.enabled = true
			end

			local var_458_12 = 0.9
			local var_458_13 = 0.1

			if 0.9 < arg_455_1.time_ and arg_455_1.time_ <= var_458_12 + arg_458_0 then
				arg_455_1.talkMaxDuration = 0
				arg_455_1.dialogCg_.alpha = 1

				arg_455_1.dialog_:SetActive(true)
				SetActive(arg_455_1.leftNameGo_, true)

				arg_455_1.leftNameTxt_.text = arg_455_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_455_1.leftNameTxt_.transform)

				arg_455_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_455_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_455_1:RecordName(arg_455_1.leftNameTxt_.text)
				SetActive(arg_455_1.iconTrs_.gameObject, false)
				arg_455_1.callingController_:SetSelectedState("normal")

				local var_458_14 = arg_455_1:GetWordFromCfg(1109704111)
				local var_458_15 = arg_455_1:FormatText(var_458_14.content)

				arg_455_1.text_.text = var_458_15

				LuaForUtil.ClearLinePrefixSymbol(arg_455_1.text_)

				local var_458_17 = 4 <= 0 and var_458_13 or var_458_13 * (utf8.len(var_458_15) / 4)

				if (4 <= 0 and var_458_13 or var_458_13 * (utf8.len(var_458_15) / 4)) > 0 and var_458_13 < var_458_17 then
					arg_455_1.talkMaxDuration = var_458_17

					if var_458_17 + var_458_12 > arg_455_1.duration_ then
						arg_455_1.duration_ = var_458_17 + var_458_12
					end
				end

				arg_455_1.text_.text = var_458_15
				arg_455_1.typewritter.percent = 0

				arg_455_1.typewritter:SetDirty()
				arg_455_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704111", "story_v_side_new_1109704.awb") ~= 0 then
					local var_458_18 = manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704111", "story_v_side_new_1109704.awb") / 1000

					if var_458_18 + var_458_12 > arg_455_1.duration_ then
						arg_455_1.duration_ = var_458_18 + var_458_12
					end

					if var_458_14.prefab_name ~= "" and arg_455_1.actors_[var_458_14.prefab_name] ~= nil then
						local var_458_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_455_1.actors_[var_458_14.prefab_name].transform, "story_v_side_new_1109704", "1109704111", "story_v_side_new_1109704.awb")

						arg_455_1:RecordAudio("1109704111", var_458_19)
						arg_455_1:RecordAudio("1109704111", var_458_19)
					else
						arg_455_1:AudioAction("play", "voice", "story_v_side_new_1109704", "1109704111", "story_v_side_new_1109704.awb")
					end

					arg_455_1:RecordHistoryTalkVoice("story_v_side_new_1109704", "1109704111", "story_v_side_new_1109704.awb")
				end

				arg_455_1:RecordContent(arg_455_1.text_.text)
			end

			local var_458_20 = math.max(var_458_13, arg_455_1.talkMaxDuration)

			if var_458_12 <= arg_455_1.time_ and arg_455_1.time_ < var_458_12 + var_458_20 then
				arg_455_1.typewritter.percent = (arg_455_1.time_ - var_458_12) / var_458_20

				arg_455_1.typewritter:SetDirty()
			end

			if arg_455_1.time_ >= var_458_12 + var_458_20 and arg_455_1.time_ < var_458_12 + var_458_20 + arg_458_0 then
				arg_455_1.typewritter.percent = 1

				arg_455_1.typewritter:SetDirty()
				arg_455_1:ShowNextGo(true)
			end
		end

		arg_455_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "R9701",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "R9701",
				changeDisplayLayer = false,
				needEase = false,
				duration = 2.583334,
				className = "StoryMoveNode",
				startTime = 0.0166666666666666,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_455_1:InitPlayNodeList()
	end,
	Play1109704112 = function(arg_459_0, arg_459_1)
		arg_459_1.time_ = 0
		arg_459_1.frameCnt_ = 0
		arg_459_1.state_ = "playing"
		arg_459_1.curTalkId_ = 1109704112
		arg_459_1.duration_ = 5

		SetActive(arg_459_1.tipsGo_, false)

		function arg_459_1.onSingleLineFinish_()
			arg_459_1.onSingleLineUpdate_ = nil
			arg_459_1.onSingleLineFinish_ = nil
			arg_459_1.state_ = "waiting"
		end

		function arg_459_1.playNext_(arg_461_0)
			if arg_461_0 == 1 then
				arg_459_0:Play1109704113(arg_459_1)
			end
		end

		function arg_459_1.onSingleLineUpdate_(arg_462_0)
			local var_462_0 = 0.9

			if 0 < arg_459_1.time_ and arg_459_1.time_ <= 0 + arg_462_0 then
				arg_459_1.talkMaxDuration = 0
				arg_459_1.dialogCg_.alpha = 1

				arg_459_1.dialog_:SetActive(true)
				SetActive(arg_459_1.leftNameGo_, false)

				arg_459_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_459_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_459_1:RecordName(arg_459_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_459_1.iconTrs_.gameObject, false)
				arg_459_1.callingController_:SetSelectedState("normal")

				local var_462_1 = arg_459_1:FormatText(arg_459_1:GetWordFromCfg(1109704112).content)

				arg_459_1.text_.text = var_462_1

				LuaForUtil.ClearLinePrefixSymbol(arg_459_1.text_)

				local var_462_3 = 36 <= 0 and var_462_0 or var_462_0 * (utf8.len(var_462_1) / 36)

				if (36 <= 0 and var_462_0 or var_462_0 * (utf8.len(var_462_1) / 36)) > 0 and var_462_0 < var_462_3 then
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
	Play1109704113 = function(arg_463_0, arg_463_1)
		arg_463_1.time_ = 0
		arg_463_1.frameCnt_ = 0
		arg_463_1.state_ = "playing"
		arg_463_1.curTalkId_ = 1109704113
		arg_463_1.duration_ = 5

		SetActive(arg_463_1.tipsGo_, false)

		function arg_463_1.onSingleLineFinish_()
			arg_463_1.onSingleLineUpdate_ = nil
			arg_463_1.onSingleLineFinish_ = nil
			arg_463_1.state_ = "waiting"
		end

		function arg_463_1.playNext_(arg_465_0)
			if arg_465_0 == 1 then
				arg_463_0:Play1109704114(arg_463_1)
			end
		end

		function arg_463_1.onSingleLineUpdate_(arg_466_0)
			local var_466_0 = 0.15

			if 0 < arg_463_1.time_ and arg_463_1.time_ <= 0 + arg_466_0 then
				arg_463_1.talkMaxDuration = 0
				arg_463_1.dialogCg_.alpha = 1

				arg_463_1.dialog_:SetActive(true)
				SetActive(arg_463_1.leftNameGo_, true)

				arg_463_1.leftNameTxt_.text = arg_463_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_463_1.leftNameTxt_.transform)

				arg_463_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_463_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_463_1:RecordName(arg_463_1.leftNameTxt_.text)
				SetActive(arg_463_1.iconTrs_.gameObject, true)
				arg_463_1.iconController_:SetSelectedState("hero")

				arg_463_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_463_1.callingController_:SetSelectedState("normal")

				arg_463_1.keyicon_.color = Color.New(1, 1, 1)
				arg_463_1.icon_.color = Color.New(1, 1, 1)

				local var_466_1 = arg_463_1:FormatText(arg_463_1:GetWordFromCfg(1109704113).content)

				arg_463_1.text_.text = var_466_1

				LuaForUtil.ClearLinePrefixSymbol(arg_463_1.text_)

				local var_466_3 = 6 <= 0 and var_466_0 or var_466_0 * (utf8.len(var_466_1) / 6)

				if (6 <= 0 and var_466_0 or var_466_0 * (utf8.len(var_466_1) / 6)) > 0 and var_466_0 < var_466_3 then
					arg_463_1.talkMaxDuration = var_466_3

					if var_466_3 + 0 > arg_463_1.duration_ then
						arg_463_1.duration_ = var_466_3 + 0
					end
				end

				arg_463_1.text_.text = var_466_1
				arg_463_1.typewritter.percent = 0

				arg_463_1.typewritter:SetDirty()
				arg_463_1:ShowNextGo(false)
				arg_463_1:RecordContent(arg_463_1.text_.text)
			end

			local var_466_4 = math.max(var_466_0, arg_463_1.talkMaxDuration)

			if 0 <= arg_463_1.time_ and arg_463_1.time_ < 0 + var_466_4 then
				arg_463_1.typewritter.percent = (arg_463_1.time_ - 0) / var_466_4

				arg_463_1.typewritter:SetDirty()
			end

			if arg_463_1.time_ >= 0 + var_466_4 and arg_463_1.time_ < 0 + var_466_4 + arg_466_0 then
				arg_463_1.typewritter.percent = 1

				arg_463_1.typewritter:SetDirty()
				arg_463_1:ShowNextGo(true)
			end
		end

		arg_463_1.nodeConfigList_ = {}

		arg_463_1:InitPlayNodeList()
	end,
	Play1109704114 = function(arg_467_0, arg_467_1)
		arg_467_1.time_ = 0
		arg_467_1.frameCnt_ = 0
		arg_467_1.state_ = "playing"
		arg_467_1.curTalkId_ = 1109704114
		arg_467_1.duration_ = 5

		SetActive(arg_467_1.tipsGo_, false)

		function arg_467_1.onSingleLineFinish_()
			arg_467_1.onSingleLineUpdate_ = nil
			arg_467_1.onSingleLineFinish_ = nil
			arg_467_1.state_ = "waiting"
		end

		function arg_467_1.playNext_(arg_469_0)
			if arg_469_0 == 1 then
				arg_467_0:Play1109704115(arg_467_1)
			end
		end

		function arg_467_1.onSingleLineUpdate_(arg_470_0)
			local var_470_0 = 0.75

			if 0 < arg_467_1.time_ and arg_467_1.time_ <= 0 + arg_470_0 then
				arg_467_1.talkMaxDuration = 0
				arg_467_1.dialogCg_.alpha = 1

				arg_467_1.dialog_:SetActive(true)
				SetActive(arg_467_1.leftNameGo_, false)

				arg_467_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_467_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_467_1:RecordName(arg_467_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_467_1.iconTrs_.gameObject, false)
				arg_467_1.callingController_:SetSelectedState("normal")

				local var_470_1 = arg_467_1:FormatText(arg_467_1:GetWordFromCfg(1109704114).content)

				arg_467_1.text_.text = var_470_1

				LuaForUtil.ClearLinePrefixSymbol(arg_467_1.text_)

				local var_470_3 = 30 <= 0 and var_470_0 or var_470_0 * (utf8.len(var_470_1) / 30)

				if (30 <= 0 and var_470_0 or var_470_0 * (utf8.len(var_470_1) / 30)) > 0 and var_470_0 < var_470_3 then
					arg_467_1.talkMaxDuration = var_470_3

					if var_470_3 + 0 > arg_467_1.duration_ then
						arg_467_1.duration_ = var_470_3 + 0
					end
				end

				arg_467_1.text_.text = var_470_1
				arg_467_1.typewritter.percent = 0

				arg_467_1.typewritter:SetDirty()
				arg_467_1:ShowNextGo(false)
				arg_467_1:RecordContent(arg_467_1.text_.text)
			end

			local var_470_4 = math.max(var_470_0, arg_467_1.talkMaxDuration)

			if 0 <= arg_467_1.time_ and arg_467_1.time_ < 0 + var_470_4 then
				arg_467_1.typewritter.percent = (arg_467_1.time_ - 0) / var_470_4

				arg_467_1.typewritter:SetDirty()
			end

			if arg_467_1.time_ >= 0 + var_470_4 and arg_467_1.time_ < 0 + var_470_4 + arg_470_0 then
				arg_467_1.typewritter.percent = 1

				arg_467_1.typewritter:SetDirty()
				arg_467_1:ShowNextGo(true)
			end
		end

		arg_467_1.nodeConfigList_ = {}

		arg_467_1:InitPlayNodeList()
	end,
	Play1109704115 = function(arg_471_0, arg_471_1)
		arg_471_1.time_ = 0
		arg_471_1.frameCnt_ = 0
		arg_471_1.state_ = "playing"
		arg_471_1.curTalkId_ = 1109704115
		arg_471_1.duration_ = 3.97

		local var_471_0 = {
			zh = 3.966,
			ja = 2.533
		}
		local var_471_1 = manager.audio:GetLocalizationFlag()

		if var_471_0[var_471_1] ~= nil then
			arg_471_1.duration_ = var_471_0[var_471_1]
		end

		SetActive(arg_471_1.tipsGo_, false)

		function arg_471_1.onSingleLineFinish_()
			arg_471_1.onSingleLineUpdate_ = nil
			arg_471_1.onSingleLineFinish_ = nil
			arg_471_1.state_ = "waiting"
		end

		function arg_471_1.playNext_(arg_473_0)
			if arg_473_0 == 1 then
				arg_471_0:Play1109704116(arg_471_1)
			end
		end

		function arg_471_1.onSingleLineUpdate_(arg_474_0)
			local var_474_0 = 0.525

			if 0 < arg_471_1.time_ and arg_471_1.time_ <= 0 + arg_474_0 then
				arg_471_1.talkMaxDuration = 0
				arg_471_1.dialogCg_.alpha = 1

				arg_471_1.dialog_:SetActive(true)
				SetActive(arg_471_1.leftNameGo_, true)

				arg_471_1.leftNameTxt_.text = arg_471_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_471_1.leftNameTxt_.transform)

				arg_471_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_471_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_471_1:RecordName(arg_471_1.leftNameTxt_.text)
				SetActive(arg_471_1.iconTrs_.gameObject, false)
				arg_471_1.callingController_:SetSelectedState("normal")

				local var_474_1 = arg_471_1:GetWordFromCfg(1109704115)
				local var_474_2 = arg_471_1:FormatText(var_474_1.content)

				arg_471_1.text_.text = var_474_2

				LuaForUtil.ClearLinePrefixSymbol(arg_471_1.text_)

				local var_474_4 = 21 <= 0 and var_474_0 or var_474_0 * (utf8.len(var_474_2) / 21)

				if (21 <= 0 and var_474_0 or var_474_0 * (utf8.len(var_474_2) / 21)) > 0 and var_474_0 < var_474_4 then
					arg_471_1.talkMaxDuration = var_474_4

					if var_474_4 + 0 > arg_471_1.duration_ then
						arg_471_1.duration_ = var_474_4 + 0
					end
				end

				arg_471_1.text_.text = var_474_2
				arg_471_1.typewritter.percent = 0

				arg_471_1.typewritter:SetDirty()
				arg_471_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704115", "story_v_side_new_1109704.awb") ~= 0 then
					local var_474_5 = manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704115", "story_v_side_new_1109704.awb") / 1000

					if var_474_5 + 0 > arg_471_1.duration_ then
						arg_471_1.duration_ = var_474_5 + 0
					end

					if var_474_1.prefab_name ~= "" and arg_471_1.actors_[var_474_1.prefab_name] ~= nil then
						local var_474_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_471_1.actors_[var_474_1.prefab_name].transform, "story_v_side_new_1109704", "1109704115", "story_v_side_new_1109704.awb")

						arg_471_1:RecordAudio("1109704115", var_474_6)
						arg_471_1:RecordAudio("1109704115", var_474_6)
					else
						arg_471_1:AudioAction("play", "voice", "story_v_side_new_1109704", "1109704115", "story_v_side_new_1109704.awb")
					end

					arg_471_1:RecordHistoryTalkVoice("story_v_side_new_1109704", "1109704115", "story_v_side_new_1109704.awb")
				end

				arg_471_1:RecordContent(arg_471_1.text_.text)
			end

			local var_474_7 = math.max(var_474_0, arg_471_1.talkMaxDuration)

			if 0 <= arg_471_1.time_ and arg_471_1.time_ < 0 + var_474_7 then
				arg_471_1.typewritter.percent = (arg_471_1.time_ - 0) / var_474_7

				arg_471_1.typewritter:SetDirty()
			end

			if arg_471_1.time_ >= 0 + var_474_7 and arg_471_1.time_ < 0 + var_474_7 + arg_474_0 then
				arg_471_1.typewritter.percent = 1

				arg_471_1.typewritter:SetDirty()
				arg_471_1:ShowNextGo(true)
			end
		end

		arg_471_1.nodeConfigList_ = {}

		arg_471_1:InitPlayNodeList()
	end,
	Play1109704116 = function(arg_475_0, arg_475_1)
		arg_475_1.time_ = 0
		arg_475_1.frameCnt_ = 0
		arg_475_1.state_ = "playing"
		arg_475_1.curTalkId_ = 1109704116
		arg_475_1.duration_ = 5

		SetActive(arg_475_1.tipsGo_, false)

		function arg_475_1.onSingleLineFinish_()
			arg_475_1.onSingleLineUpdate_ = nil
			arg_475_1.onSingleLineFinish_ = nil
			arg_475_1.state_ = "waiting"
		end

		function arg_475_1.playNext_(arg_477_0)
			if arg_477_0 == 1 then
				arg_475_0:Play1109704117(arg_475_1)
			end
		end

		function arg_475_1.onSingleLineUpdate_(arg_478_0)
			if 0 < arg_475_1.time_ and arg_475_1.time_ <= 0 + arg_478_0 and not isNil(arg_475_1.actors_["1097ui_story"]) and arg_475_1.var_.characterEffect1097ui_story == nil then
				arg_475_1.var_.characterEffect1097ui_story = arg_475_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_478_0 = 0.200000002980232

			if 0 <= arg_475_1.time_ and arg_475_1.time_ < 0 + var_478_0 and not isNil(arg_475_1.actors_["1097ui_story"]) then
				if arg_475_1.var_.characterEffect1097ui_story and not isNil(arg_475_1.actors_["1097ui_story"]) then
					arg_475_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_475_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_475_1.time_ - 0) / var_478_0)
				end
			end

			if arg_475_1.time_ >= 0 + var_478_0 and arg_475_1.time_ < 0 + var_478_0 + arg_478_0 and not isNil(arg_475_1.actors_["1097ui_story"]) and arg_475_1.var_.characterEffect1097ui_story then
				arg_475_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_475_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_478_1 = 0
			local var_478_2 = 0.125

			if 0 < arg_475_1.time_ and arg_475_1.time_ <= var_478_1 + arg_478_0 then
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

				local var_478_3 = arg_475_1:FormatText(arg_475_1:GetWordFromCfg(1109704116).content)

				arg_475_1.text_.text = var_478_3

				LuaForUtil.ClearLinePrefixSymbol(arg_475_1.text_)

				local var_478_5 = 5 <= 0 and var_478_2 or var_478_2 * (utf8.len(var_478_3) / 5)

				if (5 <= 0 and var_478_2 or var_478_2 * (utf8.len(var_478_3) / 5)) > 0 and var_478_2 < var_478_5 then
					arg_475_1.talkMaxDuration = var_478_5

					if var_478_5 + var_478_1 > arg_475_1.duration_ then
						arg_475_1.duration_ = var_478_5 + var_478_1
					end
				end

				arg_475_1.text_.text = var_478_3
				arg_475_1.typewritter.percent = 0

				arg_475_1.typewritter:SetDirty()
				arg_475_1:ShowNextGo(false)
				arg_475_1:RecordContent(arg_475_1.text_.text)
			end

			local var_478_6 = math.max(var_478_2, arg_475_1.talkMaxDuration)

			if var_478_1 <= arg_475_1.time_ and arg_475_1.time_ < var_478_1 + var_478_6 then
				arg_475_1.typewritter.percent = (arg_475_1.time_ - var_478_1) / var_478_6

				arg_475_1.typewritter:SetDirty()
			end

			if arg_475_1.time_ >= var_478_1 + var_478_6 and arg_475_1.time_ < var_478_1 + var_478_6 + arg_478_0 then
				arg_475_1.typewritter.percent = 1

				arg_475_1.typewritter:SetDirty()
				arg_475_1:ShowNextGo(true)
			end
		end

		arg_475_1.nodeConfigList_ = {}

		arg_475_1:InitPlayNodeList()
	end,
	Play1109704117 = function(arg_479_0, arg_479_1)
		arg_479_1.time_ = 0
		arg_479_1.frameCnt_ = 0
		arg_479_1.state_ = "playing"
		arg_479_1.curTalkId_ = 1109704117
		arg_479_1.duration_ = 5

		SetActive(arg_479_1.tipsGo_, false)

		function arg_479_1.onSingleLineFinish_()
			arg_479_1.onSingleLineUpdate_ = nil
			arg_479_1.onSingleLineFinish_ = nil
			arg_479_1.state_ = "waiting"
		end

		function arg_479_1.playNext_(arg_481_0)
			if arg_481_0 == 1 then
				arg_479_0:Play1109704118(arg_479_1)
			end
		end

		function arg_479_1.onSingleLineUpdate_(arg_482_0)
			local var_482_0 = 0.925

			if 0 < arg_479_1.time_ and arg_479_1.time_ <= 0 + arg_482_0 then
				arg_479_1.talkMaxDuration = 0
				arg_479_1.dialogCg_.alpha = 1

				arg_479_1.dialog_:SetActive(true)
				SetActive(arg_479_1.leftNameGo_, false)

				arg_479_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_479_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_479_1:RecordName(arg_479_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_479_1.iconTrs_.gameObject, false)
				arg_479_1.callingController_:SetSelectedState("normal")

				local var_482_1 = arg_479_1:FormatText(arg_479_1:GetWordFromCfg(1109704117).content)

				arg_479_1.text_.text = var_482_1

				LuaForUtil.ClearLinePrefixSymbol(arg_479_1.text_)

				local var_482_3 = 37 <= 0 and var_482_0 or var_482_0 * (utf8.len(var_482_1) / 37)

				if (37 <= 0 and var_482_0 or var_482_0 * (utf8.len(var_482_1) / 37)) > 0 and var_482_0 < var_482_3 then
					arg_479_1.talkMaxDuration = var_482_3

					if var_482_3 + 0 > arg_479_1.duration_ then
						arg_479_1.duration_ = var_482_3 + 0
					end
				end

				arg_479_1.text_.text = var_482_1
				arg_479_1.typewritter.percent = 0

				arg_479_1.typewritter:SetDirty()
				arg_479_1:ShowNextGo(false)
				arg_479_1:RecordContent(arg_479_1.text_.text)
			end

			local var_482_4 = math.max(var_482_0, arg_479_1.talkMaxDuration)

			if 0 <= arg_479_1.time_ and arg_479_1.time_ < 0 + var_482_4 then
				arg_479_1.typewritter.percent = (arg_479_1.time_ - 0) / var_482_4

				arg_479_1.typewritter:SetDirty()
			end

			if arg_479_1.time_ >= 0 + var_482_4 and arg_479_1.time_ < 0 + var_482_4 + arg_482_0 then
				arg_479_1.typewritter.percent = 1

				arg_479_1.typewritter:SetDirty()
				arg_479_1:ShowNextGo(true)
			end
		end

		arg_479_1.nodeConfigList_ = {}

		arg_479_1:InitPlayNodeList()
	end,
	Play1109704118 = function(arg_483_0, arg_483_1)
		arg_483_1.time_ = 0
		arg_483_1.frameCnt_ = 0
		arg_483_1.state_ = "playing"
		arg_483_1.curTalkId_ = 1109704118
		arg_483_1.duration_ = 5

		SetActive(arg_483_1.tipsGo_, false)

		function arg_483_1.onSingleLineFinish_()
			arg_483_1.onSingleLineUpdate_ = nil
			arg_483_1.onSingleLineFinish_ = nil
			arg_483_1.state_ = "waiting"
		end

		function arg_483_1.playNext_(arg_485_0)
			if arg_485_0 == 1 then
				arg_483_0:Play1109704119(arg_483_1)
			end
		end

		function arg_483_1.onSingleLineUpdate_(arg_486_0)
			local var_486_0 = 0.55

			if 0 < arg_483_1.time_ and arg_483_1.time_ <= 0 + arg_486_0 then
				arg_483_1.talkMaxDuration = 0
				arg_483_1.dialogCg_.alpha = 1

				arg_483_1.dialog_:SetActive(true)
				SetActive(arg_483_1.leftNameGo_, false)

				arg_483_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_483_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_483_1:RecordName(arg_483_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_483_1.iconTrs_.gameObject, false)
				arg_483_1.callingController_:SetSelectedState("normal")

				local var_486_1 = arg_483_1:FormatText(arg_483_1:GetWordFromCfg(1109704118).content)

				arg_483_1.text_.text = var_486_1

				LuaForUtil.ClearLinePrefixSymbol(arg_483_1.text_)

				local var_486_3 = 22 <= 0 and var_486_0 or var_486_0 * (utf8.len(var_486_1) / 22)

				if (22 <= 0 and var_486_0 or var_486_0 * (utf8.len(var_486_1) / 22)) > 0 and var_486_0 < var_486_3 then
					arg_483_1.talkMaxDuration = var_486_3

					if var_486_3 + 0 > arg_483_1.duration_ then
						arg_483_1.duration_ = var_486_3 + 0
					end
				end

				arg_483_1.text_.text = var_486_1
				arg_483_1.typewritter.percent = 0

				arg_483_1.typewritter:SetDirty()
				arg_483_1:ShowNextGo(false)
				arg_483_1:RecordContent(arg_483_1.text_.text)
			end

			local var_486_4 = math.max(var_486_0, arg_483_1.talkMaxDuration)

			if 0 <= arg_483_1.time_ and arg_483_1.time_ < 0 + var_486_4 then
				arg_483_1.typewritter.percent = (arg_483_1.time_ - 0) / var_486_4

				arg_483_1.typewritter:SetDirty()
			end

			if arg_483_1.time_ >= 0 + var_486_4 and arg_483_1.time_ < 0 + var_486_4 + arg_486_0 then
				arg_483_1.typewritter.percent = 1

				arg_483_1.typewritter:SetDirty()
				arg_483_1:ShowNextGo(true)
			end
		end

		arg_483_1.nodeConfigList_ = {}

		arg_483_1:InitPlayNodeList()
	end,
	Play1109704119 = function(arg_487_0, arg_487_1)
		arg_487_1.time_ = 0
		arg_487_1.frameCnt_ = 0
		arg_487_1.state_ = "playing"
		arg_487_1.curTalkId_ = 1109704119
		arg_487_1.duration_ = 9

		SetActive(arg_487_1.tipsGo_, false)

		function arg_487_1.onSingleLineFinish_()
			arg_487_1.onSingleLineUpdate_ = nil
			arg_487_1.onSingleLineFinish_ = nil
			arg_487_1.state_ = "waiting"
		end

		function arg_487_1.playNext_(arg_489_0)
			if arg_489_0 == 1 then
				arg_487_0:Play1109704120(arg_487_1)
			end
		end

		function arg_487_1.onSingleLineUpdate_(arg_490_0)
			if 2 < arg_487_1.time_ and arg_487_1.time_ <= 2 + arg_490_0 then
				local var_490_0 = arg_487_1.bgs_.ST60

				arg_487_1.bgs_.ST60.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_490_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_490_1 = var_490_0:GetComponent("SpriteRenderer")

				if var_490_1 and var_490_1.sprite then
					local var_490_2 = 2 * (var_490_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_490_0.transform.localScale = Vector3.New(var_490_2 / var_490_1.sprite.bounds.size.y < var_490_2 * manager.ui.mainCameraCom_.aspect / var_490_1.sprite.bounds.size.x and var_490_2 * manager.ui.mainCameraCom_.aspect / var_490_1.sprite.bounds.size.x or var_490_2 / var_490_1.sprite.bounds.size.y, var_490_2 / var_490_1.sprite.bounds.size.y < var_490_2 * manager.ui.mainCameraCom_.aspect / var_490_1.sprite.bounds.size.x and var_490_2 * manager.ui.mainCameraCom_.aspect / var_490_1.sprite.bounds.size.x or var_490_2 / var_490_1.sprite.bounds.size.y, 0)
				end

				for iter_490_0, iter_490_1 in pairs(arg_487_1.bgs_) do
					if iter_490_0 ~= "ST60" then
						iter_490_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_490_3 = 4

			if 4 < arg_487_1.time_ and arg_487_1.time_ <= var_490_3 + arg_490_0 then
				arg_487_1.allBtn_.enabled = false
			end

			if arg_487_1.time_ >= var_490_3 + 0.3 and arg_487_1.time_ < var_490_3 + 0.3 + arg_490_0 then
				arg_487_1.allBtn_.enabled = true
			end

			local var_490_4 = 0

			if 0 < arg_487_1.time_ and arg_487_1.time_ <= var_490_4 + arg_490_0 then
				arg_487_1.mask_.enabled = true
				arg_487_1.mask_.raycastTarget = true

				arg_487_1:SetGaussion(false)
			end

			local var_490_5 = 2

			if var_490_4 <= arg_487_1.time_ and arg_487_1.time_ < var_490_4 + var_490_5 then
				local var_490_6 = Color.New(1, 1, 1)

				var_490_6.a = Mathf.Lerp(0, 1, (arg_487_1.time_ - var_490_4) / var_490_5)
				arg_487_1.mask_.color = var_490_6
			end

			if arg_487_1.time_ >= var_490_4 + var_490_5 and arg_487_1.time_ < var_490_4 + var_490_5 + arg_490_0 then
				local var_490_7 = Color.New(1, 1, 1)

				var_490_7.a = 1
				arg_487_1.mask_.color = var_490_7
			end

			local var_490_8 = 2

			if 2 < arg_487_1.time_ and arg_487_1.time_ <= var_490_8 + arg_490_0 then
				arg_487_1.mask_.enabled = true
				arg_487_1.mask_.raycastTarget = true

				arg_487_1:SetGaussion(false)
			end

			local var_490_9 = 2

			if var_490_8 <= arg_487_1.time_ and arg_487_1.time_ < var_490_8 + var_490_9 then
				local var_490_10 = Color.New(1, 1, 1)

				var_490_10.a = Mathf.Lerp(1, 0, (arg_487_1.time_ - var_490_8) / var_490_9)
				arg_487_1.mask_.color = var_490_10
			end

			if arg_487_1.time_ >= var_490_8 + var_490_9 and arg_487_1.time_ < var_490_8 + var_490_9 + arg_490_0 then
				local var_490_11 = Color.New(1, 1, 1)

				arg_487_1.mask_.enabled = false
				var_490_11.a = 0
				arg_487_1.mask_.color = var_490_11
			end

			if arg_487_1.frameCnt_ <= 1 then
				arg_487_1.dialog_:SetActive(false)
			end

			local var_490_12 = 4
			local var_490_13 = 0.6

			if 4 < arg_487_1.time_ and arg_487_1.time_ <= var_490_12 + arg_490_0 then
				arg_487_1.talkMaxDuration = 0

				arg_487_1.dialog_:SetActive(true)

				arg_487_1.dialogCg_.alpha = 0

				local var_490_14 = LeanTween.value(arg_487_1.dialog_, 0, 1, 0.3)

				var_490_14:setOnUpdate(LuaHelper.FloatAction(function(arg_491_0)
					arg_487_1.dialogCg_.alpha = arg_491_0
				end))
				var_490_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_487_1.dialog_)
					var_490_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_487_1.duration_ = arg_487_1.duration_ + 0.3

				SetActive(arg_487_1.leftNameGo_, true)

				arg_487_1.leftNameTxt_.text = arg_487_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_487_1.leftNameTxt_.transform)

				arg_487_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_487_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_487_1:RecordName(arg_487_1.leftNameTxt_.text)
				SetActive(arg_487_1.iconTrs_.gameObject, true)
				arg_487_1.iconController_:SetSelectedState("hero")

				arg_487_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_487_1.callingController_:SetSelectedState("normal")

				arg_487_1.keyicon_.color = Color.New(1, 1, 1)
				arg_487_1.icon_.color = Color.New(1, 1, 1)

				local var_490_15 = arg_487_1:FormatText(arg_487_1:GetWordFromCfg(1109704119).content)

				arg_487_1.text_.text = var_490_15

				LuaForUtil.ClearLinePrefixSymbol(arg_487_1.text_)

				local var_490_17 = 24 <= 0 and var_490_13 or var_490_13 * (utf8.len(var_490_15) / 24)

				if (24 <= 0 and var_490_13 or var_490_13 * (utf8.len(var_490_15) / 24)) > 0 and var_490_13 < var_490_17 then
					arg_487_1.talkMaxDuration = var_490_17
					var_490_12 = var_490_12 + 0.3

					if var_490_17 + var_490_12 > arg_487_1.duration_ then
						arg_487_1.duration_ = var_490_17 + var_490_12
					end
				end

				arg_487_1.text_.text = var_490_15
				arg_487_1.typewritter.percent = 0

				arg_487_1.typewritter:SetDirty()
				arg_487_1:ShowNextGo(false)
				arg_487_1:RecordContent(arg_487_1.text_.text)
			end

			local var_490_18 = var_490_12 + 0.3
			local var_490_19 = math.max(var_490_13, arg_487_1.talkMaxDuration)

			if var_490_12 + 0.3 <= arg_487_1.time_ and arg_487_1.time_ < var_490_18 + var_490_19 then
				arg_487_1.typewritter.percent = (arg_487_1.time_ - var_490_18) / var_490_19

				arg_487_1.typewritter:SetDirty()
			end

			if arg_487_1.time_ >= var_490_18 + var_490_19 and arg_487_1.time_ < var_490_18 + var_490_19 + arg_490_0 then
				arg_487_1.typewritter.percent = 1

				arg_487_1.typewritter:SetDirty()
				arg_487_1:ShowNextGo(true)
			end
		end

		arg_487_1.nodeConfigList_ = {}

		arg_487_1:InitPlayNodeList()
	end,
	Play1109704120 = function(arg_493_0, arg_493_1)
		arg_493_1.time_ = 0
		arg_493_1.frameCnt_ = 0
		arg_493_1.state_ = "playing"
		arg_493_1.curTalkId_ = 1109704120
		arg_493_1.duration_ = 4.4

		local var_493_0 = {
			zh = 4.366,
			ja = 4.4
		}
		local var_493_1 = manager.audio:GetLocalizationFlag()

		if var_493_0[var_493_1] ~= nil then
			arg_493_1.duration_ = var_493_0[var_493_1]
		end

		SetActive(arg_493_1.tipsGo_, false)

		function arg_493_1.onSingleLineFinish_()
			arg_493_1.onSingleLineUpdate_ = nil
			arg_493_1.onSingleLineFinish_ = nil
			arg_493_1.state_ = "waiting"
		end

		function arg_493_1.playNext_(arg_495_0)
			if arg_495_0 == 1 then
				arg_493_0:Play1109704121(arg_493_1)
			end
		end

		function arg_493_1.onSingleLineUpdate_(arg_496_0)
			if 0 < arg_493_1.time_ and arg_493_1.time_ <= 0 + arg_496_0 then
				arg_493_1.var_.moveOldPos1097ui_story = arg_493_1.actors_["1097ui_story"].transform.localPosition
			end

			local var_496_0 = 0.001

			if 0 <= arg_493_1.time_ and arg_493_1.time_ < 0 + var_496_0 then
				arg_493_1.actors_["1097ui_story"].transform.localPosition = Vector3.Lerp(arg_493_1.var_.moveOldPos1097ui_story, Vector3.New(0, -0.54, -6.3), (arg_493_1.time_ - 0) / var_496_0)
				arg_493_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_493_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_493_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_493_1.actors_["1097ui_story"].transform.position).z)
				arg_493_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_493_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_493_1.actors_["1097ui_story"].transform.localEulerAngles = arg_493_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			if arg_493_1.time_ >= 0 + var_496_0 and arg_493_1.time_ < 0 + var_496_0 + arg_496_0 then
				arg_493_1.actors_["1097ui_story"].transform.localPosition = Vector3.New(0, -0.54, -6.3)
				arg_493_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_493_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_493_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_493_1.actors_["1097ui_story"].transform.position).z)
				arg_493_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_493_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_493_1.actors_["1097ui_story"].transform.localEulerAngles = arg_493_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			local var_496_1 = arg_493_1.actors_["1097ui_story"]

			if 0 < arg_493_1.time_ and arg_493_1.time_ <= 0 + arg_496_0 and not isNil(var_496_1) and arg_493_1.var_.characterEffect1097ui_story == nil then
				arg_493_1.var_.characterEffect1097ui_story = var_496_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_496_2 = 0.200000002980232

			if 0 <= arg_493_1.time_ and arg_493_1.time_ < 0 + var_496_2 and not isNil(var_496_1) then
				if arg_493_1.var_.characterEffect1097ui_story and not isNil(var_496_1) then
					arg_493_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_493_1.time_ >= 0 + var_496_2 and arg_493_1.time_ < 0 + var_496_2 + arg_496_0 and not isNil(var_496_1) and arg_493_1.var_.characterEffect1097ui_story then
				arg_493_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_493_1.time_ and arg_493_1.time_ <= 0 + arg_496_0 then
				arg_493_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			if 0 < arg_493_1.time_ and arg_493_1.time_ <= 0 + arg_496_0 then
				arg_493_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_496_4 = 0
			local var_496_5 = 0.6

			if 0 < arg_493_1.time_ and arg_493_1.time_ <= var_496_4 + arg_496_0 then
				arg_493_1.talkMaxDuration = 0
				arg_493_1.dialogCg_.alpha = 1

				arg_493_1.dialog_:SetActive(true)
				SetActive(arg_493_1.leftNameGo_, true)

				arg_493_1.leftNameTxt_.text = arg_493_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_493_1.leftNameTxt_.transform)

				arg_493_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_493_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_493_1:RecordName(arg_493_1.leftNameTxt_.text)
				SetActive(arg_493_1.iconTrs_.gameObject, false)
				arg_493_1.callingController_:SetSelectedState("normal")

				local var_496_6 = arg_493_1:GetWordFromCfg(1109704120)
				local var_496_7 = arg_493_1:FormatText(var_496_6.content)

				arg_493_1.text_.text = var_496_7

				LuaForUtil.ClearLinePrefixSymbol(arg_493_1.text_)

				local var_496_9 = 24 <= 0 and var_496_5 or var_496_5 * (utf8.len(var_496_7) / 24)

				if (24 <= 0 and var_496_5 or var_496_5 * (utf8.len(var_496_7) / 24)) > 0 and var_496_5 < var_496_9 then
					arg_493_1.talkMaxDuration = var_496_9

					if var_496_9 + var_496_4 > arg_493_1.duration_ then
						arg_493_1.duration_ = var_496_9 + var_496_4
					end
				end

				arg_493_1.text_.text = var_496_7
				arg_493_1.typewritter.percent = 0

				arg_493_1.typewritter:SetDirty()
				arg_493_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704120", "story_v_side_new_1109704.awb") ~= 0 then
					local var_496_10 = manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704120", "story_v_side_new_1109704.awb") / 1000

					if var_496_10 + var_496_4 > arg_493_1.duration_ then
						arg_493_1.duration_ = var_496_10 + var_496_4
					end

					if var_496_6.prefab_name ~= "" and arg_493_1.actors_[var_496_6.prefab_name] ~= nil then
						local var_496_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_493_1.actors_[var_496_6.prefab_name].transform, "story_v_side_new_1109704", "1109704120", "story_v_side_new_1109704.awb")

						arg_493_1:RecordAudio("1109704120", var_496_11)
						arg_493_1:RecordAudio("1109704120", var_496_11)
					else
						arg_493_1:AudioAction("play", "voice", "story_v_side_new_1109704", "1109704120", "story_v_side_new_1109704.awb")
					end

					arg_493_1:RecordHistoryTalkVoice("story_v_side_new_1109704", "1109704120", "story_v_side_new_1109704.awb")
				end

				arg_493_1:RecordContent(arg_493_1.text_.text)
			end

			local var_496_12 = math.max(var_496_5, arg_493_1.talkMaxDuration)

			if var_496_4 <= arg_493_1.time_ and arg_493_1.time_ < var_496_4 + var_496_12 then
				arg_493_1.typewritter.percent = (arg_493_1.time_ - var_496_4) / var_496_12

				arg_493_1.typewritter:SetDirty()
			end

			if arg_493_1.time_ >= var_496_4 + var_496_12 and arg_493_1.time_ < var_496_4 + var_496_12 + arg_496_0 then
				arg_493_1.typewritter.percent = 1

				arg_493_1.typewritter:SetDirty()
				arg_493_1:ShowNextGo(true)
			end
		end

		arg_493_1.nodeConfigList_ = {
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

		arg_493_1:InitPlayNodeList()
	end,
	Play1109704121 = function(arg_497_0, arg_497_1)
		arg_497_1.time_ = 0
		arg_497_1.frameCnt_ = 0
		arg_497_1.state_ = "playing"
		arg_497_1.curTalkId_ = 1109704121
		arg_497_1.duration_ = 5

		SetActive(arg_497_1.tipsGo_, false)

		function arg_497_1.onSingleLineFinish_()
			arg_497_1.onSingleLineUpdate_ = nil
			arg_497_1.onSingleLineFinish_ = nil
			arg_497_1.state_ = "waiting"
		end

		function arg_497_1.playNext_(arg_499_0)
			if arg_499_0 == 1 then
				arg_497_0:Play1109704122(arg_497_1)
			end
		end

		function arg_497_1.onSingleLineUpdate_(arg_500_0)
			if 0 < arg_497_1.time_ and arg_497_1.time_ <= 0 + arg_500_0 and not isNil(arg_497_1.actors_["1097ui_story"]) and arg_497_1.var_.characterEffect1097ui_story == nil then
				arg_497_1.var_.characterEffect1097ui_story = arg_497_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_500_0 = 0.200000002980232

			if 0 <= arg_497_1.time_ and arg_497_1.time_ < 0 + var_500_0 and not isNil(arg_497_1.actors_["1097ui_story"]) then
				if arg_497_1.var_.characterEffect1097ui_story and not isNil(arg_497_1.actors_["1097ui_story"]) then
					arg_497_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_497_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_497_1.time_ - 0) / var_500_0)
				end
			end

			if arg_497_1.time_ >= 0 + var_500_0 and arg_497_1.time_ < 0 + var_500_0 + arg_500_0 and not isNil(arg_497_1.actors_["1097ui_story"]) and arg_497_1.var_.characterEffect1097ui_story then
				arg_497_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_497_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_500_1 = 0
			local var_500_2 = 0.25

			if 0 < arg_497_1.time_ and arg_497_1.time_ <= var_500_1 + arg_500_0 then
				arg_497_1.talkMaxDuration = 0
				arg_497_1.dialogCg_.alpha = 1

				arg_497_1.dialog_:SetActive(true)
				SetActive(arg_497_1.leftNameGo_, true)

				arg_497_1.leftNameTxt_.text = arg_497_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_497_1.leftNameTxt_.transform)

				arg_497_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_497_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_497_1:RecordName(arg_497_1.leftNameTxt_.text)
				SetActive(arg_497_1.iconTrs_.gameObject, true)
				arg_497_1.iconController_:SetSelectedState("hero")

				arg_497_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_497_1.callingController_:SetSelectedState("normal")

				arg_497_1.keyicon_.color = Color.New(1, 1, 1)
				arg_497_1.icon_.color = Color.New(1, 1, 1)

				local var_500_3 = arg_497_1:FormatText(arg_497_1:GetWordFromCfg(1109704121).content)

				arg_497_1.text_.text = var_500_3

				LuaForUtil.ClearLinePrefixSymbol(arg_497_1.text_)

				local var_500_5 = 10 <= 0 and var_500_2 or var_500_2 * (utf8.len(var_500_3) / 10)

				if (10 <= 0 and var_500_2 or var_500_2 * (utf8.len(var_500_3) / 10)) > 0 and var_500_2 < var_500_5 then
					arg_497_1.talkMaxDuration = var_500_5

					if var_500_5 + var_500_1 > arg_497_1.duration_ then
						arg_497_1.duration_ = var_500_5 + var_500_1
					end
				end

				arg_497_1.text_.text = var_500_3
				arg_497_1.typewritter.percent = 0

				arg_497_1.typewritter:SetDirty()
				arg_497_1:ShowNextGo(false)
				arg_497_1:RecordContent(arg_497_1.text_.text)
			end

			local var_500_6 = math.max(var_500_2, arg_497_1.talkMaxDuration)

			if var_500_1 <= arg_497_1.time_ and arg_497_1.time_ < var_500_1 + var_500_6 then
				arg_497_1.typewritter.percent = (arg_497_1.time_ - var_500_1) / var_500_6

				arg_497_1.typewritter:SetDirty()
			end

			if arg_497_1.time_ >= var_500_1 + var_500_6 and arg_497_1.time_ < var_500_1 + var_500_6 + arg_500_0 then
				arg_497_1.typewritter.percent = 1

				arg_497_1.typewritter:SetDirty()
				arg_497_1:ShowNextGo(true)
			end
		end

		arg_497_1.nodeConfigList_ = {}

		arg_497_1:InitPlayNodeList()
	end,
	Play1109704122 = function(arg_501_0, arg_501_1)
		arg_501_1.time_ = 0
		arg_501_1.frameCnt_ = 0
		arg_501_1.state_ = "playing"
		arg_501_1.curTalkId_ = 1109704122
		arg_501_1.duration_ = 2.83

		local var_501_0 = {
			zh = 2.333,
			ja = 2.833
		}
		local var_501_1 = manager.audio:GetLocalizationFlag()

		if var_501_0[var_501_1] ~= nil then
			arg_501_1.duration_ = var_501_0[var_501_1]
		end

		SetActive(arg_501_1.tipsGo_, false)

		function arg_501_1.onSingleLineFinish_()
			arg_501_1.onSingleLineUpdate_ = nil
			arg_501_1.onSingleLineFinish_ = nil
			arg_501_1.state_ = "waiting"
		end

		function arg_501_1.playNext_(arg_503_0)
			if arg_503_0 == 1 then
				arg_501_0:Play1109704123(arg_501_1)
			end
		end

		function arg_501_1.onSingleLineUpdate_(arg_504_0)
			local var_504_0 = 0.25

			if 0 < arg_501_1.time_ and arg_501_1.time_ <= 0 + arg_504_0 then
				arg_501_1.talkMaxDuration = 0
				arg_501_1.dialogCg_.alpha = 1

				arg_501_1.dialog_:SetActive(true)
				SetActive(arg_501_1.leftNameGo_, true)

				arg_501_1.leftNameTxt_.text = arg_501_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_501_1.leftNameTxt_.transform)

				arg_501_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_501_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_501_1:RecordName(arg_501_1.leftNameTxt_.text)
				SetActive(arg_501_1.iconTrs_.gameObject, true)
				arg_501_1.iconController_:SetSelectedState("hero")

				arg_501_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2070")

				arg_501_1.callingController_:SetSelectedState("normal")

				arg_501_1.keyicon_.color = Color.New(1, 1, 1)
				arg_501_1.icon_.color = Color.New(1, 1, 1)

				local var_504_1 = arg_501_1:GetWordFromCfg(1109704122)
				local var_504_2 = arg_501_1:FormatText(var_504_1.content)

				arg_501_1.text_.text = var_504_2

				LuaForUtil.ClearLinePrefixSymbol(arg_501_1.text_)

				local var_504_4 = 10 <= 0 and var_504_0 or var_504_0 * (utf8.len(var_504_2) / 10)

				if (10 <= 0 and var_504_0 or var_504_0 * (utf8.len(var_504_2) / 10)) > 0 and var_504_0 < var_504_4 then
					arg_501_1.talkMaxDuration = var_504_4

					if var_504_4 + 0 > arg_501_1.duration_ then
						arg_501_1.duration_ = var_504_4 + 0
					end
				end

				arg_501_1.text_.text = var_504_2
				arg_501_1.typewritter.percent = 0

				arg_501_1.typewritter:SetDirty()
				arg_501_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704122", "story_v_side_new_1109704.awb") ~= 0 then
					local var_504_5 = manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704122", "story_v_side_new_1109704.awb") / 1000

					if var_504_5 + 0 > arg_501_1.duration_ then
						arg_501_1.duration_ = var_504_5 + 0
					end

					if var_504_1.prefab_name ~= "" and arg_501_1.actors_[var_504_1.prefab_name] ~= nil then
						local var_504_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_501_1.actors_[var_504_1.prefab_name].transform, "story_v_side_new_1109704", "1109704122", "story_v_side_new_1109704.awb")

						arg_501_1:RecordAudio("1109704122", var_504_6)
						arg_501_1:RecordAudio("1109704122", var_504_6)
					else
						arg_501_1:AudioAction("play", "voice", "story_v_side_new_1109704", "1109704122", "story_v_side_new_1109704.awb")
					end

					arg_501_1:RecordHistoryTalkVoice("story_v_side_new_1109704", "1109704122", "story_v_side_new_1109704.awb")
				end

				arg_501_1:RecordContent(arg_501_1.text_.text)
			end

			local var_504_7 = math.max(var_504_0, arg_501_1.talkMaxDuration)

			if 0 <= arg_501_1.time_ and arg_501_1.time_ < 0 + var_504_7 then
				arg_501_1.typewritter.percent = (arg_501_1.time_ - 0) / var_504_7

				arg_501_1.typewritter:SetDirty()
			end

			if arg_501_1.time_ >= 0 + var_504_7 and arg_501_1.time_ < 0 + var_504_7 + arg_504_0 then
				arg_501_1.typewritter.percent = 1

				arg_501_1.typewritter:SetDirty()
				arg_501_1:ShowNextGo(true)
			end
		end

		arg_501_1.nodeConfigList_ = {}

		arg_501_1:InitPlayNodeList()
	end,
	Play1109704123 = function(arg_505_0, arg_505_1)
		arg_505_1.time_ = 0
		arg_505_1.frameCnt_ = 0
		arg_505_1.state_ = "playing"
		arg_505_1.curTalkId_ = 1109704123
		arg_505_1.duration_ = 5

		SetActive(arg_505_1.tipsGo_, false)

		function arg_505_1.onSingleLineFinish_()
			arg_505_1.onSingleLineUpdate_ = nil
			arg_505_1.onSingleLineFinish_ = nil
			arg_505_1.state_ = "waiting"
		end

		function arg_505_1.playNext_(arg_507_0)
			if arg_507_0 == 1 then
				arg_505_0:Play1109704124(arg_505_1)
			end
		end

		function arg_505_1.onSingleLineUpdate_(arg_508_0)
			local var_508_0 = 1.35

			if 0 < arg_505_1.time_ and arg_505_1.time_ <= 0 + arg_508_0 then
				arg_505_1.talkMaxDuration = 0
				arg_505_1.dialogCg_.alpha = 1

				arg_505_1.dialog_:SetActive(true)
				SetActive(arg_505_1.leftNameGo_, false)

				arg_505_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_505_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_505_1:RecordName(arg_505_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_505_1.iconTrs_.gameObject, false)
				arg_505_1.callingController_:SetSelectedState("normal")

				local var_508_1 = arg_505_1:FormatText(arg_505_1:GetWordFromCfg(1109704123).content)

				arg_505_1.text_.text = var_508_1

				LuaForUtil.ClearLinePrefixSymbol(arg_505_1.text_)

				local var_508_3 = 54 <= 0 and var_508_0 or var_508_0 * (utf8.len(var_508_1) / 54)

				if (54 <= 0 and var_508_0 or var_508_0 * (utf8.len(var_508_1) / 54)) > 0 and var_508_0 < var_508_3 then
					arg_505_1.talkMaxDuration = var_508_3

					if var_508_3 + 0 > arg_505_1.duration_ then
						arg_505_1.duration_ = var_508_3 + 0
					end
				end

				arg_505_1.text_.text = var_508_1
				arg_505_1.typewritter.percent = 0

				arg_505_1.typewritter:SetDirty()
				arg_505_1:ShowNextGo(false)
				arg_505_1:RecordContent(arg_505_1.text_.text)
			end

			local var_508_4 = math.max(var_508_0, arg_505_1.talkMaxDuration)

			if 0 <= arg_505_1.time_ and arg_505_1.time_ < 0 + var_508_4 then
				arg_505_1.typewritter.percent = (arg_505_1.time_ - 0) / var_508_4

				arg_505_1.typewritter:SetDirty()
			end

			if arg_505_1.time_ >= 0 + var_508_4 and arg_505_1.time_ < 0 + var_508_4 + arg_508_0 then
				arg_505_1.typewritter.percent = 1

				arg_505_1.typewritter:SetDirty()
				arg_505_1:ShowNextGo(true)
			end
		end

		arg_505_1.nodeConfigList_ = {}

		arg_505_1:InitPlayNodeList()
	end,
	Play1109704124 = function(arg_509_0, arg_509_1)
		arg_509_1.time_ = 0
		arg_509_1.frameCnt_ = 0
		arg_509_1.state_ = "playing"
		arg_509_1.curTalkId_ = 1109704124
		arg_509_1.duration_ = 2.67

		local var_509_0 = {
			zh = 2.633,
			ja = 2.666
		}
		local var_509_1 = manager.audio:GetLocalizationFlag()

		if var_509_0[var_509_1] ~= nil then
			arg_509_1.duration_ = var_509_0[var_509_1]
		end

		SetActive(arg_509_1.tipsGo_, false)

		function arg_509_1.onSingleLineFinish_()
			arg_509_1.onSingleLineUpdate_ = nil
			arg_509_1.onSingleLineFinish_ = nil
			arg_509_1.state_ = "waiting"
		end

		function arg_509_1.playNext_(arg_511_0)
			if arg_511_0 == 1 then
				arg_509_0:Play1109704125(arg_509_1)
			end
		end

		function arg_509_1.onSingleLineUpdate_(arg_512_0)
			if 0 < arg_509_1.time_ and arg_509_1.time_ <= 0 + arg_512_0 then
				arg_509_1.var_.moveOldPos1097ui_story = arg_509_1.actors_["1097ui_story"].transform.localPosition
			end

			local var_512_0 = 0.001

			if 0 <= arg_509_1.time_ and arg_509_1.time_ < 0 + var_512_0 then
				arg_509_1.actors_["1097ui_story"].transform.localPosition = Vector3.Lerp(arg_509_1.var_.moveOldPos1097ui_story, Vector3.New(0, -0.54, -6.3), (arg_509_1.time_ - 0) / var_512_0)
				arg_509_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_509_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_509_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_509_1.actors_["1097ui_story"].transform.position).z)
				arg_509_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_509_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_509_1.actors_["1097ui_story"].transform.localEulerAngles = arg_509_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			if arg_509_1.time_ >= 0 + var_512_0 and arg_509_1.time_ < 0 + var_512_0 + arg_512_0 then
				arg_509_1.actors_["1097ui_story"].transform.localPosition = Vector3.New(0, -0.54, -6.3)
				arg_509_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_509_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_509_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_509_1.actors_["1097ui_story"].transform.position).z)
				arg_509_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_509_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_509_1.actors_["1097ui_story"].transform.localEulerAngles = arg_509_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			local var_512_1 = arg_509_1.actors_["1097ui_story"]

			if 0 < arg_509_1.time_ and arg_509_1.time_ <= 0 + arg_512_0 and not isNil(var_512_1) and arg_509_1.var_.characterEffect1097ui_story == nil then
				arg_509_1.var_.characterEffect1097ui_story = var_512_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_512_2 = 0.200000002980232

			if 0 <= arg_509_1.time_ and arg_509_1.time_ < 0 + var_512_2 and not isNil(var_512_1) then
				if arg_509_1.var_.characterEffect1097ui_story and not isNil(var_512_1) then
					arg_509_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_509_1.time_ >= 0 + var_512_2 and arg_509_1.time_ < 0 + var_512_2 + arg_512_0 and not isNil(var_512_1) and arg_509_1.var_.characterEffect1097ui_story then
				arg_509_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_509_1.time_ and arg_509_1.time_ <= 0 + arg_512_0 then
				arg_509_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			if 0 < arg_509_1.time_ and arg_509_1.time_ <= 0 + arg_512_0 then
				arg_509_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva")
			end

			local var_512_4 = 0
			local var_512_5 = 0.375

			if 0 < arg_509_1.time_ and arg_509_1.time_ <= var_512_4 + arg_512_0 then
				arg_509_1.talkMaxDuration = 0
				arg_509_1.dialogCg_.alpha = 1

				arg_509_1.dialog_:SetActive(true)
				SetActive(arg_509_1.leftNameGo_, true)

				arg_509_1.leftNameTxt_.text = arg_509_1:FormatText(StoryNameCfg[952].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_509_1.leftNameTxt_.transform)

				arg_509_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_509_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_509_1:RecordName(arg_509_1.leftNameTxt_.text)
				SetActive(arg_509_1.iconTrs_.gameObject, false)
				arg_509_1.callingController_:SetSelectedState("normal")

				local var_512_6 = arg_509_1:GetWordFromCfg(1109704124)
				local var_512_7 = arg_509_1:FormatText(var_512_6.content)

				arg_509_1.text_.text = var_512_7

				LuaForUtil.ClearLinePrefixSymbol(arg_509_1.text_)

				local var_512_9 = 15 <= 0 and var_512_5 or var_512_5 * (utf8.len(var_512_7) / 15)

				if (15 <= 0 and var_512_5 or var_512_5 * (utf8.len(var_512_7) / 15)) > 0 and var_512_5 < var_512_9 then
					arg_509_1.talkMaxDuration = var_512_9

					if var_512_9 + var_512_4 > arg_509_1.duration_ then
						arg_509_1.duration_ = var_512_9 + var_512_4
					end
				end

				arg_509_1.text_.text = var_512_7
				arg_509_1.typewritter.percent = 0

				arg_509_1.typewritter:SetDirty()
				arg_509_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704124", "story_v_side_new_1109704.awb") ~= 0 then
					local var_512_10 = manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704124", "story_v_side_new_1109704.awb") / 1000

					if var_512_10 + var_512_4 > arg_509_1.duration_ then
						arg_509_1.duration_ = var_512_10 + var_512_4
					end

					if var_512_6.prefab_name ~= "" and arg_509_1.actors_[var_512_6.prefab_name] ~= nil then
						local var_512_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_509_1.actors_[var_512_6.prefab_name].transform, "story_v_side_new_1109704", "1109704124", "story_v_side_new_1109704.awb")

						arg_509_1:RecordAudio("1109704124", var_512_11)
						arg_509_1:RecordAudio("1109704124", var_512_11)
					else
						arg_509_1:AudioAction("play", "voice", "story_v_side_new_1109704", "1109704124", "story_v_side_new_1109704.awb")
					end

					arg_509_1:RecordHistoryTalkVoice("story_v_side_new_1109704", "1109704124", "story_v_side_new_1109704.awb")
				end

				arg_509_1:RecordContent(arg_509_1.text_.text)
			end

			local var_512_12 = math.max(var_512_5, arg_509_1.talkMaxDuration)

			if var_512_4 <= arg_509_1.time_ and arg_509_1.time_ < var_512_4 + var_512_12 then
				arg_509_1.typewritter.percent = (arg_509_1.time_ - var_512_4) / var_512_12

				arg_509_1.typewritter:SetDirty()
			end

			if arg_509_1.time_ >= var_512_4 + var_512_12 and arg_509_1.time_ < var_512_4 + var_512_12 + arg_512_0 then
				arg_509_1.typewritter.percent = 1

				arg_509_1.typewritter:SetDirty()
				arg_509_1:ShowNextGo(true)
			end
		end

		arg_509_1.nodeConfigList_ = {
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

		arg_509_1:InitPlayNodeList()
	end,
	Play1109704125 = function(arg_513_0, arg_513_1)
		arg_513_1.time_ = 0
		arg_513_1.frameCnt_ = 0
		arg_513_1.state_ = "playing"
		arg_513_1.curTalkId_ = 1109704125
		arg_513_1.duration_ = 5

		SetActive(arg_513_1.tipsGo_, false)

		function arg_513_1.onSingleLineFinish_()
			arg_513_1.onSingleLineUpdate_ = nil
			arg_513_1.onSingleLineFinish_ = nil
			arg_513_1.state_ = "waiting"
		end

		function arg_513_1.playNext_(arg_515_0)
			if arg_515_0 == 1 then
				arg_513_0:Play1109704126(arg_513_1)
			end
		end

		function arg_513_1.onSingleLineUpdate_(arg_516_0)
			if 0 < arg_513_1.time_ and arg_513_1.time_ <= 0 + arg_516_0 and not isNil(arg_513_1.actors_["1097ui_story"]) and arg_513_1.var_.characterEffect1097ui_story == nil then
				arg_513_1.var_.characterEffect1097ui_story = arg_513_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_516_0 = 0.200000002980232

			if 0 <= arg_513_1.time_ and arg_513_1.time_ < 0 + var_516_0 and not isNil(arg_513_1.actors_["1097ui_story"]) then
				if arg_513_1.var_.characterEffect1097ui_story and not isNil(arg_513_1.actors_["1097ui_story"]) then
					arg_513_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_513_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_513_1.time_ - 0) / var_516_0)
				end
			end

			if arg_513_1.time_ >= 0 + var_516_0 and arg_513_1.time_ < 0 + var_516_0 + arg_516_0 and not isNil(arg_513_1.actors_["1097ui_story"]) and arg_513_1.var_.characterEffect1097ui_story then
				arg_513_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_513_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_516_1 = 0
			local var_516_2 = 0.95

			if 0 < arg_513_1.time_ and arg_513_1.time_ <= var_516_1 + arg_516_0 then
				arg_513_1.talkMaxDuration = 0
				arg_513_1.dialogCg_.alpha = 1

				arg_513_1.dialog_:SetActive(true)
				SetActive(arg_513_1.leftNameGo_, false)

				arg_513_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_513_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_513_1:RecordName(arg_513_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_513_1.iconTrs_.gameObject, false)
				arg_513_1.callingController_:SetSelectedState("normal")

				local var_516_3 = arg_513_1:FormatText(arg_513_1:GetWordFromCfg(1109704125).content)

				arg_513_1.text_.text = var_516_3

				LuaForUtil.ClearLinePrefixSymbol(arg_513_1.text_)

				local var_516_5 = 38 <= 0 and var_516_2 or var_516_2 * (utf8.len(var_516_3) / 38)

				if (38 <= 0 and var_516_2 or var_516_2 * (utf8.len(var_516_3) / 38)) > 0 and var_516_2 < var_516_5 then
					arg_513_1.talkMaxDuration = var_516_5

					if var_516_5 + var_516_1 > arg_513_1.duration_ then
						arg_513_1.duration_ = var_516_5 + var_516_1
					end
				end

				arg_513_1.text_.text = var_516_3
				arg_513_1.typewritter.percent = 0

				arg_513_1.typewritter:SetDirty()
				arg_513_1:ShowNextGo(false)
				arg_513_1:RecordContent(arg_513_1.text_.text)
			end

			local var_516_6 = math.max(var_516_2, arg_513_1.talkMaxDuration)

			if var_516_1 <= arg_513_1.time_ and arg_513_1.time_ < var_516_1 + var_516_6 then
				arg_513_1.typewritter.percent = (arg_513_1.time_ - var_516_1) / var_516_6

				arg_513_1.typewritter:SetDirty()
			end

			if arg_513_1.time_ >= var_516_1 + var_516_6 and arg_513_1.time_ < var_516_1 + var_516_6 + arg_516_0 then
				arg_513_1.typewritter.percent = 1

				arg_513_1.typewritter:SetDirty()
				arg_513_1:ShowNextGo(true)
			end
		end

		arg_513_1.nodeConfigList_ = {}

		arg_513_1:InitPlayNodeList()
	end,
	Play1109704126 = function(arg_517_0, arg_517_1)
		arg_517_1.time_ = 0
		arg_517_1.frameCnt_ = 0
		arg_517_1.state_ = "playing"
		arg_517_1.curTalkId_ = 1109704126
		arg_517_1.duration_ = 5

		SetActive(arg_517_1.tipsGo_, false)

		function arg_517_1.onSingleLineFinish_()
			arg_517_1.onSingleLineUpdate_ = nil
			arg_517_1.onSingleLineFinish_ = nil
			arg_517_1.state_ = "waiting"
		end

		function arg_517_1.playNext_(arg_519_0)
			if arg_519_0 == 1 then
				arg_517_0:Play1109704127(arg_517_1)
			end
		end

		function arg_517_1.onSingleLineUpdate_(arg_520_0)
			local var_520_0 = 0.725

			if 0 < arg_517_1.time_ and arg_517_1.time_ <= 0 + arg_520_0 then
				arg_517_1.talkMaxDuration = 0
				arg_517_1.dialogCg_.alpha = 1

				arg_517_1.dialog_:SetActive(true)
				SetActive(arg_517_1.leftNameGo_, true)

				arg_517_1.leftNameTxt_.text = arg_517_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_517_1.leftNameTxt_.transform)

				arg_517_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_517_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_517_1:RecordName(arg_517_1.leftNameTxt_.text)
				SetActive(arg_517_1.iconTrs_.gameObject, true)
				arg_517_1.iconController_:SetSelectedState("hero")

				arg_517_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_517_1.callingController_:SetSelectedState("normal")

				arg_517_1.keyicon_.color = Color.New(1, 1, 1)
				arg_517_1.icon_.color = Color.New(1, 1, 1)

				local var_520_1 = arg_517_1:FormatText(arg_517_1:GetWordFromCfg(1109704126).content)

				arg_517_1.text_.text = var_520_1

				LuaForUtil.ClearLinePrefixSymbol(arg_517_1.text_)

				local var_520_3 = 29 <= 0 and var_520_0 or var_520_0 * (utf8.len(var_520_1) / 29)

				if (29 <= 0 and var_520_0 or var_520_0 * (utf8.len(var_520_1) / 29)) > 0 and var_520_0 < var_520_3 then
					arg_517_1.talkMaxDuration = var_520_3

					if var_520_3 + 0 > arg_517_1.duration_ then
						arg_517_1.duration_ = var_520_3 + 0
					end
				end

				arg_517_1.text_.text = var_520_1
				arg_517_1.typewritter.percent = 0

				arg_517_1.typewritter:SetDirty()
				arg_517_1:ShowNextGo(false)
				arg_517_1:RecordContent(arg_517_1.text_.text)
			end

			local var_520_4 = math.max(var_520_0, arg_517_1.talkMaxDuration)

			if 0 <= arg_517_1.time_ and arg_517_1.time_ < 0 + var_520_4 then
				arg_517_1.typewritter.percent = (arg_517_1.time_ - 0) / var_520_4

				arg_517_1.typewritter:SetDirty()
			end

			if arg_517_1.time_ >= 0 + var_520_4 and arg_517_1.time_ < 0 + var_520_4 + arg_520_0 then
				arg_517_1.typewritter.percent = 1

				arg_517_1.typewritter:SetDirty()
				arg_517_1:ShowNextGo(true)
			end
		end

		arg_517_1.nodeConfigList_ = {}

		arg_517_1:InitPlayNodeList()
	end,
	Play1109704127 = function(arg_521_0, arg_521_1)
		arg_521_1.time_ = 0
		arg_521_1.frameCnt_ = 0
		arg_521_1.state_ = "playing"
		arg_521_1.curTalkId_ = 1109704127
		arg_521_1.duration_ = 7

		SetActive(arg_521_1.tipsGo_, false)

		function arg_521_1.onSingleLineFinish_()
			arg_521_1.onSingleLineUpdate_ = nil
			arg_521_1.onSingleLineFinish_ = nil
			arg_521_1.state_ = "waiting"
		end

		function arg_521_1.playNext_(arg_523_0)
			if arg_523_0 == 1 then
				arg_521_0:Play1109704128(arg_521_1)
			end
		end

		function arg_521_1.onSingleLineUpdate_(arg_524_0)
			if 0 < arg_521_1.time_ and arg_521_1.time_ <= 0 + arg_524_0 then
				local var_524_0 = arg_521_1.bgs_.ST60

				arg_521_1.bgs_.ST60.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_524_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_524_1 = var_524_0:GetComponent("SpriteRenderer")

				if var_524_1 and var_524_1.sprite then
					local var_524_2 = 2 * (var_524_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_524_0.transform.localScale = Vector3.New(var_524_2 / var_524_1.sprite.bounds.size.y < var_524_2 * manager.ui.mainCameraCom_.aspect / var_524_1.sprite.bounds.size.x and var_524_2 * manager.ui.mainCameraCom_.aspect / var_524_1.sprite.bounds.size.x or var_524_2 / var_524_1.sprite.bounds.size.y, var_524_2 / var_524_1.sprite.bounds.size.y < var_524_2 * manager.ui.mainCameraCom_.aspect / var_524_1.sprite.bounds.size.x and var_524_2 * manager.ui.mainCameraCom_.aspect / var_524_1.sprite.bounds.size.x or var_524_2 / var_524_1.sprite.bounds.size.y, 0)
				end

				for iter_524_0, iter_524_1 in pairs(arg_521_1.bgs_) do
					if iter_524_0 ~= "ST60" then
						iter_524_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_524_3 = 2

			if 2 < arg_521_1.time_ and arg_521_1.time_ <= var_524_3 + arg_524_0 then
				arg_521_1.allBtn_.enabled = false
			end

			if arg_521_1.time_ >= var_524_3 + 0.3 and arg_521_1.time_ < var_524_3 + 0.3 + arg_524_0 then
				arg_521_1.allBtn_.enabled = true
			end

			local var_524_4 = 0

			if 0 < arg_521_1.time_ and arg_521_1.time_ <= var_524_4 + arg_524_0 then
				arg_521_1.mask_.enabled = true
				arg_521_1.mask_.raycastTarget = true

				arg_521_1:SetGaussion(false)
			end

			local var_524_5 = 2

			if var_524_4 <= arg_521_1.time_ and arg_521_1.time_ < var_524_4 + var_524_5 then
				local var_524_6 = Color.New(1, 1, 1)

				var_524_6.a = Mathf.Lerp(1, 0, (arg_521_1.time_ - var_524_4) / var_524_5)
				arg_521_1.mask_.color = var_524_6
			end

			if arg_521_1.time_ >= var_524_4 + var_524_5 and arg_521_1.time_ < var_524_4 + var_524_5 + arg_524_0 then
				local var_524_7 = Color.New(1, 1, 1)

				arg_521_1.mask_.enabled = false
				var_524_7.a = 0
				arg_521_1.mask_.color = var_524_7
			end

			if 0 < arg_521_1.time_ and arg_521_1.time_ <= 0 + arg_524_0 then
				arg_521_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_524_10 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_521_1.bgmTxt_.text ~= var_524_10 and arg_521_1.bgmTxt_.text ~= "" then
						if arg_521_1.bgmTxt2_.text ~= "" then
							arg_521_1.bgmTxt_.text = arg_521_1.bgmTxt2_.text
						end

						arg_521_1.bgmTxt2_.text = var_524_10

						arg_521_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_521_1.bgmTxt_.text = var_524_10
						arg_521_1.bgmTxt2_.text = var_524_10
					end

					if arg_521_1.bgmTimer then
						arg_521_1.bgmTimer:Stop()

						arg_521_1.bgmTimer = nil
					end

					if arg_521_1.settingData.show_music_name == 1 then
						arg_521_1.musicController:SetSelectedState("show")
						arg_521_1.musicAnimator_:Play("open", 0, 0)

						if arg_521_1.settingData.music_time ~= 0 then
							arg_521_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_521_1.settingData.music_time), function()
								if arg_521_1 == nil or isNil(arg_521_1.bgmTxt_) then
									return
								end

								arg_521_1.musicController:SetSelectedState("hide")
								arg_521_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_521_1.frameCnt_ <= 1 then
				arg_521_1.dialog_:SetActive(false)
			end

			local var_524_11 = 2
			local var_524_12 = 0.15

			if 2 < arg_521_1.time_ and arg_521_1.time_ <= var_524_11 + arg_524_0 then
				arg_521_1.talkMaxDuration = 0

				arg_521_1.dialog_:SetActive(true)

				arg_521_1.dialogCg_.alpha = 0

				local var_524_13 = LeanTween.value(arg_521_1.dialog_, 0, 1, 0.3)

				var_524_13:setOnUpdate(LuaHelper.FloatAction(function(arg_526_0)
					arg_521_1.dialogCg_.alpha = arg_526_0
				end))
				var_524_13:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_521_1.dialog_)
					var_524_13:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_521_1.duration_ = arg_521_1.duration_ + 0.3

				SetActive(arg_521_1.leftNameGo_, false)

				arg_521_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_521_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_521_1:RecordName(arg_521_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_521_1.iconTrs_.gameObject, false)
				arg_521_1.callingController_:SetSelectedState("normal")

				local var_524_14 = arg_521_1:FormatText(arg_521_1:GetWordFromCfg(1109704127).content)

				arg_521_1.text_.text = var_524_14

				LuaForUtil.ClearLinePrefixSymbol(arg_521_1.text_)

				local var_524_16 = 6 <= 0 and var_524_12 or var_524_12 * (utf8.len(var_524_14) / 6)

				if (6 <= 0 and var_524_12 or var_524_12 * (utf8.len(var_524_14) / 6)) > 0 and var_524_12 < var_524_16 then
					arg_521_1.talkMaxDuration = var_524_16
					var_524_11 = var_524_11 + 0.3

					if var_524_16 + var_524_11 > arg_521_1.duration_ then
						arg_521_1.duration_ = var_524_16 + var_524_11
					end
				end

				arg_521_1.text_.text = var_524_14
				arg_521_1.typewritter.percent = 0

				arg_521_1.typewritter:SetDirty()
				arg_521_1:ShowNextGo(false)
				arg_521_1:RecordContent(arg_521_1.text_.text)
			end

			local var_524_17 = var_524_11 + 0.3
			local var_524_18 = math.max(var_524_12, arg_521_1.talkMaxDuration)

			if var_524_11 + 0.3 <= arg_521_1.time_ and arg_521_1.time_ < var_524_17 + var_524_18 then
				arg_521_1.typewritter.percent = (arg_521_1.time_ - var_524_17) / var_524_18

				arg_521_1.typewritter:SetDirty()
			end

			if arg_521_1.time_ >= var_524_17 + var_524_18 and arg_521_1.time_ < var_524_17 + var_524_18 + arg_524_0 then
				arg_521_1.typewritter.percent = 1

				arg_521_1.typewritter:SetDirty()
				arg_521_1:ShowNextGo(true)
			end
		end

		arg_521_1.nodeConfigList_ = {}

		arg_521_1:InitPlayNodeList()
	end,
	Play1109704128 = function(arg_528_0, arg_528_1)
		arg_528_1.time_ = 0
		arg_528_1.frameCnt_ = 0
		arg_528_1.state_ = "playing"
		arg_528_1.curTalkId_ = 1109704128
		arg_528_1.duration_ = 5

		SetActive(arg_528_1.tipsGo_, false)

		function arg_528_1.onSingleLineFinish_()
			arg_528_1.onSingleLineUpdate_ = nil
			arg_528_1.onSingleLineFinish_ = nil
			arg_528_1.state_ = "waiting"
		end

		function arg_528_1.playNext_(arg_530_0)
			if arg_530_0 == 1 then
				arg_528_0:Play1109704129(arg_528_1)
			end
		end

		function arg_528_1.onSingleLineUpdate_(arg_531_0)
			local var_531_0 = 1.225

			if 0 < arg_528_1.time_ and arg_528_1.time_ <= 0 + arg_531_0 then
				arg_528_1.talkMaxDuration = 0
				arg_528_1.dialogCg_.alpha = 1

				arg_528_1.dialog_:SetActive(true)
				SetActive(arg_528_1.leftNameGo_, false)

				arg_528_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_528_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_528_1:RecordName(arg_528_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_528_1.iconTrs_.gameObject, false)
				arg_528_1.callingController_:SetSelectedState("normal")

				local var_531_1 = arg_528_1:FormatText(arg_528_1:GetWordFromCfg(1109704128).content)

				arg_528_1.text_.text = var_531_1

				LuaForUtil.ClearLinePrefixSymbol(arg_528_1.text_)

				local var_531_3 = 49 <= 0 and var_531_0 or var_531_0 * (utf8.len(var_531_1) / 49)

				if (49 <= 0 and var_531_0 or var_531_0 * (utf8.len(var_531_1) / 49)) > 0 and var_531_0 < var_531_3 then
					arg_528_1.talkMaxDuration = var_531_3

					if var_531_3 + 0 > arg_528_1.duration_ then
						arg_528_1.duration_ = var_531_3 + 0
					end
				end

				arg_528_1.text_.text = var_531_1
				arg_528_1.typewritter.percent = 0

				arg_528_1.typewritter:SetDirty()
				arg_528_1:ShowNextGo(false)
				arg_528_1:RecordContent(arg_528_1.text_.text)
			end

			local var_531_4 = math.max(var_531_0, arg_528_1.talkMaxDuration)

			if 0 <= arg_528_1.time_ and arg_528_1.time_ < 0 + var_531_4 then
				arg_528_1.typewritter.percent = (arg_528_1.time_ - 0) / var_531_4

				arg_528_1.typewritter:SetDirty()
			end

			if arg_528_1.time_ >= 0 + var_531_4 and arg_528_1.time_ < 0 + var_531_4 + arg_531_0 then
				arg_528_1.typewritter.percent = 1

				arg_528_1.typewritter:SetDirty()
				arg_528_1:ShowNextGo(true)
			end
		end

		arg_528_1.nodeConfigList_ = {}

		arg_528_1:InitPlayNodeList()
	end,
	Play1109704129 = function(arg_532_0, arg_532_1)
		arg_532_1.time_ = 0
		arg_532_1.frameCnt_ = 0
		arg_532_1.state_ = "playing"
		arg_532_1.curTalkId_ = 1109704129
		arg_532_1.duration_ = 5

		SetActive(arg_532_1.tipsGo_, false)

		function arg_532_1.onSingleLineFinish_()
			arg_532_1.onSingleLineUpdate_ = nil
			arg_532_1.onSingleLineFinish_ = nil
			arg_532_1.state_ = "waiting"
		end

		function arg_532_1.playNext_(arg_534_0)
			if arg_534_0 == 1 then
				arg_532_0:Play1109704130(arg_532_1)
			end
		end

		function arg_532_1.onSingleLineUpdate_(arg_535_0)
			local var_535_0 = 0.05

			if 0 < arg_532_1.time_ and arg_532_1.time_ <= 0 + arg_535_0 then
				arg_532_1.talkMaxDuration = 0
				arg_532_1.dialogCg_.alpha = 1

				arg_532_1.dialog_:SetActive(true)
				SetActive(arg_532_1.leftNameGo_, true)

				arg_532_1.leftNameTxt_.text = arg_532_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_532_1.leftNameTxt_.transform)

				arg_532_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_532_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_532_1:RecordName(arg_532_1.leftNameTxt_.text)
				SetActive(arg_532_1.iconTrs_.gameObject, true)
				arg_532_1.iconController_:SetSelectedState("hero")

				arg_532_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_532_1.callingController_:SetSelectedState("normal")

				arg_532_1.keyicon_.color = Color.New(1, 1, 1)
				arg_532_1.icon_.color = Color.New(1, 1, 1)

				local var_535_1 = arg_532_1:FormatText(arg_532_1:GetWordFromCfg(1109704129).content)

				arg_532_1.text_.text = var_535_1

				LuaForUtil.ClearLinePrefixSymbol(arg_532_1.text_)

				local var_535_3 = 2 <= 0 and var_535_0 or var_535_0 * (utf8.len(var_535_1) / 2)

				if (2 <= 0 and var_535_0 or var_535_0 * (utf8.len(var_535_1) / 2)) > 0 and var_535_0 < var_535_3 then
					arg_532_1.talkMaxDuration = var_535_3

					if var_535_3 + 0 > arg_532_1.duration_ then
						arg_532_1.duration_ = var_535_3 + 0
					end
				end

				arg_532_1.text_.text = var_535_1
				arg_532_1.typewritter.percent = 0

				arg_532_1.typewritter:SetDirty()
				arg_532_1:ShowNextGo(false)
				arg_532_1:RecordContent(arg_532_1.text_.text)
			end

			local var_535_4 = math.max(var_535_0, arg_532_1.talkMaxDuration)

			if 0 <= arg_532_1.time_ and arg_532_1.time_ < 0 + var_535_4 then
				arg_532_1.typewritter.percent = (arg_532_1.time_ - 0) / var_535_4

				arg_532_1.typewritter:SetDirty()
			end

			if arg_532_1.time_ >= 0 + var_535_4 and arg_532_1.time_ < 0 + var_535_4 + arg_535_0 then
				arg_532_1.typewritter.percent = 1

				arg_532_1.typewritter:SetDirty()
				arg_532_1:ShowNextGo(true)
			end
		end

		arg_532_1.nodeConfigList_ = {}

		arg_532_1:InitPlayNodeList()
	end,
	Play1109704130 = function(arg_536_0, arg_536_1)
		arg_536_1.time_ = 0
		arg_536_1.frameCnt_ = 0
		arg_536_1.state_ = "playing"
		arg_536_1.curTalkId_ = 1109704130
		arg_536_1.duration_ = 1.7

		local var_536_0 = {
			zh = 1.7,
			ja = 1.466
		}
		local var_536_1 = manager.audio:GetLocalizationFlag()

		if var_536_0[var_536_1] ~= nil then
			arg_536_1.duration_ = var_536_0[var_536_1]
		end

		SetActive(arg_536_1.tipsGo_, false)

		function arg_536_1.onSingleLineFinish_()
			arg_536_1.onSingleLineUpdate_ = nil
			arg_536_1.onSingleLineFinish_ = nil
			arg_536_1.state_ = "waiting"
		end

		function arg_536_1.playNext_(arg_538_0)
			if arg_538_0 == 1 then
				arg_536_0:Play1109704131(arg_536_1)
			end
		end

		function arg_536_1.onSingleLineUpdate_(arg_539_0)
			if 0 < arg_536_1.time_ and arg_536_1.time_ <= 0 + arg_539_0 then
				arg_536_1.var_.moveOldPos1097ui_story = arg_536_1.actors_["1097ui_story"].transform.localPosition
			end

			local var_539_0 = 0.001

			if 0 <= arg_536_1.time_ and arg_536_1.time_ < 0 + var_539_0 then
				arg_536_1.actors_["1097ui_story"].transform.localPosition = Vector3.Lerp(arg_536_1.var_.moveOldPos1097ui_story, Vector3.New(0, -0.54, -6.3), (arg_536_1.time_ - 0) / var_539_0)
				arg_536_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_536_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_536_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_536_1.actors_["1097ui_story"].transform.position).z)
				arg_536_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_536_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_536_1.actors_["1097ui_story"].transform.localEulerAngles = arg_536_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			if arg_536_1.time_ >= 0 + var_539_0 and arg_536_1.time_ < 0 + var_539_0 + arg_539_0 then
				arg_536_1.actors_["1097ui_story"].transform.localPosition = Vector3.New(0, -0.54, -6.3)
				arg_536_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_536_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_536_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_536_1.actors_["1097ui_story"].transform.position).z)
				arg_536_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_536_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_536_1.actors_["1097ui_story"].transform.localEulerAngles = arg_536_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			local var_539_1 = arg_536_1.actors_["1097ui_story"]

			if 0 < arg_536_1.time_ and arg_536_1.time_ <= 0 + arg_539_0 and not isNil(var_539_1) and arg_536_1.var_.characterEffect1097ui_story == nil then
				arg_536_1.var_.characterEffect1097ui_story = var_539_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_539_2 = 0.200000002980232

			if 0 <= arg_536_1.time_ and arg_536_1.time_ < 0 + var_539_2 and not isNil(var_539_1) then
				if arg_536_1.var_.characterEffect1097ui_story and not isNil(var_539_1) then
					arg_536_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_536_1.time_ >= 0 + var_539_2 and arg_536_1.time_ < 0 + var_539_2 + arg_539_0 and not isNil(var_539_1) and arg_536_1.var_.characterEffect1097ui_story then
				arg_536_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_536_1.time_ and arg_536_1.time_ <= 0 + arg_539_0 then
				arg_536_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			if 0 < arg_536_1.time_ and arg_536_1.time_ <= 0 + arg_539_0 then
				arg_536_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_539_4 = 0
			local var_539_5 = 0.35

			if 0 < arg_536_1.time_ and arg_536_1.time_ <= var_539_4 + arg_539_0 then
				arg_536_1.talkMaxDuration = 0
				arg_536_1.dialogCg_.alpha = 1

				arg_536_1.dialog_:SetActive(true)
				SetActive(arg_536_1.leftNameGo_, true)

				arg_536_1.leftNameTxt_.text = arg_536_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_536_1.leftNameTxt_.transform)

				arg_536_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_536_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_536_1:RecordName(arg_536_1.leftNameTxt_.text)
				SetActive(arg_536_1.iconTrs_.gameObject, false)
				arg_536_1.callingController_:SetSelectedState("normal")

				local var_539_6 = arg_536_1:GetWordFromCfg(1109704130)
				local var_539_7 = arg_536_1:FormatText(var_539_6.content)

				arg_536_1.text_.text = var_539_7

				LuaForUtil.ClearLinePrefixSymbol(arg_536_1.text_)

				local var_539_9 = 14 <= 0 and var_539_5 or var_539_5 * (utf8.len(var_539_7) / 14)

				if (14 <= 0 and var_539_5 or var_539_5 * (utf8.len(var_539_7) / 14)) > 0 and var_539_5 < var_539_9 then
					arg_536_1.talkMaxDuration = var_539_9

					if var_539_9 + var_539_4 > arg_536_1.duration_ then
						arg_536_1.duration_ = var_539_9 + var_539_4
					end
				end

				arg_536_1.text_.text = var_539_7
				arg_536_1.typewritter.percent = 0

				arg_536_1.typewritter:SetDirty()
				arg_536_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704130", "story_v_side_new_1109704.awb") ~= 0 then
					local var_539_10 = manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704130", "story_v_side_new_1109704.awb") / 1000

					if var_539_10 + var_539_4 > arg_536_1.duration_ then
						arg_536_1.duration_ = var_539_10 + var_539_4
					end

					if var_539_6.prefab_name ~= "" and arg_536_1.actors_[var_539_6.prefab_name] ~= nil then
						local var_539_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_536_1.actors_[var_539_6.prefab_name].transform, "story_v_side_new_1109704", "1109704130", "story_v_side_new_1109704.awb")

						arg_536_1:RecordAudio("1109704130", var_539_11)
						arg_536_1:RecordAudio("1109704130", var_539_11)
					else
						arg_536_1:AudioAction("play", "voice", "story_v_side_new_1109704", "1109704130", "story_v_side_new_1109704.awb")
					end

					arg_536_1:RecordHistoryTalkVoice("story_v_side_new_1109704", "1109704130", "story_v_side_new_1109704.awb")
				end

				arg_536_1:RecordContent(arg_536_1.text_.text)
			end

			local var_539_12 = math.max(var_539_5, arg_536_1.talkMaxDuration)

			if var_539_4 <= arg_536_1.time_ and arg_536_1.time_ < var_539_4 + var_539_12 then
				arg_536_1.typewritter.percent = (arg_536_1.time_ - var_539_4) / var_539_12

				arg_536_1.typewritter:SetDirty()
			end

			if arg_536_1.time_ >= var_539_4 + var_539_12 and arg_536_1.time_ < var_539_4 + var_539_12 + arg_539_0 then
				arg_536_1.typewritter.percent = 1

				arg_536_1.typewritter:SetDirty()
				arg_536_1:ShowNextGo(true)
			end
		end

		arg_536_1.nodeConfigList_ = {
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

		arg_536_1:InitPlayNodeList()
	end,
	Play1109704131 = function(arg_540_0, arg_540_1)
		arg_540_1.time_ = 0
		arg_540_1.frameCnt_ = 0
		arg_540_1.state_ = "playing"
		arg_540_1.curTalkId_ = 1109704131
		arg_540_1.duration_ = 5

		SetActive(arg_540_1.tipsGo_, false)

		function arg_540_1.onSingleLineFinish_()
			arg_540_1.onSingleLineUpdate_ = nil
			arg_540_1.onSingleLineFinish_ = nil
			arg_540_1.state_ = "waiting"
		end

		function arg_540_1.playNext_(arg_542_0)
			if arg_542_0 == 1 then
				arg_540_0:Play1109704132(arg_540_1)
			end
		end

		function arg_540_1.onSingleLineUpdate_(arg_543_0)
			if 0 < arg_540_1.time_ and arg_540_1.time_ <= 0 + arg_543_0 and not isNil(arg_540_1.actors_["1097ui_story"]) and arg_540_1.var_.characterEffect1097ui_story == nil then
				arg_540_1.var_.characterEffect1097ui_story = arg_540_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_543_0 = 0.200000002980232

			if 0 <= arg_540_1.time_ and arg_540_1.time_ < 0 + var_543_0 and not isNil(arg_540_1.actors_["1097ui_story"]) then
				if arg_540_1.var_.characterEffect1097ui_story and not isNil(arg_540_1.actors_["1097ui_story"]) then
					arg_540_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_540_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_540_1.time_ - 0) / var_543_0)
				end
			end

			if arg_540_1.time_ >= 0 + var_543_0 and arg_540_1.time_ < 0 + var_543_0 + arg_543_0 and not isNil(arg_540_1.actors_["1097ui_story"]) and arg_540_1.var_.characterEffect1097ui_story then
				arg_540_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_540_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_543_1 = 0
			local var_543_2 = 0.6

			if 0 < arg_540_1.time_ and arg_540_1.time_ <= var_543_1 + arg_543_0 then
				arg_540_1.talkMaxDuration = 0
				arg_540_1.dialogCg_.alpha = 1

				arg_540_1.dialog_:SetActive(true)
				SetActive(arg_540_1.leftNameGo_, true)

				arg_540_1.leftNameTxt_.text = arg_540_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_540_1.leftNameTxt_.transform)

				arg_540_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_540_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_540_1:RecordName(arg_540_1.leftNameTxt_.text)
				SetActive(arg_540_1.iconTrs_.gameObject, true)
				arg_540_1.iconController_:SetSelectedState("hero")

				arg_540_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_540_1.callingController_:SetSelectedState("normal")

				arg_540_1.keyicon_.color = Color.New(1, 1, 1)
				arg_540_1.icon_.color = Color.New(1, 1, 1)

				local var_543_3 = arg_540_1:FormatText(arg_540_1:GetWordFromCfg(1109704131).content)

				arg_540_1.text_.text = var_543_3

				LuaForUtil.ClearLinePrefixSymbol(arg_540_1.text_)

				local var_543_5 = 24 <= 0 and var_543_2 or var_543_2 * (utf8.len(var_543_3) / 24)

				if (24 <= 0 and var_543_2 or var_543_2 * (utf8.len(var_543_3) / 24)) > 0 and var_543_2 < var_543_5 then
					arg_540_1.talkMaxDuration = var_543_5

					if var_543_5 + var_543_1 > arg_540_1.duration_ then
						arg_540_1.duration_ = var_543_5 + var_543_1
					end
				end

				arg_540_1.text_.text = var_543_3
				arg_540_1.typewritter.percent = 0

				arg_540_1.typewritter:SetDirty()
				arg_540_1:ShowNextGo(false)
				arg_540_1:RecordContent(arg_540_1.text_.text)
			end

			local var_543_6 = math.max(var_543_2, arg_540_1.talkMaxDuration)

			if var_543_1 <= arg_540_1.time_ and arg_540_1.time_ < var_543_1 + var_543_6 then
				arg_540_1.typewritter.percent = (arg_540_1.time_ - var_543_1) / var_543_6

				arg_540_1.typewritter:SetDirty()
			end

			if arg_540_1.time_ >= var_543_1 + var_543_6 and arg_540_1.time_ < var_543_1 + var_543_6 + arg_543_0 then
				arg_540_1.typewritter.percent = 1

				arg_540_1.typewritter:SetDirty()
				arg_540_1:ShowNextGo(true)
			end
		end

		arg_540_1.nodeConfigList_ = {}

		arg_540_1:InitPlayNodeList()
	end,
	Play1109704132 = function(arg_544_0, arg_544_1)
		arg_544_1.time_ = 0
		arg_544_1.frameCnt_ = 0
		arg_544_1.state_ = "playing"
		arg_544_1.curTalkId_ = 1109704132
		arg_544_1.duration_ = 7

		SetActive(arg_544_1.tipsGo_, false)

		function arg_544_1.onSingleLineFinish_()
			arg_544_1.onSingleLineUpdate_ = nil
			arg_544_1.onSingleLineFinish_ = nil
			arg_544_1.state_ = "waiting"
		end

		function arg_544_1.playNext_(arg_546_0)
			if arg_546_0 == 1 then
				arg_544_0:Play1109704133(arg_544_1)
			end
		end

		function arg_544_1.onSingleLineUpdate_(arg_547_0)
			if 0 < arg_544_1.time_ and arg_544_1.time_ <= 0 + arg_547_0 then
				local var_547_0 = arg_544_1.bgs_.STwhite

				arg_544_1.bgs_.STwhite.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_547_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_547_1 = var_547_0:GetComponent("SpriteRenderer")

				if var_547_1 and var_547_1.sprite then
					local var_547_2 = 2 * (var_547_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_547_0.transform.localScale = Vector3.New(var_547_2 / var_547_1.sprite.bounds.size.y < var_547_2 * manager.ui.mainCameraCom_.aspect / var_547_1.sprite.bounds.size.x and var_547_2 * manager.ui.mainCameraCom_.aspect / var_547_1.sprite.bounds.size.x or var_547_2 / var_547_1.sprite.bounds.size.y, var_547_2 / var_547_1.sprite.bounds.size.y < var_547_2 * manager.ui.mainCameraCom_.aspect / var_547_1.sprite.bounds.size.x and var_547_2 * manager.ui.mainCameraCom_.aspect / var_547_1.sprite.bounds.size.x or var_547_2 / var_547_1.sprite.bounds.size.y, 0)
				end

				for iter_547_0, iter_547_1 in pairs(arg_544_1.bgs_) do
					if iter_547_0 ~= "STwhite" then
						iter_547_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_547_3 = 2

			if 2 < arg_544_1.time_ and arg_544_1.time_ <= var_547_3 + arg_547_0 then
				arg_544_1.allBtn_.enabled = false
			end

			if arg_544_1.time_ >= var_547_3 + 0.3 and arg_544_1.time_ < var_547_3 + 0.3 + arg_547_0 then
				arg_544_1.allBtn_.enabled = true
			end

			local var_547_4 = 0

			if 0 < arg_544_1.time_ and arg_544_1.time_ <= var_547_4 + arg_547_0 then
				arg_544_1.mask_.enabled = true
				arg_544_1.mask_.raycastTarget = true

				arg_544_1:SetGaussion(false)
			end

			local var_547_5 = 2

			if var_547_4 <= arg_544_1.time_ and arg_544_1.time_ < var_547_4 + var_547_5 then
				local var_547_6 = Color.New(1, 1, 1)

				var_547_6.a = Mathf.Lerp(1, 0, (arg_544_1.time_ - var_547_4) / var_547_5)
				arg_544_1.mask_.color = var_547_6
			end

			if arg_544_1.time_ >= var_547_4 + var_547_5 and arg_544_1.time_ < var_547_4 + var_547_5 + arg_547_0 then
				local var_547_7 = Color.New(1, 1, 1)

				arg_544_1.mask_.enabled = false
				var_547_7.a = 0
				arg_544_1.mask_.color = var_547_7
			end

			local var_547_8 = arg_544_1.actors_["1097ui_story"].transform

			if 0 < arg_544_1.time_ and arg_544_1.time_ <= 0 + arg_547_0 then
				arg_544_1.var_.moveOldPos1097ui_story = var_547_8.localPosition
			end

			local var_547_9 = 0.001

			if 0 <= arg_544_1.time_ and arg_544_1.time_ < 0 + var_547_9 then
				var_547_8.localPosition = Vector3.Lerp(arg_544_1.var_.moveOldPos1097ui_story, Vector3.New(0, 100, 0), (arg_544_1.time_ - 0) / var_547_9)
				var_547_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_547_8.position).x, (manager.ui.mainCamera.transform.position - var_547_8.position).y, (manager.ui.mainCamera.transform.position - var_547_8.position).z)
				var_547_8.localEulerAngles.z = 0
				var_547_8.localEulerAngles.x = 0
				var_547_8.localEulerAngles = var_547_8.localEulerAngles
			end

			if arg_544_1.time_ >= 0 + var_547_9 and arg_544_1.time_ < 0 + var_547_9 + arg_547_0 then
				var_547_8.localPosition = Vector3.New(0, 100, 0)
				var_547_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_547_8.position).x, (manager.ui.mainCamera.transform.position - var_547_8.position).y, (manager.ui.mainCamera.transform.position - var_547_8.position).z)
				var_547_8.localEulerAngles.z = 0
				var_547_8.localEulerAngles.x = 0
				var_547_8.localEulerAngles = var_547_8.localEulerAngles
			end

			if 0 < arg_544_1.time_ and arg_544_1.time_ <= 0 + arg_547_0 then
				arg_544_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_547_12 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_544_1.bgmTxt_.text ~= var_547_12 and arg_544_1.bgmTxt_.text ~= "" then
						if arg_544_1.bgmTxt2_.text ~= "" then
							arg_544_1.bgmTxt_.text = arg_544_1.bgmTxt2_.text
						end

						arg_544_1.bgmTxt2_.text = var_547_12

						arg_544_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_544_1.bgmTxt_.text = var_547_12
						arg_544_1.bgmTxt2_.text = var_547_12
					end

					if arg_544_1.bgmTimer then
						arg_544_1.bgmTimer:Stop()

						arg_544_1.bgmTimer = nil
					end

					if arg_544_1.settingData.show_music_name == 1 then
						arg_544_1.musicController:SetSelectedState("show")
						arg_544_1.musicAnimator_:Play("open", 0, 0)

						if arg_544_1.settingData.music_time ~= 0 then
							arg_544_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_544_1.settingData.music_time), function()
								if arg_544_1 == nil or isNil(arg_544_1.bgmTxt_) then
									return
								end

								arg_544_1.musicController:SetSelectedState("hide")
								arg_544_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.3 < arg_544_1.time_ and arg_544_1.time_ <= 0.3 + arg_547_0 then
				arg_544_1:AudioAction("play", "music", "bgm_side_daily03", "bgm_side_daily03", "bgm_side_daily03.awb")

				local var_547_15 = manager.audio:GetAudioName("bgm_side_daily03", "bgm_side_daily03")

				if "" ~= "" then
					if arg_544_1.bgmTxt_.text ~= var_547_15 and arg_544_1.bgmTxt_.text ~= "" then
						if arg_544_1.bgmTxt2_.text ~= "" then
							arg_544_1.bgmTxt_.text = arg_544_1.bgmTxt2_.text
						end

						arg_544_1.bgmTxt2_.text = var_547_15

						arg_544_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_544_1.bgmTxt_.text = var_547_15
						arg_544_1.bgmTxt2_.text = var_547_15
					end

					if arg_544_1.bgmTimer then
						arg_544_1.bgmTimer:Stop()

						arg_544_1.bgmTimer = nil
					end

					if arg_544_1.settingData.show_music_name == 1 then
						arg_544_1.musicController:SetSelectedState("show")
						arg_544_1.musicAnimator_:Play("open", 0, 0)

						if arg_544_1.settingData.music_time ~= 0 then
							arg_544_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_544_1.settingData.music_time), function()
								if arg_544_1 == nil or isNil(arg_544_1.bgmTxt_) then
									return
								end

								arg_544_1.musicController:SetSelectedState("hide")
								arg_544_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_544_1.frameCnt_ <= 1 then
				arg_544_1.dialog_:SetActive(false)
			end

			local var_547_16 = 2
			local var_547_17 = 0.85

			if 2 < arg_544_1.time_ and arg_544_1.time_ <= var_547_16 + arg_547_0 then
				arg_544_1.talkMaxDuration = 0

				arg_544_1.dialog_:SetActive(true)

				arg_544_1.dialogCg_.alpha = 0

				local var_547_18 = LeanTween.value(arg_544_1.dialog_, 0, 1, 0.3)

				var_547_18:setOnUpdate(LuaHelper.FloatAction(function(arg_550_0)
					arg_544_1.dialogCg_.alpha = arg_550_0
				end))
				var_547_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_544_1.dialog_)
					var_547_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_544_1.duration_ = arg_544_1.duration_ + 0.3

				SetActive(arg_544_1.leftNameGo_, false)

				arg_544_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_544_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_544_1:RecordName(arg_544_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_544_1.iconTrs_.gameObject, false)
				arg_544_1.callingController_:SetSelectedState("normal")

				local var_547_19 = arg_544_1:FormatText(arg_544_1:GetWordFromCfg(1109704132).content)

				arg_544_1.text_.text = var_547_19

				LuaForUtil.ClearLinePrefixSymbol(arg_544_1.text_)

				local var_547_21 = 34 <= 0 and var_547_17 or var_547_17 * (utf8.len(var_547_19) / 34)

				if (34 <= 0 and var_547_17 or var_547_17 * (utf8.len(var_547_19) / 34)) > 0 and var_547_17 < var_547_21 then
					arg_544_1.talkMaxDuration = var_547_21
					var_547_16 = var_547_16 + 0.3

					if var_547_21 + var_547_16 > arg_544_1.duration_ then
						arg_544_1.duration_ = var_547_21 + var_547_16
					end
				end

				arg_544_1.text_.text = var_547_19
				arg_544_1.typewritter.percent = 0

				arg_544_1.typewritter:SetDirty()
				arg_544_1:ShowNextGo(false)
				arg_544_1:RecordContent(arg_544_1.text_.text)
			end

			local var_547_22 = var_547_16 + 0.3
			local var_547_23 = math.max(var_547_17, arg_544_1.talkMaxDuration)

			if var_547_16 + 0.3 <= arg_544_1.time_ and arg_544_1.time_ < var_547_22 + var_547_23 then
				arg_544_1.typewritter.percent = (arg_544_1.time_ - var_547_22) / var_547_23

				arg_544_1.typewritter:SetDirty()
			end

			if arg_544_1.time_ >= var_547_22 + var_547_23 and arg_544_1.time_ < var_547_22 + var_547_23 + arg_547_0 then
				arg_544_1.typewritter.percent = 1

				arg_544_1.typewritter:SetDirty()
				arg_544_1:ShowNextGo(true)
			end
		end

		arg_544_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_544_1:InitPlayNodeList()
	end,
	Play1109704133 = function(arg_552_0, arg_552_1)
		arg_552_1.time_ = 0
		arg_552_1.frameCnt_ = 0
		arg_552_1.state_ = "playing"
		arg_552_1.curTalkId_ = 1109704133
		arg_552_1.duration_ = 8.57

		local var_552_0 = {
			zh = 8.566,
			ja = 5.366
		}
		local var_552_1 = manager.audio:GetLocalizationFlag()

		if var_552_0[var_552_1] ~= nil then
			arg_552_1.duration_ = var_552_0[var_552_1]
		end

		SetActive(arg_552_1.tipsGo_, false)

		function arg_552_1.onSingleLineFinish_()
			arg_552_1.onSingleLineUpdate_ = nil
			arg_552_1.onSingleLineFinish_ = nil
			arg_552_1.state_ = "waiting"
		end

		function arg_552_1.playNext_(arg_554_0)
			if arg_554_0 == 1 then
				arg_552_0:Play1109704134(arg_552_1)
			end
		end

		function arg_552_1.onSingleLineUpdate_(arg_555_0)
			local var_555_0 = 1.15

			if 0 < arg_552_1.time_ and arg_552_1.time_ <= 0 + arg_555_0 then
				arg_552_1.talkMaxDuration = 0
				arg_552_1.dialogCg_.alpha = 1

				arg_552_1.dialog_:SetActive(true)
				SetActive(arg_552_1.leftNameGo_, true)

				arg_552_1.leftNameTxt_.text = arg_552_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_552_1.leftNameTxt_.transform)

				arg_552_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_552_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_552_1:RecordName(arg_552_1.leftNameTxt_.text)
				SetActive(arg_552_1.iconTrs_.gameObject, true)
				arg_552_1.iconController_:SetSelectedState("hero")

				arg_552_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1097")

				arg_552_1.callingController_:SetSelectedState("normal")

				arg_552_1.keyicon_.color = Color.New(1, 1, 1)
				arg_552_1.icon_.color = Color.New(1, 1, 1)

				local var_555_1 = arg_552_1:GetWordFromCfg(1109704133)
				local var_555_2 = arg_552_1:FormatText(var_555_1.content)

				arg_552_1.text_.text = var_555_2

				LuaForUtil.ClearLinePrefixSymbol(arg_552_1.text_)

				local var_555_4 = 46 <= 0 and var_555_0 or var_555_0 * (utf8.len(var_555_2) / 46)

				if (46 <= 0 and var_555_0 or var_555_0 * (utf8.len(var_555_2) / 46)) > 0 and var_555_0 < var_555_4 then
					arg_552_1.talkMaxDuration = var_555_4

					if var_555_4 + 0 > arg_552_1.duration_ then
						arg_552_1.duration_ = var_555_4 + 0
					end
				end

				arg_552_1.text_.text = var_555_2
				arg_552_1.typewritter.percent = 0

				arg_552_1.typewritter:SetDirty()
				arg_552_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704133", "story_v_side_new_1109704.awb") ~= 0 then
					local var_555_5 = manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704133", "story_v_side_new_1109704.awb") / 1000

					if var_555_5 + 0 > arg_552_1.duration_ then
						arg_552_1.duration_ = var_555_5 + 0
					end

					if var_555_1.prefab_name ~= "" and arg_552_1.actors_[var_555_1.prefab_name] ~= nil then
						local var_555_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_552_1.actors_[var_555_1.prefab_name].transform, "story_v_side_new_1109704", "1109704133", "story_v_side_new_1109704.awb")

						arg_552_1:RecordAudio("1109704133", var_555_6)
						arg_552_1:RecordAudio("1109704133", var_555_6)
					else
						arg_552_1:AudioAction("play", "voice", "story_v_side_new_1109704", "1109704133", "story_v_side_new_1109704.awb")
					end

					arg_552_1:RecordHistoryTalkVoice("story_v_side_new_1109704", "1109704133", "story_v_side_new_1109704.awb")
				end

				arg_552_1:RecordContent(arg_552_1.text_.text)
			end

			local var_555_7 = math.max(var_555_0, arg_552_1.talkMaxDuration)

			if 0 <= arg_552_1.time_ and arg_552_1.time_ < 0 + var_555_7 then
				arg_552_1.typewritter.percent = (arg_552_1.time_ - 0) / var_555_7

				arg_552_1.typewritter:SetDirty()
			end

			if arg_552_1.time_ >= 0 + var_555_7 and arg_552_1.time_ < 0 + var_555_7 + arg_555_0 then
				arg_552_1.typewritter.percent = 1

				arg_552_1.typewritter:SetDirty()
				arg_552_1:ShowNextGo(true)
			end
		end

		arg_552_1.nodeConfigList_ = {}

		arg_552_1:InitPlayNodeList()
	end,
	Play1109704134 = function(arg_556_0, arg_556_1)
		arg_556_1.time_ = 0
		arg_556_1.frameCnt_ = 0
		arg_556_1.state_ = "playing"
		arg_556_1.curTalkId_ = 1109704134
		arg_556_1.duration_ = 5

		SetActive(arg_556_1.tipsGo_, false)

		function arg_556_1.onSingleLineFinish_()
			arg_556_1.onSingleLineUpdate_ = nil
			arg_556_1.onSingleLineFinish_ = nil
			arg_556_1.state_ = "waiting"
		end

		function arg_556_1.playNext_(arg_558_0)
			if arg_558_0 == 1 then
				arg_556_0:Play1109704135(arg_556_1)
			end
		end

		function arg_556_1.onSingleLineUpdate_(arg_559_0)
			if 0 < arg_556_1.time_ and arg_556_1.time_ <= 0 + arg_559_0 and not isNil(arg_556_1.actors_["1097ui_story"]) and arg_556_1.var_.characterEffect1097ui_story == nil then
				arg_556_1.var_.characterEffect1097ui_story = arg_556_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_559_0 = 0.200000002980232

			if 0 <= arg_556_1.time_ and arg_556_1.time_ < 0 + var_559_0 and not isNil(arg_556_1.actors_["1097ui_story"]) then
				if arg_556_1.var_.characterEffect1097ui_story and not isNil(arg_556_1.actors_["1097ui_story"]) then
					arg_556_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_556_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_556_1.time_ - 0) / var_559_0)
				end
			end

			if arg_556_1.time_ >= 0 + var_559_0 and arg_556_1.time_ < 0 + var_559_0 + arg_559_0 and not isNil(arg_556_1.actors_["1097ui_story"]) and arg_556_1.var_.characterEffect1097ui_story then
				arg_556_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_556_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_559_1 = 0
			local var_559_2 = 0.05

			if 0 < arg_556_1.time_ and arg_556_1.time_ <= var_559_1 + arg_559_0 then
				arg_556_1.talkMaxDuration = 0
				arg_556_1.dialogCg_.alpha = 1

				arg_556_1.dialog_:SetActive(true)
				SetActive(arg_556_1.leftNameGo_, true)

				arg_556_1.leftNameTxt_.text = arg_556_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_556_1.leftNameTxt_.transform)

				arg_556_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_556_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_556_1:RecordName(arg_556_1.leftNameTxt_.text)
				SetActive(arg_556_1.iconTrs_.gameObject, true)
				arg_556_1.iconController_:SetSelectedState("hero")

				arg_556_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_556_1.callingController_:SetSelectedState("normal")

				arg_556_1.keyicon_.color = Color.New(1, 1, 1)
				arg_556_1.icon_.color = Color.New(1, 1, 1)

				local var_559_3 = arg_556_1:FormatText(arg_556_1:GetWordFromCfg(1109704134).content)

				arg_556_1.text_.text = var_559_3

				LuaForUtil.ClearLinePrefixSymbol(arg_556_1.text_)

				local var_559_5 = 2 <= 0 and var_559_2 or var_559_2 * (utf8.len(var_559_3) / 2)

				if (2 <= 0 and var_559_2 or var_559_2 * (utf8.len(var_559_3) / 2)) > 0 and var_559_2 < var_559_5 then
					arg_556_1.talkMaxDuration = var_559_5

					if var_559_5 + var_559_1 > arg_556_1.duration_ then
						arg_556_1.duration_ = var_559_5 + var_559_1
					end
				end

				arg_556_1.text_.text = var_559_3
				arg_556_1.typewritter.percent = 0

				arg_556_1.typewritter:SetDirty()
				arg_556_1:ShowNextGo(false)
				arg_556_1:RecordContent(arg_556_1.text_.text)
			end

			local var_559_6 = math.max(var_559_2, arg_556_1.talkMaxDuration)

			if var_559_1 <= arg_556_1.time_ and arg_556_1.time_ < var_559_1 + var_559_6 then
				arg_556_1.typewritter.percent = (arg_556_1.time_ - var_559_1) / var_559_6

				arg_556_1.typewritter:SetDirty()
			end

			if arg_556_1.time_ >= var_559_1 + var_559_6 and arg_556_1.time_ < var_559_1 + var_559_6 + arg_559_0 then
				arg_556_1.typewritter.percent = 1

				arg_556_1.typewritter:SetDirty()
				arg_556_1:ShowNextGo(true)
			end
		end

		arg_556_1.nodeConfigList_ = {}

		arg_556_1:InitPlayNodeList()
	end,
	Play1109704135 = function(arg_560_0, arg_560_1)
		arg_560_1.time_ = 0
		arg_560_1.frameCnt_ = 0
		arg_560_1.state_ = "playing"
		arg_560_1.curTalkId_ = 1109704135
		arg_560_1.duration_ = 6.3

		local var_560_0 = {
			zh = 6.3,
			ja = 4.566
		}
		local var_560_1 = manager.audio:GetLocalizationFlag()

		if var_560_0[var_560_1] ~= nil then
			arg_560_1.duration_ = var_560_0[var_560_1]
		end

		SetActive(arg_560_1.tipsGo_, false)

		function arg_560_1.onSingleLineFinish_()
			arg_560_1.onSingleLineUpdate_ = nil
			arg_560_1.onSingleLineFinish_ = nil
			arg_560_1.state_ = "waiting"
		end

		function arg_560_1.playNext_(arg_562_0)
			if arg_562_0 == 1 then
				arg_560_0:Play1109704136(arg_560_1)
			end
		end

		function arg_560_1.onSingleLineUpdate_(arg_563_0)
			local var_563_0 = 0.675

			if 0 < arg_560_1.time_ and arg_560_1.time_ <= 0 + arg_563_0 then
				arg_560_1.talkMaxDuration = 0
				arg_560_1.dialogCg_.alpha = 1

				arg_560_1.dialog_:SetActive(true)
				SetActive(arg_560_1.leftNameGo_, true)

				arg_560_1.leftNameTxt_.text = arg_560_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_560_1.leftNameTxt_.transform)

				arg_560_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_560_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_560_1:RecordName(arg_560_1.leftNameTxt_.text)
				SetActive(arg_560_1.iconTrs_.gameObject, true)
				arg_560_1.iconController_:SetSelectedState("hero")

				arg_560_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1097")

				arg_560_1.callingController_:SetSelectedState("normal")

				arg_560_1.keyicon_.color = Color.New(1, 1, 1)
				arg_560_1.icon_.color = Color.New(1, 1, 1)

				local var_563_1 = arg_560_1:GetWordFromCfg(1109704135)
				local var_563_2 = arg_560_1:FormatText(var_563_1.content)

				arg_560_1.text_.text = var_563_2

				LuaForUtil.ClearLinePrefixSymbol(arg_560_1.text_)

				local var_563_4 = 27 <= 0 and var_563_0 or var_563_0 * (utf8.len(var_563_2) / 27)

				if (27 <= 0 and var_563_0 or var_563_0 * (utf8.len(var_563_2) / 27)) > 0 and var_563_0 < var_563_4 then
					arg_560_1.talkMaxDuration = var_563_4

					if var_563_4 + 0 > arg_560_1.duration_ then
						arg_560_1.duration_ = var_563_4 + 0
					end
				end

				arg_560_1.text_.text = var_563_2
				arg_560_1.typewritter.percent = 0

				arg_560_1.typewritter:SetDirty()
				arg_560_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704135", "story_v_side_new_1109704.awb") ~= 0 then
					local var_563_5 = manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704135", "story_v_side_new_1109704.awb") / 1000

					if var_563_5 + 0 > arg_560_1.duration_ then
						arg_560_1.duration_ = var_563_5 + 0
					end

					if var_563_1.prefab_name ~= "" and arg_560_1.actors_[var_563_1.prefab_name] ~= nil then
						local var_563_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_560_1.actors_[var_563_1.prefab_name].transform, "story_v_side_new_1109704", "1109704135", "story_v_side_new_1109704.awb")

						arg_560_1:RecordAudio("1109704135", var_563_6)
						arg_560_1:RecordAudio("1109704135", var_563_6)
					else
						arg_560_1:AudioAction("play", "voice", "story_v_side_new_1109704", "1109704135", "story_v_side_new_1109704.awb")
					end

					arg_560_1:RecordHistoryTalkVoice("story_v_side_new_1109704", "1109704135", "story_v_side_new_1109704.awb")
				end

				arg_560_1:RecordContent(arg_560_1.text_.text)
			end

			local var_563_7 = math.max(var_563_0, arg_560_1.talkMaxDuration)

			if 0 <= arg_560_1.time_ and arg_560_1.time_ < 0 + var_563_7 then
				arg_560_1.typewritter.percent = (arg_560_1.time_ - 0) / var_563_7

				arg_560_1.typewritter:SetDirty()
			end

			if arg_560_1.time_ >= 0 + var_563_7 and arg_560_1.time_ < 0 + var_563_7 + arg_563_0 then
				arg_560_1.typewritter.percent = 1

				arg_560_1.typewritter:SetDirty()
				arg_560_1:ShowNextGo(true)
			end
		end

		arg_560_1.nodeConfigList_ = {}

		arg_560_1:InitPlayNodeList()
	end,
	Play1109704136 = function(arg_564_0, arg_564_1)
		arg_564_1.time_ = 0
		arg_564_1.frameCnt_ = 0
		arg_564_1.state_ = "playing"
		arg_564_1.curTalkId_ = 1109704136
		arg_564_1.duration_ = 5

		SetActive(arg_564_1.tipsGo_, false)

		function arg_564_1.onSingleLineFinish_()
			arg_564_1.onSingleLineUpdate_ = nil
			arg_564_1.onSingleLineFinish_ = nil
			arg_564_1.state_ = "waiting"
		end

		function arg_564_1.playNext_(arg_566_0)
			if arg_566_0 == 1 then
				arg_564_0:Play1109704137(arg_564_1)
			end
		end

		function arg_564_1.onSingleLineUpdate_(arg_567_0)
			if 0 < arg_564_1.time_ and arg_564_1.time_ <= 0 + arg_567_0 and not isNil(arg_564_1.actors_["1097ui_story"]) and arg_564_1.var_.characterEffect1097ui_story == nil then
				arg_564_1.var_.characterEffect1097ui_story = arg_564_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_567_0 = 0.200000002980232

			if 0 <= arg_564_1.time_ and arg_564_1.time_ < 0 + var_567_0 and not isNil(arg_564_1.actors_["1097ui_story"]) then
				if arg_564_1.var_.characterEffect1097ui_story and not isNil(arg_564_1.actors_["1097ui_story"]) then
					arg_564_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_564_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_564_1.time_ - 0) / var_567_0)
				end
			end

			if arg_564_1.time_ >= 0 + var_567_0 and arg_564_1.time_ < 0 + var_567_0 + arg_567_0 and not isNil(arg_564_1.actors_["1097ui_story"]) and arg_564_1.var_.characterEffect1097ui_story then
				arg_564_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_564_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_567_1 = 0
			local var_567_2 = 0.825

			if 0 < arg_564_1.time_ and arg_564_1.time_ <= var_567_1 + arg_567_0 then
				arg_564_1.talkMaxDuration = 0
				arg_564_1.dialogCg_.alpha = 1

				arg_564_1.dialog_:SetActive(true)
				SetActive(arg_564_1.leftNameGo_, false)

				arg_564_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_564_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_564_1:RecordName(arg_564_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_564_1.iconTrs_.gameObject, false)
				arg_564_1.callingController_:SetSelectedState("normal")

				local var_567_3 = arg_564_1:FormatText(arg_564_1:GetWordFromCfg(1109704136).content)

				arg_564_1.text_.text = var_567_3

				LuaForUtil.ClearLinePrefixSymbol(arg_564_1.text_)

				local var_567_5 = 33 <= 0 and var_567_2 or var_567_2 * (utf8.len(var_567_3) / 33)

				if (33 <= 0 and var_567_2 or var_567_2 * (utf8.len(var_567_3) / 33)) > 0 and var_567_2 < var_567_5 then
					arg_564_1.talkMaxDuration = var_567_5

					if var_567_5 + var_567_1 > arg_564_1.duration_ then
						arg_564_1.duration_ = var_567_5 + var_567_1
					end
				end

				arg_564_1.text_.text = var_567_3
				arg_564_1.typewritter.percent = 0

				arg_564_1.typewritter:SetDirty()
				arg_564_1:ShowNextGo(false)
				arg_564_1:RecordContent(arg_564_1.text_.text)
			end

			local var_567_6 = math.max(var_567_2, arg_564_1.talkMaxDuration)

			if var_567_1 <= arg_564_1.time_ and arg_564_1.time_ < var_567_1 + var_567_6 then
				arg_564_1.typewritter.percent = (arg_564_1.time_ - var_567_1) / var_567_6

				arg_564_1.typewritter:SetDirty()
			end

			if arg_564_1.time_ >= var_567_1 + var_567_6 and arg_564_1.time_ < var_567_1 + var_567_6 + arg_567_0 then
				arg_564_1.typewritter.percent = 1

				arg_564_1.typewritter:SetDirty()
				arg_564_1:ShowNextGo(true)
			end
		end

		arg_564_1.nodeConfigList_ = {}

		arg_564_1:InitPlayNodeList()
	end,
	Play1109704137 = function(arg_568_0, arg_568_1)
		arg_568_1.time_ = 0
		arg_568_1.frameCnt_ = 0
		arg_568_1.state_ = "playing"
		arg_568_1.curTalkId_ = 1109704137
		arg_568_1.duration_ = 10.8

		local var_568_0 = {
			zh = 8.7,
			ja = 10.8
		}
		local var_568_1 = manager.audio:GetLocalizationFlag()

		if var_568_0[var_568_1] ~= nil then
			arg_568_1.duration_ = var_568_0[var_568_1]
		end

		SetActive(arg_568_1.tipsGo_, false)

		function arg_568_1.onSingleLineFinish_()
			arg_568_1.onSingleLineUpdate_ = nil
			arg_568_1.onSingleLineFinish_ = nil
			arg_568_1.state_ = "waiting"
		end

		function arg_568_1.playNext_(arg_570_0)
			if arg_570_0 == 1 then
				arg_568_0:Play1109704138(arg_568_1)
			end
		end

		function arg_568_1.onSingleLineUpdate_(arg_571_0)
			local var_571_0 = 1.2

			if 0 < arg_568_1.time_ and arg_568_1.time_ <= 0 + arg_571_0 then
				arg_568_1.talkMaxDuration = 0
				arg_568_1.dialogCg_.alpha = 1

				arg_568_1.dialog_:SetActive(true)
				SetActive(arg_568_1.leftNameGo_, true)

				arg_568_1.leftNameTxt_.text = arg_568_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_568_1.leftNameTxt_.transform)

				arg_568_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_568_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_568_1:RecordName(arg_568_1.leftNameTxt_.text)
				SetActive(arg_568_1.iconTrs_.gameObject, true)
				arg_568_1.iconController_:SetSelectedState("hero")

				arg_568_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1097")

				arg_568_1.callingController_:SetSelectedState("normal")

				arg_568_1.keyicon_.color = Color.New(1, 1, 1)
				arg_568_1.icon_.color = Color.New(1, 1, 1)

				local var_571_1 = arg_568_1:GetWordFromCfg(1109704137)
				local var_571_2 = arg_568_1:FormatText(var_571_1.content)

				arg_568_1.text_.text = var_571_2

				LuaForUtil.ClearLinePrefixSymbol(arg_568_1.text_)

				local var_571_4 = 48 <= 0 and var_571_0 or var_571_0 * (utf8.len(var_571_2) / 48)

				if (48 <= 0 and var_571_0 or var_571_0 * (utf8.len(var_571_2) / 48)) > 0 and var_571_0 < var_571_4 then
					arg_568_1.talkMaxDuration = var_571_4

					if var_571_4 + 0 > arg_568_1.duration_ then
						arg_568_1.duration_ = var_571_4 + 0
					end
				end

				arg_568_1.text_.text = var_571_2
				arg_568_1.typewritter.percent = 0

				arg_568_1.typewritter:SetDirty()
				arg_568_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704137", "story_v_side_new_1109704.awb") ~= 0 then
					local var_571_5 = manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704137", "story_v_side_new_1109704.awb") / 1000

					if var_571_5 + 0 > arg_568_1.duration_ then
						arg_568_1.duration_ = var_571_5 + 0
					end

					if var_571_1.prefab_name ~= "" and arg_568_1.actors_[var_571_1.prefab_name] ~= nil then
						local var_571_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_568_1.actors_[var_571_1.prefab_name].transform, "story_v_side_new_1109704", "1109704137", "story_v_side_new_1109704.awb")

						arg_568_1:RecordAudio("1109704137", var_571_6)
						arg_568_1:RecordAudio("1109704137", var_571_6)
					else
						arg_568_1:AudioAction("play", "voice", "story_v_side_new_1109704", "1109704137", "story_v_side_new_1109704.awb")
					end

					arg_568_1:RecordHistoryTalkVoice("story_v_side_new_1109704", "1109704137", "story_v_side_new_1109704.awb")
				end

				arg_568_1:RecordContent(arg_568_1.text_.text)
			end

			local var_571_7 = math.max(var_571_0, arg_568_1.talkMaxDuration)

			if 0 <= arg_568_1.time_ and arg_568_1.time_ < 0 + var_571_7 then
				arg_568_1.typewritter.percent = (arg_568_1.time_ - 0) / var_571_7

				arg_568_1.typewritter:SetDirty()
			end

			if arg_568_1.time_ >= 0 + var_571_7 and arg_568_1.time_ < 0 + var_571_7 + arg_571_0 then
				arg_568_1.typewritter.percent = 1

				arg_568_1.typewritter:SetDirty()
				arg_568_1:ShowNextGo(true)
			end
		end

		arg_568_1.nodeConfigList_ = {}

		arg_568_1:InitPlayNodeList()
	end,
	Play1109704138 = function(arg_572_0, arg_572_1)
		arg_572_1.time_ = 0
		arg_572_1.frameCnt_ = 0
		arg_572_1.state_ = "playing"
		arg_572_1.curTalkId_ = 1109704138
		arg_572_1.duration_ = 11.37

		local var_572_0 = {
			zh = 8.966,
			ja = 11.366
		}
		local var_572_1 = manager.audio:GetLocalizationFlag()

		if var_572_0[var_572_1] ~= nil then
			arg_572_1.duration_ = var_572_0[var_572_1]
		end

		SetActive(arg_572_1.tipsGo_, false)

		function arg_572_1.onSingleLineFinish_()
			arg_572_1.onSingleLineUpdate_ = nil
			arg_572_1.onSingleLineFinish_ = nil
			arg_572_1.state_ = "waiting"
		end

		function arg_572_1.playNext_(arg_574_0)
			if arg_574_0 == 1 then
				arg_572_0:Play1109704139(arg_572_1)
			end
		end

		function arg_572_1.onSingleLineUpdate_(arg_575_0)
			local var_575_0 = 0.825

			if 0 < arg_572_1.time_ and arg_572_1.time_ <= 0 + arg_575_0 then
				arg_572_1.talkMaxDuration = 0
				arg_572_1.dialogCg_.alpha = 1

				arg_572_1.dialog_:SetActive(true)
				SetActive(arg_572_1.leftNameGo_, true)

				arg_572_1.leftNameTxt_.text = arg_572_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_572_1.leftNameTxt_.transform)

				arg_572_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_572_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_572_1:RecordName(arg_572_1.leftNameTxt_.text)
				SetActive(arg_572_1.iconTrs_.gameObject, true)
				arg_572_1.iconController_:SetSelectedState("hero")

				arg_572_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1097")

				arg_572_1.callingController_:SetSelectedState("normal")

				arg_572_1.keyicon_.color = Color.New(1, 1, 1)
				arg_572_1.icon_.color = Color.New(1, 1, 1)

				local var_575_1 = arg_572_1:GetWordFromCfg(1109704138)
				local var_575_2 = arg_572_1:FormatText(var_575_1.content)

				arg_572_1.text_.text = var_575_2

				LuaForUtil.ClearLinePrefixSymbol(arg_572_1.text_)

				local var_575_4 = 33 <= 0 and var_575_0 or var_575_0 * (utf8.len(var_575_2) / 33)

				if (33 <= 0 and var_575_0 or var_575_0 * (utf8.len(var_575_2) / 33)) > 0 and var_575_0 < var_575_4 then
					arg_572_1.talkMaxDuration = var_575_4

					if var_575_4 + 0 > arg_572_1.duration_ then
						arg_572_1.duration_ = var_575_4 + 0
					end
				end

				arg_572_1.text_.text = var_575_2
				arg_572_1.typewritter.percent = 0

				arg_572_1.typewritter:SetDirty()
				arg_572_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704138", "story_v_side_new_1109704.awb") ~= 0 then
					local var_575_5 = manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704138", "story_v_side_new_1109704.awb") / 1000

					if var_575_5 + 0 > arg_572_1.duration_ then
						arg_572_1.duration_ = var_575_5 + 0
					end

					if var_575_1.prefab_name ~= "" and arg_572_1.actors_[var_575_1.prefab_name] ~= nil then
						local var_575_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_572_1.actors_[var_575_1.prefab_name].transform, "story_v_side_new_1109704", "1109704138", "story_v_side_new_1109704.awb")

						arg_572_1:RecordAudio("1109704138", var_575_6)
						arg_572_1:RecordAudio("1109704138", var_575_6)
					else
						arg_572_1:AudioAction("play", "voice", "story_v_side_new_1109704", "1109704138", "story_v_side_new_1109704.awb")
					end

					arg_572_1:RecordHistoryTalkVoice("story_v_side_new_1109704", "1109704138", "story_v_side_new_1109704.awb")
				end

				arg_572_1:RecordContent(arg_572_1.text_.text)
			end

			local var_575_7 = math.max(var_575_0, arg_572_1.talkMaxDuration)

			if 0 <= arg_572_1.time_ and arg_572_1.time_ < 0 + var_575_7 then
				arg_572_1.typewritter.percent = (arg_572_1.time_ - 0) / var_575_7

				arg_572_1.typewritter:SetDirty()
			end

			if arg_572_1.time_ >= 0 + var_575_7 and arg_572_1.time_ < 0 + var_575_7 + arg_575_0 then
				arg_572_1.typewritter.percent = 1

				arg_572_1.typewritter:SetDirty()
				arg_572_1:ShowNextGo(true)
			end
		end

		arg_572_1.nodeConfigList_ = {}

		arg_572_1:InitPlayNodeList()
	end,
	Play1109704139 = function(arg_576_0, arg_576_1)
		arg_576_1.time_ = 0
		arg_576_1.frameCnt_ = 0
		arg_576_1.state_ = "playing"
		arg_576_1.curTalkId_ = 1109704139
		arg_576_1.duration_ = 5

		SetActive(arg_576_1.tipsGo_, false)

		function arg_576_1.onSingleLineFinish_()
			arg_576_1.onSingleLineUpdate_ = nil
			arg_576_1.onSingleLineFinish_ = nil
			arg_576_1.state_ = "waiting"
		end

		function arg_576_1.playNext_(arg_578_0)
			if arg_578_0 == 1 then
				arg_576_0:Play1109704140(arg_576_1)
			end
		end

		function arg_576_1.onSingleLineUpdate_(arg_579_0)
			local var_579_0 = 0
			local var_579_1 = 0.6

			if 0 < arg_576_1.time_ and arg_576_1.time_ <= var_579_0 + arg_579_0 then
				arg_576_1.talkMaxDuration = 0

				arg_576_1.dialog_:SetActive(true)

				arg_576_1.dialogCg_.alpha = 0

				local var_579_2 = LeanTween.value(arg_576_1.dialog_, 0, 1, 0.3)

				var_579_2:setOnUpdate(LuaHelper.FloatAction(function(arg_580_0)
					arg_576_1.dialogCg_.alpha = arg_580_0
				end))
				var_579_2:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_576_1.dialog_)
					var_579_2:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_576_1.duration_ = arg_576_1.duration_ + 0.3

				SetActive(arg_576_1.leftNameGo_, false)

				arg_576_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_576_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_576_1:RecordName(arg_576_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_576_1.iconTrs_.gameObject, false)
				arg_576_1.callingController_:SetSelectedState("normal")

				local var_579_3 = arg_576_1:FormatText(arg_576_1:GetWordFromCfg(1109704139).content)

				arg_576_1.text_.text = var_579_3

				LuaForUtil.ClearLinePrefixSymbol(arg_576_1.text_)

				local var_579_5 = 24 <= 0 and var_579_1 or var_579_1 * (utf8.len(var_579_3) / 24)

				if (24 <= 0 and var_579_1 or var_579_1 * (utf8.len(var_579_3) / 24)) > 0 and var_579_1 < var_579_5 then
					arg_576_1.talkMaxDuration = var_579_5
					var_579_0 = var_579_0 + 0.3

					if var_579_5 + var_579_0 > arg_576_1.duration_ then
						arg_576_1.duration_ = var_579_5 + var_579_0
					end
				end

				arg_576_1.text_.text = var_579_3
				arg_576_1.typewritter.percent = 0

				arg_576_1.typewritter:SetDirty()
				arg_576_1:ShowNextGo(false)
				arg_576_1:RecordContent(arg_576_1.text_.text)
			end

			local var_579_6 = var_579_0 + 0.3
			local var_579_7 = math.max(var_579_1, arg_576_1.talkMaxDuration)

			if var_579_0 + 0.3 <= arg_576_1.time_ and arg_576_1.time_ < var_579_6 + var_579_7 then
				arg_576_1.typewritter.percent = (arg_576_1.time_ - var_579_6) / var_579_7

				arg_576_1.typewritter:SetDirty()
			end

			if arg_576_1.time_ >= var_579_6 + var_579_7 and arg_576_1.time_ < var_579_6 + var_579_7 + arg_579_0 then
				arg_576_1.typewritter.percent = 1

				arg_576_1.typewritter:SetDirty()
				arg_576_1:ShowNextGo(true)
			end
		end

		arg_576_1.nodeConfigList_ = {}

		arg_576_1:InitPlayNodeList()
	end,
	Play1109704140 = function(arg_582_0, arg_582_1)
		arg_582_1.time_ = 0
		arg_582_1.frameCnt_ = 0
		arg_582_1.state_ = "playing"
		arg_582_1.curTalkId_ = 1109704140
		arg_582_1.duration_ = 5

		SetActive(arg_582_1.tipsGo_, false)

		function arg_582_1.onSingleLineFinish_()
			arg_582_1.onSingleLineUpdate_ = nil
			arg_582_1.onSingleLineFinish_ = nil
			arg_582_1.state_ = "waiting"
		end

		function arg_582_1.playNext_(arg_584_0)
			if arg_584_0 == 1 then
				arg_582_0:Play1109704141(arg_582_1)
			end
		end

		function arg_582_1.onSingleLineUpdate_(arg_585_0)
			local var_585_0 = 0.1

			if 0 < arg_582_1.time_ and arg_582_1.time_ <= 0 + arg_585_0 then
				arg_582_1.talkMaxDuration = 0
				arg_582_1.dialogCg_.alpha = 1

				arg_582_1.dialog_:SetActive(true)
				SetActive(arg_582_1.leftNameGo_, false)

				arg_582_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_582_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_582_1:RecordName(arg_582_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_582_1.iconTrs_.gameObject, false)
				arg_582_1.callingController_:SetSelectedState("normal")

				local var_585_1 = arg_582_1:FormatText(arg_582_1:GetWordFromCfg(1109704140).content)

				arg_582_1.text_.text = var_585_1

				LuaForUtil.ClearLinePrefixSymbol(arg_582_1.text_)

				local var_585_3 = 4 <= 0 and var_585_0 or var_585_0 * (utf8.len(var_585_1) / 4)

				if (4 <= 0 and var_585_0 or var_585_0 * (utf8.len(var_585_1) / 4)) > 0 and var_585_0 < var_585_3 then
					arg_582_1.talkMaxDuration = var_585_3

					if var_585_3 + 0 > arg_582_1.duration_ then
						arg_582_1.duration_ = var_585_3 + 0
					end
				end

				arg_582_1.text_.text = var_585_1
				arg_582_1.typewritter.percent = 0

				arg_582_1.typewritter:SetDirty()
				arg_582_1:ShowNextGo(false)
				arg_582_1:RecordContent(arg_582_1.text_.text)
			end

			local var_585_4 = math.max(var_585_0, arg_582_1.talkMaxDuration)

			if 0 <= arg_582_1.time_ and arg_582_1.time_ < 0 + var_585_4 then
				arg_582_1.typewritter.percent = (arg_582_1.time_ - 0) / var_585_4

				arg_582_1.typewritter:SetDirty()
			end

			if arg_582_1.time_ >= 0 + var_585_4 and arg_582_1.time_ < 0 + var_585_4 + arg_585_0 then
				arg_582_1.typewritter.percent = 1

				arg_582_1.typewritter:SetDirty()
				arg_582_1:ShowNextGo(true)
			end
		end

		arg_582_1.nodeConfigList_ = {}

		arg_582_1:InitPlayNodeList()
	end,
	Play1109704141 = function(arg_586_0, arg_586_1)
		arg_586_1.time_ = 0
		arg_586_1.frameCnt_ = 0
		arg_586_1.state_ = "playing"
		arg_586_1.curTalkId_ = 1109704141
		arg_586_1.duration_ = 5

		SetActive(arg_586_1.tipsGo_, false)

		function arg_586_1.onSingleLineFinish_()
			arg_586_1.onSingleLineUpdate_ = nil
			arg_586_1.onSingleLineFinish_ = nil
			arg_586_1.state_ = "waiting"
		end

		function arg_586_1.playNext_(arg_588_0)
			if arg_588_0 == 1 then
				arg_586_0:Play1109704142(arg_586_1)
			end
		end

		function arg_586_1.onSingleLineUpdate_(arg_589_0)
			local var_589_0 = 0.05

			if 0 < arg_586_1.time_ and arg_586_1.time_ <= 0 + arg_589_0 then
				arg_586_1.talkMaxDuration = 0
				arg_586_1.dialogCg_.alpha = 1

				arg_586_1.dialog_:SetActive(true)
				SetActive(arg_586_1.leftNameGo_, false)

				arg_586_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_586_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_586_1:RecordName(arg_586_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_586_1.iconTrs_.gameObject, false)
				arg_586_1.callingController_:SetSelectedState("normal")

				local var_589_1 = arg_586_1:FormatText(arg_586_1:GetWordFromCfg(1109704141).content)

				arg_586_1.text_.text = var_589_1

				LuaForUtil.ClearLinePrefixSymbol(arg_586_1.text_)

				local var_589_3 = 2 <= 0 and var_589_0 or var_589_0 * (utf8.len(var_589_1) / 2)

				if (2 <= 0 and var_589_0 or var_589_0 * (utf8.len(var_589_1) / 2)) > 0 and var_589_0 < var_589_3 then
					arg_586_1.talkMaxDuration = var_589_3

					if var_589_3 + 0 > arg_586_1.duration_ then
						arg_586_1.duration_ = var_589_3 + 0
					end
				end

				arg_586_1.text_.text = var_589_1
				arg_586_1.typewritter.percent = 0

				arg_586_1.typewritter:SetDirty()
				arg_586_1:ShowNextGo(false)
				arg_586_1:RecordContent(arg_586_1.text_.text)
			end

			local var_589_4 = math.max(var_589_0, arg_586_1.talkMaxDuration)

			if 0 <= arg_586_1.time_ and arg_586_1.time_ < 0 + var_589_4 then
				arg_586_1.typewritter.percent = (arg_586_1.time_ - 0) / var_589_4

				arg_586_1.typewritter:SetDirty()
			end

			if arg_586_1.time_ >= 0 + var_589_4 and arg_586_1.time_ < 0 + var_589_4 + arg_589_0 then
				arg_586_1.typewritter.percent = 1

				arg_586_1.typewritter:SetDirty()
				arg_586_1:ShowNextGo(true)
			end
		end

		arg_586_1.nodeConfigList_ = {}

		arg_586_1:InitPlayNodeList()
	end,
	Play1109704142 = function(arg_590_0, arg_590_1)
		arg_590_1.time_ = 0
		arg_590_1.frameCnt_ = 0
		arg_590_1.state_ = "playing"
		arg_590_1.curTalkId_ = 1109704142
		arg_590_1.duration_ = 9

		SetActive(arg_590_1.tipsGo_, false)

		function arg_590_1.onSingleLineFinish_()
			arg_590_1.onSingleLineUpdate_ = nil
			arg_590_1.onSingleLineFinish_ = nil
			arg_590_1.state_ = "waiting"
		end

		function arg_590_1.playNext_(arg_592_0)
			if arg_592_0 == 1 then
				arg_590_0:Play1109704143(arg_590_1)
			end
		end

		function arg_590_1.onSingleLineUpdate_(arg_593_0)
			if arg_590_1.bgs_.F01 == nil then
				local var_593_0 = Object.Instantiate(arg_590_1.paintGo_)

				var_593_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "F01")
				var_593_0.name = "F01"
				var_593_0.transform.parent = arg_590_1.stage_.transform
				var_593_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_590_1.bgs_.F01 = var_593_0
			end

			if 1.999999999999 < arg_590_1.time_ and arg_590_1.time_ <= 1.999999999999 + arg_593_0 then
				local var_593_1 = arg_590_1.bgs_.F01

				arg_590_1.bgs_.F01.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_593_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_593_2 = var_593_1:GetComponent("SpriteRenderer")

				if var_593_2 and var_593_2.sprite then
					local var_593_3 = 2 * (var_593_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_593_1.transform.localScale = Vector3.New(var_593_3 / var_593_2.sprite.bounds.size.y < var_593_3 * manager.ui.mainCameraCom_.aspect / var_593_2.sprite.bounds.size.x and var_593_3 * manager.ui.mainCameraCom_.aspect / var_593_2.sprite.bounds.size.x or var_593_3 / var_593_2.sprite.bounds.size.y, var_593_3 / var_593_2.sprite.bounds.size.y < var_593_3 * manager.ui.mainCameraCom_.aspect / var_593_2.sprite.bounds.size.x and var_593_3 * manager.ui.mainCameraCom_.aspect / var_593_2.sprite.bounds.size.x or var_593_3 / var_593_2.sprite.bounds.size.y, 0)
				end

				for iter_593_0, iter_593_1 in pairs(arg_590_1.bgs_) do
					if iter_593_0 ~= "F01" then
						iter_593_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_593_4 = 3.999999999999

			if 3.999999999999 < arg_590_1.time_ and arg_590_1.time_ <= var_593_4 + arg_593_0 then
				arg_590_1.allBtn_.enabled = false
			end

			if arg_590_1.time_ >= var_593_4 + 0.3 and arg_590_1.time_ < var_593_4 + 0.3 + arg_593_0 then
				arg_590_1.allBtn_.enabled = true
			end

			local var_593_5 = 0

			if 0 < arg_590_1.time_ and arg_590_1.time_ <= var_593_5 + arg_593_0 then
				arg_590_1.mask_.enabled = true
				arg_590_1.mask_.raycastTarget = true

				arg_590_1:SetGaussion(false)
			end

			local var_593_6 = 2

			if var_593_5 <= arg_590_1.time_ and arg_590_1.time_ < var_593_5 + var_593_6 then
				local var_593_7 = Color.New(1, 1, 1)

				var_593_7.a = Mathf.Lerp(0, 1, (arg_590_1.time_ - var_593_5) / var_593_6)
				arg_590_1.mask_.color = var_593_7
			end

			if arg_590_1.time_ >= var_593_5 + var_593_6 and arg_590_1.time_ < var_593_5 + var_593_6 + arg_593_0 then
				local var_593_8 = Color.New(1, 1, 1)

				var_593_8.a = 1
				arg_590_1.mask_.color = var_593_8
			end

			local var_593_9 = 2

			if 2 < arg_590_1.time_ and arg_590_1.time_ <= var_593_9 + arg_593_0 then
				arg_590_1.mask_.enabled = true
				arg_590_1.mask_.raycastTarget = true

				arg_590_1:SetGaussion(false)
			end

			local var_593_10 = 2

			if var_593_9 <= arg_590_1.time_ and arg_590_1.time_ < var_593_9 + var_593_10 then
				local var_593_11 = Color.New(1, 1, 1)

				var_593_11.a = Mathf.Lerp(1, 0, (arg_590_1.time_ - var_593_9) / var_593_10)
				arg_590_1.mask_.color = var_593_11
			end

			if arg_590_1.time_ >= var_593_9 + var_593_10 and arg_590_1.time_ < var_593_9 + var_593_10 + arg_593_0 then
				local var_593_12 = Color.New(1, 1, 1)

				arg_590_1.mask_.enabled = false
				var_593_12.a = 0
				arg_590_1.mask_.color = var_593_12
			end

			if arg_590_1.frameCnt_ <= 1 then
				arg_590_1.dialog_:SetActive(false)
			end

			local var_593_13 = 3.999999999999
			local var_593_14 = 0.15

			if 3.999999999999 < arg_590_1.time_ and arg_590_1.time_ <= var_593_13 + arg_593_0 then
				arg_590_1.talkMaxDuration = 0

				arg_590_1.dialog_:SetActive(true)

				arg_590_1.dialogCg_.alpha = 0

				local var_593_15 = LeanTween.value(arg_590_1.dialog_, 0, 1, 0.3)

				var_593_15:setOnUpdate(LuaHelper.FloatAction(function(arg_594_0)
					arg_590_1.dialogCg_.alpha = arg_594_0
				end))
				var_593_15:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_590_1.dialog_)
					var_593_15:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_590_1.duration_ = arg_590_1.duration_ + 0.3

				SetActive(arg_590_1.leftNameGo_, true)

				arg_590_1.leftNameTxt_.text = arg_590_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_590_1.leftNameTxt_.transform)

				arg_590_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_590_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_590_1:RecordName(arg_590_1.leftNameTxt_.text)
				SetActive(arg_590_1.iconTrs_.gameObject, true)
				arg_590_1.iconController_:SetSelectedState("hero")

				arg_590_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_590_1.callingController_:SetSelectedState("normal")

				arg_590_1.keyicon_.color = Color.New(1, 1, 1)
				arg_590_1.icon_.color = Color.New(1, 1, 1)

				local var_593_16 = arg_590_1:FormatText(arg_590_1:GetWordFromCfg(1109704142).content)

				arg_590_1.text_.text = var_593_16

				LuaForUtil.ClearLinePrefixSymbol(arg_590_1.text_)

				local var_593_18 = 6 <= 0 and var_593_14 or var_593_14 * (utf8.len(var_593_16) / 6)

				if (6 <= 0 and var_593_14 or var_593_14 * (utf8.len(var_593_16) / 6)) > 0 and var_593_14 < var_593_18 then
					arg_590_1.talkMaxDuration = var_593_18
					var_593_13 = var_593_13 + 0.3

					if var_593_18 + var_593_13 > arg_590_1.duration_ then
						arg_590_1.duration_ = var_593_18 + var_593_13
					end
				end

				arg_590_1.text_.text = var_593_16
				arg_590_1.typewritter.percent = 0

				arg_590_1.typewritter:SetDirty()
				arg_590_1:ShowNextGo(false)
				arg_590_1:RecordContent(arg_590_1.text_.text)
			end

			local var_593_19 = var_593_13 + 0.3
			local var_593_20 = math.max(var_593_14, arg_590_1.talkMaxDuration)

			if var_593_13 + 0.3 <= arg_590_1.time_ and arg_590_1.time_ < var_593_19 + var_593_20 then
				arg_590_1.typewritter.percent = (arg_590_1.time_ - var_593_19) / var_593_20

				arg_590_1.typewritter:SetDirty()
			end

			if arg_590_1.time_ >= var_593_19 + var_593_20 and arg_590_1.time_ < var_593_19 + var_593_20 + arg_593_0 then
				arg_590_1.typewritter.percent = 1

				arg_590_1.typewritter:SetDirty()
				arg_590_1:ShowNextGo(true)
			end
		end

		arg_590_1.nodeConfigList_ = {}

		arg_590_1:InitPlayNodeList()
	end,
	Play1109704143 = function(arg_596_0, arg_596_1)
		arg_596_1.time_ = 0
		arg_596_1.frameCnt_ = 0
		arg_596_1.state_ = "playing"
		arg_596_1.curTalkId_ = 1109704143
		arg_596_1.duration_ = 10.9

		local var_596_0 = {
			zh = 7.433,
			ja = 10.9
		}
		local var_596_1 = manager.audio:GetLocalizationFlag()

		if var_596_0[var_596_1] ~= nil then
			arg_596_1.duration_ = var_596_0[var_596_1]
		end

		SetActive(arg_596_1.tipsGo_, false)

		function arg_596_1.onSingleLineFinish_()
			arg_596_1.onSingleLineUpdate_ = nil
			arg_596_1.onSingleLineFinish_ = nil
			arg_596_1.state_ = "waiting"
		end

		function arg_596_1.playNext_(arg_598_0)
			if arg_598_0 == 1 then
				arg_596_0:Play1109704144(arg_596_1)
			end
		end

		function arg_596_1.onSingleLineUpdate_(arg_599_0)
			if arg_596_1.actors_["1042ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1042ui_story"))) then
				local var_599_0 = Object.Instantiate(Asset.Load("Char/" .. "1042ui_story"), arg_596_1.stage_.transform)

				var_599_0.name = "1042ui_story"
				var_599_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_596_1.actors_["1042ui_story"] = var_599_0

				local var_599_1 = var_599_0:GetComponentInChildren(typeof(CharacterEffect))

				var_599_1.enabled = true

				local var_599_2 = GameObjectTools.GetOrAddComponent(var_599_0, typeof(DynamicBoneHelper))

				if var_599_2 then
					var_599_2:EnableDynamicBone(false)
				end

				arg_596_1:ShowWeapon(var_599_1.transform, false)

				arg_596_1.var_["1042ui_story" .. "Animator"] = var_599_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_596_1.var_["1042ui_story" .. "Animator"].applyRootMotion = true
				arg_596_1.var_["1042ui_story" .. "LipSync"] = var_599_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_599_3 = arg_596_1.actors_["1042ui_story"].transform

			if 0 < arg_596_1.time_ and arg_596_1.time_ <= 0 + arg_599_0 then
				arg_596_1.var_.moveOldPos1042ui_story = var_599_3.localPosition
			end

			local var_599_4 = 0.001

			if 0 <= arg_596_1.time_ and arg_596_1.time_ < 0 + var_599_4 then
				var_599_3.localPosition = Vector3.Lerp(arg_596_1.var_.moveOldPos1042ui_story, Vector3.New(0, -1.06, -6.2), (arg_596_1.time_ - 0) / var_599_4)
				var_599_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_599_3.position).x, (manager.ui.mainCamera.transform.position - var_599_3.position).y, (manager.ui.mainCamera.transform.position - var_599_3.position).z)
				var_599_3.localEulerAngles.z = 0
				var_599_3.localEulerAngles.x = 0
				var_599_3.localEulerAngles = var_599_3.localEulerAngles
			end

			if arg_596_1.time_ >= 0 + var_599_4 and arg_596_1.time_ < 0 + var_599_4 + arg_599_0 then
				var_599_3.localPosition = Vector3.New(0, -1.06, -6.2)
				var_599_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_599_3.position).x, (manager.ui.mainCamera.transform.position - var_599_3.position).y, (manager.ui.mainCamera.transform.position - var_599_3.position).z)
				var_599_3.localEulerAngles.z = 0
				var_599_3.localEulerAngles.x = 0
				var_599_3.localEulerAngles = var_599_3.localEulerAngles
			end

			local var_599_5 = arg_596_1.actors_["1042ui_story"]

			if 0 < arg_596_1.time_ and arg_596_1.time_ <= 0 + arg_599_0 and not isNil(var_599_5) and arg_596_1.var_.characterEffect1042ui_story == nil then
				arg_596_1.var_.characterEffect1042ui_story = var_599_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_599_6 = 0.200000002980232

			if 0 <= arg_596_1.time_ and arg_596_1.time_ < 0 + var_599_6 and not isNil(var_599_5) then
				if arg_596_1.var_.characterEffect1042ui_story and not isNil(var_599_5) then
					arg_596_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_596_1.time_ >= 0 + var_599_6 and arg_596_1.time_ < 0 + var_599_6 + arg_599_0 and not isNil(var_599_5) and arg_596_1.var_.characterEffect1042ui_story then
				arg_596_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			if 0 < arg_596_1.time_ and arg_596_1.time_ <= 0 + arg_599_0 then
				arg_596_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042action/1042action2_1")
			end

			if 0 < arg_596_1.time_ and arg_596_1.time_ <= 0 + arg_599_0 then
				arg_596_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_599_8 = 0
			local var_599_9 = 0.725

			if 0 < arg_596_1.time_ and arg_596_1.time_ <= var_599_8 + arg_599_0 then
				arg_596_1.talkMaxDuration = 0
				arg_596_1.dialogCg_.alpha = 1

				arg_596_1.dialog_:SetActive(true)
				SetActive(arg_596_1.leftNameGo_, true)

				arg_596_1.leftNameTxt_.text = arg_596_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_596_1.leftNameTxt_.transform)

				arg_596_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_596_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_596_1:RecordName(arg_596_1.leftNameTxt_.text)
				SetActive(arg_596_1.iconTrs_.gameObject, false)
				arg_596_1.callingController_:SetSelectedState("normal")

				local var_599_10 = arg_596_1:GetWordFromCfg(1109704143)
				local var_599_11 = arg_596_1:FormatText(var_599_10.content)

				arg_596_1.text_.text = var_599_11

				LuaForUtil.ClearLinePrefixSymbol(arg_596_1.text_)

				local var_599_13 = 29 <= 0 and var_599_9 or var_599_9 * (utf8.len(var_599_11) / 29)

				if (29 <= 0 and var_599_9 or var_599_9 * (utf8.len(var_599_11) / 29)) > 0 and var_599_9 < var_599_13 then
					arg_596_1.talkMaxDuration = var_599_13

					if var_599_13 + var_599_8 > arg_596_1.duration_ then
						arg_596_1.duration_ = var_599_13 + var_599_8
					end
				end

				arg_596_1.text_.text = var_599_11
				arg_596_1.typewritter.percent = 0

				arg_596_1.typewritter:SetDirty()
				arg_596_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704143", "story_v_side_new_1109704.awb") ~= 0 then
					local var_599_14 = manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704143", "story_v_side_new_1109704.awb") / 1000

					if var_599_14 + var_599_8 > arg_596_1.duration_ then
						arg_596_1.duration_ = var_599_14 + var_599_8
					end

					if var_599_10.prefab_name ~= "" and arg_596_1.actors_[var_599_10.prefab_name] ~= nil then
						local var_599_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_596_1.actors_[var_599_10.prefab_name].transform, "story_v_side_new_1109704", "1109704143", "story_v_side_new_1109704.awb")

						arg_596_1:RecordAudio("1109704143", var_599_15)
						arg_596_1:RecordAudio("1109704143", var_599_15)
					else
						arg_596_1:AudioAction("play", "voice", "story_v_side_new_1109704", "1109704143", "story_v_side_new_1109704.awb")
					end

					arg_596_1:RecordHistoryTalkVoice("story_v_side_new_1109704", "1109704143", "story_v_side_new_1109704.awb")
				end

				arg_596_1:RecordContent(arg_596_1.text_.text)
			end

			local var_599_16 = math.max(var_599_9, arg_596_1.talkMaxDuration)

			if var_599_8 <= arg_596_1.time_ and arg_596_1.time_ < var_599_8 + var_599_16 then
				arg_596_1.typewritter.percent = (arg_596_1.time_ - var_599_8) / var_599_16

				arg_596_1.typewritter:SetDirty()
			end

			if arg_596_1.time_ >= var_599_8 + var_599_16 and arg_596_1.time_ < var_599_8 + var_599_16 + arg_599_0 then
				arg_596_1.typewritter.percent = 1

				arg_596_1.typewritter:SetDirty()
				arg_596_1:ShowNextGo(true)
			end
		end

		arg_596_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1042ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_596_1:InitPlayNodeList()
	end,
	Play1109704144 = function(arg_600_0, arg_600_1)
		arg_600_1.time_ = 0
		arg_600_1.frameCnt_ = 0
		arg_600_1.state_ = "playing"
		arg_600_1.curTalkId_ = 1109704144
		arg_600_1.duration_ = 5

		SetActive(arg_600_1.tipsGo_, false)

		function arg_600_1.onSingleLineFinish_()
			arg_600_1.onSingleLineUpdate_ = nil
			arg_600_1.onSingleLineFinish_ = nil
			arg_600_1.state_ = "waiting"
		end

		function arg_600_1.playNext_(arg_602_0)
			if arg_602_0 == 1 then
				arg_600_0:Play1109704145(arg_600_1)
			end
		end

		function arg_600_1.onSingleLineUpdate_(arg_603_0)
			if 0 < arg_600_1.time_ and arg_600_1.time_ <= 0 + arg_603_0 and not isNil(arg_600_1.actors_["1042ui_story"]) and arg_600_1.var_.characterEffect1042ui_story == nil then
				arg_600_1.var_.characterEffect1042ui_story = arg_600_1.actors_["1042ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_603_0 = 0.200000002980232

			if 0 <= arg_600_1.time_ and arg_600_1.time_ < 0 + var_603_0 and not isNil(arg_600_1.actors_["1042ui_story"]) then
				if arg_600_1.var_.characterEffect1042ui_story and not isNil(arg_600_1.actors_["1042ui_story"]) then
					arg_600_1.var_.characterEffect1042ui_story.fillFlat = true
					arg_600_1.var_.characterEffect1042ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_600_1.time_ - 0) / var_603_0)
				end
			end

			if arg_600_1.time_ >= 0 + var_603_0 and arg_600_1.time_ < 0 + var_603_0 + arg_603_0 and not isNil(arg_600_1.actors_["1042ui_story"]) and arg_600_1.var_.characterEffect1042ui_story then
				arg_600_1.var_.characterEffect1042ui_story.fillFlat = true
				arg_600_1.var_.characterEffect1042ui_story.fillRatio = 0.5
			end

			local var_603_1 = 0
			local var_603_2 = 0.05

			if 0 < arg_600_1.time_ and arg_600_1.time_ <= var_603_1 + arg_603_0 then
				arg_600_1.talkMaxDuration = 0
				arg_600_1.dialogCg_.alpha = 1

				arg_600_1.dialog_:SetActive(true)
				SetActive(arg_600_1.leftNameGo_, true)

				arg_600_1.leftNameTxt_.text = arg_600_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_600_1.leftNameTxt_.transform)

				arg_600_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_600_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_600_1:RecordName(arg_600_1.leftNameTxt_.text)
				SetActive(arg_600_1.iconTrs_.gameObject, true)
				arg_600_1.iconController_:SetSelectedState("hero")

				arg_600_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_600_1.callingController_:SetSelectedState("normal")

				arg_600_1.keyicon_.color = Color.New(1, 1, 1)
				arg_600_1.icon_.color = Color.New(1, 1, 1)

				local var_603_3 = arg_600_1:FormatText(arg_600_1:GetWordFromCfg(1109704144).content)

				arg_600_1.text_.text = var_603_3

				LuaForUtil.ClearLinePrefixSymbol(arg_600_1.text_)

				local var_603_5 = 2 <= 0 and var_603_2 or var_603_2 * (utf8.len(var_603_3) / 2)

				if (2 <= 0 and var_603_2 or var_603_2 * (utf8.len(var_603_3) / 2)) > 0 and var_603_2 < var_603_5 then
					arg_600_1.talkMaxDuration = var_603_5

					if var_603_5 + var_603_1 > arg_600_1.duration_ then
						arg_600_1.duration_ = var_603_5 + var_603_1
					end
				end

				arg_600_1.text_.text = var_603_3
				arg_600_1.typewritter.percent = 0

				arg_600_1.typewritter:SetDirty()
				arg_600_1:ShowNextGo(false)
				arg_600_1:RecordContent(arg_600_1.text_.text)
			end

			local var_603_6 = math.max(var_603_2, arg_600_1.talkMaxDuration)

			if var_603_1 <= arg_600_1.time_ and arg_600_1.time_ < var_603_1 + var_603_6 then
				arg_600_1.typewritter.percent = (arg_600_1.time_ - var_603_1) / var_603_6

				arg_600_1.typewritter:SetDirty()
			end

			if arg_600_1.time_ >= var_603_1 + var_603_6 and arg_600_1.time_ < var_603_1 + var_603_6 + arg_603_0 then
				arg_600_1.typewritter.percent = 1

				arg_600_1.typewritter:SetDirty()
				arg_600_1:ShowNextGo(true)
			end
		end

		arg_600_1.nodeConfigList_ = {}

		arg_600_1:InitPlayNodeList()
	end,
	Play1109704145 = function(arg_604_0, arg_604_1)
		arg_604_1.time_ = 0
		arg_604_1.frameCnt_ = 0
		arg_604_1.state_ = "playing"
		arg_604_1.curTalkId_ = 1109704145
		arg_604_1.duration_ = 5

		SetActive(arg_604_1.tipsGo_, false)

		function arg_604_1.onSingleLineFinish_()
			arg_604_1.onSingleLineUpdate_ = nil
			arg_604_1.onSingleLineFinish_ = nil
			arg_604_1.state_ = "waiting"
		end

		function arg_604_1.playNext_(arg_606_0)
			if arg_606_0 == 1 then
				arg_604_0:Play1109704146(arg_604_1)
			end
		end

		function arg_604_1.onSingleLineUpdate_(arg_607_0)
			local var_607_0 = 1.275

			if 0 < arg_604_1.time_ and arg_604_1.time_ <= 0 + arg_607_0 then
				arg_604_1.talkMaxDuration = 0
				arg_604_1.dialogCg_.alpha = 1

				arg_604_1.dialog_:SetActive(true)
				SetActive(arg_604_1.leftNameGo_, false)

				arg_604_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_604_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_604_1:RecordName(arg_604_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_604_1.iconTrs_.gameObject, false)
				arg_604_1.callingController_:SetSelectedState("normal")

				local var_607_1 = arg_604_1:FormatText(arg_604_1:GetWordFromCfg(1109704145).content)

				arg_604_1.text_.text = var_607_1

				LuaForUtil.ClearLinePrefixSymbol(arg_604_1.text_)

				local var_607_3 = 51 <= 0 and var_607_0 or var_607_0 * (utf8.len(var_607_1) / 51)

				if (51 <= 0 and var_607_0 or var_607_0 * (utf8.len(var_607_1) / 51)) > 0 and var_607_0 < var_607_3 then
					arg_604_1.talkMaxDuration = var_607_3

					if var_607_3 + 0 > arg_604_1.duration_ then
						arg_604_1.duration_ = var_607_3 + 0
					end
				end

				arg_604_1.text_.text = var_607_1
				arg_604_1.typewritter.percent = 0

				arg_604_1.typewritter:SetDirty()
				arg_604_1:ShowNextGo(false)
				arg_604_1:RecordContent(arg_604_1.text_.text)
			end

			local var_607_4 = math.max(var_607_0, arg_604_1.talkMaxDuration)

			if 0 <= arg_604_1.time_ and arg_604_1.time_ < 0 + var_607_4 then
				arg_604_1.typewritter.percent = (arg_604_1.time_ - 0) / var_607_4

				arg_604_1.typewritter:SetDirty()
			end

			if arg_604_1.time_ >= 0 + var_607_4 and arg_604_1.time_ < 0 + var_607_4 + arg_607_0 then
				arg_604_1.typewritter.percent = 1

				arg_604_1.typewritter:SetDirty()
				arg_604_1:ShowNextGo(true)
			end
		end

		arg_604_1.nodeConfigList_ = {}

		arg_604_1:InitPlayNodeList()
	end,
	Play1109704146 = function(arg_608_0, arg_608_1)
		arg_608_1.time_ = 0
		arg_608_1.frameCnt_ = 0
		arg_608_1.state_ = "playing"
		arg_608_1.curTalkId_ = 1109704146
		arg_608_1.duration_ = 5

		SetActive(arg_608_1.tipsGo_, false)

		function arg_608_1.onSingleLineFinish_()
			arg_608_1.onSingleLineUpdate_ = nil
			arg_608_1.onSingleLineFinish_ = nil
			arg_608_1.state_ = "waiting"
		end

		function arg_608_1.playNext_(arg_610_0)
			if arg_610_0 == 1 then
				arg_608_0:Play1109704147(arg_608_1)
			end
		end

		function arg_608_1.onSingleLineUpdate_(arg_611_0)
			local var_611_0 = 0.75

			if 0 < arg_608_1.time_ and arg_608_1.time_ <= 0 + arg_611_0 then
				arg_608_1.talkMaxDuration = 0
				arg_608_1.dialogCg_.alpha = 1

				arg_608_1.dialog_:SetActive(true)
				SetActive(arg_608_1.leftNameGo_, true)

				arg_608_1.leftNameTxt_.text = arg_608_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_608_1.leftNameTxt_.transform)

				arg_608_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_608_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_608_1:RecordName(arg_608_1.leftNameTxt_.text)
				SetActive(arg_608_1.iconTrs_.gameObject, true)
				arg_608_1.iconController_:SetSelectedState("hero")

				arg_608_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_608_1.callingController_:SetSelectedState("normal")

				arg_608_1.keyicon_.color = Color.New(1, 1, 1)
				arg_608_1.icon_.color = Color.New(1, 1, 1)

				local var_611_1 = arg_608_1:FormatText(arg_608_1:GetWordFromCfg(1109704146).content)

				arg_608_1.text_.text = var_611_1

				LuaForUtil.ClearLinePrefixSymbol(arg_608_1.text_)

				local var_611_3 = 30 <= 0 and var_611_0 or var_611_0 * (utf8.len(var_611_1) / 30)

				if (30 <= 0 and var_611_0 or var_611_0 * (utf8.len(var_611_1) / 30)) > 0 and var_611_0 < var_611_3 then
					arg_608_1.talkMaxDuration = var_611_3

					if var_611_3 + 0 > arg_608_1.duration_ then
						arg_608_1.duration_ = var_611_3 + 0
					end
				end

				arg_608_1.text_.text = var_611_1
				arg_608_1.typewritter.percent = 0

				arg_608_1.typewritter:SetDirty()
				arg_608_1:ShowNextGo(false)
				arg_608_1:RecordContent(arg_608_1.text_.text)
			end

			local var_611_4 = math.max(var_611_0, arg_608_1.talkMaxDuration)

			if 0 <= arg_608_1.time_ and arg_608_1.time_ < 0 + var_611_4 then
				arg_608_1.typewritter.percent = (arg_608_1.time_ - 0) / var_611_4

				arg_608_1.typewritter:SetDirty()
			end

			if arg_608_1.time_ >= 0 + var_611_4 and arg_608_1.time_ < 0 + var_611_4 + arg_611_0 then
				arg_608_1.typewritter.percent = 1

				arg_608_1.typewritter:SetDirty()
				arg_608_1:ShowNextGo(true)
			end
		end

		arg_608_1.nodeConfigList_ = {}

		arg_608_1:InitPlayNodeList()
	end,
	Play1109704147 = function(arg_612_0, arg_612_1)
		arg_612_1.time_ = 0
		arg_612_1.frameCnt_ = 0
		arg_612_1.state_ = "playing"
		arg_612_1.curTalkId_ = 1109704147
		arg_612_1.duration_ = 8.83

		local var_612_0 = {
			zh = 8.8,
			ja = 8.833
		}
		local var_612_1 = manager.audio:GetLocalizationFlag()

		if var_612_0[var_612_1] ~= nil then
			arg_612_1.duration_ = var_612_0[var_612_1]
		end

		SetActive(arg_612_1.tipsGo_, false)

		function arg_612_1.onSingleLineFinish_()
			arg_612_1.onSingleLineUpdate_ = nil
			arg_612_1.onSingleLineFinish_ = nil
			arg_612_1.state_ = "waiting"
		end

		function arg_612_1.playNext_(arg_614_0)
			if arg_614_0 == 1 then
				arg_612_0:Play1109704148(arg_612_1)
			end
		end

		function arg_612_1.onSingleLineUpdate_(arg_615_0)
			if 0 < arg_612_1.time_ and arg_612_1.time_ <= 0 + arg_615_0 then
				arg_612_1.var_.moveOldPos1042ui_story = arg_612_1.actors_["1042ui_story"].transform.localPosition
			end

			local var_615_0 = 0.001

			if 0 <= arg_612_1.time_ and arg_612_1.time_ < 0 + var_615_0 then
				arg_612_1.actors_["1042ui_story"].transform.localPosition = Vector3.Lerp(arg_612_1.var_.moveOldPos1042ui_story, Vector3.New(0, -1.06, -6.2), (arg_612_1.time_ - 0) / var_615_0)
				arg_612_1.actors_["1042ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_612_1.actors_["1042ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_612_1.actors_["1042ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_612_1.actors_["1042ui_story"].transform.position).z)
				arg_612_1.actors_["1042ui_story"].transform.localEulerAngles.z = 0
				arg_612_1.actors_["1042ui_story"].transform.localEulerAngles.x = 0
				arg_612_1.actors_["1042ui_story"].transform.localEulerAngles = arg_612_1.actors_["1042ui_story"].transform.localEulerAngles
			end

			if arg_612_1.time_ >= 0 + var_615_0 and arg_612_1.time_ < 0 + var_615_0 + arg_615_0 then
				arg_612_1.actors_["1042ui_story"].transform.localPosition = Vector3.New(0, -1.06, -6.2)
				arg_612_1.actors_["1042ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_612_1.actors_["1042ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_612_1.actors_["1042ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_612_1.actors_["1042ui_story"].transform.position).z)
				arg_612_1.actors_["1042ui_story"].transform.localEulerAngles.z = 0
				arg_612_1.actors_["1042ui_story"].transform.localEulerAngles.x = 0
				arg_612_1.actors_["1042ui_story"].transform.localEulerAngles = arg_612_1.actors_["1042ui_story"].transform.localEulerAngles
			end

			local var_615_1 = arg_612_1.actors_["1042ui_story"]

			if 0 < arg_612_1.time_ and arg_612_1.time_ <= 0 + arg_615_0 and not isNil(var_615_1) and arg_612_1.var_.characterEffect1042ui_story == nil then
				arg_612_1.var_.characterEffect1042ui_story = var_615_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_615_2 = 0.200000002980232

			if 0 <= arg_612_1.time_ and arg_612_1.time_ < 0 + var_615_2 and not isNil(var_615_1) then
				if arg_612_1.var_.characterEffect1042ui_story and not isNil(var_615_1) then
					arg_612_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_612_1.time_ >= 0 + var_615_2 and arg_612_1.time_ < 0 + var_615_2 + arg_615_0 and not isNil(var_615_1) and arg_612_1.var_.characterEffect1042ui_story then
				arg_612_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			if 0 < arg_612_1.time_ and arg_612_1.time_ <= 0 + arg_615_0 then
				arg_612_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042action/1042action2_2")
			end

			if 0 < arg_612_1.time_ and arg_612_1.time_ <= 0 + arg_615_0 then
				arg_612_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_615_4 = 0
			local var_615_5 = 0.975

			if 0 < arg_612_1.time_ and arg_612_1.time_ <= var_615_4 + arg_615_0 then
				arg_612_1.talkMaxDuration = 0
				arg_612_1.dialogCg_.alpha = 1

				arg_612_1.dialog_:SetActive(true)
				SetActive(arg_612_1.leftNameGo_, true)

				arg_612_1.leftNameTxt_.text = arg_612_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_612_1.leftNameTxt_.transform)

				arg_612_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_612_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_612_1:RecordName(arg_612_1.leftNameTxt_.text)
				SetActive(arg_612_1.iconTrs_.gameObject, false)
				arg_612_1.callingController_:SetSelectedState("normal")

				local var_615_6 = arg_612_1:GetWordFromCfg(1109704147)
				local var_615_7 = arg_612_1:FormatText(var_615_6.content)

				arg_612_1.text_.text = var_615_7

				LuaForUtil.ClearLinePrefixSymbol(arg_612_1.text_)

				local var_615_9 = 39 <= 0 and var_615_5 or var_615_5 * (utf8.len(var_615_7) / 39)

				if (39 <= 0 and var_615_5 or var_615_5 * (utf8.len(var_615_7) / 39)) > 0 and var_615_5 < var_615_9 then
					arg_612_1.talkMaxDuration = var_615_9

					if var_615_9 + var_615_4 > arg_612_1.duration_ then
						arg_612_1.duration_ = var_615_9 + var_615_4
					end
				end

				arg_612_1.text_.text = var_615_7
				arg_612_1.typewritter.percent = 0

				arg_612_1.typewritter:SetDirty()
				arg_612_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704147", "story_v_side_new_1109704.awb") ~= 0 then
					local var_615_10 = manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704147", "story_v_side_new_1109704.awb") / 1000

					if var_615_10 + var_615_4 > arg_612_1.duration_ then
						arg_612_1.duration_ = var_615_10 + var_615_4
					end

					if var_615_6.prefab_name ~= "" and arg_612_1.actors_[var_615_6.prefab_name] ~= nil then
						local var_615_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_612_1.actors_[var_615_6.prefab_name].transform, "story_v_side_new_1109704", "1109704147", "story_v_side_new_1109704.awb")

						arg_612_1:RecordAudio("1109704147", var_615_11)
						arg_612_1:RecordAudio("1109704147", var_615_11)
					else
						arg_612_1:AudioAction("play", "voice", "story_v_side_new_1109704", "1109704147", "story_v_side_new_1109704.awb")
					end

					arg_612_1:RecordHistoryTalkVoice("story_v_side_new_1109704", "1109704147", "story_v_side_new_1109704.awb")
				end

				arg_612_1:RecordContent(arg_612_1.text_.text)
			end

			local var_615_12 = math.max(var_615_5, arg_612_1.talkMaxDuration)

			if var_615_4 <= arg_612_1.time_ and arg_612_1.time_ < var_615_4 + var_615_12 then
				arg_612_1.typewritter.percent = (arg_612_1.time_ - var_615_4) / var_615_12

				arg_612_1.typewritter:SetDirty()
			end

			if arg_612_1.time_ >= var_615_4 + var_615_12 and arg_612_1.time_ < var_615_4 + var_615_12 + arg_615_0 then
				arg_612_1.typewritter.percent = 1

				arg_612_1.typewritter:SetDirty()
				arg_612_1:ShowNextGo(true)
			end
		end

		arg_612_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1042ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_612_1:InitPlayNodeList()
	end,
	Play1109704148 = function(arg_616_0, arg_616_1)
		arg_616_1.time_ = 0
		arg_616_1.frameCnt_ = 0
		arg_616_1.state_ = "playing"
		arg_616_1.curTalkId_ = 1109704148
		arg_616_1.duration_ = 5

		SetActive(arg_616_1.tipsGo_, false)

		function arg_616_1.onSingleLineFinish_()
			arg_616_1.onSingleLineUpdate_ = nil
			arg_616_1.onSingleLineFinish_ = nil
			arg_616_1.state_ = "waiting"
		end

		function arg_616_1.playNext_(arg_618_0)
			if arg_618_0 == 1 then
				arg_616_0:Play1109704149(arg_616_1)
			end
		end

		function arg_616_1.onSingleLineUpdate_(arg_619_0)
			if 0 < arg_616_1.time_ and arg_616_1.time_ <= 0 + arg_619_0 and not isNil(arg_616_1.actors_["1042ui_story"]) and arg_616_1.var_.characterEffect1042ui_story == nil then
				arg_616_1.var_.characterEffect1042ui_story = arg_616_1.actors_["1042ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_619_0 = 0.200000002980232

			if 0 <= arg_616_1.time_ and arg_616_1.time_ < 0 + var_619_0 and not isNil(arg_616_1.actors_["1042ui_story"]) then
				if arg_616_1.var_.characterEffect1042ui_story and not isNil(arg_616_1.actors_["1042ui_story"]) then
					arg_616_1.var_.characterEffect1042ui_story.fillFlat = true
					arg_616_1.var_.characterEffect1042ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_616_1.time_ - 0) / var_619_0)
				end
			end

			if arg_616_1.time_ >= 0 + var_619_0 and arg_616_1.time_ < 0 + var_619_0 + arg_619_0 and not isNil(arg_616_1.actors_["1042ui_story"]) and arg_616_1.var_.characterEffect1042ui_story then
				arg_616_1.var_.characterEffect1042ui_story.fillFlat = true
				arg_616_1.var_.characterEffect1042ui_story.fillRatio = 0.5
			end

			local var_619_1 = 0
			local var_619_2 = 0.075

			if 0 < arg_616_1.time_ and arg_616_1.time_ <= var_619_1 + arg_619_0 then
				arg_616_1.talkMaxDuration = 0
				arg_616_1.dialogCg_.alpha = 1

				arg_616_1.dialog_:SetActive(true)
				SetActive(arg_616_1.leftNameGo_, true)

				arg_616_1.leftNameTxt_.text = arg_616_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_616_1.leftNameTxt_.transform)

				arg_616_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_616_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_616_1:RecordName(arg_616_1.leftNameTxt_.text)
				SetActive(arg_616_1.iconTrs_.gameObject, true)
				arg_616_1.iconController_:SetSelectedState("hero")

				arg_616_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_616_1.callingController_:SetSelectedState("normal")

				arg_616_1.keyicon_.color = Color.New(1, 1, 1)
				arg_616_1.icon_.color = Color.New(1, 1, 1)

				local var_619_3 = arg_616_1:FormatText(arg_616_1:GetWordFromCfg(1109704148).content)

				arg_616_1.text_.text = var_619_3

				LuaForUtil.ClearLinePrefixSymbol(arg_616_1.text_)

				local var_619_5 = 3 <= 0 and var_619_2 or var_619_2 * (utf8.len(var_619_3) / 3)

				if (3 <= 0 and var_619_2 or var_619_2 * (utf8.len(var_619_3) / 3)) > 0 and var_619_2 < var_619_5 then
					arg_616_1.talkMaxDuration = var_619_5

					if var_619_5 + var_619_1 > arg_616_1.duration_ then
						arg_616_1.duration_ = var_619_5 + var_619_1
					end
				end

				arg_616_1.text_.text = var_619_3
				arg_616_1.typewritter.percent = 0

				arg_616_1.typewritter:SetDirty()
				arg_616_1:ShowNextGo(false)
				arg_616_1:RecordContent(arg_616_1.text_.text)
			end

			local var_619_6 = math.max(var_619_2, arg_616_1.talkMaxDuration)

			if var_619_1 <= arg_616_1.time_ and arg_616_1.time_ < var_619_1 + var_619_6 then
				arg_616_1.typewritter.percent = (arg_616_1.time_ - var_619_1) / var_619_6

				arg_616_1.typewritter:SetDirty()
			end

			if arg_616_1.time_ >= var_619_1 + var_619_6 and arg_616_1.time_ < var_619_1 + var_619_6 + arg_619_0 then
				arg_616_1.typewritter.percent = 1

				arg_616_1.typewritter:SetDirty()
				arg_616_1:ShowNextGo(true)
			end
		end

		arg_616_1.nodeConfigList_ = {}

		arg_616_1:InitPlayNodeList()
	end,
	Play1109704149 = function(arg_620_0, arg_620_1)
		arg_620_1.time_ = 0
		arg_620_1.frameCnt_ = 0
		arg_620_1.state_ = "playing"
		arg_620_1.curTalkId_ = 1109704149
		arg_620_1.duration_ = 5

		SetActive(arg_620_1.tipsGo_, false)

		function arg_620_1.onSingleLineFinish_()
			arg_620_1.onSingleLineUpdate_ = nil
			arg_620_1.onSingleLineFinish_ = nil
			arg_620_1.state_ = "waiting"
		end

		function arg_620_1.playNext_(arg_622_0)
			if arg_622_0 == 1 then
				arg_620_0:Play1109704150(arg_620_1)
			end
		end

		function arg_620_1.onSingleLineUpdate_(arg_623_0)
			local var_623_0 = 1.475

			if 0 < arg_620_1.time_ and arg_620_1.time_ <= 0 + arg_623_0 then
				arg_620_1.talkMaxDuration = 0
				arg_620_1.dialogCg_.alpha = 1

				arg_620_1.dialog_:SetActive(true)
				SetActive(arg_620_1.leftNameGo_, false)

				arg_620_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_620_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_620_1:RecordName(arg_620_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_620_1.iconTrs_.gameObject, false)
				arg_620_1.callingController_:SetSelectedState("normal")

				local var_623_1 = arg_620_1:FormatText(arg_620_1:GetWordFromCfg(1109704149).content)

				arg_620_1.text_.text = var_623_1

				LuaForUtil.ClearLinePrefixSymbol(arg_620_1.text_)

				local var_623_3 = 59 <= 0 and var_623_0 or var_623_0 * (utf8.len(var_623_1) / 59)

				if (59 <= 0 and var_623_0 or var_623_0 * (utf8.len(var_623_1) / 59)) > 0 and var_623_0 < var_623_3 then
					arg_620_1.talkMaxDuration = var_623_3

					if var_623_3 + 0 > arg_620_1.duration_ then
						arg_620_1.duration_ = var_623_3 + 0
					end
				end

				arg_620_1.text_.text = var_623_1
				arg_620_1.typewritter.percent = 0

				arg_620_1.typewritter:SetDirty()
				arg_620_1:ShowNextGo(false)
				arg_620_1:RecordContent(arg_620_1.text_.text)
			end

			local var_623_4 = math.max(var_623_0, arg_620_1.talkMaxDuration)

			if 0 <= arg_620_1.time_ and arg_620_1.time_ < 0 + var_623_4 then
				arg_620_1.typewritter.percent = (arg_620_1.time_ - 0) / var_623_4

				arg_620_1.typewritter:SetDirty()
			end

			if arg_620_1.time_ >= 0 + var_623_4 and arg_620_1.time_ < 0 + var_623_4 + arg_623_0 then
				arg_620_1.typewritter.percent = 1

				arg_620_1.typewritter:SetDirty()
				arg_620_1:ShowNextGo(true)
			end
		end

		arg_620_1.nodeConfigList_ = {}

		arg_620_1:InitPlayNodeList()
	end,
	Play1109704150 = function(arg_624_0, arg_624_1)
		arg_624_1.time_ = 0
		arg_624_1.frameCnt_ = 0
		arg_624_1.state_ = "playing"
		arg_624_1.curTalkId_ = 1109704150
		arg_624_1.duration_ = 5

		SetActive(arg_624_1.tipsGo_, false)

		function arg_624_1.onSingleLineFinish_()
			arg_624_1.onSingleLineUpdate_ = nil
			arg_624_1.onSingleLineFinish_ = nil
			arg_624_1.state_ = "waiting"
		end

		function arg_624_1.playNext_(arg_626_0)
			if arg_626_0 == 1 then
				arg_624_0:Play1109704151(arg_624_1)
			end
		end

		function arg_624_1.onSingleLineUpdate_(arg_627_0)
			local var_627_0 = 0.625

			if 0 < arg_624_1.time_ and arg_624_1.time_ <= 0 + arg_627_0 then
				arg_624_1.talkMaxDuration = 0
				arg_624_1.dialogCg_.alpha = 1

				arg_624_1.dialog_:SetActive(true)
				SetActive(arg_624_1.leftNameGo_, true)

				arg_624_1.leftNameTxt_.text = arg_624_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_624_1.leftNameTxt_.transform)

				arg_624_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_624_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_624_1:RecordName(arg_624_1.leftNameTxt_.text)
				SetActive(arg_624_1.iconTrs_.gameObject, true)
				arg_624_1.iconController_:SetSelectedState("hero")

				arg_624_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_624_1.callingController_:SetSelectedState("normal")

				arg_624_1.keyicon_.color = Color.New(1, 1, 1)
				arg_624_1.icon_.color = Color.New(1, 1, 1)

				local var_627_1 = arg_624_1:FormatText(arg_624_1:GetWordFromCfg(1109704150).content)

				arg_624_1.text_.text = var_627_1

				LuaForUtil.ClearLinePrefixSymbol(arg_624_1.text_)

				local var_627_3 = 25 <= 0 and var_627_0 or var_627_0 * (utf8.len(var_627_1) / 25)

				if (25 <= 0 and var_627_0 or var_627_0 * (utf8.len(var_627_1) / 25)) > 0 and var_627_0 < var_627_3 then
					arg_624_1.talkMaxDuration = var_627_3

					if var_627_3 + 0 > arg_624_1.duration_ then
						arg_624_1.duration_ = var_627_3 + 0
					end
				end

				arg_624_1.text_.text = var_627_1
				arg_624_1.typewritter.percent = 0

				arg_624_1.typewritter:SetDirty()
				arg_624_1:ShowNextGo(false)
				arg_624_1:RecordContent(arg_624_1.text_.text)
			end

			local var_627_4 = math.max(var_627_0, arg_624_1.talkMaxDuration)

			if 0 <= arg_624_1.time_ and arg_624_1.time_ < 0 + var_627_4 then
				arg_624_1.typewritter.percent = (arg_624_1.time_ - 0) / var_627_4

				arg_624_1.typewritter:SetDirty()
			end

			if arg_624_1.time_ >= 0 + var_627_4 and arg_624_1.time_ < 0 + var_627_4 + arg_627_0 then
				arg_624_1.typewritter.percent = 1

				arg_624_1.typewritter:SetDirty()
				arg_624_1:ShowNextGo(true)
			end
		end

		arg_624_1.nodeConfigList_ = {}

		arg_624_1:InitPlayNodeList()
	end,
	Play1109704151 = function(arg_628_0, arg_628_1)
		arg_628_1.time_ = 0
		arg_628_1.frameCnt_ = 0
		arg_628_1.state_ = "playing"
		arg_628_1.curTalkId_ = 1109704151
		arg_628_1.duration_ = 3.5

		local var_628_0 = {
			zh = 3.4,
			ja = 3.5
		}
		local var_628_1 = manager.audio:GetLocalizationFlag()

		if var_628_0[var_628_1] ~= nil then
			arg_628_1.duration_ = var_628_0[var_628_1]
		end

		SetActive(arg_628_1.tipsGo_, false)

		function arg_628_1.onSingleLineFinish_()
			arg_628_1.onSingleLineUpdate_ = nil
			arg_628_1.onSingleLineFinish_ = nil
			arg_628_1.state_ = "waiting"
		end

		function arg_628_1.playNext_(arg_630_0)
			if arg_630_0 == 1 then
				arg_628_0:Play1109704152(arg_628_1)
			end
		end

		function arg_628_1.onSingleLineUpdate_(arg_631_0)
			if 0 < arg_628_1.time_ and arg_628_1.time_ <= 0 + arg_631_0 then
				arg_628_1.var_.moveOldPos1042ui_story = arg_628_1.actors_["1042ui_story"].transform.localPosition
			end

			local var_631_0 = 0.001

			if 0 <= arg_628_1.time_ and arg_628_1.time_ < 0 + var_631_0 then
				arg_628_1.actors_["1042ui_story"].transform.localPosition = Vector3.Lerp(arg_628_1.var_.moveOldPos1042ui_story, Vector3.New(0, -1.06, -6.2), (arg_628_1.time_ - 0) / var_631_0)
				arg_628_1.actors_["1042ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_628_1.actors_["1042ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_628_1.actors_["1042ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_628_1.actors_["1042ui_story"].transform.position).z)
				arg_628_1.actors_["1042ui_story"].transform.localEulerAngles.z = 0
				arg_628_1.actors_["1042ui_story"].transform.localEulerAngles.x = 0
				arg_628_1.actors_["1042ui_story"].transform.localEulerAngles = arg_628_1.actors_["1042ui_story"].transform.localEulerAngles
			end

			if arg_628_1.time_ >= 0 + var_631_0 and arg_628_1.time_ < 0 + var_631_0 + arg_631_0 then
				arg_628_1.actors_["1042ui_story"].transform.localPosition = Vector3.New(0, -1.06, -6.2)
				arg_628_1.actors_["1042ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_628_1.actors_["1042ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_628_1.actors_["1042ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_628_1.actors_["1042ui_story"].transform.position).z)
				arg_628_1.actors_["1042ui_story"].transform.localEulerAngles.z = 0
				arg_628_1.actors_["1042ui_story"].transform.localEulerAngles.x = 0
				arg_628_1.actors_["1042ui_story"].transform.localEulerAngles = arg_628_1.actors_["1042ui_story"].transform.localEulerAngles
			end

			local var_631_1 = arg_628_1.actors_["1042ui_story"]

			if 0 < arg_628_1.time_ and arg_628_1.time_ <= 0 + arg_631_0 and not isNil(var_631_1) and arg_628_1.var_.characterEffect1042ui_story == nil then
				arg_628_1.var_.characterEffect1042ui_story = var_631_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_631_2 = 0.200000002980232

			if 0 <= arg_628_1.time_ and arg_628_1.time_ < 0 + var_631_2 and not isNil(var_631_1) then
				if arg_628_1.var_.characterEffect1042ui_story and not isNil(var_631_1) then
					arg_628_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_628_1.time_ >= 0 + var_631_2 and arg_628_1.time_ < 0 + var_631_2 + arg_631_0 and not isNil(var_631_1) and arg_628_1.var_.characterEffect1042ui_story then
				arg_628_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			if 0 < arg_628_1.time_ and arg_628_1.time_ <= 0 + arg_631_0 then
				arg_628_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042action/1042action1_1")
			end

			if 0 < arg_628_1.time_ and arg_628_1.time_ <= 0 + arg_631_0 then
				arg_628_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_631_4 = 0
			local var_631_5 = 0.35

			if 0 < arg_628_1.time_ and arg_628_1.time_ <= var_631_4 + arg_631_0 then
				arg_628_1.talkMaxDuration = 0
				arg_628_1.dialogCg_.alpha = 1

				arg_628_1.dialog_:SetActive(true)
				SetActive(arg_628_1.leftNameGo_, true)

				arg_628_1.leftNameTxt_.text = arg_628_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_628_1.leftNameTxt_.transform)

				arg_628_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_628_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_628_1:RecordName(arg_628_1.leftNameTxt_.text)
				SetActive(arg_628_1.iconTrs_.gameObject, false)
				arg_628_1.callingController_:SetSelectedState("normal")

				local var_631_6 = arg_628_1:GetWordFromCfg(1109704151)
				local var_631_7 = arg_628_1:FormatText(var_631_6.content)

				arg_628_1.text_.text = var_631_7

				LuaForUtil.ClearLinePrefixSymbol(arg_628_1.text_)

				local var_631_9 = 14 <= 0 and var_631_5 or var_631_5 * (utf8.len(var_631_7) / 14)

				if (14 <= 0 and var_631_5 or var_631_5 * (utf8.len(var_631_7) / 14)) > 0 and var_631_5 < var_631_9 then
					arg_628_1.talkMaxDuration = var_631_9

					if var_631_9 + var_631_4 > arg_628_1.duration_ then
						arg_628_1.duration_ = var_631_9 + var_631_4
					end
				end

				arg_628_1.text_.text = var_631_7
				arg_628_1.typewritter.percent = 0

				arg_628_1.typewritter:SetDirty()
				arg_628_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704151", "story_v_side_new_1109704.awb") ~= 0 then
					local var_631_10 = manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704151", "story_v_side_new_1109704.awb") / 1000

					if var_631_10 + var_631_4 > arg_628_1.duration_ then
						arg_628_1.duration_ = var_631_10 + var_631_4
					end

					if var_631_6.prefab_name ~= "" and arg_628_1.actors_[var_631_6.prefab_name] ~= nil then
						local var_631_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_628_1.actors_[var_631_6.prefab_name].transform, "story_v_side_new_1109704", "1109704151", "story_v_side_new_1109704.awb")

						arg_628_1:RecordAudio("1109704151", var_631_11)
						arg_628_1:RecordAudio("1109704151", var_631_11)
					else
						arg_628_1:AudioAction("play", "voice", "story_v_side_new_1109704", "1109704151", "story_v_side_new_1109704.awb")
					end

					arg_628_1:RecordHistoryTalkVoice("story_v_side_new_1109704", "1109704151", "story_v_side_new_1109704.awb")
				end

				arg_628_1:RecordContent(arg_628_1.text_.text)
			end

			local var_631_12 = math.max(var_631_5, arg_628_1.talkMaxDuration)

			if var_631_4 <= arg_628_1.time_ and arg_628_1.time_ < var_631_4 + var_631_12 then
				arg_628_1.typewritter.percent = (arg_628_1.time_ - var_631_4) / var_631_12

				arg_628_1.typewritter:SetDirty()
			end

			if arg_628_1.time_ >= var_631_4 + var_631_12 and arg_628_1.time_ < var_631_4 + var_631_12 + arg_631_0 then
				arg_628_1.typewritter.percent = 1

				arg_628_1.typewritter:SetDirty()
				arg_628_1:ShowNextGo(true)
			end
		end

		arg_628_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1042ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_628_1:InitPlayNodeList()
	end,
	Play1109704152 = function(arg_632_0, arg_632_1)
		arg_632_1.time_ = 0
		arg_632_1.frameCnt_ = 0
		arg_632_1.state_ = "playing"
		arg_632_1.curTalkId_ = 1109704152
		arg_632_1.duration_ = 10.93

		local var_632_0 = {
			zh = 10.933,
			ja = 8.9
		}
		local var_632_1 = manager.audio:GetLocalizationFlag()

		if var_632_0[var_632_1] ~= nil then
			arg_632_1.duration_ = var_632_0[var_632_1]
		end

		SetActive(arg_632_1.tipsGo_, false)

		function arg_632_1.onSingleLineFinish_()
			arg_632_1.onSingleLineUpdate_ = nil
			arg_632_1.onSingleLineFinish_ = nil
			arg_632_1.state_ = "waiting"
		end

		function arg_632_1.playNext_(arg_634_0)
			if arg_634_0 == 1 then
				arg_632_0:Play1109704153(arg_632_1)
			end
		end

		function arg_632_1.onSingleLineUpdate_(arg_635_0)
			if 0 < arg_632_1.time_ and arg_632_1.time_ <= 0 + arg_635_0 then
				arg_632_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042action/1042action6_1")
			end

			if 0 < arg_632_1.time_ and arg_632_1.time_ <= 0 + arg_635_0 then
				arg_632_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_635_0 = 0
			local var_635_1 = 1.225

			if 0 < arg_632_1.time_ and arg_632_1.time_ <= var_635_0 + arg_635_0 then
				arg_632_1.talkMaxDuration = 0
				arg_632_1.dialogCg_.alpha = 1

				arg_632_1.dialog_:SetActive(true)
				SetActive(arg_632_1.leftNameGo_, true)

				arg_632_1.leftNameTxt_.text = arg_632_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_632_1.leftNameTxt_.transform)

				arg_632_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_632_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_632_1:RecordName(arg_632_1.leftNameTxt_.text)
				SetActive(arg_632_1.iconTrs_.gameObject, false)
				arg_632_1.callingController_:SetSelectedState("normal")

				local var_635_2 = arg_632_1:GetWordFromCfg(1109704152)
				local var_635_3 = arg_632_1:FormatText(var_635_2.content)

				arg_632_1.text_.text = var_635_3

				LuaForUtil.ClearLinePrefixSymbol(arg_632_1.text_)

				local var_635_5 = 49 <= 0 and var_635_1 or var_635_1 * (utf8.len(var_635_3) / 49)

				if (49 <= 0 and var_635_1 or var_635_1 * (utf8.len(var_635_3) / 49)) > 0 and var_635_1 < var_635_5 then
					arg_632_1.talkMaxDuration = var_635_5

					if var_635_5 + var_635_0 > arg_632_1.duration_ then
						arg_632_1.duration_ = var_635_5 + var_635_0
					end
				end

				arg_632_1.text_.text = var_635_3
				arg_632_1.typewritter.percent = 0

				arg_632_1.typewritter:SetDirty()
				arg_632_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704152", "story_v_side_new_1109704.awb") ~= 0 then
					local var_635_6 = manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704152", "story_v_side_new_1109704.awb") / 1000

					if var_635_6 + var_635_0 > arg_632_1.duration_ then
						arg_632_1.duration_ = var_635_6 + var_635_0
					end

					if var_635_2.prefab_name ~= "" and arg_632_1.actors_[var_635_2.prefab_name] ~= nil then
						local var_635_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_632_1.actors_[var_635_2.prefab_name].transform, "story_v_side_new_1109704", "1109704152", "story_v_side_new_1109704.awb")

						arg_632_1:RecordAudio("1109704152", var_635_7)
						arg_632_1:RecordAudio("1109704152", var_635_7)
					else
						arg_632_1:AudioAction("play", "voice", "story_v_side_new_1109704", "1109704152", "story_v_side_new_1109704.awb")
					end

					arg_632_1:RecordHistoryTalkVoice("story_v_side_new_1109704", "1109704152", "story_v_side_new_1109704.awb")
				end

				arg_632_1:RecordContent(arg_632_1.text_.text)
			end

			local var_635_8 = math.max(var_635_1, arg_632_1.talkMaxDuration)

			if var_635_0 <= arg_632_1.time_ and arg_632_1.time_ < var_635_0 + var_635_8 then
				arg_632_1.typewritter.percent = (arg_632_1.time_ - var_635_0) / var_635_8

				arg_632_1.typewritter:SetDirty()
			end

			if arg_632_1.time_ >= var_635_0 + var_635_8 and arg_632_1.time_ < var_635_0 + var_635_8 + arg_635_0 then
				arg_632_1.typewritter.percent = 1

				arg_632_1.typewritter:SetDirty()
				arg_632_1:ShowNextGo(true)
			end
		end

		arg_632_1.nodeConfigList_ = {}

		arg_632_1:InitPlayNodeList()
	end,
	Play1109704153 = function(arg_636_0, arg_636_1)
		arg_636_1.time_ = 0
		arg_636_1.frameCnt_ = 0
		arg_636_1.state_ = "playing"
		arg_636_1.curTalkId_ = 1109704153
		arg_636_1.duration_ = 5

		SetActive(arg_636_1.tipsGo_, false)

		function arg_636_1.onSingleLineFinish_()
			arg_636_1.onSingleLineUpdate_ = nil
			arg_636_1.onSingleLineFinish_ = nil
			arg_636_1.state_ = "waiting"
		end

		function arg_636_1.playNext_(arg_638_0)
			if arg_638_0 == 1 then
				arg_636_0:Play1109704154(arg_636_1)
			end
		end

		function arg_636_1.onSingleLineUpdate_(arg_639_0)
			if 0 < arg_636_1.time_ and arg_636_1.time_ <= 0 + arg_639_0 and not isNil(arg_636_1.actors_["1042ui_story"]) and arg_636_1.var_.characterEffect1042ui_story == nil then
				arg_636_1.var_.characterEffect1042ui_story = arg_636_1.actors_["1042ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_639_0 = 0.200000002980232

			if 0 <= arg_636_1.time_ and arg_636_1.time_ < 0 + var_639_0 and not isNil(arg_636_1.actors_["1042ui_story"]) then
				if arg_636_1.var_.characterEffect1042ui_story and not isNil(arg_636_1.actors_["1042ui_story"]) then
					arg_636_1.var_.characterEffect1042ui_story.fillFlat = true
					arg_636_1.var_.characterEffect1042ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_636_1.time_ - 0) / var_639_0)
				end
			end

			if arg_636_1.time_ >= 0 + var_639_0 and arg_636_1.time_ < 0 + var_639_0 + arg_639_0 and not isNil(arg_636_1.actors_["1042ui_story"]) and arg_636_1.var_.characterEffect1042ui_story then
				arg_636_1.var_.characterEffect1042ui_story.fillFlat = true
				arg_636_1.var_.characterEffect1042ui_story.fillRatio = 0.5
			end

			local var_639_1 = 0
			local var_639_2 = 0.3

			if 0 < arg_636_1.time_ and arg_636_1.time_ <= var_639_1 + arg_639_0 then
				arg_636_1.talkMaxDuration = 0
				arg_636_1.dialogCg_.alpha = 1

				arg_636_1.dialog_:SetActive(true)
				SetActive(arg_636_1.leftNameGo_, true)

				arg_636_1.leftNameTxt_.text = arg_636_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_636_1.leftNameTxt_.transform)

				arg_636_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_636_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_636_1:RecordName(arg_636_1.leftNameTxt_.text)
				SetActive(arg_636_1.iconTrs_.gameObject, true)
				arg_636_1.iconController_:SetSelectedState("hero")

				arg_636_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_636_1.callingController_:SetSelectedState("normal")

				arg_636_1.keyicon_.color = Color.New(1, 1, 1)
				arg_636_1.icon_.color = Color.New(1, 1, 1)

				local var_639_3 = arg_636_1:FormatText(arg_636_1:GetWordFromCfg(1109704153).content)

				arg_636_1.text_.text = var_639_3

				LuaForUtil.ClearLinePrefixSymbol(arg_636_1.text_)

				local var_639_5 = 12 <= 0 and var_639_2 or var_639_2 * (utf8.len(var_639_3) / 12)

				if (12 <= 0 and var_639_2 or var_639_2 * (utf8.len(var_639_3) / 12)) > 0 and var_639_2 < var_639_5 then
					arg_636_1.talkMaxDuration = var_639_5

					if var_639_5 + var_639_1 > arg_636_1.duration_ then
						arg_636_1.duration_ = var_639_5 + var_639_1
					end
				end

				arg_636_1.text_.text = var_639_3
				arg_636_1.typewritter.percent = 0

				arg_636_1.typewritter:SetDirty()
				arg_636_1:ShowNextGo(false)
				arg_636_1:RecordContent(arg_636_1.text_.text)
			end

			local var_639_6 = math.max(var_639_2, arg_636_1.talkMaxDuration)

			if var_639_1 <= arg_636_1.time_ and arg_636_1.time_ < var_639_1 + var_639_6 then
				arg_636_1.typewritter.percent = (arg_636_1.time_ - var_639_1) / var_639_6

				arg_636_1.typewritter:SetDirty()
			end

			if arg_636_1.time_ >= var_639_1 + var_639_6 and arg_636_1.time_ < var_639_1 + var_639_6 + arg_639_0 then
				arg_636_1.typewritter.percent = 1

				arg_636_1.typewritter:SetDirty()
				arg_636_1:ShowNextGo(true)
			end
		end

		arg_636_1.nodeConfigList_ = {}

		arg_636_1:InitPlayNodeList()
	end,
	Play1109704154 = function(arg_640_0, arg_640_1)
		arg_640_1.time_ = 0
		arg_640_1.frameCnt_ = 0
		arg_640_1.state_ = "playing"
		arg_640_1.curTalkId_ = 1109704154
		arg_640_1.duration_ = 5

		SetActive(arg_640_1.tipsGo_, false)

		function arg_640_1.onSingleLineFinish_()
			arg_640_1.onSingleLineUpdate_ = nil
			arg_640_1.onSingleLineFinish_ = nil
			arg_640_1.state_ = "waiting"
		end

		function arg_640_1.playNext_(arg_642_0)
			if arg_642_0 == 1 then
				arg_640_0:Play1109704155(arg_640_1)
			end
		end

		function arg_640_1.onSingleLineUpdate_(arg_643_0)
			if 0 < arg_640_1.time_ and arg_640_1.time_ <= 0 + arg_643_0 then
				arg_640_1.var_.moveOldPos1042ui_story = arg_640_1.actors_["1042ui_story"].transform.localPosition
			end

			local var_643_0 = 0.001

			if 0 <= arg_640_1.time_ and arg_640_1.time_ < 0 + var_643_0 then
				arg_640_1.actors_["1042ui_story"].transform.localPosition = Vector3.Lerp(arg_640_1.var_.moveOldPos1042ui_story, Vector3.New(0, 100, 0), (arg_640_1.time_ - 0) / var_643_0)
				arg_640_1.actors_["1042ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_640_1.actors_["1042ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_640_1.actors_["1042ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_640_1.actors_["1042ui_story"].transform.position).z)
				arg_640_1.actors_["1042ui_story"].transform.localEulerAngles.z = 0
				arg_640_1.actors_["1042ui_story"].transform.localEulerAngles.x = 0
				arg_640_1.actors_["1042ui_story"].transform.localEulerAngles = arg_640_1.actors_["1042ui_story"].transform.localEulerAngles
			end

			if arg_640_1.time_ >= 0 + var_643_0 and arg_640_1.time_ < 0 + var_643_0 + arg_643_0 then
				arg_640_1.actors_["1042ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_640_1.actors_["1042ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_640_1.actors_["1042ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_640_1.actors_["1042ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_640_1.actors_["1042ui_story"].transform.position).z)
				arg_640_1.actors_["1042ui_story"].transform.localEulerAngles.z = 0
				arg_640_1.actors_["1042ui_story"].transform.localEulerAngles.x = 0
				arg_640_1.actors_["1042ui_story"].transform.localEulerAngles = arg_640_1.actors_["1042ui_story"].transform.localEulerAngles
			end

			local var_643_1 = arg_640_1.actors_["1042ui_story"]

			if 0 < arg_640_1.time_ and arg_640_1.time_ <= 0 + arg_643_0 and not isNil(var_643_1) and arg_640_1.var_.characterEffect1042ui_story == nil then
				arg_640_1.var_.characterEffect1042ui_story = var_643_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_643_2 = 0.200000002980232

			if 0 <= arg_640_1.time_ and arg_640_1.time_ < 0 + var_643_2 and not isNil(var_643_1) then
				if arg_640_1.var_.characterEffect1042ui_story and not isNil(var_643_1) then
					arg_640_1.var_.characterEffect1042ui_story.fillFlat = true
					arg_640_1.var_.characterEffect1042ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_640_1.time_ - 0) / var_643_2)
				end
			end

			if arg_640_1.time_ >= 0 + var_643_2 and arg_640_1.time_ < 0 + var_643_2 + arg_643_0 and not isNil(var_643_1) and arg_640_1.var_.characterEffect1042ui_story then
				arg_640_1.var_.characterEffect1042ui_story.fillFlat = true
				arg_640_1.var_.characterEffect1042ui_story.fillRatio = 0.5
			end

			local var_643_3 = 0
			local var_643_4 = 0.6

			if 0 < arg_640_1.time_ and arg_640_1.time_ <= var_643_3 + arg_643_0 then
				arg_640_1.talkMaxDuration = 0
				arg_640_1.dialogCg_.alpha = 1

				arg_640_1.dialog_:SetActive(true)
				SetActive(arg_640_1.leftNameGo_, false)

				arg_640_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_640_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_640_1:RecordName(arg_640_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_640_1.iconTrs_.gameObject, false)
				arg_640_1.callingController_:SetSelectedState("normal")

				local var_643_5 = arg_640_1:FormatText(arg_640_1:GetWordFromCfg(1109704154).content)

				arg_640_1.text_.text = var_643_5

				LuaForUtil.ClearLinePrefixSymbol(arg_640_1.text_)

				local var_643_7 = 24 <= 0 and var_643_4 or var_643_4 * (utf8.len(var_643_5) / 24)

				if (24 <= 0 and var_643_4 or var_643_4 * (utf8.len(var_643_5) / 24)) > 0 and var_643_4 < var_643_7 then
					arg_640_1.talkMaxDuration = var_643_7

					if var_643_7 + var_643_3 > arg_640_1.duration_ then
						arg_640_1.duration_ = var_643_7 + var_643_3
					end
				end

				arg_640_1.text_.text = var_643_5
				arg_640_1.typewritter.percent = 0

				arg_640_1.typewritter:SetDirty()
				arg_640_1:ShowNextGo(false)
				arg_640_1:RecordContent(arg_640_1.text_.text)
			end

			local var_643_8 = math.max(var_643_4, arg_640_1.talkMaxDuration)

			if var_643_3 <= arg_640_1.time_ and arg_640_1.time_ < var_643_3 + var_643_8 then
				arg_640_1.typewritter.percent = (arg_640_1.time_ - var_643_3) / var_643_8

				arg_640_1.typewritter:SetDirty()
			end

			if arg_640_1.time_ >= var_643_3 + var_643_8 and arg_640_1.time_ < var_643_3 + var_643_8 + arg_643_0 then
				arg_640_1.typewritter.percent = 1

				arg_640_1.typewritter:SetDirty()
				arg_640_1:ShowNextGo(true)
			end
		end

		arg_640_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1042ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_640_1:InitPlayNodeList()
	end,
	Play1109704155 = function(arg_644_0, arg_644_1)
		arg_644_1.time_ = 0
		arg_644_1.frameCnt_ = 0
		arg_644_1.state_ = "playing"
		arg_644_1.curTalkId_ = 1109704155
		arg_644_1.duration_ = 8.93

		local var_644_0 = {
			zh = 8.933,
			ja = 7
		}
		local var_644_1 = manager.audio:GetLocalizationFlag()

		if var_644_0[var_644_1] ~= nil then
			arg_644_1.duration_ = var_644_0[var_644_1]
		end

		SetActive(arg_644_1.tipsGo_, false)

		function arg_644_1.onSingleLineFinish_()
			arg_644_1.onSingleLineUpdate_ = nil
			arg_644_1.onSingleLineFinish_ = nil
			arg_644_1.state_ = "waiting"
		end

		function arg_644_1.playNext_(arg_646_0)
			if arg_646_0 == 1 then
				arg_644_0:Play1109704156(arg_644_1)
			end
		end

		function arg_644_1.onSingleLineUpdate_(arg_647_0)
			if 0 < arg_644_1.time_ and arg_644_1.time_ <= 0 + arg_647_0 then
				arg_644_1.var_.moveOldPos1097ui_story = arg_644_1.actors_["1097ui_story"].transform.localPosition
			end

			local var_647_0 = 0.001

			if 0 <= arg_644_1.time_ and arg_644_1.time_ < 0 + var_647_0 then
				arg_644_1.actors_["1097ui_story"].transform.localPosition = Vector3.Lerp(arg_644_1.var_.moveOldPos1097ui_story, Vector3.New(0, -0.54, -6.3), (arg_644_1.time_ - 0) / var_647_0)
				arg_644_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_644_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_644_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_644_1.actors_["1097ui_story"].transform.position).z)
				arg_644_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_644_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_644_1.actors_["1097ui_story"].transform.localEulerAngles = arg_644_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			if arg_644_1.time_ >= 0 + var_647_0 and arg_644_1.time_ < 0 + var_647_0 + arg_647_0 then
				arg_644_1.actors_["1097ui_story"].transform.localPosition = Vector3.New(0, -0.54, -6.3)
				arg_644_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_644_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_644_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_644_1.actors_["1097ui_story"].transform.position).z)
				arg_644_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_644_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_644_1.actors_["1097ui_story"].transform.localEulerAngles = arg_644_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			local var_647_1 = arg_644_1.actors_["1097ui_story"]

			if 0 < arg_644_1.time_ and arg_644_1.time_ <= 0 + arg_647_0 and not isNil(var_647_1) and arg_644_1.var_.characterEffect1097ui_story == nil then
				arg_644_1.var_.characterEffect1097ui_story = var_647_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_647_2 = 0.200000002980232

			if 0 <= arg_644_1.time_ and arg_644_1.time_ < 0 + var_647_2 and not isNil(var_647_1) then
				if arg_644_1.var_.characterEffect1097ui_story and not isNil(var_647_1) then
					arg_644_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_644_1.time_ >= 0 + var_647_2 and arg_644_1.time_ < 0 + var_647_2 + arg_647_0 and not isNil(var_647_1) and arg_644_1.var_.characterEffect1097ui_story then
				arg_644_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_644_1.time_ and arg_644_1.time_ <= 0 + arg_647_0 then
				arg_644_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			if 0 < arg_644_1.time_ and arg_644_1.time_ <= 0 + arg_647_0 then
				arg_644_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_647_4 = 0
			local var_647_5 = 0.775

			if 0 < arg_644_1.time_ and arg_644_1.time_ <= var_647_4 + arg_647_0 then
				arg_644_1.talkMaxDuration = 0
				arg_644_1.dialogCg_.alpha = 1

				arg_644_1.dialog_:SetActive(true)
				SetActive(arg_644_1.leftNameGo_, true)

				arg_644_1.leftNameTxt_.text = arg_644_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_644_1.leftNameTxt_.transform)

				arg_644_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_644_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_644_1:RecordName(arg_644_1.leftNameTxt_.text)
				SetActive(arg_644_1.iconTrs_.gameObject, false)
				arg_644_1.callingController_:SetSelectedState("normal")

				local var_647_6 = arg_644_1:GetWordFromCfg(1109704155)
				local var_647_7 = arg_644_1:FormatText(var_647_6.content)

				arg_644_1.text_.text = var_647_7

				LuaForUtil.ClearLinePrefixSymbol(arg_644_1.text_)

				local var_647_9 = 31 <= 0 and var_647_5 or var_647_5 * (utf8.len(var_647_7) / 31)

				if (31 <= 0 and var_647_5 or var_647_5 * (utf8.len(var_647_7) / 31)) > 0 and var_647_5 < var_647_9 then
					arg_644_1.talkMaxDuration = var_647_9

					if var_647_9 + var_647_4 > arg_644_1.duration_ then
						arg_644_1.duration_ = var_647_9 + var_647_4
					end
				end

				arg_644_1.text_.text = var_647_7
				arg_644_1.typewritter.percent = 0

				arg_644_1.typewritter:SetDirty()
				arg_644_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704155", "story_v_side_new_1109704.awb") ~= 0 then
					local var_647_10 = manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704155", "story_v_side_new_1109704.awb") / 1000

					if var_647_10 + var_647_4 > arg_644_1.duration_ then
						arg_644_1.duration_ = var_647_10 + var_647_4
					end

					if var_647_6.prefab_name ~= "" and arg_644_1.actors_[var_647_6.prefab_name] ~= nil then
						local var_647_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_644_1.actors_[var_647_6.prefab_name].transform, "story_v_side_new_1109704", "1109704155", "story_v_side_new_1109704.awb")

						arg_644_1:RecordAudio("1109704155", var_647_11)
						arg_644_1:RecordAudio("1109704155", var_647_11)
					else
						arg_644_1:AudioAction("play", "voice", "story_v_side_new_1109704", "1109704155", "story_v_side_new_1109704.awb")
					end

					arg_644_1:RecordHistoryTalkVoice("story_v_side_new_1109704", "1109704155", "story_v_side_new_1109704.awb")
				end

				arg_644_1:RecordContent(arg_644_1.text_.text)
			end

			local var_647_12 = math.max(var_647_5, arg_644_1.talkMaxDuration)

			if var_647_4 <= arg_644_1.time_ and arg_644_1.time_ < var_647_4 + var_647_12 then
				arg_644_1.typewritter.percent = (arg_644_1.time_ - var_647_4) / var_647_12

				arg_644_1.typewritter:SetDirty()
			end

			if arg_644_1.time_ >= var_647_4 + var_647_12 and arg_644_1.time_ < var_647_4 + var_647_12 + arg_647_0 then
				arg_644_1.typewritter.percent = 1

				arg_644_1.typewritter:SetDirty()
				arg_644_1:ShowNextGo(true)
			end
		end

		arg_644_1.nodeConfigList_ = {
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

		arg_644_1:InitPlayNodeList()
	end,
	Play1109704156 = function(arg_648_0, arg_648_1)
		arg_648_1.time_ = 0
		arg_648_1.frameCnt_ = 0
		arg_648_1.state_ = "playing"
		arg_648_1.curTalkId_ = 1109704156
		arg_648_1.duration_ = 5

		SetActive(arg_648_1.tipsGo_, false)

		function arg_648_1.onSingleLineFinish_()
			arg_648_1.onSingleLineUpdate_ = nil
			arg_648_1.onSingleLineFinish_ = nil
			arg_648_1.state_ = "waiting"
		end

		function arg_648_1.playNext_(arg_650_0)
			if arg_650_0 == 1 then
				arg_648_0:Play1109704157(arg_648_1)
			end
		end

		function arg_648_1.onSingleLineUpdate_(arg_651_0)
			if 0 < arg_648_1.time_ and arg_648_1.time_ <= 0 + arg_651_0 and not isNil(arg_648_1.actors_["1097ui_story"]) and arg_648_1.var_.characterEffect1097ui_story == nil then
				arg_648_1.var_.characterEffect1097ui_story = arg_648_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_651_0 = 0.200000002980232

			if 0 <= arg_648_1.time_ and arg_648_1.time_ < 0 + var_651_0 and not isNil(arg_648_1.actors_["1097ui_story"]) then
				if arg_648_1.var_.characterEffect1097ui_story and not isNil(arg_648_1.actors_["1097ui_story"]) then
					arg_648_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_648_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_648_1.time_ - 0) / var_651_0)
				end
			end

			if arg_648_1.time_ >= 0 + var_651_0 and arg_648_1.time_ < 0 + var_651_0 + arg_651_0 and not isNil(arg_648_1.actors_["1097ui_story"]) and arg_648_1.var_.characterEffect1097ui_story then
				arg_648_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_648_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_651_1 = 0
			local var_651_2 = 0.275

			if 0 < arg_648_1.time_ and arg_648_1.time_ <= var_651_1 + arg_651_0 then
				arg_648_1.talkMaxDuration = 0
				arg_648_1.dialogCg_.alpha = 1

				arg_648_1.dialog_:SetActive(true)
				SetActive(arg_648_1.leftNameGo_, true)

				arg_648_1.leftNameTxt_.text = arg_648_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_648_1.leftNameTxt_.transform)

				arg_648_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_648_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_648_1:RecordName(arg_648_1.leftNameTxt_.text)
				SetActive(arg_648_1.iconTrs_.gameObject, true)
				arg_648_1.iconController_:SetSelectedState("hero")

				arg_648_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_648_1.callingController_:SetSelectedState("normal")

				arg_648_1.keyicon_.color = Color.New(1, 1, 1)
				arg_648_1.icon_.color = Color.New(1, 1, 1)

				local var_651_3 = arg_648_1:FormatText(arg_648_1:GetWordFromCfg(1109704156).content)

				arg_648_1.text_.text = var_651_3

				LuaForUtil.ClearLinePrefixSymbol(arg_648_1.text_)

				local var_651_5 = 11 <= 0 and var_651_2 or var_651_2 * (utf8.len(var_651_3) / 11)

				if (11 <= 0 and var_651_2 or var_651_2 * (utf8.len(var_651_3) / 11)) > 0 and var_651_2 < var_651_5 then
					arg_648_1.talkMaxDuration = var_651_5

					if var_651_5 + var_651_1 > arg_648_1.duration_ then
						arg_648_1.duration_ = var_651_5 + var_651_1
					end
				end

				arg_648_1.text_.text = var_651_3
				arg_648_1.typewritter.percent = 0

				arg_648_1.typewritter:SetDirty()
				arg_648_1:ShowNextGo(false)
				arg_648_1:RecordContent(arg_648_1.text_.text)
			end

			local var_651_6 = math.max(var_651_2, arg_648_1.talkMaxDuration)

			if var_651_1 <= arg_648_1.time_ and arg_648_1.time_ < var_651_1 + var_651_6 then
				arg_648_1.typewritter.percent = (arg_648_1.time_ - var_651_1) / var_651_6

				arg_648_1.typewritter:SetDirty()
			end

			if arg_648_1.time_ >= var_651_1 + var_651_6 and arg_648_1.time_ < var_651_1 + var_651_6 + arg_651_0 then
				arg_648_1.typewritter.percent = 1

				arg_648_1.typewritter:SetDirty()
				arg_648_1:ShowNextGo(true)
			end
		end

		arg_648_1.nodeConfigList_ = {}

		arg_648_1:InitPlayNodeList()
	end,
	Play1109704157 = function(arg_652_0, arg_652_1)
		arg_652_1.time_ = 0
		arg_652_1.frameCnt_ = 0
		arg_652_1.state_ = "playing"
		arg_652_1.curTalkId_ = 1109704157
		arg_652_1.duration_ = 2.3

		local var_652_0 = {
			zh = 2.3,
			ja = 2
		}
		local var_652_1 = manager.audio:GetLocalizationFlag()

		if var_652_0[var_652_1] ~= nil then
			arg_652_1.duration_ = var_652_0[var_652_1]
		end

		SetActive(arg_652_1.tipsGo_, false)

		function arg_652_1.onSingleLineFinish_()
			arg_652_1.onSingleLineUpdate_ = nil
			arg_652_1.onSingleLineFinish_ = nil
			arg_652_1.state_ = "waiting"
		end

		function arg_652_1.playNext_(arg_654_0)
			if arg_654_0 == 1 then
				arg_652_0:Play1109704158(arg_652_1)
			end
		end

		function arg_652_1.onSingleLineUpdate_(arg_655_0)
			if 0 < arg_652_1.time_ and arg_652_1.time_ <= 0 + arg_655_0 and not isNil(arg_652_1.actors_["1097ui_story"]) and arg_652_1.var_.characterEffect1097ui_story == nil then
				arg_652_1.var_.characterEffect1097ui_story = arg_652_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_655_0 = 0.200000002980232

			if 0 <= arg_652_1.time_ and arg_652_1.time_ < 0 + var_655_0 and not isNil(arg_652_1.actors_["1097ui_story"]) then
				if arg_652_1.var_.characterEffect1097ui_story and not isNil(arg_652_1.actors_["1097ui_story"]) then
					arg_652_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_652_1.time_ >= 0 + var_655_0 and arg_652_1.time_ < 0 + var_655_0 + arg_655_0 and not isNil(arg_652_1.actors_["1097ui_story"]) and arg_652_1.var_.characterEffect1097ui_story then
				arg_652_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_652_1.time_ and arg_652_1.time_ <= 0 + arg_655_0 then
				arg_652_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			if 0 < arg_652_1.time_ and arg_652_1.time_ <= 0 + arg_655_0 then
				arg_652_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_655_2 = 0
			local var_655_3 = 0.425

			if 0 < arg_652_1.time_ and arg_652_1.time_ <= var_655_2 + arg_655_0 then
				arg_652_1.talkMaxDuration = 0
				arg_652_1.dialogCg_.alpha = 1

				arg_652_1.dialog_:SetActive(true)
				SetActive(arg_652_1.leftNameGo_, true)

				arg_652_1.leftNameTxt_.text = arg_652_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_652_1.leftNameTxt_.transform)

				arg_652_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_652_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_652_1:RecordName(arg_652_1.leftNameTxt_.text)
				SetActive(arg_652_1.iconTrs_.gameObject, false)
				arg_652_1.callingController_:SetSelectedState("normal")

				local var_655_4 = arg_652_1:GetWordFromCfg(1109704157)
				local var_655_5 = arg_652_1:FormatText(var_655_4.content)

				arg_652_1.text_.text = var_655_5

				LuaForUtil.ClearLinePrefixSymbol(arg_652_1.text_)

				local var_655_7 = 17 <= 0 and var_655_3 or var_655_3 * (utf8.len(var_655_5) / 17)

				if (17 <= 0 and var_655_3 or var_655_3 * (utf8.len(var_655_5) / 17)) > 0 and var_655_3 < var_655_7 then
					arg_652_1.talkMaxDuration = var_655_7

					if var_655_7 + var_655_2 > arg_652_1.duration_ then
						arg_652_1.duration_ = var_655_7 + var_655_2
					end
				end

				arg_652_1.text_.text = var_655_5
				arg_652_1.typewritter.percent = 0

				arg_652_1.typewritter:SetDirty()
				arg_652_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704157", "story_v_side_new_1109704.awb") ~= 0 then
					local var_655_8 = manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704157", "story_v_side_new_1109704.awb") / 1000

					if var_655_8 + var_655_2 > arg_652_1.duration_ then
						arg_652_1.duration_ = var_655_8 + var_655_2
					end

					if var_655_4.prefab_name ~= "" and arg_652_1.actors_[var_655_4.prefab_name] ~= nil then
						local var_655_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_652_1.actors_[var_655_4.prefab_name].transform, "story_v_side_new_1109704", "1109704157", "story_v_side_new_1109704.awb")

						arg_652_1:RecordAudio("1109704157", var_655_9)
						arg_652_1:RecordAudio("1109704157", var_655_9)
					else
						arg_652_1:AudioAction("play", "voice", "story_v_side_new_1109704", "1109704157", "story_v_side_new_1109704.awb")
					end

					arg_652_1:RecordHistoryTalkVoice("story_v_side_new_1109704", "1109704157", "story_v_side_new_1109704.awb")
				end

				arg_652_1:RecordContent(arg_652_1.text_.text)
			end

			local var_655_10 = math.max(var_655_3, arg_652_1.talkMaxDuration)

			if var_655_2 <= arg_652_1.time_ and arg_652_1.time_ < var_655_2 + var_655_10 then
				arg_652_1.typewritter.percent = (arg_652_1.time_ - var_655_2) / var_655_10

				arg_652_1.typewritter:SetDirty()
			end

			if arg_652_1.time_ >= var_655_2 + var_655_10 and arg_652_1.time_ < var_655_2 + var_655_10 + arg_655_0 then
				arg_652_1.typewritter.percent = 1

				arg_652_1.typewritter:SetDirty()
				arg_652_1:ShowNextGo(true)
			end
		end

		arg_652_1.nodeConfigList_ = {}

		arg_652_1:InitPlayNodeList()
	end,
	Play1109704158 = function(arg_656_0, arg_656_1)
		arg_656_1.time_ = 0
		arg_656_1.frameCnt_ = 0
		arg_656_1.state_ = "playing"
		arg_656_1.curTalkId_ = 1109704158
		arg_656_1.duration_ = 5

		SetActive(arg_656_1.tipsGo_, false)

		function arg_656_1.onSingleLineFinish_()
			arg_656_1.onSingleLineUpdate_ = nil
			arg_656_1.onSingleLineFinish_ = nil
			arg_656_1.state_ = "waiting"
		end

		function arg_656_1.playNext_(arg_658_0)
			if arg_658_0 == 1 then
				arg_656_0:Play1109704159(arg_656_1)
			end
		end

		function arg_656_1.onSingleLineUpdate_(arg_659_0)
			if 0 < arg_656_1.time_ and arg_656_1.time_ <= 0 + arg_659_0 and not isNil(arg_656_1.actors_["1097ui_story"]) and arg_656_1.var_.characterEffect1097ui_story == nil then
				arg_656_1.var_.characterEffect1097ui_story = arg_656_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_659_0 = 0.200000002980232

			if 0 <= arg_656_1.time_ and arg_656_1.time_ < 0 + var_659_0 and not isNil(arg_656_1.actors_["1097ui_story"]) then
				if arg_656_1.var_.characterEffect1097ui_story and not isNil(arg_656_1.actors_["1097ui_story"]) then
					arg_656_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_656_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_656_1.time_ - 0) / var_659_0)
				end
			end

			if arg_656_1.time_ >= 0 + var_659_0 and arg_656_1.time_ < 0 + var_659_0 + arg_659_0 and not isNil(arg_656_1.actors_["1097ui_story"]) and arg_656_1.var_.characterEffect1097ui_story then
				arg_656_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_656_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_659_1 = arg_656_1.actors_["1097ui_story"].transform

			if 0 < arg_656_1.time_ and arg_656_1.time_ <= 0 + arg_659_0 then
				arg_656_1.var_.moveOldPos1097ui_story = var_659_1.localPosition
			end

			local var_659_2 = 0.001

			if 0 <= arg_656_1.time_ and arg_656_1.time_ < 0 + var_659_2 then
				var_659_1.localPosition = Vector3.Lerp(arg_656_1.var_.moveOldPos1097ui_story, Vector3.New(0, 100, 0), (arg_656_1.time_ - 0) / var_659_2)
				var_659_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_659_1.position).x, (manager.ui.mainCamera.transform.position - var_659_1.position).y, (manager.ui.mainCamera.transform.position - var_659_1.position).z)
				var_659_1.localEulerAngles.z = 0
				var_659_1.localEulerAngles.x = 0
				var_659_1.localEulerAngles = var_659_1.localEulerAngles
			end

			if arg_656_1.time_ >= 0 + var_659_2 and arg_656_1.time_ < 0 + var_659_2 + arg_659_0 then
				var_659_1.localPosition = Vector3.New(0, 100, 0)
				var_659_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_659_1.position).x, (manager.ui.mainCamera.transform.position - var_659_1.position).y, (manager.ui.mainCamera.transform.position - var_659_1.position).z)
				var_659_1.localEulerAngles.z = 0
				var_659_1.localEulerAngles.x = 0
				var_659_1.localEulerAngles = var_659_1.localEulerAngles
			end

			local var_659_3 = manager.ui.mainCamera.transform

			if 0.4 < arg_656_1.time_ and arg_656_1.time_ <= 0.4 + arg_659_0 then
				arg_656_1.var_.shakeOldPos = var_659_3.localPosition
			end

			local var_659_4 = 0.6

			if 0.4 <= arg_656_1.time_ and arg_656_1.time_ < 0.4 + var_659_4 then
				local var_659_5, var_659_6 = math.modf((arg_656_1.time_ - 0.4) / 0.066)

				var_659_3.localPosition = Vector3.New(var_659_6 * 0.13, var_659_6 * 0.13, var_659_6 * 0.13) + arg_656_1.var_.shakeOldPos
			end

			if arg_656_1.time_ >= 0.4 + var_659_4 and arg_656_1.time_ < 0.4 + var_659_4 + arg_659_0 then
				var_659_3.localPosition = arg_656_1.var_.shakeOldPos
			end

			local var_659_7 = 0

			if 0 < arg_656_1.time_ and arg_656_1.time_ <= var_659_7 + arg_659_0 then
				arg_656_1.allBtn_.enabled = false
			end

			if arg_656_1.time_ >= var_659_7 + 1 and arg_656_1.time_ < var_659_7 + 1 + arg_659_0 then
				arg_656_1.allBtn_.enabled = true
			end

			local var_659_8 = 0
			local var_659_9 = 1.425

			if 0 < arg_656_1.time_ and arg_656_1.time_ <= var_659_8 + arg_659_0 then
				arg_656_1.talkMaxDuration = 0
				arg_656_1.dialogCg_.alpha = 1

				arg_656_1.dialog_:SetActive(true)
				SetActive(arg_656_1.leftNameGo_, true)

				arg_656_1.leftNameTxt_.text = arg_656_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_656_1.leftNameTxt_.transform)

				arg_656_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_656_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_656_1:RecordName(arg_656_1.leftNameTxt_.text)
				SetActive(arg_656_1.iconTrs_.gameObject, true)
				arg_656_1.iconController_:SetSelectedState("hero")

				arg_656_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_656_1.callingController_:SetSelectedState("normal")

				arg_656_1.keyicon_.color = Color.New(1, 1, 1)
				arg_656_1.icon_.color = Color.New(1, 1, 1)

				local var_659_10 = arg_656_1:FormatText(arg_656_1:GetWordFromCfg(1109704158).content)

				arg_656_1.text_.text = var_659_10

				LuaForUtil.ClearLinePrefixSymbol(arg_656_1.text_)

				local var_659_12 = 57 <= 0 and var_659_9 or var_659_9 * (utf8.len(var_659_10) / 57)

				if (57 <= 0 and var_659_9 or var_659_9 * (utf8.len(var_659_10) / 57)) > 0 and var_659_9 < var_659_12 then
					arg_656_1.talkMaxDuration = var_659_12

					if var_659_12 + var_659_8 > arg_656_1.duration_ then
						arg_656_1.duration_ = var_659_12 + var_659_8
					end
				end

				arg_656_1.text_.text = var_659_10
				arg_656_1.typewritter.percent = 0

				arg_656_1.typewritter:SetDirty()
				arg_656_1:ShowNextGo(false)
				arg_656_1:RecordContent(arg_656_1.text_.text)
			end

			local var_659_13 = math.max(var_659_9, arg_656_1.talkMaxDuration)

			if var_659_8 <= arg_656_1.time_ and arg_656_1.time_ < var_659_8 + var_659_13 then
				arg_656_1.typewritter.percent = (arg_656_1.time_ - var_659_8) / var_659_13

				arg_656_1.typewritter:SetDirty()
			end

			if arg_656_1.time_ >= var_659_8 + var_659_13 and arg_656_1.time_ < var_659_8 + var_659_13 + arg_659_0 then
				arg_656_1.typewritter.percent = 1

				arg_656_1.typewritter:SetDirty()
				arg_656_1:ShowNextGo(true)
			end
		end

		arg_656_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_656_1:InitPlayNodeList()
	end,
	Play1109704159 = function(arg_660_0, arg_660_1)
		arg_660_1.time_ = 0
		arg_660_1.frameCnt_ = 0
		arg_660_1.state_ = "playing"
		arg_660_1.curTalkId_ = 1109704159
		arg_660_1.duration_ = 5

		SetActive(arg_660_1.tipsGo_, false)

		function arg_660_1.onSingleLineFinish_()
			arg_660_1.onSingleLineUpdate_ = nil
			arg_660_1.onSingleLineFinish_ = nil
			arg_660_1.state_ = "waiting"
		end

		function arg_660_1.playNext_(arg_662_0)
			if arg_662_0 == 1 then
				arg_660_0:Play1109704160(arg_660_1)
			end
		end

		function arg_660_1.onSingleLineUpdate_(arg_663_0)
			local var_663_0 = 0.55

			if 0 < arg_660_1.time_ and arg_660_1.time_ <= 0 + arg_663_0 then
				arg_660_1.talkMaxDuration = 0
				arg_660_1.dialogCg_.alpha = 1

				arg_660_1.dialog_:SetActive(true)
				SetActive(arg_660_1.leftNameGo_, false)

				arg_660_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_660_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_660_1:RecordName(arg_660_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_660_1.iconTrs_.gameObject, false)
				arg_660_1.callingController_:SetSelectedState("normal")

				local var_663_1 = arg_660_1:FormatText(arg_660_1:GetWordFromCfg(1109704159).content)

				arg_660_1.text_.text = var_663_1

				LuaForUtil.ClearLinePrefixSymbol(arg_660_1.text_)

				local var_663_3 = 22 <= 0 and var_663_0 or var_663_0 * (utf8.len(var_663_1) / 22)

				if (22 <= 0 and var_663_0 or var_663_0 * (utf8.len(var_663_1) / 22)) > 0 and var_663_0 < var_663_3 then
					arg_660_1.talkMaxDuration = var_663_3

					if var_663_3 + 0 > arg_660_1.duration_ then
						arg_660_1.duration_ = var_663_3 + 0
					end
				end

				arg_660_1.text_.text = var_663_1
				arg_660_1.typewritter.percent = 0

				arg_660_1.typewritter:SetDirty()
				arg_660_1:ShowNextGo(false)
				arg_660_1:RecordContent(arg_660_1.text_.text)
			end

			local var_663_4 = math.max(var_663_0, arg_660_1.talkMaxDuration)

			if 0 <= arg_660_1.time_ and arg_660_1.time_ < 0 + var_663_4 then
				arg_660_1.typewritter.percent = (arg_660_1.time_ - 0) / var_663_4

				arg_660_1.typewritter:SetDirty()
			end

			if arg_660_1.time_ >= 0 + var_663_4 and arg_660_1.time_ < 0 + var_663_4 + arg_663_0 then
				arg_660_1.typewritter.percent = 1

				arg_660_1.typewritter:SetDirty()
				arg_660_1:ShowNextGo(true)
			end
		end

		arg_660_1.nodeConfigList_ = {}

		arg_660_1:InitPlayNodeList()
	end,
	Play1109704160 = function(arg_664_0, arg_664_1)
		arg_664_1.time_ = 0
		arg_664_1.frameCnt_ = 0
		arg_664_1.state_ = "playing"
		arg_664_1.curTalkId_ = 1109704160
		arg_664_1.duration_ = 6.73

		local var_664_0 = {
			zh = 6.733,
			ja = 6.5
		}
		local var_664_1 = manager.audio:GetLocalizationFlag()

		if var_664_0[var_664_1] ~= nil then
			arg_664_1.duration_ = var_664_0[var_664_1]
		end

		SetActive(arg_664_1.tipsGo_, false)

		function arg_664_1.onSingleLineFinish_()
			arg_664_1.onSingleLineUpdate_ = nil
			arg_664_1.onSingleLineFinish_ = nil
			arg_664_1.state_ = "waiting"
		end

		function arg_664_1.playNext_(arg_666_0)
			if arg_666_0 == 1 then
				arg_664_0:Play1109704161(arg_664_1)
			end
		end

		function arg_664_1.onSingleLineUpdate_(arg_667_0)
			if 0 < arg_664_1.time_ and arg_664_1.time_ <= 0 + arg_667_0 then
				arg_664_1.var_.moveOldPos1097ui_story = arg_664_1.actors_["1097ui_story"].transform.localPosition
			end

			local var_667_0 = 0.001

			if 0 <= arg_664_1.time_ and arg_664_1.time_ < 0 + var_667_0 then
				arg_664_1.actors_["1097ui_story"].transform.localPosition = Vector3.Lerp(arg_664_1.var_.moveOldPos1097ui_story, Vector3.New(0, -0.54, -6.3), (arg_664_1.time_ - 0) / var_667_0)
				arg_664_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_664_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_664_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_664_1.actors_["1097ui_story"].transform.position).z)
				arg_664_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_664_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_664_1.actors_["1097ui_story"].transform.localEulerAngles = arg_664_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			if arg_664_1.time_ >= 0 + var_667_0 and arg_664_1.time_ < 0 + var_667_0 + arg_667_0 then
				arg_664_1.actors_["1097ui_story"].transform.localPosition = Vector3.New(0, -0.54, -6.3)
				arg_664_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_664_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_664_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_664_1.actors_["1097ui_story"].transform.position).z)
				arg_664_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_664_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_664_1.actors_["1097ui_story"].transform.localEulerAngles = arg_664_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			local var_667_1 = arg_664_1.actors_["1097ui_story"]

			if 0 < arg_664_1.time_ and arg_664_1.time_ <= 0 + arg_667_0 and not isNil(var_667_1) and arg_664_1.var_.characterEffect1097ui_story == nil then
				arg_664_1.var_.characterEffect1097ui_story = var_667_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_667_2 = 0.200000002980232

			if 0 <= arg_664_1.time_ and arg_664_1.time_ < 0 + var_667_2 and not isNil(var_667_1) then
				if arg_664_1.var_.characterEffect1097ui_story and not isNil(var_667_1) then
					arg_664_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_664_1.time_ >= 0 + var_667_2 and arg_664_1.time_ < 0 + var_667_2 + arg_667_0 and not isNil(var_667_1) and arg_664_1.var_.characterEffect1097ui_story then
				arg_664_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_664_1.time_ and arg_664_1.time_ <= 0 + arg_667_0 then
				arg_664_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action7_1")
			end

			if 0 < arg_664_1.time_ and arg_664_1.time_ <= 0 + arg_667_0 then
				arg_664_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_667_4 = 0
			local var_667_5 = 0.75

			if 0 < arg_664_1.time_ and arg_664_1.time_ <= var_667_4 + arg_667_0 then
				arg_664_1.talkMaxDuration = 0
				arg_664_1.dialogCg_.alpha = 1

				arg_664_1.dialog_:SetActive(true)
				SetActive(arg_664_1.leftNameGo_, true)

				arg_664_1.leftNameTxt_.text = arg_664_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_664_1.leftNameTxt_.transform)

				arg_664_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_664_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_664_1:RecordName(arg_664_1.leftNameTxt_.text)
				SetActive(arg_664_1.iconTrs_.gameObject, false)
				arg_664_1.callingController_:SetSelectedState("normal")

				local var_667_6 = arg_664_1:GetWordFromCfg(1109704160)
				local var_667_7 = arg_664_1:FormatText(var_667_6.content)

				arg_664_1.text_.text = var_667_7

				LuaForUtil.ClearLinePrefixSymbol(arg_664_1.text_)

				local var_667_9 = 30 <= 0 and var_667_5 or var_667_5 * (utf8.len(var_667_7) / 30)

				if (30 <= 0 and var_667_5 or var_667_5 * (utf8.len(var_667_7) / 30)) > 0 and var_667_5 < var_667_9 then
					arg_664_1.talkMaxDuration = var_667_9

					if var_667_9 + var_667_4 > arg_664_1.duration_ then
						arg_664_1.duration_ = var_667_9 + var_667_4
					end
				end

				arg_664_1.text_.text = var_667_7
				arg_664_1.typewritter.percent = 0

				arg_664_1.typewritter:SetDirty()
				arg_664_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704160", "story_v_side_new_1109704.awb") ~= 0 then
					local var_667_10 = manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704160", "story_v_side_new_1109704.awb") / 1000

					if var_667_10 + var_667_4 > arg_664_1.duration_ then
						arg_664_1.duration_ = var_667_10 + var_667_4
					end

					if var_667_6.prefab_name ~= "" and arg_664_1.actors_[var_667_6.prefab_name] ~= nil then
						local var_667_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_664_1.actors_[var_667_6.prefab_name].transform, "story_v_side_new_1109704", "1109704160", "story_v_side_new_1109704.awb")

						arg_664_1:RecordAudio("1109704160", var_667_11)
						arg_664_1:RecordAudio("1109704160", var_667_11)
					else
						arg_664_1:AudioAction("play", "voice", "story_v_side_new_1109704", "1109704160", "story_v_side_new_1109704.awb")
					end

					arg_664_1:RecordHistoryTalkVoice("story_v_side_new_1109704", "1109704160", "story_v_side_new_1109704.awb")
				end

				arg_664_1:RecordContent(arg_664_1.text_.text)
			end

			local var_667_12 = math.max(var_667_5, arg_664_1.talkMaxDuration)

			if var_667_4 <= arg_664_1.time_ and arg_664_1.time_ < var_667_4 + var_667_12 then
				arg_664_1.typewritter.percent = (arg_664_1.time_ - var_667_4) / var_667_12

				arg_664_1.typewritter:SetDirty()
			end

			if arg_664_1.time_ >= var_667_4 + var_667_12 and arg_664_1.time_ < var_667_4 + var_667_12 + arg_667_0 then
				arg_664_1.typewritter.percent = 1

				arg_664_1.typewritter:SetDirty()
				arg_664_1:ShowNextGo(true)
			end
		end

		arg_664_1.nodeConfigList_ = {
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

		arg_664_1:InitPlayNodeList()
	end,
	Play1109704161 = function(arg_668_0, arg_668_1)
		arg_668_1.time_ = 0
		arg_668_1.frameCnt_ = 0
		arg_668_1.state_ = "playing"
		arg_668_1.curTalkId_ = 1109704161
		arg_668_1.duration_ = 5

		SetActive(arg_668_1.tipsGo_, false)

		function arg_668_1.onSingleLineFinish_()
			arg_668_1.onSingleLineUpdate_ = nil
			arg_668_1.onSingleLineFinish_ = nil
			arg_668_1.state_ = "waiting"
		end

		function arg_668_1.playNext_(arg_670_0)
			if arg_670_0 == 1 then
				arg_668_0:Play1109704162(arg_668_1)
			end
		end

		function arg_668_1.onSingleLineUpdate_(arg_671_0)
			if 0 < arg_668_1.time_ and arg_668_1.time_ <= 0 + arg_671_0 and not isNil(arg_668_1.actors_["1097ui_story"]) and arg_668_1.var_.characterEffect1097ui_story == nil then
				arg_668_1.var_.characterEffect1097ui_story = arg_668_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_671_0 = 0.200000002980232

			if 0 <= arg_668_1.time_ and arg_668_1.time_ < 0 + var_671_0 and not isNil(arg_668_1.actors_["1097ui_story"]) then
				if arg_668_1.var_.characterEffect1097ui_story and not isNil(arg_668_1.actors_["1097ui_story"]) then
					arg_668_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_668_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_668_1.time_ - 0) / var_671_0)
				end
			end

			if arg_668_1.time_ >= 0 + var_671_0 and arg_668_1.time_ < 0 + var_671_0 + arg_671_0 and not isNil(arg_668_1.actors_["1097ui_story"]) and arg_668_1.var_.characterEffect1097ui_story then
				arg_668_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_668_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_671_1 = 0
			local var_671_2 = 0.45

			if 0 < arg_668_1.time_ and arg_668_1.time_ <= var_671_1 + arg_671_0 then
				arg_668_1.talkMaxDuration = 0
				arg_668_1.dialogCg_.alpha = 1

				arg_668_1.dialog_:SetActive(true)
				SetActive(arg_668_1.leftNameGo_, true)

				arg_668_1.leftNameTxt_.text = arg_668_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_668_1.leftNameTxt_.transform)

				arg_668_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_668_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_668_1:RecordName(arg_668_1.leftNameTxt_.text)
				SetActive(arg_668_1.iconTrs_.gameObject, true)
				arg_668_1.iconController_:SetSelectedState("hero")

				arg_668_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_668_1.callingController_:SetSelectedState("normal")

				arg_668_1.keyicon_.color = Color.New(1, 1, 1)
				arg_668_1.icon_.color = Color.New(1, 1, 1)

				local var_671_3 = arg_668_1:FormatText(arg_668_1:GetWordFromCfg(1109704161).content)

				arg_668_1.text_.text = var_671_3

				LuaForUtil.ClearLinePrefixSymbol(arg_668_1.text_)

				local var_671_5 = 18 <= 0 and var_671_2 or var_671_2 * (utf8.len(var_671_3) / 18)

				if (18 <= 0 and var_671_2 or var_671_2 * (utf8.len(var_671_3) / 18)) > 0 and var_671_2 < var_671_5 then
					arg_668_1.talkMaxDuration = var_671_5

					if var_671_5 + var_671_1 > arg_668_1.duration_ then
						arg_668_1.duration_ = var_671_5 + var_671_1
					end
				end

				arg_668_1.text_.text = var_671_3
				arg_668_1.typewritter.percent = 0

				arg_668_1.typewritter:SetDirty()
				arg_668_1:ShowNextGo(false)
				arg_668_1:RecordContent(arg_668_1.text_.text)
			end

			local var_671_6 = math.max(var_671_2, arg_668_1.talkMaxDuration)

			if var_671_1 <= arg_668_1.time_ and arg_668_1.time_ < var_671_1 + var_671_6 then
				arg_668_1.typewritter.percent = (arg_668_1.time_ - var_671_1) / var_671_6

				arg_668_1.typewritter:SetDirty()
			end

			if arg_668_1.time_ >= var_671_1 + var_671_6 and arg_668_1.time_ < var_671_1 + var_671_6 + arg_671_0 then
				arg_668_1.typewritter.percent = 1

				arg_668_1.typewritter:SetDirty()
				arg_668_1:ShowNextGo(true)
			end
		end

		arg_668_1.nodeConfigList_ = {}

		arg_668_1:InitPlayNodeList()
	end,
	Play1109704162 = function(arg_672_0, arg_672_1)
		arg_672_1.time_ = 0
		arg_672_1.frameCnt_ = 0
		arg_672_1.state_ = "playing"
		arg_672_1.curTalkId_ = 1109704162
		arg_672_1.duration_ = 5

		SetActive(arg_672_1.tipsGo_, false)

		function arg_672_1.onSingleLineFinish_()
			arg_672_1.onSingleLineUpdate_ = nil
			arg_672_1.onSingleLineFinish_ = nil
			arg_672_1.state_ = "waiting"
		end

		function arg_672_1.playNext_(arg_674_0)
			if arg_674_0 == 1 then
				arg_672_0:Play1109704163(arg_672_1)
			end
		end

		function arg_672_1.onSingleLineUpdate_(arg_675_0)
			local var_675_0 = 1.075

			if 0 < arg_672_1.time_ and arg_672_1.time_ <= 0 + arg_675_0 then
				arg_672_1.talkMaxDuration = 0
				arg_672_1.dialogCg_.alpha = 1

				arg_672_1.dialog_:SetActive(true)
				SetActive(arg_672_1.leftNameGo_, false)

				arg_672_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_672_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_672_1:RecordName(arg_672_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_672_1.iconTrs_.gameObject, false)
				arg_672_1.callingController_:SetSelectedState("normal")

				local var_675_1 = arg_672_1:FormatText(arg_672_1:GetWordFromCfg(1109704162).content)

				arg_672_1.text_.text = var_675_1

				LuaForUtil.ClearLinePrefixSymbol(arg_672_1.text_)

				local var_675_3 = 43 <= 0 and var_675_0 or var_675_0 * (utf8.len(var_675_1) / 43)

				if (43 <= 0 and var_675_0 or var_675_0 * (utf8.len(var_675_1) / 43)) > 0 and var_675_0 < var_675_3 then
					arg_672_1.talkMaxDuration = var_675_3

					if var_675_3 + 0 > arg_672_1.duration_ then
						arg_672_1.duration_ = var_675_3 + 0
					end
				end

				arg_672_1.text_.text = var_675_1
				arg_672_1.typewritter.percent = 0

				arg_672_1.typewritter:SetDirty()
				arg_672_1:ShowNextGo(false)
				arg_672_1:RecordContent(arg_672_1.text_.text)
			end

			local var_675_4 = math.max(var_675_0, arg_672_1.talkMaxDuration)

			if 0 <= arg_672_1.time_ and arg_672_1.time_ < 0 + var_675_4 then
				arg_672_1.typewritter.percent = (arg_672_1.time_ - 0) / var_675_4

				arg_672_1.typewritter:SetDirty()
			end

			if arg_672_1.time_ >= 0 + var_675_4 and arg_672_1.time_ < 0 + var_675_4 + arg_675_0 then
				arg_672_1.typewritter.percent = 1

				arg_672_1.typewritter:SetDirty()
				arg_672_1:ShowNextGo(true)
			end
		end

		arg_672_1.nodeConfigList_ = {}

		arg_672_1:InitPlayNodeList()
	end,
	Play1109704163 = function(arg_676_0, arg_676_1)
		arg_676_1.time_ = 0
		arg_676_1.frameCnt_ = 0
		arg_676_1.state_ = "playing"
		arg_676_1.curTalkId_ = 1109704163
		arg_676_1.duration_ = 5

		SetActive(arg_676_1.tipsGo_, false)

		function arg_676_1.onSingleLineFinish_()
			arg_676_1.onSingleLineUpdate_ = nil
			arg_676_1.onSingleLineFinish_ = nil
			arg_676_1.state_ = "waiting"
		end

		function arg_676_1.playNext_(arg_678_0)
			if arg_678_0 == 1 then
				arg_676_0:Play1109704164(arg_676_1)
			end
		end

		function arg_676_1.onSingleLineUpdate_(arg_679_0)
			local var_679_0 = 0.5

			if 0 < arg_676_1.time_ and arg_676_1.time_ <= 0 + arg_679_0 then
				arg_676_1.talkMaxDuration = 0
				arg_676_1.dialogCg_.alpha = 1

				arg_676_1.dialog_:SetActive(true)
				SetActive(arg_676_1.leftNameGo_, true)

				arg_676_1.leftNameTxt_.text = arg_676_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_676_1.leftNameTxt_.transform)

				arg_676_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_676_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_676_1:RecordName(arg_676_1.leftNameTxt_.text)
				SetActive(arg_676_1.iconTrs_.gameObject, true)
				arg_676_1.iconController_:SetSelectedState("hero")

				arg_676_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_676_1.callingController_:SetSelectedState("normal")

				arg_676_1.keyicon_.color = Color.New(1, 1, 1)
				arg_676_1.icon_.color = Color.New(1, 1, 1)

				local var_679_1 = arg_676_1:FormatText(arg_676_1:GetWordFromCfg(1109704163).content)

				arg_676_1.text_.text = var_679_1

				LuaForUtil.ClearLinePrefixSymbol(arg_676_1.text_)

				local var_679_3 = 20 <= 0 and var_679_0 or var_679_0 * (utf8.len(var_679_1) / 20)

				if (20 <= 0 and var_679_0 or var_679_0 * (utf8.len(var_679_1) / 20)) > 0 and var_679_0 < var_679_3 then
					arg_676_1.talkMaxDuration = var_679_3

					if var_679_3 + 0 > arg_676_1.duration_ then
						arg_676_1.duration_ = var_679_3 + 0
					end
				end

				arg_676_1.text_.text = var_679_1
				arg_676_1.typewritter.percent = 0

				arg_676_1.typewritter:SetDirty()
				arg_676_1:ShowNextGo(false)
				arg_676_1:RecordContent(arg_676_1.text_.text)
			end

			local var_679_4 = math.max(var_679_0, arg_676_1.talkMaxDuration)

			if 0 <= arg_676_1.time_ and arg_676_1.time_ < 0 + var_679_4 then
				arg_676_1.typewritter.percent = (arg_676_1.time_ - 0) / var_679_4

				arg_676_1.typewritter:SetDirty()
			end

			if arg_676_1.time_ >= 0 + var_679_4 and arg_676_1.time_ < 0 + var_679_4 + arg_679_0 then
				arg_676_1.typewritter.percent = 1

				arg_676_1.typewritter:SetDirty()
				arg_676_1:ShowNextGo(true)
			end
		end

		arg_676_1.nodeConfigList_ = {}

		arg_676_1:InitPlayNodeList()
	end,
	Play1109704164 = function(arg_680_0, arg_680_1)
		arg_680_1.time_ = 0
		arg_680_1.frameCnt_ = 0
		arg_680_1.state_ = "playing"
		arg_680_1.curTalkId_ = 1109704164
		arg_680_1.duration_ = 5.1

		local var_680_0 = {
			zh = 1.999999999999,
			ja = 5.1
		}
		local var_680_1 = manager.audio:GetLocalizationFlag()

		if var_680_0[var_680_1] ~= nil then
			arg_680_1.duration_ = var_680_0[var_680_1]
		end

		SetActive(arg_680_1.tipsGo_, false)

		function arg_680_1.onSingleLineFinish_()
			arg_680_1.onSingleLineUpdate_ = nil
			arg_680_1.onSingleLineFinish_ = nil
			arg_680_1.state_ = "waiting"
			arg_680_1.auto_ = false
		end

		function arg_680_1.playNext_(arg_682_0)
			arg_680_1.onStoryFinished_()
		end

		function arg_680_1.onSingleLineUpdate_(arg_683_0)
			if 0 < arg_680_1.time_ and arg_680_1.time_ <= 0 + arg_683_0 then
				arg_680_1.var_.moveOldPos1097ui_story = arg_680_1.actors_["1097ui_story"].transform.localPosition
			end

			local var_683_0 = 0.001

			if 0 <= arg_680_1.time_ and arg_680_1.time_ < 0 + var_683_0 then
				arg_680_1.actors_["1097ui_story"].transform.localPosition = Vector3.Lerp(arg_680_1.var_.moveOldPos1097ui_story, Vector3.New(0, -0.54, -6.3), (arg_680_1.time_ - 0) / var_683_0)
				arg_680_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_680_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_680_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_680_1.actors_["1097ui_story"].transform.position).z)
				arg_680_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_680_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_680_1.actors_["1097ui_story"].transform.localEulerAngles = arg_680_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			if arg_680_1.time_ >= 0 + var_683_0 and arg_680_1.time_ < 0 + var_683_0 + arg_683_0 then
				arg_680_1.actors_["1097ui_story"].transform.localPosition = Vector3.New(0, -0.54, -6.3)
				arg_680_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_680_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_680_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_680_1.actors_["1097ui_story"].transform.position).z)
				arg_680_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_680_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_680_1.actors_["1097ui_story"].transform.localEulerAngles = arg_680_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			local var_683_1 = arg_680_1.actors_["1097ui_story"]

			if 0 < arg_680_1.time_ and arg_680_1.time_ <= 0 + arg_683_0 and not isNil(var_683_1) and arg_680_1.var_.characterEffect1097ui_story == nil then
				arg_680_1.var_.characterEffect1097ui_story = var_683_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_683_2 = 0.200000002980232

			if 0 <= arg_680_1.time_ and arg_680_1.time_ < 0 + var_683_2 and not isNil(var_683_1) then
				if arg_680_1.var_.characterEffect1097ui_story and not isNil(var_683_1) then
					arg_680_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_680_1.time_ >= 0 + var_683_2 and arg_680_1.time_ < 0 + var_683_2 + arg_683_0 and not isNil(var_683_1) and arg_680_1.var_.characterEffect1097ui_story then
				arg_680_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_680_1.time_ and arg_680_1.time_ <= 0 + arg_683_0 then
				arg_680_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action7_2")
			end

			if 0 < arg_680_1.time_ and arg_680_1.time_ <= 0 + arg_683_0 then
				arg_680_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva")
			end

			local var_683_4 = 0
			local var_683_5 = 0.1

			if 0 < arg_680_1.time_ and arg_680_1.time_ <= var_683_4 + arg_683_0 then
				arg_680_1.talkMaxDuration = 0
				arg_680_1.dialogCg_.alpha = 1

				arg_680_1.dialog_:SetActive(true)
				SetActive(arg_680_1.leftNameGo_, true)

				arg_680_1.leftNameTxt_.text = arg_680_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_680_1.leftNameTxt_.transform)

				arg_680_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_680_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_680_1:RecordName(arg_680_1.leftNameTxt_.text)
				SetActive(arg_680_1.iconTrs_.gameObject, false)
				arg_680_1.callingController_:SetSelectedState("normal")

				local var_683_6 = arg_680_1:GetWordFromCfg(1109704164)
				local var_683_7 = arg_680_1:FormatText(var_683_6.content)

				arg_680_1.text_.text = var_683_7

				LuaForUtil.ClearLinePrefixSymbol(arg_680_1.text_)

				local var_683_9 = 4 <= 0 and var_683_5 or var_683_5 * (utf8.len(var_683_7) / 4)

				if (4 <= 0 and var_683_5 or var_683_5 * (utf8.len(var_683_7) / 4)) > 0 and var_683_5 < var_683_9 then
					arg_680_1.talkMaxDuration = var_683_9

					if var_683_9 + var_683_4 > arg_680_1.duration_ then
						arg_680_1.duration_ = var_683_9 + var_683_4
					end
				end

				arg_680_1.text_.text = var_683_7
				arg_680_1.typewritter.percent = 0

				arg_680_1.typewritter:SetDirty()
				arg_680_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704164", "story_v_side_new_1109704.awb") ~= 0 then
					local var_683_10 = manager.audio:GetVoiceLength("story_v_side_new_1109704", "1109704164", "story_v_side_new_1109704.awb") / 1000

					if var_683_10 + var_683_4 > arg_680_1.duration_ then
						arg_680_1.duration_ = var_683_10 + var_683_4
					end

					if var_683_6.prefab_name ~= "" and arg_680_1.actors_[var_683_6.prefab_name] ~= nil then
						local var_683_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_680_1.actors_[var_683_6.prefab_name].transform, "story_v_side_new_1109704", "1109704164", "story_v_side_new_1109704.awb")

						arg_680_1:RecordAudio("1109704164", var_683_11)
						arg_680_1:RecordAudio("1109704164", var_683_11)
					else
						arg_680_1:AudioAction("play", "voice", "story_v_side_new_1109704", "1109704164", "story_v_side_new_1109704.awb")
					end

					arg_680_1:RecordHistoryTalkVoice("story_v_side_new_1109704", "1109704164", "story_v_side_new_1109704.awb")
				end

				arg_680_1:RecordContent(arg_680_1.text_.text)
			end

			local var_683_12 = math.max(var_683_5, arg_680_1.talkMaxDuration)

			if var_683_4 <= arg_680_1.time_ and arg_680_1.time_ < var_683_4 + var_683_12 then
				arg_680_1.typewritter.percent = (arg_680_1.time_ - var_683_4) / var_683_12

				arg_680_1.typewritter:SetDirty()
			end

			if arg_680_1.time_ >= var_683_4 + var_683_12 and arg_680_1.time_ < var_683_4 + var_683_12 + arg_683_0 then
				arg_680_1.typewritter.percent = 1

				arg_680_1.typewritter:SetDirty()
				arg_680_1:ShowNextGo(true)
			end
		end

		arg_680_1.nodeConfigList_ = {
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

		arg_680_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST01",
		"TextureConfig/Background/STwhite",
		"TextureConfig/Background/ST60",
		"TextureConfig/Background/R9701",
		"TextureConfig/Background/F01"
	},
	voices = {
		"story_v_side_new_1109704.awb"
	}
}
